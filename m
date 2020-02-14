Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD54CC3B19F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 14:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6EC24649
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 14:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387600AbgBNO75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 09:59:57 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:44731 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387561AbgBNO74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 09:59:56 -0500
Received: from localhost (lfbn-lyo-1-1670-129.w90-65.abo.wanadoo.fr [90.65.102.129])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 789F524000E;
        Fri, 14 Feb 2020 14:59:52 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] clk: at91: add at91rm9200 pmc driver
Date:   Fri, 14 Feb 2020 15:59:33 +0100
Message-Id: <20200214145934.53648-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the PMC clocks of the at91rm9200.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/Makefile     |   1 +
 drivers/clk/at91/at91rm9200.c | 199 ++++++++++++++++++++++++++++++++++
 2 files changed, 200 insertions(+)
 create mode 100644 drivers/clk/at91/at91rm9200.c

diff --git a/drivers/clk/at91/Makefile b/drivers/clk/at91/Makefile
index 3732241352ce..08fa7930c8fd 100644
--- a/drivers/clk/at91/Makefile
+++ b/drivers/clk/at91/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_HAVE_AT91_H32MX)		+= clk-h32mx.o
 obj-$(CONFIG_HAVE_AT91_GENERATED_CLK)	+= clk-generated.o
 obj-$(CONFIG_HAVE_AT91_I2S_MUX_CLK)	+= clk-i2s-mux.o
 obj-$(CONFIG_HAVE_AT91_SAM9X60_PLL)	+= clk-sam9x60-pll.o
+obj-$(CONFIG_SOC_AT91RM9200) += at91rm9200.o
 obj-$(CONFIG_SOC_AT91SAM9) += at91sam9260.o at91sam9rl.o at91sam9x5.o
 obj-$(CONFIG_SOC_SAM9X60) += sam9x60.o
 obj-$(CONFIG_SOC_SAMA5D4) += sama5d4.o
diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
new file mode 100644
index 000000000000..90b2ace7f7bd
--- /dev/null
+++ b/drivers/clk/at91/at91rm9200.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/clk-provider.h>
+#include <linux/mfd/syscon.h>
+#include <linux/slab.h>
+
+#include <dt-bindings/clock/at91.h>
+
+#include "pmc.h"
+
+struct sck {
+	char *n;
+	char *p;
+	u8 id;
+};
+
+struct pck {
+	char *n;
+	u8 id;
+};
+
+static const struct clk_master_characteristics rm9200_mck_characteristics = {
+	.output = { .min = 0, .max = 80000000 },
+	.divisors = { 1, 2, 3, 4 },
+};
+
+static u8 rm9200_pll_out[] = { 0, 2 };
+
+static const struct clk_range rm9200_pll_outputs[] = {
+	{ .min = 80000000, .max = 160000000 },
+	{ .min = 150000000, .max = 180000000 },
+};
+
+static const struct clk_pll_characteristics rm9200_pll_characteristics = {
+	.input = { .min = 1000000, .max = 32000000 },
+	.num_output = ARRAY_SIZE(rm9200_pll_outputs),
+	.output = rm9200_pll_outputs,
+	.out = rm9200_pll_out,
+};
+
+static const struct sck at91rm9200_systemck[] = {
+	{ .n = "udpck", .p = "usbck",    .id = 2 },
+	{ .n = "uhpck", .p = "usbck",    .id = 4 },
+	{ .n = "pck0",  .p = "prog0",    .id = 8 },
+	{ .n = "pck1",  .p = "prog1",    .id = 9 },
+	{ .n = "pck2",  .p = "prog2",    .id = 10 },
+	{ .n = "pck3",  .p = "prog3",    .id = 11 },
+};
+
+static const struct pck at91rm9200_periphck[] = {
+	{ .n = "pioA_clk",   .id = 2 },
+	{ .n = "pioB_clk",   .id = 3 },
+	{ .n = "pioC_clk",   .id = 4 },
+	{ .n = "pioD_clk",   .id = 5 },
+	{ .n = "usart0_clk", .id = 6 },
+	{ .n = "usart1_clk", .id = 7 },
+	{ .n = "usart2_clk", .id = 8 },
+	{ .n = "usart3_clk", .id = 9 },
+	{ .n = "mci0_clk",   .id = 10 },
+	{ .n = "udc_clk",    .id = 11 },
+	{ .n = "twi0_clk",   .id = 12 },
+	{ .n = "spi0_clk",   .id = 13 },
+	{ .n = "ssc0_clk",   .id = 14 },
+	{ .n = "ssc1_clk",   .id = 15 },
+	{ .n = "ssc2_clk",   .id = 16 },
+	{ .n = "tc0_clk",    .id = 17 },
+	{ .n = "tc1_clk",    .id = 18 },
+	{ .n = "tc2_clk",    .id = 19 },
+	{ .n = "tc3_clk",    .id = 20 },
+	{ .n = "tc4_clk",    .id = 21 },
+	{ .n = "tc5_clk",    .id = 22 },
+	{ .n = "ohci_clk",   .id = 23 },
+	{ .n = "macb0_clk",  .id = 24 },
+};
+
+static void __init at91rm9200_pmc_setup(struct device_node *np)
+{
+	const char *slowxtal_name, *mainxtal_name;
+	struct pmc_data *at91rm9200_pmc;
+	u32 usb_div[] = { 1, 2, 0, 0 };
+	const char *parent_names[6];
+	struct regmap *regmap;
+	struct clk_hw *hw;
+	int i;
+	bool bypass;
+
+	i = of_property_match_string(np, "clock-names", "slow_xtal");
+	if (i < 0)
+		return;
+
+	slowxtal_name = of_clk_get_parent_name(np, i);
+
+	i = of_property_match_string(np, "clock-names", "main_xtal");
+	if (i < 0)
+		return;
+	mainxtal_name = of_clk_get_parent_name(np, i);
+
+	regmap = device_node_to_regmap(np);
+	if (IS_ERR(regmap))
+		return;
+
+	at91rm9200_pmc = pmc_data_allocate(PMC_MAIN + 1,
+					    nck(at91rm9200_systemck),
+					    nck(at91rm9200_periphck), 0);
+	if (!at91rm9200_pmc)
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
+	at91rm9200_pmc->chws[PMC_MAIN] = hw;
+
+	hw = at91_clk_register_pll(regmap, "pllack", "mainck", 0,
+				   &at91rm9200_pll_layout,
+				   &rm9200_pll_characteristics);
+	if (IS_ERR(hw))
+		goto err_free;
+
+	hw = at91_clk_register_pll(regmap, "pllbck", "mainck", 1,
+				   &at91rm9200_pll_layout,
+				   &rm9200_pll_characteristics);
+	if (IS_ERR(hw))
+		goto err_free;
+
+	parent_names[0] = slowxtal_name;
+	parent_names[1] = "mainck";
+	parent_names[2] = "pllack";
+	parent_names[3] = "pllbck";
+	hw = at91_clk_register_master(regmap, "masterck", 4, parent_names,
+				      &at91rm9200_master_layout,
+				      &rm9200_mck_characteristics);
+	if (IS_ERR(hw))
+		goto err_free;
+
+	at91rm9200_pmc->chws[PMC_MCK] = hw;
+
+	hw = at91rm9200_clk_register_usb(regmap, "usbck", "pllbck", usb_div);
+	if (IS_ERR(hw))
+		goto err_free;
+
+	parent_names[0] = slowxtal_name;
+	parent_names[1] = "mainck";
+	parent_names[2] = "pllack";
+	parent_names[3] = "pllbck";
+	for (i = 0; i < 4; i++) {
+		char name[6];
+
+		snprintf(name, sizeof(name), "prog%d", i);
+
+		hw = at91_clk_register_programmable(regmap, name,
+						    parent_names, 4, i,
+						    &at91rm9200_programmable_layout);
+		if (IS_ERR(hw))
+			goto err_free;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(at91rm9200_systemck); i++) {
+		hw = at91_clk_register_system(regmap, at91rm9200_systemck[i].n,
+					      at91rm9200_systemck[i].p,
+					      at91rm9200_systemck[i].id);
+		if (IS_ERR(hw))
+			goto err_free;
+
+		at91rm9200_pmc->shws[at91rm9200_systemck[i].id] = hw;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(at91rm9200_periphck); i++) {
+		hw = at91_clk_register_peripheral(regmap,
+						  at91rm9200_periphck[i].n,
+						  "masterck",
+						  at91rm9200_periphck[i].id);
+		if (IS_ERR(hw))
+			goto err_free;
+
+		at91rm9200_pmc->phws[at91rm9200_periphck[i].id] = hw;
+	}
+
+	of_clk_add_hw_provider(np, of_clk_hw_pmc_get, at91rm9200_pmc);
+
+	return;
+
+err_free:
+	pmc_data_free(at91rm9200_pmc);
+}
+/* 
+ * While the TCB can be used as the clocksource, the system timer is most likely
+ * to be used instead. However, the pinctrl driver doesn't support probe
+ * deferring properly. Once this is fixed, this can be switched to a platform
+ * driver.
+ */
+CLK_OF_DECLARE_DRIVER(at91rm9200_pmc, "atmel,at91rm9200-pmc",
+		      at91rm9200_pmc_setup);
-- 
2.24.1

