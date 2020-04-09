Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7666BC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 12:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545FE20753
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 12:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgDIMDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 08:03:43 -0400
Received: from foss.arm.com ([217.140.110.172]:49336 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgDIMDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 08:03:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 087B630E;
        Thu,  9 Apr 2020 05:03:43 -0700 (PDT)
Received: from [192.168.1.172] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF9063F73D;
        Thu,  9 Apr 2020 05:03:41 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] arm64/vdso: Handle faults on timens page
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
References: <20200225073731.465270-1-avagin@gmail.com>
 <20200225073731.465270-5-avagin@gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <658a52bb-400e-46d2-bfe8-1718c5c5f613@arm.com>
Date:   Thu, 9 Apr 2020 13:04:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200225073731.465270-5-avagin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/20 7:37 AM, Andrei Vagin wrote:
> If a task belongs to a time namespace then the VVAR page which contains
> the system wide VDSO data is replaced with a namespace specific page
> which has the same layout as the VVAR page.
> 
> Signed-off-by: Andrei Vagin <avagin@gmail.com>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  arch/arm64/kernel/vdso.c | 57 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 53 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index b3e7ce24e59b..fb32c6f76078 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -18,6 +18,7 @@
>  #include <linux/sched.h>
>  #include <linux/signal.h>
>  #include <linux/slab.h>
> +#include <linux/time_namespace.h>
>  #include <linux/timekeeper_internal.h>
>  #include <linux/vmalloc.h>
>  #include <vdso/datapage.h>
> @@ -175,15 +176,63 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
>  	up_write(&mm->mmap_sem);
>  	return 0;
>  }
> +
> +static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
> +{
> +	if (likely(vma->vm_mm == current->mm))
> +		return current->nsproxy->time_ns->vvar_page;
> +
> +	/*
> +	 * VM_PFNMAP | VM_IO protect .fault() handler from being called
> +	 * through interfaces like /proc/$pid/mem or
> +	 * process_vm_{readv,writev}() as long as there's no .access()
> +	 * in special_mapping_vmops().
> +	 * For more details check_vma_flags() and __access_remote_vm()
> +	 */
> +
> +	WARN(1, "vvar_page accessed remotely");
> +
> +	return NULL;
> +}
> +#else
> +static inline struct page *find_timens_vvar_page(struct vm_area_struct *vma)
> +{
> +	return NULL;
> +}
>  #endif
>  
>  static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
>  			     struct vm_area_struct *vma, struct vm_fault *vmf)
>  {
> -	if (vmf->pgoff == 0)
> -		return vmf_insert_pfn(vma, vmf->address,
> -				sym_to_pfn(vdso_data));
> -	return VM_FAULT_SIGBUS;
> +	struct page *timens_page = find_timens_vvar_page(vma);
> +	unsigned long pfn;
> +
> +	switch (vmf->pgoff) {
> +	case VVAR_DATA_PAGE_OFFSET:
> +		if (timens_page)
> +			pfn = page_to_pfn(timens_page);
> +		else
> +			pfn = sym_to_pfn(vdso_data);
> +		break;
> +#ifdef CONFIG_TIME_NS
> +	case VVAR_TIMENS_PAGE_OFFSET:
> +		/*
> +		 * If a task belongs to a time namespace then a namespace
> +		 * specific VVAR is mapped with the VVAR_DATA_PAGE_OFFSET and
> +		 * the real VVAR page is mapped with the VVAR_TIMENS_PAGE_OFFSET
> +		 * offset.
> +		 * See also the comment near timens_setup_vdso_data().
> +		 */
> +		if (!timens_page)
> +			return VM_FAULT_SIGBUS;
> +		pfn = sym_to_pfn(vdso_data);
> +		break;
> +#endif /* CONFIG_TIME_NS */
> +	default:
> +		return VM_FAULT_SIGBUS;
> +	}
> +
> +	return vmf_insert_pfn(vma, vmf->address, pfn);
>  }
>  
>  static int __setup_additional_pages(enum arch_vdso_type arch_index,
> 

-- 
Regards,
Vincenzo
