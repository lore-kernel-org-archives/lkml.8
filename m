Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32CFC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A26920781
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgC2U0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:26:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57096 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbgC2U0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:38 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIeVt-0001VF-0v; Sun, 29 Mar 2020 22:26:33 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 80E0A1C0450;
        Sun, 29 Mar 2020 22:26:22 +0200 (CEST)
Date:   Sun, 29 Mar 2020 20:26:22 -0000
From:   "tip-bot2 for afzal mohammed" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip: Replace setup_irq() by request_irq()
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200304004839.4729-1-afzal.mohd.ma@gmail.com>
References: <20200304004839.4729-1-afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Message-ID: <158551358214.28353.15463615152083988179.tip-bot2@tip-bot2>
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

Commit-ID:     2ef1cb763d92f3e212005fcf5dcc713eaf42b257
Gitweb:        https://git.kernel.org/tip/2ef1cb763d92f3e212005fcf5dcc713eaf42b257
Author:        afzal mohammed <afzal.mohd.ma@gmail.com>
AuthorDate:    Wed, 04 Mar 2020 06:18:38 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 08 Mar 2020 14:25:46 

irqchip: Replace setup_irq() by request_irq()

request_irq() is preferred over setup_irq(). Invocations of setup_irq()
occur after memory allocators are ready.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200304004839.4729-1-afzal.mohd.ma@gmail.com
---
 drivers/irqchip/irq-i8259.c   | 16 ++++++----------
 drivers/irqchip/irq-ingenic.c |  9 +++------
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/irqchip/irq-i8259.c b/drivers/irqchip/irq-i8259.c
index d000870..b6f6aa7 100644
--- a/drivers/irqchip/irq-i8259.c
+++ b/drivers/irqchip/irq-i8259.c
@@ -268,15 +268,6 @@ static void init_8259A(int auto_eoi)
 	raw_spin_unlock_irqrestore(&i8259A_lock, flags);
 }
 
-/*
- * IRQ2 is cascade interrupt to second interrupt controller
- */
-static struct irqaction irq2 = {
-	.handler = no_action,
-	.name = "cascade",
-	.flags = IRQF_NO_THREAD,
-};
-
 static struct resource pic1_io_resource = {
 	.name = "pic1",
 	.start = PIC_MASTER_CMD,
@@ -311,6 +302,10 @@ static const struct irq_domain_ops i8259A_ops = {
  */
 struct irq_domain * __init __init_i8259_irqs(struct device_node *node)
 {
+	/*
+	 * PIC_CASCADE_IR is cascade interrupt to second interrupt controller
+	 */
+	int irq = I8259A_IRQ_BASE + PIC_CASCADE_IR;
 	struct irq_domain *domain;
 
 	insert_resource(&ioport_resource, &pic1_io_resource);
@@ -323,7 +318,8 @@ struct irq_domain * __init __init_i8259_irqs(struct device_node *node)
 	if (!domain)
 		panic("Failed to add i8259 IRQ domain");
 
-	setup_irq(I8259A_IRQ_BASE + PIC_CASCADE_IR, &irq2);
+	if (request_irq(irq, no_action, IRQF_NO_THREAD, "cascade", NULL))
+		pr_err("Failed to register cascade interrupt\n");
 	register_syscore_ops(&i8259_syscore_ops);
 	return domain;
 }
diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index c5589ee..9f3da42 100644
--- a/drivers/irqchip/irq-ingenic.c
+++ b/drivers/irqchip/irq-ingenic.c
@@ -58,11 +58,6 @@ static irqreturn_t intc_cascade(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction intc_cascade_action = {
-	.handler = intc_cascade,
-	.name = "SoC intc cascade interrupt",
-};
-
 static int __init ingenic_intc_of_init(struct device_node *node,
 				       unsigned num_chips)
 {
@@ -130,7 +125,9 @@ static int __init ingenic_intc_of_init(struct device_node *node,
 		irq_reg_writel(gc, IRQ_MSK(32), JZ_REG_INTC_SET_MASK);
 	}
 
-	setup_irq(parent_irq, &intc_cascade_action);
+	if (request_irq(parent_irq, intc_cascade, 0,
+			"SoC intc cascade interrupt", NULL))
+		pr_err("Failed to register SoC intc cascade interrupt\n");
 	return 0;
 
 out_domain_remove:
