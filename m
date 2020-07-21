Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBE1C433FB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65D272065D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TZagcxsv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbgGURDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 13:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730411AbgGURAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 13:00:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D38C0619DC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 10:00:16 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 22so3532186wmg.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 10:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4rU3b/gziRzoNApIuUQOhBISC1QXxPCmKcl+VrCyHfM=;
        b=TZagcxsvvNWcs1yVY+CL7AodCrhUI/pwmVvVHQ9kkofoOakLyDuKZtIFEtBtRO9dgP
         cJOjbRXbeXx9+8Xw9m64/gA039nNk9U6Z7cX1Qc/HXOypUPEvFYyhVhAlekkTaH0l9St
         8sFwOc6zbcKRy/fkJWbpQBFZBAzBoQY9Lo/X9CrMfcyShVCa7tCF5Ynnu/Mat1fss7WX
         Cbc8tUPGjA3a0HkOX2kamp+Ljuea6rSkwUmvQxJSGV0qbDoQ3yfzT26J0YKaKQvi3dkh
         2sXJ2sE/kryAhEghs/yRO58y13MmX424/RNqLBodl/gijjcF9h+QncDOikOoeAJ0dDuF
         mcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4rU3b/gziRzoNApIuUQOhBISC1QXxPCmKcl+VrCyHfM=;
        b=TqiSU/ejItCusDEdLmpO/bJgHX75NwXjPmnDjH+Wx0ljk8Yfrvgdk6KQGeqH4tFY4C
         sGS23+ngLoxqaRS+JEUFT0AmgjqhLFsggeh/tH1Jngi7yOoJY33C5tCdDHJie/beahzZ
         MKEiJIjAmB2ISulvW28sHfAS3K9fM0H+RdIhsh0HIE0wqwCVVBoLYkH0Tg4+f6QImUTr
         +6RAIjgsuCWMCz/LQqKOXnnfk/GxvihwIZ+tfmAR1cegXYHU1ejz2ecXzro6UJYNkZKt
         Ib7p0QlK1irRU2h5jDkq0FWabnVE//sirPmL3O1pQc4GxoV/TWKvO49iithV5eCsKzHC
         e+OQ==
X-Gm-Message-State: AOAM532QyCk69yw73fBNCE9yjywLtykD69TpQYHLKUhUsmSYBs1s9ryD
        xLzxDuuqcnRDyINWwM/dHxtNNA==
X-Google-Smtp-Source: ABdhPJx0378L3JEh/bfdLm1mDah0uO18+EojpgndTJjXLnsvs9BnTrzTyeSkmbdU9xwu4rDx2IOyBg==
X-Received: by 2002:a1c:7d56:: with SMTP id y83mr5150904wmc.154.1595350814996;
        Tue, 21 Jul 2020 10:00:14 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id h11sm15526327wrb.68.2020.07.21.10.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 10:00:14 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH v2 2/6] ALSA: compress: add new ioctl for setting codec parameters
Date:   Tue, 21 Jul 2020 18:00:03 +0100
Message-Id: <20200721170007.4554-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
References: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For gapless playback it is possible that each track can have different
codec profile with same decoder, for example we have WMA album,
we may have different tracks as WMA v9, WMA v10 and so on

Or if DSP's like QDSP have abililty to switch decoders on single stream
for each track, then this call could be used to set new codec parameters.

Existing code does not allow to change this profile while doing gapless
playback.

This patch adds new SNDRV_COMPRESS_SET_CODEC_PARAMS IOCTL to allow
userspace to set this new parameters required for new codec profile.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../sound/designs/compress-offload.rst        |  6 ++++
 include/sound/compress_driver.h               |  5 +++
 include/uapi/sound/compress_offload.h         |  1 +
 sound/core/compress_offload.c                 | 34 +++++++++++++++++++
 4 files changed, 46 insertions(+)

diff --git a/Documentation/sound/designs/compress-offload.rst b/Documentation/sound/designs/compress-offload.rst
index 935f325dbc77..305ccc7bfdd9 100644
--- a/Documentation/sound/designs/compress-offload.rst
+++ b/Documentation/sound/designs/compress-offload.rst
@@ -128,6 +128,12 @@ set_params
   cases decoders will ignore other fields, while encoders will strictly
   comply to the settings
 
+set_codec_params
+  This routine is very much simillar to set_params but exculding stream
+  information. Only codec related information is set as part of this.
+  It is used in gapless playback where its required to change decoder
+  or its parameters for next track. This is optional.
+
 get_params
   This routines returns the actual settings used by the DSP. Changes to
   the settings should remain the exception.
diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
index 70cbc5095e72..d9c00bcfce9b 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -93,6 +93,9 @@ struct snd_compr_stream {
  * @set_params: Sets the compressed stream parameters, mandatory
  * This can be called in during stream creation only to set codec params
  * and the stream properties
+ * @set_codec_params: Sets the compressed stream codec parameters, Optional
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
index af5824113246..184722643c97 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -590,6 +590,37 @@ static int snd_compress_check_input(struct snd_compr_params *params)
 
 }
 
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
+
+out:
+	kfree(params);
+	return retval;
+}
+
 static int
 snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
 {
@@ -973,6 +1004,9 @@ static long snd_compr_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 	case _IOC_NR(SNDRV_COMPRESS_GET_PARAMS):
 		retval = snd_compr_get_params(stream, arg);
 		break;
+	case _IOC_NR(SNDRV_COMPRESS_SET_CODEC_PARAMS):
+		retval = snd_compr_set_codec_params(stream, arg);
+		break;
 	case _IOC_NR(SNDRV_COMPRESS_SET_METADATA):
 		retval = snd_compr_set_metadata(stream, arg);
 		break;
-- 
2.21.0

