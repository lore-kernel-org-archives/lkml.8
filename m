Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0DFC3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC45020848
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581627518;
	bh=gGyC2yCilDzrVy2DuoupOHXmFrSvA7OwYuKRmcnlp/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=Kijr32i6Iwt1Qgixx24F2KmZBMeoX8YrdjuZgfKBZE37xy6jgaQTNeWnFWjMk4hsV
	 KG0Tvc6quWl1PMjs8PsbVUMK1dvZRi+ZD8gr3GSnlTU3kq2xxmcext5Ecg6pj5cJGg
	 If7wGHpkhD/h4ykfBePM177k1UrNMwP3BZKvTW5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgBMU6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 15:58:37 -0500
Received: from foss.arm.com ([217.140.110.172]:53628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728591AbgBMU6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 15:58:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D95F21FB;
        Thu, 13 Feb 2020 12:58:35 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DCAE3F6CF;
        Thu, 13 Feb 2020 12:58:35 -0800 (PST)
Date:   Thu, 13 Feb 2020 20:58:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: core: allow a dt node to provide several components" to the asoc tree
In-Reply-To:  <20200213155159.3235792-2-jbrunet@baylibre.com>
Message-Id:  <applied-20200213155159.3235792-2-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: core: allow a dt node to provide several components

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

From 1dfa5a5ab34560fd9647083f623d19705be2e706 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 13 Feb 2020 16:51:51 +0100
Subject: [PATCH] ASoC: core: allow a dt node to provide several components

At the moment, querying the dai_name will stop of the first component
matching the dt node. This does not allow a device (single dt node) to
provide several ASoC components which could then be used through DT.

This change let the search go on if the xlate function of the component
returns an error, giving the possibility to another component to match
and return the dai_name.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20200213155159.3235792-2-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 068d809c349a..03b87427faa7 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3102,6 +3102,14 @@ int snd_soc_get_dai_name(struct of_phandle_args *args,
 			*dai_name = dai->driver->name;
 			if (!*dai_name)
 				*dai_name = pos->name;
+		} else if (ret) {
+			/*
+			 * if another error than ENOTSUPP is returned go on and
+			 * check if another component is provided with the same
+			 * node. This may happen if a device provides several
+			 * components
+			 */
+			continue;
 		}
 
 		break;
-- 
2.20.1

