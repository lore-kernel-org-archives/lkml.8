Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFEFC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7975820735
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JWU5WHFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgDVAOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 20:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgDVAOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 20:14:37 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D58C061BD3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:14:37 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id j21so209699pgh.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8FnslH4tR73JosMxXTOPIZuRsegD1R4BjGmc4H1Efbk=;
        b=JWU5WHFaC45VBv/xrFjMK7OwdpuKWWSegf6NvVAZ6UEABOcKKTcG2oQcKQGx/5Q0dG
         C41bjPBmBF80jU5649PBGjRPBEEtWj4mRcBSpdiZq0DbZECJjSJR/v/0rc2ML/GcR6br
         EibBNdDZg9sUGT5UYh1Lq8a7SegYBt6HJvouDcBnHNy0NimkjP3UYjzMnczDDXQgoJsO
         wXZ7hEbZVKEph3QVNLNxW/oBEXPqiJ+WVJbn46jHkKLvZbh+eA1O+rcBeCW7jTXpQYwD
         48CwqB//5AWQ6M0hRZ9VQ/MpalnRFOQ7Hr3MGNwHVu0osB544qPIfo7USYhnP40RziD2
         VPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8FnslH4tR73JosMxXTOPIZuRsegD1R4BjGmc4H1Efbk=;
        b=Ry61/s5wKJz5ss3SC6FcBE3LlaDJlKrFQdCz1WlL6/UwgtTtsoRft7vAAkXZHAv8B7
         NC5r1W3zoRHHnigmJh099mNV8tzdEwCpu9YEN1zCW7IDFlh17V8MjRztcntgM1S7wTfE
         nodarDziSD1r5CXmWFRUwEe4qwbMW7Rfer0q72LQwA/KAUbIzigdtErZuAc38hTh0FrR
         0kdcJrJgRh9pA5NPYhBW1yC3I+1d6J5OV0wv9LCvSidgs1wtgNus/FigS1mzLCRccZ6B
         14uiMF39yuEeSnaob/fzkykNzupUpIlcqP/ePIqllGpCtGPCW+Jb+fbV1HejVEL7I6qe
         Cpow==
X-Gm-Message-State: AGi0PuZTr/C+xKIxAVDXEVDiL/htWARDh/WvCFOMUkTsNUpV41oLgcGu
        bIiiytU+O1YWsPQlviiOJKYEjCLar8U=
X-Google-Smtp-Source: APiQypIBKQRhS5e8bQazNSaQQz7nGVHZINlqTrrBi2XxI6F8bbYraDwiumiKajFnM935JXcNODoWe9B04m0=
X-Received: by 2002:a17:90b:3444:: with SMTP id lj4mr8239893pjb.37.1587514476777;
 Tue, 21 Apr 2020 17:14:36 -0700 (PDT)
Date:   Tue, 21 Apr 2020 17:14:17 -0700
In-Reply-To: <20200422001422.232330-1-walken@google.com>
Message-Id: <20200422001422.232330-6-walken@google.com>
Mime-Version: 1.0
References: <20200422001422.232330-1-walken@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v5 05/10] mmap locking API: convert mmap_sem call sites missed
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
        Daniel Jordan <daniel.m.jordan@oracle.com>,
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
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 arch/mips/mm/fault.c           | 10 +++++-----
 arch/riscv/mm/pageattr.c       |  4 ++--
 arch/x86/kvm/mmu/paging_tmpl.h |  8 ++++----
 drivers/android/binder_alloc.c |  4 ++--
 fs/proc/base.c                 |  6 +++---
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index f8d62cd83b36..9ef2dd39111e 100644
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
@@ -190,7 +190,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 		}
 	}
 
-	up_read(&mm->mmap_sem);
+	mmap_read_unlock(mm);
 	return;
 
 /*
@@ -198,7 +198,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
  * Fix it, but check if it's kernel or user first..
  */
 bad_area:
-	up_read(&mm->mmap_sem);
+	mmap_read_unlock(mm);
 
 bad_area_nosemaphore:
 	/* User mode accesses just cause a SIGSEGV */
@@ -250,14 +250,14 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
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
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 728759eb530a..b9072c043222 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -117,10 +117,10 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
 	if (!numpages)
 		return 0;
 
-	down_read(&init_mm.mmap_sem);
+	mmap_read_lock(&init_mm);
 	ret =  walk_page_range_novma(&init_mm, start, end, &pageattr_ops, NULL,
 				     &masks);
-	up_read(&init_mm.mmap_sem);
+	mmap_read_unlock(&init_mm);
 
 	flush_tlb_kernel_range(start, end);
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 9bdf9b7d9a96..40e5bb67cc09 100644
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
index 8fff3c955530..ebb356434652 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2314,7 +2314,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 	if (!mm)
 		goto out_put_task;
 
-	ret = down_read_killable(&mm->mmap_sem);
+	ret = mmap_read_lock_killable(mm);
 	if (ret) {
 		mmput(mm);
 		goto out_put_task;
@@ -2341,7 +2341,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 		p = genradix_ptr_alloc(&fa, nr_files++, GFP_KERNEL);
 		if (!p) {
 			ret = -ENOMEM;
-			up_read(&mm->mmap_sem);
+			mmap_read_unlock(mm);
 			mmput(mm);
 			goto out_put_task;
 		}
@@ -2350,7 +2350,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 		p->end = vma->vm_end;
 		p->mode = vma->vm_file->f_mode;
 	}
-	up_read(&mm->mmap_sem);
+	mmap_read_unlock(mm);
 	mmput(mm);
 
 	for (i = 0; i < nr_files; i++) {
-- 
2.26.1.301.g55bc3eb7cb9-goog

