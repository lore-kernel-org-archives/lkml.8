Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDD0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 17:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DE0B2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 17:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbgG3RFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 13:05:23 -0400
Received: from foss.arm.com ([217.140.110.172]:42706 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729843AbgG3RFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 13:05:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FE261063;
        Thu, 30 Jul 2020 10:05:21 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 709CB3F66E;
        Thu, 30 Jul 2020 10:05:20 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Subject: [PATCH v2 2/2] irqchip/gic-v2, v3: Prevent SW resends entirely
Date:   Thu, 30 Jul 2020 18:03:21 +0100
Message-Id: <20200730170321.31228-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200730170321.31228-1-valentin.schneider@arm.com>
References: <20200730170321.31228-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GIC irqchips can now use a HW resend when a retrigger is invoked by
check_irq_resend(). However, should the HW resend fail, check_irq_resend()
will still attempt to trigger a SW resend, which is still a bad idea for
the GICs.

Prevent this from happening by setting IRQD_HANDLE_ENFORCE_IRQCTX on all
GIC IRQs. Technically per-cpu IRQs do not need this, as their flow handlers
never set IRQS_PENDING, but this aligns all IRQs wrt context enforcement:
this also forces all GIC IRQ handling to happen in IRQ context (as defined
by in_irq()).

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 5 ++++-
 drivers/irqchip/irq-gic.c    | 6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 0fbcbf55ec48..1a8acf7cd8ac 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1279,6 +1279,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 			      irq_hw_number_t hw)
 {
 	struct irq_chip *chip = &gic_chip;
+	struct irq_data *irqd = irq_desc_get_irq_data(irq_to_desc(irq));
 
 	if (static_branch_likely(&supports_deactivate_key))
 		chip = &gic_eoimode1_chip;
@@ -1296,7 +1297,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		irq_domain_set_info(d, irq, hw, chip, d->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
 		irq_set_probe(irq);
-		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(irq)));
+		irqd_set_single_target(irqd);
 		break;
 
 	case LPI_RANGE:
@@ -1310,6 +1311,8 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		return -EPERM;
 	}
 
+	/* Prevents SW retriggers which mess up the ACK/EOI ordering */
+	irqd_set_handle_enforce_irqctx(irqd);
 	return 0;
 }
 
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index e2b4cae88bce..a91ce1e73bd2 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -983,6 +983,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 				irq_hw_number_t hw)
 {
 	struct gic_chip_data *gic = d->host_data;
+	struct irq_data *irqd = irq_desc_get_irq_data(irq_to_desc(irq));
 
 	if (hw < 32) {
 		irq_set_percpu_devid(irq);
@@ -992,8 +993,11 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		irq_domain_set_info(d, irq, hw, &gic->chip, d->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
 		irq_set_probe(irq);
-		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(irq)));
+		irqd_set_single_target(irqd);
 	}
+
+	/* Prevents SW retriggers which mess up the ACK/EOI ordering */
+	irqd_set_handle_enforce_irqctx(irqd);
 	return 0;
 }
 
-- 
2.27.0

