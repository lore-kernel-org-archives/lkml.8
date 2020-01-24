Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BCAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6902520704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rh4pzNcE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389400AbgAXQSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 11:18:18 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46035 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387404AbgAXQSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 11:18:18 -0500
Received: by mail-pg1-f195.google.com with SMTP id b9so1303358pgk.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 08:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f6i3qjBek5P+NveIU0YQzN4nK3tWw+6Ug6MXdr38uao=;
        b=Rh4pzNcESgyXtUh2ki3NH63xAon46/zrP/Zp20KOzIa7Vwo88jJuk8a3lnUuh4Pmzz
         uUOFGBSriMWGxriM/+4XQ4FJAlgZkaH7eej4U7nU4D+6MOgo76OkPbhqbcY/CWsQj0Vp
         bF2rHYax/iXjdl9qPLKxmqoM0CP0ZRyDAFpS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f6i3qjBek5P+NveIU0YQzN4nK3tWw+6Ug6MXdr38uao=;
        b=q6X0cJ70RS567v5m8WKNIqNIBT7TvkSzYOb/FfhqdznsFtMvuzb7247hzvELp/Zzhh
         U/f9tf/D0JnKmH2VhKFtF9nbGxrXDoFiC7RhDL69Hu+TYXR4o+eAfS0+kUYdKAEJ+bLc
         0eyHCyUiKDAUl5XY/Vjobj0Kc6E8UpE+RQpRwenSsXl7J5RdLbVhp89qXYhsumNy2NR2
         k2UiGAHvP2/XBt4YjV5UxQiH8pTAHtjIb5vZt39aepgunlBCgFhbfvVltuEgDjrrK+ky
         CwtAs/flUWf78oxmajCA7Q4CadAVrhRSDDm/DWk7yt7HndQUY4kTVlqkmWLspNLh6tIm
         n0ug==
X-Gm-Message-State: APjAAAUov8mQLxABC01DCshfa0FYn71mJKNVHH2y/M/l2J4hulWbkVOV
        cJ/06iko5U2FrG3OIF7y1zBl8lrI6VY=
X-Google-Smtp-Source: APXvYqxOxWS2JFEnZTuQvzzGNNfukoeOa2gGdxXOJSQTyxqm6DlGO6lxpD1iRhJ8g/CnVqTANck5/w==
X-Received: by 2002:a63:5525:: with SMTP id j37mr4778283pgb.180.1579882697143;
        Fri, 24 Jan 2020 08:18:17 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:845f:e35d:e30c:4b47])
        by smtp.gmail.com with ESMTPSA id s7sm7429120pjk.22.2020.01.24.08.18.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 08:18:16 -0800 (PST)
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Cheng-Yi Chiang <cychiang@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benson Leung <bleung@chromium.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>
Subject: [PATCH] ASoC: cros_ec_codec: Support setting bclk ratio
Date:   Sat, 25 Jan 2020 00:18:11 +0800
Message-Id: <20200124161811.105623-1-yuhsuan@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support setting bclk ratio from machine drivers.

Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
---
 sound/soc/codecs/cros_ec_codec.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index 6a24f570c5e86f..818a405fbc44ff 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -42,6 +42,8 @@ struct cros_ec_codec_priv {
 	uint64_t ap_shm_addr;
 	uint64_t ap_shm_last_alloc;
 
+	uint32_t i2s_rx_bclk_ratio;
+
 	/* DMIC */
 	atomic_t dmic_probed;
 
@@ -259,6 +261,7 @@ static int i2s_rx_hw_params(struct snd_pcm_substream *substream,
 		snd_soc_component_get_drvdata(component);
 	struct ec_param_ec_codec_i2s_rx p;
 	enum ec_codec_i2s_rx_sample_depth depth;
+	uint32_t bclk;
 	int ret;
 
 	if (params_rate(params) != 48000)
@@ -284,15 +287,30 @@ static int i2s_rx_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	dev_dbg(component->dev, "set bclk to %u\n",
-		snd_soc_params_to_bclk(params));
+	/* If the blck ratio is not set, get bclk from hw_params. */
+	if (priv->i2s_rx_bclk_ratio)
+		bclk = params_rate(params) * priv->i2s_rx_bclk_ratio;
+	else
+		bclk = snd_soc_params_to_bclk(params);
+
+	dev_dbg(component->dev, "set bclk to %u\n", bclk);
 
 	p.cmd = EC_CODEC_I2S_RX_SET_BCLK;
-	p.set_bclk_param.bclk = snd_soc_params_to_bclk(params);
+	p.set_bclk_param.bclk = bclk;
 	return send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_I2S_RX,
 				    (uint8_t *)&p, sizeof(p), NULL, 0);
 }
 
+static int i2s_rx_set_bclk_ratio(struct snd_soc_dai *dai, unsigned int ratio)
+{
+	struct snd_soc_component *component = dai->component;
+	struct cros_ec_codec_priv *priv =
+		snd_soc_component_get_drvdata(component);
+
+	priv->i2s_rx_bclk_ratio = ratio;
+	return 0;
+}
+
 static int i2s_rx_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_component *component = dai->component;
@@ -340,6 +358,7 @@ static int i2s_rx_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 static const struct snd_soc_dai_ops i2s_rx_dai_ops = {
 	.hw_params = i2s_rx_hw_params,
 	.set_fmt = i2s_rx_set_fmt,
+	.set_bclk_ratio = i2s_rx_set_bclk_ratio,
 };
 
 static int i2s_rx_event(struct snd_soc_dapm_widget *w,
-- 
2.25.0.341.g760bfbb309-goog

