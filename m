Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00ECC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D0DF206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgELMjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 08:39:19 -0400
Received: from foss.arm.com ([217.140.110.172]:54178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgELMjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:39:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BB6F30E;
        Tue, 12 May 2020 05:39:17 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F05103F71E;
        Tue, 12 May 2020 05:39:14 -0700 (PDT)
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
 <d07a0517-b1bf-0879-575b-7933063c7597@arm.com>
 <20200511080122.GI264022@localhost.localdomain>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <204d67f1-a21c-9d71-9b76-6f1a11c89092@arm.com>
Date:   Tue, 12 May 2020 14:39:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511080122.GI264022@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2020 10:01, Juri Lelli wrote:
> On 06/05/20 17:09, Dietmar Eggemann wrote:
>> On 06/05/2020 14:37, Juri Lelli wrote:
>>> On 06/05/20 12:54, Dietmar Eggemann wrote:
>>>> On 27/04/2020 10:37, Dietmar Eggemann wrote:

[...]

>>> to say that we actually want to check new tasks bw requirement against
>>> the available bandwidth of the particular CPU they happen to be running
>>> (and will continue to run) when setscheduler is called.
>>
>> By 'available bandwidth of the particular CPU' you refer to
>> '\Sum_{cpu_rq(i)->rd->span} CPU capacity', right?
> 
> No. I was referring to the single CPU capacity. The capacity of the CPU
> where a task is running when setscheduler is called for it (and DL AC
> performed). See below, maybe more clear why I wondered about this case..

OK, got it! I was just confused since I don't think that this patch
introduced the issue.

Before the patch 'int cpus = dl_bw_cpus(task_cpu(p))' was used which
returns the number of cpus on the (default) rd (n). So for a single CPU
(1024) we use n*1024.

I wonder if a fix for that should be part of this patch-set?

[...]

>> ...
>> [  144.920102] __dl_bw_capacity CPU3 rd->span=3-5 return 1338
>> [  144.925607] sched_dl_overflow: [bash 1999] task_cpu(p)=3 cap=1338 cpus_ptr=3-5
> 
> So, here you are checking new task bw against 1338 which is 3*L
> capacity. However, since load balance is disabled at this point for 3-5,
> once admitted the task will only be able to run on CPU 3. Now, if more
> tasks on CPU 3 are admitted the same way (up to 1338) I believe they
> will start to experience deadline misses because only 446 will be
> actually available to them until load balance is enabled below and they
> are then free to migrate to CPUs 4 and 5.
> 
> Does it makes sense?

Yes, it does.

So my first idea was to only consider the CPU (i.e. its CPU capacity) in
case we detect 'cpu_rq(cpu)->rd == def_root_domain'?

In case I re-enable load-balancing on cpuset '/', we can't make a task
in cpuset 'B' DL since we hit this in __sched_setscheduler():

4931           /*
4932            * Don't allow tasks with an affinity mask smaller than
4933            * the entire root_domain to become SCHED_DEADLINE.
...
4935            */
4936            if (!cpumask_subset(span, p->cpus_ptr) || ...

root@juno:~# echo 1 > /sys/fs/cgroup/cpuset/cpuset.sched_load_balance
root@juno:~# echo $$ > /sys/fs/cgroup/cpuset/B/tasks
root@juno:~# chrt -d --sched-runtime 8000 --sched-period 16000 -p 0 $$
chrt: failed to set pid 2316's policy: Operation not permitted

So this task has to leave 'B' first I assume.

[...]
