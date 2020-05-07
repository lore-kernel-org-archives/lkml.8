Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAADC54E4A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 00:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 725FF20735
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 00:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgEGA7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 20:59:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:26590 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728395AbgEGA7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 20:59:14 -0400
IronPort-SDR: KWcfvfqmMys53NHORA5+ECWNYkJXaD4TRHd5E4pGTQHWfXONZntSU2MsJRDmbtofKG+VTO9fD8
 D8VCiHLlBbWw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 17:59:13 -0700
IronPort-SDR: qln4NkEEk5t6d6IbJjC7R3hJpvKDOQlxD3fjLCUjTSpO6qUNpvZULUMQqeyqSwoTo+qYdPdQD4
 unwsI80zcuuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,361,1583222400"; 
   d="scan'208";a="407461820"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by orsmga004.jf.intel.com with ESMTP; 06 May 2020 17:59:11 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        Liu Yi L <yi.l.liu@intel.com>, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 5/5] iommu/vt-d: Remove redundant IOTLB flush
Date:   Thu,  7 May 2020 08:55:34 +0800
Message-Id: <20200507005534.3080-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507005534.3080-1-baolu.lu@linux.intel.com>
References: <20200507005534.3080-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOTLB flush already included in the PASID tear down and the page request
drain process. There is no need to flush again.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-svm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 7256eb965cf6..5ff05adc96e9 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -209,11 +209,9 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	 * *has* to handle gracefully without affecting other processes.
 	 */
 	rcu_read_lock();
-	list_for_each_entry_rcu(sdev, &svm->devs, list) {
+	list_for_each_entry_rcu(sdev, &svm->devs, list)
 		intel_pasid_tear_down_entry(svm->iommu, sdev->dev,
 					    svm->pasid, true);
-		intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
-	}
 	rcu_read_unlock();
 
 }
@@ -407,7 +405,6 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
 			intel_pasid_tear_down_entry(iommu, dev,
 						    svm->pasid, false);
 			intel_svm_drain_prq(dev, svm->pasid);
-			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
 			kfree_rcu(sdev, rcu);
 
 			if (list_empty(&svm->devs)) {
@@ -647,7 +644,6 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 			intel_pasid_tear_down_entry(iommu, dev,
 						    svm->pasid, false);
 			intel_svm_drain_prq(dev, svm->pasid);
-			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
 			kfree_rcu(sdev, rcu);
 
 			if (list_empty(&svm->devs)) {
-- 
2.17.1

