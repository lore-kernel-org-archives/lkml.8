Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D93C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B03720714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h+nS41fF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgCQPM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 11:12:59 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36033 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbgCQPM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 11:12:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id g62so22442739wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 08:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=To+ZBrVO7etOV/SjBRId9Z6wmLhx8Z2t4f3TOlZx1jE=;
        b=h+nS41fFI/j+hpYD0FJ9Cffsw1aWAfZSbfSVYU2TvNSeoAWY098CmiFLLRoqfKfMXB
         0bIhtn+MEZO2FygfvnzyGful+JsMHWK1rtGczPo/tpVUNY77WbOMNdELQlyMTkYGqgGo
         xBPUP80QF92zGW87sPiOS8z3Mx4tlf5MFGkJuYUYAuRJ1yzSasfMAwc4zS9J316hOqEA
         X4yipCiYmQcoWK7T1qUSQGLEUUHRrxrK98MNJKnmjo8XW47PVCHo1Q0d06ids/Q2plLq
         BUz3sm0a9a6AW5UQglkxr4f0ZE14ax9X9cCDt7jNwkoFeRTYcvg9BAmcG4QtvNi/dXs1
         KtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=To+ZBrVO7etOV/SjBRId9Z6wmLhx8Z2t4f3TOlZx1jE=;
        b=meTsCr53j2lglAYTu0wxgEBDWYVOaOe7z4bEtcXRmfWPwA06zUNSeTiWzhxZAN2pLn
         skzYVO60PdCmUUKc0G0AjognW7sRsFYu9vPLIJ2PS5UwKVfJ4Hm3ZFHyRROskmeNiQh0
         NlY9e6c4VLSrpbp2kcp5caYnxUY1x1OCuHWDpg0EBBfglQhCOND1APsWfQmlbCLBt3Zy
         /I2UhX7HMQSKUSysfzTwwd64Ha9p4c1bQwxSZNL3wYb5ReKLvDGygLVS6TXX48Y5WuHr
         ZWY5FRrP00tGX+sk4jh4oIPvtXW7E0bMh8HEHRhya3zNbKQXWoliRi4Pt+qQvgSqM2BS
         2wrg==
X-Gm-Message-State: ANhLgQ10YyMdgN6YIi0gM6Qz5RgMHLI/o7wFIcCitE0wPQIJk5L/+gRU
        QgnVnBuE1KBiL/naK3jogsa1QQ==
X-Google-Smtp-Source: ADFU+vtPm4u2akxIoRVa2g4Wb70tmucXIbnpVUxO5369gZNB38g9SBFZmRu3Amtdirg/GIpusE1B9A==
X-Received: by 2002:a1c:1d4d:: with SMTP id d74mr5706207wmd.123.1584457974485;
        Tue, 17 Mar 2020 08:12:54 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id u8sm4711089wrn.69.2020.03.17.08.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 08:12:53 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        vkoul@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/2] ASoC: codecs: wsa881x: remove soundwire stream handling
Date:   Tue, 17 Mar 2020 15:12:33 +0000
Message-Id: <20200317151233.8763-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200317151233.8763-1-srinivas.kandagatla@linaro.org>
References: <20200317151233.8763-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There could be multiple instances of this codec on any platform,
so handling stream directly in this codec driver can lead to
multiple calls to prepare/enable/disable on the same SoundWire stream.
Move this stream handling to machine driver to fix this issue.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wsa881x.c | 44 +-------------------------------------
 1 file changed, 1 insertion(+), 43 deletions(-)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index 1810e0775efe..d39d479e2378 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -680,7 +680,6 @@ struct wsa881x_priv {
 	int active_ports;
 	bool port_prepared[WSA881X_MAX_SWR_PORTS];
 	bool port_enable[WSA881X_MAX_SWR_PORTS];
-	bool stream_prepared;
 };
 
 static void wsa881x_init(struct wsa881x_priv *wsa881x)
@@ -958,41 +957,6 @@ static const struct snd_soc_dapm_widget wsa881x_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("SPKR"),
 };
 
-static int wsa881x_prepare(struct snd_pcm_substream *substream,
-			   struct snd_soc_dai *dai)
-{
-	struct wsa881x_priv *wsa881x = dev_get_drvdata(dai->dev);
-	int ret;
-
-	if (wsa881x->stream_prepared) {
-		sdw_disable_stream(wsa881x->sruntime);
-		sdw_deprepare_stream(wsa881x->sruntime);
-		wsa881x->stream_prepared = false;
-	}
-
-
-	ret = sdw_prepare_stream(wsa881x->sruntime);
-	if (ret)
-		return ret;
-
-	/**
-	 * NOTE: there is a strict hw requirement about the ordering of port
-	 * enables and actual PA enable. PA enable should only happen after
-	 * soundwire ports are enabled if not DC on the line is accumulated
-	 * resulting in Click/Pop Noise
-	 * PA enable/mute are handled as part of DAPM and digital mute.
-	 */
-
-	ret = sdw_enable_stream(wsa881x->sruntime);
-	if (ret) {
-		sdw_deprepare_stream(wsa881x->sruntime);
-		return ret;
-	}
-	wsa881x->stream_prepared = true;
-
-	return ret;
-}
-
 static int wsa881x_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params,
 			     struct snd_soc_dai *dai)
@@ -1020,12 +984,7 @@ static int wsa881x_hw_free(struct snd_pcm_substream *substream,
 {
 	struct wsa881x_priv *wsa881x = dev_get_drvdata(dai->dev);
 
-	if (wsa881x->stream_prepared) {
-		sdw_disable_stream(wsa881x->sruntime);
-		sdw_deprepare_stream(wsa881x->sruntime);
-		sdw_stream_remove_slave(wsa881x->slave, wsa881x->sruntime);
-		wsa881x->stream_prepared = false;
-	}
+	sdw_stream_remove_slave(wsa881x->slave, wsa881x->sruntime);
 
 	return 0;
 }
@@ -1056,7 +1015,6 @@ static int wsa881x_digital_mute(struct snd_soc_dai *dai, int mute, int stream)
 
 static struct snd_soc_dai_ops wsa881x_dai_ops = {
 	.hw_params = wsa881x_hw_params,
-	.prepare = wsa881x_prepare,
 	.hw_free = wsa881x_hw_free,
 	.mute_stream = wsa881x_digital_mute,
 	.set_sdw_stream = wsa881x_set_sdw_stream,
-- 
2.21.0

