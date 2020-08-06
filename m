Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6539CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB1B6206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596735294;
	bh=23MTobahm6zRo96g4niRECq1POSsRjhUXkwdXYkgfjE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=a0v5zMjRWs6mN98M50zDXabhkH2YmIh8+M+9W5y2ckTiCuZMgBm4KcNb/P4R7DJ+5
	 pZcj58g2dqBieHqz5PMfAoVP30xhtJSBWvfw69spaPmFpOVs3D8C4H1n+8fvd65KXz
	 LlEGnapljF3ris819TrxZEZgL5Wn/7btHllpiDOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbgHFRet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:34:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729912AbgHFRbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:31:44 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5477A2310A;
        Thu,  6 Aug 2020 13:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596720958;
        bh=23MTobahm6zRo96g4niRECq1POSsRjhUXkwdXYkgfjE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bwBKTPBBDUebSZYsN/topApvDhzzAoDT1MUI8MaAw3kV7RS2yGqCtCp2rfPmRZHQs
         MMj9PMIsh5TgQAgrpJq/eIU+RV1O8/SRPAgeBDFDuVVlnHfo25Z8T0EEX7DDD7EX/G
         rLndR9ICy5zRt/UtWNAyD0A9f0oyUmZATeAEhKDA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F1BA135206C1; Thu,  6 Aug 2020 06:35:57 -0700 (PDT)
Date:   Thu, 6 Aug 2020 06:35:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Marco Elver <elver@google.com>, Kostya Serebryany <kcc@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        'Dmitry Vyukov' via syzkaller-upstream-moderation 
        <syzkaller-upstream-moderation@googlegroups.com>,
        Jann Horn <jannh@google.com>
Subject: Re: Finally starting on short RCU grace periods, but...
Message-ID: <20200806133557.GM4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200805230852.GA28727@paulmck-ThinkPad-P72>
 <CANpmjNPxzOFC+VQujipFaPmAV8evU2LnB4X-iXuHah45o-7pfw@mail.gmail.com>
 <CACT4Y+Ye7j-scb-thp2ubORCoEnuJPHL7W6Wh_DLP_4cux-0SQ@mail.gmail.com>
 <CACT4Y+aF=Y-b7Lm7+UAD7Zb1kS1uWF+G_3yBbXsY6YO3k2dBuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aF=Y-b7Lm7+UAD7Zb1kS1uWF+G_3yBbXsY6YO3k2dBuw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 03:25:57PM +0200, Dmitry Vyukov wrote:
> On Thu, Aug 6, 2020 at 3:22 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Thu, Aug 6, 2020 at 12:31 PM Marco Elver <elver@google.com> wrote:
> > >
> > > +Cc kasan-dev

Thank you!

> > > On Thu, 6 Aug 2020 at 01:08, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > Hello!
> > > >
> > > > If I remember correctly, one of you asked for a way to shorten RCU
> > > > grace periods so that KASAN would have a better chance of detecting bugs
> > > > such as pointers being leaked out of RCU read-side critical sections.
> > > > I am finally starting entering and testing code for this, but realized
> > > > that I had forgotten a couple of things:
> > > >
> > > > 1.      I don't remember exactly who asked, but I suspect that it was
> > > >         Kostya.  I am using his Reported-by as a placeholder for the
> > > >         moment, but please let me know if this should be adjusted.
> > >
> > > It certainly was not me.
> > >
> > > > 2.      Although this work is necessary to detect situtions where
> > > >         call_rcu() is used to initiate a grace period, there already
> > > >         exists a way to make short grace periods that are initiated by
> > > >         synchronize_rcu(), namely, the rcupdate.rcu_expedited kernel
> > > >         boot parameter.  This will cause all calls to synchronize_rcu()
> > > >         to act like synchronize_rcu_expedited(), resulting in about 2-3
> > > >         orders of magnitude reduction in grace-period latency on small
> > > >         systems (say 16 CPUs).
> > > >
> > > > In addition, I plan to make a few other adjustments that will
> > > > increase the probability of KASAN spotting a pointer leak even in the
> > > > rcupdate.rcu_expedited case.
> > >
> > > Thank you, that'll be useful I think.
> > >
> > > > But if you would like to start this sort of testing on current mainline,
> > > > rcupdate.rcu_expedited is your friend!
> >
> > Hi Paul,
> >
> > This is great!
> >
> > I understand it's not a sufficiently challenging way of tracking
> > things, but it's simply here ;)
> > https://bugzilla.kernel.org/show_bug.cgi?id=208299
> > (now we also know who asked for this, +Jann)

Thank you, and I will update the Reported-by lines accordingly.

> > I've tested on the latest mainline and with rcupdate.rcu_expedited=1
> > it boots to ssh successfully and I see:
> > [    0.369258][    T0] All grace periods are expedited (rcu_expedited).
> >
> > I have created https://github.com/google/syzkaller/pull/2021 to enable
> > it on syzbot.
> > On syzbot we generally use only 2-4 CPUs per VM, so it should be even better.

Sounds good, and perhaps this will answer Marco's question below.  ;-)

> > > Do any of you remember some bugs we missed due to this? Can we find
> > > them if we add this option?
> >
> > The problem is that it's hard to remember bugs that were not caught :)
> > Here is an approximation of UAFs with free in rcu callback:
> > https://groups.google.com/forum/#!searchin/syzkaller-bugs/KASAN$20use-after-free$20rcu_do_batch%7Csort:date
> > The ones with low hit count are the ones that we almost did not catch.
> > That's the best estimation I can think of. Also potentially we can get
> > reproducers for such bugs without reproducers.
> > Maybe we will be able to correlate some bugs/reproducers that appear
> > soon with this change.
> 
> Wait, it was added in 2012?
> https://github.com/torvalds/linux/commit/3705b88db0d7cc4

Indeed it was, which is my current excuse for having failed to immediately
mention it to Jann during our IRC discussion.

The purpose back then was to make battery-powered systems go faster,
I think mostly focused on CPU hotplug operations.  At least that would
explain the commit log being indefinite on the exact benefit.  ;-)

							Thanx, Paul
