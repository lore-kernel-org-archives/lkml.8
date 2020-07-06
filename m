Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD12C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BE4220739
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594023358;
	bh=6YmTM1KwwDkiZJp3aHQpt/yeMmff1B/qvXle8AM26Dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aLg7/ue8EAUpQ+aCNiB8DoyzUulL3O43od1fvJ3rghcN5ew0vhTkK6tJ49FMaQA3t
	 cU0yQtWFW5cdwWJKle0LgHLV2nK3F+aYQghevonz8pk7lzQjKHACeQ8KYHIyOTtBdn
	 c0M4r59/IMHhv+I4X7XUuAsuepKWUl59GX/NU08c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgGFIP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 04:15:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgGFIP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 04:15:56 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB7EC20739;
        Mon,  6 Jul 2020 08:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594023355;
        bh=6YmTM1KwwDkiZJp3aHQpt/yeMmff1B/qvXle8AM26Dg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iWAHvxfF8nbyMfjcdC2lpaaAjlF1hXSXt6DDyrRcFoG7auqNjMWo34j5rj6GU/Zoq
         mwt7c8TF0D6jU2ZdeicAVi4zrlk8MzdOzD84X5ERAFOZ0IBj6YkhzBrJ8G2iBLRRvO
         EXsv1eX2V3Yk3U/BbAp4tjkhZcVbur3yd2gy0qb4=
Date:   Mon, 6 Jul 2020 09:15:51 +0100
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Keno Fischer <keno@juliacomputing.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: ptrace: seccomp: Return value when the call was already invalid
Message-ID: <20200706081550.GA23032@willie-the-truck>
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
> 
> Anyway, good that the test output doesn't change, bad that seccomp has
> missed a corner of this architecture interface. (i.e. the entire
> TRACE_syscall fixture is dedicated to exercising the changing/skipping
> interface, but I see now that it doesn't at all exercise any area of
> ENOSYS results.)
> 
> > We could add a test, but then we'd have to agree on what it's supposed to
> > be doing ;)
> 
> Well, if you look at change_syscall() in seccomp_bpf.c (once you stop
> screaming) you'll likely share my desire to have more things that are
> common across architectures. ;) So, to that end, yes, please, let's
> define what we'd like to see, and then build out the (likely wildly
> different per-architecture expectations). If I read this thread
> correctly, we need to test:
> 
> 	syscall(-1), direct,  returns ENOSYS
> 	syscall(-10), direct, returns ENOSYS
> 	syscall(-1), SECCOMP_RET_TRACE+PTRACE_CONT, returns ENOSYS
> 	syscall(-10), SECCOMP_RET_TRACE+PTRACE_CONT, returns ENOSYS
> 	syscall(-1), ptrace+PTRACE_SYSCALL, returns ENOSYS
> 	syscall(-10), ptrace+PTRACE_SYSCALL, returns ENOSYS
> 
> do we need to double-check that registers before/after are otherwise
> unchanged too? (I *think* just looking at syscall return should be
> sufficient to catch the visible results.)

There's also the case where the tracer sets the system call to -1 to skip
it.

Will
