Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B2BC34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17CF2464E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eihYPreW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgBSJC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 04:02:58 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39545 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgBSJC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 04:02:58 -0500
Received: by mail-lf1-f66.google.com with SMTP id t23so16792331lfk.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 01:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9mdafkGFE1/A9hESaW/fy4nLurlhlMJSzFn2FCxSr3Q=;
        b=eihYPreWe/yvP2cPuwbUY1INzp6vheX1MaFnujPkEniCx9dNvK9Vl7pb8uFCnARvHA
         crP9qf9nbYD/q10piaIz4sE3ERU6IdMIkk39cNyzJ6WzgBxPwwLtKPWE71t6N9/xxiz9
         OKnJmIpLWh+tZWMiTxCFDoWwt7LBhk/7lCKopdKbC5auFbX8j+ZvA9ee8tfuKMdaSYZc
         DkXyYsFSVnjGgqsSYOflGeUemfJ7BXnyJR2o9ZWMSHhdbXAlBl2ih6XFkZ9KU012B802
         YNUmF1RCHbhcqfw/tUbMXctsFAs4Bk4XK6aoJXMQdYqTRFX72vdH3cEW+E8Qrl+U15aF
         iUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9mdafkGFE1/A9hESaW/fy4nLurlhlMJSzFn2FCxSr3Q=;
        b=Avn3sz+pFCEfDffzNVtGSjIa6dp1x2O7wG1mdQyw8+MhUCwhJLy6LZMeOTXgQoak6z
         FVFMIT9c/z8siy4v571pXOmiHCPklv0A3/UnIHFaODvCZof69YqUW7BELFdye6iNe5ba
         FYQMGNOdzcGJliAJEcIGs2cfER7Vm0NQfOwqeS7jTpFqi8DUGj40WPRzPSg+BHn2PssL
         2ueBGQIVj+fE4vhYOyQ7dTftKBGLv0zxYjrxUahc9mH3vlgWH5TgFVvg9o30+m0/U+e9
         Ng81PqU5c9siDgKc91OMJN7lcnkUFQJwsU9GCl6WnH+LQtn0NzeMKH7mxQL1goHuEJdn
         wbvg==
X-Gm-Message-State: APjAAAUyG/B8+VBkKejoQqaJBo9+x5bQv7p3Ja4qoDEVSgO4MvIKOv8K
        VlVRnTolXL798wbWgeKtf/1mfR7h5+mDmv1L9sUBng==
X-Google-Smtp-Source: APXvYqx7bZlxmxvokOv1nZr/+UeiYfNKfPUQuyAkDtduDKN0uB8lDW3A+OyVmt6hVHikd2Ug3nEGr33JBj+byWdsFAo=
X-Received: by 2002:ac2:4add:: with SMTP id m29mr12895991lfp.190.1582102975220;
 Wed, 19 Feb 2020 01:02:55 -0800 (PST)
MIME-Version: 1.0
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
 <20200214152729.6059-5-vincent.guittot@linaro.org> <4cda8dc3-f6bb-2896-c899-65eadd5c839d@arm.com>
In-Reply-To: <4cda8dc3-f6bb-2896-c899-65eadd5c839d@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 19 Feb 2020 10:02:43 +0100
Message-ID: <CAKfTPtBVuYC9=QaMzeGuVqMBCTxT9mAp9U=iWZMzNg0a7Jos-Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] sched/pelt: Add a new runnable average signal
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 at 22:19, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 14/02/2020 15:27, Vincent Guittot wrote:
> > Now that runnable_load_avg has been removed, we can replace it by a new
> > signal that will highlight the runnable pressure on a cfs_rq. This signal
> > track the waiting time of tasks on rq and can help to better define the
> > state of rqs.
> >
> > At now, only util_avg is used to define the state of a rq:
> >   A rq with more that around 80% of utilization and more than 1 tasks is
> >   considered as overloaded.
> >
> > But the util_avg signal of a rq can become temporaly low after that a task
> > migrated onto another rq which can bias the classification of the rq.
> >
> > When tasks compete for the same rq, their runnable average signal will be
> > higher than util_avg as it will include the waiting time and we can use
> > this signal to better classify cfs_rqs.
> >
> > The new runnable_avg will track the runnable time of a task which simply
> > adds the waiting time to the running time. The runnable _avg of cfs_rq
> > will be the /Sum of se's runnable_avg and the runnable_avg of group entity
> > will follow the one of the rq similarly to util_avg.
> >
>
> I did a bit of playing around with tracepoints and it seems to be behaving
> fine. For instance, if I spawn 12 always runnable tasks (sysbench --test=cpu)
> on my Juno (6 CPUs), I get to a system-wide runnable value (\Sum cpu_runnable())
> of about 12K. I've only eyeballed them, but migration of the signal values
> seem fine too.
>
> I have a slight worry that the rq-wide runnable signal might be too easy to
> inflate, since we aggregate for *all* runnable tasks, and that may not play
> well with your group_is_overloaded() change (despite having the imbalance_pct
> on the "right" side).
>
> In any case I'll need to convince myself of it with some messing around, and
> this concerns patch 5 more than patch 4. So FWIW for this one:
>
> Tested-by: Valentin Schneider <valentin.schneider@arm.com>
>
> I also have one (two) more nit(s) below.
>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> > diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> > @@ -227,14 +231,14 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
> >        * Step 1: accumulate *_sum since last_update_time. If we haven't
> >        * crossed period boundaries, finish.
> >        */
> > -     if (!accumulate_sum(delta, sa, load, running))
> > +     if (!accumulate_sum(delta, sa, load, runnable, running))
> >               return 0;
> >
> >       return 1;
> >  }
> >
> >  static __always_inline void
> > -___update_load_avg(struct sched_avg *sa, unsigned long load)
> > +___update_load_avg(struct sched_avg *sa, unsigned long load, unsigned long runnable)
> >  {
> >       u32 divider = LOAD_AVG_MAX - 1024 + sa->period_contrib;
> >
> > @@ -242,6 +246,7 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load)
> >        * Step 2: update *_avg.
> >        */
> >       sa->load_avg = div_u64(load * sa->load_sum, divider);
> > +     sa->runnable_avg =      div _u64(runnable * sa->runnable_sum, divider);
>                           ^^^^^^        ^^^^^^^^
>                             a)             b)
> a) That's a tab
>
> b) The value being passed is always 1, do we really need it to expose it as a
>    parameter?

In fact, I haven't been able to convince myself if it was better to
add the SCHED_CAPACITY_SCALE range in the _sum or only in the _avg.
That's the reason for this parameter to still being there.
On one side we do a shift at every PELT update and the
attach/detach/propagate are quite straight forward. On the other side
it is done only during attach/detach/propagate but it complexify the
thing. Having it in _sum doesn't seem to be a concern so I will keep
it there and remove the parameter
