Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7527C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B3032083B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="UPUzl0b8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="idZ69wOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgIBSHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:07:52 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60579 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727949AbgIBSGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:06:43 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0E0A85C016C;
        Wed,  2 Sep 2020 14:06:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 02 Sep 2020 14:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=z/QjPKfyJw+jN
        wp1dt2Sd4gqN+oJ4ARlb6FmyazN+3o=; b=UPUzl0b8ylt7A/Q4qNv5AkVQikCYz
        R+8ftNfuoYYpCrWnblBYhzHz/NSaqTQvfae5fqjUFarDKmKwMMhYhzbSO1iBLbve
        C3OruCDsj4T+Q99RMKcFZuplhyzJ5n2vlvSyZGeqqKGErM5MQIrS3TVwSSXhHJm/
        5KgypYQecNOLDL51BcenM+EkIFXVatutWGrLiXICH0IQy+5Zt71rvsU7BRt4KfjG
        gNNPzdhQJBPLF9tXhkjtLx77JoZfWSP8+NNkkNlltBjkMWhJzJGxnnm8vA6E64sl
        LOTcDo5U49aFdwkLmwx7iHevALTCAXwslY+5nv6uI8AmhnBAlQX6vbhZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=z/QjPKfyJw+jNwp1dt2Sd4gqN+oJ4ARlb6FmyazN+3o=; b=idZ69wOS
        5rl1TfFPc8QE7dt/ilcmplHQEq6ztHpUDf2l1bojIFlNoECIWDSJYuiu0lOP00XZ
        0RHy+3xBSoo2eQrAPxHosyMUcYtwOeU3zmShZqzqEQ48uibRpltnsIRumjucquWr
        ltlRa1bdue7XI3CCfHHGHejudDeDcEMke0jpx+i7kcr6hK0qf1Vdh82CNMeb34o9
        SCbIcPbqw3OAxSSK7qB4SPTSiT6pn/iPzJaD/toZwIGlgA9UxYHRH9YwNdAZcIqY
        PMCPE/fXXrGD7uVs5a0oyQ66FPvBsT8K38pbPWTCQkpwncybqoBzBkYp6iWiwmjE
        +5TQuBBbHsB06w==
X-ME-Sender: <xms:Kt9PX1JwMUjDJxIse_8dGk56WpZLmUZOBiGicOpQsl3vh8za8WfLbQ>
    <xme:Kt9PXxKbhBdtJmT6PLVU5lvJyjdV2dPXvpIVcomcJlpCBZxs4T7h5IpSXYwkomImo
    aw6OdXPLZsrT5hAKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhf
    ffveektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphep
    uddvrdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpeduvdenucfrrghrrg
    hmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:Kt9PX9uKwK77cgo8fGjQbU6XolfKLb4bmTQwzLFJoB1U1Baw0rrxdw>
    <xmx:Kt9PX2ZNg5U-5_6LkweofOFCmlk9LCE9ZKjWK3i2FLWKSpnJO6BGEQ>
    <xmx:Kt9PX8Zcvaq1pusJO6YpN8ClO6Q0Ib_PMjPlBjHmxJCGY99RBoIGJA>
    <xmx:K99PX84Nc_gaCaiCMj0wT5IyBhR9PWiDRHavPqrT3uBk9rZbDcYMgA>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5017E30600B7;
        Wed,  2 Sep 2020 14:06:34 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>
Cc:     Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 15/16] hugetlb: cma: move cma reserve function to cma.c.
Date:   Wed,  2 Sep 2020 14:06:27 -0400
Message-Id: <20200902180628.4052244-16-zi.yan@sent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902180628.4052244-1-zi.yan@sent.com>
References: <20200902180628.4052244-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

It will be used by other allocations, like 1GB THP allocation in the
upcoming commit.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 .../admin-guide/kernel-parameters.txt         |  2 +-
 arch/arm64/mm/hugetlbpage.c                   |  2 +-
 arch/powerpc/mm/hugetlbpage.c                 |  2 +-
 arch/x86/kernel/setup.c                       |  8 +-
 include/linux/cma.h                           | 15 ++++
 include/linux/hugetlb.h                       | 12 ---
 mm/cma.c                                      | 88 +++++++++++++++++++
 mm/hugetlb.c                                  | 88 ++-----------------
 8 files changed, 118 insertions(+), 99 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 68fee5e034ca..600668ee0ac7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1507,7 +1507,7 @@
 	hpet_mmap=	[X86, HPET_MMAP] Allow userspace to mmap HPET
 			registers.  Default set by CONFIG_HPET_MMAP_DEFAULT.
 
-	hugetlb_cma=	[HW] The size of a cma area used for allocation
+	hugepage_cma=	[HW] The size of a cma area used for allocation
 			of gigantic hugepages.
 			Format: nn[KMGTPE]
 
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 55ecf6de9ff7..8a3ad7eaae49 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -52,7 +52,7 @@ void __init arm64_hugetlb_cma_reserve(void)
 	 * breaking this assumption.
 	 */
 	WARN_ON(order <= MAX_ORDER);
-	hugetlb_cma_reserve(order);
+	hugepage_cma_reserve(order);
 }
 #endif /* CONFIG_CMA */
 
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 26292544630f..d608e58cb69b 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -699,6 +699,6 @@ void __init gigantic_hugetlb_cma_reserve(void)
 
 	if (order) {
 		VM_WARN_ON(order < MAX_ORDER);
-		hugetlb_cma_reserve(order);
+		hugepage_cma_reserve(order);
 	}
 }
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 52e83ba607b3..93c8fbdff972 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -16,7 +16,7 @@
 #include <linux/pci.h>
 #include <linux/root_dev.h>
 #include <linux/sfi.h>
-#include <linux/hugetlb.h>
+#include <linux/cma.h>
 #include <linux/tboot.h>
 #include <linux/usb/xhci-dbgp.h>
 
@@ -640,7 +640,7 @@ static void __init trim_snb_memory(void)
 	 * already been reserved.
 	 */
 	memblock_reserve(0, 1<<20);
-	
+
 	for (i = 0; i < ARRAY_SIZE(bad_pages); i++) {
 		if (memblock_reserve(bad_pages[i], PAGE_SIZE))
 			printk(KERN_WARNING "failed to reserve 0x%08lx\n",
@@ -732,7 +732,7 @@ static void __init trim_low_memory_range(void)
 {
 	memblock_reserve(0, ALIGN(reserve_low, PAGE_SIZE));
 }
-	
+
 /*
  * Dump out kernel offset information on panic.
  */
@@ -1142,7 +1142,7 @@ void __init setup_arch(char **cmdline_p)
 	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
 
 	if (boot_cpu_has(X86_FEATURE_GBPAGES))
-		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
+		hugepage_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
 
 	/*
 	 * Reserve memory for crash kernel after SRAT is parsed so that it
diff --git a/include/linux/cma.h b/include/linux/cma.h
index 6ff79fefd01f..abcf7ab712f9 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -47,4 +47,19 @@ extern struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 extern bool cma_release(struct cma *cma, const struct page *pages, unsigned int count);
 
 extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data);
+
+extern void cma_reserve(int min_order, unsigned long requested_size,
+			const char *name, struct cma *cma_struct[N_MEMORY]);
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
+extern void __init hugepage_cma_reserve(int order);
+extern void __init hugepage_cma_check(void);
+#else
+static inline void __init hugepage_cma_check(void)
+{
+}
+static inline void __init hugepage_cma_reserve(int order)
+{
+}
+#endif
+
 #endif
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d5cc5f802dd4..087d13a1dc24 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -935,16 +935,4 @@ static inline spinlock_t *huge_pte_lock(struct hstate *h,
 	return ptl;
 }
 
-#if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_CMA)
-extern void __init hugetlb_cma_reserve(int order);
-extern void __init hugetlb_cma_check(void);
-#else
-static inline __init void hugetlb_cma_reserve(int order)
-{
-}
-static inline __init void hugetlb_cma_check(void)
-{
-}
-#endif
-
 #endif /* _LINUX_HUGETLB_H */
diff --git a/mm/cma.c b/mm/cma.c
index 7f415d7cda9f..aa3a17d8a191 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -37,6 +37,10 @@
 #include "cma.h"
 
 struct cma cma_areas[MAX_CMA_AREAS];
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
+struct cma *hugepage_cma[MAX_NUMNODES];
+#endif
+unsigned long hugepage_cma_size __initdata;
 unsigned cma_area_count;
 static DEFINE_MUTEX(cma_mutex);
 
@@ -541,3 +545,87 @@ int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
 
 	return 0;
 }
+
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
+/*
+ * cma_reserve() - reserve CMA for gigantic pages on nodes with memory
+ *
+ * must be called after free_area_init() that updates N_MEMORY via node_set_state().
+ * cma_reserve() scans over N_MEMORY nodemask and hence expects the platforms
+ * to have initialized N_MEMORY state.
+ */
+void __init cma_reserve(int min_order, unsigned long requested_size, const char *name,
+		 struct cma *cma_struct[MAX_NUMNODES])
+{
+	unsigned long size, reserved, per_node;
+	int nid;
+
+	if (!requested_size)
+		return;
+
+	if (requested_size < (PAGE_SIZE << min_order)) {
+		pr_warn("%s_cma: cma area should be at least %lu MiB\n",
+			name, (PAGE_SIZE << min_order) / SZ_1M);
+		return;
+	}
+
+	/*
+	 * If 3 GB area is requested on a machine with 4 numa nodes,
+	 * let's allocate 1 GB on first three nodes and ignore the last one.
+	 */
+	per_node = DIV_ROUND_UP(requested_size, nr_online_nodes);
+	pr_info("%s_cma: reserve %lu MiB, up to %lu MiB per node\n",
+		name, requested_size / SZ_1M, per_node / SZ_1M);
+
+	reserved = 0;
+	for_each_node_state(nid, N_ONLINE) {
+		int res;
+		char node_name[20];
+
+		size = min(per_node, requested_size - reserved);
+		size = round_up(size, PAGE_SIZE << min_order);
+
+		snprintf(node_name, 20, "%s%d", name, nid);
+		res = cma_declare_contiguous_nid(0, size, 0,
+						 PAGE_SIZE << min_order,
+						 0, false, node_name,
+						 &cma_struct[nid], nid);
+		if (res) {
+			pr_warn("%s_cma: reservation failed: err %d, node %d",
+				name, res, nid);
+			continue;
+		}
+
+		reserved += size;
+		pr_info("%s_cma: reserved %lu MiB on node %d\n",
+			name, size / SZ_1M, nid);
+
+		if (reserved >= requested_size)
+			break;
+	}
+}
+
+static bool hugepage_cma_reserve_called __initdata;
+
+static int __init cmdline_parse_hugepage_cma(char *p)
+{
+	hugepage_cma_size = memparse(p, &p);
+	return 0;
+}
+
+early_param("hugepage_cma", cmdline_parse_hugepage_cma);
+
+void __init hugepage_cma_reserve(int order)
+{
+	hugepage_cma_reserve_called = true;
+	cma_reserve(order, hugepage_cma_size, "hugepage", hugepage_cma);
+}
+
+void __init hugepage_cma_check(void)
+{
+	if (!hugepage_cma_size || hugepage_cma_reserve_called)
+		return;
+
+	pr_warn("hugepage_cma: the option isn't supported by current arch\n");
+}
+#endif
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d5357778b026..6685cad879d0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -48,9 +48,9 @@ unsigned int default_hstate_idx;
 struct hstate hstates[HUGE_MAX_HSTATE];
 
 #ifdef CONFIG_CMA
-static struct cma *hugetlb_cma[MAX_NUMNODES];
+extern struct cma *hugepage_cma[MAX_NUMNODES];
 #endif
-static unsigned long hugetlb_cma_size __initdata;
+extern unsigned long hugepage_cma_size __initdata;
 
 /*
  * Minimum page order among possible hugepage sizes, set to a proper value
@@ -1218,7 +1218,7 @@ static void free_gigantic_page(struct page *page, unsigned int order)
 	 * cma_release() returns false.
 	 */
 #ifdef CONFIG_CMA
-	if (cma_release(hugetlb_cma[page_to_nid(page)], page, 1 << order))
+	if (cma_release(hugepage_cma[page_to_nid(page)], page, 1 << order))
 		return;
 #endif
 
@@ -1237,10 +1237,10 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
 		int node;
 
 		for_each_node_mask(node, *nodemask) {
-			if (!hugetlb_cma[node])
+			if (!hugepage_cma[node])
 				continue;
 
-			page = cma_alloc(hugetlb_cma[node], nr_pages,
+			page = cma_alloc(hugepage_cma[node], nr_pages,
 					 huge_page_order(h), true);
 			if (page)
 				return page;
@@ -2532,8 +2532,8 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 
 	for (i = 0; i < h->max_huge_pages; ++i) {
 		if (hstate_is_gigantic(h)) {
-			if (hugetlb_cma_size) {
-				pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip boot time allocation\n");
+			if (hugepage_cma_size) {
+				pr_warn_once("HugeTLB: hugepage_cma is enabled, skip boot time allocation\n");
 				break;
 			}
 			if (!alloc_bootmem_huge_page(h))
@@ -3209,7 +3209,7 @@ static int __init hugetlb_init(void)
 		}
 	}
 
-	hugetlb_cma_check();
+	hugepage_cma_check();
 	hugetlb_init_hstates();
 	gather_bootmem_prealloc();
 	report_hugepages();
@@ -5622,75 +5622,3 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
 		spin_unlock(&hugetlb_lock);
 	}
 }
-
-#ifdef CONFIG_CMA
-static bool cma_reserve_called __initdata;
-
-static int __init cmdline_parse_hugetlb_cma(char *p)
-{
-	hugetlb_cma_size = memparse(p, &p);
-	return 0;
-}
-
-early_param("hugetlb_cma", cmdline_parse_hugetlb_cma);
-
-void __init hugetlb_cma_reserve(int order)
-{
-	unsigned long size, reserved, per_node;
-	int nid;
-
-	cma_reserve_called = true;
-
-	if (!hugetlb_cma_size)
-		return;
-
-	if (hugetlb_cma_size < (PAGE_SIZE << order)) {
-		pr_warn("hugetlb_cma: cma area should be at least %lu MiB\n",
-			(PAGE_SIZE << order) / SZ_1M);
-		return;
-	}
-
-	/*
-	 * If 3 GB area is requested on a machine with 4 numa nodes,
-	 * let's allocate 1 GB on first three nodes and ignore the last one.
-	 */
-	per_node = DIV_ROUND_UP(hugetlb_cma_size, nr_online_nodes);
-	pr_info("hugetlb_cma: reserve %lu MiB, up to %lu MiB per node\n",
-		hugetlb_cma_size / SZ_1M, per_node / SZ_1M);
-
-	reserved = 0;
-	for_each_node_state(nid, N_ONLINE) {
-		int res;
-		char name[20];
-
-		size = min(per_node, hugetlb_cma_size - reserved);
-		size = round_up(size, PAGE_SIZE << order);
-
-		snprintf(name, 20, "hugetlb%d", nid);
-		res = cma_declare_contiguous_nid(0, size, 0, PAGE_SIZE << order,
-						 0, false, name,
-						 &hugetlb_cma[nid], nid);
-		if (res) {
-			pr_warn("hugetlb_cma: reservation failed: err %d, node %d",
-				res, nid);
-			continue;
-		}
-
-		reserved += size;
-		pr_info("hugetlb_cma: reserved %lu MiB on node %d\n",
-			size / SZ_1M, nid);
-
-		if (reserved >= hugetlb_cma_size)
-			break;
-	}
-}
-
-void __init hugetlb_cma_check(void)
-{
-	if (!hugetlb_cma_size || cma_reserve_called)
-		return;
-
-	pr_warn("hugetlb_cma: the option isn't supported by current arch\n");
-}
-
-#endif /* CONFIG_CMA */
-- 
2.28.0

