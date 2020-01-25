Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A69C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 16:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811AE20704
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 16:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JvpSxx+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgAYQ3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 11:29:25 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:56024 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgAYQ3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 11:29:25 -0500
Received: by mail-pj1-f68.google.com with SMTP id d5so1179920pjz.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 08:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fXSQKIL0dD1lYRTOFFY91TxyyI+2c+Y8mAqJiNtHVic=;
        b=JvpSxx+9/xqNSJz/0zgTcvMvolZtJ36685E1qTXtSngk3q8URPaOJgMbUK4wc4RefI
         42SkhywCIKUxSg74BRA6M+NjdT2S+rX5U/ET8beCzYf1XQ/Qw8057ridYk+PUMH0OsLy
         a7+NqmjzrpXp0ZjeLSEhXBcyHxBxhmfEsiBQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fXSQKIL0dD1lYRTOFFY91TxyyI+2c+Y8mAqJiNtHVic=;
        b=DDBSTWiFyGxI+0tbwnLCvbx42tOoVlmpdGsDx2+1JC2DznzwDhWa5Bcq8UPAeDaHx/
         aGuu3tSuqd/wVIInyJuKzYRzuzHfZa6JYo9Si4fBeZzJxoM7mGtbAIp36OIteZkGGjIs
         eE54d12Cv88LXjv3VxaCDquoEu8+PtmhzvejPo+lPrgqQjD22UfKBZs7zv0i6gLHPnGr
         4HZPhggbT871Vvsn1QvExKCbdIftMUzran0kNct4B5kmzPrR1zD/lh1ANPs27IMsjEZF
         fpfl0z02DaUWZoMVLyQ/2xGCXMBlJaxbuOr4uyqDyopXrXyRQeUuIAf1QYNaiGTuMxhN
         +U1A==
X-Gm-Message-State: APjAAAVuXfcFy83d4i0+gDqc6UxJt0GRRh2a615I8v8ZgXSzwANyPg3/
        NRd+6N+15iuPqZhslsxrIKutOln3LYE=
X-Google-Smtp-Source: APXvYqyjV2myEfqJK1IkglNqdu1mwxuHAB6eLXyslJQN4SjW4cncyTdA+1I5fvL709lRy4xbY9cnfA==
X-Received: by 2002:a17:902:b107:: with SMTP id q7mr1935912plr.343.1579969764135;
        Sat, 25 Jan 2020 08:29:24 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:845f:e35d:e30c:4b47])
        by smtp.gmail.com with ESMTPSA id r20sm10487339pgu.89.2020.01.25.08.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2020 08:29:23 -0800 (PST)
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
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH v2] ASoC: cros_ec_codec: Support setting bclk ratio
Date:   Sun, 26 Jan 2020 00:29:17 +0800
Message-Id: <20200125162917.247485-1-yuhsuan@chromium.org>
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
index 6a24f570c5e86f..d3dc42aa682565 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -45,6 +45,9 @@ struct cros_ec_codec_priv {
 	/* DMIC */
 	atomic_t dmic_probed;
 
+	/* I2S_RX */
+	uint32_t i2s_rx_bclk_ratio;
+
 	/* WoV */
 	bool wov_enabled;
 	uint8_t *wov_audio_shm_p;
@@ -259,6 +262,7 @@ static int i2s_rx_hw_params(struct snd_pcm_substream *substream,
 		snd_soc_component_get_drvdata(component);
 	struct ec_param_ec_codec_i2s_rx p;
 	enum ec_codec_i2s_rx_sample_depth depth;
+	uint32_t bclk;
 	int ret;
 
 	if (params_rate(params) != 48000)
@@ -284,15 +288,29 @@ static int i2s_rx_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	dev_dbg(component->dev, "set bclk to %u\n",
-		snd_soc_params_to_bclk(params));
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

