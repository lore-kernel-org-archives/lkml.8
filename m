Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D43C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 932D72082F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgFQWAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 18:00:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37450 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726758AbgFQWAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:00:14 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7632131C4F4978AC70FE;
        Thu, 18 Jun 2020 06:00:12 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.210) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 18 Jun 2020 06:00:04 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <nsaenzjulienne@suse.de>, <steve.capper@arm.com>,
        <rppt@linux.ibm.com>, <akpm@linux-foundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>
Subject: [PATCH v3] arm64: mm: reserve hugetlb CMA after numa_init
Date:   Thu, 18 Jun 2020 09:58:28 +1200
Message-ID: <20200617215828.25296-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.200.210]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hugetlb_cma_reserve() is called at the wrong place. numa_init has not been
done yet. so all reserved memory will be located at node0.

Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Will Deacon <will@kernel.org>
Acked-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 -v3:
 add review-by;
 add comment according to Will's feedback

 arch/arm64/mm/init.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index e631e6425165..1e93cfc7c47a 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -404,11 +404,6 @@ void __init arm64_memblock_init(void)
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
 
 	dma_contiguous_reserve(arm64_dma32_phys_limit);
-
-#ifdef CONFIG_ARM64_4K_PAGES
-	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
-#endif
-
 }
 
 void __init bootmem_init(void)
@@ -424,6 +419,16 @@ void __init bootmem_init(void)
 	min_low_pfn = min;
 
 	arm64_numa_init();
+
+	/*
+	 * must be done after arm64_numa_init() which calls numa_init() to
+	 * initialize node_online_map that gets used in hugetlb_cma_reserve()
+	 * while allocating required CMA size across online nodes.
+	 */
+#ifdef CONFIG_ARM64_4K_PAGES
+	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
+#endif
+
 	/*
 	 * Sparsemem tries to allocate bootmem in memory_present(), so must be
 	 * done after the fixed reservations.
-- 
2.23.0


