Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48CAC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 03:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94BB720746
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 03:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgEHDIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 23:08:51 -0400
Received: from foss.arm.com ([217.140.110.172]:42492 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbgEHDIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 23:08:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95EAB31B;
        Thu,  7 May 2020 20:08:49 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.73.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5E0B13F305;
        Thu,  7 May 2020 20:08:47 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/3] arm64/mm: Drop __HAVE_ARCH_HUGE_PTEP_GET
Date:   Fri,  8 May 2020 08:37:49 +0530
Message-Id: <1588907271-11920-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588907271-11920-1-git-send-email-anshuman.khandual@arm.com>
References: <1588907271-11920-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform specific huge_ptep_get() is required only when fetching the huge
PTE involves more than just dereferencing the page table pointer. This is
not the case on arm64 platform. Hence huge_ptep_pte() can be dropped along
with it's __HAVE_ARCH_HUGE_PTEP_GET subscription. Before that, it updates
the generic huge_ptep_get() with READ_ONCE() which will prevent known page
table issues with THP on arm64.

https://lore.kernel.org/r/1506527369-19535-1-git-send-email-will.deacon@arm.com/

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/hugetlb.h | 6 ------
 include/asm-generic/hugetlb.h    | 2 +-
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 2eb6c234d594..b88878ddc88b 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -17,12 +17,6 @@
 extern bool arch_hugetlb_migration_supported(struct hstate *h);
 #endif
 
-#define __HAVE_ARCH_HUGE_PTEP_GET
-static inline pte_t huge_ptep_get(pte_t *ptep)
-{
-	return READ_ONCE(*ptep);
-}
-
 static inline int is_hugepage_only_range(struct mm_struct *mm,
 					 unsigned long addr, unsigned long len)
 {
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 822f433ac95c..40f85decc2ee 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -122,7 +122,7 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 #ifndef __HAVE_ARCH_HUGE_PTEP_GET
 static inline pte_t huge_ptep_get(pte_t *ptep)
 {
-	return *ptep;
+	return READ_ONCE(*ptep);
 }
 #endif
 
-- 
2.20.1

