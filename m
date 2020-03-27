Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72846C2D0E7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5BA2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vBmocNGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgC0CLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:11:31 -0400
Received: from mail-pj1-f73.google.com ([209.85.216.73]:34392 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbgC0CL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:11:28 -0400
Received: by mail-pj1-f73.google.com with SMTP id d2so736919pje.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 19:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HCcfjnECbvQav2RZOXb0TuQMQZlLK/cH1xDpf2n6/4s=;
        b=vBmocNGDoHiN1eWI+OKYlLiswXWTqhxtwVcF+S5yJYy7Yun/iL0jWkDXun6XuIiONm
         sCC1Kzemm7FYnSBWw0oIvkTa/+/MLPwr/5lrHFiYPLKVL/EkgALhkveg+14LLnXzznif
         fw/7T7fVp3PYo822Ryt/Dh9Aroj5MOa2h8XyVU9AdMMORjlJBRVN270LSRnUg4Sur8OZ
         1yZKJjHkKFNkjWe15JqamTD2P47QQU0OJlHfPMYLU4mGoG7+Ujta3MTUN1ZWQezeAPeX
         OHH8jK/O7ZOy0rl/nvF9GwRE/5zoDqHy7mYWDRGHIHe8XRy+AvLWNvkRWgdPHUcwjUu9
         +UkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HCcfjnECbvQav2RZOXb0TuQMQZlLK/cH1xDpf2n6/4s=;
        b=OEzwB3aH2zV7CaSyQr8mW0CtDzf9TSFIMS5viVjoctZD3s6I5XUymgcEjvgKnuyPKa
         9s4Sn09efo2sTZgqPl+fljar9oa/lLsX+9OhKrVfhk4RQTWLvznZcItBYjFkVBb0+Iyl
         rSacnRQrCZZKvVNw08ze0RhLmUGfg3WdygI6sHKXs/5Vy+SZHlFDCIZShstCxDYQJSO1
         fU9T2uETtZbAHoB91JhGu295FRTRQHi2xN1h1/HBM7AxMKLi55cercFFyhbXHhqdY52m
         hHadGTfqeTXMX1U9IYpwmRyaGBO5Kfg0KkL+nHt2Z413RQu7+i8jPKNZLxah1+LBlB6m
         Zl0g==
X-Gm-Message-State: ANhLgQ2Dvb+ksohe1B//z2ldhYftninDVbq2V12gIyyJbQ9fwmhaLntJ
        LQrNlJAFUNv0XPidmO51VZaBOooLkT0=
X-Google-Smtp-Source: ADFU+vvjm9Q77smnavoap4nb9VHXOug+3XQiXpzfDL04wA+gKq7Jjv5j6j2G4NjyLiriacJ/wCZ5D0EDjDk=
X-Received: by 2002:a63:f002:: with SMTP id k2mr11663994pgh.14.1585275085803;
 Thu, 26 Mar 2020 19:11:25 -0700 (PDT)
Date:   Thu, 26 Mar 2020 19:10:58 -0700
In-Reply-To: <20200327021058.221911-1-walken@google.com>
Message-Id: <20200327021058.221911-11-walken@google.com>
Mime-Version: 1.0
References: <20200327021058.221911-1-walken@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v2 10/10] mmap locking API: rename mmap_sem to mmap_lock
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
        Markus Elfring <Markus.Elfring@web.de>,
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
 arch/x86/kernel/tboot.c               |  2 +-
 arch/x86/mm/fault.c                   |  2 +-
 drivers/firmware/efi/efi.c            |  2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.c |  2 +-
 fs/userfaultfd.c                      |  6 +++---
 include/linux/mm_types.h              |  2 +-
 include/linux/mmap_lock.h             | 30 +++++++++++++--------------
 mm/gup.c                              |  2 +-
 mm/hmm.c                              |  2 +-
 mm/init-mm.c                          |  2 +-
 mm/memory.c                           |  4 ++--
 mm/mmap.c                             |  4 ++--
 mm/mmu_notifier.c                     | 18 ++++++++--------
 mm/pagewalk.c                         | 15 +++++++-------
 mm/util.c                             |  4 ++--
 17 files changed, 53 insertions(+), 52 deletions(-)

diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
index b423f0a970e4..70c7c7909cc5 100644
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
index 3bb738f5a472..ad21924c575e 100644
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
diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 4b79335624b1..4792e8778b28 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -90,7 +90,7 @@ static struct mm_struct tboot_mm = {
 	.pgd            = swapper_pg_dir,
 	.mm_users       = ATOMIC_INIT(2),
 	.mm_count       = ATOMIC_INIT(1),
-	.mmap_sem       = MMAP_LOCK_INITIALIZER(init_mm.mmap_sem),
+	.mmap_lock      = MMAP_LOCK_INITIALIZER(init_mm.mmap_lock),
 	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
 	.mmlist         = LIST_HEAD_INIT(init_mm.mmlist),
 };
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 5bb97d2a7d3b..98d413e6fbb2 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1526,7 +1526,7 @@ dotraplinkage void
 do_page_fault(struct pt_regs *regs, unsigned long hw_error_code,
 		unsigned long address)
 {
-	prefetchw(&current->mm->mmap_sem);
+	prefetchw(&current->mm->mmap_lock);
 	trace_page_fault_entries(regs, hw_error_code, address);
 
 	if (unlikely(kmmio_fault(regs, address)))
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 5bdfe698cd7f..d38e0e85eb0d 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -60,7 +60,7 @@ struct mm_struct efi_mm = {
 	.mm_rb			= RB_ROOT,
 	.mm_users		= ATOMIC_INIT(2),
 	.mm_count		= ATOMIC_INIT(1),
-	.mmap_sem		= MMAP_LOCK_INITIALIZER(efi_mm.mmap_sem),
+	.mmap_lock		= MMAP_LOCK_INITIALIZER(efi_mm.mmap_lock),
 	.page_table_lock	= __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),
 	.mmlist			= LIST_HEAD_INIT(efi_mm.mmlist),
 	.cpu_bitmap		= { [BITS_TO_LONGS(NR_CPUS)] = 0},
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index 6adea180d629..3470482d95bc 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -661,7 +661,7 @@ static int etnaviv_gem_userptr_get_pages(struct etnaviv_gem_object *etnaviv_obj)
 	struct etnaviv_gem_userptr *userptr = &etnaviv_obj->userptr;
 	int ret, pinned = 0, npages = etnaviv_obj->base.size >> PAGE_SHIFT;
 
-	might_lock_read(&current->mm->mmap_sem);
+	might_lock_read(&current->mm->mmap_lock);
 
 	if (userptr->mm != current->mm)
 		return -EPERM;
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index ad1ce223ee6a..faea442c8fed 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -234,7 +234,7 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 	pte_t *ptep, pte;
 	bool ret = true;
 
-	lockdep_assert_held(&mm->mmap_sem);
+	lockdep_assert_held(&mm->mmap_lock);
 
 	ptep = huge_pte_offset(mm, address, vma_mmu_pagesize(vma));
 
@@ -286,7 +286,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	pte_t *pte;
 	bool ret = true;
 
-	lockdep_assert_held(&mm->mmap_sem);
+	lockdep_assert_held(&mm->mmap_lock);
 
 	pgd = pgd_offset(mm, address);
 	if (!pgd_present(*pgd))
@@ -376,7 +376,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	 * Coredumping runs without mmap_sem so we can only check that
 	 * the mmap_sem is held, if PF_DUMPCORE was not set.
 	 */
-	lockdep_assert_held(&mm->mmap_sem);
+	lockdep_assert_held(&mm->mmap_lock);
 
 	ctx = vmf->vma->vm_userfaultfd_ctx.ctx;
 	if (!ctx)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index c28911c3afa8..a168d13b5c44 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -431,7 +431,7 @@ struct mm_struct {
 		spinlock_t page_table_lock; /* Protects page tables and some
 					     * counters
 					     */
-		struct rw_semaphore mmap_sem;
+		struct rw_semaphore mmap_lock;
 
 		struct list_head mmlist; /* List of maybe swapped mm's.	These
 					  * are globally strung together off
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 7474b15bba38..700dd297f2af 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -5,78 +5,78 @@
 
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
 
 /* Pairs with mmap_write_lock_nested() */
 static inline void mmap_write_unlock_nested(struct mm_struct *mm)
 {
-	up_write(&mm->mmap_sem);
+	up_write(&mm->mmap_lock);
 }
 
 static inline void mmap_downgrade_write_lock(struct mm_struct *mm)
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
 
 static inline void mmap_read_release(struct mm_struct *mm, unsigned long ip)
 {
-	rwsem_release(&mm->mmap_sem.dep_map, ip);
+	rwsem_release(&mm->mmap_lock.dep_map, ip);
 }
 
 static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
 {
-	up_read_non_owner(&mm->mmap_sem);
+	up_read_non_owner(&mm->mmap_lock);
 }
 
 static inline bool mmap_is_locked(struct mm_struct *mm)
 {
-	return rwsem_is_locked(&mm->mmap_sem) != 0;
+	return rwsem_is_locked(&mm->mmap_lock) != 0;
 }
 
 #endif /* _LINUX_MMAP_LOCK_H */
diff --git a/mm/gup.c b/mm/gup.c
index 1e225eba4787..9c90d5e04897 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1154,7 +1154,7 @@ long populate_vma_page_range(struct vm_area_struct *vma,
 	VM_BUG_ON(end   & ~PAGE_MASK);
 	VM_BUG_ON_VMA(start < vma->vm_start, vma);
 	VM_BUG_ON_VMA(end   > vma->vm_end, vma);
-	lockdep_assert_held(&mm->mmap_sem);
+	lockdep_assert_held(&mm->mmap_lock);
 
 	gup_flags = FOLL_TOUCH | FOLL_POPULATE | FOLL_MLOCK;
 	if (vma->vm_flags & VM_LOCKONFAULT)
diff --git a/mm/hmm.c b/mm/hmm.c
index 72e5a6d9a417..4d736a710910 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -681,7 +681,7 @@ long hmm_range_fault(struct hmm_range *range, unsigned int flags)
 	struct mm_struct *mm = range->notifier->mm;
 	int ret;
 
-	lockdep_assert_held(&mm->mmap_sem);
+	lockdep_assert_held(&mm->mmap_lock);
 
 	do {
 		/* If range is no longer valid force retry. */
diff --git a/mm/init-mm.c b/mm/init-mm.c
index 3c128bd6a30c..2b16924419b4 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -31,7 +31,7 @@ struct mm_struct init_mm = {
 	.pgd		= swapper_pg_dir,
 	.mm_users	= ATOMIC_INIT(2),
 	.mm_count	= ATOMIC_INIT(1),
-	.mmap_sem	= MMAP_LOCK_INITIALIZER(init_mm.mmap_sem),
+	.mmap_lock	= MMAP_LOCK_INITIALIZER(init_mm.mmap_lock),
 	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
 	.arg_lock	=  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
 	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
diff --git a/mm/memory.c b/mm/memory.c
index 4c125f0a1df9..afb86afc5832 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1202,7 +1202,7 @@ static inline unsigned long zap_pud_range(struct mmu_gather *tlb,
 		next = pud_addr_end(addr, end);
 		if (pud_trans_huge(*pud) || pud_devmap(*pud)) {
 			if (next - addr != HPAGE_PUD_SIZE) {
-				lockdep_assert_held(&tlb->mm->mmap_sem);
+				lockdep_assert_held(&tlb->mm->mmap_lock);
 				split_huge_pud(vma, pud, addr);
 			} else if (zap_huge_pud(tlb, vma, pud, addr))
 				goto next;
@@ -4648,7 +4648,7 @@ void __might_fault(const char *file, int line)
 	__might_sleep(file, line, 0);
 #if defined(CONFIG_DEBUG_ATOMIC_SLEEP)
 	if (current->mm)
-		might_lock_read(&current->mm->mmap_sem);
+		might_lock_read(&current->mm->mmap_lock);
 #endif
 }
 EXPORT_SYMBOL(__might_fault);
diff --git a/mm/mmap.c b/mm/mmap.c
index ba51ff516ec0..c81db16c8c23 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3450,7 +3450,7 @@ static void vm_lock_anon_vma(struct mm_struct *mm, struct anon_vma *anon_vma)
 		 * The LSB of head.next can't change from under us
 		 * because we hold the mm_all_locks_mutex.
 		 */
-		down_write_nest_lock(&anon_vma->root->rwsem, &mm->mmap_sem);
+		down_write_nest_lock(&anon_vma->root->rwsem, &mm->mmap_lock);
 		/*
 		 * We can safely modify head.next after taking the
 		 * anon_vma->root->rwsem. If some other vma in this mm shares
@@ -3480,7 +3480,7 @@ static void vm_lock_mapping(struct mm_struct *mm, struct address_space *mapping)
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
2.26.0.rc2.310.g2932bb562d-goog

