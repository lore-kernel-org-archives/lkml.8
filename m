Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58845C11D20
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F2F20679
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="b6Q3mgJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgBTU53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 15:57:29 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36058 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729371AbgBTU5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:57:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so6194527wru.3;
        Thu, 20 Feb 2020 12:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O9H0QZyYuaUeSBKWNz88pbKgmPYyIAQJ2VGIcN7sek0=;
        b=b6Q3mgJE/4X0ENVknSqB4BtsyvQ74D276ZzvnPLSb7sg7O+6chdR1qLWsLsIDf25vJ
         hFELriumpX90BRiMoHhBeLiOe+eK8z3s29hsNJM6JYhBpiUkFzlRJcjWkSslZANli+w3
         vizSo+w7cNiah9ptmHqyTO6fOJ2Z1FYUeP4uFO3SJra4UWofMbcgcO+jgcAQsPrYpQaZ
         hLQ/BJq3fiK5EZXom38aJkJ7xmL+cY2EVEFaK89D6wWp5vW0IJsCAQJd4siKS6m5Zs7u
         YuI7WrCS3XX656MKm9ELKGHESQ7YJG9OsD5J7FYsTdPx+PTKkmP6YVSbp3us4NI4sT6n
         Iyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O9H0QZyYuaUeSBKWNz88pbKgmPYyIAQJ2VGIcN7sek0=;
        b=s2svM/fLLMyhqf79Qcv9lwap60ItAIk2aFF0gf6K0Go5JFSav2AiA/fuV3+kmTSw1R
         tPta9nNRsRr6VBq5UcGHHdL0+E/xtVGVDnZnKI5/mo0oLb2alBiOHDd7pTHc9TzbmMIO
         PG+MU20n/uM5d830w06kT8u39NrrbYsZU0MPitqPfXc7qjnLlRZ6F6B+NUqvCEGOsYl7
         Zc2eyu44gg3NJ9KHlh74gx3UGspUxjSvztnqsQMrCakbMjo3tZZzq/HAP03Tt0vWVeBM
         WiVids6isL+VQ0TpktACbFqxKIGmqVH6WARVPzAaXiMFVk9c0T9BrVUxmAyFPft/aECv
         EHNw==
X-Gm-Message-State: APjAAAUsCnaGuzEvAUaSvxl886Te0nQAShBRGAfgg4e4GLU2589Gggvc
        0ySp9ntKP4rsmo/NtnnKuqY=
X-Google-Smtp-Source: APXvYqxYZID8xJsIWV9Ml8b2mVsDTj0py1fbWd0tADweJ9z/lQnfqtkr1cSxhaTtWPJxJis6vxvwGA==
X-Received: by 2002:adf:a39a:: with SMTP id l26mr43640993wrb.211.1582232241757;
        Thu, 20 Feb 2020 12:57:21 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id a184sm695039wmf.29.2020.02.20.12.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 12:57:21 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/3] ASoC: meson: aiu: add support for the Meson8 and Meson8b SoC families
Date:   Thu, 20 Feb 2020 21:57:11 +0100
Message-Id: <20200220205711.77953-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200220205711.77953-1-martin.blumenstingl@googlemail.com>
References: <20200220205711.77953-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AIU audio controller on the Meson8 and Meson8b SoC families is
compatible with the one found in the later GXBB family. Add compatible
strings for these two older SoC families so the driver can be loaded for
them.

Instead of using the I2S divider from the AIU_CLK_CTRL_MORE register we
need to use the I2S divider from the AIU_CLK_CTRL register. This older
register is less flexible because it only supports four divider settings
(1, 2, 4, 8) compared to the AIU_CLK_CTRL_MORE register (which supports
dividers in the range 0..64).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 sound/soc/meson/Kconfig           |  2 +-
 sound/soc/meson/aiu-encoder-i2s.c | 92 +++++++++++++++++++++++--------
 sound/soc/meson/aiu.c             |  9 +++
 sound/soc/meson/aiu.h             |  1 +
 4 files changed, 81 insertions(+), 23 deletions(-)

diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
index 897a706dcda0..d27e9180b453 100644
--- a/sound/soc/meson/Kconfig
+++ b/sound/soc/meson/Kconfig
@@ -10,7 +10,7 @@ config SND_MESON_AIU
 	imply SND_SOC_HDMI_CODEC if DRM_MESON_DW_HDMI
 	help
 	  Select Y or M to add support for the Audio output subsystem found
-	  in the Amlogic GX SoC family
+	  in the Amlogic Meson8, Meson8b and GX SoC families
 
 config SND_MESON_AXG_FIFO
 	tristate
diff --git a/sound/soc/meson/aiu-encoder-i2s.c b/sound/soc/meson/aiu-encoder-i2s.c
index 4900e38e7e49..cc73b5d5c2b7 100644
--- a/sound/soc/meson/aiu-encoder-i2s.c
+++ b/sound/soc/meson/aiu-encoder-i2s.c
@@ -111,34 +111,40 @@ static int aiu_encoder_i2s_setup_desc(struct snd_soc_component *component,
 	return 0;
 }
 
-static int aiu_encoder_i2s_set_clocks(struct snd_soc_component *component,
-				      struct snd_pcm_hw_params *params)
+static int aiu_encoder_i2s_set_legacy_div(struct snd_soc_component *component,
+					  struct snd_pcm_hw_params *params,
+					  unsigned int bs)
 {
-	struct aiu *aiu = snd_soc_component_get_drvdata(component);
-	unsigned int srate = params_rate(params);
-	unsigned int fs, bs;
-
-	/* Get the oversampling factor */
-	fs = DIV_ROUND_CLOSEST(clk_get_rate(aiu->i2s.clks[MCLK].clk), srate);
+	switch (bs) {
+	case 1:
+	case 2:
+	case 4:
+	case 8:
+		/* These are the only valid legacy dividers */
+		break;
 
-	if (fs % 64)
+	default:
+		dev_err(component->dev, "Unsupported i2s divider: %u\n", bs);
 		return -EINVAL;
+	};
 
-	/* Send data MSB first */
-	snd_soc_component_update_bits(component, AIU_I2S_DAC_CFG,
-				      AIU_I2S_DAC_CFG_MSB_FIRST,
-				      AIU_I2S_DAC_CFG_MSB_FIRST);
+	snd_soc_component_update_bits(component, AIU_CLK_CTRL,
+				      AIU_CLK_CTRL_I2S_DIV,
+				      FIELD_PREP(AIU_CLK_CTRL_I2S_DIV,
+						 __ffs(bs)));
 
-	/* Set bclk to lrlck ratio */
-	snd_soc_component_update_bits(component, AIU_CODEC_DAC_LRCLK_CTRL,
-				      AIU_CODEC_DAC_LRCLK_CTRL_DIV,
-				      FIELD_PREP(AIU_CODEC_DAC_LRCLK_CTRL_DIV,
-						 64 - 1));
+	snd_soc_component_update_bits(component, AIU_CLK_CTRL_MORE,
+				      AIU_CLK_CTRL_MORE_I2S_DIV,
+				      FIELD_PREP(AIU_CLK_CTRL_MORE_I2S_DIV,
+						 0));
 
-	/* Use CLK_MORE for mclk to bclk divider */
-	snd_soc_component_update_bits(component, AIU_CLK_CTRL,
-				      AIU_CLK_CTRL_I2S_DIV, 0);
+	return 0;
+}
 
+static int aiu_encoder_i2s_set_more_div(struct snd_soc_component *component,
+					struct snd_pcm_hw_params *params,
+					unsigned int bs)
+{
 	/*
 	 * NOTE: this HW is odd.
 	 * In most configuration, the i2s divider is 'mclk / blck'.
@@ -146,7 +152,6 @@ static int aiu_encoder_i2s_set_clocks(struct snd_soc_component *component,
 	 * increased by 50% to get the correct output rate.
 	 * No idea why !
 	 */
-	bs = fs / 64;
 	if (params_width(params) == 16 && params_channels(params) == 8) {
 		if (bs % 2) {
 			dev_err(component->dev,
@@ -156,11 +161,54 @@ static int aiu_encoder_i2s_set_clocks(struct snd_soc_component *component,
 		bs += bs / 2;
 	}
 
+	/* Use CLK_MORE for mclk to bclk divider */
+	snd_soc_component_update_bits(component, AIU_CLK_CTRL,
+				      AIU_CLK_CTRL_I2S_DIV,
+				      FIELD_PREP(AIU_CLK_CTRL_I2S_DIV, 0));
+
 	snd_soc_component_update_bits(component, AIU_CLK_CTRL_MORE,
 				      AIU_CLK_CTRL_MORE_I2S_DIV,
 				      FIELD_PREP(AIU_CLK_CTRL_MORE_I2S_DIV,
 						 bs - 1));
 
+	return 0;
+}
+
+static int aiu_encoder_i2s_set_clocks(struct snd_soc_component *component,
+				      struct snd_pcm_hw_params *params)
+{
+	struct aiu *aiu = snd_soc_component_get_drvdata(component);
+	unsigned int srate = params_rate(params);
+	unsigned int fs, bs;
+	int ret;
+
+	/* Get the oversampling factor */
+	fs = DIV_ROUND_CLOSEST(clk_get_rate(aiu->i2s.clks[MCLK].clk), srate);
+
+	if (fs % 64)
+		return -EINVAL;
+
+	/* Send data MSB first */
+	snd_soc_component_update_bits(component, AIU_I2S_DAC_CFG,
+				      AIU_I2S_DAC_CFG_MSB_FIRST,
+				      AIU_I2S_DAC_CFG_MSB_FIRST);
+
+	/* Set bclk to lrlck ratio */
+	snd_soc_component_update_bits(component, AIU_CODEC_DAC_LRCLK_CTRL,
+				      AIU_CODEC_DAC_LRCLK_CTRL_DIV,
+				      FIELD_PREP(AIU_CODEC_DAC_LRCLK_CTRL_DIV,
+						 64 - 1));
+
+	bs = fs / 64;
+
+	if (aiu->platform->has_clk_ctrl_more_i2s_div)
+		ret = aiu_encoder_i2s_set_more_div(component, params, bs);
+	else
+		ret = aiu_encoder_i2s_set_legacy_div(component, params, bs);
+
+	if (ret)
+		return ret;
+
 	/* Make sure amclk is used for HDMI i2s as well */
 	snd_soc_component_update_bits(component, AIU_CLK_CTRL_MORE,
 				      AIU_CLK_CTRL_MORE_HDMI_AMCLK,
diff --git a/sound/soc/meson/aiu.c b/sound/soc/meson/aiu.c
index 38209312a8c3..dc35ca79021c 100644
--- a/sound/soc/meson/aiu.c
+++ b/sound/soc/meson/aiu.c
@@ -351,15 +351,24 @@ static int aiu_remove(struct platform_device *pdev)
 
 static const struct aiu_platform_data aiu_gxbb_pdata = {
 	.has_acodec = false,
+	.has_clk_ctrl_more_i2s_div = true,
 };
 
 static const struct aiu_platform_data aiu_gxl_pdata = {
 	.has_acodec = true,
+	.has_clk_ctrl_more_i2s_div = true,
+};
+
+static const struct aiu_platform_data aiu_meson8_pdata = {
+	.has_acodec = false,
+	.has_clk_ctrl_more_i2s_div = false,
 };
 
 static const struct of_device_id aiu_of_match[] = {
 	{ .compatible = "amlogic,aiu-gxbb", .data = &aiu_gxbb_pdata },
 	{ .compatible = "amlogic,aiu-gxl", .data = &aiu_gxl_pdata },
+	{ .compatible = "amlogic,aiu-meson8", .data = &aiu_meson8_pdata },
+	{ .compatible = "amlogic,aiu-meson8b", .data = &aiu_meson8_pdata },
 	{}
 };
 MODULE_DEVICE_TABLE(of, aiu_of_match);
diff --git a/sound/soc/meson/aiu.h b/sound/soc/meson/aiu.h
index ab003638d5e5..87aa19ac4af3 100644
--- a/sound/soc/meson/aiu.h
+++ b/sound/soc/meson/aiu.h
@@ -29,6 +29,7 @@ struct aiu_interface {
 
 struct aiu_platform_data {
 	bool has_acodec;
+	bool has_clk_ctrl_more_i2s_div;
 };
 
 struct aiu {
-- 
2.25.1

