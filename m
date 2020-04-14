Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86E5C2BB86
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2B16208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502367AbgDNMzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:55:04 -0400
Received: from foss.arm.com ([217.140.110.172]:54860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502340AbgDNMy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:54:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2209630E;
        Tue, 14 Apr 2020 05:54:58 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.30.4])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1966E3F73D;
        Tue, 14 Apr 2020 05:54:56 -0700 (PDT)
Date:   Tue, 14 Apr 2020 13:54:54 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Wang Qing <wangqing@vivo.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] ARM64: fixed dump_backtrace() when task running on
 another cpu
Message-ID: <20200414125454.GE2486@C02TD0UTHF1T.local>
References: <1586425106-7369-1-git-send-email-wangqing@vivo.com>
 <1586769788-5954-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586769788-5954-1-git-send-email-wangqing@vivo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 05:23:08PM +0800, Wang Qing wrote:
> >Hi,
> >
> >On Thu, Apr 09, 2020 at 05:38:16PM +0800, Wang Qing wrote:
> >> We cannot get FP and PC when the task is running on another CPU,
> >> task->thread.cpu_context is the last time the task was switched out,
> >> it's better to give a reminder than to provide wrong information.
> >> 
> >> Signed-off-by: Wang Qing <wangqing@vivo.com>
> >
> >Are you seeing this happen anywhere in particular today?
> 
> This problem is not so obvious, because it will not cause any exceptions
> but will show "old" stack always ending with switch_to, I finally confirmed
> the problem through debugging.
> 
> For example:Task blocked in spinlock/interrupt/busy loop, I want to print
> the backtrace when detected(like PSI in Android), the printing is wrong(old).

Sure, but *where* are you seeing this?

Is this a problem in mainline, or only in code that you add?
 
> >
> >> ---
> >>  arch/arm64/kernel/traps.c | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >> 
> >> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> >> index cf402be..c04e3e8 100644
> >> --- a/arch/arm64/kernel/traps.c
> >> +++ b/arch/arm64/kernel/traps.c
> >> @@ -106,6 +106,14 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
> >>  		start_backtrace(&frame,
> >>  				(unsigned long)__builtin_frame_address(0),
> >>  				(unsigned long)dump_backtrace);
> >> +	} else if (tsk->on_cpu) {
> >> +		/*
> >> +		 * The task is running in another cpu, so the call stack
> >> +		 * is changing and we cannot get it.
> >> +		 */
> >> +		pr_warn("tsk: %s is running in CPU%d, Don't call trace!\n",
> >> +			tsk->comm, tsk->cpu);
> >
> >I believe that we can race with a concurrent write to tsk->cpu in both
> >cases above. We could use READ_ONCE() to get a snapshot, but we can
> >still race and miss cases where the task was runnning as we backtrace
> >it.
> >
> >Thanks,
> >Mark.
> 
> I will use task_cpu(tsk) instead of tsk->cpu, and add task_running_oncpu() in
> include/linux/sched.h instead of tsk->on_cpu, but as you said, by this patch,
> we can still race and miss cases where the task was runnning as we backtrace.
> 
> But from the user's perspective, printing wrong backtrace is confused when
> we call this function while task already running. However, it's reasonable to
> print the last backtrace when task enter running during the function is called.

The contract of dump_backtrace() is that it's only called for either:

* the current task
* a task that is blocked in switch_to()

... so I don't think that the current behaviour is wrong as such, though
if it's easy to catch misuse I agree it would be nice to do so for
robustness.

However, we can alwatys race here, so detecting this case is best-effort
and not entirely reliable, and I don't want to leave the impression that
it is. I'm also not a fan of pr_warn() here, since this is indicative of
a kernel bug rather than a user/system issue, and can spam the console
due to a lack of ratelimiting.

So, based on whether this is a problem in existing code, I'd like that
code fix first, and then we can consider adding a WARN_ONCE() or
something ratelimited. Ideally something that'll give us the bactrace or
the code that's calling dump_backtrace() erroneously.

Thanks,
Mark.
