Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9A1C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 872782065E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261611;
	bh=GwixDRIoyH/k1UNYUFK1YYn4Esbpdb5Z0b8IK21pRu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GyZWbgRl5YRq5SouzoD5cVfsgNndTiDLfEhDlsRV5lWZJ4lrO3KtaUgky1I3sdhFB
	 hxS789HXe1X2YJuuQ3F+7M7XCC926q/s5q99smpHr10Dw+aEqXlQ8iQ4+7R6DeCX0C
	 uGpuKYhjRzCIIqSFoXSCwQf5u0i4i2aUqQDK3BBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388117AbgGTQN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:13:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387468AbgGTQNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:13:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C5C72064B;
        Mon, 20 Jul 2020 16:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261600;
        bh=GwixDRIoyH/k1UNYUFK1YYn4Esbpdb5Z0b8IK21pRu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e8uDKXL5FLsUr3vsFnBbkhba0ELlMJRR62xLnsBgocPE6CFSaUkPFcH6R+ezy8Q3J
         TknjDOrfO09i56KvUlei9ZBN9CebZufR2Ai6e9Zio4QwjTQKe4KWBK/PtbmjwDCW72
         oioOLmSUObla+LKyG7+9YqBWbsSYbQZ3OKF1wjcA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 5.7 144/244] clk: qcom: gcc: Add missing UFS clocks for SM8150
Date:   Mon, 20 Jul 2020 17:36:55 +0200
Message-Id: <20200720152832.700697063@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

commit 37c72e4cae37f0dace1abb3711ede7fbc6d0862a upstream.

Add the missing ufs card and ufs phy clocks for SM8150. They were missed
in earlier addition of clock driver.

Fixes: 2a1d7eb854bb ("clk: qcom: gcc: Add global clock controller driver for SM8150")
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Link: https://lkml.kernel.org/r/20200513065420.32735-2-vkoul@kernel.org
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/qcom/gcc-sm8150.c |   84 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

--- a/drivers/clk/qcom/gcc-sm8150.c
+++ b/drivers/clk/qcom/gcc-sm8150.c
@@ -2872,6 +2872,45 @@ static struct clk_branch gcc_ufs_card_ph
 	},
 };
 
+/* external clocks so add BRANCH_HALT_SKIP */
+static struct clk_branch gcc_ufs_card_rx_symbol_0_clk = {
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x7501c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_ufs_card_rx_symbol_0_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+/* external clocks so add BRANCH_HALT_SKIP */
+static struct clk_branch gcc_ufs_card_rx_symbol_1_clk = {
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x750ac,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_ufs_card_rx_symbol_1_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+/* external clocks so add BRANCH_HALT_SKIP */
+static struct clk_branch gcc_ufs_card_tx_symbol_0_clk = {
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x75018,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_ufs_card_tx_symbol_0_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_ufs_card_unipro_core_clk = {
 	.halt_reg = 0x75058,
 	.halt_check = BRANCH_HALT,
@@ -3052,6 +3091,45 @@ static struct clk_branch gcc_ufs_phy_phy
 	},
 };
 
+/* external clocks so add BRANCH_HALT_SKIP */
+static struct clk_branch gcc_ufs_phy_rx_symbol_0_clk = {
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x7701c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_ufs_phy_rx_symbol_0_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+/* external clocks so add BRANCH_HALT_SKIP */
+static struct clk_branch gcc_ufs_phy_rx_symbol_1_clk = {
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x770ac,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_ufs_phy_rx_symbol_1_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+/* external clocks so add BRANCH_HALT_SKIP */
+static struct clk_branch gcc_ufs_phy_tx_symbol_0_clk = {
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x77018,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_ufs_phy_tx_symbol_0_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_ufs_phy_unipro_core_clk = {
 	.halt_reg = 0x77058,
 	.halt_check = BRANCH_HALT,
@@ -3548,6 +3626,9 @@ static struct clk_regmap *gcc_sm8150_clo
 	[GCC_UFS_CARD_PHY_AUX_CLK_SRC] = &gcc_ufs_card_phy_aux_clk_src.clkr,
 	[GCC_UFS_CARD_PHY_AUX_HW_CTL_CLK] =
 		&gcc_ufs_card_phy_aux_hw_ctl_clk.clkr,
+	[GCC_UFS_CARD_RX_SYMBOL_0_CLK] = &gcc_ufs_card_rx_symbol_0_clk.clkr,
+	[GCC_UFS_CARD_RX_SYMBOL_1_CLK] = &gcc_ufs_card_rx_symbol_1_clk.clkr,
+	[GCC_UFS_CARD_TX_SYMBOL_0_CLK] = &gcc_ufs_card_tx_symbol_0_clk.clkr,
 	[GCC_UFS_CARD_UNIPRO_CORE_CLK] = &gcc_ufs_card_unipro_core_clk.clkr,
 	[GCC_UFS_CARD_UNIPRO_CORE_CLK_SRC] =
 		&gcc_ufs_card_unipro_core_clk_src.clkr,
@@ -3565,6 +3646,9 @@ static struct clk_regmap *gcc_sm8150_clo
 	[GCC_UFS_PHY_PHY_AUX_CLK] = &gcc_ufs_phy_phy_aux_clk.clkr,
 	[GCC_UFS_PHY_PHY_AUX_CLK_SRC] = &gcc_ufs_phy_phy_aux_clk_src.clkr,
 	[GCC_UFS_PHY_PHY_AUX_HW_CTL_CLK] = &gcc_ufs_phy_phy_aux_hw_ctl_clk.clkr,
+	[GCC_UFS_PHY_RX_SYMBOL_0_CLK] = &gcc_ufs_phy_rx_symbol_0_clk.clkr,
+	[GCC_UFS_PHY_RX_SYMBOL_1_CLK] = &gcc_ufs_phy_rx_symbol_1_clk.clkr,
+	[GCC_UFS_PHY_TX_SYMBOL_0_CLK] = &gcc_ufs_phy_tx_symbol_0_clk.clkr,
 	[GCC_UFS_PHY_UNIPRO_CORE_CLK] = &gcc_ufs_phy_unipro_core_clk.clkr,
 	[GCC_UFS_PHY_UNIPRO_CORE_CLK_SRC] =
 		&gcc_ufs_phy_unipro_core_clk_src.clkr,


