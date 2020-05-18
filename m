Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FBCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8C4E2065F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgERNXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:23:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8682 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726800AbgERNXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:23:24 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04ID44i4159992;
        Mon, 18 May 2020 09:23:16 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 312cagtejt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 09:23:15 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04ID5V5t171303;
        Mon, 18 May 2020 09:23:15 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 312cagtehx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 09:23:15 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04IDKvoM016004;
        Mon, 18 May 2020 13:23:13 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3127t5m79r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 13:23:13 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04IDNBE79437664
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 May 2020 13:23:11 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5430A4204F;
        Mon, 18 May 2020 13:23:11 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EA534203F;
        Mon, 18 May 2020 13:23:10 +0000 (GMT)
Received: from pomme.local (unknown [9.145.67.24])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 May 2020 13:23:10 +0000 (GMT)
Subject: Re: [PATCH v5 05/10] mmap locking API: convert mmap_sem call sites
 missed by coccinelle
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
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
References: <20200422001422.232330-1-walken@google.com>
 <20200422001422.232330-6-walken@google.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
Message-ID: <107a23f9-dde0-8e60-6117-4c1f9f6e4e58@linux.ibm.com>
Date:   Mon, 18 May 2020 15:23:10 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200422001422.232330-6-walken@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-18_06:2020-05-15,2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=2
 bulkscore=0 mlxlogscore=999 adultscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 cotscore=-2147483648 phishscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005180117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 22/04/2020 à 02:14, Michel Lespinasse a écrit :
> Convert the last few remaining mmap_sem rwsem calls to use the new
> mmap locking API. These were missed by coccinelle for some reason
> (I think coccinelle does not support some of the preprocessor
> constructs in these files ?)
> 
> Signed-off-by: Michel Lespinasse <walken@google.com>
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>

Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>

> ---
>   arch/mips/mm/fault.c           | 10 +++++-----
>   arch/riscv/mm/pageattr.c       |  4 ++--
>   arch/x86/kvm/mmu/paging_tmpl.h |  8 ++++----
>   drivers/android/binder_alloc.c |  4 ++--
>   fs/proc/base.c                 |  6 +++---
>   5 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
> index f8d62cd83b36..9ef2dd39111e 100644
> --- a/arch/mips/mm/fault.c
> +++ b/arch/mips/mm/fault.c
> @@ -97,7 +97,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
>   	if (user_mode(regs))
>   		flags |= FAULT_FLAG_USER;
>   retry:
> -	down_read(&mm->mmap_sem);
> +	mmap_read_lock(mm);
>   	vma = find_vma(mm, address);
>   	if (!vma)
>   		goto bad_area;
> @@ -190,7 +190,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
>   		}
>   	}
>   
> -	up_read(&mm->mmap_sem);
> +	mmap_read_unlock(mm);
>   	return;
>   
>   /*
> @@ -198,7 +198,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
>    * Fix it, but check if it's kernel or user first..
>    */
>   bad_area:
> -	up_read(&mm->mmap_sem);
> +	mmap_read_unlock(mm);
>   
>   bad_area_nosemaphore:
>   	/* User mode accesses just cause a SIGSEGV */
> @@ -250,14 +250,14 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
>   	 * We ran out of memory, call the OOM killer, and return the userspace
>   	 * (which will retry the fault, or kill us if we got oom-killed).
>   	 */
> -	up_read(&mm->mmap_sem);
> +	mmap_read_unlock(mm);
>   	if (!user_mode(regs))
>   		goto no_context;
>   	pagefault_out_of_memory();
>   	return;
>   
>   do_sigbus:
> -	up_read(&mm->mmap_sem);
> +	mmap_read_unlock(mm);
>   
>   	/* Kernel mode? Handle exceptions or die */
>   	if (!user_mode(regs))
> diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> index 728759eb530a..b9072c043222 100644
> --- a/arch/riscv/mm/pageattr.c
> +++ b/arch/riscv/mm/pageattr.c
> @@ -117,10 +117,10 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
>   	if (!numpages)
>   		return 0;
>   
> -	down_read(&init_mm.mmap_sem);
> +	mmap_read_lock(&init_mm);
>   	ret =  walk_page_range_novma(&init_mm, start, end, &pageattr_ops, NULL,
>   				     &masks);
> -	up_read(&init_mm.mmap_sem);
> +	mmap_read_unlock(&init_mm);
>   
>   	flush_tlb_kernel_range(start, end);
>   
> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
> index 9bdf9b7d9a96..40e5bb67cc09 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -165,22 +165,22 @@ static int FNAME(cmpxchg_gpte)(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
>   		unsigned long pfn;
>   		unsigned long paddr;
>   
> -		down_read(&current->mm->mmap_sem);
> +		mmap_read_lock(current->mm);
>   		vma = find_vma_intersection(current->mm, vaddr, vaddr + PAGE_SIZE);
>   		if (!vma || !(vma->vm_flags & VM_PFNMAP)) {
> -			up_read(&current->mm->mmap_sem);
> +			mmap_read_unlock(current->mm);
>   			return -EFAULT;
>   		}
>   		pfn = ((vaddr - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
>   		paddr = pfn << PAGE_SHIFT;
>   		table = memremap(paddr, PAGE_SIZE, MEMREMAP_WB);
>   		if (!table) {
> -			up_read(&current->mm->mmap_sem);
> +			mmap_read_unlock(current->mm);
>   			return -EFAULT;
>   		}
>   		ret = CMPXCHG(&table[index], orig_pte, new_pte);
>   		memunmap(table);
> -		up_read(&current->mm->mmap_sem);
> +		mmap_read_unlock(current->mm);
>   	}
>   
>   	return (ret != orig_pte);
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 5e063739a3a8..cbdc43ed0f9f 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -932,7 +932,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
>   	mm = alloc->vma_vm_mm;
>   	if (!mmget_not_zero(mm))
>   		goto err_mmget;
> -	if (!down_read_trylock(&mm->mmap_sem))
> +	if (!mmap_read_trylock(mm))
>   		goto err_down_read_mmap_sem_failed;
>   	vma = binder_alloc_get_vma(alloc);
>   
> @@ -946,7 +946,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
>   
>   		trace_binder_unmap_user_end(alloc, index);
>   	}
> -	up_read(&mm->mmap_sem);
> +	mmap_read_unlock(mm);
>   	mmput(mm);
>   
>   	trace_binder_unmap_kernel_start(alloc, index);
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 8fff3c955530..ebb356434652 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2314,7 +2314,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
>   	if (!mm)
>   		goto out_put_task;
>   
> -	ret = down_read_killable(&mm->mmap_sem);
> +	ret = mmap_read_lock_killable(mm);
>   	if (ret) {
>   		mmput(mm);
>   		goto out_put_task;
> @@ -2341,7 +2341,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
>   		p = genradix_ptr_alloc(&fa, nr_files++, GFP_KERNEL);
>   		if (!p) {
>   			ret = -ENOMEM;
> -			up_read(&mm->mmap_sem);
> +			mmap_read_unlock(mm);
>   			mmput(mm);
>   			goto out_put_task;
>   		}
> @@ -2350,7 +2350,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
>   		p->end = vma->vm_end;
>   		p->mode = vma->vm_file->f_mode;
>   	}
> -	up_read(&mm->mmap_sem);
> +	mmap_read_unlock(mm);
>   	mmput(mm);
>   
>   	for (i = 0; i < nr_files; i++) {
> 

