-- ================================================================
-- TABLA DE RESULTADOS VOCACIONALES - COLECTIVO VALLE DEL HUASCARÁN
-- ================================================================
-- Ejecuta este script en el "SQL Editor" de tu proyecto de Supabase:

CREATE TABLE IF NOT EXISTS public.student_tests (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    student_name TEXT NOT NULL,
    school_or_location TEXT DEFAULT 'Valle del Huascarán',
    category TEXT NOT NULL,
    profile_title TEXT NOT NULL,
    recommended_university TEXT NOT NULL,
    recommended_technical TEXT NOT NULL,
    university_avg_young TEXT,
    technical_avg_young TEXT,
    answers JSONB DEFAULT '{}'::jsonb
);

-- Habilitar Row Level Security (RLS)
ALTER TABLE public.student_tests ENABLE ROW LEVEL SECURITY;

-- Política 1: Permitir que cualquier usuario/estudiante inserte su test
CREATE POLICY "Permitir inserción pública de tests de estudiantes"
ON public.student_tests
FOR INSERT
TO public
WITH CHECK (true);

-- Política 2: Permitir lectura pública para consultar resultados previos
CREATE POLICY "Permitir lectura de tests vocacionales"
ON public.student_tests
FOR SELECT
TO public
USING (true);

-- Índice para búsquedas rápidas por nombre de alumno y fecha
CREATE INDEX IF NOT EXISTS idx_student_tests_name ON public.student_tests (student_name);
CREATE INDEX IF NOT EXISTS idx_student_tests_created_at ON public.student_tests (created_at DESC);
