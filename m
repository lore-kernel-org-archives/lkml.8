Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441E0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23F6E20678
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgHEUZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:25:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:48318 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbgHEUZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 16:25:10 -0400
IronPort-SDR: VrOGxXHQ+LSD9H5cM9SUGVTw3z3+N+A8aqAEOrFA+uMCt9pHuVW33h5wVzmEmkDtvTtXorONn9
 906eXlZs/37w==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="150111859"
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="150111859"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 13:25:10 -0700
IronPort-SDR: HbRHoTGFJSxS1MIl+mccRaoFfcuWW/ooCQc9+11yaMXRaUJZn+GrmwxZusWdaZA2qdUwhu4ejm
 st/UzK+2+Q0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="332958432"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by orsmga007.jf.intel.com with ESMTP; 05 Aug 2020 13:25:09 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 1/6] perf/x86/intel/uncore: Factor out uncore_pci_get_dev_die_info()
Date:   Wed,  5 Aug 2020 13:24:06 -0700
Message-Id: <1596659051-95759-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596659051-95759-1-git-send-email-kan.liang@linux.intel.com>
References: <1596659051-95759-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The socket and die information is required to register/unregister a PMU
in the uncore PCI sub driver. The codes, which get the socket and die
information from a BUS number, can be shared.

Factor out uncore_pci_get_dev_die_info(), which will be used later.

There is no functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index d5c6d3b..e14b03f 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -989,6 +989,26 @@ uncore_types_init(struct intel_uncore_type **types, bool setid)
 }
 
 /*
+ * Get the die information of a PCI device.
+ * @pdev: The PCI device.
+ * @phys_id: The physical socket id which the device maps to.
+ * @die: The die id which the device maps to.
+ */
+static int uncore_pci_get_dev_die_info(struct pci_dev *pdev,
+				       int *phys_id, int *die)
+{
+	*phys_id = uncore_pcibus_to_physid(pdev->bus);
+	if (*phys_id < 0)
+		return -ENODEV;
+
+	*die = (topology_max_die_per_package() > 1) ? *phys_id :
+				topology_phys_to_logical_pkg(*phys_id);
+	if (*die < 0)
+		return -EINVAL;
+
+	return 0;
+}
+/*
  * add a pci uncore device
  */
 static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
@@ -998,14 +1018,9 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	struct intel_uncore_box *box;
 	int phys_id, die, ret;
 
-	phys_id = uncore_pcibus_to_physid(pdev->bus);
-	if (phys_id < 0)
-		return -ENODEV;
-
-	die = (topology_max_die_per_package() > 1) ? phys_id :
-					topology_phys_to_logical_pkg(phys_id);
-	if (die < 0)
-		return -EINVAL;
+	ret = uncore_pci_get_dev_die_info(pdev, &phys_id, &die);
+	if (ret)
+		return ret;
 
 	if (UNCORE_PCI_DEV_TYPE(id->driver_data) == UNCORE_EXTRA_PCI_DEV) {
 		int idx = UNCORE_PCI_DEV_IDX(id->driver_data);
-- 
2.7.4

