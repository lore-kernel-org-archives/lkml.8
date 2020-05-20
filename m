Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F3CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 05:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF2D5207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 05:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MU7TNwoJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgETF3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 01:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbgETF3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 01:29:35 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5875C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 22:29:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s8so789834ybj.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 22:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RrikTmw7tkKR8j1RKmHSLRVaXrgipAWAZuExbNYUkgA=;
        b=MU7TNwoJ6QqArvgk1mucJAEriyJLMYw8Xb9eCdknhhUu3f41Kiz4K2OM03tapZRaf1
         HiAeBNv1cYsayQ2cCbEgxWP3q9RE3HWDOPcM9pP7ONsu1Navv29v85p6ajk7rKBJZotv
         iAVk9eyrQwX4LArMPLSLx0XCJ51ZFBucGOp1WnHjQZc2hd3AGghqAHt5wvUvlkQJcj1O
         6UU9zoSDoHO/iwD14Q8I3w5QpVdZ/D8Iz3RyldEudZE3PrJqeepzjZSUOntg0Ejr9EVp
         Jf5Zw2RX7f8s4zDK5uVwAtDPO1a5Oa7GiAID4dwwb8UjHigBCjYKo9SDfc5CvTKIFXHm
         heqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RrikTmw7tkKR8j1RKmHSLRVaXrgipAWAZuExbNYUkgA=;
        b=hfvgersSYubwx9Ec7NWmWsb2FLTqGzejx87s9F7HIt9KBjk+OCvaS5CbOULJ4VBClW
         8y53cBB0xuyCyekFevd0Ry4eJd8gm9/y1s25jR+GBw8g0lXlNELQqqfI7eJnxem3s/EQ
         b18xn3TSNVOWAlDgdDC8TmKlYNaqDdssh5GCDSgKe5vOVsvrdohgUkJ/8I0qjQoWoaxw
         p8e7NyH4kzf/C7/bUdSan2Sq9crz/tcvHoTiOUTdYDhjI/G0XdltKhtwX5hPLdLJdMzW
         pKUrXtcYnkmNKJjj6LN55/CcffbtV8ngW+CNmloUmnTGxgZ/zIC8L7fkYAzrr5Sj1rUZ
         QSwA==
X-Gm-Message-State: AOAM530fDk3oFzE1+ivaTTfAZGPLNgNxeITVleZ8aVPeS5f1sE/Lfa9e
        d1+5n05r0Bt9fdeuXdz+6SEcnntmWxs=
X-Google-Smtp-Source: ABdhPJzIYk4ESLhciP+gpGkUxCXLRu0Lf2AY6ECrC+loFsBWs23BizNjpSayw5HRciDB8q2oaIYyjLCazoM=
X-Received: by 2002:a25:6046:: with SMTP id u67mr4722745ybb.54.1589952574874;
 Tue, 19 May 2020 22:29:34 -0700 (PDT)
Date:   Tue, 19 May 2020 22:29:06 -0700
In-Reply-To: <20200520052908.204642-1-walken@google.com>
Message-Id: <20200520052908.204642-11-walken@google.com>
Mime-Version: 1.0
References: <20200520052908.204642-1-walken@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v6 10/12] mmap locking API: rename mmap_sem to mmap_lock
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

Rename the mmap_sem field to mmap_lock. Any new uses of this lock
should now go through the new mmap locking api. The mmap_lock is
still implemented as a rwsem, though this could change in the future.

Signed-off-by: Michel Lespinasse <walken@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 arch/ia64/mm/fault.c                  |  4 +--
 arch/x86/mm/fault.c                   |  2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.c |  2 +-
 include/linux/mm_types.h              |  2 +-
 include/linux/mmap_lock.h             | 38 +++++++++++++--------------
 mm/memory.c                           |  2 +-
 mm/mmap.c                             |  4 +--
 mm/mmu_notifier.c                     |  2 +-
 8 files changed, 28 insertions(+), 28 deletions(-)

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
index 43ef914e6468..b5bd86778cca 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -4,67 +4,67 @@
 #include <linux/mmdebug.h>
 
 #define MMAP_LOCK_INITIALIZER(name) \
-	.mmap_sem = __RWSEM_INITIALIZER((name).mmap_sem),
+	.mmap_lock = __RWSEM_INITIALIZER((name).mmap_lock),
 
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
@@ -72,19 +72,19 @@ static inline bool mmap_read_trylock_non_owner(struct mm_struct *mm)
 
 static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
 {
-	up_read_non_owner(&mm->mmap_sem);
+	up_read_non_owner(&mm->mmap_lock);
 }
 
 static inline void mmap_assert_locked(struct mm_struct *mm)
 {
-	lockdep_assert_held(&mm->mmap_sem);
-	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_sem), mm);
+	lockdep_assert_held(&mm->mmap_lock);
+	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
 }
 
 static inline void mmap_assert_write_locked(struct mm_struct *mm)
 {
-	lockdep_assert_held_write(&mm->mmap_sem);
-	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_sem), mm);
+	lockdep_assert_held_write(&mm->mmap_lock);
+	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
 }
 
 #endif /* _LINUX_MMAP_LOCK_H */
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
index 24eb9d1ed0a7..2f348b6c9c9a 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -983,7 +983,7 @@ int mmu_interval_notifier_insert(struct mmu_interval_notifier *interval_sub,
 	struct mmu_notifier_subscriptions *subscriptions;
 	int ret;
 
-	might_lock(&mm->mmap_sem);
+	might_lock(&mm->mmap_lock);
 
 	subscriptions = smp_load_acquire(&mm->notifier_subscriptions);
 	if (!subscriptions || !subscriptions->has_itree) {
-- 
2.26.2.761.g0e0b3e54be-goog

