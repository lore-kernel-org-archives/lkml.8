Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2151DC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92A620746
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JOJEh8ex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgCMO0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:26:35 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46344 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgCMO0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:26:34 -0400
Received: by mail-lf1-f66.google.com with SMTP id r9so2535288lff.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 07:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=irAtZlhE5ipoJ5Rehur7bBbjUX7Tu4nfN7dSklsY0vM=;
        b=JOJEh8exqosUoHPcE3n8pKuCgoQXEn4uSLEBKIUdIHmmBBIsP1LisJYUJeRkhIPlBu
         Cz+2skfbMRBy/mMsI8N4Q3PveOU9yMt46Vg8s/vmU1Lm0Z1k6mKG7XI2Dk61LWO5fleK
         9VaW02uaQZbV/5EpDOzz2i4mst3q9Eo/ynSrH5L3talwAMNQiyQiJMkXF30fnjEztaHo
         4LqJEi8qn73GCe1kdj8CtGkezTGLwByCRJ9hlC4on/bG9dER0jKvoWG80Ln5grW+Y7Co
         EXXZmAPkW+w4f6NpPhG6wZNkwOqB2xJJ2UpGJJXlc+HsaqjQlObOM1JPv6/1bMkI7+8P
         e9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=irAtZlhE5ipoJ5Rehur7bBbjUX7Tu4nfN7dSklsY0vM=;
        b=KgotiaJzyzip7CCJTPbemvvVZt9KoOBODUoLLlAILJ1WbHYasNZlvii5SGVRp8URLQ
         EhXRlYua5GKUatV/EkqwV5KQkbQoUcXI5fNKPNU07DAt3E2p5Xg2w1G8l57hNUcjWDFp
         8X9ghaV+oYDwa995PqcuSXk+mKGfqj2pOAbt3asXF6xf272LY+JeGaZwbSSXnSum7mSQ
         gKtNd29+/JsrYDThy1Hw7OjbIO4Y6I2WDrUpCQqZSGzNhwIOXbfq1wbtr9UQsXewUdoh
         DB0k2GCdOqCbgwgoAqZ1LGpL2/TlyDh27hFCynIUuProLAzmXwewokezKuxGTGoGUGLb
         wc0A==
X-Gm-Message-State: ANhLgQ3CNYEjaeB6ZZrz2eC9Zd0Ln6l0dtqTr1P6kuJ7ZvdLQ1agStMF
        8S4TH2yUxonTBJykwsHbRVmvSO0vjNvXgwIZPS6VnA==
X-Google-Smtp-Source: ADFU+vvjEyUjdM+gaWGh7QIL0njIl3gQ7MDTz1GG3kSgxAydx8alREMSCi/pnABTDCjEaj4CWlDMgb3WZICUwJODfR4=
X-Received: by 2002:ac2:522e:: with SMTP id i14mr5481302lfl.133.1584109592111;
 Fri, 13 Mar 2020 07:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200312165429.990-1-vincent.guittot@linaro.org>
 <jhjr1xwjz96.mognet@arm.com> <CAKfTPtCQZMOz9HzdiWg5g9O+W=hC5E-fiG8YVHWCcODjFRfefQ@mail.gmail.com>
 <jhjpndgjxxk.mognet@arm.com> <jhj4kuspgse.mognet@arm.com> <CAKfTPtD67EKA46i12FHpJQT4gTzaH=ASAyb2dhv4=owPHBRSdQ@mail.gmail.com>
In-Reply-To: <CAKfTPtD67EKA46i12FHpJQT4gTzaH=ASAyb2dhv4=owPHBRSdQ@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 13 Mar 2020 15:26:20 +0100
Message-ID: <CAKfTPtBZgvTBYR+kYjj9dHq8_25mG19CZmYzY5s33ijSHdLGyQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: improve spreading of utilization
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Mar 2020 at 13:55, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Fri, 13 Mar 2020 at 13:42, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
> >
> >
> > On Fri, Mar 13 2020, Valentin Schneider wrote:
> > > On Fri, Mar 13 2020, Vincent Guittot wrote:
> > >>> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > >>> > index 3c8a379c357e..97a0307312d9 100644
> > >>> > --- a/kernel/sched/fair.c
> > >>> > +++ b/kernel/sched/fair.c
> > >>> > @@ -9025,6 +9025,14 @@ static struct rq *find_busiest_queue(struct lb_env *env,
> > >>> >               case migrate_util:
> > >>> >                       util = cpu_util(cpu_of(rq));
> > >>> >
> > >>> > +                     /*
> > >>> > +                      * Don't try to pull utilization from a CPU with one
> > >>> > +                      * running task. Whatever its utilization, we will fail
> > >>> > +                      * detach the task.
> > >>> > +                      */
> > >>> > +                     if (nr_running <= 1)
> > >>> > +                             continue;
> > >>> > +
> > >>>
> > >>> Doesn't this break misfit? If the busiest group is group_misfit_task, it
> > >>> is totally valid for the runqueues to have a single running task -
> > >>> that's the CPU-bound task we want to upmigrate.
> > >>
> > >>  group_misfit_task has its dedicated migrate_misfit case
> > >>
> > >
> > > Doh, yes, sorry. I think my rambling on ASYM_PACKING / reduced capacity
> > > migration is still relevant, though.
> > >
> >
> > And with more coffee that's another Doh, ASYM_PACKING would end up as
> > migrate_task. So this only affects the reduced capacity migration, which
>
> yes  ASYM_PACKING uses migrate_task and the case of reduced capacity
> would use it too and would not be impacted by this patch. I say
> "would" because the original rework of load balance got rid of this
> case. I'm going to prepare a separate fix  for this

After more thought, I think that we are safe for reduced capacity too
because this is handled in the migrate_load case. In my previous
reply, I was thinking of  the case where rq is not overloaded but cpu
has reduced capacity which is not handled. But in such case, we don't
have to force the migration of the task because there is still enough
capacity otherwise rq would be overloaded and we are back to the case
already handled

>
> > might be hard to notice in benchmarks.
