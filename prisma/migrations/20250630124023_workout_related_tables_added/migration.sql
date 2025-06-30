/*
  Warnings:

  - You are about to drop the column `emailVerified` on the `user` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "user" DROP COLUMN "emailVerified",
ADD COLUMN     "email_verified" BOOLEAN NOT NULL DEFAULT false;

-- CreateTable
CREATE TABLE "gym_workout" (
    "id" BIGSERIAL NOT NULL,
    "userId" TEXT NOT NULL,
    "workout_name" TEXT NOT NULL,
    "duration_minutes" INTEGER NOT NULL,
    "calories_burned" INTEGER,
    "workout_date" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "gym_workout_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "weekly_streak" (
    "id" BIGSERIAL NOT NULL,
    "userId" TEXT NOT NULL,
    "week_start_date" TIMESTAMP(3) NOT NULL,
    "streak_count" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "weekly_streak_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "exercise" (
    "id" BIGSERIAL NOT NULL,
    "workoutId" BIGINT NOT NULL,
    "exercise_name" TEXT NOT NULL,
    "sets" INTEGER NOT NULL,
    "reps" INTEGER NOT NULL,
    "weight" DOUBLE PRECISION,
    "weight_unit" TEXT NOT NULL DEFAULT 'kg',
    "muscle_group" TEXT NOT NULL,

    CONSTRAINT "exercise_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "gym_workout" ADD CONSTRAINT "gym_workout_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "weekly_streak" ADD CONSTRAINT "weekly_streak_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "exercise" ADD CONSTRAINT "exercise_workoutId_fkey" FOREIGN KEY ("workoutId") REFERENCES "gym_workout"("id") ON DELETE CASCADE ON UPDATE CASCADE;
