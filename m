Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3010FC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 12:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F257E20753
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 12:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgDIMEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 08:04:33 -0400
Received: from foss.arm.com ([217.140.110.172]:49364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbgDIMEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 08:04:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33B1830E;
        Thu,  9 Apr 2020 05:04:33 -0700 (PDT)
Received: from [192.168.1.172] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F8FD3F73D;
        Thu,  9 Apr 2020 05:04:31 -0700 (PDT)
Subject: Re: [PATCH v2 5/6] arm64/vdso: Restrict splitting VVAR VMA
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
References: <20200225073731.465270-1-avagin@gmail.com>
 <20200225073731.465270-6-avagin@gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <31a0e784-7d38-b9aa-d84c-8deb6436b647@arm.com>
Date:   Thu, 9 Apr 2020 13:05:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200225073731.465270-6-avagin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/20 7:37 AM, Andrei Vagin wrote:
> Forbid splitting VVAR VMA resulting in a stricter ABI and reducing the
> amount of corner-cases to consider while working further on VDSO time
> namespace support.
> 
> As the offset from timens to VVAR page is computed compile-time, the pages
> in VVAR should stay together and not being partically mremap()'ed.
> 
> Signed-off-by: Andrei Vagin <avagin@gmail.com>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  arch/arm64/kernel/vdso.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index fb32c6f76078..c003f7ee383a 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -235,6 +235,17 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
>  	return vmf_insert_pfn(vma, vmf->address, pfn);
>  }
>  
> +static int vvar_mremap(const struct vm_special_mapping *sm,
> +		       struct vm_area_struct *new_vma)
> +{
> +	unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
> +
> +	if (new_size != VVAR_NR_PAGES * PAGE_SIZE)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static int __setup_additional_pages(enum arch_vdso_type arch_index,
>  				    struct mm_struct *mm,
>  				    struct linux_binprm *bprm,
> @@ -315,6 +326,7 @@ static struct vm_special_mapping aarch32_vdso_spec[C_PAGES] = {
>  	{
>  		.name = "[vvar]",
>  		.fault = vvar_fault,
> +		.mremap = vvar_mremap,
>  	},
>  	{
>  		.name = "[vdso]",
> @@ -497,6 +509,7 @@ static struct vm_special_mapping vdso_spec[A_PAGES] __ro_after_init = {
>  	{
>  		.name	= "[vvar]",
>  		.fault = vvar_fault,
> +		.mremap = vvar_mremap,
>  	},
>  	{
>  		.name	= "[vdso]",
> 

-- 
Regards,
Vincenzo
