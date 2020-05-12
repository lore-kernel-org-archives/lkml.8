Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CBCC2D0F7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49F86206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589307432;
	bh=SH4TNKWiiMK8Bi96neyAYYKhQf6TWRQT/RGdYI++BQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gZMkgyQgv/sIjKsp690TBp9hHxGMM/IEN2xsKUMu5IRHauO3UkxbRFq0Y2+8Uob+L
	 7NC7MGaIIuIsV7JrgBeSVA20/TOKSsqHXttTqIUH6Q2ehWv3CImUNNAybWLxAqFgWM
	 Kg3xVyzXUkuyeBmRjL6EbBz28Hud5scDn6YXXCjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbgELSRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 14:17:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730200AbgELSRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 14:17:02 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDC1620733;
        Tue, 12 May 2020 18:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589307421;
        bh=SH4TNKWiiMK8Bi96neyAYYKhQf6TWRQT/RGdYI++BQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XRJJ8Qu2KupTZV05XmZVjD5bYb9CxKYGp7LfXo/Pv0DHGMTfj2kBpYx53jp7BiHYQ
         wd+2Apw3HiN4Yp5uqNoe6HzzHZObBvixMq7ffUB3b8nu+RNewlKrWHwguPC0id9YKQ
         ipFjN2RlGUJVIbTt1g1q4NjpndzrFlLOI8Y48Ve8=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-clk@vger.kernel.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com
Subject: [RESEND PATCHv7 3/5] clk: socfpga: add const to _ops data structures
Date:   Tue, 12 May 2020 13:16:45 -0500
Message-Id: <20200512181647.5071-3-dinguyen@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512181647.5071-1-dinguyen@kernel.org>
References: <20200512181647.5071-1-dinguyen@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the static clk_ops data structure need a const.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v7: no changes
v6: no changes
v5: no changes
v4: no changes
v3: no changes
v2: created
---
 drivers/clk/socfpga/clk-pll-a10.c | 2 +-
 drivers/clk/socfpga/clk-pll-s10.c | 4 ++--
 drivers/clk/socfpga/clk-pll.c     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/socfpga/clk-pll-a10.c b/drivers/clk/socfpga/clk-pll-a10.c
index 6d9395106c0c..db54f7d806a0 100644
--- a/drivers/clk/socfpga/clk-pll-a10.c
+++ b/drivers/clk/socfpga/clk-pll-a10.c
@@ -58,7 +58,7 @@ static u8 clk_pll_get_parent(struct clk_hw *hwclk)
 		CLK_MGR_PLL_CLK_SRC_MASK;
 }
 
-static struct clk_ops clk_pll_ops = {
+static const struct clk_ops clk_pll_ops = {
 	.recalc_rate = clk_pll_recalc_rate,
 	.get_parent = clk_pll_get_parent,
 };
diff --git a/drivers/clk/socfpga/clk-pll-s10.c b/drivers/clk/socfpga/clk-pll-s10.c
index 9faa80ff3b53..5c3e1ee44f6b 100644
--- a/drivers/clk/socfpga/clk-pll-s10.c
+++ b/drivers/clk/socfpga/clk-pll-s10.c
@@ -98,13 +98,13 @@ static int clk_pll_prepare(struct clk_hw *hwclk)
 	return 0;
 }
 
-static struct clk_ops clk_pll_ops = {
+static const struct clk_ops clk_pll_ops = {
 	.recalc_rate = clk_pll_recalc_rate,
 	.get_parent = clk_pll_get_parent,
 	.prepare = clk_pll_prepare,
 };
 
-static struct clk_ops clk_boot_ops = {
+static const struct clk_ops clk_boot_ops = {
 	.recalc_rate = clk_boot_clk_recalc_rate,
 	.get_parent = clk_boot_get_parent,
 	.prepare = clk_pll_prepare,
diff --git a/drivers/clk/socfpga/clk-pll.c b/drivers/clk/socfpga/clk-pll.c
index a001641b2f42..e5fb786843f3 100644
--- a/drivers/clk/socfpga/clk-pll.c
+++ b/drivers/clk/socfpga/clk-pll.c
@@ -65,7 +65,7 @@ static u8 clk_pll_get_parent(struct clk_hw *hwclk)
 			CLK_MGR_PLL_CLK_SRC_MASK;
 }
 
-static struct clk_ops clk_pll_ops = {
+static const struct clk_ops clk_pll_ops = {
 	.recalc_rate = clk_pll_recalc_rate,
 	.get_parent = clk_pll_get_parent,
 };
-- 
2.17.1

