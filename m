Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7C8C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6BC322CB1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261409;
	bh=+Yu0yXXoWm65CQbTb8rEu8e9JDG41uLdmHPn23u0NFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1jCzh4MR4EC9U0m8WjRobcC8Qho/GngPxmGpdJ/eIvL2CvUTn1t/RRla5Ph1DxESv
	 ePqJtneCkLfHbCNh6PJRKBjJnQaXzZkZidtu7brhUMHtfVnGBMYJmnA3b12ZpWpMCF
	 1fHM5KVsBdT2SCwpOqzbh+mSHis+V17+/184hgQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387625AbgGTQKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387607AbgGTQKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:10:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27D382064B;
        Mon, 20 Jul 2020 16:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261403;
        bh=+Yu0yXXoWm65CQbTb8rEu8e9JDG41uLdmHPn23u0NFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mfKcPSTSyKrEUKFgxc6IAmQlYiiGAZVRjtOtG5QGyICK1nxOBlqLiO4QMuF4t5r+2
         JEK3uEI3MqCE6X+DnT2e+hUOB3gzWvnbOUaoTOnh0rcH4x2xZrsOcpolO2toOU7uf1
         8PqrB+Kz0SJnMrG5d6T4J/yhaXmOq9/KCPQ2YrC0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eddie James <eajames@linux.ibm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>, Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 102/244] clk: AST2600: Add mux for EMMC clock
Date:   Mon, 20 Jul 2020 17:36:13 +0200
Message-Id: <20200720152830.684860477@linuxfoundation.org>
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

From: Eddie James <eajames@linux.ibm.com>

[ Upstream commit c2407ab3bd55064d459bc822efd1c134e852798c ]

The EMMC clock can be derived from either the HPLL or the MPLL. Register
a clock mux so that the rate is calculated correctly based upon the
parent.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Link: https://lore.kernel.org/r/20200709195706.12741-2-eajames@linux.ibm.com
Acked-by: Joel Stanley <joel@jms.id.au>
Fixes: d3d04f6c330a ("clk: Add support for AST2600 SoC")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-ast2600.c | 49 ++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
index 99afc949925f0..177368cac6dd6 100644
--- a/drivers/clk/clk-ast2600.c
+++ b/drivers/clk/clk-ast2600.c
@@ -131,6 +131,18 @@ static const struct clk_div_table ast2600_eclk_div_table[] = {
 	{ 0 }
 };
 
+static const struct clk_div_table ast2600_emmc_extclk_div_table[] = {
+	{ 0x0, 2 },
+	{ 0x1, 4 },
+	{ 0x2, 6 },
+	{ 0x3, 8 },
+	{ 0x4, 10 },
+	{ 0x5, 12 },
+	{ 0x6, 14 },
+	{ 0x7, 16 },
+	{ 0 }
+};
+
 static const struct clk_div_table ast2600_mac_div_table[] = {
 	{ 0x0, 4 },
 	{ 0x1, 4 },
@@ -390,6 +402,11 @@ static struct clk_hw *aspeed_g6_clk_hw_register_gate(struct device *dev,
 	return hw;
 }
 
+static const char *const emmc_extclk_parent_names[] = {
+	"emmc_extclk_hpll_in",
+	"mpll",
+};
+
 static const char * const vclk_parent_names[] = {
 	"dpll",
 	"d1pll",
@@ -459,16 +476,32 @@ static int aspeed_g6_clk_probe(struct platform_device *pdev)
 		return PTR_ERR(hw);
 	aspeed_g6_clk_data->hws[ASPEED_CLK_UARTX] = hw;
 
-	/* EMMC ext clock divider */
-	hw = clk_hw_register_gate(dev, "emmc_extclk_gate", "hpll", 0,
-			scu_g6_base + ASPEED_G6_CLK_SELECTION1, 15, 0,
-			&aspeed_g6_clk_lock);
+	/* EMMC ext clock */
+	hw = clk_hw_register_fixed_factor(dev, "emmc_extclk_hpll_in", "hpll",
+					  0, 1, 2);
 	if (IS_ERR(hw))
 		return PTR_ERR(hw);
-	hw = clk_hw_register_divider_table(dev, "emmc_extclk", "emmc_extclk_gate", 0,
-			scu_g6_base + ASPEED_G6_CLK_SELECTION1, 12, 3, 0,
-			ast2600_div_table,
-			&aspeed_g6_clk_lock);
+
+	hw = clk_hw_register_mux(dev, "emmc_extclk_mux",
+				 emmc_extclk_parent_names,
+				 ARRAY_SIZE(emmc_extclk_parent_names), 0,
+				 scu_g6_base + ASPEED_G6_CLK_SELECTION1, 11, 1,
+				 0, &aspeed_g6_clk_lock);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
+	hw = clk_hw_register_gate(dev, "emmc_extclk_gate", "emmc_extclk_mux",
+				  0, scu_g6_base + ASPEED_G6_CLK_SELECTION1,
+				  15, 0, &aspeed_g6_clk_lock);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
+	hw = clk_hw_register_divider_table(dev, "emmc_extclk",
+					   "emmc_extclk_gate", 0,
+					   scu_g6_base +
+						ASPEED_G6_CLK_SELECTION1, 12,
+					   3, 0, ast2600_emmc_extclk_div_table,
+					   &aspeed_g6_clk_lock);
 	if (IS_ERR(hw))
 		return PTR_ERR(hw);
 	aspeed_g6_clk_data->hws[ASPEED_CLK_EMMC] = hw;
-- 
2.25.1



