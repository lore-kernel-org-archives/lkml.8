Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95C5C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF9F020771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407688AbgDPGKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 02:10:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:17470 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407386AbgDPGK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:10:26 -0400
IronPort-SDR: esyJZud+EMherZ+iTvEMuPB54E/g3GoBkF0ixAB8/kIYNA/O/hUIh+e3wI3yaufqseSVMn0GBu
 a1Fc1uw/0a5Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 23:10:15 -0700
IronPort-SDR: l0M/4uVcQLx4VLYyDn048V0pfwyBqU6UuI1cBVFYpIwnccjI7SpzRgmkZ5Jh+jeCBdCqgXKao/
 afw5sW+y5WqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="245891053"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.238.5.222]) ([10.238.5.222])
  by fmsmga008.fm.intel.com with ESMTP; 15 Apr 2020 23:10:12 -0700
Subject: Re: [LKP] [x86, sched] 1567c3e346: vm-scalability.median -15.8%
 regression
To:     kernel test robot <oliver.sang@intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@lists.01.org
References: <20200306051916.GA23395@xsang-OptiPlex-9020>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <a5b0b58d-54a9-0f06-c822-3087346a0ae8@linux.intel.com>
Date:   Thu, 16 Apr 2020 14:10:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200306051916.GA23395@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Giovanni,

   1567c3e346("x86, sched: Add support for frequency invariance") has 
been merged into Linux mainline v5.7-rc1 now. Do you have time to take a 
look at this? Thanks.

On 3/6/2020 1:19 PM, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed a -15.8% regression of vm-scalability.median due to commit:
> 
> 
> commit: 1567c3e3467cddeb019a7b53ec632f834b6a9239 ("x86, sched: Add support for frequency invariance")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: vm-scalability
> on test machine: 144 threads Intel(R) Xeon(R) CPU E7-8890 v3 @ 2.50GHz with 512G memory
> with following parameters:
> 
> 	runtime: 300s
> 	size: 8T
> 	test: anon-cow-seq
> 	cpufreq_governor: performance
> 	ucode: 0x16
> 
> test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
> test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
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
> compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase/ucode:
>    gcc-7/performance/x86_64-rhel-7.6/debian-x86_64-20191114.cgz/300s/8T/lkp-hsw-4ex1/anon-cow-seq/vm-scalability/0x16
> 
> commit:
>    2a4b03ffc6 ("sched/fair: Prevent unlimited runtime on throttled group")
>    1567c3e346 ("x86, sched: Add support for frequency invariance")
> 
> 2a4b03ffc69f2ded 1567c3e3467cddeb019a7b53ec6
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>      210443           -15.8%     177280        vm-scalability.median
>        0.07 ±  6%     -64.9%       0.02 ± 16%  vm-scalability.median_stddev
>    30242018           -16.0%   25399016        vm-scalability.throughput
>      241304 ±  2%     +53.9%     371337 ±  2%  vm-scalability.time.involuntary_context_switches
>     8973780           -12.4%    7862380        vm-scalability.time.minor_page_faults
>       10507            +7.6%      11301        vm-scalability.time.percent_of_cpu_this_job_got
>       17759           +22.0%      21664 ±  2%  vm-scalability.time.system_time
>       14801           -10.4%      13262        vm-scalability.time.user_time
>     1023965           -63.3%     376066 ±  4%  vm-scalability.time.voluntary_context_switches
>   7.967e+09           -11.1%  7.082e+09        vm-scalability.workload
>        2985           -11.4%       2643 ±  3%  slabinfo.khugepaged_mm_slot.active_objs
>        2985           -11.4%       2643 ±  3%  slabinfo.khugepaged_mm_slot.num_objs
>    36024164           -42.9%   20554898 ± 40%  cpuidle.C1.time
>   7.277e+09 ± 41%     -72.1%  2.027e+09 ±160%  cpuidle.C3.time
>    17453257 ± 19%     -74.4%    4462508 ±163%  cpuidle.C3.usage
>      214574 ± 10%     -50.2%     106926 ± 33%  cpuidle.POLL.usage
>       26.26            -5.4       20.89        mpstat.cpu.all.idle%
>        0.02 ±  8%      -0.0        0.01 ±  9%  mpstat.cpu.all.iowait%
>       40.23            +8.8       49.05        mpstat.cpu.all.sys%
>       33.49            -3.4       30.05 ±  2%  mpstat.cpu.all.usr%
>     1989988           -20.6%    1580840 ±  4%  numa-numastat.node1.local_node
>     2026261           -20.6%    1608134 ±  4%  numa-numastat.node1.numa_hit
>     3614123 ± 44%     -56.4%    1576459 ±  5%  numa-numastat.node2.local_node
>     3641345 ± 44%     -56.0%    1603122 ±  5%  numa-numastat.node2.numa_hit
>       26.50           -20.8%      21.00        vmstat.cpu.id
>       32.75           -10.7%      29.25        vmstat.cpu.us
>        9800           -34.3%       6434        vmstat.system.cs
>      290059            -6.9%     270063 ±  4%  vmstat.system.in
>   1.012e+08           +12.3%  1.136e+08        meminfo.Active
>   1.012e+08           +12.3%  1.136e+08        meminfo.Active(anon)
>    92123057           +14.3%  1.053e+08        meminfo.AnonHugePages
>   1.009e+08           +12.3%  1.134e+08        meminfo.AnonPages
>   1.044e+08           +11.9%  1.169e+08        meminfo.Memused
>    25495045           +15.0%   29324284        numa-meminfo.node1.Active
>    25494976           +15.0%   29324244        numa-meminfo.node1.Active(anon)
>    23164225           +17.2%   27157731        numa-meminfo.node1.AnonHugePages
>    25417044           +15.1%   29267058        numa-meminfo.node1.AnonPages
>    26192254           +14.4%   29959010        numa-meminfo.node1.MemUsed
>    24839952 ±  3%     +18.2%   29349199        numa-meminfo.node2.Active
>    24839901 ±  3%     +18.2%   29349040        numa-meminfo.node2.Active(anon)
>    22604826 ±  3%     +20.4%   27211067        numa-meminfo.node2.AnonHugePages
>    24777054 ±  3%     +18.2%   29282273        numa-meminfo.node2.AnonPages
>    25718372 ±  2%     +16.8%   30037056        numa-meminfo.node2.MemUsed
>      199045 ± 96%     -99.6%     743.75 ± 52%  numa-meminfo.node2.PageTables
>       54935 ± 20%     -24.5%      41470 ± 10%  numa-meminfo.node2.SUnreclaim
>      418.75 ± 94%     -93.7%      26.50 ± 49%  numa-meminfo.node3.Inactive(file)
>        4864 ± 15%     +26.9%       6174 ± 10%  numa-meminfo.node3.KernelStack
>       95371 ±172%    +233.9%     318444 ± 57%  numa-meminfo.node3.PageTables
>     6347307           +14.8%    7286035        numa-vmstat.node1.nr_active_anon
>     6328825           +14.9%    7268986        numa-vmstat.node1.nr_anon_pages
>       11261           +16.9%      13162        numa-vmstat.node1.nr_anon_transparent_hugepages
>     6347284           +14.8%    7285923        numa-vmstat.node1.nr_zone_active_anon
>     1324428           -15.2%    1122566 ±  3%  numa-vmstat.node1.numa_hit
>     1204942           -16.0%    1011998 ±  3%  numa-vmstat.node1.numa_local
>     6207902 ±  3%     +17.7%    7308204        numa-vmstat.node2.nr_active_anon
>     6195059 ±  3%     +17.6%    7287608        numa-vmstat.node2.nr_anon_pages
>       11047 ±  3%     +19.7%      13218        numa-vmstat.node2.nr_anon_transparent_hugepages
>       49684 ± 96%     -99.6%     186.00 ± 52%  numa-vmstat.node2.nr_page_table_pages
>       13734 ± 20%     -24.5%      10367 ± 10%  numa-vmstat.node2.nr_slab_unreclaimable
>     6207738 ±  3%     +17.7%    7308081        numa-vmstat.node2.nr_zone_active_anon
>     2125860 ± 40%     -49.5%    1073183 ±  2%  numa-vmstat.node2.numa_hit
>     2015486 ± 42%     -52.2%     963317 ±  2%  numa-vmstat.node2.numa_local
>      104.25 ± 94%     -93.8%       6.50 ± 49%  numa-vmstat.node3.nr_inactive_file
>        4864 ± 15%     +26.7%       6160 ± 10%  numa-vmstat.node3.nr_kernel_stack
>       23833 ±172%    +230.0%      78649 ± 57%  numa-vmstat.node3.nr_page_table_pages
>      104.25 ± 94%     -93.8%       6.50 ± 49%  numa-vmstat.node3.nr_zone_inactive_file
>        1.12 ± 19%      -0.5        0.63 ± 20%  perf-profile.calltrace.cycles-pp.do_huge_pmd_numa_page.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault
>        0.81 ± 19%      -0.2        0.60 ± 20%  perf-profile.calltrace.cycles-pp.reuse_swap_page.do_huge_pmd_wp_page.__handle_mm_fault.handle_mm_fault.__do_page_fault
>        0.33 ± 22%      -0.2        0.17 ±  4%  perf-profile.children.cycles-pp.migrate_misplaced_transhuge_page
>        0.09 ± 23%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.ttwu_do_activate
>        0.08 ± 19%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.enqueue_entity
>        0.15 ± 20%      -0.1        0.10 ± 15%  perf-profile.children.cycles-pp.wake_up_page_bit
>        0.14 ± 23%      -0.1        0.09 ± 14%  perf-profile.children.cycles-pp.__wake_up_common
>        0.14 ± 20%      -0.1        0.09 ± 13%  perf-profile.children.cycles-pp.autoremove_wake_function
>        0.09 ± 20%      -0.0        0.04 ± 58%  perf-profile.children.cycles-pp.enqueue_task_fair
>        0.09 ± 23%      -0.0        0.04 ± 58%  perf-profile.children.cycles-pp.activate_task
>        0.15 ± 21%      -0.0        0.11 ± 17%  perf-profile.children.cycles-pp.try_to_wake_up
>        0.15 ± 11%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.schedule
>        0.08 ± 10%      +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.newidle_balance
>        0.12 ± 16%      +0.0        0.17 ±  9%  perf-profile.children.cycles-pp.find_busiest_group
>        0.00            +0.1        0.05        perf-profile.children.cycles-pp.balance_fair
>        0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.arch_scale_freq_tick
>        0.18 ± 10%      +0.1        0.23 ±  8%  perf-profile.children.cycles-pp.load_balance
>        0.00            +0.1        0.09 ±  9%  perf-profile.children.cycles-pp.smpboot_thread_fn
>        0.40 ± 23%      +0.3        0.68 ± 17%  perf-profile.children.cycles-pp.task_tick_fair
>        0.01 ±173%      +0.3        0.30 ± 16%  perf-profile.children.cycles-pp.update_cfs_group
>        0.01 ±173%      +0.3        0.30 ± 16%  perf-profile.self.cycles-pp.update_cfs_group
>        8587 ± 12%     -29.1%       6090 ±  9%  sched_debug.cfs_rq:/.exec_clock.stddev
>        0.53 ± 45%     -92.1%       0.04 ±173%  sched_debug.cfs_rq:/.load_avg.min
>        0.54 ± 19%     +38.3%       0.74 ± 10%  sched_debug.cfs_rq:/.nr_running.avg
>        4.81 ± 12%    +266.0%      17.59 ±  7%  sched_debug.cfs_rq:/.nr_spread_over.avg
>       24.01 ±  8%     +96.4%      47.14 ±  4%  sched_debug.cfs_rq:/.nr_spread_over.max
>        5.02 ± 10%    +123.0%      11.19 ±  6%  sched_debug.cfs_rq:/.nr_spread_over.stddev
>      313.47 ± 18%     -55.1%     140.75 ± 51%  sched_debug.cfs_rq:/.runnable_load_avg.max
>       31.75 ±  9%     -54.5%      14.46 ± 44%  sched_debug.cfs_rq:/.runnable_load_avg.stddev
>        0.54 ± 19%     +38.2%       0.75 ±  9%  sched_debug.cpu.nr_running.avg
>       11567 ±  8%     -28.4%       8277 ±  7%  sched_debug.cpu.nr_switches.avg
>        4760 ±  9%     -31.7%       3249 ±  4%  sched_debug.cpu.nr_switches.stddev
>      -36.17           +31.8%     -47.65        sched_debug.cpu.nr_uninterruptible.min
>       15.88 ±  2%     +35.3%      21.49 ±  7%  sched_debug.cpu.nr_uninterruptible.stddev
>        9718 ± 10%     -34.1%       6402 ±  9%  sched_debug.cpu.sched_count.avg
>        4294 ±  8%     -37.4%       2688 ±  8%  sched_debug.cpu.sched_count.stddev
>        3936 ± 10%     -53.6%       1828 ± 12%  sched_debug.cpu.sched_goidle.avg
>        2045 ±  8%     -50.0%       1022 ± 10%  sched_debug.cpu.sched_goidle.stddev
>        4616 ±  9%     -36.5%       2933 ± 10%  sched_debug.cpu.ttwu_count.avg
>       11005 ±  9%     -22.0%       8579 ±  9%  sched_debug.cpu.ttwu_count.max
>        2271 ±  8%     -34.9%       1478 ±  8%  sched_debug.cpu.ttwu_count.stddev
>      915.40 ±  8%     +42.3%       1303 ±  6%  sched_debug.cpu.ttwu_local.avg
>        3927 ±  5%     +19.3%       4684 ± 10%  sched_debug.cpu.ttwu_local.max
>      488.40 ±  9%     +40.6%     686.55 ±  3%  sched_debug.cpu.ttwu_local.stddev
>    25252488           +12.3%   28363408        proc-vmstat.nr_active_anon
>    25182652           +12.4%   28296707        proc-vmstat.nr_anon_pages
>       44870           +14.2%      51263        proc-vmstat.nr_anon_transparent_hugepages
>      148.25            -5.7%     139.75        proc-vmstat.nr_dirtied
>    10541824            -3.0%   10230220        proc-vmstat.nr_dirty_background_threshold
>    21109424            -3.0%   20485453        proc-vmstat.nr_dirty_threshold
>    1.06e+08            -2.9%  1.029e+08        proc-vmstat.nr_free_pages
>      369.75            -1.4%     364.50        proc-vmstat.nr_inactive_file
>       99622            +7.3%     106911        proc-vmstat.nr_page_table_pages
>      144.25            -4.9%     137.25        proc-vmstat.nr_written
>    25252485           +12.3%   28363396        proc-vmstat.nr_zone_active_anon
>      369.75            -1.4%     364.50        proc-vmstat.nr_zone_inactive_file
>     2953466           -10.6%    2639571        proc-vmstat.numa_hint_faults
>      661711            -9.8%     596566        proc-vmstat.numa_hint_faults_local
>    11245421           -11.8%    9923535        proc-vmstat.numa_hit
>     5838019            -7.0%    5428548        proc-vmstat.numa_huge_pte_updates
>    11136518           -11.9%    9814538        proc-vmstat.numa_local
>      201352 ± 12%    +234.6%     673715 ±  7%  proc-vmstat.numa_pages_migrated
>    2.99e+09            -7.0%   2.78e+09        proc-vmstat.numa_pte_updates
>   2.382e+09           -18.9%  1.931e+09        proc-vmstat.pgalloc_normal
>    10046733           -11.2%    8918565        proc-vmstat.pgfault
>   2.381e+09           -18.9%   1.93e+09        proc-vmstat.pgfree
>   5.942e+08           -42.6%  3.409e+08        proc-vmstat.pgmigrate_fail
>      201352 ± 12%    +234.6%     673715 ±  7%  proc-vmstat.pgmigrate_success
>     3478289           -11.1%    3091553        proc-vmstat.thp_fault_alloc
>        8.85 ±  7%     -16.8%       7.36 ± 12%  perf-stat.i.MPKI
>   2.766e+10 ±  4%      -7.4%  2.562e+10 ±  3%  perf-stat.i.branch-instructions
>       20.31            +1.8       22.10 ±  4%  perf-stat.i.cache-miss-rate%
>   5.089e+08 ±  4%      -9.5%  4.604e+08 ±  3%  perf-stat.i.cache-references
>        9955 ±  3%     -33.0%       6665 ±  4%  perf-stat.i.context-switches
>        1.73 ±  4%      +9.9%       1.90 ±  3%  perf-stat.i.cpi
>   1.287e+11 ±  4%     +11.2%  1.431e+11 ±  3%  perf-stat.i.cpu-cycles
>      485.10 ±  5%    +108.0%       1009 ±  4%  perf-stat.i.cpu-migrations
>   2.215e+10 ±  4%      -6.5%  2.071e+10 ±  3%  perf-stat.i.dTLB-loads
>   7.427e+09 ±  4%      -8.1%  6.829e+09 ±  3%  perf-stat.i.dTLB-stores
>      958368 ±  5%     -30.9%     662160 ±  2%  perf-stat.i.iTLB-load-misses
>   8.707e+10 ±  4%      -7.4%  8.062e+10 ±  3%  perf-stat.i.instructions
>      142754 ±  2%     +11.3%     158927 ±  2%  perf-stat.i.instructions-per-iTLB-miss
>        0.67           -13.3%       0.58        perf-stat.i.ipc
>       33135 ±  4%     -10.7%      29584 ±  2%  perf-stat.i.minor-faults
>       70.79            +6.0       76.82        perf-stat.i.node-load-miss-rate%
>    41028170 ±  4%     +14.1%   46801837 ±  3%  perf-stat.i.node-load-misses
>        1.85 ±  5%      +0.9        2.78 ±  5%  perf-stat.i.node-store-miss-rate%
>      584076 ±  6%     +70.0%     992640 ±  4%  perf-stat.i.node-store-misses
>    53445296 ±  5%     -19.0%   43298204 ±  7%  perf-stat.i.node-stores
>       33137 ±  4%     -10.7%      29584 ±  2%  perf-stat.i.page-faults
>        5.85            -1.7%       5.75        perf-stat.overall.MPKI
>        1.48           +19.6%       1.77        perf-stat.overall.cpi
>        1156           +16.7%       1350 ±  5%  perf-stat.overall.cycles-between-cache-misses
>       92129 ±  6%     +25.2%     115378        perf-stat.overall.instructions-per-iTLB-miss
>        0.67           -16.4%       0.56        perf-stat.overall.ipc
>       75.40            +3.8       79.17        perf-stat.overall.node-load-miss-rate%
>        1.11 ±  2%      +1.2        2.33 ±  7%  perf-stat.overall.node-store-miss-rate%
>   2.704e+10           -11.0%  2.408e+10        perf-stat.ps.branch-instructions
>   1.091e+08            -8.5%   99896941 ±  5%  perf-stat.ps.cache-misses
>   4.979e+08           -12.5%  4.357e+08        perf-stat.ps.cache-references
>        9775           -34.7%       6386 ±  2%  perf-stat.ps.context-switches
>   1.262e+11            +6.5%  1.344e+11        perf-stat.ps.cpu-cycles
>      487.90 ±  5%    +100.7%     979.41        perf-stat.ps.cpu-migrations
>   2.166e+10           -10.1%  1.948e+10        perf-stat.ps.dTLB-loads
>    7.26e+09           -11.3%  6.441e+09        perf-stat.ps.dTLB-stores
>      927296 ±  5%     -29.1%     657143        perf-stat.ps.iTLB-load-misses
>   8.512e+10           -10.9%  7.581e+10        perf-stat.ps.instructions
>       32070           -11.2%      28469        perf-stat.ps.minor-faults
>    40537100            +9.2%   44251909 ±  4%  perf-stat.ps.node-load-misses
>    13226459 ±  2%     -12.0%   11644845 ±  4%  perf-stat.ps.node-loads
>      582949 ±  3%     +65.6%     965166 ±  3%  perf-stat.ps.node-store-misses
>    52116857           -21.9%   40679765 ±  8%  perf-stat.ps.node-stores
>       32070           -11.2%      28469        perf-stat.ps.page-faults
>   2.642e+13           -11.4%  2.341e+13        perf-stat.total.instructions
>      229.75 ± 52%     -34.1%     151.50        interrupts.102:PCI-MSI.1572921-edge.eth0-TxRx-57
>      156.75 ±  3%     +27.3%     199.50 ± 29%  interrupts.47:PCI-MSI.1572866-edge.eth0-TxRx-2
>        1603 ± 22%     -15.6%       1352 ±  4%  interrupts.CPU1.NMI:Non-maskable_interrupts
>        1603 ± 22%     -15.6%       1352 ±  4%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
>        1007 ± 19%     -38.7%     618.00 ±  8%  interrupts.CPU100.RES:Rescheduling_interrupts
>        1016 ± 19%     -33.9%     671.75 ±  5%  interrupts.CPU101.RES:Rescheduling_interrupts
>        2046 ± 32%     -19.9%       1638 ± 30%  interrupts.CPU102.NMI:Non-maskable_interrupts
>        2046 ± 32%     -19.9%       1638 ± 30%  interrupts.CPU102.PMI:Performance_monitoring_interrupts
>      956.75 ± 18%     -33.1%     640.25 ±  5%  interrupts.CPU102.RES:Rescheduling_interrupts
>      909.50 ± 20%     -29.1%     644.50 ± 12%  interrupts.CPU103.RES:Rescheduling_interrupts
>      959.50 ± 24%     -31.4%     658.00 ±  5%  interrupts.CPU104.RES:Rescheduling_interrupts
>      921.75 ± 14%     -30.2%     643.50 ±  3%  interrupts.CPU105.RES:Rescheduling_interrupts
>      901.50 ± 14%     -27.8%     650.50 ± 11%  interrupts.CPU106.RES:Rescheduling_interrupts
>        2670 ±  3%     -37.5%       1670 ± 31%  interrupts.CPU107.NMI:Non-maskable_interrupts
>        2670 ±  3%     -37.5%       1670 ± 31%  interrupts.CPU107.PMI:Performance_monitoring_interrupts
>        2849           -31.6%       1948 ± 33%  interrupts.CPU109.NMI:Non-maskable_interrupts
>        2849           -31.6%       1948 ± 33%  interrupts.CPU109.PMI:Performance_monitoring_interrupts
>        1410 ± 20%     +51.0%       2130 ± 23%  interrupts.CPU11.NMI:Non-maskable_interrupts
>        1410 ± 20%     +51.0%       2130 ± 23%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
>        2820 ±  3%     -30.7%       1955 ± 32%  interrupts.CPU111.NMI:Non-maskable_interrupts
>        2820 ±  3%     -30.7%       1955 ± 32%  interrupts.CPU111.PMI:Performance_monitoring_interrupts
>        2808           -30.1%       1962 ± 33%  interrupts.CPU116.NMI:Non-maskable_interrupts
>        2808           -30.1%       1962 ± 33%  interrupts.CPU116.PMI:Performance_monitoring_interrupts
>      622190            -8.1%     571803 ±  4%  interrupts.CPU118.LOC:Local_timer_interrupts
>      621861            -8.3%     570381 ±  4%  interrupts.CPU119.LOC:Local_timer_interrupts
>        2024 ± 25%     -30.0%       1417 ±  8%  interrupts.CPU12.NMI:Non-maskable_interrupts
>        2024 ± 25%     -30.0%       1417 ±  8%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
>      622130            -8.0%     572612 ±  4%  interrupts.CPU120.LOC:Local_timer_interrupts
>      622145            -8.4%     569980 ±  4%  interrupts.CPU121.LOC:Local_timer_interrupts
>        2131 ± 33%     -24.4%       1611 ± 26%  interrupts.CPU121.NMI:Non-maskable_interrupts
>        2131 ± 33%     -24.4%       1611 ± 26%  interrupts.CPU121.PMI:Performance_monitoring_interrupts
>      621983            -7.9%     572602 ±  4%  interrupts.CPU123.LOC:Local_timer_interrupts
>        2219 ± 34%     -40.0%       1332 ±  5%  interrupts.CPU124.NMI:Non-maskable_interrupts
>        2219 ± 34%     -40.0%       1332 ±  5%  interrupts.CPU124.PMI:Performance_monitoring_interrupts
>      622061            -8.0%     572198 ±  4%  interrupts.CPU125.LOC:Local_timer_interrupts
>      817.50 ± 12%     -46.8%     435.25 ± 13%  interrupts.CPU128.RES:Rescheduling_interrupts
>      820.75 ± 24%     -48.8%     420.00 ± 25%  interrupts.CPU129.RES:Rescheduling_interrupts
>      750.00 ± 25%     -42.9%     428.00 ± 24%  interrupts.CPU130.RES:Rescheduling_interrupts
>        2285 ± 22%     -38.1%       1415        interrupts.CPU133.NMI:Non-maskable_interrupts
>        2285 ± 22%     -38.1%       1415        interrupts.CPU133.PMI:Performance_monitoring_interrupts
>      779.25 ± 30%     -50.5%     386.00 ± 23%  interrupts.CPU133.RES:Rescheduling_interrupts
>      741.25 ± 28%     -47.7%     387.75 ± 28%  interrupts.CPU135.RES:Rescheduling_interrupts
>      728.00 ± 28%     -46.2%     391.50 ± 31%  interrupts.CPU137.RES:Rescheduling_interrupts
>      749.25 ± 29%     -53.9%     345.50 ± 27%  interrupts.CPU138.RES:Rescheduling_interrupts
>      751.25 ± 27%     -49.0%     383.00 ± 29%  interrupts.CPU139.RES:Rescheduling_interrupts
>      688.00 ± 24%     -49.8%     345.25 ± 27%  interrupts.CPU140.RES:Rescheduling_interrupts
>      726.00 ± 27%     -55.1%     326.25 ± 32%  interrupts.CPU141.RES:Rescheduling_interrupts
>        2272 ± 29%     -40.7%       1347 ±  2%  interrupts.CPU15.NMI:Non-maskable_interrupts
>        2272 ± 29%     -40.7%       1347 ±  2%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
>      156.75 ±  3%     +27.3%     199.50 ± 29%  interrupts.CPU2.47:PCI-MSI.1572866-edge.eth0-TxRx-2
>        2562 ±  9%     -38.6%       1573 ± 28%  interrupts.CPU2.NMI:Non-maskable_interrupts
>        2562 ±  9%     -38.6%       1573 ± 28%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
>        1344 ± 20%     -32.8%     903.75        interrupts.CPU20.RES:Rescheduling_interrupts
>        1314 ± 16%     -29.9%     921.50 ±  5%  interrupts.CPU21.RES:Rescheduling_interrupts
>      120.00 ± 47%     -98.3%       2.00 ± 93%  interrupts.CPU22.TLB:TLB_shootdowns
>        2245 ± 24%     -35.7%       1443 ± 24%  interrupts.CPU23.NMI:Non-maskable_interrupts
>        2245 ± 24%     -35.7%       1443 ± 24%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
>        1338 ± 18%     -32.8%     899.00 ± 12%  interrupts.CPU23.RES:Rescheduling_interrupts
>        1243 ± 16%     -28.0%     895.75 ±  4%  interrupts.CPU24.RES:Rescheduling_interrupts
>        1360 ± 30%     -33.3%     907.50 ± 15%  interrupts.CPU25.RES:Rescheduling_interrupts
>        1273 ± 20%     -34.0%     841.00 ±  6%  interrupts.CPU26.RES:Rescheduling_interrupts
>        1273 ± 15%     -31.3%     874.25 ±  8%  interrupts.CPU27.RES:Rescheduling_interrupts
>        1315 ± 16%     -40.6%     781.00 ± 11%  interrupts.CPU28.RES:Rescheduling_interrupts
>        1320 ± 20%     -39.2%     802.75 ±  5%  interrupts.CPU29.RES:Rescheduling_interrupts
>        2094 ± 30%     -22.7%       1619 ± 35%  interrupts.CPU30.NMI:Non-maskable_interrupts
>        2094 ± 30%     -22.7%       1619 ± 35%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
>        1301 ± 19%     -40.6%     773.00 ±  5%  interrupts.CPU30.RES:Rescheduling_interrupts
>        1253 ± 16%     -36.9%     791.00 ± 15%  interrupts.CPU31.RES:Rescheduling_interrupts
>        1231 ± 17%     -41.5%     720.25 ±  8%  interrupts.CPU32.RES:Rescheduling_interrupts
>        1177 ± 11%     -37.3%     738.00 ± 14%  interrupts.CPU33.RES:Rescheduling_interrupts
>        1195 ± 18%     -34.0%     788.75 ± 21%  interrupts.CPU34.RES:Rescheduling_interrupts
>        2567 ±  8%     -35.1%       1666 ± 35%  interrupts.CPU35.NMI:Non-maskable_interrupts
>        2567 ±  8%     -35.1%       1666 ± 35%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
>        1223 ± 18%     -39.1%     745.25 ±  8%  interrupts.CPU35.RES:Rescheduling_interrupts
>      621753            -7.9%     572936 ±  4%  interrupts.CPU36.LOC:Local_timer_interrupts
>        2527 ± 10%     -34.0%       1667 ± 31%  interrupts.CPU40.NMI:Non-maskable_interrupts
>        2527 ± 10%     -34.0%       1667 ± 31%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
>      622323            -7.9%     572967 ±  4%  interrupts.CPU45.LOC:Local_timer_interrupts
>        1832 ± 17%     +38.7%       2541 ±  3%  interrupts.CPU46.NMI:Non-maskable_interrupts
>        1832 ± 17%     +38.7%       2541 ±  3%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
>      621906            -8.0%     572330 ±  4%  interrupts.CPU47.LOC:Local_timer_interrupts
>      621972            -8.1%     571378 ±  4%  interrupts.CPU48.LOC:Local_timer_interrupts
>      622275            -8.2%     571410 ±  4%  interrupts.CPU49.LOC:Local_timer_interrupts
>        2459 ± 24%     -41.7%       1433 ± 10%  interrupts.CPU49.NMI:Non-maskable_interrupts
>        2459 ± 24%     -41.7%       1433 ± 10%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
>      622031            -7.9%     573184 ±  4%  interrupts.CPU50.LOC:Local_timer_interrupts
>      622081            -7.9%     572943 ±  4%  interrupts.CPU51.LOC:Local_timer_interrupts
>      622140            -7.8%     573769 ±  4%  interrupts.CPU52.LOC:Local_timer_interrupts
>      622074            -7.6%     574558 ±  4%  interrupts.CPU53.LOC:Local_timer_interrupts
>      229.75 ± 52%     -34.1%     151.50        interrupts.CPU57.102:PCI-MSI.1572921-edge.eth0-TxRx-57
>        1052 ± 38%     -59.2%     429.25 ± 16%  interrupts.CPU61.RES:Rescheduling_interrupts
>      830.75 ± 26%     -53.3%     388.25 ± 27%  interrupts.CPU62.RES:Rescheduling_interrupts
>      774.50 ± 28%     -48.5%     399.00 ± 32%  interrupts.CPU67.RES:Rescheduling_interrupts
>      785.00 ± 33%     -51.6%     380.00 ± 32%  interrupts.CPU68.RES:Rescheduling_interrupts
>      890.25 ± 31%     -58.3%     371.50 ± 27%  interrupts.CPU69.RES:Rescheduling_interrupts
>      821.50 ± 30%     -46.4%     440.50 ± 36%  interrupts.CPU70.RES:Rescheduling_interrupts
>        1897 ± 24%     +40.4%       2663 ±  4%  interrupts.CPU84.NMI:Non-maskable_interrupts
>        1897 ± 24%     +40.4%       2663 ±  4%  interrupts.CPU84.PMI:Performance_monitoring_interrupts
>        1431 ± 17%     -43.5%     808.25 ± 21%  interrupts.CPU9.RES:Rescheduling_interrupts
>        1064 ± 18%     -30.1%     743.75 ± 16%  interrupts.CPU91.RES:Rescheduling_interrupts
>        1076 ± 10%     -39.6%     649.75 ± 10%  interrupts.CPU92.RES:Rescheduling_interrupts
>        1042 ± 17%     -33.8%     690.00 ± 10%  interrupts.CPU93.RES:Rescheduling_interrupts
>        1065 ± 18%     -33.4%     709.50 ±  5%  interrupts.CPU94.RES:Rescheduling_interrupts
>        2731 ±  7%     -30.6%       1894 ± 28%  interrupts.CPU95.NMI:Non-maskable_interrupts
>        2731 ±  7%     -30.6%       1894 ± 28%  interrupts.CPU95.PMI:Performance_monitoring_interrupts
>      998.75 ± 19%     -28.4%     715.00 ±  7%  interrupts.CPU96.RES:Rescheduling_interrupts
>        2.75 ± 47%   +2009.1%      58.00 ±148%  interrupts.CPU96.TLB:TLB_shootdowns
>      952.50 ± 27%     -29.5%     671.25 ± 12%  interrupts.CPU97.RES:Rescheduling_interrupts
>        2667 ±  2%     -50.2%       1328 ±  4%  interrupts.CPU98.NMI:Non-maskable_interrupts
>        2667 ±  2%     -50.2%       1328 ±  4%  interrupts.CPU98.PMI:Performance_monitoring_interrupts
>      973.00 ± 20%     -28.5%     695.25 ±  4%  interrupts.CPU98.RES:Rescheduling_interrupts
>      991.00 ± 18%     -34.0%     654.00 ±  8%  interrupts.CPU99.RES:Rescheduling_interrupts
>      135782 ± 14%     -25.0%     101847 ±  6%  interrupts.RES:Rescheduling_interrupts
>      140559 ±  2%     -11.8%     124028 ±  6%  softirqs.CPU0.RCU
>      145814 ±  3%     -13.7%     125791 ±  5%  softirqs.CPU1.RCU
>      138760           -12.0%     122124 ±  6%  softirqs.CPU100.RCU
>       16104           -17.4%      13295 ±  5%  softirqs.CPU100.SCHED
>       16422 ±  5%     -16.9%      13653 ±  7%  softirqs.CPU101.SCHED
>       15960           -14.5%      13650 ±  6%  softirqs.CPU102.SCHED
>       15804 ±  8%     -13.8%      13616 ±  7%  softirqs.CPU103.SCHED
>      139949           -12.0%     123102 ±  5%  softirqs.CPU104.RCU
>       16155 ±  3%     -14.6%      13799 ±  8%  softirqs.CPU104.SCHED
>       16018 ±  4%     -14.3%      13725 ± 10%  softirqs.CPU105.SCHED
>       15392 ±  5%     -14.4%      13172 ±  6%  softirqs.CPU106.SCHED
>       15218 ±  4%     -15.5%      12852 ±  9%  softirqs.CPU107.SCHED
>      143209           -14.2%     122899 ±  5%  softirqs.CPU108.RCU
>      144618           -14.9%     123106 ±  4%  softirqs.CPU109.RCU
>      144915           -14.1%     124470 ±  6%  softirqs.CPU110.RCU
>      145038           -14.7%     123770 ±  5%  softirqs.CPU111.RCU
>      138846           -12.2%     121867 ±  6%  softirqs.CPU112.RCU
>      137438           -11.9%     121069 ±  6%  softirqs.CPU113.RCU
>      141152           -13.4%     122234 ±  5%  softirqs.CPU114.RCU
>      141545           -13.8%     122025 ±  5%  softirqs.CPU115.RCU
>      140302           -13.0%     122108 ±  6%  softirqs.CPU116.RCU
>      140548           -13.2%     122057 ±  5%  softirqs.CPU117.RCU
>      142370           -14.3%     122021 ±  5%  softirqs.CPU118.RCU
>      136694           -11.3%     121193 ±  5%  softirqs.CPU119.RCU
>      137193           -11.5%     121415 ±  6%  softirqs.CPU120.RCU
>      137125           -11.9%     120804 ±  5%  softirqs.CPU121.RCU
>      140181           -13.0%     121893 ±  5%  softirqs.CPU122.RCU
>      137405           -11.4%     121741 ±  5%  softirqs.CPU124.RCU
>      139350           -12.5%     122000 ±  6%  softirqs.CPU125.RCU
>      145339           -14.5%     124311 ±  5%  softirqs.CPU126.RCU
>       14887 ± 18%     -32.6%      10033 ± 15%  softirqs.CPU126.SCHED
>      144917           -15.6%     122366 ±  5%  softirqs.CPU127.RCU
>       15094 ± 20%     -37.0%       9516 ± 21%  softirqs.CPU127.SCHED
>      140946           -13.8%     121461 ±  6%  softirqs.CPU128.RCU
>      138106 ±  2%     -11.1%     122812 ±  6%  softirqs.CPU129.RCU
>      137799           -11.3%     122221 ±  6%  softirqs.CPU130.RCU
>      137425           -10.9%     122427 ±  6%  softirqs.CPU131.RCU
>      140854           -12.9%     122753 ±  5%  softirqs.CPU132.RCU
>       15140 ± 24%     -35.8%       9716 ± 19%  softirqs.CPU132.SCHED
>      140764 ±  2%     -12.7%     122926 ±  5%  softirqs.CPU133.RCU
>      139626           -11.7%     123235 ±  5%  softirqs.CPU134.RCU
>      141210 ±  2%     -12.6%     123477 ±  5%  softirqs.CPU135.RCU
>      142996 ±  3%     -14.1%     122901 ±  5%  softirqs.CPU136.RCU
>      140567 ±  2%     -12.5%     123022 ±  6%  softirqs.CPU140.RCU
>       14192 ± 21%     -34.2%       9336 ± 18%  softirqs.CPU141.SCHED
>      135514 ±  2%      -9.8%     122294 ±  5%  softirqs.CPU142.RCU
>      134945 ±  2%     -10.0%     121501 ±  6%  softirqs.CPU143.RCU
>      145145           -13.0%     126309 ±  5%  softirqs.CPU16.RCU
>      144489 ±  2%     -13.3%     125217 ±  5%  softirqs.CPU17.RCU
>      138706 ±  4%     -12.0%     122092 ±  5%  softirqs.CPU18.RCU
>       15348 ±  4%     -10.0%      13810 ±  8%  softirqs.CPU18.SCHED
>      140870 ±  2%     -10.7%     125784 ±  3%  softirqs.CPU19.RCU
>       16392 ±  5%     -15.5%      13843 ±  6%  softirqs.CPU19.SCHED
>      143741 ±  2%     -12.4%     125852 ±  5%  softirqs.CPU2.RCU
>      140088           -11.7%     123663 ±  5%  softirqs.CPU20.RCU
>       16092 ±  3%     -14.0%      13832 ±  5%  softirqs.CPU20.SCHED
>      138206           -11.0%     123025 ±  5%  softirqs.CPU21.RCU
>       16877 ±  4%     -16.7%      14051 ±  4%  softirqs.CPU21.SCHED
>      138653           -11.4%     122814 ±  5%  softirqs.CPU22.RCU
>       17090 ±  3%     -19.3%      13797 ±  5%  softirqs.CPU22.SCHED
>       16476 ±  3%     -15.6%      13910 ±  5%  softirqs.CPU23.SCHED
>      138808           -11.2%     123204 ±  5%  softirqs.CPU24.RCU
>       16779           -16.2%      14060 ±  5%  softirqs.CPU24.SCHED
>      139811 ±  2%     -11.6%     123555 ±  5%  softirqs.CPU25.RCU
>       16734 ±  3%     -15.8%      14083 ±  7%  softirqs.CPU25.SCHED
>      138909           -10.9%     123758 ±  5%  softirqs.CPU26.RCU
>       16619 ±  5%     -15.0%      14133 ±  5%  softirqs.CPU26.SCHED
>      140257           -12.3%     123025 ±  5%  softirqs.CPU27.RCU
>       17013 ±  5%     -17.3%      14061 ±  5%  softirqs.CPU27.SCHED
>      137824           -11.2%     122428 ±  6%  softirqs.CPU28.RCU
>       16470 ±  2%     -15.4%      13927 ±  6%  softirqs.CPU28.SCHED
>      135294 ±  2%      -9.6%     122364 ±  6%  softirqs.CPU29.RCU
>       17350 ±  3%     -20.7%      13761 ±  5%  softirqs.CPU29.SCHED
>      142300 ±  3%     -13.1%     123621 ±  6%  softirqs.CPU3.RCU
>       17067           -18.4%      13927 ±  5%  softirqs.CPU30.SCHED
>       17110 ±  4%     -17.6%      14099 ±  7%  softirqs.CPU31.SCHED
>      145321           -14.0%     124914 ±  4%  softirqs.CPU32.RCU
>       16952 ±  3%     -16.0%      14234 ±  7%  softirqs.CPU32.SCHED
>      143684           -14.0%     123636 ±  5%  softirqs.CPU33.RCU
>       16728 ±  2%     -17.3%      13838 ±  5%  softirqs.CPU33.SCHED
>      143358           -13.4%     124129 ±  5%  softirqs.CPU34.RCU
>       17103 ±  3%     -17.7%      14082 ±  6%  softirqs.CPU34.SCHED
>      143430           -13.0%     124848 ±  5%  softirqs.CPU35.RCU
>       16705           -17.7%      13746 ±  4%  softirqs.CPU35.SCHED
>      139206           -11.5%     123261 ±  7%  softirqs.CPU36.RCU
>      140252           -12.7%     122378 ±  5%  softirqs.CPU37.RCU
>      140086           -12.6%     122492 ±  5%  softirqs.CPU39.RCU
>      140518           -13.4%     121743 ±  5%  softirqs.CPU40.RCU
>      138605           -11.7%     122371 ±  5%  softirqs.CPU41.RCU
>      141519           -13.5%     122418 ±  5%  softirqs.CPU42.RCU
>      142030           -13.7%     122637 ±  5%  softirqs.CPU43.RCU
>      140694           -13.4%     121845 ±  4%  softirqs.CPU44.RCU
>      140504           -12.1%     123545 ±  5%  softirqs.CPU45.RCU
>      140277           -12.7%     122435 ±  5%  softirqs.CPU46.RCU
>      137267           -11.2%     121919 ±  5%  softirqs.CPU47.RCU
>      140839           -12.9%     122646 ±  5%  softirqs.CPU48.RCU
>      141816           -13.3%     122937 ±  5%  softirqs.CPU49.RCU
>      140868 ±  2%     -12.0%     123942 ±  6%  softirqs.CPU5.RCU
>      143643           -14.1%     123392 ±  6%  softirqs.CPU50.RCU
>      141326           -12.7%     123403 ±  6%  softirqs.CPU51.RCU
>      141583           -13.4%     122613 ±  6%  softirqs.CPU52.RCU
>      141100           -13.2%     122445 ±  5%  softirqs.CPU53.RCU
>      139956           -12.1%     122981 ±  6%  softirqs.CPU54.RCU
>       14018 ± 17%     -29.8%       9845 ± 15%  softirqs.CPU54.SCHED
>      140114           -11.3%     124217 ±  5%  softirqs.CPU55.RCU
>      143329           -14.8%     122069 ±  6%  softirqs.CPU56.RCU
>      141146           -12.3%     123718 ±  6%  softirqs.CPU57.RCU
>       15264 ± 19%     -34.6%       9988 ± 17%  softirqs.CPU57.SCHED
>      140809           -12.4%     123330 ±  6%  softirqs.CPU58.RCU
>       15201 ± 20%     -36.3%       9678 ± 20%  softirqs.CPU58.SCHED
>      140568           -12.0%     123769 ±  5%  softirqs.CPU59.RCU
>       15360 ± 20%     -33.3%      10252 ± 19%  softirqs.CPU59.SCHED
>      139409 ±  3%     -10.9%     124281 ±  6%  softirqs.CPU6.RCU
>      141767           -12.7%     123768 ±  5%  softirqs.CPU60.RCU
>      142046           -12.9%     123657 ±  5%  softirqs.CPU61.RCU
>       15389 ± 22%     -34.7%      10052 ± 18%  softirqs.CPU61.SCHED
>      141719           -12.7%     123700 ±  5%  softirqs.CPU62.RCU
>      142499           -12.9%     124068 ±  6%  softirqs.CPU63.RCU
>       14667 ± 20%     -31.8%      10005 ± 18%  softirqs.CPU63.SCHED
>      144437           -14.1%     124008 ±  6%  softirqs.CPU64.RCU
>       15191 ± 22%     -35.9%       9736 ± 19%  softirqs.CPU64.SCHED
>      141156 ±  2%     -12.3%     123743 ±  6%  softirqs.CPU65.RCU
>      139859           -11.2%     124140 ±  6%  softirqs.CPU66.RCU
>      141282           -11.9%     124535 ±  6%  softirqs.CPU67.RCU
>      144228           -13.7%     124434 ±  6%  softirqs.CPU68.RCU
>      142536           -13.0%     123956 ±  6%  softirqs.CPU69.RCU
>      141103 ±  2%     -11.8%     124488 ±  6%  softirqs.CPU7.RCU
>      140849 ±  2%     -11.5%     124683 ±  6%  softirqs.CPU70.RCU
>      141347 ±  2%     -12.4%     123863 ±  6%  softirqs.CPU71.RCU
>      142552 ±  3%     -13.6%     123193 ±  5%  softirqs.CPU72.RCU
>      142074 ±  4%     -12.3%     124659 ±  7%  softirqs.CPU73.RCU
>      141649           -13.1%     123155 ±  5%  softirqs.CPU74.RCU
>      143525 ±  4%     -14.0%     123493 ±  6%  softirqs.CPU75.RCU
>      142772 ±  3%     -13.9%     122974 ±  7%  softirqs.CPU76.RCU
>      141178 ±  3%     -12.9%     122944 ±  5%  softirqs.CPU77.RCU
>      140777 ±  3%     -12.8%     122799 ±  5%  softirqs.CPU78.RCU
>      143039 ±  4%     -14.3%     122572 ±  5%  softirqs.CPU79.RCU
>      140336 ±  3%     -11.8%     123811 ±  6%  softirqs.CPU8.RCU
>      141727 ±  2%     -13.0%     123316 ±  5%  softirqs.CPU80.RCU
>      141813 ±  2%     -13.0%     123363 ±  5%  softirqs.CPU81.RCU
>      141978 ±  2%     -11.6%     125442 ±  3%  softirqs.CPU82.RCU
>      137611 ±  3%     -10.7%     122950 ±  5%  softirqs.CPU84.RCU
>      141077 ±  2%     -12.0%     124188 ±  5%  softirqs.CPU86.RCU
>      139221 ±  3%     -11.9%     122606 ±  5%  softirqs.CPU87.RCU
>      138177 ±  4%     -11.7%     121980 ±  5%  softirqs.CPU88.RCU
>      139882 ±  2%     -11.1%     124329 ±  5%  softirqs.CPU9.RCU
>      141843 ±  2%     -13.6%     122541 ±  6%  softirqs.CPU90.RCU
>       16251 ±  3%     -15.5%      13733 ±  5%  softirqs.CPU90.SCHED
>      143175 ±  2%     -14.1%     122926 ±  6%  softirqs.CPU91.RCU
>       17088 ±  3%     -19.2%      13801 ±  7%  softirqs.CPU91.SCHED
>      144768           -14.7%     123542 ±  5%  softirqs.CPU92.RCU
>       16851 ±  2%     -20.1%      13462 ±  4%  softirqs.CPU92.SCHED
>      144398 ±  4%     -13.4%     125018 ±  3%  softirqs.CPU93.RCU
>       16917 ±  3%     -19.9%      13559 ±  6%  softirqs.CPU93.SCHED
>      142957 ±  2%     -13.6%     123521 ±  5%  softirqs.CPU94.RCU
>       16758 ±  2%     -17.8%      13773 ±  4%  softirqs.CPU94.SCHED
>      141885           -13.8%     122263 ±  6%  softirqs.CPU95.RCU
>       16161 ±  5%     -14.7%      13789 ±  6%  softirqs.CPU95.SCHED
>      138647           -11.8%     122297 ±  5%  softirqs.CPU96.RCU
>       16590 ±  3%     -16.8%      13804 ±  8%  softirqs.CPU96.SCHED
>       15776 ±  3%     -13.0%      13731 ±  7%  softirqs.CPU97.SCHED
>       16115           -10.6%      14405 ±  5%  softirqs.CPU98.SCHED
>      140827           -12.8%     122846 ±  5%  softirqs.CPU99.RCU
>       16252 ±  4%     -16.2%      13623 ±  5%  softirqs.CPU99.SCHED
>    20190421           -12.1%   17737370 ±  5%  softirqs.RCU
>     2133170           -16.1%    1790167 ±  4%  softirqs.SCHED
> 
> 
>                                                                                  
>                             vm-scalability.time.system_time
>                                                                                  
>    22500 +-------------------------------------------------------------------+
>    22000 |-+                                                          O    O |
>          |      O    O    O                                 O                |
>    21500 |-O            O      O           O    O O  O                       |
>    21000 |-+  O    O             O  O    O   O            O   O  O O    O    |
>    20500 |-+                O         O                O                     |
>    20000 |-+                                                                 |
>          |                                                                   |
>    19500 |-+                                                                 |
>    19000 |-+                                                                 |
>    18500 |-+            +                                                    |
>    18000 |.+..     +   + :                                                   |
>          |       .. + +  : .+..  +..  +                                      |
>    17500 |-+  +.+    +    +     +    +                                       |
>    17000 +-------------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                     vm-scalability.time.percent_of_cpu_this_job_got
>                                                                                  
>    11400 +-------------------------------------------------------------------+
>    11300 |-+              O                       O  O O  O   O  O O  O      |
>          | O  O O  O O  O      O O    O  O O O  O           O           O  O |
>    11200 |-+                O       O                                        |
>    11100 |-+                                                                 |
>          |                                                                   |
>    11000 |-+                                                                 |
>    10900 |-+                                                                 |
>    10800 |-+                                                                 |
>          |                                                                   |
>    10700 |-+                                                                 |
>    10600 |-+                                                                 |
>          |.+..    .+.  .+.      .+.. .+                                      |
>    10500 |-+  +.+.   +.   +.+..+    +                                        |
>    10400 +-------------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                      vm-scalability.time.voluntary_context_switches
>                                                                                  
>    1.3e+06 +-----------------------------------------------------------------+
>    1.2e+06 |.+                                                               |
>            |  +              .+.  .+. .+                                     |
>    1.1e+06 |-+ + .+.+..+.+..+   +.   +                                       |
>      1e+06 |-+  +                                                            |
>            |                                                                 |
>     900000 |-+                                                               |
>     800000 |-+                                                               |
>     700000 |-+                                                               |
>            |                                                                 |
>     600000 |-+                                                               |
>     500000 |-+                                                               |
>            |    O      O      O O    O O  O O O  O O O           O           |
>     400000 |-O    O O    O  O      O                    O O  O O    O O O  O |
>     300000 +-----------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                                 vm-scalability.throughput
>                                                                                  
>    3.2e+07 +-----------------------------------------------------------------+
>            | +..                                                             |
>    3.1e+07 |++                                                               |
>            |    +.+.  .+.  .+.+.+..+.+.+                                     |
>      3e+07 |-+      +.   +.                                                  |
>            |                                                                 |
>    2.9e+07 |-+                                                               |
>            |                                                                 |
>    2.8e+07 |-+                                                               |
>            |                                                                 |
>    2.7e+07 |-+                                                               |
>            |                                                                 |
>    2.6e+07 |-+  O             O        O  O O O  O O O  O O      O  O        |
>            | O    O O  O O  O   O  O O                         O      O O    |
>    2.5e+07 +-----------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                                  vm-scalability.median
>                                                                                  
>    220000 +------------------------------------------------------------------+
>    215000 |-+..                                                              |
>           |+   +.+.. .+.  .+.+..+.+.+..+                                     |
>    210000 |-+       +   +.                                                   |
>    205000 |-+                                                                |
>           |                                                                  |
>    200000 |-+                                                                |
>    195000 |-+                                                                |
>    190000 |-+                                                                |
>           |                                                                  |
>    185000 |-+                                                                |
>    180000 |-+  O             O    O O  O O  O O O  O O O  O      O O         |
>           | O    O  O O O  O    O                           O  O      O O    |
>    175000 |-+                                                              O |
>    170000 +------------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                                  vm-scalability.workload
>                                                                                  
>    8.4e+09 +-----------------------------------------------------------------+
>            | +                                                               |
>    8.2e+09 |:++                                                              |
>            |:  +                                                             |
>      8e+09 |-+  +.+.+..+.+..+.+.+..+.+.+                                     |
>            |                                                                 |
>    7.8e+09 |-+                                                               |
>            |                                                                 |
>    7.6e+09 |-+                                                               |
>            |                                                                 |
>    7.4e+09 |-+                                                               |
>            |                                                                 |
>    7.2e+09 |-+                                                               |
>            | O  O O O  O O  O O O  O O O  O O O  O O O  O O  O O O  O O O  O |
>      7e+09 +-----------------------------------------------------------------+
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
> Oliver Sang
> 
> 
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
> 

-- 
Zhengjun Xing
