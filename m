Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998B7C2D0E5
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7849B20781
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgC2U0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:26:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57093 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728900AbgC2U0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:38 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIeVq-0001X9-R1; Sun, 29 Mar 2020 22:26:31 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7928C1C07A5;
        Sun, 29 Mar 2020 22:26:24 +0200 (CEST)
Date:   Sun, 29 Mar 2020 20:26:24 -0000
From:   "tip-bot2 for Alexandre Torgue" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] pinctrl: stm32: Add level interrupt support to gpio irq chip
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        Marc Zyngier <maz@kernel.org>, Marek Vasut <marex@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200219143229.18084-3-alexandre.torgue@st.com>
References: <20200219143229.18084-3-alexandre.torgue@st.com>
MIME-Version: 1.0
Message-ID: <158551358409.28353.6617704278446088456.tip-bot2@tip-bot2>
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

Commit-ID:     47beed513a85b3561e74cbb4dd7af848716fa4e0
Gitweb:        https://git.kernel.org/tip/47beed513a85b3561e74cbb4dd7af848716fa4e0
Author:        Alexandre Torgue <alexandre.torgue@st.com>
AuthorDate:    Wed, 19 Feb 2020 15:32:29 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 08 Mar 2020 14:25:45 

pinctrl: stm32: Add level interrupt support to gpio irq chip

GPIO hardware block is directly linked to EXTI block but EXTI handles
external interrupts only on edge. To be able to handle GPIO interrupt on
level a "hack" is done in gpio irq chip: parent interrupt (exti irq chip)
is retriggered following interrupt type and gpio line value.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Tested-by: Marek Vasut <marex@denx.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20200219143229.18084-3-alexandre.torgue@st.com
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 45 ++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 2d5e043..d330b30 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -92,6 +92,7 @@ struct stm32_gpio_bank {
 	u32 bank_nr;
 	u32 bank_ioport_nr;
 	u32 pin_backup[STM32_GPIO_PINS_PER_BANK];
+	u8 irq_type[STM32_GPIO_PINS_PER_BANK];
 };
 
 struct stm32_pinctrl {
@@ -303,6 +304,46 @@ static const struct gpio_chip stm32_gpio_template = {
 	.get_direction		= stm32_gpio_get_direction,
 };
 
+void stm32_gpio_irq_eoi(struct irq_data *d)
+{
+	struct stm32_gpio_bank *bank = d->domain->host_data;
+	int level;
+
+	irq_chip_eoi_parent(d);
+
+	/* If level interrupt type then retrig */
+	level = stm32_gpio_get(&bank->gpio_chip, d->hwirq);
+	if ((level == 0 && bank->irq_type[d->hwirq] == IRQ_TYPE_LEVEL_LOW) ||
+	    (level == 1 && bank->irq_type[d->hwirq] == IRQ_TYPE_LEVEL_HIGH))
+		irq_chip_retrigger_hierarchy(d);
+};
+
+static int stm32_gpio_set_type(struct irq_data *d, unsigned int type)
+{
+	struct stm32_gpio_bank *bank = d->domain->host_data;
+	u32 parent_type;
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+	case IRQ_TYPE_EDGE_FALLING:
+	case IRQ_TYPE_EDGE_BOTH:
+		parent_type = type;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		parent_type = IRQ_TYPE_EDGE_RISING;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		parent_type = IRQ_TYPE_EDGE_FALLING;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	bank->irq_type[d->hwirq] = type;
+
+	return irq_chip_set_type_parent(d, parent_type);
+};
+
 static int stm32_gpio_irq_request_resources(struct irq_data *irq_data)
 {
 	struct stm32_gpio_bank *bank = irq_data->domain->host_data;
@@ -332,11 +373,11 @@ static void stm32_gpio_irq_release_resources(struct irq_data *irq_data)
 
 static struct irq_chip stm32_gpio_irq_chip = {
 	.name		= "stm32gpio",
-	.irq_eoi	= irq_chip_eoi_parent,
+	.irq_eoi	= stm32_gpio_irq_eoi,
 	.irq_ack	= irq_chip_ack_parent,
 	.irq_mask	= irq_chip_mask_parent,
 	.irq_unmask	= irq_chip_unmask_parent,
-	.irq_set_type	= irq_chip_set_type_parent,
+	.irq_set_type	= stm32_gpio_set_type,
 	.irq_set_wake	= irq_chip_set_wake_parent,
 	.irq_request_resources = stm32_gpio_irq_request_resources,
 	.irq_release_resources = stm32_gpio_irq_release_resources,
