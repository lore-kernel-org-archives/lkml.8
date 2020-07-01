Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9418C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 04:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B26702073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 04:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgGAEmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 00:42:37 -0400
Received: from foss.arm.com ([217.140.110.172]:52518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725272AbgGAEmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 00:42:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53D6A30E;
        Tue, 30 Jun 2020 21:42:36 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.84.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 82C893F73C;
        Tue, 30 Jun 2020 21:42:24 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     robin.murphy@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3] arm64/hugetlb: Reserve CMA areas for gigantic pages on 16K and 64K configs
Date:   Wed,  1 Jul 2020 10:12:01 +0530
Message-Id: <1593578521-24672-1-git-send-email-anshuman.khandual@arm.com>
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
in CONFIG_CMA. Call site for arm64_hugetlb_cma_reserve() is also protected
as <asm/hugetlb.h> is conditionally included and hence cannot contain stub
for the inverse config i.e !(CONFIG_HUGETLB_PAGE && CONFIG_CMA).

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
Applies on 5.8-rc3.

Changes in V3:

- Dropped the stub, protected call site, moved the declaration to a header

Changes in V2: (https://patchwork.kernel.org/patch/11630503/)

- Moved arm64_hugetlb_cma_reserve() stub and declaration near call site

Changes in V1: (https://patchwork.kernel.org/patch/11619839/)

 arch/arm64/include/asm/hugetlb.h |  2 ++
 arch/arm64/mm/hugetlbpage.c      | 38 ++++++++++++++++++++++++++++++++
 arch/arm64/mm/init.c             |  4 ++--
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 94ba0c5bced2..5abf91e3494c 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -49,6 +49,8 @@ extern void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
 				 pte_t *ptep, pte_t pte, unsigned long sz);
 #define set_huge_swap_pte_at set_huge_swap_pte_at
 
+void __init arm64_hugetlb_cma_reserve(void);
+
 #include <asm-generic/hugetlb.h>
 
 #endif /* __ASM_HUGETLB_H */
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 0a52ce46f020..ea7fb48b8617 100644
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
index 1e93cfc7c47a..5f5665b9b026 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -425,8 +425,8 @@ void __init bootmem_init(void)
 	 * initialize node_online_map that gets used in hugetlb_cma_reserve()
 	 * while allocating required CMA size across online nodes.
 	 */
-#ifdef CONFIG_ARM64_4K_PAGES
-	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
+#if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_CMA)
+	arm64_hugetlb_cma_reserve();
 #endif
 
 	/*
-- 
2.20.1

