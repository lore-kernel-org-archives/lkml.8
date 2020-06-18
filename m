Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E305C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D5AE20853
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592446475;
	bh=D10H/Hi5j6L+G6VVFSuWkYjliITCpHndKHjj172hRo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CJnsmmIiTpZqYtB16SA4tLKZECTUhjWG3gKrf9HWa8bnxfLzI00dU0Kv/zPstdugc
	 RJvvZlvgEeK6Mo+OG72oK03f2u7TpDJFA79ob2mEzRY+3EbW2UonxvpOuh/FzK2DOz
	 InuYmwxPfWN7BEUQcn+/wrQLVDAn8Ff1g00x236g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbgFRCOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:14:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729316AbgFRBUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:20:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEA8A21974;
        Thu, 18 Jun 2020 01:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443248;
        bh=D10H/Hi5j6L+G6VVFSuWkYjliITCpHndKHjj172hRo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qRRtq6RIwjs/myOk09yNzJjf/fFDfRe6apEmKtn+tsL0kKrkKtRbJKXyU9xCgaTpi
         r1HzWJAC8klwZXEfziDJxpIUxmqB+BSf/XawfAXBngkIKxlkhuekB7wqSP0CYQuMD9
         QMxFiKtPLIa7i+5pgIMqF1Bn5FcGpDvt07A/VN44=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eddie James <eajames@linux.ibm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 198/266] clk: ast2600: Fix AHB clock divider for A1
Date:   Wed, 17 Jun 2020 21:15:23 -0400
Message-Id: <20200618011631.604574-198-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eddie James <eajames@linux.ibm.com>

[ Upstream commit 2d491066ccd4286538450c227fc5094ceb04b494 ]

The latest specs for the AST2600 A1 chip include some different bit
definitions for calculating the AHB clock divider. Implement these in
order to get the correct AHB clock value in Linux.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Link: https://lkml.kernel.org/r/20200408203616.4031-1-eajames@linux.ibm.com
Fixes: d3d04f6c330a ("clk: Add support for AST2600 SoC")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-ast2600.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
index b1318e6b655b..675cab6fa781 100644
--- a/drivers/clk/clk-ast2600.c
+++ b/drivers/clk/clk-ast2600.c
@@ -599,14 +599,22 @@ static const u32 ast2600_a0_axi_ahb_div_table[] = {
 	2, 2, 3, 5,
 };
 
-static const u32 ast2600_a1_axi_ahb_div_table[] = {
-	4, 6, 2, 4,
+static const u32 ast2600_a1_axi_ahb_div0_tbl[] = {
+	3, 2, 3, 4,
+};
+
+static const u32 ast2600_a1_axi_ahb_div1_tbl[] = {
+	3, 4, 6, 8,
+};
+
+static const u32 ast2600_a1_axi_ahb200_tbl[] = {
+	3, 4, 3, 4, 2, 2, 2, 2,
 };
 
 static void __init aspeed_g6_cc(struct regmap *map)
 {
 	struct clk_hw *hw;
-	u32 val, div, chip_id, axi_div, ahb_div;
+	u32 val, div, divbits, chip_id, axi_div, ahb_div;
 
 	clk_hw_register_fixed_rate(NULL, "clkin", NULL, 0, 25000000);
 
@@ -636,11 +644,22 @@ static void __init aspeed_g6_cc(struct regmap *map)
 	else
 		axi_div = 2;
 
+	divbits = (val >> 11) & 0x3;
 	regmap_read(map, ASPEED_G6_SILICON_REV, &chip_id);
-	if (chip_id & BIT(16))
-		ahb_div = ast2600_a1_axi_ahb_div_table[(val >> 11) & 0x3];
-	else
+	if (chip_id & BIT(16)) {
+		if (!divbits) {
+			ahb_div = ast2600_a1_axi_ahb200_tbl[(val >> 8) & 0x3];
+			if (val & BIT(16))
+				ahb_div *= 2;
+		} else {
+			if (val & BIT(16))
+				ahb_div = ast2600_a1_axi_ahb_div1_tbl[divbits];
+			else
+				ahb_div = ast2600_a1_axi_ahb_div0_tbl[divbits];
+		}
+	} else {
 		ahb_div = ast2600_a0_axi_ahb_div_table[(val >> 11) & 0x3];
+	}
 
 	hw = clk_hw_register_fixed_factor(NULL, "ahb", "hpll", 0, 1, axi_div * ahb_div);
 	aspeed_g6_clk_data->hws[ASPEED_CLK_AHB] = hw;
-- 
2.25.1

