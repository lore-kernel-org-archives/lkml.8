Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8D7C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 01:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDC252071C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 01:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iBxxvM+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgDXBjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 21:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725884AbgDXBjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 21:39:03 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391FCC09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 18:39:03 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w3so3158735plz.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 18:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eZcf0QPT3ZvI34tvvY0T2MtEDb+ZHbHmyYW0ad7vjJc=;
        b=iBxxvM+QNomOa7lVAyh6PRH8iW3RTfaCAxwwypmALNJgt5ObVteaV4+5U/Z9Zm5SQt
         qfT4Y5PA+ZPY5kVetf/LTb5J7DdeqM5UMjweLizYxswKt2Vee7DtmRlpEZeq8nYc0hd4
         X7IMB6TDsdBmcTEV509t1ccHbximkauBTRzduVgW9vEjoey8+dGaDVcBOa5Q6jfV4haE
         hZ5FJxe44f9aEix+xex2I3nmtsCqKa/vqZ9TBs+WSQdqL16pSQmxqFxrOOjWqSt+xHqx
         KkdhW9d89/uyu2VKi0EoavXYGzKe67/O4U5+yvRawASTczOzLKAPTqBszIvCpclcPjeF
         yTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eZcf0QPT3ZvI34tvvY0T2MtEDb+ZHbHmyYW0ad7vjJc=;
        b=nFEBobeS9YaWTCwb1wIGDyBIh2Vm3/thLMu2Vqa5mcFb2MePljNXnEjVzJbmYonT3F
         HS9EAK20fGF2Qa84dNreXIKEFQYbZgjwd3AZe4qJn3SeD+ua0uIVixI31eJFQCtyymQj
         rYKYeQ2X1KjzqaAVcHLnRhWCn6VeUsnM2PepHDB+3xD3SZbNdGOczH2d8Ic5PHkkTB6q
         DbJBfaU+gBto6nijmIWHL3lcYh/rq8c2nc/wevgSNjn3tiJxEm4QQQNM3xUQ1g3BVcYi
         ufln2F5woFf8eROvOdRnS56kmfxIe20D+vMn8irh6dVcDRN1LVBtcA7AVcHDg2y3WGo4
         JPKg==
X-Gm-Message-State: AGi0PuZ3wNLd34ODit+FtsqTYWvzQIZEnd0C2aqhYw9+7AAPPaVaaT9K
        mZALlHOLzv3OoedSn8LZiHVAzg==
X-Google-Smtp-Source: APiQypKlst01cw/y+XQoF/d2CAeJEm3O9oYhK0VQeTP5culqA6mYQMpqBhc5FNeTq2G2WM2kl4iL6A==
X-Received: by 2002:a17:90a:e28f:: with SMTP id d15mr3671951pjz.79.1587692342246;
        Thu, 23 Apr 2020 18:39:02 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:202:2523:d194:de3b:636f])
        by smtp.gmail.com with ESMTPSA id 22sm3977091pfb.132.2020.04.23.18.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 18:39:00 -0700 (PDT)
Date:   Thu, 23 Apr 2020 18:38:58 -0700
From:   Michel Lespinasse <walken@google.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH v5.5 09/10] mmap locking API: add mmap_assert_locked() and
 mmap_assert_write_locked()
Message-ID: <20200424013858.GB158937@google.com>
References: <20200422001422.232330-1-walken@google.com>
 <20200422001422.232330-11-walken@google.com>
 <20200422015829.GR5820@bombadil.infradead.org>
 <CANN689EnGsJXA8n6JvTryQfkCtARPvtZbkH+9Dd2a4X+fvqU9g@mail.gmail.com>
 <20200423015917.GA13910@bombadil.infradead.org>
 <20200424012612.GA158937@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424012612.GA158937@google.com>
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
index 9e104835a0d1..5bf7cee5d93b 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -1,6 +1,8 @@
 #ifndef _LINUX_MMAP_LOCK_H
 #define _LINUX_MMAP_LOCK_H
 
+#include <linux/mmdebug.h>
+
 #define MMAP_LOCK_INITIALIZER(name) \
 	.mmap_sem = __RWSEM_INITIALIZER(name.mmap_sem),
 
@@ -73,4 +75,16 @@ static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
 	up_read_non_owner(&mm->mmap_sem);
 }
 
+static inline void mmap_assert_locked(struct mm_struct *mm)
+{
+	VM_BUG_ON_MM(!lockdep_is_held_type(&mm->mmap_sem, -1), mm);
+	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_sem), mm);
+}
+
+static inline void mmap_assert_write_locked(struct mm_struct *mm)
+{
+	VM_BUG_ON_MM(!lockdep_is_held_type(&mm->mmap_sem, 0), mm);
+	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_sem), mm);
+}
+
 #endif /* _LINUX_MMAP_LOCK_H */
diff --git a/mm/gup.c b/mm/gup.c
index 0404e52513b2..e12993ceb711 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1403,7 +1403,7 @@ long populate_vma_page_range(struct vm_area_struct *vma,
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
2.26.2.303.gf8c07b1a785-goog

