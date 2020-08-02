Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC92C433E3
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 19:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1734F2086A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 19:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="skZxXq54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgHBTQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 15:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgHBTQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 15:16:57 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9B6C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 12:16:57 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id s16so26784308qtn.7
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 12:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=wynZ9zIDAE/hK/2qRtBgXqgR/4DY/aRh94k5GpXzQlM=;
        b=skZxXq54gBYMDReRoAFvzjlJQMgazo+he7aVO9uXOp+HJWgWqTcPzm4esfVXrKoe6B
         T2NOVM98IlcbT2rqdb4muE+pylAfQHa6W7AbnQezwLn/4UBSgc28Fq05wM0H3WuJavEB
         N1EGdjBVUZI+6+GOQJHWHNm6OHKF7PAVIH7/qkmqWXL2rFVqRm/98nFd9RGCUDvqHPiX
         tLbhejfnu6UB0D9J37sOISArT/ig0SrMk4OkSVRaT/+t2PmwObr46QWiPPomBi1M0tCD
         eGkxRuqY4RRm0HjbXdCc+nFOWEQecxYaQumPhK/Q4I5g0DZTaX/D3cf5H3yf3ARP88Ns
         9y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=wynZ9zIDAE/hK/2qRtBgXqgR/4DY/aRh94k5GpXzQlM=;
        b=QgOqjg8ZHnAWIM3k6tSvbcjQXb4EZ/fFDBhnhbP/6WS/rCjGj6Q2DDqYMqf+LrldJc
         GBsZWQzEGMhcZ599eKLhBwR3wrWlxKBcXA0mAlDEGoZMKoBDz9zK52XE2GU8V4P2rDtB
         Tz8uBykm3rRzSXrlLnoL1oHfDsY65+OI8OCi9BsK9qHG3xJ9egXqFu/8hK0POtg2v8H7
         WzAtu/qHxfobvL2ovyUwDX0zVM9W/EEzXsFcjjes0651fTx5sUO2AfckUITpjfPLkDzz
         nGG3RZAnJAK0fLtrQvjSueT2KASbnFpSgd7fCGBd75r5Puph6Ll6VrM5/9/VoHpc2YEv
         s0Cw==
X-Gm-Message-State: AOAM532E5xqdw7ANoU9bCGN0BIMO7glBBs2uAktqj1YugBXkyBBwzISR
        ytTWuRlv+KYQldJZevo5q/qufg==
X-Google-Smtp-Source: ABdhPJwfwVY08GwUjd/rgvaHaGv+O8c3N9g5P+qpYC1MQ4+3Mj1k9RTVsD1nA95F1RjtX3WwvID/YA==
X-Received: by 2002:ac8:450c:: with SMTP id q12mr13267601qtn.292.1596395816642;
        Sun, 02 Aug 2020 12:16:56 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m3sm17486113qka.31.2020.08.02.12.16.54
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 02 Aug 2020 12:16:55 -0700 (PDT)
Date:   Sun, 2 Aug 2020 12:16:53 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] khugepaged: retract_page_tables() remember to test exit
In-Reply-To: <alpine.LSU.2.11.2008021204390.27773@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2008021215400.27773@eggly.anvils>
References: <alpine.LSU.2.11.2008021204390.27773@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only once have I seen this scenario (and forgot even to notice what
forced the eventual crash): a sequence of "BUG: Bad page map" alerts
from vm_normal_page(), from zap_pte_range() servicing exit_mmap();
pmd:00000000, pte values corresponding to data in physical page 0.

The pte mappings being zapped in this case were supposed to be from a
huge page of ext4 text (but could as well have been shmem): my belief
is that it was racing with collapse_file()'s retract_page_tables(),
found *pmd pointing to a page table, locked it, but *pmd had become
0 by the time start_pte was decided.

In most cases, that possibility is excluded by holding mmap lock;
but exit_mmap() proceeds without mmap lock.  Most of what's run by
khugepaged checks khugepaged_test_exit() after acquiring mmap lock:
khugepaged_collapse_pte_mapped_thps() and hugepage_vma_revalidate()
do so, for example.  But retract_page_tables() did not: fix that
(using an mm variable instead of vma->vm_mm repeatedly).

Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: stable@vger.kernel.org # v4.8+
---

 mm/khugepaged.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

--- 5.8-rc7/mm/khugepaged.c	2020-07-26 16:58:02.189038680 -0700
+++ linux/mm/khugepaged.c	2020-08-02 10:53:37.892660983 -0700
@@ -1538,6 +1538,7 @@ out:
 static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 {
 	struct vm_area_struct *vma;
+	struct mm_struct *mm;
 	unsigned long addr;
 	pmd_t *pmd, _pmd;
 
@@ -1566,7 +1567,8 @@ static void retract_page_tables(struct a
 			continue;
 		if (vma->vm_end < addr + HPAGE_PMD_SIZE)
 			continue;
-		pmd = mm_find_pmd(vma->vm_mm, addr);
+		mm = vma->vm_mm;
+		pmd = mm_find_pmd(mm, addr);
 		if (!pmd)
 			continue;
 		/*
@@ -1576,17 +1578,19 @@ static void retract_page_tables(struct a
 		 * mmap_lock while holding page lock. Fault path does it in
 		 * reverse order. Trylock is a way to avoid deadlock.
 		 */
-		if (mmap_write_trylock(vma->vm_mm)) {
-			spinlock_t *ptl = pmd_lock(vma->vm_mm, pmd);
-			/* assume page table is clear */
-			_pmd = pmdp_collapse_flush(vma, addr, pmd);
-			spin_unlock(ptl);
-			mmap_write_unlock(vma->vm_mm);
-			mm_dec_nr_ptes(vma->vm_mm);
-			pte_free(vma->vm_mm, pmd_pgtable(_pmd));
+		if (mmap_write_trylock(mm)) {
+			if (!khugepaged_test_exit(mm)) {
+				spinlock_t *ptl = pmd_lock(mm, pmd);
+				/* assume page table is clear */
+				_pmd = pmdp_collapse_flush(vma, addr, pmd);
+				spin_unlock(ptl);
+				mm_dec_nr_ptes(mm);
+				pte_free(mm, pmd_pgtable(_pmd));
+			}
+			mmap_write_unlock(mm);
 		} else {
 			/* Try again later */
-			khugepaged_add_pte_mapped_thp(vma->vm_mm, addr);
+			khugepaged_add_pte_mapped_thp(mm, addr);
 		}
 	}
 	i_mmap_unlock_write(mapping);
