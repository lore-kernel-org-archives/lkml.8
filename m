Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29D4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADAD24686
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404109AbgAXTL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:11:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43043 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404012AbgAXTLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 14:11:21 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iv4MO-0007e2-DL; Fri, 24 Jan 2020 20:11:16 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AEC3E1C1A69;
        Fri, 24 Jan 2020 20:11:11 +0100 (CET)
Date:   Fri, 24 Jan 2020 19:11:11 -0000
From:   "tip-bot2 for Qianggui Song" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/meson-gpio: Rework meson irqchip driver to
 support meson-A1 SoCs
Cc:     Qianggui Song <qianggui.song@amlogic.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191216123645.10099-3-qianggui.song@amlogic.com>
References: <20191216123645.10099-3-qianggui.song@amlogic.com>
MIME-Version: 1.0
Message-ID: <157989307153.396.6528484151738683758.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e2514165f36edac382a95474a73ba2bfa51bc2b2
Gitweb:        https://git.kernel.org/tip/e2514165f36edac382a95474a73ba2bfa51bc2b2
Author:        Qianggui Song <qianggui.song@amlogic.com>
AuthorDate:    Mon, 16 Dec 2019 20:36:43 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 20 Jan 2020 19:10:05 

irqchip/meson-gpio: Rework meson irqchip driver to support meson-A1 SoCs

Since Meson-A1 SoCs register layout of gpio interrupt controller has
difference with previous chips, registers to decide irq line and offset
of trigger method are all changed, the current driver should be modified.

Signed-off-by: Qianggui Song <qianggui.song@amlogic.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20191216123645.10099-3-qianggui.song@amlogic.com
---
 drivers/irqchip/irq-meson-gpio.c | 95 ++++++++++++++++++++++---------
 1 file changed, 70 insertions(+), 25 deletions(-)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index 829084b..5a1a59e 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -30,44 +30,75 @@
  * stuck at 0. Bits 8 to 15 are responsive and have the expected
  * effect.
  */
-#define REG_EDGE_POL_EDGE(x)	BIT(x)
-#define REG_EDGE_POL_LOW(x)	BIT(16 + (x))
-#define REG_BOTH_EDGE(x)	BIT(8 + (x))
-#define REG_EDGE_POL_MASK(x)    (	\
-		REG_EDGE_POL_EDGE(x) |	\
-		REG_EDGE_POL_LOW(x)  |	\
-		REG_BOTH_EDGE(x))
+#define REG_EDGE_POL_EDGE(params, x)	BIT((params)->edge_single_offset + (x))
+#define REG_EDGE_POL_LOW(params, x)	BIT((params)->pol_low_offset + (x))
+#define REG_BOTH_EDGE(params, x)	BIT((params)->edge_both_offset + (x))
+#define REG_EDGE_POL_MASK(params, x)    (	\
+		REG_EDGE_POL_EDGE(params, x) |	\
+		REG_EDGE_POL_LOW(params, x)  |	\
+		REG_BOTH_EDGE(params, x))
 #define REG_PIN_SEL_SHIFT(x)	(((x) % 4) * 8)
 #define REG_FILTER_SEL_SHIFT(x)	((x) * 4)
 
+struct meson_gpio_irq_controller;
+static void meson8_gpio_irq_sel_pin(struct meson_gpio_irq_controller *ctl,
+				    unsigned int channel, unsigned long hwirq);
+static void meson_gpio_irq_init_dummy(struct meson_gpio_irq_controller *ctl);
+
+struct irq_ctl_ops {
+	void (*gpio_irq_sel_pin)(struct meson_gpio_irq_controller *ctl,
+				 unsigned int channel, unsigned long hwirq);
+	void (*gpio_irq_init)(struct meson_gpio_irq_controller *ctl);
+};
+
 struct meson_gpio_irq_params {
 	unsigned int nr_hwirq;
 	bool support_edge_both;
+	unsigned int edge_both_offset;
+	unsigned int edge_single_offset;
+	unsigned int pol_low_offset;
+	unsigned int pin_sel_mask;
+	struct irq_ctl_ops ops;
 };
 
+#define INIT_MESON_COMMON(irqs, init, sel)			\
+	.nr_hwirq = irqs,					\
+	.ops = {						\
+		.gpio_irq_init = init,				\
+		.gpio_irq_sel_pin = sel,			\
+	},
+
+#define INIT_MESON8_COMMON_DATA(irqs)				\
+	INIT_MESON_COMMON(irqs, meson_gpio_irq_init_dummy,	\
+			  meson8_gpio_irq_sel_pin)		\
+	.edge_single_offset = 0,				\
+	.pol_low_offset = 16,					\
+	.pin_sel_mask = 0xff,					\
+
 static const struct meson_gpio_irq_params meson8_params = {
-	.nr_hwirq = 134,
+	INIT_MESON8_COMMON_DATA(134)
 };
 
 static const struct meson_gpio_irq_params meson8b_params = {
-	.nr_hwirq = 119,
+	INIT_MESON8_COMMON_DATA(119)
 };
 
 static const struct meson_gpio_irq_params gxbb_params = {
-	.nr_hwirq = 133,
+	INIT_MESON8_COMMON_DATA(133)
 };
 
 static const struct meson_gpio_irq_params gxl_params = {
-	.nr_hwirq = 110,
+	INIT_MESON8_COMMON_DATA(110)
 };
 
 static const struct meson_gpio_irq_params axg_params = {
-	.nr_hwirq = 100,
+	INIT_MESON8_COMMON_DATA(100)
 };
 
 static const struct meson_gpio_irq_params sm1_params = {
-	.nr_hwirq = 100,
+	INIT_MESON8_COMMON_DATA(100)
 	.support_edge_both = true,
+	.edge_both_offset = 8,
 };
 
 static const struct of_device_id meson_irq_gpio_matches[] = {
@@ -100,9 +131,22 @@ static void meson_gpio_irq_update_bits(struct meson_gpio_irq_controller *ctl,
 	writel_relaxed(tmp, ctl->base + reg);
 }
 
-static unsigned int meson_gpio_irq_channel_to_reg(unsigned int channel)
+static void meson_gpio_irq_init_dummy(struct meson_gpio_irq_controller *ctl)
 {
-	return (channel < 4) ? REG_PIN_03_SEL : REG_PIN_47_SEL;
+}
+
+static void meson8_gpio_irq_sel_pin(struct meson_gpio_irq_controller *ctl,
+				    unsigned int channel, unsigned long hwirq)
+{
+	unsigned int reg_offset;
+	unsigned int bit_offset;
+
+	reg_offset = (channel < 4) ? REG_PIN_03_SEL : REG_PIN_47_SEL;
+	bit_offset = REG_PIN_SEL_SHIFT(channel);
+
+	meson_gpio_irq_update_bits(ctl, reg_offset,
+				   ctl->params->pin_sel_mask << bit_offset,
+				   hwirq << bit_offset);
 }
 
 static int
@@ -110,7 +154,7 @@ meson_gpio_irq_request_channel(struct meson_gpio_irq_controller *ctl,
 			       unsigned long  hwirq,
 			       u32 **channel_hwirq)
 {
-	unsigned int reg, idx;
+	unsigned int idx;
 
 	spin_lock(&ctl->lock);
 
@@ -129,10 +173,7 @@ meson_gpio_irq_request_channel(struct meson_gpio_irq_controller *ctl,
 	 * Setup the mux of the channel to route the signal of the pad
 	 * to the appropriate input of the GIC
 	 */
-	reg = meson_gpio_irq_channel_to_reg(idx);
-	meson_gpio_irq_update_bits(ctl, reg,
-				   0xff << REG_PIN_SEL_SHIFT(idx),
-				   hwirq << REG_PIN_SEL_SHIFT(idx));
+	ctl->params->ops.gpio_irq_sel_pin(ctl, idx, hwirq);
 
 	/*
 	 * Get the hwirq number assigned to this channel through
@@ -173,7 +214,9 @@ static int meson_gpio_irq_type_setup(struct meson_gpio_irq_controller *ctl,
 {
 	u32 val = 0;
 	unsigned int idx;
+	const struct meson_gpio_irq_params *params;
 
+	params = ctl->params;
 	idx = meson_gpio_irq_get_channel_idx(ctl, channel_hwirq);
 
 	/*
@@ -190,22 +233,22 @@ static int meson_gpio_irq_type_setup(struct meson_gpio_irq_controller *ctl,
 	 * precedence over the other edge/polarity settings
 	 */
 	if (type == IRQ_TYPE_EDGE_BOTH) {
-		if (!ctl->params->support_edge_both)
+		if (!params->support_edge_both)
 			return -EINVAL;
 
-		val |= REG_BOTH_EDGE(idx);
+		val |= REG_BOTH_EDGE(params, idx);
 	} else {
 		if (type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING))
-			val |= REG_EDGE_POL_EDGE(idx);
+			val |= REG_EDGE_POL_EDGE(params, idx);
 
 		if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_EDGE_FALLING))
-			val |= REG_EDGE_POL_LOW(idx);
+			val |= REG_EDGE_POL_LOW(params, idx);
 	}
 
 	spin_lock(&ctl->lock);
 
 	meson_gpio_irq_update_bits(ctl, REG_EDGE_POL,
-				   REG_EDGE_POL_MASK(idx), val);
+				   REG_EDGE_POL_MASK(params, idx), val);
 
 	spin_unlock(&ctl->lock);
 
@@ -371,6 +414,8 @@ static int __init meson_gpio_irq_parse_dt(struct device_node *node,
 		return ret;
 	}
 
+	ctl->params->ops.gpio_irq_init(ctl);
+
 	return 0;
 }
 
