Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B01C3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 20:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79E424690
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 20:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582922188;
	bh=82G5bMsbbX/PJ9S7g4In+ZAGDal1cM6uHXZ3zbPyr8Q=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=CF7xA2K/OL1KAlugYBwf0adIaATh16/Q/bx7B7Wk8AmVOPQp2BPIFdWgzMzrsiJQK
	 OlAR6w5Zwwud1I7dIIzA1cbzDPUAPiWuk6Q6Ghu0+52oCqbNPa2s5ZUwNscSpHh6PB
	 nOnW7jPx9IZ2p/Pqs7X+0ktjR6MR0Sfc0cu/2dgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgB1UgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 15:36:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:43366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1UgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 15:36:24 -0500
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00A2D24690;
        Fri, 28 Feb 2020 20:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582922182;
        bh=82G5bMsbbX/PJ9S7g4In+ZAGDal1cM6uHXZ3zbPyr8Q=;
        h=From:To:Cc:Subject:Date:From;
        b=j5k27icMOr5YfokqXjjMWO1g95b2bVgj8Lbilm6RYfDo9JZCHI91t5DVLuJjh/M59
         2eQMjN0efa+rz7o2yXgl1zUHsUROMVRT5P+hJNq6NJSttICLoXyIcZ5pvmPTb51lmp
         FPP9H5FHMGvInhpr6bDXQfVWzGmWRHjxoKII1iHQ=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     sboyd@kernel.org
Cc:     dinguyen@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: socfpga: stratix10: use new parent data scheme
Date:   Fri, 28 Feb 2020 14:36:11 -0600
Message-Id: <20200228203611.15507-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert, where possible, the stratix10 clock driver to the new parent
data scheme by specifying the parent data for clocks that have multiple
parents.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/clk/socfpga/clk-gate-s10.c   |   5 +-
 drivers/clk/socfpga/clk-periph-s10.c |  10 ++-
 drivers/clk/socfpga/clk-pll-s10.c    |   4 +-
 drivers/clk/socfpga/clk-s10.c        | 110 ++++++++++++++++++++-------
 drivers/clk/socfpga/stratix10-clk.h  |   8 +-
 5 files changed, 96 insertions(+), 41 deletions(-)

diff --git a/drivers/clk/socfpga/clk-gate-s10.c b/drivers/clk/socfpga/clk-gate-s10.c
index 8be4722f6064..083b2ec21fdd 100644
--- a/drivers/clk/socfpga/clk-gate-s10.c
+++ b/drivers/clk/socfpga/clk-gate-s10.c
@@ -70,7 +70,6 @@ struct clk *s10_register_gate(const struct stratix10_gate_clock *clks, void __io
 	struct clk *clk;
 	struct socfpga_gate_clk *socfpga_clk;
 	struct clk_init_data init;
-	const char * const *parent_names = clks->parent_names;
 	const char *parent_name = clks->parent_name;
 
 	socfpga_clk = kzalloc(sizeof(*socfpga_clk), GFP_KERNEL);
@@ -108,7 +107,9 @@ struct clk *s10_register_gate(const struct stratix10_gate_clock *clks, void __io
 	init.flags = clks->flags;
 
 	init.num_parents = clks->num_parents;
-	init.parent_names = parent_names ? parent_names : &parent_name;
+	init.parent_names = parent_name ? &parent_name : NULL;
+	if (init.parent_names == NULL)
+		init.parent_data = clks->parent_data;
 	socfpga_clk->hw.hw.init = &init;
 
 	clk = clk_register(NULL, &socfpga_clk->hw.hw);
diff --git a/drivers/clk/socfpga/clk-periph-s10.c b/drivers/clk/socfpga/clk-periph-s10.c
index dd6d4056e9de..397b77b89b16 100644
--- a/drivers/clk/socfpga/clk-periph-s10.c
+++ b/drivers/clk/socfpga/clk-periph-s10.c
@@ -81,7 +81,6 @@ struct clk *s10_register_periph(const struct stratix10_perip_c_clock *clks,
 	struct clk_init_data init;
 	const char *name = clks->name;
 	const char *parent_name = clks->parent_name;
-	const char * const *parent_names = clks->parent_names;
 
 	periph_clk = kzalloc(sizeof(*periph_clk), GFP_KERNEL);
 	if (WARN_ON(!periph_clk))
@@ -94,7 +93,9 @@ struct clk *s10_register_periph(const struct stratix10_perip_c_clock *clks,
 	init.flags = clks->flags;
 
 	init.num_parents = clks->num_parents;
-	init.parent_names = parent_names ? parent_names : &parent_name;
+	init.parent_names = parent_name ? &parent_name : NULL;
+	if (init.parent_names == NULL)
+		init.parent_data = clks->parent_data;
 
 	periph_clk->hw.hw.init = &init;
 
@@ -114,7 +115,6 @@ struct clk *s10_register_cnt_periph(const struct stratix10_perip_cnt_clock *clks
 	struct clk_init_data init;
 	const char *name = clks->name;
 	const char *parent_name = clks->parent_name;
-	const char * const *parent_names = clks->parent_names;
 
 	periph_clk = kzalloc(sizeof(*periph_clk), GFP_KERNEL);
 	if (WARN_ON(!periph_clk))
@@ -137,7 +137,9 @@ struct clk *s10_register_cnt_periph(const struct stratix10_perip_cnt_clock *clks
 	init.flags = clks->flags;
 
 	init.num_parents = clks->num_parents;
-	init.parent_names = parent_names ? parent_names : &parent_name;
+	init.parent_names = parent_name ? &parent_name : NULL;
+	if (init.parent_names == NULL)
+		init.parent_data = clks->parent_data;
 
 	periph_clk->hw.hw.init = &init;
 
diff --git a/drivers/clk/socfpga/clk-pll-s10.c b/drivers/clk/socfpga/clk-pll-s10.c
index a301bb22f36c..bcd3f14e9145 100644
--- a/drivers/clk/socfpga/clk-pll-s10.c
+++ b/drivers/clk/socfpga/clk-pll-s10.c
@@ -117,7 +117,6 @@ struct clk *s10_register_pll(const struct stratix10_pll_clock *clks,
 	struct socfpga_pll *pll_clk;
 	struct clk_init_data init;
 	const char *name = clks->name;
-	const char * const *parent_names = clks->parent_names;
 
 	pll_clk = kzalloc(sizeof(*pll_clk), GFP_KERNEL);
 	if (WARN_ON(!pll_clk))
@@ -134,7 +133,8 @@ struct clk *s10_register_pll(const struct stratix10_pll_clock *clks,
 	init.flags = clks->flags;
 
 	init.num_parents = clks->num_parents;
-	init.parent_names = parent_names;
+	init.parent_names = NULL;
+	init.parent_data = clks->parent_data;
 	pll_clk->hw.hw.init = &init;
 
 	pll_clk->hw.bit_idx = SOCFPGA_PLL_POWER;
diff --git a/drivers/clk/socfpga/clk-s10.c b/drivers/clk/socfpga/clk-s10.c
index dea7c6c7d269..ed11c8509a15 100644
--- a/drivers/clk/socfpga/clk-s10.c
+++ b/drivers/clk/socfpga/clk-s10.c
@@ -12,35 +12,87 @@
 
 #include "stratix10-clk.h"
 
-static const char * const pll_mux[] = { "osc1", "cb-intosc-hs-div2-clk",
-					"f2s-free-clk",};
-static const char * const cntr_mux[] = { "main_pll", "periph_pll",
-					 "osc1", "cb-intosc-hs-div2-clk",
-					 "f2s-free-clk"};
-static const char * const boot_mux[] = { "osc1", "cb-intosc-hs-div2-clk",};
-
-static const char * const noc_free_mux[] = {"main_noc_base_clk",
-					    "peri_noc_base_clk",
-					    "osc1", "cb-intosc-hs-div2-clk",
-					    "f2s-free-clk"};
-
-static const char * const emaca_free_mux[] = {"peri_emaca_clk", "boot_clk"};
-static const char * const emacb_free_mux[] = {"peri_emacb_clk", "boot_clk"};
-static const char * const emac_ptp_free_mux[] = {"peri_emac_ptp_clk", "boot_clk"};
-static const char * const gpio_db_free_mux[] = {"peri_gpio_db_clk", "boot_clk"};
-static const char * const sdmmc_free_mux[] = {"main_sdmmc_clk", "boot_clk"};
-static const char * const s2f_usr1_free_mux[] = {"peri_s2f_usr1_clk", "boot_clk"};
-static const char * const psi_ref_free_mux[] = {"peri_psi_ref_clk", "boot_clk"};
-static const char * const mpu_mux[] = { "mpu_free_clk", "boot_clk",};
-
-static const char * const s2f_usr0_mux[] = {"f2s-free-clk", "boot_clk"};
-static const char * const emac_mux[] = {"emaca_free_clk", "emacb_free_clk"};
-static const char * const noc_mux[] = {"noc_free_clk", "boot_clk"};
-
-static const char * const mpu_free_mux[] = {"main_mpu_base_clk",
-					    "peri_mpu_base_clk",
-					    "osc1", "cb-intosc-hs-div2-clk",
-					    "f2s-free-clk"};
+static const struct clk_parent_data pll_mux[] = {
+	{ .name = "osc1" },
+	{ .name = "cb-intosc-hs-div2-clk" },
+	{ .name = "f2s-free-clk" },
+};
+
+static const struct clk_parent_data cntr_mux[] = {
+	{ .name = "main_pll", },
+	{ .name = "periph_pll", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data boot_mux[] = {
+	{ .name = "osc1" },
+	{ .name = "cb-intosc-hs-div2-clk" },
+};
+
+static const struct clk_parent_data noc_free_mux[] = {
+	{ .name = "main_noc_base_clk", },
+	{ .name = "peri_noc_base_clk", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data emaca_free_mux[] = {
+	{ .name = "peri_emaca_clk", },
+	{ .name = "boot_clk", },
+};
+
+static const struct clk_parent_data emacb_free_mux[] = {
+	{ .name = "peri_emacb_clk", },
+	{ .name = "boot_clk", },
+};
+static const struct clk_parent_data emac_ptp_free_mux[] = {
+	{ .name = "peri_emac_ptp_clk", },
+	{ .name = "boot_clk", },
+};
+static const struct clk_parent_data gpio_db_free_mux[] = {
+	{ .name = "peri_gpio_db_clk", },
+	{ .name = "boot_clk", },
+};
+static const struct clk_parent_data sdmmc_free_mux[] = {
+	{ .name = "main_sdmmc_clk", },
+	{ .name = "boot_clk", },
+};
+static const struct clk_parent_data s2f_usr1_free_mux[] = {
+	{ .name = "peri_s2f_usr1_clk", },
+	{ .name = "boot_clk", },
+};
+static const struct clk_parent_data psi_ref_free_mux[] = {
+	{ .name = "peri_psi_ref_clk", },
+	{ .name = "boot_clk", },
+};
+static const struct clk_parent_data mpu_mux[] = {
+	{ .name = "mpu_free_clk", },
+	{ .name = "boot_clk", },
+};
+
+static const struct clk_parent_data s2f_usr0_mux[] = {
+	{ .name = "f2s-free-clk", },
+	{ .name = "boot_clk", },
+};
+static const struct clk_parent_data emac_mux[] = {
+	{ .name = "emaca_free_clk", },
+	{ .name = "emacb_free_clk", },
+};
+static const struct clk_parent_data noc_mux[] = {
+	{ .name = "noc_free_clk", },
+	{ .name = "boot_clk", },
+};
+
+static const struct clk_parent_data mpu_free_mux[] = {
+	{ .name = "main_mpu_base_clk", },
+	{ .name = "peri_mpu_base_clk", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
 
 /* clocks in AO (always on) controller */
 static const struct stratix10_pll_clock s10_pll_clks[] = {
diff --git a/drivers/clk/socfpga/stratix10-clk.h b/drivers/clk/socfpga/stratix10-clk.h
index fcabef42249c..ffbd1fb2c8ef 100644
--- a/drivers/clk/socfpga/stratix10-clk.h
+++ b/drivers/clk/socfpga/stratix10-clk.h
@@ -14,7 +14,7 @@ struct stratix10_clock_data {
 struct stratix10_pll_clock {
 	unsigned int		id;
 	const char		*name;
-	const char		*const *parent_names;
+	const struct clk_parent_data	*parent_data;
 	u8			num_parents;
 	unsigned long		flags;
 	unsigned long		offset;
@@ -24,7 +24,7 @@ struct stratix10_perip_c_clock {
 	unsigned int		id;
 	const char		*name;
 	const char		*parent_name;
-	const char		*const *parent_names;
+	const struct clk_parent_data	*parent_data;
 	u8			num_parents;
 	unsigned long		flags;
 	unsigned long		offset;
@@ -34,7 +34,7 @@ struct stratix10_perip_cnt_clock {
 	unsigned int		id;
 	const char		*name;
 	const char		*parent_name;
-	const char		*const *parent_names;
+	const struct clk_parent_data	*parent_data;
 	u8			num_parents;
 	unsigned long		flags;
 	unsigned long		offset;
@@ -47,7 +47,7 @@ struct stratix10_gate_clock {
 	unsigned int		id;
 	const char		*name;
 	const char		*parent_name;
-	const char		*const *parent_names;
+	const struct clk_parent_data	*parent_data;
 	u8			num_parents;
 	unsigned long		flags;
 	unsigned long		gate_reg;
-- 
2.17.1

