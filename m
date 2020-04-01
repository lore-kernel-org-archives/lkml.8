Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309A9C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11025214DB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733070AbgDAPfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:35:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59658 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732789AbgDAPfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:35:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: myjosserand)
        with ESMTPSA id 4BE02291334
From:   =?UTF-8?q?Myl=C3=A8ne=20Josserand?= 
        <mylene.josserand@collabora.com>
To:     heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-clk@vger.kernel.org, mylene.josserand@collabora.com,
        kernel@collabora.com, kever.yang@rock-chips.com,
        geert@linux-m68k.org
Subject: [PATCH v2 2/2] clk: rockchip: rk3288: Handle clock tree for rk3288w
Date:   Wed,  1 Apr 2020 17:35:13 +0200
Message-Id: <20200401153513.423683-3-mylene.josserand@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200401153513.423683-1-mylene.josserand@collabora.com>
References: <20200401153513.423683-1-mylene.josserand@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The revision rk3288w has a different clock tree about
"hclk_vio" clock, according to the BSP kernel code.

This patch handles this difference by detecting which SOC it is
and creating the div accordingly. Because we are using
soc_device_match function, we need to delay the registration
of this clock later than others to have time to get SoC revision.

Otherwise, because of CLK_OF_DECLARE uses, clock tree will be
created too soon to have time to detect SoC's revision.

Signed-off-by: Mylène Josserand <mylene.josserand@collabora.com>
---
 drivers/clk/rockchip/clk-rk3288.c | 36 +++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index cc2a177bbdbf..1950d1efe1b8 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -9,6 +9,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/syscore_ops.h>
+#include <linux/sys_soc.h>
 #include <dt-bindings/clock/rk3288-cru.h>
 #include "clk.h"
 
@@ -425,8 +426,6 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 	COMPOSITE(0, "aclk_vio0", mux_pll_src_cpll_gpll_usb480m_p, CLK_IGNORE_UNUSED,
 			RK3288_CLKSEL_CON(31), 6, 2, MFLAGS, 0, 5, DFLAGS,
 			RK3288_CLKGATE_CON(3), 0, GFLAGS),
-	DIV(0, "hclk_vio", "aclk_vio0", 0,
-			RK3288_CLKSEL_CON(28), 8, 5, DFLAGS),
 	COMPOSITE(0, "aclk_vio1", mux_pll_src_cpll_gpll_usb480m_p, CLK_IGNORE_UNUSED,
 			RK3288_CLKSEL_CON(31), 14, 2, MFLAGS, 8, 5, DFLAGS,
 			RK3288_CLKGATE_CON(3), 2, GFLAGS),
@@ -819,6 +818,16 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 	INVERTER(0, "pclk_isp", "pclk_isp_in", RK3288_CLKSEL_CON(29), 3, IFLAGS),
 };
 
+static struct rockchip_clk_branch rk3288w_hclkvio_branch[] __initdata = {
+	DIV(0, "hclk_vio", "aclk_vio1", 0,
+	    RK3288_CLKSEL_CON(28), 8, 5, DFLAGS),
+};
+
+static struct rockchip_clk_branch rk3288_hclkvio_branch[] __initdata = {
+	DIV(0, "hclk_vio", "aclk_vio0", 0,
+	    RK3288_CLKSEL_CON(28), 8, 5, DFLAGS),
+};
+
 static const char *const rk3288_critical_clocks[] __initconst = {
 	"aclk_cpu",
 	"aclk_peri",
@@ -914,10 +923,15 @@ static struct syscore_ops rk3288_clk_syscore_ops = {
 	.resume = rk3288_clk_resume,
 };
 
+static const struct soc_device_attribute rk3288w[] = {
+	{ .soc_id = "RK32xx", .revision = "RK3288w" },
+	{ /* sentinel */ }
+};
+
+static struct rockchip_clk_provider *ctx;
+
 static void __init rk3288_clk_init(struct device_node *np)
 {
-	struct rockchip_clk_provider *ctx;
-
 	rk3288_cru_base = of_iomap(np, 0);
 	if (!rk3288_cru_base) {
 		pr_err("%s: could not map cru region\n", __func__);
@@ -955,3 +969,17 @@ static void __init rk3288_clk_init(struct device_node *np)
 	rockchip_clk_of_add_provider(np, ctx);
 }
 CLK_OF_DECLARE(rk3288_cru, "rockchip,rk3288-cru", rk3288_clk_init);
+
+static int __init rk3288_hclkvio_register(void)
+{
+	/* Check for the rk3288w revision as clock tree is different */
+	if (soc_device_match(rk3288w))
+		rockchip_clk_register_branches(ctx, rk3288w_hclkvio_branch,
+					       ARRAY_SIZE(rk3288w_hclkvio_branch));
+	else
+		rockchip_clk_register_branches(ctx, rk3288_hclkvio_branch,
+					       ARRAY_SIZE(rk3288_hclkvio_branch));
+
+	return 0;
+}
+subsys_initcall(rk3288_hclkvio_register);
-- 
2.25.1

