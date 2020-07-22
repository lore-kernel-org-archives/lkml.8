Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7526EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2566820729
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732003AbgGVHVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:21:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:2895 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730238AbgGVHVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:21:15 -0400
IronPort-SDR: hvO8gqzs7pXrlySU/nTFr+gXXKwrzMJyzudKSG+G1A9xLMzfEETgkzEntFHcV2AyDZ4ZzyzTO9
 l4cStLI6Ly3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="168422208"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="168422208"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 23:27:08 -0700
IronPort-SDR: KFZ/OfWX6nCGw8nPmFOWLyLZ8P0tiYefAzmj/sLYksYbWun8FtH0/AgzafXPVGAUJ4Lay0tG9j
 OvaKfWeSTWBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="318577685"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.238.4.18]) ([10.238.4.18])
  by orsmga008.jf.intel.com with ESMTP; 21 Jul 2020 23:27:02 -0700
Subject: Re: [LKP] [xfs] a5949d3fae: aim7.jobs-per-min -33.6% regression
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Brian Foster <bfoster@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200606154812.GQ12456@shao2-debian>
 <a080165c-824f-3d48-44e8-388fa94d32fe@linux.intel.com>
 <45df2ba8-6089-463e-670d-ee34a0b3d36c@linux.intel.com>
 <20200706183056.GY7625@magnolia>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <e6c86bb8-79a0-1add-370e-1c1c6e593569@linux.intel.com>
Date:   Wed, 22 Jul 2020 14:27:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200706183056.GY7625@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/7/2020 2:30 AM, Darrick J. Wong wrote:
> On Wed, Jul 01, 2020 at 03:49:52PM +0800, Xing Zhengjun wrote:
>>
>>
>> On 6/10/2020 11:07 AM, Xing Zhengjun wrote:
>>> Hi Darrick,
>>>
>>>      Do you have time to take a look at this? Thanks.
>>>
>>
>>
>> Ping...
> 
> Yes, that decrease is the expected end result of making the write path
> take a longer route to avoid a file corruption vector.
> 
> --D
> 

Thanks for the explanation, We will stop tracking it.

>>
>>
>>> On 6/6/2020 11:48 PM, kernel test robot wrote:
>>>> Greeting,
>>>>
>>>> FYI, we noticed a -33.6% regression of aim7.jobs-per-min due to commit:
>>>>
>>>>
>>>> commit: a5949d3faedf492fa7863b914da408047ab46eb0 ("xfs: force writes
>>>> to delalloc regions to unwritten")
>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>>
>>>> in testcase: aim7
>>>> on test machine: 48 threads Intel(R) Xeon(R) CPU E5-2697 v2 @
>>>> 2.70GHz with 64G memory
>>>> with following parameters:
>>>>
>>>>      disk: 1BRD_48G
>>>>      fs: xfs
>>>>      test: sync_disk_rw
>>>>      load: 600
>>>>      cpufreq_governor: performance
>>>>      ucode: 0x42e
>>>>
>>>> test-description: AIM7 is a traditional UNIX system level benchmark
>>>> suite which is used to test and measure the performance of multiuser
>>>> system.
>>>> test-url: https://sourceforge.net/projects/aimbench/files/aim-suite7/
>>>>
>>>>
>>>>
>>>> If you fix the issue, kindly add following tag
>>>> Reported-by: kernel test robot <rong.a.chen@intel.com>
>>>>
>>>>
>>>> Details are as below:
>>>> -------------------------------------------------------------------------------------------------->
>>>>
>>>>
>>>>
>>>> To reproduce:
>>>>
>>>>           git clone https://github.com/intel/lkp-tests.git
>>>>           cd lkp-tests
>>>>           bin/lkp install job.yaml  # job file is attached in this email
>>>>           bin/lkp run     job.yaml
>>>>
>>>> =========================================================================================
>>>>
>>>> compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase/ucode:
>>>>
>>>>      gcc-9/performance/1BRD_48G/xfs/x86_64-rhel-7.6/600/debian-x86_64-20191114.cgz/lkp-ivb-2ep1/sync_disk_rw/aim7/0x42e
>>>>
>>>>
>>>> commit:
>>>>     590b16516e ("xfs: refactor xfs_iomap_prealloc_size")
>>>>     a5949d3fae ("xfs: force writes to delalloc regions to unwritten")
>>>>
>>>> 590b16516ef38e2e a5949d3faedf492fa7863b914da
>>>> ---------------- ---------------------------
>>>>          fail:runs  %reproduction    fail:runs
>>>>              |             |             |
>>>>              :4           50%           2:4
>>>> dmesg.WARNING:at#for_ip_swapgs_restore_regs_and_return_to_usermode/0x
>>>>            %stddev     %change         %stddev
>>>>                \          |                \
>>>>        35272           -33.6%      23430        aim7.jobs-per-min
>>>>       102.13           +50.5%     153.75        aim7.time.elapsed_time
>>>>       102.13           +50.5%     153.75        aim7.time.elapsed_time.max
>>>>      1388038           +40.2%    1945838
>>>> aim7.time.involuntary_context_switches
>>>>        43420 ±  2%     +13.4%      49255 ±  2%
>>>> aim7.time.minor_page_faults
>>>>         3123           +44.2%       4504 ±  2%  aim7.time.system_time
>>>>        59.31            +6.5%      63.18        aim7.time.user_time
>>>>     48595108           +58.6%   77064959
>>>> aim7.time.voluntary_context_switches
>>>>         1.44           -28.8%       1.02        iostat.cpu.user
>>>>         0.07 ±  6%      +0.4        0.44 ±  7%  mpstat.cpu.all.iowait%
>>>>         1.44            -0.4        1.02        mpstat.cpu.all.usr%
>>>>         8632 ± 50%     +75.6%      15156 ± 34%
>>>> numa-meminfo.node0.KernelStack
>>>>         6583 ±136%    +106.0%      13562 ± 82%
>>>> numa-meminfo.node0.PageTables
>>>>        63325 ± 11%     +14.3%      72352 ± 12%
>>>> numa-meminfo.node0.SUnreclaim
>>>>         8647 ± 50%     +75.3%      15156 ± 34%
>>>> numa-vmstat.node0.nr_kernel_stack
>>>>         1656 ±136%    +104.6%       3389 ± 82%
>>>> numa-vmstat.node0.nr_page_table_pages
>>>>        15831 ± 11%     +14.3%      18087 ± 12%
>>>> numa-vmstat.node0.nr_slab_unreclaimable
>>>>        93640 ±  3%     +41.2%     132211 ±  2%  meminfo.AnonHugePages
>>>>        21641           +39.9%      30271 ±  4%  meminfo.KernelStack
>>>>       129269           +12.3%     145114        meminfo.SUnreclaim
>>>>        28000           -31.2%      19275        meminfo.max_used_kB
>>>>      1269307           -26.9%     927657        vmstat.io.bo
>>>>       149.75 ±  3%     -17.4%     123.75 ±  4%  vmstat.procs.r
>>>>       718992           +13.3%     814567        vmstat.system.cs
>>>>       231397            -9.3%     209881 ±  2%  vmstat.system.in
>>>>    6.774e+08           +70.0%  1.152e+09        cpuidle.C1.time
>>>>     18203372           +60.4%   29198744        cpuidle.C1.usage
>>>>    2.569e+08 ± 18%     +81.8%  4.672e+08 ±  5%  cpuidle.C1E.time
>>>>      2691402 ± 13%     +98.7%    5346901 ±  3%  cpuidle.C1E.usage
>>>>       990350           +95.0%    1931226 ±  2%  cpuidle.POLL.time
>>>>       520061           +97.7%    1028004 ±  2%  cpuidle.POLL.usage
>>>>        77231            +1.8%      78602        proc-vmstat.nr_active_anon
>>>>        19868            +3.8%      20615        proc-vmstat.nr_dirty
>>>>       381302            +1.0%     384969        proc-vmstat.nr_file_pages
>>>>         4388            -2.7%       4270
>>>> proc-vmstat.nr_inactive_anon
>>>>        69865            +4.7%      73155
>>>> proc-vmstat.nr_inactive_file
>>>>        21615           +40.0%      30251 ±  4%
>>>> proc-vmstat.nr_kernel_stack
>>>>         7363            -3.2%       7127        proc-vmstat.nr_mapped
>>>>        12595 ±  3%      +5.2%      13255 ±  4%  proc-vmstat.nr_shmem
>>>>        19619            +3.2%      20247
>>>> proc-vmstat.nr_slab_reclaimable
>>>>        32316           +12.3%      36280
>>>> proc-vmstat.nr_slab_unreclaimable
>>>>        77231            +1.8%      78602
>>>> proc-vmstat.nr_zone_active_anon
>>>>         4388            -2.7%       4270
>>>> proc-vmstat.nr_zone_inactive_anon
>>>>        69865            +4.7%      73155
>>>> proc-vmstat.nr_zone_inactive_file
>>>>        19165            +3.4%      19824
>>>> proc-vmstat.nr_zone_write_pending
>>>>         9845 ± 27%     +68.0%      16539 ± 37%
>>>> proc-vmstat.numa_hint_faults_local
>>>>      8195135            +2.5%    8402537        proc-vmstat.numa_hit
>>>>      8179414            +2.5%    8386209        proc-vmstat.numa_local
>>>>        15720            +3.9%      16328        proc-vmstat.numa_other
>>>>      8281098            +2.4%    8477157        proc-vmstat.pgalloc_normal
>>>>       342925 ±  2%     +39.8%     479279        proc-vmstat.pgfault
>>>>      8132789            +2.0%    8298189        proc-vmstat.pgfree
>>>>    1.327e+08            +9.7%  1.455e+08        proc-vmstat.pgpgout
>>>>       394.00          +151.7%     991.75 ±  5%
>>>> slabinfo.biovec-max.active_objs
>>>>       394.00          +152.1%     993.25 ±  5%
>>>> slabinfo.biovec-max.num_objs
>>>>        21028 ±  6%      -7.8%      19389 ±  5%  slabinfo.filp.active_objs
>>>>        21520 ±  5%      -7.6%      19886 ±  5%  slabinfo.filp.num_objs
>>>>         4955          +234.9%      16594 ±  2%
>>>> slabinfo.kmalloc-256.active_objs
>>>>        77.25          +238.5%     261.50 ±  2%
>>>> slabinfo.kmalloc-256.active_slabs
>>>>         4955          +238.4%      16768 ±  2%
>>>> slabinfo.kmalloc-256.num_objs
>>>>        77.25          +238.5%     261.50 ±  2%
>>>> slabinfo.kmalloc-256.num_slabs
>>>>         3368 ±  2%     +22.6%       4128 ±  2%
>>>> slabinfo.kmalloc-2k.active_objs
>>>>         3446 ±  2%     +21.9%       4200 ±  2%
>>>> slabinfo.kmalloc-2k.num_objs
>>>>        11815 ±  8%     +29.0%      15239 ±  3%
>>>> slabinfo.kmalloc-512.active_objs
>>>>        11824 ±  9%     +29.0%      15249 ±  3%
>>>> slabinfo.kmalloc-512.num_objs
>>>>         6849 ±  5%      +9.0%       7463 ±  2%
>>>> slabinfo.kmalloc-96.active_objs
>>>>         6906 ±  5%      +8.9%       7521 ±  2%
>>>> slabinfo.kmalloc-96.num_objs
>>>>       765.00 ±  4%     +25.0%     956.25 ±  5%
>>>> slabinfo.mnt_cache.active_objs
>>>>       765.00 ±  4%     +25.0%     956.25 ±  5%
>>>> slabinfo.mnt_cache.num_objs
>>>>        13866           +12.5%      15594
>>>> slabinfo.proc_inode_cache.active_objs
>>>>        13905           +12.2%      15598
>>>> slabinfo.proc_inode_cache.num_objs
>>>>         1954           +24.4%       2431 ±  3%
>>>> slabinfo.sighand_cache.active_objs
>>>>         1954           +24.4%       2431 ±  3%
>>>> slabinfo.sighand_cache.num_objs
>>>>         2596           +13.7%       2951 ±  2%
>>>> slabinfo.signal_cache.active_objs
>>>>         2596           +13.7%       2951 ±  2%
>>>> slabinfo.signal_cache.num_objs
>>>>         4368 ±  6%     -11.7%       3856 ±  2%
>>>> slabinfo.skbuff_head_cache.num_objs
>>>>       822.25 ± 11%     +21.4%     998.50 ±  3%
>>>> slabinfo.task_group.active_objs
>>>>       822.25 ± 11%     +21.4%     998.50 ±  3%
>>>> slabinfo.task_group.num_objs
>>>>         1612           +32.1%       2129 ±  3%
>>>> slabinfo.task_struct.active_objs
>>>>       540.50           +31.6%     711.25 ±  3%
>>>> slabinfo.task_struct.active_slabs
>>>>         1622           +31.6%       2134 ±  3%
>>>> slabinfo.task_struct.num_objs
>>>>       540.50           +31.6%     711.25 ±  3%
>>>> slabinfo.task_struct.num_slabs
>>>>         6905           +20.0%       8289
>>>> slabinfo.vmap_area.active_objs
>>>>         6933           +20.0%       8322
>>>> slabinfo.vmap_area.num_objs
>>>>       646.25 ±  7%    +195.2%       1907
>>>> slabinfo.xfs_buf.active_objs
>>>>       646.25 ±  7%    +195.2%       1907        slabinfo.xfs_buf.num_objs
>>>>         1.78 ±  2%      -0.3        1.51 ±  2%
>>>> perf-stat.i.branch-miss-rate%
>>>>     64079048            +3.9%   66551536        perf-stat.i.branch-misses
>>>>        17.99            -4.2       13.84
>>>> perf-stat.i.cache-miss-rate%
>>>>     66630506           -16.5%   55647472        perf-stat.i.cache-misses
>>>>    3.899e+08            +9.4%  4.265e+08
>>>> perf-stat.i.cache-references
>>>>       731029           +13.1%     826756
>>>> perf-stat.i.context-switches
>>>>         3.79            -1.7%       3.73        perf-stat.i.cpi
>>>>       113320            +8.3%     122693        perf-stat.i.cpu-migrations
>>>>         1498           +20.4%       1803
>>>> perf-stat.i.cycles-between-cache-misses
>>>>     50450547 ±  4%      -8.0%   46402743 ±  5%
>>>> perf-stat.i.dTLB-load-misses
>>>>         0.20 ±  3%      -0.0        0.16 ±  2%
>>>> perf-stat.i.dTLB-store-miss-rate%
>>>>      4587096 ±  3%     -22.9%    3538422 ±  2%
>>>> perf-stat.i.dTLB-store-misses
>>>>    2.297e+09            -5.6%  2.168e+09        perf-stat.i.dTLB-stores
>>>>        86.68            -2.4       84.25
>>>> perf-stat.i.iTLB-load-miss-rate%
>>>>     19484791            -6.1%   18297125
>>>> perf-stat.i.iTLB-load-misses
>>>>      3060023           +14.4%    3501587 ±  4%  perf-stat.i.iTLB-loads
>>>>         0.29            -1.5%       0.28        perf-stat.i.ipc
>>>>         0.21 ±  5%     -20.5%       0.17 ±  6%  perf-stat.i.metric.K/sec
>>>>         3120            -5.8%       2938        perf-stat.i.minor-faults
>>>>        42.61            +1.2       43.83
>>>> perf-stat.i.node-load-miss-rate%
>>>>     24887573           -10.1%   22384693
>>>> perf-stat.i.node-load-misses
>>>>     31814752           -12.5%   27830232        perf-stat.i.node-loads
>>>>        36.62            +0.8       37.45
>>>> perf-stat.i.node-store-miss-rate%
>>>>     22617213           -20.3%   18015607
>>>> perf-stat.i.node-store-misses
>>>>     35707079           -19.9%   28604167        perf-stat.i.node-stores
>>>>         3120            -5.8%       2938        perf-stat.i.page-faults
>>>>        13.96            +9.3%      15.25        perf-stat.overall.MPKI
>>>>         0.99            +0.0        1.03
>>>> perf-stat.overall.branch-miss-rate%
>>>>        17.09            -4.0       13.05
>>>> perf-stat.overall.cache-miss-rate%
>>>>         1555           +19.4%       1856
>>>> perf-stat.overall.cycles-between-cache-misses
>>>>         0.69 ±  4%      -0.1        0.64 ±  5%
>>>> perf-stat.overall.dTLB-load-miss-rate%
>>>>         0.20 ±  3%      -0.0        0.16 ±  2%
>>>> perf-stat.overall.dTLB-store-miss-rate%
>>>>        86.43            -2.5       83.94
>>>> perf-stat.overall.iTLB-load-miss-rate%
>>>>         1433            +6.7%       1528
>>>> perf-stat.overall.instructions-per-iTLB-miss
>>>>        43.89            +0.7       44.58
>>>> perf-stat.overall.node-load-miss-rate%
>>>>    6.389e+09            +0.8%  6.438e+09
>>>> perf-stat.ps.branch-instructions
>>>>     63452800            +4.2%   66110454        perf-stat.ps.branch-misses
>>>>     65977234           -16.2%   55277568        perf-stat.ps.cache-misses
>>>>    3.861e+08            +9.8%  4.237e+08
>>>> perf-stat.ps.cache-references
>>>>       723870           +13.5%     821265
>>>> perf-stat.ps.context-switches
>>>>       112209            +8.6%     121881
>>>> perf-stat.ps.cpu-migrations
>>>>     49955941 ±  4%      -7.7%   46094243 ±  5%
>>>> perf-stat.ps.dTLB-load-misses
>>>>      4542094 ±  3%     -22.6%    3514899 ±  2%
>>>> perf-stat.ps.dTLB-store-misses
>>>>    2.275e+09            -5.3%  2.154e+09        perf-stat.ps.dTLB-stores
>>>>     19294019            -5.8%   18175580
>>>> perf-stat.ps.iTLB-load-misses
>>>>      3030049           +14.8%    3478314 ±  4%  perf-stat.ps.iTLB-loads
>>>>         3089            -5.5%       2918        perf-stat.ps.minor-faults
>>>>     24643655            -9.8%   22235787
>>>> perf-stat.ps.node-load-misses
>>>>     31502901           -12.2%   27645143        perf-stat.ps.node-loads
>>>>     22395376           -20.1%   17895417
>>>> perf-stat.ps.node-store-misses
>>>>     35356897           -19.6%   28413366        perf-stat.ps.node-stores
>>>>         3089            -5.5%       2918        perf-stat.ps.page-faults
>>>>     2.85e+12           +50.6%  4.293e+12
>>>> perf-stat.total.instructions
>>>>        84193 ± 36%    +135.9%     198575 ± 25%
>>>> sched_debug.cfs_rq:/.MIN_vruntime.avg
>>>>       919053           +98.2%    1821460 ±  2%
>>>> sched_debug.cfs_rq:/.MIN_vruntime.max
>>>>       256686 ± 16%    +114.7%     551162 ± 13%
>>>> sched_debug.cfs_rq:/.MIN_vruntime.stddev
>>>>        19497          +106.7%      40307
>>>> sched_debug.cfs_rq:/.exec_clock.avg
>>>>        21240          +101.1%      42717
>>>> sched_debug.cfs_rq:/.exec_clock.max
>>>>        19079          +107.3%      39542
>>>> sched_debug.cfs_rq:/.exec_clock.min
>>>>       394.52 ±  2%     +54.3%     608.79 ± 13%
>>>> sched_debug.cfs_rq:/.exec_clock.stddev
>>>>       965.25 ± 15%     +59.7%       1541 ±  4%
>>>> sched_debug.cfs_rq:/.load_avg.avg
>>>>         2866 ± 21%     +57.1%       4503 ± 10%
>>>> sched_debug.cfs_rq:/.load_avg.max
>>>>       659.77 ± 15%     +68.9%       1114 ±  9%
>>>> sched_debug.cfs_rq:/.load_avg.stddev
>>>>        84193 ± 36%    +135.9%     198575 ± 25%
>>>> sched_debug.cfs_rq:/.max_vruntime.avg
>>>>       919053           +98.2%    1821462 ±  2%
>>>> sched_debug.cfs_rq:/.max_vruntime.max
>>>>       256686 ± 16%    +114.7%     551163 ± 13%
>>>> sched_debug.cfs_rq:/.max_vruntime.stddev
>>>>       901765           +97.1%    1777741 ±  2%
>>>> sched_debug.cfs_rq:/.min_vruntime.avg
>>>>       941794           +95.8%    1844445 ±  2%
>>>> sched_debug.cfs_rq:/.min_vruntime.max
>>>>       872925           +96.5%    1715658 ±  2%
>>>> sched_debug.cfs_rq:/.min_vruntime.min
>>>>        18358 ± 44%    +146.6%      45281 ± 34%
>>>> sched_debug.cfs_rq:/.min_vruntime.stddev
>>>>         1.22 ±  8%    +159.9%       3.18 ± 20%
>>>> sched_debug.cfs_rq:/.nr_spread_over.avg
>>>>         6.75 ± 23%     +65.4%      11.17 ± 17%
>>>> sched_debug.cfs_rq:/.nr_spread_over.max
>>>>         1.38 ± 11%     +61.4%       2.22 ± 12%
>>>> sched_debug.cfs_rq:/.nr_spread_over.stddev
>>>>        18357 ± 44%    +146.5%      45250 ± 34%
>>>> sched_debug.cfs_rq:/.spread0.stddev
>>>>       773.25 ±  3%     +13.2%     875.02
>>>> sched_debug.cfs_rq:/.util_avg.avg
>>>>       285624           -30.3%     199111 ±  4%
>>>> sched_debug.cpu.avg_idle.avg
>>>>       576507 ±  2%     -26.2%     425271 ±  7%
>>>> sched_debug.cpu.avg_idle.max
>>>>        51029 ± 68%     -83.4%       8469 ± 29%
>>>> sched_debug.cpu.avg_idle.min
>>>>       135149 ±  7%     -23.4%     103460 ± 10%
>>>> sched_debug.cpu.avg_idle.stddev
>>>>        57492           +51.0%      86835        sched_debug.cpu.clock.avg
>>>>        57495           +51.0%      86841        sched_debug.cpu.clock.max
>>>>        57487           +51.0%      86828        sched_debug.cpu.clock.min
>>>>         1.98 ±  4%     +74.8%       3.46 ± 10%
>>>> sched_debug.cpu.clock.stddev
>>>>        57492           +51.0%      86835
>>>> sched_debug.cpu.clock_task.avg
>>>>        57495           +51.0%      86841
>>>> sched_debug.cpu.clock_task.max
>>>>        57487           +51.0%      86828
>>>> sched_debug.cpu.clock_task.min
>>>>         1.98 ±  4%     +74.8%       3.46 ± 10%
>>>> sched_debug.cpu.clock_task.stddev
>>>>         2831           +43.0%       4049
>>>> sched_debug.cpu.curr->pid.max
>>>>       417519          +133.3%     974078
>>>> sched_debug.cpu.nr_switches.avg
>>>>       427854          +134.0%    1001016
>>>> sched_debug.cpu.nr_switches.max
>>>>       409942          +131.8%     950218
>>>> sched_debug.cpu.nr_switches.min
>>>>         4770 ± 42%    +238.7%      16156 ± 22%
>>>> sched_debug.cpu.nr_switches.stddev
>>>>         4.70 ± 23%     +37.1%       6.44 ±  4%
>>>> sched_debug.cpu.nr_uninterruptible.avg
>>>>       776.62 ± 19%     +86.1%       1445 ± 12%
>>>> sched_debug.cpu.nr_uninterruptible.max
>>>>      -472.62           +98.3%    -937.33
>>>> sched_debug.cpu.nr_uninterruptible.min
>>>>       289.80 ±  5%    +109.7%     607.68 ±  3%
>>>> sched_debug.cpu.nr_uninterruptible.stddev
>>>>       415893          +133.8%     972526
>>>> sched_debug.cpu.sched_count.avg
>>>>       423960          +135.5%     998457
>>>> sched_debug.cpu.sched_count.max
>>>>       409113          +132.0%     949068
>>>> sched_debug.cpu.sched_count.min
>>>>         4194 ± 50%    +274.3%      15698 ± 22%
>>>> sched_debug.cpu.sched_count.stddev
>>>>       110094          +125.8%     248571
>>>> sched_debug.cpu.sched_goidle.avg
>>>>       112236          +125.6%     253163
>>>> sched_debug.cpu.sched_goidle.max
>>>>       108281          +125.8%     244506
>>>> sched_debug.cpu.sched_goidle.min
>>>>       772.04 ± 16%    +175.8%       2129 ± 18%
>>>> sched_debug.cpu.sched_goidle.stddev
>>>>       297267          +137.2%     705173
>>>> sched_debug.cpu.ttwu_count.avg
>>>>       320112          +135.9%     755096
>>>> sched_debug.cpu.ttwu_count.max
>>>>       272487 ±  2%    +142.2%     660099
>>>> sched_debug.cpu.ttwu_count.min
>>>>        10662 ± 10%    +110.9%      22491 ± 18%
>>>> sched_debug.cpu.ttwu_count.stddev
>>>>        12295 ±  2%    +834.9%     114954 ±  2%
>>>> sched_debug.cpu.ttwu_local.avg
>>>>        13726 ±  2%    +769.7%     119376 ±  2%
>>>> sched_debug.cpu.ttwu_local.max
>>>>        10620 ±  4%    +942.4%     110710
>>>> sched_debug.cpu.ttwu_local.min
>>>>       693.29 ± 14%    +228.7%       2278 ± 18%
>>>> sched_debug.cpu.ttwu_local.stddev
>>>>        57488           +51.0%      86829        sched_debug.cpu_clk
>>>>        56998           +51.5%      86337        sched_debug.ktime
>>>>        57977           +50.6%      87317        sched_debug.sched_clk
>>>>        72.50 ± 37%     +55.5%     112.75 ± 26%
>>>> interrupts.36:PCI-MSI.2621442-edge.eth0-TxRx-1
>>>>        53.25 ±  2%     +84.5%      98.25 ± 22%
>>>> interrupts.37:PCI-MSI.2621443-edge.eth0-TxRx-2
>>>>        73.50 ± 26%    +116.3%     159.00 ± 60%
>>>> interrupts.38:PCI-MSI.2621444-edge.eth0-TxRx-3
>>>>       204541           +49.0%     304702 ±  2%
>>>> interrupts.CPU0.LOC:Local_timer_interrupts
>>>>       290268 ±  2%     +29.1%     374641 ±  4%
>>>> interrupts.CPU0.RES:Rescheduling_interrupts
>>>>       204580           +48.9%     304667 ±  2%
>>>> interrupts.CPU1.LOC:Local_timer_interrupts
>>>>       290342 ±  2%     +28.5%     373110 ±  4%
>>>> interrupts.CPU1.RES:Rescheduling_interrupts
>>>>       204537           +48.9%     304619 ±  2%
>>>> interrupts.CPU10.LOC:Local_timer_interrupts
>>>>       291605 ±  2%     +28.3%     374190 ±  4%
>>>> interrupts.CPU10.RES:Rescheduling_interrupts
>>>>       204140           +49.2%     304587 ±  2%
>>>> interrupts.CPU11.LOC:Local_timer_interrupts
>>>>       291988 ±  2%     +28.1%     374024 ±  4%
>>>> interrupts.CPU11.RES:Rescheduling_interrupts
>>>>       204367           +49.0%     304559 ±  2%
>>>> interrupts.CPU12.LOC:Local_timer_interrupts
>>>>       288632           +28.4%     370669 ±  3%
>>>> interrupts.CPU12.RES:Rescheduling_interrupts
>>>>       204555           +48.9%     304669 ±  2%
>>>> interrupts.CPU13.LOC:Local_timer_interrupts
>>>>       289354 ±  2%     +28.5%     371782 ±  3%
>>>> interrupts.CPU13.RES:Rescheduling_interrupts
>>>>       204536           +49.0%     304726 ±  2%
>>>> interrupts.CPU14.LOC:Local_timer_interrupts
>>>>         4937 ± 25%     +41.6%       6991 ±  2%
>>>> interrupts.CPU14.NMI:Non-maskable_interrupts
>>>>         4937 ± 25%     +41.6%       6991 ±  2%
>>>> interrupts.CPU14.PMI:Performance_monitoring_interrupts
>>>>       287759           +28.2%     368986 ±  3%
>>>> interrupts.CPU14.RES:Rescheduling_interrupts
>>>>       204527           +49.0%     304707 ±  2%
>>>> interrupts.CPU15.LOC:Local_timer_interrupts
>>>>       286950           +28.6%     369104 ±  3%
>>>> interrupts.CPU15.RES:Rescheduling_interrupts
>>>>       204556           +49.0%     304718 ±  2%
>>>> interrupts.CPU16.LOC:Local_timer_interrupts
>>>>         5444 ± 32%     -19.9%       4360 ± 32%
>>>> interrupts.CPU16.NMI:Non-maskable_interrupts
>>>>         5444 ± 32%     -19.9%       4360 ± 32%
>>>> interrupts.CPU16.PMI:Performance_monitoring_interrupts
>>>>       287623           +28.1%     368583 ±  3%
>>>> interrupts.CPU16.RES:Rescheduling_interrupts
>>>>       204528           +49.0%     304728 ±  2%
>>>> interrupts.CPU17.LOC:Local_timer_interrupts
>>>>       287734           +28.2%     368920 ±  3%
>>>> interrupts.CPU17.RES:Rescheduling_interrupts
>>>>       204465           +49.0%     304707 ±  2%
>>>> interrupts.CPU18.LOC:Local_timer_interrupts
>>>>         5382 ± 31%     -21.8%       4211 ± 27%
>>>> interrupts.CPU18.NMI:Non-maskable_interrupts
>>>>         5382 ± 31%     -21.8%       4211 ± 27%
>>>> interrupts.CPU18.PMI:Performance_monitoring_interrupts
>>>>       288778           +28.1%     369871 ±  3%
>>>> interrupts.CPU18.RES:Rescheduling_interrupts
>>>>       204302           +49.2%     304727 ±  2%
>>>> interrupts.CPU19.LOC:Local_timer_interrupts
>>>>       289794           +27.8%     370247 ±  3%
>>>> interrupts.CPU19.RES:Rescheduling_interrupts
>>>>       204552           +49.0%     304821 ±  2%
>>>> interrupts.CPU2.LOC:Local_timer_interrupts
>>>>       291056 ±  2%     +28.3%     373290 ±  4%
>>>> interrupts.CPU2.RES:Rescheduling_interrupts
>>>>       204468           +48.9%     304484 ±  2%
>>>> interrupts.CPU20.LOC:Local_timer_interrupts
>>>>       290778           +27.6%     371106 ±  3%
>>>> interrupts.CPU20.RES:Rescheduling_interrupts
>>>>       204546           +48.9%     304619 ±  2%
>>>> interrupts.CPU21.LOC:Local_timer_interrupts
>>>>       289974           +28.0%     371074 ±  3%
>>>> interrupts.CPU21.RES:Rescheduling_interrupts
>>>>       204694           +48.8%     304581 ±  2%
>>>> interrupts.CPU22.LOC:Local_timer_interrupts
>>>>       290312           +28.0%     371734 ±  3%
>>>> interrupts.CPU22.RES:Rescheduling_interrupts
>>>>       204374           +49.0%     304493 ±  2%
>>>> interrupts.CPU23.LOC:Local_timer_interrupts
>>>>       290266           +28.5%     372865 ±  3%
>>>> interrupts.CPU23.RES:Rescheduling_interrupts
>>>>       204518           +49.0%     304653 ±  2%
>>>> interrupts.CPU24.LOC:Local_timer_interrupts
>>>>       288815 ±  2%     +28.7%     371621 ±  4%
>>>> interrupts.CPU24.RES:Rescheduling_interrupts
>>>>       204414           +49.0%     304640 ±  2%
>>>> interrupts.CPU25.LOC:Local_timer_interrupts
>>>>       288779 ±  2%     +28.2%     370202 ±  4%
>>>> interrupts.CPU25.RES:Rescheduling_interrupts
>>>>       204536           +49.0%     304730 ±  2%
>>>> interrupts.CPU26.LOC:Local_timer_interrupts
>>>>       287615 ±  2%     +28.6%     369843 ±  4%
>>>> interrupts.CPU26.RES:Rescheduling_interrupts
>>>>        72.50 ± 37%     +55.5%     112.75 ± 26%
>>>> interrupts.CPU27.36:PCI-MSI.2621442-edge.eth0-TxRx-1
>>>>       204514           +49.0%     304668 ±  2%
>>>> interrupts.CPU27.LOC:Local_timer_interrupts
>>>>       287014 ±  2%     +28.5%     368825 ±  4%
>>>> interrupts.CPU27.RES:Rescheduling_interrupts
>>>>        53.25 ±  2%     +84.5%      98.25 ± 22%
>>>> interrupts.CPU28.37:PCI-MSI.2621443-edge.eth0-TxRx-2
>>>>       204331           +49.1%     304759 ±  2%
>>>> interrupts.CPU28.LOC:Local_timer_interrupts
>>>>       287278 ±  2%     +28.4%     368876 ±  4%
>>>> interrupts.CPU28.RES:Rescheduling_interrupts
>>>>        73.50 ± 26%    +116.3%     159.00 ± 60%
>>>> interrupts.CPU29.38:PCI-MSI.2621444-edge.eth0-TxRx-3
>>>>       204427           +49.0%     304651 ±  2%
>>>> interrupts.CPU29.LOC:Local_timer_interrupts
>>>>       287382 ±  2%     +28.9%     370434 ±  4%
>>>> interrupts.CPU29.RES:Rescheduling_interrupts
>>>>       204538           +49.0%     304765 ±  2%
>>>> interrupts.CPU3.LOC:Local_timer_interrupts
>>>>         5034 ± 27%     -29.4%       3552
>>>> interrupts.CPU3.NMI:Non-maskable_interrupts
>>>>         5034 ± 27%     -29.4%       3552
>>>> interrupts.CPU3.PMI:Performance_monitoring_interrupts
>>>>       288881 ±  2%     +28.3%     370740 ±  4%
>>>> interrupts.CPU3.RES:Rescheduling_interrupts
>>>>       204750           +48.8%     304674 ±  2%
>>>> interrupts.CPU30.LOC:Local_timer_interrupts
>>>>       287139 ±  2%     +28.8%     369825 ±  4%
>>>> interrupts.CPU30.RES:Rescheduling_interrupts
>>>>       204429           +48.9%     304416 ±  2%
>>>> interrupts.CPU31.LOC:Local_timer_interrupts
>>>>       288411 ±  2%     +28.4%     370199 ±  4%
>>>> interrupts.CPU31.RES:Rescheduling_interrupts
>>>>       204395           +49.3%     305106 ±  2%
>>>> interrupts.CPU32.LOC:Local_timer_interrupts
>>>>       289178 ±  2%     +28.6%     371830 ±  4%
>>>> interrupts.CPU32.RES:Rescheduling_interrupts
>>>>       204347           +49.2%     304799 ±  2%
>>>> interrupts.CPU33.LOC:Local_timer_interrupts
>>>>       289689 ±  2%     +28.2%     371280 ±  4%
>>>> interrupts.CPU33.RES:Rescheduling_interrupts
>>>>       204280           +49.1%     304566 ±  2%
>>>> interrupts.CPU34.LOC:Local_timer_interrupts
>>>>         6418 ± 24%     -44.5%       3564
>>>> interrupts.CPU34.NMI:Non-maskable_interrupts
>>>>         6418 ± 24%     -44.5%       3564
>>>> interrupts.CPU34.PMI:Performance_monitoring_interrupts
>>>>       290382 ±  2%     +28.3%     372606 ±  4%
>>>> interrupts.CPU34.RES:Rescheduling_interrupts
>>>>       204331           +49.0%     304517 ±  2%
>>>> interrupts.CPU35.LOC:Local_timer_interrupts
>>>>       289736 ±  2%     +28.3%     371869 ±  4%
>>>> interrupts.CPU35.RES:Rescheduling_interrupts
>>>>       204578           +48.8%     304423 ±  2%
>>>> interrupts.CPU36.LOC:Local_timer_interrupts
>>>>         7298           -39.0%       4450 ± 34%
>>>> interrupts.CPU36.NMI:Non-maskable_interrupts
>>>>         7298           -39.0%       4450 ± 34%
>>>> interrupts.CPU36.PMI:Performance_monitoring_interrupts
>>>>       287187           +28.3%     368516 ±  3%
>>>> interrupts.CPU36.RES:Rescheduling_interrupts
>>>>       204538           +49.0%     304729 ±  2%
>>>> interrupts.CPU37.LOC:Local_timer_interrupts
>>>>       288676           +28.1%     369792 ±  3%
>>>> interrupts.CPU37.RES:Rescheduling_interrupts
>>>>       204504           +49.0%     304687 ±  2%
>>>> interrupts.CPU38.LOC:Local_timer_interrupts
>>>>         6301 ± 24%     -29.8%       4424 ± 34%
>>>> interrupts.CPU38.NMI:Non-maskable_interrupts
>>>>         6301 ± 24%     -29.8%       4424 ± 34%
>>>> interrupts.CPU38.PMI:Performance_monitoring_interrupts
>>>>       287510           +28.1%     368349 ±  3%
>>>> interrupts.CPU38.RES:Rescheduling_interrupts
>>>>       204566           +48.9%     304668 ±  2%
>>>> interrupts.CPU39.LOC:Local_timer_interrupts
>>>>       286909           +28.1%     367622 ±  3%
>>>> interrupts.CPU39.RES:Rescheduling_interrupts
>>>>       204445           +49.0%     304686 ±  2%
>>>> interrupts.CPU4.LOC:Local_timer_interrupts
>>>>       288608 ±  2%     +28.7%     371493 ±  3%
>>>> interrupts.CPU4.RES:Rescheduling_interrupts
>>>>       204538           +48.9%     304582 ±  2%
>>>> interrupts.CPU40.LOC:Local_timer_interrupts
>>>>       286219           +27.9%     365983 ±  3%
>>>> interrupts.CPU40.RES:Rescheduling_interrupts
>>>>       204551           +49.0%     304739 ±  2%
>>>> interrupts.CPU41.LOC:Local_timer_interrupts
>>>>         5170 ± 29%     -18.5%       4215 ± 27%
>>>> interrupts.CPU41.NMI:Non-maskable_interrupts
>>>>         5170 ± 29%     -18.5%       4215 ± 27%
>>>> interrupts.CPU41.PMI:Performance_monitoring_interrupts
>>>>       286946           +27.8%     366717 ±  3%
>>>> interrupts.CPU41.RES:Rescheduling_interrupts
>>>>       204492           +48.9%     304442 ±  2%
>>>> interrupts.CPU42.LOC:Local_timer_interrupts
>>>>       287384           +28.0%     367805 ±  3%
>>>> interrupts.CPU42.RES:Rescheduling_interrupts
>>>>       204545           +49.0%     304679 ±  2%
>>>> interrupts.CPU43.LOC:Local_timer_interrupts
>>>>       289100           +27.3%     368059 ±  3%
>>>> interrupts.CPU43.RES:Rescheduling_interrupts
>>>>       204489           +49.0%     304635 ±  2%
>>>> interrupts.CPU44.LOC:Local_timer_interrupts
>>>>         6393 ± 24%     -32.4%       4319 ± 31%
>>>> interrupts.CPU44.NMI:Non-maskable_interrupts
>>>>         6393 ± 24%     -32.4%       4319 ± 31%
>>>> interrupts.CPU44.PMI:Performance_monitoring_interrupts
>>>>       288835           +27.8%     369182 ±  3%
>>>> interrupts.CPU44.RES:Rescheduling_interrupts
>>>>       204473           +49.2%     304983 ±  2%
>>>> interrupts.CPU45.LOC:Local_timer_interrupts
>>>>       289778           +27.4%     369059 ±  3%
>>>> interrupts.CPU45.RES:Rescheduling_interrupts
>>>>       204493           +49.0%     304598 ±  2%
>>>> interrupts.CPU46.LOC:Local_timer_interrupts
>>>>       289485           +27.9%     370172 ±  3%
>>>> interrupts.CPU46.RES:Rescheduling_interrupts
>>>>       204511           +49.2%     305090 ±  2%
>>>> interrupts.CPU47.LOC:Local_timer_interrupts
>>>>       286611           +28.8%     369021 ±  3%
>>>> interrupts.CPU47.RES:Rescheduling_interrupts
>>>>       204441           +49.1%     304794 ±  2%
>>>> interrupts.CPU5.LOC:Local_timer_interrupts
>>>>       289245 ±  2%     +28.4%     371335 ±  4%
>>>> interrupts.CPU5.RES:Rescheduling_interrupts
>>>>       204246           +49.0%     304414 ±  2%
>>>> interrupts.CPU6.LOC:Local_timer_interrupts
>>>>       290006 ±  2%     +28.3%     372180 ±  4%
>>>> interrupts.CPU6.RES:Rescheduling_interrupts
>>>>       204445           +49.0%     304719 ±  2%
>>>> interrupts.CPU7.LOC:Local_timer_interrupts
>>>>       290524 ±  2%     +28.2%     372414 ±  4%
>>>> interrupts.CPU7.RES:Rescheduling_interrupts
>>>>       204178           +49.2%     304663 ±  2%
>>>> interrupts.CPU8.LOC:Local_timer_interrupts
>>>>       291625 ±  2%     +27.8%     372747 ±  4%
>>>> interrupts.CPU8.RES:Rescheduling_interrupts
>>>>       204502           +48.9%     304407 ±  3%
>>>> interrupts.CPU9.LOC:Local_timer_interrupts
>>>>       291615 ±  2%     +27.9%     373024 ±  4%
>>>> interrupts.CPU9.RES:Rescheduling_interrupts
>>>>      9814627           +49.0%   14624016 ±  2%
>>>> interrupts.LOC:Local_timer_interrupts
>>>>     13869791           +28.2%   17785831 ±  3%
>>>> interrupts.RES:Rescheduling_interrupts
>>>>        25728           +47.6%      37969        softirqs.CPU0.RCU
>>>>        34944           +41.7%      49503 ±  3%  softirqs.CPU0.SCHED
>>>>        42375           +38.5%      58673 ±  2%  softirqs.CPU0.TIMER
>>>>        25348           +53.8%      38976 ±  5%  softirqs.CPU1.RCU
>>>>        30986           +46.2%      45315 ±  3%  softirqs.CPU1.SCHED
>>>>        41265           +44.3%      59538 ±  3%  softirqs.CPU1.TIMER
>>>>        25149           +48.3%      37288        softirqs.CPU10.RCU
>>>>        29752           +47.1%      43764 ±  2%  softirqs.CPU10.SCHED
>>>>        40609           +41.5%      57449        softirqs.CPU10.TIMER
>>>>        25218           +48.3%      37399        softirqs.CPU11.RCU
>>>>        30294           +44.6%      43800        softirqs.CPU11.SCHED
>>>>        41371           +39.2%      57578        softirqs.CPU11.TIMER
>>>>        24427           +48.9%      36361        softirqs.CPU12.RCU
>>>>        30438           +44.0%      43835        softirqs.CPU12.SCHED
>>>>        41045 ±  3%     +43.0%      58687        softirqs.CPU12.TIMER
>>>>        24247           +47.0%      35645        softirqs.CPU13.RCU
>>>>        30155           +44.5%      43577        softirqs.CPU13.SCHED
>>>>        41148 ±  2%     +40.3%      57720        softirqs.CPU13.TIMER
>>>>        24506           +46.3%      35856        softirqs.CPU14.RCU
>>>>        29991           +44.1%      43229        softirqs.CPU14.SCHED
>>>>        41190 ±  2%     +39.7%      57552        softirqs.CPU14.TIMER
>>>>        24412           +46.7%      35800        softirqs.CPU15.RCU
>>>>        30135           +44.1%      43430        softirqs.CPU15.SCHED
>>>>        45081 ± 15%     +28.0%      57684        softirqs.CPU15.TIMER
>>>>        25327           +47.0%      37225        softirqs.CPU16.RCU
>>>>        30230           +43.8%      43461        softirqs.CPU16.SCHED
>>>>        41157           +39.6%      57448        softirqs.CPU16.TIMER
>>>>        25136           +47.8%      37142        softirqs.CPU17.RCU
>>>>        29894           +44.5%      43212        softirqs.CPU17.SCHED
>>>>        41961 ±  5%     +36.5%      57281        softirqs.CPU17.TIMER
>>>>        25431           +46.1%      37160        softirqs.CPU18.RCU
>>>>        30062           +44.0%      43281        softirqs.CPU18.SCHED
>>>>        40956 ±  2%     +42.1%      58217        softirqs.CPU18.TIMER
>>>>        25496           +44.8%      36923 ±  2%  softirqs.CPU19.RCU
>>>>        29989           +46.5%      43946        softirqs.CPU19.SCHED
>>>>        41740 ±  2%     +67.8%      70057 ± 17%  softirqs.CPU19.TIMER
>>>>        25414           +48.3%      37678        softirqs.CPU2.RCU
>>>>        30905           +43.4%      44309 ±  2%  softirqs.CPU2.SCHED
>>>>        41083           +40.6%      57768 ±  2%  softirqs.CPU2.TIMER
>>>>        25124           +46.8%      36892        softirqs.CPU20.RCU
>>>>        30001           +44.7%      43416        softirqs.CPU20.SCHED
>>>>        41060 ±  7%     +39.2%      57151        softirqs.CPU20.TIMER
>>>>        24992           +47.6%      36896        softirqs.CPU21.RCU
>>>>        30109           +44.4%      43467        softirqs.CPU21.SCHED
>>>>        40055 ±  3%     +42.5%      57081 ±  2%  softirqs.CPU21.TIMER
>>>>        25072           +46.2%      36656        softirqs.CPU22.RCU
>>>>        30296           +43.3%      43425        softirqs.CPU22.SCHED
>>>>        24882           +48.8%      37031        softirqs.CPU23.RCU
>>>>        29900           +43.7%      42971        softirqs.CPU23.SCHED
>>>>        40388 ±  3%     +44.8%      58494 ±  3%  softirqs.CPU23.TIMER
>>>>        25007           +48.1%      37036        softirqs.CPU24.RCU
>>>>        29755           +45.9%      43399        softirqs.CPU24.SCHED
>>>>        40786           +40.6%      57353        softirqs.CPU24.TIMER
>>>>        25031           +47.3%      36875        softirqs.CPU25.RCU
>>>>        29841 ±  2%     +45.3%      43355        softirqs.CPU25.SCHED
>>>>        40971           +39.8%      57266        softirqs.CPU25.TIMER
>>>>        25145           +47.6%      37114        softirqs.CPU26.RCU
>>>>        29462 ±  2%     +48.5%      43739 ±  2%  softirqs.CPU26.SCHED
>>>>        40553           +41.8%      57521        softirqs.CPU26.TIMER
>>>>        25184           +47.6%      37169        softirqs.CPU27.RCU
>>>>        29867           +45.5%      43450 ±  3%  softirqs.CPU27.SCHED
>>>>        41118           +39.3%      57261        softirqs.CPU27.TIMER
>>>>        25452           +47.1%      37440        softirqs.CPU28.RCU
>>>>        29714           +46.2%      43440 ±  2%  softirqs.CPU28.SCHED
>>>>        41209 ±  2%     +37.8%      56783 ±  2%  softirqs.CPU28.TIMER
>>>>        25334           +48.8%      37696 ±  2%  softirqs.CPU29.RCU
>>>>        29894           +46.3%      43749        softirqs.CPU29.SCHED
>>>>        41413 ±  2%     +43.3%      59346 ±  5%  softirqs.CPU29.TIMER
>>>>        25514           +47.0%      37495        softirqs.CPU3.RCU
>>>>        30016           +46.0%      43831 ±  2%  softirqs.CPU3.SCHED
>>>>        41371 ±  2%     +39.3%      57611        softirqs.CPU3.TIMER
>>>>        25206           +47.4%      37149        softirqs.CPU30.RCU
>>>>        30167           +44.0%      43451 ±  2%  softirqs.CPU30.SCHED
>>>>        41166 ±  2%     +58.1%      65092 ± 19%  softirqs.CPU30.TIMER
>>>>        25211           +46.8%      37016        softirqs.CPU31.RCU
>>>>        30004 ±  2%     +45.2%      43569        softirqs.CPU31.SCHED
>>>>        41541 ±  2%     +36.9%      56874        softirqs.CPU31.TIMER
>>>>        24432           +46.9%      35885        softirqs.CPU32.RCU
>>>>        30206           +43.4%      43322 ±  2%  softirqs.CPU32.SCHED
>>>>        41069           +40.7%      57781 ±  2%  softirqs.CPU32.TIMER
>>>>        24303           +48.0%      35973        softirqs.CPU33.RCU
>>>>        30238           +43.8%      43489        softirqs.CPU33.SCHED
>>>>        41161           +38.2%      56872        softirqs.CPU33.TIMER
>>>>        24308           +47.6%      35876        softirqs.CPU34.RCU
>>>>        29803           +46.5%      43647 ±  2%  softirqs.CPU34.SCHED
>>>>        40809           +39.2%      56817        softirqs.CPU34.TIMER
>>>>        24291           +47.7%      35877        softirqs.CPU35.RCU
>>>>        30092           +44.2%      43386        softirqs.CPU35.SCHED
>>>>        40607           +41.5%      57480 ±  2%  softirqs.CPU35.TIMER
>>>>        25605           +49.5%      38286        softirqs.CPU36.RCU
>>>>        29900           +44.6%      43238        softirqs.CPU36.SCHED
>>>>        45207 ± 15%     +27.4%      57602        softirqs.CPU36.TIMER
>>>>        25555 ±  2%     +49.0%      38070        softirqs.CPU37.RCU
>>>>        29926           +45.2%      43460        softirqs.CPU37.SCHED
>>>>        42619 ±  8%     +36.7%      58242        softirqs.CPU37.TIMER
>>>>        27683 ±  9%     +50.2%      41577 ±  4%  softirqs.CPU38.RCU
>>>>        29700           +45.6%      43230        softirqs.CPU38.SCHED
>>>>        41779 ±  4%     +43.5%      59948        softirqs.CPU38.TIMER
>>>>        26699 ±  7%     +42.1%      37951        softirqs.CPU39.RCU
>>>>        30061           +43.4%      43102        softirqs.CPU39.SCHED
>>>>        42312 ±  5%     +36.1%      57581 ±  2%  softirqs.CPU39.TIMER
>>>>        25219           +47.7%      37247        softirqs.CPU4.RCU
>>>>        30363 ±  3%     +45.9%      44295        softirqs.CPU4.SCHED
>>>>        41108 ±  2%     +39.6%      57371 ±  2%  softirqs.CPU4.TIMER
>>>>        25413           +50.6%      38268        softirqs.CPU40.RCU
>>>>        29910           +46.0%      43665        softirqs.CPU40.SCHED
>>>>        39987 ±  2%     +45.9%      58322        softirqs.CPU40.TIMER
>>>>        25569           +49.5%      38238        softirqs.CPU41.RCU
>>>>        29867           +44.8%      43247        softirqs.CPU41.SCHED
>>>>        25492           +49.8%      38185        softirqs.CPU42.RCU
>>>>        29871           +45.4%      43440        softirqs.CPU42.SCHED
>>>>        40076           +44.8%      58020        softirqs.CPU42.TIMER
>>>>        25281           +48.9%      37640        softirqs.CPU43.RCU
>>>>        30025           +43.9%      43220        softirqs.CPU43.SCHED
>>>>        40222 ±  3%     +44.7%      58195        softirqs.CPU43.TIMER
>>>>        25183           +49.3%      37611        softirqs.CPU44.RCU
>>>>        30123           +43.6%      43249        softirqs.CPU44.SCHED
>>>>        41090 ±  6%     +42.5%      58537        softirqs.CPU44.TIMER
>>>>        25314           +49.6%      37863        softirqs.CPU45.RCU
>>>>        29998           +43.2%      42957        softirqs.CPU45.SCHED
>>>>        39705 ±  3%     +43.6%      57033        softirqs.CPU45.TIMER
>>>>        25500           +46.2%      37274        softirqs.CPU46.RCU
>>>>        29921           +44.7%      43286        softirqs.CPU46.SCHED
>>>>        41088 ±  5%     +39.9%      57463 ±  3%  softirqs.CPU46.TIMER
>>>>        25564           +48.4%      37931        softirqs.CPU47.RCU
>>>>        30178           +42.4%      42980        softirqs.CPU47.SCHED
>>>>        40738 ±  4%     +42.2%      57939 ±  3%  softirqs.CPU47.TIMER
>>>>        26467 ±  8%     +40.8%      37278        softirqs.CPU5.RCU
>>>>        30334 ±  2%     +44.1%      43714        softirqs.CPU5.SCHED
>>>>        42268 ±  4%     +35.8%      57394        softirqs.CPU5.TIMER
>>>>        25343           +47.0%      37245        softirqs.CPU6.RCU
>>>>        30100           +45.0%      43643 ±  2%  softirqs.CPU6.SCHED
>>>>        41270           +43.6%      59249 ±  5%  softirqs.CPU6.TIMER
>>>>        25331           +47.7%      37418        softirqs.CPU7.RCU
>>>>        30210           +44.7%      43727 ±  2%  softirqs.CPU7.SCHED
>>>>        41028           +41.9%      58206 ±  2%  softirqs.CPU7.TIMER
>>>>        25483           +47.2%      37514        softirqs.CPU8.RCU
>>>>        30324 ±  2%     +43.4%      43483 ±  2%  softirqs.CPU8.SCHED
>>>>        41027           +40.4%      57591 ±  2%  softirqs.CPU8.TIMER
>>>>        25546           +47.5%      37687        softirqs.CPU9.RCU
>>>>        30218           +44.8%      43771 ±  2%  softirqs.CPU9.SCHED
>>>>        41193           +40.1%      57716 ±  2%  softirqs.CPU9.TIMER
>>>>      1212606           +47.7%    1790808        softirqs.RCU
>>>>      1448198           +44.7%    2095500        softirqs.SCHED
>>>>      1990064           +40.7%    2800202        softirqs.TIMER
>>>>         8.56 ±  3%      -4.3        4.25        perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.file_write_and_wait_range.xfs_file_fsync.xfs_file_buffered_aio_write.new_sync_write
>>>>
>>>>         8.50 ±  3%      -4.3        4.20        perf-profile.calltrace.cycles-pp.do_writepages.__filemap_fdatawrite_range.file_write_and_wait_range.xfs_file_fsync.xfs_file_buffered_aio_write
>>>>
>>>>         8.47 ±  3%      -4.3        4.17        perf-profile.calltrace.cycles-pp.xfs_vm_writepages.do_writepages.__filemap_fdatawrite_range.file_write_and_wait_range.xfs_file_fsync
>>>>
>>>>        78.55            -4.1       74.44
>>>> perf-profile.calltrace.cycles-pp.write
>>>>         8.74 ±  3%      -4.0        4.70        perf-profile.calltrace.cycles-pp.file_write_and_wait_range.xfs_file_fsync.xfs_file_buffered_aio_write.new_sync_write.vfs_write
>>>>
>>>>        77.69            -3.9       73.75
>>>> perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
>>>>        77.64            -3.9       73.71        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>>>>
>>>>        77.13            -3.8       73.36        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>>>>
>>>>        77.08            -3.8       73.31        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>>>>
>>>>        76.61            -3.7       72.96        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>>>
>>>>        76.43            -3.6       72.80        perf-profile.calltrace.cycles-pp.xfs_file_buffered_aio_write.new_sync_write.vfs_write.ksys_write.do_syscall_64
>>>>
>>>>        69.22            -2.6       66.62        perf-profile.calltrace.cycles-pp.xfs_file_fsync.xfs_file_buffered_aio_write.new_sync_write.vfs_write.ksys_write
>>>>
>>>>         4.70 ±  2%      -2.2        2.50        perf-profile.calltrace.cycles-pp.iomap_submit_ioend.xfs_vm_writepages.do_writepages.__filemap_fdatawrite_range.file_write_and_wait_range
>>>>
>>>>         4.63 ±  2%      -2.2        2.45        perf-profile.calltrace.cycles-pp.submit_bio.iomap_submit_ioend.xfs_vm_writepages.do_writepages.__filemap_fdatawrite_range
>>>>
>>>>         4.60 ±  2%      -2.2        2.43        perf-profile.calltrace.cycles-pp.generic_make_request.submit_bio.iomap_submit_ioend.xfs_vm_writepages.do_writepages
>>>>
>>>>         4.32 ±  2%      -2.1        2.22        perf-profile.calltrace.cycles-pp.brd_make_request.generic_make_request.submit_bio.iomap_submit_ioend.xfs_vm_writepages
>>>>
>>>>         3.72 ±  4%      -2.1        1.63        perf-profile.calltrace.cycles-pp.iomap_writepages.xfs_vm_writepages.do_writepages.__filemap_fdatawrite_range.file_write_and_wait_range
>>>>
>>>>         3.71 ±  4%      -2.1        1.62        perf-profile.calltrace.cycles-pp.write_cache_pages.iomap_writepages.xfs_vm_writepages.do_writepages.__filemap_fdatawrite_range
>>>>
>>>>         2.63 ±  4%      -2.0        0.63 ±  3%  perf-profile.calltrace.cycles-pp.iomap_finish_ioend.brd_make_request.generic_make_request.submit_bio.iomap_submit_ioend
>>>>
>>>>         7.72            -2.0        5.74 ±  2%  perf-profile.calltrace.cycles-pp.__flush_work.xlog_cil_force_lsn.xfs_log_force_lsn.xfs_file_fsync.xfs_file_buffered_aio_write
>>>>
>>>>         3.08 ±  5%      -1.9        1.13        perf-profile.calltrace.cycles-pp.iomap_writepage_map.write_cache_pages.iomap_writepages.xfs_vm_writepages.do_writepages
>>>>
>>>>         2.49 ±  5%      -1.9        0.55 ±  3%  perf-profile.calltrace.cycles-pp.end_page_writeback.iomap_finish_ioend.brd_make_request.generic_make_request.submit_bio
>>>>
>>>>         2.48 ±  5%      -1.9        0.55 ±  3%  perf-profile.calltrace.cycles-pp.test_clear_page_writeback.end_page_writeback.iomap_finish_ioend.brd_make_request.generic_make_request
>>>>
>>>>         2.41 ±  6%      -1.8        0.61 ±  2%  perf-profile.calltrace.cycles-pp.__test_set_page_writeback.iomap_writepage_map.write_cache_pages.iomap_writepages.xfs_vm_writepages
>>>>
>>>>         4.90            -1.5        3.40 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.__flush_work.xlog_cil_force_lsn.xfs_log_force_lsn.xfs_file_fsync
>>>>
>>>>         4.78            -1.5        3.30 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.__flush_work.xlog_cil_force_lsn.xfs_log_force_lsn
>>>>
>>>>         2.35            -0.6        1.77 ±  2%  perf-profile.calltrace.cycles-pp.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write.new_sync_write.vfs_write
>>>>
>>>>         2.36            -0.6        1.79        perf-profile.calltrace.cycles-pp.iomap_file_buffered_write.xfs_file_buffered_aio_write.new_sync_write.vfs_write.ksys_write
>>>>
>>>>         3.40            -0.5        2.87 ±  6%  perf-profile.calltrace.cycles-pp.__xfs_trans_commit.xfs_vn_update_time.file_update_time.xfs_file_aio_write_checks.xfs_file_buffered_aio_write
>>>>
>>>>         1.83            -0.5        1.33 ±  2%  perf-profile.calltrace.cycles-pp.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write.new_sync_write
>>>>
>>>>         3.26            -0.5        2.75 ±  6%  perf-profile.calltrace.cycles-pp.xfs_log_commit_cil.__xfs_trans_commit.xfs_vn_update_time.file_update_time.xfs_file_aio_write_checks
>>>>
>>>>         2.85            -0.4        2.40        perf-profile.calltrace.cycles-pp.complete.process_one_work.worker_thread.kthread.ret_from_fork
>>>>
>>>>         2.79            -0.4        2.34        perf-profile.calltrace.cycles-pp.try_to_wake_up.swake_up_locked.complete.process_one_work.worker_thread
>>>>
>>>>         2.83            -0.4        2.38        perf-profile.calltrace.cycles-pp.swake_up_locked.complete.process_one_work.worker_thread.kthread
>>>>
>>>>         1.48            -0.4        1.05 ±  2%  perf-profile.calltrace.cycles-pp.brd_do_bvec.brd_make_request.generic_make_request.submit_bio.iomap_submit_ioend
>>>>
>>>>         0.61 ±  2%      -0.4        0.26 ±100%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.scheduler_ipi.reschedule_interrupt.native_queued_spin_lock_slowpath._raw_spin_lock
>>>>
>>>>         1.89            -0.3        1.54        perf-profile.calltrace.cycles-pp.wait_for_completion.__flush_work.xlog_cil_force_lsn.xfs_log_force_lsn.xfs_file_fsync
>>>>
>>>>         1.71            -0.3        1.38        perf-profile.calltrace.cycles-pp.schedule_timeout.wait_for_completion.__flush_work.xlog_cil_force_lsn.xfs_log_force_lsn
>>>>
>>>>         1.65            -0.3        1.34        perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.wait_for_completion.__flush_work.xlog_cil_force_lsn
>>>>
>>>>         0.69            -0.3        0.38 ± 57%  perf-profile.calltrace.cycles-pp.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write
>>>>
>>>>         1.59            -0.3        1.29        perf-profile.calltrace.cycles-pp.__sched_text_start.schedule.schedule_timeout.wait_for_completion.__flush_work
>>>>
>>>>         0.86            -0.3        0.58 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.xfs_log_commit_cil.__xfs_trans_commit.xfs_vn_update_time.file_update_time
>>>>
>>>>         1.52            -0.3        1.26 ±  3%  perf-profile.calltrace.cycles-pp.xlog_cil_insert_items.xfs_log_commit_cil.__xfs_trans_commit.xfs_vn_update_time.file_update_time
>>>>
>>>>         1.75            -0.2        1.50 ±  2%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.swake_up_locked.complete.process_one_work
>>>>
>>>>         1.74            -0.2        1.49 ±  2%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up.swake_up_locked
>>>>
>>>>         1.74            -0.2        1.50 ±  2%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.try_to_wake_up.swake_up_locked.complete
>>>>
>>>>         2.15            -0.2        1.94        perf-profile.calltrace.cycles-pp.__account_scheduler_latency.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
>>>>
>>>>         0.79 ±  3%      -0.2        0.60 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock.xlog_cil_insert_items.xfs_log_commit_cil.__xfs_trans_commit.xfs_vn_update_time
>>>>
>>>>         1.81            -0.2        1.62        perf-profile.calltrace.cycles-pp.arch_stack_walk.stack_trace_save_tsk.__account_scheduler_latency.enqueue_entity.enqueue_task_fair
>>>>
>>>>         1.87            -0.2        1.68        perf-profile.calltrace.cycles-pp.stack_trace_save_tsk.__account_scheduler_latency.enqueue_entity.enqueue_task_fair.activate_task
>>>>
>>>>         0.70 ±  4%      -0.2        0.54 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.xlog_cil_insert_items.xfs_log_commit_cil.__xfs_trans_commit
>>>>
>>>>         0.81            -0.1        0.68        perf-profile.calltrace.cycles-pp.unwind_next_frame.arch_stack_walk.stack_trace_save_tsk.__account_scheduler_latency.enqueue_entity
>>>>
>>>>         0.65 ±  2%      -0.1        0.55 ±  2%  perf-profile.calltrace.cycles-pp.reschedule_interrupt.native_queued_spin_lock_slowpath._raw_spin_lock.xlog_cil_force_lsn.xfs_log_force_lsn
>>>>
>>>>         0.62 ±  2%      -0.1        0.52 ±  3%  perf-profile.calltrace.cycles-pp.scheduler_ipi.reschedule_interrupt.native_queued_spin_lock_slowpath._raw_spin_lock.xlog_cil_force_lsn
>>>>
>>>>         1.18            -0.0        1.16        perf-profile.calltrace.cycles-pp.sched_ttwu_pending.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
>>>>
>>>>         1.01            -0.0        0.99        perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.do_idle.cpu_startup_entry
>>>>
>>>>         1.00            -0.0        0.98        perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending.do_idle
>>>>
>>>>         0.96            -0.0        0.93        perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending
>>>>
>>>>         1.01            -0.0        0.99        perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.do_idle.cpu_startup_entry.start_secondary
>>>>
>>>>         0.59 ±  3%      +0.1        0.68        perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
>>>>
>>>>         0.58 ±  3%      +0.1        0.67        perf-profile.calltrace.cycles-pp.__sched_text_start.schedule_idle.do_idle.cpu_startup_entry.start_secondary
>>>>
>>>>         0.53            +0.1        0.63 ±  3%  perf-profile.calltrace.cycles-pp.try_to_wake_up.__wake_up_common.__wake_up_common_lock.xlog_cil_push_work.process_one_work
>>>>
>>>>         0.91 ±  3%      +0.1        1.02 ±  2%  perf-profile.calltrace.cycles-pp.xlog_write.xlog_cil_push_work.process_one_work.worker_thread.kthread
>>>>
>>>>         0.54            +0.1        0.65 ±  3%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.xlog_cil_push_work.process_one_work.worker_thread
>>>>
>>>>         0.57            +0.1        0.69 ±  3%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.xlog_cil_push_work.process_one_work.worker_thread.kthread
>>>>
>>>>         1.83            +0.2        1.99        perf-profile.calltrace.cycles-pp.xlog_cil_push_work.process_one_work.worker_thread.kthread.ret_from_fork
>>>>
>>>>         0.00            +0.6        0.57 ±  2%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
>>>>
>>>>         0.00            +0.6        0.57 ±  2%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
>>>>
>>>>         0.00            +0.6        0.57 ±  2%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.wake_up_page_bit
>>>>
>>>>         0.00            +0.7        0.70 ±  2%  perf-profile.calltrace.cycles-pp.xfs_bmap_add_extent_unwritten_real.xfs_bmapi_convert_unwritten.xfs_bmapi_write.xfs_iomap_write_unwritten.xfs_end_ioend
>>>>
>>>>         0.00            +0.8        0.75 ±  4%  perf-profile.calltrace.cycles-pp.xfs_bmapi_convert_unwritten.xfs_bmapi_write.xfs_iomap_write_unwritten.xfs_end_ioend.xfs_end_io
>>>>
>>>>         0.00            +0.8        0.80        perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.wake_up_page_bit.iomap_finish_ioend
>>>>
>>>>         0.00            +0.8        0.80        perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.wake_up_page_bit.iomap_finish_ioend.iomap_finish_ioends
>>>>
>>>>         0.00            +0.8        0.80 ± 30%  perf-profile.calltrace.cycles-pp.xfs_trans_reserve.xfs_trans_alloc.xfs_vn_update_time.file_update_time.xfs_file_aio_write_checks
>>>>
>>>>         0.00            +0.8        0.82        perf-profile.calltrace.cycles-pp.__wake_up_common.wake_up_page_bit.iomap_finish_ioend.iomap_finish_ioends.xfs_end_ioend
>>>>
>>>>         0.00            +0.8        0.85        perf-profile.calltrace.cycles-pp.wake_up_page_bit.iomap_finish_ioend.iomap_finish_ioends.xfs_end_ioend.xfs_end_io
>>>>
>>>>         0.00            +0.9        0.89 ±  2%  perf-profile.calltrace.cycles-pp.xfs_bmapi_write.xfs_iomap_write_unwritten.xfs_end_ioend.xfs_end_io.process_one_work
>>>>
>>>>         0.00            +0.9        0.92 ± 21%  perf-profile.calltrace.cycles-pp.xfs_log_commit_cil.__xfs_trans_commit.xfs_iomap_write_unwritten.xfs_end_ioend.xfs_end_io
>>>>
>>>>         0.00            +1.0        0.97 ± 20%  perf-profile.calltrace.cycles-pp.__xfs_trans_commit.xfs_iomap_write_unwritten.xfs_end_ioend.xfs_end_io.process_one_work
>>>>
>>>>        35.68            +1.0       36.68        perf-profile.calltrace.cycles-pp.xlog_cil_force_lsn.xfs_log_force_lsn.xfs_file_fsync.xfs_file_buffered_aio_write.new_sync_write
>>>>
>>>>         0.00            +1.0        1.04        perf-profile.calltrace.cycles-pp.iomap_finish_ioend.iomap_finish_ioends.xfs_end_ioend.xfs_end_io.process_one_work
>>>>
>>>>         0.00            +1.0        1.05        perf-profile.calltrace.cycles-pp.iomap_finish_ioends.xfs_end_ioend.xfs_end_io.process_one_work.worker_thread
>>>>
>>>>         9.35            +1.2       10.54        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
>>>>
>>>>         9.61            +1.2       10.85        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
>>>>
>>>>         9.63            +1.2       10.87        perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
>>>>
>>>>        12.24            +1.3       13.58        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
>>>>
>>>>        12.25            +1.3       13.60
>>>> perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
>>>>        12.25            +1.3       13.60        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
>>>>
>>>>        12.49            +1.4       13.89
>>>> perf-profile.calltrace.cycles-pp.secondary_startup_64
>>>>        14.38            +1.4       15.81 ±  2%  perf-profile.calltrace.cycles-pp.xlog_wait_on_iclog.__xfs_log_force_lsn.xfs_log_force_lsn.xfs_file_fsync.xfs_file_buffered_aio_write
>>>>
>>>>        13.41            +1.4       14.86 ±  2%  perf-profile.calltrace.cycles-pp.remove_wait_queue.xlog_wait_on_iclog.__xfs_log_force_lsn.xfs_log_force_lsn.xfs_file_fsync
>>>>
>>>>        13.37            +1.5       14.82 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.remove_wait_queue.xlog_wait_on_iclog.__xfs_log_force_lsn.xfs_log_force_lsn
>>>>
>>>>        13.34            +1.5       14.80 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.remove_wait_queue.xlog_wait_on_iclog.__xfs_log_force_lsn
>>>>
>>>>        58.91            +1.6       60.56        perf-profile.calltrace.cycles-pp.xfs_log_force_lsn.xfs_file_fsync.xfs_file_buffered_aio_write.new_sync_write.vfs_write
>>>>
>>>>         0.00            +2.2        2.24 ± 13%  perf-profile.calltrace.cycles-pp.xfs_iomap_write_unwritten.xfs_end_ioend.xfs_end_io.process_one_work.worker_thread
>>>>
>>>>         5.63            +2.5        8.15        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.remove_wait_queue.xlog_cil_force_lsn.xfs_log_force_lsn
>>>>
>>>>         5.65            +2.5        8.19        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.remove_wait_queue.xlog_cil_force_lsn.xfs_log_force_lsn.xfs_file_fsync
>>>>
>>>>         5.69            +2.5        8.23        perf-profile.calltrace.cycles-pp.remove_wait_queue.xlog_cil_force_lsn.xfs_log_force_lsn.xfs_file_fsync.xfs_file_buffered_aio_write
>>>>
>>>>         7.04            +2.8        9.80 ±  2%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
>>>>
>>>>         7.54            +2.9       10.45 ±  2%
>>>> perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
>>>>         7.55            +2.9       10.46 ±  2%
>>>> perf-profile.calltrace.cycles-pp.ret_from_fork
>>>>         7.55            +2.9       10.46 ±  2%
>>>> perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
>>>>         0.00            +3.3        3.30 ±  9%  perf-profile.calltrace.cycles-pp.xfs_end_ioend.xfs_end_io.process_one_work.worker_thread.kthread
>>>>
>>>>         0.00            +3.3        3.32 ±  8%  perf-profile.calltrace.cycles-pp.xfs_end_io.process_one_work.worker_thread.kthread.ret_from_fork
>>>>
>>>>         8.56 ±  3%      -4.3        4.25
>>>> perf-profile.children.cycles-pp.__filemap_fdatawrite_range
>>>>         8.47 ±  3%      -4.3        4.18
>>>> perf-profile.children.cycles-pp.xfs_vm_writepages
>>>>         8.50 ±  3%      -4.3        4.20
>>>> perf-profile.children.cycles-pp.do_writepages
>>>>        78.64            -4.1       74.51
>>>> perf-profile.children.cycles-pp.write
>>>>        78.55            -4.1       74.44
>>>> perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>>>>        78.50            -4.1       74.41
>>>> perf-profile.children.cycles-pp.do_syscall_64
>>>>         8.75 ±  3%      -4.1        4.70
>>>> perf-profile.children.cycles-pp.file_write_and_wait_range
>>>>        77.14            -3.8       73.37
>>>> perf-profile.children.cycles-pp.ksys_write
>>>>        77.09            -3.8       73.33
>>>> perf-profile.children.cycles-pp.vfs_write
>>>>        76.62            -3.7       72.97
>>>> perf-profile.children.cycles-pp.new_sync_write
>>>>        76.44            -3.6       72.81
>>>> perf-profile.children.cycles-pp.xfs_file_buffered_aio_write
>>>>        69.23            -2.6       66.62
>>>> perf-profile.children.cycles-pp.xfs_file_fsync
>>>>         4.70 ±  2%      -2.2        2.50
>>>> perf-profile.children.cycles-pp.iomap_submit_ioend
>>>>         4.89 ±  2%      -2.1        2.75
>>>> perf-profile.children.cycles-pp.submit_bio
>>>>         4.85 ±  2%      -2.1        2.71
>>>> perf-profile.children.cycles-pp.generic_make_request
>>>>         3.73 ±  4%      -2.1        1.63
>>>> perf-profile.children.cycles-pp.iomap_writepages
>>>>         3.72 ±  4%      -2.1        1.63
>>>> perf-profile.children.cycles-pp.write_cache_pages
>>>>         4.43 ±  2%      -2.1        2.38
>>>> perf-profile.children.cycles-pp.brd_make_request
>>>>         7.73            -2.0        5.75 ±  2%
>>>> perf-profile.children.cycles-pp.__flush_work
>>>>         3.08 ±  4%      -1.9        1.14
>>>> perf-profile.children.cycles-pp.iomap_writepage_map
>>>>         6.00            -1.8        4.20 ±  2%
>>>> perf-profile.children.cycles-pp._raw_spin_lock_irq
>>>>         2.50 ±  4%      -1.8        0.70 ±  3%
>>>> perf-profile.children.cycles-pp.end_page_writeback
>>>>         2.50 ±  5%      -1.8        0.70 ±  4%
>>>> perf-profile.children.cycles-pp.test_clear_page_writeback
>>>>         2.42 ±  6%      -1.8        0.61 ±  2%
>>>> perf-profile.children.cycles-pp.__test_set_page_writeback
>>>>         2.08 ±  7%      -1.6        0.44 ±  4%
>>>> perf-profile.children.cycles-pp.sb_mark_inode_writeback
>>>>         2.08 ±  6%      -1.6        0.44 ±  5%
>>>> perf-profile.children.cycles-pp.sb_clear_inode_writeback
>>>>         2.70 ±  4%      -1.0        1.67 ±  2%
>>>> perf-profile.children.cycles-pp.iomap_finish_ioend
>>>>         2.36            -0.6        1.79
>>>> perf-profile.children.cycles-pp.iomap_file_buffered_write
>>>>         2.35            -0.6        1.78
>>>> perf-profile.children.cycles-pp.iomap_apply
>>>>         1.84            -0.5        1.33 ±  2%
>>>> perf-profile.children.cycles-pp.iomap_write_actor
>>>>         2.41 ±  4%      -0.5        1.94 ±  2%
>>>> perf-profile.children.cycles-pp.reschedule_interrupt
>>>>         3.44 ±  2%      -0.5        2.98
>>>> perf-profile.children.cycles-pp.sched_ttwu_pending
>>>>         2.87            -0.5        2.42
>>>> perf-profile.children.cycles-pp.complete
>>>>         2.83            -0.4        2.38
>>>> perf-profile.children.cycles-pp.swake_up_locked
>>>>         2.28 ±  4%      -0.4        1.84 ±  2%
>>>> perf-profile.children.cycles-pp.scheduler_ipi
>>>>         1.56            -0.4        1.17 ±  2%
>>>> perf-profile.children.cycles-pp.brd_do_bvec
>>>>         1.89            -0.4        1.54
>>>> perf-profile.children.cycles-pp.wait_for_completion
>>>>         1.71            -0.3        1.38
>>>> perf-profile.children.cycles-pp.schedule_timeout
>>>>         0.88            -0.2        0.68 ±  2%
>>>> perf-profile.children.cycles-pp.rwsem_down_read_slowpath
>>>>         0.69            -0.2        0.51 ±  2%
>>>> perf-profile.children.cycles-pp.iomap_write_begin
>>>>         0.67 ±  2%      -0.2        0.49
>>>> perf-profile.children.cycles-pp.lseek64
>>>>         1.33 ±  5%      -0.2        1.17 ±  3%
>>>> perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
>>>>         0.51            -0.2        0.36
>>>> perf-profile.children.cycles-pp.grab_cache_page_write_begin
>>>>         0.47            -0.1        0.33
>>>> perf-profile.children.cycles-pp.pagecache_get_page
>>>>         0.51 ±  3%      -0.1        0.38 ±  2%
>>>> perf-profile.children.cycles-pp.iomap_write_end
>>>>         0.57 ±  2%      -0.1        0.46
>>>> perf-profile.children.cycles-pp.blkdev_issue_flush
>>>>         0.38            -0.1        0.26 ±  5%
>>>> perf-profile.children.cycles-pp.iov_iter_copy_from_user_atomic
>>>>         0.34            -0.1        0.23 ±  6%
>>>> perf-profile.children.cycles-pp.copyin
>>>>         0.33            -0.1        0.22 ±  6%
>>>> perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
>>>>         0.65 ±  2%      -0.1        0.56 ±  2%
>>>> perf-profile.children.cycles-pp.rwsem_optimistic_spin
>>>>         0.37            -0.1        0.28 ±  2%
>>>> perf-profile.children.cycles-pp.bio_alloc_bioset
>>>>         0.31 ±  4%      -0.1        0.22
>>>> perf-profile.children.cycles-pp.syscall_return_via_sysret
>>>>         0.56 ±  3%      -0.1        0.48 ±  3%
>>>> perf-profile.children.cycles-pp.osq_lock
>>>>         0.26 ±  3%      -0.1        0.18 ±  4%
>>>> perf-profile.children.cycles-pp.entry_SYSCALL_64
>>>>         0.28 ±  2%      -0.1        0.21 ±  5%
>>>> perf-profile.children.cycles-pp.mempool_alloc
>>>>         0.26 ±  6%      -0.1        0.18 ±  8%
>>>> perf-profile.children.cycles-pp.xlog_state_get_iclog_space
>>>>         0.29            -0.1        0.22 ±  3%
>>>> perf-profile.children.cycles-pp.find_get_entry
>>>>         0.34 ±  2%      -0.1        0.27 ±  4%
>>>> perf-profile.children.cycles-pp.generic_make_request_checks
>>>>         0.30 ±  5%      -0.1        0.23 ±  3%
>>>> perf-profile.children.cycles-pp.iomap_set_page_dirty
>>>>         0.32 ±  2%      -0.1        0.26 ±  5%
>>>> perf-profile.children.cycles-pp.brd_lookup_page
>>>>         0.18 ±  2%      -0.1        0.12 ±  6%
>>>> perf-profile.children.cycles-pp.iomap_set_range_uptodate
>>>>         0.15 ±  2%      -0.1        0.09 ±  4%
>>>> perf-profile.children.cycles-pp.__mod_lruvec_state
>>>>         0.15 ±  5%      -0.1        0.10 ±  9%
>>>> perf-profile.children.cycles-pp.wake_up_q
>>>>         0.21 ±  5%      -0.1        0.15 ±  5%
>>>> perf-profile.children.cycles-pp.xfs_ilock
>>>>         0.13 ±  3%      -0.0        0.08 ± 10%
>>>> perf-profile.children.cycles-pp.rwsem_wake
>>>>         0.20 ±  2%      -0.0        0.15 ±  5%
>>>> perf-profile.children.cycles-pp.ksys_lseek
>>>>         0.20 ±  3%      -0.0        0.15 ±  3%
>>>> perf-profile.children.cycles-pp.xas_load
>>>>         0.20 ±  5%      -0.0        0.16 ±  2%
>>>> perf-profile.children.cycles-pp.__set_page_dirty
>>>>         0.19 ±  2%      -0.0        0.15 ±  2%
>>>> perf-profile.children.cycles-pp.xfs_iunlock
>>>>         0.40            -0.0        0.36 ±  4%
>>>> perf-profile.children.cycles-pp.xfs_buffered_write_iomap_begin
>>>>         0.17 ±  2%      -0.0        0.12 ±  4%
>>>> perf-profile.children.cycles-pp.clear_page_dirty_for_io
>>>>         0.20 ±  3%      -0.0        0.16 ±  4%
>>>> perf-profile.children.cycles-pp.submit_bio_wait
>>>>         0.18 ±  4%      -0.0        0.15 ±  7%
>>>> perf-profile.children.cycles-pp.security_file_permission
>>>>         0.10            -0.0        0.06 ±  6%
>>>> perf-profile.children.cycles-pp.evict
>>>>         0.10            -0.0        0.06 ±  6%
>>>> perf-profile.children.cycles-pp.truncate_inode_pages_range
>>>>         0.06 ±  6%      -0.0        0.03 ±100%
>>>> perf-profile.children.cycles-pp.vfs_unlink
>>>>         0.08 ±  6%      -0.0        0.04 ± 58%
>>>> perf-profile.children.cycles-pp.add_to_page_cache_lru
>>>>         0.26 ±  2%      -0.0        0.23 ±  3%
>>>> perf-profile.children.cycles-pp.reweight_entity
>>>>         0.12 ±  6%      -0.0        0.09 ±  4%
>>>> perf-profile.children.cycles-pp.bio_endio
>>>>         0.10 ±  7%      -0.0        0.07 ±  7%
>>>> perf-profile.children.cycles-pp.do_sys_open
>>>>         0.10 ±  7%      -0.0        0.07 ±  7%
>>>> perf-profile.children.cycles-pp.do_sys_openat2
>>>>         0.17 ±  2%      -0.0        0.14
>>>> perf-profile.children.cycles-pp.__pagevec_release
>>>>         0.13 ±  5%      -0.0        0.10 ±  4%
>>>> perf-profile.children.cycles-pp.down_write
>>>>         0.10 ±  5%      -0.0        0.06 ±  6%
>>>> perf-profile.children.cycles-pp.do_filp_open
>>>>         0.15 ±  4%      -0.0        0.12 ±  5%
>>>> perf-profile.children.cycles-pp.tag_pages_for_writeback
>>>>         0.11 ±  9%      -0.0        0.08 ±  5%
>>>> perf-profile.children.cycles-pp.bio_associate_blkg
>>>>         0.10 ±  5%      -0.0        0.07 ±  7%
>>>> perf-profile.children.cycles-pp.open64
>>>>         0.09 ±  4%      -0.0        0.06 ±  6%
>>>> perf-profile.children.cycles-pp.path_openat
>>>>         0.16 ±  8%      -0.0        0.13 ±  3%
>>>> perf-profile.children.cycles-pp.pagevec_lookup_range_tag
>>>>         0.12 ±  8%      -0.0        0.10 ±  5%
>>>> perf-profile.children.cycles-pp.account_page_dirtied
>>>>         0.10 ±  4%      -0.0        0.08 ±  6%
>>>> perf-profile.children.cycles-pp.__fdget_pos
>>>>         0.14 ±  3%      -0.0        0.11 ±  7%
>>>> perf-profile.children.cycles-pp.memset_erms
>>>>         0.11 ±  3%      -0.0        0.09 ±  4%
>>>> perf-profile.children.cycles-pp.switch_fpu_return
>>>>         0.23            -0.0        0.21 ±  3%
>>>> perf-profile.children.cycles-pp.__radix_tree_lookup
>>>>         0.18 ±  2%      -0.0        0.16 ±  9%
>>>> perf-profile.children.cycles-pp.insert_work
>>>>         0.12 ±  4%      -0.0        0.10 ±  7%
>>>> perf-profile.children.cycles-pp.common_file_perm
>>>>         0.09 ±  4%      -0.0        0.07 ±  6%
>>>> perf-profile.children.cycles-pp.__fget_light
>>>>         0.09 ±  4%      -0.0        0.07 ±  6%
>>>> perf-profile.children.cycles-pp.bvec_alloc
>>>>         0.15 ±  7%      -0.0        0.12 ±  3%
>>>> perf-profile.children.cycles-pp.find_get_pages_range_tag
>>>>         0.08 ±  8%      -0.0        0.06 ±  7%
>>>> perf-profile.children.cycles-pp.iov_iter_fault_in_readable
>>>>         0.09 ±  5%      -0.0        0.06 ± 13%
>>>> perf-profile.children.cycles-pp.blk_throtl_bio
>>>>         0.24 ±  4%      -0.0        0.22 ±  3%
>>>> perf-profile.children.cycles-pp._cond_resched
>>>>         0.13 ±  3%      -0.0        0.11 ±  4%
>>>> perf-profile.children.cycles-pp.release_pages
>>>>         0.10 ±  4%      -0.0        0.08 ±  6%
>>>> perf-profile.children.cycles-pp.xfs_bmbt_to_iomap
>>>>         0.08 ± 10%      -0.0        0.06
>>>> perf-profile.children.cycles-pp.unlink
>>>>         0.08 ± 10%      -0.0        0.06 ± 11%
>>>> perf-profile.children.cycles-pp.__sb_start_write
>>>>         0.08 ±  5%      -0.0        0.06 ±  7%
>>>> perf-profile.children.cycles-pp.generic_write_checks
>>>>         0.08 ±  8%      -0.0        0.06
>>>> perf-profile.children.cycles-pp.do_unlinkat
>>>>         0.07 ± 10%      -0.0        0.05
>>>> perf-profile.children.cycles-pp.xfs_break_layouts
>>>>         0.18 ±  2%      -0.0        0.16 ±  2%
>>>> perf-profile.children.cycles-pp.__list_add_valid
>>>>         0.12 ±  3%      -0.0        0.10 ±  8%
>>>> perf-profile.children.cycles-pp.__might_sleep
>>>>         0.14 ±  3%      -0.0        0.12 ±  7%
>>>> perf-profile.children.cycles-pp.xas_find_marked
>>>>         0.07 ± 10%      -0.0        0.05 ±  8%
>>>> perf-profile.children.cycles-pp.bio_associate_blkg_from_css
>>>>         0.08 ±  5%      -0.0        0.06 ± 11%
>>>> perf-profile.children.cycles-pp.bio_free
>>>>         0.08 ±  6%      -0.0        0.06
>>>> perf-profile.children.cycles-pp.xfs_file_llseek
>>>>         0.08 ±  5%      -0.0        0.06 ±  6%
>>>> perf-profile.children.cycles-pp.xfs_file_write_iter
>>>>         0.16 ±  2%      +0.0        0.17 ±  2%
>>>> perf-profile.children.cycles-pp.__switch_to_asm
>>>>         0.05            +0.0        0.07 ±  7%
>>>> perf-profile.children.cycles-pp.cpumask_next_wrap
>>>>         0.10 ±  4%      +0.0        0.12 ±  3%
>>>> perf-profile.children.cycles-pp._find_next_bit
>>>>         0.07 ±  7%      +0.0        0.09 ±  5%
>>>> perf-profile.children.cycles-pp.xlog_state_done_syncing
>>>>         0.16 ±  2%      +0.0        0.19 ±  2%
>>>> perf-profile.children.cycles-pp.check_preempt_curr
>>>>         0.19 ±  4%      +0.0        0.22
>>>> perf-profile.children.cycles-pp.ttwu_do_wakeup
>>>>         0.56 ±  3%      +0.0        0.60
>>>> perf-profile.children.cycles-pp.dequeue_entity
>>>>         0.20 ±  6%      +0.0        0.23 ±  4%
>>>> perf-profile.children.cycles-pp.xfs_trans_committed_bulk
>>>>         0.07 ±  7%      +0.0        0.10 ±  7%
>>>> perf-profile.children.cycles-pp.check_preempt_wakeup
>>>>         0.82 ±  2%      +0.0        0.86
>>>> perf-profile.children.cycles-pp.update_load_avg
>>>>         0.31 ±  3%      +0.0        0.35
>>>> perf-profile.children.cycles-pp.__unwind_start
>>>>         0.08 ±  8%      +0.0        0.12 ±  3%
>>>> perf-profile.children.cycles-pp.destroy_inode
>>>>         0.08 ± 10%      +0.0        0.12 ±  3%
>>>> perf-profile.children.cycles-pp.xfs_fs_destroy_inode
>>>>         0.08 ± 10%      +0.0        0.12 ±  3%
>>>> perf-profile.children.cycles-pp.xfs_inactive
>>>>         0.08 ± 15%      +0.0        0.12 ±  5%
>>>> perf-profile.children.cycles-pp.xfs_bmap_validate_extent
>>>>         3.96            +0.0        4.01
>>>> perf-profile.children.cycles-pp.stack_trace_save_tsk
>>>>         0.28            +0.0        0.33
>>>> perf-profile.children.cycles-pp.set_next_entity
>>>>         0.00            +0.1        0.05
>>>> perf-profile.children.cycles-pp.xfs_trans_roll
>>>>         0.00            +0.1        0.05 ±  8%
>>>> perf-profile.children.cycles-pp.xfs_btree_delrec
>>>>         0.00            +0.1        0.05 ±  8%
>>>> perf-profile.children.cycles-pp.xfs_btree_insert
>>>>         0.16 ±  4%      +0.1        0.21 ±  5%
>>>> perf-profile.children.cycles-pp.memcpy_erms
>>>>         0.04 ± 57%      +0.1        0.10 ±  4%
>>>> perf-profile.children.cycles-pp.xfs_itruncate_extents_flags
>>>>         0.00            +0.1        0.06 ± 11%
>>>> perf-profile.children.cycles-pp.xfs_buf_item_format_segment
>>>>         0.00            +0.1        0.06 ± 11%
>>>> perf-profile.children.cycles-pp.xfs_btree_delete
>>>>         0.00            +0.1        0.06
>>>> perf-profile.children.cycles-pp.xfs_btree_update
>>>>         0.00            +0.1        0.07 ±  7%
>>>> perf-profile.children.cycles-pp.xfs_cil_prepare_item
>>>>         0.00            +0.1        0.07 ±  6%
>>>> perf-profile.children.cycles-pp.xfs_bmbt_update
>>>>         0.00            +0.1        0.07 ± 10%
>>>> perf-profile.children.cycles-pp.xfs_buf_item_format
>>>>         0.56            +0.1        0.64 ±  2%
>>>> perf-profile.children.cycles-pp.pick_next_task_fair
>>>>         0.03 ±100%      +0.1        0.10 ±  4%
>>>> perf-profile.children.cycles-pp.xfs_inactive_truncate
>>>>         0.08 ±  5%      +0.1        0.16 ± 11%
>>>> perf-profile.children.cycles-pp.xfs_iext_lookup_extent
>>>>         0.00            +0.1        0.08 ±  5%
>>>> perf-profile.children.cycles-pp.xfs_defer_finish
>>>>         0.00            +0.1        0.08 ±  5%
>>>> perf-profile.children.cycles-pp.xfs_bmap_check_leaf_extents
>>>>         0.00            +0.1        0.08 ±  5%
>>>> perf-profile.children.cycles-pp.xfs_verify_agbno
>>>>         0.00            +0.1        0.09 ±  9%
>>>> perf-profile.children.cycles-pp.xfs_defer_finish_noroll
>>>>         0.60 ±  3%      +0.1        0.70
>>>> perf-profile.children.cycles-pp.schedule_idle
>>>>         0.39 ±  2%      +0.1        0.49
>>>> perf-profile.children.cycles-pp.xlog_state_release_iclog
>>>>         0.00            +0.1        0.10 ±  9%
>>>> perf-profile.children.cycles-pp.xfs_buf_find
>>>>         0.93 ±  3%      +0.1        1.03 ±  2%
>>>> perf-profile.children.cycles-pp.xlog_write
>>>>         2.58            +0.1        2.69
>>>> perf-profile.children.cycles-pp.schedule
>>>>         1.52            +0.1        1.63
>>>> perf-profile.children.cycles-pp.__wake_up_common_lock
>>>>         0.00            +0.1        0.11 ±  7%
>>>> perf-profile.children.cycles-pp.xfs_buf_get_map
>>>>         4.62            +0.1        4.73
>>>> perf-profile.children.cycles-pp.__account_scheduler_latency
>>>>         0.00            +0.1        0.12 ± 10%
>>>> perf-profile.children.cycles-pp.xfs_buf_read_map
>>>>         1.83            +0.2        1.99
>>>> perf-profile.children.cycles-pp.xlog_cil_push_work
>>>>         5.94            +0.2        6.12
>>>> perf-profile.children.cycles-pp.ttwu_do_activate
>>>>         0.00            +0.2        0.17 ±  6%
>>>> perf-profile.children.cycles-pp.xfs_btree_read_buf_block
>>>>         5.93            +0.2        6.11
>>>> perf-profile.children.cycles-pp.activate_task
>>>>         5.88            +0.2        6.06
>>>> perf-profile.children.cycles-pp.enqueue_task_fair
>>>>         0.00            +0.2        0.18 ±  5%
>>>> perf-profile.children.cycles-pp.xfs_trans_read_buf_map
>>>>         5.41            +0.2        5.59
>>>> perf-profile.children.cycles-pp.enqueue_entity
>>>>         3.14            +0.2        3.33
>>>> perf-profile.children.cycles-pp.__sched_text_start
>>>>         0.00            +0.2        0.21 ±  6%
>>>> perf-profile.children.cycles-pp.xfs_btree_lookup_get_block
>>>>         0.00            +0.2        0.23 ± 57%
>>>> perf-profile.children.cycles-pp.xlog_grant_head_wait
>>>>         0.00            +0.2        0.24 ±  6%
>>>> perf-profile.children.cycles-pp.io_schedule
>>>>         0.11 ±  3%      +0.3        0.38 ±  4%
>>>> perf-profile.children.cycles-pp.__filemap_fdatawait_range
>>>>         0.00            +0.3        0.27 ±  8%
>>>> perf-profile.children.cycles-pp.wait_on_page_bit
>>>>         0.00            +0.3        0.34 ±  5%
>>>> perf-profile.children.cycles-pp.xfs_btree_lookup
>>>>         0.08 ± 14%      +0.4        0.43
>>>> perf-profile.children.cycles-pp.__queue_work
>>>>         0.08 ±  8%      +0.4        0.44
>>>> perf-profile.children.cycles-pp.queue_work_on
>>>>         0.00            +0.4        0.41
>>>> perf-profile.children.cycles-pp.xfs_end_bio
>>>>         3.51            +0.4        3.94 ±  9%
>>>> perf-profile.children.cycles-pp.__xfs_trans_commit
>>>>         0.20 ±  9%      +0.5        0.72 ± 54%
>>>> perf-profile.children.cycles-pp.xfs_log_ticket_ungrant
>>>>         0.06 ± 11%      +0.5        0.58 ± 67%
>>>> perf-profile.children.cycles-pp.xfs_log_space_wake
>>>>         0.45 ±  5%      +0.6        1.04 ± 36%
>>>> perf-profile.children.cycles-pp.xfs_log_reserve
>>>>         0.65 ±  3%      +0.6        1.25 ± 29%
>>>> perf-profile.children.cycles-pp.xfs_trans_alloc
>>>>         0.48 ±  5%      +0.6        1.09 ± 34%
>>>> perf-profile.children.cycles-pp.xfs_trans_reserve
>>>>         0.04 ± 57%      +0.6        0.65 ± 60%
>>>> perf-profile.children.cycles-pp.xlog_grant_head_check
>>>>         4.83            +0.7        5.52
>>>> perf-profile.children.cycles-pp.try_to_wake_up
>>>>         0.00            +0.7        0.70 ±  2%
>>>> perf-profile.children.cycles-pp.xfs_bmap_add_extent_unwritten_real
>>>>         0.00            +0.8        0.75 ±  4%
>>>> perf-profile.children.cycles-pp.xfs_bmapi_convert_unwritten
>>>>         0.04 ± 57%      +0.8        0.80
>>>> perf-profile.children.cycles-pp.autoremove_wake_function
>>>>         0.05 ±  8%      +0.8        0.85
>>>> perf-profile.children.cycles-pp.wake_up_page_bit
>>>>         1.50            +0.9        2.36
>>>> perf-profile.children.cycles-pp.__wake_up_common
>>>>         0.00            +0.9        0.89 ±  2%
>>>> perf-profile.children.cycles-pp.xfs_bmapi_write
>>>>        24.29            +0.9       25.18
>>>> perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>>>>         0.07 ±  5%      +1.0        1.05
>>>> perf-profile.children.cycles-pp.iomap_finish_ioends
>>>>        35.68            +1.0       36.69
>>>> perf-profile.children.cycles-pp.xlog_cil_force_lsn
>>>>         9.53            +1.2       10.76
>>>> perf-profile.children.cycles-pp.intel_idle
>>>>         9.81            +1.3       11.10
>>>> perf-profile.children.cycles-pp.cpuidle_enter_state
>>>>         9.82            +1.3       11.11
>>>> perf-profile.children.cycles-pp.cpuidle_enter
>>>>        12.25            +1.3       13.60
>>>> perf-profile.children.cycles-pp.start_secondary
>>>>        12.49            +1.4       13.89
>>>> perf-profile.children.cycles-pp.secondary_startup_64
>>>>        12.49            +1.4       13.89
>>>> perf-profile.children.cycles-pp.cpu_startup_entry
>>>>        12.48            +1.4       13.88
>>>> perf-profile.children.cycles-pp.do_idle
>>>>        14.78            +1.4       16.20 ±  2%
>>>> perf-profile.children.cycles-pp.xlog_wait_on_iclog
>>>>        58.91            +1.7       60.57
>>>> perf-profile.children.cycles-pp.xfs_log_force_lsn
>>>>         0.00            +2.2        2.24 ± 13%
>>>> perf-profile.children.cycles-pp.xfs_iomap_write_unwritten
>>>>         7.05            +2.8        9.81 ±  2%
>>>> perf-profile.children.cycles-pp.process_one_work
>>>>         7.54            +2.9       10.45 ±  2%
>>>> perf-profile.children.cycles-pp.worker_thread
>>>>         7.55            +2.9       10.46 ±  2%
>>>> perf-profile.children.cycles-pp.ret_from_fork
>>>>         7.55            +2.9       10.46 ±  2%
>>>> perf-profile.children.cycles-pp.kthread
>>>>         0.10            +3.2        3.30 ±  9%
>>>> perf-profile.children.cycles-pp.xfs_end_ioend
>>>>         0.10 ±  4%      +3.2        3.32 ±  8%
>>>> perf-profile.children.cycles-pp.xfs_end_io
>>>>        19.57            +4.0       23.62
>>>> perf-profile.children.cycles-pp.remove_wait_queue
>>>>         1.20            -0.3        0.90 ±  2%
>>>> perf-profile.self.cycles-pp.brd_do_bvec
>>>>         0.55 ±  3%      -0.2        0.39 ±  4%
>>>> perf-profile.self.cycles-pp.do_syscall_64
>>>>         0.31            -0.1        0.22 ±  5%
>>>> perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
>>>>         0.31 ±  3%      -0.1        0.22
>>>> perf-profile.self.cycles-pp.syscall_return_via_sysret
>>>>         0.54 ±  3%      -0.1        0.47 ±  3%
>>>> perf-profile.self.cycles-pp.osq_lock
>>>>         0.23 ±  3%      -0.1        0.16 ±  5%
>>>> perf-profile.self.cycles-pp.entry_SYSCALL_64
>>>>         0.10 ±  4%      -0.1        0.04 ± 57%
>>>> perf-profile.self.cycles-pp.__mod_lruvec_state
>>>>         0.18 ±  4%      -0.1        0.12 ±  5%
>>>> perf-profile.self.cycles-pp.iomap_set_range_uptodate
>>>>         0.60 ±  4%      -0.1        0.54 ±  2%
>>>> perf-profile.self.cycles-pp._raw_spin_lock
>>>>         0.77            -0.0        0.72
>>>> perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>>>>         0.14            -0.0        0.10 ±  8%
>>>> perf-profile.self.cycles-pp.find_get_entry
>>>>         0.14 ±  3%      -0.0        0.11 ±  4%
>>>> perf-profile.self.cycles-pp.xas_load
>>>>         0.17 ±  4%      -0.0        0.14 ±  3%
>>>> perf-profile.self.cycles-pp.write
>>>>         0.30 ±  2%      -0.0        0.27 ±  6%
>>>> perf-profile.self.cycles-pp._raw_spin_lock_irq
>>>>         0.18 ±  5%      -0.0        0.15 ±  7%
>>>> perf-profile.self.cycles-pp.__flush_work
>>>>         0.08 ±  5%      -0.0        0.05
>>>> perf-profile.self.cycles-pp.xfs_inode_item_format_data_fork
>>>>         0.12 ±  3%      -0.0        0.09 ±  4%
>>>> perf-profile.self.cycles-pp.brd_lookup_page
>>>>         0.12 ±  7%      -0.0        0.09 ±  9%
>>>> perf-profile.self.cycles-pp.vfs_write
>>>>         0.18 ±  4%      -0.0        0.15 ±  7%
>>>> perf-profile.self.cycles-pp.insert_work
>>>>         0.13            -0.0        0.10 ±  8%
>>>> perf-profile.self.cycles-pp.memset_erms
>>>>         0.11 ±  4%      -0.0        0.08
>>>> perf-profile.self.cycles-pp.xfs_file_buffered_aio_write
>>>>         0.11 ±  6%      -0.0        0.08 ±  5%
>>>> perf-profile.self.cycles-pp.xfs_buffered_write_iomap_begin
>>>>         0.12 ±  3%      -0.0        0.09 ±  4%
>>>> perf-profile.self.cycles-pp.iomap_writepage_map
>>>>         0.08 ±  8%      -0.0        0.06 ± 15%
>>>> perf-profile.self.cycles-pp.bio_alloc_bioset
>>>>         0.06 ±  6%      -0.0        0.04 ± 57%
>>>> perf-profile.self.cycles-pp.xfs_bmbt_to_iomap
>>>>         0.09 ±  5%      -0.0        0.06 ±  6%
>>>> perf-profile.self.cycles-pp.__fget_light
>>>>         0.06            -0.0        0.04 ± 57%
>>>> perf-profile.self.cycles-pp.xfs_map_blocks
>>>>         0.18 ±  2%      -0.0        0.15 ±  3%
>>>> perf-profile.self.cycles-pp.__list_add_valid
>>>>         0.08 ±  6%      -0.0        0.06 ±  9%
>>>> perf-profile.self.cycles-pp.xfs_ilock
>>>>         0.08 ±  6%      -0.0        0.06 ±  9%
>>>> perf-profile.self.cycles-pp.iov_iter_fault_in_readable
>>>>         0.11 ±  4%      -0.0        0.09 ±  4%
>>>> perf-profile.self.cycles-pp.switch_fpu_return
>>>>         0.07            -0.0        0.05
>>>> perf-profile.self.cycles-pp.iomap_write_actor
>>>>         0.23 ±  2%      -0.0        0.21 ±  5%
>>>> perf-profile.self.cycles-pp.__radix_tree_lookup
>>>>         0.18 ±  4%      -0.0        0.16 ±  6%
>>>> perf-profile.self.cycles-pp.xlog_cil_force_lsn
>>>>         0.20 ±  2%      -0.0        0.18 ±  4%
>>>> perf-profile.self.cycles-pp.kmem_cache_alloc
>>>>         0.10 ±  5%      -0.0        0.08 ± 11%
>>>> perf-profile.self.cycles-pp.xfs_file_fsync
>>>>         0.07 ��  5%      -0.0        0.05 ±  9%
>>>> perf-profile.self.cycles-pp.clear_page_dirty_for_io
>>>>         0.07 ±  6%      -0.0        0.05
>>>> perf-profile.self.cycles-pp.__test_set_page_writeback
>>>>         0.11            -0.0        0.09 ±  8%
>>>> perf-profile.self.cycles-pp.common_file_perm
>>>>         0.23            -0.0        0.21 ±  4%
>>>> perf-profile.self.cycles-pp.update_rq_clock
>>>>         0.08 ±  6%      -0.0        0.06
>>>> perf-profile.self.cycles-pp.xfs_file_write_iter
>>>>         0.10 ±  5%      -0.0        0.08 ±  8%
>>>> perf-profile.self.cycles-pp.up_read
>>>>         0.08 ±  5%      -0.0        0.07
>>>> perf-profile.self.cycles-pp.write_cache_pages
>>>>         0.10            -0.0        0.09
>>>> perf-profile.self.cycles-pp.reweight_entity
>>>>         0.05 ±  8%      +0.0        0.07 ±  7%
>>>> perf-profile.self.cycles-pp.dequeue_entity
>>>>         0.16 ±  4%      +0.0        0.17 ±  2%
>>>> perf-profile.self.cycles-pp.__switch_to_asm
>>>>         0.11 ±  4%      +0.0        0.12 ±  3%
>>>> perf-profile.self.cycles-pp.set_next_entity
>>>>         0.15 ±  3%      +0.0        0.16 ±  2%
>>>> perf-profile.self.cycles-pp.orc_find
>>>>         0.09 ±  4%      +0.0        0.11 ±  6%
>>>> perf-profile.self.cycles-pp.enqueue_entity
>>>>         0.10 ±  4%      +0.0        0.12 ±  3%
>>>> perf-profile.self.cycles-pp._find_next_bit
>>>>         0.01 ±173%      +0.0        0.06 ±  7%
>>>> perf-profile.self.cycles-pp.check_preempt_wakeup
>>>>         0.01 ±173%      +0.0        0.06 ± 11%
>>>> perf-profile.self.cycles-pp.xfs_trans_committed_bulk
>>>>         0.45 ±  2%      +0.1        0.51 ±  2%
>>>> perf-profile.self.cycles-pp.__sched_text_start
>>>>         0.15 ±  6%      +0.1        0.21 ±  3%
>>>> perf-profile.self.cycles-pp.memcpy_erms
>>>>         0.00            +0.1        0.06 ±  6%
>>>> perf-profile.self.cycles-pp.xfs_verify_agbno
>>>>         0.08 ±  8%      +0.1        0.16 ±  9%
>>>> perf-profile.self.cycles-pp.xfs_iext_lookup_extent
>>>>         9.53            +1.2       10.76
>>>> perf-profile.self.cycles-pp.intel_idle
>>>>
>>>>
>>>>                                     aim7.jobs-per-min
>>>>     45000
>>>> +-------------------------------------------------------------------+
>>>>           |        +
>>>> +                                                       |
>>>>     40000 |.+.+    :   + .+.   +.
>>>> .+.     |
>>>>     35000 |-+ :    :    +   +.+
>>>> +.+.+.++.+.+.+.++.+.+.+.++.+.+.++.+.+   ++.+.|
>>>>           |   :
>>>> :                                                          |
>>>>     30000 |-+ :
>>>> :                                                           |
>>>>     25000 |-O :O O:O
>>>> OO                                                     |
>>>>           |   :   :  O    O O OO O O O
>>>> O                                      |
>>>>     20000 |-+  :
>>>> :                                                           |
>>>>     15000 |-+  :
>>>> :                                                           |
>>>>           |    :
>>>> :                                                           |
>>>>     10000 |-+  :
>>>> :                                                            |
>>>>      5000 |-+  :
>>>> :                                                            |
>>>>           |    :
>>>> :                                                            |
>>>>         0
>>>> +-------------------------------------------------------------------+
>>>>                                  aim7.time.system_time
>>>>     5000
>>>> +--------------------------------------------------------------------+
>>>>     4500 |-+        O   OO   O    O O
>>>> O                                       |
>>>>          | O OO O O   O    O   O
>>>> O                                            |
>>>>     4000
>>>> |-+
>>>> |
>>>>     3500
>>>> |-+
>>>> |
>>>>          |             .+ .+.+. .++.+.+.+.+.++.+.+.+.++.+.+.+.+
>>>> .+.+.+. .++.+.|
>>>>     3000 |.+.+       .+  +     +                               +
>>>> +      |
>>>>     2500 |-+ :
>>>> +.+                                                         |
>>>>     2000 |-+ :
>>>> :                                                           |
>>>>          |   :
>>>> :                                                            |
>>>>     1500 |-+  :
>>>> :                                                            |
>>>>     1000 |-+  :
>>>> :                                                            |
>>>>          |    :
>>>> :                                                            |
>>>>      500 |-+  :
>>>> :                                                             |
>>>>        0
>>>> +--------------------------------------------------------------------+
>>>>                                 aim7.time.elapsed_time
>>>>     160
>>>> +---------------------------------------------------------------------+
>>>>         |   O OO O O O O OO O O O
>>>> O                                         |
>>>>     140
>>>> |-O
>>>> |
>>>>     120
>>>> |-+
>>>> |
>>>> |                                                                     |
>>>>     100 |-+           .+. +.+.
>>>> .+.+.++.+.+.+.+.+.++.+.+.+.+.++.+.+.+.+. +.+.+.|
>>>>         |.+.+    +. .+   +    +
>>>> +      |
>>>>      80 |-+ :    :
>>>> +                                                          |
>>>>         |    :
>>>> :                                                            |
>>>>      60 |-+  :
>>>> :                                                             |
>>>>      40 |-+  :
>>>> :                                                             |
>>>>         |    :
>>>> :                                                             |
>>>>      20 |-+   :
>>>> :                                                             |
>>>>         |
>>>> ::                                                              |
>>>>       0
>>>> +---------------------------------------------------------------------+
>>>>                               aim7.time.elapsed_time.max
>>>>     160
>>>> +---------------------------------------------------------------------+
>>>>         |   O OO O O O O OO O O O
>>>> O                                         |
>>>>     140
>>>> |-O
>>>> |
>>>>     120
>>>> |-+
>>>> |
>>>> |                                                                     |
>>>>     100 |-+           .+. +.+.
>>>> .+.+.++.+.+.+.+.+.++.+.+.+.+.++.+.+.+.+. +.+.+.|
>>>>         |.+.+    +. .+   +    +
>>>> +      |
>>>>      80 |-+ :    :
>>>> +                                                          |
>>>>         |    :
>>>> :                                                            |
>>>>      60 |-+  :
>>>> :                                                             |
>>>>      40 |-+  :
>>>> :                                                             |
>>>>         |    :
>>>> :                                                             |
>>>>      20 |-+   :
>>>> :                                                             |
>>>>         |
>>>> ::                                                              |
>>>>       0
>>>> +---------------------------------------------------------------------+
>>>>                           aim7.time.voluntary_context_switches
>>>>     8e+07
>>>> +-------------------------------------------------------------------+
>>>>           | O          O  O O OO O
>>>> O                                        |
>>>>     7e+07
>>>> |-+
>>>> |
>>>>     6e+07
>>>> |-+
>>>> |
>>>> |                                                                   |
>>>>     5e+07 |-+           +.+.+.++.+.+.+.++.+.+. .+   .+.+.    .+.
>>>> .+.   +.+.|
>>>>           |.+.+       .+                      +  +.+     ++.+   ++.+
>>>> +.+    |
>>>>     4e+07 |-+ :
>>>> +.+                                                        |
>>>>           |   :
>>>> :                                                          |
>>>>     3e+07 |-+ :
>>>> :                                                           |
>>>>     2e+07 |-+  :
>>>> :                                                           |
>>>>           |    :
>>>> :                                                           |
>>>>     1e+07 |-+  :
>>>> :                                                           |
>>>>           |    :
>>>> :                                                            |
>>>>         0
>>>> +-------------------------------------------------------------------+
>>>> [*] bisect-good sample
>>>> [O] bisect-bad  sample
>>>>
>>>>
>>>>
>>>> Disclaimer:
>>>> Results have been estimated based on internal Intel analysis and are
>>>> provided
>>>> for informational purposes only. Any difference in system hardware
>>>> or software
>>>> design or configuration may affect actual performance.
>>>>
>>>>
>>>> Thanks,
>>>> Rong Chen
>>>>
>>>>
>>>> _______________________________________________
>>>> LKP mailing list -- lkp@lists.01.org
>>>> To unsubscribe send an email to lkp-leave@lists.01.org
>>>>
>>>
>>
>> -- 
>> Zhengjun Xing

-- 
Zhengjun Xing
