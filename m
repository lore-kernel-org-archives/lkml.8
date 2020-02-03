Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D58C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C16C2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580750990;
	bh=Uspm0bN82l4q/CZvMckAs1J5CnCFjKdej6OTbP0zbts=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ErkhpDkCQjfHBXFw3hrHy9paZhJfUxn44zn9tZYSsk4q5aCJFRKeGTCYzrPANV28o
	 NPTYbhWNvevGKRyykWrsUzsDml4DvLLSBXQcjEYz6bF0GSUAO8WMbxocw8RyLqz3Vr
	 wSDxDMotLKP2ajUnL9mHNaltyjVwImch4aZSpYsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgBCR3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 12:29:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:50230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727150AbgBCR3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 12:29:48 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 099252051A;
        Mon,  3 Feb 2020 17:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580750988;
        bh=Uspm0bN82l4q/CZvMckAs1J5CnCFjKdej6OTbP0zbts=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fbpMA9Nue+S3d9Ba/+scCcAj5pEpzNJwzr+RoQG2ur7DAvrDIdKCpOhxRU+hQZYUC
         aV5AYwSZ4M6Ypu5+tWqcOroXtYm8UP+gMi2yeRxmSBROrRqE8/Je+LMabuDFdewu+n
         0HOCgBhB301RSRj/8I65l4ivCTXPJbCvxCiy/Q7Y=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D7BCB3522718; Mon,  3 Feb 2020 09:29:47 -0800 (PST)
Date:   Mon, 3 Feb 2020 09:29:47 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        'Eric Dumazet' <edumazet@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>
Subject: Re: Confused about hlist_unhashed_lockless()
Message-ID: <20200203172947.GM2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200131164308.GA5175@willie-the-truck>
 <CANn89i+CnezK81gZSLOy0w7MaZy0uT=xyxoKSTyZU3aMpzifOA@mail.gmail.com>
 <20200131184322.GA11457@worktop.programming.kicks-ass.net>
 <CANn89iLBL1qbrEucm2FU02oNbf=x3_4K93TmZ3yS2ZNWm8Qrsg@mail.gmail.com>
 <CANn89i+pExLRqJxbamGv=uDi2kWY-1CKsh1DcAgfdh9DjpQx3A@mail.gmail.com>
 <26258e70c35e4c108173a27317e64a0b@AcuMS.aculab.com>
 <20200203155839.GK2935@paulmck-ThinkPad-P72>
 <20200203160227.GA7274@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203160227.GA7274@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 04:02:28PM +0000, Will Deacon wrote:
> On Mon, Feb 03, 2020 at 07:58:39AM -0800, Paul E. McKenney wrote:
> > On Mon, Feb 03, 2020 at 03:45:54PM +0000, David Laight wrote:
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
> > No, because you use data_race() when there really are data races, but you
> > want KCSAN to ignore them.  For example, diagnostic code that doesn't
> > participate in the actual concurrency design and that doesn't run all
> > that often might use data_race().  For another example, if a developer
> > knew that data races existed, but that the compiler could not reasonably
> > do anything untoward with those data races, that developer might well
> > choose to use data_race() instead of READ_ONCE().  Especially if the
> > access in question was on a fastpath where helpful compiler optimizations
> > would be prohibited by use of READ_ONCE().
> 
> Yes, and in this particular case I think we can remove some WRITE_ONCE()s
> from the non-RCU hlist code too (similarly for hlist_nulls).

Quite possibly, but we should take them case by case.  READ_ONCE()
really does protect against some optimizations, while data_race() does
not at all.

But yes, in some cases you want to -avoid- using READ_ONCE() and
WRITE_ONCE() so that KCSAN can do its job.  For example, given a per-CPU
variable that is only supposed to be accessed from the corresponding CPU
except for reads by diagnostic code, you should have the main algorithm
use plain C-language reads and writes, and have the diagnostic code
use data_race().  This allows KCSAN to correctly flag bugs that access
this per-CPU variable off-CPU while leaving the diagnostic code alone.

Seem reasonable?

							Thanx, Paul
