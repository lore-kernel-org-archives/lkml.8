Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA109C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB22F2077D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594313132;
	bh=v+cZOYTLs18dLhEf6Q0peEyAKgt/ABxrl/BBbRjNql4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=KTBKZuE+OLAkbuuzgeexLSdFGax3zixQ00UVvLacEPbdlC2BUDXDDffQya+qR1/8F
	 MYcsgF7xy5DLG7wNnq+QjO78b+n9ibjobsbpkrMx0xBurtDZBFK8OLS652yWlPst2F
	 LYSGKAcIj0xWfu9y0IoEvKkthx6vsHx4U1pcgTzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgGIQpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:45:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgGIQpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:45:31 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7281F20720;
        Thu,  9 Jul 2020 16:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594313130;
        bh=v+cZOYTLs18dLhEf6Q0peEyAKgt/ABxrl/BBbRjNql4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FU+gEFLC5uMeI3QhaeEEXMQy8pm4ciMhLVT7p3J6iBQrtxN1fK8VO0I7dtSG+q7Hd
         C4psRR8kP0J69UxCbluXKkah6hYplUh3++E6LJR7A92TugnhXBk65FSKzkmaNJSWUd
         jmKHMleu3X5LBFqHVZCvo/tpe2KYyBWsvEv/xBKQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 619AB3522CE7; Thu,  9 Jul 2020 09:45:30 -0700 (PDT)
Date:   Thu, 9 Jul 2020 09:45:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+0f719294463916a3fc0e@syzkaller.appspotmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: KASAN: stack-out-of-bounds Read in csd_lock_record
Message-ID: <20200709164530.GA9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <00000000000042f21905a991ecea@google.com>
 <20200704164522.GO9247@paulmck-ThinkPad-P72>
 <CACT4Y+Zs4TO9-XSZ7cRXFZVqRakS8WuSno2=dac6Gv2XmExbkA@mail.gmail.com>
 <CACT4Y+aMJRwQANQZ5Fr1RPZ6EOZ2zEPaZwMTndKJ+mTJ8o6b7Q@mail.gmail.com>
 <20200707162610.GY9247@paulmck-ThinkPad-P72>
 <CACT4Y+Z8yErbDWPxv5tX0hnw7cTa6nJjg5f=MWMYS-2X91TZ9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Z8yErbDWPxv5tX0hnw7cTa6nJjg5f=MWMYS-2X91TZ9w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 12:13:44PM +0200, Dmitry Vyukov wrote:
> On Tue, Jul 7, 2020 at 6:26 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Tue, Jul 07, 2020 at 05:51:48PM +0200, Dmitry Vyukov wrote:
> > > On Sat, Jul 4, 2020 at 8:34 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > >
> > > > On Sat, Jul 4, 2020 at 6:45 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > >
> > > > > On Fri, Jul 03, 2020 at 04:31:22PM -0700, syzbot wrote:
> > > > > > Hello,
> > > > > >
> > > > > > syzbot found the following crash on:
> > > > > >
> > > > > > HEAD commit:    9e50b94b Add linux-next specific files for 20200703
> > > > > > git tree:       linux-next
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1024b405100000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=f99cc0faa1476ed6
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=0f719294463916a3fc0e
> > > > > > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16dc490f100000
> > > > > >
> > > > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > > > Reported-by: syzbot+0f719294463916a3fc0e@syzkaller.appspotmail.com
> > > > >
> > > > > Good catch!  A call to csd_lock_record() was on the wrong side of a
> > > > > call to csd_unlock().
> > > >
> > > > Thanks for taking a look.
> > > >
> > > > > But is folded into another commit for bisectability reasons, so
> > > > > "Reported-by" would not make sense.  I have instead added this to the
> > > > > commit log:
> > > > >
> > > > > [ paulmck: Fix for syzbot+0f719294463916a3fc0e@syzkaller.appspotmail.com ]
> > > > > Link: https://lore.kernel.org/lkml/00000000000042f21905a991ecea@google.com
> > > > > Link: https://lore.kernel.org/lkml/0000000000002ef21705a9933cf3@google.com
> > > >
> > > > This should work, as far as I remember sybot looks for the email+hash
> > > > anywhere in the commit.
> > > > FWIW Tested-by can make sense as well.
> > >
> > > Paul, there is also some spike of stalls in smp_call_function,
> > > if you look at the top ones at:
> > > https://syzkaller.appspot.com/upstream#open
> > >
> > > Can these be caused by the same root cause?
> > > I am not sure what trees the bug was/is present... This seems to only
> > > happen on linux-next and nowhere else. But these stalls equally happen
> > > on mainline...
> >
> > I would be surprised, given that the csd_unlock() was before the faulting
> > reference.  But then again, I have been surprised before.
> 
> Yes, it seems unrelated.
> It looks like something broken in the kernel recently and now instead
> of diagnosing a stall on one CPU, it diagnoses it as a stall in
> smp_call_function on another CPU. This produces large number of
> assorted stall reports which are not too actionable...
> 
> 
> > You aren't running scftorture with its longwait parameter set to a
> > non-zero value, are you?  In that case, stalls are expected behavior.
> > This is to support test the CSD lock diagnostics in -rcu.  Which isn't
> > in mainline yet, so maybe I am asking a stupid question.
> 
> Since I don't know what is scftorture/longwait, I guess I am not running it :)
> 
> > If these are repeatable, one thing to try is to build the kernel with
> > CSD_LOCK_WAIT_DEBUG=y.  This requires c6c67d89c059 ("smp: Add source and
> > destination CPUs to __call_single_data") and 216d15e0d870 ("kernel/smp:
> > Provide CSD lock timeout diagnostics") from the -rcu tree's "dev" branch.
> > This will dump out the smp_call_function() function that was to be
> > invoked, on the off-chance that the problem is something like lock
> > contention in that function.
> 
> Here are some with reproducers:
> https://syzkaller.appspot.com/bug?id=8a1e95291152ce5afea43c103a1fd62a257fcf4b
> https://syzkaller.appspot.com/bug?id=5e3ac329b6304aacc6304cfaab1a514bca12ce82
> https://syzkaller.appspot.com/bug?id=a01b4478f89e19cee91531f7c2b7751f0caf8c0c
> https://syzkaller.appspot.com/bug?id=e4caef9fc41d0c019c532a4257faec129699a42e
> 
> But the question is if this CSD_LOCK_WAIT_DEBUG=y is useful in
> general? Should we enable it all the time?

The CSD_LOCK_WAIT_DEBUG functionality is quite new, so it is quite
possible that it is causing rather than detecting problems.  ;-)

But once it is stable, then yes, it might be quite generally useful.

							Thanx, Paul
