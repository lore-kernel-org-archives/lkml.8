Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C557C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2832B20B80
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgC2U0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:26:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56900 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgC2U0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:10 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIeVS-0001JG-Vr; Sun, 29 Mar 2020 22:26:07 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8E0CF1C0451;
        Sun, 29 Mar 2020 22:26:06 +0200 (CEST)
Date:   Sun, 29 Mar 2020 20:26:06 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v4.1: Add VSGI allocation/teardown
Cc:     Marc Zyngier <maz@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200304203330.4967-15-maz@kernel.org>
References: <20200304203330.4967-15-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <158551356619.28353.3805591305388999695.tip-bot2@tip-bot2>
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

Commit-ID:     6d31b6ff985dbd144b2c4d519cf573b8f81865d9
Gitweb:        https://git.kernel.org/tip/6d31b6ff985dbd144b2c4d519cf573b8f81865d9
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 04 Mar 2020 20:33:21 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 24 Mar 2020 12:15:51 

irqchip/gic-v4.1: Add VSGI allocation/teardown

Allocate per-VPE SGIs when initializing the GIC-specific part of the
VPE data structure.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Link: https://lore.kernel.org/r/20200304203330.4967-15-maz@kernel.org
---
 drivers/irqchip/irq-gic-v4.c       | 68 ++++++++++++++++++++++++++++-
 include/linux/irqchip/arm-gic-v4.h |  2 +-
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v4.c b/drivers/irqchip/irq-gic-v4.c
index 117ba6d..99b33f6 100644
--- a/drivers/irqchip/irq-gic-v4.c
+++ b/drivers/irqchip/irq-gic-v4.c
@@ -92,6 +92,47 @@ static bool has_v4_1(void)
 	return !!sgi_domain_ops;
 }
 
+static int its_alloc_vcpu_sgis(struct its_vpe *vpe, int idx)
+{
+	char *name;
+	int sgi_base;
+
+	if (!has_v4_1())
+		return 0;
+
+	name = kasprintf(GFP_KERNEL, "GICv4-sgi-%d", task_pid_nr(current));
+	if (!name)
+		goto err;
+
+	vpe->fwnode = irq_domain_alloc_named_id_fwnode(name, idx);
+	if (!vpe->fwnode)
+		goto err;
+
+	kfree(name);
+	name = NULL;
+
+	vpe->sgi_domain = irq_domain_create_linear(vpe->fwnode, 16,
+						   sgi_domain_ops, vpe);
+	if (!vpe->sgi_domain)
+		goto err;
+
+	sgi_base = __irq_domain_alloc_irqs(vpe->sgi_domain, -1, 16,
+					       NUMA_NO_NODE, vpe,
+					       false, NULL);
+	if (sgi_base <= 0)
+		goto err;
+
+	return 0;
+
+err:
+	if (vpe->sgi_domain)
+		irq_domain_remove(vpe->sgi_domain);
+	if (vpe->fwnode)
+		irq_domain_free_fwnode(vpe->fwnode);
+	kfree(name);
+	return -ENOMEM;
+}
+
 int its_alloc_vcpu_irqs(struct its_vm *vm)
 {
 	int vpe_base_irq, i;
@@ -118,8 +159,13 @@ int its_alloc_vcpu_irqs(struct its_vm *vm)
 	if (vpe_base_irq <= 0)
 		goto err;
 
-	for (i = 0; i < vm->nr_vpes; i++)
+	for (i = 0; i < vm->nr_vpes; i++) {
+		int ret;
 		vm->vpes[i]->irq = vpe_base_irq + i;
+		ret = its_alloc_vcpu_sgis(vm->vpes[i], i);
+		if (ret)
+			goto err;
+	}
 
 	return 0;
 
@@ -132,8 +178,28 @@ err:
 	return -ENOMEM;
 }
 
+static void its_free_sgi_irqs(struct its_vm *vm)
+{
+	int i;
+
+	if (!has_v4_1())
+		return;
+
+	for (i = 0; i < vm->nr_vpes; i++) {
+		unsigned int irq = irq_find_mapping(vm->vpes[i]->sgi_domain, 0);
+
+		if (WARN_ON(!irq))
+			continue;
+
+		irq_domain_free_irqs(irq, 16);
+		irq_domain_remove(vm->vpes[i]->sgi_domain);
+		irq_domain_free_fwnode(vm->vpes[i]->fwnode);
+	}
+}
+
 void its_free_vcpu_irqs(struct its_vm *vm)
 {
+	its_free_sgi_irqs(vm);
 	irq_domain_free_irqs(vm->vpes[0]->irq, vm->nr_vpes);
 	irq_domain_remove(vm->domain);
 	irq_domain_free_fwnode(vm->fwnode);
diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
index 34ed4b5..b120a01 100644
--- a/include/linux/irqchip/arm-gic-v4.h
+++ b/include/linux/irqchip/arm-gic-v4.h
@@ -49,6 +49,8 @@ struct its_vpe {
 		};
 		/* GICv4.1 implementations */
 		struct {
+			struct fwnode_handle	*fwnode;
+			struct irq_domain	*sgi_domain;
 			struct {
 				u8	priority;
 				bool	enabled;
