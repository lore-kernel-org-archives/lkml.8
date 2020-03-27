Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3952DC2D0EE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7232083E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P5SOps4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgC0CLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:11:16 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:37413 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbgC0CLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:11:15 -0400
Received: by mail-pl1-f201.google.com with SMTP id t12so5926131plo.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 19:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=86ZhzKm5T/6O9jpZoUxqs4yVA0IM57Jhl4+KLMoCVFw=;
        b=P5SOps4uTWzsBuLbKsjnkChAFv6ql2CBHdwpwKFH+F+XX/4VCzV5NupuVkxEOMxQt6
         DMGnyVvY2sYYl5sMCiQg5NqakpHj9wQidJBjZ1TGuyzFS+2o1o8lYQMLdsIDB7GmqA6C
         nGapTc8uCpEvfIM0Z0divAJFdQHmjTESQRCCSmNdTxAw8MVBHf3dgrePsoLavJGDYH8L
         3AStgTQj4uXtylhryYnxzeUvdH01QgfLgoYOkIYPLdDOp/c8Fmutmad0onhbXkAlxcsE
         Qb60IJe9lq1Vo9HEKGuhx9jnSUUmAti/irFZubRQUfAJMZzzpqcALg1QvEwEim8ONtKj
         sEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=86ZhzKm5T/6O9jpZoUxqs4yVA0IM57Jhl4+KLMoCVFw=;
        b=WfI+FIVDc/68qqDpmT+mX7R6ceSdKczTrbqaGJYkGCfeIuF4D5kG0xpyd45fQGFm5n
         h60e/o1b3aVHyVCeywR7wWzn/yusRU/iiKSet8fznaohAh4xpKe790JqLn3uXOw+BnOo
         XTxjgyD6IOfr4+0OUsXemPhFmP/alI9BlfG1R5oV+Enz4UNDBXxuqVxjgsdRn4XguuJU
         4q+iP3Ft3cHH4ErZOPGjeg7os0RCiHp7X77E0krcI1yaCRfq73wGdwCfF/sImdHEM9BG
         /g8ZimZmmRmxw5xv1ztuU/39KON9cLUPk5OVtS7hMDaI994NM2/vGoalQvlKgDSRfXV0
         KBbg==
X-Gm-Message-State: ANhLgQ2vqutM67kvnCteE/wSVsYxqkQwYby29aSj77x+50Ta+5tIrzgF
        QAGGRAKtBtH7Np2GLZsxa+B8LyE5EWA=
X-Google-Smtp-Source: ADFU+vsBLiPvP0NqS4n0sAn14g5i8Q22CPBFYyKZHkEeQh1YEzfJ3Li8FMwYWgAS1Ga0RA2U4XU/PJ2i4UI=
X-Received: by 2002:a63:3187:: with SMTP id x129mr11282870pgx.180.1585275073883;
 Thu, 26 Mar 2020 19:11:13 -0700 (PDT)
Date:   Thu, 26 Mar 2020 19:10:53 -0700
In-Reply-To: <20200327021058.221911-1-walken@google.com>
Message-Id: <20200327021058.221911-6-walken@google.com>
Mime-Version: 1.0
References: <20200327021058.221911-1-walken@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v2 05/10] mmap locking API: convert mmap_sem call sites missed
 by coccinelle
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

Convert the last few remaining mmap_sem rwsem calls to use the new
mmap locking API. These were missed by coccinelle for some reason
(I think coccinelle does not support some of the preprocessor
constructs in these files ?)

Signed-off-by: Michel Lespinasse <walken@google.com>
---
 arch/mips/mm/fault.c           | 10 +++++-----
 arch/x86/kvm/mmu/paging_tmpl.h |  8 ++++----
 drivers/android/binder_alloc.c |  4 ++--
 fs/proc/base.c                 |  6 +++---
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index 1e8d00793784..c406250d7761 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -97,7 +97,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
 retry:
-	down_read(&mm->mmap_sem);
+	mmap_read_lock(mm);
 	vma = find_vma(mm, address);
 	if (!vma)
 		goto bad_area;
@@ -191,7 +191,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 		}
 	}
 
-	up_read(&mm->mmap_sem);
+	mmap_read_unlock(mm);
 	return;
 
 /*
@@ -199,7 +199,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
  * Fix it, but check if it's kernel or user first..
  */
 bad_area:
-	up_read(&mm->mmap_sem);
+	mmap_read_unlock(mm);
 
 bad_area_nosemaphore:
 	/* User mode accesses just cause a SIGSEGV */
@@ -251,14 +251,14 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 	 * We ran out of memory, call the OOM killer, and return the userspace
 	 * (which will retry the fault, or kill us if we got oom-killed).
 	 */
-	up_read(&mm->mmap_sem);
+	mmap_read_unlock(mm);
 	if (!user_mode(regs))
 		goto no_context;
 	pagefault_out_of_memory();
 	return;
 
 do_sigbus:
-	up_read(&mm->mmap_sem);
+	mmap_read_unlock(mm);
 
 	/* Kernel mode? Handle exceptions or die */
 	if (!user_mode(regs))
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index e4c8a4cbf407..8cbfe6c96d82 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -165,22 +165,22 @@ static int FNAME(cmpxchg_gpte)(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 		unsigned long pfn;
 		unsigned long paddr;
 
-		down_read(&current->mm->mmap_sem);
+		mmap_read_lock(current->mm);
 		vma = find_vma_intersection(current->mm, vaddr, vaddr + PAGE_SIZE);
 		if (!vma || !(vma->vm_flags & VM_PFNMAP)) {
-			up_read(&current->mm->mmap_sem);
+			mmap_read_unlock(current->mm);
 			return -EFAULT;
 		}
 		pfn = ((vaddr - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
 		paddr = pfn << PAGE_SHIFT;
 		table = memremap(paddr, PAGE_SIZE, MEMREMAP_WB);
 		if (!table) {
-			up_read(&current->mm->mmap_sem);
+			mmap_read_unlock(current->mm);
 			return -EFAULT;
 		}
 		ret = CMPXCHG(&table[index], orig_pte, new_pte);
 		memunmap(table);
-		up_read(&current->mm->mmap_sem);
+		mmap_read_unlock(current->mm);
 	}
 
 	return (ret != orig_pte);
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 5e063739a3a8..cbdc43ed0f9f 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -932,7 +932,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	mm = alloc->vma_vm_mm;
 	if (!mmget_not_zero(mm))
 		goto err_mmget;
-	if (!down_read_trylock(&mm->mmap_sem))
+	if (!mmap_read_trylock(mm))
 		goto err_down_read_mmap_sem_failed;
 	vma = binder_alloc_get_vma(alloc);
 
@@ -946,7 +946,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 
 		trace_binder_unmap_user_end(alloc, index);
 	}
-	up_read(&mm->mmap_sem);
+	mmap_read_unlock(mm);
 	mmput(mm);
 
 	trace_binder_unmap_kernel_start(alloc, index);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 479efdba60b9..0dc54b5d75f2 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2280,7 +2280,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 	if (!mm)
 		goto out_put_task;
 
-	ret = down_read_killable(&mm->mmap_sem);
+	ret = mmap_read_lock_killable(mm);
 	if (ret) {
 		mmput(mm);
 		goto out_put_task;
@@ -2307,7 +2307,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 		p = genradix_ptr_alloc(&fa, nr_files++, GFP_KERNEL);
 		if (!p) {
 			ret = -ENOMEM;
-			up_read(&mm->mmap_sem);
+			mmap_read_unlock(mm);
 			mmput(mm);
 			goto out_put_task;
 		}
@@ -2316,7 +2316,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 		p->end = vma->vm_end;
 		p->mode = vma->vm_file->f_mode;
 	}
-	up_read(&mm->mmap_sem);
+	mmap_read_unlock(mm);
 	mmput(mm);
 
 	for (i = 0; i < nr_files; i++) {
-- 
2.26.0.rc2.310.g2932bb562d-goog

