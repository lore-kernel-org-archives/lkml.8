Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0353EC5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 08:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D77BB2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 08:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgDVIJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 04:09:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:3118 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgDVIJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 04:09:31 -0400
IronPort-SDR: +m9f03o3W9SDK07bd3LqMR+nvhEDE7W6pQJuBEnjkB4ku3iNfa3D/PQsYQHM28bk9TVWj/6qlq
 k4KAXFmPoa9Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 01:09:31 -0700
IronPort-SDR: Wn0DWR4rFVqBBrCZR51mE6qJ8Dy3fREZ6QTcElA5HhY5SG33s1lX4qDQ/7GX4xlVcjXdSgWO+R
 VTWyrEQ4b/vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,412,1580803200"; 
   d="scan'208";a="365609644"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 22 Apr 2020 01:09:29 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        Liu Yi L <yi.l.liu@intel.com>, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 4/4] iommu/vt-d: Remove redundant IOTLB flush
Date:   Wed, 22 Apr 2020 16:06:11 +0800
Message-Id: <20200422080611.15689-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422080611.15689-1-baolu.lu@linux.intel.com>
References: <20200422080611.15689-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOTLB flush already included in the PASID tear down and the page request
drain process. There is no need to flush again.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-svm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 2534641ef707..543109fe2003 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -212,7 +212,6 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	list_for_each_entry_rcu(sdev, &svm->devs, list) {
 		intel_pasid_tear_down_entry(svm->iommu, sdev->dev, svm->pasid);
 		intel_svm_drain_prq(sdev->dev, svm->pasid);
-		intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
 	}
 	rcu_read_unlock();
 
@@ -406,7 +405,6 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
 			list_del_rcu(&sdev->list);
 			intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
 			intel_svm_drain_prq(dev, svm->pasid);
-			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
 			kfree_rcu(sdev, rcu);
 
 			if (list_empty(&svm->devs)) {
@@ -645,7 +643,6 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 			 * hard to be as defensive as we might like. */
 			intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
 			intel_svm_drain_prq(dev, svm->pasid);
-			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
 			kfree_rcu(sdev, rcu);
 
 			if (list_empty(&svm->devs)) {
-- 
2.17.1

