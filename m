Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A738C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 19:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F936206F6
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 19:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K6DX5GPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgHBTPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 15:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbgHBTP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 15:15:28 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23853C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 12:15:28 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id v22so20873042qtq.8
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 12:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=vS2vRaAkTGnixX4BAai/gTgrBST/TBnGGZjBlA+esRM=;
        b=K6DX5GPY7IwFkwoiAtoKOSRoll93bYubZeIiKxw2JkhpEdiYJB3ukMFh4bwKlnAI5d
         3bWVaO1GfbcgKcbEPO/iaOe/lpYwEXle+qXkfVVjbn4FinRbBlJ4/tMNSSyHa4xgNQFK
         1RxgS8AHoTQZuP7Ym8hqrJ7z2TK629wsZmm2aC30AmeQnN0ieHljT3+/cWlsZsSqux9e
         B0HO9ftXRfak9vVy/RAABHVYUmODca0qa+x4SFVyAJxTP8u02TB21ZR89CZfXsHSgVzc
         eGybkcotEcctEsUZvgR1zoeSBBo7/C+C7S7lTVVFykzGZMF6FCaqwerxfjQCwMg48I/Z
         /+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=vS2vRaAkTGnixX4BAai/gTgrBST/TBnGGZjBlA+esRM=;
        b=ODcZqJA0QhDNJj8G35UaWx0EnetyA8AaaHZSGpdPoBLf68ZgaMxBMgHXDZYfwQqePT
         vnNxN1U8aDe49tVL9ThD+ixmkRuSryrt5N1gZX5BWGZaZapVqieI+ZZ1IVTk1AXESVBx
         dB27SrjHh4tTaNkGMz9I9RRWAU6ZyJWPbHAbW8aEyvRoJwtn/D6ZFkk+Ona+NwVaqrcv
         IWHGGXlR4ctzA3UHhNPMP8SUOrGsVRPfMFJTzXBgyhaf5OeB/RJ7ulwtMeINIqJ9Mc6H
         osDVnl4c3geYgYHYYTnKas7CktqQ4c0rRdr42+oThnCdvP+QudFj2DssNWmbqS1LLQpC
         UyKQ==
X-Gm-Message-State: AOAM533el/aixEhKQn1+/ARmmVSNGPjCJNhOxT+BcuRZz/8wqaA8tx/l
        a3seHS7mj6uTUTJ3hlhd+kjnDQ==
X-Google-Smtp-Source: ABdhPJzRb+C23fUu3f4LTU7NLJtGziasQnCgIc5ixpWKAjMGf7iooXhSpgv+oeeEQ9QVKsVgGRpEJg==
X-Received: by 2002:ac8:24d9:: with SMTP id t25mr13778535qtt.15.1596395727021;
        Sun, 02 Aug 2020 12:15:27 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l11sm18727086qti.59.2020.08.02.12.15.25
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 02 Aug 2020 12:15:26 -0700 (PDT)
Date:   Sun, 2 Aug 2020 12:15:24 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] khugepaged: collapse_pte_mapped_thp() protect the pmd lock
In-Reply-To: <alpine.LSU.2.11.2008021204390.27773@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2008021213070.27773@eggly.anvils>
References: <alpine.LSU.2.11.2008021204390.27773@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When retract_page_tables() removes a page table to make way for a huge
pmd, it holds huge page lock, i_mmap_lock_write, mmap_write_trylock and
pmd lock; but when collapse_pte_mapped_thp() does the same (to handle
the case when the original mmap_write_trylock had failed), only
mmap_write_trylock and pmd lock are held.

That's not enough.  One machine has twice crashed under load, with
"BUG: spinlock bad magic" and GPF on 6b6b6b6b6b6b6b6b.  Examining the
second crash, page_vma_mapped_walk_done()'s spin_unlock of pvmw->ptl
(serving page_referenced() on a file THP, that had found a page table
at *pmd) discovers that the page table page and its lock have already
been freed by the time it comes to unlock.

Follow the example of retract_page_tables(), but we only need one of
huge page lock or i_mmap_lock_write to secure against this: because it's
the narrower lock, and because it simplifies collapse_pte_mapped_thp()
to know the hpage earlier, choose to rely on huge page lock here.

Fixes: 27e1f8273113 ("khugepaged: enable collapse pmd for pte-mapped THP")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: stable@vger.kernel.org # v5.4+
---

 mm/khugepaged.c |   44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

--- 5.8-rc7/mm/khugepaged.c	2020-07-26 16:58:02.189038680 -0700
+++ linux/mm/khugepaged.c	2020-08-02 10:51:02.127688808 -0700
@@ -1412,7 +1412,7 @@ void collapse_pte_mapped_thp(struct mm_s
 {
 	unsigned long haddr = addr & HPAGE_PMD_MASK;
 	struct vm_area_struct *vma = find_vma(mm, haddr);
-	struct page *hpage = NULL;
+	struct page *hpage;
 	pte_t *start_pte, *pte;
 	pmd_t *pmd, _pmd;
 	spinlock_t *ptl;
@@ -1432,9 +1432,17 @@ void collapse_pte_mapped_thp(struct mm_s
 	if (!hugepage_vma_check(vma, vma->vm_flags | VM_HUGEPAGE))
 		return;
 
+	hpage = find_lock_page(vma->vm_file->f_mapping,
+			       linear_page_index(vma, haddr));
+	if (!hpage)
+		return;
+
+	if (!PageHead(hpage))
+		goto drop_hpage;
+
 	pmd = mm_find_pmd(mm, haddr);
 	if (!pmd)
-		return;
+		goto drop_hpage;
 
 	start_pte = pte_offset_map_lock(mm, pmd, haddr, &ptl);
 
@@ -1453,30 +1461,11 @@ void collapse_pte_mapped_thp(struct mm_s
 
 		page = vm_normal_page(vma, addr, *pte);
 
-		if (!page || !PageCompound(page))
-			goto abort;
-
-		if (!hpage) {
-			hpage = compound_head(page);
-			/*
-			 * The mapping of the THP should not change.
-			 *
-			 * Note that uprobe, debugger, or MAP_PRIVATE may
-			 * change the page table, but the new page will
-			 * not pass PageCompound() check.
-			 */
-			if (WARN_ON(hpage->mapping != vma->vm_file->f_mapping))
-				goto abort;
-		}
-
 		/*
-		 * Confirm the page maps to the correct subpage.
-		 *
-		 * Note that uprobe, debugger, or MAP_PRIVATE may change
-		 * the page table, but the new page will not pass
-		 * PageCompound() check.
+		 * Note that uprobe, debugger, or MAP_PRIVATE may change the
+		 * page table, but the new page will not be a subpage of hpage.
 		 */
-		if (WARN_ON(hpage + i != page))
+		if (hpage + i != page)
 			goto abort;
 		count++;
 	}
@@ -1495,7 +1484,7 @@ void collapse_pte_mapped_thp(struct mm_s
 	pte_unmap_unlock(start_pte, ptl);
 
 	/* step 3: set proper refcount and mm_counters. */
-	if (hpage) {
+	if (count) {
 		page_ref_sub(hpage, count);
 		add_mm_counter(vma->vm_mm, mm_counter_file(hpage), -count);
 	}
@@ -1506,10 +1495,15 @@ void collapse_pte_mapped_thp(struct mm_s
 	spin_unlock(ptl);
 	mm_dec_nr_ptes(mm);
 	pte_free(mm, pmd_pgtable(_pmd));
+
+drop_hpage:
+	unlock_page(hpage);
+	put_page(hpage);
 	return;
 
 abort:
 	pte_unmap_unlock(start_pte, ptl);
+	goto drop_hpage;
 }
 
 static int khugepaged_collapse_pte_mapped_thps(struct mm_slot *mm_slot)
