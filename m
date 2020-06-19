Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFF5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A1B220DD4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgFSE4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 00:56:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:33224 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728181AbgFSE4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 00:56:01 -0400
IronPort-SDR: 5w/42+9C1zbZ0d3k60e3JQunuUSxUhxPnwhMXs4u45tW8tyMI3DRspVSmbvXrC6eDD+hyWpyP1
 0Os+Whdn2VtQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="123089724"
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="scan'208";a="123089724"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 21:55:57 -0700
IronPort-SDR: v6RRaB8YurYok2hJc1mGhV4tqtqB/y//kNTUTPHO1V/eDPnwRirdV+BfN6SeiS9QytCJl1iFPG
 WbsBLJqd7zgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="scan'208";a="262211947"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.249.171.195]) ([10.249.171.195])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jun 2020 21:55:54 -0700
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
 <20200617145725.GA12524@vingu-book>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <987fd281-cf22-c17f-b156-4b6f904c5a5b@linux.intel.com>
Date:   Fri, 19 Jun 2020 12:55:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200617145725.GA12524@vingu-book>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/17/2020 10:57 PM, Vincent Guittot wrote:
> Le mercredi 17 juin 2020 à 08:30:21 (+0800), Xing Zhengjun a écrit :
>>
>>
>> On 6/16/2020 2:54 PM, Vincent Guittot wrote:
>>>
>>> Hi Xing,
>>>
>>> Le mardi 16 juin 2020 à 11:17:16 (+0800), Xing Zhengjun a écrit :
>>>>
>>>>
>>>> On 6/15/2020 4:10 PM, Vincent Guittot wrote:
>>>>> Hi Xing,
>>>>>
>>>>> Le lundi 15 juin 2020 à 15:26:59 (+0800), Xing Zhengjun a écrit :
>>>>>>
>>>>>>
>>>>>> On 6/12/2020 7:06 PM, Hillf Danton wrote:
>>>>>>>
>>>>>>> On Fri, 12 Jun 2020 14:36:49 +0800 Xing Zhengjun wrote:
>>>>>
>>>
>>> ...
>>>
>>>>>
>>>>
>>>> I apply the patch based on v5.7, the test result is as the following:
>>>
>>> TBH, I didn't expect that the results would still be bad, so i wonder if the threshold are
>>> the root problem.
>>>
>>> Could you run tests with the patch below that removes condition with runnable_avg ?
>>> I just want to make sure that those 2 conditions are the root cause.
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index da3e5b54715b..f5774d0af059 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -8210,10 +8210,6 @@ group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
>>>           if (sgs->sum_nr_running < sgs->group_weight)
>>>                   return true;
>>>
>>> -       if ((sgs->group_capacity * imbalance_pct) <
>>> -                       (sgs->group_runnable * 100))
>>> -               return false;
>>> -
>>>           if ((sgs->group_capacity * 100) >
>>>                           (sgs->group_util * imbalance_pct))
>>>                   return true;
>>> @@ -8239,10 +8235,6 @@ group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
>>>                           (sgs->group_util * imbalance_pct))
>>>                   return true;
>>>
>>> -       if ((sgs->group_capacity * imbalance_pct) <
>>> -                       (sgs->group_runnable * 100))
>>> -               return true;
>>> -
>>>           return false;
>>>    }
>>>
>>>
>>>
>>> Thanks.
>>> Vincent
>>>
>>
>>
>> I apply the patch based on v5.7, the test result is as the following:
>>
>> =========================================================================================
>> tbox_group/testcase/rootfs/kconfig/compiler/runtime/nr_task/debug-setup/test/cpufreq_governor/ucode:
>>
>> lkp-ivb-d04/reaim/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/300s/100%/test/five_sec/performance/0x21
>>
>> commit:
>>    9f68395333ad7f5bfe2f83473fed363d4229f11c
>>    070f5e860ee2bf588c99ef7b4c202451faa48236
>>    v5.7
>>    63a5d0fbb5ec62f5148c251c01e709b8358cd0ee (the test patch)
>>
>> 9f68395333ad7f5b 070f5e860ee2bf588c99ef7b4c2                        v5.7
>> 63a5d0fbb5ec62f5148c251c01e
>> ---------------- --------------------------- ---------------------------
>> ---------------------------
>>           %stddev     %change         %stddev     %change %stddev     %change
>> %stddev
>>               \          |                \          |                \
>> |                \
>>        0.69           -10.3%       0.62            -9.1%       0.62
>> +1.0%       0.69        reaim.child_systime
>>        0.62            -1.0%       0.61            +0.5%       0.62
>> -0.1%       0.62        reaim.child_utime
>>       66870           -10.0%      60187            -7.6%      61787
>> +1.1%      67636        reaim.jobs_per_min
>>       16717           -10.0%      15046            -7.6%      15446
>> +1.1%      16909        reaim.jobs_per_min_child
> 
> OK. So the regression disappears when the conditions on runnable_avg are removed.
> 
> In the meantime, I have been able to understand more deeply what was happeningi
> for this bench and how it is impacted by
>    commit: 070f5e860ee2 ("sched/fair: Take into account runnable_avg to classify group")
> 
> This bench forks a new thread for each and every new step. But a newly forked
> threads start with a load_avg and a runnable_avg set to max whereas the threads
> are running shortly before exiting. This makes the CPU to be set overloaded in
> some case whereas it isn't.
> 
> Could you try the patch below ?
> It fixes the problem on my setup (I have finally been able to reproduce the problem)
> 
> ---
>   kernel/sched/fair.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0aeffff62807..b33a4a9e1491 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -807,7 +807,7 @@ void post_init_entity_util_avg(struct task_struct *p)
>   		}
>   	}
>   
> -	sa->runnable_avg = cpu_scale;
> +	sa->runnable_avg = sa->util_avg;
>   
>   	if (p->sched_class != &fair_sched_class) {
>   		/*
> 

I apply the patch above based on v5.7, the test result is as the following:

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/runtime/nr_task/debug-setup/test/cpufreq_governor/ucode:
 
lkp-ivb-d04/reaim/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/300s/100%/test/five_sec/performance/0x21

commit:
   9f68395333ad7f5bfe2f83473fed363d4229f11c
   070f5e860ee2bf588c99ef7b4c202451faa48236
   v5.7
   cbb4d668e7431479a7978fa79d64c2271adefab0 ( the test patch which modify
post_init_entity_util_avg())

9f68395333ad7f5b 070f5e860ee2bf588c99ef7b4c2                        v5.7 
cbb4d668e7431479a7978fa79d6
---------------- --------------------------- --------------------------- 
---------------------------
          %stddev     %change         %stddev     %change 
%stddev     %change         %stddev
              \          |                \          |                \ 
         |                \
       0.69           -10.3%       0.62            -9.1%       0.62 
       +0.6%       0.69        reaim.child_systime
       0.62            -1.0%       0.61            +0.5%       0.62 
       -0.3%       0.62        reaim.child_utime
      66870           -10.0%      60187            -7.6%      61787 
       +0.7%      67335        reaim.jobs_per_min
      16717           -10.0%      15046            -7.6%      15446 
       +0.7%      16833        reaim.jobs_per_min_child
      97.84            -1.1%      96.75            -0.4%      97.43 
       +0.2%      98.05        reaim.jti
      72000           -10.8%      64216            -8.3%      66000 
       +0.0%      72000        reaim.max_jobs_per_min
       0.36           +10.6%       0.40            +7.8%       0.39 
       -0.6%       0.36        reaim.parent_time
       1.58 ±  2%     +71.0%       2.70 ±  2%     +26.9%       2.01 ± 
2%      -8.8%       1.44 ±  2%  reaim.std_dev_percent
       0.00 ±  5%    +110.4%       0.01 ±  3%     +48.8%       0.01 ± 
7%     -24.6%       0.00 ±  7%  reaim.std_dev_time
      50800            -2.4%      49600            -1.6%      50000 
       +0.0%      50800        reaim.workload


-- 
Zhengjun Xing
