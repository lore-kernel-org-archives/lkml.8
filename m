Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4267C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BF912078A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408048AbgDPG2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 02:28:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:28088 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407878AbgDPG1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:27:12 -0400
IronPort-SDR: 8BmkvFSIiGHrvC4IqG4DCaagQzhd47ar1+w8AIbzREdr0VT2XFlkiAlm66iZVuhw5Rx/fBl/zi
 SzyWGL+OHvMA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 23:27:12 -0700
IronPort-SDR: SX55Mth9OeckkE6SGIu2EM2vP+O9ZZ1JaLsNRCOkMX2yLoJVXBJrhvdM/b5C8Zve8+IQ3OCPiP
 5KVUnZDd/vtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="277881097"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 15 Apr 2020 23:27:09 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        kevin.tian@intel.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Daniel Drake <drake@endlessm.com>,
        Derrick Jonathan <jonathan.derrick@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 2/3] iommu/vt-d: Allow PCI sub-hierarchy to use DMA domain
Date:   Thu, 16 Apr 2020 14:23:53 +0800
Message-Id: <20200416062354.10307-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416062354.10307-1-baolu.lu@linux.intel.com>
References: <20200416062354.10307-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before commit fa954e6831789 ("iommu/vt-d: Delegate the dma domain
to upper layer"), Intel IOMMU started off with all devices in the
identity domain, and took them out later if it found they couldn't
access all of memory. This required devices behind a PCI bridge to
use a DMA domain at the beginning because all PCI devices behind
the bridge use the same source-id in their transactions and the
domain couldn't be changed at run-time.

Intel IOMMU driver is now aligned with the default domain framework,
there's no need to keep this requirement anymore.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index bc5c821519a5..f556fd89c7d2 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2857,31 +2857,6 @@ static int device_def_domain_type(struct device *dev)
 
 		if ((iommu_identity_mapping & IDENTMAP_GFX) && IS_GFX_DEVICE(pdev))
 			return IOMMU_DOMAIN_IDENTITY;
-
-		/*
-		 * We want to start off with all devices in the 1:1 domain, and
-		 * take them out later if we find they can't access all of memory.
-		 *
-		 * However, we can't do this for PCI devices behind bridges,
-		 * because all PCI devices behind the same bridge will end up
-		 * with the same source-id on their transactions.
-		 *
-		 * Practically speaking, we can't change things around for these
-		 * devices at run-time, because we can't be sure there'll be no
-		 * DMA transactions in flight for any of their siblings.
-		 *
-		 * So PCI devices (unless they're on the root bus) as well as
-		 * their parent PCI-PCI or PCIe-PCI bridges must be left _out_ of
-		 * the 1:1 domain, just in _case_ one of their siblings turns out
-		 * not to be able to map all of memory.
-		 */
-		if (!pci_is_pcie(pdev)) {
-			if (!pci_is_root_bus(pdev->bus))
-				return IOMMU_DOMAIN_DMA;
-			if (pdev->class >> 8 == PCI_CLASS_BRIDGE_PCI)
-				return IOMMU_DOMAIN_DMA;
-		} else if (pci_pcie_type(pdev) == PCI_EXP_TYPE_PCI_BRIDGE)
-			return IOMMU_DOMAIN_DMA;
 	}
 
 	return 0;
-- 
2.17.1

