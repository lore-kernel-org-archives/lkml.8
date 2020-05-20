Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B87FC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 05:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74082207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 05:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EPtki99w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgETF3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 01:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgETF3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 01:29:33 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FCBC05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 22:29:33 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id v6so2668972qkh.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 22:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IkbPpp4pCdE+DLiAS2Sxpg5ui8paNSEwzQTlJNwfQUQ=;
        b=EPtki99waF7pQHInsDA9Q+hFfVyOcLCNmCpGj2wziziq4j8YNpCaICDNF9IUtnkKu+
         7qLXG+b0t0vfqhdMTBYAVmlJg39mkK8phV2KVPuNaUe+001Hl2PvfZixJT1O5whglHBp
         MccIJsiVNc39Jq+QjGAvAvDV4Luoo3mZlK7pJmAiYI89WfANKJvpWhzkcNKvwXbE5nOt
         2rsBB5FCecGcEpTfRBgQRuOpQyqf7i0Gwd6i9I3uGBZnLtxBE4v7FCncMEKVN/pfj+cB
         ztovpnR8Myrt4nca+xQj9Qe5K15GZp0RogZSezBS5HV1x0iRlakMFrPDi/2fy/VykA6y
         Uu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IkbPpp4pCdE+DLiAS2Sxpg5ui8paNSEwzQTlJNwfQUQ=;
        b=T6ykaDURN4e0CmRwgOfAa3+YcANiKgb8iZE+qUX/TrYI5tXkMn4Gpdjdzi0XB9WcUE
         zt+rdSHPeUvWrLW6kjRcIa3ymG02bKtTdP0DYiQqBtOM4AxrMNXeF6J3bYQrXuvkNQ6j
         osKMvWamAxLOh8w8SGfN677hdjlAcABUhpI19IttSbK5zm4ULuzBr9brlbqhDBWuYmiF
         QH2w2SsLwRFCdNmMbRFC0o7a575I/sIeLOyHD0GLl/2+ULFPMvGFvg8VAJQqU5U1dbhG
         Nb99TF9dyABm7sWAQnXXq0CJooSgB9D2fa3xx8dHwzVg/iCQkKZT5HSeWq2DEM+Y4DSx
         hTUA==
X-Gm-Message-State: AOAM530kxfLwq6fXlQvHB5B/izfzJCm0KMcmzWPwrQQngDbo87qcE6hZ
        GcIpkzqrE4HLtecdPO6OMa6Eg8OOZl8=
X-Google-Smtp-Source: ABdhPJyanOI+/pFVvjh2AMm1O9YBdh1EpiXsGdBqeD7eCJEnxNt7FGcGFNwZbhnPfC4pLAD20iLqA/sRW+w=
X-Received: by 2002:a0c:c991:: with SMTP id b17mr3178170qvk.16.1589952572487;
 Tue, 19 May 2020 22:29:32 -0700 (PDT)
Date:   Tue, 19 May 2020 22:29:05 -0700
In-Reply-To: <20200520052908.204642-1-walken@google.com>
Message-Id: <20200520052908.204642-10-walken@google.com>
Mime-Version: 1.0
References: <20200520052908.204642-1-walken@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v6 09/12] mmap locking API: add mmap_assert_locked() and mmap_assert_write_locked()
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
        John Hubbard <jhubbard@nvidia.com>,
        Michel Lespinasse <walken@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new APIs to assert that mmap_sem is held.

Using this instead of rwsem_is_locked and lockdep_assert_held[_write]
makes the assertions more tolerant of future changes to the lock type.

Signed-off-by: Michel Lespinasse <walken@google.com>
---
 arch/x86/events/core.c    |  2 +-
 fs/userfaultfd.c          |  6 +++---
 include/linux/mmap_lock.h | 14 ++++++++++++++
 mm/gup.c                  |  2 +-
 mm/hmm.c                  |  2 +-
 mm/memory.c               |  2 +-
 mm/mmu_notifier.c         |  6 +++---
 mm/pagewalk.c             |  6 +++---
 mm/util.c                 |  2 +-
 9 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index a619763e96e1..66559ac4f89e 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2182,7 +2182,7 @@ static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
 	 * For now, this can't happen because all callers hold mmap_sem
 	 * for write.  If this changes, we'll need a different solution.
 	 */
-	lockdep_assert_held_write(&mm->mmap_sem);
+	mmap_assert_write_locked(mm);
 
 	if (atomic_inc_return(&mm->context.perf_rdpmc_allowed) == 1)
 		on_each_cpu_mask(mm_cpumask(mm), refresh_pce, NULL, 1);
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 9c645eee1a59..12b492409040 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -234,7 +234,7 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 	pte_t *ptep, pte;
 	bool ret = true;
 
-	VM_BUG_ON(!rwsem_is_locked(&mm->mmap_sem));
+	mmap_assert_locked(mm);
 
 	ptep = huge_pte_offset(mm, address, vma_mmu_pagesize(vma));
 
@@ -286,7 +286,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	pte_t *pte;
 	bool ret = true;
 
-	VM_BUG_ON(!rwsem_is_locked(&mm->mmap_sem));
+	mmap_assert_locked(mm);
 
 	pgd = pgd_offset(mm, address);
 	if (!pgd_present(*pgd))
@@ -405,7 +405,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	 * Coredumping runs without mmap_sem so we can only check that
 	 * the mmap_sem is held, if PF_DUMPCORE was not set.
 	 */
-	WARN_ON_ONCE(!rwsem_is_locked(&mm->mmap_sem));
+	mmap_assert_locked(mm);
 
 	ctx = vmf->vma->vm_userfaultfd_ctx.ctx;
 	if (!ctx)
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index acac1bf5ecd2..43ef914e6468 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -1,6 +1,8 @@
 #ifndef _LINUX_MMAP_LOCK_H
 #define _LINUX_MMAP_LOCK_H
 
+#include <linux/mmdebug.h>
+
 #define MMAP_LOCK_INITIALIZER(name) \
 	.mmap_sem = __RWSEM_INITIALIZER((name).mmap_sem),
 
@@ -73,4 +75,16 @@ static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
 	up_read_non_owner(&mm->mmap_sem);
 }
 
+static inline void mmap_assert_locked(struct mm_struct *mm)
+{
+	lockdep_assert_held(&mm->mmap_sem);
+	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_sem), mm);
+}
+
+static inline void mmap_assert_write_locked(struct mm_struct *mm)
+{
+	lockdep_assert_held_write(&mm->mmap_sem);
+	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_sem), mm);
+}
+
 #endif /* _LINUX_MMAP_LOCK_H */
diff --git a/mm/gup.c b/mm/gup.c
index 631285295950..c1c0b37d0e8f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1405,7 +1405,7 @@ long populate_vma_page_range(struct vm_area_struct *vma,
 	VM_BUG_ON(end   & ~PAGE_MASK);
 	VM_BUG_ON_VMA(start < vma->vm_start, vma);
 	VM_BUG_ON_VMA(end   > vma->vm_end, vma);
-	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_sem), mm);
+	mmap_assert_locked(mm);
 
 	gup_flags = FOLL_TOUCH | FOLL_POPULATE | FOLL_MLOCK;
 	if (vma->vm_flags & VM_LOCKONFAULT)
diff --git a/mm/hmm.c b/mm/hmm.c
index 280585833adf..660a4bcf932a 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -581,7 +581,7 @@ long hmm_range_fault(struct hmm_range *range)
 	struct mm_struct *mm = range->notifier->mm;
 	int ret;
 
-	lockdep_assert_held(&mm->mmap_sem);
+	mmap_assert_locked(mm);
 
 	do {
 		/* If range is no longer valid force retry. */
diff --git a/mm/memory.c b/mm/memory.c
index e6dd3309c5a3..20f98ea8968e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1214,7 +1214,7 @@ static inline unsigned long zap_pud_range(struct mmu_gather *tlb,
 		next = pud_addr_end(addr, end);
 		if (pud_trans_huge(*pud) || pud_devmap(*pud)) {
 			if (next - addr != HPAGE_PUD_SIZE) {
-				VM_BUG_ON_VMA(!rwsem_is_locked(&tlb->mm->mmap_sem), vma);
+				mmap_assert_locked(tlb->mm);
 				split_huge_pud(vma, pud, addr);
 			} else if (zap_huge_pud(tlb, vma, pud, addr))
 				goto next;
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index cfd0a03bf5cc..24eb9d1ed0a7 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -609,7 +609,7 @@ int __mmu_notifier_register(struct mmu_notifier *subscription,
 	struct mmu_notifier_subscriptions *subscriptions = NULL;
 	int ret;
 
-	lockdep_assert_held_write(&mm->mmap_sem);
+	mmap_assert_write_locked(mm);
 	BUG_ON(atomic_read(&mm->mm_users) <= 0);
 
 	if (IS_ENABLED(CONFIG_LOCKDEP)) {
@@ -761,7 +761,7 @@ struct mmu_notifier *mmu_notifier_get_locked(const struct mmu_notifier_ops *ops,
 	struct mmu_notifier *subscription;
 	int ret;
 
-	lockdep_assert_held_write(&mm->mmap_sem);
+	mmap_assert_write_locked(mm);
 
 	if (mm->notifier_subscriptions) {
 		subscription = find_get_mmu_notifier(mm, ops);
@@ -1006,7 +1006,7 @@ int mmu_interval_notifier_insert_locked(
 		mm->notifier_subscriptions;
 	int ret;
 
-	lockdep_assert_held_write(&mm->mmap_sem);
+	mmap_assert_write_locked(mm);
 
 	if (!subscriptions || !subscriptions->has_itree) {
 		ret = __mmu_notifier_register(NULL, mm);
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 928df1638c30..3b452aa05cd0 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -395,7 +395,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 	if (!walk.mm)
 		return -EINVAL;
 
-	lockdep_assert_held(&walk.mm->mmap_sem);
+	mmap_assert_locked(walk.mm);
 
 	vma = find_vma(walk.mm, start);
 	do {
@@ -453,7 +453,7 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 	if (start >= end || !walk.mm)
 		return -EINVAL;
 
-	lockdep_assert_held(&walk.mm->mmap_sem);
+	mmap_assert_locked(walk.mm);
 
 	return __walk_page_range(start, end, &walk);
 }
@@ -472,7 +472,7 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 	if (!walk.mm)
 		return -EINVAL;
 
-	lockdep_assert_held(&walk.mm->mmap_sem);
+	mmap_assert_locked(walk.mm);
 
 	err = walk_page_test(vma->vm_start, vma->vm_end, &walk);
 	if (err > 0)
diff --git a/mm/util.c b/mm/util.c
index ea2e15b21446..e7cf9c815f5a 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -437,7 +437,7 @@ int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
 	unsigned long locked_vm, limit;
 	int ret = 0;
 
-	lockdep_assert_held_write(&mm->mmap_sem);
+	mmap_assert_write_locked(mm);
 
 	locked_vm = mm->locked_vm;
 	if (inc) {
-- 
2.26.2.761.g0e0b3e54be-goog

