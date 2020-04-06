Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E82C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BEDE21D82
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgDFMqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 08:46:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12456 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728034AbgDFMqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 08:46:01 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 036CYVdx095294
        for <linux-kernel@vger.kernel.org>; Mon, 6 Apr 2020 08:46:00 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 306n24a142-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 08:46:00 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ldufour@linux.ibm.com>;
        Mon, 6 Apr 2020 13:45:46 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Apr 2020 13:45:42 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 036CjrY829687850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Apr 2020 12:45:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1805BA4062;
        Mon,  6 Apr 2020 12:45:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47B01A405C;
        Mon,  6 Apr 2020 12:45:52 +0000 (GMT)
Received: from pomme.local (unknown [9.145.52.152])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 Apr 2020 12:45:52 +0000 (GMT)
Subject: Re: [PATCH 8/8] mmap locking API: rename mmap_sem to mmap_lock
To:     Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>
References: <20200326070236.235835-1-walken@google.com>
 <20200326070236.235835-9-walken@google.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
Date:   Mon, 6 Apr 2020 14:45:51 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326070236.235835-9-walken@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20040612-0012-0000-0000-0000039F5469
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040612-0013-0000-0000-000021DC7239
Message-Id: <4eaa33a1-8144-253e-ac99-eeb354b6f871@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-06_07:2020-04-06,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 26/03/2020 à 08:02, Michel Lespinasse a écrit :
> Rename the mmap_sem field to mmap_lock. Any new uses of this lock
> should now go through the new mmap locking api. The mmap_lock is
> still implemented as a rwsem, though this could change in the future.

Since you don't change the type of the mmap_sem, it's still a semaphore, I don't 
think mmap_lock is a good name. This is not a lock.

I'm bad at naming, but what about __map_sem?

> 
> Signed-off-by: Michel Lespinasse <walken@google.com>
> ---
>   arch/ia64/mm/fault.c                  |  4 ++--
>   arch/x86/events/core.c                |  4 ++--
>   arch/x86/kernel/tboot.c               |  2 +-
>   arch/x86/mm/fault.c                   |  2 +-
>   drivers/firmware/efi/efi.c            |  2 +-
>   drivers/gpu/drm/etnaviv/etnaviv_gem.c |  2 +-
>   include/linux/mm_types.h              |  2 +-
>   include/linux/mmap_lock.h             | 30 +++++++++++++--------------
>   mm/hmm.c                              |  2 +-
>   mm/init-mm.c                          |  2 +-
>   mm/memory.c                           |  2 +-
>   mm/mmap.c                             |  4 ++--
>   mm/mmu_notifier.c                     | 18 ++++++++--------
>   mm/pagewalk.c                         | 15 +++++++-------
>   mm/util.c                             |  4 ++--
>   15 files changed, 48 insertions(+), 47 deletions(-)
> 
> diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
> index b423f0a970e4..70c7c7909cc5 100644
> --- a/arch/ia64/mm/fault.c
> +++ b/arch/ia64/mm/fault.c
> @@ -70,8 +70,8 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
>   	mask = ((((isr >> IA64_ISR_X_BIT) & 1UL) << VM_EXEC_BIT)
>   		| (((isr >> IA64_ISR_W_BIT) & 1UL) << VM_WRITE_BIT));
>   
> -	/* mmap_sem is performance critical.... */
> -	prefetchw(&mm->mmap_sem);
> +	/* mmap_lock is performance critical.... */
> +	prefetchw(&mm->mmap_lock);
>   
>   	/*
>   	 * If we're in an interrupt or have no user context, we must not take the fault..
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 3bb738f5a472..ad21924c575e 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2179,10 +2179,10 @@ static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
>   	 * userspace with CR4.PCE clear while another task is still
>   	 * doing on_each_cpu_mask() to propagate CR4.PCE.
>   	 *
> -	 * For now, this can't happen because all callers hold mmap_sem
> +	 * For now, this can't happen because all callers hold mmap_lock
>   	 * for write.  If this changes, we'll need a different solution.
>   	 */
> -	lockdep_assert_held_write(&mm->mmap_sem);
> +	lockdep_assert_held_write(&mm->mmap_lock);
>   
>   	if (atomic_inc_return(&mm->context.perf_rdpmc_allowed) == 1)
>   		on_each_cpu_mask(mm_cpumask(mm), refresh_pce, NULL, 1);
> diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
> index 4b79335624b1..4792e8778b28 100644
> --- a/arch/x86/kernel/tboot.c
> +++ b/arch/x86/kernel/tboot.c
> @@ -90,7 +90,7 @@ static struct mm_struct tboot_mm = {
>   	.pgd            = swapper_pg_dir,
>   	.mm_users       = ATOMIC_INIT(2),
>   	.mm_count       = ATOMIC_INIT(1),
> -	.mmap_sem       = MMAP_LOCK_INITIALIZER(init_mm.mmap_sem),
> +	.mmap_lock      = MMAP_LOCK_INITIALIZER(init_mm.mmap_lock),
>   	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
>   	.mmlist         = LIST_HEAD_INIT(init_mm.mmlist),
>   };
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 5bb97d2a7d3b..98d413e6fbb2 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1526,7 +1526,7 @@ dotraplinkage void
>   do_page_fault(struct pt_regs *regs, unsigned long hw_error_code,
>   		unsigned long address)
>   {
> -	prefetchw(&current->mm->mmap_sem);
> +	prefetchw(&current->mm->mmap_lock);
>   	trace_page_fault_entries(regs, hw_error_code, address);
>   
>   	if (unlikely(kmmio_fault(regs, address)))
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 5bdfe698cd7f..d38e0e85eb0d 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -60,7 +60,7 @@ struct mm_struct efi_mm = {
>   	.mm_rb			= RB_ROOT,
>   	.mm_users		= ATOMIC_INIT(2),
>   	.mm_count		= ATOMIC_INIT(1),
> -	.mmap_sem		= MMAP_LOCK_INITIALIZER(efi_mm.mmap_sem),
> +	.mmap_lock		= MMAP_LOCK_INITIALIZER(efi_mm.mmap_lock),
>   	.page_table_lock	= __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),
>   	.mmlist			= LIST_HEAD_INIT(efi_mm.mmlist),
>   	.cpu_bitmap		= { [BITS_TO_LONGS(NR_CPUS)] = 0},
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> index 6adea180d629..3470482d95bc 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> @@ -661,7 +661,7 @@ static int etnaviv_gem_userptr_get_pages(struct etnaviv_gem_object *etnaviv_obj)
>   	struct etnaviv_gem_userptr *userptr = &etnaviv_obj->userptr;
>   	int ret, pinned = 0, npages = etnaviv_obj->base.size >> PAGE_SHIFT;
>   
> -	might_lock_read(&current->mm->mmap_sem);
> +	might_lock_read(&current->mm->mmap_lock);
>   
>   	if (userptr->mm != current->mm)
>   		return -EPERM;
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index c28911c3afa8..a168d13b5c44 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -431,7 +431,7 @@ struct mm_struct {
>   		spinlock_t page_table_lock; /* Protects page tables and some
>   					     * counters
>   					     */
> -		struct rw_semaphore mmap_sem;
> +		struct rw_semaphore mmap_lock;
>   
>   		struct list_head mmlist; /* List of maybe swapped mm's.	These
>   					  * are globally strung together off
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 7474b15bba38..700dd297f2af 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -5,78 +5,78 @@
>   
>   static inline void mmap_init_lock(struct mm_struct *mm)
>   {
> -	init_rwsem(&mm->mmap_sem);
> +	init_rwsem(&mm->mmap_lock);
>   }
>   
>   static inline void mmap_write_lock(struct mm_struct *mm)
>   {
> -	down_write(&mm->mmap_sem);
> +	down_write(&mm->mmap_lock);
>   }
>   
>   static inline void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
>   {
> -	down_write_nested(&mm->mmap_sem, subclass);
> +	down_write_nested(&mm->mmap_lock, subclass);
>   }
>   
>   static inline int mmap_write_lock_killable(struct mm_struct *mm)
>   {
> -	return down_write_killable(&mm->mmap_sem);
> +	return down_write_killable(&mm->mmap_lock);
>   }
>   
>   static inline bool mmap_write_trylock(struct mm_struct *mm)
>   {
> -	return down_write_trylock(&mm->mmap_sem) != 0;
> +	return down_write_trylock(&mm->mmap_lock) != 0;
>   }
>   
>   static inline void mmap_write_unlock(struct mm_struct *mm)
>   {
> -	up_write(&mm->mmap_sem);
> +	up_write(&mm->mmap_lock);
>   }
>   
>   /* Pairs with mmap_write_lock_nested() */
>   static inline void mmap_write_unlock_nested(struct mm_struct *mm)
>   {
> -	up_write(&mm->mmap_sem);
> +	up_write(&mm->mmap_lock);
>   }
>   
>   static inline void mmap_downgrade_write_lock(struct mm_struct *mm)
>   {
> -	downgrade_write(&mm->mmap_sem);
> +	downgrade_write(&mm->mmap_lock);
>   }
>   
>   static inline void mmap_read_lock(struct mm_struct *mm)
>   {
> -	down_read(&mm->mmap_sem);
> +	down_read(&mm->mmap_lock);
>   }
>   
>   static inline int mmap_read_lock_killable(struct mm_struct *mm)
>   {
> -	return down_read_killable(&mm->mmap_sem);
> +	return down_read_killable(&mm->mmap_lock);
>   }
>   
>   static inline bool mmap_read_trylock(struct mm_struct *mm)
>   {
> -	return down_read_trylock(&mm->mmap_sem) != 0;
> +	return down_read_trylock(&mm->mmap_lock) != 0;
>   }
>   
>   static inline void mmap_read_unlock(struct mm_struct *mm)
>   {
> -	up_read(&mm->mmap_sem);
> +	up_read(&mm->mmap_lock);
>   }
>   
>   static inline void mmap_read_release(struct mm_struct *mm, unsigned long ip)
>   {
> -	rwsem_release(&mm->mmap_sem.dep_map, ip);
> +	rwsem_release(&mm->mmap_lock.dep_map, ip);
>   }
>   
>   static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
>   {
> -	up_read_non_owner(&mm->mmap_sem);
> +	up_read_non_owner(&mm->mmap_lock);
>   }
>   
>   static inline bool mmap_is_locked(struct mm_struct *mm)
>   {
> -	return rwsem_is_locked(&mm->mmap_sem) != 0;
> +	return rwsem_is_locked(&mm->mmap_lock) != 0;
>   }
>   
>   #endif /* _LINUX_MMAP_LOCK_H */
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 72e5a6d9a417..4d736a710910 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -681,7 +681,7 @@ long hmm_range_fault(struct hmm_range *range, unsigned int flags)
>   	struct mm_struct *mm = range->notifier->mm;
>   	int ret;
>   
> -	lockdep_assert_held(&mm->mmap_sem);
> +	lockdep_assert_held(&mm->mmap_lock);
>   
>   	do {
>   		/* If range is no longer valid force retry. */
> diff --git a/mm/init-mm.c b/mm/init-mm.c
> index 3c128bd6a30c..2b16924419b4 100644
> --- a/mm/init-mm.c
> +++ b/mm/init-mm.c
> @@ -31,7 +31,7 @@ struct mm_struct init_mm = {
>   	.pgd		= swapper_pg_dir,
>   	.mm_users	= ATOMIC_INIT(2),
>   	.mm_count	= ATOMIC_INIT(1),
> -	.mmap_sem	= MMAP_LOCK_INITIALIZER(init_mm.mmap_sem),
> +	.mmap_lock	= MMAP_LOCK_INITIALIZER(init_mm.mmap_lock),
>   	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
>   	.arg_lock	=  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
>   	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
> diff --git a/mm/memory.c b/mm/memory.c
> index 5f9a81b2507a..f146f58898f9 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4648,7 +4648,7 @@ void __might_fault(const char *file, int line)
>   	__might_sleep(file, line, 0);
>   #if defined(CONFIG_DEBUG_ATOMIC_SLEEP)
>   	if (current->mm)
> -		might_lock_read(&current->mm->mmap_sem);
> +		might_lock_read(&current->mm->mmap_lock);
>   #endif
>   }
>   EXPORT_SYMBOL(__might_fault);
> diff --git a/mm/mmap.c b/mm/mmap.c
> index ba51ff516ec0..c81db16c8c23 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3450,7 +3450,7 @@ static void vm_lock_anon_vma(struct mm_struct *mm, struct anon_vma *anon_vma)
>   		 * The LSB of head.next can't change from under us
>   		 * because we hold the mm_all_locks_mutex.
>   		 */
> -		down_write_nest_lock(&anon_vma->root->rwsem, &mm->mmap_sem);
> +		down_write_nest_lock(&anon_vma->root->rwsem, &mm->mmap_lock);
>   		/*
>   		 * We can safely modify head.next after taking the
>   		 * anon_vma->root->rwsem. If some other vma in this mm shares
> @@ -3480,7 +3480,7 @@ static void vm_lock_mapping(struct mm_struct *mm, struct address_space *mapping)
>   		 */
>   		if (test_and_set_bit(AS_MM_ALL_LOCKS, &mapping->flags))
>   			BUG();
> -		down_write_nest_lock(&mapping->i_mmap_rwsem, &mm->mmap_sem);
> +		down_write_nest_lock(&mapping->i_mmap_rwsem, &mm->mmap_lock);
>   	}
>   }
>   
> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index cfd0a03bf5cc..6717278d6d49 100644
> --- a/mm/mmu_notifier.c
> +++ b/mm/mmu_notifier.c
> @@ -599,7 +599,7 @@ void __mmu_notifier_invalidate_range(struct mm_struct *mm,
>   }
>   
>   /*
> - * Same as mmu_notifier_register but here the caller must hold the mmap_sem in
> + * Same as mmu_notifier_register but here the caller must hold the mmap_lock in
>    * write mode. A NULL mn signals the notifier is being registered for itree
>    * mode.
>    */
> @@ -609,7 +609,7 @@ int __mmu_notifier_register(struct mmu_notifier *subscription,
>   	struct mmu_notifier_subscriptions *subscriptions = NULL;
>   	int ret;
>   
> -	lockdep_assert_held_write(&mm->mmap_sem);
> +	lockdep_assert_held_write(&mm->mmap_lock);
>   	BUG_ON(atomic_read(&mm->mm_users) <= 0);
>   
>   	if (IS_ENABLED(CONFIG_LOCKDEP)) {
> @@ -623,7 +623,7 @@ int __mmu_notifier_register(struct mmu_notifier *subscription,
>   		/*
>   		 * kmalloc cannot be called under mm_take_all_locks(), but we
>   		 * know that mm->notifier_subscriptions can't change while we
> -		 * hold the write side of the mmap_sem.
> +		 * hold the write side of the mmap_lock.
>   		 */
>   		subscriptions = kzalloc(
>   			sizeof(struct mmu_notifier_subscriptions), GFP_KERNEL);
> @@ -655,7 +655,7 @@ int __mmu_notifier_register(struct mmu_notifier *subscription,
>   	 * readers.  acquire can only be used while holding the mmgrab or
>   	 * mmget, and is safe because once created the
>   	 * mmu_notifier_subscriptions is not freed until the mm is destroyed.
> -	 * As above, users holding the mmap_sem or one of the
> +	 * As above, users holding the mmap_lock or one of the
>   	 * mm_take_all_locks() do not need to use acquire semantics.
>   	 */
>   	if (subscriptions)
> @@ -689,7 +689,7 @@ EXPORT_SYMBOL_GPL(__mmu_notifier_register);
>    * @mn: The notifier to attach
>    * @mm: The mm to attach the notifier to
>    *
> - * Must not hold mmap_sem nor any other VM related lock when calling
> + * Must not hold mmap_lock nor any other VM related lock when calling
>    * this registration function. Must also ensure mm_users can't go down
>    * to zero while this runs to avoid races with mmu_notifier_release,
>    * so mm has to be current->mm or the mm should be pinned safely such
> @@ -750,7 +750,7 @@ find_get_mmu_notifier(struct mm_struct *mm, const struct mmu_notifier_ops *ops)
>    * are the same.
>    *
>    * Each call to mmu_notifier_get() must be paired with a call to
> - * mmu_notifier_put(). The caller must hold the write side of mm->mmap_sem.
> + * mmu_notifier_put(). The caller must hold the write side of mm->mmap_lock.
>    *
>    * While the caller has a mmu_notifier get the mm pointer will remain valid,
>    * and can be converted to an active mm pointer via mmget_not_zero().
> @@ -761,7 +761,7 @@ struct mmu_notifier *mmu_notifier_get_locked(const struct mmu_notifier_ops *ops,
>   	struct mmu_notifier *subscription;
>   	int ret;
>   
> -	lockdep_assert_held_write(&mm->mmap_sem);
> +	lockdep_assert_held_write(&mm->mmap_lock);
>   
>   	if (mm->notifier_subscriptions) {
>   		subscription = find_get_mmu_notifier(mm, ops);
> @@ -983,7 +983,7 @@ int mmu_interval_notifier_insert(struct mmu_interval_notifier *interval_sub,
>   	struct mmu_notifier_subscriptions *subscriptions;
>   	int ret;
>   
> -	might_lock(&mm->mmap_sem);
> +	might_lock(&mm->mmap_lock);
>   
>   	subscriptions = smp_load_acquire(&mm->notifier_subscriptions);
>   	if (!subscriptions || !subscriptions->has_itree) {
> @@ -1006,7 +1006,7 @@ int mmu_interval_notifier_insert_locked(
>   		mm->notifier_subscriptions;
>   	int ret;
>   
> -	lockdep_assert_held_write(&mm->mmap_sem);
> +	lockdep_assert_held_write(&mm->mmap_lock);
>   
>   	if (!subscriptions || !subscriptions->has_itree) {
>   		ret = __mmu_notifier_register(NULL, mm);
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index 928df1638c30..d669a3146c0f 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -373,8 +373,9 @@ static int __walk_page_range(unsigned long start, unsigned long end,
>    * caller-specific data to callbacks, @private should be helpful.
>    *
>    * Locking:
> - *   Callers of walk_page_range() and walk_page_vma() should hold @mm->mmap_sem,
> - *   because these function traverse vma list and/or access to vma's data.
> + *   Callers of walk_page_range() and walk_page_vma() should hold
> + *   @mm->mmap_lock, because these function traverse the vma list
> + *   and/or access the vma's data.
>    */
>   int walk_page_range(struct mm_struct *mm, unsigned long start,
>   		unsigned long end, const struct mm_walk_ops *ops,
> @@ -395,7 +396,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
>   	if (!walk.mm)
>   		return -EINVAL;
>   
> -	lockdep_assert_held(&walk.mm->mmap_sem);
> +	lockdep_assert_held(&walk.mm->mmap_lock);
>   
>   	vma = find_vma(walk.mm, start);
>   	do {
> @@ -453,7 +454,7 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
>   	if (start >= end || !walk.mm)
>   		return -EINVAL;
>   
> -	lockdep_assert_held(&walk.mm->mmap_sem);
> +	lockdep_assert_held(&walk.mm->mmap_lock);
>   
>   	return __walk_page_range(start, end, &walk);
>   }
> @@ -472,7 +473,7 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
>   	if (!walk.mm)
>   		return -EINVAL;
>   
> -	lockdep_assert_held(&walk.mm->mmap_sem);
> +	lockdep_assert_held(&walk.mm->mmap_lock);
>   
>   	err = walk_page_test(vma->vm_start, vma->vm_end, &walk);
>   	if (err > 0)
> @@ -498,11 +499,11 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
>    * Also see walk_page_range() for additional information.
>    *
>    * Locking:
> - *   This function can't require that the struct mm_struct::mmap_sem is held,
> + *   This function can't require that the struct mm_struct::mmap_lock is held,
>    *   since @mapping may be mapped by multiple processes. Instead
>    *   @mapping->i_mmap_rwsem must be held. This might have implications in the
>    *   callbacks, and it's up tho the caller to ensure that the
> - *   struct mm_struct::mmap_sem is not needed.
> + *   struct mm_struct::mmap_lock is not needed.
>    *
>    *   Also this means that a caller can't rely on the struct
>    *   vm_area_struct::vm_flags to be constant across a call,
> diff --git a/mm/util.c b/mm/util.c
> index ea2e15b21446..56c562f7ad19 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -425,7 +425,7 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
>    * @bypass_rlim: %true if checking RLIMIT_MEMLOCK should be skipped
>    *
>    * Assumes @task and @mm are valid (i.e. at least one reference on each), and
> - * that mmap_sem is held as writer.
> + * that mmap_lock is held as writer.
>    *
>    * Return:
>    * * 0       on success
> @@ -437,7 +437,7 @@ int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
>   	unsigned long locked_vm, limit;
>   	int ret = 0;
>   
> -	lockdep_assert_held_write(&mm->mmap_sem);
> +	lockdep_assert_held_write(&mm->mmap_lock);
>   
>   	locked_vm = mm->locked_vm;
>   	if (inc) {
> 

