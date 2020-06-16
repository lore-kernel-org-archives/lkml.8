Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8355AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 22:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64135207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 22:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgFPWVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 18:21:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6347 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725790AbgFPWVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 18:21:09 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 272BA9D6BAD4017319D4;
        Wed, 17 Jun 2020 06:21:07 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.10) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 17 Jun 2020 06:20:58 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <nsaenzjulienne@suse.de>, <steve.capper@arm.com>,
        <rppt@linux.ibm.com>, <akpm@linux-foundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v2] arm64: mm: reserve hugetlb CMA after numa_init
Date:   Wed, 17 Jun 2020 10:19:24 +1200
Message-ID: <20200616221924.74780-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.203.10]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hugetlb_cma_reserve() is called at the wrong place. numa_init has not been
done yet. so all reserved memory will be located at node0.

Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Acked-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 -v2: add Fixes tag according to Matthias Brugger's comment

 arch/arm64/mm/init.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index e631e6425165..41914b483d54 100644
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
@@ -424,6 +419,11 @@ void __init bootmem_init(void)
 	min_low_pfn = min;
 
 	arm64_numa_init();
+
+#ifdef CONFIG_ARM64_4K_PAGES
+	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
+#endif
+
 	/*
 	 * Sparsemem tries to allocate bootmem in memory_present(), so must be
 	 * done after the fixed reservations.
-- 
2.23.0


