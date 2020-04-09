Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C317BC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 12:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981BA20768
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 12:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgDIMBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 08:01:08 -0400
Received: from foss.arm.com ([217.140.110.172]:49274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbgDIMBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 08:01:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7DCA30E;
        Thu,  9 Apr 2020 05:01:08 -0700 (PDT)
Received: from [192.168.1.172] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEF923F73D;
        Thu,  9 Apr 2020 05:01:07 -0700 (PDT)
Subject: Re: [PATCH v2 2/6] arm64/vdso: Zap vvar pages when switching to a
 time namespace
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
References: <20200225073731.465270-1-avagin@gmail.com>
 <20200225073731.465270-3-avagin@gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <b56f9232-1914-4c7a-7aac-76207fb989c5@arm.com>
Date:   Thu, 9 Apr 2020 13:01:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200225073731.465270-3-avagin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/20 7:37 AM, Andrei Vagin wrote:
> The VVAR page layout depends on whether a task belongs to the root or
> non-root time namespace. Whenever a task changes its namespace, the VVAR
> page tables are cleared and then they will be re-faulted with a
> corresponding layout.
> 
> Signed-off-by: Andrei Vagin <avagin@gmail.com>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  arch/arm64/kernel/vdso.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index 290c36d74e03..6ac9cdeac5be 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -131,6 +131,38 @@ static int __vdso_init(enum arch_vdso_type arch_index)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_TIME_NS
> +/*
> + * The vvar page layout depends on whether a task belongs to the root or
> + * non-root time namespace. Whenever a task changes its namespace, the VVAR
> + * page tables are cleared and then they will re-faulted with a
> + * corresponding layout.
> + * See also the comment near timens_setup_vdso_data() for details.
> + */
> +int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
> +{
> +	struct mm_struct *mm = task->mm;
> +	struct vm_area_struct *vma;
> +
> +	if (down_write_killable(&mm->mmap_sem))
> +		return -EINTR;
> +
> +	for (vma = mm->mmap; vma; vma = vma->vm_next) {
> +		unsigned long size = vma->vm_end - vma->vm_start;
> +
> +		if (vma_is_special_mapping(vma, vdso_lookup[ARM64_VDSO].dm))
> +			zap_page_range(vma, vma->vm_start, size);
> +#ifdef CONFIG_COMPAT_VDSO
> +		if (vma_is_special_mapping(vma, vdso_lookup[ARM64_VDSO32].dm))
> +			zap_page_range(vma, vma->vm_start, size);
> +#endif
> +	}
> +
> +	up_write(&mm->mmap_sem);
> +	return 0;
> +}
> +#endif
> +
>  static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
>  			     struct vm_area_struct *vma, struct vm_fault *vmf)
>  {
> 

-- 
Regards,
Vincenzo
