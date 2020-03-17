Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B6DC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96A120752
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PO+VRhl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgCQPMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 11:12:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50416 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbgCQPMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 11:12:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id z13so5811390wml.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 08:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6OE0T7bJ5s9V3BgaE2gwgmd/QajU+WNA9/hfTCyPYzk=;
        b=PO+VRhl67KGSI9TyhWJJEGt+Sbh60tA8UgoP8OHHgVk1R9v7wHC0xgEPfZeL/4OP6o
         JS6e0B8qh2Ns0kzTvkTDI0z9u9QQInO6iFmUaM7zVbfSXK/fSot+JoztyawqqoWJ35za
         1kv/DGXYgfgNXcdPxrwug2optXmtJGdUZDGYM9sZLJ8TdHEn97xjKOdEG5JwDAadt7BR
         hwniIQ0Ni+ZVrgE1Vc7haTopp6kADOrcACTiICoL9vK9ZBRhX18OcyeEbugpz5Gu1iVh
         MAaLnqTfKzv+j7XENFyi5BSDNKdw1mYZAZ/uZ28ETuz9sKjlOF9qfRPXoKZOhBxtE4be
         Bd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6OE0T7bJ5s9V3BgaE2gwgmd/QajU+WNA9/hfTCyPYzk=;
        b=HYoJasPe1O8TMpJnXQrXjfe2+MMLfN7kxqXmBTK7+Oe7Yt7qSroWmPNhmfFXAJ0ISU
         Y0NAe4V64L4GYUluOxcECrHGVyjQ+Mky/gGhh286a83bOuHxY+yyVtV1+IRoXsBZ03Ce
         A589LT9G7PY3lge8WPskzIfXRim+bo92oDOqRze548sWpN7zsw7YgMQ+5ujNm/HtbP8M
         3j3NJfnSLLKpaDGP3dcpoaskVSCIfrQut0GcP7qJ6hRjtVrMguiZyrImpLDOf7T8YaJu
         q91Oezx6Vw/BI4fI3fr6U7UY+oPqBl+czChqZyR9u/j5SVh2PajD+VgTXyaeMzoWMQat
         a9xQ==
X-Gm-Message-State: ANhLgQ1oYFiQ0WvFqdilhCY87QN5naMMO+WV+If3yrAUq5/l6OItTpqP
        xBc7tHT6ZIVOAq+MR1qCfJA1Uw==
X-Google-Smtp-Source: ADFU+vv+LodaySxOuG1XJtZX2h5nc4wtyXmEf/5onTSVqD960Mah8WApo/k4gaup/Hh2qM42ePe3tQ==
X-Received: by 2002:a05:600c:2c09:: with SMTP id q9mr5534902wmg.167.1584457972302;
        Tue, 17 Mar 2020 08:12:52 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id u8sm4711089wrn.69.2020.03.17.08.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 08:12:51 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        vkoul@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/2] ASoC: qcom: sdm845: handle soundwire stream
Date:   Tue, 17 Mar 2020 15:12:32 +0000
Message-Id: <20200317151233.8763-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200317151233.8763-1-srinivas.kandagatla@linaro.org>
References: <20200317151233.8763-1-srinivas.kandagatla@linaro.org>
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
 sound/soc/qcom/sdm845.c | 67 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 1 deletion(-)

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
index 3ac02204a706..67a55edf755f 100644
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
@@ -45,11 +48,18 @@ static int sdm845_slim_snd_hw_params(struct snd_pcm_substream *substream,
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
+
 		ret = snd_soc_dai_get_channel_map(codec_dai,
 				&tx_ch_cnt, tx_ch, &rx_ch_cnt, rx_ch);
 
@@ -425,8 +435,65 @@ static void  sdm845_snd_shutdown(struct snd_pcm_substream *substream)
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

