Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AF3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 317D822CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgHEUZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:25:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:32779 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbgHEUZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 16:25:14 -0400
IronPort-SDR: G6+dO4kpxug0mYeI2KplAKvena/nnF/+AMrR4zjDepCdkP8bKqWQl7xsJGnT1iNAvwjg2rwFYM
 8QT9SF/1RNww==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="214171514"
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="214171514"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 13:25:13 -0700
IronPort-SDR: p2TYnDiDjOO0kDKJiHYPIC2vqtClXY1/NFqI9yvVfhiZ9FiHGseJHHMTmiiTeSQa7aHaoJYxIH
 yhueZNxSilpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="332958450"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by orsmga007.jf.intel.com with ESMTP; 05 Aug 2020 13:25:13 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 5/6] perf/x86/intel/uncore: Generic support for the PCI sub driver
Date:   Wed,  5 Aug 2020 13:24:10 -0700
Message-Id: <1596659051-95759-6-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596659051-95759-1-git-send-email-kan.liang@linux.intel.com>
References: <1596659051-95759-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Some uncore counters may be located in the configuration space of a PCI
device, which already has a bonded driver. Currently, the uncore driver
cannot register a PCI uncore PMU for these counters, because, to
register a PCI uncore PMU, the uncore driver must be bond to the device.
However, one device can only have one bonded driver.

Add an uncore PCI sub driver to support such kind of devices.

The sub driver doesn't own the device. In initialization, the sub
driver searches the device via pci_get_device(), and register the
corresponding PMU for the device. In the meantime, the sub driver
registeris a PCI bus notifier, which is used to notify the sub driver
once the device is removed. The sub driver can unregister the PMU
accordingly.

The sub driver only searches the devices defined in its id table. The
id table varies on different platforms, which will be implemented in the
following platform-specific patch.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 81 ++++++++++++++++++++++++++++++++++++++++++
 arch/x86/events/intel/uncore.h |  1 +
 2 files changed, 82 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 428a2c0..9283478 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -12,6 +12,8 @@ struct intel_uncore_type **uncore_mmio_uncores = empty_uncore;
 
 static bool pcidrv_registered;
 struct pci_driver *uncore_pci_driver;
+/* The PCI driver for the device which the uncore doesn't own. */
+struct pci_driver *uncore_pci_sub_driver;
 /* pci bus to socket mapping */
 DEFINE_RAW_SPINLOCK(pci2phy_map_lock);
 struct list_head pci2phy_map_head = LIST_HEAD_INIT(pci2phy_map_head);
@@ -1186,6 +1188,80 @@ static void uncore_pci_remove(struct pci_dev *pdev)
 	uncore_pci_pmu_unregister(pmu, phys_id, die);
 }
 
+static int uncore_bus_notify(struct notifier_block *nb,
+			     unsigned long action, void *data)
+{
+	struct device *dev = data;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct intel_uncore_pmu *pmu;
+	int phys_id, die;
+
+	/* Unregister the PMU when the device is going to be deleted. */
+	if (action != BUS_NOTIFY_DEL_DEVICE)
+		return NOTIFY_DONE;
+
+	pmu = uncore_pci_find_dev_pmu(pdev, uncore_pci_sub_driver->id_table);
+	if (!pmu)
+		return NOTIFY_DONE;
+
+	if (uncore_pci_get_dev_die_info(pdev, &phys_id, &die))
+		return NOTIFY_DONE;
+
+	uncore_pci_pmu_unregister(pmu, phys_id, die);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block uncore_notifier = {
+	.notifier_call = uncore_bus_notify,
+};
+
+static void uncore_pci_sub_driver_init(void)
+{
+	const struct pci_device_id *ids = uncore_pci_sub_driver->id_table;
+	struct intel_uncore_type *type;
+	struct intel_uncore_pmu *pmu;
+	struct pci_dev *pci_sub_dev;
+	bool notify = false;
+	unsigned int devfn;
+	int phys_id, die;
+
+	while (ids && ids->vendor) {
+		pci_sub_dev = NULL;
+		type = uncore_pci_uncores[UNCORE_PCI_DEV_TYPE(ids->driver_data)];
+		/*
+		 * Search the available device, and register the
+		 * corresponding PMU.
+		 */
+		while ((pci_sub_dev = pci_get_device(PCI_VENDOR_ID_INTEL,
+						     ids->device, pci_sub_dev))) {
+			devfn = PCI_DEVFN(UNCORE_PCI_DEV_DEV(ids->driver_data),
+					  UNCORE_PCI_DEV_FUNC(ids->driver_data));
+			if (devfn != pci_sub_dev->devfn)
+				continue;
+
+			pmu = &type->pmus[UNCORE_PCI_DEV_IDX(ids->driver_data)];
+			if (!pmu)
+				continue;
+
+			if (uncore_pci_get_dev_die_info(pci_sub_dev,
+							&phys_id, &die))
+				continue;
+
+			if (!uncore_pci_pmu_register(pci_sub_dev, type, pmu,
+						     phys_id, die))
+				notify = true;
+		}
+		ids++;
+	}
+
+	if (notify && bus_register_notifier(&pci_bus_type, &uncore_notifier))
+		notify = false;
+
+	if (!notify)
+		uncore_pci_sub_driver = NULL;
+}
+
 static int __init uncore_pci_init(void)
 {
 	size_t size;
@@ -1209,6 +1285,9 @@ static int __init uncore_pci_init(void)
 	if (ret)
 		goto errtype;
 
+	if (uncore_pci_sub_driver)
+		uncore_pci_sub_driver_init();
+
 	pcidrv_registered = true;
 	return 0;
 
@@ -1226,6 +1305,8 @@ static void uncore_pci_exit(void)
 {
 	if (pcidrv_registered) {
 		pcidrv_registered = false;
+		if (uncore_pci_sub_driver)
+			bus_unregister_notifier(&pci_bus_type, &uncore_notifier);
 		pci_unregister_driver(uncore_pci_driver);
 		uncore_types_exit(uncore_pci_uncores);
 		kfree(uncore_extra_pci_dev);
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 105fdc6..df544bc 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -552,6 +552,7 @@ extern struct intel_uncore_type **uncore_msr_uncores;
 extern struct intel_uncore_type **uncore_pci_uncores;
 extern struct intel_uncore_type **uncore_mmio_uncores;
 extern struct pci_driver *uncore_pci_driver;
+extern struct pci_driver *uncore_pci_sub_driver;
 extern raw_spinlock_t pci2phy_map_lock;
 extern struct list_head pci2phy_map_head;
 extern struct pci_extra_dev *uncore_extra_pci_dev;
-- 
2.7.4

