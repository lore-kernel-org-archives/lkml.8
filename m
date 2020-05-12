Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A4DC2D0F6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FC1320720
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589307422;
	bh=7ledyV1OhRiHzkxJNPm3VGiig2l4t0br/rnLqqrD5+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LBdXAQbxOBDuhd6NYzbv3+d5gUXctVCV7b1TGsadY2miWmR0fIJHS1DCWVhYzUM52
	 I+sFdnFSRorfmgA8zeVGMJBjOSSWZq5to6LtQsQCcSFMvbjGT/tHANtioHIiGlK/sE
	 Dnfg/5l457/FBy5gGoJ+XQgpaMy/lEurU4VfhwO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbgELSRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 14:17:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728309AbgELSRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 14:17:01 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39D7F20722;
        Tue, 12 May 2020 18:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589307420;
        bh=7ledyV1OhRiHzkxJNPm3VGiig2l4t0br/rnLqqrD5+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F+RZzyXLjNRlziMmo/iZs9UXM0x/mC9pCgdz011XA84ABn48B5pKp9ssAWQP3ExkV
         24np6yhYeB4o1Lpy0mKyndzq71g1b6ZR20bSFG9V6MF8Yj9qRCDISfoZinKqunoxAo
         JCpwCB7KAUCbgJrLti02GPYX21P3O0qj/GHyC3bI=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-clk@vger.kernel.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com
Subject: [RESEND PATCHv7 2/5] clk: socfpga: remove clk_ops enable/disable methods
Date:   Tue, 12 May 2020 13:16:44 -0500
Message-Id: <20200512181647.5071-2-dinguyen@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512181647.5071-1-dinguyen@kernel.org>
References: <20200512181647.5071-1-dinguyen@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enable/disable clock ops are already defined in the standard clock
ops, so we don't need to assign them.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v7: no changes
v6: no changes
v5: no changes
v4: no changes
v3: no changes
v2: created
---
 drivers/clk/socfpga/clk-pll-a10.c | 2 --
 drivers/clk/socfpga/clk-pll-s10.c | 2 --
 drivers/clk/socfpga/clk-pll.c     | 2 --
 3 files changed, 6 deletions(-)

diff --git a/drivers/clk/socfpga/clk-pll-a10.c b/drivers/clk/socfpga/clk-pll-a10.c
index 3816fc04b274..6d9395106c0c 100644
--- a/drivers/clk/socfpga/clk-pll-a10.c
+++ b/drivers/clk/socfpga/clk-pll-a10.c
@@ -102,8 +102,6 @@ static struct clk * __init __socfpga_pll_init(struct device_node *node,
 	pll_clk->hw.hw.init = &init;
 
 	pll_clk->hw.bit_idx = SOCFPGA_PLL_EXT_ENA;
-	clk_pll_ops.enable = clk_gate_ops.enable;
-	clk_pll_ops.disable = clk_gate_ops.disable;
 
 	clk = clk_register(NULL, &pll_clk->hw.hw);
 	if (WARN_ON(IS_ERR(clk))) {
diff --git a/drivers/clk/socfpga/clk-pll-s10.c b/drivers/clk/socfpga/clk-pll-s10.c
index bcd3f14e9145..9faa80ff3b53 100644
--- a/drivers/clk/socfpga/clk-pll-s10.c
+++ b/drivers/clk/socfpga/clk-pll-s10.c
@@ -138,8 +138,6 @@ struct clk *s10_register_pll(const struct stratix10_pll_clock *clks,
 	pll_clk->hw.hw.init = &init;
 
 	pll_clk->hw.bit_idx = SOCFPGA_PLL_POWER;
-	clk_pll_ops.enable = clk_gate_ops.enable;
-	clk_pll_ops.disable = clk_gate_ops.disable;
 
 	clk = clk_register(NULL, &pll_clk->hw.hw);
 	if (WARN_ON(IS_ERR(clk))) {
diff --git a/drivers/clk/socfpga/clk-pll.c b/drivers/clk/socfpga/clk-pll.c
index dc65cc0fd3bd..a001641b2f42 100644
--- a/drivers/clk/socfpga/clk-pll.c
+++ b/drivers/clk/socfpga/clk-pll.c
@@ -105,8 +105,6 @@ static __init struct clk *__socfpga_pll_init(struct device_node *node,
 	pll_clk->hw.hw.init = &init;
 
 	pll_clk->hw.bit_idx = SOCFPGA_PLL_EXT_ENA;
-	clk_pll_ops.enable = clk_gate_ops.enable;
-	clk_pll_ops.disable = clk_gate_ops.disable;
 
 	clk = clk_register(NULL, &pll_clk->hw.hw);
 	if (WARN_ON(IS_ERR(clk))) {
-- 
2.17.1

