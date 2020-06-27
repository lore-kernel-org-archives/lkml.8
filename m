Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE898C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 08:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 127CE2137B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 08:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgF0I0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 04:26:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:42719 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgF0I0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 04:26:34 -0400
IronPort-SDR: Pad8Vv2ac71O78RK7UaE+eSLsyqRow0YWnynrXM+wDkDx+RVT1CbYL05nkeLrpAw0FjrBCP+rc
 2FVyHGsBPQOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="143116383"
X-IronPort-AV: E=Sophos;i="5.75,287,1589266800"; 
   d="yaml'?scan'208";a="143116383"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2020 01:25:11 -0700
IronPort-SDR: PzLgy3AwyDFWik2fhO+595HlGCe/Ux63NF9WxTmHxT7oDPeH4QH/1UZo0Nrt2g805fS5C1lmQ+
 TdvN9BqzQrTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,287,1589266800"; 
   d="yaml'?scan'208";a="305573612"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by orsmga007.jf.intel.com with ESMTP; 27 Jun 2020 01:25:08 -0700
Date:   Sat, 27 Jun 2020 16:24:43 +0800
From:   krenel test robot <rong.a.chen@intel.com>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Christoph Hellwig <hch@lst.de>, Xin Tan <tanxin.ctf@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: [configfs] 8aebfffacf: will-it-scale.per_process_ops 10.7%
 improvement
Message-ID: <20200627082443.GI5535@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/6pUCPTUcpTjDznW"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/6pUCPTUcpTjDznW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Greeting,

FYI, we noticed a 10.7% improvement of will-it-scale.per_process_ops due to commit:


commit: 8aebfffacfa379ba400da573a5bf9e49634e38cb ("configfs: fix config_item refcnt leak in configfs_rmdir()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: will-it-scale
on test machine: 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory
with following parameters:

	nr_task: 100%
	mode: process
	test: mmap1
	cpufreq_governor: performance
	ucode: 0x11

test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
test-url: https://github.com/antonblanchard/will-it-scale

In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_thread_ops 11.9% improvement        |
| test machine     | 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory |
| test parameters  | cpufreq_governor=performance                                         |
|                  | mode=thread                                                          |
|                  | nr_task=100%                                                         |
|                  | test=open1                                                           |
|                  | ucode=0x11                                                           |
+------------------+----------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_thread_ops 17.8% improvement        |
| test machine     | 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory |
| test parameters  | cpufreq_governor=performance                                         |
|                  | mode=thread                                                          |
|                  | nr_task=100%                                                         |
|                  | test=sched_yield                                                     |
|                  | ucode=0x11                                                           |
+------------------+----------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_process_ops -14.1% regression       |
| test machine     | 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory |
| test parameters  | cpufreq_governor=performance                                         |
|                  | mode=process                                                         |
|                  | nr_task=100%                                                         |
|                  | test=page_fault2                                                     |
|                  | ucode=0x11                                                           |
+------------------+----------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
  gcc-7/performance/x86_64-rhel-7.6/process/100%/debian-x86_64-20191114.cgz/lkp-knm01/mmap1/will-it-scale/0x11

commit: 
  v5.7-rc3
  8aebfffacf ("configfs: fix config_item refcnt leak in configfs_rmdir()")

        v5.7-rc3 8aebfffacfa379ba400da573a5b 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          5:6          -83%            :4     dmesg.WARNING:at#for_ip_interrupt_entry/0x
           :6           17%           1:4     dmesg.WARNING:at_ip_fsnotify_parent/0x
          2:6          -33%            :4     dmesg.WARNING:at_ip_perf_event_mmap_output/0x
         %stddev     %change         %stddev
             \          |                \  
      1471           +10.7%       1628        will-it-scale.per_process_ops
    158244           -93.8%       9886        will-it-scale.time.maximum_resident_set_size
     87613           -93.0%       6106        will-it-scale.time.minor_page_faults
      1.17 ± 31%    -100.0%       0.00        will-it-scale.time.percent_of_cpu_this_job_got
    423766           +10.7%     469037        will-it-scale.workload
     45.02            +4.4%      47.01 ±  2%  boot-time.boot
      0.54 ±  5%      +0.2        0.76 ±  8%  mpstat.cpu.all.usr%
   1381971           +11.0%    1534587        vmstat.memory.cache
    360.06          -100.0%       0.00        uptime.boot
     14088 ±  3%    -100.0%       0.00        uptime.idle
   1261069           +11.3%    1403860        meminfo.Cached
     48276 ± 22%     +48.4%      71641 ± 22%  meminfo.Mapped
   1096270           +12.8%    1236320        meminfo.Unevictable
    315278           +11.3%     350955        proc-vmstat.nr_file_pages
     12192 ± 22%     +47.3%      17953 ± 22%  proc-vmstat.nr_mapped
     30130            +8.1%      32577        proc-vmstat.nr_slab_reclaimable
    274067           +12.8%     309080        proc-vmstat.nr_unevictable
    274067           +12.8%     309080        proc-vmstat.nr_zone_unevictable
   1074698 ± 11%     -17.1%     890766 ±  5%  proc-vmstat.pgfree
    565456           +12.4%     635335        numa-meminfo.node0.Unevictable
    530814           +13.2%     600985        numa-meminfo.node1.FilePages
     17836 ±  6%     +27.3%      22702        numa-meminfo.node1.KReclaimable
     10865           +14.1%      12399        numa-meminfo.node1.Mapped
    623752           +11.9%     697704        numa-meminfo.node1.MemUsed
     17836 ±  6%     +27.3%      22702        numa-meminfo.node1.SReclaimable
    530814           +13.2%     600985        numa-meminfo.node1.Unevictable
    141363           +12.4%     158833        numa-vmstat.node0.nr_unevictable
    141363           +12.4%     158833        numa-vmstat.node0.nr_zone_unevictable
    154650           +11.3%     172062        numa-vmstat.node0.numa_interleave
    132703           +13.2%     150246        numa-vmstat.node1.nr_file_pages
      2715           +14.1%       3099        numa-vmstat.node1.nr_mapped
      4459 ±  6%     +27.3%       5675        numa-vmstat.node1.nr_slab_reclaimable
    132703           +13.2%     150246        numa-vmstat.node1.nr_unevictable
    132703           +13.2%     150246        numa-vmstat.node1.nr_zone_unevictable
    155463           +11.0%     172640        numa-vmstat.node1.numa_hit
    154878           +11.1%     172055        numa-vmstat.node1.numa_interleave
    154891           +11.1%     172068        numa-vmstat.node1.numa_other
    108714 ±  3%      -8.1%      99959 ±  5%  sched_debug.cfs_rq:/.exec_clock.min
  35857851 ±  3%      -7.8%   33046430 ±  5%  sched_debug.cfs_rq:/.min_vruntime.min
    566.50 ±  7%     -11.5%     501.41 ±  3%  sched_debug.cfs_rq:/.util_est_enqueued.avg
   2057901 ± 11%     +24.7%    2565766 ± 10%  sched_debug.cpu.avg_idle.avg
   1139755 ±  8%     +48.0%    1686683 ± 11%  sched_debug.cpu.avg_idle.stddev
    608.73 ±  7%     -14.8%     518.47 ±  3%  sched_debug.cpu.clock.stddev
    608.73 ±  7%     -14.8%     518.47 ±  3%  sched_debug.cpu.clock_task.stddev
   2502457 ± 25%     +52.1%    3805340 ± 21%  sched_debug.cpu.max_idle_balance_cost.max
    227444 ± 12%     +57.7%     358618 ± 12%  sched_debug.cpu.max_idle_balance_cost.stddev
      1059 ± 22%     -47.5%     556.70 ±  2%  sched_debug.cpu.nr_switches.min
    418.53 ±  4%     -12.7%     365.55 ±  3%  sched_debug.cpu.sched_count.min
      0.03 ± 82%   +1207.4%       0.45 ± 41%  sched_debug.rt_rq:/.rt_time.avg
      4.65 ±211%   +2609.5%     125.93 ± 46%  sched_debug.rt_rq:/.rt_time.max
      0.30 ±185%   +2337.7%       7.41 ± 46%  sched_debug.rt_rq:/.rt_time.stddev
     65.33 ± 31%    +157.1%     168.00        slabinfo.btrfs_extent_map.active_objs
     65.33 ± 31%    +157.1%     168.00        slabinfo.btrfs_extent_map.num_objs
      8668 ±  8%     +13.9%       9873 ±  2%  slabinfo.eventpoll_pwq.active_objs
      8668 ±  8%     +13.9%       9873 ±  2%  slabinfo.eventpoll_pwq.num_objs
     84377           +10.6%      93315        slabinfo.inode_cache.active_objs
      1567           +10.6%       1733        slabinfo.inode_cache.active_slabs
     84674           +10.6%      93652        slabinfo.inode_cache.num_objs
      1567           +10.6%       1733        slabinfo.inode_cache.num_slabs
    597.33 ± 14%     -27.7%     432.00 ± 19%  slabinfo.kmalloc-rcl-128.active_objs
    597.33 ± 14%     -27.7%     432.00 ± 19%  slabinfo.kmalloc-rcl-128.num_objs
      6319 ±  6%     +23.9%       7831 ±  9%  slabinfo.kmalloc-rcl-64.active_objs
      6319 ±  6%     +23.9%       7831 ±  9%  slabinfo.kmalloc-rcl-64.num_objs
     28831           +15.7%      33359        slabinfo.radix_tree_node.active_objs
     28831           +15.7%      33359        slabinfo.radix_tree_node.num_objs
    986.50 ±  5%    -100.0%       0.00        slabinfo.skbuff_ext_cache.active_objs
    986.50 ±  5%    -100.0%       0.00        slabinfo.skbuff_ext_cache.num_objs
      5697 ± 33%     -34.2%       3746        interrupts.CPU106.NMI:Non-maskable_interrupts
      5697 ± 33%     -34.2%       3746        interrupts.CPU106.PMI:Performance_monitoring_interrupts
      6325 ± 28%     -25.8%       4690 ± 35%  interrupts.CPU112.NMI:Non-maskable_interrupts
      6325 ± 28%     -25.8%       4690 ± 35%  interrupts.CPU112.PMI:Performance_monitoring_interrupts
      5692 ± 33%     -17.6%       4691 ± 35%  interrupts.CPU124.NMI:Non-maskable_interrupts
      5692 ± 33%     -17.6%       4691 ± 35%  interrupts.CPU124.PMI:Performance_monitoring_interrupts
      9.33 ± 23%    +408.9%      47.50 ±111%  interrupts.CPU147.RES:Rescheduling_interrupts
     83.00 ± 32%     +54.2%     128.00 ± 15%  interrupts.CPU150.RES:Rescheduling_interrupts
    170.50 ± 26%     -38.7%     104.50 ± 22%  interrupts.CPU160.RES:Rescheduling_interrupts
    184.83 ± 75%     -52.4%      88.00 ± 51%  interrupts.CPU170.RES:Rescheduling_interrupts
     83.17 ± 15%    +149.8%     207.75 ± 16%  interrupts.CPU188.RES:Rescheduling_interrupts
     97.67 ± 37%     +68.7%     164.75 ± 30%  interrupts.CPU204.RES:Rescheduling_interrupts
    147.50 ± 55%     -52.2%      70.50 ± 81%  interrupts.CPU208.RES:Rescheduling_interrupts
      6327 ± 28%     -26.1%       4675 ± 35%  interrupts.CPU220.NMI:Non-maskable_interrupts
      6327 ± 28%     -26.1%       4675 ± 35%  interrupts.CPU220.PMI:Performance_monitoring_interrupts
      6941 ± 20%     -32.6%       4676 ± 35%  interrupts.CPU227.NMI:Non-maskable_interrupts
      6941 ± 20%     -32.6%       4676 ± 35%  interrupts.CPU227.PMI:Performance_monitoring_interrupts
      5678 ± 33%     -18.5%       4628 ± 31%  interrupts.CPU238.NMI:Non-maskable_interrupts
      5678 ± 33%     -18.5%       4628 ± 31%  interrupts.CPU238.PMI:Performance_monitoring_interrupts
      5669 ± 33%     -34.0%       3744        interrupts.CPU248.NMI:Non-maskable_interrupts
      5669 ± 33%     -34.0%       3744        interrupts.CPU248.PMI:Performance_monitoring_interrupts
     29.83 ± 50%    +202.5%      90.25 ± 59%  interrupts.CPU264.RES:Rescheduling_interrupts
      6324 ± 28%     -40.7%       3752        interrupts.CPU281.NMI:Non-maskable_interrupts
      6324 ± 28%     -40.7%       3752        interrupts.CPU281.PMI:Performance_monitoring_interrupts
     93.67 ± 20%     -56.8%      40.50 ± 33%  interrupts.CPU29.RES:Rescheduling_interrupts
     80.17 ± 22%    +231.8%     266.00 ± 64%  interrupts.CPU70.RES:Rescheduling_interrupts
      5699 ± 33%     -18.6%       4641 ± 32%  interrupts.CPU90.NMI:Non-maskable_interrupts
      5699 ± 33%     -18.6%       4641 ± 32%  interrupts.CPU90.PMI:Performance_monitoring_interrupts
     35.57 ±  8%      -6.3       29.27        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.munmap
     35.56 ±  8%      -6.3       29.26        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.munmap
     35.69 ±  8%      -6.3       29.40        perf-profile.calltrace.cycles-pp.munmap
     35.34 ±  8%      -6.3       29.05        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.munmap
     35.35 ±  8%      -6.3       29.07        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.munmap
     34.52 ±  8%      -5.9       28.63        perf-profile.calltrace.cycles-pp.mmap64
     34.37 ±  8%      -5.9       28.48        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.mmap64
     34.38 ±  8%      -5.9       28.49        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.mmap64
     34.17 ±  8%      -5.9       28.31        perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.mmap64
     34.16 ±  8%      -5.9       28.30        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.mmap64
      0.73 ± 15%      -0.5        0.27 ±100%  perf-profile.calltrace.cycles-pp._raw_spin_unlock_irqrestore.percpu_counter_add_batch.__do_munmap.__vm_munmap.__x64_sys_munmap
      0.72 ± 13%      -0.5        0.26 ±100%  perf-profile.calltrace.cycles-pp._raw_spin_unlock_irqrestore.percpu_counter_add_batch.__vm_enough_memory.mmap_region.do_mmap
      0.91 ±  7%      -0.2        0.68 ±  4%  perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap
      0.85 ±  7%      -0.2        0.64 ±  4%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.__do_munmap.__vm_munmap
     49.96            -0.2       49.76        perf-profile.calltrace.cycles-pp.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     48.00            -0.2       47.81        perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
     46.09            +0.4       46.48        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.percpu_counter_add_batch.__vm_enough_memory.mmap_region
     46.13            +0.4       46.53        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.percpu_counter_add_batch.__vm_enough_memory.mmap_region.do_mmap
     14.25 ± 19%      +6.0       20.24        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.26 ± 19%      +6.0       20.25        perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.75 ± 19%      +6.0       20.79        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.76 ± 19%      +6.0       20.80        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     29.34 ± 19%     +12.2       41.52        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     29.35 ± 19%     +12.2       41.54        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     35.71 ±  8%      -6.3       29.41        perf-profile.children.cycles-pp.munmap
     34.53 ±  8%      -5.9       28.64        perf-profile.children.cycles-pp.mmap64
      1.92 ±  9%      -0.4        1.57 ± 11%  perf-profile.children.cycles-pp.smp_apic_timer_interrupt
      1.66 ±  9%      -0.3        1.33 ± 11%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.38 ±  6%      -0.3        1.11 ± 10%  perf-profile.children.cycles-pp.__hrtimer_run_queues
     50.09            -0.2       49.85        perf-profile.children.cycles-pp.__vm_munmap
     50.11            -0.2       49.88        perf-profile.children.cycles-pp.__x64_sys_munmap
     49.97            -0.2       49.77        perf-profile.children.cycles-pp.__do_munmap
      1.30            -0.1        1.17 ±  3%  perf-profile.children.cycles-pp.unmap_vmas
      1.25            -0.1        1.12 ±  3%  perf-profile.children.cycles-pp.unmap_page_range
      0.94 ±  3%      -0.1        0.83 ±  9%  perf-profile.children.cycles-pp.tick_sched_timer
      0.90 ±  3%      -0.1        0.79 ± 10%  perf-profile.children.cycles-pp.tick_sched_handle
      0.88 ±  3%      -0.1        0.78 ± 10%  perf-profile.children.cycles-pp.update_process_times
      0.70 ±  4%      -0.1        0.60 ± 10%  perf-profile.children.cycles-pp.scheduler_tick
      0.49 ±  2%      -0.1        0.42 ± 10%  perf-profile.children.cycles-pp.task_tick_fair
      0.12 ± 19%      -0.1        0.06 ± 20%  perf-profile.children.cycles-pp.__remove_hrtimer
      0.59            -0.0        0.56 ±  3%  perf-profile.children.cycles-pp.___might_sleep
      0.15 ±  5%      -0.0        0.12 ± 12%  perf-profile.children.cycles-pp.irq_exit
      0.14 ±  5%      -0.0        0.11 ±  9%  perf-profile.children.cycles-pp.update_curr
      0.11 ±  6%      -0.0        0.09 ±  7%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.07 ±  5%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.remove_vma
      0.10 ±  9%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.13 ±  7%      +0.0        0.16 ±  6%  perf-profile.children.cycles-pp.vm_area_alloc
      0.14 ±  5%      +0.0        0.18 ±  8%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.00            +0.1        0.05 ±  9%  perf-profile.children.cycles-pp.kmem_cache_free
      0.01 ±223%      +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.__might_sleep
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.fpregs_assert_state_consistent
      0.05            +0.1        0.14 ±  7%  perf-profile.children.cycles-pp.lru_add_drain
      0.02 ±141%      +0.1        0.13 ±  6%  perf-profile.children.cycles-pp.lru_add_drain_cpu
     92.90            +0.5       93.36        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     93.01            +0.5       93.48        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.20 ±  6%      -0.1        0.13 ±  9%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.51 ±  2%      -0.1        0.43 ±  3%  perf-profile.self.cycles-pp.unmap_page_range
      0.09 ± 27%      -0.1        0.03 ±102%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.10 ± 14%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.perf_event_mmap
      0.56            -0.0        0.53 ±  3%  perf-profile.self.cycles-pp.___might_sleep
      0.24 ±  3%      -0.0        0.22 ±  5%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.09 ±  5%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.12 ±  8%      +0.0        0.15 ± 10%  perf-profile.self.cycles-pp.perf_iterate_sb
      0.14 ±  5%      +0.0        0.18 ±  8%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.00            +0.1        0.05 ±  9%  perf-profile.self.cycles-pp.kmem_cache_free
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.__might_sleep
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.fpregs_assert_state_consistent
      0.01 ±223%      +0.1        0.13 ±  6%  perf-profile.self.cycles-pp.lru_add_drain_cpu
     92.90            +0.5       93.36        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
    134459 ±  2%      -8.7%     122798        softirqs.CPU0.TIMER
    133411 ±  2%      -8.0%     122678        softirqs.CPU100.TIMER
    133333 ±  2%      -8.0%     122724        softirqs.CPU101.TIMER
    133598 ±  2%      -8.4%     122435        softirqs.CPU110.TIMER
    134909            -9.1%     122634        softirqs.CPU113.TIMER
    133179 ±  2%      -7.7%     122926 ±  2%  softirqs.CPU114.TIMER
    133436 ±  2%      -8.3%     122320        softirqs.CPU119.TIMER
    134596 ±  2%      -9.3%     122103        softirqs.CPU12.TIMER
    135545 ±  4%      -9.8%     122253        softirqs.CPU122.TIMER
    134335 ±  2%      -8.6%     122754        softirqs.CPU125.TIMER
    135177 ±  4%      -9.2%     122750        softirqs.CPU128.TIMER
    134010 ±  3%      -8.4%     122696        softirqs.CPU129.TIMER
    133968 ±  2%      -8.5%     122525        softirqs.CPU13.TIMER
    132997 ±  2%      -8.0%     122308        softirqs.CPU134.TIMER
    132866 ±  2%      -8.1%     122135        softirqs.CPU136.TIMER
    133212 ±  2%      -8.4%     122064        softirqs.CPU137.TIMER
    133362 ±  2%      -8.2%     122381        softirqs.CPU138.TIMER
    134902 ±  2%      -8.7%     123132        softirqs.CPU14.TIMER
    133290 ±  2%      -8.2%     122366        softirqs.CPU140.TIMER
    133372 ±  3%      -8.2%     122468        softirqs.CPU141.TIMER
    132826 ±  2%      -8.0%     122159        softirqs.CPU142.TIMER
    132860 ±  2%      -8.6%     121443        softirqs.CPU144.TIMER
    133202 ±  2%      -8.2%     122321        softirqs.CPU146.TIMER
    133355 ±  2%      -8.7%     121769        softirqs.CPU148.TIMER
    133645 ±  2%      -8.3%     122597        softirqs.CPU149.TIMER
    133171 ±  3%      -8.2%     122221        softirqs.CPU156.TIMER
    135643 ±  4%      -9.6%     122677        softirqs.CPU16.TIMER
    133388 ±  2%      -8.1%     122526        softirqs.CPU163.TIMER
    133749 ±  2%      -8.5%     122375        softirqs.CPU17.TIMER
    132919 ±  2%      -8.5%     121670        softirqs.CPU171.TIMER
    133345 ±  2%      -8.3%     122262        softirqs.CPU173.TIMER
    132748 ±  3%      -8.0%     122131        softirqs.CPU176.TIMER
    133989 ±  2%      -8.9%     122054        softirqs.CPU18.TIMER
    133046 ±  2%      -8.1%     122223        softirqs.CPU180.TIMER
    132979 ±  2%      -8.1%     122264        softirqs.CPU181.TIMER
    133378 ±  2%      -8.4%     122150        softirqs.CPU182.TIMER
    133506 ±  3%      -8.7%     121872        softirqs.CPU188.TIMER
    133634 ±  2%      -8.4%     122410        softirqs.CPU19.TIMER
    133179 ±  2%      -8.5%     121804        softirqs.CPU195.TIMER
    132997 ±  3%      -8.6%     121596        softirqs.CPU197.TIMER
    132919 ±  2%      -8.5%     121655        softirqs.CPU198.TIMER
    133502 ±  2%      -8.6%     121974        softirqs.CPU20.TIMER
    132247 ±  2%      -7.7%     122080        softirqs.CPU200.TIMER
    132682 ±  2%      -8.3%     121707        softirqs.CPU201.TIMER
    132349 ±  3%      -7.7%     122114        softirqs.CPU202.TIMER
    132434 ±  3%      -7.7%     122283        softirqs.CPU203.TIMER
    132590 ±  2%      -8.4%     121393        softirqs.CPU208.TIMER
    132398 ±  2%      -8.2%     121482        softirqs.CPU209.TIMER
    133514 ±  2%      -8.7%     121956        softirqs.CPU21.TIMER
    133008 ±  3%      -8.3%     121918        softirqs.CPU210.TIMER
    133510 ±  3%      -8.9%     121656        softirqs.CPU211.TIMER
    132399 ±  2%      -8.2%     121476        softirqs.CPU212.TIMER
    132399 ±  2%      -8.2%     121476        softirqs.CPU213.TIMER
    132523 ±  2%      -8.0%     121977        softirqs.CPU214.TIMER
    132473 ±  2%      -8.5%     121240        softirqs.CPU215.TIMER
    137798 ±  7%     -11.5%     121900        softirqs.CPU22.TIMER
    133101 ±  2%      -8.6%     121611        softirqs.CPU220.TIMER
    134009 ±  3%      -9.2%     121636        softirqs.CPU221.TIMER
    132697 ±  2%      -8.4%     121490        softirqs.CPU222.TIMER
    133397 ±  2%      -8.4%     122135        softirqs.CPU228.TIMER
    133531 ±  2%      -8.7%     121970        softirqs.CPU23.TIMER
    132213 ±  2%      -7.9%     121829        softirqs.CPU230.TIMER
    132975 ±  3%      -8.3%     121978        softirqs.CPU238.TIMER
    133584 ±  3%      -8.7%     121978        softirqs.CPU24.TIMER
    132432 ±  2%      -8.0%     121787        softirqs.CPU242.TIMER
    132561 ±  2%      -8.4%     121491        softirqs.CPU243.TIMER
    132407 ±  2%      -7.8%     122027 ±  2%  softirqs.CPU244.TIMER
    132955 ±  2%      -8.6%     121534        softirqs.CPU245.TIMER
    133660 ±  2%      -8.8%     121922        softirqs.CPU25.TIMER
    132138 ±  2%      -7.8%     121774        softirqs.CPU250.TIMER
    132361 ±  3%      -8.2%     121514        softirqs.CPU252.TIMER
    132422 ±  3%      -8.2%     121586        softirqs.CPU253.TIMER
    137025 ±  7%     -11.3%     121487        softirqs.CPU254.TIMER
    132352 ±  2%      -8.4%     121197        softirqs.CPU255.TIMER
    131979 ±  2%      -8.2%     121176        softirqs.CPU256.TIMER
    132151 ±  2%      -8.4%     121098        softirqs.CPU257.TIMER
    132837 ±  3%      -8.5%     121489        softirqs.CPU260.TIMER
    132653            -8.8%     120999 ±  2%  softirqs.CPU266.TIMER
    132231 ±  2%      -8.9%     120478        softirqs.CPU269.TIMER
    133698 ±  2%      -8.7%     122032        softirqs.CPU27.TIMER
    132110 ±  2%      -8.9%     120375        softirqs.CPU270.TIMER
    132329 ±  2%      -9.0%     120457        softirqs.CPU272.TIMER
    132508 ±  2%      -8.8%     120911        softirqs.CPU273.TIMER
    131921 ±  2%      -8.6%     120544        softirqs.CPU274.TIMER
    132230 ±  2%      -8.7%     120729        softirqs.CPU275.TIMER
    132181 ±  2%      -8.8%     120573        softirqs.CPU276.TIMER
    134398 ±  5%     -10.1%     120833        softirqs.CPU277.TIMER
    131843 ±  2%      -8.5%     120602        softirqs.CPU278.TIMER
    133421 ±  2%      -8.5%     122025        softirqs.CPU28.TIMER
    131856 ±  2%      -8.7%     120359        softirqs.CPU280.TIMER
    132034 ±  2%      -8.7%     120592        softirqs.CPU281.TIMER
    132557 ±  2%      -9.0%     120614        softirqs.CPU282.TIMER
    133019 ±  2%      -9.7%     120142        softirqs.CPU283.TIMER
    131831 ±  2%      -8.5%     120600        softirqs.CPU284.TIMER
    132329 ±  2%      -8.6%     120971        softirqs.CPU285.TIMER
    131836 ±  2%      -8.9%     120073        softirqs.CPU286.TIMER
    126308 ±  3%     -14.3%     108210 ±  7%  softirqs.CPU287.TIMER
    133749 ±  2%      -8.7%     122054        softirqs.CPU29.TIMER
    133821 ±  2%      -9.0%     121831        softirqs.CPU3.TIMER
    133931            -8.9%     122056        softirqs.CPU30.TIMER
    133730 ±  2%      -8.8%     121904        softirqs.CPU31.TIMER
    135936 ±  3%     -10.5%     121705        softirqs.CPU32.TIMER
    133364 ±  2%      -8.7%     121789        softirqs.CPU33.TIMER
    133499            -8.8%     121705        softirqs.CPU34.TIMER
    134336 ±  2%      -9.2%     121940        softirqs.CPU35.TIMER
    133118 ±  2%      -8.3%     122113        softirqs.CPU36.TIMER
    133775 ±  2%      -9.0%     121748        softirqs.CPU37.TIMER
    133045 ±  2%      -8.3%     121998        softirqs.CPU38.TIMER
    132874 ±  2%      -8.0%     122287        softirqs.CPU39.TIMER
    134208 ±  2%      -7.4%     124329 ±  4%  softirqs.CPU4.TIMER
    133599 ±  2%      -8.6%     122060        softirqs.CPU41.TIMER
    133991 ±  2%      -8.9%     122058        softirqs.CPU42.TIMER
    133783 ±  2%      -8.7%     122132        softirqs.CPU45.TIMER
    133698 ±  2%      -8.4%     122501        softirqs.CPU47.TIMER
    133904 ±  2%      -8.9%     121925        softirqs.CPU5.TIMER
    134059 ±  2%      -8.6%     122491        softirqs.CPU53.TIMER
    140548 ± 11%     -13.0%     122285        softirqs.CPU55.TIMER
    134013 ±  2%      -8.8%     122274        softirqs.CPU56.TIMER
    135542 ±  4%      -9.3%     122942        softirqs.CPU57.TIMER
    133683 ±  2%      -8.7%     122070        softirqs.CPU58.TIMER
    133734 ±  2%      -8.2%     122801        softirqs.CPU6.TIMER
    133469 ±  2%      -8.4%     122305        softirqs.CPU60.TIMER
    136154 ±  4%     -10.1%     122353        softirqs.CPU61.TIMER
    133819 ±  2%      -8.9%     121944        softirqs.CPU62.TIMER
    133824 ±  2%      -9.3%     121414        softirqs.CPU63.TIMER
    133697 ±  2%      -8.5%     122288        softirqs.CPU64.TIMER
    133719 ±  2%      -8.8%     122016        softirqs.CPU66.TIMER
    133634 ±  2%      -8.9%     121724        softirqs.CPU67.TIMER
    133851 ±  2%      -8.5%     122495        softirqs.CPU68.TIMER
    133618 ±  2%      -8.5%     122325        softirqs.CPU69.TIMER
    133816 ±  2%      -8.7%     122110        softirqs.CPU70.TIMER
    133338 ±  2%      -8.2%     122340        softirqs.CPU71.TIMER
      8074 ± 32%     -43.6%       4557        softirqs.CPU73.RCU
    139691 ±  5%     -12.2%     122619        softirqs.CPU73.TIMER
    134414 ±  2%      -8.7%     122695        softirqs.CPU76.TIMER
    134661 ±  2%      -8.9%     122674        softirqs.CPU77.TIMER
    133670 ±  2%      -8.7%     122040        softirqs.CPU8.TIMER
    134093 ±  2%      -8.4%     122854        softirqs.CPU80.TIMER
    133919 ±  2%      -8.6%     122458        softirqs.CPU83.TIMER
    133776 ±  2%      -8.2%     122797        softirqs.CPU86.TIMER
    135212 ±  4%      -9.4%     122496        softirqs.CPU89.TIMER
    133802 ±  2%      -8.9%     121958        softirqs.CPU9.TIMER
    134030 ±  2%      -8.6%     122545        softirqs.CPU91.TIMER
    134236 ±  3%      -8.4%     123012        softirqs.CPU94.TIMER
    138956 ±  7%     -11.4%     123126        softirqs.CPU96.TIMER
      1565 ±  5%    +381.2%       7535 ± 49%  softirqs.NET_RX
  38399366 ±  2%      -8.2%   35256509        softirqs.TIMER


                                                                                
                           will-it-scale.per_process_ops                        
                                                                                
  1800 +--------------------------------------------------------------------+   
       |  O   O  O      O   O  O   O  O   O  O  O   O  O   O  O   O  O      |   
  1600 |..+                      ..+..      .+..+...+..+...     ..+..+...+..|   
  1400 |-+:             +...+..+.     +...+.               +..+.            |   
       |   :            :                                                   |   
  1200 |-+ :           :                                                    |   
  1000 |-+ :           :                                                    |   
       |    :          :                                                    |   
   800 |-+  :          :                                                    |   
   600 |-+  :         :                                                     |   
       |     :        :                                                     |   
   400 |-+   :        :                                                     |   
   200 |-+   :        :                                                     |   
       |      :      :                                                      |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                               will-it-scale.workload                           
                                                                                
  500000 +------------------------------------------------------------------+   
  450000 |-+O   O  O      O  O  O   O  O   O  O  O   O  O  O   O  O  O      |   
         |..+             +..+..+...+..  ..+..+..+...+..+..  ..+..+..+...+..|   
  400000 |-+:             :            +.                  +.               |   
  350000 |-+ :           :                                                  |   
         |   :           :                                                  |   
  300000 |-+ :           :                                                  |   
  250000 |-+  :         :                                                   |   
  200000 |-+  :         :                                                   |   
         |    :         :                                                   |   
  150000 |-+   :       :                                                    |   
  100000 |-+   :       :                                                    |   
         |     :       :                                                    |   
   50000 |-+    :     :                                                     |   
       0 +------------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-knm01: 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
  gcc-7/performance/x86_64-rhel-7.6/thread/100%/debian-x86_64-20191114.cgz/lkp-knm01/open1/will-it-scale/0x11

commit: 
  v5.7-rc3
  8aebfffacf ("configfs: fix config_item refcnt leak in configfs_rmdir()")

        v5.7-rc3 8aebfffacfa379ba400da573a5b 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          5:5         -100%            :1     dmesg.WARNING:at#for_ip_interrupt_entry/0x
           :5           20%           1:1     dmesg.WARNING:at#for_ip_swapgs_restore_regs_and_return_to_usermode/0x
          4:5          -80%            :1     dmesg.WARNING:at_ip_fsnotify_parent/0x
         %stddev     %change         %stddev
             \          |                \  
    888.20           +11.9%     994.00        will-it-scale.per_thread_ops
    542327          -100.0%       6.00        will-it-scale.time.involuntary_context_switches
    244880           -96.0%       9772        will-it-scale.time.maximum_resident_set_size
     52934           -88.5%       6070        will-it-scale.time.minor_page_faults
     28447          -100.0%       0.00        will-it-scale.time.percent_of_cpu_this_job_got
     87059          -100.0%       0.19        will-it-scale.time.system_time
    313.04 ±  3%     -99.9%       0.24        will-it-scale.time.user_time
      2065 ± 21%     -96.8%      67.00        will-it-scale.time.voluntary_context_switches
    255979           +11.9%     286557        will-it-scale.workload
     45.76 ±  2%      +3.8%      47.50        boot-time.boot
     11391 ±  2%      +3.9%      11836        boot-time.idle
      0.06 ±  5%      +0.1        0.11        mpstat.cpu.all.soft%
      0.50 ±  2%      +0.2        0.73        mpstat.cpu.all.usr%
    360.53          -100.0%       0.00        uptime.boot
     14281          -100.0%       0.00        uptime.idle
   1366998           +10.9%    1515912        vmstat.memory.cache
      4322           +40.8%       6087        vmstat.system.cs
   1247353           +11.1%    1386310        meminfo.Cached
    681.20 ±122%    +150.6%       1707        meminfo.Mlocked
   1095965           +12.9%    1237288        meminfo.Unevictable
    565128           +12.6%     636336        numa-meminfo.node0.Unevictable
    530836           +13.2%     600952        numa-meminfo.node1.FilePages
     17615 ±  9%     +32.5%      23348        numa-meminfo.node1.KReclaimable
     10925           +13.8%      12429        numa-meminfo.node1.Mapped
    622609           +12.2%     698516        numa-meminfo.node1.MemUsed
     17615 ±  9%     +32.5%      23348        numa-meminfo.node1.SReclaimable
     31688 ±  8%     +18.7%      37628        numa-meminfo.node1.Slab
    530836           +13.2%     600952        numa-meminfo.node1.Unevictable
    141281           +12.6%     159083        numa-vmstat.node0.nr_unevictable
    141281           +12.6%     159083        numa-vmstat.node0.nr_zone_unevictable
    154743           +11.2%     172123        numa-vmstat.node0.numa_interleave
    132709           +13.2%     150238        numa-vmstat.node1.nr_file_pages
      2731           +13.7%       3105        numa-vmstat.node1.nr_mapped
      4403 ±  9%     +32.5%       5837        numa-vmstat.node1.nr_slab_reclaimable
    132709           +13.2%     150238        numa-vmstat.node1.nr_unevictable
    132709           +13.2%     150238        numa-vmstat.node1.nr_zone_unevictable
    155367           +11.1%     172552        numa-vmstat.node1.numa_hit
    154782           +11.1%     171964        numa-vmstat.node1.numa_interleave
    154795           +11.1%     171976        numa-vmstat.node1.numa_other
    125539            +1.4%     127359        proc-vmstat.nr_anon_pages
    311850           +11.1%     346545        proc-vmstat.nr_file_pages
     11616            +5.4%      12242        proc-vmstat.nr_mapped
     29822            +8.5%      32345        proc-vmstat.nr_slab_reclaimable
     87439            +1.4%      88664        proc-vmstat.nr_slab_unreclaimable
    273990           +12.9%     309322        proc-vmstat.nr_unevictable
    273990           +12.9%     309322        proc-vmstat.nr_zone_unevictable
      6518 ±  3%      -9.2%       5921        proc-vmstat.numa_hint_faults
      6518 ±  3%      -9.2%       5921        proc-vmstat.numa_hint_faults_local
    894126            -1.5%     880458        proc-vmstat.numa_hit
    894126            -1.5%     880458        proc-vmstat.numa_local
    356019            +7.0%     380894        proc-vmstat.numa_pte_updates
    846963            -1.9%     830953        proc-vmstat.pgfault
    962825            -7.8%     887792        proc-vmstat.pgfree
      1511 ±  6%     +27.9%       1933        slabinfo.file_lock_cache.active_objs
      1511 ±  6%     +27.9%       1933        slabinfo.file_lock_cache.num_objs
     84372           +10.6%      93300        slabinfo.inode_cache.active_objs
      1567           +10.6%       1733        slabinfo.inode_cache.active_slabs
     84657           +10.6%      93607        slabinfo.inode_cache.num_objs
      1567           +10.6%       1733        slabinfo.inode_cache.num_slabs
      2465 ± 10%     +27.2%       3137        slabinfo.khugepaged_mm_slot.active_objs
      2465 ± 10%     +27.2%       3137        slabinfo.khugepaged_mm_slot.num_objs
      6099 ±  8%     +16.9%       7129        slabinfo.kmalloc-rcl-64.active_objs
      6099 ±  8%     +16.9%       7129        slabinfo.kmalloc-rcl-64.num_objs
    657.20 ±  7%     +22.6%     806.00        slabinfo.numa_policy.active_objs
    657.20 ±  7%     +22.6%     806.00        slabinfo.numa_policy.num_objs
     28780           +15.5%      33230        slabinfo.radix_tree_node.active_objs
     28780           +15.5%      33230        slabinfo.radix_tree_node.num_objs
      1136 ±  4%    -100.0%       0.00        slabinfo.skbuff_ext_cache.active_objs
      1136 ±  4%    -100.0%       0.00        slabinfo.skbuff_ext_cache.num_objs
      1026 ±  4%     -15.2%     870.00        slabinfo.skbuff_fclone_cache.active_objs
      1026 ±  4%     -15.2%     870.00        slabinfo.skbuff_fclone_cache.num_objs
      1255 ±  3%     +15.5%       1450        slabinfo.task_group.active_objs
      1255 ±  3%     +15.5%       1450        slabinfo.task_group.num_objs
      1472           -18.5%       1200        sched_debug.cfs_rq:/.exec_clock.stddev
      5.09 ±  5%     +24.2%       6.32        sched_debug.cfs_rq:/.load_avg.avg
    147.32 ± 36%     -38.2%      91.00        sched_debug.cfs_rq:/.load_avg.max
    644505           -15.9%     541941        sched_debug.cfs_rq:/.min_vruntime.stddev
    128.50 ± 40%     +80.8%     232.36        sched_debug.cfs_rq:/.nr_spread_over.avg
    254.64 ± 21%     +46.5%     373.00        sched_debug.cfs_rq:/.nr_spread_over.max
     19.72 ±  8%     +84.7%      36.42        sched_debug.cfs_rq:/.nr_spread_over.stddev
     47.08 ±  7%     +13.0%      53.19        sched_debug.cfs_rq:/.util_avg.stddev
   8576310 ± 11%     +23.4%   10584065        sched_debug.cpu.avg_idle.max
      1270           -33.7%     842.03        sched_debug.cpu.clock.stddev
      1270           -33.7%     842.03        sched_debug.cpu.clock_task.stddev
   1969070 ± 10%     +36.3%    2683386        sched_debug.cpu.max_idle_balance_cost.max
    207363 ± 10%     +17.2%     243056        sched_debug.cpu.max_idle_balance_cost.stddev
      0.00           -33.5%       0.00        sched_debug.cpu.next_balance.stddev
      4788           +15.0%       5504        sched_debug.cpu.nr_switches.avg
     22523 ± 12%     +34.6%      30319        sched_debug.cpu.nr_switches.max
      1789 ± 19%     +53.3%       2743        sched_debug.cpu.nr_switches.min
      1922 ±  5%     +15.5%       2220        sched_debug.cpu.nr_switches.stddev
      0.00 ± 54%    -100.0%       0.00        sched_debug.cpu.nr_uninterruptible.avg
      2066           +33.0%       2748        sched_debug.cpu.sched_count.avg
     18124 ± 17%     +43.4%      25987        sched_debug.cpu.sched_count.max
      1336           +45.4%       1943        sched_debug.cpu.sched_count.min
      1489 ±  9%     +21.2%       1805        sched_debug.cpu.sched_count.stddev
    906.60           +38.5%       1255        sched_debug.cpu.ttwu_count.avg
      8824 ± 16%     +42.9%      12610        sched_debug.cpu.ttwu_count.max
    600.40           +51.8%     911.40        sched_debug.cpu.ttwu_count.min
    771.87 ±  8%     +19.8%     924.84        sched_debug.cpu.ttwu_count.stddev
    838.79           +41.8%       1189        sched_debug.cpu.ttwu_local.avg
      8251 ± 17%     +47.4%      12161        sched_debug.cpu.ttwu_local.max
    592.04           +50.8%     893.00        sched_debug.cpu.ttwu_local.min
    671.44 ± 11%     +24.5%     836.15        sched_debug.cpu.ttwu_local.stddev
      0.02 ± 13%   +2158.1%       0.49        sched_debug.rt_rq:/.rt_time.avg
      0.23 ± 23%  +61069.8%     140.99        sched_debug.rt_rq:/.rt_time.max
      0.05 ±  8%  +15455.0%       8.29        sched_debug.rt_rq:/.rt_time.stddev
     17897           +10.0%      19690        softirqs.CPU102.RCU
     17584 ±  3%      +8.6%      19097        softirqs.CPU104.RCU
    118027 ± 13%     +17.3%     138420        softirqs.CPU105.TIMER
      1567 ±146%   +1449.6%      24286        softirqs.CPU11.NET_RX
     20056 ±  8%     +47.9%      29665        softirqs.CPU11.RCU
    105076 ±  9%     +14.9%     120696        softirqs.CPU11.TIMER
    125179 ± 10%     +19.2%     149205        softirqs.CPU112.TIMER
    122851 ± 12%     +19.7%     147077        softirqs.CPU122.TIMER
    295.00 ± 70%   +3917.3%      11851        softirqs.CPU13.NET_RX
     19060 ±  3%     +48.6%      28327        softirqs.CPU13.RCU
    118005 ± 12%     +20.9%     142700        softirqs.CPU134.TIMER
    115236 ±  9%     +17.7%     135682        softirqs.CPU135.TIMER
    124737 ± 12%     +17.5%     146568        softirqs.CPU138.TIMER
    118041 ± 11%     +16.2%     137150        softirqs.CPU146.TIMER
    117207 ± 13%     +22.4%     143500        softirqs.CPU147.TIMER
    123578 ± 12%     +15.2%     142420        softirqs.CPU152.TIMER
    119024 ± 12%     +18.6%     141137        softirqs.CPU153.TIMER
    114261 ± 13%     +23.4%     141010        softirqs.CPU157.TIMER
    127481 ± 11%     +14.9%     146417        softirqs.CPU159.TIMER
     19230 ±  4%      +9.6%      21072        softirqs.CPU16.RCU
    124958 ± 11%     +14.9%     143591        softirqs.CPU161.TIMER
    124030 ± 13%     +16.2%     144177        softirqs.CPU165.TIMER
    115582 ± 14%     +19.0%     137497        softirqs.CPU173.TIMER
     17444 ±  2%     +17.3%      20465        softirqs.CPU182.RCU
    120903 ± 13%     +19.7%     144709        softirqs.CPU187.TIMER
    116780 ± 12%     +17.5%     137227        softirqs.CPU195.TIMER
     17548 ±  3%     +17.4%      20609        softirqs.CPU196.RCU
    116381 ± 13%     +19.5%     139093        softirqs.CPU199.TIMER
     17195 ±  2%      +9.3%      18790        softirqs.CPU200.RCU
    118401 ± 11%     +16.4%     137831        softirqs.CPU200.TIMER
    124742 ± 11%     +15.4%     143893        softirqs.CPU202.TIMER
    117531 ± 11%     +18.9%     139749        softirqs.CPU215.TIMER
    116289 ± 11%     +19.6%     139030        softirqs.CPU216.TIMER
    116587 ± 11%     +23.7%     144193        softirqs.CPU220.TIMER
     17695 ±  3%      +8.1%      19135        softirqs.CPU221.RCU
    117205 ± 11%     +19.4%     139956        softirqs.CPU221.TIMER
    119762 ± 11%     +20.7%     144564        softirqs.CPU225.TIMER
     17214 ±  2%      +9.1%      18776        softirqs.CPU229.RCU
    122398 ± 11%     +17.4%     143709        softirqs.CPU233.TIMER
    112338 ± 13%     +17.5%     131952        softirqs.CPU238.TIMER
     17326           +15.2%      19952        softirqs.CPU239.RCU
    119806 ± 11%     +19.6%     143316        softirqs.CPU246.TIMER
    118281 ± 13%     +17.1%     138534        softirqs.CPU247.TIMER
    110402 ± 13%     +20.4%     132888        softirqs.CPU256.TIMER
     17218 ±  2%     +40.6%      24209        softirqs.CPU265.RCU
    103283 ±  8%     +71.8%     177475        softirqs.CPU265.TIMER
     18905 ±  2%     +11.8%      21138        softirqs.CPU28.RCU
     17230 ±  3%     +10.3%      18999        softirqs.CPU282.RCU
     19392 ±  4%     +21.9%      23632        softirqs.CPU30.RCU
     18951 ±  3%     +18.4%      22433        softirqs.CPU31.RCU
    105516 ±  6%     -11.3%      93580        softirqs.CPU32.TIMER
     18749 ±  2%     +13.1%      21201        softirqs.CPU34.RCU
    108972 ± 10%     +22.1%     133022        softirqs.CPU43.TIMER
     18723 ±  3%     +27.8%      23926        softirqs.CPU53.RCU
    109283 ± 10%     +22.0%     133326        softirqs.CPU64.TIMER
     18586 ±  9%     +45.0%      26960        softirqs.CPU72.RCU
    117359 ± 13%     +30.5%     153156        softirqs.CPU72.TIMER
     17989           +24.6%      22407        softirqs.CPU75.RCU
    112037 ± 12%     +19.8%     134168        softirqs.CPU75.TIMER
    115165 ± 12%     +21.8%     140265        softirqs.CPU80.TIMER
    110504 ± 12%     +17.9%     130255        softirqs.CPU81.TIMER
    122916 ± 12%     +16.8%     143533        softirqs.CPU82.TIMER
    116896 ± 12%     +17.2%     137045        softirqs.CPU84.TIMER
    118538 ± 10%     +13.6%     134673        softirqs.CPU85.TIMER
    116481 ± 12%     +19.4%     139126        softirqs.CPU93.TIMER
      3411 ± 68%   +1005.0%      37695        softirqs.NET_RX
     48.48            -0.3       48.13        perf-profile.calltrace.cycles-pp.__alloc_fd.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
     48.22            -0.3       47.94        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__alloc_fd.do_sys_openat2.do_sys_open
     49.17            -0.3       48.91        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__GI___libc_close
     49.15            -0.3       48.90        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_close
     49.95            -0.2       49.72        perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_open
     49.94            -0.2       49.71        perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_open
     48.20            -0.2       47.98        perf-profile.calltrace.cycles-pp._raw_spin_lock.__alloc_fd.do_sys_openat2.do_sys_open.do_syscall_64
     48.62            -0.2       48.41        perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_close
     50.02            -0.2       49.81        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_open
     50.03            -0.2       49.82        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__GI___libc_open
     48.47            -0.2       48.27        perf-profile.calltrace.cycles-pp.__close_fd.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_close
     49.34            -0.2       49.15        perf-profile.calltrace.cycles-pp.__GI___libc_close
     48.28            -0.2       48.10        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__close_fd.__x64_sys_close.do_syscall_64
     50.22            -0.2       50.06        perf-profile.calltrace.cycles-pp.__GI___libc_open
     48.27            -0.1       48.14        perf-profile.calltrace.cycles-pp._raw_spin_lock.__close_fd.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.89 ±  3%      +0.2        3.11        perf-profile.calltrace.cycles-pp.apic_timer_interrupt.native_queued_spin_lock_slowpath._raw_spin_lock.__alloc_fd.do_sys_openat2
      2.77 ±  3%      +0.2        3.01        perf-profile.calltrace.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.native_queued_spin_lock_slowpath._raw_spin_lock.__alloc_fd
      3.55 ±  3%      +0.2        3.80        perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt.native_queued_spin_lock_slowpath
      2.91 ±  4%      +0.3        3.18        perf-profile.calltrace.cycles-pp.apic_timer_interrupt.native_queued_spin_lock_slowpath._raw_spin_lock.__close_fd.__x64_sys_close
      2.79 ±  4%      +0.3        3.07        perf-profile.calltrace.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.native_queued_spin_lock_slowpath._raw_spin_lock.__close_fd
      4.56 ±  3%      +0.3        4.91        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt.native_queued_spin_lock_slowpath._raw_spin_lock
     96.64            -0.5       96.17        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     96.69            -0.5       96.23        perf-profile.children.cycles-pp._raw_spin_lock
     48.51            -0.3       48.16        perf-profile.children.cycles-pp.__alloc_fd
     99.46            -0.3       99.16        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     99.43            -0.3       99.13        perf-profile.children.cycles-pp.do_syscall_64
     49.95            -0.2       49.72        perf-profile.children.cycles-pp.do_sys_openat2
     49.96            -0.2       49.73        perf-profile.children.cycles-pp.do_sys_open
     48.62            -0.2       48.41        perf-profile.children.cycles-pp.__x64_sys_close
     48.47            -0.2       48.27        perf-profile.children.cycles-pp.__close_fd
     49.35            -0.2       49.16        perf-profile.children.cycles-pp.__GI___libc_close
     50.22            -0.2       50.07        perf-profile.children.cycles-pp.__GI___libc_open
      0.17 ± 13%      -0.1        0.08        perf-profile.children.cycles-pp.update_rq_clock
      0.49            -0.1        0.41        perf-profile.children.cycles-pp.exit_to_usermode_loop
      0.45            -0.1        0.37        perf-profile.children.cycles-pp.task_work_run
      0.48 ±  2%      -0.1        0.41        perf-profile.children.cycles-pp.alloc_empty_file
      0.34            -0.1        0.28        perf-profile.children.cycles-pp.kmem_cache_alloc
      0.16 ± 10%      -0.0        0.11        perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.14 ± 22%      -0.0        0.09        perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.09 ± 10%      -0.0        0.05        perf-profile.children.cycles-pp.expand_files
      0.30            -0.0        0.26        perf-profile.children.cycles-pp.__fput
      0.42 ±  2%      -0.0        0.38        perf-profile.children.cycles-pp.__alloc_file
      0.14 ±  5%      -0.0        0.11        perf-profile.children.cycles-pp.security_file_alloc
      0.11 ±  4%      -0.0        0.10        perf-profile.children.cycles-pp.strncpy_from_user
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.security_file_open
      0.16 ±  2%      +0.0        0.17        perf-profile.children.cycles-pp.link_path_walk
      0.06 ±  6%      +0.0        0.08        perf-profile.children.cycles-pp.tick_program_event
      0.15 ±  4%      +0.0        0.17        perf-profile.children.cycles-pp.do_dentry_open
      0.04 ± 50%      +0.0        0.06        perf-profile.children.cycles-pp.lapic_next_deadline
      0.05            +0.0        0.07        perf-profile.children.cycles-pp.dput
      0.19 ±  2%      +0.0        0.21        perf-profile.children.cycles-pp.getname_flags
      0.05 ± 50%      +0.0        0.07        perf-profile.children.cycles-pp.native_write_msr
      0.13 ±  6%      +0.0        0.15        perf-profile.children.cycles-pp.enqueue_hrtimer
      0.11 ±  7%      +0.0        0.13        perf-profile.children.cycles-pp.timerqueue_add
      0.06 ±  7%      +0.0        0.09        perf-profile.children.cycles-pp.___might_sleep
      0.16 ±  9%      +0.0        0.19        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.03 ± 81%      +0.0        0.06        perf-profile.children.cycles-pp.fsnotify
      0.03 ± 81%      +0.0        0.06        perf-profile.children.cycles-pp._cond_resched
      0.19 ± 29%      +0.0        0.24        perf-profile.children.cycles-pp.rb_next
      0.09 ± 23%      +0.1        0.14        perf-profile.children.cycles-pp.rcu_irq_enter
      0.01 ±200%      +0.1        0.07        perf-profile.children.cycles-pp.shmem_getpage_gfp
      0.03 ± 81%      +0.1        0.09        perf-profile.children.cycles-pp.__slab_free
      0.01 ±200%      +0.1        0.07        perf-profile.children.cycles-pp.fput_many
      0.24 ± 25%      +0.1        0.31        perf-profile.children.cycles-pp.timerqueue_del
      0.13 ±  3%      +0.1        0.20        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.14 ±  2%      +0.1        0.21        perf-profile.children.cycles-pp.kmem_cache_free
      0.48 ±  7%      +0.1        0.55        perf-profile.children.cycles-pp.irq_exit
      0.00            +0.1        0.08        perf-profile.children.cycles-pp.account_process_tick
      0.00            +0.1        0.10        perf-profile.children.cycles-pp.fpregs_assert_state_consistent
      0.14 ± 34%      +0.1        0.24        perf-profile.children.cycles-pp.generic_perform_write
      0.15 ± 32%      +0.1        0.25        perf-profile.children.cycles-pp.__generic_file_write_iter
      0.19 ±  2%      +0.1        0.30        perf-profile.children.cycles-pp.file_free_rcu
      0.18 ± 21%      +0.1        0.29        perf-profile.children.cycles-pp.irq_enter
      0.50 ± 28%      +0.1        0.62        perf-profile.children.cycles-pp.__remove_hrtimer
      0.15 ± 34%      +0.1        0.27        perf-profile.children.cycles-pp.generic_file_write_iter
      0.16 ± 33%      +0.1        0.28        perf-profile.children.cycles-pp.new_sync_write
      0.18 ± 32%      +0.1        0.32        perf-profile.children.cycles-pp.vfs_write
      0.19 ± 32%      +0.1        0.34        perf-profile.children.cycles-pp.ksys_write
      0.24 ± 22%      +0.1        0.39        perf-profile.children.cycles-pp.update_curr
      0.06            +0.2        0.22        perf-profile.children.cycles-pp.ret_from_fork
      0.06 ±  6%      +0.2        0.22        perf-profile.children.cycles-pp.kthread
      0.29 ±  2%      +0.2        0.45        perf-profile.children.cycles-pp.rcu_core
      0.27            +0.2        0.44        perf-profile.children.cycles-pp.rcu_do_batch
      0.25 ± 32%      +0.2        0.42        perf-profile.children.cycles-pp.main
      0.25 ± 32%      +0.2        0.42        perf-profile.children.cycles-pp.cmd_record
      0.00            +0.2        0.19        perf-profile.children.cycles-pp.run_ksoftirqd
      0.00            +0.2        0.20        perf-profile.children.cycles-pp.smpboot_thread_fn
      0.42 ±  4%      +0.2        0.62        perf-profile.children.cycles-pp.__softirqentry_text_start
      3.69 ±  2%      +0.3        3.97        perf-profile.children.cycles-pp.__hrtimer_run_queues
      4.75 ±  2%      +0.4        5.15        perf-profile.children.cycles-pp.hrtimer_interrupt
      6.02 ±  4%      +0.6        6.59        perf-profile.children.cycles-pp.apic_timer_interrupt
      5.76 ±  3%      +0.6        6.35        perf-profile.children.cycles-pp.smp_apic_timer_interrupt
     90.71            -1.0       89.67        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.27 ±  3%      -0.1        0.16        perf-profile.self.cycles-pp._raw_spin_lock
      0.23            -0.1        0.14        perf-profile.self.cycles-pp.kmem_cache_alloc
      0.15 ±  7%      -0.1        0.10        perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.10 ± 23%      -0.1        0.05        perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.08 ±  4%      -0.0        0.05        perf-profile.self.cycles-pp.do_syscall_64
      0.09 ±  4%      -0.0        0.07        perf-profile.self.cycles-pp.__close_fd
      0.10 ±  5%      -0.0        0.08        perf-profile.self.cycles-pp.__alloc_fd
      0.08 ±  5%      +0.0        0.10        perf-profile.self.cycles-pp.timerqueue_add
      0.09 ±  4%      +0.0        0.11        perf-profile.self.cycles-pp.kmem_cache_free
      0.06 ±  6%      +0.0        0.08        perf-profile.self.cycles-pp.tick_program_event
      0.05 ± 50%      +0.0        0.07        perf-profile.self.cycles-pp.native_write_msr
      0.06 ±  8%      +0.0        0.08        perf-profile.self.cycles-pp.___might_sleep
      0.16 ±  9%      +0.0        0.19        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.02 ±122%      +0.0        0.06        perf-profile.self.cycles-pp.__softirqentry_text_start
      0.08 ±  6%      +0.0        0.12        perf-profile.self.cycles-pp.__alloc_file
      0.18 ± 28%      +0.0        0.23        perf-profile.self.cycles-pp.rb_next
      0.03 ± 81%      +0.0        0.08        perf-profile.self.cycles-pp.__slab_free
      0.01 ±200%      +0.0        0.06        perf-profile.self.cycles-pp.run_timer_softirq
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.do_filp_open
      0.09 ± 19%      +0.1        0.15        perf-profile.self.cycles-pp.irq_enter
      0.08 ± 22%      +0.1        0.14        perf-profile.self.cycles-pp.rcu_irq_enter
      0.13 ±  3%      +0.1        0.20        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.account_process_tick
      0.18 ±  4%      +0.1        0.28        perf-profile.self.cycles-pp.file_free_rcu
      0.00            +0.1        0.10        perf-profile.self.cycles-pp.fpregs_assert_state_consistent
      0.14 ± 29%      +0.1        0.25        perf-profile.self.cycles-pp.update_curr
      2513 ±155%   +1249.9%      33932        interrupts.31:IR-PCI-MSI.2097154-edge.eth0-TxRx-1
    446.60 ± 74%   +3332.4%      15329        interrupts.33:IR-PCI-MSI.2097156-edge.eth0-TxRx-3
    875.40 ± 71%     -68.5%     276.00        interrupts.CPU1.RES:Rescheduling_interrupts
      6595 ± 21%     -44.2%       3683        interrupts.CPU10.NMI:Non-maskable_interrupts
      6595 ± 21%     -44.2%       3683        interrupts.CPU10.PMI:Performance_monitoring_interrupts
      4331 ± 33%     +69.1%       7322        interrupts.CPU101.NMI:Non-maskable_interrupts
      4331 ± 33%     +69.1%       7322        interrupts.CPU101.PMI:Performance_monitoring_interrupts
    115.20 ± 11%     -17.5%      95.00        interrupts.CPU103.RES:Rescheduling_interrupts
    570.60 ± 89%     -83.4%      95.00        interrupts.CPU104.RES:Rescheduling_interrupts
    104.80 ±  8%     +88.0%     197.00        interrupts.CPU105.RES:Rescheduling_interrupts
      3644           +97.8%       7209        interrupts.CPU106.NMI:Non-maskable_interrupts
      3644           +97.8%       7209        interrupts.CPU106.PMI:Performance_monitoring_interrupts
      3619          +101.2%       7282        interrupts.CPU108.NMI:Non-maskable_interrupts
      3619          +101.2%       7282        interrupts.CPU108.PMI:Performance_monitoring_interrupts
    169.00 ± 25%     -55.6%      75.00        interrupts.CPU108.RES:Rescheduling_interrupts
      2513 ±155%   +1249.9%      33932        interrupts.CPU11.31:IR-PCI-MSI.2097154-edge.eth0-TxRx-1
    337.60 ± 11%     -13.5%     292.00        interrupts.CPU11.RES:Rescheduling_interrupts
    241.20 ± 65%     -62.3%      91.00        interrupts.CPU110.RES:Rescheduling_interrupts
    121.60 ± 28%     -56.4%      53.00        interrupts.CPU111.RES:Rescheduling_interrupts
    228.40 ± 53%     -64.1%      82.00        interrupts.CPU112.RES:Rescheduling_interrupts
      5826 ± 30%     -38.1%       3609        interrupts.CPU113.NMI:Non-maskable_interrupts
      5826 ± 30%     -38.1%       3609        interrupts.CPU113.PMI:Performance_monitoring_interrupts
    125.00 ± 14%     -29.6%      88.00        interrupts.CPU115.RES:Rescheduling_interrupts
    199.60 ± 18%     -48.4%     103.00        interrupts.CPU116.RES:Rescheduling_interrupts
    144.80 ± 41%     -62.7%      54.00        interrupts.CPU117.RES:Rescheduling_interrupts
    168.20 ± 10%     -57.8%      71.00        interrupts.CPU119.RES:Rescheduling_interrupts
      5899 ± 30%     -37.7%       3675        interrupts.CPU12.NMI:Non-maskable_interrupts
      5899 ± 30%     -37.7%       3675        interrupts.CPU12.PMI:Performance_monitoring_interrupts
    195.80 ± 44%     -62.7%      73.00        interrupts.CPU120.RES:Rescheduling_interrupts
      4313 ± 33%     +67.8%       7240        interrupts.CPU121.NMI:Non-maskable_interrupts
      4313 ± 33%     +67.8%       7240        interrupts.CPU121.PMI:Performance_monitoring_interrupts
    138.20 ± 17%     -37.8%      86.00        interrupts.CPU121.RES:Rescheduling_interrupts
      6509 ± 21%     -43.9%       3651        interrupts.CPU123.NMI:Non-maskable_interrupts
      6509 ± 21%     -43.9%       3651        interrupts.CPU123.PMI:Performance_monitoring_interrupts
      4330 ± 33%     +67.1%       7235        interrupts.CPU127.NMI:Non-maskable_interrupts
      4330 ± 33%     +67.1%       7235        interrupts.CPU127.PMI:Performance_monitoring_interrupts
    154.20 ± 33%     -31.3%     106.00        interrupts.CPU129.RES:Rescheduling_interrupts
    446.60 ± 74%   +3332.4%      15329        interrupts.CPU13.33:IR-PCI-MSI.2097156-edge.eth0-TxRx-3
    162.00 ± 55%     -52.5%      77.00        interrupts.CPU131.RES:Rescheduling_interrupts
    142.60 ± 19%     -32.7%      96.00        interrupts.CPU132.RES:Rescheduling_interrupts
    162.60 ±  8%     +58.1%     257.00        interrupts.CPU134.RES:Rescheduling_interrupts
    160.60 ± 23%     -34.0%     106.00        interrupts.CPU138.RES:Rescheduling_interrupts
      5820 ± 30%     -38.6%       3572        interrupts.CPU139.NMI:Non-maskable_interrupts
      5820 ± 30%     -38.6%       3572        interrupts.CPU139.PMI:Performance_monitoring_interrupts
    324.40 ±  7%     -12.8%     283.00        interrupts.CPU14.RES:Rescheduling_interrupts
    167.80 ± 32%     -70.8%      49.00        interrupts.CPU140.RES:Rescheduling_interrupts
    179.40 ± 29%     -57.1%      77.00        interrupts.CPU142.RES:Rescheduling_interrupts
      7243           -50.2%       3605        interrupts.CPU150.NMI:Non-maskable_interrupts
      7243           -50.2%       3605        interrupts.CPU150.PMI:Performance_monitoring_interrupts
      3644           +98.8%       7246        interrupts.CPU151.NMI:Non-maskable_interrupts
      3644           +98.8%       7246        interrupts.CPU151.PMI:Performance_monitoring_interrupts
     58.20 ± 21%     +92.4%     112.00        interrupts.CPU154.RES:Rescheduling_interrupts
      3598          +101.1%       7237        interrupts.CPU160.NMI:Non-maskable_interrupts
      3598          +101.1%       7237        interrupts.CPU160.PMI:Performance_monitoring_interrupts
      3618          +101.5%       7291        interrupts.CPU165.NMI:Non-maskable_interrupts
      3618          +101.5%       7291        interrupts.CPU165.PMI:Performance_monitoring_interrupts
     63.80 ± 86%    +459.6%     357.00        interrupts.CPU167.RES:Rescheduling_interrupts
      5818 ± 30%     -38.1%       3599        interrupts.CPU170.NMI:Non-maskable_interrupts
      5818 ± 30%     -38.1%       3599        interrupts.CPU170.PMI:Performance_monitoring_interrupts
     63.00 ± 42%     +96.8%     124.00        interrupts.CPU176.RES:Rescheduling_interrupts
     39.60 ± 27%    +185.4%     113.00        interrupts.CPU179.RES:Rescheduling_interrupts
     56.00 ± 28%    +166.1%     149.00        interrupts.CPU180.RES:Rescheduling_interrupts
     35.80 ± 20%    +441.9%     194.00        interrupts.CPU187.RES:Rescheduling_interrupts
     46.60 ± 16%    +116.7%     101.00        interrupts.CPU191.RES:Rescheduling_interrupts
      4318 ± 33%     +68.8%       7291        interrupts.CPU198.NMI:Non-maskable_interrupts
      4318 ± 33%     +68.8%       7291        interrupts.CPU198.PMI:Performance_monitoring_interrupts
      4310 ± 33%     +68.4%       7258        interrupts.CPU201.NMI:Non-maskable_interrupts
      4310 ± 33%     +68.4%       7258        interrupts.CPU201.PMI:Performance_monitoring_interrupts
     37.80 ± 31%    +243.9%     130.00        interrupts.CPU201.RES:Rescheduling_interrupts
      5055 ± 35%     +44.1%       7285        interrupts.CPU202.NMI:Non-maskable_interrupts
      5055 ± 35%     +44.1%       7285        interrupts.CPU202.PMI:Performance_monitoring_interrupts
     75.80 ± 28%    +911.9%     767.00        interrupts.CPU202.RES:Rescheduling_interrupts
      4311 ± 33%     +68.2%       7250        interrupts.CPU203.NMI:Non-maskable_interrupts
      4311 ± 33%     +68.2%       7250        interrupts.CPU203.PMI:Performance_monitoring_interrupts
      3593          +100.4%       7199        interrupts.CPU205.NMI:Non-maskable_interrupts
      3593          +100.4%       7199        interrupts.CPU205.PMI:Performance_monitoring_interrupts
    129.60 ± 11%    +240.3%     441.00        interrupts.CPU21.RES:Rescheduling_interrupts
     74.00 ± 17%    +456.8%     412.00        interrupts.CPU210.RES:Rescheduling_interrupts
      5033 ± 34%     +44.1%       7254        interrupts.CPU213.NMI:Non-maskable_interrupts
      5033 ± 34%     +44.1%       7254        interrupts.CPU213.PMI:Performance_monitoring_interrupts
     43.60 ± 39%   +2166.1%     988.00        interrupts.CPU213.RES:Rescheduling_interrupts
     67.80 ± 88%     -72.0%      19.00        interrupts.CPU216.RES:Rescheduling_interrupts
     27.80 ± 45%    +310.1%     114.00        interrupts.CPU223.RES:Rescheduling_interrupts
      3586          +101.4%       7224        interrupts.CPU224.NMI:Non-maskable_interrupts
      3586          +101.4%       7224        interrupts.CPU224.PMI:Performance_monitoring_interrupts
     22.20 ± 28%    +404.5%     112.00        interrupts.CPU239.RES:Rescheduling_interrupts
      3602          +100.8%       7234        interrupts.CPU240.NMI:Non-maskable_interrupts
      3602          +100.8%       7234        interrupts.CPU240.PMI:Performance_monitoring_interrupts
      3594          +101.4%       7239        interrupts.CPU241.NMI:Non-maskable_interrupts
      3594          +101.4%       7239        interrupts.CPU241.PMI:Performance_monitoring_interrupts
     33.60 ± 51%    +370.2%     158.00        interrupts.CPU241.RES:Rescheduling_interrupts
      4765           -11.6%       4212        interrupts.CPU244.CAL:Function_call_interrupts
      4316 ± 32%     +67.2%       7218        interrupts.CPU248.NMI:Non-maskable_interrupts
      4316 ± 32%     +67.2%       7218        interrupts.CPU248.PMI:Performance_monitoring_interrupts
      4409 ± 32%     +68.4%       7425        interrupts.CPU25.NMI:Non-maskable_interrupts
      4409 ± 32%     +68.4%       7425        interrupts.CPU25.PMI:Performance_monitoring_interrupts
    118.80 ± 17%     -31.0%      82.00        interrupts.CPU25.RES:Rescheduling_interrupts
      3602           +99.0%       7167        interrupts.CPU250.NMI:Non-maskable_interrupts
      3602           +99.0%       7167        interrupts.CPU250.PMI:Performance_monitoring_interrupts
     31.60 ± 66%    +263.9%     115.00        interrupts.CPU251.RES:Rescheduling_interrupts
     38.60 ± 28%    +648.7%     289.00        interrupts.CPU258.RES:Rescheduling_interrupts
      3611          +102.2%       7303        interrupts.CPU259.NMI:Non-maskable_interrupts
      3611          +102.2%       7303        interrupts.CPU259.PMI:Performance_monitoring_interrupts
      4332 ± 33%     +66.8%       7228        interrupts.CPU267.NMI:Non-maskable_interrupts
      4332 ± 33%     +66.8%       7228        interrupts.CPU267.PMI:Performance_monitoring_interrupts
      5778 ± 31%     -39.0%       3526        interrupts.CPU268.NMI:Non-maskable_interrupts
      5778 ± 31%     -39.0%       3526        interrupts.CPU268.PMI:Performance_monitoring_interrupts
      3697           +99.5%       7377        interrupts.CPU27.NMI:Non-maskable_interrupts
      3697           +99.5%       7377        interrupts.CPU27.PMI:Performance_monitoring_interrupts
      5037 ± 35%     +44.5%       7278        interrupts.CPU275.NMI:Non-maskable_interrupts
      5037 ± 35%     +44.5%       7278        interrupts.CPU275.PMI:Performance_monitoring_interrupts
     23.00 ± 22%   +1034.8%     261.00        interrupts.CPU278.RES:Rescheduling_interrupts
      4322 ± 32%     +66.5%       7197        interrupts.CPU280.NMI:Non-maskable_interrupts
      4322 ± 32%     +66.5%       7197        interrupts.CPU280.PMI:Performance_monitoring_interrupts
      3585          +101.5%       7225        interrupts.CPU285.NMI:Non-maskable_interrupts
      3585          +101.5%       7225        interrupts.CPU285.PMI:Performance_monitoring_interrupts
    359.80 ±  7%     +60.6%     578.00        interrupts.CPU3.RES:Rescheduling_interrupts
    131.80 ± 20%     -37.0%      83.00        interrupts.CPU30.RES:Rescheduling_interrupts
    125.40 ± 14%     -30.6%      87.00        interrupts.CPU32.RES:Rescheduling_interrupts
      5948 ± 30%     -38.8%       3639        interrupts.CPU33.NMI:Non-maskable_interrupts
      5948 ± 30%     -38.8%       3639        interrupts.CPU33.PMI:Performance_monitoring_interrupts
      4408 ± 34%     +68.8%       7443        interrupts.CPU34.NMI:Non-maskable_interrupts
      4408 ± 34%     +68.8%       7443        interrupts.CPU34.PMI:Performance_monitoring_interrupts
    131.80 ± 23%     -40.8%      78.00        interrupts.CPU34.RES:Rescheduling_interrupts
      5152 ± 34%     +43.5%       7395        interrupts.CPU35.NMI:Non-maskable_interrupts
      5152 ± 34%     +43.5%       7395        interrupts.CPU35.PMI:Performance_monitoring_interrupts
    127.80 ± 24%     -34.3%      84.00        interrupts.CPU36.RES:Rescheduling_interrupts
    141.00 ± 16%     +26.2%     178.00        interrupts.CPU38.RES:Rescheduling_interrupts
    135.60 ± 36%     -59.4%      55.00        interrupts.CPU39.RES:Rescheduling_interrupts
    175.80 ± 44%     -58.5%      73.00        interrupts.CPU40.RES:Rescheduling_interrupts
    128.00 ±  4%     -32.8%      86.00        interrupts.CPU41.RES:Rescheduling_interrupts
     94.40 ± 10%     -33.3%      63.00        interrupts.CPU43.RES:Rescheduling_interrupts
      5834 ± 30%     -38.5%       3587        interrupts.CPU44.NMI:Non-maskable_interrupts
      5834 ± 30%     -38.5%       3587        interrupts.CPU44.PMI:Performance_monitoring_interrupts
    131.60 ± 15%     -23.3%     101.00        interrupts.CPU44.RES:Rescheduling_interrupts
    170.00 ± 22%     -47.1%      90.00        interrupts.CPU46.RES:Rescheduling_interrupts
    159.20 ± 35%     -49.7%      80.00        interrupts.CPU47.RES:Rescheduling_interrupts
    127.60 ± 34%     -43.6%      72.00        interrupts.CPU49.RES:Rescheduling_interrupts
    179.20 ± 41%     -51.5%      87.00        interrupts.CPU50.RES:Rescheduling_interrupts
    122.80 ± 17%     -39.7%      74.00        interrupts.CPU51.RES:Rescheduling_interrupts
    123.60 ± 18%     -35.3%      80.00        interrupts.CPU53.RES:Rescheduling_interrupts
    141.20 ± 19%     +76.3%     249.00        interrupts.CPU57.RES:Rescheduling_interrupts
      5820 ± 30%     -38.3%       3590        interrupts.CPU58.NMI:Non-maskable_interrupts
      5820 ± 30%     -38.3%       3590        interrupts.CPU58.PMI:Performance_monitoring_interrupts
    148.20 ± 33%     -69.0%      46.00        interrupts.CPU59.RES:Rescheduling_interrupts
    339.40 ± 14%    +158.7%     878.00        interrupts.CPU6.RES:Rescheduling_interrupts
      3594          +100.6%       7211        interrupts.CPU60.NMI:Non-maskable_interrupts
      3594          +100.6%       7211        interrupts.CPU60.PMI:Performance_monitoring_interrupts
    165.40 ± 16%     -46.8%      88.00        interrupts.CPU60.RES:Rescheduling_interrupts
    119.60 ± 13%     -32.3%      81.00        interrupts.CPU65.RES:Rescheduling_interrupts
      6569 ± 22%     -45.8%       3559        interrupts.CPU68.NMI:Non-maskable_interrupts
      6569 ± 22%     -45.8%       3559        interrupts.CPU68.PMI:Performance_monitoring_interrupts
    149.60 ± 18%     -53.9%      69.00        interrupts.CPU68.RES:Rescheduling_interrupts
    124.60 ± 23%     -55.1%      56.00        interrupts.CPU69.RES:Rescheduling_interrupts
    351.40 ± 21%     -19.7%     282.00        interrupts.CPU7.RES:Rescheduling_interrupts
      5826 ± 31%     -38.5%       3584        interrupts.CPU76.NMI:Non-maskable_interrupts
      5826 ± 31%     -38.5%       3584        interrupts.CPU76.PMI:Performance_monitoring_interrupts
      3615          +100.9%       7263        interrupts.CPU80.NMI:Non-maskable_interrupts
      3615          +100.9%       7263        interrupts.CPU80.PMI:Performance_monitoring_interrupts
      4325 ± 32%     +66.8%       7216        interrupts.CPU81.NMI:Non-maskable_interrupts
      4325 ± 32%     +66.8%       7216        interrupts.CPU81.PMI:Performance_monitoring_interrupts
    114.20 ± 22%     -39.6%      69.00        interrupts.CPU81.RES:Rescheduling_interrupts
    120.00 ± 32%     -62.5%      45.00        interrupts.CPU83.RES:Rescheduling_interrupts
    293.40 ± 63%     -73.4%      78.00        interrupts.CPU86.RES:Rescheduling_interrupts
    126.20 ± 24%     -45.3%      69.00        interrupts.CPU89.RES:Rescheduling_interrupts
    311.00 ±  8%    +187.8%     895.00        interrupts.CPU9.RES:Rescheduling_interrupts
    175.60 ± 31%     -55.6%      78.00        interrupts.CPU90.RES:Rescheduling_interrupts
    100.40 ± 29%     -29.3%      71.00        interrupts.CPU91.RES:Rescheduling_interrupts
    177.40 ± 16%     -58.9%      73.00        interrupts.CPU95.RES:Rescheduling_interrupts
    185.20 ± 38%     -50.9%      91.00        interrupts.CPU96.RES:Rescheduling_interrupts
    113.40 ± 12%     +20.8%     137.00        interrupts.CPU99.RES:Rescheduling_interrupts



***************************************************************************************************
lkp-knm01: 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
  gcc-7/performance/x86_64-rhel-7.6/thread/100%/debian-x86_64-20191114.cgz/lkp-knm01/sched_yield/will-it-scale/0x11

commit: 
  v5.7-rc3
  8aebfffacf ("configfs: fix config_item refcnt leak in configfs_rmdir()")

        v5.7-rc3 8aebfffacfa379ba400da573a5b 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          1:5          -20%            :4     dmesg.WARNING:at#for_ip_interrupt_entry/0x
         %stddev     %change         %stddev
             \          |                \  
    129619           +17.8%     152634        will-it-scale.per_thread_ops
  12586764 ±  6%    -100.0%       2.25 ± 72%  will-it-scale.time.involuntary_context_switches
    245608           -96.0%       9887        will-it-scale.time.maximum_resident_set_size
     57640 ±  4%     -89.4%       6105        will-it-scale.time.minor_page_faults
     28478          -100.0%       0.00        will-it-scale.time.percent_of_cpu_this_job_got
     74208          -100.0%       0.19 ±  7%  will-it-scale.time.system_time
     14260          -100.0%       0.25 ±  3%  will-it-scale.time.user_time
  37330584           +17.8%   43958990        will-it-scale.workload
   1348004           +11.0%    1496355        vmstat.memory.cache
   1228847           +11.3%    1368042        meminfo.Cached
   1096118           +12.8%    1236404        meminfo.Unevictable
    363.61          -100.0%       0.00        uptime.boot
     14062 ±  3%    -100.0%       0.00        uptime.idle
     45.55 ±  2%      +4.3%      47.52 ±  2%  boot-time.boot
     27.68 ±  4%      +7.5%      29.77 ±  3%  boot-time.dhcp
     11319 ±  3%      +5.0%      11886 ±  2%  boot-time.idle
    126266            +1.4%     127983        proc-vmstat.nr_anon_pages
    307237           +11.3%     341994        proc-vmstat.nr_file_pages
     29707            +7.7%      31999        proc-vmstat.nr_slab_reclaimable
    274029           +12.8%     309100        proc-vmstat.nr_unevictable
    274029           +12.8%     309100        proc-vmstat.nr_zone_unevictable
    991130            +1.2%    1003460        proc-vmstat.pgalloc_normal
    818717            +1.3%     829269        proc-vmstat.pgfault
    698116            +9.9%     767014        numa-meminfo.node0.FilePages
    565294           +12.4%     635266        numa-meminfo.node0.Unevictable
    530824           +13.2%     601139        numa-meminfo.node1.FilePages
     18760 ±  6%     +19.6%      22432 ±  5%  numa-meminfo.node1.KReclaimable
     10936           +14.3%      12504        numa-meminfo.node1.Mapped
    625411           +11.6%     698082        numa-meminfo.node1.MemUsed
     18760 ±  6%     +19.6%      22432 ±  5%  numa-meminfo.node1.SReclaimable
    530824           +13.2%     601139        numa-meminfo.node1.Unevictable
    174502            +9.9%     191744        numa-vmstat.node0.nr_file_pages
    141323           +12.4%     158816        numa-vmstat.node0.nr_unevictable
    141323           +12.4%     158816        numa-vmstat.node0.nr_zone_unevictable
    154664           +11.3%     172075        numa-vmstat.node0.numa_interleave
    132706           +13.2%     150284        numa-vmstat.node1.nr_file_pages
      2735           +14.3%       3124        numa-vmstat.node1.nr_mapped
      4690 ±  6%     +19.6%       5608 ±  5%  numa-vmstat.node1.nr_slab_reclaimable
    132706           +13.2%     150284        numa-vmstat.node1.nr_unevictable
    132706           +13.2%     150284        numa-vmstat.node1.nr_zone_unevictable
    155440           +11.1%     172714        numa-vmstat.node1.numa_hit
    154855           +11.2%     172128        numa-vmstat.node1.numa_interleave
    154868           +11.2%     172141        numa-vmstat.node1.numa_other
     56.00          +150.0%     140.00 ± 20%  slabinfo.btrfs_extent_map.active_objs
     56.00          +150.0%     140.00 ± 20%  slabinfo.btrfs_extent_map.num_objs
      1568            +9.7%       1720        slabinfo.inode_cache.active_slabs
     84716            +9.7%      92925        slabinfo.inode_cache.num_objs
      1568            +9.7%       1720        slabinfo.inode_cache.num_slabs
    524.80 ± 14%     -29.9%     368.00 ±  7%  slabinfo.kmalloc-rcl-128.active_objs
    524.80 ± 14%     -29.9%     368.00 ±  7%  slabinfo.kmalloc-rcl-128.num_objs
      6284 ±  4%     +28.9%       8098 ±  7%  slabinfo.kmalloc-rcl-64.active_objs
      6284 ±  4%     +28.9%       8098 ±  7%  slabinfo.kmalloc-rcl-64.num_objs
     28669           +16.0%      33247        slabinfo.radix_tree_node.active_objs
     28669           +16.0%      33247        slabinfo.radix_tree_node.num_objs
      1066 ± 10%    -100.0%       0.00        slabinfo.skbuff_ext_cache.active_objs
      1066 ± 10%    -100.0%       0.00        slabinfo.skbuff_ext_cache.num_objs
    945.80 ±  2%     +10.2%       1042 ±  6%  slabinfo.skbuff_fclone_cache.active_objs
    945.80 ±  2%     +10.2%       1042 ±  6%  slabinfo.skbuff_fclone_cache.num_objs
      2289 ±  2%     -14.9%       1947        sched_debug.cfs_rq:/.exec_clock.stddev
      4558 ±  8%     -10.1%       4098 ±  3%  sched_debug.cfs_rq:/.load.avg
     21597 ± 25%     -25.8%      16031 ±  4%  sched_debug.cfs_rq:/.load.stddev
    938759 ±  2%     -13.0%     816467 ±  3%  sched_debug.cfs_rq:/.min_vruntime.stddev
     35.32 ± 32%     +45.2%      51.30 ± 17%  sched_debug.cfs_rq:/.nr_spread_over.max
      2.90 ± 19%     +35.1%       3.92 ±  3%  sched_debug.cfs_rq:/.nr_spread_over.stddev
  -8467500           -16.3%   -7085934        sched_debug.cfs_rq:/.spread0.min
    641459 ±  5%     -12.2%     563287 ±  5%  sched_debug.cfs_rq:/.spread0.stddev
      1937 ±  3%     -14.2%       1662        sched_debug.cpu.clock.stddev
      1937 ±  3%     -14.2%       1662        sched_debug.cpu.clock_task.stddev
    229162 ± 14%     +15.5%     264772 ±  6%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.00 ±  2%     -14.6%       0.00        sched_debug.cpu.next_balance.stddev
  17032335           +15.7%   19705462        sched_debug.cpu.sched_count.avg
  41820934           +10.5%   46197041        sched_debug.cpu.sched_count.max
   9425674 ±  2%     +20.7%   11374378        sched_debug.cpu.sched_count.stddev
  17031308           +15.7%   19704439        sched_debug.cpu.yld_count.avg
  41819326           +10.5%   46194610        sched_debug.cpu.yld_count.max
   9425595 ±  2%     +20.7%   11374229        sched_debug.cpu.yld_count.stddev
      1645 ± 17%     -44.1%     919.00 ± 45%  interrupts.CPU1.RES:Rescheduling_interrupts
    126.40 ± 55%    +337.5%     553.00 ± 97%  interrupts.CPU101.RES:Rescheduling_interrupts
      1103 ± 95%     -77.4%     249.50 ± 29%  interrupts.CPU104.RES:Rescheduling_interrupts
      5548 ± 29%     -37.4%       3473        interrupts.CPU139.NMI:Non-maskable_interrupts
      5548 ± 29%     -37.4%       3473        interrupts.CPU139.PMI:Performance_monitoring_interrupts
      5486 ± 29%     -37.5%       3427        interrupts.CPU147.NMI:Non-maskable_interrupts
      5486 ± 29%     -37.5%       3427        interrupts.CPU147.PMI:Performance_monitoring_interrupts
      5554 ± 29%     -37.6%       3465        interrupts.CPU148.NMI:Non-maskable_interrupts
      5554 ± 29%     -37.6%       3465        interrupts.CPU148.PMI:Performance_monitoring_interrupts
    132.60 ± 33%     -59.5%      53.75 ± 25%  interrupts.CPU148.RES:Rescheduling_interrupts
    454.80 ± 28%     +27.7%     581.00 ± 17%  interrupts.CPU15.RES:Rescheduling_interrupts
     62.00 ± 85%    +127.0%     140.75 ± 69%  interrupts.CPU150.RES:Rescheduling_interrupts
     21.60 ±100%    +841.0%     203.25 ± 73%  interrupts.CPU161.RES:Rescheduling_interrupts
    307.00 ±137%     -95.5%      13.75 ± 48%  interrupts.CPU167.RES:Rescheduling_interrupts
      5547 ± 30%     -38.6%       3404        interrupts.CPU171.NMI:Non-maskable_interrupts
      5547 ± 30%     -38.6%       3404        interrupts.CPU171.PMI:Performance_monitoring_interrupts
    102.20 ± 35%     -90.5%       9.75 ± 18%  interrupts.CPU193.RES:Rescheduling_interrupts
    183.40 ± 70%     -79.4%      37.75 ± 46%  interrupts.CPU196.RES:Rescheduling_interrupts
      5638 ± 29%     -37.7%       3515        interrupts.CPU201.NMI:Non-maskable_interrupts
      5638 ± 29%     -37.7%       3515        interrupts.CPU201.PMI:Performance_monitoring_interrupts
    268.00 ± 45%    +140.2%     643.75 ± 51%  interrupts.CPU21.RES:Rescheduling_interrupts
      5463 ± 29%     -36.5%       3468        interrupts.CPU216.NMI:Non-maskable_interrupts
      5463 ± 29%     -36.5%       3468        interrupts.CPU216.PMI:Performance_monitoring_interrupts
    304.20 ± 34%    +109.8%     638.25 ± 24%  interrupts.CPU22.RES:Rescheduling_interrupts
    131.60 ± 88%     -66.2%      44.50 ± 49%  interrupts.CPU220.RES:Rescheduling_interrupts
     79.00 ± 25%     -50.0%      39.50 ± 64%  interrupts.CPU228.RES:Rescheduling_interrupts
    423.20 ± 41%     +97.7%     836.50 ± 27%  interrupts.CPU24.RES:Rescheduling_interrupts
    136.00 ± 38%     -78.1%      29.75 ± 84%  interrupts.CPU240.RES:Rescheduling_interrupts
     76.80 ± 61%     -74.0%      20.00 ± 68%  interrupts.CPU266.RES:Rescheduling_interrupts
    480.80 ± 54%     +81.8%     874.00 ± 14%  interrupts.CPU28.RES:Rescheduling_interrupts
    229.20 ± 43%    +218.2%     729.25 ± 90%  interrupts.CPU29.RES:Rescheduling_interrupts
    434.40 ± 95%    +105.7%     893.75 ± 47%  interrupts.CPU30.RES:Rescheduling_interrupts
      6433 ± 21%     -44.8%       3552        interrupts.CPU66.NMI:Non-maskable_interrupts
      6433 ± 21%     -44.8%       3552        interrupts.CPU66.PMI:Performance_monitoring_interrupts
    415.00 ± 55%     -79.0%      87.25 ± 16%  interrupts.CPU72.RES:Rescheduling_interrupts
    312.00 ± 34%     -54.6%     141.50 ± 37%  interrupts.CPU75.RES:Rescheduling_interrupts
    841.60 ± 29%     -43.8%     473.00 ± 24%  interrupts.CPU8.RES:Rescheduling_interrupts
      4127 ± 31%     +64.4%       6787        interrupts.CPU89.NMI:Non-maskable_interrupts
      4127 ± 31%     +64.4%       6787        interrupts.CPU89.PMI:Performance_monitoring_interrupts
    217.80 ± 31%     -59.5%      88.25 ± 58%  interrupts.CPU89.RES:Rescheduling_interrupts
    285.00 ± 66%     -79.6%      58.00 ± 63%  interrupts.CPU93.RES:Rescheduling_interrupts
     96.20 ± 53%     +81.1%     174.25 ± 47%  interrupts.CPU95.RES:Rescheduling_interrupts
    471.80 ± 40%    +210.9%       1466 ± 66%  interrupts.CPU98.RES:Rescheduling_interrupts
     10.39            -4.7        5.72 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.do_sched_yield.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.81            -4.3        7.56 ±  2%  perf-profile.calltrace.cycles-pp.update_rq_clock.__sched_text_start.schedule.__x64_sys_sched_yield.do_syscall_64
      5.25 ±  2%      -2.4        2.82 ±  3%  perf-profile.calltrace.cycles-pp.sched_clock.sched_clock_cpu.update_rq_clock.__sched_text_start.schedule
      6.08 ±  2%      -2.4        3.66 ±  3%  perf-profile.calltrace.cycles-pp.sched_clock_cpu.update_rq_clock.__sched_text_start.schedule.__x64_sys_sched_yield
      5.47 ±  2%      -2.4        3.05 ±  3%  perf-profile.calltrace.cycles-pp.native_sched_clock.sched_clock.sched_clock_cpu.update_rq_clock.__sched_text_start
      3.46            -2.1        1.41 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__sched_text_start.schedule.__x64_sys_sched_yield.do_syscall_64
     14.72            -2.0       12.71 ±  2%  perf-profile.calltrace.cycles-pp.do_sched_yield.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      1.94 ±  3%      -1.3        0.64 ±  4%  perf-profile.calltrace.cycles-pp.rcu_qs.rcu_note_context_switch.__sched_text_start.schedule.__x64_sys_sched_yield
      4.86 ± 12%      -1.2        3.62 ± 13%  perf-profile.calltrace.cycles-pp.apic_timer_interrupt.__raw_spin_unlock_irq.__sched_text_start.schedule.__x64_sys_sched_yield
      4.70 ± 11%      -1.2        3.48 ± 13%  perf-profile.calltrace.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.__raw_spin_unlock_irq.__sched_text_start.schedule
      5.60 ± 10%      -1.1        4.54 ± 10%  perf-profile.calltrace.cycles-pp.__raw_spin_unlock_irq.__sched_text_start.schedule.__x64_sys_sched_yield.do_syscall_64
      3.89 ± 11%      -1.0        2.87 ± 15%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt.__raw_spin_unlock_irq.__sched_text_start
     76.22            -0.9       75.35        perf-profile.calltrace.cycles-pp.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      2.75 ± 10%      -0.7        2.07 ± 15%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt.__raw_spin_unlock_irq
      1.48 ± 16%      -0.7        0.81 ± 65%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt
     81.87            -0.7       81.21        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      1.35 ± 18%      -0.6        0.71 ± 65%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt
      1.28 ± 18%      -0.6        0.67 ± 65%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      0.93 ± 19%      -0.6        0.36 ±101%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
     83.76            -0.5       83.26        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__sched_yield
      0.71 ± 13%      -0.4        0.30 ±100%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt.__sched_yield
      2.69 ±  2%      -0.4        2.33 ±  3%  perf-profile.calltrace.cycles-pp.rcu_note_context_switch.__sched_text_start.schedule.__x64_sys_sched_yield.do_syscall_64
      1.28 ±  2%      -0.2        1.04 ±  2%  perf-profile.calltrace.cycles-pp.__list_del_entry_valid.pick_next_task_fair.__sched_text_start.schedule.__x64_sys_sched_yield
      5.32            -0.2        5.09        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__sched_yield
      0.89 ± 14%      -0.2        0.67 ± 15%  perf-profile.calltrace.cycles-pp.apic_timer_interrupt.__sched_yield
      0.85 ± 13%      -0.2        0.64 ± 15%  perf-profile.calltrace.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.__sched_yield
      0.42 ± 50%      +0.1        0.55 ±  3%  perf-profile.calltrace.cycles-pp.check_cfs_rq_runtime.pick_next_task_fair.__sched_text_start.schedule.__x64_sys_sched_yield
      0.86 ±  2%      +0.2        1.02 ±  3%  perf-profile.calltrace.cycles-pp.fpregs_assert_state_consistent.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      1.36 ±  2%      +0.2        1.53 ±  3%  perf-profile.calltrace.cycles-pp.pick_next_entity.pick_next_task_fair.__sched_text_start.schedule.__x64_sys_sched_yield
      0.64 ±  2%      +0.2        0.82        perf-profile.calltrace.cycles-pp.update_min_vruntime.update_curr.pick_next_task_fair.__sched_text_start.schedule
      2.44            +0.4        2.80 ±  3%  perf-profile.calltrace.cycles-pp.__calc_delta.update_curr.pick_next_task_fair.__sched_text_start.schedule
     58.36            +0.5       58.86        perf-profile.calltrace.cycles-pp.__sched_text_start.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.61            +0.7        6.34        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__sched_yield
     60.37            +1.1       61.43        perf-profile.calltrace.cycles-pp.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      6.36 ±  2%      +1.8        8.11 ±  3%  perf-profile.calltrace.cycles-pp.cpuacct_charge.update_curr.pick_next_task_fair.__sched_text_start.schedule
     19.28            +3.6       22.89 ±  2%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__sched_text_start.schedule.__x64_sys_sched_yield.do_syscall_64
     12.50            +4.2       16.73 ±  2%  perf-profile.calltrace.cycles-pp.update_curr.pick_next_task_fair.__sched_text_start.schedule.__x64_sys_sched_yield
     14.19            -6.9        7.32 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
     12.08            -4.4        7.71 ±  2%  perf-profile.children.cycles-pp.update_rq_clock
      5.67 ±  2%      -2.5        3.19 ±  2%  perf-profile.children.cycles-pp.sched_clock
      6.25 ±  2%      -2.5        3.77 ±  2%  perf-profile.children.cycles-pp.sched_clock_cpu
      5.59 ±  2%      -2.5        3.11 ±  2%  perf-profile.children.cycles-pp.native_sched_clock
     14.75            -2.0       12.75 ±  2%  perf-profile.children.cycles-pp.do_sched_yield
      1.99 ±  3%      -1.3        0.67 ±  4%  perf-profile.children.cycles-pp.rcu_qs
      5.74 ± 10%      -1.1        4.66 ± 10%  perf-profile.children.cycles-pp.__raw_spin_unlock_irq
     76.26            -0.9       75.39        perf-profile.children.cycles-pp.__x64_sys_sched_yield
     82.34            -0.7       81.65        perf-profile.children.cycles-pp.do_syscall_64
     84.21            -0.5       83.67        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.75 ±  2%      -0.4        2.39 ±  3%  perf-profile.children.cycles-pp.rcu_note_context_switch
      1.32 ±  2%      -0.2        1.08 ±  2%  perf-profile.children.cycles-pp.__list_del_entry_valid
      5.94            -0.2        5.76        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.66 ±  9%      -0.1        0.54 ± 15%  perf-profile.children.cycles-pp.irq_exit
      0.28 ±  8%      -0.1        0.18 ± 16%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.17 ± 19%      -0.1        0.07 ± 72%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.16 ± 13%      -0.1        0.07 ± 64%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.20 ± 11%      -0.1        0.13 ± 10%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.10 ± 13%      -0.1        0.04 ±107%  perf-profile.children.cycles-pp.rcu_core
      0.05 ± 51%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.ret_from_intr
      0.61 ±  2%      +0.0        0.65 ±  2%  perf-profile.children.cycles-pp.check_cfs_rq_runtime
      0.06 ± 57%      +0.0        0.10 ± 25%  perf-profile.children.cycles-pp.irq_enter
      0.00            +0.1        0.10 ± 11%  perf-profile.children.cycles-pp.idle_cpu
      0.89            +0.2        1.05 ±  3%  perf-profile.children.cycles-pp.fpregs_assert_state_consistent
      1.48 ±  2%      +0.2        1.66 ±  3%  perf-profile.children.cycles-pp.pick_next_entity
      0.70 ±  2%      +0.2        0.89        perf-profile.children.cycles-pp.update_min_vruntime
      2.49            +0.4        2.85 ±  3%  perf-profile.children.cycles-pp.__calc_delta
     58.57            +0.5       59.08        perf-profile.children.cycles-pp.__sched_text_start
      4.87            +0.6        5.50        perf-profile.children.cycles-pp.entry_SYSCALL_64
     60.44            +1.1       61.50        perf-profile.children.cycles-pp.schedule
      6.49 ±  3%      +1.7        8.22 ±  2%  perf-profile.children.cycles-pp.cpuacct_charge
     19.54            +3.6       23.16 ±  2%  perf-profile.children.cycles-pp.pick_next_task_fair
     12.90 ±  2%      +4.2       17.12 ±  2%  perf-profile.children.cycles-pp.update_curr
     14.15            -6.9        7.28 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      5.30 ±  2%      -2.5        2.81 ±  2%  perf-profile.self.cycles-pp.native_sched_clock
      5.86            -1.9        3.96        perf-profile.self.cycles-pp.update_rq_clock
      1.95 ±  3%      -1.3        0.62 ±  5%  perf-profile.self.cycles-pp.rcu_qs
      3.39            -0.6        2.79 ±  2%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.97 ± 26%      -0.4        0.56 ± 21%  perf-profile.self.cycles-pp.hrtimer_interrupt
      1.29 ±  2%      -0.2        1.05 ±  2%  perf-profile.self.cycles-pp.__list_del_entry_valid
      5.92            -0.2        5.74        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.27 ±  9%      -0.1        0.18 ± 16%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.16 ± 13%      -0.1        0.07 ± 64%  perf-profile.self.cycles-pp.perf_event_task_tick
      0.19 ± 18%      -0.1        0.11 ± 40%  perf-profile.self.cycles-pp.task_tick_fair
      0.10 ± 19%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.20 ± 11%      -0.1        0.13 ± 10%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.20 ±  2%      +0.0        0.22 ±  3%  perf-profile.self.cycles-pp.__list_add_valid
      0.55            +0.0        0.58 ±  2%  perf-profile.self.cycles-pp.check_cfs_rq_runtime
      0.02 ±122%      +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.ret_from_intr
      0.97            +0.1        1.03 ±  2%  perf-profile.self.cycles-pp.yield_task_fair
      1.02            +0.1        1.11 ±  2%  perf-profile.self.cycles-pp.__x64_sys_sched_yield
      0.00            +0.1        0.09 ± 11%  perf-profile.self.cycles-pp.idle_cpu
      0.99 ±  2%      +0.2        1.15 ±  3%  perf-profile.self.cycles-pp.pick_next_entity
      0.83 ±  2%      +0.2        0.99 ±  3%  perf-profile.self.cycles-pp.fpregs_assert_state_consistent
      1.84            +0.2        2.00 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.73 ±  6%      +0.2        0.90        perf-profile.self.cycles-pp.__raw_spin_unlock_irq
      0.65 ±  2%      +0.2        0.84        perf-profile.self.cycles-pp.update_min_vruntime
      2.44            +0.4        2.79 ±  2%  perf-profile.self.cycles-pp.__calc_delta
      3.20            +0.4        3.61        perf-profile.self.cycles-pp.__sched_yield
      4.05            +0.5        4.58        perf-profile.self.cycles-pp.entry_SYSCALL_64
      1.79 ±  3%      +0.5        2.32 ±  2%  perf-profile.self.cycles-pp.schedule
      0.77            +1.0        1.73 ±  3%  perf-profile.self.cycles-pp.rcu_note_context_switch
      6.44 ±  3%      +1.7        8.17 ±  2%  perf-profile.self.cycles-pp.cpuacct_charge
      3.33 ±  2%      +2.0        5.29 ±  2%  perf-profile.self.cycles-pp.update_curr
      3.11 ±  2%      +2.7        5.79        perf-profile.self.cycles-pp.do_sched_yield
     14.98 ±  4%      +4.6       19.54 ±  2%  perf-profile.self.cycles-pp.__sched_text_start
    113119 ±  7%     +16.3%     131545 ±  4%  softirqs.CPU0.TIMER
    114026 ±  6%     -13.7%      98362 ±  3%  softirqs.CPU10.TIMER
    124842 ± 11%     +15.5%     144145 ±  4%  softirqs.CPU100.TIMER
    120351 ± 11%     +16.0%     139650 ±  4%  softirqs.CPU101.TIMER
    114377 ±  9%     +23.7%     141538        softirqs.CPU103.TIMER
    119810 ±  9%     +20.0%     143803        softirqs.CPU104.TIMER
    124302 ± 10%     +19.0%     147917 ±  2%  softirqs.CPU105.TIMER
    128843 ±  6%     +16.0%     149410 ±  2%  softirqs.CPU106.TIMER
    133894 ±  6%     +14.4%     153196        softirqs.CPU107.TIMER
    121089 ±  8%     +19.4%     144552 ±  2%  softirqs.CPU108.TIMER
    116435 ±  9%     +18.9%     138420 ±  6%  softirqs.CPU109.TIMER
    122605 ±  9%     +20.6%     147851 ±  2%  softirqs.CPU110.TIMER
    125118 ± 11%     +18.0%     147647 ±  3%  softirqs.CPU111.TIMER
    120414 ± 11%     +24.0%     149357 ±  4%  softirqs.CPU112.TIMER
    118061 ±  9%     +24.5%     147002 ±  2%  softirqs.CPU113.TIMER
    113262 ± 12%     +21.7%     137886 ±  4%  softirqs.CPU114.TIMER
    115072 ±  8%     +15.8%     133253 ±  2%  softirqs.CPU115.TIMER
    126037 ±  7%     +17.3%     147845 ±  3%  softirqs.CPU116.TIMER
    125201 ±  9%     +27.9%     160135 ±  5%  softirqs.CPU117.TIMER
    126815 ±  7%     +15.3%     146183 ±  3%  softirqs.CPU119.TIMER
    113033 ± 11%     +22.8%     138784 ±  5%  softirqs.CPU120.TIMER
    124716 ±  8%     +20.6%     150419 ±  9%  softirqs.CPU124.TIMER
    119654 ±  9%     +23.3%     147567 ±  2%  softirqs.CPU125.TIMER
    121689 ± 11%     +17.8%     143395 ±  3%  softirqs.CPU126.TIMER
    124001 ±  7%     +18.0%     146288        softirqs.CPU128.TIMER
    129333 ±  8%     +15.5%     149415 ±  2%  softirqs.CPU129.TIMER
    109263 ±  3%     +24.0%     135462 ±  4%  softirqs.CPU13.TIMER
    120280 ±  8%     +18.5%     142504 ±  2%  softirqs.CPU130.TIMER
    127568 ±  9%     +15.9%     147805 ±  2%  softirqs.CPU131.TIMER
    121492 ± 10%     +18.9%     144478 ±  3%  softirqs.CPU132.TIMER
    121701 ± 12%     +20.0%     146072 ±  4%  softirqs.CPU133.TIMER
    118584 ± 12%     +19.4%     141554 ±  2%  softirqs.CPU134.TIMER
    118139 ± 12%     +19.3%     140941 ±  8%  softirqs.CPU135.TIMER
    111559 ± 10%     +23.7%     137951 ±  8%  softirqs.CPU136.TIMER
    116550 ±  6%     +21.1%     141123 ±  4%  softirqs.CPU138.TIMER
    119925 ± 11%     +20.9%     145018 ±  3%  softirqs.CPU139.TIMER
    110559 ±  8%     +19.2%     131773 ±  4%  softirqs.CPU14.TIMER
    118476 ±  9%     +15.1%     136359 ±  2%  softirqs.CPU140.TIMER
    123705 ±  9%     +17.5%     145309 ±  2%  softirqs.CPU141.TIMER
    119453 ±  9%     +17.7%     140644 ±  2%  softirqs.CPU142.TIMER
    130404 ± 10%     +16.3%     151657 ±  2%  softirqs.CPU143.TIMER
    127286 ±  8%     +17.1%     149108 ±  2%  softirqs.CPU144.TIMER
    125136 ± 10%     +16.3%     145511        softirqs.CPU145.TIMER
    126142 ±  6%     +15.4%     145582 ±  2%  softirqs.CPU146.TIMER
    125707 ±  8%     +14.3%     143729 ±  2%  softirqs.CPU147.TIMER
    120985 ± 10%     +18.4%     143290 ±  3%  softirqs.CPU148.TIMER
    123289 ± 11%     +15.8%     142709 ±  3%  softirqs.CPU149.TIMER
    110288 ±  3%     +23.7%     136419 ±  2%  softirqs.CPU15.TIMER
    118787 ± 14%     +21.0%     143741 ±  3%  softirqs.CPU150.TIMER
    118711 ± 10%     +11.9%     132818 ±  6%  softirqs.CPU151.TIMER
    124926 ±  7%     +18.0%     147353 ±  2%  softirqs.CPU152.TIMER
    123757 ±  7%     +15.6%     143106 ±  2%  softirqs.CPU153.TIMER
    128552 ±  8%     +14.5%     147151 ±  2%  softirqs.CPU154.TIMER
    124377 ±  8%     +17.8%     146546        softirqs.CPU155.TIMER
    125536 ± 10%     +15.9%     145472 ±  2%  softirqs.CPU156.TIMER
    116239 ±  9%     +15.8%     134554 ±  3%  softirqs.CPU157.TIMER
    123726 ± 10%     +16.4%     143992 ±  4%  softirqs.CPU158.TIMER
    123210 ±  9%     +16.6%     143679 ±  2%  softirqs.CPU159.TIMER
    109481 ±  2%     +33.6%     146300 ±  4%  softirqs.CPU16.TIMER
    119827 ±  7%     +23.5%     148008        softirqs.CPU160.TIMER
    123247 ±  9%     +18.8%     146472 ±  2%  softirqs.CPU161.TIMER
    112096 ±  9%     +19.4%     133805 ±  3%  softirqs.CPU162.TIMER
    115002 ±  8%     +24.0%     142655 ±  3%  softirqs.CPU164.TIMER
    124289 ±  6%     +26.0%     156586        softirqs.CPU165.TIMER
    124167 ±  7%     +13.2%     140537        softirqs.CPU166.TIMER
    120607 ±  7%     +25.4%     151242        softirqs.CPU167.TIMER
    124851 ±  7%     +15.4%     144078        softirqs.CPU168.TIMER
    126304 ±  8%     +16.0%     146520        softirqs.CPU169.TIMER
    110273 ±  6%     +22.0%     134573 ±  3%  softirqs.CPU17.TIMER
    125873 ±  8%     +17.0%     147232        softirqs.CPU170.TIMER
    128114 ±  6%     +18.9%     152291        softirqs.CPU171.TIMER
    124202 ± 11%     +13.2%     140567 ±  3%  softirqs.CPU172.TIMER
    124056 ± 12%     +18.0%     146348 ±  3%  softirqs.CPU174.TIMER
    121501 ± 10%     +20.5%     146393 ±  2%  softirqs.CPU175.TIMER
    118121 ± 10%     +19.3%     140906 ±  3%  softirqs.CPU176.TIMER
    117434 ± 11%     +21.4%     142608 ±  3%  softirqs.CPU177.TIMER
    114173 ± 10%     +15.6%     131982 ±  3%  softirqs.CPU178.TIMER
    116001 ±  9%     +17.5%     136283 ±  2%  softirqs.CPU179.TIMER
    113960 ±  5%     +30.4%     148616 ±  2%  softirqs.CPU18.TIMER
    124274 ±  7%     +18.2%     146928 ±  2%  softirqs.CPU180.TIMER
    124996 ±  5%     +17.7%     147104 ±  2%  softirqs.CPU181.TIMER
    111019 ±  6%     +28.1%     142231 ±  3%  softirqs.CPU182.TIMER
    111383 ±  9%     +18.5%     131989 ±  2%  softirqs.CPU183.TIMER
    118735 ±  8%     +21.4%     144187 ±  2%  softirqs.CPU185.TIMER
    119430 ± 10%     +20.0%     143357 ±  2%  softirqs.CPU186.TIMER
    119779 ± 13%     +18.5%     141916 ±  2%  softirqs.CPU187.TIMER
    114844 ± 10%     +19.3%     137044 ±  5%  softirqs.CPU188.TIMER
    112217 ± 10%     +16.6%     130821 ±  4%  softirqs.CPU189.TIMER
    108078 ±  3%     +18.7%     128293 ±  2%  softirqs.CPU19.TIMER
    128086 ±  7%     +18.9%     152236 ±  2%  softirqs.CPU190.TIMER
    127315 ±  9%     +14.8%     146133        softirqs.CPU192.TIMER
    127602 ±  7%     +17.6%     150031 ±  2%  softirqs.CPU193.TIMER
    126385 ±  7%     +14.4%     144530        softirqs.CPU195.TIMER
    119831 ±  7%     +21.2%     145237 ±  2%  softirqs.CPU196.TIMER
    121831 ±  9%     +17.1%     142687 ±  3%  softirqs.CPU197.TIMER
    116601 ± 11%     +15.6%     134796 ±  5%  softirqs.CPU198.TIMER
    113355 ±  7%     +24.9%     141568        softirqs.CPU2.TIMER
    110416 ±  8%     +17.0%     129173 ±  4%  softirqs.CPU200.TIMER
    113086 ± 11%     +19.5%     135112 ±  5%  softirqs.CPU201.TIMER
    119543 ± 12%     +18.6%     141771 ±  2%  softirqs.CPU202.TIMER
    118165 ± 10%     +21.5%     143606 ±  2%  softirqs.CPU203.TIMER
    116981 ±  8%     +19.0%     139231 ±  2%  softirqs.CPU204.TIMER
    118396 ± 10%     +21.8%     144211 ±  2%  softirqs.CPU206.TIMER
    133254 ±  6%     +12.7%     150153 ±  2%  softirqs.CPU207.TIMER
    129492 ±  7%     +16.5%     150874 ±  3%  softirqs.CPU208.TIMER
    126629 ±  8%     +16.3%     147271 ±  2%  softirqs.CPU209.TIMER
    120427 ±  7%     +20.1%     144661 ±  2%  softirqs.CPU210.TIMER
    115844 ±  5%     +23.4%     142908 ±  2%  softirqs.CPU211.TIMER
    123594 ±  8%     +20.2%     148590 ±  3%  softirqs.CPU212.TIMER
    124179 ± 11%     +16.0%     144109 ±  3%  softirqs.CPU213.TIMER
    117713 ± 10%     +20.0%     141292 ±  3%  softirqs.CPU214.TIMER
    121682 ± 11%     +13.7%     138390        softirqs.CPU215.TIMER
    125855 ±  9%     +14.6%     144201 ±  2%  softirqs.CPU216.TIMER
    119457 ±  7%     +18.1%     141135 ±  2%  softirqs.CPU217.TIMER
    129515 ±  7%     +15.2%     149225 ±  2%  softirqs.CPU218.TIMER
    126641 ±  8%     +16.2%     147164        softirqs.CPU219.TIMER
    118461 ± 12%     +16.9%     138460 ±  4%  softirqs.CPU220.TIMER
    118142 ± 12%     +17.8%     139186 ±  4%  softirqs.CPU221.TIMER
    123028 ± 11%     +17.9%     145077 ±  4%  softirqs.CPU223.TIMER
    116760 ± 11%     +21.0%     141309 ±  4%  softirqs.CPU224.TIMER
    117769 ± 13%     +22.9%     144787 ±  2%  softirqs.CPU225.TIMER
    115921 ±  9%     +21.0%     140316 ±  3%  softirqs.CPU226.TIMER
    117756 ± 12%     +23.8%     145835 ±  4%  softirqs.CPU227.TIMER
    127787 ±  7%     +13.1%     144484 ±  3%  softirqs.CPU228.TIMER
    129622 ±  8%     +15.0%     149116        softirqs.CPU229.TIMER
    112443 ±  9%     +17.6%     132259 ±  6%  softirqs.CPU230.TIMER
    111976 ±  8%     +17.5%     131521 ±  4%  softirqs.CPU231.TIMER
    120500 ±  9%     +16.7%     140660 ±  3%  softirqs.CPU233.TIMER
    115604 ± 10%     +15.7%     133702 ±  3%  softirqs.CPU234.TIMER
    125051 ± 11%     +14.2%     142772 ±  2%  softirqs.CPU235.TIMER
    119846 ±  9%     +22.5%     146843 ±  2%  softirqs.CPU236.TIMER
    125549 ± 10%     +18.4%     148672 ±  3%  softirqs.CPU237.TIMER
    121442 ± 10%     +16.6%     141632 ±  2%  softirqs.CPU238.TIMER
    110362 ±  3%     +26.7%     139858 ±  2%  softirqs.CPU24.TIMER
    120794 ±  9%     +17.6%     141997        softirqs.CPU240.TIMER
    113824 ±  9%     +17.1%     133278 ±  3%  softirqs.CPU241.TIMER
    119687 ± 11%     +21.7%     145654        softirqs.CPU242.TIMER
    115912 ± 12%     +19.2%     138121        softirqs.CPU243.TIMER
    110237 ±  8%     +14.0%     125635 ±  7%  softirqs.CPU244.TIMER
    111771 ±  8%     +16.2%     129872 ±  6%  softirqs.CPU245.TIMER
    118060 ± 11%     +18.0%     139342 ±  2%  softirqs.CPU246.TIMER
    116693 ± 13%     +20.5%     140666        softirqs.CPU247.TIMER
    118072 ±  7%     +28.4%     151653        softirqs.CPU248.TIMER
    108763 ±  9%     +26.2%     137221        softirqs.CPU249.TIMER
    122016 ± 10%     +19.8%     146178        softirqs.CPU250.TIMER
    117815 ± 10%     +17.3%     138149        softirqs.CPU251.TIMER
    121858 ± 10%     +19.6%     145741 ±  3%  softirqs.CPU253.TIMER
    107240 ±  6%     +12.1%     120268 ±  4%  softirqs.CPU254.TIMER
    108103 ±  6%     +17.9%     127505 ±  5%  softirqs.CPU255.TIMER
    116381 ± 12%     +15.6%     134529 ±  2%  softirqs.CPU256.TIMER
    122438 ±  9%     +17.1%     143331 ±  3%  softirqs.CPU259.TIMER
    120442 ± 10%     +17.3%     141291 ±  3%  softirqs.CPU260.TIMER
    122688 ± 10%     +18.3%     145140 ±  2%  softirqs.CPU261.TIMER
    120694 ±  8%     +20.5%     145449 ±  3%  softirqs.CPU262.TIMER
    114187 ±  9%     +11.8%     127621 ±  3%  softirqs.CPU266.TIMER
    107478 ±  6%     +10.0%     118190 ±  6%  softirqs.CPU269.TIMER
    107966 ±  5%     +11.4%     120301 ±  7%  softirqs.CPU273.TIMER
    109304 ±  6%     +13.9%     124478 ±  4%  softirqs.CPU276.TIMER
    110399 ±  8%     +16.2%     128241 ±  5%  softirqs.CPU277.TIMER
    106029 ±  6%      +9.9%     116510 ±  7%  softirqs.CPU281.TIMER
    106824 ±  4%     +19.7%     127862 ±  9%  softirqs.CPU283.TIMER
    105328 ±  5%     +12.4%     118346 ±  9%  softirqs.CPU284.TIMER
     98787 ±  5%     +11.0%     109671 ±  4%  softirqs.CPU287.TIMER
    109815 ±  6%     +22.1%     134129 ±  4%  softirqs.CPU36.TIMER
    109122 ±  2%     +29.2%     140981 ±  4%  softirqs.CPU37.TIMER
    108522 ±  2%     +23.9%     134419 ±  4%  softirqs.CPU38.TIMER
    109707 ±  3%     +26.6%     138933 ±  4%  softirqs.CPU39.TIMER
    107644 ±  4%     +15.6%     124484 ±  5%  softirqs.CPU42.TIMER
    108155 ±  4%     +10.8%     119800 ±  7%  softirqs.CPU45.TIMER
    112088 ±  7%     +16.9%     130979 ±  6%  softirqs.CPU47.TIMER
    112818 ±  8%     +14.3%     128922 ±  6%  softirqs.CPU49.TIMER
    110167 ±  3%     +17.6%     129599 ±  4%  softirqs.CPU59.TIMER
    107521 ±  5%     +11.1%     119499 ±  3%  softirqs.CPU62.TIMER
    105396 ±  4%     +11.2%     117248 ±  7%  softirqs.CPU66.TIMER
    109136 ±  5%      +9.1%     119076 ±  3%  softirqs.CPU68.TIMER
    107512 ±  4%     +11.6%     120020 ±  5%  softirqs.CPU69.TIMER
    109104 ±  5%     +20.5%     131425 ±  6%  softirqs.CPU7.TIMER
    109245 ±  6%      +8.5%     118577 ±  3%  softirqs.CPU70.TIMER
    116561 ± 10%     +24.6%     145283 ±  3%  softirqs.CPU72.TIMER
     42353 ±  7%     -12.2%      37180 ±  9%  softirqs.CPU73.RCU
    119948 ± 12%     +15.9%     139063 ±  3%  softirqs.CPU73.TIMER
    110624 ±  7%     +20.1%     132912 ±  3%  softirqs.CPU74.TIMER
    115257 ± 12%     +19.8%     138101 ±  3%  softirqs.CPU75.TIMER
    119711 ± 12%     +16.5%     139480 ±  3%  softirqs.CPU76.TIMER
    117787 ± 12%     +19.3%     140577 ±  4%  softirqs.CPU77.TIMER
    117562 ±  9%     +19.8%     140828 ±  4%  softirqs.CPU80.TIMER
    116478 ±  8%     +18.3%     137819 ±  4%  softirqs.CPU81.TIMER
    124014 ± 11%     +13.9%     141248 ±  3%  softirqs.CPU82.TIMER
    120670 ± 10%     +17.8%     142089 ±  2%  softirqs.CPU83.TIMER
    117102 ±  7%     +23.9%     145050        softirqs.CPU85.TIMER
    125172 ±  8%     +18.8%     148643 ±  2%  softirqs.CPU86.TIMER
    121015 ±  8%     +21.2%     146694 ±  2%  softirqs.CPU87.TIMER
    127523 ± 10%     +14.4%     145924 ±  2%  softirqs.CPU88.TIMER
    119199 ± 11%     +17.0%     139463 ±  3%  softirqs.CPU90.TIMER
    125653 ±  9%     +18.7%     149146 ±  2%  softirqs.CPU92.TIMER
    121635 ± 10%     +21.5%     147752        softirqs.CPU93.TIMER
    121228 ±  8%     +22.1%     147960        softirqs.CPU95.TIMER
    111706 ±  8%     +16.4%     130048        softirqs.CPU96.TIMER
    115196 ± 11%     +16.1%     133731 ±  3%  softirqs.CPU97.TIMER
    121196 ± 13%     +20.3%     145771        softirqs.CPU98.TIMER
    126502 ± 11%     +18.8%     150267        softirqs.CPU99.TIMER
  33761845 ±  7%     +15.1%   38854076 ±  2%  softirqs.TIMER



***************************************************************************************************
lkp-knm01: 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
  gcc-7/performance/x86_64-rhel-7.6/process/100%/debian-x86_64-20191114.cgz/lkp-knm01/page_fault2/will-it-scale/0x11

commit: 
  v5.7-rc3
  8aebfffacf ("configfs: fix config_item refcnt leak in configfs_rmdir()")

        v5.7-rc3 8aebfffacfa379ba400da573a5b 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      1945           -14.1%       1671        will-it-scale.per_process_ops
    978.60 ±  7%     -99.8%       2.00 ± 50%  will-it-scale.time.involuntary_context_switches
    158244           -93.7%       9896        will-it-scale.time.maximum_resident_set_size
     87626           -93.0%       6109        will-it-scale.time.minor_page_faults
      6.80 ±  5%    -100.0%       0.00        will-it-scale.time.percent_of_cpu_this_job_got
     22.04           -99.2%       0.18        will-it-scale.time.system_time
    560392           -14.1%     481535        will-it-scale.workload
     90.00            -1.1%      89.00        vmstat.cpu.sy
     45.31 ±  4%      +5.6%      47.83 ±  2%  boot-time.boot
     11253 ±  4%      +6.3%      11962 ±  3%  boot-time.idle
    294444 ± 14%     -26.3%     217051 ±  4%  meminfo.Mapped
   1096009           +12.9%    1236982        meminfo.Unevictable
      7.71            +0.9        8.60        mpstat.cpu.all.idle%
      1.23 ±  4%      +0.3        1.55 ±  4%  mpstat.cpu.all.usr%
 2.043e+08 ±  4%     -15.5%  1.726e+08        numa-numastat.node0.local_node
 2.043e+08 ±  4%     -15.5%  1.726e+08        numa-numastat.node0.numa_hit
    430.09 ±  4%    -100.0%       0.00        uptime.boot
     16131 ±  3%    -100.0%       0.00        uptime.idle
      6498 ± 10%     +16.8%       7587 ±  5%  slabinfo.kmalloc-rcl-64.active_objs
      6498 ± 10%     +16.8%       7587 ±  5%  slabinfo.kmalloc-rcl-64.num_objs
    706.80 ±  4%      +9.6%     775.00 ±  4%  slabinfo.numa_policy.active_objs
    706.80 ±  4%      +9.6%     775.00 ±  4%  slabinfo.numa_policy.num_objs
      1237 ± 13%    -100.0%       0.00        slabinfo.skbuff_ext_cache.active_objs
      1237 ± 13%    -100.0%       0.00        slabinfo.skbuff_ext_cache.num_objs
    282427 ± 14%     -27.3%     205355 ±  5%  numa-meminfo.node0.Mapped
    565175           +12.5%     635871        numa-meminfo.node0.Unevictable
    530833           +13.2%     601112        numa-meminfo.node1.FilePages
     17652 ±  6%     +20.6%      21280 ±  7%  numa-meminfo.node1.KReclaimable
     11323           +13.6%      12867        numa-meminfo.node1.Mapped
    623495           +11.8%     696907        numa-meminfo.node1.MemUsed
     17652 ±  6%     +20.6%      21280 ±  7%  numa-meminfo.node1.SReclaimable
     32701 ±  5%      +9.5%      35810 ±  5%  numa-meminfo.node1.Slab
    530833           +13.2%     601111        numa-meminfo.node1.Unevictable
    107.40 ± 45%     +31.3%     141.00        proc-vmstat.nr_isolated_anon
     74270 ± 15%     -26.0%      54987 ±  4%  proc-vmstat.nr_mapped
     49908            +3.7%      51731        proc-vmstat.nr_slab_reclaimable
    274002           +12.9%     309245        proc-vmstat.nr_unevictable
    274002           +12.9%     309245        proc-vmstat.nr_zone_unevictable
    109.00 ± 40%   +1585.8%       1837 ± 89%  proc-vmstat.numa_hint_faults
    109.00 ± 40%   +1585.8%       1837 ± 89%  proc-vmstat.numa_hint_faults_local
 2.043e+08 ±  4%     -15.5%  1.726e+08        proc-vmstat.numa_hit
 2.043e+08 ±  4%     -15.5%  1.726e+08        proc-vmstat.numa_local
     57344 ± 38%     +89.4%     108606 ±  3%  proc-vmstat.numa_pte_updates
     59052 ±121%     -99.5%     311.50        proc-vmstat.pgactivate
 2.002e+08 ±  4%     -15.3%  1.695e+08        proc-vmstat.pgalloc_normal
 1.942e+08 ±  5%     -16.3%  1.626e+08        proc-vmstat.pgfault
 2.037e+08 ±  4%     -15.4%  1.722e+08        proc-vmstat.pgfree
    113.20 ± 46%     +30.7%     148.00 ±  6%  numa-vmstat.node0.nr_isolated_anon
     70785 ± 14%     -29.7%      49758 ±  3%  numa-vmstat.node0.nr_mapped
    141293           +12.5%     158966        numa-vmstat.node0.nr_unevictable
    141293           +12.5%     158966        numa-vmstat.node0.nr_zone_unevictable
 1.107e+08 ±  4%     -15.3%   93735997        numa-vmstat.node0.numa_hit
    154693           +11.3%     172115        numa-vmstat.node0.numa_interleave
 1.107e+08 ±  4%     -15.3%   93737665        numa-vmstat.node0.numa_local
    132708           +13.2%     150278        numa-vmstat.node1.nr_file_pages
      2836           +13.6%       3222        numa-vmstat.node1.nr_mapped
      4413 ±  6%     +20.6%       5320 ±  7%  numa-vmstat.node1.nr_slab_reclaimable
    132708           +13.2%     150277        numa-vmstat.node1.nr_unevictable
    132708           +13.2%     150277        numa-vmstat.node1.nr_zone_unevictable
    155429           +11.1%     172634        numa-vmstat.node1.numa_hit
    154844           +11.1%     172048        numa-vmstat.node1.numa_interleave
    154857           +11.1%     172060        numa-vmstat.node1.numa_other
     64.47 ±  9%     -26.9%      47.16 ± 12%  sched_debug.cfs_rq:/.nr_spread_over.avg
     39.33 ±  8%     -25.7%      29.23 ± 15%  sched_debug.cfs_rq:/.nr_spread_over.min
 -10184167           -37.1%   -6401034        sched_debug.cfs_rq:/.spread0.min
      1352 ±  6%     +14.2%       1544        sched_debug.cfs_rq:/.util_avg.max
    140.69 ±  9%     +16.3%     163.69 ±  5%  sched_debug.cfs_rq:/.util_avg.stddev
   5737899 ±  8%     +22.0%    7002653 ±  2%  sched_debug.cpu.avg_idle.avg
  25342220 ±  7%     +23.9%   31404672        sched_debug.cpu.avg_idle.max
   4341642 ±  5%     +26.7%    5499420        sched_debug.cpu.avg_idle.stddev
    614.61 ±  5%     +11.8%     687.14 ±  2%  sched_debug.cpu.curr->pid.stddev
   2726049 ±  8%     +24.7%    3400632        sched_debug.cpu.max_idle_balance_cost.avg
  11766110 ±  4%     +21.6%   14305126        sched_debug.cpu.max_idle_balance_cost.max
   2097272 ±  6%     +28.6%    2698037        sched_debug.cpu.max_idle_balance_cost.stddev
      0.00 ± 12%     -46.1%       0.00 ±  4%  sched_debug.cpu.next_balance.stddev
     17846 ± 11%     -17.3%      14763 ±  3%  sched_debug.cpu.nr_switches.max
      0.00 ± 55%    +134.9%       0.00 ±  2%  sched_debug.cpu.nr_uninterruptible.avg
    237.17 ±  8%     -20.9%     187.48 ±  7%  sched_debug.cpu.ttwu_count.min
     11.28 ±  4%      -8.8        2.53 ± 32%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     11.28 ±  4%      -8.8        2.53 ± 32%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.98 ±  4%      -8.7        2.26 ± 35%  perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.98 ±  4%      -8.7        2.26 ± 35%  perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.44 ±  2%      -0.3        3.12 ±  3%  perf-profile.calltrace.cycles-pp.tlb_flush_mmu.tlb_finish_mmu.unmap_region.__do_munmap.__vm_munmap
      3.44 ±  2%      -0.3        3.12 ±  3%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap
      3.42 ±  2%      -0.3        3.12 ±  3%  perf-profile.calltrace.cycles-pp.release_pages.tlb_flush_mmu.tlb_finish_mmu.unmap_region.__do_munmap
      3.40 ±  2%      -0.3        3.10 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.release_pages.tlb_flush_mmu.tlb_finish_mmu
      3.40 ±  2%      -0.3        3.10 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.release_pages.tlb_flush_mmu.tlb_finish_mmu.unmap_region
     19.79 ±  2%      +8.4       28.19 ±  4%  perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.munmap
     19.79 ±  2%      +8.4       28.19 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.munmap
     19.82 ±  2%      +8.4       28.23 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.munmap
     19.82 ±  2%      +8.4       28.23 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.munmap
     19.82 ±  2%      +8.4       28.23 ±  4%  perf-profile.calltrace.cycles-pp.munmap
      0.19 ± 34%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.free_unref_page_list
      0.15 ± 35%      -0.1        0.06        perf-profile.children.cycles-pp.free_pcppages_bulk
     19.82 ±  2%      +8.4       28.23 ±  4%  perf-profile.children.cycles-pp.munmap
     30744 ± 22%     +20.4%      37021 ± 19%  softirqs.CPU0.SCHED
     40150 ±  6%     -14.2%      34450 ±  3%  softirqs.CPU10.TIMER
     40980 ±  5%     -12.6%      35798 ±  4%  softirqs.CPU102.TIMER
     41457 ±  9%     -14.0%      35671 ±  3%  softirqs.CPU11.TIMER
     40837 ±  6%     -13.0%      35533 ±  3%  softirqs.CPU116.TIMER
      2991 ±  7%    +137.4%       7100 ± 56%  softirqs.CPU118.SCHED
     40675 ±  4%     -13.3%      35251 ±  3%  softirqs.CPU125.TIMER
      2916 ± 11%    +218.9%       9298 ± 66%  softirqs.CPU153.SCHED
     43448 ±  9%     -15.7%      36639 ±  3%  softirqs.CPU16.TIMER
      2948 ± 12%    +131.9%       6838 ± 56%  softirqs.CPU165.SCHED
     39548 ±  5%     -12.3%      34675        softirqs.CPU187.TIMER
     43043 ± 13%     -18.2%      35210 ±  3%  softirqs.CPU193.TIMER
     44340 ±  8%     -18.1%      36293 ±  2%  softirqs.CPU2.TIMER
     42478 ± 14%     -16.6%      35430        softirqs.CPU200.TIMER
     40184 ±  4%     -11.6%      35535 ±  3%  softirqs.CPU213.TIMER
      2891 ± 15%    +125.4%       6517 ± 57%  softirqs.CPU221.SCHED
      4677 ± 69%     -46.1%       2522 ±  2%  softirqs.CPU239.SCHED
     39582 ±  4%     -12.0%      34848 ±  2%  softirqs.CPU264.TIMER
     39242 ±  3%     -12.1%      34500 ±  2%  softirqs.CPU273.TIMER
     39720 ±  5%     -11.0%      35370        softirqs.CPU274.TIMER
     39463 ±  5%     -14.5%      33747 ±  3%  softirqs.CPU275.TIMER
     39046 ±  5%     -11.1%      34704 ±  2%  softirqs.CPU282.TIMER
     39107 ±  5%     -12.9%      34052 ±  3%  softirqs.CPU284.TIMER
     39427 ±  4%     -12.2%      34614        softirqs.CPU285.TIMER
     38657 ±  5%     -14.5%      33049        softirqs.CPU286.TIMER
     40552 ±  4%     -11.7%      35817 ±  3%  softirqs.CPU32.TIMER
      2980 ±  8%    +292.0%      11681 ± 72%  softirqs.CPU47.SCHED
     41953 ±  9%     -13.9%      36109 ±  4%  softirqs.CPU50.TIMER
     40401 ±  4%     -11.1%      35926 ±  2%  softirqs.CPU56.TIMER
     42468 ±  8%     -14.4%      36338 ±  4%  softirqs.CPU58.TIMER
     43418 ± 10%     -17.0%      36044        softirqs.CPU60.TIMER
      2199 ±  4%    +185.4%       6278 ± 63%  softirqs.CPU71.RCU
     40825 ±  3%     -12.2%      35851 ±  3%  softirqs.CPU72.TIMER
      2814 ± 12%    +154.9%       7174 ± 56%  softirqs.CPU78.SCHED
     44413 ± 31%     +20.6%      53565 ± 24%  interrupts.CPU0.RES:Rescheduling_interrupts
      1311 ± 24%     -89.3%     140.00 ± 71%  interrupts.CPU1.RES:Rescheduling_interrupts
     25362 ± 49%     +47.1%      37320 ± 36%  interrupts.CPU10.NMI:Non-maskable_interrupts
     25362 ± 49%     +47.1%      37320 ± 36%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
     23833 ± 44%     +50.0%      35755 ± 38%  interrupts.CPU100.NMI:Non-maskable_interrupts
     23833 ± 44%     +50.0%      35755 ± 38%  interrupts.CPU100.PMI:Performance_monitoring_interrupts
     21886 ± 55%     +57.9%      34568 ± 26%  interrupts.CPU101.NMI:Non-maskable_interrupts
     21886 ± 55%     +57.9%      34568 ± 26%  interrupts.CPU101.PMI:Performance_monitoring_interrupts
    115.60 ± 67%     -68.9%      36.00 ± 13%  interrupts.CPU102.RES:Rescheduling_interrupts
     17917 ± 40%     +90.8%      34188 ± 25%  interrupts.CPU107.NMI:Non-maskable_interrupts
     17917 ± 40%     +90.8%      34188 ± 25%  interrupts.CPU107.PMI:Performance_monitoring_interrupts
    116731 ±  6%      -9.9%     105211        interrupts.CPU108.LOC:Local_timer_interrupts
    113992 ±  3%     -10.3%     102241        interrupts.CPU109.LOC:Local_timer_interrupts
    117808           -10.7%     105251        interrupts.CPU113.LOC:Local_timer_interrupts
     23944 ± 43%     +51.1%      36178 ± 39%  interrupts.CPU113.NMI:Non-maskable_interrupts
     23944 ± 43%     +51.1%      36178 ± 39%  interrupts.CPU113.PMI:Performance_monitoring_interrupts
    112586 ±  2%      -9.6%     101751        interrupts.CPU115.LOC:Local_timer_interrupts
     17938 ± 39%     +92.1%      34458 ± 25%  interrupts.CPU115.NMI:Non-maskable_interrupts
     17938 ± 39%     +92.1%      34458 ± 25%  interrupts.CPU115.PMI:Performance_monitoring_interrupts
    119013 ±  3%     -12.4%     104204        interrupts.CPU116.LOC:Local_timer_interrupts
     23941 ± 46%     +44.6%      34625 ± 24%  interrupts.CPU116.NMI:Non-maskable_interrupts
     23941 ± 46%     +44.6%      34625 ± 24%  interrupts.CPU116.PMI:Performance_monitoring_interrupts
     62.60 ± 46%     -55.3%      28.00 ±  7%  interrupts.CPU117.RES:Rescheduling_interrupts
     22842 ± 42%     +52.1%      34744 ± 27%  interrupts.CPU118.NMI:Non-maskable_interrupts
     22842 ± 42%     +52.1%      34744 ± 27%  interrupts.CPU118.PMI:Performance_monitoring_interrupts
     55.40 ± 60%  +14820.6%       8266 ± 98%  interrupts.CPU118.RES:Rescheduling_interrupts
    119354 ±  7%     -14.2%     102437        interrupts.CPU119.LOC:Local_timer_interrupts
     21602 ± 17%     +69.2%      36544 ± 39%  interrupts.CPU119.NMI:Non-maskable_interrupts
     21602 ± 17%     +69.2%      36544 ± 39%  interrupts.CPU119.PMI:Performance_monitoring_interrupts
     19795 ± 31%     +85.9%      36795 ± 40%  interrupts.CPU122.NMI:Non-maskable_interrupts
     19795 ± 31%     +85.9%      36795 ± 40%  interrupts.CPU122.PMI:Performance_monitoring_interrupts
      2230 ±182%     -98.3%      37.00        interrupts.CPU122.RES:Rescheduling_interrupts
     23701 ± 46%     +52.3%      36100 ± 39%  interrupts.CPU123.NMI:Non-maskable_interrupts
     23701 ± 46%     +52.3%      36100 ± 39%  interrupts.CPU123.PMI:Performance_monitoring_interrupts
      3061 ±175%     -99.0%      31.50 ± 11%  interrupts.CPU124.RES:Rescheduling_interrupts
    120574 ±  5%     -13.6%     104157 ±  2%  interrupts.CPU126.LOC:Local_timer_interrupts
     23625 ± 46%     +45.5%      34373 ± 25%  interrupts.CPU126.NMI:Non-maskable_interrupts
     23625 ± 46%     +45.5%      34373 ± 25%  interrupts.CPU126.PMI:Performance_monitoring_interrupts
    117690 ±  4%     -14.2%     100992        interrupts.CPU127.LOC:Local_timer_interrupts
     26834 ± 31%     +38.1%      37049 ± 30%  interrupts.CPU13.NMI:Non-maskable_interrupts
     26834 ± 31%     +38.1%      37049 ± 30%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
     23710 ± 46%     +46.9%      34829 ± 26%  interrupts.CPU131.NMI:Non-maskable_interrupts
     23710 ± 46%     +46.9%      34829 ± 26%  interrupts.CPU131.PMI:Performance_monitoring_interrupts
    121993 ±  6%     -19.3%      98444        interrupts.CPU132.LOC:Local_timer_interrupts
    118641 ±  5%     -13.3%     102859        interrupts.CPU133.LOC:Local_timer_interrupts
    116855 ±  5%     -15.2%      99116        interrupts.CPU135.LOC:Local_timer_interrupts
     21994 ± 56%     +65.0%      36281 ± 39%  interrupts.CPU136.NMI:Non-maskable_interrupts
     21994 ± 56%     +65.0%      36281 ± 39%  interrupts.CPU136.PMI:Performance_monitoring_interrupts
     24176 ± 46%     +50.0%      36269 ± 39%  interrupts.CPU137.NMI:Non-maskable_interrupts
     24176 ± 46%     +50.0%      36269 ± 39%  interrupts.CPU137.PMI:Performance_monitoring_interrupts
     19777 ± 31%     +85.4%      36666 ± 40%  interrupts.CPU139.NMI:Non-maskable_interrupts
     19777 ± 31%     +85.4%      36666 ± 40%  interrupts.CPU139.PMI:Performance_monitoring_interrupts
     27476 ± 37%     +74.8%      48017 ±  7%  interrupts.CPU14.NMI:Non-maskable_interrupts
     27476 ± 37%     +74.8%      48017 ±  7%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
     17615 ± 39%     +95.8%      34493 ± 28%  interrupts.CPU141.NMI:Non-maskable_interrupts
     17615 ± 39%     +95.8%      34493 ± 28%  interrupts.CPU141.PMI:Performance_monitoring_interrupts
     19759 ± 31%     +82.6%      36089 ± 38%  interrupts.CPU142.NMI:Non-maskable_interrupts
     19759 ± 31%     +82.6%      36089 ± 38%  interrupts.CPU142.PMI:Performance_monitoring_interrupts
     47.60 ± 22%  +15915.8%       7623 ± 98%  interrupts.CPU143.RES:Rescheduling_interrupts
     21504 ± 56%     +59.1%      34204 ± 28%  interrupts.CPU145.NMI:Non-maskable_interrupts
     21504 ± 56%     +59.1%      34204 ± 28%  interrupts.CPU145.PMI:Performance_monitoring_interrupts
    121982 ±  9%     -14.0%     104947 ±  2%  interrupts.CPU146.LOC:Local_timer_interrupts
    121216 ±  4%     -12.6%     105990        interrupts.CPU148.LOC:Local_timer_interrupts
     66.60 ± 57%    +795.6%     596.50 ± 82%  interrupts.CPU148.RES:Rescheduling_interrupts
    119881 ±  3%     -13.4%     103848        interrupts.CPU15.LOC:Local_timer_interrupts
     58.60 ± 73%   +9627.0%       5700 ± 56%  interrupts.CPU152.RES:Rescheduling_interrupts
     62.60 ± 20%  +19400.8%      12207 ± 99%  interrupts.CPU153.RES:Rescheduling_interrupts
     62.80 ± 44%    +117.4%     136.50 ±  4%  interrupts.CPU154.RES:Rescheduling_interrupts
     81.40 ± 30%     +65.2%     134.50 ± 13%  interrupts.CPU157.RES:Rescheduling_interrupts
    122848 ±  5%     -14.8%     104642        interrupts.CPU158.LOC:Local_timer_interrupts
     18722 ± 29%     +78.7%      33462 ± 28%  interrupts.CPU160.NMI:Non-maskable_interrupts
     18722 ± 29%     +78.7%      33462 ± 28%  interrupts.CPU160.PMI:Performance_monitoring_interrupts
     54.80 ± 81%   +1773.2%       1026 ± 95%  interrupts.CPU164.RES:Rescheduling_interrupts
     51.80 ± 41%  +14703.1%       7668 ± 99%  interrupts.CPU165.RES:Rescheduling_interrupts
    119687 ±  3%     -14.5%     102376        interrupts.CPU167.LOC:Local_timer_interrupts
     19851 ± 18%     +66.0%      32947 ± 27%  interrupts.CPU167.NMI:Non-maskable_interrupts
     19851 ± 18%     +66.0%      32947 ± 27%  interrupts.CPU167.PMI:Performance_monitoring_interrupts
     20526 ± 53%     +62.9%      33435 ± 37%  interrupts.CPU168.NMI:Non-maskable_interrupts
     20526 ± 53%     +62.9%      33435 ± 37%  interrupts.CPU168.PMI:Performance_monitoring_interrupts
     22011 ± 42%     +55.3%      34182 ± 39%  interrupts.CPU169.NMI:Non-maskable_interrupts
     22011 ± 42%     +55.3%      34182 ± 39%  interrupts.CPU169.PMI:Performance_monitoring_interrupts
     16490 ± 43%    +105.5%      33884 ± 38%  interrupts.CPU175.NMI:Non-maskable_interrupts
     16490 ± 43%    +105.5%      33884 ± 38%  interrupts.CPU175.PMI:Performance_monitoring_interrupts
     98.80 ± 49%     -72.7%      27.00 ±  3%  interrupts.CPU175.RES:Rescheduling_interrupts
    119432 ±  6%     -15.3%     101195        interrupts.CPU177.LOC:Local_timer_interrupts
     21582 ± 42%     +97.4%      42614 ±  7%  interrupts.CPU180.NMI:Non-maskable_interrupts
     21582 ± 42%     +97.4%      42614 ±  7%  interrupts.CPU180.PMI:Performance_monitoring_interrupts
    119772 ±  3%     -13.7%     103342        interrupts.CPU183.LOC:Local_timer_interrupts
    114335 ±  5%     -10.8%     101938        interrupts.CPU184.LOC:Local_timer_interrupts
     22474 ± 43%     +91.1%      42954 ±  6%  interrupts.CPU184.NMI:Non-maskable_interrupts
     22474 ± 43%     +91.1%      42954 ±  6%  interrupts.CPU184.PMI:Performance_monitoring_interrupts
     67.00 ± 60%     -61.2%      26.00 ±  3%  interrupts.CPU184.RES:Rescheduling_interrupts
    117913 ±  5%     -10.6%     105418        interrupts.CPU185.LOC:Local_timer_interrupts
     20531 ± 54%     +51.4%      31081 ± 26%  interrupts.CPU185.NMI:Non-maskable_interrupts
     20531 ± 54%     +51.4%      31081 ± 26%  interrupts.CPU185.PMI:Performance_monitoring_interrupts
    114480 ±  2%     -13.8%      98655        interrupts.CPU187.LOC:Local_timer_interrupts
    117946 ±  7%     -13.1%     102502 ±  2%  interrupts.CPU188.LOC:Local_timer_interrupts
    117037 ±  6%     -12.1%     102841        interrupts.CPU189.LOC:Local_timer_interrupts
     20504 ± 54%     +53.6%      31491 ± 25%  interrupts.CPU189.NMI:Non-maskable_interrupts
     20504 ± 54%     +53.6%      31491 ± 25%  interrupts.CPU189.PMI:Performance_monitoring_interrupts
    119458 ±  5%     -16.3%      99979 ±  2%  interrupts.CPU191.LOC:Local_timer_interrupts
     17934 ± 35%     +84.9%      33158 ± 38%  interrupts.CPU191.NMI:Non-maskable_interrupts
     17934 ± 35%     +84.9%      33158 ± 38%  interrupts.CPU191.PMI:Performance_monitoring_interrupts
    117361 ±  4%     -11.9%     103355        interrupts.CPU193.LOC:Local_timer_interrupts
     19054 ± 37%     +65.3%      31490 ± 26%  interrupts.CPU193.NMI:Non-maskable_interrupts
     19054 ± 37%     +65.3%      31490 ± 26%  interrupts.CPU193.PMI:Performance_monitoring_interrupts
    744.20 ±175%     -94.4%      41.50 ± 18%  interrupts.CPU193.RES:Rescheduling_interrupts
    120732 ±  6%     -15.1%     102480        interrupts.CPU194.LOC:Local_timer_interrupts
     16696 ± 45%    +155.6%      42678 ±  7%  interrupts.CPU194.NMI:Non-maskable_interrupts
     16696 ± 45%    +155.6%      42678 ±  7%  interrupts.CPU194.PMI:Performance_monitoring_interrupts
     20990 ± 59%     +51.7%      31840 ± 41%  interrupts.CPU196.NMI:Non-maskable_interrupts
     20990 ± 59%     +51.7%      31840 ± 41%  interrupts.CPU196.PMI:Performance_monitoring_interrupts
    119369 ±  4%     -14.2%     102421 ±  3%  interrupts.CPU199.LOC:Local_timer_interrupts
     16633 ± 45%     +83.9%      30586 ± 27%  interrupts.CPU199.NMI:Non-maskable_interrupts
     16633 ± 45%     +83.9%      30586 ± 27%  interrupts.CPU199.PMI:Performance_monitoring_interrupts
    118932 ±  7%     -15.5%     100519 ±  3%  interrupts.CPU2.LOC:Local_timer_interrupts
     22407 ± 43%     +34.9%      30220 ± 29%  interrupts.CPU200.NMI:Non-maskable_interrupts
     22407 ± 43%     +34.9%      30220 ± 29%  interrupts.CPU200.PMI:Performance_monitoring_interrupts
    123037 ±  4%     -13.5%     106382 ±  3%  interrupts.CPU202.LOC:Local_timer_interrupts
    116719 ±  6%     -15.4%      98794        interrupts.CPU203.LOC:Local_timer_interrupts
    117259 ±  4%     -12.8%     102265        interrupts.CPU204.LOC:Local_timer_interrupts
     17009 ± 47%     +78.4%      30342 ± 24%  interrupts.CPU205.NMI:Non-maskable_interrupts
     17009 ± 47%     +78.4%      30342 ± 24%  interrupts.CPU205.PMI:Performance_monitoring_interrupts
      3714 ±196%     -99.3%      27.50 ± 20%  interrupts.CPU205.RES:Rescheduling_interrupts
     16910 ± 46%     +91.8%      32437 ± 42%  interrupts.CPU206.NMI:Non-maskable_interrupts
     16910 ± 46%     +91.8%      32437 ± 42%  interrupts.CPU206.PMI:Performance_monitoring_interrupts
    120037 ±  5%     -14.5%     102637 ±  2%  interrupts.CPU21.LOC:Local_timer_interrupts
    117963 ±  4%     -12.1%     103659        interrupts.CPU211.LOC:Local_timer_interrupts
     17939 ± 35%     +65.9%      29764 ± 23%  interrupts.CPU212.NMI:Non-maskable_interrupts
     17939 ± 35%     +65.9%      29764 ± 23%  interrupts.CPU212.PMI:Performance_monitoring_interrupts
    115452 ±  3%     -12.9%     100528        interrupts.CPU214.LOC:Local_timer_interrupts
    466.80 ±178%     -93.3%      31.50 ±  4%  interrupts.CPU217.RES:Rescheduling_interrupts
    121828 ±  5%     -18.3%      99577        interrupts.CPU218.LOC:Local_timer_interrupts
      1660 ±192%     -98.5%      24.50 ± 30%  interrupts.CPU218.RES:Rescheduling_interrupts
    122819 ±  5%     -13.2%     106581        interrupts.CPU22.LOC:Local_timer_interrupts
     50.40 ± 22%  +13769.0%       6990 ± 95%  interrupts.CPU221.RES:Rescheduling_interrupts
     17704 ± 35%     +64.8%      29176 ± 27%  interrupts.CPU222.NMI:Non-maskable_interrupts
     17704 ± 35%     +64.8%      29176 ± 27%  interrupts.CPU222.PMI:Performance_monitoring_interrupts
     61.00 ± 47%   +4351.6%       2715 ± 97%  interrupts.CPU222.RES:Rescheduling_interrupts
     41.80 ± 32%  +15075.8%       6343 ± 87%  interrupts.CPU224.RES:Rescheduling_interrupts
    117616 ±  7%     -13.1%     102187        interrupts.CPU225.LOC:Local_timer_interrupts
     56.40 ± 54%    +640.2%     417.50        interrupts.CPU225.RES:Rescheduling_interrupts
     25163 ± 43%     +57.1%      39525 ± 11%  interrupts.CPU227.NMI:Non-maskable_interrupts
     25163 ± 43%     +57.1%      39525 ± 11%  interrupts.CPU227.PMI:Performance_monitoring_interrupts
     76.60 ± 27%     -56.9%      33.00        interrupts.CPU228.RES:Rescheduling_interrupts
     35.20 ± 31%   +1846.0%     685.00 ± 78%  interrupts.CPU229.RES:Rescheduling_interrupts
     17795 ± 35%    +123.2%      39716 ±  8%  interrupts.CPU231.NMI:Non-maskable_interrupts
     17795 ± 35%    +123.2%      39716 ±  8%  interrupts.CPU231.PMI:Performance_monitoring_interrupts
    119991 ±  4%     -13.3%     104031        interrupts.CPU235.LOC:Local_timer_interrupts
     66.20 ± 97%    +659.1%     502.50 ± 90%  interrupts.CPU237.RES:Rescheduling_interrupts
    120331 ±  3%     -16.0%     101114        interrupts.CPU238.LOC:Local_timer_interrupts
      4018 ±122%     -99.3%      27.50        interrupts.CPU238.RES:Rescheduling_interrupts
    121416 ±  3%     -18.1%      99384 ±  3%  interrupts.CPU239.LOC:Local_timer_interrupts
    134.80 ± 74%     -69.6%      41.00 ± 41%  interrupts.CPU24.RES:Rescheduling_interrupts
    119296 ±  6%     -14.1%     102465        interrupts.CPU240.LOC:Local_timer_interrupts
      2321 ±192%     -99.2%      19.50 ±  7%  interrupts.CPU240.RES:Rescheduling_interrupts
     39.00 ± 62%   +2380.8%     967.50 ± 96%  interrupts.CPU243.RES:Rescheduling_interrupts
     16832 ± 48%    +133.0%      39225 ±  9%  interrupts.CPU244.NMI:Non-maskable_interrupts
     16832 ± 48%    +133.0%      39225 ±  9%  interrupts.CPU244.PMI:Performance_monitoring_interrupts
    114446 ±  5%     -12.4%     100302        interrupts.CPU247.LOC:Local_timer_interrupts
     45.80 ± 51%    +183.8%     130.00 ± 43%  interrupts.CPU247.RES:Rescheduling_interrupts
    116970 ±  8%     -15.8%      98458        interrupts.CPU248.LOC:Local_timer_interrupts
    117471 ±  7%     -13.7%     101346        interrupts.CPU249.LOC:Local_timer_interrupts
      2762 ±196%     -99.0%      28.50 ±  5%  interrupts.CPU249.RES:Rescheduling_interrupts
    122057 ±  6%     -12.0%     107449        interrupts.CPU25.LOC:Local_timer_interrupts
    115489 ±  5%     -15.0%      98109        interrupts.CPU253.LOC:Local_timer_interrupts
     24369 ± 41%     +63.0%      39726 ±  7%  interrupts.CPU253.NMI:Non-maskable_interrupts
     24369 ± 41%     +63.0%      39726 ±  7%  interrupts.CPU253.PMI:Performance_monitoring_interrupts
    119795 ±  3%     -13.9%     103127        interrupts.CPU255.LOC:Local_timer_interrupts
    114991 ±  3%     -11.3%     102052        interrupts.CPU257.LOC:Local_timer_interrupts
     19912 ± 49%     +45.4%      28955 ± 25%  interrupts.CPU259.NMI:Non-maskable_interrupts
     19912 ± 49%     +45.4%      28955 ± 25%  interrupts.CPU259.PMI:Performance_monitoring_interrupts
    126.80 ±122%    +917.4%       1290 ± 94%  interrupts.CPU259.RES:Rescheduling_interrupts
     17936 ± 37%     +59.6%      28626 ± 27%  interrupts.CPU260.NMI:Non-maskable_interrupts
     17936 ± 37%     +59.6%      28626 ± 27%  interrupts.CPU260.PMI:Performance_monitoring_interrupts
     21974 ± 51%     +78.4%      39200 ±  8%  interrupts.CPU261.NMI:Non-maskable_interrupts
     21974 ± 51%     +78.4%      39200 ±  8%  interrupts.CPU261.PMI:Performance_monitoring_interrupts
     37.80 ± 59%  +22356.3%       8488 ± 99%  interrupts.CPU261.RES:Rescheduling_interrupts
    115566 ±  4%     -12.6%     101038 ±  4%  interrupts.CPU263.LOC:Local_timer_interrupts
    117096 ±  4%     -13.8%     100936 ±  3%  interrupts.CPU264.LOC:Local_timer_interrupts
    115215 ±  5%     -11.6%     101842 ±  2%  interrupts.CPU265.LOC:Local_timer_interrupts
     16524 ± 46%     +72.2%      28453 ± 24%  interrupts.CPU265.NMI:Non-maskable_interrupts
     16524 ± 46%     +72.2%      28453 ± 24%  interrupts.CPU265.PMI:Performance_monitoring_interrupts
     16588 ± 46%     +75.8%      29154 ± 27%  interrupts.CPU269.NMI:Non-maskable_interrupts
     16588 ± 46%     +75.8%      29154 ± 27%  interrupts.CPU269.PMI:Performance_monitoring_interrupts
    119181 ±  3%     -12.3%     104485        interrupts.CPU270.LOC:Local_timer_interrupts
    126083 ±  3%     -18.6%     102582        interrupts.CPU271.LOC:Local_timer_interrupts
    120889 ±  4%     -10.4%     108294        interrupts.CPU274.LOC:Local_timer_interrupts
     20501 ± 61%     +86.6%      38253 ±  8%  interrupts.CPU274.NMI:Non-maskable_interrupts
     20501 ± 61%     +86.6%      38253 ±  8%  interrupts.CPU274.PMI:Performance_monitoring_interrupts
     43.60 ± 38%    +311.7%     179.50 ± 79%  interrupts.CPU274.RES:Rescheduling_interrupts
     20162 ± 27%     +90.5%      38419 ± 11%  interrupts.CPU276.NMI:Non-maskable_interrupts
     20162 ± 27%     +90.5%      38419 ± 11%  interrupts.CPU276.PMI:Performance_monitoring_interrupts
    469.60 ±180%     -94.5%      26.00 ± 23%  interrupts.CPU276.RES:Rescheduling_interrupts
    119850 ±  2%     -16.4%     100136 ±  2%  interrupts.CPU277.LOC:Local_timer_interrupts
     19782 ± 50%     +39.4%      27572 ± 22%  interrupts.CPU281.NMI:Non-maskable_interrupts
     19782 ± 50%     +39.4%      27572 ± 22%  interrupts.CPU281.PMI:Performance_monitoring_interrupts
     19467 ± 49%     +98.5%      38647 ± 11%  interrupts.CPU283.NMI:Non-maskable_interrupts
     19467 ± 49%     +98.5%      38647 ± 11%  interrupts.CPU283.PMI:Performance_monitoring_interrupts
    118186 ±  4%     -12.5%     103417        interrupts.CPU284.LOC:Local_timer_interrupts
     20890 ± 41%     +31.7%      27517 ± 22%  interrupts.CPU284.NMI:Non-maskable_interrupts
     20890 ± 41%     +31.7%      27517 ± 22%  interrupts.CPU284.PMI:Performance_monitoring_interrupts
     16703 ± 47%     +79.1%      29908 ± 42%  interrupts.CPU285.NMI:Non-maskable_interrupts
     16703 ± 47%     +79.1%      29908 ± 42%  interrupts.CPU285.PMI:Performance_monitoring_interrupts
    120367 ±  3%     -14.3%     103207 ±  3%  interrupts.CPU286.LOC:Local_timer_interrupts
    203105 ± 16%     -21.3%     159888        interrupts.CPU287.LOC:Local_timer_interrupts
    116843           -12.2%     102631        interrupts.CPU29.LOC:Local_timer_interrupts
     19918 ± 30%     +82.9%      36430 ± 26%  interrupts.CPU29.NMI:Non-maskable_interrupts
     19918 ± 30%     +82.9%      36430 ± 26%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
    115537 ±  5%     -12.8%     100799        interrupts.CPU31.LOC:Local_timer_interrupts
     24936 ± 14%     +42.8%      35617 ± 28%  interrupts.CPU31.NMI:Non-maskable_interrupts
     24936 ± 14%     +42.8%      35617 ± 28%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
    117133 ±  4%     -13.5%     101372        interrupts.CPU33.LOC:Local_timer_interrupts
     24316 ± 49%     +99.0%      48379 ±  4%  interrupts.CPU33.NMI:Non-maskable_interrupts
     24316 ± 49%     +99.0%      48379 ±  4%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
     26337 ± 39%     +86.4%      49100 ±  5%  interrupts.CPU35.NMI:Non-maskable_interrupts
     26337 ± 39%     +86.4%      49100 ±  5%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
     26228 ± 39%     +43.4%      37614 ± 39%  interrupts.CPU36.NMI:Non-maskable_interrupts
     26228 ± 39%     +43.4%      37614 ± 39%  interrupts.CPU36.PMI:Performance_monitoring_interrupts
    116348 ±  5%     -11.5%     102962        interrupts.CPU37.LOC:Local_timer_interrupts
     19410 ± 30%     +85.7%      36045 ± 28%  interrupts.CPU37.NMI:Non-maskable_interrupts
     19410 ± 30%     +85.7%      36045 ± 28%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
     22299 ± 28%    +115.7%      48099        interrupts.CPU39.NMI:Non-maskable_interrupts
     22299 ± 28%    +115.7%      48099        interrupts.CPU39.PMI:Performance_monitoring_interrupts
     20744 ± 27%     +72.7%      35832 ± 28%  interrupts.CPU4.NMI:Non-maskable_interrupts
     20744 ± 27%     +72.7%      35832 ± 28%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
    378.60 ± 83%    +694.8%       3009 ± 34%  interrupts.CPU4.RES:Rescheduling_interrupts
    118387 ±  4%     -10.7%     105718        interrupts.CPU40.LOC:Local_timer_interrupts
     25688 ± 35%     +47.2%      37822 ± 37%  interrupts.CPU40.NMI:Non-maskable_interrupts
     25688 ± 35%     +47.2%      37822 ± 37%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
    118362 ±  4%     -12.7%     103323 ±  2%  interrupts.CPU41.LOC:Local_timer_interrupts
     92.20 ± 94%     -74.0%      24.00 ±  4%  interrupts.CPU44.RES:Rescheduling_interrupts
    121354 ±  7%     -15.5%     102554 ±  2%  interrupts.CPU46.LOC:Local_timer_interrupts
    119439 ±  4%     -12.3%     104763 ±  3%  interrupts.CPU47.LOC:Local_timer_interrupts
    118786 ±  7%     -14.9%     101047        interrupts.CPU49.LOC:Local_timer_interrupts
    123.60 ± 51%   +3720.4%       4722 ± 96%  interrupts.CPU5.RES:Rescheduling_interrupts
    119935 ±  6%     -15.3%     101599 ±  2%  interrupts.CPU50.LOC:Local_timer_interrupts
     25639 ± 42%     +48.5%      38066 ± 38%  interrupts.CPU53.NMI:Non-maskable_interrupts
     25639 ± 42%     +48.5%      38066 ± 38%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
    123762 ±  6%     -17.3%     102351        interrupts.CPU55.LOC:Local_timer_interrupts
    120248 ±  6%     -15.6%     101459        interrupts.CPU61.LOC:Local_timer_interrupts
     27467 ± 31%     +33.8%      36765 ± 27%  interrupts.CPU61.NMI:Non-maskable_interrupts
     27467 ± 31%     +33.8%      36765 ± 27%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
     63.20 ± 38%   +2386.6%       1571 ± 90%  interrupts.CPU62.RES:Rescheduling_interrupts
    120083 ±  7%     -13.0%     104487        interrupts.CPU64.LOC:Local_timer_interrupts
     22757 ± 50%     +67.5%      38115 ± 39%  interrupts.CPU67.NMI:Non-maskable_interrupts
     22757 ± 50%     +67.5%      38115 ± 39%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
     25527 ± 54%     +90.2%      48549 ±  9%  interrupts.CPU73.NMI:Non-maskable_interrupts
     25527 ± 54%     +90.2%      48549 ±  9%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
      1079 ±187%     -96.2%      41.00 ±  7%  interrupts.CPU73.RES:Rescheduling_interrupts
    116963 ±  5%     -11.9%     103068        interrupts.CPU74.LOC:Local_timer_interrupts
    119414 ±  5%     -12.3%     104777        interrupts.CPU76.LOC:Local_timer_interrupts
     96.40 ± 93%   +8929.0%       8704 ± 99%  interrupts.CPU78.RES:Rescheduling_interrupts
    119473 ±  4%     -10.1%     107439        interrupts.CPU8.LOC:Local_timer_interrupts
    101.40 ± 40%   +1138.2%       1255 ± 90%  interrupts.CPU8.RES:Rescheduling_interrupts
    100.40 ± 35%   +2870.6%       2982 ±  8%  interrupts.CPU80.RES:Rescheduling_interrupts
     63.80 ± 18%   +1049.7%     733.50 ± 85%  interrupts.CPU81.RES:Rescheduling_interrupts
    121318 ±  6%     -12.7%     105910        interrupts.CPU82.LOC:Local_timer_interrupts
     20126 ± 26%     +67.5%      33715 ± 24%  interrupts.CPU83.NMI:Non-maskable_interrupts
     20126 ± 26%     +67.5%      33715 ± 24%  interrupts.CPU83.PMI:Performance_monitoring_interrupts
     67.20 ± 46%   +8900.7%       6048 ± 98%  interrupts.CPU84.RES:Rescheduling_interrupts
     20042 ± 27%     +79.5%      35969 ± 40%  interrupts.CPU86.NMI:Non-maskable_interrupts
     20042 ± 27%     +79.5%      35969 ± 40%  interrupts.CPU86.PMI:Performance_monitoring_interrupts
     50.80 ± 31%    +566.3%     338.50 ± 85%  interrupts.CPU88.RES:Rescheduling_interrupts
     22713 ± 17%     +66.5%      37828 ± 36%  interrupts.CPU9.NMI:Non-maskable_interrupts
     22713 ± 17%     +66.5%      37828 ± 36%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
    250.80 ±119%    +735.3%       2095 ± 70%  interrupts.CPU9.RES:Rescheduling_interrupts
     21922 ± 53%     +53.3%      33598 ± 25%  interrupts.CPU90.NMI:Non-maskable_interrupts
     21922 ± 53%     +53.3%      33598 ± 25%  interrupts.CPU90.PMI:Performance_monitoring_interrupts
     47.20 ± 39%    +280.3%     179.50 ± 70%  interrupts.CPU92.RES:Rescheduling_interrupts
     23428 ± 43%     +53.5%      35964 ± 40%  interrupts.CPU93.NMI:Non-maskable_interrupts
     23428 ± 43%     +53.5%      35964 ± 40%  interrupts.CPU93.PMI:Performance_monitoring_interrupts
    121016 ±  7%     -12.7%     105693 ±  2%  interrupts.CPU94.LOC:Local_timer_interrupts
     17635 ± 39%     +99.2%      35125 ± 40%  interrupts.CPU95.NMI:Non-maskable_interrupts
     17635 ± 39%     +99.2%      35125 ± 40%  interrupts.CPU95.PMI:Performance_monitoring_interrupts
     25621 ± 32%     +33.1%      34090 ± 27%  interrupts.CPU96.NMI:Non-maskable_interrupts
     25621 ± 32%     +33.1%      34090 ± 27%  interrupts.CPU96.PMI:Performance_monitoring_interrupts
    118451 ±  6%     -12.9%     103182        interrupts.CPU97.LOC:Local_timer_interrupts





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Rong Chen


--/6pUCPTUcpTjDznW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.7.0-rc3-00001-g8aebfffacfa37"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.7.0-rc3 Kernel Configuration
#

#
# Compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70500
CONFIG_LD_VERSION=234000000
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
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
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
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
# CONFIG_SCHED_THERMAL_PRESSURE is not set
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
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
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
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
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
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
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
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_LSM is not set
CONFIG_BPF_SYSCALL=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
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
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
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
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
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
CONFIG_X86_IOPL_IOPERM=y
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
CONFIG_X86_UMIP=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
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
# CONFIG_KEXEC_SIG is not set
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
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
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
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

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
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
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
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
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
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y

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
CONFIG_HAVE_ASM_MODVERSIONS=y
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
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
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
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
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
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
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
CONFIG_BLK_MQ_RDMA=y
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
CONFIG_NUMA_KEEP_MEMINFO=y
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
CONFIG_PAGE_REPORTING=y
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
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
# CONFIG_ZSWAP_DEFAULT_ON is not set
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
# CONFIG_DEVICE_PRIVATE is not set
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_REDIRECT=y
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
# CONFIG_SMC is not set
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
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
# CONFIG_INET_ESP_OFFLOAD is not set
# CONFIG_INET_ESPINTCP is not set
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
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
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
# CONFIG_NET_SCH_ETS is not set
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
# CONFIG_NET_TC_SKB_EXT is not set
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
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
# CONFIG_MPLS_ROUTING is not set
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
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
# CONFIG_CAN_J1939 is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
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
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
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
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
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
# CONFIG_NET_9P_RDMA is not set
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
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y
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
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
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
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_PM_QOS_KUNIT_TEST is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_KUNIT_DRIVER_PE_TEST=y
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
# CONFIG_MTD_AR7_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
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
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_RDMA is not set
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_RDMA is not set
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
# CONFIG_INTEL_MIC_BUS is not set
# CONFIG_SCIF_BUS is not set
# CONFIG_VOP_BUS is not set
# end of Intel MIC & related support

# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
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
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
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
# CONFIG_DM_CLONE is not set
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
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
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
# CONFIG_WIREGUARD is not set
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
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
CONFIG_MACSEC=m
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
CONFIG_VSOCKMON=m
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

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
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
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
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set
# CONFIG_MDIO_XPCS is not set
CONFIG_PHYLINK=m
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_SFP is not set
# CONFIG_ADIN_PHY is not set
CONFIG_AMD_PHY=m
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_BROADCOM_PHY=m
# CONFIG_BCM84881_PHY is not set
CONFIG_CICADA_PHY=m
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=m
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
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
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
CONFIG_ISDN=y
CONFIG_ISDN_CAPI=y
CONFIG_CAPI_TRACE=y
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
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
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
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y

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
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
# CONFIG_TRACE_SINK is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
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
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set
CONFIG_NVRAM=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_DEVPORT=y
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
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

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
CONFIG_I2C_SMBUS=y
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
CONFIG_I2C_I801=y
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
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

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
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
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
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=m
# CONFIG_PINCTRL_BROXTON is not set
CONFIG_PINCTRL_CANNONLAKE=m
# CONFIG_PINCTRL_CEDARFORK is not set
CONFIG_PINCTRL_DENVERTON=m
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
# CONFIG_PINCTRL_TIGERLAKE is not set
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

# CONFIG_GPIO_MOCKUP is not set
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
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_DRIVETEMP is not set
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
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
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
# CONFIG_SENSORS_MAX31730 is not set
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
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
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
# CONFIG_SENSORS_TMP513 is not set
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
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
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
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_IQS62X is not set
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
# CONFIG_LIRC is not set
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
# CONFIG_IR_IMON_DECODER is not set
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
# CONFIG_RC_LOOPBACK is not set
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
CONFIG_VIDEO_V4L2_I2C=y
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
CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=y
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# I2C drivers hidden by 'Autoselect ancillary drivers'
#

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_TDA7432=m
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
CONFIG_VIDEO_SAA711X=m

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m

#
# Camera sensor devices
#

#
# Lens drivers
#

#
# Flash devices
#

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
CONFIG_VIDEO_M52790=m

#
# SPI drivers hidden by 'Autoselect ancillary drivers'
#

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Tuner drivers hidden by 'Autoselect ancillary drivers'
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
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
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m

#
# DVB Frontend drivers hidden by 'Autoselect ancillary drivers'
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
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_GP8PSK_FE=m

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
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m

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
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_TTM_DMA_PAGE_POOL=y
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
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
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
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
# CONFIG_DRM_GM12U320 is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

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
# CONFIG_BACKLIGHT_QCOM_WLED is not set
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
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=m
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
# CONFIG_SND_BCM63XX_I2S_WHISTLER is not set
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
# CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES is not set
CONFIG_SND_SOC_INTEL_HASWELL_MACH=m
# CONFIG_SND_SOC_INTEL_BDW_RT5650_MACH is not set
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
CONFIG_SND_SOC_INTEL_DA7219_MAX98357A_GENERIC=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_COMMON=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH=m
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH is not set
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
# CONFIG_SND_SOC_ADAU7118_HW is not set
# CONFIG_SND_SOC_ADAU7118_I2C is not set
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
# CONFIG_SND_SOC_TAS2562 is not set
# CONFIG_SND_SOC_TAS2770 is not set
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
# CONFIG_SND_SOC_TLV320ADCX140 is not set
CONFIG_SND_SOC_TS3A227E=m
# CONFIG_SND_SOC_TSCS42XX is not set
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_UDA1334 is not set
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
# CONFIG_SND_SOC_MT6660 is not set
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
# CONFIG_HID_CREATIVE_SB0540 is not set
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
# CONFIG_HID_GLORIOUS is not set
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
# CONFIG_HID_MCP2221 is not set
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
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
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
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

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
# CONFIG_USB_CDNS3 is not set
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
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
# CONFIG_APPLE_MFI_FASTCHARGE is not set
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
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
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
# CONFIG_MMC_HSQ is not set
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
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
# CONFIG_INFINIBAND_EXP_LEGACY_VERBS_NEW_UAPI is not set
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_INFINIBAND_CXGB4 is not set
# CONFIG_INFINIBAND_EFA is not set
# CONFIG_INFINIBAND_I40IW is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_VMWARE_PVRDMA is not set
# CONFIG_INFINIBAND_USNIC is not set
# CONFIG_INFINIBAND_BNXT_RE is not set
# CONFIG_INFINIBAND_QEDR is not set
# CONFIG_INFINIBAND_RDMAVT is not set
CONFIG_RDMA_RXE=m
CONFIG_RDMA_SIW=m
CONFIG_INFINIBAND_IPOIB=m
# CONFIG_INFINIBAND_IPOIB_CM is not set
CONFIG_INFINIBAND_IPOIB_DEBUG=y
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=m
CONFIG_INFINIBAND_SRPT=m
# CONFIG_INFINIBAND_ISER is not set
# CONFIG_INFINIBAND_ISERT is not set
# CONFIG_INFINIBAND_OPA_VNIC is not set
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
# CONFIG_INTEL_IDXD is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set

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
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
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
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST_DPN=y
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
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

# CONFIG_GREYBUS is not set
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
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# end of Gasket devices

# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set
CONFIG_QLGE=m
# CONFIG_WFX is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_ALIENWARE_WMI is not set
# CONFIG_HUAWEI_WMI is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_XIAOMI_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
CONFIG_DELL_SMBIOS_SMM=y
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_RBTN=m
CONFIG_DELL_RBU=m
CONFIG_DELL_SMO8800=m
CONFIG_DELL_WMI=m
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=m
# CONFIG_DELL_WMI_LED is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_INTEL_ATOMISP2_PM is not set
CONFIG_INTEL_HID_EVENT=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_MENLOW is not set
CONFIG_INTEL_OAKTRAIL=m
CONFIG_INTEL_VBTN=m
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_MLX_PLATFORM is not set
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

# CONFIG_INTEL_TURBO_MAX_3 is not set
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
CONFIG_INTEL_PMC_CORE=m
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_PMC_ATOM=y
# CONFIG_MFD_CROS_EC is not set
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
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
# CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
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
# CONFIG_BMA400 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
CONFIG_HID_SENSOR_ACCEL_3D=m
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
# CONFIG_AD7091R5 is not set
# CONFIG_AD7124 is not set
# CONFIG_AD7192 is not set
# CONFIG_AD7266 is not set
# CONFIG_AD7291 is not set
# CONFIG_AD7292 is not set
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
# CONFIG_LTC2496 is not set
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
# CONFIG_HMC425 is not set
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
# CONFIG_AD5686_SPI is not set
# CONFIG_AD5696_I2C is not set
# CONFIG_AD5755 is not set
# CONFIG_AD5758 is not set
# CONFIG_AD5761 is not set
# CONFIG_AD5764 is not set
# CONFIG_AD5770R is not set
# CONFIG_AD5791 is not set
# CONFIG_AD7303 is not set
# CONFIG_AD8801 is not set
# CONFIG_DS4424 is not set
# CONFIG_LTC1660 is not set
# CONFIG_LTC2632 is not set
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
# CONFIG_ADIS16460 is not set
# CONFIG_ADIS16480 is not set
# CONFIG_BMI160_I2C is not set
# CONFIG_BMI160_SPI is not set
# CONFIG_FXOS8700_I2C is not set
# CONFIG_FXOS8700_SPI is not set
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
# CONFIG_ADUX1020 is not set
# CONFIG_AL3010 is not set
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP002 is not set
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
# CONFIG_NOA1305 is not set
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
# CONFIG_VEML6030 is not set
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
# Linear and angular position sensors
#
# end of Linear and angular position sensors

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
# CONFIG_MAX5432 is not set
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
# CONFIG_DLHL60D is not set
# CONFIG_DPS310 is not set
CONFIG_HID_SENSOR_PRESS=m
# CONFIG_HP03 is not set
# CONFIG_ICP10100 is not set
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
# CONFIG_PING is not set
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
# CONFIG_LTC2983 is not set
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
# CONFIG_PWM_DEBUG is not set
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
# CONFIG_PHY_INTEL_EMMC is not set
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
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID is not set
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
# CONFIG_TEE is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
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
CONFIG_EXT4_KUNIT_TESTS=m
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
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=m
# CONFIG_FS_VERITY is not set
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
# CONFIG_VIRTIO_FS is not set
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
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

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
CONFIG_PROC_CPU_RESCTRL=y
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
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
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
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
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
CONFIG_SUNRPC_XPRT_RDMA=m
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
# CONFIG_CIFS_SMB_DIRECT is not set
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
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_SECURITY_INFINIBAND is not set
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
# CONFIG_SECURITY_SELINUX_DISABLE is not set
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_APPARMOR_KUNIT_TEST is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
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
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
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
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
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
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

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
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
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
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
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

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=y
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
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
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
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
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_DMA_VIRT_OPS=y
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
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
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
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
# end of Generic Kernel Debugging Instruments

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
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
# CONFIG_KASAN is not set
CONFIG_KASAN_STACK=1
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
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
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

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
# CONFIG_WW_MUTEX_SELFTEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

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
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
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
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
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
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
# CONFIG_KUNIT_DEBUGFS is not set
CONFIG_KUNIT_TEST=m
CONFIG_KUNIT_EXAMPLE_TEST=m
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
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
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_MIN_HEAP is not set
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
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
CONFIG_TEST_BPF=m
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
CONFIG_SYSCTL_KUNIT_TEST=m
CONFIG_LIST_KUNIT_TEST=m
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--/6pUCPTUcpTjDznW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='will-it-scale'
	export testcase='will-it-scale'
	export category='benchmark'
	export nr_task=288
	export job_origin='/lkp/lkp/.src-20200514-102226/allot/cyclic:p1:linux-devel:devel-hourly/lkp-knm01/will-it-scale-100.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-knm01'
	export tbox_group='lkp-knm01'
	export submit_id='5eee25cf9e041f0a17194dff'
	export job_file='/lkp/jobs/scheduled/lkp-knm01/will-it-scale-performance-process-100%-mmap1-ucode=0x11-debian-x86_64-20191114.cgz-8aebfffacfa379ba400da573a5bf9e49634e38cb-20200620-2583-13tieff-2.yaml'
	export id='c89754dd8c5fef1203089f7d5ba4055ff6128e34'
	export queuer_version='/lkp-src'
	export model='Knights Mill'
	export nr_node=1
	export nr_cpu=288
	export memory='80G'
	export hdd_partitions=
	export swap_partitions='LABEL=SWAP'
	export rootfs_partition='/dev/disk/by-id/ata-WDC_WD30EZRX-00SPEB0_WD-WCC4E4EK5J23-part1'
	export brand='Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz'
	export commit='8aebfffacfa379ba400da573a5bf9e49634e38cb'
	export need_kconfig_hw='CONFIG_IGB=y
CONFIG_SATA_AHCI'
	export ucode='0x11'
	export kconfig='x86_64-rhel-7.6'
	export compiler='gcc-7'
	export enqueue_time='2020-06-20 23:05:51 +0800'
	export _id='5eee25cf9e041f0a17194dff'
	export _rt='/result/will-it-scale/performance-process-100%-mmap1-ucode=0x11/lkp-knm01/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/8aebfffacfa379ba400da573a5bf9e49634e38cb'
	export user='lkp'
	export head_commit='33dab5accc317b5f777f30cf51564fe02c503c03'
	export base_commit='2ef96a5bb12be62ef75b5828c0aab838ebb29cb8'
	export branch='linux-devel/devel-hourly-2020051600'
	export rootfs='debian-x86_64-20191114.cgz'
	export result_root='/result/will-it-scale/performance-process-100%-mmap1-ucode=0x11/lkp-knm01/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/8aebfffacfa379ba400da573a5bf9e49634e38cb/3'
	export scheduler_version='/lkp/lkp/.src-20200619-190700'
	export LKP_SERVER='inn'
	export arch='x86_64'
	export max_uptime=1500
	export initrd='/osimage/debian/debian-x86_64-20191114.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-knm01/will-it-scale-performance-process-100%-mmap1-ucode=0x11-debian-x86_64-20191114.cgz-8aebfffacfa379ba400da573a5bf9e49634e38cb-20200620-2583-13tieff-2.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.6
branch=linux-devel/devel-hourly-2020051600
commit=8aebfffacfa379ba400da573a5bf9e49634e38cb
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/8aebfffacfa379ba400da573a5bf9e49634e38cb/vmlinuz-5.7.0-rc3-00001-g8aebfffacfa37
max_uptime=1500
RESULT_ROOT=/result/will-it-scale/performance-process-100%-mmap1-ucode=0x11/lkp-knm01/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/8aebfffacfa379ba400da573a5bf9e49634e38cb/3
LKP_SERVER=inn
nokaslr
selinux=0
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
	export modules_initrd='/pkg/linux/x86_64-rhel-7.6/gcc-7/8aebfffacfa379ba400da573a5bf9e49634e38cb/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-20180403.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/lkp_2019-08-05.cgz,/osimage/deps/debian-x86_64-20180403.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/will-it-scale_2020-01-07.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/will-it-scale-x86_64-0f26364-1_20200528.cgz,/osimage/deps/debian-x86_64-20180403.cgz/mpstat_2020-01-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/vmstat_2020-01-07.cgz,/osimage/deps/debian-x86_64-20180403.cgz/perf_20200325.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/perf-x86_64-76ccd234269b-1_20200325.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/sar-x86_64-e011d97-1_2020-01-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/hw_2020-01-02.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20191114.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.7.0-rc5-02835-g151f57cb5d2a3'
	export repeat_to=4
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-7.6/gcc-7/8aebfffacfa379ba400da573a5bf9e49634e38cb/vmlinuz-5.7.0-rc3-00001-g8aebfffacfa37'
	export dequeue_time='2020-06-20 23:20:53 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-knm01/will-it-scale-performance-process-100%-mmap1-ucode=0x11-debian-x86_64-20191114.cgz-8aebfffacfa379ba400da573a5bf9e49634e38cb-20200620-2583-13tieff-2.cgz'

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
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test mode='process' test='mmap1' $LKP_SRC/tests/wrapper will-it-scale
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper will-it-scale
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
	$LKP_SRC/stats/wrapper sched_debug
	$LKP_SRC/stats/wrapper perf-stat
	$LKP_SRC/stats/wrapper mpstat
	$LKP_SRC/stats/wrapper perf-profile

	$LKP_SRC/stats/wrapper time will-it-scale.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--/6pUCPTUcpTjDznW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/will-it-scale-100.yaml
suite: will-it-scale
testcase: will-it-scale
category: benchmark
nr_task: 100%
will-it-scale:
  mode: process
  test: mmap1
job_origin: "/lkp/lkp/.src-20200514-102226/allot/cyclic:p1:linux-devel:devel-hourly/lkp-knm01/will-it-scale-100.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-knm01
tbox_group: lkp-knm01
submit_id: 5eee00f69e041f092455764a
job_file: "/lkp/jobs/scheduled/lkp-knm01/will-it-scale-performance-process-100%-mmap1-ucode=0x11-debian-x86_64-20191114.cgz-8aebfffacfa379ba400da573a5bf9e49634e38cb-20200620-2340-syvjqi-0.yaml"
id: 7876115a30c7d400318feb16cea501bc9e7cfb32
queuer_version: "/lkp-src"

#! hosts/lkp-knm01
model: Knights Mill
nr_node: 1
nr_cpu: 288
memory: 80G
hdd_partitions: 
swap_partitions: LABEL=SWAP
rootfs_partition: "/dev/disk/by-id/ata-WDC_WD30EZRX-00SPEB0_WD-WCC4E4EK5J23-part1"
brand: Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz

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
sched_debug: 
perf-stat: 
mpstat: 
perf-profile: 

#! include/category/ALL
cpufreq_governor: performance

#! include/queue/cyclic
commit: 8aebfffacfa379ba400da573a5bf9e49634e38cb

#! include/testbox/lkp-knm01
need_kconfig_hw:
- CONFIG_IGB=y
- CONFIG_SATA_AHCI
ucode: '0x11'

#! default params
kconfig: x86_64-rhel-7.6
compiler: gcc-7
enqueue_time: 2020-06-20 20:28:38.694160333 +08:00
_id: 5eee00f69e041f092455764a
_rt: "/result/will-it-scale/performance-process-100%-mmap1-ucode=0x11/lkp-knm01/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/8aebfffacfa379ba400da573a5bf9e49634e38cb"

#! schedule options
user: lkp
head_commit: 33dab5accc317b5f777f30cf51564fe02c503c03
base_commit: 2ef96a5bb12be62ef75b5828c0aab838ebb29cb8
branch: linux-devel/devel-hourly-2020051600
rootfs: debian-x86_64-20191114.cgz
result_root: "/result/will-it-scale/performance-process-100%-mmap1-ucode=0x11/lkp-knm01/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/8aebfffacfa379ba400da573a5bf9e49634e38cb/0"
scheduler_version: "/lkp/lkp/.src-20200619-190700"
LKP_SERVER: inn
arch: x86_64
max_uptime: 1500
initrd: "/osimage/debian/debian-x86_64-20191114.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-knm01/will-it-scale-performance-process-100%-mmap1-ucode=0x11-debian-x86_64-20191114.cgz-8aebfffacfa379ba400da573a5bf9e49634e38cb-20200620-2340-syvjqi-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-7.6
- branch=linux-devel/devel-hourly-2020051600
- commit=8aebfffacfa379ba400da573a5bf9e49634e38cb
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/8aebfffacfa379ba400da573a5bf9e49634e38cb/vmlinuz-5.7.0-rc3-00001-g8aebfffacfa37
- max_uptime=1500
- RESULT_ROOT=/result/will-it-scale/performance-process-100%-mmap1-ucode=0x11/lkp-knm01/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/8aebfffacfa379ba400da573a5bf9e49634e38cb/0
- LKP_SERVER=inn
- nokaslr
- selinux=0
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
modules_initrd: "/pkg/linux/x86_64-rhel-7.6/gcc-7/8aebfffacfa379ba400da573a5bf9e49634e38cb/modules.cgz"
bm_initrd: "/osimage/deps/debian-x86_64-20180403.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/lkp_2019-08-05.cgz,/osimage/deps/debian-x86_64-20180403.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/will-it-scale_2020-01-07.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/will-it-scale-x86_64-0f26364-1_20200528.cgz,/osimage/deps/debian-x86_64-20180403.cgz/mpstat_2020-01-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/vmstat_2020-01-07.cgz,/osimage/deps/debian-x86_64-20180403.cgz/perf_20200325.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/perf-x86_64-76ccd234269b-1_20200325.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/sar-x86_64-e011d97-1_2020-01-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/hw_2020-01-02.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20191114.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20200514-102226/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.6.0-01891-ga776c270a0b2f
repeat_to: 2
schedule_notify_address: 

#! user overrides
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-7.6/gcc-7/8aebfffacfa379ba400da573a5bf9e49634e38cb/vmlinuz-5.7.0-rc3-00001-g8aebfffacfa37"
dequeue_time: 2020-06-20 22:10:59.411056670 +08:00

#! /lkp/lkp/.src-20200619-190700/include/site/inn
job_state: finished
loadavg: 54.84 134.94 74.78 2/1850 11362
start_time: '1592662369'
end_time: '1592662677'
version: "/lkp/lkp/.src-20200619-190732:c0ef8a7a:3391efd8c"

--/6pUCPTUcpTjDznW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

 "/lkp/benchmarks/python3/bin/python3" "./runtest.py" "mmap1" "295" "process" "288"

--/6pUCPTUcpTjDznW--
