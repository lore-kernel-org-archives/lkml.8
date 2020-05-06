Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B73C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F389020752
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dMf6oT2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgEFNpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 09:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725966AbgEFNpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 09:45:42 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8DCC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 06:45:42 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 188so1376533lfa.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 06:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oNMw1/oUmQe9wJ5IG8wrbgriwK3wMZ1bOEkTKJypMs4=;
        b=dMf6oT2DO2yk/Rta1AQRBREJoVhXM6CqkriMdZHwYpd5adf/lEIDdhHN8FCarTxLov
         2WjdtT3LffvxiLAJyvmR05yc1WPgxZHSnwquGGGjA7TEklgRR5uKoGK4nEGVdpwTOews
         xJ+U2Q4BiZTfk30AreuFL+ePDQqbWLnSbw5CytDhe1nmK2ErFNIF6Qk+JScOoF2cLupY
         nhUurXboYWL1FeJD3gQPgBfRACkrBnicRuEiB4H+3EYIS6kk33m9YxQH1l3CpgaJAoH9
         fFG1W8X/wZEts5mRURxutxDhi4blnOt2ns/Vwg/dhQutv+XnS6nRICqfICOJSZMCfF+D
         WA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oNMw1/oUmQe9wJ5IG8wrbgriwK3wMZ1bOEkTKJypMs4=;
        b=DS7IRAaGlLNwzl8d/mLqQK2kkVh6Xg4z0SSmxfsqMEswvlmm9ZvvPm/Cd8J9RoHEea
         mmO1bqSlJMMyjC2FhfLs3b58zRerDZv8Su5xAnH97hCfp88GtleWGCCT4TmVgm2WvbXj
         FU3LmG3jZv4onn5sAgd+31n3kbAmEJcvekIi44+tBZ3Aee0xyCCDixIYwhkbCIauhBxM
         6lowc3KD+GSjgfXGerDMbo7Vkg4JLXvbRwxRvp12QS3GBH1zw34bUMS477ymWNEiADUS
         dXPgFhC4yjec1VFvhe9nO65GGedbJZGiHD9PaFZF/73MttD6dV6tFcO6J16Ruzp1H6JN
         VViA==
X-Gm-Message-State: AGi0PublSswhx/ZTKjKHWL8gvJonMtdWXQhNNkIGCkENYuA/S+hxTsyG
        9pEWNYy6w/bFROCJ0DWMPtMlMzDTRO/Tz1WkMRPbPg==
X-Google-Smtp-Source: APiQypLKFhBjnKbCluld53RcHtlLQB6Qj6qAB6Yyyk+eqxahTlAl1GfB0NFgZUOTgcfgsYpfgp/XPua0q/klDsg0FF0=
X-Received: by 2002:ac2:46c1:: with SMTP id p1mr4912523lfo.25.1588772739676;
 Wed, 06 May 2020 06:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200503083407.GA27766@iZj6chx1xj0e0buvshuecpZ>
 <CAKfTPtCNG9Y4xNA-iLd+JRRsUCA1+SkkFFRbbzk5n7q6v401tw@mail.gmail.com>
 <20200505134056.GA31680@iZj6chx1xj0e0buvshuecpZ> <20200505142711.GA12952@vingu-book>
 <jhjftcd1hmx.mognet@arm.com>
In-Reply-To: <jhjftcd1hmx.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 6 May 2020 15:45:28 +0200
Message-ID: <CAKfTPtCM7mE7a63rXB4cG5gHn03ArjTB1ZBje=qEWOGR9mj67g@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix nohz.next_balance update
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peng Liu <iwtbavbm@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 May 2020 at 12:29, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
> On 05/05/20 15:27, Vincent Guittot wrote:
> > So I would be in favor of something as simple as :
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 04098d678f3b..e028bc1c4744 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10457,6 +10457,14 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
> >                 }
> >         }
> >
> > +       /*
> > +        * next_balance will be updated only when there is a need.
> > +        * When the CPU is attached to null domain for ex, it will not be
> > +        * updated.
> > +        */
> > +       if (likely(update_next_balance))
> > +               nohz.next_balance = next_balance;
> > +
> >         /* Newly idle CPU doesn't need an update */
> >         if (idle != CPU_NEWLY_IDLE) {
> >                 update_blocked_averages(this_cpu);
> > @@ -10477,14 +10485,6 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
> >         if (has_blocked_load)
> >                 WRITE_ONCE(nohz.has_blocked, 1);
> >
> > -       /*
> > -        * next_balance will be updated only when there is a need.
> > -        * When the CPU is attached to null domain for ex, it will not be
> > -        * updated.
> > -        */
> > -       if (likely(update_next_balance))
> > -               nohz.next_balance = next_balance;
> > -
> >         return ret;
> >  }
> >
>
> But then we may skip an update if we goto abort, no? Imagine we have just
> NOHZ_STATS_KICK, so we don't call any rebalance_domains(), and then as we
> go through the last NOHZ CPU in the loop we hit need_resched(). We would
> end in the abort part without any update to nohz.next_balance, despite
> having accumulated relevant data in the local next_balance variable.

Yes but on the other end, the last CPU has not been able to run the
rebalance_domain so we must not move  nohz.next_balance otherwise it
will have to wait for at least another full period
In fact, I think that we have a problem with current implementation
because if we abort because  local cpu because busy we might end up
skipping idle load balance for a lot of idle CPUs

As an example, imagine that we have 10 idle CPUs with the same
rq->next_balance which equal nohz.next_balance.  _nohz_idle_balance
starts on CPU0, it processes idle lb for CPU1 but then has to abort
because of need_resched. If we update nohz.next_balance like
currently, the next idle load balance  will happen after a full
balance interval whereas we still have 8 CPUs waiting for running an
idle load balance.

My proposal also fixes this problem

>
> Also note that in this case, nohz_idle_balance() will still return true.
>
> If we rip out just the one update we need from rebalance_domains(), then
> perhaps we could go with what Peng was initially suggesting? i.e. something
> like the below.
>
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 46b7bd41573f..0a292e0a0731 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9934,22 +9934,8 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
>          * When the cpu is attached to null domain for ex, it will not be
>          * updated.
>          */
> -       if (likely(update_next_balance)) {
> +       if (likely(update_next_balance))
>                 rq->next_balance = next_balance;
> -
> -#ifdef CONFIG_NO_HZ_COMMON
> -               /*
> -                * If this CPU has been elected to perform the nohz idle
> -                * balance. Other idle CPUs have already rebalanced with
> -                * nohz_idle_balance() and nohz.next_balance has been
> -                * updated accordingly. This CPU is now running the idle load
> -                * balance for itself and we need to update the
> -                * nohz.next_balance accordingly.
> -                */
> -               if ((idle == CPU_IDLE) && time_after(nohz.next_balance, rq->next_balance))
> -                       nohz.next_balance = rq->next_balance;
> -#endif
> -       }
>  }
>
>  static inline int on_null_domain(struct rq *rq)
> @@ -10315,6 +10301,11 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>         if (flags & NOHZ_BALANCE_KICK)
>                 rebalance_domains(this_rq, CPU_IDLE);
>
> +       if (time_after(next_balance, this_rq->next_balance)) {
> +               next_balance = this_rq->next_balance;
> +               update_next_balance = 1;
> +       }
> +
>         WRITE_ONCE(nohz.next_blocked,
>                 now + msecs_to_jiffies(LOAD_AVG_PERIOD));
>
> @@ -10551,6 +10542,17 @@ static __latent_entropy void run_rebalance_domains(struct softirq_action *h)
>         /* normal load balance */
>         update_blocked_averages(this_rq->cpu);
>         rebalance_domains(this_rq, idle);
> +
> +#ifdef CONFIG_NO_HZ_COMMON
> +       /*
> +        * NOHZ idle CPUs will be rebalanced with nohz_idle_balance() and thus
> +        * nohz.next_balance will be updated accordingly. If there was no NOHZ
> +        * kick, then we just need to update nohz.next_balance wrt *this* CPU.
> +        */
> +       if ((idle == CPU_IDLE) &&
> +           time_after(nohz.next_balance, this_rq->next_balance))
> +               nohz.next_balance = this_rq->next_balance;
> +#endif
>  }
>
>  /*
> ---
