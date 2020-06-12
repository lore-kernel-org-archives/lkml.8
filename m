Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BD9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B0B0207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgFLH7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 03:59:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:56732 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgFLH7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:59:35 -0400
IronPort-SDR: Ri9Rp6IrRK4cQvygVkuIRhTZwKt2vSrVgMLjvOpq+z5K4/d0/a6fcDnz4nEy8HfVHNkCuGrWME
 dbxAnXV+h6Mg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 00:59:33 -0700
IronPort-SDR: +qenIa/OQfDCWHcD1Gj6eF/7yxrffKAalbGPb2nEpFh9nEWxo32Jeo9F+ktbTlIuIVFO2IQ9jz
 SRxoKuufOpMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,502,1583222400"; 
   d="scan'208";a="380637402"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.238.6.47]) ([10.238.6.47])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jun 2020 00:59:32 -0700
Subject: Re: [LKP] [sched/fair] 6c8116c914: stress-ng.mmapfork.ops_per_sec
 -38.0% regression
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Hillf Danton <hdanton@sina.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Tao Zhou <ouwen210@hotmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200421004749.GC26573@shao2-debian>
 <20200425012306.13516-1-hdanton@sina.com>
 <20200426124208.8872-1-hdanton@sina.com>
 <20200427113533.4688-1-hdanton@sina.com>
 <CAKfTPtABxPBmS6=qn96=7X5vfF0ae15M+RAiduH0sb11+gyKew@mail.gmail.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <d50c9467-7b1b-346b-d4ab-107253a0a3ae@linux.intel.com>
Date:   Fri, 12 Jun 2020 15:59:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtABxPBmS6=qn96=7X5vfF0ae15M+RAiduH0sb11+gyKew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   I test the regression, it still existed in v5.7.  If you have any fix 
for it, please send it to me, I can verify it. Thanks.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/nr_threads/disk/sc_pid_max/testtime/class/cpufreq_governor/ucode:
 
lkp-bdw-ep6/stress-ng/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/100%/1HDD/4194304/1s/scheduler/performance/0xb000038

commit:
   e94f80f6c49020008e6fa0f3d4b806b8595d17d8
   6c8116c914b65be5e4d6f66d69c8142eb0648c22
   v5.7-rc3
   v5.7

e94f80f6c4902000 6c8116c914b65be5e4d6f66d69c                    v5.7-rc3 
                        v5.7
---------------- --------------------------- --------------------------- 
---------------------------
          %stddev     %change         %stddev     %change 
%stddev     %change         %stddev
              \          |                \          |                \ 
         |                \
      21398 ±  7%      +6.5%      22781 ±  2%     -14.5%      18287 ± 
4%      -5.5%      20231 ± 14%  stress-ng.clone.ops
     819250 ±  5%     -10.1%     736616 ±  8%     +34.2%    1099410 ± 
5%     +41.2%    1156877 ±  3%  stress-ng.futex.ops
     818985 ±  5%     -10.1%     736460 ±  8%     +34.2%    1099487 ± 
5%     +41.2%    1156215 ±  3%  stress-ng.futex.ops_per_sec
       1551 ±  3%      -3.4%       1498 ±  5%      -9.5%       1404 ± 
2%      -4.6%       1480 ±  5%  stress-ng.inotify.ops
       1547 ±  3%      -3.5%       1492 ±  5%      -9.5%       1400 ± 
2%      -4.8%       1472 ±  5%  stress-ng.inotify.ops_per_sec
      11292 ±  8%      -2.8%      10974 ±  8%      +1.9%      11505 ± 
13%      -9.4%      10225 ±  6%  stress-ng.kill.ops
      28.20 ±  4%     -35.4%      18.22           -33.5%      18.75 
      -33.4%      18.77        stress-ng.mmapfork.ops_per_sec
    1932318            +1.5%    1961688 ±  2%     -22.8%    1492231 ± 
2%      +4.0%    2010509 ±  3%  stress-ng.softlockup.ops
    1931679 ±  2%      +1.5%    1961143 ±  2%     -22.8%    1491939 ± 
2%      +4.0%    2009585 ±  3%  stress-ng.softlockup.ops_per_sec
   18607406 ±  6%     -12.9%   16210450 ± 21%     -12.7%   16238693 ± 
14%      -8.0%   17120880 ± 13%  stress-ng.switch.ops
   18604406 ±  6%     -12.9%   16208270 ± 21%     -12.7%   16237956 ± 
14%      -8.0%   17115273 ± 13%  stress-ng.switch.ops_per_sec
    2999012 ± 21%     -10.1%    2696954 ± 22%      -9.1%    2725653 ± 
21%     -88.5%     344447 ± 11%  stress-ng.tee.ops_per_sec
       7882 ±  3%      -5.4%       7458 ±  4%      -4.0%       7566 ± 
4%      -2.0%       7724 ±  3%  stress-ng.vforkmany.ops
       7804 ±  3%      -5.2%       7400 ±  4%      -3.8%       7504 ± 
4%      -2.0%       7647 ±  3%  stress-ng.vforkmany.ops_per_sec
   46745421 ±  3%      -8.1%   42938569 ±  3%      -7.8%   43078233 ± 
3%      -5.2%   44312072 ±  4%  stress-ng.yield.ops
   46734472 ±  3%      -8.1%   42926316 ±  3%      -7.8%   43067447 ± 
3%      -5.2%   44290338 ±  4%  stress-ng.yield.ops_per_sec


On 4/27/2020 8:46 PM, Vincent Guittot wrote:
> On Mon, 27 Apr 2020 at 13:35, Hillf Danton <hdanton@sina.com> wrote:
>>
>>
>> On Mon, 27 Apr 2020 11:03:58 +0200 Vincent Guittot wrote: 
>>> On Sun, 26 Apr 2020 at 14:42, Hillf Danton wrote:
>>>>
>>>> On 4/21/2020 8:47 AM, kernel test robot wrote:
>>>>>
>>>>> Greeting,
>>>>>
>>>>> FYI, we noticed a 56.4% improvement of stress-ng.fifo.ops_per_sec due to commit:
>>>>>
>>>>>
>>>>> commit: 6c8116c914b65be5e4d6f66d69c8142eb0648c22 ("sched/fair: Fix condition of avg_load calculation")
>>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>>>
>>>>> in testcase: stress-ng
>>>>> on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory
>>>>> with following parameters:
>>>>>
>>>>>      nr_threads: 100%
>>>>>      disk: 1HDD
>>>>>      testtime: 1s
>>>>>      class: scheduler
>>>>>      cpufreq_governor: performance
>>>>>      ucode: 0xb000038
>>>>>      sc_pid_max: 4194304
>>>>>
>>>>
>>>> We need to handle group_fully_busy in a different way from
>>>> group_overloaded as task push does not help grow load balance
>>>> in the former case.
>>>
>>> Have you tested this patch for the UC above ? Do you have figures ?
>>>
>> No I am looking for a box of 88 threads. Likely to get access to it in
>> as early as three weeks.
>>
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -8744,30 +8744,20 @@ find_idlest_group(struct sched_domain *s
>>>>
>>>>          switch (local_sgs.group_type) {
>>>>          case group_overloaded:
>>>> -       case group_fully_busy:
>>>> -               /*
>>>> -                * When comparing groups across NUMA domains, it's possible for
>>>> -                * the local domain to be very lightly loaded relative to the
>>>> -                * remote domains but "imbalance" skews the comparison making
>>>> -                * remote CPUs look much more favourable. When considering
>>>> -                * cross-domain, add imbalance to the load on the remote node
>>>> -                * and consider staying local.
>>>> -                */
>>>> -
>>>> -               if ((sd->flags & SD_NUMA) &&
>>>> -                   ((idlest_sgs.avg_load + imbalance) >= local_sgs.avg_load))
>>>> +               if (100 * local_sgs.avg_load <= sd->imbalance_pct * (idlest_sgs.avg_load + imbalance))
>>>> +                       return idlest;
>>>
>>> So you have completely removed the NUMA special case without explaining why.
>>>
>> That was for the local domain that is lightly loaded, as the comment says,
>> it now is overloaded.
> 
> The load value is not linked to the overloaded state of the group as
> you can be overloaded but still have a low load especially with cgroup
> 
> That's also why there are 2 type of comparison:
> an absolute comparison for low load value
> and a proportional comparison for normal/high value
> 
>>
>>> And you have also removed the tests for small load.
>>>
>> It is a heuristic I want to avoid. It can be replaced with the load of the
>> task in question as best effort.
>>
>>> Could you explain the rationale behind all these changes ?
>>>
>>> Also keep in mind that the current version provide +58% improvement
>>> for  stress-ng.fifo
>>>
>> Yes it's great. I'm on the minor one.
>>
>>>> +               if (local_sgs.avg_load > idlest_sgs.avg_load + imbalance)
>>>> +                       return idlest;
>>>> +               else
>>>>                          return NULL;
>>>>
>>>> +       case group_fully_busy:
>>>>                  /*
>>>> -                * If the local group is less loaded than the selected
>>>> -                * idlest group don't try and push any tasks.
>>>> +                * Pushing task to the idlest group will make the target group
>>>> +                * overloaded, leaving the local group that is overloaded fully busy,
>>>> +                * thus we earn nothing except for the exchange of group types.
>>>
>>> For this case both local and idlest are fully busy and in this case
>>> one will become overloaded so you must compare the load to be fair in
>>> the spread of load
>>>
>> It may be sooner than thought that the newly overloaded group is looking to
>> push task out, and we'll see a task ping-pong if it happens.
>>
>>
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -8683,15 +8683,11 @@ find_idlest_group(struct sched_domain *s
>>          struct sched_group *idlest = NULL, *local = NULL, *group = sd->groups;
>>          struct sg_lb_stats local_sgs, tmp_sgs;
>>          struct sg_lb_stats *sgs;
>> -       unsigned long imbalance;
>>          struct sg_lb_stats idlest_sgs = {
>>                          .avg_load = UINT_MAX,
>>                          .group_type = group_overloaded,
>>          };
>>
>> -       imbalance = scale_load_down(NICE_0_LOAD) *
>> -                               (sd->imbalance_pct-100) / 100;
>> -
>>          do {
>>                  int local_group;
>>
>> @@ -8743,31 +8739,26 @@ find_idlest_group(struct sched_domain *s
>>                  return idlest;
>>
>>          switch (local_sgs.group_type) {
>> -       case group_overloaded:
>>          case group_fully_busy:
>> -               /*
>> -                * When comparing groups across NUMA domains, it's possible for
>> -                * the local domain to be very lightly loaded relative to the
>> -                * remote domains but "imbalance" skews the comparison making
>> -                * remote CPUs look much more favourable. When considering
>> -                * cross-domain, add imbalance to the load on the remote node
>> -                * and consider staying local.
>> -                */
>> -
>> -               if ((sd->flags & SD_NUMA) &&
>> -                   ((idlest_sgs.avg_load + imbalance) >= local_sgs.avg_load))
>> -                       return NULL;
>> -
>> -               /*
>> -                * If the local group is less loaded than the selected
>> -                * idlest group don't try and push any tasks.
>> -                */
>> -               if (idlest_sgs.avg_load >= (local_sgs.avg_load + imbalance))
>> -                       return NULL;
>> -
>> -               if (100 * local_sgs.avg_load <= sd->imbalance_pct * idlest_sgs.avg_load)
>> -                       return NULL;
>> -               break;
>> +               return NULL;
>> +       case group_overloaded:
>> +               /* No push if balanced */
>> +               if (100 * local_sgs.avg_load > sd->imbalance_pct *
>> +                                               idlest_sgs.avg_load) {
>> +                       unsigned long avg_load;
>> +
>> +                       avg_load = task_h_load(p) + idlest_sgs.group_load;
>> +                       avg_load = (avg_load * SCHED_CAPACITY_SCALE) /
>> +                                               idlest_sgs.group_capacity;
>> +
>> +                       if (100 * local_sgs.avg_load <= sd->imbalance_pct *
>> +                                                               avg_load)
>> +                               return idlest;
>> +
>> +                       if (local_sgs.avg_load > avg_load)
>> +                               return idlest;
>> +               }
>> +               return NULL;
>>
>>          case group_imbalanced:
>>          case group_asym_packing:
>>

-- 
Zhengjun Xing
