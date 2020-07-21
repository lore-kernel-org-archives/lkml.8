Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF0FC433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 230E9207BB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rGgImTH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbgGURDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 13:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730428AbgGURAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 13:00:44 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB0BC0619DE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 10:00:18 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g10so2599871wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 10:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZOraVd74qzG1/9gtwasj7hNZRlKbVxl3mVRj5ZSF7Dw=;
        b=rGgImTH6cRW3JnhKIdeBbGCqvYhutbzFSz7mlRlsdNbijsdwAga1FeJyh4NCPezpJP
         w3E0eicyoEm4KyHIDU7BT17bprfX97UBJ7cZoZboy8dxVYTHW4B3YPI/b4zNtjijmThJ
         TnYB1luKSwCroAcp/7ifYGxWOP8Zy0L/0eycR5j5p5AqWdOLx002RpjAq9Q+CXe5oN+E
         gfcbJ6D4xy0hmDwFyNdjATtWz5U+x9qARq0vEwWu+oB6Qas0dcNOejAO2Pczk0W22uEY
         PdToiMO/G89MgtVzzrLyyVLVlwz0DNLexhNvsvC/2xvnqwus7c/TUH+NH7LbIZVLVnIt
         Izkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZOraVd74qzG1/9gtwasj7hNZRlKbVxl3mVRj5ZSF7Dw=;
        b=NO9BmZ1zpFSxi/TxjTGn+7sTs/r27xlhR7lzcWfmCewdLF+y5RQ5Xz0otjqvLCZ6+c
         GjHbQL5dgaXOxv18hvW8veefu4gNcJrjBmfLqPRa2MFu2stDlkBn+L8IyzzcGI8Tsc3f
         ciG51k66icdi8lEQdxDCferUsxq4FtCPqWxD5oDFlpMINAA/MSjXkfiYG140qfve13Bj
         TBIXLJkoNmk+MMvtdNcq6Dre4cFk6sRuf2d4gNx8kemFKJAHmCvk89oZWgrqpjUUyN51
         PxsWOCTDzTQaz2HpVVwe472fXSwMbLxLUpOqnzU6MP1yCBNLSl9UGmEswgIAzXmQNXai
         C9eA==
X-Gm-Message-State: AOAM5316E4dWq6jTHTXMhi3GGy9JgobQI+T0S457QTRMUkqUtHhImFmt
        m2sYwxniSdDAb7X8rbqmTPxFnQ==
X-Google-Smtp-Source: ABdhPJyanh2NBymOjVnC1OieVwWUIGSxUVOyeKt8tkHvdgFZRJPKcaXzfWkcjFu5fSmyt990bVvV4g==
X-Received: by 2002:a1c:e382:: with SMTP id a124mr491428wmh.11.1595350817574;
        Tue, 21 Jul 2020 10:00:17 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id h11sm15526327wrb.68.2020.07.21.10.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 10:00:16 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH v2 4/6] ASoC: compress: add snd_soc_dai_compr_set_codec_params()
Date:   Tue, 21 Jul 2020 18:00:05 +0100
Message-Id: <20200721170007.4554-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
References: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add corresponding ASoC changes to support gapless playback of tracks
which have different codec profile with or without same decoder.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/sound/soc-component.h |  3 +++
 include/sound/soc-dai.h       |  5 +++++
 sound/soc/soc-compress.c      | 30 ++++++++++++++++++++++++++++++
 sound/soc/soc-dai.c           | 14 ++++++++++++++
 4 files changed, 52 insertions(+)

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

