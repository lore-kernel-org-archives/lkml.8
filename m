Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D388BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC70F22B42
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgHEUZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:25:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:32773 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgHEUZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 16:25:14 -0400
IronPort-SDR: dbel/N2nZKODl0dOec42emWCUjDw01OkN4o/2FHn9N6xAg9PnIIhN2/hGBbOzx7h8G9qmgeBGY
 ClmOcMisYOiA==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="214171510"
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="214171510"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 13:25:12 -0700
IronPort-SDR: 08z1HJKuNLdDI0MR3BVTrFYBX/0IO+4tPgF34EGhTCoLUgeT6VbzidPtrgXfHpl+HAIdexhdDg
 6RYiDBZr1uJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="332958445"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by orsmga007.jf.intel.com with ESMTP; 05 Aug 2020 13:25:12 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 4/6] perf/x86/intel/uncore: Factor out uncore_pci_pmu_unregister()
Date:   Wed,  5 Aug 2020 13:24:09 -0700
Message-Id: <1596659051-95759-5-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596659051-95759-1-git-send-email-kan.liang@linux.intel.com>
References: <1596659051-95759-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The PMU unregistration in the uncore PCI sub driver is similar as the
normal PMU unregistration for a PCI device. The codes to unregister a
PCI PMU can be shared.

Factor out uncore_pci_pmu_unregister(), which will be used later.

Use uncore_pci_get_dev_die_info() to replace the codes which retrieve
the socket and die informaion.

The pci_set_drvdata() is not included in uncore_pci_pmu_unregister() as
well, because the uncore PCI sub driver will not touch the private
driver data pointer of the device.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index a884747..428a2c0 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1137,18 +1137,38 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	return ret;
 }
 
+/*
+ * Unregister the PMU of a PCI device
+ * @pmu: The corresponding PMU is unregistered.
+ * @phys_id: The physical socket id which the device maps to.
+ * @die: The die id which the device maps to.
+ */
+static void uncore_pci_pmu_unregister(struct intel_uncore_pmu *pmu,
+				      int phys_id, int die)
+{
+	struct intel_uncore_box *box = pmu->boxes[die];
+
+	if (WARN_ON_ONCE(phys_id != box->pci_phys_id))
+		return;
+
+	pmu->boxes[die] = NULL;
+	if (atomic_dec_return(&pmu->activeboxes) == 0)
+		uncore_pmu_unregister(pmu);
+	uncore_box_exit(box);
+	kfree(box);
+}
+
 static void uncore_pci_remove(struct pci_dev *pdev)
 {
 	struct intel_uncore_box *box;
 	struct intel_uncore_pmu *pmu;
 	int i, phys_id, die;
 
-	phys_id = uncore_pcibus_to_physid(pdev->bus);
+	if (uncore_pci_get_dev_die_info(pdev, &phys_id, &die))
+		return;
 
 	box = pci_get_drvdata(pdev);
 	if (!box) {
-		die = (topology_max_die_per_package() > 1) ? phys_id :
-					topology_phys_to_logical_pkg(phys_id);
 		for (i = 0; i < UNCORE_EXTRA_PCI_DEV_MAX; i++) {
 			if (uncore_extra_pci_dev[die].dev[i] == pdev) {
 				uncore_extra_pci_dev[die].dev[i] = NULL;
@@ -1160,15 +1180,10 @@ static void uncore_pci_remove(struct pci_dev *pdev)
 	}
 
 	pmu = box->pmu;
-	if (WARN_ON_ONCE(phys_id != box->pci_phys_id))
-		return;
 
 	pci_set_drvdata(pdev, NULL);
-	pmu->boxes[box->dieid] = NULL;
-	if (atomic_dec_return(&pmu->activeboxes) == 0)
-		uncore_pmu_unregister(pmu);
-	uncore_box_exit(box);
-	kfree(box);
+
+	uncore_pci_pmu_unregister(pmu, phys_id, die);
 }
 
 static int __init uncore_pci_init(void)
-- 
2.7.4

