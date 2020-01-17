Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D012FC33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 21:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FE22083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 21:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbgAQVFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 16:05:36 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:37693 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbgAQVFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 16:05:36 -0500
X-Originating-IP: 90.65.92.102
Received: from localhost (lfbn-lyo-1-1913-102.w90-65.abo.wanadoo.fr [90.65.92.102])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 92A5E40002;
        Fri, 17 Jan 2020 21:05:33 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] clk: at91: add at91sam9g45 pmc driver
Date:   Fri, 17 Jan 2020 22:05:29 +0100
Message-Id: <20200117210529.17490-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the PMC clocks of the at91sam9g45 family.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/Makefile      |   1 +
 drivers/clk/at91/at91sam9g45.c | 220 +++++++++++++++++++++++++++++++++
 2 files changed, 221 insertions(+)
 create mode 100644 drivers/clk/at91/at91sam9g45.c

diff --git a/drivers/clk/at91/Makefile b/drivers/clk/at91/Makefile
index 3732241352ce..c02c53a0e02e 100644
--- a/drivers/clk/at91/Makefile
+++ b/drivers/clk/at91/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_HAVE_AT91_GENERATED_CLK)	+= clk-generated.o
 obj-$(CONFIG_HAVE_AT91_I2S_MUX_CLK)	+= clk-i2s-mux.o
 obj-$(CONFIG_HAVE_AT91_SAM9X60_PLL)	+= clk-sam9x60-pll.o
 obj-$(CONFIG_SOC_AT91SAM9) += at91sam9260.o at91sam9rl.o at91sam9x5.o
+obj-$(CONFIG_SOC_AT91SAM9) += at91sam9g45.o
 obj-$(CONFIG_SOC_SAM9X60) += sam9x60.o
 obj-$(CONFIG_SOC_SAMA5D4) += sama5d4.o
 obj-$(CONFIG_SOC_SAMA5D2) += sama5d2.o
diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
new file mode 100644
index 000000000000..38a7d2d2df0c
--- /dev/null
+++ b/drivers/clk/at91/at91sam9g45.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/clk-provider.h>
+#include <linux/mfd/syscon.h>
+#include <linux/slab.h>
+
+#include <dt-bindings/clock/at91.h>
+
+#include "pmc.h"
+
+static const struct clk_master_characteristics mck_characteristics = {
+	.output = { .min = 0, .max = 133333333 },
+	.divisors = { 1, 2, 4, 3 },
+};
+
+static u8 plla_out[] = { 0, 1, 2, 3, 0, 1, 2, 3 };
+
+static u16 plla_icpll[] = { 0, 0, 0, 0, 1, 1, 1, 1 };
+
+static const struct clk_range plla_outputs[] = {
+	{ .min = 745000000, .max = 800000000 },
+	{ .min = 695000000, .max = 750000000 },
+	{ .min = 645000000, .max = 700000000 },
+	{ .min = 595000000, .max = 650000000 },
+	{ .min = 545000000, .max = 600000000 },
+	{ .min = 495000000, .max = 555000000 },
+	{ .min = 445000000, .max = 500000000 },
+	{ .min = 400000000, .max = 450000000 },
+};
+
+static const struct clk_pll_characteristics plla_characteristics = {
+	.input = { .min = 2000000, .max = 32000000 },
+	.num_output = ARRAY_SIZE(plla_outputs),
+	.output = plla_outputs,
+	.icpll = plla_icpll,
+	.out = plla_out,
+};
+
+static const struct {
+	char *n;
+	char *p;
+	u8 id;
+} at91sam9g45_systemck[] = {
+	{ .n = "ddrck", .p = "masterck", .id = 2 },
+	{ .n = "uhpck", .p = "usbck",    .id = 6 },
+	{ .n = "pck0",  .p = "prog0",    .id = 8 },
+	{ .n = "pck1",  .p = "prog1",    .id = 9 },
+};
+
+static const struct clk_pcr_layout at91sam9g45_pcr_layout = {
+	.offset = 0x10c,
+	.cmd = BIT(12),
+	.pid_mask = GENMASK(5, 0),
+	.div_mask = GENMASK(17, 16),
+};
+
+struct pck {
+	char *n;
+	u8 id;
+};
+
+static const struct pck at91sam9g45_periphck[] = {
+	{ .n = "pioA_clk",       .id = 2, },
+	{ .n = "pioB_clk",       .id = 3, },
+	{ .n = "pioC_clk",       .id = 4, },
+	{ .n = "pioDE_clk",      .id = 5, },
+	{ .n = "trng_clk",       .id = 6, },
+	{ .n = "usart0_clk",     .id = 7, },
+	{ .n = "usart1_clk",     .id = 8, },
+	{ .n = "usart2_clk",     .id = 9, },
+	{ .n = "usart3_clk",     .id = 10, },
+	{ .n = "mci0_clk",       .id = 11, },
+	{ .n = "twi0_clk",       .id = 12, },
+	{ .n = "twi1_clk",       .id = 13, },
+	{ .n = "spi0_clk",       .id = 14, },
+	{ .n = "spi1_clk",       .id = 15, },
+	{ .n = "ssc0_clk",       .id = 16, },
+	{ .n = "ssc1_clk",       .id = 17, },
+	{ .n = "tcb0_clk",       .id = 18, },
+	{ .n = "pwm_clk",        .id = 19, },
+	{ .n = "adc_clk",        .id = 20, },
+	{ .n = "dma0_clk",       .id = 21, },
+	{ .n = "uhphs_clk",      .id = 22, },
+	{ .n = "lcd_clk",        .id = 23, },
+	{ .n = "ac97_clk",       .id = 24, },
+	{ .n = "macb0_clk",      .id = 25, },
+	{ .n = "isi_clk",        .id = 26, },
+	{ .n = "udphs_clk",      .id = 27, },
+	{ .n = "aestdessha_clk", .id = 28, },
+	{ .n = "mci1_clk",       .id = 29, },
+	{ .n = "vdec_clk",       .id = 30, },
+};
+
+static void __init at91sam9g45_pmc_setup(struct device_node *np)
+{
+	const char *slck_name, *mainxtal_name;
+	struct pmc_data *at91sam9g45_pmc;
+	const char *parent_names[6];
+	struct regmap *regmap;
+	struct clk_hw *hw;
+	int i;
+	bool bypass;
+
+	i = of_property_match_string(np, "clock-names", "slow_clk");
+	if (i < 0)
+		return;
+
+	slck_name = of_clk_get_parent_name(np, i);
+
+	i = of_property_match_string(np, "clock-names", "main_xtal");
+	if (i < 0)
+		return;
+	mainxtal_name = of_clk_get_parent_name(np, i);
+
+	regmap = syscon_node_to_regmap(np);
+	if (IS_ERR(regmap))
+		return;
+
+	at91sam9g45_pmc = pmc_data_allocate(PMC_MAIN + 1,
+					    nck(at91sam9g45_systemck),
+					    nck(at91sam9g45_periphck), 0);
+	if (!at91sam9g45_pmc)
+		return;
+
+	bypass = of_property_read_bool(np, "atmel,osc-bypass");
+
+	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name,
+					bypass);
+	if (IS_ERR(hw))
+		goto err_free;
+
+	hw = at91_clk_register_rm9200_main(regmap, "mainck", "main_osc");
+	if (IS_ERR(hw))
+		goto err_free;
+
+	at91sam9g45_pmc->chws[PMC_MAIN] = hw;
+
+	hw = at91_clk_register_pll(regmap, "pllack", "mainck", 0,
+				   &at91rm9200_pll_layout, &plla_characteristics);
+	if (IS_ERR(hw))
+		goto err_free;
+
+	hw = at91_clk_register_plldiv(regmap, "plladivck", "pllack");
+	if (IS_ERR(hw))
+		goto err_free;
+
+	hw = at91_clk_register_utmi(regmap, NULL, "utmick", "mainck");
+	if (IS_ERR(hw))
+		goto err_free;
+
+	at91sam9g45_pmc->chws[PMC_UTMI] = hw;
+
+	parent_names[0] = slck_name;
+	parent_names[1] = "mainck";
+	parent_names[2] = "plladivck";
+	parent_names[3] = "utmick";
+	hw = at91_clk_register_master(regmap, "masterck", 4, parent_names,
+				      &at91rm9200_master_layout,
+				      &mck_characteristics);
+	if (IS_ERR(hw))
+		goto err_free;
+
+	at91sam9g45_pmc->chws[PMC_MCK] = hw;
+
+	parent_names[0] = "plladivck";
+	parent_names[1] = "utmick";
+	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, 2);
+	if (IS_ERR(hw))
+		goto err_free;
+
+	parent_names[0] = slck_name;
+	parent_names[1] = "mainck";
+	parent_names[2] = "plladivck";
+	parent_names[3] = "utmick";
+	parent_names[4] = "masterck";
+	for (i = 0; i < 2; i++) {
+		char name[6];
+
+		snprintf(name, sizeof(name), "prog%d", i);
+
+		hw = at91_clk_register_programmable(regmap, name,
+						    parent_names, 5, i,
+						    &at91sam9g45_programmable_layout);
+		if (IS_ERR(hw))
+			goto err_free;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(at91sam9g45_systemck); i++) {
+		hw = at91_clk_register_system(regmap, at91sam9g45_systemck[i].n,
+					      at91sam9g45_systemck[i].p,
+					      at91sam9g45_systemck[i].id);
+		if (IS_ERR(hw))
+			goto err_free;
+
+		at91sam9g45_pmc->shws[at91sam9g45_systemck[i].id] = hw;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(at91sam9g45_periphck); i++) {
+		hw = at91_clk_register_peripheral(regmap,
+						  at91sam9g45_periphck[i].n,
+						  "masterck",
+						  at91sam9g45_periphck[i].id);
+		if (IS_ERR(hw))
+			goto err_free;
+
+		at91sam9g45_pmc->phws[at91sam9g45_periphck[i].id] = hw;
+	}
+
+	of_clk_add_hw_provider(np, of_clk_hw_pmc_get, at91sam9g45_pmc);
+
+	return;
+
+err_free:
+	pmc_data_free(at91sam9g45_pmc);
+}
+/*
+ * The TCB is used as the clocksource so its clock is needed early. This means
+ * this can't be a platform driver.
+ */
+CLK_OF_DECLARE_DRIVER(at91sam9g45_pmc, "atmel,at91sam9g45-pmc",
+		      at91sam9g45_pmc_setup);
-- 
2.24.1

