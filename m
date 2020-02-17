Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD15C7619E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E234206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="F7IJ71l4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="agSTzwEf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgBQGnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:43:20 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:60881 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727402AbgBQGnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:43:10 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 22CCF5590;
        Mon, 17 Feb 2020 01:43:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 17 Feb 2020 01:43:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=ectfDp539hM3p
        tJyekSj+yRWKWQ4i4xQcJ0r8f3OkZg=; b=F7IJ71l4MsxmVq4huWXG6LnfilrRa
        PEe+HDA5NQrcuy951qPXy2dH8ZaPzUFQMz2SHMVw2hWzEcbHo3TKXmxcUX94Xmz3
        /mSa9mi2iv9sEuBvtXTmRLWKPk4lzpgyh4t/10VDFBUaOCjoUI7jJrxXolnVTeOT
        Vqz7gS3bcK+yYr5eiI96CgtxNjkQXn5Abob/WPibXSRyJz711KPH9VtLsiIhdoPC
        dIsPSX0rIASALTvKFYWyAwWLLNDD0qo3oUn+mh0bYPeqwblsdLd9h3DKfKmigyZQ
        0TQXDFzhLhKk53Br59N6gcvQYWcxHgo7HnOkNsF3iuSkru73kfrS/juYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ectfDp539hM3ptJyekSj+yRWKWQ4i4xQcJ0r8f3OkZg=; b=agSTzwEf
        Uic/LDNzkirTkry/5n12fx4DHRJy+gzejfXJdV2+rBU/8w5L1CweXmTzXiHyHj0N
        8k2rWRy1fr5abvYxbMukBPrknfr/m5yACsbZ5pMOkz5hEsDSFUMG98HxHZnBSSm1
        nrStBUcknkKojORDi5uoDPHyh3nIM2mpgi2vx+7BiSMkhRDPlq4rSisJfAAJv4Ps
        vFJroUm4n9i/goiFOgHbVbXNZq6Y8Jmd3jFj584cJRTKxqG5FJFGNmVPH9H9wIog
        cxAe6oe9pkN7soLPGRswsAinpmT3BIpTY7MyddDp6ucrC7EELzM/n7oYl7MCLFXo
        K0mWBXEA9GAGew==
X-ME-Sender: <xms:_DVKXjCMbXSmVX_qm8JIGG0OBE2efMrP9xAB7AjghsEqLJuIPqbUnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedvjeenucfrrghr
    rghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:_TVKXtzF_Hu6hN0cXNTPj9K1w70EDnTgOULcYe2R8NMdRdo0kY8m9w>
    <xmx:_TVKXpnT3tRnltnyCWA8NFXVkNNCezYKrOS1SSAYUgJaCWqnkJZAHA>
    <xmx:_TVKXqGXBqOFE62Qe0ay9vBSBdfuOuZEz1cESeMrLCRi60l65lBhxw>
    <xmx:_TVKXszf4QYA9d_usTG6AjiZJ60jBHwoYoHJfpt7I086t6bCgzFjOw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5CBEE3280059;
        Mon, 17 Feb 2020 01:43:08 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        =?UTF-8?q?Myl=C3=A8ne=20Josserand?= 
        <mylene.josserand@free-electrons.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [RFC PATCH 29/34] ASoC: sun8i-codec: Add AIF, ADC, and DAC volume controls
Date:   Mon, 17 Feb 2020 00:42:45 -0600
Message-Id: <20200217064250.15516-30-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217064250.15516-1-samuel@sholland.org>
References: <20200217064250.15516-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows changing the volume of each digital input/output
independently, and provides the only "master volume" for the DAC.
(The ADC also has a gain control on the analog side.)

While the hardware supports volumes up to +72dB, the controls here
are limited to +24dB maximum, as anything more makes volume sliders
difficult to use, and is extremely likely to cause clipping (this is
simple digital gain).

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 56 +++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 245145e36357..71cd7646a895 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -21,6 +21,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
+#include <sound/tlv.h>
 
 #define SUN8I_SYSCLK_CTL				0x00c
 #define SUN8I_SYSCLK_CTL_AIF1CLK_ENA			11
@@ -73,6 +74,12 @@
 #define SUN8I_AIF1_MXR_SRC_AD0R_MXR_SRC_AIF2DACR	10
 #define SUN8I_AIF1_MXR_SRC_AD0R_MXR_SRC_ADCR		9
 #define SUN8I_AIF1_MXR_SRC_AD0R_MXR_SRC_AIF2DACL	8
+#define SUN8I_AIF1_VOL_CTRL1				0x050
+#define SUN8I_AIF1_VOL_CTRL1_AD0L_VOL			8
+#define SUN8I_AIF1_VOL_CTRL1_AD0R_VOL			0
+#define SUN8I_AIF1_VOL_CTRL3				0x058
+#define SUN8I_AIF1_VOL_CTRL3_DA0L_VOL			8
+#define SUN8I_AIF1_VOL_CTRL3_DA0R_VOL			0
 #define SUN8I_AIF2_ADCDAT_CTRL				0x084
 #define SUN8I_AIF2_ADCDAT_CTRL_AIF2_ADCL_ENA		15
 #define SUN8I_AIF2_ADCDAT_CTRL_AIF2_ADCR_ENA		14
@@ -93,6 +100,12 @@
 #define SUN8I_AIF2_MXR_SRC_ADCR_MXR_SRC_AIF1DA1R	10
 #define SUN8I_AIF2_MXR_SRC_ADCR_MXR_SRC_AIF2DACL	9
 #define SUN8I_AIF2_MXR_SRC_ADCR_MXR_SRC_ADCR		8
+#define SUN8I_AIF2_VOL_CTRL1				0x090
+#define SUN8I_AIF2_VOL_CTRL1_ADCL_VOL			8
+#define SUN8I_AIF2_VOL_CTRL1_ADCR_VOL			0
+#define SUN8I_AIF2_VOL_CTRL2				0x098
+#define SUN8I_AIF2_VOL_CTRL2_DACL_VOL			8
+#define SUN8I_AIF2_VOL_CTRL2_DACR_VOL			0
 #define SUN8I_AIF3_CLK_CTRL_AIF3_CLOCK_SRC_AIF1		(0x0 << 0)
 #define SUN8I_AIF3_CLK_CTRL_AIF3_CLOCK_SRC_AIF2		(0x1 << 0)
 #define SUN8I_AIF3_CLK_CTRL_AIF3_CLOCK_SRC_AIF1CLK	(0x2 << 0)
@@ -106,8 +119,14 @@
 #define SUN8I_ADC_DIG_CTRL_ENAD				15
 #define SUN8I_ADC_DIG_CTRL_ADOUT_DTS			2
 #define SUN8I_ADC_DIG_CTRL_ADOUT_DLY			1
+#define SUN8I_ADC_VOL_CTRL				0x104
+#define SUN8I_ADC_VOL_CTRL_ADCL_VOL			8
+#define SUN8I_ADC_VOL_CTRL_ADCR_VOL			0
 #define SUN8I_DAC_DIG_CTRL				0x120
 #define SUN8I_DAC_DIG_CTRL_ENDA				15
+#define SUN8I_DAC_VOL_CTRL				0x124
+#define SUN8I_DAC_VOL_CTRL_DACL_VOL			8
+#define SUN8I_DAC_VOL_CTRL_DACR_VOL			0
 #define SUN8I_DAC_MXR_SRC				0x130
 #define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF1DA0L		15
 #define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF1DA1L		14
@@ -521,6 +540,41 @@ static struct snd_soc_dai_driver sun8i_codec_dais[] = {
 	},
 };
 
+static const DECLARE_TLV_DB_SCALE(sun8i_codec_vol_scale, -12000, 75, 1);
+
+static const struct snd_kcontrol_new sun8i_codec_controls[] = {
+	SOC_DOUBLE_TLV("AIF1 AD0 Capture Volume",
+		       SUN8I_AIF1_VOL_CTRL1,
+		       SUN8I_AIF1_VOL_CTRL1_AD0L_VOL,
+		       SUN8I_AIF1_VOL_CTRL1_AD0R_VOL,
+		       0xc0, 0, sun8i_codec_vol_scale),
+	SOC_DOUBLE_TLV("AIF1 DA0 Playback Volume",
+		       SUN8I_AIF1_VOL_CTRL3,
+		       SUN8I_AIF1_VOL_CTRL3_DA0L_VOL,
+		       SUN8I_AIF1_VOL_CTRL3_DA0R_VOL,
+		       0xc0, 0, sun8i_codec_vol_scale),
+	SOC_DOUBLE_TLV("AIF2 ADC Capture Volume",
+		       SUN8I_AIF2_VOL_CTRL1,
+		       SUN8I_AIF2_VOL_CTRL1_ADCL_VOL,
+		       SUN8I_AIF2_VOL_CTRL1_ADCR_VOL,
+		       0xc0, 0, sun8i_codec_vol_scale),
+	SOC_DOUBLE_TLV("AIF2 DAC Playback Volume",
+		       SUN8I_AIF2_VOL_CTRL2,
+		       SUN8I_AIF2_VOL_CTRL2_DACL_VOL,
+		       SUN8I_AIF2_VOL_CTRL2_DACR_VOL,
+		       0xc0, 0, sun8i_codec_vol_scale),
+	SOC_DOUBLE_TLV("ADC Capture Volume",
+		       SUN8I_ADC_VOL_CTRL,
+		       SUN8I_ADC_VOL_CTRL_ADCL_VOL,
+		       SUN8I_ADC_VOL_CTRL_ADCR_VOL,
+		       0xc0, 0, sun8i_codec_vol_scale),
+	SOC_DOUBLE_TLV("DAC Playback Volume",
+		       SUN8I_DAC_VOL_CTRL,
+		       SUN8I_DAC_VOL_CTRL_DACL_VOL,
+		       SUN8I_DAC_VOL_CTRL_DACR_VOL,
+		       0xc0, 0, sun8i_codec_vol_scale),
+};
+
 static const struct snd_kcontrol_new sun8i_aif1_loopback_switch =
 	SOC_DAPM_SINGLE("AIF1 Loopback Switch",
 			SUN8I_AIF1_DACDAT_CTRL,
@@ -1017,6 +1071,8 @@ static int sun8i_codec_component_probe(struct snd_soc_component *component)
 }
 
 static const struct snd_soc_component_driver sun8i_soc_component = {
+	.controls		= sun8i_codec_controls,
+	.num_controls		= ARRAY_SIZE(sun8i_codec_controls),
 	.dapm_widgets		= sun8i_codec_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(sun8i_codec_dapm_widgets),
 	.dapm_routes		= sun8i_codec_dapm_routes,
-- 
2.24.1

