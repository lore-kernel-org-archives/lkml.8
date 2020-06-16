Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148B0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAF4520734
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgFPLYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:24:24 -0400
Received: from foss.arm.com ([217.140.110.172]:35720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgFPLYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 07:24:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A4D71F1;
        Tue, 16 Jun 2020 04:24:23 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.1.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AD463F6CF;
        Tue, 16 Jun 2020 04:24:21 -0700 (PDT)
Date:   Tue, 16 Jun 2020 12:24:18 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH 2/6] arm64/vdso: Zap vvar pages when switching to a time
 namespace
Message-ID: <20200616112418.GC11780@C02TD0UTHF1T.local>
References: <20200616075545.312684-1-avagin@gmail.com>
 <20200616075545.312684-3-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616075545.312684-3-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 12:55:41AM -0700, Andrei Vagin wrote:
> The VVAR page layout depends on whether a task belongs to the root or
> non-root time namespace.

Please be more explicit as to what you mean by `layout` here, as that seems to
be an overloaded term. For example, the comment above timens_setup_vdso_data()
can be read to directly contradict this:

| A time namespace VVAR page has the same layout as the VVAR page which
| contains the system wide VDSO data.

... I think you're trying to say is that when we add time namespace support,
we'll have multiple VVAR pages, and their position in the address space depends
on whether the task is part of a time namespace.

> Whenever a task changes its namespace, the VVAR
> page tables are cleared and then they will be re-faulted with a
> corresponding layout.

How does this work for multi-threaded applications? Are there any
concerns w.r.t. atomicity of the change?

> Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Dmitry Safonov <dima@arista.com>
> Signed-off-by: Andrei Vagin <avagin@gmail.com>
> ---
>  arch/arm64/kernel/vdso.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index b0aec4e8c9b4..df4bb736d28a 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -125,6 +125,38 @@ static int __vdso_init(enum vdso_abi abi)
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

As with the commit message, this is not very clear and can be read to
contradict the comment it refers to, which is rather unhelpful.

How about:

/*
 * The vvar mapping contains data for a specific time namespace, so when
 * a task changes namespace we must unmap its vvar data for the old
 * namespace. Subsequent faults will map in data for the new namespace.
 *
 * For more details see timens_setup_vdso_data().
 */

Thanks,
Mark.

> +int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
> +{
> +	struct mm_struct *mm = task->mm;
> +	struct vm_area_struct *vma;
> +
> +	if (mmap_write_lock_killable(mm))
> +		return -EINTR;
> +
> +	for (vma = mm->mmap; vma; vma = vma->vm_next) {
> +		unsigned long size = vma->vm_end - vma->vm_start;
> +
> +		if (vma_is_special_mapping(vma, vdso_info[VDSO_ABI_AA64].dm))
> +			zap_page_range(vma, vma->vm_start, size);
> +#ifdef CONFIG_COMPAT_VDSO
> +		if (vma_is_special_mapping(vma, vdso_info[VDSO_ABI_AA32].dm))
> +			zap_page_range(vma, vma->vm_start, size);
> +#endif
> +	}
> +
> +	mmap_write_unlock(mm);
> +	return 0;
> +}
> +#endif
> +
>  static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
>  			     struct vm_area_struct *vma, struct vm_fault *vmf)
>  {
> -- 
> 2.24.1
> 
