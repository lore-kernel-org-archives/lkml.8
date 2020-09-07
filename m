Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D636C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 015CB2192A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599499134;
	bh=IEZaBZy+wF6qUv3LytCsSz8WDwJL0KEc1L1DPsZ6+7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hWwfxOI/p1gpdU1/3MsWTL8RrwwjeZTfxkHwd2ca3sUqJUwHH3G3hH5n5QltVX0ZS
	 uVMSw2kGvUIJw7HtMqYUE3tFe6voBiK6JFPjybBs0RaIXp9HrFRsi6EysBgF1WxOyJ
	 AbunLJZZaOkIySMlAdUiUpkIJIK9lLj5yMd+Vysw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbgIGRSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:18:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729766AbgIGRSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 13:18:30 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44444206B8;
        Mon,  7 Sep 2020 17:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599499110;
        bh=IEZaBZy+wF6qUv3LytCsSz8WDwJL0KEc1L1DPsZ6+7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dl/DUE0pmefb4/xQ/Jr74SJHnHU31J7Hd7ut34f2DJhWbmQFq+lWETrJEIQKn/Bg7
         Hbx32NmMYECK6tCKnlKhXtF4evW0YXDidJ4/wCDBYJs6ImumYLxSZAhvDARqjL4CNq
         eEtMnw5Lfa5MQxvgU8aIN+cJ3uEZNWtPARKxxQy4=
Date:   Mon, 7 Sep 2020 18:18:25 +0100
From:   Will Deacon <will@kernel.org>
To:     Anthony Steinhauser <asteinhauser@google.com>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        maz@kernel.org
Subject: Re: [PATCH] PR_SPEC_DISABLE_NOEXEC support for arm64.
Message-ID: <20200907171825.GB13281@willie-the-truck>
References: <20200717110532.238533-1-asteinhauser@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717110532.238533-1-asteinhauser@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 04:05:32AM -0700, Anthony Steinhauser wrote:
> For x64 it was already implemented in:
> https://github.com/torvalds/linux/commit/71368af
> 
> The rationale is the same as for the x64 implementation.
> 
> Signed-off-by: Anthony Steinhauser <asteinhauser@google.com>
> ---
> 
> It's actively attempted by OpenJDK on arm64 CentOS and Fedora:
> https://git.centos.org/rpms/java-11-openjdk/blob/c8s/f/SOURCES/rh1566890-CVE_2018_3639-speculative_store_bypass.patch
> 
>  arch/arm64/include/asm/ssbd.h | 28 ++++++++++++++++++++++++++++
>  arch/arm64/kernel/process.c   | 13 +++++++++++++
>  arch/arm64/kernel/ssbd.c      | 34 +++++++++++++++++-----------------
>  3 files changed, 58 insertions(+), 17 deletions(-)
>  create mode 100644 arch/arm64/include/asm/ssbd.h

As a heads up: I'm currently reworking most of this, and hope to post
something within the next two weeks.

> diff --git a/arch/arm64/include/asm/ssbd.h b/arch/arm64/include/asm/ssbd.h
> new file mode 100644
> index 000000000000..68c716dc5811
> --- /dev/null
> +++ b/arch/arm64/include/asm/ssbd.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2020 Google LLC.
> + */
> +#ifndef __ASM_SSBD_H
> +#define __ASM_SSBD_H
> +
> +#include <linux/compat.h>
> +#include <linux/sched/task_stack.h>
> +#include <linux/thread_info.h>
> +
> +static inline void ssbd_ssbs_enable(struct task_struct *task)
> +{
> +	u64 val = is_compat_thread(task_thread_info(task)) ?
> +		PSR_AA32_SSBS_BIT : PSR_SSBS_BIT;
> +
> +	task_pt_regs(task)->pstate |= val;
> +}
> +
> +static inline void ssbd_ssbs_disable(struct task_struct *task)
> +{
> +	u64 val = is_compat_thread(task_thread_info(task)) ?
> +		PSR_AA32_SSBS_BIT : PSR_SSBS_BIT;
> +
> +	task_pt_regs(task)->pstate &= ~val;
> +}

I'd prefer to keep these where they are and have an out-of-line call if
necessary. We should try to keep the SSBD stuff in one place.

> +
> +#endif	/* __ASM_SSBD_H */
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 6089638c7d43..ad3c67c86c4c 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -54,6 +54,7 @@
>  #include <asm/mmu_context.h>
>  #include <asm/processor.h>
>  #include <asm/pointer_auth.h>
> +#include <asm/ssbd.h>
>  #include <asm/stacktrace.h>
>  
>  #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
> @@ -588,6 +589,18 @@ void arch_setup_new_exec(void)
>  	current->mm->context.flags = is_compat_task() ? MMCF_AARCH32 : 0;
>  
>  	ptrauth_thread_init_user(current);
> +
> +	/*
> +	 * Don't inherit TIF_SSBD across exec boundary when
> +	 * PR_SPEC_DISABLE_NOEXEC is used.
> +	 */
> +	if (test_thread_flag(TIF_SSBD) &&
> +	    task_spec_ssb_noexec(current)) {
> +		clear_thread_flag(TIF_SSBD);
> +		task_clear_spec_ssb_disable(current);
> +		task_clear_spec_ssb_noexec(current);
> +		ssbd_ssbs_enable(current);
> +	}

How is this supposed to work with CPUs that expose SSBS directly to
userspace? I suppose we should be using PR_SPEC_DISABLE_NOEXEC to decide
what we set the SSBS bit to on exec, but the logic here requires TIF_SSBD
to be set and so won't trigger afaict.

Will
