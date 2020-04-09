Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40246C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC8720857
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kYetJAgd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgDIOOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 10:14:15 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44563 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgDIOOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 10:14:14 -0400
Received: by mail-lf1-f66.google.com with SMTP id 131so7977355lfh.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 07:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4S3HX591o8/xcYJ4XU8XYvNjiwmEXUx35NNSt95/Fjc=;
        b=kYetJAgd6bjPTJ2QgJ3rcqCBlnniSqZ4/o3Dc8YagTnpRM4BbGIUttUIzP+qt5ML51
         4Z63bOY09q66wVz+cnbKMPcsw9xfMaaUObwm0UnaU9hFQBeb8SE3CkTJWf7Fk0EevzSd
         3x5tiR4mfVQ4kbyQOvh66/fub84dDSc0MeywPd95loch/hvD2L9VGWar5TLZRKeQI9dF
         UtPTguasOGyA79CzwySGjPL21/ENR8hu92yYfMKooIHJrJop7dy4oY5uByG5zi40GZL1
         vIjtlkMEwJkH0XbviAkFpZEp49/Ae83IlRCR330ga3xN+cRa87ful08JuygEC6AlkJIN
         rN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4S3HX591o8/xcYJ4XU8XYvNjiwmEXUx35NNSt95/Fjc=;
        b=ZeyOsh/T7Gbz05sZcteu4CunebOex0XXHcajRMjKqTFT6iC/bD9tT3gplUrriKxRYd
         nTQnNz2cGJeLDjTQ4VyTdfOutNBcPINxJW87ocxh/jKWpP1F0btmVnn1WBvDzmElx6jw
         G+jsfr4ZNyP3ZOzQPlmeWe1TAD9AcAxqCHAaZL6OOn48Urb/rxuRs/j7VvWl7j+b2kSa
         vXoz6ZNaX212pF+S+vvsaR8Cs2x/z6P1xxKSfuyc2UOFzBpeG5/jLGWObyEwHVj3m691
         vzpj3T8cgj6NyLNiqSlIZCoadasbaWn/ig/FKRJxMiOKCdh4D/O1BuegH5vaO2AqkG8n
         2CyA==
X-Gm-Message-State: AGi0PuYelJTuiGSD/5qd55j6UjIsw7EqJUAfPIn5GgxQVgM10GRlQM16
        zStPlzG6SuPtA9K3kuHzZzfR4Al8cKTopGNlm4HU+g==
X-Google-Smtp-Source: APiQypKNi0LWihelHszoaqeBuoMWnuGVQl8HOpaT7mbJs2HgDRsirbzBuMY3YB7LqurF0OfU/qYr8vT4dOW4XxsVt2Q=
X-Received: by 2002:ac2:46f9:: with SMTP id q25mr7996813lfo.149.1586441652020;
 Thu, 09 Apr 2020 07:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200408095012.3819-1-dietmar.eggemann@arm.com>
 <20200408095012.3819-2-dietmar.eggemann@arm.com> <CAKfTPtC4_+dTddLdoFMdzUvsXwWyi3bUOXcg9kstC8RzZS_a+A@mail.gmail.com>
 <42cc3878-4c57-96ba-3ebd-1b4d4ef87fae@arm.com> <CAKfTPtDS_qwPH+TwoFWPz6QRzG1N=t46ZvGN=w6zbOtnGAdOeQ@mail.gmail.com>
 <d2ace353-cdf3-c22a-2b19-7fa33281fe27@arm.com>
In-Reply-To: <d2ace353-cdf3-c22a-2b19-7fa33281fe27@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 9 Apr 2020 16:13:58 +0200
Message-ID: <CAKfTPtC2yQeBnm3QfCnZCo5jbAF7VYqFpBGDuzAkdUysc8yvrA@mail.gmail.com>
Subject: Re: [PATCH 1/4] sched/topology: Store root domain CPU capacity sum
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Apr 2020 at 15:50, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 08.04.20 19:03, Vincent Guittot wrote:
> > On Wed, 8 Apr 2020 at 18:31, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 08.04.20 14:29, Vincent Guittot wrote:
> >>> On Wed, 8 Apr 2020 at 11:50, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> [...]
> >>
> >>>>  /**
> >>>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> >>>> index 8344757bba6e..74b0c0fa4b1b 100644
> >>>> --- a/kernel/sched/topology.c
> >>>> +++ b/kernel/sched/topology.c
> >>>> @@ -2052,12 +2052,17 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
> >>>>         /* Attach the domains */
> >>>>         rcu_read_lock();
> >>>>         for_each_cpu(i, cpu_map) {
> >>>> +               unsigned long cap = arch_scale_cpu_capacity(i);
> >>>
> >>> Why do you replace the use of rq->cpu_capacity_orig by
> >>> arch_scale_cpu_capacity(i) ?
> >>> There is nothing about this change in the commit message
> >>
> >> True. And I can change this back.
> >>
> >> It seems though that the solution is not sufficient because of the
> >> 'rd->span &nsub cpu_active_mask' issue discussed under patch 2/4.
> >>ap
> >> But this remind me of another question I have.
> >>
> >> Currently we use arch_scale_cpu_capacity() more often (16 times) than
> >> capacity_orig_of()/rq->cpu_capacity_orig .
> >>
> >> What's hindering us to remove rq->cpu_capacity_orig and the code around
> >> it and solely rely on arch_scale_cpu_capacity()? I mean the arch
> >> implementation should be fast.
> >
> > Or we can do the opposite and only use capacity_orig_of()/rq->cpu_capacity_orig.
> >
> > Is there a case where the max cpu capacity changes over time ? So I
> > would prefer to use cpu_capacity_orig which is a field of scheduler
> > instead of always calling an external arch specific function
>
> I see. So far it only changes during startup.
>
> And it looks like that asym_cpu_capacity_level() [topology.c] would fail
> if we would use capacity_orig_of() instead of arch_scale_cpu_capacity().

Yes I agree.  See below

>
> post_init_entity_util_avg() [fair.c] and sugov_get_util()
> [cpufreq_schedutil.c] would be temporarily off until
> update_cpu_capacity() has updated cpu_rq(cpu)->cpu_capacity_orig.

I think that we could even get rid of this update in
update_cpu_capacity(). cpu_capacity_orig should be set while building
the sched_domain topology because the topology itself is built based
on this max cpu  capacity with asym_cpu_capacity_level(). So changing
the capacity without rebuilding the domain could break the
sched_domain topology correctness.

And we can't really set cpu_capacity_orig earlier during the boot
because the capacity of b.L is set late during the boot and a rebuild
of the sched_domain topology is then triggered.

>
> compute_energy() [fair.c] is guarded by sched_energy_enabled() from
> being used at startup.
>
> scale_rt_capacity() could be changed in case we call it after the
> cpu_rq(cpu)->cpu_capacity_orig = arch_scale_cpu_capacity(cpu) in
> update_cpu_capacity().

With the removal of the update in update_cpu_capacity(), we don't have
a problem anymore, isn't it ?

>
> The Energy Model (and CPUfreq cooling) code would need
> capacity_orig_of() exported. arch_scale_cpu_capacity() currently is
> exported via include/linux/sched/topology.h.

Not sure that we need to export it outside scheduler, they can still
use arch_scale_cpu_capacity()

>
> I guess Pelt and 'scale invariant Deadline bandwidth enforcement' should
> continue using arch_scale_cpu_capacity() in sync with
> arch_scale_freq_capacity().

Why can't they use capacity_orig_of ?
we keep using arch_scale_freq_capacity() because it's dynamic but we
don't really need to keep using arch_scale_cpu_capacity()

>
> IMHO it's hard to give clear advice when to use the one or the other.
>
> We probably don't want to set cpu_rq(cpu)->cpu_capacity_orig in the arch
> cpu scale setter. We have arch_scale_cpu_capacity() to decouple that.

Yes I agree
