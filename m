Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453D1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 03:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 029632072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 03:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgFJDeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 23:34:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:8004 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgFJDeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 23:34:18 -0400
IronPort-SDR: asnQ4+0K8fsvmELABGR1wpl9iUyErsLN4ifwENSNKobXuTHFWYe5rMrPrw+o5cM6bz5zkV+oO+
 0fZf2qV/lx3g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 20:21:16 -0700
IronPort-SDR: 65fyH+r6fAU66s38ltH9QBKuse/rP5X6C1qHFYkvB+hAdHWJUq5nrVNKCJbdEZrLIbhMtwmO5S
 yMV5awwVD5Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,494,1583222400"; 
   d="scan'208";a="379935646"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.238.6.47]) ([10.238.6.47])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jun 2020 20:21:14 -0700
Subject: Re: [LKP] [ima] 8eb613c0b8: stress-ng.icache.ops_per_sec -84.2%
 regression
To:     kernel test robot <rong.a.chen@intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200603091150.GH12456@shao2-debian>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <099cfe59-1601-a0fc-3849-13eee8754130@linux.intel.com>
Date:   Wed, 10 Jun 2020 11:21:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200603091150.GH12456@shao2-debian>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi,

     Do you have time to take a look at this? we noticed a 3.7% 
regression of boot-time.dhcp and a 84.2% regression of 
stress-ng.icache.ops_per_sec. Thanks.

On 6/3/2020 5:11 PM, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a 3.7% regression of boot-time.dhcp due to commit:
> 
> 
> commit: 8eb613c0b8f19627ba1846dcf78bb2c85edbe8dd ("ima: verify mprotect change is consistent with mmap policy")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: stress-ng
> on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory
> with following parameters:
> 
> 	nr_threads: 100%
> 	disk: 1HDD
> 	testtime: 30s
> 	class: cpu-cache
> 	cpufreq_governor: performance
> 	ucode: 0x500002c
> 
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> To reproduce:
> 
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          bin/lkp install job.yaml  # job file is attached in this email
>          bin/lkp run     job.yaml
> 
> =========================================================================================
> class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/testcase/testtime/ucode:
>    cpu-cache/gcc-9/performance/1HDD/x86_64-rhel-7.6/100%/debian-x86_64-20191114.cgz/lkp-csl-2sp5/stress-ng/30s/0x500002c
> 
> commit:
>    0c4395fb2a ("evm: Fix possible memory leak in evm_calc_hmac_or_hash()")
>    8eb613c0b8 ("ima: verify mprotect change is consistent with mmap policy")
> 
> 0c4395fb2aa77341 8eb613c0b8f19627ba1846dcf78
> ---------------- ---------------------------
>         fail:runs  %reproduction    fail:runs
>             |             |             |
>             :4           25%           1:4     dmesg.WARNING:at#for_ip_interrupt_entry/0x
>            0:4            3%           0:4     perf-profile.children.cycles-pp.error_entry
>           %stddev     %change         %stddev
>               \          |                \
>     1245570           -84.2%     197151        stress-ng.icache.ops
>       41517           -84.2%       6570        stress-ng.icache.ops_per_sec
>   1.306e+09           -82.1%  2.338e+08        stress-ng.time.minor_page_faults
>        2985           +13.5%       3387        stress-ng.time.system_time
>        4.28           +13.1%       4.85        iostat.cpu.system
>        4.18            +0.6        4.73        mpstat.cpu.all.sys%
>       10121            +9.6%      11096 ±  3%  softirqs.CPU67.SCHED
>      203299            -4.2%     194854 ±  5%  vmstat.system.in
>       26.91            +2.8%      27.67 ±  3%  boot-time.boot
>       16.34            +3.7%      16.94 ±  2%  boot-time.dhcp
>        2183 ±  3%      +3.7%       2263        boot-time.idle
>     1042938 ± 80%   +8208.2%   86649242 ±156%  cpuidle.C1.time
>       48428 ±114%   +1842.4%     940677 ±151%  cpuidle.C1.usage
>       15748 ± 28%    +301.0%      63144 ± 79%  cpuidle.POLL.usage
>       61300 ±  4%     +82.8%     112033 ± 11%  numa-vmstat.node1.nr_active_anon
>       47060 ±  3%    +106.8%      97323 ± 12%  numa-vmstat.node1.nr_anon_pages
>       42.67 ±  2%    +217.0%     135.25 ± 14%  numa-vmstat.node1.nr_anon_transparent_hugepages
>       61301 ±  4%     +82.8%     112032 ± 11%  numa-vmstat.node1.nr_zone_active_anon
>        3816 ±  2%      +3.0%       3931        proc-vmstat.nr_page_table_pages
>    35216541            +2.9%   36244047        proc-vmstat.pgalloc_normal
>   1.308e+09           -82.0%  2.356e+08        proc-vmstat.pgfault
>    35173363            +2.8%   36173843        proc-vmstat.pgfree
>      248171 ±  5%     +82.5%     452893 ± 11%  numa-meminfo.node1.Active
>      244812 ±  4%     +83.5%     449116 ± 11%  numa-meminfo.node1.Active(anon)
>       88290 ±  3%    +214.4%     277591 ± 15%  numa-meminfo.node1.AnonHugePages
>      187940 ±  3%    +107.8%     390486 ± 12%  numa-meminfo.node1.AnonPages
>     1366813 ±  3%     +12.0%    1530428 ±  6%  numa-meminfo.node1.MemUsed
>      571.00 ±  8%     +10.4%     630.50 ±  8%  slabinfo.UDP.active_objs
>      571.00 ±  8%     +10.4%     630.50 ±  8%  slabinfo.UDP.num_objs
>      300.00 ±  5%     +20.0%     360.00 ± 10%  slabinfo.kmem_cache.active_objs
>      300.00 ±  5%     +20.0%     360.00 ± 10%  slabinfo.kmem_cache.num_objs
>      606.33 ±  4%     +17.6%     713.00 ±  8%  slabinfo.kmem_cache_node.active_objs
>      661.33 ±  4%     +16.1%     768.00 ±  8%  slabinfo.kmem_cache_node.num_objs
>      114561 ± 23%     -34.3%      75239 ±  7%  sched_debug.cfs_rq:/.load.max
>       14869 ± 22%     -36.6%       9424 ±  8%  sched_debug.cfs_rq:/.load.stddev
>     4040842 ±  5%     +18.0%    4767515 ± 13%  sched_debug.cpu.avg_idle.max
>     2019061 ±  8%     +25.5%    2534134 ± 14%  sched_debug.cpu.max_idle_balance_cost.max
>      378044 ±  3%     +22.5%     463135 ±  8%  sched_debug.cpu.max_idle_balance_cost.stddev
>       41605           +12.6%      46852 ±  2%  sched_debug.cpu.nr_switches.max
>       44445 ±  2%     +11.8%      49668 ±  3%  sched_debug.cpu.sched_count.max
>        7704 ±  8%     +26.6%       9753 ± 14%  sched_debug.cpu.sched_goidle.max
>      584.16 ±  4%    +135.0%       1372 ± 57%  sched_debug.cpu.sched_goidle.stddev
>        1416 ±  3%     +32.2%       1873 ± 19%  sched_debug.cpu.ttwu_local.stddev
>        0.33 ±141%  +18200.0%      61.00 ±152%  interrupts.40:PCI-MSI.31981573-edge.i40e-eth0-TxRx-4
>       79.67 ±124%     -99.1%       0.75 ±110%  interrupts.89:PCI-MSI.31981622-edge.i40e-eth0-TxRx-53
>        6318           +44.6%       9134 ±  6%  interrupts.CPU1.RES:Rescheduling_interrupts
>        5245 ± 35%     +50.1%       7871        interrupts.CPU11.NMI:Non-maskable_interrupts
>        5245 ± 35%     +50.1%       7871        interrupts.CPU11.PMI:Performance_monitoring_interrupts
>       67.00 ± 58%     -79.9%      13.50 ± 76%  interrupts.CPU16.TLB:TLB_shootdowns
>      861.67           +39.1%       1198 ± 31%  interrupts.CPU23.RES:Rescheduling_interrupts
>      796.33 ±  2%      +9.4%     871.50 ±  2%  interrupts.CPU34.RES:Rescheduling_interrupts
>        0.33 ±141%  +18125.0%      60.75 ±153%  interrupts.CPU4.40:PCI-MSI.31981573-edge.i40e-eth0-TxRx-4
>        1271 ± 43%     +47.2%       1872 ± 26%  interrupts.CPU51.RES:Rescheduling_interrupts
>       79.33 ±125%     -99.4%       0.50 ±173%  interrupts.CPU53.89:PCI-MSI.31981622-edge.i40e-eth0-TxRx-53
>      844.00 ±  2%     +63.7%       1381 ± 34%  interrupts.CPU6.RES:Rescheduling_interrupts
>      786.00 ±  4%     +21.2%     953.00 ± 13%  interrupts.CPU69.RES:Rescheduling_interrupts
>      855.67 ± 11%     +96.3%       1679 ± 60%  interrupts.CPU8.RES:Rescheduling_interrupts
>      178.33 ± 43%     -81.2%      33.50 ± 85%  interrupts.CPU8.TLB:TLB_shootdowns
>      820.67 ±  9%     -18.8%     666.25 ±  9%  interrupts.CPU82.RES:Rescheduling_interrupts
>   4.464e+10            -2.9%  4.336e+10        perf-stat.i.branch-instructions
>        2.65            +0.1        2.73        perf-stat.i.branch-miss-rate%
>        6.32 ±  3%      +5.3%       6.65 ±  2%  perf-stat.i.cpi
>    19226980            -8.5%   17587852        perf-stat.i.dTLB-load-misses
>    5.17e+10            -3.5%  4.989e+10        perf-stat.i.dTLB-loads
>     5874100           -52.1%    2811682        perf-stat.i.dTLB-store-misses
>   1.968e+10            -5.4%  1.861e+10        perf-stat.i.dTLB-stores
>     6448559 ±  3%     -45.3%    3527950 ±  9%  perf-stat.i.iTLB-load-misses
>    31409753 ±  4%     -53.3%   14680095 ±  3%  perf-stat.i.iTLB-loads
>   2.267e+11            -2.9%  2.201e+11        perf-stat.i.instructions
>        0.93            -2.7%       0.91        perf-stat.i.ipc
>        1155            -3.9%       1110        perf-stat.i.metric.M/sec
>     1819587           -82.9%     311898        perf-stat.i.minor-faults
>     1819587           -82.9%     311898        perf-stat.i.page-faults
>        3.49            +3.3%       3.61        perf-stat.overall.MPKI
>        2.26            +0.1        2.32        perf-stat.overall.branch-miss-rate%
>        1.08            +3.5%       1.12        perf-stat.overall.cpi
>        0.04            -0.0        0.04        perf-stat.overall.dTLB-load-miss-rate%
>        0.03            -0.0        0.02        perf-stat.overall.dTLB-store-miss-rate%
>       17.10            +2.4       19.49 ±  6%  perf-stat.overall.iTLB-load-miss-rate%
>       35144 ±  2%     +75.7%      61761 ±  8%  perf-stat.overall.instructions-per-iTLB-miss
>        0.92            -3.3%       0.89        perf-stat.overall.ipc
>   4.286e+10            -3.0%  4.156e+10        perf-stat.ps.branch-instructions
>    18403186            -8.6%   16825390        perf-stat.ps.dTLB-load-misses
>   4.958e+10            -3.6%  4.778e+10        perf-stat.ps.dTLB-loads
>     5647388           -51.3%    2750721        perf-stat.ps.dTLB-store-misses
>   1.886e+10            -5.5%  1.782e+10        perf-stat.ps.dTLB-stores
>     6190595 ±  2%     -44.4%    3440326 ±  9%  perf-stat.ps.iTLB-load-misses
>    30030226 ±  4%     -52.8%   14185074 ±  3%  perf-stat.ps.iTLB-loads
>   2.174e+11            -3.1%  2.107e+11        perf-stat.ps.instructions
>     1737379           -82.0%     312180        perf-stat.ps.minor-faults
>     1737379           -82.0%     312180        perf-stat.ps.page-faults
>   1.635e+14            -3.1%  1.585e+14        perf-stat.total.instructions
>        0.97 ±  3%      -0.3        0.70 ±  9%  perf-profile.calltrace.cycles-pp.__generic_file_write_iter.generic_file_write_iter.new_sync_write.vfs_write.ksys_write
>        0.97 ±  3%      -0.3        0.70 ±  9%  perf-profile.calltrace.cycles-pp.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.new_sync_write.vfs_write
>        0.98 ±  4%      -0.3        0.71 ± 10%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.98 ±  4%      -0.3        0.71 ± 10%  perf-profile.calltrace.cycles-pp.generic_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
>        0.99 ±  3%      -0.2        0.74 ± 11%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_write
>        1.02 ±  3%      -0.2        0.77 ±  9%  perf-profile.calltrace.cycles-pp.perf_mmap__push.cmd_record.main.__libc_start_main
>        1.00 ±  4%      -0.2        0.76 ± 10%  perf-profile.calltrace.cycles-pp.__GI___libc_write.perf_mmap__push.cmd_record.main.__libc_start_main
>        0.99 ±  3%      -0.2        0.75 ±  9%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_write.perf_mmap__push
>        0.99 ±  3%      -0.2        0.76 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__GI___libc_write.perf_mmap__push.cmd_record.main
>        0.99 ±  3%      -0.2        0.76 ± 10%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_write.perf_mmap__push.cmd_record
>        2.99 ±  5%      +0.4        3.37 ±  5%  perf-profile.calltrace.cycles-pp.lapic_next_deadline.clockevents_program_event.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt
>        2.06 ±  9%      +0.4        2.45 ± 11%  perf-profile.calltrace.cycles-pp.update_curr.task_tick_fair.scheduler_tick.update_process_times.tick_sched_handle
>        2.43 ±  7%      +0.4        2.84 ±  7%  perf-profile.calltrace.cycles-pp.native_write_msr.lapic_next_deadline.clockevents_program_event.hrtimer_interrupt.smp_apic_timer_interrupt
>        0.17 ±141%      +0.4        0.60 ± 13%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.rcu_core.__softirqentry_text_start.irq_exit.smp_apic_timer_interrupt
>        0.19 ±141%      +0.5        0.68 ± 14%  perf-profile.calltrace.cycles-pp.reweight_entity.task_tick_fair.scheduler_tick.update_process_times.tick_sched_handle
>        1.50 ± 15%      +0.5        2.03 ±  9%  perf-profile.calltrace.cycles-pp.native_write_msr.__intel_pmu_enable_all.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt
>        1.57 ± 16%      +0.6        2.12 ±  8%  perf-profile.calltrace.cycles-pp.__intel_pmu_enable_all.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt
>        3.58 ± 15%      +1.0        4.63 ± 12%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt
>        3.94 ±  3%      +1.7        5.69 ± 28%  perf-profile.calltrace.cycles-pp.hrtimer_active.task_tick_fair.scheduler_tick.update_process_times.tick_sched_handle
>       34.96 ±  5%      +3.2       38.16 ±  5%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt
>       41.63 ±  5%      +4.8       46.42 ±  6%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt
>       19.35 ±  3%      +5.8       25.16 ± 23%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
>        0.41 ± 55%      -0.3        0.09 ± 55%  perf-profile.children.cycles-pp.alloc_pages_vma
>        1.22 ±  2%      -0.3        0.91 ± 15%  perf-profile.children.cycles-pp.new_sync_write
>        1.26            -0.3        0.96 ± 13%  perf-profile.children.cycles-pp.ksys_write
>        1.23            -0.3        0.94 ± 15%  perf-profile.children.cycles-pp.vfs_write
>        0.98 ±  4%      -0.3        0.71 ±  8%  perf-profile.children.cycles-pp.__generic_file_write_iter
>        0.98 ±  4%      -0.3        0.71 ±  8%  perf-profile.children.cycles-pp.generic_perform_write
>        0.99 ±  5%      -0.3        0.72 ± 10%  perf-profile.children.cycles-pp.generic_file_write_iter
>        1.02 ±  3%      -0.2        0.77 ±  9%  perf-profile.children.cycles-pp.perf_mmap__push
>        1.00 ±  4%      -0.2        0.76 ± 10%  perf-profile.children.cycles-pp.__GI___libc_write
>        0.16 ± 10%      -0.1        0.07 ± 60%  perf-profile.children.cycles-pp.hrtimer_run_queues
>        0.15 ± 22%      -0.1        0.09 ± 20%  perf-profile.children.cycles-pp.run_posix_cpu_timers
>        0.33 ±  8%      -0.1        0.27 ±  4%  perf-profile.children.cycles-pp.rcu_irq_enter
>        0.04 ± 71%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.path_lookupat
>        0.04 ± 71%      +0.0        0.08 ± 10%  perf-profile.children.cycles-pp.filename_lookup
>        0.20 ± 22%      +0.0        0.25 ± 15%  perf-profile.children.cycles-pp.tick_program_event
>        0.20 ± 23%      +0.1        0.26 ± 15%  perf-profile.children.cycles-pp.cmd_stat
>        0.02 ±141%      +0.1        0.08 ± 15%  perf-profile.children.cycles-pp.vsnprintf
>        0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.lookup_fast
>        0.12 ± 26%      +0.1        0.18 ± 15%  perf-profile.children.cycles-pp.enqueue_entity
>        0.03 ±141%      +0.1        0.09 ± 39%  perf-profile.children.cycles-pp.pagevec_lru_move_fn
>        0.02 ±141%      +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.__x64_sys_mprotect
>        0.02 ±141%      +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.do_mprotect_pkey
>        0.19 ± 38%      +0.1        0.26 ±  7%  perf-profile.children.cycles-pp.update_min_vruntime
>        0.16 ± 29%      +0.1        0.23 ± 16%  perf-profile.children.cycles-pp.iov_iter_fault_in_readable
>        0.19 ±  5%      +0.1        0.27 ± 27%  perf-profile.children.cycles-pp.copy_process
>        0.25 ± 14%      +0.1        0.33 ± 29%  perf-profile.children.cycles-pp.__do_sys_clone
>        0.25 ± 14%      +0.1        0.33 ± 29%  perf-profile.children.cycles-pp._do_fork
>        0.12 ± 13%      +0.1        0.21 ± 17%  perf-profile.children.cycles-pp.activate_task
>        0.14 ± 18%      +0.1        0.23 ± 23%  perf-profile.children.cycles-pp.enqueue_task_fair
>        0.11 ± 29%      +0.1        0.20 ± 41%  perf-profile.children.cycles-pp.rebalance_domains
>        0.04 ± 71%      +0.1        0.13 ± 43%  perf-profile.children.cycles-pp.cpuacct_account_field
>        0.12 ± 22%      +0.1        0.21 ± 16%  perf-profile.children.cycles-pp.ttwu_do_activate
>        0.29 ± 10%      +0.1        0.40 ± 24%  perf-profile.children.cycles-pp.__libc_fork
>        0.00            +0.1        0.11 ± 48%  perf-profile.children.cycles-pp.i40e_handle_lldp_event
>        0.00            +0.1        0.11 ± 48%  perf-profile.children.cycles-pp.i40e_asq_send_command
>        0.33 ±  6%      +0.1        0.44 ± 19%  perf-profile.children.cycles-pp.forkshell
>        0.00            +0.1        0.11 ± 42%  perf-profile.children.cycles-pp.i40e_clean_adminq_subtask
>        0.63            +0.1        0.75 ± 14%  perf-profile.children.cycles-pp._raw_spin_lock_irq
>        0.02 ±141%      +0.1        0.14 ± 62%  perf-profile.children.cycles-pp.__x64_sys_poll
>        0.09 ± 13%      +0.1        0.21 ± 51%  perf-profile.children.cycles-pp.change_prot_numa
>        0.00            +0.1        0.12 ± 43%  perf-profile.children.cycles-pp.i40e_service_task
>        0.57 ± 14%      +0.1        0.70 ± 17%  perf-profile.children.cycles-pp.handle_mm_fault
>        0.02 ±141%      +0.1        0.15 ± 55%  perf-profile.children.cycles-pp.poll
>        0.85            +0.2        1.07 ± 13%  perf-profile.children.cycles-pp.interrupt_entry
>        1.55 ±  5%      +0.3        1.80 ± 11%  perf-profile.children.cycles-pp.read_tsc
>        0.49 ± 24%      +0.3        0.76 ± 15%  perf-profile.children.cycles-pp.reweight_entity
>        0.62 ± 10%      +0.3        0.90 ± 29%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
>        0.27 ± 28%      +0.4        0.63 ± 33%  perf-profile.children.cycles-pp.account_user_time
>        3.00 ±  5%      +0.4        3.38 ±  5%  perf-profile.children.cycles-pp.lapic_next_deadline
>        2.20 ±  8%      +0.4        2.62 ± 10%  perf-profile.children.cycles-pp.update_curr
>        1.58 ± 15%      +0.6        2.13 ±  8%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
>        0.31 ±141%      +0.6        0.90 ± 39%  perf-profile.children.cycles-pp.wake_up_klogd_work_func
>        4.11 ±  9%      +1.0        5.07 ±  7%  perf-profile.children.cycles-pp.native_write_msr
>        3.62 ± 15%      +1.1        4.68 ± 12%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
>        3.95 ±  3%      +1.7        5.70 ± 29%  perf-profile.children.cycles-pp.hrtimer_active
>       34.98 ±  5%      +3.2       38.18 ±  5%  perf-profile.children.cycles-pp.tick_sched_timer
>       15.44            +3.7       19.12 ± 18%  perf-profile.children.cycles-pp.scheduler_tick
>       41.67 ±  5%      +4.8       46.49 ±  6%  perf-profile.children.cycles-pp.__hrtimer_run_queues
>       19.36 ±  3%      +5.8       25.18 ± 23%  perf-profile.children.cycles-pp.update_process_times
>        0.33 ±  8%      -0.1        0.27 ±  7%  perf-profile.self.cycles-pp.rcu_irq_enter
>        0.15 ± 23%      -0.1        0.09 ± 20%  perf-profile.self.cycles-pp.run_posix_cpu_timers
>        0.20 ± 22%      +0.0        0.24 ± 13%  perf-profile.self.cycles-pp.tick_program_event
>        0.10 ± 12%      +0.1        0.17 ± 23%  perf-profile.self.cycles-pp.unmap_page_range
>        0.07 ± 30%      +0.1        0.13 ± 31%  perf-profile.self.cycles-pp.rcu_irq_exit
>        0.00            +0.1        0.06 ± 20%  perf-profile.self.cycles-pp.select_idle_sibling
>        0.18 ± 35%      +0.1        0.26 ±  7%  perf-profile.self.cycles-pp.update_min_vruntime
>        0.04 ± 71%      +0.1        0.13 ± 43%  perf-profile.self.cycles-pp.cpuacct_account_field
>        0.05 ± 78%      +0.1        0.14 ± 49%  perf-profile.self.cycles-pp.change_pte_range
>        0.20 ± 21%      +0.1        0.32 ± 19%  perf-profile.self.cycles-pp.irq_exit
>        0.13 ±  3%      +0.1        0.27 ± 29%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
>        0.37 ± 31%      +0.2        0.57 ± 21%  perf-profile.self.cycles-pp.reweight_entity
>        0.84 ±  2%      +0.2        1.07 ± 13%  perf-profile.self.cycles-pp.interrupt_entry
>        0.62 ±  8%      +0.3        0.87 ± 29%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
>        1.49 ±  6%      +0.3        1.75 ±  9%  perf-profile.self.cycles-pp.read_tsc
>        0.22 ± 31%      +0.3        0.50 ± 33%  perf-profile.self.cycles-pp.account_user_time
>        1.47            +0.4        1.91 ± 13%  perf-profile.self.cycles-pp.update_curr
>        4.10 ± 10%      +1.0        5.05 ±  7%  perf-profile.self.cycles-pp.native_write_msr
>        3.93 ±  3%      +1.8        5.70 ± 29%  perf-profile.self.cycles-pp.hrtimer_active
> 
> 
>                                                                                  
>                              stress-ng.time.system_time
>                                                                                  
>    3500 +--------------------------------------------------------------------+
>         |  O  O  O  O O  O  O  O  O     O  O O  O  O  O             O        |
>    3000 |..+..+..+..+.+..+..+..+..+..+..+..+.+..+..+..+..+..+     +.+..+     |
>         |                                                   :     :          |
>    2500 |-+                                                  :    :          |
>         |                                                    :   :           |
>    2000 |-+                                                  :   :           |
>         |                                                    :   :           |
>    1500 |-+                                                   :  :           |
>         |                                                     : :            |
>    1000 |-+                                                   : :            |
>         |                                                     : :            |
>     500 |-+                                                    ::            |
>         |                                                      :             |
>       0 +--------------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                             stress-ng.time.minor_page_faults
>                                                                                  
>    1.4e+09 +-----------------------------------------------------------------+
>            |..+..+.+..+..+..+.+..+..+..+.+..+..+..+.+..+..+..+    +..+..+    |
>    1.2e+09 |-+                                               :    :          |
>            |                                                 :    :          |
>      1e+09 |-+                                               :   :           |
>            |                                                  :  :           |
>      8e+08 |-+                                                :  :           |
>            |                                                  :  :           |
>      6e+08 |-+                                                : :            |
>            |                                                  : :            |
>      4e+08 |-+                                                : :            |
>            |                                                   ::            |
>      2e+08 |-+O  O O  O  O  O O  O  O    O  O  O  O O  O  O  O :  O  O  O O  |
>            |                                                   :             |
>          0 +-----------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                                   stress-ng.icache.ops
>                                                                                  
>    1.4e+06 +-----------------------------------------------------------------+
>            |                 .+..                                            |
>    1.2e+06 |..+..+.+..+..+..+    +..+..+.+..+..+..+.+..+..+..+    +..+..+    |
>            |                                                 :    :          |
>      1e+06 |-+                                               :    :          |
>            |                                                  :  :           |
>     800000 |-+                                                :  :           |
>            |                                                  :  :           |
>     600000 |-+                                                :  :           |
>            |                                                  : :            |
>     400000 |-+                                                : :            |
>            |                                                   ::            |
>     200000 |-+O  O O  O  O  O O  O  O    O  O  O  O O  O  O  O :: O  O  O O  |
>            |                                                   :             |
>          0 +-----------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                              stress-ng.icache.ops_per_sec
>                                                                                  
>    45000 +-------------------------------------------------------------------+
>          |..+..+..+.+..+..+..+..+..+.+..+..+..+..+..+.+..+..+     +..+.+     |
>    40000 |-+                                                :     :          |
>    35000 |-+                                                :     :          |
>          |                                                   :   :           |
>    30000 |-+                                                 :   :           |
>    25000 |-+                                                 :   :           |
>          |                                                   :   :           |
>    20000 |-+                                                  : :            |
>    15000 |-+                                                  : :            |
>          |                                                    : :            |
>    10000 |-+                                                  : :            |
>     5000 |-+O  O  O O  O  O  O  O  O    O  O  O  O  O O  O  O  :  O  O O  O  |
>          |                                                     :             |
>        0 +-------------------------------------------------------------------+
>                                                                                  
>                                                                                  
> [*] bisect-good sample
> [O] bisect-bad  sample
> 
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 
> Thanks,
> Rong Chen
> 
> 
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
> 

-- 
Zhengjun Xing
