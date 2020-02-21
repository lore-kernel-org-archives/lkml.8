Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D825C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7084524650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582271272;
	bh=LUMQ4dfbhY9whkPxnaGYGSz/mst3o4nhse0JeJl/eyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qxWdNDaErILn9LrjAHDkCUOhBTYE8mW1zSQYPm+xvUNtCGhX1TPJRqiNs0FTMjDL9
	 o3njRY2K6HxN74erzX732inNep0eL2t2nRPqJIkFUl9yjRIEzPEax+aKW2e6oRO227
	 Ic5Slg2Cyb25Sjbe5II+Bz0c2a76oq2GZAH46GL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgBUHru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:47:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:43676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728324AbgBUHrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:47:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D327424653;
        Fri, 21 Feb 2020 07:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271263;
        bh=LUMQ4dfbhY9whkPxnaGYGSz/mst3o4nhse0JeJl/eyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oABAnRl+HH9nzkMGPvZyNm0MW6P0YTpRgsZ8krghQxqrDVaYw8U/20BeAkiIu4qRk
         o9oATgDbjVZwIEvkyG70GUOBObHfmjDWh/P5icCNWoGqSq5JR9yyr3/FkftMrKfXad
         SKrXep1vIMrjRvxJVKpOE6cMLk89Bxt4tmX6L6dE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 100/399] clk: qcom: Dont overwrite cfg in clk_rcg2_dfs_populate_freq()
Date:   Fri, 21 Feb 2020 08:37:05 +0100
Message-Id: <20200221072412.125206758@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@kernel.org>

[ Upstream commit 21e157c62eeded8b1558a991b4820b761d48a730 ]

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
Link: https://lkml.kernel.org/r/20200128193329.45635-1-sboyd@kernel.org
Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/clk-rcg2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 8f4b9bec29565..5e0f7d8f168dd 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -952,7 +952,7 @@ static void clk_rcg2_dfs_populate_freq(struct clk_hw *hw, unsigned int l,
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	struct clk_hw *p;
 	unsigned long prate = 0;
-	u32 val, mask, cfg, mode;
+	u32 val, mask, cfg, mode, src;
 	int i, num_parents;
 
 	regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + SE_PERF_DFSR(l), &cfg);
@@ -962,12 +962,12 @@ static void clk_rcg2_dfs_populate_freq(struct clk_hw *hw, unsigned int l,
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
2.20.1



