Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D438FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89AB20739
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Dx5Br7VM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbgCKWJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:09:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44114 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729535AbgCKWJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:09:23 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02BM0eIY002720
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 15:09:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=xOsxMeB6xbKBUIfGFABLuhEYB5rReWtaCoUJRqO/ziw=;
 b=Dx5Br7VM7wKNHlgUvHaCmW49scWgCvstoLlZ9biSJonLoJI8jItVVOKf1JSRCu9hBXuh
 1X5GJArl11R395Th9y3bgtamu916rw7lx9nCzwZh/YW1cizWAC1+VZM8vm1jQKSGMr7l
 USYxqb21k9l4URNFngvRFdhT2MOoUKw/Xbc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yq5kf8wf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 15:09:22 -0700
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 11 Mar 2020 15:09:22 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id B6EDC36A2704F; Wed, 11 Mar 2020 15:09:21 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Andreas Schaufler <andreas.schaufler@gmx.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v3] mm: hugetlb: optionally allocate gigantic hugepages using cma 65;5803;1c Commit 944d9fec8d7a ("hugetlb: add support for gigantic page allocation at runtime") has added the run-time allocation of gigantic pages. However it actually works only at early stages of the system loading, when the majority of memory is free. After some time the memory gets fragmented by non-movable pages, so the chances to find a contiguous 1 GB block are getting close to zero. Even dropping caches manually doesn't help a lot.
Date:   Wed, 11 Mar 2020 15:09:20 -0700
Message-ID: <20200311220920.2487528-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-11_11:2020-03-11,2020-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=2
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110123
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At large scale rebooting servers in order to allocate gigantic hugepages
is quite expensive and complex. At the same time keeping some constant
percentage of memory in reserved hugepages even if the workload isn't
using it is a big waste: not all workloads can benefit from using 1 GB
pages.

The following solution can solve the problem:
1) On boot time a dedicated cma area* is reserved. The size is passed
   as a kernel argument.
2) Run-time allocations of gigantic hugepages are performed using the
   cma allocator and the dedicated cma area

In this case gigantic hugepages can be allocated successfully with a
high probability, however the memory isn't completely wasted if nobody
is using 1GB hugepages: it can be used for pagecache, anon memory,
THPs, etc.

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

v3:
  - added fallback to the existing allocation mechanism
  - added min/max checks
  - switched to MiB in debug output
  - removed percentage option
  - added arch-specific order argument to determine an alignment
  - added arm support
  - fixed the !CONFIG_HUGETLBFS build

  Thanks to Michal, Mike, Andreas and Rik for ideas and suggestions!

v2:
  -fixed !CONFIG_CMA build, suggested by Andrew Morton

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 .../admin-guide/kernel-parameters.txt         |   7 ++
 arch/arm64/mm/init.c                          |   6 +
 arch/x86/kernel/setup.c                       |   4 +
 include/linux/hugetlb.h                       |   8 ++
 mm/hugetlb.c                                  | 116 ++++++++++++++++++
 5 files changed, 141 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0c9894247015..9eb0df40643d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1452,6 +1452,13 @@
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
index 50480d16bd33..b831e9fa1a26 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -890,4 +890,12 @@ static inline spinlock_t *huge_pte_lock(struct hstate *h,
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
index 7fb31750e670..66bfc2bdc203 100644
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
@@ -1228,6 +1232,14 @@ static void destroy_compound_gigantic_page(struct page *page,
 
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
 
@@ -1237,6 +1249,21 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
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
 
@@ -2439,6 +2466,10 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 
 	for (i = 0; i < h->max_huge_pages; ++i) {
 		if (hstate_is_gigantic(h)) {
+			if (IS_ENABLED(CONFIG_CMA) && hugetlb_cma[0]) {
+				pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip boot time allocation\n");
+				break;
+			}
 			if (!alloc_bootmem_huge_page(h))
 				break;
 		} else if (!alloc_pool_huge_page(h,
@@ -5372,3 +5403,88 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
 		spin_unlock(&hugetlb_lock);
 	}
 }
+
+#ifdef CONFIG_CMA
+static unsigned long hugetlb_cma_size __initdata;
+
+static int __init cmdline_parse_hugetlb_cma(char *p)
+{
+	unsigned long long val;
+	char *endptr;
+
+	if (!p)
+		return -EINVAL;
+
+	val = simple_strtoull(p, &endptr, 0);
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
+		unsigned long start_pfn, end_pfn;
+		unsigned long min_pfn = 0, max_pfn = 0;
+		int res, i;
+
+		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
+			if (!min_pfn)
+				min_pfn = start_pfn;
+			max_pfn = end_pfn;
+		}
+
+		size = max(per_node, hugetlb_cma_size - reserved);
+		size = round_up(size, PAGE_SIZE << order);
+
+		if (size > ((max_pfn - min_pfn) << PAGE_SHIFT) / 2) {
+			pr_warn("hugetlb_cma: cma_area is too big, please try less than %lu MiB\n",
+				round_down(((max_pfn - min_pfn) << PAGE_SHIFT) *
+					   nr_online_nodes / 2 / SZ_1M,
+					   PAGE_SIZE << order));
+			break;
+		}
+
+		res = cma_declare_contiguous(PFN_PHYS(min_pfn), size,
+					     PFN_PHYS(max_pfn),
+					     PAGE_SIZE << order,
+					     0, false,
+					     "hugetlb", &hugetlb_cma[nid]);
+		if (res) {
+			pr_warn("hugetlb_cma: reservation failed: err %d, node %d, [%llu, %llu)",
+				res, nid, PFN_PHYS(min_pfn), PFN_PHYS(max_pfn));
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
2.24.1

