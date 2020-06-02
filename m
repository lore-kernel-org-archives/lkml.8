Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9985AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 03:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73BA52072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 03:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgFBDhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 23:37:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:38035 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgFBDhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 23:37:31 -0400
IronPort-SDR: SRLfei3ExG7R50hPtn63+RIEwJpJeFzh1SXb/lzIiNmwEhYb3KpOtR5/wDJXeYf5T9jvxVtKOH
 Lsx4R0dz2MWw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 20:37:28 -0700
IronPort-SDR: mkc3HWQNX/rWdothBNUFM1JML2EZE5uPnNW/Qj71bE7jTutMNSueC//cIras36U/+VOPFhjfk5
 pQfRrvR5AyWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,462,1583222400"; 
   d="scan'208";a="444523756"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by orsmga005.jf.intel.com with ESMTP; 01 Jun 2020 20:37:24 -0700
Date:   Tue, 2 Jun 2020 11:37:23 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Konstantin Khlebnikov <koct9i@gmail.com>
Subject: Re: [PATCH v4 3/4] mm/util.c: remove the VM_WARN_ONCE for
 vm_committed_as underflow check
Message-ID: <20200602033723.GA48154@shbuild999.sh.intel.com>
References: <1590714370-67182-1-git-send-email-feng.tang@intel.com>
 <1590714370-67182-4-git-send-email-feng.tang@intel.com>
 <20200529024928.GA4566@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200529024928.GA4566@lca.pw>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

On Thu, May 28, 2020 at 10:49:28PM -0400, Qian Cai wrote:
> On Fri, May 29, 2020 at 09:06:09AM +0800, Feng Tang wrote:
> > As is explained by Michal Hocko:
> > 
> > : Looking at the history, this has been added by 82f71ae4a2b8
> > : ("mm: catch memory commitment underflow") to have a safety check
> > : for issues which have been fixed. There doesn't seem to be any bug
> > : reports mentioning this splat since then so it is likely just
> > : spending cycles for a hot path (yes many people run with DEBUG_VM)
> > : without a strong reason.
> 
> Hmm, it looks like the warning is still useful to catch issues in,
> 
> https://lore.kernel.org/linux-mm/20140624201606.18273.44270.stgit@zurg
> https://lore.kernel.org/linux-mm/54BB9A32.7080703@oracle.com/
> 
> After read the whole discussion in that thread, I actually disagree with
> Michal. In order to get ride of this existing warning, it is rather
> someone needs a strong reason that could prove the performance hit is
> noticeable with some data.

I re-run the same benchmark with v5.7 and 5.7+remove_warning kernels,
the overall performance change is trivial (which is expected)

   1330147            +0.1%    1331032        will-it-scale.72.processes

But the perf stats of "self" shows big change for __vm_enough_memory() 

      0.27            -0.3        0.00        pp.self.__vm_enough_memory

I post the full compare result in the end.

Thanks,
Feng


=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/nr_task/mode/test/cpufreq_governor/ucode:
  lkp-skl-2sp7/will-it-scale/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-vm-debug/gcc-7/100%/process/mmap2/performance/0x2000065

commit: 
  v5.7
  af3eca72dc43078e1ee4a38b0ecc0225b659f345

            v5.7 af3eca72dc43078e1ee4a38b0ec 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
        850:3       -12130%         486:2     dmesg.timestamp:last
          2:3          -67%            :2     kmsg.Firmware_Bug]:the_BIOS_has_corrupted_hw-PMU_resources(MSR#is#bb)
           :3           33%           1:2     kmsg.Firmware_Bug]:the_BIOS_has_corrupted_hw-PMU_resources(MSR#is#e08)
          5:3         -177%            :2     kmsg.timestamp:Firmware_Bug]:the_BIOS_has_corrupted_hw-PMU_resources(MSR#is#bb)
           :3           88%           2:2     kmsg.timestamp:Firmware_Bug]:the_BIOS_has_corrupted_hw-PMU_resources(MSR#is#e08)
        398:3        -4444%         265:2     kmsg.timestamp:last
         %stddev     %change         %stddev
             \          |                \  
   1330147            +0.1%    1331032        will-it-scale.72.processes
      0.02            +0.0%       0.02        will-it-scale.72.processes_idle
     18474            +0.1%      18486        will-it-scale.per_process_ops
    301.18            -0.0%     301.16        will-it-scale.time.elapsed_time
    301.18            -0.0%     301.16        will-it-scale.time.elapsed_time.max
      1.00 ± 81%    +100.0%       2.00        will-it-scale.time.involuntary_context_switches
      9452            +0.0%       9452        will-it-scale.time.maximum_resident_set_size
      5925            +0.1%       5932        will-it-scale.time.minor_page_faults
      4096            +0.0%       4096        will-it-scale.time.page_size
      0.01 ± 35%     +12.5%       0.01 ± 33%  will-it-scale.time.system_time
      0.03 ± 14%      +5.0%       0.04 ± 14%  will-it-scale.time.user_time
     83.33            +0.2%      83.50        will-it-scale.time.voluntary_context_switches
   1330147            +0.1%    1331032        will-it-scale.workload
      0.45 ± 29%      +0.0        0.50 ± 28%  mpstat.cpu.all.idle%
     98.41            -0.1       98.34        mpstat.cpu.all.sys%
      1.14            +0.0        1.16        mpstat.cpu.all.usr%
    200395 ± 18%     +11.9%     224282 ± 14%  cpuidle.C1.time
      4008 ± 38%      -2.1%       3924 ± 15%  cpuidle.C1.usage
 1.222e+08 ± 19%     -29.2%   86444161        cpuidle.C1E.time
    254203 ± 19%     -23.2%     195198 ±  4%  cpuidle.C1E.usage
   8145747 ± 31%    +339.9%   35830338 ± 72%  cpuidle.C6.time
     22878 ±  9%    +288.2%      88823 ± 70%  cpuidle.C6.usage
      8891 ±  7%      -7.4%       8229        cpuidle.POLL.time
      3111 ± 18%     -11.1%       2766        cpuidle.POLL.usage
      0.00          -100.0%       0.00        numa-numastat.node0.interleave_hit
    314399 ±  2%      -1.0%     311244 ±  3%  numa-numastat.node0.local_node
    322209            +2.4%     329909        numa-numastat.node0.numa_hit
      7814 ± 73%    +138.9%      18670 ± 24%  numa-numastat.node0.other_node
      0.00          -100.0%       0.00        numa-numastat.node1.interleave_hit
    343026 ±  2%      -0.3%     341980        numa-numastat.node1.local_node
    358632            -3.3%     346708        numa-numastat.node1.numa_hit
     15613 ± 36%     -69.7%       4728 ± 98%  numa-numastat.node1.other_node
    301.18            -0.0%     301.16        time.elapsed_time
    301.18            -0.0%     301.16        time.elapsed_time.max
      1.00 ± 81%    +100.0%       2.00        time.involuntary_context_switches
      9452            +0.0%       9452        time.maximum_resident_set_size
      5925            +0.1%       5932        time.minor_page_faults
      4096            +0.0%       4096        time.page_size
      0.01 ± 35%     +12.5%       0.01 ± 33%  time.system_time
      0.03 ± 14%      +5.0%       0.04 ± 14%  time.user_time
     83.33            +0.2%      83.50        time.voluntary_context_switches
      0.33 ±141%     +50.0%       0.50 ±100%  vmstat.cpu.id
     97.00            +0.0%      97.00        vmstat.cpu.sy
      1.00            +0.0%       1.00        vmstat.cpu.us
      0.00          -100.0%       0.00        vmstat.io.bi
      4.00            +0.0%       4.00        vmstat.memory.buff
   1391751            +0.1%    1392746        vmstat.memory.cache
 1.294e+08            -0.0%  1.294e+08        vmstat.memory.free
     71.00            +0.0%      71.00        vmstat.procs.r
      1315            -0.7%       1305        vmstat.system.cs
    147433            -0.0%     147369        vmstat.system.in
      0.00          -100.0%       0.00        proc-vmstat.compact_isolated
     85060            +0.4%      85431        proc-vmstat.nr_active_anon
     37.00            -1.4%      36.50        proc-vmstat.nr_active_file
     71111            +0.1%      71200        proc-vmstat.nr_anon_pages
     77.33 ± 17%     +12.5%      87.00        proc-vmstat.nr_anon_transparent_hugepages
     54.00            +1.9%      55.00        proc-vmstat.nr_dirtied
      5.00            +0.0%       5.00        proc-vmstat.nr_dirty
   3215506            -0.0%    3215471        proc-vmstat.nr_dirty_background_threshold
   6438875            -0.0%    6438805        proc-vmstat.nr_dirty_threshold
    327936            +0.1%     328237        proc-vmstat.nr_file_pages
     50398            +0.0%      50398        proc-vmstat.nr_free_cma
  32356721            -0.0%   32356374        proc-vmstat.nr_free_pages
      4640            -0.1%       4636        proc-vmstat.nr_inactive_anon
     82.67 ±  2%      -0.8%      82.00 ±  2%  proc-vmstat.nr_inactive_file
     13256            -0.3%      13211        proc-vmstat.nr_kernel_stack
      8057            -0.5%       8017        proc-vmstat.nr_mapped
    134.00 ±141%     +49.3%     200.00 ±100%  proc-vmstat.nr_mlock
      2229            +0.2%       2234        proc-vmstat.nr_page_table_pages
     18609 ±  3%      +1.6%      18898 ±  3%  proc-vmstat.nr_shmem
     19964            -0.3%      19901        proc-vmstat.nr_slab_reclaimable
     34003            +0.1%      34025        proc-vmstat.nr_slab_unreclaimable
    309227            +0.0%     309249        proc-vmstat.nr_unevictable
      0.00          -100.0%       0.00        proc-vmstat.nr_writeback
     53.00            +0.0%      53.00        proc-vmstat.nr_written
     85060            +0.4%      85431        proc-vmstat.nr_zone_active_anon
     37.00            -1.4%      36.50        proc-vmstat.nr_zone_active_file
      4640            -0.1%       4636        proc-vmstat.nr_zone_inactive_anon
     82.67 ±  2%      -0.8%      82.00 ±  2%  proc-vmstat.nr_zone_inactive_file
    309227            +0.0%     309249        proc-vmstat.nr_zone_unevictable
      5.00            +0.0%       5.00        proc-vmstat.nr_zone_write_pending
      2181 ±124%     -68.6%     685.50 ± 80%  proc-vmstat.numa_hint_faults
     37.67 ±109%     +77.9%      67.00 ± 91%  proc-vmstat.numa_hint_faults_local
    702373            +0.7%     707116        proc-vmstat.numa_hit
     35.33 ± 85%     -70.3%      10.50 ±  4%  proc-vmstat.numa_huge_pte_updates
      0.00          -100.0%       0.00        proc-vmstat.numa_interleave
    678938            +0.7%     683714        proc-vmstat.numa_local
     23435            -0.1%      23401        proc-vmstat.numa_other
      4697 ± 68%     -86.8%     618.50 ± 98%  proc-vmstat.numa_pages_migrated
     25844 ± 52%     -79.1%       5406 ±  4%  proc-vmstat.numa_pte_updates
     20929 ±  4%      +1.9%      21332 ±  5%  proc-vmstat.pgactivate
      0.00          -100.0%       0.00        proc-vmstat.pgalloc_dma32
    760325            -0.4%     756908        proc-vmstat.pgalloc_normal
    801566            -0.5%     797832        proc-vmstat.pgfault
    714690            -0.2%     713286        proc-vmstat.pgfree
      4697 ± 68%     -86.8%     618.50 ± 98%  proc-vmstat.pgmigrate_success
      0.00          -100.0%       0.00        proc-vmstat.pgpgin
    103.00            +0.5%     103.50        proc-vmstat.thp_collapse_alloc
      5.00            +0.0%       5.00        proc-vmstat.thp_fault_alloc
      0.00          -100.0%       0.00        proc-vmstat.thp_zero_page_alloc
     41.00 ± 98%     +35.4%      55.50 ± 80%  proc-vmstat.unevictable_pgs_culled
    183.00 ±141%     +50.0%     274.50 ±100%  proc-vmstat.unevictable_pgs_mlocked
      2.59            +0.5%       2.60        perf-stat.i.MPKI
 4.854e+09            +0.0%  4.856e+09        perf-stat.i.branch-instructions
      0.45            -0.0        0.43        perf-stat.i.branch-miss-rate%
  21296577            -2.3%   20817170        perf-stat.i.branch-misses
     39.98            -0.2       39.81        perf-stat.i.cache-miss-rate%
  21372778            +0.0%   21380457        perf-stat.i.cache-misses
  53441942            +0.5%   53705724        perf-stat.i.cache-references
      1285            -0.7%       1277        perf-stat.i.context-switches
     10.67            -0.0%      10.67        perf-stat.i.cpi
     71998            -0.0%      71998        perf-stat.i.cpu-clock
  2.21e+11            +0.0%   2.21e+11        perf-stat.i.cpu-cycles
    117.36            +0.3%     117.71        perf-stat.i.cpu-migrations
     10322            -0.0%      10321        perf-stat.i.cycles-between-cache-misses
      0.05            +0.0        0.05        perf-stat.i.dTLB-load-miss-rate%
   2709233            +0.1%    2712427        perf-stat.i.dTLB-load-misses
 5.785e+09            +0.0%  5.787e+09        perf-stat.i.dTLB-loads
      0.00            +0.0        0.00 ±  2%  perf-stat.i.dTLB-store-miss-rate%
      8967            -3.0%       8701        perf-stat.i.dTLB-store-misses
  1.97e+09            +0.1%  1.971e+09        perf-stat.i.dTLB-stores
     94.02            +0.2       94.24        perf-stat.i.iTLB-load-miss-rate%
   2732366            -1.4%    2694372        perf-stat.i.iTLB-load-misses
    173049            -5.7%     163172 ±  2%  perf-stat.i.iTLB-loads
  2.07e+10            +0.0%  2.071e+10        perf-stat.i.instructions
      7671            +1.0%       7747        perf-stat.i.instructions-per-iTLB-miss
      0.10            +0.1%       0.10        perf-stat.i.ipc
      3.07            +0.0%       3.07        perf-stat.i.metric.GHz
      0.42            +0.5%       0.43        perf-stat.i.metric.K/sec
    175.98            +0.1%     176.08        perf-stat.i.metric.M/sec
      2565            -0.7%       2547        perf-stat.i.minor-faults
     99.55            -0.0       99.53        perf-stat.i.node-load-miss-rate%
   5949351            +0.3%    5969805        perf-stat.i.node-load-misses
     22301 ±  6%      +5.6%      23543 ±  8%  perf-stat.i.node-loads
     99.73            -0.0       99.72        perf-stat.i.node-store-miss-rate%
   5314673            -0.1%    5310449        perf-stat.i.node-store-misses
      4704 ±  4%      -1.8%       4619        perf-stat.i.node-stores
      2565            -0.7%       2547        perf-stat.i.page-faults
     71998            -0.0%      71998        perf-stat.i.task-clock
      2.58            +0.5%       2.59        perf-stat.overall.MPKI
      0.44            -0.0        0.43        perf-stat.overall.branch-miss-rate%
     39.99            -0.2       39.81        perf-stat.overall.cache-miss-rate%
     10.67            -0.0%      10.67        perf-stat.overall.cpi
     10340            -0.0%      10337        perf-stat.overall.cycles-between-cache-misses
      0.05            +0.0        0.05        perf-stat.overall.dTLB-load-miss-rate%
      0.00            -0.0        0.00        perf-stat.overall.dTLB-store-miss-rate%
     94.04            +0.2       94.29        perf-stat.overall.iTLB-load-miss-rate%
      7577            +1.4%       7686        perf-stat.overall.instructions-per-iTLB-miss
      0.09            +0.0%       0.09        perf-stat.overall.ipc
     99.62            -0.0       99.60        perf-stat.overall.node-load-miss-rate%
     99.91            +0.0       99.91        perf-stat.overall.node-store-miss-rate%
   4691551            +0.0%    4693151        perf-stat.overall.path-length
 4.838e+09            +0.0%   4.84e+09        perf-stat.ps.branch-instructions
  21230930            -2.3%   20750859        perf-stat.ps.branch-misses
  21302195            +0.0%   21309444        perf-stat.ps.cache-misses
  53273375            +0.5%   53531696        perf-stat.ps.cache-references
      1281            -0.7%       1273        perf-stat.ps.context-switches
     71760            -0.0%      71759        perf-stat.ps.cpu-clock
 2.203e+11            +0.0%  2.203e+11        perf-stat.ps.cpu-cycles
    117.02            +0.3%     117.33        perf-stat.ps.cpu-migrations
   2702184            +0.1%    2704689        perf-stat.ps.dTLB-load-misses
 5.766e+09            +0.0%  5.767e+09        perf-stat.ps.dTLB-loads
      9028            -3.2%       8736        perf-stat.ps.dTLB-store-misses
 1.963e+09            +0.1%  1.965e+09        perf-stat.ps.dTLB-stores
   2723237            -1.4%    2685365        perf-stat.ps.iTLB-load-misses
    172573            -5.7%     162735 ±  2%  perf-stat.ps.iTLB-loads
 2.063e+10            +0.0%  2.064e+10        perf-stat.ps.instructions
      2559            -0.7%       2540        perf-stat.ps.minor-faults
   5929506            +0.3%    5949863        perf-stat.ps.node-load-misses
     22689 ±  5%      +4.7%      23766 ±  8%  perf-stat.ps.node-loads
   5296902            -0.1%    5292690        perf-stat.ps.node-store-misses
      4724 ±  4%      -2.2%       4622        perf-stat.ps.node-stores
      2559            -0.7%       2540        perf-stat.ps.page-faults
     71760            -0.0%      71759        perf-stat.ps.task-clock
  6.24e+12            +0.1%  6.247e+12        perf-stat.total.instructions
     47.20            -0.2       47.05        pp.bt.percpu_counter_add_batch.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
     50.12            -0.2       49.97        pp.bt.entry_SYSCALL_64_after_hwframe.munmap
     50.10            -0.1       49.95        pp.bt.do_syscall_64.entry_SYSCALL_64_after_hwframe.munmap
     46.75            -0.1       46.60        pp.bt._raw_spin_lock_irqsave.percpu_counter_add_batch.__do_munmap.__vm_munmap.__x64_sys_munmap
     49.36            -0.1       49.22        pp.bt.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     49.78            -0.1       49.64        pp.bt.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.munmap
     49.75            -0.1       49.61        pp.bt.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.munmap
     50.48            -0.1       50.34        pp.bt.munmap
     46.56            -0.1       46.41        pp.bt.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.percpu_counter_add_batch.__do_munmap.__vm_munmap
      1.88            -0.0        1.88        pp.bt.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      1.32            +0.0        1.33        pp.bt.unmap_page_range.unmap_vmas.unmap_region.__do_munmap.__vm_munmap
      1.42            +0.0        1.44        pp.bt.unmap_vmas.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap
      0.51            +0.0        0.53        pp.bt.___might_sleep.unmap_page_range.unmap_vmas.unmap_region.__do_munmap
     48.27            +0.1       48.39        pp.bt.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
     48.67            +0.1       48.80        pp.bt.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.mmap64
     48.51            +0.1       48.65        pp.bt.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     47.10            +0.1       47.24        pp.bt.__vm_enough_memory.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
     48.74            +0.1       48.88        pp.bt.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.mmap64
     49.08            +0.1       49.23        pp.bt.entry_SYSCALL_64_after_hwframe.mmap64
     46.48            +0.1       46.62        pp.bt.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.percpu_counter_add_batch.__vm_enough_memory.mmap_region
     49.06            +0.1       49.21        pp.bt.do_syscall_64.entry_SYSCALL_64_after_hwframe.mmap64
     49.46            +0.1       49.61        pp.bt.mmap64
     46.66            +0.1       46.80        pp.bt._raw_spin_lock_irqsave.percpu_counter_add_batch.__vm_enough_memory.mmap_region.do_mmap
     46.84            +0.4       47.23        pp.bt.percpu_counter_add_batch.__vm_enough_memory.mmap_region.do_mmap.vm_mmap_pgoff
     49.78            -0.1       49.64        pp.child.__x64_sys_munmap
     50.51            -0.1       50.36        pp.child.munmap
     49.76            -0.1       49.61        pp.child.__vm_munmap
     49.36            -0.1       49.22        pp.child.__do_munmap
      0.45            -0.0        0.41        pp.child.perf_event_mmap
      0.03 ± 70%      -0.0        0.00        pp.child.strlen
      0.02 ±141%      -0.0        0.00        pp.child.common_file_perm
      0.30            -0.0        0.29        pp.child.free_pgd_range
      1.88            -0.0        1.88        pp.child.unmap_region
      0.28            -0.0        0.27        pp.child.free_p4d_range
      0.28 ±  4%      -0.0        0.27        pp.child.apic_timer_interrupt
      0.19 ±  4%      -0.0        0.18 ±  2%  pp.child.hrtimer_interrupt
      0.09            -0.0        0.08 ±  5%  pp.child.find_vma
      0.40 ±  2%      -0.0        0.40 ±  3%  pp.child.vm_area_alloc
      0.35            -0.0        0.34        pp.child.syscall_return_via_sysret
      0.35 ±  2%      -0.0        0.34        pp.child.up_read
     93.41            -0.0       93.41        pp.child._raw_spin_lock_irqsave
      0.05 ±  8%      -0.0        0.05        pp.child.kmem_cache_alloc_trace
      0.11 ±  4%      -0.0        0.11        pp.child.d_path
      0.11 ±  4%      -0.0        0.11        pp.child.perf_iterate_sb
      0.08 ±  5%      -0.0        0.08        pp.child.prepend_path
     99.23            -0.0       99.23        pp.child.entry_SYSCALL_64_after_hwframe
     93.04            -0.0       93.04        pp.child.native_queued_spin_lock_slowpath
      0.09            -0.0        0.09        pp.child.tick_sched_timer
      0.05            -0.0        0.05        pp.child.unlink_file_vma
      0.05            -0.0        0.05        pp.child.task_tick_fair
      0.05            -0.0        0.05        pp.child.perf_event_mmap_output
     99.20            +0.0       99.20        pp.child.do_syscall_64
      0.21 ±  3%      +0.0        0.21        pp.child.smp_apic_timer_interrupt
      0.08            +0.0        0.08        pp.child.update_process_times
      0.06            +0.0        0.06        pp.child.down_write_killable
      0.15            +0.0        0.15 ±  6%  pp.child.rcu_all_qs
      0.37 ±  2%      +0.0        0.37 ±  5%  pp.child.kmem_cache_alloc
      0.28            +0.0        0.29 ±  5%  pp.child._cond_resched
      0.12 ±  3%      +0.0        0.12 ±  4%  pp.child.vma_link
      0.09 ±  5%      +0.0        0.10 ±  5%  pp.child.security_mmap_file
      0.06 ±  7%      +0.0        0.07 ±  7%  pp.child.scheduler_tick
      0.13 ±  3%      +0.0        0.14 ±  3%  pp.child.__hrtimer_run_queues
      0.32 ±  2%      +0.0        0.32        pp.child._raw_spin_unlock_irqrestore
      0.08            +0.0        0.08 ±  5%  pp.child.tick_sched_handle
      0.06            +0.0        0.07 ±  7%  pp.child.down_write
      0.06            +0.0        0.07 ±  7%  pp.child.remove_vma
      1.43            +0.0        1.44        pp.child.unmap_vmas
      0.05            +0.0        0.06        pp.child.__vma_rb_erase
      0.08            +0.0        0.09        pp.child.free_pgtables
      1.39            +0.0        1.40        pp.child.unmap_page_range
      0.35            +0.0        0.36 ±  4%  pp.child.entry_SYSCALL_64
      0.10 ±  4%      +0.0        0.11        pp.child.arch_get_unmapped_area_topdown
      0.58            +0.0        0.59        pp.child.___might_sleep
      0.06            +0.0        0.08 ±  6%  pp.child.shmem_mmap
      0.03 ± 70%      +0.0        0.05        pp.child.up_write
      0.03 ± 70%      +0.0        0.05        pp.child.vm_unmapped_area
      0.03 ± 70%      +0.0        0.05        pp.child.__vma_link_rb
      0.15 ±  3%      +0.0        0.17 ±  3%  pp.child.shmem_get_unmapped_area
      0.18 ±  2%      +0.0        0.20 ±  2%  pp.child.get_unmapped_area
      0.00            +0.0        0.03 ±100%  pp.child.prepend_name
      0.02 ±141%      +0.0        0.05        pp.child.touch_atime
     48.28            +0.1       48.39        pp.child.mmap_region
     47.10            +0.1       47.24        pp.child.__vm_enough_memory
     48.51            +0.1       48.65        pp.child.do_mmap
     48.74            +0.1       48.88        pp.child.ksys_mmap_pgoff
     48.67            +0.1       48.81        pp.child.vm_mmap_pgoff
     49.49            +0.1       49.64        pp.child.mmap64
     94.04            +0.2       94.28        pp.child.percpu_counter_add_batch
      0.27            -0.3        0.00        pp.self.__vm_enough_memory
      0.03 ± 70%      -0.0        0.00        pp.self.strlen
      0.02 ±141%      -0.0        0.00        pp.self.prepend_path
      0.28            -0.0        0.27        pp.self.free_p4d_range
      0.07            -0.0        0.06        pp.self.perf_iterate_sb
      0.08            -0.0        0.07        pp.self.perf_event_mmap
      0.35 ±  2%      -0.0        0.34 ±  5%  pp.self.kmem_cache_alloc
      0.11            -0.0        0.11 ±  4%  pp.self.rcu_all_qs
      0.37            -0.0        0.36        pp.self._raw_spin_lock_irqsave
      0.35            -0.0        0.34        pp.self.syscall_return_via_sysret
      0.35 ±  2%      -0.0        0.34        pp.self.up_read
      0.14 ±  3%      -0.0        0.14 ±  3%  pp.self._cond_resched
     93.04            -0.0       93.04        pp.self.native_queued_spin_lock_slowpath
      0.31            +0.0        0.32 ±  4%  pp.self.entry_SYSCALL_64
      0.69            +0.0        0.69        pp.self.unmap_page_range
      0.10 ±  4%      +0.0        0.10        pp.self._raw_spin_unlock_irqrestore
      0.06 ±  8%      +0.0        0.06        pp.self.find_vma
      0.06 ±  8%      +0.0        0.06        pp.self.__do_munmap
      0.06 ±  7%      +0.0        0.07        pp.self.mmap_region
      0.61 ±  3%      +0.0        0.62        pp.self.do_syscall_64
      0.02 ±141%      +0.0        0.03 ±100%  pp.self.up_write
      0.05            +0.0        0.06        pp.self.__vma_rb_erase
      0.54            +0.0        0.56        pp.self.___might_sleep
      0.03 ± 70%      +0.0        0.05        pp.self.vm_unmapped_area
      0.03 ± 70%      +0.0        0.05        pp.self.shmem_get_unmapped_area
      0.03 ± 70%      +0.0        0.05        pp.self.__vma_link_rb
      0.00            +0.0        0.03 ±100%  pp.self.prepend_name
      0.00            +0.0        0.03 ±100%  pp.self.do_mmap
      0.00            +0.0        0.03 ±100%  pp.self.arch_get_unmapped_area_topdown
      0.02 ±141%      +0.0        0.05        pp.self.perf_event_mmap_output
      0.32 ±  2%      +0.2        0.56        pp.self.percpu_counter_add_batch
    552.67 ±  2%      -5.2%     524.00 ±  6%  softirqs.BLOCK
      2.00            +0.0%       2.00        softirqs.HI
    911.00 ± 47%     -31.4%     625.00 ±  2%  softirqs.NET_RX
     63.67 ±  3%      -5.0%      60.50 ±  4%  softirqs.NET_TX
    312414            -1.1%     309101        softirqs.RCU
    228903            -1.4%     225602 ±  3%  softirqs.SCHED
    265.67            -1.0%     263.00        softirqs.TASKLET
   8777267            +0.1%    8789634        softirqs.TIMER
     23504            -0.1%      23472        interrupts.CAL:Function_call_interrupts
    144.00            -0.3%     143.50        interrupts.IWI:IRQ_work_interrupts
  43641147            -0.0%   43621882        interrupts.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.MCP:Machine_check_polls
    570736 ±  5%      +2.1%     582977 ±  5%  interrupts.NMI:Non-maskable_interrupts
    570736 ±  5%      +2.1%     582977 ±  5%  interrupts.PMI:Performance_monitoring_interrupts
     45097            +0.7%      45407        interrupts.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00        interrupts.RTR:APIC_ICR_read_retries
    193.67 ± 26%     -21.3%     152.50 ± 29%  interrupts.TLB:TLB_shootdowns


