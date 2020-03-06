Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0E2C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE77208CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vHwDKD8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgCFNCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:02:06 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38747 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgCFNCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:02:06 -0500
Received: by mail-wm1-f66.google.com with SMTP id u9so2287102wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 05:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pUTUKe1ETsrKt03/K8XFrOHiuViiNejQfkx377kvHWs=;
        b=vHwDKD8WnVD4XGaGQWK1nRjEz3HT5MOG0IwqkPkUYSKJ3zNOik7vRThpI8QHYziLGM
         Y+vvyU5kcAjcJa5kMOyPCOTyH0ILFVZNJrb1w7Gbm7Ezvj9C+8X3PW/9Pn9shjowUfBU
         upHnpztrOipG2J3TgYnIfhi+9izI3Ss1XD+RskCSPuCIsLXV02X7ENKkmyJIBQfsj2MM
         QIS8I2i1HteFYou44w6VUzs6Hv9VGFz0lwoFJJPx6uPSoSI8Hk5416hkSHhuAQ0pvTHo
         ouAX++E6x74XgASA1tBqutLnxD9Tba3j2VDqQNF7sTtwePututbASVPiVkKzERIvU6L1
         Qbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pUTUKe1ETsrKt03/K8XFrOHiuViiNejQfkx377kvHWs=;
        b=FhKY5fT3T9N6EeIQvJW81BiHpyTof36jDBYSqwZDRLaA7a3lNx9+D5FKyvElGrcFwE
         0jUzSuCCcXobf0b/sk5Gd9zKM1PYRNWJ7SoUPVZT+LLyb2kSzM1/zT1PIA3YiMjInRWy
         9fiMomQnNBqPigNC26D0W7mo44nnV5MfK8gs+4X/EsVZvwhNfnOVMaizxTf9fZFj7ds4
         XsrwJBfBiq+X2RLH5JIiPY7O9ouAaZVK7q3n6NjXJEG556gNPA4CG7XiMnoltBGhvbgh
         LrpO9bLtOlMrvhTaCeGywZVwqUrMDYiDqzcqdN8NSb+Qc7kC/imhc7zZI+vee0W7r8bZ
         hZAA==
X-Gm-Message-State: ANhLgQ0dZ/retn3hveUnKXeBScMEOX1U7X2Fssx8wWMdmUuNYSYZFa60
        P6OjDRXXx5M4uG2e8V9CaS8bCMd8vHU=
X-Google-Smtp-Source: ADFU+vuqmeh78SXaWsiXYy8hXlNrfLgWnmSHgXkI8A59hRejEmU+31cdoU6sL3oIm2qw7aI5XIZ2yA==
X-Received: by 2002:a1c:41c3:: with SMTP id o186mr3876274wma.27.1583499721445;
        Fri, 06 Mar 2020 05:02:01 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id b5sm3128324wrn.22.2020.03.06.05.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 05:01:59 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takahide Higuchi <takahidehiguchi@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: qcom: lpass-cpu: support full duplex operation
Date:   Fri,  6 Mar 2020 13:01:47 +0000
Message-Id: <20200306130147.27452-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takahide Higuchi <takahidehiguchi@gmail.com>

This patch fixes a bug where playback on bidirectional I2S interface stops
when we start recording on the same interface.

We use regmap_update_bits instead of regmap_write so that we will not clear
SPKEN and SPKMODE bits when we start/stop recording.

Signed-off-by: Takahide Higuchi <takahidehiguchi@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-apq8016.c   |  2 ++
 sound/soc/qcom/lpass-cpu.c       | 24 ++++++++++++++++++------
 sound/soc/qcom/lpass-lpaif-reg.h |  2 +-
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/sound/soc/qcom/lpass-apq8016.c b/sound/soc/qcom/lpass-apq8016.c
index 6575da549237..85079c697faa 100644
--- a/sound/soc/qcom/lpass-apq8016.c
+++ b/sound/soc/qcom/lpass-apq8016.c
@@ -121,6 +121,8 @@ static struct snd_soc_dai_driver apq8016_lpass_cpu_dai_driver[] = {
 		},
 		.probe	= &asoc_qcom_lpass_cpu_dai_probe,
 		.ops    = &asoc_qcom_lpass_cpu_dai_ops,
+		.symmetric_samplebits   = 1,
+		.symmetric_rates        = 1,
 	},
 };
 
diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index dbce7e92baf3..dc8acb380b6f 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -72,6 +72,7 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
 	snd_pcm_format_t format = params_format(params);
 	unsigned int channels = params_channels(params);
 	unsigned int rate = params_rate(params);
+	unsigned int mask;
 	unsigned int regval;
 	int bitwidth, ret;
 
@@ -81,6 +82,9 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
 		return bitwidth;
 	}
 
+	mask   = LPAIF_I2SCTL_LOOPBACK_MASK |
+			LPAIF_I2SCTL_WSSRC_MASK |
+			LPAIF_I2SCTL_BITWIDTH_MASK;
 	regval = LPAIF_I2SCTL_LOOPBACK_DISABLE |
 			LPAIF_I2SCTL_WSSRC_INTERNAL;
 
@@ -100,6 +104,7 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		mask   |= LPAIF_I2SCTL_SPKMODE_MASK | LPAIF_I2SCTL_SPKMONO_MASK;
 		switch (channels) {
 		case 1:
 			regval |= LPAIF_I2SCTL_SPKMODE_SD0;
@@ -127,6 +132,7 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
 			return -EINVAL;
 		}
 	} else {
+		mask   |= LPAIF_I2SCTL_MICMODE_MASK | LPAIF_I2SCTL_MICMONO_MASK;
 		switch (channels) {
 		case 1:
 			regval |= LPAIF_I2SCTL_MICMODE_SD0;
@@ -155,9 +161,9 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
-	ret = regmap_write(drvdata->lpaif_map,
-			   LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id),
-			   regval);
+	ret = regmap_update_bits(drvdata->lpaif_map,
+			 LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id),
+			 mask, regval);
 	if (ret) {
 		dev_err(dai->dev, "error writing to i2sctl reg: %d\n", ret);
 		return ret;
@@ -178,11 +184,17 @@ static int lpass_cpu_daiops_hw_free(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
 	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
+	unsigned int mask;
 	int ret;
 
-	ret = regmap_write(drvdata->lpaif_map,
-			   LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id),
-			   0);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		mask   = LPAIF_I2SCTL_SPKMODE_MASK;
+	else
+		mask   = LPAIF_I2SCTL_MICMODE_MASK;
+
+	ret = regmap_update_bits(drvdata->lpaif_map,
+			 LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id),
+			 mask, 0);
 	if (ret)
 		dev_err(dai->dev, "error writing to i2sctl reg: %d\n", ret);
 
diff --git a/sound/soc/qcom/lpass-lpaif-reg.h b/sound/soc/qcom/lpass-lpaif-reg.h
index 3d74ae123e9d..7a2b9cf99976 100644
--- a/sound/soc/qcom/lpass-lpaif-reg.h
+++ b/sound/soc/qcom/lpass-lpaif-reg.h
@@ -56,7 +56,7 @@
 #define LPAIF_I2SCTL_MICMODE_6CH	(7 << LPAIF_I2SCTL_MICMODE_SHIFT)
 #define LPAIF_I2SCTL_MICMODE_8CH	(8 << LPAIF_I2SCTL_MICMODE_SHIFT)
 
-#define LPAIF_I2SCTL_MIMONO_MASK	GENMASK(3, 3)
+#define LPAIF_I2SCTL_MICMONO_MASK	GENMASK(3, 3)
 #define LPAIF_I2SCTL_MICMONO_SHIFT	3
 #define LPAIF_I2SCTL_MICMONO_STEREO	(0 << LPAIF_I2SCTL_MICMONO_SHIFT)
 #define LPAIF_I2SCTL_MICMONO_MONO	(1 << LPAIF_I2SCTL_MICMONO_SHIFT)
-- 
2.21.0

