Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C688ECA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F8AE206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589307425;
	bh=n//p7+8M3+kBax9IJzQimioQSM7ABpQuynYGbSHrqYs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=VWk5h3waEl9bc9HEShaUwzVKoAGuxEsQ3KToo7TUms9LXkTudXClnsN1Ncb8E129E
	 zEujZNknATkiTFxwNHsj7VibzCBwQ0Xi9iiHMrgz8l1c1HRyrSsPd1ZvbZ6RKyF7AJ
	 LbJ1F6MNU6zrK5LqsgOcf5McVNDp5ICoEmnMHVxU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbgELSRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 14:17:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbgELSRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 14:17:01 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B8CB206B8;
        Tue, 12 May 2020 18:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589307420;
        bh=n//p7+8M3+kBax9IJzQimioQSM7ABpQuynYGbSHrqYs=;
        h=From:To:Cc:Subject:Date:From;
        b=YKACo0Sa5+3VQjC9NkwMERUHPpazmaLpnrFTEuOIBAC1dtMXLgKB1vPC5tVMOUc3k
         1bTBeDTZt0GN2dlhnJKmLN45iJSmNv7NT+I9HWHMvUiYCQdD5R0pkSlfezGTJraVIL
         hua+QG4Onl3J9kYe+TD6reJDtXxVHJsqJDqFIck4=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-clk@vger.kernel.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com
Subject: [RESEND PATCHv7 1/5] clk: socfpga: stratix10: use new parent data scheme
Date:   Tue, 12 May 2020 13:16:43 -0500
Message-Id: <20200512181647.5071-1-dinguyen@kernel.org>
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
v7: no change
v6: no change
v5: no change
v4: no change
v3: no change
v2: add fw_name
---
 drivers/clk/socfpga/clk-gate-s10.c   |   5 +-
 drivers/clk/socfpga/clk-periph-s10.c |  10 +-
 drivers/clk/socfpga/clk-pll-s10.c    |   4 +-
 drivers/clk/socfpga/clk-s10.c        | 160 ++++++++++++++++++++++-----
 drivers/clk/socfpga/stratix10-clk.h  |   8 +-
 5 files changed, 146 insertions(+), 41 deletions(-)

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
index dea7c6c7d269..c1dfc9b34e4e 100644
--- a/drivers/clk/socfpga/clk-s10.c
+++ b/drivers/clk/socfpga/clk-s10.c
@@ -12,35 +12,137 @@
 
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
+	{ .fw_name = "osc1",
+	  .name = "osc1" },
+	{ .fw_name = "cb-intosc-hs-div2-clk",
+	  .name = "cb-intosc-hs-div2-clk" },
+	{ .fw_name = "f2s-free-clk",
+	  .name = "f2s-free-clk" },
+};
+
+static const struct clk_parent_data cntr_mux[] = {
+	{ .fw_name =  "main_pll",
+	  .name = "main_pll", },
+	{ .fw_name = "periph_pll",
+	  .name = "periph_pll", },
+	{ .fw_name = "osc1",
+	  .name = "osc1", },
+	{ .fw_name = "cb-intosc-hs-div2-clk",
+	  .name = "cb-intosc-hs-div2-clk", },
+	{ .fw_name = "f2s-free-clk",
+	  .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data boot_mux[] = {
+	{ .fw_name = "osc1",
+	  .name = "osc1" },
+	{ .fw_name = "cb-intosc-hs-div2-clk",
+	  .name = "cb-intosc-hs-div2-clk" },
+};
+
+static const struct clk_parent_data noc_free_mux[] = {
+	{ .fw_name = "main_noc_base_clk",
+	  .name = "main_noc_base_clk", },
+	{ .fw_name = "peri_noc_base_clk",
+	  .name = "peri_noc_base_clk", },
+	{ .fw_name = "osc1",
+	  .name = "osc1", },
+	{ .fw_name = "cb-intosc-hs-div2-clk",
+	  .name = "cb-intosc-hs-div2-clk", },
+	{ .fw_name = "f2s-free-clk",
+	  .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data emaca_free_mux[] = {
+	{ .fw_name = "peri_emaca_clk",
+	  .name = "peri_emaca_clk", },
+	{ .fw_name = "boot_clk",
+	  .name = "boot_clk", },
+};
+
+static const struct clk_parent_data emacb_free_mux[] = {
+	{ .fw_name = "peri_emacb_clk",
+	  .name = "peri_emacb_clk", },
+	{ .fw_name = "boot_clk",
+	  .name = "boot_clk", },
+};
+
+static const struct clk_parent_data emac_ptp_free_mux[] = {
+	{ .fw_name = "peri_emac_ptp_clk",
+	  .name = "peri_emac_ptp_clk", },
+	{ .fw_name = "boot_clk",
+	  .name = "boot_clk", },
+};
+
+static const struct clk_parent_data gpio_db_free_mux[] = {
+	{ .fw_name = "peri_gpio_db_clk",
+	  .name = "peri_gpio_db_clk", },
+	{ .fw_name = "boot_clk",
+	  .name = "boot_clk", },
+};
+
+static const struct clk_parent_data sdmmc_free_mux[] = {
+	{ .fw_name = "main_sdmmc_clk",
+	  .name = "main_sdmmc_clk", },
+	{ .fw_name = "boot_clk",
+	  .name = "boot_clk", },
+};
+
+static const struct clk_parent_data s2f_usr1_free_mux[] = {
+	{ .fw_name = "peri_s2f_usr1_clk",
+	  .name = "peri_s2f_usr1_clk", },
+	{ .fw_name = "boot_clk",
+	  .name = "boot_clk", },
+};
+
+static const struct clk_parent_data psi_ref_free_mux[] = {
+	{ .fw_name = "peri_psi_ref_clk",
+	  .name = "peri_psi_ref_clk", },
+	{ .fw_name = "boot_clk",
+	  .name = "boot_clk", },
+};
+
+static const struct clk_parent_data mpu_mux[] = {
+	{ .fw_name = "mpu_free_clk",
+	  .name = "mpu_free_clk", },
+	{ .fw_name = "boot_clk",
+	  .name = "boot_clk", },
+};
+
+static const struct clk_parent_data s2f_usr0_mux[] = {
+	{ .fw_name = "f2s-free-clk",
+	  .name = "f2s-free-clk", },
+	{ .fw_name = "boot_clk",
+	  .name = "boot_clk", },
+};
+
+static const struct clk_parent_data emac_mux[] = {
+	{ .fw_name = "emaca_free_clk",
+	  .name = "emaca_free_clk", },
+	{ .fw_name = "emacb_free_clk",
+	  .name = "emacb_free_clk", },
+};
+
+static const struct clk_parent_data noc_mux[] = {
+	{ .fw_name = "noc_free_clk",
+	  .name = "noc_free_clk", },
+	{ .fw_name = "boot_clk",
+	  .name = "boot_clk", },
+};
+
+static const struct clk_parent_data mpu_free_mux[] = {
+	{ .fw_name = "main_mpu_base_clk",
+	  .name = "main_mpu_base_clk", },
+	{ .fw_name = "peri_mpu_base_clk",
+	  .name = "peri_mpu_base_clk", },
+	{ .fw_name = "osc1",
+	  .name = "osc1", },
+	{ .fw_name = "cb-intosc-hs-div2-clk",
+	  .name = "cb-intosc-hs-div2-clk", },
+	{ .fw_name = "f2s-free-clk",
+	  .name = "f2s-free-clk", },
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

