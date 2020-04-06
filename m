Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF99AC2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 01:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1683920678
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 01:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgDFB03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 21:26:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:19420 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbgDFB02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 21:26:28 -0400
IronPort-SDR: WmEGmrEjCb9pC6GoTuc7uA9GD3RaPd+5BinoP99Fx2juxcAOn8qPHwLitiAugk16FtxakqB2v8
 4803Rz0YW+Rg==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2020 18:26:04 -0700
IronPort-SDR: 3YUs1x86a0Jh3jYd6B2c8JBGUiTKSGFWx5kolDnxFwRsBTWCw0zbOLAC/3d5KV9ApmSn4GHG6p
 nPk1BaCt/7Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,349,1580803200"; 
   d="yaml'?scan'208";a="253966987"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2020 18:26:01 -0700
Date:   Mon, 6 Apr 2020 09:25:39 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: [non] 2aa3847085: will-it-scale.per_process_ops -32.0% regression
Message-ID: <20200406012539.GR8179@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oOpJzULQ70+PGW7h"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oOpJzULQ70+PGW7h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Greeting,

FYI, we noticed a -32.0% regression of will-it-scale.per_process_ops due to commit:


commit: 2aa38470853a65dc9b1b4bd0989d34cd3fc57ebd ("non-RCU analogue of the previous commit")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: will-it-scale
on test machine: 4 threads Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 4G memory
with following parameters:

	test: open2
	cpufreq_governor: performance
	ucode: 0x21

test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
test-url: https://github.com/antonblanchard/will-it-scale

In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_thread_ops -28.9% regression             |
| test machine     | 4 threads Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 8G memory          |
| test parameters  | cpufreq_governor=performance                                              |
|                  | mode=thread                                                               |
|                  | nr_task=16                                                                |
|                  | test=open1                                                                |
|                  | ucode=0x21                                                                |
+------------------+---------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_thread_ops -29.5% regression             |
| test machine     | 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory      |
| test parameters  | cpufreq_governor=performance                                              |
|                  | mode=thread                                                               |
|                  | nr_task=100%                                                              |
|                  | test=unlink2                                                              |
|                  | ucode=0x11                                                                |
+------------------+---------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_process_ops -22.4% regression            |
| test machine     | 8 threads Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz with 16G memory        |
| test parameters  | cpufreq_governor=performance                                              |
|                  | mode=process                                                              |
|                  | nr_task=100%                                                              |
|                  | test=unlink2                                                              |
|                  | ucode=0x21                                                                |
+------------------+---------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_process_ops -63.9% regression            |
| test machine     | 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
| test parameters  | cpufreq_governor=performance                                              |
|                  | mode=process                                                              |
|                  | nr_task=100%                                                              |
|                  | test=unlink2                                                              |
|                  | ucode=0x500002c                                                           |
+------------------+---------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_process_ops -92.6% regression            |
| test machine     | 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory      |
| test parameters  | cpufreq_governor=performance                                              |
|                  | mode=process                                                              |
|                  | nr_task=100%                                                              |
|                  | test=open2                                                                |
|                  | ucode=0x11                                                                |
+------------------+---------------------------------------------------------------------------+
| testcase: change | filebench: filebench.sum_bytes_mb/s -14.1% regression                     |
| test machine     | 8 threads Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz with 8G memory          |
| test parameters  | cpufreq_governor=performance                                              |
|                  | disk=1HDD                                                                 |
|                  | fs=btrfs                                                                  |
|                  | test=listdirs.f                                                           |
|                  | ucode=0x27                                                                |
+------------------+---------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_thread_ops -29.2% regression             |
| test machine     | 8 threads Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz with 16G memory        |
| test parameters  | cpufreq_governor=performance                                              |
|                  | mode=thread                                                               |
|                  | nr_task=100%                                                              |
|                  | test=open1                                                                |
|                  | ucode=0x21                                                                |
+------------------+---------------------------------------------------------------------------+
| testcase: change | reaim: reaim.jobs_per_min -2.0% regression                                |
| test machine     | 72 threads Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz with 256G memory     |
| test parameters  | cpufreq_governor=performance                                              |
|                  | nr_job=1000                                                               |
|                  | nr_task=100%                                                              |
|                  | runtime=300s                                                              |
|                  | test=high_systime                                                         |
|                  | ucode=0x43                                                                |
+------------------+---------------------------------------------------------------------------+
| testcase: change | unixbench: unixbench.score -4.7% regression                               |
| test machine     | 72 threads Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz with 256G memory     |
| test parameters  | cpufreq_governor=performance                                              |
|                  | nr_task=1                                                                 |
|                  | runtime=30s                                                               |
|                  | test=shell1                                                               |
|                  | ucode=0x43                                                                |
+------------------+---------------------------------------------------------------------------+


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
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/ucode:
  gcc-7/performance/x86_64-rhel-7.6/debian-x86_64-20191114.cgz/lkp-ivb-d04/open2/will-it-scale/0x21

commit: 
  7ef482fa65 ("helper for mount rootwards traversal")
  2aa3847085 ("non-RCU analogue of the previous commit")

7ef482fa65513b18 2aa38470853a65dc9b1b4bd0989 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          1:4          -25%            :4     dmesg.WARNING:at_ip__fsnotify_parent/0x
         %stddev     %change         %stddev
             \          |                \  
    449960           -32.0%     306036        will-it-scale.per_process_ops
    433605           -30.6%     300719        will-it-scale.per_thread_ops
      0.62            -4.3%       0.59        will-it-scale.scalability
     18460 ± 14%     -26.9%      13502        will-it-scale.time.involuntary_context_switches
    282.05           +11.0%     313.06        will-it-scale.time.system_time
     96.33           -31.4%      66.12        will-it-scale.time.user_time
   8081793           -31.7%    5523799        will-it-scale.workload
     89.75 ± 16%     -22.8%      69.25 ± 10%  interrupts.TLB:TLB_shootdowns
     28498           +12.2%      31976        meminfo.SUnreclaim
      0.02 ± 13%      +0.5        0.52 ±  5%  mpstat.cpu.all.soft%
     17.25 ±  3%      -5.3       11.94        mpstat.cpu.all.usr%
     46.25           +10.8%      51.25        vmstat.cpu.sy
     16.75 ±  4%     -31.3%      11.50 ±  4%  vmstat.cpu.us
      5.79 ± 33%     -47.5%       3.04 ± 39%  sched_debug.cfs_rq:/.nr_spread_over.max
      2.14 ± 32%     -52.2%       1.02 ± 39%  sched_debug.cfs_rq:/.nr_spread_over.stddev
    167457 ±  3%     -11.7%     147862 ±  8%  sched_debug.cpu.avg_idle.stddev
    197186 ± 20%     -23.5%     150806        softirqs.CPU1.RCU
    176179 ± 31%     -40.5%     104763 ±  4%  softirqs.CPU2.RCU
    192521 ±  5%     -35.9%     123384        softirqs.CPU3.RCU
    713159 ± 11%     -28.1%     512675        softirqs.RCU
      7097           +12.9%       8016        proc-vmstat.nr_slab_unreclaimable
  16207823           +39.1%   22537707        proc-vmstat.numa_hit
  16207823           +39.1%   22537707        proc-vmstat.numa_local
   1847675 ± 37%    +290.6%    7216752 ± 32%  proc-vmstat.pgalloc_dma32
  16251820           +39.2%   22620665 ±  2%  proc-vmstat.pgfree
      3220 ±  9%     +38.0%       4445 ±  7%  slabinfo.anon_vma_chain.active_objs
      3764 ±  5%     +19.7%       4504 ±  5%  slabinfo.anon_vma_chain.num_objs
     17016 ±  2%     +81.1%      30811 ±  2%  slabinfo.filp.active_objs
      1068 ±  2%     +80.9%       1933 ±  2%  slabinfo.filp.active_slabs
     17105 ±  2%     +80.9%      30943 ±  2%  slabinfo.filp.num_objs
      1068 ±  2%     +80.9%       1933 ±  2%  slabinfo.filp.num_slabs
      2.02           +24.0%       2.51        perf-stat.i.MPKI
 1.194e+09           +12.6%  1.345e+09        perf-stat.i.branch-instructions
      0.97 ±  2%      -0.1        0.90        perf-stat.i.branch-miss-rate%
     20.99 ±  2%      +4.3       25.26        perf-stat.i.cache-miss-rate%
   2484450 ±  2%     +62.0%    4024615        perf-stat.i.cache-misses
  12527210           +39.8%   17507052        perf-stat.i.cache-references
      1.35           -10.8%       1.20        perf-stat.i.cpi
     31.96           -12.7%      27.89 ±  3%  perf-stat.i.cpu-migrations
      3676 ±  3%     -42.7%       2106        perf-stat.i.cycles-between-cache-misses
 1.768e+09           +11.5%  1.972e+09        perf-stat.i.dTLB-loads
      0.44 ±  3%      -0.2        0.29 ± 15%  perf-stat.i.dTLB-store-miss-rate%
   5332367 ±  4%     -26.7%    3908806 ± 15%  perf-stat.i.dTLB-store-misses
 1.186e+09           +11.6%  1.324e+09        perf-stat.i.dTLB-stores
   1751901           -27.4%    1271707 ±  2%  perf-stat.i.iTLB-load-misses
    206031 ± 14%     -38.1%     127455 ±  5%  perf-stat.i.iTLB-loads
 6.108e+09           +11.1%  6.788e+09        perf-stat.i.instructions
      3655           +52.9%       5588 ±  2%  perf-stat.i.instructions-per-iTLB-miss
      0.77           +12.2%       0.86        perf-stat.i.ipc
      2.05           +25.8%       2.58        perf-stat.overall.MPKI
      1.01            -0.1        0.92        perf-stat.overall.branch-miss-rate%
     19.83            +3.2       22.99        perf-stat.overall.cache-miss-rate%
      1.39           -10.5%       1.25        perf-stat.overall.cpi
      3422 ±  2%     -38.6%       2100        perf-stat.overall.cycles-between-cache-misses
      0.45 ±  3%      -0.2        0.29 ± 16%  perf-stat.overall.dTLB-store-miss-rate%
      3487           +53.2%       5342 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
      0.72           +11.7%       0.80        perf-stat.overall.ipc
    229833           +62.6%     373735        perf-stat.overall.path-length
  1.19e+09           +12.6%   1.34e+09        perf-stat.ps.branch-instructions
   2476320 ±  2%     +62.0%    4011412        perf-stat.ps.cache-misses
  12486106           +39.8%   17449573        perf-stat.ps.cache-references
     31.85           -12.7%      27.81 ±  3%  perf-stat.ps.cpu-migrations
 1.762e+09           +11.5%  1.965e+09        perf-stat.ps.dTLB-loads
   5314861 ±  4%     -26.7%    3895962 ± 15%  perf-stat.ps.dTLB-store-misses
 1.182e+09           +11.6%  1.319e+09        perf-stat.ps.dTLB-stores
   1746139           -27.4%    1267514 ±  2%  perf-stat.ps.iTLB-load-misses
    205358 ± 14%     -38.1%     127042 ±  5%  perf-stat.ps.iTLB-loads
 6.088e+09           +11.1%  6.766e+09        perf-stat.ps.instructions
 1.857e+12           +11.1%  2.064e+12        perf-stat.total.instructions
      6.27 ± 10%      -2.0        4.25 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64
      6.16 ±  9%      -1.8        4.33 ±  8%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret
      4.05 ± 10%      -0.9        3.14 ±  8%  perf-profile.calltrace.cycles-pp.do_dentry_open.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      3.88 ±  8%      -0.7        3.14 ±  8%  perf-profile.calltrace.cycles-pp.getname_flags.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.67 ±  5%      -0.7        1.99 ± 13%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.35 ± 10%      -0.6        1.72 ±  8%  perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.do_sys_openat2.do_sys_open.do_syscall_64
      1.61 ± 13%      -0.5        1.11 ± 12%  perf-profile.calltrace.cycles-pp.__d_lookup_rcu.lookup_fast.walk_component.link_path_walk.path_openat
      1.52 ± 10%      -0.5        1.02 ± 12%  perf-profile.calltrace.cycles-pp.ima_file_check.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.94 ± 13%      -0.4        0.51 ± 59%  perf-profile.calltrace.cycles-pp.fput_many.filp_close.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.29 ± 10%      -0.4        0.87 ± 13%  perf-profile.calltrace.cycles-pp.security_task_getsecid.ima_file_check.path_openat.do_filp_open.do_sys_openat2
      1.56 ± 11%      -0.4        1.16 ± 14%  perf-profile.calltrace.cycles-pp.filp_close.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.61 ± 12%      -0.4        1.22 ± 10%  perf-profile.calltrace.cycles-pp.__check_object_size.strncpy_from_user.getname_flags.do_sys_openat2.do_sys_open
      1.17 ±  9%      -0.4        0.80 ± 16%  perf-profile.calltrace.cycles-pp.apparmor_task_getsecid.security_task_getsecid.ima_file_check.path_openat.do_filp_open
      0.62 ±  6%      +0.2        0.80 ± 10%  perf-profile.calltrace.cycles-pp.rcu_segcblist_enqueue.call_rcu.task_work_run.exit_to_usermode_loop.do_syscall_64
      0.68 ± 14%      +0.3        0.93 ± 10%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.07 ±  7%      +0.4        1.44 ±  6%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.security_file_alloc.__alloc_file.alloc_empty_file.path_openat
      0.94 ± 17%      +0.4        1.37 ± 10%  perf-profile.calltrace.cycles-pp.new_slab.___slab_alloc.__slab_alloc.kmem_cache_alloc.__alloc_file
      1.16 ± 17%      +0.5        1.62 ±  8%  perf-profile.calltrace.cycles-pp.___slab_alloc.__slab_alloc.kmem_cache_alloc.__alloc_file.alloc_empty_file
      1.22 ± 15%      +0.5        1.70 ±  8%  perf-profile.calltrace.cycles-pp.__slab_alloc.kmem_cache_alloc.__alloc_file.alloc_empty_file.path_openat
      0.81 ± 20%      +0.5        1.30 ±  4%  perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_openat2
      1.24 ±  4%      +0.6        1.81 ± 12%  perf-profile.calltrace.cycles-pp.call_rcu.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.21 ± 16%      +0.6        1.79 ±  4%  perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00            +0.6        0.60 ±  8%  perf-profile.calltrace.cycles-pp.lockref_put_return.dput.step_into.walk_component.link_path_walk
      0.00            +0.6        0.61 ±  5%  perf-profile.calltrace.cycles-pp.lockref_put_return.dput.terminate_walk.path_openat.do_filp_open
      0.27 ±100%      +0.7        0.93 ± 17%  perf-profile.calltrace.cycles-pp.lookup_fast.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00            +0.7        0.70 ± 20%  perf-profile.calltrace.cycles-pp.fput_many.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00            +0.7        0.73 ± 13%  perf-profile.calltrace.cycles-pp.step_into.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      2.71 ± 11%      +0.9        3.59 ± 13%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.__alloc_file.alloc_empty_file.path_openat.do_filp_open
      0.00            +0.9        0.89 ±  7%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__d_lookup.lookup_fast.walk_component.link_path_walk
      1.90 ± 12%      +0.9        2.80 ±  8%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_openat.do_filp_open
      0.00            +1.0        0.98 ± 20%  perf-profile.calltrace.cycles-pp.lockref_get.__traverse_mounts.step_into.walk_component.link_path_walk
      3.43 ±  8%      +1.0        4.46 ± 11%  perf-profile.calltrace.cycles-pp.security_file_alloc.__alloc_file.alloc_empty_file.path_openat.do_filp_open
      0.00            +1.1        1.06 ±  7%  perf-profile.calltrace.cycles-pp.lockref_get.set_root.nd_jump_root.path_init.path_openat
      0.00            +1.1        1.15 ± 13%  perf-profile.calltrace.cycles-pp.dput.step_into.walk_component.link_path_walk.path_openat
      0.00            +1.3        1.32 ±  8%  perf-profile.calltrace.cycles-pp.__d_lookup.lookup_fast.walk_component.link_path_walk.path_openat
      0.59 ±  8%      +1.4        1.95 ± 12%  perf-profile.calltrace.cycles-pp.set_root.nd_jump_root.path_init.path_openat.do_filp_open
      0.92 ± 15%      +1.6        2.52 ± 11%  perf-profile.calltrace.cycles-pp.nd_jump_root.path_init.path_openat.do_filp_open.do_sys_openat2
      1.11 ± 15%      +1.7        2.80 ± 11%  perf-profile.calltrace.cycles-pp.path_init.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00            +2.3        2.29 ± 13%  perf-profile.calltrace.cycles-pp.__traverse_mounts.step_into.walk_component.link_path_walk.path_openat
      0.91 ± 30%      +3.7        4.58 ± 12%  perf-profile.calltrace.cycles-pp.step_into.walk_component.link_path_walk.path_openat.do_filp_open
      7.25 ±  8%      +4.4       11.67 ± 10%  perf-profile.calltrace.cycles-pp.__alloc_file.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
      7.47 ±  8%      +4.5       11.95 ± 10%  perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      3.09 ±  7%      +4.7        7.75 ±  8%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      4.85 ±  7%      +5.4       10.28 ±  9%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
     31.61 ±  8%     +10.0       41.61 ±  9%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
     31.25 ±  8%     +10.1       41.40 ±  9%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
     23.68 ±  9%     +12.1       35.75 ±  9%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
     23.07 ±  9%     +12.2       35.27 ±  9%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      6.95 ± 10%      -2.1        4.83 ±  8%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      6.29 ± 10%      -2.0        4.26 ±  8%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      4.08 ± 10%      -0.9        3.17 ±  8%  perf-profile.children.cycles-pp.do_dentry_open
      3.89 ±  8%      -0.7        3.15 ±  8%  perf-profile.children.cycles-pp.getname_flags
      0.97 ± 13%      -0.7        0.29 ± 23%  perf-profile.children.cycles-pp.unlazy_walk
      2.67 ±  5%      -0.7        1.99 ± 13%  perf-profile.children.cycles-pp.__x64_sys_close
      1.05 ± 13%      -0.7        0.37 ± 19%  perf-profile.children.cycles-pp.complete_walk
      2.36 ± 10%      -0.6        1.74 ±  8%  perf-profile.children.cycles-pp.strncpy_from_user
      1.98 ± 11%      -0.5        1.44 ±  7%  perf-profile.children.cycles-pp.__d_lookup_rcu
      1.55 ± 10%      -0.5        1.03 ± 12%  perf-profile.children.cycles-pp.ima_file_check
      1.59 ± 11%      -0.4        1.17 ± 14%  perf-profile.children.cycles-pp.filp_close
      1.29 ± 10%      -0.4        0.88 ± 13%  perf-profile.children.cycles-pp.security_task_getsecid
      1.19 ± 10%      -0.4        0.81 ± 16%  perf-profile.children.cycles-pp.apparmor_task_getsecid
      0.91 ± 17%      -0.3        0.59 ± 19%  perf-profile.children.cycles-pp.fsnotify
      0.76 ± 13%      -0.3        0.49 ± 10%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.67 ± 10%      -0.2        0.48 ± 22%  perf-profile.children.cycles-pp.aa_get_task_label
      0.50 ± 17%      -0.2        0.34 ± 13%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.22 ±  9%      -0.2        0.07 ± 58%  perf-profile.children.cycles-pp.restore_nameidata
      0.43 ±  6%      -0.2        0.28 ± 16%  perf-profile.children.cycles-pp.__mnt_want_write
      0.28 ± 46%      -0.1        0.14 ± 33%  perf-profile.children.cycles-pp.get_unused_fd_flags
      0.39 ±  7%      -0.1        0.27 ±  8%  perf-profile.children.cycles-pp.__x64_sys_open
      0.16 ± 30%      -0.1        0.07 ± 24%  perf-profile.children.cycles-pp.put_pid
      0.23            -0.1        0.14 ±  5%  perf-profile.children.cycles-pp.__fd_install
      0.18 ±  5%      -0.1        0.12 ± 10%  perf-profile.children.cycles-pp.__mnt_drop_write
      0.12 ± 20%      -0.0        0.07 ± 21%  perf-profile.children.cycles-pp.process_measurement
      0.09 ± 11%      +0.1        0.15 ± 15%  perf-profile.children.cycles-pp.mntput
      0.05 ± 67%      +0.1        0.11 ± 27%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.09 ± 13%      +0.1        0.15 ± 32%  perf-profile.children.cycles-pp.blkcg_maybe_throttle_current
      0.20 ± 12%      +0.1        0.27 ±  9%  perf-profile.children.cycles-pp.security_inode_permission
      0.06 ± 63%      +0.1        0.14 ± 27%  perf-profile.children.cycles-pp.vfs_open
      0.22 ± 24%      +0.1        0.35 ± 11%  perf-profile.children.cycles-pp.unfreeze_partials
      0.36 ± 16%      +0.1        0.49 ± 17%  perf-profile.children.cycles-pp.generic_permission
      0.39 ± 14%      +0.2        0.55 ±  9%  perf-profile.children.cycles-pp.may_open
      0.61 ± 11%      +0.2        0.77 ±  4%  perf-profile.children.cycles-pp.__might_sleep
      0.00            +0.2        0.17 ± 21%  perf-profile.children.cycles-pp.__legitimize_path
      0.24 ± 25%      +0.2        0.42 ± 22%  perf-profile.children.cycles-pp.put_cpu_partial
      0.62 ±  6%      +0.2        0.80 ± 10%  perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.34 ± 14%      +0.2        0.52 ± 11%  perf-profile.children.cycles-pp.rcu_all_qs
      0.57 ±  9%      +0.2        0.81 ±  7%  perf-profile.children.cycles-pp.lockref_put_or_lock
      0.68 ± 14%      +0.3        0.94 ± 10%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.68 ±  7%      +0.3        1.00 ± 17%  perf-profile.children.cycles-pp.memset_erms
      0.76 ± 15%      +0.3        1.10 ± 15%  perf-profile.children.cycles-pp.file_free_rcu
      0.65 ± 14%      +0.3        1.00 ±  9%  perf-profile.children.cycles-pp._cond_resched
      0.00            +0.3        0.35 ±  8%  perf-profile.children.cycles-pp.legitimize_mnt
      0.96 ± 13%      +0.4        1.37 ± 19%  perf-profile.children.cycles-pp.fput_many
      1.29 ± 11%      +0.4        1.70 ±  9%  perf-profile.children.cycles-pp.___might_sleep
      0.95 ± 18%      +0.4        1.38 ± 10%  perf-profile.children.cycles-pp.new_slab
      1.17 ± 16%      +0.5        1.63 ±  8%  perf-profile.children.cycles-pp.___slab_alloc
      1.23 ± 15%      +0.5        1.71 ±  8%  perf-profile.children.cycles-pp.__slab_alloc
      1.27 ±  5%      +0.6        1.84 ± 12%  perf-profile.children.cycles-pp.call_rcu
      0.00            +0.6        0.61 ± 11%  perf-profile.children.cycles-pp.lookup_mnt
      1.25 ± 16%      +0.6        1.86 ±  4%  perf-profile.children.cycles-pp.terminate_walk
      2.61 ± 11%      +0.9        3.52 ± 13%  perf-profile.children.cycles-pp.rcu_core
      2.63 ± 11%      +0.9        3.54 ± 13%  perf-profile.children.cycles-pp.irq_exit
      2.58 ± 11%      +0.9        3.50 ± 13%  perf-profile.children.cycles-pp.rcu_do_batch
      2.62 ± 11%      +0.9        3.54 ± 13%  perf-profile.children.cycles-pp.__softirqentry_text_start
      2.94 ± 13%      +1.0        3.92 ± 11%  perf-profile.children.cycles-pp.smp_apic_timer_interrupt
      2.97 ± 13%      +1.0        3.95 ± 11%  perf-profile.children.cycles-pp.apic_timer_interrupt
      3.44 ±  8%      +1.0        4.47 ± 11%  perf-profile.children.cycles-pp.security_file_alloc
      0.00            +1.2        1.21 ±  3%  perf-profile.children.cycles-pp.lockref_put_return
      5.19 ± 10%      +1.2        6.41 ±  9%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.73 ±  8%      +1.2        1.97 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock
      2.44 ± 10%      +1.3        3.78 ±  9%  perf-profile.children.cycles-pp.lookup_fast
      0.59 ±  9%      +1.4        1.96 ± 11%  perf-profile.children.cycles-pp.set_root
      0.93 ± 15%      +1.6        2.54 ± 11%  perf-profile.children.cycles-pp.nd_jump_root
      1.12 ± 14%      +1.7        2.81 ± 11%  perf-profile.children.cycles-pp.path_init
      0.00            +1.8        1.78 ± 10%  perf-profile.children.cycles-pp.__d_lookup
      0.26 ± 21%      +2.2        2.48 ± 11%  perf-profile.children.cycles-pp.lockref_get
      0.00            +2.3        2.32 ± 13%  perf-profile.children.cycles-pp.__traverse_mounts
      1.49 ± 14%      +2.5        3.98 ±  6%  perf-profile.children.cycles-pp.dput
      1.11 ± 27%      +4.3        5.36 ± 12%  perf-profile.children.cycles-pp.step_into
      7.29 ±  8%      +4.4       11.72 ± 10%  perf-profile.children.cycles-pp.__alloc_file
      7.51 ±  8%      +4.5       11.99 ± 10%  perf-profile.children.cycles-pp.alloc_empty_file
      3.12 ±  7%      +4.7        7.79 ±  8%  perf-profile.children.cycles-pp.walk_component
      4.88 ±  7%      +5.5       10.34 ±  9%  perf-profile.children.cycles-pp.link_path_walk
     31.62 ±  8%     +10.0       41.63 ±  9%  perf-profile.children.cycles-pp.do_sys_open
     31.30 ±  8%     +10.1       41.45 ±  9%  perf-profile.children.cycles-pp.do_sys_openat2
     23.70 ±  9%     +12.1       35.79 ±  9%  perf-profile.children.cycles-pp.do_filp_open
     23.17 ±  9%     +12.3       35.47 ±  9%  perf-profile.children.cycles-pp.path_openat
     12.19 ±  8%      -3.9        8.28 ± 11%  perf-profile.self.cycles-pp.do_syscall_64
      6.93 ± 10%      -2.1        4.82 ±  8%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      6.29 ± 10%      -2.0        4.26 ±  8%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      1.88 ± 10%      -0.6        1.32 ±  3%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.88 ± 17%      -0.3        0.56 ± 20%  perf-profile.self.cycles-pp.fsnotify
      0.76 ± 14%      -0.3        0.49 ± 10%  perf-profile.self.cycles-pp.do_sys_openat2
      0.69 ±  7%      -0.3        0.43 ± 11%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.86 ±  8%      -0.2        0.64 ± 11%  perf-profile.self.cycles-pp.do_dentry_open
      0.60 ± 17%      -0.2        0.38 ± 13%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.66 ± 10%      -0.2        0.45 ±  3%  perf-profile.self.cycles-pp.strncpy_from_user
      0.48 ± 11%      -0.2        0.31 ±  9%  perf-profile.self.cycles-pp.apparmor_task_getsecid
      0.62 ±  8%      -0.2        0.46 ± 22%  perf-profile.self.cycles-pp.aa_get_task_label
      0.47 ± 16%      -0.2        0.32 ± 11%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.40 ± 10%      -0.1        0.25 ± 20%  perf-profile.self.cycles-pp.__mnt_want_write
      0.20 ±  9%      -0.1        0.06 ± 60%  perf-profile.self.cycles-pp.restore_nameidata
      0.27 ± 49%      -0.1        0.14 ± 37%  perf-profile.self.cycles-pp.get_unused_fd_flags
      0.30 ± 11%      -0.1        0.18 ± 16%  perf-profile.self.cycles-pp.do_sys_open
      0.14 ± 30%      -0.1        0.05 ± 62%  perf-profile.self.cycles-pp.put_pid
      0.31 ±  3%      -0.1        0.22 ± 13%  perf-profile.self.cycles-pp.__x64_sys_open
      0.22 ±  5%      -0.1        0.14 ±  5%  perf-profile.self.cycles-pp.__fd_install
      0.18 ±  4%      -0.1        0.12 ± 11%  perf-profile.self.cycles-pp.__mnt_drop_write
      0.14 ± 20%      -0.0        0.09 ± 15%  perf-profile.self.cycles-pp.ima_file_check
      0.10 ± 18%      -0.0        0.06 ± 59%  perf-profile.self.cycles-pp.locks_remove_posix
      0.06 ±  9%      +0.0        0.09 ±  8%  perf-profile.self.cycles-pp.mntput
      0.20 ± 14%      +0.1        0.26 ±  9%  perf-profile.self.cycles-pp.security_inode_permission
      0.01 ±173%      +0.1        0.08 ± 30%  perf-profile.self.cycles-pp.free_pcppages_bulk
      0.03 ±100%      +0.1        0.10 ± 27%  perf-profile.self.cycles-pp.path_get
      0.12 ± 27%      +0.1        0.20 ± 22%  perf-profile.self.cycles-pp.may_open
      0.00            +0.1        0.07 ± 11%  perf-profile.self.cycles-pp.__alloc_pages_nodemask
      0.24 ± 12%      +0.1        0.32 ±  9%  perf-profile.self.cycles-pp.walk_component
      0.27 ± 10%      +0.1        0.36 ± 15%  perf-profile.self.cycles-pp.mntput_no_expire
      0.24 ± 15%      +0.1        0.35 ± 15%  perf-profile.self.cycles-pp.rcu_all_qs
      0.00            +0.1        0.14 ± 26%  perf-profile.self.cycles-pp.__legitimize_path
      0.53 ± 14%      +0.1        0.67 ±  4%  perf-profile.self.cycles-pp.__might_sleep
      0.00            +0.2        0.17 ± 25%  perf-profile.self.cycles-pp.lookup_mnt
      0.41 ± 10%      +0.2        0.58 ±  7%  perf-profile.self.cycles-pp.exit_to_usermode_loop
      0.29 ± 16%      +0.2        0.46 ± 10%  perf-profile.self.cycles-pp._cond_resched
      0.62 ±  6%      +0.2        0.80 ± 10%  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.29 ± 16%      +0.2        0.48 ± 23%  perf-profile.self.cycles-pp.fput_many
      0.51 ± 12%      +0.2        0.72 ±  6%  perf-profile.self.cycles-pp.lockref_put_or_lock
      0.00            +0.2        0.22 ± 21%  perf-profile.self.cycles-pp.__traverse_mounts
      0.62 ±  6%      +0.2        0.84 ± 15%  perf-profile.self.cycles-pp.memset_erms
      0.67 ± 14%      +0.2        0.92 ± 10%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.63 ± 11%      +0.3        0.89 ± 13%  perf-profile.self.cycles-pp.path_openat
      0.44 ± 13%      +0.3        0.71 ± 12%  perf-profile.self.cycles-pp.new_slab
      0.73 ± 15%      +0.3        1.02 ± 10%  perf-profile.self.cycles-pp.file_free_rcu
      0.29 ± 12%      +0.3        0.60 ± 19%  perf-profile.self.cycles-pp.dput
      0.55 ±  4%      +0.3        0.88 ± 13%  perf-profile.self.cycles-pp.call_rcu
      0.81 ±  8%      +0.4        1.16 ± 10%  perf-profile.self.cycles-pp.task_work_run
      1.20 ± 11%      +0.4        1.58 ±  9%  perf-profile.self.cycles-pp.___might_sleep
      1.02 ±  9%      +0.5        1.56 ± 10%  perf-profile.self.cycles-pp.link_path_walk
      0.00            +0.6        0.63 ± 21%  perf-profile.self.cycles-pp.__d_lookup
      0.00            +1.1        1.09 ±  7%  perf-profile.self.cycles-pp.lockref_put_return
      0.68 ± 10%      +1.1        1.82 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock
      0.25 ± 20%      +2.1        2.38 ± 11%  perf-profile.self.cycles-pp.lockref_get
      1.06 ±  5%      +2.3        3.39 ±  8%  perf-profile.self.cycles-pp.__alloc_file


                                                                                
                            will-it-scale.per_process_ops                       
                                                                                
  480000 +------------------------------------------------------------------+   
  460000 |-+                               +.+                    +         |   
         | .++.        +.+     .++.  .+ +. : :                    :+. +.+ .+|   
  440000 |++   ++.+++.+   +.+++    ++  +  +   :                  :   +   +  |   
  420000 |-+                                  :+.++.++.+ +.++.++.+          |   
         |                                    +         +                   |   
  400000 |-+                                                                |   
  380000 |-+                                                                |   
  360000 |-+                                                                |   
         |                                                                  |   
  340000 |-+                                                                |   
  320000 |O+OO OO OO                         O O                            |   
         |          O OO OO OOO O  OO OOO OO  O  OO OO OOO  O OO OO         |   
  300000 |-+                     O                         O                |   
  280000 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                            will-it-scale.per_thread_ops                        
                                                                                
  460000 +------------------------------------------------------------------+   
         |                                  .+                              |   
  440000 |+.++.     +.++.+   ++.++.  .+++.++ :                    ++.++.++.+|   
  420000 |-+   ++.++      +.+      ++         :                   :         |   
         |                                    + .++.++.++ .++.++.+          |   
  400000 |-+                                   +         +                  |   
  380000 |-+                                                                |   
         |                                                                  |   
  360000 |-+                                                                |   
  340000 |-+                                                                |   
         |                                                                  |   
  320000 |-+                                                                |   
  300000 |O+OO OO OOO OO OO O O O   O  O  OO OOO OO OO OOO  O  O OO         |   
         |                   O   O O  O O                  O  O             |   
  280000 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                will-it-scale.workload                          
                                                                                
  8.5e+06 +-----------------------------------------------------------------+   
          |                                .++                    +.+ +.    |   
    8e+06 |+.++.++   +.+++.++.+++.++.+++.++   :                   :  +  ++.+|   
          |       +.+                         :                  :          |   
  7.5e+06 |-+                                  +++.++.+++.++.+++.+          |   
          |                                                                 |   
    7e+06 |-+                                                               |   
          |                                                                 |   
  6.5e+06 |-+                                                               |   
          |                                                                 |   
    6e+06 |-+                                                               |   
          |O OO OOO  O                       O OOO                          |   
  5.5e+06 |-+       O  OOO OO OOO  O OOO OO O      OO OOO OO OOO OO         |   
          |                       O                                         |   
    5e+06 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                           will-it-scale.time.user_time                         
                                                                                
  100 +---------------------------------------------------------------------+   
      |        +                     +     +                       +   .++. |   
   95 |+.++.  + +.++.++.  .++.++.  .+ + +.+ :                     + + +    +|   
      |     ++          ++       ++    +    :                    +   +      |   
   90 |-+                                    ++.++.++.++.++.++.++           |   
      |                                                                     |   
   85 |-+                                                                   |   
      |                                                                     |   
   80 |-+                                                                   |   
      |                                                                     |   
   75 |-+                                                                   |   
      |                                                                     |   
   70 |-+            O           OO  O                                      |   
      |O  O OO OO OO  O OO    OO    O  O  OO OO OO OO OO O  O   O O         |   
   65 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                          will-it-scale.time.system_time                        
                                                                                
  315 +---------------------------------------------------------------------+   
      |     OO O      O  O O  OO    O  OO  O O  O  O  OO O  O  OO O         |   
  310 |O+ O     O OO O  O        OO  O    O   O  O  O                       |   
      |                                                                     |   
  305 |-+                                                                   |   
      |                                                                     |   
  300 |-+                                                                   |   
      |                                                                     |   
  295 |-+                                                                   |   
      |                                                                     |   
  290 |-+                                    ++.++. +. +.++.+ .+            |   
      |    .++         .++      .++.        :      +  +      +  +           |   
  285 |+.++   +    +.++   + +.++    + .+    :                    +  .++.    |   
      |        ++.+        +         +  +.++                      ++    + .+|   
  280 +---------------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-ivb-d02: 4 threads Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 8G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
  gcc-7/performance/x86_64-rhel-7.6/thread/16/debian-x86_64-20191114.cgz/lkp-ivb-d02/open1/will-it-scale/0x21

commit: 
  7ef482fa65 ("helper for mount rootwards traversal")
  2aa3847085 ("non-RCU analogue of the previous commit")

7ef482fa65513b18 2aa38470853a65dc9b1b4bd0989 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :4           25%           1:4     dmesg.WARNING:at_ip__fsnotify_parent/0x
         %stddev     %change         %stddev
             \          |                \  
     80534           -28.9%      57267        will-it-scale.per_thread_ops
   1209875 ±  4%      -6.0%    1136859        will-it-scale.time.involuntary_context_switches
    381.00            +1.6%     387.00        will-it-scale.time.percent_of_cpu_this_job_got
    869.04           +10.7%     962.00        will-it-scale.time.system_time
    280.00           -26.5%     205.70        will-it-scale.time.user_time
   1288551           -28.9%     916290        will-it-scale.workload
      2678 ±  2%     +52.3%       4079 ± 30%  cpuidle.C6.usage
     25.32            -6.6       18.71        mpstat.cpu.all.usr%
     73.50            +8.8%      80.00        vmstat.cpu.sy
     24.50 ±  2%     -26.5%      18.00        vmstat.cpu.us
      8674 ±  4%     -10.3%       7782        vmstat.system.cs
     11815 ±  9%     +75.9%      20788        slabinfo.filp.active_objs
    748.75 ±  8%     +74.5%       1306        slabinfo.filp.active_slabs
     11984 ±  8%     +74.5%      20916        slabinfo.filp.num_objs
    748.75 ±  8%     +74.5%       1306        slabinfo.filp.num_slabs
      6748            +8.1%       7291        proc-vmstat.nr_slab_unreclaimable
  17375304 ±  3%     +53.2%   26621934        proc-vmstat.numa_hit
  17375304 ±  3%     +53.2%   26621934        proc-vmstat.numa_local
  17423549 ±  3%     +53.2%   26690139        proc-vmstat.pgalloc_normal
  17406780 ±  3%     +53.2%   26673747        proc-vmstat.pgfree
   2059972 ± 39%     -60.2%     820224 ±  7%  softirqs.CPU0.RCU
   1924107 ± 37%     -56.0%     845975 ±  4%  softirqs.CPU1.RCU
   2130024 ± 40%     -66.0%     723748 ± 23%  softirqs.CPU2.RCU
   2656995 ± 12%     -71.7%     752958 ± 16%  softirqs.CPU3.RCU
    141120 ±  7%     +12.8%     159192 ±  3%  softirqs.CPU3.TIMER
   8771098 ± 28%     -64.2%    3142908 ± 11%  softirqs.RCU
    319.89 ±  5%     -21.8%     250.19 ± 17%  sched_debug.cfs_rq:/.exec_clock.stddev
     11777 ± 14%     -42.6%       6765 ± 42%  sched_debug.cfs_rq:/.min_vruntime.stddev
     10.94 ± 16%     -21.3%       8.61 ± 18%  sched_debug.cfs_rq:/.nr_spread_over.stddev
    -18526           -84.1%      -2941        sched_debug.cfs_rq:/.spread0.min
     11778 ± 14%     -42.6%       6762 ± 42%  sched_debug.cfs_rq:/.spread0.stddev
    127398 ±  6%     -24.0%      96759 ±  8%  sched_debug.cpu.nr_switches.min
    118816 ±  8%     -27.5%      86181 ±  9%  sched_debug.cpu.sched_count.min
     56655 ± 12%     -39.9%      34064 ± 12%  sched_debug.cpu.ttwu_count.min
     50390 ± 12%     -42.4%      29046 ± 13%  sched_debug.cpu.ttwu_local.min
     10707 ± 24%     -39.1%       6526        interrupts.CPU0.NMI:Non-maskable_interrupts
     10707 ± 24%     -39.1%       6526        interrupts.CPU0.PMI:Performance_monitoring_interrupts
      8800 ± 11%     -36.6%       5575 ± 35%  interrupts.CPU0.RES:Rescheduling_interrupts
     13839 ± 62%     -49.9%       6926 ± 10%  interrupts.CPU1.RES:Rescheduling_interrupts
    609417          +126.2%    1378486 ±  2%  interrupts.CPU2.LOC:Local_timer_interrupts
     10145 ± 12%     -70.3%       3018 ±  9%  interrupts.CPU2.RES:Rescheduling_interrupts
   1197286 ± 28%     -49.4%     605952        interrupts.CPU3.LOC:Local_timer_interrupts
     43455 ±  9%     -24.3%      32916 ± 21%  interrupts.NMI:Non-maskable_interrupts
     43455 ±  9%     -24.3%      32916 ± 21%  interrupts.PMI:Performance_monitoring_interrupts
     39979 ± 20%     -42.5%      22985 ±  5%  interrupts.RES:Rescheduling_interrupts
      2.85 ±  2%     +13.7%       3.24 ±  2%  perf-stat.i.MPKI
 1.428e+09           +14.3%  1.633e+09        perf-stat.i.branch-instructions
      1.06            -0.1        0.99        perf-stat.i.branch-miss-rate%
  15174211 ±  2%      +7.2%   16260168        perf-stat.i.branch-misses
     12.45 ±  3%      +3.1       15.52 ±  3%  perf-stat.i.cache-miss-rate%
   2527696 ±  4%     +60.1%    4047737        perf-stat.i.cache-misses
  20497447 ±  2%     +28.4%   26309371 ±  2%  perf-stat.i.cache-references
      8739 ±  4%     -10.3%       7839        perf-stat.i.context-switches
      1.82           -11.5%       1.61        perf-stat.i.cpi
      5233 ±  4%     -38.1%       3239        perf-stat.i.cycles-between-cache-misses
      2.21 ± 19%      -0.7        1.53 ± 13%  perf-stat.i.dTLB-load-miss-rate%
 2.111e+09           +12.8%  2.381e+09        perf-stat.i.dTLB-loads
      0.39 ±  2%      -0.1        0.27 ±  7%  perf-stat.i.dTLB-store-miss-rate%
   5645399 ±  2%     -22.9%    4353851 ±  7%  perf-stat.i.dTLB-store-misses
  1.44e+09           +11.5%  1.606e+09        perf-stat.i.dTLB-stores
   1629748 ±  2%     -26.2%    1202465        perf-stat.i.iTLB-load-misses
     64708 ± 49%     -63.7%      23494 ± 14%  perf-stat.i.iTLB-loads
 7.195e+09           +13.0%  8.128e+09        perf-stat.i.instructions
      4458 ±  2%     +52.9%       6815        perf-stat.i.instructions-per-iTLB-miss
      0.55           +12.9%       0.62        perf-stat.i.ipc
      2.85 ±  2%     +13.6%       3.24 ±  2%  perf-stat.overall.MPKI
      1.06            -0.1        1.00        perf-stat.overall.branch-miss-rate%
     12.33 ±  3%      +3.1       15.40 ±  3%  perf-stat.overall.cache-miss-rate%
      1.82           -11.5%       1.61        perf-stat.overall.cpi
      5179 ±  4%     -37.6%       3229        perf-stat.overall.cycles-between-cache-misses
      2.22 ± 19%      -0.7        1.53 ± 13%  perf-stat.overall.dTLB-load-miss-rate%
      0.39 ±  2%      -0.1        0.27 ±  7%  perf-stat.overall.dTLB-store-miss-rate%
      4417 ±  2%     +53.0%       6759        perf-stat.overall.instructions-per-iTLB-miss
      0.55           +13.0%       0.62        perf-stat.overall.ipc
   1681463           +58.9%    2671230        perf-stat.overall.path-length
 1.423e+09           +14.3%  1.627e+09        perf-stat.ps.branch-instructions
  15124201 ±  2%      +7.2%   16206764        perf-stat.ps.branch-misses
   2519326 ±  4%     +60.1%    4034326        perf-stat.ps.cache-misses
  20429539 ±  2%     +28.4%   26222166 ±  2%  perf-stat.ps.cache-references
      8710 ±  4%     -10.3%       7813        perf-stat.ps.context-switches
 2.104e+09           +12.8%  2.373e+09        perf-stat.ps.dTLB-loads
   5626686 ±  2%     -22.9%    4339437 ±  7%  perf-stat.ps.dTLB-store-misses
 1.435e+09           +11.5%    1.6e+09        perf-stat.ps.dTLB-stores
   1624347 ±  2%     -26.2%    1198481        perf-stat.ps.iTLB-load-misses
     64495 ± 49%     -63.7%      23417 ± 14%  perf-stat.ps.iTLB-loads
 7.171e+09           +13.0%  8.101e+09        perf-stat.ps.instructions
 2.167e+12           +13.0%  2.448e+12        perf-stat.total.instructions
     33.37            -8.7       24.65        perf-profile.calltrace.cycles-pp.__GI___libc_close
     24.32            -6.4       17.91        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__GI___libc_close
     23.88            -6.3       17.60        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_close
     13.31            -3.5        9.81 ±  2%  perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_close
     12.42            -3.3        9.11 ±  2%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_close
      5.68            -1.6        4.12 ±  2%  perf-profile.calltrace.cycles-pp.do_dentry_open.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      5.72            -1.6        4.17 ±  2%  perf-profile.calltrace.cycles-pp.getname_flags.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.34 ±  2%      -1.2        3.12 ±  2%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__GI___libc_close
      3.78 ±  2%      -1.1        2.64 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__GI___libc_close
      4.01            -1.0        3.00 ±  8%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_close
      3.67            -0.9        2.74 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__GI___libc_open
      3.39 ±  2%      -0.9        2.47 ±  2%  perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.do_sys_openat2.do_sys_open.do_syscall_64
      3.98 ±  4%      -0.9        3.07        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__GI___libc_open
      2.59 ±  2%      -0.9        1.72        perf-profile.calltrace.cycles-pp.__alloc_fd.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.46 ±  2%      -0.7        1.80 ±  2%  perf-profile.calltrace.cycles-pp.security_file_open.do_dentry_open.path_openat.do_filp_open.do_sys_openat2
      2.08 ±  2%      -0.6        1.46        perf-profile.calltrace.cycles-pp.ima_file_check.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      2.52 ±  2%      -0.6        1.91 ±  2%  perf-profile.calltrace.cycles-pp.__check_object_size.strncpy_from_user.getname_flags.do_sys_openat2.do_sys_open
      2.10 ±  4%      -0.6        1.50        perf-profile.calltrace.cycles-pp.apparmor_file_open.security_file_open.do_dentry_open.path_openat.do_filp_open
      1.33 ±  2%      -0.6        0.74        perf-profile.calltrace.cycles-pp.complete_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      1.82 ±  2%      -0.5        1.32 ± 15%  perf-profile.calltrace.cycles-pp.__close_fd.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_close
      1.81            -0.5        1.32 ±  9%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.getname_flags.do_sys_openat2.do_sys_open.do_syscall_64
      0.75 ± 11%      -0.5        0.26 ±100%  perf-profile.calltrace.cycles-pp.__fd_install.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.65 ±  3%      -0.5        1.19        perf-profile.calltrace.cycles-pp.security_task_getsecid.ima_file_check.path_openat.do_filp_open.do_sys_openat2
      0.70 ±  5%      -0.4        0.26 ±100%  perf-profile.calltrace.cycles-pp.task_work_add.fput_many.filp_close.__x64_sys_close.do_syscall_64
      1.10 ±  5%      -0.4        0.69 ±  7%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__alloc_fd.do_sys_openat2.do_sys_open.do_syscall_64
      0.68 ±  5%      -0.4        0.27 ±100%  perf-profile.calltrace.cycles-pp.__pthread_enable_asynccancel
      1.43 ±  3%      -0.4        1.03        perf-profile.calltrace.cycles-pp.apparmor_task_getsecid.security_task_getsecid.ima_file_check.path_openat.do_filp_open
      7.59 ±  2%      -0.4        7.19 ±  2%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.66            -0.4        1.28 ±  7%  perf-profile.calltrace.cycles-pp.filp_close.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_close
      1.38 ±  3%      -0.4        1.03 ± 15%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__close_fd.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.10 ±  5%      -0.3        0.75 ±  5%  perf-profile.calltrace.cycles-pp.fput_many.filp_close.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.72 ±  5%      -0.3        0.40 ± 57%  perf-profile.calltrace.cycles-pp.rcu_segcblist_enqueue.call_rcu.task_work_run.exit_to_usermode_loop.do_syscall_64
      0.69 ±  3%      -0.3        0.40 ± 57%  perf-profile.calltrace.cycles-pp.aa_get_task_label.apparmor_task_getsecid.security_task_getsecid.ima_file_check.path_openat
      0.67 ±  5%      -0.3        0.40 ± 58%  perf-profile.calltrace.cycles-pp.__pthread_disable_asynccancel
      0.96 ± 10%      -0.3        0.70 ±  5%  perf-profile.calltrace.cycles-pp.dput.__fput.task_work_run.exit_to_usermode_loop.do_syscall_64
      0.67 ±  3%      -0.2        0.42 ± 57%  perf-profile.calltrace.cycles-pp.inode_permission.may_open.path_openat.do_filp_open.do_sys_openat2
      0.94 ±  5%      -0.2        0.70 ±  7%  perf-profile.calltrace.cycles-pp.__d_lookup_rcu.lookup_fast.path_openat.do_filp_open.do_sys_openat2
      0.97            -0.2        0.80 ±  3%  perf-profile.calltrace.cycles-pp.__virt_addr_valid.__check_object_size.strncpy_from_user.getname_flags.do_sys_openat2
      1.07 ±  3%      -0.1        0.94 ±  5%  perf-profile.calltrace.cycles-pp.may_open.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.55 ±  5%      +0.2        0.78        perf-profile.calltrace.cycles-pp.memset_erms.kmem_cache_alloc.__alloc_file.alloc_empty_file.path_openat
      1.74 ±  7%      +0.3        2.02 ±  7%  perf-profile.calltrace.cycles-pp.apparmor_file_free_security.security_file_free.__fput.task_work_run.exit_to_usermode_loop
      0.55 ±  8%      +0.3        0.83 ±  2%  perf-profile.calltrace.cycles-pp.generic_permission.inode_permission.link_path_walk.path_openat.do_filp_open
      0.93 ±  3%      +0.3        1.24 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.98 ±  6%      +0.3        2.29 ±  6%  perf-profile.calltrace.cycles-pp.security_file_free.__fput.task_work_run.exit_to_usermode_loop.do_syscall_64
      0.91 ±  5%      +0.4        1.32        perf-profile.calltrace.cycles-pp.inode_permission.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.66 ±  4%      +0.5        1.16 ±  7%  perf-profile.calltrace.cycles-pp.new_slab.___slab_alloc.__slab_alloc.kmem_cache_alloc.__alloc_file
      0.00            +0.6        0.57 ±  4%  perf-profile.calltrace.cycles-pp.lockref_put_return.dput.terminate_walk.path_openat.do_filp_open
      0.98 ±  3%      +0.6        1.55 ±  3%  perf-profile.calltrace.cycles-pp.___slab_alloc.__slab_alloc.kmem_cache_alloc.__alloc_file.alloc_empty_file
      0.00            +0.6        0.57 ±  7%  perf-profile.calltrace.cycles-pp.task_work_add.fput_many.path_openat.do_filp_open.do_sys_openat2
      1.15 ±  3%      +0.6        1.73 ±  2%  perf-profile.calltrace.cycles-pp.lookup_fast.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      1.02 ±  3%      +0.6        1.63 ±  3%  perf-profile.calltrace.cycles-pp.__slab_alloc.kmem_cache_alloc.__alloc_file.alloc_empty_file.path_openat
      0.00            +0.6        0.61 ±  7%  perf-profile.calltrace.cycles-pp.memset_erms.kmem_cache_alloc.security_file_alloc.__alloc_file.alloc_empty_file
      1.45 ±  2%      +0.7        2.14 ±  3%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.security_file_alloc.__alloc_file.alloc_empty_file.path_openat
      0.00            +0.7        0.70 ±  4%  perf-profile.calltrace.cycles-pp.__d_lookup.lookup_fast.path_openat.do_filp_open.do_sys_openat2
      0.00            +0.8        0.75 ± 11%  perf-profile.calltrace.cycles-pp.lockref_get.__traverse_mounts.step_into.walk_component.link_path_walk
      0.00            +0.8        0.76 ±  4%  perf-profile.calltrace.cycles-pp.lockref_get.set_root.nd_jump_root.path_init.path_openat
      1.38 ± 15%      +0.8        2.21 ±  6%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_openat.do_filp_open
      1.15 ±  9%      +0.8        1.98 ±  2%  perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_openat2
      1.67 ±  3%      +0.9        2.52 ±  2%  perf-profile.calltrace.cycles-pp.call_rcu.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.95            +0.9        2.81 ±  2%  perf-profile.calltrace.cycles-pp.apparmor_file_alloc_security.security_file_alloc.__alloc_file.alloc_empty_file.path_openat
      0.00            +0.9        0.89 ±  9%  perf-profile.calltrace.cycles-pp.fput_many.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00            +0.9        0.89 ±  4%  perf-profile.calltrace.cycles-pp.dput.__traverse_mounts.step_into.walk_component.link_path_walk
      0.00            +0.9        0.90 ±  5%  perf-profile.calltrace.cycles-pp.dput.step_into.path_openat.do_filp_open.do_sys_openat2
      0.00            +0.9        0.91 ±  3%  perf-profile.calltrace.cycles-pp.dput.step_into.walk_component.link_path_walk.path_openat
      0.00            +1.0        0.96 ±  2%  perf-profile.calltrace.cycles-pp.__d_lookup.lookup_fast.walk_component.link_path_walk.path_openat
      0.00            +1.0        1.02 ±  3%  perf-profile.calltrace.cycles-pp.lookup_mnt.__traverse_mounts.step_into.walk_component.link_path_walk
      0.00            +1.0        1.02 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock.set_root.nd_jump_root.path_init.path_openat
      1.79 ±  5%      +1.2        2.97 ±  2%  perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00            +1.4        1.44 ±  5%  perf-profile.calltrace.cycles-pp.step_into.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      2.90 ±  3%      +1.5        4.38        perf-profile.calltrace.cycles-pp.kmem_cache_alloc.__alloc_file.alloc_empty_file.path_openat.do_filp_open
      3.74            +1.6        5.38 ±  2%  perf-profile.calltrace.cycles-pp.security_file_alloc.__alloc_file.alloc_empty_file.path_openat.do_filp_open
      0.65 ±  7%      +2.2        2.87 ±  3%  perf-profile.calltrace.cycles-pp.set_root.nd_jump_root.path_init.path_openat.do_filp_open
      0.97 ±  6%      +2.7        3.71 ±  2%  perf-profile.calltrace.cycles-pp.nd_jump_root.path_init.path_openat.do_filp_open.do_sys_openat2
      1.43 ±  3%      +2.9        4.30 ±  2%  perf-profile.calltrace.cycles-pp.path_init.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00            +3.1        3.12 ±  3%  perf-profile.calltrace.cycles-pp.__traverse_mounts.step_into.walk_component.link_path_walk.path_openat
      8.57            +3.9       12.46        perf-profile.calltrace.cycles-pp.__alloc_file.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
      9.01            +4.0       13.05        perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      1.30 ±  7%      +4.4        5.75        perf-profile.calltrace.cycles-pp.step_into.walk_component.link_path_walk.path_openat.do_filp_open
      0.00            +4.9        4.90        perf-profile.calltrace.cycles-pp.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_open
      2.92 ±  6%      +5.4        8.35 ±  2%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.00            +5.7        5.75        perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_open
      5.55 ±  3%      +6.8       12.32 ±  2%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
     44.91           +10.5       55.38        perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_open
     44.45           +10.6       55.10        perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_open
     61.57           +12.3       73.84        perf-profile.calltrace.cycles-pp.__GI___libc_open
     52.96           +13.9       66.83        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__GI___libc_open
     52.51           +14.0       66.51        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_open
     31.75           +14.5       46.30        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
     30.92           +14.7       45.59        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
     33.83            -8.8       25.02        perf-profile.children.cycles-pp.__GI___libc_close
      3.25 ±  7%      -3.2        0.04 ±104%  perf-profile.children.cycles-pp.ret_from_fork
      3.25 ±  7%      -3.2        0.04 ±104%  perf-profile.children.cycles-pp.kthread
      9.17 ±  2%      -2.4        6.77        perf-profile.children.cycles-pp.syscall_return_via_sysret
      7.47            -2.1        5.39 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      5.75            -1.6        4.15 ±  2%  perf-profile.children.cycles-pp.do_dentry_open
      5.75            -1.6        4.19 ±  2%  perf-profile.children.cycles-pp.getname_flags
      4.01            -1.0        3.02 ±  8%  perf-profile.children.cycles-pp.__x64_sys_close
      3.42 ±  2%      -0.9        2.49 ±  2%  perf-profile.children.cycles-pp.strncpy_from_user
      2.62 ±  2%      -0.9        1.75        perf-profile.children.cycles-pp.__alloc_fd
      1.21 ±  2%      -0.7        0.51 ±  4%  perf-profile.children.cycles-pp.unlazy_walk
      2.48 ±  2%      -0.7        1.82 ±  2%  perf-profile.children.cycles-pp.security_file_open
      2.12 ±  2%      -0.6        1.48        perf-profile.children.cycles-pp.ima_file_check
      2.60 ±  2%      -0.6        1.97 ±  3%  perf-profile.children.cycles-pp.__check_object_size
      1.36 ±  3%      -0.6        0.75        perf-profile.children.cycles-pp.complete_walk
      2.10 ±  4%      -0.6        1.50        perf-profile.children.cycles-pp.apparmor_file_open
      1.58 ± 18%      -0.5        1.06 ± 15%  perf-profile.children.cycles-pp.fsnotify
      1.83 ±  2%      -0.5        1.33 ± 14%  perf-profile.children.cycles-pp.__close_fd
      1.66 ±  3%      -0.5        1.20        perf-profile.children.cycles-pp.security_task_getsecid
      2.07 ±  8%      -0.5        1.62 ±  5%  perf-profile.children.cycles-pp.__d_lookup_rcu
      7.77 ±  2%      -0.4        7.35 ±  2%  perf-profile.children.cycles-pp.__fput
      1.46 ±  3%      -0.4        1.04        perf-profile.children.cycles-pp.apparmor_task_getsecid
      1.69            -0.4        1.31 ±  7%  perf-profile.children.cycles-pp.filp_close
      0.98 ±  9%      -0.3        0.70 ±  5%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.75 ± 11%      -0.3        0.47 ±  8%  perf-profile.children.cycles-pp.__fd_install
      0.99            -0.2        0.81 ±  3%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.68 ±  5%      -0.2        0.51 ±  7%  perf-profile.children.cycles-pp.__pthread_enable_asynccancel
      0.69 ±  3%      -0.2        0.52 ±  4%  perf-profile.children.cycles-pp.aa_get_task_label
      0.67 ±  5%      -0.2        0.51 ± 10%  perf-profile.children.cycles-pp.__pthread_disable_asynccancel
      0.52 ±  5%      -0.2        0.37 ±  7%  perf-profile.children.cycles-pp.__mnt_want_write
      1.12 ±  3%      -0.1        0.98 ±  5%  perf-profile.children.cycles-pp.may_open
      0.54 ±  3%      -0.1        0.40 ±  5%  perf-profile.children.cycles-pp.__check_heap_object
      0.26 ±  8%      -0.1        0.16 ± 12%  perf-profile.children.cycles-pp.vfs_open
      0.37 ±  3%      -0.1        0.26 ±  4%  perf-profile.children.cycles-pp.__x64_sys_open
      0.21 ± 16%      -0.1        0.12 ± 23%  perf-profile.children.cycles-pp.restore_nameidata
      0.11 ±  7%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.schedule
      0.30 ±  4%      -0.1        0.24 ± 10%  perf-profile.children.cycles-pp._find_next_bit
      0.27 ±  9%      -0.1        0.21 ± 18%  perf-profile.children.cycles-pp.expand_files
      0.15 ±  3%      -0.1        0.09 ±  9%  perf-profile.children.cycles-pp.__sched_text_start
      0.12 ±  7%      -0.1        0.07 ± 13%  perf-profile.children.cycles-pp.check_stack_object
      0.14 ±  5%      -0.0        0.10 ± 17%  perf-profile.children.cycles-pp.put_pid
      0.16 ± 10%      -0.0        0.12 ± 13%  perf-profile.children.cycles-pp.process_measurement
      0.05 ±  8%      +0.0        0.08 ± 20%  perf-profile.children.cycles-pp.bit_putcs
      0.05 ±  8%      +0.0        0.08 ± 19%  perf-profile.children.cycles-pp.fbcon_putcs
      0.04 ± 58%      +0.0        0.08 ± 10%  perf-profile.children.cycles-pp.legitimize_links
      0.03 ±100%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.kick_process
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.discard_slab
      0.03 ±100%      +0.1        0.08 ± 15%  perf-profile.children.cycles-pp.alloc_pages_current
      0.01 ±173%      +0.1        0.07 ± 22%  perf-profile.children.cycles-pp.setup_object_debug
      0.01 ±173%      +0.1        0.07 ± 22%  perf-profile.children.cycles-pp.memset
      0.00            +0.1        0.07 ± 23%  perf-profile.children.cycles-pp.fput
      0.04 ± 59%      +0.1        0.11 ±  9%  perf-profile.children.cycles-pp.free_unref_page
      0.44 ± 10%      +0.1        0.52 ±  7%  perf-profile.children.cycles-pp.__lookup_mnt
      0.19 ± 15%      +0.1        0.27 ± 14%  perf-profile.children.cycles-pp.mntget
      0.26 ±  7%      +0.1        0.36 ±  9%  perf-profile.children.cycles-pp.path_get
      0.13 ± 11%      +0.1        0.25 ±  4%  perf-profile.children.cycles-pp.mem_cgroup_handle_over_high
      0.72 ±  9%      +0.1        0.84 ±  4%  perf-profile.children.cycles-pp.lockref_put_or_lock
      0.18 ±  6%      +0.1        0.31 ±  3%  perf-profile.children.cycles-pp.unfreeze_partials
      0.21 ±  7%      +0.1        0.34 ±  3%  perf-profile.children.cycles-pp.put_cpu_partial
      0.09 ± 15%      +0.1        0.23 ± 10%  perf-profile.children.cycles-pp.mntput
      0.18 ± 10%      +0.1        0.33 ± 14%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.59 ±  4%      +0.2        0.76 ±  5%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.65 ±  6%      +0.2        0.83        perf-profile.children.cycles-pp.rcu_all_qs
      0.17 ± 11%      +0.2        0.36 ± 11%  perf-profile.children.cycles-pp.blkcg_maybe_throttle_current
      0.28 ±  9%      +0.2        0.49 ± 15%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      0.88 ±  3%      +0.2        1.12        perf-profile.children.cycles-pp.generic_permission
      0.64 ±  6%      +0.3        0.89 ±  6%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.72 ±  5%      +0.3        0.99 ±  3%  perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.79 ±  7%      +0.3        1.07 ±  5%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.75 ±  7%      +0.3        2.04 ±  7%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.82 ±  5%      +0.3        1.12 ±  5%  perf-profile.children.cycles-pp.__slab_free
      1.60 ±  3%      +0.3        1.91 ±  2%  perf-profile.children.cycles-pp.inode_permission
      0.00            +0.3        0.31 ±  6%  perf-profile.children.cycles-pp.__legitimize_path
      0.94 ±  3%      +0.3        1.25 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      1.98 ±  6%      +0.3        2.30 ±  6%  perf-profile.children.cycles-pp.security_file_free
      0.60 ±  7%      +0.3        0.93        perf-profile.children.cycles-pp.mntput_no_expire
      0.71 ±  5%      +0.4        1.08 ±  6%  perf-profile.children.cycles-pp.task_work_add
      0.99 ±  3%      +0.5        1.45 ±  3%  perf-profile.children.cycles-pp.memset_erms
      0.00            +0.5        0.47 ±  8%  perf-profile.children.cycles-pp.legitimize_mnt
      1.16 ±  4%      +0.5        1.65 ±  3%  perf-profile.children.cycles-pp._cond_resched
      0.67 ±  4%      +0.5        1.18 ±  7%  perf-profile.children.cycles-pp.new_slab
      1.12 ±  5%      +0.6        1.68 ±  7%  perf-profile.children.cycles-pp.fput_many
      0.98 ±  3%      +0.6        1.56 ±  3%  perf-profile.children.cycles-pp.___slab_alloc
      0.89 ±  7%      +0.6        1.51 ±  7%  perf-profile.children.cycles-pp.__might_sleep
      1.02 ±  3%      +0.6        1.64 ±  3%  perf-profile.children.cycles-pp.__slab_alloc
      1.31 ± 11%      +0.6        1.93 ±  4%  perf-profile.children.cycles-pp.file_free_rcu
      1.58 ±  2%      +0.9        2.43 ±  3%  perf-profile.children.cycles-pp.___might_sleep
      1.98            +0.9        2.84 ±  2%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      1.70 ±  3%      +0.9        2.58 ±  2%  perf-profile.children.cycles-pp.call_rcu
      3.98 ±  7%      +1.0        5.00 ±  3%  perf-profile.children.cycles-pp.__softirqentry_text_start
      2.55 ±  4%      +1.0        3.60 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock
      0.00            +1.1        1.06 ±  3%  perf-profile.children.cycles-pp.lookup_mnt
      3.80 ±  7%      +1.1        4.92 ±  3%  perf-profile.children.cycles-pp.rcu_core
      1.84 ±  4%      +1.2        3.08 ±  2%  perf-profile.children.cycles-pp.terminate_walk
      3.59 ±  7%      +1.3        4.87 ±  3%  perf-profile.children.cycles-pp.rcu_do_batch
      0.00            +1.3        1.31 ±  4%  perf-profile.children.cycles-pp.lockref_put_return
      2.56 ±  8%      +1.4        3.99        perf-profile.children.cycles-pp.lookup_fast
     12.49            +1.6       14.11        perf-profile.children.cycles-pp.task_work_run
      3.74            +1.7        5.39 ±  2%  perf-profile.children.cycles-pp.security_file_alloc
      0.00            +1.7        1.69 ±  3%  perf-profile.children.cycles-pp.__d_lookup
      0.33 ±  5%      +1.7        2.03 ±  6%  perf-profile.children.cycles-pp.lockref_get
      6.36            +1.7        8.06        perf-profile.children.cycles-pp.kmem_cache_alloc
      0.65 ±  7%      +2.3        2.91 ±  3%  perf-profile.children.cycles-pp.set_root
     13.41            +2.3       15.69        perf-profile.children.cycles-pp.exit_to_usermode_loop
      1.00 ±  5%      +2.8        3.77 ±  2%  perf-profile.children.cycles-pp.nd_jump_root
      1.47 ±  3%      +2.9        4.34 ±  2%  perf-profile.children.cycles-pp.path_init
      0.00            +3.2        3.18 ±  3%  perf-profile.children.cycles-pp.__traverse_mounts
      2.25 ±  8%      +3.4        5.69        perf-profile.children.cycles-pp.dput
      8.62            +3.9       12.52        perf-profile.children.cycles-pp.__alloc_file
      9.08            +4.0       13.12        perf-profile.children.cycles-pp.alloc_empty_file
      0.86 ± 11%      +4.1        4.99 ±  4%  perf-profile.children.cycles-pp.irq_exit
      1.32 ± 13%      +4.2        5.47 ±  6%  perf-profile.children.cycles-pp.smp_apic_timer_interrupt
      1.37 ± 13%      +4.2        5.53 ±  6%  perf-profile.children.cycles-pp.apic_timer_interrupt
      2.95 ±  6%      +5.4        8.40 ±  2%  perf-profile.children.cycles-pp.walk_component
      1.64 ±  6%      +5.6        7.28        perf-profile.children.cycles-pp.step_into
      5.58 ±  3%      +6.8       12.41 ±  2%  perf-profile.children.cycles-pp.link_path_walk
     77.59            +7.5       85.05        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     76.78            +7.7       84.50        perf-profile.children.cycles-pp.do_syscall_64
     44.94           +10.5       55.41        perf-profile.children.cycles-pp.do_sys_open
     44.58           +10.6       55.18        perf-profile.children.cycles-pp.do_sys_openat2
     62.02           +12.2       74.17        perf-profile.children.cycles-pp.__GI___libc_open
     31.82           +14.6       46.38        perf-profile.children.cycles-pp.do_filp_open
     31.17           +14.8       45.95        perf-profile.children.cycles-pp.path_openat
     13.26 ±  3%      -4.1        9.16        perf-profile.self.cycles-pp.do_syscall_64
      9.15 ±  2%      -2.4        6.76        perf-profile.self.cycles-pp.syscall_return_via_sysret
      6.67 ±  2%      -1.9        4.78 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      2.03 ±  5%      -0.6        1.41        perf-profile.self.cycles-pp.apparmor_file_open
      1.53 ± 19%      -0.5        0.99 ± 14%  perf-profile.self.cycles-pp.fsnotify
      2.02 ±  9%      -0.5        1.52 ±  5%  perf-profile.self.cycles-pp.__d_lookup_rcu
      1.12 ±  2%      -0.4        0.67 ±  3%  perf-profile.self.cycles-pp.do_sys_openat2
      1.36 ±  4%      -0.4        0.98 ±  7%  perf-profile.self.cycles-pp.do_dentry_open
      0.90 ±  2%      -0.3        0.58 ±  6%  perf-profile.self.cycles-pp.__alloc_fd
      1.02 ±  5%      -0.3        0.70 ±  9%  perf-profile.self.cycles-pp.__check_object_size
      0.80            -0.3        0.49 ±  8%  perf-profile.self.cycles-pp.strncpy_from_user
      0.92 ±  9%      -0.3        0.62 ±  6%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.73 ± 11%      -0.3        0.44 ±  8%  perf-profile.self.cycles-pp.__fd_install
      0.84 ±  6%      -0.3        0.58 ±  8%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.73 ±  5%      -0.3        0.47 ±  4%  perf-profile.self.cycles-pp.apparmor_task_getsecid
      1.28 ±  4%      -0.2        1.05 ±  5%  perf-profile.self.cycles-pp.__fput
      0.91            -0.2        0.72 ±  4%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.68 ±  5%      -0.2        0.49 ±  9%  perf-profile.self.cycles-pp.__GI___libc_open
      0.65 ±  5%      -0.2        0.47 ±  8%  perf-profile.self.cycles-pp.__pthread_enable_asynccancel
      0.68 ±  5%      -0.2        0.51 ±  7%  perf-profile.self.cycles-pp.__GI___libc_close
      0.67 ±  3%      -0.2        0.50 ±  6%  perf-profile.self.cycles-pp.aa_get_task_label
      0.50 ±  5%      -0.2        0.34 ±  7%  perf-profile.self.cycles-pp.__mnt_want_write
      0.60 ±  5%      -0.2        0.44 ± 11%  perf-profile.self.cycles-pp.__pthread_disable_asynccancel
      0.44 ±  4%      -0.2        0.28 ± 17%  perf-profile.self.cycles-pp.__close_fd
      0.52 ±  3%      -0.1        0.37 ±  5%  perf-profile.self.cycles-pp.__check_heap_object
      0.46 ±  3%      -0.1        0.32 ±  9%  perf-profile.self.cycles-pp.do_filp_open
      0.48 ±  2%      -0.1        0.34 ± 12%  perf-profile.self.cycles-pp.getname_flags
      0.34 ±  5%      -0.1        0.21 ± 22%  perf-profile.self.cycles-pp.do_sys_open
      0.29 ±  5%      -0.1        0.16 ± 12%  perf-profile.self.cycles-pp.ima_file_check
      0.45 ±  8%      -0.1        0.34 ±  8%  perf-profile.self.cycles-pp.__x64_sys_close
      0.32 ±  4%      -0.1        0.22 ±  8%  perf-profile.self.cycles-pp.__x64_sys_open
      0.21 ±  5%      -0.1        0.11 ± 14%  perf-profile.self.cycles-pp.vfs_open
      0.19 ± 15%      -0.1        0.10 ± 26%  perf-profile.self.cycles-pp.restore_nameidata
      0.30 ±  6%      -0.1        0.21 ± 13%  perf-profile.self.cycles-pp._find_next_bit
      0.25 ±  8%      -0.1        0.18 ± 16%  perf-profile.self.cycles-pp.expand_files
      0.10 ± 14%      -0.1        0.05 ± 58%  perf-profile.self.cycles-pp.check_stack_object
      0.18 ±  7%      -0.0        0.13 ± 26%  perf-profile.self.cycles-pp.unlazy_walk
      0.19 ± 12%      -0.0        0.14 ± 16%  perf-profile.self.cycles-pp.rcu_do_batch
      0.15 ± 10%      -0.0        0.11 ± 13%  perf-profile.self.cycles-pp.process_measurement
      0.18 ±  8%      -0.0        0.15 ± 13%  perf-profile.self.cycles-pp.security_task_getsecid
      0.11 ±  9%      -0.0        0.08 ± 15%  perf-profile.self.cycles-pp.put_pid
      0.14 ± 15%      +0.0        0.18 ±  8%  perf-profile.self.cycles-pp.complete_walk
      0.04 ± 57%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.unfreeze_partials
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.discard_slab
      0.06 ± 58%      +0.1        0.11 ± 16%  perf-profile.self.cycles-pp.path_get
      0.01 ±173%      +0.1        0.07 ± 23%  perf-profile.self.cycles-pp.legitimize_links
      0.34 ±  9%      +0.1        0.40 ±  2%  perf-profile.self.cycles-pp.nd_jump_root
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.legitimize_mnt
      0.07 ± 12%      +0.1        0.14 ± 15%  perf-profile.self.cycles-pp.mntput
      0.24 ± 12%      +0.1        0.32 ±  7%  perf-profile.self.cycles-pp.security_file_alloc
      0.10 ± 17%      +0.1        0.18 ±  9%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.10 ± 12%      +0.1        0.19 ±  4%  perf-profile.self.cycles-pp.mem_cgroup_handle_over_high
      0.25 ±  5%      +0.1        0.35 ± 10%  perf-profile.self.cycles-pp.walk_component
      0.52 ±  8%      +0.1        0.63 ±  4%  perf-profile.self.cycles-pp.rcu_all_qs
      0.54 ±  4%      +0.1        0.66 ±  5%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.25 ±  7%      +0.1        0.38 ±  4%  perf-profile.self.cycles-pp.terminate_walk
      0.47 ±  5%      +0.2        0.64 ±  6%  perf-profile.self.cycles-pp.lookup_fast
      0.39 ± 18%      +0.2        0.56 ±  6%  perf-profile.self.cycles-pp.fput_many
      0.00            +0.2        0.16 ±  9%  perf-profile.self.cycles-pp.__legitimize_path
      0.16 ± 10%      +0.2        0.33 ± 11%  perf-profile.self.cycles-pp.blkcg_maybe_throttle_current
      0.85 ±  3%      +0.2        1.03        perf-profile.self.cycles-pp.generic_permission
      0.30 ±  5%      +0.2        0.50 ±  8%  perf-profile.self.cycles-pp.new_slab
      0.61 ±  6%      +0.2        0.86 ±  5%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.47 ±  9%      +0.3        0.72 ±  5%  perf-profile.self.cycles-pp._cond_resched
      0.77 ±  6%      +0.3        1.02 ±  5%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.72 ±  5%      +0.3        0.97 ±  3%  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      1.32 ±  5%      +0.3        1.57 ±  4%  perf-profile.self.cycles-pp.path_openat
      0.58 ±  6%      +0.3        0.85 ±  3%  perf-profile.self.cycles-pp.mntput_no_expire
      0.65 ±  5%      +0.3        0.93 ±  7%  perf-profile.self.cycles-pp.task_work_add
      0.00            +0.3        0.29 ±  6%  perf-profile.self.cycles-pp.lookup_mnt
      0.81 ±  6%      +0.3        1.10 ±  5%  perf-profile.self.cycles-pp.__slab_free
      0.91 ±  3%      +0.3        1.22 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.62 ±  3%      +0.3        0.95 ±  2%  perf-profile.self.cycles-pp.exit_to_usermode_loop
      0.61 ±  8%      +0.3        0.96 ± 10%  perf-profile.self.cycles-pp.set_root
      0.95 ±  4%      +0.4        1.32 ±  2%  perf-profile.self.cycles-pp.memset_erms
      0.00            +0.4        0.45 ±  9%  perf-profile.self.cycles-pp.__traverse_mounts
      1.19 ±  5%      +0.4        1.64 ±  5%  perf-profile.self.cycles-pp.step_into
      0.89 ±  3%      +0.5        1.37 ±  3%  perf-profile.self.cycles-pp.call_rcu
      0.80 ±  6%      +0.5        1.31 ±  7%  perf-profile.self.cycles-pp.__might_sleep
      1.59 ±  2%      +0.5        2.10        perf-profile.self.cycles-pp.apparmor_file_alloc_security
      1.68 ±  4%      +0.6        2.29 ±  5%  perf-profile.self.cycles-pp.task_work_run
      1.27 ± 11%      +0.6        1.89 ±  4%  perf-profile.self.cycles-pp.file_free_rcu
      1.82 ±  4%      +0.6        2.44 ±  4%  perf-profile.self.cycles-pp.__alloc_file
      1.75 ±  5%      +0.6        2.38 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock
      0.53 ± 22%      +0.7        1.19 ±  3%  perf-profile.self.cycles-pp.dput
      1.52 ±  2%      +0.7        2.23 ±  3%  perf-profile.self.cycles-pp.___might_sleep
      1.48 ±  2%      +0.7        2.22 ±  6%  perf-profile.self.cycles-pp.link_path_walk
      0.00            +0.9        0.90 ± 10%  perf-profile.self.cycles-pp.__d_lookup
      0.00            +1.2        1.22 ±  5%  perf-profile.self.cycles-pp.lockref_put_return
      0.33 ±  7%      +1.6        1.92 ±  5%  perf-profile.self.cycles-pp.lockref_get



***************************************************************************************************
lkp-knm01: 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
  gcc-7/performance/x86_64-rhel-7.6/thread/100%/debian-x86_64-20191114.cgz/lkp-knm01/unlink2/will-it-scale/0x11

commit: 
  7ef482fa65 ("helper for mount rootwards traversal")
  2aa3847085 ("non-RCU analogue of the previous commit")

7ef482fa65513b18 2aa38470853a65dc9b1b4bd0989 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          1:4          -25%            :4     dmesg.WARNING:at_ip_filename_parentat/0x
         %stddev     %change         %stddev
             \          |                \  
      1033           -29.5%     728.25 ±  2%  will-it-scale.per_thread_ops
    961210            -3.4%     928587        will-it-scale.time.involuntary_context_switches
    635.18 ± 12%     -36.8%     401.42 ±  6%  will-it-scale.time.user_time
    297743           -29.5%     209901 ±  2%  will-it-scale.workload
     46.32            +0.9%      46.74        boot-time.boot
    509.00 ± 11%   +1061.8%       5913 ± 91%  cpuidle.POLL.usage
      7350            -2.7%       7149        vmstat.system.cs
      0.38 ±  4%      +0.4        0.80 ± 12%  mpstat.cpu.all.soft%
      0.88 ± 10%      -0.3        0.62 ±  5%  mpstat.cpu.all.usr%
    644652            +9.4%     705338 ±  3%  meminfo.Active
    644584            +9.4%     705266 ±  3%  meminfo.Active(anon)
     46008 ±  3%     +36.3%      62728 ± 21%  meminfo.Mapped
    156622 ±  2%     +40.8%     220590 ± 10%  meminfo.Shmem
    644742            +9.4%     705390 ±  3%  numa-meminfo.node0.Active
    644674            +9.4%     705318 ±  3%  numa-meminfo.node0.Active(anon)
    709239            +8.9%     772560 ±  3%  numa-meminfo.node0.FilePages
     35171 ±  4%     +46.9%      51664 ± 26%  numa-meminfo.node0.Mapped
    156627 ±  2%     +40.6%     220204 ± 10%  numa-meminfo.node0.Shmem
    161330            +9.3%     176263 ±  3%  numa-vmstat.node0.nr_active_anon
    177343            +9.0%     193228 ±  3%  numa-vmstat.node0.nr_file_pages
      8919 ±  3%     +46.2%      13040 ± 26%  numa-vmstat.node0.nr_mapped
     39190 ±  2%     +40.7%      55139 ± 10%  numa-vmstat.node0.nr_shmem
    161329            +9.3%     176260 ±  3%  numa-vmstat.node0.nr_zone_active_anon
      1008           +18.8%       1197 ± 13%  sched_debug.cfs_rq:/.exec_clock.stddev
      9.81 ±  5%     +29.4%      12.69 ±  6%  sched_debug.cfs_rq:/.load_avg.avg
     17.08 ± 18%    +243.8%      58.71 ± 33%  sched_debug.cfs_rq:/.nr_spread_over.avg
     81.50 ±  6%     +55.2%     126.45 ± 29%  sched_debug.cfs_rq:/.nr_spread_over.max
      5.85 ± 54%    +382.1%      28.20 ± 43%  sched_debug.cfs_rq:/.nr_spread_over.min
      7.80 ±  7%     +46.4%      11.41 ± 23%  sched_debug.cfs_rq:/.nr_spread_over.stddev
   1824882 ±  7%     -11.8%    1609586 ±  6%  sched_debug.cpu.avg_idle.avg
  12463693 ± 17%     -33.3%    8311654 ±  6%  sched_debug.cpu.avg_idle.max
   1148418 ± 11%     -25.6%     854826 ±  9%  sched_debug.cpu.avg_idle.stddev
    161230            +9.3%     176238 ±  3%  proc-vmstat.nr_active_anon
    128337            -0.7%     127432        proc-vmstat.nr_anon_pages
    306814            +5.2%     322674        proc-vmstat.nr_file_pages
      5499            +0.9%       5551        proc-vmstat.nr_inactive_anon
     11641 ±  3%     +34.9%      15706 ± 21%  proc-vmstat.nr_mapped
     39159 ±  2%     +40.7%      55087 ± 10%  proc-vmstat.nr_shmem
    161230            +9.3%     176238 ±  3%  proc-vmstat.nr_zone_active_anon
      5499            +0.9%       5551        proc-vmstat.nr_zone_inactive_anon
    896840            +2.7%     920864        proc-vmstat.numa_hit
    896840            +2.7%     920864        proc-vmstat.numa_local
      4194           +51.3%       6345 ± 11%  proc-vmstat.pgactivate
    848078            +1.4%     859960        proc-vmstat.pgfault
     13.31            -9.2%      12.08        perf-stat.i.MPKI
      1.59            +0.1        1.69        perf-stat.i.branch-miss-rate%
 1.378e+08            +6.1%  1.461e+08        perf-stat.i.branch-misses
     17.04            +2.2       19.20        perf-stat.i.cache-miss-rate%
  82207634            +2.1%   83926341        perf-stat.i.cache-misses
 4.823e+08            -9.4%  4.368e+08        perf-stat.i.cache-references
      7453            -2.0%       7306        perf-stat.i.context-switches
    251.52            +3.3%     259.82        perf-stat.i.cpu-migrations
      5345            -2.1%       5231        perf-stat.i.cycles-between-cache-misses
      0.33            -0.0        0.29 ±  2%  perf-stat.i.iTLB-load-miss-rate%
 1.209e+08           -13.7%  1.043e+08        perf-stat.i.iTLB-load-misses
    301.31           +16.0%     349.57 ±  2%  perf-stat.i.instructions-per-iTLB-miss
     13.18            -9.6%      11.92        perf-stat.overall.MPKI
      1.56            +0.1        1.64        perf-stat.overall.branch-miss-rate%
     17.08            +2.2       19.24        perf-stat.overall.cache-miss-rate%
      5368            -1.9%       5265        perf-stat.overall.cycles-between-cache-misses
      0.33            -0.0        0.28 ±  2%  perf-stat.overall.iTLB-load-miss-rate%
    302.34           +16.2%     351.22 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
  37348015           +41.9%   52987472 ±  2%  perf-stat.overall.path-length
 1.367e+08            +5.6%  1.444e+08        perf-stat.ps.branch-misses
  81868451            +1.9%   83441006        perf-stat.ps.cache-misses
 4.795e+08            -9.6%  4.336e+08        perf-stat.ps.cache-references
      7269            -3.0%       7051        perf-stat.ps.context-switches
 1.203e+08           -13.9%  1.037e+08        perf-stat.ps.iTLB-load-misses
      2653            +1.4%       2691        perf-stat.ps.minor-faults
      2653            +1.4%       2691        perf-stat.ps.page-faults
    396.75 ± 19%    +143.4%     965.50 ± 29%  interrupts.CPU1.RES:Rescheduling_interrupts
     16.50 ± 31%    +866.7%     159.50 ±146%  interrupts.CPU101.RES:Rescheduling_interrupts
      4705 ± 34%     +43.5%       6753 ± 22%  interrupts.CPU105.NMI:Non-maskable_interrupts
      4705 ± 34%     +43.5%       6753 ± 22%  interrupts.CPU105.PMI:Performance_monitoring_interrupts
      3798 ±  3%     +54.5%       5868 ± 31%  interrupts.CPU127.NMI:Non-maskable_interrupts
      3798 ±  3%     +54.5%       5868 ± 31%  interrupts.CPU127.PMI:Performance_monitoring_interrupts
      3779 ±  3%     +28.6%       4859 ± 29%  interrupts.CPU128.NMI:Non-maskable_interrupts
      3779 ±  3%     +28.6%       4859 ± 29%  interrupts.CPU128.PMI:Performance_monitoring_interrupts
     19.00 ± 47%    +261.8%      68.75 ± 46%  interrupts.CPU137.RES:Rescheduling_interrupts
      3784 ±  2%     +53.5%       5811 ± 28%  interrupts.CPU141.NMI:Non-maskable_interrupts
      3784 ±  2%     +53.5%       5811 ± 28%  interrupts.CPU141.PMI:Performance_monitoring_interrupts
     19.50 ± 23%    +262.8%      70.75 ± 42%  interrupts.CPU141.RES:Rescheduling_interrupts
      4843 ± 34%     +51.8%       7353 ± 27%  interrupts.CPU15.NMI:Non-maskable_interrupts
      4843 ± 34%     +51.8%       7353 ± 27%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
      3743 ±  3%     +80.6%       6762 ± 24%  interrupts.CPU155.NMI:Non-maskable_interrupts
      3743 ±  3%     +80.6%       6762 ± 24%  interrupts.CPU155.PMI:Performance_monitoring_interrupts
      4775 ± 34%     +42.7%       6814 ± 21%  interrupts.CPU157.NMI:Non-maskable_interrupts
      4775 ± 34%     +42.7%       6814 ± 21%  interrupts.CPU157.PMI:Performance_monitoring_interrupts
      4685 ± 30%     +46.9%       6883 ± 25%  interrupts.CPU160.NMI:Non-maskable_interrupts
      4685 ± 30%     +46.9%       6883 ± 25%  interrupts.CPU160.PMI:Performance_monitoring_interrupts
     18.00 ± 18%    +208.3%      55.50 ± 54%  interrupts.CPU161.RES:Rescheduling_interrupts
     22.25 ± 43%    +159.6%      57.75 ± 61%  interrupts.CPU162.RES:Rescheduling_interrupts
    124.50 ± 13%    +123.7%     278.50 ± 24%  interrupts.CPU17.RES:Rescheduling_interrupts
     23.00 ± 51%    +719.6%     188.50 ±130%  interrupts.CPU173.RES:Rescheduling_interrupts
     94.00 ± 16%     +92.6%     181.00 ± 29%  interrupts.CPU18.RES:Rescheduling_interrupts
      3809 ±  2%     +51.4%       5768 ± 29%  interrupts.CPU185.NMI:Non-maskable_interrupts
      3809 ±  2%     +51.4%       5768 ± 29%  interrupts.CPU185.PMI:Performance_monitoring_interrupts
      3752 ±  4%     +29.4%       4856 ± 29%  interrupts.CPU195.NMI:Non-maskable_interrupts
      3752 ±  4%     +29.4%       4856 ± 29%  interrupts.CPU195.PMI:Performance_monitoring_interrupts
      3746 ±  2%     +31.7%       4934 ± 32%  interrupts.CPU198.NMI:Non-maskable_interrupts
      3746 ±  2%     +31.7%       4934 ± 32%  interrupts.CPU198.PMI:Performance_monitoring_interrupts
      4845 ± 32%     +45.4%       7045 ± 21%  interrupts.CPU2.NMI:Non-maskable_interrupts
      4845 ± 32%     +45.4%       7045 ± 21%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
     34.00 ± 34%    +387.5%     165.75 ± 73%  interrupts.CPU20.RES:Rescheduling_interrupts
      3787 ±  3%     +53.4%       5811 ± 30%  interrupts.CPU223.NMI:Non-maskable_interrupts
      3787 ±  3%     +53.4%       5811 ± 30%  interrupts.CPU223.PMI:Performance_monitoring_interrupts
     27.25 ± 39%    +100.9%      54.75 ± 52%  interrupts.CPU23.RES:Rescheduling_interrupts
     26.00 ± 56%    +192.3%      76.00 ± 68%  interrupts.CPU232.RES:Rescheduling_interrupts
      4679 ± 30%     +45.0%       6784 ± 21%  interrupts.CPU248.NMI:Non-maskable_interrupts
      4679 ± 30%     +45.0%       6784 ± 21%  interrupts.CPU248.PMI:Performance_monitoring_interrupts
      4693 ± 35%     +44.2%       6766 ± 24%  interrupts.CPU249.NMI:Non-maskable_interrupts
      4693 ± 35%     +44.2%       6766 ± 24%  interrupts.CPU249.PMI:Performance_monitoring_interrupts
     14.50 ± 24%    +208.6%      44.75 ± 81%  interrupts.CPU249.RES:Rescheduling_interrupts
      3805 ±  2%     +81.9%       6922 ± 25%  interrupts.CPU269.NMI:Non-maskable_interrupts
      3805 ±  2%     +81.9%       6922 ± 25%  interrupts.CPU269.PMI:Performance_monitoring_interrupts
      4672 ± 30%     +70.8%       7981 ±  5%  interrupts.CPU278.NMI:Non-maskable_interrupts
      4672 ± 30%     +70.8%       7981 ±  5%  interrupts.CPU278.PMI:Performance_monitoring_interrupts
     29.50 ± 69%    +101.7%      59.50 ± 47%  interrupts.CPU281.RES:Rescheduling_interrupts
     19.25 ±  9%   +1127.3%     236.25 ±128%  interrupts.CPU29.RES:Rescheduling_interrupts
     46.25 ± 54%    +166.5%     123.25 ± 60%  interrupts.CPU32.RES:Rescheduling_interrupts
     22.00 ± 20%    +264.8%      80.25 ± 67%  interrupts.CPU33.RES:Rescheduling_interrupts
      4760 ± 32%     +52.8%       7275 ± 26%  interrupts.CPU34.NMI:Non-maskable_interrupts
      4760 ± 32%     +52.8%       7275 ± 26%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
      4774 ± 32%     +29.0%       6156 ± 34%  interrupts.CPU37.NMI:Non-maskable_interrupts
      4774 ± 32%     +29.0%       6156 ± 34%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
     24.25 ± 27%    +226.8%      79.25 ± 75%  interrupts.CPU37.RES:Rescheduling_interrupts
      3876           +57.3%       6098 ± 32%  interrupts.CPU4.NMI:Non-maskable_interrupts
      3876           +57.3%       6098 ± 32%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
      3824           +85.1%       7076 ± 26%  interrupts.CPU42.NMI:Non-maskable_interrupts
      3824           +85.1%       7076 ± 26%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
     30.50 ± 31%    +221.3%      98.00 ± 62%  interrupts.CPU56.RES:Rescheduling_interrupts
      3851 ±  2%    +107.8%       8005 ±  4%  interrupts.CPU60.NMI:Non-maskable_interrupts
      3851 ±  2%    +107.8%       8005 ±  4%  interrupts.CPU60.PMI:Performance_monitoring_interrupts
     25.00 ± 62%    +164.0%      66.00 ± 78%  interrupts.CPU65.RES:Rescheduling_interrupts
      3804           +55.9%       5931 ± 29%  interrupts.CPU68.NMI:Non-maskable_interrupts
      3804           +55.9%       5931 ± 29%  interrupts.CPU68.PMI:Performance_monitoring_interrupts
     66.00 ± 81%     -61.7%      25.25 ± 65%  interrupts.CPU73.RES:Rescheduling_interrupts
     32.25 ± 65%    +914.7%     327.25 ± 86%  interrupts.CPU77.RES:Rescheduling_interrupts
     28.50 ± 58%    +399.1%     142.25 ± 75%  interrupts.CPU78.RES:Rescheduling_interrupts
    341.50 ±108%     -90.8%      31.25 ± 83%  interrupts.CPU86.RES:Rescheduling_interrupts
      3765 ±  3%     +57.2%       5920 ± 32%  interrupts.CPU87.NMI:Non-maskable_interrupts
      3765 ±  3%     +57.2%       5920 ± 32%  interrupts.CPU87.PMI:Performance_monitoring_interrupts
     97.25 ± 41%     -74.8%      24.50 ± 32%  interrupts.CPU87.RES:Rescheduling_interrupts
     17.00 ± 31%    +964.7%     181.00 ±106%  interrupts.CPU89.RES:Rescheduling_interrupts
      4718 ± 30%     +25.4%       5915 ± 28%  interrupts.CPU91.NMI:Non-maskable_interrupts
      4718 ± 30%     +25.4%       5915 ± 28%  interrupts.CPU91.PMI:Performance_monitoring_interrupts
     15.50 ± 17%    +243.5%      53.25 ±100%  interrupts.CPU95.RES:Rescheduling_interrupts
    358.25 ± 16%     +22.3%     438.00 ±  9%  interrupts.IWI:IRQ_work_interrupts
     39.74 ±  4%     -39.1        0.66 ±  9%  perf-profile.calltrace.cycles-pp.__GI___libc_close
     38.93 ±  4%     -38.9        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_close
     39.51 ±  4%     -38.9        0.60 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__GI___libc_close
     39.50 ±  4%     -38.9        0.59 ± 11%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_close
     38.88 ±  4%     -38.9        0.00        perf-profile.calltrace.cycles-pp.__alloc_fd.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
     38.78 ±  4%     -38.8        0.00        perf-profile.calltrace.cycles-pp.__close_fd.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_close
     38.73 ±  4%     -38.7        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.__alloc_fd.do_sys_openat2.do_sys_open.do_syscall_64
     38.69 ±  4%     -38.7        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__alloc_fd.do_sys_openat2.do_sys_open
     38.67 ±  4%     -38.7        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.__close_fd.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
     38.62 ±  4%     -38.6        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__close_fd.__x64_sys_close.do_syscall_64
      7.62 ± 20%      -7.6        0.00        perf-profile.calltrace.cycles-pp.new_inode.shmem_get_inode.shmem_mknod.path_openat.do_filp_open
      7.65 ± 20%      -7.5        0.12 ±173%  perf-profile.calltrace.cycles-pp.evict.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      7.86 ± 20%      -7.4        0.43 ± 58%  perf-profile.calltrace.cycles-pp.shmem_get_inode.shmem_mknod.path_openat.do_filp_open.do_sys_openat2
      8.05 ± 19%      -7.3        0.70 ±  7%  perf-profile.calltrace.cycles-pp.shmem_mknod.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      7.31 ± 21%      -7.3        0.00        perf-profile.calltrace.cycles-pp.inode_sb_list_add.new_inode.shmem_get_inode.shmem_mknod.path_openat
      7.24 ± 21%      -7.2        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.evict.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.24 ± 21%      -7.2        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.inode_sb_list_add.new_inode.shmem_get_inode.shmem_mknod
      7.22 ± 21%      -7.2        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.inode_sb_list_add.new_inode.shmem_get_inode
      7.21 ± 21%      -7.2        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.evict.do_unlinkat.do_syscall_64
     49.62            +0.2       49.79        perf-profile.calltrace.cycles-pp.__GI___libc_open
     49.33            +0.2       49.54        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__GI___libc_open
     49.32            +0.2       49.53        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_open
      0.00            +1.8        1.82 ± 13%  perf-profile.calltrace.cycles-pp._raw_spin_lock.set_root.nd_jump_root.path_init.path_openat
      0.00            +1.8        1.83 ± 13%  perf-profile.calltrace.cycles-pp._raw_spin_lock.set_root.nd_jump_root.path_init.path_parentat
      0.00            +1.9        1.88 ± 13%  perf-profile.calltrace.cycles-pp.set_root.nd_jump_root.path_init.path_openat.do_filp_open
      0.00            +1.9        1.88 ± 13%  perf-profile.calltrace.cycles-pp.set_root.nd_jump_root.path_init.path_parentat.filename_parentat
      0.00            +1.9        1.90 ± 13%  perf-profile.calltrace.cycles-pp.nd_jump_root.path_init.path_openat.do_filp_open.do_sys_openat2
      0.00            +1.9        1.91 ± 13%  perf-profile.calltrace.cycles-pp.nd_jump_root.path_init.path_parentat.filename_parentat.do_unlinkat
      0.00            +1.9        1.93 ± 12%  perf-profile.calltrace.cycles-pp.path_init.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00            +1.9        1.93 ± 13%  perf-profile.calltrace.cycles-pp.path_init.path_parentat.filename_parentat.do_unlinkat.do_syscall_64
      0.00            +3.4        3.43 ± 29%  perf-profile.calltrace.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_put_or_lock
      0.00            +3.6        3.62 ± 14%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.set_root.nd_jump_root.path_init
      0.00            +3.7        3.69 ± 31%  perf-profile.calltrace.cycles-pp.apic_timer_interrupt.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_put_or_lock.dput
      0.00            +3.7        3.72 ± 31%  perf-profile.calltrace.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.native_queued_spin_lock_slowpath._raw_spin_lock.__d_lookup
      0.00            +4.0        3.95 ± 32%  perf-profile.calltrace.cycles-pp.apic_timer_interrupt.native_queued_spin_lock_slowpath._raw_spin_lock.__d_lookup.lookup_fast
      0.00           +21.9       21.94        perf-profile.calltrace.cycles-pp.__traverse_mounts.step_into.walk_component.link_path_walk.path_openat
      0.00           +21.9       21.94        perf-profile.calltrace.cycles-pp.__traverse_mounts.step_into.walk_component.link_path_walk.path_parentat
      0.00           +22.1       22.11        perf-profile.calltrace.cycles-pp.step_into.walk_component.link_path_walk.path_openat.do_filp_open
      0.00           +22.1       22.13        perf-profile.calltrace.cycles-pp.step_into.walk_component.link_path_walk.path_parentat.filename_parentat
      0.00           +22.4       22.39        perf-profile.calltrace.cycles-pp.__d_lookup.lookup_fast.walk_component.link_path_walk.path_openat
      0.00           +22.4       22.45        perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_openat.do_filp_open
      0.00           +22.5       22.46        perf-profile.calltrace.cycles-pp.__d_lookup.lookup_fast.walk_component.link_path_walk.path_parentat
      0.00           +22.5       22.51        perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_parentat.filename_parentat
     10.05 ± 15%     +38.6       48.67        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.99 ± 15%     +38.7       48.66        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      9.42 ± 16%     +38.8       48.24        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlink
      9.40 ± 16%     +38.8       48.24        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      9.57 ± 16%     +38.9       48.44        perf-profile.calltrace.cycles-pp.unlink
      9.16 ± 17%     +38.9       48.07        perf-profile.calltrace.cycles-pp.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.00           +43.4       43.39        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_put_or_lock.dput.__traverse_mounts
      0.00           +43.5       43.49        perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_put_or_lock.dput.__traverse_mounts.step_into
      0.00           +43.6       43.63        perf-profile.calltrace.cycles-pp.lockref_put_or_lock.dput.__traverse_mounts.step_into.walk_component
      0.00           +43.7       43.70        perf-profile.calltrace.cycles-pp.dput.__traverse_mounts.step_into.walk_component.link_path_walk
      0.00           +44.6       44.56        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__d_lookup.lookup_fast.walk_component
      0.00           +44.6       44.58        perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.00           +44.7       44.66        perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_parentat.filename_parentat.do_unlinkat
      0.00           +44.7       44.66        perf-profile.calltrace.cycles-pp._raw_spin_lock.__d_lookup.lookup_fast.walk_component.link_path_walk
      0.00           +44.8       44.75        perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00           +44.8       44.84        perf-profile.calltrace.cycles-pp.link_path_walk.path_parentat.filename_parentat.do_unlinkat.do_syscall_64
      0.00           +46.9       46.87        perf-profile.calltrace.cycles-pp.path_parentat.filename_parentat.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +46.9       46.91        perf-profile.calltrace.cycles-pp.filename_parentat.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
     39.75 ±  4%     -39.1        0.67 ±  9%  perf-profile.children.cycles-pp.__GI___libc_close
     38.93 ±  4%     -38.5        0.39 ± 16%  perf-profile.children.cycles-pp.__x64_sys_close
     38.90 ±  4%     -38.5        0.37 ± 16%  perf-profile.children.cycles-pp.__alloc_fd
     38.78 ±  4%     -38.4        0.34 ± 18%  perf-profile.children.cycles-pp.__close_fd
      8.05 ± 19%      -7.3        0.70 ±  7%  perf-profile.children.cycles-pp.shmem_mknod
      7.86 ± 20%      -7.3        0.56 ±  8%  perf-profile.children.cycles-pp.shmem_get_inode
      7.66 ± 20%      -7.2        0.44 ± 11%  perf-profile.children.cycles-pp.evict
      7.62 ± 20%      -7.2        0.43 ±  9%  perf-profile.children.cycles-pp.new_inode
      7.31 ± 21%      -7.1        0.24 ± 19%  perf-profile.children.cycles-pp.inode_sb_list_add
      0.28            -0.1        0.15 ±  5%  perf-profile.children.cycles-pp.shmem_evict_inode
      0.43            -0.1        0.32 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.51            -0.1        0.40        perf-profile.children.cycles-pp.exit_to_usermode_loop
      0.34            -0.1        0.23        perf-profile.children.cycles-pp.getname_flags
      0.30 ±  2%      -0.1        0.19 ±  4%  perf-profile.children.cycles-pp.new_inode_pseudo
      0.34            -0.1        0.23        perf-profile.children.cycles-pp.__fput
      0.45            -0.1        0.35 ±  2%  perf-profile.children.cycles-pp.task_work_run
      0.28            -0.1        0.18 ±  3%  perf-profile.children.cycles-pp.alloc_inode
      0.31            -0.1        0.22 ±  5%  perf-profile.children.cycles-pp.vfs_unlink
      0.28            -0.1        0.20 ±  3%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.20 ±  2%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.__x64_sys_unlink
      0.18 ±  2%      -0.1        0.11 ±  6%  perf-profile.children.cycles-pp.inode_init_always
      0.23 ±  2%      -0.1        0.15 ±  3%  perf-profile.children.cycles-pp.strncpy_from_user
      0.14 ±  3%      -0.1        0.07 ±  6%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.23 ±  3%      -0.1        0.17 ±  3%  perf-profile.children.cycles-pp.d_alloc
      0.17 ±  4%      -0.1        0.11 ±  3%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.14 ±  3%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.shmem_truncate_range
      0.14 ±  5%      -0.1        0.09 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.20 ±  2%      -0.1        0.14 ±  3%  perf-profile.children.cycles-pp.__d_alloc
      0.19            -0.1        0.14 ±  3%  perf-profile.children.cycles-pp.do_dentry_open
      0.10 ±  4%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.destroy_inode
      0.14            -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.__check_object_size
      0.07            -0.0        0.03 ±100%  perf-profile.children.cycles-pp.current_time
      0.12            -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.mnt_want_write
      0.11 ±  4%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.shmem_undo_range
      0.39 ±  2%      -0.0        0.35        perf-profile.children.cycles-pp.alloc_empty_file
      0.08 ±  8%      -0.0        0.04 ± 58%  perf-profile.children.cycles-pp.fpregs_assert_state_consistent
      0.11            -0.0        0.07        perf-profile.children.cycles-pp.fsnotify
      0.35            -0.0        0.31 ±  2%  perf-profile.children.cycles-pp.__alloc_file
      0.07 ±  5%      -0.0        0.04 ± 57%  perf-profile.children.cycles-pp.dentry_unlink_inode
      0.06            -0.0        0.03 ±100%  perf-profile.children.cycles-pp.__lookup_hash
      0.11 ±  4%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.simple_lookup
      0.09 ±  5%      -0.0        0.05 ±  9%  perf-profile.children.cycles-pp.__sb_start_write
      0.09 ±  4%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.d_add
      0.09            -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.shmem_alloc_inode
      0.08 ±  5%      -0.0        0.05 ±  9%  perf-profile.children.cycles-pp.d_lookup
      0.08 ±  5%      -0.0        0.05 ±  9%  perf-profile.children.cycles-pp.shmem_unlink
      0.08            -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.security_file_open
      0.07 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.down_write
      0.14 ±  3%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__dentry_kill
      0.16 ±  2%      -0.0        0.14 ±  6%  perf-profile.children.cycles-pp.___might_sleep
      0.07 ±  6%      -0.0        0.05        perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.12            -0.0        0.11 ±  4%  perf-profile.children.cycles-pp._cond_resched
      0.11 ±  4%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.generic_permission
      0.10            +0.0        0.13 ±  6%  perf-profile.children.cycles-pp.__might_sleep
      0.12 ± 13%      +0.0        0.16 ± 15%  perf-profile.children.cycles-pp.clockevents_program_event
      0.09 ±  9%      +0.0        0.13 ± 18%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.lookup_mnt
      0.06            +0.1        0.16 ±  2%  perf-profile.children.cycles-pp.terminate_walk
      0.00            +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.lockref_get
      0.29 ±  2%      +0.1        0.42 ± 10%  perf-profile.children.cycles-pp.file_free_rcu
      0.06 ± 59%      +0.1        0.19 ± 33%  perf-profile.children.cycles-pp.x86_pmu_disable
      0.00            +0.2        0.15 ±  7%  perf-profile.children.cycles-pp.lockref_put_return
      0.63 ±  3%      +0.2        0.79 ± 11%  perf-profile.children.cycles-pp.rcu_do_batch
      0.25 ± 14%      +0.2        0.41 ± 18%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
     49.62            +0.2       49.80        perf-profile.children.cycles-pp.__GI___libc_open
     92.01            +0.9       92.91        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     92.23            +0.9       93.14        perf-profile.children.cycles-pp._raw_spin_lock
      0.11 ±  4%      +3.7        3.85 ± 13%  perf-profile.children.cycles-pp.path_init
      0.06 ±  7%      +3.8        3.81 ± 13%  perf-profile.children.cycles-pp.nd_jump_root
      0.00            +3.8        3.76 ± 13%  perf-profile.children.cycles-pp.set_root
     10.05 ± 15%     +38.6       48.69        perf-profile.children.cycles-pp.do_filp_open
     10.00 ± 15%     +38.7       48.66        perf-profile.children.cycles-pp.path_openat
      9.59 ± 16%     +38.9       48.47        perf-profile.children.cycles-pp.unlink
      9.17 ± 17%     +38.9       48.07        perf-profile.children.cycles-pp.do_unlinkat
      0.05 ±  9%     +43.6       43.67        perf-profile.children.cycles-pp.lockref_put_or_lock
      0.00           +43.9       43.88        perf-profile.children.cycles-pp.__traverse_mounts
      0.35           +43.9       44.25        perf-profile.children.cycles-pp.dput
      0.11           +44.1       44.24        perf-profile.children.cycles-pp.step_into
      0.16           +44.8       44.97        perf-profile.children.cycles-pp.lookup_fast
      0.06           +44.8       44.91        perf-profile.children.cycles-pp.__d_lookup
      0.42           +46.4       46.87        perf-profile.children.cycles-pp.path_parentat
      0.46           +46.4       46.91        perf-profile.children.cycles-pp.filename_parentat
      0.30           +89.0       89.25        perf-profile.children.cycles-pp.walk_component
      0.59           +89.0       89.61        perf-profile.children.cycles-pp.link_path_walk
      0.13 ±  3%      -0.1        0.06        perf-profile.self.cycles-pp.__d_lookup_rcu
      0.26 ±  3%      -0.1        0.19 ±  5%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.17 ±  4%      -0.1        0.11 ±  3%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.13 ±  3%      -0.1        0.08 ±  6%  perf-profile.self.cycles-pp.inode_init_always
      0.12 ±  3%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.08 ±  8%      -0.0        0.04 ± 58%  perf-profile.self.cycles-pp.fpregs_assert_state_consistent
      0.06 ±  6%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.10            -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.fsnotify
      0.10 ±  5%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.do_syscall_64
      0.08            -0.0        0.05        perf-profile.self.cycles-pp.__d_alloc
      0.16 ±  5%      -0.0        0.13        perf-profile.self.cycles-pp.kmem_cache_free
      0.15 ±  3%      -0.0        0.12 ±  8%  perf-profile.self.cycles-pp.___might_sleep
      0.08            -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.strncpy_from_user
      0.12 ±  3%      -0.0        0.10 ±  7%  perf-profile.self.cycles-pp.inode_permission
      0.10 ±  4%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.call_rcu
      0.05            +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.dput
      0.10 ±  4%      +0.0        0.12 ±  6%  perf-profile.self.cycles-pp.link_path_walk
      0.09 ±  4%      +0.0        0.11 ±  7%  perf-profile.self.cycles-pp.__might_sleep
      0.06            +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.step_into
      0.07 ±  7%      +0.0        0.10 ± 17%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.01 ±173%      +0.1        0.10 ±  7%  perf-profile.self.cycles-pp.lockref_put_or_lock
      0.00            +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.lockref_get
      0.05 ±  8%      +0.1        0.16 ±  7%  perf-profile.self.cycles-pp.__d_lookup
      0.27 ±  3%      +0.1        0.39 ±  9%  perf-profile.self.cycles-pp.file_free_rcu
      0.06 ± 59%      +0.1        0.19 ± 31%  perf-profile.self.cycles-pp.x86_pmu_disable
      0.00            +0.1        0.14 ±  7%  perf-profile.self.cycles-pp.lockref_put_return



***************************************************************************************************
lkp-ivb-d01: 8 threads Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz with 16G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
  gcc-7/performance/x86_64-rhel-7.6/process/100%/debian-x86_64-20191114.cgz/lkp-ivb-d01/unlink2/will-it-scale/0x21

commit: 
  7ef482fa65 ("helper for mount rootwards traversal")
  2aa3847085 ("non-RCU analogue of the previous commit")

7ef482fa65513b18 2aa38470853a65dc9b1b4bd0989 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          1:4          -25%            :4     dmesg.RIP:loop
          1:4          -25%            :4     dmesg.RIP:poll_idle
          1:4          -25%            :4     kmsg.a1dd49>]usb_hcd_irq
           :4           25%           1:4     kmsg.aa24>]usb_hcd_irq
           :4           25%           1:4     kmsg.b428c>]usb_hcd_irq
           :4           25%           1:4     kmsg.cd5a>]usb_hcd_irq
          1:4          -25%            :4     kmsg.d0ef16>]usb_hcd_irq
          1:4          -25%            :4     kmsg.fd#d1>]usb_hcd_irq
           :4           25%           1:4     kmsg.usb_hcd_irq
         %stddev     %change         %stddev
             \          |                \  
    138295           -22.4%     107268        will-it-scale.per_process_ops
   1106364           -22.4%     858148        will-it-scale.workload
     74850           +11.7%      83605        meminfo.SUnreclaim
     24141 ±  6%      -6.8%      22506        softirqs.SCHED
      2.48            +0.4        2.83        mpstat.cpu.all.soft%
     14.44            -3.5       10.89        mpstat.cpu.all.usr%
      1.09 ± 25%     -23.8%       0.83 ±  5%  sched_debug.cpu.clock.stddev
      1.09 ± 25%     -23.5%       0.83 ±  5%  sched_debug.cpu.clock_task.stddev
     83.75            +5.1%      88.00        vmstat.cpu.sy
     14.00           -28.6%      10.00        vmstat.cpu.us
    199.50 ± 13%     +92.4%     383.75 ± 28%  interrupts.55:PCI-MSI.528391-edge.eth3-TxRx-6
    690137 ±  7%      +8.3%     747234 ±  5%  interrupts.CPU4.LOC:Local_timer_interrupts
      8487 ±  9%     -13.2%       7365 ±  2%  interrupts.CPU4.NMI:Non-maskable_interrupts
      8487 ±  9%     -13.2%       7365 ±  2%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
    199.50 ± 13%     +92.4%     383.75 ± 28%  interrupts.CPU5.55:PCI-MSI.528391-edge.eth3-TxRx-6
     18856           +11.5%      21019        proc-vmstat.nr_slab_unreclaimable
  31150052            +1.7%   31677101        proc-vmstat.numa_hit
  31150052            +1.7%   31677101        proc-vmstat.numa_local
  72273940            -1.1%   71451482        proc-vmstat.pgalloc_normal
  72251795            -1.1%   71421633        proc-vmstat.pgfree
      5199 ± 12%     +29.9%       6753 ± 10%  slabinfo.anon_vma_chain.active_objs
      5508 ±  9%     +26.6%       6974 ±  5%  slabinfo.anon_vma_chain.num_objs
     47778           +87.5%      89584        slabinfo.filp.active_objs
      1497           +87.2%       2802        slabinfo.filp.active_slabs
     47911           +87.2%      89697        slabinfo.filp.num_objs
      1497           +87.2%       2802        slabinfo.filp.num_slabs
    333.00 ±  8%     -27.0%     243.00 ±  6%  slabinfo.kmem_cache.active_objs
    333.00 ±  8%     -27.0%     243.00 ±  6%  slabinfo.kmem_cache.num_objs
    512.00 ±  8%     -28.1%     368.00 ±  7%  slabinfo.kmem_cache_node.active_objs
    512.00 ±  8%     -28.1%     368.00 ±  7%  slabinfo.kmem_cache_node.num_objs
      2365 ±  5%     +20.3%       2846 ± 12%  slabinfo.lsm_file_cache.active_objs
      2365 ±  5%     +20.3%       2846 ± 12%  slabinfo.lsm_file_cache.num_objs
  3.21e+09            +7.1%  3.439e+09        perf-stat.i.branch-instructions
      1.04 ±  2%      -0.1        0.97        perf-stat.i.branch-miss-rate%
   9396063           +11.5%   10480941        perf-stat.i.cache-misses
  64119641 ±  2%     +15.0%   73766130 ±  2%  perf-stat.i.cache-references
      1.82            -6.6%       1.70        perf-stat.i.cpi
     48.73           -16.5%      40.69        perf-stat.i.cpu-migrations
      3114           -10.2%       2797        perf-stat.i.cycles-between-cache-misses
 4.695e+09            +6.2%  4.985e+09        perf-stat.i.dTLB-loads
      0.34 ±  7%      -0.1        0.27 ±  2%  perf-stat.i.dTLB-store-miss-rate%
  11607694 ±  7%     -17.2%    9606757 ±  2%  perf-stat.i.dTLB-store-misses
 3.402e+09            +3.7%  3.527e+09        perf-stat.i.dTLB-stores
     92.78           -13.3       79.50        perf-stat.i.iTLB-load-miss-rate%
   1610008           -16.8%    1339659        perf-stat.i.iTLB-load-misses
    126447 ± 15%    +174.5%     347105 ±  6%  perf-stat.i.iTLB-loads
 1.612e+10            +6.9%  1.724e+10        perf-stat.i.instructions
     10048           +28.4%      12899        perf-stat.i.instructions-per-iTLB-miss
      0.55            +6.8%       0.59        perf-stat.i.ipc
      3.98 ±  2%      +7.6%       4.28 ±  2%  perf-stat.overall.MPKI
      1.03            -0.1        0.97        perf-stat.overall.branch-miss-rate%
      1.81            -6.4%       1.70        perf-stat.overall.cpi
      3113           -10.3%       2794        perf-stat.overall.cycles-between-cache-misses
      0.34 ±  7%      -0.1        0.27 ±  2%  perf-stat.overall.dTLB-store-miss-rate%
     92.74           -13.3       79.44        perf-stat.overall.iTLB-load-miss-rate%
     10017           +28.5%      12871        perf-stat.overall.instructions-per-iTLB-miss
      0.55            +6.8%       0.59        perf-stat.overall.ipc
   4397504           +37.4%    6042155        perf-stat.overall.path-length
 3.199e+09            +7.1%  3.427e+09        perf-stat.ps.branch-instructions
   9364688           +11.5%   10445777        perf-stat.ps.cache-misses
  63904815 ±  2%     +15.0%   73518356 ±  2%  perf-stat.ps.cache-references
     48.57           -16.5%      40.55        perf-stat.ps.cpu-migrations
 4.679e+09            +6.2%  4.968e+09        perf-stat.ps.dTLB-loads
  11568767 ±  7%     -17.2%    9574444 ±  2%  perf-stat.ps.dTLB-store-misses
 3.391e+09            +3.7%  3.516e+09        perf-stat.ps.dTLB-stores
   1604624           -16.8%    1335170        perf-stat.ps.iTLB-load-misses
    126032 ± 15%    +174.5%     345941 ±  6%  perf-stat.ps.iTLB-loads
 1.607e+10            +6.9%  1.718e+10        perf-stat.ps.instructions
 4.865e+12            +6.6%  5.185e+12        perf-stat.total.instructions
     14.08            -3.7       10.37        perf-profile.calltrace.cycles-pp.close
     10.64            -3.0        7.63        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.close
     10.44            -2.9        7.51        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.close
     10.32            -1.9        8.38        perf-profile.calltrace.cycles-pp.shmem_mknod.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      6.82 ±  2%      -1.6        5.21        perf-profile.calltrace.cycles-pp.evict.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      5.94            -1.6        4.36        perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.close
      7.50            -1.5        5.98        perf-profile.calltrace.cycles-pp.shmem_get_inode.shmem_mknod.path_openat.do_filp_open.do_sys_openat2
      5.26 ±  2%      -1.2        4.04        perf-profile.calltrace.cycles-pp.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.close
      4.92            -1.0        3.88 ±  2%  perf-profile.calltrace.cycles-pp.vfs_unlink.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      5.03            -1.0        4.07 ±  2%  perf-profile.calltrace.cycles-pp.new_inode.shmem_get_inode.shmem_mknod.path_openat.do_filp_open
      4.22 ±  2%      -0.9        3.31 ±  2%  perf-profile.calltrace.cycles-pp.shmem_evict_inode.evict.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.54 ±  3%      -0.8        2.75        perf-profile.calltrace.cycles-pp.dput.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      3.08            -0.7        2.34 ±  2%  perf-profile.calltrace.cycles-pp.do_dentry_open.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      2.50            -0.6        1.90 ±  2%  perf-profile.calltrace.cycles-pp.getname_flags.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.56            -0.6        3.00        perf-profile.calltrace.cycles-pp.new_inode_pseudo.new_inode.shmem_get_inode.shmem_mknod.path_openat
      2.58 ±  2%      -0.6        2.02        perf-profile.calltrace.cycles-pp.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      2.51            -0.5        1.98        perf-profile.calltrace.cycles-pp.shmem_truncate_range.shmem_evict_inode.evict.do_unlinkat.do_syscall_64
      2.74 ±  2%      -0.5        2.23        perf-profile.calltrace.cycles-pp.d_alloc_parallel.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      3.28            -0.5        2.78        perf-profile.calltrace.cycles-pp.alloc_inode.new_inode_pseudo.new_inode.shmem_get_inode.shmem_mknod
      2.41 ±  3%      -0.5        1.92        perf-profile.calltrace.cycles-pp.getname_flags.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.74 ±  2%      -0.5        0.26 ±100%  perf-profile.calltrace.cycles-pp.d_lookup.lookup_dcache.__lookup_hash.do_unlinkat.do_syscall_64
      2.11            -0.5        1.64        perf-profile.calltrace.cycles-pp.shmem_undo_range.shmem_truncate_range.shmem_evict_inode.evict.do_unlinkat
      1.96 ±  4%      -0.4        1.55 ±  2%  perf-profile.calltrace.cycles-pp.simple_lookup.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      2.06            -0.4        1.65 ±  4%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.shmem_alloc_inode.alloc_inode.new_inode_pseudo.new_inode
      2.05 ±  4%      -0.4        1.65        perf-profile.calltrace.cycles-pp.d_alloc.d_alloc_parallel.path_openat.do_filp_open.do_sys_openat2
      1.44 ±  3%      -0.4        1.04 ±  6%  perf-profile.calltrace.cycles-pp.inode_sb_list_add.new_inode.shmem_get_inode.shmem_mknod.path_openat
      0.81 ±  9%      -0.4        0.41 ± 58%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.evict.do_unlinkat.do_syscall_64
      1.52 ±  3%      -0.4        1.13        perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.do_sys_openat2.do_sys_open.do_syscall_64
      1.63 ±  4%      -0.4        1.24        perf-profile.calltrace.cycles-pp.__d_alloc.d_alloc.d_alloc_parallel.path_openat.do_filp_open
      1.56 ±  3%      -0.4        1.18 ±  4%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.unlink
      1.34 ±  6%      -0.4        0.96 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock.evict.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.15            -0.4        1.77 ±  4%  perf-profile.calltrace.cycles-pp.shmem_alloc_inode.alloc_inode.new_inode_pseudo.new_inode.shmem_get_inode
      0.79            -0.4        0.42 ± 58%  perf-profile.calltrace.cycles-pp.lookup_dcache.__lookup_hash.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.48 ±  3%      -0.4        1.11        perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.64            -0.4        1.28        perf-profile.calltrace.cycles-pp.__dentry_kill.dput.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.44 ±  2%      -0.4        1.08 ±  3%  perf-profile.calltrace.cycles-pp.destroy_inode.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      1.44 ±  5%      -0.4        1.08 ±  3%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.open64
      0.60 ±  4%      -0.3        0.26 ±100%  perf-profile.calltrace.cycles-pp.kmem_cache_free.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      1.28 ±  2%      -0.3        0.94 ±  4%  perf-profile.calltrace.cycles-pp.__destroy_inode.destroy_inode.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.50 ±  3%      -0.3        1.15 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.open64
      1.54 ±  4%      -0.3        1.21 ±  3%  perf-profile.calltrace.cycles-pp.d_add.simple_lookup.path_openat.do_filp_open.do_sys_openat2
      1.49 ±  3%      -0.3        1.18 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.unlink
      1.45 ±  3%      -0.3        1.14 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.close
      1.42 ±  3%      -0.3        1.11        perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.close
      1.08 ±  4%      -0.3        0.78 ±  2%  perf-profile.calltrace.cycles-pp.__check_object_size.strncpy_from_user.getname_flags.__x64_sys_unlink.do_syscall_64
      1.10 ±  2%      -0.3        0.82 ±  2%  perf-profile.calltrace.cycles-pp.__check_object_size.strncpy_from_user.getname_flags.do_sys_openat2.do_sys_open
      1.11 ±  2%      -0.3        0.83 ±  3%  perf-profile.calltrace.cycles-pp.dentry_unlink_inode.vfs_unlink.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.03 ±  4%      -0.3        0.75 ±  9%  perf-profile.calltrace.cycles-pp._raw_spin_lock.inode_sb_list_add.new_inode.shmem_get_inode.shmem_mknod
      0.86 ±  3%      -0.3        0.59 ±  5%  perf-profile.calltrace.cycles-pp.apparmor_file_free_security.security_file_free.__fput.task_work_run.exit_to_usermode_loop
      0.66 ±  4%      -0.3        0.40 ± 57%  perf-profile.calltrace.cycles-pp.apparmor_task_getsecid.security_task_getsecid.ima_file_check.path_openat.do_filp_open
      0.64 ±  2%      -0.3        0.39 ± 57%  perf-profile.calltrace.cycles-pp.call_rcu.__dentry_kill.dput.do_unlinkat.do_syscall_64
      1.37            -0.2        1.12 ±  2%  perf-profile.calltrace.cycles-pp.shmem_unlink.vfs_unlink.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.83            -0.2        0.59 ±  8%  perf-profile.calltrace.cycles-pp.__lookup_hash.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      1.36            -0.2        1.12 ±  4%  perf-profile.calltrace.cycles-pp.__slab_alloc.kmem_cache_alloc.shmem_alloc_inode.alloc_inode.new_inode_pseudo
      1.22 ±  3%      -0.2        0.97        perf-profile.calltrace.cycles-pp.security_file_open.do_dentry_open.path_openat.do_filp_open.do_sys_openat2
      1.35            -0.2        1.10 ±  4%  perf-profile.calltrace.cycles-pp.___slab_alloc.__slab_alloc.kmem_cache_alloc.shmem_alloc_inode.alloc_inode
      1.03 ±  5%      -0.2        0.79 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.__d_alloc.d_alloc.d_alloc_parallel.path_openat
      0.95 ±  4%      -0.2        0.71 ±  5%  perf-profile.calltrace.cycles-pp.__d_lookup_rcu.lookup_fast.walk_component.link_path_walk.path_openat
      0.97 ±  6%      -0.2        0.75 ±  4%  perf-profile.calltrace.cycles-pp.ima_file_check.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      1.02 ±  4%      -0.2        0.80 ±  3%  perf-profile.calltrace.cycles-pp.apparmor_file_open.security_file_open.do_dentry_open.path_openat.do_filp_open
      1.24            -0.2        1.03 ±  4%  perf-profile.calltrace.cycles-pp.new_slab.___slab_alloc.__slab_alloc.kmem_cache_alloc.shmem_alloc_inode
      1.39 ±  2%      -0.2        1.18        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.close
      0.96 ±  8%      -0.2        0.75 ±  8%  perf-profile.calltrace.cycles-pp.shmem_free_inode.shmem_evict_inode.evict.do_unlinkat.do_syscall_64
      0.77 ±  3%      -0.2        0.58 ±  5%  perf-profile.calltrace.cycles-pp.mnt_want_write.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.94 ±  4%      -0.2        0.75 ±  3%  perf-profile.calltrace.cycles-pp.shmem_reserve_inode.shmem_get_inode.shmem_mknod.path_openat.do_filp_open
      1.06 ±  3%      -0.2        0.88 ±  3%  perf-profile.calltrace.cycles-pp.__alloc_fd.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.02 ±  4%      -0.2        0.84        perf-profile.calltrace.cycles-pp.simple_acl_create.shmem_mknod.path_openat.do_filp_open.do_sys_openat2
      0.83 ±  4%      -0.2        0.65 ±  3%  perf-profile.calltrace.cycles-pp.filp_close.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.close
      1.04            -0.2        0.86        perf-profile.calltrace.cycles-pp.find_get_entries.shmem_undo_range.shmem_truncate_range.shmem_evict_inode.evict
      0.78 ±  6%      -0.2        0.60 ±  5%  perf-profile.calltrace.cycles-pp.security_task_getsecid.ima_file_check.path_openat.do_filp_open.do_sys_openat2
      0.93 ±  4%      -0.2        0.75 ±  9%  perf-profile.calltrace.cycles-pp.__d_lookup_rcu.lookup_fast.walk_component.link_path_walk.path_parentat
      0.76 ±  3%      -0.2        0.58 ±  4%  perf-profile.calltrace.cycles-pp.mnt_want_write.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.58 ±  4%      -0.2        0.40 ± 57%  perf-profile.calltrace.cycles-pp.call_rcu.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.73 ±  2%      -0.2        0.56 ±  5%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.getname_flags.do_sys_openat2.do_sys_open.do_syscall_64
      0.80 ±  5%      -0.2        0.63 ±  3%  perf-profile.calltrace.cycles-pp.__d_lookup_done.d_add.simple_lookup.path_openat.do_filp_open
      0.86 ±  3%      -0.1        0.72 ±  6%  perf-profile.calltrace.cycles-pp.inode_init_once.new_slab.___slab_alloc.__slab_alloc.kmem_cache_alloc
      0.72 ±  6%      -0.1        0.58 ±  7%  perf-profile.calltrace.cycles-pp.security_path_mknod.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      1.07 ±  2%      -0.1        0.94 ±  3%  perf-profile.calltrace.cycles-pp.inode_init_always.alloc_inode.new_inode_pseudo.new_inode.shmem_get_inode
      0.66 ±  4%      -0.1        0.57 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.getname_flags.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.68 ±  6%      -0.1        0.60 ±  2%  perf-profile.calltrace.cycles-pp.may_open.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.62 ±  5%      -0.1        0.55 ±  3%  perf-profile.calltrace.cycles-pp.iput.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.84 ±  2%      -0.1        0.78        perf-profile.calltrace.cycles-pp.d_instantiate.shmem_mknod.path_openat.do_filp_open.do_sys_openat2
      0.96 ±  2%      +0.2        1.20        perf-profile.calltrace.cycles-pp.security_file_free.__fput.task_work_run.exit_to_usermode_loop.do_syscall_64
      0.57 ±  7%      +0.3        0.91 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.security_file_alloc.__alloc_file.alloc_empty_file.path_openat
      0.86 ±  4%      +0.4        1.31 ±  2%  perf-profile.calltrace.cycles-pp.apparmor_file_alloc_security.security_file_alloc.__alloc_file.alloc_empty_file.path_openat
      0.26 ±100%      +0.5        0.75 ±  4%  perf-profile.calltrace.cycles-pp.inode_permission.link_path_walk.path_parentat.filename_parentat.do_unlinkat
      0.00            +0.6        0.57        perf-profile.calltrace.cycles-pp.dput.__traverse_mounts.step_into.walk_component.link_path_walk
      1.25 ±  2%      +0.6        1.82        perf-profile.calltrace.cycles-pp.kmem_cache_alloc.__alloc_file.alloc_empty_file.path_openat.do_filp_open
      0.00            +0.6        0.62 ±  4%  perf-profile.calltrace.cycles-pp.___slab_alloc.__slab_alloc.kmem_cache_alloc.__alloc_file.alloc_empty_file
      0.00            +0.6        0.63 ±  4%  perf-profile.calltrace.cycles-pp.__slab_alloc.kmem_cache_alloc.__alloc_file.alloc_empty_file.path_openat
      0.00            +0.7        0.65 ±  3%  perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_parentat.filename_parentat.do_unlinkat
      0.00            +0.7        0.69        perf-profile.calltrace.cycles-pp.lockref_put_return.dput.terminate_walk.path_openat.do_filp_open
      0.00            +0.7        0.71 ±  3%  perf-profile.calltrace.cycles-pp.inode_permission.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.00            +0.7        0.71 ±  4%  perf-profile.calltrace.cycles-pp.lockref_get.set_root.nd_jump_root.path_init.path_parentat
      0.00            +0.7        0.73 ±  2%  perf-profile.calltrace.cycles-pp.lockref_get.set_root.nd_jump_root.path_init.path_openat
     33.56            +0.7       34.29        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlink
     33.41            +0.7       34.16        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      1.57 ±  5%      +0.8        2.39        perf-profile.calltrace.cycles-pp.security_file_alloc.__alloc_file.alloc_empty_file.path_openat.do_filp_open
      1.19 ±  3%      +0.8        2.03 ±  4%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_openat.do_filp_open
      1.13 ±  4%      +0.9        2.01 ±  5%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_parentat.filename_parentat
      0.00            +0.9        0.94        perf-profile.calltrace.cycles-pp.terminate_walk.path_parentat.filename_parentat.do_unlinkat.do_syscall_64
      0.00            +1.0        0.96 ±  7%  perf-profile.calltrace.cycles-pp.__d_lookup.lookup_fast.walk_component.link_path_walk.path_parentat
      0.00            +1.0        0.97 ±  6%  perf-profile.calltrace.cycles-pp.__d_lookup.lookup_fast.walk_component.link_path_walk.path_openat
      0.74 ±  4%      +1.0        1.74 ±  2%  perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00            +1.1        1.06 ±  2%  perf-profile.calltrace.cycles-pp.dput.step_into.walk_component.link_path_walk.path_openat
      0.00            +1.1        1.13        perf-profile.calltrace.cycles-pp.dput.step_into.walk_component.link_path_walk.path_parentat
      0.00            +1.2        1.23 ±  2%  perf-profile.calltrace.cycles-pp.set_root.nd_jump_root.path_init.path_openat.do_filp_open
      0.00            +1.2        1.25 ±  4%  perf-profile.calltrace.cycles-pp.set_root.nd_jump_root.path_init.path_parentat.filename_parentat
      0.00            +1.3        1.25 ±  2%  perf-profile.calltrace.cycles-pp.lockref_put_return.dput.step_into.walk_component.link_path_walk
      0.00            +1.3        1.30 ±  3%  perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_openat2
      0.70 ±  2%      +1.3        2.02 ±  2%  perf-profile.calltrace.cycles-pp.path_init.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.74 ±  4%      +1.4        2.12 ±  2%  perf-profile.calltrace.cycles-pp.path_init.path_parentat.filename_parentat.do_unlinkat.do_syscall_64
      0.00            +1.6        1.61 ±  2%  perf-profile.calltrace.cycles-pp.__traverse_mounts.step_into.walk_component.link_path_walk.path_openat
      3.42 ±  2%      +1.6        5.05        perf-profile.calltrace.cycles-pp.__alloc_file.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
      0.00            +1.6        1.65        perf-profile.calltrace.cycles-pp.__traverse_mounts.step_into.walk_component.link_path_walk.path_parentat
      0.13 ±173%      +1.7        1.82 ±  3%  perf-profile.calltrace.cycles-pp.nd_jump_root.path_init.path_parentat.filename_parentat.do_unlinkat
      3.69 ±  2%      +1.7        5.39        perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00            +1.7        1.75        perf-profile.calltrace.cycles-pp.nd_jump_root.path_init.path_openat.do_filp_open.do_sys_openat2
     28.08            +1.8       29.88        perf-profile.calltrace.cycles-pp.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.00            +2.2        2.22 ±  2%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     41.25            +2.5       43.78        perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     41.05            +2.6       43.65        perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      0.00            +2.7        2.71        perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      0.70 ±  2%      +3.0        3.67        perf-profile.calltrace.cycles-pp.step_into.walk_component.link_path_walk.path_openat.do_filp_open
      0.64            +3.1        3.74        perf-profile.calltrace.cycles-pp.step_into.walk_component.link_path_walk.path_parentat.filename_parentat
     48.23            +3.7       51.98        perf-profile.calltrace.cycles-pp.open64
      2.15 ±  2%      +3.9        6.03        perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
     35.65            +3.9       39.58        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
     35.20            +4.0       39.18        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      1.99 ±  2%      +4.1        6.08        perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_parentat.filename_parentat.do_unlinkat
     44.61            +4.6       49.18        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
     44.42            +4.6       49.03        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      3.77            +4.7        8.43        perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      3.51 ±  2%      +4.9        8.45        perf-profile.calltrace.cycles-pp.link_path_walk.path_parentat.filename_parentat.do_unlinkat.do_syscall_64
      5.62            +6.9       12.55        perf-profile.calltrace.cycles-pp.filename_parentat.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      5.23            +7.0       12.20        perf-profile.calltrace.cycles-pp.path_parentat.filename_parentat.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.27            -3.7       10.53        perf-profile.children.cycles-pp.close
     10.36            -1.9        8.42        perf-profile.children.cycles-pp.shmem_mknod
      6.85 ±  2%      -1.6        5.23        perf-profile.children.cycles-pp.evict
      7.57            -1.5        6.03        perf-profile.children.cycles-pp.shmem_get_inode
      4.94            -1.1        3.83        perf-profile.children.cycles-pp.getname_flags
      4.83 ±  2%      -1.0        3.80        perf-profile.children.cycles-pp.syscall_return_via_sysret
      4.96            -1.0        3.93 ±  2%  perf-profile.children.cycles-pp.vfs_unlink
      4.45 ±  2%      -1.0        3.48        perf-profile.children.cycles-pp.entry_SYSCALL_64
      5.04            -1.0        4.08 ±  2%  perf-profile.children.cycles-pp.new_inode
      4.24 ±  2%      -0.9        3.32 ±  2%  perf-profile.children.cycles-pp.shmem_evict_inode
      3.02 ±  2%      -0.8        2.26        perf-profile.children.cycles-pp.strncpy_from_user
      3.11            -0.8        2.36 ±  2%  perf-profile.children.cycles-pp.do_dentry_open
      2.24            -0.6        1.65        perf-profile.children.cycles-pp.__check_object_size
      1.18 ±  2%      -0.6        0.59 ±  4%  perf-profile.children.cycles-pp.unlazy_walk
      1.37            -0.6        0.81 ±  2%  perf-profile.children.cycles-pp.complete_walk
      3.57            -0.6        3.02        perf-profile.children.cycles-pp.new_inode_pseudo
      2.59 ±  2%      -0.5        2.05        perf-profile.children.cycles-pp.__x64_sys_unlink
      2.52            -0.5        1.98        perf-profile.children.cycles-pp.shmem_truncate_range
      2.75 ±  2%      -0.5        2.24        perf-profile.children.cycles-pp.d_alloc_parallel
      3.29            -0.5        2.78        perf-profile.children.cycles-pp.alloc_inode
      2.15            -0.5        1.68        perf-profile.children.cycles-pp.shmem_undo_range
      1.99 ±  3%      -0.4        1.57 ±  3%  perf-profile.children.cycles-pp.simple_lookup
      2.01 ±  4%      -0.4        1.59 ±  5%  perf-profile.children.cycles-pp.__d_lookup_rcu
      2.08 ±  3%      -0.4        1.67        perf-profile.children.cycles-pp.d_alloc
      1.45 ±  3%      -0.4        1.05 ±  6%  perf-profile.children.cycles-pp.inode_sb_list_add
      1.65 ±  4%      -0.4        1.26        perf-profile.children.cycles-pp.__d_alloc
      1.68            -0.4        1.30        perf-profile.children.cycles-pp.__dentry_kill
      5.13 ±  4%      -0.4        4.75 ±  2%  perf-profile.children.cycles-pp.irq_exit
      2.16            -0.4        1.78 ±  4%  perf-profile.children.cycles-pp.shmem_alloc_inode
      1.58 ±  2%      -0.4        1.21 ±  2%  perf-profile.children.cycles-pp.mnt_want_write
      1.45 ±  2%      -0.4        1.08 ±  3%  perf-profile.children.cycles-pp.destroy_inode
      1.61 ±  4%      -0.4        1.25 ±  3%  perf-profile.children.cycles-pp.d_add
      3.14 ±  2%      -0.4        2.78 ±  2%  perf-profile.children.cycles-pp.kmem_cache_free
      1.32 ±  2%      -0.3        0.97 ±  5%  perf-profile.children.cycles-pp.__destroy_inode
      1.02            -0.3        0.70 ±  4%  perf-profile.children.cycles-pp.d_lookup
      1.42 ±  3%      -0.3        1.12        perf-profile.children.cycles-pp.__x64_sys_close
      1.14 ±  2%      -0.3        0.84 ±  3%  perf-profile.children.cycles-pp.dentry_unlink_inode
      1.06 ±  5%      -0.3        0.78 ±  3%  perf-profile.children.cycles-pp.fsnotify_destroy_marks
      0.88 ±  4%      -0.3        0.60        perf-profile.children.cycles-pp.__mnt_want_write
      0.79            -0.3        0.54 ±  7%  perf-profile.children.cycles-pp.lookup_dcache
      1.22 ±  3%      -0.2        0.97        perf-profile.children.cycles-pp.security_file_open
      1.20 ±  3%      -0.2        0.95 ±  4%  perf-profile.children.cycles-pp.current_time
      1.38            -0.2        1.13 ±  2%  perf-profile.children.cycles-pp.shmem_unlink
      0.85            -0.2        0.60 ±  8%  perf-profile.children.cycles-pp.__lookup_hash
      1.52            -0.2        1.27 ±  4%  perf-profile.children.cycles-pp.fsnotify
      0.98 ±  6%      -0.2        0.76 ±  4%  perf-profile.children.cycles-pp.ima_file_check
      1.02 ±  4%      -0.2        0.80 ±  3%  perf-profile.children.cycles-pp.apparmor_file_open
      0.80 ±  6%      -0.2        0.58 ±  2%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.97 ±  8%      -0.2        0.76 ±  8%  perf-profile.children.cycles-pp.shmem_free_inode
      0.90 ±  5%      -0.2        0.69 ±  4%  perf-profile.children.cycles-pp.fsnotify_grab_connector
      1.65 ±  3%      -0.2        1.44 ±  2%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      1.10 ±  3%      -0.2        0.90 ±  3%  perf-profile.children.cycles-pp.__alloc_fd
      0.95 ±  5%      -0.2        0.75 ±  3%  perf-profile.children.cycles-pp.shmem_reserve_inode
      0.85 ±  4%      -0.2        0.66 ±  3%  perf-profile.children.cycles-pp.filp_close
      0.98 ±  4%      -0.2        0.79 ±  5%  perf-profile.children.cycles-pp.down_write
      1.06            -0.2        0.88        perf-profile.children.cycles-pp.find_get_entries
      0.79 ±  6%      -0.2        0.60 ±  5%  perf-profile.children.cycles-pp.security_task_getsecid
      1.03 ±  4%      -0.2        0.85        perf-profile.children.cycles-pp.simple_acl_create
      0.67 ±  6%      -0.2        0.48 ±  4%  perf-profile.children.cycles-pp.security_path_unlink
      0.80 ±  5%      -0.2        0.64 ±  4%  perf-profile.children.cycles-pp.__d_lookup_done
      0.84 ±  7%      -0.2        0.67 ±  6%  perf-profile.children.cycles-pp.__sb_start_write
      2.00 ±  5%      -0.2        1.84 ±  3%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.60 ±  5%      -0.1        0.45        perf-profile.children.cycles-pp.inode_wait_for_writeback
      0.72 ±  7%      -0.1        0.58 ±  7%  perf-profile.children.cycles-pp.security_path_mknod
      1.09 ±  2%      -0.1        0.95 ±  3%  perf-profile.children.cycles-pp.inode_init_always
      0.86 ±  2%      -0.1        0.73 ±  5%  perf-profile.children.cycles-pp.inode_init_once
      2.27 ±  2%      -0.1        2.13 ±  2%  perf-profile.children.cycles-pp.__slab_alloc
      0.66 ±  4%      -0.1        0.53 ±  4%  perf-profile.children.cycles-pp.apparmor_task_getsecid
      0.48 ±  5%      -0.1        0.35 ±  3%  perf-profile.children.cycles-pp.may_delete
      0.49 ±  5%      -0.1        0.37 ±  7%  perf-profile.children.cycles-pp.__srcu_read_lock
      0.47 ±  4%      -0.1        0.35 ±  6%  perf-profile.children.cycles-pp.common_perm_rm
      0.63 ±  7%      -0.1        0.52        perf-profile.children.cycles-pp.posix_acl_create
      2.21 ±  2%      -0.1        2.09 ±  2%  perf-profile.children.cycles-pp.___slab_alloc
      0.44 ±  5%      -0.1        0.32 ±  3%  perf-profile.children.cycles-pp.drop_nlink
      0.44 ±  3%      -0.1        0.33 ±  7%  perf-profile.children.cycles-pp.i_callback
      0.43 ± 18%      -0.1        0.33 ±  7%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.51 ±  4%      -0.1        0.40 ±  4%  perf-profile.children.cycles-pp.shmem_free_in_core_inode
      0.49 ±  3%      -0.1        0.39 ±  4%  perf-profile.children.cycles-pp.__wake_up_common_lock
      0.41 ±  3%      -0.1        0.30 ±  6%  perf-profile.children.cycles-pp.clear_inode
      0.33 ± 10%      -0.1        0.22 ±  8%  perf-profile.children.cycles-pp.__d_rehash
      0.45 ±  5%      -0.1        0.34 ±  4%  perf-profile.children.cycles-pp.__check_heap_object
      0.36            -0.1        0.26        perf-profile.children.cycles-pp.__d_drop
      0.31 ±  6%      -0.1        0.21 ±  3%  perf-profile.children.cycles-pp.prandom_u32
      0.54 ±  3%      -0.1        0.45        perf-profile.children.cycles-pp.xas_find
      0.49 ±  5%      -0.1        0.40 ±  2%  perf-profile.children.cycles-pp._atomic_dec_and_lock
      0.33            -0.1        0.23 ±  3%  perf-profile.children.cycles-pp.___d_drop
      0.53 ±  7%      -0.1        0.44 ±  6%  perf-profile.children.cycles-pp.common_perm
      0.85 ±  3%      -0.1        0.76        perf-profile.children.cycles-pp.iput
      0.71 ±  6%      -0.1        0.63 ±  2%  perf-profile.children.cycles-pp.may_open
      0.41 ±  4%      -0.1        0.32 ± 10%  perf-profile.children.cycles-pp.d_delete
      0.25 ±  3%      -0.1        0.17 ±  7%  perf-profile.children.cycles-pp.ihold
      1.92 ±  2%      -0.1        1.84        perf-profile.children.cycles-pp.new_slab
      0.30 ± 14%      -0.1        0.22 ±  5%  perf-profile.children.cycles-pp.__srcu_read_unlock
      0.39 ±  4%      -0.1        0.32 ±  5%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.21 ±  8%      -0.1        0.14 ±  5%  perf-profile.children.cycles-pp.get_cached_acl
      0.86 ±  2%      -0.1        0.79        perf-profile.children.cycles-pp.d_instantiate
      0.60 ±  2%      -0.1        0.53 ±  4%  perf-profile.children.cycles-pp.__indirect_thunk_start
      0.32 ±  7%      -0.1        0.25 ±  5%  perf-profile.children.cycles-pp.get_acl
      0.11 ± 11%      -0.1        0.04 ± 58%  perf-profile.children.cycles-pp.put_pid
      0.25 ±  6%      -0.1        0.18 ±  6%  perf-profile.children.cycles-pp._find_next_bit
      0.20 ±  6%      -0.1        0.14 ± 12%  perf-profile.children.cycles-pp.prandom_u32_state
      0.44 ±  7%      -0.1        0.38 ±  7%  perf-profile.children.cycles-pp.common_perm_create
      0.16 ± 10%      -0.1        0.10 ± 10%  perf-profile.children.cycles-pp.apparmor_path_mknod
      0.33 ±  4%      -0.1        0.28 ±  3%  perf-profile.children.cycles-pp.xas_load
      0.29 ±  3%      -0.1        0.23 ±  6%  perf-profile.children.cycles-pp.map_id_up
      0.12 ±  8%      -0.1        0.07 ±  5%  perf-profile.children.cycles-pp.check_stack_object
      0.26 ±  4%      -0.1        0.20 ±  7%  perf-profile.children.cycles-pp.expand_files
      0.32 ±  4%      -0.0        0.27        perf-profile.children.cycles-pp.aa_get_task_label
      0.19 ± 15%      -0.0        0.14 ±  9%  perf-profile.children.cycles-pp.mnt_drop_write
      0.13 ±  8%      -0.0        0.08 ± 13%  perf-profile.children.cycles-pp.vfs_open
      0.18 ± 11%      -0.0        0.14 ±  6%  perf-profile.children.cycles-pp.always_delete_dentry
      0.15 ±  3%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.__fd_install
      0.16 ±  9%      -0.0        0.11 ± 13%  perf-profile.children.cycles-pp.file_ra_state_init
      0.15 ±  8%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp.__init_rwsem
      0.31 ±  5%      -0.0        0.27 ±  3%  perf-profile.children.cycles-pp.set_cached_acl
      0.18 ± 11%      -0.0        0.14 ± 12%  perf-profile.children.cycles-pp.putname
      0.13 ± 13%      -0.0        0.10 ± 11%  perf-profile.children.cycles-pp.apparmor_path_unlink
      0.11 ± 11%      -0.0        0.08 ± 11%  perf-profile.children.cycles-pp.__d_free
      0.32 ±  4%      -0.0        0.29 ±  3%  perf-profile.children.cycles-pp.__close_fd
      0.15 ±  5%      -0.0        0.12 ±  5%  perf-profile.children.cycles-pp.shmem_create
      0.17 ±  7%      -0.0        0.14 ±  6%  perf-profile.children.cycles-pp.__x64_sys_open
      0.17 ±  3%      -0.0        0.13 ±  8%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.13 ±  7%      -0.0        0.10 ± 13%  perf-profile.children.cycles-pp.get_unused_fd_flags
      0.09 ± 11%      -0.0        0.07 ± 13%  perf-profile.children.cycles-pp.__wake_up_bit
      0.23 ±  6%      -0.0        0.21 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.11 ±  9%      -0.0        0.09 ± 16%  perf-profile.children.cycles-pp.locks_remove_posix
      0.12 ±  6%      -0.0        0.10        perf-profile.children.cycles-pp.mpol_shared_policy_init
      0.11 ±  7%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.dnotify_flush
      0.09 ± 12%      +0.0        0.11 ±  7%  perf-profile.children.cycles-pp.__mnt_drop_write
      0.10 ±  4%      +0.0        0.12 ±  8%  perf-profile.children.cycles-pp.free_one_page
      0.13 ±  5%      +0.0        0.16 ±  7%  perf-profile.children.cycles-pp.__free_pages_ok
      0.12 ±  5%      +0.0        0.16 ±  7%  perf-profile.children.cycles-pp.d_flags_for_inode
      0.09 ± 15%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.mem_cgroup_handle_over_high
      0.07 ± 11%      +0.0        0.12 ±  5%  perf-profile.children.cycles-pp.legitimize_links
      0.01 ±173%      +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.security_inode_unlink
      0.71 ±  2%      +0.1        0.78 ±  4%  perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.25 ± 12%      +0.1        0.33 ±  6%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.19 ± 11%      +0.1        0.29 ±  2%  perf-profile.children.cycles-pp.mntget
      0.12 ±  7%      +0.1        0.23 ±  3%  perf-profile.children.cycles-pp.mntput
      0.06 ±  7%      +0.1        0.17 ±  6%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.08 ± 14%      +0.1        0.19 ±  5%  perf-profile.children.cycles-pp.ret_from_fork
      0.06 ±  7%      +0.1        0.17 ±  7%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.07 ± 14%      +0.1        0.19 ±  5%  perf-profile.children.cycles-pp.kthread
      0.66 ±  4%      +0.1        0.78 ±  4%  perf-profile.children.cycles-pp.rcu_all_qs
      0.34 ±  5%      +0.1        0.47 ±  5%  perf-profile.children.cycles-pp.__lookup_mnt
      0.39 ±  2%      +0.1        0.54 ±  3%  perf-profile.children.cycles-pp.security_inode_permission
      1.85            +0.1        1.99 ±  2%  perf-profile.children.cycles-pp.call_rcu
      0.22 ± 11%      +0.2        0.38 ±  3%  perf-profile.children.cycles-pp.path_get
      0.86 ±  3%      +0.2        1.04 ±  2%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.31 ±  4%      +0.2        0.50 ±  5%  perf-profile.children.cycles-pp.task_work_add
      0.39 ±  6%      +0.2        0.59 ±  7%  perf-profile.children.cycles-pp.mntput_no_expire
      0.37 ±  4%      +0.2        0.61 ±  3%  perf-profile.children.cycles-pp.memset_erms
      0.96 ±  2%      +0.2        1.21        perf-profile.children.cycles-pp.security_file_free
      1.35 ±  2%      +0.3        1.61        perf-profile.children.cycles-pp.__might_sleep
      1.07 ±  6%      +0.3        1.34 ±  3%  perf-profile.children.cycles-pp.lockref_put_or_lock
      0.45 ±  5%      +0.3        0.75 ±  2%  perf-profile.children.cycles-pp.file_free_rcu
      0.46 ±  3%      +0.3        0.76 ±  4%  perf-profile.children.cycles-pp.fput_many
      1.28 ±  5%      +0.3        1.59 ±  3%  perf-profile.children.cycles-pp._cond_resched
      0.75 ±  3%      +0.3        1.06 ±  6%  perf-profile.children.cycles-pp.generic_permission
      0.00            +0.3        0.33 ±  7%  perf-profile.children.cycles-pp.__legitimize_path
      1.84            +0.4        2.20 ±  3%  perf-profile.children.cycles-pp.inode_permission
      0.00            +0.4        0.41 ±  2%  perf-profile.children.cycles-pp.legitimize_mnt
      1.88 ±  2%      +0.4        2.31        perf-profile.children.cycles-pp.___might_sleep
      0.87 ±  4%      +0.5        1.32 ±  2%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      1.57 ±  5%      +0.8        2.40        perf-profile.children.cycles-pp.security_file_alloc
      0.00            +0.9        0.93 ±  2%  perf-profile.children.cycles-pp.lookup_mnt
      5.28 ±  2%      +1.0        6.29        perf-profile.children.cycles-pp.task_work_run
      5.96            +1.2        7.12        perf-profile.children.cycles-pp.exit_to_usermode_loop
      3.44 ±  2%      +1.6        5.08        perf-profile.children.cycles-pp.__alloc_file
      0.89 ±  2%      +1.7        2.57 ±  5%  perf-profile.children.cycles-pp.__d_lookup
      3.71 ±  2%      +1.7        5.42        perf-profile.children.cycles-pp.alloc_empty_file
      2.36 ±  3%      +1.7        4.09 ±  4%  perf-profile.children.cycles-pp.lookup_fast
     28.19            +1.8       29.95        perf-profile.children.cycles-pp.do_unlinkat
      0.96 ±  4%      +1.8        2.78        perf-profile.children.cycles-pp.terminate_walk
      0.62 ±  5%      +1.9        2.51 ±  2%  perf-profile.children.cycles-pp.set_root
     88.97            +2.3       91.27        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.00            +2.3        2.34        perf-profile.children.cycles-pp.lockref_put_return
     88.49            +2.4       90.91        perf-profile.children.cycles-pp.do_syscall_64
     41.26            +2.5       43.80        perf-profile.children.cycles-pp.do_sys_open
     41.11            +2.6       43.69        perf-profile.children.cycles-pp.do_sys_openat2
      0.99 ±  4%      +2.6        3.63        perf-profile.children.cycles-pp.nd_jump_root
      1.49 ±  2%      +2.7        4.20        perf-profile.children.cycles-pp.path_init
      0.35 ±  6%      +2.8        3.17        perf-profile.children.cycles-pp.lockref_get
      0.00            +3.3        3.31        perf-profile.children.cycles-pp.__traverse_mounts
     48.43            +3.7       52.15        perf-profile.children.cycles-pp.open64
      5.37 ±  3%      +3.9        9.28        perf-profile.children.cycles-pp.dput
     35.68            +3.9       39.61        perf-profile.children.cycles-pp.do_filp_open
     35.37            +4.0       39.39        perf-profile.children.cycles-pp.path_openat
      1.37            +6.1        7.49        perf-profile.children.cycles-pp.step_into
      5.65            +6.9       12.57        perf-profile.children.cycles-pp.filename_parentat
      5.28            +7.0       12.25        perf-profile.children.cycles-pp.path_parentat
      4.20 ±  2%      +8.0       12.19        perf-profile.children.cycles-pp.walk_component
      7.36            +9.6       16.99        perf-profile.children.cycles-pp.link_path_walk
      8.05            -2.0        6.01        perf-profile.self.cycles-pp.do_syscall_64
      4.82 ±  2%      -1.0        3.79        perf-profile.self.cycles-pp.syscall_return_via_sysret
      3.97 ±  2%      -0.9        3.11        perf-profile.self.cycles-pp.entry_SYSCALL_64
      1.86 ±  4%      -0.4        1.48 ±  5%  perf-profile.self.cycles-pp.__d_lookup_rcu
      1.79            -0.3        1.50 ±  5%  perf-profile.self.cycles-pp.kmem_cache_free
      0.83 ±  5%      -0.3        0.56 ±  2%  perf-profile.self.cycles-pp.__mnt_want_write
      1.40 ±  2%      -0.2        1.18 ±  2%  perf-profile.self.cycles-pp.fsnotify
      0.87 ±  2%      -0.2        0.66 ±  3%  perf-profile.self.cycles-pp.__check_object_size
      0.95 ±  3%      -0.2        0.75 ±  3%  perf-profile.self.cycles-pp.apparmor_file_open
      1.62 ±  3%      -0.2        1.42 ±  2%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      1.86 ±  5%      -0.2        1.67 ±  2%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.71 ±  7%      -0.2        0.52 ±  3%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.58 ±  3%      -0.2        0.41 ±  3%  perf-profile.self.cycles-pp.__destroy_inode
      0.73 ±  3%      -0.2        0.56 ±  2%  perf-profile.self.cycles-pp.shmem_get_inode
      2.56 ±  2%      -0.2        2.39 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc
      1.81            -0.2        1.65 ±  3%  perf-profile.self.cycles-pp.path_openat
      0.53 ±  6%      -0.2        0.37 ±  4%  perf-profile.self.cycles-pp.do_sys_openat2
      0.74 ±  3%      -0.2        0.59 ±  4%  perf-profile.self.cycles-pp.strncpy_from_user
      0.51 ±  6%      -0.1        0.37 ±  8%  perf-profile.self.cycles-pp.do_unlinkat
      0.75 ±  2%      -0.1        0.62 ±  3%  perf-profile.self.cycles-pp.__fput
      0.71 ±  2%      -0.1        0.58 ±  5%  perf-profile.self.cycles-pp.do_dentry_open
      0.50 ±  2%      -0.1        0.37 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.79 ±  4%      -0.1        0.67 ±  6%  perf-profile.self.cycles-pp.inode_init_once
      0.42 ±  9%      -0.1        0.30 ±  5%  perf-profile.self.cycles-pp.shmem_free_inode
      0.44 ±  5%      -0.1        0.33 ±  7%  perf-profile.self.cycles-pp.shmem_reserve_inode
      0.55 ±  4%      -0.1        0.44 ±  4%  perf-profile.self.cycles-pp.shmem_undo_range
      0.42 ±  3%      -0.1        0.31 ±  9%  perf-profile.self.cycles-pp.i_callback
      0.54 ±  5%      -0.1        0.43 ±  2%  perf-profile.self.cycles-pp.inode_init_always
      0.41 ±  4%      -0.1        0.31        perf-profile.self.cycles-pp.drop_nlink
      0.45 ±  7%      -0.1        0.35 ±  7%  perf-profile.self.cycles-pp.__srcu_read_lock
      0.53 ±  3%      -0.1        0.43 ±  4%  perf-profile.self.cycles-pp.d_alloc_parallel
      0.48 ±  3%      -0.1        0.38 ±  5%  perf-profile.self.cycles-pp.shmem_free_in_core_inode
      0.41 ± 18%      -0.1        0.31 ±  8%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.32 ±  4%      -0.1        0.23 ±  2%  perf-profile.self.cycles-pp.d_add
      0.41 ±  6%      -0.1        0.32        perf-profile.self.cycles-pp.__check_heap_object
      0.42 ±  3%      -0.1        0.32 ±  3%  perf-profile.self.cycles-pp.current_time
      0.37 ±  8%      -0.1        0.28 ± 15%  perf-profile.self.cycles-pp.vfs_unlink
      0.50 ±  7%      -0.1        0.41 ±  6%  perf-profile.self.cycles-pp.common_perm
      0.49 ±  5%      -0.1        0.40 ±  4%  perf-profile.self.cycles-pp.find_get_entries
      0.33 ±  6%      -0.1        0.25 ±  7%  perf-profile.self.cycles-pp.__dentry_kill
      0.30 ±  4%      -0.1        0.22        perf-profile.self.cycles-pp.___d_drop
      0.32 ±  6%      -0.1        0.24 ± 10%  perf-profile.self.cycles-pp.apparmor_task_getsecid
      0.29 ±  7%      -0.1        0.21 ±  5%  perf-profile.self.cycles-pp.__d_alloc
      0.44 ±  5%      -0.1        0.36 ±  6%  perf-profile.self.cycles-pp.getname_flags
      0.41 ±  4%      -0.1        0.34 ±  5%  perf-profile.self.cycles-pp.__alloc_fd
      0.25 ±  4%      -0.1        0.18 ±  6%  perf-profile.self.cycles-pp.unlink
      0.35 ±  3%      -0.1        0.28 ±  4%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.17 ±  3%      -0.1        0.10 ±  5%  perf-profile.self.cycles-pp.fsnotify_destroy_marks
      0.10 ± 15%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.put_pid
      0.40 ±  3%      -0.1        0.33 ±  2%  perf-profile.self.cycles-pp.down_write
      0.19 ±  6%      -0.1        0.12 ± 13%  perf-profile.self.cycles-pp.prandom_u32_state
      0.22 ±  4%      -0.1        0.15 ±  3%  perf-profile.self.cycles-pp.do_filp_open
      0.22 ±  7%      -0.1        0.15 ±  2%  perf-profile.self.cycles-pp.may_delete
      0.21 ±  6%      -0.1        0.15 ±  7%  perf-profile.self.cycles-pp.ihold
      0.20 ±  5%      -0.1        0.13 ±  5%  perf-profile.self.cycles-pp.get_cached_acl
      0.33 ±  3%      -0.1        0.27 ±  7%  perf-profile.self.cycles-pp.shmem_evict_inode
      0.27 ±  4%      -0.1        0.21 ±  3%  perf-profile.self.cycles-pp.map_id_up
      0.27 ± 12%      -0.1        0.21 ±  5%  perf-profile.self.cycles-pp.__srcu_read_unlock
      0.51 ±  2%      -0.1        0.45 ±  5%  perf-profile.self.cycles-pp.__indirect_thunk_start
      0.14 ± 10%      -0.1        0.08 ±  5%  perf-profile.self.cycles-pp.apparmor_path_mknod
      0.32 ±  3%      -0.1        0.26 ±  2%  perf-profile.self.cycles-pp._atomic_dec_and_lock
      0.29 ±  7%      -0.1        0.24 ±  9%  perf-profile.self.cycles-pp.__d_lookup_done
      0.11 ±  4%      -0.1        0.06 ±  6%  perf-profile.self.cycles-pp.check_stack_object
      0.27 ±  8%      -0.0        0.22 ±  6%  perf-profile.self.cycles-pp.open64
      0.21 ±  8%      -0.0        0.16 ±  7%  perf-profile.self.cycles-pp.__x64_sys_close
      0.22 ±  6%      -0.0        0.17 ±  4%  perf-profile.self.cycles-pp._find_next_bit
      0.21 ± 12%      -0.0        0.16 ±  6%  perf-profile.self.cycles-pp.simple_lookup
      0.12 ± 14%      -0.0        0.08 ± 14%  perf-profile.self.cycles-pp.ima_file_check
      0.38 ±  4%      -0.0        0.33 ±  2%  perf-profile.self.cycles-pp.up_write
      0.15 ± 10%      -0.0        0.10 ± 14%  perf-profile.self.cycles-pp.file_ra_state_init
      0.17 ±  8%      -0.0        0.12 ±  8%  perf-profile.self.cycles-pp.dentry_unlink_inode
      0.15 ±  3%      -0.0        0.10 ±  7%  perf-profile.self.cycles-pp.__fd_install
      0.22 ±  4%      -0.0        0.18 ± 10%  perf-profile.self.cycles-pp.shmem_mknod
      0.24 ±  6%      -0.0        0.20 ±  5%  perf-profile.self.cycles-pp.xas_find
      0.18 ± 15%      -0.0        0.13 ±  9%  perf-profile.self.cycles-pp.mnt_drop_write
      0.29            -0.0        0.24 ±  5%  perf-profile.self.cycles-pp.aa_get_task_label
      0.21 ±  5%      -0.0        0.17 ±  6%  perf-profile.self.cycles-pp.__d_instantiate
      0.14 ±  5%      -0.0        0.10 ± 12%  perf-profile.self.cycles-pp.do_sys_open
      0.10 ± 12%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.inode_sb_list_add
      0.22 ±  3%      -0.0        0.18 ±  6%  perf-profile.self.cycles-pp.expand_files
      0.12 ± 11%      -0.0        0.08 ± 17%  perf-profile.self.cycles-pp.d_lookup
      0.11 ± 12%      -0.0        0.07 ± 17%  perf-profile.self.cycles-pp.security_task_getsecid
      0.15 ±  9%      -0.0        0.11 ± 11%  perf-profile.self.cycles-pp.common_perm_rm
      0.15 ±  7%      -0.0        0.11 ±  9%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.16 ± 10%      -0.0        0.12 ±  5%  perf-profile.self.cycles-pp.always_delete_dentry
      0.10 ±  8%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.__d_free
      0.29 ±  3%      -0.0        0.25 ±  4%  perf-profile.self.cycles-pp.set_cached_acl
      0.21 ±  8%      -0.0        0.17 ± 11%  perf-profile.self.cycles-pp.memcpy_erms
      0.25 ±  4%      -0.0        0.22 ±  7%  perf-profile.self.cycles-pp.evict
      0.08 ±  6%      -0.0        0.04 ± 58%  perf-profile.self.cycles-pp.clear_inode
      0.22 ±  9%      -0.0        0.19 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.13 ±  8%      -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.__init_rwsem
      0.22 ±  6%      -0.0        0.19 ±  7%  perf-profile.self.cycles-pp.shmem_unlink
      0.15 ±  6%      -0.0        0.12 ±  5%  perf-profile.self.cycles-pp.__x64_sys_open
      0.10 ± 10%      -0.0        0.07 ± 17%  perf-profile.self.cycles-pp.prandom_u32
      0.12 ±  5%      -0.0        0.09 ± 13%  perf-profile.self.cycles-pp.get_unused_fd_flags
      0.09 ±  4%      -0.0        0.06 ± 13%  perf-profile.self.cycles-pp.vfs_open
      0.10 ±  9%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.xas_load
      0.12 ±  7%      -0.0        0.09 ± 17%  perf-profile.self.cycles-pp.restore_nameidata
      0.11 ± 17%      -0.0        0.09 ±  9%  perf-profile.self.cycles-pp.d_instantiate
      0.14 ±  3%      -0.0        0.11 ±  6%  perf-profile.self.cycles-pp.shmem_create
      0.16 ±  2%      -0.0        0.13 ±  9%  perf-profile.self.cycles-pp.__x64_sys_unlink
      0.11 ±  4%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.mpol_shared_policy_init
      0.08 ±  8%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.__wake_up_bit
      0.10 ±  7%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.dnotify_flush
      0.06 ± 11%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.try_module_get
      0.11 ±  6%      +0.0        0.13 ±  6%  perf-profile.self.cycles-pp.d_flags_for_inode
      0.06 ±  7%      +0.0        0.09 ± 13%  perf-profile.self.cycles-pp.d_delete
      0.08 ± 14%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.mem_cgroup_handle_over_high
      0.03 ±100%      +0.0        0.07 ± 10%  perf-profile.self.cycles-pp.__lookup_hash
      0.08 ± 12%      +0.0        0.12 ±  6%  perf-profile.self.cycles-pp.security_file_free
      0.06 ± 11%      +0.0        0.11 ±  7%  perf-profile.self.cycles-pp.legitimize_links
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.security_inode_unlink
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.legitimize_mnt
      0.22 ±  8%      +0.1        0.29 ±  6%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.96 ±  2%      +0.1        1.03 ±  3%  perf-profile.self.cycles-pp.call_rcu
      0.71 ±  2%      +0.1        0.78 ±  3%  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.07 ± 10%      +0.1        0.15 ±  8%  perf-profile.self.cycles-pp.mntput
      0.49 ±  5%      +0.1        0.57 ±  3%  perf-profile.self.cycles-pp.path_init
      0.40 ±  6%      +0.1        0.48 ±  3%  perf-profile.self.cycles-pp.new_slab
      0.16 ± 11%      +0.1        0.25 ±  3%  perf-profile.self.cycles-pp.mntget
      0.01 ±173%      +0.1        0.10 ±  7%  perf-profile.self.cycles-pp.path_get
      0.33 ±  6%      +0.1        0.43 ±  3%  perf-profile.self.cycles-pp.nd_jump_root
      0.14 ±  7%      +0.1        0.24 ±  2%  perf-profile.self.cycles-pp.path_parentat
      0.51 ±  4%      +0.1        0.61 ±  5%  perf-profile.self.cycles-pp.rcu_all_qs
      0.39 ±  9%      +0.1        0.49 ±  3%  perf-profile.self.cycles-pp.exit_to_usermode_loop
      0.15 ±  3%      +0.1        0.25 ±  6%  perf-profile.self.cycles-pp.fput_many
      0.80 ±  6%      +0.1        0.93 ±  3%  perf-profile.self.cycles-pp.lockref_put_or_lock
      0.24            +0.1        0.37 ±  7%  perf-profile.self.cycles-pp.terminate_walk
      0.30 ±  6%      +0.1        0.43 ±  5%  perf-profile.self.cycles-pp.__lookup_mnt
      4.10 ±  2%      +0.1        4.23        perf-profile.self.cycles-pp._raw_spin_lock
      0.37            +0.1        0.51 ±  3%  perf-profile.self.cycles-pp.security_inode_permission
      0.00            +0.2        0.15 ± 11%  perf-profile.self.cycles-pp.__legitimize_path
      0.44 ±  2%      +0.2        0.60 ±  3%  perf-profile.self.cycles-pp.walk_component
      0.80 ±  3%      +0.2        0.96        perf-profile.self.cycles-pp.apparmor_file_free_security
      0.36 ±  7%      +0.2        0.53 ±  5%  perf-profile.self.cycles-pp.mntput_no_expire
      0.58 ±  7%      +0.2        0.75 ±  3%  perf-profile.self.cycles-pp._cond_resched
      0.26 ±  7%      +0.2        0.44 ±  4%  perf-profile.self.cycles-pp.task_work_add
      0.45 ±  5%      +0.2        0.64 ±  2%  perf-profile.self.cycles-pp.lookup_fast
      0.54 ±  4%      +0.2        0.74 ±  2%  perf-profile.self.cycles-pp.__alloc_file
      0.34 ±  3%      +0.2        0.57 ±  4%  perf-profile.self.cycles-pp.memset_erms
      1.13 ±  2%      +0.3        1.39 ±  2%  perf-profile.self.cycles-pp.__might_sleep
      0.69 ±  4%      +0.3        0.96 ±  7%  perf-profile.self.cycles-pp.generic_permission
      0.00            +0.3        0.29 ±  3%  perf-profile.self.cycles-pp.lookup_mnt
      0.43 ±  5%      +0.3        0.73 ±  3%  perf-profile.self.cycles-pp.file_free_rcu
      0.65 ±  3%      +0.3        0.97 ±  2%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.00            +0.4        0.39 ±  5%  perf-profile.self.cycles-pp.__traverse_mounts
      1.72 ±  2%      +0.4        2.14 ±  2%  perf-profile.self.cycles-pp.___might_sleep
      0.41 ±  2%      +0.5        0.86 ±  5%  perf-profile.self.cycles-pp.task_work_run
      0.98            +0.5        1.46 ±  6%  perf-profile.self.cycles-pp.step_into
      0.90 ±  5%      +0.6        1.47 ±  3%  perf-profile.self.cycles-pp.dput
      0.72            +0.7        1.47 ±  6%  perf-profile.self.cycles-pp.__d_lookup
      1.86 ±  2%      +0.9        2.81        perf-profile.self.cycles-pp.link_path_walk
      0.00            +2.2        2.20        perf-profile.self.cycles-pp.lockref_put_return
      0.33 ±  5%      +2.7        3.00        perf-profile.self.cycles-pp.lockref_get



***************************************************************************************************
lkp-csl-2ap4: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
  gcc-7/performance/x86_64-rhel-7.6/process/100%/debian-x86_64-20191114.cgz/lkp-csl-2ap4/unlink2/will-it-scale/0x500002c

commit: 
  7ef482fa65 ("helper for mount rootwards traversal")
  2aa3847085 ("non-RCU analogue of the previous commit")

7ef482fa65513b18 2aa38470853a65dc9b1b4bd0989 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :4           50%           2:4     dmesg.WARNING:at#for_ip_swapgs_restore_regs_and_return_to_usermode/0x
           :4           50%           2:4     dmesg.WARNING:stack_recursion
         %stddev     %change         %stddev
             \          |                \  
      3880 ±  2%     -63.9%       1399        will-it-scale.per_process_ops
    745214 ±  2%     -63.9%     268803        will-it-scale.workload
      5866 ±  3%      +4.7%       6140 ±  5%  boot-time.idle
      0.09 ± 12%      -0.0        0.05        mpstat.cpu.all.usr%
      6487            -9.2%       5892        vmstat.system.cs
    502549 ±  7%     -35.4%     324734 ± 42%  numa-numastat.node0.numa_hit
    613871 ± 35%     -77.3%     139047 ± 83%  numa-numastat.node1.local_node
    637197 ± 33%     -74.0%     165465 ± 66%  numa-numastat.node1.numa_hit
    735095 ± 40%     -80.3%     145175 ± 89%  numa-numastat.node2.local_node
    755291 ± 38%     -76.7%     176203 ± 73%  numa-numastat.node2.numa_hit
     31049           -59.7%      12501 ±104%  numa-numastat.node3.other_node
     33137 ±  3%     +12.5%      37269 ±  3%  meminfo.Inactive
     32126 ±  3%     +12.9%      36272 ±  3%  meminfo.Inactive(anon)
    148996           -12.2%     130758        meminfo.KReclaimable
     41833 ±  2%     +14.5%      47911 ±  3%  meminfo.Mapped
    148996           -12.2%     130758        meminfo.SReclaimable
    456397           -17.6%     376155        meminfo.SUnreclaim
    605393           -16.3%     506914        meminfo.Slab
      7258           +43.8%      10435 ± 22%  numa-meminfo.node0.Mapped
    126834 ±  7%     -14.9%     107888 ±  9%  numa-meminfo.node0.SUnreclaim
    112997 ±  4%     -23.6%      86362 ±  4%  numa-meminfo.node1.SUnreclaim
    156389 ±  9%     -24.5%     118057 ±  6%  numa-meminfo.node1.Slab
      7923 ± 18%     +28.1%      10148 ± 20%  numa-meminfo.node2.Mapped
    108798 ±  5%     -19.7%      87376 ± 10%  numa-meminfo.node2.SUnreclaim
    143343 ±  8%     -19.0%     116099 ±  7%  numa-meminfo.node2.Slab
     10004 ±  2%     +12.7%      11279 ±  4%  numa-meminfo.node3.PageTables
    108055 ±  4%     -12.4%      94628 ±  5%  numa-meminfo.node3.SUnreclaim
      1817           +45.5%       2643 ± 21%  numa-vmstat.node0.nr_mapped
     31692 ±  7%     -14.9%      26971 ±  9%  numa-vmstat.node0.nr_slab_unreclaimable
     28249 ±  4%     -23.6%      21593 ±  4%  numa-vmstat.node1.nr_slab_unreclaimable
    714207 ± 19%     -40.3%     426037 ± 14%  numa-vmstat.node1.numa_hit
    603812 ± 22%     -48.2%     312798 ± 21%  numa-vmstat.node1.numa_local
      2017 ± 19%     +28.3%       2589 ± 20%  numa-vmstat.node2.nr_mapped
     27201 ±  5%     -19.7%      21849 ± 10%  numa-vmstat.node2.nr_slab_unreclaimable
    769559 ± 20%     -42.6%     441768 ± 22%  numa-vmstat.node2.numa_hit
    661829 ± 25%     -51.1%     323479 ± 30%  numa-vmstat.node2.numa_local
      2501 ±  2%     +12.7%       2817 ±  4%  numa-vmstat.node3.nr_page_table_pages
     26986 ±  5%     -12.3%      23663 ±  5%  numa-vmstat.node3.nr_slab_unreclaimable
    118367           -15.7%      99809 ± 12%  numa-vmstat.node3.numa_other
      7920 ±  2%     +15.9%       9181 ±  5%  proc-vmstat.nr_inactive_anon
     10431           +17.5%      12259 ±  4%  proc-vmstat.nr_mapped
     37247           -12.2%      32687        proc-vmstat.nr_slab_reclaimable
    114175           -17.6%      94052        proc-vmstat.nr_slab_unreclaimable
      7920 ±  2%     +15.9%       9181 ±  5%  proc-vmstat.nr_zone_inactive_anon
      1130 ± 52%    +601.0%       7926 ± 92%  proc-vmstat.numa_hint_faults
    170.00 ±126%   +1340.7%       2449 ±125%  proc-vmstat.numa_hint_faults_local
   2380298 ±  7%     -58.8%     981568        proc-vmstat.numa_hit
   2287151 ±  7%     -61.2%     888409        proc-vmstat.numa_local
  10000704 ±  9%     -87.8%    1217641 ±  2%  proc-vmstat.pgalloc_normal
   1077079            -6.6%    1006478        proc-vmstat.pgfault
   9983700 ±  9%     -87.9%    1209551 ±  3%  proc-vmstat.pgfree
    359184 ±  2%     -25.8%     266447 ±  2%  slabinfo.dentry.active_objs
      8557 ±  2%     -25.4%       6385 ±  2%  slabinfo.dentry.active_slabs
    359427 ±  2%     -25.4%     268195 ±  2%  slabinfo.dentry.num_objs
      8557 ±  2%     -25.4%       6385 ±  2%  slabinfo.dentry.num_slabs
      7976 ±  5%     -22.8%       6157 ± 11%  slabinfo.eventpoll_pwq.active_objs
      7976 ±  5%     -22.8%       6157 ± 11%  slabinfo.eventpoll_pwq.num_objs
    232351 ±  2%     -15.3%     196809        slabinfo.filp.active_objs
      3665 ±  2%     -15.8%       3087        slabinfo.filp.active_slabs
    234623 ±  2%     -15.8%     197603        slabinfo.filp.num_objs
      3665 ±  2%     -15.8%       3087        slabinfo.filp.num_slabs
    213457 ±  2%     -47.8%     111478 ±  2%  slabinfo.shmem_inode_cache.active_objs
      4730 ±  2%     -48.8%       2423 ±  2%  slabinfo.shmem_inode_cache.active_slabs
    217602 ±  2%     -48.8%     111510 ±  2%  slabinfo.shmem_inode_cache.num_objs
      4730 ±  2%     -48.8%       2423 ±  2%  slabinfo.shmem_inode_cache.num_slabs
    365.35 ±  7%     +33.1%     486.42 ±  5%  sched_debug.cfs_rq:/.exec_clock.stddev
    153.38 ± 21%     +87.7%     287.96 ± 33%  sched_debug.cfs_rq:/.load_avg.max
    214155 ±  5%     +71.0%     366144 ±  8%  sched_debug.cfs_rq:/.min_vruntime.stddev
      4.88 ±  4%     -15.5%       4.13 ± 13%  sched_debug.cfs_rq:/.nr_spread_over.stddev
     13.00 ±  5%    +996.2%     142.50 ± 99%  sched_debug.cfs_rq:/.runnable_load_avg.max
      1.07 ± 10%    +868.9%      10.39 ± 98%  sched_debug.cfs_rq:/.runnable_load_avg.stddev
  -1560685           +63.5%   -2551048        sched_debug.cfs_rq:/.spread0.min
    214312 ±  5%     +70.9%     366206 ±  8%  sched_debug.cfs_rq:/.spread0.stddev
    794.38 ±  6%     -28.5%     567.62 ± 11%  sched_debug.cfs_rq:/.util_avg.min
     48.11 ±  3%     +36.1%      65.47 ±  2%  sched_debug.cfs_rq:/.util_avg.stddev
    563.83 ±  5%     +24.8%     703.79 ± 11%  sched_debug.cfs_rq:/.util_est_enqueued.max
   2517801 ± 23%     -54.6%    1142262 ±  9%  sched_debug.cpu.avg_idle.max
    173309 ± 22%     -41.8%     100875 ±  9%  sched_debug.cpu.avg_idle.stddev
     22.50 ±  3%     -19.7%      18.07 ±  5%  sched_debug.cpu.clock.stddev
     22.50 ±  3%     -19.7%      18.07 ±  5%  sched_debug.cpu.clock_task.stddev
    697954 ± 15%     -26.4%     513684        sched_debug.cpu.max_idle_balance_cost.max
     16054 ± 58%     -88.7%       1807 ± 86%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.12 ± 11%     +20.8%       0.14 ± 11%  sched_debug.cpu.nr_running.stddev
      2498           -10.2%       2243        sched_debug.cpu.ttwu_count.avg
      1838 ±  2%     -10.3%       1648        sched_debug.cpu.ttwu_count.min
      2425           -10.7%       2166        sched_debug.cpu.ttwu_local.avg
     12.75 ± 23%   +1002.0%     140.50 ± 85%  interrupts.CPU104.RES:Rescheduling_interrupts
      9.25 ± 11%    +948.6%      97.00 ±140%  interrupts.CPU107.RES:Rescheduling_interrupts
      8.50 ± 17%    +641.2%      63.00 ±106%  interrupts.CPU108.RES:Rescheduling_interrupts
     26.50 ±114%    +620.8%     191.00 ± 60%  interrupts.CPU111.RES:Rescheduling_interrupts
      9.00 ± 19%    +483.3%      52.50 ± 94%  interrupts.CPU112.RES:Rescheduling_interrupts
      7.75 ± 10%    +461.3%      43.50 ±103%  interrupts.CPU117.RES:Rescheduling_interrupts
    275.75 ±  4%     +34.1%     369.75 ± 24%  interrupts.CPU12.RES:Rescheduling_interrupts
     10.75 ± 28%   +2455.8%     274.75 ±160%  interrupts.CPU120.RES:Rescheduling_interrupts
      8.75 ± 21%   +1734.3%     160.50 ±152%  interrupts.CPU127.RES:Rescheduling_interrupts
     54.50 ± 51%     -69.7%      16.50 ± 15%  interrupts.CPU158.RES:Rescheduling_interrupts
     11.75 ± 30%    +255.3%      41.75 ± 93%  interrupts.CPU167.RES:Rescheduling_interrupts
      8.75 ± 28%    +697.1%      69.75 ±120%  interrupts.CPU168.RES:Rescheduling_interrupts
      9.00 ± 20%   +1488.9%     143.00 ± 68%  interrupts.CPU169.RES:Rescheduling_interrupts
      8.25 ± 23%    +897.0%      82.25 ±108%  interrupts.CPU176.RES:Rescheduling_interrupts
     10.25 ± 18%    +553.7%      67.00 ± 69%  interrupts.CPU177.RES:Rescheduling_interrupts
      5472 ± 34%     +59.9%       8751        interrupts.CPU180.NMI:Non-maskable_interrupts
      5472 ± 34%     +59.9%       8751        interrupts.CPU180.PMI:Performance_monitoring_interrupts
     10.50 ± 35%    +302.4%      42.25 ±107%  interrupts.CPU182.RES:Rescheduling_interrupts
      7.75 ± 27%    +835.5%      72.50 ±128%  interrupts.CPU184.RES:Rescheduling_interrupts
     11.50 ± 32%    +304.3%      46.50 ±105%  interrupts.CPU186.RES:Rescheduling_interrupts
      8.50 ± 13%    +905.9%      85.50 ±120%  interrupts.CPU187.RES:Rescheduling_interrupts
     12.50 ± 62%    +384.0%      60.50 ± 98%  interrupts.CPU188.RES:Rescheduling_interrupts
      9.75 ± 13%   +2287.2%     232.75 ±155%  interrupts.CPU189.RES:Rescheduling_interrupts
    280.00 ±  5%     +12.1%     313.75 ± 11%  interrupts.CPU21.RES:Rescheduling_interrupts
    378.50 ± 32%     -26.8%     277.25        interrupts.CPU33.RES:Rescheduling_interrupts
    396.00 ± 32%     -29.7%     278.50 ±  4%  interrupts.CPU46.RES:Rescheduling_interrupts
    445.25 ± 39%     -34.6%     291.00 ±  8%  interrupts.CPU55.RES:Rescheduling_interrupts
    326.00 ± 12%     -16.6%     272.00        interrupts.CPU57.RES:Rescheduling_interrupts
    257.00 ±  4%     +20.5%     309.75 ±  7%  interrupts.CPU76.RES:Rescheduling_interrupts
      3.61 ± 11%     -56.2%       1.58 ±  5%  perf-stat.i.MPKI
 1.324e+10            -5.3%  1.253e+10        perf-stat.i.branch-instructions
      0.23 ±  2%      -0.1        0.17        perf-stat.i.branch-miss-rate%
  28145064 ±  2%     -29.6%   19823404        perf-stat.i.branch-misses
     59.19 ±  2%     -10.9       48.29 ±  3%  perf-stat.i.cache-miss-rate%
 1.179e+08 ± 14%     -67.6%   38197567 ±  7%  perf-stat.i.cache-misses
 1.985e+08 ± 11%     -59.9%   79648044 ±  4%  perf-stat.i.cache-references
      6507            -9.2%       5908        perf-stat.i.context-switches
     10.61            +7.6%      11.42        perf-stat.i.cpi
    179.55            +2.4%     183.92        perf-stat.i.cpu-migrations
      5078 ± 12%    +205.3%      15502 ±  8%  perf-stat.i.cycles-between-cache-misses
      0.01 ±  9%      -0.0        0.01 ±  9%  perf-stat.i.dTLB-load-miss-rate%
   1192992 ±  8%     -30.7%     826996 ± 11%  perf-stat.i.dTLB-load-misses
 1.433e+10            -8.5%  1.311e+10        perf-stat.i.dTLB-loads
      0.01 ± 15%      -0.0        0.01 ± 13%  perf-stat.i.dTLB-store-miss-rate%
    193873 ± 17%     -68.1%      61893 ± 14%  perf-stat.i.dTLB-store-misses
 2.235e+09 ±  2%     -45.7%  1.214e+09        perf-stat.i.dTLB-stores
     96.86            -1.5       95.39        perf-stat.i.iTLB-load-miss-rate%
  12685070 ±  3%     -42.6%    7279196 ±  6%  perf-stat.i.iTLB-load-misses
 5.538e+10            -7.1%  5.147e+10        perf-stat.i.instructions
      4366 ±  3%     +62.5%       7096 ±  6%  perf-stat.i.instructions-per-iTLB-miss
      0.10            -7.0%       0.09        perf-stat.i.ipc
      3447            -7.2%       3200        perf-stat.i.minor-faults
     90.08            +5.8       95.90        perf-stat.i.node-load-miss-rate%
  23742009 ± 19%     -52.4%   11310057 ±  6%  perf-stat.i.node-load-misses
   2570289 ±  8%     -81.0%     488912 ± 14%  perf-stat.i.node-loads
     84.87           +12.6       97.43        perf-stat.i.node-store-miss-rate%
  13179764 ± 14%     -41.7%    7685392        perf-stat.i.node-store-misses
   2338995 ± 12%     -91.5%     199320 ±  2%  perf-stat.i.node-stores
      3447            -7.2%       3200        perf-stat.i.page-faults
      3.60 ± 11%     -56.9%       1.55 ±  4%  perf-stat.overall.MPKI
      0.21 ±  2%      -0.1        0.16        perf-stat.overall.branch-miss-rate%
     59.17 ±  2%     -11.2       47.97 ±  3%  perf-stat.overall.cache-miss-rate%
     10.64            +7.6%      11.45        perf-stat.overall.cpi
      5081 ± 12%    +204.5%      15472 ±  8%  perf-stat.overall.cycles-between-cache-misses
      0.01            -0.0        0.01 ±  9%  perf-stat.overall.dTLB-load-miss-rate%
      0.01 ± 15%      -0.0        0.01 ± 14%  perf-stat.overall.dTLB-store-miss-rate%
     96.94            -1.6       95.37        perf-stat.overall.iTLB-load-miss-rate%
      4370 ±  3%     +62.5%       7102 ±  6%  perf-stat.overall.instructions-per-iTLB-miss
      0.09            -7.1%       0.09        perf-stat.overall.ipc
     90.02            +5.7       95.69        perf-stat.overall.node-load-miss-rate%
     84.67           +12.4       97.08        perf-stat.overall.node-store-miss-rate%
  22397338 ±  2%    +157.6%   57692609        perf-stat.overall.path-length
 1.319e+10            -5.3%  1.249e+10        perf-stat.ps.branch-instructions
  27965482 ±  2%     -29.8%   19645718        perf-stat.ps.branch-misses
 1.177e+08 ± 14%     -67.6%   38192878 ±  7%  perf-stat.ps.cache-misses
 1.983e+08 ± 11%     -59.9%   79500330 ±  4%  perf-stat.ps.cache-references
      6434            -9.3%       5834        perf-stat.ps.context-switches
    176.59            +1.2%     178.78        perf-stat.ps.cpu-migrations
   1366971           -36.1%     873829 ±  9%  perf-stat.ps.dTLB-load-misses
 1.428e+10            -8.5%  1.306e+10        perf-stat.ps.dTLB-loads
    195631 ± 17%     -68.2%      62278 ± 14%  perf-stat.ps.dTLB-store-misses
 2.227e+09 ±  2%     -45.7%   1.21e+09        perf-stat.ps.dTLB-stores
  12641760 ±  3%     -42.6%    7251918 ±  6%  perf-stat.ps.iTLB-load-misses
 5.519e+10            -7.1%  5.129e+10        perf-stat.ps.instructions
      3430            -7.9%       3157        perf-stat.ps.minor-faults
  23662732 ± 19%     -52.4%   11273183 ±  6%  perf-stat.ps.node-load-misses
   2579624 ±  8%     -80.2%     510725 ± 13%  perf-stat.ps.node-loads
  13135476 ± 14%     -41.7%    7661143        perf-stat.ps.node-store-misses
   2371277 ± 11%     -90.3%     230773 ±  2%  perf-stat.ps.node-stores
      3430            -7.9%       3157        perf-stat.ps.page-faults
 1.668e+13            -7.0%  1.551e+13        perf-stat.total.instructions
     48.59           -48.6        0.00        perf-profile.calltrace.cycles-pp.shmem_mknod.path_openat.do_filp_open.do_sys_openat2.do_sys_open
     48.42           -48.4        0.00        perf-profile.calltrace.cycles-pp.shmem_get_inode.shmem_mknod.path_openat.do_filp_open.do_sys_openat2
     48.31           -48.3        0.00        perf-profile.calltrace.cycles-pp.evict.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
     46.83 ±  3%     -46.8        0.00        perf-profile.calltrace.cycles-pp.new_inode.shmem_get_inode.shmem_mknod.path_openat.do_filp_open
     46.57 ±  4%     -46.6        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.evict.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     46.49 ±  4%     -46.5        0.00        perf-profile.calltrace.cycles-pp.inode_sb_list_add.new_inode.shmem_get_inode.shmem_mknod.path_openat
     46.39 ±  4%     -46.4        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.inode_sb_list_add.new_inode.shmem_get_inode.shmem_mknod
     46.38 ±  4%     -46.4        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.evict.do_unlinkat.do_syscall_64
     46.24 ±  4%     -46.2        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.inode_sb_list_add.new_inode.shmem_get_inode
     50.08            -0.2       49.86        perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     50.08            -0.2       49.86        perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     50.13            -0.2       49.95        perf-profile.calltrace.cycles-pp.open64
     50.10            -0.2       49.94        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
     49.95            -0.2       49.79        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
     49.94            -0.2       49.78        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
     49.48            +0.2       49.70        perf-profile.calltrace.cycles-pp.unlink
     49.45            +0.2       49.68        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
     49.45            +0.2       49.69        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlink
     49.39            +0.3       49.65        perf-profile.calltrace.cycles-pp.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.00           +12.1       12.14        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk.path_openat
      0.00           +12.1       12.14        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk.path_parentat
      0.00           +12.2       12.18        perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.terminate_walk.path_openat.do_filp_open
      0.00           +12.2       12.19        perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.terminate_walk.path_parentat.filename_parentat
      0.00           +12.2       12.21        perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_parentat.filename_parentat.do_unlinkat
      0.00           +12.2       12.22        perf-profile.calltrace.cycles-pp.terminate_walk.path_parentat.filename_parentat.do_unlinkat.do_syscall_64
      0.00           +12.2       12.22        perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_openat2
      0.00           +12.2       12.22        perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00           +12.2       12.24        perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get.nd_jump_root.path_init.path_parentat
      0.00           +12.2       12.25        perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get.nd_jump_root.path_init.path_openat
      0.00           +12.3       12.28        perf-profile.calltrace.cycles-pp.lockref_get.nd_jump_root.path_init.path_parentat.filename_parentat
      0.00           +12.3       12.28        perf-profile.calltrace.cycles-pp.lockref_get.nd_jump_root.path_init.path_openat.do_filp_open
      0.00           +12.3       12.29        perf-profile.calltrace.cycles-pp.dput.step_into.walk_component.link_path_walk.path_parentat
      0.00           +12.3       12.29        perf-profile.calltrace.cycles-pp.lockref_get.set_root.nd_jump_root.path_init.path_openat
      0.00           +12.3       12.30        perf-profile.calltrace.cycles-pp.set_root.nd_jump_root.path_init.path_openat.do_filp_open
      0.00           +12.3       12.30        perf-profile.calltrace.cycles-pp.lockref_get.set_root.nd_jump_root.path_init.path_parentat
      0.00           +12.3       12.30        perf-profile.calltrace.cycles-pp.set_root.nd_jump_root.path_init.path_parentat.filename_parentat
      0.00           +12.3       12.31        perf-profile.calltrace.cycles-pp.dput.step_into.walk_component.link_path_walk.path_openat
      0.00           +12.4       12.35        perf-profile.calltrace.cycles-pp.step_into.walk_component.link_path_walk.path_parentat.filename_parentat
      0.00           +12.4       12.37        perf-profile.calltrace.cycles-pp.step_into.walk_component.link_path_walk.path_openat.do_filp_open
      0.00           +12.4       12.39        perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_parentat.filename_parentat.do_unlinkat
      0.00           +12.4       12.41        perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.00           +12.5       12.48        perf-profile.calltrace.cycles-pp.link_path_walk.path_parentat.filename_parentat.do_unlinkat.do_syscall_64
      0.00           +12.5       12.49        perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00           +24.4       24.41        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.step_into.walk_component
      0.00           +24.4       24.43        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get.nd_jump_root.path_init
      0.00           +24.5       24.45        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get.set_root.nd_jump_root
      0.00           +24.5       24.48        perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.step_into.walk_component.link_path_walk
      0.00           +24.5       24.53        perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get.set_root.nd_jump_root.path_init
      0.00           +24.6       24.58        perf-profile.calltrace.cycles-pp.nd_jump_root.path_init.path_openat.do_filp_open.do_sys_openat2
      0.00           +24.6       24.58        perf-profile.calltrace.cycles-pp.path_init.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00           +24.6       24.58        perf-profile.calltrace.cycles-pp.nd_jump_root.path_init.path_parentat.filename_parentat.do_unlinkat
      0.00           +24.6       24.58        perf-profile.calltrace.cycles-pp.path_init.path_parentat.filename_parentat.do_unlinkat.do_syscall_64
      0.00           +49.3       49.28        perf-profile.calltrace.cycles-pp.path_parentat.filename_parentat.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +49.3       49.29        perf-profile.calltrace.cycles-pp.filename_parentat.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
     48.59           -48.4        0.17 ±  2%  perf-profile.children.cycles-pp.shmem_mknod
     48.42           -48.3        0.14 ±  3%  perf-profile.children.cycles-pp.shmem_get_inode
     48.31           -48.2        0.11 ±  4%  perf-profile.children.cycles-pp.evict
     46.83 ±  3%     -46.8        0.07        perf-profile.children.cycles-pp.new_inode
     46.49 ±  4%     -46.5        0.00        perf-profile.children.cycles-pp.inode_sb_list_add
      1.53 ±105%      -1.5        0.06 ±  7%  perf-profile.children.cycles-pp.shmem_evict_inode
      0.33 ± 24%      -0.3        0.04 ± 57%  perf-profile.children.cycles-pp.new_inode_pseudo
      0.32 ± 23%      -0.3        0.06 ±  7%  perf-profile.children.cycles-pp.do_dentry_open
      0.31 ± 24%      -0.2        0.08 ±  6%  perf-profile.children.cycles-pp.vfs_unlink
      0.29 ± 30%      -0.2        0.08 ±  5%  perf-profile.children.cycles-pp.mnt_want_write
      0.27 ± 11%      -0.2        0.07 ±  5%  perf-profile.children.cycles-pp.close
     50.13            -0.2       49.95        perf-profile.children.cycles-pp.open64
      0.15 ± 14%      -0.1        0.04 ± 57%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.40 ±  2%      -0.1        0.30 ±  6%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.38            -0.1        0.27 ±  7%  perf-profile.children.cycles-pp.rcu_core
      0.19 ±  7%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.alloc_empty_file
      0.18 ±  9%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.__alloc_file
      0.21 ± 12%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.exit_to_usermode_loop
      0.21 ± 13%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.task_work_run
      0.15 ±  7%      -0.1        0.06        perf-profile.children.cycles-pp.d_alloc_parallel
      0.15 ± 19%      -0.1        0.07 ±  6%  perf-profile.children.cycles-pp.__fput
      0.12 ± 29%      -0.1        0.04 ± 58%  perf-profile.children.cycles-pp.__sb_start_write
      0.12 ± 11%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.security_file_alloc
      0.30            -0.0        0.27 ±  8%  perf-profile.children.cycles-pp.irq_exit
      0.07 ±  7%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.filename_lookup
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.path_lookupat
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.setlocale
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.__d_lookup
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.lookup_fast
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.generic_permission
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.__traverse_mounts
     99.81            +0.1       99.92        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     99.80            +0.1       99.92        perf-profile.children.cycles-pp.do_syscall_64
      0.00            +0.2        0.17 ±  4%  perf-profile.children.cycles-pp.lockref_put_return
     49.49            +0.2       49.70        perf-profile.children.cycles-pp.unlink
     49.39            +0.3       49.65        perf-profile.children.cycles-pp.do_unlinkat
     95.76            +2.5       98.25        perf-profile.children.cycles-pp._raw_spin_lock
     95.22            +2.8       98.03        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.00           +24.5       24.49        perf-profile.children.cycles-pp.terminate_walk
      0.00           +24.6       24.64        perf-profile.children.cycles-pp.set_root
      0.00           +24.8       24.78        perf-profile.children.cycles-pp.step_into
      0.06 ±  6%     +24.8       24.86        perf-profile.children.cycles-pp.walk_component
      0.12 ±  4%     +24.9       25.03        perf-profile.children.cycles-pp.link_path_walk
      0.10 ±  4%     +49.1       49.20        perf-profile.children.cycles-pp.dput
      0.10 ±  7%     +49.2       49.29        perf-profile.children.cycles-pp.filename_parentat
      0.10 ±  5%     +49.2       49.29        perf-profile.children.cycles-pp.path_parentat
      0.00           +49.2       49.24        perf-profile.children.cycles-pp.nd_jump_root
      0.00           +49.3       49.26        perf-profile.children.cycles-pp.path_init
      0.00           +49.3       49.30        perf-profile.children.cycles-pp.lockref_get
      0.54 ±  9%      -0.3        0.23        perf-profile.self.cycles-pp._raw_spin_lock
      0.06            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.generic_permission
      0.00            +0.1        0.06 ± 16%  perf-profile.self.cycles-pp.link_path_walk
      0.00            +0.2        0.16 ±  5%  perf-profile.self.cycles-pp.lockref_put_return
      0.00            +0.2        0.18 ±  3%  perf-profile.self.cycles-pp.lockref_get
     94.53            +2.8       97.34        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



***************************************************************************************************
lkp-knm01: 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
  gcc-7/performance/x86_64-rhel-7.6/process/100%/debian-x86_64-20191114.cgz/lkp-knm01/open2/will-it-scale/0x11

commit: 
  7ef482fa65 ("helper for mount rootwards traversal")
  2aa3847085 ("non-RCU analogue of the previous commit")

7ef482fa65513b18 2aa38470853a65dc9b1b4bd0989 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          3:4          -75%            :4     dmesg.WARNING:at#for_ip_swapgs_restore_regs_and_return_to_usermode/0x
          3:4          -75%            :4     dmesg.WARNING:at_ip__slab_free/0x
          1:4          -25%            :4     dmesg.WARNING:at_ip_do_filp_open/0x
         %stddev     %change         %stddev
             \          |                \  
      8861           -92.6%     652.50        will-it-scale.per_process_ops
    318.71            -2.7%     310.01        will-it-scale.time.elapsed_time
    318.71            -2.7%     310.01        will-it-scale.time.elapsed_time.max
    956.25 ±  8%     -11.9%     842.00 ±  4%  will-it-scale.time.involuntary_context_switches
      4.25 ± 10%     -52.9%       2.00        will-it-scale.time.percent_of_cpu_this_job_got
     11.45           -66.4%       3.85 ± 11%  will-it-scale.time.system_time
   2552144           -92.6%     188059        will-it-scale.workload
 1.318e+09 ±  2%     -14.8%  1.124e+09        cpuidle.C1.time
   2792902           -16.2%    2341375 ±  3%  cpuidle.C1.usage
    626843 ± 35%     -43.6%     353493        meminfo.SUnreclaim
    746726 ± 29%     -36.9%     471126        meminfo.Slab
    614096 ± 36%     -44.9%     338188        numa-meminfo.node0.SUnreclaim
    716247 ± 31%     -38.8%     438268        numa-meminfo.node0.Slab
   6462466 ± 22%     -86.7%     858173        numa-numastat.node0.local_node
   6462461 ± 22%     -86.7%     858156        numa-numastat.node0.numa_hit
     94.00            +3.2%      97.00        vmstat.cpu.sy
    581410            +1.3%     588903        vmstat.system.in
      1.47 ±  2%      -0.3        1.21 ±  4%  mpstat.cpu.all.idle%
      1.64 ±  4%      -1.6        0.00 ± 22%  mpstat.cpu.all.soft%
      3.35 ±  7%      -2.8        0.57        mpstat.cpu.all.usr%
    153927 ± 36%     -45.1%      84544        numa-vmstat.node0.nr_slab_unreclaimable
   4756359 ± 11%     -56.7%    2059955        numa-vmstat.node0.numa_hit
   4756414 ± 11%     -56.7%    2059961        numa-vmstat.node0.numa_local
     10354 ± 77%     -45.9%       5600        proc-vmstat.nr_inactive_anon
     33178 ± 56%     -35.1%      21534 ±  2%  proc-vmstat.nr_mapped
     29963            -1.9%      29407        proc-vmstat.nr_slab_reclaimable
    156519 ± 35%     -43.5%      88388        proc-vmstat.nr_slab_unreclaimable
     10354 ± 77%     -45.9%       5600        proc-vmstat.nr_zone_inactive_anon
   6476388 ± 22%     -86.5%     876797        proc-vmstat.numa_hit
   6476388 ± 22%     -86.5%     876797        proc-vmstat.numa_local
    137932 ± 14%     -34.7%      90056 ± 37%  proc-vmstat.numa_pte_updates
  23213646 ± 25%     -95.7%     996214        proc-vmstat.pgalloc_normal
    871214           -11.3%     773084        proc-vmstat.pgfault
  23153887 ± 24%     -95.0%    1166543        proc-vmstat.pgfree
      9094 ±  3%      +9.1%       9926 ±  3%  slabinfo.eventpoll_pwq.active_objs
      9094 ±  3%      +9.1%       9926 ±  3%  slabinfo.eventpoll_pwq.num_objs
   1262069 ± 71%     -83.1%     213021 ±  8%  slabinfo.filp.active_objs
     20486 ± 69%     -83.7%       3333 ±  8%  slabinfo.filp.active_slabs
   1311183 ± 69%     -83.7%     213365 ±  8%  slabinfo.filp.num_objs
     20486 ± 69%     -83.7%       3333 ±  8%  slabinfo.filp.num_slabs
      7354 ±  2%     +14.4%       8411 ±  4%  slabinfo.khugepaged_mm_slot.active_objs
      7354 ±  2%     +14.4%       8411 ±  4%  slabinfo.khugepaged_mm_slot.num_objs
      6681 ±  3%     -11.1%       5940 ±  7%  slabinfo.kmalloc-rcl-64.active_objs
      6681 ±  3%     -11.1%       5940 ±  7%  slabinfo.kmalloc-rcl-64.num_objs
    857.75 ±  3%     -14.9%     730.00 ±  7%  slabinfo.kmem_cache.active_objs
    857.75 ±  3%     -14.9%     730.00 ±  7%  slabinfo.kmem_cache.num_objs
    891.00 ±  3%     -12.6%     779.00 ±  5%  slabinfo.kmem_cache_node.active_objs
    944.00 ±  2%     -11.9%     832.00 ±  5%  slabinfo.kmem_cache_node.num_objs
      1000 ±  3%     -12.6%     874.50 ±  8%  slabinfo.skbuff_fclone_cache.active_objs
      1000 ±  3%     -12.6%     874.50 ±  8%  slabinfo.skbuff_fclone_cache.num_objs
 2.491e+09 ± 57%    +243.9%  8.564e+09        perf-stat.i.branch-instructions
      5.97 ± 57%     +15.5       21.50        perf-stat.i.cache-miss-rate%
 3.278e+11 ± 57%     +34.9%  4.421e+11        perf-stat.i.cpu-cycles
      4321 ± 57%     +93.1%       8342 ±  2%  perf-stat.i.cycles-between-cache-misses
 1.272e+10 ± 57%    +176.1%  3.512e+10        perf-stat.i.iTLB-loads
 1.269e+10 ± 57%    +176.3%  3.508e+10        perf-stat.i.instructions
     34.14 ± 57%   +1351.0%     495.45        perf-stat.i.instructions-per-iTLB-miss
      0.03 ± 57%    +168.1%       0.08        perf-stat.i.ipc
      5.95 ± 57%     +15.6       21.55        perf-stat.overall.cache-miss-rate%
      4331 ± 57%     +93.3%       8373 ±  2%  perf-stat.overall.cycles-between-cache-misses
     34.10 ± 57%   +1353.8%     495.72        perf-stat.overall.instructions-per-iTLB-miss
      0.03 ± 57%    +172.9%       0.08        perf-stat.overall.ipc
   1582568 ± 57%   +3540.5%   57612923        perf-stat.overall.path-length
 2.499e+09 ± 57%    +242.2%   8.55e+09        perf-stat.ps.branch-instructions
 1.273e+10 ± 57%    +175.3%  3.503e+10        perf-stat.ps.iTLB-loads
 1.271e+10 ± 57%    +175.4%  3.501e+10        perf-stat.ps.instructions
 4.052e+12 ± 57%    +167.4%  1.083e+13        perf-stat.total.instructions
    951695 ± 34%     -81.5%     176179 ± 43%  sched_debug.cfs_rq:/.MIN_vruntime.avg
   6370430 ± 22%     -63.0%    2358751 ± 33%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
    155445           -20.0%     124294        sched_debug.cfs_rq:/.exec_clock.avg
    159327           -20.8%     126240        sched_debug.cfs_rq:/.exec_clock.max
      3033 ± 32%     -46.1%       1635 ±  2%  sched_debug.cfs_rq:/.exec_clock.stddev
     25225 ± 15%     -73.1%       6776 ± 28%  sched_debug.cfs_rq:/.load.avg
    137273 ±  8%     -64.2%      49184 ± 40%  sched_debug.cfs_rq:/.load.stddev
     28.50 ± 51%     -81.0%       5.42 ±  5%  sched_debug.cfs_rq:/.load_avg.avg
    463.83 ± 40%     -55.1%     208.45 ± 46%  sched_debug.cfs_rq:/.load_avg.max
     49.12 ± 55%     -69.7%      14.89 ± 36%  sched_debug.cfs_rq:/.load_avg.stddev
    951695 ± 34%     -81.5%     176179 ± 43%  sched_debug.cfs_rq:/.max_vruntime.avg
   6370430 ± 22%     -63.0%    2358751 ± 33%  sched_debug.cfs_rq:/.max_vruntime.stddev
  51272980           -18.1%   42013582        sched_debug.cfs_rq:/.min_vruntime.avg
  52302369           -18.0%   42867767        sched_debug.cfs_rq:/.min_vruntime.max
      0.58 ± 14%     +37.1%       0.80        sched_debug.cfs_rq:/.nr_running.min
      0.21 ±  7%     -65.7%       0.07 ± 27%  sched_debug.cfs_rq:/.nr_running.stddev
      6.89 ± 27%     +64.8%      11.35 ±  8%  sched_debug.cfs_rq:/.nr_spread_over.stddev
      6.11 ± 56%     -46.4%       3.27 ± 11%  sched_debug.cfs_rq:/.runnable_load_avg.avg
    411.42 ± 48%     -60.5%     162.50 ± 66%  sched_debug.cfs_rq:/.runnable_load_avg.max
      1.54 ± 17%     +52.4%       2.35 ±  3%  sched_debug.cfs_rq:/.runnable_load_avg.min
     32.33 ± 65%     -66.9%      10.69 ± 57%  sched_debug.cfs_rq:/.runnable_load_avg.stddev
     25218 ± 15%     -73.2%       6770 ± 28%  sched_debug.cfs_rq:/.runnable_weight.avg
    137270 ±  8%     -64.2%      49187 ± 40%  sched_debug.cfs_rq:/.runnable_weight.stddev
    637237 ± 37%     -83.9%     102420 ±280%  sched_debug.cfs_rq:/.spread0.avg
   1478281 ± 24%     -61.2%     573799 ± 51%  sched_debug.cfs_rq:/.spread0.max
 -15139634           -43.2%   -8600864        sched_debug.cfs_rq:/.spread0.min
      1411 ±  6%     -11.9%       1243 ±  4%  sched_debug.cfs_rq:/.util_avg.max
    136.67 ±  3%     -59.3%      55.63 ±  8%  sched_debug.cfs_rq:/.util_avg.stddev
    291.23 ±  2%     +26.5%     368.38 ±  3%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    182.53           -31.6%     124.81 ± 23%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    212719           -15.0%     180872        sched_debug.cpu.clock.avg
    214258           -14.8%     182547        sched_debug.cpu.clock.max
    211047           -15.1%     179176        sched_debug.cpu.clock.min
    212719           -15.0%     180872        sched_debug.cpu.clock_task.avg
    214258           -14.8%     182547        sched_debug.cpu.clock_task.max
    211047           -15.1%     179176        sched_debug.cpu.clock_task.min
     97.42 ± 21%   +2062.2%       2106 ± 13%  sched_debug.cpu.curr->pid.min
    799.06 ±  3%     -59.0%     327.64 ±  6%  sched_debug.cpu.curr->pid.stddev
   1157268 ±  4%     -30.8%     801255 ± 14%  sched_debug.cpu.max_idle_balance_cost.avg
   4671189 ± 22%     -49.5%    2357890 ± 10%  sched_debug.cpu.max_idle_balance_cost.max
    637133 ± 20%     -66.5%     213240 ± 13%  sched_debug.cpu.max_idle_balance_cost.stddev
      2.21 ±  9%     -14.0%       1.90 ±  9%  sched_debug.cpu.nr_running.max
      0.62 ± 11%     +28.0%       0.80        sched_debug.cpu.nr_running.min
      0.24 ±  5%     -45.0%       0.13 ± 15%  sched_debug.cpu.nr_running.stddev
      7517 ±  6%     -23.7%       5735        sched_debug.cpu.nr_switches.avg
      4389 ± 10%     -43.5%       2482 ±  7%  sched_debug.cpu.nr_switches.min
      4770 ±  9%     -37.8%       2966        sched_debug.cpu.sched_count.avg
      3463 ± 19%     -41.0%       2041        sched_debug.cpu.sched_count.min
      1633 ± 12%     +20.5%       1968 ±  4%  sched_debug.cpu.sched_count.stddev
     74.59 ±  4%     -27.6%      53.99 ± 11%  sched_debug.cpu.sched_goidle.avg
      2272 ± 10%     -39.6%       1373        sched_debug.cpu.ttwu_count.avg
      1640 ± 21%     -41.0%     968.25        sched_debug.cpu.ttwu_count.min
      2208 ± 10%     -40.1%       1321        sched_debug.cpu.ttwu_local.avg
      1608 ± 22%     -40.7%     954.15 ±  2%  sched_debug.cpu.ttwu_local.min
    211031           -15.1%     179166        sched_debug.cpu_clk
    210362           -15.1%     178498        sched_debug.ktime
      2.03           -25.0%       1.52 ± 19%  sched_debug.rt_rq:/.rt_runtime.stddev
    211506           -15.1%     179641        sched_debug.sched_clk
     16.28 ± 60%     -16.3        0.00        perf-profile.calltrace.cycles-pp.close
     15.29 ± 60%     -15.3        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.close
     15.18 ± 60%     -15.2        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.close
     14.43 ± 57%     -14.4        0.00        perf-profile.calltrace.cycles-pp.do_dentry_open.path_openat.do_filp_open.do_sys_openat2.do_sys_open
     10.81 ± 60%     -10.8        0.00        perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.close
     10.19 ± 60%     -10.2        0.00        perf-profile.calltrace.cycles-pp.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.close
      9.76 ± 57%      -9.8        0.00        perf-profile.calltrace.cycles-pp.ima_file_check.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      9.32 ± 57%      -9.3        0.00        perf-profile.calltrace.cycles-pp.security_file_open.do_dentry_open.path_openat.do_filp_open.do_sys_openat2
      9.30 ± 57%      -9.3        0.00        perf-profile.calltrace.cycles-pp.security_task_getsecid.ima_file_check.path_openat.do_filp_open.do_sys_openat2
      9.19 ± 57%      -9.2        0.00        perf-profile.calltrace.cycles-pp.apparmor_task_getsecid.security_task_getsecid.ima_file_check.path_openat.do_filp_open
      8.86 ± 57%      -8.9        0.00        perf-profile.calltrace.cycles-pp.apparmor_file_open.security_file_open.do_dentry_open.path_openat.do_filp_open
      8.62 ± 57%      -8.6        0.00        perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      8.49 ± 57%      -8.5        0.00        perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.36 ± 57%      -8.4        0.00        perf-profile.calltrace.cycles-pp.__alloc_file.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
      5.19 ± 57%      -5.2        0.00        perf-profile.calltrace.cycles-pp.security_file_alloc.__alloc_file.alloc_empty_file.path_openat.do_filp_open
      4.54 ± 57%      -4.5        0.00        perf-profile.calltrace.cycles-pp.apparmor_file_alloc_security.security_file_alloc.__alloc_file.alloc_empty_file.path_openat
      4.52 ± 57%      -4.5        0.00        perf-profile.calltrace.cycles-pp.aa_get_task_label.apparmor_task_getsecid.security_task_getsecid.ima_file_check.path_openat
      3.80 ± 57%      -3.8        0.00        perf-profile.calltrace.cycles-pp.security_file_free.__fput.task_work_run.exit_to_usermode_loop.do_syscall_64
      3.69 ± 57%      -3.7        0.00        perf-profile.calltrace.cycles-pp.complete_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      3.34 ± 83%      -3.3        0.00        perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.15 ± 83%      -3.2        0.00        perf-profile.calltrace.cycles-pp.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.13 ±173%      +0.7        0.83 ± 25%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      0.14 ±173%      +0.7        0.87 ± 24%  perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      0.00            +1.3        1.25 ± 10%  perf-profile.calltrace.cycles-pp.apic_timer_interrupt.native_queued_spin_lock_slowpath._raw_spin_lock.dput.step_into
      0.00            +1.3        1.27 ± 11%  perf-profile.calltrace.cycles-pp.apic_timer_interrupt.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk
      0.00            +1.3        1.29 ± 10%  perf-profile.calltrace.cycles-pp.apic_timer_interrupt.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get.nd_jump_root
      0.00            +1.3        1.29 ± 11%  perf-profile.calltrace.cycles-pp.apic_timer_interrupt.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get.set_root
      0.00            +2.4        2.41 ± 10%  perf-profile.calltrace.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.native_queued_spin_lock_slowpath._raw_spin_lock.dput
      0.00            +2.5        2.47 ± 10%  perf-profile.calltrace.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get
      0.00            +2.8        2.79 ± 12%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt.native_queued_spin_lock_slowpath
      0.00            +3.8        3.85 ± 11%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt.native_queued_spin_lock_slowpath._raw_spin_lock
      2.83 ± 57%     +21.1       23.97        perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      2.44 ± 57%     +21.5       23.93        perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_openat2
      2.39 ± 57%     +22.1       24.44        perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      1.14 ± 59%     +23.1       24.23        perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.00           +23.7       23.68        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get.nd_jump_root.path_init
      0.00           +23.7       23.71        perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get.nd_jump_root.path_init.path_openat
      0.00           +23.7       23.73        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.step_into.walk_component
      0.00           +23.8       23.76        perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.step_into.walk_component.link_path_walk
      0.00           +23.8       23.78        perf-profile.calltrace.cycles-pp.lockref_get.nd_jump_root.path_init.path_openat.do_filp_open
      0.29 ±101%     +23.8       24.08        perf-profile.calltrace.cycles-pp.step_into.walk_component.link_path_walk.path_openat.do_filp_open
      0.00           +23.8       23.80        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk.path_openat
      0.00           +23.8       23.84        perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.terminate_walk.path_openat.do_filp_open
      0.00           +23.9       23.88        perf-profile.calltrace.cycles-pp.dput.step_into.walk_component.link_path_walk.path_openat
      0.00           +23.9       23.94        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get.set_root.nd_jump_root
      0.00           +24.0       23.97        perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get.set_root.nd_jump_root.path_init
      0.00           +24.0       24.04        perf-profile.calltrace.cycles-pp.lockref_get.set_root.nd_jump_root.path_init.path_openat
      0.00           +24.1       24.08        perf-profile.calltrace.cycles-pp.set_root.nd_jump_root.path_init.path_openat.do_filp_open
      0.14 ±173%     +47.8       47.92        perf-profile.calltrace.cycles-pp.path_init.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00           +47.9       47.88        perf-profile.calltrace.cycles-pp.nd_jump_root.path_init.path_openat.do_filp_open.do_sys_openat2
     40.09 ± 60%     +51.1       91.15 ±  8%  perf-profile.calltrace.cycles-pp.open64
     38.08 ± 60%     +51.8       89.91 ±  8%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     38.92 ± 60%     +51.9       90.85 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
     37.97 ± 60%     +51.9       89.90 ±  8%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     38.80 ± 60%     +52.0       90.84 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     43.81 ± 57%     +53.3       97.09        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
     43.57 ± 57%     +53.5       97.04        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      9.77 ± 57%      -9.8        0.00        perf-profile.children.cycles-pp.ima_file_check
      9.31 ± 57%      -9.3        0.00        perf-profile.children.cycles-pp.security_task_getsecid
      9.21 ± 57%      -9.2        0.00        perf-profile.children.cycles-pp.apparmor_task_getsecid
      8.89 ± 57%      -8.9        0.00        perf-profile.children.cycles-pp.apparmor_file_open
      4.64 ± 57%      -4.6        0.00        perf-profile.children.cycles-pp.aa_get_task_label
      3.77 ± 57%      -3.8        0.00        perf-profile.children.cycles-pp.complete_walk
      0.07 ± 58%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.x86_pmu_disable
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__do_sys_newstat
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.vfs_statx
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.__d_lookup
      0.00            +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.filename_lookup
      0.00            +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.path_lookupat
      0.00            +0.1        0.11 ±  7%  perf-profile.children.cycles-pp.setlocale
      0.00            +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.__traverse_mounts
      2.89 ± 57%     +21.2       24.05        perf-profile.children.cycles-pp.terminate_walk
      2.45 ± 57%     +22.1       24.54        perf-profile.children.cycles-pp.link_path_walk
      1.29 ± 57%     +23.0       24.33        perf-profile.children.cycles-pp.walk_component
      0.59 ± 57%     +23.6       24.20        perf-profile.children.cycles-pp.step_into
      0.15 ± 57%     +24.0       24.14        perf-profile.children.cycles-pp.set_root
     70.62 ± 57%     +28.8       99.43        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     70.33 ± 57%     +29.1       99.41        perf-profile.children.cycles-pp.do_syscall_64
      3.96 ± 57%     +44.1       48.07        perf-profile.children.cycles-pp.dput
      1.36 ± 57%     +46.6       48.00        perf-profile.children.cycles-pp.lockref_get
      0.45 ± 57%     +47.6       48.07        perf-profile.children.cycles-pp.path_init
      0.23 ± 57%     +47.8       48.03        perf-profile.children.cycles-pp.nd_jump_root
     49.30 ± 57%     +48.3       97.64        perf-profile.children.cycles-pp.do_sys_open
     49.17 ± 57%     +48.5       97.63        perf-profile.children.cycles-pp.do_sys_openat2
     40.19 ± 60%     +51.0       91.18 ±  8%  perf-profile.children.cycles-pp.open64
     43.83 ± 57%     +53.5       97.32        perf-profile.children.cycles-pp.do_filp_open
     43.60 ± 57%     +53.7       97.26        perf-profile.children.cycles-pp.path_openat
      4.98 ± 57%     +90.8       95.79        perf-profile.children.cycles-pp._raw_spin_lock
      1.04 ± 58%     +94.6       95.67        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      7.96 ± 57%      -8.0        0.00        perf-profile.self.cycles-pp.apparmor_file_open
      4.17 ± 57%      -4.2        0.00        perf-profile.self.cycles-pp.aa_get_task_label
      4.09 ± 57%      -4.1        0.00        perf-profile.self.cycles-pp.apparmor_task_getsecid
      4.08 ± 57%      -4.1        0.00        perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.07 ± 58%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.x86_pmu_disable
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.__d_lookup
      1.04 ± 58%     +88.9       89.96        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
     82.50 ± 44%     -81.5%      15.25 ± 30%  interrupts.CPU101.RES:Rescheduling_interrupts
    103.75 ± 49%     -81.0%      19.75 ± 34%  interrupts.CPU105.RES:Rescheduling_interrupts
      3872 ± 10%     +96.4%       7603        interrupts.CPU108.NMI:Non-maskable_interrupts
      3872 ± 10%     +96.4%       7603        interrupts.CPU108.PMI:Performance_monitoring_interrupts
    132.50 ± 12%    +120.0%     291.50 ± 34%  interrupts.CPU12.RES:Rescheduling_interrupts
    115.25 ± 59%     -89.4%      12.25 ± 39%  interrupts.CPU126.RES:Rescheduling_interrupts
     96.75 ± 17%    +142.9%     235.00 ± 20%  interrupts.CPU13.RES:Rescheduling_interrupts
    240.75 ±126%     -89.1%      26.25 ± 86%  interrupts.CPU130.RES:Rescheduling_interrupts
     76.50 ± 38%     -61.1%      29.75 ±105%  interrupts.CPU131.RES:Rescheduling_interrupts
    128.25 ± 47%     -62.6%      48.00 ±121%  interrupts.CPU135.RES:Rescheduling_interrupts
     84.75 ± 24%     -67.6%      27.50 ± 97%  interrupts.CPU137.RES:Rescheduling_interrupts
      3964 ± 11%     +45.0%       5748 ± 32%  interrupts.CPU142.NMI:Non-maskable_interrupts
      3964 ± 11%     +45.0%       5748 ± 32%  interrupts.CPU142.PMI:Performance_monitoring_interrupts
     72.50 ± 35%     -78.3%      15.75 ± 18%  interrupts.CPU142.RES:Rescheduling_interrupts
    310.75 ± 61%     -73.5%      82.50 ±129%  interrupts.CPU145.RES:Rescheduling_interrupts
     81.00 ± 34%     -81.8%      14.75 ± 22%  interrupts.CPU146.RES:Rescheduling_interrupts
    104.25 ± 51%     -84.4%      16.25 ± 27%  interrupts.CPU147.RES:Rescheduling_interrupts
    109.25 ± 78%     -84.0%      17.50 ± 61%  interrupts.CPU149.RES:Rescheduling_interrupts
     95.25 ± 34%     +48.8%     141.75 ±  7%  interrupts.CPU15.RES:Rescheduling_interrupts
      4008 ± 11%     +67.0%       6695 ± 23%  interrupts.CPU150.NMI:Non-maskable_interrupts
      4008 ± 11%     +67.0%       6695 ± 23%  interrupts.CPU150.PMI:Performance_monitoring_interrupts
     98.25 ± 43%     -80.7%      19.00 ± 33%  interrupts.CPU154.RES:Rescheduling_interrupts
     89.75 ± 39%     -80.5%      17.50 ± 35%  interrupts.CPU155.RES:Rescheduling_interrupts
    328.00 ±111%     -94.4%      18.50 ± 54%  interrupts.CPU158.RES:Rescheduling_interrupts
     71.75 ± 60%     -82.6%      12.50 ±  8%  interrupts.CPU162.RES:Rescheduling_interrupts
     82.00 ± 40%     -86.3%      11.25 ±  7%  interrupts.CPU163.RES:Rescheduling_interrupts
     91.00 ± 59%     -61.0%      35.50 ± 61%  interrupts.CPU173.RES:Rescheduling_interrupts
    119.25 ± 65%     -72.5%      32.75 ± 86%  interrupts.CPU174.RES:Rescheduling_interrupts
     79.25 ± 33%     -57.4%      33.75 ± 52%  interrupts.CPU176.RES:Rescheduling_interrupts
    139.25 ± 56%     -62.5%      52.25 ± 80%  interrupts.CPU186.RES:Rescheduling_interrupts
    120.25 ± 65%     -64.7%      42.50 ±133%  interrupts.CPU190.RES:Rescheduling_interrupts
    119.75 ± 28%     -72.0%      33.50 ± 57%  interrupts.CPU192.RES:Rescheduling_interrupts
    123.50 ± 50%     -87.7%      15.25 ± 31%  interrupts.CPU197.RES:Rescheduling_interrupts
    100.50 ± 56%     -80.3%      19.75 ± 83%  interrupts.CPU202.RES:Rescheduling_interrupts
     98.50 ± 39%     -82.5%      17.25 ± 29%  interrupts.CPU203.RES:Rescheduling_interrupts
     95.25 ± 43%     -81.1%      18.00 ± 65%  interrupts.CPU211.RES:Rescheduling_interrupts
    116.50 ± 18%     -89.9%      11.75 ± 16%  interrupts.CPU218.RES:Rescheduling_interrupts
     94.50 ± 69%     -85.2%      14.00 ± 17%  interrupts.CPU219.RES:Rescheduling_interrupts
     79.25 ± 43%     -63.4%      29.00 ± 41%  interrupts.CPU22.RES:Rescheduling_interrupts
      3976 ± 10%     +92.1%       7638        interrupts.CPU222.NMI:Non-maskable_interrupts
      3976 ± 10%     +92.1%       7638        interrupts.CPU222.PMI:Performance_monitoring_interrupts
     82.75 ± 37%     -63.7%      30.00 ± 74%  interrupts.CPU225.RES:Rescheduling_interrupts
     92.25 ± 72%     -77.8%      20.50 ± 36%  interrupts.CPU226.RES:Rescheduling_interrupts
     85.75 ± 12%     -80.8%      16.50 ± 51%  interrupts.CPU227.RES:Rescheduling_interrupts
      4021 ± 11%     +43.1%       5755 ± 32%  interrupts.CPU230.NMI:Non-maskable_interrupts
      4021 ± 11%     +43.1%       5755 ± 32%  interrupts.CPU230.PMI:Performance_monitoring_interrupts
    240.75 ± 68%     -91.2%      21.25 ± 49%  interrupts.CPU230.RES:Rescheduling_interrupts
    119.75 ± 68%     -74.1%      31.00 ± 87%  interrupts.CPU231.RES:Rescheduling_interrupts
     85.00 ± 62%     -85.9%      12.00 ± 13%  interrupts.CPU234.RES:Rescheduling_interrupts
     84.00 ± 47%     -84.5%      13.00 ± 28%  interrupts.CPU235.RES:Rescheduling_interrupts
      3909 ± 11%     +69.4%       6623 ± 24%  interrupts.CPU237.NMI:Non-maskable_interrupts
      3909 ± 11%     +69.4%       6623 ± 24%  interrupts.CPU237.PMI:Performance_monitoring_interrupts
     77.50 ± 27%     -56.1%      34.00 ± 36%  interrupts.CPU237.RES:Rescheduling_interrupts
     74.75 ± 40%     -46.8%      39.75 ± 78%  interrupts.CPU238.RES:Rescheduling_interrupts
     89.50 ± 27%     -62.8%      33.25 ± 85%  interrupts.CPU25.RES:Rescheduling_interrupts
     85.50 ± 34%     -68.7%      26.75 ± 80%  interrupts.CPU251.RES:Rescheduling_interrupts
    100.75 ± 41%     -74.2%      26.00 ± 24%  interrupts.CPU258.RES:Rescheduling_interrupts
    276.25 ±147%     -93.0%      19.25 ± 71%  interrupts.CPU270.RES:Rescheduling_interrupts
      6261 ± 39%     -24.6%       4721 ± 33%  interrupts.CPU271.NMI:Non-maskable_interrupts
      6261 ± 39%     -24.6%       4721 ± 33%  interrupts.CPU271.PMI:Performance_monitoring_interrupts
    116.75 ± 40%     -70.9%      34.00 ±105%  interrupts.CPU273.RES:Rescheduling_interrupts
      6535 ± 17%     -41.6%       3819        interrupts.CPU274.NMI:Non-maskable_interrupts
      6535 ± 17%     -41.6%       3819        interrupts.CPU274.PMI:Performance_monitoring_interrupts
     84.00 ± 32%     -80.7%      16.25 ± 32%  interrupts.CPU275.RES:Rescheduling_interrupts
    130.00 ± 63%     -85.2%      19.25 ± 38%  interrupts.CPU283.RES:Rescheduling_interrupts
    122.50 ± 57%     -68.2%      39.00 ± 86%  interrupts.CPU284.RES:Rescheduling_interrupts
     85.25 ± 32%     -74.5%      21.75 ± 45%  interrupts.CPU286.RES:Rescheduling_interrupts
      5776 ± 26%     -32.1%       3920        interrupts.CPU29.NMI:Non-maskable_interrupts
      5776 ± 26%     -32.1%       3920        interrupts.CPU29.PMI:Performance_monitoring_interrupts
     85.75 ± 36%     -67.9%      27.50 ± 44%  interrupts.CPU29.RES:Rescheduling_interrupts
      5093 ± 30%     -23.9%       3876        interrupts.CPU32.NMI:Non-maskable_interrupts
      5093 ± 30%     -23.9%       3876        interrupts.CPU32.PMI:Performance_monitoring_interrupts
     94.00 ± 14%     -43.6%      53.00 ± 59%  interrupts.CPU32.RES:Rescheduling_interrupts
    138.25 ± 47%     -70.3%      41.00 ± 56%  interrupts.CPU42.RES:Rescheduling_interrupts
     97.75 ± 56%     -74.2%      25.25 ± 73%  interrupts.CPU44.RES:Rescheduling_interrupts
      6681 ± 18%     -42.2%       3859        interrupts.CPU47.NMI:Non-maskable_interrupts
      6681 ± 18%     -42.2%       3859        interrupts.CPU47.PMI:Performance_monitoring_interrupts
    100.50 ± 24%     -44.5%      55.75 ± 58%  interrupts.CPU48.RES:Rescheduling_interrupts
     74.75 ± 42%     -64.5%      26.50 ± 54%  interrupts.CPU49.RES:Rescheduling_interrupts
      5712 ± 25%     -31.1%       3936        interrupts.CPU5.NMI:Non-maskable_interrupts
      5712 ± 25%     -31.1%       3936        interrupts.CPU5.PMI:Performance_monitoring_interrupts
      4026 ± 10%     +43.0%       5758 ± 32%  interrupts.CPU55.NMI:Non-maskable_interrupts
      4026 ± 10%     +43.0%       5758 ± 32%  interrupts.CPU55.PMI:Performance_monitoring_interrupts
      6709 ± 18%     -28.2%       4818 ± 33%  interrupts.CPU58.NMI:Non-maskable_interrupts
      6709 ± 18%     -28.2%       4818 ± 33%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
     99.00 ± 38%     -76.8%      23.00 ± 73%  interrupts.CPU58.RES:Rescheduling_interrupts
      6879 ± 31%     -44.2%       3837        interrupts.CPU59.NMI:Non-maskable_interrupts
      6879 ± 31%     -44.2%       3837        interrupts.CPU59.PMI:Performance_monitoring_interrupts
     92.25 ± 46%     -75.9%      22.25 ± 75%  interrupts.CPU59.RES:Rescheduling_interrupts
      4016 ±  9%     +43.2%       5750 ± 33%  interrupts.CPU63.NMI:Non-maskable_interrupts
      4016 ±  9%     +43.2%       5750 ± 33%  interrupts.CPU63.PMI:Performance_monitoring_interrupts
    126.75 ± 32%     -69.6%      38.50 ± 74%  interrupts.CPU65.RES:Rescheduling_interrupts
    157.25 ± 46%     -87.9%      19.00 ± 51%  interrupts.CPU67.RES:Rescheduling_interrupts
     95.25 ± 43%     -67.5%      31.00 ± 41%  interrupts.CPU70.RES:Rescheduling_interrupts
    118.00 ± 16%     -82.6%      20.50 ± 32%  interrupts.CPU73.RES:Rescheduling_interrupts
     82.25 ± 54%     -50.2%      41.00 ±112%  interrupts.CPU74.RES:Rescheduling_interrupts
     79.50 ± 70%     -81.8%      14.50 ± 31%  interrupts.CPU75.RES:Rescheduling_interrupts
      3946 ± 11%     +46.3%       5776 ± 33%  interrupts.CPU76.NMI:Non-maskable_interrupts
      3946 ± 11%     +46.3%       5776 ± 33%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
    208.75 ±120%     -87.8%      25.50 ± 92%  interrupts.CPU76.RES:Rescheduling_interrupts
      3985 ± 11%     +44.6%       5764 ± 33%  interrupts.CPU78.NMI:Non-maskable_interrupts
      3985 ± 11%     +44.6%       5764 ± 33%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
     83.75 ± 51%     -74.6%      21.25 ± 35%  interrupts.CPU82.RES:Rescheduling_interrupts
    300.00 ± 91%     -94.9%      15.25 ± 27%  interrupts.CPU86.RES:Rescheduling_interrupts
     99.25 ± 38%     -72.8%      27.00 ± 87%  interrupts.CPU87.RES:Rescheduling_interrupts
      3984 ± 12%     +67.8%       6684 ± 24%  interrupts.CPU88.NMI:Non-maskable_interrupts
      3984 ± 12%     +67.8%       6684 ± 24%  interrupts.CPU88.PMI:Performance_monitoring_interrupts
     71.00 ± 37%     -71.8%      20.00 ± 86%  interrupts.CPU91.RES:Rescheduling_interrupts
     87.50 ± 27%     -58.0%      36.75 ± 93%  interrupts.CPU97.RES:Rescheduling_interrupts
     33721 ±  8%     -35.3%      21822 ±  3%  interrupts.RES:Rescheduling_interrupts
      1816 ±  6%     -22.4%       1410 ± 19%  interrupts.TLB:TLB_shootdowns
    238247 ±  9%     -28.3%     170748        softirqs.CPU0.RCU
    236779 ±  9%     -33.4%     157755 ±  2%  softirqs.CPU1.RCU
    237988 ±  9%     -32.6%     160512 ±  2%  softirqs.CPU10.RCU
    112279 ±  7%     +10.8%     124353 ±  6%  softirqs.CPU10.TIMER
    231596 ±  8%     -30.3%     161406        softirqs.CPU100.RCU
    120868 ±  9%     +26.5%     152927 ±  5%  softirqs.CPU100.TIMER
    232353 ±  8%     -30.2%     162222 ±  2%  softirqs.CPU101.RCU
    121879 ±  8%     +25.2%     152625 ±  5%  softirqs.CPU101.TIMER
    222237 ± 11%     -26.3%     163834        softirqs.CPU102.RCU
    126679 ±  9%     +22.2%     154805 ±  4%  softirqs.CPU102.TIMER
    128553 ±  9%     +20.2%     154508 ±  4%  softirqs.CPU103.TIMER
    233682 ±  8%     -32.1%     158639 ±  4%  softirqs.CPU104.RCU
    116840 ± 10%     +30.1%     151985 ±  5%  softirqs.CPU104.TIMER
    228086 ±  9%     -29.5%     160694        softirqs.CPU105.RCU
    120313 ± 10%     +26.1%     151665 ±  7%  softirqs.CPU105.TIMER
    223464 ± 11%     -26.2%     164885        softirqs.CPU106.RCU
    120540 ± 16%     +25.4%     151126 ±  6%  softirqs.CPU106.TIMER
    216063 ±  9%     -23.9%     164523 ±  2%  softirqs.CPU107.RCU
    122211 ± 15%     +21.9%     148985 ±  8%  softirqs.CPU107.TIMER
    222332 ± 11%     -27.8%     160489        softirqs.CPU108.RCU
    121199 ±  9%     +26.4%     153206 ±  4%  softirqs.CPU108.TIMER
    214667 ±  9%     -25.3%     160370        softirqs.CPU109.RCU
    123537 ± 12%     +24.5%     153781 ±  4%  softirqs.CPU109.TIMER
    225317 ± 14%     -29.1%     159743 ±  2%  softirqs.CPU11.RCU
    214908 ±  8%     -23.1%     165224        softirqs.CPU110.RCU
    127111 ±  9%     +22.1%     155217 ±  3%  softirqs.CPU110.TIMER
    226176 ±  8%     -26.8%     165603 ±  2%  softirqs.CPU111.RCU
    124667 ± 11%     +23.9%     154415 ±  4%  softirqs.CPU111.TIMER
    223510 ± 11%     -27.9%     161136 ±  2%  softirqs.CPU112.RCU
    127464 ±  8%     +19.6%     152404 ±  6%  softirqs.CPU112.TIMER
    230449 ±  8%     -29.2%     163137        softirqs.CPU113.RCU
    131210 ±  7%     +17.8%     154586 ±  4%  softirqs.CPU113.TIMER
    220697 ± 13%     -26.7%     161833 ±  2%  softirqs.CPU114.RCU
    121537 ± 11%     +23.0%     149536 ±  6%  softirqs.CPU114.TIMER
    125017 ±  9%     +21.1%     151453 ±  4%  softirqs.CPU115.TIMER
    232249 ±  9%     -30.0%     162576 ±  2%  softirqs.CPU116.RCU
    118972 ±  9%     +28.2%     152488 ±  6%  softirqs.CPU116.TIMER
    233529 ±  9%     -30.7%     161816        softirqs.CPU117.RCU
    119285 ±  9%     +30.3%     155487 ±  4%  softirqs.CPU117.TIMER
    220618 ± 13%     -25.2%     164993        softirqs.CPU118.RCU
    120094 ± 14%     +25.0%     150164 ±  5%  softirqs.CPU118.TIMER
    233554 ±  8%     -30.2%     162990 ±  2%  softirqs.CPU119.RCU
    122200 ± 13%     +25.1%     152920 ±  4%  softirqs.CPU119.TIMER
    239214 ±  9%     -32.8%     160781        softirqs.CPU12.RCU
    220813 ± 14%     -25.9%     163539        softirqs.CPU120.RCU
    123275 ± 10%     +23.5%     152243 ±  5%  softirqs.CPU120.TIMER
    226511 ± 10%     -28.9%     161000        softirqs.CPU121.RCU
    126293 ±  9%     +20.5%     152219 ±  4%  softirqs.CPU121.TIMER
    234056 ±  8%     -30.3%     163105 ±  2%  softirqs.CPU122.RCU
    221757 ± 11%     -26.6%     162876 ±  3%  softirqs.CPU123.RCU
    129192 ±  8%     +21.3%     156690 ±  5%  softirqs.CPU123.TIMER
    222429 ± 11%     -26.5%     163398        softirqs.CPU124.RCU
    119777 ± 11%     +26.9%     151961 ±  6%  softirqs.CPU124.TIMER
    229392 ±  8%     -29.3%     162144 ±  2%  softirqs.CPU125.RCU
    122676 ± 12%     +24.7%     152937 ±  5%  softirqs.CPU125.TIMER
    231095 ±  8%     -29.0%     164170        softirqs.CPU126.RCU
    121713 ± 10%     +27.3%     154962 ±  4%  softirqs.CPU126.TIMER
    227399 ±  9%     -27.0%     166019 ±  2%  softirqs.CPU127.RCU
    124802 ± 10%     +25.2%     156240 ±  5%  softirqs.CPU127.TIMER
    230996 ±  8%     -29.4%     163111        softirqs.CPU128.RCU
    119030 ± 10%     +29.9%     154601 ±  4%  softirqs.CPU128.TIMER
    231174 ±  8%     -29.6%     162632        softirqs.CPU129.RCU
    120317 ±  9%     +25.3%     150741 ±  6%  softirqs.CPU129.TIMER
    237257 ±  9%     -31.2%     163124 ±  3%  softirqs.CPU13.RCU
    235056 ±  9%     -30.6%     163088 ±  3%  softirqs.CPU130.RCU
    119529 ± 12%     +27.4%     152246 ±  6%  softirqs.CPU130.TIMER
    232314 ±  8%     -29.5%     163868        softirqs.CPU131.RCU
    118990 ±  9%     +28.2%     152572 ±  5%  softirqs.CPU131.TIMER
    230175 ±  8%     -29.9%     161318        softirqs.CPU132.RCU
    130618 ± 10%     +18.2%     154445 ±  4%  softirqs.CPU132.TIMER
    231251 ±  9%     -29.0%     164074        softirqs.CPU133.RCU
    131251 ± 11%     +17.5%     154199 ±  5%  softirqs.CPU133.TIMER
    230547 ±  8%     -30.9%     159379 ±  2%  softirqs.CPU134.RCU
    131851 ± 11%     +16.2%     153178 ±  5%  softirqs.CPU134.TIMER
    215293 ±  9%     -24.1%     163468 ±  2%  softirqs.CPU135.RCU
    128062 ± 11%     +19.3%     152739 ±  5%  softirqs.CPU135.TIMER
    234142 ±  9%     -30.2%     163328 ±  2%  softirqs.CPU136.RCU
    122428 ± 10%     +21.5%     148756 ±  6%  softirqs.CPU136.TIMER
    225997 ± 11%     -28.2%     162277        softirqs.CPU137.RCU
    127729 ±  9%     +18.5%     151340 ±  6%  softirqs.CPU137.TIMER
    231204 ±  8%     -29.4%     163152 ±  4%  softirqs.CPU138.RCU
    129038 ±  6%     +20.1%     155006 ±  5%  softirqs.CPU138.TIMER
    231416 ±  8%     -29.9%     162239        softirqs.CPU139.RCU
    126543 ±  8%     +21.5%     153716 ±  4%  softirqs.CPU139.TIMER
    237277 ±  9%     -30.1%     165892 ±  2%  softirqs.CPU14.RCU
    227543 ± 10%     -28.8%     162049        softirqs.CPU140.RCU
    114733 ± 12%     +28.9%     147914 ±  8%  softirqs.CPU140.TIMER
    222258 ± 11%     -27.6%     161005        softirqs.CPU141.RCU
    118969 ± 10%     +28.3%     152584 ±  5%  softirqs.CPU141.TIMER
    226511 ±  9%     -27.7%     163781        softirqs.CPU142.RCU
    118568 ±  9%     +29.9%     153968 ±  5%  softirqs.CPU142.TIMER
    217183 ± 11%     -24.4%     164279 ±  3%  softirqs.CPU143.RCU
    126626 ± 12%     +23.8%     156721 ±  2%  softirqs.CPU143.TIMER
    234553 ±  7%     -29.9%     164444        softirqs.CPU144.RCU
    118075 ±  9%     +26.8%     149771 ±  5%  softirqs.CPU144.TIMER
    232957 ±  8%     -30.5%     161865        softirqs.CPU145.RCU
    114724 ± 11%     +26.6%     145296 ±  7%  softirqs.CPU145.TIMER
    233346 ±  8%     -30.8%     161512        softirqs.CPU146.RCU
    118169 ±  9%     +28.2%     151453 ±  6%  softirqs.CPU146.TIMER
    232722 ±  8%     -32.1%     157904        softirqs.CPU147.RCU
    117389 ± 11%     +29.3%     151820 ±  6%  softirqs.CPU147.TIMER
    218414 ± 13%     -27.7%     157826        softirqs.CPU148.RCU
    123300 ± 11%     +22.8%     151458 ±  6%  softirqs.CPU148.TIMER
    218995 ± 13%     -26.5%     160912 ±  2%  softirqs.CPU149.RCU
    126508 ±  9%     +19.6%     151263 ±  6%  softirqs.CPU149.TIMER
    238731 ±  9%     -33.4%     158898 ±  2%  softirqs.CPU15.RCU
    232750 ±  9%     -31.5%     159542 ±  2%  softirqs.CPU150.RCU
    123917 ±  7%     +23.4%     152941 ±  5%  softirqs.CPU150.TIMER
    220241 ± 13%     -26.2%     162644        softirqs.CPU151.RCU
    121599 ±  9%     +26.0%     153186 ±  4%  softirqs.CPU151.TIMER
    220534 ± 13%     -26.3%     162543        softirqs.CPU152.RCU
    121141 ±  9%     +25.7%     152276 ±  5%  softirqs.CPU152.TIMER
    233484 ±  9%     -30.1%     163269        softirqs.CPU153.RCU
    116878 ±  8%     +30.1%     152055 ±  5%  softirqs.CPU153.TIMER
    233802 ±  8%     -30.8%     161899        softirqs.CPU154.RCU
    121461 ± 11%     +26.4%     153518 ±  5%  softirqs.CPU154.TIMER
    232554 ±  8%     -29.6%     163751 ±  2%  softirqs.CPU155.RCU
    116846 ± 10%     +28.0%     149509 ±  7%  softirqs.CPU155.TIMER
    230502 ±  9%     -31.2%     158522 ±  2%  softirqs.CPU156.RCU
    123269 ±  8%     +23.3%     151956 ±  5%  softirqs.CPU156.TIMER
    221740 ± 13%     -29.1%     157256 ±  3%  softirqs.CPU157.RCU
    118511 ±  9%     +29.1%     153006 ±  4%  softirqs.CPU157.TIMER
    233134 ±  8%     -30.5%     162022 ±  2%  softirqs.CPU158.RCU
    122961 ±  9%     +25.2%     153951 ±  3%  softirqs.CPU158.TIMER
    232383 ±  8%     -30.1%     162378        softirqs.CPU159.RCU
    124465 ± 10%     +24.4%     154783 ±  4%  softirqs.CPU159.TIMER
    238380 ±  9%     -32.0%     162056 ±  2%  softirqs.CPU16.RCU
    115648 ± 10%     +13.2%     130898 ±  9%  softirqs.CPU16.TIMER
    233381 ±  8%     -30.2%     162981        softirqs.CPU160.RCU
    127851 ±  7%     +21.5%     155333 ±  4%  softirqs.CPU160.TIMER
    219828 ± 13%     -26.5%     161519 ±  2%  softirqs.CPU161.RCU
    126217 ±  7%     +22.0%     154048 ±  5%  softirqs.CPU161.TIMER
    221115 ± 14%     -28.2%     158677        softirqs.CPU162.RCU
    118811 ±  9%     +24.7%     148210 ±  6%  softirqs.CPU162.TIMER
    221265 ± 13%     -27.4%     160694        softirqs.CPU163.RCU
    118708 ±  7%     +24.4%     147621 ±  5%  softirqs.CPU163.TIMER
    232514 ±  8%     -29.9%     163106        softirqs.CPU164.RCU
    116233 ±  8%     +31.4%     152719 ±  5%  softirqs.CPU164.TIMER
    233375 ±  8%     -30.6%     162005 ±  2%  softirqs.CPU165.RCU
    128937 ± 10%     +22.3%     157738 ±  2%  softirqs.CPU165.TIMER
    232598 ±  8%     -30.7%     161112        softirqs.CPU166.RCU
    113485 ±  8%     +32.8%     150730 ±  5%  softirqs.CPU166.TIMER
    232721 ±  9%     -30.3%     162220 ±  2%  softirqs.CPU167.RCU
    120693 ±  9%     +26.8%     153080 ±  3%  softirqs.CPU167.TIMER
    225482 ± 10%     -27.4%     163603        softirqs.CPU168.RCU
    116467 ±  9%     +28.4%     149529 ±  6%  softirqs.CPU168.TIMER
    232383 ±  8%     -32.2%     157515 ±  3%  softirqs.CPU169.RCU
    118518 ± 10%     +26.8%     150226 ±  5%  softirqs.CPU169.TIMER
    237743 ±  9%     -32.2%     161187 ±  3%  softirqs.CPU17.RCU
    232245 ±  8%     -29.7%     163230        softirqs.CPU170.RCU
    117170 ± 12%     +26.2%     147821 ±  7%  softirqs.CPU170.TIMER
    232001 ±  9%     -28.3%     166312 ±  2%  softirqs.CPU171.RCU
    122480 ± 13%     +21.2%     148483 ±  7%  softirqs.CPU171.TIMER
    232728 ±  8%     -30.5%     161717        softirqs.CPU172.RCU
    119430 ±  9%     +27.3%     152089 ±  5%  softirqs.CPU172.TIMER
    219487 ± 13%     -28.0%     158089        softirqs.CPU173.RCU
    123092 ±  8%     +23.8%     152437 ±  5%  softirqs.CPU173.TIMER
    219378 ± 13%     -26.1%     162070        softirqs.CPU174.RCU
    119735 ± 11%     +23.8%     148192 ±  7%  softirqs.CPU174.TIMER
    233076 ±  9%     -30.0%     163141 ±  2%  softirqs.CPU175.RCU
    125939 ± 10%     +19.2%     150080 ±  5%  softirqs.CPU175.TIMER
    219886 ± 13%     -26.6%     161335        softirqs.CPU176.RCU
    126588 ±  9%     +21.1%     153283 ±  5%  softirqs.CPU176.TIMER
    232606 ±  8%     -30.8%     161060        softirqs.CPU177.RCU
    124602 ± 10%     +21.9%     151844 ±  5%  softirqs.CPU177.TIMER
    220746 ± 13%     -26.0%     163273        softirqs.CPU178.RCU
    221262 ± 13%     -27.1%     161283 ±  2%  softirqs.CPU179.RCU
    231984 ±  8%     -29.3%     164033 ±  2%  softirqs.CPU18.RCU
    231656 ±  8%     -28.9%     164693        softirqs.CPU180.RCU
    120447 ± 11%     +26.6%     152450 ±  4%  softirqs.CPU180.TIMER
    232522 ±  9%     -29.2%     164531        softirqs.CPU181.RCU
    118088 ±  8%     +28.4%     151620 ±  5%  softirqs.CPU181.TIMER
    228088 ±  8%     -28.8%     162306 ±  2%  softirqs.CPU182.RCU
    121717 ± 13%     +23.2%     150005 ±  6%  softirqs.CPU182.TIMER
    220970 ± 13%     -25.6%     164445 ±  2%  softirqs.CPU183.RCU
    116223 ± 11%     +29.1%     150047 ±  7%  softirqs.CPU183.TIMER
    232737 ±  8%     -30.5%     161802 ±  2%  softirqs.CPU184.RCU
    121488 ±  9%     +25.1%     151923 ±  6%  softirqs.CPU184.TIMER
    232545 ±  8%     -30.6%     161314        softirqs.CPU185.RCU
    124873 ±  6%     +22.1%     152513 ±  4%  softirqs.CPU185.TIMER
    233081 ±  8%     -31.6%     159530 ±  2%  softirqs.CPU186.RCU
    130132 ±  7%     +17.5%     152903 ±  4%  softirqs.CPU186.TIMER
    234022 ±  9%     -32.0%     159208        softirqs.CPU187.RCU
    128957 ± 10%     +18.4%     152662 ±  4%  softirqs.CPU187.TIMER
    227129 ± 11%     -28.4%     162671        softirqs.CPU188.RCU
    114603 ± 12%     +28.9%     147702 ±  7%  softirqs.CPU188.TIMER
    225980 ± 12%     -28.2%     162244        softirqs.CPU189.RCU
    113115 ±  9%     +32.1%     149476 ±  5%  softirqs.CPU189.TIMER
    224572 ± 13%     -29.2%     159025 ±  2%  softirqs.CPU19.RCU
    231420 ±  8%     -29.4%     163284        softirqs.CPU190.RCU
    131021 ± 12%     +19.4%     156451 ±  2%  softirqs.CPU190.TIMER
    232495 ±  8%     -30.0%     162664        softirqs.CPU191.RCU
    125606 ± 13%     +23.5%     155170 ±  3%  softirqs.CPU191.TIMER
    231371 ±  8%     -30.2%     161553        softirqs.CPU192.RCU
    121420 ± 12%     +25.4%     152280 ±  6%  softirqs.CPU192.TIMER
    230775 ±  8%     -30.1%     161204        softirqs.CPU193.RCU
    121083 ±  8%     +26.6%     153231 ±  3%  softirqs.CPU193.TIMER
    232674 ±  9%     -30.9%     160713        softirqs.CPU194.RCU
    116489 ±  9%     +29.7%     151043 ±  4%  softirqs.CPU194.TIMER
    232288 ±  9%     -31.4%     159375 ±  3%  softirqs.CPU195.RCU
    119157 ±  8%     +26.8%     151122 ±  5%  softirqs.CPU195.TIMER
    232090 ±  9%     -29.2%     164417        softirqs.CPU196.RCU
    124684 ± 10%     +21.5%     151553 ±  5%  softirqs.CPU196.TIMER
    231445 ±  8%     -31.2%     159309 ±  2%  softirqs.CPU197.RCU
    128612 ± 10%     +18.6%     152547 ±  4%  softirqs.CPU197.TIMER
    219132 ± 13%     -27.2%     159512 ±  3%  softirqs.CPU198.RCU
    124341 ± 10%     +23.8%     153990 ±  4%  softirqs.CPU198.TIMER
    220250 ± 14%     -27.9%     158857        softirqs.CPU199.RCU
    128330 ± 10%     +19.9%     153840 ±  4%  softirqs.CPU199.TIMER
    226284 ± 13%     -27.2%     164747        softirqs.CPU2.RCU
    224938 ± 14%     -28.2%     161613        softirqs.CPU20.RCU
    233506 ±  8%     -31.0%     161155        softirqs.CPU200.RCU
    220775 ± 14%     -27.6%     159791        softirqs.CPU201.RCU
    119780 ±  9%     +25.1%     149793 ±  6%  softirqs.CPU201.TIMER
    230724 ±  8%     -30.2%     161117        softirqs.CPU202.RCU
    127757 ±  9%     +20.4%     153772 ±  5%  softirqs.CPU202.TIMER
    232524 ±  8%     -29.1%     164753        softirqs.CPU203.RCU
    125483 ±  7%     +22.6%     153781 ±  6%  softirqs.CPU203.TIMER
    220525 ± 13%     -24.8%     165808 ±  2%  softirqs.CPU204.RCU
    120886 ± 14%     +23.4%     149157 ±  6%  softirqs.CPU204.TIMER
    233468 ±  9%     -30.4%     162495        softirqs.CPU205.RCU
    119620 ± 14%     +26.0%     150715 ±  6%  softirqs.CPU205.TIMER
    231570 ±  8%     -30.1%     161878        softirqs.CPU206.RCU
    122831 ± 14%     +23.8%     152119 ±  6%  softirqs.CPU206.TIMER
    230223 ±  8%     -29.5%     162411        softirqs.CPU207.RCU
    126455 ± 13%     +20.0%     151732 ±  7%  softirqs.CPU207.TIMER
    231102 ±  9%     -29.1%     163834 ±  2%  softirqs.CPU208.RCU
    120957 ± 12%     +25.0%     151206 ±  6%  softirqs.CPU208.TIMER
    231320 ±  9%     -28.9%     164509 ±  3%  softirqs.CPU209.RCU
    120596 ± 11%     +25.1%     150869 ±  5%  softirqs.CPU209.TIMER
    225609 ± 14%     -29.3%     159425        softirqs.CPU21.RCU
    231133 ±  9%     -29.8%     162326 ±  2%  softirqs.CPU210.RCU
    121428 ±  8%     +25.3%     152182 ±  5%  softirqs.CPU210.TIMER
    232351 ±  8%     -31.8%     158421        softirqs.CPU211.RCU
    118790 ±  8%     +27.2%     151146 ±  5%  softirqs.CPU211.TIMER
    230886 ±  8%     -30.4%     160645 ±  2%  softirqs.CPU212.RCU
    120107 ± 12%     +24.3%     149338 ±  7%  softirqs.CPU212.TIMER
    230380 ±  8%     -29.9%     161597        softirqs.CPU213.RCU
    123952 ± 10%     +22.3%     151584 ±  6%  softirqs.CPU213.TIMER
    231419 ±  8%     -31.7%     158138 ±  2%  softirqs.CPU214.RCU
    123472 ±  9%     +22.3%     150947 ±  6%  softirqs.CPU214.TIMER
    216922 ± 13%     -27.0%     158374 ±  2%  softirqs.CPU215.RCU
    124727 ±  9%     +23.0%     153367 ±  4%  softirqs.CPU215.TIMER
    232777 ±  9%     -30.2%     162453 ±  2%  softirqs.CPU216.RCU
    116068 ± 10%     +29.1%     149832 ±  6%  softirqs.CPU216.TIMER
    219862 ± 14%     -27.5%     159396        softirqs.CPU217.RCU
    113495 ± 11%     +31.2%     148945 ±  6%  softirqs.CPU217.TIMER
    232543 ±  8%     -30.8%     160995        softirqs.CPU218.RCU
    117549 ±  9%     +29.6%     152330 ±  5%  softirqs.CPU218.TIMER
    232773 ±  8%     -30.4%     161949 ±  2%  softirqs.CPU219.RCU
    115909 ±  9%     +31.0%     151786 ±  5%  softirqs.CPU219.TIMER
    237373 ±  9%     -33.4%     157992        softirqs.CPU22.RCU
    233616 ±  9%     -31.6%     159801        softirqs.CPU220.RCU
    124171 ± 11%     +23.9%     153863 ±  4%  softirqs.CPU220.TIMER
    233639 ±  8%     -31.7%     159633 ±  2%  softirqs.CPU221.RCU
    127915 ±  7%     +20.3%     153888 ±  5%  softirqs.CPU221.TIMER
    232725 ±  9%     -30.1%     162690 ±  2%  softirqs.CPU222.RCU
    121219 ± 10%     +25.6%     152262 ±  5%  softirqs.CPU222.TIMER
    230567 ±  8%     -29.7%     161975        softirqs.CPU223.RCU
    127255 ± 11%     +21.3%     154360 ±  4%  softirqs.CPU223.TIMER
    231703 ±  8%     -30.0%     162203        softirqs.CPU224.RCU
    127210 ±  8%     +21.3%     154308 ±  4%  softirqs.CPU224.TIMER
    233666 ±  9%     -30.8%     161598        softirqs.CPU225.RCU
    126866 ±  9%     +21.5%     154115 ±  5%  softirqs.CPU225.TIMER
    231634 ±  8%     -30.2%     161619        softirqs.CPU226.RCU
    124501 ± 10%     +24.1%     154547 ±  4%  softirqs.CPU226.TIMER
    233093 ±  9%     -29.9%     163454        softirqs.CPU227.RCU
    118654 ±  8%     +30.1%     154381 ±  4%  softirqs.CPU227.TIMER
    233136 ±  8%     -30.5%     162121        softirqs.CPU228.RCU
    119059 ± 11%     +29.5%     154226 ±  3%  softirqs.CPU228.TIMER
    232591 ±  8%     -29.1%     164849        softirqs.CPU229.RCU
    121312 ± 11%     +28.5%     155909 ±  3%  softirqs.CPU229.TIMER
    225868 ± 14%     -26.9%     165172 ±  3%  softirqs.CPU23.RCU
    222369 ± 13%     -26.8%     162722        softirqs.CPU230.RCU
    112041 ± 10%     +32.4%     148326 ±  6%  softirqs.CPU230.TIMER
    221659 ± 13%     -26.0%     164012        softirqs.CPU231.RCU
    114204 ±  9%     +30.9%     149541 ±  6%  softirqs.CPU231.TIMER
    232179 ±  8%     -30.5%     161433        softirqs.CPU232.RCU
    123325 ± 10%     +23.5%     152361 ±  5%  softirqs.CPU232.TIMER
    232809 ±  8%     -29.5%     164137 ±  2%  softirqs.CPU233.RCU
    122913 ±  8%     +24.5%     152975 ±  4%  softirqs.CPU233.TIMER
    233163 ±  9%     -32.9%     156445 ±  2%  softirqs.CPU234.RCU
    119203 ±  9%     +26.1%     150288 ±  4%  softirqs.CPU234.TIMER
    231920 ±  8%     -33.6%     153941 ±  2%  softirqs.CPU235.RCU
    123801 ±  9%     +21.5%     150357 ±  6%  softirqs.CPU235.TIMER
    233373 ±  8%     -30.3%     162632        softirqs.CPU236.RCU
    114914 ±  8%     +28.3%     147463 ±  7%  softirqs.CPU236.TIMER
    232240 ±  8%     -29.5%     163727 ±  2%  softirqs.CPU237.RCU
    116592 ± 10%     +25.4%     146194 ±  7%  softirqs.CPU237.TIMER
    233718 ±  8%     -32.2%     158552 ±  2%  softirqs.CPU238.RCU
    114323 ±  9%     +30.8%     149562 ±  4%  softirqs.CPU238.TIMER
    232327 ±  8%     -30.8%     160685 ±  2%  softirqs.CPU239.RCU
    115861 ±  8%     +29.6%     150203 ±  5%  softirqs.CPU239.TIMER
    224847 ± 14%     -25.3%     167932        softirqs.CPU24.RCU
    232648 ±  8%     -29.5%     163924        softirqs.CPU240.RCU
    117664 ± 10%     +26.5%     148805 ±  7%  softirqs.CPU240.TIMER
    234459 ±  9%     -30.7%     162573        softirqs.CPU241.RCU
    113032 ± 10%     +30.4%     147383 ±  7%  softirqs.CPU241.TIMER
    232509 ±  8%     -29.5%     163919        softirqs.CPU242.RCU
    123877 ± 13%     +23.3%     152744 ±  6%  softirqs.CPU242.TIMER
    233383 ±  8%     -29.4%     164870        softirqs.CPU243.RCU
    116918 ±  9%     +29.6%     151572 ±  6%  softirqs.CPU243.TIMER
    220662 ± 14%     -26.7%     161710        softirqs.CPU244.RCU
    121356 ± 10%     +23.7%     150154 ±  5%  softirqs.CPU244.TIMER
    221259 ± 14%     -27.4%     160741        softirqs.CPU245.RCU
    118554 ± 10%     +25.4%     148721 ±  9%  softirqs.CPU245.TIMER
    232106 ±  8%     -30.7%     160910        softirqs.CPU246.RCU
    126278 ± 10%     +20.5%     152161 ±  5%  softirqs.CPU246.TIMER
    232049 ±  8%     -30.6%     160978        softirqs.CPU247.RCU
    125709 ±  9%     +21.8%     153144 ±  4%  softirqs.CPU247.TIMER
    232020 ±  9%     -30.0%     162371        softirqs.CPU248.RCU
    124250 ± 11%     +24.4%     154577 ±  3%  softirqs.CPU248.TIMER
    233043 ±  9%     -29.9%     163480        softirqs.CPU249.RCU
    120195 ± 11%     +27.1%     152821 ±  4%  softirqs.CPU249.TIMER
    236943 ±  9%     -31.2%     163010        softirqs.CPU25.RCU
    231403 ±  8%     -29.8%     162383        softirqs.CPU250.RCU
    124859 ± 14%     +21.6%     151801 ±  5%  softirqs.CPU250.TIMER
    232754 ±  8%     -28.8%     165618 ±  2%  softirqs.CPU251.RCU
    119876 ± 15%     +25.6%     150535 ±  6%  softirqs.CPU251.TIMER
    232812 ±  8%     -30.4%     162008        softirqs.CPU252.RCU
    126204 ± 10%     +22.0%     154002 ±  4%  softirqs.CPU252.TIMER
    231210 ±  8%     -29.7%     162491        softirqs.CPU253.RCU
    123480 ±  8%     +24.5%     153691 ±  5%  softirqs.CPU253.TIMER
    232794 ±  8%     -30.3%     162296 ±  2%  softirqs.CPU254.RCU
    121737 ± 10%     +22.5%     149097 ±  6%  softirqs.CPU254.TIMER
    232807 ±  9%     -30.9%     160855        softirqs.CPU255.RCU
    118362 ± 10%     +25.7%     148829 ±  7%  softirqs.CPU255.TIMER
    232622 ±  8%     -31.3%     159754        softirqs.CPU256.RCU
    119580 ± 10%     +26.3%     151010 ±  6%  softirqs.CPU256.TIMER
    231785 ±  8%     -32.0%     157639 ±  2%  softirqs.CPU257.RCU
    126687 ± 10%     +19.8%     151775 ±  5%  softirqs.CPU257.TIMER
    231487 ±  8%     -31.2%     159194        softirqs.CPU258.RCU
    124518 ±  9%     +22.8%     152922 ±  4%  softirqs.CPU258.TIMER
    231805 ±  8%     -29.8%     162713        softirqs.CPU259.RCU
    125330 ± 10%     +22.2%     153192 ±  4%  softirqs.CPU259.TIMER
    237474 ±  9%     -31.8%     161858 ±  2%  softirqs.CPU26.RCU
    232931 ±  9%     -31.0%     160630 ±  2%  softirqs.CPU260.RCU
    118691 ± 10%     +26.3%     149860 ±  6%  softirqs.CPU260.TIMER
    232056 ±  9%     -30.6%     161058 ±  2%  softirqs.CPU261.RCU
    119772 ± 11%     +26.8%     151928 ±  6%  softirqs.CPU261.TIMER
    231774 ±  8%     -30.1%     161958        softirqs.CPU262.RCU
    121518 ± 13%     +21.7%     147892 ±  6%  softirqs.CPU262.TIMER
    236958 ±  9%     -31.9%     161408 ±  2%  softirqs.CPU263.RCU
    219683 ± 14%     -27.3%     159681        softirqs.CPU264.RCU
    117027 ± 13%     +24.3%     145457 ±  8%  softirqs.CPU264.TIMER
    224862 ± 12%     -27.9%     162166 ±  5%  softirqs.CPU265.RCU
    220152 ± 14%     -27.5%     159660        softirqs.CPU266.RCU
    115647 ±  9%     +25.6%     145231 ±  8%  softirqs.CPU266.TIMER
    224946 ± 13%     -28.4%     161081 ±  2%  softirqs.CPU267.RCU
    109137 ±  6%     +26.2%     137718 ±  8%  softirqs.CPU267.TIMER
    232140 ±  9%     -31.6%     158799 ±  2%  softirqs.CPU268.RCU
    232513 ±  9%     -31.6%     159038 ±  3%  softirqs.CPU269.RCU
    124552 ± 11%     +16.3%     144905 ±  7%  softirqs.CPU269.TIMER
    237555 ±  9%     -32.8%     159575 ±  3%  softirqs.CPU27.RCU
    219885 ± 14%     -28.4%     157502        softirqs.CPU270.RCU
    117006 ±  8%     +17.6%     137581 ±  7%  softirqs.CPU270.TIMER
    226280 ± 16%     -30.3%     157763 ±  2%  softirqs.CPU271.RCU
    233449 ±  9%     -32.1%     158601 ±  2%  softirqs.CPU272.RCU
    114841 ± 10%     +25.1%     143628 ±  8%  softirqs.CPU272.TIMER
    231909 ±  9%     -31.6%     158543 ±  2%  softirqs.CPU273.RCU
    116967 ± 10%     +22.3%     143046 ±  7%  softirqs.CPU273.TIMER
    219458 ± 14%     -27.2%     159721 ±  2%  softirqs.CPU274.RCU
    119066 ± 13%     +22.1%     145332 ±  8%  softirqs.CPU274.TIMER
    229016 ±  8%     -31.2%     157561 ±  3%  softirqs.CPU275.RCU
    114886 ±  8%     +28.0%     147040 ±  4%  softirqs.CPU275.TIMER
    219027 ± 13%     -28.0%     157618        softirqs.CPU276.RCU
    115369 ± 13%     +19.2%     137503 ±  8%  softirqs.CPU276.TIMER
    219504 ± 13%     -26.2%     162075 ±  6%  softirqs.CPU277.RCU
    117776 ± 14%     +25.9%     148266 ±  9%  softirqs.CPU277.TIMER
    220173 ± 13%     -27.0%     160776        softirqs.CPU278.RCU
    236676 ± 10%     -31.7%     161606 ±  4%  softirqs.CPU279.RCU
    238236 ±  9%     -31.9%     162197        softirqs.CPU28.RCU
    222405 ± 12%     -27.4%     161518 ±  3%  softirqs.CPU280.RCU
    121210 ± 11%     +19.3%     144614 ±  8%  softirqs.CPU280.TIMER
    218379 ± 14%     -29.0%     155028 ±  2%  softirqs.CPU281.RCU
    232932 ±  9%     -32.3%     157637 ±  2%  softirqs.CPU282.RCU
    115089 ±  8%     +25.2%     144138 ±  6%  softirqs.CPU282.TIMER
    218638 ± 14%     -25.9%     161973 ±  4%  softirqs.CPU283.RCU
    233158 ±  9%     -31.8%     159083        softirqs.CPU284.RCU
    111825 ±  9%     +24.3%     139055 ± 10%  softirqs.CPU284.TIMER
    220070 ± 14%     -28.4%     157676 ±  2%  softirqs.CPU285.RCU
    113471 ± 11%     +26.3%     143337 ±  9%  softirqs.CPU285.TIMER
    220955 ± 14%     -29.0%     156988 ±  2%  softirqs.CPU286.RCU
    109828 ±  8%     +26.8%     139302 ±  8%  softirqs.CPU286.TIMER
     80995 ± 30%     +48.5%     120270 ±  8%  softirqs.CPU287.TIMER
    225760 ± 14%     -28.8%     160824 ±  2%  softirqs.CPU29.RCU
    110824 ±  4%     +16.6%     129200 ±  9%  softirqs.CPU29.TIMER
    237667 ±  9%     -32.9%     159364 ±  3%  softirqs.CPU3.RCU
    237221 ±  9%     -31.6%     162260        softirqs.CPU30.RCU
    225887 ± 13%     -27.6%     163458        softirqs.CPU31.RCU
    226061 ± 14%     -27.1%     164739 ±  3%  softirqs.CPU32.RCU
    235491 ±  9%     -30.8%     162986 ±  2%  softirqs.CPU33.RCU
    224990 ± 14%     -28.3%     161374 ±  5%  softirqs.CPU34.RCU
    222704 ± 13%     -28.8%     158657 ±  2%  softirqs.CPU35.RCU
    237583 ±  9%     -31.4%     163080 ±  2%  softirqs.CPU36.RCU
    224384 ± 14%     -28.4%     160695 ±  2%  softirqs.CPU37.RCU
    226703 ± 15%     -29.1%     160635 ±  3%  softirqs.CPU38.RCU
    236926 ±  9%     -31.6%     161942 ±  2%  softirqs.CPU39.RCU
    237964 ±  9%     -31.7%     162436 ±  2%  softirqs.CPU4.RCU
    222032 ± 14%     -27.8%     160242 ±  2%  softirqs.CPU40.RCU
    120829 ± 10%     +19.5%     144338 ±  8%  softirqs.CPU40.TIMER
    223214 ± 14%     -29.5%     157403        softirqs.CPU41.RCU
    118821 ± 11%     +20.3%     142955 ±  8%  softirqs.CPU41.TIMER
    221159 ± 14%     -27.8%     159739 ±  3%  softirqs.CPU42.RCU
    119655 ± 10%     +21.7%     145609 ±  9%  softirqs.CPU42.TIMER
    221582 ± 14%     -28.4%     158562        softirqs.CPU43.RCU
    118788 ± 11%     +22.3%     145320 ±  7%  softirqs.CPU43.TIMER
    222967 ± 14%     -27.9%     160835 ±  4%  softirqs.CPU44.RCU
    112417 ±  8%     +24.1%     139484 ±  9%  softirqs.CPU44.TIMER
    224990 ± 12%     -28.7%     160339 ±  2%  softirqs.CPU45.RCU
    111540 ± 10%     +27.9%     142636 ±  8%  softirqs.CPU45.TIMER
    222427 ± 14%     -26.9%     162574 ±  2%  softirqs.CPU46.RCU
    116551 ± 14%     +22.1%     142347 ±  8%  softirqs.CPU46.TIMER
    222435 ± 14%     -26.8%     162745 ±  2%  softirqs.CPU47.RCU
    116389 ± 13%     +21.6%     141522 ±  8%  softirqs.CPU47.TIMER
    235428 ±  9%     -31.7%     160896        softirqs.CPU48.RCU
    114507 ± 12%     +25.5%     143761 ±  8%  softirqs.CPU48.TIMER
    235089 ±  8%     -32.1%     159740        softirqs.CPU49.RCU
    114816 ± 10%     +20.5%     138395 ±  9%  softirqs.CPU49.TIMER
    237583 ±  9%     -32.4%     160604 ±  3%  softirqs.CPU5.RCU
    236340 ±  9%     -32.1%     160359 ±  2%  softirqs.CPU50.RCU
    110248 ±  8%     +27.0%     139994 ±  9%  softirqs.CPU50.TIMER
    222763 ± 13%     -26.9%     162775        softirqs.CPU51.RCU
    115423 ±  8%     +23.2%     142242 ±  9%  softirqs.CPU51.TIMER
    226771 ± 12%     -30.1%     158482 ±  3%  softirqs.CPU52.RCU
    222313 ± 14%     -22.9%     171453 ±  3%  softirqs.CPU53.RCU
    121135 ± 12%     +37.6%     166708 ±  7%  softirqs.CPU53.TIMER
    221754 ± 14%     -29.2%     157079 ±  2%  softirqs.CPU54.RCU
    123236 ± 12%     +16.9%     144061 ±  7%  softirqs.CPU54.TIMER
    219939 ± 13%     -29.1%     156032 ±  2%  softirqs.CPU55.RCU
    222192 ± 13%     -28.8%     158286        softirqs.CPU56.RCU
    110797 ±  8%     +30.8%     144911 ±  6%  softirqs.CPU56.TIMER
    227010 ± 15%     -30.0%     158895        softirqs.CPU57.RCU
    120493 ±  9%     +20.6%     145269 ±  7%  softirqs.CPU57.TIMER
    223449 ± 13%     -26.4%     164506        softirqs.CPU58.RCU
    109774 ±  6%     +27.5%     139961 ±  9%  softirqs.CPU58.TIMER
    235936 ±  9%     -32.2%     159961        softirqs.CPU59.RCU
    110052 ±  6%     +25.8%     138478 ±  9%  softirqs.CPU59.TIMER
    225463 ± 14%     -27.3%     163855 ±  4%  softirqs.CPU6.RCU
    229815 ±  9%     -29.6%     161771 ±  2%  softirqs.CPU60.RCU
    232870 ±  8%     -32.0%     158277        softirqs.CPU61.RCU
    220653 ± 14%     -28.0%     158892        softirqs.CPU62.RCU
    233246 ±  8%     -31.7%     159237 ±  2%  softirqs.CPU63.RCU
    219980 ± 13%     -25.3%     164406 ±  4%  softirqs.CPU64.RCU
    120556 ± 11%     +20.9%     145736 ±  7%  softirqs.CPU64.TIMER
    234587 ±  9%     -32.6%     158033 ±  2%  softirqs.CPU65.RCU
    121833 ± 10%     +18.6%     144459 ±  6%  softirqs.CPU65.TIMER
    233829 ±  8%     -32.2%     158447 ±  2%  softirqs.CPU66.RCU
    124428 ± 10%     +18.7%     147742 ±  7%  softirqs.CPU66.TIMER
    232015 ±  8%     -32.6%     156293        softirqs.CPU67.RCU
    120453 ± 10%     +21.5%     146375 ±  8%  softirqs.CPU67.TIMER
    221688 ± 14%     -28.2%     159167 ±  2%  softirqs.CPU68.RCU
    114680 ± 11%     +24.8%     143151 ±  9%  softirqs.CPU68.TIMER
    235428 ±  9%     -30.7%     163060 ±  2%  softirqs.CPU69.RCU
    112188 ±  8%     +21.6%     136391 ± 10%  softirqs.CPU69.TIMER
    237390 ±  9%     -31.8%     161933 ±  3%  softirqs.CPU7.RCU
    222551 ± 13%     -29.0%     157963 ±  2%  softirqs.CPU70.RCU
    116262 ± 10%     +23.8%     143968 ±  8%  softirqs.CPU70.TIMER
    234532 ±  9%     -31.4%     160858        softirqs.CPU71.RCU
    111653 ±  8%     +28.2%     143085 ±  7%  softirqs.CPU71.TIMER
    222006 ±  8%     -24.7%     167264 ±  4%  softirqs.CPU72.RCU
    120182 ±  8%     +28.7%     154632 ±  6%  softirqs.CPU72.TIMER
    216143 ±  8%     -25.2%     161664 ±  4%  softirqs.CPU73.RCU
    120754 ± 13%     +27.9%     154458 ±  3%  softirqs.CPU73.TIMER
    233378 ±  8%     -30.7%     161776 ±  2%  softirqs.CPU74.RCU
    114634 ±  8%     +30.2%     149206 ±  6%  softirqs.CPU74.TIMER
    226394 ± 11%     -29.5%     159720 ±  3%  softirqs.CPU75.RCU
    117600 ± 11%     +27.7%     150133 ±  7%  softirqs.CPU75.TIMER
    225085 ±  7%     -27.8%     162404 ±  3%  softirqs.CPU76.RCU
    126524 ±  9%     +22.8%     155394 ±  6%  softirqs.CPU76.TIMER
    216680 ±  9%     -27.0%     158138 ±  3%  softirqs.CPU77.RCU
    129512 ±  8%     +20.3%     155859 ±  3%  softirqs.CPU77.TIMER
    230179 ±  8%     -28.8%     163856        softirqs.CPU78.RCU
    118458 ±  9%     +29.0%     152774 ±  8%  softirqs.CPU78.TIMER
    228133 ±  7%     -28.2%     163841 ±  2%  softirqs.CPU79.RCU
    120872 ±  9%     +25.0%     151089 ±  6%  softirqs.CPU79.TIMER
    229877 ± 13%     -29.6%     161824 ±  2%  softirqs.CPU8.RCU
    111763 ±  4%     +14.8%     128297 ±  8%  softirqs.CPU8.TIMER
    217399 ±  9%     -26.0%     160923 ±  3%  softirqs.CPU80.RCU
    122412 ±  7%     +25.2%     153212 ±  5%  softirqs.CPU80.TIMER
    222859 ±  9%     -27.9%     160603 ±  2%  softirqs.CPU81.RCU
    119142 ±  8%     +28.2%     152682 ±  5%  softirqs.CPU81.TIMER
    228699 ±  9%     -28.2%     164128        softirqs.CPU82.RCU
    125382 ± 12%     +20.2%     150686 ±  5%  softirqs.CPU82.TIMER
    228985 ±  9%     -29.6%     161303        softirqs.CPU83.RCU
    117330 ±  9%     +27.4%     149453 ±  7%  softirqs.CPU83.TIMER
    228311 ±  8%     -29.3%     161365 ±  2%  softirqs.CPU84.RCU
    118486 ±  9%     +27.4%     150961 ±  5%  softirqs.CPU84.TIMER
    233115 ±  8%     -30.9%     161132 ±  4%  softirqs.CPU85.RCU
    116935 ±  9%     +29.0%     150805 ±  5%  softirqs.CPU85.TIMER
    222799 ± 11%     -26.6%     163626        softirqs.CPU86.RCU
    120007 ± 12%     +23.9%     148736 ±  7%  softirqs.CPU86.TIMER
    227894 ±  9%     -28.0%     164192        softirqs.CPU87.RCU
    116979 ±  9%     +27.3%     148959 ±  7%  softirqs.CPU87.TIMER
    233839 ±  8%     -28.9%     166295 ±  2%  softirqs.CPU88.RCU
    126158 ± 11%     +21.0%     152670 ±  6%  softirqs.CPU88.TIMER
    222783 ± 11%     -26.2%     164350        softirqs.CPU89.RCU
    118849 ± 10%     +27.2%     151153 ±  7%  softirqs.CPU89.TIMER
    237833 ±  9%     -33.0%     159308 ±  3%  softirqs.CPU9.RCU
    229759 ±  7%     -28.1%     165156        softirqs.CPU90.RCU
    127211 ± 11%     +22.0%     155136 ±  4%  softirqs.CPU90.TIMER
    230951 ±  9%     -29.9%     161792 ±  2%  softirqs.CPU91.RCU
    122277 ±  8%     +24.6%     152343 ±  6%  softirqs.CPU91.TIMER
    228010 ±  7%     -29.2%     161527        softirqs.CPU92.RCU
    119910 ± 11%     +27.3%     152673 ±  5%  softirqs.CPU92.TIMER
    234430 ±  8%     -30.3%     163463        softirqs.CPU93.RCU
    115964 ±  8%     +31.4%     152385 ±  5%  softirqs.CPU93.TIMER
    225560 ± 10%     -28.4%     161579 ±  4%  softirqs.CPU94.RCU
    116921 ±  9%     +29.0%     150795 ±  5%  softirqs.CPU94.TIMER
    225759 ± 12%     -27.5%     163706        softirqs.CPU95.RCU
    116777 ±  8%     +30.8%     152705 ±  4%  softirqs.CPU95.TIMER
    221364 ± 14%     -24.9%     166298 ±  2%  softirqs.CPU96.RCU
    116497 ± 13%     +27.0%     147894 ±  7%  softirqs.CPU96.TIMER
    223277 ± 10%     -26.0%     165203 ±  3%  softirqs.CPU97.RCU
    113171 ± 11%     +31.2%     148503 ±  5%  softirqs.CPU97.TIMER
    233607 ±  8%     -29.8%     163961 ±  2%  softirqs.CPU98.RCU
    121935 ± 11%     +26.5%     154287 ±  5%  softirqs.CPU98.TIMER
    222980 ± 11%     -25.8%     165351        softirqs.CPU99.RCU
    125248 ± 13%     +23.5%     154739 ±  5%  softirqs.CPU99.TIMER
  65799451 ±  9%     -29.3%   46522156        softirqs.RCU
  34539115 ±  9%     +22.1%   42176671 ±  6%  softirqs.TIMER



***************************************************************************************************
lkp-hsw-d01: 8 threads Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz with 8G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/rootfs/tbox_group/test/testcase/ucode:
  gcc-7/performance/1HDD/btrfs/x86_64-rhel-7.6/debian-x86_64-20191114.cgz/lkp-hsw-d01/listdirs.f/filebench/0x27

commit: 
  7ef482fa65 ("helper for mount rootwards traversal")
  2aa3847085 ("non-RCU analogue of the previous commit")

7ef482fa65513b18 2aa38470853a65dc9b1b4bd0989 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :4           25%           1:4     dmesg.Kernel_panic-not_syncing:Fatal_exception
           :4           25%           1:4     dmesg.RIP:__d_lookup
           :4           25%           1:4     dmesg.RIP:__list_del_entry_valid
           :4           25%           1:4     dmesg.WARNING:at_lib/list_debug.c:#__list_del_entry_valid
           :4           25%           1:4     dmesg.canonical_address#:#[##]
         %stddev     %change         %stddev
             \          |                \  
    981.85           -14.1%     843.90        filebench.sum_bytes_mb/s
  29047819           -14.1%   24966024        filebench.sum_operations
    484103           -14.1%     416075        filebench.sum_operations/s
      0.01           +21.4%       0.02        filebench.sum_time_ms/op
    959147 ±  2%      -1.7%     943041 ±  2%  filebench.time.involuntary_context_switches
    310.02            +6.5%     330.10        filebench.time.system_time
    152.56           -14.0%     131.17        filebench.time.user_time
   1720648 ±  2%     -23.5%    1316815 ±  5%  filebench.time.voluntary_context_switches
     32.05            -3.8       28.21        mpstat.cpu.all.usr%
     59.44            +5.2%      62.51        iostat.cpu.system
     31.22           -12.4%      27.36 ±  2%  iostat.cpu.user
      0.54 ±  5%     +82.7%       0.99 ± 72%  iostat.sda.svctm.max
    708.17            -1.6%     696.57        iostat.sda.wkB/s
     59.00            +5.1%      62.00        vmstat.cpu.sy
     31.00           -12.9%      27.00 ±  3%  vmstat.cpu.us
    705.00            -1.6%     693.67        vmstat.io.bo
     60999 ±  2%     -12.8%      53207        vmstat.system.cs
    245879 ±  2%     -19.0%     199089        cpuidle.C1.usage
   5086988 ±  5%     -33.1%    3405326 ± 24%  cpuidle.C1E.time
    689584         +2814.6%   20098370 ± 55%  cpuidle.C3.time
     12403          +311.0%      50972 ± 48%  cpuidle.C3.usage
    326384 ±  2%   +3855.1%   12908690 ± 66%  cpuidle.C6.time
      1380         +1351.1%      20025 ± 64%  cpuidle.C6.usage
  27170801 ±  6%     -96.2%    1020682 ± 57%  cpuidle.C7s.time
     29816 ±  5%     -94.9%       1506 ± 59%  cpuidle.C7s.usage
    178060 ±  6%     -13.7%     153612 ± 12%  cpuidle.POLL.time
     78698 ±  6%     -20.8%      62299 ±  8%  cpuidle.POLL.usage
      7577 ±  2%     +56.7%      11872 ±  7%  slabinfo.filp.active_objs
    248.00 ±  2%     +57.8%     391.33 ±  6%  slabinfo.filp.active_slabs
      7962 ±  2%     +57.3%      12527 ±  6%  slabinfo.filp.num_objs
    248.00 ±  2%     +57.8%     391.33 ±  6%  slabinfo.filp.num_slabs
      1810 ±  9%     +55.1%       2806 ± 18%  slabinfo.kmalloc-192.active_objs
      1837 ±  7%     +54.2%       2833 ± 19%  slabinfo.kmalloc-192.num_objs
      1246 ±  2%      -9.6%       1127 ±  6%  slabinfo.kmalloc-1k.active_objs
    544.00 ±  5%     -13.7%     469.33 ±  6%  slabinfo.kmem_cache_node.active_objs
    544.00 ±  5%     -13.7%     469.33 ±  6%  slabinfo.kmem_cache_node.num_objs
    637.00 ±  4%      -8.1%     585.33 ±  5%  slabinfo.task_delay_info.active_objs
    637.00 ±  4%      -8.1%     585.33 ±  5%  slabinfo.task_delay_info.num_objs
      3011            -1.2%       2974        proc-vmstat.nr_dirty
     13665            -0.9%      13543        proc-vmstat.nr_inactive_anon
    130.00 ±  3%      -4.1%     124.67 ±  3%  proc-vmstat.nr_inactive_file
     13968            -0.9%      13848        proc-vmstat.nr_shmem
     29833            -0.7%      29627        proc-vmstat.nr_slab_reclaimable
     12990            +3.0%      13373        proc-vmstat.nr_slab_unreclaimable
     13665            -0.9%      13544        proc-vmstat.nr_zone_inactive_anon
    130.50 ±  2%      -4.7%     124.33 ±  3%  proc-vmstat.nr_zone_inactive_file
      3012            -1.2%       2976        proc-vmstat.nr_zone_write_pending
    386500           +87.1%     723265 ±  4%  proc-vmstat.numa_hit
    386500           +87.1%     723265 ±  4%  proc-vmstat.numa_local
    656142 ±  2%    +101.9%    1324645 ±  5%  proc-vmstat.pgalloc_normal
    607609 ±  2%    +112.4%    1290341 ±  5%  proc-vmstat.pgfree
    214920           +39.7%     300288 ±  4%  softirqs.CPU0.RCU
     13644           -15.7%      11504 ±  3%  softirqs.CPU0.SCHED
    217802           +40.1%     305223        softirqs.CPU1.RCU
     12948 ±  6%     -10.5%      11586 ±  3%  softirqs.CPU1.SCHED
    220816           +38.6%     306048        softirqs.CPU2.RCU
    208406 ±  2%     +45.2%     302562 ±  2%  softirqs.CPU3.RCU
     12272           -11.1%      10912 ±  6%  softirqs.CPU3.SCHED
     36328 ±  4%     -11.3%      32231 ±  5%  softirqs.CPU3.TIMER
    212385 ±  5%     +43.9%     305528        softirqs.CPU4.RCU
    212448 ±  2%     +42.5%     302756 ±  2%  softirqs.CPU5.RCU
     29865 ±  4%     +33.6%      39885 ±  6%  softirqs.CPU5.TIMER
    214278           +42.2%     304705 ±  2%  softirqs.CPU6.RCU
     12011           -12.5%      10510        softirqs.CPU6.SCHED
    212668           +42.9%     303956 ±  2%  softirqs.CPU7.RCU
     11230 ±  3%      -8.4%      10287        softirqs.CPU7.SCHED
     39681 ±  6%     -18.6%      32281 ±  4%  softirqs.CPU7.TIMER
   1713727           +41.9%    2431070        softirqs.RCU
     48622 ± 35%     -50.3%      24165 ± 42%  sched_debug.cfs_rq:/.load.min
     11266           -31.6%       7707 ± 10%  sched_debug.cfs_rq:/.min_vruntime.stddev
      9282 ± 13%    -149.3%      -4577        sched_debug.cfs_rq:/.spread0.avg
     33162 ±  3%     -72.4%       9137 ± 41%  sched_debug.cfs_rq:/.spread0.max
   -811.89         +1615.9%     -13931        sched_debug.cfs_rq:/.spread0.min
     11266           -31.6%       7706 ± 10%  sched_debug.cfs_rq:/.spread0.stddev
    750.25 ±  7%     -16.7%     625.33 ± 10%  sched_debug.cfs_rq:/.util_avg.min
    238.50 ±  6%     -65.4%      82.50 ±140%  sched_debug.cfs_rq:/.util_est_enqueued.min
    254642 ±  2%     -11.5%     225343        sched_debug.cpu.nr_switches.avg
    275481            -9.0%     250625        sched_debug.cpu.nr_switches.max
    237375           -13.2%     206010 ±  3%  sched_debug.cpu.nr_switches.min
    248261 ±  2%     -11.9%     218776 ±  2%  sched_debug.cpu.sched_count.avg
    264851            -8.2%     243187 ±  2%  sched_debug.cpu.sched_count.max
    233075           -13.7%     201078 ±  3%  sched_debug.cpu.sched_count.min
     21130 ±  2%     -14.1%      18155 ±  2%  sched_debug.cpu.sched_goidle.avg
     27456 ±  2%     -18.4%      22406 ±  5%  sched_debug.cpu.sched_goidle.max
     18040           -16.2%      15126        sched_debug.cpu.sched_goidle.min
      3124 ±  4%     -13.1%       2716 ± 15%  sched_debug.cpu.sched_goidle.stddev
    167144 ±  2%     -15.2%     141700 ±  2%  sched_debug.cpu.ttwu_count.avg
    174841           -10.6%     156326 ±  2%  sched_debug.cpu.ttwu_count.max
    158475           -16.5%     132400 ±  4%  sched_debug.cpu.ttwu_count.min
 4.025e+09            +1.8%  4.096e+09        perf-stat.i.branch-instructions
      1.48            -0.0        1.46        perf-stat.i.branch-miss-rate%
  56486149            -1.7%   55531379        perf-stat.i.branch-misses
     13.96 ±  2%      -1.8       12.14        perf-stat.i.cache-miss-rate%
  15384638            -9.7%   13898974        perf-stat.i.cache-misses
 1.141e+08 ±  2%      +3.9%  1.186e+08        perf-stat.i.cache-references
     63752 ±  2%     -12.4%      55837        perf-stat.i.context-switches
      1.37            -1.4%       1.35        perf-stat.i.cpi
      2420 ±  2%     -18.9%       1962 ±  2%  perf-stat.i.cpu-migrations
      1825           +10.4%       2015        perf-stat.i.cycles-between-cache-misses
      0.11            -0.0        0.10 ±  3%  perf-stat.i.dTLB-load-miss-rate%
 4.495e+09            +6.6%  4.791e+09        perf-stat.i.dTLB-loads
      0.09            -0.0        0.08        perf-stat.i.dTLB-store-miss-rate%
   2863185           -13.9%    2464352 ±  2%  perf-stat.i.dTLB-store-misses
 3.058e+09            +4.7%  3.202e+09        perf-stat.i.dTLB-stores
 2.017e+10            +1.8%  2.054e+10        perf-stat.i.instructions
      0.74            +2.2%       0.75        perf-stat.i.ipc
  13475301           -11.1%   11985595        perf-stat.i.node-loads
      1.40            -0.0        1.36        perf-stat.overall.branch-miss-rate%
     13.49 ±  2%      -1.8       11.72        perf-stat.overall.cache-miss-rate%
      1.38            -2.2%       1.35        perf-stat.overall.cpi
      1806           +10.2%       1991        perf-stat.overall.cycles-between-cache-misses
      0.11            -0.0        0.10 ±  5%  perf-stat.overall.dTLB-load-miss-rate%
      0.09            -0.0        0.08        perf-stat.overall.dTLB-store-miss-rate%
      0.73            +2.2%       0.74        perf-stat.overall.ipc
 3.962e+09            +1.8%  4.033e+09        perf-stat.ps.branch-instructions
  55633795            -1.7%   54690520        perf-stat.ps.branch-misses
  15142143            -9.6%   13682691        perf-stat.ps.cache-misses
 1.123e+08 ±  2%      +4.0%  1.167e+08        perf-stat.ps.cache-references
     62751 ±  2%     -12.4%      54971        perf-stat.ps.context-switches
      2382 ±  2%     -18.9%       1931 ±  2%  perf-stat.ps.cpu-migrations
 4.424e+09            +6.6%  4.717e+09        perf-stat.ps.dTLB-loads
   2817984           -13.9%    2425963 ±  2%  perf-stat.ps.dTLB-store-misses
  3.01e+09            +4.7%  3.152e+09        perf-stat.ps.dTLB-stores
 1.986e+10            +1.8%  2.022e+10        perf-stat.ps.instructions
  13262776           -11.0%   11799028        perf-stat.ps.node-loads
 1.292e+12            +2.4%  1.322e+12        perf-stat.total.instructions



***************************************************************************************************
lkp-ivb-d01: 8 threads Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz with 16G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
  gcc-7/performance/x86_64-rhel-7.6/thread/100%/debian-x86_64-20191114.cgz/lkp-ivb-d01/open1/will-it-scale/0x21

commit: 
  7ef482fa65 ("helper for mount rootwards traversal")
  2aa3847085 ("non-RCU analogue of the previous commit")

7ef482fa65513b18 2aa38470853a65dc9b1b4bd0989 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          2:4          -50%            :4     dmesg.RIP:cpuidle_enter_state
          1:4          -25%            :4     dmesg.RIP:poll_idle
           :4           25%           1:4     kmsg.afabc>]usb_hcd_irq
           :4           25%           1:4     kmsg.c7924>]usb_hcd_irq
           :4           25%           1:4     kmsg.ca#f>]usb_hcd_irq
          1:4          -25%            :4     kmsg.d395720>]usb_hcd_irq
           :4           25%           1:4     kmsg.f05ae>]usb_hcd_irq
          1:4          -25%            :4     kmsg.fb#f>]usb_hcd_irq
         %stddev     %change         %stddev
             \          |                \  
    338634           -29.2%     239728        will-it-scale.per_thread_ops
      1877            +7.3%       2014        will-it-scale.time.system_time
    504.46           -27.4%     366.23        will-it-scale.time.user_time
   2709080           -29.2%    1917830        will-it-scale.workload
   1368731 ± 33%     +66.5%    2278428 ± 17%  cpuidle.C1E.time
     20364 ± 28%     +66.9%      33996 ± 17%  cpuidle.C1E.usage
     53903           +29.3%      69698        meminfo.SUnreclaim
     97097           +16.2%     112853        meminfo.Slab
      0.37 ±  4%      +1.8        2.14 ±  2%  mpstat.cpu.all.soft%
     21.54            -5.8       15.78        mpstat.cpu.all.usr%
     77.25            +7.4%      83.00        vmstat.cpu.sy
     21.00           -28.6%      15.00        vmstat.cpu.us
     13525           +29.3%      17488        proc-vmstat.nr_slab_unreclaimable
  20144368           +44.3%   29064744        proc-vmstat.numa_hit
  20144368           +44.3%   29064744        proc-vmstat.numa_local
  40078120           +44.6%   57943011        proc-vmstat.pgalloc_normal
  40059077           +44.6%   57919499        proc-vmstat.pgfree
     45444 ± 46%     +91.9%      87219 ± 26%  sched_debug.cpu.nr_switches.min
     41555 ± 50%    +103.0%      84362 ± 26%  sched_debug.cpu.sched_count.min
      1879 ± 15%     +66.1%       3121 ± 13%  sched_debug.cpu.sched_goidle.avg
     94.62 ±127%    +398.9%     472.12 ± 53%  sched_debug.cpu.sched_goidle.min
     20621 ± 47%    +104.1%      42081 ± 26%  sched_debug.cpu.ttwu_count.min
     19637 ± 49%    +108.9%      41024 ± 28%  sched_debug.cpu.ttwu_local.min
     91271           +71.3%     156311        slabinfo.filp.active_objs
      2853           +71.3%       4886        slabinfo.filp.active_slabs
     91329           +71.2%     156393        slabinfo.filp.num_objs
      2853           +71.3%       4886        slabinfo.filp.num_slabs
      2585 ±  2%     +12.0%       2896 ±  4%  slabinfo.lsm_file_cache.active_objs
      2585 ±  2%     +12.0%       2896 ±  4%  slabinfo.lsm_file_cache.num_objs
    176.25 ±  3%     +33.3%     235.00 ± 20%  interrupts.52:PCI-MSI.528388-edge.eth3-TxRx-3
    854.50            -5.1%     811.00 ±  4%  interrupts.CAL:Function_call_interrupts
    176.25 ±  3%     +33.3%     235.00 ± 20%  interrupts.CPU2.52:PCI-MSI.528388-edge.eth3-TxRx-3
     95.50 ± 19%     +18.6%     113.25 ±  5%  interrupts.CPU3.CAL:Function_call_interrupts
      9906 ± 28%     -26.8%       7249        interrupts.CPU5.NMI:Non-maskable_interrupts
      9906 ± 28%     -26.8%       7249        interrupts.CPU5.PMI:Performance_monitoring_interrupts
    651646 ± 10%     +12.0%     730058 ±  8%  interrupts.CPU6.LOC:Local_timer_interrupts
      1029 ± 64%     +76.1%       1813 ± 55%  interrupts.CPU7.RES:Rescheduling_interrupts
      4.76 ±  4%      +7.2%       5.10 ±  2%  perf-stat.i.MPKI
 2.972e+09           +13.4%   3.37e+09        perf-stat.i.branch-instructions
      1.10            -0.1        1.00        perf-stat.i.branch-miss-rate%
  32828419            +2.7%   33716561        perf-stat.i.branch-misses
      7.74 ±  4%      +2.1        9.81 ±  3%  perf-stat.i.cache-miss-rate%
   5468454           +52.6%    8344125        perf-stat.i.cache-misses
  71042783 ±  4%     +20.3%   85482132 ±  2%  perf-stat.i.cache-references
      1.96           -10.9%       1.75        perf-stat.i.cpi
     57.24           -13.0%      49.79        perf-stat.i.cpu-migrations
      5366           -34.5%       3515        perf-stat.i.cycles-between-cache-misses
      2.14 ±  6%      -0.7        1.46 ±  8%  perf-stat.i.dTLB-load-miss-rate%
  95870608 ±  7%     -24.2%   72710344 ±  8%  perf-stat.i.dTLB-load-misses
 4.383e+09           +12.0%  4.908e+09        perf-stat.i.dTLB-loads
      0.43 ± 14%      -0.1        0.28 ±  6%  perf-stat.i.dTLB-store-miss-rate%
  12837336 ± 14%     -27.9%    9254848 ±  6%  perf-stat.i.dTLB-store-misses
 2.987e+09           +11.0%  3.315e+09        perf-stat.i.dTLB-stores
   2899904 ±  3%     -22.1%    2259821        perf-stat.i.iTLB-load-misses
 1.495e+10           +12.1%  1.676e+10        perf-stat.i.instructions
      5185 ±  2%     +44.1%       7471        perf-stat.i.instructions-per-iTLB-miss
      0.51           +12.2%       0.57        perf-stat.i.ipc
      4.75 ±  4%      +7.3%       5.10 ±  2%  perf-stat.overall.MPKI
      1.10            -0.1        1.00        perf-stat.overall.branch-miss-rate%
      7.71 ±  4%      +2.1        9.77 ±  3%  perf-stat.overall.cache-miss-rate%
      1.96           -10.8%       1.75        perf-stat.overall.cpi
      5357           -34.5%       3510        perf-stat.overall.cycles-between-cache-misses
      2.14 ±  6%      -0.7        1.46 ±  8%  perf-stat.overall.dTLB-load-miss-rate%
      0.43 ± 14%      -0.1        0.28 ±  6%  perf-stat.overall.dTLB-store-miss-rate%
      5158 ±  2%     +43.8%       7417        perf-stat.overall.instructions-per-iTLB-miss
      0.51           +12.1%       0.57        perf-stat.overall.ipc
   1661657           +58.4%    2632202        perf-stat.overall.path-length
 2.962e+09           +13.4%  3.359e+09        perf-stat.ps.branch-instructions
  32720778            +2.7%   33609210        perf-stat.ps.branch-misses
   5450177           +52.6%    8316246        perf-stat.ps.cache-misses
  70804449 ±  4%     +20.3%   85195410 ±  2%  perf-stat.ps.cache-references
     57.05           -13.0%      49.63        perf-stat.ps.cpu-migrations
  95548464 ±  7%     -24.2%   72466155 ±  8%  perf-stat.ps.dTLB-load-misses
 4.368e+09           +12.0%  4.892e+09        perf-stat.ps.dTLB-loads
  12794222 ± 14%     -27.9%    9223761 ±  6%  perf-stat.ps.dTLB-store-misses
 2.977e+09           +11.0%  3.304e+09        perf-stat.ps.dTLB-stores
   2890175 ±  3%     -22.1%    2252245        perf-stat.ps.iTLB-load-misses
  1.49e+10           +12.1%   1.67e+10        perf-stat.ps.instructions
 4.502e+12           +12.1%  5.048e+12        perf-stat.total.instructions
     34.65           -11.0       23.63        perf-profile.calltrace.cycles-pp.__GI___libc_close
     26.44            -8.7       17.74        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__GI___libc_close
     26.01            -8.5       17.48        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_close
      7.91 ±  5%      -3.5        4.41 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_close
     12.16 ±  2%      -3.4        8.78 ±  2%  perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_close
      5.95            -3.2        2.77 ±  4%  perf-profile.calltrace.cycles-pp.__alloc_fd.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.33 ±  2%      -3.2        8.15 ±  2%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_close
      5.50 ±  6%      -2.8        2.70 ±  4%  perf-profile.calltrace.cycles-pp.__close_fd.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_close
      4.68 ±  6%      -2.4        2.32 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__close_fd.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.99 ±  2%      -2.3        1.68 ±  7%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__alloc_fd.do_sys_openat2.do_sys_open.do_syscall_64
      2.85 ±  3%      -1.8        1.00 ± 10%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__alloc_fd.do_sys_openat2.do_sys_open
      3.35 ±  3%      -1.8        1.53 ±  7%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__close_fd.__x64_sys_close.do_syscall_64
      5.47            -1.7        3.76 ±  3%  perf-profile.calltrace.cycles-pp.getname_flags.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.98 ±  2%      -1.7        4.32 ±  2%  perf-profile.calltrace.cycles-pp.do_dentry_open.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      3.68 ±  2%      -1.2        2.45 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__GI___libc_close
      3.65 ±  5%      -1.2        2.48 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__GI___libc_open
      3.26 ±  3%      -0.9        2.38 ±  2%  perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.do_sys_openat2.do_sys_open.do_syscall_64
      3.43 ±  2%      -0.9        2.56        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__GI___libc_close
      3.05            -0.8        2.23 ±  4%  perf-profile.calltrace.cycles-pp.security_file_open.do_dentry_open.path_openat.do_filp_open.do_sys_openat2
      3.34            -0.8        2.56        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__GI___libc_open
      2.57 ±  2%      -0.8        1.80        perf-profile.calltrace.cycles-pp.ima_file_check.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      2.68            -0.7        1.94 ±  5%  perf-profile.calltrace.cycles-pp.apparmor_file_open.security_file_open.do_dentry_open.path_openat.do_filp_open
      1.35 ±  3%      -0.7        0.62 ±  4%  perf-profile.calltrace.cycles-pp.complete_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      2.46 ±  4%      -0.7        1.80        perf-profile.calltrace.cycles-pp.__check_object_size.strncpy_from_user.getname_flags.do_sys_openat2.do_sys_open
      1.69 ±  2%      -0.7        1.03 ± 15%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.getname_flags.do_sys_openat2.do_sys_open.do_syscall_64
      2.23 ±  3%      -0.6        1.59        perf-profile.calltrace.cycles-pp.security_task_getsecid.ima_file_check.path_openat.do_filp_open.do_sys_openat2
      2.04 ±  3%      -0.6        1.44        perf-profile.calltrace.cycles-pp.apparmor_task_getsecid.security_task_getsecid.ima_file_check.path_openat.do_filp_open
      1.89 ±  5%      -0.5        1.34 ±  8%  perf-profile.calltrace.cycles-pp.filp_close.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_close
      1.33 ±  4%      -0.5        0.82 ±  3%  perf-profile.calltrace.cycles-pp.fput_many.filp_close.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.71 ±  4%      -0.4        0.27 ±100%  perf-profile.calltrace.cycles-pp.task_work_add.fput_many.filp_close.__x64_sys_close.do_syscall_64
      0.68            -0.4        0.26 ±100%  perf-profile.calltrace.cycles-pp.__pthread_enable_asynccancel
      1.14 ±  6%      -0.3        0.81 ±  3%  perf-profile.calltrace.cycles-pp.aa_get_task_label.apparmor_task_getsecid.security_task_getsecid.ima_file_check.path_openat
      0.71 ±  6%      -0.3        0.39 ± 57%  perf-profile.calltrace.cycles-pp.__pthread_disable_asynccancel
      1.19 ±  3%      -0.3        0.87 ±  3%  perf-profile.calltrace.cycles-pp.may_open.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.86 ±  2%      -0.3        0.57 ±  4%  perf-profile.calltrace.cycles-pp.__fd_install.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.89 ± 12%      -0.3        0.63 ±  6%  perf-profile.calltrace.cycles-pp.__d_lookup_rcu.lookup_fast.path_openat.do_filp_open.do_sys_openat2
      0.89 ±  2%      -0.2        0.65 ±  4%  perf-profile.calltrace.cycles-pp.dput.__fput.task_work_run.exit_to_usermode_loop.do_syscall_64
      0.96 ±  8%      -0.2        0.72 ±  2%  perf-profile.calltrace.cycles-pp.__virt_addr_valid.__check_object_size.strncpy_from_user.getname_flags.do_sys_openat2
      0.78 ±  4%      -0.2        0.60 ±  5%  perf-profile.calltrace.cycles-pp.inode_permission.may_open.path_openat.do_filp_open.do_sys_openat2
      1.10 ±  6%      -0.2        0.93 ± 11%  perf-profile.calltrace.cycles-pp.__d_lookup_rcu.lookup_fast.walk_component.link_path_walk.path_openat
      0.52            +0.2        0.74 ±  5%  perf-profile.calltrace.cycles-pp.memset_erms.kmem_cache_alloc.__alloc_file.alloc_empty_file.path_openat
      0.58 ±  2%      +0.3        0.91 ±  4%  perf-profile.calltrace.cycles-pp.new_slab.___slab_alloc.__slab_alloc.kmem_cache_alloc.__alloc_file
      0.78 ±  4%      +0.4        1.21 ±  2%  perf-profile.calltrace.cycles-pp.___slab_alloc.__slab_alloc.kmem_cache_alloc.__alloc_file.alloc_empty_file
      1.89 ± 11%      +0.4        2.33 ±  6%  perf-profile.calltrace.cycles-pp.apparmor_file_free_security.security_file_free.__fput.task_work_run.exit_to_usermode_loop
      0.81 ±  4%      +0.4        1.25        perf-profile.calltrace.cycles-pp.__slab_alloc.kmem_cache_alloc.__alloc_file.alloc_empty_file.path_openat
      2.10 ± 10%      +0.5        2.59 ±  6%  perf-profile.calltrace.cycles-pp.security_file_free.__fput.task_work_run.exit_to_usermode_loop.do_syscall_64
      0.84 ±  7%      +0.5        1.35 ±  5%  perf-profile.calltrace.cycles-pp.generic_permission.inode_permission.link_path_walk.path_openat.do_filp_open
      1.10 ± 10%      +0.5        1.63 ±  2%  perf-profile.calltrace.cycles-pp.lookup_fast.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      1.48 ±  2%      +0.5        2.01 ±  3%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.security_file_alloc.__alloc_file.alloc_empty_file.path_openat
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp.lockref_put_or_lock.dput.__traverse_mounts.step_into.walk_component
      0.00            +0.6        0.58 ±  2%  perf-profile.calltrace.cycles-pp.memset_erms.kmem_cache_alloc.security_file_alloc.__alloc_file.alloc_empty_file
      1.19 ±  2%      +0.6        1.80 ±  4%  perf-profile.calltrace.cycles-pp.inode_permission.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.00            +0.7        0.66 ±  4%  perf-profile.calltrace.cycles-pp.lockref_put_return.dput.step_into.path_openat.do_filp_open
      1.49 ±  3%      +0.7        2.18        perf-profile.calltrace.cycles-pp.call_rcu.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.72 ±  2%  perf-profile.calltrace.cycles-pp.__d_lookup.lookup_fast.path_openat.do_filp_open.do_sys_openat2
      0.00            +0.8        0.78 ±  3%  perf-profile.calltrace.cycles-pp.fput_many.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00            +0.8        0.82 ± 12%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__d_lookup.lookup_fast.walk_component.link_path_walk
      0.00            +0.9        0.94 ±  2%  perf-profile.calltrace.cycles-pp.lockref_get.set_root.nd_jump_root.path_init.path_openat
      0.00            +0.9        0.94        perf-profile.calltrace.cycles-pp.lockref_put_return.dput.step_into.walk_component.link_path_walk
      0.00            +1.0        0.96 ±  3%  perf-profile.calltrace.cycles-pp.lookup_mnt.__traverse_mounts.step_into.walk_component.link_path_walk
      2.30 ±  6%      +1.0        3.31 ±  2%  perf-profile.calltrace.cycles-pp.apparmor_file_alloc_security.security_file_alloc.__alloc_file.alloc_empty_file.path_openat
      0.00            +1.0        1.01 ±  3%  perf-profile.calltrace.cycles-pp.dput.__traverse_mounts.step_into.walk_component.link_path_walk
      0.00            +1.1        1.06 ±  4%  perf-profile.calltrace.cycles-pp.lockref_get.__traverse_mounts.step_into.walk_component.link_path_walk
      2.61            +1.1        3.68        perf-profile.calltrace.cycles-pp.kmem_cache_alloc.__alloc_file.alloc_empty_file.path_openat.do_filp_open
      0.00            +1.1        1.11 ±  3%  perf-profile.calltrace.cycles-pp.dput.step_into.path_openat.do_filp_open.do_sys_openat2
      0.00            +1.1        1.12 ± 14%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.set_root.nd_jump_root.path_init
      0.00            +1.2        1.20 ±  3%  perf-profile.calltrace.cycles-pp.lockref_put_return.dput.terminate_walk.path_openat.do_filp_open
      1.36 ±  4%      +1.2        2.60 ±  8%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_openat.do_filp_open
      0.00            +1.4        1.36 ±  7%  perf-profile.calltrace.cycles-pp.__d_lookup.lookup_fast.walk_component.link_path_walk.path_openat
      1.00 ±  4%      +1.4        2.38        perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_openat2
      0.00            +1.4        1.43 ±  2%  perf-profile.calltrace.cycles-pp.dput.step_into.walk_component.link_path_walk.path_openat
      4.09 ±  3%      +1.6        5.68        perf-profile.calltrace.cycles-pp.security_file_alloc.__alloc_file.alloc_empty_file.path_openat.do_filp_open
      1.57 ±  2%      +1.6        3.17        perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00            +1.6        1.65 ±  2%  perf-profile.calltrace.cycles-pp.step_into.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00            +1.9        1.85 ± 10%  perf-profile.calltrace.cycles-pp._raw_spin_lock.set_root.nd_jump_root.path_init.path_openat
      0.65 ±  3%      +3.4        4.03 ±  6%  perf-profile.calltrace.cycles-pp.set_root.nd_jump_root.path_init.path_openat.do_filp_open
      0.00            +3.4        3.44        perf-profile.calltrace.cycles-pp.__traverse_mounts.step_into.walk_component.link_path_walk.path_openat
      9.00            +3.8       12.77        perf-profile.calltrace.cycles-pp.__alloc_file.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
      9.47            +3.9       13.39        perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.99            +4.0        4.99 ±  4%  perf-profile.calltrace.cycles-pp.nd_jump_root.path_init.path_openat.do_filp_open.do_sys_openat2
      1.40 ±  3%      +4.1        5.54 ±  4%  perf-profile.calltrace.cycles-pp.path_init.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00            +4.7        4.69        perf-profile.calltrace.cycles-pp.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_open
      1.17 ±  4%      +5.1        6.26 ±  2%  perf-profile.calltrace.cycles-pp.step_into.walk_component.link_path_walk.path_openat.do_filp_open
      0.00            +5.4        5.37        perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_open
      2.75 ±  2%      +6.5        9.21        perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      5.46            +7.7       13.14        perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
     48.59           +10.0       58.63        perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_open
     48.22           +10.2       58.37        perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_open
     63.74           +11.3       75.08        perf-profile.calltrace.cycles-pp.__GI___libc_open
     55.64           +13.4       69.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__GI___libc_open
     55.24           +13.5       68.72        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_open
     32.60           +16.5       49.05        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
     31.90           +16.6       48.47        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
     35.08           -11.1       23.95        perf-profile.children.cycles-pp.__GI___libc_close
      7.92 ±  5%      -3.5        4.42 ±  2%  perf-profile.children.cycles-pp.__x64_sys_close
      5.99            -3.2        2.81 ±  4%  perf-profile.children.cycles-pp.__alloc_fd
      5.51 ±  6%      -2.8        2.71 ±  4%  perf-profile.children.cycles-pp.__close_fd
      7.34 ±  4%      -2.4        4.94 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      6.21 ±  3%      -2.1        4.10 ±  8%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      7.52            -1.9        5.67        perf-profile.children.cycles-pp.syscall_return_via_sysret
      5.50            -1.7        3.78 ±  3%  perf-profile.children.cycles-pp.getname_flags
      6.04 ±  2%      -1.7        4.36 ±  2%  perf-profile.children.cycles-pp.do_dentry_open
      8.77 ±  3%      -1.6        7.15 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock
      3.29 ±  2%      -0.9        2.39 ±  2%  perf-profile.children.cycles-pp.strncpy_from_user
      3.07            -0.8        2.25 ±  4%  perf-profile.children.cycles-pp.security_file_open
      2.60 ±  2%      -0.8        1.82        perf-profile.children.cycles-pp.ima_file_check
      1.21 ±  3%      -0.8        0.46 ±  4%  perf-profile.children.cycles-pp.unlazy_walk
      2.68            -0.7        1.94 ±  5%  perf-profile.children.cycles-pp.apparmor_file_open
      1.36 ±  3%      -0.7        0.64 ±  5%  perf-profile.children.cycles-pp.complete_walk
      2.54 ±  4%      -0.7        1.87        perf-profile.children.cycles-pp.__check_object_size
      2.25 ±  3%      -0.7        1.59        perf-profile.children.cycles-pp.security_task_getsecid
      2.06 ±  3%      -0.6        1.46        perf-profile.children.cycles-pp.apparmor_task_getsecid
      1.92 ±  6%      -0.6        1.36 ±  8%  perf-profile.children.cycles-pp.filp_close
      2.00 ±  5%      -0.4        1.56 ±  7%  perf-profile.children.cycles-pp.__d_lookup_rcu
      1.37 ± 11%      -0.4        1.02 ± 12%  perf-profile.children.cycles-pp.fsnotify
      1.22 ±  3%      -0.3        0.89 ±  4%  perf-profile.children.cycles-pp.may_open
      1.14 ±  6%      -0.3        0.81 ±  3%  perf-profile.children.cycles-pp.aa_get_task_label
      0.86 ±  2%      -0.3        0.57 ±  4%  perf-profile.children.cycles-pp.__fd_install
      0.91 ±  3%      -0.3        0.64 ±  2%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.98 ±  8%      -0.2        0.73 ±  2%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.71 ±  6%      -0.2        0.51 ±  4%  perf-profile.children.cycles-pp.__pthread_disable_asynccancel
      0.68            -0.2        0.50 ±  4%  perf-profile.children.cycles-pp.__pthread_enable_asynccancel
      0.43 ±  4%      -0.2        0.24 ±  8%  perf-profile.children.cycles-pp._find_next_bit
      0.51 ±  4%      -0.2        0.35 ±  5%  perf-profile.children.cycles-pp.__check_heap_object
      0.46 ±  7%      -0.1        0.35 ±  2%  perf-profile.children.cycles-pp.__mnt_want_write
      0.21 ± 18%      -0.1        0.11 ± 28%  perf-profile.children.cycles-pp.ima_file_free
      0.20 ±  4%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.restore_nameidata
      0.19 ± 12%      -0.1        0.10 ± 12%  perf-profile.children.cycles-pp.vfs_open
      0.35 ±  5%      -0.1        0.27 ± 10%  perf-profile.children.cycles-pp.__x64_sys_open
      0.23 ±  7%      -0.1        0.16 ± 10%  perf-profile.children.cycles-pp.get_unused_fd_flags
      0.53 ±  5%      -0.1        0.46 ±  2%  perf-profile.children.cycles-pp.__indirect_thunk_start
      0.14 ±  6%      -0.1        0.08 ± 11%  perf-profile.children.cycles-pp.fd_install
      0.14 ± 15%      -0.1        0.09 ±  9%  perf-profile.children.cycles-pp.put_pid
      0.15 ± 19%      -0.1        0.10 ± 10%  perf-profile.children.cycles-pp.locks_remove_posix
      0.22 ±  7%      -0.0        0.17 ± 10%  perf-profile.children.cycles-pp.expand_files
      0.12 ±  5%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.process_measurement
      0.09 ±  9%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.dnotify_flush
      0.06 ± 14%      +0.0        0.09 ± 17%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rdx
      0.04 ± 58%      +0.0        0.07 ± 14%  perf-profile.children.cycles-pp.get_partial_node
      0.17 ±  4%      +0.0        0.20 ±  9%  perf-profile.children.cycles-pp.__mnt_drop_write
      0.04 ± 59%      +0.0        0.09 ± 16%  perf-profile.children.cycles-pp.rcu_segcblist_pend_cbs
      0.00            +0.1        0.05        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.01 ±173%      +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.09 ± 14%      +0.1        0.15 ±  8%  perf-profile.children.cycles-pp.free_one_page
      0.00            +0.1        0.06 ± 17%  perf-profile.children.cycles-pp.fput
      0.11 ±  9%      +0.1        0.18 ±  6%  perf-profile.children.cycles-pp.setup_object_debug
      0.00            +0.1        0.07 ± 31%  perf-profile.children.cycles-pp.kthread
      0.00            +0.1        0.07 ± 29%  perf-profile.children.cycles-pp.ret_from_fork
      0.12 ±  6%      +0.1        0.20 ±  8%  perf-profile.children.cycles-pp.__free_pages_ok
      0.10 ± 11%      +0.1        0.18 ±  7%  perf-profile.children.cycles-pp.mem_cgroup_handle_over_high
      0.18 ±  8%      +0.1        0.27 ±  5%  perf-profile.children.cycles-pp.mntget
      0.25 ±  5%      +0.1        0.34 ±  4%  perf-profile.children.cycles-pp.path_get
      0.20 ±  6%      +0.1        0.29 ±  6%  perf-profile.children.cycles-pp.unfreeze_partials
      0.20 ±  3%      +0.1        0.29 ±  8%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.21 ±  6%      +0.1        0.30 ±  6%  perf-profile.children.cycles-pp.put_cpu_partial
      0.23 ±  3%      +0.1        0.33 ±  7%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      0.11 ± 13%      +0.1        0.23 ±  5%  perf-profile.children.cycles-pp.mntput
      0.14 ±  9%      +0.1        0.27 ±  4%  perf-profile.children.cycles-pp.blkcg_maybe_throttle_current
      0.58 ±  4%      +0.1        0.71 ±  6%  perf-profile.children.cycles-pp.mntput_no_expire
      0.39 ±  2%      +0.2        0.55 ± 19%  perf-profile.children.cycles-pp.__lookup_mnt
      0.62 ±  3%      +0.2        0.81 ±  4%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.54 ±  5%      +0.2        0.72        perf-profile.children.cycles-pp.rcu_all_qs
      0.54 ±  9%      +0.2        0.75 ±  5%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.65 ±  4%      +0.2        0.89 ±  4%  perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      1.35 ±  4%      +0.3        1.63 ±  2%  perf-profile.children.cycles-pp.fput_many
      0.00            +0.3        0.28 ±  9%  perf-profile.children.cycles-pp.__legitimize_path
      0.82            +0.3        1.11 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.72 ±  3%      +0.3        1.03 ±  3%  perf-profile.children.cycles-pp.task_work_add
      0.68 ±  2%      +0.3        1.01        perf-profile.children.cycles-pp.lockref_put_or_lock
      0.72 ±  6%      +0.3        1.07 ±  3%  perf-profile.children.cycles-pp.__slab_free
      0.65 ±  4%      +0.4        1.03 ±  3%  perf-profile.children.cycles-pp.new_slab
      0.97 ±  3%      +0.4        1.35 ±  3%  perf-profile.children.cycles-pp.memset_erms
      1.33 ±  7%      +0.4        1.74 ±  4%  perf-profile.children.cycles-pp.generic_permission
      0.79 ±  3%      +0.4        1.22 ±  2%  perf-profile.children.cycles-pp.___slab_alloc
      0.00            +0.4        0.43 ±  5%  perf-profile.children.cycles-pp.legitimize_mnt
      1.90 ± 10%      +0.4        2.34 ±  6%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.95 ±  3%      +0.4        1.39        perf-profile.children.cycles-pp._cond_resched
      0.81 ±  3%      +0.4        1.25 ±  2%  perf-profile.children.cycles-pp.__slab_alloc
      1.99 ±  2%      +0.4        2.44 ±  4%  perf-profile.children.cycles-pp.inode_permission
      0.82 ±  3%      +0.5        1.29 ±  3%  perf-profile.children.cycles-pp.__might_sleep
      2.10 ± 10%      +0.5        2.60 ±  6%  perf-profile.children.cycles-pp.security_file_free
      1.54 ±  2%      +0.6        2.19 ±  3%  perf-profile.children.cycles-pp.___might_sleep
      1.52 ±  3%      +0.7        2.23        perf-profile.children.cycles-pp.call_rcu
      1.49 ±  6%      +0.7        2.24 ±  3%  perf-profile.children.cycles-pp.file_free_rcu
      5.95            +1.0        6.90 ±  3%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.00            +1.0        0.99 ±  3%  perf-profile.children.cycles-pp.lookup_mnt
      2.32 ±  5%      +1.0        3.34 ±  2%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      3.70 ±  5%      +1.5        5.17 ±  2%  perf-profile.children.cycles-pp.apic_timer_interrupt
      3.67 ±  5%      +1.5        5.14 ±  2%  perf-profile.children.cycles-pp.smp_apic_timer_interrupt
      3.37 ±  6%      +1.5        4.85 ±  3%  perf-profile.children.cycles-pp.irq_exit
      3.31 ±  6%      +1.5        4.83 ±  3%  perf-profile.children.cycles-pp.rcu_do_batch
      3.37 ±  6%      +1.5        4.89 ±  3%  perf-profile.children.cycles-pp.__softirqentry_text_start
     11.39 ±  2%      +1.5       12.92        perf-profile.children.cycles-pp.task_work_run
      3.33 ±  6%      +1.5        4.87 ±  3%  perf-profile.children.cycles-pp.rcu_core
      4.09 ±  3%      +1.6        5.69        perf-profile.children.cycles-pp.security_file_alloc
      1.61 ±  2%      +1.7        3.27        perf-profile.children.cycles-pp.terminate_walk
      2.50 ±  4%      +1.8        4.28 ±  5%  perf-profile.children.cycles-pp.lookup_fast
     12.21 ±  2%      +2.0       14.24        perf-profile.children.cycles-pp.exit_to_usermode_loop
      0.00            +2.1        2.12 ±  4%  perf-profile.children.cycles-pp.__d_lookup
      0.32 ±  5%      +2.4        2.71        perf-profile.children.cycles-pp.lockref_get
      0.00            +2.8        2.81 ±  2%  perf-profile.children.cycles-pp.lockref_put_return
      0.65 ±  3%      +3.4        4.06 ±  5%  perf-profile.children.cycles-pp.set_root
      0.00            +3.5        3.51        perf-profile.children.cycles-pp.__traverse_mounts
      9.05            +3.8       12.81        perf-profile.children.cycles-pp.__alloc_file
      9.52            +3.9       13.45        perf-profile.children.cycles-pp.alloc_empty_file
      1.02            +4.0        5.05 ±  4%  perf-profile.children.cycles-pp.nd_jump_root
      1.44 ±  2%      +4.1        5.56 ±  4%  perf-profile.children.cycles-pp.path_init
     82.25            +4.7       86.92        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.01 ±  2%      +4.8        6.85        perf-profile.children.cycles-pp.dput
     81.53            +4.9       86.44        perf-profile.children.cycles-pp.do_syscall_64
      2.78 ±  2%      +6.5        9.25        perf-profile.children.cycles-pp.walk_component
      1.51 ±  4%      +6.5        7.99 ±  2%  perf-profile.children.cycles-pp.step_into
      5.51            +7.7       13.20        perf-profile.children.cycles-pp.link_path_walk
     48.62           +10.0       58.65        perf-profile.children.cycles-pp.do_sys_open
     48.33           +10.1       58.44        perf-profile.children.cycles-pp.do_sys_openat2
     64.19           +11.2       75.38        perf-profile.children.cycles-pp.__GI___libc_open
     32.69           +16.4       49.11        perf-profile.children.cycles-pp.do_filp_open
     32.10           +16.6       48.74        perf-profile.children.cycles-pp.path_openat
     11.59            -3.5        8.09        perf-profile.self.cycles-pp.do_syscall_64
      6.55 ±  4%      -2.2        4.38 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      6.03 ±  3%      -2.2        3.86 ±  7%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      7.51            -1.8        5.66        perf-profile.self.cycles-pp.syscall_return_via_sysret
      2.54 ±  2%      -0.7        1.81 ±  4%  perf-profile.self.cycles-pp.apparmor_file_open
      1.27 ±  3%      -0.6        0.66        perf-profile.self.cycles-pp.__alloc_fd
      1.91 ±  5%      -0.4        1.46 ±  7%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.78 ± 11%      -0.4        0.35 ± 14%  perf-profile.self.cycles-pp.__close_fd
      1.02 ±  4%      -0.4        0.61 ±  2%  perf-profile.self.cycles-pp.do_sys_openat2
      1.20 ±  8%      -0.4        0.81 ±  7%  perf-profile.self.cycles-pp.do_dentry_open
      1.29 ± 11%      -0.3        0.95 ± 14%  perf-profile.self.cycles-pp.fsnotify
      1.07 ±  6%      -0.3        0.77 ±  2%  perf-profile.self.cycles-pp.aa_get_task_label
      0.83 ±  2%      -0.3        0.54 ±  3%  perf-profile.self.cycles-pp.__fd_install
      0.87 ±  2%      -0.3        0.60        perf-profile.self.cycles-pp.apparmor_task_getsecid
      0.97 ±  4%      -0.3        0.70 ±  6%  perf-profile.self.cycles-pp.__check_object_size
      0.84 ±  4%      -0.3        0.58 ±  2%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.76 ±  3%      -0.3        0.50 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.88 ±  6%      -0.2        0.63 ±  3%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.71 ±  4%      -0.2        0.49 ±  5%  perf-profile.self.cycles-pp.strncpy_from_user
      0.65 ±  4%      -0.2        0.45 ±  6%  perf-profile.self.cycles-pp.__GI___libc_close
      1.20            -0.2        1.00        perf-profile.self.cycles-pp.__fput
      0.63            -0.2        0.44 ±  4%  perf-profile.self.cycles-pp.__pthread_enable_asynccancel
      0.68 ±  2%      -0.2        0.49 ±  3%  perf-profile.self.cycles-pp.__GI___libc_open
      0.41 ±  4%      -0.2        0.23 ±  8%  perf-profile.self.cycles-pp._find_next_bit
      0.62 ±  5%      -0.2        0.44 ±  6%  perf-profile.self.cycles-pp.__pthread_disable_asynccancel
      0.48 ±  4%      -0.2        0.32 ±  9%  perf-profile.self.cycles-pp.__check_heap_object
      0.47 ±  3%      -0.2        0.31 ±  6%  perf-profile.self.cycles-pp.getname_flags
      0.43 ±  7%      -0.1        0.31 ±  3%  perf-profile.self.cycles-pp.__x64_sys_close
      0.42 ±  3%      -0.1        0.29 ±  3%  perf-profile.self.cycles-pp.do_filp_open
      0.33 ±  6%      -0.1        0.21 ±  9%  perf-profile.self.cycles-pp.may_open
      0.43 ±  6%      -0.1        0.32 ±  5%  perf-profile.self.cycles-pp.__mnt_want_write
      0.19 ± 17%      -0.1        0.10 ± 28%  perf-profile.self.cycles-pp.ima_file_free
      0.31 ±  5%      -0.1        0.22 ± 11%  perf-profile.self.cycles-pp.__x64_sys_open
      0.28 ±  4%      -0.1        0.20 ± 10%  perf-profile.self.cycles-pp.do_sys_open
      0.17 ±  4%      -0.1        0.09 ±  4%  perf-profile.self.cycles-pp.restore_nameidata
      0.21 ±  3%      -0.1        0.14 ±  9%  perf-profile.self.cycles-pp.ima_file_check
      0.15 ± 12%      -0.1        0.08        perf-profile.self.cycles-pp.vfs_open
      0.18 ±  8%      -0.1        0.12 ±  7%  perf-profile.self.cycles-pp.security_task_getsecid
      0.21 ±  7%      -0.1        0.15 ± 11%  perf-profile.self.cycles-pp.get_unused_fd_flags
      0.12 ±  9%      -0.1        0.06 ± 11%  perf-profile.self.cycles-pp.fd_install
      0.13 ± 22%      -0.1        0.08 ± 13%  perf-profile.self.cycles-pp.locks_remove_posix
      0.19 ±  8%      -0.0        0.15 ±  7%  perf-profile.self.cycles-pp.expand_files
      0.15 ±  9%      -0.0        0.11 ± 13%  perf-profile.self.cycles-pp.unlazy_walk
      0.11 ± 17%      -0.0        0.07 ± 17%  perf-profile.self.cycles-pp.put_pid
      0.08 ± 15%      -0.0        0.04 ± 59%  perf-profile.self.cycles-pp.dnotify_flush
      0.11 ±  4%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.process_measurement
      0.07 ± 15%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.putname
      0.06            +0.0        0.08 ± 10%  perf-profile.self.cycles-pp.path_get
      0.08 ± 10%      +0.0        0.11 ±  8%  perf-profile.self.cycles-pp.___slab_alloc
      0.04 ± 57%      +0.0        0.07 ± 12%  perf-profile.self.cycles-pp.__x86_indirect_thunk_rdx
      0.16 ±  5%      +0.0        0.19 ±  9%  perf-profile.self.cycles-pp.__mnt_drop_write
      0.10 ±  8%      +0.0        0.13 ±  9%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.18 ±  6%      +0.0        0.22 ±  5%  perf-profile.self.cycles-pp.security_file_free
      0.18 ± 10%      +0.0        0.22 ±  7%  perf-profile.self.cycles-pp.alloc_empty_file
      0.07 ± 17%      +0.0        0.11 ±  8%  perf-profile.self.cycles-pp.free_one_page
      0.01 ±173%      +0.0        0.05 ±  9%  perf-profile.self.cycles-pp.setup_object_debug
      0.27            +0.0        0.31 ±  6%  perf-profile.self.cycles-pp.security_inode_permission
      0.33 ±  5%      +0.0        0.38 ±  4%  perf-profile.self.cycles-pp.nd_jump_root
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.legitimize_mnt
      0.43 ±  7%      +0.1        0.49 ±  5%  perf-profile.self.cycles-pp.path_init
      0.01 ±173%      +0.1        0.07 ± 11%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.08 ± 12%      +0.1        0.15 ±  5%  perf-profile.self.cycles-pp.mntput
      0.08 ± 14%      +0.1        0.15 ± 10%  perf-profile.self.cycles-pp.mem_cgroup_handle_over_high
      0.16 ±  9%      +0.1        0.23 ±  4%  perf-profile.self.cycles-pp.mntget
      0.21 ±  6%      +0.1        0.30 ±  8%  perf-profile.self.cycles-pp.walk_component
      0.48 ±  3%      +0.1        0.58 ±  5%  perf-profile.self.cycles-pp.lookup_fast
      0.13 ±  8%      +0.1        0.23 ±  7%  perf-profile.self.cycles-pp.blkcg_maybe_throttle_current
      0.54 ±  5%      +0.1        0.66 ±  7%  perf-profile.self.cycles-pp.mntput_no_expire
      0.00            +0.1        0.12 ±  7%  perf-profile.self.cycles-pp.__legitimize_path
      0.42 ±  7%      +0.1        0.54        perf-profile.self.cycles-pp.rcu_all_qs
      0.35 ±  2%      +0.1        0.49 ± 19%  perf-profile.self.cycles-pp.__lookup_mnt
      0.18 ±  6%      +0.1        0.33 ±  4%  perf-profile.self.cycles-pp.terminate_walk
      0.57 ±  4%      +0.2        0.72 ±  2%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.61 ±  3%      +0.2        0.78 ±  4%  perf-profile.self.cycles-pp.lockref_put_or_lock
      1.27 ±  5%      +0.2        1.44 ±  2%  perf-profile.self.cycles-pp.path_openat
      0.52 ±  9%      +0.2        0.73 ±  4%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.64 ±  3%      +0.2        0.88 ±  4%  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.40 ±  4%      +0.2        0.64 ±  3%  perf-profile.self.cycles-pp._cond_resched
      0.33 ±  4%      +0.2        0.57 ±  3%  perf-profile.self.cycles-pp.new_slab
      0.00            +0.3        0.26 ±  6%  perf-profile.self.cycles-pp.lookup_mnt
      1.08 ±  6%      +0.3        1.34 ±  6%  perf-profile.self.cycles-pp.step_into
      0.63 ±  3%      +0.3        0.90 ±  3%  perf-profile.self.cycles-pp.task_work_add
      0.80            +0.3        1.08 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.57 ±  7%      +0.3        0.87 ±  3%  perf-profile.self.cycles-pp.exit_to_usermode_loop
      0.72 ±  6%      +0.3        1.05 ±  3%  perf-profile.self.cycles-pp.__slab_free
      0.91 ±  4%      +0.3        1.25 ±  3%  perf-profile.self.cycles-pp.memset_erms
      1.27 ±  7%      +0.4        1.62 ±  5%  perf-profile.self.cycles-pp.generic_permission
      1.77 ± 11%      +0.4        2.14 ±  6%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.76 ±  3%      +0.4        1.15        perf-profile.self.cycles-pp.call_rcu
      0.74 ±  3%      +0.4        1.12 ±  2%  perf-profile.self.cycles-pp.__might_sleep
      2.51 ±  5%      +0.4        2.91        perf-profile.self.cycles-pp._raw_spin_lock
      0.00            +0.4        0.44 ±  8%  perf-profile.self.cycles-pp.__traverse_mounts
      0.60 ±  5%      +0.5        1.09 ±  5%  perf-profile.self.cycles-pp.set_root
      1.28 ±  4%      +0.5        1.81 ±  2%  perf-profile.self.cycles-pp.link_path_walk
      1.44 ±  2%      +0.6        2.00 ±  3%  perf-profile.self.cycles-pp.___might_sleep
      0.42 ±  7%      +0.6        1.03        perf-profile.self.cycles-pp.dput
      1.24            +0.7        1.92 ±  2%  perf-profile.self.cycles-pp.task_work_run
      1.46 ±  6%      +0.7        2.20 ±  3%  perf-profile.self.cycles-pp.file_free_rcu
      1.92 ±  7%      +0.8        2.72 ±  2%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      2.18 ±  2%      +1.0        3.16        perf-profile.self.cycles-pp.__alloc_file
      0.00            +1.0        1.00 ± 11%  perf-profile.self.cycles-pp.__d_lookup
      0.31 ±  6%      +2.3        2.58        perf-profile.self.cycles-pp.lockref_get
      0.00            +2.6        2.64        perf-profile.self.cycles-pp.lockref_put_return



***************************************************************************************************
lkp-hsw-ep4: 72 threads Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_job/nr_task/rootfs/runtime/tbox_group/test/testcase/ucode:
  gcc-7/performance/x86_64-rhel-7.6/1000/100%/debian-x86_64-20191114.cgz/300s/lkp-hsw-ep4/high_systime/reaim/0x43

commit: 
  7ef482fa65 ("helper for mount rootwards traversal")
  2aa3847085 ("non-RCU analogue of the previous commit")

7ef482fa65513b18 2aa38470853a65dc9b1b4bd0989 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          1:4           -7%           1:4     perf-profile.children.cycles-pp.error_entry
          1:4           -7%           0:4     perf-profile.self.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
    226.54          +123.5%     506.34        reaim.child_systime
    149.14            -4.7%     142.18        reaim.child_utime
     21958            -2.0%      21515        reaim.jobs_per_min
    304.98            -2.0%     298.83        reaim.jobs_per_min_child
     21961            -2.0%      21522        reaim.max_jobs_per_min
    195.75            +2.1%     199.78        reaim.parent_time
      0.08 ±  4%    +185.9%       0.23 ±  3%  reaim.std_dev_percent
      0.16 ±  5%    +188.2%       0.46 ±  4%  reaim.std_dev_time
    395.57            +2.0%     403.62        reaim.time.elapsed_time
    395.57            +2.0%     403.62        reaim.time.elapsed_time.max
     48744           +32.6%      64645 ±  2%  reaim.time.involuntary_context_switches
    190.25           +69.1%     321.75        reaim.time.percent_of_cpu_this_job_got
    455.53          +122.8%       1015        reaim.time.system_time
    299.52            -4.7%     285.57        reaim.time.user_time
   2004312            -2.3%    1957239        reaim.time.voluntary_context_switches
      2.00            +1.9        3.87        mpstat.cpu.all.sys%
     39253            +1.4%      39808        proc-vmstat.nr_slab_unreclaimable
     36.79            +3.7%      38.16        boot-time.boot
      2289            +3.8%       2376        boot-time.idle
     97.00            -2.1%      95.00        vmstat.cpu.id
      2.00           +50.0%       3.00        vmstat.procs.r
     14531            -2.6%      14149        vmstat.system.cs
     22745           +26.1%      28690        slabinfo.filp.active_objs
    756.50           +31.0%     991.00        slabinfo.filp.active_slabs
     24225           +31.0%      31732        slabinfo.filp.num_objs
    756.50           +31.0%     991.00        slabinfo.filp.num_slabs
      1375 ±  5%      -9.9%       1239 ±  3%  slabinfo.kmalloc-rcl-96.active_objs
      1375 ±  5%      -9.9%       1239 ±  3%  slabinfo.kmalloc-rcl-96.num_objs
    747.00 ±  4%     -17.1%     619.00 ± 11%  slabinfo.kmem_cache_node.active_objs
    800.00 ±  4%     -16.0%     672.00 ± 10%  slabinfo.kmem_cache_node.num_objs
      5215           +16.1%       6053 ±  2%  slabinfo.sock_inode_cache.active_objs
      5215           +16.1%       6053 ±  2%  slabinfo.sock_inode_cache.num_objs
      7006 ± 16%     +30.7%       9155 ±  8%  softirqs.CPU10.NET_RX
    112821 ±  3%      +6.0%     119576 ±  4%  softirqs.CPU15.TIMER
    113001 ±  3%      +6.0%     119735 ±  5%  softirqs.CPU16.TIMER
    114773 ±  4%     +25.3%     143816 ± 26%  softirqs.CPU2.TIMER
     10583 ±  6%     -17.6%       8716 ± 10%  softirqs.CPU21.NET_RX
     10664 ±  6%     -22.4%       8274 ± 18%  softirqs.CPU26.NET_RX
     11489 ±  7%     -21.9%       8975 ± 14%  softirqs.CPU27.NET_RX
     12052 ±  8%     -24.1%       9145 ± 16%  softirqs.CPU29.NET_RX
     97911           +12.7%     110340 ±  3%  softirqs.CPU37.RCU
    111332 ±  2%      +8.3%     120603 ±  6%  softirqs.CPU37.TIMER
     99031            +8.9%     107844 ±  4%  softirqs.CPU4.RCU
      7898 ±  5%     +17.9%       9309 ±  5%  softirqs.CPU41.NET_RX
      9362 ± 15%     +19.6%      11193 ± 11%  softirqs.CPU44.NET_RX
     12748 ± 22%     -26.3%       9389 ± 19%  softirqs.CPU45.NET_RX
    111535 ±  3%      +5.4%     117587 ±  5%  softirqs.CPU45.TIMER
    111506 ±  3%      +7.1%     119422 ±  4%  softirqs.CPU50.TIMER
    111380 ±  3%      +5.8%     117857 ±  5%  softirqs.CPU51.TIMER
     12824 ± 10%     -26.0%       9489 ±  2%  softirqs.CPU52.NET_RX
      9003 ± 12%     +30.7%      11763 ± 13%  softirqs.CPU62.NET_RX
    112274 ±  3%      +6.6%     119733 ±  5%  softirqs.CPU8.TIMER
      8353 ± 11%     +42.7%      11917 ± 15%  softirqs.CPU9.NET_RX
      4014           +40.9%       5657        sched_debug.cfs_rq:/.exec_clock.avg
      6076 ±  3%     +30.1%       7907 ±  2%  sched_debug.cfs_rq:/.exec_clock.max
      2987 ±  4%     +56.6%       4679 ±  2%  sched_debug.cfs_rq:/.exec_clock.min
    160128 ±  3%     +83.5%     293810        sched_debug.cfs_rq:/.min_vruntime.avg
    186743           +79.1%     334424 ±  2%  sched_debug.cfs_rq:/.min_vruntime.max
    135562 ±  5%     +87.1%     253668        sched_debug.cfs_rq:/.min_vruntime.min
     11174 ±  7%     +71.1%      19121 ± 13%  sched_debug.cfs_rq:/.min_vruntime.stddev
      3.69 ± 42%     +94.4%       7.17 ± 27%  sched_debug.cfs_rq:/.removed.load_avg.avg
     22.12 ± 20%     +80.6%      39.95 ± 13%  sched_debug.cfs_rq:/.removed.load_avg.stddev
    170.14 ± 42%     +94.5%     330.89 ± 27%  sched_debug.cfs_rq:/.removed.runnable_sum.avg
      1021 ± 20%     +80.8%       1845 ± 13%  sched_debug.cfs_rq:/.removed.runnable_sum.stddev
     47.36 ± 21%    +112.2%     100.50 ± 28%  sched_debug.cfs_rq:/.removed.util_avg.max
      6.73 ± 30%    +133.0%      15.69 ± 30%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    -25353           +68.5%     -42719        sched_debug.cfs_rq:/.spread0.min
     11174 ±  7%     +71.1%      19121 ± 13%  sched_debug.cfs_rq:/.spread0.stddev
    152.79 ±  5%     +10.4%     168.65 ±  5%  sched_debug.cfs_rq:/.util_avg.stddev
    187.79 ±  7%     +38.5%     260.04 ±  9%  sched_debug.cfs_rq:/.util_est_enqueued.max
     33.10 ± 11%     +37.2%      45.40 ± 10%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    174945 ±  2%     +24.4%     217667 ± 12%  sched_debug.cpu.avg_idle.stddev
      2.91 ±  6%      -9.1%       2.64 ±  6%  sched_debug.cpu.clock.stddev
      2.91 ±  6%      -9.1%       2.64 ±  6%  sched_debug.cpu.clock_task.stddev
    603.06 ± 19%     +25.6%     757.62 ±  8%  sched_debug.cpu.curr->pid.avg
      0.00 ±  8%     +23.1%       0.00 ±  7%  sched_debug.cpu.next_balance.stddev
      0.06 ± 10%     +27.2%       0.07 ±  5%  sched_debug.cpu.nr_running.avg
      0.21 ±  3%     +13.7%       0.24 ±  2%  sched_debug.cpu.nr_running.stddev
     31.11 ± 19%     -26.1%      23.00 ± 10%  sched_debug.cpu.nr_uninterruptible.max
    214.00 ±  5%     +50.5%     322.00 ± 48%  interrupts.49:IR-PCI-MSI.1572874-edge.eth0-TxRx-10
    211.25 ±  5%     +11.1%     234.75 ±  6%  interrupts.51:IR-PCI-MSI.1572876-edge.eth0-TxRx-12
    195.75            +8.2%     211.75 ±  6%  interrupts.79:IR-PCI-MSI.1572902-edge.eth0-TxRx-38
     32321            -1.8%      31726        interrupts.CAL:Function_call_interrupts
    214.00 ±  5%     +50.5%     322.00 ± 48%  interrupts.CPU10.49:IR-PCI-MSI.1572874-edge.eth0-TxRx-10
    417.00 ±  6%     +39.6%     582.00 ± 18%  interrupts.CPU10.RES:Rescheduling_interrupts
    211.25 ±  5%     +11.1%     234.75 ±  6%  interrupts.CPU12.51:IR-PCI-MSI.1572876-edge.eth0-TxRx-12
    440.25 ±  7%     +12.9%     497.25 ±  4%  interrupts.CPU12.RES:Rescheduling_interrupts
    159.75 ± 14%     +79.8%     287.25 ± 29%  interrupts.CPU14.NMI:Non-maskable_interrupts
    159.75 ± 14%     +79.8%     287.25 ± 29%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
    436.25 ± 10%     +19.6%     521.75 ±  4%  interrupts.CPU15.RES:Rescheduling_interrupts
    402.00 ±  6%     +22.6%     492.75 ±  7%  interrupts.CPU16.RES:Rescheduling_interrupts
    390.00 ±  5%     +19.7%     467.00 ±  6%  interrupts.CPU17.RES:Rescheduling_interrupts
    485.25 ±  5%     +19.5%     580.00 ±  6%  interrupts.CPU2.RES:Rescheduling_interrupts
    195.75            +8.2%     211.75 ±  6%  interrupts.CPU20.79:IR-PCI-MSI.1572902-edge.eth0-TxRx-38
     85.75 ± 13%     -30.3%      59.75 ± 17%  interrupts.CPU21.TLB:TLB_shootdowns
    107.00 ± 32%     -38.8%      65.50 ± 11%  interrupts.CPU23.TLB:TLB_shootdowns
    426.00 ±  6%     +13.7%     484.50 ±  5%  interrupts.CPU26.RES:Rescheduling_interrupts
     96.25 ± 26%     -36.1%      61.50 ± 14%  interrupts.CPU27.TLB:TLB_shootdowns
    151.75 ± 21%     -60.6%      59.75 ± 15%  interrupts.CPU28.TLB:TLB_shootdowns
    498.50 ±  9%    +170.4%       1347 ±  2%  interrupts.CPU3.RES:Rescheduling_interrupts
    420.50 ± 19%     +76.5%     742.25 ± 42%  interrupts.CPU30.RES:Rescheduling_interrupts
    127.00 ± 64%     -54.3%      58.00 ±  8%  interrupts.CPU31.TLB:TLB_shootdowns
     94.25 ± 31%     -37.4%      59.00 ± 24%  interrupts.CPU37.TLB:TLB_shootdowns
    440.75 ± 10%     +25.4%     552.75 ± 11%  interrupts.CPU39.RES:Rescheduling_interrupts
    438.25 ±  5%     +17.6%     515.25 ±  3%  interrupts.CPU4.RES:Rescheduling_interrupts
    438.00 ±  7%     +23.8%     542.25 ±  5%  interrupts.CPU40.RES:Rescheduling_interrupts
    524.50 ±  5%     +13.7%     596.25 ±  5%  interrupts.CPU41.RES:Rescheduling_interrupts
     81.75 ± 18%     -28.1%      58.75 ±  8%  interrupts.CPU41.TLB:TLB_shootdowns
    483.75 ±  2%     +17.4%     567.75 ±  6%  interrupts.CPU46.RES:Rescheduling_interrupts
    425.75 ±  4%     +27.3%     542.00 ±  6%  interrupts.CPU48.RES:Rescheduling_interrupts
    297.00 ± 12%     -24.9%     223.00 ± 33%  interrupts.CPU54.NMI:Non-maskable_interrupts
    297.00 ± 12%     -24.9%     223.00 ± 33%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
    197.50 ± 28%     +65.9%     327.75 ± 18%  interrupts.CPU57.NMI:Non-maskable_interrupts
    197.50 ± 28%     +65.9%     327.75 ± 18%  interrupts.CPU57.PMI:Performance_monitoring_interrupts
    460.25 ±  8%     +15.2%     530.00 ±  3%  interrupts.CPU57.RES:Rescheduling_interrupts
    471.00 ±  5%     +33.0%     626.50 ± 24%  interrupts.CPU58.RES:Rescheduling_interrupts
    476.50 ±  8%     +35.8%     647.25 ± 29%  interrupts.CPU61.RES:Rescheduling_interrupts
    101.75 ± 45%     -52.8%      48.00 ± 19%  interrupts.CPU62.TLB:TLB_shootdowns
    467.50 ±  9%     +30.6%     610.75 ±  8%  interrupts.CPU64.RES:Rescheduling_interrupts
    453.50 ±  7%     +51.3%     686.25 ± 27%  interrupts.CPU66.RES:Rescheduling_interrupts
    444.25 ±  8%     +57.0%     697.50 ± 34%  interrupts.CPU68.RES:Rescheduling_interrupts
    413.25 ±  7%     +24.9%     516.25 ±  9%  interrupts.CPU9.RES:Rescheduling_interrupts
     36637           +10.6%      40529 ±  2%  interrupts.RES:Rescheduling_interrupts
 8.391e+08           +24.9%  1.048e+09        perf-stat.i.branch-instructions
      2.16            -0.1        2.10        perf-stat.i.branch-miss-rate%
      4.48            +0.2        4.70        perf-stat.i.cache-miss-rate%
   2644019           +16.3%    3074372        perf-stat.i.cache-misses
  46671140            +3.5%   48312981        perf-stat.i.cache-references
     14521            -2.3%      14186        perf-stat.i.context-switches
 7.816e+09           +44.5%  1.129e+10        perf-stat.i.cpu-cycles
    947.27            +2.9%     974.42        perf-stat.i.cpu-migrations
 1.111e+09           +19.3%  1.325e+09        perf-stat.i.dTLB-loads
   1448157            -3.2%    1402349        perf-stat.i.dTLB-store-misses
 6.388e+08            +3.6%  6.616e+08        perf-stat.i.dTLB-stores
     20.84            +1.1       21.94 ±  2%  perf-stat.i.iTLB-load-miss-rate%
 3.996e+09           +21.0%  4.834e+09        perf-stat.i.instructions
    154139            -2.3%     150556        perf-stat.i.minor-faults
   1681849           +10.5%    1858237        perf-stat.i.node-load-misses
    219358           +23.7%     271422        perf-stat.i.node-loads
    390275 ±  2%     +34.7%     525659        perf-stat.i.node-store-misses
    332890 ±  2%     +20.1%     399879        perf-stat.i.node-stores
    154139            -2.3%     150556        perf-stat.i.page-faults
     11.67           -14.5%       9.97        perf-stat.overall.MPKI
      1.99            -0.4        1.60        perf-stat.overall.branch-miss-rate%
      5.68            +0.7        6.38        perf-stat.overall.cache-miss-rate%
      1.96           +19.7%       2.34        perf-stat.overall.cpi
      2953           +24.7%       3681        perf-stat.overall.cycles-between-cache-misses
      0.36 ±  6%      -0.1        0.29 ±  5%  perf-stat.overall.dTLB-load-miss-rate%
      0.23            -0.0        0.21        perf-stat.overall.dTLB-store-miss-rate%
      1978 ±  2%     +22.3%       2419 ±  8%  perf-stat.overall.instructions-per-iTLB-miss
      0.51           -16.4%       0.43        perf-stat.overall.ipc
     88.46            -1.2       87.24        perf-stat.overall.node-load-miss-rate%
     54.05            +2.8       56.84        perf-stat.overall.node-store-miss-rate%
  11072678           +23.4%   13663359        perf-stat.overall.path-length
 8.442e+08           +24.8%  1.053e+09        perf-stat.ps.branch-instructions
   2664434           +15.9%    3088457        perf-stat.ps.cache-misses
  46905438            +3.2%   48419008        perf-stat.ps.cache-references
     14529            -2.4%      14173        perf-stat.ps.context-switches
 7.868e+09           +44.5%  1.137e+10        perf-stat.ps.cpu-cycles
    953.66            +2.5%     977.36        perf-stat.ps.cpu-migrations
 1.118e+09           +19.0%   1.33e+09        perf-stat.ps.dTLB-loads
   1461983 ±  2%      -3.7%    1408156        perf-stat.ps.dTLB-store-misses
 6.427e+08            +3.2%  6.631e+08        perf-stat.ps.dTLB-stores
  4.02e+09           +20.8%  4.855e+09        perf-stat.ps.instructions
    155116            -2.7%     150903        perf-stat.ps.minor-faults
   1693703           +10.1%    1865332        perf-stat.ps.node-load-misses
    220920           +23.5%     272743        perf-stat.ps.node-loads
    394598 ±  2%     +34.1%     529320        perf-stat.ps.node-store-misses
    335514 ±  2%     +19.8%     401853        perf-stat.ps.node-stores
    155116            -2.7%     150903        perf-stat.ps.page-faults
 1.594e+12           +23.4%  1.968e+12        perf-stat.total.instructions
      0.99 ±  3%      -0.1        0.89 ±  5%  perf-profile.calltrace.cycles-pp.native_write_msr.lapic_next_deadline.clockevents_program_event.hrtimer_interrupt.smp_apic_timer_interrupt
      0.73 ± 11%      +0.1        0.83 ±  3%  perf-profile.calltrace.cycles-pp.perf_event_mmap.do_brk_flags.__x64_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.59 ±  8%      +0.3        0.93        perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat
      0.58 ±  8%      +0.3        0.93        perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat
      0.70 ±  9%      +0.4        1.11 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat
      0.70 ±  9%      +0.4        1.11 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat
      0.78 ±  9%      +0.4        1.20        perf-profile.calltrace.cycles-pp.creat
      0.26 ±100%      +0.7        0.98 ± 24%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      0.27 ±100%      +0.7        0.99 ± 24%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.06 ±  3%      -0.4        4.70 ±  5%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      2.38 ±  5%      -0.3        2.08 ±  7%  perf-profile.children.cycles-pp.update_process_times
      2.47 ±  4%      -0.3        2.19 ±  6%  perf-profile.children.cycles-pp.tick_sched_handle
      0.67 ±  6%      -0.1        0.56 ± 12%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.45 ±  6%      -0.1        0.36 ± 10%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      1.22 ±  2%      -0.1        1.14 ±  5%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.56 ±  6%      -0.1        0.47 ±  9%  perf-profile.children.cycles-pp.sched_clock
      0.53 ±  5%      -0.1        0.45 ± 10%  perf-profile.children.cycles-pp.native_sched_clock
      0.48 ±  3%      -0.1        0.42 ±  9%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.20 ± 16%      -0.1        0.15 ± 17%  perf-profile.children.cycles-pp.rcu_eqs_enter
      0.07 ± 15%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.mem_cgroup_try_charge
      0.25 ± 10%      -0.0        0.20 ± 17%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.08 ±  5%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.xas_load
      0.08 ±  5%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.xas_find
      0.28 ±  3%      +0.0        0.31 ±  5%  perf-profile.children.cycles-pp.copy_page
      0.28 ±  3%      +0.0        0.32 ±  6%  perf-profile.children.cycles-pp.copy_user_highpage
      0.28 ±  7%      +0.0        0.33 ±  9%  perf-profile.children.cycles-pp.do_mprotect_pkey
      0.18 ±  4%      +0.0        0.23 ±  9%  perf-profile.children.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.12 ±  8%      +0.0        0.17 ± 11%  perf-profile.children.cycles-pp.strlcpy
      0.14 ±  5%      +0.1        0.20 ± 13%  perf-profile.children.cycles-pp.unlink_file_vma
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.unlink
      0.04 ± 60%      +0.1        0.10 ± 25%  perf-profile.children.cycles-pp.fput_many
      0.03 ±102%      +0.1        0.09 ± 16%  perf-profile.children.cycles-pp.link
      0.05 ± 61%      +0.1        0.11 ±  6%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.00            +0.1        0.06 ± 26%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.24 ±  3%      +0.1        0.31 ±  7%  perf-profile.children.cycles-pp.dput
      0.00            +0.1        0.07 ± 36%  perf-profile.children.cycles-pp.lockref_get
      0.15 ± 25%      +0.1        0.23 ±  7%  perf-profile.children.cycles-pp.rcu_do_batch
      0.10 ± 24%      +0.1        0.17 ± 11%  perf-profile.children.cycles-pp.security_file_alloc
      0.00            +0.1        0.08 ± 20%  perf-profile.children.cycles-pp.__x64_sys_link
      0.00            +0.1        0.08 ± 20%  perf-profile.children.cycles-pp.do_linkat
      0.00            +0.1        0.08 ± 17%  perf-profile.children.cycles-pp.set_root
      0.32 ±  8%      +0.1        0.40 ± 17%  perf-profile.children.cycles-pp.get_unmapped_area
      0.00            +0.1        0.10 ± 11%  perf-profile.children.cycles-pp.__d_lookup
      0.33 ± 14%      +0.1        0.43 ± 11%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.91 ±  9%      +0.1        1.02 ±  2%  perf-profile.children.cycles-pp.perf_event_mmap
      0.42 ± 14%      +0.1        0.53 ± 12%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.00            +0.1        0.11 ± 24%  perf-profile.children.cycles-pp.nd_jump_root
      0.35 ± 12%      +0.1        0.46 ± 13%  perf-profile.children.cycles-pp.flush_tlb_func_common
      0.35 ±  3%      +0.1        0.47 ± 10%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.15 ± 11%      +0.1        0.28 ±  2%  perf-profile.children.cycles-pp.step_into
      0.66 ± 11%      +0.1        0.79 ± 13%  perf-profile.children.cycles-pp.__do_munmap
      0.00            +0.1        0.13 ± 31%  perf-profile.children.cycles-pp.path_init
      0.45 ±  7%      +0.1        0.59 ± 18%  perf-profile.children.cycles-pp.unmap_region
      0.31 ± 27%      +0.1        0.46 ± 12%  perf-profile.children.cycles-pp.alloc_empty_file
      0.30 ± 28%      +0.2        0.45 ± 12%  perf-profile.children.cycles-pp.__alloc_file
      0.45 ± 17%      +0.2        0.62 ± 10%  perf-profile.children.cycles-pp.memcpy_erms
      0.34 ±  6%      +0.2        0.58 ±  4%  perf-profile.children.cycles-pp.link_path_walk
      0.79 ±  9%      +0.4        1.21        perf-profile.children.cycles-pp.creat
      1.25 ± 13%      +0.5        1.72 ±  7%  perf-profile.children.cycles-pp.do_sys_open
      1.24 ± 13%      +0.5        1.71 ±  7%  perf-profile.children.cycles-pp.do_sys_openat2
      1.08 ± 16%      +0.5        1.61 ±  8%  perf-profile.children.cycles-pp.do_filp_open
      1.07 ± 16%      +0.5        1.61 ±  8%  perf-profile.children.cycles-pp.path_openat
      1.78 ±  4%      -0.1        1.65 ±  2%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.52 ±  6%      -0.1        0.44 ± 10%  perf-profile.self.cycles-pp.native_sched_clock
      0.35 ±  9%      -0.1        0.27 ±  6%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.20 ± 15%      -0.0        0.15 ± 17%  perf-profile.self.cycles-pp.rcu_eqs_enter
      0.09 ±  8%      -0.0        0.06 ± 20%  perf-profile.self.cycles-pp.down_write_killable
      0.28 ±  3%      +0.0        0.30 ±  3%  perf-profile.self.cycles-pp.copy_page
      0.15 ± 11%      +0.0        0.19 ±  9%  perf-profile.self.cycles-pp.menu_reflect
      0.13 ± 12%      +0.0        0.17 ± 11%  perf-profile.self.cycles-pp.__might_sleep
      0.04 ± 59%      +0.0        0.08 ± 13%  perf-profile.self.cycles-pp.local_touch_nmi
      0.08 ± 16%      +0.0        0.12 ± 16%  perf-profile.self.cycles-pp.dup_mm
      0.18 ±  3%      +0.0        0.23 ± 10%  perf-profile.self.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.01 ±173%      +0.0        0.06 ± 16%  perf-profile.self.cycles-pp.step_into
      0.01 ±173%      +0.1        0.07 ± 13%  perf-profile.self.cycles-pp.dput
      0.11 ± 11%      +0.1        0.17 ± 21%  perf-profile.self.cycles-pp.__alloc_file
      0.03 ±100%      +0.1        0.10 ± 18%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.00            +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.path_openat
      0.00            +0.1        0.07 ± 36%  perf-profile.self.cycles-pp.lockref_get
      0.01 ±173%      +0.1        0.10 ± 14%  perf-profile.self.cycles-pp.link_path_walk
      0.17 ± 15%      +0.1        0.27 ± 17%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.33 ± 14%      +0.1        0.43 ± 11%  perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.44 ± 18%      +0.2        0.61 ± 10%  perf-profile.self.cycles-pp.memcpy_erms



***************************************************************************************************
lkp-hsw-ep4: 72 threads Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase/ucode:
  gcc-7/performance/x86_64-rhel-7.6/1/debian-i386-20191205.cgz/30s/lkp-hsw-ep4/shell1/unixbench/0x43

commit: 
  7ef482fa65 ("helper for mount rootwards traversal")
  2aa3847085 ("non-RCU analogue of the previous commit")

7ef482fa65513b18 2aa38470853a65dc9b1b4bd0989 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          1:4          -10%           0:4     perf-profile.children.cycles-pp.error_entry
          1:4           -8%           0:4     perf-profile.self.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
      2112            -4.7%       2013        unixbench.score
    564308            -4.7%     537722        unixbench.workload
      0.00 ± 23%      -0.0        0.00 ±128%  mpstat.cpu.all.soft%
   1052271 ±  6%      -8.8%     960139 ±  3%  numa-meminfo.node1.MemUsed
     12685            -3.5%      12243        vmstat.system.cs
     37232 ±  2%     -11.0%      33143 ±  7%  cpuidle.POLL.time
      8394 ±  6%     -17.4%       6932 ± 14%  cpuidle.POLL.usage
   5530691            -4.0%    5307598        proc-vmstat.numa_hit
   5507387            -4.1%    5284307        proc-vmstat.numa_local
   6085398            -3.2%    5890392        proc-vmstat.pgalloc_normal
   8401553            -4.6%    8013382        proc-vmstat.pgfault
   6068528            -3.2%    5873130        proc-vmstat.pgfree
    125449            -4.7%     119541        proc-vmstat.unevictable_pgs_culled
     22816 ±  3%     +13.0%      25777 ±  2%  slabinfo.filp.active_objs
     23084 ±  3%     +13.1%      26115 ±  2%  slabinfo.filp.num_objs
    960.75 ±  3%     -22.6%     744.00 ±  9%  slabinfo.khugepaged_mm_slot.active_objs
    960.75 ±  3%     -22.6%     744.00 ±  9%  slabinfo.khugepaged_mm_slot.num_objs
    867.00 ±  7%     -19.1%     701.25 ±  6%  slabinfo.mnt_cache.active_objs
    867.00 ±  7%     -19.1%     701.25 ±  6%  slabinfo.mnt_cache.num_objs
      3312 ±  2%      -7.0%       3080 ±  4%  slabinfo.skbuff_head_cache.active_objs
    118.75 ±109%     -71.8%      33.50 ±  3%  interrupts.45:IR-PCI-MSI.1572870-edge.eth0-TxRx-6
     67.75 ± 71%     -47.2%      35.75 ±  6%  interrupts.49:IR-PCI-MSI.1572874-edge.eth0-TxRx-10
     67.75 ± 71%     -47.2%      35.75 ±  6%  interrupts.CPU10.49:IR-PCI-MSI.1572874-edge.eth0-TxRx-10
    116.25 ± 32%    +248.0%     404.50 ± 92%  interrupts.CPU14.NMI:Non-maskable_interrupts
    116.25 ± 32%    +248.0%     404.50 ± 92%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
    104.50 ± 10%    +185.4%     298.25 ± 58%  interrupts.CPU15.NMI:Non-maskable_interrupts
    104.50 ± 10%    +185.4%     298.25 ± 58%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
     20.00 ±135%   +1691.2%     358.25 ± 97%  interrupts.CPU18.RES:Rescheduling_interrupts
     19.00 ±155%   +1234.2%     253.50 ± 74%  interrupts.CPU19.RES:Rescheduling_interrupts
      5409 ± 57%     -81.8%     985.50 ±154%  interrupts.CPU2.RES:Rescheduling_interrupts
    123.50 ± 66%    +190.5%     358.75 ± 45%  interrupts.CPU21.NMI:Non-maskable_interrupts
    123.50 ± 66%    +190.5%     358.75 ± 45%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
      1223 ± 33%     -87.4%     153.75 ± 16%  interrupts.CPU26.NMI:Non-maskable_interrupts
      1223 ± 33%     -87.4%     153.75 ± 16%  interrupts.CPU26.PMI:Performance_monitoring_interrupts
    396.50 ± 50%     -84.2%      62.50 ±136%  interrupts.CPU26.RES:Rescheduling_interrupts
    140.00 ± 49%     -86.1%      19.50 ±161%  interrupts.CPU27.RES:Rescheduling_interrupts
    226.75 ± 36%     -75.9%      54.75 ±146%  interrupts.CPU28.RES:Rescheduling_interrupts
      2.00 ± 35%   +5137.5%     104.75 ± 96%  interrupts.CPU35.RES:Rescheduling_interrupts
    118.75 ±109%     -71.8%      33.50 ±  3%  interrupts.CPU6.45:IR-PCI-MSI.1572870-edge.eth0-TxRx-6
    886.75 ± 62%     -83.6%     145.25 ± 40%  interrupts.CPU61.NMI:Non-maskable_interrupts
    886.75 ± 62%     -83.6%     145.25 ± 40%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
      2033 ± 87%     -94.0%     122.00 ± 29%  interrupts.CPU62.NMI:Non-maskable_interrupts
      2033 ± 87%     -94.0%     122.00 ± 29%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
    383.25 ±  6%     -18.9%     310.75 ± 20%  interrupts.CPU63.CAL:Function_call_interrupts
      1663 ± 83%     -79.7%     338.25 ±125%  interrupts.CPU64.NMI:Non-maskable_interrupts
      1663 ± 83%     -79.7%     338.25 ±125%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
     11.75 ± 60%    +668.1%      90.25 ± 82%  interrupts.CPU70.RES:Rescheduling_interrupts
      4.75 ±100%   +7226.3%     348.00 ±126%  interrupts.CPU71.RES:Rescheduling_interrupts
     10.10 ±  2%      -3.9%       9.70        perf-stat.i.MPKI
 1.174e+09 ±  2%      +3.1%   1.21e+09        perf-stat.i.branch-instructions
     12903            -3.6%      12433        perf-stat.i.context-switches
     95.03            +5.1%      99.84        perf-stat.i.cpu-migrations
 1.628e+09            +2.0%   1.66e+09        perf-stat.i.dTLB-loads
      0.07            -0.0        0.06        perf-stat.i.dTLB-store-miss-rate%
    682816            -5.3%     646904        perf-stat.i.dTLB-store-misses
     44.58            -1.6       42.96        perf-stat.i.iTLB-load-miss-rate%
   1933196            -5.9%    1819284        perf-stat.i.iTLB-load-misses
 5.599e+09            +3.2%  5.776e+09        perf-stat.i.instructions
    128128            -4.7%     122169        perf-stat.i.minor-faults
    128128            -4.7%     122169        perf-stat.i.page-faults
      9.95 ±  2%      -4.1%       9.54        perf-stat.overall.MPKI
      1.07 ±  2%      +0.1        1.13 ±  2%  perf-stat.overall.cache-miss-rate%
      0.07            -0.0        0.07        perf-stat.overall.dTLB-store-miss-rate%
     46.05            -1.7       44.39        perf-stat.overall.iTLB-load-miss-rate%
      2898 ±  2%      +9.6%       3177 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
    623367            +8.6%     676992        perf-stat.overall.path-length
 1.156e+09 ±  2%      +3.1%  1.191e+09        perf-stat.ps.branch-instructions
     12695            -3.6%      12236        perf-stat.ps.context-switches
     93.62            +5.0%      98.30        perf-stat.ps.cpu-migrations
 1.602e+09            +2.0%  1.635e+09        perf-stat.ps.dTLB-loads
    671869            -5.2%     636703        perf-stat.ps.dTLB-store-misses
   1902059            -5.9%    1790579        perf-stat.ps.iTLB-load-misses
 5.512e+09            +3.2%  5.687e+09        perf-stat.ps.instructions
    126065            -4.6%     120234        perf-stat.ps.minor-faults
    126065            -4.6%     120234        perf-stat.ps.page-faults
 3.518e+11            +3.5%   3.64e+11        perf-stat.total.instructions
      0.08 ± 77%   +1455.3%       1.27 ± 32%  sched_debug.cfs_rq:/.exec_clock.avg
      1.76 ± 83%    +334.8%       7.65 ± 13%  sched_debug.cfs_rq:/.exec_clock.max
      0.33 ± 81%    +444.5%       1.80 ± 20%  sched_debug.cfs_rq:/.exec_clock.stddev
     79.11 ± 19%     -54.1%      36.33 ±  8%  sched_debug.cfs_rq:/.load_avg.avg
    245.47 ±  9%     -46.5%     131.38 ± 15%  sched_debug.cfs_rq:/.load_avg.stddev
      0.22 ±  4%     -23.7%       0.17 ± 12%  sched_debug.cfs_rq:/.nr_running.avg
     38.12 ± 36%    -100.0%       0.00        sched_debug.cfs_rq:/.removed.load_avg.avg
      1016          -100.0%       0.00        sched_debug.cfs_rq:/.removed.load_avg.max
    189.36 ± 16%    -100.0%       0.00        sched_debug.cfs_rq:/.removed.load_avg.stddev
      1758 ± 37%    -100.0%       0.00        sched_debug.cfs_rq:/.removed.runnable_sum.avg
     46915          -100.0%       0.00        sched_debug.cfs_rq:/.removed.runnable_sum.max
      8725 ± 17%    -100.0%       0.00        sched_debug.cfs_rq:/.removed.runnable_sum.stddev
     12.59 ± 31%    -100.0%       0.00        sched_debug.cfs_rq:/.removed.util_avg.avg
    461.25 ± 12%    -100.0%       0.00        sched_debug.cfs_rq:/.removed.util_avg.max
     66.79 ± 13%    -100.0%       0.00        sched_debug.cfs_rq:/.removed.util_avg.stddev
     21.75 ± 24%    +470.1%     124.00 ± 97%  sched_debug.cfs_rq:/.runnable_load_avg.max
    406.34 ±  3%     -17.5%     335.40 ±  4%  sched_debug.cfs_rq:/.util_avg.avg
      1601 ±  8%     -28.7%       1142 ± 15%  sched_debug.cfs_rq:/.util_avg.max
     38.27 ± 13%     -20.5%      30.41 ±  5%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    122.11 ±  5%     -12.3%     107.08 ±  2%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    305.21 ± 11%     -24.4%     230.67 ± 18%  sched_debug.cpu.curr->pid.avg
    628.56 ±  5%     -12.2%     551.76 ±  8%  sched_debug.cpu.curr->pid.stddev
      0.15 ±106%  +14411.2%      21.88 ± 37%  sched_debug.cpu.sched_count.avg
      1.50 ±110%  +74800.0%       1123 ± 49%  sched_debug.cpu.sched_count.max
      0.38 ±106%  +34689.3%     131.90 ± 48%  sched_debug.cpu.sched_count.stddev
      0.11 ±109%   +9996.6%      10.95 ± 37%  sched_debug.cpu.sched_goidle.avg
      0.75 ±110%  +74833.3%     562.00 ± 48%  sched_debug.cpu.sched_goidle.max
      0.25 ±107%  +26737.0%      65.98 ± 48%  sched_debug.cpu.sched_goidle.stddev
      0.54 ± 95%   +1267.2%       7.38 ± 40%  sched_debug.cpu.ttwu_count.avg
     14.50 ± 96%   +2300.0%     348.00 ± 47%  sched_debug.cpu.ttwu_count.max
      2.74 ± 96%   +1393.3%      40.98 ± 47%  sched_debug.cpu.ttwu_count.stddev
      0.00       +6.3e+101%       0.63 ± 43%  sched_debug.cpu.ttwu_local.avg
      0.00       +2.3e+103%      22.50 ± 41%  sched_debug.cpu.ttwu_local.max
      0.00       +2.7e+102%       2.67 ± 39%  sched_debug.cpu.ttwu_local.stddev
     36442 ±  3%     -30.4%      25363 ±  6%  softirqs.CPU0.TIMER
     34756 ±  9%     -26.3%      25606 ± 14%  softirqs.CPU1.TIMER
     11044 ± 13%     -21.3%       8692 ± 14%  softirqs.CPU10.SCHED
     35932 ±  2%     -33.6%      23865 ±  5%  softirqs.CPU10.TIMER
     36179 ±  2%     -30.9%      24995 ±  9%  softirqs.CPU11.TIMER
     10270 ±  2%     -10.0%       9243 ±  3%  softirqs.CPU12.SCHED
     36456 ±  2%     -30.8%      25232 ±  5%  softirqs.CPU12.TIMER
     35602 ±  2%     -32.2%      24139 ±  6%  softirqs.CPU13.TIMER
     35575 ±  2%     -31.0%      24540 ±  4%  softirqs.CPU14.TIMER
     35415           -32.3%      23960 ±  5%  softirqs.CPU15.TIMER
     35517           -35.0%      23077 ±  2%  softirqs.CPU17.TIMER
      6380 ± 39%     +51.3%       9653 ±  6%  softirqs.CPU18.SCHED
     23060 ±  6%     +29.7%      29916 ±  8%  softirqs.CPU19.TIMER
     35720 ±  6%     -28.8%      25420 ±  8%  softirqs.CPU2.TIMER
     32311 ±  2%     +46.7%      47397 ± 32%  softirqs.CPU20.RCU
     23904 ± 10%     +27.8%      30560 ±  6%  softirqs.CPU20.TIMER
     23501 ±  8%     +36.0%      31953 ±  6%  softirqs.CPU21.TIMER
     22608 ±  3%     +46.7%      33171 ±  2%  softirqs.CPU22.TIMER
     23305           +42.7%      33259 ±  5%  softirqs.CPU23.TIMER
     22843 ±  3%     +49.7%      34203 ±  7%  softirqs.CPU24.TIMER
      9204 ±  2%     +53.4%      14124 ± 39%  softirqs.CPU25.SCHED
     23512 ±  4%     +41.3%      33230 ±  7%  softirqs.CPU25.TIMER
     24150 ±  7%     +36.7%      33021 ±  7%  softirqs.CPU26.TIMER
     38855 ± 15%     -16.4%      32487        softirqs.CPU27.RCU
     24890 ±  6%     +31.5%      32727 ±  5%  softirqs.CPU27.TIMER
     25568 ±  3%     +25.8%      32176 ±  6%  softirqs.CPU28.TIMER
     24527 ±  4%     +27.6%      31307 ±  9%  softirqs.CPU29.TIMER
     34219 ± 11%     -25.6%      25467 ± 10%  softirqs.CPU3.TIMER
     24054 ±  5%     +29.7%      31205 ± 10%  softirqs.CPU30.TIMER
     24474 ±  5%     +28.8%      31517 ±  9%  softirqs.CPU31.TIMER
     24212 ±  9%     +35.4%      32783 ±  8%  softirqs.CPU32.TIMER
     22566 ±  3%     +42.7%      32199 ±  6%  softirqs.CPU33.TIMER
     22820 ±  3%     +44.4%      32945 ±  6%  softirqs.CPU34.TIMER
     22519 ±  2%     +42.1%      31996 ±  4%  softirqs.CPU35.TIMER
     33493 ±  8%     -34.7%      21857 ±  4%  softirqs.CPU38.TIMER
     33536 ± 10%     -29.2%      23739 ±  7%  softirqs.CPU39.TIMER
     33810 ±  9%     -28.6%      24146 ±  6%  softirqs.CPU4.TIMER
      9957 ±  2%     -23.1%       7654 ± 27%  softirqs.CPU40.SCHED
     34272 ± 11%     -33.5%      22792 ±  3%  softirqs.CPU40.TIMER
     33744 ±  8%     -31.4%      23158 ±  5%  softirqs.CPU41.TIMER
     34812 ±  3%     -32.3%      23569 ±  3%  softirqs.CPU42.TIMER
     35250 ±  3%     -33.7%      23382 ±  5%  softirqs.CPU43.TIMER
     35879 ±  2%     -35.4%      23167 ±  6%  softirqs.CPU44.TIMER
     35357 ±  2%     -34.9%      23011 ±  3%  softirqs.CPU45.TIMER
     36456 ±  5%     -37.3%      22846 ±  4%  softirqs.CPU46.TIMER
     35278           -33.0%      23619 ±  5%  softirqs.CPU47.TIMER
     36160 ±  3%     -34.2%      23794 ±  6%  softirqs.CPU48.TIMER
     35899 ±  3%     -34.9%      23357 ±  4%  softirqs.CPU49.TIMER
     34470 ±  8%     -29.2%      24400 ±  7%  softirqs.CPU5.TIMER
     35181           -35.5%      22690 ±  4%  softirqs.CPU50.TIMER
     35101           -34.7%      22931 ±  3%  softirqs.CPU51.TIMER
     35019           -32.7%      23552 ±  4%  softirqs.CPU52.TIMER
     35153 ±  2%     -36.8%      22224        softirqs.CPU53.TIMER
     22760 ±  3%     +28.4%      29220 ± 10%  softirqs.CPU55.TIMER
     22193 ±  2%     +35.2%      30004 ±  8%  softirqs.CPU56.TIMER
     22053 ±  3%     +41.9%      31299 ±  6%  softirqs.CPU57.TIMER
     22491 ±  5%     +44.1%      32413 ±  5%  softirqs.CPU58.TIMER
     22325 ±  2%     +49.1%      33277 ±  7%  softirqs.CPU59.TIMER
     35445 ±  3%     -34.5%      23209 ±  3%  softirqs.CPU6.TIMER
     22294 ±  2%     +48.4%      33094 ±  7%  softirqs.CPU60.TIMER
     22705 ±  4%     +44.4%      32779 ±  6%  softirqs.CPU61.TIMER
     23634 ±  6%     +37.9%      32591 ±  7%  softirqs.CPU62.TIMER
     23637 ±  4%     +36.8%      32337 ±  6%  softirqs.CPU63.TIMER
     11293 ± 10%     -19.4%       9105 ±  6%  softirqs.CPU64.SCHED
     23853 ±  5%     +32.1%      31518 ±  7%  softirqs.CPU64.TIMER
     23533 ±  3%     +31.3%      30895 ±  9%  softirqs.CPU65.TIMER
     22470           +40.0%      31448 ±  7%  softirqs.CPU68.TIMER
     22085           +45.0%      32032 ±  6%  softirqs.CPU69.TIMER
     35869 ±  2%     -34.8%      23374 ±  3%  softirqs.CPU7.TIMER
     31726           +28.6%      40786 ± 20%  softirqs.CPU71.RCU
     21729 ±  2%     +50.6%      32716 ±  8%  softirqs.CPU71.TIMER
     35379 ±  2%     -33.3%      23605 ±  4%  softirqs.CPU8.TIMER
      3.45 ±  3%      -0.5        2.97 ± 10%  perf-profile.calltrace.cycles-pp.__ia32_compat_sys_execve.do_fast_syscall_32.entry_SYSENTER_compat
      3.43 ±  3%      -0.5        2.96 ± 10%  perf-profile.calltrace.cycles-pp.__do_execve_file.__ia32_compat_sys_execve.do_fast_syscall_32.entry_SYSENTER_compat
      2.15 ±  4%      -0.4        1.71 ± 14%  perf-profile.calltrace.cycles-pp.__ia32_sys_exit_group.do_fast_syscall_32.entry_SYSENTER_compat
      2.15 ±  4%      -0.4        1.71 ± 14%  perf-profile.calltrace.cycles-pp.do_group_exit.__ia32_sys_exit_group.do_fast_syscall_32.entry_SYSENTER_compat
      2.14 ±  4%      -0.4        1.71 ± 14%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__ia32_sys_exit_group.do_fast_syscall_32.entry_SYSENTER_compat
      2.46 ±  7%      -0.4        2.11 ± 10%  perf-profile.calltrace.cycles-pp.page_fault
      2.30 ±  7%      -0.3        1.96 ± 10%  perf-profile.calltrace.cycles-pp.do_page_fault.page_fault
      1.51 ±  4%      -0.3        1.23 ± 15%  perf-profile.calltrace.cycles-pp.mmput.do_exit.do_group_exit.__ia32_sys_exit_group.do_fast_syscall_32
      1.91 ±  5%      -0.3        1.63 ±  9%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_page_fault.page_fault
      1.98 ±  6%      -0.3        1.70 ± 10%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_page_fault.page_fault
      1.50 ±  4%      -0.3        1.23 ± 16%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.do_exit.do_group_exit.__ia32_sys_exit_group
      1.78 ±  5%      -0.3        1.52 ± 10%  perf-profile.calltrace.cycles-pp.handle_pte_fault.__handle_mm_fault.handle_mm_fault.do_page_fault.page_fault
      0.94 ±  6%      -0.2        0.77 ± 13%  perf-profile.calltrace.cycles-pp._dl_addr
      0.96 ±  5%      -0.1        0.81 ± 11%  perf-profile.calltrace.cycles-pp.flush_old_exec.load_elf_binary.search_binary_handler.__do_execve_file.__ia32_compat_sys_execve
      0.88 ±  4%      -0.1        0.74 ± 11%  perf-profile.calltrace.cycles-pp.mmput.flush_old_exec.load_elf_binary.search_binary_handler.__do_execve_file
      0.82 ±  6%      -0.1        0.68 ± 14%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.mmput.do_exit.do_group_exit
      0.87 ±  4%      -0.1        0.74 ± 10%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.flush_old_exec.load_elf_binary.search_binary_handler
      1.30 ±  6%      +0.2        1.54 ±  9%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_int80_syscall_32
      1.31 ±  6%      +0.2        1.56 ±  9%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_int80_syscall_32.entry_INT80_compat
      0.44 ± 58%      +0.3        0.73 ± 19%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_fast_syscall_32.entry_SYSENTER_compat.setlocale
      5.40 ±  4%      +0.5        5.88 ±  3%  perf-profile.calltrace.cycles-pp.irq_exit.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.13 ±173%      +0.5        0.64 ± 18%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_fast_syscall_32
      0.13 ±173%      +0.5        0.65 ± 18%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_fast_syscall_32.entry_SYSENTER_compat
      3.99 ±  7%      +0.5        4.54 ±  5%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.irq_exit.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state
      4.34 ±  5%      -0.6        3.75 ± 10%  perf-profile.children.cycles-pp.page_fault
      3.99 ±  5%      -0.5        3.44 ± 10%  perf-profile.children.cycles-pp.do_page_fault
      3.56 ±  5%      -0.5        3.06 ±  9%  perf-profile.children.cycles-pp.handle_mm_fault
      3.42 ±  5%      -0.5        2.93 ±  9%  perf-profile.children.cycles-pp.__handle_mm_fault
      3.15 ±  5%      -0.5        2.67 ±  9%  perf-profile.children.cycles-pp.handle_pte_fault
      2.45 ±  4%      -0.4        2.02 ± 13%  perf-profile.children.cycles-pp.mmput
      2.16 ±  4%      -0.4        1.73 ± 14%  perf-profile.children.cycles-pp.__ia32_sys_exit_group
      2.16 ±  4%      -0.4        1.73 ± 14%  perf-profile.children.cycles-pp.do_group_exit
      2.16 ±  4%      -0.4        1.73 ± 14%  perf-profile.children.cycles-pp.do_exit
      2.42 ±  4%      -0.4        2.00 ± 13%  perf-profile.children.cycles-pp.exit_mmap
      1.39 ±  4%      -0.2        1.14 ± 14%  perf-profile.children.cycles-pp.unmap_vmas
      1.28 ± 10%      -0.2        1.03 ±  9%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      1.33 ±  5%      -0.2        1.08 ± 14%  perf-profile.children.cycles-pp.unmap_page_range
      1.16 ±  9%      -0.2        0.94 ± 10%  perf-profile.children.cycles-pp.do_mmap
      1.03 ± 13%      -0.2        0.82 ± 12%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.99 ±  7%      -0.2        0.79 ±  9%  perf-profile.children.cycles-pp.mmap_region
      0.95 ±  6%      -0.2        0.78 ± 13%  perf-profile.children.cycles-pp._dl_addr
      1.02 ±  6%      -0.2        0.86 ± 11%  perf-profile.children.cycles-pp.flush_old_exec
      0.67 ±  6%      -0.2        0.52 ± 19%  perf-profile.children.cycles-pp.alloc_set_pte
      0.52 ±  9%      -0.1        0.41 ± 15%  perf-profile.children.cycles-pp.__strcoll_l
      0.57 ±  6%      -0.1        0.45 ±  9%  perf-profile.children.cycles-pp.copy_strings
      0.44 ±  4%      -0.1        0.35 ±  6%  perf-profile.children.cycles-pp.perf_event_mmap
      0.41 ±  6%      -0.1        0.32 ±  8%  perf-profile.children.cycles-pp.free_pgtables
      0.24 ±  6%      -0.1        0.15 ± 17%  perf-profile.children.cycles-pp.unlock_page
      0.31 ± 11%      -0.1        0.23 ±  9%  perf-profile.children.cycles-pp.vma_link
      0.21 ± 17%      -0.1        0.12 ± 12%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.26 ±  4%      -0.1        0.18 ± 24%  perf-profile.children.cycles-pp.malloc
      0.35 ±  7%      -0.1        0.28 ± 21%  perf-profile.children.cycles-pp.__ia32_sys_mprotect
      0.35 ±  7%      -0.1        0.28 ± 20%  perf-profile.children.cycles-pp.do_mprotect_pkey
      0.24 ± 12%      -0.1        0.18 ± 17%  perf-profile.children.cycles-pp.simple_lookup
      0.23 ± 10%      -0.1        0.17 ±  4%  perf-profile.children.cycles-pp.idle_cpu
      0.24 ± 12%      -0.1        0.18 ± 18%  perf-profile.children.cycles-pp.enqueue_entity
      0.20 ±  7%      -0.1        0.14 ± 16%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.26 ± 12%      -0.1        0.20 ± 18%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.23 ± 11%      -0.1        0.17 ± 15%  perf-profile.children.cycles-pp.strnlen_user
      0.27            -0.1        0.22 ± 10%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.11 ± 13%      -0.1        0.06 ± 62%  perf-profile.children.cycles-pp.sched_move_task
      0.20 ± 10%      -0.1        0.15 ± 20%  perf-profile.children.cycles-pp.schedule_tail
      0.13 ± 11%      -0.1        0.08 ± 28%  perf-profile.children.cycles-pp.__d_lookup_done
      0.12 ± 15%      -0.0        0.07 ± 30%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.16 ± 24%      -0.0        0.12 ± 21%  perf-profile.children.cycles-pp.do_notify_parent
      0.15 ± 10%      -0.0        0.10 ± 10%  perf-profile.children.cycles-pp.copy_strings_kernel
      0.12 ± 21%      -0.0        0.08 ± 30%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.09 ± 15%      -0.0        0.05 ± 64%  perf-profile.children.cycles-pp.copy_user_generic_unrolled
      0.08 ± 10%      -0.0        0.04 ± 58%  perf-profile.children.cycles-pp.count
      0.15 ± 16%      -0.0        0.12 ± 17%  perf-profile.children.cycles-pp.get_unmapped_area
      0.10 ± 15%      -0.0        0.07 ± 17%  perf-profile.children.cycles-pp.strncasecmp
      0.12 ±  7%      -0.0        0.08 ± 21%  perf-profile.children.cycles-pp.up_write
      0.07 ±  7%      -0.0        0.04 ± 58%  perf-profile.children.cycles-pp.queue_work_on
      0.20 ±  3%      -0.0        0.18 ±  6%  perf-profile.children.cycles-pp.sched_exec
      0.09 ± 13%      -0.0        0.07        perf-profile.children.cycles-pp.generic_perform_write
      0.22 ±  5%      +0.0        0.25 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.04 ± 60%      +0.0        0.09 ± 10%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.29 ±  8%      +0.0        0.33 ±  6%  perf-profile.children.cycles-pp.__fput
      0.05 ± 62%      +0.0        0.10 ± 15%  perf-profile.children.cycles-pp.security_file_free
      0.14 ±  6%      +0.1        0.19 ± 20%  perf-profile.children.cycles-pp.do_open_execat
      0.12 ± 11%      +0.1        0.17 ± 15%  perf-profile.children.cycles-pp.trigger_load_balance
      0.10 ± 23%      +0.1        0.18 ± 18%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.00            +0.1        0.09 ± 28%  perf-profile.children.cycles-pp.lockref_get
      0.47 ±  9%      +0.1        0.58 ±  9%  perf-profile.children.cycles-pp.step_into
      0.03 ±100%      +0.1        0.15 ± 24%  perf-profile.children.cycles-pp.set_root
      0.43 ±  5%      +0.1        0.56 ±  5%  perf-profile.children.cycles-pp.task_work_run
      0.07 ± 36%      +0.1        0.19 ± 26%  perf-profile.children.cycles-pp.nd_jump_root
      0.33 ± 11%      +0.1        0.47 ± 12%  perf-profile.children.cycles-pp.rcu_do_batch
      0.12 ± 28%      +0.1        0.26 ± 23%  perf-profile.children.cycles-pp.path_init
      0.17 ± 20%      +0.1        0.31 ± 19%  perf-profile.children.cycles-pp.security_file_alloc
      0.63 ±  7%      +0.2        0.80 ± 13%  perf-profile.children.cycles-pp.path_lookupat
      0.56 ±  7%      +0.2        0.73 ± 13%  perf-profile.children.cycles-pp.__do_compat_sys_x86_stat64
      0.56 ±  7%      +0.2        0.73 ± 13%  perf-profile.children.cycles-pp.vfs_statx
      0.40 ±  2%      +0.2        0.58 ±  7%  perf-profile.children.cycles-pp.exit_to_usermode_loop
      0.00            +0.2        0.18 ± 30%  perf-profile.children.cycles-pp.__d_lookup
      0.64 ±  5%      +0.2        0.82 ± 14%  perf-profile.children.cycles-pp.filename_lookup
      1.26 ±  5%      +0.2        1.46 ± 11%  perf-profile.children.cycles-pp.link_path_walk
      0.44 ± 11%      +0.3        0.74 ± 12%  perf-profile.children.cycles-pp.__alloc_file
      0.45 ± 11%      +0.3        0.77 ± 12%  perf-profile.children.cycles-pp.alloc_empty_file
      5.69 ±  3%      +0.5        6.21 ±  3%  perf-profile.children.cycles-pp.irq_exit
      2.09 ±  6%      +0.5        2.62 ± 11%  perf-profile.children.cycles-pp.do_filp_open
      2.07 ±  6%      +0.5        2.60 ± 11%  perf-profile.children.cycles-pp.path_openat
      4.35 ±  6%      +0.6        4.99 ±  5%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.45 ± 37%      -0.3        0.18 ± 31%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.93 ±  7%      -0.2        0.75 ± 12%  perf-profile.self.cycles-pp._dl_addr
      0.61 ±  9%      -0.1        0.47 ± 11%  perf-profile.self.cycles-pp.unmap_page_range
      0.52 ±  9%      -0.1        0.40 ± 15%  perf-profile.self.cycles-pp.__strcoll_l
      0.71 ±  6%      -0.1        0.60 ±  5%  perf-profile.self.cycles-pp.do_int80_syscall_32
      0.33 ± 11%      -0.1        0.24 ±  9%  perf-profile.self.cycles-pp.entry_SYSENTER_compat
      0.28 ±  8%      -0.1        0.19 ± 25%  perf-profile.self.cycles-pp.entry_INT80_compat
      0.23 ±  5%      -0.1        0.15 ± 16%  perf-profile.self.cycles-pp.unlock_page
      0.33 ±  7%      -0.1        0.25 ± 20%  perf-profile.self.cycles-pp.page_add_file_rmap
      0.20 ±  7%      -0.1        0.14 ± 16%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.22 ± 11%      -0.1        0.17 ±  4%  perf-profile.self.cycles-pp.idle_cpu
      0.71 ±  3%      -0.1        0.66 ±  7%  perf-profile.self.cycles-pp.prepare_exit_to_usermode
      0.22 ±  8%      -0.1        0.17 ± 17%  perf-profile.self.cycles-pp.strnlen_user
      0.11 ± 17%      -0.0        0.06 ± 58%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.11 ±  9%      -0.0        0.08 ± 19%  perf-profile.self.cycles-pp.do_page_fault
      0.11 ±  9%      -0.0        0.08 ± 19%  perf-profile.self.cycles-pp.up_write
      0.07 ±  5%      +0.0        0.09 ±  8%  perf-profile.self.cycles-pp.account_process_tick
      0.21 ±  5%      +0.0        0.23 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.04 ± 60%      +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.05 ± 61%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.step_into
      0.06 ± 14%      +0.0        0.10 ± 24%  perf-profile.self.cycles-pp.file_free_rcu
      0.11 ± 14%      +0.0        0.16 ± 15%  perf-profile.self.cycles-pp.trigger_load_balance
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.walk_component
      0.28 ± 12%      +0.1        0.34 ± 12%  perf-profile.self.cycles-pp.__softirqentry_text_start
      0.10 ± 13%      +0.1        0.17 ± 14%  perf-profile.self.cycles-pp.link_path_walk
      0.00            +0.1        0.09 ± 26%  perf-profile.self.cycles-pp.lockref_get
      0.13 ± 14%      +0.1        0.23 ± 11%  perf-profile.self.cycles-pp.__alloc_file





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Rong Chen


--oOpJzULQ70+PGW7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.6.0-rc1-00054-g2aa38470853a6"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.6.0-rc1 Kernel Configuration
#

#
# Compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70500
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
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
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
CONFIG_CGROUP_BPF=y
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
CONFIG_BOOT_CONFIG=y
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
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
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

CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
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
CONFIG_MPTCP=y
CONFIG_MPTCP_IPV6=y
# CONFIG_MPTCP_HMAC_TEST is not set
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
# CONFIG_NET_ACT_CT is not set
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
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
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
# CONFIG_MDIO_THUNDER is not set
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
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
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
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
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
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_SPIN_REQUEST=5
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
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
# CONFIG_DRM_GM12U320 is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
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
CONFIG_SND_HDA_PREALLOC_SIZE=0
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
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
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
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
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
# CONFIG_PI433 is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# end of Gasket devices

# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set
CONFIG_USB_WUSB=m
CONFIG_USB_WUSB_CBAF=m
# CONFIG_USB_WUSB_CBAF_DEBUG is not set
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=m
CONFIG_UWB=m
CONFIG_UWB_HWA=m
CONFIG_UWB_WHCI=m
CONFIG_UWB_I1480U=m
# CONFIG_STAGING_EXFAT_FS is not set
CONFIG_QLGE=m
# CONFIG_NET_VENDOR_HP is not set
# CONFIG_WFX is not set
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
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

# CONFIG_SYSTEM76_ACPI is not set
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
# CONFIG_TEE is not set
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
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
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
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"

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
CONFIG_CRYPTO_DEV_CCP_DD=m
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
CONFIG_LIBXBC=y
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
# CONFIG_DEBUG_INFO_BTF is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_OPTIMIZE_INLINING=y
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
CONFIG_DEBUG_FS=y
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_UBSAN_ALIGNMENT=y
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
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
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
CONFIG_WW_MUTEX_SELFTEST=m
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
CONFIG_BOOTTIME_TRACING=y
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
# CONFIG_UNWINDER_GUESS is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
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
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
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
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--oOpJzULQ70+PGW7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='will-it-scale'
	export testcase='will-it-scale'
	export category='benchmark'
	export job_origin='/lkp/lkp/.src-20200402-081120/allot/cyclic:p1:linux-devel:devel-hourly/lkp-ivb-d04/will-it-scale.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-ivb-d04'
	export tbox_group='lkp-ivb-d04'
	export submit_id='5e88cd2385893f3e3c7fdd8a'
	export job_file='/lkp/jobs/scheduled/lkp-ivb-d04/will-it-scale-performance-open2-ucode=0x21-debian-x86_64-20191114.cgz-2aa38470853a65dc9b1b4bd0989d34cd3fc57ebd-20200405-15932-1wb01jm-3.yaml'
	export id='b036264a2ab5208f70181dfaa0db9fd5e13e6573'
	export queuer_version='/lkp-src'
	export model='Ivy Bridge'
	export nr_node=1
	export nr_cpu=4
	export memory='4G'
	export nr_hdd_partitions=0
	export hdd_partitions=
	export rootfs_partition='/dev/disk/by-id/ata-WDC_WD20EZRX-00D8PB0_WD-WCC4M0KTT6NK-part1'
	export brand='Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz'
	export commit='2aa38470853a65dc9b1b4bd0989d34cd3fc57ebd'
	export netconsole_port=6675
	export ucode='0x21'
	export need_kconfig_hw='CONFIG_R8169=y
CONFIG_SATA_AHCI'
	export kconfig='x86_64-rhel-7.6'
	export compiler='gcc-7'
	export enqueue_time='2020-04-05 02:08:39 +0800'
	export _id='5e88cd2785893f3e3c7fdd8b'
	export _rt='/result/will-it-scale/performance-open2-ucode=0x21/lkp-ivb-d04/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/2aa38470853a65dc9b1b4bd0989d34cd3fc57ebd'
	export user='lkp'
	export head_commit='bcbe5ecf098072589d5819132db25071453452f6'
	export base_commit='7111951b8d4973bda27ff663f2cf18b663d15b48'
	export branch='linux-devel/devel-hourly-2020040319'
	export rootfs='debian-x86_64-20191114.cgz'
	export result_root='/result/will-it-scale/performance-open2-ucode=0x21/lkp-ivb-d04/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/2aa38470853a65dc9b1b4bd0989d34cd3fc57ebd/3'
	export scheduler_version='/lkp/lkp/.src-20200404-231707'
	export LKP_SERVER='inn'
	export arch='x86_64'
	export max_uptime=1500
	export initrd='/osimage/debian/debian-x86_64-20191114.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-ivb-d04/will-it-scale-performance-open2-ucode=0x21-debian-x86_64-20191114.cgz-2aa38470853a65dc9b1b4bd0989d34cd3fc57ebd-20200405-15932-1wb01jm-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.6
branch=linux-devel/devel-hourly-2020040319
commit=2aa38470853a65dc9b1b4bd0989d34cd3fc57ebd
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/2aa38470853a65dc9b1b4bd0989d34cd3fc57ebd/vmlinuz-5.6.0-rc1-00054-g2aa38470853a6
max_uptime=1500
RESULT_ROOT=/result/will-it-scale/performance-open2-ucode=0x21/lkp-ivb-d04/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/2aa38470853a65dc9b1b4bd0989d34cd3fc57ebd/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-7.6/gcc-7/2aa38470853a65dc9b1b4bd0989d34cd3fc57ebd/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-20180403.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/lkp_2019-08-05.cgz,/osimage/deps/debian-x86_64-20180403.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/will-it-scale_2020-01-07.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/will-it-scale-x86_64-1eef89e-1_2020-01-07.cgz,/osimage/deps/debian-x86_64-20180403.cgz/mpstat_2020-01-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/vmstat_2020-01-07.cgz,/osimage/deps/debian-x86_64-20180403.cgz/perf_20200325.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/perf-x86_64-76ccd234269b-1_20200325.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/sar-x86_64-e011d97-1_2020-01-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/hw_2020-01-02.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.6.0'
	export repeat_to=4
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-7.6/gcc-7/2aa38470853a65dc9b1b4bd0989d34cd3fc57ebd/vmlinuz-5.6.0-rc1-00054-g2aa38470853a6'
	export dequeue_time='2020-04-05 02:19:16 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-ivb-d04/will-it-scale-performance-open2-ucode=0x21-debian-x86_64-20191114.cgz-2aa38470853a65dc9b1b4bd0989d34cd3fc57ebd-20200405-15932-1wb01jm-3.cgz'

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

	run_test test='open2' $LKP_SRC/tests/wrapper will-it-scale
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

--oOpJzULQ70+PGW7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/will-it-scale.yaml
suite: will-it-scale
testcase: will-it-scale
category: benchmark
will-it-scale:
  test: open2
job_origin: "/lkp/lkp/.src-20200402-081120/allot/cyclic:p1:linux-devel:devel-hourly/lkp-ivb-d04/will-it-scale.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-ivb-d04
tbox_group: lkp-ivb-d04
submit_id: 5e88c33127aa2cfd2d4f2f02
job_file: "/lkp/jobs/scheduled/lkp-ivb-d04/will-it-scale-performance-open2-ucode=0x21-debian-x86_64-20191114.cgz-2aa38470853a65dc9b1b4bd0989d34cd3fc57ebd-20200405-64813-t0bbta-0.yaml"
id: 725ab2b040e4f1523890da2d1c0892a1c5261e3a
queuer_version: "/lkp-src"

#! hosts/lkp-ivb-d04
model: Ivy Bridge
nr_node: 1
nr_cpu: 4
memory: 4G
nr_hdd_partitions: 0
hdd_partitions: 
rootfs_partition: "/dev/disk/by-id/ata-WDC_WD20EZRX-00D8PB0_WD-WCC4M0KTT6NK-part1"
brand: Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz

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
commit: 2aa38470853a65dc9b1b4bd0989d34cd3fc57ebd

#! include/testbox/lkp-ivb-d04
netconsole_port: 6675
ucode: '0x21'
need_kconfig_hw:
- CONFIG_R8169=y
- CONFIG_SATA_AHCI

#! default params
kconfig: x86_64-rhel-7.6
compiler: gcc-7
enqueue_time: 2020-04-05 01:26:13.142997832 +08:00
_id: 5e88c33127aa2cfd2d4f2f02
_rt: "/result/will-it-scale/performance-open2-ucode=0x21/lkp-ivb-d04/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/2aa38470853a65dc9b1b4bd0989d34cd3fc57ebd"

#! schedule options
user: lkp
head_commit: bcbe5ecf098072589d5819132db25071453452f6
base_commit: 7111951b8d4973bda27ff663f2cf18b663d15b48
branch: linux-devel/devel-hourly-2020040319
rootfs: debian-x86_64-20191114.cgz
result_root: "/result/will-it-scale/performance-open2-ucode=0x21/lkp-ivb-d04/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/2aa38470853a65dc9b1b4bd0989d34cd3fc57ebd/0"
scheduler_version: "/lkp/lkp/.src-20200404-231707"
LKP_SERVER: inn
arch: x86_64
max_uptime: 1500
initrd: "/osimage/debian/debian-x86_64-20191114.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-ivb-d04/will-it-scale-performance-open2-ucode=0x21-debian-x86_64-20191114.cgz-2aa38470853a65dc9b1b4bd0989d34cd3fc57ebd-20200405-64813-t0bbta-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-7.6
- branch=linux-devel/devel-hourly-2020040319
- commit=2aa38470853a65dc9b1b4bd0989d34cd3fc57ebd
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/2aa38470853a65dc9b1b4bd0989d34cd3fc57ebd/vmlinuz-5.6.0-rc1-00054-g2aa38470853a6
- max_uptime=1500
- RESULT_ROOT=/result/will-it-scale/performance-open2-ucode=0x21/lkp-ivb-d04/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/2aa38470853a65dc9b1b4bd0989d34cd3fc57ebd/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-7.6/gcc-7/2aa38470853a65dc9b1b4bd0989d34cd3fc57ebd/modules.cgz"
bm_initrd: "/osimage/deps/debian-x86_64-20180403.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/lkp_2019-08-05.cgz,/osimage/deps/debian-x86_64-20180403.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/will-it-scale_2020-01-07.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/will-it-scale-x86_64-1eef89e-1_2020-01-07.cgz,/osimage/deps/debian-x86_64-20180403.cgz/mpstat_2020-01-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/vmstat_2020-01-07.cgz,/osimage/deps/debian-x86_64-20180403.cgz/perf_20200325.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/perf-x86_64-76ccd234269b-1_20200325.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/sar-x86_64-e011d97-1_2020-01-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/hw_2020-01-02.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20200403-112930/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.6.0-wt-13023-gea951f49c35c0
repeat_to: 2
schedule_notify_address: 

#! user overrides
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-7.6/gcc-7/2aa38470853a65dc9b1b4bd0989d34cd3fc57ebd/vmlinuz-5.6.0-rc1-00054-g2aa38470853a6"
dequeue_time: 2020-04-05 01:54:54.502393303 +08:00

#! /lkp/lkp/.src-20200404-231707/include/site/inn
job_state: finished
loadavg: 3.36 1.93 0.83 1/140 5205
start_time: '1586022946'
end_time: '1586023250'
version: "/lkp/lkp/.src-20200404-231737:7ff622c6-dirty:a3467df8e"

--oOpJzULQ70+PGW7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

 "python2" "./runtest.py" "open2" "32" "both" "1" "2" "3" "4"

--oOpJzULQ70+PGW7h--
