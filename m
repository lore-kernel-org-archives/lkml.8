Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9042BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C12B2074B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgFLN3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:29:54 -0400
Received: from foss.arm.com ([217.140.110.172]:36358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgFLN3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 09:29:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 934C21F1;
        Fri, 12 Jun 2020 06:29:51 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.9.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 205533F6CF;
        Fri, 12 Jun 2020 06:29:48 -0700 (PDT)
Date:   Fri, 12 Jun 2020 14:29:43 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        jinho lim <jordan.lim@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] arm64: smp call when task currently running on other cpu
Message-ID: <20200612132943.GA71861@C02TD0UTHF1T.local>
References: <1591947707-15140-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591947707-15140-1-git-send-email-wangqing@vivo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 03:41:46PM +0800, Wang Qing wrote:
> We cannot get FP and PC when the task is running on another CPU,
> task->thread.cpu_context is the last time the task was switched out,
> we can use smp call to print backtrace itself.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>

Sorry, but NAK to this as-is. This is not a legitimate use of
dump_backtrace(), and even if we wanted to dump a backtrace of a
remotely running task, the patch is:

* Insufficient, since a remotely running task can become blocked after
  task_curr() is sampled.

* Insufficient and incorrect, since the task can be rescheduled after
  task->cpu is sampled. This patch could cause *another* task to dump a
  stacktrace.

* Unsafe, since tsk->cpu is accessed racily. In practice we'd likely get
  away with that, but it's not something we should rely on.

* Unsafe, since if this were ever called in IRQ context it could result
  in a deadlock.

Taking a step back, please explain *why* you think you need this?

What code in mainline is calling dumop_backtrace() on a remotely running
task?

Thanks,
Mark.

> ---
>  arch/arm64/kernel/traps.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  mode change 100644 => 100755 arch/arm64/kernel/traps.c
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 50cc30a..17a07b9
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -83,6 +83,11 @@ static void dump_kernel_instr(const char *lvl, struct pt_regs *regs)
>  	printk("%sCode: %s\n", lvl, str);
>  }
>  
> +static void dump_backtrace_smp_fun(struct task_struct *tsk)
> +{
> +	dump_backtrace(NULL, tsk, KERN_DEFAULT);
> +}
> +
>  void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
>  		    const char *loglvl)
>  {
> @@ -107,6 +112,12 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
>  		start_backtrace(&frame,
>  				(unsigned long)__builtin_frame_address(0),
>  				(unsigned long)dump_backtrace);
> +	} else if (task_curr(tsk)) {
> +		/*
> +		 * The task is currently running on other cpu
> +		 */
> +		smp_call_function_single(tsk->cpu, dump_backtrace_fun, tsk, 0);
> +		return;
>  	} else {
>  		/*
>  		 * task blocked in __switch_to
> -- 
> 2.7.4
> 
