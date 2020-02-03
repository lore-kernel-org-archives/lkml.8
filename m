Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D131C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2260024688
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580750756;
	bh=U+WFdDMs2py+jrUgPw25TAgQh0Oc93Yfllr/9P1q1zw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=B/qVECNrNxGNuWDjrrnV99rAHPIu+S9C3H0AgZMUb7tHFQPFV0MwUgoUVtwxFeUzp
	 yPuyHpJ4DatkAw6Xn6odeD2NSTuZMWa3WHxSzghlH6myjbdRcsh/akMNz6NuJKn1VZ
	 Sf8rLSfI/guP/rMz7VSUgF0lDnK3mcsSRPXPaJrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgBCRZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 12:25:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:48106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727150AbgBCRZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 12:25:55 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3839F21D7E;
        Mon,  3 Feb 2020 17:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580750754;
        bh=U+WFdDMs2py+jrUgPw25TAgQh0Oc93Yfllr/9P1q1zw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ox6TelB70UeTlYdxY9Fp+JnDQczAzGzoRebrj0xmq/1MDdHIlSeZ5I5X+OpvvRuAU
         p3/Kc94bDNvU3RcYBaDCRm+gHpLaVC3A8Tklwn8R7Re2Tl4oUsvILslUOWwmvW52DI
         9uTvwy3UwgEFmRjtbAzk3ecodIfQWgnpHd6+UfUQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0B1EE3522718; Mon,  3 Feb 2020 09:25:54 -0800 (PST)
Date:   Mon, 3 Feb 2020 09:25:54 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Marco Elver' <elver@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Confused about hlist_unhashed_lockless()
Message-ID: <20200203172554.GL2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200131164308.GA5175@willie-the-truck>
 <CANn89i+CnezK81gZSLOy0w7MaZy0uT=xyxoKSTyZU3aMpzifOA@mail.gmail.com>
 <20200131184322.GA11457@worktop.programming.kicks-ass.net>
 <CANn89iLBL1qbrEucm2FU02oNbf=x3_4K93TmZ3yS2ZNWm8Qrsg@mail.gmail.com>
 <CANn89i+pExLRqJxbamGv=uDi2kWY-1CKsh1DcAgfdh9DjpQx3A@mail.gmail.com>
 <26258e70c35e4c108173a27317e64a0b@AcuMS.aculab.com>
 <CANpmjNNVstV4AJHtf0aht1xyj+_a-Kj4so4Mi1DpOWDPYN=-2Q@mail.gmail.com>
 <154c51cc385544789c9fa0b233fc76e7@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154c51cc385544789c9fa0b233fc76e7@AcuMS.aculab.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 04:05:25PM +0000, David Laight wrote:
> From: Marco Elver
> > Sent: 03 February 2020 15:55
> > 
> > On Mon, 3 Feb 2020 at 16:45, David Laight <David.Laight@aculab.com> wrote:
> > >
> > > From: Eric Dumazet
> > > > Sent: 31 January 2020 18:53
> > > >
> > > > On Fri, Jan 31, 2020 at 10:48 AM Eric Dumazet <edumazet@google.com> wrote:
> > > > >
> > > >
> > > > > This is nice, now with have data_race()
> > > > >
> > > > > Remember these patches were sent 2 months ago, at a time we were
> > > > > trying to sort out things.
> > > > >
> > > > > data_race() was merged a few days ago.
> > > >
> > > > Well, actually data_race() is not there yet anyway.
> > >
> > > Shouldn't it be NO_DATA_RACE() ??
> > 
> > Various options were considered, and based on feedback from Linus,
> > decided 'data_race(..)' is the best option:
> >   https://lore.kernel.org/linux-fsdevel/CAHk-
> > =wg5CkOEF8DTez1Qu0XTEFw_oHhxN98bDnFqbY7HL5AB2g@mail.gmail.com/
> > 
> > It's meant to be as unobtrusive as possible, and an all-caps macro was
> > ruled out.
> 
> Except that it then looks like something that actually does something.
> 
> > Second, the "NO_" prefix would be incorrect, since it'd be the
> > opposite of what it is. The macro is meant to document and mark a
> > deliberate data race.
> 
> It should be IGNORE_DATA_RACE() then.

People will get used to the name more quickly than they will get used
to typing the extra seven characters.  Here is the current comment header:

/*
 * data_race(): macro to document that accesses in an expression may conflict with
 * other concurrent accesses resulting in data races, but the resulting
 * behaviour is deemed safe regardless.
 *
 * This macro *does not* affect normal code generation, but is a hint to tooling
 * that data races here should be ignored.
 */

I will be converting this to docbook form.

In addition, in the KCSAN documentation:

* KCSAN understands the ``data_race(expr)`` annotation, which tells KCSAN that
  any data races due to accesses in ``expr`` should be ignored and resulting
  behaviour when encountering a data race is deemed safe.

Fair enough?

								Thanx, Paul
