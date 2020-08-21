Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F347C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 02:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E52F20758
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 02:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgHUCnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 22:43:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:14432 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbgHUCnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 22:43:35 -0400
IronPort-SDR: 2Eqhxf3D0MjI8nYDlaPfTwQUwnilbH8Fc2+B038q1Km1zClI8kjaygXKK4Tf/Y2u97XGO4jBxz
 GVPbSa9S7PRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="240260814"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="new'?old'?scan'208";a="240260814"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 19:03:03 -0700
IronPort-SDR: dT4Jl9X57+Ab8x71z2AOUuIsDoDXE6WF7mAWFqVm3SJnUaJKHp/mGJw81bWubknN4YCoZcc5C/
 xD0u9Ltqu2BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="new'?old'?scan'208";a="472871237"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by orsmga005.jf.intel.com with ESMTP; 20 Aug 2020 19:02:59 -0700
Date:   Fri, 21 Aug 2020 10:02:59 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@suse.de>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [LKP] Re: [x86/mce] 1de08dccd3: will-it-scale.per_process_ops
 -14.1% regression
Message-ID: <20200821020259.GA90000@shbuild999.sh.intel.com>
References: <20200425114414.GU26573@shao2-debian>
 <20200425130136.GA28245@zn.tnic>
 <20200818082943.GA65567@shbuild999.sh.intel.com>
 <20200818200654.GA21494@agluck-desk2.amr.corp.intel.com>
 <20200819020437.GA2605@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200819020437.GA2605@shbuild999.sh.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Aug 19, 2020 at 10:04:37AM +0800, Feng Tang wrote:
> > We do have some DEFINE_PER_CPU data objects of type "struct mce":
> > 
> > $ git grep 'DEFINE_PER_CPU(struct mce,'
> > arch/x86/kernel/cpu/mce/core.c:static DEFINE_PER_CPU(struct mce, mces_seen);
> > arch/x86/kernel/cpu/mce/core.c:DEFINE_PER_CPU(struct mce, injectm);
> > 
> > Maybe making those slightly bigger has pushed some other per_cpu object
> > into an unfortunate alignment where some frequently used data is now
> > split between two cache lines instead of sitting in one?
> 
> Yes, I also checked the percpu data part of kernel System map, seems
> it only affects alignments of several variables, from 'mce_pooll_banks'
> to 'tsc_adjust', and the alignment restores for 'lapic_events', but I
> can't see any of them could be related to this malloc microbenchmark
> 	
> old map:
> 
> 	0000000000018c60 d mces_seen
> 	0000000000018ce0 D injectm
> 	0000000000018d58 D mce_poll_banks
> 	0000000000018d60 D mce_poll_count
> 	0000000000018d64 D mce_exception_count
> 	0000000000018d68 D mce_device
> 	0000000000018d70 d cmci_storm_state
> 	0000000000018d74 d cmci_storm_cnt
> 	0000000000018d78 d cmci_time_stamp
> 	0000000000018d80 d cmci_backoff_cnt
> 	0000000000018d88 d mce_banks_owned
> 	0000000000018d90 d smca_misc_banks_map
> 	0000000000018d94 d bank_map
> 	0000000000018d98 d threshold_banks
> 	0000000000018da0 d thermal_state
> 	0000000000019260 D pqr_state
> 	0000000000019270 d arch_prev_mperf
> 	0000000000019278 d arch_prev_aperf
> 	0000000000019280 D arch_freq_scale
> 	00000000000192a0 d tsc_adjust
> 	00000000000192c0 d lapic_events
> 
> new map:
> 
> 	0000000000018c60 d mces_seen
> 	0000000000018ce0 D injectm
> 	0000000000018d60 D mce_poll_banks
> 	0000000000018d68 D mce_poll_count
> 	0000000000018d6c D mce_exception_count
> 	0000000000018d70 D mce_device
> 	0000000000018d78 d cmci_storm_state
> 	0000000000018d7c d cmci_storm_cnt
> 	0000000000018d80 d cmci_time_stamp
> 	0000000000018d88 d cmci_backoff_cnt
> 	0000000000018d90 d mce_banks_owned
> 	0000000000018d98 d smca_misc_banks_map
> 	0000000000018d9c d bank_map
> 	0000000000018da0 d threshold_banks
> 	0000000000018dc0 d thermal_state
> 	0000000000019280 D pqr_state
> 	0000000000019290 d arch_prev_mperf
> 	0000000000019298 d arch_prev_aperf
> 	00000000000192a0 D arch_freq_scale
> 	00000000000192c0 d tsc_adjust
> 	0000000000019300 d lapic_events
> 
> > Can you collect some perf trace data for the benchmark when running
> > on kernels with kflags as __u32 and __u64 (looks to be the minimal
> > possible change that you found that still exhibits this problem).
> >
> > We'd like to find out which kernel functions are burning extra CPU
> > cycles and maybe understand why.

I can only found the old kernels for raw tip/ras/core branch, which reproduced
this regressions.

  1de08dccd383 x86/mce: Add a struct mce.kflags field
  9554bfe403bd x86/mce: Convert the CEC to use the MCE notifier

And strange thing is after using gcc9 and debian10 rootfs, with same commits
the regression turns to a improvement, though the trend keeps, that if we
changes the kflags from __u64 to __u32, the performance will be no change.

Following is the comparing of regression, I also attached the perf-profile
for old and new commit (let me know if you need more data)


9554bfe403bdfc08 1de08dccd383482a3e88845d355 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    192362           -15.1%     163343        will-it-scale.287.processes
      0.91            +0.2%       0.92        will-it-scale.287.processes_idle
    669.67           -15.1%     568.50        will-it-scale.per_process_ops
    309.97            +0.2%     310.74        will-it-scale.time.elapsed_time
    309.97            +0.2%     310.74        will-it-scale.time.elapsed_time.max
      0.67 ±141%    +200.0%       2.00 ± 50%  will-it-scale.time.involuntary_context_switches
      9921            +0.8%      10004        will-it-scale.time.maximum_resident_set_size
      6110            +0.3%       6130        will-it-scale.time.minor_page_faults
      4096            +0.0%       4096        will-it-scale.time.page_size
      0.18 ±  2%      +1.9%       0.18 ±  5%  will-it-scale.time.system_time
      0.25 ±  3%      +0.0%       0.25 ±  4%  will-it-scale.time.user_time
     73.00           +12.3%      82.00 ±  3%  will-it-scale.time.voluntary_context_switches
    192362           -15.1%     163343        will-it-scale.workload
    366.22            +0.3%     367.20        uptime.boot
     15417 ±  4%      +0.8%      15533        uptime.idle
 1.347e+09 ±  2%      -1.9%  1.321e+09        cpuidle.C1.time
   2623112 ±  7%      +5.7%    2773573        cpuidle.C1.usage
    532385 ± 70%     -98.7%       7012 ± 13%  cpuidle.POLL.time
     11803 ± 72%     -96.7%     392.50 ± 13%  cpuidle.POLL.usage
      1.44 ±  4%      +0.1        1.52        mpstat.cpu.all.idle%
      0.00 ± 41%      +0.0        0.00 ± 19%  mpstat.cpu.all.soft%
     98.01            -0.0       97.98        mpstat.cpu.all.sys%
      0.55 ±  3%      -0.1        0.50        mpstat.cpu.all.usr%
      0.00          -100.0%       0.00        numa-numastat.node0.interleave_hit
   1.2e+08           -14.5%  1.026e+08        numa-numastat.node0.local_node
   1.2e+08           -14.5%  1.026e+08        numa-numastat.node0.numa_hit
      0.00          -100.0%       0.00        numa-numastat.node0.other_node
      0.00          -100.0%       0.00        numa-numastat.node1.interleave_hit
      0.00          -100.0%       0.00        numa-numastat.node1.local_node
      0.00          -100.0%       0.00        numa-numastat.node1.numa_hit
      0.00          -100.0%       0.00        numa-numastat.node1.other_node
    309.97            +0.2%     310.74        time.elapsed_time
    309.97            +0.2%     310.74        time.elapsed_time.max
      0.67 ±141%    +200.0%       2.00 ± 50%  time.involuntary_context_switches
      9921            +0.8%      10004        time.maximum_resident_set_size
      6110            +0.3%       6130        time.minor_page_faults
      4096            +0.0%       4096        time.page_size
      0.18 ±  2%      +1.9%       0.18 ±  5%  time.system_time
      0.25 ±  3%      +0.0%       0.25 ±  4%  time.user_time
     73.00           +12.3%      82.00 ±  3%  time.voluntary_context_switches
      1.00           +50.0%       1.50 ± 33%  vmstat.cpu.id
     97.00            +0.0%      97.00        vmstat.cpu.sy
      0.00          -100.0%       0.00        vmstat.cpu.us
      0.00          -100.0%       0.00        vmstat.io.bi
      4.00            +0.0%       4.00        vmstat.memory.buff
   1574390            -0.1%    1573361        vmstat.memory.cache
  79173849            +0.0%   79177727        vmstat.memory.free
    282.33            -0.1%     282.00        vmstat.procs.r
      2760            -0.4%       2749        vmstat.system.cs
    364380 ± 12%      -1.4%     359417        vmstat.system.in
     10.07            -8.7%       9.20        perf-stat.i.MPKI
 1.005e+10            +1.6%  1.022e+10        perf-stat.i.branch-instructions
      1.30            -0.1        1.16        perf-stat.i.branch-miss-rate%
  1.26e+08            -9.7%  1.138e+08        perf-stat.i.branch-misses
     13.62            +0.2       13.86        perf-stat.i.cache-miss-rate%
  55442235 ±  2%      -6.1%   52078517        perf-stat.i.cache-misses
 4.077e+08 ±  2%      -7.6%  3.766e+08        perf-stat.i.cache-references
      2747            -0.3%       2739        perf-stat.i.context-switches
     10.85            -1.4%      10.70        perf-stat.i.cpi
    288378            +0.1%     288596        perf-stat.i.cpu-clock
 4.467e+11            -0.0%  4.465e+11        perf-stat.i.cpu-cycles
    267.78            +0.2%     268.24        perf-stat.i.cpu-migrations
      8033 ±  2%      +6.4%       8547        perf-stat.i.cycles-between-cache-misses
      0.18            -0.0        0.16        perf-stat.i.iTLB-load-miss-rate%
  68968473           -11.4%   61127131        perf-stat.i.iTLB-load-misses
 4.114e+10            +1.4%  4.172e+10        perf-stat.i.iTLB-loads
 4.109e+10            +1.4%  4.167e+10        perf-stat.i.instructions
    598.48           +14.8%     687.20        perf-stat.i.instructions-per-iTLB-miss
      0.09            +1.4%       0.09        perf-stat.i.ipc
      1.55            -0.1%       1.55        perf-stat.i.metric.GHz
      1.35           -15.1%       1.15        perf-stat.i.metric.K/sec
    178.94            +1.3%     181.27        perf-stat.i.metric.M/sec
    195779           -14.8%     166863        perf-stat.i.minor-faults
    195779           -14.8%     166863        perf-stat.i.page-faults
    288378            +0.1%     288596        perf-stat.i.task-clock
      9.92            -8.9%       9.04        perf-stat.overall.MPKI
      1.25            -0.1        1.11        perf-stat.overall.branch-miss-rate%
     13.66            +0.2       13.89        perf-stat.overall.cache-miss-rate%
     10.87            -1.5%      10.71        perf-stat.overall.cpi
      8026 ±  2%      +6.3%       8534        perf-stat.overall.cycles-between-cache-misses
      0.17            -0.0        0.15        perf-stat.overall.iTLB-load-miss-rate%
    596.26           +14.2%     681.07        perf-stat.overall.instructions-per-iTLB-miss
      0.09            +1.5%       0.09        perf-stat.overall.ipc
  65896092           +19.8%   78932072        perf-stat.overall.path-length
 1.002e+10            +1.6%  1.018e+10        perf-stat.ps.branch-instructions
 1.254e+08            -9.5%  1.134e+08        perf-stat.ps.branch-misses
  55492415 ±  2%      -6.1%   52128690        perf-stat.ps.cache-misses
 4.062e+08 ±  2%      -7.6%  3.754e+08        perf-stat.ps.cache-references
      2689            -0.4%       2677        perf-stat.ps.context-switches
    286795            +0.0%     286862        perf-stat.ps.cpu-clock
 4.452e+11            -0.1%  4.449e+11        perf-stat.ps.cpu-cycles
    253.81            +0.2%     254.32        perf-stat.ps.cpu-migrations
  68711344           -11.3%   60977219        perf-stat.ps.iTLB-load-misses
 4.098e+10            +1.4%  4.156e+10        perf-stat.ps.iTLB-loads
 4.096e+10            +1.4%  4.153e+10        perf-stat.ps.instructions
    194243           -14.6%     165836        perf-stat.ps.minor-faults
    194243           -14.6%     165836        perf-stat.ps.page-faults
    286795            +0.0%     286862        perf-stat.ps.task-clock
 1.268e+13            +1.7%  1.289e+13        perf-stat.total.instructions
      0.00          -100.0%       0.00        proc-vmstat.compact_isolated
    153775            +0.1%     153982        proc-vmstat.nr_active_anon
     34.00 ±  7%      -5.9%      32.00 ±  9%  proc-vmstat.nr_active_file
    111205            -0.4%     110762        proc-vmstat.nr_anon_pages
     61.00 ± 31%     +14.8%      70.00 ±  5%  proc-vmstat.nr_anon_transparent_hugepages
     58.67            -1.1%      58.00        proc-vmstat.nr_dirtied
      5.00            +0.0%       5.00        proc-vmstat.nr_dirty
   1963650            +0.0%    1963749        proc-vmstat.nr_dirty_background_threshold
   3932102            +0.0%    3932300        proc-vmstat.nr_dirty_threshold
    360190            +0.0%     360264        proc-vmstat.nr_file_pages
     49937            +0.0%      49937        proc-vmstat.nr_free_cma
  19794023            +0.0%   19795020        proc-vmstat.nr_free_pages
      5663            -0.0%       5661        proc-vmstat.nr_inactive_anon
     98.00 ±  3%      +0.0%      98.00 ±  7%  proc-vmstat.nr_inactive_file
     13.33 ± 60%     +61.2%      21.50 ±  2%  proc-vmstat.nr_isolated_anon
     40539            -0.0%      40522        proc-vmstat.nr_kernel_stack
     12404            -0.5%      12343        proc-vmstat.nr_mapped
    430.00           -49.9%     215.50 ± 99%  proc-vmstat.nr_mlock
     15352            -0.0%      15347        proc-vmstat.nr_page_table_pages
     48318            +1.3%      48928        proc-vmstat.nr_shmem
     33638            -0.6%      33432        proc-vmstat.nr_slab_reclaimable
     80590            -0.7%      80051        proc-vmstat.nr_slab_unreclaimable
    311806            -0.2%     311237        proc-vmstat.nr_unevictable
      0.00          -100.0%       0.00        proc-vmstat.nr_unstable
      0.00          -100.0%       0.00        proc-vmstat.nr_writeback
     57.67            -1.2%      57.00        proc-vmstat.nr_written
    153775            +0.1%     153982        proc-vmstat.nr_zone_active_anon
     34.00 ±  7%      -5.9%      32.00 ±  9%  proc-vmstat.nr_zone_active_file
      5663            -0.0%       5661        proc-vmstat.nr_zone_inactive_anon
     98.00 ±  3%      +0.0%      98.00 ±  7%  proc-vmstat.nr_zone_inactive_file
    311806            -0.2%     311237        proc-vmstat.nr_zone_unevictable
      5.00            +0.0%       5.00        proc-vmstat.nr_zone_write_pending
      2788 ±  8%      -1.2%       2755 ± 11%  proc-vmstat.numa_hint_faults
      2788 ±  8%      -1.2%       2755 ± 11%  proc-vmstat.numa_hint_faults_local
   1.2e+08           -14.5%  1.026e+08        proc-vmstat.numa_hit
    121.00 ± 28%     +59.9%     193.50 ± 20%  proc-vmstat.numa_huge_pte_updates
      0.00          -100.0%       0.00        proc-vmstat.numa_interleave
   1.2e+08           -14.5%  1.026e+08        proc-vmstat.numa_local
      0.00          -100.0%       0.00        proc-vmstat.numa_other
     65275 ± 26%     +56.7%     102311 ± 20%  proc-vmstat.numa_pte_updates
      6292 ±  6%      +0.7%       6335 ±  2%  proc-vmstat.pgactivate
      0.00          -100.0%       0.00        proc-vmstat.pgalloc_dma32
 1.201e+08           -14.5%  1.027e+08        proc-vmstat.pgalloc_normal
  60452926           -14.4%   51751356        proc-vmstat.pgfault
   1.2e+08           -14.5%  1.026e+08        proc-vmstat.pgfree
      0.00          -100.0%       0.00        proc-vmstat.pgpgin
     50.00 ± 52%     +18.0%      59.00 ± 10%  proc-vmstat.thp_collapse_alloc
     32.00            +0.0%      32.00        proc-vmstat.thp_fault_alloc
      0.00          -100.0%       0.00        proc-vmstat.thp_zero_page_alloc
    105.00            -0.5%     104.50        proc-vmstat.unevictable_pgs_culled
    549.00            +0.0%     549.00        proc-vmstat.unevictable_pgs_mlocked
      0.68 ± 70%      -0.7        0.00        pp.bt.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt
      0.56 ±  2%      -0.6        0.00        pp.bt.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.76            -0.1        0.65        pp.bt.mmap64
      0.68            -0.1        0.57        pp.bt.entry_SYSCALL_64_after_hwframe.mmap64
      0.64            -0.1        0.54        pp.bt.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.mmap64
      0.65            -0.1        0.55        pp.bt.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.mmap64
      0.67            -0.1        0.57        pp.bt.do_syscall_64.entry_SYSCALL_64_after_hwframe.mmap64
      0.82            -0.1        0.74 ±  2%  pp.bt.handle_mm_fault.do_page_fault.page_fault
      0.78            -0.1        0.70        pp.bt.__handle_mm_fault.handle_mm_fault.do_page_fault.page_fault
      0.70            -0.1        0.62        pp.bt.handle_pte_fault.__handle_mm_fault.handle_mm_fault.do_page_fault.page_fault
      1.03            -0.1        0.95        pp.bt.page_fault
      0.99            -0.1        0.92 ±  2%  pp.bt.do_page_fault.page_fault
      0.92            -0.1        0.86        pp.bt.unmap_vmas.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap
      0.85            -0.1        0.80        pp.bt.unmap_page_range.unmap_vmas.unmap_region.__do_munmap.__vm_munmap
      1.42 ±  4%      -0.0        1.37        pp.bt.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt._raw_spin_unlock_irqrestore
      0.99 ±  6%      -0.0        0.95        pp.bt._raw_spin_unlock_irqrestore.release_pages.tlb_flush_mmu.tlb_finish_mmu.unmap_region
      0.98 ±  5%      -0.0        0.94        pp.bt.apic_timer_interrupt._raw_spin_unlock_irqrestore.release_pages.tlb_flush_mmu.tlb_finish_mmu
      0.94 ±  6%      -0.0        0.91        pp.bt.smp_apic_timer_interrupt.apic_timer_interrupt._raw_spin_unlock_irqrestore.release_pages.tlb_flush_mmu
      0.82 ±  5%      -0.0        0.79        pp.bt.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt._raw_spin_unlock_irqrestore.release_pages
      0.82 ±  5%      -0.0        0.81        pp.bt.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt._raw_spin_unlock_irqrestore.pagevec_lru_move_fn
      0.95 ±  5%      -0.0        0.94        pp.bt.smp_apic_timer_interrupt.apic_timer_interrupt._raw_spin_unlock_irqrestore.pagevec_lru_move_fn.lru_add_drain_cpu
      0.98 ±  5%      -0.0        0.97        pp.bt.apic_timer_interrupt._raw_spin_unlock_irqrestore.pagevec_lru_move_fn.lru_add_drain_cpu.lru_add_drain
      0.98 ±  5%      -0.0        0.97        pp.bt._raw_spin_unlock_irqrestore.pagevec_lru_move_fn.lru_add_drain_cpu.lru_add_drain.unmap_region
     47.85            +0.1       47.95        pp.bt.tlb_finish_mmu.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap
     47.84            +0.1       47.94        pp.bt.tlb_flush_mmu.tlb_finish_mmu.unmap_region.__do_munmap.__vm_munmap
     47.71            +0.1       47.83        pp.bt.release_pages.tlb_flush_mmu.tlb_finish_mmu.unmap_region.__do_munmap
     97.48            +0.2       97.64        pp.bt.munmap
     97.35            +0.2       97.53        pp.bt.entry_SYSCALL_64_after_hwframe.munmap
     97.34            +0.2       97.52        pp.bt.do_syscall_64.entry_SYSCALL_64_after_hwframe.munmap
     46.37            +0.2       46.55        pp.bt._raw_spin_lock_irqsave.release_pages.tlb_flush_mmu.tlb_finish_mmu.unmap_region
     46.34            +0.2       46.52        pp.bt.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.release_pages.tlb_flush_mmu.tlb_finish_mmu
     96.76            +0.2       96.97        pp.bt.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     96.81            +0.2       97.03        pp.bt.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.munmap
     96.80            +0.2       97.02        pp.bt.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.munmap
     47.47            +0.2       47.71        pp.bt.lru_add_drain.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap
     47.46            +0.2       47.70        pp.bt.lru_add_drain_cpu.lru_add_drain.unmap_region.__do_munmap.__vm_munmap
     47.44            +0.2       47.68        pp.bt.pagevec_lru_move_fn.lru_add_drain_cpu.lru_add_drain.unmap_region.__do_munmap
     96.55            +0.2       96.80        pp.bt.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
     46.22            +0.3       46.48        pp.bt._raw_spin_lock_irqsave.pagevec_lru_move_fn.lru_add_drain_cpu.lru_add_drain.unmap_region
     46.19            +0.3       46.47        pp.bt.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.pagevec_lru_move_fn.lru_add_drain_cpu.lru_add_drain
      0.76            -0.1        0.65        pp.child.mmap64
      0.66            -0.1        0.56        pp.child.vm_mmap_pgoff
      0.67            -0.1        0.57        pp.child.ksys_mmap_pgoff
      0.58 ±  2%      -0.1        0.49        pp.child.do_mmap
      0.11 ± 37%      -0.1        0.03 ±100%  pp.child.timerqueue_del
      2.02 ±  4%      -0.1        1.94        pp.child.smp_apic_timer_interrupt
      2.11 ±  4%      -0.1        2.03        pp.child.apic_timer_interrupt
      1.51 ±  4%      -0.1        1.44        pp.child.__hrtimer_run_queues
      0.79            -0.1        0.71        pp.child.__handle_mm_fault
      0.84            -0.1        0.77        pp.child.handle_mm_fault
      1.07            -0.1        0.99        pp.child.page_fault
      1.75 ±  4%      -0.1        1.68        pp.child.hrtimer_interrupt
      0.71            -0.1        0.64        pp.child.handle_pte_fault
      0.44 ±  2%      -0.1        0.36        pp.child.mmap_region
      0.07 ± 70%      -0.1        0.00        pp.child.rb_next
      1.02            -0.1        0.95        pp.child.do_page_fault
      0.06            -0.1        0.00        pp.child.free_unref_page_commit
      0.93            -0.1        0.87        pp.child.unmap_vmas
      2.06 ±  6%      -0.1        2.00        pp.child._raw_spin_unlock_irqrestore
      0.05            -0.1        0.00        pp.child.__might_sleep
      0.05            -0.1        0.00        pp.child.find_vma
      0.51            -0.0        0.46        pp.child.exit_to_usermode_loop
      0.27            -0.0        0.22        pp.child.get_page_from_freelist
      0.32            -0.0        0.27        pp.child.__alloc_pages_nodemask
      0.87            -0.0        0.83        pp.child.unmap_page_range
      0.39 ± 29%      -0.0        0.35 ± 34%  pp.child.cmd_record
      0.39 ± 29%      -0.0        0.35 ± 34%  pp.child.perf_mmap__push
      0.36 ± 27%      -0.0        0.32 ± 34%  pp.child.ksys_write
      0.50            -0.0        0.46        pp.child.task_work_run
      0.50            -0.0        0.46        pp.child.task_numa_work
      0.18 ±  4%      -0.0        0.14        pp.child.perf_event_mmap
      0.39 ± 29%      -0.0        0.35 ± 35%  pp.child.__libc_start_main
      0.39 ± 29%      -0.0        0.35 ± 35%  pp.child.main
      0.38 ± 28%      -0.0        0.35 ± 33%  pp.child.__GI___libc_write
      0.17 ±  2%      -0.0        0.14 ±  3%  pp.child.prep_new_page
      0.35 ± 27%      -0.0        0.31 ± 35%  pp.child.vfs_write
      0.12 ±  8%      -0.0        0.08        pp.child.perf_iterate_sb
      0.50            -0.0        0.46        pp.child.change_protection
      0.50            -0.0        0.46        pp.child.change_prot_numa
      0.50            -0.0        0.46        pp.child.change_p4d_range
      0.25 ±  3%      -0.0        0.21 ±  2%  pp.child.__pte_alloc
      0.03 ± 70%      -0.0        0.00        pp.child.mem_cgroup_try_charge_delay
      0.03 ± 70%      -0.0        0.00        pp.child.__put_anon_vma
      0.15 ±  3%      -0.0        0.12        pp.child.clear_page_erms
      0.23 ±  2%      -0.0        0.20 ±  2%  pp.child.pte_alloc_one
      0.32 ± 28%      -0.0        0.29 ± 34%  pp.child.generic_file_write_iter
      0.31 ± 29%      -0.0        0.28 ± 35%  pp.child.__generic_file_write_iter
      0.30 ± 28%      -0.0        0.28 ± 34%  pp.child.generic_perform_write
      0.32 ± 28%      -0.0        0.30 ± 35%  pp.child.new_sync_write
      0.11 ±  4%      -0.0        0.09        pp.child.free_unref_page_list
      0.99 ±  4%      -0.0        0.97        pp.child.update_process_times
      1.06 ±  4%      -0.0        1.04        pp.child.tick_sched_timer
      0.16            -0.0        0.14        pp.child.alloc_pages_vma
      0.12            -0.0        0.10        pp.child.get_unmapped_area
      1.01 ±  4%      -0.0        0.99        pp.child.tick_sched_handle
      0.54 ±  3%      -0.0        0.53        pp.child.task_tick_fair
      0.78 ±  5%      -0.0        0.76        pp.child.scheduler_tick
      0.02 ±141%      -0.0        0.00        pp.child.iov_iter_fault_in_readable
      0.02 ±141%      -0.0        0.00        pp.child.enqueue_hrtimer
      0.32            -0.0        0.30        pp.child.___might_sleep
      0.17 ±  2%      -0.0        0.15        pp.child._cond_resched
      0.07 ±  7%      -0.0        0.05        pp.child.kmem_cache_free
      0.16            -0.0        0.15 ±  3%  pp.child.irq_exit
      0.13 ±  3%      -0.0        0.12        pp.child.free_pgtables
      0.12 ±  3%      -0.0        0.11        pp.child.unlink_anon_vmas
      0.11 ± 11%      -0.0        0.10        pp.child.perf_mux_hrtimer_handler
      0.08 ±  5%      -0.0        0.07        pp.child._raw_spin_lock
      0.10 ±  4%      -0.0        0.08 ±  5%  pp.child.arch_get_unmapped_area_topdown
      0.10            -0.0        0.09        pp.child.__update_load_avg_cfs_rq
      0.22 ± 28%      -0.0        0.21 ± 38%  pp.child.shmem_write_begin
      0.22 ± 28%      -0.0        0.21 ± 38%  pp.child.shmem_getpage_gfp
      0.16 ±  5%      -0.0        0.15        pp.child.update_curr
      0.13            -0.0        0.12        pp.child.__anon_vma_prepare
      0.13            -0.0        0.12        pp.child.free_pgd_range
      0.09 ±  9%      -0.0        0.08        pp.child.mem_cgroup_uncharge_list
      0.07            -0.0        0.06        pp.child.vm_unmapped_area
      0.07            -0.0        0.06        pp.child.percpu_counter_add_batch
      0.12            -0.0        0.11        pp.child.free_p4d_range
      0.09 ±  5%      -0.0        0.08        pp.child.kmem_cache_alloc
      0.06 ±  8%      -0.0        0.05        pp.child.rcu_sched_clock_irq
      0.06 ±  8%      -0.0        0.05        pp.child.remove_vma
      0.07            -0.0        0.07 ±  7%  pp.child.rcu_all_qs
      0.06            -0.0        0.06 ±  9%  pp.child.run_timer_softirq
      0.06            -0.0        0.06 ±  9%  pp.child.malloc
      0.07 ±  6%      -0.0        0.07        pp.child.flush_tlb_mm_range
      0.05 ±  8%      -0.0        0.05        pp.child.entry_SYSCALL_64
      0.05 ±  8%      -0.0        0.05        pp.child.vma_link
      0.06 ±  8%      -0.0        0.06 ±  9%  pp.child.clockevents_program_event
      0.05            -0.0        0.05        pp.child.vm_normal_page
      0.06            +0.0        0.06        pp.child.syscall_return_via_sysret
      0.06            +0.0        0.06        pp.child.uncharge_batch
      0.11 ±  4%      +0.0        0.11 ±  4%  pp.child.__softirqentry_text_start
      0.09 ±  5%      +0.0        0.10 ±  5%  pp.child.__update_load_avg_se
      0.16 ± 26%      +0.0        0.16 ± 27%  pp.child.__lru_cache_add
      0.11 ±  4%      +0.0        0.12        pp.child.__pagevec_lru_add_fn
      0.02 ±141%      +0.0        0.03 ±100%  pp.child.interrupt_entry
      0.07 ± 18%      +0.0        0.08        pp.child.update_rq_clock
      0.11 ±  4%      +0.0        0.12 ±  4%  pp.child.__perf_sw_event
      0.09 ±  5%      +0.0        0.11 ±  4%  pp.child.___perf_sw_event
      0.04 ± 70%      +0.0        0.06        pp.child.perf_event_task_tick
      0.13 ± 31%      +0.0        0.15 ±  3%  pp.child.__remove_hrtimer
      0.07            +0.0        0.11 ±  4%  pp.child.__mod_lruvec_state
      0.00            +0.1        0.05        pp.child.irq_enter
      0.00            +0.1        0.05 ±100%  pp.child.isolate_lru_page
     98.48            +0.1       98.53        pp.child.do_syscall_64
      0.00            +0.1        0.06 ±  9%  pp.child.mmput
      0.00            +0.1        0.06 ±  9%  pp.child.exit_mmap
     98.50            +0.1       98.56        pp.child.entry_SYSCALL_64_after_hwframe
      0.02 ±141%      +0.1        0.08 ±  6%  pp.child.__mod_memcg_state
      0.00            +0.1        0.06 ±100%  pp.child.khugepaged
      0.00            +0.1        0.06 ±100%  pp.child._raw_spin_lock_irq
      0.00            +0.1        0.07 ±100%  pp.child.ret_from_fork
      0.00            +0.1        0.07 ±100%  pp.child.kthread
     47.88            +0.1       47.98        pp.child.tlb_finish_mmu
     47.87            +0.1       47.98        pp.child.tlb_flush_mmu
     47.79            +0.1       47.90        pp.child.release_pages
     97.50            +0.2       97.66        pp.child.munmap
     96.82            +0.2       97.03        pp.child.__x64_sys_munmap
     96.81            +0.2       97.03        pp.child.__vm_munmap
     96.79            +0.2       97.01        pp.child.__do_munmap
     47.66            +0.2       47.91        pp.child.pagevec_lru_move_fn
     47.52            +0.2       47.77        pp.child.lru_add_drain
     47.51            +0.3       47.76        pp.child.lru_add_drain_cpu
     96.58            +0.3       96.83        pp.child.unmap_region
     92.87            +0.5       93.34        pp.child._raw_spin_lock_irqsave
     92.80            +0.5       93.31        pp.child.native_queued_spin_lock_slowpath
      0.15 ± 28%      -0.1        0.07        pp.self.__hrtimer_run_queues
      0.07 ± 70%      -0.1        0.00        pp.self.rb_next
      0.05            -0.1        0.00        pp.self.__pagevec_lru_add_fn
      0.05            -0.1        0.00        pp.self.run_timer_softirq
      0.05            -0.1        0.00        pp.self.free_unref_page_commit
      0.15 ±  3%      -0.0        0.11        pp.self.clear_page_erms
      0.44            -0.0        0.41        pp.self.change_p4d_range
      0.08 ±  5%      -0.0        0.06 ±  9%  pp.self.perf_iterate_sb
      0.47 ±  2%      -0.0        0.45        pp.self.unmap_page_range
      0.02 ±141%      -0.0        0.00        pp.self.smp_apic_timer_interrupt
      0.30            -0.0        0.29        pp.self.___might_sleep
      0.02 ±141%      -0.0        0.00        pp.self.malloc
      0.02 ±141%      -0.0        0.00        pp.self.entry_SYSCALL_64
      0.02 ±141%      -0.0        0.00        pp.self.__might_sleep
      0.08 ± 10%      -0.0        0.07 ±  7%  pp.self._raw_spin_lock
      0.09 ± 14%      -0.0        0.08 ±  6%  pp.self.hrtimer_interrupt
      0.09 ±  5%      -0.0        0.08 ±  6%  pp.self.release_pages
      0.10 ±  8%      -0.0        0.09        pp.self._raw_spin_unlock_irqrestore
      0.09            -0.0        0.08        pp.self.__update_load_avg_cfs_rq
      0.06            -0.0        0.05        pp.self.do_page_fault
      0.06            -0.0        0.05        pp.self.kmem_cache_free
      0.09 ±  5%      -0.0        0.08 ±  5%  pp.self.free_p4d_range
      0.08 ±  5%      -0.0        0.08 ±  6%  pp.self._cond_resched
      0.07 ±  7%      -0.0        0.06        pp.self.vm_unmapped_area
      0.06 ±  8%      -0.0        0.05        pp.self.kmem_cache_alloc
      0.06            -0.0        0.06 ±  9%  pp.self.rcu_all_qs
      0.08            -0.0        0.08 ±  6%  pp.self.__update_load_avg_se
      0.09 ±  5%      -0.0        0.09        pp.self.update_curr
      0.07 ±  6%      -0.0        0.07        pp.self._raw_spin_lock_irqsave
      0.11 ±  4%      -0.0        0.11        pp.self.task_tick_fair
      0.07 ±  7%      -0.0        0.07 ±  7%  pp.self.get_page_from_freelist
      0.06 ±  8%      -0.0        0.06 ±  9%  pp.self.__handle_mm_fault
      0.05            -0.0        0.05        pp.self.__do_munmap
      0.06            +0.0        0.06        pp.self.syscall_return_via_sysret
      0.02 ±141%      +0.0        0.03 ±100%  pp.self.update_rq_clock
      0.02 ±141%      +0.0        0.03 ±100%  pp.self.interrupt_entry
      0.04 ± 70%      +0.0        0.06 ±  9%  pp.self.perf_event_task_tick
      0.00            +0.0        0.03 ±100%  pp.self.vm_normal_page
      0.05            +0.0        0.08        pp.self.___perf_sw_event
      0.02 ±141%      +0.1        0.08 ±  6%  pp.self.__mod_memcg_state
      0.00            +0.1        0.11 ±  4%  pp.self.__remove_hrtimer
     92.80            +0.5       93.31        pp.self.native_queued_spin_lock_slowpath
    333.33            -0.2%     332.50        softirqs.BLOCK
      5.00            +0.0%       5.00        softirqs.HI
     17005 ± 69%     -64.3%       6074 ±  8%  softirqs.NET_RX
     45.33            +0.4%      45.50 ±  3%  softirqs.NET_TX
   1322815 ±  2%      -1.3%    1305414        softirqs.RCU
    633707 ±  9%      +1.9%     645991 ± 11%  softirqs.SCHED
    293.00            -0.2%     292.50        softirqs.TASKLET
  35621870           +12.5%   40074312        softirqs.TIMER
    344034            -0.3%     343007        interrupts.CAL:Function_call_interrupts
    396.00            -0.1%     395.50        interrupts.IWI:IRQ_work_interrupts
 1.102e+08 ± 13%      -1.1%   1.09e+08        interrupts.LOC:Local_timer_interrupts
    288.00            +0.0%     288.00        interrupts.MCP:Machine_check_polls
   1451499            +1.0%    1465843        interrupts.NMI:Non-maskable_interrupts
   1451499            +1.0%    1465843        interrupts.PMI:Performance_monitoring_interrupts
     24121 ±  2%      +1.9%      24578 ±  7%  interrupts.RES:Rescheduling_interrupts
      1262 ±  2%     +12.5%       1421 ±  7%  interrupts.TLB:TLB_shootdowns

Thanks,
Feng


--GvXjxJ+pjyke8COw
Content-Type: application/x-trash
Content-Disposition: attachment; filename="perf-profile.old"
Content-Transfer-Encoding: quoted-printable

# =3D=3D=3D=3D=3D=3D=3D=3D=0A# captured on    : Wed Aug 19 13:29:35 2020=0A=
# header version : 1=0A# data offset    : 4984=0A# data size      : 2689165=
20=0A# feat offset    : 268921504=0A# hostname : lkp-knm01=0A# os release :=
 5.7.0-rc1-00010-g9554bfe403bdf=0A# perf version : 5.8.rc2.g3e08a95294a4=0A=
# arch : x86_64=0A# nrcpus online : 288=0A# nrcpus avail : 288=0A# cpudesc =
: Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz=0A# cpuid : GenuineIntel,6,133,0=
=0A# total memory : 82305680 kB=0A# cmdline : /lkp/benchmarks/perf/perf rec=
ord -q -ag --realtime=3D1 -m 256 --count=3D1000003 -e cycles:pp -o /tmp/lkp=
/perf.data -D 100000 -- /lkp/lkp/src/bin/event/wait post-test --timeout 110=
 =0A# event : name =3D cycles:pp, , id =3D { 5278, 5279, 5280, 5281, 5282, =
5283, 5284, 5285, 5286, 5287, 5288, 5289, 5290, 5291, 5292, 5293, 5294, 529=
5, 5296, 5297, 5298, 5299, 5300, 5301, 5302, 5303, 5304, 5305, 5306, 5307, =
5308, 5309, 5310, 5311, 5312, 5313, 5314, 5315, 5316, 5317, 5318, 5319, 532=
0, 5321, 5322, 5323, 5324, 5325, 5326, 5327, 5328, 5329, 5330, 5331, 5332, =
5333, 5334, 5335, 5336, 5337, 5338, 5339, 5340, 5341, 5342, 5343, 5344, 534=
5, 5346, 5347, 5348, 5349, 5350, 5351, 5352, 5353, 5354, 5355, 5356, 5357, =
5358, 5359, 5360, 5361, 5362, 5363, 5364, 5365, 5366, 5367, 5368, 5369, 537=
0, 5371, 5372, 5373, 5374, 5375, 5376, 5377, 5378, 5379, 5380, 5381, 5382, =
5383, 5384, 5385, 5386, 5387, 5388, 5389, 5390, 5391, 5392, 5393, 5394, 539=
5, 5396, 5397, 5398, 5399, 5400, 5401, 5402, 5403, 5404, 5405, 5406, 5407, =
5408, 5409, 5410, 5411, 5412, 5413, 5414, 5415, 5416, 5417, 5418, 5419, 542=
0, 5421, 5422, 5423, 5424, 5425, 5426, 5427, 5428, 5429, 5430, 5431, 5432, =
5433, 5434, 5435, 5436, 5437, 5438, 5439, 5440, 5441, 5442, 5443, 5444, 544=
5, 5446, 5447, 5448, 5449, 5450, 5451, 5452, 5453, 5454, 5455, 5456, 5457, =
5458, 5459, 5460, 5461, 5462, 5463, 5464, 5465, 5466, 5467, 5468, 5469, 547=
0, 5471, 5472, 5473, 5474, 5475, 5476, 5477, 5478, 5479, 5480, 5481, 5482, =
5483, 5484, 5485, 5486, 5487, 5488, 5489, 5490, 5491, 5492, 5493, 5494, 549=
5, 5496, 5497, 5498, 5499, 5500, 5501, 5502, 5503, 5504, 5505, 5506, 5507, =
5508, 5509, 5510, 5511, 5512, 5513, 5514, 5515, 5516, 5517, 5518, 5519, 552=
0, 5521, 5522, 5523, 5524, 5525, 5526, 5527, 5528, 5529, 5530, 5531, 5532, =
5533, 5534, 5535, 5536, 5537, 5538, 5539, 5540, 5541, 5542, 5543, 5544, 554=
5, 5546, 5547, 5548, 5549, 5550, 5551, 5552, 5553, 5554, 5555, 5556, 5557, =
5558, 5559, 5560, 5561, 5562, 5563, 5564, 5565 }, size =3D 120, { sample_pe=
riod, sample_freq } =3D 1000003, sample_type =3D IP|TID|TIME|CALLCHAIN|ID|C=
PU, read_format =3D ID, disabled =3D 1, inherit =3D 1, precise_ip =3D 2, sa=
mple_id_all =3D 1, exclude_guest =3D 1=0A# event : name =3D dummy:HG, , id =
=3D { 5566, 5567, 5568, 5569, 5570, 5571, 5572, 5573, 5574, 5575, 5576, 557=
7, 5578, 5579, 5580, 5581, 5582, 5583, 5584, 5585, 5586, 5587, 5588, 5589, =
5590, 5591, 5592, 5593, 5594, 5595, 5596, 5597, 5598, 5599, 5600, 5601, 560=
2, 5603, 5604, 5605, 5606, 5607, 5608, 5609, 5610, 5611, 5612, 5613, 5614, =
5615, 5616, 5617, 5618, 5619, 5620, 5621, 5622, 5623, 5624, 5625, 5626, 562=
7, 5628, 5629, 5630, 5631, 5632, 5633, 5634, 5635, 5636, 5637, 5638, 5639, =
5640, 5641, 5642, 5643, 5644, 5645, 5646, 5647, 5648, 5649, 5650, 5651, 565=
2, 5653, 5654, 5655, 5656, 5657, 5658, 5659, 5660, 5661, 5662, 5663, 5664, =
5665, 5666, 5667, 5668, 5669, 5670, 5671, 5672, 5673, 5674, 5675, 5676, 567=
7, 5678, 5679, 5680, 5681, 5682, 5683, 5684, 5685, 5686, 5687, 5688, 5689, =
5690, 5691, 5692, 5693, 5694, 5695, 5696, 5697, 5698, 5699, 5700, 5701, 570=
2, 5703, 5704, 5705, 5706, 5707, 5708, 5709, 5710, 5711, 5712, 5713, 5714, =
5715, 5716, 5717, 5718, 5719, 5720, 5721, 5722, 5723, 5724, 5725, 5726, 572=
7, 5728, 5729, 5730, 5731, 5732, 5733, 5734, 5735, 5736, 5737, 5738, 5739, =
5740, 5741, 5742, 5743, 5744, 5745, 5746, 5747, 5748, 5749, 5750, 5751, 575=
2, 5753, 5754, 5755, 5756, 5757, 5758, 5759, 5760, 5761, 5762, 5763, 5764, =
5765, 5766, 5767, 5768, 5769, 5770, 5771, 5772, 5773, 5774, 5775, 5776, 577=
7, 5778, 5779, 5780, 5781, 5782, 5783, 5784, 5785, 5786, 5787, 5788, 5789, =
5790, 5791, 5792, 5793, 5794, 5795, 5796, 5797, 5798, 5799, 5800, 5801, 580=
2, 5803, 5804, 5805, 5806, 5807, 5808, 5809, 5810, 5811, 5812, 5813, 5814, =
5815, 5816, 5817, 5818, 5819, 5820, 5821, 5822, 5823, 5824, 5825, 5826, 582=
7, 5828, 5829, 5830, 5831, 5832, 5833, 5834, 5835, 5836, 5837, 5838, 5839, =
5840, 5841, 5842, 5843, 5844, 5845, 5846, 5847, 5848, 5849, 5850, 5851, 585=
2, 5853 }, type =3D 1, size =3D 120, config =3D 0x9, { sample_period, sampl=
e_freq } =3D 1000003, sample_type =3D IP|TID|TIME|CALLCHAIN|ID|CPU, read_fo=
rmat =3D ID, disabled =3D 1, inherit =3D 1, mmap =3D 1, comm =3D 1, enable_=
on_exec =3D 1, task =3D 1, sample_id_all =3D 1, mmap2 =3D 1, comm_exec =3D =
1, ksymbol =3D 1, bpf_event =3D 1=0A# CPU_TOPOLOGY info available, use -I t=
o display=0A# NUMA_TOPOLOGY info available, use -I to display=0A# pmu mappi=
ngs: uncore_cha_34 =3D 71, uncore_edc_uclk_5 =3D 24, uncore_cha_1 =3D 38, u=
ncore_cha_24 =3D 61, software =3D 1, uncore_cha_14 =3D 51, uncore_imc_5 =3D=
 15, uncore_edc_eclk_0 =3D 27, uncore_cha_32 =3D 69, uncore_edc_uclk_3 =3D =
22, uncore_cha_22 =3D 59, uncore_cha_12 =3D 49, uncore_imc_uclk_1 =3D 17, u=
ncore_imc_3 =3D 13, uncore_cha_8 =3D 45, uncore_cha_30 =3D 67, uncore_edc_u=
clk_1 =3D 20, uncore_cha_20 =3D 57, uncore_cha_10 =3D 47, uncore_edc_eclk_7=
 =3D 34, uncore_imc_1 =3D 11, power =3D 9, uncore_cha_6 =3D 43, uncore_cha_=
29 =3D 66, uncore_cha_19 =3D 56, uprobe =3D 7, uncore_edc_eclk_5 =3D 32, un=
core_cha_37 =3D 74, cpu =3D 4, uncore_cha_4 =3D 41, uncore_cha_27 =3D 64, u=
ncore_cha_17 =3D 54, cstate_core =3D 76, uncore_edc_eclk_3 =3D 30, uncore_c=
ha_35 =3D 72, breakpoint =3D 5, uncore_edc_uclk_6 =3D 25, uncore_cha_2 =3D =
39, uncore_cha_25 =3D 62, uncore_cha_15 =3D 52, uncore_edc_eclk_1 =3D 28, u=
ncore_cha_33 =3D 70, tracepoint =3D 2, uncore_edc_uclk_4 =3D 23, uncore_cha=
_0 =3D 37, uncore_cha_23 =3D 60, uncore_cha_13 =3D 50, cstate_pkg =3D 77, u=
ncore_imc_4 =3D 14, uncore_cha_9 =3D 46, uncore_cha_31 =3D 68, uncore_ubox =
=3D 36, uncore_edc_uclk_2 =3D 21, uncore_cha_21 =3D 58, uncore_cha_11 =3D 4=
8, uncore_imc_uclk_0 =3D 16, uncore_imc_2 =3D 12, kprobe =3D 6, uncore_cha_=
7 =3D 44, uncore_edc_uclk_0 =3D 19, uncore_edc_eclk_6 =3D 33, uncore_m2pcie=
 =3D 18, uncore_imc_0 =3D 10, uncore_cha_5 =3D 42, uncore_pcu =3D 75, uncor=
e_cha_28 =3D 65, uncore_cha_18 =3D 55, msr =3D 8, uncore_edc_eclk_4 =3D 31,=
 uncore_cha_36 =3D 73, uncore_edc_uclk_7 =3D 26, uncore_irp =3D 35, uncore_=
cha_3 =3D 40, uncore_cha_26 =3D 63, uncore_cha_16 =3D 53, uncore_edc_eclk_2=
 =3D 29=0A# CACHE info available, use -I to display=0A# time of first sampl=
e : 159.649673=0A# time of last sample : 169.797487=0A# sample duration :  =
10147.815 ms=0A# MEM_TOPOLOGY info available, use -I to display=0A# cpu pmu=
 capabilities: branches=3D8, max_precise=3D2, pmu_name=3Dknights-landing=0A=
# missing features: TRACING_DATA BRANCH_STACK GROUP_DESC AUXTRACE STAT CLOC=
KID DIR_FORMAT COMPRESSED =0A# =3D=3D=3D=3D=3D=3D=3D=3D=0A#=0A#=0A# Total L=
ost Samples: 40=0A#=0A# Samples: 1M of event 'cycles:pp'=0A# Event count (a=
pprox.): 1458671376001=0A#=0A# Children      Self  Shared Object       Symb=
ol                                            IPC   [IPC Coverage]=0A# ....=
=2E...  ........  ..................  .....................................=
=2E..........  ....................=0A#=0A    98.50%     0.02%  [kernel.kal=
lsyms]   [k] entry_SYSCALL_64_after_hwframe                -      -        =
    =0A97.30% entry_SYSCALL_64_after_hwframe;munmap=0A0.67% entry_SYSCALL_6=
4_after_hwframe;mmap64=0A    98.48%     0.03%  [kernel.kallsyms]   [k] do_s=
yscall_64                                 -      -            =0A97.29% do_=
syscall_64;entry_SYSCALL_64_after_hwframe;munmap=0A0.66% do_syscall_64;entr=
y_SYSCALL_64_after_hwframe;mmap64=0A    97.45%     0.03%  libc-2.24.so     =
   [.] munmap                                        -      -            =
=0A97.43% munmap=0A    96.78%     0.01%  [kernel.kallsyms]   [k] __x64_sys_=
munmap                              -      -            =0A96.77% __x64_sys=
_munmap;do_syscall_64;entry_SYSCALL_64_after_hwframe;munmap=0A    96.76%   =
  0.01%  [kernel.kallsyms]   [k] __vm_munmap                               =
    -      -            =0A96.75% __vm_munmap;__x64_sys_munmap;do_syscall_6=
4;entry_SYSCALL_64_after_hwframe;munmap=0A    96.74%     0.05%  [kernel.kal=
lsyms]   [k] __do_munmap                                   -      -        =
    =0A96.72% __do_munmap;__vm_munmap;__x64_sys_munmap;do_syscall_64;entry_=
SYSCALL_64_after_hwframe;munmap=0A    96.54%     0.03%  [kernel.kallsyms]  =
 [k] unmap_region                                  -      -            =0A9=
6.51% unmap_region;__do_munmap;__vm_munmap;__x64_sys_munmap;do_syscall_64;e=
ntry_SYSCALL_64_after_hwframe;munmap=0A    92.69%     0.08%  [kernel.kallsy=
ms]   [k] _raw_spin_lock_irqsave                        -      -           =
 =0A46.23% _raw_spin_lock_irqsave;release_pages;tlb_flush_mmu;tlb_finish_mm=
u;unmap_region;__do_munmap;__vm_munmap;__x64_sys_munmap;do_syscall_64;entry=
_SYSCALL_64_after_hwframe;munmap=0A46.15% _raw_spin_lock_irqsave;pagevec_lr=
u_move_fn;lru_add_drain_cpu;lru_add_drain;unmap_region;__do_munmap;__vm_mun=
map;__x64_sys_munmap;do_syscall_64;entry_SYSCALL_64_after_hwframe;munmap=0A=
    92.62%    92.62%  [kernel.kallsyms]   [k] native_queued_spin_lock_slowp=
ath              -      -            =0A46.20% native_queued_spin_lock_slow=
path;_raw_spin_lock_irqsave;release_pages;tlb_flush_mmu;tlb_finish_mmu;unma=
p_region;__do_munmap;__vm_munmap;__x64_sys_munmap;do_syscall_64;entry_SYSCA=
LL_64_after_hwframe;munmap=0A46.13% native_queued_spin_lock_slowpath;_raw_s=
pin_lock_irqsave;pagevec_lru_move_fn;lru_add_drain_cpu;lru_add_drain;unmap_=
region;__do_munmap;__vm_munmap;__x64_sys_munmap;do_syscall_64;entry_SYSCALL=
_64_after_hwframe;munmap=0A    47.82%     0.01%  [kernel.kallsyms]   [k] tl=
b_finish_mmu                                -      -            =0A47.79% t=
lb_finish_mmu;unmap_region;__do_munmap;__vm_munmap;__x64_sys_munmap;do_sysc=
all_64;entry_SYSCALL_64_after_hwframe;munmap=0A    47.81%     0.01%  [kerne=
l.kallsyms]   [k] tlb_flush_mmu                                 -      -   =
         =0A47.78% tlb_flush_mmu;tlb_finish_mmu;unmap_region;__do_munmap;__=
vm_munmap;__x64_sys_munmap;do_syscall_64;entry_SYSCALL_64_after_hwframe;mun=
map=0A    47.73%     0.08%  [kernel.kallsyms]   [k] release_pages          =
                       -      -            =0A47.66% release_pages;tlb_flus=
h_mmu;tlb_finish_mmu;unmap_region;__do_munmap;__vm_munmap;__x64_sys_munmap;=
do_syscall_64;entry_SYSCALL_64_after_hwframe;munmap=0A    47.70%     0.03% =
 [kernel.kallsyms]   [k] pagevec_lru_move_fn                           -   =
   -            =0A47.45% pagevec_lru_move_fn;lru_add_drain_cpu;lru_add_dra=
in;unmap_region;__do_munmap;__vm_munmap;__x64_sys_munmap;do_syscall_64;entr=
y_SYSCALL_64_after_hwframe;munmap=0A    47.53%     0.01%  [kernel.kallsyms]=
   [k] lru_add_drain                                 -      -            =
=0A47.48% lru_add_drain;unmap_region;__do_munmap;__vm_munmap;__x64_sys_munm=
ap;do_syscall_64;entry_SYSCALL_64_after_hwframe;munmap=0A    47.52%     0.0=
3%  [kernel.kallsyms]   [k] lru_add_drain_cpu                             -=
      -            =0A47.47% lru_add_drain_cpu;lru_add_drain;unmap_region;_=
_do_munmap;__vm_munmap;__x64_sys_munmap;do_syscall_64;entry_SYSCALL_64_afte=
r_hwframe;munmap=0A     2.25%     0.02%  [kernel.kallsyms]   [k] apic_timer=
_interrupt                          -      -            =0A1.06% apic_timer=
_interrupt;_raw_spin_unlock_irqrestore;pagevec_lru_move_fn;lru_add_drain_cp=
u;lru_add_drain;unmap_region;__do_munmap;__vm_munmap;__x64_sys_munmap;do_sy=
scall_64;entry_SYSCALL_64_after_hwframe;munmap=0A1.06% apic_timer_interrupt=
;_raw_spin_unlock_irqrestore;release_pages;tlb_flush_mmu;tlb_finish_mmu;unm=
ap_region;__do_munmap;__vm_munmap;__x64_sys_munmap;do_syscall_64;entry_SYSC=
ALL_64_after_hwframe;munmap=0A     2.23%     0.11%  [kernel.kallsyms]   [k]=
 _raw_spin_unlock_irqrestore                   -      -            =0A1.07%=
 _raw_spin_unlock_irqrestore;release_pages;tlb_flush_mmu;tlb_finish_mmu;unm=
ap_region;__do_munmap;__vm_munmap;__x64_sys_munmap;do_syscall_64;entry_SYSC=
ALL_64_after_hwframe;munmap=0A1.06% _raw_spin_unlock_irqrestore;pagevec_lru=
_move_fn;lru_add_drain_cpu;lru_add_drain;unmap_region;__do_munmap;__vm_munm=
ap;__x64_sys_munmap;do_syscall_64;entry_SYSCALL_64_after_hwframe;munmap=0A =
    2.15%     0.06%  [kernel.kallsyms]   [k] smp_apic_timer_interrupt      =
                -      -            =0A1.02% smp_apic_timer_interrupt;apic_=
timer_interrupt;_raw_spin_unlock_irqrestore;release_pages;tlb_flush_mmu;tlb=
_finish_mmu;unmap_region;__do_munmap;__vm_munmap;__x64_sys_munmap;do_syscal=
l_64;entry_SYSCALL_64_after_hwframe;munmap=0A1.02% smp_apic_timer_interrupt=
;apic_timer_interrupt;_raw_spin_unlock_irqrestore;pagevec_lru_move_fn;lru_a=
dd_drain_cpu;lru_add_drain;unmap_region;__do_munmap;__vm_munmap;__x64_sys_m=
unmap;do_syscall_64;entry_SYSCALL_64_after_hwframe;munmap=0A     1.86%     =
0.10%  [kernel.kallsyms]   [k] hrtimer_interrupt                           =
  -      -            =0A0.88% hrtimer_interrupt;smp_apic_timer_interrupt;a=
pic_timer_interrupt;_raw_spin_unlock_irqrestore;release_pages;tlb_flush_mmu=
;tlb_finish_mmu;unmap_region;__do_munmap;__vm_munmap;__x64_sys_munmap;do_sy=
scall_64;entry_SYSCALL_64_after_hwframe;munmap=0A0.88% hrtimer_interrupt;sm=
p_apic_timer_interrupt;apic_timer_interrupt;_raw_spin_unlock_irqrestore;pag=
evec_lru_move_fn;lru_add_drain_cpu;lru_add_drain;unmap_region;__do_munmap;_=
_vm_munmap;__x64_sys_munmap;do_syscall_64;entry_SYSCALL_64_after_hwframe;mu=
nmap=0A     1.59%     0.17%  [kernel.kallsyms]   [k] __hrtimer_run_queues  =
                        -      -            =0A0.76% __hrtimer_run_queues;h=
rtimer_interrupt;smp_apic_timer_interrupt;apic_timer_interrupt;_raw_spin_un=
lock_irqrestore;release_pages;tlb_flush_mmu;tlb_finish_mmu;unmap_region;__d=
o_munmap;__vm_munmap;__x64_sys_munmap;do_syscall_64;entry_SYSCALL_64_after_=
hwframe;munmap=0A0.75% __hrtimer_run_queues;hrtimer_interrupt;smp_apic_time=
r_interrupt;apic_timer_interrupt;_raw_spin_unlock_irqrestore;pagevec_lru_mo=
ve_fn;lru_add_drain_cpu;lru_add_drain;unmap_region;__do_munmap;__vm_munmap;=
__x64_sys_munmap;do_syscall_64;entry_SYSCALL_64_after_hwframe;munmap=0A    =
 1.09%     0.01%  [kernel.kallsyms]   [k] tick_sched_timer                 =
             -      -            =0A0.51% tick_sched_timer;__hrtimer_run_qu=
eues;hrtimer_interrupt;smp_apic_timer_interrupt;apic_timer_interrupt;_raw_s=
pin_unlock_irqrestore;pagevec_lru_move_fn;lru_add_drain_cpu;lru_add_drain;u=
nmap_region;__do_munmap;__vm_munmap;__x64_sys_munmap;do_syscall_64;entry_SY=
SCALL_64_after_hwframe;munmap=0A0.51% tick_sched_timer;__hrtimer_run_queues=
;hrtimer_interrupt;smp_apic_timer_interrupt;apic_timer_interrupt;_raw_spin_=
unlock_irqrestore;release_pages;tlb_flush_mmu;tlb_finish_mmu;unmap_region;_=
_do_munmap;__vm_munmap;__x64_sys_munmap;do_syscall_64;entry_SYSCALL_64_afte=
r_hwframe;munmap=0A     1.07%     0.01%  [kernel.kallsyms]   [k] page_fault=
                                    -      -            =0A1.03% page_fault=
=0A     1.04%     0.01%  [kernel.kallsyms]   [k] tick_sched_handle         =
                    -      -            =0A     1.02%     0.06%  [kernel.ka=
llsyms]   [k] do_page_fault                                 -      -       =
     =0A0.99% do_page_fault;page_fault=0A     1.02%     0.01%  [kernel.kall=
syms]   [k] update_process_times                          -      -         =
   =0A     0.94%     0.02%  [kernel.kallsyms]   [k] unmap_vmas             =
                       -      -            =0A0.94% unmap_vmas;unmap_region=
;__do_munmap;__vm_munmap;__x64_sys_munmap;do_syscall_64;entry_SYSCALL_64_af=
ter_hwframe;munmap=0A     0.89%     0.48%  [kernel.kallsyms]   [k] unmap_pa=
ge_range                              -      -            =0A0.87% unmap_pa=
ge_range;unmap_vmas;unmap_region;__do_munmap;__vm_munmap;__x64_sys_munmap;d=
o_syscall_64;entry_SYSCALL_64_after_hwframe;munmap=0A     0.85%     0.04%  =
[kernel.kallsyms]   [k] handle_mm_fault                               -    =
  -            =0A0.83% handle_mm_fault;do_page_fault;page_fault=0A     0.8=
0%     0.06%  [kernel.kallsyms]   [k] __handle_mm_fault                    =
         -      -            =0A0.78% __handle_mm_fault;handle_mm_fault;do_=
page_fault;page_fault=0A     0.80%     0.02%  [kernel.kallsyms]   [k] sched=
uler_tick                                -      -            =0A     0.75% =
    0.02%  libc-2.24.so        [.] mmap64                                  =
      -      -            =0A0.75% mmap64=0A     0.72%     0.03%  [kernel.k=
allsyms]   [k] handle_pte_fault                              -      -      =
      =0A0.70% handle_pte_fault;__handle_mm_fault;handle_mm_fault;do_page_f=
ault;page_fault=0A     0.66%     0.01%  [kernel.kallsyms]   [k] ksys_mmap_p=
goff                               -      -            =0A0.64% ksys_mmap_p=
goff;do_syscall_64;entry_SYSCALL_64_after_hwframe;mmap64=0A     0.65%     0=
=2E01%  [kernel.kallsyms]   [k] vm_mmap_pgoff                              =
   -      -            =0A0.63% vm_mmap_pgoff;ksys_mmap_pgoff;do_syscall_64=
;entry_SYSCALL_64_after_hwframe;mmap64=0A     0.57%     0.03%  [kernel.kall=
syms]   [k] do_mmap                                       -      -         =
   =0A0.55% do_mmap;vm_mmap_pgoff;ksys_mmap_pgoff;do_syscall_64;entry_SYSCA=
LL_64_after_hwframe;mmap64=0A     0.55%     0.12%  [kernel.kallsyms]   [k] =
task_tick_fair                                -      -            =0A     0=
=2E50%     0.00%  [kernel.kallsyms]   [k] exit_to_usermode_loop            =
             -      -            =0A     0.50%     0.00%  [kernel.kallsyms]=
   [k] task_work_run                                 -      -            =
=0A     0.50%     0.00%  [kernel.kallsyms]   [k] task_numa_work            =
                    -      -            =0A     0.49%     0.00%  [kernel.ka=
llsyms]   [k] change_protection                             -      -       =
     =0A     0.49%     0.00%  [kernel.kallsyms]   [k] change_prot_numa     =
                         -      -            =0A     0.49%     0.44%  [kern=
el.kallsyms]   [k] change_p4d_range                              -      -  =
          =0A     0.47%     0.00%  libc-2.24.so        [.] __libc_start_mai=
n                             -      -            =0A     0.47%     0.00%  =
perf                [.] main                                          -    =
  -            =0A     0.47%     0.00%  perf                [.] cmd_record =
                                   -      -            =0A     0.47%     0.=
00%  perf                [.] perf_mmap__push                               =
-      -            =0A     0.46%     0.01%  libpthread-2.24.so  [.] __GI__=
_libc_write                             -      -            =0A     0.43%  =
   0.00%  [kernel.kallsyms]   [k] ksys_write                               =
     -      -            =0A     0.42%     0.04%  [kernel.kallsyms]   [k] m=
map_region                                   -      -            =0A     0.=
41%     0.00%  [kernel.kallsyms]   [k] vfs_write                           =
          -      -            =0A     0.38%     0.00%  [kernel.kallsyms]   =
[k] new_sync_write                                -      -            =0A  =
   0.38%     0.00%  [kernel.kallsyms]   [k] generic_file_write_iter        =
               -      -            =0A     0.37%     0.00%  [kernel.kallsym=
s]   [k] __generic_file_write_iter                     -      -            =
=0A     0.36%     0.00%  [kernel.kallsyms]   [k] generic_perform_write     =
                    -      -            =0A     0.32%     0.31%  [kernel.ka=
llsyms]   [k] ___might_sleep                                -      -       =
     =0A     0.32%     0.03%  [kernel.kallsyms]   [k] __alloc_pages_nodemas=
k                        -      -            =0A     0.27%     0.07%  [kern=
el.kallsyms]   [k] get_page_from_freelist                        -      -  =
          =0A     0.26%     0.00%  [kernel.kallsyms]   [k] shmem_write_begi=
n                             -      -            =0A     0.26%     0.01%  =
[kernel.kallsyms]   [k] shmem_getpage_gfp                             -    =
  -            =0A     0.26%     0.01%  [kernel.kallsyms]   [k] __pte_alloc=
                                   -      -            =0A     0.23%     0.=
01%  [kernel.kallsyms]   [k] pte_alloc_one                                 =
-      -            =0A     0.19%     0.01%  [kernel.kallsyms]   [k] __lru_=
cache_add                               -      -            =0A     0.18%  =
   0.02%  [kernel.kallsyms]   [k] prep_new_page                            =
     -      -            =0A     0.17%     0.04%  [kernel.kallsyms]   [k] p=
erf_event_mmap                               -      -            =0A     0.=
17%     0.08%  [kernel.kallsyms]   [k] _cond_resched                       =
          -      -            =0A     0.16%     0.01%  [kernel.kallsyms]   =
[k] irq_exit                                      -      -            =0A  =
   0.16%     0.09%  [kernel.kallsyms]   [k] update_curr                    =
               -      -            =0A     0.16%     0.01%  [kernel.kallsym=
s]   [k] alloc_pages_vma                               -      -            =
=0A     0.16%     0.15%  [kernel.kallsyms]   [k] clear_page_erms           =
                    -      -            =0A     0.15%     0.02%  [kernel.ka=
llsyms]   [k] __remove_hrtimer                              -      -       =
     =0A     0.13%     0.01%  [kernel.kallsyms]   [k] free_pgtables        =
                         -      -            =0A     0.13%     0.01%  [kern=
el.kallsyms]   [k] __anon_vma_prepare                            -      -  =
          =0A     0.13%     0.01%  [kernel.kallsyms]   [k] free_pgd_range  =
                              -      -            =0A     0.13%     0.01%  =
[kernel.kallsyms]   [k] timerqueue_del                                -    =
  -            =0A     0.12%     0.03%  [kernel.kallsyms]   [k] unlink_anon=
_vmas                              -      -            =0A     0.12%     0.=
01%  [kernel.kallsyms]   [k] get_unmapped_area                             =
-      -            =0A     0.12%     0.10%  [kernel.kallsyms]   [k] free_p=
4d_range                                -      -            =0A     0.11%  =
   0.04%  [kernel.kallsyms]   [k] free_unref_page_list                     =
     -      -            =0A     0.11%     0.04%  [kernel.kallsyms]   [k] p=
erf_mux_hrtimer_handler                      -      -            =0A     0.=
11%     0.05%  [kernel.kallsyms]   [k] __pagevec_lru_add_fn                =
          -      -            =0A     0.11%     0.04%  [kernel.kallsyms]   =
[k] __softirqentry_text_start                     -      -            =0A  =
   0.11%     0.08%  [kernel.kallsyms]   [k] perf_iterate_sb                =
               -      -            =0A     0.10%     0.02%  [kernel.kallsym=
s]   [k] __perf_sw_event                               -      -            =
=0A     0.10%     0.09%  [kernel.kallsyms]   [k] __update_load_avg_cfs_rq  =
                    -      -            =0A     0.10%     0.10%  [kernel.ka=
llsyms]   [k] rb_next                                       -      -       =
     =0A     0.10%     0.02%  [kernel.kallsyms]   [k] arch_get_unmapped_are=
a_topdown                -      -            =0A     0.09%     0.08%  [kern=
el.kallsyms]   [k] __update_load_avg_se                          -      -  =
          =0A     0.08%     0.05%  [kernel.kallsyms]   [k] kmem_cache_alloc=
                              -      -            =0A     0.08%     0.08%  =
[kernel.kallsyms]   [k] _raw_spin_lock                                -    =
  -            =0A     0.08%     0.05%  [kernel.kallsyms]   [k] ___perf_sw_=
event                              -      -            =0A     0.08%     0.=
02%  [kernel.kallsyms]   [k] mem_cgroup_uncharge_list                      =
-      -            =0A     0.07%     0.06%  [kernel.kallsyms]   [k] rcu_al=
l_qs                                    -      -            =0A     0.07%  =
   0.02%  [kernel.kallsyms]   [k] flush_tlb_mm_range                       =
     -      -            =0A     0.07%     0.05%  [kernel.kallsyms]   [k] u=
pdate_rq_clock.part.70                       -      -            =0A     0.=
07%     0.07%  [kernel.kallsyms]   [k] vm_unmapped_area                    =
          -      -            =0A     0.07%     0.04%  [kernel.kallsyms]   =
[k] percpu_counter_add_batch                      -      -            =0A  =
   0.07%     0.03%  [kernel.kallsyms]   [k] __mod_lruvec_state             =
               -      -            =0A     0.06%     0.02%  [kernel.kallsym=
s]   [k] clockevents_program_event                     -      -            =
=0A     0.06%     0.06%  [kernel.kallsyms]   [k] kmem_cache_free           =
                    -      -            =0A     0.06%     0.06%  [kernel.ka=
llsyms]   [k] syscall_return_via_sysret                     -      -       =
     =0A     0.06%     0.05%  [kernel.kallsyms]   [k] run_timer_softirq    =
                         -      -            =0A     0.06%     0.06%  [kern=
el.kallsyms]   [k] perf_event_task_tick                          -      -  =
          =0A     0.06%     0.01%  [kernel.kallsyms]   [k] uncharge_batch  =
                              -      -            =0A     0.06%     0.05%  =
[kernel.kallsyms]   [k] free_unref_page_commit                        -    =
  -            =0A     0.06%     0.05%  libc-2.24.so        [.] malloc     =
                                   -      -            =0A     0.06%     0.=
05%  [kernel.kallsyms]   [k] entry_SYSCALL_64                              =
-      -            =0A     0.05%     0.01%  [kernel.kallsyms]   [k] vma_li=
nk                                      -      -            =0A     0.05%  =
   0.05%  [kernel.kallsyms]   [k] interrupt_entry                          =
     -      -            =0A     0.05%     0.04%  [kernel.kallsyms]   [k] r=
cu_sched_clock_irq                           -      -            =0A     0.=
05%     0.01%  [kernel.kallsyms]   [k] remove_vma                          =
          -      -            =0A     0.05%     0.04%  [kernel.kallsyms]   =
[k] vm_normal_page                                -      -            =0A  =
   0.05%     0.01%  [kernel.kallsyms]   [k] mem_cgroup_try_charge_delay    =
               -      -            =0A     0.05%     0.02%  [kernel.kallsym=
s]   [k] iov_iter_fault_in_readable                    -      -            =
=0A     0.05%     0.04%  [kernel.kallsyms]   [k] __might_sleep             =
                    -      -            =0A     0.05%     0.03%  [kernel.ka=
llsyms]   [k] find_vma                                      -      -       =
     =0A     0.05%     0.03%  [kernel.kallsyms]   [k] error_entry          =
                         -      -            =0A     0.04%     0.04%  [kern=
el.kallsyms]   [k] __mod_memcg_state                             -      -  =
          =0A     0.04%     0.01%  [kernel.kallsyms]   [k] enqueue_hrtimer =
                              -      -            =0A     0.04%     0.03%  =
[kernel.kallsyms]   [k] ktime_get                                     -    =
  -            =0A     0.04%     0.01%  [kernel.kallsyms]   [k] __put_anon_=
vma                                -      -            =0A     0.04%     0.=
03%  [kernel.kallsyms]   [k] irq_enter                                     =
-      -            =0A     0.04%     0.03%  [kernel.kallsyms]   [k] ktime_=
get_update_offsets_now                  -      -            =0A     0.04%  =
   0.00%  [kernel.kallsyms]   [k] mark_page_accessed                       =
     -      -            =0A     0.04%     0.00%  [kernel.kallsyms]   [k] m=
mput                                         -      -            =0A     0.=
04%     0.00%  [kernel.kallsyms]   [k] exit_mmap                           =
          -      -            =0A     0.04%     0.02%  [kernel.kallsyms]   =
[k] arch_scale_freq_tick                          -      -            =0A  =
   0.04%     0.04%  [kernel.kallsyms]   [k] native_irq_return_iret         =
               -      -            =0A     0.04%     0.01%  [kernel.kallsym=
s]   [k] vm_area_alloc                                 -      -            =
=0A     0.04%     0.04%  [kernel.kallsyms]   [k] __vma_link_rb             =
                    -      -            =0A     0.04%     0.00%  [kernel.ka=
llsyms]   [k] activate_page                                 -      -       =
     =0A     0.04%     0.02%  [kernel.kallsyms]   [k] swapgs_restore_regs_a=
nd_return_to_usermode    -      -            =0A     0.04%     0.04%  [kern=
el.kallsyms]   [k] mem_cgroup_page_lruvec                        -      -  =
          =0A     0.04%     0.02%  [kernel.kallsyms]   [k] security_mmap_fi=
le                            -      -            =0A     0.03%     0.03%  =
[kernel.kallsyms]   [k] hrtimer_active                                -    =
  -            =0A     0.03%     0.01%  [kernel.kallsyms]   [k] cpumask_any=
_but                               -      -            =0A     0.03%     0.=
03%  [kernel.kallsyms]   [k] __list_del_entry_valid                        =
-      -            =0A     0.03%     0.01%  [kernel.kallsyms]   [k] alloc_=
pages_current                           -      -            =0A     0.03%  =
   0.01%  [kernel.kallsyms]   [k] __vm_enough_memory                       =
     -      -            =0A     0.03%     0.02%  [kernel.kallsyms]   [k] t=
imerqueue_add                                -      -            =0A     0.=
03%     0.03%  [kernel.kallsyms]   [k] native_write_msr                    =
          -      -            =0A     0.03%     0.01%  [kernel.kallsyms]   =
[k] security_vm_enough_memory_mm                  -      -            =0A  =
   0.03%     0.03%  [kernel.kallsyms]   [k] perf_event_mmap_output         =
               -      -            =0A     0.03%     0.01%  [kernel.kallsym=
s]   [k] down_write                                    -      -            =
=0A     0.03%     0.01%  [kernel.kallsyms]   [k] lapic_next_deadline       =
                    -      -            =0A     0.03%     0.02%  [kernel.ka=
llsyms]   [k] reweight_entity                               -      -       =
     =0A     0.03%     0.01%  [kernel.kallsyms]   [k] down_write_killable  =
                         -      -            =0A     0.03%     0.01%  [kern=
el.kallsyms]   [k] free_pages_and_swap_cache                     -      -  =
          =0A     0.03%     0.03%  [kernel.kallsyms]   [k] run_local_timers=
                              -      -            =0A     0.03%     0.03%  =
[kernel.kallsyms]   [k] __count_memcg_events                          -    =
  -            =0A     0.03%     0.03%  [kernel.kallsyms]   [k] read_tsc   =
                                   -      -            =0A     0.03%     0.=
03%  [kernel.kallsyms]   [k] cpuacct_charge                                =
-      -            =0A     0.03%     0.03%  [kernel.kallsyms]   [k] __mod_=
node_page_state                         -      -            =0A     0.03%  =
   0.02%  [kernel.kallsyms]   [k] account_system_index_time                =
     -      -            =0A     0.03%     0.03%  [kernel.kallsyms]   [k] _=
_calc_delta                                  -      -            =0A     0.=
03%     0.01%  [kernel.kallsyms]   [k] mem_cgroup_commit_charge            =
          -      -            =0A     0.03%     0.00%  [kernel.kallsyms]   =
[k] __x64_sys_execve                              -      -            =0A  =
   0.03%     0.00%  [kernel.kallsyms]   [k] __do_execve_file.isra.33       =
               -      -            =0A     0.03%     0.00%  libc-2.24.so   =
     [.] execve                                        -      -            =
=0A     0.03%     0.00%  [kernel.kallsyms]   [k] sched_clock_cpu           =
                    -      -            =0A     0.03%     0.01%  libc-2.24.=
so        [.] free                                          -      -       =
     =0A     0.03%     0.03%  [kernel.kallsyms]   [k] __accumulate_pelt_seg=
ments                    -      -            =0A     0.02%     0.02%  [kern=
el.kallsyms]   [k] ksoftirqd_running                             -      -  =
          =0A     0.02%     0.02%  [kernel.kallsyms]   [k] _raw_spin_lock_i=
rq                            -      -            =0A     0.02%     0.02%  =
[kernel.kallsyms]   [k] __vma_rb_erase                                -    =
  -            =0A     0.02%     0.02%  [kernel.kallsyms]   [k] __hrtimer_n=
ext_event_base                     -      -            =0A     0.02%     0.=
02%  [kernel.kallsyms]   [k] __list_add_valid                              =
-      -            =0A     0.02%     0.02%  [kernel.kallsyms]   [k] calc_g=
lobal_load_tick                         -      -            =0A     0.02%  =
   0.00%  [kernel.kallsyms]   [k] sched_clock                              =
     -      -            =0A     0.02%     0.02%  [kernel.kallsyms]   [k] n=
ative_sched_clock                            -      -            =0A     0.=
02%     0.01%  [kernel.kallsyms]   [k] cap_vm_enough_memory                =
          -      -            =0A     0.02%     0.00%  [kernel.kallsyms]   =
[k] __x64_sys_exit_group                          -      -            =0A  =
   0.02%     0.00%  [kernel.kallsyms]   [k] do_group_exit                  =
               -      -            =0A     0.02%     0.00%  [kernel.kallsym=
s]   [k] do_exit                                       -      -            =
=0A     0.02%     0.00%  [kernel.kallsyms]   [k] search_binary_handler     =
                    -      -            =0A     0.02%     0.02%  [kernel.ka=
llsyms]   [k] _find_next_bit.constprop.1                    -      -       =
     =0A     0.02%     0.00%  [kernel.kallsyms]   [k] load_elf_binary      =
                         -      -            =0A     0.02%     0.02%  [kern=
el.kallsyms]   [k] rb_erase                                      -      -  =
          =0A     0.02%     0.01%  [kernel.kallsyms]   [k] flush_tlb_func_c=
ommon.constprop.9             -      -            =0A     0.02%     0.01%  =
[kernel.kallsyms]   [k] page_remove_rmap                              -    =
  -            =0A     0.02%     0.02%  [kernel.kallsyms]   [k] irq_work_ti=
ck                                 -      -            =0A     0.02%     0.=
02%  [kernel.kallsyms]   [k] __x86_indirect_thunk_rax                      =
-      -            =0A     0.02%     0.02%  [kernel.kallsyms]   [k] fpregs=
_assert_state_consistent                -      -            =0A     0.02%  =
   0.02%  [kernel.kallsyms]   [k] tick_program_event                       =
     -      -            =0A     0.02%     0.02%  [kernel.kallsyms]   [k] m=
em_cgroup_throttle_swaprate                  -      -            =0A     0.=
02%     0.02%  [kernel.kallsyms]   [k] native_read_msr                     =
          -      -            =0A     0.02%     0.02%  [kernel.kallsyms]   =
[k] get_task_policy.part.31                       -      -            =0A  =
   0.02%     0.02%  [kernel.kallsyms]   [k] native_apic_msr_eoi_write      =
               -      -            =0A     0.02%     0.01%  [kernel.kallsym=
s]   [k] mem_cgroup_try_charge                         -      -            =
=0A     0.02%     0.02%  [kernel.kallsyms]   [k] update_cfs_group          =
                    -      -            =0A     0.02%     0.02%  [kernel.ka=
llsyms]   [k] __acct_update_integrals                       -      -       =
     =0A     0.02%     0.02%  [kernel.kallsyms]   [k] anon_vma_interval_tre=
e_remove                 -      -            =0A     0.02%     0.00%  [kern=
el.kallsyms]   [k] iov_iter_copy_from_user_atomic                -      -  =
          =0A     0.02%     0.01%  [kernel.kallsyms]   [k] __hrtimer_get_ne=
xt_event                      -      -            =0A     0.02%     0.02%  =
[kernel.kallsyms]   [k] mem_cgroup_update_lru_size                    -    =
  -            =0A     0.02%     0.02%  [kernel.kallsyms]   [k] hrtimer_for=
ward                               -      -            =0A     0.02%     0.=
00%  [kernel.kallsyms]   [k] ret_from_fork                                 =
-      -            =0A     0.02%     0.00%  [kernel.kallsyms]   [k] kthrea=
d                                       -      -            =0A     0.02%  =
   0.01%  [kernel.kallsyms]   [k] trigger_load_balance                     =
     -      -            =0A     0.02%     0.01%  [kernel.kallsyms]   [k] p=
repare_exit_to_usermode                      -      -            =0A     0.=
02%     0.00%  [kernel.kallsyms]   [k] find_lock_entry                     =
          -      -            =0A     0.02%     0.02%  [kernel.kallsyms]   =
[k] vmacache_find                                 -      -            =0A  =
   0.02%     0.00%  [kernel.kallsyms]   [k] flush_old_exec                 =
               -      -            =0A     0.02%     0.02%  [kernel.kallsym=
s]   [k] perf_exclude_event                            -      -            =
=0A     0.02%     0.02%  [kernel.kallsyms]   [k] rcu_segcblist_ready_cbs   =
                    -      -            =0A     0.02%     0.01%  [kernel.ka=
llsyms]   [k] page_add_new_anon_rmap                        -      -       =
     =0A     0.02%     0.02%  [kernel.kallsyms]   [k] account_process_tick =
                         -      -            =0A     0.02%     0.02%  [kern=
el.kallsyms]   [k] x86_pmu_disable                               -      -  =
          =0A     0.02%     0.01%  [kernel.kallsyms]   [k] ret_from_intr   =
                              -      -            =0A     0.02%     0.02%  =
[kernel.kallsyms]   [k] sync_regs                                     -    =
  -            =0A     0.02%     0.01%  [kernel.kallsyms]   [k] shmem_write=
_end                               -      -            =0A     0.02%     0.=
00%  [kernel.kallsyms]   [k] copyin                                        =
-      -            =0A     0.02%     0.00%  [kernel.kallsyms]   [k] ___pte=
_free_tlb                               -      -            =0A     0.02%  =
   0.01%  [kernel.kallsyms]   [k] native_flush_tlb                         =
     -      -            =0A     0.02%     0.02%  [kernel.kallsyms]   [k] _=
_mod_zone_page_state                         -      -            =0A     0.=
02%     0.01%  [kernel.kallsyms]   [k] vma_set_page_prot                   =
          -      -            =0A     0.02%     0.01%  [kernel.kallsyms]   =
[k] rcu_irq_enter                                 -      -            =0A  =
   0.01%     0.01%  [kernel.kallsyms]   [k] tlb_gather_mmu                 =
               -      -            =0A     0.01%     0.01%  [kernel.kallsym=
s]   [k] cap_capable                                   -      -            =
=0A     0.01%     0.01%  [kernel.kallsyms]   [k] strlcpy                   =
                    -      -            =0A     0.01%     0.01%  [kernel.ka=
llsyms]   [k] copy_user_enhanced_fast_string                -      -       =
     =0A     0.01%     0.01%  [kernel.kallsyms]   [k] may_expand_vm        =
                         -      -            =0A     0.01%     0.01%  [kern=
el.kallsyms]   [k] irq_work_run_list                             -      -  =
          =0A     0.01%     0.01%  [kernel.kallsyms]   [k] up_write        =
                              -      -            =0A     0.01%     0.01%  =
[kernel.kallsyms]   [k] up_read                                       -    =
  -            =0A     0.01%     0.01%  [kernel.kallsyms]   [k] memcpy_erms=
                                   -      -            =0A     0.01%     0.=
01%  malloc1_processes   [.] free@plt                                      =
-      -            =0A     0.01%     0.01%  [kernel.kallsyms]   [k] run_po=
six_cpu_timers                          -      -            =0A     0.01%  =
   0.01%  [kernel.kallsyms]   [k] find_mergeable_anon_vma                  =
     -      -            =0A     0.01%     0.01%  [kernel.kallsyms]   [k] f=
ree_unref_page_prepare.part.72               -      -            =0A     0.=
01%     0.01%  [kernel.kallsyms]   [k] mem_cgroup_charge_statistics        =
          -      -            =0A     0.01%     0.01%  [kernel.kallsyms]   =
[k] perf_swevent_event                            -      -            =0A  =
   0.01%     0.00%  [kernel.kallsyms]   [k] __intel_pmu_enable_all.constpro=
p.31           -      -            =0A     0.01%     0.00%  [kernel.kallsym=
s]   [k] shmem_alloc_and_acct_page                     -      -            =
=0A     0.01%     0.00%  [kernel.kallsyms]   [k] __fdget_pos               =
                    -      -            =0A     0.01%     0.01%  [kernel.ka=
llsyms]   [k] sync_mm_rss                                   -      -       =
     =0A     0.01%     0.01%  [kernel.kallsyms]   [k] raise_softirq        =
                         -      -            =0A     0.01%     0.00%  [kern=
el.kallsyms]   [k] find_get_entry                                -      -  =
          =0A     0.01%     0.01%  [kernel.kallsyms]   [k] vma_merge       =
                              -      -            =0A     0.01%     0.01%  =
malloc1_processes   [.] malloc@plt                                    -    =
  -            =0A     0.01%     0.01%  [kernel.kallsyms]   [k] rb_insert_c=
olor                               -      -            =0A     0.01%     0.=
01%  [kernel.kallsyms]   [k] userfaultfd_unmap_complete                    =
-      -            =0A     0.01%     0.00%  [kernel.kallsyms]   [k] __sche=
d_text_start                            -      -            =0A     0.01%  =
   0.00%  [kernel.kallsyms]   [k] worker_thread                            =
     -      -            =0A     0.01%     0.01%  [kernel.kallsyms]   [k] _=
_rb_insert_augmented                         -      -            =0A     0.=
01%     0.01%  [kernel.kallsyms]   [k] do_huge_pmd_anonymous_page          =
          -      -            =0A     0.01%     0.00%  [kernel.kallsyms]   =
[k] shmem_alloc_page                              -      -            =0A  =
   0.01%     0.01%  [kernel.kallsyms]   [k] apparmor_mmap_file             =
               -      -            =0A     0.01%     0.01%  [kernel.kallsym=
s]   [k] uncharge_page                                 -      -            =
=0A     0.01%     0.01%  [kernel.kallsyms]   [k] tick_sched_do_timer       =
                    -      -            =0A     0.01%     0.01%  [kernel.ka=
llsyms]   [k] idle_cpu                                      -      -       =
     =0A     0.01%     0.01%  [kernel.kallsyms]   [k] blocking_notifier_cal=
l_chain                  -      -            =0A     0.01%     0.01%  [kern=
el.kallsyms]   [k] inc_zone_page_state                           -      -  =
          =0A     0.01%     0.00%  [kernel.kallsyms]   [k] process_one_work=
                              -      -            =0A     0.01%     0.01%  =
[kernel.kallsyms]   [k] anon_vma_chain_link                           -    =
  -            =0A     0.01%     0.01%  [kernel.kallsyms]   [k] update_min_=
vruntime                           -      -            =0A     0.01%     0.=
01%  [kernel.kallsyms]   [k] page_mapping                                  =
-      -            =0A     0.01%     0.01%  [kernel.kallsyms]   [k] __tran=
sparent_hugepage_enabled                -      -            =0A     0.01%  =
   0.01%  [kernel.kallsyms]   [k] userfaultfd_unmap_prep                   =
     -      -            =0A     0.01%     0.01%  [kernel.kallsyms]   [k] m=
emcg_check_events                            -      -            =0A     0.=
01%     0.01%  [kernel.kallsyms]   [k] __dec_node_state                    =
          -      -            =0A     0.01%     0.01%  [kernel.kallsyms]   =
[k] __inc_numa_state                              -      -            =0A  =
   0.01%     0.01%  [kernel.kallsyms]   [k] pmd_none_or_trans_huge_or_clear=
_bad           -      -            =0A     0.01%     0.00%  [kernel.kallsym=
s]   [k] vfs_read                                      -      -            =
=0A     0.01%     0.01%  [kernel.kallsyms]   [k] rcu_irq_exit              =
                    -      -            =0A     0.01%     0.00%  [kernel.ka=
llsyms]   [k] security_file_permission                      -      -       =
     =0A     0.01%     0.00%  [kernel.kallsyms]   [k] intel_pmu_disable_all=
                         -      -            =0A     0.01%     0.00%  [kern=
el.kallsyms]   [k] ksys_read                                     -      -  =
          =0A     0.01%     0.01%  [kernel.kallsyms]   [k] unmap_single_vma=
                              -      -            =0A     0.01%     0.01%  =
[kernel.kallsyms]   [k] anon_vma_compatible                           -    =
  -            =0A     0.01%     0.01%  [kernel.kallsyms]   [k] try_charge =
                                   -      -            =0A     0.01%     0.=
00%  [kernel.kallsyms]   [k] security_mmap_addr                            =
-      -            =0A     0.01%     0.00%  [kernel.kallsyms]   [k] rcu_gp=
_kthread                                -      -            =0A     0.01%  =
   0.00%  libc-2.24.so        [.] read                                     =
     -      -            =0A     0.01%     0.00%  [kernel.kallsyms]   [k] d=
rm_fb_helper_dirty_work                      -      -            =0A     0.=
01%     0.01%  [kernel.kallsyms]   [k] profile_tick                        =
          -      -            =0A     0.01%     0.01%  [kernel.kallsyms]   =
[k] dec_zone_page_state                           -      -            =0A  =
   0.01%     0.01%  [kernel.kallsyms]   [k] get_mem_cgroup_from_mm         =
               -      -            =0A     0.01%     0.01%  [kernel.kallsym=
s]   [k] __tlb_remove_page_size                        -      -            =
=0A     0.01%     0.00%  [kernel.kallsyms]   [k] mutex_lock                =
                    -      -            =0A     0.01%     0.01%  [kernel.ka=
llsyms]   [k] retint_kernel                                 -      -       =
     =0A     0.01%     0.00%  [kernel.kallsyms]   [k] alloc_set_pte        =
                         -      -            =0A     0.01%     0.00%  [kern=
el.kallsyms]   [k] force_qs_rnp                                  -      -  =
          =0A     0.01%     0.00%  [kernel.kallsyms]   [k] file_update_time=
                              -      -            =0A     0.01%     0.01%  =
[kernel.kallsyms]   [k] account_entity_enqueue                        -    =
  -            =0A     0.01%     0.01%  [kernel.kallsyms]   [k] update_rq_c=
lock                               -      -            =0A     0.01%     0.=
00%  [kernel.kallsyms]   [k] shmem_add_to_page_cache                       =
-      -            =0A     0.01%     0.00%  [kernel.kallsyms]   [k] error_=
exit                                    -      -            =0A     0.01%  =
   0.01%  [kernel.kallsyms]   [k] free_pcp_prepare                         =
     -      -            =0A     0.01%     0.01%  [kernel.kallsyms]   [k] v=
m_pgprot_modify                              -      -            =0A     0.=
01%     0.00%  [kernel.kallsyms]   [k] finish_fault                        =
          -      -            =0A     0.01%     0.00%  [kernel.kallsyms]   =
[k] xas_load                                      -      -            =0A  =
   0.01%     0.00%  [kernel.kallsyms]   [k] tlb_remove_page                =
               -      -            =0A     0.01%     0.01%  [kernel.kallsym=
s]   [k] __page_set_anon_rmap                          -      -            =
=0A     0.01%     0.01%  [kernel.kallsyms]   [k] p4d_offset                =
                    -      -            =0A     0.01%     0.00%  [kernel.ka=
llsyms]   [k] load_balance                                  -      -       =
     =0A     0.01%     0.01%  [kernel.kallsyms]   [k] account_entity_dequeu=
e                        -      -            =0A     0.01%     0.01%  [kern=
el.kallsyms]   [k] downgrade_write                               -      -  =
          =0A     0.01%     0.01%  [kernel.kallsyms]   [k] pfn_pte         =
                              -      -            =0A     0.01%     0.00%  =
[kernel.kallsyms]   [k] should_failslab                               -    =
  -            =0A     0.01%     0.00%  [kernel.kallsyms]   [k] rebalance_d=
omains                             -      -            =0A     0.01%     0.=
01%  [kernel.kallsyms]   [k] anon_vma_interval_tree_insert                 =
-      -            =0A     0.01%     0.00%  [kernel.kallsyms]   [k] cpuacc=
t_account_field                         -      -            =0A     0.01%  =
   0.01%  [kernel.kallsyms]   [k] rcu_implicit_dynticks_qs                 =
     -      -            =0A     0.01%     0.01%  [kernel.kallsyms]   [k] d=
own_read_trylock                             -      -            =0A     0.=
01%     0.00%  [kernel.kallsyms]   [k] __sb_start_write                    =
          -      -            =0A     0.01%     0.00%  [kernel.kallsyms]   =
[k] ima_file_mmap                                 -      -            =0A  =
   0.01%     0.00%  [kernel.kallsyms]   [k] preempt_schedule_common        =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] strlen                                        -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] vmacache_update           =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] __x64_sys_mmap                                -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] policy_nodemask      =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] __intel_pmu_disable_all                       -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __fget_light    =
                              -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] try_to_wake_up                                -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __do_fault =
                                   -      -            =0A     0.00%     0.=
00%  dash                [.] forkshell                                     =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] elf_ma=
p                                       -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] policy_node                              =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] g=
et_mmap_base                                 -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] irq_work_interrupt                  =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] smp_irq_work_interrupt                        -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] irq_work_run                   =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] seq_read                                      -      -            =
=0A     0.00%     0.00%  libc-2.24.so        [.] __libc_fork               =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] vm_area_free                                  -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] kthread_blkcg        =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] vprintk_emit                                  -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] pick_next_task_f=
air                           -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] printk                                        -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] p4d_page_va=
ddr                                -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] schedule                                      =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __x86_=
indirect_thunk_r13                      -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] lru_cache_add_active_or_unevictable      =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] _=
_dec_node_page_state                         -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] native_set_pmd                      =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] kfree                                         -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] __do_sys_clone                 =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] _do_fork                                      -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] should_fail_alloc_page    =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] perf_mmap_fault                               -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] common_file_perm     =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] find_busiest_group                            -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] fsnotify        =
                              -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] run_rebalance_domains                         -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __x86_indir=
ect_thunk_r14                      -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] current_time                                  =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] unlink=
_file_vma                               -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] __fget_files                             =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] t=
lb_table_flush                               -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] pmd_pfn                             =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] __x86_indirect_thunk_r12                      -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] update_blocked_averages        =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] vma_wants_writenotify                         -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] update_sd_lb_stats.constpr=
op.120              -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] get_vma_policy.part.36                        -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] call_timer_fn        =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] hrtimer_run_queues                            -      -  =
          =0A     0.00%     0.00%  perf                [.] perf_mmap__read_=
init                          -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] cap_mmap_addr                                 -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __vma_link_=
list                               -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] do_filp_open                                  =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] path_o=
penat                                   -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] console_unlock                           =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] d=
o_sys_open                                   -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] do_sys_openat2                      =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] __get_vma_policy                              -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] rcu_core                       =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] acct_account_cputime                          -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] profile_munmap            =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] account_system_time                           -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] set_page_dirty       =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] do_signal                                     -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] enqueue_task_fai=
r                             -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] cap_mmap_file                                 -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] iov_iter_ad=
vance                              -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] __vma_link_file                               =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] mem_cg=
roup_from_task                          -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] page_add_file_rmap                       =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] s=
elect_task_rq_fair                           -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] ttwu_do_activate                    =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] activate_task                                 -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] nohz_balance_exit_idle         =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] pmd_page_vaddr                                -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] filemap_map_pages         =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] fsnotify_parent                               -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] copy_process         =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] enqueue_entity                                -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] serial8250_conso=
le_write                      -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] uart_console_write                            -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] flush_tlb_b=
atched_pending                     -      -            =0A     0.00%     0.=
00%  libc-2.24.so        [.] setlocale                                     =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] sched_=
clock_tick                              -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] update_load_avg                          =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] _=
_queue_work                                  -      -            =0A     0.=
00%     0.00%  libc-2.24.so        [.] write                               =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] serial8250_console_putchar                    -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] wait_for_xmitr                 =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] find_idlest_group.isra.95                     -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] find_next_bit             =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] xas_start                                     -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __raw_spin_unlock    =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] __x86_indirect_thunk_r15                      -      -  =
          =0A     0.00%     0.00%  libpthread-2.24.so  [.] __pthread_disabl=
e_asynccancel                 -      -            =0A     0.00%     0.00%  =
perf                [.] perf_mmap__consume                            -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] aa_file_per=
m                                  -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] get_signal                                    =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] sysfs_=
kf_seq_show                             -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] dev_attr_show                            =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] _=
_sb_end_write                                -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] do_wp_page                          =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] memcpy                                        -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] mutex_unlock                   =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] balance_dirty_pages_ratelimited               -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] sum_zone_numa_state       =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] native_set_pte_at                             -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] arch_vma_name        =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] timekeeping_advance                           -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] link_path_walk.p=
art.30                        -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] net_rx_action                                 -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] generic_wri=
te_check_limits.isra.52            -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] xas_store                                     =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] perf_m=
map_to_page                             -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] io_serial_in                             =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] _=
_account_scheduler_latency                   -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] kill_pid_info                       =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] wp_page_copy                                  -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] igb_poll                       =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] sched_exec                                    -      -            =
=0A     0.00%     0.00%  perf                [.] cmd_stat                  =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] dup_mm                                        -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] new_sync_read        =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] pipe_write                                    -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] stack_trace_save=
_tsk                          -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] walk_component                                -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] xas_find_co=
nflict                             -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] arch_stack_walk                               =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] filena=
me_lookup                               -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] wake_up_new_task                         =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] r=
w_verify_area                                -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] timestamp_truncate                  =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] __set_page_dirty_no_writeback                 -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] __wake_up_common_lock          =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] task_tick_rt                                  -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] xas_create_range          =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] update_rt_rq_load_avg                         -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] vsnprintf            =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] newidle_balance                               -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] path_lookupat   =
                              -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] note_gp_changes                               -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] copy_string=
s.isra.27                          -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] pipe_read                                     =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] show_s=
tat                                     -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] __x86_indirect_thunk_r10                 =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] k=
time_get_coarse_real_ts64                    -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] vma_migratable                      =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] xas_create                                    -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] gro_normal_list.part.133       =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] __wake_up_common                              -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] autoremove_wake_function  =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] it_real_fn                                    -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] napi_complete_done   =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] secondary_startup_64                          -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] cpu_startup_entr=
y                             -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] do_idle                                       -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] finish_task=
_switch                            -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] smpboot_thread_fn                             =
-      -            =0A     0.00%     0.00%  libc-2.24.so        [.] kill  =
                                        -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] fput_many                                =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] f=
ile_remove_privs                             -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] pmd_devmap_trans_unstable           =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] lock_page_memcg                               -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] __x64_sys_kill                 =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] copy_page_range                               -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] do_send_sig_info          =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] start_secondary                               -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] apparmor_file_permiss=
ion                      -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] unlock_page                                   -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] unwind_next_fram=
e                             -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] copy_p4d_range                                -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] step_into  =
                                   -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] rcu_do_batch                                  =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __send=
_signal                                 -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] cpumask_next_and                         =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] _=
_x64_sys_mprotect                            -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] do_mprotect_pkey                    =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] do_IRQ                                        -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] netif_receive_skb_list_internal=
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] node_read_numastat                            -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] timekeeping_update        =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] wake_up_klogd_work_func                       -      -       =
     =0A     0.00%     0.00%  perf                [.] write@plt            =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] delay_tsc                                     -      -  =
          =0A     0.00%     0.00%  libpthread-2.24.so  [.] __pthread_enable=
_asynccancel                  -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] shmem_pseudo_vma_init                         -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] dequeue_tas=
k_fair                             -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] __netif_receive_skb_list_core                 =
-      -            =0A     0.00%     0.00%  libpthread-2.24.so  [.] __GI__=
_libc_read                              -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] vt_console_print                         =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] l=
f                                            -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] con_scroll                          =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] fbcon_scroll                                  -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] fbcon_redraw.isra.18           =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] fbcon_putcs                                   -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] bit_putcs                 =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] mprotect_fixup                                -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] proc_reg_read        =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] PageHuge                                      -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] sys_imageblit   =
                              -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] iov_iter_init                                 -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] pick_next_e=
ntity                              -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] update_curr_rt                                =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] seq_pr=
intf                                    -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] do_faccessat                             =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] d=
rm_fb_helper_sys_imageblit                   -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] node_read_vmstat                    =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] vmstat_update                                 -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] set_next_entity                =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] devkmsg_read                                  -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] diskstats_show            =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] kill_something_info                           -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] put_prev_entity      =
                         -      -            =0A     0.00%     0.00%  libc-=
2.24.so        [.] _dl_addr                                      -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __mem_cgroup_thr=
eshold                        -      -            =0A     0.00%     0.00%  =
libc-2.24.so        [.] _IO_vfscanf                                   -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __x64_sys_w=
rite                               -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] refresh_cpu_vm_stats                          =
-      -            =0A     0.00%     0.00%  perf                [.] evsel_=
_read_counter                           -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] cpumask_next                             =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] a=
cpi_os_execute_deferred                      -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] acpi_ev_asynch_execute_gpe_method   =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] acpi_ns_evaluate                              -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] acpi_ps_execute_method         =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] ip_list_rcv                                   -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] ip_sublist_rcv            =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] schedule_idle                                 -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] seq_vprintf          =
                         -      -            =0A     0.00%     0.00%  libc-=
2.24.so        [.] wait4                                         -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __f_unlock_pos  =
                              -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] format_decode                                 -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] get_user_ar=
g_ptr.isra.23                      -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] tick_do_update_jiffies64.part.17              =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] alloc_=
empty_file                              -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] __alloc_file                             =
     -      -            =0A     0.00%     0.00%  libc-2.24.so        [.] s=
ched_setaffinity                             -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] __do_sys_newstat                    =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] acpi_ps_parse_aml                             -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] dequeue_signal                 =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] do_open_execat                                -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] schedule_timeout          =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] vfs_statx                                     -      -       =
     =0A     0.00%     0.00%  libpthread-2.24.so  [.] start_thread         =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] __switch_to                                   -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] update_irq_load_=
avg                           -      -            =0A     0.00%     0.00%  =
libc-2.24.so        [.] __mbrtowc                                     -    =
  -            =0A     0.00%     0.00%  perf                [.] perf_data_f=
ile__write                         -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] part_stat_read_all.isra.22                    =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] vma_po=
licy_mof                                -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] __might_fault                            =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] f=
ree_uid                                      -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] igb_clean_rx_irq                    =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] __dentry_kill                                 -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] __fput                         =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] __get_user_pages_remote                       -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] __setup_rt_frame          =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] dequeue_entity                                -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] dput                 =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] lookup_fast                                   -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] notifier_call_ch=
ain                           -      -            =0A     0.00%     0.00%  =
libc-2.24.so        [.] poll                                          -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __dequeue_s=
ignal                              -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] __split_vma                                   =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] do_den=
try_open                                -      -            =0A     0.00%  =
   0.00%  libc-2.24.so        [.] __isoc99_vsscanf                         =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] m=
pol_shared_policy_lookup                     -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] pvclock_gtod_notify                 =
          -      -            =0A     0.00%     0.00%  gawk                =
[.] r_interpret                                   -      -            =0A  =
   0.00%     0.00%  libc-2.24.so        [.] _IO_fwrite                     =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] __unlock_page_memcg                           -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] call_rcu                  =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] inode_permission                              -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] rcu_note_context_swit=
ch                       -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] rcu_qs                                        -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] copy_fpstate_to_=
sigframe                      -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] perf_poll                                     -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __get_user_=
pages                              -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] __x64_sys_sched_setaffinity                   =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] getnam=
e_flags                                 -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] ip_route_input_noref                     =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] _=
_x64_sys_rt_sigreturn                        -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] restore_sigcontext                  =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] __do_sys_wait4                                -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] __unwind_start                 =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] __vma_adjust                                  -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] __x64_sys_poll            =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] acpi_ps_parse_loop                            -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] cache_show           =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] do_sys_poll                                   -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] group_send_sig_i=
nfo                           -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] ip_rcv_finish_core.isra.19                    -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] kernel_wait=
4                                  -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] do_wait                                       =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] slab_s=
how                                     -      -            =0A     0.00%  =
   0.00%  gawk                [.] more_blocks                              =
     -      -            =0A     0.00%     0.00%  libc-2.24.so        [.] c=
lose                                         -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] __d_lookup_rcu                      =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] __slab_free                                   -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] account_user_time              =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] copy_page                                     -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] native_iret               =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] vma_interval_tree_insert                      -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __clear_user         =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] clear_buddies                                 -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] pmd_trans_huge  =
                              -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] sched_setaffinity                             -    =
  -            =0A     0.00%     0.00%  libc-2.24.so        [.] _IO_file_xs=
putn                               -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] __kmalloc                                     =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] apparm=
or_task_kill                            -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] from_kuid_munged                         =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] i=
p_route_input_slow                           -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] seq_put_decimal_ull_width           =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] touch_atime                                   -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] __do_sys_newfstat              =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] __lookup_slow                                 -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] copy_user_highpage.isra.85=
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] cpu_stopper_thread                            -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] cpuidle_enter        =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] cpuidle_enter_state                           -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] ip_route_input_r=
cu                            -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] msg_print_ext_header.constprop.32             -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] sched_move_=
task                               -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] scnprintf                                     =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] securi=
ty_task_kill                            -      -            =0A     0.00%  =
   0.00%  libc-2.24.so        [.] __strcasecmp                             =
     -      -            =0A     0.00%     0.00%  libc-2.24.so        [.] a=
larm                                         -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] __radix_tree_lookup                 =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] __vfs_write                                   -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] blkcg_maybe_throttle_current   =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] copy_user_generic_unrolled                    -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] d_path                    =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] kick_process                                  -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] map_id_up            =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] memset_erms                                   -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] shmem_recalc_ino=
de                            -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] copy_strings_kernel                           -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] switch_mm_i=
rqs_off                            -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] update_vsyscall                               =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __fpu_=
_restore_sig                            -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] num_to_str                               =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] r=
efcount_dec_and_lock_irqsave                 -      -            =0A     0.=
00%     0.00%  dash                [.] evalcommand                         =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] __activate_page                               -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] __note_gp_changes              =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] fpu__clear                                    -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] xas_alloc                 =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] __check_object_size                           -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] cp_new_stat          =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] group_balance_cpu                             -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] perf_read       =
                              -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] security_file_alloc                           -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] terminate_w=
alk                                -      -            =0A     0.00%     0.=
00%  perf                [.] perf_evsel__read                              =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __sigq=
ueue_free.part.18                       -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] __vmalloc_node_range                     =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] _=
_x64_sys_readlink                            -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] cgroup_post_fork                    =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] pipe_release                                  -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] ttwu_do_wakeup                 =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] check_preempt_curr                            -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] check_preempt_wakeup      =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] count.isra.24.constprop.41                    -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] do_readlinkat        =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] do_task_dead                                  -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] fifo_open       =
                              -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] generic_file_mmap                             -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] migration_c=
pu_stop                            -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] move_queued_task                              =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] open_e=
xec                                     -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] pipe_wait                                =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] p=
repare_binprm                                -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] stop_one_cpu                        =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] wait_for_partner                              -      -            =0A  =
   0.00%     0.00%  perf                [.] evlist__disable                =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] __mnt_want_write_file                         -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] __orc_find                =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] __switch_to_asm                               -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] aa_get_task_label    =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] dyntick_save_progress_counter                 -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] find_first_bit  =
                              -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] fput                                          -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] smp_call_fu=
nction_single                      -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] io_serial_out                                 =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] io_ser=
ial_in                                  -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] prepare_signal                           =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] s=
hmem_get_policy                              -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] strnlen_user                        =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] update_group_capacity                         -      -            =0A  =
   0.00%     0.00%  dash                [.] listvars                       =
               -      -            =0A     0.00%     0.00%  perf           =
     [.] perf_evlist                                   -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] __set_current_blocked     =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] __sigqueue_alloc                              -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] alloc_vmap_area      =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] invoke_rcu_core                               -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] path_init       =
                              -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] rcu_accelerate_cbs                            -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] rcu_segcbli=
st_pend_cbs                        -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] rt_dst_alloc                                  =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] strncp=
y_from_user                             -      -            =0A     0.00%  =
   0.00%  dash                [.] cmdlookup                                =
     -      -            =0A     0.00%     0.00%  gawk                [.] m=
ake_str_node                                 -      -            =0A     0.=
00%     0.00%  libc-2.24.so        [.] getenv                              =
          -      -            =0A     0.00%     0.00%  libc-2.24.so        =
[.] strlen                                        -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] __d_alloc                      =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] __internal_add_timer                          -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] alloc_pid                 =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] anon_vma_clone                                -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] d_add                =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] do_setitimer                                  -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] ip_error        =
                              -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] prepare_creds                                 -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] sched_rt_pe=
riod_timer                         -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] scheduler_ipi                                 =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] signal=
_wake_up_state                          -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] stack_trace_consume_entry_nosched        =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] u=
nlazy_walk                                   -      -            =0A     0.=
00%     0.00%  libc-2.24.so        [.] __printf_chk                        =
          -      -            =0A     0.00%     0.00%  libc-2.24.so        =
[.] ioctl                                         -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] __get_vm_area_node             =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] __put_user_4                                  -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] __x64_sys_alarm           =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] acpi_ds_exec_end_op                           -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] alarm_setitimer      =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] anon_vma_fork                                 -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] d_alloc_parallel=
                              -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] d_alloc                                       -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] do_notify_p=
arent                              -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] kmsg_read                                     =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] do_sys=
log.part.25                             -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] find_extend_vma                          =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] e=
xpand_downwards                              -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] ip_sublist_rcv_finish               =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] kernel_read                                   -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] lock_page                      =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] node_read_meminfo                             -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] wait_consider_task        =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] release_task                                  -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] proc_flush_pid       =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] proc_invalidate_siblings_dcache               -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] reschedule_inter=
rupt                          -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] schedule_tail                                 -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] signal_setu=
p_done                             -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] simple_lookup                                 =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] sprint=
f                                       -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] wake_up_q                                =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] x=
as_find                                      -      -            =0A     0.=
00%     0.00%  libc-2.24.so        [.] _IO_file_close                      =
          -      -            =0A     0.00%     0.00%  libc-2.24.so        =
[.] __fxstat64                                    -      -            =0A  =
   0.00%     0.00%  libc-2.24.so        [.] __xstat64                      =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] __bitmap_and                                  -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] __mnt_want_write          =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] __usecs_to_jiffies                            -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __netif_receive_skb_c=
ore                      -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] __virt_addr_valid                             -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] _raw_spin_tryloc=
k                             -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] aa_may_signal                                 -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] apparmor_cr=
ed_prepare                         -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] blk_mq_queue_tag_busy_iter                    =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] calc_g=
lobal_load                              -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] calc_wheel_index                         =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] f=
ind_next_and_bit                             -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] fpregs_mark_activate                =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] free_one_page                                 -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] generic_permission             =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] hrtick_update                                 -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] idr_get_free              =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] in_lock_functions                             -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] is_cpu_allowed       =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] kcpustat_cpu_fetch                            -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] may_open        =
                              -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] native_irq_return_ldt                         -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] number     =
                                   -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] page_cpupid_xchg_last                         =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] propag=
ate_entity_cfs_rq.isra.87               -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] rcu_cblist_dequeue                       =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] r=
cu_report_qs_rnp                             -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] round_jiffies_relative              =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] switch_fpu_return                             -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] update_dl_rq_load_avg          =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] update_fast_timekeeper                        -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] vma_interval_tree_remove  =
                    -      -            =0A     0.00%     0.00%  dash      =
          [.] dowait                                        -      -       =
     =0A     0.00%     0.00%  dash                [.] findvar              =
                         -      -            =0A     0.00%     0.00%  libc-=
2.24.so        [.] _IO_file_overflow                             -      -  =
          =0A     0.00%     0.00%  libc-2.24.so        [.] _IO_file_write  =
                              -      -            =0A     0.00%     0.00%  =
libc-2.24.so        [.] btowc                                         -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] _perf_ioctl=
                                   -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] xas_nomem                                     =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] acpi_d=
s_call_control_method                   -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] balance_fair                             =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] c=
pumask_next_wrap                             -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] kfree_skb                           =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] perf_event_read                               -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] perf_pending_event             =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] pick_next_task_rt                             -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] put_cred_rcu              =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] sched_change_group                            -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] security_task_getseci=
d                        -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] set_task_cpu                                  -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] ___slab_alloc   =
                              -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] __d_lookup_done                               -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __free_page=
s_ok                               -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] __lock_task_sighand                           =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __mmdr=
op                                      -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] __set_cpus_allowed_ptr                   =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] _=
_slab_alloc                                  -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] __x64_sys_futex                     =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] __x64_sys_ioctl                               -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] _copy_to_user                  =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] blk_mq_in_flight                              -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] complete_walk             =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] copy_page_from_iter                           -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] copy_page_to_iter    =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] cpu_cgroup_fork                               -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] d_invalidate    =
                              -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] do_futex                                      -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] free_pipe_i=
nfo                                -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] generic_exec_single                           =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] generi=
c_file_read_iter                        -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] get_idle_time.isra.2                     =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] g=
et_iowait_time.isra.3                        -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] get_cpu_idle_time_us                =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] get_cpu_iowait_time_us                        -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] idr_alloc_cyclic               =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] idr_alloc_u32                                 -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] in_sched_functions        =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] ksys_ioctl                                    -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] load_elf_phdrs       =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] map_vdso                                      -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __install_specia=
l_mapping                     -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] move_page_tables                              -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] new_slab   =
                                   -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] next_online_pgdat                             =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] perf_i=
octl                                    -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] perf_output_copy                         =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] p=
repare_to_swait_event                        -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] put_prev_task_fair                  =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] sched_slice.isra.63                           -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] sched_ttwu_pending             =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] security_prepare_creds                        -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] seq_path                  =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] setup_arg_pages                               -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] shift_arg_pages      =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] show_map                                      -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] show_map_vma    =
                              -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] shrink_dcache_parent                          -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] shrink_dent=
ry_list                            -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] sock_sendmsg                                  =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] tick_i=
rq_enter                                -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] user_path_at_empty                       =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] w=
p_page_reuse                                 -      -            =0A     0.=
00%     0.00%  dash                [.] closescript                         =
          -      -            =0A     0.00%     0.00%  libc-2.24.so        =
[.] _IO_file_open                                 -      -            =0A  =
   0.00%     0.00%  libc-2.24.so        [.] _IO_setvbuf                    =
               -      -            =0A     0.00%     0.00%  libc-2.24.so   =
     [.] getopt_long                                   -      -            =
=0A     0.00%     0.00%  libc-2.24.so        [.] open64                    =
                    -      -            =0A     0.00%     0.00%  libc-2.24.=
so        [.] vsscanf                                       -      -       =
     =0A     0.00%     0.00%  libpthread-2.24.so  [.] __GI___libc_open     =
                         -      -            =0A     0.00%     0.00%  libpt=
hread-2.24.so  [.] pthread_cond_signal@@GLIBC_2.3.2              -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] ___d_drop       =
                              -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] ___pud_free_tlb                               -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __bitmap_in=
tersects                           -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] __d_free                                      =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __d_lo=
okup                                    -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] __destroy_inode                          =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] _=
_get_user_8                                  -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] __handle_irq_event_percpu           =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] __build_skb                                   -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] __hrtimer_init                 =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] __ipv6_dev_get_saddr                          -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] __mnt_drop_write_file     =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] __mark_inode_dirty                            -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __module_get         =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] __msecs_to_jiffies                            -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __mutex_init    =
                              -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] __percpu_counter_compare                      -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __pollwait =
                                   -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] __pti_set_user_pgtbl                          =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __pud_=
alloc                                   -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] __raw_spin_unlock                        =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] _=
_raw_spin_unlock_irq                         -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] __remove_shared_vm_struct           =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] __seccomp_filter                              -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] __task_rq_lock                 =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] __vfs_read                                    -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] __wake_up_bit             =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] __x64_sys_close                               -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] acpi_ps_get_opcode_in=
fo                       -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] acpi_ns_lookup                                -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] acpi_ps_complete=
_this_op                      -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] acpi_ds_is_result_used                        -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] acpi_ex_do_=
logical_op                         -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] apparmor_file_alloc_security                  =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] attach=
_entity_load_avg                        -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] audit_signal_info                        =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] b=
alance_dl                                    -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] cgroup_css_set_put_fork             =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] check_stack_object                            -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] complete                       =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] detach_if_pending                             -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] dma_direct_sync_single_for=
_cpu                -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] do_timer                                      -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] enter_lazy_tlb       =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] errseq_sample                                 -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] fib_table_lookup=
                              -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] file_free_rcu                                 -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] filemap_fau=
lt                                 -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] find_next_iomem_res                           =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] find_n=
ext_zero_bit                            -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] find_vmap_area                           =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] f=
lush_signal_handlers                         -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] fold_diff                           =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] fpu__copy                                     -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] fpu__drop                      =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] free_pcppages_bulk                            -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] freezer_fork              =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] ftrace_graph_init_task                        -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] ftrace_graph_ret_addr=
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] igb_alloc_rx_buffers                          -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] inet_gro_receive=
                              -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] kmem_cache_alloc_node                         -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] kstat_irqs =
                                   -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] kthread_data                                  =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] legiti=
mize_root                               -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] lock_hrtimer_base                        =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] l=
ockref_get                                   -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] lockref_get_not_dead                =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] locks_remove_posix                            -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] lru_cache_add_anon             =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] mangle_path                                   -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] mm_release                =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] mm_update_next_owner                          -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] mntput               =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] native_flush_tlb_one_user                     -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] native_load_tls =
                              -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] get_nohz_timer_target                         -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] nd_jump_roo=
t                                  -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] next_zone                                     =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] nr_con=
text_switches                           -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] orc_find.part.4                          =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] p=
age_frag_free                                -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] page_get_link                       =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] page_trans_huge_mapcount                      -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] pick_next_task_stop            =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] proc_reg_open                                 -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] put_dec_trunc8            =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] queue_work_on                                 -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] rcu_advance_cbs      =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] rcu_core_si                                   -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] rcu_is_watching =
                              -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] rcu_segcblist_enqueue                         -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] recalc_sigp=
ending_tsk                         -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] refcount_dec_not_one                          =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] remote=
_function                               -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] remove_entity_load_avg                   =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] r=
estore_nameidata                             -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] security_bprm_set_creds             =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] security_inode_permission                     -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] send_signal                    =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] seq_list_start                                -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] set_next_buddy            =
                    -      -            =0A     0.00%     0.00%  [kernel.ka=
llsyms]   [k] simple_getattr                                -      -       =
     =0A     0.00%     0.00%  [kernel.kallsyms]   [k] string_nocheck       =
                         -      -            =0A     0.00%     0.00%  [kern=
el.kallsyms]   [k] sum_vm_events                                 -      -  =
          =0A     0.00%     0.00%  [kernel.kallsyms]   [k] switch_ldt      =
                              -      -            =0A     0.00%     0.00%  =
[kernel.kallsyms]   [k] task_of                                       -    =
  -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] task_wants_=
autogroup                          -      -            =0A     0.00%     0.=
00%  [kernel.kallsyms]   [k] unlock_page_memcg                             =
-      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] unregi=
ster_hw_breakpoint                      -      -            =0A     0.00%  =
   0.00%  [kernel.kallsyms]   [k] update_cfs_rq_h_load                     =
     -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] u=
pdate_time                                   -      -            =0A     0.=
00%     0.00%  [kernel.kallsyms]   [k] update_ts_time_stats                =
          -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   =
[k] vdso_fault                                    -      -            =0A  =
   0.00%     0.00%  [kernel.kallsyms]   [k] vma_adjust_trans_huge          =
               -      -            =0A     0.00%     0.00%  [kernel.kallsym=
s]   [k] vma_interval_tree_insert_after                -      -            =
=0A     0.00%     0.00%  [kernel.kallsyms]   [k] wakeup_preempt_entity.isra=
=2E65                 -      -            =0A     0.00%     0.00%  dash    =
            [.] _init                                         -      -     =
       =0A     0.00%     0.00%  dash                [.] evalvar            =
                           -      -            =0A     0.00%     0.00%  das=
h                [.] poplocalvars                                  -      -=
            =0A     0.00%     0.00%  dash                [.] stalloc       =
                                -      -            =0A     0.00%     0.00%=
  dash                [.] waitforjob                                    -  =
    -            =0A     0.00%     0.00%  dmesg               [.] strchr@pl=
t                                    -      -            =0A     0.00%     =
0.00%  gawk                [.] inrec                                       =
  -      -            =0A     0.00%     0.00%  gawk                [.] r_ge=
t_field                                   -      -            =0A     0.00%=
     0.00%  grep                [.] _init                                  =
       -      -            =0A     0.00%     0.00%  ld-2.24.so          [.]=
 __libc_memalign                               -      -            =0A     =
0.00%     0.00%  ld-2.24.so          [.] calloc                            =
            -      -            =0A     0.00%     0.00%  libc-2.24.so      =
  [.] _IO_fflush                                    -      -            =0A=
     0.00%     0.00%  libc-2.24.so        [.] __ctype_b_loc                =
                 -      -            =0A     0.00%     0.00%  libc-2.24.so =
       [.] __strtoull_internal                           -      -          =
  =0A     0.00%     0.00%  libc-2.24.so        [.] _setjmp                 =
                      -      -            =0A     0.00%     0.00%  libc-2.2=
4.so        [.] fopen                                         -      -     =
       =0A     0.00%     0.00%  libc-2.24.so        [.] memcpy             =
                           -      -            =0A     0.00%     0.00%  lib=
c-2.24.so        [.] memmem                                        -      -=
            =0A     0.00%     0.00%  libc-2.24.so        [.] vfprintf      =
                                -      -            =0A     0.00%     0.00%=
  perf                [.] perf_stat_process_counter                     -  =
    -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] ___sys_se=
ndmsg                                -      -            =0A     0.00%     =
0.00%  [kernel.kallsyms]   [k] ____sys_sendmsg                             =
  -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __al=
loc_fd                                    -      -            =0A     0.00%=
     0.00%  [kernel.kallsyms]   [k] __d_drop.part.19                       =
       -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k]=
 __do_pipe_flags                               -      -            =0A     =
0.00%     0.00%  [kernel.kallsyms]   [k] __hrtimer_get_remaining           =
            -      -            =0A     0.00%     0.00%  [kernel.kallsyms] =
  [k] __kernel_text_address                         -      -            =0A=
     0.00%     0.00%  [kernel.kallsyms]   [k] __legitimize_path            =
                 -      -            =0A     0.00%     0.00%  [kernel.kalls=
yms]   [k] __perf_event__output_id_sample                -      -          =
  =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __perf_event_header__ini=
t_id                  -      -            =0A     0.00%     0.00%  [kernel.=
kallsyms]   [k] __perf_event_read_value                       -      -     =
       =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __perf_read_group_a=
dd                         -      -            =0A     0.00%     0.00%  [ke=
rnel.kallsyms]   [k] __perf_event_read                             -      -=
            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __pmd_alloc   =
                                -      -            =0A     0.00%     0.00%=
  [kernel.kallsyms]   [k] __sched_fork                                  -  =
    -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __sys_sen=
dmsg                                 -      -            =0A     0.00%     =
0.00%  [kernel.kallsyms]   [k] __sys_sendto                                =
  -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] __tr=
averse_mounts                             -      -            =0A     0.00%=
     0.00%  [kernel.kallsyms]   [k] __update_load_avg_blocked_se           =
       -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k]=
 __vunmap                                      -      -            =0A     =
0.00%     0.00%  [kernel.kallsyms]   [k] __x64_sys_brk                     =
            -      -            =0A     0.00%     0.00%  [kernel.kallsyms] =
  [k] __x64_sys_nanosleep                           -      -            =0A=
     0.00%     0.00%  [kernel.kallsyms]   [k] __x64_sys_pipe               =
                 -      -            =0A     0.00%     0.00%  [kernel.kalls=
yms]   [k] __x64_sys_sendto                              -      -          =
  =0A     0.00%     0.00%  [kernel.kallsyms]   [k] _atomic_dec_and_lock    =
                      -      -            =0A     0.00%     0.00%  [kernel.=
kallsyms]   [k] _copy_from_user                               -      -     =
       =0A     0.00%     0.00%  [kernel.kallsyms]   [k] _copy_to_iter      =
                           -      -            =0A     0.00%     0.00%  [ke=
rnel.kallsyms]   [k] acpi_ps_create_scope_op                       -      -=
            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] acpi_ds_begin_=
method_execution                -      -            =0A     0.00%     0.00%=
  [kernel.kallsyms]   [k] acpi_ds_create_walk_state                     -  =
    -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] acpi_ps_c=
omplete_op                           -      -            =0A     0.00%     =
0.00%  [kernel.kallsyms]   [k] acpi_ps_create_op                           =
  -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] acpi=
_ps_get_next_namepath                     -      -            =0A     0.00%=
     0.00%  [kernel.kallsyms]   [k] acpi_ds_create_operands                =
       -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k]=
 acpi_ds_delete_result_if_not_used             -      -            =0A     =
0.00%     0.00%  [kernel.kallsyms]   [k] acpi_ex_opcode_2A_0T_1R           =
            -      -            =0A     0.00%     0.00%  [kernel.kallsyms] =
  [k] acpi_ex_start_trace_method                    -      -            =0A=
     0.00%     0.00%  [kernel.kallsyms]   [k] acpi_ds_create_operand       =
                 -      -            =0A     0.00%     0.00%  [kernel.kalls=
yms]   [k] acpi_ns_get_normalized_pathname               -      -          =
  =0A     0.00%     0.00%  [kernel.kallsyms]   [k] acpi_ut_create_internal_=
object_dbg            -      -            =0A     0.00%     0.00%  [kernel.=
kallsyms]   [k] acpi_ut_allocate_object_desc_dbg              -      -     =
       =0A     0.00%     0.00%  [kernel.kallsyms]   [k] add_timer_on       =
                           -      -            =0A     0.00%     0.00%  [ke=
rnel.kallsyms]   [k] alloc_file_pseudo                             -      -=
            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] alloc_file    =
                                -      -            =0A     0.00%     0.00%=
  [kernel.kallsyms]   [k] apparmor_task_getsecid                        -  =
    -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] arch_irq_=
stat_cpu                             -      -            =0A     0.00%     =
0.00%  [kernel.kallsyms]   [k] atime_needs_update                          =
  -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] buil=
d_skb                                     -      -            =0A     0.00%=
     0.00%  [kernel.kallsyms]   [k] check_kill_permission                  =
       -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k]=
 copy_creds                                    -      -            =0A     =
0.00%     0.00%  [kernel.kallsyms]   [k] copyout                           =
            -      -            =0A     0.00%     0.00%  [kernel.kallsyms] =
  [k] cpu_stop_queue_work                           -      -            =0A=
     0.00%     0.00%  [kernel.kallsyms]   [k] cpu_stop_should_run          =
                 -      -            =0A     0.00%     0.00%  [kernel.kalls=
yms]   [k] create_pipe_files                             -      -          =
  =0A     0.00%     0.00%  [kernel.kallsyms]   [k] destroy_inode           =
                      -      -            =0A     0.00%     0.00%  [kernel.=
kallsyms]   [k] dev_gro_receive                               -      -     =
       =0A     0.00%     0.00%  [kernel.kallsyms]   [k] do_brk_flags       =
                           -      -            =0A     0.00%     0.00%  [ke=
rnel.kallsyms]   [k] do_nanosleep                                  -      -=
            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] do_pipe2      =
                                -      -            =0A     0.00%     0.00%=
  [kernel.kallsyms]   [k] drm_client_buffer_vunmap                      -  =
    -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] drm_gem_v=
ram_vunmap                           -      -            =0A     0.00%     =
0.00%  [kernel.kallsyms]   [k] dst_alloc                                   =
  -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] dst_=
destroy                                   -      -            =0A     0.00%=
     0.00%  [kernel.kallsyms]   [k] event_function_call                    =
       -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k]=
 evict                                         -      -            =0A     =
0.00%     0.00%  [kernel.kallsyms]   [k] filp_close                        =
            -      -            =0A     0.00%     0.00%  [kernel.kallsyms] =
  [k] finish_wait                                   -      -            =0A=
     0.00%     0.00%  [kernel.kallsyms]   [k] flush_thread                 =
                 -      -            =0A     0.00%     0.00%  [kernel.kalls=
yms]   [k] flush_ptrace_hw_breakpoint                    -      -          =
  =0A     0.00%     0.00%  [kernel.kallsyms]   [k] free_ldt_pgtables       =
                      -      -            =0A     0.00%     0.00%  [kernel.=
kallsyms]   [k] free_work                                     -      -     =
       =0A     0.00%     0.00%  [kernel.kallsyms]   [k] generic_update_time=
                           -      -            =0A     0.00%     0.00%  [ke=
rnel.kallsyms]   [k] hrtimer_nanosleep                             -      -=
            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] hrtimer_start_=
range_ns                        -      -            =0A     0.00%     0.00%=
  [kernel.kallsyms]   [k] hrtimer_wakeup                                -  =
    -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] ima_bprm_=
check                                -      -            =0A     0.00%     =
0.00%  [kernel.kallsyms]   [k] ima_file_check                              =
  -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] init=
_dl_inactive_task_timer                   -      -            =0A     0.00%=
     0.00%  [kernel.kallsyms]   [k] ip6_sk_dst_lookup_flow                 =
       -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k]=
 ip6_dst_lookup_flow                           -      -            =0A     =
0.00%     0.00%  [kernel.kallsyms]   [k] ip6_dst_lookup_tail               =
            -      -            =0A     0.00%     0.00%  [kernel.kallsyms] =
  [k] iput                                          -      -            =0A=
     0.00%     0.00%  [kernel.kallsyms]   [k] ipv6_dev_get_saddr           =
                 -      -            =0A     0.00%     0.00%  [kernel.kalls=
yms]   [k] itimer_get_remtime                            -      -          =
  =0A     0.00%     0.00%  [kernel.kallsyms]   [k] mutex_lock_interruptible=
                      -      -            =0A     0.00%     0.00%  [kernel.=
kallsyms]   [k] kernel_text_address                           -      -     =
       =0A     0.00%     0.00%  [kernel.kallsyms]   [k] kstat_irqs_usr     =
                           -      -            =0A     0.00%     0.00%  [ke=
rnel.kallsyms]   [k] legitimize_links                              -      -=
            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] lookup_memtype=
                                -      -            =0A     0.00%     0.00%=
  [kernel.kallsyms]   [k] migrate_task_rq_fair                          -  =
    -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] napi_gro_=
receive                              -      -            =0A     0.00%     =
0.00%  [kernel.kallsyms]   [k] native_set_p4d                              =
  -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] ntp_=
tick_length                               -      -            =0A     0.00%=
     0.00%  [kernel.kallsyms]   [k] pagecache_get_page                     =
       -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k]=
 pat_pagerange_is_ram                          -      -            =0A     =
0.00%     0.00%  [kernel.kallsyms]   [k] perf_event_for_each_child         =
            -      -            =0A     0.00%     0.00%  [kernel.kallsyms] =
  [k] perf_event_wakeup                             -      -            =0A=
     0.00%     0.00%  [kernel.kallsyms]   [k] pmd_devmap                   =
                 -      -            =0A     0.00%     0.00%  [kernel.kalls=
yms]   [k] prepare_exec_creds                            -      -          =
  =0A     0.00%     0.00%  [kernel.kallsyms]   [k] prepare_to_wait_event   =
                      -      -            =0A     0.00%     0.00%  [kernel.=
kallsyms]   [k] proc_single_show                              -      -     =
       =0A     0.00%     0.00%  [kernel.kallsyms]   [k] proc_cgroup_show   =
                           -      -            =0A     0.00%     0.00%  [ke=
rnel.kallsyms]   [k] ptep_clear_flush                              -      -=
            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] put_files_stru=
ct                              -      -            =0A     0.00%     0.00%=
  [kernel.kallsyms]   [k] queue_delayed_work_on                         -  =
    -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] recalc_si=
gpending                             -      -            =0A     0.00%     =
0.00%  [kernel.kallsyms]   [k] reuse_swap_page                             =
  -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] sche=
d_fork                                    -      -            =0A     0.00%=
     0.00%  [kernel.kallsyms]   [k] security_task_setscheduler             =
       -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k]=
 skb_copy_datagram_from_iter                   -      -            =0A     =
0.00%     0.00%  [kernel.kallsyms]   [k] stack_access_ok                   =
            -      -            =0A     0.00%     0.00%  [kernel.kallsyms] =
  [k] start_kernel                                  -      -            =0A=
     0.00%     0.00%  [kernel.kallsyms]   [k] strchr                       =
                 -      -            =0A     0.00%     0.00%  [kernel.kalls=
yms]   [k] string                                        -      -          =
  =0A     0.00%     0.00%  [kernel.kallsyms]   [k] syscall_trace_enter     =
                      -      -            =0A     0.00%     0.00%  [kernel.=
kallsyms]   [k] task_clock_event_read                         -      -     =
       =0A     0.00%     0.00%  [kernel.kallsyms]   [k] task_rq_lock       =
                           -      -            =0A     0.00%     0.00%  [ke=
rnel.kallsyms]   [k] task_work_add                                 -      -=
            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] vmf_insert_pfn=
_prot                           -      -            =0A     0.00%     0.00%=
  [kernel.kallsyms]   [k] track_pfn_insert                              -  =
    -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] try_modul=
e_get                                -      -            =0A     0.00%     =
0.00%  [kernel.kallsyms]   [k] udpv6_sendmsg                               =
  -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k] unix=
_stream_sendmsg                           -      -            =0A     0.00%=
     0.00%  [kernel.kallsyms]   [k] unwind_get_return_address              =
       -      -            =0A     0.00%     0.00%  [kernel.kallsyms]   [k]=
 vfs_statx_fd                                  -      -            =0A     =
0.00%     0.00%  [kernel.kallsyms]   [k] vmstat_show                       =
            -      -            =0A     0.00%     0.00%  [kernel.kallsyms] =
  [k] vmstat_start                                  -      -            =0A=
     0.00%     0.00%  [kernel.kallsyms]   [k] wait_for_completion          =
                 -      -            =0A     0.00%     0.00%  [kernel.kalls=
yms]   [k] walk_system_ram_range                         -      -          =
  =0A     0.00%     0.00%  [kernel.kallsyms]   [k] worker_enter_idle       =
                      -      -            =0A     0.00%     0.00%  [kernel.=
kallsyms]   [k] wq_worker_running                             -      -     =
       =0A     0.00%     0.00%  [kernel.kallsyms]   [k] ww_mutex_lock      =
                           -      -            =0A     0.00%     0.00%  das=
h                [.] _rmescapes                                    -      -=
            =0A     0.00%     0.00%  dash                [.] onsig         =
                                -      -            =0A     0.00%     0.00%=
  gawk                [.] estrdup                                       -  =
    -            =0A     0.00%     0.00%  ld-2.24.so          [.] malloc@pl=
t                                    -      -            =0A     0.00%     =
0.00%  libc-2.24.so        [.] _IO_file_read                               =
  -      -            =0A     0.00%     0.00%  libc-2.24.so        [.] __cl=
ock_gettime                               -      -            =0A     0.00%=
     0.00%  libc-2.24.so        [.] __ctype_init                           =
       -      -            =0A     0.00%     0.00%  libc-2.24.so        [.]=
 __getpid                                      -      -            =0A     =
0.00%     0.00%  libc-2.24.so        [.] __pipe                            =
            -      -            =0A     0.00%     0.00%  libc-2.24.so      =
  [.] __sbrk                                        -      -            =0A=
     0.00%     0.00%  libc-2.24.so        [.] __sysconf                    =
                 -      -            =0A     0.00%     0.00%  libc-2.24.so =
       [.] __vsprintf_chk                                -      -          =
  =0A     0.00%     0.00%  libc-2.24.so        [.] brk                     =
                      -      -            =0A     0.00%     0.00%  libc-2.2=
4.so        [.] strnlen                                       -      -     =
       =0A     0.00%     0.00%  libc-2.24.so        [.] time               =
                           -      -            =0A     0.00%     0.00%  lib=
m-2.24.so        [.] cos                                           -      -=
            =0A     0.00%     0.00%  libpthread-2.24.so  [.] __GI___libc_se=
ndto                            -      -            =0A     0.00%     0.00%=
  libpthread-2.24.so  [.] __libc_sendmsg                                -  =
    -            =0A     0.00%     0.00%  libpthread-2.24.so  [.] __nanosle=
ep                                   -      -            =0A     0.00%     =
0.00%  libreadline.so.7.0  [.] _fini                                       =
  -      -            =0A=0A=0A# Samples: 0  of event 'dummy:HG'=0A# Event =
count (approx.): 0=0A#=0A# Children      Self  Shared Object  Symbol  IPC  =
 [IPC Coverage]=0A# ........  ........  .............  ......  ............=
=2E.......=0A#=0A=0A=0A#=0A# (Cannot load tips.txt file, please install per=
f!)=0A#=0A
--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="perf-profile.new"
Content-Transfer-Encoding: quoted-printable

# =3D=3D=3D=3D=3D=3D=3D=3D
# captured on    : Wed Aug 19 14:08:27 2020
# header version : 1
# data offset    : 4984
# data size      : 269262376
# feat offset    : 269267360
# hostname : lkp-knm01
# os release : 5.7.0-rc1-00011-g1de08dccd3834
# perf version : 5.8.rc2.g3e08a95294a4
# arch : x86_64
# nrcpus online : 288
# nrcpus avail : 288
# cpudesc : Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz
# cpuid : GenuineIntel,6,133,0
# total memory : 82305680 kB
# cmdline : /lkp/benchmarks/perf/perf record -q -ag --realtime=3D1 -m 256 -=
-count=3D1000003 -e cycles:pp -o /tmp/lkp/perf.data -D 100000 -- /lkp/lkp/s=
rc/bin/event/wait post-test --timeout 110=20
# event : name =3D cycles:pp, , id =3D { 5278, 5279, 5280, 5281, 5282, 5283=
, 5284, 5285, 5286, 5287, 5288, 5289, 5290, 5291, 5292, 5293, 5294, 5295, 5=
296, 5297, 5298, 5299, 5300, 5301, 5302, 5303, 5304, 5305, 5306, 5307, 5308=
, 5309, 5310, 5311, 5312, 5313, 5314, 5315, 5316, 5317, 5318, 5319, 5320, 5=
321, 5322, 5323, 5324, 5325, 5326, 5327, 5328, 5329, 5330, 5331, 5332, 5333=
, 5334, 5335, 5336, 5337, 5338, 5339, 5340, 5341, 5342, 5343, 5344, 5345, 5=
346, 5347, 5348, 5349, 5350, 5351, 5352, 5353, 5354, 5355, 5356, 5357, 5358=
, 5359, 5360, 5361, 5362, 5363, 5364, 5365, 5366, 5367, 5368, 5369, 5370, 5=
371, 5372, 5373, 5374, 5375, 5376, 5377, 5378, 5379, 5380, 5381, 5382, 5383=
, 5384, 5385, 5386, 5387, 5388, 5389, 5390, 5391, 5392, 5393, 5394, 5395, 5=
396, 5397, 5398, 5399, 5400, 5401, 5402, 5403, 5404, 5405, 5406, 5407, 5408=
, 5409, 5410, 5411, 5412, 5413, 5414, 5415, 5416, 5417, 5418, 5419, 5420, 5=
421, 5422, 5423, 5424, 5425, 5426, 5427, 5428, 5429, 5430, 5431, 5432, 5433=
, 5434, 5435, 5436, 5437, 5438, 5439, 5440, 5441, 5442, 5443, 5444, 5445, 5=
446, 5447, 5448, 5449, 5450, 5451, 5452, 5453, 5454, 5455, 5456, 5457, 5458=
, 5459, 5460, 5461, 5462, 5463, 5464, 5465, 5466, 5467, 5468, 5469, 5470, 5=
471, 5472, 5473, 5474, 5475, 5476, 5477, 5478, 5479, 5480, 5481, 5482, 5483=
, 5484, 5485, 5486, 5487, 5488, 5489, 5490, 5491, 5492, 5493, 5494, 5495, 5=
496, 5497, 5498, 5499, 5500, 5501, 5502, 5503, 5504, 5505, 5506, 5507, 5508=
, 5509, 5510, 5511, 5512, 5513, 5514, 5515, 5516, 5517, 5518, 5519, 5520, 5=
521, 5522, 5523, 5524, 5525, 5526, 5527, 5528, 5529, 5530, 5531, 5532, 5533=
, 5534, 5535, 5536, 5537, 5538, 5539, 5540, 5541, 5542, 5543, 5544, 5545, 5=
546, 5547, 5548, 5549, 5550, 5551, 5552, 5553, 5554, 5555, 5556, 5557, 5558=
, 5559, 5560, 5561, 5562, 5563, 5564, 5565 }, size =3D 120, { sample_period=
, sample_freq } =3D 1000003, sample_type =3D IP|TID|TIME|CALLCHAIN|ID|CPU, =
read_format =3D ID, disabled =3D 1, inherit =3D 1, precise_ip =3D 2, sample=
_id_all =3D 1, exclude_guest =3D 1
# event : name =3D dummy:HG, , id =3D { 5566, 5567, 5568, 5569, 5570, 5571,=
 5572, 5573, 5574, 5575, 5576, 5577, 5578, 5579, 5580, 5581, 5582, 5583, 55=
84, 5585, 5586, 5587, 5588, 5589, 5590, 5591, 5592, 5593, 5594, 5595, 5596,=
 5597, 5598, 5599, 5600, 5601, 5602, 5603, 5604, 5605, 5606, 5607, 5608, 56=
09, 5610, 5611, 5612, 5613, 5614, 5615, 5616, 5617, 5618, 5619, 5620, 5621,=
 5622, 5623, 5624, 5625, 5626, 5627, 5628, 5629, 5630, 5631, 5632, 5633, 56=
34, 5635, 5636, 5637, 5638, 5639, 5640, 5641, 5642, 5643, 5644, 5645, 5646,=
 5647, 5648, 5649, 5650, 5651, 5652, 5653, 5654, 5655, 5656, 5657, 5658, 56=
59, 5660, 5661, 5662, 5663, 5664, 5665, 5666, 5667, 5668, 5669, 5670, 5671,=
 5672, 5673, 5674, 5675, 5676, 5677, 5678, 5679, 5680, 5681, 5682, 5683, 56=
84, 5685, 5686, 5687, 5688, 5689, 5690, 5691, 5692, 5693, 5694, 5695, 5696,=
 5697, 5698, 5699, 5700, 5701, 5702, 5703, 5704, 5705, 5706, 5707, 5708, 57=
09, 5710, 5711, 5712, 5713, 5714, 5715, 5716, 5717, 5718, 5719, 5720, 5721,=
 5722, 5723, 5724, 5725, 5726, 5727, 5728, 5729, 5730, 5731, 5732, 5733, 57=
34, 5735, 5736, 5737, 5738, 5739, 5740, 5741, 5742, 5743, 5744, 5745, 5746,=
 5747, 5748, 5749, 5750, 5751, 5752, 5753, 5754, 5755, 5756, 5757, 5758, 57=
59, 5760, 5761, 5762, 5763, 5764, 5765, 5766, 5767, 5768, 5769, 5770, 5771,=
 5772, 5773, 5774, 5775, 5776, 5777, 5778, 5779, 5780, 5781, 5782, 5783, 57=
84, 5785, 5786, 5787, 5788, 5789, 5790, 5791, 5792, 5793, 5794, 5795, 5796,=
 5797, 5798, 5799, 5800, 5801, 5802, 5803, 5804, 5805, 5806, 5807, 5808, 58=
09, 5810, 5811, 5812, 5813, 5814, 5815, 5816, 5817, 5818, 5819, 5820, 5821,=
 5822, 5823, 5824, 5825, 5826, 5827, 5828, 5829, 5830, 5831, 5832, 5833, 58=
34, 5835, 5836, 5837, 5838, 5839, 5840, 5841, 5842, 5843, 5844, 5845, 5846,=
 5847, 5848, 5849, 5850, 5851, 5852, 5853 }, type =3D 1, size =3D 120, conf=
ig =3D 0x9, { sample_period, sample_freq } =3D 1000003, sample_type =3D IP|=
TID|TIME|CALLCHAIN|ID|CPU, read_format =3D ID, disabled =3D 1, inherit =3D =
1, mmap =3D 1, comm =3D 1, enable_on_exec =3D 1, task =3D 1, sample_id_all =
=3D 1, mmap2 =3D 1, comm_exec =3D 1, ksymbol =3D 1, bpf_event =3D 1
# CPU_TOPOLOGY info available, use -I to display
# NUMA_TOPOLOGY info available, use -I to display
# pmu mappings: uncore_cha_34 =3D 71, uncore_edc_uclk_5 =3D 24, uncore_cha_=
1 =3D 38, uncore_cha_24 =3D 61, software =3D 1, uncore_cha_14 =3D 51, uncor=
e_imc_5 =3D 15, uncore_edc_eclk_0 =3D 27, uncore_cha_32 =3D 69, uncore_edc_=
uclk_3 =3D 22, uncore_cha_22 =3D 59, uncore_cha_12 =3D 49, uncore_imc_uclk_=
1 =3D 17, uncore_imc_3 =3D 13, uncore_cha_8 =3D 45, uncore_cha_30 =3D 67, u=
ncore_edc_uclk_1 =3D 20, uncore_cha_20 =3D 57, uncore_cha_10 =3D 47, uncore=
_edc_eclk_7 =3D 34, uncore_imc_1 =3D 11, power =3D 9, uncore_cha_6 =3D 43, =
uncore_cha_29 =3D 66, uncore_cha_19 =3D 56, uprobe =3D 7, uncore_edc_eclk_5=
 =3D 32, uncore_cha_37 =3D 74, cpu =3D 4, uncore_cha_4 =3D 41, uncore_cha_2=
7 =3D 64, uncore_cha_17 =3D 54, cstate_core =3D 76, uncore_edc_eclk_3 =3D 3=
0, uncore_cha_35 =3D 72, breakpoint =3D 5, uncore_edc_uclk_6 =3D 25, uncore=
_cha_2 =3D 39, uncore_cha_25 =3D 62, uncore_cha_15 =3D 52, uncore_edc_eclk_=
1 =3D 28, uncore_cha_33 =3D 70, tracepoint =3D 2, uncore_edc_uclk_4 =3D 23,=
 uncore_cha_0 =3D 37, uncore_cha_23 =3D 60, uncore_cha_13 =3D 50, cstate_pk=
g =3D 77, uncore_imc_4 =3D 14, uncore_cha_9 =3D 46, uncore_cha_31 =3D 68, u=
ncore_ubox =3D 36, uncore_edc_uclk_2 =3D 21, uncore_cha_21 =3D 58, uncore_c=
ha_11 =3D 48, uncore_imc_uclk_0 =3D 16, uncore_imc_2 =3D 12, kprobe =3D 6, =
uncore_cha_7 =3D 44, uncore_edc_uclk_0 =3D 19, uncore_edc_eclk_6 =3D 33, un=
core_m2pcie =3D 18, uncore_imc_0 =3D 10, uncore_cha_5 =3D 42, uncore_pcu =
=3D 75, uncore_cha_28 =3D 65, uncore_cha_18 =3D 55, msr =3D 8, uncore_edc_e=
clk_4 =3D 31, uncore_cha_36 =3D 73, uncore_edc_uclk_7 =3D 26, uncore_irp =
=3D 35, uncore_cha_3 =3D 40, uncore_cha_26 =3D 63, uncore_cha_16 =3D 53, un=
core_edc_eclk_2 =3D 29
# CACHE info available, use -I to display
# time of first sample : 162.017687
# time of last sample : 172.174592
# sample duration :  10156.905 ms
# MEM_TOPOLOGY info available, use -I to display
# cpu pmu capabilities: branches=3D8, max_precise=3D2, pmu_name=3Dknights-l=
anding
# missing features: TRACING_DATA BRANCH_STACK GROUP_DESC AUXTRACE STAT CLOC=
KID DIR_FORMAT COMPRESSED=20
# =3D=3D=3D=3D=3D=3D=3D=3D
#
#
# Total Lost Samples: 72
#
# Samples: 1M of event 'cycles:pp'
# Event count (approx.): 1460004380000
#
# Children      Self  Shared Object             Symbol                     =
                       IPC   [IPC Coverage]
# ........  ........  ........................  ...........................=
=2E....................  ....................
#
    98.62%     0.02%  [kernel.kallsyms]         [k] entry_SYSCALL_64_after_=
hwframe                -      -           =20
97.48% entry_SYSCALL_64_after_hwframe;munmap
0.57% entry_SYSCALL_64_after_hwframe;mmap64
    98.60%     0.03%  [kernel.kallsyms]         [k] do_syscall_64          =
                       -      -           =20
97.47% do_syscall_64;entry_SYSCALL_64_after_hwframe;munmap
0.56% do_syscall_64;entry_SYSCALL_64_after_hwframe;mmap64
    97.61%     0.03%  libc-2.24.so              [.] munmap                 =
                       -      -           =20
97.60% munmap
    96.99%     0.01%  [kernel.kallsyms]         [k] __x64_sys_munmap       =
                       -      -           =20
96.98% __x64_sys_munmap;do_syscall_64;entry_SYSCALL_64_after_hwframe;munmap
    96.98%     0.01%  [kernel.kallsyms]         [k] __vm_munmap            =
                       -      -           =20
96.97% __vm_munmap;__x64_sys_munmap;do_syscall_64;entry_SYSCALL_64_after_hw=
frame;munmap
    96.96%     0.05%  [kernel.kallsyms]         [k] __do_munmap            =
                       -      -           =20
96.93% __do_munmap;__vm_munmap;__x64_sys_munmap;do_syscall_64;entry_SYSCALL=
_64_after_hwframe;munmap
    96.78%     0.03%  [kernel.kallsyms]         [k] unmap_region           =
                       -      -           =20
96.75% unmap_region;__do_munmap;__vm_munmap;__x64_sys_munmap;do_syscall_64;=
entry_SYSCALL_64_after_hwframe;munmap
    93.33%     0.07%  [kernel.kallsyms]         [k] _raw_spin_lock_irqsave =
                       -      -           =20
46.50% _raw_spin_lock_irqsave;release_pages;tlb_flush_mmu;tlb_finish_mmu;un=
map_region;__do_munmap;__vm_munmap;__x64_sys_munmap;do_syscall_64;entry_SYS=
CALL_64_after_hwframe;munmap
46.47% _raw_spin_lock_irqsave;pagevec_lru_move_fn;lru_add_drain_cpu;lru_add=
_drain;unmap_region;__do_munmap;__vm_munmap;__x64_sys_munmap;do_syscall_64;=
entry_SYSCALL_64_after_hwframe;munmap
    93.26%    93.26%  [kernel.kallsyms]         [k] native_queued_spin_lock=
_slowpath              -      -           =20
46.47% native_queued_spin_lock_slowpath;_raw_spin_lock_irqsave;release_page=
s;tlb_flush_mmu;tlb_finish_mmu;unmap_region;__do_munmap;__vm_munmap;__x64_s=
ys_munmap;do_syscall_64;entry_SYSCALL_64_after_hwframe;munmap
46.45% native_queued_spin_lock_slowpath;_raw_spin_lock_irqsave;pagevec_lru_=
move_fn;lru_add_drain_cpu;lru_add_drain;unmap_region;__do_munmap;__vm_munma=
p;__x64_sys_munmap;do_syscall_64;entry_SYSCALL_64_after_hwframe;munmap
    47.96%     0.01%  [kernel.kallsyms]         [k] tlb_finish_mmu         =
                       -      -           =20
47.92% tlb_finish_mmu;unmap_region;__do_munmap;__vm_munmap;__x64_sys_munmap=
;do_syscall_64;entry_SYSCALL_64_after_hwframe;munmap
    47.95%     0.02%  [kernel.kallsyms]         [k] pagevec_lru_move_fn    =
                       -      -           =20
47.66% pagevec_lru_move_fn;lru_add_drain_cpu;lru_add_drain;unmap_region;__d=
o_munmap;__vm_munmap;__x64_sys_munmap;do_syscall_64;entry_SYSCALL_64_after_=
hwframe;munmap
    47.95%     0.01%  [kernel.kallsyms]         [k] tlb_flush_mmu          =
                       -      -           =20
47.91% tlb_flush_mmu;tlb_finish_mmu;unmap_region;__do_munmap;__vm_munmap;__=
x64_sys_munmap;do_syscall_64;entry_SYSCALL_64_after_hwframe;munmap
    47.87%     0.08%  [kernel.kallsyms]         [k] release_pages          =
                       -      -           =20
47.80% release_pages;tlb_flush_mmu;tlb_finish_mmu;unmap_region;__do_munmap;=
__vm_munmap;__x64_sys_munmap;do_syscall_64;entry_SYSCALL_64_after_hwframe;m=
unmap
    47.76%     0.01%  [kernel.kallsyms]         [k] lru_add_drain          =
                       -      -           =20
47.69% lru_add_drain;unmap_region;__do_munmap;__vm_munmap;__x64_sys_munmap;=
do_syscall_64;entry_SYSCALL_64_after_hwframe;munmap
    47.75%     0.03%  [kernel.kallsyms]         [k] lru_add_drain_cpu      =
                       -      -           =20
47.69% lru_add_drain_cpu;lru_add_drain;unmap_region;__do_munmap;__vm_munmap=
;__x64_sys_munmap;do_syscall_64;entry_SYSCALL_64_after_hwframe;munmap
     2.04%     0.01%  [kernel.kallsyms]         [k] apic_timer_interrupt   =
                       -      -           =20
0.97% apic_timer_interrupt;_raw_spin_unlock_irqrestore;pagevec_lru_move_fn;=
lru_add_drain_cpu;lru_add_drain;unmap_region;__do_munmap;__vm_munmap;__x64_=
sys_munmap;do_syscall_64;entry_SYSCALL_64_after_hwframe;munmap
0.95% apic_timer_interrupt;_raw_spin_unlock_irqrestore;release_pages;tlb_fl=
ush_mmu;tlb_finish_mmu;unmap_region;__do_munmap;__vm_munmap;__x64_sys_munma=
p;do_syscall_64;entry_SYSCALL_64_after_hwframe;munmap
     2.01%     0.09%  [kernel.kallsyms]         [k] _raw_spin_unlock_irqres=
tore                   -      -           =20
0.97% _raw_spin_unlock_irqrestore;pagevec_lru_move_fn;lru_add_drain_cpu;lru=
_add_drain;unmap_region;__do_munmap;__vm_munmap;__x64_sys_munmap;do_syscall=
_64;entry_SYSCALL_64_after_hwframe;munmap
0.96% _raw_spin_unlock_irqrestore;release_pages;tlb_flush_mmu;tlb_finish_mm=
u;unmap_region;__do_munmap;__vm_munmap;__x64_sys_munmap;do_syscall_64;entry=
_SYSCALL_64_after_hwframe;munmap
     1.95%     0.04%  [kernel.kallsyms]         [k] smp_apic_timer_interrup=
t                      -      -           =20
0.93% smp_apic_timer_interrupt;apic_timer_interrupt;_raw_spin_unlock_irqres=
tore;pagevec_lru_move_fn;lru_add_drain_cpu;lru_add_drain;unmap_region;__do_=
munmap;__vm_munmap;__x64_sys_munmap;do_syscall_64;entry_SYSCALL_64_after_hw=
frame;munmap
0.92% smp_apic_timer_interrupt;apic_timer_interrupt;_raw_spin_unlock_irqres=
tore;release_pages;tlb_flush_mmu;tlb_finish_mmu;unmap_region;__do_munmap;__=
vm_munmap;__x64_sys_munmap;do_syscall_64;entry_SYSCALL_64_after_hwframe;mun=
map
     1.69%     0.07%  [kernel.kallsyms]         [k] hrtimer_interrupt      =
                       -      -           =20
0.80% hrtimer_interrupt;smp_apic_timer_interrupt;apic_timer_interrupt;_raw_=
spin_unlock_irqrestore;pagevec_lru_move_fn;lru_add_drain_cpu;lru_add_drain;=
unmap_region;__do_munmap;__vm_munmap;__x64_sys_munmap;do_syscall_64;entry_S=
YSCALL_64_after_hwframe;munmap
0.80% hrtimer_interrupt;smp_apic_timer_interrupt;apic_timer_interrupt;_raw_=
spin_unlock_irqrestore;release_pages;tlb_flush_mmu;tlb_finish_mmu;unmap_reg=
ion;__do_munmap;__vm_munmap;__x64_sys_munmap;do_syscall_64;entry_SYSCALL_64=
_after_hwframe;munmap
     1.45%     0.07%  [kernel.kallsyms]         [k] __hrtimer_run_queues   =
                       -      -           =20
0.69% __hrtimer_run_queues;hrtimer_interrupt;smp_apic_timer_interrupt;apic_=
timer_interrupt;_raw_spin_unlock_irqrestore;release_pages;tlb_flush_mmu;tlb=
_finish_mmu;unmap_region;__do_munmap;__vm_munmap;__x64_sys_munmap;do_syscal=
l_64;entry_SYSCALL_64_after_hwframe;munmap
0.69% __hrtimer_run_queues;hrtimer_interrupt;smp_apic_timer_interrupt;apic_=
timer_interrupt;_raw_spin_unlock_irqrestore;pagevec_lru_move_fn;lru_add_dra=
in_cpu;lru_add_drain;unmap_region;__do_munmap;__vm_munmap;__x64_sys_munmap;=
do_syscall_64;entry_SYSCALL_64_after_hwframe;munmap
     1.06%     0.01%  [kernel.kallsyms]         [k] tick_sched_timer       =
                       -      -           =20
     1.01%     0.01%  [kernel.kallsyms]         [k] tick_sched_handle      =
                       -      -           =20
     0.98%     0.01%  [kernel.kallsyms]         [k] page_fault             =
                       -      -           =20
0.94% page_fault
     0.98%     0.01%  [kernel.kallsyms]         [k] update_process_times   =
                       -      -           =20
     0.94%     0.05%  [kernel.kallsyms]         [k] do_page_fault          =
                       -      -           =20
0.90% do_page_fault;page_fault
     0.87%     0.02%  [kernel.kallsyms]         [k] unmap_vmas             =
                       -      -           =20
0.86% unmap_vmas;unmap_region;__do_munmap;__vm_munmap;__x64_sys_munmap;do_s=
yscall_64;entry_SYSCALL_64_after_hwframe;munmap
     0.83%     0.45%  [kernel.kallsyms]         [k] unmap_page_range       =
                       -      -           =20
0.80% unmap_page_range;unmap_vmas;unmap_region;__do_munmap;__vm_munmap;__x6=
4_sys_munmap;do_syscall_64;entry_SYSCALL_64_after_hwframe;munmap
     0.77%     0.03%  [kernel.kallsyms]         [k] scheduler_tick         =
                       -      -           =20
     0.76%     0.04%  [kernel.kallsyms]         [k] handle_mm_fault        =
                       -      -           =20
0.73% handle_mm_fault;do_page_fault;page_fault
     0.71%     0.05%  [kernel.kallsyms]         [k] __handle_mm_fault      =
                       -      -           =20
0.69% __handle_mm_fault;handle_mm_fault;do_page_fault;page_fault
     0.64%     0.02%  libc-2.24.so              [.] mmap64                 =
                       -      -           =20
0.64% mmap64
     0.63%     0.03%  [kernel.kallsyms]         [k] handle_pte_fault       =
                       -      -           =20
0.61% handle_pte_fault;__handle_mm_fault;handle_mm_fault;do_page_fault;page=
_fault
     0.57%     0.01%  [kernel.kallsyms]         [k] ksys_mmap_pgoff        =
                       -      -           =20
0.54% ksys_mmap_pgoff;do_syscall_64;entry_SYSCALL_64_after_hwframe;mmap64
     0.56%     0.01%  [kernel.kallsyms]         [k] vm_mmap_pgoff          =
                       -      -           =20
0.53% vm_mmap_pgoff;ksys_mmap_pgoff;do_syscall_64;entry_SYSCALL_64_after_hw=
frame;mmap64
     0.53%     0.11%  [kernel.kallsyms]         [k] task_tick_fair         =
                       -      -           =20
     0.49%     0.02%  [kernel.kallsyms]         [k] do_mmap                =
                       -      -           =20
     0.48%     0.00%  libc-2.24.so              [.] __libc_start_main      =
                       -      -           =20
     0.48%     0.00%  perf                      [.] main                   =
                       -      -           =20
     0.47%     0.00%  perf                      [.] cmd_record             =
                       -      -           =20
     0.47%     0.00%  perf                      [.] perf_mmap__push        =
                       -      -           =20
     0.46%     0.00%  [kernel.kallsyms]         [k] exit_to_usermode_loop  =
                       -      -           =20
     0.46%     0.00%  [kernel.kallsyms]         [k] task_work_run          =
                       -      -           =20
     0.46%     0.01%  libpthread-2.24.so        [.] __GI___libc_write      =
                       -      -           =20
     0.46%     0.00%  [kernel.kallsyms]         [k] task_numa_work         =
                       -      -           =20
     0.46%     0.00%  [kernel.kallsyms]         [k] change_protection      =
                       -      -           =20
     0.46%     0.00%  [kernel.kallsyms]         [k] change_prot_numa       =
                       -      -           =20
     0.46%     0.40%  [kernel.kallsyms]         [k] change_p4d_range       =
                       -      -           =20
     0.43%     0.00%  [kernel.kallsyms]         [k] ksys_write             =
                       -      -           =20
     0.42%     0.00%  [kernel.kallsyms]         [k] vfs_write              =
                       -      -           =20
     0.40%     0.00%  [kernel.kallsyms]         [k] new_sync_write         =
                       -      -           =20
     0.39%     0.00%  [kernel.kallsyms]         [k] generic_file_write_iter=
                       -      -           =20
     0.38%     0.00%  [kernel.kallsyms]         [k] __generic_file_write_it=
er                     -      -           =20
     0.37%     0.00%  [kernel.kallsyms]         [k] generic_perform_write  =
                       -      -           =20
     0.36%     0.03%  [kernel.kallsyms]         [k] mmap_region            =
                       -      -           =20
     0.30%     0.29%  [kernel.kallsyms]         [k] ___might_sleep         =
                       -      -           =20
     0.29%     0.00%  [kernel.kallsyms]         [k] shmem_write_begin      =
                       -      -           =20
     0.29%     0.01%  [kernel.kallsyms]         [k] shmem_getpage_gfp      =
                       -      -           =20
     0.27%     0.03%  [kernel.kallsyms]         [k] __alloc_pages_nodemask =
                       -      -           =20
     0.22%     0.06%  [kernel.kallsyms]         [k] get_page_from_freelist =
                       -      -           =20
     0.21%     0.01%  [kernel.kallsyms]         [k] __pte_alloc            =
                       -      -           =20
     0.21%     0.01%  [kernel.kallsyms]         [k] __lru_cache_add        =
                       -      -           =20
     0.19%     0.01%  [kernel.kallsyms]         [k] pte_alloc_one          =
                       -      -           =20
     0.15%     0.09%  [kernel.kallsyms]         [k] update_curr            =
                       -      -           =20
     0.15%     0.07%  [kernel.kallsyms]         [k] _cond_resched          =
                       -      -           =20
     0.15%     0.01%  [kernel.kallsyms]         [k] irq_exit               =
                       -      -           =20
     0.15%     0.10%  [kernel.kallsyms]         [k] __remove_hrtimer       =
                       -      -           =20
     0.14%     0.04%  [kernel.kallsyms]         [k] perf_event_mmap        =
                       -      -           =20
     0.14%     0.01%  [kernel.kallsyms]         [k] alloc_pages_vma        =
                       -      -           =20
     0.13%     0.02%  [kernel.kallsyms]         [k] prep_new_page          =
                       -      -           =20
     0.12%     0.02%  [kernel.kallsyms]         [k] __perf_sw_event        =
                       -      -           =20
     0.12%     0.04%  [kernel.kallsyms]         [k] __pagevec_lru_add_fn   =
                       -      -           =20
     0.12%     0.01%  [kernel.kallsyms]         [k] __anon_vma_prepare     =
                       -      -           =20
     0.12%     0.11%  [kernel.kallsyms]         [k] clear_page_erms        =
                       -      -           =20
     0.12%     0.00%  [kernel.kallsyms]         [k] free_pgtables          =
                       -      -           =20
     0.12%     0.01%  [kernel.kallsyms]         [k] free_pgd_range         =
                       -      -           =20
     0.12%     0.04%  [kernel.kallsyms]         [k] __softirqentry_text_sta=
rt                     -      -           =20
     0.11%     0.03%  [kernel.kallsyms]         [k] unlink_anon_vmas       =
                       -      -           =20
     0.11%     0.08%  [kernel.kallsyms]         [k] free_p4d_range         =
                       -      -           =20
     0.11%     0.04%  [kernel.kallsyms]         [k] __mod_lruvec_state     =
                       -      -           =20
     0.10%     0.08%  [kernel.kallsyms]         [k] ___perf_sw_event       =
                       -      -           =20
     0.10%     0.03%  [kernel.kallsyms]         [k] perf_mux_hrtimer_handle=
r                      -      -           =20
     0.10%     0.01%  [kernel.kallsyms]         [k] get_unmapped_area      =
                       -      -           =20
     0.10%     0.08%  [kernel.kallsyms]         [k] __update_load_avg_se   =
                       -      -           =20
     0.09%     0.03%  [kernel.kallsyms]         [k] free_unref_page_list   =
                       -      -           =20
     0.09%     0.08%  [kernel.kallsyms]         [k] __update_load_avg_cfs_r=
q                      -      -           =20
     0.09%     0.02%  [kernel.kallsyms]         [k] arch_get_unmapped_area_=
topdown                -      -           =20
     0.08%     0.01%  [kernel.kallsyms]         [k] mem_cgroup_uncharge_lis=
t                      -      -           =20
     0.08%     0.04%  [kernel.kallsyms]         [k] update_rq_clock.part.70=
                       -      -           =20
     0.08%     0.08%  [kernel.kallsyms]         [k] __mod_memcg_state      =
                       -      -           =20
     0.08%     0.05%  [kernel.kallsyms]         [k] kmem_cache_alloc       =
                       -      -           =20
     0.08%     0.05%  [kernel.kallsyms]         [k] perf_iterate_sb        =
                       -      -           =20
     0.07%     0.06%  [kernel.kallsyms]         [k] rcu_all_qs             =
                       -      -           =20
     0.07%     0.02%  [kernel.kallsyms]         [k] flush_tlb_mm_range     =
                       -      -           =20
     0.07%     0.06%  [kernel.kallsyms]         [k] _raw_spin_lock         =
                       -      -           =20
     0.06%     0.06%  [kernel.kallsyms]         [k] vm_unmapped_area       =
                       -      -           =20
     0.06%     0.01%  [kernel.kallsyms]         [k] uncharge_batch         =
                       -      -           =20
     0.06%     0.06%  [kernel.kallsyms]         [k] perf_event_task_tick   =
                       -      -           =20
     0.06%     0.00%  [kernel.kallsyms]         [k] mmput                  =
                       -      -           =20
     0.06%     0.00%  [kernel.kallsyms]         [k] exit_mmap              =
                       -      -           =20
     0.06%     0.04%  libc-2.24.so              [.] malloc                 =
                       -      -           =20
     0.06%     0.06%  [kernel.kallsyms]         [k] syscall_return_via_sysr=
et                     -      -           =20
     0.06%     0.04%  [kernel.kallsyms]         [k] run_timer_softirq      =
                       -      -           =20
     0.06%     0.03%  [kernel.kallsyms]         [k] percpu_counter_add_batc=
h                      -      -           =20
     0.05%     0.04%  [kernel.kallsyms]         [k] rcu_sched_clock_irq    =
                       -      -           =20
     0.05%     0.05%  [kernel.kallsyms]         [k] vm_normal_page         =
                       -      -           =20
     0.05%     0.01%  [kernel.kallsyms]         [k] clockevents_program_eve=
nt                     -      -           =20
     0.05%     0.04%  [kernel.kallsyms]         [k] entry_SYSCALL_64       =
                       -      -           =20
     0.05%     0.01%  [kernel.kallsyms]         [k] remove_vma             =
                       -      -           =20
     0.05%     0.05%  [kernel.kallsyms]         [k] kmem_cache_free        =
                       -      -           =20
     0.05%     0.05%  [kernel.kallsyms]         [k] interrupt_entry        =
                       -      -           =20
     0.05%     0.03%  [kernel.kallsyms]         [k] irq_enter              =
                       -      -           =20
     0.05%     0.01%  [kernel.kallsyms]         [k] vma_link               =
                       -      -           =20
     0.04%     0.01%  [kernel.kallsyms]         [k] timerqueue_del         =
                       -      -           =20
     0.04%     0.02%  [kernel.kallsyms]         [k] find_vma               =
                       -      -           =20
     0.04%     0.01%  [kernel.kallsyms]         [k] enqueue_hrtimer        =
                       -      -           =20
     0.04%     0.04%  [kernel.kallsyms]         [k] __might_sleep          =
                       -      -           =20
     0.04%     0.01%  [kernel.kallsyms]         [k] iov_iter_fault_in_reada=
ble                    -      -           =20
     0.04%     0.00%  [kernel.kallsyms]         [k] mark_page_accessed     =
                       -      -           =20
     0.04%     0.03%  [kernel.kallsyms]         [k] free_unref_page_commit =
                       -      -           =20
     0.04%     0.03%  [kernel.kallsyms]         [k] ktime_get              =
                       -      -           =20
     0.04%     0.03%  [kernel.kallsyms]         [k] error_entry            =
                       -      -           =20
     0.04%     0.00%  [kernel.kallsyms]         [k] mem_cgroup_try_charge_d=
elay                   -      -           =20
     0.04%     0.04%  [kernel.kallsyms]         [k] __hrtimer_next_event_ba=
se                     -      -           =20
     0.04%     0.04%  [kernel.kallsyms]         [k] __mod_node_page_state  =
                       -      -           =20
     0.04%     0.01%  [kernel.kallsyms]         [k] __put_anon_vma         =
                       -      -           =20
     0.04%     0.00%  [kernel.kallsyms]         [k] activate_page          =
                       -      -           =20
     0.04%     0.00%  [kernel.kallsyms]         [k] __x64_sys_execve       =
                       -      -           =20
     0.04%     0.00%  [kernel.kallsyms]         [k] __do_execve_file.isra.3=
3                      -      -           =20
     0.04%     0.00%  libc-2.24.so              [.] execve                 =
                       -      -           =20
     0.04%     0.00%  [kernel.kallsyms]         [k] sched_clock_cpu        =
                       -      -           =20
     0.04%     0.01%  [kernel.kallsyms]         [k] vm_area_alloc          =
                       -      -           =20
     0.04%     0.00%  [kernel.kallsyms]         [k] search_binary_handler  =
                       -      -           =20
     0.04%     0.00%  [kernel.kallsyms]         [k] load_elf_binary        =
                       -      -           =20
     0.03%     0.00%  [kernel.kallsyms]         [k] sched_clock            =
                       -      -           =20
     0.03%     0.03%  [kernel.kallsyms]         [k] ktime_get_update_offset=
s_now                  -      -           =20
     0.03%     0.03%  [kernel.kallsyms]         [k] native_sched_clock     =
                       -      -           =20
     0.03%     0.03%  [kernel.kallsyms]         [k] native_write_msr       =
                       -      -           =20
     0.03%     0.01%  [kernel.kallsyms]         [k] __vm_enough_memory     =
                       -      -           =20
     0.03%     0.02%  [kernel.kallsyms]         [k] timerqueue_add         =
                       -      -           =20
     0.03%     0.01%  [kernel.kallsyms]         [k] down_write_killable    =
                       -      -           =20
     0.03%     0.03%  [kernel.kallsyms]         [k] native_irq_return_iret =
                       -      -           =20
     0.03%     0.00%  [kernel.kallsyms]         [k] __x64_sys_exit_group   =
                       -      -           =20
     0.03%     0.00%  [kernel.kallsyms]         [k] do_group_exit          =
                       -      -           =20
     0.03%     0.00%  [kernel.kallsyms]         [k] do_exit                =
                       -      -           =20
     0.03%     0.01%  [kernel.kallsyms]         [k] arch_scale_freq_tick   =
                       -      -           =20
     0.03%     0.01%  [kernel.kallsyms]         [k] mem_cgroup_commit_charg=
e                      -      -           =20
     0.03%     0.01%  [kernel.kallsyms]         [k] free_pages_and_swap_cac=
he                     -      -           =20
     0.03%     0.03%  [kernel.kallsyms]         [k] __vma_link_rb          =
                       -      -           =20
     0.03%     0.02%  [kernel.kallsyms]         [k] reweight_entity        =
                       -      -           =20
     0.03%     0.03%  [kernel.kallsyms]         [k] __list_del_entry_valid =
                       -      -           =20
     0.03%     0.01%  [kernel.kallsyms]         [k] swapgs_restore_regs_and=
_return_to_usermode    -      -           =20
     0.03%     0.02%  [kernel.kallsyms]         [k] account_system_index_ti=
me                     -      -           =20
     0.03%     0.03%  [kernel.kallsyms]         [k] cpuacct_charge         =
                       -      -           =20
     0.03%     0.01%  [kernel.kallsyms]         [k] lapic_next_deadline    =
                       -      -           =20
     0.03%     0.03%  [kernel.kallsyms]         [k] hrtimer_active         =
                       -      -           =20
     0.03%     0.02%  [kernel.kallsyms]         [k] security_mmap_file     =
                       -      -           =20
     0.03%     0.03%  [kernel.kallsyms]         [k] __calc_delta           =
                       -      -           =20
     0.03%     0.03%  [kernel.kallsyms]         [k] __accumulate_pelt_segme=
nts                    -      -           =20
     0.03%     0.00%  [kernel.kallsyms]         [k] flush_old_exec         =
                       -      -           =20
     0.03%     0.01%  [kernel.kallsyms]         [k] alloc_pages_current    =
                       -      -           =20
     0.03%     0.01%  [kernel.kallsyms]         [k] down_write             =
                       -      -           =20
     0.03%     0.03%  [kernel.kallsyms]         [k] mem_cgroup_page_lruvec =
                       -      -           =20
     0.03%     0.02%  [kernel.kallsyms]         [k] _raw_spin_lock_irq     =
                       -      -           =20
     0.03%     0.01%  [kernel.kallsyms]         [k] cpumask_any_but        =
                       -      -           =20
     0.03%     0.03%  [kernel.kallsyms]         [k] __acct_update_integrals=
                       -      -           =20
     0.02%     0.01%  [kernel.kallsyms]         [k] flush_tlb_func_common.c=
onstprop.9             -      -           =20
     0.02%     0.01%  [kernel.kallsyms]         [k] security_vm_enough_memo=
ry_mm                  -      -           =20
     0.02%     0.00%  [kernel.kallsyms]         [k] ret_from_fork          =
                       -      -           =20
     0.02%     0.02%  [kernel.kallsyms]         [k] __list_add_valid       =
                       -      -           =20
     0.02%     0.00%  [kernel.kallsyms]         [k] kthread                =
                       -      -           =20
     0.02%     0.02%  [kernel.kallsyms]         [k] read_tsc               =
                       -      -           =20
     0.02%     0.02%  [kernel.kallsyms]         [k] __vma_rb_erase         =
                       -      -           =20
     0.02%     0.02%  [kernel.kallsyms]         [k] update_cfs_group       =
                       -      -           =20
     0.02%     0.02%  [kernel.kallsyms]         [k] run_local_timers       =
                       -      -           =20
     0.02%     0.02%  [kernel.kallsyms]         [k] rcu_irq_enter          =
                       -      -           =20
     0.02%     0.02%  [kernel.kallsyms]         [k] fpregs_assert_state_con=
sistent                -      -           =20
     0.02%     0.02%  [kernel.kallsyms]         [k] __mod_zone_page_state  =
                       -      -           =20
     0.02%     0.02%  [kernel.kallsyms]         [k] perf_event_mmap_output =
                       -      -           =20
     0.02%     0.01%  [kernel.kallsyms]         [k] trigger_load_balance   =
                       -      -           =20
     0.02%     0.02%  [kernel.kallsyms]         [k] native_apic_msr_eoi_wri=
te                     -      -           =20
     0.02%     0.02%  [kernel.kallsyms]         [k] irq_work_tick          =
                       -      -           =20
     0.02%     0.02%  [kernel.kallsyms]         [k] __x86_indirect_thunk_ra=
x                      -      -           =20
     0.02%     0.02%  [kernel.kallsyms]         [k] native_read_msr        =
                       -      -           =20
     0.02%     0.00%  [kernel.kallsyms]         [k] iov_iter_copy_from_user=
_atomic                -      -           =20
     0.02%     0.01%  [kernel.kallsyms]         [k] mem_cgroup_try_charge  =
                       -      -           =20
     0.02%     0.02%  [kernel.kallsyms]         [k] rb_next                =
                       -      -           =20
     0.02%     0.01%  [kernel.kallsyms]         [k] page_remove_rmap       =
                       -      -           =20
     0.02%     0.02%  [kernel.kallsyms]         [k] hrtimer_forward        =
                       -      -           =20
     0.02%     0.01%  libc-2.24.so              [.] free                   =
                       -      -           =20
     0.02%     0.02%  [kernel.kallsyms]         [k] tick_program_event     =
                       -      -           =20
     0.02%     0.02%  [kernel.kallsyms]         [k] rb_erase               =
                       -      -           =20
     0.02%     0.01%  [kernel.kallsyms]         [k] __hrtimer_get_next_even=
t                      -      -           =20
     0.02%     0.02%  [kernel.kallsyms]         [k] calc_global_load_tick  =
                       -      -           =20
     0.02%     0.00%  [kernel.kallsyms]         [k] ___pte_free_tlb        =
                       -      -           =20
     0.02%     0.02%  [kernel.kallsyms]         [k] memcpy_erms            =
                       -      -           =20
     0.02%     0.01%  [kernel.kallsyms]         [k] mem_cgroup_throttle_swa=
prate                  -      -           =20
     0.02%     0.02%  [kernel.kallsyms]         [k] vmacache_find          =
                       -      -           =20
     0.02%     0.01%  [kernel.kallsyms]         [k] page_add_new_anon_rmap =
                       -      -           =20
     0.02%     0.01%  [kernel.kallsyms]         [k] anon_vma_interval_tree_=
remove                 -      -           =20
     0.02%     0.00%  [kernel.kallsyms]         [k] find_lock_entry        =
                       -      -           =20
     0.02%     0.00%  [kernel.kallsyms]         [k] worker_thread          =
                       -      -           =20
     0.02%     0.02%  [kernel.kallsyms]         [k] run_posix_cpu_timers   =
                       -      -           =20
     0.02%     0.02%  [kernel.kallsyms]         [k] native_flush_tlb       =
                       -      -           =20
     0.02%     0.01%  [kernel.kallsyms]         [k] get_task_policy.part.31=
                       -      -           =20
     0.02%     0.02%  [kernel.kallsyms]         [k] mem_cgroup_update_lru_s=
ize                    -      -           =20
     0.02%     0.01%  [kernel.kallsyms]         [k] _find_next_bit.constpro=
p.1                    -      -           =20
     0.02%     0.01%  [kernel.kallsyms]         [k] cap_vm_enough_memory   =
                       -      -           =20
     0.02%     0.01%  [kernel.kallsyms]         [k] ret_from_intr          =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] sync_regs              =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] mem_cgroup_charge_stati=
stics                  -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] prepare_exit_to_usermod=
e                      -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] copyin                 =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] rcu_segcblist_ready_cbs=
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] __count_memcg_events   =
                       -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] shmem_alloc_and_acct_pa=
ge                     -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] __intel_pmu_enable_all.=
constprop.31           -      -           =20
     0.01%     0.01%  malloc1_processes         [.] malloc@plt             =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] account_process_tick   =
                       -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] process_one_work       =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] copy_user_enhanced_fast=
_string                -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] may_expand_vm          =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] shmem_write_end        =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] strlcpy                =
                       -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] vma_set_page_prot      =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] up_write               =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] ksoftirqd_running      =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] perf_exclude_event     =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] irq_work_run_list      =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] tlb_gather_mmu         =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] sync_mm_rss            =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] up_read                =
                       -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] find_mergeable_anon_vma=
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] free_unref_page_prepare=
=2Epart.72               -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] raise_softirq          =
                       -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] vfs_read               =
                       -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] find_get_entry         =
                       -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] drm_fb_helper_dirty_wor=
k                      -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] ksys_read              =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] userfaultfd_unmap_compl=
ete                    -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] __sched_text_start     =
                       -      -           =20
     0.01%     0.00%  libc-2.24.so              [.] read                   =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] cap_capable            =
                       -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] shmem_alloc_page       =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] x86_pmu_disable        =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] update_min_vruntime    =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] rb_insert_color        =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] perf_swevent_event     =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] vma_merge              =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] uncharge_page          =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] rcu_irq_exit           =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] cpuacct_account_field  =
                       -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] __fdget_pos            =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] __transparent_hugepage_=
enabled                -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] idle_cpu               =
                       -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] security_file_permissio=
n                      -      -           =20
     0.01%     0.00%  dash                      [.] forkshell              =
                       -      -           =20
     0.01%     0.01%  malloc1_processes         [.] free@plt               =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] __inc_numa_state       =
                       -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] intel_pmu_disable_all  =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] __rb_insert_augmented  =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] memcg_check_events     =
                       -      -           =20
     0.01%     0.00%  libc-2.24.so              [.] __libc_fork            =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] anon_vma_chain_link    =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] pmd_none_or_trans_huge_=
or_clear_bad           -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] inc_zone_page_state    =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] tick_sched_do_timer    =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] do_huge_pmd_anonymous_p=
age                    -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] rebalance_domains      =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] dec_zone_page_state    =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] unmap_single_vma       =
                       -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] load_balance           =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] retint_kernel          =
                       -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] __do_sys_clone         =
                       -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] _do_fork               =
                       -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] seq_read               =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] anon_vma_compatible    =
                       -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] rcu_gp_kthread         =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] blocking_notifier_call_=
chain                  -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] apparmor_mmap_file     =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] anon_vma_interval_tree_=
insert                 -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] userfaultfd_unmap_prep =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] __dec_node_state       =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] account_entity_enqueue =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] profile_tick           =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] __tlb_remove_page_size =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] account_entity_dequeue =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] page_mapping           =
                       -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] force_qs_rnp           =
                       -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] security_mmap_addr     =
                       -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] shmem_add_to_page_cache=
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] free_pcp_prepare       =
                       -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] elf_map                =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] try_charge             =
                       -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] xas_load               =
                       -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] file_update_time       =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] rcu_implicit_dynticks_q=
s                      -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] get_mem_cgroup_from_mm =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] vm_area_free           =
                       -      -           =20
     0.01%     0.01%  [kernel.kallsyms]         [k] kfree                  =
                       -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] tlb_remove_page        =
                       -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] alloc_set_pte          =
                       -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] policy_nodemask        =
                       -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] nohz_balance_exit_idle =
                       -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] preempt_schedule_common=
                       -      -           =20
     0.01%     0.00%  [kernel.kallsyms]         [k] __sb_start_write       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] down_read_trylock      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] downgrade_write        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] pick_next_task_fair    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] vm_pgprot_modify       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] pfn_pte                =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] try_to_wake_up         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] update_rq_clock        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] schedule               =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] get_mmap_base          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] lru_cache_add_active_or=
_unevictable           -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __fget_light           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __intel_pmu_disable_all=
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] finish_fault           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __x64_sys_mmap         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] error_exit             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] copy_process           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] vma_wants_writenotify  =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] strlen                 =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __x86_indirect_thunk_r1=
4                      -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] common_file_perm       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] select_task_rq_fair    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] ima_file_mmap          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] unlink_file_vma        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] mutex_lock             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __page_set_anon_rmap   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] p4d_offset             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __do_fault             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] should_failslab        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] find_busiest_group     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] do_sys_open            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] do_sys_openat2         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] do_filp_open           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] path_openat            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] kthread_blkcg          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] enqueue_task_fair      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] irq_work_interrupt     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] smp_irq_work_interrupt =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] irq_work_run           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] vmacache_update        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] update_sd_lb_stats.cons=
tprop.120              -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] ttwu_do_activate       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] activate_task          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __dec_node_page_state  =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] printk                 =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] vprintk_emit           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] find_idlest_group.isra.=
95                     -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] profile_munmap         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] native_set_pmd         =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] setlocale              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] cap_mmap_addr          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] account_system_time    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] pmd_pfn                =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] policy_node            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] call_timer_fn          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] p4d_page_vaddr         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] rcu_core               =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] hrtimer_run_queues     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __fget_files           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] mem_cgroup_from_task   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] perf_mmap_fault        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __get_vma_policy       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] current_time           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] dup_mm                 =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] run_rebalance_domains  =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acct_account_cputime   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] cap_mmap_file          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] update_blocked_averages=
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] fsnotify               =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] sched_clock_tick       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] filemap_map_pages      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] enqueue_entity         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __vma_link_list        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] get_vma_policy.part.36 =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] do_wp_page             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __x86_indirect_thunk_r1=
3                      -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] iov_iter_advance       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] sysfs_kf_seq_show      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] dev_attr_show          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] tlb_table_flush        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __x86_indirect_thunk_r1=
2                      -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] do_signal              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] wp_page_copy           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] sum_zone_numa_state    =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] write                  =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __queue_work           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] console_unlock         =
                       -      -           =20
     0.00%     0.00%  perf                      [.] perf_mmap__read_init   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] should_fail_alloc_page =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] task_tick_rt           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] new_sync_read          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] show_stat              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] serial8250_console_writ=
e                      -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] flush_tlb_batched_pendi=
ng                     -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] pmd_page_vaddr         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] uart_console_write     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] find_next_bit          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] memcpy                 =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] update_load_avg        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] wake_up_new_task       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] wait_for_xmitr         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __vma_link_file        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] serial8250_console_putc=
har                    -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] set_page_dirty         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] link_path_walk.part.30 =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] aa_file_perm           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __raw_spin_unlock      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] fsnotify_parent        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] sched_exec             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] native_set_pte_at      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] walk_component         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] arch_vma_name          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] page_add_file_rmap     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] secondary_startup_64   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] start_secondary        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] cpu_startup_entry      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] do_idle                =
                       -      -           =20
     0.00%     0.00%  libpthread-2.24.so        [.] __pthread_disable_async=
cancel                 -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] pipe_read              =
                       -      -           =20
     0.00%     0.00%  perf                      [.] perf_mmap__consume     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] perf_mmap_to_page      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __account_scheduler_lat=
ency                   -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] net_rx_action          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] newidle_balance        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] io_serial_in           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] xas_start              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] update_rt_rq_load_avg  =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __x86_indirect_thunk_r1=
5                      -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] igb_poll               =
                       -      -           =20
     0.00%     0.00%  perf                      [.] cmd_stat               =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] xas_find_conflict      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] cpuidle_enter_state    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] pipe_write             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_os_execute_deferre=
d                      -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ev_asynch_execute_=
gpe_method             -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ns_evaluate       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ps_execute_method =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] cpuidle_enter          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] xas_store              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] get_signal             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] stack_trace_save_tsk   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] do_IRQ                 =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ps_parse_aml      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] node_read_numastat     =
                       -      -           =20
     0.00%     0.00%  perf                      [.] write@plt              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] mutex_unlock           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] balance_dirty_pages_rat=
elimited               -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] node_read_vmstat       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ps_parse_loop     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] update_curr_rt         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] do_mprotect_pkey       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] kill_pid_info          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] copy_page_range        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] vmstat_update          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __x64_sys_mprotect     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __sb_end_write         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] ktime_get_coarse_real_t=
s64                    -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] refresh_cpu_vm_stats   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] arch_stack_walk        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] apparmor_file_permissio=
n                      -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] generic_write_check_lim=
its.isra.52            -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] file_remove_privs      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] PageHuge               =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] copy_p4d_range         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] do_faccessat           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] napi_complete_done     =
                       -      -           =20
     0.00%     0.00%  libpthread-2.24.so        [.] __GI___libc_read       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __wake_up_common_lock  =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __switch_to            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] timekeeping_advance    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] xas_create_range       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] mprotect_fixup         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] cpumask_next_and       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] gro_normal_list.part.13=
3                      -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] netif_receive_skb_list_=
internal               -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] kill                   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __set_page_dirty_no_wri=
teback                 -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] set_next_entity        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] step_into              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __wake_up_common       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] filename_lookup        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __netif_receive_skb_lis=
t_core                 -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] reschedule_interrupt   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] scheduler_ipi          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] sched_ttwu_pending     =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] __fxstat64             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] rw_verify_area         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] vma_migratable         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __x86_indirect_thunk_r1=
0                      -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] timestamp_truncate     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] note_gp_changes        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] it_real_fn             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __send_signal          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] autoremove_wake_functio=
n                      -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] ip_list_rcv            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] shmem_pseudo_vma_init  =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] cpumask_next           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] ip_sublist_rcv         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] path_lookupat          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] touch_atime            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] native_iret            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] generic_update_time    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] unwind_next_frame      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __setup_rt_frame       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] vsnprintf              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] alloc_empty_file       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] copy_user_highpage.isra=
=2E85                    -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] dequeue_task_fair      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] do_send_sig_info       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] smpboot_thread_fn      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] copy_page              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] xas_create             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __fput                 =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] put_prev_entity        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __do_sys_newfstat      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] seq_vprintf            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __x64_sys_kill         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] proc_reg_read          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] seq_printf             =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] wait4                  =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] _IO_file_xsputn        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] delay_tsc              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] fput_many              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] rcu_do_batch           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ds_exec_end_op    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] do_open_execat         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] getname_flags          =
                       -      -           =20
     0.00%     0.00%  perf                      [.] perf_evsel__read       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __f_unlock_pos         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] mpol_shared_policy_look=
up                     -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] switch_mm_irqs_off     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __alloc_file           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __vma_adjust           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] dequeue_entity         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] seq_put_decimal_ull_wid=
th                     -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] generic_file_mmap      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] lookup_fast            =
                       -      -           =20
     0.00%     0.00%  gawk                      [.] more_blocks            =
                       -      -           =20
     0.00%     0.00%  perf                      [.] evsel__read_counter    =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] alarm                  =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __mnt_want_write_file  =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] lock_page_memcg        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] update_irq_load_avg    =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] _IO_fwrite             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] num_to_str             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] unlock_page            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] fpu__clear             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] filp_close             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __x64_sys_alarm        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] do_setitimer           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] do_dentry_open         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] generic_file_read_iter =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] timekeeping_update     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __split_vma            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __x64_sys_close        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __x64_sys_rt_sigreturn =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] restore_sigcontext     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] alarm_setitimer        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] dput                   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] kill_something_info    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] schedule_timeout       =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] __isoc99_vsscanf       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __x64_sys_write        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] iov_iter_init          =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] __mbrtowc              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] copy_fpstate_to_sigfram=
e                      -      -           =20
     0.00%     0.00%  dash                      [.] dowait                 =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __might_fault          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] anon_vma_fork          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __clear_user           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ds_evaluate_name_p=
ath                    -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ns_lookup         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] ip_rcv_finish_core.isra=
=2E19                    -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __do_sys_wait4         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __lookup_slow          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] do_task_dead           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] kernel_wait4           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] do_wait                =
                       -      -           =20
     0.00%     0.00%  libpthread-2.24.so        [.] start_thread           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __d_lookup_rcu         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __mark_inode_dirty     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __msecs_to_jiffies     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] switch_fpu_return      =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] _dl_addr               =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __mem_cgroup_threshold =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] account_user_time      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] get_cpu_idle_time_us   =
                       -      -           =20
     0.00%     0.00%  libpthread-2.24.so        [.] __pthread_enable_asyncc=
ancel                  -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] lock_page              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] vma_policy_mof         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __dentry_kill          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] atime_needs_update     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] handle_edge_irq        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] ip_route_input_slow    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] kmem_cache_alloc_trace =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] rcu_accelerate_cbs     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] vm_area_dup            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] copy_strings.isra.27   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] d_path                 =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] ip_error               =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] user_path_at_empty     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] vfs_statx_fd           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] strncpy_from_user      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ps_get_next_namepa=
th                     -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ns_search_and_ente=
r                      -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] diskstats_show         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] get_idle_time.isra.2   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] igb_clean_rx_irq       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] ip_sublist_rcv_finish  =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] ip_route_input_noref   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] ip_route_input_rcu     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] kernel_read            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] ttwu_do_wakeup         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] check_preempt_curr     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] check_preempt_wakeup   =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] _IO_file_open          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __vfs_write            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] _raw_spin_trylock      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] prepare_signal         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] update_vsyscall        =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] _IO_vfscanf            =
                       -      -           =20
     0.00%     0.00%  perf                      [.] perf_data_file__write  =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] call_rcu               =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] rcu_note_context_switch=
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] alloc_vmap_area        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] copy_user_generic_unrol=
led                    -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] finish_task_switch     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] prepend_path           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] show_map_vma           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __alloc_fd             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] perf_read              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] dequeue_signal         =
                       -      -           =20
     0.00%     0.00%  dash                      [.] evalcommand            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __do_sys_newstat       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __get_free_pages       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __vmalloc_node_range   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __get_vm_area_node     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] _copy_from_user        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] cache_show             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] handle_irq_event       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] handle_irq_event_percpu=
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] prepare_binprm         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] show_map               =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] slab_show              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] vfs_statx              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] wait_consider_task     =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] _IO_file_close         =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] close                  =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __switch_to_asm        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ns_search_one_scop=
e                      -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] find_next_and_bit      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] invoke_rcu_core        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] io_serial_in           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] locks_remove_posix     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] memset_erms            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] part_stat_read_all.isra=
=2E22                    -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] rcu_segcblist_pend_cbs =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] shmem_recalc_inode     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] vma_interval_tree_inser=
t                      -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] vma_interval_tree_remov=
e                      -      -           =20
     0.00%     0.00%  gawk                      [.] r_interpret            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] inode_permission       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] kcpustat_cpu_fetch     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] sched_slice.isra.63    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __check_object_size    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __unwind_start         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] _copy_to_user          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] anon_vma_clone         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] fput                   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] get_cpu_iowait_time_us =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] group_balance_cpu      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] perf_poll              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] pick_next_entity       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] signal_wake_up_state   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] cp_new_stat            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] d_alloc_parallel       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] group_send_sig_info    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] mm_init                =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] path_init              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] prepare_creds          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] put_cred_rcu           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] sched_move_task        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] tick_do_update_jiffies6=
4.part.17              -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __handle_irq_event_perc=
pu                     -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __x64_sys_futex        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __x64_sys_poll         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __x64_sys_readlink     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] do_futex               =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] do_readlinkat          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] do_sys_poll            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] fifo_open              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] get_iowait_time.isra.3 =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] kfree_skb              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] open_exec              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] pagecache_get_page     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] pipe_wait              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] release_task           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] schedule_tail          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] setup_arg_pages        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] wait_for_partner       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] wake_up_q              =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] __printf_chk           =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] __xstat64              =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] poll                   =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] sched_setaffinity      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __bitmap_and           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __enqueue_entity       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __orc_find             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __unlock_page_memcg    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] cpus_share_cache       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] format_decode          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] hrtimer_start_range_ns =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] intel_idle             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] map_id_up              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] native_irq_return_ldt  =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] native_load_tls        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] pmd_devmap_trans_unstab=
le                     -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] pmd_trans_huge         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] resched_curr           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] strnlen_user           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] update_dl_rq_load_avg  =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] _IO_sputbackc          =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] strlen                 =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] vfprintf               =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __d_alloc              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __fpu__restore_sig     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] expand_files           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] lock_timer_base        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] nr_iowait              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] rcu_core_si            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] rcu_disable_urgency_upo=
n_qs                   -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] recalc_sigpending      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] security_file_open     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] sys_imageblit          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] terminate_walk         =
                       -      -           =20
     0.00%     0.00%  dash                      [.] memtodest              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __dequeue_signal       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ex_resolve_to_valu=
e                      -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] count.isra.24.constprop=
=2E41                    -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] futex_wait_queue_me    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] security_file_alloc    =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] __strcasecmp           =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] memmem                 =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] time                   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __hrtimer_get_remaining=
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __put_task_struct      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __put_user_4           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ds_create_operand =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] con_scroll             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] bit_putcs              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] cpu_stop_queue_work    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] cpu_stopper_thread     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] d_alloc                =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] devkmsg_read           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] do_mkdirat             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] do_notify_parent       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] fbcon_scroll           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] fbcon_redraw.isra.18   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] fbcon_putcs            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] drm_fb_helper_sys_image=
blit                   -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] filename_create        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] from_kuid_munged       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] futex_wait             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] itimer_get_remtime     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] lf                     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] load_elf_phdrs         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] map_vdso               =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] migration_cpu_stop     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] move_queued_task       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] pgd_alloc              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] pipe_release           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] queue_work_on          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] shift_arg_pages        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] skb_release_all        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] skb_release_head_state =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] vfs_getattr            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] security_inode_getattr =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] vmstat_start           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] vt_console_print       =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] epoll_wait             =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] open64                 =
                       -      -           =20
     0.00%     0.00%  libpthread-2.24.so        [.] pthread_cond_wait@@GLIB=
C_2.3.2                -      -           =20
     0.00%     0.00%  perf                      [.] evlist__disable        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __d_lookup             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __legitimize_mnt       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __local_bh_enable_ip   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __lookup_mnt           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __napi_schedule        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __percpu_counter_compar=
e                      -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __slab_free            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __zone_watermark_ok    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ex_write_data_to_f=
ield                   -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ex_system_memory_s=
pace_handler           -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] apparmor_file_free_secu=
rity                   -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] calc_global_load       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] calc_wheel_index       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] clear_buddies          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] d_set_d_op             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] deactivate_task        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] fib_table_lookup       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] find_first_bit         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] fpregs_mark_activate   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] idr_find               =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] insert_work            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] io_serial_out          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] is_cpu_allowed         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] load_new_mm_cr3        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] native_flush_tlb_one_us=
er                     -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] nd_jump_root           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] number                 =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] orc_find.part.4        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] prepend_name           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] security_inode_permissi=
on                     -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] security_task_kill     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] simple_getattr         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] strscpy                =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] update_cfs_rq_h_load   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] uprobe_deny_signal     =
                       -      -           =20
     0.00%     0.00%  dash                      [.] findvar                =
                       -      -           =20
     0.00%     0.00%  gawk                      [.] make_str_node          =
                       -      -           =20
     0.00%     0.00%  gawk                      [.] yyparse                =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] memchr                 =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __install_special_mappi=
ng                     -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __note_gp_changes      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __x64_sys_ioctl        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ps_create_op      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ut_repair_name    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] cap_bprm_set_creds     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] common_perm            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] complete_signal        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] copy_page_to_iter      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] cpumask_next_wrap      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] do_epoll_wait          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] do_read_cache_page     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] down_read              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] dst_destroy            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] evict                  =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] filemap_fault          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] get_random_u64         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] ima_file_check         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] inet_gro_receive       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] mangle_path            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] mem_cgroup_handle_over_=
high                   -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] prepare_to_wait_event  =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] sched_fork             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] sched_rt_period_timer  =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] schedule_idle          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] scnprintf              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] simple_lookup          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] sum_vm_events          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] ttm_bo_move_to_lru_tail=
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] update_group_capacity  =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] wq_worker_running      =
                       -      -           =20
     0.00%     0.00%  dash                      [.] argstr                 =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __build_skb            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __internal_add_timer   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __legitimize_path      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __perf_event_header__in=
it_id                  -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __pmd_alloc            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __x64_sys_epoll_wait   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __x64_sys_sched_setaffi=
nity                   -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ev_address_space_d=
ispatch                -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_irq               =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ev_sci_xrupt_handl=
er                     -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ev_gpe_detect     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ex_opcode_1A_1T_1R=
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ex_store          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ex_resolve_node_to=
_value                 -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ex_store_object_to=
_node                  -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ex_read_data_from_=
field                  -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ex_extract_from_fi=
eld                    -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ex_field_datum_io =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ex_access_region  =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] add_timer_on           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] build_skb              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] calculate_sigpending   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] common_perm_cond       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] detach_entity_cfs_rq   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] dev_gro_receive        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] filename_parentat      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] handle_fasteoi_irq     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] irq_entries_start      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] igb_msix_ring          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] ksys_ioctl             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] msg_print_ext_header.co=
nstprop.32             -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] napi_gro_receive       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] new_inode              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] page_get_link          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] path_parentat          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] perf_event_ctx_lock_nes=
ted.isra.81            -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] perf_event_fork        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] perf_event_task        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] perf_event_task_output =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] proc_root_lookup       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] proc_pid_lookup        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] proc_pid_instantiate   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] proc_pid_make_inode    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] ptep_clear_flush       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] put_prev_task_fair     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] put_task_stack         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] queue_delayed_work_on  =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] sched_setaffinity      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] security_bprm_set_creds=
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] security_cred_free     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] security_file_free     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] seq_path               =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] setup_new_exec         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] stop_one_cpu           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] unlazy_walk            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] watchdog_timer_fn      =
                       -      -           =20
     0.00%     0.00%  dash                      [.] closescript            =
                       -      -           =20
     0.00%     0.00%  dash                      [.] evalbackcmd            =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] _IO_fgets              =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] _IO_setvbuf            =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] __ctype_init           =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] _exit                  =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] ioctl                  =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] ___d_drop              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] ___slab_alloc          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __bitmap_intersects    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __bitmap_subset        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __check_heap_object    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __close_fd             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __get_user_8           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __hrtimer_init         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __inode_wait_for_writeb=
ack                    -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __kmalloc              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __lock_task_sighand    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __netif_receive_skb_cor=
e                      -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __perf_event__output_id=
_sample                -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __pti_set_user_pgtbl   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __radix_tree_delete    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __remove_shared_vm_stru=
ct                     -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __task_pid_nr_ns       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __virt_addr_valid      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ds_method_data_ini=
t                      -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ex_start_trace_opc=
ode                    -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ds_create_operands=
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ex_allocate_name_s=
tring                  -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_os_read_port      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ps_append_arg     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ut_valid_name_char=
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] add_interrupt_randomnes=
s                      -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] apparmor_bprm_committin=
g_creds                -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] apparmor_file_mprotect =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] apparmor_inode_getattr =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] arch_irq_stat_cpu      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] arch_setup_new_exec    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] attach_entity_load_avg =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] audit_signal_info      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] balance_stop           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] blkcg_maybe_throttle_cu=
rrent                  -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] cgroup_css_set_put_fork=
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] chacha_permute         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] copy_namespaces        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] cgroup_release         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] cputime_adjust         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] disk_part_iter_next    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] domain_dirty_limits    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] dst_init               =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] dup_fd                 =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] dyntick_save_progress_c=
ounter                 -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] eth_type_trans         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] exit_creds             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] find_vpid              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] flush_ptrace_hw_breakpo=
int                    -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] fold_diff              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] free_pcppages_bulk     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] generic_file_llseek_siz=
e                      -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] generic_permission     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] get_task_pid           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] get_vfs_caps_from_disk =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] get_work_pool          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] igb_alloc_rx_buffers   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] ima_file_free          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] in_lock_functions      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] insert_vmap_area.constp=
rop.51                 -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] irq_chip_ack_parent    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] ip_rcv_core.isra.20    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] kernel_text_address    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] klist_next             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] kthread_data           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] lock_hrtimer_base      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] lockref_put_return     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] lru_cache_add_anon     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] m_next                 =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] m_stop                 =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] mm_put_huge_zero_page  =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] mntput_no_expire       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] msg_print_ext_body     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] nfs_flush_incompatible =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] page_frag_free         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] page_move_anon_rmap    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] perf_output_begin      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] perf_pending_event     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] pick_next_task_dl      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] pid_task               =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] posix_cpu_timers_exit  =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] put_ctx                =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] put_dec_trunc8         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] pwq_dec_nr_in_flight   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] ramfs_mmu_get_unmapped_=
area                   -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] raw_notifier_call_chain=
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] pvclock_gtod_notify    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] rcu_cblist_dequeue     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] rcu_dynticks_eqs_exit  =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] rcu_qs                 =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] rcu_report_qs_rnp      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] rcu_segcblist_accelerat=
e                      -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] recalc_sigpending_tsk  =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] refcount_dec_and_lock_i=
rqsave                 -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] reuse_swap_page        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] sched_autogroup_exit   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] security_task_free     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] security_task_getsecid =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] seq_puts               =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] skb_defer_rx_timestamp =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] sock_init_data         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] soft_cursor            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] stack_access_ok        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] start_thread_common.con=
stprop.6               -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] strchr                 =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] string                 =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] strrchr                =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] switch_ldt             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] sysctl_perm            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] task_curr              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] task_work_add          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] tsc_verify_tsc_adjust  =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] tick_nohz_next_event   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] tsk_fork_get_node      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] ttm_bo_add_mem_to_lru.i=
sra.10                 -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] udp4_gro_receive       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] unlock_page_memcg      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] uprobe_mmap            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] user_disable_single_ste=
p                      -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] vdso_fault             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] vma_adjust_trans_huge  =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] wakeup_preempt_entity.i=
sra.65                 -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] worker_enter_idle      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] would_dump             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] xas_nomem              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] xas_alloc              =
                       -      -           =20
     0.00%     0.00%  dash                      [.] expredir               =
                       -      -           =20
     0.00%     0.00%  dash                      [.] find_builtin           =
                       -      -           =20
     0.00%     0.00%  dash                      [.] find_command           =
                       -      -           =20
     0.00%     0.00%  dash                      [.] fmtstr                 =
                       -      -           =20
     0.00%     0.00%  dash                      [.] freejob                =
                       -      -           =20
     0.00%     0.00%  dash                      [.] ifsfree                =
                       -      -           =20
     0.00%     0.00%  dash                      [.] listvars               =
                       -      -           =20
     0.00%     0.00%  dash                      [.] redirectsafe           =
                       -      -           =20
     0.00%     0.00%  dash                      [.] testcmd                =
                       -      -           =20
     0.00%     0.00%  dash                      [.] unwindredir            =
                       -      -           =20
     0.00%     0.00%  dmesg                     [.] __ctype_b_loc@plt      =
                       -      -           =20
     0.00%     0.00%  gawk                      [.] main                   =
                       -      -           =20
     0.00%     0.00%  grep                      [.] _init                  =
                       -      -           =20
     0.00%     0.00%  imklog.so                 [.] _init                  =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] __sigsetjmp            =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] __strdup               =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] bindtextdomain         =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] btowc                  =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] fread_unlocked         =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] getenv                 =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] strchrnul              =
                       -      -           =20
     0.00%     0.00%  libpthread-2.24.so        [.] _pthread_cleanup_push_d=
efer                   -      -           =20
     0.00%     0.00%  malloc1_processes         [.] alarm@plt              =
                       -      -           =20
     0.00%     0.00%  mpstat                    [.] fgets@plt              =
                       -      -           =20
     0.00%     0.00%  perf                      [.] perf_evlist            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __d_drop.part.19       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __get_user_pages_remote=
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __get_user_pages       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __kernel_text_address  =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __lookup_hash          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __next_timer_interrupt =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __pud_alloc            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __put_cred             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] cgroup_post_fork       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __sched_fork           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __set_cpus_allowed_ptr =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __sigqueue_alloc       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __slab_alloc           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __sys_socket           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __sock_create          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __x64_sys_chdir        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __x64_sys_nanosleep    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] __x64_sys_socket       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] _extract_crng          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acct_collect           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ds_create_walk_sta=
te                     -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ds_restart_control=
_method                -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ds_result_push    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ev_detect_gpe     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ps_complete_op    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ps_get_next_arg   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ut_create_generic_=
state                  -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_ex_get_name_string=
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_hw_read           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] acpi_hw_read_port      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] alloc_inode            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] apparmor_file_alloc_sec=
urity                  -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] arch_cpu_idle_enter    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] attach_entity_cfs_rq   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] balance_fair           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] bit_cursor             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] cgroup_exit            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] chacha_block_generic   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] check_kill_permission  =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] class_dev_iter_next    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] complete_walk          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] copy_page_from_iter    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] copy_strings_kernel    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] copyout                =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] css_set_move_task      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] cursor_timer_handler   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] d_invalidate           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] d_lookup               =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] dcache_dir_close       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] disk_seqf_next         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] do_nanosleep           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] drm_client_buffer_vmap =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] drm_client_buffer_vunma=
p                      -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] drm_gem_vmap           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] drm_gem_vram_vunmap    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] drm_gem_vram_object_vma=
p                      -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] drm_gem_vram_vmap      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] dst_alloc              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] ep_poll                =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] exec_mm_release        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] fb_flashcursor         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] find_extend_vma        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] fpstate_init           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] free_fs_struct         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] free_pid               =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] free_uid               =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] free_unref_page        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] futex_exec_release     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] get_user_arg_ptr.isra.2=
3                      -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] global_dirty_limits    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] hrtimer_nanosleep      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] in_sched_functions     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] init_dl_task_timer     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] inode_sb_list_add      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] inode_wait_for_writebac=
k                      -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] insert_vm_struct       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] insert_vmap_area_augmen=
t.constprop.52         -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] install_exec_creds     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] ksys_chdir             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] ksys_lseek             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] lookup_dcache          =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] menu_select            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] migrate_task_rq_fair   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] mod_timer              =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] move_page_tables       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] native_set_p4d         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] new_inode_pseudo       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] next_online_pgdat      =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] nfs_file_write         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] nfs_write_begin        =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] notifier_call_chain    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] nr_running             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] perf_event_pid_type    =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] pmd_devmap             =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] prepare_exec_creds     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] proc_alloc_inode       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] proc_flush_pid         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] proc_invalidate_sibling=
s_dcache               -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] proc_sys_call_handler  =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] put_files_struct       =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] put_pid.part.1         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] put_prev_task_stop     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] radix_tree_delete_item =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] randomize_page         =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] rt_dst_alloc           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] schedule_hrtimeout_rang=
e_clock                -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] security_bprm_committin=
g_creds                -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] security_file_mprotect =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] set_task_cpu           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] shrink_dcache_parent   =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] shrink_dentry_list     =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] sprintf                =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] stack_trace_consume_ent=
ry_nosched             -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] swake_up_one           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] swake_up_locked.part.2 =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] task_change_group_fair =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] thread_group_cputime_ad=
justed                 -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] tick_nohz_get_sleep_len=
gth                    -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] unix_create            =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] unix_create1           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] unwind_get_return_addre=
ss                     -      -           =20
     0.00%     0.00%  dash                      [.] popstackmark           =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] uprobe_start_dup_mmap  =
                       -      -           =20
     0.00%     0.00%  [kernel.kallsyms]         [k] vmstat_show            =
                       -      -           =20
     0.00%     0.00%  gawk                      [.] estrdup                =
                       -      -           =20
     0.00%     0.00%  gawk                      [.] init_symbol_table      =
                       -      -           =20
     0.00%     0.00%  gawk                      [.] resetup                =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] _IO_file_read          =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] _IO_file_setbuf        =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] __clock_gettime        =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] __ctype_b_loc          =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] __getpagesize          =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] __memcpy_chk           =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] __socket               =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] __sysconf              =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] __vsprintf_chk         =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] access                 =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] lseek64                =
                       -      -           =20
     0.00%     0.00%  libc-2.24.so              [.] mkdir                  =
                       -      -           =20
     0.00%     0.00%  libm-2.24.so              [.] ceilf                  =
                       -      -           =20
     0.00%     0.00%  libpthread-2.24.so        [.] __nanosleep            =
                       -      -           =20
     0.00%     0.00%  libpthread-2.24.so        [.] pthread_cond_signal@@GL=
IBC_2.3.2              -      -           =20
     0.00%     0.00%  libsystemd-shared-232.so  [.] sd_event_run           =
                       -      -           =20
     0.00%     0.00%  libsystemd-shared-232.so  [.] sd_notifyf             =
                       -      -           =20


# Samples: 0  of event 'dummy:HG'
# Event count (approx.): 0
#
# Children      Self  Shared Object  Symbol  IPC   [IPC Coverage]
# ........  ........  .............  ......  ....................
#


#
# (Cannot load tips.txt file, please install perf!)
#

--GvXjxJ+pjyke8COw--
