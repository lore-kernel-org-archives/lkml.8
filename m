Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE3CC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 22:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A8320801
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 22:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581977066;
	bh=bH3FBL9iAI688kTKzfmDBpqnQ+AmP2ss7KMOYVIasfY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=juR5F3mYicDHoTaTOqtMdyWSc+/jAbhprPK9zSAuiXaD4uzBkUJ/011g51FjVT6aW
	 B2uff3jO3WARmaz55rAlLiGci75uY3Zi9nugmXRZaIAcZ8Ei7vSlsl6La69NEO04Ln
	 XedBzTKQhueZJVjp6zCsm/HBU0Ih5o5zFKNbbvQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgBQWEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 17:04:25 -0500
Received: from foss.arm.com ([217.140.110.172]:42244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgBQWEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 17:04:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94C7B106F;
        Mon, 17 Feb 2020 14:04:24 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1810F3F703;
        Mon, 17 Feb 2020 14:04:23 -0800 (PST)
Date:   Mon, 17 Feb 2020 22:04:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: Applied "regulator: mp5416: Fix output discharge enable bit for LDOs" to the regulator tree
In-Reply-To:  <20200212150223.20042-1-axel.lin@ingics.com>
Message-Id:  <applied-20200212150223.20042-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: mp5416: Fix output discharge enable bit for LDOs

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

From 502cdd605edd95209661c8bf90927af6d05c011c Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 12 Feb 2020 23:02:23 +0800
Subject: [PATCH] regulator: mp5416: Fix output discharge enable bit for LDOs

The .active_discharge_on/.active_discharge_mask settings does not match
the datasheet, fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Link: https://lore.kernel.org/r/20200212150223.20042-1-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mp5416.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/mp5416.c b/drivers/regulator/mp5416.c
index 7954ad17249b..67ce1b52a1a1 100644
--- a/drivers/regulator/mp5416.c
+++ b/drivers/regulator/mp5416.c
@@ -73,7 +73,7 @@
 		.owner			= THIS_MODULE,			\
 	}
 
-#define MP5416LDO(_name, _id)						\
+#define MP5416LDO(_name, _id, _dval)					\
 	[MP5416_LDO ## _id] = {						\
 		.id = MP5416_LDO ## _id,				\
 		.name = _name,						\
@@ -87,9 +87,9 @@
 		.vsel_mask = MP5416_MASK_VSET,				\
 		.enable_reg = MP5416_REG_LDO ##_id,			\
 		.enable_mask = MP5416_REGULATOR_EN,			\
-		.active_discharge_on	= BIT(_id),			\
+		.active_discharge_on	= _dval,			\
 		.active_discharge_reg	= MP5416_REG_CTL2,		\
-		.active_discharge_mask	= BIT(_id),			\
+		.active_discharge_mask	= _dval,			\
 		.owner			= THIS_MODULE,			\
 	}
 
@@ -155,10 +155,10 @@ static struct regulator_desc mp5416_regulators_desc[MP5416_MAX_REGULATORS] = {
 	MP5416BUCK("buck2", 2, mp5416_I_limits2, MP5416_REG_CTL1, BIT(1), 2),
 	MP5416BUCK("buck3", 3, mp5416_I_limits1, MP5416_REG_CTL1, BIT(2), 1),
 	MP5416BUCK("buck4", 4, mp5416_I_limits2, MP5416_REG_CTL2, BIT(5), 2),
-	MP5416LDO("ldo1", 1),
-	MP5416LDO("ldo2", 2),
-	MP5416LDO("ldo3", 3),
-	MP5416LDO("ldo4", 4),
+	MP5416LDO("ldo1", 1, BIT(4)),
+	MP5416LDO("ldo2", 2, BIT(3)),
+	MP5416LDO("ldo3", 3, BIT(2)),
+	MP5416LDO("ldo4", 4, BIT(1)),
 };
 
 /*
-- 
2.20.1

