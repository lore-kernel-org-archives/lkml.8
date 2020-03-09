Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DB6C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1E62087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgCIJyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 05:54:16 -0400
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:55524 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726545AbgCIJyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 05:54:10 -0400
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 09 Mar 2020 15:24:02 +0530
Received: from c-sanm-linux.qualcomm.com ([10.206.25.31])
  by ironmsg01-blr.qualcomm.com with ESMTP; 09 Mar 2020 15:23:43 +0530
Received: by c-sanm-linux.qualcomm.com (Postfix, from userid 2343233)
        id A741B245A; Mon,  9 Mar 2020 15:23:42 +0530 (IST)
From:   Sandeep Maheswaram <sanm@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
Subject: [PATCH v5 3/9] phy: qcom-qusb2: Add generic QUSB2 V2 PHY support
Date:   Mon,  9 Mar 2020 15:23:03 +0530
Message-Id: <1583747589-17267-4-git-send-email-sanm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583747589-17267-1-git-send-email-sanm@codeaurora.org>
References: <1583747589-17267-1-git-send-email-sanm@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add generic QUSB2 V2 PHY table so the respective phys
can use the same table.

Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/phy/qualcomm/phy-qcom-qusb2.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
index bf94a52..70c9da6 100644
--- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2017, 2019, The Linux Foundation. All rights reserved.
  */
 
 #include <linux/clk.h>
@@ -177,7 +177,7 @@ static const struct qusb2_phy_init_tbl msm8998_init_tbl[] = {
 	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_DIGITAL_TIMERS_TWO, 0x19),
 };
 
-static const unsigned int sdm845_regs_layout[] = {
+static const unsigned int qusb2_v2_regs_layout[] = {
 	[QUSB2PHY_PLL_CORE_INPUT_OVERRIDE] = 0xa8,
 	[QUSB2PHY_PLL_STATUS]		= 0x1a0,
 	[QUSB2PHY_PORT_TUNE1]		= 0x240,
@@ -191,7 +191,7 @@ static const unsigned int sdm845_regs_layout[] = {
 	[QUSB2PHY_INTR_CTRL]		= 0x230,
 };
 
-static const struct qusb2_phy_init_tbl sdm845_init_tbl[] = {
+static const struct qusb2_phy_init_tbl qusb2_v2_init_tbl[] = {
 	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_ANALOG_CONTROLS_TWO, 0x03),
 	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_CLOCK_INVERTERS, 0x7c),
 	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_CMODE, 0x80),
@@ -258,10 +258,10 @@ static const struct qusb2_phy_cfg msm8998_phy_cfg = {
 	.update_tune1_with_efuse = true,
 };
 
-static const struct qusb2_phy_cfg sdm845_phy_cfg = {
-	.tbl		= sdm845_init_tbl,
-	.tbl_num	= ARRAY_SIZE(sdm845_init_tbl),
-	.regs		= sdm845_regs_layout,
+static const struct qusb2_phy_cfg qusb2_v2_phy_cfg = {
+	.tbl		= qusb2_v2_init_tbl,
+	.tbl_num	= ARRAY_SIZE(qusb2_v2_init_tbl),
+	.regs		= qusb2_v2_regs_layout,
 
 	.disable_ctrl	= (PWR_CTRL1_VREF_SUPPLY_TRIM | PWR_CTRL1_CLAMP_N_EN |
 			   POWER_DOWN),
@@ -774,8 +774,8 @@ static const struct of_device_id qusb2_phy_of_match_table[] = {
 		.compatible	= "qcom,msm8998-qusb2-phy",
 		.data		= &msm8998_phy_cfg,
 	}, {
-		.compatible	= "qcom,sdm845-qusb2-phy",
-		.data		= &sdm845_phy_cfg,
+		.compatible	= "qcom,qusb2-v2-phy",
+		.data		= &qusb2_v2_phy_cfg,
 	},
 	{ },
 };
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

