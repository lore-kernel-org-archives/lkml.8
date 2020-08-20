Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32975C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBCDE20738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597926646;
	bh=5zDIADOTLQKE0vCNuwOkqvRT7Efysr/y1egeJ9G6Vnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pOQspH5G/we8nk4Q46dA9D3SAPULm/uwjo1Ws8DWVmSy2jYBMVSWR7XHNz0qy0PY6
	 38dVPCOfZkMoaNYHZBWZL32999OwJgbswrEgGDpR8lfau1KwVHRfdf5UV7waIwUMwo
	 tLSipiClKtgmdYgQ8pWeAkU8ixZbiDr7mlAHx1fg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbgHTMan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:30:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728589AbgHTJvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:51:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0051C2075E;
        Thu, 20 Aug 2020 09:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917071;
        bh=5zDIADOTLQKE0vCNuwOkqvRT7Efysr/y1egeJ9G6Vnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EHqe7KLeT/apgf0tos8niFCMXyFgEJeoATsXKhDFyDTqlyMOHQ8o1Du19blVo2V7a
         UuCtcCEFkdhixyEI3fLKZV242AHskK0+xgom0WZg69sNdFWDBTLg4Z7bLUp4150NXP
         BjhOQlLUkxoU+z5T+RnPtEhHmgQg3l7c4GNKEq2Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 107/152] clk: qcom: clk-alpha-pll: remove unused/incorrect PLL_CAL_VAL
Date:   Thu, 20 Aug 2020 11:21:14 +0200
Message-Id: <20200820091559.245470303@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091553.615456912@linuxfoundation.org>
References: <20200820091553.615456912@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Marek <jonathan@marek.ca>

[ Upstream commit c8b9002f44e4a1d2771b2f59f6de900864b1f9d7 ]

0x44 isn't a register offset, it is the value that goes into CAL_L_VAL.

Fixes: 548a909597d5 ("clk: qcom: clk-alpha-pll: Add support for Trion PLLs")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20200709135251.643-3-jonathan@marek.ca
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/clk-alpha-pll.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 055318f979915..a69f53e435ed5 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -55,7 +55,6 @@
 #define PLL_STATUS(p)		((p)->offset + (p)->regs[PLL_OFF_STATUS])
 #define PLL_OPMODE(p)		((p)->offset + (p)->regs[PLL_OFF_OPMODE])
 #define PLL_FRAC(p)		((p)->offset + (p)->regs[PLL_OFF_FRAC])
-#define PLL_CAL_VAL(p)		((p)->offset + (p)->regs[PLL_OFF_CAL_VAL])
 
 const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
 	[CLK_ALPHA_PLL_TYPE_DEFAULT] =  {
@@ -114,7 +113,6 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
 		[PLL_OFF_STATUS] = 0x30,
 		[PLL_OFF_OPMODE] = 0x38,
 		[PLL_OFF_ALPHA_VAL] = 0x40,
-		[PLL_OFF_CAL_VAL] = 0x44,
 	},
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
-- 
2.25.1



