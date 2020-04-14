Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FE5C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B40DF20774
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437572AbgDNJUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 05:20:16 -0400
Received: from foss.arm.com ([217.140.110.172]:51518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728324AbgDNJUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 05:20:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3E6C1FB;
        Tue, 14 Apr 2020 02:20:09 -0700 (PDT)
Received: from [192.168.1.19] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28B823F6C4;
        Tue, 14 Apr 2020 02:20:07 -0700 (PDT)
Subject: Re: [PATCH 1/4] sched/topology: Store root domain CPU capacity sum
To:     Vincent Guittot <vincent.guittot@linaro.org>
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
References: <20200408095012.3819-1-dietmar.eggemann@arm.com>
 <20200408095012.3819-2-dietmar.eggemann@arm.com>
 <CAKfTPtC4_+dTddLdoFMdzUvsXwWyi3bUOXcg9kstC8RzZS_a+A@mail.gmail.com>
 <42cc3878-4c57-96ba-3ebd-1b4d4ef87fae@arm.com>
 <CAKfTPtDS_qwPH+TwoFWPz6QRzG1N=t46ZvGN=w6zbOtnGAdOeQ@mail.gmail.com>
 <d2ace353-cdf3-c22a-2b19-7fa33281fe27@arm.com>
 <CAKfTPtC2yQeBnm3QfCnZCo5jbAF7VYqFpBGDuzAkdUysc8yvrA@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <b34be03b-280b-e084-6bc3-552ee58917af@arm.com>
Date:   Tue, 14 Apr 2020 11:20:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtC2yQeBnm3QfCnZCo5jbAF7VYqFpBGDuzAkdUysc8yvrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.04.20 16:13, Vincent Guittot wrote:
> On Thu, 9 Apr 2020 at 15:50, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 08.04.20 19:03, Vincent Guittot wrote:
>>> On Wed, 8 Apr 2020 at 18:31, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>>
>>>> On 08.04.20 14:29, Vincent Guittot wrote:
>>>>> On Wed, 8 Apr 2020 at 11:50, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:

[...]

>> And it looks like that asym_cpu_capacity_level() [topology.c] would fail
>> if we would use capacity_orig_of() instead of arch_scale_cpu_capacity().
> 
> Yes I agree.  See below
> 
>> post_init_entity_util_avg() [fair.c] and sugov_get_util()
>> [cpufreq_schedutil.c] would be temporarily off until
>> update_cpu_capacity() has updated cpu_rq(cpu)->cpu_capacity_orig.
> 
> I think that we could even get rid of this update in
> update_cpu_capacity(). cpu_capacity_orig should be set while building
> the sched_domain topology because the topology itself is built based
> on this max cpu  capacity with asym_cpu_capacity_level(). So changing
> the capacity without rebuilding the domain could break the
> sched_domain topology correctness.

True. rq->cpu_capacity_orig could be set early in build_sched_domains(),
before the call to asym_cpu_capacity_level() or within this function.

> And we can't really set cpu_capacity_orig earlier during the boot
> because the capacity of b.L is set late during the boot and a rebuild
> of the sched_domain topology is then triggered.
> 
>>
>> compute_energy() [fair.c] is guarded by sched_energy_enabled() from
>> being used at startup.
>>
>> scale_rt_capacity() could be changed in case we call it after the
>> cpu_rq(cpu)->cpu_capacity_orig = arch_scale_cpu_capacity(cpu) in
>> update_cpu_capacity().
> 
> With the removal of the update in update_cpu_capacity(), we don't have
> a problem anymore, isn't it ?

True.

>> The Energy Model (and CPUfreq cooling) code would need
>> capacity_orig_of() exported. arch_scale_cpu_capacity() currently is
>> exported via include/linux/sched/topology.h.
> 
> Not sure that we need to export it outside scheduler, they can still
> use arch_scale_cpu_capacity()

OK, let's change this for the task scheduler only.

>> I guess Pelt and 'scale invariant Deadline bandwidth enforcement' should
>> continue using arch_scale_cpu_capacity() in sync with
>> arch_scale_freq_capacity().
> 
> Why can't they use capacity_orig_of ?
> we keep using arch_scale_freq_capacity() because it's dynamic but we
> don't really need to keep using arch_scale_cpu_capacity()

OK, Pelt is task scheduler so it can be changed here as well.

I'm going to create a patch following these ideas.

[...]
