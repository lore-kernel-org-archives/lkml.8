Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21BBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 01:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1B13207F7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 01:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KeXNSTZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgEVB0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 21:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgEVB0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 21:26:20 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30555C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 18:26:20 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id p12so7131542qtn.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 18:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8sldq0pMkWDsxQ4+5VF7/Xl+EYi91SNnCVeh6ANVjMA=;
        b=KeXNSTZQPmytCRtDQ2bBN4aRS4A7Lnla+lbYVhJRu96GSy3NoAEdP2e09RVS91IKS8
         8647xtQUd4Fu5B3mXQrkoo2d6hTGL6p/1Aj7XTtHeMIUUQD0g6ofMD6R3bHXCRiJll75
         bw8dvhnz2tqzKf3p+HGcqjuQkWOOzNzpAeygGXUd/kehm3/OI9qfUk9rnggFxi7UkVZK
         GT4Hj7HGnLSZIzdE+aVjQ5QVGsMso3sNnSK1EasjReTTMxal4JkHgrdwgbDWisSIg5x+
         A7MLrkQSRVdrfdgiG2S9zW/pYMtysOPV2yovy9Z9WKl7kofjJFHVUIn0+Lm+cvTt/aey
         60sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8sldq0pMkWDsxQ4+5VF7/Xl+EYi91SNnCVeh6ANVjMA=;
        b=r7ClYCb9nK43NTzsNHvYYQRwpoID59U7aRcTwBjlxqJi6hxMfE07qIj3YVmWiCwQrI
         7tME/MuUVTRr55BGMgYj0mBNWQZU8jLIu1WozCtXuxxOzqhZ6l0/YglKfZsi5ATSPep4
         k1b/xW/DLgzYVidEgI0fj7jkrGR80+HVHyS1aYRK5xeakQtUZzHnr4QtZOV84dctm2tM
         FOID81GP4KflwRTSHzvLuYfYfW5oFx/c8CUpZ/5cxgyUhLvUNj3Q9q7DlXUGAgde4xo7
         pauZwI6KFzFgEeF8fDtHPGyhgkyccfWt1MqzWIKNizcgqnu7aaC2c5/ObITsxaGfEem6
         Lt2w==
X-Gm-Message-State: AOAM533Tu9XIZpTSxnRtqBWJDZ/WmR0GQcHBG/33IfmQHUBvfu+B3SAI
        3myozM1oL1kWbLlvw1T0zZ3UqANjoyAmQX8ILhjyfQ==
X-Google-Smtp-Source: ABdhPJxFgxrb/KqPSe2SjIw5HgVTkYN54u4PTLazRZxD6RstWtydGYuJE8M75QHUR22jaA/ErjKnA6xapmrOjN4YOWs=
X-Received: by 2002:ac8:1c67:: with SMTP id j36mr13503048qtk.34.1590110778831;
 Thu, 21 May 2020 18:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <20200520224818.78930-1-joel@joelfernandes.org> <20200521225202.GD2869@paulmck-ThinkPad-P72>
In-Reply-To: <20200521225202.GD2869@paulmck-ThinkPad-P72>
From:   Joel Fernandes <joelaf@google.com>
Date:   Thu, 21 May 2020 21:26:05 -0400
Message-ID: <CAJWu+opfReuX=uEV+2yhor81yjzSe1O0JP9=TxPd2O-mxxFyyw@mail.gmail.com>
Subject: Re: [PATCH RFC] sched: Use sched-RCU in core-scheduling balancing logic
To:     paulmck@kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        vpillai <vpillai@digitalocean.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Frederic Weisbecker" <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 6:52 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, May 20, 2020 at 06:48:18PM -0400, Joel Fernandes (Google) wrote:
> > rcu_read_unlock() can incur an infrequent deadlock in
> > sched_core_balance(). Fix this by using sched-RCU instead.
> >
> > This fixes the following spinlock recursion observed when testing the
> > core scheduling patches on PREEMPT=y kernel on ChromeOS:
> >
> > [    3.240891] BUG: spinlock recursion on CPU#2, swapper/2/0
> > [    3.240900]  lock: 0xffff9cd1eeb28e40, .magic: dead4ead, .owner: swapper/2/0, .owner_cpu: 2
> > [    3.240905] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.4.22htcore #4
> > [    3.240908] Hardware name: Google Eve/Eve, BIOS Google_Eve.9584.174.0 05/29/2018
> > [    3.240910] Call Trace:
> > [    3.240919]  dump_stack+0x97/0xdb
> > [    3.240924]  ? spin_bug+0xa4/0xb1
> > [    3.240927]  do_raw_spin_lock+0x79/0x98
> > [    3.240931]  try_to_wake_up+0x367/0x61b
> > [    3.240935]  rcu_read_unlock_special+0xde/0x169
> > [    3.240938]  ? sched_core_balance+0xd9/0x11e
> > [    3.240941]  __rcu_read_unlock+0x48/0x4a
> > [    3.240945]  __balance_callback+0x50/0xa1
> > [    3.240949]  __schedule+0x55a/0x61e
> > [    3.240952]  schedule_idle+0x21/0x2d
> > [    3.240956]  do_idle+0x1d5/0x1f8
> > [    3.240960]  cpu_startup_entry+0x1d/0x1f
> > [    3.240964]  start_secondary+0x159/0x174
> > [    3.240967]  secondary_startup_64+0xa4/0xb0
> > [   14.998590] watchdog: BUG: soft lockup - CPU#0 stuck for 11s! [kworker/0:10:965]
> >
> > Cc: vpillai <vpillai@digitalocean.com>
> > Cc: Aaron Lu <aaron.lwe@gmail.com>
> > Cc: Aubrey Li <aubrey.intel@gmail.com>
> > Cc: peterz@infradead.org
> > Cc: paulmck@kernel.org
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Change-Id: I1a4bf0cd1426b3c21ad5de44719813ad4ee5805e
>
> With some luck, the commit removing the need for this will hit
> mainline during the next merge window.  Fingers firmly crossed...

Sounds good, thank you Paul :-)

 - Joel


>
>                                                 Thanx, Paul
>
> > ---
> >  kernel/sched/core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 780514d03da47..b8ca6fcaaaf06 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4897,7 +4897,7 @@ static void sched_core_balance(struct rq *rq)
> >       struct sched_domain *sd;
> >       int cpu = cpu_of(rq);
> >
> > -     rcu_read_lock();
> > +     rcu_read_lock_sched();
> >       raw_spin_unlock_irq(rq_lockp(rq));
> >       for_each_domain(cpu, sd) {
> >               if (!(sd->flags & SD_LOAD_BALANCE))
> > @@ -4910,7 +4910,7 @@ static void sched_core_balance(struct rq *rq)
> >                       break;
> >       }
> >       raw_spin_lock_irq(rq_lockp(rq));
> > -     rcu_read_unlock();
> > +     rcu_read_unlock_sched();
> >  }
> >
> >  static DEFINE_PER_CPU(struct callback_head, core_balance_head);
> > --
> > 2.26.2.761.g0e0b3e54be-goog
> >
