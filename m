Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15704C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C942F20735
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SssyziSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgDVAPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 20:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgDVAOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 20:14:49 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9587AC061BD3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:14:49 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 75so228679pge.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zTh8b7RkNjPks24jV7/li7LKOvprI0HH2UU/tYjPtTE=;
        b=SssyziSuU39OVM/zFl4G5zbSJeluyD8sI7DrMO83k9o5Kz2M1UC3XqTAXZj52y84Zc
         8ABC8zm5xEmA2LBf2/DZWYuLGmta8EnyNAekDtZG0TLPPL+QQFWWqqy/R+2nl0yEIQTB
         ZNmeR2JaaR996a2n0tuu9NjqJoLaNEmmt84zXqfv8eu3dPF7h1KiYvhxu4EdUYruSupu
         xYBqNBn7bYoGd1E6+Bq7lUhW01GBHWkiHO+LWxqcnsXNAI27rj+mLQ9F9vs0QPnW1p0j
         +5ECL6FX0sJH4I5RZ2x0RB8TcSk3XZx+n9kVZD/RKbOc+vk33iC9Z5luEbr/2+tBXODy
         QwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zTh8b7RkNjPks24jV7/li7LKOvprI0HH2UU/tYjPtTE=;
        b=gXIJCGMpgMj8F2TiDZZ2RHIqxPCQP8AzX6gQkL0Y+oClRvvYhiIWl7o1W4dDklHCRI
         OUIPbGiwoN13ulEszbbbhU4I5z1jNWF22VC1W4p/JI3tqlxOjA9VPnXQQg+q5HIsIb3U
         g+Gzq0Ab2R6YRFFKLawNqoULN87Tn2XJKutQCQJTLyj+Gj9L9qyaboi6xhgtMEotN+GR
         /WQSpuZJKKRo8WtV4952PoaDFyVLveRAZvvSY1hW3V7pczMINBqOady+PqAoDofIalgG
         jhisvbEj/k2zzLYbawyU4n4JSUhp8mFQ50xLN2JjZGAYLne+5abSWUTbt11XaxisdgSz
         KlEQ==
X-Gm-Message-State: AGi0PuadQHUu8u3xklYoxsr6dr8yjBaltXh/Ghc89C0v3wtfSu4O+mMv
        IdSSM78mJyvL1h3LQFfMvii1vhcUE88=
X-Google-Smtp-Source: APiQypLo0I8zT8VqNAdBkX69fEiQmpb7TKR8EfxzxAqWqjVL5UY8sWJYZQV5U57B5NsqHG0CtpOMfYiR1xk=
X-Received: by 2002:a63:ee0b:: with SMTP id e11mr24642910pgi.80.1587514488899;
 Tue, 21 Apr 2020 17:14:48 -0700 (PDT)
Date:   Tue, 21 Apr 2020 17:14:22 -0700
In-Reply-To: <20200422001422.232330-1-walken@google.com>
Message-Id: <20200422001422.232330-11-walken@google.com>
Mime-Version: 1.0
References: <20200422001422.232330-1-walken@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v5 10/10] mmap locking API: rename mmap_sem to mmap_lock
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

Rename the mmap_sem field to mmap_lock. Any new uses of this lock
should now go through the new mmap locking api. The mmap_lock is
still implemented as a rwsem, though this could change in the future.

Signed-off-by: Michel Lespinasse <walken@google.com>
---
 arch/ia64/mm/fault.c                  |  4 ++--
 arch/x86/events/core.c                |  4 ++--
 arch/x86/mm/fault.c                   |  2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.c |  2 +-
 include/linux/mm_types.h              |  2 +-
 include/linux/mmap_lock.h             | 34 +++++++++++++--------------
 mm/hmm.c                              |  2 +-
 mm/memory.c                           |  2 +-
 mm/mmap.c                             |  4 ++--
 mm/mmu_notifier.c                     | 18 +++++++-------
 mm/pagewalk.c                         | 15 ++++++------
 mm/util.c                             |  4 ++--
 12 files changed, 47 insertions(+), 46 deletions(-)

diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
index 693f00b117e1..9b95050c2048 100644
--- a/arch/ia64/mm/fault.c
+++ b/arch/ia64/mm/fault.c
@@ -70,8 +70,8 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 	mask = ((((isr >> IA64_ISR_X_BIT) & 1UL) << VM_EXEC_BIT)
 		| (((isr >> IA64_ISR_W_BIT) & 1UL) << VM_WRITE_BIT));
 
-	/* mmap_sem is performance critical.... */
-	prefetchw(&mm->mmap_sem);
+	/* mmap_lock is performance critical.... */
+	prefetchw(&mm->mmap_lock);
 
 	/*
 	 * If we're in an interrupt or have no user context, we must not take the fault..
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index a619763e96e1..eda117ca1c43 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2179,10 +2179,10 @@ static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
 	 * userspace with CR4.PCE clear while another task is still
 	 * doing on_each_cpu_mask() to propagate CR4.PCE.
 	 *
-	 * For now, this can't happen because all callers hold mmap_sem
+	 * For now, this can't happen because all callers hold mmap_lock
 	 * for write.  If this changes, we'll need a different solution.
 	 */
-	lockdep_assert_held_write(&mm->mmap_sem);
+	lockdep_assert_held_write(&mm->mmap_lock);
 
 	if (atomic_inc_return(&mm->context.perf_rdpmc_allowed) == 1)
 		on_each_cpu_mask(mm_cpumask(mm), refresh_pce, NULL, 1);
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 181f66b9049f..35f530f9dfc0 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1522,7 +1522,7 @@ dotraplinkage void
 do_page_fault(struct pt_regs *regs, unsigned long hw_error_code,
 		unsigned long address)
 {
-	prefetchw(&current->mm->mmap_sem);
+	prefetchw(&current->mm->mmap_lock);
 	trace_page_fault_entries(regs, hw_error_code, address);
 
 	if (unlikely(kmmio_fault(regs, address)))
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index dc9ef302f517..701f3995f621 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -661,7 +661,7 @@ static int etnaviv_gem_userptr_get_pages(struct etnaviv_gem_object *etnaviv_obj)
 	struct etnaviv_gem_userptr *userptr = &etnaviv_obj->userptr;
 	int ret, pinned = 0, npages = etnaviv_obj->base.size >> PAGE_SHIFT;
 
-	might_lock_read(&current->mm->mmap_sem);
+	might_lock_read(&current->mm->mmap_lock);
 
 	if (userptr->mm != current->mm)
 		return -EPERM;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 4aba6c0c2ba8..d13b90399c16 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -436,7 +436,7 @@ struct mm_struct {
 		spinlock_t page_table_lock; /* Protects page tables and some
 					     * counters
 					     */
-		struct rw_semaphore mmap_sem;
+		struct rw_semaphore mmap_lock;
 
 		struct list_head mmlist; /* List of maybe swapped mm's.	These
 					  * are globally strung together off
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index f7a3a9550cc5..f8db53f10c1c 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -4,67 +4,67 @@
 #include <linux/mmdebug.h>
 
 #define MMAP_LOCK_INITIALIZER(name) \
-	.mmap_sem = __RWSEM_INITIALIZER(name.mmap_sem),
+	.mmap_lock = __RWSEM_INITIALIZER(name.mmap_lock),
 
 static inline void mmap_init_lock(struct mm_struct *mm)
 {
-	init_rwsem(&mm->mmap_sem);
+	init_rwsem(&mm->mmap_lock);
 }
 
 static inline void mmap_write_lock(struct mm_struct *mm)
 {
-	down_write(&mm->mmap_sem);
+	down_write(&mm->mmap_lock);
 }
 
 static inline void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
 {
-	down_write_nested(&mm->mmap_sem, subclass);
+	down_write_nested(&mm->mmap_lock, subclass);
 }
 
 static inline int mmap_write_lock_killable(struct mm_struct *mm)
 {
-	return down_write_killable(&mm->mmap_sem);
+	return down_write_killable(&mm->mmap_lock);
 }
 
 static inline bool mmap_write_trylock(struct mm_struct *mm)
 {
-	return down_write_trylock(&mm->mmap_sem) != 0;
+	return down_write_trylock(&mm->mmap_lock) != 0;
 }
 
 static inline void mmap_write_unlock(struct mm_struct *mm)
 {
-	up_write(&mm->mmap_sem);
+	up_write(&mm->mmap_lock);
 }
 
 static inline void mmap_write_downgrade(struct mm_struct *mm)
 {
-	downgrade_write(&mm->mmap_sem);
+	downgrade_write(&mm->mmap_lock);
 }
 
 static inline void mmap_read_lock(struct mm_struct *mm)
 {
-	down_read(&mm->mmap_sem);
+	down_read(&mm->mmap_lock);
 }
 
 static inline int mmap_read_lock_killable(struct mm_struct *mm)
 {
-	return down_read_killable(&mm->mmap_sem);
+	return down_read_killable(&mm->mmap_lock);
 }
 
 static inline bool mmap_read_trylock(struct mm_struct *mm)
 {
-	return down_read_trylock(&mm->mmap_sem) != 0;
+	return down_read_trylock(&mm->mmap_lock) != 0;
 }
 
 static inline void mmap_read_unlock(struct mm_struct *mm)
 {
-	up_read(&mm->mmap_sem);
+	up_read(&mm->mmap_lock);
 }
 
 static inline bool mmap_read_trylock_non_owner(struct mm_struct *mm)
 {
-	if (down_read_trylock(&mm->mmap_sem)) {
-		rwsem_release(&mm->mmap_sem.dep_map, _RET_IP_);
+	if (down_read_trylock(&mm->mmap_lock)) {
+		rwsem_release(&mm->mmap_lock.dep_map, _RET_IP_);
 		return true;
 	}
 	return false;
@@ -72,15 +72,15 @@ static inline bool mmap_read_trylock_non_owner(struct mm_struct *mm)
 
 static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
 {
-	up_read_non_owner(&mm->mmap_sem);
+	up_read_non_owner(&mm->mmap_lock);
 }
 
 static inline void mmap_assert_locked(struct mm_struct *mm)
 {
 	if (IS_ENABLED(CONFIG_LOCKDEP) && debug_locks)
-		VM_BUG_ON_MM(!lockdep_is_held(&mm->mmap_sem), mm);
+		VM_BUG_ON_MM(!lockdep_is_held(&mm->mmap_lock), mm);
 	else
-		VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_sem), mm);
+		VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
 }
 
 #endif /* _LINUX_MMAP_LOCK_H */
diff --git a/mm/hmm.c b/mm/hmm.c
index 280585833adf..8660aec6aafa 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -581,7 +581,7 @@ long hmm_range_fault(struct hmm_range *range)
 	struct mm_struct *mm = range->notifier->mm;
 	int ret;
 
-	lockdep_assert_held(&mm->mmap_sem);
+	lockdep_assert_held(&mm->mmap_lock);
 
 	do {
 		/* If range is no longer valid force retry. */
diff --git a/mm/memory.c b/mm/memory.c
index 20f98ea8968e..c2963e7affa9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4811,7 +4811,7 @@ void __might_fault(const char *file, int line)
 	__might_sleep(file, line, 0);
 #if defined(CONFIG_DEBUG_ATOMIC_SLEEP)
 	if (current->mm)
-		might_lock_read(&current->mm->mmap_sem);
+		might_lock_read(&current->mm->mmap_lock);
 #endif
 }
 EXPORT_SYMBOL(__might_fault);
diff --git a/mm/mmap.c b/mm/mmap.c
index 2f4ffccc5972..80a47031d5db 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3474,7 +3474,7 @@ static void vm_lock_anon_vma(struct mm_struct *mm, struct anon_vma *anon_vma)
 		 * The LSB of head.next can't change from under us
 		 * because we hold the mm_all_locks_mutex.
 		 */
-		down_write_nest_lock(&anon_vma->root->rwsem, &mm->mmap_sem);
+		down_write_nest_lock(&anon_vma->root->rwsem, &mm->mmap_lock);
 		/*
 		 * We can safely modify head.next after taking the
 		 * anon_vma->root->rwsem. If some other vma in this mm shares
@@ -3504,7 +3504,7 @@ static void vm_lock_mapping(struct mm_struct *mm, struct address_space *mapping)
 		 */
 		if (test_and_set_bit(AS_MM_ALL_LOCKS, &mapping->flags))
 			BUG();
-		down_write_nest_lock(&mapping->i_mmap_rwsem, &mm->mmap_sem);
+		down_write_nest_lock(&mapping->i_mmap_rwsem, &mm->mmap_lock);
 	}
 }
 
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index cfd0a03bf5cc..6717278d6d49 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -599,7 +599,7 @@ void __mmu_notifier_invalidate_range(struct mm_struct *mm,
 }
 
 /*
- * Same as mmu_notifier_register but here the caller must hold the mmap_sem in
+ * Same as mmu_notifier_register but here the caller must hold the mmap_lock in
  * write mode. A NULL mn signals the notifier is being registered for itree
  * mode.
  */
@@ -609,7 +609,7 @@ int __mmu_notifier_register(struct mmu_notifier *subscription,
 	struct mmu_notifier_subscriptions *subscriptions = NULL;
 	int ret;
 
-	lockdep_assert_held_write(&mm->mmap_sem);
+	lockdep_assert_held_write(&mm->mmap_lock);
 	BUG_ON(atomic_read(&mm->mm_users) <= 0);
 
 	if (IS_ENABLED(CONFIG_LOCKDEP)) {
@@ -623,7 +623,7 @@ int __mmu_notifier_register(struct mmu_notifier *subscription,
 		/*
 		 * kmalloc cannot be called under mm_take_all_locks(), but we
 		 * know that mm->notifier_subscriptions can't change while we
-		 * hold the write side of the mmap_sem.
+		 * hold the write side of the mmap_lock.
 		 */
 		subscriptions = kzalloc(
 			sizeof(struct mmu_notifier_subscriptions), GFP_KERNEL);
@@ -655,7 +655,7 @@ int __mmu_notifier_register(struct mmu_notifier *subscription,
 	 * readers.  acquire can only be used while holding the mmgrab or
 	 * mmget, and is safe because once created the
 	 * mmu_notifier_subscriptions is not freed until the mm is destroyed.
-	 * As above, users holding the mmap_sem or one of the
+	 * As above, users holding the mmap_lock or one of the
 	 * mm_take_all_locks() do not need to use acquire semantics.
 	 */
 	if (subscriptions)
@@ -689,7 +689,7 @@ EXPORT_SYMBOL_GPL(__mmu_notifier_register);
  * @mn: The notifier to attach
  * @mm: The mm to attach the notifier to
  *
- * Must not hold mmap_sem nor any other VM related lock when calling
+ * Must not hold mmap_lock nor any other VM related lock when calling
  * this registration function. Must also ensure mm_users can't go down
  * to zero while this runs to avoid races with mmu_notifier_release,
  * so mm has to be current->mm or the mm should be pinned safely such
@@ -750,7 +750,7 @@ find_get_mmu_notifier(struct mm_struct *mm, const struct mmu_notifier_ops *ops)
  * are the same.
  *
  * Each call to mmu_notifier_get() must be paired with a call to
- * mmu_notifier_put(). The caller must hold the write side of mm->mmap_sem.
+ * mmu_notifier_put(). The caller must hold the write side of mm->mmap_lock.
  *
  * While the caller has a mmu_notifier get the mm pointer will remain valid,
  * and can be converted to an active mm pointer via mmget_not_zero().
@@ -761,7 +761,7 @@ struct mmu_notifier *mmu_notifier_get_locked(const struct mmu_notifier_ops *ops,
 	struct mmu_notifier *subscription;
 	int ret;
 
-	lockdep_assert_held_write(&mm->mmap_sem);
+	lockdep_assert_held_write(&mm->mmap_lock);
 
 	if (mm->notifier_subscriptions) {
 		subscription = find_get_mmu_notifier(mm, ops);
@@ -983,7 +983,7 @@ int mmu_interval_notifier_insert(struct mmu_interval_notifier *interval_sub,
 	struct mmu_notifier_subscriptions *subscriptions;
 	int ret;
 
-	might_lock(&mm->mmap_sem);
+	might_lock(&mm->mmap_lock);
 
 	subscriptions = smp_load_acquire(&mm->notifier_subscriptions);
 	if (!subscriptions || !subscriptions->has_itree) {
@@ -1006,7 +1006,7 @@ int mmu_interval_notifier_insert_locked(
 		mm->notifier_subscriptions;
 	int ret;
 
-	lockdep_assert_held_write(&mm->mmap_sem);
+	lockdep_assert_held_write(&mm->mmap_lock);
 
 	if (!subscriptions || !subscriptions->has_itree) {
 		ret = __mmu_notifier_register(NULL, mm);
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 928df1638c30..d669a3146c0f 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -373,8 +373,9 @@ static int __walk_page_range(unsigned long start, unsigned long end,
  * caller-specific data to callbacks, @private should be helpful.
  *
  * Locking:
- *   Callers of walk_page_range() and walk_page_vma() should hold @mm->mmap_sem,
- *   because these function traverse vma list and/or access to vma's data.
+ *   Callers of walk_page_range() and walk_page_vma() should hold
+ *   @mm->mmap_lock, because these function traverse the vma list
+ *   and/or access the vma's data.
  */
 int walk_page_range(struct mm_struct *mm, unsigned long start,
 		unsigned long end, const struct mm_walk_ops *ops,
@@ -395,7 +396,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 	if (!walk.mm)
 		return -EINVAL;
 
-	lockdep_assert_held(&walk.mm->mmap_sem);
+	lockdep_assert_held(&walk.mm->mmap_lock);
 
 	vma = find_vma(walk.mm, start);
 	do {
@@ -453,7 +454,7 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 	if (start >= end || !walk.mm)
 		return -EINVAL;
 
-	lockdep_assert_held(&walk.mm->mmap_sem);
+	lockdep_assert_held(&walk.mm->mmap_lock);
 
 	return __walk_page_range(start, end, &walk);
 }
@@ -472,7 +473,7 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 	if (!walk.mm)
 		return -EINVAL;
 
-	lockdep_assert_held(&walk.mm->mmap_sem);
+	lockdep_assert_held(&walk.mm->mmap_lock);
 
 	err = walk_page_test(vma->vm_start, vma->vm_end, &walk);
 	if (err > 0)
@@ -498,11 +499,11 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
  * Also see walk_page_range() for additional information.
  *
  * Locking:
- *   This function can't require that the struct mm_struct::mmap_sem is held,
+ *   This function can't require that the struct mm_struct::mmap_lock is held,
  *   since @mapping may be mapped by multiple processes. Instead
  *   @mapping->i_mmap_rwsem must be held. This might have implications in the
  *   callbacks, and it's up tho the caller to ensure that the
- *   struct mm_struct::mmap_sem is not needed.
+ *   struct mm_struct::mmap_lock is not needed.
  *
  *   Also this means that a caller can't rely on the struct
  *   vm_area_struct::vm_flags to be constant across a call,
diff --git a/mm/util.c b/mm/util.c
index ea2e15b21446..56c562f7ad19 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -425,7 +425,7 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
  * @bypass_rlim: %true if checking RLIMIT_MEMLOCK should be skipped
  *
  * Assumes @task and @mm are valid (i.e. at least one reference on each), and
- * that mmap_sem is held as writer.
+ * that mmap_lock is held as writer.
  *
  * Return:
  * * 0       on success
@@ -437,7 +437,7 @@ int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
 	unsigned long locked_vm, limit;
 	int ret = 0;
 
-	lockdep_assert_held_write(&mm->mmap_sem);
+	lockdep_assert_held_write(&mm->mmap_lock);
 
 	locked_vm = mm->locked_vm;
 	if (inc) {
-- 
2.26.1.301.g55bc3eb7cb9-goog

