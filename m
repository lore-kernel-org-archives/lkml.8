Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C391C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C513420781
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="DQ7IQv9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgGAVzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:55:42 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16214 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgGAVzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 17:55:41 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efd062a0000>; Wed, 01 Jul 2020 14:54:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 01 Jul 2020 14:55:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 01 Jul 2020 14:55:41 -0700
Received: from [10.2.54.200] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Jul
 2020 21:55:40 +0000
Subject: Re: [PATCH v4 26/26] mm/gup: Remove task_struct pointer for all gup
 code
To:     Peter Xu <peterx@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>
References: <20200630204609.39736-1-peterx@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <a5b6caba-28bf-4869-d1c9-984136f9f77b@nvidia.com>
Date:   Wed, 1 Jul 2020 14:55:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630204609.39736-1-peterx@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593640491; bh=q03RG/caAiuZnuuzWMpKRYJJzobpFqspHXM98/TezRU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=DQ7IQv9PCGEClbt8LuiCUBA0QutJhPnn0WavINaQVA4WNNpiz+e/sgbIhDiY0ZJ4O
         wAcvQQ8agAdp9891EelPWE3JnXDQLOpJwPRDEgzWpNVPkluD/qm6E8QpcoBqOllb3M
         h3zu2t7ciRT1uoOSfuvCSBkGA39i0nRqALMoWmRRmAIv/NZD2LJcK394wgVgha9xx3
         mrmtJtCSJgtpS5US7WP+pjrh7B671pYpzBU2bPXPpw8OxgKhQW8iFMEUotsTpUwO1h
         EToyy0vUVwWcHFa6HNpvTsOa7uO7Dv6jXLzT50kE0qUMEhY3VRXJmnrPTSXyKFCe4U
         rrFPoF+XvlDTg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-30 13:46, Peter Xu wrote:
> After the cleanup of page fault accounting, gup does not need to pass
> task_struct around any more.  Remove that parameter in the whole gup stack.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   arch/arc/kernel/process.c                   |  2 +-
>   arch/s390/kvm/interrupt.c                   |  2 +-
>   arch/s390/kvm/kvm-s390.c                    |  2 +-
>   arch/s390/kvm/priv.c                        |  8 +-
>   arch/s390/mm/gmap.c                         |  4 +-
>   drivers/gpu/drm/i915/gem/i915_gem_userptr.c |  2 +-
>   drivers/infiniband/core/umem_odp.c          |  2 +-
>   drivers/vfio/vfio_iommu_type1.c             |  4 +-
>   fs/exec.c                                   |  2 +-
>   include/linux/mm.h                          |  9 +-
>   kernel/events/uprobes.c                     |  6 +-
>   kernel/futex.c                              |  2 +-
>   mm/gup.c                                    | 92 +++++++++------------
>   mm/memory.c                                 |  2 +-
>   mm/process_vm_access.c                      |  2 +-
>   security/tomoyo/domain.c                    |  2 +-
>   virt/kvm/async_pf.c                         |  2 +-
>   virt/kvm/kvm_main.c                         |  2 +-
>   18 files changed, 65 insertions(+), 82 deletions(-)
> 

Looks good:

     Reviewed-by: John Hubbard <jhubbard@nvidia.com>

One minor refinement: in gup.c, if you add the following hunk on top of your
changes, that will eradicate the last reference to struct task, in that file:


diff --git a/mm/gup.c b/mm/gup.c
index 8ddc48022d74..75c4b305828b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1902,10 +1902,9 @@ static long __get_user_pages_remote(struct mm_struct *mm,
   *              Or NULL if the caller does not require them.
   *
   * This is the same as get_user_pages_remote(), just with a
- * less-flexible calling convention where we assume that the task
- * and mm being operated on are the current task's and don't allow
- * passing of a locked parameter.  We also obviously don't pass
- * FOLL_REMOTE in here.
+ * less-flexible calling convention where we assume that the mm being operated
+ * on belongs to the current task, and doesn't allow passing of a locked
+ * parameter. We also obviously don't pass FOLL_REMOTE in here.
   */
  long get_user_pages(unsigned long start, unsigned long nr_pages,
                 unsigned int gup_flags, struct page **pages,




thanks,
-- 
John Hubbard
NVIDIA


> diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
> index 8c8e5172fecd..1ef6b78ff9c7 100644
> --- a/arch/arc/kernel/process.c
> +++ b/arch/arc/kernel/process.c
> @@ -91,7 +91,7 @@ SYSCALL_DEFINE3(arc_usr_cmpxchg, int *, uaddr, int, expected, int, new)
>   		 goto fail;
>   
>   	mmap_read_lock(current->mm);
> -	ret = fixup_user_fault(current, current->mm, (unsigned long) uaddr,
> +	ret = fixup_user_fault(current->mm, (unsigned long) uaddr,
>   			       FAULT_FLAG_WRITE, NULL);
>   	mmap_read_unlock(current->mm);
>   
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 1608fd99bbee..2f177298c663 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2768,7 +2768,7 @@ static struct page *get_map_page(struct kvm *kvm, u64 uaddr)
>   	struct page *page = NULL;
>   
>   	mmap_read_lock(kvm->mm);
> -	get_user_pages_remote(NULL, kvm->mm, uaddr, 1, FOLL_WRITE,
> +	get_user_pages_remote(kvm->mm, uaddr, 1, FOLL_WRITE,
>   			      &page, NULL, NULL);
>   	mmap_read_unlock(kvm->mm);
>   	return page;
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 08e6cf6cb454..f78921bc11b3 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -1892,7 +1892,7 @@ static long kvm_s390_set_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
>   
>   		r = set_guest_storage_key(current->mm, hva, keys[i], 0);
>   		if (r) {
> -			r = fixup_user_fault(current, current->mm, hva,
> +			r = fixup_user_fault(current->mm, hva,
>   					     FAULT_FLAG_WRITE, &unlocked);
>   			if (r)
>   				break;
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index 96ae368aa0a2..0fd94e86a28d 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -274,7 +274,7 @@ static int handle_iske(struct kvm_vcpu *vcpu)
>   	rc = get_guest_storage_key(current->mm, vmaddr, &key);
>   
>   	if (rc) {
> -		rc = fixup_user_fault(current, current->mm, vmaddr,
> +		rc = fixup_user_fault(current->mm, vmaddr,
>   				      FAULT_FLAG_WRITE, &unlocked);
>   		if (!rc) {
>   			mmap_read_unlock(current->mm);
> @@ -320,7 +320,7 @@ static int handle_rrbe(struct kvm_vcpu *vcpu)
>   	mmap_read_lock(current->mm);
>   	rc = reset_guest_reference_bit(current->mm, vmaddr);
>   	if (rc < 0) {
> -		rc = fixup_user_fault(current, current->mm, vmaddr,
> +		rc = fixup_user_fault(current->mm, vmaddr,
>   				      FAULT_FLAG_WRITE, &unlocked);
>   		if (!rc) {
>   			mmap_read_unlock(current->mm);
> @@ -391,7 +391,7 @@ static int handle_sske(struct kvm_vcpu *vcpu)
>   						m3 & SSKE_MC);
>   
>   		if (rc < 0) {
> -			rc = fixup_user_fault(current, current->mm, vmaddr,
> +			rc = fixup_user_fault(current->mm, vmaddr,
>   					      FAULT_FLAG_WRITE, &unlocked);
>   			rc = !rc ? -EAGAIN : rc;
>   		}
> @@ -1095,7 +1095,7 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
>   			rc = cond_set_guest_storage_key(current->mm, vmaddr,
>   							key, NULL, nq, mr, mc);
>   			if (rc < 0) {
> -				rc = fixup_user_fault(current, current->mm, vmaddr,
> +				rc = fixup_user_fault(current->mm, vmaddr,
>   						      FAULT_FLAG_WRITE, &unlocked);
>   				rc = !rc ? -EAGAIN : rc;
>   			}
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index 190357ff86b3..8747487c50a8 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -649,7 +649,7 @@ int gmap_fault(struct gmap *gmap, unsigned long gaddr,
>   		rc = vmaddr;
>   		goto out_up;
>   	}
> -	if (fixup_user_fault(current, gmap->mm, vmaddr, fault_flags,
> +	if (fixup_user_fault(gmap->mm, vmaddr, fault_flags,
>   			     &unlocked)) {
>   		rc = -EFAULT;
>   		goto out_up;
> @@ -879,7 +879,7 @@ static int gmap_pte_op_fixup(struct gmap *gmap, unsigned long gaddr,
>   
>   	BUG_ON(gmap_is_shadow(gmap));
>   	fault_flags = (prot == PROT_WRITE) ? FAULT_FLAG_WRITE : 0;
> -	if (fixup_user_fault(current, mm, vmaddr, fault_flags, &unlocked))
> +	if (fixup_user_fault(mm, vmaddr, fault_flags, &unlocked))
>   		return -EFAULT;
>   	if (unlocked)
>   		/* lost mmap_lock, caller has to retry __gmap_translate */
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> index 9c53eb883400..4ce66baaa17f 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> @@ -472,7 +472,7 @@ __i915_gem_userptr_get_pages_worker(struct work_struct *_work)
>   					locked = 1;
>   				}
>   				ret = pin_user_pages_remote
> -					(work->task, mm,
> +					(mm,
>   					 obj->userptr.ptr + pinned * PAGE_SIZE,
>   					 npages - pinned,
>   					 flags,
> diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
> index 5e32f61a2fe4..cc6b4befde7c 100644
> --- a/drivers/infiniband/core/umem_odp.c
> +++ b/drivers/infiniband/core/umem_odp.c
> @@ -439,7 +439,7 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
>   		 * complex (and doesn't gain us much performance in most use
>   		 * cases).
>   		 */
> -		npages = get_user_pages_remote(owning_process, owning_mm,
> +		npages = get_user_pages_remote(owning_mm,
>   				user_virt, gup_num_pages,
>   				flags, local_page_list, NULL, NULL);
>   		mmap_read_unlock(owning_mm);
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 5e556ac9102a..9d41105bfd01 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -425,7 +425,7 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
>   	if (ret) {
>   		bool unlocked = false;
>   
> -		ret = fixup_user_fault(NULL, mm, vaddr,
> +		ret = fixup_user_fault(mm, vaddr,
>   				       FAULT_FLAG_REMOTE |
>   				       (write_fault ?  FAULT_FLAG_WRITE : 0),
>   				       &unlocked);
> @@ -453,7 +453,7 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
>   		flags |= FOLL_WRITE;
>   
>   	mmap_read_lock(mm);
> -	ret = pin_user_pages_remote(NULL, mm, vaddr, 1, flags | FOLL_LONGTERM,
> +	ret = pin_user_pages_remote(mm, vaddr, 1, flags | FOLL_LONGTERM,
>   				    page, NULL, NULL);
>   	if (ret == 1) {
>   		*pfn = page_to_pfn(page[0]);
> diff --git a/fs/exec.c b/fs/exec.c
> index 7b7cbb180785..3cf806de5710 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -217,7 +217,7 @@ static struct page *get_arg_page(struct linux_binprm *bprm, unsigned long pos,
>   	 * We are doing an exec().  'current' is the process
>   	 * doing the exec and bprm->mm is the new process's mm.
>   	 */
> -	ret = get_user_pages_remote(current, bprm->mm, pos, 1, gup_flags,
> +	ret = get_user_pages_remote(bprm->mm, pos, 1, gup_flags,
>   			&page, NULL, NULL);
>   	if (ret <= 0)
>   		return NULL;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ebc173dddad5..6da813301497 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1654,7 +1654,7 @@ int invalidate_inode_page(struct page *page);
>   extern vm_fault_t handle_mm_fault(struct vm_area_struct *vma,
>   				  unsigned long address, unsigned int flags,
>   				  struct pt_regs *regs);
> -extern int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
> +extern int fixup_user_fault(struct mm_struct *mm,
>   			    unsigned long address, unsigned int fault_flags,
>   			    bool *unlocked);
>   void unmap_mapping_pages(struct address_space *mapping,
> @@ -1670,8 +1670,7 @@ static inline vm_fault_t handle_mm_fault(struct vm_area_struct *vma,
>   	BUG();
>   	return VM_FAULT_SIGBUS;
>   }
> -static inline int fixup_user_fault(struct task_struct *tsk,
> -		struct mm_struct *mm, unsigned long address,
> +static inline int fixup_user_fault(struct mm_struct *mm, unsigned long address,
>   		unsigned int fault_flags, bool *unlocked)
>   {
>   	/* should never happen if there's no MMU */
> @@ -1697,11 +1696,11 @@ extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
>   extern int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
>   		unsigned long addr, void *buf, int len, unsigned int gup_flags);
>   
> -long get_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
> +long get_user_pages_remote(struct mm_struct *mm,
>   			    unsigned long start, unsigned long nr_pages,
>   			    unsigned int gup_flags, struct page **pages,
>   			    struct vm_area_struct **vmas, int *locked);
> -long pin_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
> +long pin_user_pages_remote(struct mm_struct *mm,
>   			   unsigned long start, unsigned long nr_pages,
>   			   unsigned int gup_flags, struct page **pages,
>   			   struct vm_area_struct **vmas, int *locked);
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index e84eb52b646b..f500204eb70d 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -376,7 +376,7 @@ __update_ref_ctr(struct mm_struct *mm, unsigned long vaddr, short d)
>   	if (!vaddr || !d)
>   		return -EINVAL;
>   
> -	ret = get_user_pages_remote(NULL, mm, vaddr, 1,
> +	ret = get_user_pages_remote(mm, vaddr, 1,
>   			FOLL_WRITE, &page, &vma, NULL);
>   	if (unlikely(ret <= 0)) {
>   		/*
> @@ -477,7 +477,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
>   	if (is_register)
>   		gup_flags |= FOLL_SPLIT_PMD;
>   	/* Read the page with vaddr into memory */
> -	ret = get_user_pages_remote(NULL, mm, vaddr, 1, gup_flags,
> +	ret = get_user_pages_remote(mm, vaddr, 1, gup_flags,
>   				    &old_page, &vma, NULL);
>   	if (ret <= 0)
>   		return ret;
> @@ -2029,7 +2029,7 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
>   	 * but we treat this as a 'remote' access since it is
>   	 * essentially a kernel access to the memory.
>   	 */
> -	result = get_user_pages_remote(NULL, mm, vaddr, 1, FOLL_FORCE, &page,
> +	result = get_user_pages_remote(mm, vaddr, 1, FOLL_FORCE, &page,
>   			NULL, NULL);
>   	if (result < 0)
>   		return result;
> diff --git a/kernel/futex.c b/kernel/futex.c
> index 05e88562de68..d024fcef62e8 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -699,7 +699,7 @@ static int fault_in_user_writeable(u32 __user *uaddr)
>   	int ret;
>   
>   	mmap_read_lock(mm);
> -	ret = fixup_user_fault(current, mm, (unsigned long)uaddr,
> +	ret = fixup_user_fault(mm, (unsigned long)uaddr,
>   			       FAULT_FLAG_WRITE, NULL);
>   	mmap_read_unlock(mm);
>   
> diff --git a/mm/gup.c b/mm/gup.c
> index 89b18c407ad2..8ddc48022d74 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -859,7 +859,7 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
>    * does not include FOLL_NOWAIT, the mmap_lock may be released.  If it
>    * is, *@locked will be set to 0 and -EBUSY returned.
>    */
> -static int faultin_page(struct task_struct *tsk, struct vm_area_struct *vma,
> +static int faultin_page(struct vm_area_struct *vma,
>   		unsigned long address, unsigned int *flags, int *locked)
>   {
>   	unsigned int fault_flags = 0;
> @@ -962,7 +962,6 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
>   
>   /**
>    * __get_user_pages() - pin user pages in memory
> - * @tsk:	task_struct of target task
>    * @mm:		mm_struct of target mm
>    * @start:	starting user address
>    * @nr_pages:	number of pages from start to pin
> @@ -1021,7 +1020,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
>    * instead of __get_user_pages. __get_user_pages should be used only if
>    * you need some special @gup_flags.
>    */
> -static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
> +static long __get_user_pages(struct mm_struct *mm,
>   		unsigned long start, unsigned long nr_pages,
>   		unsigned int gup_flags, struct page **pages,
>   		struct vm_area_struct **vmas, int *locked)
> @@ -1103,8 +1102,7 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>   
>   		page = follow_page_mask(vma, start, foll_flags, &ctx);
>   		if (!page) {
> -			ret = faultin_page(tsk, vma, start, &foll_flags,
> -					   locked);
> +			ret = faultin_page(vma, start, &foll_flags, locked);
>   			switch (ret) {
>   			case 0:
>   				goto retry;
> @@ -1178,8 +1176,6 @@ static bool vma_permits_fault(struct vm_area_struct *vma,
>   
>   /**
>    * fixup_user_fault() - manually resolve a user page fault
> - * @tsk:	the task_struct to use for page fault accounting, or
> - *		NULL if faults are not to be recorded.
>    * @mm:		mm_struct of target mm
>    * @address:	user address
>    * @fault_flags:flags to pass down to handle_mm_fault()
> @@ -1207,7 +1203,7 @@ static bool vma_permits_fault(struct vm_area_struct *vma,
>    * This function will not return with an unlocked mmap_lock. So it has not the
>    * same semantics wrt the @mm->mmap_lock as does filemap_fault().
>    */
> -int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
> +int fixup_user_fault(struct mm_struct *mm,
>   		     unsigned long address, unsigned int fault_flags,
>   		     bool *unlocked)
>   {
> @@ -1256,8 +1252,7 @@ EXPORT_SYMBOL_GPL(fixup_user_fault);
>    * Please note that this function, unlike __get_user_pages will not
>    * return 0 for nr_pages > 0 without FOLL_NOWAIT
>    */
> -static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
> -						struct mm_struct *mm,
> +static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
>   						unsigned long start,
>   						unsigned long nr_pages,
>   						struct page **pages,
> @@ -1290,7 +1285,7 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
>   	pages_done = 0;
>   	lock_dropped = false;
>   	for (;;) {
> -		ret = __get_user_pages(tsk, mm, start, nr_pages, flags, pages,
> +		ret = __get_user_pages(mm, start, nr_pages, flags, pages,
>   				       vmas, locked);
>   		if (!locked)
>   			/* VM_FAULT_RETRY couldn't trigger, bypass */
> @@ -1350,7 +1345,7 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
>   		}
>   
>   		*locked = 1;
> -		ret = __get_user_pages(tsk, mm, start, 1, flags | FOLL_TRIED,
> +		ret = __get_user_pages(mm, start, 1, flags | FOLL_TRIED,
>   				       pages, NULL, locked);
>   		if (!*locked) {
>   			/* Continue to retry until we succeeded */
> @@ -1436,7 +1431,7 @@ long populate_vma_page_range(struct vm_area_struct *vma,
>   	 * We made sure addr is within a VMA, so the following will
>   	 * not result in a stack expansion that recurses back here.
>   	 */
> -	return __get_user_pages(current, mm, start, nr_pages, gup_flags,
> +	return __get_user_pages(mm, start, nr_pages, gup_flags,
>   				NULL, NULL, locked);
>   }
>   
> @@ -1520,7 +1515,7 @@ struct page *get_dump_page(unsigned long addr)
>   	struct vm_area_struct *vma;
>   	struct page *page;
>   
> -	if (__get_user_pages(current, current->mm, addr, 1,
> +	if (__get_user_pages(current->mm, addr, 1,
>   			     FOLL_FORCE | FOLL_DUMP | FOLL_GET, &page, &vma,
>   			     NULL) < 1)
>   		return NULL;
> @@ -1529,8 +1524,7 @@ struct page *get_dump_page(unsigned long addr)
>   }
>   #endif /* CONFIG_ELF_CORE */
>   #else /* CONFIG_MMU */
> -static long __get_user_pages_locked(struct task_struct *tsk,
> -		struct mm_struct *mm, unsigned long start,
> +static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
>   		unsigned long nr_pages, struct page **pages,
>   		struct vm_area_struct **vmas, int *locked,
>   		unsigned int foll_flags)
> @@ -1606,8 +1600,7 @@ static struct page *alloc_migration_target_non_cma(struct page *page, unsigned l
>   	return alloc_migration_target(page, (unsigned long)&mtc);
>   }
>   
> -static long check_and_migrate_cma_pages(struct task_struct *tsk,
> -					struct mm_struct *mm,
> +static long check_and_migrate_cma_pages(struct mm_struct *mm,
>   					unsigned long start,
>   					unsigned long nr_pages,
>   					struct page **pages,
> @@ -1681,7 +1674,7 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
>   		 * again migrating any new CMA pages which we failed to isolate
>   		 * earlier.
>   		 */
> -		ret = __get_user_pages_locked(tsk, mm, start, nr_pages,
> +		ret = __get_user_pages_locked(mm, start, nr_pages,
>   						   pages, vmas, NULL,
>   						   gup_flags);
>   
> @@ -1695,8 +1688,7 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
>   	return ret;
>   }
>   #else
> -static long check_and_migrate_cma_pages(struct task_struct *tsk,
> -					struct mm_struct *mm,
> +static long check_and_migrate_cma_pages(struct mm_struct *mm,
>   					unsigned long start,
>   					unsigned long nr_pages,
>   					struct page **pages,
> @@ -1711,8 +1703,7 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
>    * __gup_longterm_locked() is a wrapper for __get_user_pages_locked which
>    * allows us to process the FOLL_LONGTERM flag.
>    */
> -static long __gup_longterm_locked(struct task_struct *tsk,
> -				  struct mm_struct *mm,
> +static long __gup_longterm_locked(struct mm_struct *mm,
>   				  unsigned long start,
>   				  unsigned long nr_pages,
>   				  struct page **pages,
> @@ -1737,7 +1728,7 @@ static long __gup_longterm_locked(struct task_struct *tsk,
>   		flags = memalloc_nocma_save();
>   	}
>   
> -	rc = __get_user_pages_locked(tsk, mm, start, nr_pages, pages,
> +	rc = __get_user_pages_locked(mm, start, nr_pages, pages,
>   				     vmas_tmp, NULL, gup_flags);
>   
>   	if (gup_flags & FOLL_LONGTERM) {
> @@ -1752,7 +1743,7 @@ static long __gup_longterm_locked(struct task_struct *tsk,
>   			goto out;
>   		}
>   
> -		rc = check_and_migrate_cma_pages(tsk, mm, start, rc, pages,
> +		rc = check_and_migrate_cma_pages(mm, start, rc, pages,
>   						 vmas_tmp, gup_flags);
>   	}
>   
> @@ -1762,22 +1753,20 @@ static long __gup_longterm_locked(struct task_struct *tsk,
>   	return rc;
>   }
>   #else /* !CONFIG_FS_DAX && !CONFIG_CMA */
> -static __always_inline long __gup_longterm_locked(struct task_struct *tsk,
> -						  struct mm_struct *mm,
> +static __always_inline long __gup_longterm_locked(struct mm_struct *mm,
>   						  unsigned long start,
>   						  unsigned long nr_pages,
>   						  struct page **pages,
>   						  struct vm_area_struct **vmas,
>   						  unsigned int flags)
>   {
> -	return __get_user_pages_locked(tsk, mm, start, nr_pages, pages, vmas,
> +	return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
>   				       NULL, flags);
>   }
>   #endif /* CONFIG_FS_DAX || CONFIG_CMA */
>   
>   #ifdef CONFIG_MMU
> -static long __get_user_pages_remote(struct task_struct *tsk,
> -				    struct mm_struct *mm,
> +static long __get_user_pages_remote(struct mm_struct *mm,
>   				    unsigned long start, unsigned long nr_pages,
>   				    unsigned int gup_flags, struct page **pages,
>   				    struct vm_area_struct **vmas, int *locked)
> @@ -1796,20 +1785,18 @@ static long __get_user_pages_remote(struct task_struct *tsk,
>   		 * This will check the vmas (even if our vmas arg is NULL)
>   		 * and return -ENOTSUPP if DAX isn't allowed in this case:
>   		 */
> -		return __gup_longterm_locked(tsk, mm, start, nr_pages, pages,
> +		return __gup_longterm_locked(mm, start, nr_pages, pages,
>   					     vmas, gup_flags | FOLL_TOUCH |
>   					     FOLL_REMOTE);
>   	}
>   
> -	return __get_user_pages_locked(tsk, mm, start, nr_pages, pages, vmas,
> +	return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
>   				       locked,
>   				       gup_flags | FOLL_TOUCH | FOLL_REMOTE);
>   }
>   
>   /**
>    * get_user_pages_remote() - pin user pages in memory
> - * @tsk:	the task_struct to use for page fault accounting, or
> - *		NULL if faults are not to be recorded.
>    * @mm:		mm_struct of target mm
>    * @start:	starting user address
>    * @nr_pages:	number of pages from start to pin
> @@ -1868,7 +1855,7 @@ static long __get_user_pages_remote(struct task_struct *tsk,
>    * should use get_user_pages_remote because it cannot pass
>    * FAULT_FLAG_ALLOW_RETRY to handle_mm_fault.
>    */
> -long get_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
> +long get_user_pages_remote(struct mm_struct *mm,
>   		unsigned long start, unsigned long nr_pages,
>   		unsigned int gup_flags, struct page **pages,
>   		struct vm_area_struct **vmas, int *locked)
> @@ -1880,13 +1867,13 @@ long get_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
>   	if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
>   		return -EINVAL;
>   
> -	return __get_user_pages_remote(tsk, mm, start, nr_pages, gup_flags,
> +	return __get_user_pages_remote(mm, start, nr_pages, gup_flags,
>   				       pages, vmas, locked);
>   }
>   EXPORT_SYMBOL(get_user_pages_remote);
>   
>   #else /* CONFIG_MMU */
> -long get_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
> +long get_user_pages_remote(struct mm_struct *mm,
>   			   unsigned long start, unsigned long nr_pages,
>   			   unsigned int gup_flags, struct page **pages,
>   			   struct vm_area_struct **vmas, int *locked)
> @@ -1894,8 +1881,7 @@ long get_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
>   	return 0;
>   }
>   
> -static long __get_user_pages_remote(struct task_struct *tsk,
> -				    struct mm_struct *mm,
> +static long __get_user_pages_remote(struct mm_struct *mm,
>   				    unsigned long start, unsigned long nr_pages,
>   				    unsigned int gup_flags, struct page **pages,
>   				    struct vm_area_struct **vmas, int *locked)
> @@ -1932,7 +1918,7 @@ long get_user_pages(unsigned long start, unsigned long nr_pages,
>   	if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
>   		return -EINVAL;
>   
> -	return __gup_longterm_locked(current, current->mm, start, nr_pages,
> +	return __gup_longterm_locked(current->mm, start, nr_pages,
>   				     pages, vmas, gup_flags | FOLL_TOUCH);
>   }
>   EXPORT_SYMBOL(get_user_pages);
> @@ -1942,7 +1928,7 @@ EXPORT_SYMBOL(get_user_pages);
>    *
>    *      mmap_read_lock(mm);
>    *      do_something()
> - *      get_user_pages(tsk, mm, ..., pages, NULL);
> + *      get_user_pages(mm, ..., pages, NULL);
>    *      mmap_read_unlock(mm);
>    *
>    *  to:
> @@ -1950,7 +1936,7 @@ EXPORT_SYMBOL(get_user_pages);
>    *      int locked = 1;
>    *      mmap_read_lock(mm);
>    *      do_something()
> - *      get_user_pages_locked(tsk, mm, ..., pages, &locked);
> + *      get_user_pages_locked(mm, ..., pages, &locked);
>    *      if (locked)
>    *          mmap_read_unlock(mm);
>    *
> @@ -1988,7 +1974,7 @@ long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
>   	if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
>   		return -EINVAL;
>   
> -	return __get_user_pages_locked(current, current->mm, start, nr_pages,
> +	return __get_user_pages_locked(current->mm, start, nr_pages,
>   				       pages, NULL, locked,
>   				       gup_flags | FOLL_TOUCH);
>   }
> @@ -1998,12 +1984,12 @@ EXPORT_SYMBOL(get_user_pages_locked);
>    * get_user_pages_unlocked() is suitable to replace the form:
>    *
>    *      mmap_read_lock(mm);
> - *      get_user_pages(tsk, mm, ..., pages, NULL);
> + *      get_user_pages(mm, ..., pages, NULL);
>    *      mmap_read_unlock(mm);
>    *
>    *  with:
>    *
> - *      get_user_pages_unlocked(tsk, mm, ..., pages);
> + *      get_user_pages_unlocked(mm, ..., pages);
>    *
>    * It is functionally equivalent to get_user_pages_fast so
>    * get_user_pages_fast should be used instead if specific gup_flags
> @@ -2026,7 +2012,7 @@ long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>   		return -EINVAL;
>   
>   	mmap_read_lock(mm);
> -	ret = __get_user_pages_locked(current, mm, start, nr_pages, pages, NULL,
> +	ret = __get_user_pages_locked(mm, start, nr_pages, pages, NULL,
>   				      &locked, gup_flags | FOLL_TOUCH);
>   	if (locked)
>   		mmap_read_unlock(mm);
> @@ -2671,7 +2657,7 @@ static int __gup_longterm_unlocked(unsigned long start, int nr_pages,
>   	 */
>   	if (gup_flags & FOLL_LONGTERM) {
>   		mmap_read_lock(current->mm);
> -		ret = __gup_longterm_locked(current, current->mm,
> +		ret = __gup_longterm_locked(current->mm,
>   					    start, nr_pages,
>   					    pages, NULL, gup_flags);
>   		mmap_read_unlock(current->mm);
> @@ -2914,10 +2900,8 @@ int pin_user_pages_fast_only(unsigned long start, int nr_pages,
>   EXPORT_SYMBOL_GPL(pin_user_pages_fast_only);
>   
>   /**
> - * pin_user_pages_remote() - pin pages of a remote process (task != current)
> + * pin_user_pages_remote() - pin pages of a remote process
>    *
> - * @tsk:	the task_struct to use for page fault accounting, or
> - *		NULL if faults are not to be recorded.
>    * @mm:		mm_struct of target mm
>    * @start:	starting user address
>    * @nr_pages:	number of pages from start to pin
> @@ -2938,7 +2922,7 @@ EXPORT_SYMBOL_GPL(pin_user_pages_fast_only);
>    * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
>    * see Documentation/core-api/pin_user_pages.rst for details.
>    */
> -long pin_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
> +long pin_user_pages_remote(struct mm_struct *mm,
>   			   unsigned long start, unsigned long nr_pages,
>   			   unsigned int gup_flags, struct page **pages,
>   			   struct vm_area_struct **vmas, int *locked)
> @@ -2948,7 +2932,7 @@ long pin_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
>   		return -EINVAL;
>   
>   	gup_flags |= FOLL_PIN;
> -	return __get_user_pages_remote(tsk, mm, start, nr_pages, gup_flags,
> +	return __get_user_pages_remote(mm, start, nr_pages, gup_flags,
>   				       pages, vmas, locked);
>   }
>   EXPORT_SYMBOL(pin_user_pages_remote);
> @@ -2980,7 +2964,7 @@ long pin_user_pages(unsigned long start, unsigned long nr_pages,
>   		return -EINVAL;
>   
>   	gup_flags |= FOLL_PIN;
> -	return __gup_longterm_locked(current, current->mm, start, nr_pages,
> +	return __gup_longterm_locked(current->mm, start, nr_pages,
>   				     pages, vmas, gup_flags);
>   }
>   EXPORT_SYMBOL(pin_user_pages);
> @@ -3025,7 +3009,7 @@ long pin_user_pages_locked(unsigned long start, unsigned long nr_pages,
>   		return -EINVAL;
>   
>   	gup_flags |= FOLL_PIN;
> -	return __get_user_pages_locked(current, current->mm, start, nr_pages,
> +	return __get_user_pages_locked(current->mm, start, nr_pages,
>   				       pages, NULL, locked,
>   				       gup_flags | FOLL_TOUCH);
>   }
> diff --git a/mm/memory.c b/mm/memory.c
> index 00d96ae9464c..65296a546f02 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4746,7 +4746,7 @@ int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
>   		void *maddr;
>   		struct page *page = NULL;
>   
> -		ret = get_user_pages_remote(tsk, mm, addr, 1,
> +		ret = get_user_pages_remote(mm, addr, 1,
>   				gup_flags, &page, &vma, NULL);
>   		if (ret <= 0) {
>   #ifndef CONFIG_HAVE_IOREMAP_PROT
> diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
> index cc85ce81914a..29c052099aff 100644
> --- a/mm/process_vm_access.c
> +++ b/mm/process_vm_access.c
> @@ -105,7 +105,7 @@ static int process_vm_rw_single_vec(unsigned long addr,
>   		 * current/current->mm
>   		 */
>   		mmap_read_lock(mm);
> -		pinned_pages = pin_user_pages_remote(task, mm, pa, pinned_pages,
> +		pinned_pages = pin_user_pages_remote(mm, pa, pinned_pages,
>   						     flags, process_pages,
>   						     NULL, &locked);
>   		if (locked)
> diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
> index 7869d6a9980b..afe5e68ede77 100644
> --- a/security/tomoyo/domain.c
> +++ b/security/tomoyo/domain.c
> @@ -914,7 +914,7 @@ bool tomoyo_dump_page(struct linux_binprm *bprm, unsigned long pos,
>   	 * (represented by bprm).  'current' is the process doing
>   	 * the execve().
>   	 */
> -	if (get_user_pages_remote(current, bprm->mm, pos, 1,
> +	if (get_user_pages_remote(bprm->mm, pos, 1,
>   				FOLL_FORCE, &page, NULL, NULL) <= 0)
>   		return false;
>   #else
> diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
> index 45799606bb3e..0939ed377688 100644
> --- a/virt/kvm/async_pf.c
> +++ b/virt/kvm/async_pf.c
> @@ -61,7 +61,7 @@ static void async_pf_execute(struct work_struct *work)
>   	 * access remotely.
>   	 */
>   	mmap_read_lock(mm);
> -	get_user_pages_remote(NULL, mm, addr, 1, FOLL_WRITE, NULL, NULL,
> +	get_user_pages_remote(mm, addr, 1, FOLL_WRITE, NULL, NULL,
>   			&locked);
>   	if (locked)
>   		mmap_read_unlock(mm);
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index a852af5c3214..45a0a1e6fde8 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1830,7 +1830,7 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
>   		 * not call the fault handler, so do it here.
>   		 */
>   		bool unlocked = false;
> -		r = fixup_user_fault(current, current->mm, addr,
> +		r = fixup_user_fault(current->mm, addr,
>   				     (write_fault ? FAULT_FLAG_WRITE : 0),
>   				     &unlocked);
>   		if (unlocked)
> 
