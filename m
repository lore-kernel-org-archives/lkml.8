Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB96C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280AB21741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgBEM3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 07:29:31 -0500
Received: from mga09.intel.com ([134.134.136.24]:6155 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbgBEM3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 07:29:30 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 04:29:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,405,1574150400"; 
   d="yaml'?scan'208";a="235568969"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by orsmga006.jf.intel.com with ESMTP; 05 Feb 2020 04:29:16 -0800
Date:   Wed, 5 Feb 2020 20:29:02 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: [sched/fair] 3c29e651e1: hackbench.throughput -15.2% regression
Message-ID: <20200205122902.GL12867@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="I4VOKWutKNZEOIPu"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--I4VOKWutKNZEOIPu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Greeting,

FYI, we noticed a -15.2% regression of hackbench.throughput due to commit:


commit: 3c29e651e16dd3b3179cfb2d055ee9538e37515c ("sched/fair: Fall back to sched-idle CPU if idle CPU isn't found")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: hackbench
on test machine: 16 threads Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz with 32G memory
with following parameters:

	nr_threads: 100%
	mode: threads
	ipc: pipe
	cpufreq_governor: performance
	ucode: 0xca

test-description: Hackbench is both a benchmark and a stress test for the Linux kernel scheduler.
test-url: https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/sched/cfs-scheduler/hackbench.c

In addition to that, the commit also has significant impact on the following tests:

+------------------+-----------------------------------------------------------------------+
| testcase: change | hackbench: hackbench.throughput -11.3% regression                     |
| test machine     | 72 threads Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz with 256G memory |
| test parameters  | cpufreq_governor=performance                                          |
|                  | ipc=pipe                                                              |
|                  | iterations=18                                                         |
|                  | mode=threads                                                          |
|                  | nr_threads=1600%                                                      |
|                  | ucode=0x43                                                            |
+------------------+-----------------------------------------------------------------------+
| testcase: change | hackbench: hackbench.throughput -10.6% regression                     |
| test machine     | 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory |
| test parameters  | cpufreq_governor=performance                                          |
|                  | ipc=pipe                                                              |
|                  | mode=process                                                          |
|                  | nr_threads=50%                                                        |
|                  | ucode=0xb000038                                                       |
+------------------+-----------------------------------------------------------------------+
| testcase: change | hackbench: hackbench.throughput -6.8% regression                      |
| test machine     | 16 threads Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz with 32G memory     |
| test parameters  | cpufreq_governor=performance                                          |
|                  | ipc=pipe                                                              |
|                  | mode=threads                                                          |
|                  | nr_threads=100%                                                       |
|                  | ucode=0xb8                                                            |
+------------------+-----------------------------------------------------------------------+


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <rong.a.chen@intel.com>


Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml

=========================================================================================
compiler/cpufreq_governor/ipc/kconfig/mode/nr_threads/rootfs/tbox_group/testcase/ucode:
  gcc-7/performance/pipe/x86_64-rhel-7.6/threads/100%/debian-x86_64-20191114.cgz/lkp-cfl-e1/hackbench/0xca

commit: 
  43e9f7f231 ("sched/fair: Start tracking SCHED_IDLE tasks count in cfs_rq")
  3c29e651e1 ("sched/fair: Fall back to sched-idle CPU if idle CPU isn't found")

43e9f7f231e40e45 3c29e651e16dd3b3179cfb2d055 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     69492 ±  3%     -15.2%      58899        hackbench.throughput
 7.727e+08 ±  7%     +38.3%  1.069e+09 ±  2%  hackbench.time.involuntary_context_switches
    131708 ±  4%     -15.4%     111382        hackbench.time.minor_page_faults
    684.98 ±  2%      -2.5%     667.72        hackbench.time.user_time
 1.755e+09 ±  2%     +11.2%  1.953e+09        hackbench.time.voluntary_context_switches
  4.32e+08 ±  4%     -15.6%  3.648e+08        hackbench.workload
    186.50 ± 12%     -16.6%     155.50 ± 11%  interrupts.TLB:TLB_shootdowns
   4147892 ±  5%     +19.6%    4961643        vmstat.system.cs
      0.72 ± 10%      -0.1        0.58 ± 17%  mpstat.cpu.all.idle%
      0.00 ±156%      +0.0        0.01 ± 62%  mpstat.cpu.all.soft%
      1038 ±  9%     +18.5%       1230 ±  4%  slabinfo.avc_xperms_data.active_objs
      1038 ±  9%     +18.5%       1230 ±  4%  slabinfo.avc_xperms_data.num_objs
  40647036 ± 10%     -34.6%   26589504        proc-vmstat.numa_hit
  40647036 ± 10%     -34.6%   26589504        proc-vmstat.numa_local
  40724029 ± 10%     -34.5%   26661546        proc-vmstat.pgalloc_normal
    763906 ±  2%      -7.5%     706781        proc-vmstat.pgfault
  40701242 ± 10%     -34.6%   26637947        proc-vmstat.pgfree
   1636058 ± 11%     -45.0%     899629 ± 11%  turbostat.C1
      0.10 ±  7%      -0.0        0.07 ±  7%  turbostat.C1%
     15201 ± 25%    +113.3%      32422 ±  8%  turbostat.C1E
      0.01 ± 57%      +0.0        0.03 ± 13%  turbostat.C1E%
      9093 ± 11%    +217.2%      28841 ± 11%  turbostat.C3
      0.00 ±173%      +0.0        0.03 ± 13%  turbostat.C3%
     16977 ±  2%     -92.8%       1222 ± 98%  turbostat.C8
      0.17 ±  4%      -0.2        0.01 ±110%  turbostat.C8%
      0.13          -100.0%       0.00        turbostat.CPU%c7
   9623106 ±  5%     -35.1%    6241651 ±  8%  cpuidle.C1.time
   1636668 ± 11%     -45.0%     899926 ± 11%  cpuidle.C1.usage
    899494 ± 33%    +272.6%    3351412 ±  5%  cpuidle.C1E.time
     15327 ± 25%    +112.6%      32592 ±  8%  cpuidle.C1E.usage
    435674 ± 20%    +643.5%    3239351 ± 14%  cpuidle.C3.time
      9179 ± 11%    +215.2%      28933 ± 11%  cpuidle.C3.usage
  16850924 ±  2%     -94.2%     979516 ± 86%  cpuidle.C8.time
     17150 ±  2%     -92.0%       1378 ± 88%  cpuidle.C8.usage
   6022328 ± 18%     -57.1%    2584773 ±  7%  cpuidle.POLL.time
   5339703 ± 19%     -60.1%    2130089 ±  7%  cpuidle.POLL.usage
     14.06 ± 25%     +64.0%      23.07 ± 13%  sched_debug.cfs_rq:/.runnable_load_avg.min
     25.10 ±  5%     -15.8%      21.12 ±  7%  sched_debug.cfs_rq:/.runnable_load_avg.stddev
     13339 ± 24%     +45.7%      19433 ±  7%  sched_debug.cfs_rq:/.runnable_weight.min
    166.51 ± 24%     +48.9%     247.86 ±  7%  sched_debug.cfs_rq:/.util_est_enqueued.min
    253.56 ±  2%     -12.3%     222.30 ±  9%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    159602 ± 23%     +55.6%     248411 ±  6%  sched_debug.cpu.avg_idle.max
     51567 ± 24%     +49.1%      76905 ± 11%  sched_debug.cpu.avg_idle.stddev
     11576 ±  5%      -9.5%      10478        sched_debug.cpu.curr->pid.avg
      9976 ±  8%     -16.8%       8305 ±  9%  sched_debug.cpu.curr->pid.min
      4.81 ± 15%     +43.3%       6.89 ±  8%  sched_debug.cpu.nr_running.min
      6.68 ±  4%     -17.0%       5.54 ±  8%  sched_debug.cpu.nr_running.stddev
  76003928 ±  2%     +21.0%   91975904        sched_debug.cpu.nr_switches.avg
  78115404 ±  2%     +23.4%   96397551        sched_debug.cpu.nr_switches.max
  74275755 ±  2%     +19.0%   88359903        sched_debug.cpu.nr_switches.min
   1043054 ± 15%     +83.9%    1917752 ± 10%  sched_debug.cpu.nr_switches.stddev
   -685.26           +64.8%      -1129        sched_debug.cpu.nr_uninterruptible.min
     15470 ±  9%     -31.0%      10674 ±  9%  softirqs.CPU0.SCHED
     13756 ± 10%     -40.8%       8140 ±  4%  softirqs.CPU1.SCHED
     13645 ± 11%     -39.7%       8227 ±  3%  softirqs.CPU10.SCHED
     14065 ± 12%     -38.8%       8609 ±  2%  softirqs.CPU11.SCHED
     13948 ± 11%     -39.9%       8381 ±  6%  softirqs.CPU12.SCHED
     13823 ± 12%     -39.7%       8332 ±  9%  softirqs.CPU13.SCHED
     73323           +13.4%      83165 ± 11%  softirqs.CPU14.RCU
     13872 ± 12%     -36.5%       8809 ±  7%  softirqs.CPU14.SCHED
     13726 ± 12%     -40.4%       8175 ±  4%  softirqs.CPU15.SCHED
     13780 ± 11%     -34.8%       8987 ± 12%  softirqs.CPU2.SCHED
     13895 ± 10%     -40.5%       8266 ±  6%  softirqs.CPU3.SCHED
    221879           +13.4%     251589 ± 14%  softirqs.CPU3.TIMER
     13873 ± 10%     -40.4%       8262 ±  6%  softirqs.CPU4.SCHED
     72625           +12.0%      81355 ± 10%  softirqs.CPU5.RCU
     13876 ± 13%     -41.4%       8137 ±  3%  softirqs.CPU5.SCHED
     14118 ± 12%     -40.8%       8354 ±  3%  softirqs.CPU6.SCHED
     13503 ± 12%     -40.0%       8099        softirqs.CPU7.SCHED
     13549 ± 11%     -38.2%       8374 ±  8%  softirqs.CPU8.SCHED
     14273 ± 10%     -40.1%       8548 ±  6%  softirqs.CPU9.SCHED
    223184 ± 11%     -38.9%     136383 ±  5%  softirqs.SCHED
     55.80            +9.9%      61.34        perf-stat.i.MPKI
      1.32            +0.1        1.39        perf-stat.i.branch-miss-rate%
 1.066e+08            +3.7%  1.105e+08        perf-stat.i.branch-misses
      0.15 ±  8%      -0.0        0.11 ±  3%  perf-stat.i.cache-miss-rate%
   2521584 ±  9%     -26.5%    1854353 ±  3%  perf-stat.i.cache-misses
  2.27e+09            +8.0%  2.451e+09        perf-stat.i.cache-references
   4162783 ±  4%     +19.7%    4981708        perf-stat.i.context-switches
      1.52            +2.0%       1.55        perf-stat.i.cpi
    227633 ± 14%     +75.1%     398694 ±  3%  perf-stat.i.cpu-migrations
     33931 ± 12%     +42.7%      48428 ±  2%  perf-stat.i.cycles-between-cache-misses
      0.01            -0.0        0.01 ±  4%  perf-stat.i.dTLB-load-miss-rate%
   1408442 ±  2%     -16.4%    1177727 ±  4%  perf-stat.i.dTLB-load-misses
 1.229e+10            -2.1%  1.203e+10        perf-stat.i.dTLB-loads
      0.00 ±  2%      -0.0        0.00 ±  4%  perf-stat.i.dTLB-store-miss-rate%
     35757 ±  2%     -16.0%      30032 ±  3%  perf-stat.i.dTLB-store-misses
 7.449e+09            -2.3%  7.279e+09        perf-stat.i.dTLB-stores
  39246970            -5.5%   37079604        perf-stat.i.iTLB-load-misses
     76813 ±  8%     -26.2%      56724 ±  6%  perf-stat.i.iTLB-loads
 4.096e+10            -1.9%   4.02e+10        perf-stat.i.instructions
      1062            +4.1%       1105        perf-stat.i.instructions-per-iTLB-miss
      0.66            -1.9%       0.65        perf-stat.i.ipc
      1210            -7.1%       1124        perf-stat.i.minor-faults
    105889 ± 10%     -24.8%      79596 ±  5%  perf-stat.i.node-loads
    174508 ±  7%     -24.4%     131915        perf-stat.i.node-stores
      1210            -7.1%       1124        perf-stat.i.page-faults
     55.42 ±  2%     +10.0%      60.98        perf-stat.overall.MPKI
      1.31            +0.1        1.38        perf-stat.overall.branch-miss-rate%
      0.11 ± 11%      -0.0        0.08 ±  3%  perf-stat.overall.cache-miss-rate%
      1.51            +1.9%       1.54        perf-stat.overall.cpi
     24740 ±  9%     +34.9%      33377 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.01            -0.0        0.01 ±  4%  perf-stat.overall.dTLB-load-miss-rate%
      0.00 ±  2%      -0.0        0.00 ±  4%  perf-stat.overall.dTLB-store-miss-rate%
      1043            +3.9%       1084        perf-stat.overall.instructions-per-iTLB-miss
      0.66            -1.9%       0.65        perf-stat.overall.ipc
     57826 ±  3%     +15.6%      66874        perf-stat.overall.path-length
 1.064e+08            +3.7%  1.104e+08        perf-stat.ps.branch-misses
   2517524 ±  9%     -26.5%    1851335 ±  3%  perf-stat.ps.cache-misses
 2.266e+09            +8.0%  2.447e+09        perf-stat.ps.cache-references
   4155898 ±  4%     +19.7%    4973458        perf-stat.ps.context-switches
    227258 ± 14%     +75.1%     398041 ±  3%  perf-stat.ps.cpu-migrations
   1406119 ±  2%     -16.4%    1175777 ±  4%  perf-stat.ps.dTLB-load-misses
 1.227e+10            -2.1%  1.201e+10        perf-stat.ps.dTLB-loads
     35699 ±  2%     -16.0%      29983 ±  3%  perf-stat.ps.dTLB-store-misses
 7.437e+09            -2.3%  7.267e+09        perf-stat.ps.dTLB-stores
  39182154            -5.5%   37018206        perf-stat.ps.iTLB-load-misses
     76695 ±  8%     -26.2%      56638 ±  6%  perf-stat.ps.iTLB-loads
  4.09e+10            -1.9%  4.013e+10        perf-stat.ps.instructions
      1208            -7.1%       1122        perf-stat.ps.minor-faults
    105716 ± 10%     -24.8%      79465 ±  5%  perf-stat.ps.node-loads
    174234 ±  7%     -24.4%     131703        perf-stat.ps.node-stores
      1208            -7.1%       1122        perf-stat.ps.page-faults
     29.39 ±104%     -29.4        0.00        perf-profile.calltrace.cycles-pp.start_thread
     15.86 ±105%     -15.9        0.00        perf-profile.calltrace.cycles-pp.__GI___libc_write.start_thread
     14.88 ±105%     -14.9        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__GI___libc_write.start_thread
     14.75 ±105%     -14.8        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_write.start_thread
     13.53 ±104%     -13.5        0.00        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_write.start_thread
     12.51 ±104%     -12.5        0.00        perf-profile.calltrace.cycles-pp.__GI___libc_read.start_thread
     12.45 ±105%     -12.4        0.00        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_write
     11.21 ±105%     -11.2        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__GI___libc_read.start_thread
     11.08 ±105%     -11.1        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_read.start_thread
     10.47 ±105%     -10.5        0.00        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_read.start_thread
      9.73 ±105%      -9.7        0.00        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_read
      3.09 ± 12%      -0.6        2.50 ±  2%  perf-profile.calltrace.cycles-pp.copy_page_to_iter.pipe_read.new_sync_read.vfs_read.ksys_read
      2.45 ± 14%      -0.5        1.95 ±  2%  perf-profile.calltrace.cycles-pp.copy_page_from_iter.pipe_write.new_sync_write.vfs_write.ksys_write
      1.15 ± 13%      -0.2        0.95 ±  4%  perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter.pipe_write.new_sync_write.vfs_write
      0.99 ± 13%      -0.2        0.83 ±  5%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.copy_page_from_iter.pipe_write.new_sync_write
      0.92 ± 15%      +0.2        1.10        perf-profile.calltrace.cycles-pp.__fget_light.__fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.84 ± 23%      +0.3        1.10 ±  2%  perf-profile.calltrace.cycles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule.pipe_wait
      0.99 ± 19%      +0.3        1.26 ±  3%  perf-profile.calltrace.cycles-pp.update_curr.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      0.97 ± 23%      +0.3        1.26        perf-profile.calltrace.cycles-pp.__enqueue_entity.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      0.29 ±100%      +0.3        0.60 ±  5%  perf-profile.calltrace.cycles-pp.reschedule_interrupt.__lock_text_start.__wake_up_common_lock.pipe_write.new_sync_write
      0.55 ± 62%      +0.3        0.89 ±  7%  perf-profile.calltrace.cycles-pp.update_curr.reweight_entity.dequeue_task_fair.__schedule.schedule
      0.28 ±100%      +0.4        0.63 ±  7%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__schedule.schedule.exit_to_usermode_loop
      0.33 ±100%      +0.4        0.69 ±  2%  perf-profile.calltrace.cycles-pp.prepare_to_wait.pipe_wait.pipe_read.new_sync_read.vfs_read
      0.29 ±100%      +0.4        0.65 ±  4%  perf-profile.calltrace.cycles-pp.___perf_sw_event.__schedule.schedule.pipe_wait.pipe_read
      1.00 ± 27%      +0.4        1.37 ±  2%  perf-profile.calltrace.cycles-pp.check_preempt_wakeup.check_preempt_curr.ttwu_do_wakeup.try_to_wake_up.autoremove_wake_function
      0.57 ± 63%      +0.4        0.95 ±  5%  perf-profile.calltrace.cycles-pp.update_curr.reweight_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      1.46 ± 31%      +0.4        1.86 ±  2%  perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.72 ± 60%      +0.4        1.14 ±  2%  perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.29 ±100%      +0.4        0.70 ±  6%  perf-profile.calltrace.cycles-pp.pick_next_entity.pick_next_task_fair.__schedule.schedule.pipe_wait
      0.34 ±100%      +0.4        0.77 ±  7%  perf-profile.calltrace.cycles-pp.__update_load_avg_cfs_rq.update_load_avg.enqueue_entity.enqueue_task_fair.activate_task
      1.26 ± 26%      +0.5        1.72        perf-profile.calltrace.cycles-pp.check_preempt_curr.ttwu_do_wakeup.try_to_wake_up.autoremove_wake_function.__wake_up_common
      1.13 ± 26%      +0.5        1.59        perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      0.35 ±100%      +0.5        0.83 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__schedule.schedule.exit_to_usermode_loop.do_syscall_64
      1.28 ± 28%      +0.5        1.77 ±  3%  perf-profile.calltrace.cycles-pp.reweight_entity.dequeue_task_fair.__schedule.schedule.pipe_wait
      1.40 ± 26%      +0.5        1.89        perf-profile.calltrace.cycles-pp.ttwu_do_wakeup.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      0.44 ±100%      +0.5        0.95 ±  7%  perf-profile.calltrace.cycles-pp.put_prev_entity.pick_next_task_fair.__schedule.schedule.exit_to_usermode_loop
      2.33 ± 17%      +0.5        2.88 ±  2%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.pipe_wait.pipe_read
      1.33 ± 28%      +0.6        1.89 ±  2%  perf-profile.calltrace.cycles-pp.reweight_entity.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up
      1.40 ± 24%      +0.6        1.97 ±  4%  perf-profile.calltrace.cycles-pp.available_idle_cpu.select_idle_sibling.select_task_rq_fair.try_to_wake_up.autoremove_wake_function
      0.83 ± 66%      +0.6        1.40 ±  5%  perf-profile.calltrace.cycles-pp.native_write_msr
      5.01 ±  8%      +0.8        5.81 ±  2%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up
      1.75 ± 39%      +0.9        2.61 ±  6%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.exit_to_usermode_loop.do_syscall_64
      1.33 ± 67%      +1.0        2.28 ±  6%  perf-profile.calltrace.cycles-pp.switch_fpu_return.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.56 ± 12%      +1.2        7.78        perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.pipe_wait.pipe_read
      8.96 ±  9%      +1.6       10.56        perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
      9.23 ± 10%      +1.6       10.87        perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      9.17 ± 10%      +1.6       10.81        perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
      3.72 ± 31%      +1.7        5.44 ±  6%  perf-profile.calltrace.cycles-pp.__schedule.schedule.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.37 ±  8%      +1.9        5.32 ±  4%  perf-profile.calltrace.cycles-pp.select_idle_sibling.select_task_rq_fair.try_to_wake_up.autoremove_wake_function.__wake_up_common
      4.37 ± 10%      +2.3        6.65 ±  5%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
     15.27 ± 10%      +2.3       17.59        perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_wait.pipe_read.new_sync_read
     15.59 ± 10%      +2.4       17.96        perf-profile.calltrace.cycles-pp.schedule.pipe_wait.pipe_read.new_sync_read.vfs_read
      3.00 ± 71%      +2.6        5.60 ±  6%  perf-profile.calltrace.cycles-pp.schedule.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.10 ± 71%      +2.7        5.77 ±  6%  perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
     18.05 ± 10%      +2.7       20.73        perf-profile.calltrace.cycles-pp.pipe_wait.pipe_read.new_sync_read.vfs_read.ksys_read
     28.21 ±  5%      +3.7       31.87        perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write.ksys_write
     24.29 ±  8%      +4.7       28.98        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write
     23.38 ±  8%      +4.7       28.08        perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write
     23.72 ±  8%      +4.7       28.43        perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write.new_sync_write
     31.18 ± 41%     +12.7       43.86        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     33.44 ± 40%     +13.2       46.61        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     64.81 ± 43%     +27.5       92.34        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     65.30 ± 43%     +27.7       92.99        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     29.39 ±104%     -29.4        0.00        perf-profile.children.cycles-pp.start_thread
     16.09 ±105%     -16.1        0.00        perf-profile.children.cycles-pp.__GI___libc_write
     12.73 ±104%     -12.7        0.00        perf-profile.children.cycles-pp.__GI___libc_read
      5.80 ± 10%      -1.2        4.65 ±  3%  perf-profile.children.cycles-pp.security_file_permission
      4.10 ± 16%      -1.0        3.10 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      3.21 ±  9%      -0.7        2.55 ±  3%  perf-profile.children.cycles-pp.copy_page_to_iter
      1.45 ± 32%      -0.6        0.83        perf-profile.children.cycles-pp.entry_SYSCALL_64
      3.04 ±  8%      -0.6        2.44 ±  3%  perf-profile.children.cycles-pp.selinux_file_permission
      2.56 ± 11%      -0.6        1.99 ±  2%  perf-profile.children.cycles-pp.copy_page_from_iter
      2.80 ±  9%      -0.5        2.25 ±  2%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      3.38 ±  7%      -0.5        2.87 ±  2%  perf-profile.children.cycles-pp.mutex_lock
      1.62 ± 12%      -0.4        1.23 ±  3%  perf-profile.children.cycles-pp.___might_sleep
      1.82 ±  9%      -0.4        1.43 ±  4%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      2.09 ± 12%      -0.4        1.72 ±  6%  perf-profile.children.cycles-pp.file_has_perm
      0.90 ± 20%      -0.3        0.57 ±  9%  perf-profile.children.cycles-pp.__mutex_lock
      1.14 ± 12%      -0.3        0.82 ±  3%  perf-profile.children.cycles-pp.__inode_security_revalidate
      1.26 ± 10%      -0.3        0.97 ±  4%  perf-profile.children.cycles-pp.copyin
      1.70 ±  8%      -0.3        1.42 ±  3%  perf-profile.children.cycles-pp.copyout
      1.25 ± 11%      -0.3        0.98 ±  3%  perf-profile.children.cycles-pp.fsnotify
      1.04 ±  9%      -0.3        0.79 ±  3%  perf-profile.children.cycles-pp._cond_resched
      1.72 ±  7%      -0.2        1.48 ±  5%  perf-profile.children.cycles-pp.fput_many
      1.16 ± 10%      -0.2        0.92 ±  4%  perf-profile.children.cycles-pp.__might_sleep
      1.09 ±  8%      -0.2        0.85 ±  3%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.83 ± 13%      -0.2        0.63 ±  3%  perf-profile.children.cycles-pp.__might_fault
      0.69 ± 11%      -0.1        0.56        perf-profile.children.cycles-pp.current_time
      0.99 ±  4%      -0.1        0.89 ±  4%  perf-profile.children.cycles-pp.touch_atime
      0.65 ±  6%      -0.1        0.55 ±  6%  perf-profile.children.cycles-pp.atime_needs_update
      0.39 ±  4%      -0.1        0.29        perf-profile.children.cycles-pp.rcu_all_qs
      0.13 ± 39%      -0.1        0.04 ± 59%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      0.34 ± 11%      -0.1        0.26 ±  9%  perf-profile.children.cycles-pp.preempt_schedule_common
      0.49 ±  5%      -0.1        0.41 ±  2%  perf-profile.children.cycles-pp.wake_up_q
      0.24 ±  2%      -0.1        0.17 ±  4%  perf-profile.children.cycles-pp.fpregs_assert_state_consistent
      0.30 ± 11%      -0.1        0.23 ±  3%  perf-profile.children.cycles-pp.inode_has_perm
      0.23 ±  8%      -0.1        0.18 ±  6%  perf-profile.children.cycles-pp.__sb_end_write
      0.21 ±  9%      -0.1        0.16 ±  9%  perf-profile.children.cycles-pp.__x64_sys_read
      0.29 ±  8%      -0.0        0.24 ±  2%  perf-profile.children.cycles-pp.timespec64_trunc
      0.21 ±  8%      -0.0        0.17 ±  8%  perf-profile.children.cycles-pp.__x64_sys_write
      0.22 ±  7%      -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.08 ± 16%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.bpf_fd_pass
      0.10 ±  4%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.perf_exclude_event
      0.08 ± 24%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.rcu_note_context_switch
      0.17 ± 19%      +0.1        0.24 ±  8%  perf-profile.children.cycles-pp.wakeup_preempt_entity
      0.23 ± 19%      +0.1        0.32 ±  3%  perf-profile.children.cycles-pp.resched_curr
      0.61 ±  8%      +0.1        0.72 ±  6%  perf-profile.children.cycles-pp.sched_clock
      0.67 ±  8%      +0.1        0.78 ±  6%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.50 ±  9%      +0.1        0.62 ±  3%  perf-profile.children.cycles-pp.account_entity_enqueue
      0.61 ± 10%      +0.2        0.79        perf-profile.children.cycles-pp.account_entity_dequeue
      0.43 ± 19%      +0.2        0.62 ±  7%  perf-profile.children.cycles-pp.clear_buddies
      1.42 ± 14%      +0.2        1.66 ±  4%  perf-profile.children.cycles-pp.native_write_msr
      1.17 ± 13%      +0.3        1.42 ±  2%  perf-profile.children.cycles-pp.check_preempt_wakeup
      0.85 ± 23%      +0.3        1.12 ±  7%  perf-profile.children.cycles-pp.put_prev_entity
      0.94 ± 14%      +0.3        1.22 ±  5%  perf-profile.children.cycles-pp.___perf_sw_event
      1.45 ± 11%      +0.3        1.73        perf-profile.children.cycles-pp.check_preempt_curr
      1.45 ± 12%      +0.3        1.76        perf-profile.children.cycles-pp.__enqueue_entity
      1.60 ± 10%      +0.3        1.91        perf-profile.children.cycles-pp.ttwu_do_wakeup
      1.12 ±  9%      +0.3        1.43 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_se
      1.64 ±  8%      +0.4        2.00 ±  4%  perf-profile.children.cycles-pp.available_idle_cpu
      0.96 ± 19%      +0.4        1.34 ±  7%  perf-profile.children.cycles-pp.pick_next_entity
      1.85 ± 16%      +0.4        2.28 ±  6%  perf-profile.children.cycles-pp.switch_fpu_return
      1.90 ±  9%      +0.6        2.50 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      3.22 ± 13%      +0.6        3.87        perf-profile.children.cycles-pp.update_load_avg
      4.03 ± 10%      +0.6        4.68 ±  2%  perf-profile.children.cycles-pp.update_curr
      3.01 ± 14%      +0.7        3.72 ±  2%  perf-profile.children.cycles-pp.reweight_entity
      5.10 ±  8%      +0.8        5.87 ±  2%  perf-profile.children.cycles-pp.enqueue_entity
      4.71 ± 15%      +1.1        5.77 ±  4%  perf-profile.children.cycles-pp.pick_next_task_fair
      6.73 ± 11%      +1.1        7.87        perf-profile.children.cycles-pp.dequeue_task_fair
      9.07 ±  9%      +1.5       10.61        perf-profile.children.cycles-pp.enqueue_task_fair
      9.32 ±  9%      +1.6       10.89        perf-profile.children.cycles-pp.ttwu_do_activate
     91.46            +1.6       93.03        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      9.27 ±  9%      +1.6       10.84        perf-profile.children.cycles-pp.activate_task
      4.16 ± 26%      +1.6        5.78 ±  6%  perf-profile.children.cycles-pp.exit_to_usermode_loop
     90.79            +1.7       92.47        perf-profile.children.cycles-pp.do_syscall_64
      3.48 ±  8%      +1.9        5.36 ±  4%  perf-profile.children.cycles-pp.select_idle_sibling
      4.44 ± 10%      +2.2        6.67 ±  5%  perf-profile.children.cycles-pp.select_task_rq_fair
     18.46 ±  9%      +2.3       20.81        perf-profile.children.cycles-pp.pipe_wait
     19.93 ± 11%      +3.5       23.46 ±  2%  perf-profile.children.cycles-pp.__schedule
     28.82 ±  5%      +3.6       32.45        perf-profile.children.cycles-pp.__wake_up_common_lock
     19.89 ± 12%      +3.7       23.62 ±  2%  perf-profile.children.cycles-pp.schedule
     23.96 ±  8%      +4.5       28.45        perf-profile.children.cycles-pp.try_to_wake_up
     24.53 ±  8%      +4.5       29.06        perf-profile.children.cycles-pp.__wake_up_common
     23.91 ±  8%      +4.6       28.46        perf-profile.children.cycles-pp.autoremove_wake_function
      2.76 ±  9%      -0.5        2.23 ±  2%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      1.46 ± 18%      -0.4        1.06 ±  4%  perf-profile.self.cycles-pp.pipe_write
      1.81 ±  9%      -0.4        1.43 ±  4%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      1.56 ± 12%      -0.4        1.19 ±  3%  perf-profile.self.cycles-pp.___might_sleep
      2.09 ±  7%      -0.3        1.81 ±  2%  perf-profile.self.cycles-pp.mutex_lock
      1.86 ±  8%      -0.3        1.59 ±  3%  perf-profile.self.cycles-pp.selinux_file_permission
      1.21 ± 11%      -0.3        0.96 ±  2%  perf-profile.self.cycles-pp.fsnotify
      1.70 ±  7%      -0.2        1.46 ±  5%  perf-profile.self.cycles-pp.fput_many
      1.04 ± 11%      -0.2        0.82 ±  3%  perf-profile.self.cycles-pp.__might_sleep
      1.01 ±  8%      -0.2        0.80 ±  3%  perf-profile.self.cycles-pp.__fsnotify_parent
      1.04 ± 10%      -0.2        0.83        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.67 ± 10%      -0.2        0.51 ±  5%  perf-profile.self.cycles-pp.new_sync_write
      0.64 ± 12%      -0.2        0.48 ±  5%  perf-profile.self.cycles-pp.vfs_write
      1.67            -0.2        1.51 ±  2%  perf-profile.self.cycles-pp.pipe_read
      0.58 ± 17%      -0.1        0.44 ±  7%  perf-profile.self.cycles-pp.file_has_perm
      0.44 ± 18%      -0.1        0.31 ±  7%  perf-profile.self.cycles-pp.__mutex_lock
      0.49 ± 13%      -0.1        0.35 ±  3%  perf-profile.self.cycles-pp.copy_page_from_iter
      0.64 ±  8%      -0.1        0.52 ±  4%  perf-profile.self.cycles-pp.copy_page_to_iter
      0.67 ±  7%      -0.1        0.55 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.30 ±  5%      -0.1        0.20 ±  4%  perf-profile.self.cycles-pp.ksys_write
      0.40 ± 12%      -0.1        0.30 ±  7%  perf-profile.self.cycles-pp.security_file_permission
      0.13 ± 38%      -0.1        0.04 ± 59%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      0.36 ± 11%      -0.1        0.28 ±  3%  perf-profile.self.cycles-pp.__inode_security_revalidate
      0.76 ±  5%      -0.1        0.68 ±  5%  perf-profile.self.cycles-pp.do_syscall_64
      0.21 ±  2%      -0.1        0.14 ±  8%  perf-profile.self.cycles-pp.fpregs_assert_state_consistent
      0.26 ± 12%      -0.1        0.20 ±  4%  perf-profile.self.cycles-pp.inode_has_perm
      0.29 ± 11%      -0.1        0.23 ±  6%  perf-profile.self.cycles-pp.current_time
      0.28 ±  4%      -0.1        0.21 ±  2%  perf-profile.self.cycles-pp.rcu_all_qs
      0.22 ±  7%      -0.1        0.17 ±  7%  perf-profile.self.cycles-pp.__sb_end_write
      0.31            -0.1        0.26 ±  7%  perf-profile.self.cycles-pp.ksys_read
      0.20 ± 11%      -0.0        0.16 ±  9%  perf-profile.self.cycles-pp.__x64_sys_read
      0.26 ±  8%      -0.0        0.22        perf-profile.self.cycles-pp.timespec64_trunc
      0.20 ±  5%      -0.0        0.16 ±  9%  perf-profile.self.cycles-pp.__x64_sys_write
      0.24 ±  9%      -0.0        0.21 ±  6%  perf-profile.self.cycles-pp.__might_fault
      0.09 ±  9%      -0.0        0.06        perf-profile.self.cycles-pp.copyin
      0.14 ±  5%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.__x86_indirect_thunk_rax
      0.07 ± 10%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.sched_clock
      0.16 ±  5%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.ttwu_do_wakeup
      0.20 ± 12%      +0.0        0.24 ±  5%  perf-profile.self.cycles-pp.__list_add_valid
      0.10 ± 26%      +0.0        0.14 ± 10%  perf-profile.self.cycles-pp.update_cfs_rq_h_load
      0.15 ± 16%      +0.1        0.21 ± 11%  perf-profile.self.cycles-pp.wakeup_preempt_entity
      0.35 ±  7%      +0.1        0.43 ±  4%  perf-profile.self.cycles-pp.prepare_to_wait
      0.55 ±  2%      +0.1        0.63 ±  3%  perf-profile.self.cycles-pp.__fget_light
      0.22 ± 18%      +0.1        0.30 ±  3%  perf-profile.self.cycles-pp.resched_curr
      0.48 ± 11%      +0.1        0.58 ±  3%  perf-profile.self.cycles-pp.check_preempt_wakeup
      0.39 ± 11%      +0.1        0.50        perf-profile.self.cycles-pp.account_entity_enqueue
      0.85 ±  7%      +0.1        0.97 ±  4%  perf-profile.self.cycles-pp.enqueue_entity
      0.43 ± 16%      +0.1        0.55 ±  7%  perf-profile.self.cycles-pp.pick_next_entity
      0.86 ± 10%      +0.1        0.99        perf-profile.self.cycles-pp.dequeue_task_fair
      0.37 ± 21%      +0.2        0.55 ±  6%  perf-profile.self.cycles-pp.clear_buddies
      0.45 ± 14%      +0.2        0.65        perf-profile.self.cycles-pp.account_entity_dequeue
      1.41 ± 14%      +0.2        1.65 ±  4%  perf-profile.self.cycles-pp.native_write_msr
      0.80 ± 16%      +0.3        1.06 ±  4%  perf-profile.self.cycles-pp.___perf_sw_event
      1.09 ±  9%      +0.3        1.39 ±  2%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.84 ± 16%      +0.3        1.14 ±  7%  perf-profile.self.cycles-pp.select_task_rq_fair
      1.45 ± 12%      +0.3        1.75        perf-profile.self.cycles-pp.__enqueue_entity
      1.62 ±  8%      +0.4        1.99 ±  4%  perf-profile.self.cycles-pp.available_idle_cpu
      1.83 ± 16%      +0.4        2.25 ±  6%  perf-profile.self.cycles-pp.switch_fpu_return
      2.15 ± 11%      +0.5        2.60 ±  5%  perf-profile.self.cycles-pp.update_curr
      1.88 ±  9%      +0.6        2.45 ±  3%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      1.21 ±  9%      +0.7        1.92 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      0.80 ± 11%      +1.4        2.17 ±  3%  perf-profile.self.cycles-pp.select_idle_sibling


                                                                                
                                hackbench.throughput                            
                                                                                
  74000 +-+-----------------------------------------------------------------+   
  72000 +-+.+                .+                                             |   
        |.+  :  .+. .+.     +                                               |   
  70000 +-+  : +   +   +.   :                                               |   
  68000 +-+   +          + :                                                |   
        |                 ::                                                |   
  66000 +-+               +                                                 |   
  64000 +-+                                                                 |   
  62000 +-+                                                                 |   
        |                                                                   |   
  60000 +-+                   O   O OO O     O O  O   O O O          OO     |   
  58000 +-+                     O          O    O   O      O O O O      O O O   
        |     O        O OO              O                         O        |   
  56000 O-+ O  O O O O      O                                               |   
  54000 +-O-----------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-hsw-ep4: 72 threads Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz with 256G memory
=========================================================================================
compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase/ucode:
  gcc-7/performance/pipe/18/x86_64-rhel-7.6/threads/1600%/debian-x86_64-2019-11-14.cgz/lkp-hsw-ep4/hackbench/0x43

commit: 
  43e9f7f231 ("sched/fair: Start tracking SCHED_IDLE tasks count in cfs_rq")
  3c29e651e1 ("sched/fair: Fall back to sched-idle CPU if idle CPU isn't found")

43e9f7f231e40e45 3c29e651e16dd3b3179cfb2d055 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :4           25%           1:4     dmesg.WARNING:at#for_ip_interrupt_entry/0x
         %stddev     %change         %stddev
             \          |                \  
    176075 ±  2%     -11.3%     156152        hackbench.throughput
    891.79           +12.3%       1001        hackbench.time.elapsed_time
    891.79           +12.3%       1001        hackbench.time.elapsed_time.max
 1.889e+09 ±  9%     +33.1%  2.514e+09 ±  3%  hackbench.time.involuntary_context_switches
     42939 ±  3%     +17.0%      50220        hackbench.time.system_time
     18978            +3.2%      19592        hackbench.time.user_time
 2.558e+09 ±  8%     +33.5%  3.415e+09 ±  2%  hackbench.time.voluntary_context_switches
  43133704 ±  3%     +39.2%   60035429 ± 33%  cpuidle.C1.time
     48661           +17.7%      57274 ±  5%  meminfo.Shmem
     19043 ±  2%     -14.0%      16377        meminfo.max_used_kB
      2502            +1.3%       2535        turbostat.Avg_MHz
 3.368e+08 ±  5%     +30.6%  4.398e+08        turbostat.IRQ
     66.25            +4.5%      69.25        vmstat.cpu.sy
     29.25 ±  2%      -8.5%      26.75        vmstat.cpu.us
   5000443 ±  7%     +18.6%    5931772        vmstat.system.cs
    370173 ±  3%     +17.1%     433616        vmstat.system.in
  98786923 ±  7%     +74.5%  1.724e+08        numa-numastat.node0.local_node
  98791606 ±  7%     +74.5%  1.724e+08        numa-numastat.node0.numa_hit
      4686 ± 99%    +297.8%      18642 ± 24%  numa-numastat.node0.other_node
 1.818e+08           -51.4%   88447082 ±  3%  numa-numastat.node1.local_node
 1.819e+08           -51.4%   88451833 ±  3%  numa-numastat.node1.numa_hit
     18694 ± 25%     -74.6%       4753 ± 97%  numa-numastat.node1.other_node
    155316            +1.5%     157632        proc-vmstat.nr_active_anon
     99.50            +5.3%     104.75 ±  3%  proc-vmstat.nr_dirtied
      4440            +4.9%       4656        proc-vmstat.nr_inactive_anon
      6283            +1.9%       6399        proc-vmstat.nr_mapped
     12248 ±  2%     +16.6%      14276 ±  5%  proc-vmstat.nr_shmem
     98.75            +5.3%     104.00        proc-vmstat.nr_written
    155316            +1.5%     157632        proc-vmstat.nr_zone_active_anon
      4440            +4.9%       4656        proc-vmstat.nr_zone_inactive_anon
 2.807e+08            -7.1%  2.609e+08        proc-vmstat.numa_hit
 2.807e+08            -7.1%  2.609e+08        proc-vmstat.numa_local
  2.83e+08            -7.0%  2.632e+08        proc-vmstat.pgalloc_normal
   3212744            +2.3%    3286078        proc-vmstat.pgfault
 2.828e+08            -7.0%  2.631e+08        proc-vmstat.pgfree
     39216 ± 35%    +153.3%      99342 ±  4%  numa-vmstat.node0.nr_active_anon
     31864 ± 44%    +211.0%      99111 ±  4%  numa-vmstat.node0.nr_anon_pages
     11183 ±  3%   +4212.8%     482321 ±  2%  numa-vmstat.node0.nr_kernel_stack
    499.50 ± 23%     +66.9%     833.75 ±  8%  numa-vmstat.node0.nr_page_table_pages
     11417           -63.5%       4168 ±  5%  numa-vmstat.node0.nr_shmem
     15905 ±  4%     -12.5%      13919 ±  2%  numa-vmstat.node0.nr_slab_reclaimable
     17996 ±  3%    +587.4%     123708 ±  2%  numa-vmstat.node0.nr_slab_unreclaimable
     39216 ± 35%    +153.3%      99342 ±  4%  numa-vmstat.node0.nr_zone_active_anon
  52471566 ±  6%     +73.3%   90915199        numa-vmstat.node0.numa_hit
  52466577 ±  6%     +73.2%   90896366        numa-vmstat.node0.numa_local
      4990 ± 92%    +277.5%      18836 ± 24%  numa-vmstat.node0.numa_other
    114712 ± 12%     -50.1%      57234 ±  7%  numa-vmstat.node1.nr_active_anon
    114545 ± 12%     -58.2%      47874 ±  9%  numa-vmstat.node1.nr_anon_pages
    462075           -96.6%      15717 ± 67%  numa-vmstat.node1.nr_kernel_stack
    871.50 ± 13%     -37.9%     541.00 ± 13%  numa-vmstat.node1.nr_page_table_pages
    691.25 ± 22%   +1359.2%      10086 ±  8%  numa-vmstat.node1.nr_shmem
     11357 ±  5%     +18.1%      13414 ±  4%  numa-vmstat.node1.nr_slab_reclaimable
    118594           -85.5%      17243 ± 16%  numa-vmstat.node1.nr_slab_unreclaimable
    114712 ± 12%     -50.1%      57234 ±  7%  numa-vmstat.node1.nr_zone_active_anon
  93308245 ±  2%     -49.7%   46921467 ±  4%  numa-vmstat.node1.numa_hit
  93128224 ±  2%     -49.8%   46755145 ±  4%  numa-vmstat.node1.numa_local
    157762 ± 35%    +154.4%     401333 ±  4%  numa-meminfo.node0.Active
    157721 ± 35%    +154.4%     401249 ±  4%  numa-meminfo.node0.Active(anon)
    128232 ± 44%    +212.2%     400337 ±  4%  numa-meminfo.node0.AnonPages
     63487 ±  4%     -12.0%      55850 ±  2%  numa-meminfo.node0.KReclaimable
     11691 ±  3%   +4087.3%     489553        numa-meminfo.node0.KernelStack
   1170596 ±  4%    +104.2%    2390602        numa-meminfo.node0.MemUsed
      2003 ± 23%     +67.3%       3351 ±  8%  numa-meminfo.node0.PageTables
     63487 ±  4%     -12.0%      55850 ±  2%  numa-meminfo.node0.SReclaimable
     72301 ±  3%    +591.9%     500285        numa-meminfo.node0.SUnreclaim
     45749           -63.5%      16679 ±  5%  numa-meminfo.node0.Shmem
    135789 ±  3%    +309.6%     556136        numa-meminfo.node0.Slab
    460025 ± 11%     -50.2%     228882 ±  7%  numa-meminfo.node1.Active
    459902 ± 11%     -50.2%     228802 ±  7%  numa-meminfo.node1.Active(anon)
    459237 ± 11%     -58.3%     191354 ±  9%  numa-meminfo.node1.AnonPages
     45568 ±  5%     +17.8%      53657 ±  4%  numa-meminfo.node1.KReclaimable
    468955           -96.7%      15461 ± 67%  numa-meminfo.node1.KernelStack
   2241450           -51.9%    1078199 ±  3%  numa-meminfo.node1.MemUsed
      3493 ± 13%     -38.0%       2167 ± 13%  numa-meminfo.node1.PageTables
     45568 ±  5%     +17.8%      53657 ±  4%  numa-meminfo.node1.SReclaimable
    479010           -85.6%      68750 ± 16%  numa-meminfo.node1.SUnreclaim
      2779 ± 23%   +1354.1%      40419 ±  8%  numa-meminfo.node1.Shmem
    524580           -76.7%     122408 ±  8%  numa-meminfo.node1.Slab
    250988 ± 19%     -52.0%     120407 ± 33%  sched_debug.cfs_rq:/.MIN_vruntime.avg
   1469922 ± 14%     -32.1%     998119 ± 33%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
     20766 ±  9%     -25.3%      15519 ± 10%  sched_debug.cfs_rq:/.load.avg
     43820 ± 19%     -40.6%      26044 ± 36%  sched_debug.cfs_rq:/.load.stddev
    250988 ± 19%     -52.0%     120407 ± 33%  sched_debug.cfs_rq:/.max_vruntime.avg
   1469922 ± 14%     -32.1%     998119 ± 33%  sched_debug.cfs_rq:/.max_vruntime.stddev
  10990567 ±  9%     +22.9%   13509735 ±  7%  sched_debug.cfs_rq:/.min_vruntime.stddev
    102.40           -33.3%      68.27 ± 57%  sched_debug.cfs_rq:/.removed.load_avg.max
      4711           -33.4%       3136 ± 57%  sched_debug.cfs_rq:/.removed.runnable_sum.max
     19930 ± 10%     -25.1%      14917 ± 10%  sched_debug.cfs_rq:/.runnable_weight.avg
  -5713498          -349.0%   14226386 ±  8%  sched_debug.cfs_rq:/.spread0.avg
   8106715 ± 13%    +283.1%   31057182 ±  6%  sched_debug.cfs_rq:/.spread0.max
 -18025645           -99.7%     -45393        sched_debug.cfs_rq:/.spread0.min
  11027552 ±  9%     +21.5%   13398318 ±  7%  sched_debug.cfs_rq:/.spread0.stddev
    570.46 ±  5%    +109.2%       1193 ± 21%  sched_debug.cfs_rq:/.util_est_enqueued.avg
      2898 ± 11%     +90.0%       5507 ± 10%  sched_debug.cfs_rq:/.util_est_enqueued.max
    563.27 ± 13%    +149.3%       1404 ± 18%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    155578 ± 22%     +84.1%     286457 ± 28%  sched_debug.cpu.avg_idle.min
      1678 ± 43%    +105.9%       3457 ± 31%  sched_debug.cpu.clock.stddev
      1678 ± 43%    +105.9%       3457 ± 31%  sched_debug.cpu.clock_task.stddev
     50207           -12.3%      44017 ±  7%  sched_debug.cpu.curr->pid.avg
     82673           -19.5%      66514 ±  5%  sched_debug.cpu.curr->pid.max
    746.05 ± 11%    +554.3%       4881 ±  8%  sched_debug.cpu.curr->pid.min
     30728 ±  2%     -40.8%      18187 ± 10%  sched_debug.cpu.curr->pid.stddev
      0.00 ± 43%    +106.0%       0.00 ± 31%  sched_debug.cpu.next_balance.stddev
     20.49 ±  6%    +149.0%      51.03 ± 23%  sched_debug.cpu.nr_running.avg
    157.83 ±  9%     +77.0%     279.37 ±  8%  sched_debug.cpu.nr_running.max
     29.95 ± 11%    +137.1%      70.99 ± 16%  sched_debug.cpu.nr_running.stddev
  29803727 ±  9%     +29.6%   38623870 ±  3%  sched_debug.cpu.nr_switches.avg
  51549476 ± 10%     +22.5%   63171598 ±  3%  sched_debug.cpu.nr_switches.max
  12792570 ±  3%     +43.5%   18362678 ±  4%  sched_debug.cpu.nr_switches.min
      2.03 ± 80%    +430.9%      10.76 ± 38%  sched_debug.cpu.nr_uninterruptible.avg
      6.99 ±  4%     +48.7%      10.39 ±  5%  perf-stat.i.MPKI
      7.49 ±  5%      -1.2        6.29 ±  5%  perf-stat.i.cache-miss-rate%
  27202880 ±  2%     +46.9%   39966416 ±  2%  perf-stat.i.cache-misses
 4.662e+08 ±  5%     +71.5%  7.998e+08 ±  5%  perf-stat.i.cache-references
   5989366 ±  4%     +12.9%    6760958 ±  5%  perf-stat.i.context-switches
    197319 ± 12%     -19.2%     159504 ±  3%  perf-stat.i.cpu-migrations
      7415 ±  2%     -23.3%       5686 ±  3%  perf-stat.i.cycles-between-cache-misses
      0.61 ± 35%      -0.3        0.35 ±  4%  perf-stat.i.dTLB-load-miss-rate%
 1.506e+08 ± 38%     -44.9%   82967539 ±  5%  perf-stat.i.dTLB-load-misses
      0.22 ±  4%      -0.0        0.20 ±  4%  perf-stat.i.dTLB-store-miss-rate%
  35974976 ±  5%     -13.4%   31146077 ±  6%  perf-stat.i.dTLB-store-misses
 1.627e+10            -3.7%  1.566e+10        perf-stat.i.dTLB-stores
  46665620 ±  3%     -14.6%   39838962 ±  5%  perf-stat.i.iTLB-load-misses
      2191 ±  5%     +21.4%       2660 ±  7%  perf-stat.i.instructions-per-iTLB-miss
      0.47            -2.5%       0.46        perf-stat.i.ipc
      6660 ±  8%     -19.1%       5391 ±  8%  perf-stat.i.minor-faults
     62.93 ±  2%     +11.1       74.06        perf-stat.i.node-load-miss-rate%
  12537290 ±  4%     +73.5%   21750457 ±  4%  perf-stat.i.node-load-misses
   5459308 ±  3%      -7.4%    5057404 ±  3%  perf-stat.i.node-loads
     29.39 ±  2%      -4.1       25.29 ±  2%  perf-stat.i.node-store-miss-rate%
   2863317           +13.6%    3252632 ±  2%  perf-stat.i.node-store-misses
   6381925 ±  2%     +53.5%    9796918 ±  4%  perf-stat.i.node-stores
      6638 ±  8%     -19.4%       5348 ±  8%  perf-stat.i.page-faults
      4.89 ±  4%     +78.4%       8.73        perf-stat.overall.MPKI
      1.29            +0.0        1.31        perf-stat.overall.branch-miss-rate%
      6.13 ±  4%      -1.3        4.85 ±  3%  perf-stat.overall.cache-miss-rate%
      2.15            +2.0%       2.19        perf-stat.overall.cpi
      7187           -27.9%       5182 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.63 ± 39%      -0.3        0.36 ±  5%  perf-stat.overall.dTLB-load-miss-rate%
      0.23 ±  5%      -0.0        0.21 ±  3%  perf-stat.overall.dTLB-store-miss-rate%
     75.65            -1.1       74.59        perf-stat.overall.iTLB-load-miss-rate%
      1604 ±  3%     +15.9%       1859        perf-stat.overall.instructions-per-iTLB-miss
      0.47            -2.0%       0.46        perf-stat.overall.ipc
     63.14 ±  2%     +13.6       76.70        perf-stat.overall.node-load-miss-rate%
     30.74 ±  2%      -5.1       25.62 ±  2%  perf-stat.overall.node-store-miss-rate%
     47754 ±  2%     +11.7%      53321        perf-stat.overall.path-length
  24893507           +40.6%   34993733 ±  2%  perf-stat.ps.cache-misses
 4.072e+08 ±  5%     +77.1%  7.212e+08        perf-stat.ps.cache-references
   4968881 ±  7%     +19.0%    5911450        perf-stat.ps.context-switches
 1.789e+11            +1.3%  1.812e+11        perf-stat.ps.cpu-cycles
  1.59e+08 ± 39%     -44.1%   88801351 ±  6%  perf-stat.ps.dTLB-load-misses
 2.502e+10            -2.0%  2.453e+10        perf-stat.ps.dTLB-loads
  39138578 ±  5%     -12.6%   34190129 ±  3%  perf-stat.ps.dTLB-store-misses
 1.675e+10            -3.7%  1.613e+10        perf-stat.ps.dTLB-stores
  51901139 ±  2%     -14.3%   44461197        perf-stat.ps.iTLB-load-misses
  16711264 ±  2%      -9.3%   15153636 ±  2%  perf-stat.ps.iTLB-loads
      3573            -9.1%       3247        perf-stat.ps.minor-faults
  10427704 ±  3%     +73.2%   18055799 ±  3%  perf-stat.ps.node-load-misses
   6085553 ±  4%     -10.0%    5479559 ±  2%  perf-stat.ps.node-loads
   2566511           +13.4%    2911367 ±  2%  perf-stat.ps.node-store-misses
   5784179 ±  2%     +46.2%    8454210 ±  3%  perf-stat.ps.node-stores
      3573            -9.1%       3247        perf-stat.ps.page-faults
 7.427e+13 ±  2%     +11.7%  8.293e+13        perf-stat.total.instructions
    127394 ±  5%     +19.1%     151665        softirqs.CPU0.RCU
    321761 ±  3%     +12.8%     363107 ±  3%  softirqs.CPU0.TIMER
    124526 ±  5%     +20.2%     149697 ±  3%  softirqs.CPU1.RCU
    123768 ±  4%     +24.7%     154332 ±  2%  softirqs.CPU10.RCU
    130315 ±  3%     +22.1%     159111        softirqs.CPU11.RCU
    126684 ±  4%     +26.1%     159755 ±  2%  softirqs.CPU12.RCU
    124649 ±  9%     +27.8%     159298 ±  3%  softirqs.CPU13.RCU
    124528 ±  4%     +23.2%     153372 ±  2%  softirqs.CPU14.RCU
    326150 ±  2%      +9.8%     357991 ±  4%  softirqs.CPU14.TIMER
    121923 ±  6%     +17.4%     143119        softirqs.CPU15.RCU
    122114 ±  5%     +16.7%     142560        softirqs.CPU16.RCU
    121425 ±  6%     +14.4%     138861 ±  3%  softirqs.CPU17.RCU
    330948 ±  2%     +22.2%     404570 ± 16%  softirqs.CPU17.TIMER
    312317 ±  4%     +18.2%     369091 ±  2%  softirqs.CPU18.TIMER
      9626 ±  2%     +15.0%      11067 ±  3%  softirqs.CPU19.SCHED
    322308 ±  3%     +21.1%     390454 ±  2%  softirqs.CPU19.TIMER
    124281 ±  5%     +22.8%     152670 ±  2%  softirqs.CPU2.RCU
      9452 ±  2%     +15.6%      10927 ±  3%  softirqs.CPU20.SCHED
    318575 ±  6%     +22.3%     389741 ±  3%  softirqs.CPU20.TIMER
      9327 ±  3%     +16.7%      10886 ±  3%  softirqs.CPU21.SCHED
    306628 ±  4%     +23.3%     377962 ±  3%  softirqs.CPU21.TIMER
      9424 ±  2%     +17.6%      11084 ±  3%  softirqs.CPU22.SCHED
    302796 ±  4%     +24.2%     376126 ±  2%  softirqs.CPU22.TIMER
      9798 ±  2%     +11.4%      10918 ±  4%  softirqs.CPU23.SCHED
    312009 ±  4%     +23.6%     385626 ±  2%  softirqs.CPU23.TIMER
      9559 ±  3%     +13.2%      10822        softirqs.CPU24.SCHED
    311772 ±  4%     +23.0%     383504 ±  2%  softirqs.CPU24.TIMER
      9514 ±  4%     +13.2%      10766 ±  3%  softirqs.CPU25.SCHED
    307640 ±  4%     +22.4%     376479 ±  2%  softirqs.CPU25.TIMER
      9573 ±  3%     +13.8%      10897 ±  3%  softirqs.CPU26.SCHED
    314607 ±  9%     +21.1%     380918 ±  2%  softirqs.CPU26.TIMER
      9385           +13.7%      10668 ±  2%  softirqs.CPU27.SCHED
    301949 ±  4%     +25.2%     378140 ±  3%  softirqs.CPU27.TIMER
      9483 ±  2%     +14.7%      10874 ±  2%  softirqs.CPU28.SCHED
    299462 ±  3%     +24.9%     373896 ±  2%  softirqs.CPU28.TIMER
      9505 ±  3%     +13.3%      10769 ±  3%  softirqs.CPU29.SCHED
    307087 ±  4%     +23.8%     380066 ±  3%  softirqs.CPU29.TIMER
    124992 ±  4%     +19.4%     149253 ±  3%  softirqs.CPU3.RCU
      9630 ±  4%     +13.6%      10942 ±  3%  softirqs.CPU30.SCHED
    306382 ±  4%     +25.4%     384355 ±  2%  softirqs.CPU30.TIMER
      9496 ±  6%     +12.6%      10689 ±  2%  softirqs.CPU31.SCHED
    308689 ±  4%     +24.5%     384419 ±  2%  softirqs.CPU31.TIMER
      9714           +12.6%      10937 ±  4%  softirqs.CPU32.SCHED
    304137 ±  3%     +35.9%     413240 ± 13%  softirqs.CPU32.TIMER
      9598 ±  2%     +13.4%      10882 ±  5%  softirqs.CPU33.SCHED
      9622           +13.8%      10949 ±  3%  softirqs.CPU34.SCHED
    305882 ±  4%     +27.3%     389315 ±  4%  softirqs.CPU34.TIMER
      9409 ±  4%     +15.3%      10853 ±  4%  softirqs.CPU35.SCHED
    306215 ±  4%     +23.8%     379222 ±  2%  softirqs.CPU35.TIMER
    321617 ±  4%     +12.9%     362966 ±  3%  softirqs.CPU36.TIMER
    134843 ±  6%     +19.4%     161053 ±  2%  softirqs.CPU37.RCU
    130954 ±  6%     +20.4%     157716        softirqs.CPU38.RCU
    129884 ±  5%     +17.8%     152978        softirqs.CPU39.RCU
    124744 ±  4%     +20.1%     149790 ±  3%  softirqs.CPU4.RCU
    130593 ±  5%     +17.2%     153092 ±  2%  softirqs.CPU40.RCU
    134185 ±  5%     +19.9%     160871        softirqs.CPU41.RCU
    133336 ±  5%     +18.1%     157409        softirqs.CPU42.RCU
    134486 ±  4%     +18.7%     159613        softirqs.CPU43.RCU
    129857 ±  6%     +18.5%     153887        softirqs.CPU44.RCU
    131816 ±  5%     +20.0%     158144        softirqs.CPU45.RCU
    132691 ±  5%     +22.4%     162412        softirqs.CPU46.RCU
    138736 ±  3%     +18.7%     164668        softirqs.CPU47.RCU
    132971 ±  6%     +24.2%     165142        softirqs.CPU48.RCU
    136142 ±  3%     +20.8%     164493        softirqs.CPU49.RCU
    125011 ±  4%     +23.6%     154462 ±  2%  softirqs.CPU5.RCU
    133660 ±  4%     +19.5%     159753 ±  2%  softirqs.CPU50.RCU
    140405 ±  4%     +19.5%     167772        softirqs.CPU51.RCU
    140523 ±  4%     +18.5%     166576        softirqs.CPU52.RCU
    138849 ±  5%     +14.6%     159157 ±  4%  softirqs.CPU53.RCU
    332171 ±  2%     +21.4%     403260 ± 15%  softirqs.CPU53.TIMER
    133037 ±  4%     +14.0%     151688 ±  2%  softirqs.CPU54.RCU
      9584           +14.3%      10959 ±  2%  softirqs.CPU54.SCHED
    310603 ±  4%     +18.0%     366472 ±  3%  softirqs.CPU54.TIMER
      9565 ±  2%     +13.8%      10889 ±  5%  softirqs.CPU55.SCHED
    321231 ±  3%     +21.3%     389753 ±  2%  softirqs.CPU55.TIMER
    136633 ±  4%     +12.6%     153854        softirqs.CPU56.RCU
      9430 ±  2%     +15.6%      10898 ±  5%  softirqs.CPU56.SCHED
    319477 ±  6%     +22.1%     390107 ±  2%  softirqs.CPU56.TIMER
    128672 ±  4%     +14.1%     146791 ±  3%  softirqs.CPU57.RCU
      9493 ±  2%     +13.1%      10740 ±  3%  softirqs.CPU57.SCHED
    305670 ±  4%     +23.5%     377597 ±  2%  softirqs.CPU57.TIMER
    127129 ±  4%     +15.6%     146993 ±  2%  softirqs.CPU58.RCU
      9529 ±  3%     +13.6%      10824 ±  4%  softirqs.CPU58.SCHED
    302317 ±  4%     +23.8%     374371 ±  3%  softirqs.CPU58.TIMER
      9427 ±  2%     +14.0%      10743 ±  2%  softirqs.CPU59.SCHED
    310985 ±  4%     +23.5%     384119 ±  3%  softirqs.CPU59.TIMER
    124937 ±  4%     +21.6%     151962 ±  3%  softirqs.CPU6.RCU
      9435 ±  2%     +14.1%      10762 ±  3%  softirqs.CPU60.SCHED
    311646 ±  4%     +22.8%     382731 ±  3%  softirqs.CPU60.TIMER
      9585           +13.5%      10877 ±  2%  softirqs.CPU61.SCHED
    306857 ±  4%     +22.8%     376944 ±  2%  softirqs.CPU61.TIMER
      9483 ±  2%     +12.5%      10671 ±  5%  softirqs.CPU62.SCHED
      9620 ±  4%      +9.7%      10556 ±  4%  softirqs.CPU63.SCHED
    301085 ±  3%     +24.7%     375397 ±  3%  softirqs.CPU63.TIMER
    300443 ±  4%     +23.7%     371620 ±  2%  softirqs.CPU64.TIMER
      9667           +11.2%      10751 ±  4%  softirqs.CPU65.SCHED
    307194 ±  4%     +23.4%     379020 ±  3%  softirqs.CPU65.TIMER
      9493 ±  3%     +14.9%      10909 ±  3%  softirqs.CPU66.SCHED
    306226 ±  4%     +25.1%     383140 ±  3%  softirqs.CPU66.TIMER
      9674 ±  3%     +13.8%      11010 ±  3%  softirqs.CPU67.SCHED
    307870 ±  4%     +25.0%     384793 ±  2%  softirqs.CPU67.TIMER
      9451 ±  2%     +14.2%      10792 ±  4%  softirqs.CPU68.SCHED
    301873 ±  3%     +26.1%     380748        softirqs.CPU68.TIMER
      9542           +13.8%      10863 ±  3%  softirqs.CPU69.SCHED
    316206 ±  8%     +20.5%     380893 ±  2%  softirqs.CPU69.TIMER
    128158 ±  4%     +20.4%     154294 ±  2%  softirqs.CPU7.RCU
      9456 ±  3%     +13.5%      10734 ±  3%  softirqs.CPU70.SCHED
    305361 ±  4%     +36.4%     416546 ± 15%  softirqs.CPU70.TIMER
      9520 ±  3%     +15.4%      10985 ±  4%  softirqs.CPU71.SCHED
    305605 ±  4%     +24.6%     380653 ±  2%  softirqs.CPU71.TIMER
    122831 ±  4%     +21.6%     149424 ±  2%  softirqs.CPU8.RCU
    123870 ±  4%     +23.0%     152396 ±  2%  softirqs.CPU9.RCU
   9357957 ±  5%     +15.4%   10794953        softirqs.RCU
  23209193 ±  3%     +15.5%   26806870 ±  3%  softirqs.TIMER
      4.79 ±  4%      -3.1        1.71 ± 16%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.85 ±  4%      -2.4        1.41 ± 16%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.39 ±  4%      -2.0        1.35 ± 16%  perf-profile.calltrace.cycles-pp.copy_page_to_iter.pipe_read.new_sync_read.vfs_read.ksys_read
      2.93 ±  5%      -1.9        0.99 ± 18%  perf-profile.calltrace.cycles-pp.copy_page_from_iter.pipe_write.new_sync_write.vfs_write.ksys_write
      3.25 ±  4%      -1.9        1.31 ± 10%  perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_write.new_sync_write.vfs_write.ksys_write
      2.14 ±  4%      -1.2        0.91 ± 14%  perf-profile.calltrace.cycles-pp.selinux_file_permission.security_file_permission.vfs_read.ksys_read.do_syscall_64
      2.06 ±  4%      -1.2        0.85 ± 13%  perf-profile.calltrace.cycles-pp.selinux_file_permission.security_file_permission.vfs_write.ksys_write.do_syscall_64
      1.52 ±  3%      -1.0        0.49 ± 59%  perf-profile.calltrace.cycles-pp.copyout.copy_page_to_iter.pipe_read.new_sync_read.vfs_read
      1.46 ±  3%      -1.0        0.46 ± 59%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyout.copy_page_to_iter.pipe_read.new_sync_read
      1.53 ±  8%      -0.8        0.68 ± 12%  perf-profile.calltrace.cycles-pp.touch_atime.pipe_read.new_sync_read.vfs_read.ksys_read
      1.65 ±  4%      -0.8        0.81 ± 10%  perf-profile.calltrace.cycles-pp.__fget_light.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.45 ±  5%      -0.7        0.74 ± 10%  perf-profile.calltrace.cycles-pp.__fget_light.__fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.35 ±  5%      -0.7        0.68 ± 10%  perf-profile.calltrace.cycles-pp.__fget.__fget_light.__fdget_pos.ksys_write.do_syscall_64
      1.28 ±  8%      -0.7        0.62 ± 12%  perf-profile.calltrace.cycles-pp.file_update_time.pipe_write.new_sync_write.vfs_write.ksys_write
      1.29 ±  3%      -0.6        0.67 ±  9%  perf-profile.calltrace.cycles-pp.mutex_lock.pipe_write.new_sync_write.vfs_write.ksys_write
      0.64 ± 11%      +0.3        0.96 ±  7%  perf-profile.calltrace.cycles-pp.__lock_text_start.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write
      0.00            +0.5        0.55 ±  3%  perf-profile.calltrace.cycles-pp.pick_next_entity.pick_next_task_fair.__schedule.schedule.exit_to_usermode_loop
      0.00            +0.6        0.55 ±  5%  perf-profile.calltrace.cycles-pp.pick_next_entity.pick_next_task_fair.__schedule.schedule.pipe_wait
      0.00            +0.6        0.57 ±  6%  perf-profile.calltrace.cycles-pp.update_curr.reweight_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      0.00            +0.6        0.61 ±  7%  perf-profile.calltrace.cycles-pp.update_curr.reweight_entity.dequeue_task_fair.__schedule.schedule
      0.00            +0.7        0.69 ±  8%  perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule.pipe_wait.pipe_read
      0.00            +0.7        0.70 ±  6%  perf-profile.calltrace.cycles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule.pipe_wait
      0.00            +0.7        0.71 ± 11%  perf-profile.calltrace.cycles-pp.__enqueue_entity.put_prev_entity.pick_next_task_fair.__schedule.schedule
      0.00            +0.7        0.72 ±  7%  perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      0.00            +0.7        0.72 ±  6%  perf-profile.calltrace.cycles-pp.__update_load_avg_cfs_rq.dequeue_task_fair.__schedule.schedule.pipe_wait
      0.00            +0.8        0.76 ± 10%  perf-profile.calltrace.cycles-pp.__enqueue_entity.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      0.00            +0.8        0.77 ±  2%  perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_task_fair.__schedule.schedule
      0.00            +0.8        0.77 ±  5%  perf-profile.calltrace.cycles-pp.__switch_to
      0.00            +0.8        0.77 ±  6%  perf-profile.calltrace.cycles-pp.___perf_sw_event.__schedule.schedule.pipe_wait.pipe_read
      0.00            +0.8        0.79 ±  5%  perf-profile.calltrace.cycles-pp.update_load_avg.dequeue_entity.dequeue_task_fair.__schedule.schedule
      0.00            +0.8        0.81 ±  4%  perf-profile.calltrace.cycles-pp.mutex_lock.pipe_wait.pipe_read.new_sync_read.vfs_read
      0.00            +0.8        0.82 ±  6%  perf-profile.calltrace.cycles-pp.update_rq_clock.__schedule.schedule.pipe_wait.pipe_read
      0.00            +0.8        0.82 ±  6%  perf-profile.calltrace.cycles-pp.__update_load_avg_cfs_rq.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up
      0.00            +0.9        0.90 ±  3%  perf-profile.calltrace.cycles-pp.find_next_bit.cpumask_next_wrap.select_idle_sibling.select_task_rq_fair.try_to_wake_up
      0.00            +0.9        0.91 ±  4%  perf-profile.calltrace.cycles-pp.update_rq_clock.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      0.00            +0.9        0.91 ±  6%  perf-profile.calltrace.cycles-pp.check_preempt_wakeup.check_preempt_curr.ttwu_do_wakeup.try_to_wake_up.autoremove_wake_function
      0.00            +0.9        0.92 ±  2%  perf-profile.calltrace.cycles-pp.native_write_msr
      0.00            +1.1        1.05 ±  5%  perf-profile.calltrace.cycles-pp.check_preempt_curr.ttwu_do_wakeup.try_to_wake_up.autoremove_wake_function.__wake_up_common
      0.00            +1.1        1.08 ±  8%  perf-profile.calltrace.cycles-pp.put_prev_entity.pick_next_task_fair.__schedule.schedule.exit_to_usermode_loop
      0.00            +1.1        1.13 ±  5%  perf-profile.calltrace.cycles-pp.ttwu_do_wakeup.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      0.00            +1.2        1.17 ±  9%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.try_to_wake_up.autoremove_wake_function.__wake_up_common
      0.00            +1.2        1.18 ±  2%  perf-profile.calltrace.cycles-pp.__switch_to_asm
      0.00            +1.2        1.20 ±  9%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__schedule.schedule.pipe_wait.pipe_read
      0.00            +1.3        1.30 ±  5%  perf-profile.calltrace.cycles-pp.reweight_entity.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up
      0.00            +1.3        1.34 ±  6%  perf-profile.calltrace.cycles-pp.reweight_entity.dequeue_task_fair.__schedule.schedule.pipe_wait
      0.00            +1.6        1.62 ±  4%  perf-profile.calltrace.cycles-pp.switch_fpu_return.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.9        1.88 ±  5%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.pipe_wait.pipe_read
      0.00            +1.9        1.93 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      0.13 ±173%      +2.0        2.11 ±  5%  perf-profile.calltrace.cycles-pp.cpumask_next_wrap.select_idle_sibling.select_task_rq_fair.try_to_wake_up.autoremove_wake_function
      0.00            +2.1        2.06 ±  4%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.pipe_wait
      0.00            +2.4        2.38 ±  4%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.exit_to_usermode_loop.do_syscall_64
      0.00            +2.7        2.65 ±  4%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up
      0.35 ±103%      +4.3        4.67 ±  4%  perf-profile.calltrace.cycles-pp.__schedule.schedule.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.22 ±173%      +4.6        4.81 ±  4%  perf-profile.calltrace.cycles-pp.schedule.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.23 ±173%      +4.7        4.97 ±  4%  perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.72 ± 23%      +5.0        5.72 ±  5%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.pipe_wait.pipe_read
      0.69 ± 17%      +5.6        6.25 ±  4%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
      0.74 ± 17%      +5.8        6.50 ±  4%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
      0.74 ± 18%      +5.8        6.55 ±  5%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
     15.99 ± 54%      +7.5       23.51 ±  6%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.13            +7.7       20.86 ±  3%  perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.49            +8.7       20.19 ±  3%  perf-profile.calltrace.cycles-pp.pipe_read.new_sync_read.vfs_read.ksys_read.do_syscall_64
      1.31 ± 27%      +8.9       10.21 ±  7%  perf-profile.calltrace.cycles-pp.available_idle_cpu.select_idle_sibling.select_task_rq_fair.try_to_wake_up.autoremove_wake_function
      1.81 ± 22%     +11.2       12.98 ±  5%  perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_wait.pipe_read.new_sync_read
      1.89 ± 22%     +11.4       13.28 ±  5%  perf-profile.calltrace.cycles-pp.schedule.pipe_wait.pipe_read.new_sync_read.vfs_read
      2.18 ± 21%     +13.1       15.28 ±  4%  perf-profile.calltrace.cycles-pp.pipe_wait.pipe_read.new_sync_read.vfs_read.ksys_read
      2.01 ± 25%     +19.1       21.10 ±  7%  perf-profile.calltrace.cycles-pp.select_idle_sibling.select_task_rq_fair.try_to_wake_up.autoremove_wake_function.__wake_up_common
      2.38 ± 23%     +20.0       22.40 ±  7%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
     19.01 ±  3%     +23.4       42.38 ±  4%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.13 ± 53%     +23.8       44.92 ±  5%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     17.85 ±  4%     +23.9       41.76 ±  4%  perf-profile.calltrace.cycles-pp.pipe_write.new_sync_write.vfs_write.ksys_write.do_syscall_64
     19.16 ± 53%     +24.6       43.74 ±  5%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.79 ± 22%     +30.7       34.45 ±  6%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write
      3.84 ± 23%     +30.9       34.69 ±  6%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write.new_sync_write
      4.13 ± 21%     +31.0       35.10 ±  6%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write
      5.77 ± 14%     +31.0       36.76 ±  6%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write.ksys_write
      9.20 ±  6%      -6.0        3.16 ± 12%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      8.88 ±  3%      -5.8        3.03 ± 12%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      8.72 ±  4%      -5.3        3.39 ± 11%  perf-profile.children.cycles-pp.security_file_permission
      4.27 ±  3%      -2.4        1.89 ±  9%  perf-profile.children.cycles-pp.selinux_file_permission
      3.15 ±  5%      -2.1        1.07 ± 12%  perf-profile.children.cycles-pp.file_has_perm
      3.48 ±  3%      -2.0        1.46 ± 10%  perf-profile.children.cycles-pp.copy_page_to_iter
      3.80 ±  3%      -2.0        1.79 ±  6%  perf-profile.children.cycles-pp.mutex_unlock
      3.02 ±  5%      -1.9        1.11 ± 11%  perf-profile.children.cycles-pp.copy_page_from_iter
      3.31 ±  4%      -1.6        1.75 ±  6%  perf-profile.children.cycles-pp.__fdget_pos
      2.55 ±  3%      -1.5        1.02 ± 10%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      3.17 ±  4%      -1.5        1.70 ±  6%  perf-profile.children.cycles-pp.__fget_light
      2.10 ±  7%      -1.4        0.71 ± 12%  perf-profile.children.cycles-pp.fsnotify
      2.52 ±  6%      -1.3        1.23 ±  8%  perf-profile.children.cycles-pp.__fget
      1.77 ±  6%      -1.1        0.66 ±  9%  perf-profile.children.cycles-pp.avc_has_perm
      1.89 ±  5%      -1.1        0.78 ± 10%  perf-profile.children.cycles-pp.___might_sleep
      1.44 ±  4%      -1.0        0.48 ± 12%  perf-profile.children.cycles-pp.__inode_security_revalidate
      1.33 ± 10%      -0.9        0.40 ± 16%  perf-profile.children.cycles-pp.current_time
      1.56 ±  3%      -0.9        0.66 ±  9%  perf-profile.children.cycles-pp.copyout
      1.56 ±  8%      -0.8        0.73 ±  7%  perf-profile.children.cycles-pp.touch_atime
      1.33 ±  4%      -0.8        0.53 ± 10%  perf-profile.children.cycles-pp.__might_sleep
      1.15 ±  9%      -0.8        0.36 ± 12%  perf-profile.children.cycles-pp.atime_needs_update
      1.17 ±  4%      -0.7        0.43 ± 13%  perf-profile.children.cycles-pp.copyin
      1.23 ±  5%      -0.7        0.54 ±  9%  perf-profile.children.cycles-pp.__fsnotify_parent
      1.32 ±  7%      -0.6        0.68 ±  6%  perf-profile.children.cycles-pp.file_update_time
      1.02 ±  3%      -0.6        0.38 ± 12%  perf-profile.children.cycles-pp.__might_fault
      2.54 ±  2%      -0.5        2.03        perf-profile.children.cycles-pp.mutex_lock
      0.78 ±  4%      -0.4        0.36 ± 10%  perf-profile.children.cycles-pp.fput_many
      0.53 ±  4%      -0.4        0.15 ± 21%  perf-profile.children.cycles-pp.inode_has_perm
      0.44 ± 12%      -0.3        0.11 ± 22%  perf-profile.children.cycles-pp.iov_iter_init
      0.76 ±  4%      -0.3        0.44 ±  8%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.53 ±  3%      -0.3        0.21 ±  6%  perf-profile.children.cycles-pp.rcu_all_qs
      0.41 ±  9%      -0.3        0.12 ± 15%  perf-profile.children.cycles-pp.timespec64_trunc
      0.97            -0.3        0.71 ±  3%  perf-profile.children.cycles-pp._cond_resched
      0.47 ±  7%      -0.3        0.21 ± 11%  perf-profile.children.cycles-pp.__x64_sys_read
      0.45 ±  7%      -0.3        0.20 ± 10%  perf-profile.children.cycles-pp.__x64_sys_write
      0.37 ±  4%      -0.2        0.17 ± 16%  perf-profile.children.cycles-pp.generic_pipe_buf_confirm
      0.44 ± 12%      -0.2        0.24 ±  3%  perf-profile.children.cycles-pp.__sb_start_write
      0.31 ±  6%      -0.2        0.12 ± 13%  perf-profile.children.cycles-pp.__sb_end_write
      0.36 ±  7%      -0.2        0.18 ±  6%  perf-profile.children.cycles-pp.rw_verify_area
      0.26 ± 14%      -0.2        0.09 ± 14%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.29 ±  8%      -0.2        0.14 ± 16%  perf-profile.children.cycles-pp.fpregs_assert_state_consistent
      0.22 ± 39%      -0.2        0.06 ± 11%  perf-profile.children.cycles-pp.__vfs_read
      0.21 ± 19%      -0.1        0.11 ±  9%  perf-profile.children.cycles-pp.__mutex_unlock_slowpath
      0.12 ±  9%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__vfs_write
      0.12 ± 17%      -0.0        0.08 ± 11%  perf-profile.children.cycles-pp.wake_up_q
      0.08 ± 10%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.kill_fasync
      0.11 ±  7%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.swapgs_restore_regs_and_return_to_usermode
      0.09 ±  5%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.prepare_exit_to_usermode
      0.01 ±173%      +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__mnt_want_write
      0.07 ± 25%      +0.1        0.12 ± 27%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.08 ± 30%      +0.1        0.14 ± 26%  perf-profile.children.cycles-pp.irq_exit
      0.06 ±  6%      +0.1        0.12 ± 10%  perf-profile.children.cycles-pp.__mark_inode_dirty
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.preempt_schedule_common
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.is_cpu_allowed
      0.03 ±100%      +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.native_apic_msr_eoi_write
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.__x2apic_send_IPI_dest
      0.01 ±173%      +0.1        0.09 ± 32%  perf-profile.children.cycles-pp.migrate_task_rq_fair
      0.00            +0.1        0.07 ± 14%  perf-profile.children.cycles-pp.update_cfs_rq_h_load
      0.05 ± 61%      +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.00            +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.rcu_note_context_switch
      0.00            +0.1        0.08 ± 13%  perf-profile.children.cycles-pp.smp_reschedule_interrupt
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.native_load_tls
      0.03 ±102%      +0.1        0.12 ± 30%  perf-profile.children.cycles-pp.set_task_cpu
      0.00            +0.1        0.09 ± 11%  perf-profile.children.cycles-pp.check_cfs_rq_runtime
      0.00            +0.1        0.10 ±  5%  perf-profile.children.cycles-pp.rb_next
      0.10 ± 10%      +0.1        0.20 ±  9%  perf-profile.children.cycles-pp.generic_update_time
      0.00            +0.1        0.10 ± 29%  perf-profile.children.cycles-pp.__x64_sys_exit
      0.00            +0.1        0.10 ± 28%  perf-profile.children.cycles-pp.do_exit
      0.00            +0.1        0.11 ±  8%  perf-profile.children.cycles-pp.rb_insert_color
      0.00            +0.1        0.11 ±  7%  perf-profile.children.cycles-pp.__list_add_valid
      0.00            +0.1        0.12 ±  7%  perf-profile.children.cycles-pp.resched_curr
      0.00            +0.1        0.12 ±  6%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.13 ± 10%      +0.1        0.26 ±  4%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.00            +0.1        0.15 ±  4%  perf-profile.children.cycles-pp.set_next_buddy
      0.00            +0.2        0.16 ±  5%  perf-profile.children.cycles-pp.deactivate_task
      0.05 ±  9%      +0.2        0.22 ±  7%  perf-profile.children.cycles-pp.rb_erase
      0.06 ± 13%      +0.2        0.23 ±  9%  perf-profile.children.cycles-pp.finish_wait
      0.17 ± 12%      +0.2        0.35 ±  2%  perf-profile.children.cycles-pp.anon_pipe_buf_release
      0.01 ±173%      +0.2        0.20 ±  8%  perf-profile.children.cycles-pp.wakeup_preempt_entity
      0.00            +0.2        0.21 ±  4%  perf-profile.children.cycles-pp.cpumask_next
      0.07 ± 22%      +0.3        0.40 ±  2%  perf-profile.children.cycles-pp.prepare_to_wait
      0.03 ±100%      +0.4        0.39 ±  5%  perf-profile.children.cycles-pp.update_min_vruntime
      0.03 ±100%      +0.4        0.39 ± 12%  perf-profile.children.cycles-pp.cpus_share_cache
      0.06 ± 14%      +0.4        0.43        perf-profile.children.cycles-pp.clear_buddies
      0.11 ± 15%      +0.4        0.50 ±  3%  perf-profile.children.cycles-pp.cpuacct_charge
      0.10 ± 26%      +0.4        0.49 ±  4%  perf-profile.children.cycles-pp.native_sched_clock
      0.32 ± 31%      +0.4        0.75 ± 14%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.11 ± 26%      +0.4        0.56 ±  3%  perf-profile.children.cycles-pp.sched_clock
      0.34 ± 32%      +0.5        0.80 ± 15%  perf-profile.children.cycles-pp.scheduler_ipi
      0.08 ± 12%      +0.5        0.56 ±  7%  perf-profile.children.cycles-pp.account_entity_enqueue
      0.13 ± 26%      +0.5        0.62 ±  3%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.14 ± 26%      +0.6        0.77 ±  4%  perf-profile.children.cycles-pp.__calc_delta
      0.08 ± 16%      +0.7        0.76 ±  3%  perf-profile.children.cycles-pp.account_entity_dequeue
      0.84 ±  5%      +0.7        1.54 ±  5%  perf-profile.children.cycles-pp.__lock_text_start
      1.61 ± 16%      +0.7        2.31 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.42 ± 31%      +0.7        1.12 ± 13%  perf-profile.children.cycles-pp.reschedule_interrupt
      0.24 ± 28%      +0.9        1.11        perf-profile.children.cycles-pp.native_write_msr
      0.14 ± 22%      +0.9        1.01 ±  5%  perf-profile.children.cycles-pp.check_preempt_wakeup
      0.24 ± 32%      +0.9        1.12 ±  7%  perf-profile.children.cycles-pp.finish_task_switch
      0.22 ± 22%      +0.9        1.10 ±  3%  perf-profile.children.cycles-pp.find_next_bit
      0.22 ± 23%      +0.9        1.12 ±  3%  perf-profile.children.cycles-pp.set_next_entity
      0.21 ± 32%      +0.9        1.14 ±  3%  perf-profile.children.cycles-pp.update_cfs_group
      0.16 ± 23%      +1.0        1.15 ±  4%  perf-profile.children.cycles-pp.check_preempt_curr
      0.21 ± 30%      +1.0        1.21 ±  2%  perf-profile.children.cycles-pp.__switch_to
      0.23 ± 21%      +1.0        1.24 ±  2%  perf-profile.children.cycles-pp.__switch_to_asm
      0.16 ± 38%      +1.0        1.20 ±  4%  perf-profile.children.cycles-pp.___perf_sw_event
      0.15 ± 26%      +1.0        1.20 ±  3%  perf-profile.children.cycles-pp.pick_next_entity
      0.15 ± 20%      +1.1        1.21 ±  7%  perf-profile.children.cycles-pp.put_prev_entity
      0.17 ± 22%      +1.1        1.23 ±  4%  perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.19 ± 10%      +1.3        1.52 ± 10%  perf-profile.children.cycles-pp.__enqueue_entity
      0.24 ± 23%      +1.3        1.59 ±  6%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.28 ± 23%      +1.4        1.64 ±  3%  perf-profile.children.cycles-pp.switch_fpu_return
      0.31 ± 29%      +1.6        1.88 ±  5%  perf-profile.children.cycles-pp.update_rq_clock
      0.44 ± 21%      +1.8        2.24 ±  4%  perf-profile.children.cycles-pp.cpumask_next_wrap
      0.33 ± 20%      +1.8        2.15 ±  4%  perf-profile.children.cycles-pp.dequeue_entity
     23.28 ±  2%      +2.0       25.27 ±  2%  perf-profile.children.cycles-pp.ksys_read
      0.46 ± 25%      +2.1        2.57 ±  5%  perf-profile.children.cycles-pp.update_load_avg
      0.20 ± 21%      +2.1        2.34 ±  4%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.91 ± 29%      +2.2        3.12 ± 11%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.38 ± 23%      +2.4        2.80 ±  4%  perf-profile.children.cycles-pp.reweight_entity
      0.52 ± 18%      +2.4        2.96 ±  3%  perf-profile.children.cycles-pp.enqueue_entity
      0.49 ± 23%      +2.6        3.10 ±  4%  perf-profile.children.cycles-pp.update_curr
     20.92 ±  2%      +3.2       24.12 ±  2%  perf-profile.children.cycles-pp.vfs_read
      0.21 ± 23%      +3.4        3.65 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock
      0.76 ± 24%      +3.9        4.67 ±  3%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.66 ± 34%      +4.4        5.06 ±  2%  perf-profile.children.cycles-pp.exit_to_usermode_loop
      0.81 ± 22%      +5.0        5.83 ±  4%  perf-profile.children.cycles-pp.dequeue_task_fair
      1.01 ± 21%      +5.8        6.86 ±  4%  perf-profile.children.cycles-pp.enqueue_task_fair
      1.06 ± 21%      +6.0        7.10 ±  4%  perf-profile.children.cycles-pp.activate_task
      1.07 ± 21%      +6.1        7.15 ±  4%  perf-profile.children.cycles-pp.ttwu_do_activate
     13.19            +7.8       20.94 ±  3%  perf-profile.children.cycles-pp.new_sync_read
     11.61            +8.7       20.29 ±  3%  perf-profile.children.cycles-pp.pipe_read
      1.45 ± 25%      +8.9       10.35 ±  7%  perf-profile.children.cycles-pp.available_idle_cpu
     78.85 ±  2%      +9.8       88.66        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     77.90 ±  2%     +10.1       88.00        perf-profile.children.cycles-pp.do_syscall_64
      2.42 ± 21%     +12.9       15.36 ±  4%  perf-profile.children.cycles-pp.pipe_wait
      2.71 ± 26%     +15.4       18.12 ±  4%  perf-profile.children.cycles-pp.__schedule
      2.76 ± 25%     +15.6       18.37 ±  4%  perf-profile.children.cycles-pp.schedule
     27.59 ±  2%     +18.6       46.17 ±  3%  perf-profile.children.cycles-pp.ksys_write
      2.26 ± 23%     +19.0       21.30 ±  7%  perf-profile.children.cycles-pp.select_idle_sibling
     24.98 ±  2%     +19.9       44.88 ±  3%  perf-profile.children.cycles-pp.vfs_write
      2.48 ± 23%     +20.0       22.46 ±  7%  perf-profile.children.cycles-pp.select_task_rq_fair
     19.06 ±  3%     +23.3       42.41 ±  4%  perf-profile.children.cycles-pp.new_sync_write
     17.98 ±  4%     +23.9       41.93 ±  4%  perf-profile.children.cycles-pp.pipe_write
      4.03 ± 21%     +30.6       34.60 ±  6%  perf-profile.children.cycles-pp.try_to_wake_up
      3.97 ± 22%     +30.8       34.74 ±  6%  perf-profile.children.cycles-pp.autoremove_wake_function
      4.30 ± 20%     +30.9       35.19 ±  6%  perf-profile.children.cycles-pp.__wake_up_common
      6.06 ± 14%     +31.2       37.21 ±  5%  perf-profile.children.cycles-pp.__wake_up_common_lock
     24.41 ±  6%     -15.5        8.96 ± 10%  perf-profile.self.cycles-pp.do_syscall_64
      9.18 ±  6%      -6.0        3.14 ± 12%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      8.63 ±  5%      -5.6        3.00 ± 12%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      3.71 ±  3%      -2.0        1.73 ±  6%  perf-profile.self.cycles-pp.mutex_unlock
      2.47 ±  3%      -1.5        0.96 ± 10%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      2.76 ±  3%      -1.4        1.35 ±  8%  perf-profile.self.cycles-pp.selinux_file_permission
      2.02 ±  7%      -1.3        0.68 ± 12%  perf-profile.self.cycles-pp.fsnotify
      2.46 ±  6%      -1.3        1.20 ±  8%  perf-profile.self.cycles-pp.__fget
      1.75 ±  6%      -1.1        0.64 ± 10%  perf-profile.self.cycles-pp.avc_has_perm
      1.83 ±  5%      -1.1        0.75 ± 10%  perf-profile.self.cycles-pp.___might_sleep
      1.75            -1.0        0.77 ±  7%  perf-profile.self.cycles-pp.pipe_write
      1.20 ±  4%      -0.7        0.46 ± 10%  perf-profile.self.cycles-pp.__might_sleep
      1.29 ± 11%      -0.7        0.58 ± 10%  perf-profile.self.cycles-pp.new_sync_read
      1.63 ±  4%      -0.7        0.97 ±  5%  perf-profile.self.cycles-pp.pipe_read
      1.15 ±  5%      -0.7        0.49 ±  8%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.89 ±  8%      -0.6        0.27 ± 15%  perf-profile.self.cycles-pp.copy_page_from_iter
      0.89 ±  4%      -0.6        0.29 ± 14%  perf-profile.self.cycles-pp.security_file_permission
      0.83 ±  5%      -0.6        0.24 ± 21%  perf-profile.self.cycles-pp.file_has_perm
      0.90 ±  2%      -0.5        0.41 ±  6%  perf-profile.self.cycles-pp.new_sync_write
      0.67 ± 10%      -0.5        0.20 ± 15%  perf-profile.self.cycles-pp.current_time
      0.83 ±  4%      -0.4        0.41 ± 10%  perf-profile.self.cycles-pp.copy_page_to_iter
      0.72 ±  7%      -0.4        0.31 ±  9%  perf-profile.self.cycles-pp.vfs_write
      0.75 ±  4%      -0.4        0.35 ±  9%  perf-profile.self.cycles-pp.fput_many
      1.01 ±  4%      -0.3        0.69 ±  5%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.45 ±  4%      -0.3        0.14 ± 19%  perf-profile.self.cycles-pp.inode_has_perm
      0.54 ±  8%      -0.3        0.23 ±  9%  perf-profile.self.cycles-pp.file_update_time
      0.41 ± 10%      -0.3        0.11 ± 20%  perf-profile.self.cycles-pp.iov_iter_init
      0.49 ±  7%      -0.3        0.19 ±  8%  perf-profile.self.cycles-pp.atime_needs_update
      0.44 ±  7%      -0.3        0.15 ± 14%  perf-profile.self.cycles-pp.ksys_read
      0.44 ±  7%      -0.3        0.17 ±  9%  perf-profile.self.cycles-pp.__inode_security_revalidate
      0.41 ±  2%      -0.3        0.15 ±  8%  perf-profile.self.cycles-pp.rcu_all_qs
      0.43 ±  8%      -0.3        0.17 ± 11%  perf-profile.self.cycles-pp.ksys_write
      0.37 ±  9%      -0.3        0.11 ± 17%  perf-profile.self.cycles-pp.timespec64_trunc
      0.42 ± 14%      -0.2        0.18 ±  8%  perf-profile.self.cycles-pp.__sb_start_write
      0.39 ±  7%      -0.2        0.17 ± 11%  perf-profile.self.cycles-pp.__x64_sys_write
      0.40 ±  8%      -0.2        0.17 ±  8%  perf-profile.self.cycles-pp.__x64_sys_read
      0.41 ±  7%      -0.2        0.20 ± 11%  perf-profile.self.cycles-pp.__wake_up_common_lock
      0.60 ±  4%      -0.2        0.39 ±  7%  perf-profile.self.cycles-pp.__x86_indirect_thunk_rax
      1.25            -0.2        1.04 ±  2%  perf-profile.self.cycles-pp.mutex_lock
      0.30 ±  6%      -0.2        0.12 ± 15%  perf-profile.self.cycles-pp.__sb_end_write
      0.35 ±  5%      -0.2        0.18 ±  3%  perf-profile.self.cycles-pp.rw_verify_area
      0.34 ±  7%      -0.2        0.18 ±  8%  perf-profile.self.cycles-pp.touch_atime
      0.32 ±  4%      -0.2        0.15 ± 14%  perf-profile.self.cycles-pp.generic_pipe_buf_confirm
      0.23 ± 16%      -0.2        0.08 ± 11%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.74 ±  3%      -0.2        0.59 ±  5%  perf-profile.self.cycles-pp.vfs_read
      0.60 ±  3%      -0.2        0.45 ±  4%  perf-profile.self.cycles-pp.__fget_light
      0.27 ±  8%      -0.1        0.12 ± 15%  perf-profile.self.cycles-pp.fpregs_assert_state_consistent
      0.18 ± 45%      -0.1        0.04 ± 58%  perf-profile.self.cycles-pp.__vfs_read
      0.18 ±  5%      -0.1        0.06 ± 17%  perf-profile.self.cycles-pp.__fdget_pos
      0.25 ±  5%      -0.1        0.14 ± 11%  perf-profile.self.cycles-pp.__might_fault
      0.07 ±  7%      -0.0        0.04 ± 57%  perf-profile.self.cycles-pp.kill_fasync
      0.01 ±173%      +0.1        0.06 ± 17%  perf-profile.self.cycles-pp.sched_ttwu_pending
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.scheduler_ipi
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.rcu_note_context_switch
      0.01 ±173%      +0.1        0.07 ± 12%  perf-profile.self.cycles-pp.generic_update_time
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.cpumask_next
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.ttwu_do_activate
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.__mnt_want_write
      0.06 ± 14%      +0.1        0.12 ± 10%  perf-profile.self.cycles-pp.__mark_inode_dirty
      0.00            +0.1        0.06 ± 13%  perf-profile.self.cycles-pp.is_cpu_allowed
      0.00            +0.1        0.07 ± 13%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.sched_clock
      0.03 ±100%      +0.1        0.10 ± 11%  perf-profile.self.cycles-pp.native_apic_msr_eoi_write
      0.00            +0.1        0.07 ± 14%  perf-profile.self.cycles-pp.update_cfs_rq_h_load
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.native_load_tls
      0.05 ± 60%      +0.1        0.13 ±  5%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.00            +0.1        0.09 ±  9%  perf-profile.self.cycles-pp.ttwu_do_wakeup
      0.00            +0.1        0.09 ± 11%  perf-profile.self.cycles-pp.rb_next
      0.00            +0.1        0.10 ±  8%  perf-profile.self.cycles-pp.__list_add_valid
      0.00            +0.1        0.10 ± 10%  perf-profile.self.cycles-pp.rb_insert_color
      0.00            +0.1        0.11 ±  9%  perf-profile.self.cycles-pp.resched_curr
      0.00            +0.1        0.11 ±  7%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.32 ±  7%      +0.1        0.45 ±  5%  perf-profile.self.cycles-pp.__wake_up_common
      0.13 ± 10%      +0.1        0.25 ±  5%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.00            +0.1        0.13 ±  5%  perf-profile.self.cycles-pp.autoremove_wake_function
      0.00            +0.1        0.13 ±  8%  perf-profile.self.cycles-pp.check_preempt_curr
      0.04 ± 58%      +0.1        0.18 ± 10%  perf-profile.self.cycles-pp.finish_wait
      0.00            +0.1        0.14 ±  5%  perf-profile.self.cycles-pp.set_next_buddy
      0.00            +0.1        0.15 ±  3%  perf-profile.self.cycles-pp.put_prev_entity
      0.00            +0.2        0.15 ±  5%  perf-profile.self.cycles-pp.deactivate_task
      0.05 ±  9%      +0.2        0.21 ±  5%  perf-profile.self.cycles-pp.rb_erase
      0.00            +0.2        0.15 ± 10%  perf-profile.self.cycles-pp.exit_to_usermode_loop
      0.00            +0.2        0.18 ±  6%  perf-profile.self.cycles-pp.wakeup_preempt_entity
      0.15 ±  7%      +0.2        0.34 ±  2%  perf-profile.self.cycles-pp.anon_pipe_buf_release
      0.03 ±100%      +0.2        0.21 ±  8%  perf-profile.self.cycles-pp.pipe_wait
      0.03 ±102%      +0.2        0.24 ±  3%  perf-profile.self.cycles-pp.activate_task
      0.01 ±173%      +0.2        0.23 ±  3%  perf-profile.self.cycles-pp.prepare_to_wait
      0.03 ±100%      +0.2        0.25 ±  4%  perf-profile.self.cycles-pp.set_next_entity
      0.02 ±173%      +0.2        0.26 ±  9%  perf-profile.self.cycles-pp.dequeue_entity
      0.04 ±100%      +0.3        0.29 ±  5%  perf-profile.self.cycles-pp.enqueue_entity
      0.08 ± 31%      +0.3        0.34 ±  2%  perf-profile.self.cycles-pp.schedule
      0.78 ±  3%      +0.3        1.09        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.09 ± 24%      +0.3        0.42 ±  7%  perf-profile.self.cycles-pp.finish_task_switch
      0.03 ±100%      +0.3        0.37 ±  6%  perf-profile.self.cycles-pp.update_min_vruntime
      0.03 ±102%      +0.4        0.38        perf-profile.self.cycles-pp.clear_buddies
      0.03 ±100%      +0.4        0.39 ± 12%  perf-profile.self.cycles-pp.cpus_share_cache
      0.07 ± 22%      +0.4        0.44 ±  7%  perf-profile.self.cycles-pp.check_preempt_wakeup
      0.09 ± 27%      +0.4        0.47 ±  4%  perf-profile.self.cycles-pp.native_sched_clock
      0.07 ± 26%      +0.4        0.45 ±  4%  perf-profile.self.cycles-pp.pick_next_entity
      0.11 ± 15%      +0.4        0.50 ±  3%  perf-profile.self.cycles-pp.cpuacct_charge
      0.07 ± 14%      +0.5        0.53 ±  8%  perf-profile.self.cycles-pp.account_entity_enqueue
      0.10 ± 21%      +0.5        0.56 ±  8%  perf-profile.self.cycles-pp.try_to_wake_up
      0.10 ± 18%      +0.5        0.62 ±  6%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.14 ± 26%      +0.6        0.75 ±  4%  perf-profile.self.cycles-pp.__calc_delta
      0.06 ± 13%      +0.6        0.68 ±  4%  perf-profile.self.cycles-pp.account_entity_dequeue
      0.15 ± 27%      +0.6        0.79 ±  6%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.17 ± 30%      +0.7        0.89 ±  4%  perf-profile.self.cycles-pp.update_load_avg
      0.15 ± 20%      +0.7        0.88 ±  4%  perf-profile.self.cycles-pp.reweight_entity
      0.15 ± 23%      +0.8        0.96 ±  3%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.24 ± 30%      +0.9        1.11        perf-profile.self.cycles-pp.native_write_msr
      0.20 ± 23%      +0.9        1.07 ±  5%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.20 ± 22%      +0.9        1.07 ±  3%  perf-profile.self.cycles-pp.find_next_bit
      0.20 ± 31%      +0.9        1.11 ±  3%  perf-profile.self.cycles-pp.update_cfs_group
      0.20 ± 28%      +0.9        1.14 ±  2%  perf-profile.self.cycles-pp.__switch_to
      0.14 ± 37%      +1.0        1.13 ±  5%  perf-profile.self.cycles-pp.___perf_sw_event
      0.21 ± 24%      +1.0        1.22 ±  2%  perf-profile.self.cycles-pp.__switch_to_asm
      0.24 ± 23%      +1.1        1.31 ±  5%  perf-profile.self.cycles-pp.cpumask_next_wrap
      0.23 ± 32%      +1.3        1.49 ±  5%  perf-profile.self.cycles-pp.update_rq_clock
      0.19 ± 28%      +1.3        1.45 ±  6%  perf-profile.self.cycles-pp.update_curr
      0.23 ± 23%      +1.3        1.55 ±  6%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.19 ± 10%      +1.3        1.51 ± 10%  perf-profile.self.cycles-pp.__enqueue_entity
      0.28 ± 22%      +1.3        1.63 ±  3%  perf-profile.self.cycles-pp.switch_fpu_return
      0.11 ± 19%      +1.6        1.72 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock
      0.42 ± 26%      +1.7        2.12 ±  2%  perf-profile.self.cycles-pp.__schedule
      0.19 ± 20%      +2.0        2.20 ±  4%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.91 ± 29%      +2.2        3.11 ± 12%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.32 ± 19%      +7.7        8.05 ±  7%  perf-profile.self.cycles-pp.select_idle_sibling
      1.44 ± 25%      +8.8       10.23 ±  7%  perf-profile.self.cycles-pp.available_idle_cpu
    439.00           +11.7%     490.50        interrupts.100:IR-PCI-MSI.1572923-edge.eth0-TxRx-59
    436.25           +13.1%     493.25        interrupts.101:IR-PCI-MSI.1572924-edge.eth0-TxRx-60
    436.25           +12.4%     490.50        interrupts.102:IR-PCI-MSI.1572925-edge.eth0-TxRx-61
    436.25           +12.4%     490.50        interrupts.103:IR-PCI-MSI.1572926-edge.eth0-TxRx-62
    509.75 ±  3%    +545.1%       3288 ±120%  interrupts.42:IR-PCI-MSI.1572867-edge.eth0-TxRx-3
    474.00 ±  3%     +49.7%     709.75 ± 24%  interrupts.46:IR-PCI-MSI.1572871-edge.eth0-TxRx-7
    588.00 ± 35%    +196.0%       1740 ± 50%  interrupts.51:IR-PCI-MSI.1572876-edge.eth0-TxRx-12
    436.75 ±  2%     +12.8%     492.50        interrupts.55:IR-PCI-MSI.1572880-edge.eth0-TxRx-16
    438.00           +39.5%     611.00 ± 33%  interrupts.57:IR-PCI-MSI.1572882-edge.eth0-TxRx-18
    436.25           +13.8%     496.25        interrupts.58:IR-PCI-MSI.1572883-edge.eth0-TxRx-19
    436.25           +14.3%     498.50        interrupts.59:IR-PCI-MSI.1572884-edge.eth0-TxRx-20
    437.00           +12.2%     490.50        interrupts.60:IR-PCI-MSI.1572885-edge.eth0-TxRx-21
    436.25           +12.4%     490.50        interrupts.61:IR-PCI-MSI.1572886-edge.eth0-TxRx-22
    436.25           +12.4%     490.50        interrupts.62:IR-PCI-MSI.1572887-edge.eth0-TxRx-23
    441.00           +11.8%     493.00        interrupts.63:IR-PCI-MSI.1572888-edge.eth0-TxRx-24
    437.25           +13.3%     495.25        interrupts.64:IR-PCI-MSI.1572889-edge.eth0-TxRx-25
    436.25           +12.4%     490.50        interrupts.65:IR-PCI-MSI.1572890-edge.eth0-TxRx-26
    436.25           +12.4%     490.50        interrupts.68:IR-PCI-MSI.1572893-edge.eth0-TxRx-29
    436.25           +12.4%     490.50        interrupts.69:IR-PCI-MSI.1572894-edge.eth0-TxRx-30
    436.25           +12.4%     490.50        interrupts.71:IR-PCI-MSI.1572896-edge.eth0-TxRx-32
    437.25 ±  2%     +12.2%     490.50        interrupts.74:IR-PCI-MSI.1572897-edge.eth0-TxRx-33
    436.25           +12.6%     491.25        interrupts.75:IR-PCI-MSI.1572898-edge.eth0-TxRx-34
    440.75           +12.4%     495.25 ±  2%  interrupts.76:IR-PCI-MSI.1572899-edge.eth0-TxRx-35
    436.25           +12.6%     491.00        interrupts.77:IR-PCI-MSI.1572900-edge.eth0-TxRx-36
    436.75           +13.1%     493.75        interrupts.78:IR-PCI-MSI.1572901-edge.eth0-TxRx-37
    436.25           +12.8%     492.25        interrupts.79:IR-PCI-MSI.1572902-edge.eth0-TxRx-38
    436.25           +12.8%     492.25        interrupts.80:IR-PCI-MSI.1572903-edge.eth0-TxRx-39
    436.25           +12.4%     490.50        interrupts.81:IR-PCI-MSI.1572904-edge.eth0-TxRx-40
    436.25           +12.4%     490.50        interrupts.82:IR-PCI-MSI.1572905-edge.eth0-TxRx-41
    436.25           +12.4%     490.50        interrupts.83:IR-PCI-MSI.1572906-edge.eth0-TxRx-42
    436.25           +14.6%     499.75 ±  2%  interrupts.84:IR-PCI-MSI.1572907-edge.eth0-TxRx-43
    436.25           +12.4%     490.50        interrupts.85:IR-PCI-MSI.1572908-edge.eth0-TxRx-44
    436.50           +12.4%     490.50        interrupts.86:IR-PCI-MSI.1572909-edge.eth0-TxRx-45
    436.25           +12.4%     490.50        interrupts.87:IR-PCI-MSI.1572910-edge.eth0-TxRx-46
    436.25           +12.4%     490.50        interrupts.88:IR-PCI-MSI.1572911-edge.eth0-TxRx-47
    436.25           +12.6%     491.00        interrupts.89:IR-PCI-MSI.1572912-edge.eth0-TxRx-48
    441.25 ±  3%     +14.1%     503.25 ±  3%  interrupts.90:IR-PCI-MSI.1572913-edge.eth0-TxRx-49
    436.25           +12.4%     490.50        interrupts.91:IR-PCI-MSI.1572914-edge.eth0-TxRx-50
    436.25           +14.4%     499.25 ±  3%  interrupts.92:IR-PCI-MSI.1572915-edge.eth0-TxRx-51
    439.25 ±  2%     +11.7%     490.50        interrupts.94:IR-PCI-MSI.1572917-edge.eth0-TxRx-53
    437.75           +12.1%     490.50        interrupts.95:IR-PCI-MSI.1572918-edge.eth0-TxRx-54
    436.50           +12.4%     490.50        interrupts.96:IR-PCI-MSI.1572919-edge.eth0-TxRx-55
    436.25           +12.4%     490.50        interrupts.97:IR-PCI-MSI.1572920-edge.eth0-TxRx-56
    439.00 ±  2%     +11.7%     490.50        interrupts.98:IR-PCI-MSI.1572921-edge.eth0-TxRx-57
    442.25 ±  3%     +10.9%     490.50        interrupts.99:IR-PCI-MSI.1572922-edge.eth0-TxRx-58
      1989           +12.1%       2230        interrupts.9:IR-IO-APIC.9-fasteoi.acpi
   6596036 ± 10%     -21.1%    5206443 ±  6%  interrupts.CAL:Function_call_interrupts
     86097 ± 13%     -18.4%      70229 ±  7%  interrupts.CPU0.CAL:Function_call_interrupts
   1785369           +12.4%    2006294        interrupts.CPU0.LOC:Local_timer_interrupts
    102823 ± 12%     -18.3%      84031 ±  5%  interrupts.CPU0.TLB:TLB_shootdowns
    388425 ± 12%     +27.8%     496548 ±  4%  interrupts.CPU0.TRM:Thermal_event_interrupts
      1989           +12.1%       2230        interrupts.CPU1.9:IR-IO-APIC.9-fasteoi.acpi
     90370 ±  8%     -21.4%      70995 ±  6%  interrupts.CPU1.CAL:Function_call_interrupts
   1784834           +12.4%    2006046        interrupts.CPU1.LOC:Local_timer_interrupts
   3088391 ± 15%     -20.9%    2441882 ±  7%  interrupts.CPU1.RES:Rescheduling_interrupts
    105391 ±  8%     -18.6%      85793 ±  6%  interrupts.CPU1.TLB:TLB_shootdowns
    388373 ± 12%     +27.9%     496558 ±  4%  interrupts.CPU1.TRM:Thermal_event_interrupts
     88236 ± 11%     -19.5%      71001 ±  7%  interrupts.CPU10.CAL:Function_call_interrupts
   1785471           +12.3%    2004740        interrupts.CPU10.LOC:Local_timer_interrupts
   3040774 ±  4%     -21.1%    2398396 ±  8%  interrupts.CPU10.RES:Rescheduling_interrupts
    104483 ± 10%     -18.6%      85025 ±  5%  interrupts.CPU10.TLB:TLB_shootdowns
    388417 ± 12%     +27.8%     496560 ±  4%  interrupts.CPU10.TRM:Thermal_event_interrupts
   1785039           +12.3%    2005274        interrupts.CPU11.LOC:Local_timer_interrupts
    925.75 ±173%    +461.3%       5196 ± 58%  interrupts.CPU11.NMI:Non-maskable_interrupts
    925.75 ±173%    +461.3%       5196 ± 58%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
   3094193 ± 14%     -21.5%    2430228 ±  8%  interrupts.CPU11.RES:Rescheduling_interrupts
    102398 ± 10%     -16.1%      85884 ±  5%  interrupts.CPU11.TLB:TLB_shootdowns
    388413 ± 12%     +27.8%     496474 ±  4%  interrupts.CPU11.TRM:Thermal_event_interrupts
    588.00 ± 35%    +196.0%       1740 ± 50%  interrupts.CPU12.51:IR-PCI-MSI.1572876-edge.eth0-TxRx-12
     87438 ±  9%     -18.1%      71580 ±  7%  interrupts.CPU12.CAL:Function_call_interrupts
   1785376           +12.3%    2005068        interrupts.CPU12.LOC:Local_timer_interrupts
    103057 ± 10%     -16.4%      86186 ±  6%  interrupts.CPU12.TLB:TLB_shootdowns
    388416 ± 12%     +27.8%     496490 ±  4%  interrupts.CPU12.TRM:Thermal_event_interrupts
     88735 ±  9%     -19.4%      71496 ±  9%  interrupts.CPU13.CAL:Function_call_interrupts
   1785460           +12.3%    2005445        interrupts.CPU13.LOC:Local_timer_interrupts
    104230 ±  9%     -17.5%      86038 ±  6%  interrupts.CPU13.TLB:TLB_shootdowns
    388422 ± 12%     +27.8%     496563 ±  4%  interrupts.CPU13.TRM:Thermal_event_interrupts
     88327 ± 12%     -19.0%      71507 ±  7%  interrupts.CPU14.CAL:Function_call_interrupts
   1785094           +12.3%    2005441        interrupts.CPU14.LOC:Local_timer_interrupts
    103317 ± 11%     -18.1%      84581 ±  6%  interrupts.CPU14.TLB:TLB_shootdowns
    388412 ± 12%     +27.8%     496564 ±  4%  interrupts.CPU14.TRM:Thermal_event_interrupts
     86972 ± 10%     -17.3%      71898 ±  7%  interrupts.CPU15.CAL:Function_call_interrupts
   1784668           +12.4%    2005375        interrupts.CPU15.LOC:Local_timer_interrupts
   3039799 ±  9%     -21.1%    2397505 ±  9%  interrupts.CPU15.RES:Rescheduling_interrupts
    103367 ± 12%     -16.9%      85892 ±  6%  interrupts.CPU15.TLB:TLB_shootdowns
    388342 ± 12%     +27.9%     496559 ±  4%  interrupts.CPU15.TRM:Thermal_event_interrupts
    436.75 ±  2%     +12.8%     492.50        interrupts.CPU16.55:IR-PCI-MSI.1572880-edge.eth0-TxRx-16
   1784750           +12.4%    2005330        interrupts.CPU16.LOC:Local_timer_interrupts
     55.25 ±171%   +7696.8%       4307 ± 64%  interrupts.CPU16.NMI:Non-maskable_interrupts
     55.25 ±171%   +7696.8%       4307 ± 64%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
   2969996 ± 10%     -18.7%    2413141 ±  9%  interrupts.CPU16.RES:Rescheduling_interrupts
    102367 ± 11%     -13.7%      88305 ±  3%  interrupts.CPU16.TLB:TLB_shootdowns
    388423 ± 12%     +27.8%     496563 ±  4%  interrupts.CPU16.TRM:Thermal_event_interrupts
   1785363           +12.3%    2005849        interrupts.CPU17.LOC:Local_timer_interrupts
    388418 ± 12%     +27.8%     496560 ±  4%  interrupts.CPU17.TRM:Thermal_event_interrupts
    438.00           +39.5%     611.00 ± 33%  interrupts.CPU18.57:IR-PCI-MSI.1572882-edge.eth0-TxRx-18
     88992 ± 12%     -22.3%      69145 ±  6%  interrupts.CPU18.CAL:Function_call_interrupts
   1785398           +12.1%    2001316        interrupts.CPU18.LOC:Local_timer_interrupts
   2199105 ±  7%    +115.2%    4731679 ±  7%  interrupts.CPU18.RES:Rescheduling_interrupts
    108465 ±  8%     -23.0%      83467 ±  5%  interrupts.CPU18.TLB:TLB_shootdowns
    329294 ±  3%     +15.4%     380131 ±  2%  interrupts.CPU18.TRM:Thermal_event_interrupts
    436.25           +13.8%     496.25        interrupts.CPU19.58:IR-PCI-MSI.1572883-edge.eth0-TxRx-19
     92059 ±  6%     -24.2%      69776 ±  5%  interrupts.CPU19.CAL:Function_call_interrupts
   1784665           +12.2%    2001579        interrupts.CPU19.LOC:Local_timer_interrupts
   1284622 ±  7%    +225.8%    4185208 ±  4%  interrupts.CPU19.RES:Rescheduling_interrupts
    108492 ±  7%     -23.4%      83059 ±  4%  interrupts.CPU19.TLB:TLB_shootdowns
    329166 ±  3%     +15.5%     380141 ±  2%  interrupts.CPU19.TRM:Thermal_event_interrupts
   1784512           +12.4%    2005572        interrupts.CPU2.LOC:Local_timer_interrupts
   3091132 ±  8%     -22.3%    2401342 ±  4%  interrupts.CPU2.RES:Rescheduling_interrupts
    102562 ±  9%     -16.5%      85643 ±  5%  interrupts.CPU2.TLB:TLB_shootdowns
    388380 ± 12%     +27.8%     496544 ±  4%  interrupts.CPU2.TRM:Thermal_event_interrupts
    436.25           +14.3%     498.50        interrupts.CPU20.59:IR-PCI-MSI.1572884-edge.eth0-TxRx-20
     91785 ±  9%     -23.9%      69853 ±  4%  interrupts.CPU20.CAL:Function_call_interrupts
   1785284           +12.1%    2001952        interrupts.CPU20.LOC:Local_timer_interrupts
   1281621 ± 12%    +203.6%    3890516 ±  7%  interrupts.CPU20.RES:Rescheduling_interrupts
    106297 ±  9%     -19.9%      85180 ±  3%  interrupts.CPU20.TLB:TLB_shootdowns
    329293 ±  3%     +15.4%     380131 ±  2%  interrupts.CPU20.TRM:Thermal_event_interrupts
    437.00           +12.2%     490.50        interrupts.CPU21.60:IR-PCI-MSI.1572885-edge.eth0-TxRx-21
     92635 ±  7%     -23.9%      70512 ±  6%  interrupts.CPU21.CAL:Function_call_interrupts
   1785480           +12.1%    2001723        interrupts.CPU21.LOC:Local_timer_interrupts
   1595447 ±  6%    +187.8%    4591004        interrupts.CPU21.RES:Rescheduling_interrupts
    107575 ±  7%     -21.6%      84296 ±  5%  interrupts.CPU21.TLB:TLB_shootdowns
    329296 ±  3%     +15.4%     380086 ±  2%  interrupts.CPU21.TRM:Thermal_event_interrupts
    436.25           +12.4%     490.50        interrupts.CPU22.61:IR-PCI-MSI.1572886-edge.eth0-TxRx-22
     92674 ± 10%     -24.4%      70047 ±  6%  interrupts.CPU22.CAL:Function_call_interrupts
   1784881           +12.1%    2001482        interrupts.CPU22.LOC:Local_timer_interrupts
   1605143 ±  6%    +179.5%    4486945 ±  5%  interrupts.CPU22.RES:Rescheduling_interrupts
    108749 ± 10%     -23.3%      83409 ±  5%  interrupts.CPU22.TLB:TLB_shootdowns
    329295 ±  3%     +15.4%     380136 ±  2%  interrupts.CPU22.TRM:Thermal_event_interrupts
    436.25           +12.4%     490.50        interrupts.CPU23.62:IR-PCI-MSI.1572887-edge.eth0-TxRx-23
     90975 ± 11%     -23.6%      69492 ±  5%  interrupts.CPU23.CAL:Function_call_interrupts
   1785236           +12.1%    2001811        interrupts.CPU23.LOC:Local_timer_interrupts
   1600988 ±  2%    +180.2%    4486667 ±  5%  interrupts.CPU23.RES:Rescheduling_interrupts
    106819 ± 10%     -22.3%      83007 ±  4%  interrupts.CPU23.TLB:TLB_shootdowns
    329296 ±  3%     +15.4%     380146 ±  2%  interrupts.CPU23.TRM:Thermal_event_interrupts
    441.00           +11.8%     493.00        interrupts.CPU24.63:IR-PCI-MSI.1572888-edge.eth0-TxRx-24
     91919 ± 11%     -23.1%      70689 ±  5%  interrupts.CPU24.CAL:Function_call_interrupts
   1784996           +12.1%    2000922        interrupts.CPU24.LOC:Local_timer_interrupts
   1612237 ±  5%    +188.4%    4649702 ±  2%  interrupts.CPU24.RES:Rescheduling_interrupts
    108187 ±  8%     -22.5%      83831 ±  3%  interrupts.CPU24.TLB:TLB_shootdowns
    329296 ±  3%     +15.4%     380122 ±  2%  interrupts.CPU24.TRM:Thermal_event_interrupts
    437.25           +13.3%     495.25        interrupts.CPU25.64:IR-PCI-MSI.1572889-edge.eth0-TxRx-25
     88417 ± 12%     -20.8%      70029 ±  4%  interrupts.CPU25.CAL:Function_call_interrupts
   1785404           +12.0%    1999622        interrupts.CPU25.LOC:Local_timer_interrupts
   1612074 ±  2%    +182.4%    4551699        interrupts.CPU25.RES:Rescheduling_interrupts
    105324 ± 10%     -20.1%      84201 ±  4%  interrupts.CPU25.TLB:TLB_shootdowns
    329296 ±  3%     +15.4%     380141 ±  2%  interrupts.CPU25.TRM:Thermal_event_interrupts
    436.25           +12.4%     490.50        interrupts.CPU26.65:IR-PCI-MSI.1572890-edge.eth0-TxRx-26
     92632 ± 12%     -23.5%      70907 ±  5%  interrupts.CPU26.CAL:Function_call_interrupts
   1784730           +12.1%    2000264        interrupts.CPU26.LOC:Local_timer_interrupts
   1639148 ±  6%    +188.0%    4720149 ±  4%  interrupts.CPU26.RES:Rescheduling_interrupts
    108099 ± 11%     -21.6%      84727 ±  4%  interrupts.CPU26.TLB:TLB_shootdowns
    329271 ±  3%     +15.4%     379984 ±  2%  interrupts.CPU26.TRM:Thermal_event_interrupts
     91312 ± 12%     -23.4%      69963 ±  6%  interrupts.CPU27.CAL:Function_call_interrupts
   1785171           +12.1%    2001743        interrupts.CPU27.LOC:Local_timer_interrupts
   1704847 ± 11%    +179.4%    4764019 ±  4%  interrupts.CPU27.RES:Rescheduling_interrupts
    106515 ± 11%     -21.6%      83491 ±  5%  interrupts.CPU27.TLB:TLB_shootdowns
    329296 ±  3%     +15.4%     380080 ±  2%  interrupts.CPU27.TRM:Thermal_event_interrupts
     89178 ±  8%     -22.0%      69565 ±  6%  interrupts.CPU28.CAL:Function_call_interrupts
   1785194           +12.1%    2001836        interrupts.CPU28.LOC:Local_timer_interrupts
   1593025 ±  8%    +185.7%    4551782 ±  5%  interrupts.CPU28.RES:Rescheduling_interrupts
    104408 ± 10%     -19.2%      84365 ±  6%  interrupts.CPU28.TLB:TLB_shootdowns
    329294 ±  3%     +15.4%     380142 ±  2%  interrupts.CPU28.TRM:Thermal_event_interrupts
    436.25           +12.4%     490.50        interrupts.CPU29.68:IR-PCI-MSI.1572893-edge.eth0-TxRx-29
     90850 ± 12%     -21.9%      70993 ±  6%  interrupts.CPU29.CAL:Function_call_interrupts
   1785398           +12.1%    2000545        interrupts.CPU29.LOC:Local_timer_interrupts
   1657508 ±  5%    +179.4%    4631109 ±  3%  interrupts.CPU29.RES:Rescheduling_interrupts
    106383 ± 13%     -20.8%      84284 ±  4%  interrupts.CPU29.TLB:TLB_shootdowns
    329296 ±  3%     +15.4%     380133 ±  2%  interrupts.CPU29.TRM:Thermal_event_interrupts
    509.75 ±  3%    +545.1%       3288 ±120%  interrupts.CPU3.42:IR-PCI-MSI.1572867-edge.eth0-TxRx-3
     87008 ± 11%     -19.9%      69730 ±  5%  interrupts.CPU3.CAL:Function_call_interrupts
   1784446           +12.4%    2005368        interrupts.CPU3.LOC:Local_timer_interrupts
   3169674 ±  9%     -20.4%    2521963 ±  8%  interrupts.CPU3.RES:Rescheduling_interrupts
    103703 ± 12%     -17.1%      85958 ±  7%  interrupts.CPU3.TLB:TLB_shootdowns
    388356 ± 12%     +27.9%     496551 ±  4%  interrupts.CPU3.TRM:Thermal_event_interrupts
    436.25           +12.4%     490.50        interrupts.CPU30.69:IR-PCI-MSI.1572894-edge.eth0-TxRx-30
     92043 ± 12%     -24.2%      69765 ±  5%  interrupts.CPU30.CAL:Function_call_interrupts
   1785175           +12.1%    2001248        interrupts.CPU30.LOC:Local_timer_interrupts
   1637465 ±  6%    +191.3%    4769701 ±  3%  interrupts.CPU30.RES:Rescheduling_interrupts
    106836 ± 11%     -22.5%      82810 ±  5%  interrupts.CPU30.TLB:TLB_shootdowns
    329296 ±  3%     +15.4%     380130 ±  2%  interrupts.CPU30.TRM:Thermal_event_interrupts
   1785301           +12.0%    1999270        interrupts.CPU31.LOC:Local_timer_interrupts
     62.75 ±173%   +4261.4%       2736 ±113%  interrupts.CPU31.NMI:Non-maskable_interrupts
     62.75 ±173%   +4261.4%       2736 ±113%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
   1589500 ±  5%    +184.1%    4515325        interrupts.CPU31.RES:Rescheduling_interrupts
    106576 ± 11%     -21.5%      83698 ±  5%  interrupts.CPU31.TLB:TLB_shootdowns
    329293 ±  3%     +15.4%     380131 ±  2%  interrupts.CPU31.TRM:Thermal_event_interrupts
    436.25           +12.4%     490.50        interrupts.CPU32.71:IR-PCI-MSI.1572896-edge.eth0-TxRx-32
     93348 ± 12%     -24.4%      70595 ±  8%  interrupts.CPU32.CAL:Function_call_interrupts
   1785245           +12.1%    2001145        interrupts.CPU32.LOC:Local_timer_interrupts
   1626883 ±  6%    +176.3%    4494456 ±  5%  interrupts.CPU32.RES:Rescheduling_interrupts
    107151 ± 12%     -21.4%      84236 ±  5%  interrupts.CPU32.TLB:TLB_shootdowns
    329296 ±  3%     +15.4%     380131 ±  2%  interrupts.CPU32.TRM:Thermal_event_interrupts
    437.25 ±  2%     +12.2%     490.50        interrupts.CPU33.74:IR-PCI-MSI.1572897-edge.eth0-TxRx-33
     91487 ± 12%     -22.7%      70758 ±  3%  interrupts.CPU33.CAL:Function_call_interrupts
   1785371           +12.0%    1999987        interrupts.CPU33.LOC:Local_timer_interrupts
   1578761 ±  6%    +201.2%    4754762 ±  6%  interrupts.CPU33.RES:Rescheduling_interrupts
    106071 ± 12%     -21.3%      83430 ±  2%  interrupts.CPU33.TLB:TLB_shootdowns
    329296 ±  3%     +15.4%     380130 ±  2%  interrupts.CPU33.TRM:Thermal_event_interrupts
    436.25           +12.6%     491.25        interrupts.CPU34.75:IR-PCI-MSI.1572898-edge.eth0-TxRx-34
     91116 ± 11%     -24.3%      68943 ±  7%  interrupts.CPU34.CAL:Function_call_interrupts
   1785353           +12.1%    2001525        interrupts.CPU34.LOC:Local_timer_interrupts
   1553828 ±  4%    +186.0%    4444035 ±  3%  interrupts.CPU34.RES:Rescheduling_interrupts
    105575 ± 10%     -20.7%      83762 ±  4%  interrupts.CPU34.TLB:TLB_shootdowns
    329296 ±  3%     +15.4%     380139 ±  2%  interrupts.CPU34.TRM:Thermal_event_interrupts
    440.75           +12.4%     495.25 ±  2%  interrupts.CPU35.76:IR-PCI-MSI.1572899-edge.eth0-TxRx-35
     91396 ± 11%     -25.6%      67986 ± 11%  interrupts.CPU35.CAL:Function_call_interrupts
   1785237           +12.0%    2000288        interrupts.CPU35.LOC:Local_timer_interrupts
   1602616 ± 10%    +189.7%    4642115 ±  3%  interrupts.CPU35.RES:Rescheduling_interrupts
    107669 ± 12%     -21.3%      84736 ±  4%  interrupts.CPU35.TLB:TLB_shootdowns
    329296 ±  3%     +15.4%     380145 ±  2%  interrupts.CPU35.TRM:Thermal_event_interrupts
    436.25           +12.6%     491.00        interrupts.CPU36.77:IR-PCI-MSI.1572900-edge.eth0-TxRx-36
     93553 ±  8%     -19.8%      75044 ±  6%  interrupts.CPU36.CAL:Function_call_interrupts
   1784636           +12.4%    2005389        interrupts.CPU36.LOC:Local_timer_interrupts
   2588984 ±  6%     +25.8%    3256348 ±  6%  interrupts.CPU36.RES:Rescheduling_interrupts
    107053 ±  7%     -19.0%      86754 ±  5%  interrupts.CPU36.TLB:TLB_shootdowns
    388423 ± 12%     +27.8%     496560 ±  4%  interrupts.CPU36.TRM:Thermal_event_interrupts
    436.75           +13.1%     493.75        interrupts.CPU37.78:IR-PCI-MSI.1572901-edge.eth0-TxRx-37
     89518 ± 10%     -18.9%      72619 ±  5%  interrupts.CPU37.CAL:Function_call_interrupts
   1784648           +12.4%    2005651        interrupts.CPU37.LOC:Local_timer_interrupts
   3112476 ± 10%     -20.8%    2464103 ±  5%  interrupts.CPU37.RES:Rescheduling_interrupts
    102576 ± 10%     -14.4%      87794 ±  6%  interrupts.CPU37.TLB:TLB_shootdowns
    388412 ± 12%     +27.8%     496563 ±  4%  interrupts.CPU37.TRM:Thermal_event_interrupts
    436.25           +12.8%     492.25        interrupts.CPU38.79:IR-PCI-MSI.1572902-edge.eth0-TxRx-38
     92566 ± 10%     -20.6%      73466 ±  6%  interrupts.CPU38.CAL:Function_call_interrupts
   1785132           +12.4%    2005883        interrupts.CPU38.LOC:Local_timer_interrupts
   3163520 ± 10%     -26.0%    2340820 ± 11%  interrupts.CPU38.RES:Rescheduling_interrupts
    105823 ± 10%     -18.0%      86785 ±  4%  interrupts.CPU38.TLB:TLB_shootdowns
    388401 ± 12%     +27.8%     496554 ±  4%  interrupts.CPU38.TRM:Thermal_event_interrupts
    436.25           +12.8%     492.25        interrupts.CPU39.80:IR-PCI-MSI.1572903-edge.eth0-TxRx-39
     93197 ± 11%     -21.8%      72854 ±  7%  interrupts.CPU39.CAL:Function_call_interrupts
   1784624           +12.4%    2005934        interrupts.CPU39.LOC:Local_timer_interrupts
    105953 ± 11%     -20.8%      83925 ±  6%  interrupts.CPU39.TLB:TLB_shootdowns
    388418 ± 12%     +27.8%     496548 ±  4%  interrupts.CPU39.TRM:Thermal_event_interrupts
     86883 ± 13%     -17.8%      71449 ±  7%  interrupts.CPU4.CAL:Function_call_interrupts
   1784433           +12.4%    2005462        interrupts.CPU4.LOC:Local_timer_interrupts
   3119739 ±  9%     -21.1%    2461192 ±  4%  interrupts.CPU4.RES:Rescheduling_interrupts
    104829 ± 11%     -19.1%      84802 ±  5%  interrupts.CPU4.TLB:TLB_shootdowns
    388417 ± 12%     +27.8%     496563 ±  4%  interrupts.CPU4.TRM:Thermal_event_interrupts
    436.25           +12.4%     490.50        interrupts.CPU40.81:IR-PCI-MSI.1572904-edge.eth0-TxRx-40
     91881 ± 12%     -21.4%      72188 ±  8%  interrupts.CPU40.CAL:Function_call_interrupts
   1784831           +12.4%    2005991        interrupts.CPU40.LOC:Local_timer_interrupts
   3101288 ± 10%     -17.2%    2569221 ±  7%  interrupts.CPU40.RES:Rescheduling_interrupts
    105884 ± 10%     -19.0%      85772 ±  5%  interrupts.CPU40.TLB:TLB_shootdowns
    388415 ± 12%     +27.8%     496564 ±  4%  interrupts.CPU40.TRM:Thermal_event_interrupts
    436.25           +12.4%     490.50        interrupts.CPU41.82:IR-PCI-MSI.1572905-edge.eth0-TxRx-41
     91739 ± 12%     -19.9%      73475 ±  7%  interrupts.CPU41.CAL:Function_call_interrupts
   1785231           +12.3%    2005398        interrupts.CPU41.LOC:Local_timer_interrupts
   3223405 ± 11%     -27.9%    2325498 ±  5%  interrupts.CPU41.RES:Rescheduling_interrupts
    104410 ± 11%     -18.7%      84846 ±  6%  interrupts.CPU41.TLB:TLB_shootdowns
    388408 ± 12%     +27.8%     496557 ±  4%  interrupts.CPU41.TRM:Thermal_event_interrupts
    436.25           +12.4%     490.50        interrupts.CPU42.83:IR-PCI-MSI.1572906-edge.eth0-TxRx-42
   1785354           +12.4%    2006034        interrupts.CPU42.LOC:Local_timer_interrupts
   3068304 ±  9%     -22.1%    2390347 ±  6%  interrupts.CPU42.RES:Rescheduling_interrupts
    107102 ±  9%     -20.7%      84890 ±  4%  interrupts.CPU42.TLB:TLB_shootdowns
    388423 ± 12%     +27.8%     496564 ±  4%  interrupts.CPU42.TRM:Thermal_event_interrupts
    436.25           +14.6%     499.75 ±  2%  interrupts.CPU43.84:IR-PCI-MSI.1572907-edge.eth0-TxRx-43
     92178 ±  9%     -18.3%      75306 ±  7%  interrupts.CPU43.CAL:Function_call_interrupts
   1784759           +12.4%    2005986        interrupts.CPU43.LOC:Local_timer_interrupts
      6434 ±  7%     -64.3%       2297 ±106%  interrupts.CPU43.NMI:Non-maskable_interrupts
      6434 ±  7%     -64.3%       2297 ±106%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
    104773 ±  9%     -17.6%      86369 ±  6%  interrupts.CPU43.TLB:TLB_shootdowns
    388425 ± 12%     +27.8%     496556 ±  4%  interrupts.CPU43.TRM:Thermal_event_interrupts
    436.25           +12.4%     490.50        interrupts.CPU44.85:IR-PCI-MSI.1572908-edge.eth0-TxRx-44
     92387 ± 10%     -21.9%      72174 ±  9%  interrupts.CPU44.CAL:Function_call_interrupts
   1784603           +12.4%    2006064        interrupts.CPU44.LOC:Local_timer_interrupts
    106179 ±  9%     -18.6%      86461 ±  6%  interrupts.CPU44.TLB:TLB_shootdowns
    388426 ± 12%     +27.8%     496562 ±  4%  interrupts.CPU44.TRM:Thermal_event_interrupts
    436.50           +12.4%     490.50        interrupts.CPU45.86:IR-PCI-MSI.1572909-edge.eth0-TxRx-45
     93641 ±  7%     -21.9%      73155 ±  6%  interrupts.CPU45.CAL:Function_call_interrupts
   1784811           +12.4%    2005654        interrupts.CPU45.LOC:Local_timer_interrupts
   3093195 ± 11%     -15.6%    2609354 ±  4%  interrupts.CPU45.RES:Rescheduling_interrupts
    106463 ±  7%     -19.6%      85593 ±  5%  interrupts.CPU45.TLB:TLB_shootdowns
    388408 ± 12%     +27.8%     496564 ±  4%  interrupts.CPU45.TRM:Thermal_event_interrupts
    436.25           +12.4%     490.50        interrupts.CPU46.87:IR-PCI-MSI.1572910-edge.eth0-TxRx-46
     91739 ± 10%     -19.0%      74279 ±  8%  interrupts.CPU46.CAL:Function_call_interrupts
   1784609           +12.4%    2005522        interrupts.CPU46.LOC:Local_timer_interrupts
   2970471 ±  9%     -21.0%    2345439 ±  8%  interrupts.CPU46.RES:Rescheduling_interrupts
    108158 ± 10%     -19.8%      86743 ±  4%  interrupts.CPU46.TLB:TLB_shootdowns
    388368 ± 12%     +27.8%     496469 ±  4%  interrupts.CPU46.TRM:Thermal_event_interrupts
    436.25           +12.4%     490.50        interrupts.CPU47.88:IR-PCI-MSI.1572911-edge.eth0-TxRx-47
     92856 ±  9%     -20.0%      74327 ±  8%  interrupts.CPU47.CAL:Function_call_interrupts
   1784835           +12.4%    2005700        interrupts.CPU47.LOC:Local_timer_interrupts
   3116242 ± 10%     -20.4%    2480398 ±  5%  interrupts.CPU47.RES:Rescheduling_interrupts
    104927 ±  9%     -18.6%      85393 ±  6%  interrupts.CPU47.TLB:TLB_shootdowns
    388403 ± 12%     +27.8%     496554 ±  4%  interrupts.CPU47.TRM:Thermal_event_interrupts
    436.25           +12.6%     491.00        interrupts.CPU48.89:IR-PCI-MSI.1572912-edge.eth0-TxRx-48
     92889 ± 11%     -21.5%      72890 ±  8%  interrupts.CPU48.CAL:Function_call_interrupts
   1784772           +12.4%    2006205        interrupts.CPU48.LOC:Local_timer_interrupts
   3175210 ± 12%     -19.7%    2548339 ± 13%  interrupts.CPU48.RES:Rescheduling_interrupts
    105183 ± 11%     -18.6%      85618 ±  6%  interrupts.CPU48.TLB:TLB_shootdowns
    388426 ± 12%     +27.8%     496563 ±  4%  interrupts.CPU48.TRM:Thermal_event_interrupts
    441.25 ±  3%     +14.1%     503.25 ±  3%  interrupts.CPU49.90:IR-PCI-MSI.1572913-edge.eth0-TxRx-49
     90134 ± 10%     -18.3%      73603 ±  6%  interrupts.CPU49.CAL:Function_call_interrupts
   1785145           +12.4%    2005932        interrupts.CPU49.LOC:Local_timer_interrupts
   3185609 ± 11%     -17.6%    2626502 ±  4%  interrupts.CPU49.RES:Rescheduling_interrupts
    102737 ± 10%     -17.3%      84932 ±  5%  interrupts.CPU49.TLB:TLB_shootdowns
    388425 ± 12%     +27.8%     496560 ±  4%  interrupts.CPU49.TRM:Thermal_event_interrupts
     92114 ±  9%     -23.2%      70721 ±  6%  interrupts.CPU5.CAL:Function_call_interrupts
   1785135           +12.3%    2005424        interrupts.CPU5.LOC:Local_timer_interrupts
   3210646 ± 12%     -24.8%    2415935 ±  4%  interrupts.CPU5.RES:Rescheduling_interrupts
    107349 ±  9%     -18.9%      87034 ±  6%  interrupts.CPU5.TLB:TLB_shootdowns
    388418 ± 12%     +27.8%     496564 ±  4%  interrupts.CPU5.TRM:Thermal_event_interrupts
    436.25           +12.4%     490.50        interrupts.CPU50.91:IR-PCI-MSI.1572914-edge.eth0-TxRx-50
     92406 ± 10%     -20.2%      73771 ±  8%  interrupts.CPU50.CAL:Function_call_interrupts
   1785200           +12.4%    2006488        interrupts.CPU50.LOC:Local_timer_interrupts
    106635 ±  9%     -19.9%      85431 ±  6%  interrupts.CPU50.TLB:TLB_shootdowns
    388419 ± 12%     +27.8%     496564 ±  4%  interrupts.CPU50.TRM:Thermal_event_interrupts
    436.25           +14.4%     499.25 ±  3%  interrupts.CPU51.92:IR-PCI-MSI.1572915-edge.eth0-TxRx-51
     91491 ±  9%     -20.8%      72473 ±  6%  interrupts.CPU51.CAL:Function_call_interrupts
   1784683           +12.4%    2005527        interrupts.CPU51.LOC:Local_timer_interrupts
   3051494 ±  8%     -24.6%    2300032 ± 10%  interrupts.CPU51.RES:Rescheduling_interrupts
    104954 ± 10%     -20.2%      83775 ±  5%  interrupts.CPU51.TLB:TLB_shootdowns
    388264 ± 12%     +27.9%     496462 ±  4%  interrupts.CPU51.TRM:Thermal_event_interrupts
     92938 ± 11%     -19.7%      74594 ±  7%  interrupts.CPU52.CAL:Function_call_interrupts
   1785451           +12.4%    2006171        interrupts.CPU52.LOC:Local_timer_interrupts
   3025681 ± 11%     -17.1%    2506800 ± 10%  interrupts.CPU52.RES:Rescheduling_interrupts
    107100 ± 11%     -19.6%      86156 ±  6%  interrupts.CPU52.TLB:TLB_shootdowns
    388422 ± 12%     +27.8%     496563 ±  4%  interrupts.CPU52.TRM:Thermal_event_interrupts
    439.25 ±  2%     +11.7%     490.50        interrupts.CPU53.94:IR-PCI-MSI.1572917-edge.eth0-TxRx-53
     93000 ± 12%     -20.9%      73549 ±  7%  interrupts.CPU53.CAL:Function_call_interrupts
   1785290           +12.3%    2005441        interrupts.CPU53.LOC:Local_timer_interrupts
   3212623 ±  7%     -18.2%    2629478 ± 10%  interrupts.CPU53.RES:Rescheduling_interrupts
    107303 ± 11%     -17.5%      88567 ± 10%  interrupts.CPU53.TLB:TLB_shootdowns
    388411 ± 12%     +27.8%     496557 ±  4%  interrupts.CPU53.TRM:Thermal_event_interrupts
    437.75           +12.1%     490.50        interrupts.CPU54.95:IR-PCI-MSI.1572918-edge.eth0-TxRx-54
   1785170           +12.0%    2000090        interrupts.CPU54.LOC:Local_timer_interrupts
      5351 ± 26%     -64.5%       1900 ± 99%  interrupts.CPU54.NMI:Non-maskable_interrupts
      5351 ± 26%     -64.5%       1900 ± 99%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
   2066106 ±  9%     +92.7%    3982033 ±  6%  interrupts.CPU54.RES:Rescheduling_interrupts
    108150 ± 12%     -21.2%      85173 ±  5%  interrupts.CPU54.TLB:TLB_shootdowns
    329294 ±  3%     +15.4%     380146 ±  2%  interrupts.CPU54.TRM:Thermal_event_interrupts
    436.50           +12.4%     490.50        interrupts.CPU55.96:IR-PCI-MSI.1572919-edge.eth0-TxRx-55
     91164 ± 12%     -19.9%      73014 ±  6%  interrupts.CPU55.CAL:Function_call_interrupts
   1785472           +12.0%    1999115        interrupts.CPU55.LOC:Local_timer_interrupts
   1286654 ±  6%    +228.2%    4223034 ±  5%  interrupts.CPU55.RES:Rescheduling_interrupts
    104943 ± 11%     -19.5%      84466 ±  5%  interrupts.CPU55.TLB:TLB_shootdowns
    329292 ±  3%     +15.4%     379918 ±  2%  interrupts.CPU55.TRM:Thermal_event_interrupts
    436.25           +12.4%     490.50        interrupts.CPU56.97:IR-PCI-MSI.1572920-edge.eth0-TxRx-56
     96934 ± 13%     -23.4%      74215 ±  6%  interrupts.CPU56.CAL:Function_call_interrupts
   1785010           +12.1%    2000169        interrupts.CPU56.LOC:Local_timer_interrupts
   1312758 ± 17%    +194.5%    3866522 ±  3%  interrupts.CPU56.RES:Rescheduling_interrupts
    109307 ± 12%     -22.1%      85139 ±  4%  interrupts.CPU56.TLB:TLB_shootdowns
    329273 ±  3%     +15.4%     380131 ±  2%  interrupts.CPU56.TRM:Thermal_event_interrupts
    439.00 ±  2%     +11.7%     490.50        interrupts.CPU57.98:IR-PCI-MSI.1572921-edge.eth0-TxRx-57
     94960 ± 11%     -22.9%      73246 ±  5%  interrupts.CPU57.CAL:Function_call_interrupts
   1785297           +12.0%    2000019        interrupts.CPU57.LOC:Local_timer_interrupts
   1666475 ± 10%    +169.6%    4492937        interrupts.CPU57.RES:Rescheduling_interrupts
    107534 ± 10%     -22.0%      83871 ±  5%  interrupts.CPU57.TLB:TLB_shootdowns
    329296 ±  3%     +15.4%     380136 ±  2%  interrupts.CPU57.TRM:Thermal_event_interrupts
    442.25 ±  3%     +10.9%     490.50        interrupts.CPU58.99:IR-PCI-MSI.1572922-edge.eth0-TxRx-58
     92818 ± 12%     -21.4%      72925 ±  5%  interrupts.CPU58.CAL:Function_call_interrupts
   1785429           +12.0%    1999528        interrupts.CPU58.LOC:Local_timer_interrupts
   1606064 ±  5%    +176.8%    4446179 ±  6%  interrupts.CPU58.RES:Rescheduling_interrupts
    103696 ± 11%     -19.5%      83458 ±  4%  interrupts.CPU58.TLB:TLB_shootdowns
    329293 ±  3%     +15.4%     380022 ±  2%  interrupts.CPU58.TRM:Thermal_event_interrupts
    439.00           +11.7%     490.50        interrupts.CPU59.100:IR-PCI-MSI.1572923-edge.eth0-TxRx-59
     93876 ± 13%     -20.5%      74669 ±  6%  interrupts.CPU59.CAL:Function_call_interrupts
   1785085           +12.0%    1999992        interrupts.CPU59.LOC:Local_timer_interrupts
   1634812 ±  5%    +174.5%    4487501 ±  4%  interrupts.CPU59.RES:Rescheduling_interrupts
    106929 ± 13%     -21.0%      84522 ±  5%  interrupts.CPU59.TLB:TLB_shootdowns
    329291 ±  3%     +15.4%     380111 ±  2%  interrupts.CPU59.TRM:Thermal_event_interrupts
     89930 ±  9%     -20.5%      71520 ±  7%  interrupts.CPU6.CAL:Function_call_interrupts
   1785220           +12.3%    2005468        interrupts.CPU6.LOC:Local_timer_interrupts
    106307 ±  7%     -19.9%      85162 ±  6%  interrupts.CPU6.TLB:TLB_shootdowns
    388421 ± 12%     +27.8%     496564 ±  4%  interrupts.CPU6.TRM:Thermal_event_interrupts
    436.25           +13.1%     493.25        interrupts.CPU60.101:IR-PCI-MSI.1572924-edge.eth0-TxRx-60
     98595 ± 11%     -25.6%      73379 ±  5%  interrupts.CPU60.CAL:Function_call_interrupts
   1785116           +12.1%    2000324        interrupts.CPU60.LOC:Local_timer_interrupts
   1604314 ±  8%    +186.8%    4601614 ±  5%  interrupts.CPU60.RES:Rescheduling_interrupts
    110442 ± 10%     -24.0%      83932 ±  5%  interrupts.CPU60.TLB:TLB_shootdowns
    329256 ±  3%     +15.5%     380140 ±  2%  interrupts.CPU60.TRM:Thermal_event_interrupts
    436.25           +12.4%     490.50        interrupts.CPU61.102:IR-PCI-MSI.1572925-edge.eth0-TxRx-61
     93035 ± 11%     -21.4%      73124 ±  5%  interrupts.CPU61.CAL:Function_call_interrupts
   1785176           +12.1%    2000960        interrupts.CPU61.LOC:Local_timer_interrupts
      4567 ± 67%     -79.2%     952.00 ±171%  interrupts.CPU61.NMI:Non-maskable_interrupts
      4567 ± 67%     -79.2%     952.00 ±171%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
   1575186 ±  6%    +194.9%    4644760 ±  4%  interrupts.CPU61.RES:Rescheduling_interrupts
    103665 ± 11%     -18.7%      84259 ±  5%  interrupts.CPU61.TLB:TLB_shootdowns
    329296 ±  3%     +15.4%     380127 ±  2%  interrupts.CPU61.TRM:Thermal_event_interrupts
    436.25           +12.4%     490.50        interrupts.CPU62.103:IR-PCI-MSI.1572926-edge.eth0-TxRx-62
     95188 ± 10%     -21.9%      74376 ±  6%  interrupts.CPU62.CAL:Function_call_interrupts
   1785028           +12.0%    1999262        interrupts.CPU62.LOC:Local_timer_interrupts
   1613834 ±  8%    +184.7%    4594499 ±  3%  interrupts.CPU62.RES:Rescheduling_interrupts
    106856 ± 10%     -21.4%      83987 ±  5%  interrupts.CPU62.TLB:TLB_shootdowns
    329270 ±  3%     +15.4%     380120 ±  2%  interrupts.CPU62.TRM:Thermal_event_interrupts
     94411 ± 11%     -21.3%      74269 ±  5%  interrupts.CPU63.CAL:Function_call_interrupts
   1785322           +12.0%    1999237        interrupts.CPU63.LOC:Local_timer_interrupts
   1669218 ±  6%    +187.2%    4794684 ±  3%  interrupts.CPU63.RES:Rescheduling_interrupts
    105402 ± 10%     -18.3%      86076 ±  8%  interrupts.CPU63.TLB:TLB_shootdowns
    329296 ±  3%     +15.4%     380141 ±  2%  interrupts.CPU63.TRM:Thermal_event_interrupts
     96060 ± 11%     -22.6%      74364 ±  6%  interrupts.CPU64.CAL:Function_call_interrupts
   1785304           +12.0%    1999571        interrupts.CPU64.LOC:Local_timer_interrupts
   1681501 ±  7%    +164.0%    4438647 ±  3%  interrupts.CPU64.RES:Rescheduling_interrupts
    108534 ± 10%     -22.8%      83813 ±  5%  interrupts.CPU64.TLB:TLB_shootdowns
    329296 ±  3%     +15.4%     380142 ±  2%  interrupts.CPU64.TRM:Thermal_event_interrupts
     94178 ±  9%     -22.7%      72758 ±  8%  interrupts.CPU65.CAL:Function_call_interrupts
   1785338           +12.0%    1999408        interrupts.CPU65.LOC:Local_timer_interrupts
   1674108 ±  4%    +182.2%    4724262 ±  3%  interrupts.CPU65.RES:Rescheduling_interrupts
    107519 ± 10%     -22.6%      83259 ±  5%  interrupts.CPU65.TLB:TLB_shootdowns
    329296 ±  3%     +15.4%     380128 ±  2%  interrupts.CPU65.TRM:Thermal_event_interrupts
     95135 ±  8%     -22.4%      73795 ±  5%  interrupts.CPU66.CAL:Function_call_interrupts
   1785413           +12.0%    2000352        interrupts.CPU66.LOC:Local_timer_interrupts
    616.75 ±171%    +902.4%       6182 ± 28%  interrupts.CPU66.NMI:Non-maskable_interrupts
    616.75 ±171%    +902.4%       6182 ± 28%  interrupts.CPU66.PMI:Performance_monitoring_interrupts
   1646166 ±  6%    +169.3%    4433267 ±  6%  interrupts.CPU66.RES:Rescheduling_interrupts
    107190 ±  7%     -22.5%      83034 ±  4%  interrupts.CPU66.TLB:TLB_shootdowns
    329296 ±  3%     +15.4%     380118 ±  2%  interrupts.CPU66.TRM:Thermal_event_interrupts
     95627 ± 10%     -22.4%      74249 ±  5%  interrupts.CPU67.CAL:Function_call_interrupts
   1785314           +12.1%    2001128        interrupts.CPU67.LOC:Local_timer_interrupts
   1611146 ±  4%    +183.8%    4572204 ±  7%  interrupts.CPU67.RES:Rescheduling_interrupts
    109283 ± 11%     -22.5%      84676 ±  4%  interrupts.CPU67.TLB:TLB_shootdowns
    329296 ±  3%     +15.4%     380142 ±  2%  interrupts.CPU67.TRM:Thermal_event_interrupts
     95479 ± 11%     -20.6%      75791 ±  5%  interrupts.CPU68.CAL:Function_call_interrupts
   1785192           +12.0%    1999411        interrupts.CPU68.LOC:Local_timer_interrupts
   1575394 ±  7%    +189.9%    4567277 ±  4%  interrupts.CPU68.RES:Rescheduling_interrupts
    106972 ± 12%     -18.6%      87039 ±  5%  interrupts.CPU68.TLB:TLB_shootdowns
    329296 ±  3%     +15.4%     380129 ±  2%  interrupts.CPU68.TRM:Thermal_event_interrupts
     93067 ± 14%     -19.9%      74538 ±  4%  interrupts.CPU69.CAL:Function_call_interrupts
   1785257           +12.1%    2000636        interrupts.CPU69.LOC:Local_timer_interrupts
   1578663 ±  9%    +192.9%    4624518 ±  3%  interrupts.CPU69.RES:Rescheduling_interrupts
    104271 ± 12%     -18.5%      84989 ±  2%  interrupts.CPU69.TLB:TLB_shootdowns
    329296 ±  3%     +15.4%     380066 ±  2%  interrupts.CPU69.TRM:Thermal_event_interrupts
    474.00 ±  3%     +49.7%     709.75 ± 24%  interrupts.CPU7.46:IR-PCI-MSI.1572871-edge.eth0-TxRx-7
     92062 ±  9%     -19.7%      73884 ±  5%  interrupts.CPU7.CAL:Function_call_interrupts
   1784266           +12.4%    2004980        interrupts.CPU7.LOC:Local_timer_interrupts
   2505703 ± 11%     -19.0%    2029187 ±  5%  interrupts.CPU7.RES:Rescheduling_interrupts
    107698 ±  8%     -18.4%      87903 ±  6%  interrupts.CPU7.TLB:TLB_shootdowns
    388281 ± 12%     +27.8%     496347 ±  4%  interrupts.CPU7.TRM:Thermal_event_interrupts
     92337 ± 12%     -17.5%      76148 ±  2%  interrupts.CPU70.CAL:Function_call_interrupts
   1785161           +12.0%    1999757        interrupts.CPU70.LOC:Local_timer_interrupts
   1562360 ±  4%    +170.8%    4231208 ±  9%  interrupts.CPU70.RES:Rescheduling_interrupts
    103862 ± 10%     -18.8%      84371 ±  3%  interrupts.CPU70.TLB:TLB_shootdowns
    329296 ±  3%     +15.4%     380141 ±  2%  interrupts.CPU70.TRM:Thermal_event_interrupts
     95829 ± 12%     -21.2%      75509 ±  5%  interrupts.CPU71.CAL:Function_call_interrupts
   1784894           +12.1%    2001287        interrupts.CPU71.LOC:Local_timer_interrupts
   1533567 ±  7%    +196.9%    4553440        interrupts.CPU71.RES:Rescheduling_interrupts
    105883 ± 11%     -20.4%      84248 ±  6%  interrupts.CPU71.TLB:TLB_shootdowns
    329247 ±  3%     +15.5%     380146 ±  2%  interrupts.CPU71.TRM:Thermal_event_interrupts
     88372 ± 11%     -20.3%      70389 ±  7%  interrupts.CPU8.CAL:Function_call_interrupts
   1784452           +12.4%    2005305        interrupts.CPU8.LOC:Local_timer_interrupts
    103992 ± 10%     -17.4%      85887 ±  5%  interrupts.CPU8.TLB:TLB_shootdowns
    388422 ± 12%     +27.8%     496557 ±  4%  interrupts.CPU8.TRM:Thermal_event_interrupts
     89290 ± 10%     -19.1%      72221 ±  6%  interrupts.CPU9.CAL:Function_call_interrupts
   1784716           +12.4%    2005710        interrupts.CPU9.LOC:Local_timer_interrupts
    104340 ± 10%     -16.0%      87647 ±  3%  interrupts.CPU9.TLB:TLB_shootdowns
    388408 ± 12%     +27.8%     496557 ±  4%  interrupts.CPU9.TRM:Thermal_event_interrupts
 1.285e+08           +12.2%  1.442e+08        interrupts.LOC:Local_timer_interrupts
    144.00           +50.0%     216.00        interrupts.MCP:Machine_check_polls
 1.677e+08 ±  8%     +50.4%  2.522e+08 ±  2%  interrupts.RES:Rescheduling_interrupts
   7624145 ± 10%     -19.7%    6125835 ±  5%  interrupts.TLB:TLB_shootdowns
  25836833 ±  8%     +22.2%   31559779 ±  2%  interrupts.TRM:Thermal_event_interrupts



***************************************************************************************************
lkp-bdw-ep6: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory
=========================================================================================
compiler/cpufreq_governor/ipc/kconfig/mode/nr_threads/rootfs/tbox_group/testcase/ucode:
  gcc-7/performance/pipe/x86_64-rhel-7.6/process/50%/debian-x86_64-2019-11-14.cgz/lkp-bdw-ep6/hackbench/0xb000038

commit: 
  43e9f7f231 ("sched/fair: Start tracking SCHED_IDLE tasks count in cfs_rq")
  3c29e651e1 ("sched/fair: Fall back to sched-idle CPU if idle CPU isn't found")

43e9f7f231e40e45 3c29e651e16dd3b3179cfb2d055 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          1:4          -25%            :4     dmesg.WARNING:at#for_ip_interrupt_entry/0x
         %stddev     %change         %stddev
             \          |                \  
    134091           -10.6%     119937        hackbench.throughput
 3.352e+09 ±  2%     +16.1%  3.892e+09 ±  5%  hackbench.time.involuntary_context_switches
    535571 ±  2%     +10.6%     592420 ±  4%  numa-meminfo.node0.FilePages
     12614 ± 18%     -12.2%      11078 ± 18%  numa-meminfo.node1.Mapped
      3472 ±  6%     +18.0%       4096        slabinfo.skbuff_head_cache.active_objs
      3568 ±  6%     +15.7%       4128        slabinfo.skbuff_head_cache.num_objs
    730128 ±  5%     -52.2%     349073 ± 25%  turbostat.C3
     14.77            +5.9%      15.64        turbostat.RAMWatt
  24613783 ±  5%     -32.6%   16595193 ± 23%  numa-numastat.node0.local_node
  24632941 ±  5%     -32.6%   16605181 ± 23%  numa-numastat.node0.numa_hit
  25827961           -29.9%   18097150 ± 19%  numa-numastat.node1.local_node
  25836948           -29.9%   18115676 ± 19%  numa-numastat.node1.numa_hit
  50467170 ±  2%     -31.2%   34733456 ± 10%  proc-vmstat.numa_hit
  50439016 ±  2%     -31.2%   34704933 ± 10%  proc-vmstat.numa_local
  50622650 ±  2%     -31.1%   34896854 ± 10%  proc-vmstat.pgalloc_normal
  50548381 ±  2%     -31.1%   34834391 ± 10%  proc-vmstat.pgfree
     79.00            +2.2%      80.75        vmstat.cpu.sy
     19.00            -7.9%      17.50 ±  2%  vmstat.cpu.us
  13450755            +4.6%   14066265        vmstat.system.cs
   1122772           -12.1%     986681        vmstat.system.in
    133891 ±  2%     +10.6%     148112 ±  4%  numa-vmstat.node0.nr_file_pages
  12301995 ±  4%     -30.2%    8590153 ± 22%  numa-vmstat.node0.numa_hit
  12282910 ±  4%     -30.1%    8580139 ± 22%  numa-vmstat.node0.numa_local
  12964354 ±  5%     -31.2%    8914408 ± 18%  numa-vmstat.node1.numa_hit
  12806275 ±  5%     -31.7%    8746928 ± 19%  numa-vmstat.node1.numa_local
  33816695 ± 10%     +17.8%   39824104 ±  7%  cpuidle.C1.time
  21015951 ±  3%     +19.6%   25127666 ±  7%  cpuidle.C1E.time
    730991 ±  5%     -52.1%     350128 ± 25%  cpuidle.C3.usage
 1.497e+08 ± 28%     +41.6%  2.119e+08 ± 15%  cpuidle.C6.time
   6771631 ±  4%     -45.2%    3713804 ± 15%  cpuidle.POLL.time
   5209842 ±  4%     -44.1%    2913245 ± 15%  cpuidle.POLL.usage
  26965506            +5.5%   28444381 ±  4%  sched_debug.cfs_rq:/.min_vruntime.avg
  28257967            +6.6%   30126596 ±  4%  sched_debug.cfs_rq:/.min_vruntime.max
    582203 ±  9%     +37.0%     797353 ±  8%  sched_debug.cfs_rq:/.min_vruntime.stddev
      4.65 ±  8%     -10.7%       4.16 ±  6%  sched_debug.cfs_rq:/.runnable_load_avg.stddev
      4620 ±  6%     -10.7%       4125 ±  4%  sched_debug.cfs_rq:/.runnable_weight.stddev
    582831 ±  9%     +36.6%     796226 ±  7%  sched_debug.cfs_rq:/.spread0.stddev
    154.73 ±  2%     -14.7%     132.00 ±  3%  sched_debug.cfs_rq:/.util_avg.stddev
    120.93 ± 25%     +43.5%     173.50 ± 19%  sched_debug.cfs_rq:/.util_est_enqueued.min
    184.93 ±  2%     -11.0%     164.54 ±  3%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    182135 ± 18%     +57.1%     286098 ±  6%  sched_debug.cpu.avg_idle.avg
    185926 ± 19%     +49.0%     276991 ±  9%  sched_debug.cpu.avg_idle.stddev
      3.32 ±  4%     -10.8%       2.96 ±  3%  sched_debug.cpu.nr_running.stddev
  46710201            +9.0%   50934866 ±  5%  sched_debug.cpu.nr_switches.avg
  50053735           +16.9%   58491253 ±  7%  sched_debug.cpu.nr_switches.max
  43751407            +6.7%   46698664 ±  4%  sched_debug.cpu.nr_switches.min
   1344975 ± 10%     +78.9%    2406504 ± 16%  sched_debug.cpu.nr_switches.stddev
      1.63 ±  3%     -32.8%       1.09 ± 11%  sched_debug.cpu.nr_uninterruptible.avg
      1017 ± 27%     -59.5%     411.75 ± 16%  interrupts.40:IR-PCI-MSI.1572871-edge.eth0-TxRx-6
   6547829           -14.4%    5603910 ±  5%  interrupts.CPU16.RES:Rescheduling_interrupts
      1017 ± 27%     -59.5%     411.75 ± 16%  interrupts.CPU19.40:IR-PCI-MSI.1572871-edge.eth0-TxRx-6
   6801598           -14.7%    5801847 ±  5%  interrupts.CPU19.RES:Rescheduling_interrupts
   6609756           -13.7%    5703084 ±  8%  interrupts.CPU20.RES:Rescheduling_interrupts
   6446878 ±  2%     -11.8%    5689145 ±  7%  interrupts.CPU21.RES:Rescheduling_interrupts
   6634825            -9.4%    6008203 ±  6%  interrupts.CPU24.RES:Rescheduling_interrupts
   6801182            -9.8%    6137528 ±  3%  interrupts.CPU25.RES:Rescheduling_interrupts
   6687252           -12.9%    5821967 ±  6%  interrupts.CPU28.RES:Rescheduling_interrupts
   6583387           -10.9%    5868659 ±  6%  interrupts.CPU29.RES:Rescheduling_interrupts
   6585631           -16.6%    5490726 ±  9%  interrupts.CPU37.RES:Rescheduling_interrupts
   6759973           -13.2%    5867800 ±  7%  interrupts.CPU57.RES:Rescheduling_interrupts
   6459616 ±  2%     -10.5%    5783047 ±  6%  interrupts.CPU58.RES:Rescheduling_interrupts
   6580818 ±  2%     -16.9%    5468945 ±  3%  interrupts.CPU60.RES:Rescheduling_interrupts
   6723178 ±  2%     -12.4%    5887778 ±  3%  interrupts.CPU63.RES:Rescheduling_interrupts
   6480129           -16.2%    5427168 ±  7%  interrupts.CPU64.RES:Rescheduling_interrupts
   6439558 ±  2%     -11.6%    5691160 ±  5%  interrupts.CPU65.RES:Rescheduling_interrupts
   6662822           -12.0%    5866390 ±  7%  interrupts.CPU68.RES:Rescheduling_interrupts
   6602178           -12.0%    5809760 ±  7%  interrupts.CPU7.RES:Rescheduling_interrupts
   6616172           -14.1%    5685889 ±  7%  interrupts.CPU73.RES:Rescheduling_interrupts
   6591477           -13.8%    5682655 ±  8%  interrupts.CPU81.RES:Rescheduling_interrupts
     13.97           +15.8%      16.18        perf-stat.i.MPKI
      1.70            -0.1        1.65        perf-stat.i.branch-miss-rate%
 3.607e+08            -1.6%  3.549e+08        perf-stat.i.branch-misses
      1.22 ±  6%      +0.8        2.01 ± 18%  perf-stat.i.cache-miss-rate%
  17650711 ±  6%     +98.0%   34953649 ± 18%  perf-stat.i.cache-misses
 1.496e+09           +17.3%  1.755e+09        perf-stat.i.cache-references
  13503062            +4.6%   14122231        perf-stat.i.context-switches
   2946654 ±  2%     +18.5%    3491269 ±  3%  perf-stat.i.cpu-migrations
     29365 ±  8%     -30.6%      20387 ± 31%  perf-stat.i.cycles-between-cache-misses
      0.35 ±  2%      +0.0        0.36 ±  2%  perf-stat.i.dTLB-store-miss-rate%
 2.048e+10            -2.1%  2.006e+10        perf-stat.i.dTLB-stores
     55.17            -1.4       53.74        perf-stat.i.iTLB-load-miss-rate%
 1.019e+08            +5.5%  1.074e+08        perf-stat.i.iTLB-loads
      3068            -3.0%       2975        perf-stat.i.minor-faults
   9195204 ±  6%    +113.0%   19589023 ± 18%  perf-stat.i.node-load-misses
     28132 ±  6%    +125.3%      63396 ± 13%  perf-stat.i.node-loads
     58.92            -9.8       49.16 ±  4%  perf-stat.i.node-store-miss-rate%
   3588196 ±  6%     +60.5%    5760265 ± 19%  perf-stat.i.node-store-misses
   2415953 ±  5%    +145.2%    5924042 ± 18%  perf-stat.i.node-stores
      3068            -3.0%       2975        perf-stat.i.page-faults
     13.96           +16.0%      16.19        perf-stat.overall.MPKI
      1.70            -0.1        1.65        perf-stat.overall.branch-miss-rate%
      1.18 ±  6%      +0.8        1.99 ± 18%  perf-stat.overall.cache-miss-rate%
     13823 ±  6%     -47.8%       7221 ± 20%  perf-stat.overall.cycles-between-cache-misses
      0.35 ±  2%      +0.0        0.36 ±  2%  perf-stat.overall.dTLB-store-miss-rate%
     55.11            -1.4       53.70        perf-stat.overall.iTLB-load-miss-rate%
     59.75           -10.5       49.23        perf-stat.overall.node-store-miss-rate%
     78192           +13.0%      88370        perf-stat.overall.path-length
 3.601e+08            -1.6%  3.543e+08        perf-stat.ps.branch-misses
  17622620 ±  6%     +98.0%   34899005 ± 18%  perf-stat.ps.cache-misses
 1.494e+09           +17.3%  1.752e+09        perf-stat.ps.cache-references
  13480657            +4.6%   14099389        perf-stat.ps.context-switches
   2941749 ±  2%     +18.5%    3485631 ±  3%  perf-stat.ps.cpu-migrations
 2.045e+10            -2.1%  2.003e+10        perf-stat.ps.dTLB-stores
 1.017e+08            +5.5%  1.072e+08        perf-stat.ps.iTLB-loads
      3064            -3.0%       2972        perf-stat.ps.minor-faults
   9180406 ±  6%    +113.0%   19558101 ± 18%  perf-stat.ps.node-load-misses
     28101 ±  6%    +125.3%      63314 ± 13%  perf-stat.ps.node-loads
   3582467 ±  6%     +60.5%    5751138 ± 19%  perf-stat.ps.node-store-misses
   2412086 ±  5%    +145.2%    5914636 ± 18%  perf-stat.ps.node-stores
      3064            -3.0%       2972        perf-stat.ps.page-faults
    223485            +9.1%     243918 ±  5%  softirqs.CPU0.TIMER
     11887 ± 11%     -18.2%       9723 ±  6%  softirqs.CPU1.SCHED
    215411            +9.2%     235267 ±  6%  softirqs.CPU1.TIMER
     11293 ±  3%     -14.3%       9678 ± 10%  softirqs.CPU10.SCHED
    213916            +9.8%     234908 ±  5%  softirqs.CPU10.TIMER
    212758            +7.7%     229141 ±  5%  softirqs.CPU11.TIMER
     11098 ±  2%     -15.9%       9337 ± 10%  softirqs.CPU12.SCHED
    213397            +9.0%     232706 ±  6%  softirqs.CPU12.TIMER
    212419            +8.3%     230115 ±  6%  softirqs.CPU13.TIMER
     10777 ±  4%     -12.5%       9426 ±  6%  softirqs.CPU14.SCHED
     11241 ±  3%     -11.5%       9950 ±  6%  softirqs.CPU15.SCHED
    214604           +10.0%     236116 ±  8%  softirqs.CPU15.TIMER
     11147           -14.9%       9482 ±  8%  softirqs.CPU16.SCHED
    216343            +8.4%     234558 ±  6%  softirqs.CPU16.TIMER
    214680            +7.0%     229748 ±  6%  softirqs.CPU17.TIMER
    212791            +8.6%     230988 ±  6%  softirqs.CPU19.TIMER
     11211 ±  4%     -10.4%      10047 ±  6%  softirqs.CPU2.SCHED
    219918            +9.8%     241513 ±  6%  softirqs.CPU2.TIMER
     10825 ±  4%     -14.3%       9273 ±  7%  softirqs.CPU20.SCHED
    215209            +8.8%     234149 ±  6%  softirqs.CPU20.TIMER
     10869 ±  4%     -11.4%       9626 ±  4%  softirqs.CPU21.SCHED
    216225            +8.7%     235105 ±  5%  softirqs.CPU21.TIMER
     13013 ±  7%     -14.0%      11192 ±  3%  softirqs.CPU22.SCHED
    220406            +8.9%     239975 ±  4%  softirqs.CPU22.TIMER
     11925           -14.9%      10145 ±  3%  softirqs.CPU23.SCHED
    220231            +7.6%     237056 ±  5%  softirqs.CPU23.TIMER
     11140 ±  2%     -11.5%       9861 ±  7%  softirqs.CPU24.SCHED
    216091            +8.9%     235338 ±  5%  softirqs.CPU24.TIMER
     11438 ±  3%     -16.3%       9578 ±  2%  softirqs.CPU25.SCHED
    214880            +9.4%     235143 ±  5%  softirqs.CPU25.TIMER
    214888            +8.8%     233874 ±  5%  softirqs.CPU26.TIMER
     11410 ±  2%     -13.7%       9844 ± 10%  softirqs.CPU27.SCHED
    215012            +8.7%     233790 ±  4%  softirqs.CPU27.TIMER
    220618 ±  2%      +7.8%     237788 ±  5%  softirqs.CPU28.TIMER
     11096 ±  5%     -14.3%       9513 ±  6%  softirqs.CPU29.SCHED
    217194            +8.2%     235108 ±  5%  softirqs.CPU29.TIMER
     11445 ±  2%     -16.7%       9536 ± 10%  softirqs.CPU3.SCHED
    214692            +9.1%     234221 ±  5%  softirqs.CPU3.TIMER
     11127 ±  5%     -10.5%       9954 ±  6%  softirqs.CPU30.SCHED
    214861            +8.2%     232532 ±  5%  softirqs.CPU30.TIMER
    217582            +7.8%     234493 ±  4%  softirqs.CPU31.TIMER
    214606            +8.8%     233473 ±  4%  softirqs.CPU32.TIMER
     11299 ±  2%     -11.7%       9975 ±  6%  softirqs.CPU33.SCHED
     11503 ±  2%     -16.0%       9658 ± 10%  softirqs.CPU34.SCHED
    213233           +10.9%     236580 ±  6%  softirqs.CPU34.TIMER
     11162 ±  2%     -11.6%       9863 ±  7%  softirqs.CPU35.SCHED
     11241           -13.9%       9678 ±  6%  softirqs.CPU36.SCHED
    215681            +9.2%     235446 ±  4%  softirqs.CPU36.TIMER
     11358           -15.2%       9632 ±  6%  softirqs.CPU37.SCHED
    219691 ±  2%     +18.5%     260407 ± 13%  softirqs.CPU37.TIMER
     11570 ±  2%     -13.1%      10049 ±  6%  softirqs.CPU38.SCHED
    215559            +8.2%     233189 ±  4%  softirqs.CPU38.TIMER
     11295 ±  4%     -13.1%       9819 ± 10%  softirqs.CPU39.SCHED
    215781 ±  2%      +7.6%     232108 ±  5%  softirqs.CPU39.TIMER
     11506 ±  7%     -13.0%      10006 ±  6%  softirqs.CPU4.SCHED
    214973            +8.9%     234140 ±  6%  softirqs.CPU4.TIMER
     11304 ±  2%     -13.7%       9759 ± 10%  softirqs.CPU40.SCHED
    213827           +10.1%     235341 ±  4%  softirqs.CPU40.TIMER
     11462 ±  4%     -13.5%       9913 ±  8%  softirqs.CPU41.SCHED
    215879 ±  2%      +7.2%     231499 ±  5%  softirqs.CPU41.TIMER
     11418 ±  3%     -14.0%       9819 ±  8%  softirqs.CPU43.SCHED
    214864            +8.3%     232698 ±  4%  softirqs.CPU43.TIMER
     10706 ±  5%     -13.9%       9223 ± 11%  softirqs.CPU44.SCHED
    217386            +9.4%     237916 ±  5%  softirqs.CPU44.TIMER
    215191            +9.7%     236017 ±  5%  softirqs.CPU45.TIMER
    214214            +9.9%     235466 ±  6%  softirqs.CPU46.TIMER
    214471            +9.9%     235675 ±  5%  softirqs.CPU47.TIMER
     11251 ±  2%     -13.0%       9785 ±  8%  softirqs.CPU48.SCHED
    212500            +9.9%     233451 ±  6%  softirqs.CPU48.TIMER
    213609            +9.9%     234657 ±  5%  softirqs.CPU49.TIMER
    216836            +8.5%     235225 ±  5%  softirqs.CPU5.TIMER
    215854            +9.0%     235383 ±  5%  softirqs.CPU50.TIMER
     11468           -14.4%       9820 ±  9%  softirqs.CPU51.SCHED
    215402            +8.8%     234360 ±  5%  softirqs.CPU51.TIMER
    214152            +8.8%     233038 ±  5%  softirqs.CPU52.TIMER
    212843            +8.4%     230716 ±  5%  softirqs.CPU53.TIMER
     11373 ±  2%     -14.9%       9679 ±  7%  softirqs.CPU54.SCHED
    214008            +9.5%     234380 ±  5%  softirqs.CPU54.TIMER
    212619            +7.5%     228539 ±  5%  softirqs.CPU55.TIMER
     11136 ±  3%     -16.4%       9312 ± 10%  softirqs.CPU56.SCHED
    213404            +9.0%     232542 ±  6%  softirqs.CPU56.TIMER
     11171 ±  4%     -11.9%       9837 ±  7%  softirqs.CPU57.SCHED
    212283            +8.6%     230474 ±  6%  softirqs.CPU57.TIMER
     11137 ±  4%     -14.0%       9578 ±  6%  softirqs.CPU58.SCHED
     11226 ±  4%     -17.2%       9289 ±  4%  softirqs.CPU59.SCHED
    214193           +23.1%     263668 ± 22%  softirqs.CPU59.TIMER
    217195            +8.2%     234975 ±  5%  softirqs.CPU6.TIMER
     11051 ±  4%     -14.4%       9460 ±  9%  softirqs.CPU60.SCHED
    217131            +7.9%     234363 ±  5%  softirqs.CPU60.TIMER
     11206 ±  3%     -12.6%       9793 ±  9%  softirqs.CPU61.SCHED
    211791            +9.2%     231302 ±  5%  softirqs.CPU61.TIMER
    214956 ±  2%      +8.8%     233770 ±  5%  softirqs.CPU62.TIMER
     11180 ±  3%     -14.8%       9526 ±  8%  softirqs.CPU63.SCHED
    213413            +8.7%     232008 ±  5%  softirqs.CPU63.TIMER
    215674            +8.1%     233086 ±  6%  softirqs.CPU64.TIMER
     11032 ±  3%     -15.7%       9302 ±  7%  softirqs.CPU65.SCHED
    215870            +9.0%     235386 ±  5%  softirqs.CPU65.TIMER
     11403 ±  3%     -14.2%       9786 ±  6%  softirqs.CPU66.SCHED
    215968            +9.4%     236175 ±  5%  softirqs.CPU66.TIMER
     11098 ±  3%      -7.4%      10281 ±  4%  softirqs.CPU67.SCHED
    217846            +8.3%     236023 ±  4%  softirqs.CPU67.TIMER
     11094           -12.2%       9740 ±  7%  softirqs.CPU68.SCHED
    215512            +9.4%     235796 ±  5%  softirqs.CPU68.TIMER
     11321 ±  3%     -14.1%       9724 ±  3%  softirqs.CPU69.SCHED
    213564            +9.0%     232867 ±  5%  softirqs.CPU69.TIMER
    218822            +8.8%     238080 ±  6%  softirqs.CPU7.TIMER
     11507 ±  2%     -12.9%      10026 ±  4%  softirqs.CPU70.SCHED
    213928            +9.4%     233986 ±  4%  softirqs.CPU70.TIMER
    213528            +8.5%     231730 ±  4%  softirqs.CPU71.TIMER
     11262 ±  2%     -11.1%      10013 ±  5%  softirqs.CPU72.SCHED
     11145 ±  3%     -14.5%       9533 ±  8%  softirqs.CPU73.SCHED
    216467            +9.2%     236409 ±  5%  softirqs.CPU73.TIMER
     11447 ±  4%     -13.2%       9935 ±  4%  softirqs.CPU74.SCHED
    212578            +9.1%     232022 ±  5%  softirqs.CPU74.TIMER
    215256            +7.8%     232072 ±  5%  softirqs.CPU75.TIMER
     11324 ±  4%     -11.8%       9985 ±  3%  softirqs.CPU76.SCHED
    214170            +8.6%     232516 ±  5%  softirqs.CPU76.TIMER
     11646 ±  5%     -15.7%       9824 ±  7%  softirqs.CPU77.SCHED
    213706            +8.0%     230880 ±  5%  softirqs.CPU77.TIMER
     11397 ±  6%     -13.9%       9810 ± 10%  softirqs.CPU78.SCHED
     11179 ±  3%     -11.5%       9894 ±  5%  softirqs.CPU79.SCHED
    213215            +8.4%     231081 ±  5%  softirqs.CPU79.TIMER
     11165 ±  4%     -16.2%       9352 ±  9%  softirqs.CPU8.SCHED
    216508 ±  2%      +7.9%     233692 ±  6%  softirqs.CPU8.TIMER
     11203 ±  2%     -13.9%       9643 ±  4%  softirqs.CPU80.SCHED
    216446            +8.3%     234469 ±  5%  softirqs.CPU80.TIMER
     11151 ±  2%     -12.8%       9726 ±  6%  softirqs.CPU81.SCHED
     11373 ±  3%     -13.0%       9891 ±  6%  softirqs.CPU82.SCHED
    213597            +8.9%     232608 ±  5%  softirqs.CPU82.TIMER
    214308            +7.9%     231148 ±  5%  softirqs.CPU83.TIMER
    214384           +20.9%     259149 ± 15%  softirqs.CPU84.TIMER
     11458           -13.7%       9887 ±  7%  softirqs.CPU86.SCHED
    215459            +8.2%     233058 ±  5%  softirqs.CPU86.TIMER
     11303 ±  4%     -12.4%       9904 ±  8%  softirqs.CPU87.SCHED
    214185            +7.9%     231116 ±  5%  softirqs.CPU87.TIMER
     11030 ±  2%     -13.0%       9593 ±  8%  softirqs.CPU9.SCHED
    213229            +8.7%     231788 ±  6%  softirqs.CPU9.TIMER
    995635           -12.9%     867688 ±  5%  softirqs.SCHED
  19052052            +8.6%   20690944 ±  5%  softirqs.TIMER
     31.32            -1.6       29.74        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     30.24            -1.5       28.76        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     26.06            -0.9       25.17        perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.35 ±  5%      -0.9        1.48 ± 12%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.try_to_wake_up.autoremove_wake_function.__wake_up_common
     25.36            -0.8       24.54        perf-profile.calltrace.cycles-pp.pipe_read.new_sync_read.vfs_read.ksys_read.do_syscall_64
      2.75 ±  4%      -0.7        2.08 ±  7%  perf-profile.calltrace.cycles-pp._raw_spin_lock.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      4.24 ±  2%      -0.6        3.60 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64
      3.84 ±  2%      -0.6        3.23 ±  2%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret
      7.83            -0.5        7.30 ±  2%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
      1.68 ±  6%      -0.5        1.17 ± 10%  perf-profile.calltrace.cycles-pp.update_cfs_group.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up
      8.02            -0.5        7.53 ±  2%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
      8.08            -0.5        7.60 ±  2%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      1.63 ±  4%      -0.4        1.19 ±  6%  perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_write.new_sync_write.vfs_write.ksys_write
      1.71 ±  6%      -0.4        1.28 ±  8%  perf-profile.calltrace.cycles-pp.update_cfs_group.dequeue_task_fair.__schedule.schedule.pipe_wait
      2.60            -0.4        2.19 ±  4%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.03 ±  2%      -0.4        1.64 ±  4%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.47            -0.4        3.08 ±  4%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up
      1.95 ±  2%      -0.3        1.61 ±  3%  perf-profile.calltrace.cycles-pp.copy_page_from_iter.pipe_write.new_sync_write.vfs_write.ksys_write
      2.67            -0.3        2.35 ±  3%  perf-profile.calltrace.cycles-pp.copy_page_to_iter.pipe_read.new_sync_read.vfs_read.ksys_read
      0.56            -0.3        0.26 ±100%  perf-profile.calltrace.cycles-pp.fsnotify.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.22 ±  4%      -0.3        0.94 ±  2%  perf-profile.calltrace.cycles-pp.mutex_lock.pipe_write.new_sync_write.vfs_write.ksys_write
      1.25 ±  2%      -0.3        1.00 ±  5%  perf-profile.calltrace.cycles-pp.selinux_file_permission.security_file_permission.vfs_write.ksys_write.do_syscall_64
      2.64            -0.2        2.41 ±  2%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.pipe_wait
      1.53            -0.2        1.34 ±  7%  perf-profile.calltrace.cycles-pp.selinux_file_permission.security_file_permission.vfs_read.ksys_read.do_syscall_64
      0.59 ±  4%      -0.2        0.40 ± 57%  perf-profile.calltrace.cycles-pp.__enqueue_entity.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      1.34            -0.2        1.16 ±  6%  perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      1.07 ±  2%      -0.2        0.90 ±  4%  perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter.pipe_write.new_sync_write.vfs_write
      1.05            -0.2        0.88 ±  6%  perf-profile.calltrace.cycles-pp.update_load_avg.dequeue_entity.dequeue_task_fair.__schedule.schedule
      1.56 ±  2%      -0.2        1.38 ±  2%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyout.copy_page_to_iter.pipe_read.new_sync_read
      1.17 ±  4%      -0.2        1.01 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write
      0.98 ±  2%      -0.2        0.82 ±  4%  perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.66 ±  2%      -0.2        1.50 ±  5%  perf-profile.calltrace.cycles-pp.copyout.copy_page_to_iter.pipe_read.new_sync_read.vfs_read
      0.73 ±  3%      -0.2        0.57 ±  2%  perf-profile.calltrace.cycles-pp.file_has_perm.security_file_permission.vfs_read.ksys_read.do_syscall_64
      0.96 ±  2%      -0.1        0.82 ±  3%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.copy_page_from_iter.pipe_write.new_sync_write
      0.89 ±  2%      -0.1        0.77 ±  3%  perf-profile.calltrace.cycles-pp.__fget_light.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.66 ±  6%      -0.1        0.54 ±  2%  perf-profile.calltrace.cycles-pp.file_has_perm.security_file_permission.vfs_write.ksys_write.do_syscall_64
      2.42            -0.1        2.32        perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule.pipe_wait.pipe_read
      0.89 ±  4%      -0.1        0.79 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__wake_up_common_lock.pipe_write.new_sync_write
      0.74 ±  2%      -0.1        0.66 ±  3%  perf-profile.calltrace.cycles-pp.update_curr.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      0.84            -0.1        0.79 ±  3%  perf-profile.calltrace.cycles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule.pipe_wait
      0.56            -0.0        0.54 ±  2%  perf-profile.calltrace.cycles-pp.update_curr.reweight_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      0.77 ±  2%      +0.1        0.82        perf-profile.calltrace.cycles-pp.check_preempt_wakeup.check_preempt_curr.ttwu_do_wakeup.try_to_wake_up.autoremove_wake_function
      0.90 ±  3%      +0.1        0.97 ±  2%  perf-profile.calltrace.cycles-pp.native_write_msr
      0.69 ±  3%      +0.1        0.77 ±  3%  perf-profile.calltrace.cycles-pp.update_rq_clock.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      0.80 ±  4%      +0.1        0.89 ±  2%  perf-profile.calltrace.cycles-pp.___perf_sw_event.__schedule.schedule.pipe_wait.pipe_read
      1.10            +0.1        1.20        perf-profile.calltrace.cycles-pp.reweight_entity.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up
      0.73 ±  3%      +0.1        0.83 ±  2%  perf-profile.calltrace.cycles-pp.__switch_to
      1.05            +0.1        1.16        perf-profile.calltrace.cycles-pp.reweight_entity.dequeue_task_fair.__schedule.schedule.pipe_wait
      0.63 ±  4%      +0.1        0.75 ±  2%  perf-profile.calltrace.cycles-pp.put_prev_entity.pick_next_task_fair.__schedule.schedule.exit_to_usermode_loop
      0.99 ±  5%      +0.1        1.12 ±  5%  perf-profile.calltrace.cycles-pp.set_task_cpu.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      1.07 ±  3%      +0.1        1.21 ±  2%  perf-profile.calltrace.cycles-pp.__switch_to_asm
      0.64 ±  6%      +0.2        0.80 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__schedule.schedule.pipe_wait.pipe_read
      1.41 ±  3%      +0.2        1.59 ±  2%  perf-profile.calltrace.cycles-pp.switch_fpu_return.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.77 ±  5%      +0.2        1.00 ±  5%  perf-profile.calltrace.cycles-pp.load_new_mm_cr3.switch_mm_irqs_off.__schedule.schedule.exit_to_usermode_loop
      1.73 ±  3%      +0.3        2.06 ±  3%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.exit_to_usermode_loop.do_syscall_64
      0.14 ±173%      +0.5        0.63 ±  5%  perf-profile.calltrace.cycles-pp.update_rq_clock.__schedule.schedule.pipe_wait.pipe_read
      0.13 ±173%      +0.5        0.64 ±  5%  perf-profile.calltrace.cycles-pp.migrate_task_rq_fair.set_task_cpu.try_to_wake_up.autoremove_wake_function.__wake_up_common
      1.85 ±  5%      +0.5        2.38 ±  3%  perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule.exit_to_usermode_loop.do_syscall_64
      0.00            +0.6        0.59 ±  4%  perf-profile.calltrace.cycles-pp.mutex_lock.pipe_wait.pipe_read.new_sync_read.vfs_read
      0.00            +0.6        0.60 ±  5%  perf-profile.calltrace.cycles-pp.__update_load_avg_cfs_rq.dequeue_task_fair.__schedule.schedule.pipe_wait
      0.00            +0.7        0.67 ±  5%  perf-profile.calltrace.cycles-pp.__update_load_avg_cfs_rq.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up
      0.15 ±173%      +1.0        1.14 ± 12%  perf-profile.calltrace.cycles-pp.cpumask_next_wrap.select_idle_sibling.select_task_rq_fair.try_to_wake_up.autoremove_wake_function
     87.66            +1.1       88.78        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     86.87            +1.1       88.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.59 ±  4%      +1.4        6.96 ±  3%  perf-profile.calltrace.cycles-pp.__schedule.schedule.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.72 ±  4%      +1.4        7.12 ±  3%  perf-profile.calltrace.cycles-pp.schedule.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.87 ±  4%      +1.4        7.28 ±  3%  perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.70 ± 30%      +3.3        4.98 ± 13%  perf-profile.calltrace.cycles-pp.available_idle_cpu.select_idle_sibling.select_task_rq_fair.try_to_wake_up.autoremove_wake_function
     35.54            +3.3       38.87        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     34.28            +3.5       37.82        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     31.12            +4.1       35.22 ±  2%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     30.49            +4.1       34.63 ±  2%  perf-profile.calltrace.cycles-pp.pipe_write.new_sync_write.vfs_write.ksys_write.do_syscall_64
     22.54 ±  2%      +6.0       28.53 ±  3%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write.ksys_write
     20.58 ±  2%      +6.2       26.76 ±  3%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write
     19.97 ±  2%      +6.2       26.16 ±  3%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write.new_sync_write
     19.73 ±  3%      +6.2       25.92 ±  3%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write
      3.39 ± 20%      +7.0       10.39 ± 12%  perf-profile.calltrace.cycles-pp.select_idle_sibling.select_task_rq_fair.try_to_wake_up.autoremove_wake_function.__wake_up_common
      4.89 ± 15%      +7.1       11.98 ± 10%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
     31.34            -1.6       29.75        perf-profile.children.cycles-pp.ksys_read
     30.28            -1.5       28.79        perf-profile.children.cycles-pp.vfs_read
      4.14 ±  5%      -1.3        2.85 ±  7%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      3.51 ±  6%      -1.0        2.54 ±  8%  perf-profile.children.cycles-pp.update_cfs_group
     26.10            -0.9       25.20        perf-profile.children.cycles-pp.new_sync_read
     25.42            -0.8       24.59        perf-profile.children.cycles-pp.pipe_read
      4.67            -0.8        3.86 ±  4%  perf-profile.children.cycles-pp.security_file_permission
      4.33 ±  2%      -0.7        3.65 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      4.24 ±  2%      -0.6        3.60 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      2.18 ±  4%      -0.5        1.64 ±  6%  perf-profile.children.cycles-pp.mutex_unlock
      7.92            -0.5        7.40 ±  3%  perf-profile.children.cycles-pp.enqueue_task_fair
      8.10            -0.5        7.61 ±  3%  perf-profile.children.cycles-pp.activate_task
      8.16            -0.5        7.67 ±  3%  perf-profile.children.cycles-pp.ttwu_do_activate
      4.12 ±  4%      -0.5        3.64 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock
      2.83            -0.4        2.38 ±  6%  perf-profile.children.cycles-pp.selinux_file_permission
      3.53            -0.4        3.13 ±  4%  perf-profile.children.cycles-pp.enqueue_entity
      1.99 ±  2%      -0.4        1.64 ±  3%  perf-profile.children.cycles-pp.copy_page_from_iter
      3.34            -0.4        2.99 ±  4%  perf-profile.children.cycles-pp.update_load_avg
      2.70            -0.3        2.39 ±  3%  perf-profile.children.cycles-pp.copy_page_to_iter
      2.66            -0.3        2.35 ±  3%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.93 ±  3%      -0.3        0.64 ±  7%  perf-profile.children.cycles-pp.__mutex_unlock_slowpath
      1.41 ±  4%      -0.3        1.13        perf-profile.children.cycles-pp.file_has_perm
      2.75            -0.3        2.49 ±  2%  perf-profile.children.cycles-pp.dequeue_entity
      2.29 ±  2%      -0.3        2.04        perf-profile.children.cycles-pp.mutex_lock
      0.85 ±  3%      -0.2        0.61 ±  4%  perf-profile.children.cycles-pp.__inode_security_revalidate
      0.59 ±  3%      -0.2        0.39 ±  6%  perf-profile.children.cycles-pp.__mutex_lock
      1.79 ±  2%      -0.2        1.59 ±  4%  perf-profile.children.cycles-pp.__fdget_pos
      1.70 ±  2%      -0.2        1.52 ±  3%  perf-profile.children.cycles-pp.__fget_light
      0.93 ±  3%      -0.2        0.75        perf-profile.children.cycles-pp.avc_has_perm
      1.09 ±  2%      -0.2        0.92 ±  4%  perf-profile.children.cycles-pp.copyin
      2.33 ±  2%      -0.2        2.16        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.96 ±  2%      -0.2        0.81 ±  2%  perf-profile.children.cycles-pp.___might_sleep
      1.67 ±  2%      -0.2        1.52 ±  5%  perf-profile.children.cycles-pp.copyout
      0.83 ±  4%      -0.1        0.68 ±  2%  perf-profile.children.cycles-pp._cond_resched
      0.33 ±  5%      -0.1        0.19 ± 10%  perf-profile.children.cycles-pp.preempt_schedule_common
      0.42 ±  2%      -0.1        0.28 ±  8%  perf-profile.children.cycles-pp.wake_up_q
      0.70 ±  3%      -0.1        0.59 ±  3%  perf-profile.children.cycles-pp.__might_sleep
      0.65 ±  5%      -0.1        0.54 ±  7%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.52 ±  2%      -0.1        0.43        perf-profile.children.cycles-pp.__might_fault
      0.53 ±  5%      -0.1        0.45        perf-profile.children.cycles-pp.current_time
      0.84 ±  3%      -0.1        0.77        perf-profile.children.cycles-pp.fsnotify
      0.16 ±  7%      -0.1        0.09 ± 13%  perf-profile.children.cycles-pp.swapgs_restore_regs_and_return_to_usermode
      0.15 ±  8%      -0.1        0.08 ± 15%  perf-profile.children.cycles-pp.prepare_exit_to_usermode
      0.22 ±  3%      -0.1        0.16 ±  7%  perf-profile.children.cycles-pp.wake_q_add
      0.49            -0.1        0.44        perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.26 ±  4%      -0.1        0.21 ±  2%  perf-profile.children.cycles-pp.rcu_all_qs
      0.08 ± 14%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__vfs_read
      0.25 ±  4%      -0.0        0.20 ±  5%  perf-profile.children.cycles-pp.finish_wait
      0.38            -0.0        0.34 ±  2%  perf-profile.children.cycles-pp.__x64_sys_read
      0.43 ±  3%      -0.0        0.39 ±  2%  perf-profile.children.cycles-pp.prepare_to_wait
      0.14 ± 20%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.task_tick_fair
      0.16 ± 19%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.scheduler_tick
      0.10 ±  8%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      0.18 ±  8%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.inode_has_perm
      0.21 ±  2%      -0.0        0.18 ±  6%  perf-profile.children.cycles-pp.deactivate_task
      0.20 ±  2%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.generic_pipe_buf_confirm
      0.13 ±  3%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__sb_end_write
      0.14 ±  9%      -0.0        0.12        perf-profile.children.cycles-pp.timespec64_trunc
      0.14 ±  3%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.11 ±  4%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.smp_reschedule_interrupt
      0.17 ±  4%      -0.0        0.15        perf-profile.children.cycles-pp.iov_iter_init
      0.11 ±  4%      -0.0        0.09 ± 10%  perf-profile.children.cycles-pp.native_apic_msr_eoi_write
      0.09 ±  4%      -0.0        0.07        perf-profile.children.cycles-pp.__x2apic_send_IPI_dest
      0.15            -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.rb_insert_color
      0.18 ±  2%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.set_next_buddy
      0.08 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.interrupt_entry
      0.23 ±  2%      +0.0        0.24        perf-profile.children.cycles-pp.cpumask_next
      0.67            +0.0        0.69        perf-profile.children.cycles-pp.__calc_delta
      0.15 ±  3%      +0.0        0.18 ±  6%  perf-profile.children.cycles-pp.wakeup_preempt_entity
      0.17 ±  6%      +0.1        0.23 ±  3%  perf-profile.children.cycles-pp.remove_entity_load_avg
      0.14 ±  6%      +0.1        0.19 ±  7%  perf-profile.children.cycles-pp.attach_entity_load_avg
      0.80 ±  3%      +0.1        0.86        perf-profile.children.cycles-pp.check_preempt_wakeup
      0.37 ±  3%      +0.1        0.45 ±  4%  perf-profile.children.cycles-pp.account_entity_enqueue
      0.79 ±  4%      +0.1        0.88 ±  5%  perf-profile.children.cycles-pp.finish_task_switch
      0.80 ±  2%      +0.1        0.89 ±  2%  perf-profile.children.cycles-pp.put_prev_entity
      0.54 ±  2%      +0.1        0.65        perf-profile.children.cycles-pp.account_entity_dequeue
      1.01 ±  5%      +0.1        1.13 ±  5%  perf-profile.children.cycles-pp.set_task_cpu
      0.49 ±  7%      +0.2        0.65 ±  5%  perf-profile.children.cycles-pp.migrate_task_rq_fair
      1.23 ±  4%      +0.2        1.40 ±  2%  perf-profile.children.cycles-pp.__switch_to_asm
      1.15 ±  2%      +0.2        1.33 ±  2%  perf-profile.children.cycles-pp.__switch_to
      1.42 ±  3%      +0.2        1.59 ±  2%  perf-profile.children.cycles-pp.switch_fpu_return
      0.76 ±  3%      +0.2        0.96 ±  3%  perf-profile.children.cycles-pp.pick_next_entity
      2.21            +0.2        2.42        perf-profile.children.cycles-pp.reweight_entity
      2.20 ±  2%      +0.2        2.43        perf-profile.children.cycles-pp.load_new_mm_cr3
      1.24 ±  5%      +0.2        1.48 ±  4%  perf-profile.children.cycles-pp.update_rq_clock
      1.43 ±  5%      +0.3        1.73 ±  2%  perf-profile.children.cycles-pp.___perf_sw_event
      0.38 ± 15%      +0.3        0.68 ±  9%  perf-profile.children.cycles-pp.find_next_bit
      3.96            +0.3        4.28        perf-profile.children.cycles-pp.pick_next_task_fair
      4.43 ±  2%      +0.4        4.82        perf-profile.children.cycles-pp.switch_mm_irqs_off
      1.11            +0.7        1.83 ±  4%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.46 ± 26%      +0.7        1.20 ± 12%  perf-profile.children.cycles-pp.cpumask_next_wrap
     87.76            +1.1       88.86        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     86.98            +1.1       88.10        perf-profile.children.cycles-pp.do_syscall_64
     21.71            +1.3       23.02        perf-profile.children.cycles-pp.__schedule
      5.98 ±  4%      +1.4        7.34 ±  3%  perf-profile.children.cycles-pp.exit_to_usermode_loop
     21.59            +1.4       22.99        perf-profile.children.cycles-pp.schedule
      1.73 ± 29%      +3.3        5.03 ± 13%  perf-profile.children.cycles-pp.available_idle_cpu
     35.55            +3.3       38.88        perf-profile.children.cycles-pp.ksys_write
     34.31            +3.5       37.84        perf-profile.children.cycles-pp.vfs_write
     31.14            +4.1       35.23 ±  2%  perf-profile.children.cycles-pp.new_sync_write
     30.56            +4.2       34.74 ±  2%  perf-profile.children.cycles-pp.pipe_write
     22.96 ±  2%      +6.0       28.93 ±  3%  perf-profile.children.cycles-pp.__wake_up_common_lock
     20.11 ±  2%      +6.1       26.19 ±  3%  perf-profile.children.cycles-pp.try_to_wake_up
     20.66 ±  2%      +6.2       26.82 ±  3%  perf-profile.children.cycles-pp.__wake_up_common
     20.01 ±  2%      +6.2       26.19 ±  3%  perf-profile.children.cycles-pp.autoremove_wake_function
      3.46 ± 20%      +7.0       10.48 ± 12%  perf-profile.children.cycles-pp.select_idle_sibling
      4.92 ± 15%      +7.1       12.01 ± 10%  perf-profile.children.cycles-pp.select_task_rq_fair
     11.85 ±  3%      -2.1        9.72 ±  2%  perf-profile.self.cycles-pp.do_syscall_64
      4.13 ±  5%      -1.3        2.85 ±  8%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      3.49 ±  6%      -1.0        2.52 ±  9%  perf-profile.self.cycles-pp.update_cfs_group
      4.33 ±  2%      -0.7        3.64 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      4.24 ±  2%      -0.6        3.60 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      2.12 ±  4%      -0.5        1.59 ±  6%  perf-profile.self.cycles-pp.mutex_unlock
      2.61            -0.3        2.31 ±  3%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      1.60 ±  2%      -0.3        1.30 ±  5%  perf-profile.self.cycles-pp.update_load_avg
      1.48 ±  3%      -0.2        1.25 ±  2%  perf-profile.self.cycles-pp.mutex_lock
      1.95            -0.2        1.75 ±  7%  perf-profile.self.cycles-pp.selinux_file_permission
      1.06 ±  5%      -0.2        0.86 ±  5%  perf-profile.self.cycles-pp.pipe_write
      1.46 ±  2%      -0.2        1.28 ±  3%  perf-profile.self.cycles-pp.pipe_read
      1.65 ±  2%      -0.2        1.49 ±  4%  perf-profile.self.cycles-pp.__fget_light
      0.91 ±  3%      -0.2        0.74        perf-profile.self.cycles-pp.avc_has_perm
      0.94 ±  2%      -0.2        0.79 ±  2%  perf-profile.self.cycles-pp.___might_sleep
      1.84            -0.1        1.72 ±  2%  perf-profile.self.cycles-pp.update_curr
      1.05            -0.1        0.93        perf-profile.self.cycles-pp.enqueue_task_fair
      0.63 ±  3%      -0.1        0.52 ±  2%  perf-profile.self.cycles-pp.__might_sleep
      0.60 ±  6%      -0.1        0.51 ±  7%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.29 ±  3%      -0.1        0.19 ±  5%  perf-profile.self.cycles-pp.__mutex_lock
      0.38 ±  4%      -0.1        0.29 ±  4%  perf-profile.self.cycles-pp.vfs_write
      0.51            -0.1        0.43 ±  4%  perf-profile.self.cycles-pp.copy_page_to_iter
      0.49            -0.1        0.41 ±  2%  perf-profile.self.cycles-pp.new_sync_write
      0.35 ±  4%      -0.1        0.28 ±  2%  perf-profile.self.cycles-pp.copy_page_from_iter
      0.81 ±  3%      -0.1        0.75        perf-profile.self.cycles-pp.fsnotify
      0.26            -0.1        0.19 ±  3%  perf-profile.self.cycles-pp.__inode_security_revalidate
      0.20 ±  4%      -0.1        0.13 ±  6%  perf-profile.self.cycles-pp.__mutex_unlock_slowpath
      0.29 ±  5%      -0.1        0.23 ±  3%  perf-profile.self.cycles-pp.file_has_perm
      0.22            -0.1        0.16 ±  8%  perf-profile.self.cycles-pp.wake_q_add
      0.57 ±  2%      -0.1        0.52        perf-profile.self.cycles-pp.new_sync_read
      0.34 ±  2%      -0.1        0.29 ±  3%  perf-profile.self.cycles-pp.dequeue_entity
      0.26 ±  3%      -0.1        0.21 ±  3%  perf-profile.self.cycles-pp.ksys_read
      0.28 ±  2%      -0.0        0.23        perf-profile.self.cycles-pp.security_file_permission
      0.22 ±  3%      -0.0        0.17 ±  4%  perf-profile.self.cycles-pp.finish_wait
      0.25            -0.0        0.21 ±  4%  perf-profile.self.cycles-pp.ksys_write
      0.88            -0.0        0.83        perf-profile.self.cycles-pp.__lock_text_start
      0.66            -0.0        0.61        perf-profile.self.cycles-pp.vfs_read
      1.37            -0.0        1.32        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.29 ±  4%      -0.0        0.25        perf-profile.self.cycles-pp.current_time
      0.20 ±  3%      -0.0        0.16 ±  4%  perf-profile.self.cycles-pp.rcu_all_qs
      0.10 ±  8%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      0.42            -0.0        0.39 ±  2%  perf-profile.self.cycles-pp.__x86_indirect_thunk_rax
      0.34            -0.0        0.31 ±  2%  perf-profile.self.cycles-pp.__x64_sys_read
      0.09 ±  5%      -0.0        0.05 ±  9%  perf-profile.self.cycles-pp.wake_up_q
      0.15 ±  8%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.inode_has_perm
      0.14 ±  5%      -0.0        0.11 ±  9%  perf-profile.self.cycles-pp.rb_next
      0.20 ±  2%      -0.0        0.17 ±  4%  perf-profile.self.cycles-pp.deactivate_task
      0.11 ±  4%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.__fdget_pos
      0.24 ±  2%      -0.0        0.22 ±  3%  perf-profile.self.cycles-pp.prepare_to_wait
      0.14 ±  3%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.13 ±  7%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.timespec64_trunc
      0.06            -0.0        0.04 ± 57%  perf-profile.self.cycles-pp.copyout
      0.11 ±  4%      -0.0        0.09 ± 10%  perf-profile.self.cycles-pp.native_apic_msr_eoi_write
      0.17 ±  4%      -0.0        0.15 ±  2%  perf-profile.self.cycles-pp.generic_pipe_buf_confirm
      0.18 ±  2%      -0.0        0.16 ±  4%  perf-profile.self.cycles-pp.__might_fault
      0.17 ±  2%      -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.set_next_buddy
      0.15 ±  2%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.rb_insert_color
      0.12 ±  3%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.__sb_end_write
      0.10 ±  8%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.kill_fasync
      0.14 ±  3%      +0.0        0.16 ±  5%  perf-profile.self.cycles-pp.exit_to_usermode_loop
      0.66            +0.0        0.68        perf-profile.self.cycles-pp.__calc_delta
      0.16 ±  5%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.native_load_tls
      0.14 ±  3%      +0.0        0.17 ±  4%  perf-profile.self.cycles-pp.wakeup_preempt_entity
      0.67            +0.0        0.70        perf-profile.self.cycles-pp.dequeue_task_fair
      0.23 ±  3%      +0.0        0.27 ±  3%  perf-profile.self.cycles-pp._cond_resched
      0.17 ±  4%      +0.0        0.21 ±  6%  perf-profile.self.cycles-pp.activate_task
      0.35 ±  3%      +0.0        0.40        perf-profile.self.cycles-pp.pick_next_entity
      1.20            +0.1        1.25        perf-profile.self.cycles-pp.select_task_rq_fair
      0.13 ±  6%      +0.1        0.18 ±  6%  perf-profile.self.cycles-pp.attach_entity_load_avg
      0.87 ±  3%      +0.1        0.96 ±  3%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.27 ±  6%      +0.1        0.36 ±  7%  perf-profile.self.cycles-pp.migrate_task_rq_fair
      0.32 ±  2%      +0.1        0.41 ±  4%  perf-profile.self.cycles-pp.account_entity_enqueue
      0.42            +0.1        0.56 ±  2%  perf-profile.self.cycles-pp.account_entity_dequeue
      2.24 ±  3%      +0.1        2.39 ±  2%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      1.09 ±  2%      +0.2        1.26 ±  2%  perf-profile.self.cycles-pp.__switch_to
      1.20 ±  4%      +0.2        1.37 ±  2%  perf-profile.self.cycles-pp.__switch_to_asm
      1.40 ±  3%      +0.2        1.58 ±  2%  perf-profile.self.cycles-pp.switch_fpu_return
      0.89 ±  6%      +0.2        1.10 ±  5%  perf-profile.self.cycles-pp.update_rq_clock
      2.19 ±  2%      +0.2        2.42        perf-profile.self.cycles-pp.load_new_mm_cr3
      1.33 ±  4%      +0.3        1.60 ±  3%  perf-profile.self.cycles-pp.___perf_sw_event
      0.34 ± 14%      +0.3        0.66 ±  9%  perf-profile.self.cycles-pp.find_next_bit
      0.28 ± 23%      +0.4        0.72 ± 12%  perf-profile.self.cycles-pp.cpumask_next_wrap
      0.89            +0.7        1.58 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock
      1.04            +0.7        1.76 ±  4%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.65 ± 12%      +3.0        3.61 ± 13%  perf-profile.self.cycles-pp.select_idle_sibling
      1.71 ± 29%      +3.3        4.97 ± 13%  perf-profile.self.cycles-pp.available_idle_cpu



***************************************************************************************************
lkp-cfl-e1: 16 threads Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz with 32G memory
=========================================================================================
compiler/cpufreq_governor/ipc/kconfig/mode/nr_threads/rootfs/tbox_group/testcase/ucode:
  gcc-7/performance/pipe/x86_64-rhel-7.6/threads/100%/debian-x86_64-2018-04-03.cgz/lkp-cfl-e1/hackbench/0xb8

commit: 
  43e9f7f231 ("sched/fair: Start tracking SCHED_IDLE tasks count in cfs_rq")
  3c29e651e1 ("sched/fair: Fall back to sched-idle CPU if idle CPU isn't found")

43e9f7f231e40e45 3c29e651e16dd3b3179cfb2d055 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          1:2          -50%            :4     dmesg.WARNING:at#for_ip_swapgs_restore_regs_and_return_to_usermode/0x
          1:2          -50%            :4     dmesg.WARNING:stack_recursion
         %stddev     %change         %stddev
             \          |                \  
     49845            -6.8%      46466        hackbench.throughput
 8.776e+08           +13.0%  9.915e+08        hackbench.time.involuntary_context_switches
     93623            -6.3%      87707        hackbench.time.minor_page_faults
    740.08            -1.4%     729.54        hackbench.time.user_time
 1.569e+09            +3.5%  1.623e+09        hackbench.time.voluntary_context_switches
 3.072e+08            -6.2%   2.88e+08        hackbench.workload
     21.45            -1.7%      21.09        boot-time.boot
   1747212 ±  3%     -31.0%    1205072 ± 14%  cpuidle.POLL.time
   1289000 ±  4%     -36.6%     817407 ± 13%  cpuidle.POLL.usage
   4038486            +6.3%    4293331        vmstat.system.cs
    394711           -10.2%     354353 ±  2%  vmstat.system.in
     10059           -15.4%       8506 ±  5%  softirqs.CPU0.SCHED
    309881           -27.3%     225159 ±  4%  softirqs.CPU2.TIMER
    220105           +20.8%     265807 ± 16%  softirqs.CPU6.TIMER
    120937 ±  3%     -17.6%      99667 ±  2%  softirqs.SCHED
     18883            -8.9%      17200 ±  3%  slabinfo.kmalloc-32.active_objs
     18883            -8.9%      17200 ±  3%  slabinfo.kmalloc-32.num_objs
      8573 ±  2%      -7.6%       7924        slabinfo.lsm_file_cache.active_objs
      8573 ±  2%      -7.6%       7924        slabinfo.lsm_file_cache.num_objs
      5280            -8.8%       4814        slabinfo.task_delay_info.active_objs
      5280            -8.8%       4814        slabinfo.task_delay_info.num_objs
     65295            -1.9%      64034        proc-vmstat.nr_active_anon
     60605            -1.5%      59671        proc-vmstat.nr_anon_pages
     12935            -0.9%      12820        proc-vmstat.nr_slab_unreclaimable
     65295            -1.9%      64034        proc-vmstat.nr_zone_active_anon
  24774010           -16.6%   20673098        proc-vmstat.numa_hit
  24774010           -16.6%   20673098        proc-vmstat.numa_local
  24839243           -16.5%   20735391        proc-vmstat.pgalloc_normal
    673024            -2.4%     657142        proc-vmstat.pgfault
  24822112           -16.5%   20717243        proc-vmstat.pgfree
    247.95 ± 14%     -19.1%     200.59 ±  4%  sched_debug.cfs_rq:/.load_avg.max
     43.55 ±  3%     -19.9%      34.86 ±  6%  sched_debug.cfs_rq:/.load_avg.min
     55.51 ±  6%     -13.2%      48.19 ±  7%  sched_debug.cfs_rq:/.load_avg.stddev
     20116 ±  8%     -12.8%      17531 ±  5%  sched_debug.cfs_rq:/.runnable_weight.min
      1288            +7.5%       1384 ±  3%  sched_debug.cfs_rq:/.util_avg.max
     54763 ±  9%    +130.8%     126390 ± 25%  sched_debug.cpu.avg_idle.avg
    301502 ± 18%     +84.9%     557406 ± 14%  sched_debug.cpu.avg_idle.max
     82233 ± 22%    +122.7%     183153 ± 17%  sched_debug.cpu.avg_idle.stddev
      0.00 ± 12%     -12.0%       0.00 ±  8%  sched_debug.cpu.next_balance.stddev
     16.92 ±  4%      -7.5%      15.66 ±  3%  sched_debug.cpu.nr_running.avg
      2.92 ± 10%     -20.9%       2.31 ± 16%  sched_debug.cpu.nr_uninterruptible.avg
      2977 ± 50%     -73.0%     803.75 ± 43%  interrupts.133:IR-PCI-MSI.2097154-edge.eth1-TxRx-1
    546.00 ± 23%    +119.5%       1198 ± 16%  interrupts.135:IR-PCI-MSI.2097156-edge.eth1-TxRx-3
  13831842           -11.5%   12245495 ±  2%  interrupts.CPU0.RES:Rescheduling_interrupts
     45259 ±  5%     +68.9%      76440 ± 15%  interrupts.CPU0.TRM:Thermal_event_interrupts
      2977 ± 50%     -73.0%     803.75 ± 43%  interrupts.CPU1.133:IR-PCI-MSI.2097154-edge.eth1-TxRx-1
     45283 ±  5%     +68.9%      76474 ± 15%  interrupts.CPU1.TRM:Thermal_event_interrupts
  13947887           -11.0%   12413074        interrupts.CPU10.RES:Rescheduling_interrupts
     45275 ±  5%     +68.9%      76468 ± 15%  interrupts.CPU10.TRM:Thermal_event_interrupts
     45286 ±  5%     +68.9%      76468 ± 15%  interrupts.CPU11.TRM:Thermal_event_interrupts
  13579741           -11.8%   11974820 ±  5%  interrupts.CPU12.RES:Rescheduling_interrupts
     45286 ±  5%     +68.9%      76471 ± 15%  interrupts.CPU12.TRM:Thermal_event_interrupts
  13668073           -11.3%   12119346        interrupts.CPU13.RES:Rescheduling_interrupts
     45286 ±  5%     +68.9%      76474 ± 15%  interrupts.CPU13.TRM:Thermal_event_interrupts
  13578574            -7.8%   12518854        interrupts.CPU14.RES:Rescheduling_interrupts
     45286 ±  5%     +68.9%      76467 ± 15%  interrupts.CPU14.TRM:Thermal_event_interrupts
  13689117           -10.1%   12310290 ±  2%  interrupts.CPU15.RES:Rescheduling_interrupts
     45286 ±  5%     +68.9%      76473 ± 15%  interrupts.CPU15.TRM:Thermal_event_interrupts
  13924470           -10.5%   12461613        interrupts.CPU2.RES:Rescheduling_interrupts
     45264 ±  5%     +68.9%      76467 ± 15%  interrupts.CPU2.TRM:Thermal_event_interrupts
    546.00 ± 23%    +119.5%       1198 ± 16%  interrupts.CPU3.135:IR-PCI-MSI.2097156-edge.eth1-TxRx-3
  13951884           -10.5%   12480739        interrupts.CPU3.RES:Rescheduling_interrupts
     45286 ±  5%     +68.9%      76469 ± 15%  interrupts.CPU3.TRM:Thermal_event_interrupts
     45285 ±  5%     +68.9%      76471 ± 15%  interrupts.CPU4.TRM:Thermal_event_interrupts
  14030690           -10.7%   12530992 ±  3%  interrupts.CPU5.RES:Rescheduling_interrupts
     45286 ±  5%     +68.9%      76471 ± 15%  interrupts.CPU5.TRM:Thermal_event_interrupts
     45285 ±  5%     +68.9%      76474 ± 15%  interrupts.CPU6.TRM:Thermal_event_interrupts
     45285 ±  5%     +68.9%      76472 ± 15%  interrupts.CPU7.TRM:Thermal_event_interrupts
  13319036           -10.2%   11966842 ±  2%  interrupts.CPU8.RES:Rescheduling_interrupts
     45280 ±  5%     +68.7%      76405 ± 15%  interrupts.CPU8.TRM:Thermal_event_interrupts
  13401328           -11.8%   11816711 ±  3%  interrupts.CPU9.RES:Rescheduling_interrupts
     45279 ±  5%     +68.9%      76467 ± 15%  interrupts.CPU9.TRM:Thermal_event_interrupts
  2.19e+08            -9.8%  1.974e+08 ±  2%  interrupts.RES:Rescheduling_interrupts
    724498 ±  5%     +68.9%    1223435 ± 15%  interrupts.TRM:Thermal_event_interrupts
     53.44            +4.2%      55.68        perf-stat.i.MPKI
      0.12            -0.0        0.10 ±  4%  perf-stat.i.cache-miss-rate%
   1764490           -13.1%    1533362 ±  3%  perf-stat.i.cache-misses
 1.767e+09            +3.6%  1.832e+09        perf-stat.i.cache-references
   4055785            +6.2%    4306694        perf-stat.i.context-switches
    336154           +21.5%     408363        perf-stat.i.cpu-migrations
     34528 ±  5%     +10.3%      38089 ±  3%  perf-stat.i.cycles-between-cache-misses
      0.01 ±  6%      -0.0        0.01 ±  6%  perf-stat.i.dTLB-load-miss-rate%
    899577 ±  6%     -15.2%     762553 ±  5%  perf-stat.i.dTLB-load-misses
      0.00 ±  7%      -0.0        0.00 ±  4%  perf-stat.i.dTLB-store-miss-rate%
     22816 ±  7%     -13.2%      19813 ±  4%  perf-stat.i.dTLB-store-misses
 6.044e+09            -1.2%  5.969e+09        perf-stat.i.dTLB-stores
  31331199            -3.4%   30272777        perf-stat.i.iTLB-load-misses
      1061            +3.1%       1094        perf-stat.i.instructions-per-iTLB-miss
      1077            -2.9%       1046        perf-stat.i.minor-faults
     73018           -10.9%      65028 ±  2%  perf-stat.i.node-loads
    122632 ±  2%      -9.3%     111181 ±  4%  perf-stat.i.node-stores
      1077            -2.9%       1046        perf-stat.i.page-faults
     53.29            +4.2%      55.53        perf-stat.overall.MPKI
      0.10            -0.0        0.08 ±  3%  perf-stat.overall.cache-miss-rate%
     25264           +15.3%      29120 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.01 ±  6%      -0.0        0.01 ±  6%  perf-stat.overall.dTLB-load-miss-rate%
      0.00 ±  7%      -0.0        0.00 ±  4%  perf-stat.overall.dTLB-store-miss-rate%
      1058            +2.9%       1089        perf-stat.overall.instructions-per-iTLB-miss
     65158            +6.6%      69487        perf-stat.overall.path-length
   1761814           -13.1%    1530883 ±  3%  perf-stat.ps.cache-misses
 1.765e+09            +3.7%  1.829e+09        perf-stat.ps.cache-references
   4048770            +6.2%    4299578        perf-stat.ps.context-switches
    335565           +21.5%     407697        perf-stat.ps.cpu-migrations
    898100 ±  6%     -15.2%     761293 ±  5%  perf-stat.ps.dTLB-load-misses
     22777 ±  7%     -13.2%      19781 ±  4%  perf-stat.ps.dTLB-store-misses
 6.034e+09            -1.2%   5.96e+09        perf-stat.ps.dTLB-stores
  31277565            -3.4%   30222833        perf-stat.ps.iTLB-load-misses
      1075            -2.9%       1044        perf-stat.ps.minor-faults
     72896           -10.9%      64922 ±  2%  perf-stat.ps.node-loads
    122424 ±  2%      -9.3%     111005 ±  4%  perf-stat.ps.node-stores
      1075            -2.9%       1044        perf-stat.ps.page-faults
     39.37 ±100%     -36.4        2.98 ±173%  perf-profile.calltrace.cycles-pp.start_thread
     21.68 ±100%     -20.0        1.64 ±173%  perf-profile.calltrace.cycles-pp.__GI___libc_write.start_thread
     20.14 ±100%     -18.6        1.52 ±173%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__GI___libc_write.start_thread
     20.00 ±100%     -18.5        1.51 ±173%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_write.start_thread
     18.05 ±100%     -16.7        1.39 ±173%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_write.start_thread
     16.75 ±100%     -15.5        1.22 ±173%  perf-profile.calltrace.cycles-pp.__GI___libc_read.start_thread
     16.70 ±100%     -15.4        1.26 ±173%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_write
     14.98 ±100%     -13.9        1.09 ±173%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__GI___libc_read.start_thread
     14.82 ±100%     -13.7        1.08 ±173%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_read.start_thread
     13.95 ±100%     -12.9        1.03 ±173%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_read.start_thread
     12.97 ±100%     -12.0        0.95 ±173%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_read
      3.69 ±  6%      -1.1        2.58 ±  7%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.try_to_wake_up.autoremove_wake_function.__wake_up_common
      4.25 ±  6%      -1.0        3.29 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      1.54 ± 10%      -0.5        1.05        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write
      1.07 ± 16%      -0.5        0.60 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__wake_up_common_lock.pipe_write.new_sync_write
      1.14 ±  2%      -0.3        0.80 ±  7%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__schedule.schedule.pipe_wait
      0.55 ±  4%      -0.3        0.26 ±100%  perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_read.new_sync_read.vfs_read.ksys_read
      1.90 ±  9%      -0.2        1.67 ±  7%  perf-profile.calltrace.cycles-pp.__fget_light.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.71 ±  7%      -0.2        1.48 ±  7%  perf-profile.calltrace.cycles-pp.__fget.__fget_light.__fdget_pos.ksys_write.do_syscall_64
      0.68 ± 19%      +0.2        0.86        perf-profile.calltrace.cycles-pp.update_cfs_group.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up
      0.67 ± 16%      +0.2        0.88 ±  4%  perf-profile.calltrace.cycles-pp.update_cfs_group.dequeue_task_fair.__schedule.schedule.pipe_wait
      0.29 ±100%      +0.4        0.64 ±  4%  perf-profile.calltrace.cycles-pp.___perf_sw_event.__schedule.schedule.pipe_wait.pipe_read
      0.31 ±100%      +0.4        0.67 ±  4%  perf-profile.calltrace.cycles-pp.mutex_lock.pipe_wait.pipe_read.new_sync_read.vfs_read
      0.32 ±100%      +0.4        0.68 ±  2%  perf-profile.calltrace.cycles-pp.pick_next_entity.pick_next_task_fair.__schedule.schedule.pipe_wait
      0.29 ±100%      +0.4        0.68 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__schedule.schedule.exit_to_usermode_loop.do_syscall_64
      0.35 ±100%      +0.4        0.78        perf-profile.calltrace.cycles-pp.update_curr.reweight_entity.dequeue_task_fair.__schedule.schedule
      1.23 ± 19%      +0.4        1.68 ±  2%  perf-profile.calltrace.cycles-pp.reweight_entity.dequeue_task_fair.__schedule.schedule.pipe_wait
      1.29 ± 18%      +0.5        1.76 ±  5%  perf-profile.calltrace.cycles-pp.reweight_entity.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up
      0.00            +0.5        0.53 ±  2%  perf-profile.calltrace.cycles-pp.update_load_avg.set_next_entity.pick_next_task_fair.__schedule.schedule
      0.00            +0.6        0.59 ±  7%  perf-profile.calltrace.cycles-pp.__enqueue_entity.put_prev_entity.pick_next_task_fair.__schedule.schedule
      8.82            +0.6        9.46 ±  2%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
      0.47 ±100%      +0.7        1.14 ±  6%  perf-profile.calltrace.cycles-pp.put_prev_entity.pick_next_task_fair.__schedule.schedule.exit_to_usermode_loop
      2.21 ± 10%      +0.7        2.88 ±  4%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.exit_to_usermode_loop.do_syscall_64
      9.10            +0.7        9.79        perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      9.04            +0.7        9.74 ±  2%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
      0.71 ±100%      +0.9        1.61 ±  3%  perf-profile.calltrace.cycles-pp.__switch_to
      0.68 ± 99%      +0.9        1.60 ±  3%  perf-profile.calltrace.cycles-pp.native_write_msr
      0.86 ±100%      +0.9        1.79 ±  2%  perf-profile.calltrace.cycles-pp.__switch_to_asm
      6.54            +1.0        7.53 ±  2%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.pipe_wait.pipe_read
     26.96            +1.0       27.95        perf-profile.calltrace.cycles-pp.pipe_read.new_sync_read.vfs_read.ksys_read.do_syscall_64
      1.42 ± 63%      +1.0        2.47 ±  3%  perf-profile.calltrace.cycles-pp.switch_fpu_return.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.54 ±  8%      +1.2        5.79 ±  4%  perf-profile.calltrace.cycles-pp.__schedule.schedule.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.99            +1.3       16.27        perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_wait.pipe_read.new_sync_read
     15.35            +1.3       16.66        perf-profile.calltrace.cycles-pp.schedule.pipe_wait.pipe_read.new_sync_read.vfs_read
     27.37            +1.3       28.70 ±  2%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write.ksys_write
     17.81            +1.6       19.38        perf-profile.calltrace.cycles-pp.pipe_wait.pipe_read.new_sync_read.vfs_read.ksys_read
      3.95 ± 11%      +1.8        5.70 ±  6%  perf-profile.calltrace.cycles-pp.select_idle_sibling.select_task_rq_fair.try_to_wake_up.autoremove_wake_function.__wake_up_common
     23.38            +2.0       25.33 ±  2%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write
     24.30            +2.0       26.27 ±  2%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write
     23.73            +2.0       25.71 ±  2%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write.new_sync_write
      5.24 ± 10%      +2.0        7.25 ±  6%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      3.23 ± 57%      +2.7        5.98 ±  4%  perf-profile.calltrace.cycles-pp.schedule.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.34 ± 57%      +2.8        6.18 ±  4%  perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
     39.37 ±100%     -36.4        2.98 ±173%  perf-profile.children.cycles-pp.start_thread
     21.68 ±100%     -20.0        1.67 ±173%  perf-profile.children.cycles-pp.__GI___libc_write
     16.99 ±100%     -15.7        1.24 ±173%  perf-profile.children.cycles-pp.__GI___libc_read
      6.84 ± 10%      -2.1        4.71        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     45.35            -1.0       44.33        perf-profile.children.cycles-pp.ksys_write
      6.70 ±  5%      -1.0        5.70 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      5.90 ±  4%      -0.6        5.34 ±  6%  perf-profile.children.cycles-pp.security_file_permission
      3.35 ±  9%      -0.6        2.80 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     42.14            -0.5       41.63        perf-profile.children.cycles-pp.vfs_write
      3.41            -0.4        3.01        perf-profile.children.cycles-pp.__fdget_pos
      3.30            -0.4        2.91        perf-profile.children.cycles-pp.__fget_light
      2.71 ±  2%      -0.4        2.32        perf-profile.children.cycles-pp.__fget
      3.23            -0.3        2.93 ±  3%  perf-profile.children.cycles-pp.mutex_lock
      2.76            -0.3        2.47 ±  5%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      2.21 ±  3%      -0.3        1.93 ± 10%  perf-profile.children.cycles-pp.file_has_perm
      3.14            -0.2        2.90 ±  4%  perf-profile.children.cycles-pp.copy_page_to_iter
      3.03 ±  5%      -0.2        2.79 ±  5%  perf-profile.children.cycles-pp.selinux_file_permission
      2.10 ±  5%      -0.2        1.86 ±  2%  perf-profile.children.cycles-pp.mutex_unlock
      1.50 ±  5%      -0.2        1.27 ±  2%  perf-profile.children.cycles-pp.fput_many
      0.68 ± 17%      -0.2        0.48 ±  4%  perf-profile.children.cycles-pp.__mutex_lock
      1.66 ±  2%      -0.2        1.47 ±  4%  perf-profile.children.cycles-pp.copyout
      1.73            -0.2        1.57 ±  2%  perf-profile.children.cycles-pp.update_rq_clock
      1.30            -0.1        1.17 ±  6%  perf-profile.children.cycles-pp.copyin
      0.27 ± 11%      -0.1        0.15 ±  9%  perf-profile.children.cycles-pp.preempt_schedule_common
      1.25 ±  3%      -0.1        1.15 ±  3%  perf-profile.children.cycles-pp.fsnotify
      0.79            -0.1        0.69 ±  7%  perf-profile.children.cycles-pp.reschedule_interrupt
      0.91            -0.1        0.82 ±  5%  perf-profile.children.cycles-pp._cond_resched
      0.80 ±  2%      -0.1        0.71 ±  3%  perf-profile.children.cycles-pp.file_update_time
      0.29 ± 10%      -0.1        0.24 ±  5%  perf-profile.children.cycles-pp.rb_insert_color
      0.26            -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.07 ± 14%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.scheduler_ipi
      0.22 ±  6%      -0.0        0.18 ±  4%  perf-profile.children.cycles-pp.__x64_sys_read
      0.25 ±  4%      -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.27            -0.0        0.23 ±  9%  perf-profile.children.cycles-pp.timespec64_trunc
      0.23 ±  2%      -0.0        0.20 ±  5%  perf-profile.children.cycles-pp.smp_reschedule_interrupt
      0.22            -0.0        0.20 ±  5%  perf-profile.children.cycles-pp.__x64_sys_write
      0.24            -0.0        0.22 ±  3%  perf-profile.children.cycles-pp.__list_add_valid
      0.14            -0.0        0.12 ± 10%  perf-profile.children.cycles-pp.kill_fasync
      0.11 ±  4%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.perf_exclude_event
      0.10            +0.0        0.12 ±  8%  perf-profile.children.cycles-pp.is_cpu_allowed
      0.09 ± 11%      +0.0        0.12 ±  7%  perf-profile.children.cycles-pp.rcu_note_context_switch
      0.07            +0.0        0.10 ± 10%  perf-profile.children.cycles-pp.pkg_thermal_notify
      0.17 ±  3%      +0.0        0.20 ±  9%  perf-profile.children.cycles-pp.deactivate_task
      0.16            +0.0        0.21 ± 10%  perf-profile.children.cycles-pp.update_cfs_rq_h_load
      0.08 ±  6%      +0.0        0.12 ± 10%  perf-profile.children.cycles-pp.intel_thermal_interrupt
      0.08 ±  6%      +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.smp_thermal_interrupt
      0.08            +0.1        0.13 ±  9%  perf-profile.children.cycles-pp.thermal_interrupt
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.default_wake_function
      0.19 ±  5%      +0.1        0.25 ±  5%  perf-profile.children.cycles-pp.wakeup_preempt_entity
      0.19 ±  5%      +0.1        0.27 ±  4%  perf-profile.children.cycles-pp.finish_wait
      0.89 ±  8%      +0.1        0.98        perf-profile.children.cycles-pp.__calc_delta
      0.63 ±  4%      +0.1        0.74 ±  4%  perf-profile.children.cycles-pp.native_sched_clock
      0.33 ±  4%      +0.1        0.44 ±  5%  perf-profile.children.cycles-pp.set_next_buddy
      1.23 ±  3%      +0.1        1.34 ±  3%  perf-profile.children.cycles-pp.check_preempt_wakeup
      0.69 ±  4%      +0.1        0.81 ±  3%  perf-profile.children.cycles-pp.sched_clock
      1.52 ±  3%      +0.1        1.65 ±  2%  perf-profile.children.cycles-pp.set_next_entity
      0.73 ±  4%      +0.1        0.88 ±  3%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.57 ±  4%      +0.2        0.74 ±  4%  perf-profile.children.cycles-pp.account_entity_dequeue
      1.21 ±  4%      +0.2        1.39 ±  2%  perf-profile.children.cycles-pp.__update_load_avg_se
      1.99 ±  3%      +0.2        2.20 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      1.64 ±  6%      +0.2        1.85        perf-profile.children.cycles-pp.__switch_to_asm
      1.60 ±  4%      +0.2        1.85 ±  3%  perf-profile.children.cycles-pp.update_cfs_group
      3.91            +0.2        4.15        perf-profile.children.cycles-pp.update_curr
      1.04 ±  5%      +0.3        1.30 ±  4%  perf-profile.children.cycles-pp.___perf_sw_event
      1.05 ±  9%      +0.3        1.33 ±  2%  perf-profile.children.cycles-pp.pick_next_entity
      1.57 ±  3%      +0.3        1.89        perf-profile.children.cycles-pp.native_write_msr
      1.01 ±  9%      +0.3        1.33 ±  5%  perf-profile.children.cycles-pp.put_prev_entity
      2.17 ±  7%      +0.3        2.51 ±  2%  perf-profile.children.cycles-pp.switch_fpu_return
      1.93 ±  7%      +0.4        2.36        perf-profile.children.cycles-pp.__switch_to
      2.99 ±  4%      +0.6        3.57 ±  2%  perf-profile.children.cycles-pp.reweight_entity
      8.89            +0.6        9.50 ±  2%  perf-profile.children.cycles-pp.enqueue_task_fair
      9.16            +0.7        9.82        perf-profile.children.cycles-pp.ttwu_do_activate
      9.09            +0.7        9.76 ±  2%  perf-profile.children.cycles-pp.activate_task
      5.18 ±  6%      +0.9        6.04 ±  2%  perf-profile.children.cycles-pp.pick_next_task_fair
      6.71            +0.9        7.63 ±  2%  perf-profile.children.cycles-pp.dequeue_task_fair
     28.01            +1.4       29.36 ±  2%  perf-profile.children.cycles-pp.__wake_up_common_lock
      4.91 ±  7%      +1.4        6.28 ±  4%  perf-profile.children.cycles-pp.exit_to_usermode_loop
     18.19            +1.4       19.56        perf-profile.children.cycles-pp.pipe_wait
      4.03 ± 11%      +1.7        5.75 ±  6%  perf-profile.children.cycles-pp.select_idle_sibling
     23.86 ±  2%      +1.8       25.71 ±  2%  perf-profile.children.cycles-pp.try_to_wake_up
     24.44            +1.9       26.36 ±  2%  perf-profile.children.cycles-pp.__wake_up_common
     23.84            +1.9       25.77 ±  2%  perf-profile.children.cycles-pp.autoremove_wake_function
      5.29 ± 10%      +2.0        7.29 ±  6%  perf-profile.children.cycles-pp.select_task_rq_fair
     20.27 ±  2%      +2.3       22.53 ±  2%  perf-profile.children.cycles-pp.__schedule
     20.36 ±  2%      +2.5       22.82 ±  2%  perf-profile.children.cycles-pp.schedule
      6.82 ± 10%      -2.1        4.69        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      2.67 ±  2%      -0.4        2.29        perf-profile.self.cycles-pp.__fget
      2.72            -0.3        2.44 ±  5%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      1.22            -0.2        0.98 ±  2%  perf-profile.self.cycles-pp.update_rq_clock
      1.36 ±  3%      -0.2        1.13 ±  6%  perf-profile.self.cycles-pp.pipe_write
      1.48 ±  5%      -0.2        1.24 ±  3%  perf-profile.self.cycles-pp.fput_many
      2.04 ±  5%      -0.2        1.81 ±  2%  perf-profile.self.cycles-pp.mutex_unlock
      1.96            -0.2        1.73 ±  2%  perf-profile.self.cycles-pp.mutex_lock
      0.66 ± 12%      -0.1        0.53 ± 10%  perf-profile.self.cycles-pp.file_has_perm
      0.38 ± 10%      -0.1        0.28 ±  9%  perf-profile.self.cycles-pp.ksys_read
      0.34 ±  7%      -0.1        0.25 ±  7%  perf-profile.self.cycles-pp.__mutex_lock
      1.21 ±  3%      -0.1        1.11 ±  2%  perf-profile.self.cycles-pp.fsnotify
      1.00            -0.1        0.94 ±  5%  perf-profile.self.cycles-pp.__might_sleep
      0.60 ±  4%      -0.1        0.55 ±  8%  perf-profile.self.cycles-pp.vfs_write
      0.29 ± 10%      -0.1        0.23 ±  3%  perf-profile.self.cycles-pp.rb_insert_color
      0.32 ±  6%      -0.0        0.28 ±  6%  perf-profile.self.cycles-pp.ksys_write
      0.26            -0.0        0.21 ±  2%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.07 ± 14%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.scheduler_ipi
      0.36 ±  5%      -0.0        0.32 ±  8%  perf-profile.self.cycles-pp.__sb_start_write
      0.29            -0.0        0.24 ±  4%  perf-profile.self.cycles-pp.check_preempt_curr
      0.22 ±  6%      -0.0        0.17 ±  6%  perf-profile.self.cycles-pp.__x64_sys_read
      0.25            -0.0        0.21 ±  8%  perf-profile.self.cycles-pp.timespec64_trunc
      0.22 ±  4%      -0.0        0.19 ± 11%  perf-profile.self.cycles-pp.wake_q_add
      0.21 ±  2%      -0.0        0.18 ±  6%  perf-profile.self.cycles-pp.__x64_sys_write
      0.21 ±  2%      -0.0        0.20        perf-profile.self.cycles-pp.__list_add_valid
      0.11 ±  4%      -0.0        0.10 ±  7%  perf-profile.self.cycles-pp.kill_fasync
      0.06 ±  9%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.rcu_note_context_switch
      0.15            +0.0        0.18 ±  6%  perf-profile.self.cycles-pp.autoremove_wake_function
      0.16            +0.0        0.19 ±  9%  perf-profile.self.cycles-pp.deactivate_task
      0.26            +0.0        0.29 ±  5%  perf-profile.self.cycles-pp.rcu_all_qs
      0.33 ±  3%      +0.0        0.37 ±  4%  perf-profile.self.cycles-pp.set_next_entity
      0.18 ±  5%      +0.0        0.22 ±  6%  perf-profile.self.cycles-pp.wakeup_preempt_entity
      0.03 ±100%      +0.0        0.07        perf-profile.self.cycles-pp.check_cfs_rq_runtime
      0.16 ±  6%      +0.0        0.20 ±  6%  perf-profile.self.cycles-pp.exit_to_usermode_loop
      0.16            +0.0        0.20 ± 12%  perf-profile.self.cycles-pp.update_cfs_rq_h_load
      0.20 ±  2%      +0.1        0.25 ±  2%  perf-profile.self.cycles-pp.activate_task
      0.41 ±  6%      +0.1        0.46        perf-profile.self.cycles-pp.schedule
      1.96            +0.1        2.02        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.15 ±  6%      +0.1        0.22        perf-profile.self.cycles-pp.finish_wait
      0.41 ±  4%      +0.1        0.48 ±  6%  perf-profile.self.cycles-pp.account_entity_enqueue
      0.61 ±  4%      +0.1        0.71 ±  3%  perf-profile.self.cycles-pp.native_sched_clock
      0.83 ±  2%      +0.1        0.93        perf-profile.self.cycles-pp.dequeue_task_fair
      0.29 ±  3%      +0.1        0.40 ±  5%  perf-profile.self.cycles-pp.set_next_buddy
      1.02            +0.1        1.15 ±  7%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.46 ± 12%      +0.2        0.61 ±  3%  perf-profile.self.cycles-pp.pick_next_entity
      1.17 ±  4%      +0.2        1.35 ±  2%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.42 ±  8%      +0.2        0.61 ±  5%  perf-profile.self.cycles-pp.account_entity_dequeue
      1.64 ±  6%      +0.2        1.85        perf-profile.self.cycles-pp.__switch_to_asm
      1.23 ±  4%      +0.2        1.46 ±  3%  perf-profile.self.cycles-pp.reweight_entity
      1.07 ±  5%      +0.2        1.31 ±  4%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.90 ±  5%      +0.2        1.14 ±  5%  perf-profile.self.cycles-pp.___perf_sw_event
      1.57 ±  4%      +0.2        1.82 ±  2%  perf-profile.self.cycles-pp.update_cfs_group
      1.17 ±  3%      +0.3        1.42 ±  7%  perf-profile.self.cycles-pp.update_load_avg
      1.56 ±  4%      +0.3        1.88        perf-profile.self.cycles-pp.native_write_msr
      2.16 ±  7%      +0.3        2.50 ±  2%  perf-profile.self.cycles-pp.switch_fpu_return
      1.84 ±  8%      +0.4        2.25 ±  2%  perf-profile.self.cycles-pp.__switch_to
      1.22            +0.5        1.73 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock
      0.92 ± 11%      +1.3        2.27 ±  6%  perf-profile.self.cycles-pp.select_idle_sibling





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Rong Chen


--I4VOKWutKNZEOIPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.3.0-rc1-00065-g3c29e651e16dd"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.3.0-rc1 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.5.0-3) 7.5.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70500
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_HEADER_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_SWAP_ENABLED=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_PV_SMP=y
# CONFIG_XEN_DOM0 is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_512GB=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
# CONFIG_PVH is not set
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
# CONFIG_CALGARY_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
CONFIG_X86_INTEL_MPX=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
CONFIG_KEXEC_VERIFY_SIG=y
CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_DPTF_POWER is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

CONFIG_X86_DEV_DMA_OPS=y

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
CONFIG_KVM_AMD=m
CONFIG_KVM_AMD_SEV=y
CONFIG_KVM_MMU_AUDIT=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
CONFIG_VHOST=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_64BIT_TIME=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y

#
# GCC plugins
#
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
# end of GCC plugins
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_ZSWAP=y
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM_MIRROR=y
# CONFIG_DEVICE_PRIVATE is not set
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
# CONFIG_INET_ESP_OFFLOAD is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
# CONFIG_TCP_CONG_BBR is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
# CONFIG_INET6_ESP_OFFLOAD is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
CONFIG_NETLABEL=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
# CONFIG_NF_TABLES_SET is not set
# CONFIG_NF_TABLES_INET is not set
# CONFIG_NF_TABLES_NETDEV is not set
# CONFIG_NFT_NUMGEN is not set
CONFIG_NFT_CT=m
CONFIG_NFT_COUNTER=m
# CONFIG_NFT_CONNLIMIT is not set
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
# CONFIG_NFT_TUNNEL is not set
# CONFIG_NFT_OBJREF is not set
CONFIG_NFT_QUEUE=m
# CONFIG_NFT_QUOTA is not set
CONFIG_NFT_REJECT=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
# CONFIG_NFT_XFRM is not set
# CONFIG_NFT_SOCKET is not set
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
# CONFIG_IP_VS_FO is not set
# CONFIG_IP_VS_OVF is not set
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
# CONFIG_NF_TABLES_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_DUP_IPV4=m
# CONFIG_NF_LOG_ARP is not set
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
# CONFIG_NF_TABLES_IPV6 is not set
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
# CONFIG_NF_TABLES_BRIDGE is not set
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
CONFIG_6LOWPAN_NHC=m
CONFIG_6LOWPAN_NHC_DEST=m
CONFIG_6LOWPAN_NHC_FRAGMENT=m
CONFIG_6LOWPAN_NHC_HOP=m
CONFIG_6LOWPAN_NHC_IPV6=m
CONFIG_6LOWPAN_NHC_MOBILITY=m
CONFIG_6LOWPAN_NHC_ROUTING=m
CONFIG_6LOWPAN_NHC_UDP=m
# CONFIG_6LOWPAN_GHC_EXT_HDR_HOP is not set
# CONFIG_6LOWPAN_GHC_UDP is not set
# CONFIG_6LOWPAN_GHC_ICMPV6 is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_DEST is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
# CONFIG_NET_ACT_BPF is not set
CONFIG_NET_ACT_CONNMARK=m
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_CT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_EMS_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PLX_PCI=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
CONFIG_CAN_8DEV_USB=m
CONFIG_CAN_EMS_USB=m
CONFIG_CAN_ESD_USB2=m
# CONFIG_CAN_GS_USB is not set
CONFIG_CAN_KVASER_USB=m
# CONFIG_CAN_MCBA_USB is not set
CONFIG_CAN_PEAK_USB=m
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_CMTP=m
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_DEBUGFS=y

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_RTL=m
CONFIG_BT_HCIBTUSB=m
# CONFIG_BT_HCIBTUSB_AUTOSUSPEND is not set
CONFIG_BT_HCIBTUSB_BCM=y
# CONFIG_BT_HCIBTUSB_MTK is not set
CONFIG_BT_HCIBTUSB_RTL=y
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_BT_ATH3K=m
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_LIB80211=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_BW is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
# CONFIG_PCI_PF_STUB is not set
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support

CONFIG_VMD=y

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_AR7_PARTS is not set

#
# Partition parsers
#
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_RAW_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_MTD_HYPERBUS is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=y
# CONFIG_VIRTIO_BLK_SCSI is not set
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_SGI_IOC4=m
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# end of Intel MIC & related support

# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_SCSI_UFS_BSG is not set
CONFIG_SCSI_HPTIOP=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=m
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
CONFIG_TCM_QLA2XXX=m
# CONFIG_TCM_QLA2XXX_DEBUG is not set
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_QEDI is not set
# CONFIG_QEDF is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=m
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=m
CONFIG_PATA_CMD64X=m
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
# CONFIG_PATA_HPT3X3_DMA is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=m
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=m
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
# CONFIG_PATA_RADISYS is not set
CONFIG_PATA_RDC=m
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=m
CONFIG_PATA_TOSHIBA=m
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_VIA=m
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=m
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
# CONFIG_MD_CLUSTER is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
# CONFIG_DM_WRITECACHE is not set
CONFIG_DM_ERA=m
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
# CONFIG_DM_ZONED is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
CONFIG_ISCSI_TARGET_CXGB4=m
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
CONFIG_IFB=m
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=m
CONFIG_GENEVE=m
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_NTB_NETDEV=m
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
CONFIG_NLMON=m
CONFIG_NET_VRF=y
CONFIG_VSOCKMON=m
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_ENA_ETHERNET=m
CONFIG_NET_VENDOR_AMD=y
CONFIG_AMD8111_ETH=m
CONFIG_PCNET32=m
CONFIG_AMD_XGBE=m
# CONFIG_AMD_XGBE_DCB is not set
CONFIG_AMD_XGBE_HAVE_ECC=y
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_AQTION=m
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=m
CONFIG_ATL1=m
CONFIG_ATL1E=m
CONFIG_ATL1C=m
CONFIG_ALX=m
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
CONFIG_BNX2=m
CONFIG_CNIC=m
CONFIG_TIGON3=y
CONFIG_TIGON3_HWMON=y
CONFIG_BNX2X=m
CONFIG_BNX2X_SRIOV=y
# CONFIG_SYSTEMPORT is not set
CONFIG_BNXT=m
CONFIG_BNXT_SRIOV=y
CONFIG_BNXT_FLOWER_OFFLOAD=y
CONFIG_BNXT_DCB=y
CONFIG_BNXT_HWMON=y
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_MACB=m
CONFIG_MACB_USE_HWSTAMP=y
# CONFIG_MACB_PCI is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
CONFIG_LIQUIDIO=m
CONFIG_LIQUIDIO_VF=m
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
# CONFIG_CHELSIO_T4_DCB is not set
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_DE2104X_DSL=0
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_ULI526X=m
CONFIG_PCMCIA_XIRCOM=m
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
# CONFIG_NET_VENDOR_HP is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=m
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBEVF=m
CONFIG_I40E=y
CONFIG_I40E_DCB=y
CONFIG_IAVF=m
CONFIG_I40EVF=m
# CONFIG_ICE is not set
CONFIG_FM10K=m
# CONFIG_IGC is not set
CONFIG_JME=m
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
CONFIG_SKGE=y
# CONFIG_SKGE_DEBUG is not set
CONFIG_SKGE_GENESIS=y
CONFIG_SKY2=m
# CONFIG_SKY2_DEBUG is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
# CONFIG_MSCC_OCELOT_SWITCH is not set
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
CONFIG_MYRI10GE_DCA=y
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NFP=m
CONFIG_NFP_APP_FLOWER=y
CONFIG_NFP_APP_ABM_NIC=y
# CONFIG_NFP_DEBUG is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=m
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
CONFIG_YELLOWFIN=m
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
CONFIG_QLGE=m
CONFIG_NETXEN_NIC=m
CONFIG_QED=m
CONFIG_QED_SRIOV=y
CONFIG_QEDE=m
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
CONFIG_8139CP=y
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_ROCKER=m
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
CONFIG_SFC_FALCON=m
CONFIG_SFC_FALCON_MTD=y
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=m
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=m
CONFIG_NET_VENDOR_SOCIONEXT=y
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
CONFIG_TLAN=m
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
# CONFIG_MDIO_BCM_UNIMAC is not set
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_GPIO is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=m
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
CONFIG_AT803X_PHY=m
# CONFIG_BCM7XXX_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_BROADCOM_PHY=m
CONFIG_CICADA_PHY=m
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=m
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=m
# CONFIG_INTEL_XWAY_PHY is not set
CONFIG_LSI_ET1011C_PHY=m
CONFIG_LXT_PHY=m
CONFIG_MARVELL_PHY=m
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=m
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
CONFIG_NATIONAL_PHY=m
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
# CONFIG_TERANETICS_PHY is not set
CONFIG_VITESSE_PHY=m
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=y
CONFIG_USB_RTL8152=m
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=m
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=y
CONFIG_USB_NET_CDC_NCM=m
CONFIG_USB_NET_HUAWEI_CDC_NCM=m
CONFIG_USB_NET_CDC_MBIM=m
CONFIG_USB_NET_DM9601=y
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=y
CONFIG_USB_NET_SMSC95XX=y
CONFIG_USB_NET_GL620A=y
CONFIG_USB_NET_NET1080=y
CONFIG_USB_NET_PLUSB=y
CONFIG_USB_NET_MCS7830=y
CONFIG_USB_NET_RNDIS_HOST=y
CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
CONFIG_USB_NET_CDC_SUBSET=y
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=y
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
CONFIG_USB_NET_INT51X1=y
CONFIG_USB_IPHETH=y
CONFIG_USB_SIERRA_NET=y
CONFIG_USB_VL600=m
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_ATH_COMMON=m
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_ATH9K_HW=m
CONFIG_ATH9K_COMMON=m
CONFIG_ATH9K_BTCOEX_SUPPORT=y
# CONFIG_ATH9K is not set
CONFIG_ATH9K_HTC=m
# CONFIG_ATH9K_HTC_DEBUGFS is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
CONFIG_IWLEGACY=m
CONFIG_IWL4965=m
CONFIG_IWL3945=m

#
# iwl3945 / iwl4965 Debugging Options
#
CONFIG_IWLEGACY_DEBUG=y
CONFIG_IWLEGACY_DEBUGFS=y
# end of iwl3945 / iwl4965 Debugging Options

CONFIG_IWLWIFI=m
CONFIG_IWLWIFI_LEDS=y
CONFIG_IWLDVM=m
CONFIG_IWLMVM=m
CONFIG_IWLWIFI_OPMODE_MODULAR=y
# CONFIG_IWLWIFI_BCAST_FILTERING is not set
# CONFIG_IWLWIFI_PCIE_RTPM is not set

#
# Debugging Options
#
# CONFIG_IWLWIFI_DEBUG is not set
CONFIG_IWLWIFI_DEBUGFS=y
# CONFIG_IWLWIFI_DEVICE_TRACING is not set
# end of Debugging Options

CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
# CONFIG_RTL_CARDS is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
# CONFIG_HDLC_RAW_ETH is not set
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m

#
# X.25/LAPB support is disabled
#
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
# CONFIG_DSCC4 is not set
CONFIG_DLCI=m
CONFIG_DLCI_MAX=8
# CONFIG_SBNI is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=m
CONFIG_VMXNET3=m
CONFIG_FUJITSU_ES=m
CONFIG_THUNDERBOLT_NET=m
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
CONFIG_ISDN=y
CONFIG_ISDN_CAPI=m
# CONFIG_CAPI_TRACE is not set
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_MISDN=m
CONFIG_MISDN_DSP=m
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=m
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_HFCUSB=m
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_HDLC=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
CONFIG_TABLET_USB_GTCO=m
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=m
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ADC is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
# CONFIG_TOUCHSCREEN_IQS5XX is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_MSM_VIBRATOR is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
CONFIG_INPUT_GP2A=m
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_UINPUT=m
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=m
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SPI is not set
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F54 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
CONFIG_NOZOMI=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
# CONFIG_TRACE_SINK is not set
# CONFIG_NULL_TTY is not set
CONFIG_LDISC_AUTOLOAD=y
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=y
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_DP83640_PHY=m
CONFIG_PTP_1588_CLOCK_KVM=m
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
CONFIG_PINCTRL_INTEL=m
# CONFIG_PINCTRL_BROXTON is not set
CONFIG_PINCTRL_CANNONLAKE=m
# CONFIG_PINCTRL_CEDARFORK is not set
CONFIG_PINCTRL_DENVERTON=m
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_LYNXPOINT is not set
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=m
# end of USB GPIO expanders

CONFIG_GPIO_MOCKUP=y
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=m
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=y
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=m
CONFIG_IR_ENE=m
CONFIG_IR_IMON=m
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_MCEUSB=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
CONFIG_IR_REDRAT3=m
CONFIG_IR_STREAMZAP=m
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=m
CONFIG_IR_TTUSBIR=m
CONFIG_RC_LOOPBACK=m
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
# CONFIG_RC_XBOX_DVD is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_CONTROLLER=y
CONFIG_MEDIA_CONTROLLER_DVB=y
CONFIG_VIDEO_DEV=m
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
CONFIG_VIDEO_V4L2=m
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_VIDEOBUF_VMALLOC=m
CONFIG_DVB_CORE=m
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_TTPCI_EEPROM=m
CONFIG_DVB_MAX_ADAPTERS=8
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_GSPCA=m
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_GL860=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
CONFIG_USB_GSPCA_CPIA1=m
# CONFIG_USB_GSPCA_DTCS033 is not set
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
# CONFIG_USB_GSPCA_KINECT is not set
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA500=m
CONFIG_USB_GSPCA_SPCA501=m
CONFIG_USB_GSPCA_SPCA505=m
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SPCA1528=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
# CONFIG_USB_GSPCA_STK1135 is not set
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
# CONFIG_USB_GSPCA_TOUPTEK is not set
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m
# CONFIG_VIDEO_USBTV is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=m
CONFIG_VIDEO_USBVISION=m
# CONFIG_VIDEO_STK1160_COMMON is not set
# CONFIG_VIDEO_GO7007 is not set

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y
# CONFIG_VIDEO_AU0828_RC is not set
CONFIG_VIDEO_CX231XX=m
CONFIG_VIDEO_CX231XX_RC=y
CONFIG_VIDEO_CX231XX_ALSA=m
CONFIG_VIDEO_CX231XX_DVB=m
CONFIG_VIDEO_TM6000=m
CONFIG_VIDEO_TM6000_ALSA=m
CONFIG_VIDEO_TM6000_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_CXUSB=m
# CONFIG_DVB_USB_CXUSB_ANALOG is not set
CONFIG_DVB_USB_M920X=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_VP7045=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_TTUSB2=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_USB_OPERA1=m
CONFIG_DVB_USB_AF9005=m
CONFIG_DVB_USB_AF9005_REMOTE=m
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_DW2102=m
CONFIG_DVB_USB_CINERGY_T2=m
CONFIG_DVB_USB_DTV5100=m
CONFIG_DVB_USB_AZ6027=m
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
CONFIG_DVB_USB_AZ6007=m
CONFIG_DVB_USB_CE6230=m
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
# CONFIG_DVB_USB_DVBSKY is not set
# CONFIG_DVB_USB_ZD1301 is not set
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
# CONFIG_VIDEO_EM28XX_V4L2 is not set
CONFIG_VIDEO_EM28XX_ALSA=m
CONFIG_VIDEO_EM28XX_DVB=m
CONFIG_VIDEO_EM28XX_RC=m
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_MEYE is not set
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_TW686X is not set

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=m
# CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
# CONFIG_VIDEO_IVTV_ALSA is not set
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_FB_IVTV_FORCE_PAT is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DT3155 is not set

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
CONFIG_VIDEO_CX23885=m
CONFIG_MEDIA_ALTERA_CI=m
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m
CONFIG_VIDEO_CX88_ENABLE_VP3054=y
CONFIG_VIDEO_CX88_VP3054=m
CONFIG_VIDEO_CX88_MPEG=m
CONFIG_VIDEO_BT848=m
CONFIG_DVB_BT8XX=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110_IR=y
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_BUDGET_PATCH=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_DM1105=m
CONFIG_DVB_PT1=m
# CONFIG_DVB_PT3 is not set
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_DVB_NETUP_UNIDVB is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=m
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set

#
# Texas Instruments WL128x FM driver (ST based)
#
# end of Texas Instruments WL128x FM driver (ST based)

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
# CONFIG_SMS_SIANO_DEBUGFS is not set

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_TDA7432=m
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m
# CONFIG_VIDEO_SONY_BTF_MPX is not set

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
CONFIG_VIDEO_SAA711X=m
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set

#
# Camera sensor devices
#
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_RJ54N1 is not set

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
CONFIG_VIDEO_M52790=m
# CONFIG_VIDEO_I2C is not set
# end of I2C Encoders, decoders, sensors and other helper chips

#
# SPI helper chips
#
# end of SPI helper chips

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
# CONFIG_MEDIA_TUNER_MSI001 is not set
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
# CONFIG_MEDIA_TUNER_MXL301RF is not set
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
# CONFIG_DVB_S5H1432 is not set
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
# CONFIG_DVB_DIB9000 is not set
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_SI2168=m
# CONFIG_DVB_ZD1301_DEMOD is not set
CONFIG_DVB_GP8PSK_FE=m
# CONFIG_DVB_CXD2880 is not set

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
# CONFIG_DVB_MN88443X is not set

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
# CONFIG_DVB_LNBH29 is not set
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
# CONFIG_DVB_LGS8GL5 is not set
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
# CONFIG_DVB_HORUS3A is not set
# CONFIG_DVB_ASCOT2E is not set
# CONFIG_DVB_HELENE is not set

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
# CONFIG_DVB_SP2 is not set

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m
# end of Customise DVB Frontends

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#
# end of ACP (Audio CoProcessor) Configuration

# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_SPIN_REQUEST=5
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_CIRRUS_QEMU=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_TINYDRM is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m
# CONFIG_SND_PORTMAN2X4 is not set
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=5
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
CONFIG_SND_ES1968_RADIO=y
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=m
# CONFIG_SND_RIPTIDE is not set
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=512
# CONFIG_SND_SPI is not set
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
CONFIG_SND_USB_HIFACE=m
CONFIG_SND_BCD2000=m
CONFIG_SND_USB_LINE6=m
CONFIG_SND_USB_POD=m
CONFIG_SND_USB_PODHD=m
CONFIG_SND_USB_TONEPORT=m
CONFIG_SND_USB_VARIAX=m
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
# CONFIG_SND_DICE is not set
# CONFIG_SND_OXFW is not set
CONFIG_SND_ISIGHT=m
# CONFIG_SND_FIREWORKS is not set
# CONFIG_SND_BEBOB is not set
# CONFIG_SND_FIREWIRE_DIGI00X is not set
# CONFIG_SND_FIREWIRE_TASCAM is not set
# CONFIG_SND_FIREWIRE_MOTU is not set
# CONFIG_SND_FIREFACE is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=m
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_I2S_HI6210_I2S is not set
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_IPC=m
CONFIG_SND_SST_IPC_ACPI=m
CONFIG_SND_SOC_INTEL_SST_ACPI=m
CONFIG_SND_SOC_INTEL_SST=m
CONFIG_SND_SOC_INTEL_SST_FIRMWARE=m
CONFIG_SND_SOC_INTEL_HASWELL=m
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
CONFIG_SND_SOC_INTEL_SKYLAKE=m
CONFIG_SND_SOC_INTEL_SKL=m
CONFIG_SND_SOC_INTEL_APL=m
CONFIG_SND_SOC_INTEL_KBL=m
CONFIG_SND_SOC_INTEL_GLK=m
CONFIG_SND_SOC_INTEL_CNL=m
CONFIG_SND_SOC_INTEL_CFL=m
# CONFIG_SND_SOC_INTEL_CML_H is not set
# CONFIG_SND_SOC_INTEL_CML_LP is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=m
CONFIG_SND_SOC_INTEL_SKYLAKE_SSP_CLK=m
# CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=m
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_INTEL_HASWELL_MACH=m
CONFIG_SND_SOC_INTEL_BDW_RT5677_MACH=m
CONFIG_SND_SOC_INTEL_BROADWELL_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=m
# CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH is not set
# CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH is not set
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH=m
CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH=m
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH is not set
# CONFIG_SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
# CONFIG_SND_SOC_XILINX_SPDIF is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
# CONFIG_ZX_TDM is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
# CONFIG_SND_SOC_ADAU1701 is not set
# CONFIG_SND_SOC_ADAU1761_I2C is not set
# CONFIG_SND_SOC_ADAU1761_SPI is not set
# CONFIG_SND_SOC_ADAU7002 is not set
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
# CONFIG_SND_SOC_AK4458 is not set
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
# CONFIG_SND_SOC_AK5558 is not set
# CONFIG_SND_SOC_ALC5623 is not set
# CONFIG_SND_SOC_BD28623 is not set
# CONFIG_SND_SOC_BT_SCO is not set
# CONFIG_SND_SOC_CS35L32 is not set
# CONFIG_SND_SOC_CS35L33 is not set
# CONFIG_SND_SOC_CS35L34 is not set
# CONFIG_SND_SOC_CS35L35 is not set
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS42L42 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
# CONFIG_SND_SOC_CS4265 is not set
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS4271_SPI is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_CS53L30 is not set
# CONFIG_SND_SOC_CX2072X is not set
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DMIC=m
# CONFIG_SND_SOC_ES7134 is not set
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8316=m
# CONFIG_SND_SOC_ES8328_I2C is not set
# CONFIG_SND_SOC_ES8328_SPI is not set
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDAC_HDMI=m
# CONFIG_SND_SOC_INNO_RK3036 is not set
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98357A=m
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=m
# CONFIG_SND_SOC_MAX98373 is not set
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
# CONFIG_SND_SOC_PCM1789_I2C is not set
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM179X_SPI is not set
# CONFIG_SND_SOC_PCM186X_I2C is not set
# CONFIG_SND_SOC_PCM186X_SPI is not set
# CONFIG_SND_SOC_PCM3060_I2C is not set
# CONFIG_SND_SOC_PCM3060_SPI is not set
# CONFIG_SND_SOC_PCM3168A_I2C is not set
# CONFIG_SND_SOC_PCM3168A_SPI is not set
# CONFIG_SND_SOC_PCM512x_I2C is not set
# CONFIG_SND_SOC_PCM512x_SPI is not set
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RL6347A=m
CONFIG_SND_SOC_RT286=m
CONFIG_SND_SOC_RT298=m
CONFIG_SND_SOC_RT5514=m
CONFIG_SND_SOC_RT5514_SPI=m
# CONFIG_SND_SOC_RT5616 is not set
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_RT5651=m
CONFIG_SND_SOC_RT5663=m
CONFIG_SND_SOC_RT5670=m
CONFIG_SND_SOC_RT5677=m
CONFIG_SND_SOC_RT5677_SPI=m
# CONFIG_SND_SOC_SGTL5000 is not set
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
# CONFIG_SND_SOC_SIRF_AUDIO_CODEC is not set
# CONFIG_SND_SOC_SPDIF is not set
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=m
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
# CONFIG_SND_SOC_TAS5720 is not set
# CONFIG_SND_SOC_TAS6424 is not set
# CONFIG_SND_SOC_TDA7419 is not set
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
# CONFIG_SND_SOC_TLV320AIC3X is not set
CONFIG_SND_SOC_TS3A227E=m
# CONFIG_SND_SOC_TSCS42XX is not set
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
# CONFIG_SND_SOC_WM8524 is not set
# CONFIG_SND_SOC_WM8580 is not set
# CONFIG_SND_SOC_WM8711 is not set
# CONFIG_SND_SOC_WM8728 is not set
# CONFIG_SND_SOC_WM8731 is not set
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
# CONFIG_SND_SOC_WM8750 is not set
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8770 is not set
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8782 is not set
# CONFIG_SND_SOC_WM8804_I2C is not set
# CONFIG_SND_SOC_WM8804_SPI is not set
# CONFIG_SND_SOC_WM8903 is not set
# CONFIG_SND_SOC_WM8904 is not set
# CONFIG_SND_SOC_WM8960 is not set
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8974 is not set
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_WM8985 is not set
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
# CONFIG_SND_SOC_MAX9759 is not set
# CONFIG_SND_SOC_MT6351 is not set
# CONFIG_SND_SOC_MT6358 is not set
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
# CONFIG_SND_SOC_NAU8822 is not set
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_NAU8825=m
# CONFIG_SND_SOC_TPA6130A2 is not set
# end of CODEC drivers

# CONFIG_SND_SIMPLE_CARD is not set
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=m
CONFIG_SND_SYNTH_EMUX=m
# CONFIG_SND_XEN_FRONTEND is not set
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=m
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_PRODIKEYS=m
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=m
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=y
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y
CONFIG_USB_WUSB=m
CONFIG_USB_WUSB_CBAF=m
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=m
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USBIP_CORE=m
# CONFIG_USBIP_VHCI_HCD is not set
# CONFIG_USBIP_HOST is not set
# CONFIG_USBIP_DEBUG is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
# CONFIG_USB_SERIAL_MXUPORT is not set
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
# CONFIG_USB_RIO500 is not set
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_SISUSBVGA_CON=y
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=m
CONFIG_UWB_HWA=m
CONFIG_UWB_WHCI=m
CONFIG_UWB_I1480U=m
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
# CONFIG_RTC_DRV_BD70528 is not set
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RX6110 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_INTEL_IDMA64 is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# end of DMABUF options

CONFIG_DCA=m
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_PARPORT_PANEL is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_TSCPAGE=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_HAVE_VPMU=y
# end of Xen driver support

CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m
# CONFIG_RTL8723BS is not set
CONFIG_R8712U=m
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
# CONFIG_ADIS16240 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7816 is not set
# CONFIG_AD7192 is not set
# CONFIG_AD7280 is not set
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
# CONFIG_AD9832 is not set
# CONFIG_AD9834 is not set
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
# CONFIG_AD2S1210 is not set
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# end of Speakup console speech

# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
# CONFIG_ANDROID_VSOC is not set
CONFIG_ION=y
CONFIG_ION_SYSTEM_HEAP=y
# CONFIG_ION_CMA_HEAP is not set
# end of Android

# CONFIG_LTE_GDM724X is not set
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
# CONFIG_MOST is not set
# CONFIG_KS7010 is not set
# CONFIG_GREYBUS is not set
# CONFIG_PI433 is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# end of Gasket devices

# CONFIG_EROFS_FS is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set

#
# ISDN CAPI drivers
#
CONFIG_CAPI_AVM=y
CONFIG_ISDN_DRV_AVMB1_B1PCI=m
CONFIG_ISDN_DRV_AVMB1_B1PCIV4=y
CONFIG_ISDN_DRV_AVMB1_T1PCI=m
CONFIG_ISDN_DRV_AVMB1_C4=m
CONFIG_ISDN_DRV_GIGASET=m
CONFIG_GIGASET_CAPI=y
CONFIG_GIGASET_BASE=m
CONFIG_GIGASET_M105=m
CONFIG_GIGASET_M101=m
# CONFIG_GIGASET_DEBUG is not set
CONFIG_HYSDN=m
CONFIG_HYSDN_CAPI=y
# end of ISDN CAPI drivers

CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACERHDF=m
# CONFIG_ALIENWARE_WMI is not set
CONFIG_ASUS_LAPTOP=m
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
CONFIG_DELL_SMBIOS_SMM=y
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_WMI=m
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=m
# CONFIG_DELL_WMI_LED is not set
CONFIG_DELL_SMO8800=m
CONFIG_DELL_RBTN=m
CONFIG_DELL_RBU=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_AMILO_RFKILL=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_LG_LAPTOP is not set
CONFIG_MSI_LAPTOP=m
CONFIG_PANASONIC_LAPTOP=m
CONFIG_COMPAL_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_SURFACE3_WMI is not set
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_SENSORS_HDAPS=m
# CONFIG_INTEL_MENLOW is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_WMI=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
CONFIG_INTEL_WMI_THUNDERBOLT=m
# CONFIG_XIAOMI_WMI is not set
CONFIG_MSI_WMI=m
# CONFIG_PEAQ_WMI is not set
CONFIG_TOPSTAR_LAPTOP=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_PMC_CORE=m
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_MXM_WMI=m
CONFIG_INTEL_OAKTRAIL=m
CONFIG_SAMSUNG_Q10=m
CONFIG_APPLE_GMUX=m
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_TURBO_MAX_3 is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_HUAWEI_WMI is not set
# CONFIG_PCENGINES_APU2 is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# end of Common Clock Framework

# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# IXP4xx SoC drivers
#
# CONFIG_IXP4XX_QMGR is not set
# CONFIG_IXP4XX_NPE is not set
# end of IXP4xx SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=m
# CONFIG_IIO_CONFIGFS is not set
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
# CONFIG_IIO_SW_TRIGGER is not set

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16209 is not set
# CONFIG_ADXL345_I2C is not set
# CONFIG_ADXL345_SPI is not set
# CONFIG_ADXL372_SPI is not set
# CONFIG_ADXL372_I2C is not set
# CONFIG_BMA180 is not set
# CONFIG_BMA220 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
CONFIG_HID_SENSOR_ACCEL_3D=m
# CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7455_SPI is not set
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
# CONFIG_MXC4005 is not set
# CONFIG_MXC6255 is not set
# CONFIG_SCA3000 is not set
# CONFIG_STK8312 is not set
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7124 is not set
# CONFIG_AD7266 is not set
# CONFIG_AD7291 is not set
# CONFIG_AD7298 is not set
# CONFIG_AD7476 is not set
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD7606_IFACE_SPI is not set
# CONFIG_AD7766 is not set
# CONFIG_AD7768_1 is not set
# CONFIG_AD7780 is not set
# CONFIG_AD7791 is not set
# CONFIG_AD7793 is not set
# CONFIG_AD7887 is not set
# CONFIG_AD7923 is not set
# CONFIG_AD7949 is not set
# CONFIG_AD799X is not set
# CONFIG_HI8435 is not set
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
# CONFIG_LTC2471 is not set
# CONFIG_LTC2485 is not set
# CONFIG_LTC2497 is not set
# CONFIG_MAX1027 is not set
# CONFIG_MAX11100 is not set
# CONFIG_MAX1118 is not set
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
# CONFIG_MCP320X is not set
# CONFIG_MCP3422 is not set
# CONFIG_MCP3911 is not set
# CONFIG_NAU7802 is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
# CONFIG_TI_ADC108S102 is not set
# CONFIG_TI_ADC128S052 is not set
# CONFIG_TI_ADC161S626 is not set
# CONFIG_TI_ADS1015 is not set
# CONFIG_TI_ADS7950 is not set
# CONFIG_TI_TLC4541 is not set
# CONFIG_VIPERBOARD_ADC is not set
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog Front Ends
#
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_AD8366 is not set
# end of Amplifiers

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
# CONFIG_BME680 is not set
# CONFIG_CCS811 is not set
# CONFIG_IAQCORE is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SPS30 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
# end of Hid Sensor IIO Common

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5421 is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5449 is not set
# CONFIG_AD5592R is not set
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
# CONFIG_LTC1660 is not set
# CONFIG_LTC2632 is not set
# CONFIG_AD5686_SPI is not set
# CONFIG_AD5696_I2C is not set
# CONFIG_AD5755 is not set
# CONFIG_AD5758 is not set
# CONFIG_AD5761 is not set
# CONFIG_AD5764 is not set
# CONFIG_AD5791 is not set
# CONFIG_AD7303 is not set
# CONFIG_AD8801 is not set
# CONFIG_DS4424 is not set
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
# CONFIG_MCP4725 is not set
# CONFIG_MCP4922 is not set
# CONFIG_TI_DAC082S085 is not set
# CONFIG_TI_DAC5571 is not set
# CONFIG_TI_DAC7311 is not set
# CONFIG_TI_DAC7612 is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set
# CONFIG_ADF4371 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16136 is not set
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS450 is not set
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
CONFIG_HID_SENSOR_GYRO_3D=m
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
# CONFIG_HID_SENSOR_HUMIDITY is not set
# CONFIG_HTS221 is not set
# CONFIG_HTU21 is not set
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
# CONFIG_ADIS16480 is not set
# CONFIG_BMI160_I2C is not set
# CONFIG_BMI160_SPI is not set
# CONFIG_KMX61 is not set
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_INV_MPU6050_SPI is not set
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=m
CONFIG_HID_SENSOR_PROX=m
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
# CONFIG_LTR501 is not set
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
# CONFIG_SI1133 is not set
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
# CONFIG_TSL2772 is not set
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6070 is not set
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_BMC150_MAGN_SPI is not set
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_HMC5843_SPI is not set
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_SENSORS_RM3100_SPI is not set
# end of Magnetometer sensors

#
# Multiplexers
#
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
CONFIG_HID_SENSOR_DEVICE_ROTATION=m
# end of Inclinometer sensors

#
# Triggers - standalone
#
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
# CONFIG_MAX5481 is not set
# CONFIG_MAX5487 is not set
# CONFIG_MCP4018 is not set
# CONFIG_MCP4131 is not set
# CONFIG_MCP4531 is not set
# CONFIG_MCP41010 is not set
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
# CONFIG_BMP280 is not set
# CONFIG_DPS310 is not set
CONFIG_HID_SENSOR_PRESS=m
# CONFIG_HP03 is not set
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL115_SPI is not set
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# CONFIG_AS3935 is not set
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
# CONFIG_LIDAR_LITE_V2 is not set
# CONFIG_MB1232 is not set
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
# CONFIG_AD2S1200 is not set
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_MAXIM_THERMOCOUPLE is not set
# CONFIG_HID_SENSOR_TEMP is not set
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
# CONFIG_TMP006 is not set
# CONFIG_TMP007 is not set
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# CONFIG_MAX31856 is not set
# end of Temperature sensors

CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
CONFIG_NTB_AMD=m
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
CONFIG_NTB_PERF=m
CONFIG_NTB_TRANSPORT=m
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
CONFIG_THUNDERBOLT=y

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=m
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=m
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=m
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
# CONFIG_NFSD_FAULT_INJECTION is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=m

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECRDSA is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128L is not set
# CONFIG_CRYPTO_AEGIS256 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS256_AESNI_SSE2 is not set
# CONFIG_CRYPTO_MORUS640 is not set
# CONFIG_CRYPTO_MORUS640_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280 is not set
# CONFIG_CRYPTO_MORUS1280_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280_AVX2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
# CONFIG_CRYPTO_XXHASH is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=m
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=m
# CONFIG_CRYPTO_USER_API_AEAD is not set
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
CONFIG_CRYPTO_DEV_CHELSIO=m
CONFIG_CRYPTO_DEV_VIRTIO=m
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_BTF is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_INSTALL is not set
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_CC_HAS_KASAN_GENERIC=y
# CONFIG_KASAN is not set
CONFIG_KASAN_STACK=1
# end of Memory Debugging

CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# end of Debug Lockups and Hangs

CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=m
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_STACK_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FUNCTION_PROFILER=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=m
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_UBSAN_ALIGNMENT=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set
# end of Kernel hacking

--I4VOKWutKNZEOIPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='hackbench'
	export testcase='hackbench'
	export category='benchmark'
	export disable_latency_stats=1
	export nr_threads=16
	export job_origin='/lkp/lkp/.src-20200203-231712/allot/cyclic:p1:linux-devel:devel-hourly/lkp-cfl-e1/hackbench-100.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-cfl-e1'
	export tbox_group='lkp-cfl-e1'
	export submit_id='5e39ee9328d98b1cd50e0381'
	export job_file='/lkp/jobs/scheduled/lkp-cfl-e1/hackbench-performance-pipe-threads-100%-ucode=0xca-debian-x86_64-20191114.cgz-3c29e651e16dd3b3179cfb2d055ee9538e37515c-20200205-7381-mzci5z-3.yaml'
	export id='fa9667ac7a567c8dbc9d9677420cebcb0ef07705'
	export queuer_version='/lkp-src'
	export arch='x86_64'
	export model='Coffee Lake'
	export nr_node=1
	export nr_cpu=16
	export memory='32G'
	export nr_hdd_partitions=1
	export hdd_partitions='/dev/disk/by-id/ata-WDC_WD1005FBYZ-01YCBB1_WD-WMC6M0D4MD6W-part2'
	export swap_partitions='LABEL=SWAP'
	export rootfs_partition='/dev/disk/by-id/ata-WDC_WD1005FBYZ-01YCBB1_WD-WMC6M0D4MD6W-part1'
	export brand='Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz'
	export commit='3c29e651e16dd3b3179cfb2d055ee9538e37515c'
	export ucode='0xca'
	export need_kconfig_hw='CONFIG_IGB=y
CONFIG_SATA_AHCI'
	export kconfig='x86_64-rhel-7.6'
	export compiler='gcc-7'
	export enqueue_time='2020-02-05 06:22:45 +0800'
	export _id='5e39eeb528d98b1cd50e0382'
	export _rt='/result/hackbench/performance-pipe-threads-100%-ucode=0xca/lkp-cfl-e1/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/3c29e651e16dd3b3179cfb2d055ee9538e37515c'
	export user='lkp'
	export head_commit='12be34e47b2e41897ed73b235a3ef57cc6ee0bfd'
	export base_commit='d5226fa6dbae0569ee43ecfc08bdcd6770fc4755'
	export branch='linux-devel/devel-hourly-2020020403'
	export rootfs='debian-x86_64-20191114.cgz'
	export result_root='/result/hackbench/performance-pipe-threads-100%-ucode=0xca/lkp-cfl-e1/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/3c29e651e16dd3b3179cfb2d055ee9538e37515c/3'
	export scheduler_version='/lkp/lkp/.src-20200204-224526'
	export LKP_SERVER='inn'
	export max_uptime=2400
	export initrd='/osimage/debian/debian-x86_64-20191114.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-cfl-e1/hackbench-performance-pipe-threads-100%-ucode=0xca-debian-x86_64-20191114.cgz-3c29e651e16dd3b3179cfb2d055ee9538e37515c-20200205-7381-mzci5z-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.6
branch=linux-devel/devel-hourly-2020020403
commit=3c29e651e16dd3b3179cfb2d055ee9538e37515c
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/3c29e651e16dd3b3179cfb2d055ee9538e37515c/vmlinuz-5.3.0-rc1-00065-g3c29e651e16dd
max_uptime=2400
RESULT_ROOT=/result/hackbench/performance-pipe-threads-100%-ucode=0xca/lkp-cfl-e1/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/3c29e651e16dd3b3179cfb2d055ee9538e37515c/3
LKP_SERVER=inn
nokaslr
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-7.6/gcc-7/3c29e651e16dd3b3179cfb2d055ee9538e37515c/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-20180403.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/lkp_2019-08-05.cgz,/osimage/deps/debian-x86_64-20180403.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/hackbench_2020-01-02.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/hackbench-x86_64-1.5-1_2020-01-02.cgz,/osimage/deps/debian-x86_64-20180403.cgz/mpstat_2020-01-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/vmstat_2020-01-07.cgz,/osimage/deps/debian-x86_64-20180403.cgz/turbostat_2020-01-06.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/turbostat-x86_64-3.7-4_2020-01-06.cgz,/osimage/deps/debian-x86_64-20180403.cgz/perf_2020-01-04.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/sar-x86_64-e011d97-1_2020-01-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/hw_2020-01-02.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.5.0-12684-g12be34e47b2e4'
	export repeat_to=4
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-7.6/gcc-7/3c29e651e16dd3b3179cfb2d055ee9538e37515c/vmlinuz-5.3.0-rc1-00065-g3c29e651e16dd'
	export dequeue_time='2020-02-05 06:44:23 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-cfl-e1/hackbench-performance-pipe-threads-100%-ucode=0xca-debian-x86_64-20191114.cgz-3c29e651e16dd3b3179cfb2d055ee9538e37515c-20200205-7381-mzci5z-3.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper iostat
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-numastat
	run_monitor $LKP_SRC/monitors/wrapper numa-vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-meminfo
	run_monitor $LKP_SRC/monitors/wrapper proc-vmstat
	run_monitor $LKP_SRC/monitors/wrapper proc-stat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper slabinfo
	run_monitor $LKP_SRC/monitors/wrapper interrupts
	run_monitor $LKP_SRC/monitors/wrapper lock_stat
	run_monitor $LKP_SRC/monitors/wrapper latency_stats
	run_monitor $LKP_SRC/monitors/wrapper softirqs
	run_monitor $LKP_SRC/monitors/one-shot/wrapper bdi_dev_mapping
	run_monitor $LKP_SRC/monitors/wrapper diskstats
	run_monitor $LKP_SRC/monitors/wrapper nfsstat
	run_monitor $LKP_SRC/monitors/wrapper cpuidle
	run_monitor $LKP_SRC/monitors/wrapper cpufreq-stats
	run_monitor $LKP_SRC/monitors/wrapper turbostat
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test mode='threads' ipc='pipe' $LKP_SRC/tests/wrapper hackbench
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper hackbench
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper iostat
	$LKP_SRC/stats/wrapper vmstat
	$LKP_SRC/stats/wrapper numa-numastat
	$LKP_SRC/stats/wrapper numa-vmstat
	$LKP_SRC/stats/wrapper numa-meminfo
	$LKP_SRC/stats/wrapper proc-vmstat
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper slabinfo
	$LKP_SRC/stats/wrapper interrupts
	$LKP_SRC/stats/wrapper lock_stat
	$LKP_SRC/stats/wrapper latency_stats
	$LKP_SRC/stats/wrapper softirqs
	$LKP_SRC/stats/wrapper diskstats
	$LKP_SRC/stats/wrapper nfsstat
	$LKP_SRC/stats/wrapper cpuidle
	$LKP_SRC/stats/wrapper turbostat
	$LKP_SRC/stats/wrapper sched_debug
	$LKP_SRC/stats/wrapper perf-stat
	$LKP_SRC/stats/wrapper mpstat
	$LKP_SRC/stats/wrapper perf-profile

	$LKP_SRC/stats/wrapper time hackbench.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--I4VOKWutKNZEOIPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/hackbench-100.yaml
suite: hackbench
testcase: hackbench
category: benchmark
disable_latency_stats: 1
nr_threads: 100%
hackbench:
  mode: threads
  ipc: pipe
job_origin: "/lkp/lkp/.src-20200203-231712/allot/cyclic:p1:linux-devel:devel-hourly/lkp-cfl-e1/hackbench-100.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-cfl-e1
tbox_group: lkp-cfl-e1
submit_id: 5e39cd5728d98b1b8fc12899
job_file: "/lkp/jobs/scheduled/lkp-cfl-e1/hackbench-performance-pipe-threads-100%-ucode=0xca-debian-x86_64-20191114.cgz-3c29e651e16dd3b3179cfb2d055ee9538e37515c-20200205-7055-1dznxw7-0.yaml"
id: a9ce3bce866e81d9d10082d52727e92ddad98429
queuer_version: "/lkp-src"
arch: x86_64

#! hosts/lkp-cfl-e1
model: Coffee Lake
nr_node: 1
nr_cpu: 16
memory: 32G
nr_hdd_partitions: 1
hdd_partitions: "/dev/disk/by-id/ata-WDC_WD1005FBYZ-01YCBB1_WD-WMC6M0D4MD6W-part2"
swap_partitions: LABEL=SWAP
rootfs_partition: "/dev/disk/by-id/ata-WDC_WD1005FBYZ-01YCBB1_WD-WMC6M0D4MD6W-part1"
brand: Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz

#! include/category/benchmark
kmsg: 
boot-time: 
iostat: 
heartbeat: 
vmstat: 
numa-numastat: 
numa-vmstat: 
numa-meminfo: 
proc-vmstat: 
proc-stat: 
meminfo: 
slabinfo: 
interrupts: 
lock_stat: 
latency_stats: 
softirqs: 
bdi_dev_mapping: 
diskstats: 
nfsstat: 
cpuidle: 
cpufreq-stats: 
turbostat: 
sched_debug: 
perf-stat: 
mpstat: 
perf-profile: 

#! include/category/ALL
cpufreq_governor: performance

#! include/queue/cyclic
commit: 3c29e651e16dd3b3179cfb2d055ee9538e37515c

#! include/testbox/lkp-cfl-e1
ucode: '0xca'
need_kconfig_hw:
- CONFIG_IGB=y
- CONFIG_SATA_AHCI

#! default params
kconfig: x86_64-rhel-7.6
compiler: gcc-7
enqueue_time: 2020-02-05 04:03:33.135694719 +08:00
_id: 5e39cd5728d98b1b8fc12899
_rt: "/result/hackbench/performance-pipe-threads-100%-ucode=0xca/lkp-cfl-e1/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/3c29e651e16dd3b3179cfb2d055ee9538e37515c"

#! schedule options
user: lkp
head_commit: 12be34e47b2e41897ed73b235a3ef57cc6ee0bfd
base_commit: d5226fa6dbae0569ee43ecfc08bdcd6770fc4755
branch: linux-devel/devel-hourly-2020020403
rootfs: debian-x86_64-20191114.cgz
result_root: "/result/hackbench/performance-pipe-threads-100%-ucode=0xca/lkp-cfl-e1/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/3c29e651e16dd3b3179cfb2d055ee9538e37515c/0"
scheduler_version: "/lkp/lkp/.src-20200204-224526"
LKP_SERVER: inn
max_uptime: 2400
initrd: "/osimage/debian/debian-x86_64-20191114.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-cfl-e1/hackbench-performance-pipe-threads-100%-ucode=0xca-debian-x86_64-20191114.cgz-3c29e651e16dd3b3179cfb2d055ee9538e37515c-20200205-7055-1dznxw7-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-7.6
- branch=linux-devel/devel-hourly-2020020403
- commit=3c29e651e16dd3b3179cfb2d055ee9538e37515c
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/3c29e651e16dd3b3179cfb2d055ee9538e37515c/vmlinuz-5.3.0-rc1-00065-g3c29e651e16dd
- max_uptime=2400
- RESULT_ROOT=/result/hackbench/performance-pipe-threads-100%-ucode=0xca/lkp-cfl-e1/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/3c29e651e16dd3b3179cfb2d055ee9538e37515c/0
- LKP_SERVER=inn
- nokaslr
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-7.6/gcc-7/3c29e651e16dd3b3179cfb2d055ee9538e37515c/modules.cgz"
bm_initrd: "/osimage/deps/debian-x86_64-20180403.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/lkp_2019-08-05.cgz,/osimage/deps/debian-x86_64-20180403.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/hackbench_2020-01-02.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/hackbench-x86_64-1.5-1_2020-01-02.cgz,/osimage/deps/debian-x86_64-20180403.cgz/mpstat_2020-01-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/vmstat_2020-01-07.cgz,/osimage/deps/debian-x86_64-20180403.cgz/turbostat_2020-01-06.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/turbostat-x86_64-3.7-4_2020-01-06.cgz,/osimage/deps/debian-x86_64-20180403.cgz/perf_2020-01-04.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/sar-x86_64-e011d97-1_2020-01-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/hw_2020-01-02.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20200203-231712/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 4.19.101
repeat_to: 2
schedule_notify_address: 

#! user overrides
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-7.6/gcc-7/3c29e651e16dd3b3179cfb2d055ee9538e37515c/vmlinuz-5.3.0-rc1-00065-g3c29e651e16dd"
dequeue_time: 2020-02-05 05:54:36.134542901 +08:00

#! /lkp/lkp/.src-20200204-224526/include/site/inn
job_state: finished
loadavg: 282.94 291.11 165.66 1/216 20384
start_time: '1580853336'
end_time: '1580853941'
version: "/lkp/lkp/.src-20200204-224609:1f7eb94a:ca3b0b9c1-dirty"

--I4VOKWutKNZEOIPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

 "/usr/bin/hackbench" "-g" "16" "--threads" "--pipe" "-l" "30000" "-s" "100"
 "/usr/bin/hackbench" "-g" "16" "--threads" "--pipe" "-l" "30000" "-s" "100"
 "/usr/bin/hackbench" "-g" "16" "--threads" "--pipe" "-l" "30000" "-s" "100"
 "/usr/bin/hackbench" "-g" "16" "--threads" "--pipe" "-l" "30000" "-s" "100"
 "/usr/bin/hackbench" "-g" "16" "--threads" "--pipe" "-l" "30000" "-s" "100"
 "/usr/bin/hackbench" "-g" "16" "--threads" "--pipe" "-l" "30000" "-s" "100"
 "/usr/bin/hackbench" "-g" "16" "--threads" "--pipe" "-l" "30000" "-s" "100"
 "/usr/bin/hackbench" "-g" "16" "--threads" "--pipe" "-l" "30000" "-s" "100"
 "/usr/bin/hackbench" "-g" "16" "--threads" "--pipe" "-l" "30000" "-s" "100"
 "/usr/bin/hackbench" "-g" "16" "--threads" "--pipe" "-l" "30000" "-s" "100"
 "/usr/bin/hackbench" "-g" "16" "--threads" "--pipe" "-l" "30000" "-s" "100"
 "/usr/bin/hackbench" "-g" "16" "--threads" "--pipe" "-l" "30000" "-s" "100"
 "/usr/bin/hackbench" "-g" "16" "--threads" "--pipe" "-l" "30000" "-s" "100"
 "/usr/bin/hackbench" "-g" "16" "--threads" "--pipe" "-l" "30000" "-s" "100"
 "/usr/bin/hackbench" "-g" "16" "--threads" "--pipe" "-l" "30000" "-s" "100"
 "/usr/bin/hackbench" "-g" "16" "--threads" "--pipe" "-l" "30000" "-s" "100"
 "/usr/bin/hackbench" "-g" "16" "--threads" "--pipe" "-l" "30000" "-s" "100"
 "/usr/bin/hackbench" "-g" "16" "--threads" "--pipe" "-l" "30000" "-s" "100"
 "/usr/bin/hackbench" "-g" "16" "--threads" "--pipe" "-l" "30000" "-s" "100"

--I4VOKWutKNZEOIPu--
