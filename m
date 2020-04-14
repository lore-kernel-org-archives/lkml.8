Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3641C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 05:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C788E20678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 05:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405630AbgDNFtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 01:49:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:54925 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405621AbgDNFtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 01:49:23 -0400
IronPort-SDR: 3Y1lOxn0WmlArUqP6i7blvAbxvDT/yas6scK2ezmaeWvTrcflyhv/fM44xjo6JCtLXFAgh8WOP
 oR1q4FHQko4g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 22:49:18 -0700
IronPort-SDR: 2WlCmS/yZQ0uiBgyKGenhjE2e+RQmNYsuVin/azCKBmnxB76QoEEuftbDLQG07hCOZG2Jx5jR0
 OhMart802Tkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,381,1580803200"; 
   d="scan'208";a="363277854"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.255.29.110]) ([10.255.29.110])
  by fmsmga001.fm.intel.com with ESMTP; 13 Apr 2020 22:49:16 -0700
Subject: Re: [LKP] [ext4] d3b6f23f71: stress-ng.fiemap.ops_per_sec -60.5%
 regression
To:     Ritesh Harjani <riteshh@linux.ibm.com>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, kbuild test robot <lkp@intel.com>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200407080036.GA8179@shao2-debian>
 <f06f7ebf-ec9c-3126-f00a-a3578ecee3f6@linux.intel.com>
 <20200413105656.9B0D1AE04D@d06av26.portsmouth.uk.ibm.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <bf06a978-828a-9676-0ff8-fa47826d0bdd@linux.intel.com>
Date:   Tue, 14 Apr 2020 13:49:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200413105656.9B0D1AE04D@d06av26.portsmouth.uk.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your quick response, if you need any more test information 
about the regression, please let me known.

On 4/13/2020 6:56 PM, Ritesh Harjani wrote:
> 
> 
> On 4/13/20 2:07 PM, Xing Zhengjun wrote:
>> Hi Harjani,
>>
>>     Do you have time to take a look at this? Thanks.
> 
> Hello Xing,
> 
> I do want to look into this. But as of now I am stuck with another
> mballoc failure issue. I will get back at this once I have some handle
> over that one.
> 
> BTW, are you planning to take look at this?
> 
> -ritesh
> 
> 
>>
>> On 4/7/2020 4:00 PM, kernel test robot wrote:
>>> Greeting,
>>>
>>> FYI, we noticed a -60.5% regression of stress-ng.fiemap.ops_per_sec 
>>> due to commit:
>>>
>>>
>>> commit: d3b6f23f71670007817a5d59f3fbafab2b794e8c ("ext4: move 
>>> ext4_fiemap to use iomap framework")
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>
>>> in testcase: stress-ng
>>> on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz 
>>> with 192G memory
>>> with following parameters:
>>>
>>>     nr_threads: 10%
>>>     disk: 1HDD
>>>     testtime: 1s
>>>     class: os
>>>     cpufreq_governor: performance
>>>     ucode: 0x500002c
>>>     fs: ext4
>>>
>>>
>>>
>>>
>>>
>>>
>>> Details are as below:
>>> --------------------------------------------------------------------------------------------------> 
>>>
>>>
>>>
>>> To reproduce:
>>>
>>>          git clone https://github.com/intel/lkp-tests.git
>>>          cd lkp-tests
>>>          bin/lkp install job.yaml  # job file is attached in this email
>>>          bin/lkp run     job.yaml
>>>
>>> ========================================================================================= 
>>>
>>> class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/testcase/testtime/ucode: 
>>>
>>> os/gcc-7/performance/1HDD/ext4/x86_64-rhel-7.6/10%/debian-x86_64-20191114.cgz/lkp-csl-2sp5/stress-ng/1s/0x500002c 
>>>
>>>
>>> commit:
>>>    b2c5764262 ("ext4: make ext4_ind_map_blocks work with fiemap")
>>>    d3b6f23f71 ("ext4: move ext4_fiemap to use iomap framework")
>>>
>>> b2c5764262edded1 d3b6f23f71670007817a5d59f3f
>>> ---------------- ---------------------------
>>>         fail:runs  %reproduction    fail:runs
>>>             |             |             |
>>>             :4           25%           1:4 
>>> dmesg.WARNING:at#for_ip_interrupt_entry/0x
>>>            2:4            5%           2:4 
>>> perf-profile.calltrace.cycles-pp.sync_regs.error_entry
>>>            2:4            6%           3:4 
>>> perf-profile.calltrace.cycles-pp.error_entry
>>>            3:4            9%           3:4 
>>> perf-profile.children.cycles-pp.error_entry
>>>            0:4            1%           0:4 
>>> perf-profile.self.cycles-pp.error_entry
>>>           %stddev     %change         %stddev
>>>               \          |                \
>>>       28623           +28.2%      36703 ± 12%  stress-ng.daemon.ops
>>>       28632           +28.2%      36704 ± 12% 
>>> stress-ng.daemon.ops_per_sec
>>>      566.00 ± 22%     -53.2%     265.00 ± 53%  stress-ng.dev.ops
>>>      278.81 ± 22%     -53.0%     131.00 ± 54%  stress-ng.dev.ops_per_sec
>>>       73160           -60.6%      28849 ±  3%  stress-ng.fiemap.ops
>>>       72471           -60.5%      28612 ±  3% 
>>> stress-ng.fiemap.ops_per_sec
>>>       23421 ± 12%     +21.2%      28388 ±  6%  stress-ng.filename.ops
>>>       22638 ± 12%     +20.3%      27241 ±  6% 
>>> stress-ng.filename.ops_per_sec
>>>       21.25 ±  7%     -10.6%      19.00 ±  3%  stress-ng.iomix.ops
>>>       38.75 ± 49%     -47.7%      20.25 ± 96%  stress-ng.memhotplug.ops
>>>       34.45 ± 52%     -51.8%      16.62 ±106% 
>>> stress-ng.memhotplug.ops_per_sec
>>>        1734 ± 10%     +31.4%       2278 ± 10%  stress-ng.resources.ops
>>>      807.56 ±  5%     +35.2%       1091 ±  8% 
>>> stress-ng.resources.ops_per_sec
>>>     1007356 ±  3%     -16.5%     840642 ±  9%  stress-ng.revio.ops
>>>     1007692 ±  3%     -16.6%     840711 ±  9% 
>>> stress-ng.revio.ops_per_sec
>>>       21812 ±  3%     +16.0%      25294 ±  5%  stress-ng.sysbadaddr.ops
>>>       21821 ±  3%     +15.9%      25294 ±  5% 
>>> stress-ng.sysbadaddr.ops_per_sec
>>>      440.75 ±  4%     +21.9%     537.25 ±  9%  stress-ng.sysfs.ops
>>>      440.53 ±  4%     +21.9%     536.86 ±  9% 
>>> stress-ng.sysfs.ops_per_sec
>>>    13286582           -11.1%   11805520 ±  6% 
>>> stress-ng.time.file_system_outputs
>>>    68253896            +2.4%   69860122 stress-ng.time.minor_page_faults
>>>      197.00 ±  4%     -15.9%     165.75 ± 12%  stress-ng.xattr.ops
>>>      192.45 ±  5%     -16.1%     161.46 ± 11% 
>>> stress-ng.xattr.ops_per_sec
>>>       15310           +62.5%      24875 ± 22%  stress-ng.zombie.ops
>>>       15310           +62.5%      24874 ± 22% 
>>> stress-ng.zombie.ops_per_sec
>>>      203.50 ± 12%     -47.3%     107.25 ± 49%  vmstat.io.bi
>>>      861318 ± 18%     -29.7%     605884 ±  5%  meminfo.AnonHugePages
>>>     1062742 ± 14%     -20.2%     847853 ±  3%  meminfo.AnonPages
>>>       31093 ±  6%      +9.6%      34090 ±  3%  meminfo.KernelStack
>>>        7151 ± 34%     +55.8%      11145 ±  9%  meminfo.Mlocked
>>>   1.082e+08 ±  5%     -40.2%   64705429 ± 31% 
>>> numa-numastat.node0.local_node
>>>   1.082e+08 ±  5%     -40.2%   64739883 ± 31% 
>>> numa-numastat.node0.numa_hit
>>>    46032662 ± 21%    +104.3%   94042918 ± 20% 
>>> numa-numastat.node1.local_node
>>>    46074205 ± 21%    +104.2%   94072810 ± 20% 
>>> numa-numastat.node1.numa_hit
>>>        3942 ±  3%     +14.2%       4501 ±  4% 
>>> slabinfo.pool_workqueue.active_objs
>>>        4098 ±  3%     +14.3%       4683 ±  4% 
>>> slabinfo.pool_workqueue.num_objs
>>>        4817 ±  7%     +13.3%       5456 ±  8% 
>>> slabinfo.proc_dir_entry.active_objs
>>>        5153 ±  6%     +12.5%       5797 ±  8% 
>>> slabinfo.proc_dir_entry.num_objs
>>>       18598 ± 13%     -33.1%      12437 ± 20% 
>>> sched_debug.cfs_rq:/.load.avg
>>>      452595 ± 56%     -71.4%     129637 ± 76% 
>>> sched_debug.cfs_rq:/.load.max
>>>       67675 ± 35%     -55.1%      30377 ± 42% 
>>> sched_debug.cfs_rq:/.load.stddev
>>>       18114 ± 12%     -33.7%      12011 ± 20% 
>>> sched_debug.cfs_rq:/.runnable_weight.avg
>>>      448215 ± 58%     -72.8%     121789 ± 82% 
>>> sched_debug.cfs_rq:/.runnable_weight.max
>>>       67083 ± 37%     -56.3%      29305 ± 43% 
>>> sched_debug.cfs_rq:/.runnable_weight.stddev
>>>      -38032          +434.3%    -203212 sched_debug.cfs_rq:/.spread0.avg
>>>     -204466           +95.8%    -400301 sched_debug.cfs_rq:/.spread0.min
>>>       90.02 ± 25%     -58.1%      37.69 ± 52% 
>>> sched_debug.cfs_rq:/.util_est_enqueued.avg
>>>      677.54 ±  6%     -39.3%     411.50 ± 22% 
>>> sched_debug.cfs_rq:/.util_est_enqueued.max
>>>      196.57 ±  8%     -47.6%     103.05 ± 36% 
>>> sched_debug.cfs_rq:/.util_est_enqueued.stddev
>>>        3.34 ± 23%     +34.1%       4.48 ±  4% 
>>> sched_debug.cpu.clock.stddev
>>>        3.34 ± 23%     +34.1%       4.48 ±  4% 
>>> sched_debug.cpu.clock_task.stddev
>>>      402872 ±  7%     -11.9%     354819 ±  2%  
>>> proc-vmstat.nr_active_anon
>>>     1730331            -9.5%    1566418 ±  5%  proc-vmstat.nr_dirtied
>>>       31042 ±  6%      +9.3%      33915 ±  3% 
>>> proc-vmstat.nr_kernel_stack
>>>      229047            -2.4%     223615        proc-vmstat.nr_mapped
>>>       74008 ±  7%     +20.5%      89163 ±  8%  proc-vmstat.nr_written
>>>      402872 ±  7%     -11.9%     354819 ±  2% 
>>> proc-vmstat.nr_zone_active_anon
>>>       50587 ± 11%     -25.2%      37829 ± 14% 
>>> proc-vmstat.numa_pages_migrated
>>>      457500           -23.1%     351918 ± 31% 
>>> proc-vmstat.numa_pte_updates
>>>    81382485            +1.9%   82907822        proc-vmstat.pgfault
>>>   2.885e+08 ±  5%     -13.3%  2.502e+08 ±  6%  proc-vmstat.pgfree
>>>       42206 ± 12%     -46.9%      22399 ± 49%  proc-vmstat.pgpgin
>>>      431233 ± 13%     -64.8%     151736 ±109%  proc-vmstat.pgrotated
>>>      176754 ±  7%     -40.2%     105637 ± 31% 
>>> proc-vmstat.thp_fault_alloc
>>>      314.50 ± 82%    +341.5%       1388 ± 44% 
>>> proc-vmstat.unevictable_pgs_stranded
>>>     1075269 ± 14%     -41.3%     631388 ± 17%  numa-meminfo.node0.Active
>>>      976056 ± 12%     -39.7%     588727 ± 19% 
>>> numa-meminfo.node0.Active(anon)
>>>      426857 ± 22%     -36.4%     271375 ± 13% 
>>> numa-meminfo.node0.AnonHugePages
>>>      558590 ± 19%     -36.4%     355402 ± 14% 
>>> numa-meminfo.node0.AnonPages
>>>     1794824 ±  9%     -28.8%    1277157 ± 20% 
>>> numa-meminfo.node0.FilePages
>>>        8517 ± 92%     -82.7%       1473 ± 89% 
>>> numa-meminfo.node0.Inactive(file)
>>>      633118 ±  2%     -41.7%     368920 ± 36%  numa-meminfo.node0.Mapped
>>>     2958038 ± 12%     -27.7%    2139271 ± 12%  
>>> numa-meminfo.node0.MemUsed
>>>      181401 ±  5%     -13.7%     156561 ±  4% 
>>> numa-meminfo.node0.SUnreclaim
>>>      258124 ±  6%     -13.0%     224535 ±  5%  numa-meminfo.node0.Slab
>>>      702083 ± 16%     +31.0%     919406 ± 11%  numa-meminfo.node1.Active
>>>       38663 ±107%    +137.8%      91951 ± 31% 
>>> numa-meminfo.node1.Active(file)
>>>     1154975 ±  7%     +41.6%    1635593 ± 12% 
>>> numa-meminfo.node1.FilePages
>>>      395813 ± 25%     +62.8%     644533 ± 16% 
>>> numa-meminfo.node1.Inactive
>>>      394313 ± 25%     +62.5%     640686 ± 16% 
>>> numa-meminfo.node1.Inactive(anon)
>>>      273317           +88.8%     515976 ± 25%  numa-meminfo.node1.Mapped
>>>     2279237 ±  6%     +25.7%    2865582 ±  7%  
>>> numa-meminfo.node1.MemUsed
>>>       10830 ± 18%     +29.6%      14033 ±  9% 
>>> numa-meminfo.node1.PageTables
>>>      149390 ±  3%     +23.2%     184085 ±  3% 
>>> numa-meminfo.node1.SUnreclaim
>>>      569542 ± 16%     +74.8%     995336 ± 21%  numa-meminfo.node1.Shmem
>>>      220774 ±  5%     +20.3%     265656 ±  3%  numa-meminfo.node1.Slab
>>>    35623587 ±  5%     -11.7%   31444514 ±  3%  perf-stat.i.cache-misses
>>>   2.576e+08 ±  5%      -6.8%    2.4e+08 ±  2% 
>>> perf-stat.i.cache-references
>>>        3585            -7.3%       3323 ±  5%  
>>> perf-stat.i.cpu-migrations
>>>      180139 ±  2%      +4.2%     187668        perf-stat.i.minor-faults
>>>       69.13            +2.6       71.75 perf-stat.i.node-load-miss-rate%
>>>     4313695 ±  2%      -7.4%    3994957 ±  2% 
>>> perf-stat.i.node-load-misses
>>>     5466253 ± 11%     -17.3%    4521173 ±  6%  perf-stat.i.node-loads
>>>     2818674 ±  6%     -15.8%    2372542 ±  5%  perf-stat.i.node-stores
>>>      227810            +4.6%     238290        perf-stat.i.page-faults
>>>       12.67 ±  4%      -7.2%      11.76 ±  2%  perf-stat.overall.MPKI
>>>        1.01 ±  4%      -0.0        0.97 ±  3% 
>>> perf-stat.overall.branch-miss-rate%
>>>        1044           +13.1%       1181 ±  4% 
>>> perf-stat.overall.cycles-between-cache-misses
>>>       40.37 ±  4%      +3.6       44.00 ±  2% 
>>> perf-stat.overall.node-store-miss-rate%
>>>    36139526 ±  5%     -12.5%   31625519 ±  3%  perf-stat.ps.cache-misses
>>>   2.566e+08 ±  5%      -6.9%  2.389e+08 ±  2% 
>>> perf-stat.ps.cache-references
>>>        3562            -7.2%       3306 ±  5% 
>>> perf-stat.ps.cpu-migrations
>>>      179088            +4.2%     186579        perf-stat.ps.minor-faults
>>>     4323383 ±  2%      -7.5%    3999214 perf-stat.ps.node-load-misses
>>>     5607721 ± 10%     -18.5%    4568664 ±  6%  perf-stat.ps.node-loads
>>>     2855134 ±  7%     -16.4%    2387345 ±  5%  perf-stat.ps.node-stores
>>>      226270            +4.6%     236709        perf-stat.ps.page-faults
>>>      242305 ± 10%     -42.4%     139551 ± 18% 
>>> numa-vmstat.node0.nr_active_anon
>>>      135983 ± 17%     -37.4%      85189 ± 10% 
>>> numa-vmstat.node0.nr_anon_pages
>>>      209.25 ± 16%     -38.1%     129.50 ± 10% 
>>> numa-vmstat.node0.nr_anon_transparent_hugepages
>>>      449367 ±  9%     -29.7%     315804 ± 20% 
>>> numa-vmstat.node0.nr_file_pages
>>>        2167 ± 90%     -80.6%     419.75 ± 98% 
>>> numa-vmstat.node0.nr_inactive_file
>>>      157405 ±  3%     -41.4%      92206 ± 35% 
>>> numa-vmstat.node0.nr_mapped
>>>        2022 ± 30%     -73.3%     539.25 ± 91%  
>>> numa-vmstat.node0.nr_mlock
>>>        3336 ± 10%     -24.3%       2524 ± 25% 
>>> numa-vmstat.node0.nr_page_table_pages
>>>      286158 ± 10%     -41.2%     168337 ± 37%  
>>> numa-vmstat.node0.nr_shmem
>>>       45493 ±  5%     -14.1%      39094 ±  4% 
>>> numa-vmstat.node0.nr_slab_unreclaimable
>>>      242294 ± 10%     -42.4%     139547 ± 18% 
>>> numa-vmstat.node0.nr_zone_active_anon
>>>        2167 ± 90%     -80.6%     419.75 ± 98% 
>>> numa-vmstat.node0.nr_zone_inactive_file
>>>    54053924 ±  8%     -39.3%   32786242 ± 34%  
>>> numa-vmstat.node0.numa_hit
>>>    53929628 ±  8%     -39.5%   32619715 ± 34% 
>>> numa-vmstat.node0.numa_local
>>>        9701 ±107%    +136.9%      22985 ± 31% 
>>> numa-vmstat.node1.nr_active_file
>>>      202.50 ± 16%     -25.1%     151.75 ± 23% 
>>> numa-vmstat.node1.nr_anon_transparent_hugepages
>>>      284922 ±  7%     +43.3%     408195 ± 13% 
>>> numa-vmstat.node1.nr_file_pages
>>>       96002 ± 26%     +67.5%     160850 ± 17% 
>>> numa-vmstat.node1.nr_inactive_anon
>>>       68077 ±  2%     +90.3%     129533 ± 25% 
>>> numa-vmstat.node1.nr_mapped
>>>      138482 ± 15%     +79.2%     248100 ± 22%  
>>> numa-vmstat.node1.nr_shmem
>>>       37396 ±  3%     +23.3%      46094 ±  3% 
>>> numa-vmstat.node1.nr_slab_unreclaimable
>>>        9701 ±107%    +136.9%      22985 ± 31% 
>>> numa-vmstat.node1.nr_zone_active_file
>>>       96005 ± 26%     +67.5%     160846 ± 17% 
>>> numa-vmstat.node1.nr_zone_inactive_anon
>>>    23343661 ± 17%     +99.9%   46664267 ± 23%  
>>> numa-vmstat.node1.numa_hit
>>>    23248487 ± 17%    +100.5%   46610447 ± 23% 
>>> numa-vmstat.node1.numa_local
>>>      105745 ± 23%    +112.6%     224805 ± 24%  softirqs.CPU0.NET_RX
>>>      133310 ± 36%     -45.3%      72987 ± 52%  softirqs.CPU1.NET_RX
>>>      170110 ± 55%     -66.8%      56407 ±147%  softirqs.CPU11.NET_RX
>>>       91465 ± 36%     -65.2%      31858 ±112%  softirqs.CPU13.NET_RX
>>>      164491 ± 57%     -77.7%      36641 ±121%  softirqs.CPU15.NET_RX
>>>      121069 ± 55%     -99.3%     816.75 ± 96%  softirqs.CPU17.NET_RX
>>>       81019 ±  4%      -8.7%      73967 ±  4%  softirqs.CPU20.RCU
>>>       72143 ± 63%     -89.8%       7360 ±172%  softirqs.CPU22.NET_RX
>>>      270663 ± 17%     -57.9%     113915 ± 45%  softirqs.CPU24.NET_RX
>>>       20149 ± 76%    +474.1%     115680 ± 62%  softirqs.CPU26.NET_RX
>>>       14033 ± 70%    +977.5%     151211 ± 75%  softirqs.CPU27.NET_RX
>>>       27834 ± 94%    +476.1%     160357 ± 28%  softirqs.CPU28.NET_RX
>>>       35346 ± 68%    +212.0%     110290 ± 30%  softirqs.CPU29.NET_RX
>>>       34347 ±103%    +336.5%     149941 ± 32%  softirqs.CPU32.NET_RX
>>>       70077 ±  3%     +10.8%      77624 ±  3%  softirqs.CPU34.RCU
>>>       36453 ± 84%    +339.6%     160253 ± 42%  softirqs.CPU36.NET_RX
>>>       72367 ±  2%     +10.6%      80043        softirqs.CPU37.RCU
>>>       25239 ±118%    +267.7%      92799 ± 45%  softirqs.CPU38.NET_RX
>>>        4995 ±170%   +1155.8%      62734 ± 62%  softirqs.CPU39.NET_RX
>>>        4641 ±145%   +1611.3%      79432 ± 90%  softirqs.CPU42.NET_RX
>>>        7192 ± 65%    +918.0%      73225 ± 66%  softirqs.CPU45.NET_RX
>>>        1772 ±166%   +1837.4%      34344 ± 63%  softirqs.CPU46.NET_RX
>>>       13149 ± 81%    +874.7%     128170 ± 58%  softirqs.CPU47.NET_RX
>>>       86484 ± 94%     -92.6%       6357 ±172%  softirqs.CPU48.NET_RX
>>>      129128 ± 27%     -95.8%       5434 ±172%  softirqs.CPU55.NET_RX
>>>       82772 ± 59%     -91.7%       6891 ±164%  softirqs.CPU56.NET_RX
>>>      145313 ± 57%     -87.8%      17796 ± 88%  softirqs.CPU57.NET_RX
>>>      118160 ± 33%     -86.3%      16226 ±109%  softirqs.CPU58.NET_RX
>>>       94576 ± 56%     -94.1%       5557 ±173%  softirqs.CPU6.NET_RX
>>>       82900 ± 77%     -66.8%      27508 ±171%  softirqs.CPU62.NET_RX
>>>      157291 ± 30%     -81.1%      29656 ±111%  softirqs.CPU64.NET_RX
>>>      135101 ± 28%     -80.2%      26748 ± 90%  softirqs.CPU67.NET_RX
>>>      146574 ± 56%    -100.0%      69.75 ± 98%  softirqs.CPU68.NET_RX
>>>       81347 ±  2%      -9.0%      74024 ±  2%  softirqs.CPU68.RCU
>>>      201729 ± 37%     -99.6%     887.50 ±107%  softirqs.CPU69.NET_RX
>>>      108454 ± 78%     -97.9%       2254 ±169%  softirqs.CPU70.NET_RX
>>>       55289 ±104%     -89.3%       5942 ±172%  softirqs.CPU71.NET_RX
>>>       10112 ±172%    +964.6%     107651 ± 89%  softirqs.CPU72.NET_RX
>>>        3136 ±171%   +1522.2%      50879 ± 66%  softirqs.CPU73.NET_RX
>>>       13353 ± 79%    +809.2%     121407 ±101%  softirqs.CPU74.NET_RX
>>>       75194 ±  3%     +10.3%      82957 ±  5%  softirqs.CPU75.RCU
>>>       11002 ±173%   +1040.8%     125512 ± 61%  softirqs.CPU76.NET_RX
>>>        2463 ±173%   +2567.3%      65708 ± 77%  softirqs.CPU78.NET_RX
>>>       25956 ±  3%      -7.8%      23932 ±  3%  softirqs.CPU78.SCHED
>>>       16366 ±150%    +340.7%      72125 ± 91%  softirqs.CPU82.NET_RX
>>>       14553 ±130%   +1513.4%     234809 ± 27%  softirqs.CPU93.NET_RX
>>>       26314            -9.2%      23884 ±  3%  softirqs.CPU93.SCHED
>>>        4582 ± 88%   +4903.4%     229268 ± 23%  softirqs.CPU94.NET_RX
>>>       11214 ±111%   +1762.5%     208867 ± 18%  softirqs.CPU95.NET_RX
>>>        1.53 ± 27%      -0.5        0.99 ± 17% 
>>> perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe 
>>>
>>>        1.52 ± 27%      -0.5        0.99 ± 17% 
>>> perf-profile.calltrace.cycles-pp.do_signal.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe 
>>>
>>>        1.39 ± 29%      -0.5        0.88 ± 21% 
>>> perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.do_signal.exit_to_usermode_loop.do_syscall_64 
>>>
>>>        1.39 ± 29%      -0.5        0.88 ± 21% 
>>> perf-profile.calltrace.cycles-pp.get_signal.do_signal.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe 
>>>
>>>        0.50 ± 59%      +0.3        0.81 ± 13% 
>>> perf-profile.calltrace.cycles-pp.filemap_map_pages.handle_pte_fault.__handle_mm_fault.handle_mm_fault.do_page_fault 
>>>
>>>        5.70 ±  9%      +0.8        6.47 ±  7% 
>>> perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.do_signal.exit_to_usermode_loop 
>>>
>>>        5.48 ±  9%      +0.8        6.27 ±  7% 
>>> perf-profile.calltrace.cycles-pp.exit_mmap.mmput.do_exit.do_group_exit.get_signal 
>>>
>>>        5.49 ±  9%      +0.8        6.28 ±  7% 
>>> perf-profile.calltrace.cycles-pp.mmput.do_exit.do_group_exit.get_signal.do_signal 
>>>
>>>        4.30 ±  4%      +1.3        5.60 ±  7% 
>>> perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.do_signal.exit_to_usermode_loop.prepare_exit_to_usermode 
>>>
>>>        4.40 ±  4%      +1.3        5.69 ±  7% 
>>> perf-profile.calltrace.cycles-pp.prepare_exit_to_usermode.swapgs_restore_regs_and_return_to_usermode 
>>>
>>>        4.37 ±  4%      +1.3        5.66 ±  7% 
>>> perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.prepare_exit_to_usermode.swapgs_restore_regs_and_return_to_usermode 
>>>
>>>        4.36 ±  4%      +1.3        5.66 ±  7% 
>>> perf-profile.calltrace.cycles-pp.do_signal.exit_to_usermode_loop.prepare_exit_to_usermode.swapgs_restore_regs_and_return_to_usermode 
>>>
>>>        4.33 ±  4%      +1.3        5.62 ±  7% 
>>> perf-profile.calltrace.cycles-pp.get_signal.do_signal.exit_to_usermode_loop.prepare_exit_to_usermode.swapgs_restore_regs_and_return_to_usermode 
>>>
>>>        4.44 ±  4%      +1.3        5.74 ±  7% 
>>> perf-profile.calltrace.cycles-pp.swapgs_restore_regs_and_return_to_usermode 
>>>
>>>        3.20 ± 10%      -2.4        0.78 ±156% 
>>> perf-profile.children.cycles-pp.copy_page
>>>        0.16 ±  9%      -0.1        0.08 ± 64% 
>>> perf-profile.children.cycles-pp.irq_work_interrupt
>>>        0.16 ±  9%      -0.1        0.08 ± 64% 
>>> perf-profile.children.cycles-pp.smp_irq_work_interrupt
>>>        0.24 ±  5%      -0.1        0.17 ± 18% 
>>> perf-profile.children.cycles-pp.irq_work_run_list
>>>        0.16 ±  9%      -0.1        0.10 ± 24% 
>>> perf-profile.children.cycles-pp.irq_work_run
>>>        0.16 ±  9%      -0.1        0.10 ± 24% 
>>> perf-profile.children.cycles-pp.printk
>>>        0.23 ±  6%      -0.1        0.17 ±  9% 
>>> perf-profile.children.cycles-pp.__do_execve_file
>>>        0.08 ± 14%      -0.1        0.03 ±100% 
>>> perf-profile.children.cycles-pp.delay_tsc
>>>        0.16 ±  6%      -0.1        0.11 ±  9% 
>>> perf-profile.children.cycles-pp.load_elf_binary
>>>        0.16 ±  7%      -0.0        0.12 ± 13% 
>>> perf-profile.children.cycles-pp.search_binary_handler
>>>        0.20 ±  7%      -0.0        0.15 ± 10% 
>>> perf-profile.children.cycles-pp.call_usermodehelper_exec_async
>>>        0.19 ±  6%      -0.0        0.15 ± 11% 
>>> perf-profile.children.cycles-pp.do_execve
>>>        0.08 ± 10%      -0.0        0.04 ± 59% 
>>> perf-profile.children.cycles-pp.__vunmap
>>>        0.15 ±  3%      -0.0        0.11 ±  7% 
>>> perf-profile.children.cycles-pp.rcu_idle_exit
>>>        0.12 ± 10%      -0.0        0.09 ± 14% 
>>> perf-profile.children.cycles-pp.__switch_to_asm
>>>        0.09 ± 13%      -0.0        0.07 ±  5% 
>>> perf-profile.children.cycles-pp.des3_ede_encrypt
>>>        0.06 ± 11%      +0.0        0.09 ± 13% 
>>> perf-profile.children.cycles-pp.mark_page_accessed
>>>        0.15 ±  5%      +0.0        0.19 ± 12% 
>>> perf-profile.children.cycles-pp.apparmor_cred_prepare
>>>        0.22 ±  8%      +0.0        0.27 ± 11% 
>>> perf-profile.children.cycles-pp.mem_cgroup_throttle_swaprate
>>>        0.17 ±  2%      +0.0        0.22 ± 12% 
>>> perf-profile.children.cycles-pp.security_prepare_creds
>>>        0.95 ± 17%      +0.3        1.22 ± 14% 
>>> perf-profile.children.cycles-pp.filemap_map_pages
>>>        5.92 ±  8%      +0.7        6.65 ±  7% 
>>> perf-profile.children.cycles-pp.get_signal
>>>        5.66 ±  9%      +0.8        6.44 ±  7% 
>>> perf-profile.children.cycles-pp.mmput
>>>        5.65 ±  9%      +0.8        6.43 ±  7% 
>>> perf-profile.children.cycles-pp.exit_mmap
>>>        4.40 ±  4%      +1.3        5.70 ±  7% 
>>> perf-profile.children.cycles-pp.prepare_exit_to_usermode
>>>        4.45 ±  4%      +1.3        5.75 ±  7% 
>>> perf-profile.children.cycles-pp.swapgs_restore_regs_and_return_to_usermode 
>>>
>>>        3.16 ± 10%      -2.4        0.77 ±155% 
>>> perf-profile.self.cycles-pp.copy_page
>>>        0.08 ± 14%      -0.1        0.03 ±100% 
>>> perf-profile.self.cycles-pp.delay_tsc
>>>        0.12 ± 10%      -0.0        0.09 ± 14% 
>>> perf-profile.self.cycles-pp.__switch_to_asm
>>>        0.08 ± 12%      -0.0        0.06 ± 17% 
>>> perf-profile.self.cycles-pp.enqueue_task_fair
>>>        0.09 ± 13%      -0.0        0.07 ±  5% 
>>> perf-profile.self.cycles-pp.des3_ede_encrypt
>>>        0.07 ± 13%      +0.0        0.08 ± 19% 
>>> perf-profile.self.cycles-pp.__lru_cache_add
>>>        0.19 ±  9%      +0.0        0.22 ± 10% 
>>> perf-profile.self.cycles-pp.mem_cgroup_throttle_swaprate
>>>        0.15 ±  5%      +0.0        0.19 ± 11% 
>>> perf-profile.self.cycles-pp.apparmor_cred_prepare
>>>        0.05 ± 58%      +0.0        0.09 ± 13% 
>>> perf-profile.self.cycles-pp.mark_page_accessed
>>>        0.58 ± 10%      +0.2        0.80 ± 20% 
>>> perf-profile.self.cycles-pp.release_pages
>>>        0.75 ±173%  +1.3e+05%       1005 ±100% 
>>> interrupts.127:PCI-MSI.31981660-edge.i40e-eth0-TxRx-91
>>>      820.75 ±111%     -99.9%       0.50 ±173% 
>>> interrupts.47:PCI-MSI.31981580-edge.i40e-eth0-TxRx-11
>>>      449.25 ± 86%    -100.0%       0.00 
>>> interrupts.53:PCI-MSI.31981586-edge.i40e-eth0-TxRx-17
>>>       33.25 ±157%    -100.0%       0.00 
>>> interrupts.57:PCI-MSI.31981590-edge.i40e-eth0-TxRx-21
>>>        0.75 ±110%  +63533.3%     477.25 ±162% 
>>> interrupts.61:PCI-MSI.31981594-edge.i40e-eth0-TxRx-25
>>>      561.50 ±160%    -100.0%       0.00 
>>> interrupts.65:PCI-MSI.31981598-edge.i40e-eth0-TxRx-29
>>>       82921 ±  8%     -11.1%      73748 ±  6% 
>>> interrupts.CPU11.CAL:Function_call_interrupts
>>>       66509 ± 30%     -32.6%      44828 ±  8% 
>>> interrupts.CPU14.TLB:TLB_shootdowns
>>>       43105 ± 98%     -90.3%       4183 ± 21% 
>>> interrupts.CPU17.RES:Rescheduling_interrupts
>>>      148719 ± 70%     -69.4%      45471 ± 16% 
>>> interrupts.CPU17.TLB:TLB_shootdowns
>>>       85589 ± 42%     -52.2%      40884 ±  5% 
>>> interrupts.CPU20.TLB:TLB_shootdowns
>>>      222472 ± 41%     -98.0%       4360 ± 45% 
>>> interrupts.CPU22.RES:Rescheduling_interrupts
>>>        0.50 ±173%  +95350.0%     477.25 ±162% 
>>> interrupts.CPU25.61:PCI-MSI.31981594-edge.i40e-eth0-TxRx-25
>>>       76029 ± 10%     +14.9%      87389 ±  5% 
>>> interrupts.CPU25.CAL:Function_call_interrupts
>>>      399042 ±  6%     +13.4%     452479 ±  8% 
>>> interrupts.CPU27.LOC:Local_timer_interrupts
>>>      561.00 ±161%    -100.0%       0.00 
>>> interrupts.CPU29.65:PCI-MSI.31981598-edge.i40e-eth0-TxRx-29
>>>        7034 ± 46%   +1083.8%      83279 ±138% 
>>> interrupts.CPU29.RES:Rescheduling_interrupts
>>>       17829 ± 99%     -71.0%       5172 ± 16% 
>>> interrupts.CPU30.RES:Rescheduling_interrupts
>>>        5569 ± 15%   +2414.7%     140059 ± 94% 
>>> interrupts.CPU31.RES:Rescheduling_interrupts
>>>       37674 ± 16%     +36.6%      51473 ± 25% 
>>> interrupts.CPU31.TLB:TLB_shootdowns
>>>       47905 ± 39%     +76.6%      84583 ± 38% 
>>> interrupts.CPU34.TLB:TLB_shootdowns
>>>      568.75 ±140%    +224.8%       1847 ± 90% 
>>> interrupts.CPU36.NMI:Non-maskable_interrupts
>>>      568.75 ±140%    +224.8%       1847 ± 90% 
>>> interrupts.CPU36.PMI:Performance_monitoring_interrupts
>>>        4236 ± 25%   +2168.5%      96092 ± 90% 
>>> interrupts.CPU36.RES:Rescheduling_interrupts
>>>       52717 ± 27%     +43.3%      75565 ± 28% 
>>> interrupts.CPU37.TLB:TLB_shootdowns
>>>       41418 ±  9%    +136.6%      98010 ± 50% 
>>> interrupts.CPU39.TLB:TLB_shootdowns
>>>        5551 ±  8%    +847.8%      52615 ± 66% 
>>> interrupts.CPU40.RES:Rescheduling_interrupts
>>>        4746 ± 25%    +865.9%      45841 ± 91% 
>>> interrupts.CPU42.RES:Rescheduling_interrupts
>>>       37556 ± 11%     +24.6%      46808 ±  6% 
>>> interrupts.CPU42.TLB:TLB_shootdowns
>>>       21846 ±124%     -84.4%       3415 ± 46% 
>>> interrupts.CPU48.RES:Rescheduling_interrupts
>>>      891.50 ± 22%     -35.2%     577.25 ± 40% 
>>> interrupts.CPU49.NMI:Non-maskable_interrupts
>>>      891.50 ± 22%     -35.2%     577.25 ± 40% 
>>> interrupts.CPU49.PMI:Performance_monitoring_interrupts
>>>       20459 ±120%     -79.2%       4263 ± 14% 
>>> interrupts.CPU49.RES:Rescheduling_interrupts
>>>       59840 ± 21%     -23.1%      46042 ± 16% 
>>> interrupts.CPU5.TLB:TLB_shootdowns
>>>       65200 ± 19%     -34.5%      42678 ±  9% 
>>> interrupts.CPU51.TLB:TLB_shootdowns
>>>       70923 ±153%     -94.0%       4270 ± 29% 
>>> interrupts.CPU53.RES:Rescheduling_interrupts
>>>       65312 ± 22%     -28.7%      46578 ± 14% 
>>> interrupts.CPU56.TLB:TLB_shootdowns
>>>       65828 ± 24%   �� -33.4%      43846 ±  4% 
>>> interrupts.CPU59.TLB:TLB_shootdowns
>>>       72558 ±156%     -93.2%       4906 ±  9% 
>>> interrupts.CPU6.RES:Rescheduling_interrupts
>>>       68698 ± 34%     -32.6%      46327 ± 18% 
>>> interrupts.CPU61.TLB:TLB_shootdowns
>>>      109745 ± 44%     -57.4%      46711 ± 16% 
>>> interrupts.CPU62.TLB:TLB_shootdowns
>>>       89714 ± 44%     -48.5%      46198 ±  7% 
>>> interrupts.CPU63.TLB:TLB_shootdowns
>>>       59380 ±136%     -91.5%       5066 ± 13% 
>>> interrupts.CPU69.RES:Rescheduling_interrupts
>>>       40094 ± 18%    +133.9%      93798 ± 44% 
>>> interrupts.CPU78.TLB:TLB_shootdowns
>>>      129884 ± 72%     -55.3%      58034 ±157% 
>>> interrupts.CPU8.RES:Rescheduling_interrupts
>>>       69984 ± 11%     +51.4%     105957 ± 20% 
>>> interrupts.CPU80.CAL:Function_call_interrupts
>>>       32857 ± 10%    +128.7%      75131 ± 36% 
>>> interrupts.CPU80.TLB:TLB_shootdowns
>>>       35726 ± 16%     +34.6%      48081 ± 12% 
>>> interrupts.CPU82.TLB:TLB_shootdowns
>>>       73820 ± 17%     +28.2%      94643 ±  8% 
>>> interrupts.CPU84.CAL:Function_call_interrupts
>>>       38829 ± 28%    +190.3%     112736 ± 42% 
>>> interrupts.CPU84.TLB:TLB_shootdowns
>>>       36129 ±  4%     +47.6%      53329 ± 13% 
>>> interrupts.CPU85.TLB:TLB_shootdowns
>>>        4693 ±  7%   +1323.0%      66793 ±145% 
>>> interrupts.CPU86.RES:Rescheduling_interrupts
>>>       38003 ± 11%     +94.8%      74031 ± 43% 
>>> interrupts.CPU86.TLB:TLB_shootdowns
>>>       78022 ±  3%      +7.9%      84210 ±  3% 
>>> interrupts.CPU87.CAL:Function_call_interrupts
>>>       36359 ±  6%     +54.9%      56304 ± 48% 
>>> interrupts.CPU88.TLB:TLB_shootdowns
>>>       89031 ±105%     -95.0%       4475 ± 40% 
>>> interrupts.CPU9.RES:Rescheduling_interrupts
>>>       40085 ± 11%     +60.6%      64368 ± 27% 
>>> interrupts.CPU91.TLB:TLB_shootdowns
>>>       42244 ± 10%     +44.8%      61162 ± 35% 
>>> interrupts.CPU94.TLB:TLB_shootdowns
>>>       40959 ± 15%    +109.4%      85780 ± 41% 
>>> interrupts.CPU95.TLB:TLB_shootdowns
>>>
>>>
>>>                                  stress-ng.fiemap.ops
>>>    80000 
>>> +-------------------------------------------------------------------+
>>>    75000 |..+.             .+..            .+..+..  .+. 
>>> .+..                |
>>>          |    +..+..+..+.+.     .+..+..  .+       +.   +. 
>>> +.+..+..+..+.+..|
>>>    70000 |-+                   + +.                                    |
>>>    65000 
>>> |-+                                                                 |
>>>    60000 
>>> |-+                                                                 |
>>>    55000 
>>> |-+                                                                 |
>>> |                                                                   |
>>>    50000 
>>> |-+                                                                 |
>>>    45000 
>>> |-+                                                                 |
>>>    40000 
>>> |-+                                                                 |
>>>    35000 |-+ O                                                |
>>>          |  O       O                       O     O 
>>> O                     |
>>>    30000 |-+  O  O     O O     O O     O  O    O     O    O  O O  O 
>>> O  O O  |
>>>    25000 
>>> +-------------------------------------------------------------------+
>>>                              stress-ng.fiemap.ops_per_sec
>>>    80000 
>>> +-------------------------------------------------------------------+
>>>    75000 |..               .+.. .+..                           |
>>>          |  +.  .+..+..+.+.     .+..+..  .+.+. 
>>> +..+.+..+..+.+..+..+..+.+..|
>>>    70000 |-+  +.               + +.                                    |
>>>    65000 
>>> |-+                                                                 |
>>>    60000 
>>> |-+                                                                 |
>>>    55000 
>>> |-+                                                                 |
>>> |                                                                   |
>>>    50000 
>>> |-+                                                                 |
>>>    45000 
>>> |-+                                                                 |
>>>    40000 
>>> |-+                                                                 |
>>>    35000 |-+ O                                                |
>>>          |  O       O                       O 
>>> O                          |
>>>    30000 |-+  O  O     O O     O O     O       O     O O  O  O    O 
>>> O  O O  |
>>>    25000 
>>> +-------------------------------------------------------------------+
>>> [*] bisect-good sample
>>> [O] bisect-bad  sample
>>>
>>>
>>>
>>> Disclaimer:
>>> Results have been estimated based on internal Intel analysis and are 
>>> provided
>>> for informational purposes only. Any difference in system hardware or 
>>> software
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
> 

-- 
Zhengjun Xing
