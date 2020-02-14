Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6BAC3B1BF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE88222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581713795;
	bh=zdsPPUoi7S6CohbWuEgA9cX+8ZgcyXdq+J04QATwkS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=yTM+KrYsb15/WGxdyjrVI39UrJOgTbE4eOeXLva6eytKnswSwLUTLvgtC2mtyZfIY
	 ES2nhQMFeogvyFC0kQhMFTuoHSXUFbV0HUym07Mev3tH1LiE0/AoIHWfWXIFSeuNyM
	 FjIDVFFY7SWkN8OBs5FiiIKqZM6hxPgfEDDxEWCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388710AbgBNU4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:56:34 -0500
Received: from foss.arm.com ([217.140.110.172]:45004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387526AbgBNU4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:56:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01D1230E;
        Fri, 14 Feb 2020 12:56:32 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 784BF3F68F;
        Fri, 14 Feb 2020 12:56:31 -0800 (PST)
Date:   Fri, 14 Feb 2020 20:56:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        kbuild test robot <lkp@intel.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: aiu: fix clk bulk size allocation" to the asoc tree
In-Reply-To:  <20200214131350.337968-3-jbrunet@baylibre.com>
Message-Id:  <applied-20200214131350.337968-3-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: aiu: fix clk bulk size allocation

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

From 269f00171273e47eebc915cc6ee8ceececa37a3a Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 14 Feb 2020 14:13:47 +0100
Subject: [PATCH] ASoC: meson: aiu: fix clk bulk size allocation

Fix the size of allocated memory for the clock bulk data

Fixes: 6ae9ca9ce986 ("ASoC: meson: aiu: add i2s and spdif support")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20200214131350.337968-3-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/aiu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/meson/aiu.c b/sound/soc/meson/aiu.c
index 5c4845a23a34..de678a9d5cab 100644
--- a/sound/soc/meson/aiu.c
+++ b/sound/soc/meson/aiu.c
@@ -203,7 +203,7 @@ static int aiu_clk_bulk_get(struct device *dev,
 	struct clk_bulk_data *clks;
 	int i, ret;
 
-	clks = devm_kcalloc(dev, num, sizeof(clks), GFP_KERNEL);
+	clks = devm_kcalloc(dev, num, sizeof(*clks), GFP_KERNEL);
 	if (!clks)
 		return -ENOMEM;
 
-- 
2.20.1

