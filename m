Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D211C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 00:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41F2C2067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 00:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbgGHAZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 20:25:15 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35270 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728208AbgGHAZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 20:25:14 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 551C3A5C8F42FA658B63;
        Wed,  8 Jul 2020 08:25:12 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.214) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Wed, 8 Jul 2020 08:25:03 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <akpm@linux-foundation.org>
CC:     <x86@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Roman Gushchin <guro@fb.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH] mm/hugetlb: split hugetlb_cma in nodes with memory
Date:   Wed, 8 Jul 2020 12:23:07 +1200
Message-ID: <20200708002307.26716-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.200.214]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than splitting huge_cma in online nodes, it is better to do it in
nodes with memory.
For an ARM64 server with four numa nodes and only node0 has memory. If I
set hugetlb_cma=4G in bootargs,

without this patch, I got the below printk:
hugetlb_cma: reserve 4096 MiB, up to 1024 MiB per node
hugetlb_cma: reserved 1024 MiB on node 0
hugetlb_cma: reservation failed: err -12, node 1
hugetlb_cma: reservation failed: err -12, node 2
hugetlb_cma: reservation failed: err -12, node 3

hugetlb_cma size is broken once the system has nodes without memory.

With this patch, I got the below printk:
hugetlb_cma: reserve 4096 MiB, up to 4096 MiB per node
hugetlb_cma: reserved 4096 MiB on node 0

So this patch fixes the broken hugetlb_cma size on arm64.

Jonathan Cameron tested this patch on x86 platform. Jonathan figured out x86
is much different with arm64. hugetlb_cma size has never broken on x86.
On arm64 all nodes are marked online at the same time. On x86, only
nodes with memory are initially marked as online:
initmem_init()->x86_numa_init()->numa_init()->
numa_register_memblks()->alloc_node_data()->node_set_online()
So at time of the existing cma setup call only the memory containing nodes
are online. The other nodes are brought up much later.

Thus, the change is simply to fix ARM64.  A change is needed to x86 only
because the inherent assumptions in cma_hugetlb_reserve() have changed.

Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
Cc: Roman Gushchin <guro@fb.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 arch/arm64/mm/init.c    | 18 +++++++++---------
 arch/x86/kernel/setup.c | 13 ++++++++++---
 mm/hugetlb.c            |  4 ++--
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 1e93cfc7c47a..f6090ef6812b 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -420,15 +420,6 @@ void __init bootmem_init(void)
 
 	arm64_numa_init();
 
-	/*
-	 * must be done after arm64_numa_init() which calls numa_init() to
-	 * initialize node_online_map that gets used in hugetlb_cma_reserve()
-	 * while allocating required CMA size across online nodes.
-	 */
-#ifdef CONFIG_ARM64_4K_PAGES
-	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
-#endif
-
 	/*
 	 * Sparsemem tries to allocate bootmem in memory_present(), so must be
 	 * done after the fixed reservations.
@@ -438,6 +429,15 @@ void __init bootmem_init(void)
 	sparse_init();
 	zone_sizes_init(min, max);
 
+	/*
+	 * must be done after zone_sizes_init() which calls node_set_state() to
+	 * setup node_states[N_MEMORY] that gets used in hugetlb_cma_reserve()
+	 * while allocating required CMA size across nodes with memory.
+	 */
+#ifdef CONFIG_ARM64_4K_PAGES
+	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
+#endif
+
 	memblock_dump_all();
 }
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index a3767e74c758..fdb3a934b6c6 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1164,9 +1164,6 @@ void __init setup_arch(char **cmdline_p)
 	initmem_init();
 	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
 
-	if (boot_cpu_has(X86_FEATURE_GBPAGES))
-		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
-
 	/*
 	 * Reserve memory for crash kernel after SRAT is parsed so that it
 	 * won't consume hotpluggable memory.
@@ -1180,6 +1177,16 @@ void __init setup_arch(char **cmdline_p)
 
 	x86_init.paging.pagetable_init();
 
+	/*
+	 * must be done after zone_sizes_init() which calls node_set_state() to
+	 * setup node_states[N_MEMORY] that gets used in hugetlb_cma_reserve()
+	 * while allocating required CMA size across nodes with memory.
+	 * And zone_sizes_init() is done in x86_init.paging.pagetable_init()
+	 * which is typically paging_init().
+	 */
+	if (boot_cpu_has(X86_FEATURE_GBPAGES))
+		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
+
 	kasan_init();
 
 	/*
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d293c823121e..3a0ad49187e4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5699,12 +5699,12 @@ void __init hugetlb_cma_reserve(int order)
 	 * If 3 GB area is requested on a machine with 4 numa nodes,
 	 * let's allocate 1 GB on first three nodes and ignore the last one.
 	 */
-	per_node = DIV_ROUND_UP(hugetlb_cma_size, nr_online_nodes);
+	per_node = DIV_ROUND_UP(hugetlb_cma_size, num_node_state(N_MEMORY));
 	pr_info("hugetlb_cma: reserve %lu MiB, up to %lu MiB per node\n",
 		hugetlb_cma_size / SZ_1M, per_node / SZ_1M);
 
 	reserved = 0;
-	for_each_node_state(nid, N_ONLINE) {
+	for_each_node_state(nid, N_MEMORY) {
 		int res;
 
 		size = min(per_node, hugetlb_cma_size - reserved);
-- 
2.27.0


