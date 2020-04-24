Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E15C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 04:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA61F20767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 04:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587703407;
	bh=iNmFScr18oN2eDrbxAgPlz5bhULsk0p3yjhL8V85T8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jKhwToex3huyJjnm0KeQ3/ZYYpOkHKjscrGrCLI+EfIFerUGDnO8wuRAvwvEha8rn
	 NL7aXOyHftkTkM3Pk38y11t7fKxoeegUl4YTJJ4rbDde2TTqI3nELoRCa/b75ohjRO
	 I0O1av66DCkSpM1g6pOOMZzpcYExiK+N/3di4d6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgDXEn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 00:43:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgDXEnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 00:43:25 -0400
Received: from vkoul-mobl.Dlink (unknown [106.51.110.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2267820767;
        Fri, 24 Apr 2020 04:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587703405;
        bh=iNmFScr18oN2eDrbxAgPlz5bhULsk0p3yjhL8V85T8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zvHAxowI7UC/F+I+kZziK75HAMEtVvqttWHYoQUEOmwuiCGM9zRQtUqpdnXExS3HS
         dpjiF5K8hAJ0H0W++6vA8dcSq/vmLQF0AANRlgTKi5CzvRFc4TX8qjP9e472a0yBKf
         ZfwGYR06wnl6c5iIv87TqD7Exzm0Gj58KFBSPgkU=
From:   Vinod Koul <vkoul@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] clk: qcom: gcc: Add missing UFS clocks for SM8150
Date:   Fri, 24 Apr 2020 10:13:11 +0530
Message-Id: <20200424044311.2155917-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200424044311.2155917-1-vkoul@kernel.org>
References: <20200424044311.2155917-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing ufs card and ufs phy clocks for SM8150. They were missed
in earlier addition of clock driver.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/clk/qcom/gcc-sm8150.c | 84 +++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
index 5c3dc34c955e..4354620fa12d 100644
--- a/drivers/clk/qcom/gcc-sm8150.c
+++ b/drivers/clk/qcom/gcc-sm8150.c
@@ -2881,6 +2881,45 @@ static struct clk_branch gcc_ufs_card_phy_aux_hw_ctl_clk = {
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
@@ -3061,6 +3100,45 @@ static struct clk_branch gcc_ufs_phy_phy_aux_hw_ctl_clk = {
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
@@ -3557,6 +3635,9 @@ static struct clk_regmap *gcc_sm8150_clocks[] = {
 	[GCC_UFS_CARD_PHY_AUX_CLK_SRC] = &gcc_ufs_card_phy_aux_clk_src.clkr,
 	[GCC_UFS_CARD_PHY_AUX_HW_CTL_CLK] =
 		&gcc_ufs_card_phy_aux_hw_ctl_clk.clkr,
+	[GCC_UFS_CARD_RX_SYMBOL_0_CLK] = &gcc_ufs_card_rx_symbol_0_clk.clkr,
+	[GCC_UFS_CARD_RX_SYMBOL_1_CLK] = &gcc_ufs_card_rx_symbol_1_clk.clkr,
+	[GCC_UFS_CARD_TX_SYMBOL_0_CLK] = &gcc_ufs_card_tx_symbol_0_clk.clkr,
 	[GCC_UFS_CARD_UNIPRO_CORE_CLK] = &gcc_ufs_card_unipro_core_clk.clkr,
 	[GCC_UFS_CARD_UNIPRO_CORE_CLK_SRC] =
 		&gcc_ufs_card_unipro_core_clk_src.clkr,
@@ -3574,6 +3655,9 @@ static struct clk_regmap *gcc_sm8150_clocks[] = {
 	[GCC_UFS_PHY_PHY_AUX_CLK] = &gcc_ufs_phy_phy_aux_clk.clkr,
 	[GCC_UFS_PHY_PHY_AUX_CLK_SRC] = &gcc_ufs_phy_phy_aux_clk_src.clkr,
 	[GCC_UFS_PHY_PHY_AUX_HW_CTL_CLK] = &gcc_ufs_phy_phy_aux_hw_ctl_clk.clkr,
+	[GCC_UFS_PHY_RX_SYMBOL_0_CLK] = &gcc_ufs_phy_rx_symbol_0_clk.clkr,
+	[GCC_UFS_PHY_RX_SYMBOL_1_CLK] = &gcc_ufs_phy_rx_symbol_1_clk.clkr,
+	[GCC_UFS_PHY_TX_SYMBOL_0_CLK] = &gcc_ufs_phy_tx_symbol_0_clk.clkr,
 	[GCC_UFS_PHY_UNIPRO_CORE_CLK] = &gcc_ufs_phy_unipro_core_clk.clkr,
 	[GCC_UFS_PHY_UNIPRO_CORE_CLK_SRC] =
 		&gcc_ufs_phy_unipro_core_clk_src.clkr,
-- 
2.25.1

