Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02770C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D78ED2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgDQOzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 10:55:39 -0400
Received: from foss.arm.com ([217.140.110.172]:52328 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbgDQOzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:55:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 708FD30E;
        Fri, 17 Apr 2020 07:55:38 -0700 (PDT)
Received: from [192.168.1.19] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A3EA3F73D;
        Fri, 17 Apr 2020 07:55:35 -0700 (PDT)
Subject: Re: [PATCH 2/4] sched/deadline: Improve admission control for
 asymmetric CPU capacities
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        luca abeni <luca.abeni@santannapisa.it>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
References: <20200408095012.3819-1-dietmar.eggemann@arm.com>
 <20200408095012.3819-3-dietmar.eggemann@arm.com> <jhjeesyw96u.mognet@arm.com>
 <20200408153032.447e098d@nowhere> <jhjblo2vx60.mognet@arm.com>
 <31620965-e1e7-6854-ad46-8192ee4b41af@arm.com>
 <20200417121945.GM9767@localhost.localdomain>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <8734b37e-5602-79dc-c7a8-c41fd9eb86b5@arm.com>
Date:   Fri, 17 Apr 2020 16:55:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200417121945.GM9767@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.04.20 14:19, Juri Lelli wrote:
> On 09/04/20 19:29, Dietmar Eggemann wrote:

[...]

>> Maybe we can do a hybrid. We have rd->span and rd->sum_cpu_capacity and
>> with the help of an extra per-cpu cpumask we could just
> 
> Hummm, I like the idea, but
> 
>> DEFINE_PER_CPU(cpumask_var_t, dl_bw_mask);
>>
>> dl_bw_cpus(int i) {
> 
> This works if calls are always local to the rd we are interested into
> (argument 'i' isn't used). Are we always doing that?

I thought so. The existing dl_bw_cpus(int i) implementation already
assumes this by using:

    struct root_domain *rd = cpu_rq(i)->rd;

    ...

    for_each_cpu_and(i, rd->span, cpu_active_mask)

Or did you refer to something else here?

And the patch would not introduce new places in which we call
dl_bw_cpus(). It will just replace some with a dl_bw_capacity() call.

>>     struct cpumask *cpus = this_cpu_cpumask_var_ptr(dl_bw_mask);
>>     ...
>>     cpumask_and(cpus, rd->span, cpu_active_mask);
>>
>>     return cpumask_weight(cpus);
>> }
>>
>> and
>>
>> dl_bw_capacity(int i) {
>>
>>     struct cpumask *cpus = this_cpu_cpumask_var_ptr(dl_bw_mask);
>>     ...
>>     cpumask_and(cpus, rd->span, cpu_active_mask);
>>     if (cpumask_equal(cpus, rd->span))
>>         return rd->sum_cpu_capacity;
> 
> What if capacities change between invocations (with the same span)?
> Can that happen?

The CPU capacity should only change during initial bring-up. On
asymmetric CPU capacity systems we have to re-create the Sched Domain
(SD) topology after CPUfreq becomes available.

After the initial build and this first rebuild of the SD topology, the
CPU capacity should be stable.

Everything which might follow afterwards (starting EAS, exclusive
cpusets or CPU hp) will not change the CPU capacity.

Obviously, if you defer loading CPUfreq driver after you started DL
scheduling you can break things. But this is not considered a valid
environment here.

[...]
