Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72546C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56C952076D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgEFPJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:09:31 -0400
Received: from foss.arm.com ([217.140.110.172]:38498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728428AbgEFPJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:09:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6725DD6E;
        Wed,  6 May 2020 08:09:30 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12E6A3F68F;
        Wed,  6 May 2020 08:09:25 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] sched/deadline: Add dl_bw_capacity()
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
References: <20200427083709.30262-1-dietmar.eggemann@arm.com>
 <20200427083709.30262-4-dietmar.eggemann@arm.com>
 <23bde551-0d91-4bfe-ce65-40af9fbfdef9@arm.com>
 <20200506123738.GJ17381@localhost.localdomain>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <d07a0517-b1bf-0879-575b-7933063c7597@arm.com>
Date:   Wed, 6 May 2020 17:09:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506123738.GJ17381@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2020 14:37, Juri Lelli wrote:
> On 06/05/20 12:54, Dietmar Eggemann wrote:
>> On 27/04/2020 10:37, Dietmar Eggemann wrote:

[...]

>> There is an issue w/ excl. cpusets and cpuset.sched_load_balance=0. The
>> latter is needed to demonstrate the problem since DL task affinity can't
>> be altered.
>>
>> A CPU in such a cpuset has its rq attached to def_root_domain which does
>> not have its 'sum_cpu_capacity' properly set.
> 
> Hummm, but if sched_load_balance is disabled it means that we've now got
> a subset of CPUs which (from a DL AC pow) are partitioned. So, I'd tend

Yes, the CPUs of the cpuset w/ cpuset.sched_load_balance=0 (cpuset B in
the example).

> to say that we actually want to check new tasks bw requirement against
> the available bandwidth of the particular CPU they happen to be running
> (and will continue to run) when setscheduler is called.

By 'available bandwidth of the particular CPU' you refer to
'\Sum_{cpu_rq(i)->rd->span} CPU capacity', right?

This is what this fix tries to achieve. Regardless whether cpu_rq(i)->rd
is a 'real' rd or the def_root_domain, dl_bw_capacity() will now always
return '\Sum_{cpu_rq(i)->rd->span} CPU capacity'

> If then load balance is enabled again, AC check we did above should
> still be valid for all tasks admitted in the meantime, no?
 
Example (w/ this fix) on Juno [L b b L L L], capacity_orig_of(L)=446 :

mkdir /sys/fs/cgroup/cpuset/A
echo 0 > /sys/fs/cgroup/cpuset/A/cpuset.mems
echo 1 > /sys/fs/cgroup/cpuset/A/cpuset.cpu_exclusive
echo 0-2 > /sys/fs/cgroup/cpuset/A/cpuset.cpus

mkdir /sys/fs/cgroup/cpuset/B
echo 0 > /sys/fs/cgroup/cpuset/B/cpuset.mems
echo 1 > /sys/fs/cgroup/cpuset/B/cpuset.cpu_exclusive
echo 3-5 > /sys/fs/cgroup/cpuset/B/cpuset.cpus

echo 0 > /sys/fs/cgroup/cpuset/B/cpuset.sched_load_balance
echo 0 > /sys/fs/cgroup/cpuset/cpuset.sched_load_balance

echo $$ > /sys/fs/cgroup/cpuset/B/tasks
chrt -d --sched-runtime 8000 --sched-period 16000 -p 0 $$

...
[  144.920102] __dl_bw_capacity CPU3 rd->span=3-5 return 1338
[  144.925607] sched_dl_overflow: [bash 1999] task_cpu(p)=3 cap=1338 cpus_ptr=3-5
[  144.932841] __dl_bw_capacity CPU3 rd->span=3-5 return 1338
...

echo 1 > /sys/fs/cgroup/cpuset/B/cpuset.sched_load_balance

echo $$ > /sys/fs/cgroup/cpuset/B/tasks
chrt -d --sched-runtime 8000 --sched-period 16000 -p 0 $$

...
[  254.367982] __dl_bw_capacity CPU5 rd->span=3-5 return 1338
[  254.373487] sched_dl_overflow: [bash 2052] task_cpu(p)=5 cap=1338 cpus_ptr=3-5
[  254.380721] __dl_bw_capacity CPU5 rd->span=3-5 return 1338
...

Regardless of 'B/cpuset.sched_load_balance'
'\Sum_{cpu_rq(i)->rd->span} CPU capacity' stays 1338 (3*446)

So IMHO, DL AC check stays intact.
