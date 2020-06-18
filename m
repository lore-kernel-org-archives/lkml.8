Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BITCOIN_SPAM_02,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BTC_ID,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0CBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A9BC21534
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387846AbgFRCp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:45:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:53268 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728699AbgFRCpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 22:45:12 -0400
IronPort-SDR: Ux7dnncKW/DR8W3iYQuEqc71TxZsNcb+j3u5WOlvIhpzyMwSWVdwJKym4dbJOLxSohgmYoAOdP
 Rqk55AtJ2Mvw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 19:45:07 -0700
IronPort-SDR: vpicNZtjBybqYaFOP44BICPVKXb3Pvn9De0zl/oFkhlVn6TxJ21knTXZDAFMHRPK7DEkd0T4dd
 1COwYAtbAjBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,524,1583222400"; 
   d="scan'208";a="291623926"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.238.6.47]) ([10.238.6.47])
  by orsmga002.jf.intel.com with ESMTP; 17 Jun 2020 19:45:02 -0700
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
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <451eabaf-c425-8e05-f5d4-3074c867cea6@linux.intel.com>
Date:   Thu, 18 Jun 2020 10:45:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200617162558.GA3253@vingu-book>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/18/2020 12:25 AM, Vincent Guittot wrote:
> Le mercredi 17 juin 2020 à 16:57:25 (+0200), Vincent Guittot a écrit :
>> Le mercredi 17 juin 2020 à 08:30:21 (+0800), Xing Zhengjun a écrit :
>>>
>>>
>>> On 6/16/2020 2:54 PM, Vincent Guittot wrote:
>>>>
>>>> Hi Xing,
>>>>
>>>> Le mardi 16 juin 2020 à 11:17:16 (+0800), Xing Zhengjun a écrit :
>>>>>
>>>>>
>>>>> On 6/15/2020 4:10 PM, Vincent Guittot wrote:
>>>>>> Hi Xing,
>>>>>>
>>>>>> Le lundi 15 juin 2020 à 15:26:59 (+0800), Xing Zhengjun a écrit :
>>>>>>>
>>>>>>>
>>>>>>> On 6/12/2020 7:06 PM, Hillf Danton wrote:
>>>>>>>>
>>>>>>>> On Fri, 12 Jun 2020 14:36:49 +0800 Xing Zhengjun wrote:
>>>>>>
>>>>
>>>> ...
>>>>
> ...
>>>
>>> I apply the patch based on v5.7, the test result is as the following:
>>>
>>> =========================================================================================
>>> tbox_group/testcase/rootfs/kconfig/compiler/runtime/nr_task/debug-setup/test/cpufreq_governor/ucode:
>>>
>>> lkp-ivb-d04/reaim/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/300s/100%/test/five_sec/performance/0x21
>>>
>>> commit:
>>>    9f68395333ad7f5bfe2f83473fed363d4229f11c
>>>    070f5e860ee2bf588c99ef7b4c202451faa48236
>>>    v5.7
>>>    63a5d0fbb5ec62f5148c251c01e709b8358cd0ee (the test patch)
>>>
>>> 9f68395333ad7f5b 070f5e860ee2bf588c99ef7b4c2                        v5.7
>>> 63a5d0fbb5ec62f5148c251c01e
>>> ---------------- --------------------------- ---------------------------
>>> ---------------------------
>>>           %stddev     %change         %stddev     %change %stddev     %change
>>> %stddev
>>>               \          |                \          |                \
>>> |                \
>>>        0.69           -10.3%       0.62            -9.1%       0.62
>>> +1.0%       0.69        reaim.child_systime
>>>        0.62            -1.0%       0.61            +0.5%       0.62
>>> -0.1%       0.62        reaim.child_utime
>>>       66870           -10.0%      60187            -7.6%      61787
>>> +1.1%      67636        reaim.jobs_per_min
>>>       16717           -10.0%      15046            -7.6%      15446
>>> +1.1%      16909        reaim.jobs_per_min_child
>>
>> OK. So the regression disappears when the conditions on runnable_avg are removed.
>>
>> In the meantime, I have been able to understand more deeply what was happeningi
>> for this bench and how it is impacted by
>>    commit: 070f5e860ee2 ("sched/fair: Take into account runnable_avg to classify group")
>>
>> This bench forks a new thread for each and every new step. But a newly forked
>> threads start with a load_avg and a runnable_avg set to max whereas the threads
>> are running shortly before exiting. This makes the CPU to be set overloaded in
>> some case whereas it isn't.
>>
>> Could you try the patch below ?
>> It fixes the problem on my setup (I have finally been able to reproduce the problem)
>>
>> ---
>>   kernel/sched/fair.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 0aeffff62807..b33a4a9e1491 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -807,7 +807,7 @@ void post_init_entity_util_avg(struct task_struct *p)
>>   		}
>>   	}
>>   
>> -	sa->runnable_avg = cpu_scale;
>> +	sa->runnable_avg = sa->util_avg;
>>   
>>   	if (p->sched_class != &fair_sched_class) {
>>   		/*
>> -- 
>> 2.17.1
>>
> 
> The patch above tries to move back to the group in the same classification as
> before but this could harm other benchmarks.
> 
> There is another way to fix this by easing the migration of task in the case
> of migrate_util imbalance.
> 
> Could you also try the patch below instead of the one above ?
> 
> ---
>   kernel/sched/fair.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0aeffff62807..fcaf66c4d086 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7753,7 +7753,8 @@ static int detach_tasks(struct lb_env *env)
>   		case migrate_util:
>   			util = task_util_est(p);
> 
> -			if (util > env->imbalance)
> +			if (util/2 > env->imbalance &&
> +			    env->sd->nr_balance_failed <= env->sd->cache_nice_tries)
>   				goto next;
> 
>   			env->imbalance -= util;
> --
> 2.17.1
> 
> 

I apply the patch based on v5.7, the test result is as the following:

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/runtime/nr_task/debug-setup/test/cpufreq_governor/ucode:
 
lkp-ivb-d04/reaim/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/300s/100%/test/five_sec/performance/0x21

commit:
   9f68395333ad7f5bfe2f83473fed363d4229f11c
   070f5e860ee2bf588c99ef7b4c202451faa48236
   v5.7
   69c81543653bf5f2c7105086502889fa019c15cb  (the test patch)

9f68395333ad7f5b 070f5e860ee2bf588c99ef7b4c2                        v5.7 
69c81543653bf5f2c7105086502
---------------- --------------------------- --------------------------- 
---------------------------
          %stddev     %change         %stddev     %change 
%stddev     %change         %stddev
              \          |                \          |                \ 
         |                \
       0.69           -10.3%       0.62            -9.1%       0.62 
       -7.6%       0.63        reaim.child_systime
       0.62            -1.0%       0.61            +0.5%       0.62 
       +1.9%       0.63        reaim.child_utime
      66870           -10.0%      60187            -7.6%      61787 
       -5.9%      62947        reaim.jobs_per_min
      16717           -10.0%      15046            -7.6%      15446 
       -5.9%      15736        reaim.jobs_per_min_child
      97.84            -1.1%      96.75            -0.4%      97.43 
       -0.4%      97.47        reaim.jti
      72000           -10.8%      64216            -8.3%      66000 
       -5.7%      67885        reaim.max_jobs_per_min
       0.36           +10.6%       0.40            +7.8%       0.39 
       +6.0%       0.38        reaim.parent_time
       1.58 ±  2%     +71.0%       2.70 ±  2%     +26.9%       2.01 ± 
2%     +23.6%       1.95 ±  3%  reaim.std_dev_percent
       0.00 ±  5%    +110.4%       0.01 ±  3%     +48.8%       0.01 ± 
7%     +43.2%       0.01 ±  5%  reaim.std_dev_time
      50800            -2.4%      49600            -1.6%      50000 
       -0.8%      50400        reaim.workload


>>
>>
>>>       97.84            -1.1%      96.75            -0.4%      97.43
>>> +0.3%      98.09        reaim.jti
>>>       72000           -10.8%      64216            -8.3%      66000
>>> +0.0%      72000        reaim.max_jobs_per_min
>>>        0.36           +10.6%       0.40            +7.8%       0.39
>>> -1.1%       0.36        reaim.parent_time
>>>        1.58 ±  2%     +71.0%       2.70 ±  2%     +26.9%       2.01 ± 2%
>>> -11.9%       1.39 ±  4%  reaim.std_dev_percent
>>>        0.00 ±  5%    +110.4%       0.01 ±  3%     +48.8%       0.01 ± 7%
>>> -27.3%       0.00 ± 15%  reaim.std_dev_time
>>>       50800            -2.4%      49600            -1.6%      50000
>>> +0.0%      50800        reaim.workload
>>>
>>>
>>>>>
>>>>> =========================================================================================
>>>>> tbox_group/testcase/rootfs/kconfig/compiler/runtime/nr_task/debug-setup/test/cpufreq_governor/ucode:
>>>>>
>>>>> lkp-ivb-d04/reaim/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/300s/100%/test/five_sec/performance/0x21
>>>>>
>>>>> commit:
>>>>>     9f68395333ad7f5bfe2f83473fed363d4229f11c
>>>>>     070f5e860ee2bf588c99ef7b4c202451faa48236
>>>>>     v5.7
>>>>>     3e1643da53f3fc7414cfa3ad2a16ab2a164b7f4d (the test patch)
>>>>>
>>>>> 9f68395333ad7f5b 070f5e860ee2bf588c99ef7b4c2                        v5.7
>>>>> 3e1643da53f3fc7414cfa3ad2a1
>>>>> ---------------- --------------------------- ---------------------------
>>>>> ---------------------------
>>>>>            %stddev     %change         %stddev     %change %stddev     %change
>>>>> %stddev
>>>>>                \          |                \          |                \
>>>>> |                \
>>>>>         0.69           -10.3%       0.62            -9.1%       0.62
>>>>> -7.1%       0.64        reaim.child_systime
>>>>>         0.62            -1.0%       0.61            +0.5%       0.62
>>>>> +1.3%       0.63        reaim.child_utime
>>>>>        66870           -10.0%      60187            -7.6%      61787
>>>>> -6.1%      62807        reaim.jobs_per_min
>>>>>        16717           -10.0%      15046            -7.6%      15446
>>>>> -6.1%      15701        reaim.jobs_per_min_child
>>>>>        97.84            -1.1%      96.75            -0.4%      97.43
>>>>> -0.5%      97.34        reaim.jti
>>>>>        72000           -10.8%      64216            -8.3%      66000
>>>>> -5.7%      67885        reaim.max_jobs_per_min
>>>>>         0.36           +10.6%       0.40            +7.8%       0.39
>>>>> +6.9%       0.38        reaim.parent_time
>>>>>         1.58 ±  2%     +71.0%       2.70 ±  2%     +26.9%       2.01 ± 2%
>>>>> +32.5%       2.09 ±  6%  reaim.std_dev_percent
>>>>>         0.00 ±  5%    +110.4%       0.01 ±  3%     +48.8%       0.01 ± 7%
>>>>> +61.7%       0.01 ±  8%  reaim.std_dev_time
>>>>>        50800            -2.4%      49600            -1.6%      50000
>>>>> -1.3%      50133        reaim.workload
>>>>>
>>>>>
>>>>>>>
>>>>>>> =========================================================================================
>>>>>>> tbox_group/testcase/rootfs/kconfig/compiler/runtime/nr_task/debug-setup/test/cpufreq_governor/ucode:
>>>>>>>
>>>>>>> lkp-ivb-d04/reaim/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/300s/100%/test/five_sec/performance/0x21
>>>>>>>
>>>>>>> commit:
>>>>>>>      9f68395333ad7f5bfe2f83473fed363d4229f11c
>>>>>>>      070f5e860ee2bf588c99ef7b4c202451faa48236
>>>>>>>      v5.7
>>>>>>>      6b33257768b8dd3982054885ea310871be2cfe0b (Hillf's patch)
>>>>>>>
>>>>>>> 9f68395333ad7f5b 070f5e860ee2bf588c99ef7b4c2                        v5.7
>>>>>>> 6b33257768b8dd3982054885ea3
>>>>>>> ---------------- --------------------------- ---------------------------
>>>>>>> ---------------------------
>>>>>>>             %stddev     %change         %stddev     %change %stddev     %change
>>>>>>> %stddev
>>>>>>>                 \          |                \          |                \
>>>>>>> |                \
>>>>>>>          0.69           -10.3%       0.62            -9.1%       0.62
>>>>>>> -10.1%       0.62        reaim.child_systime
>>>>>>>          0.62            -1.0%       0.61            +0.5%       0.62
>>>>>>> +0.3%       0.62        reaim.child_utime
>>>>>>>         66870           -10.0%      60187            -7.6%      61787
>>>>>>> -8.3%      61305        reaim.jobs_per_min
>>>>>>>         16717           -10.0%      15046            -7.6%      15446
>>>>>>> -8.3%      15326        reaim.jobs_per_min_child
>>>>>>>         97.84            -1.1%      96.75            -0.4%      97.43
>>>>>>> -0.5%      97.37        reaim.jti
>>>>>>>         72000           -10.8%      64216            -8.3%      66000
>>>>>>> -8.3%      66000        reaim.max_jobs_per_min
>>>>>>>          0.36           +10.6%       0.40            +7.8%       0.39
>>>>>>> +9.4%       0.39        reaim.parent_time
>>>>>>>          1.58 ±  2%     +71.0%       2.70 ±  2%     +26.9%       2.01 ± 2%
>>>>>>> +33.2%       2.11        reaim.std_dev_percent
>>>>>>>          0.00 ±  5%    +110.4%       0.01 ±  3%     +48.8%       0.01 ± 7%
>>>>>>> +65.3%       0.01 ±  3%  reaim.std_dev_time
>>>>>>>         50800            -2.4%      49600            -1.6%      50000
>>>>>>> -1.8%      49866        reaim.workload
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> -- 
>>>>>>> Zhengjun Xing
>>>>>
>>>>> -- 
>>>>> Zhengjun Xing
>>>
>>> -- 
>>> Zhengjun Xing

-- 
Zhengjun Xing
