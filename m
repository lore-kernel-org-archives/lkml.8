Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAACAC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 07:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BD520753
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 07:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oyO5r4S/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgCRHvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 03:51:22 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37582 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgCRHvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 03:51:22 -0400
Received: by mail-lf1-f67.google.com with SMTP id j11so19489738lfg.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 00:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=juWbiO75ljKtIvGcmG7GLzUlU68OypDsDpU61z33BU8=;
        b=oyO5r4S//56t97TZUbnFmDpoJ8MJA4LFhjiplp/VJyweoMs4KjbOfsE/DfaMAGUnmY
         sKlan1PMuzYjy09OK9WueQ6NYJERPc05OC1dCCwkIPmt8ZOaUmPJfuPM1f165HyUNgTm
         KUJCW7sJQNlld4/NiQsiqVuDNJzV7I0Xv7lUPKvLlL/wirtIb1BVhIO11vrDBsXy6QQO
         bEL6okCFxfM9G00wIJhmMcK//b9RH+codRo97a/2vtV6EOcbqAUHi0tA0NPZvkFEIu63
         0+52J0rYbj7HAwKOum6dKCI/5erUggbAW34eYSdFD32CZD4BXfvHv5VstYXzoS6pvG8L
         HcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=juWbiO75ljKtIvGcmG7GLzUlU68OypDsDpU61z33BU8=;
        b=aZ6ehTKku0gtaBHUhak1bipWZsQtmN4YIBs/q7iJggro7A5fR/lrsBeGMF6igk/Nlt
         B0NpJbwo1sD0pxghjEYoSdAU8OcYh3KEoLwZYTf3Tg82vI5l7w2Zyp+OKCxLnoCyGQK4
         8Ub8MUSaf7CQJIlqd8EAJyyPYNkIJFGjDhns38ru5064ZRY1Zi8lfgBcchN6gkTnAE9O
         0ACDvkXRHCyL8GTpeAQ4+ZdlIB6+dAlzEqSmmx7rGPTlqyXps/nzecTjPx/0XxeibK4T
         j3514QnnNRhKqshfOm+F93W+z164oQe1WPTAdoJk8CSEnoaq5UB9wUfKPphxtBhk92I5
         QwPw==
X-Gm-Message-State: ANhLgQ2pujlXs2wQWt5rdemzLTMR6YH6cuLgukRDUApvtAsHrWxgFxiO
        f1SvW9sDnkfmzfoMQu492qs7ky12RhCHc6pWK+6s+g==
X-Google-Smtp-Source: ADFU+vtNexqSTj06dks/2fciLcO50RGEr6KNPD6PSVxQ4ZvrTFv9jgtOYr9nKkY2k4ebYw2L8TyKwwfPE3te2gx45c8=
X-Received: by 2002:ac2:5de1:: with SMTP id z1mr2029359lfq.95.1584517875708;
 Wed, 18 Mar 2020 00:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200311202625.13629-1-daniel.lezcano@linaro.org>
 <CAKfTPtAqeHhVCeSgE1DsaGGkM6nY-9oAvGw_6zWvv1bKyE85JQ@mail.gmail.com>
 <e6e8ff94-64f2-6404-e332-2e030fc7e332@linaro.org> <20200317075607.GE10914@e105550-lin.cambridge.arm.com>
 <3520b762-08f5-0db8-30cb-372709188bb9@linaro.org> <20200317143053.GF10914@e105550-lin.cambridge.arm.com>
In-Reply-To: <20200317143053.GF10914@e105550-lin.cambridge.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 18 Mar 2020 08:51:04 +0100
Message-ID: <CAKfTPtD+aWcgjjK35x1LWKCNS_AVGm9sFoBXgqW_qL+oUSPMiw@mail.gmail.com>
Subject: Re: [PATCH V2] sched: fair: Use the earliest break even
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Mar 2020 at 15:30, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
>
> On Tue, Mar 17, 2020 at 02:48:51PM +0100, Daniel Lezcano wrote:
> >
> > Hi Morten,
> >
> > On 17/03/2020 08:56, Morten Rasmussen wrote:
> > > Hi Daniel,
> > >
> > > First, I think letting the scheduler know about desired minimum idle
> > > times is an interesting optimization if the overhead can be kept at a
> > > minimum. I do have a few comments about the patch though.
> > >
> > > On Thu, Mar 12, 2020 at 11:04:19AM +0100, Daniel Lezcano wrote:
> > >> On 12/03/2020 09:36, Vincent Guittot wrote:
> > >>> Hi Daniel,
> > >>>
> > >>> On Wed, 11 Mar 2020 at 21:28, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> > >>>>
> > >>>> In the idle CPU selection process occuring in the slow path via the
> > >>>> find_idlest_group_cpu() function, we pick up in priority an idle CPU
> > >>>> with the shallowest idle state otherwise we fall back to the least
> > >>>> loaded CPU.
> > >>>
> > >>> The idea makes sense but this path is only used by fork and exec so
> > >>> I'm not sure about the real impact
> > >>
> > >> I agree the fork / exec path is called much less often than the wake
> > >> path but it makes more sense for the decision.
> > >
> > > Looking at the flow in find_idlest_cpu(), AFAICT,
> > > find_idlest_group_cpu() is not actually making the final choice of CPU,
> > > so going through a lot of trouble there looking at idle states is
> > > pointless. Is there something I don't see?
> > >
> > > We fellow sd->child until groups == CPUs which which means that
> > > find_idlest_group() actually makes the final choice as the final group
> > > passed to find_idlest_group_cpu() is single-CPU group. The flow has been
> > > like that for years. Even before you added the initial idle-state
> > > awareness.
> > >
> > > I agree with Vincent, if this should really make a difference it should
> > > include wake-ups existing tasks too. Although I'm aware it would be a
> > > more invasive change. As said from the beginning, the idea is fine, but
> > > the current implementation should not make any measurable difference?
> >
> > I'm seeing the wake-ups path so sensitive, I'm not comfortable to do any
> > changes in it. That is the reason why the patch only changes the slow path.
>
> Right. I'm not against being cautious at all. It would be interesting to
> evaluate how bad it really is. The extra time-stamping business cost is
> the same, so it really down how much we dare to use the information in
> the fast-path and change the CPU selection policy. And of course, how
> much can be gained by the change.

Hmm... the fast path not even parses all idle CPUs right now so it
will be difficult to make any comparison. Regarding wakeup path, the
only place that could make sense IMO is the EAS slow wakeup path
find_energy_efficient_cpu() which mitigates performance vs energy
consumption

>
> >
> > >>>> In order to be more energy efficient but without impacting the
> > >>>> performances, let's use another criteria: the break even deadline.
> > >>>>
> > >>>> At idle time, when we store the idle state the CPU is entering in, we
> > >>>> compute the next deadline where the CPU could be woken up without
> > >>>> spending more energy to sleep.
> > >
> > > I don't follow the argument that sleeping longer should improve energy
> > > consumption.
> >
> > May be it is not explained correctly.
> >
> > The patch is about selecting a CPU with the smallest break even deadline
> > value. In a group of idle CPUs in the same idle state, we will pick the
> > one with the smallest break even dead line which is the one with the
> > highest probability it already reached its target residency.
> >
> > It is best effort.
>
> Indeed. I get what the patch does, I just don't see how the patch
> improves energy efficiency.
>
> >
> > > The patch doesn't affect the number of idle state
> > > enter/exit cycles, so you spend the amount of energy on those
> > > transitions. The main change is that idle time get spread out, so CPUs
> > > are less likely to be in the process of entering an idle state when they
> > > are asked to wake back up again.
> > >
> > > Isn't it fair to say that we expect the total number of wake-ups remains
> > > unchanged? Total busy and idle times across all CPUs should remain the
> > > same too? Unless chosen idle-state is changed, which I don't think we
> > > expect either, there should be no net effect on energy? The main benefit
> > > is reduced wake-up latency I think.
> > >
> > > Regarding chosen idle state, I'm wondering how this patch affects the
> > > cpuidle governor's idle state selection. Could the spreading of wake-ups
> > > trick governor to pick a shallower idle-state for some idle CPUs because
> > > we actively spread wake-ups rather than consolidating them? Just a
> > > thought.
> >
> > May be I missed the point, why are we spreading the tasks?
>
> Picking the CPU with the smallest break-even time-stamp means you pick
> the CPU that has been idle longest in the shallowest idle-state. If you
> periodically one-shot spawn tasks at a rate which is long enough that
> the shallowest state is the same for several CPUs, you would end up
> picking the least recently used CPU each time effectively spreading the
> wake-ups across all the CPUs in the same state.
>
> Thinking more about it, it might not be a real problem as if one of the
> CPUs suddenly choose a shallower idle-state, it would become the target
> all new tasks from that point onwards.
>
> > We are taking the decision on the same sched domain, no?
>
> I'm not sure I get the relation to the sched_domain?
>
> >
> > >>>> At the selection process, we use the shallowest CPU but in addition we
> > >>>> choose the one with the minimal break even deadline instead of relying
> > >>>> on the idle_timestamp. When the CPU is idle, the timestamp has less
> > >>>> meaning because the CPU could have wake up and sleep again several times
> > >>>> without exiting the idle loop. In this case the break even deadline is
> > >>>> more relevant as it increases the probability of choosing a CPU which
> > >>>> reached its break even.
> > >
> > > I guess you could improve the idle time stamping without adding the
> > > break-even time, they don't have to go together?
> >
> > Yes, we can add the idle start time when entering idle in the
> > cpuidle_enter function which is different from the idle_timestamp which
> > gives the idle task scheduling. I sent a RFC for that [1].
> >
> > However, each time we would like to inspect the deadline, we will have
> > to compute it, so IMO it makes more sense to pre-compute it when
> > entering idle in addition to the idle start.
> >
> > [1] https://lkml.org/lkml/2020/3/16/902
>
> Yes, I saw that patch too. Seems to make sense :-)
>
> >
> > >>>> Tested on:
> > >>>>  - a synquacer 24 cores, 6 sched domains
> > >>>>  - a hikey960 HMP 8 cores, 2 sched domains, with the EAS and energy probe
> > >>>>
> > >>>> sched/perf and messaging does not show a performance regression. Ran
> > >>>> 50 times schbench, adrestia and forkbench.
> > >>>>
> > >>>> The tools described at https://lwn.net/Articles/724935/
> > >>>>
> > >>>>  --------------------------------------------------------------
> > >>>> | Synquacer             | With break even | Without break even |
> > >>>>  --------------------------------------------------------------
> > >>>> | schbench *99.0th      |      14844.8    |         15017.6    |
> > >>>> | adrestia / periodic   |        57.95    |              57    |
> > >>>> | adrestia / single     |         49.3    |            55.4    |
> > >>>>  --------------------------------------------------------------
> > >>>
> > >>> Have you got some figures or cpuidle statistics for the syncquacer ?
> > >>
> > >> No, and we just noticed the syncquacer has a bug in the firmware and
> > >> does not actually go to the idle states.
> > >
> > > I would also like some statistics to help understanding what actually
> > > changes.
> > >
> > > I did some measurements on TX2, which only has one idle-state. I don't
> > > see the same trends as you do. adrestia single seems to be most affected
> > > by the patch, but _increases_ with the break_even patch rather than
> > > decrease. I don't trust adrestia too much though as the time resolution
> > > is low on TX2.
> > >
> > > TX2                 tip             break_even
> > > ----------------------------------------------------
> > > adrestia / single   5.21            5.51
> > > adrestia / periodic 5.75            5.67
> > > schbench 99.0th             45465.6         45376.0
> > > hackbench           27.9851         27.9775
> > >
> > > Notes:
> > > adrestia: Avg of 100 runs: adrestia -l 25000
> > > schbench: Avg of 10 runs: schbench -m16 -t64
> > > hackbench: Avg of 10 runs: hackbench -g 20 -T 256 -l 100000
> >
> > Thanks for testing. Is that a Jetson TX2 from Nvidia? If that is the
> > case, IIRC, it has some kind of switcher for the CPUs in the firmware, I
> > don't know how that can interact with the testing.
>
> Sorry, I should have been clearer. It is a ThunderX2. 2x 32-core (128
> threads) = 256 HW threads.
>
> Morten
