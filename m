Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6979C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B94692068E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgFOH1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:27:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:4099 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728380AbgFOH1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:27:04 -0400
IronPort-SDR: ltgMgBL5FwXYyGaAbwwilhIwXWD0l7vN2CKqNkXpkUxyYk0/qNWooOn/pazMAgPhTah9vMFp7o
 GsxhwVRENt7g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 00:27:03 -0700
IronPort-SDR: k23d8mGdhIi8mE0zWaRIwZT4SBlZv6wGQ1xZtWJSm5Ma7ijIyA7cY9175hQZmMK/PXEW6IPbSh
 BQEWAnzl3JPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,514,1583222400"; 
   d="scan'208";a="382434853"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.238.6.47]) ([10.238.6.47])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2020 00:27:00 -0700
Subject: Re: [LKP] [sched/fair] 070f5e860e: reaim.jobs_per_min -10.5%
 regression
To:     Hillf Danton <hdanton@sina.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <90f4036d-bb16-af67-8776-a2cbe67dfe7f@linux.intel.com>
Date:   Mon, 15 Jun 2020 15:26:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200612110616.20264-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/2020 7:06 PM, Hillf Danton wrote:
> 
> On Fri, 12 Jun 2020 14:36:49 +0800 Xing Zhengjun wrote:
>> Hi Vincent,
>>
>>     We test the regression still existed in v5.7, do you have time to
>> look at it? Thanks.
>>
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
>>
>> 9f68395333ad7f5b 070f5e860ee2bf588c99ef7b4c2                        v5.7
>> ---------------- --------------------------- ---------------------------
>>            %stddev     %change         %stddev     %change         %stddev
>>                \          |                \          |                \
>>         0.69           -10.3%       0.62            -9.1%       0.62     reaim.child_systime
>>         0.62            -1.0%       0.61            +0.5%       0.62     reaim.child_utime
>>        66870           -10.0%      60187            -7.6%      61787     reaim.jobs_per_min
>>        16717           -10.0%      15046            -7.6%      15446     reaim.jobs_per_min_child
>>        97.84            -1.1%      96.75            -0.4%      97.43     reaim.jti
>>        72000           -10.8%      64216            -8.3%      66000     reaim.max_jobs_per_min
>>         0.36           +10.6%       0.40            +7.8%       0.39     reaim.parent_time
>>         1.58 ą  2%     +71.0%       2.70 ą  2%     +26.9%       2.01 ą  2%  reaim.std_dev_percent
>>         0.00 ą  5%    +110.4%       0.01 ą  3%     +48.8%       0.01 ą  7%  reaim.std_dev_time
>>        50800            -2.4%      49600            -1.6%      50000     reaim.workload
>>
>>
>> On 3/19/2020 10:38 AM, kernel test robot wrote:
>>> Greeting,
>>>
>>> FYI, we noticed a -10.5% regression of reaim.jobs_per_min due to commit:
>>>
>>>
>>> commit: 070f5e860ee2bf588c99ef7b4c202451faa48236 ("sched/fair: Take into account runnable_avg to classify group")
>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>>
>>> in testcase: reaim
>>> on test machine: 4 threads Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 4G memory
>>> with following parameters:
>>>
>>> 	runtime: 300s
>>> 	nr_task: 100%
>>> 	test: five_sec
>>> 	cpufreq_governor: performance
>>> 	ucode: 0x21
>>>
>>> test-description: REAIM is an updated and improved version of AIM 7 benchmark.
>>> test-url: https://sourceforge.net/projects/re-aim-7/
> 
> Hi Xing
> 
> After 070f5e860ee2 let's treat runnable the same way as util on
> comparing capacity in the assumption that
> (125 + 110 + 117) / 3 = 117 accounts for 105 within margin of error
> before any other proposal with some more reasons.
> 
> thanks
> Hillf
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8215,12 +8215,8 @@ group_has_capacity(unsigned int imbalanc
>   	if (sgs->sum_nr_running < sgs->group_weight)
>   		return true;
>   
> -	if ((sgs->group_capacity * imbalance_pct) <
> -			(sgs->group_runnable * 100))
> -		return false;
> -
> -	if ((sgs->group_capacity * 100) >
> -			(sgs->group_util * imbalance_pct))
> +	if ((sgs->group_capacity * 100) > (sgs->group_util * imbalance_pct) &&
> +	    (sgs->group_capacity * 100) > (sgs->group_runnable * imbalance_pct))
>   		return true;
>   
>   	return false;
> @@ -8240,12 +8236,8 @@ group_is_overloaded(unsigned int imbalan
>   	if (sgs->sum_nr_running <= sgs->group_weight)
>   		return false;
>   
> -	if ((sgs->group_capacity * 100) <
> -			(sgs->group_util * imbalance_pct))
> -		return true;
> -
> -	if ((sgs->group_capacity * imbalance_pct) <
> -			(sgs->group_runnable * 100))
> +	if ((sgs->group_capacity * 100) < (sgs->group_util * imbalance_pct) ||
> +	    (sgs->group_capacity * 100) < (sgs->group_runnable * imbalance_pct))
>   		return true;
>   
>   	return false;
> 

I apply the patch based on v5.7, the regression still existed.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/runtime/nr_task/debug-setup/test/cpufreq_governor/ucode:
 
lkp-ivb-d04/reaim/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/300s/100%/test/five_sec/performance/0x21

commit:
   9f68395333ad7f5bfe2f83473fed363d4229f11c
   070f5e860ee2bf588c99ef7b4c202451faa48236
   v5.7
   6b33257768b8dd3982054885ea310871be2cfe0b (Hillf's patch)

9f68395333ad7f5b 070f5e860ee2bf588c99ef7b4c2                        v5.7 
6b33257768b8dd3982054885ea3
---------------- --------------------------- --------------------------- 
---------------------------
          %stddev     %change         %stddev     %change 
%stddev     %change         %stddev
              \          |                \          |                \ 
         |                \
       0.69           -10.3%       0.62            -9.1%       0.62 
      -10.1%       0.62        reaim.child_systime
       0.62            -1.0%       0.61            +0.5%       0.62 
       +0.3%       0.62        reaim.child_utime
      66870           -10.0%      60187            -7.6%      61787 
       -8.3%      61305        reaim.jobs_per_min
      16717           -10.0%      15046            -7.6%      15446 
       -8.3%      15326        reaim.jobs_per_min_child
      97.84            -1.1%      96.75            -0.4%      97.43 
       -0.5%      97.37        reaim.jti
      72000           -10.8%      64216            -8.3%      66000 
       -8.3%      66000        reaim.max_jobs_per_min
       0.36           +10.6%       0.40            +7.8%       0.39 
       +9.4%       0.39        reaim.parent_time
       1.58 ±  2%     +71.0%       2.70 ±  2%     +26.9%       2.01 ± 
2%     +33.2%       2.11        reaim.std_dev_percent
       0.00 ±  5%    +110.4%       0.01 ±  3%     +48.8%       0.01 ± 
7%     +65.3%       0.01 ±  3%  reaim.std_dev_time
      50800            -2.4%      49600            -1.6%      50000 
       -1.8%      49866        reaim.workload



-- 
Zhengjun Xing
