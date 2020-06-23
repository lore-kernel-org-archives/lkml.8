Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D423C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D2E620724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbgFWGWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:22:08 -0400
Received: from foss.arm.com ([217.140.110.172]:54270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730406AbgFWGWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:22:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A01A31B;
        Mon, 22 Jun 2020 23:22:07 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.81.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6B77E3F71E;
        Mon, 22 Jun 2020 23:22:03 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/hugetlb: Reserve CMA areas for gigantic pages on 16K and 64K configs
Date:   Tue, 23 Jun 2020 11:51:36 +0530
Message-Id: <1592893296-22040-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently 'hugetlb_cma=' command line argument does not create CMA area on
ARM64_16K_PAGES and ARM64_64K_PAGES based platforms. Instead, it just ends
up with the following warning message. Reason being, hugetlb_cma_reserve()
never gets called for these huge page sizes.

[   64.255669] hugetlb_cma: the option isn't supported by current arch

This enables CMA areas reservation on ARM64_16K_PAGES and ARM64_64K_PAGES
configs by defining an unified arm64_hugetlb_cma_reseve() that is wrapped
in CONFIG_CMA.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Barry Song <song.bao.hua@hisilicon.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Applies on 5.8-rc2.

 arch/arm64/include/asm/hugetlb.h |  8 ++++++++
 arch/arm64/mm/hugetlbpage.c      | 38 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/mm/init.c             |  4 +---
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 94ba0c5..8eea0e0 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -17,6 +17,14 @@
 extern bool arch_hugetlb_migration_supported(struct hstate *h);
 #endif
 
+#ifdef CONFIG_CMA
+void arm64_hugetlb_cma_reserve(void);
+#else
+static inline void arm64_hugetlb_cma_reserve(void)
+{
+}
+#endif
+
 static inline void arch_clear_hugepage_flags(struct page *page)
 {
 	clear_bit(PG_dcache_clean, &page->flags);
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 0a52ce4..ea7fb48 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -19,6 +19,44 @@
 #include <asm/tlbflush.h>
 #include <asm/pgalloc.h>
 
+/*
+ * HugeTLB Support Matrix
+ *
+ * ---------------------------------------------------
+ * | Page Size | CONT PTE |  PMD  | CONT PMD |  PUD  |
+ * ---------------------------------------------------
+ * |     4K    |   64K    |   2M  |    32M   |   1G  |
+ * |    16K    |    2M    |  32M  |     1G   |       |
+ * |    64K    |    2M    | 512M  |    16G   |       |
+ * ---------------------------------------------------
+ */
+
+/*
+ * Reserve CMA areas for the largest supported gigantic
+ * huge page when requested. Any other smaller gigantic
+ * huge pages could still be served from those areas.
+ */
+#ifdef CONFIG_CMA
+void __init arm64_hugetlb_cma_reserve(void)
+{
+	int order;
+
+#ifdef CONFIG_ARM64_4K_PAGES
+	order = PUD_SHIFT - PAGE_SHIFT;
+#else
+	order = CONT_PMD_SHIFT + PMD_SHIFT - PAGE_SHIFT;
+#endif
+	/*
+	 * HugeTLB CMA reservation is required for gigantic
+	 * huge pages which could not be allocated via the
+	 * page allocator. Just warn if there is any change
+	 * breaking this assumption.
+	 */
+	WARN_ON(order <= MAX_ORDER);
+	hugetlb_cma_reserve(order);
+}
+#endif /* CONFIG_CMA */
+
 #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
 bool arch_hugetlb_migration_supported(struct hstate *h)
 {
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 1e93cfc..fabf8b0 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -425,9 +425,7 @@ void __init bootmem_init(void)
 	 * initialize node_online_map that gets used in hugetlb_cma_reserve()
 	 * while allocating required CMA size across online nodes.
 	 */
-#ifdef CONFIG_ARM64_4K_PAGES
-	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
-#endif
+	arm64_hugetlb_cma_reserve();
 
 	/*
 	 * Sparsemem tries to allocate bootmem in memory_present(), so must be
-- 
2.7.4

