Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957A9C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77BD320C56
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgE3Hqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 03:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbgE3Hqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 03:46:46 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFC6C08C5C9;
        Sat, 30 May 2020 00:46:46 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jewCZ-0001tA-Nk; Sat, 30 May 2020 09:46:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EAF091C04D6;
        Sat, 30 May 2020 09:46:38 +0200 (CEST)
Date:   Sat, 30 May 2020 07:46:38 -0000
From:   "tip-bot2 for Bartosz Golaszewski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Make irq_domain_reset_irq_data() available
 to non-hierarchical users
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200514083901.23445-2-brgl@bgdev.pl>
References: <20200514083901.23445-2-brgl@bgdev.pl>
MIME-Version: 1.0
Message-ID: <159082479875.17951.240413408821890303.tip-bot2@tip-bot2>
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

Commit-ID:     5c8f77a278737a6af44a892f0700d9aadb2b0de0
Gitweb:        https://git.kernel.org/tip/5c8f77a278737a6af44a892f0700d9aadb2b0de0
Author:        Bartosz Golaszewski <bgolaszewski@baylibre.com>
AuthorDate:    Thu, 14 May 2020 10:39:00 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 18 May 2020 10:29:26 +01:00

irqdomain: Make irq_domain_reset_irq_data() available to  non-hierarchical users

irq_domain_reset_irq_data() doesn't modify the parent data, so it can be
made available even if irq domain hierarchy is not being built. We'll
subsequently use it in irq_sim code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20200514083901.23445-2-brgl@bgdev.pl
---
 include/linux/irqdomain.h |  2 +-
 kernel/irq/irqdomain.c    | 24 ++++++++++++------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 8d062e8..b37350c 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -450,6 +450,7 @@ extern void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
 				irq_hw_number_t hwirq, struct irq_chip *chip,
 				void *chip_data, irq_flow_handler_t handler,
 				void *handler_data, const char *handler_name);
+extern void irq_domain_reset_irq_data(struct irq_data *irq_data);
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 extern struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
 			unsigned int flags, unsigned int size,
@@ -491,7 +492,6 @@ extern int irq_domain_set_hwirq_and_chip(struct irq_domain *domain,
 					 irq_hw_number_t hwirq,
 					 struct irq_chip *chip,
 					 void *chip_data);
-extern void irq_domain_reset_irq_data(struct irq_data *irq_data);
 extern void irq_domain_free_irqs_common(struct irq_domain *domain,
 					unsigned int virq,
 					unsigned int nr_irqs);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 35b8d97..e2aa128 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1047,6 +1047,18 @@ int irq_domain_alloc_descs(int virq, unsigned int cnt, irq_hw_number_t hwirq,
 	return virq;
 }
 
+/**
+ * irq_domain_reset_irq_data - Clear hwirq, chip and chip_data in @irq_data
+ * @irq_data:	The pointer to irq_data
+ */
+void irq_domain_reset_irq_data(struct irq_data *irq_data)
+{
+	irq_data->hwirq = 0;
+	irq_data->chip = &no_irq_chip;
+	irq_data->chip_data = NULL;
+}
+EXPORT_SYMBOL_GPL(irq_domain_reset_irq_data);
+
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 /**
  * irq_domain_create_hierarchy - Add a irqdomain into the hierarchy
@@ -1248,18 +1260,6 @@ void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
 EXPORT_SYMBOL(irq_domain_set_info);
 
 /**
- * irq_domain_reset_irq_data - Clear hwirq, chip and chip_data in @irq_data
- * @irq_data:	The pointer to irq_data
- */
-void irq_domain_reset_irq_data(struct irq_data *irq_data)
-{
-	irq_data->hwirq = 0;
-	irq_data->chip = &no_irq_chip;
-	irq_data->chip_data = NULL;
-}
-EXPORT_SYMBOL_GPL(irq_domain_reset_irq_data);
-
-/**
  * irq_domain_free_irqs_common - Clear irq_data and free the parent
  * @domain:	Interrupt domain to match
  * @virq:	IRQ number to start with
