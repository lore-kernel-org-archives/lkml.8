Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79882C3F2D6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 15:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5381720409
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 15:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583507019;
	bh=EZ3C2rlyNUrRxX2zYtuIyyeToL3vAS26vj8u9F3mNuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=ffyT8GFiZxpXJpxgPEqWBAvoxHgKrWecjUTa4wGOVYZLtkUwPKfrC8KrRQIvmhZ+f
	 91o0htoiYQwRJWI3Xfs7bhb71V4JXvIn6cpwUi+zclBiMM9+vJLqbCtHUgJF/3mn6+
	 EZVH8rjUS1nRaSvKMc37+qL4A4Twe5AaCo9AVokw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgCFPDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 10:03:38 -0500
Received: from foss.arm.com ([217.140.110.172]:35168 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgCFPDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 10:03:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 888A731B;
        Fri,  6 Mar 2020 07:03:35 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0994B3F237;
        Fri,  6 Mar 2020 07:03:34 -0800 (PST)
Date:   Fri, 06 Mar 2020 15:03:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: simple-card: Add support for codec2codec DAI links" to the asoc tree
In-Reply-To:  <20200305051143.60691-4-samuel@sholland.org>
Message-Id:  <applied-20200305051143.60691-4-samuel@sholland.org>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: simple-card: Add support for codec2codec DAI links

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 95cfc0a0aaf575207152dd7601e782702565a6f1 Mon Sep 17 00:00:00 2001
From: Samuel Holland <samuel@sholland.org>
Date: Wed, 4 Mar 2020 23:11:43 -0600
Subject: [PATCH] ASoC: simple-card: Add support for codec2codec DAI links

Following the example in cb2cf0de1174 ("ASoC: soc-core: care Codec <->
Codec case by non_legacy_dai_naming"), determine if a DAI link contains
only codec DAIs by examining the non_legacy_dai_naming flag in each
DAI's component.

For now, we assume there is only one or a small set of valid PCM stream
parameters, so num_params == 1 is good enough. We also assume that the
same params are valid for all supported streams. params is set to the
subset of parameters common among all DAIs, and then the existing code
automatically chooses the highest quality of the remaining values when
the link is brought up.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Link: https://lore.kernel.org/r/20200305051143.60691-4-samuel@sholland.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/sound/soc/codec-to-codec.rst |  9 +++-
 sound/soc/generic/simple-card-utils.c      | 48 ++++++++++++++++++++++
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/Documentation/sound/soc/codec-to-codec.rst b/Documentation/sound/soc/codec-to-codec.rst
index 810109d7500d..4eaa9a0c41fc 100644
--- a/Documentation/sound/soc/codec-to-codec.rst
+++ b/Documentation/sound/soc/codec-to-codec.rst
@@ -104,5 +104,10 @@ Make sure to name your corresponding cpu and codec playback and capture
 dai names ending with "Playback" and "Capture" respectively as dapm core
 will link and power those dais based on the name.
 
-Note that in current device tree there is no way to mark a dai_link
-as codec to codec. However, it may change in future.
+A dai_link in a "simple-audio-card" will automatically be detected as
+codec to codec when all DAIs on the link belong to codec components.
+The dai_link will be initialized with the subset of stream parameters
+(channels, format, sample rate) supported by all DAIs on the link. Since
+there is no way to provide these parameters in the device tree, this is
+mostly useful for communication with simple fixed-function codecs, such
+as a Bluetooth controller or cellular modem.
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 9b794775df53..320e648f7499 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -331,6 +331,50 @@ static int asoc_simple_init_dai(struct snd_soc_dai *dai,
 	return 0;
 }
 
+static int asoc_simple_init_dai_link_params(struct snd_soc_pcm_runtime *rtd,
+					    struct simple_dai_props *dai_props)
+{
+	struct snd_soc_dai_link *dai_link = rtd->dai_link;
+	struct snd_soc_component *component;
+	struct snd_soc_pcm_stream *params;
+	struct snd_pcm_hardware hw;
+	int i, ret, stream;
+
+	/* Only codecs should have non_legacy_dai_naming set. */
+	for_each_rtd_components(rtd, i, component) {
+		if (!component->driver->non_legacy_dai_naming)
+			return 0;
+	}
+
+	/* Assumes the capabilities are the same for all supported streams */
+	for (stream = 0; stream < 2; stream++) {
+		ret = snd_soc_runtime_calc_hw(rtd, &hw, stream);
+		if (ret == 0)
+			break;
+	}
+
+	if (ret < 0) {
+		dev_err(rtd->dev, "simple-card: no valid dai_link params\n");
+		return ret;
+	}
+
+	params = devm_kzalloc(rtd->dev, sizeof(*params), GFP_KERNEL);
+	if (!params)
+		return -ENOMEM;
+
+	params->formats = hw.formats;
+	params->rates = hw.rates;
+	params->rate_min = hw.rate_min;
+	params->rate_max = hw.rate_max;
+	params->channels_min = hw.channels_min;
+	params->channels_max = hw.channels_max;
+
+	dai_link->params = params;
+	dai_link->num_params = 1;
+
+	return 0;
+}
+
 int asoc_simple_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
@@ -347,6 +391,10 @@ int asoc_simple_dai_init(struct snd_soc_pcm_runtime *rtd)
 	if (ret < 0)
 		return ret;
 
+	ret = asoc_simple_init_dai_link_params(rtd, dai_props);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(asoc_simple_dai_init);
-- 
2.20.1

