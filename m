Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCDAC2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 01:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1339D20736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 01:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OpXzBSsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgDXBkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 21:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726152AbgDXBkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 21:40:02 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7D8C09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 18:40:02 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mq3so3308133pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 18:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=68Nx2V8aZ/ShCL5lhF0+fP6Gwyx0200ThlJtcELp36E=;
        b=OpXzBSsxwfLCg1Fm8bhwdgNV04pYonI9vicEN6e72BxIcNWF4ejewW74Sf3Sw02xuf
         hZliOvZsG4rH77xHjyQUKE0EBincQr7n/Ueenctw47W0AU6h1wPPskfo+9q3ayovHMY6
         +zweC/tU+jmEH6gAayNafg+ZHz/lYQGEkeZt/e/GBg87h5Cw/q4xpIHuTOe5Gg8UU964
         0tWXsxA40wiK/PQfuZ7Sn/lp+6s6ACm4r5ooCtBvfDwNiTnV21LM3XyuXs+Ywt54u1MT
         ZpY8v5iqOpWTN2FLbbQsM/M4GxM8pAvuwKMRcOITc7sCPwN7xC1SQJDFO/aiXoJFwZ1N
         dq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=68Nx2V8aZ/ShCL5lhF0+fP6Gwyx0200ThlJtcELp36E=;
        b=grcyTT0YgpSCvI/HXDSLUg2QPU+dnUoUZgQCS9Hl13UvfT6LHBUZlRo93fNuDNEeMu
         P/tIoAf3yHrrgpqAK4RJwbZ1JHwfTHbm2gsSHjmu07sNtWQy4tdiiZJriUY6datQKND2
         +WRUxF8g7yzokv0A9s+/zDGob/yAxIYlCO6djmOwEnHOerJicQXSA/lOxz13vwjRO7K2
         z2Vl41SrLv52UXZEHzeVbTjtEBaTL7Ldwc9MVvT02T1t6f75iAgoWCxDLvy2yixtexos
         R/9S07V99Zzoh41MOej2RMHb4dYeplPIZnRLhh9cHt0SA/1hsa+1Y3c2h6sL16xOGMYu
         GKQw==
X-Gm-Message-State: AGi0PuZGlnZhKd2eYQiz0tfeKcEWNRlwAN3eKEm4lYWFph5DnvEX+uOi
        ne0AxseXMbkP8GAJ8kKsTfuZa3DRBzxYnw==
X-Google-Smtp-Source: APiQypKQqJaem5xVn+CH3gnRms1htPRwe3w5eIVaLVtSZBJGLpN4BihhHy6fH/KuhwX7AlL01LCacg==
X-Received: by 2002:a17:90a:4e81:: with SMTP id o1mr3601742pjh.161.1587692401505;
        Thu, 23 Apr 2020 18:40:01 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:202:2523:d194:de3b:636f])
        by smtp.gmail.com with ESMTPSA id x10sm3219587pgq.79.2020.04.23.18.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 18:40:00 -0700 (PDT)
Date:   Thu, 23 Apr 2020 18:39:58 -0700
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
Subject: [PATCH v5.5 10/10] mmap locking API: rename mmap_sem to mmap_lock
Message-ID: <20200424013958.GC158937@google.com>
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

Rename the mmap_sem field to mmap_lock. Any new uses of this lock
should now go through the new mmap locking api. The mmap_lock is
still implemented as a rwsem, though this could change in the future.

Signed-off-by: Michel Lespinasse <walken@google.com>
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
index 5bf7cee5d93b..9dc632add390 100644
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
@@ -72,19 +72,19 @@ static inline bool mmap_read_trylock_non_owner(struct mm_struct *mm)
 
 static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
 {
-	up_read_non_owner(&mm->mmap_sem);
+	up_read_non_owner(&mm->mmap_lock);
 }
 
 static inline void mmap_assert_locked(struct mm_struct *mm)
 {
-	VM_BUG_ON_MM(!lockdep_is_held_type(&mm->mmap_sem, -1), mm);
-	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_sem), mm);
+	VM_BUG_ON_MM(!lockdep_is_held_type(&mm->mmap_lock, -1), mm);
+	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
 }
 
 static inline void mmap_assert_write_locked(struct mm_struct *mm)
 {
-	VM_BUG_ON_MM(!lockdep_is_held_type(&mm->mmap_sem, 0), mm);
-	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_sem), mm);
+	VM_BUG_ON_MM(!lockdep_is_held_type(&mm->mmap_lock, 0), mm);
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
2.26.2.303.gf8c07b1a785-goog

