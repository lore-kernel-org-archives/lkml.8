Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C88EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4307D2078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594384980;
	bh=xRBtzclHlMuakub8GY8QxjRYcXXc0+XpksOWyODqDVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P/9UcknMwN3nhqg7wjxN+cuSdjfnFpb8PJOEaJrx7DbGQ/9XPD1hh28WCLRTkAs3W
	 8/K2CCMZzOCIoGZwwM2bXKNcJBXDPNydXXfuJxrEnK5MI4ePDEW3b8ZpYGvICvpZYL
	 xoWdG3dhI75jnfPSRsN4Xv2GSIGgm9nNXVAbnNdo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgGJMm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:42:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgGJMm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:42:58 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0053420772;
        Fri, 10 Jul 2020 12:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594384978;
        bh=xRBtzclHlMuakub8GY8QxjRYcXXc0+XpksOWyODqDVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g9TPmzN1z6IrexQ84CPBYnNFt6sF+IyyWq4/DpzSu7Iqos/jXzh+ld+I67sPG/TCh
         hIpdCWv1RAJblEeF7FdjeCnnj+jUvQK3oVnO3oEwCnGBlE3N0vtW/TARSjjqKqbW6H
         YuGUDYZbYf0qzjxfoVljEGxjWtOp32tjL0LMXdHI=
Date:   Fri, 10 Jul 2020 13:42:54 +0100
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Keno Fischer <keno@juliacomputing.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: ptrace: seccomp: Return value when the call was already invalid
Message-ID: <20200710124253.GB30458@willie-the-truck>
References: <CABV8kRxA9mXPZwtYrjbAfOfFewhABHddipccgk-LQJO+ZYu4Xg@mail.gmail.com>
 <20200703083914.GA18516@willie-the-truck>
 <202007030815.744AAB35D@keescook>
 <20200703154426.GA19406@willie-the-truck>
 <202007030851.D11F1EFA@keescook>
 <20200704123355.GA21185@willie-the-truck>
 <202007042132.DAFA2C2@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007042132.DAFA2C2@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 04, 2020 at 09:56:50PM -0700, Kees Cook wrote:
> On Sat, Jul 04, 2020 at 01:33:56PM +0100, Will Deacon wrote:
> > On Fri, Jul 03, 2020 at 08:52:05AM -0700, Kees Cook wrote:
> > > On Fri, Jul 03, 2020 at 04:44:27PM +0100, Will Deacon wrote:
> > > > On Fri, Jul 03, 2020 at 08:17:19AM -0700, Kees Cook wrote:
> > > > > On Fri, Jul 03, 2020 at 09:39:14AM +0100, Will Deacon wrote:
> > > > > > diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> > > > > > index 5f5b868292f5..a13661f44818 100644
> > > > > > --- a/arch/arm64/kernel/syscall.c
> > > > > > +++ b/arch/arm64/kernel/syscall.c
> > > > > > @@ -121,12 +121,10 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
> > > > > >  	user_exit();
> > > > > >  
> > > > > >  	if (has_syscall_work(flags)) {
> > > > > > -		/* set default errno for user-issued syscall(-1) */
> > > > > > -		if (scno == NO_SYSCALL)
> > > > > > -			regs->regs[0] = -ENOSYS;
> > > > > > -		scno = syscall_trace_enter(regs);
> > > > > > -		if (scno == NO_SYSCALL)
> > > > > > +		if (syscall_trace_enter(regs))
> > > > > >  			goto trace_exit;
> > > > > > +
> > > > > > +		scno = regs->syscallno;
> > > > > >  	}
> > > > > >  
> > > > > >  	invoke_syscall(regs, scno, sc_nr, syscall_table);
> > > > > 
> > > > > What effect do either of these patches have on the existing seccomp
> > > > > selftests: tools/testing/selftests/seccomp/seccomp_bpf ?
> > > > 
> > > > Tests! Thanks, I'll have a look.
> > > 
> > > Thanks!
> > > 
> > > (And either way, that this behavioral difference went unnoticed means we
> > > need to add a test to the selftests for this patch.)
> > 
> > Unsurprisingly, I don't think the tests go near this. I get 75/77 passes
> > on arm64 defconfig with or without these changes.
> 
> (What doesn't pass for you? I tried to go find kernelci.org test output,
> but it doesn't appear to actually run selftests yet?)

Sorry, realised I forgot to reply to this point. I was seeing assertion
failures in 'global.user_notification_with_tsync' and
'user_notification_sibling_pid_ns'. I started looking into the first one,
saw an -EACCESS kicking around, re-ran the tests as root and now they all
pass.

Are they expected to pass as a normal user?

Will
