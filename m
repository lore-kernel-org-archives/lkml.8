Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC3BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9592467B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579875533;
	bh=cOyqk97cutL1s+fJwmtKJKAfj/jZXdg6ZAmb/dhgNH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=up/PgroHz7F2oW3fK3mM4PGANvIjQLFAEA4YzYQJRYjsqpffV3vGOshgUk2A+dTRv
	 IRTB39PekNSGTIn7JS+F8LWI+InP4fGNzhI0SKiDVIVRdUuUddIQCV6AhcypiEKQCD
	 PwK13YSadf/owrE2NWGjvYJhKnghOPsu9p9oME3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391157AbgAXOSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:18:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:38538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390973AbgAXOSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:18:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1510B22464;
        Fri, 24 Jan 2020 14:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875524;
        bh=cOyqk97cutL1s+fJwmtKJKAfj/jZXdg6ZAmb/dhgNH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tk71IFufMPoskqSClLRkmX0e9oOII1vq0algWcVLbXHMAQTKRxDqcyJJaKM6apr22
         RVbRpPw/sH9oYaJ0SzEWqJ4bECqUwobgKjeTRIZkngfTo33rfOMy0I77Tm/i8jvgef
         ocwABviNIL1l9lvpPChdqGhmRkIDrbJARrZbV8Zk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 023/107] clk: sunxi-ng: sun8i-r: Fix divider on APB0 clock
Date:   Fri, 24 Jan 2020 09:16:53 -0500
Message-Id: <20200124141817.28793-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124141817.28793-1-sashal@kernel.org>
References: <20200124141817.28793-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Holland <samuel@sholland.org>

[ Upstream commit 47d64fef1f3ffbdf960d3330b9865fc9f12fdf84 ]

According to the BSP source code, the APB0 clock on the H3 and H5 has a
normal M divider, not a power-of-two divider. This matches the hardware
in the A83T (as described in both the BSP source code and the manual).
Since the A83T and H3/A64 clocks are actually the same, we can merge the
definitions.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-r.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r.c b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
index 4646fdc61053b..4c8c491b87c27 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
@@ -51,19 +51,7 @@ static struct ccu_div ar100_clk = {
 
 static CLK_FIXED_FACTOR_HW(ahb0_clk, "ahb0", &ar100_clk.common.hw, 1, 1, 0);
 
-static struct ccu_div apb0_clk = {
-	.div		= _SUNXI_CCU_DIV_FLAGS(0, 2, CLK_DIVIDER_POWER_OF_TWO),
-
-	.common		= {
-		.reg		= 0x0c,
-		.hw.init	= CLK_HW_INIT_HW("apb0",
-						 &ahb0_clk.hw,
-						 &ccu_div_ops,
-						 0),
-	},
-};
-
-static SUNXI_CCU_M(a83t_apb0_clk, "apb0", "ahb0", 0x0c, 0, 2, 0);
+static SUNXI_CCU_M(apb0_clk, "apb0", "ahb0", 0x0c, 0, 2, 0);
 
 /*
  * Define the parent as an array that can be reused to save space
@@ -127,7 +115,7 @@ static struct ccu_mp a83t_ir_clk = {
 
 static struct ccu_common *sun8i_a83t_r_ccu_clks[] = {
 	&ar100_clk.common,
-	&a83t_apb0_clk.common,
+	&apb0_clk.common,
 	&apb0_pio_clk.common,
 	&apb0_ir_clk.common,
 	&apb0_timer_clk.common,
@@ -167,7 +155,7 @@ static struct clk_hw_onecell_data sun8i_a83t_r_hw_clks = {
 	.hws	= {
 		[CLK_AR100]		= &ar100_clk.common.hw,
 		[CLK_AHB0]		= &ahb0_clk.hw,
-		[CLK_APB0]		= &a83t_apb0_clk.common.hw,
+		[CLK_APB0]		= &apb0_clk.common.hw,
 		[CLK_APB0_PIO]		= &apb0_pio_clk.common.hw,
 		[CLK_APB0_IR]		= &apb0_ir_clk.common.hw,
 		[CLK_APB0_TIMER]	= &apb0_timer_clk.common.hw,
@@ -282,9 +270,6 @@ static void __init sunxi_r_ccu_init(struct device_node *node,
 
 static void __init sun8i_a83t_r_ccu_setup(struct device_node *node)
 {
-	/* Fix apb0 bus gate parents here */
-	apb0_gate_parent[0] = &a83t_apb0_clk.common.hw;
-
 	sunxi_r_ccu_init(node, &sun8i_a83t_r_ccu_desc);
 }
 CLK_OF_DECLARE(sun8i_a83t_r_ccu, "allwinner,sun8i-a83t-r-ccu",
-- 
2.20.1

