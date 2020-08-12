Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507E4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A1FD207F7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597247913;
	bh=HKREKe0ESjseHoiLGsj9725lBR8Sr2gmcFmI0WmwD/M=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=kQss2axdu1UqanX6CS5hL5OVHPnFAeVz6MXy6qe4VXebbhcwqh2jYRCHewiD2XYhA
	 7cgWneBIo6XS3MOWYgkI0m9LMlT4OxBSAKPYpwlv05MC9EP8L/d+1DQuEpQzNJ7Kyp
	 T7s0HiLxhRfDECHebQwMIMYvDKLqrrlxDd8buhlc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgHLP6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:58:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgHLP5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:57:04 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D30B822DD3;
        Wed, 12 Aug 2020 15:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597247821;
        bh=HKREKe0ESjseHoiLGsj9725lBR8Sr2gmcFmI0WmwD/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W9mKyuwnP1vqBuF1brHM54UpZN093Z6suOHxKv3oo2ZNbsZO8r16575deR1HkW/9G
         hW0AqOcTX+MWrOTzSlR58+md4vx2L0QyOVuPZrYHhcKf5AcrjX3LexmzBT1zvf0pBP
         EjOoRIH+mohPzqhFHDkHeEBrPsbCkrpNbjbCFFtY=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5t7a-005t70-Tf; Wed, 12 Aug 2020 17:56:58 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 31/44] staging: regulator: hi6421v600-regulator: better handle modes
Date:   Wed, 12 Aug 2020 17:56:41 +0200
Message-Id: <18e0cd2c2e9bd3247ad29e6e2105a545774c82a2.1597247164.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597247164.git.mchehab+huawei@kernel.org>
References: <cover.1597247164.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of implementing a custom set of properties, set
valid_modes_mask based on having or not a mask for enabling
the eco_mode.

This makes the code clearer, and remove some uneeded props
from DT.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../staging/hikey9xx/hi6421v600-regulator.c   | 32 ++++++-------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421v600-regulator.c b/drivers/staging/hikey9xx/hi6421v600-regulator.c
index e4a64893a7ad..bde7fa4d7e8f 100644
--- a/drivers/staging/hikey9xx/hi6421v600-regulator.c
+++ b/drivers/staging/hikey9xx/hi6421v600-regulator.c
@@ -338,7 +338,6 @@ static int hisi_regulator_probe_ldo(struct platform_device *pdev,
 	struct regulator_config config = { };
 	struct regulation_constraints *constraint;
 	const char *supplyname = NULL;
-	unsigned int temp_modes;
 	int ret = 0;
 
 	initdata = of_get_regulator_init_data(dev, np, NULL);
@@ -347,25 +346,6 @@ static int hisi_regulator_probe_ldo(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
-	/* hisi regulator supports two modes */
-	constraint = &initdata->constraints;
-
-	ret = of_property_read_u32_array(np, "valid-modes-mask",
-					 &constraint->valid_modes_mask, 1);
-	if (ret) {
-		dev_err(dev, "no valid modes mask\n");
-		ret = -ENODEV;
-		return ret;
-	}
-	ret = of_property_read_u32_array(np, "valid-idle-mask",
-					 &temp_modes, 1);
-	if (ret) {
-		dev_err(dev, "no valid idle mask\n");
-		ret = -ENODEV;
-		return ret;
-	}
-	constraint->valid_ops_mask |= temp_modes;
-
 	sreg = kzalloc(sizeof(*sreg), GFP_KERNEL);
 	if (!sreg)
 		return -ENOMEM;
@@ -387,6 +367,15 @@ static int hisi_regulator_probe_ldo(struct platform_device *pdev,
 	if (ret)
 		goto hisi_probe_end;
 
+	/* hisi regulator supports two modes */
+	constraint = &initdata->constraints;
+
+	constraint->valid_modes_mask = REGULATOR_MODE_NORMAL;
+	if (sreg->eco_mode_mask) {
+		constraint->valid_modes_mask |= REGULATOR_MODE_IDLE;
+		constraint->valid_ops_mask |= REGULATOR_CHANGE_MODE;
+	}
+
 	config.dev = &pdev->dev;
 	config.init_data = initdata;
 	config.driver_data = sreg;
@@ -401,8 +390,7 @@ static int hisi_regulator_probe_ldo(struct platform_device *pdev,
 		goto hisi_probe_end;
 	}
 
-	dev_dbg(dev, "%s:valid_modes_mask: 0x%x, valid_ops_mask: 0x%x\n",
-		 rdesc->name,
+	dev_dbg(dev, "valid_modes_mask: 0x%x, valid_ops_mask: 0x%x\n",
 		 constraint->valid_modes_mask, constraint->valid_ops_mask);
 
 	dev_set_drvdata(dev, rdev);
-- 
2.26.2

