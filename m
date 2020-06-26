Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F40C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC562089D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+tfgZ9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgFZWhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:37:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42650 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726393AbgFZWg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593211016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w7iXcZhQYu4WM0y6dP2Yn9IEmieBN+tAo0TwngF+atA=;
        b=D+tfgZ9UexkaYbD3rCU6x7kL75THn6M8OZOlNRtMqjaoT3UVBje9CTG92JkJPJ6BgsXIVN
        C7ZyW5l7Y+vdWQMm1JvmHx1Zz6LnDnJtC1C0D4V+5/ZXxwQN/uXlHMWqOkYOolE/0WmgXd
        YYTaJOXZdwAtn8TfRp/34fX5i8bquso=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-tX0o6em6P-6PHpQd7c3bVw-1; Fri, 26 Jun 2020 18:36:52 -0400
X-MC-Unique: tX0o6em6P-6PHpQd7c3bVw-1
Received: by mail-qt1-f197.google.com with SMTP id s30so7511177qts.18
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w7iXcZhQYu4WM0y6dP2Yn9IEmieBN+tAo0TwngF+atA=;
        b=pjHGh1NNwSsS1jnGkeRL/4dmR505StUUq+gsHGd6DPegWHq2zCTDi0WKkYSO7GTOWv
         PIEo9Nrpa6bYwz5XJh24okbRzhAKUt25lNuN4aCrXPZuMaA28z6WaQJHX8/ogwsMP/Ab
         5S7RAp85c8Vuo4YT6rJ/M/50GX5N215+hGVexKIeQjgnhGCKpyaHOhboZtyCY2Y27Tr1
         HFv7IC14KaCKal/9/RHnAttOEWtqpHjtLP+ww+GMqkwM2o05kF494M3BZNpDuClWqO4c
         tFSTVJLS1yyRm8T0lD08F1GUM6m4HLFqG8xem9j0aCXUA2oOshd2g8GLKH0K0X/zWrXr
         W/jA==
X-Gm-Message-State: AOAM531UhL+9EmSmTTN2itZeZ42r8INJzMMMrWc1seRgf1OaO0JaB/Q0
        uByfXyBq7Z1BcUm5CXRAkcRd+GIYrWEgsgwI0kiYKhm23wfLkIeaN1fCoqCMl+BUA30ioHcA3sT
        Ge2AEzrLPd8Zw6RQGYTh9DH38
X-Received: by 2002:a37:887:: with SMTP id 129mr5000686qki.52.1593211010797;
        Fri, 26 Jun 2020 15:36:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvq92JUa05+mYjuhtdjTn/Kh7PHIgDVmSeW2WxL73f4sLi2Su/EUUgnRLsMPHzoQ7fjPyCxg==
X-Received: by 2002:a37:887:: with SMTP id 129mr5000652qki.52.1593211010334;
        Fri, 26 Jun 2020 15:36:50 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id t35sm4597525qth.79.2020.06.26.15.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:36:49 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 26/26] mm/gup: Remove task_struct pointer for all gup code
Date:   Fri, 26 Jun 2020 18:36:48 -0400
Message-Id: <20200626223648.200249-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626223130.199227-1-peterx@redhat.com>
References: <20200626223130.199227-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the cleanup of page fault accounting, gup does not need to pass
task_struct around any more.  Remove that parameter in the whole gup stack.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arc/kernel/process.c                   |  2 +-
 arch/s390/kvm/interrupt.c                   |  2 +-
 arch/s390/kvm/kvm-s390.c                    |  2 +-
 arch/s390/kvm/priv.c                        |  8 +-
 arch/s390/mm/gmap.c                         |  4 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c |  2 +-
 drivers/infiniband/core/umem_odp.c          |  2 +-
 drivers/vfio/vfio_iommu_type1.c             |  2 +-
 fs/exec.c                                   |  2 +-
 include/linux/mm.h                          |  9 +--
 kernel/events/uprobes.c                     |  6 +-
 kernel/futex.c                              |  2 +-
 mm/gup.c                                    | 90 +++++++++------------
 mm/memory.c                                 |  2 +-
 mm/process_vm_access.c                      |  2 +-
 security/tomoyo/domain.c                    |  2 +-
 virt/kvm/async_pf.c                         |  2 +-
 virt/kvm/kvm_main.c                         |  2 +-
 18 files changed, 63 insertions(+), 80 deletions(-)

diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index 315528f04bc1..2aad79ffc7f8 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -91,7 +91,7 @@ SYSCALL_DEFINE3(arc_usr_cmpxchg, int *, uaddr, int, expected, int, new)
 		 goto fail;
 
 	down_read(&current->mm->mmap_sem);
-	ret = fixup_user_fault(current, current->mm, (unsigned long) uaddr,
+	ret = fixup_user_fault(current->mm, (unsigned long) uaddr,
 			       FAULT_FLAG_WRITE, NULL);
 	up_read(&current->mm->mmap_sem);
 
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index bfb481134994..7f4c5895aabd 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2768,7 +2768,7 @@ static struct page *get_map_page(struct kvm *kvm, u64 uaddr)
 	struct page *page = NULL;
 
 	down_read(&kvm->mm->mmap_sem);
-	get_user_pages_remote(NULL, kvm->mm, uaddr, 1, FOLL_WRITE,
+	get_user_pages_remote(kvm->mm, uaddr, 1, FOLL_WRITE,
 			      &page, NULL, NULL);
 	up_read(&kvm->mm->mmap_sem);
 	return page;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d05bb040fd42..12fa299986f8 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1892,7 +1892,7 @@ static long kvm_s390_set_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
 
 		r = set_guest_storage_key(current->mm, hva, keys[i], 0);
 		if (r) {
-			r = fixup_user_fault(current, current->mm, hva,
+			r = fixup_user_fault(current->mm, hva,
 					     FAULT_FLAG_WRITE, &unlocked);
 			if (r)
 				break;
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 893893642415..45b7d5df72d7 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -274,7 +274,7 @@ static int handle_iske(struct kvm_vcpu *vcpu)
 	rc = get_guest_storage_key(current->mm, vmaddr, &key);
 
 	if (rc) {
-		rc = fixup_user_fault(current, current->mm, vmaddr,
+		rc = fixup_user_fault(current->mm, vmaddr,
 				      FAULT_FLAG_WRITE, &unlocked);
 		if (!rc) {
 			up_read(&current->mm->mmap_sem);
@@ -320,7 +320,7 @@ static int handle_rrbe(struct kvm_vcpu *vcpu)
 	down_read(&current->mm->mmap_sem);
 	rc = reset_guest_reference_bit(current->mm, vmaddr);
 	if (rc < 0) {
-		rc = fixup_user_fault(current, current->mm, vmaddr,
+		rc = fixup_user_fault(current->mm, vmaddr,
 				      FAULT_FLAG_WRITE, &unlocked);
 		if (!rc) {
 			up_read(&current->mm->mmap_sem);
@@ -391,7 +391,7 @@ static int handle_sske(struct kvm_vcpu *vcpu)
 						m3 & SSKE_MC);
 
 		if (rc < 0) {
-			rc = fixup_user_fault(current, current->mm, vmaddr,
+			rc = fixup_user_fault(current->mm, vmaddr,
 					      FAULT_FLAG_WRITE, &unlocked);
 			rc = !rc ? -EAGAIN : rc;
 		}
@@ -1095,7 +1095,7 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 			rc = cond_set_guest_storage_key(current->mm, vmaddr,
 							key, NULL, nq, mr, mc);
 			if (rc < 0) {
-				rc = fixup_user_fault(current, current->mm, vmaddr,
+				rc = fixup_user_fault(current->mm, vmaddr,
 						      FAULT_FLAG_WRITE, &unlocked);
 				rc = !rc ? -EAGAIN : rc;
 			}
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 1a95d8809cc3..0faf4f5f3fd4 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -649,7 +649,7 @@ int gmap_fault(struct gmap *gmap, unsigned long gaddr,
 		rc = vmaddr;
 		goto out_up;
 	}
-	if (fixup_user_fault(current, gmap->mm, vmaddr, fault_flags,
+	if (fixup_user_fault(gmap->mm, vmaddr, fault_flags,
 			     &unlocked)) {
 		rc = -EFAULT;
 		goto out_up;
@@ -879,7 +879,7 @@ static int gmap_pte_op_fixup(struct gmap *gmap, unsigned long gaddr,
 
 	BUG_ON(gmap_is_shadow(gmap));
 	fault_flags = (prot == PROT_WRITE) ? FAULT_FLAG_WRITE : 0;
-	if (fixup_user_fault(current, mm, vmaddr, fault_flags, &unlocked))
+	if (fixup_user_fault(mm, vmaddr, fault_flags, &unlocked))
 		return -EFAULT;
 	if (unlocked)
 		/* lost mmap_sem, caller has to retry __gmap_translate */
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
index 7ffd7afeb7a5..e87fa79c18d5 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
@@ -472,7 +472,7 @@ __i915_gem_userptr_get_pages_worker(struct work_struct *_work)
 					locked = 1;
 				}
 				ret = get_user_pages_remote
-					(work->task, mm,
+					(mm,
 					 obj->userptr.ptr + pinned * PAGE_SIZE,
 					 npages - pinned,
 					 flags,
diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 3b1e627d9a8d..73b1a01b7339 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -437,7 +437,7 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
 		 * complex (and doesn't gain us much performance in most use
 		 * cases).
 		 */
-		npages = get_user_pages_remote(owning_process, owning_mm,
+		npages = get_user_pages_remote(owning_mm,
 				user_virt, gup_num_pages,
 				flags, local_page_list, NULL, NULL);
 		up_read(&owning_mm->mmap_sem);
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index cc1d64765ce7..d77b34d6ee19 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -329,7 +329,7 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
 		flags |= FOLL_WRITE;
 
 	down_read(&mm->mmap_sem);
-	ret = pin_user_pages_remote(NULL, mm, vaddr, 1, flags | FOLL_LONGTERM,
+	ret = pin_user_pages_remote(mm, vaddr, 1, flags | FOLL_LONGTERM,
 				    page, NULL, NULL);
 	if (ret == 1) {
 		*pfn = page_to_pfn(page[0]);
diff --git a/fs/exec.c b/fs/exec.c
index 2c465119affc..f3f87911f3d0 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -213,7 +213,7 @@ static struct page *get_arg_page(struct linux_binprm *bprm, unsigned long pos,
 	 * We are doing an exec().  'current' is the process
 	 * doing the exec and bprm->mm is the new process's mm.
 	 */
-	ret = get_user_pages_remote(current, bprm->mm, pos, 1, gup_flags,
+	ret = get_user_pages_remote(bprm->mm, pos, 1, gup_flags,
 			&page, NULL, NULL);
 	if (ret <= 0)
 		return NULL;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 46bee4044ac1..5e347ffb049f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1655,7 +1655,7 @@ int invalidate_inode_page(struct page *page);
 extern vm_fault_t handle_mm_fault(struct vm_area_struct *vma,
 				  unsigned long address, unsigned int flags,
 				  struct pt_regs *regs);
-extern int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
+extern int fixup_user_fault(struct mm_struct *mm,
 			    unsigned long address, unsigned int fault_flags,
 			    bool *unlocked);
 void unmap_mapping_pages(struct address_space *mapping,
@@ -1671,8 +1671,7 @@ static inline vm_fault_t handle_mm_fault(struct vm_area_struct *vma,
 	BUG();
 	return VM_FAULT_SIGBUS;
 }
-static inline int fixup_user_fault(struct task_struct *tsk,
-		struct mm_struct *mm, unsigned long address,
+static inline int fixup_user_fault(struct mm_struct *mm, unsigned long address,
 		unsigned int fault_flags, bool *unlocked)
 {
 	/* should never happen if there's no MMU */
@@ -1698,11 +1697,11 @@ extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
 extern int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
 		unsigned long addr, void *buf, int len, unsigned int gup_flags);
 
-long get_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
+long get_user_pages_remote(struct mm_struct *mm,
 			    unsigned long start, unsigned long nr_pages,
 			    unsigned int gup_flags, struct page **pages,
 			    struct vm_area_struct **vmas, int *locked);
-long pin_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
+long pin_user_pages_remote(struct mm_struct *mm,
 			   unsigned long start, unsigned long nr_pages,
 			   unsigned int gup_flags, struct page **pages,
 			   struct vm_area_struct **vmas, int *locked);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ece7e13f6e4a..b7c9ad7e7d54 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -382,7 +382,7 @@ __update_ref_ctr(struct mm_struct *mm, unsigned long vaddr, short d)
 	if (!vaddr || !d)
 		return -EINVAL;
 
-	ret = get_user_pages_remote(NULL, mm, vaddr, 1,
+	ret = get_user_pages_remote(mm, vaddr, 1,
 			FOLL_WRITE, &page, &vma, NULL);
 	if (unlikely(ret <= 0)) {
 		/*
@@ -483,7 +483,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (is_register)
 		gup_flags |= FOLL_SPLIT_PMD;
 	/* Read the page with vaddr into memory */
-	ret = get_user_pages_remote(NULL, mm, vaddr, 1, gup_flags,
+	ret = get_user_pages_remote(mm, vaddr, 1, gup_flags,
 				    &old_page, &vma, NULL);
 	if (ret <= 0)
 		return ret;
@@ -2027,7 +2027,7 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
 	 * but we treat this as a 'remote' access since it is
 	 * essentially a kernel access to the memory.
 	 */
-	result = get_user_pages_remote(NULL, mm, vaddr, 1, FOLL_FORCE, &page,
+	result = get_user_pages_remote(mm, vaddr, 1, FOLL_FORCE, &page,
 			NULL, NULL);
 	if (result < 0)
 		return result;
diff --git a/kernel/futex.c b/kernel/futex.c
index b59532862bc0..1466b4322491 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -696,7 +696,7 @@ static int fault_in_user_writeable(u32 __user *uaddr)
 	int ret;
 
 	down_read(&mm->mmap_sem);
-	ret = fixup_user_fault(current, mm, (unsigned long)uaddr,
+	ret = fixup_user_fault(mm, (unsigned long)uaddr,
 			       FAULT_FLAG_WRITE, NULL);
 	up_read(&mm->mmap_sem);
 
diff --git a/mm/gup.c b/mm/gup.c
index 17b4d0c45a6b..b8eb02673c10 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -851,7 +851,7 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
  * does not include FOLL_NOWAIT, the mmap_sem may be released.  If it
  * is, *@locked will be set to 0 and -EBUSY returned.
  */
-static int faultin_page(struct task_struct *tsk, struct vm_area_struct *vma,
+static int faultin_page(struct vm_area_struct *vma,
 		unsigned long address, unsigned int *flags, int *locked)
 {
 	unsigned int fault_flags = 0;
@@ -954,7 +954,6 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 
 /**
  * __get_user_pages() - pin user pages in memory
- * @tsk:	task_struct of target task
  * @mm:		mm_struct of target mm
  * @start:	starting user address
  * @nr_pages:	number of pages from start to pin
@@ -1012,7 +1011,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
  * instead of __get_user_pages. __get_user_pages should be used only if
  * you need some special @gup_flags.
  */
-static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
+static long __get_user_pages(struct mm_struct *mm,
 		unsigned long start, unsigned long nr_pages,
 		unsigned int gup_flags, struct page **pages,
 		struct vm_area_struct **vmas, int *locked)
@@ -1088,8 +1087,7 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 
 		page = follow_page_mask(vma, start, foll_flags, &ctx);
 		if (!page) {
-			ret = faultin_page(tsk, vma, start, &foll_flags,
-					   locked);
+			ret = faultin_page(vma, start, &foll_flags, locked);
 			switch (ret) {
 			case 0:
 				goto retry;
@@ -1163,8 +1161,6 @@ static bool vma_permits_fault(struct vm_area_struct *vma,
 
 /*
  * fixup_user_fault() - manually resolve a user page fault
- * @tsk:	the task_struct to use for page fault accounting, or
- *		NULL if faults are not to be recorded.
  * @mm:		mm_struct of target mm
  * @address:	user address
  * @fault_flags:flags to pass down to handle_mm_fault()
@@ -1191,7 +1187,7 @@ static bool vma_permits_fault(struct vm_area_struct *vma,
  * This function will not return with an unlocked mmap_sem. So it has not the
  * same semantics wrt the @mm->mmap_sem as does filemap_fault().
  */
-int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
+int fixup_user_fault(struct mm_struct *mm,
 		     unsigned long address, unsigned int fault_flags,
 		     bool *unlocked)
 {
@@ -1236,8 +1232,7 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 }
 EXPORT_SYMBOL_GPL(fixup_user_fault);
 
-static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
-						struct mm_struct *mm,
+static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
 						unsigned long start,
 						unsigned long nr_pages,
 						struct page **pages,
@@ -1270,7 +1265,7 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
 	pages_done = 0;
 	lock_dropped = false;
 	for (;;) {
-		ret = __get_user_pages(tsk, mm, start, nr_pages, flags, pages,
+		ret = __get_user_pages(mm, start, nr_pages, flags, pages,
 				       vmas, locked);
 		if (!locked)
 			/* VM_FAULT_RETRY couldn't trigger, bypass */
@@ -1330,7 +1325,7 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
 		}
 
 		*locked = 1;
-		ret = __get_user_pages(tsk, mm, start, 1, flags | FOLL_TRIED,
+		ret = __get_user_pages(mm, start, 1, flags | FOLL_TRIED,
 				       pages, NULL, locked);
 		if (!*locked) {
 			/* Continue to retry until we succeeded */
@@ -1416,7 +1411,7 @@ long populate_vma_page_range(struct vm_area_struct *vma,
 	 * We made sure addr is within a VMA, so the following will
 	 * not result in a stack expansion that recurses back here.
 	 */
-	return __get_user_pages(current, mm, start, nr_pages, gup_flags,
+	return __get_user_pages(mm, start, nr_pages, gup_flags,
 				NULL, NULL, locked);
 }
 
@@ -1500,7 +1495,7 @@ struct page *get_dump_page(unsigned long addr)
 	struct vm_area_struct *vma;
 	struct page *page;
 
-	if (__get_user_pages(current, current->mm, addr, 1,
+	if (__get_user_pages(current->mm, addr, 1,
 			     FOLL_FORCE | FOLL_DUMP | FOLL_GET, &page, &vma,
 			     NULL) < 1)
 		return NULL;
@@ -1509,8 +1504,7 @@ struct page *get_dump_page(unsigned long addr)
 }
 #endif /* CONFIG_ELF_CORE */
 #else /* CONFIG_MMU */
-static long __get_user_pages_locked(struct task_struct *tsk,
-		struct mm_struct *mm, unsigned long start,
+static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
 		unsigned long nr_pages, struct page **pages,
 		struct vm_area_struct **vmas, int *locked,
 		unsigned int foll_flags)
@@ -1626,8 +1620,7 @@ static struct page *new_non_cma_page(struct page *page, unsigned long private)
 	return __alloc_pages_node(nid, gfp_mask, 0);
 }
 
-static long check_and_migrate_cma_pages(struct task_struct *tsk,
-					struct mm_struct *mm,
+static long check_and_migrate_cma_pages(struct mm_struct *mm,
 					unsigned long start,
 					unsigned long nr_pages,
 					struct page **pages,
@@ -1701,7 +1694,7 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
 		 * again migrating any new CMA pages which we failed to isolate
 		 * earlier.
 		 */
-		ret = __get_user_pages_locked(tsk, mm, start, nr_pages,
+		ret = __get_user_pages_locked(mm, start, nr_pages,
 						   pages, vmas, NULL,
 						   gup_flags);
 
@@ -1715,8 +1708,7 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
 	return ret;
 }
 #else
-static long check_and_migrate_cma_pages(struct task_struct *tsk,
-					struct mm_struct *mm,
+static long check_and_migrate_cma_pages(struct mm_struct *mm,
 					unsigned long start,
 					unsigned long nr_pages,
 					struct page **pages,
@@ -1731,8 +1723,7 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
  * __gup_longterm_locked() is a wrapper for __get_user_pages_locked which
  * allows us to process the FOLL_LONGTERM flag.
  */
-static long __gup_longterm_locked(struct task_struct *tsk,
-				  struct mm_struct *mm,
+static long __gup_longterm_locked(struct mm_struct *mm,
 				  unsigned long start,
 				  unsigned long nr_pages,
 				  struct page **pages,
@@ -1757,7 +1748,7 @@ static long __gup_longterm_locked(struct task_struct *tsk,
 		flags = memalloc_nocma_save();
 	}
 
-	rc = __get_user_pages_locked(tsk, mm, start, nr_pages, pages,
+	rc = __get_user_pages_locked(mm, start, nr_pages, pages,
 				     vmas_tmp, NULL, gup_flags);
 
 	if (gup_flags & FOLL_LONGTERM) {
@@ -1772,7 +1763,7 @@ static long __gup_longterm_locked(struct task_struct *tsk,
 			goto out;
 		}
 
-		rc = check_and_migrate_cma_pages(tsk, mm, start, rc, pages,
+		rc = check_and_migrate_cma_pages(mm, start, rc, pages,
 						 vmas_tmp, gup_flags);
 	}
 
@@ -1782,22 +1773,20 @@ static long __gup_longterm_locked(struct task_struct *tsk,
 	return rc;
 }
 #else /* !CONFIG_FS_DAX && !CONFIG_CMA */
-static __always_inline long __gup_longterm_locked(struct task_struct *tsk,
-						  struct mm_struct *mm,
+static __always_inline long __gup_longterm_locked(struct mm_struct *mm,
 						  unsigned long start,
 						  unsigned long nr_pages,
 						  struct page **pages,
 						  struct vm_area_struct **vmas,
 						  unsigned int flags)
 {
-	return __get_user_pages_locked(tsk, mm, start, nr_pages, pages, vmas,
+	return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
 				       NULL, flags);
 }
 #endif /* CONFIG_FS_DAX || CONFIG_CMA */
 
 #ifdef CONFIG_MMU
-static long __get_user_pages_remote(struct task_struct *tsk,
-				    struct mm_struct *mm,
+static long __get_user_pages_remote(struct mm_struct *mm,
 				    unsigned long start, unsigned long nr_pages,
 				    unsigned int gup_flags, struct page **pages,
 				    struct vm_area_struct **vmas, int *locked)
@@ -1816,20 +1805,18 @@ static long __get_user_pages_remote(struct task_struct *tsk,
 		 * This will check the vmas (even if our vmas arg is NULL)
 		 * and return -ENOTSUPP if DAX isn't allowed in this case:
 		 */
-		return __gup_longterm_locked(tsk, mm, start, nr_pages, pages,
+		return __gup_longterm_locked(mm, start, nr_pages, pages,
 					     vmas, gup_flags | FOLL_TOUCH |
 					     FOLL_REMOTE);
 	}
 
-	return __get_user_pages_locked(tsk, mm, start, nr_pages, pages, vmas,
+	return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
 				       locked,
 				       gup_flags | FOLL_TOUCH | FOLL_REMOTE);
 }
 
 /*
  * get_user_pages_remote() - pin user pages in memory
- * @tsk:	the task_struct to use for page fault accounting, or
- *		NULL if faults are not to be recorded.
  * @mm:		mm_struct of target mm
  * @start:	starting user address
  * @nr_pages:	number of pages from start to pin
@@ -1888,7 +1875,7 @@ static long __get_user_pages_remote(struct task_struct *tsk,
  * should use get_user_pages because it cannot pass
  * FAULT_FLAG_ALLOW_RETRY to handle_mm_fault.
  */
-long get_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
+long get_user_pages_remote(struct mm_struct *mm,
 		unsigned long start, unsigned long nr_pages,
 		unsigned int gup_flags, struct page **pages,
 		struct vm_area_struct **vmas, int *locked)
@@ -1900,13 +1887,13 @@ long get_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
 	if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
 		return -EINVAL;
 
-	return __get_user_pages_remote(tsk, mm, start, nr_pages, gup_flags,
+	return __get_user_pages_remote(mm, start, nr_pages, gup_flags,
 				       pages, vmas, locked);
 }
 EXPORT_SYMBOL(get_user_pages_remote);
 
 #else /* CONFIG_MMU */
-long get_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
+long get_user_pages_remote(struct mm_struct *mm,
 			   unsigned long start, unsigned long nr_pages,
 			   unsigned int gup_flags, struct page **pages,
 			   struct vm_area_struct **vmas, int *locked)
@@ -1914,8 +1901,7 @@ long get_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
 	return 0;
 }
 
-static long __get_user_pages_remote(struct task_struct *tsk,
-				    struct mm_struct *mm,
+static long __get_user_pages_remote(struct mm_struct *mm,
 				    unsigned long start, unsigned long nr_pages,
 				    unsigned int gup_flags, struct page **pages,
 				    struct vm_area_struct **vmas, int *locked)
@@ -1942,7 +1928,7 @@ long get_user_pages(unsigned long start, unsigned long nr_pages,
 	if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
 		return -EINVAL;
 
-	return __gup_longterm_locked(current, current->mm, start, nr_pages,
+	return __gup_longterm_locked(current->mm, start, nr_pages,
 				     pages, vmas, gup_flags | FOLL_TOUCH);
 }
 EXPORT_SYMBOL(get_user_pages);
@@ -1956,7 +1942,7 @@ EXPORT_SYMBOL(get_user_pages);
  *
  *      down_read(&mm->mmap_sem);
  *      do_something()
- *      get_user_pages(tsk, mm, ..., pages, NULL);
+ *      get_user_pages(mm, ..., pages, NULL);
  *      up_read(&mm->mmap_sem);
  *
  *  to:
@@ -1964,7 +1950,7 @@ EXPORT_SYMBOL(get_user_pages);
  *      int locked = 1;
  *      down_read(&mm->mmap_sem);
  *      do_something()
- *      get_user_pages_locked(tsk, mm, ..., pages, &locked);
+ *      get_user_pages_locked(mm, ..., pages, &locked);
  *      if (locked)
  *          up_read(&mm->mmap_sem);
  */
@@ -1981,7 +1967,7 @@ long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
 	if (WARN_ON_ONCE(gup_flags & FOLL_LONGTERM))
 		return -EINVAL;
 
-	return __get_user_pages_locked(current, current->mm, start, nr_pages,
+	return __get_user_pages_locked(current->mm, start, nr_pages,
 				       pages, NULL, locked,
 				       gup_flags | FOLL_TOUCH);
 }
@@ -1991,12 +1977,12 @@ EXPORT_SYMBOL(get_user_pages_locked);
  * get_user_pages_unlocked() is suitable to replace the form:
  *
  *      down_read(&mm->mmap_sem);
- *      get_user_pages(tsk, mm, ..., pages, NULL);
+ *      get_user_pages(mm, ..., pages, NULL);
  *      up_read(&mm->mmap_sem);
  *
  *  with:
  *
- *      get_user_pages_unlocked(tsk, mm, ..., pages);
+ *      get_user_pages_unlocked(mm, ..., pages);
  *
  * It is functionally equivalent to get_user_pages_fast so
  * get_user_pages_fast should be used instead if specific gup_flags
@@ -2019,7 +2005,7 @@ long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 		return -EINVAL;
 
 	down_read(&mm->mmap_sem);
-	ret = __get_user_pages_locked(current, mm, start, nr_pages, pages, NULL,
+	ret = __get_user_pages_locked(mm, start, nr_pages, pages, NULL,
 				      &locked, gup_flags | FOLL_TOUCH);
 	if (locked)
 		up_read(&mm->mmap_sem);
@@ -2720,7 +2706,7 @@ static int __gup_longterm_unlocked(unsigned long start, int nr_pages,
 	 */
 	if (gup_flags & FOLL_LONGTERM) {
 		down_read(&current->mm->mmap_sem);
-		ret = __gup_longterm_locked(current, current->mm,
+		ret = __gup_longterm_locked(current->mm,
 					    start, nr_pages,
 					    pages, NULL, gup_flags);
 		up_read(&current->mm->mmap_sem);
@@ -2850,10 +2836,8 @@ int pin_user_pages_fast(unsigned long start, int nr_pages,
 EXPORT_SYMBOL_GPL(pin_user_pages_fast);
 
 /**
- * pin_user_pages_remote() - pin pages of a remote process (task != current)
+ * pin_user_pages_remote() - pin pages of a remote process
  *
- * @tsk:	the task_struct to use for page fault accounting, or
- *		NULL if faults are not to be recorded.
  * @mm:		mm_struct of target mm
  * @start:	starting user address
  * @nr_pages:	number of pages from start to pin
@@ -2877,7 +2861,7 @@ EXPORT_SYMBOL_GPL(pin_user_pages_fast);
  * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_pages.rst. It
  * is NOT intended for Case 2 (RDMA: long-term pins).
  */
-long pin_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
+long pin_user_pages_remote(struct mm_struct *mm,
 			   unsigned long start, unsigned long nr_pages,
 			   unsigned int gup_flags, struct page **pages,
 			   struct vm_area_struct **vmas, int *locked)
@@ -2887,7 +2871,7 @@ long pin_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
 		return -EINVAL;
 
 	gup_flags |= FOLL_PIN;
-	return __get_user_pages_remote(tsk, mm, start, nr_pages, gup_flags,
+	return __get_user_pages_remote(mm, start, nr_pages, gup_flags,
 				       pages, vmas, locked);
 }
 EXPORT_SYMBOL(pin_user_pages_remote);
@@ -2922,7 +2906,7 @@ long pin_user_pages(unsigned long start, unsigned long nr_pages,
 		return -EINVAL;
 
 	gup_flags |= FOLL_PIN;
-	return __gup_longterm_locked(current, current->mm, start, nr_pages,
+	return __gup_longterm_locked(current->mm, start, nr_pages,
 				     pages, vmas, gup_flags);
 }
 EXPORT_SYMBOL(pin_user_pages);
diff --git a/mm/memory.c b/mm/memory.c
index 0b3c747cd2b3..65576e3b382f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4739,7 +4739,7 @@ int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
 		void *maddr;
 		struct page *page = NULL;
 
-		ret = get_user_pages_remote(tsk, mm, addr, 1,
+		ret = get_user_pages_remote(mm, addr, 1,
 				gup_flags, &page, &vma, NULL);
 		if (ret <= 0) {
 #ifndef CONFIG_HAVE_IOREMAP_PROT
diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
index 74e957e302fe..5523464d0ab5 100644
--- a/mm/process_vm_access.c
+++ b/mm/process_vm_access.c
@@ -105,7 +105,7 @@ static int process_vm_rw_single_vec(unsigned long addr,
 		 * current/current->mm
 		 */
 		down_read(&mm->mmap_sem);
-		pinned_pages = pin_user_pages_remote(task, mm, pa, pinned_pages,
+		pinned_pages = pin_user_pages_remote(mm, pa, pinned_pages,
 						     flags, process_pages,
 						     NULL, &locked);
 		if (locked)
diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index 7869d6a9980b..afe5e68ede77 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -914,7 +914,7 @@ bool tomoyo_dump_page(struct linux_binprm *bprm, unsigned long pos,
 	 * (represented by bprm).  'current' is the process doing
 	 * the execve().
 	 */
-	if (get_user_pages_remote(current, bprm->mm, pos, 1,
+	if (get_user_pages_remote(bprm->mm, pos, 1,
 				FOLL_FORCE, &page, NULL, NULL) <= 0)
 		return false;
 #else
diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
index 15e5b037f92d..73098e18baaf 100644
--- a/virt/kvm/async_pf.c
+++ b/virt/kvm/async_pf.c
@@ -60,7 +60,7 @@ static void async_pf_execute(struct work_struct *work)
 	 * access remotely.
 	 */
 	down_read(&mm->mmap_sem);
-	get_user_pages_remote(NULL, mm, addr, 1, FOLL_WRITE, NULL, NULL,
+	get_user_pages_remote(mm, addr, 1, FOLL_WRITE, NULL, NULL,
 			&locked);
 	if (locked)
 		up_read(&mm->mmap_sem);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 731c1e517716..3e1b2ec4ec96 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1829,7 +1829,7 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 		 * not call the fault handler, so do it here.
 		 */
 		bool unlocked = false;
-		r = fixup_user_fault(current, current->mm, addr,
+		r = fixup_user_fault(current->mm, addr,
 				     (write_fault ? FAULT_FLAG_WRITE : 0),
 				     &unlocked);
 		if (unlocked)
-- 
2.26.2

