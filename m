Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3036C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC4512072D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597921360;
	bh=V+lz7/siG4c9XdPPITwRwWgfq5p7uZfJ6aoge+OydFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZpUkAvvGaWoguO92+5xHIFjdycbHP25uaSFyGjP7jc1//3DdcHVRVGpQ4GOR31CzF
	 VrPTj8A0rCyLGPjePgrKA/8zmJrNJcdXeHeT4wFRdIUeeVK/sQMTGHmWLGPrPDTiFi
	 Td0TROzpOxOGPsH5N0S9eO/VOQesnJAXytJGquJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbgHTLCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:02:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731090AbgHTKNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:13:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0725F2067C;
        Thu, 20 Aug 2020 10:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918418;
        bh=V+lz7/siG4c9XdPPITwRwWgfq5p7uZfJ6aoge+OydFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EanQxAekEDMVYdb6/tdTm2NbJEnsXdKH+BtZjRI7rM7bT+gTRXLZMQcQnO4BTgc7n
         G4VR3m+ls5/wWGnw6EkwhdSmLHGofpCVijDpqlNfPYjkrSGVhT59euokmv3gUb7JXp
         Fbd6vVctzVUtcV3pWFxh+tYTcq43gqP5FhX/Jkgw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Derrick <jonathan.derrick@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4.14 163/228] irqdomain/treewide: Free firmware node after domain removal
Date:   Thu, 20 Aug 2020 11:22:18 +0200
Message-Id: <20200820091615.722537215@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Derrick <jonathan.derrick@intel.com>

commit ec0160891e387f4771f953b888b1fe951398e5d9 upstream.

Commit 711419e504eb ("irqdomain: Add the missing assignment of
domain->fwnode for named fwnode") unintentionally caused a dangling pointer
page fault issue on firmware nodes that were freed after IRQ domain
allocation. Commit e3beca48a45b fixed that dangling pointer issue by only
freeing the firmware node after an IRQ domain allocation failure. That fix
no longer frees the firmware node immediately, but leaves the firmware node
allocated after the domain is removed.

The firmware node must be kept around through irq_domain_remove, but should be
freed it afterwards.

Add the missing free operations after domain removal where where appropriate.

Fixes: e3beca48a45b ("irqdomain/treewide: Keep firmware node unconditionally allocated")
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# drivers/pci
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/1595363169-7157-1-git-send-email-jonathan.derrick@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/apic/io_apic.c      |    5 +++++
 drivers/iommu/intel_irq_remapping.c |    8 ++++++++
 drivers/pci/host/vmd.c              |    3 +++
 3 files changed, 16 insertions(+)

--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2252,8 +2252,13 @@ static int mp_irqdomain_create(int ioapi
 
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
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -601,13 +601,21 @@ out_free_table:
 
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
--- a/drivers/pci/host/vmd.c
+++ b/drivers/pci/host/vmd.c
@@ -651,6 +651,7 @@ static int vmd_enable_domain(struct vmd_
 	if (!vmd->bus) {
 		pci_free_resource_list(&resources);
 		irq_domain_remove(vmd->irq_domain);
+		irq_domain_free_fwnode(fn);
 		return -ENODEV;
 	}
 
@@ -753,6 +754,7 @@ static void vmd_cleanup_srcu(struct vmd_
 static void vmd_remove(struct pci_dev *dev)
 {
 	struct vmd_dev *vmd = pci_get_drvdata(dev);
+	struct fwnode_handle *fn = vmd->irq_domain->fwnode;
 
 	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
 	pci_stop_root_bus(vmd->bus);
@@ -761,6 +763,7 @@ static void vmd_remove(struct pci_dev *d
 	vmd_teardown_dma_ops(vmd);
 	vmd_detach_resources(vmd);
 	irq_domain_remove(vmd->irq_domain);
+	irq_domain_free_fwnode(fn);
 }
 
 #ifdef CONFIG_PM_SLEEP


