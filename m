Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA27AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 05:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99B98206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 05:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgFSFBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 01:01:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:14185 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgFSFBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 01:01:36 -0400
IronPort-SDR: MocMuL/9lNNc1ijMTHYSJ39gQs9Wxz5xuPIwlxtrhTe1J6DXtrsdhbbZnr4FejoMXHt7LPLmvn
 rN8+mO8cW8Zw==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="204331536"
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="scan'208";a="204331536"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 22:01:34 -0700
IronPort-SDR: WazQLo6m3SlU/AjORBRiflOgPm2Lt9diJX/sDwzGKeT1jjBOF85UWA+Wo4polTMx9xpzmmKI8s
 tNUInU+6Om3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="scan'208";a="262213168"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.249.171.195]) ([10.249.171.195])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jun 2020 22:01:30 -0700
Subject: Re: [LKP] [sched/fair] 070f5e860e: reaim.jobs_per_min -10.5%
 regression
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200319023819.GO11705@shao2-debian>
 <20200612110616.20264-1-hdanton@sina.com>
 <90f4036d-bb16-af67-8776-a2cbe67dfe7f@linux.intel.com>
 <20200615081041.GA16990@vingu-book>
 <d60343e9-b3a0-bdc7-84f4-e8c912f92c46@linux.intel.com>
 <20200616065432.GA18401@vingu-book>
 <3de4937b-1dcd-6d2e-836f-fed1c295dd7c@linux.intel.com>
 <20200617145725.GA12524@vingu-book> <20200617162558.GA3253@vingu-book>
 <451eabaf-c425-8e05-f5d4-3074c867cea6@linux.intel.com>
 <CAKfTPtCSGcx0_0b7PTWPNi9LnGqCCTpt4zswOBumVgr7CWAJbQ@mail.gmail.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <26e38288-8f7c-4c22-d0ca-7e9236e94c94@linux.intel.com>
Date:   Fri, 19 Jun 2020 13:01:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCSGcx0_0b7PTWPNi9LnGqCCTpt4zswOBumVgr7CWAJbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/18/2020 8:35 PM, Vincent Guittot wrote:
> On Thu, 18 Jun 2020 at 04:45, Xing Zhengjun
> <zhengjun.xing@linux.intel.com> wrote:
>>
>>
>>
> 
>>>>
>>>> This bench forks a new thread for each and every new step. But a newly forked
>>>> threads start with a load_avg and a runnable_avg set to max whereas the threads
>>>> are running shortly before exiting. This makes the CPU to be set overloaded in
>>>> some case whereas it isn't.
>>>>
>>>> Could you try the patch below ?
>>>> It fixes the problem on my setup (I have finally been able to reproduce the problem)
>>>>
>>>> ---
>>>>    kernel/sched/fair.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index 0aeffff62807..b33a4a9e1491 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -807,7 +807,7 @@ void post_init_entity_util_avg(struct task_struct *p)
>>>>               }
>>>>       }
>>>>
>>>> -    sa->runnable_avg = cpu_scale;
>>>> +    sa->runnable_avg = sa->util_avg;
>>>>
>>>>       if (p->sched_class != &fair_sched_class) {
>>>>               /*
>>>> --
>>>> 2.17.1
>>>>
>>>
>>> The patch above tries to move back to the group in the same classification as
>>> before but this could harm other benchmarks.
>>>
>>> There is another way to fix this by easing the migration of task in the case
>>> of migrate_util imbalance.
>>>
>>> Could you also try the patch below instead of the one above ?
>>>
>>> ---
>>>    kernel/sched/fair.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 0aeffff62807..fcaf66c4d086 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -7753,7 +7753,8 @@ static int detach_tasks(struct lb_env *env)
>>>                case migrate_util:
>>>                        util = task_util_est(p);
>>>
>>> -                     if (util > env->imbalance)
>>> +                     if (util/2 > env->imbalance &&
>>> +                         env->sd->nr_balance_failed <= env->sd->cache_nice_tries)
>>>                                goto next;
>>>
>>>                        env->imbalance -= util;
>>> --
>>> 2.17.1
>>>
>>>
>>
>> I apply the patch based on v5.7, the test result is as the following:
>>
>> =========================================================================================
>> tbox_group/testcase/rootfs/kconfig/compiler/runtime/nr_task/debug-setup/test/cpufreq_governor/ucode:
>>
>> lkp-ivb-d04/reaim/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/300s/100%/test/five_sec/performance/0x21
>>
>> commit:
>>     9f68395333ad7f5bfe2f83473fed363d4229f11c
>>     070f5e860ee2bf588c99ef7b4c202451faa48236
>>     v5.7
>>     69c81543653bf5f2c7105086502889fa019c15cb  (the test patch)
>>
>> 9f68395333ad7f5b 070f5e860ee2bf588c99ef7b4c2                        v5.7
>> 69c81543653bf5f2c7105086502
>> ---------------- --------------------------- ---------------------------
>> ---------------------------
>>            %stddev     %change         %stddev     %change
>> %stddev     %change         %stddev
>>                \          |                \          |                \
>>           |                \
>>         0.69           -10.3%       0.62            -9.1%       0.62
>>         -7.6%       0.63        reaim.child_systime
>>         0.62            -1.0%       0.61            +0.5%       0.62
>>         +1.9%       0.63        reaim.child_utime
>>        66870           -10.0%      60187            -7.6%      61787
>>         -5.9%      62947        reaim.jobs_per_min
> 
> There is an improvement but not at the same level as on my setup.
> I'm not sure with patch you tested here. Is it the last one that
> modify detach_tasks() or the previous one that modify
> post_init_entity_util_avg() ?
> 
It is the last one that modify detach_tasks().

> Could you also try the other one ? Both patches were improving results
> on y setup but the behavior doesn't seem to be the same on your setup.
> 

The test result for the other one has been sent in another mail.

> 
>>        16717           -10.0%      15046            -7.6%      15446
>>         -5.9%      15736        reaim.jobs_per_min_child
>>        97.84            -1.1%      96.75            -0.4%      97.43
>>         -0.4%      97.47        reaim.jti
>>        72000           -10.8%      64216            -8.3%      66000
>>         -5.7%      67885        reaim.max_jobs_per_min
>>         0.36           +10.6%       0.40            +7.8%       0.39
>>         +6.0%       0.38        reaim.parent_time
>>         1.58 ±  2%     +71.0%       2.70 ±  2%     +26.9%       2.01 ±
>> 2%     +23.6%       1.95 ±  3%  reaim.std_dev_percent
>>         0.00 ±  5%    +110.4%       0.01 ±  3%     +48.8%       0.01 ±
>> 7%     +43.2%       0.01 ±  5%  reaim.std_dev_time
>>        50800            -2.4%      49600            -1.6%      50000
>>         -0.8%      50400        reaim.workload
>>
>>
>>>>
>>>>
> ...
>>>>>>>
>>>>>>> --
>>>>>>> Zhengjun Xing
>>>>>
>>>>> --
>>>>> Zhengjun Xing
>>
>> --
>> Zhengjun Xing

-- 
Zhengjun Xing
