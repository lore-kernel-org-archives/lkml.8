Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E5EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 776DC20786
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgHRHXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 03:23:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:57039 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgHRHXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 03:23:00 -0400
IronPort-SDR: BIKJI2D0YC1nyfzIcv3+OPuu2P9NBIFDAXBuCZODpaNkRtyU6uOZK4LrxQmIx7IlrmLLwpTvNZ
 S4218Rh2WMZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="142483410"
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="142483410"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 00:18:36 -0700
IronPort-SDR: YwXTLainzo+xUiXvpLEyRPzI8R+8/997q8m7JjP30VehCn3OekX6/1PcTSUq48SjDgSL4EY3LB
 SE2I1jPNx5Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="326649991"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.238.4.18]) ([10.238.4.18])
  by orsmga008.jf.intel.com with ESMTP; 18 Aug 2020 00:18:35 -0700
Subject: Re: [LKP] [rcu] 276c410448: will-it-scale.per_thread_ops -12.3%
 regression
To:     paulmck@kernel.org
Cc:     kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200615085717.GQ12456@shao2-debian>
 <7f29c45c-53a1-58b7-1479-7a1b0a4e0508@linux.intel.com>
 <20200616162817.GA2723@paulmck-ThinkPad-P72>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <13d4807e-fcea-c87e-d4d4-4a99aa44d3a3@linux.intel.com>
Date:   Tue, 18 Aug 2020 15:18:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200616162817.GA2723@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/17/2020 12:28 AM, Paul E. McKenney wrote:
> On Tue, Jun 16, 2020 at 10:02:24AM +0800, Xing Zhengjun wrote:
>> Hi Paul,
>>
>>     Do you have time to take a look at this? Thanks.
> 
> I do not see how this change could affect anything that isn't directly
> using RCU Tasks Trace.  Yes, there is some addition to process creation,
> but that isn't what is showing the increased overhead.
> 
> I see that the instruction count increased.  Is it possible that this
> is due to changes in offsets within the task_struct structure?
> 
> 							Thanx, Paul


How about this regression? I test the latest v5.9-rc1, the regression is 
still exsited.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/debug-setup/nr_task/mode/test/cpufreq_governor/ucode:
 
lkp-knm01/will-it-scale/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-9/test2/100%/thread/page_fault3/performance/0x11

commit:
   b0afa0f056676ffe0a7213818f09d2460adbcc16
   276c410448dbca357a2bc3539acfe04862e5f172
   v5.9-rc1

b0afa0f056676ffe 276c410448dbca357a2bc3539ac                    v5.9-rc1
---------------- --------------------------- ---------------------------
          %stddev     %change         %stddev     %change         %stddev
              \          |                \          |                \
       1417           -13.2%       1230 ±  2%     -16.6%       1182 
   will-it-scale.per_thread_ops
     408456           -13.2%     354391 ±  2%     -16.6%     340519 
   will-it-scale.workload


> 
>> On 6/15/2020 4:57 PM, kernel test robot wrote:
>>> Greeting,
>>>
>>> FYI, we noticed a -12.3% regression of will-it-scale.per_thread_ops due to commit:
>>>
>>>
>>> commit: 276c410448dbca357a2bc3539acfe04862e5f172 ("rcu-tasks: Split ->trc_reader_need_end")
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>
>>> in testcase: will-it-scale
>>> on test machine: 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory
>>> with following parameters:
>>>
>>> 	nr_task: 100%
>>> 	mode: thread
>>> 	test: page_fault3
>>> 	cpufreq_governor: performance
>>> 	ucode: 0x11
>>>
>>> test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
>>> test-url: https://github.com/antonblanchard/will-it-scale
>>>
>>>
>>>
>>> If you fix the issue, kindly add following tag
>>> Reported-by: kernel test robot <rong.a.chen@intel.com>
>>>
>>>
>>> Details are as below:
>>> -------------------------------------------------------------------------------------------------->
>>>
>>>
>>> To reproduce:
>>>
>>>           git clone https://github.com/intel/lkp-tests.git
>>>           cd lkp-tests
>>>           bin/lkp install job.yaml  # job file is attached in this email
>>>           bin/lkp run     job.yaml
>>>
>>> =========================================================================================
>>> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
>>>     gcc-9/performance/x86_64-rhel-7.6/thread/100%/debian-x86_64-20191114.cgz/lkp-knm01/page_fault3/will-it-scale/0x11
>>>
>>> commit:
>>>     b0afa0f056 ("rcu-tasks: Provide boot parameter to delay IPIs until late in grace period")
>>>     276c410448 ("rcu-tasks: Split ->trc_reader_need_end")
>>>
>>> b0afa0f056676ffe 276c410448dbca357a2bc3539ac
>>> ---------------- ---------------------------
>>>          fail:runs  %reproduction    fail:runs
>>>              |             |             |
>>>             2:4          -50%            :4     dmesg.WARNING:at#for_ip_interrupt_entry/0x
>>>              :4           28%           1:4     perf-profile.calltrace.cycles-pp.error_entry
>>>             0:4            0%           0:4     perf-profile.children.cycles-pp.error_exit
>>>             1:4            7%           2:4     perf-profile.children.cycles-pp.error_entry
>>>             0:4            4%           1:4     perf-profile.self.cycles-pp.error_entry
>>>            %stddev     %change         %stddev
>>>                \          |                \
>>>         1414           -12.3%       1241 ±  2%  will-it-scale.per_thread_ops
>>>       463.32            +1.7%     470.99        will-it-scale.time.elapsed_time
>>>       463.32            +1.7%     470.99        will-it-scale.time.elapsed_time.max
>>>       407566           -12.3%     357573 ±  2%  will-it-scale.workload
>>>        48.51            -1.5%      47.77        boot-time.boot
>>>    7.203e+10           +20.0%   8.64e+10 ±  2%  cpuidle.C1.time
>>>    2.162e+08 ±  2%     +27.7%  2.761e+08 ±  2%  cpuidle.C1.usage
>>>        60.50           +12.2       72.74 ±  2%  mpstat.cpu.all.idle%
>>>        39.17           -12.2       26.97 ±  6%  mpstat.cpu.all.sys%
>>>         2334 ± 12%     +18.8%       2772 ±  5%  slabinfo.khugepaged_mm_slot.active_objs
>>>         2334 ± 12%     +18.8%       2772 ±  5%  slabinfo.khugepaged_mm_slot.num_objs
>>>        60.25           +20.3%      72.50 ±  2%  vmstat.cpu.id
>>>        92.75 ±  3%     -21.6%      72.75 ±  5%  vmstat.procs.r
>>>       223709           +41.8%     317250 ±  3%  vmstat.system.cs
>>>       641687 ±  3%      +8.0%     693245 ±  2%  proc-vmstat.nr_inactive_anon
>>>       641688 ±  3%      +8.0%     693245 ±  2%  proc-vmstat.nr_zone_inactive_anon
>>>       166782            -3.7%     160632        proc-vmstat.numa_hint_faults
>>>       166782            -3.7%     160632        proc-vmstat.numa_hint_faults_local
>>>       984.25           -14.2%     844.75 ±  2%  proc-vmstat.numa_huge_pte_updates
>>>       710979           -11.2%     631134        proc-vmstat.numa_pte_updates
>>>    1.967e+08           -10.9%  1.752e+08        proc-vmstat.pgfault
>>>        58.18            +3.4%      60.17        perf-stat.i.MPKI
>>>    1.173e+09           +10.5%  1.296e+09        perf-stat.i.branch-instructions
>>>         6.74            -0.1        6.68        perf-stat.i.branch-miss-rate%
>>>     72495831           +10.7%   80219684        perf-stat.i.branch-misses
>>>        14.68            -0.6       14.06        perf-stat.i.cache-miss-rate%
>>>     43014696           +10.5%   47551690        perf-stat.i.cache-misses
>>>    2.936e+08           +15.6%  3.393e+08        perf-stat.i.cache-references
>>>       227441           +42.0%     323034 ±  3%  perf-stat.i.context-switches
>>>        37.22           -29.0%      26.44 ±  5%  perf-stat.i.cpi
>>>    1.828e+11           -22.3%  1.421e+11 ±  3%  perf-stat.i.cpu-cycles
>>>       513.71           +13.6%     583.63        perf-stat.i.cpu-migrations
>>>         4303           -27.8%       3107 ±  5%  perf-stat.i.cycles-between-cache-misses
>>>         1.78            -0.0        1.74        perf-stat.i.iTLB-load-miss-rate%
>>>     90757979            +9.1%   98982336        perf-stat.i.iTLB-load-misses
>>>    5.518e+09           +10.1%  6.076e+09        perf-stat.i.iTLB-loads
>>>    5.501e+09           +10.3%  6.065e+09        perf-stat.i.instructions
>>>        59.50            +2.4%      60.91        perf-stat.i.instructions-per-iTLB-miss
>>>         0.03           +48.9%       0.05 ±  3%  perf-stat.i.ipc
>>>         0.61           -22.2%       0.47 ±  3%  perf-stat.i.metric.GHz
>>>         0.85 ±  2%      +6.3%       0.90 ±  3%  perf-stat.i.metric.K/sec
>>>        23.19           +10.3%      25.58        perf-stat.i.metric.M/sec
>>>       398027           -13.3%     345187 ±  2%  perf-stat.i.minor-faults
>>>       398027           -13.3%     345187 ±  2%  perf-stat.i.page-faults
>>>        51.63            +4.7%      54.06        perf-stat.overall.MPKI
>>>        14.82            -0.6       14.26        perf-stat.overall.cache-miss-rate%
>>>        32.82           -28.9%      23.34 ±  4%  perf-stat.overall.cpi
>>>         4290           -29.4%       3029 ±  5%  perf-stat.overall.cycles-between-cache-misses
>>>         0.03           +40.9%       0.04 ±  4%  perf-stat.overall.ipc
>>>      6447068           +28.0%    8254132 ±  3%  perf-stat.overall.path-length
>>>    1.214e+09           +10.5%  1.341e+09        perf-stat.ps.branch-instructions
>>>     72454767           +10.7%   80188768        perf-stat.ps.branch-misses
>>>     43379426           +11.2%   48228470        perf-stat.ps.cache-misses
>>>    2.927e+08           +15.5%  3.382e+08 ±  2%  perf-stat.ps.cache-references
>>>       223136           +42.0%     316818 ±  3%  perf-stat.ps.context-switches
>>>    1.861e+11           -21.6%  1.459e+11 ±  3%  perf-stat.ps.cpu-cycles
>>>       498.80           +14.0%     568.54        perf-stat.ps.cpu-migrations
>>>     90216145            +8.9%   98279965        perf-stat.ps.iTLB-load-misses
>>>    5.688e+09           +10.2%  6.267e+09        perf-stat.ps.iTLB-loads
>>>     5.67e+09           +10.3%  6.256e+09        perf-stat.ps.instructions
>>>       404137           -13.0%     351604 ±  2%  perf-stat.ps.minor-faults
>>>       404137           -13.0%     351604 ±  2%  perf-stat.ps.page-faults
>>>    2.627e+12           +12.2%  2.949e+12        perf-stat.total.instructions
>>>        84210           -25.9%      62375 ±  5%  sched_debug.cfs_rq:/.exec_clock.avg
>>>        91870 ±  3%     -23.3%      70486 ±  5%  sched_debug.cfs_rq:/.exec_clock.max
>>>        79683           -23.1%      61285 ±  6%  sched_debug.cfs_rq:/.exec_clock.min
>>>         2299 ±  7%     +36.5%       3139 ± 12%  sched_debug.cfs_rq:/.load.avg
>>>       216559           +81.8%     393746 ± 14%  sched_debug.cfs_rq:/.load.max
>>>        16561 ±  3%     +64.0%      27165 ± 14%  sched_debug.cfs_rq:/.load.stddev
>>>         2.32 ± 11%     -19.6%       1.87 ± 14%  sched_debug.cfs_rq:/.load_avg.avg
>>>     18373664 ±  3%     -19.7%   14762699 ±  8%  sched_debug.cfs_rq:/.min_vruntime.avg
>>>     18652687 ±  3%     -19.9%   14948853 ±  8%  sched_debug.cfs_rq:/.min_vruntime.max
>>>     17259651 ±  3%     -20.6%   13706324 ±  9%  sched_debug.cfs_rq:/.min_vruntime.min
>>>         0.09 ±  4%     -30.2%       0.06 ±  8%  sched_debug.cfs_rq:/.nr_running.avg
>>>         0.27 ±  2%     -14.3%       0.24 ±  5%  sched_debug.cfs_rq:/.nr_running.stddev
>>>        18.07 ±  2%     -31.0%      12.47 ±  5%  sched_debug.cfs_rq:/.nr_spread_over.avg
>>>         1.97 ± 34%     -49.2%       1.00 ± 57%  sched_debug.cfs_rq:/.nr_spread_over.min
>>>       258.66 ±  6%     -38.4%     159.22 ±  5%  sched_debug.cfs_rq:/.runnable_avg.avg
>>>       231.14           -13.6%     199.77 ±  7%  sched_debug.cfs_rq:/.runnable_avg.stddev
>>>       302282 ± 40%     -44.4%     168177 ± 29%  sched_debug.cfs_rq:/.spread0.avg
>>>       568464 ± 36%     -39.3%     344858 ± 16%  sched_debug.cfs_rq:/.spread0.max
>>>       252.26 ±  6%     -38.7%     154.72 ±  5%  sched_debug.cfs_rq:/.util_avg.avg
>>>       217.63           -15.4%     184.13 ±  6%  sched_debug.cfs_rq:/.util_avg.stddev
>>>        18.44 ± 12%     -50.3%       9.17 ±  9%  sched_debug.cfs_rq:/.util_est_enqueued.avg
>>>       575.84 ± 17%     -22.2%     447.81 ± 16%  sched_debug.cfs_rq:/.util_est_enqueued.max
>>>        67.91 ±  9%     -35.4%      43.85 ±  9%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
>>>       417156 ±  7%     -15.2%     353896 ±  5%  sched_debug.cpu.avg_idle.stddev
>>>       273.72 ±  3%     -11.3%     242.79 ±  4%  sched_debug.cpu.clock.stddev
>>>       273.72 ±  3%     -11.3%     242.79 ±  4%  sched_debug.cpu.clock_task.stddev
>>>       426.78 ±  3%     -27.6%     309.10 ± 12%  sched_debug.cpu.curr->pid.avg
>>>         1282 ±  2%     -12.4%       1123 ±  6%  sched_debug.cpu.curr->pid.stddev
>>>       351857 ±  3%     -16.4%     294246 ±  4%  sched_debug.cpu.max_idle_balance_cost.stddev
>>>         0.00           -11.8%       0.00 ±  3%  sched_debug.cpu.next_balance.stddev
>>>         0.09 ±  3%     -32.0%       0.06 ± 12%  sched_debug.cpu.nr_running.avg
>>>         0.28           -14.6%       0.24 ±  7%  sched_debug.cpu.nr_running.stddev
>>>       163725           +37.4%     225040 ±  4%  sched_debug.cpu.nr_switches.avg
>>>       174783           +35.4%     236604 ±  4%  sched_debug.cpu.nr_switches.max
>>>       151538           +36.4%     206743 ±  4%  sched_debug.cpu.nr_switches.min
>>>         2143 ±  4%     +28.5%       2753 ±  4%  sched_debug.cpu.nr_switches.stddev
>>>       160974           +38.1%     222280 ±  4%  sched_debug.cpu.sched_count.avg
>>>       170145           +36.7%     232581 ±  4%  sched_debug.cpu.sched_count.max
>>>       148944           +37.6%     204888 ±  4%  sched_debug.cpu.sched_count.min
>>>         1847 ±  8%     +38.7%       2563 ±  6%  sched_debug.cpu.sched_count.stddev
>>>        80136           +38.3%     110820 ±  4%  sched_debug.cpu.sched_goidle.avg
>>>        84559           +36.9%     115782 ±  4%  sched_debug.cpu.sched_goidle.max
>>>        74091           +37.8%     102072 ±  4%  sched_debug.cpu.sched_goidle.min
>>>       891.35 ±  6%     +41.4%       1260 ±  6%  sched_debug.cpu.sched_goidle.stddev
>>>        80346           +38.2%     111003 ±  4%  sched_debug.cpu.ttwu_count.avg
>>>       114308 ±  2%     +42.7%     163080 ±  6%  sched_debug.cpu.ttwu_count.max
>>>        62759 ±  3%     +38.4%      86881 ±  2%  sched_debug.cpu.ttwu_count.min
>>>         8223 ±  7%     +53.5%      12623 ± 13%  sched_debug.cpu.ttwu_count.stddev
>>>         2.35 ± 10%      -0.7        1.65 ± 14%  perf-profile.calltrace.cycles-pp.irq_exit.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
>>>         0.94 ± 15%      -0.5        0.44 ± 58%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.rwsem_down_read_slowpath.do_user_addr_fault.page_fault
>>>         0.90 ± 15%      -0.5        0.42 ± 58%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.rwsem_down_read_slowpath.do_user_addr_fault.page_fault
>>>         1.38 ±  4%      -0.4        0.94 ± 12%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.irq_exit.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state
>>>         0.81 ±  4%      +0.1        0.91 ±  4%  perf-profile.calltrace.cycles-pp.file_update_time.fault_dirty_shared_page.do_fault.__handle_mm_fault.handle_mm_fault
>>>         1.35 ±  6%      +0.2        1.51 ±  3%  perf-profile.calltrace.cycles-pp.find_get_entry.find_lock_entry.shmem_getpage_gfp.shmem_fault.__do_fault
>>>         1.16 ±  7%      +0.2        1.33 ±  5%  perf-profile.calltrace.cycles-pp.unlock_page.fault_dirty_shared_page.do_fault.__handle_mm_fault.handle_mm_fault
>>>         1.29 ±  8%      +0.2        1.46 ±  7%  perf-profile.calltrace.cycles-pp._raw_spin_lock.alloc_set_pte.finish_fault.do_fault.__handle_mm_fault
>>>         1.76 ±  7%      +0.3        2.04 ±  5%  perf-profile.calltrace.cycles-pp.page_add_file_rmap.alloc_set_pte.finish_fault.do_fault.__handle_mm_fault
>>>         2.13 ±  5%      +0.3        2.41 ±  4%  perf-profile.calltrace.cycles-pp.fault_dirty_shared_page.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
>>>         2.46 ±  8%      +0.4        2.81 ±  7%  perf-profile.calltrace.cycles-pp.up_read.do_user_addr_fault.page_fault
>>>         2.86 ±  6%      +0.4        3.21 ±  4%  perf-profile.calltrace.cycles-pp.find_lock_entry.shmem_getpage_gfp.shmem_fault.__do_fault.do_fault
>>>         3.12 ±  6%      +0.4        3.52 ±  4%  perf-profile.calltrace.cycles-pp.shmem_getpage_gfp.shmem_fault.__do_fault.do_fault.__handle_mm_fault
>>>         3.27 ±  6%      +0.4        3.67 ±  4%  perf-profile.calltrace.cycles-pp.shmem_fault.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault
>>>         3.33 ±  6%      +0.4        3.75 ±  4%  perf-profile.calltrace.cycles-pp.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
>>>         0.13 ±173%      +0.4        0.55 ±  8%  perf-profile.calltrace.cycles-pp.swapgs_restore_regs_and_return_to_usermode
>>>         3.39 ±  7%      +0.5        3.89 ±  5%  perf-profile.calltrace.cycles-pp.alloc_set_pte.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault
>>>         3.44 ±  7%      +0.5        3.94 ±  5%  perf-profile.calltrace.cycles-pp.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
>>>         8.99 ±  6%      +1.2       10.20 ±  4%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.page_fault
>>>        12.23 ±  6%      +1.6       13.84 ±  5%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.page_fault
>>>        12.68 ±  6%      +1.7       14.38 ±  5%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.page_fault
>>>        45.14 ±  9%      +6.1       51.25 ±  6%  perf-profile.calltrace.cycles-pp.down_read_trylock.do_user_addr_fault.page_fault
>>>        66.96 ±  7%      +7.4       74.37 ±  4%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.page_fault
>>>        69.19 ±  7%      +7.7       76.89 ±  4%  perf-profile.calltrace.cycles-pp.page_fault
>>>        17.74 ±  8%      -3.3       14.46 ± 20%  perf-profile.children.cycles-pp.apic_timer_interrupt
>>>        17.02 ±  8%      -3.1       13.89 ± 20%  perf-profile.children.cycles-pp.smp_apic_timer_interrupt
>>>         2.97 ±  8%      -0.7        2.25 ± 12%  perf-profile.children.cycles-pp.irq_exit
>>>         1.88 ± 11%      -0.5        1.41 ± 11%  perf-profile.children.cycles-pp.__softirqentry_text_start
>>>         1.02 ± 14%      -0.4        0.59 ± 15%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>>>         1.75 ± 12%      -0.4        1.35 ± 14%  perf-profile.children.cycles-pp._raw_spin_lock_irq
>>>         0.92 ± 12%      -0.2        0.68 ± 17%  perf-profile.children.cycles-pp.ktime_get
>>>         0.32 ± 20%      -0.2        0.13 ± 30%  perf-profile.children.cycles-pp.munmap
>>>         0.32 ± 22%      -0.2        0.14 ± 27%  perf-profile.children.cycles-pp.__x64_sys_munmap
>>>         0.32 ± 22%      -0.2        0.14 ± 28%  perf-profile.children.cycles-pp.__vm_munmap
>>>         0.29 ± 21%      -0.2        0.13 ± 23%  perf-profile.children.cycles-pp.__do_munmap
>>>         0.28 ± 21%      -0.2        0.12 ± 25%  perf-profile.children.cycles-pp.unmap_region
>>>         0.28 ± 22%      -0.2        0.13 ± 23%  perf-profile.children.cycles-pp.unmap_vmas
>>>         0.28 ± 21%      -0.2        0.13 ± 23%  perf-profile.children.cycles-pp.unmap_page_range
>>>         0.48 ±  6%      -0.1        0.34 ± 15%  perf-profile.children.cycles-pp.rebalance_domains
>>>         0.56 ± 12%      -0.1        0.43 ± 16%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
>>>         0.44 ± 11%      -0.1        0.33 ± 25%  perf-profile.children.cycles-pp.clockevents_program_event
>>>         0.31 ± 14%      -0.1        0.21 ± 16%  perf-profile.children.cycles-pp.run_rebalance_domains
>>>         0.34 ±  9%      -0.1        0.25 ± 16%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
>>>         0.28 ± 14%      -0.1        0.21 ± 22%  perf-profile.children.cycles-pp.rcu_dynticks_eqs_exit
>>>         0.12 ± 21%      -0.1        0.04 ± 59%  perf-profile.children.cycles-pp.smp_call_function_many_cond
>>>         0.12 ± 21%      -0.1        0.04 ± 59%  perf-profile.children.cycles-pp.on_each_cpu_cond_mask
>>>         0.12 ± 21%      -0.1        0.05 ± 60%  perf-profile.children.cycles-pp.flush_tlb_mm_range
>>>         0.19 ± 16%      -0.1        0.12 ± 25%  perf-profile.children.cycles-pp.irq_work_tick
>>>         0.31 ± 10%      -0.1        0.24 ± 21%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
>>>         0.17 ± 13%      -0.0        0.12 ± 15%  perf-profile.children.cycles-pp.rcu_idle_exit
>>>         0.12 ± 12%      -0.0        0.08 ± 30%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
>>>         0.14 ±  8%      -0.0        0.10 ± 12%  perf-profile.children.cycles-pp.raise_softirq
>>>         0.09 ±  7%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp._cond_resched
>>>         0.06            +0.0        0.08 ± 11%  perf-profile.children.cycles-pp.lock_page_memcg
>>>         0.15 ±  7%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.__mod_memcg_state
>>>         0.07            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.perf_swevent_event
>>>         0.18 ±  7%      +0.0        0.21 ±  4%  perf-profile.children.cycles-pp.current_time
>>>         0.23 ±  3%      +0.0        0.26 ±  4%  perf-profile.children.cycles-pp.xas_load
>>>         0.14 ±  9%      +0.0        0.18 ±  8%  perf-profile.children.cycles-pp.__count_memcg_events
>>>         0.46 ±  5%      +0.1        0.51 ±  4%  perf-profile.children.cycles-pp.__mod_lruvec_state
>>>         0.42 ±  5%      +0.1        0.48 ±  7%  perf-profile.children.cycles-pp.__mark_inode_dirty
>>>         0.55 ±  5%      +0.1        0.61 ±  3%  perf-profile.children.cycles-pp.___perf_sw_event
>>>         0.47 ±  4%      +0.1        0.55 ±  8%  perf-profile.children.cycles-pp.swapgs_restore_regs_and_return_to_usermode
>>>         0.42 ±  9%      +0.1        0.50 ±  8%  perf-profile.children.cycles-pp.__might_sleep
>>>         0.81 ±  5%      +0.1        0.92 ±  4%  perf-profile.children.cycles-pp.file_update_time
>>>         1.36 ±  6%      +0.2        1.52 ±  3%  perf-profile.children.cycles-pp.find_get_entry
>>>         1.17 ±  7%      +0.2        1.34 ±  5%  perf-profile.children.cycles-pp.unlock_page
>>>         1.77 ±  7%      +0.3        2.05 ±  5%  perf-profile.children.cycles-pp.page_add_file_rmap
>>>         2.14 ±  5%      +0.3        2.42 ±  4%  perf-profile.children.cycles-pp.fault_dirty_shared_page
>>>         2.51 ±  8%      +0.4        2.86 ±  7%  perf-profile.children.cycles-pp.up_read
>>>         2.90 ±  6%      +0.4        3.26 ±  4%  perf-profile.children.cycles-pp.find_lock_entry
>>>         3.12 ±  6%      +0.4        3.52 ±  4%  perf-profile.children.cycles-pp.shmem_getpage_gfp
>>>         3.27 ±  6%      +0.4        3.68 ±  4%  perf-profile.children.cycles-pp.shmem_fault
>>>         3.33 ±  6%      +0.4        3.75 ±  3%  perf-profile.children.cycles-pp.__do_fault
>>>         3.45 ±  7%      +0.5        3.95 ±  5%  perf-profile.children.cycles-pp.finish_fault
>>>         3.42 ±  7%      +0.5        3.92 ±  5%  perf-profile.children.cycles-pp.alloc_set_pte
>>>         9.02 ±  6%      +1.2       10.23 ±  4%  perf-profile.children.cycles-pp.do_fault
>>>        12.26 ±  6%      +1.6       13.88 ±  5%  perf-profile.children.cycles-pp.__handle_mm_fault
>>>        12.72 ±  6%      +1.7       14.43 ±  5%  perf-profile.children.cycles-pp.handle_mm_fault
>>>        45.27 ±  9%      +6.1       51.39 ±  6%  perf-profile.children.cycles-pp.down_read_trylock
>>>        67.33 ±  7%      +7.5       74.81 ±  4%  perf-profile.children.cycles-pp.do_user_addr_fault
>>>        69.24 ±  7%      +7.7       76.95 ±  4%  perf-profile.children.cycles-pp.page_fault
>>>         1.02 ± 14%      -0.4        0.59 ± 15%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
>>>         0.74 ± 13%      -0.2        0.55 ± 18%  perf-profile.self.cycles-pp.ktime_get
>>>         0.28 ± 10%      -0.1        0.21 ± 17%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
>>>         0.28 ± 13%      -0.1        0.20 ± 21%  perf-profile.self.cycles-pp.rcu_dynticks_eqs_exit
>>>         0.19 ± 16%      -0.1        0.12 ± 25%  perf-profile.self.cycles-pp.irq_work_tick
>>>         0.26 ±  7%      -0.1        0.21 ± 12%  perf-profile.self.cycles-pp.__softirqentry_text_start
>>>         0.20 ± 15%      -0.0        0.16 ± 11%  perf-profile.self.cycles-pp.__run_timers
>>>         0.14 ±  7%      -0.0        0.10 ± 12%  perf-profile.self.cycles-pp.raise_softirq
>>>         0.13 ±  9%      -0.0        0.10 ± 15%  perf-profile.self.cycles-pp.tick_sched_timer
>>>         0.07 ± 10%      -0.0        0.04 ± 58%  perf-profile.self.cycles-pp.clockevents_program_event
>>>         0.09 ±  5%      -0.0        0.07 ± 17%  perf-profile.self.cycles-pp.apic_timer_interrupt
>>>         0.05 ±  8%      +0.0        0.07 ± 12%  perf-profile.self.cycles-pp.lock_page_memcg
>>>         0.11 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.file_update_time
>>>         0.10 ±  7%      +0.0        0.12 ±  7%  perf-profile.self.cycles-pp.___might_sleep
>>>         0.06 ±  6%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.perf_swevent_event
>>>         0.18 ±  8%      +0.0        0.20 ±  6%  perf-profile.self.cycles-pp.__mod_lruvec_state
>>>         0.13 ±  9%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.__mod_memcg_state
>>>         0.24 ±  6%      +0.0        0.27 ±  6%  perf-profile.self.cycles-pp.handle_mm_fault
>>>         0.41 ±  4%      +0.0        0.44 ±  3%  perf-profile.self.cycles-pp.___perf_sw_event
>>>         0.14 ±  9%      +0.0        0.17 ±  6%  perf-profile.self.cycles-pp.__count_memcg_events
>>>         0.21 ±  6%      +0.0        0.25 ±  4%  perf-profile.self.cycles-pp.shmem_getpage_gfp
>>>         0.23 ± 10%      +0.1        0.29 ± 13%  perf-profile.self.cycles-pp.swapgs_restore_regs_and_return_to_usermode
>>>         1.02 ±  6%      +0.1        1.13 ±  6%  perf-profile.self.cycles-pp.find_get_entry
>>>         0.86 ±  4%      +0.1        1.00 ±  6%  perf-profile.self.cycles-pp.do_user_addr_fault
>>>         1.10 ±  6%      +0.2        1.26 ±  7%  perf-profile.self.cycles-pp.unlock_page
>>>         1.26 ±  7%      +0.2        1.44 ±  8%  perf-profile.self.cycles-pp.find_lock_entry
>>>         1.20 ±  6%      +0.2        1.38 ±  8%  perf-profile.self.cycles-pp.page_add_file_rmap
>>>         2.35 ±  7%      +0.3        2.69 ±  8%  perf-profile.self.cycles-pp.up_read
>>>         2.97 ±  6%      +0.4        3.35 ±  8%  perf-profile.self.cycles-pp.__handle_mm_fault
>>>        42.09 ±  8%      +5.7       47.79 ±  8%  perf-profile.self.cycles-pp.down_read_trylock
>>>       406.00 ± 37%   +1859.5%       7955 ±151%  interrupts.32:IR-PCI-MSI.2097155-edge.eth0-TxRx-2
>>>      3009113            -4.3%    2880393 ±  2%  interrupts.CAL:Function_call_interrupts
>>>         1445 ± 50%     +93.0%       2788 ±  9%  interrupts.CPU0.NMI:Non-maskable_interrupts
>>>         1445 ± 50%     +93.0%       2788 ±  9%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
>>>       939.50 ± 16%     +23.2%       1157 ±  5%  interrupts.CPU100.RES:Rescheduling_interrupts
>>>         1223 ± 11%     +43.3%       1753 ± 23%  interrupts.CPU103.NMI:Non-maskable_interrupts
>>>         1223 ± 11%     +43.3%       1753 ± 23%  interrupts.CPU103.PMI:Performance_monitoring_interrupts
>>>         1163 ±  6%     +24.5%       1448 ±  6%  interrupts.CPU104.RES:Rescheduling_interrupts
>>>         1062 ± 15%     +40.5%       1493 ±  5%  interrupts.CPU105.RES:Rescheduling_interrupts
>>>         1490 ± 28%     +70.1%       2536 ± 20%  interrupts.CPU106.NMI:Non-maskable_interrupts
>>>         1490 ± 28%     +70.1%       2536 ± 20%  interrupts.CPU106.PMI:Performance_monitoring_interrupts
>>>         1186 ±  3%     +26.4%       1499 ± 11%  interrupts.CPU106.RES:Rescheduling_interrupts
>>>         1186 ±  5%     +36.5%       1618 ±  9%  interrupts.CPU107.RES:Rescheduling_interrupts
>>>         1484 ± 29%     +98.1%       2941 ±  9%  interrupts.CPU108.NMI:Non-maskable_interrupts
>>>         1484 ± 29%     +98.1%       2941 ±  9%  interrupts.CPU108.PMI:Performance_monitoring_interrupts
>>>         1087 ± 11%     +35.2%       1470 ± 11%  interrupts.CPU108.RES:Rescheduling_interrupts
>>>       905.00 ± 14%     +26.9%       1148 ±  8%  interrupts.CPU109.RES:Rescheduling_interrupts
>>>         1534 ± 35%     +91.6%       2939 ±  9%  interrupts.CPU110.NMI:Non-maskable_interrupts
>>>         1534 ± 35%     +91.6%       2939 ±  9%  interrupts.CPU110.PMI:Performance_monitoring_interrupts
>>>         1222 ± 11%     +54.3%       1885 ± 44%  interrupts.CPU111.NMI:Non-maskable_interrupts
>>>         1222 ± 11%     +54.3%       1885 ± 44%  interrupts.CPU111.PMI:Performance_monitoring_interrupts
>>>         1066           +27.7%       1360 ±  5%  interrupts.CPU111.RES:Rescheduling_interrupts
>>>         1214 ± 12%     +51.1%       1833 ± 35%  interrupts.CPU112.NMI:Non-maskable_interrupts
>>>         1214 ± 12%     +51.1%       1833 ± 35%  interrupts.CPU112.PMI:Performance_monitoring_interrupts
>>>         1206 ± 12%     +30.8%       1577 ±  9%  interrupts.CPU116.RES:Rescheduling_interrupts
>>>         1102 ± 10%     +46.7%       1616 ± 11%  interrupts.CPU117.RES:Rescheduling_interrupts
>>>         1211 ±  3%     +35.2%       1638 ± 15%  interrupts.CPU118.RES:Rescheduling_interrupts
>>>         1217 ± 11%    +115.4%       2623 ± 29%  interrupts.CPU119.NMI:Non-maskable_interrupts
>>>         1217 ± 11%    +115.4%       2623 ± 29%  interrupts.CPU119.PMI:Performance_monitoring_interrupts
>>>       406.00 ± 37%   +1859.5%       7955 ±151%  interrupts.CPU12.32:IR-PCI-MSI.2097155-edge.eth0-TxRx-2
>>>         1125 ± 12%     +27.3%       1432 ± 10%  interrupts.CPU12.NMI:Non-maskable_interrupts
>>>         1125 ± 12%     +27.3%       1432 ± 10%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
>>>         1173 ± 12%     +55.5%       1823 ± 35%  interrupts.CPU120.NMI:Non-maskable_interrupts
>>>         1173 ± 12%     +55.5%       1823 ± 35%  interrupts.CPU120.PMI:Performance_monitoring_interrupts
>>>         1112 ±  5%     +40.2%       1559 ±  6%  interrupts.CPU121.RES:Rescheduling_interrupts
>>>         1227 ± 11%     +50.5%       1846 ± 34%  interrupts.CPU122.NMI:Non-maskable_interrupts
>>>         1227 ± 11%     +50.5%       1846 ± 34%  interrupts.CPU122.PMI:Performance_monitoring_interrupts
>>>         1036 ± 11%     +36.6%       1416 ±  4%  interrupts.CPU122.RES:Rescheduling_interrupts
>>>         1164 ± 22%     +40.8%       1639 ± 16%  interrupts.CPU123.RES:Rescheduling_interrupts
>>>         1419 ± 13%     +20.7%       1712 ±  9%  interrupts.CPU124.RES:Rescheduling_interrupts
>>>         1209 ± 11%     +21.5%       1469 ±  9%  interrupts.CPU126.NMI:Non-maskable_interrupts
>>>         1209 ± 11%     +21.5%       1469 ±  9%  interrupts.CPU126.PMI:Performance_monitoring_interrupts
>>>         1266 ± 16%     +34.9%       1708 ± 13%  interrupts.CPU126.RES:Rescheduling_interrupts
>>>         1207 ± 24%     +36.5%       1648 ± 11%  interrupts.CPU127.RES:Rescheduling_interrupts
>>>         1298 ± 12%     +30.8%       1698        interrupts.CPU128.RES:Rescheduling_interrupts
>>>         1354 ±  7%     +33.5%       1808 ±  9%  interrupts.CPU129.RES:Rescheduling_interrupts
>>>         1046 ±  7%     +42.3%       1488 ± 17%  interrupts.CPU130.RES:Rescheduling_interrupts
>>>         1068 ±  6%     +45.9%       1558 ± 13%  interrupts.CPU131.RES:Rescheduling_interrupts
>>>         1200 ±  2%     +41.7%       1701 ± 14%  interrupts.CPU132.RES:Rescheduling_interrupts
>>>         1191 ± 11%     +85.4%       2208 ± 39%  interrupts.CPU133.NMI:Non-maskable_interrupts
>>>         1191 ± 11%     +85.4%       2208 ± 39%  interrupts.CPU133.PMI:Performance_monitoring_interrupts
>>>         1327 ±  9%     +13.8%       1510 ±  4%  interrupts.CPU134.RES:Rescheduling_interrupts
>>>         1203 ± 12%     +52.8%       1837 ± 34%  interrupts.CPU136.NMI:Non-maskable_interrupts
>>>         1203 ± 12%     +52.8%       1837 ± 34%  interrupts.CPU136.PMI:Performance_monitoring_interrupts
>>>       976.75 ±  8%     +19.0%       1162 ±  8%  interrupts.CPU136.RES:Rescheduling_interrupts
>>>         1438 ± 34%     +75.9%       2530 ± 27%  interrupts.CPU137.NMI:Non-maskable_interrupts
>>>         1438 ± 34%     +75.9%       2530 ± 27%  interrupts.CPU137.PMI:Performance_monitoring_interrupts
>>>       950.75 ±  5%     +33.1%       1265 ± 14%  interrupts.CPU139.RES:Rescheduling_interrupts
>>>         1054 ±  6%     +26.9%       1338 ±  8%  interrupts.CPU140.RES:Rescheduling_interrupts
>>>        10703 ±  3%      -8.0%       9849 ±  4%  interrupts.CPU140.TLB:TLB_shootdowns
>>>         1509 ± 29%     +71.5%       2589 ± 27%  interrupts.CPU141.NMI:Non-maskable_interrupts
>>>         1509 ± 29%     +71.5%       2589 ± 27%  interrupts.CPU141.PMI:Performance_monitoring_interrupts
>>>         1334 ±  7%     +14.9%       1533 ±  8%  interrupts.CPU141.RES:Rescheduling_interrupts
>>>         1505 ± 36%     +71.7%       2585 ± 27%  interrupts.CPU142.NMI:Non-maskable_interrupts
>>>         1505 ± 36%     +71.7%       2585 ± 27%  interrupts.CPU142.PMI:Performance_monitoring_interrupts
>>>         1206 ±  7%     +32.3%       1596 ± 13%  interrupts.CPU142.RES:Rescheduling_interrupts
>>>         1218 ± 11%     +55.0%       1888 ± 44%  interrupts.CPU143.NMI:Non-maskable_interrupts
>>>         1218 ± 11%     +55.0%       1888 ± 44%  interrupts.CPU143.PMI:Performance_monitoring_interrupts
>>>         1883 ±  5%     +37.7%       2594 ± 12%  interrupts.CPU143.RES:Rescheduling_interrupts
>>>         1211 ± 11%     +51.1%       1831 ± 35%  interrupts.CPU144.NMI:Non-maskable_interrupts
>>>         1211 ± 11%     +51.1%       1831 ± 35%  interrupts.CPU144.PMI:Performance_monitoring_interrupts
>>>         1266 ± 15%     +43.3%       1815 ±  7%  interrupts.CPU144.RES:Rescheduling_interrupts
>>>         1226 ± 11%    +109.7%       2572 ± 27%  interrupts.CPU145.NMI:Non-maskable_interrupts
>>>         1226 ± 11%    +109.7%       2572 ± 27%  interrupts.CPU145.PMI:Performance_monitoring_interrupts
>>>         1370 ± 27%     +54.3%       2114 ± 35%  interrupts.CPU15.NMI:Non-maskable_interrupts
>>>         1370 ± 27%     +54.3%       2114 ± 35%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
>>>       685.25 ±  6%     +33.2%     913.00 ±  9%  interrupts.CPU15.RES:Rescheduling_interrupts
>>>         1197 ± 11%     +84.2%       2206 ± 39%  interrupts.CPU150.NMI:Non-maskable_interrupts
>>>         1197 ± 11%     +84.2%       2206 ± 39%  interrupts.CPU150.PMI:Performance_monitoring_interrupts
>>>         1097 ±  9%     +33.0%       1459 ± 13%  interrupts.CPU152.RES:Rescheduling_interrupts
>>>         1263 ±  7%     +31.8%       1665 ±  8%  interrupts.CPU154.RES:Rescheduling_interrupts
>>>         1215 ± 12%     +49.4%       1815 ± 33%  interrupts.CPU155.NMI:Non-maskable_interrupts
>>>         1215 ± 12%     +49.4%       1815 ± 33%  interrupts.CPU155.PMI:Performance_monitoring_interrupts
>>>         1222 ±  5%     +29.1%       1578 ±  9%  interrupts.CPU155.RES:Rescheduling_interrupts
>>>         1065 ±  9%     +30.1%       1386 ± 13%  interrupts.CPU156.RES:Rescheduling_interrupts
>>>         1017 ± 13%     +23.8%       1259 ±  7%  interrupts.CPU157.RES:Rescheduling_interrupts
>>>         1055 ± 11%     +28.5%       1356 ± 11%  interrupts.CPU158.RES:Rescheduling_interrupts
>>>         1016 ±  9%     +39.7%       1420 ± 13%  interrupts.CPU159.RES:Rescheduling_interrupts
>>>         1084 ±  2%     +24.3%       1347 ± 13%  interrupts.CPU161.RES:Rescheduling_interrupts
>>>       918.75 ± 13%     +20.4%       1106 ± 11%  interrupts.CPU162.RES:Rescheduling_interrupts
>>>        10725            -8.9%       9774 ±  2%  interrupts.CPU162.TLB:TLB_shootdowns
>>>       959.75 ±  9%     +24.8%       1197 ± 11%  interrupts.CPU163.RES:Rescheduling_interrupts
>>>         1177 ±  8%     +36.8%       1610 ± 15%  interrupts.CPU167.RES:Rescheduling_interrupts
>>>         1211 ± 12%     +84.4%       2233 ± 39%  interrupts.CPU168.NMI:Non-maskable_interrupts
>>>         1211 ± 12%     +84.4%       2233 ± 39%  interrupts.CPU168.PMI:Performance_monitoring_interrupts
>>>         1220 ± 12%     +22.2%       1491 ±  8%  interrupts.CPU169.RES:Rescheduling_interrupts
>>>       711.00 ±  6%     +33.3%     948.00 ± 13%  interrupts.CPU17.RES:Rescheduling_interrupts
>>>         1254 ±  8%     +32.6%       1663 ± 18%  interrupts.CPU170.RES:Rescheduling_interrupts
>>>         1149 ± 10%     +46.0%       1677 ± 11%  interrupts.CPU171.RES:Rescheduling_interrupts
>>>         1578 ± 49%     +41.6%       2234 ± 40%  interrupts.CPU173.NMI:Non-maskable_interrupts
>>>         1578 ± 49%     +41.6%       2234 ± 40%  interrupts.CPU173.PMI:Performance_monitoring_interrupts
>>>         1242 ±  9%     +17.3%       1456 ±  9%  interrupts.CPU174.NMI:Non-maskable_interrupts
>>>         1242 ±  9%     +17.3%       1456 ±  9%  interrupts.CPU174.PMI:Performance_monitoring_interrupts
>>>         1008 ±  7%     +26.7%       1278        interrupts.CPU176.RES:Rescheduling_interrupts
>>>         1015 ±  4%     +33.9%       1360 ±  8%  interrupts.CPU177.RES:Rescheduling_interrupts
>>>       929.50 ± 13%     +27.4%       1183 ±  6%  interrupts.CPU178.RES:Rescheduling_interrupts
>>>         1051 ±  8%     +20.7%       1268        interrupts.CPU179.RES:Rescheduling_interrupts
>>>         1149 ± 13%     +87.3%       2153 ± 34%  interrupts.CPU18.NMI:Non-maskable_interrupts
>>>         1149 ± 13%     +87.3%       2153 ± 34%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
>>>       832.75 ±  4%     +23.5%       1028        interrupts.CPU18.RES:Rescheduling_interrupts
>>>         1215 ± 11%     +21.9%       1481 ±  9%  interrupts.CPU180.NMI:Non-maskable_interrupts
>>>         1215 ± 11%     +21.9%       1481 ±  9%  interrupts.CPU180.PMI:Performance_monitoring_interrupts
>>>         1050 ± 15%     +39.3%       1463 ±  6%  interrupts.CPU181.RES:Rescheduling_interrupts
>>>         1093 ±  5%     +28.7%       1407 ± 11%  interrupts.CPU182.RES:Rescheduling_interrupts
>>>         1082 ±  5%     +27.6%       1381 ±  3%  interrupts.CPU183.RES:Rescheduling_interrupts
>>>       990.50 ± 10%     +28.1%       1269 ±  8%  interrupts.CPU184.RES:Rescheduling_interrupts
>>>       964.00 ± 13%     +28.2%       1235 ±  8%  interrupts.CPU186.RES:Rescheduling_interrupts
>>>         1498 ± 29%     +68.5%       2524 ± 19%  interrupts.CPU187.NMI:Non-maskable_interrupts
>>>         1498 ± 29%     +68.5%       2524 ± 19%  interrupts.CPU187.PMI:Performance_monitoring_interrupts
>>>         1084 ± 11%     +35.9%       1473 ±  9%  interrupts.CPU188.RES:Rescheduling_interrupts
>>>         1537 ± 34%     +68.0%       2582 ± 26%  interrupts.CPU190.NMI:Non-maskable_interrupts
>>>         1537 ± 34%     +68.0%       2582 ± 26%  interrupts.CPU190.PMI:Performance_monitoring_interrupts
>>>         1247 ±  2%     +32.7%       1655 ±  5%  interrupts.CPU190.RES:Rescheduling_interrupts
>>>         1292 ± 11%     +26.0%       1628 ±  6%  interrupts.CPU191.RES:Rescheduling_interrupts
>>>         1223 ± 13%     +50.2%       1837 ± 33%  interrupts.CPU192.NMI:Non-maskable_interrupts
>>>         1223 ± 13%     +50.2%       1837 ± 33%  interrupts.CPU192.PMI:Performance_monitoring_interrupts
>>>         1263 ±  8%     +30.8%       1651 ±  8%  interrupts.CPU193.RES:Rescheduling_interrupts
>>>         1369 ±  8%     +25.9%       1724 ± 13%  interrupts.CPU196.RES:Rescheduling_interrupts
>>>         1127 ±  9%     +27.5%       1437 ±  6%  interrupts.CPU197.RES:Rescheduling_interrupts
>>>         1134 ± 10%     +25.8%       1427 ± 19%  interrupts.CPU198.RES:Rescheduling_interrupts
>>>         1205 ± 12%     +47.0%       1772 ± 24%  interrupts.CPU199.NMI:Non-maskable_interrupts
>>>         1205 ± 12%     +47.0%       1772 ± 24%  interrupts.CPU199.PMI:Performance_monitoring_interrupts
>>>         1160 ± 12%    +117.2%       2520 ± 25%  interrupts.CPU2.NMI:Non-maskable_interrupts
>>>         1160 ± 12%    +117.2%       2520 ± 25%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
>>>         1408 ± 27%     +77.7%       2502 ± 27%  interrupts.CPU20.NMI:Non-maskable_interrupts
>>>         1408 ± 27%     +77.7%       2502 ± 27%  interrupts.CPU20.PMI:Performance_monitoring_interrupts
>>>         1077 ± 13%     +28.2%       1381 ±  9%  interrupts.CPU202.RES:Rescheduling_interrupts
>>>         1512 ± 36%     +41.9%       2147 ± 26%  interrupts.CPU203.NMI:Non-maskable_interrupts
>>>         1512 ± 36%     +41.9%       2147 ± 26%  interrupts.CPU203.PMI:Performance_monitoring_interrupts
>>>         1052 ±  5%     +35.0%       1420 ± 20%  interrupts.CPU203.RES:Rescheduling_interrupts
>>>         1001 ±  3%     +41.0%       1411 ± 19%  interrupts.CPU204.RES:Rescheduling_interrupts
>>>         1140 ±  4%     +31.4%       1498 ±  7%  interrupts.CPU206.RES:Rescheduling_interrupts
>>>         1288 ±  5%     +27.6%       1643 ±  3%  interrupts.CPU208.RES:Rescheduling_interrupts
>>>         1131 ± 13%     +60.9%       1821 ± 44%  interrupts.CPU21.NMI:Non-maskable_interrupts
>>>         1131 ± 13%     +60.9%       1821 ± 44%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
>>>         1126 ±  2%     +29.1%       1454 ± 13%  interrupts.CPU210.RES:Rescheduling_interrupts
>>>        10556 ±  3%      -8.9%       9618 ±  2%  interrupts.CPU210.TLB:TLB_shootdowns
>>>         1042 ± 12%     +42.8%       1489 ±  9%  interrupts.CPU211.RES:Rescheduling_interrupts
>>>         1156 ± 10%     +18.5%       1371 ±  9%  interrupts.CPU212.RES:Rescheduling_interrupts
>>>         1336 ±  4%     +13.8%       1520 ±  5%  interrupts.CPU213.RES:Rescheduling_interrupts
>>>         1201 ±  5%     +23.0%       1477 ±  8%  interrupts.CPU214.RES:Rescheduling_interrupts
>>>         1622 ±  6%     +36.7%       2219 ± 17%  interrupts.CPU215.RES:Rescheduling_interrupts
>>>         1178 ± 16%     +30.5%       1538 ±  6%  interrupts.CPU216.RES:Rescheduling_interrupts
>>>         1006 ± 13%     +48.5%       1494 ±  7%  interrupts.CPU217.RES:Rescheduling_interrupts
>>>         1603 ± 48%     +40.3%       2248 ± 38%  interrupts.CPU218.NMI:Non-maskable_interrupts
>>>         1603 ± 48%     +40.3%       2248 ± 38%  interrupts.CPU218.PMI:Performance_monitoring_interrupts
>>>         1235 ±  9%     +36.4%       1684 ±  6%  interrupts.CPU218.RES:Rescheduling_interrupts
>>>         1219 ± 13%     +29.3%       1576 ±  8%  interrupts.CPU219.RES:Rescheduling_interrupts
>>>         1153 ± 12%    +145.2%       2828 ± 10%  interrupts.CPU22.NMI:Non-maskable_interrupts
>>>         1153 ± 12%    +145.2%       2828 ± 10%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
>>>       849.50 ±  4%     +25.5%       1066 ±  6%  interrupts.CPU22.RES:Rescheduling_interrupts
>>>         1209 ± 12%     +84.1%       2226 ± 40%  interrupts.CPU220.NMI:Non-maskable_interrupts
>>>         1209 ± 12%     +84.1%       2226 ± 40%  interrupts.CPU220.PMI:Performance_monitoring_interrupts
>>>         1037 ± 10%     +14.3%       1186 ±  3%  interrupts.CPU220.RES:Rescheduling_interrupts
>>>         1092 ±  8%     +31.8%       1440 ± 14%  interrupts.CPU221.RES:Rescheduling_interrupts
>>>         1112 ± 13%     +28.8%       1433 ±  9%  interrupts.CPU222.RES:Rescheduling_interrupts
>>>         1220 ±  9%     +32.8%       1620 ±  7%  interrupts.CPU223.RES:Rescheduling_interrupts
>>>         1515 ± 34%     +42.5%       2159 ± 28%  interrupts.CPU226.NMI:Non-maskable_interrupts
>>>         1515 ± 34%     +42.5%       2159 ± 28%  interrupts.CPU226.PMI:Performance_monitoring_interrupts
>>>         1083 ±  8%     +33.0%       1441 ± 13%  interrupts.CPU226.RES:Rescheduling_interrupts
>>>       956.50 ± 11%     +23.7%       1183 ±  8%  interrupts.CPU227.RES:Rescheduling_interrupts
>>>         1180 ±  3%     +38.2%       1631 ± 18%  interrupts.CPU228.RES:Rescheduling_interrupts
>>>         1223 ± 11%     +20.1%       1468 ±  9%  interrupts.CPU229.NMI:Non-maskable_interrupts
>>>         1223 ± 11%     +20.1%       1468 ±  9%  interrupts.CPU229.PMI:Performance_monitoring_interrupts
>>>         1149 ± 12%     +58.3%       1819 ± 44%  interrupts.CPU23.NMI:Non-maskable_interrupts
>>>         1149 ± 12%     +58.3%       1819 ± 44%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
>>>       726.75 ±  4%     +32.6%     963.50 ±  6%  interrupts.CPU23.RES:Rescheduling_interrupts
>>>         1013 ±  7%     +35.2%       1370 ± 14%  interrupts.CPU230.RES:Rescheduling_interrupts
>>>         1004 ±  5%     +29.5%       1300 ±  8%  interrupts.CPU231.RES:Rescheduling_interrupts
>>>         1213 ± 13%    +141.5%       2929 ±  9%  interrupts.CPU233.NMI:Non-maskable_interrupts
>>>         1213 ± 13%    +141.5%       2929 ±  9%  interrupts.CPU233.PMI:Performance_monitoring_interrupts
>>>         1013 ±  9%     +22.5%       1241 ±  8%  interrupts.CPU233.RES:Rescheduling_interrupts
>>>         1177 ± 13%     +80.2%       2121 ± 29%  interrupts.CPU234.NMI:Non-maskable_interrupts
>>>         1177 ± 13%     +80.2%       2121 ± 29%  interrupts.CPU234.PMI:Performance_monitoring_interrupts
>>>         1515 ± 35%     +68.0%       2545 ± 26%  interrupts.CPU237.NMI:Non-maskable_interrupts
>>>         1515 ± 35%     +68.0%       2545 ± 26%  interrupts.CPU237.PMI:Performance_monitoring_interrupts
>>>         1770 ± 29%     +64.4%       2910 ± 10%  interrupts.CPU238.NMI:Non-maskable_interrupts
>>>         1770 ± 29%     +64.4%       2910 ± 10%  interrupts.CPU238.PMI:Performance_monitoring_interrupts
>>>         1000 ± 10%     +23.4%       1233 ±  3%  interrupts.CPU238.RES:Rescheduling_interrupts
>>>         1178 ±  6%     +23.5%       1456 ±  8%  interrupts.CPU239.RES:Rescheduling_interrupts
>>>         1151 ± 14%    +115.7%       2483 ± 27%  interrupts.CPU24.NMI:Non-maskable_interrupts
>>>         1151 ± 14%    +115.7%       2483 ± 27%  interrupts.CPU24.PMI:Performance_monitoring_interrupts
>>>       823.00 ±  9%     +51.7%       1248 ± 19%  interrupts.CPU24.RES:Rescheduling_interrupts
>>>         1217 ± 15%     +22.9%       1496 ±  8%  interrupts.CPU240.RES:Rescheduling_interrupts
>>>         1014 ±  4%     +54.4%       1565 ± 20%  interrupts.CPU242.RES:Rescheduling_interrupts
>>>        10616 ±  3%      -8.3%       9731        interrupts.CPU242.TLB:TLB_shootdowns
>>>         1043 ± 11%     +36.3%       1422 ± 16%  interrupts.CPU243.RES:Rescheduling_interrupts
>>>         1215 ± 11%     +83.3%       2227 ± 40%  interrupts.CPU247.NMI:Non-maskable_interrupts
>>>         1215 ± 11%     +83.3%       2227 ± 40%  interrupts.CPU247.PMI:Performance_monitoring_interrupts
>>>         1499 ± 34%     +68.8%       2531 ± 20%  interrupts.CPU248.NMI:Non-maskable_interrupts
>>>         1499 ± 34%     +68.8%       2531 ± 20%  interrupts.CPU248.PMI:Performance_monitoring_interrupts
>>>         1034 ±  5%     +28.3%       1327 ± 15%  interrupts.CPU248.RES:Rescheduling_interrupts
>>>         1103 ± 14%     +25.1%       1380 ±  8%  interrupts.CPU249.RES:Rescheduling_interrupts
>>>         1143 ± 13%     +49.8%       1712 ± 24%  interrupts.CPU25.NMI:Non-maskable_interrupts
>>>         1143 ± 13%     +49.8%       1712 ± 24%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
>>>       749.50 ±  9%     +24.9%     936.25 ±  4%  interrupts.CPU25.RES:Rescheduling_interrupts
>>>        10842 ±  2%      -8.8%       9885 ±  2%  interrupts.CPU25.TLB:TLB_shootdowns
>>>         1099 ±  5%     +18.0%       1297 ±  3%  interrupts.CPU251.RES:Rescheduling_interrupts
>>>       993.25 ± 11%     +23.1%       1223 ±  5%  interrupts.CPU252.RES:Rescheduling_interrupts
>>>         1017 ± 12%     +34.7%       1369 ± 11%  interrupts.CPU253.RES:Rescheduling_interrupts
>>>         1532 ± 49%     +44.3%       2211 ± 39%  interrupts.CPU254.NMI:Non-maskable_interrupts
>>>         1532 ± 49%     +44.3%       2211 ± 39%  interrupts.CPU254.PMI:Performance_monitoring_interrupts
>>>       979.50 ± 10%     +29.8%       1271 ± 10%  interrupts.CPU254.RES:Rescheduling_interrupts
>>>       928.50 ±  8%     +43.7%       1334 ± 17%  interrupts.CPU256.RES:Rescheduling_interrupts
>>>         1049 ± 12%     +23.9%       1300 ±  8%  interrupts.CPU257.RES:Rescheduling_interrupts
>>>         1183 ±  4%     +12.5%       1331 ± 10%  interrupts.CPU258.RES:Rescheduling_interrupts
>>>       796.50 ±  6%     +38.3%       1101 ± 23%  interrupts.CPU26.RES:Rescheduling_interrupts
>>>         1087 ±  8%     +28.4%       1396 ±  6%  interrupts.CPU260.RES:Rescheduling_interrupts
>>>         1081 ± 11%     +40.3%       1517 ±  6%  interrupts.CPU261.RES:Rescheduling_interrupts
>>>         1553 ± 48%     +43.8%       2233 ± 39%  interrupts.CPU262.NMI:Non-maskable_interrupts
>>>         1553 ± 48%     +43.8%       2233 ± 39%  interrupts.CPU262.PMI:Performance_monitoring_interrupts
>>>         1270 ± 13%     +29.0%       1638 ± 10%  interrupts.CPU262.RES:Rescheduling_interrupts
>>>         1170 ± 13%     +57.6%       1844 ± 44%  interrupts.CPU264.NMI:Non-maskable_interrupts
>>>         1170 ± 13%     +57.6%       1844 ± 44%  interrupts.CPU264.PMI:Performance_monitoring_interrupts
>>>       899.00 ± 10%     +38.8%       1247 ± 14%  interrupts.CPU264.RES:Rescheduling_interrupts
>>>       912.25 ± 11%     +18.3%       1079 ±  7%  interrupts.CPU267.RES:Rescheduling_interrupts
>>>       703.25 ±  9%     +48.5%       1044 ± 21%  interrupts.CPU27.RES:Rescheduling_interrupts
>>>         1198 ± 12%     +82.4%       2185 ± 40%  interrupts.CPU273.NMI:Non-maskable_interrupts
>>>         1198 ± 12%     +82.4%       2185 ± 40%  interrupts.CPU273.PMI:Performance_monitoring_interrupts
>>>       847.50 ± 10%     +44.9%       1228 ± 18%  interrupts.CPU273.RES:Rescheduling_interrupts
>>>       900.50 ± 19%     +34.2%       1208 ± 17%  interrupts.CPU274.RES:Rescheduling_interrupts
>>>         1175 ± 13%     +82.5%       2145 ± 36%  interrupts.CPU275.NMI:Non-maskable_interrupts
>>>         1175 ± 13%     +82.5%       2145 ± 36%  interrupts.CPU275.PMI:Performance_monitoring_interrupts
>>>       800.50 ±  8%     +35.5%       1084 ± 14%  interrupts.CPU275.RES:Rescheduling_interrupts
>>>       803.00 ±  7%     +55.0%       1244 ± 20%  interrupts.CPU276.RES:Rescheduling_interrupts
>>>       888.50 ± 11%     +40.6%       1249 ±  9%  interrupts.CPU277.RES:Rescheduling_interrupts
>>>        10916           -10.1%       9813 ±  2%  interrupts.CPU277.TLB:TLB_shootdowns
>>>         1035 ±  2%     +23.6%       1280 ±  5%  interrupts.CPU278.RES:Rescheduling_interrupts
>>>       926.75 ±  8%     +37.3%       1272 ± 16%  interrupts.CPU279.RES:Rescheduling_interrupts
>>>       753.25 ± 21%     +42.8%       1076 ±  8%  interrupts.CPU282.RES:Rescheduling_interrupts
>>>         1183 ± 12%     +55.6%       1841 ± 44%  interrupts.CPU283.NMI:Non-maskable_interrupts
>>>         1183 ± 12%     +55.6%       1841 ± 44%  interrupts.CPU283.PMI:Performance_monitoring_interrupts
>>>         1187 ± 11%    +112.7%       2525 ± 27%  interrupts.CPU284.NMI:Non-maskable_interrupts
>>>         1187 ± 11%    +112.7%       2525 ± 27%  interrupts.CPU284.PMI:Performance_monitoring_interrupts
>>>         2063 ± 28%     +38.7%       2863 ±  9%  interrupts.CPU285.NMI:Non-maskable_interrupts
>>>         2063 ± 28%     +38.7%       2863 ±  9%  interrupts.CPU285.PMI:Performance_monitoring_interrupts
>>>       854.25 ±  3%     +27.0%       1084 ±  5%  interrupts.CPU286.RES:Rescheduling_interrupts
>>>       729.50 ± 11%     +33.3%     972.75 ±  5%  interrupts.CPU287.RES:Rescheduling_interrupts
>>>         1473 ± 50%     +72.6%       2542 ± 30%  interrupts.CPU29.NMI:Non-maskable_interrupts
>>>         1473 ± 50%     +72.6%       2542 ± 30%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
>>>         1133 ± 13%     +92.6%       2183 ± 39%  interrupts.CPU3.NMI:Non-maskable_interrupts
>>>         1133 ± 13%     +92.6%       2183 ± 39%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
>>>       853.00 ±  5%     +19.3%       1017 ±  4%  interrupts.CPU3.RES:Rescheduling_interrupts
>>>       865.00 ±  5%     +27.6%       1103 ±  9%  interrupts.CPU30.RES:Rescheduling_interrupts
>>>       750.50 ± 10%     +20.9%     907.25 ± 12%  interrupts.CPU31.RES:Rescheduling_interrupts
>>>         1140 ± 13%     +93.0%       2201 ± 40%  interrupts.CPU32.NMI:Non-maskable_interrupts
>>>         1140 ± 13%     +93.0%       2201 ± 40%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
>>>       800.50 ± 10%     +17.9%     944.00 ±  4%  interrupts.CPU32.RES:Rescheduling_interrupts
>>>       836.50 ±  5%     +18.9%     994.50 ±  4%  interrupts.CPU34.RES:Rescheduling_interrupts
>>>       797.00 ±  4%     +21.9%     971.75 ±  6%  interrupts.CPU35.RES:Rescheduling_interrupts
>>>       754.00 ±  4%     +21.2%     914.00 ±  5%  interrupts.CPU36.RES:Rescheduling_interrupts
>>>       616.25 ±  8%     +44.8%     892.25 ± 15%  interrupts.CPU37.RES:Rescheduling_interrupts
>>>       791.25 ±  6%     +32.6%       1049 ± 16%  interrupts.CPU38.RES:Rescheduling_interrupts
>>>       686.75 ±  5%     +34.9%     926.50 ± 14%  interrupts.CPU39.RES:Rescheduling_interrupts
>>>       878.50 ±  6%     +31.6%       1156 ± 16%  interrupts.CPU4.RES:Rescheduling_interrupts
>>>         1180 ± 12%     +85.2%       2185 ± 34%  interrupts.CPU42.NMI:Non-maskable_interrupts
>>>         1180 ± 12%     +85.2%       2185 ± 34%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
>>>       980.75 ± 11%     +39.5%       1367 ± 14%  interrupts.CPU45.RES:Rescheduling_interrupts
>>>         1103 ± 14%     +22.1%       1347 ±  6%  interrupts.CPU46.RES:Rescheduling_interrupts
>>>       925.00 ± 26%     +42.2%       1315 ± 10%  interrupts.CPU47.RES:Rescheduling_interrupts
>>>       960.25 ± 15%     +41.2%       1356 ± 12%  interrupts.CPU48.RES:Rescheduling_interrupts
>>>       921.75 ±  8%     +23.2%       1135 ± 11%  interrupts.CPU49.RES:Rescheduling_interrupts
>>>         1067 ± 15%     +25.3%       1337 ± 10%  interrupts.CPU50.RES:Rescheduling_interrupts
>>>         1076 ±  7%     +49.1%       1605 ± 17%  interrupts.CPU56.RES:Rescheduling_interrupts
>>>        10449 ±  2%      -7.7%       9646 ±  3%  interrupts.CPU56.TLB:TLB_shootdowns
>>>       913.75 ± 13%     +40.9%       1287 ± 13%  interrupts.CPU58.RES:Rescheduling_interrupts
>>>       767.50 ±  8%     +54.1%       1182 ± 14%  interrupts.CPU59.RES:Rescheduling_interrupts
>>>         1374 ± 27%     +79.9%       2473 ± 26%  interrupts.CPU6.NMI:Non-maskable_interrupts
>>>         1374 ± 27%     +79.9%       2473 ± 26%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
>>>       825.00 ± 11%     +38.8%       1145 ± 18%  interrupts.CPU6.RES:Rescheduling_interrupts
>>>         1016 ± 21%     +32.2%       1343 ± 12%  interrupts.CPU60.RES:Rescheduling_interrupts
>>>       802.50 ± 12%     +52.6%       1225 ± 16%  interrupts.CPU61.RES:Rescheduling_interrupts
>>>       895.50 ±  8%     +21.4%       1087 ±  2%  interrupts.CPU62.RES:Rescheduling_interrupts
>>>       973.25 ± 22%     +41.4%       1376 ±  6%  interrupts.CPU66.RES:Rescheduling_interrupts
>>>       854.75 ± 10%     +33.8%       1143 ± 13%  interrupts.CPU67.RES:Rescheduling_interrupts
>>>       771.25 ± 12%     +40.2%       1081 ± 13%  interrupts.CPU69.RES:Rescheduling_interrupts
>>>       621.50 ±  7%     +45.4%     903.50 ± 12%  interrupts.CPU7.RES:Rescheduling_interrupts
>>>         1169 ±  7%     +24.5%       1455 ±  5%  interrupts.CPU70.RES:Rescheduling_interrupts
>>>        10547 ±  2%      -8.5%       9654        interrupts.CPU70.TLB:TLB_shootdowns
>>>         1574 ± 12%     +34.4%       2115 ± 11%  interrupts.CPU71.RES:Rescheduling_interrupts
>>>         1456 ± 29%     +49.9%       2183 ± 35%  interrupts.CPU72.NMI:Non-maskable_interrupts
>>>         1456 ± 29%     +49.9%       2183 ± 35%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
>>>         1183 ± 12%     +25.6%       1485 ±  8%  interrupts.CPU72.RES:Rescheduling_interrupts
>>>         1514 ± 33%     +41.4%       2142 ± 27%  interrupts.CPU73.NMI:Non-maskable_interrupts
>>>         1514 ± 33%     +41.4%       2142 ± 27%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
>>>       986.75 ± 21%     +56.7%       1546 ± 14%  interrupts.CPU73.RES:Rescheduling_interrupts
>>>         1001 ±  4%     +35.5%       1356 ±  7%  interrupts.CPU76.RES:Rescheduling_interrupts
>>>         1004 ± 10%     +22.4%       1229 ± 11%  interrupts.CPU77.RES:Rescheduling_interrupts
>>>       897.25 ±  9%     +34.5%       1206 ± 19%  interrupts.CPU78.RES:Rescheduling_interrupts
>>>       785.75 ± 11%     +25.6%     987.00 ±  4%  interrupts.CPU8.RES:Rescheduling_interrupts
>>>       943.75 ±  9%     +29.1%       1218 ± 12%  interrupts.CPU81.RES:Rescheduling_interrupts
>>>       991.75 ±  2%     +37.9%       1367 ± 17%  interrupts.CPU82.RES:Rescheduling_interrupts
>>>         1177 ± 12%     +58.9%       1870 ± 44%  interrupts.CPU83.NMI:Non-maskable_interrupts
>>>         1177 ± 12%     +58.9%       1870 ± 44%  interrupts.CPU83.PMI:Performance_monitoring_interrupts
>>>         1170 ± 15%     +17.1%       1370 ±  6%  interrupts.CPU83.RES:Rescheduling_interrupts
>>>         1499 ± 30%     +45.9%       2188 ± 34%  interrupts.CPU86.NMI:Non-maskable_interrupts
>>>         1499 ± 30%     +45.9%       2188 ± 34%  interrupts.CPU86.PMI:Performance_monitoring_interrupts
>>>         1193 ± 10%    +109.8%       2502 ± 20%  interrupts.CPU87.NMI:Non-maskable_interrupts
>>>         1193 ± 10%    +109.8%       2502 ± 20%  interrupts.CPU87.PMI:Performance_monitoring_interrupts
>>>         1145 ± 14%     +31.2%       1502 ±  7%  interrupts.CPU87.RES:Rescheduling_interrupts
>>>         1177 ±  6%     +21.1%       1426 ±  8%  interrupts.CPU88.RES:Rescheduling_interrupts
>>>         1140 ± 14%     +91.1%       2179 ± 40%  interrupts.CPU9.NMI:Non-maskable_interrupts
>>>         1140 ± 14%     +91.1%       2179 ± 40%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
>>>       676.75 ± 10%     +41.2%     955.25 ± 11%  interrupts.CPU9.RES:Rescheduling_interrupts
>>>         1195 ± 11%     +56.7%       1872 ± 43%  interrupts.CPU90.NMI:Non-maskable_interrupts
>>>         1195 ± 11%     +56.7%       1872 ± 43%  interrupts.CPU90.PMI:Performance_monitoring_interrupts
>>>         2083 ± 27%     +40.0%       2917 ± 10%  interrupts.CPU95.NMI:Non-maskable_interrupts
>>>         2083 ± 27%     +40.0%       2917 ± 10%  interrupts.CPU95.PMI:Performance_monitoring_interrupts
>>>         1110 ±  6%     +14.4%       1270 ± 11%  interrupts.CPU95.RES:Rescheduling_interrupts
>>>         1110 ±  6%     +41.0%       1566 ± 18%  interrupts.CPU98.RES:Rescheduling_interrupts
>>>       984.75 ±  9%     +58.2%       1557 ± 19%  interrupts.CPU99.RES:Rescheduling_interrupts
>>>       310787 ±  6%     +23.6%     384165 ±  4%  interrupts.RES:Rescheduling_interrupts
>>>        33134 ±  2%     +14.7%      38003 ±  6%  softirqs.CPU0.SCHED
>>>        27079 ±  2%     +17.4%      31779 ±  3%  softirqs.CPU1.SCHED
>>>       162495            +8.8%     176829 ±  4%  softirqs.CPU1.TIMER
>>>        26465           +19.2%      31556 ±  3%  softirqs.CPU10.SCHED
>>>        25261 ±  3%     +16.4%      29411 ±  3%  softirqs.CPU100.SCHED
>>>        25450           +18.5%      30153 ±  4%  softirqs.CPU101.SCHED
>>>        25169 ±  2%     +19.3%      30020 ±  3%  softirqs.CPU102.SCHED
>>>        24805 ±  3%     +20.5%      29893 ±  3%  softirqs.CPU103.SCHED
>>>        25132 ±  3%     +18.9%      29875 ±  3%  softirqs.CPU104.SCHED
>>>       177301 ±  2%     +11.3%     197274 ±  4%  softirqs.CPU104.TIMER
>>>        24869 ±  3%     +18.8%      29537 ±  2%  softirqs.CPU105.SCHED
>>>        25032 ±  2%     +17.7%      29462 ±  3%  softirqs.CPU106.SCHED
>>>        24317           +22.3%      29729 ±  3%  softirqs.CPU107.SCHED
>>>        25241 ±  3%     +18.5%      29917 ±  2%  softirqs.CPU108.SCHED
>>>        25571 ±  2%     +17.6%      30075 ±  3%  softirqs.CPU109.SCHED
>>>        25910           +17.9%      30551 ±  3%  softirqs.CPU11.SCHED
>>>        24927 ±  2%     +18.5%      29538 ±  4%  softirqs.CPU110.SCHED
>>>        25019 ±  2%     +19.2%      29833 ±  4%  softirqs.CPU111.SCHED
>>>        25067 ±  2%     +18.7%      29743 ±  4%  softirqs.CPU112.SCHED
>>>        25105 ±  2%     +19.1%      29892 ±  2%  softirqs.CPU113.SCHED
>>>        25603 ±  2%     +16.2%      29753 ±  4%  softirqs.CPU114.SCHED
>>>        25517 ±  2%     +17.9%      30096 ±  3%  softirqs.CPU115.SCHED
>>>       176346 ±  5%     +11.4%     196390 ±  4%  softirqs.CPU115.TIMER
>>>        24988 ±  2%     +17.3%      29299 ±  4%  softirqs.CPU116.SCHED
>>>        24362           +22.1%      29748 ±  2%  softirqs.CPU117.SCHED
>>>        25420 ±  2%     +18.4%      30101 ±  3%  softirqs.CPU118.SCHED
>>>        25202           +17.2%      29531 ±  3%  softirqs.CPU119.SCHED
>>>       246.00 ± 32%   +5886.8%      14727 ±166%  softirqs.CPU12.NET_RX
>>>        25808 ±  2%     +19.6%      30866 ±  4%  softirqs.CPU12.SCHED
>>>       161592 ±  4%     +26.1%     203759 ± 17%  softirqs.CPU12.TIMER
>>>        25550           +16.3%      29721 ±  3%  softirqs.CPU120.SCHED
>>>       172644 ±  4%     +13.1%     195269 ±  4%  softirqs.CPU120.TIMER
>>>        24062 ±  5%     +24.3%      29898 ±  3%  softirqs.CPU121.SCHED
>>>       173612 ±  4%     +12.4%     195124 ±  3%  softirqs.CPU121.TIMER
>>>        24774 ±  3%     +20.1%      29742 ±  2%  softirqs.CPU122.SCHED
>>>        25233 ±  2%     +18.4%      29878 ±  2%  softirqs.CPU123.SCHED
>>>        25038 ±  2%     +18.0%      29548 ±  4%  softirqs.CPU124.SCHED
>>>        24756           +19.1%      29485 ±  3%  softirqs.CPU125.SCHED
>>>        25079           +19.2%      29903 ±  3%  softirqs.CPU126.SCHED
>>>        25110           +17.9%      29598 ±  3%  softirqs.CPU127.SCHED
>>>        24869 ±  3%     +19.6%      29754 ±  3%  softirqs.CPU128.SCHED
>>>        25255 ±  2%     +17.6%      29710 ±  3%  softirqs.CPU129.SCHED
>>>        26257           +22.8%      32254 ±  3%  softirqs.CPU13.SCHED
>>>        25274 ±  2%     +19.3%      30153 ±  2%  softirqs.CPU130.SCHED
>>>        25219 ±  2%     +15.4%      29103 ±  2%  softirqs.CPU131.SCHED
>>>        25034 ±  2%     +19.3%      29869 ±  2%  softirqs.CPU132.SCHED
>>>        25448           +17.1%      29792        softirqs.CPU133.SCHED
>>>        25064           +17.5%      29450 ±  4%  softirqs.CPU134.SCHED
>>>        25561 ±  2%     +16.4%      29742 ±  4%  softirqs.CPU135.SCHED
>>>        25620           +17.3%      30041 ±  3%  softirqs.CPU136.SCHED
>>>       174761 ±  6%     +11.1%     194097 ±  7%  softirqs.CPU136.TIMER
>>>        26235 ±  2%     +14.8%      30124 ±  2%  softirqs.CPU137.SCHED
>>>       169540 ±  4%     +13.3%     192089 ±  3%  softirqs.CPU137.TIMER
>>>        25194           +18.3%      29808 ±  3%  softirqs.CPU138.SCHED
>>>        25038 ±  4%     +19.7%      29982 ±  4%  softirqs.CPU139.SCHED
>>>        26136 ±  2%     +20.5%      31494 ±  2%  softirqs.CPU14.SCHED
>>>        25185           +20.2%      30269 ±  3%  softirqs.CPU140.SCHED
>>>        25032           +20.2%      30098 ±  2%  softirqs.CPU141.SCHED
>>>        25247 ±  2%     +16.9%      29514        softirqs.CPU142.SCHED
>>>        24775           +12.9%      27962 ±  6%  softirqs.CPU143.SCHED
>>>        25196           +19.1%      30016 ±  3%  softirqs.CPU144.SCHED
>>>        24907 ±  2%     +18.4%      29495 ±  3%  softirqs.CPU145.SCHED
>>>        25254           +16.3%      29359 ±  4%  softirqs.CPU146.SCHED
>>>        25123           +19.8%      30089 ±  3%  softirqs.CPU147.SCHED
>>>        25311 ±  6%     +17.6%      29757 ±  5%  softirqs.CPU148.SCHED
>>>        25020 ±  2%     +20.4%      30121 ±  2%  softirqs.CPU149.SCHED
>>>        26013           +19.5%      31094 ±  2%  softirqs.CPU15.SCHED
>>>        25040           +19.1%      29828 ±  4%  softirqs.CPU150.SCHED
>>>        25358           +20.1%      30458 ±  2%  softirqs.CPU151.SCHED
>>>       175966 ±  6%     +11.6%     196369 ±  4%  softirqs.CPU151.TIMER
>>>        24847 ±  2%     +20.7%      30003 ±  2%  softirqs.CPU152.SCHED
>>>        24860 ±  4%     +19.9%      29811 ±  3%  softirqs.CPU153.SCHED
>>>        25102 ±  3%     +18.0%      29611 ±  3%  softirqs.CPU154.SCHED
>>>        24819           +20.0%      29792 ±  3%  softirqs.CPU155.SCHED
>>>        25414 ±  2%     +17.3%      29808        softirqs.CPU156.SCHED
>>>       176417 ±  5%     +15.6%     203967 ±  5%  softirqs.CPU156.TIMER
>>>        25556           +16.1%      29663 ±  4%  softirqs.CPU157.SCHED
>>>        25241 ±  2%     +19.9%      30256 ±  3%  softirqs.CPU158.SCHED
>>>        25462           +17.9%      30017 ±  2%  softirqs.CPU159.SCHED
>>>        25909           +18.5%      30694 ±  3%  softirqs.CPU16.SCHED
>>>        25139           +18.1%      29684 ±  4%  softirqs.CPU160.SCHED
>>>        25431           +17.2%      29812 ±  4%  softirqs.CPU161.SCHED
>>>        25712           +18.6%      30483 ±  5%  softirqs.CPU162.SCHED
>>>       172304 ±  4%     +13.1%     194925 ±  4%  softirqs.CPU162.TIMER
>>>        25736           +16.7%      30040 ±  3%  softirqs.CPU163.SCHED
>>>       169697 ±  6%     +16.0%     196768 ±  7%  softirqs.CPU163.TIMER
>>>        25196 ±  2%     +17.4%      29591 ±  2%  softirqs.CPU164.SCHED
>>>        24976           +19.1%      29753 ±  2%  softirqs.CPU165.SCHED
>>>        25153 ±  2%     +18.0%      29682 ±  2%  softirqs.CPU166.SCHED
>>>        24977           +19.7%      29886 ±  2%  softirqs.CPU167.SCHED
>>>        24784 ±  3%     +18.9%      29457 ±  3%  softirqs.CPU168.SCHED
>>>        25266 ±  2%     +17.1%      29596 ±  4%  softirqs.CPU169.SCHED
>>>        25886 ±  2%     +19.3%      30876 ±  3%  softirqs.CPU17.SCHED
>>>        24920           +17.6%      29295 ±  3%  softirqs.CPU170.SCHED
>>>        24993           +18.7%      29660 ±  3%  softirqs.CPU171.SCHED
>>>        25422           +17.1%      29763 ±  2%  softirqs.CPU172.SCHED
>>>        25491 ±  2%     +17.7%      29994 ±  3%  softirqs.CPU173.SCHED
>>>        25264 ±  2%     +16.8%      29518 ±  6%  softirqs.CPU174.SCHED
>>>        25266 ±  2%     +17.9%      29791 ±  2%  softirqs.CPU175.SCHED
>>>        25231 ±  2%     +17.9%      29754 ±  3%  softirqs.CPU176.SCHED
>>>       183212 ±  2%     +10.0%     201572 ±  2%  softirqs.CPU176.TIMER
>>>        25273 ±  2%     +18.3%      29899 ±  3%  softirqs.CPU177.SCHED
>>>        25155           +19.8%      30145 ±  2%  softirqs.CPU178.SCHED
>>>        25499 ±  2%     +16.0%      29576 ±  5%  softirqs.CPU179.SCHED
>>>        26339           +16.3%      30634 ±  2%  softirqs.CPU18.SCHED
>>>        24757 ±  4%     +19.2%      29500 ±  2%  softirqs.CPU180.SCHED
>>>        25192 ±  3%     +14.7%      28898 ±  5%  softirqs.CPU181.SCHED
>>>        25166 ±  2%     +19.2%      29999 ±  2%  softirqs.CPU182.SCHED
>>>        25259 ±  2%     +18.4%      29910 ±  4%  softirqs.CPU183.SCHED
>>>        25247 ±  2%     +16.9%      29519 ±  4%  softirqs.CPU184.SCHED
>>>        25415 ±  2%     +16.9%      29715 ±  2%  softirqs.CPU185.SCHED
>>>       180421 ±  5%     +11.4%     200946 ±  3%  softirqs.CPU185.TIMER
>>>        24973 ±  3%     +16.3%      29053        softirqs.CPU186.SCHED
>>>        25525 ±  2%     +16.1%      29625 ±  2%  softirqs.CPU187.SCHED
>>>        25461           +18.2%      30088 ±  2%  softirqs.CPU188.SCHED
>>>        24833           +20.5%      29936 ±  2%  softirqs.CPU189.SCHED
>>>        25894           +17.1%      30332 ±  4%  softirqs.CPU19.SCHED
>>>       162878 ±  4%     +18.0%     192168 ± 14%  softirqs.CPU19.TIMER
>>>        25062           +18.4%      29663 ±  2%  softirqs.CPU190.SCHED
>>>        24867           +18.3%      29425 ±  3%  softirqs.CPU191.SCHED
>>>        24926           +18.8%      29620 ±  2%  softirqs.CPU192.SCHED
>>>       183126 ±  5%     +11.9%     204971 ±  2%  softirqs.CPU192.TIMER
>>>        24864 ±  2%     +16.2%      28893 ±  4%  softirqs.CPU193.SCHED
>>>        25242           +17.7%      29702 ±  2%  softirqs.CPU194.SCHED
>>>        25230 ±  2%     +17.4%      29626 ±  3%  softirqs.CPU195.SCHED
>>>        24981 ±  2%     +18.8%      29680 ±  2%  softirqs.CPU196.SCHED
>>>        25020           +17.3%      29348 ±  6%  softirqs.CPU197.SCHED
>>>        25272           +18.5%      29942 ±  3%  softirqs.CPU198.SCHED
>>>        25221 ±  2%     +18.8%      29968 ±  3%  softirqs.CPU199.SCHED
>>>       182100 ±  4%      +8.3%     197211 ±  3%  softirqs.CPU199.TIMER
>>>        26451           +18.1%      31251 ±  3%  softirqs.CPU2.SCHED
>>>        26194           +18.4%      31019 ±  2%  softirqs.CPU20.SCHED
>>>        25645 ±  2%     +17.6%      30168 ±  3%  softirqs.CPU200.SCHED
>>>        25337           +20.0%      30393 ±  3%  softirqs.CPU201.SCHED
>>>        25160           +19.0%      29945 ±  2%  softirqs.CPU202.SCHED
>>>        25322 ±  2%     +18.3%      29944 ±  3%  softirqs.CPU203.SCHED
>>>        25076           +20.2%      30130 ±  3%  softirqs.CPU204.SCHED
>>>        25542           +19.2%      30455 ±  2%  softirqs.CPU205.SCHED
>>>        25245 ±  2%     +16.7%      29455 ±  2%  softirqs.CPU206.SCHED
>>>        25317 ±  2%     +17.5%      29743 ±  3%  softirqs.CPU207.SCHED
>>>        25283 ±  2%     +18.5%      29958 ±  4%  softirqs.CPU208.SCHED
>>>        25533           +12.9%      28839 ±  6%  softirqs.CPU209.SCHED
>>>       176766 ±  3%     +13.1%     199978 ±  2%  softirqs.CPU209.TIMER
>>>        26093           +18.6%      30954 ±  3%  softirqs.CPU21.SCHED
>>>        25426 ±  2%     +17.8%      29963 ±  3%  softirqs.CPU210.SCHED
>>>        25363 ±  2%     +17.5%      29794        softirqs.CPU211.SCHED
>>>        25056 ±  2%     +18.3%      29644 ±  5%  softirqs.CPU212.SCHED
>>>        24915 ±  2%     +18.8%      29602 ±  3%  softirqs.CPU213.SCHED
>>>        25269 ±  2%     +19.9%      30296 ±  2%  softirqs.CPU214.SCHED
>>>        24759 ±  2%     +16.4%      28808 ±  5%  softirqs.CPU215.SCHED
>>>        25090           +19.8%      30061 ±  2%  softirqs.CPU216.SCHED
>>>        24887 ±  2%     +17.2%      29156        softirqs.CPU217.SCHED
>>>        25021           +17.2%      29336 ±  4%  softirqs.CPU218.SCHED
>>>        25320 ±  2%     +17.7%      29806 ±  2%  softirqs.CPU219.SCHED
>>>        25672 ±  2%     +20.9%      31048        softirqs.CPU22.SCHED
>>>        25182 ±  2%     +18.8%      29919 ±  3%  softirqs.CPU220.SCHED
>>>        25152 ±  2%     +20.3%      30248 ±  4%  softirqs.CPU221.SCHED
>>>        24777           +19.1%      29504 ±  5%  softirqs.CPU222.SCHED
>>>        25122 ±  3%     +19.6%      30041 ±  2%  softirqs.CPU223.SCHED
>>>        25079 ±  2%     +19.4%      29954 ±  2%  softirqs.CPU224.SCHED
>>>        25236 ±  2%     +18.8%      29969 ±  2%  softirqs.CPU225.SCHED
>>>        25105 ±  3%     +19.0%      29876 ±  2%  softirqs.CPU226.SCHED
>>>        25609           +15.6%      29613 ±  4%  softirqs.CPU227.SCHED
>>>       180136 ±  8%     +11.0%     200040 ±  5%  softirqs.CPU227.TIMER
>>>        25435           +15.9%      29476 ±  2%  softirqs.CPU228.SCHED
>>>       175813 ±  3%     +16.7%     205108 ±  5%  softirqs.CPU228.TIMER
>>>        25142 ±  2%     +14.1%      28699 ±  5%  softirqs.CPU229.SCHED
>>>        25831           +19.2%      30787 ±  2%  softirqs.CPU23.SCHED
>>>        25460 ±  2%     +18.8%      30242 ±  3%  softirqs.CPU230.SCHED
>>>        25200 ±  3%     +20.1%      30259 ±  2%  softirqs.CPU231.SCHED
>>>       168374 ±  3%      +8.7%     183098 ±  3%  softirqs.CPU231.TIMER
>>>        25379 ±  2%     +17.1%      29711 ±  2%  softirqs.CPU232.SCHED
>>>        25524 ±  2%     +18.5%      30246 ±  3%  softirqs.CPU233.SCHED
>>>        25686 ±  2%     +17.5%      30170 ±  3%  softirqs.CPU234.SCHED
>>>       170330 ±  4%     +11.3%     189542 ±  5%  softirqs.CPU234.TIMER
>>>        25635 ±  2%     +14.7%      29410 ±  4%  softirqs.CPU235.SCHED
>>>       176292 ±  7%     +15.9%     204389 ±  6%  softirqs.CPU235.TIMER
>>>        25549 ±  2%     +16.3%      29718 ±  2%  softirqs.CPU236.SCHED
>>>       178538 ±  4%      +9.2%     194880 ±  4%  softirqs.CPU236.TIMER
>>>        25386 ±  2%     +18.4%      30055 ±  2%  softirqs.CPU237.SCHED
>>>        25191 ±  2%     +17.9%      29707        softirqs.CPU238.SCHED
>>>        25186 ±  3%     +20.3%      30293        softirqs.CPU239.SCHED
>>>        25877           +19.0%      30799 ±  3%  softirqs.CPU24.SCHED
>>>        25506           +17.5%      29967 ±  3%  softirqs.CPU240.SCHED
>>>        24964 ±  2%     +21.1%      30222 ±  3%  softirqs.CPU241.SCHED
>>>        25258           +17.7%      29719 ±  2%  softirqs.CPU242.SCHED
>>>        25162           +18.2%      29740 ±  4%  softirqs.CPU243.SCHED
>>>        25808           +17.3%      30285 ±  3%  softirqs.CPU244.SCHED
>>>        25679           +17.4%      30150 ±  3%  softirqs.CPU245.SCHED
>>>       175664 ±  3%      +8.3%     190327 ±  4%  softirqs.CPU245.TIMER
>>>        25134 ±  2%     +19.7%      30079 ±  4%  softirqs.CPU246.SCHED
>>>        24942           +19.9%      29913 ±  3%  softirqs.CPU247.SCHED
>>>        25395 ±  2%     +17.8%      29906 ±  2%  softirqs.CPU248.SCHED
>>>       180993 ±  3%     +10.8%     200584 ±  4%  softirqs.CPU248.TIMER
>>>        25491 ±  2%     +18.0%      30075 ±  4%  softirqs.CPU249.SCHED
>>>        26099           +17.2%      30595 ±  3%  softirqs.CPU25.SCHED
>>>        25332           +18.7%      30060 ±  2%  softirqs.CPU250.SCHED
>>>        25471 ±  2%     +17.4%      29892 ±  3%  softirqs.CPU251.SCHED
>>>       180242 ±  4%      +9.8%     197819 ±  4%  softirqs.CPU251.TIMER
>>>        25406 ±  2%     +16.9%      29694 ±  3%  softirqs.CPU252.SCHED
>>>        25317 ±  3%     +18.2%      29922 ±  3%  softirqs.CPU253.SCHED
>>>        25103 ±  4%     +19.9%      30106 ±  3%  softirqs.CPU254.SCHED
>>>        25231 ±  2%     +19.8%      30227 ±  3%  softirqs.CPU255.SCHED
>>>        25509 ±  2%     +18.2%      30161 ±  3%  softirqs.CPU256.SCHED
>>>        25559 ±  3%     +16.9%      29888 ±  3%  softirqs.CPU257.SCHED
>>>        25277 ±  2%     +16.8%      29523 ±  2%  softirqs.CPU258.SCHED
>>>        24695 ±  5%     +20.4%      29721 ±  2%  softirqs.CPU259.SCHED
>>>       182550 ±  5%     +10.5%     201781 ±  3%  softirqs.CPU259.TIMER
>>>        25905           +19.5%      30970 ±  2%  softirqs.CPU26.SCHED
>>>       164306 ±  3%      +7.6%     176738 ±  5%  softirqs.CPU26.TIMER
>>>        24829 ±  2%     +20.8%      29990 ±  2%  softirqs.CPU260.SCHED
>>>        25156           +19.1%      29971 ±  2%  softirqs.CPU261.SCHED
>>>        25098 ±  3%     +17.6%      29515 ±  4%  softirqs.CPU262.SCHED
>>>       180807 ±  5%      +9.4%     197856 ±  3%  softirqs.CPU262.TIMER
>>>        25053 ±  2%     +18.2%      29613 ±  2%  softirqs.CPU263.SCHED
>>>        25505           +18.9%      30336 ±  3%  softirqs.CPU264.SCHED
>>>       169958 ±  5%     +11.8%     189979 ±  4%  softirqs.CPU264.TIMER
>>>        25011 ±  3%     +18.5%      29640 ±  4%  softirqs.CPU265.SCHED
>>>       169719 ±  4%     +22.2%     207453 ±  8%  softirqs.CPU265.TIMER
>>>        25489 ±  2%     +18.6%      30231 ±  3%  softirqs.CPU266.SCHED
>>>        25727           +18.8%      30554 ±  2%  softirqs.CPU267.SCHED
>>>        25423           +18.1%      30020 ±  2%  softirqs.CPU268.SCHED
>>>        25451 ±  2%     +19.0%      30292 ±  4%  softirqs.CPU269.SCHED
>>>        26042           +18.5%      30852 ±  3%  softirqs.CPU27.SCHED
>>>       163812 ±  3%      +8.6%     177825 ±  5%  softirqs.CPU27.TIMER
>>>        25649 ±  2%     +18.3%      30337 ±  3%  softirqs.CPU270.SCHED
>>>        25318           +19.3%      30212 ±  3%  softirqs.CPU271.SCHED
>>>        25592 ±  2%     +19.6%      30603 ±  3%  softirqs.CPU272.SCHED
>>>        25440 ±  2%     +20.0%      30520 ±  3%  softirqs.CPU273.SCHED
>>>        26007           +18.2%      30741 ±  2%  softirqs.CPU274.SCHED
>>>        25661           +18.7%      30454 ±  3%  softirqs.CPU275.SCHED
>>>        25227           +21.0%      30536 ±  2%  softirqs.CPU276.SCHED
>>>        25923           +17.9%      30560 ±  3%  softirqs.CPU277.SCHED
>>>        25973           +14.6%      29757 ±  5%  softirqs.CPU278.SCHED
>>>        25905 ±  2%     +16.2%      30089 ±  3%  softirqs.CPU279.SCHED
>>>        26091           +18.3%      30875 ±  3%  softirqs.CPU28.SCHED
>>>        25736 ±  2%     +17.4%      30217 ±  4%  softirqs.CPU280.SCHED
>>>        25964           +13.5%      29482 ±  6%  softirqs.CPU281.SCHED
>>>       170413 ±  4%     +11.8%     190550 ±  4%  softirqs.CPU281.TIMER
>>>        25669           +18.8%      30484 ±  3%  softirqs.CPU282.SCHED
>>>        25462 ±  2%     +18.6%      30208        softirqs.CPU283.SCHED
>>>       174059 ±  6%     +10.6%     192446 ±  5%  softirqs.CPU283.TIMER
>>>        25578           +18.4%      30287 ±  3%  softirqs.CPU284.SCHED
>>>        25703           +19.1%      30617 ±  3%  softirqs.CPU285.SCHED
>>>        25775 ±  2%     +16.0%      29891 ±  2%  softirqs.CPU286.SCHED
>>>        25175 ±  2%     +16.0%      29204 ±  4%  softirqs.CPU287.SCHED
>>>        26076           +17.7%      30684 ±  3%  softirqs.CPU29.SCHED
>>>        26116           +18.8%      31032 ±  2%  softirqs.CPU3.SCHED
>>>        26043           +18.2%      30789 ±  3%  softirqs.CPU30.SCHED
>>>        25884           +18.5%      30681 ±  2%  softirqs.CPU31.SCHED
>>>       167289 ±  2%      +6.3%     177832 ±  6%  softirqs.CPU31.TIMER
>>>        26095           +17.1%      30563 ±  3%  softirqs.CPU32.SCHED
>>>       161186 ±  2%     +10.6%     178192 ±  4%  softirqs.CPU32.TIMER
>>>        26124           +18.2%      30887 ±  3%  softirqs.CPU33.SCHED
>>>        25966           +18.0%      30651 ±  2%  softirqs.CPU34.SCHED
>>>       167402 ±  4%      +6.6%     178425 ±  4%  softirqs.CPU34.TIMER
>>>        25944           +18.0%      30622 ±  3%  softirqs.CPU35.SCHED
>>>        26167           +17.9%      30861 ±  2%  softirqs.CPU36.SCHED
>>>        25900           +20.7%      31271 ±  3%  softirqs.CPU37.SCHED
>>>        25475 ±  3%     +21.1%      30843 ±  3%  softirqs.CPU38.SCHED
>>>        25642 ±  2%     +19.4%      30627 ±  3%  softirqs.CPU39.SCHED
>>>        25494 ±  2%     +20.7%      30774 ±  2%  softirqs.CPU4.SCHED
>>>        25610           +18.1%      30236 ±  4%  softirqs.CPU40.SCHED
>>>        26064 ±  3%     +17.2%      30546 ±  3%  softirqs.CPU41.SCHED
>>>        25739 ±  2%     +15.2%      29643 ±  4%  softirqs.CPU42.SCHED
>>>        25730 ±  2%     +18.5%      30493 ±  3%  softirqs.CPU43.SCHED
>>>       175037 ±  6%     +10.6%     193664 ±  4%  softirqs.CPU43.TIMER
>>>        25729           +18.4%      30470 ±  3%  softirqs.CPU44.SCHED
>>>        25114 ±  2%     +21.3%      30475 ±  2%  softirqs.CPU45.SCHED
>>>        25415 ±  3%     +20.1%      30511 ±  2%  softirqs.CPU46.SCHED
>>>        25558           +17.4%      29994        softirqs.CPU47.SCHED
>>>        25624           +16.7%      29897 ±  4%  softirqs.CPU48.SCHED
>>>       167429 ±  5%     +13.0%     189268 ±  5%  softirqs.CPU48.TIMER
>>>        25871           +17.3%      30344 ±  3%  softirqs.CPU49.SCHED
>>>       167694 ±  3%     +12.5%     188683 ±  4%  softirqs.CPU49.TIMER
>>>        25681           +20.0%      30819 ±  3%  softirqs.CPU5.SCHED
>>>        25661           +17.8%      30220        softirqs.CPU50.SCHED
>>>        25857           +17.6%      30408 ±  3%  softirqs.CPU51.SCHED
>>>        25943           +17.7%      30544 ±  3%  softirqs.CPU52.SCHED
>>>        25398 ±  2%     +19.6%      30387 ±  3%  softirqs.CPU53.SCHED
>>>        25599 ±  2%     +18.9%      30428 ±  3%  softirqs.CPU54.SCHED
>>>        25454 ±  2%     +20.5%      30663 ±  3%  softirqs.CPU55.SCHED
>>>        25603 ±  2%     +18.6%      30374 ±  3%  softirqs.CPU56.SCHED
>>>        25665           +18.7%      30453 ±  3%  softirqs.CPU57.SCHED
>>>        25853           +18.9%      30740 ±  2%  softirqs.CPU58.SCHED
>>>        25916           +17.5%      30454 ±  3%  softirqs.CPU59.SCHED
>>>        26202           +16.7%      30570 ±  3%  softirqs.CPU6.SCHED
>>>        25549 ±  2%     +20.5%      30778 ±  2%  softirqs.CPU60.SCHED
>>>        25854           +18.5%      30626 ±  2%  softirqs.CPU61.SCHED
>>>        25516 ±  2%     +17.1%      29871 ±  4%  softirqs.CPU62.SCHED
>>>        25833           +17.2%      30284 ±  3%  softirqs.CPU63.SCHED
>>>        25510 ±  3%     +19.2%      30420 ±  3%  softirqs.CPU64.SCHED
>>>        26177           +16.5%      30487 ±  3%  softirqs.CPU65.SCHED
>>>       166747 ±  3%     +11.5%     185900 ±  3%  softirqs.CPU65.TIMER
>>>        25637 ±  2%     +19.0%      30503 ±  3%  softirqs.CPU66.SCHED
>>>        25644 ±  2%     +15.4%      29588        softirqs.CPU67.SCHED
>>>        25796           +18.6%      30585 ±  3%  softirqs.CPU68.SCHED
>>>        25503           +20.2%      30654 ±  3%  softirqs.CPU69.SCHED
>>>        25912           +16.4%      30171 ±  4%  softirqs.CPU7.SCHED
>>>        25994 ±  6%     +16.2%      30203        softirqs.CPU70.SCHED
>>>        25255           +17.9%      29766 ±  3%  softirqs.CPU71.SCHED
>>>        25057           +19.1%      29854 ±  3%  softirqs.CPU72.SCHED
>>>        24925 ±  2%     +18.7%      29588 ±  2%  softirqs.CPU73.SCHED
>>>        25774           +16.1%      29929 ±  3%  softirqs.CPU74.SCHED
>>>       177035 ±  2%      +7.9%     190942 ±  4%  softirqs.CPU74.TIMER
>>>        25433           +19.2%      30327 ±  3%  softirqs.CPU75.SCHED
>>>        25274 ±  2%     +15.5%      29184 ±  3%  softirqs.CPU76.SCHED
>>>        25297           +17.7%      29765 ±  4%  softirqs.CPU77.SCHED
>>>        25557 ±  2%     +18.2%      30203 ±  3%  softirqs.CPU78.SCHED
>>>        25604 ±  2%     +17.3%      30034 ±  3%  softirqs.CPU79.SCHED
>>>       175758 ±  6%      +9.8%     193033 ±  3%  softirqs.CPU79.TIMER
>>>        26086           +18.4%      30878 ±  2%  softirqs.CPU8.SCHED
>>>        25297           +18.6%      30013 ±  3%  softirqs.CPU80.SCHED
>>>        25450           +17.8%      29987 ±  2%  softirqs.CPU81.SCHED
>>>        25125 ±  3%     +17.0%      29404 ±  3%  softirqs.CPU82.SCHED
>>>        24840 ±  2%     +18.7%      29490 ±  6%  softirqs.CPU83.SCHED
>>>        25920           +14.9%      29770 ±  2%  softirqs.CPU84.SCHED
>>>       168708 ±  5%     +18.4%     199703 ±  7%  softirqs.CPU84.TIMER
>>>        24980 ±  3%     +19.5%      29850 ±  3%  softirqs.CPU85.SCHED
>>>        25338           +18.6%      30042 ±  2%  softirqs.CPU86.SCHED
>>>        25404 ±  2%     +18.6%      30142 ±  2%  softirqs.CPU87.SCHED
>>>       177099 ±  3%      +9.0%     193072        softirqs.CPU87.TIMER
>>>        24855 ±  2%     +20.7%      30000 ±  3%  softirqs.CPU88.SCHED
>>>        25532 ±  2%     +17.2%      29916 ±  3%  softirqs.CPU89.SCHED
>>>        26321 ±  2%     +14.7%      30186 ±  4%  softirqs.CPU9.SCHED
>>>        25622 ±  2%     +17.4%      30077 ±  3%  softirqs.CPU90.SCHED
>>>       177491 ±  4%     +10.9%     196822 ±  4%  softirqs.CPU90.TIMER
>>>        25638 ±  2%     +14.0%      29228 ±  5%  softirqs.CPU91.SCHED
>>>       175040 ±  5%     +16.7%     204221 ±  6%  softirqs.CPU91.TIMER
>>>        25387 ±  2%     +18.0%      29968 ±  2%  softirqs.CPU92.SCHED
>>>        25316 ±  2%     +19.5%      30262 ±  2%  softirqs.CPU93.SCHED
>>>        25125 ±  2%     +19.6%      30051        softirqs.CPU94.SCHED
>>>        25303 ±  2%     +18.1%      29875 ±  2%  softirqs.CPU95.SCHED
>>>        25481           +18.3%      30133 ±  3%  softirqs.CPU96.SCHED
>>>        25533           +18.1%      30146 ±  3%  softirqs.CPU97.SCHED
>>>        24892 ±  3%     +20.4%      29982 ±  3%  softirqs.CPU98.SCHED
>>>        24611           +20.3%      29607 ±  3%  softirqs.CPU99.SCHED
>>>      7325587           +18.2%    8660780 ±  3%  softirqs.SCHED
>>>
>>>
>>>                              will-it-scale.per_thread_ops
>>>     1500 +--------------------------------------------------------------------+
>>>     1450 |+. +.  .+  +++. +.  .+++. +.  .++. +                                |
>>>          |  +  ++        +  ++     +  ++    + +   .++.+                       |
>>>     1400 |-+                                   : +     +                      |
>>>     1350 |-+                                   : :                     OO     |
>>>     1300 |-+                                    +                    O        |
>>>     1250 |-+                                       OO            O OO     OO O|
>>>          |               O  OO O O OO OO O                                    |
>>>     1200 |-+              O     O                      OO OO OO O             |
>>>     1150 |-+                                    O                             |
>>>     1100 |-+                              O O    O    O                       |
>>>     1050 |O+O      O O O                      O                               |
>>>          |     O  O   O                      O                                |
>>>     1000 |-+ O  O                                                             |
>>>      950 +--------------------------------------------------------------------+
>>> [*] bisect-good sample
>>> [O] bisect-bad  sample
>>>
>>>
>>>
>>> Disclaimer:
>>> Results have been estimated based on internal Intel analysis and are provided
>>> for informational purposes only. Any difference in system hardware or software
>>> design or configuration may affect actual performance.
>>>
>>>
>>> Thanks,
>>> Rong Chen
>>>
>>>
>>> _______________________________________________
>>> LKP mailing list -- lkp@lists.01.org
>>> To unsubscribe send an email to lkp-leave@lists.01.org
>>>
>>
>> -- 
>> Zhengjun Xing

-- 
Zhengjun Xing
