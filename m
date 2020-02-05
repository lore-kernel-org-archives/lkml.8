Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1A3C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D99720730
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UPgujWka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgBETPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 14:15:04 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42758 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgBETPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 14:15:04 -0500
Received: by mail-pl1-f194.google.com with SMTP id e8so1262639plt.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 11:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Au7vyzp7l2LzZghmAjt7fLaBwN+1gtH+DoV5Fi0iNs=;
        b=UPgujWkaUyq4Fm2bZm8MTevViA78PsBnVMJ846OvkIxXtx11SQcVqrHnDP9xn8xzqk
         AwZ6C9psjdQhnF21RL15+d/RXPMvQm+s0DFdbFPopibDyysyg5tya+HZWfbfWMTenljB
         OP9PLi4qjb+OWavPkCmeUfE+c9hPXD46Y9B8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Au7vyzp7l2LzZghmAjt7fLaBwN+1gtH+DoV5Fi0iNs=;
        b=bcglYXk9pRL5FRaeAAS84+m6MGUHyA0k5/sFff6SXiHNXnUSIrS6wtuL0XvJlDSmge
         4guPCLZ+/NeyI/71o7CrSICiH7FC53gsWl5qJyPmnAamdCbQOgibmvMhb7K/qn8w6wWl
         268qCKQntzpCqH+3xulbmCCsYrXrW0SUmykAjh6+jFQ+TUPz0+rHVJXszzGpEUS3LpLZ
         ky93V5IzUorR8qL5fFGfWYYPW3cn64Q9v+MDtZTHO+QiwjjgWmnfVScx/20YE31DGf3Q
         umsi/LEGSGO0rpYaaR8JIbS5W8FQvUy3rEx1jQF9ansCaQsB2XIf0UI1WgspkYhe5rFP
         d+Yw==
X-Gm-Message-State: APjAAAU0GBXGFQ1yJh/exss1atukV0wRB2XLvbPw5hn+mJZbu+2rv/I9
        G+3rC/9LTP6GX2Cuo/HPaC8R02JVKcQ=
X-Google-Smtp-Source: APXvYqzsjFJdUq2dQRQEBZgCnMW+01KFo+QQdIKRxFr72pSEntwurTGr8lW0FWH4D1quKkcvS6AfVQ==
X-Received: by 2002:a17:90b:4004:: with SMTP id ie4mr7299409pjb.49.1580930101392;
        Wed, 05 Feb 2020 11:15:01 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id u23sm257224pfm.29.2020.02.05.11.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 11:15:00 -0800 (PST)
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
Subject: [PATCH v2 11/17] ASoC: cros_ec_codec: Use cros_ec_cmd()
Date:   Wed,  5 Feb 2020 11:00:16 -0800
Message-Id: <20200205190028.183069-12-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200205190028.183069-1-pmalani@chromium.org>
References: <20200205190028.183069-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace send_ec_host_command() with cros_ec_cmd() which does the same
thing, but is defined in a common location in platform/chrome and
exposed for other modules to use. This allows us to remove
send_ec_host_command() entirely.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- Updated to use new function name and parameter list.

 sound/soc/codecs/cros_ec_codec.c | 119 +++++++++++--------------------
 1 file changed, 42 insertions(+), 77 deletions(-)

diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index 6a24f570c5e86f..8516ba5f7624f8 100644
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
@@ -149,18 +117,18 @@ static int dmic_get_gain(struct snd_kcontrol *kcontrol,
 
 	p.cmd = EC_CODEC_DMIC_GET_GAIN_IDX;
 	p.get_gain_idx_param.channel = EC_CODEC_DMIC_CHANNEL_0;
-	ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_DMIC,
-				   (uint8_t *)&p, sizeof(p),
-				   (uint8_t *)&r, sizeof(r));
+	ret = cros_ec_cmd(priv->ec_device, 0, EC_CMD_EC_CODEC_DMIC,
+			  (uint8_t *)&p, sizeof(p), (uint8_t *)&r, sizeof(r),
+			  NULL);
 	if (ret < 0)
 		return ret;
 	ucontrol->value.integer.value[0] = r.gain;
 
 	p.cmd = EC_CODEC_DMIC_GET_GAIN_IDX;
 	p.get_gain_idx_param.channel = EC_CODEC_DMIC_CHANNEL_1;
-	ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_DMIC,
-				   (uint8_t *)&p, sizeof(p),
-				   (uint8_t *)&r, sizeof(r));
+	ret = cros_ec_cmd(priv->ec_device, 0, EC_CMD_EC_CODEC_DMIC,
+			  (uint8_t *)&p, sizeof(p), (uint8_t *)&r, sizeof(r),
+			  NULL);
 	if (ret < 0)
 		return ret;
 	ucontrol->value.integer.value[1] = r.gain;
@@ -191,16 +159,16 @@ static int dmic_put_gain(struct snd_kcontrol *kcontrol,
 	p.cmd = EC_CODEC_DMIC_SET_GAIN_IDX;
 	p.set_gain_idx_param.channel = EC_CODEC_DMIC_CHANNEL_0;
 	p.set_gain_idx_param.gain = left;
-	ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_DMIC,
-				   (uint8_t *)&p, sizeof(p), NULL, 0);
+	ret = cros_ec_cmd(priv->ec_device, 0, EC_CMD_EC_CODEC_DMIC,
+			  (uint8_t *)&p, sizeof(p), NULL, 0, NULL);
 	if (ret < 0)
 		return ret;
 
 	p.cmd = EC_CODEC_DMIC_SET_GAIN_IDX;
 	p.set_gain_idx_param.channel = EC_CODEC_DMIC_CHANNEL_1;
 	p.set_gain_idx_param.gain = right;
-	return send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_DMIC,
-				    (uint8_t *)&p, sizeof(p), NULL, 0);
+	return cros_ec_cmd(priv->ec_device, 0, EC_CMD_EC_CODEC_DMIC,
+			   (uint8_t *)&p, sizeof(p), NULL, 0, NULL);
 }
 
 static const DECLARE_TLV_DB_SCALE(dmic_gain_tlv, 0, 100, 0);
@@ -231,9 +199,9 @@ static int dmic_probe(struct snd_soc_component *component)
 
 	p.cmd = EC_CODEC_DMIC_GET_MAX_GAIN;
 
-	ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_DMIC,
-				   (uint8_t *)&p, sizeof(p),
-				   (uint8_t *)&r, sizeof(r));
+	ret = cros_ec_cmd(priv->ec_device, 0, EC_CMD_EC_CODEC_DMIC,
+			  (uint8_t *)&p, sizeof(p), (uint8_t *)&r, sizeof(r),
+			  NULL);
 	if (ret < 0) {
 		dev_warn(dev, "get_max_gain() unsupported\n");
 		return 0;
@@ -279,8 +247,8 @@ static int i2s_rx_hw_params(struct snd_pcm_substream *substream,
 
 	p.cmd = EC_CODEC_I2S_RX_SET_SAMPLE_DEPTH;
 	p.set_sample_depth_param.depth = depth;
-	ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_I2S_RX,
-				   (uint8_t *)&p, sizeof(p), NULL, 0);
+	ret = cros_ec_cmd(priv->ec_device, 0, EC_CMD_EC_CODEC_I2S_RX,
+			  (uint8_t *)&p, sizeof(p), NULL, 0, NULL);
 	if (ret < 0)
 		return ret;
 
@@ -289,8 +257,8 @@ static int i2s_rx_hw_params(struct snd_pcm_substream *substream,
 
 	p.cmd = EC_CODEC_I2S_RX_SET_BCLK;
 	p.set_bclk_param.bclk = snd_soc_params_to_bclk(params);
-	return send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_I2S_RX,
-				    (uint8_t *)&p, sizeof(p), NULL, 0);
+	return cros_ec_cmd(priv->ec_device, 0, EC_CMD_EC_CODEC_I2S_RX,
+			   (uint8_t *)&p, sizeof(p), NULL, 0, NULL);
 }
 
 static int i2s_rx_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
@@ -333,8 +301,8 @@ static int i2s_rx_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 
 	p.cmd = EC_CODEC_I2S_RX_SET_DAIFMT;
 	p.set_daifmt_param.daifmt = daifmt;
-	return send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_I2S_RX,
-				    (uint8_t *)&p, sizeof(p), NULL, 0);
+	return cros_ec_cmd(priv->ec_device, 0, EC_CMD_EC_CODEC_I2S_RX,
+			   (uint8_t *)&p, sizeof(p), NULL, 0, NULL);
 }
 
 static const struct snd_soc_dai_ops i2s_rx_dai_ops = {
@@ -364,8 +332,8 @@ static int i2s_rx_event(struct snd_soc_dapm_widget *w,
 		return 0;
 	}
 
-	return send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_I2S_RX,
-				    (uint8_t *)&p, sizeof(p), NULL, 0);
+	return cros_ec_cmd(priv->ec_device, 0, EC_CMD_EC_CODEC_I2S_RX,
+			   (uint8_t *)&p, sizeof(p), NULL, 0, NULL);
 }
 
 static struct snd_soc_dapm_widget i2s_rx_dapm_widgets[] = {
@@ -415,9 +383,8 @@ static void *wov_map_shm(struct cros_ec_codec_priv *priv,
 
 	p.cmd = EC_CODEC_GET_SHM_ADDR;
 	p.get_shm_addr_param.shm_id = shm_id;
-	if (send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC,
-				 (uint8_t *)&p, sizeof(p),
-				 (uint8_t *)&r, sizeof(r)) < 0) {
+	if (cros_ec_cmd(priv->ec_device, 0, EC_CMD_EC_CODEC, (uint8_t *)&p,
+			sizeof(p), (uint8_t *)&r, sizeof(r), NULL) < 0) {
 		dev_err(priv->dev, "failed to EC_CODEC_GET_SHM_ADDR\n");
 		return NULL;
 	}
@@ -453,9 +420,8 @@ static void *wov_map_shm(struct cros_ec_codec_priv *priv,
 		p.set_shm_addr_param.phys_addr = priv->ap_shm_last_alloc;
 		p.set_shm_addr_param.len = req;
 		p.set_shm_addr_param.shm_id = shm_id;
-		if (send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC,
-					 (uint8_t *)&p, sizeof(p),
-					 NULL, 0) < 0) {
+		if (cros_ec_cmd(priv->ec_device, 0, EC_CMD_EC_CODEC,
+				(uint8_t *)&p, sizeof(p), NULL, 0, NULL) < 0) {
 			dev_err(priv->dev, "failed to EC_CODEC_SET_SHM_ADDR\n");
 			return NULL;
 		}
@@ -571,9 +537,9 @@ static int wov_read_audio_shm(struct cros_ec_codec_priv *priv)
 	int ret;
 
 	p.cmd = EC_CODEC_WOV_READ_AUDIO_SHM;
-	ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_WOV,
-				   (uint8_t *)&p, sizeof(p),
-				   (uint8_t *)&r, sizeof(r));
+	ret = cros_ec_cmd(priv->ec_device, 0, EC_CMD_EC_CODEC_WOV,
+			  (uint8_t *)&p, sizeof(p), (uint8_t *)&r, sizeof(r),
+			  NULL);
 	if (ret) {
 		dev_err(priv->dev, "failed to EC_CODEC_WOV_READ_AUDIO_SHM\n");
 		return ret;
@@ -596,9 +562,9 @@ static int wov_read_audio(struct cros_ec_codec_priv *priv)
 
 	while (remain >= 0) {
 		p.cmd = EC_CODEC_WOV_READ_AUDIO;
-		ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_WOV,
-					   (uint8_t *)&p, sizeof(p),
-					   (uint8_t *)&r, sizeof(r));
+		ret = cros_ec_cmd(priv->ec_device, 0, EC_CMD_EC_CODEC_WOV,
+				  (uint8_t *)&p, sizeof(p), (uint8_t *)&r,
+				  sizeof(r), NULL);
 		if (ret) {
 			dev_err(priv->dev,
 				"failed to EC_CODEC_WOV_READ_AUDIO\n");
@@ -669,8 +635,8 @@ static int wov_enable_put(struct snd_kcontrol *kcontrol,
 		else
 			p.cmd = EC_CODEC_WOV_DISABLE;
 
-		ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_WOV,
-					   (uint8_t *)&p, sizeof(p), NULL, 0);
+		ret = cros_ec_cmd(priv->ec_device, 0, EC_CMD_EC_CODEC_WOV,
+				  (uint8_t *)&p, sizeof(p), NULL, 0, NULL);
 		if (ret) {
 			dev_err(priv->dev, "failed to %s wov\n",
 				enabled ? "enable" : "disable");
@@ -716,8 +682,8 @@ static int wov_set_lang_shm(struct cros_ec_codec_priv *priv,
 	p.cmd = EC_CODEC_WOV_SET_LANG_SHM;
 	memcpy(pp->hash, digest, SHA256_DIGEST_SIZE);
 	pp->total_len = size;
-	ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_WOV,
-				   (uint8_t *)&p, sizeof(p), NULL, 0);
+	ret = cros_ec_cmd(priv->ec_device, 0, EC_CMD_EC_CODEC_WOV,
+			  (uint8_t *)&p, sizeof(p), NULL, 0, NULL);
 	if (ret) {
 		dev_err(priv->dev, "failed to EC_CODEC_WOV_SET_LANG_SHM\n");
 		return ret;
@@ -743,8 +709,8 @@ static int wov_set_lang(struct cros_ec_codec_priv *priv,
 		pp->offset = i;
 		memcpy(pp->buf, buf + i, req);
 		pp->len = req;
-		ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_WOV,
-					   (uint8_t *)&p, sizeof(p), NULL, 0);
+		ret = cros_ec_cmd(priv->ec_device, 0, EC_CMD_EC_CODEC_WOV,
+				  (uint8_t *)&p, sizeof(p), NULL, 0, NULL);
 		if (ret) {
 			dev_err(priv->dev, "failed to EC_CODEC_WOV_SET_LANG\n");
 			return ret;
@@ -782,9 +748,9 @@ static int wov_hotword_model_put(struct snd_kcontrol *kcontrol,
 		goto leave;
 
 	p.cmd = EC_CODEC_WOV_GET_LANG;
-	ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_WOV,
-				   (uint8_t *)&p, sizeof(p),
-				   (uint8_t *)&r, sizeof(r));
+	ret = cros_ec_cmd(priv->ec_device, 0, EC_CMD_EC_CODEC_WOV,
+			  (uint8_t *)&p, sizeof(p), (uint8_t *)&r, sizeof(r),
+			  NULL);
 	if (ret)
 		goto leave;
 
@@ -1020,9 +986,8 @@ static int cros_ec_codec_platform_probe(struct platform_device *pdev)
 	atomic_set(&priv->dmic_probed, 0);
 
 	p.cmd = EC_CODEC_GET_CAPABILITIES;
-	ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC,
-				   (uint8_t *)&p, sizeof(p),
-				   (uint8_t *)&r, sizeof(r));
+	ret = cros_ec_cmd(priv->ec_device, 0, EC_CMD_EC_CODEC, (uint8_t *)&p,
+			  sizeof(p), (uint8_t *)&r, sizeof(r), NULL);
 	if (ret) {
 		dev_err(dev, "failed to EC_CODEC_GET_CAPABILITIES\n");
 		return ret;
-- 
2.25.0.341.g760bfbb309-goog

