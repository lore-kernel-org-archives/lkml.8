Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF40C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9F5222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581713789;
	bh=G2ZaCVSZUKQRR4ZTO3jw8GltKv8W/DOSeNrG+fQnmAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=2brPV9hkbJZh6+HP+aCN2+GqZXLdaHLXKu5FQCPWDY+Hd0SA9ZkYTm1oVkaTeNlkY
	 qzQe9ruA/R1K0jfgL8cbfJwOw978J1iv43h2C9VJsWTh6v92zli62enUNDHscwtq3c
	 VkgtEX7W4i9NdPUJC0twKNGhOvJ7i31iXQN5oGwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388605AbgBNU42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:56:28 -0500
Received: from foss.arm.com ([217.140.110.172]:44986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388053AbgBNU41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:56:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8681930E;
        Fri, 14 Feb 2020 12:56:27 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A7363F68F;
        Fri, 14 Feb 2020 12:56:26 -0800 (PST)
Date:   Fri, 14 Feb 2020 20:56:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        kbuild test robot <lkp@intel.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: aiu: fix irq registration" to the asoc tree
In-Reply-To:  <20200214131350.337968-4-jbrunet@baylibre.com>
Message-Id:  <applied-20200214131350.337968-4-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: aiu: fix irq registration

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

From 6e700f0672199f773ad645c2b7e886c1d2e2046e Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 14 Feb 2020 14:13:48 +0100
Subject: [PATCH] ASoC: meson: aiu: fix irq registration

The aiu stored the irq in an unsigned integer which may have discarded an
error returned by platform_get_irq_byname(). This is incorrect and should
have been a signed integer.

Also drop the irq error traces from the probe function as this is already
done by platform_get_irq_byname().

Fixes: 6ae9ca9ce986 ("ASoC: meson: aiu: add i2s and spdif support")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20200214131350.337968-4-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/aiu.c | 8 ++------
 sound/soc/meson/aiu.h | 2 +-
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/meson/aiu.c b/sound/soc/meson/aiu.c
index de678a9d5cab..34b40b8b8299 100644
--- a/sound/soc/meson/aiu.c
+++ b/sound/soc/meson/aiu.c
@@ -314,16 +314,12 @@ static int aiu_probe(struct platform_device *pdev)
 	}
 
 	aiu->i2s.irq = platform_get_irq_byname(pdev, "i2s");
-	if (aiu->i2s.irq < 0) {
-		dev_err(dev, "Can't get i2s irq\n");
+	if (aiu->i2s.irq < 0)
 		return aiu->i2s.irq;
-	}
 
 	aiu->spdif.irq = platform_get_irq_byname(pdev, "spdif");
-	if (aiu->spdif.irq < 0) {
-		dev_err(dev, "Can't get spdif irq\n");
+	if (aiu->spdif.irq < 0)
 		return aiu->spdif.irq;
-	}
 
 	ret = aiu_clk_get(dev);
 	if (ret)
diff --git a/sound/soc/meson/aiu.h b/sound/soc/meson/aiu.h
index a65a576e3400..097c26de7b7c 100644
--- a/sound/soc/meson/aiu.h
+++ b/sound/soc/meson/aiu.h
@@ -26,7 +26,7 @@ enum aiu_clk_ids {
 struct aiu_interface {
 	struct clk_bulk_data *clks;
 	unsigned int clk_num;
-	unsigned int irq;
+	int irq;
 };
 
 struct aiu {
-- 
2.20.1

