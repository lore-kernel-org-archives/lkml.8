Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF72FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 21:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF9720705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 21:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580505592;
	bh=lY2Z+X3l1tr6YzzhCrksivm2PIFjGHOfay6vKF4ubtE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=xCGf6v3gaLudViNveAWd/fnOiXdh5OJZ08uBHQjZ9ARYUuznHp5Rx8/L6Qb8XN5YY
	 VgeNyaWnl0xwLus+SCNP0AbQD2Aej52EHTmTVt2unQnQbX8swJ47ES8Cf9KuGYWIg4
	 ZJQQ6G0iiHgZbnQEPXNz+g8sOstHasdGlbtRQ52g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgAaVTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 16:19:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:48064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgAaVTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 16:19:51 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04D6C214D8;
        Fri, 31 Jan 2020 21:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580505591;
        bh=lY2Z+X3l1tr6YzzhCrksivm2PIFjGHOfay6vKF4ubtE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bBbRAl9md3jvxTlEpM1bTIyO8aJ7VEwhzlidAH9RJQq4yLIvktk1rAUP/G6CvSxLd
         LkeTQju7Xo+vaUjf1E0P6sR2n0vF5uStbnBFnWueiqujfAP/mdoTH1FCvWQ8nhY2s/
         eWM7eM7y6Epqs/gwPO1B8vXW/atQHN2vzFi3Q1K4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9CAFC3522722; Fri, 31 Jan 2020 13:19:50 -0800 (PST)
Date:   Fri, 31 Jan 2020 13:19:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>, mingo@kernel.org
Subject: Re: Confused about hlist_unhashed_lockless()
Message-ID: <20200131211950.GX2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200131164308.GA5175@willie-the-truck>
 <CANn89i+CnezK81gZSLOy0w7MaZy0uT=xyxoKSTyZU3aMpzifOA@mail.gmail.com>
 <20200131184322.GA11457@worktop.programming.kicks-ass.net>
 <CANn89iLBL1qbrEucm2FU02oNbf=x3_4K93TmZ3yS2ZNWm8Qrsg@mail.gmail.com>
 <CANn89i+pExLRqJxbamGv=uDi2kWY-1CKsh1DcAgfdh9DjpQx3A@mail.gmail.com>
 <20200131205337.GU2935@paulmck-ThinkPad-P72>
 <CANn89iJzzws6MbbwuwXs+GPHAe3X-jB=JnKLh_6bX76keoKLwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iJzzws6MbbwuwXs+GPHAe3X-jB=JnKLh_6bX76keoKLwA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 01:04:37PM -0800, Eric Dumazet wrote:
> On Fri, Jan 31, 2020 at 12:53 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Jan 31, 2020 at 10:52:46AM -0800, Eric Dumazet wrote:
> > > On Fri, Jan 31, 2020 at 10:48 AM Eric Dumazet <edumazet@google.com> wrote:
> > > >
> > >
> > > > This is nice, now with have data_race()
> > > >
> > > > Remember these patches were sent 2 months ago, at a time we were
> > > > trying to sort out things.
> > > >
> > > > data_race() was merged a few days ago.
> > >
> > > Well, actually data_race() is not there yet anyway.
> > >
> > > Is it really scheduled for 5.7 kernel ?
> >
> > Right now, yes.  Would it make sense to separate it out and push it
> > into the current merge window?
> 
> That would be very nice, because we could start using it before KCSAN is merged.

Seems reasonable to me.  This one is already inn -tip:

c48981eeb0d5 ("include/linux/compiler.h: Introduce data_race(expr) macro")

This is in tip/WIP.locking/kcsan, so I am adding Ingo on CC.

Ingo, how would you like to proceed?  For example, if it would be
helpful, I could rebase that commit on top of rcu/for-mingo and send a
pull request.

							Thanx, Paul
