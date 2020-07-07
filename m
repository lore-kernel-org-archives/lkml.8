Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC861C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 00:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95ECC20656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 00:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgGGAGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 20:06:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:18972 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbgGGAGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 20:06:21 -0400
IronPort-SDR: EHK1Ctxpg1qQfZGvYURlSCNT2TIKlLha4gi8Pz9g4b+bUrFH8x65yQKLJToc2jxntR+3LKMlm4
 kSN+QL5V0j0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="212492295"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="212492295"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 17:06:17 -0700
IronPort-SDR: zIKUYel984wcBdO+TLjmSOReSJwSakFRRGa9gt4eyUT3zw+W/tvb3jMJlmnjGzGml0C6FqTgnX
 xPgt4TuSi+Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="456913831"
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
Subject: [PATCH v4 7/7] iommu/vt-d: Disable multiple GPASID-dev bind
Date:   Mon,  6 Jul 2020 17:12:54 -0700
Message-Id: <1594080774-33413-8-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594080774-33413-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1594080774-33413-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the unlikely use case where multiple aux domains from the same pdev
are attached to a single guest and then bound to a single process
(thus same PASID) within that guest, we cannot easily support this case
by refcounting the number of users. As there is only one SL page table
per PASID while we have multiple aux domains thus multiple SL page tables
for the same PASID.

Extra unbinding guest PASID can happen due to race between normal and
exception cases. Termination of one aux domain may affect others unless
we actively track and switch aux domains to ensure the validity of SL
page tables and TLB states in the shared PASID entry.

Support for sharing second level PGDs across domains can reduce the
complexity but this is not available due to the limitations on VFIO
container architecture. We can revisit this decision once sharing PGDs
are available.

Overall, the complexity and potential glitch do not warrant this unlikely
use case thereby removed by this patch.

Fixes: 56722a4398a30 ("iommu/vt-d: Add bind guest PASID support")
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 6c87c807a0ab..d386853121a2 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -277,20 +277,16 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 			goto out;
 		}
 
+		/*
+		 * Do not allow multiple bindings of the same device-PASID since
+		 * there is only one SL page tables per PASID. We may revisit
+		 * once sharing PGD across domains are supported.
+		 */
 		for_each_svm_dev(sdev, svm, dev) {
-			/*
-			 * For devices with aux domains, we should allow
-			 * multiple bind calls with the same PASID and pdev.
-			 */
-			if (iommu_dev_feature_enabled(dev,
-						      IOMMU_DEV_FEAT_AUX)) {
-				sdev->users++;
-			} else {
-				dev_warn_ratelimited(dev,
-						     "Already bound with PASID %u\n",
-						     svm->pasid);
-				ret = -EBUSY;
-			}
+			dev_warn_ratelimited(dev,
+					     "Already bound with PASID %u\n",
+					     svm->pasid);
+			ret = -EBUSY;
 			goto out;
 		}
 	} else {
-- 
2.7.4

