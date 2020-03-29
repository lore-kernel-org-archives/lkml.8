Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C525FC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4350207FF
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgC2U2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:28:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56919 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbgC2U0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:13 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIeVW-0001LQ-4j; Sun, 29 Mar 2020 22:26:10 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BF6CE1C0334;
        Sun, 29 Mar 2020 22:26:09 +0200 (CEST)
Date:   Sun, 29 Mar 2020 20:26:09 -0000
From:   "tip-bot2 for Marek Vasut" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/stm32: Retrigger both in eoi and unmask callbacks
Cc:     Marek Vasut <marex@denx.de>, Marc Zyngier <maz@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200323235132.530550-1-marex@denx.de>
References: <20200323235132.530550-1-marex@denx.de>
MIME-Version: 1.0
Message-ID: <158551356939.28353.3524136454839534794.tip-bot2@tip-bot2>
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

Commit-ID:     00760d3cd9de2ccee6b73e30b53e71704a99209e
Gitweb:        https://git.kernel.org/tip/00760d3cd9de2ccee6b73e30b53e71704a99209e
Author:        Marek Vasut <marex@denx.de>
AuthorDate:    Tue, 24 Mar 2020 00:51:32 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 24 Mar 2020 11:12:34 

irqchip/stm32: Retrigger both in eoi and unmask callbacks

Sampling the IRQ line state in EOI and retriggering the interrupt to
work around missing level-triggered interrupt support only works for
non-threaded interrupts. Threaded interrupts must be retriggered the
same way in unmask callback.

Signed-off-by: Marek Vasut <marex@denx.de>
[maz: fixed missing static attribute]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200323235132.530550-1-marex@denx.de
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index d330b30..af3b24f 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -304,18 +304,22 @@ static const struct gpio_chip stm32_gpio_template = {
 	.get_direction		= stm32_gpio_get_direction,
 };
 
-void stm32_gpio_irq_eoi(struct irq_data *d)
+static void stm32_gpio_irq_trigger(struct irq_data *d)
 {
 	struct stm32_gpio_bank *bank = d->domain->host_data;
 	int level;
 
-	irq_chip_eoi_parent(d);
-
 	/* If level interrupt type then retrig */
 	level = stm32_gpio_get(&bank->gpio_chip, d->hwirq);
 	if ((level == 0 && bank->irq_type[d->hwirq] == IRQ_TYPE_LEVEL_LOW) ||
 	    (level == 1 && bank->irq_type[d->hwirq] == IRQ_TYPE_LEVEL_HIGH))
 		irq_chip_retrigger_hierarchy(d);
+}
+
+static void stm32_gpio_irq_eoi(struct irq_data *d)
+{
+	irq_chip_eoi_parent(d);
+	stm32_gpio_irq_trigger(d);
 };
 
 static int stm32_gpio_set_type(struct irq_data *d, unsigned int type)
@@ -371,12 +375,18 @@ static void stm32_gpio_irq_release_resources(struct irq_data *irq_data)
 	gpiochip_unlock_as_irq(&bank->gpio_chip, irq_data->hwirq);
 }
 
+static void stm32_gpio_irq_unmask(struct irq_data *d)
+{
+	irq_chip_unmask_parent(d);
+	stm32_gpio_irq_trigger(d);
+}
+
 static struct irq_chip stm32_gpio_irq_chip = {
 	.name		= "stm32gpio",
 	.irq_eoi	= stm32_gpio_irq_eoi,
 	.irq_ack	= irq_chip_ack_parent,
 	.irq_mask	= irq_chip_mask_parent,
-	.irq_unmask	= irq_chip_unmask_parent,
+	.irq_unmask	= stm32_gpio_irq_unmask,
 	.irq_set_type	= stm32_gpio_set_type,
 	.irq_set_wake	= irq_chip_set_wake_parent,
 	.irq_request_resources = stm32_gpio_irq_request_resources,
