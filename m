Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCEEC0044D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 01:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D069420663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 01:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733116AbgCQBMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 21:12:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:35614 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733017AbgCQBMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 21:12:50 -0400
IronPort-SDR: 0eLccunPwof4+zVF20ibZbFYYQ2CjSJ2ZywnWok76MaHhuetEgfKYVFJHVplXAu0AqjNS6bYbA
 eFNdHD9Z4m1w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 18:12:49 -0700
IronPort-SDR: +84DntUAMAuwV5f09HlFOUn2P/p32UPXKVpFFk29p2DkFjlDAcIQJe/qIvhWUYyffUH0pMyjpW
 DjOh7595MAjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,562,1574150400"; 
   d="scan'208";a="267782250"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 16 Mar 2020 18:12:47 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        kevin.tian@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Liu Yi L <yi.l.liu@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Fix page request descriptor size
Date:   Tue, 17 Mar 2020 09:10:18 +0800
Message-Id: <20200317011018.22799-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

Intel VT-d might support PRS (Page Reqest Support) when it's
running in the scalable mode. Each page request descriptor
occupies 32 bytes and is 32-bytes aligned. The page request
descriptor offset mask should be 32-bytes aligned.

Fixes: 5b438f4ba315d ("iommu/vt-d: Support page request in scalable mode")
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 0e506de2d375..6183016f4269 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -491,7 +491,7 @@ struct page_req_dsc {
 	u64 priv_data[2];
 };
 
-#define PRQ_RING_MASK ((0x1000 << PRQ_ORDER) - 0x10)
+#define PRQ_RING_MASK	((0x1000 << PRQ_ORDER) - 0x20)
 
 static bool access_error(struct vm_area_struct *vma, struct page_req_dsc *req)
 {
-- 
2.17.1

