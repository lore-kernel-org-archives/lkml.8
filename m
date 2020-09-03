Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72ADC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC6A620775
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgICQQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:16:42 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:49254 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgICQQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:16:42 -0400
Date:   Thu, 3 Sep 2020 12:16:40 -0400
From:   Rich Felker <dalias@libc.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-sh@vger.kernel.org,
        Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH] sh: fix syscall tracing
Message-ID: <20200903161639.GE3265@brightrain.aerifal.cx>
References: <20200903054803.GX3265@brightrain.aerifal.cx>
 <e456a455-62cd-4f76-a69a-84d1e5b4d153@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e456a455-62cd-4f76-a69a-84d1e5b4d153@physik.fu-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 12:14:43PM +0200, John Paul Adrian Glaubitz wrote:
> Hi Rich!
> 
> On 9/3/20 7:48 AM, Rich Felker wrote:
> > Addition of SECCOMP_FILTER exposed a longstanding bug in
> > do_syscall_trace_enter, whereby r0 (the 5th argument register) was
> > mistakenly used where r3 (syscall_nr) was intended. By overwriting r0
> > rather than r3 with -1 when attempting to block a syscall, the
> > existing code would instead have caused the syscall to execute with an
> > argument clobbered.
> > 
> > Commit 0bb605c2c7f2b4b3 then introduced skipping of the syscall when
> > do_syscall_trace_enter returns -1, so that the return value set by
> > seccomp filters would not be clobbered by -ENOSYS. This eliminated the
> > clobbering of the 5th argument register, but instead caused syscalls
> > made with a 5th argument of -1 to be misinterpreted as a request by
> > do_syscall_trace_enter to suppress the syscall.
> > 
> > Fixes: 0bb605c2c7f2b4b3 ("sh: Add SECCOMP_FILTER")
> > Fixes: ab99c733ae73cce3 ("sh: Make syscall tracer use tracehook notifiers, add TIF_NOTIFY_RESUME.")
> > Signed-off-by: Rich Felker <dalias@libc.org>
> > ---
> >  arch/sh/kernel/entry-common.S |  1 -
> >  arch/sh/kernel/ptrace_32.c    | 15 +++++----------
> >  2 files changed, 5 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/sh/kernel/entry-common.S b/arch/sh/kernel/entry-common.S
> > index ad963104d22d..91ab2607a1ff 100644
> > --- a/arch/sh/kernel/entry-common.S
> > +++ b/arch/sh/kernel/entry-common.S
> > @@ -370,7 +370,6 @@ syscall_trace_entry:
> >  	 nop
> >  	cmp/eq	#-1, r0
> >  	bt	syscall_exit
> > -	mov.l	r0, @(OFF_R0,r15)	! Save return value
> >  	!			Reload R0-R4 from kernel stack, where the
> >  	!   	    	    	parent may have modified them using
> >  	!   	    	    	ptrace(POKEUSR).  (Note that R0-R2 are
> > diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
> > index b05bf92f9c32..5281685f6ad1 100644
> > --- a/arch/sh/kernel/ptrace_32.c
> > +++ b/arch/sh/kernel/ptrace_32.c
> > @@ -455,16 +455,11 @@ long arch_ptrace(struct task_struct *child, long request,
> >  
> >  asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
> >  {
> > -	long ret = 0;
> > -
> >  	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
> > -	    tracehook_report_syscall_entry(regs))
> > -		/*
> > -		 * Tracing decided this syscall should not happen.
> > -		 * We'll return a bogus call number to get an ENOSYS
> > -		 * error, but leave the original number in regs->regs[0].
> > -		 */
> > -		ret = -1L;
> > +	    tracehook_report_syscall_entry(regs)) {
> > +		regs->regs[0] = -ENOSYS;
> > +		return -1;
> > +	}
> >  
> >  	if (secure_computing() == -1)
> >  		return -1;
> > @@ -475,7 +470,7 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
> >  	audit_syscall_entry(regs->regs[3], regs->regs[4], regs->regs[5],
> >  			    regs->regs[6], regs->regs[7]);
> >  
> > -	return ret ?: regs->regs[0];
> > +	return 0;
> >  }
> >  
> >  asmlinkage void do_syscall_trace_leave(struct pt_regs *regs)
> > 
> 
> I can confirm that this patch fixes both strace for me and does not break libseccomp,
> I have run the libseccomp testsuite with my patch for SuperH support applied on top
> of a rebased libseccomp with the 32-bit fixes. Attaching the testsuite log.
> 
> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Great! Thanks!

Rich
