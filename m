Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABCCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 10:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 891BD20A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 10:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgFPK7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 06:59:32 -0400
Received: from foss.arm.com ([217.140.110.172]:35430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728306AbgFPK7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 06:59:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2B221F1;
        Tue, 16 Jun 2020 03:59:24 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.1.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 401933F6CF;
        Tue, 16 Jun 2020 03:59:23 -0700 (PDT)
Date:   Tue, 16 Jun 2020 11:59:20 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH 1/6] arm64/vdso: use the fault callback to map vvar pages
Message-ID: <20200616105920.GB11780@C02TD0UTHF1T.local>
References: <20200616075545.312684-1-avagin@gmail.com>
 <20200616075545.312684-2-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616075545.312684-2-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 12:55:40AM -0700, Andrei Vagin wrote:
> This is required to support time namespaces where a time namespace data
> page is different for each namespace.

Can you please give a bit more of an introduction to the changes here?
As-is, this doesn't give reviewers the necessary context to understand
the change, nor does it justify it.

Ideally, a commit message for this should look something like:

| Currently the vdso has no awareness of time namespaces, which may
| apply distinct offsets to processes in different namespaces. To handle
| this within the vdso, we'll need to expose a per-namespace data page.
|
| As a preparatory step, this patch separates the vdso data page from
| the code pages, and has it faulted in via its own fault callback.
| Subsquent patches will extend this to support distinct pages per time
| namespace.

Otherwise, I have a few minor comments below.

> Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Dmitry Safonov <dima@arista.com>
> Signed-off-by: Andrei Vagin <avagin@gmail.com>
> ---
>  arch/arm64/kernel/vdso.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index 4e016574bd91..b0aec4e8c9b4 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -108,28 +108,32 @@ static int __vdso_init(enum vdso_abi abi)
>  			PAGE_SHIFT;
>  
>  	/* Allocate the vDSO pagelist, plus a page for the data. */
> -	vdso_pagelist = kcalloc(vdso_info[abi].vdso_pages + 1,
> +	vdso_pagelist = kcalloc(vdso_info[abi].vdso_pages,
>  				sizeof(struct page *),
>  				GFP_KERNEL);

The comment above is now stale. Can you please update it, or (event
better) delete it entirely?

>  	if (vdso_pagelist == NULL)
>  		return -ENOMEM;
>  
> -	/* Grab the vDSO data page. */
> -	vdso_pagelist[0] = phys_to_page(__pa_symbol(vdso_data));
> -
> -
>  	/* Grab the vDSO code pages. */
>  	pfn = sym_to_pfn(vdso_info[abi].vdso_code_start);
>  
>  	for (i = 0; i < vdso_info[abi].vdso_pages; i++)
> -		vdso_pagelist[i + 1] = pfn_to_page(pfn + i);
> +		vdso_pagelist[i] = pfn_to_page(pfn + i);
>  
> -	vdso_info[abi].dm->pages = &vdso_pagelist[0];
> -	vdso_info[abi].cm->pages = &vdso_pagelist[1];
> +	vdso_info[abi].cm->pages = vdso_pagelist;
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

This might look better as:

|	if (vmf->pgoff != 0)
|		return VM_FAULT_SIGBUS;
|	
|	return vmf_insert_pfn(vma, vmf->address, sym_to_pfn(vdso_data));

> +
>  static int __setup_additional_pages(enum vdso_abi abi,
>  				    struct mm_struct *mm,
>  				    struct linux_binprm *bprm,
> @@ -150,7 +154,7 @@ static int __setup_additional_pages(enum vdso_abi abi,
>  	}
>  
>  	ret = _install_special_mapping(mm, vdso_base, PAGE_SIZE,
> -				       VM_READ|VM_MAYREAD,
> +				       VM_READ|VM_MAYREAD|VM_PFNMAP,

This change needs to be explained in the commit message. WHy is it
necessary, and why only so for the data page?

Thanks,
Mark.

>  				       vdso_info[abi].dm);
>  	if (IS_ERR(ret))
>  		goto up_fail;
> @@ -209,6 +213,7 @@ static struct vm_special_mapping aarch32_vdso_maps[] = {
>  #ifdef CONFIG_COMPAT_VDSO
>  	[AA32_MAP_VVAR] = {
>  		.name = "[vvar]",
> +		.fault = vvar_fault,
>  	},
>  	[AA32_MAP_VDSO] = {
>  		.name = "[vdso]",
> @@ -376,6 +381,7 @@ enum aarch64_map {
>  static struct vm_special_mapping aarch64_vdso_maps[] __ro_after_init = {
>  	[AA64_MAP_VVAR] = {
>  		.name	= "[vvar]",
> +		.fault = vvar_fault,
>  	},
>  	[AA64_MAP_VDSO] = {
>  		.name	= "[vdso]",
> -- 
> 2.24.1
> 
