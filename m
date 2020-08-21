Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54C8C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 11:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDDCD20732
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 11:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgHULiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 07:38:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10300 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727931AbgHULhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 07:37:06 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6EB9571D0E991F6D9C19;
        Fri, 21 Aug 2020 19:37:04 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.129) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 21 Aug 2020 19:36:58 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
        <will@kernel.org>, <ganapatrao.kulkarni@cavium.com>,
        <catalin.marinas@arm.com>, <akpm@linux-foundation.org>
CC:     <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <prime.zeng@hisilicon.com>,
        <huangdaode@huawei.com>, <linuxarm@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v7 3/3] mm: cma: use CMA_MAX_NAME to define the length of cma name array
Date:   Fri, 21 Aug 2020 23:33:55 +1200
Message-ID: <20200821113355.6140-4-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200821113355.6140-1-song.bao.hua@hisilicon.com>
References: <20200821113355.6140-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.200.129]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CMA_MAX_NAME should be visible to CMA's users as they might need it to set
the name of CMA areas and avoid hardcoding the size locally.
So this patch moves CMA_MAX_NAME from local header file to include/linux
header file and removes the magic number in hugetlb.c and contiguous.c.

Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 this patch is fixing the magic number issue with respect to Will's comment here:
 https://lore.kernel.org/linux-iommu/4ab78767553f48a584217063f6f24eb9@hisilicon.com/

 include/linux/cma.h     | 2 ++
 kernel/dma/contiguous.c | 2 +-
 mm/cma.h                | 2 --
 mm/hugetlb.c            | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index 6ff79fefd01f..217999c8a762 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -18,6 +18,8 @@
 
 #endif
 
+#define CMA_MAX_NAME 64
+
 struct cma;
 
 extern unsigned long totalcma_pages;
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 0383c9b86715..d2d6b715c274 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -119,7 +119,7 @@ void __init dma_pernuma_cma_reserve(void)
 
 	for_each_online_node(nid) {
 		int ret;
-		char name[20];
+		char name[CMA_MAX_NAME];
 		struct cma **cma = &dma_contiguous_pernuma_area[nid];
 
 		snprintf(name, sizeof(name), "pernuma%d", nid);
diff --git a/mm/cma.h b/mm/cma.h
index 20f6e24bc477..42ae082cb067 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -4,8 +4,6 @@
 
 #include <linux/debugfs.h>
 
-#define CMA_MAX_NAME 64
-
 struct cma {
 	unsigned long   base_pfn;
 	unsigned long   count;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a301c2d672bf..9eec0ea9ba68 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5683,12 +5683,12 @@ void __init hugetlb_cma_reserve(int order)
 	reserved = 0;
 	for_each_node_state(nid, N_ONLINE) {
 		int res;
-		char name[20];
+		char name[CMA_MAX_NAME];
 
 		size = min(per_node, hugetlb_cma_size - reserved);
 		size = round_up(size, PAGE_SIZE << order);
 
-		snprintf(name, 20, "hugetlb%d", nid);
+		snprintf(name, sizeof(name), "hugetlb%d", nid);
 		res = cma_declare_contiguous_nid(0, size, 0, PAGE_SIZE << order,
 						 0, false, name,
 						 &hugetlb_cma[nid], nid);
-- 
2.27.0


