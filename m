Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B37C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F5D20708
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IMFrpYrs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgA3Ue6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:34:58 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34433 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgA3Ue6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 15:34:58 -0500
Received: by mail-pl1-f195.google.com with SMTP id j7so1794863plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 12:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xIBLIja+ndS5AxMN3F+B+9BHNQrH87Ijr0ahHedqz3M=;
        b=IMFrpYrs7XP1XyZlJnVJbQ6QlHJxE8i0riwPj0dI/NkxkSw44FPxjZZYFGaYXCy66X
         LPXlEwMui8Lu6WvIxbsK2BwxwZTwSVgNBe8nEEoOx9Cx9nklY0Nqs/tPDt3x0xvOUNOT
         jGER95TOVm77tDVo/UO+nhcdg3f9Abmnk4tb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xIBLIja+ndS5AxMN3F+B+9BHNQrH87Ijr0ahHedqz3M=;
        b=f8+RU7aSDBLjYZ9Krh5cJLIx/X0suMQpjBRxvJR0uW/dAUt1IZzs+EpWTQtEPESxBM
         uWaJlDMTurzij4UDc8ZrYixg5ylHP6FLztqtPlHnjDUIYZJcwWbNjVhJRCIdq+DTxVRw
         73Ez9HtDAD4Hzdq8N1keB93OBHaNkH2j9JWN9SPQvV0LwPbl7JRnL49IrxnBKAc9qdGT
         KTQb2ZETTGbj2qvq+FUMDq6Q68zevpSou1EXucvkExkjv2K1bs7hlD53uZjTA3wdwinu
         Rp0FUh6zAed0dBVEb7Ni5dbSLBQ/wgMm3hTrM1jlrJxsU8hx/A6NsmeDTYKOAWFeOqI0
         VJdw==
X-Gm-Message-State: APjAAAW7A+CgNrWBF/DijCTJ2247m9sAbyV4w62Q+46BLqJEFoLlKpnw
        ka10c8o0UXeSAhSErVdHw3PUuAcBqcUXIQ==
X-Google-Smtp-Source: APXvYqzPJ14sLr/VvKzgKGNecSz8sayW4zofhv8W5rLMSxCXjluwZOiLdwwNvhsjBctsx5JgkIZ6tA==
X-Received: by 2002:a17:902:7449:: with SMTP id e9mr6241556plt.139.1580416497238;
        Thu, 30 Jan 2020 12:34:57 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id q12sm7469321pfh.158.2020.01.30.12.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:34:56 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benson Leung <bleung@chromium.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...)
Subject: [PATCH 11/17] ASoC: cros_ec_codec: Use cros_ec_send_cmd_msg()
Date:   Thu, 30 Jan 2020 12:30:56 -0800
Message-Id: <20200130203106.201894-12-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200130203106.201894-1-pmalani@chromium.org>
References: <20200130203106.201894-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace send_ec_host_command() with cros_ec_send_cmd_msg() which does
the same thing, but is defined in a common location in platform/chrome
and exposed for other modules to use. This allows us to remove
send_ec_host_command() entirely.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 sound/soc/codecs/cros_ec_codec.c | 71 ++++++++++----------------------
 1 file changed, 21 insertions(+), 50 deletions(-)

diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index 6a24f570c5e86f..49adb07d766963 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -69,38 +69,6 @@ static int ec_codec_capable(struct cros_ec_codec_priv *priv, uint8_t cap)
 	return priv->ec_capabilities & BIT(cap);
 }
 
-static int send_ec_host_command(struct cros_ec_device *ec_dev, uint32_t cmd,
-				uint8_t *out, size_t outsize,
-				uint8_t *in, size_t insize)
-{
-	int ret;
-	struct cros_ec_command *msg;
-
-	msg = kmalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	msg->version = 0;
-	msg->command = cmd;
-	msg->outsize = outsize;
-	msg->insize = insize;
-
-	if (outsize)
-		memcpy(msg->data, out, outsize);
-
-	ret = cros_ec_cmd_xfer_status(ec_dev, msg);
-	if (ret < 0)
-		goto error;
-
-	if (insize)
-		memcpy(in, msg->data, insize);
-
-	ret = 0;
-error:
-	kfree(msg);
-	return ret;
-}
-
 static int calculate_sha256(struct cros_ec_codec_priv *priv,
 			    uint8_t *buf, uint32_t size, uint8_t *digest)
 {
@@ -149,7 +117,7 @@ static int dmic_get_gain(struct snd_kcontrol *kcontrol,
 
 	p.cmd = EC_CODEC_DMIC_GET_GAIN_IDX;
 	p.get_gain_idx_param.channel = EC_CODEC_DMIC_CHANNEL_0;
-	ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_DMIC,
+	ret = cros_ec_send_cmd_msg(priv->ec_device, 0, EC_CMD_EC_CODEC_DMIC,
 				   (uint8_t *)&p, sizeof(p),
 				   (uint8_t *)&r, sizeof(r));
 	if (ret < 0)
@@ -158,7 +126,7 @@ static int dmic_get_gain(struct snd_kcontrol *kcontrol,
 
 	p.cmd = EC_CODEC_DMIC_GET_GAIN_IDX;
 	p.get_gain_idx_param.channel = EC_CODEC_DMIC_CHANNEL_1;
-	ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_DMIC,
+	ret = cros_ec_send_cmd_msg(priv->ec_device, 0, EC_CMD_EC_CODEC_DMIC,
 				   (uint8_t *)&p, sizeof(p),
 				   (uint8_t *)&r, sizeof(r));
 	if (ret < 0)
@@ -191,7 +159,7 @@ static int dmic_put_gain(struct snd_kcontrol *kcontrol,
 	p.cmd = EC_CODEC_DMIC_SET_GAIN_IDX;
 	p.set_gain_idx_param.channel = EC_CODEC_DMIC_CHANNEL_0;
 	p.set_gain_idx_param.gain = left;
-	ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_DMIC,
+	ret = cros_ec_send_cmd_msg(priv->ec_device, 0, EC_CMD_EC_CODEC_DMIC,
 				   (uint8_t *)&p, sizeof(p), NULL, 0);
 	if (ret < 0)
 		return ret;
@@ -199,7 +167,7 @@ static int dmic_put_gain(struct snd_kcontrol *kcontrol,
 	p.cmd = EC_CODEC_DMIC_SET_GAIN_IDX;
 	p.set_gain_idx_param.channel = EC_CODEC_DMIC_CHANNEL_1;
 	p.set_gain_idx_param.gain = right;
-	return send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_DMIC,
+	return cros_ec_send_cmd_msg(priv->ec_device, 0, EC_CMD_EC_CODEC_DMIC,
 				    (uint8_t *)&p, sizeof(p), NULL, 0);
 }
 
@@ -231,7 +199,7 @@ static int dmic_probe(struct snd_soc_component *component)
 
 	p.cmd = EC_CODEC_DMIC_GET_MAX_GAIN;
 
-	ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_DMIC,
+	ret = cros_ec_send_cmd_msg(priv->ec_device, 0, EC_CMD_EC_CODEC_DMIC,
 				   (uint8_t *)&p, sizeof(p),
 				   (uint8_t *)&r, sizeof(r));
 	if (ret < 0) {
@@ -279,7 +247,7 @@ static int i2s_rx_hw_params(struct snd_pcm_substream *substream,
 
 	p.cmd = EC_CODEC_I2S_RX_SET_SAMPLE_DEPTH;
 	p.set_sample_depth_param.depth = depth;
-	ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_I2S_RX,
+	ret = cros_ec_send_cmd_msg(priv->ec_device, 0, EC_CMD_EC_CODEC_I2S_RX,
 				   (uint8_t *)&p, sizeof(p), NULL, 0);
 	if (ret < 0)
 		return ret;
@@ -289,7 +257,7 @@ static int i2s_rx_hw_params(struct snd_pcm_substream *substream,
 
 	p.cmd = EC_CODEC_I2S_RX_SET_BCLK;
 	p.set_bclk_param.bclk = snd_soc_params_to_bclk(params);
-	return send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_I2S_RX,
+	return cros_ec_send_cmd_msg(priv->ec_device, 0, EC_CMD_EC_CODEC_I2S_RX,
 				    (uint8_t *)&p, sizeof(p), NULL, 0);
 }
 
@@ -333,7 +301,7 @@ static int i2s_rx_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 
 	p.cmd = EC_CODEC_I2S_RX_SET_DAIFMT;
 	p.set_daifmt_param.daifmt = daifmt;
-	return send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_I2S_RX,
+	return cros_ec_send_cmd_msg(priv->ec_device, 0, EC_CMD_EC_CODEC_I2S_RX,
 				    (uint8_t *)&p, sizeof(p), NULL, 0);
 }
 
@@ -364,7 +332,7 @@ static int i2s_rx_event(struct snd_soc_dapm_widget *w,
 		return 0;
 	}
 
-	return send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_I2S_RX,
+	return cros_ec_send_cmd_msg(priv->ec_device, 0, EC_CMD_EC_CODEC_I2S_RX,
 				    (uint8_t *)&p, sizeof(p), NULL, 0);
 }
 
@@ -415,7 +383,7 @@ static void *wov_map_shm(struct cros_ec_codec_priv *priv,
 
 	p.cmd = EC_CODEC_GET_SHM_ADDR;
 	p.get_shm_addr_param.shm_id = shm_id;
-	if (send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC,
+	if (cros_ec_send_cmd_msg(priv->ec_device, 0, EC_CMD_EC_CODEC,
 				 (uint8_t *)&p, sizeof(p),
 				 (uint8_t *)&r, sizeof(r)) < 0) {
 		dev_err(priv->dev, "failed to EC_CODEC_GET_SHM_ADDR\n");
@@ -453,7 +421,7 @@ static void *wov_map_shm(struct cros_ec_codec_priv *priv,
 		p.set_shm_addr_param.phys_addr = priv->ap_shm_last_alloc;
 		p.set_shm_addr_param.len = req;
 		p.set_shm_addr_param.shm_id = shm_id;
-		if (send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC,
+		if (cros_ec_send_cmd_msg(priv->ec_device, 0, EC_CMD_EC_CODEC,
 					 (uint8_t *)&p, sizeof(p),
 					 NULL, 0) < 0) {
 			dev_err(priv->dev, "failed to EC_CODEC_SET_SHM_ADDR\n");
@@ -571,7 +539,7 @@ static int wov_read_audio_shm(struct cros_ec_codec_priv *priv)
 	int ret;
 
 	p.cmd = EC_CODEC_WOV_READ_AUDIO_SHM;
-	ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_WOV,
+	ret = cros_ec_send_cmd_msg(priv->ec_device, 0, EC_CMD_EC_CODEC_WOV,
 				   (uint8_t *)&p, sizeof(p),
 				   (uint8_t *)&r, sizeof(r));
 	if (ret) {
@@ -596,7 +564,8 @@ static int wov_read_audio(struct cros_ec_codec_priv *priv)
 
 	while (remain >= 0) {
 		p.cmd = EC_CODEC_WOV_READ_AUDIO;
-		ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_WOV,
+		ret = cros_ec_send_cmd_msg(priv->ec_device, 0,
+					   EC_CMD_EC_CODEC_WOV,
 					   (uint8_t *)&p, sizeof(p),
 					   (uint8_t *)&r, sizeof(r));
 		if (ret) {
@@ -669,7 +638,8 @@ static int wov_enable_put(struct snd_kcontrol *kcontrol,
 		else
 			p.cmd = EC_CODEC_WOV_DISABLE;
 
-		ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_WOV,
+		ret = cros_ec_send_cmd_msg(priv->ec_device, 0,
+					   EC_CMD_EC_CODEC_WOV,
 					   (uint8_t *)&p, sizeof(p), NULL, 0);
 		if (ret) {
 			dev_err(priv->dev, "failed to %s wov\n",
@@ -716,7 +686,7 @@ static int wov_set_lang_shm(struct cros_ec_codec_priv *priv,
 	p.cmd = EC_CODEC_WOV_SET_LANG_SHM;
 	memcpy(pp->hash, digest, SHA256_DIGEST_SIZE);
 	pp->total_len = size;
-	ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_WOV,
+	ret = cros_ec_send_cmd_msg(priv->ec_device, 0, EC_CMD_EC_CODEC_WOV,
 				   (uint8_t *)&p, sizeof(p), NULL, 0);
 	if (ret) {
 		dev_err(priv->dev, "failed to EC_CODEC_WOV_SET_LANG_SHM\n");
@@ -743,7 +713,8 @@ static int wov_set_lang(struct cros_ec_codec_priv *priv,
 		pp->offset = i;
 		memcpy(pp->buf, buf + i, req);
 		pp->len = req;
-		ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_WOV,
+		ret = cros_ec_send_cmd_msg(priv->ec_device, 0,
+					   EC_CMD_EC_CODEC_WOV,
 					   (uint8_t *)&p, sizeof(p), NULL, 0);
 		if (ret) {
 			dev_err(priv->dev, "failed to EC_CODEC_WOV_SET_LANG\n");
@@ -782,7 +753,7 @@ static int wov_hotword_model_put(struct snd_kcontrol *kcontrol,
 		goto leave;
 
 	p.cmd = EC_CODEC_WOV_GET_LANG;
-	ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_WOV,
+	ret = cros_ec_send_cmd_msg(priv->ec_device, 0, EC_CMD_EC_CODEC_WOV,
 				   (uint8_t *)&p, sizeof(p),
 				   (uint8_t *)&r, sizeof(r));
 	if (ret)
@@ -1020,7 +991,7 @@ static int cros_ec_codec_platform_probe(struct platform_device *pdev)
 	atomic_set(&priv->dmic_probed, 0);
 
 	p.cmd = EC_CODEC_GET_CAPABILITIES;
-	ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC,
+	ret = cros_ec_send_cmd_msg(priv->ec_device, 0, EC_CMD_EC_CODEC,
 				   (uint8_t *)&p, sizeof(p),
 				   (uint8_t *)&r, sizeof(r));
 	if (ret) {
-- 
2.25.0.341.g760bfbb309-goog

