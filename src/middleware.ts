import { type NextRequest, NextResponse } from "next/server";
import { getSessionCookie } from "better-auth/cookies";

export async function middleware(request: NextRequest) {
    const sessionCookie = getSessionCookie(request);

    const { pathname } = request.nextUrl;

    // If on `/` and logged in, redirect to `/dashboard`
    if (pathname === "/" && sessionCookie) {
        return NextResponse.redirect(new URL("/dashboard", request.url));
    }

    // If on `/dashboard` and NOT logged in, redirect to `/`
    if (pathname.startsWith("/dashboard") && !sessionCookie) {
        return NextResponse.redirect(new URL("/", request.url));
    }

    return NextResponse.next();
}

export const config = {
    matcher: ["/", "/dashboard/:path*"], // Apply to `/` and all `/dashboard` routes
};
