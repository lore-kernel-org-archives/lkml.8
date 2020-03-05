Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B860C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 05:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496242146E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 05:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="B5uyHhTh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NJOA7gNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgCEFLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 00:11:52 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:34567 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725839AbgCEFLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 00:11:47 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 50F5613EC;
        Thu,  5 Mar 2020 00:11:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 05 Mar 2020 00:11:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=WgXHuW9inH73V
        4eN9Lhc8dVUq0yylRgC2mv73tI5Dos=; b=B5uyHhThrj2OofyyxskhR/L9EAozj
        MuCOo23YfhH41IZF4duzAQ5aaTbIjz4qIxh9pK8MaJ+qaPiCQzf2h4GWrEuziNpG
        1B/bRI67OJWzgL0FEnjyHoiYnI18KNX6N6BtAs1/o3rkJRcxx8fe97+kIsZclAgO
        lXxNiUzRGDoQvtNsNAuGSV/6n4yusOFVAeuGebtdRFs2o6FZ8TKPgPUc2pUY095f
        P9uwwlSqvCby9ydaqnbujOAVaSeC0pomYoiUCx77imTMGegcVBJNDiLPQWJEcFkc
        8/hPtLuJ9QFP4s54mDfr0YVFagt95bOfOYC1QRmbixWqorM3FBoFDZ3ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=WgXHuW9inH73V4eN9Lhc8dVUq0yylRgC2mv73tI5Dos=; b=NJOA7gNH
        syK7afkZkupBPnZNGLUOSi9ILnoW79aLG8skgIqWVZdTkPJzj+f3ys5P0vqPrMwl
        zqtmPJWYnfJugJB0VvQqIqY/EXsMKhTEzvuHzY9AGkqy5uxWlGyDhJMEWBx/hhb9
        BHCvHaDLAShRbQkV5xzerc9tDUYZDkggw5l6tqepYZ5iCzcAOsv0l+7+/TYw6sPD
        tviMuNQTwO5VKQKsui2HYepqgbwdwsn2EJRfzs5Jsu+knDTSzkYDQJeWXEhqE7Qy
        NuRHfOtqpn98TY4v9EWmlzyQhXFq8+a4f/CAVAUJXD1qSHFWkacpgNwdtiwAKp75
        hI4gu0XRasmY3Q==
X-ME-Sender: <xms:EYpgXsFZUw1fdpsIctcO3TQtLiJcinGgFDdBSK1xSfEnxE3GQyjdBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddtledgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:EYpgXs8f10zp7uGtX61wRzqpMWDxGNgINF1TNdphcxHxgYAOvqzLkw>
    <xmx:EYpgXhXRnA_5PTIyKOTCumPylRkH8lVDDOCXhJIPAuVZSAcqfAuE2g>
    <xmx:EYpgXoZJGiNcdOmCAilJfNP8yUuRvbcUKdSGSntbb51UpoyzJSCSQg>
    <xmx:EopgXuGzW5D9sQsG_WAePJJl7IVTf8wZ-P-gMNNZnH-_ZtdJfa2tag>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id ECE51328005E;
        Thu,  5 Mar 2020 00:11:44 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v4 2/3] ASoC: pcm: Export parameter intersection logic
Date:   Wed,  4 Mar 2020 23:11:42 -0600
Message-Id: <20200305051143.60691-3-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305051143.60691-1-samuel@sholland.org>
References: <20200305051143.60691-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic to calculate the subset of stream parameters supported by all
DAIs associated with a PCM stream is nontrivial. Export a helper
function so it can be used to set up simple codec2codec DAI links.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 include/sound/soc.h |  3 +++
 sound/soc/soc-pcm.c | 59 ++++++++++++++++++++++++++++++---------------
 2 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 81e5d17be935..9543d9246ca4 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -471,6 +471,9 @@ bool snd_soc_runtime_ignore_pmdown_time(struct snd_soc_pcm_runtime *rtd);
 void snd_soc_runtime_activate(struct snd_soc_pcm_runtime *rtd, int stream);
 void snd_soc_runtime_deactivate(struct snd_soc_pcm_runtime *rtd, int stream);
 
+int snd_soc_runtime_calc_hw(struct snd_soc_pcm_runtime *rtd,
+			    struct snd_pcm_hardware *hw, int stream);
+
 int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
 	unsigned int dai_fmt);
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 90857138c823..2ad501aaa4f9 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -587,11 +587,18 @@ static void soc_pcm_apply_msb(struct snd_pcm_substream *substream)
 	soc_pcm_set_msb(substream, cpu_bits);
 }
 
-static void soc_pcm_init_runtime_hw(struct snd_pcm_substream *substream)
+/**
+ * snd_soc_runtime_calc_hw() - Calculate hw limits for a PCM stream
+ * @rtd: ASoC PCM runtime
+ * @hw: PCM hardware parameters (output)
+ * @stream: Direction of the PCM stream
+ *
+ * Calculates the subset of stream parameters supported by all DAIs
+ * associated with the PCM stream.
+ */
+int snd_soc_runtime_calc_hw(struct snd_soc_pcm_runtime *rtd,
+			    struct snd_pcm_hardware *hw, int stream)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_pcm_hardware *hw = &runtime->hw;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai;
 	struct snd_soc_dai *cpu_dai;
 	struct snd_soc_pcm_stream *codec_stream;
@@ -602,7 +609,6 @@ static void soc_pcm_init_runtime_hw(struct snd_pcm_substream *substream)
 	unsigned int cpu_rate_min = 0, cpu_rate_max = UINT_MAX;
 	unsigned int rates = UINT_MAX, cpu_rates = UINT_MAX;
 	u64 formats = ULLONG_MAX;
-	int stream = substream->stream;
 	int i;
 
 	/* first calculate min/max only for CPUs in the DAI link */
@@ -613,12 +619,8 @@ static void soc_pcm_init_runtime_hw(struct snd_pcm_substream *substream)
 		 * Otherwise, since the rate, channel, and format values will
 		 * zero in that case, we would have no usable settings left,
 		 * causing the resulting setup to fail.
-		 * At least one CPU should match, otherwise we should have
-		 * bailed out on a higher level, since there would be no
-		 * CPU to support the transfer direction in that case.
 		 */
-		if (!snd_soc_dai_stream_valid(cpu_dai,
-					      substream->stream))
+		if (!snd_soc_dai_stream_valid(cpu_dai, stream))
 			continue;
 
 		cpu_stream = snd_soc_dai_get_pcm_stream(cpu_dai, stream);
@@ -640,12 +642,8 @@ static void soc_pcm_init_runtime_hw(struct snd_pcm_substream *substream)
 		 * Otherwise, since the rate, channel, and format values will
 		 * zero in that case, we would have no usable settings left,
 		 * causing the resulting setup to fail.
-		 * At least one CODEC should match, otherwise we should have
-		 * bailed out on a higher level, since there would be no
-		 * CODEC to support the transfer direction in that case.
 		 */
-		if (!snd_soc_dai_stream_valid(codec_dai,
-					      substream->stream))
+		if (!snd_soc_dai_stream_valid(codec_dai, stream))
 			continue;
 
 		codec_stream = snd_soc_dai_get_pcm_stream(codec_dai, stream);
@@ -658,6 +656,10 @@ static void soc_pcm_init_runtime_hw(struct snd_pcm_substream *substream)
 		rates = snd_pcm_rate_mask_intersect(codec_stream->rates, rates);
 	}
 
+	/* Verify both a valid CPU DAI and a valid CODEC DAI were found */
+	if (!chan_min || !cpu_chan_min)
+		return -EINVAL;
+
 	/*
 	 * chan min/max cannot be enforced if there are multiple CODEC DAIs
 	 * connected to CPU DAI(s), use CPU DAI's directly and let
@@ -671,18 +673,35 @@ static void soc_pcm_init_runtime_hw(struct snd_pcm_substream *substream)
 	/* finally find a intersection between CODECs and CPUs */
 	hw->channels_min = max(chan_min, cpu_chan_min);
 	hw->channels_max = min(chan_max, cpu_chan_max);
-	if (hw->formats)
-		hw->formats &= formats;
-	else
-		hw->formats = formats;
+	hw->formats = formats;
 	hw->rates = snd_pcm_rate_mask_intersect(rates, cpu_rates);
 
-	snd_pcm_limit_hw_rates(runtime);
+	snd_pcm_hw_limit_rates(hw);
 
 	hw->rate_min = max(hw->rate_min, cpu_rate_min);
 	hw->rate_min = max(hw->rate_min, rate_min);
 	hw->rate_max = min_not_zero(hw->rate_max, cpu_rate_max);
 	hw->rate_max = min_not_zero(hw->rate_max, rate_max);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_runtime_calc_hw);
+
+static void soc_pcm_init_runtime_hw(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_hardware *hw = &substream->runtime->hw;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	u64 formats = hw->formats;
+
+	/*
+	 * At least one CPU and one CODEC should match. Otherwise, we should
+	 * have bailed out on a higher level, since there would be no CPU or
+	 * CODEC to support the transfer direction in that case.
+	 */
+	snd_soc_runtime_calc_hw(rtd, hw, substream->stream);
+
+	if (formats)
+		hw->formats &= formats;
 }
 
 static int soc_pcm_components_open(struct snd_pcm_substream *substream)
-- 
2.24.1

