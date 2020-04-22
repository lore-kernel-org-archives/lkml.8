Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45BAC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29E720774
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F5cwlswn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgDVNgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 09:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgDVNgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 09:36:38 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FA0C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 06:36:36 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id f18so2260809lja.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 06:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B4V8xTwTvDTL3MhpA5Lm+TEis+W9bJLecCVE4WU5hmg=;
        b=F5cwlswnYslRfkJsmdDBVavvDi8Ca1zDJMoElyz8PyYHq5j8kapSnmXGSMuxUf6aLZ
         atLAJGmAm0Yhro7uTwTWRC+O+3Rf7faFr33E8Wye9MAuqwcWBn7Y0m25SUf+LQf4/hOS
         gIFAljqkYZYRRQQaGGOGSoVdbbchWwIvuNrXVcv+o5lFALEWdePbRm5U2ZxpwTrIqd9R
         Q1dKx/jUXDWtUJGIPzYD7zz5y6a20ysQ645FPAtrJwilHw97/TB7y2Bqbi5jkldr0h4U
         2gKGoOAr6pJYeTHJVAneIwAzE1UklyPUOMdVB2fuGWOTqvhe5v1s64khf49OG/wCDR1k
         K/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B4V8xTwTvDTL3MhpA5Lm+TEis+W9bJLecCVE4WU5hmg=;
        b=gTf1Uo+0gbHPnksYDTHbCmwF4TZ7oXmzxN9x4ftPnTETg11tfng4dEC1vdXmapJkdU
         cB+rG6ijf4VDin/sXWCq4J6Q4eGjgmRxVkUgPFvfEXNjojv+DffueIjOlLnq4xGQDFoO
         Ih/59Kq893etjr/zfTUh/SR9XPnRBr+dLks38hA5x+akjdwBzcSS+hvgn8SX4S9GswtM
         /K9/3L6j4ev1pTzx9MzfiGZxyk9MD5gdIY2km4VaF+NvPhGcw+khHDB8rVSSztRfimZC
         B+D/fGzcqhZFpr5oNmIZMEHKAUHyN/44Flh+s24SbP+g4PbEgptvgNwn0nK1cAU0U/9I
         vowQ==
X-Gm-Message-State: AGi0PuaQFdEXb96G33NCvqEAFdjCjn2eM+XZxtqAwZsX4g/7V5zoDhOf
        dyH8rF6ndaO1DPRhO2i/XDb1kWJoa4YdeEcITUy9Pw==
X-Google-Smtp-Source: APiQypJaI000LaEIQ47ZGjd6O1U473PzseYG/uhrTa6F/mlC+YDDsokDXhlDK0GBkN0Z50nPlk2KRr1bBfOIVAk9lh8=
X-Received: by 2002:a05:651c:319:: with SMTP id a25mr4091157ljp.209.1587562595026;
 Wed, 22 Apr 2020 06:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200422112719.826676174@infradead.org> <20200422112831.988065598@infradead.org>
 <CAKfTPtB8NiKqggZN3v6u=Rdwj4grzRwn1mW31ov0y5ZhDBcvuw@mail.gmail.com> <20200422132923.GK20730@hirez.programming.kicks-ass.net>
In-Reply-To: <20200422132923.GK20730@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 22 Apr 2020 15:36:22 +0200
Message-ID: <CAKfTPtBsFDt8JyxjD39B2YP+kCN9nXWZxnaJys9sz2CjWzd1Zw@mail.gmail.com>
Subject: Re: [PATCH 13/23] sched,ion: Convert to sched_set_normal()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020 at 15:29, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Apr 22, 2020 at 03:21:45PM +0200, Vincent Guittot wrote:
> > On Wed, 22 Apr 2020 at 13:29, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > In an attempt to take away sched_setscheduler() from modules, change
> > > this into sched_set_normal(.nice = 19).
> > >
> > > Cc: john.stultz@linaro.org
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Reviewed-by: Ingo Molnar <mingo@kernel.org>
> > > ---
> > >  drivers/staging/android/ion/ion_heap.c |    3 ---
> > >  1 file changed, 3 deletions(-)
> > >
> > > --- a/drivers/staging/android/ion/ion_heap.c
> > > +++ b/drivers/staging/android/ion/ion_heap.c
> > > @@ -244,8 +244,6 @@ static int ion_heap_deferred_free(void *
> > >
> > >  int ion_heap_init_deferred_free(struct ion_heap *heap)
> > >  {
> > > -       struct sched_param param = { .sched_priority = 0 };
> > > -
> > >         INIT_LIST_HEAD(&heap->free_list);
> > >         init_waitqueue_head(&heap->waitqueue);
> > >         heap->task = kthread_run(ion_heap_deferred_free, heap,
> > > @@ -255,7 +253,7 @@ int ion_heap_init_deferred_free(struct i
> > >                        __func__);
> > >                 return PTR_ERR_OR_ZERO(heap->task);
> > >         }
> > > -       sched_setscheduler(heap->task, SCHED_IDLE, &param);
> > > +       sched_set_normal(heap->task, 19);
> >
> > Would it make sense to have a sched_set_idle(task) to enable kernel
> > setting SCHED_IDLE task ?
> >
> > SCHED_NORMAL w/ nice 19 and SCHED_IDLE tasks are not treated in the
> > same way when checking for preemption at  wakeup
>
> Yeah, but does it really matter? I did indeed consider it, but got
> lazy. Is there a definite need for IDLE?

John is the best to answer this for this driver but SCHED_IDLE will
let other tasks which might be involved in end user interaction like
on Android to run first
