Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CFEC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FC8F20757
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgD2Rjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:39:55 -0400
Received: from foss.arm.com ([217.140.110.172]:42940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgD2Rjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:39:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 295241045;
        Wed, 29 Apr 2020 10:39:54 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADD6A3F73D;
        Wed, 29 Apr 2020 10:39:51 -0700 (PDT)
Subject: Re: [PATCH v2 6/6] sched/deadline: Implement fallback mechanism for
 !fit case
To:     luca abeni <luca.abeni@santannapisa.it>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
References: <20200427083709.30262-1-dietmar.eggemann@arm.com>
 <20200427083709.30262-7-dietmar.eggemann@arm.com>
 <20200427133438.GA6469@localhost.localdomain>
 <20200427161715.3dd3a148@nowhere>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <57e4846a-4e54-5450-8167-768f021250f7@arm.com>
Date:   Wed, 29 Apr 2020 19:39:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427161715.3dd3a148@nowhere>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2020 16:17, luca abeni wrote:
> Hi Juri,
> 
> On Mon, 27 Apr 2020 15:34:38 +0200
> Juri Lelli <juri.lelli@redhat.com> wrote:
> 
>> Hi,
>>
>> On 27/04/20 10:37, Dietmar Eggemann wrote:
>>> From: Luca Abeni <luca.abeni@santannapisa.it>
>>>
>>> When a task has a runtime that cannot be served within the
>>> scheduling deadline by any of the idle CPU (later_mask) the task is
>>> doomed to miss its deadline.
>>>
>>> This can happen since the SCHED_DEADLINE admission control
>>> guarantees only bounded tardiness and not the hard respect of all
>>> deadlines. In this case try to select the idle CPU with the largest
>>> CPU capacity to minimize tardiness.
>>>
>>> Signed-off-by: Luca Abeni <luca.abeni@santannapisa.it>
>>> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> [...]
>>> -		if (!cpumask_empty(later_mask))
>>> -			return 1;
>>> +		if (cpumask_empty(later_mask))
>>> +			cpumask_set_cpu(max_cpu, later_mask);  
>>
>> Think we touched upon this during v1 review, but I'm (still?)
>> wondering if we can do a little better, still considering only free
>> cpus.
>>
>> Can't we get into a situation that some of the (once free) big cpus
>> have been occupied by small tasks and now a big task enters the
>> system and it only finds small cpus available, were it could have fit
>> into bigs if small tasks were put onto small cpus?
>>
>> I.e., shouldn't we always try to best fit among free cpus?
> 
> Yes; there was an additional patch that tried schedule each task on the
> slowest core where it can fit, to address this issue.
> But I think it will go in a second round of patches.

Yes, we can run into this situation in DL, but also in CFS or RT.

IMHO, this patch is aligned with the Capacity Awareness implementation
in CFS and RT.

Capacity Awareness so far is 'find a CPU which fits the requirement of
the task (Req)'. It's not (yet) find the best CPU.

CFS - select_idle_capacity() -> task_fits_capacity()

      Req: util(p) * 1.25 < capacity_of(cpu)

RT  - select_task_rq_rt(), cpupri_find_fitness() ->
      rt_task_fits_capacity()

      Req: uclamp_eff_value(p) <= capacity_orig_of(cpu)

DL  - select_task_rq_dl(), cpudl_find() -> dl_task_fits_capacity()

      Req: dl_runtime(p)/dl_deadline(p) * 1024  <= capacity_orig_of(cpu)


There has to be an "idle" (from the viewpoint of the task) CPU available
with a fitting capacity. Otherwise a fallback mechanism applies.

CFS - best capacity handling in select_idle_capacity().

RT  - Non-fitting lowest mask

DL  - This patch

You did spot the rt-app 'delay' for the small tasks in the test case ;-)
