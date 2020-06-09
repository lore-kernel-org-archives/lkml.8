Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18287C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 21:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E92922078D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 21:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591737531;
	bh=R6TTuWXnKhUWq0RBVhFAzzNL9AjdNgHgPZzhhyArsVc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=cL9DfLyT9QidnEL6K25fNA6aU8CpMNnXtun8fI6o1Q5alEPLb6Nu4OK9ePj/AtPCJ
	 /tF2qYf6IEc28oXahPgoRfWlfpj/BUFrC4yYbb80NtZEiq8Kmvfuk1juvcy8vGCbOc
	 UPCdeb2ZAttfwPumLvAdgWkml/V7+Itp0i5Ffn04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgFIVSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 17:18:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgFIVSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 17:18:48 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB929206D5;
        Tue,  9 Jun 2020 21:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591737528;
        bh=R6TTuWXnKhUWq0RBVhFAzzNL9AjdNgHgPZzhhyArsVc=;
        h=From:To:Cc:Subject:Date:From;
        b=PKwO2PIkTqmblopwvtRWKwd6CN4x1Tj/UKMOUwlcNDh/LZ1d+ure4gPUnY9EkSLbl
         Zx46Cskf/XYR6BxzobplrMVnTwM4E/jNsomRdrYTb+SZEJDeJ/PGbJavFGQvyjxn4F
         gTFdZsydvyETG8oKitHODNNpM4r3vn82POtApYU0=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Owen Chen <owen.chen@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] clk: mediatek: Remove ifr{0,1}_cfg_regs structures
Date:   Tue,  9 Jun 2020 14:18:47 -0700
Message-Id: <20200609211847.27366-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These aren't used and the macros that reference them aren't used either.
Remove the dead code to avoid compile warnings.

Cc: Owen Chen <owen.chen@mediatek.com>
Cc: Mars Cheng <mars.cheng@mediatek.com>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>
Fixes: 1aca9939bf72 ("clk: mediatek: Add MT6765 clock support")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/mediatek/clk-mt6765.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
index 3ec53cb62ece..db8db1b3b79d 100644
--- a/drivers/clk/mediatek/clk-mt6765.c
+++ b/drivers/clk/mediatek/clk-mt6765.c
@@ -534,18 +534,6 @@ static const struct mtk_gate top_clks[] = {
 	GATE_TOP2(CLK_TOP_APLL12_DIV3, "apll12_div3", "aud_1_ck", 5),
 };
 
-static const struct mtk_gate_regs ifr0_cg_regs = {
-	.set_ofs = 0x200,
-	.clr_ofs = 0x200,
-	.sta_ofs = 0x200,
-};
-
-static const struct mtk_gate_regs ifr1_cg_regs = {
-	.set_ofs = 0x74,
-	.clr_ofs = 0x74,
-	.sta_ofs = 0x74,
-};
-
 static const struct mtk_gate_regs ifr2_cg_regs = {
 	.set_ofs = 0x80,
 	.clr_ofs = 0x84,
@@ -570,24 +558,6 @@ static const struct mtk_gate_regs ifr5_cg_regs = {
 	.sta_ofs = 0xc8,
 };
 
-#define GATE_IFR0(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &ifr0_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
-
-#define GATE_IFR1(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &ifr1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
-
 #define GATE_IFR2(_id, _name, _parent, _shift) {	\
 		.id = _id,				\
 		.name = _name,				\
-- 
Sent by a computer, using git, on the internet

