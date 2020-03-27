Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8953FC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5212E2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k0FbyRqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgC0WvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:51:21 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:41985 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbgC0WvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 18:51:18 -0400
Received: by mail-pl1-f202.google.com with SMTP id g7so8142313plj.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 15:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=86ZhzKm5T/6O9jpZoUxqs4yVA0IM57Jhl4+KLMoCVFw=;
        b=k0FbyRqkOXxRQlfvn1N+cnDG8L1/+HDAoR54lNZ3beA68vtZsiUw5DITNAshJ/ArYi
         SOAd4ZMMV3FGcrxeKmjC8sQovLZk7wcgo4KGv5l1c6VjbDSnxm49GVMnNWERqXidi4xC
         7xhe5z7low3mrkO3wUnK+MuVRdEo7mfElKRSmCh5FYcDJEtJ2qZ7IV5eWgyrwiUF0OAx
         VPROWPNVXdj227MglU9n1d8myzv1vhZ2wic5PPna/oK2qfYiPMX5FztMkjnmKJOKR6mJ
         dhqWRH1KqcLE17OEu323a/YRtwLg3GVfptB/YWk7ImNd1qW7Z1QoTqOcClMr7g6szJit
         gp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=86ZhzKm5T/6O9jpZoUxqs4yVA0IM57Jhl4+KLMoCVFw=;
        b=n60TuANUfN/qLI84Pthck522b4sKW44jfq2DDR0pUYN2uMsdyTpzIjrvtUdkbr3lKn
         e/Lr5MVcCdERw7brrdypjD3MsdaW6rHl9uh3Ilt5GEBta34653WMK1rvOf1YOUEkCSXX
         p8gOslWsKA3GaZkE531H+NO8iI0GrRYX0CITDXfCo3bbVVpeOM4RteGvVlL+4VxR72KK
         w6bWZJgbchN7/dfEXWdfYc+R5Lx74SLP75jLGBr+/CvGM49aUpZs/jOUZVh0EFUJLRpy
         Hon9Anqcbcxg7gDEhODowNFTwLV34cFeHeDYo/KFT1WPCP4EhRRG1p+NhOqX6DcMNZls
         LZmQ==
X-Gm-Message-State: ANhLgQ1nDjaAsaCz6AvGbDrxSLL3j3N4AmKuuTnqdXr2dOyeWPG9arep
        X6PHOwsyYJO8nNDX+Qus1Oi/vT2UNZ0=
X-Google-Smtp-Source: ADFU+vsPrkID+VTQJXNWuRyxzO+kSp+fAxL/4uWtlgDKm8F2KMwVHD0zZJREluBLHhPyNtq0IKWMj4lzQNs=
X-Received: by 2002:a17:90a:9409:: with SMTP id r9mr1775117pjo.39.1585349476789;
 Fri, 27 Mar 2020 15:51:16 -0700 (PDT)
Date:   Fri, 27 Mar 2020 15:50:57 -0700
In-Reply-To: <20200327225102.25061-1-walken@google.com>
Message-Id: <20200327225102.25061-6-walken@google.com>
Mime-Version: 1.0
References: <20200327225102.25061-1-walken@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v3 05/10] mmap locking API: convert mmap_sem call sites missed
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

