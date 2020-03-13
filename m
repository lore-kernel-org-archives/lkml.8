Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F78C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24386206BE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nB4eF0tt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgCMNPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:15:21 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46650 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgCMNPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 09:15:21 -0400
Received: by mail-lf1-f66.google.com with SMTP id r9so2329251lff.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 06:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4RbC+t56FP+h2CZ9zcELiUpgySPa+U+KMoYMP6T/fD8=;
        b=nB4eF0ttlP7MEtPxbfOWwGF+Onk0PESGl7ak20eqcp1hUcMJNPuXZFrZKkWsGHcgm9
         9hjrJNGWnD0e5c300x/7k1x4C6/3mWK9IMFsqIGNmgW3lIXD/zKpCs4TistDtaqYXzNH
         PJWkG1OXVGDLjfXliMCQc8KCNIRFKexG9X7xvQ0l3bvvMJuLZyx3bStAf8qKbxAm+Tre
         0wKQ0bEVAmzHap/txbhlteXH1ENVS2dSOXb6NXq/de4S+ZmJHl1Zw3bxMN1E41O+jRiJ
         ZPy4LyIdtrWzJsN+tQV9m1/FzPI3JWqHO1m3FSzzEkn1V7qPID/9PxLnN9LOxkKvRaLb
         fyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4RbC+t56FP+h2CZ9zcELiUpgySPa+U+KMoYMP6T/fD8=;
        b=LKZwT0cOp/+YFZrWKFPOQNQdG7SK7b0VXc17XdaADkKCqdj8Nq1KwZO3S/0AziUr7z
         behaVspbRfL0yAnBlNzmQ/t0BW7ddhpOeOk6oksn7YNnXPCI5MZwrG6SuBnlDxKDPxoZ
         Qiae9sQB23RJK2aCs7gcCYWQw+cph//VDcX0/PamGM737vkVS3SF/fMedCTp8wq/lqrM
         OJV1L9TJvgYGqGEcxIV/pu3bdjoBNw9+CeYQ0iebhCszYLOu44YYtDfSAzN3DtsRBWkz
         LlzDSYll/AwMmjHMrJ5QfLfXY6On7pWXgAYaJEIPwi3+vhWFbv6XaleqbUYV38XgL90Y
         BgIw==
X-Gm-Message-State: ANhLgQ0F2NINJVY9AiOkPfdXWctDfzL6IomfBmrqHpnl7THJXnQHnWzH
        5vzvXX+xbNkxIEh0H80WgywwRRwfbYAMe9mFoUbQoQ==
X-Google-Smtp-Source: ADFU+vvMgLvg3YrHSQ7yb6IeX9w/kw8uuz7WNcfR7xYEYmqZb7qn6RjS5CZXRlH8vEr9TltSyvCmUbHvlks+7sMM/oI=
X-Received: by 2002:a19:4c08:: with SMTP id z8mr8371376lfa.95.1584105316645;
 Fri, 13 Mar 2020 06:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200311202625.13629-1-daniel.lezcano@linaro.org>
 <CAKfTPtAqeHhVCeSgE1DsaGGkM6nY-9oAvGw_6zWvv1bKyE85JQ@mail.gmail.com>
 <e6e8ff94-64f2-6404-e332-2e030fc7e332@linaro.org> <CAKfTPtBU1fyxWhR04QTCbvn07KgTqAHRVOt18D3TxmZSeiHQQQ@mail.gmail.com>
 <ee3bbfeb-ddd5-e4dc-3999-39370e7a6c73@linaro.org>
In-Reply-To: <ee3bbfeb-ddd5-e4dc-3999-39370e7a6c73@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 13 Mar 2020 14:15:05 +0100
Message-ID: <CAKfTPtDUmqYB1i7UcYXxcNjnQOoGufsB9do-9NxTMeWdJAfP2w@mail.gmail.com>
Subject: Re: [PATCH V2] sched: fair: Use the earliest break even
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Mar 2020 at 13:15, Daniel Lezcano <daniel.lezcano@linaro.org> wr=
ote:
>
> On 12/03/2020 13:27, Vincent Guittot wrote:
> > On Thu, 12 Mar 2020 at 11:04, Daniel Lezcano <daniel.lezcano@linaro.org=
> wrote:
> >>
> >> On 12/03/2020 09:36, Vincent Guittot wrote:
> >>> Hi Daniel,
> >>>
> >>> On Wed, 11 Mar 2020 at 21:28, Daniel Lezcano <daniel.lezcano@linaro.o=
rg> wrote:
> >>>>
> >>>> In the idle CPU selection process occuring in the slow path via the
> >>>> find_idlest_group_cpu() function, we pick up in priority an idle CPU
> >>>> with the shallowest idle state otherwise we fall back to the least
> >>>> loaded CPU.
> >>>
> >>> The idea makes sense but this path is only used by fork and exec so
> >>> I'm not sure about the real impact
> >>
> >> I agree the fork / exec path is called much less often than the wake
> >> path but it makes more sense for the decision.
> >>
> >>>> In order to be more energy efficient but without impacting the
> >>>> performances, let's use another criteria: the break even deadline.
> >>>>
> >>>> At idle time, when we store the idle state the CPU is entering in, w=
e
> >>>> compute the next deadline where the CPU could be woken up without
> >>>> spending more energy to sleep.
> >>>>
> >>>> At the selection process, we use the shallowest CPU but in addition =
we
> >>>> choose the one with the minimal break even deadline instead of relyi=
ng
> >>>> on the idle_timestamp. When the CPU is idle, the timestamp has less
> >>>> meaning because the CPU could have wake up and sleep again several t=
imes
> >>>> without exiting the idle loop. In this case the break even deadline =
is
> >>>> more relevant as it increases the probability of choosing a CPU whic=
h
> >>>> reached its break even.
> >>>>
> >>>> Tested on:
> >>>>  - a synquacer 24 cores, 6 sched domains
> >>>>  - a hikey960 HMP 8 cores, 2 sched domains, with the EAS and energy =
probe
> >>>>
> >>>> sched/perf and messaging does not show a performance regression. Ran
> >>>> 50 times schbench, adrestia and forkbench.
> >>>>
> >>>> The tools described at https://lwn.net/Articles/724935/
> >>>>
> >>>>  --------------------------------------------------------------
> >>>> | Synquacer             | With break even | Without break even |
> >>>>  --------------------------------------------------------------
> >>>> | schbench *99.0th      |      14844.8    |         15017.6    |
> >>>> | adrestia / periodic   |        57.95    |              57    |
> >>>> | adrestia / single     |         49.3    |            55.4    |
> >>>>  --------------------------------------------------------------
> >>>
> >>> Have you got some figures or cpuidle statistics for the syncquacer ?
> >>
> >> No, and we just noticed the syncquacer has a bug in the firmware and
> >> does not actually go to the idle states.
> >>
> >>
> >>>> | Hikey960              | With break even | Without break even |
> >>>>  --------------------------------------------------------------
> >>>> | schbench *99.0th      |      56140.8    |           56256    |
> >>>> | schbench energy       |      153.575    |         152.676    |
> >>>> | adrestia / periodic   |         4.98    |             5.2    |
> >>>> | adrestia / single     |         9.02    |            9.12    |
> >>>> | adrestia energy       |         1.18    |           1.233    |
> >>>> | forkbench             |        7.971    |            8.05    |
> >>>> | forkbench energy      |         9.37    |            9.42    |
> >>>>  --------------------------------------------------------------
> >>>>
> >>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>>> ---
> >>>>  kernel/sched/fair.c  | 18 ++++++++++++++++--
> >>>>  kernel/sched/idle.c  |  8 +++++++-
> >>>>  kernel/sched/sched.h | 20 ++++++++++++++++++++
> >>>>  3 files changed, 43 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>>> index 4b5d5e5e701e..8bd6ea148db7 100644
> >>>> --- a/kernel/sched/fair.c
> >>>> +++ b/kernel/sched/fair.c
> >>>> @@ -5793,6 +5793,7 @@ find_idlest_group_cpu(struct sched_group *grou=
p, struct task_struct *p, int this
> >>>>  {
> >>>>         unsigned long load, min_load =3D ULONG_MAX;
> >>>>         unsigned int min_exit_latency =3D UINT_MAX;
> >>>> +       s64 min_break_even =3D S64_MAX;
> >>>>         u64 latest_idle_timestamp =3D 0;
> >>>>         int least_loaded_cpu =3D this_cpu;
> >>>>         int shallowest_idle_cpu =3D -1;
> >>>> @@ -5810,6 +5811,8 @@ find_idlest_group_cpu(struct sched_group *grou=
p, struct task_struct *p, int this
> >>>>                 if (available_idle_cpu(i)) {
> >>>>                         struct rq *rq =3D cpu_rq(i);
> >>>>                         struct cpuidle_state *idle =3D idle_get_stat=
e(rq);
> >>>> +                       s64 break_even =3D idle_get_break_even(rq);
> >>>> +
> >>>>                         if (idle && idle->exit_latency < min_exit_la=
tency) {
> >>>>                                 /*
> >>>>                                  * We give priority to a CPU whose i=
dle state
> >>>> @@ -5817,10 +5820,21 @@ find_idlest_group_cpu(struct sched_group *gr=
oup, struct task_struct *p, int this
> >>>>                                  * of any idle timestamp.
> >>>>                                  */
> >>>>                                 min_exit_latency =3D idle->exit_late=
ncy;
> >>>> +                               min_break_even =3D break_even;
> >>>>                                 latest_idle_timestamp =3D rq->idle_s=
tamp;
> >>>>                                 shallowest_idle_cpu =3D i;
> >>>> -                       } else if ((!idle || idle->exit_latency =3D=
=3D min_exit_latency) &&
> >>>> -                                  rq->idle_stamp > latest_idle_time=
stamp) {
> >>>> +                       } else if ((idle && idle->exit_latency =3D=
=3D min_exit_latency) &&
> >>>> +                                  break_even < min_break_even) {
> >>>> +                               /*
> >>>> +                                * We give priority to the shallowes=
t
> >>>> +                                * idle states with the minimal brea=
k
> >>>> +                                * even deadline to decrease the
> >>>> +                                * probability to choose a CPU which
> >>>> +                                * did not reach its break even yet
> >>>> +                                */
> >>>> +                               min_break_even =3D break_even;
> >>>> +                               shallowest_idle_cpu =3D i;
> >>>> +                       } else if (!idle && rq->idle_stamp > latest_=
idle_timestamp) {
> >>>>                                 /*
> >>>>                                  * If equal or no active idle state,=
 then
> >>>>                                  * the most recently idled CPU might=
 have
> >>>> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> >>>> index b743bf38f08f..3342e7bae072 100644
> >>>> --- a/kernel/sched/idle.c
> >>>> +++ b/kernel/sched/idle.c
> >>>> @@ -19,7 +19,13 @@ extern char __cpuidle_text_start[], __cpuidle_tex=
t_end[];
> >>>>   */
> >>>>  void sched_idle_set_state(struct cpuidle_state *idle_state)
> >>>>  {
> >>>> -       idle_set_state(this_rq(), idle_state);
> >>>> +       struct rq *rq =3D this_rq();
> >>>> +
> >>>> +       idle_set_state(rq, idle_state);
> >>>
> >>> Shouldn't the state be set after setting break even otherwise you wil=
l
> >>> have a time window with an idle_state !=3D null but the break_even st=
ill
> >>> set to the previous value
> >>
> >> IIUC we are protected in this section. Otherwise the routine above wou=
ld
> >> be also wrong [if (idle && idle->exit_latency)], no?
> >
> > no there are not the same because it uses the idle pointer to read
> > exit_latency so we are sure to use exit_latency related to the idle
> > pointer.
> >
> > In your case it checks idle is not null but then it uses rq to read
> > break_even but it might not have been already updated
>
> Ok I will invert the lines.
>
> >>>> +
> >>>> +       if (idle_state)
> >>>> +               idle_set_break_even(rq, ktime_get_ns() +
> >>>
> >>> What worries me a bit is that it adds one ktime_get call each time a
> >>> cpu enters idle
> >>
> >> Right, we can improve this in the future by folding the local_clock() =
in
> >> cpuidle when entering idle with this ktime_get.
> >
> > Using local_clock() would be more latency friendly
>
> Unfortunately we are comparing the deadline across CPUs, so the
> local_clock() can not be used here.
>
> But if we have one ktime_get() instead of a local_clock() + ktime_get(),
> that should be fine, no?

Can't this computation of break_even be done in cpuidle framework
while computing other statistics for selecting the idle state instead
? cpuidle already uses ktime_get for next hrtimer as an example.
So cpuidle compute break_even and make it available to scheduler like
exit_latency. And I can imagine that system wide time value will also
be needed when looking at next wakeup event of cluster/group of CPUs

>
> >>>> +                                   idle_state->exit_latency_ns);
> >>>>  }
> >>
> >> [ ... ]
> >>
> >>
> >> --
> >>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs
> >>
> >> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> >> <http://twitter.com/#!/linaroorg> Twitter |
> >> <http://www.linaro.org/linaro-blog/> Blog
> >>
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
