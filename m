Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6322C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 09:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79CA206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 09:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LOmAUKow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgA3Jti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 04:49:38 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33528 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3Jti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 04:49:38 -0500
Received: by mail-lj1-f196.google.com with SMTP id y6so2638744lji.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 01:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y7mpfXEEdg2j7N0KRo5LM+dEv4sTPhHftYE87IZmXl8=;
        b=LOmAUKowzWnUWfKeU27Au6YRUWwO5v/qVKOjPJlPJOUz3KyDZPGXz2+y/Nzq6iiZab
         uynHO8N2/kJnryUWaSma1UxqZ2GOaOx4UFjmhdyQCXfRcYKTMkSgNnskgHmSow494KNX
         J3xKpRLmEEzuavhtpwEX0tp8+Ze9lk+5IvrAgxCn7SKaFbvyF16MAbnSs65mJWxWXwXd
         nFgWUyIMC3vVN2te3PTnNu7S0ozEe99OpPSOi3zf8t+WD/p3MCrwnHfhiE2gIuDLyvut
         NQEvOlUi8zQGZLwNvflc7lo5CZb1Xph84EM+O2WeARfU6ZYn0YIpoK0plhsWaQfevtKS
         X2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y7mpfXEEdg2j7N0KRo5LM+dEv4sTPhHftYE87IZmXl8=;
        b=ZNWCuRLakRkqZ4LaBft03gkPEXZVyaVX92onl/TwwE2mDgETwWzS6vJSbVw19ad+am
         EhZqWddk4mX9xnT+e+NRLRfFFDg0za/nZOOD9d5Q2TLiQEg4TW/6S5B6HyJfsoiVEahF
         gWDIKTcmeJUTRJERT+DSWG5IQdP5v6RBXtBkqEmhIamwhW4cvCPZIurxhqEAMpzNZWeJ
         9S5tKIrQx9lBFJItqXqEG+SMsZ5UFFnbNGNOZ8O8W1AIbo8IEl4h7BvOwh2VtG/aR5C5
         oWfo+rUE9kqi9gC2WGqr9fQ8RMXyvsqLvbhZ1VpTP85SzvDF/rkYaxyUIR9u93QtUVev
         FrSg==
X-Gm-Message-State: APjAAAUIH8G7Kirjfex67yVoPs9OGQxVFMc9obwU1cJ8OBDMwwtQ5akw
        6rYUB8+GgaJAAo+P35z6uZG7bIwPsKikIDmXPtgb5R+4oLdTyQ==
X-Google-Smtp-Source: APXvYqzsWAD5XUbPy0U2iJOQZ6b/ofQSbMnITmgi2PyrVFDrNF+P4fHIMdT1Qwd5jbHkjt0CVGl9c4Yr7iD9R6HWpKk=
X-Received: by 2002:a2e:909a:: with SMTP id l26mr2101837ljg.209.1580377772183;
 Thu, 30 Jan 2020 01:49:32 -0800 (PST)
MIME-Version: 1.0
References: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
 <1579031859-18692-5-git-send-email-thara.gopinath@linaro.org>
 <20200116151502.GQ2827@hirez.programming.kicks-ass.net> <CAKfTPtA-M_APhGzwADhuwABzW_M5YKjm_ONGzQjFNRoJ+qYBmg@mail.gmail.com>
 <20200117145544.GE14879@hirez.programming.kicks-ass.net> <CAKfTPtAzgNAV5c_sTycSocmi8Y4oGGT5rDNSYmgL3tCjZ1RAQw@mail.gmail.com>
 <e0ede843-4cb8-83d8-708b-87d96b6eb1c3@arm.com> <CAKfTPtA-pr9y2MuwY8vTAy=m4beqdhNCek0fgdZP7u0JT8ojvA@mail.gmail.com>
 <aabc0d05-6092-7e50-9758-acab30d3c434@arm.com> <CAKfTPtCG2xT2+Hwo__N2+0nSRkdOQqtJ_38AxpC4AbCe60y=Xw@mail.gmail.com>
 <f5d64110-85bf-92a5-9d63-faa5d64d2155@arm.com>
In-Reply-To: <f5d64110-85bf-92a5-9d63-faa5d64d2155@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 30 Jan 2020 10:49:20 +0100
Message-ID: <CAKfTPtBzoLnvAJ7sjPogMYS=WwBbdzWO07Kj=KDFVpO4=Su5ow@mail.gmail.com>
Subject: Re: [Patch v8 4/7] sched/fair: Enable periodic update of average
 thermal pressure
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Quentin Perret <qperret@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        viresh kumar <viresh.kumar@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2020 at 16:41, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 27/01/2020 16:15, Vincent Guittot wrote:
> > On Mon, 27 Jan 2020 at 13:09, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 24/01/2020 16:45, Vincent Guittot wrote:
> >>> On Fri, 24 Jan 2020 at 16:37, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>>>
> >>>> On 17/01/2020 16:39, Vincent Guittot wrote:
> >>>>> On Fri, 17 Jan 2020 at 15:55, Peter Zijlstra <peterz@infradead.org> wrote:
> >>>>>>
> >>>>>> On Fri, Jan 17, 2020 at 02:22:51PM +0100, Vincent Guittot wrote:
> >>>>>>> On Thu, 16 Jan 2020 at 16:15, Peter Zijlstra <peterz@infradead.org> wrote:
> >>
> >> [...]
> >>
> >>>> The 'now' argument is one thing but why not:
> >>>>
> >>>> -int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
> >>>> +int update_thermal_load_avg(u64 now, struct rq *rq)
> >>>>  {
> >>>> +       u64 capacity = arch_cpu_thermal_pressure(cpu_of(rq));
> >>>> +
> >>>>         if (___update_load_sum(now, &rq->avg_thermal,
> >>>>
> >>>> This would make the call-sites __update_blocked_others() and
> >>>> task_tick(_fair)() cleaner.
> >>>
> >>> I prefer to keep the capacity as argument. This is more aligned with
> >>> others that provides the value of the signal to apply
> >>>
> >>>>
> >>>> I guess the argument is not to pollute pelt.c. But it already contains
> >>>
> >>> you've got it. I don't want to pollute the pelt.c file with things not
> >>> related to pelt but thermal as an example.
> >>>
> >>>> arch_scale_[freq|cpu]_capacity() for irq.
> >>
> >> But isn't arch_cpu_thermal_pressure() not exactly the same as
> >> arch_scale_cpu_capacity() and arch_scale_freq_capacity()?
> >>
> >> All of them are defined by default within the scheduler code
> >> [include/linux/sched/topology.h or kernel/sched/sched.h] and can be
> >> overwritten by arch code with a fast implementation (e.g. returning a
> >> per-cpu variable).
> >>
> >> So why is using arch_scale_freq_capacity() and arch_scale_cpu_capacity()
> >> in update_irq_load_avg [kernel/sched/pelt.c] and update_rq_clock_pelt()
> >
> > As explained previously, update_irq_load_avg is an exception and not
> > the example to follow. update_rt/dl_rq_load_avg are the example to
> > follow and fixing update_irq_load_avg exception is on my todo list
>
> There is already a v9 but I comment here so the thread stays intact.
>
> I guess this thread leads to nowhere. For me the question is do we
> review against existing code or some possible future changes? The
> arguments didn't convince me so far.
> But we're not talking functional issues here so I won't continue to push
> for change on this one here.
>
> >> [kernel/sched/pelt.h] OK but arch_cpu_thermal_pressure() in
> >> update_thermal_load_avg() [kernel/sched/pelt.c] not?
> >>
> >> Shouldn't arch_cpu_thermal_pressure() not be called
> >> arch_scale_thermal_capacity() to highlight the fact that those three
> >
> > Quoted from cover letter https://lkml.org/lkml/2020/1/14/1164:
> > "
> > v6->v7:
> >        - ...
> >         - Renamed arch_scale_thermal_capacity to arch_cpu_thermal_pressure
> >           as per review comments from Peter, Dietmar and Ionela.
> >        -...
> >
> > "
>
> I went back to the v6 review. Peter originally asked for a better name
> (or an additional comment) for arch_scale_thermal_capacity() because the
> return value is not capacity.
>
> So IMHO arch_scale_thermal_pressure() is a good name for keeping this
> aligned w/ the other arch_scale_* functions and to address this review
> comment.
>
> arch_scale_cpu_capacity()     - scale capacity by cpu
> arch_scale_freq_capacity()    - scale capacity by frequency
> arch_scale_thermal_pressure() - scale pressure (1 - capacity) by thermal

If arch_scale_thermal_pressure() is ok for everybody i'm fine too.

I don't have a strong opinion about the name of the function as long
as we don't go back and forth

>
> [...]
