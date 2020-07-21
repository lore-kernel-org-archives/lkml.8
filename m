Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09970C433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5E712073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AbnVVS1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbgGURDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 13:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730416AbgGURAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 13:00:44 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5B4C0619DD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 10:00:18 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q15so3531066wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 10:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cX30zM4NBo9NgJKdwCaDNO5IgDHp7txiav7RhZ1wYnQ=;
        b=AbnVVS1ePUqx9ZPvRol7dMY9NmY2pLxSYSuFxd7YPIgzDHhZ3v8kpF1QZ3NJtL6kIK
         i0Y2uIL8P6oqP1sjFslcqU+M0EmVuj8Rbq6mJWXcOwrA7OHTLIkG5vL0V2q1S6L1g2+O
         G4YFGPSucmloC+6HSvQRDkY3sYdb44fR62hM1u/eLxMTAfkUzXeDTSw+B92btBFVLoNH
         Sj0oZOseF9TALG3GGtnYqm1bneG0Z34Bti25JMNs3oYDo9DpwSj69TRKxNa/fZaPbzOj
         GPnkiOuHr2yLQIiFAVkS2OGDmbMaGnNjQ7ENLTtWXJUZi/aXos7jg0pOzXhnz0x63/nk
         Fnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cX30zM4NBo9NgJKdwCaDNO5IgDHp7txiav7RhZ1wYnQ=;
        b=mxt/V3OW20Luc6NNGZef5GghKEle+00OD36coRoL60077DcOgqA+zCJ+8Fk4j4lws8
         7gBTvHi93YPf6BWY5FVR/BMtVosaYPoIt260teScRcGDeRlnio5OXLxhPSI9IWsXfa+4
         LPF9HoGN3pB4RMqd4Wlb6Q753GeeTr42dk35Bd2p5sRcM0WYMi84NxReD+ZBd7nj7Sru
         hxZNCXzctxFdn0LKPozLCa1TD/9vq+DiwNQm9FLNidvRDyTF4iH9KnOQvQCCa0uBnvt3
         8vtEFqRlL9bLxU5AsmSHdNXtzi8t6b+eDKawlmmsQTKBpGQHshnKoMg5D2QmXwFMcYAS
         eEIQ==
X-Gm-Message-State: AOAM531+EGbh8ze4MdE+Iif7haxd/NAWs2xAKN01RNI8d/Uy3pSzj/lU
        kQJ7vZC7donpBnQVXO6KK9gKV+V68eM=
X-Google-Smtp-Source: ABdhPJxXHRQU8c3AC4+4CNVvMYSBeNRcIY6fllLgC7+JpgeWNr20AAE6+Lrw5aOotX5A5Ot5n8tUMA==
X-Received: by 2002:a7b:c5c5:: with SMTP id n5mr4872179wmk.103.1595350816319;
        Tue, 21 Jul 2020 10:00:16 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id h11sm15526327wrb.68.2020.07.21.10.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 10:00:15 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH v2 3/6] ALSA: compress: add flags to snd_compr_caps to expose dsp caps
Date:   Tue, 21 Jul 2020 18:00:04 +0100
Message-Id: <20200721170007.4554-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
References: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the DSPs like Qualcomm QDSP has ablity to change decoders
dynamically on a single stream, This could be used for features
like Cross Fade or gapless with different codec profile tracks.

Exposing such features in flags variable of compress caps descriptor
would provide userspace more flexibity in usings dsp features.

For now only one flag of switching decoders is added which is used
in subsequent patches.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/uapi/sound/compress_offload.h |  7 ++++++-
 sound/core/compress_offload.c         | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/uapi/sound/compress_offload.h b/include/uapi/sound/compress_offload.h
index c46286113a4b..43c78cdf492c 100644
--- a/include/uapi/sound/compress_offload.h
+++ b/include/uapi/sound/compress_offload.h
@@ -88,6 +88,9 @@ enum snd_compr_direction {
 	SND_COMPRESS_CAPTURE
 };
 
+/* DSP can switch decoder in a single Stream while doing gapless */
+#define SND_COMPR_CAP_FLAGS_DSP_CAN_SWITCH_DECODER	((__u32) 0x00000001)
+
 /**
  * struct snd_compr_caps - caps descriptor
  * @codecs: pointer to array of codecs
@@ -97,6 +100,7 @@ enum snd_compr_direction {
  * @min_fragments: min fragments supported by DSP
  * @max_fragments: max fragments supported by DSP
  * @num_codecs: number of codecs supported
+ * @flags: flags to expose various DSP capabilities
  * @reserved: reserved field
  */
 struct snd_compr_caps {
@@ -107,7 +111,8 @@ struct snd_compr_caps {
 	__u32 min_fragments;
 	__u32 max_fragments;
 	__u32 codecs[MAX_NUM_CODECS];
-	__u32 reserved[11];
+	__u32 flags;
+	__u32 reserved[10];
 } __attribute__((packed, aligned(4)));
 
 /**
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 184722643c97..abebd5fee2d2 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -590,12 +590,32 @@ static int snd_compress_check_input(struct snd_compr_params *params)
 
 }
 
+static bool snd_compr_can_dsp_switch_decoder(struct snd_compr_stream *stream)
+{
+	struct snd_compr_caps caps;
+
+	if (!stream->ops->get_caps)
+		return false;
+
+	memset(&caps, 0, sizeof(caps));
+	if (stream->ops->get_caps(stream, &caps))
+		return false;
+
+	if (caps.flags & SND_COMPR_CAP_FLAGS_DSP_CAN_SWITCH_DECODER)
+		return true;
+
+	return false;
+}
+
 static int snd_compr_set_codec_params(struct snd_compr_stream *stream,
 				      unsigned long arg)
 {
 	struct snd_codec *params;
 	int retval;
 
+	if (!snd_compr_can_dsp_switch_decoder(stream))
+		return -ENOTSUPP;
+
 	if (!stream->ops->set_codec_params)
 		return -EPERM;
 
-- 
2.21.0

