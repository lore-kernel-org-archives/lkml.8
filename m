Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BITCOIN_SPAM_02,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BTC_ID,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6329C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 05:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B2FD206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 05:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgFSFKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 01:10:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:12796 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgFSFKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 01:10:43 -0400
IronPort-SDR: G09xyFuLaDcCu6zrT3HgNewCvWiG0tDrv+51phiDkmbVtgwQcY25Ja2XSTXHOEb7ipZ/Vm8pXS
 0OwVzFNYevDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="142771419"
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="scan'208";a="142771419"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 22:10:42 -0700
IronPort-SDR: s0S1kvFy3vSbVqgzffNTugeJs7m19fSRyjifR17ilUSn11wfa9KSgtdRTxHUxKWQ0YE5sBHCUO
 XlLnS82OADqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="scan'208";a="262214778"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.249.171.195]) ([10.249.171.195])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jun 2020 22:10:38 -0700
Subject: Re: [LKP] [sched/fair] 070f5e860e: reaim.jobs_per_min -10.5%
 regression
To:     Hillf Danton <hdanton@sina.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
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
 <20200618082406.8292-1-hdanton@sina.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <efce710a-5cf2-4b53-c69d-40cf37483c8d@linux.intel.com>
Date:   Fri, 19 Jun 2020 13:10:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200618082406.8292-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/18/2020 4:24 PM, Hillf Danton wrote:
> 
> On Thu, 18 Jun 2020 10:45:01 +0800 Xing Zhengjun wrote:
>> On 6/18/2020 12:25 AM, Vincent Guittot wrote:
>>> Le mercredi 17 juin 2020 à 16:57:25 (+0200), Vincent Guittot a écrit :
>>>> Le mercredi 17 juin 2020 à 08:30:21 (+0800), Xing Zhengjun a écrit :
>>>>>
>>>>>
>>>>> On 6/16/2020 2:54 PM, Vincent Guittot wrote:
>>>>>>
>>>>>> Hi Xing,
>>>>>>
>>>>>> Le mardi 16 juin 2020 à 11:17:16 (+0800), Xing Zhengjun a écrit :
>>>>>>>
>>>>>>>
>>>>>>> On 6/15/2020 4:10 PM, Vincent Guittot wrote:
>>>>>>>> Hi Xing,
>>>>>>>>
>>>>>>>> Le lundi 15 juin 2020 à 15:26:59 (+0800), Xing Zhengjun a écrit :
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 6/12/2020 7:06 PM, Hillf Danton wrote:
>>>>>>>>>>
>>>>>>>>>> On Fri, 12 Jun 2020 14:36:49 +0800 Xing Zhengjun wrote:
>>>>>>>>
>>>>>>
>>>>>> ...
>>>>>>
>>> ...
>>>>>
>>>>> I apply the patch based on v5.7, the test result is as the following:
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
>>>>>     63a5d0fbb5ec62f5148c251c01e709b8358cd0ee (the test patch)
>>>>>
>>>>> 9f68395333ad7f5b 070f5e860ee2bf588c99ef7b4c2                        v5.7
>>>>> 63a5d0fbb5ec62f5148c251c01e
>>>>> ---------------- --------------------------- ---------------------------
>>>>> ---------------------------
>>>>>            %stddev     %change         %stddev     %change %stddev     %change
>>>>> %stddev
>>>>>                \          |                \          |                \
>>>>> |                \
>>>>>         0.69           -10.3%       0.62            -9.1%       0.62
>>>>> +1.0%       0.69        reaim.child_systime
>>>>>         0.62            -1.0%       0.61            +0.5%       0.62
>>>>> -0.1%       0.62        reaim.child_utime
>>>>>        66870           -10.0%      60187            -7.6%      61787
>>>>> +1.1%      67636        reaim.jobs_per_min
>>>>>        16717           -10.0%      15046            -7.6%      15446
>>>>> +1.1%      16909        reaim.jobs_per_min_child
>>>>
>>>> OK. So the regression disappears when the conditions on runnable_avg are removed.
>>>>
>>>> In the meantime, I have been able to understand more deeply what was happeningi
>>>> for this bench and how it is impacted by
>>>>     commit: 070f5e860ee2 ("sched/fair: Take into account runnable_avg to classify group")
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
>>>>    		}
>>>>    	}
>>>>    
>>>> -	sa->runnable_avg = cpu_scale;
>>>> +	sa->runnable_avg = sa->util_avg;
>>>>    
>>>>    	if (p->sched_class != &fair_sched_class) {
>>>>    		/*
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
>>>    		case migrate_util:
>>>    			util = task_util_est(p);
>>>
>>> -			if (util > env->imbalance)
>>> +			if (util/2 > env->imbalance &&
>>> +			    env->sd->nr_balance_failed <= env->sd->cache_nice_tries)
>>>    				goto next;
> 
> Hmm... this sheds a shaft of light on computing imbalance for
> migrate_util, see below.
> 
>>>
>>>    			env->imbalance -= util;
>>> --
>>> 2.17.1
>>>
>>>
>>
>> I apply the patch based on v5.7, the test result is as the following:
> 
> Thanks.
> 
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
>>>>>        97.84            -1.1%      96.75            -0.4%      97.43
>>>>> +0.3%      98.09        reaim.jti
>>>>>        72000           -10.8%      64216            -8.3%      66000
>>>>> +0.0%      72000        reaim.max_jobs_per_min
>>>>>         0.36           +10.6%       0.40            +7.8%       0.39
>>>>> -1.1%       0.36        reaim.parent_time
>>>>>         1.58 ±  2%     +71.0%       2.70 ±  2%     +26.9%       2.01 ± 2%
>>>>> -11.9%       1.39 ±  4%  reaim.std_dev_percent
>>>>>         0.00 ±  5%    +110.4%       0.01 ±  3%     +48.8%       0.01 ± 7%
>>>>> -27.3%       0.00 ± 15%  reaim.std_dev_time
>>>>>        50800            -2.4%      49600            -1.6%      50000
>>>>> +0.0%      50800        reaim.workload
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
>>>>>>>      3e1643da53f3fc7414cfa3ad2a16ab2a164b7f4d (the test patch)
>>>>>>>
>>>>>>> 9f68395333ad7f5b 070f5e860ee2bf588c99ef7b4c2                        v5.7
>>>>>>> 3e1643da53f3fc7414cfa3ad2a1
>>>>>>> ---------------- --------------------------- ---------------------------
>>>>>>> ---------------------------
>>>>>>>             %stddev     %change         %stddev     %change %stddev     %change
>>>>>>> %stddev
>>>>>>>                 \          |                \          |                \
>>>>>>> |                \
>>>>>>>          0.69           -10.3%       0.62            -9.1%       0.62
>>>>>>> -7.1%       0.64        reaim.child_systime
>>>>>>>          0.62            -1.0%       0.61            +0.5%       0.62
>>>>>>> +1.3%       0.63        reaim.child_utime
>>>>>>>         66870           -10.0%      60187            -7.6%      61787
>>>>>>> -6.1%      62807        reaim.jobs_per_min
>>>>>>>         16717           -10.0%      15046            -7.6%      15446
>>>>>>> -6.1%      15701        reaim.jobs_per_min_child
>>>>>>>         97.84            -1.1%      96.75            -0.4%      97.43
>>>>>>> -0.5%      97.34        reaim.jti
>>>>>>>         72000           -10.8%      64216            -8.3%      66000
>>>>>>> -5.7%      67885        reaim.max_jobs_per_min
>>>>>>>          0.36           +10.6%       0.40            +7.8%       0.39
>>>>>>> +6.9%       0.38        reaim.parent_time
>>>>>>>          1.58 ±  2%     +71.0%       2.70 ±  2%     +26.9%       2.01 ± 2%
>>>>>>> +32.5%       2.09 ±  6%  reaim.std_dev_percent
>>>>>>>          0.00 ±  5%    +110.4%       0.01 ±  3%     +48.8%       0.01 ± 7%
>>>>>>> +61.7%       0.01 ±  8%  reaim.std_dev_time
>>>>>>>         50800            -2.4%      49600            -1.6%      50000
>>>>>>> -1.3%      50133        reaim.workload
>>>>>>>
>>>>>>>
>>>>>>>>>
>>>>>>>>> =========================================================================================
>>>>>>>>> tbox_group/testcase/rootfs/kconfig/compiler/runtime/nr_task/debug-setup/test/cpufreq_governor/ucode:
>>>>>>>>>
>>>>>>>>> lkp-ivb-d04/reaim/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/300s/100%/test/five_sec/performance/0x21
>>>>>>>>>
>>>>>>>>> commit:
>>>>>>>>>       9f68395333ad7f5bfe2f83473fed363d4229f11c
>>>>>>>>>       070f5e860ee2bf588c99ef7b4c202451faa48236
>>>>>>>>>       v5.7
>>>>>>>>>       6b33257768b8dd3982054885ea310871be2cfe0b (Hillf's patch)
>>>>>>>>>
>>>>>>>>> 9f68395333ad7f5b 070f5e860ee2bf588c99ef7b4c2                        v5.7
>>>>>>>>> 6b33257768b8dd3982054885ea3
>>>>>>>>> ---------------- --------------------------- ---------------------------
>>>>>>>>> ---------------------------
>>>>>>>>>              %stddev     %change         %stddev     %change %stddev     %change
>>>>>>>>> %stddev
>>>>>>>>>                  \          |                \          |                \
>>>>>>>>> |                \
>>>>>>>>>           0.69           -10.3%       0.62            -9.1%       0.62
>>>>>>>>> -10.1%       0.62        reaim.child_systime
>>>>>>>>>           0.62            -1.0%       0.61            +0.5%       0.62
>>>>>>>>> +0.3%       0.62        reaim.child_utime
>>>>>>>>>          66870           -10.0%      60187            -7.6%      61787
>>>>>>>>> -8.3%      61305        reaim.jobs_per_min
>>>>>>>>>          16717           -10.0%      15046            -7.6%      15446
>>>>>>>>> -8.3%      15326        reaim.jobs_per_min_child
>>>>>>>>>          97.84            -1.1%      96.75            -0.4%      97.43
>>>>>>>>> -0.5%      97.37        reaim.jti
>>>>>>>>>          72000           -10.8%      64216            -8.3%      66000
>>>>>>>>> -8.3%      66000        reaim.max_jobs_per_min
>>>>>>>>>           0.36           +10.6%       0.40            +7.8%       0.39
>>>>>>>>> +9.4%       0.39        reaim.parent_time
>>>>>>>>>           1.58 ±  2%     +71.0%       2.70 ±  2%     +26.9%       2.01 ± 2%
>>>>>>>>> +33.2%       2.11        reaim.std_dev_percent
>>>>>>>>>           0.00 ±  5%    +110.4%       0.01 ±  3%     +48.8%       0.01 ± 7%
>>>>>>>>> +65.3%       0.01 ±  3%  reaim.std_dev_time
>>>>>>>>>          50800            -2.4%      49600            -1.6%      50000
>>>>>>>>> -1.8%      49866        reaim.workload
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> -- 
>>>>>>>>> Zhengjun Xing
>>>>>>>
>>>>>>> -- 
>>>>>>> Zhengjun Xing
>>>>>
>>>>> -- 
>>>>> Zhengjun Xing
>>
>> -- 
>> Zhengjun Xing
> 
> 
> This is not for testing. Compute imbalance for migrate_util with both
> groups taken into account, aiming at making every one fully busy, a
> state which cannot be measured without the help of imbalance_pct.
> 
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8995,17 +8995,32 @@ static inline void calculate_imbalance(s
>   	 */
>   	if (local->group_type == group_has_spare) {
>   		if (busiest->group_type > group_fully_busy) {
> +			unsigned long cap, util;
> +			unsigned int imbalance_pct = env->sd->imbalance_pct;
> +
> +			if (local->group_capacity *100 >
> +			    local->group_util * imbalance_pct)
> +				cap = (local->group_capacity *100 -
> +					local->group_util * imbalance_pct) /100;
> +			else
> +				cap = 0;
> +
> +			if (cap != 0 && busiest->group_util * imbalance_pct >
> +					busiest->group_capacity *100)
> +				util = (busiest->group_util * imbalance_pct -
> +					busiest->group_capacity *100) /100;
> +			else
> +				util = 0;
>   			/*
>   			 * If busiest is overloaded, try to fill spare
>   			 * capacity. This might end up creating spare capacity
>   			 * in busiest or busiest still being overloaded but
> -			 * there is no simple way to directly compute the
> +			 * there is no simpler way to directly compute the
>   			 * amount of load to migrate in order to balance the
> -			 * system.
> +			 * system than trying to make both groups fully busy.
>   			 */
>   			env->migration_type = migrate_util;
> -			env->imbalance = max(local->group_capacity, local->group_util) -
> -					 local->group_util;
> +			env->imbalance = min(cap, util);
>   
>   			/*
>   			 * In some cases, the group's utilization is max or even
> 

I also test the above patch, the test result is as the following:
=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/runtime/nr_task/debug-setup/test/cpufreq_governor/ucode:
 
lkp-ivb-d04/reaim/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/300s/100%/test/five_sec/performance/0x21

commit:
   9f68395333ad7f5bfe2f83473fed363d4229f11c
   070f5e860ee2bf588c99ef7b4c202451faa48236
   v5.7
   dc2401de2e8cdc180f7d55cc1cdaee4136054680 (the above test patch)

9f68395333ad7f5b 070f5e860ee2bf588c99ef7b4c2                        v5.7 
dc2401de2e8cdc180f7d55cc1cd
---------------- --------------------------- --------------------------- 
---------------------------
          %stddev     %change         %stddev     %change 
%stddev     %change         %stddev
              \          |                \          |                \ 
         |                \
       0.69           -10.3%       0.62            -9.1%       0.62 
       -8.2%       0.63        reaim.child_systime
       0.62            -1.0%       0.61            +0.5%       0.62 
       +1.1%       0.63        reaim.child_utime
      66870           -10.0%      60187            -7.6%      61787 
       -7.4%      61897        reaim.jobs_per_min
      16717           -10.0%      15046            -7.6%      15446 
       -7.4%      15474        reaim.jobs_per_min_child
      97.84            -1.1%      96.75            -0.4%      97.43 
       -0.5%      97.31        reaim.jti
      72000           -10.8%      64216            -8.3%      66000 
       -8.3%      66000        reaim.max_jobs_per_min
       0.36           +10.6%       0.40            +7.8%       0.39 
       +8.8%       0.39        reaim.parent_time
       1.58 ±  2%     +71.0%       2.70 ±  2%     +26.9%       2.01 ± 
2%     +33.7%       2.11 ±  6%  reaim.std_dev_percent
       0.00 ±  5%    +110.4%       0.01 ±  3%     +48.8%       0.01 ± 
7%     +61.6%       0.01 ±  5%  reaim.std_dev_time
      50800            -2.4%      49600            -1.6%      50000 
       -1.6%      50000        reaim.workload



-- 
Zhengjun Xing
