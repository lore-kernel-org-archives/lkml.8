Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED819C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 20:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D64F4221E3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 20:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596747540;
	bh=R3LsadsmGSaUkAvjloORlI1b+p0bDzp+RiP/3xS2v/c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=UfhV2H9zpR9IvzVehAw2yAO5iVL43IoBfkb+hE8eHT913GtnYZ1J1hN8rhlmv6rAS
	 8pjhsAHyAOpY9Z97VfkIlemYDH4X/uUhOmPOwwx8T3dSH0SUvnnCHl95EU4rdSpeYi
	 ucCyafTYJdHyxaSDeI6e61xjZ6eN8b34amVFGWtk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgHFU67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 16:58:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725272AbgHFU66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 16:58:58 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02ADA221E2;
        Thu,  6 Aug 2020 20:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596747538;
        bh=R3LsadsmGSaUkAvjloORlI1b+p0bDzp+RiP/3xS2v/c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=EDy+qKRo3rWcIjOWCDCz2Y3X2QsprJNcE6j4tNoISYKnRBgces/RXT1fLTCUs91Ls
         MBw7k9EhARUuB3CnV3+RA2fLplEbkPqoa8wBv/Lq8jYkz8ECaIQd0fPSIcU2ZP/Cys
         XQZM0hzZ2CgKSKkYUteGgybCykyLCZDIswfP1qm8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BAD2F3520734; Thu,  6 Aug 2020 13:58:57 -0700 (PDT)
Date:   Thu, 6 Aug 2020 13:58:57 -0700
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
Message-ID: <20200806205857.GA29087@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200805230852.GA28727@paulmck-ThinkPad-P72>
 <CANpmjNPxzOFC+VQujipFaPmAV8evU2LnB4X-iXuHah45o-7pfw@mail.gmail.com>
 <CACT4Y+Ye7j-scb-thp2ubORCoEnuJPHL7W6Wh_DLP_4cux-0SQ@mail.gmail.com>
 <CACT4Y+aF=Y-b7Lm7+UAD7Zb1kS1uWF+G_3yBbXsY6YO3k2dBuw@mail.gmail.com>
 <20200806133557.GM4295@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806133557.GM4295@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 06:35:57AM -0700, Paul E. McKenney wrote:
> On Thu, Aug 06, 2020 at 03:25:57PM +0200, Dmitry Vyukov wrote:
> > On Thu, Aug 6, 2020 at 3:22 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Thu, Aug 6, 2020 at 12:31 PM Marco Elver <elver@google.com> wrote:
> > > >
> > > > +Cc kasan-dev
> 
> Thank you!
> 
> > > > On Thu, 6 Aug 2020 at 01:08, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > >
> > > > > Hello!
> > > > >
> > > > > If I remember correctly, one of you asked for a way to shorten RCU
> > > > > grace periods so that KASAN would have a better chance of detecting bugs
> > > > > such as pointers being leaked out of RCU read-side critical sections.
> > > > > I am finally starting entering and testing code for this, but realized
> > > > > that I had forgotten a couple of things:
> > > > >
> > > > > 1.      I don't remember exactly who asked, but I suspect that it was
> > > > >         Kostya.  I am using his Reported-by as a placeholder for the
> > > > >         moment, but please let me know if this should be adjusted.
> > > >
> > > > It certainly was not me.
> > > >
> > > > > 2.      Although this work is necessary to detect situtions where
> > > > >         call_rcu() is used to initiate a grace period, there already
> > > > >         exists a way to make short grace periods that are initiated by
> > > > >         synchronize_rcu(), namely, the rcupdate.rcu_expedited kernel
> > > > >         boot parameter.  This will cause all calls to synchronize_rcu()
> > > > >         to act like synchronize_rcu_expedited(), resulting in about 2-3
> > > > >         orders of magnitude reduction in grace-period latency on small
> > > > >         systems (say 16 CPUs).
> > > > >
> > > > > In addition, I plan to make a few other adjustments that will
> > > > > increase the probability of KASAN spotting a pointer leak even in the
> > > > > rcupdate.rcu_expedited case.
> > > >
> > > > Thank you, that'll be useful I think.
> > > >
> > > > > But if you would like to start this sort of testing on current mainline,
> > > > > rcupdate.rcu_expedited is your friend!
> > >
> > > Hi Paul,
> > >
> > > This is great!
> > >
> > > I understand it's not a sufficiently challenging way of tracking
> > > things, but it's simply here ;)
> > > https://bugzilla.kernel.org/show_bug.cgi?id=208299
> > > (now we also know who asked for this, +Jann)
> 
> Thank you, and I will update the Reported-by lines accordingly.
> 
> > > I've tested on the latest mainline and with rcupdate.rcu_expedited=1
> > > it boots to ssh successfully and I see:
> > > [    0.369258][    T0] All grace periods are expedited (rcu_expedited).
> > >
> > > I have created https://github.com/google/syzkaller/pull/2021 to enable
> > > it on syzbot.
> > > On syzbot we generally use only 2-4 CPUs per VM, so it should be even better.
> 
> Sounds good, and perhaps this will answer Marco's question below.  ;-)
> 
> > > > Do any of you remember some bugs we missed due to this? Can we find
> > > > them if we add this option?
> > >
> > > The problem is that it's hard to remember bugs that were not caught :)
> > > Here is an approximation of UAFs with free in rcu callback:
> > > https://groups.google.com/forum/#!searchin/syzkaller-bugs/KASAN$20use-after-free$20rcu_do_batch%7Csort:date
> > > The ones with low hit count are the ones that we almost did not catch.
> > > That's the best estimation I can think of. Also potentially we can get
> > > reproducers for such bugs without reproducers.
> > > Maybe we will be able to correlate some bugs/reproducers that appear
> > > soon with this change.
> > 
> > Wait, it was added in 2012?
> > https://github.com/torvalds/linux/commit/3705b88db0d7cc4
> 
> Indeed it was, which is my current excuse for having failed to immediately
> mention it to Jann during our IRC discussion.
> 
> The purpose back then was to make battery-powered systems go faster,
> I think mostly focused on CPU hotplug operations.  At least that would
> explain the commit log being indefinite on the exact benefit.  ;-)

And don't look now, but my current intermediate state seems to make the
following splat happen semi-reliably from within rcutorture when running
scenario TREE01 with "--kconfig "CONFIG_RCU_STRICT_GRACE_PERIOD=y".
The current changes cause this scenario to process more than double the
number of RCU grace periods per unit time, so who knows?

I am not reporting this one yet because it is of course quite possible
that it is due to my changes being messed up.

							Thanx, Paul

------------------------------------------------------------------------

[   99.769536] ------------[ cut here ]------------
[   99.770052] WARNING: CPU: 5 PID: 36 at kernel/irq_work.c:95 irq_work_queue_on+0x73/0x90
[   99.770905] Modules linked in:
[   99.771239] CPU: 5 PID: 36 Comm: migration/5 Not tainted 5.8.0-rc3+ #2153
[   99.771964] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-1ubuntu1 04/01/2014
[   99.772898] RIP: 0010:irq_work_queue_on+0x73/0x90
[   99.773405] Code: 89 ee 89 df e8 fe 4a fa ff bf 01 00 00 00 e8 24 32 f3 ff 65 8b 05 6d 48 6b 59 85 c0 ba 01 00 00 00 75 b6 e8 16 f9 e9 ff eb af <0f> 0b eb 9d 48 89 ef e8 b1 fe ff ff eb d1 0f 0b eb c3 90 66 2e 0f
[   99.775384] RSP: 0018:ffffae4200197d58 EFLAGS: 00010002
[   99.775944] RAX: 0000000000000005 RBX: 0000000000000005 RCX: 0000000000000001
[   99.776708] RDX: 0000000000000000 RSI: 0000000000000005 RDI: ffff96fe9f36a270
[   99.777466] RBP: ffff96fe9f36a270 R08: 00000019b750dcec R09: 0000000000000000
[   99.778224] R10: 0000000000000008 R11: ffffffffa7c550a8 R12: 0000000000000046
[   99.778981] R13: 0000000000000000 R14: 0000000000000000 R15: ffff96fe9ee51580
[   99.779740] FS:  0000000000000000(0000) GS:ffff96fe9f340000(0000) knlGS:0000000000000000
[   99.780694] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   99.781318] CR2: 00000000ffffffff CR3: 000000000fe0a000 CR4: 00000000000006e0
[   99.782076] Call Trace:
[   99.782356]  __rcu_read_unlock+0x118/0x140
[   99.782802]  sched_cpu_dying+0x157/0x230
[   99.783228]  ? sched_cpu_starting+0x30/0x30
[   99.783678]  cpuhp_invoke_callback+0x81/0x610
[   99.784159]  ? cpu_disable_common+0x28f/0x2b0
[   99.784630]  take_cpu_down+0x62/0xa0
[   99.785018]  multi_cpu_stop+0x5f/0xe0
[   99.785417]  ? stop_machine_yield+0x10/0x10
[   99.785869]  cpu_stopper_thread+0x80/0x100
[   99.786310]  ? sort_range+0x20/0x20
[   99.786689]  smpboot_thread_fn+0x199/0x230
[   99.787131]  kthread+0x139/0x160
[   99.787484]  ? kthread_park+0x80/0x80
[   99.787881]  ret_from_fork+0x22/0x30
[   99.788278] ---[ end trace 0b90671b542e1746 ]---
