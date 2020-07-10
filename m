Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05396C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCBC220748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgGJDwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 23:52:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56516 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726509AbgGJDwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 23:52:25 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 352C5E318CA7A956C58D;
        Fri, 10 Jul 2020 11:52:20 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.201.126) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Fri, 10 Jul 2020 11:52:12 +0800
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
Subject: [PATCH v2] mm/hugetlb: split hugetlb_cma in nodes with memory
Date:   Fri, 10 Jul 2020 15:50:14 +1200
Message-ID: <20200710035014.25244-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.201.126]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than splitting huge_cma in online nodes, it is better to do it in
nodes with memory.
Without this patch, for an ARM64 server with four numa nodes and only
node0 has memory. If I set hugetlb_cma=4G in bootargs,

without this patch, I got the below printk:
hugetlb_cma: reserve 4096 MiB, up to 1024 MiB per node
hugetlb_cma: reserved 1024 MiB on node 0
hugetlb_cma: reservation failed: err -12, node 1
hugetlb_cma: reservation failed: err -12, node 2
hugetlb_cma: reservation failed: err -12, node 3

With this patch, I got the below printk:

hugetlb_cma: reserve 4096 MiB, up to 4096 MiB per node
hugetlb_cma: reserved 4096 MiB on node 0

So this patch makes the hugetlb_cma size consistent with users' setting
on ARM64 platforms.

Jonathan Cameron tested this patch on x86 platform. Jonathan figured out
the boot code of x86 is much different with arm64. On arm64 all nodes are
marked online at the same time. On x86, only nodes with memory are
initially marked as online:
initmem_init()->x86_numa_init()->numa_init()->
numa_register_memblks()->alloc_node_data()->node_set_online()
So at time of the existing cma setup call only the memory containing nodes
are online. The other nodes are brought up much later.
Therefore, on x86 platform, hugetlb_cma size is actually consistent with
users' setting even though system has nodes without memory.

The problem is always there if N_ONLINE != N_MEMORY. In x86 case, it
is just hidden because N_ONLINE happen to match N_MEMORY during the boot
process when hugetlb_cma_reserve() gets called.

This patch documents this problem in the comment of hugetlb_cma_reserve()
and makes hugetlb_cma size optimal.

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
 -v2: document better according to Anshuman Khandual's comment

 arch/arm64/mm/init.c    | 19 ++++++++++---------
 arch/x86/kernel/setup.c | 12 +++++++++---
 include/linux/hugetlb.h |  7 +++++++
 mm/hugetlb.c            |  4 ++--
 4 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 1e93cfc7c47a..420f5e55615c 100644
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
@@ -438,6 +429,16 @@ void __init bootmem_init(void)
 	sparse_init();
 	zone_sizes_init(min, max);
 
+	/*
+	 * must be done after zone_sizes_init() which calls free_area_init()
+	 * that calls node_set_state() to initialize node_states[N_MEMORY]
+	 * because hugetlb_cma_reserve() will scan over nodes with N_MEMORY
+	 * state
+	 */
+#ifdef CONFIG_ARM64_4K_PAGES
+	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
+#endif
+
 	memblock_dump_all();
 }
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index a3767e74c758..a1a9712090ae 100644
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
@@ -1180,6 +1177,15 @@ void __init setup_arch(char **cmdline_p)
 
 	x86_init.paging.pagetable_init();
 
+	/*
+	 * must be done after zone_sizes_init() which calls free_area_init()
+	 * that calls node_set_state() to initialize node_states[N_MEMORY]
+	 * because hugetlb_cma_reserve() will scan over nodes with N_MEMORY
+	 * state
+	 */
+	if (boot_cpu_has(X86_FEATURE_GBPAGES))
+		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
+
 	kasan_init();
 
 	/*
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 50650d0d01b9..6df411d91040 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -909,6 +909,13 @@ static inline spinlock_t *huge_pte_lock(struct hstate *h,
 }
 
 #if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_CMA)
+/**
+ * hugetlb_cma_reserve() -- reserve CMA for gigantic pages on nodes with memory
+ *
+ * must be called after free_area_init() that updates N_MEMORY via node_set_state().
+ * hugetlb_cma_reserve() scans over N_MEMORY nodemask and hence expects the platforms
+ * to have initialized N_MEMORY state.
+ */
 extern void __init hugetlb_cma_reserve(int order);
 extern void __init hugetlb_cma_check(void);
 #else
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bc3304af40d0..f2071f2d8c1f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5685,12 +5685,12 @@ void __init hugetlb_cma_reserve(int order)
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


