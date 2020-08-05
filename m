Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69475C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B10422CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgHEUZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:25:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:32770 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbgHEUZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 16:25:14 -0400
IronPort-SDR: 1V4cGhKT9YRrZ5z/AIsVKq9VkYk3LYV8kvX7Om1NiuE0mXPhodSrWa1HJzqr1Z3yQNifArGCDo
 pIOVXtdS0AIA==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="214171507"
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="214171507"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 13:25:11 -0700
IronPort-SDR: 5XIFxfmdCG2MgaiGEiwJEQRWDhvr0zRCGaN0TcPk8imEighTgEhbTAPHHNNVcTRGnw8oQm4i7I
 tuuBC58+ToyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="332958440"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by orsmga007.jf.intel.com with ESMTP; 05 Aug 2020 13:25:11 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 3/6] perf/x86/intel/uncore: Factor out uncore_pci_pmu_register()
Date:   Wed,  5 Aug 2020 13:24:08 -0700
Message-Id: <1596659051-95759-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596659051-95759-1-git-send-email-kan.liang@linux.intel.com>
References: <1596659051-95759-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The PMU registration in the uncore PCI sub driver is similar as the
normal PMU registration for a PCI device. The codes to register a PCI
PMU can be shared.

Factor out uncore_pci_pmu_register(), which will be used later.

The pci_set_drvdata() is not included in uncore_pci_pmu_register(). The
uncore PCI sub driver doesn't own the PCI device. It will not touch the
private driver data pointer for the device.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 82 ++++++++++++++++++++++++++----------------
 1 file changed, 51 insertions(+), 31 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index f6ff1b9..a884747 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1040,13 +1040,61 @@ uncore_pci_find_dev_pmu(struct pci_dev *pdev, const struct pci_device_id *ids)
 }
 
 /*
+ * Register the PMU for a PCI device
+ * @pdev: The PCI device.
+ * @type: The corresponding PMU type of the device.
+ * @pmu: The corresponding PMU of the device.
+ * @phys_id: The physical socket id which the device maps to.
+ * @die: The die id which the device maps to.
+ */
+static int uncore_pci_pmu_register(struct pci_dev *pdev,
+				   struct intel_uncore_type *type,
+				   struct intel_uncore_pmu *pmu,
+				   int phys_id, int die)
+{
+	struct intel_uncore_box *box;
+	int ret;
+
+	if (WARN_ON_ONCE(pmu->boxes[die] != NULL))
+		return -EINVAL;
+
+	box = uncore_alloc_box(type, NUMA_NO_NODE);
+	if (!box)
+		return -ENOMEM;
+
+	if (pmu->func_id < 0)
+		pmu->func_id = pdev->devfn;
+	else
+		WARN_ON_ONCE(pmu->func_id != pdev->devfn);
+
+	atomic_inc(&box->refcnt);
+	box->pci_phys_id = phys_id;
+	box->dieid = die;
+	box->pci_dev = pdev;
+	box->pmu = pmu;
+	uncore_box_init(box);
+
+	pmu->boxes[die] = box;
+	if (atomic_inc_return(&pmu->activeboxes) > 1)
+		return 0;
+
+	/* First active box registers the pmu */
+	ret = uncore_pmu_register(pmu);
+	if (ret) {
+		pmu->boxes[die] = NULL;
+		uncore_box_exit(box);
+		kfree(box);
+	}
+	return ret;
+}
+
+/*
  * add a pci uncore device
  */
 static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct intel_uncore_type *type;
 	struct intel_uncore_pmu *pmu = NULL;
-	struct intel_uncore_box *box;
 	int phys_id, die, ret;
 
 	ret = uncore_pci_get_dev_die_info(pdev, &phys_id, &die);
@@ -1082,38 +1130,10 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 		pmu = &type->pmus[UNCORE_PCI_DEV_IDX(id->driver_data)];
 	}
 
-	if (WARN_ON_ONCE(pmu->boxes[die] != NULL))
-		return -EINVAL;
-
-	box = uncore_alloc_box(type, NUMA_NO_NODE);
-	if (!box)
-		return -ENOMEM;
+	ret = uncore_pci_pmu_register(pdev, type, pmu, phys_id, die);
 
-	if (pmu->func_id < 0)
-		pmu->func_id = pdev->devfn;
-	else
-		WARN_ON_ONCE(pmu->func_id != pdev->devfn);
+	pci_set_drvdata(pdev, pmu->boxes[die]);
 
-	atomic_inc(&box->refcnt);
-	box->pci_phys_id = phys_id;
-	box->dieid = die;
-	box->pci_dev = pdev;
-	box->pmu = pmu;
-	uncore_box_init(box);
-	pci_set_drvdata(pdev, box);
-
-	pmu->boxes[die] = box;
-	if (atomic_inc_return(&pmu->activeboxes) > 1)
-		return 0;
-
-	/* First active box registers the pmu */
-	ret = uncore_pmu_register(pmu);
-	if (ret) {
-		pci_set_drvdata(pdev, NULL);
-		pmu->boxes[die] = NULL;
-		uncore_box_exit(box);
-		kfree(box);
-	}
 	return ret;
 }
 
-- 
2.7.4

