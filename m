Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3624C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E9D2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392223AbgAXTNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:13:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42994 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391879AbgAXTLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 14:11:13 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iv4MH-0007a9-3H; Fri, 24 Jan 2020 20:11:09 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 27E241C1A60;
        Fri, 24 Jan 2020 20:11:08 +0100 (CET)
Date:   Fri, 24 Jan 2020 19:11:07 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v4.1: Plumb skeletal VPE irqchip
Cc:     Marc Zyngier <maz@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191224111055.11836-10-maz@kernel.org>
References: <20191224111055.11836-10-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <157989306791.396.8970880490139867084.tip-bot2@tip-bot2>
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

Commit-ID:     29c647f3b5ae1a20221d477442dcdf058cea4a21
Gitweb:        https://git.kernel.org/tip/29c647f3b5ae1a20221d477442dcdf058cea4a21
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 24 Dec 2019 11:10:32 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 22 Jan 2020 14:22:20 

irqchip/gic-v4.1: Plumb skeletal VPE irqchip

Just like for GICv4.0, each VPE has its own doorbell interrupt, and
thus an irqchip that manages them. Since the doorbell management is
quite different on GICv4.1, let's introduce an almost empty irqchip
the will get populated over the next new patches.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Link: https://lore.kernel.org/r/20191224111055.11836-10-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c | 32 ++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 53a7663..2b477e2 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3553,6 +3553,32 @@ static struct irq_chip its_vpe_irq_chip = {
 	.irq_set_vcpu_affinity	= its_vpe_set_vcpu_affinity,
 };
 
+static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
+{
+	struct its_cmd_info *info = vcpu_info;
+
+	switch (info->cmd_type) {
+	case SCHEDULE_VPE:
+		return 0;
+
+	case DESCHEDULE_VPE:
+		return 0;
+
+	case INVALL_VPE:
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static struct irq_chip its_vpe_4_1_irq_chip = {
+	.name			= "GICv4.1-vpe",
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_affinity	= its_vpe_set_affinity,
+	.irq_set_vcpu_affinity	= its_vpe_4_1_set_vcpu_affinity,
+};
+
 static int its_vpe_id_alloc(void)
 {
 	return ida_simple_get(&its_vpeid_ida, 0, ITS_MAX_VPEID, GFP_KERNEL);
@@ -3633,6 +3659,7 @@ static void its_vpe_irq_domain_free(struct irq_domain *domain,
 static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				    unsigned int nr_irqs, void *args)
 {
+	struct irq_chip *irqchip = &its_vpe_irq_chip;
 	struct its_vm *vm = args;
 	unsigned long *bitmap;
 	struct page *vprop_page;
@@ -3660,6 +3687,9 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 	vm->nr_db_lpis = nr_ids;
 	vm->vprop_page = vprop_page;
 
+	if (gic_rdists->has_rvpeid)
+		irqchip = &its_vpe_4_1_irq_chip;
+
 	for (i = 0; i < nr_irqs; i++) {
 		vm->vpes[i]->vpe_db_lpi = base + i;
 		err = its_vpe_init(vm->vpes[i]);
@@ -3670,7 +3700,7 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 		if (err)
 			break;
 		irq_domain_set_hwirq_and_chip(domain, virq + i, i,
-					      &its_vpe_irq_chip, vm->vpes[i]);
+					      irqchip, vm->vpes[i]);
 		set_bit(i, bitmap);
 	}
 
