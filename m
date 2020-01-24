Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F158EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BBA2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404183AbgAXTMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:12:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43048 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404026AbgAXTLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 14:11:21 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iv4MP-0007e3-DL; Fri, 24 Jan 2020 20:11:17 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7552B1C1A68;
        Fri, 24 Jan 2020 20:11:11 +0100 (CET)
Date:   Fri, 24 Jan 2020 19:11:11 -0000
From:   "tip-bot2 for Qianggui Song" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/meson-gpio: Add support for meson a1 SoCs
Cc:     Qianggui Song <qianggui.song@amlogic.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191216123645.10099-4-qianggui.song@amlogic.com>
References: <20191216123645.10099-4-qianggui.song@amlogic.com>
MIME-Version: 1.0
Message-ID: <157989307130.396.17626728958086987704.tip-bot2@tip-bot2>
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

Commit-ID:     8f78bd62bdd7a7b0a9906c4827245bf17056f781
Gitweb:        https://git.kernel.org/tip/8f78bd62bdd7a7b0a9906c4827245bf17056f781
Author:        Qianggui Song <qianggui.song@amlogic.com>
AuthorDate:    Mon, 16 Dec 2019 20:36:44 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 20 Jan 2020 19:10:05 

irqchip/meson-gpio: Add support for meson a1 SoCs

The meson a1 Socs have some changes compared with previous
chips. For A113L, it contains 62 pins and can be spied on:

- 62:128 undefined
- 61:50 12 pins on bank A
- 49:37 13 pins on bank F
- 36:20 17 pins on bank X
- 19:13 7  pins on bank B
- 12:0  13 pins on bank P

There are five relative registers for gpio interrupt controller,
details are as below:

- PADCTRL_GPIO_IRQ_CTRL0
  bit[31]:    enable/disable the whole irq lines
  bit[16-23]: both edge trigger
  bit[8-15]:  single edge trigger
  bit[0-7]:   pol trigger

- PADCTRL_GPIO_IRQ_CTRL[X]
  bit[0-6]:   7 bits to choose gpio source for irq line 2*[X] - 2
  bit[16-22]: 7 bits to choose gpio source for irq line 2*[X] - 1
  where X =1,2,3,4

Signed-off-by: Qianggui Song <qianggui.song@amlogic.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20191216123645.10099-4-qianggui.song@amlogic.com
---
 drivers/irqchip/irq-meson-gpio.c | 42 +++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index 5a1a59e..ccc7f82 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -24,6 +24,9 @@
 #define REG_PIN_47_SEL	0x08
 #define REG_FILTER_SEL	0x0c
 
+/* use for A1 like chips */
+#define REG_PIN_A1_SEL	0x04
+
 /*
  * Note: The S905X3 datasheet reports that BOTH_EDGE is controlled by
  * bits 24 to 31. Tests on the actual HW show that these bits are
@@ -44,6 +47,10 @@ struct meson_gpio_irq_controller;
 static void meson8_gpio_irq_sel_pin(struct meson_gpio_irq_controller *ctl,
 				    unsigned int channel, unsigned long hwirq);
 static void meson_gpio_irq_init_dummy(struct meson_gpio_irq_controller *ctl);
+static void meson_a1_gpio_irq_sel_pin(struct meson_gpio_irq_controller *ctl,
+				      unsigned int channel,
+				      unsigned long hwirq);
+static void meson_a1_gpio_irq_init(struct meson_gpio_irq_controller *ctl);
 
 struct irq_ctl_ops {
 	void (*gpio_irq_sel_pin)(struct meson_gpio_irq_controller *ctl,
@@ -75,6 +82,15 @@ struct meson_gpio_irq_params {
 	.pol_low_offset = 16,					\
 	.pin_sel_mask = 0xff,					\
 
+#define INIT_MESON_A1_COMMON_DATA(irqs)				\
+	INIT_MESON_COMMON(irqs, meson_a1_gpio_irq_init,		\
+			  meson_a1_gpio_irq_sel_pin)		\
+	.support_edge_both = true,				\
+	.edge_both_offset = 16,					\
+	.edge_single_offset = 8,				\
+	.pol_low_offset = 0,					\
+	.pin_sel_mask = 0x7f,					\
+
 static const struct meson_gpio_irq_params meson8_params = {
 	INIT_MESON8_COMMON_DATA(134)
 };
@@ -101,6 +117,10 @@ static const struct meson_gpio_irq_params sm1_params = {
 	.edge_both_offset = 8,
 };
 
+static const struct meson_gpio_irq_params a1_params = {
+	INIT_MESON_A1_COMMON_DATA(62)
+};
+
 static const struct of_device_id meson_irq_gpio_matches[] = {
 	{ .compatible = "amlogic,meson8-gpio-intc", .data = &meson8_params },
 	{ .compatible = "amlogic,meson8b-gpio-intc", .data = &meson8b_params },
@@ -109,6 +129,7 @@ static const struct of_device_id meson_irq_gpio_matches[] = {
 	{ .compatible = "amlogic,meson-axg-gpio-intc", .data = &axg_params },
 	{ .compatible = "amlogic,meson-g12a-gpio-intc", .data = &axg_params },
 	{ .compatible = "amlogic,meson-sm1-gpio-intc", .data = &sm1_params },
+	{ .compatible = "amlogic,meson-a1-gpio-intc", .data = &a1_params },
 	{ }
 };
 
@@ -149,6 +170,27 @@ static void meson8_gpio_irq_sel_pin(struct meson_gpio_irq_controller *ctl,
 				   hwirq << bit_offset);
 }
 
+static void meson_a1_gpio_irq_sel_pin(struct meson_gpio_irq_controller *ctl,
+				      unsigned int channel,
+				      unsigned long hwirq)
+{
+	unsigned int reg_offset;
+	unsigned int bit_offset;
+
+	bit_offset = ((channel % 2) == 0) ? 0 : 16;
+	reg_offset = REG_PIN_A1_SEL + ((channel / 2) << 2);
+
+	meson_gpio_irq_update_bits(ctl, reg_offset,
+				   ctl->params->pin_sel_mask << bit_offset,
+				   hwirq << bit_offset);
+}
+
+/* For a1 or later chips like a1 there is a switch to enable/disable irq */
+static void meson_a1_gpio_irq_init(struct meson_gpio_irq_controller *ctl)
+{
+	meson_gpio_irq_update_bits(ctl, REG_EDGE_POL, BIT(31), BIT(31));
+}
+
 static int
 meson_gpio_irq_request_channel(struct meson_gpio_irq_controller *ctl,
 			       unsigned long  hwirq,
