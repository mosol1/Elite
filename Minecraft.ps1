[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
$webClient = New-Object System.Net.WebClient
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
$ProgramFilesPath = [System.Environment]::GetFolderPath('ProgramFiles')
$86Path = [System.Environment]::GetFolderPath('ProgramFilesX86')
$SED = "C:\Program Files (x86)\ElitePremiumUtility\resources\sed.dat"
$PathMinecraft = "$env:APPDATA\.Minecraft"
if (!(Test-Path -Path "$86Path\Minecraft Java\GraalVM8") -and !(Test-Path -Path "$86Path\Minecraft Java\GraalVM17") -and !(Test-Path -Path "$86Path\Minecraft Java\GraalVM21") -and (Test-Path -Path "$pathminecraft\launcher_profiles.json")) {
	if (!(Test-Path -Path "$86Path\Minecraft Java")) {
		New-Item -ItemType Directory -Path "$86Path\Minecraft Java" | Out-Null -ErrorAction SilentlyContinue
	}
	$GraalVMPath = "$86Path\Minecraft Java"
	try {
 		$webClient.DownloadFile("https://static.hone.gg/GraalVM8.zip", "$GraalVMPath\GraalVM8.zip") > $null
		$webClient.DownloadFile("https://static.hone.gg/GraalVM17.zip", "$GraalVMPath\GraalVM17.zip") > $null
  		$webClient.DownloadFile("https://static.hone.gg/GraalVM21.zip", "$GraalVMPath\GraalVM21.zip") > $null
	} catch {
	}
	Expand-Archive -Path "$GraalVMPath\GraalVM8.zip" -DestinationPath $GraalVMPath -Force -ErrorAction SilentlyContinue
	Expand-Archive -Path "$GraalVMPath\GraalVM17.zip" -DestinationPath $GraalVMPath -Force -ErrorAction SilentlyContinue
 	Expand-Archive -Path "$GraalVMPath\GraalVM21.zip" -DestinationPath $GraalVMPath -Force -ErrorAction SilentlyContinue
	Remove-Item -Path "$GraalVMPath\GraalVM17.zip" -Force -ErrorAction SilentlyContinue
	Remove-Item -Path "$GraalVMPath\GraalVM8.zip" -Force -ErrorAction SilentlyContinue
 	Remove-Item -Path "$GraalVMPath\GraalVM21.zip" -Force -ErrorAction SilentlyContinue
}
if ((Test-Path -Path "$86Path\Minecraft Java\GraalVM8") -and (Test-Path -Path "$86Path\Minecraft Java\GraalVM17") -and (Test-Path -Path "$86Path\Minecraft Java\GraalVM21") -and (Test-Path -Path "$pathminecraft\launcher_profiles.json")) {
	Copy-Item -Path "$pathminecraft\launcher_profiles.json" -Destination "$pathminecraft\launcher_profiles.json.bak" -Force -ErrorAction SilentlyContinue
	$jsonPath = "$PathMinecraft\launcher_profiles.json"
	try { 
		$jsonContent = Get-Content -Path $jsonPath | ConvertFrom-Json 
		foreach ($profile in $jsonContent.profiles.PSObject.Properties) {
			if ($profile.Value.lastVersionId -match 'Latest|1\.21|1\.20\.6|1\.20\.5|1\.20\.4|1\.20\.3|1\.20\.2|1\.20\.1|1\.20|1\.19\.4|1\.19\.3|1\.19\.2|1\.19\.1|1\.18\.2|1\.18\.1|1\.18|1\.17\.1|1\.17|1\.16|1\.15|1\.14|1\.13|1\.12|1\.11|1\.10|1\.9\.|1\.9|1\.8\.|1\.8|1\.7\.|1\.7|1\.6\.|1\.6'){
				if ($profile.Value.javaDir -eq $null) {
					$profile.Value | Add-Member -Type NoteProperty -Name "javaDir" -Value ""
				}
				if ($profile.Value.javaArgs -eq $null) {
					$profile.Value | Add-Member -Type NoteProperty -Name "javaArgs" -Value ""
				}
			}
			if ($profile.Value.lastVersionId -match 'Latest|1\.21|1\.20\.6|1\.20\.5') {
				$profile.Value.javaDir = "$86Path\Minecraft Java\GraalVM21\bin\javaw.exe"
				$profile.Value.javaArgs = "-XX:+UnlockExperimentalVMOptions -XX:+UnlockDiagnosticVMOptions -XX:+UseDynamicNumberOfGCThreads -XX:+ParallelRefProcEnabled -XX:+UseFastUnorderedTimeStamps -XX:+UseCriticalJavaThreadPriority -XX:+UseFPUForSpilling -XX:+EnableJVMCI -XX:+UseJVMCICompiler -XX:+AlwaysActAsServerClassMachine -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:+UseNUMA -XX:AllocatePrefetchStyle=3 -XX:NmethodSweepActivity=1 -XX:ReservedCodeCacheSize=400M -XX:-DontCompileHugeMethods -XX:ThreadPriorityPolicy=1 -XX:MaxNodeLimit=240000 -XX:NodeLimitFudgeFactor=8000 -XX:+EagerJVMCI -Dgraal.TuneInlinerExploration=1 -Dgraal.UsePriorityInlining=true -Dgraal.Vectorization=true -Dgraal.OptDuplication=true -Dgraal.DetectInvertedLoopsAsCounted=true -Dgraal.LoopInversion=true -Dgraal.VectorizeHashes=true -Dgraal.EnterprisePartialUnroll=true -Dgraal.VectorizeSIMD=true -Dgraal.StripMineNonCountedLoops=true -Dgraal.SpeculativeGuardMovement=true -Dgraal.InfeasiblePathCorrelation=true -Dgraal.CompilerConfiguration=enterprise -XX:+UseG1GC -XX:MaxGCPauseMillis=37 -XX:+PerfDisableSharedMem -XX:G1HeapRegionSize=16M -XX:G1NewSizePercent=23 -XX:G1ReservePercent=20 -XX:SurvivorRatio=32 -XX:G1MixedGCCountTarget=3 -XX:G1HeapWastePercent=20 -XX:InitiatingHeapOccupancyPercent=10 -XX:G1RSetUpdatingPauseTimePercent=0 -XX:MaxTenuringThreshold=1 -XX:G1SATBBufferEnqueueingThresholdPercent=30 -XX:G1ConcMarkStepDurationMillis=5.0 -XX:GCTimeRatio=99 -XX:NonNMethodCodeHeapSize=12M -XX:ProfiledCodeHeapSize=194M -XX:NonProfiledCodeHeapSize=194M -XX:+UseVectorCmov"
			} elseif ($profile.Value.lastVersionId -match '1\.20\.4|1\.20\.3|1\.20\.2|1\.20\.1|1\.20|1\.19\.4|1\.19\.3|1\.19\.2|1\.19\.1|1\.18\.2|1\.18\.1|1\.18|1\.17\.1|1\.17') {
				$profile.Value.javaDir = "$86Path\Minecraft Java\GraalVM17\bin\javaw.exe"
				$profile.Value.javaArgs = "-XX:+UnlockExperimentalVMOptions -XX:+UnlockDiagnosticVMOptions -XX:+UseDynamicNumberOfGCThreads -XX:+ParallelRefProcEnabled -XX:+UseFastUnorderedTimeStamps -XX:+UseCriticalJavaThreadPriority -XX:+UseFPUForSpilling -XX:+EnableJVMCI -XX:+UseJVMCICompiler -XX:+AlwaysActAsServerClassMachine -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:+UseNUMA -XX:AllocatePrefetchStyle=3 -XX:NmethodSweepActivity=1 -XX:ReservedCodeCacheSize=400M -XX:-DontCompileHugeMethods -XX:ThreadPriorityPolicy=1 -XX:MaxNodeLimit=240000 -XX:NodeLimitFudgeFactor=8000 -XX:+EagerJVMCI -Dgraal.TuneInlinerExploration=1 -Dgraal.UsePriorityInlining=true -Dgraal.Vectorization=true -Dgraal.OptDuplication=true -Dgraal.DetectInvertedLoopsAsCounted=true -Dgraal.LoopInversion=true -Dgraal.VectorizeHashes=true -Dgraal.EnterprisePartialUnroll=true -Dgraal.VectorizeSIMD=true -Dgraal.StripMineNonCountedLoops=true -Dgraal.SpeculativeGuardMovement=true -Dgraal.InfeasiblePathCorrelation=true -Dgraal.CompilerConfiguration=enterprise -XX:+UseG1GC -XX:MaxGCPauseMillis=37 -XX:+PerfDisableSharedMem -XX:G1HeapRegionSize=16M -XX:G1NewSizePercent=23 -XX:G1ReservePercent=20 -XX:SurvivorRatio=32 -XX:G1MixedGCCountTarget=3 -XX:G1HeapWastePercent=20 -XX:InitiatingHeapOccupancyPercent=10 -XX:G1RSetUpdatingPauseTimePercent=0 -XX:MaxTenuringThreshold=1 -XX:G1SATBBufferEnqueueingThresholdPercent=30 -XX:G1ConcMarkStepDurationMillis=5.0 -XX:GCTimeRatio=99 -XX:NonNMethodCodeHeapSize=12M -XX:ProfiledCodeHeapSize=194M -XX:NonProfiledCodeHeapSize=194M -XX:+UseVectorCmov"
			} elseif ($profile.Value.lastVersionId -match '1\.16|1\.15|1\.14|1\.13|1\.12|1\.11|1\.10|1\.9\.|1\.9|1\.8\.|1\.8|1\.7\.|1\.7|1\.6\.|1\.6') {
				$profile.Value.javaDir = "$86Path\Minecraft Java\GraalVM8\bin\javaw.exe"
				$profile.Value.javaArgs = "-XX:+UnlockExperimentalVMOptions -XX:+UnlockDiagnosticVMOptions -XX:+UseDynamicNumberOfGCThreads -XX:+ParallelRefProcEnabled -XX:+UseFastUnorderedTimeStamps -XX:+UseCriticalJavaThreadPriority -XX:+UseFPUForSpilling -XX:+EnableJVMCI -XX:+UseJVMCICompiler -XX:+AlwaysActAsServerClassMachine -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:+UseNUMA -XX:AllocatePrefetchStyle=1 -XX:NmethodSweepActivity=1 -XX:ReservedCodeCacheSize=350M -XX:-DontCompileHugeMethods -XX:ThreadPriorityPolicy=1 -XX:MaxNodeLimit=240000 -XX:NodeLimitFudgeFactor=8000 -XX:+EagerJVMCI -Dgraal.TuneInlinerExploration=1 -Dgraal.UsePriorityInlining=true -Dgraal.Vectorization=true -Dgraal.OptDuplication=true -Dgraal.DetectInvertedLoopsAsCounted=true -Dgraal.LoopInversion=true -Dgraal.VectorizeHashes=true -Dgraal.EnterprisePartialUnroll=true -Dgraal.VectorizeSIMD=true -Dgraal.StripMineNonCountedLoops=true -Dgraal.SpeculativeGuardMovement=true -Dgraal.InfeasiblePathCorrelation=true -Dgraal.CompilerConfiguration=enterprise -XX:+UseG1GC -XX:MaxGCPauseMillis=37 -XX:+PerfDisableSharedMem -XX:G1HeapRegionSize=16M -XX:G1NewSizePercent=23 -XX:G1ReservePercent=20 -XX:SurvivorRatio=32 -XX:G1MixedGCCountTarget=3 -XX:G1HeapWastePercent=20 -XX:InitiatingHeapOccupancyPercent=10 -XX:G1RSetUpdatingPauseTimePercent=0 -XX:MaxTenuringThreshold=1 -XX:G1SATBBufferEnqueueingThresholdPercent=30 -XX:G1ConcMarkStepDurationMillis=5.0 -XX:G1ConcRSHotCardLimit=16 -XX:G1ConcRefinementServiceIntervalMillis=150 -XX:GCTimeRatio=99 -XX:+AggressiveOpts -XX:+UseFastAccessorMethods"
			} else {
				$profile.Value.PSObject.Properties.Remove('javaDir')
				$profile.Value.PSObject.Properties.Remove('javaArgs')
			}
		}
		$jsonString = $jsonContent | ConvertTo-Json 
		$jsonString | Set-Content -Path $jsonPath 
	} Catch {}
}
if (Test-Path -Path "$PathMinecraft\options.txt") {
	Copy-Item -Path "$pathminecraft\options.txt" -Destination "$pathminecraft\options.txt.bak" -Force -ErrorAction SilentlyContinue
	$command = "$SED -i `"s/^renderDistance:.*/renderDistance:8/g;s/^simulationDistance:.*/simulationDistance:12/g;s/^particles:.*/particles:2/g;s/^bobView:.*/bobView:false/g;s/^maxFPS:.*/maxFPS:260/g;s/^fboEnable:.*/fboEnable:true/g;s/^fancyGraphics:.*/fancyGraphics:false/g;s/^renderClouds:.*/renderClouds:false/g;s/^snooperEnabled:.*/snooperEnabled:false/g;s/^fullscreen:.*/fullscreen:true/g;s/^enableVsync:.*/enableVsync:false/g;s/^useVbo:.*/useVbo:true/g;s/^advancedItemTooltips:.*/advancedItemTooltips:true/g;s/^heldItemTooltips:.*/heldItemTooltips:true/g;s/^mipmapLevels:.*/mipmapLevels:4/g;s/^reducedDebugInfo:.*/reducedDebugInfo:true/g;s/^entityShadows:.*/entityShadows:false/g;s/^showSubtitles:.*/showSubtitles:false/g;s/^realmsNotifications:.*/realmsNotifications:false/g;s/^autoJump:.*/autoJump:false/g;s/^tutorialStep:.*/tutorialStep:none/g;s/^soundCategory_music:.*/soundCategory_music:0.0/g;s/^soundCategory_weather:.*/soundCategory_weather:0.0/g;s/^operatorItemsTab:.*/operatorItemsTab:true/g;s/^toggleSprint:.*/toggleSprint:true/g;s/^hideLightningFlashes:.*/hideLightningFlashes:true/g;s/^screenEffectScale:.*/screenEffectScale:0.0/g;s/^darknessEffectScale:.*/darknessEffectScale:0.0/g;s/^damageTiltStrength:.*/damageTiltStrength:0.0/g;s/^graphicsMode:.*/graphicsMode:0/g;s/^prioritizeChunkUpdates:.*/prioritizeChunkUpdates:0/g;s/^biomeBlendRadius:.*/biomeBlendRadius:0/g;s/^textBackgroundOpacity:.*/textBackgroundOpacity:0.0/g;s/^rawMouseInput:.*/rawMouseInput:true/g;s/^glDebugVerbosity:.*/glDebugVerbosity:1/g;s/^skipMultiplayerWarning:.*/skipMultiplayerWarning:true/g;s/^skipRealms32bitWarning:.*/skipRealms32bitWarning:true/g;s/^hideBundleTutorial:.*/hideBundleTutorial:true/g;s/^syncChunkWrites:.*/syncChunkWrites:true/g;s/^showAutosaveIndicator:.*/showAutosaveIndicator:false/g;s/^telemetryOptInExtra:.*/telemetryOptInExtra:false/g;s/^allowBlockAlternatives:.*/allowBlockAlternatives:false/g;s/^showInventoryAchievementHint:.*/showInventoryAchievementHint:false/g;s/^ao:.*/ao:0/g;`" `"$PathMinecraft\options.txt`""
	cmd.exe /c $command
}
if (Test-Path -Path "$PathMinecraft\optionsof.txt") {
	Copy-Item -Path "$pathminecraft\optionsof.txt" -Destination "$pathminecraft\optionsof.txt.bak" -Force -ErrorAction SilentlyContinue
	$command = "$SED -i `"s/^ofFogType:.*/ofFogType:3/g;s/^ofMipmapType:.*/ofMipmapType:0/g;s/^ofOcclusionFancy:.*/ofOcclusionFancy:false/g;s/^ofSmoothFps:.*/ofSmoothFps:false/g;s/^ofSmoothWorld:.*/ofSmoothWorld:true/g;s/^ofClouds:.*/ofClouds:3/g;s/^ofTrees:.*/ofTrees:1/g;s/^ofRain:.*/ofRain:3/g;s/^ofAnimatedWater:.*/ofAnimatedWater:2/g;s/^ofAnimatedLava:.*/ofAnimatedLava:2/g;s/^ofAnimatedFire:.*/ofAnimatedFire:false/g;s/^ofAnimatedPortal:.*/ofAnimatedPortal:false/g;s/^ofAnimatedRedstone:.*/ofAnimatedRedstone:false/g;s/^ofAnimatedExplosion:.*/ofAnimatedExplosion:false/g;s/^ofAnimatedFlame:.*/ofAnimatedFlame:false/g;s/^ofAnimatedSmoke:.*/ofAnimatedSmoke:false/g;s/^ofVoidParticles:.*/ofVoidParticles:false/g;s/^ofWaterParticles:.*/ofWaterParticles:false/g;s/^ofPortalParticles:.*/ofPortalParticles:false/g;s/^ofPotionParticles:.*/ofPotionParticles:false/g;s/^ofFireworkParticles:.*/ofFireworkParticles:false/g;s/^ofDrippingWaterLava:.*/ofDrippingWaterLava:true/g;s/^ofAnimatedTerrain:.*/ofAnimatedTerrain:false/g;s/^ofAnimatedTextures:.*/ofAnimatedTextures:false/g;s/^ofRainSplash:.*/ofRainSplash:false/g;s/^ofBetterGrass:.*/ofBetterGrass:3/g;s/^ofConnectedTextures:.*/ofConnectedTextures:2/g;s/^ofWeather:.*/ofWeather:false/g;s/^ofSky:.*/ofSky:false/g;s/^ofStars:.*/ofStars:false/g;s/^ofSunMoon:.*/ofSunMoon:true/g;s/^ofVignette:.*/ofVignette:1/g;s/^ofChunkUpdates:.*/ofChunkUpdates:1/g;s/^ofChunkUpdatesDynamic:.*/ofChunkUpdatesDynamic:false/g;s/^ofTime:.*/ofTime:0/g;s/^ofAaLevel:.*/ofAaLevel:0/g;s/^ofAfLevel:.*/ofAfLevel:1/g;s/^ofBetterSnow:.*/ofBetterSnow:false/g;s/^ofSwampColors:.*/ofSwampColors:false/g;s/^ofRandomEntities:.*/ofRandomEntities:true/g;s/^ofCustomFonts:.*/ofCustomFonts:true/g;s/^ofCustomColors:.*/ofCustomColors:true/g;s/^ofCustomItems:.*/ofCustomItems:true/g;s/^ofCustomSky:.*/ofCustomSky:true/g;s/^ofNaturalTextures:.*/ofNaturalTextures:false/g;s/^ofEmissiveTextures:.*/ofEmissiveTextures:true/g;s/^ofLazyChunkLoading:.*/ofLazyChunkLoading:true/g;s/^ofRenderRegions:.*/ofRenderRegions:false/g;s/^ofSmartAnimations:.*/ofSmartAnimations:true/g;s/^ofAlternateBlocks:.*/ofAlternateBlocks:false/g;s/^ofDynamicLights:.*/ofDynamicLights:3/g;s/^ofCustomEntityModels:.*/ofCustomEntityModels:true/g;s/^ofCustomGuis:.*/ofCustomGuis:true/g;s/^ofShowGlErrors:.*/ofShowGlErrors:false/g;s/^ofFastMath:.*/ofFastMath:true/g;s/^ofFastRender:.*/ofFastRender:true/g;s/^ofChatBackground:.*/ofChatBackground:0/g;s/^ofChatShadow:.*/ofChatShadow:false/g;s/^ofTelemetry:.*/ofTelemetry:2/g;s/^ofHeldItemTooltips:.*/ofHeldItemTooltips:true/g;`" `"$PathMinecraft\optionsof.txt`""
	cmd.exe /c $command
}	
if (Test-Path -Path "$PathMinecraft\OptionsLC.txt") {
	Copy-Item -Path "$pathminecraft\OptionsLC.txt" -Destination "$pathminecraft\OptionsLC.txt.bak" -Force -ErrorAction SilentlyContinue
	try {
		$LunarConfig = Get-Content "$PathMinecraft\optionsLC.txt" -ErrorAction SilentlyContinue | ConvertFrom-Json
		try {
			$LunarConfig.renderDistance = "8"
		} Catch {}
		try {
			$LunarConfig.particles = "2"
		} Catch {}
		try {
			$LunarConfig.bobView = "false"
		} Catch {}
		try {
			$LunarConfig.tutorialStep = "none"
		} Catch {}
		try {
			$LunarConfig.showSubtitles = "false"
		} Catch {}
		try {
			$LunarConfig.operatorItemsTab = "true"
		} Catch {}
		try {
			$LunarConfig.graphicsMode = "0"
		} Catch {}
		try {
			$LunarConfig.prioritizeChunkUpdates = "0"
		} Catch {}
		try {
			$LunarConfig.allowBlockAlternatives = "false"
		} Catch {}
		try {
			$LunarConfig.anaglyph3d = "false"
		} Catch {}
		try {
			$LunarConfig.maxFPS = "260"
		} Catch {}
		try {
			$LunarConfig.fboEnable = "true"
		} Catch {}
		try {
			$LunarConfig.fancyGraphics = "false"
		} Catch {}
		try {
			$LunarConfig.ao = "0"
		} Catch {}
		try {
			$LunarConfig.renderClouds = "false"
		} Catch {}
		try {
			$LunarConfig.snooperEnabled = "false"
		} Catch {}
		try {
			$LunarConfig.fullscreen = "true"
		} Catch {}
		try {
			$LunarConfig.enableVsync = "false"
		} Catch {}
		try {
			$LunarConfig.useVbo = "true"
		} Catch {}
		try {
			$LunarConfig.advancedItemTooltips = "true"
		} Catch {}
		try {
			$LunarConfig.heldItemTooltips = "true"
		} Catch {}
		try {
			$LunarConfig.showInventoryAchievementHint = "false"
		} Catch {}
		try {
			$LunarConfig.mipmapLevels = "4"
		} Catch {}
		try {
			$LunarConfig.reducedDebugInfo = "true"
		} Catch {}
		try {
			$LunarConfig.entityShadows = "false"
		} Catch {}
		try {
			$LunarConfig.realmsNotifications = "false"
		} Catch {}
		try {
			$LunarConfig.soundCategory_music = "0.0"
		} Catch {}
		try {
			$LunarConfig.soundCategory_weather = "0.0"
		} Catch {}
		try {
			$LunarConfig.autoJump = "false"
		} Catch {}
		try {
			$LunarConfig.toggleSprint = "true"
		} Catch {}
		try {
			$LunarConfig.hideLightningFlashes = "true"
		} Catch {}
		try {
			$LunarConfig.screenEffectScale = "0.0"
		} Catch {}
		try {
			$LunarConfig.darknessEffectScale = "0.0"
		} Catch {}
		try {
			$LunarConfig.simulationDistance = "12"
		} Catch {}
		try {
			$LunarConfig.biomeBlendRadius = "0"
		} Catch {}
		try {
			$LunarConfig.textBackgroundOpacity = "0.0"
		} Catch {}
		try {
			$LunarConfig.rawMouseInput = "true"
		} Catch {}
		try {
			$LunarConfig.glDebugVerbosity = "1"
		} Catch {}
		try {
			$LunarConfig.skipMultiplayerWarning = "true"
		} Catch {}
		try {
			$LunarConfig.skipRealms32bitWarning = "true"
		} Catch {}
		try {
			$LunarConfig.hideBundleTutorial = "true"
		} Catch {}
		try {
			$LunarConfig.syncChunkWrites = "true"
		} Catch {}
		try {
			$LunarConfig.showAutosaveIndicator = "false"
		} Catch {}
		try {
			$LunarConfig.damageTiltStrength = "false"
		} Catch {}
		try {
			$LunarConfig.telemetryOptInExtra = "false"
		} Catch {}
		$Lunarjson = $LunarConfig | ConvertTo-Json -ErrorAction SilentlyContinue
		$Lunarjson | Set-Content -Path "$PathMinecraft\optionsLC.txt" -ErrorAction SilentlyContinue
	} Catch {}
}
if (Test-Path -Path "$PathMinecraft\sodium-options.json") {
	Copy-Item -Path "$pathminecraft\sodium-options.json" -Destination "$pathminecraft\sodium-options.json.bak" -Force -ErrorAction SilentlyContinue
$newSodiumConfig = @"
{
  "quality": {
    "weather_quality": "FAST",
    "leaves_quality": "FAST",
    "enable_vignette": false
  },
  "advanced": {
    "arena_memory_allocator": "ASYNC",
    "allow_direct_memory_access": true,
    "enable_memory_tracing": false,
    "use_advanced_staging_buffers": true,
    "cpu_render_ahead_limit": 3
  },
  "performance": {
    "chunk_builder_threads": 0,
    "always_defer_chunk_updates": false,
    "animate_only_visible_textures": true,
    "use_entity_culling": true,
    "use_fog_occlusion": true,
    "use_block_face_culling": true
  },
  "notifications": {
    "hide_donation_button": true
  }
}
"@
	
	$newSodiumConfig | Set-Content -Path "$PathMinecraft\sodium-options.json" -ErrorAction SilentlyContinue
	
}
