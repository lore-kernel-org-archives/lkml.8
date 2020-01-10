Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429FEC33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 13:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1851420838
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 13:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578663496;
	bh=VEmbovOTXfNUyE3KCrVca09Kz5Rl/4V8LpuGnpTn3Tw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=cZcxTES9ES79sQGQr2do0BWIAmJjZE99HfUYFJysecWhLY0iI6rFynFi2MdxXHxV+
	 DkBoz2T7L7LfDKf9xAoRFFAc2Tu8LWgkxYErKRve9TFu4ZAshgwZgZCvS/A4UVAt3F
	 LHGsg76AHm1td/ccr9ea54FVUL3qOThxfNICsTe8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgAJNiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 08:38:15 -0500
Received: from foss.arm.com ([217.140.110.172]:44574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbgAJNiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 08:38:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D054DA7;
        Fri, 10 Jan 2020 05:38:14 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBADB3F534;
        Fri, 10 Jan 2020 05:38:13 -0800 (PST)
Date:   Fri, 10 Jan 2020 13:38:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, sfr@canb.auug.org.au,
        sravanhome@gmail.com
Subject: Applied "regulator: mpq7920: Fix Woverflow warning on conversion" to the regulator tree
In-Reply-To: <20200110102220.7163-1-sravanhome@gmail.com>
Message-Id: <applied-20200110102220.7163-1-sravanhome@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: mpq7920: Fix Woverflow warning on conversion

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.6

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

From 686f63616f4aede1356c1bc9fa4e9a92a123bcd6 Mon Sep 17 00:00:00 2001
From: Saravanan Sekar <sravanhome@gmail.com>
Date: Fri, 10 Jan 2020 11:22:20 +0100
Subject: [PATCH] regulator: mpq7920: Fix Woverflow warning on conversion

Fix warning Woverflow on type conversion reported on x86.

Fixes: 6501c1f54a17 (regulator: mpq7920: add mpq7920 regulator driver)
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Link: https://lore.kernel.org/r/20200110102220.7163-1-sravanhome@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mpq7920.c | 2 +-
 drivers/regulator/mpq7920.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/mpq7920.c b/drivers/regulator/mpq7920.c
index c603d60fb87b..ab1b847c57e5 100644
--- a/drivers/regulator/mpq7920.c
+++ b/drivers/regulator/mpq7920.c
@@ -221,7 +221,7 @@ static int mpq7920_parse_cb(struct device_node *np,
 	if (of_property_read_bool(np, "mps,buck-ovp-disable")) {
 		regmap_update_bits(config->regmap,
 				MPQ7920_BUCK1_REG_B + (rdesc->id * 4),
-				BIT(6), ~BIT(6));
+				MPQ7920_MASK_OVP, MPQ7920_OVP_DISABLE);
 	}
 
 	ret = of_property_read_u8(np, "mps,buck-phase-delay", &val);
diff --git a/drivers/regulator/mpq7920.h b/drivers/regulator/mpq7920.h
index 6a93bfbc750c..1498a1e3f4f5 100644
--- a/drivers/regulator/mpq7920.h
+++ b/drivers/regulator/mpq7920.h
@@ -55,6 +55,8 @@
 #define MPQ7920_MASK_SWITCH_FREQ	0x30
 #define MPQ7920_MASK_BUCK_PHASE_DEALY	0x30
 #define MPQ7920_MASK_DVS_SLEWRATE	0xc0
+#define MPQ7920_MASK_OVP		0x40
+#define MPQ7920_OVP_DISABLE		~(0x40)
 #define MPQ7920_DISCHARGE_ON		0x1
 
 #define MPQ7920_REGULATOR_EN_OFFSET	7
-- 
2.20.1

