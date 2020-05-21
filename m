Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3B7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 22:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5E2B206F6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 22:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbgEUWfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 18:35:17 -0400
Received: from foss.arm.com ([217.140.110.172]:54418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730041AbgEUWfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 18:35:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5897D31B;
        Thu, 21 May 2020 15:35:16 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6FA5D3F305;
        Thu, 21 May 2020 15:35:15 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH] irqchip/gic-v2,v3: Drop extra IRQ_NOAUTOEN setting for (E)PPIs
Date:   Thu, 21 May 2020 23:35:00 +0100
Message-Id: <20200521223500.834-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(E)PPIs are per-CPU interrupts, so we want each CPU to go and enable them
via enable_percpu_irq(); this also means we want IRQ_NOAUTOEN for them as
the autoenable would lead to calling irq_enable() instead of the more
appropriate irq_percpu_enable().

Calling irq_set_percpu_devid() is enough to get just that since it trickles
down to irq_set_percpu_devid_flags(), which gives us IRQ_NOAUTOEN (and a
few others). Setting IRQ_NOAUTOEN *again* right after this call is just
redundant, so don't do it.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 1 -
 drivers/irqchip/irq-gic.c    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index d7006ef18a0d..1ed0cf9c586f 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1282,7 +1282,6 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		irq_set_percpu_devid(irq);
 		irq_domain_set_info(d, irq, hw, chip, d->host_data,
 				    handle_percpu_devid_irq, NULL, NULL);
-		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 		break;
 
 	case SPI_RANGE:
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 30ab623343d3..00de05abd3c3 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -982,7 +982,6 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		irq_set_percpu_devid(irq);
 		irq_domain_set_info(d, irq, hw, &gic->chip, d->host_data,
 				    handle_percpu_devid_irq, NULL, NULL);
-		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 	} else {
 		irq_domain_set_info(d, irq, hw, &gic->chip, d->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
-- 
2.24.0

