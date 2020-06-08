Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805A6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AA1D2078D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732648AbgFIAES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:04:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:45463 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731203AbgFHXVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:21:42 -0400
IronPort-SDR: wFi2Bku30C94HDgkwmxS3cfCG+mYEBxo9MifhoIRGv9TPDc6BbinmwwuN16SzJhaYx+RO6+DJx
 AdJs6vT8ZYyA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 16:21:42 -0700
IronPort-SDR: kx5nDcyS4aVdfRMtlstMyxBs9HPdSJuM7/Oo8XujZR2FD9UogzBuzmXUJkcT2fjil7QUwiqSed
 2HZWec3fVlVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,489,1583222400"; 
   d="scan'208";a="295641909"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 08 Jun 2020 16:21:40 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Enable PCI ACS for platform opt in hint
Date:   Tue,  9 Jun 2020 07:17:20 +0800
Message-Id: <20200608231720.27740-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCI ACS is disabled if Intel IOMMU is off by default or intel_iommu=off
is used in command line. Unfortunately, Intel IOMMU will be forced on if
there're devices sitting on an external facing PCI port that is marked
as untrusted (for example, thunderbolt peripherals). That means, PCI ACS
is disabled while Intel IOMMU is forced on to isolate those devices. As
the result, the devices of an MFD will be grouped by a single group even
the ACS is supported on device.

[    0.691263] pci 0000:00:07.1: Adding to iommu group 3
[    0.691277] pci 0000:00:07.2: Adding to iommu group 3
[    0.691292] pci 0000:00:07.3: Adding to iommu group 3

Fix it by requesting PCI ACS when Intel IOMMU is detected with platform
opt in hint.

Fixes: 89a6079df791a ("iommu/vt-d: Force IOMMU on for platform opt in hint")
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Co-developed-by: Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>
Signed-off-by: Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/dmar.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 60a2970c37ff..9e3e9067a71d 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -898,7 +898,8 @@ int __init detect_intel_iommu(void)
 	if (!ret)
 		ret = dmar_walk_dmar_table((struct acpi_table_dmar *)dmar_tbl,
 					   &validate_drhd_cb);
-	if (!ret && !no_iommu && !iommu_detected && !dmar_disabled) {
+	if (!ret && !no_iommu && !iommu_detected &&
+	    (!dmar_disabled || dmar_platform_optin())) {
 		iommu_detected = 1;
 		/* Make sure ACS will be enabled */
 		pci_request_acs();
-- 
2.17.1

