Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9D2C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9742214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580240011;
	bh=CzHf0cywYKTja7w/o3Cx9C1HB0qYaKqouONA+gnhoiU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bR5VbTsJShgy9rV4e9x2+NXAZBNvC5HyI+yXj2oiBfal0yQ1KMMTeMi/sHEZJDNZ8
	 nxCV5nRwWC5abLWWPoqB4E4fEbfxrVpsGoIhD6weYDT7/dKpRM02i88a5tYIApiV21
	 pJ9yJI6T8SSp2eOzIFUp6xkJ0uO8kSKjlR6lXx70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgA1Tdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 14:33:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:51538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgA1Tdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 14:33:31 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8297214D8;
        Tue, 28 Jan 2020 19:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580240010;
        bh=CzHf0cywYKTja7w/o3Cx9C1HB0qYaKqouONA+gnhoiU=;
        h=From:To:Cc:Subject:Date:From;
        b=DQMLvL2iNk4CbdDzOrneKsIerWY2/J+dfcAxzSEsfJNMYJlCntt2OoeDfyhLGcuPr
         //Q/c6CsyWm2X2ssuLGxudy/ZvU7kZE54DT9ChOAtolX5Q9Qc8VI60WlDqGM/Bf9Pk
         XvRw3PymqnswsnmOUB1v2SuYh8R6mWI2PR2t0yiI=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH] clk: qcom: Don't overwrite 'cfg' in clk_rcg2_dfs_populate_freq()
Date:   Tue, 28 Jan 2020 11:33:29 -0800
Message-Id: <20200128193329.45635-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DFS frequency table logic overwrites 'cfg' while detecting the
parent clk and then later on in clk_rcg2_dfs_populate_freq() we use that
same variable to figure out the mode of the clk, either MND or not. Add
a new variable to hold the parent clk bit so that 'cfg' is left
untouched for use later.

This fixes problems in detecting the supported frequencies for any clks
in DFS mode.

Fixes: cc4f6944d0e3 ("clk: qcom: Add support for RCG to register for DFS")
Reported-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/qcom/clk-rcg2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index da045b200def..973ecf4f6bc5 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -953,7 +953,7 @@ static void clk_rcg2_dfs_populate_freq(struct clk_hw *hw, unsigned int l,
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	struct clk_hw *p;
 	unsigned long prate = 0;
-	u32 val, mask, cfg, mode;
+	u32 val, mask, cfg, mode, src;
 	int i, num_parents;
 
 	regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + SE_PERF_DFSR(l), &cfg);
@@ -963,12 +963,12 @@ static void clk_rcg2_dfs_populate_freq(struct clk_hw *hw, unsigned int l,
 	if (cfg & mask)
 		f->pre_div = cfg & mask;
 
-	cfg &= CFG_SRC_SEL_MASK;
-	cfg >>= CFG_SRC_SEL_SHIFT;
+	src = cfg & CFG_SRC_SEL_MASK;
+	src >>= CFG_SRC_SEL_SHIFT;
 
 	num_parents = clk_hw_get_num_parents(hw);
 	for (i = 0; i < num_parents; i++) {
-		if (cfg == rcg->parent_map[i].cfg) {
+		if (src == rcg->parent_map[i].cfg) {
 			f->src = rcg->parent_map[i].src;
 			p = clk_hw_get_parent_by_index(&rcg->clkr.hw, i);
 			prate = clk_hw_get_rate(p);
-- 
Sent by a computer, using git, on the internet

