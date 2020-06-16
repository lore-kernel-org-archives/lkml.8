Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA10C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 03:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D93F20756
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 03:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgFPDYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 23:24:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:45063 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgFPDYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 23:24:11 -0400
IronPort-SDR: 7g+TqdEpebwwRu88C7EDr81CHfFKVhcmtQO4WPZm6pVEs9gXqyhmCeC2Ezg+smasFzBeIgPWwd
 EcTA0tQErT+Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 20:24:09 -0700
IronPort-SDR: smSxOip7oC84in6WwC7JecIm2zrW8Vl3b8HXJBSnFSPbaENNbpaeMTHkLVC/13gBJzcHKfl2DJ
 jeNto8eGoC0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,517,1583222400"; 
   d="scan'208";a="261289503"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.238.6.47]) ([10.238.6.47])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jun 2020 20:24:06 -0700
Subject: Re: [LKP] [sched/fair] 070f5e860e: reaim.jobs_per_min -10.5%
 regression
To:     Hillf Danton <hdanton@sina.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
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
 <20200615151030.6480-1-hdanton@sina.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <67688436-4855-2b0c-ac24-e2095b6ec073@linux.intel.com>
Date:   Tue, 16 Jun 2020 11:24:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615151030.6480-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/2020 11:10 PM, Hillf Danton wrote:
> 
> On Mon, 15 Jun 2020 10:10:41 +0200 Vincent Guittot wrote:
>> Le lundi 15 juin 2020 15:26:59 (+0800), Xing Zhengjun a crit :
>>>
>>> On 6/12/2020 7:06 PM, Hillf Danton wrote:
>>>>
>>>> On Fri, 12 Jun 2020 14:36:49 +0800 Xing Zhengjun wrote:
>>
>> ...
>>
>>> I apply the patch based on v5.7, the regression still existed.
>>
>> Thanks for the test.
> 
> Thanks.
> 
>> I don't know if it's relevant or not but the results seem a bit
>> better with the patch and I'd like to check that it's only a matter of threshold to
>> fix the problem.
>>
>> Could you try the patch below which is quite aggressive but will help to confirm this ?
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 28be1c984a42..3c51d557547b 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -8322,10 +8322,13 @@ static inline int sg_imbalanced(struct sched_group *group)
>>   static inline bool
>>   group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
>>   {
>> +       unsigned long imb;
>> +
>>          if (sgs->sum_nr_running < sgs->group_weight)
>>                  return true;
>>
>> -       if ((sgs->group_capacity * imbalance_pct) <
>> +       imb = sgs->sum_nr_running * 100;
>> +       if ((sgs->group_capacity * imb) <
>>                          (sgs->group_runnable * 100))
>>                  return false;
>>
>> @@ -8347,6 +8350,8 @@ group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
>>   static inline bool
>>   group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
>>   {
>> +       unsigned long imb;
>> +
>>          if (sgs->sum_nr_running <= sgs->group_weight)
>>                  return false;
>>
>> @@ -8354,7 +8359,8 @@ group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
>>                          (sgs->group_util * imbalance_pct))
>>                  return true;
>>
>> -       if ((sgs->group_capacity * imbalance_pct) <
>> +       imb = sgs->sum_nr_running * 100;
>> +       if ((sgs->group_capacity * imb) <
>>                          (sgs->group_runnable * 100))
>>                  return true;
>>
>>
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
>>>    6b33257768b8dd3982054885ea310871be2cfe0b (Hillf's patch)
>>>
>>> 9f68395333ad7f5b 070f5e860ee2bf588c99ef7b4c2                        v5.7
>>> 6b33257768b8dd3982054885ea3
>>> ---------------- --------------------------- ---------------------------
>>> ---------------------------
>>>           %stddev     %change         %stddev     %change %stddev     %change
>>> %stddev
>>>               \          |                \          |                \
>>> |                \
>>>        0.69           -10.3%       0.62            -9.1%       0.62
>>> -10.1%       0.62        reaim.child_systime
>>>        0.62            -1.0%       0.61            +0.5%       0.62
>>> +0.3%       0.62        reaim.child_utime
>>>       66870           -10.0%      60187            -7.6%      61787
>>> -8.3%      61305        reaim.jobs_per_min
>>>       16717           -10.0%      15046            -7.6%      15446
>>> -8.3%      15326        reaim.jobs_per_min_child
>>>       97.84            -1.1%      96.75            -0.4%      97.43
>>> -0.5%      97.37        reaim.jti
>>>       72000           -10.8%      64216            -8.3%      66000
>>> -8.3%      66000        reaim.max_jobs_per_min
>>>        0.36           +10.6%       0.40            +7.8%       0.39
>>> +9.4%       0.39        reaim.parent_time
>>>        1.58   2%     +71.0%       2.70   2%     +26.9%       2.01  2%
>>> +33.2%       2.11        reaim.std_dev_percent
>>>        0.00   5%    +110.4%       0.01   3%     +48.8%       0.01  7%
>>> +65.3%       0.01   3%  reaim.std_dev_time
>>>       50800            -2.4%      49600            -1.6%      50000
>>> -1.8%      49866        reaim.workload
>>>
> 
> Following the introduction of runnable_avg there came a gap between it
> and util, and it can be supposedly filled up by determining the pivot
> point using the imb percent. The upside is that no heuristic is added.
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8215,15 +8215,8 @@ group_has_capacity(unsigned int imbalanc
>   	if (sgs->sum_nr_running < sgs->group_weight)
>   		return true;
>   
> -	if ((sgs->group_capacity * imbalance_pct) <
> -			(sgs->group_runnable * 100))
> -		return false;
> -
> -	if ((sgs->group_capacity * 100) >
> -			(sgs->group_util * imbalance_pct))
> -		return true;
> -
> -	return false;
> +	return sgs->group_capacity * imbalance_pct >
> +		(sgs->group_util + sgs->group_runnable) *50;
>   }
>   
>   /*
> @@ -8240,15 +8233,8 @@ group_is_overloaded(unsigned int imbalan
>   	if (sgs->sum_nr_running <= sgs->group_weight)
>   		return false;
>   
> -	if ((sgs->group_capacity * 100) <
> -			(sgs->group_util * imbalance_pct))
> -		return true;
> -
> -	if ((sgs->group_capacity * imbalance_pct) <
> -			(sgs->group_runnable * 100))
> -		return true;
> -
> -	return false;
> +	return sgs->group_capacity * imbalance_pct <
> +		(sgs->group_util + sgs->group_runnable) *50;
>   }
>   
>   /*
> 

I apply the patch based on v5.7, the test result is as the following:
=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/runtime/nr_task/debug-setup/test/cpufreq_governor/ucode:
 
lkp-ivb-d04/reaim/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/300s/100%/test/five_sec/performance/0x21

commit:
   9f68395333ad7f5bfe2f83473fed363d4229f11c
   070f5e860ee2bf588c99ef7b4c202451faa48236
   v5.7
   1d5ee1e6dab1f8903cd7219fbcc5ac2f728ac80c (the test patch)

9f68395333ad7f5b 070f5e860ee2bf588c99ef7b4c2                        v5.7 
1d5ee1e6dab1f8903cd7219fbcc
---------------- --------------------------- --------------------------- 
---------------------------
          %stddev     %change         %stddev     %change 
%stddev     %change         %stddev
              \          |                \          |                \ 
         |                \
       0.69           -10.3%       0.62            -9.1%       0.62 
       -6.8%       0.64        reaim.child_systime
       0.62            -1.0%       0.61            +0.5%       0.62 
       +0.6%       0.62        reaim.child_utime
      66870           -10.0%      60187            -7.6%      61787 
       -5.7%      63058        reaim.jobs_per_min
      16717           -10.0%      15046            -7.6%      15446 
       -5.7%      15764        reaim.jobs_per_min_child
      97.84            -1.1%      96.75            -0.4%      97.43 
       -0.5%      97.31        reaim.jti
      72000           -10.8%      64216            -8.3%      66000 
       -5.7%      67885        reaim.max_jobs_per_min
       0.36           +10.6%       0.40            +7.8%       0.39 
       +6.0%       0.38        reaim.parent_time
       1.58 ±  2%     +71.0%       2.70 ±  2%     +26.9%       2.01 ± 
2%     +33.1%       2.10 ±  3%  reaim.std_dev_percent
       0.00 ±  5%    +110.4%       0.01 ±  3%     +48.8%       0.01 ± 
7%     +58.1%       0.01 ±  6%  reaim.std_dev_time
      50800            -2.4%      49600            -1.6%      50000 
       -0.8%      50400        reaim.workload



-- 
Zhengjun Xing
