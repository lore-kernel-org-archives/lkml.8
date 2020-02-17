Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2CFC3402D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 22:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF4A214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 22:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581977039;
	bh=yXKFLsM3x0Tbc7JM2S3uR+kawkvD3o1mSxx5Xdc4naY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=hqtlRdj5NYL4hor3uSIjU5slOEyXyX4+0PZmGtVWJ6s92WVPUuG+fkHUxbbdzip10
	 G1VXE2Ztz3ZieEVOrTaMS1m0DARJPxb5s88dJjnOlnZnXKg/UHOrXc76aqTByhIZCo
	 HVgtTr4szjqKEZ33t42DiJFlBCDLijICvzKOgG9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgBQWD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 17:03:58 -0500
Received: from foss.arm.com ([217.140.110.172]:42126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgBQWD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 17:03:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 734A0106F;
        Mon, 17 Feb 2020 14:03:55 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAD543F703;
        Mon, 17 Feb 2020 14:03:54 -0800 (PST)
Date:   Mon, 17 Feb 2020 22:03:53 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: aiu: simplify component addition" to the asoc tree
In-Reply-To:  <20200217092019.433402-1-jbrunet@baylibre.com>
Message-Id:  <applied-20200217092019.433402-1-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: aiu: simplify component addition

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 0247142233239dc235f8239aab5c7991250d4e66 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 17 Feb 2020 10:20:19 +0100
Subject: [PATCH] ASoC: meson: aiu: simplify component addition

Now that the component name is unique within ASoC, there is no need to
hack the debugfs prefix to add more than one ASoC component to a linux
device. Remove the unnecessary function and use
snd_soc_register_component() directly.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20200217092019.433402-1-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/aiu-acodec-ctrl.c |  7 +++----
 sound/soc/meson/aiu-codec-ctrl.c  |  7 +++----
 sound/soc/meson/aiu.c             | 20 --------------------
 sound/soc/meson/aiu.h             |  8 --------
 4 files changed, 6 insertions(+), 36 deletions(-)

diff --git a/sound/soc/meson/aiu-acodec-ctrl.c b/sound/soc/meson/aiu-acodec-ctrl.c
index b8e88b1a4fc8..7078197e0cc5 100644
--- a/sound/soc/meson/aiu-acodec-ctrl.c
+++ b/sound/soc/meson/aiu-acodec-ctrl.c
@@ -197,8 +197,7 @@ static const struct snd_soc_component_driver aiu_acodec_ctrl_component = {
 
 int aiu_acodec_ctrl_register_component(struct device *dev)
 {
-	return aiu_add_component(dev, &aiu_acodec_ctrl_component,
-				 aiu_acodec_ctrl_dai_drv,
-				 ARRAY_SIZE(aiu_acodec_ctrl_dai_drv),
-				 "acodec");
+	return snd_soc_register_component(dev, &aiu_acodec_ctrl_component,
+					  aiu_acodec_ctrl_dai_drv,
+					  ARRAY_SIZE(aiu_acodec_ctrl_dai_drv));
 }
diff --git a/sound/soc/meson/aiu-codec-ctrl.c b/sound/soc/meson/aiu-codec-ctrl.c
index 8646a953e3b3..4b773d3e8b07 100644
--- a/sound/soc/meson/aiu-codec-ctrl.c
+++ b/sound/soc/meson/aiu-codec-ctrl.c
@@ -144,9 +144,8 @@ static const struct snd_soc_component_driver aiu_hdmi_ctrl_component = {
 
 int aiu_hdmi_ctrl_register_component(struct device *dev)
 {
-	return aiu_add_component(dev, &aiu_hdmi_ctrl_component,
-				 aiu_hdmi_ctrl_dai_drv,
-				 ARRAY_SIZE(aiu_hdmi_ctrl_dai_drv),
-				 "hdmi");
+	return snd_soc_register_component(dev, &aiu_hdmi_ctrl_component,
+					  aiu_hdmi_ctrl_dai_drv,
+					  ARRAY_SIZE(aiu_hdmi_ctrl_dai_drv));
 }
 
diff --git a/sound/soc/meson/aiu.c b/sound/soc/meson/aiu.c
index 34b40b8b8299..d3e2d40e9562 100644
--- a/sound/soc/meson/aiu.c
+++ b/sound/soc/meson/aiu.c
@@ -71,26 +71,6 @@ int aiu_of_xlate_dai_name(struct snd_soc_component *component,
 	return 0;
 }
 
-int aiu_add_component(struct device *dev,
-		      const struct snd_soc_component_driver *component_driver,
-		      struct snd_soc_dai_driver *dai_drv,
-		      int num_dai,
-		      const char *debugfs_prefix)
-{
-	struct snd_soc_component *component;
-
-	component = devm_kzalloc(dev, sizeof(*component), GFP_KERNEL);
-	if (!component)
-		return -ENOMEM;
-
-#ifdef CONFIG_DEBUG_FS
-	component->debugfs_prefix = debugfs_prefix;
-#endif
-
-	return snd_soc_add_component(dev, component, component_driver,
-				     dai_drv, num_dai);
-}
-
 static int aiu_cpu_of_xlate_dai_name(struct snd_soc_component *component,
 				     struct of_phandle_args *args,
 				     const char **dai_name)
diff --git a/sound/soc/meson/aiu.h b/sound/soc/meson/aiu.h
index 097c26de7b7c..06a968c55728 100644
--- a/sound/soc/meson/aiu.h
+++ b/sound/soc/meson/aiu.h
@@ -11,9 +11,7 @@ struct clk;
 struct clk_bulk_data;
 struct device;
 struct of_phandle_args;
-struct snd_soc_component_driver;
 struct snd_soc_dai;
-struct snd_soc_dai_driver;
 struct snd_soc_dai_ops;
 
 enum aiu_clk_ids {
@@ -45,12 +43,6 @@ int aiu_of_xlate_dai_name(struct snd_soc_component *component,
 			  const char **dai_name,
 			  unsigned int component_id);
 
-int aiu_add_component(struct device *dev,
-		      const struct snd_soc_component_driver *component_driver,
-		      struct snd_soc_dai_driver *dai_drv,
-		      int num_dai,
-		      const char *debugfs_prefix);
-
 int aiu_hdmi_ctrl_register_component(struct device *dev);
 int aiu_acodec_ctrl_register_component(struct device *dev);
 
-- 
2.20.1

