Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A048AC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 761B8206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCvEDUKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbgEEQIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 12:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729365AbgEEQIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 12:08:52 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26973C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 09:08:52 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s18so1205664pgl.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 09:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ftQT9qUoXYzPaJy00KLHc3zTrK9zULiiZOwbWjrIEz8=;
        b=PCvEDUKWNlVbQ7GoJ9qnJ71MxkR7f4VK+HZXRrTEuaaDbqHLTVSJUo8WEF/DnyOyBp
         xs3CO5qIOJMk3w6+z++qmBPVS6qaGcwL1AMBttvFxyekitXKH6l54rraanMU4XW/apIT
         sSWieQL/EzE8OPPYVROw7IVxRal79nEaq0DquNptM45on3Ne3K/1dDpd0VZDKLa5DY9o
         KAZAFYj9oyYdbtqzrFrBXaPMGY2R8IqHo9UTzEWtnVGvWVotmFbNXdgIDH/s2ZKyT9y3
         lO0+ToD16rJO/DYaelUQslT9u+yAOGqMQA67we+Ke9hCcHCSXktmAU8PY3R7CqOK50oI
         I1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ftQT9qUoXYzPaJy00KLHc3zTrK9zULiiZOwbWjrIEz8=;
        b=WsNPMDitBPjSduGLd6dT1ZG8H9qFBz1m/iTrh4E8T/JlxsU1/lJdgX+j+TCVplqwRH
         axrb4lsXCZdVCgVotMlbeL0nBYHqXCKZSUSe7jSDCwLBe3RZ2t9oW2MkIX8kMtIXctne
         Wt35Wm/iiCR+XTxdYLPsWFqZFn6rVnhDhVyNZF7JL/1fOCL4miTQUSYh/omOHeEfh/ZX
         wEZlruT8Yt079O9QosnUF7POslWNR2aox3b/4ZFaKYRF9GvRofOejHPVWATVimZX3yoh
         6imjWmL+cny5bHF5FNvPQ5cHPuKV2M8vVFvfCjh6/UAylsKEYvgQrKrtNZyy7xiCQ3m/
         H4Qg==
X-Gm-Message-State: AGi0PuYRgPoETdPTTY7aTL9c3f/u9JHTdeIEvYr7LJ5ZjTW5nldAfCnJ
        deATLgyx2gJIvcY+lw18Ly4=
X-Google-Smtp-Source: APiQypL/D+rRTYsbKALWtrhJe1unz76o6Rv+U/jaZtX0uhpXbsYpuuDP0TVnJcS7DX9AUB9XiRpliQ==
X-Received: by 2002:a65:6706:: with SMTP id u6mr3468104pgf.148.1588694931633;
        Tue, 05 May 2020 09:08:51 -0700 (PDT)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id a2sm1823069pgh.57.2020.05.05.09.08.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 May 2020 09:08:50 -0700 (PDT)
Date:   Wed, 6 May 2020 00:08:47 +0800
From:   Peng Liu <iwtbavbm@gmail.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        iwtbavbm@gmail.com, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, valentin.schneider@arm.com
Subject: Re: [PATCH] sched/fair: Fix nohz.next_balance update
Message-ID: <20200505160847.GA32080@iZj6chx1xj0e0buvshuecpZ>
References: <20200503083407.GA27766@iZj6chx1xj0e0buvshuecpZ>
 <CAKfTPtCNG9Y4xNA-iLd+JRRsUCA1+SkkFFRbbzk5n7q6v401tw@mail.gmail.com>
 <20200505134056.GA31680@iZj6chx1xj0e0buvshuecpZ>
 <20200505142711.GA12952@vingu-book>
 <20200505151641.GA31878@iZj6chx1xj0e0buvshuecpZ>
 <CAKfTPtAYdHk0aafH5tQ7b=AVmoZim99kndOHe3cAmfBm125QSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtAYdHk0aafH5tQ7b=AVmoZim99kndOHe3cAmfBm125QSw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 05:43:04PM +0200, Vincent Guittot wrote:
> On Tue, 5 May 2020 at 17:16, Peng Liu <iwtbavbm@gmail.com> wrote:
> >
> > On Tue, May 05, 2020 at 04:27:11PM +0200, Vincent Guittot wrote:
> > > Le mardi 05 mai 2020 à 21:40:56 (+0800), Peng Liu a écrit :
> > > > On Mon, May 04, 2020 at 05:17:11PM +0200, Vincent Guittot wrote:
> > > > > On Sun, 3 May 2020 at 10:34, Peng Liu <iwtbavbm@gmail.com> wrote:
> > > > > >
> >
> > [...]
> >
> > > > Yes, you're right. When need_resched() returns true, things become out
> > > > of expectation. We haven't really got the earliest next_balance, abort
> > > > the update immediately and let the successor to help. Doubtless this
> > > > will incur some overhead due to the repeating work.
> > >
> > > There should not be some repeating works because CPUs and sched_domain, which
> > > have already been balanced, will not be rebalanced until the next load balance
> > > interval.
> > >
> > > Futhermore, there is in fact still work to do bcause not all the idle CPUs got
> > > a chance to pull work
> > >
> > > >
> > > >
> > > > About the "tick is not stopped when entering idle" case, defer the
> > > > update to nohz_balance_enter_idle() would be a choice too.
> > > >
> > > >
> > > > Of course, only update nohz.next_balance in rebalance_domains() is the
> > > > simpliest way, but as @Valentin put, too many write to it may incur
> > > > unnecessary overhead. If we can gather the earliest next_balance in
> > >
> > > This is not really possible because we have to move it to the next interval.
> > >
> > > > advance, then a single write is considered to be better.
> > > >
> > > > By the way, remove the redundant check in nohz_idle_balance().
> > > >
> > > > FWIW, how about the below?
> > >
> > > Your proposal below looks quite complex. IMO, one solution would be to move the
> > > update of nohz.next_balance before calling rebalance_domains(this_rq, CPU_IDLE)
> > > so you are back to the previous behavior.
> > >
> > > The only difference is that in case of an break because of need_resched, it
> > > doesn't update nohz.next_balance. But on the other hand, we haven't yet
> > > finished run rebalance_domains for all CPUs and some load_balance are still
> > > pending. In fact, this will be done during next tick by an idle CPU.
> > >
> > > So I would be in favor of something as simple as :
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 04098d678f3b..e028bc1c4744 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -10457,6 +10457,14 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
> > >                 }
> > >         }
> > >
> > > +       /*
> > > +        * next_balance will be updated only when there is a need.
> > > +        * When the CPU is attached to null domain for ex, it will not be
> > > +        * updated.
> > > +        */
> > > +       if (likely(update_next_balance))
> > > +               nohz.next_balance = next_balance;
> > > +
> > >         /* Newly idle CPU doesn't need an update */
> > >         if (idle != CPU_NEWLY_IDLE) {
> > >                 update_blocked_averages(this_cpu);
> > > @@ -10477,14 +10485,6 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
> > >         if (has_blocked_load)
> > >                 WRITE_ONCE(nohz.has_blocked, 1);
> > >
> > > -       /*
> > > -        * next_balance will be updated only when there is a need.
> > > -        * When the CPU is attached to null domain for ex, it will not be
> > > -        * updated.
> > > -        */
> > > -       if (likely(update_next_balance))
> > > -               nohz.next_balance = next_balance;
> > > -
> > >         return ret;
> > >  }
> > >
> >
> > Indeed, simple and straightforward, it's better.
> >
> > > > ***********************************************
> > > > * Below code is !!!ENTIRELY UNTESTED!!!, just *
> >
> > [...]
> >
> > > > @@ -10354,9 +10350,7 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
> > > >  {
> > > >     int this_cpu = this_rq->cpu;
> > > >     unsigned int flags;
> > > > -
> > > > -   if (!(atomic_read(nohz_flags(this_cpu)) & NOHZ_KICK_MASK))
> > > > -           return false;
> > >
> > > why did you remove this ?
> > >
> >
> > It seems that below 'if' do the same thing, isn't?
> 
> The test above is an optimization for the most common case
> 

If the above is for optimization, then we can safely remove the below
test, just atomic_fetch_andnot() is enough, right?

If not, frankly speaking, I really got confused.

> >
> > /* could be _relaxed() */
> > flags = atomic_fetch_andnot(NOHZ_KICK_MASK, nohz_flags(this_cpu));
> > if (!(flags & NOHZ_KICK_MASK))
> >         return false;
> >
> > > > +   bool done;
> > > >
> > > >     if (idle != CPU_IDLE) {
> > > >             atomic_andnot(NOHZ_KICK_MASK, nohz_flags(this_cpu));
> > > > @@ -10368,9 +10362,16 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
> > > >     if (!(flags & NOHZ_KICK_MASK))
> > > >             return false;
> > > >
> >
> > [...]
> >
> > > >  static void nohz_newidle_balance(struct rq *this_rq)
