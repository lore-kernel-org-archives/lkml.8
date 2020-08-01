Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB522C433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 09:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AADDC20716
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 09:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgHAJfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 05:35:06 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:28316 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725931AbgHAJfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 05:35:06 -0400
X-IronPort-AV: E=Sophos;i="5.75,420,1589234400"; 
   d="scan'208";a="462118376"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-SHA256; 01 Aug 2020 11:35:04 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Michael Turquette <mturquette@baylibre.com>
Cc:     kernel-janitors@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: drop unused function __clk_get_flags
Date:   Sat,  1 Aug 2020 10:53:42 +0200
Message-Id: <1596272022-14173-1-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function __clk_get_flags has not been used since the April 2019
commit a348f05361c9 ("ARM: omap2+: hwmod: drop CLK_IS_BASIC
flag usage").  Other uses were removed in June 2015, eg by
commit 98d8a60eccee ("clk: Convert __clk_get_flags() to
clk_hw_get_flags()"), which shows how clk_hw_get_flags can easily
be used instead.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/clk/clk.c            |    6 ------
 include/linux/clk-provider.h |    1 -
 2 files changed, 7 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 8aed0c3ff122..0a9261a099bd 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -500,12 +500,6 @@ static unsigned long clk_core_get_accuracy_no_lock(struct clk_core *core)
 	return core->accuracy;
 }
 
-unsigned long __clk_get_flags(struct clk *clk)
-{
-	return !clk ? 0 : clk->core->flags;
-}
-EXPORT_SYMBOL_GPL(__clk_get_flags);
-
 unsigned long clk_hw_get_flags(const struct clk_hw *hw)
 {
 	return hw->core->flags;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 6f815be99b77..03a5de5f99f4 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1096,7 +1096,6 @@ int clk_hw_get_parent_index(struct clk_hw *hw);
 int clk_hw_set_parent(struct clk_hw *hw, struct clk_hw *new_parent);
 unsigned int __clk_get_enable_count(struct clk *clk);
 unsigned long clk_hw_get_rate(const struct clk_hw *hw);
-unsigned long __clk_get_flags(struct clk *clk);
 unsigned long clk_hw_get_flags(const struct clk_hw *hw);
 #define clk_hw_can_set_rate_parent(hw) \
 	(clk_hw_get_flags((hw)) & CLK_SET_RATE_PARENT)

