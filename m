Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A21C2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5BF920838
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="UKAxQ3og"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgC0RDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:03:55 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39440 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgC0RDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:03:55 -0400
Received: by mail-lj1-f196.google.com with SMTP id i20so10967853ljn.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 10:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iEb1i/1dam767tXvuNF7Sp30M1yJHeTtnfytL2XD9+0=;
        b=UKAxQ3oghy+KZvU5JfMJspP8dHawVw7uDcnn47JgJG7naaZjSSbK3N/IV1OHC4LJiD
         y4XVmBqPEg8SEU+wmheP20Xupt0JU5rP9FMo9KWUEmky3NsncP1TBOc1V6LAv+cNI2MW
         hOb0MWLTA0sCb2gN8xaaF7IKfrgbtHv1VBtgI5alO0NUxnDbF47pj8AwJI2tCqaQKrqL
         ET+rtMfzfCxvwusObnkT4M6ZrFUOdSnbXV35HKtvOZGbxcZ3UPExH9BpRUL4A67zVJDt
         tCST/F2usiNPzXp8GA33dK4aj0lB5usiYOYRV9iU/g5UYYCBdV9GZfhgIFp+uZ5VkzXk
         00xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iEb1i/1dam767tXvuNF7Sp30M1yJHeTtnfytL2XD9+0=;
        b=rNd0BKJWrEyst8LXFtnQdAbRoOFRFj7+VeU85ePBTFJNJh34Y60ygJtt6AXmqzqk4O
         Yvez1632CxOZhjxhHwU0c8MN8ziv+TzxVun97j2u17y7kW2rjur3n0iKoeC41RxUs2/c
         Cfmu/4bIOlICUdWg4LZXlmRPcfEH3n/11yceKt7sKPR2ZgucT5r/TK9VOqlGhYKYnVMF
         K7BrDO1GXkT2sOKT3hjLxsOkPU+IzPtRt0Y/Rvypw8qDgIZL41cksnn2pU7vKOyw3B9y
         XveLDdBPHHCGG6bIEUaLOrOLikn4ZKetNUNC9sLmINnTBKN5I5W4KtkjjFxAFsvLDeUd
         +bdA==
X-Gm-Message-State: ANhLgQ2Ehk9IbO1dpQNfATz6nSWoan7q+K6HQzDATbwdHbu8qdVj5wyn
        C9EZVGdiCb0DGfAL1lskhCXesw==
X-Google-Smtp-Source: ADFU+vsaOT1upNhaotWwn6axLPCq69xi3Z89C1aMdJzXgAdGhWzDJWqFhqI079xcIrBwzRY46uYzpw==
X-Received: by 2002:a2e:b6c2:: with SMTP id m2mr8958115ljo.72.1585328631545;
        Fri, 27 Mar 2020 10:03:51 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id j125sm2083865lfj.38.2020.03.27.10.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 10:03:50 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 8BD32100D24; Fri, 27 Mar 2020 20:03:54 +0300 (+03)
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] thp: Simplify splitting PMD mapping huge zero page
Date:   Fri, 27 Mar 2020 20:03:53 +0300
Message-Id: <20200327170353.17734-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Splitting PMD mapping huge zero page can be simplified a lot: we can
just unmap it and fallback to PTE handling.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/huge_memory.c | 57 ++++--------------------------------------------
 1 file changed, 4 insertions(+), 53 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 42407e16bd80..ef6a6bcb291f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2114,40 +2114,6 @@ void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
 }
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 
-static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
-		unsigned long haddr, pmd_t *pmd)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	pgtable_t pgtable;
-	pmd_t _pmd;
-	int i;
-
-	/*
-	 * Leave pmd empty until pte is filled note that it is fine to delay
-	 * notification until mmu_notifier_invalidate_range_end() as we are
-	 * replacing a zero pmd write protected page with a zero pte write
-	 * protected page.
-	 *
-	 * See Documentation/vm/mmu_notifier.rst
-	 */
-	pmdp_huge_clear_flush(vma, haddr, pmd);
-
-	pgtable = pgtable_trans_huge_withdraw(mm, pmd);
-	pmd_populate(mm, &_pmd, pgtable);
-
-	for (i = 0; i < HPAGE_PMD_NR; i++, haddr += PAGE_SIZE) {
-		pte_t *pte, entry;
-		entry = pfn_pte(my_zero_pfn(haddr), vma->vm_page_prot);
-		entry = pte_mkspecial(entry);
-		pte = pte_offset_map(&_pmd, haddr);
-		VM_BUG_ON(!pte_none(*pte));
-		set_pte_at(mm, haddr, pte, entry);
-		pte_unmap(pte);
-	}
-	smp_wmb(); /* make pte visible before pmd */
-	pmd_populate(mm, pmd, pgtable);
-}
-
 static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long haddr, bool freeze)
 {
@@ -2167,7 +2133,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 
 	count_vm_event(THP_SPLIT_PMD);
 
-	if (!vma_is_anonymous(vma)) {
+	if (!vma_is_anonymous(vma) || is_huge_zero_pmd(*pmd)) {
 		_pmd = pmdp_huge_clear_flush_notify(vma, haddr, pmd);
 		/*
 		 * We are going to unmap this huge page. So
@@ -2175,7 +2141,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		 */
 		if (arch_needs_pgtable_deposit())
 			zap_deposited_table(mm, pmd);
-		if (vma_is_dax(vma))
+		if (vma_is_dax(vma) || is_huge_zero_pmd(*pmd))
 			return;
 		page = pmd_page(_pmd);
 		if (!PageDirty(page) && pmd_dirty(_pmd))
@@ -2186,17 +2152,6 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		put_page(page);
 		add_mm_counter(mm, mm_counter_file(page), -HPAGE_PMD_NR);
 		return;
-	} else if (is_huge_zero_pmd(*pmd)) {
-		/*
-		 * FIXME: Do we want to invalidate secondary mmu by calling
-		 * mmu_notifier_invalidate_range() see comments below inside
-		 * __split_huge_pmd() ?
-		 *
-		 * We are going from a zero huge page write protected to zero
-		 * small page also write protected so it does not seems useful
-		 * to invalidate secondary mmu at this time.
-		 */
-		return __split_huge_zero_page_pmd(vma, haddr, pmd);
 	}
 
 	/*
@@ -2339,13 +2294,9 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 	spin_unlock(ptl);
 	/*
 	 * No need to double call mmu_notifier->invalidate_range() callback.
-	 * They are 3 cases to consider inside __split_huge_pmd_locked():
+	 * They are 2 cases to consider inside __split_huge_pmd_locked():
 	 *  1) pmdp_huge_clear_flush_notify() call invalidate_range() obvious
-	 *  2) __split_huge_zero_page_pmd() read only zero page and any write
-	 *    fault will trigger a flush_notify before pointing to a new page
-	 *    (it is fine if the secondary mmu keeps pointing to the old zero
-	 *    page in the meantime)
-	 *  3) Split a huge pmd into pte pointing to the same page. No need
+	 *  2) Split a huge pmd into pte pointing to the same page. No need
 	 *     to invalidate secondary tlb entry they are all still valid.
 	 *     any further changes to individual pte will notify. So no need
 	 *     to call mmu_notifier->invalidate_range()
-- 
2.26.0

