Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3811C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 821BC207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgETKFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 06:05:52 -0400
Received: from foss.arm.com ([217.140.110.172]:52018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgETKFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:05:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98C0F31B;
        Wed, 20 May 2020 03:05:51 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 873B53F68F;
        Wed, 20 May 2020 03:05:50 -0700 (PDT)
Date:   Wed, 20 May 2020 11:05:44 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Will Deacon <will@kernel.org>, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        Keno Fischer <keno@juliacomputing.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: Fix PTRACE_SYSEMU semantics
Message-ID: <20200520100543.GA18302@gaia>
References: <20200515222253.GA38408@juliacomputing.com>
 <20200518114119.GB32394@willie-the-truck>
 <20200519120725.GA20313@gaia>
 <20200520100330.GA25430@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520100330.GA25430@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 11:03:30AM +0100, Sudeep Holla wrote:
> On Tue, May 19, 2020 at 01:07:27PM +0100, Catalin Marinas wrote:
> > On Mon, May 18, 2020 at 12:41:20PM +0100, Will Deacon wrote:
> > > On Fri, May 15, 2020 at 06:22:53PM -0400, Keno Fischer wrote:
> > > > Quoth the man page:
> > > > ```
> > > >        If the tracee was restarted by PTRACE_SYSCALL or PTRACE_SYSEMU, the
> > > >        tracee enters syscall-enter-stop just prior to entering any system
> > > >        call (which will not be executed if the restart was using
> > > >        PTRACE_SYSEMU, regardless of any change made to registers at this
> > > >        point or how the tracee is restarted after this stop).
> > > > ```
> > > >
> > > > The parenthetical comment is currently true on x86 and powerpc,
> > > > but not currently true on arm64. arm64 re-checks the _TIF_SYSCALL_EMU
> > > > flag after the syscall entry ptrace stop. However, at this point,
> > > > it reflects which method was used to re-start the syscall
> > > > at the entry stop, rather than the method that was used to reach it.
> > > > Fix that by recording the original flag before performing the ptrace
> > > > stop, bringing the behavior in line with documentation and x86/powerpc.
> > > >
> > > > Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> > > > ---
> > > >  arch/arm64/kernel/ptrace.c | 8 +++++---
> > > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> > > > index b3d3005d9515..b67b4d14aa17 100644
> > > > --- a/arch/arm64/kernel/ptrace.c
> > > > +++ b/arch/arm64/kernel/ptrace.c
> > > > @@ -1829,10 +1829,12 @@ static void tracehook_report_syscall(struct pt_regs *regs,
> > > >
> > > >  int syscall_trace_enter(struct pt_regs *regs)
> > > >  {
> > > > -	if (test_thread_flag(TIF_SYSCALL_TRACE) ||
> > > > -		test_thread_flag(TIF_SYSCALL_EMU)) {
> > > > +	u32 flags = READ_ONCE(current_thread_info()->flags) &
> > > > +		(_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE);
> > > > +
> > > > +	if (flags) {
> > >
> > > nit: but I'd rather the '&' operation was in the conditional so that the
> > > 'flags' variable holds all of the flags.
> > >
> > > With that:
> > >
> > > Acked-by: Will Deacon <will@kernel.org>
> > >
> > > Also needs:
> > >
> > > Cc: <stable@vger.kernel.org>
> > > Fixes: f086f67485c5 ("arm64: ptrace: add support for syscall emulation")
> > >
> > > Catalin -- can you pick this up for 5.7 please, with my 'nit' addressed?
> >
> > I'll queue it with the above addressed. I think flags also needs to be
> > unsigned long rather than u32.
> >
> > However, before sending the pull request, I'd like Sudeep to confirm
> > that it doesn't break his original use-case for this feature.
> 
> I just tested it with my simple programs I had before. I have also asked
> teams working on gvisor to test. They have tested it and see no
> regression. I will ask them to reply here.
> 
> Tested-by: Sudeep Holla <sudeep.holla@arm.com>

Thanks Sudeep.

-- 
Catalin
