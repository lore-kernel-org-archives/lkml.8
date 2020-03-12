Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EFFC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE2E206EB
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lUT/relY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgCLM2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 08:28:07 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46081 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLM2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 08:28:07 -0400
Received: by mail-lj1-f195.google.com with SMTP id d23so6137843ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 05:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nd/zdGYlA70CTuFDEU0VLMsOD4eE45IQffsNZCkZVWA=;
        b=lUT/relYkzQ+58qXYYgVOfzy8wkuvCTRPp2JZwNPMGsEbtQ5W5y+ZfNhTfQmrVAxj2
         Bn3ZZaEk0WWgbeckUHQqEvTyJA3Kiy+363OSX7G98P4XueeF602e8dU4dECDdPn79WcG
         suA9hA6Ngd0sT5JQ6EXvYaRgHF/NKBddRlMuqRL2H6wiaWb7+FVqadyt2OZGwWghAdYd
         kSY3aR2/aHRbYC8gAcotuoV+99S8cTqnycZ1zpXEsMIPhOYTEMv4+BT3kpu29pwxLNU7
         bFbYabaVqY5eeAn8YQSI2srbg/0Opk+QE7gODCqMEJF5XR4xmHiwFQHC+kVFDEy5Zntu
         gQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nd/zdGYlA70CTuFDEU0VLMsOD4eE45IQffsNZCkZVWA=;
        b=glPmNqA5sLcLbvKU4zw31r91RAFZ5aXMqco1scxYUbZ0SS1qM6yZEexEFZO4scfA9J
         5Bvb8foak7DwsKskQMg80qX3zqNAMcrJO4H5w+woesNcdzPqvMchDXknEUfyFUHAfbN1
         ySEg+FIZBXfpsX6reogs9UQWKPPeviiSYirHxsvn2FCPRwRERUMf+J5/gQ4UgFvLJbCa
         3PLYC2FyhcjtFvOWDvwbUYF9KJTf/fYPanU1i9CF7usjwHAYzgZJyPN5CL4ZHNLwLHUZ
         8wyvZ1M1geyvUEB9ez/W7pERbJDXiv1WowAesWJFiKMBGoDPQmMZqbA/SiIphef9lACG
         MI9g==
X-Gm-Message-State: ANhLgQ3d0aoPhHwXlpfASKdRhsCcutMPDbgVYJxFXVsMqLeM9X5I5q/h
        qHyAcyhbfPNJtwc5f6+gUg9PO76c9z6TfwXEB7lLTw==
X-Google-Smtp-Source: ADFU+vt2/cUUslf05snEaz3tDPF+CSffkiBZz/Oc9f/Q9RdHCUxl0njNcz67/PBM35t6Qk7ZRU6LILryC/9njyPxl4c=
X-Received: by 2002:a2e:8112:: with SMTP id d18mr4908196ljg.137.1584016085060;
 Thu, 12 Mar 2020 05:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200311202625.13629-1-daniel.lezcano@linaro.org>
 <CAKfTPtAqeHhVCeSgE1DsaGGkM6nY-9oAvGw_6zWvv1bKyE85JQ@mail.gmail.com> <e6e8ff94-64f2-6404-e332-2e030fc7e332@linaro.org>
In-Reply-To: <e6e8ff94-64f2-6404-e332-2e030fc7e332@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 12 Mar 2020 13:27:53 +0100
Message-ID: <CAKfTPtBU1fyxWhR04QTCbvn07KgTqAHRVOt18D3TxmZSeiHQQQ@mail.gmail.com>
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

On Thu, 12 Mar 2020 at 11:04, Daniel Lezcano <daniel.lezcano@linaro.org> wr=
ote:
>
> On 12/03/2020 09:36, Vincent Guittot wrote:
> > Hi Daniel,
> >
> > On Wed, 11 Mar 2020 at 21:28, Daniel Lezcano <daniel.lezcano@linaro.org=
> wrote:
> >>
> >> In the idle CPU selection process occuring in the slow path via the
> >> find_idlest_group_cpu() function, we pick up in priority an idle CPU
> >> with the shallowest idle state otherwise we fall back to the least
> >> loaded CPU.
> >
> > The idea makes sense but this path is only used by fork and exec so
> > I'm not sure about the real impact
>
> I agree the fork / exec path is called much less often than the wake
> path but it makes more sense for the decision.
>
> >> In order to be more energy efficient but without impacting the
> >> performances, let's use another criteria: the break even deadline.
> >>
> >> At idle time, when we store the idle state the CPU is entering in, we
> >> compute the next deadline where the CPU could be woken up without
> >> spending more energy to sleep.
> >>
> >> At the selection process, we use the shallowest CPU but in addition we
> >> choose the one with the minimal break even deadline instead of relying
> >> on the idle_timestamp. When the CPU is idle, the timestamp has less
> >> meaning because the CPU could have wake up and sleep again several tim=
es
> >> without exiting the idle loop. In this case the break even deadline is
> >> more relevant as it increases the probability of choosing a CPU which
> >> reached its break even.
> >>
> >> Tested on:
> >>  - a synquacer 24 cores, 6 sched domains
> >>  - a hikey960 HMP 8 cores, 2 sched domains, with the EAS and energy pr=
obe
> >>
> >> sched/perf and messaging does not show a performance regression. Ran
> >> 50 times schbench, adrestia and forkbench.
> >>
> >> The tools described at https://lwn.net/Articles/724935/
> >>
> >>  --------------------------------------------------------------
> >> | Synquacer             | With break even | Without break even |
> >>  --------------------------------------------------------------
> >> | schbench *99.0th      |      14844.8    |         15017.6    |
> >> | adrestia / periodic   |        57.95    |              57    |
> >> | adrestia / single     |         49.3    |            55.4    |
> >>  --------------------------------------------------------------
> >
> > Have you got some figures or cpuidle statistics for the syncquacer ?
>
> No, and we just noticed the syncquacer has a bug in the firmware and
> does not actually go to the idle states.
>
>
> >> | Hikey960              | With break even | Without break even |
> >>  --------------------------------------------------------------
> >> | schbench *99.0th      |      56140.8    |           56256    |
> >> | schbench energy       |      153.575    |         152.676    |
> >> | adrestia / periodic   |         4.98    |             5.2    |
> >> | adrestia / single     |         9.02    |            9.12    |
> >> | adrestia energy       |         1.18    |           1.233    |
> >> | forkbench             |        7.971    |            8.05    |
> >> | forkbench energy      |         9.37    |            9.42    |
> >>  --------------------------------------------------------------
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> ---
> >>  kernel/sched/fair.c  | 18 ++++++++++++++++--
> >>  kernel/sched/idle.c  |  8 +++++++-
> >>  kernel/sched/sched.h | 20 ++++++++++++++++++++
> >>  3 files changed, 43 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 4b5d5e5e701e..8bd6ea148db7 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -5793,6 +5793,7 @@ find_idlest_group_cpu(struct sched_group *group,=
 struct task_struct *p, int this
> >>  {
> >>         unsigned long load, min_load =3D ULONG_MAX;
> >>         unsigned int min_exit_latency =3D UINT_MAX;
> >> +       s64 min_break_even =3D S64_MAX;
> >>         u64 latest_idle_timestamp =3D 0;
> >>         int least_loaded_cpu =3D this_cpu;
> >>         int shallowest_idle_cpu =3D -1;
> >> @@ -5810,6 +5811,8 @@ find_idlest_group_cpu(struct sched_group *group,=
 struct task_struct *p, int this
> >>                 if (available_idle_cpu(i)) {
> >>                         struct rq *rq =3D cpu_rq(i);
> >>                         struct cpuidle_state *idle =3D idle_get_state(=
rq);
> >> +                       s64 break_even =3D idle_get_break_even(rq);
> >> +
> >>                         if (idle && idle->exit_latency < min_exit_late=
ncy) {
> >>                                 /*
> >>                                  * We give priority to a CPU whose idl=
e state
> >> @@ -5817,10 +5820,21 @@ find_idlest_group_cpu(struct sched_group *grou=
p, struct task_struct *p, int this
> >>                                  * of any idle timestamp.
> >>                                  */
> >>                                 min_exit_latency =3D idle->exit_latenc=
y;
> >> +                               min_break_even =3D break_even;
> >>                                 latest_idle_timestamp =3D rq->idle_sta=
mp;
> >>                                 shallowest_idle_cpu =3D i;
> >> -                       } else if ((!idle || idle->exit_latency =3D=3D=
 min_exit_latency) &&
> >> -                                  rq->idle_stamp > latest_idle_timest=
amp) {
> >> +                       } else if ((idle && idle->exit_latency =3D=3D =
min_exit_latency) &&
> >> +                                  break_even < min_break_even) {
> >> +                               /*
> >> +                                * We give priority to the shallowest
> >> +                                * idle states with the minimal break
> >> +                                * even deadline to decrease the
> >> +                                * probability to choose a CPU which
> >> +                                * did not reach its break even yet
> >> +                                */
> >> +                               min_break_even =3D break_even;
> >> +                               shallowest_idle_cpu =3D i;
> >> +                       } else if (!idle && rq->idle_stamp > latest_id=
le_timestamp) {
> >>                                 /*
> >>                                  * If equal or no active idle state, t=
hen
> >>                                  * the most recently idled CPU might h=
ave
> >> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> >> index b743bf38f08f..3342e7bae072 100644
> >> --- a/kernel/sched/idle.c
> >> +++ b/kernel/sched/idle.c
> >> @@ -19,7 +19,13 @@ extern char __cpuidle_text_start[], __cpuidle_text_=
end[];
> >>   */
> >>  void sched_idle_set_state(struct cpuidle_state *idle_state)
> >>  {
> >> -       idle_set_state(this_rq(), idle_state);
> >> +       struct rq *rq =3D this_rq();
> >> +
> >> +       idle_set_state(rq, idle_state);
> >
> > Shouldn't the state be set after setting break even otherwise you will
> > have a time window with an idle_state !=3D null but the break_even stil=
l
> > set to the previous value
>
> IIUC we are protected in this section. Otherwise the routine above would
> be also wrong [if (idle && idle->exit_latency)], no?

no there are not the same because it uses the idle pointer to read
exit_latency so we are sure to use exit_latency related to the idle
pointer.

In your case it checks idle is not null but then it uses rq to read
break_even but it might not have been already updated

>
> >> +
> >> +       if (idle_state)
> >> +               idle_set_break_even(rq, ktime_get_ns() +
> >
> > What worries me a bit is that it adds one ktime_get call each time a
> > cpu enters idle
>
> Right, we can improve this in the future by folding the local_clock() in
> cpuidle when entering idle with this ktime_get.

Using local_clock() would be more latency friendly

>
> >> +                                   idle_state->exit_latency_ns);
> >>  }
>
> [ ... ]
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
