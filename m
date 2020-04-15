Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AF8C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF82420737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v3U3zcnH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634672AbgDOAqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 20:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2634613AbgDOAoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 20:44:21 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D621FC0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:44:18 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id w4so14620048pjt.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ggOUzmI+Bo7l84q6+4eSP8RoHAFlUo3STFyyVvEfbuY=;
        b=v3U3zcnHadO8cIVqK7qs+yu9BjT5Cu1yAHrgYE84xqRz3dmpsNBbK1nkzqhxkzu76r
         Ru0/6QNuYt+D1VgkJZRfOvPwdG04Th2lgPYfFMUyA6NNnrhEnzYzWqOUgvstcD1y3zaG
         wu23Wkj4xhbxMmuuc+xK0vNGWDDc2Ai/L7BvERBgMf8gaJtdQTpU/jFQKJSKRMmNUcZl
         xI9r/noAK5QO/zR3AKqv503yzone0RbaRApvB3/Ns3XttF80P2z4DOEjIh9ATw+sqyqi
         YFk1WiX+kSu54pgBnYh06eEiG/sgDLROhy5OWH8NS3B1wH0Gt/Mc6Z+1jpW91zzIwGKU
         +gmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ggOUzmI+Bo7l84q6+4eSP8RoHAFlUo3STFyyVvEfbuY=;
        b=kPGVhgZJ/NCL36pqFu8pQhb5Xsv57H8Jw0NClJiMvPQwSmViUbfX1f0zkkX3Vf7msK
         TRveEysuqChUlL2lSkv4s5cnNDdPpo8ycw2suC8EBfqwKjsEhO7Nefh3DrJKjG1x7xAt
         Rtu4BMXk+WfgFpVcvdhbatAYLDoJ0J7xezHyKWGGVKVbjq+Ip1MEgEN/q7LGVk8TVxF0
         Xv2Vqed/l9LGloHDRaGSonX+twCcdgZdwaK2bZhLDfS7s0lfohy/h8SXxZ+htYqu/FLV
         SLYKD7TXDsGPptl5vvzyx8bh4+MjlulvV+K7+HBssPSqw1296DWKRqx8HLeP20pV9b/f
         FwhQ==
X-Gm-Message-State: AGi0PuaXYb3I1BOLsQqe31o3Z5x53GB8GhtakO1sL1U/rQ6evcytsFdU
        wceNR/GNU7cBetzQ3Chl83IjVf4VhsQ=
X-Google-Smtp-Source: APiQypKSHiRQIgo5oWUk5CjgE3NHcJLyFdkH8jRqO+eAwck4UEAr8xG7J11X7lWnOWO5y3p9NfdQWkaGVrg=
X-Received: by 2002:a17:90a:3287:: with SMTP id l7mr3119309pjb.126.1586911458346;
 Tue, 14 Apr 2020 17:44:18 -0700 (PDT)
Date:   Tue, 14 Apr 2020 17:43:52 -0700
In-Reply-To: <20200415004353.130248-1-walken@google.com>
Message-Id: <20200415004353.130248-10-walken@google.com>
Mime-Version: 1.0
References: <20200415004353.130248-1-walken@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v4 09/10] mmap locking API: use lockdep_assert_held
From:   Michel Lespinasse <walken@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michel Lespinasse <walken@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use lockdep_assert_held when asserting that mmap_sem is held.

Using this instead of rwsem_is_locked makes the assertions more
tolerant of future changes to the lock type.

Signed-off-by: Michel Lespinasse <walken@google.com>
---
 fs/userfaultfd.c | 6 +++---
 mm/gup.c         | 2 +-
 mm/memory.c      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 9c645eee1a59..81ae8315f1e6 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -234,7 +234,7 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 	pte_t *ptep, pte;
 	bool ret = true;
 
-	VM_BUG_ON(!rwsem_is_locked(&mm->mmap_sem));
+	lockdep_assert_held(&mm->mmap_sem);
 
 	ptep = huge_pte_offset(mm, address, vma_mmu_pagesize(vma));
 
@@ -286,7 +286,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	pte_t *pte;
 	bool ret = true;
 
-	VM_BUG_ON(!rwsem_is_locked(&mm->mmap_sem));
+	lockdep_assert_held(&mm->mmap_sem);
 
 	pgd = pgd_offset(mm, address);
 	if (!pgd_present(*pgd))
@@ -405,7 +405,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	 * Coredumping runs without mmap_sem so we can only check that
 	 * the mmap_sem is held, if PF_DUMPCORE was not set.
 	 */
-	WARN_ON_ONCE(!rwsem_is_locked(&mm->mmap_sem));
+	lockdep_assert_held(&mm->mmap_sem);
 
 	ctx = vmf->vma->vm_userfaultfd_ctx.ctx;
 	if (!ctx)
diff --git a/mm/gup.c b/mm/gup.c
index 0404e52513b2..dd8f045b047b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1403,7 +1403,7 @@ long populate_vma_page_range(struct vm_area_struct *vma,
 	VM_BUG_ON(end   & ~PAGE_MASK);
 	VM_BUG_ON_VMA(start < vma->vm_start, vma);
 	VM_BUG_ON_VMA(end   > vma->vm_end, vma);
-	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_sem), mm);
+	lockdep_assert_held(&mm->mmap_sem);
 
 	gup_flags = FOLL_TOUCH | FOLL_POPULATE | FOLL_MLOCK;
 	if (vma->vm_flags & VM_LOCKONFAULT)
diff --git a/mm/memory.c b/mm/memory.c
index e6dd3309c5a3..66baf5142e6b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1214,7 +1214,7 @@ static inline unsigned long zap_pud_range(struct mmu_gather *tlb,
 		next = pud_addr_end(addr, end);
 		if (pud_trans_huge(*pud) || pud_devmap(*pud)) {
 			if (next - addr != HPAGE_PUD_SIZE) {
-				VM_BUG_ON_VMA(!rwsem_is_locked(&tlb->mm->mmap_sem), vma);
+				lockdep_assert_held(&tlb->mm->mmap_sem);
 				split_huge_pud(vma, pud, addr);
 			} else if (zap_huge_pud(tlb, vma, pud, addr))
 				goto next;
-- 
2.26.0.110.g2183baf09c-goog

