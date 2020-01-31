Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78FCC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 17:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6972082E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 17:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580491265;
	bh=8igFNYqYVgzz8ufkSfnU3Ql7xpwSAK1V0KyAZMEOiSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dHNpzhPmts8VhrwQk6eQi/Rxxo1fyWxgtC1FgKxGQu7zHDQeLgU7DiX1cHIPMAHfL
	 dfikEm5cI+/Iu/HACD7dKURsysVLwqbPdhVNWxGsqMMTDkvBwkNQLlszJSEa6M0zjJ
	 v/UnR/0FI9WiaQtJVyhw77+7YDPE0KyELpyArVDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgAaRVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 12:21:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:44026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgAaRVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 12:21:04 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F17EC206D5;
        Fri, 31 Jan 2020 17:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580491263;
        bh=8igFNYqYVgzz8ufkSfnU3Ql7xpwSAK1V0KyAZMEOiSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zghBy1Lzh7+sMfv0GK3+2FqtKUKrvPcYIx7m30xVHsXD4TsCGzHkgDhv5VG5XSV9K
         wDKxmPvlmYehJxauRZPj2dBOx+1LTB8uRC4FPMotz0pddLu4zfb0yHx7NpiPurvRom
         pd2eOM1EePnA9WrOZQ6hYZtclmqrNW9ec8hnj1D0=
Date:   Fri, 31 Jan 2020 17:20:58 +0000
From:   Will Deacon <will@kernel.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Confused about hlist_unhashed_lockless()
Message-ID: <20200131172058.GB5517@willie-the-truck>
References: <20200131164308.GA5175@willie-the-truck>
 <CANn89i+CnezK81gZSLOy0w7MaZy0uT=xyxoKSTyZU3aMpzifOA@mail.gmail.com>
 <20200131165718.GA5517@willie-the-truck>
 <CANn89iKmSBPKJGw--WaJJhCdu2wz2aq-ve+E8z=gfsYj6Zom_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iKmSBPKJGw--WaJJhCdu2wz2aq-ve+E8z=gfsYj6Zom_A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 09:06:27AM -0800, Eric Dumazet wrote:
> On Fri, Jan 31, 2020 at 8:57 AM Will Deacon <will@kernel.org> wrote:
> > On Fri, Jan 31, 2020 at 08:48:05AM -0800, Eric Dumazet wrote:
> > > On Fri, Jan 31, 2020 at 8:43 AM Will Deacon <will@kernel.org> wrote:
> > > > Then running these two concurrently on the same node means that
> > > > hlist_unhashed_lockless() doesn't really tell you anything about whether
> > > > or not the node is reachable in the list (i.e. there is another node
> > > > with a next pointer pointing to it). In other words, I think all of
> > > > these outcomes are permitted:
> > > >
> > > >         hlist_unhashed_lockless(n)      n reachable in list
> > > >         0                               0 (No reordering)
> > > >         0                               1 (No reordering)
> > > >         1                               0 (No reordering)
> > > >         1                               1 (Reorder first and last WRITE_ONCEs)
> > > >
> > > > So I must be missing some details about the use-case here. Please could
> > > > you enlighten me? The RCU implementation permits only the first three
> > > > outcomes afaict, why not use that and leave non-RCU hlist as it was?
> > > >
> > >
> > > I guess the following has been lost :
> >
> > Thanks, although...
> >
> > > Author: Eric Dumazet <edumazet@google.com>
> > > Date:   Thu Nov 7 11:23:14 2019 -0800
> > >
> > >     timer: use hlist_unhashed_lockless() in timer_pending()
> > >
> > >     timer_pending() is mostly used in lockless contexts.
> >
> > ... my point above still stands: the value returned by
> > hlist_unhashed_lockless() doesn't tell you anything about whether or
> > not the timer is reachable in the hlist or not. The comment above
> > timer_pending() also states that:
> >
> >   | Callers must ensure serialization wrt. other operations done to
> >   | this timer, e.g. interrupt contexts, or other CPUs on SMP.
> >
> > If that is intended to preclude list operations, shouldn't we use an
> > RCU hlist instead of throwing {READ,WRITE}_ONCE() at the problem to
> > shut the sanitiser up without actually fixing anything? :(
> 
> 
> Sorry, but timer_pending() requires no serialization.

Then we should update the comment!

Without serialisation, timer_pending() as currently implemented does
not reliably tell you whether the timer is in the hlist. Is that not a
problem? Using an RCU hlist does not introduce serialisation, but does
at least rule out the case where timer_pending() returns false for a
timer that /is/ reachable in the list by another CPU.

> The only thing we need is a READ_ONCE() so that compiler is not allowed
> to optimize out stuff like
> 
> loop() {
>    if (timer_pending())
>       something;

If that was the case, then you wouldn't need to touch hlist_add_before()
at all so there's got to be more to it than that or we can revert that
part of the patch.

Will
