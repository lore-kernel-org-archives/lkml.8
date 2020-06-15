Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9D4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D93BC204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgFOIOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:14:07 -0400
Received: from mga14.intel.com ([192.55.52.115]:21769 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728162AbgFOIOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:14:06 -0400
IronPort-SDR: AFJkNOaknzCyBlTfKVSShAV6Bs9jb6+g+z+n+y47pfbAaO+F5CwMAHZWLQynVxToHGi6RBbzta
 pQKJvaxnl1aw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 01:14:04 -0700
IronPort-SDR: 0k82oeE6uncmAo06sXFaHoNxFWHLYIBkzesD/zG2X08hywgWSdr0DgAOvzVnJZbZ0MzTHQ6tpX
 WJsgZYw9/Sng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,514,1583222400"; 
   d="scan'208";a="382444659"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.238.6.47]) ([10.238.6.47])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2020 01:14:02 -0700
Subject: Re: [LKP] [sched/fair] 6c8116c914: stress-ng.mmapfork.ops_per_sec
 -38.0% regression
To:     Tao Zhou <ouwen210@hotmail.com>, linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Hillf Danton <hdanton@sina.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>
References: <20200421004749.GC26573@shao2-debian>
 <20200425012306.13516-1-hdanton@sina.com>
 <20200426124208.8872-1-hdanton@sina.com>
 <20200427113533.4688-1-hdanton@sina.com>
 <CAKfTPtABxPBmS6=qn96=7X5vfF0ae15M+RAiduH0sb11+gyKew@mail.gmail.com>
 <d50c9467-7b1b-346b-d4ab-107253a0a3ae@linux.intel.com>
 <BL0PR14MB377940B17C0889D725FF78599A9C0@BL0PR14MB3779.namprd14.prod.outlook.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <d0faca7b-641a-e0e6-db89-443d88e2b3d8@linux.intel.com>
Date:   Mon, 15 Jun 2020 16:14:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <BL0PR14MB377940B17C0889D725FF78599A9C0@BL0PR14MB3779.namprd14.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/2020 1:18 PM, Tao Zhou wrote:
> Hi,
> 
> On Fri, Jun 12, 2020 at 03:59:31PM +0800, Xing Zhengjun wrote:
>> Hi,
>>
>>     I test the regression, it still existed in v5.7.  If you have any fix
>> for it, please send it to me, I can verify it. Thanks.
> 
> When busiest group is group_fully_busy and local group <= group_fully_busy
> the metric used:
> 
>                local group          busiest group          use metric
>             group_fully_busy       group_fully_busy         avg load
>             group_has_spare        group_fully_busy         idle cpu/task num
> 
> In find_busiest_group() about this condition:
> 
>      'if (busiest->group_type != group_overloaded) {'
> 
> in this case, busiest type is group_fully_busy, local type <= group_fully_busy.
> in this branch, it check idle cpu and task num and can go to out_balance. That
> is to say ignore group_fully_busy other than group_has_spare(this case is done
> in calculate_imbalance()).
> 
> When local group and busiest group are all group_fully_busy, need to use avg
> load to metric(in calculate_imbalance()). So give the below change:
> 
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cbcb2f71599b..0afbea39dd5a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9219,24 +9219,26 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>                           */
>                          goto out_balanced;
>   
> -               if (busiest->group_weight > 1 &&
> -                   local->idle_cpus <= (busiest->idle_cpus + 1))
> -                       /*
> -                        * If the busiest group is not overloaded
> -                        * and there is no imbalance between this and busiest
> -                        * group wrt idle CPUs, it is balanced. The imbalance
> -                        * becomes significant if the diff is greater than 1
> -                        * otherwise we might end up to just move the imbalance
> -                        * on another group. Of course this applies only if
> -                        * on another group. Of course this applies only if
> -                        * there is more than 1 CPU per group.
> -                        */
> -                       goto out_balanced;
> +               if (local->group_type == group_has_spare) {
> +                       if (busiest->group_weight > 1 &&
> +                           local->idle_cpus <= (busiest->idle_cpus + 1))
> +                               /*
> +                                * If the busiest group is not overloaded
> +                                * and there is no imbalance between this and busiest
> +                                * group wrt idle CPUs, it is balanced. The imbalance
> +                                * becomes significant if the diff is greater than 1
> +                                * otherwise we might end up to just move the imbalance
> +                                * on another group. Of course this applies only if
> +                                * there is more than 1 CPU per group.
> +                                */
> +                               goto out_balanced;
>   
> -               if (busiest->sum_h_nr_running == 1)
> -                       /*
> -                        * busiest doesn't have any tasks waiting to run
> -                        */
> -                       goto out_balanced;
> +                       if (busiest->sum_h_nr_running == 1)
> +                               /*
> +                                * busiest doesn't have any tasks waiting to run
> +                                */
> +                               goto out_balanced;
> +               }
>          }
>   
>   force_balance:
> 
> In fact, I don't know this change can help or not, can be right or not.
> No test, no compile. If it is wrong, just ignore.
> 
> Thanks
> 
I apply the patch based on v5.7, the regression still existed.
=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/nr_threads/disk/sc_pid_max/testtime/class/cpufreq_governor/ucode:
 
lkp-bdw-ep6/stress-ng/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/100%/1HDD/4194304/1s/scheduler/performance/0xb000038

commit:
   e94f80f6c49020008e6fa0f3d4b806b8595d17d8
   6c8116c914b65be5e4d6f66d69c8142eb0648c22
   v5.7
   c7e6d37f60da32f808140b1b7dabcc3cde73c4cc  (Tao's patch)

e94f80f6c4902000 6c8116c914b65be5e4d6f66d69c                        v5.7 
c7e6d37f60da32f808140b1b7da
---------------- --------------------------- --------------------------- 
---------------------------
          %stddev     %change         %stddev     %change 
%stddev     %change         %stddev
              \          |                \          |                \ 
         |                \
     819250 ±  5%     -10.1%     736616 ±  8%     +41.2%    1156877 ± 
3%     +43.6%    1176246 ±  5%  stress-ng.futex.ops
     818985 ±  5%     -10.1%     736460 ±  8%     +41.2%    1156215 ± 
3%     +43.6%    1176055 ±  5%  stress-ng.futex.ops_per_sec
       1551 ±  3%      -3.4%       1498 ±  5%      -4.6%       1480 ± 
5%     -14.3%       1329 ± 11%  stress-ng.inotify.ops
       1547 ±  3%      -3.5%       1492 ±  5%      -4.8%       1472 ± 
5%     -14.3%       1326 ± 11%  stress-ng.inotify.ops_per_sec
      11292 ±  8%      -2.8%      10974 ±  8%      -9.4%      10225 ± 
6%     -10.1%      10146 ±  6%  stress-ng.kill.ops
      11317 ±  8%      -2.6%      11023 ±  8%      -9.1%      10285 ± 
5%     -10.3%      10154 ±  6%  stress-ng.kill.ops_per_sec
      28.20 ±  4%     -35.4%      18.22           -33.4%      18.77 
      -27.7%      20.40 ±  9%  stress-ng.mmapfork.ops_per_sec
    2999012 ± 21%     -10.1%    2696954 ± 22%     -88.5%     344447 ± 
11%     -87.8%     364932        stress-ng.tee.ops_per_sec
       7882 ±  3%      -5.4%       7458 ±  4%      -2.0%       7724 ± 
3%      -2.2%       7709 ±  4%  stress-ng.vforkmany.ops
       7804 ±  3%      -5.2%       7400 ±  4%      -2.0%       7647 ± 
3%      -2.1%       7636 ±  4%  stress-ng.vforkmany.ops_per_sec
   46745421 ±  3%      -8.1%   42938569 ±  3%      -5.2%   44312072 ± 
4%      -2.3%   45648193        stress-ng.yield.ops
   46734472 ±  3%      -8.1%   42926316 ±  3%      -5.2%   44290338 ± 
4%      -2.4%   45627571        stress-ng.yield.ops_per_sec





>> =========================================================================================
>> tbox_group/testcase/rootfs/kconfig/compiler/nr_threads/disk/sc_pid_max/testtime/class/cpufreq_governor/ucode:
>>   
>> lkp-bdw-ep6/stress-ng/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/100%/1HDD/4194304/1s/scheduler/performance/0xb000038
>>
>> commit:
>>     e94f80f6c49020008e6fa0f3d4b806b8595d17d8
>>     6c8116c914b65be5e4d6f66d69c8142eb0648c22
>>     v5.7-rc3
>>     v5.7
>>
>> e94f80f6c4902000 6c8116c914b65be5e4d6f66d69c                    v5.7-rc3
>>                          v5.7
>> ---------------- --------------------------- ---------------------------
>> ---------------------------
>>            %stddev     %change         %stddev     %change
>> %stddev     %change         %stddev
>>                \          |                \          |                \
>>           |                \
>>        21398 ±  7%      +6.5%      22781 ±  2%     -14.5%      18287 ±
>> 4%      -5.5%      20231 ± 14%  stress-ng.clone.ops
>>       819250 ±  5%     -10.1%     736616 ±  8%     +34.2%    1099410 ±
>> 5%     +41.2%    1156877 ±  3%  stress-ng.futex.ops
>>       818985 ±  5%     -10.1%     736460 ±  8%     +34.2%    1099487 ±
>> 5%     +41.2%    1156215 ±  3%  stress-ng.futex.ops_per_sec
>>         1551 ±  3%      -3.4%       1498 ±  5%      -9.5%       1404 ±
>> 2%      -4.6%       1480 ±  5%  stress-ng.inotify.ops
>>         1547 ±  3%      -3.5%       1492 ±  5%      -9.5%       1400 ±
>> 2%      -4.8%       1472 ±  5%  stress-ng.inotify.ops_per_sec
>>        11292 ±  8%      -2.8%      10974 ±  8%      +1.9%      11505 ±
>> 13%      -9.4%      10225 ±  6%  stress-ng.kill.ops
>>        28.20 ±  4%     -35.4%      18.22           -33.5%      18.75
>>        -33.4%      18.77        stress-ng.mmapfork.ops_per_sec
>>      1932318            +1.5%    1961688 ±  2%     -22.8%    1492231 ±
>> 2%      +4.0%    2010509 ±  3%  stress-ng.softlockup.ops
>>      1931679 ±  2%      +1.5%    1961143 ±  2%     -22.8%    1491939 ±
>> 2%      +4.0%    2009585 ±  3%  stress-ng.softlockup.ops_per_sec
>>     18607406 ±  6%     -12.9%   16210450 ± 21%     -12.7%   16238693 ±
>> 14%      -8.0%   17120880 ± 13%  stress-ng.switch.ops
>>     18604406 ±  6%     -12.9%   16208270 ± 21%     -12.7%   16237956 ±
>> 14%      -8.0%   17115273 ± 13%  stress-ng.switch.ops_per_sec
>>      2999012 ± 21%     -10.1%    2696954 ± 22%      -9.1%    2725653 ±
>> 21%     -88.5%     344447 ± 11%  stress-ng.tee.ops_per_sec
>>         7882 ±  3%      -5.4%       7458 ±  4%      -4.0%       7566 ±
>> 4%      -2.0%       7724 ±  3%  stress-ng.vforkmany.ops
>>         7804 ±  3%      -5.2%       7400 ±  4%      -3.8%       7504 ±
>> 4%      -2.0%       7647 ±  3%  stress-ng.vforkmany.ops_per_sec
>>     46745421 ±  3%      -8.1%   42938569 ±  3%      -7.8%   43078233 ±
>> 3%      -5.2%   44312072 ±  4%  stress-ng.yield.ops
>>     46734472 ±  3%      -8.1%   42926316 ±  3%      -7.8%   43067447 ±
>> 3%      -5.2%   44290338 ±  4%  stress-ng.yield.ops_per_sec
>>
>>
>> On 4/27/2020 8:46 PM, Vincent Guittot wrote:
>>> On Mon, 27 Apr 2020 at 13:35, Hillf Danton <hdanton@sina.com> wrote:
>>>>
>>>>
>>>> On Mon, 27 Apr 2020 11:03:58 +0200 Vincent Guittot wrote:
>>>>> On Sun, 26 Apr 2020 at 14:42, Hillf Danton wrote:
>>>>>>
>>>>>> On 4/21/2020 8:47 AM, kernel test robot wrote:
>>>>>>>
>>>>>>> Greeting,
>>>>>>>
>>>>>>> FYI, we noticed a 56.4% improvement of stress-ng.fifo.ops_per_sec due to commit:
>>>>>>>
>>>>>>>
>>>>>>> commit: 6c8116c914b65be5e4d6f66d69c8142eb0648c22 ("sched/fair: Fix condition of avg_load calculation")
>>>>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>>>>>
>>>>>>> in testcase: stress-ng
>>>>>>> on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory
>>>>>>> with following parameters:
>>>>>>>
>>>>>>>       nr_threads: 100%
>>>>>>>       disk: 1HDD
>>>>>>>       testtime: 1s
>>>>>>>       class: scheduler
>>>>>>>       cpufreq_governor: performance
>>>>>>>       ucode: 0xb000038
>>>>>>>       sc_pid_max: 4194304
>>>>>>>
>>>>>>
>>>>>> We need to handle group_fully_busy in a different way from
>>>>>> group_overloaded as task push does not help grow load balance
>>>>>> in the former case.
>>>>>
>>>>> Have you tested this patch for the UC above ? Do you have figures ?
>>>>>
>>>> No I am looking for a box of 88 threads. Likely to get access to it in
>>>> as early as three weeks.
>>>>
>>>>>> --- a/kernel/sched/fair.c
>>>>>> +++ b/kernel/sched/fair.c
>>>>>> @@ -8744,30 +8744,20 @@ find_idlest_group(struct sched_domain *s
>>>>>>
>>>>>>           switch (local_sgs.group_type) {
>>>>>>           case group_overloaded:
>>>>>> -       case group_fully_busy:
>>>>>> -               /*
>>>>>> -                * When comparing groups across NUMA domains, it's possible for
>>>>>> -                * the local domain to be very lightly loaded relative to the
>>>>>> -                * remote domains but "imbalance" skews the comparison making
>>>>>> -                * remote CPUs look much more favourable. When considering
>>>>>> -                * cross-domain, add imbalance to the load on the remote node
>>>>>> -                * and consider staying local.
>>>>>> -                */
>>>>>> -
>>>>>> -               if ((sd->flags & SD_NUMA) &&
>>>>>> -                   ((idlest_sgs.avg_load + imbalance) >= local_sgs.avg_load))
>>>>>> +               if (100 * local_sgs.avg_load <= sd->imbalance_pct * (idlest_sgs.avg_load + imbalance))
>>>>>> +                       return idlest;
>>>>>
>>>>> So you have completely removed the NUMA special case without explaining why.
>>>>>
>>>> That was for the local domain that is lightly loaded, as the comment says,
>>>> it now is overloaded.
>>>
>>> The load value is not linked to the overloaded state of the group as
>>> you can be overloaded but still have a low load especially with cgroup
>>>
>>> That's also why there are 2 type of comparison:
>>> an absolute comparison for low load value
>>> and a proportional comparison for normal/high value
>>>
>>>>
>>>>> And you have also removed the tests for small load.
>>>>>
>>>> It is a heuristic I want to avoid. It can be replaced with the load of the
>>>> task in question as best effort.
>>>>
>>>>> Could you explain the rationale behind all these changes ?
>>>>>
>>>>> Also keep in mind that the current version provide +58% improvement
>>>>> for  stress-ng.fifo
>>>>>
>>>> Yes it's great. I'm on the minor one.
>>>>
>>>>>> +               if (local_sgs.avg_load > idlest_sgs.avg_load + imbalance)
>>>>>> +                       return idlest;
>>>>>> +               else
>>>>>>                           return NULL;
>>>>>>
>>>>>> +       case group_fully_busy:
>>>>>>                   /*
>>>>>> -                * If the local group is less loaded than the selected
>>>>>> -                * idlest group don't try and push any tasks.
>>>>>> +                * Pushing task to the idlest group will make the target group
>>>>>> +                * overloaded, leaving the local group that is overloaded fully busy,
>>>>>> +                * thus we earn nothing except for the exchange of group types.
>>>>>
>>>>> For this case both local and idlest are fully busy and in this case
>>>>> one will become overloaded so you must compare the load to be fair in
>>>>> the spread of load
>>>>>
>>>> It may be sooner than thought that the newly overloaded group is looking to
>>>> push task out, and we'll see a task ping-pong if it happens.
>>>>
>>>>
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -8683,15 +8683,11 @@ find_idlest_group(struct sched_domain *s
>>>>           struct sched_group *idlest = NULL, *local = NULL, *group = sd->groups;
>>>>           struct sg_lb_stats local_sgs, tmp_sgs;
>>>>           struct sg_lb_stats *sgs;
>>>> -       unsigned long imbalance;
>>>>           struct sg_lb_stats idlest_sgs = {
>>>>                           .avg_load = UINT_MAX,
>>>>                           .group_type = group_overloaded,
>>>>           };
>>>>
>>>> -       imbalance = scale_load_down(NICE_0_LOAD) *
>>>> -                               (sd->imbalance_pct-100) / 100;
>>>> -
>>>>           do {
>>>>                   int local_group;
>>>>
>>>> @@ -8743,31 +8739,26 @@ find_idlest_group(struct sched_domain *s
>>>>                   return idlest;
>>>>
>>>>           switch (local_sgs.group_type) {
>>>> -       case group_overloaded:
>>>>           case group_fully_busy:
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
>>>> -                       return NULL;
>>>> -
>>>> -               /*
>>>> -                * If the local group is less loaded than the selected
>>>> -                * idlest group don't try and push any tasks.
>>>> -                */
>>>> -               if (idlest_sgs.avg_load >= (local_sgs.avg_load + imbalance))
>>>> -                       return NULL;
>>>> -
>>>> -               if (100 * local_sgs.avg_load <= sd->imbalance_pct * idlest_sgs.avg_load)
>>>> -                       return NULL;
>>>> -               break;
>>>> +               return NULL;
>>>> +       case group_overloaded:
>>>> +               /* No push if balanced */
>>>> +               if (100 * local_sgs.avg_load > sd->imbalance_pct *
>>>> +                                               idlest_sgs.avg_load) {
>>>> +                       unsigned long avg_load;
>>>> +
>>>> +                       avg_load = task_h_load(p) + idlest_sgs.group_load;
>>>> +                       avg_load = (avg_load * SCHED_CAPACITY_SCALE) /
>>>> +                                               idlest_sgs.group_capacity;
>>>> +
>>>> +                       if (100 * local_sgs.avg_load <= sd->imbalance_pct *
>>>> +                                                               avg_load)
>>>> +                               return idlest;
>>>> +
>>>> +                       if (local_sgs.avg_load > avg_load)
>>>> +                               return idlest;
>>>> +               }
>>>> +               return NULL;
>>>>
>>>>           case group_imbalanced:
>>>>           case group_asym_packing:
>>>>
>>
>> -- 
>> Zhengjun Xing

-- 
Zhengjun Xing
