Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCC2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F9632064B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596452083;
	bh=ptwfdEZgI52uS+lmTVaIrEazWANiJwf/40ewHjXhcDQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=EayvxILmnXB5KD/DqFZ7MFg4uoH0488PWC1JkHd+aGu6pqIeaLvOcWhvixcCX6iJh
	 YBxQJ6Go8TYKbTN1hcE1yft0Br4guvoz2QG5/27RYNrytvQ32lPJ4NE1t5dEYD00l7
	 Ik/15tQr8VVNwDHwCMpdkSkPIcWlNZEHUhE4EHHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgHCKym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 06:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgHCKyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:54:24 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF708C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 03:54:23 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id jp10so11568191ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 03:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Z9QbVFpXqwAb9Ypi6Xs0ttGN7V6v63aCSESVP6OgPnE=;
        b=RrshzR+nZ4BX06IN0a33MP8UDEDE0WCKWtffVyvOU8cceI1D64MTvKPXzFdIq8T/0D
         J0ZkLAcgxEPTprOxCRyFcFHA22LaiAioku9XczsKtfZwUDvGalGx2VBm4bWPjTqfhLPu
         cU3QEC0r+PI782JOSAaiRFGMPJ0wXWXTQXwxbSlEVPVc0FcI71lohdWWfCWrMZeDAyg0
         wT0eagvaHGDh0wQZY/hv4qcudpvMqXvAQnzrt8K4v/RV9JHmZ43rZpl/Bqd3KuVp6Db9
         5o7jr+Mc2xivsumnL2mfr87WBvCozWLuXnWrSnbAHjWY/EsOYyqFhzVWT8Bi7L2Sdtxp
         JZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=Z9QbVFpXqwAb9Ypi6Xs0ttGN7V6v63aCSESVP6OgPnE=;
        b=f7/xvG7VgLVKJesSyDrGNb6OD6gzNGMCh20M4vWOT2HLjboqZC0bxbBrLvefm8eUb5
         F0I0aDCBe6H0ym2D9QiAtR1+PJPXIoZe7YCeukysIpTP3OhKjJMrHOzXLdJgy+dRRPS9
         yiinpUS9r0sk7C0mTsE99S7ZRMByuxgiCPM5Idl8RrIzWBkYDctDJkSBeyliHlSjumO6
         RQqhqYVZHaWCfQXXRNRRB7VzUaLF83d4iuW00rsAoqaOLa6M97X73Fgd1CTcJmcgH4AY
         CAw1VRNlmuM2tqgF0idLW0w5H2fk3n9YN+bL9qdrCl17U2o7V/6ee9zAQrIRReFUkuV9
         qtgg==
X-Gm-Message-State: AOAM533EKBOBFyGf0bkV9xBtWMorSJlX6tYyrIMO4Ks5kmZYzIs74Nal
        v/4MHA+a2NIX7AHaVTJd3a4=
X-Google-Smtp-Source: ABdhPJxLUr/0vtEM4NmqjccF1VqNLJ6dsxqDhv4idoYT1aMYSQ25KFiEBbTr3wU2y6EyHgUa7P7NZg==
X-Received: by 2002:a17:906:7e06:: with SMTP id e6mr16815154ejr.236.1596452062520;
        Mon, 03 Aug 2020 03:54:22 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id s16sm15430033ejr.31.2020.08.03.03.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 03:54:21 -0700 (PDT)
Date:   Mon, 3 Aug 2020 12:54:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] IRQ fixes
Message-ID: <20200803105419.GA256986@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest irq/urgent fixes left over from the v5.8 cycle from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-08-02

   # HEAD: aa251fc5b936d3ddb4b4c4b36427eb9aa3347c82 genirq/debugfs: Add missing irqchip flags

Fix a recent IRQ affinities regression, add in a missing debugfs 
printout that helps the debugging of IRQ affinity logic bugs, and fix 
a memory leak.

 Thanks,

	Ingo

------------------>
Jon Derrick (1):
      irqdomain/treewide: Free firmware node after domain removal

Marc Zyngier (1):
      genirq/debugfs: Add missing irqchip flags

Thomas Gleixner (1):
      genirq/affinity: Make affinity setting if activated opt-in


 arch/mips/pci/pci-xtalk-bridge.c    |  3 +++
 arch/x86/kernel/apic/io_apic.c      |  5 +++++
 arch/x86/kernel/apic/vector.c       |  4 ++++
 drivers/iommu/intel/irq_remapping.c |  8 ++++++++
 drivers/irqchip/irq-gic-v3-its.c    |  5 ++++-
 drivers/mfd/ioc3.c                  |  6 ++++++
 drivers/pci/controller/vmd.c        |  3 +++
 include/linux/irq.h                 | 13 +++++++++++++
 kernel/irq/debugfs.c                |  5 +++++
 kernel/irq/manage.c                 |  6 +++++-
 10 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pci/pci-xtalk-bridge.c b/arch/mips/pci/pci-xtalk-bridge.c
index 5958217861b8..9b3cc775c55e 100644
--- a/arch/mips/pci/pci-xtalk-bridge.c
+++ b/arch/mips/pci/pci-xtalk-bridge.c
@@ -728,6 +728,7 @@ static int bridge_probe(struct platform_device *pdev)
 	pci_free_resource_list(&host->windows);
 err_remove_domain:
 	irq_domain_remove(domain);
+	irq_domain_free_fwnode(fn);
 	return err;
 }
 
@@ -735,8 +736,10 @@ static int bridge_remove(struct platform_device *pdev)
 {
 	struct pci_bus *bus = platform_get_drvdata(pdev);
 	struct bridge_controller *bc = BRIDGE_CONTROLLER(bus);
+	struct fwnode_handle *fn = bc->domain->fwnode;
 
 	irq_domain_remove(bc->domain);
+	irq_domain_free_fwnode(fn);
 	pci_lock_rescan_remove();
 	pci_stop_root_bus(bus);
 	pci_remove_root_bus(bus);
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 81ffcfbfaef2..21325a4a78b9 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2335,8 +2335,13 @@ static int mp_irqdomain_create(int ioapic)
 
 static void ioapic_destroy_irqdomain(int idx)
 {
+	struct ioapic_domain_cfg *cfg = &ioapics[idx].irqdomain_cfg;
+	struct fwnode_handle *fn = ioapics[idx].irqdomain->fwnode;
+
 	if (ioapics[idx].irqdomain) {
 		irq_domain_remove(ioapics[idx].irqdomain);
+		if (!cfg->dev)
+			irq_domain_free_fwnode(fn);
 		ioapics[idx].irqdomain = NULL;
 	}
 }
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 7649da2478d8..dae32d948bf2 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -560,6 +560,10 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 		 * as that can corrupt the affinity move state.
 		 */
 		irqd_set_handle_enforce_irqctx(irqd);
+
+		/* Don't invoke affinity setter on deactivated interrupts */
+		irqd_set_affinity_on_activate(irqd);
+
 		/*
 		 * Legacy vectors are already assigned when the IOAPIC
 		 * takes them over. They stay on the same vector. This is
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 9564d23d094f..aa096b333a99 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -628,13 +628,21 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 
 static void intel_teardown_irq_remapping(struct intel_iommu *iommu)
 {
+	struct fwnode_handle *fn;
+
 	if (iommu && iommu->ir_table) {
 		if (iommu->ir_msi_domain) {
+			fn = iommu->ir_msi_domain->fwnode;
+
 			irq_domain_remove(iommu->ir_msi_domain);
+			irq_domain_free_fwnode(fn);
 			iommu->ir_msi_domain = NULL;
 		}
 		if (iommu->ir_domain) {
+			fn = iommu->ir_domain->fwnode;
+
 			irq_domain_remove(iommu->ir_domain);
+			irq_domain_free_fwnode(fn);
 			iommu->ir_domain = NULL;
 		}
 		free_pages((unsigned long)iommu->ir_table->base,
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index beac4caefad9..103d850b5595 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3523,6 +3523,7 @@ static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	msi_alloc_info_t *info = args;
 	struct its_device *its_dev = info->scratchpad[0].ptr;
 	struct its_node *its = its_dev->its;
+	struct irq_data *irqd;
 	irq_hw_number_t hwirq;
 	int err;
 	int i;
@@ -3542,7 +3543,9 @@ static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 		irq_domain_set_hwirq_and_chip(domain, virq + i,
 					      hwirq + i, &its_irq_chip, its_dev);
-		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(virq + i)));
+		irqd = irq_get_irq_data(virq + i);
+		irqd_set_single_target(irqd);
+		irqd_set_affinity_on_activate(irqd);
 		pr_debug("ID:%d pID:%d vID:%d\n",
 			 (int)(hwirq + i - its_dev->event_map.lpi_base),
 			 (int)(hwirq + i), virq + i);
diff --git a/drivers/mfd/ioc3.c b/drivers/mfd/ioc3.c
index 74cee7cb0afc..d939ccc46509 100644
--- a/drivers/mfd/ioc3.c
+++ b/drivers/mfd/ioc3.c
@@ -616,7 +616,10 @@ static int ioc3_mfd_probe(struct pci_dev *pdev,
 		/* Remove all already added MFD devices */
 		mfd_remove_devices(&ipd->pdev->dev);
 		if (ipd->domain) {
+			struct fwnode_handle *fn = ipd->domain->fwnode;
+
 			irq_domain_remove(ipd->domain);
+			irq_domain_free_fwnode(fn);
 			free_irq(ipd->domain_irq, (void *)ipd);
 		}
 		pci_iounmap(pdev, regs);
@@ -643,7 +646,10 @@ static void ioc3_mfd_remove(struct pci_dev *pdev)
 	/* Release resources */
 	mfd_remove_devices(&ipd->pdev->dev);
 	if (ipd->domain) {
+		struct fwnode_handle *fn = ipd->domain->fwnode;
+
 		irq_domain_remove(ipd->domain);
+		irq_domain_free_fwnode(fn);
 		free_irq(ipd->domain_irq, (void *)ipd);
 	}
 	pci_iounmap(pdev, ipd->regs);
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 9a64cf90c291..ebec0a6e77ed 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -560,6 +560,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	if (!vmd->bus) {
 		pci_free_resource_list(&resources);
 		irq_domain_remove(vmd->irq_domain);
+		irq_domain_free_fwnode(fn);
 		return -ENODEV;
 	}
 
@@ -673,6 +674,7 @@ static void vmd_cleanup_srcu(struct vmd_dev *vmd)
 static void vmd_remove(struct pci_dev *dev)
 {
 	struct vmd_dev *vmd = pci_get_drvdata(dev);
+	struct fwnode_handle *fn = vmd->irq_domain->fwnode;
 
 	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
 	pci_stop_root_bus(vmd->bus);
@@ -680,6 +682,7 @@ static void vmd_remove(struct pci_dev *dev)
 	vmd_cleanup_srcu(vmd);
 	vmd_detach_resources(vmd);
 	irq_domain_remove(vmd->irq_domain);
+	irq_domain_free_fwnode(fn);
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 8d5bc2c237d7..1b7f4dfee35b 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -213,6 +213,8 @@ struct irq_data {
  *				  required
  * IRQD_HANDLE_ENFORCE_IRQCTX	- Enforce that handle_irq_*() is only invoked
  *				  from actual interrupt context.
+ * IRQD_AFFINITY_ON_ACTIVATE	- Affinity is set on activation. Don't call
+ *				  irq_chip::irq_set_affinity() when deactivated.
  */
 enum {
 	IRQD_TRIGGER_MASK		= 0xf,
@@ -237,6 +239,7 @@ enum {
 	IRQD_CAN_RESERVE		= (1 << 26),
 	IRQD_MSI_NOMASK_QUIRK		= (1 << 27),
 	IRQD_HANDLE_ENFORCE_IRQCTX	= (1 << 28),
+	IRQD_AFFINITY_ON_ACTIVATE	= (1 << 29),
 };
 
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
@@ -421,6 +424,16 @@ static inline bool irqd_msi_nomask_quirk(struct irq_data *d)
 	return __irqd_to_state(d) & IRQD_MSI_NOMASK_QUIRK;
 }
 
+static inline void irqd_set_affinity_on_activate(struct irq_data *d)
+{
+	__irqd_to_state(d) |= IRQD_AFFINITY_ON_ACTIVATE;
+}
+
+static inline bool irqd_affinity_on_activate(struct irq_data *d)
+{
+	return __irqd_to_state(d) & IRQD_AFFINITY_ON_ACTIVATE;
+}
+
 #undef __irqd_to_state
 
 static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index 4f9f844074db..b95ff5d5f4bd 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -112,6 +112,7 @@ static const struct irq_bit_descr irqdata_states[] = {
 	BIT_MASK_DESCR(IRQD_AFFINITY_SET),
 	BIT_MASK_DESCR(IRQD_SETAFFINITY_PENDING),
 	BIT_MASK_DESCR(IRQD_AFFINITY_MANAGED),
+	BIT_MASK_DESCR(IRQD_AFFINITY_ON_ACTIVATE),
 	BIT_MASK_DESCR(IRQD_MANAGED_SHUTDOWN),
 	BIT_MASK_DESCR(IRQD_CAN_RESERVE),
 	BIT_MASK_DESCR(IRQD_MSI_NOMASK_QUIRK),
@@ -120,6 +121,10 @@ static const struct irq_bit_descr irqdata_states[] = {
 
 	BIT_MASK_DESCR(IRQD_WAKEUP_STATE),
 	BIT_MASK_DESCR(IRQD_WAKEUP_ARMED),
+
+	BIT_MASK_DESCR(IRQD_DEFAULT_TRIGGER_SET),
+
+	BIT_MASK_DESCR(IRQD_HANDLE_ENFORCE_IRQCTX),
 };
 
 static const struct irq_bit_descr irqdesc_states[] = {
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 2a9fec53e159..48c38e09c673 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -320,12 +320,16 @@ static bool irq_set_affinity_deactivated(struct irq_data *data,
 	struct irq_desc *desc = irq_data_to_desc(data);
 
 	/*
+	 * Handle irq chips which can handle affinity only in activated
+	 * state correctly
+	 *
 	 * If the interrupt is not yet activated, just store the affinity
 	 * mask and do not call the chip driver at all. On activation the
 	 * driver has to make sure anyway that the interrupt is in a
 	 * useable state so startup works.
 	 */
-	if (!IS_ENABLED(CONFIG_IRQ_DOMAIN_HIERARCHY) || irqd_is_activated(data))
+	if (!IS_ENABLED(CONFIG_IRQ_DOMAIN_HIERARCHY) ||
+	    irqd_is_activated(data) || !irqd_affinity_on_activate(data))
 		return false;
 
 	cpumask_copy(desc->irq_common_data.affinity, mask);
