Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C76DC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625AE2073E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4JYaeuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgCMMze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:55:34 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44239 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgCMMzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:55:33 -0400
Received: by mail-lf1-f67.google.com with SMTP id b186so7681439lfg.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 05:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CpV/S5dRh3Z14cEhftotr9GJXEKt0+TwJPXh+2tNvD8=;
        b=T4JYaeuknvc4qLFnfdDNS+L23u70exnEXshCWS8mkjZHF1TaK4rTP8ehcfofCLDzlE
         Cvgt/yW0FrVbyeH7lvpJ8pYpdVivnLQ9dp/5jjKdi/Et8vt/PEbtlNB3oWJJ63xWoOK1
         U3nQzyElFPTKWv/ou2whD6H52+osMi0WLv1rI58mxelQjaGhC4Z6P2ZCx3oJrgHJF7r4
         2iQoh9JRy+RBWEz8K02QlO5WQE+TAeXq0EHBFwApsfXrfOQrXe9C5b3kh7UjRQsGfFwQ
         v7LzlpusC/5r+vInNPRG0aJ2JJanH5jjTLNIkmbibdZiix8EzCE3G7/SOTP0ahLdgWiQ
         yURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CpV/S5dRh3Z14cEhftotr9GJXEKt0+TwJPXh+2tNvD8=;
        b=ZXnsUbg7zMh3QiiIDTuwa/5jb52heV9NEcWhMYG3dg5VfZ2ucztQw1N3j8OS9UCcfk
         VxgV0U1YNGpxzgo/Lqg/y9B4DKLVMmu9QyUEDrCol5MJgVg7ejmqK7GMs5leycGqJGwg
         vxmIIh9K0o3CEGXJJ7v+HkbMvOgw9yMKw1tjThTC7FYBMEECHfQsqWIXSSBKgoR+aa9W
         ZZXeWUlgdEz3MZTJI1nxHJF8YIGLvVA89IqV4YXFoL7dfkU04JgZzd7nrCG/P7xOeizx
         IulCg6RVfezRb/pr6QIgSeKI05CpqvdKB45f3SawbwEPHzATrboI4RSjDsaWD4g3XEs7
         ay6g==
X-Gm-Message-State: ANhLgQ2KrDr/sp/Bm/Ft+fgRytC5hTl85NgGLu5yQfY03IVHkpDX3dOz
        EFOH6B8/tPCzcHjaUwdTDfeSOMVU3ALzgLc6tflsww==
X-Google-Smtp-Source: ADFU+vsdsqOniZwX7HJCxOjKyY6eLnhL0Ec1Mn2JUGYMbOnZvL6w+LyNkHYKVx2z5mRtpwNjRZ0Fmk/+yWNdJ6tLEsg=
X-Received: by 2002:ac2:5605:: with SMTP id v5mr8714363lfd.184.1584104131957;
 Fri, 13 Mar 2020 05:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200312165429.990-1-vincent.guittot@linaro.org>
 <jhjr1xwjz96.mognet@arm.com> <CAKfTPtCQZMOz9HzdiWg5g9O+W=hC5E-fiG8YVHWCcODjFRfefQ@mail.gmail.com>
 <jhjpndgjxxk.mognet@arm.com> <jhj4kuspgse.mognet@arm.com>
In-Reply-To: <jhj4kuspgse.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 13 Mar 2020 13:55:20 +0100
Message-ID: <CAKfTPtD67EKA46i12FHpJQT4gTzaH=ASAyb2dhv4=owPHBRSdQ@mail.gmail.com>
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

On Fri, 13 Mar 2020 at 13:42, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
> On Fri, Mar 13 2020, Valentin Schneider wrote:
> > On Fri, Mar 13 2020, Vincent Guittot wrote:
> >>> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>> > index 3c8a379c357e..97a0307312d9 100644
> >>> > --- a/kernel/sched/fair.c
> >>> > +++ b/kernel/sched/fair.c
> >>> > @@ -9025,6 +9025,14 @@ static struct rq *find_busiest_queue(struct lb_env *env,
> >>> >               case migrate_util:
> >>> >                       util = cpu_util(cpu_of(rq));
> >>> >
> >>> > +                     /*
> >>> > +                      * Don't try to pull utilization from a CPU with one
> >>> > +                      * running task. Whatever its utilization, we will fail
> >>> > +                      * detach the task.
> >>> > +                      */
> >>> > +                     if (nr_running <= 1)
> >>> > +                             continue;
> >>> > +
> >>>
> >>> Doesn't this break misfit? If the busiest group is group_misfit_task, it
> >>> is totally valid for the runqueues to have a single running task -
> >>> that's the CPU-bound task we want to upmigrate.
> >>
> >>  group_misfit_task has its dedicated migrate_misfit case
> >>
> >
> > Doh, yes, sorry. I think my rambling on ASYM_PACKING / reduced capacity
> > migration is still relevant, though.
> >
>
> And with more coffee that's another Doh, ASYM_PACKING would end up as
> migrate_task. So this only affects the reduced capacity migration, which

yes  ASYM_PACKING uses migrate_task and the case of reduced capacity
would use it too and would not be impacted by this patch. I say
"would" because the original rework of load balance got rid of this
case. I'm going to prepare a separate fix  for this

> might be hard to notice in benchmarks.
