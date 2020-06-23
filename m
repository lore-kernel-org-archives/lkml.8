Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FD7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAD4F20707
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947909;
	bh=li5D3uOG2gu6Ux4TerVx/9z/nBnXCeCz0BpHMZTXwmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VQfACqllORpJ1cryqLIrrf1V7DLJ8WJZMVtF+fdR4BheXnIbFkkW1+hRMB52iaryz
	 PgxYCW2BGzJZDr+2tjPpQ4M0sR9537N2EmA1jpWssMc45ZqPHjSlQhnxNX5BiUqXMV
	 J+JKhTKddmuxeShd4JrLo3PiJLHEvbKeiqszMTMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388500AbgFWUMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:12:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388759AbgFWUM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:12:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47E7220707;
        Tue, 23 Jun 2020 20:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943148;
        bh=li5D3uOG2gu6Ux4TerVx/9z/nBnXCeCz0BpHMZTXwmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wIG2Y/DUWdbruHh/adlT80SmC9c6shBj0cqQ3tXC6l3EkfArsotN+KSvTZRZmbKS/
         2J80+ubcO1L0T4QVcgsBMLTcEPT9f+WKfEbrAaaLU/d2xMHja5aLeCzHvpBFYwVpfk
         g4fReZxN/oC7j7QH02HSZVwPYLP7Bs+SJ5KRZ3tk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejas Patel <tejas.patel@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 279/477] clk: zynqmp: Fix divider2 calculation
Date:   Tue, 23 Jun 2020 21:54:36 +0200
Message-Id: <20200623195420.755821270@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejas Patel <tejas.patel@xilinx.com>

[ Upstream commit b8c1049c68d634a412ed5980ae666ed7c8839305 ]

zynqmp_get_divider2_val() calculates, divider value of type DIV2 clock,
considering best possible combination of DIV1 and DIV2.

To find best possible values of DIV1 and DIV2, DIV1's parent rate
should be consider and not DIV2's parent rate since it would rate of
div1 clock. Consider a below topology,

	out_clk->div2_clk->div1_clk->fixed_parent

where out_clk = (fixed_parent/div1_clk) / div2_clk, so parent clock
of div1_clk (i.e. out_clk) should be divided by div1_clk and div2_clk.

Existing code divides parent rate of div2_clk's clock instead of
div1_clk's parent rate, which is wrong.

Fix the same by considering div1's parent clock rate.

Fixes: 4ebd92d2e228 ("clk: zynqmp: Fix divider calculation")
Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
Link: https://lkml.kernel.org/r/1583185843-20707-3-git-send-email-jolly.shah@xilinx.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/zynqmp/divider.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index 4be2cc76aa2e7..9bc4f9409aea0 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -111,23 +111,30 @@ static unsigned long zynqmp_clk_divider_recalc_rate(struct clk_hw *hw,
 
 static void zynqmp_get_divider2_val(struct clk_hw *hw,
 				    unsigned long rate,
-				    unsigned long parent_rate,
 				    struct zynqmp_clk_divider *divider,
 				    int *bestdiv)
 {
 	int div1;
 	int div2;
 	long error = LONG_MAX;
-	struct clk_hw *parent_hw = clk_hw_get_parent(hw);
-	struct zynqmp_clk_divider *pdivider = to_zynqmp_clk_divider(parent_hw);
+	unsigned long div1_prate;
+	struct clk_hw *div1_parent_hw;
+	struct clk_hw *div2_parent_hw = clk_hw_get_parent(hw);
+	struct zynqmp_clk_divider *pdivider =
+				to_zynqmp_clk_divider(div2_parent_hw);
 
 	if (!pdivider)
 		return;
 
+	div1_parent_hw = clk_hw_get_parent(div2_parent_hw);
+	if (!div1_parent_hw)
+		return;
+
+	div1_prate = clk_hw_get_rate(div1_parent_hw);
 	*bestdiv = 1;
 	for (div1 = 1; div1 <= pdivider->max_div;) {
 		for (div2 = 1; div2 <= divider->max_div;) {
-			long new_error = ((parent_rate / div1) / div2) - rate;
+			long new_error = ((div1_prate / div1) / div2) - rate;
 
 			if (abs(new_error) < abs(error)) {
 				*bestdiv = div2;
@@ -192,7 +199,7 @@ static long zynqmp_clk_divider_round_rate(struct clk_hw *hw,
 	 */
 	if (div_type == TYPE_DIV2 &&
 	    (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)) {
-		zynqmp_get_divider2_val(hw, rate, *prate, divider, &bestdiv);
+		zynqmp_get_divider2_val(hw, rate, divider, &bestdiv);
 	}
 
 	if ((clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) && divider->is_frac)
-- 
2.25.1



