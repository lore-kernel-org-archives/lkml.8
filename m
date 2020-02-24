Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A967CC35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804562080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582551717;
	bh=JFOPdMiC6entIkTxbyo8ghyjVFdPt0mqYJqGB1xCFN0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=HX5QGrIpgNgFyjEMjiNwNpZDWU67b7l62/90b0q7b3LfWgi2qDlCARmIbhY7yVVI+
	 fq79fTpQMZlA+lS0aU0Vk+FdCqjaQbwG65Y+muSFz5JiFojH/xOwQTATjxbRNF6oZt
	 MyJ5JLuP5BQV3cyKP3uMiSusMKUvdNGcFQC3XOQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbgBXNl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 08:41:56 -0500
Received: from foss.arm.com ([217.140.110.172]:37200 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbgBXNl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 08:41:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 591F831B;
        Mon, 24 Feb 2020 05:41:55 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D28513F534;
        Mon, 24 Feb 2020 05:41:54 -0800 (PST)
Date:   Mon, 24 Feb 2020 13:41:53 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: tlv320adcx140: Add decimation filter support" to the asoc tree
In-Reply-To:  <20200221181358.22526-2-dmurphy@ti.com>
Message-Id:  <applied-20200221181358.22526-2-dmurphy@ti.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: tlv320adcx140: Add decimation filter support

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

From 8101d76253f6d1032ca79e937e45b837cb4bf0e0 Mon Sep 17 00:00:00 2001
From: Dan Murphy <dmurphy@ti.com>
Date: Fri, 21 Feb 2020 12:13:58 -0600
Subject: [PATCH] ASoC: tlv320adcx140: Add decimation filter support

Add decimation filter selection support.
Per Section 8.3.6.7 the Digital Decimation Filter is selectable between
a Linear Phase, Low Latency, and Ultra Low Latency filer.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
Link: https://lore.kernel.org/r/20200221181358.22526-2-dmurphy@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320adcx140.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 105e51be6fe6..93a0cb8e662c 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -169,6 +169,17 @@ static DECLARE_TLV_DB_SCALE(agc_thresh_tlv, -3600, 200, 0);
 /* AGC Max Gain. From 3 dB to 42 dB in 3 dB steps */
 static DECLARE_TLV_DB_SCALE(agc_gain_tlv, 300, 300, 0);
 
+static const char * const decimation_filter_text[] = {
+	"Linear Phase", "Low Latency", "Ultra-low Latency"
+};
+
+static SOC_ENUM_SINGLE_DECL(decimation_filter_enum, ADCX140_DSP_CFG0, 4,
+			    decimation_filter_text);
+
+static const struct snd_kcontrol_new decimation_filter_controls[] = {
+	SOC_DAPM_ENUM("Decimation Filter", decimation_filter_enum),
+};
+
 static const char * const resistor_text[] = {
 	"2.5 kOhm", "10 kOhm", "20 kOhm"
 };
@@ -404,6 +415,9 @@ static const struct snd_soc_dapm_widget adcx140_dapm_widgets[] = {
 			in3_resistor_controls),
 	SND_SOC_DAPM_MUX("IN4 Analog Mic Resistor", SND_SOC_NOPM, 0, 0,
 			in4_resistor_controls),
+
+	SND_SOC_DAPM_MUX("Decimation Filter", SND_SOC_NOPM, 0, 0,
+			decimation_filter_controls),
 };
 
 static const struct snd_soc_dapm_route adcx140_audio_map[] = {
@@ -418,6 +432,10 @@ static const struct snd_soc_dapm_route adcx140_audio_map[] = {
 	{"CH3_ASI_EN", "Switch", "CH3_ADC"},
 	{"CH4_ASI_EN", "Switch", "CH4_ADC"},
 
+	{"Decimation Filter", "Linear Phase", "DRE_ENABLE"},
+	{"Decimation Filter", "Low Latency", "DRE_ENABLE"},
+	{"Decimation Filter", "Ultra-low Latency", "DRE_ENABLE"},
+
 	{"DRE_ENABLE", "Switch", "CH1_DRE_EN"},
 	{"DRE_ENABLE", "Switch", "CH2_DRE_EN"},
 	{"DRE_ENABLE", "Switch", "CH3_DRE_EN"},
-- 
2.20.1

