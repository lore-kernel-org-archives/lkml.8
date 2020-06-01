Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B321C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F3B8204EA
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgFAPPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:15:13 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40078 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgFAPPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:15:12 -0400
Received: from ni.home (unknown [IPv6:2a01:cb19:8092:cf00:aaa1:59ff:fe08:91d5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: myjosserand)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 0E92A2A2167;
        Mon,  1 Jun 2020 16:15:10 +0100 (BST)
From:   =?UTF-8?q?Myl=C3=A8ne=20Josserand?= 
        <mylene.josserand@collabora.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, heiko@sntech.de
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        mylene.josserand@collabora.com, kever.yang@rock-chips.com,
        geert@linux-m68k.org, kernel@collabora.com
Subject: [PATCH v3 1/1] clk: rockchip: rk3288: Handle clock tree for rk3288w
Date:   Mon,  1 Jun 2020 17:14:42 +0200
Message-Id: <20200601151442.156184-2-mylene.josserand@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601151442.156184-1-mylene.josserand@collabora.com>
References: <20200601151442.156184-1-mylene.josserand@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The revision rk3288w has a different clock tree about "hclk_vio"
clock, according to the BSP kernel code.

This patch handles this difference by detecting which device-tree
we are using. If it is a "rockchip,rk3288-cru", let's register
the clock tree as it was before. If the compatible is
"rockchip,rk3288w-cru", we will apply the difference according to this
version of this SoC.

Noticed that this new device-tree compatible must be handled by
bootloader.

Signed-off-by: Mylène Josserand <mylene.josserand@collabora.com>
---
 drivers/clk/rockchip/clk-rk3288.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index cc2a177bbdbf..5018d2f1e54c 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -425,8 +425,6 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 	COMPOSITE(0, "aclk_vio0", mux_pll_src_cpll_gpll_usb480m_p, CLK_IGNORE_UNUSED,
 			RK3288_CLKSEL_CON(31), 6, 2, MFLAGS, 0, 5, DFLAGS,
 			RK3288_CLKGATE_CON(3), 0, GFLAGS),
-	DIV(0, "hclk_vio", "aclk_vio0", 0,
-			RK3288_CLKSEL_CON(28), 8, 5, DFLAGS),
 	COMPOSITE(0, "aclk_vio1", mux_pll_src_cpll_gpll_usb480m_p, CLK_IGNORE_UNUSED,
 			RK3288_CLKSEL_CON(31), 14, 2, MFLAGS, 8, 5, DFLAGS,
 			RK3288_CLKGATE_CON(3), 2, GFLAGS),
@@ -819,6 +817,16 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
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
@@ -936,6 +944,14 @@ static void __init rk3288_clk_init(struct device_node *np)
 				   RK3288_GRF_SOC_STATUS1);
 	rockchip_clk_register_branches(ctx, rk3288_clk_branches,
 				  ARRAY_SIZE(rk3288_clk_branches));
+
+	if (of_device_is_compatible(np, "rockchip,rk3288w-cru"))
+		rockchip_clk_register_branches(ctx, rk3288w_hclkvio_branch,
+					       ARRAY_SIZE(rk3288w_hclkvio_branch));
+	else
+		rockchip_clk_register_branches(ctx, rk3288_hclkvio_branch,
+					       ARRAY_SIZE(rk3288_hclkvio_branch));
+
 	rockchip_clk_protect_critical(rk3288_critical_clocks,
 				      ARRAY_SIZE(rk3288_critical_clocks));
 
-- 
2.26.2

