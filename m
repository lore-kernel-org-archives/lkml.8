Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A926AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D7E2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392102AbgAXTMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:12:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43096 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404120AbgAXTL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 14:11:29 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iv4MX-0007ib-Uy; Fri, 24 Jan 2020 20:11:26 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BDA251C1A6F;
        Fri, 24 Jan 2020 20:11:13 +0100 (CET)
Date:   Fri, 24 Jan 2020 19:11:13 -0000
From:   "tip-bot2 for Yash Shah" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/nvic: Use irq_domain_translate_onecell
 instead of custom func
Cc:     Yash Shah <yash.shah@sifive.com>, Marc Zyngier <maz@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1575976274-13487-3-git-send-email-yash.shah@sifive.com>
References: <1575976274-13487-3-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Message-ID: <157989307358.396.14143246091966609267.tip-bot2@tip-bot2>
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

Commit-ID:     459c3bc8c497d6b665c2efd15ee7df0f4e19452a
Gitweb:        https://git.kernel.org/tip/459c3bc8c497d6b665c2efd15ee7df0f4e19452a
Author:        Yash Shah <yash.shah@sifive.com>
AuthorDate:    Tue, 10 Dec 2019 16:41:10 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 20 Jan 2020 09:24:47 

irqchip/nvic: Use irq_domain_translate_onecell instead of custom func

Make use of newly introduced irq_domain_translate_onecell() instead of
custom made function.

Signed-off-by: Yash Shah <yash.shah@sifive.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1575976274-13487-3-git-send-email-yash.shah@sifive.com
---
 drivers/irqchip/irq-nvic.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
index a166d30..f747e22 100644
--- a/drivers/irqchip/irq-nvic.c
+++ b/drivers/irqchip/irq-nvic.c
@@ -45,17 +45,6 @@ nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
 	handle_IRQ(irq, regs);
 }
 
-static int nvic_irq_domain_translate(struct irq_domain *d,
-				     struct irq_fwspec *fwspec,
-				     unsigned long *hwirq, unsigned int *type)
-{
-	if (WARN_ON(fwspec->param_count < 1))
-		return -EINVAL;
-	*hwirq = fwspec->param[0];
-	*type = IRQ_TYPE_NONE;
-	return 0;
-}
-
 static int nvic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				unsigned int nr_irqs, void *arg)
 {
@@ -64,7 +53,7 @@ static int nvic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	unsigned int type = IRQ_TYPE_NONE;
 	struct irq_fwspec *fwspec = arg;
 
-	ret = nvic_irq_domain_translate(domain, fwspec, &hwirq, &type);
+	ret = irq_domain_translate_onecell(domain, fwspec, &hwirq, &type);
 	if (ret)
 		return ret;
 
@@ -75,7 +64,7 @@ static int nvic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 }
 
 static const struct irq_domain_ops nvic_irq_domain_ops = {
-	.translate = nvic_irq_domain_translate,
+	.translate = irq_domain_translate_onecell,
 	.alloc = nvic_irq_domain_alloc,
 	.free = irq_domain_free_irqs_top,
 };
