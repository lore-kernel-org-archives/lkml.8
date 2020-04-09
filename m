Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBC0C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 12:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60D920768
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 12:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgDIMA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 08:00:29 -0400
Received: from foss.arm.com ([217.140.110.172]:49250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgDIMA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 08:00:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0726730E;
        Thu,  9 Apr 2020 05:00:29 -0700 (PDT)
Received: from [192.168.1.172] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB4323F73D;
        Thu,  9 Apr 2020 05:00:27 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] arm64/vdso: use the fault callback to map vvar
 pages
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
References: <20200225073731.465270-1-avagin@gmail.com>
 <20200225073731.465270-2-avagin@gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <fd287633-a383-e1ee-2c4a-b961e1b95d66@arm.com>
Date:   Thu, 9 Apr 2020 13:01:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200225073731.465270-2-avagin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/20 7:37 AM, Andrei Vagin wrote:
> This is required to support time namespaces where a time namespace data
> page is different for each namespace.
> 
> Signed-off-by: Andrei Vagin <avagin@gmail.com>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  arch/arm64/kernel/vdso.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index 354b11e27c07..290c36d74e03 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -114,28 +114,32 @@ static int __vdso_init(enum arch_vdso_type arch_index)
>  			PAGE_SHIFT;
>  
>  	/* Allocate the vDSO pagelist, plus a page for the data. */
> -	vdso_pagelist = kcalloc(vdso_lookup[arch_index].vdso_pages + 1,
> +	vdso_pagelist = kcalloc(vdso_lookup[arch_index].vdso_pages,
>  				sizeof(struct page *),
>  				GFP_KERNEL);
>  	if (vdso_pagelist == NULL)
>  		return -ENOMEM;
>  
> -	/* Grab the vDSO data page. */
> -	vdso_pagelist[0] = phys_to_page(__pa_symbol(vdso_data));
> -
> -
>  	/* Grab the vDSO code pages. */
>  	pfn = sym_to_pfn(vdso_lookup[arch_index].vdso_code_start);
>  
>  	for (i = 0; i < vdso_lookup[arch_index].vdso_pages; i++)
> -		vdso_pagelist[i + 1] = pfn_to_page(pfn + i);
> +		vdso_pagelist[i] = pfn_to_page(pfn + i);
>  
> -	vdso_lookup[arch_index].dm->pages = &vdso_pagelist[0];
> -	vdso_lookup[arch_index].cm->pages = &vdso_pagelist[1];
> +	vdso_lookup[arch_index].cm->pages = vdso_pagelist;
>  
>  	return 0;
>  }
>  
> +static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
> +			     struct vm_area_struct *vma, struct vm_fault *vmf)
> +{
> +	if (vmf->pgoff == 0)
> +		return vmf_insert_pfn(vma, vmf->address,
> +				sym_to_pfn(vdso_data));
> +	return VM_FAULT_SIGBUS;
> +}
> +
>  static int __setup_additional_pages(enum arch_vdso_type arch_index,
>  				    struct mm_struct *mm,
>  				    struct linux_binprm *bprm,
> @@ -155,7 +159,7 @@ static int __setup_additional_pages(enum arch_vdso_type arch_index,
>  	}
>  
>  	ret = _install_special_mapping(mm, vdso_base, PAGE_SIZE,
> -				       VM_READ|VM_MAYREAD,
> +				       VM_READ|VM_MAYREAD|VM_PFNMAP,
>  				       vdso_lookup[arch_index].dm);
>  	if (IS_ERR(ret))
>  		goto up_fail;
> @@ -215,6 +219,7 @@ static struct vm_special_mapping aarch32_vdso_spec[C_PAGES] = {
>  #ifdef CONFIG_COMPAT_VDSO
>  	{
>  		.name = "[vvar]",
> +		.fault = vvar_fault,
>  	},
>  	{
>  		.name = "[vdso]",
> @@ -396,6 +401,7 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
>  static struct vm_special_mapping vdso_spec[A_PAGES] __ro_after_init = {
>  	{
>  		.name	= "[vvar]",
> +		.fault = vvar_fault,
>  	},
>  	{
>  		.name	= "[vdso]",
> 

-- 
Regards,
Vincenzo
