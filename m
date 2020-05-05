Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8DCC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3901206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qKZbYUNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbgEEPnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729317AbgEEPnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:43:19 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C31C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 08:43:19 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id l19so2103671lje.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 08:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DhthIf7CTlC9G12YBGk1iRdVnwTNCA1LvL1+ZqqXV2c=;
        b=qKZbYUNS2kU0jTt5mGNECTrByQrLJUq8bi36thZpFfojsyOno8orxxb8Y7wGsti62+
         aLhYdfZMugv3hcB3j76jHvIQ4Q01PUPTYJxFGP1EfybaJ4OjWzHKWn35HUxY/11fJ9NP
         L3RCykMkqhYuDfCMVjMNqcKzRbP0YnlewfKPGfPw1FiQhd/xDVbjGSKoPOm5kwY0Lhmy
         DVowBGDYijBP0LcQnjEqXLzZeDPoH41tXp061810WQiHX6xAy2tZA9Mj5gsdNpcgf3Kq
         AnTNWz6TNNvlvYzLYWEUOAD8m33xNCyYh+gQ6JLR5JRtdZy+2mcRUxqMX38IpaTnfPiW
         6GXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DhthIf7CTlC9G12YBGk1iRdVnwTNCA1LvL1+ZqqXV2c=;
        b=tZp8cXvJwpOWaFYPpD2QMQu+RzHVRDHzIsCbvM1N8fwsG/LPVgoKsukxW5AR4iqign
         5T3VSZ2QSJunF+T1f7iJuiLIRb87b3854Y+sfyJSaaygQ5oVX8oD8N6gcIAdMcGBN5Kk
         PEWO9yzd4HjvizfZrdIhP13ED2HdaeI7HqawCznYPUsaZFndQK/C3n91/eOWoNgOULQM
         rUWjXzD5gUzw6r6t8YvPhX4PLxkR1gmWIMsz7gLU6KkbkZ/FIcDijsi47TcCFB+x/TvW
         jWg4mmqI4DDhYulGIb+smK0SOBAAw5Xn4XjZ3ig+YWMG5ysP4eguMITvgfoAgTBWb00K
         RlfQ==
X-Gm-Message-State: AGi0PuayEkC2BuXAtDtUuMfDhdmeVkovyMP6/6s1blfdJUDnGlwBejqK
        5hUP4ZYwtWdU/eJRZVmtxr3AsfY/P4uYRuk1OwjYmQ==
X-Google-Smtp-Source: APiQypIF4s9QgRHLcGuR1KGnifBoZlM+ESBe9Yq39DUwnKQtRijimrH4cjp5++YOQ4jtO/YhJpax5E0TIjfbgKUZv4Q=
X-Received: by 2002:a05:651c:319:: with SMTP id a25mr2057428ljp.209.1588693396001;
 Tue, 05 May 2020 08:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200503083407.GA27766@iZj6chx1xj0e0buvshuecpZ>
 <CAKfTPtCNG9Y4xNA-iLd+JRRsUCA1+SkkFFRbbzk5n7q6v401tw@mail.gmail.com>
 <20200505134056.GA31680@iZj6chx1xj0e0buvshuecpZ> <20200505142711.GA12952@vingu-book>
 <20200505151641.GA31878@iZj6chx1xj0e0buvshuecpZ>
In-Reply-To: <20200505151641.GA31878@iZj6chx1xj0e0buvshuecpZ>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 5 May 2020 17:43:04 +0200
Message-ID: <CAKfTPtAYdHk0aafH5tQ7b=AVmoZim99kndOHe3cAmfBm125QSw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix nohz.next_balance update
To:     Peng Liu <iwtbavbm@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 May 2020 at 17:16, Peng Liu <iwtbavbm@gmail.com> wrote:
>
> On Tue, May 05, 2020 at 04:27:11PM +0200, Vincent Guittot wrote:
> > Le mardi 05 mai 2020 =C3=A0 21:40:56 (+0800), Peng Liu a =C3=A9crit :
> > > On Mon, May 04, 2020 at 05:17:11PM +0200, Vincent Guittot wrote:
> > > > On Sun, 3 May 2020 at 10:34, Peng Liu <iwtbavbm@gmail.com> wrote:
> > > > >
>
> [...]
>
> > > Yes, you're right. When need_resched() returns true, things become ou=
t
> > > of expectation. We haven't really got the earliest next_balance, abor=
t
> > > the update immediately and let the successor to help. Doubtless this
> > > will incur some overhead due to the repeating work.
> >
> > There should not be some repeating works because CPUs and sched_domain,=
 which
> > have already been balanced, will not be rebalanced until the next load =
balance
> > interval.
> >
> > Futhermore, there is in fact still work to do bcause not all the idle C=
PUs got
> > a chance to pull work
> >
> > >
> > >
> > > About the "tick is not stopped when entering idle" case, defer the
> > > update to nohz_balance_enter_idle() would be a choice too.
> > >
> > >
> > > Of course, only update nohz.next_balance in rebalance_domains() is th=
e
> > > simpliest way, but as @Valentin put, too many write to it may incur
> > > unnecessary overhead. If we can gather the earliest next_balance in
> >
> > This is not really possible because we have to move it to the next inte=
rval.
> >
> > > advance, then a single write is considered to be better.
> > >
> > > By the way, remove the redundant check in nohz_idle_balance().
> > >
> > > FWIW, how about the below?
> >
> > Your proposal below looks quite complex. IMO, one solution would be to =
move the
> > update of nohz.next_balance before calling rebalance_domains(this_rq, C=
PU_IDLE)
> > so you are back to the previous behavior.
> >
> > The only difference is that in case of an break because of need_resched=
, it
> > doesn't update nohz.next_balance. But on the other hand, we haven't yet
> > finished run rebalance_domains for all CPUs and some load_balance are s=
till
> > pending. In fact, this will be done during next tick by an idle CPU.
> >
> > So I would be in favor of something as simple as :
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 04098d678f3b..e028bc1c4744 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10457,6 +10457,14 @@ static bool _nohz_idle_balance(struct rq *this=
_rq, unsigned int flags,
> >                 }
> >         }
> >
> > +       /*
> > +        * next_balance will be updated only when there is a need.
> > +        * When the CPU is attached to null domain for ex, it will not =
be
> > +        * updated.
> > +        */
> > +       if (likely(update_next_balance))
> > +               nohz.next_balance =3D next_balance;
> > +
> >         /* Newly idle CPU doesn't need an update */
> >         if (idle !=3D CPU_NEWLY_IDLE) {
> >                 update_blocked_averages(this_cpu);
> > @@ -10477,14 +10485,6 @@ static bool _nohz_idle_balance(struct rq *this=
_rq, unsigned int flags,
> >         if (has_blocked_load)
> >                 WRITE_ONCE(nohz.has_blocked, 1);
> >
> > -       /*
> > -        * next_balance will be updated only when there is a need.
> > -        * When the CPU is attached to null domain for ex, it will not =
be
> > -        * updated.
> > -        */
> > -       if (likely(update_next_balance))
> > -               nohz.next_balance =3D next_balance;
> > -
> >         return ret;
> >  }
> >
>
> Indeed, simple and straightforward, it's better.
>
> > > ***********************************************
> > > * Below code is !!!ENTIRELY UNTESTED!!!, just *
>
> [...]
>
> > > @@ -10354,9 +10350,7 @@ static bool nohz_idle_balance(struct rq *this=
_rq, enum cpu_idle_type idle)
> > >  {
> > >     int this_cpu =3D this_rq->cpu;
> > >     unsigned int flags;
> > > -
> > > -   if (!(atomic_read(nohz_flags(this_cpu)) & NOHZ_KICK_MASK))
> > > -           return false;
> >
> > why did you remove this ?
> >
>
> It seems that below 'if' do the same thing, isn't?

The test above is an optimization for the most common case

>
> /* could be _relaxed() */
> flags =3D atomic_fetch_andnot(NOHZ_KICK_MASK, nohz_flags(this_cpu));
> if (!(flags & NOHZ_KICK_MASK))
>         return false;
>
> > > +   bool done;
> > >
> > >     if (idle !=3D CPU_IDLE) {
> > >             atomic_andnot(NOHZ_KICK_MASK, nohz_flags(this_cpu));
> > > @@ -10368,9 +10362,16 @@ static bool nohz_idle_balance(struct rq *thi=
s_rq, enum cpu_idle_type idle)
> > >     if (!(flags & NOHZ_KICK_MASK))
> > >             return false;
> > >
>
> [...]
>
> > >  static void nohz_newidle_balance(struct rq *this_rq)
