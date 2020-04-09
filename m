Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D351C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 10:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B88E2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 10:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgDIKkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 06:40:25 -0400
Received: from foss.arm.com ([217.140.110.172]:48398 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgDIKkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 06:40:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6697631B;
        Thu,  9 Apr 2020 03:40:25 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2E0E3F73D;
        Thu,  9 Apr 2020 03:40:22 -0700 (PDT)
Date:   Thu, 9 Apr 2020 11:40:16 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        jinho lim <jordan.lim@samsung.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] ARM64: fixed dump_backtrace() when task running on
 another cpu
Message-ID: <20200409104016.GA2183@C02TD0UTHF1T.local>
References: <1586425106-7369-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586425106-7369-1-git-send-email-wangqing@vivo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 09, 2020 at 05:38:16PM +0800, Wang Qing wrote:
> We cannot get FP and PC when the task is running on another CPU,
> task->thread.cpu_context is the last time the task was switched out,
> it's better to give a reminder than to provide wrong information.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>

Are you seeing this happen anywhere in particular today?

> ---
>  arch/arm64/kernel/traps.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index cf402be..c04e3e8 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -106,6 +106,14 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>  		start_backtrace(&frame,
>  				(unsigned long)__builtin_frame_address(0),
>  				(unsigned long)dump_backtrace);
> +	} else if (tsk->on_cpu) {
> +		/*
> +		 * The task is running in another cpu, so the call stack
> +		 * is changing and we cannot get it.
> +		 */
> +		pr_warn("tsk: %s is running in CPU%d, Don't call trace!\n",
> +			tsk->comm, tsk->cpu);

I believe that we can race with a concurrent write to tsk->cpu in both
cases above. We could use READ_ONCE() to get a snapshot, but we can
still race and miss cases where the task was runnning as we backtrace
it.

Thanks,
Mark.

> +		return;
>  	} else {
>  		/*
>  		 * task blocked in __switch_to
> -- 
> 2.7.4
> 
