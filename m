Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889C2C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 09:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6100320663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 09:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gCt6PuOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgCQJ4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 05:56:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38698 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgCQJ4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 05:56:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id s1so3029811wrv.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 02:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=To+ZBrVO7etOV/SjBRId9Z6wmLhx8Z2t4f3TOlZx1jE=;
        b=gCt6PuOl3Pf14jrW7CShNKEAx6VEl4w9WHMOpbcHEdj/DxcqNOt+RVOr88DIpYWcr6
         9bJIRUNGJR6UTaaO1Vq3bhpbZsuyOv1BUC7BjHYVy2ZQxde6qyfto63LQS04JHoL6kXt
         XaSZc/N/8FyY69mcZVR+I7+e9MDH3734h6R3KvFTW3nZUqATwcdTYabXrjav+t0JWSYO
         sT7QWzSkvbiFcTKKp4RKzisUQfD+pD0/EFQh9mbpN5cVx/11NceyTxdH4RS83pM2NZdz
         7Ii5CcbF7f8v9KZau6JUjSh2e3Mj+CBwUbn4gGyBeuKZ9MboeEL19XfudGnGM9vj4KxU
         1oKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=To+ZBrVO7etOV/SjBRId9Z6wmLhx8Z2t4f3TOlZx1jE=;
        b=e5o9okH9D1q51VeZePIBB+8Xh2BvNtobTfvFtZpGLuF3dPKrQguq9FRzOzacm3ZNEZ
         bPiiPHnlsbe7XqKmUpi4pay1ikqwoqYw8jd/VLWkHpWMsYS0M4x8N23ELsvmYZZUiUDI
         Dx4ja3nc2lT1yXB18qSx8Wo7n+kc3DU1HX2YNNY6suCsU4iO1cCay++JP8/7FumlBjYK
         eQvQ3yRw35nzpsQX0ufyHm2BwlMZKRGGtRTGGbheL+jIy/lJ1VdmoLyUcatUtq8T0RPE
         9iaQR2J/3XugX3hzyoEVd12Puz8+25o7pkqucrgPi5fmFFBfRA67xj43cP+ABxfDT8lM
         c18w==
X-Gm-Message-State: ANhLgQ1Wx6peZ9EpxSGnFa94ncHAcopIAkyrAK/SQDhj4TjIz6Ukcic9
        qAs7xPKXz+c8fQR1hbAiQBMC4Q==
X-Google-Smtp-Source: ADFU+vvSmH4BQWYSEJ6orhlFnlf4qay25LVcbKQQgE5YeEkhjFWKQMiRb2awtyD7VI4kEaQAeIoH5w==
X-Received: by 2002:a5d:528e:: with SMTP id c14mr5246370wrv.308.1584438973380;
        Tue, 17 Mar 2020 02:56:13 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id a184sm3394970wmf.29.2020.03.17.02.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 02:56:12 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        vkoul@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] ASoC: codecs: wsa881x: remove soundwire stream handling
Date:   Tue, 17 Mar 2020 09:53:51 +0000
Message-Id: <20200317095351.15582-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200317095351.15582-1-srinivas.kandagatla@linaro.org>
References: <20200317095351.15582-1-srinivas.kandagatla@linaro.org>
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

