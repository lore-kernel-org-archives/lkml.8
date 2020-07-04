Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00FDC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 12:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 860E220885
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 12:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593867034;
	bh=4XhuUQN3QNCuKbrbw9fG4qJ8DQkgRuvV3izCuziKVKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LTmP6hLA0OAEe7TqK/GE9+5Uq+snS42n8p96XVsBrZ/fZ7cu+UuI1S7yRsNMFyPve
	 Q0wCs3Cnz/eRRf/mBLx9MZ+pq7K04386m7cLThZ6Tnt4DyGBKFedfM6tHTdA0CCTEl
	 pVFL67OZsV9pZ0nYPRpEB8/Ylb0WTr/rU74FCuBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgGDMud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 08:50:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgGDMuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 08:50:32 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B57B520885;
        Sat,  4 Jul 2020 12:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593867031;
        bh=4XhuUQN3QNCuKbrbw9fG4qJ8DQkgRuvV3izCuziKVKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LUGt9Y9D6tcO8lMDE/M9d56KUenZO8441sgpi2TquZUVjP0tEFiaqrdquhx3pPwKq
         K9YMs4T+uMlwEPCsUhuY55oNm/YeoLz3dXPifFGIpXrwY28T7srYgIPli2uXgza+E7
         HCiIt3c2+93EtM+qPAF9IvfUEAtQthLksOjyvUSQ=
Date:   Sat, 4 Jul 2020 13:50:27 +0100
From:   Will Deacon <will@kernel.org>
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: ptrace: seccomp: Return value when the call was already invalid
Message-ID: <20200704125027.GB21185@willie-the-truck>
References: <CABV8kRxA9mXPZwtYrjbAfOfFewhABHddipccgk-LQJO+ZYu4Xg@mail.gmail.com>
 <20200703083914.GA18516@willie-the-truck>
 <CABV8kRwYp9cvu1b4-fhHktyX_r2QiObhadJ4pqscvuLt1BtRvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABV8kRwYp9cvu1b4-fhHktyX_r2QiObhadJ4pqscvuLt1BtRvg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 04:27:37PM -0400, Keno Fischer wrote:
> > > Now, if we have a seccomp filter that simply does
> > > SECCOMP_RET_TRACE, and a ptracer that simply
> > > does PTRACE_CONT
> >
> > Ok, so this means that we're _skipping_ the system call, right?
> 
> If the system call were positive this would result in the system call
> being executed. The notion of "skipping" the syscall is a bit odd in
> this situation. Having the ptracer set the syscallno to -1 is generally
> accepted as the way to do it, but what happens if the syscallno is
> already -1 or negative is underspecified.

Ok. I think it would be sensible for us to have the same behaviour for
all negative system calls though.

> > > then the assert will fire/fail on arm64, but not on x86_64.
> >
> > It feels weird to me that skipping the system call has any effect on the
> > tracee registers...
> 
> I think the correct way to frame it is to ask whether the behavior
> matches that of the tracee in absence of the ptracer. I would argue
> that if the ptracer doesn't explicitly modify register contents, then
> the tracee shouldn't observe any behavior difference.

That's a useful way of thinking about it and is still the case after this
patch. The difference now is that x0 isn't zapped in the case where a
syscall(-1) is skipped.

> > > Interestingly, arm64 does do something different
> > > if the syscall is -1 rather than -10, where early
> > > in the ptrace stop it does.
> > > ```
> > > /* set default errno for user-issued syscall(-1) */
> > > if (scno == NO_SYSCALL)
> > >     regs->regs[0] = -ENOSYS;
> >
> > ... so I think this should be fixed too. How about the diff below?
> 
> I think the patch behavior is better overall, but I'm not sure it's ideal.
> I think the biggest question is what the behavior should be here and
> if we want a behavioral difference between *the syscall was -1 at entry*
> and *the syscall was -1 because the ptracer wanted to skip the syscall*.
> I think there is a bit of a semantic disconnect because "skipping" the
> syscall is not really an operation that the ptracer has at its disposal
> (unless it's using SYSEMU of course). The only thing it can do is set
> the syscall to -1. However, arguably that already has semantics
> (of returning -ENOSYS), so it's not at all clear to me that we should
> deviate from that. Unfortunately, none of this is currently consistent
> across architectures, so I think before we go changing arm64, we
> should decide what we'd like to happen in theory and then see
> what we can do to improve the situation without being too breaking.

I just object to treating a user-issued -1 differently to any other negative
system call. With this patch, they're all treated the same, which is to say
that they return -ENOSYS normally, but when skipped by a tracer (e.g. by
setting the syscall number to -1 or because of a seccomp failure), then
x0 is preserved.

This means that, with this patch, skipping syscall(-1) behaves the same
way as skipping syscall(-2) with mainline today.

Will
