@echo off
chcp 65001 >nul

:: Greetings in Indian + Nepali languages
echo हिंदी : नमस्ते दोस्त
echo मराठी : नमस्कार मित्रा
echo தமிழ் : வணக்கம் நண்பா
echo ગુજરાતી : હેલો મિત્ર
echo ਪੰਜਾਬੀ : ਸਤ ਸ੍ਰੀ ਅਕਾਲ ਦੋਸਤ
echo বাংলা : হ্যালো বন্ধু
echo नेपाली : नमस्ते साथी

:: Show current date and time
echo Date: %date%
echo Time: %time%

:: Show system info
echo User: %username%
echo Computer: %computername%

:: Voice greeting
powershell -c "Add-Type –AssemblyName System.Speech; (New-Object System.Speech.Synthesis.SpeechSynthesizer).Speak('Hello friend, your Local AI is starting now!')"

:: Log startup
echo AI started on %date% at %time% >> ai_chat_log.txt

:: Paths to your models
.\llamafile-0.10.5.exe --server --model qwen3-4b-thinking-2507.Q4_K_M.gguf 
.\llamafile-0.10.5.exe --server --model sarvam-30b-Q4_K_M.gguf-00005-of-00006.gguf

:: Get live Indian job listings (example using NewsAPI for jobs)
for /f "delims=" %%i in ('powershell -Command "(Invoke-WebRequest 'https://newsapi.org/v2/everything?q=jobs%20India&from=2026-08-01&apiKey=YOUR_API_KEY').Content"') do set JOBS=%%i

--prompt "You are a hybrid AI assistant. 
Today is %date%, time %time%. 
Latest jobs: %JOBS%. 
Use this info to answer with up‑to‑date context."


:: Launch Hybrid Mode (merge both models)
echo Starting Hybrid AI (Qwen + Sarvam)...
start /min cmd /c "D:\LOCAL AI - Copy\local-ai.exe --merge --model %MODEL_PATH1% --model %MODEL_PATH2% --threads 8 --ctx-size 2048 --interactive --prompt ^
'You are a hybrid AI assistant like Copilot. 
Use Qwen for fast, structured answers with examples. 
Use Sarvam for friendly, debate-style conversation. 
Always reply in Indian + Nepali languages when appropriate. 
Be clear, step-by-step, and respectful while talking like a friend.'"

echo Your Hybrid AI friend is ready to chat in all Indian and Nepali languages!
pause
