Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C09BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01C1320657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgERNpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:45:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2894 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726726AbgERNpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:45:41 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04IDRx1l134928;
        Mon, 18 May 2020 09:45:31 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 312btu75sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 09:45:31 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04IDS1f4135193;
        Mon, 18 May 2020 09:45:30 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 312btu75qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 09:45:30 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04IDeBbZ022806;
        Mon, 18 May 2020 13:45:26 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3127t5hq0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 13:45:26 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04IDjO5P59375632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 May 2020 13:45:24 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E693D42047;
        Mon, 18 May 2020 13:45:23 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C96E242045;
        Mon, 18 May 2020 13:45:22 +0000 (GMT)
Received: from pomme.local (unknown [9.145.67.24])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 May 2020 13:45:22 +0000 (GMT)
Subject: Re: [PATCH v5.5 10/10] mmap locking API: rename mmap_sem to mmap_lock
To:     Michel Lespinasse <walken@google.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
References: <20200422001422.232330-1-walken@google.com>
 <20200422001422.232330-11-walken@google.com>
 <20200422015829.GR5820@bombadil.infradead.org>
 <CANN689EnGsJXA8n6JvTryQfkCtARPvtZbkH+9Dd2a4X+fvqU9g@mail.gmail.com>
 <20200423015917.GA13910@bombadil.infradead.org>
 <20200424012612.GA158937@google.com> <20200424013958.GC158937@google.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
Message-ID: <f20ab834-cddb-eaa7-c03e-18f0c4897a33@linux.ibm.com>
Date:   Mon, 18 May 2020 15:45:22 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200424013958.GC158937@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-18_06:2020-05-15,2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 clxscore=1015 cotscore=-2147483648
 lowpriorityscore=0 adultscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005180117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 24/04/2020 à 03:39, Michel Lespinasse a écrit :
> Rename the mmap_sem field to mmap_lock. Any new uses of this lock
> should now go through the new mmap locking api. The mmap_lock is
> still implemented as a rwsem, though this could change in the future.
> 
> Signed-off-by: Michel Lespinasse <walken@google.com>
> ---
>   arch/ia64/mm/fault.c                  |  4 +--
>   arch/x86/mm/fault.c                   |  2 +-
>   drivers/gpu/drm/etnaviv/etnaviv_gem.c |  2 +-
>   include/linux/mm_types.h              |  2 +-
>   include/linux/mmap_lock.h             | 38 +++++++++++++--------------
>   mm/memory.c                           |  2 +-
>   mm/mmap.c                             |  4 +--
>   mm/mmu_notifier.c                     |  2 +-
>   8 files changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
> index 693f00b117e1..9b95050c2048 100644
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
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 181f66b9049f..35f530f9dfc0 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1522,7 +1522,7 @@ dotraplinkage void
>   do_page_fault(struct pt_regs *regs, unsigned long hw_error_code,
>   		unsigned long address)
>   {
> -	prefetchw(&current->mm->mmap_sem);
> +	prefetchw(&current->mm->mmap_lock);
>   	trace_page_fault_entries(regs, hw_error_code, address);
>   
>   	if (unlikely(kmmio_fault(regs, address)))
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> index dc9ef302f517..701f3995f621 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> @@ -661,7 +661,7 @@ static int etnaviv_gem_userptr_get_pages(struct etnaviv_gem_object *etnaviv_obj)
>   	struct etnaviv_gem_userptr *userptr = &etnaviv_obj->userptr;
>   	int ret, pinned = 0, npages = etnaviv_obj->base.size >> PAGE_SHIFT;
>   
> -	might_lock_read(&current->mm->mmap_sem);
> +	might_lock_read(&current->mm->mmap_lock);

Why not a mm_might_lock_read() new API to hide the mmap_lock, and add it to the 
previous patch?

>   
>   	if (userptr->mm != current->mm)
>   		return -EPERM;
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 4aba6c0c2ba8..d13b90399c16 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -436,7 +436,7 @@ struct mm_struct {
>   		spinlock_t page_table_lock; /* Protects page tables and some
>   					     * counters
>   					     */
> -		struct rw_semaphore mmap_sem;
> +		struct rw_semaphore mmap_lock;
>   
>   		struct list_head mmlist; /* List of maybe swapped mm's.	These
>   					  * are globally strung together off
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 5bf7cee5d93b..9dc632add390 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -4,67 +4,67 @@
>   #include <linux/mmdebug.h>
>   
>   #define MMAP_LOCK_INITIALIZER(name) \
> -	.mmap_sem = __RWSEM_INITIALIZER(name.mmap_sem),
> +	.mmap_lock = __RWSEM_INITIALIZER(name.mmap_lock),
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
>   static inline void mmap_write_downgrade(struct mm_struct *mm)
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
>   static inline bool mmap_read_trylock_non_owner(struct mm_struct *mm)
>   {
> -	if (down_read_trylock(&mm->mmap_sem)) {
> -		rwsem_release(&mm->mmap_sem.dep_map, _RET_IP_);
> +	if (down_read_trylock(&mm->mmap_lock)) {
> +		rwsem_release(&mm->mmap_lock.dep_map, _RET_IP_);
>   		return true;
>   	}
>   	return false;
> @@ -72,19 +72,19 @@ static inline bool mmap_read_trylock_non_owner(struct mm_struct *mm)
>   
>   static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
>   {
> -	up_read_non_owner(&mm->mmap_sem);
> +	up_read_non_owner(&mm->mmap_lock);
>   }
>   
>   static inline void mmap_assert_locked(struct mm_struct *mm)
>   {
> -	VM_BUG_ON_MM(!lockdep_is_held_type(&mm->mmap_sem, -1), mm);
> -	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_sem), mm);
> +	VM_BUG_ON_MM(!lockdep_is_held_type(&mm->mmap_lock, -1), mm);
> +	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
>   }
>   
>   static inline void mmap_assert_write_locked(struct mm_struct *mm)
>   {
> -	VM_BUG_ON_MM(!lockdep_is_held_type(&mm->mmap_sem, 0), mm);
> -	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_sem), mm);
> +	VM_BUG_ON_MM(!lockdep_is_held_type(&mm->mmap_lock, 0), mm);
> +	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
>   }
>   
>   #endif /* _LINUX_MMAP_LOCK_H */
> diff --git a/mm/memory.c b/mm/memory.c
> index 20f98ea8968e..c2963e7affa9 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4811,7 +4811,7 @@ void __might_fault(const char *file, int line)
>   	__might_sleep(file, line, 0);
>   #if defined(CONFIG_DEBUG_ATOMIC_SLEEP)
>   	if (current->mm)
> -		might_lock_read(&current->mm->mmap_sem);
> +		might_lock_read(&current->mm->mmap_lock);
>   #endif
>   }
>   EXPORT_SYMBOL(__might_fault);
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 2f4ffccc5972..80a47031d5db 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3474,7 +3474,7 @@ static void vm_lock_anon_vma(struct mm_struct *mm, struct anon_vma *anon_vma)
>   		 * The LSB of head.next can't change from under us
>   		 * because we hold the mm_all_locks_mutex.
>   		 */
> -		down_write_nest_lock(&anon_vma->root->rwsem, &mm->mmap_sem);
> +		down_write_nest_lock(&anon_vma->root->rwsem, &mm->mmap_lock);
>   		/*
>   		 * We can safely modify head.next after taking the
>   		 * anon_vma->root->rwsem. If some other vma in this mm shares
> @@ -3504,7 +3504,7 @@ static void vm_lock_mapping(struct mm_struct *mm, struct address_space *mapping)
>   		 */
>   		if (test_and_set_bit(AS_MM_ALL_LOCKS, &mapping->flags))
>   			BUG();
> -		down_write_nest_lock(&mapping->i_mmap_rwsem, &mm->mmap_sem);
> +		down_write_nest_lock(&mapping->i_mmap_rwsem, &mm->mmap_lock);
>   	}
>   }
>   
> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index 24eb9d1ed0a7..2f348b6c9c9a 100644
> --- a/mm/mmu_notifier.c
> +++ b/mm/mmu_notifier.c
> @@ -983,7 +983,7 @@ int mmu_interval_notifier_insert(struct mmu_interval_notifier *interval_sub,
>   	struct mmu_notifier_subscriptions *subscriptions;
>   	int ret;
>   
> -	might_lock(&mm->mmap_sem);
> +	might_lock(&mm->mmap_lock);

Same here with a new mm_might_lock()?

>   
>   	subscriptions = smp_load_acquire(&mm->notifier_subscriptions);
>   	if (!subscriptions || !subscriptions->has_itree) {
> 

