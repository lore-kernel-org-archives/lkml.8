Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69DCC38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 17:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9001F22240
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 17:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgDSR2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 13:28:08 -0400
Received: from v6.sk ([167.172.42.174]:44490 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbgDSR2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 13:28:04 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 8508D610C5;
        Sun, 19 Apr 2020 17:28:03 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Michael Turquette <mturquette@baylibre.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 06/10] clk: mmp2: Rename mmp2_pll_init() to mmp2_main_clk_init()
Date:   Sun, 19 Apr 2020 19:27:38 +0200
Message-Id: <20200419172742.674717-7-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200419172742.674717-1-lkundrak@v3.sk>
References: <20200419172742.674717-1-lkundrak@v3.sk>
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
index 524574187c17a..ac88ea99b7c68 100644
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
2.26.0

