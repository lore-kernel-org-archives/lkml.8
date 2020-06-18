Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B1FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8F1721548
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6ov9/6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgFRH1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 03:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgFRH1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 03:27:09 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF22C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 00:27:08 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x207so2390331pfc.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 00:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A3ubcblAnaDWXRoE3s8Wx5ABEHKfjSCdNTnDkJVDCY0=;
        b=W6ov9/6Kk0ZMItTx7KoyrPrban7W1LXQCu8RT/PMVlmFnmV2hlNP4/nXwgulHvMuS7
         yq5ZKvB/KBZqDPewXpyRY4A9C+XxF7+RabnUzWKjKE0SZxsN0NIbkOMso3xVcx7YCpy9
         dHsZxDc4bTgEgaECIfW7DA/UlWU/0x1Es1fRtDQ6WbfZ+gE9f8xPYgWiAOgurljXiCY+
         r4Eg7IytomLHoKG8+AiKXwwxAcHhxTl5tv89PWrBBJPlVgiK0MHPGn+61Gb9X46iEHJ0
         nu+WxIQkL2wl67aD2Ubz0Yi1XDTUIq2m99+qV8+kSOLKfOp8uYRAvgfhVR3jyAI9156+
         ojXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A3ubcblAnaDWXRoE3s8Wx5ABEHKfjSCdNTnDkJVDCY0=;
        b=gvafYjYk0q01sJERol3nVV7TZ9lah5kys/LJOLeeD7Wj9H5CyxIHMlMbtLvwVLrffi
         SsU+qT/oIuaa6V1oJRZvMn8Olx6hqFrw4IvH+NnJcBLTiTZ2hl8J0Of2ZdlHHRt2R4oy
         J/7G3twwiG24pgLAAQjZcoyEIkUxT1XfbqpEuElk3RCjqrnlDiuiH14mSWU0X/p2lZKL
         Lblgsfs0FjjIktIWn0+jcfo3GmmvTvViqtbV8TL96N3UIYW32qWAsGV/EeS9RnL3+6vI
         wRvWnN5ONMPi/CufbyKnoWjMdxxHwZDm1XmsFmODk3H5l787Z9nMAjSIpEBdQwwNvcwS
         kc3A==
X-Gm-Message-State: AOAM531h4VfWkYcnTjPpvxFMJUqBk20uIYDz60Pqzx4QWjvieWRIJtOz
        GfXjMz4g/PXNAG3lHXbpHpg=
X-Google-Smtp-Source: ABdhPJwjG30ZacKK/HiF9nqSz3xZMZCO1XBbk2akA/VonsQLgkaCx57QCDmPY/ktMJTThJ7ZbEdJ/A==
X-Received: by 2002:a63:ce45:: with SMTP id r5mr2314813pgi.320.1592465227759;
        Thu, 18 Jun 2020 00:27:07 -0700 (PDT)
Received: from gmail.com ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id x77sm1988193pfc.4.2020.06.18.00.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 00:27:07 -0700 (PDT)
Date:   Thu, 18 Jun 2020 00:27:05 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH 1/6] arm64/vdso: use the fault callback to map vvar pages
Message-ID: <20200618072705.GA334958@gmail.com>
References: <20200616075545.312684-1-avagin@gmail.com>
 <20200616075545.312684-2-avagin@gmail.com>
 <20200616105920.GB11780@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20200616105920.GB11780@C02TD0UTHF1T.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 11:59:20AM +0100, Mark Rutland wrote:
> On Tue, Jun 16, 2020 at 12:55:40AM -0700, Andrei Vagin wrote:
> > This is required to support time namespaces where a time namespace data
> > page is different for each namespace.
> 
> Can you please give a bit more of an introduction to the changes here?
> As-is, this doesn't give reviewers the necessary context to understand
> the change, nor does it justify it.
> 
> Ideally, a commit message for this should look something like:

Mark, thank you for the review. I will write more details message and
fix this patch according with your other comments.

> 
> | Currently the vdso has no awareness of time namespaces, which may
> | apply distinct offsets to processes in different namespaces. To handle
> | this within the vdso, we'll need to expose a per-namespace data page.
> |
> | As a preparatory step, this patch separates the vdso data page from
> | the code pages, and has it faulted in via its own fault callback.
> | Subsquent patches will extend this to support distinct pages per time
> | namespace.
> 
> Otherwise, I have a few minor comments below.
> 
> > Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Reviewed-by: Dmitry Safonov <dima@arista.com>
> > Signed-off-by: Andrei Vagin <avagin@gmail.com>
> > ---
> >  arch/arm64/kernel/vdso.c | 24 +++++++++++++++---------
> >  1 file changed, 15 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> > index 4e016574bd91..b0aec4e8c9b4 100644
> > --- a/arch/arm64/kernel/vdso.c
> > +++ b/arch/arm64/kernel/vdso.c
> > @@ -108,28 +108,32 @@ static int __vdso_init(enum vdso_abi abi)
> >  			PAGE_SHIFT;
> >  
> >  	/* Allocate the vDSO pagelist, plus a page for the data. */
> > -	vdso_pagelist = kcalloc(vdso_info[abi].vdso_pages + 1,
> > +	vdso_pagelist = kcalloc(vdso_info[abi].vdso_pages,
> >  				sizeof(struct page *),
> >  				GFP_KERNEL);
> 
> The comment above is now stale. Can you please update it, or (event
> better) delete it entirely?

I will delete it.

> 
> >  	if (vdso_pagelist == NULL)
> >  		return -ENOMEM;
> >  
> > -	/* Grab the vDSO data page. */
> > -	vdso_pagelist[0] = phys_to_page(__pa_symbol(vdso_data));
> > -
> > -
> >  	/* Grab the vDSO code pages. */
> >  	pfn = sym_to_pfn(vdso_info[abi].vdso_code_start);
> >  
> >  	for (i = 0; i < vdso_info[abi].vdso_pages; i++)
> > -		vdso_pagelist[i + 1] = pfn_to_page(pfn + i);
> > +		vdso_pagelist[i] = pfn_to_page(pfn + i);
> >  
> > -	vdso_info[abi].dm->pages = &vdso_pagelist[0];
> > -	vdso_info[abi].cm->pages = &vdso_pagelist[1];
> > +	vdso_info[abi].cm->pages = vdso_pagelist;
> >  
> >  	return 0;
> >  }
> >  
> > +static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
> > +			     struct vm_area_struct *vma, struct vm_fault *vmf)
> > +{
> > +	if (vmf->pgoff == 0)
> > +		return vmf_insert_pfn(vma, vmf->address,
> > +				sym_to_pfn(vdso_data));
> > +	return VM_FAULT_SIGBUS;
> > +}
> 
> This might look better as:

In the next patch, this function will handle more pages and this form
will look better.

> 
> |	if (vmf->pgoff != 0)
> |		return VM_FAULT_SIGBUS;
> |	
> |	return vmf_insert_pfn(vma, vmf->address, sym_to_pfn(vdso_data));
> 
> > +
> >  static int __setup_additional_pages(enum vdso_abi abi,
> >  				    struct mm_struct *mm,
> >  				    struct linux_binprm *bprm,
> > @@ -150,7 +154,7 @@ static int __setup_additional_pages(enum vdso_abi abi,
> >  	}
> >  
> >  	ret = _install_special_mapping(mm, vdso_base, PAGE_SIZE,
> > -				       VM_READ|VM_MAYREAD,
> > +				       VM_READ|VM_MAYREAD|VM_PFNMAP,
> 
> This change needs to be explained in the commit message. WHy is it
> necessary, and why only so for the data page?

I will update the commit message. VM_PFNMAP is required to handle faults
from a vma fault callback. In this case, it is vvar_fault.

> 
> Thanks,
> Mark.
> 
> >  				       vdso_info[abi].dm);
> >  	if (IS_ERR(ret))
> >  		goto up_fail;
> > @@ -209,6 +213,7 @@ static struct vm_special_mapping aarch32_vdso_maps[] = {
> >  #ifdef CONFIG_COMPAT_VDSO
> >  	[AA32_MAP_VVAR] = {
> >  		.name = "[vvar]",
> > +		.fault = vvar_fault,
> >  	},
> >  	[AA32_MAP_VDSO] = {
> >  		.name = "[vdso]",
> > @@ -376,6 +381,7 @@ enum aarch64_map {
> >  static struct vm_special_mapping aarch64_vdso_maps[] __ro_after_init = {
> >  	[AA64_MAP_VVAR] = {
> >  		.name	= "[vvar]",
> > +		.fault = vvar_fault,
> >  	},
> >  	[AA64_MAP_VDSO] = {
> >  		.name	= "[vdso]",
> > -- 
> > 2.24.1
> > 
