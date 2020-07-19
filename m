Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C33C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 13:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6CC12080D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 13:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fXIxVDVC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g1hmJ0Mc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgGSNTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 09:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSNTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 09:19:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE39C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 06:19:05 -0700 (PDT)
Date:   Sun, 19 Jul 2020 13:18:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595164743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zqdGyXBIrLEbZePTQIbct+RaSA/vuiwkN2wt6l1D3fg=;
        b=fXIxVDVC2KnI95ui9bE+Ql0cXNtGcaZb0HzMPUnsZUm6tsOWpMQkpNFkCJfS6VJKggXPT+
        Z6OeGmQA4knukMgc/+EPNuJiS5C7YEN+xOzz9/rTMeVlKalj1cezLfIZkdgZYSbYoJ0jlT
        QNSj0IZpYanIWzvYv+VgkPUZSx0X+fSco/ldt0FHLazT2LKQgSw2suP3iFZ+swWjCkZaOE
        4kPHKP7E/tpfBHC5DMSwFtEHi+7Lk2MGvXrBMA/qWe5iBNqcj5Qq2ztsX/huhlosNDxkmj
        PLselL95ie8EOaAkeDtD8TPsDJT3ZLbUGvKlhppdmURTx4eWX1El1DCBVryGPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595164743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zqdGyXBIrLEbZePTQIbct+RaSA/vuiwkN2wt6l1D3fg=;
        b=g1hmJ0McGZUlcyqH20IzdTFsM1yQmHOCXiFjehwtMbEGJ4CxiWOw0M1Ztg4gO2j+yz/gIt
        PIoTH3vbK09JD4BA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for v5.8-rc6
Message-ID: <159516469014.4147.6471285397574034610.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-07-19

up to:  baedb87d1b53: genirq/affinity: Handle affinity setting on inactive interrupts correctly

Two fixes for the interrupt subsystem:

 - Make the handling of the firmware node consistent and do not free the
   node after the domain has been created successfully. The core code
   stores a pointer to it which can lead to a use after free or double
   free.

   This used to "work" because the pointer was not stored when the initial
   code was written, but at some point later it was required to store
   it. Of course nobody noticed that the existing users break that way.

 - Handle affinity setting on inactive interrupts correctly when
   hierarchical irq domains are enabled. When interrupts are inactive with
   the modern hierarchical irqdomain design, the interrupt chips are not
   necessarily in a state where affinity changes can be handled. The legacy
   irq chip design allowed this because interrupts are immediately fully
   initialized at allocation time. X86 has a hacky workaround for this, but
   other implementations do not. This cased malfunction on GIC-V3. Instead
   of playing whack a mole to find all affected drivers, change the core
   code to store the requested affinity setting and then establish it when
   the interrupt is allocated, which makes the X86 hack go away.

Thanks,

	tglx

------------------>
Thomas Gleixner (2):
      irqdomain/treewide: Keep firmware node unconditionally allocated
      genirq/affinity: Handle affinity setting on inactive interrupts correctly


 arch/mips/pci/pci-xtalk-bridge.c    |  5 +++--
 arch/x86/kernel/apic/io_apic.c      | 10 +++++-----
 arch/x86/kernel/apic/msi.c          | 18 ++++++++++++------
 arch/x86/kernel/apic/vector.c       | 23 +++++------------------
 arch/x86/platform/uv/uv_irq.c       |  3 ++-
 drivers/iommu/amd/iommu.c           |  5 +++--
 drivers/iommu/hyperv-iommu.c        |  5 ++++-
 drivers/iommu/intel/irq_remapping.c |  2 +-
 drivers/mfd/ioc3.c                  |  5 +++--
 drivers/pci/controller/vmd.c        |  5 +++--
 kernel/irq/manage.c                 | 37 +++++++++++++++++++++++++++++++++++--
 11 files changed, 76 insertions(+), 42 deletions(-)

diff --git a/arch/mips/pci/pci-xtalk-bridge.c b/arch/mips/pci/pci-xtalk-bridge.c
index 3b2552fb7735..5958217861b8 100644
--- a/arch/mips/pci/pci-xtalk-bridge.c
+++ b/arch/mips/pci/pci-xtalk-bridge.c
@@ -627,9 +627,10 @@ static int bridge_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	domain = irq_domain_create_hierarchy(parent, 0, 8, fn,
 					     &bridge_domain_ops, NULL);
-	irq_domain_free_fwnode(fn);
-	if (!domain)
+	if (!domain) {
+		irq_domain_free_fwnode(fn);
 		return -ENOMEM;
+	}
 
 	pci_set_flags(PCI_PROBE_ONLY);
 
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index ce61e3e7d399..81ffcfbfaef2 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2316,12 +2316,12 @@ static int mp_irqdomain_create(int ioapic)
 	ip->irqdomain = irq_domain_create_linear(fn, hwirqs, cfg->ops,
 						 (void *)(long)ioapic);
 
-	/* Release fw handle if it was allocated above */
-	if (!cfg->dev)
-		irq_domain_free_fwnode(fn);
-
-	if (!ip->irqdomain)
+	if (!ip->irqdomain) {
+		/* Release fw handle if it was allocated above */
+		if (!cfg->dev)
+			irq_domain_free_fwnode(fn);
 		return -ENOMEM;
+	}
 
 	ip->irqdomain->parent = parent;
 
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 5cbaca58af95..c2b2911feeef 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -263,12 +263,13 @@ void __init arch_init_msi_domain(struct irq_domain *parent)
 		msi_default_domain =
 			pci_msi_create_irq_domain(fn, &pci_msi_domain_info,
 						  parent);
-		irq_domain_free_fwnode(fn);
 	}
-	if (!msi_default_domain)
+	if (!msi_default_domain) {
+		irq_domain_free_fwnode(fn);
 		pr_warn("failed to initialize irqdomain for MSI/MSI-x.\n");
-	else
+	} else {
 		msi_default_domain->flags |= IRQ_DOMAIN_MSI_NOMASK_QUIRK;
+	}
 }
 
 #ifdef CONFIG_IRQ_REMAP
@@ -301,7 +302,8 @@ struct irq_domain *arch_create_remap_msi_irq_domain(struct irq_domain *parent,
 	if (!fn)
 		return NULL;
 	d = pci_msi_create_irq_domain(fn, &pci_msi_ir_domain_info, parent);
-	irq_domain_free_fwnode(fn);
+	if (!d)
+		irq_domain_free_fwnode(fn);
 	return d;
 }
 #endif
@@ -364,7 +366,8 @@ static struct irq_domain *dmar_get_irq_domain(void)
 	if (fn) {
 		dmar_domain = msi_create_irq_domain(fn, &dmar_msi_domain_info,
 						    x86_vector_domain);
-		irq_domain_free_fwnode(fn);
+		if (!dmar_domain)
+			irq_domain_free_fwnode(fn);
 	}
 out:
 	mutex_unlock(&dmar_lock);
@@ -489,7 +492,10 @@ struct irq_domain *hpet_create_irq_domain(int hpet_id)
 	}
 
 	d = msi_create_irq_domain(fn, domain_info, parent);
-	irq_domain_free_fwnode(fn);
+	if (!d) {
+		irq_domain_free_fwnode(fn);
+		kfree(domain_info);
+	}
 	return d;
 }
 
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index c48be6e1f676..7649da2478d8 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -446,12 +446,10 @@ static int x86_vector_activate(struct irq_domain *dom, struct irq_data *irqd,
 	trace_vector_activate(irqd->irq, apicd->is_managed,
 			      apicd->can_reserve, reserve);
 
-	/* Nothing to do for fixed assigned vectors */
-	if (!apicd->can_reserve && !apicd->is_managed)
-		return 0;
-
 	raw_spin_lock_irqsave(&vector_lock, flags);
-	if (reserve || irqd_is_managed_and_shutdown(irqd))
+	if (!apicd->can_reserve && !apicd->is_managed)
+		assign_irq_vector_any_locked(irqd);
+	else if (reserve || irqd_is_managed_and_shutdown(irqd))
 		vector_assign_managed_shutdown(irqd);
 	else if (apicd->is_managed)
 		ret = activate_managed(irqd);
@@ -709,7 +707,6 @@ int __init arch_early_irq_init(void)
 	x86_vector_domain = irq_domain_create_tree(fn, &x86_vector_domain_ops,
 						   NULL);
 	BUG_ON(x86_vector_domain == NULL);
-	irq_domain_free_fwnode(fn);
 	irq_set_default_host(x86_vector_domain);
 
 	arch_init_msi_domain(x86_vector_domain);
@@ -775,20 +772,10 @@ void lapic_offline(void)
 static int apic_set_affinity(struct irq_data *irqd,
 			     const struct cpumask *dest, bool force)
 {
-	struct apic_chip_data *apicd = apic_chip_data(irqd);
 	int err;
 
-	/*
-	 * Core code can call here for inactive interrupts. For inactive
-	 * interrupts which use managed or reservation mode there is no
-	 * point in going through the vector assignment right now as the
-	 * activation will assign a vector which fits the destination
-	 * cpumask. Let the core code store the destination mask and be
-	 * done with it.
-	 */
-	if (!irqd_is_activated(irqd) &&
-	    (apicd->is_managed || apicd->can_reserve))
-		return IRQ_SET_MASK_OK;
+	if (WARN_ON_ONCE(!irqd_is_activated(irqd)))
+		return -EIO;
 
 	raw_spin_lock(&vector_lock);
 	cpumask_and(vector_searchmask, dest, cpu_online_mask);
diff --git a/arch/x86/platform/uv/uv_irq.c b/arch/x86/platform/uv/uv_irq.c
index fc13cbbb2dce..abb6075397f0 100644
--- a/arch/x86/platform/uv/uv_irq.c
+++ b/arch/x86/platform/uv/uv_irq.c
@@ -167,9 +167,10 @@ static struct irq_domain *uv_get_irq_domain(void)
 		goto out;
 
 	uv_domain = irq_domain_create_tree(fn, &uv_domain_ops, NULL);
-	irq_domain_free_fwnode(fn);
 	if (uv_domain)
 		uv_domain->parent = x86_vector_domain;
+	else
+		irq_domain_free_fwnode(fn);
 out:
 	mutex_unlock(&uv_lock);
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 74cca1757172..2f22326ee4df 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3985,9 +3985,10 @@ int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
 	if (!fn)
 		return -ENOMEM;
 	iommu->ir_domain = irq_domain_create_tree(fn, &amd_ir_domain_ops, iommu);
-	irq_domain_free_fwnode(fn);
-	if (!iommu->ir_domain)
+	if (!iommu->ir_domain) {
+		irq_domain_free_fwnode(fn);
 		return -ENOMEM;
+	}
 
 	iommu->ir_domain->parent = arch_get_ir_parent_domain();
 	iommu->msi_domain = arch_create_remap_msi_irq_domain(iommu->ir_domain,
diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index 3c0c67a99c7b..8919c1c70b68 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -155,7 +155,10 @@ static int __init hyperv_prepare_irq_remapping(void)
 				0, IOAPIC_REMAPPING_ENTRY, fn,
 				&hyperv_ir_domain_ops, NULL);
 
-	irq_domain_free_fwnode(fn);
+	if (!ioapic_ir_domain) {
+		irq_domain_free_fwnode(fn);
+		return -ENOMEM;
+	}
 
 	/*
 	 * Hyper-V doesn't provide irq remapping function for
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 7f8769800815..9564d23d094f 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -563,8 +563,8 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 					    0, INTR_REMAP_TABLE_ENTRIES,
 					    fn, &intel_ir_domain_ops,
 					    iommu);
-	irq_domain_free_fwnode(fn);
 	if (!iommu->ir_domain) {
+		irq_domain_free_fwnode(fn);
 		pr_err("IR%d: failed to allocate irqdomain\n", iommu->seq_id);
 		goto out_free_bitmap;
 	}
diff --git a/drivers/mfd/ioc3.c b/drivers/mfd/ioc3.c
index 02998d4eb74b..74cee7cb0afc 100644
--- a/drivers/mfd/ioc3.c
+++ b/drivers/mfd/ioc3.c
@@ -142,10 +142,11 @@ static int ioc3_irq_domain_setup(struct ioc3_priv_data *ipd, int irq)
 		goto err;
 
 	domain = irq_domain_create_linear(fn, 24, &ioc3_irq_domain_ops, ipd);
-	if (!domain)
+	if (!domain) {
+		irq_domain_free_fwnode(fn);
 		goto err;
+	}
 
-	irq_domain_free_fwnode(fn);
 	ipd->domain = domain;
 
 	irq_set_chained_handler_and_data(irq, ioc3_irq_handler, domain);
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index e386d4eac407..9a64cf90c291 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -546,9 +546,10 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
 	vmd->irq_domain = pci_msi_create_irq_domain(fn, &vmd_msi_domain_info,
 						    x86_vector_domain);
-	irq_domain_free_fwnode(fn);
-	if (!vmd->irq_domain)
+	if (!vmd->irq_domain) {
+		irq_domain_free_fwnode(fn);
 		return -ENODEV;
+	}
 
 	pci_add_resource(&resources, &vmd->resources[0]);
 	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 761911168438..2a9fec53e159 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -195,9 +195,9 @@ void irq_set_thread_affinity(struct irq_desc *desc)
 			set_bit(IRQTF_AFFINITY, &action->thread_flags);
 }
 
+#ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
 static void irq_validate_effective_affinity(struct irq_data *data)
 {
-#ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
 	const struct cpumask *m = irq_data_get_effective_affinity_mask(data);
 	struct irq_chip *chip = irq_data_get_irq_chip(data);
 
@@ -205,9 +205,19 @@ static void irq_validate_effective_affinity(struct irq_data *data)
 		return;
 	pr_warn_once("irq_chip %s did not update eff. affinity mask of irq %u\n",
 		     chip->name, data->irq);
-#endif
 }
 
+static inline void irq_init_effective_affinity(struct irq_data *data,
+					       const struct cpumask *mask)
+{
+	cpumask_copy(irq_data_get_effective_affinity_mask(data), mask);
+}
+#else
+static inline void irq_validate_effective_affinity(struct irq_data *data) { }
+static inline void irq_init_effective_affinity(struct irq_data *data,
+					       const struct cpumask *mask) { }
+#endif
+
 int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 			bool force)
 {
@@ -304,6 +314,26 @@ static int irq_try_set_affinity(struct irq_data *data,
 	return ret;
 }
 
+static bool irq_set_affinity_deactivated(struct irq_data *data,
+					 const struct cpumask *mask, bool force)
+{
+	struct irq_desc *desc = irq_data_to_desc(data);
+
+	/*
+	 * If the interrupt is not yet activated, just store the affinity
+	 * mask and do not call the chip driver at all. On activation the
+	 * driver has to make sure anyway that the interrupt is in a
+	 * useable state so startup works.
+	 */
+	if (!IS_ENABLED(CONFIG_IRQ_DOMAIN_HIERARCHY) || irqd_is_activated(data))
+		return false;
+
+	cpumask_copy(desc->irq_common_data.affinity, mask);
+	irq_init_effective_affinity(data, mask);
+	irqd_set(data, IRQD_AFFINITY_SET);
+	return true;
+}
+
 int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
 			    bool force)
 {
@@ -314,6 +344,9 @@ int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
 	if (!chip || !chip->irq_set_affinity)
 		return -EINVAL;
 
+	if (irq_set_affinity_deactivated(data, mask, force))
+		return 0;
+
 	if (irq_can_move_pcntxt(data) && !irqd_is_setaffinity_pending(data)) {
 		ret = irq_try_set_affinity(data, mask, force);
 	} else {

