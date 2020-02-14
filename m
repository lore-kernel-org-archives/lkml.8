Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3078C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D46D24650
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581713780;
	bh=XjOFCPJe79MZ075noW1paO9FwvjLeDvBIagD6B8B8pk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=eJHLvfjgG0pMSXGg3Z7zfJBYqxrpZQvgDeC/Cipj0RxGrammGkqlgtq/YeSWFxHnp
	 YDbq0V0g7PrLJgSdwkcM2aiJLXg5e7pc6db5/fC6wLJSNzfKqeYxuz4Jo8zRZGd0Mk
	 NXC6IEI3MZk8+XKMpf1k/p54Ndv8k73QTrfxvV+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388030AbgBNU4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:56:19 -0500
Received: from foss.arm.com ([217.140.110.172]:44960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730150AbgBNU4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:56:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6467E30E;
        Fri, 14 Feb 2020 12:56:18 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D73A53F68F;
        Fri, 14 Feb 2020 12:56:17 -0800 (PST)
Date:   Fri, 14 Feb 2020 20:56:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        kbuild test robot <lkp@intel.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: codec-glue: fix pcm format cast warning" to the asoc tree
In-Reply-To:  <20200214131350.337968-6-jbrunet@baylibre.com>
Message-Id:  <applied-20200214131350.337968-6-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: codec-glue: fix pcm format cast warning

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

From 3cd23f021e2e5f3350125abcb39f12430df87d06 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 14 Feb 2020 14:13:50 +0100
Subject: [PATCH] ASoC: meson: codec-glue: fix pcm format cast warning

Clarify the cast of snd_pcm_format_t and fix the sparse warning:
restricted snd_pcm_format_t degrades to integer

Fixes: 9c29fd9bdf92 ("ASoC: meson: g12a: extract codec-to-codec utils")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20200214131350.337968-6-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/meson-codec-glue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/meson/meson-codec-glue.c b/sound/soc/meson/meson-codec-glue.c
index 97bbc967e176..524a33472337 100644
--- a/sound/soc/meson/meson-codec-glue.c
+++ b/sound/soc/meson/meson-codec-glue.c
@@ -74,7 +74,7 @@ int meson_codec_glue_input_hw_params(struct snd_pcm_substream *substream,
 	data->params.rates = snd_pcm_rate_to_rate_bit(params_rate(params));
 	data->params.rate_min = params_rate(params);
 	data->params.rate_max = params_rate(params);
-	data->params.formats = 1 << params_format(params);
+	data->params.formats = 1ULL << (__force int) params_format(params);
 	data->params.channels_min = params_channels(params);
 	data->params.channels_max = params_channels(params);
 	data->params.sig_bits = dai->driver->playback.sig_bits;
-- 
2.20.1

