Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750C9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47DC62078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgGJMMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:12:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34470 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726664AbgGJML7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:11:59 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9A88CBA74490FCAB9C3A;
        Fri, 10 Jul 2020 20:11:55 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.202.234) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Fri, 10 Jul 2020 20:11:49 +0800
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
Subject: [PATCH v3] mm/hugetlb: split hugetlb_cma in nodes with memory
Date:   Sat, 11 Jul 2020 00:09:50 +1200
Message-ID: <20200710120950.37716-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.202.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Online nodes are not necessarily memory containing nodes. Splitting
huge_cma in online nodes can lead to inconsistent hugetlb_cma size
with user setting. For example, for one system with 4 numa nodes and
only one of them has memory, if users set hugetlb_cma to 4GB, it will
split into four 1GB. So only the node with memory will get 1GB CMA.
All other three nodes get nothing. That means the whole system gets
only 1GB CMA while users ask for 4GB.

Thus, it is more sensible to split hugetlb_cma in nodes with memory.
For the above case, the only node with memory will reserve 4GB cma
which is same with user setting in bootargs. In order to split cma
in nodes with memory, hugetlb_cma_reserve() should scan over those
nodes with N_MEMORY state rather than N_ONLINE state. That means
the function should be called only after arch code has finished
setting the N_MEMORY state of nodes.

The problem is always there if N_ONLINE != N_MEMORY. It is a general
problem to all platforms. But there is some trivial difference among
different architectures.
For example, for ARM64, before hugetlb_cma_reserve() is called, all
nodes have got N_ONLINE state. So hugetlb will get inconsistent cma
size when some online nodes have no memory. For x86 case, the problem
is hidden because X86 happens to just set N_ONLINE on the nodes with
memory when hugetlb_cma_reserve() is called.

Anyway, this patch moves to scan N_MEMORY in hugetlb_cma_reserve()
and lets both x86 and ARM64 call the function after N_MEMORY state
is ready. It also documents the requirement in the definition of
hugetlb_cma_reserve().

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
 v3:
 another try to refine changelog with respect to Anshuman Khandual's comments

 arch/arm64/mm/init.c    | 19 ++++++++++---------
 arch/x86/kernel/setup.c | 12 +++++++++---
 mm/hugetlb.c            | 11 +++++++++--
 3 files changed, 28 insertions(+), 14 deletions(-)

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
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bc3304af40d0..32b5035ffec1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5665,6 +5665,13 @@ static int __init cmdline_parse_hugetlb_cma(char *p)
 
 early_param("hugetlb_cma", cmdline_parse_hugetlb_cma);
 
+/*
+ * hugetlb_cma_reserve() - reserve CMA for gigantic pages on nodes with memory
+ *
+ * must be called after free_area_init() that updates N_MEMORY via node_set_state().
+ * hugetlb_cma_reserve() scans over N_MEMORY nodemask and hence expects the platforms
+ * to have initialized N_MEMORY state.
+ */
 void __init hugetlb_cma_reserve(int order)
 {
 	unsigned long size, reserved, per_node;
@@ -5685,12 +5692,12 @@ void __init hugetlb_cma_reserve(int order)
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


