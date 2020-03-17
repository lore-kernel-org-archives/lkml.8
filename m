Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393BBC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB8220724
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584461435;
	bh=SRYe3kNhcA/GRi0wWZpdN33/An8Xv8uK1rN9IZX8TI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D2bbZsatu+2k45MoQg0Pzf1gbFNiiefo1R+mfynxjlTTTCP1Xcojnmi8JgW0xTj96
	 bbIonfeRoYpE+ZmydFpbyDrb0qRiaOMdhySLpTZlaltThsvSXxly2QmpqrqKrwqFS4
	 zqpunw1RrkQ8Vc4htoTx5Rg0O4vbntAuumlHbFr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgCQQKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 12:10:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbgCQQKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:10:30 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8432A20754;
        Tue, 17 Mar 2020 16:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584461430;
        bh=SRYe3kNhcA/GRi0wWZpdN33/An8Xv8uK1rN9IZX8TI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tlGIees/ztWvElRsoyMcygF2/h4T+gOdPbh6qle3V4SBVE/Ok+SnyA/gO5DChA5W3
         zmbaVhvrZg+q9Z9fanHyMe0KDGvhOx9Df6fVrVOAMNcIVDX8ZG3XFwBRVLGvk32pcs
         qQjfXq0quLCR+fVtAyM3CwmmyEyeg9G1nUj1EEac=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-clk@vger.kernel.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        Dinh Nguyen <dinh.nguyen@intel.com>
Subject: [PATCH 3/5] clk: socfpga: add const to _ops data structures
Date:   Tue, 17 Mar 2020 11:10:20 -0500
Message-Id: <20200317161022.11181-4-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317161022.11181-1-dinguyen@kernel.org>
References: <20200317161022.11181-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinh Nguyen <dinh.nguyen@intel.com>

All the static clk_ops data structure need a const.

Signed-off-by: Dinh Nguyen <dinh.nguyen@intel.com>
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
2.25.1

