Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86298C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BAAF205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgESWmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 18:42:42 -0400
Received: from v6.sk ([167.172.42.174]:58676 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728191AbgESWmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 18:42:36 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 18704610DD;
        Tue, 19 May 2020 22:42:05 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 06/13] clk: mmp2: Rename mmp2_pll_init() to mmp2_main_clk_init()
Date:   Wed, 20 May 2020 00:41:44 +0200
Message-Id: <20200519224151.2074597-7-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519224151.2074597-1-lkundrak@v3.sk>
References: <20200519224151.2074597-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a trivial rename for a routine that registers more clock sources
than the PLLs -- there's also a XO.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/clk/mmp/clk-of-mmp2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.c
index 524574187c17..ac88ea99b7c6 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -139,7 +139,7 @@ static struct mmp_clk_factor_tbl uart_factor_tbl[] = {
 	{.num = 3521, .den = 689},	/*19.23MHZ */
 };
 
-static void mmp2_pll_init(struct mmp2_clk_unit *pxa_unit)
+static void mmp2_main_clk_init(struct mmp2_clk_unit *pxa_unit)
 {
 	struct clk *clk;
 	struct mmp_clk_unit *unit = &pxa_unit->unit;
@@ -456,7 +456,7 @@ static void __init mmp2_clk_init(struct device_node *np)
 
 	mmp_clk_init(np, &pxa_unit->unit, MMP2_NR_CLKS);
 
-	mmp2_pll_init(pxa_unit);
+	mmp2_main_clk_init(pxa_unit);
 
 	mmp2_apb_periph_clk_init(pxa_unit);
 
-- 
2.26.2

