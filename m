Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5337DC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 09:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2380A206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 09:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ij0TMFT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgCQJ4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 05:56:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35962 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgCQJ4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 05:56:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id g62so21164275wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 02:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YGpbMRaxJGjCa7+3XPo88ShDnUTM99ZCSsS8Lmv3xCs=;
        b=Ij0TMFT2ln3+jvsB/85ejD0BcUwYuv0FMiE10fbErrxpmT3faXywnu0cKL53pRYCvL
         p+yopo7XojlxHEjRoQSf3Yr/n7Ht1qu2SOfsPHy+sY1gdwFLGlNuJ4EmIoeBXB1hrWBB
         uC5suze/HqrRZUP8HsE3U469ntEka/kXMVKrFuJ+xQPqtfm91VSNUu9phxs8I2fFY7Vq
         PMoWa62R9Vrb85qSCWSGCbD0FcqGTqTFXmYm+3JlC2btmVfQzQiF8WLjo04bcnKdcSFW
         fhOR4tSpvPvGUbGDUImrLkcUdNuw5pfbeb9OlEpGn7SEmgwyPwiLmdQGxEIGMHvGp/9N
         T3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YGpbMRaxJGjCa7+3XPo88ShDnUTM99ZCSsS8Lmv3xCs=;
        b=F/5dPBNRfXKYMCjzAjjX1PITJsXAeV+l2EN/Pe470cgIkgsZFfwRiWcemE+ttu63iw
         yiWzhNBGJPnfrq2BKsHQ3TVaLCJichxGiy9RhCr/5mf4SgB99gE0Pg9wLZ0uTKxbFjBN
         A7j4/Fq17UDmljoulPvzz2WpJ7IQE86hAnK8q3PDNBGT2FQ8ADsLlaBgAI3GNAjWSpC6
         HLtQAyyETw5RFx5WMkG60FFKo1fp+P8wqYnWQFUTMki4SJRmlKHZLhlopFKXGLPXcBRC
         Fh+sIzpc3V/UTT9jyCL74OTSdxHVtUnzcSa6Pw5yIck8p70lWHWbTJR6hJ0xS0UwNvCB
         BysA==
X-Gm-Message-State: ANhLgQ3McHGmktjYt0ygAHHML/8o3/cCHBXN/GZciyPgUEUtxH/78Dpl
        1sWI2Dz+c09G2wjDJHjCAJv5uw==
X-Google-Smtp-Source: ADFU+vufT3TdTJmG7aY0yjg0gULEQIzff8XOugkxhCDe8IBjghr+nX9MiVCkS8KkXwY4TTBCA+AlvQ==
X-Received: by 2002:a1c:63c4:: with SMTP id x187mr4420289wmb.124.1584438971841;
        Tue, 17 Mar 2020 02:56:11 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id a184sm3394970wmf.29.2020.03.17.02.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 02:56:11 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        vkoul@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] ASoC: qcom: sdm845: handle soundwire stream
Date:   Tue, 17 Mar 2020 09:53:50 +0000
Message-Id: <20200317095351.15582-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200317095351.15582-1-srinivas.kandagatla@linaro.org>
References: <20200317095351.15582-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In existing setup WSA881x codec handles soundwire stream,
however DB845c and other machines based on SDM845c have 2
instances for WSA881x codec. This will force soundwire stream
to be prepared/enabled twice or multiple times.
Handling SoundWire Stream in machine driver would fix this issue.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/Kconfig  |  2 +-
 sound/soc/qcom/sdm845.c | 69 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 6530d2462a9e..f51b28d1b94d 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -99,7 +99,7 @@ config SND_SOC_MSM8996
 
 config SND_SOC_SDM845
 	tristate "SoC Machine driver for SDM845 boards"
-	depends on QCOM_APR && CROS_EC && I2C
+	depends on QCOM_APR && CROS_EC && I2C && SOUNDWIRE
 	select SND_SOC_QDSP6
 	select SND_SOC_QCOM_COMMON
 	select SND_SOC_RT5663
diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 3ac02204a706..82ec71a1e3bd 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -11,6 +11,7 @@
 #include <sound/pcm_params.h>
 #include <sound/jack.h>
 #include <sound/soc.h>
+#include <linux/soundwire/sdw.h>
 #include <uapi/linux/input-event-codes.h>
 #include "common.h"
 #include "qdsp6/q6afe.h"
@@ -31,10 +32,12 @@
 struct sdm845_snd_data {
 	struct snd_soc_jack jack;
 	bool jack_setup;
+	bool stream_prepared[SLIM_MAX_RX_PORTS];
 	struct snd_soc_card *card;
 	uint32_t pri_mi2s_clk_count;
 	uint32_t sec_mi2s_clk_count;
 	uint32_t quat_tdm_clk_count;
+	struct sdw_stream_runtime *sruntime[SLIM_MAX_RX_PORTS];
 };
 
 static unsigned int tdm_slot_offset[8] = {0, 4, 8, 12, 16, 20, 24, 28};
@@ -45,11 +48,20 @@ static int sdm845_slim_snd_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai *codec_dai;
+	struct sdm845_snd_data *pdata = snd_soc_card_get_drvdata(rtd->card);
 	u32 rx_ch[SLIM_MAX_RX_PORTS], tx_ch[SLIM_MAX_TX_PORTS];
+	struct sdw_stream_runtime *sruntime;
 	u32 rx_ch_cnt = 0, tx_ch_cnt = 0;
 	int ret = 0, i;
 
 	for_each_rtd_codec_dais(rtd, i, codec_dai) {
+		sruntime = snd_soc_dai_get_sdw_stream(codec_dai,
+						      substream->stream);
+		if (sruntime != ERR_PTR(-ENOTSUPP))
+			pdata->sruntime[cpu_dai->id] = sruntime;
+		else
+			pdata->sruntime[cpu_dai->id] = NULL;
+
 		ret = snd_soc_dai_get_channel_map(codec_dai,
 				&tx_ch_cnt, tx_ch, &rx_ch_cnt, rx_ch);
 
@@ -425,8 +437,65 @@ static void  sdm845_snd_shutdown(struct snd_pcm_substream *substream)
 	}
 }
 
+static int sdm845_snd_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
+	int ret;
+
+	if (!sruntime)
+		return 0;
+
+	if (data->stream_prepared[cpu_dai->id]) {
+		sdw_disable_stream(sruntime);
+		sdw_deprepare_stream(sruntime);
+		data->stream_prepared[cpu_dai->id] = false;
+	}
+
+	ret = sdw_prepare_stream(sruntime);
+	if (ret)
+		return ret;
+
+	/**
+	 * NOTE: there is a strict hw requirement about the ordering of port
+	 * enables and actual WSA881x PA enable. PA enable should only happen
+	 * after soundwire ports are enabled if not DC on the line is
+	 * accumulated resulting in Click/Pop Noise
+	 * PA enable/mute are handled as part of codec DAPM and digital mute.
+	 */
+
+	ret = sdw_enable_stream(sruntime);
+	if (ret) {
+		sdw_deprepare_stream(sruntime);
+		return ret;
+	}
+	data->stream_prepared[cpu_dai->id] = true;
+
+	return ret;
+}
+
+static int sdm845_snd_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
+
+	if (sruntime && data->stream_prepared[cpu_dai->id]) {
+		sdw_disable_stream(sruntime);
+		sdw_deprepare_stream(sruntime);
+		data->stream_prepared[cpu_dai->id] = false;
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_ops sdm845_be_ops = {
 	.hw_params = sdm845_snd_hw_params,
+	.hw_free = sdm845_snd_hw_free,
+	.prepare = sdm845_snd_prepare,
 	.startup = sdm845_snd_startup,
 	.shutdown = sdm845_snd_shutdown,
 };
-- 
2.21.0

