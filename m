Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2623FC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3A4206E5
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581551861;
	bh=9q9xnxmox90/77WEQ4J2KRiCOFD5p2qd8iwtV38NJ+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=Nq7PkjQhbztM1ylJcbqlXylm328Iwu69E+W+4zI7ygfbl2ZSK9UzVpsr0FJMGgcd6
	 hVDnWZhIWVVj9mvKdnxtq1befGplIEbkFdC2d9srYL/7gKqd1vDIANjqzKOlrEX+XA
	 YI3G5HxxBSEU1GKgU+mlAi1aV8XQgwxlOZ1jow4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgBLX5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 18:57:40 -0500
Received: from foss.arm.com ([217.140.110.172]:39808 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729397AbgBLX5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:57:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EFB6113E;
        Wed, 12 Feb 2020 15:57:39 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8F373F68E;
        Wed, 12 Feb 2020 15:57:38 -0800 (PST)
Date:   Wed, 12 Feb 2020 23:57:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     alsa-devel@alsa-project.org, Christoph Hellwig <hch@lst.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: sh: fsi: Restore devm_ioremap() alignment" to the asoc tree
In-Reply-To:  <20200212085008.9652-1-geert+renesas@glider.be>
Message-Id:  <applied-20200212085008.9652-1-geert+renesas@glider.be>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sh: fsi: Restore devm_ioremap() alignment

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

From 82dabf599b221a712e951b9061c56669565552a9 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 12 Feb 2020 09:50:08 +0100
Subject: [PATCH] ASoC: sh: fsi: Restore devm_ioremap() alignment

The alignment of the continuation of the devm_ioremap() call in
fsi_probe() was broken.  Join the lines, as all parameters can fit on a
single line.

Fixes: 4bdc0d676a643140 ("remove ioremap_nocache and devm_ioremap_nocache")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20200212085008.9652-1-geert+renesas@glider.be
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/fsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 4b35ef402604..5ef4221be6c3 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1938,8 +1938,7 @@ static int fsi_probe(struct platform_device *pdev)
 	if (!master)
 		return -ENOMEM;
 
-	master->base = devm_ioremap(&pdev->dev,
-					    res->start, resource_size(res));
+	master->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
 	if (!master->base) {
 		dev_err(&pdev->dev, "Unable to ioremap FSI registers.\n");
 		return -ENXIO;
-- 
2.20.1

