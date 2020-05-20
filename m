Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FE2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E549207F9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgETKfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 06:35:30 -0400
Received: from foss.arm.com ([217.140.110.172]:52642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgETKfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:35:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E02A31B;
        Wed, 20 May 2020 03:35:29 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.169.41.142])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5957E3F68F;
        Wed, 20 May 2020 03:35:27 -0700 (PDT)
From:   Bin Lu <bin.lu@arm.com>
To:     catalin.marinas@arm.com
Cc:     keno@juliacomputing.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        sudeep.holla@arm.com, will@kernel.org, Bin Lu <Bin.Lu@arm.com>
Subject: Re: [PATCH] arm64: Fix PTRACE_SYSEMU semantics
Date:   Wed, 20 May 2020 18:34:20 +0800
Message-Id: <1589970860-62695-1-git-send-email-bin.lu@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20200519120725.GA20313@gaia>
References: <20200519120725.GA20313@gaia>
References: <20200515222253.GA38408@juliacomputing.com> <20200518114119.GB32394@willie-the-truck> <20200519120725.GA20313@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519120725.GA20313@gaia>
X-Mutt-References: <20200519120725.GA20313@gaia>
X-Mutt-Fcc: =ARM/Sent Items
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bin Lu <Bin.Lu@arm.com>

On Tue, May 19, 2020 at 01:07:27PM +0100, Catalin Marinas wrote:
> On Mon, May 18, 2020 at 12:41:20PM +0100, Will Deacon wrote:
> > On Fri, May 15, 2020 at 06:22:53PM -0400, Keno Fischer wrote:
> > > Quoth the man page:
> > > ```
> > >        If the tracee was restarted by PTRACE_SYSCALL or PTRACE_SYSEMU, the
> > >        tracee enters syscall-enter-stop just prior to entering any system
> > >        call (which will not be executed if the restart was using
> > >        PTRACE_SYSEMU, regardless of any change made to registers at this
> > >        point or how the tracee is restarted after this stop).
> > > ```
> > >
> > > The parenthetical comment is currently true on x86 and powerpc,
> > > but not currently true on arm64. arm64 re-checks the _TIF_SYSCALL_EMU
> > > flag after the syscall entry ptrace stop. However, at this point,
> > > it reflects which method was used to re-start the syscall
> > > at the entry stop, rather than the method that was used to reach it.
> > > Fix that by recording the original flag before performing the ptrace
> > > stop, bringing the behavior in line with documentation and x86/powerpc.
> > >
> > > Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> > > ---
> > >  arch/arm64/kernel/ptrace.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> > > index b3d3005d9515..b67b4d14aa17 100644
> > > --- a/arch/arm64/kernel/ptrace.c
> > > +++ b/arch/arm64/kernel/ptrace.c
> > > @@ -1829,10 +1829,12 @@ static void tracehook_report_syscall(struct pt_regs *regs,
> > >
> > >  int syscall_trace_enter(struct pt_regs *regs)
> > >  {
> > > -	if (test_thread_flag(TIF_SYSCALL_TRACE) ||
> > > -		test_thread_flag(TIF_SYSCALL_EMU)) {
> > > +	u32 flags = READ_ONCE(current_thread_info()->flags) &
> > > +		(_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE);
> > > +
> > > +	if (flags) {
> >
> > nit: but I'd rather the '&' operation was in the conditional so that the
> > 'flags' variable holds all of the flags.
> >
> > With that:
> >
> > Acked-by: Will Deacon <will@kernel.org>
> >
> > Also needs:
> >
> > Cc: <stable@vger.kernel.org>
> > Fixes: f086f67485c5 ("arm64: ptrace: add support for syscall emulation")
> >
> > Catalin -- can you pick this up for 5.7 please, with my 'nit' addressed?
>
> I'll queue it with the above addressed. I think flags also needs to be
> unsigned long rather than u32.
>
> However, before sending the pull request, I'd like Sudeep to confirm
> that it doesn't break his original use-case for this feature.
>

Tested-by: Bin Lu <Bin.Lu@arm.com> (for gVisor)

I have just tested all gVisor syscall test cases with ptrace(Regs, FPRegs, TLS)
on Arm64 platform.
The test results are the same as before there was no patch.

My idea is that this kernel patch has no bad effects on gVisor.
Linux Kernel version: 5.7.0-rc6+
gVisor version: release-20200511.0

