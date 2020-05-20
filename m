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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30766C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 05:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01B60206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 05:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X2HfS2iP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgETF3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 01:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgETF3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 01:29:24 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2AEC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 22:29:23 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id b7so2653622qkk.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 22:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iUQAQwjeTdjADWMHXjV24t8dshji+euZ7/BX2PR6hJI=;
        b=X2HfS2iPbhCq77UBHBEJ0NtU4FVLJRAnApEMYAUipusGDS+1MQ/kbsH7HS+a6y4lnk
         3gEJjSZg6ODgtoON3/eAD8Df9vyNZICg7lv8wpq9CWcSkg3Jt6c3FmZy5cIR7HMmYbEi
         5OV+Le1BUemogXPjQuspI540g+3RCiAm0enCxKiw4O7bngpDZ35/fhwpCueerLzVjbAT
         HvVzUOwAoae5p+2ImOhJBDt/mHzlbwKK5QMiPmDhLFbJsImAuCpl0s92tI2oLZ7DOEXC
         qHNXMa61vLK5rBe4Hj/kLpugK2eZKbTzjq5E84V5Qqt4z3pgAIeC1sCufj/0xdeluPwR
         Q+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iUQAQwjeTdjADWMHXjV24t8dshji+euZ7/BX2PR6hJI=;
        b=b279cEZzPF7EG34LSFYpDUoVBc4e0hgj3SGkhqe7dH8G4/qsemLKPf/k2wc/eLtFYp
         osT+n3mVhYmdaKu8OCI78GY/GopGNOkOvxpprhW/bnxwpWhPhyexbj9ze2xwgJbE3JcT
         7v9pzLrCHfXatbaPHGV7tgawsNODZuVMwpX/JALXAL7WCoLMyI1mCq5ZDC/t6cH/Wt6H
         YTF325AAcXkvPGD5mLyQ+xZtdOM1eyWZtn8PYuu8Y3TMMqk+c+0uW2eenwQoTE0ffU8i
         4+qWx+A41hXYDsRlAcFC6cWgHwl14QaeSVPl+dDFEv+WJxShUMlY8pNvALxIyLNwhPYK
         s0QA==
X-Gm-Message-State: AOAM532GvAjtnrU1ExIYsg+AABFhGJvsQklvFqGMc4Cm+CvVv10OyyJY
        xjA3+xJWDMOscP0oDaScPSXoI3jjIzo=
X-Google-Smtp-Source: ABdhPJyGwCqd7fRUzPbQ1HC0xGHtWGpAikajrR8GnCma/8xsXwVRv0KFiXH47Iach63Sh3kFUmqj1qlKUi8=
X-Received: by 2002:a05:6214:90e:: with SMTP id dj14mr3124544qvb.3.1589952562922;
 Tue, 19 May 2020 22:29:22 -0700 (PDT)
Date:   Tue, 19 May 2020 22:29:01 -0700
In-Reply-To: <20200520052908.204642-1-walken@google.com>
Message-Id: <20200520052908.204642-6-walken@google.com>
Mime-Version: 1.0
References: <20200520052908.204642-1-walken@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v6 05/12] mmap locking API: convert mmap_sem call sites missed
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
        John Hubbard <jhubbard@nvidia.com>,
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
Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 arch/mips/mm/fault.c           | 10 +++++-----
 arch/riscv/mm/pageattr.c       |  4 ++--
 arch/x86/kvm/mmu/paging_tmpl.h |  8 ++++----
 fs/proc/base.c                 |  6 +++---
 4 files changed, 14 insertions(+), 14 deletions(-)

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
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9a68032d8d73..a96377557db7 100644
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
2.26.2.761.g0e0b3e54be-goog

