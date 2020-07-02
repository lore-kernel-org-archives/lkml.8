Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25AAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93FAF2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yRnF/Wv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgGBLLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbgGBLLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:11:30 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C19C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 04:11:30 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so24682767wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 04:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLcMYFjK2Mqk6sa9STwGNahU8gUOiBKyhyhKpNx5RCk=;
        b=yRnF/Wv4aNROFV4Enx2JD9ld3bfFtQjXtHqsFnXnL1TXProw3IjCOTNur3E01wXR32
         wuLE/5XkxDaiDFtpxgqd+Zw07T4sc7oUtTPAbjBH+Bq7kliSPWpiHkCL5n/U/fv4pR9P
         YZTfla/9XR4cjmqRuVCu65aDkKo2ZyxGcgzSANurMQ5G15fcZmrGmVSkNH0aG9jpPgNy
         M4ojVgTvmmqIoxz8slTPgPVioVncno2LKU/iF2jVAggD6F/3R2tO+UlKPFguFxOTysOC
         4V1+4jvGa7FiWGMNXfS5rK9ymlmdTKJd+BwuJSwMet0QuyvnO2PFiVed/EaJt6l5JXFr
         LbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLcMYFjK2Mqk6sa9STwGNahU8gUOiBKyhyhKpNx5RCk=;
        b=XJC61xFzWy5nWfLJTdJGeXIObJw38VVMrc42nw1j2s63OYu/lMLRY70QtbC1X2J57B
         Po3Yz0mqLOOOGG7822nuTngvVPM+19ydO+7BSox6/eQyX3hth67lyAh/v1HwfRFZNNlC
         DD5l8H7Yc4B8Q3J1s3/dqy+cevKDLNwxdNZiFyVqcp1gAiFJaqwxbdgW3eFfm9Uqu9cP
         RoHicmwzS9FtcqWYB8VJfSEaYEK6FstHueJScxitiTxIzUaNR86Ll31gowJcd0z45nQv
         BGoaO+PLn/N2nh0yogAHJSZ8r7R8f5ByaDsePKxtadcXp7a9mfQP616VXOMqQuJ0ry2b
         cE8A==
X-Gm-Message-State: AOAM533pJWRcEGRixMytUwzy8Aa8STAzWJenUD9350ou2siOXVQhKtQ/
        7y9qshKXufcoS3Xoo1re9eCUeA==
X-Google-Smtp-Source: ABdhPJx7r1YY7c/spG+XRYvMbNqHYb3MKBGWcT/vr7200rSOLM0hv1yy0T3E0RP7FPM4sMSKJNbAug==
X-Received: by 2002:a5d:4e8e:: with SMTP id e14mr29504972wru.134.1593688288645;
        Thu, 02 Jul 2020 04:11:28 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id l190sm10122008wml.12.2020.07.02.04.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 04:11:27 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        ckeepax@opensource.cirrus.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH] ALSA: compress: add support to change codec profile in gapless playback
Date:   Thu,  2 Jul 2020 12:11:14 +0100
Message-Id: <20200702111114.32217-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For gapless playback its possible that each track can have different
codec profile with same decoder, for example we have WMA album,
we may have different tracks as WMA v9, WMA v10 and so on

Existing code does not allow to change this profile while doing gapless
playback.

This patch adds new SNDRV_COMPRESS_SET_CODEC_PARAMS IOCTL to allow
userspace to set this new parameters required for new codec profile.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/sound/compress_driver.h       |  5 +++
 include/sound/soc-component.h         |  3 ++
 include/sound/soc-dai.h               |  5 +++
 include/uapi/sound/compress_offload.h |  1 +
 sound/core/compress_offload.c         | 54 ++++++++++++++++++++++++---
 sound/soc/soc-compress.c              | 30 +++++++++++++++
 sound/soc/soc-dai.c                   | 14 +++++++
 7 files changed, 106 insertions(+), 6 deletions(-)

diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
index 70cbc5095e72..8d23351f7ad7 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -93,6 +93,9 @@ struct snd_compr_stream {
  * @set_params: Sets the compressed stream parameters, mandatory
  * This can be called in during stream creation only to set codec params
  * and the stream properties
+ * @set_codec_params: Sets the compressed stream codec parameters, mandatory
+ * This can be called in during gapless next track codec change only to set
+ * codec params
  * @get_params: retrieve the codec parameters, mandatory
  * @set_metadata: Set the metadata values for a stream
  * @get_metadata: retrieves the requested metadata values from stream
@@ -112,6 +115,8 @@ struct snd_compr_ops {
 	int (*free)(struct snd_compr_stream *stream);
 	int (*set_params)(struct snd_compr_stream *stream,
 			struct snd_compr_params *params);
+	int (*set_codec_params)(struct snd_compr_stream *stream,
+			struct snd_codec *params);
 	int (*get_params)(struct snd_compr_stream *stream,
 			struct snd_codec *params);
 	int (*set_metadata)(struct snd_compr_stream *stream,
diff --git a/include/sound/soc-component.h b/include/sound/soc-component.h
index 5663891148e3..1e69c54ed0b9 100644
--- a/include/sound/soc-component.h
+++ b/include/sound/soc-component.h
@@ -36,6 +36,9 @@ struct snd_compress_ops {
 	int (*get_params)(struct snd_soc_component *component,
 			  struct snd_compr_stream *stream,
 			  struct snd_codec *params);
+	int (*set_codec_params)(struct snd_soc_component *component,
+			  struct snd_compr_stream *stream,
+			  struct snd_codec *params);
 	int (*set_metadata)(struct snd_soc_component *component,
 			    struct snd_compr_stream *stream,
 			    struct snd_compr_metadata *metadata);
diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 212257e84fac..526794ee555b 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -192,6 +192,9 @@ int snd_soc_dai_compr_trigger(struct snd_soc_dai *dai,
 int snd_soc_dai_compr_set_params(struct snd_soc_dai *dai,
 				 struct snd_compr_stream *cstream,
 				 struct snd_compr_params *params);
+int snd_soc_dai_compr_set_codec_params(struct snd_soc_dai *dai,
+				 struct snd_compr_stream *cstream,
+				 struct snd_codec *codec);
 int snd_soc_dai_compr_get_params(struct snd_soc_dai *dai,
 				 struct snd_compr_stream *cstream,
 				 struct snd_codec *params);
@@ -292,6 +295,8 @@ struct snd_soc_cdai_ops {
 			struct snd_soc_dai *);
 	int (*set_params)(struct snd_compr_stream *,
 			struct snd_compr_params *, struct snd_soc_dai *);
+	int (*set_codec_params)(struct snd_compr_stream *,
+			struct snd_codec *, struct snd_soc_dai *);
 	int (*get_params)(struct snd_compr_stream *,
 			struct snd_codec *, struct snd_soc_dai *);
 	int (*set_metadata)(struct snd_compr_stream *,
diff --git a/include/uapi/sound/compress_offload.h b/include/uapi/sound/compress_offload.h
index 7184265c0b0d..c46286113a4b 100644
--- a/include/uapi/sound/compress_offload.h
+++ b/include/uapi/sound/compress_offload.h
@@ -172,6 +172,7 @@ struct snd_compr_metadata {
 						 struct snd_compr_metadata)
 #define SNDRV_COMPRESS_GET_METADATA	_IOWR('C', 0x15,\
 						 struct snd_compr_metadata)
+#define SNDRV_COMPRESS_SET_CODEC_PARAMS	_IOW('C', 0x16, struct snd_codec)
 #define SNDRV_COMPRESS_TSTAMP		_IOR('C', 0x20, struct snd_compr_tstamp)
 #define SNDRV_COMPRESS_AVAIL		_IOR('C', 0x21, struct snd_compr_avail)
 #define SNDRV_COMPRESS_PAUSE		_IO('C', 0x30)
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 0e53f6f31916..1c4b2cf450a0 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -566,6 +566,18 @@ static int snd_compr_allocate_buffer(struct snd_compr_stream *stream,
 	return 0;
 }
 
+static int snd_compress_check_codec_params(struct snd_codec *codec)
+{
+	/* now codec parameters */
+	if (codec->id == 0 || codec->id > SND_AUDIOCODEC_MAX)
+		return -EINVAL;
+
+	if (codec->ch_in == 0 || codec->ch_out == 0)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int snd_compress_check_input(struct snd_compr_params *params)
 {
 	/* first let's check the buffer parameter's */
@@ -574,14 +586,41 @@ static int snd_compress_check_input(struct snd_compr_params *params)
 	    params->buffer.fragments == 0)
 		return -EINVAL;
 
-	/* now codec parameters */
-	if (params->codec.id == 0 || params->codec.id > SND_AUDIOCODEC_MAX)
-		return -EINVAL;
+	return snd_compress_check_codec_params(&params->codec);
 
-	if (params->codec.ch_in == 0 || params->codec.ch_out == 0)
-		return -EINVAL;
+}
 
-	return 0;
+static int snd_compr_set_codec_params(struct snd_compr_stream *stream,
+				      unsigned long arg)
+{
+	struct snd_codec *params;
+	int retval;
+
+	if (!stream->ops->set_codec_params)
+		return -EPERM;
+
+	if (stream->runtime->state != SNDRV_PCM_STATE_RUNNING)
+		return -EPERM;
+
+	/* codec params can be only set when next track has been signalled */
+	if (stream->next_track == false)
+		return -EPERM;
+
+	params = memdup_user((void __user *)arg, sizeof(*params));
+	if (IS_ERR(params))
+		return PTR_ERR(params);
+
+	retval = snd_compress_check_codec_params(params);
+	if (retval)
+		goto out;
+
+	retval = stream->ops->set_codec_params(stream, params);
+	if (retval)
+		goto out;
+
+out:
+	kfree(params);
+	return retval;
 }
 
 static int
@@ -964,6 +1003,9 @@ static long snd_compr_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 	case _IOC_NR(SNDRV_COMPRESS_SET_PARAMS):
 		retval = snd_compr_set_params(stream, arg);
 		break;
+	case _IOC_NR(SNDRV_COMPRESS_SET_CODEC_PARAMS):
+		retval = snd_compr_set_codec_params(stream, arg);
+		break;
 	case _IOC_NR(SNDRV_COMPRESS_GET_PARAMS):
 		retval = snd_compr_get_params(stream, arg);
 		break;
diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 4984b6a2c370..e549e0197aca 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -518,6 +518,34 @@ static int soc_compr_set_params_fe(struct snd_compr_stream *cstream,
 	return ret;
 }
 
+static int soc_compr_set_codec_params(struct snd_compr_stream *cstream,
+				      struct snd_codec *codec)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_soc_component *component;
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	int i, ret;
+
+	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
+
+	ret = snd_soc_dai_compr_set_codec_params(cpu_dai, cstream, codec);
+	if (ret < 0)
+		goto err;
+
+	for_each_rtd_components(rtd, i, component) {
+		if (!component->driver->compress_ops ||
+		    !component->driver->compress_ops->set_codec_params)
+			continue;
+
+		ret = component->driver->compress_ops->set_codec_params(component, cstream,
+								     codec);
+		break;
+	}
+err:
+	mutex_unlock(&rtd->card->pcm_mutex);
+	return ret;
+}
+
 static int soc_compr_get_params(struct snd_compr_stream *cstream,
 				struct snd_codec *params)
 {
@@ -728,6 +756,7 @@ static struct snd_compr_ops soc_compr_ops = {
 	.open		= soc_compr_open,
 	.free		= soc_compr_free,
 	.set_params	= soc_compr_set_params,
+	.set_codec_params = soc_compr_set_codec_params,
 	.set_metadata   = soc_compr_set_metadata,
 	.get_metadata	= soc_compr_get_metadata,
 	.get_params	= soc_compr_get_params,
@@ -744,6 +773,7 @@ static struct snd_compr_ops soc_compr_dyn_ops = {
 	.free		= soc_compr_free_fe,
 	.set_params	= soc_compr_set_params_fe,
 	.get_params	= soc_compr_get_params,
+	.set_codec_params = soc_compr_set_codec_params,
 	.set_metadata   = soc_compr_set_metadata,
 	.get_metadata	= soc_compr_get_metadata,
 	.trigger	= soc_compr_trigger_fe,
diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
index b05e18b63a1c..06481d0278b8 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -594,6 +594,20 @@ int snd_soc_dai_compr_get_params(struct snd_soc_dai *dai,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dai_compr_get_params);
 
+int snd_soc_dai_compr_set_codec_params(struct snd_soc_dai *dai,
+					struct snd_compr_stream *cstream,
+					struct snd_codec *codec)
+{	int ret = 0;
+
+	if (dai->driver->cops &&
+	    dai->driver->cops->set_codec_params)
+		ret = dai->driver->cops->set_codec_params(cstream, codec, dai);
+
+	return soc_dai_ret(dai, ret);
+
+}
+EXPORT_SYMBOL_GPL(snd_soc_dai_compr_set_codec_params);
+
 int snd_soc_dai_compr_ack(struct snd_soc_dai *dai,
 			  struct snd_compr_stream *cstream,
 			  size_t bytes)
-- 
2.21.0

