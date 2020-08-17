Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3475FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D7A62072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597648433;
	bh=HKREKe0ESjseHoiLGsj9725lBR8Sr2gmcFmI0WmwD/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tcw54DfUV04Yr9U9rSVCbAVJzWuIFTNQdAVnqM0gD7Qfuuki6i6vjYLb4kz9O7a20
	 Be046TpsaoCKbZi0ggg7By0CSyTNRN1iv4CzogjepTWnX0SkUIG5l4qyK8M9dTYDIh
	 Eg7TZAY5biwp5/rUE8xZRGR2Gn/U3VGnTqjVgsDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgHQHNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:13:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbgHQHLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:11:34 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2150922D2A;
        Mon, 17 Aug 2020 07:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597648278;
        bh=HKREKe0ESjseHoiLGsj9725lBR8Sr2gmcFmI0WmwD/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AQT7gJYFVonWl4yERorYsR26xeHlZZ9FD/7hEZQlbg6ssJvqsWUn5Lv6lSmC2/3L1
         AioDX0P/Ex1yK/pDRZAUe13thDBZI2Gly2pR+fh3idKrju+tWiQGfk8hXj9vx0vtao
         6u6SxiiTmMTDE4rxXC4ON52yaUtSgOayKgNWK3Do=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZIa-00Bdki-9w; Mon, 17 Aug 2020 09:11:16 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH v3 31/44] staging: regulator: hi6421v600-regulator: better handle modes
Date:   Mon, 17 Aug 2020 09:10:50 +0200
Message-Id: <0f4ac5a4167bbca428c8507b6992acd8b3ebabd1.1597647359.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597647359.git.mchehab+huawei@kernel.org>
References: <cover.1597647359.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

