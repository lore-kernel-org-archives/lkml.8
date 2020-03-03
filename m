Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D975AC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80AB20838
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgCCOam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:30:42 -0500
Received: from inva021.nxp.com ([92.121.34.21]:57390 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728113AbgCCOam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:30:42 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5893E201402;
        Tue,  3 Mar 2020 15:30:40 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CC786201257;
        Tue,  3 Mar 2020 15:30:37 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 61239402F3;
        Tue,  3 Mar 2020 22:30:34 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] regulator: anatop: Drop min dropout for bypass mode
Date:   Tue,  3 Mar 2020 22:24:36 +0800
Message-Id: <1583245476-8009-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of anatop regulators support bypass mode, and in bypass mode,
minimum dropout is NOT required, the input voltage will be equal to
the output voltage. The minimum dropout value is ONLY necessary for
LDO enabled mode, so drop the minimum dropout for bypass mode to
avoid unexpected high voltage output from PMIC supplies.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/regulator/anatop-regulator.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index ca92b3d..1a775d9 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -22,6 +22,7 @@
 #define LDO_POWER_GATE			0x00
 #define LDO_FET_FULL_ON			0x1f
 
+#define LDO_MIN_DROPOUT_UV		125000
 struct anatop_regulator {
 	u32 delay_reg;
 	int delay_bit_shift;
@@ -128,6 +129,10 @@ static int anatop_regmap_set_bypass(struct regulator_dev *reg, bool enable)
 
 	sel = enable ? LDO_FET_FULL_ON : anatop_reg->sel;
 	anatop_reg->bypass = enable;
+	if (anatop_reg->bypass)
+		anatop_reg->rdesc.min_dropout_uV = 0;
+	else
+		anatop_reg->rdesc.min_dropout_uV = LDO_MIN_DROPOUT_UV;
 
 	return regulator_set_voltage_sel_regmap(reg, sel);
 }
@@ -246,7 +251,7 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 	rdesc->linear_min_sel = min_bit_val;
 	rdesc->vsel_reg = control_reg;
 	rdesc->vsel_mask = ((1 << vol_bit_width) - 1) << vol_bit_shift;
-	rdesc->min_dropout_uV = 125000;
+	rdesc->min_dropout_uV = LDO_MIN_DROPOUT_UV;
 
 	config.dev = &pdev->dev;
 	config.init_data = initdata;
@@ -268,6 +273,7 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 		if (sreg->sel == LDO_FET_FULL_ON) {
 			sreg->sel = 0;
 			sreg->bypass = true;
+			rdesc->min_dropout_uV = 0;
 		}
 
 		/*
-- 
2.7.4

