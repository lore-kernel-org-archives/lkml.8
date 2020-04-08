Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F8DC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC9E2072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgDHHVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 03:21:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:42828 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgDHHVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 03:21:33 -0400
IronPort-SDR: 9qIDK1VANMo4fNW2iwJjwnAkj1z7jP6FOBMh6kWDgDY4jjZcy8eTKgE6LkMWXLKODx8tXrlzYz
 r0FJbG0w8c6Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 00:21:32 -0700
IronPort-SDR: 8DU0rS43X0+q9dh1hmnTkwwNvy5G+AJbotvfyHkVhAtAtrkAB6SWCe/akFWTK0FC7Hnr2U7p4W
 lJW241t73Enw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,357,1580803200"; 
   d="scan'208";a="254713673"
Received: from joy-optiplex-7040.sh.intel.com ([10.239.13.16])
  by orsmga006.jf.intel.com with ESMTP; 08 Apr 2020 00:21:30 -0700
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     alex.williamson@redhat.com, cohuck@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yan Zhao <yan.y.zhao@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] vfio: checking of validity of user vaddr in vfio_dma_rw
Date:   Wed,  8 Apr 2020 03:11:21 -0400
Message-Id: <20200408071121.25645-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

instead of calling __copy_to/from_user(), use copy_to_from_user() to
ensure vaddr range is a valid user address range before accessing them.

Cc: Kees Cook <keescook@chromium.org>

Fixes: 8d46c0cca5f4 ("vfio: introduce vfio_dma_rw to read/write a range of IOVAs")
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 drivers/vfio/vfio_iommu_type1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 3aefcc8e2933..fbc58284b333 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -2345,10 +2345,10 @@ static int vfio_iommu_type1_dma_rw_chunk(struct vfio_iommu *iommu,
 	vaddr = dma->vaddr + offset;
 
 	if (write)
-		*copied = __copy_to_user((void __user *)vaddr, data,
+		*copied = copy_to_user((void __user *)vaddr, data,
 					 count) ? 0 : count;
 	else
-		*copied = __copy_from_user(data, (void __user *)vaddr,
+		*copied = copy_from_user(data, (void __user *)vaddr,
 					   count) ? 0 : count;
 	if (kthread)
 		unuse_mm(mm);
-- 
2.17.1

