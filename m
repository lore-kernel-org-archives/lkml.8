Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A49BC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 12:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06E1B20890
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 12:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593866042;
	bh=R0N+/b+GLnsuLlGokjE50WQbtJMBRH8i5Dma5A5moiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bEu4AosXgQFkEx/WruY7puQD139spLpwj6CBCovexHBPV/EchSbgqNvemE6QQxdVC
	 FsTHcg9xoX62eOiIeWu8Y2ypwHMWdOXCtBNK6ugo0kp7zHs1srl591XTjGLiX+KxH5
	 8HCaYi8PiD9tN4qc1PwlRU70zaVIeW4hYheUQp7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgGDMeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 08:34:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgGDMeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 08:34:00 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9C792075D;
        Sat,  4 Jul 2020 12:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593866039;
        bh=R0N+/b+GLnsuLlGokjE50WQbtJMBRH8i5Dma5A5moiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KMJT6eztv2+4Bi8mLV1Wrk3Bn1ZX/suV/nq0Xzt19Pu57zZuAgCFHWHE3hNh637eQ
         UYzfcSmeJhpeqqI1+lmDN8SsxXqoxHZdkcnHCHeMbK4g0M6xIFoh/1GaBjzAepGnnX
         SMlLna9iEiMY4XPY/U5ECZFsz9QeDIQwuesbb5Aw=
Date:   Sat, 4 Jul 2020 13:33:56 +0100
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Keno Fischer <keno@juliacomputing.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: ptrace: seccomp: Return value when the call was already invalid
Message-ID: <20200704123355.GA21185@willie-the-truck>
References: <CABV8kRxA9mXPZwtYrjbAfOfFewhABHddipccgk-LQJO+ZYu4Xg@mail.gmail.com>
 <20200703083914.GA18516@willie-the-truck>
 <202007030815.744AAB35D@keescook>
 <20200703154426.GA19406@willie-the-truck>
 <202007030851.D11F1EFA@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007030851.D11F1EFA@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 08:52:05AM -0700, Kees Cook wrote:
> On Fri, Jul 03, 2020 at 04:44:27PM +0100, Will Deacon wrote:
> > On Fri, Jul 03, 2020 at 08:17:19AM -0700, Kees Cook wrote:
> > > On Fri, Jul 03, 2020 at 09:39:14AM +0100, Will Deacon wrote:
> > > > diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> > > > index 5f5b868292f5..a13661f44818 100644
> > > > --- a/arch/arm64/kernel/syscall.c
> > > > +++ b/arch/arm64/kernel/syscall.c
> > > > @@ -121,12 +121,10 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
> > > >  	user_exit();
> > > >  
> > > >  	if (has_syscall_work(flags)) {
> > > > -		/* set default errno for user-issued syscall(-1) */
> > > > -		if (scno == NO_SYSCALL)
> > > > -			regs->regs[0] = -ENOSYS;
> > > > -		scno = syscall_trace_enter(regs);
> > > > -		if (scno == NO_SYSCALL)
> > > > +		if (syscall_trace_enter(regs))
> > > >  			goto trace_exit;
> > > > +
> > > > +		scno = regs->syscallno;
> > > >  	}
> > > >  
> > > >  	invoke_syscall(regs, scno, sc_nr, syscall_table);
> > > 
> > > What effect do either of these patches have on the existing seccomp
> > > selftests: tools/testing/selftests/seccomp/seccomp_bpf ?
> > 
> > Tests! Thanks, I'll have a look.
> 
> Thanks!
> 
> (And either way, that this behavioral difference went unnoticed means we
> need to add a test to the selftests for this patch.)

Unsurprisingly, I don't think the tests go near this. I get 75/77 passes
on arm64 defconfig with or without these changes.

We could add a test, but then we'd have to agree on what it's supposed to
be doing ;)

Will
