Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B94C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A1B920870
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgGCPtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 11:49:55 -0400
Received: from gloria.sntech.de ([185.11.138.130]:41054 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbgGCPtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 11:49:55 -0400
Received: from p5b127e6f.dip0.t-ipconnect.de ([91.18.126.111] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jrNwk-0002vB-3e; Fri, 03 Jul 2020 17:49:50 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     mylene.josserand@collabora.com, mturquette@baylibre.com,
        sboyd@kernel.org, jagan@amarulasolutions.com,
        linux-kernel@vger.kernel.org, heiko@sntech.de,
        ezequiel@collabora.com, linux-clk@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH v2] clk: rockchip: use separate compatibles for rk3288w-cru
Date:   Fri,  3 Jul 2020 17:49:48 +0200
Message-Id: <20200703154948.260369-1-heiko@sntech.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

Commit 1627f683636d ("clk: rockchip: Handle clock tree for rk3288w variant")
added the check for rk3288w-specific clock-tree changes but in turn would
require a double-compatible due to re-using the main rockchip,rk3288-cru
compatible as entry point.

The binding change actually describes the compatibles as one or the other
so adapt the code accordingly and add a real second entry-point for the
clock controller.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
changes in v2:
- type enum instead of boolean (Ezequiel)

 drivers/clk/rockchip/clk-rk3288.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 204976e2d0cb..93c794695c46 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -15,6 +15,11 @@
 #define RK3288_GRF_SOC_CON(x)	(0x244 + x * 4)
 #define RK3288_GRF_SOC_STATUS1	0x284
 
+enum rk3288_variant {
+	RK3288_CRU,
+	RK3288W_CRU,
+};
+
 enum rk3288_plls {
 	apll, dpll, cpll, gpll, npll,
 };
@@ -922,7 +927,8 @@ static struct syscore_ops rk3288_clk_syscore_ops = {
 	.resume = rk3288_clk_resume,
 };
 
-static void __init rk3288_clk_init(struct device_node *np)
+static void __init rk3288_common_init(struct device_node *np,
+				      enum rk3288_variant soc)
 {
 	struct rockchip_clk_provider *ctx;
 
@@ -945,7 +951,7 @@ static void __init rk3288_clk_init(struct device_node *np)
 	rockchip_clk_register_branches(ctx, rk3288_clk_branches,
 				  ARRAY_SIZE(rk3288_clk_branches));
 
-	if (of_device_is_compatible(np, "rockchip,rk3288w-cru"))
+	if (soc == RK3288W_CRU)
 		rockchip_clk_register_branches(ctx, rk3288w_hclkvio_branch,
 					       ARRAY_SIZE(rk3288w_hclkvio_branch));
 	else
@@ -970,4 +976,15 @@ static void __init rk3288_clk_init(struct device_node *np)
 
 	rockchip_clk_of_add_provider(np, ctx);
 }
+
+static void __init rk3288_clk_init(struct device_node *np)
+{
+	rk3288_common_init(np, RK3288_CRU);
+}
 CLK_OF_DECLARE(rk3288_cru, "rockchip,rk3288-cru", rk3288_clk_init);
+
+static void __init rk3288w_clk_init(struct device_node *np)
+{
+	rk3288_common_init(np, RK3288W_CRU);
+}
+CLK_OF_DECLARE(rk3288w_cru, "rockchip,rk3288w-cru", rk3288w_clk_init);
-- 
2.26.2

