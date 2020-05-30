Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB92C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51C4020776
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgE3Hra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 03:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbgE3Hqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 03:46:38 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEB1C03E969;
        Sat, 30 May 2020 00:46:38 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jewCR-0001rS-BT; Sat, 30 May 2020 09:46:35 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 07CE71C032F;
        Sat, 30 May 2020 09:46:35 +0200 (CEST)
Date:   Sat, 30 May 2020 07:46:34 -0000
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v2, v3: Drop extra IRQ_NOAUTOEN setting
 for (E)PPIs
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521223500.834-1-valentin.schneider@arm.com>
References: <20200521223500.834-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <159082479487.17951.7616935515233095878.tip-bot2@tip-bot2>
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

Commit-ID:     cc86432aa8cc5a81f99d79eea2a29099da694df3
Gitweb:        https://git.kernel.org/tip/cc86432aa8cc5a81f99d79eea2a29099da694df3
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Thu, 21 May 2020 23:35:00 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 25 May 2020 10:32:51 +01:00

irqchip/gic-v2, v3: Drop extra IRQ_NOAUTOEN setting for (E)PPIs

(E)PPIs are per-CPU interrupts, so we want each CPU to go and enable them
via enable_percpu_irq(); this also means we want IRQ_NOAUTOEN for them as
the autoenable would lead to calling irq_enable() instead of the more
appropriate irq_percpu_enable().

Calling irq_set_percpu_devid() is enough to get just that since it trickles
down to irq_set_percpu_devid_flags(), which gives us IRQ_NOAUTOEN (and a
few others). Setting IRQ_NOAUTOEN *again* right after this call is just
redundant, so don't do it.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200521223500.834-1-valentin.schneider@arm.com
---
 drivers/irqchip/irq-gic-v3.c | 1 -
 drivers/irqchip/irq-gic.c    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 98c886d..cc46bc2 100644
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
index 30ab623..00de05a 100644
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
