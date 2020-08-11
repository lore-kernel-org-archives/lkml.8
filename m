Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35538C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 146DA2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597160609;
	bh=EM8xwYqFyPCc8YIAFgm1sKwYiM4kDXc6SIjF6+gXtKo=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=ovk6C4Oi/+ZGVDMuU4VMNYEqr2+l6/y5Lwxw8Xdl5d5qHyLAH2jpdXI2Ya6Fn5YYO
	 YqcGcMy5zbiZgej6mSEPpDU+13pR0GRS2aiiXNBagYzN7BUHjACtyoXSsAg9DopxoF
	 gtiDr/p7ueqnOyop7bPiA1Y5e4B1h7XhlhheurpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgHKPnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:43:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729002AbgHKPmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:42:07 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7ABA22D0B;
        Tue, 11 Aug 2020 15:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597160524;
        bh=EM8xwYqFyPCc8YIAFgm1sKwYiM4kDXc6SIjF6+gXtKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZEsN7BQSq4ZdtleqNhdPpRedEfBxyjSOhrrsQHUEdSKVozl20LlE7mjISRQXsfePD
         ipEqRI6ifpnNd9bOm1qhNLy514mD5qY04+iWjMwir6IeXojTY9tWmfPru4DVikS6WK
         7N7DCLA7OJRFMAS3gNNdhmvdvBH2Okzjlez8sVaA=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5WPa-004bnI-18; Tue, 11 Aug 2020 17:42:02 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 23/33] regulator: hi6421v600-regulator: better handle modes
Date:   Tue, 11 Aug 2020 17:41:49 +0200
Message-Id: <61c68dca0c7522d63a529cfb925d238f923f74f5.1597160086.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597160086.git.mchehab+huawei@kernel.org>
References: <cover.1597160086.git.mchehab+huawei@kernel.org>
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
 drivers/regulator/hi6421v600-regulator.c | 32 ++++++++----------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/regulator/hi6421v600-regulator.c b/drivers/regulator/hi6421v600-regulator.c
index e4a64893a7ad..bde7fa4d7e8f 100644
--- a/drivers/regulator/hi6421v600-regulator.c
+++ b/drivers/regulator/hi6421v600-regulator.c
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

