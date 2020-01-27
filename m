Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0945C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739C620716
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="paCWn4fR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbgA0PPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 10:15:18 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45303 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbgA0PPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 10:15:18 -0500
Received: by mail-lj1-f195.google.com with SMTP id j26so11036452ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 07:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m+OnEfzyfg+muaU/2AUGZRAG0jjXR+QcDzWNJ7FtrgE=;
        b=paCWn4fRy110Dggp/mnjowZDRQwZUnLbDFR8w3jX3jDPvgCjktfRhj7wBkqtasZLkf
         t/J1rcWs8k2O1YvuMzvkMzH4wc8gGmJDq1MCI/liEXywdK7vd69moww8clsw+BRT+eRb
         IPlWUBhP82hoemb3DqHIjTrexQCBzar9PKu6i7L8uWuzSZ65AXq1xKNkyXNDgbU40GBZ
         oLOb+uYX1rAV3K0iv34WeJOlut/haIgrQoEK0JUlgYoTVwnioJfmHOi9aOkpL1VIE4HW
         zsd4z+V9dnANDam3cR/Q+bU1rCDaHtxGaar+FTrUy17jJKExiunjsERx9OM2udvNH61E
         bm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m+OnEfzyfg+muaU/2AUGZRAG0jjXR+QcDzWNJ7FtrgE=;
        b=WAFsC9cychf058nSkbZNYm/1h548GF72kA8lnQJhJL12Ah2REunoZXvtqLIp73kgM7
         LHQO9vPDE+Jz1z8dN8Ofc7KPedCGVVrc5iJbNN7WvJG3Rx1d6RJZzmFySSG1C6yWPrYH
         1DmfPDaWkSA5MIKb/Z9lJnyMjvKIiTtKAk7gmcHQFb0LiCecD91XyU5p+7B2w9aNkzRb
         Xmr/4MggneKybTqxZzdHseoAG2OIRXko2cf8hkWFUGnhwLOm7dP4S/xnZJpniAMeE8AX
         q7L8vU1PkNKDexekz5je0nioHjKl4cN2/ofc0fZqc3dmOaD02NJU/N5SvR3pCTOt8l2M
         6caw==
X-Gm-Message-State: APjAAAVY0oN7gtY/f2jzjghb9xQPaBxvV3DmdUS0QDUllhWtSWRTeCg9
        NuU0X3kE5qnE9MC/XMym+kOY9aREWetinSCz3YDQEA==
X-Google-Smtp-Source: APXvYqx2FBx1N5/FWCTQn77nyta1XZvk3IJKXI03qUaX2hC1b0o1joc6whQV3eAlixolEWIN0F9Ex08LSeVjw/iEKNc=
X-Received: by 2002:a2e:909a:: with SMTP id l26mr9881296ljg.209.1580138116210;
 Mon, 27 Jan 2020 07:15:16 -0800 (PST)
MIME-Version: 1.0
References: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
 <1579031859-18692-5-git-send-email-thara.gopinath@linaro.org>
 <20200116151502.GQ2827@hirez.programming.kicks-ass.net> <CAKfTPtA-M_APhGzwADhuwABzW_M5YKjm_ONGzQjFNRoJ+qYBmg@mail.gmail.com>
 <20200117145544.GE14879@hirez.programming.kicks-ass.net> <CAKfTPtAzgNAV5c_sTycSocmi8Y4oGGT5rDNSYmgL3tCjZ1RAQw@mail.gmail.com>
 <e0ede843-4cb8-83d8-708b-87d96b6eb1c3@arm.com> <CAKfTPtA-pr9y2MuwY8vTAy=m4beqdhNCek0fgdZP7u0JT8ojvA@mail.gmail.com>
 <aabc0d05-6092-7e50-9758-acab30d3c434@arm.com>
In-Reply-To: <aabc0d05-6092-7e50-9758-acab30d3c434@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 27 Jan 2020 16:15:04 +0100
Message-ID: <CAKfTPtCG2xT2+Hwo__N2+0nSRkdOQqtJ_38AxpC4AbCe60y=Xw@mail.gmail.com>
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

On Mon, 27 Jan 2020 at 13:09, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 24/01/2020 16:45, Vincent Guittot wrote:
> > On Fri, 24 Jan 2020 at 16:37, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 17/01/2020 16:39, Vincent Guittot wrote:
> >>> On Fri, 17 Jan 2020 at 15:55, Peter Zijlstra <peterz@infradead.org> wrote:
> >>>>
> >>>> On Fri, Jan 17, 2020 at 02:22:51PM +0100, Vincent Guittot wrote:
> >>>>> On Thu, 16 Jan 2020 at 16:15, Peter Zijlstra <peterz@infradead.org> wrote:
>
> [...]
>
> >> The 'now' argument is one thing but why not:
> >>
> >> -int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
> >> +int update_thermal_load_avg(u64 now, struct rq *rq)
> >>  {
> >> +       u64 capacity = arch_cpu_thermal_pressure(cpu_of(rq));
> >> +
> >>         if (___update_load_sum(now, &rq->avg_thermal,
> >>
> >> This would make the call-sites __update_blocked_others() and
> >> task_tick(_fair)() cleaner.
> >
> > I prefer to keep the capacity as argument. This is more aligned with
> > others that provides the value of the signal to apply
> >
> >>
> >> I guess the argument is not to pollute pelt.c. But it already contains
> >
> > you've got it. I don't want to pollute the pelt.c file with things not
> > related to pelt but thermal as an example.
> >
> >> arch_scale_[freq|cpu]_capacity() for irq.
>
> But isn't arch_cpu_thermal_pressure() not exactly the same as
> arch_scale_cpu_capacity() and arch_scale_freq_capacity()?
>
> All of them are defined by default within the scheduler code
> [include/linux/sched/topology.h or kernel/sched/sched.h] and can be
> overwritten by arch code with a fast implementation (e.g. returning a
> per-cpu variable).
>
> So why is using arch_scale_freq_capacity() and arch_scale_cpu_capacity()
> in update_irq_load_avg [kernel/sched/pelt.c] and update_rq_clock_pelt()

As explained previously, update_irq_load_avg is an exception and not
the example to follow. update_rt/dl_rq_load_avg are the example to
follow and fixing update_irq_load_avg exception is on my todo list

> [kernel/sched/pelt.h] OK but arch_cpu_thermal_pressure() in
> update_thermal_load_avg() [kernel/sched/pelt.c] not?
>
> Shouldn't arch_cpu_thermal_pressure() not be called
> arch_scale_thermal_capacity() to highlight the fact that those three

Quoted from cover letter https://lkml.org/lkml/2020/1/14/1164:
"
v6->v7:
       - ...
        - Renamed arch_scale_thermal_capacity to arch_cpu_thermal_pressure
          as per review comments from Peter, Dietmar and Ionela.
       -...

"

> functions are doing the same thing, scaling capacity by something (cpu,
> frequency or thermal)?
