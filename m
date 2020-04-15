Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67CEC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADD5A20737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VWarSvlp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634647AbgDOApe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 20:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2634606AbgDOAoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 20:44:09 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DC3C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:44:08 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 18so1386986pfu.22
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ad1osA7PXp9TaJziz5RfxCmgCGDDxR2XQUquw95G3RM=;
        b=VWarSvlp+scq0rhdkrZI9ThmO16dKdGS3hD3dQ0o99du+Bt6HRuwpoZk6OJvNIsiTq
         6TAOthei3FwJ8wgdk/Gr0tLlHe0+kthwZP9pNPCgQme5sv0rw01DdqBEiDzdI8I3F6rm
         dPrRQUCsLxmnbTSahs0+bAYEdkowfA8dJXP492H7egotom+NbXcYh7KnKicjsn9zwuR9
         Qz2gC1ISYDJ776NxEECfK2iog5SO+KtOgSpOGbT/ApkP24/Pbt4t/V8epVgTuTt5BCEA
         XOKclDXDRd8yR4kzUXpWc/UENkcoxMz9pqF5yvp9bKhFxJk3wx1N3gclcN9pOABX5qZ2
         +jFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ad1osA7PXp9TaJziz5RfxCmgCGDDxR2XQUquw95G3RM=;
        b=X8p+SZxhSdGFueXaDZ/cx2H1ljRNatOX1RVzvha31r2ZmowCGxBxR7FAUoTenoEEbe
         L81pBqrXbkWPRXM6CCGEfRCSXD/wMUhCUmhf0Rafp3ZxY1Gvv6JrQ6/Y31qAijTHgyJZ
         34odI7UJxAWQlmVPpBA3kebXGbFp46qkT5S9M2q+BssHcUMVguM/sbK+eNUA2pslxvFC
         2f7/5I/4Q6gWV3Y+MPr90VShqQ0vZEP7eO9c9EcwrhuhCpSRpTcwprInt0+Kggc6X+St
         qKw8yA9nfrBK3o1cKw1ypJazmFMKHcYghob+QYdvJUBucNaRSfVdv7FNBjpWLM/eA1Pd
         Bxhw==
X-Gm-Message-State: AGi0PuamETvNw8IhoOwde3Cb9X3o+N1RT90jdlRdRG/lA5csfx4vKzFy
        YB+utQovbaCAZ9xAFNhVkuzzPTf73dM=
X-Google-Smtp-Source: APiQypJqGWzbv/IHIQQD+XaFi8o4HCrVN04+rqrNa9XLspAWlJs+rQikkwClVR7yHo+ZXfHFtSStaZPnY4g=
X-Received: by 2002:a17:90a:3268:: with SMTP id k95mr2933353pjb.185.1586911448288;
 Tue, 14 Apr 2020 17:44:08 -0700 (PDT)
Date:   Tue, 14 Apr 2020 17:43:48 -0700
In-Reply-To: <20200415004353.130248-1-walken@google.com>
Message-Id: <20200415004353.130248-6-walken@google.com>
Mime-Version: 1.0
References: <20200415004353.130248-1-walken@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v4 05/10] mmap locking API: convert mmap_sem call sites missed
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
 arch/x86/kvm/mmu/paging_tmpl.h |  8 ++++----
 drivers/android/binder_alloc.c |  4 ++--
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
index f0a566ccf193..6e321d1f2c03 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2302,7 +2302,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 	if (!mm)
 		goto out_put_task;
 
-	ret = down_read_killable(&mm->mmap_sem);
+	ret = mmap_read_lock_killable(mm);
 	if (ret) {
 		mmput(mm);
 		goto out_put_task;
@@ -2329,7 +2329,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 		p = genradix_ptr_alloc(&fa, nr_files++, GFP_KERNEL);
 		if (!p) {
 			ret = -ENOMEM;
-			up_read(&mm->mmap_sem);
+			mmap_read_unlock(mm);
 			mmput(mm);
 			goto out_put_task;
 		}
@@ -2338,7 +2338,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 		p->end = vma->vm_end;
 		p->mode = vma->vm_file->f_mode;
 	}
-	up_read(&mm->mmap_sem);
+	mmap_read_unlock(mm);
 	mmput(mm);
 
 	for (i = 0; i < nr_files; i++) {
-- 
2.26.0.110.g2183baf09c-goog

