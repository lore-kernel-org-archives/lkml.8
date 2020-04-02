Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA65C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7512072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389215AbgDBPUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:20:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:50448 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388942AbgDBPUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:20:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AE328B167;
        Thu,  2 Apr 2020 15:20:02 +0000 (UTC)
Subject: Re: [PATCH 2/2] mm: hugetlb: Use node interface of cma
To:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Cc:     Aslan Bakirov <aslan@fb.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@fb.com, riel@surriel.com, hannes@cmpxchg.org
References: <20200326212718.3798742-1-aslan@fb.com>
 <20200326212718.3798742-2-aslan@fb.com>
 <20200327080610.GV27965@dhcp22.suse.cz>
 <20200327144155.GA194089@carbon.DHCP.thefacebook.com>
 <20200327151339.GF10449@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <bc4af092-fb30-c8af-564c-ab2c0986109e@suse.cz>
Date:   Thu, 2 Apr 2020 17:20:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200327151339.GF10449@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/27/20 4:13 PM, Michal Hocko wrote:
> On Fri 27-03-20 07:41:55, Roman Gushchin wrote:
>> On Fri, Mar 27, 2020 at 09:06:10AM +0100, Michal Hocko wrote:
>> > On Thu 26-03-20 14:27:18, Aslan Bakirov wrote:
>> > > With introduction of numa node interface for CMA, this patch is for using that
>> > > interface for allocating memory on numa nodes if NUMA is configured.
>> > > This will be more efficient  and cleaner because first, instead of iterating
>> > > mem range of each numa node, cma_declare_contigueous_nid() will do
>> > > its own address finding if we pass 0 for  both min_pfn and max_pfn,
>> > > second, it can also handle caseswhere NUMA is not configured
>> > > by passing NUMA_NO_NODE as an argument.
>> > > 
>> > > In addition, checking if desired size of memory is available or not,
>> > > is happening in cma_declare_contiguous_nid()  because base and
>> > > limit will be determined there, since 0(any) for  base and
>> > > 0(any) for limit is passed as argument to the function.
>> > 
>> > This looks much better than the original patch. Can we simply squash
>> > your and Roman's patch in the mmotm tree and post it for the review in
>> > one piece? It would be slightly easier to review that way.
>> 
>> I'm glad you liked it! I agree, it's much nicer now, thanks to Aslan!
>> 
>> I think it's simpler to keep it as a separate patch, because there was
>> already a fix by Randy Dunlap on top of my original version.
> 
> Why would be squashing all those into a single one be a problem. I will
> not insist of course but I would much rather see a single patch which is
> easy to review and doesn't contain any intermediate hacks to prevent

FWIW, for review purposes, this is Roman's patch with all followups from
mmotm/next (hopefully didn't miss any) and then squashed with patch 2/2 from
this thread. It can be applied like this:

- checkout v5.6
- apply patch 1/2 from this thread
- apply below

----8<----
From dc10a593f2b8dfc7be920b4b088a8d55068fc6bc Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Thu, 2 Apr 2020 13:49:04 +1100
Subject: [PATCH] mm: hugetlb: optionally allocate gigantic hugepages using cma

Commit 944d9fec8d7a ("hugetlb: add support for gigantic page allocation at
runtime") has added the run-time allocation of gigantic pages.  However it
actually works only at early stages of the system loading, when the
majority of memory is free.  After some time the memory gets fragmented by
non-movable pages, so the chances to find a contiguous 1 GB block are
getting close to zero.  Even dropping caches manually doesn't help a lot.

At large scale rebooting servers in order to allocate gigantic hugepages
is quite expensive and complex.  At the same time keeping some constant
percentage of memory in reserved hugepages even if the workload isn't
using it is a big waste: not all workloads can benefit from using 1 GB
pages.

The following solution can solve the problem:
1) On boot time a dedicated cma area* is reserved. The size is passed
   as a kernel argument.
2) Run-time allocations of gigantic hugepages are performed using the
   cma allocator and the dedicated cma area

In this case gigantic hugepages can be allocated successfully with a high
probability, however the memory isn't completely wasted if nobody is using
1GB hugepages: it can be used for pagecache, anon memory, THPs, etc.

* On a multi-node machine a per-node cma area is allocated on each node.
  Following gigantic hugetlb allocation are using the first available
  numa node if the mask isn't specified by a user.

Usage:
1) configure the kernel to allocate a cma area for hugetlb allocations:
   pass hugetlb_cma=10G as a kernel argument

2) allocate hugetlb pages as usual, e.g.
   echo 10 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages

If the option isn't enabled or the allocation of the cma area failed,
the current behavior of the system is preserved.

x86 and arm-64 are covered by this patch, other architectures can be
trivially added later.

Link: http://lkml.kernel.org/r/20200311220920.2487528-1-guro@fb.com
Signed-off-by: Roman Gushchin <guro@fb.com>
Tested-by: Andreas Schaufler <andreas.schaufler@gmx.de>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Andreas Schaufler <andreas.schaufler@gmx.de>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Joonsoo Kim <js1304@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

mm: hugetlb: Use node interface of cma

With introduction of numa node interface for CMA, this patch is for using that
interface for allocating memory on numa nodes if NUMA is configured.
This will be more efficient  and cleaner because first, instead of iterating
mem range of each numa node, cma_declare_contigueous_nid() will do
its own address finding if we pass 0 for  both min_pfn and max_pfn,
second, it can also handle caseswhere NUMA is not configured
by passing NUMA_NO_NODE as an argument.

In addition, checking if desired size of memory is available or not,
is happening in cma_declare_contiguous_nid()  because base and
limit will be determined there, since 0(any) for  base and
0(any) for limit is passed as argument to the function.

Signed-off-by: Aslan Bakirov <aslan@fb.com>
Acked-by: Roman Gushchin <guro@fb.com>
---
 .../admin-guide/kernel-parameters.txt         |  7 ++
 arch/arm64/mm/init.c                          |  6 ++
 arch/x86/kernel/setup.c                       |  4 +
 include/linux/hugetlb.h                       |  8 ++
 mm/hugetlb.c                                  | 98 +++++++++++++++++++
 5 files changed, 123 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c07815d230bc..379b90c5a9aa 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1445,6 +1445,13 @@
 	hpet_mmap=	[X86, HPET_MMAP] Allow userspace to mmap HPET
 			registers.  Default set by CONFIG_HPET_MMAP_DEFAULT.
 
+	hugetlb_cma=	[x86-64] The size of a cma area used for allocation
+			of gigantic hugepages.
+			Format: nn[KMGTPE]
+
+			If enabled, boot-time allocation of gigantic hugepages
+			is skipped.
+
 	hugepages=	[HW,X86-32,IA-64] HugeTLB pages to allocate at boot.
 	hugepagesz=	[HW,IA-64,PPC,X86-64] The size of the HugeTLB pages.
 			On x86-64 and powerpc, this option can be specified
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index b65dffdfb201..e42727e3568e 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -29,6 +29,7 @@
 #include <linux/mm.h>
 #include <linux/kexec.h>
 #include <linux/crash_dump.h>
+#include <linux/hugetlb.h>
 
 #include <asm/boot.h>
 #include <asm/fixmap.h>
@@ -457,6 +458,11 @@ void __init arm64_memblock_init(void)
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
 
 	dma_contiguous_reserve(arm64_dma32_phys_limit);
+
+#ifdef CONFIG_ARM64_4K_PAGES
+	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
+#endif
+
 }
 
 void __init bootmem_init(void)
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index a74262c71484..fc3e326a62b9 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -16,6 +16,7 @@
 #include <linux/pci.h>
 #include <linux/root_dev.h>
 #include <linux/sfi.h>
+#include <linux/hugetlb.h>
 #include <linux/tboot.h>
 #include <linux/usb/xhci-dbgp.h>
 
@@ -1158,6 +1159,9 @@ void __init setup_arch(char **cmdline_p)
 	initmem_init();
 	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
 
+	if (boot_cpu_has(X86_FEATURE_GBPAGES))
+		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
+
 	/*
 	 * Reserve memory for crash kernel after SRAT is parsed so that it
 	 * won't consume hotpluggable memory.
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 1e897e4168ac..2819c7339f20 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -845,4 +845,12 @@ static inline spinlock_t *huge_pte_lock(struct hstate *h,
 	return ptl;
 }
 
+#if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_CMA)
+extern void __init hugetlb_cma_reserve(int order);
+#else
+static inline __init void hugetlb_cma_reserve(int order)
+{
+}
+#endif
+
 #endif /* _LINUX_HUGETLB_H */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index dd8737a94bec..054fadf34c39 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -28,6 +28,7 @@
 #include <linux/jhash.h>
 #include <linux/numa.h>
 #include <linux/llist.h>
+#include <linux/cma.h>
 
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -44,6 +45,9 @@
 int hugetlb_max_hstate __read_mostly;
 unsigned int default_hstate_idx;
 struct hstate hstates[HUGE_MAX_HSTATE];
+
+static struct cma *hugetlb_cma[MAX_NUMNODES];
+
 /*
  * Minimum page order among possible hugepage sizes, set to a proper value
  * at boot time.
@@ -1020,6 +1024,14 @@ static void destroy_compound_gigantic_page(struct page *page,
 
 static void free_gigantic_page(struct page *page, unsigned int order)
 {
+	/*
+	 * If the page isn't allocated using the cma allocator,
+	 * cma_release() returns false.
+	 */
+	if (IS_ENABLED(CONFIG_CMA) &&
+	    cma_release(hugetlb_cma[page_to_nid(page)], page, 1 << order))
+		return;
+
 	free_contig_range(page_to_pfn(page), 1 << order);
 }
 
@@ -1029,6 +1041,21 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 {
 	unsigned long nr_pages = 1UL << huge_page_order(h);
 
+	if (IS_ENABLED(CONFIG_CMA)) {
+		struct page *page;
+		int node;
+
+		for_each_node_mask(node, *nodemask) {
+			if (!hugetlb_cma[node])
+				break;
+
+			page = cma_alloc(hugetlb_cma[node], nr_pages,
+					 huge_page_order(h), true);
+			if (page)
+				return page;
+		}
+	}
+
 	return alloc_contig_pages(nr_pages, gfp_mask, nid, nodemask);
 }
 
@@ -2190,6 +2217,10 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 
 	for (i = 0; i < h->max_huge_pages; ++i) {
 		if (hstate_is_gigantic(h)) {
+			if (IS_ENABLED(CONFIG_CMA) && hugetlb_cma[0]) {
+				pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip boot time allocation\n");
+				break;
+			}
 			if (!alloc_bootmem_huge_page(h))
 				break;
 		} else if (!alloc_pool_huge_page(h,
@@ -5073,3 +5104,70 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
 		spin_unlock(&hugetlb_lock);
 	}
 }
+
+#ifdef CONFIG_CMA
+static unsigned long hugetlb_cma_size __initdata;
+
+static int __init cmdline_parse_hugetlb_cma(char *p)
+{
+	hugetlb_cma_size = memparse(p, &p);
+	return 0;
+}
+
+early_param("hugetlb_cma", cmdline_parse_hugetlb_cma);
+
+void __init hugetlb_cma_reserve(int order)
+{
+	unsigned long size, reserved, per_node;
+	int nid;
+
+	if (!hugetlb_cma_size)
+		return;
+
+	if (hugetlb_cma_size < (PAGE_SIZE << order)) {
+		pr_warn("hugetlb_cma: cma area should be at least %lu MiB\n",
+			(PAGE_SIZE << order) / SZ_1M);
+		return;
+	}
+
+	/*
+	 * If 3 GB area is requested on a machine with 4 numa nodes,
+	 * let's allocate 1 GB on first three nodes and ignore the last one.
+	 */
+	per_node = DIV_ROUND_UP(hugetlb_cma_size, nr_online_nodes);
+	pr_info("hugetlb_cma: reserve %lu MiB, up to %lu MiB per node\n",
+		hugetlb_cma_size / SZ_1M, per_node / SZ_1M);
+
+	reserved = 0;
+	for_each_node_state(nid, N_ONLINE) {
+		int res;
+
+		size = min(per_node, hugetlb_cma_size - reserved);
+		size = round_up(size, PAGE_SIZE << order);
+		
+		
+#ifndef CONFIG_NUMA
+		nid = NUMA_NO_NODE
+#endif		
+		res = cma_declare_contiguous_nid(0, size,
+					     0, 
+					     PAGE_SIZE << order,
+					     0, false,
+					     "hugetlb", &hugetlb_cma[nid], nid);		
+
+		if (res) {
+			pr_warn("%s: reservation failed: err %d, node %d\n",
+				__func__, res, nid);
+			break;
+		}
+
+		reserved += size;
+		pr_info("hugetlb_cma: reserved %lu MiB on node %d\n",
+			size / SZ_1M, nid);
+
+		if (reserved >= hugetlb_cma_size)
+			break;
+	}
+}
+
+#endif /* CONFIG_CMA */
-- 
2.26.0

