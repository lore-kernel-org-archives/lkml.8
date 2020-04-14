Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A53C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F215D2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390892AbgDNO2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 10:28:45 -0400
Received: from foss.arm.com ([217.140.110.172]:56916 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390874AbgDNO2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:28:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4027630E;
        Tue, 14 Apr 2020 07:28:16 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 426843F73D;
        Tue, 14 Apr 2020 07:28:14 -0700 (PDT)
References: <20200408095012.3819-1-dietmar.eggemann@arm.com> <20200408095012.3819-3-dietmar.eggemann@arm.com> <jhjeesyw96u.mognet@arm.com> <20200408153032.447e098d@nowhere> <jhjblo2vx60.mognet@arm.com> <31620965-e1e7-6854-ad46-8192ee4b41af@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     luca abeni <luca.abeni@santannapisa.it>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] sched/deadline: Improve admission control for asymmetric CPU capacities
In-reply-to: <31620965-e1e7-6854-ad46-8192ee4b41af@arm.com>
Date:   Tue, 14 Apr 2020 15:28:08 +0100
Message-ID: <jhjzhbervk7.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/04/20 18:29, Dietmar Eggemann wrote:
>> Well it is indeed the case, but sadly it's not an atomic step - AFAICT with
>> cpusets we do hold some cpuset lock when calling __dl_overflow() and when
>> rebuilding the domains, but not when fiddling with the active mask.
>>
>> I just realized it's even more obvious for dl_cpu_busy(): IIUC it is meant
>> to prevent the removal of a CPU if it would lead to a DL overflow - it
>> works now because the active mask is modified before it gets called, but
>> here it breaks because it's called before the sched_domain rebuild.
>>
>> Perhaps re-computing the root domain capacity sum at every dl_bw_cpus()
>> call would be simpler. It's a bit more work, but then we already have a
>> for_each_cpu_*() loop, and we only rely on the masks being correct.
>
> Maybe we can do a hybrid. We have rd->span and rd->sum_cpu_capacity and
> with the help of an extra per-cpu cpumask we could just
>
> DEFINE_PER_CPU(cpumask_var_t, dl_bw_mask);
>
> dl_bw_cpus(int i) {
>
>     struct cpumask *cpus = this_cpu_cpumask_var_ptr(dl_bw_mask);
>     ...
>     cpumask_and(cpus, rd->span, cpu_active_mask);
>
>     return cpumask_weight(cpus);

+1 on making this use cpumask_weight() :)

> }
>
> and
>
> dl_bw_capacity(int i) {
>
>     struct cpumask *cpus = this_cpu_cpumask_var_ptr(dl_bw_mask);
>     ...
>     cpumask_and(cpus, rd->span, cpu_active_mask);
>     if (cpumask_equal(cpus, rd->span))
>         return rd->sum_cpu_capacity;
>
>     for_each_cpu(i, cpus)
>         cap += capacity_orig_of(i);
>
>     return cap;
> }
>
> So only in cases in which rd->span and cpu_active_mask differ we would
> have to sum up again.

I think this might just work. In the "stable" case (i.e. not racing with
hotplug), we can use the value cached in the root_domain. Otherwise we'll
detect the mismatch between the cpumask and the root_domain (i.e. CPU
active but not yet included in root_domain, or CPU !active but still
included in root_domain).
