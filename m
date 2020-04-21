Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A62C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7113206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587475161;
	bh=zUU5C4PlFIXHSx5tbV3MEWj5AqS2eNayRxU3vyvHeEw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=1gG6lL3l4lUAZ8/KUJNEOazTXPpbT+iK5oDRkmL+7P07xl+s08aY9c0fdgzglkniX
	 apFCaGRVwRFS5Ug4Bpje8Jm5HOV+4rRcvJiYG4WByQHmthIkNhFlcYN4Od0gpClIUd
	 998gtaxZAgE9ije0pgqKznJ6qpZzfUyXsQifDcyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgDUNTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:19:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgDUNTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:19:20 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A802F20679;
        Tue, 21 Apr 2020 13:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587475159;
        bh=zUU5C4PlFIXHSx5tbV3MEWj5AqS2eNayRxU3vyvHeEw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=zvYjOhkalKeSPjC86A99nVnEqG+8uyzNbBUIHyyWdeKMtDp0CkW9ZVF0X1LN55Aww
         qp5tkopu8IlJCbMhGW06tuLPF1mt/5UNX65RENYNtISj2HWzxLP3lp6A7m8Fq4YSbN
         +o91r6CkCp6op8e585fB+SwTqhRs+O0aeRMwWApk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7617D35226BE; Tue, 21 Apr 2020 06:19:19 -0700 (PDT)
Date:   Tue, 21 Apr 2020 06:19:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Petko Manolov <petko.manolov@konsulko.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] WRITE_ONCE_INC() and friends
Message-ID: <20200421131919.GM17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200419094439.GA32841@carbon>
 <491f0b0bc9e4419d93a78974fd7f44c7@AcuMS.aculab.com>
 <20200419182957.GA36919@carbon>
 <8e5a0283ed76465aac19a2b97a27ff15@AcuMS.aculab.com>
 <20200420150545.GB17661@paulmck-ThinkPad-P72>
 <20200420225715.GA176156@google.com>
 <20200420231244.GK17661@paulmck-ThinkPad-P72>
 <CANpmjNOfXNE-Zh3MNP=-gmnhvKbsfUfTtWkyg_=VqTxS4nnptQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOfXNE-Zh3MNP=-gmnhvKbsfUfTtWkyg_=VqTxS4nnptQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 11:33:57AM +0200, Marco Elver wrote:
> On Tue, 21 Apr 2020 at 01:12, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Tue, Apr 21, 2020 at 12:57:15AM +0200, Marco Elver wrote:
> > > On Mon, 20 Apr 2020, Paul E. McKenney wrote:
> > >
> > > > On Sun, Apr 19, 2020 at 09:37:10PM +0000, David Laight wrote:
> > > > > From: Petko Manolov
> > > > > > Sent: 19 April 2020 19:30
> > > > > >
> > > > > > On 20-04-19 18:02:50, David Laight wrote:
> > > > > > > From: Petko Manolov
> > > > > > > > Sent: 19 April 2020 10:45
> > > > > > > > Recently I started reading up on KCSAN and at some point I ran into stuff like:
> > > > > > > >
> > > > > > > > WRITE_ONCE(ssp->srcu_lock_nesting[idx], ssp->srcu_lock_nesting[idx] + 1);
> > > > > > > > WRITE_ONCE(p->mm->numa_scan_seq, READ_ONCE(p->mm->numa_scan_seq) + 1);
> > > > > > >
> > > > > > > If all the accesses use READ/WRITE_ONCE() why not just mark the structure
> > > > > > > field 'volatile'?
> > > > > >
> > > > > > This is a bit heavy.  I guess you've read this one:
> > > > > >
> > > > > >         https://lwn.net/Articles/233479/
> > > > >
> > > > > I remember reading something similar before.
> > > > > I also remember a very old gcc (2.95?) that did a readback
> > > > > after every volatile write on sparc (to flush the store buffer).
> > > > > That broke everything.
> > > > >
> > > > > I suspect there is a lot more code that is attempting to be lockless
> > > > > these days.
> > > > > Ring buffers (one writer and one reader) are a typical example where
> > > > > you don't need locks but do need to use a consistent value.
> > > > >
> > > > > Now you may also need ordering between accesses - which I think needs
> > > > > more than volatile.
> > > >
> > > > In Petko's patch, all needed ordering is supplied by the fact that it
> > > > is the same variable being read and written.  But yes, in many other
> > > > cases, more ordering is required.
> > > >
> > > > > > And no, i am not sure all accesses are through READ/WRITE_ONCE().  If, for
> > > > > > example, all others are from withing spin_lock/unlock pairs then we _may_ not
> > > > > > need READ/WRITE_ONCE().
> > > > >
> > > > > The cost of volatile accesses is probably minimal unless the
> > > > > code is written assuming the compiler will only access things once.
> > > >
> > > > And there are variables marked as volatile, for example, jiffies.
> > > >
> > > > But one downside of declaring variables volatile is that it can prevent
> > > > KCSAN from spotting violations of the concurrency design for those
> > > > variables.
> > >
> > > Note that, KCSAN currently treats volatiles not as special, except a
> > > list of some known global volatiles (like jiffies). This means, that
> > > KCSAN will tell us about data races involving unmarked volatiles (unless
> > > they're in the list).
> > >
> > > As far as I can tell, this is what we want. At least according to LKMM.
> > >
> > > If, for whatever reason, volatiles should be treated differently, we'll
> > > have to modify the compilers to emit different instrumentation for the
> > > kernel.
> >
> > I stand corrected, then, thank you!
> >
> > In the current arrangement, declaring a variable volatile will cause
> > KCSAN to generate lots of false positives.
> >
> > I don't currently have a strong feeling on changing the current situation
> > with respect to volatile variables.  Is there a strong reason to change?
> > The general view of the community, as you say, has been that you don't use
> > the volatile keyword outside of exceptions such as jiffies, atomic_read(),
> > atomic_set(), READ_ONCE(), WRITE_ONCE() and perhaps a few others.
> >
> > Thoughts?
> 
> I certainly agree, and also want to point out that checkpatch.pl
> complains about volatile. We know using volatile has problems. KCSAN
> is (along with checkpatch.pl) another tool that can warn us about such
> problems (warning in case there is real concurrency). Another thing to
> point out is that volatile is not portable, in case
> READ_ONCE()/WRITE_ONCE()'s smp_load_barrier_depends() is not a noop.
> So from what I see, there are strong reasons against changing the
> situation for volatiles and KCSAN.

All good points, thank you!

							Thanx, Paul
