Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DF2C5ACBF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 07:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C391020719
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 07:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgCQHF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 03:05:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:56620 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbgCQHF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 03:05:28 -0400
IronPort-SDR: k2wWMUbBFNSxFaqMtVd/tUtQh6CWRti2fIBUyr+FdWc5s1bxCriVTeAsxK8glMi021I/5M/V0F
 CFOj3ko45fLg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 00:05:28 -0700
IronPort-SDR: Du6KI+jVJxW8i0JEH2B5QN2MxBjOTS3IucnyWHyVlhTQqGr5Sy9dLktw8bDHvwip2cs0QoN44g
 Jrwj3+FAq+VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,563,1574150400"; 
   d="scan'208";a="267867354"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 17 Mar 2020 00:05:25 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        Liu Yi L <yi.l.liu@intel.com>, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 4/5] iommu/vt-d: Refactor prq_event_thread()
Date:   Tue, 17 Mar 2020 15:02:28 +0800
Message-Id: <20200317070229.21131-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200317070229.21131-1-baolu.lu@linux.intel.com>
References: <20200317070229.21131-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the software processing page request descriptors part from
prq_event_thread() into a separated function. No any functional
changes.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-svm.c | 43 +++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 6183016f4269..6ce96dd541a6 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -517,27 +517,21 @@ static bool is_canonical_address(u64 addr)
 	return (((saddr << shift) >> shift) == saddr);
 }
 
-static irqreturn_t prq_event_thread(int irq, void *d)
+static int intel_svm_process_prq(struct intel_iommu *iommu,
+				 struct page_req_dsc *prq,
+				 int head, int tail)
 {
-	struct intel_iommu *iommu = d;
 	struct intel_svm *svm = NULL;
-	int head, tail, handled = 0;
-
-	/* Clear PPR bit before reading head/tail registers, to
-	 * ensure that we get a new interrupt if needed. */
-	writel(DMA_PRS_PPR, iommu->reg + DMAR_PRS_REG);
+	struct intel_svm_dev *sdev;
+	struct vm_area_struct *vma;
+	struct page_req_dsc *req;
+	struct qi_desc resp;
+	int handled = 0;
+	vm_fault_t ret;
+	u64 address;
+	int result;
 
-	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
-	head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
 	while (head != tail) {
-		struct intel_svm_dev *sdev;
-		struct vm_area_struct *vma;
-		struct page_req_dsc *req;
-		struct qi_desc resp;
-		int result;
-		vm_fault_t ret;
-		u64 address;
-
 		handled = 1;
 
 		req = &iommu->prq[head / sizeof(*req)];
@@ -649,6 +643,21 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
 
+	return handled;
+}
+
+static irqreturn_t prq_event_thread(int irq, void *d)
+{
+	struct intel_iommu *iommu = d;
+	int head, tail, handled;
+
+	/* Clear PPR bit before reading head/tail registers, to
+	 * ensure that we get a new interrupt if needed. */
+	writel(DMA_PRS_PPR, iommu->reg + DMAR_PRS_REG);
+
+	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
+	head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
+	handled = intel_svm_process_prq(iommu, iommu->prq, head, tail);
 	dmar_writeq(iommu->reg + DMAR_PQH_REG, tail);
 
 	return IRQ_RETVAL(handled);
-- 
2.17.1

