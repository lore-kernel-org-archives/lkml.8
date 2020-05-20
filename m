Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE425C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 05:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BADA420872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 05:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ju1uTzOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgETF3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 01:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbgETF3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 01:29:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAEFC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 22:29:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q16so791645ybg.18
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 22:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/1mJLG8XKzvlTqN2TpWDva8gM5dCg31OBJnLj221hJg=;
        b=ju1uTzOVIAW84CbTWrWJ3Us3p26+isy1bBXzabiZU3dQSqIhdBXILHVaKi2yqf7HdG
         0BAxLvKUw5v9VfPLkDGBrPqBcLW0Xm5z+3HqQ8KBbsQos3GIq1+1exANw3Xyy5e1lklg
         pGQ5RkAzkhINt83R2VqaQuutCB8nob+lazQFPy74L8W3EzBmAeMCZtWwk7acBERa3KMw
         BBfkmksV+ThKgP2pBesBNc1RQekm1fTCRAHzHpnFMVfLoM2Ne28+sMl6gtGVSYXfsmc6
         XxL5a4AGvetzSRPuiDK5KQSMVFgtzvN4jcSb+6yRnQpOI7XJmMKQPm61ri4A2yEswM7I
         x3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/1mJLG8XKzvlTqN2TpWDva8gM5dCg31OBJnLj221hJg=;
        b=KbVkGY8046zid9B7Y/OMqA0ngjmNFIjtXq6RXPj4C47H7A83RTKTrwvjuaiALBPulk
         cyYqHiNSrvXYkxXorOWOv6Rbmb4TA52KGqtQJmTtPu0I1GLWWRR7WceBqNUDGM9bwU8i
         HERWUgzMZMW4/5QT3U+jCajOo+fzM+U/XsOC/i41GEKHyauEcRntfRdpNPPMbQcsbiaL
         QUc/bftgjaeXsvk/I2Qm72mDhssTwtzjE1LnEoOTjFQ0chgDUFVAyTWEsLoR3pLI8k1j
         32zbU0AZoRQQbF7tkuHQhatuZE8X8Eprl6zt5Pn4Q5xF0ESgEbi77gwhJIbOhCBElPIK
         pBxQ==
X-Gm-Message-State: AOAM532Cq71G9MWlWmFORiog4nKna2DZATwKBpyPcFa96YlPLtY8AHpz
        ykEOcstJm7RM+JUqodcjXXiyyQC1GYY=
X-Google-Smtp-Source: ABdhPJxgpO99UNnwPRp2qhvMJLQBREzeLQxujHkqEtxjljxhUnoickJo/XO5GhACXOzTi3h9QiJbvGTSqRc=
X-Received: by 2002:a5b:584:: with SMTP id l4mr4775081ybp.232.1589952577126;
 Tue, 19 May 2020 22:29:37 -0700 (PDT)
Date:   Tue, 19 May 2020 22:29:07 -0700
In-Reply-To: <20200520052908.204642-1-walken@google.com>
Message-Id: <20200520052908.204642-12-walken@google.com>
Mime-Version: 1.0
References: <20200520052908.204642-1-walken@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v6 11/12] mmap locking API: convert mmap_sem API comments
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

Convert comments that reference old mmap_sem APIs to reference
corresponding new mmap locking APIs instead.

Signed-off-by: Michel Lespinasse <walken@google.com>
---
 Documentation/vm/hmm.rst       |  6 +++---
 arch/alpha/mm/fault.c          |  2 +-
 arch/ia64/mm/fault.c           |  2 +-
 arch/m68k/mm/fault.c           |  2 +-
 arch/microblaze/mm/fault.c     |  2 +-
 arch/mips/mm/fault.c           |  2 +-
 arch/nds32/mm/fault.c          |  2 +-
 arch/nios2/mm/fault.c          |  2 +-
 arch/openrisc/mm/fault.c       |  2 +-
 arch/parisc/mm/fault.c         |  2 +-
 arch/riscv/mm/fault.c          |  2 +-
 arch/sh/mm/fault.c             |  2 +-
 arch/sparc/mm/fault_32.c       |  2 +-
 arch/sparc/mm/fault_64.c       |  2 +-
 arch/xtensa/mm/fault.c         |  2 +-
 drivers/android/binder_alloc.c |  4 ++--
 fs/hugetlbfs/inode.c           |  2 +-
 fs/userfaultfd.c               |  2 +-
 mm/filemap.c                   |  2 +-
 mm/gup.c                       | 12 ++++++------
 mm/huge_memory.c               |  4 ++--
 mm/khugepaged.c                |  2 +-
 mm/ksm.c                       |  2 +-
 mm/memory.c                    |  4 ++--
 mm/mempolicy.c                 |  2 +-
 mm/migrate.c                   |  4 ++--
 mm/mmap.c                      |  2 +-
 mm/oom_kill.c                  |  8 ++++----
 net/ipv4/tcp.c                 |  2 +-
 29 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/Documentation/vm/hmm.rst b/Documentation/vm/hmm.rst
index 4e3e9362afeb..046817505033 100644
--- a/Documentation/vm/hmm.rst
+++ b/Documentation/vm/hmm.rst
@@ -194,15 +194,15 @@ The usage pattern is::
 
  again:
       range.notifier_seq = mmu_interval_read_begin(&interval_sub);
-      down_read(&mm->mmap_sem);
+      mmap_read_lock(mm);
       ret = hmm_range_fault(&range);
       if (ret) {
-          up_read(&mm->mmap_sem);
+          mmap_read_unlock(mm);
           if (ret == -EBUSY)
                  goto again;
           return ret;
       }
-      up_read(&mm->mmap_sem);
+      mmap_read_unlock(mm);
 
       take_lock(driver->update);
       if (mmu_interval_read_retry(&ni, range.notifier_seq) {
diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index 36efa778ee1a..c2303a8c2b9f 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -171,7 +171,7 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-			 /* No need to up_read(&mm->mmap_sem) as we would
+			 /* No need to mmap_read_unlock(mm) as we would
 			 * have already released it in __lock_page_or_retry
 			 * in mm/filemap.c.
 			 */
diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
index 9b95050c2048..0f788992608a 100644
--- a/arch/ia64/mm/fault.c
+++ b/arch/ia64/mm/fault.c
@@ -169,7 +169,7 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-			 /* No need to up_read(&mm->mmap_sem) as we would
+			 /* No need to mmap_read_unlock(mm) as we would
 			 * have already released it in __lock_page_or_retry
 			 * in mm/filemap.c.
 			 */
diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index 650acab0d77d..a94a814ad6ad 100644
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -165,7 +165,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 			flags |= FAULT_FLAG_TRIED;
 
 			/*
-			 * No need to up_read(&mm->mmap_sem) as we would
+			 * No need to mmap_read_unlock(mm) as we would
 			 * have already released it in __lock_page_or_retry
 			 * in mm/filemap.c.
 			 */
diff --git a/arch/microblaze/mm/fault.c b/arch/microblaze/mm/fault.c
index 9d7c423dea1d..ebf1ac50b291 100644
--- a/arch/microblaze/mm/fault.c
+++ b/arch/microblaze/mm/fault.c
@@ -239,7 +239,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 			flags |= FAULT_FLAG_TRIED;
 
 			/*
-			 * No need to up_read(&mm->mmap_sem) as we would
+			 * No need to mmap_read_unlock(mm) as we would
 			 * have already released it in __lock_page_or_retry
 			 * in mm/filemap.c.
 			 */
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index 9ef2dd39111e..01b168a90434 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -181,7 +181,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 			flags |= FAULT_FLAG_TRIED;
 
 			/*
-			 * No need to up_read(&mm->mmap_sem) as we would
+			 * No need to mmap_read_unlock(mm) as we would
 			 * have already released it in __lock_page_or_retry
 			 * in mm/filemap.c.
 			 */
diff --git a/arch/nds32/mm/fault.c b/arch/nds32/mm/fault.c
index 21bab96fd6c3..ea370f84ac54 100644
--- a/arch/nds32/mm/fault.c
+++ b/arch/nds32/mm/fault.c
@@ -248,7 +248,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-			/* No need to up_read(&mm->mmap_sem) as we would
+			/* No need to mmap_read_unlock(mm) as we would
 			 * have already released it in __lock_page_or_retry
 			 * in mm/filemap.c.
 			 */
diff --git a/arch/nios2/mm/fault.c b/arch/nios2/mm/fault.c
index 2c873f9eea1b..775e9fe1eddc 100644
--- a/arch/nios2/mm/fault.c
+++ b/arch/nios2/mm/fault.c
@@ -160,7 +160,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long cause,
 			flags |= FAULT_FLAG_TRIED;
 
 			/*
-			 * No need to up_read(&mm->mmap_sem) as we would
+			 * No need to mmap_read_unlock(mm) as we would
 			 * have already released it in __lock_page_or_retry
 			 * in mm/filemap.c.
 			 */
diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index 1dbce831f960..d6f203667361 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -183,7 +183,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-			 /* No need to up_read(&mm->mmap_sem) as we would
+			 /* No need to mmap_read_unlock(mm) as we would
 			 * have already released it in __lock_page_or_retry
 			 * in mm/filemap.c.
 			 */
diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index bc840fdb398f..66ac0719bd49 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -329,7 +329,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 			current->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
 			/*
-			 * No need to up_read(&mm->mmap_sem) as we would
+			 * No need to mmap_read_unlock(mm) as we would
 			 * have already released it in __lock_page_or_retry
 			 * in mm/filemap.c.
 			 */
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index cd7f4af95e56..996db5ebbf39 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -147,7 +147,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 			flags |= FAULT_FLAG_TRIED;
 
 			/*
-			 * No need to up_read(&mm->mmap_sem) as we would
+			 * No need to mmap_read_unlock(mm) as we would
 			 * have already released it in __lock_page_or_retry
 			 * in mm/filemap.c.
 			 */
diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index beb83e8ec0b3..ce9f492f9049 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -484,7 +484,7 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
 			flags |= FAULT_FLAG_TRIED;
 
 			/*
-			 * No need to up_read(&mm->mmap_sem) as we would
+			 * No need to mmap_read_unlock(mm) as we would
 			 * have already released it in __lock_page_or_retry
 			 * in mm/filemap.c.
 			 */
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index e69bcd957c78..18e97b2a8413 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -263,7 +263,7 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-			/* No need to up_read(&mm->mmap_sem) as we would
+			/* No need to mmap_read_unlock(mm) as we would
 			 * have already released it in __lock_page_or_retry
 			 * in mm/filemap.c.
 			 */
diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index 43ecd88a9d6f..2e79d7d050ed 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -451,7 +451,7 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-			/* No need to up_read(&mm->mmap_sem) as we would
+			/* No need to mmap_read_unlock(mm) as we would
 			 * have already released it in __lock_page_or_retry
 			 * in mm/filemap.c.
 			 */
diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index 1c8d22a0cf46..c4decc73fd86 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -130,7 +130,7 @@ void do_page_fault(struct pt_regs *regs)
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-			 /* No need to up_read(&mm->mmap_sem) as we would
+			 /* No need to mmap_read_unlock(mm) as we would
 			 * have already released it in __lock_page_or_retry
 			 * in mm/filemap.c.
 			 */
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index cbdc43ed0f9f..42c672f1584e 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -933,7 +933,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	if (!mmget_not_zero(mm))
 		goto err_mmget;
 	if (!mmap_read_trylock(mm))
-		goto err_down_read_mmap_sem_failed;
+		goto err_mmap_read_lock_failed;
 	vma = binder_alloc_get_vma(alloc);
 
 	list_lru_isolate(lru, item);
@@ -960,7 +960,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	mutex_unlock(&alloc->mutex);
 	return LRU_REMOVED_RETRY;
 
-err_down_read_mmap_sem_failed:
+err_mmap_read_lock_failed:
 	mmput_async(mm);
 err_mmget:
 err_page_already_freed:
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 991c60c7ffe0..a890f78aa80c 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -186,7 +186,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 }
 
 /*
- * Called under down_write(mmap_sem).
+ * Called under mmap_write_lock(mm).
  */
 
 #ifndef HAVE_ARCH_HUGETLB_UNMAPPED_AREA
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 12b492409040..3a63d75ed2fd 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1248,7 +1248,7 @@ static __always_inline void wake_userfault(struct userfaultfd_ctx *ctx,
 	/*
 	 * To be sure waitqueue_active() is not reordered by the CPU
 	 * before the pagetable update, use an explicit SMP memory
-	 * barrier here. PT lock release or up_read(mmap_sem) still
+	 * barrier here. PT lock release or mmap_read_unlock(mm) still
 	 * have release semantics that can allow the
 	 * waitqueue_active() to be reordered before the pte update.
 	 */
diff --git a/mm/filemap.c b/mm/filemap.c
index a4cc12653a39..10d21d0b0536 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1376,7 +1376,7 @@ EXPORT_SYMBOL_GPL(__lock_page_killable);
  * Return values:
  * 1 - page is locked; mmap_sem is still held.
  * 0 - page is not locked.
- *     mmap_sem has been released (up_read()), unless flags had both
+ *     mmap_lock has been released (mmap_read_unlock(), unless flags had both
  *     FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_RETRY_NOWAIT set, in
  *     which case mmap_sem is still held.
  *
diff --git a/mm/gup.c b/mm/gup.c
index c1c0b37d0e8f..a8606213bdec 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1967,19 +1967,19 @@ EXPORT_SYMBOL(get_user_pages);
  *
  * get_user_pages_locked() is suitable to replace the form:
  *
- *      down_read(&mm->mmap_sem);
+ *      mmap_read_lock(mm);
  *      do_something()
  *      get_user_pages(tsk, mm, ..., pages, NULL);
- *      up_read(&mm->mmap_sem);
+ *      mmap_read_unlock(mm);
  *
  *  to:
  *
  *      int locked = 1;
- *      down_read(&mm->mmap_sem);
+ *      mmap_read_lock(mm);
  *      do_something()
  *      get_user_pages_locked(tsk, mm, ..., pages, &locked);
  *      if (locked)
- *          up_read(&mm->mmap_sem);
+ *          mmap_read_unlock(mm);
  */
 long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
 			   unsigned int gup_flags, struct page **pages,
@@ -2003,9 +2003,9 @@ EXPORT_SYMBOL(get_user_pages_locked);
 /*
  * get_user_pages_unlocked() is suitable to replace the form:
  *
- *      down_read(&mm->mmap_sem);
+ *      mmap_read_lock(mm);
  *      get_user_pages(tsk, mm, ..., pages, NULL);
- *      up_read(&mm->mmap_sem);
+ *      mmap_read_unlock(mm);
  *
  *  with:
  *
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6ecd1045113b..aa940124396d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2038,9 +2038,9 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 		goto unlock;
 
 	/*
-	 * In case prot_numa, we are under down_read(mmap_sem). It's critical
+	 * In case prot_numa, we are under mmap_read_lock(mm). It's critical
 	 * to not clear pmd intermittently to avoid race with MADV_DONTNEED
-	 * which is also under down_read(mmap_sem):
+	 * which is also under mmap_read_lock(mm):
 	 *
 	 *	CPU0:				CPU1:
 	 *				change_huge_pmd(prot_numa=1)
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 100e61be4379..a173ed7eb2bf 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1444,7 +1444,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		/*
 		 * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
 		 * got written to. These VMAs are likely not worth investing
-		 * down_write(mmap_sem) as PMD-mapping is likely to be split
+		 * mmap_write_lock(mm) as PMD-mapping is likely to be split
 		 * later.
 		 *
 		 * Not that vma->anon_vma check is racy: it can be set up after
diff --git a/mm/ksm.c b/mm/ksm.c
index 17302642bcbf..0283d4969ef3 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2362,7 +2362,7 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
 	} else {
 		mmap_read_unlock(mm);
 		/*
-		 * up_read(&mm->mmap_sem) first because after
+		 * mmap_read_unlock(mm) first because after
 		 * spin_unlock(&ksm_mmlist_lock) run, the "mm" may
 		 * already have been freed under us by __ksm_exit()
 		 * because the "mm_slot" is still hashed and
diff --git a/mm/memory.c b/mm/memory.c
index c2963e7affa9..3c9a5f6ac9f0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3322,10 +3322,10 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	 * pte_offset_map() on pmds where a huge pmd might be created
 	 * from a different thread.
 	 *
-	 * pte_alloc_map() is safe to use under down_write(mmap_sem) or when
+	 * pte_alloc_map() is safe to use under mmap_write_lock(mm) or when
 	 * parallel threads are excluded by other means.
 	 *
-	 * Here we only have down_read(mmap_sem).
+	 * Here we only have mmap_read_lock(mm).
 	 */
 	if (pte_alloc(vma->vm_mm, vmf->pmd))
 		return VM_FAULT_OOM;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 202505195642..a1247d3553da 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2188,7 +2188,7 @@ static struct page *alloc_page_interleave(gfp_t gfp, unsigned order,
  *
  * 	This function allocates a page from the kernel page pool and applies
  *	a NUMA policy associated with the VMA or the current process.
- *	When VMA is not NULL caller must hold down_read on the mmap_sem of the
+ *	When VMA is not NULL caller must read-lock the mmap_lock of the
  *	mm_struct of the VMA to prevent it from going away. Should be used for
  *	all allocations for pages that will be mapped into user space. Returns
  *	NULL when no page can be allocated.
diff --git a/mm/migrate.c b/mm/migrate.c
index fc05d721b032..c3dc86ccb808 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2772,10 +2772,10 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	 * pte_offset_map() on pmds where a huge pmd might be created
 	 * from a different thread.
 	 *
-	 * pte_alloc_map() is safe to use under down_write(mmap_sem) or when
+	 * pte_alloc_map() is safe to use under mmap_write_lock(mm) or when
 	 * parallel threads are excluded by other means.
 	 *
-	 * Here we only have down_read(mmap_sem).
+	 * Here we only have mmap_read_lock(mm).
 	 */
 	if (pte_alloc(mm, pmdp))
 		goto abort;
diff --git a/mm/mmap.c b/mm/mmap.c
index 80a47031d5db..dcdda8473012 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1361,7 +1361,7 @@ static inline bool file_mmap_ok(struct file *file, struct inode *inode,
 }
 
 /*
- * The caller must hold down_write(&current->mm->mmap_sem).
+ * The caller must write-lock current->mm->mmap_lock.
  */
 unsigned long do_mmap(struct file *file, unsigned long addr,
 			unsigned long len, unsigned long prot,
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index be9f0a78c408..df99b255d510 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -577,8 +577,8 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
 	/*
 	 * MMF_OOM_SKIP is set by exit_mmap when the OOM reaper can't
 	 * work on the mm anymore. The check for MMF_OOM_SKIP must run
-	 * under mmap_sem for reading because it serializes against the
-	 * down_write();up_write() cycle in exit_mmap().
+	 * under mmap_lock for reading because it serializes against the
+	 * mmap_write_lock();mmap_write_unlock() cycle in exit_mmap().
 	 */
 	if (test_bit(MMF_OOM_SKIP, &mm->flags)) {
 		trace_skip_task_reaping(tsk->pid);
@@ -611,7 +611,7 @@ static void oom_reap_task(struct task_struct *tsk)
 	int attempts = 0;
 	struct mm_struct *mm = tsk->signal->oom_mm;
 
-	/* Retry the down_read_trylock(mmap_sem) a few times */
+	/* Retry the mmap_read_trylock(mm) a few times */
 	while (attempts++ < MAX_OOM_REAP_RETRIES && !oom_reap_task_mm(tsk, mm))
 		schedule_timeout_idle(HZ/10);
 
@@ -629,7 +629,7 @@ static void oom_reap_task(struct task_struct *tsk)
 
 	/*
 	 * Hide this mm from OOM killer because it has been either reaped or
-	 * somebody can't call up_write(mmap_sem).
+	 * somebody can't call mmap_write_unlock(mm).
 	 */
 	set_bit(MMF_OOM_SKIP, &mm->flags);
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index c4aee8379f97..a083d92ef3b9 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1734,7 +1734,7 @@ int tcp_mmap(struct file *file, struct socket *sock,
 		return -EPERM;
 	vma->vm_flags &= ~(VM_MAYWRITE | VM_MAYEXEC);
 
-	/* Instruct vm_insert_page() to not down_read(mmap_sem) */
+	/* Instruct vm_insert_page() to not mmap_read_lock(mm) */
 	vma->vm_flags |= VM_MIXEDMAP;
 
 	vma->vm_ops = &tcp_vm_ops;
-- 
2.26.2.761.g0e0b3e54be-goog

