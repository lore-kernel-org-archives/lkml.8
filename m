Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B311CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A29F22B42
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgHEUZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:25:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:48326 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbgHEUZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 16:25:11 -0400
IronPort-SDR: WhL7dtPdPEmIOngt+oBRyu3AHu4hEvmtvo/0smyy/hnwDgyhCP0FrQMY8zG7qL18AkRiU+mxCF
 Z7BGFwb8+mrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="150111860"
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="150111860"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 13:25:10 -0700
IronPort-SDR: EWxCIIhUZ+bOzadcqov1HsFFnhe8zEfU+4ogUmVH/U8MLMqmfTxW7YaDmDzb9XE2GhX8TABpIK
 TWrhb6jy6oVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="332958436"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by orsmga007.jf.intel.com with ESMTP; 05 Aug 2020 13:25:10 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 2/6] perf/x86/intel/uncore: Factor out uncore_pci_find_dev_pmu()
Date:   Wed,  5 Aug 2020 13:24:07 -0700
Message-Id: <1596659051-95759-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596659051-95759-1-git-send-email-kan.liang@linux.intel.com>
References: <1596659051-95759-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

When an uncore PCI sub driver gets a remove notification, the
corresponding PMU has to be retrieved and unregistered. The codes, which
find the corresponding PMU by comparing the pci_device_id table, can be
shared.

Factor out uncore_pci_find_dev_pmu(), which will be used later.

There is no functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 48 +++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index e14b03f..f6ff1b9 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1008,6 +1008,37 @@ static int uncore_pci_get_dev_die_info(struct pci_dev *pdev,
 
 	return 0;
 }
+
+/*
+ * Find the PMU of a PCI device.
+ * @pdev: The PCI device.
+ * @ids: The ID table of the available PCI devices with a PMU.
+ */
+static struct intel_uncore_pmu *
+uncore_pci_find_dev_pmu(struct pci_dev *pdev, const struct pci_device_id *ids)
+{
+	struct intel_uncore_pmu *pmu = NULL;
+	struct intel_uncore_type *type;
+	kernel_ulong_t data;
+	unsigned int devfn;
+
+	while (ids && ids->vendor) {
+		if ((ids->vendor == pdev->vendor) &&
+		    (ids->device == pdev->device)) {
+			data = ids->driver_data;
+			devfn = PCI_DEVFN(UNCORE_PCI_DEV_DEV(data),
+					  UNCORE_PCI_DEV_FUNC(data));
+			if (devfn == pdev->devfn) {
+				type = uncore_pci_uncores[UNCORE_PCI_DEV_TYPE(data)];
+				pmu = &type->pmus[UNCORE_PCI_DEV_IDX(data)];
+				break;
+			}
+		}
+		ids++;
+	}
+	return pmu;
+}
+
 /*
  * add a pci uncore device
  */
@@ -1039,21 +1070,8 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	 */
 	if (id->driver_data & ~0xffff) {
 		struct pci_driver *pci_drv = pdev->driver;
-		const struct pci_device_id *ids = pci_drv->id_table;
-		unsigned int devfn;
-
-		while (ids && ids->vendor) {
-			if ((ids->vendor == pdev->vendor) &&
-			    (ids->device == pdev->device)) {
-				devfn = PCI_DEVFN(UNCORE_PCI_DEV_DEV(ids->driver_data),
-						  UNCORE_PCI_DEV_FUNC(ids->driver_data));
-				if (devfn == pdev->devfn) {
-					pmu = &type->pmus[UNCORE_PCI_DEV_IDX(ids->driver_data)];
-					break;
-				}
-			}
-			ids++;
-		}
+
+		pmu = uncore_pci_find_dev_pmu(pdev, pci_drv->id_table);
 		if (pmu == NULL)
 			return -ENODEV;
 	} else {
-- 
2.7.4

