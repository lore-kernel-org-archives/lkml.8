Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F894C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6D42076F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584723798;
	bh=nGNWNe4gb5SNLtQ25FhIgpIFgzRIf+L0AGCdRSLeuP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vhdYmbJ3RzhG6wypuqx2gZoJsXLKpqDmRxAWd0YhatX854ahD3Y1PgjvNtM+H3W/N
	 O9vGrnbG6cnm+0DkG4uib5WjE2Psi7EJcIbNXC/JUTjubVtWdan7Vzw9Mg5aBQ7p0d
	 rN3RYTYAHiqLrDxkjiSc25wb+m+FANUUOgPFuWhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgCTRDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:03:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727550AbgCTRDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:03:00 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BA3C2076F;
        Fri, 20 Mar 2020 17:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584723779;
        bh=nGNWNe4gb5SNLtQ25FhIgpIFgzRIf+L0AGCdRSLeuP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A3ZmPKVIQtj8lobfxYDECKYDuHJ4J7xjtiXmwVCtZa6w86HHju4vFQGQN0OzrQpFd
         Iv5Nl67LumeKcNUjLL5Tk53XyzTPesPxRc94TlfSlfQ8aYqu3BwmvJx++wTh9IIiX0
         QgzrNSyJBcy2aTCZeTzcQL3nwygAowu50uOrAhDs=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-clk@vger.kernel.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        Dinh Nguyen <dinh.nguyen@intel.com>
Subject: [PATCH 2/5] clk: socfpga: remove clk_ops enable/disable methods
Date:   Fri, 20 Mar 2020 12:02:08 -0500
Message-Id: <20200320170212.21523-3-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320170212.21523-1-dinguyen@kernel.org>
References: <20200320170212.21523-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinh Nguyen <dinh.nguyen@intel.com>

The enable/disable clock ops are already defined in the standard clock
ops, so we don't need to assign them.

Signed-off-by: Dinh Nguyen <dinh.nguyen@intel.com>
---
v4: no change
v3: introduced
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
2.25.1

