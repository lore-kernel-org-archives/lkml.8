Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C249CC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 05:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E5D2072D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 05:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="kIPGLoPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgCSFgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 01:36:10 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:49336 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725767AbgCSFgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 01:36:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584596169; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=lXhkIBcKbtLstxQRyAkgmmBBedPpvtcrGcYCAgn01SQ=; b=kIPGLoPhJcmrkNO3wPEFt/OdpJbxfq6zhe5oovB5oHkDPDHWPNThU1CZ3SvgnNGadP/kuk2v
 SxGwXzbAnZ+l1S8j1R8U6vDg9HGwxRMRFEVeB/1zbS6Hq9eOwQqqtNI5JPqLjIm+TnNqdVWo
 pQoCKCrC70aRbzMM6dg3DLvXR3U=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7304bf.7fb8df05a7a0-smtp-out-n03;
 Thu, 19 Mar 2020 05:35:59 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CE94BC432C2; Thu, 19 Mar 2020 05:35:59 +0000 (UTC)
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 14F65C433BA;
        Thu, 19 Mar 2020 05:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 14F65C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v7 2/3] clk: qcom: gcc: Add support for modem clocks in GCC
Date:   Thu, 19 Mar 2020 11:05:30 +0530
Message-Id: <1584596131-22741-3-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584596131-22741-1-git-send-email-tdas@codeaurora.org>
References: <1584596131-22741-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the required modem clocks in global clock controller which are
required to bring the modem out of reset.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/gcc-sc7180.c | 72 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-sc7180.c b/drivers/clk/qcom/gcc-sc7180.c
index 7f59fb8..6a51b5b 100644
--- a/drivers/clk/qcom/gcc-sc7180.c
+++ b/drivers/clk/qcom/gcc-sc7180.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
  */

 #include <linux/clk-provider.h>
@@ -2165,6 +2165,71 @@ static struct clk_branch gcc_video_xo_clk = {
 	},
 };

+static struct clk_branch gcc_mss_cfg_ahb_clk = {
+	.halt_reg = 0x8a000,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x8a000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_mss_cfg_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mss_mfab_axis_clk = {
+	.halt_reg = 0x8a004,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x8a004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_mss_mfab_axis_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mss_nav_axi_clk = {
+	.halt_reg = 0x8a00c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x8a00c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_mss_nav_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mss_snoc_axi_clk = {
+	.halt_reg = 0x8a150,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x8a150,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_mss_snoc_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mss_q6_memnoc_axi_clk = {
+	.halt_reg = 0x8a154,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x8a154,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_mss_q6_memnoc_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct gdsc ufs_phy_gdsc = {
 	.gdscr = 0x77004,
 	.pd = {
@@ -2336,6 +2401,11 @@ static struct clk_regmap *gcc_sc7180_clocks[] = {
 	[GPLL7] = &gpll7.clkr,
 	[GPLL4] = &gpll4.clkr,
 	[GPLL1] = &gpll1.clkr,
+	[GCC_MSS_CFG_AHB_CLK] = &gcc_mss_cfg_ahb_clk.clkr,
+	[GCC_MSS_MFAB_AXIS_CLK] = &gcc_mss_mfab_axis_clk.clkr,
+	[GCC_MSS_NAV_AXI_CLK] = &gcc_mss_nav_axi_clk.clkr,
+	[GCC_MSS_Q6_MEMNOC_AXI_CLK] = &gcc_mss_q6_memnoc_axi_clk.clkr,
+	[GCC_MSS_SNOC_AXI_CLK] = &gcc_mss_snoc_axi_clk.clkr,
 };

 static const struct qcom_reset_map gcc_sc7180_resets[] = {
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
