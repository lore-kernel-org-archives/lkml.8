Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC48C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 00:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E44C220656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 00:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgGGAGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 20:06:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:18972 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgGGAGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 20:06:20 -0400
IronPort-SDR: /yLSR4MNBbWl9mGlh1x9s3mDPZTQp1/r6haq3or1OhGBRYjKvnRX/Kq5eK3x35gZpwcQtgPDVb
 yY6gwYtTxZcA==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="212492294"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="212492294"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 17:06:17 -0700
IronPort-SDR: fkYAVSxIRBBWJHkxRirdEJhXhbVqjRmHZAvxL6MDyaz2l7ogk1YhS1NXmigm5/LN9IrgVPSajd
 UvY2RNpt3JCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="456913822"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 06 Jul 2020 17:06:17 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 4/7] iommu/vt-d: Handle non-page aligned address
Date:   Mon,  6 Jul 2020 17:12:51 -0700
Message-Id: <1594080774-33413-5-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594080774-33413-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1594080774-33413-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Yi L <yi.l.liu@intel.com>

Address information for device TLB invalidation comes from userspace
when device is directly assigned to a guest with vIOMMU support.
VT-d requires page aligned address. This patch checks and enforce
address to be page aligned, otherwise reserved bits can be set in the
invalidation descriptor. Unrecoverable fault will be reported due to
non-zero value in the reserved bits.

Fixes: 61a06a16e36d8 ("iommu/vt-d: Support flushing more translation
cache types")
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

---
 drivers/iommu/intel/dmar.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index d9f973fa1190..b2c53bada905 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1455,9 +1455,25 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 	 * Max Invs Pending (MIP) is set to 0 for now until we have DIT in
 	 * ECAP.
 	 */
-	desc.qw1 |= addr & ~mask;
-	if (size_order)
+	if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
+		pr_warn_ratelimited("Invalidate non-aligned address %llx, order %d\n", addr, size_order);
+
+	/* Take page address */
+	desc.qw1 = QI_DEV_EIOTLB_ADDR(addr);
+
+	if (size_order) {
+		/*
+		 * Existing 0s in address below size_order may be the least
+		 * significant bit, we must set them to 1s to avoid having
+		 * smaller size than desired.
+		 */
+		desc.qw1 |= GENMASK_ULL(size_order + VTD_PAGE_SHIFT,
+					VTD_PAGE_SHIFT);
+		/* Clear size_order bit to indicate size */
+		desc.qw1 &= ~mask;
+		/* Set the S bit to indicate flushing more than 1 page */
 		desc.qw1 |= QI_DEV_EIOTLB_SIZE;
+	}
 
 	qi_submit_sync(iommu, &desc, 1, 0);
 }
-- 
2.7.4

