Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55830C2D0EB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3586F20B80
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgC2U0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:26:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56899 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbgC2U0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:11 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIeVS-0001J9-BL; Sun, 29 Mar 2020 22:26:06 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A32D21C0334;
        Sun, 29 Mar 2020 22:26:05 +0200 (CEST)
Date:   Sun, 29 Mar 2020 20:26:05 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v4.1: Eagerly vmap vPEs
Cc:     Marc Zyngier <maz@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200304203330.4967-17-maz@kernel.org>
References: <20200304203330.4967-17-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <158551356520.28353.14747325681195848536.tip-bot2@tip-bot2>
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

Commit-ID:     009384b38034111bf2c0c7bfb2740f5bd45c176c
Gitweb:        https://git.kernel.org/tip/009384b38034111bf2c0c7bfb2740f5bd45c176c
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 04 Mar 2020 20:33:23 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 24 Mar 2020 12:15:51 

irqchip/gic-v4.1: Eagerly vmap vPEs

Now that we have HW-accelerated SGIs being delivered to VPEs, it
becomes required to map the VPEs on all ITSs instead of relying
on the lazy approach that we would use when using the ITS-list
mechanism.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Link: https://lore.kernel.org/r/20200304203330.4967-17-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c | 52 +++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index aae5332..1259f7f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -189,6 +189,15 @@ static DEFINE_IDA(its_vpeid_ida);
 #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
 #define gic_data_rdist_vlpi_base()	(gic_data_rdist_rd_base() + SZ_128K)
 
+/*
+ * Skip ITSs that have no vLPIs mapped, unless we're on GICv4.1, as we
+ * always have vSGIs mapped.
+ */
+static bool require_its_list_vmovp(struct its_vm *vm, struct its_node *its)
+{
+	return (gic_rdists->has_rvpeid || vm->vlpi_count[its->list_nr]);
+}
+
 static u16 get_its_list(struct its_vm *vm)
 {
 	struct its_node *its;
@@ -198,7 +207,7 @@ static u16 get_its_list(struct its_vm *vm)
 		if (!is_v4(its))
 			continue;
 
-		if (vm->vlpi_count[its->list_nr])
+		if (require_its_list_vmovp(vm, its))
 			__set_bit(its->list_nr, &its_list);
 	}
 
@@ -1295,7 +1304,7 @@ static void its_send_vmovp(struct its_vpe *vpe)
 		if (!is_v4(its))
 			continue;
 
-		if (!vpe->its_vm->vlpi_count[its->list_nr])
+		if (!require_its_list_vmovp(vpe->its_vm, its))
 			continue;
 
 		desc.its_vmovp_cmd.col = &its->collections[col_id];
@@ -1586,12 +1595,31 @@ static int its_irq_set_irqchip_state(struct irq_data *d,
 	return 0;
 }
 
+/*
+ * Two favourable cases:
+ *
+ * (a) Either we have a GICv4.1, and all vPEs have to be mapped at all times
+ *     for vSGI delivery
+ *
+ * (b) Or the ITSs do not use a list map, meaning that VMOVP is cheap enough
+ *     and we're better off mapping all VPEs always
+ *
+ * If neither (a) nor (b) is true, then we map vPEs on demand.
+ *
+ */
+static bool gic_requires_eager_mapping(void)
+{
+	if (!its_list_map || gic_rdists->has_rvpeid)
+		return true;
+
+	return false;
+}
+
 static void its_map_vm(struct its_node *its, struct its_vm *vm)
 {
 	unsigned long flags;
 
-	/* Not using the ITS list? Everything is always mapped. */
-	if (!its_list_map)
+	if (gic_requires_eager_mapping())
 		return;
 
 	raw_spin_lock_irqsave(&vmovp_lock, flags);
@@ -1625,7 +1653,7 @@ static void its_unmap_vm(struct its_node *its, struct its_vm *vm)
 	unsigned long flags;
 
 	/* Not using the ITS list? Everything is always mapped. */
-	if (!its_list_map)
+	if (gic_requires_eager_mapping())
 		return;
 
 	raw_spin_lock_irqsave(&vmovp_lock, flags);
@@ -4282,8 +4310,12 @@ static int its_vpe_irq_domain_activate(struct irq_domain *domain,
 	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
 	struct its_node *its;
 
-	/* If we use the list map, we issue VMAPP on demand... */
-	if (its_list_map)
+	/*
+	 * If we use the list map, we issue VMAPP on demand... Unless
+	 * we're on a GICv4.1 and we eagerly map the VPE on all ITSs
+	 * so that VSGIs can work.
+	 */
+	if (!gic_requires_eager_mapping())
 		return 0;
 
 	/* Map the VPE to the first possible CPU */
@@ -4309,10 +4341,10 @@ static void its_vpe_irq_domain_deactivate(struct irq_domain *domain,
 	struct its_node *its;
 
 	/*
-	 * If we use the list map, we unmap the VPE once no VLPIs are
-	 * associated with the VM.
+	 * If we use the list map on GICv4.0, we unmap the VPE once no
+	 * VLPIs are associated with the VM.
 	 */
-	if (its_list_map)
+	if (!gic_requires_eager_mapping())
 		return;
 
 	list_for_each_entry(its, &its_nodes, entry) {
