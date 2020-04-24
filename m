Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C6DC2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39D5C20724
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgDXIPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 04:15:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:49231 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbgDXIPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 04:15:54 -0400
IronPort-SDR: 8V7c/Pl/IqyFXCi7ZB8/2RoQ85PtrkjSoa2f9VwnC6vdZzdw176l71KNGf/XT0PsnhKKY+mTQr
 FGqpvfmIE2+Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 01:15:49 -0700
IronPort-SDR: z+ATNys5syQTa0CoAWfbttRue+lM9qxtDmc9BmDRaV+/4XEEawDtkPw+ehnpi7Svla93UdhKuR
 Uui7SuWATUzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,310,1583222400"; 
   d="scan'208";a="246532598"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.255.30.164]) ([10.255.30.164])
  by fmsmga007.fm.intel.com with ESMTP; 24 Apr 2020 01:15:47 -0700
Subject: Re: [LKP] [sched/fair] 6c8116c914: stress-ng.mmapfork.ops_per_sec
 -38.0% regression
To:     kernel test robot <rong.a.chen@intel.com>,
        Tao Zhou <ouwen210@hotmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200421004749.GC26573@shao2-debian>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <74c86b02-bf93-db33-dbea-9b1934c3c9ab@linux.intel.com>
Date:   Fri, 24 Apr 2020 16:15:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421004749.GC26573@shao2-debian>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao,

    Do you have time to take a look at this? Thanks.

On 4/21/2020 8:47 AM, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a 56.4% improvement of stress-ng.fifo.ops_per_sec due to commit:
> 
> 
> commit: 6c8116c914b65be5e4d6f66d69c8142eb0648c22 ("sched/fair: Fix condition of avg_load calculation")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: stress-ng
> on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory
> with following parameters:
> 
> 	nr_threads: 100%
> 	disk: 1HDD
> 	testtime: 1s
> 	class: scheduler
> 	cpufreq_governor: performance
> 	ucode: 0xb000038
> 	sc_pid_max: 4194304
> 
> 
> In addition to that, the commit also has significant impact on the following tests:
> 
> +------------------+----------------------------------------------------------------------+
> | testcase: change | stress-ng: stress-ng.mmapfork.ops_per_sec -19.2% regression          |
> | test machine     | 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory |
> | test parameters  | class=vm                                                             |
> |                  | cpufreq_governor=performance                                         |
> |                  | disk=1HDD                                                            |
> |                  | fs=ext4                                                              |
> |                  | nr_threads=10%                                                       |
> |                  | testtime=1s                                                          |
> |                  | ucode=0x500002c                                                      |
> +------------------+----------------------------------------------------------------------+
> 
> 
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
> class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/sc_pid_max/tbox_group/testcase/testtime/ucode:
>    scheduler/gcc-7/performance/1HDD/x86_64-rhel-7.6/100%/debian-x86_64-20191114.cgz/4194304/lkp-bdw-ep6/stress-ng/1s/0xb000038
> 
> commit:
>    e94f80f6c4 ("sched/rt: cpupri_find: Trigger a full search as fallback")
>    6c8116c914 ("sched/fair: Fix condition of avg_load calculation")
> 
> e94f80f6c4902000 6c8116c914b65be5e4d6f66d69c
> ---------------- ---------------------------
>         fail:runs  %reproduction    fail:runs
>             |             |             |
>             :4           25%           1:4     dmesg.WARNING:at#for_ip_interrupt_entry/0x
>             :4           25%           1:4     dmesg.WARNING:at_ip___perf_sw_event/0x
>             :4           25%           1:4     dmesg.WARNING:at_ip__slab_free/0x
>           %stddev     %change         %stddev
>               \          |                \
>     3986602 ± 12%     +56.5%    6237290 ± 11%  stress-ng.fifo.ops
>     3982065 ± 12%     +56.4%    6228889 ± 11%  stress-ng.fifo.ops_per_sec
>       20066 ±  5%      -9.0%      18250 ±  5%  stress-ng.fork.ops
>       20043 ±  5%      -9.0%      18239 ±  6%  stress-ng.fork.ops_per_sec
>       29.08 ±  2%     -38.0%      18.01        stress-ng.mmapfork.ops_per_sec
>        2200            +3.8%       2284        stress-ng.time.system_time
>    19775571 ± 12%     +28.2%   25357609 ±  6%  numa-numastat.node1.local_node
>    19843883 ± 12%     +28.1%   25427059 ±  6%  numa-numastat.node1.numa_hit
>        4489 ± 15%     -21.5%       3523 ±  3%  sched_debug.cfs_rq:/.runnable_avg.max
>      929.25           -12.0%     818.19 ±  7%  sched_debug.cfs_rq:/.runnable_avg.stddev
>        1449 ± 26%     -25.8%       1075 ±  5%  sched_debug.cfs_rq:/.util_avg.max
>       28692            +9.2%      31327 ±  5%  softirqs.CPU44.TIMER
>       22999 ±  3%     +13.7%      26141 ±  6%  softirqs.CPU56.RCU
>       28464 ±  4%      +9.9%      31279 ±  6%  softirqs.CPU56.TIMER
>       30.25 ±  2%      -6.6%      28.25        vmstat.cpu.id
>       60.00            +4.6%      62.75        vmstat.cpu.sy
>     2526959 ±  3%     +69.1%    4273296 ±  2%  vmstat.memory.cache
>      371.25 ±  9%     +27.1%     472.00 ±  5%  vmstat.procs.r
>       30.16 ±  3%      -6.0%      28.35 ±  2%  iostat.cpu.idle
>       60.99            +3.6%      63.22        iostat.cpu.system
>        8.39 ±  2%      -4.9%       7.98        iostat.cpu.user
>        3.10 ±173%    -100.0%       0.00        iostat.sdc.await.max
>        3.10 ±173%    -100.0%       0.00        iostat.sdc.r_await.max
>        1082 ±  9%     +11.4%       1206 ±  4%  slabinfo.kmalloc-128.active_slabs
>       34667 ±  9%     +11.3%      38602 ±  4%  slabinfo.kmalloc-128.num_objs
>        1082 ±  9%     +11.4%       1206 ±  4%  slabinfo.kmalloc-128.num_slabs
>      454.50 ± 11%     +21.0%     549.75 ± 22%  slabinfo.kmalloc-192.active_slabs
>       19110 ± 10%     +20.9%      23108 ± 22%  slabinfo.kmalloc-192.num_objs
>      454.50 ± 11%     +21.0%     549.75 ± 22%  slabinfo.kmalloc-192.num_slabs
>      106621            -7.8%      98257 ±  5%  slabinfo.kmalloc-32.active_objs
>       37329 ±  3%     +20.6%      45034        slabinfo.radix_tree_node.active_objs
>      706.25 ±  3%     +24.5%     879.25        slabinfo.radix_tree_node.active_slabs
>       39573 ±  3%     +24.5%      49252        slabinfo.radix_tree_node.num_objs
>      706.25 ±  3%     +24.5%     879.25        slabinfo.radix_tree_node.num_slabs
>     1318829 ±  8%     +49.7%    1974635 ± 10%  meminfo.Active
>     1318549 ±  8%     +49.7%    1974352 ± 10%  meminfo.Active(anon)
>      723296 ± 17%     +41.1%    1020590 ± 15%  meminfo.AnonHugePages
>      905050 ± 11%     +40.9%    1274793 ± 16%  meminfo.AnonPages
>     2271966 ±  3%     +83.7%    4173221        meminfo.Cached
>    62076918 ±  3%     +12.6%   69917857 ±  5%  meminfo.Committed_AS
>      815680 ±  7%    +198.4%    2434139 ±  2%  meminfo.Inactive
>      815324 ±  7%    +198.5%    2433786 ±  2%  meminfo.Inactive(anon)
>      840619 ±  7%    +192.4%    2457795 ±  2%  meminfo.Mapped
>     4535703 ±  4%     +51.0%    6849231 ±  3%  meminfo.Memused
>       66386 ±  5%     +20.2%      79763 ±  4%  meminfo.PageTables
>     1210719 ±  5%    +157.1%    3112278 ±  2%  meminfo.Shmem
>      509312 ±  6%     +75.4%     893498        meminfo.max_used_kB
>      323591 ±  5%     +48.3%     479732 ± 10%  proc-vmstat.nr_active_anon
>      225088 ±  9%     +40.2%     315590 ± 14%  proc-vmstat.nr_anon_pages
>      362.50 ± 16%     +35.7%     492.00 ± 14%  proc-vmstat.nr_anon_transparent_hugepages
>     3164981            -1.8%    3108432        proc-vmstat.nr_dirty_background_threshold
>     6337701            -1.8%    6224466        proc-vmstat.nr_dirty_threshold
>      562051 ±  3%     +82.2%    1023916 ±  2%  proc-vmstat.nr_file_pages
>    31851080            -1.8%   31284538        proc-vmstat.nr_free_pages
>      201936 ±  8%    +196.7%     599169 ±  3%  proc-vmstat.nr_inactive_anon
>      208366 ±  8%    +190.5%     605371 ±  3%  proc-vmstat.nr_mapped
>       16350 ±  3%     +24.7%      20391 ±  7%  proc-vmstat.nr_page_table_pages
>      296735 ±  6%    +155.7%     758662 ±  3%  proc-vmstat.nr_shmem
>      323592 ±  5%     +48.3%     479731 ± 10%  proc-vmstat.nr_zone_active_anon
>      201936 ±  8%    +196.7%     599168 ±  3%  proc-vmstat.nr_zone_inactive_anon
>    14509555 ±  2%      +6.5%   15449984        proc-vmstat.pgactivate
>      565861 ± 54%     -93.7%      35832 ± 28%  numa-meminfo.node0.Inactive
>      565602 ± 54%     -93.7%      35573 ± 28%  numa-meminfo.node0.Inactive(anon)
>      583972 ± 52%     -91.4%      50225 ± 20%  numa-meminfo.node0.Mapped
>      627138 ± 20%    +131.7%    1453311 ±  9%  numa-meminfo.node1.Active
>      627070 ± 20%    +131.8%    1453285 ±  9%  numa-meminfo.node1.Active(anon)
>      327555 ± 17%    +109.1%     684899 ±  9%  numa-meminfo.node1.AnonHugePages
>      460420 ± 11%     +76.5%     812769 ± 16%  numa-meminfo.node1.AnonPages
>      968393 ± 45%    +265.8%    3542629 ±  3%  numa-meminfo.node1.FilePages
>      270293 ±115%    +784.7%    2391349 ±  3%  numa-meminfo.node1.Inactive
>      270196 ±116%    +785.0%    2391255 ±  3%  numa-meminfo.node1.Inactive(anon)
>       94282 ±  6%     +14.1%     107588 ±  4%  numa-meminfo.node1.KReclaimable
>      277310 ±113%    +765.8%    2401026 ±  2%  numa-meminfo.node1.Mapped
>     2101472 ± 20%    +143.0%    5106156 ±  3%  numa-meminfo.node1.MemUsed
>       30839 ± 14%     +75.9%      54240 ±  5%  numa-meminfo.node1.PageTables
>       94282 ±  6%     +14.1%     107588 ±  4%  numa-meminfo.node1.SReclaimable
>      428801 ±102%    +603.2%    3015356 ±  3%  numa-meminfo.node1.Shmem
>      319011 ± 32%     -53.5%     148357 ±  3%  numa-vmstat.node0.nr_file_pages
>      136650 ± 54%     -90.3%      13199 ± 47%  numa-vmstat.node0.nr_inactive_anon
>      141251 ± 52%     -88.0%      16942 ± 37%  numa-vmstat.node0.nr_mapped
>        9345 ± 15%     -29.0%       6638 ±  9%  numa-vmstat.node0.nr_page_table_pages
>      188582 ± 54%     -92.1%      14926 ± 42%  numa-vmstat.node0.nr_shmem
>      136645 ± 54%     -90.3%      13189 ± 47%  numa-vmstat.node0.nr_zone_inactive_anon
>    11178939 ±  9%     -17.1%    9271727 ±  7%  numa-vmstat.node0.numa_hit
>    10982245 ±  9%     -17.1%    9101421 ±  7%  numa-vmstat.node0.numa_local
>      158792 ± 23%    +130.0%     365220 ± 12%  numa-vmstat.node1.nr_active_anon
>      114790 ± 11%     +76.4%     202539 ± 17%  numa-vmstat.node1.nr_anon_pages
>      160.50 ± 19%    +107.3%     332.75 ±  9%  numa-vmstat.node1.nr_anon_transparent_hugepages
>      244507 ± 46%    +262.7%     886783 ±  2%  numa-vmstat.node1.nr_file_pages
>       68248 ±122%    +773.8%     596360        numa-vmstat.node1.nr_inactive_anon
>       70043 ±119%    +755.1%     598917        numa-vmstat.node1.nr_mapped
>        8117 ± 22%     +66.1%      13481 ±  3%  numa-vmstat.node1.nr_page_table_pages
>      109596 ±104%    +588.9%     754961 ±  3%  numa-vmstat.node1.nr_shmem
>       23655 ±  7%     +13.4%      26828 ±  4%  numa-vmstat.node1.nr_slab_reclaimable
>      158794 ± 23%    +130.0%     365223 ± 12%  numa-vmstat.node1.nr_zone_active_anon
>       68248 ±122%    +773.8%     596359        numa-vmstat.node1.nr_zone_inactive_anon
>    10597757 ±  6%     +31.0%   13877833 ±  2%  numa-vmstat.node1.numa_hit
>    10518704 ±  6%     +30.8%   13763501 ±  3%  numa-vmstat.node1.numa_local
>      130.75 ± 26%     -78.4%      28.25 ± 11%  interrupts.36:IR-PCI-MSI.1572867-edge.eth0-TxRx-2
>      454956 ± 13%     -45.1%     249594 ± 38%  interrupts.CPU14.LOC:Local_timer_interrupts
>       17625 ± 28%     +80.2%      31751 ± 37%  interrupts.CPU14.RES:Rescheduling_interrupts
>      130.75 ± 26%     -78.4%      28.25 ± 11%  interrupts.CPU15.36:IR-PCI-MSI.1572867-edge.eth0-TxRx-2
>      263948 ± 23%     -25.7%     196017 ±  2%  interrupts.CPU15.LOC:Local_timer_interrupts
>      425840 ± 19%     -53.7%     197051 ±  4%  interrupts.CPU17.LOC:Local_timer_interrupts
>       44187 ± 27%     -53.8%      20406 ± 39%  interrupts.CPU18.RES:Rescheduling_interrupts
>        2400 ±149%     -91.2%     211.50 ±143%  interrupts.CPU2.IWI:IRQ_work_interrupts
>      432176 ± 16%     -51.2%     211015 ±  9%  interrupts.CPU2.LOC:Local_timer_interrupts
>      444388 ± 20%     -44.4%     246924 ± 34%  interrupts.CPU20.LOC:Local_timer_interrupts
>        1763 ± 11%     +31.8%       2324 ± 13%  interrupts.CPU25.TLB:TLB_shootdowns
>      428063 ±  7%     -33.9%     282779 ± 33%  interrupts.CPU27.LOC:Local_timer_interrupts
>       19879 ± 66%     +94.7%      38706 ± 47%  interrupts.CPU29.RES:Rescheduling_interrupts
>        1459 ± 17%     +62.3%       2369 ± 22%  interrupts.CPU32.TLB:TLB_shootdowns
>        1593 ± 17%     +35.2%       2154 ± 15%  interrupts.CPU33.TLB:TLB_shootdowns
>        1388 ± 21%     +57.5%       2185 ± 19%  interrupts.CPU34.TLB:TLB_shootdowns
>       44877 ± 50%     -52.3%      21390 ± 19%  interrupts.CPU36.RES:Rescheduling_interrupts
>        6002 ± 35%     -34.7%       3920 ±  8%  interrupts.CPU37.CAL:Function_call_interrupts
>      519.00 ±159%     -95.2%      24.75 ± 51%  interrupts.CPU4.IWI:IRQ_work_interrupts
>      371753 ± 25%     -46.6%     198407 ±  6%  interrupts.CPU4.LOC:Local_timer_interrupts
>        1490 ± 19%     +42.9%       2130 ±  7%  interrupts.CPU41.TLB:TLB_shootdowns
>        6738 ± 41%     -34.0%       4449 ± 19%  interrupts.CPU45.CAL:Function_call_interrupts
>        1145 ±124%     -82.6%     199.25 ±153%  interrupts.CPU46.IWI:IRQ_work_interrupts
>      275.75 ±141%     -94.2%      16.00 ± 84%  interrupts.CPU48.IWI:IRQ_work_interrupts
>      310.00 ±134%     -93.1%      21.25 ±103%  interrupts.CPU49.IWI:IRQ_work_interrupts
>      463385 ±  3%     -57.3%     197853 ±  6%  interrupts.CPU49.LOC:Local_timer_interrupts
>        7206 ± 33%     -36.7%       4558 ± 10%  interrupts.CPU5.CAL:Function_call_interrupts
>      264579 ± 13%     -24.5%     199834 ±  2%  interrupts.CPU5.LOC:Local_timer_interrupts
>        5463 ± 14%     -26.3%       4025 ± 11%  interrupts.CPU50.CAL:Function_call_interrupts
>        7063 ± 31%     -41.3%       4147 ± 13%  interrupts.CPU54.CAL:Function_call_interrupts
>      287711 ± 25%     -31.7%     196499 ±  6%  interrupts.CPU55.LOC:Local_timer_interrupts
>      415854 ±  8%     -41.4%     243719 ± 33%  interrupts.CPU57.LOC:Local_timer_interrupts
>      324710 ± 32%     -38.3%     200427 ± 11%  interrupts.CPU6.LOC:Local_timer_interrupts
>      343106 ± 32%     -27.0%     250512 ± 35%  interrupts.CPU61.LOC:Local_timer_interrupts
>      395834 ± 19%     -49.0%     201844 ± 17%  interrupts.CPU63.LOC:Local_timer_interrupts
>      483611 ± 24%     -48.4%     249593 ± 31%  interrupts.CPU64.LOC:Local_timer_interrupts
>        1885 ± 13%     +37.5%       2591 ± 23%  interrupts.CPU69.TLB:TLB_shootdowns
>      382720 ± 33%     -38.5%     235483 ± 34%  interrupts.CPU7.LOC:Local_timer_interrupts
>        1437 ± 11%     +37.1%       1970 ± 16%  interrupts.CPU70.TLB:TLB_shootdowns
>        3844 ± 34%     +64.2%       6312 ±  2%  interrupts.CPU71.NMI:Non-maskable_interrupts
>        3844 ± 34%     +64.2%       6312 ±  2%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
>       54451 ± 37%     -65.6%      18725 ± 51%  interrupts.CPU71.RES:Rescheduling_interrupts
>        1710 ±  6%     +27.2%       2176 ± 10%  interrupts.CPU72.TLB:TLB_shootdowns
>      350141 ± 20%     -32.6%     236073 ± 29%  interrupts.CPU74.LOC:Local_timer_interrupts
>        1172 ± 18%     +80.1%       2112 ± 10%  interrupts.CPU76.TLB:TLB_shootdowns
>       59169 ± 36%     -56.0%      26026 ± 56%  interrupts.CPU84.RES:Rescheduling_interrupts
>      409027 ± 39%     -41.4%     239528 ± 25%  interrupts.CPU86.LOC:Local_timer_interrupts
>        1543 ± 14%     +24.6%       1922 ±  9%  interrupts.CPU86.TLB:TLB_shootdowns
>        8.71 ±  7%      -3.8        4.92 ± 23%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write.ksys_write
>        8.66 ±  7%      -3.8        4.89 ± 23%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write
>        8.61 ±  7%      -3.8        4.84 ± 23%  perf-profile.calltrace.cycles-pp.pollwake.__wake_up_common.__wake_up_common_lock.pipe_write.new_sync_write
>        8.60 ±  7%      -3.8        4.83 ± 23%  perf-profile.calltrace.cycles-pp.try_to_wake_up.pollwake.__wake_up_common.__wake_up_common_lock.pipe_write
>       10.58 ±  4%      -3.7        6.87 ± 17%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__account_scheduler_latency.enqueue_entity.enqueue_task_fair.activate_task
>       10.46 ±  5%      -3.7        6.77 ± 17%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__account_scheduler_latency.enqueue_entity.enqueue_task_fair
>       11.46 ±  4%      -3.6        7.81 ± 14%  perf-profile.calltrace.cycles-pp.__account_scheduler_latency.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
>       11.71 ±  4%      -3.6        8.07 ± 13%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up
>        8.92 ±  7%      -3.6        5.31 ± 22%  perf-profile.calltrace.cycles-pp.pipe_write.new_sync_write.vfs_write.ksys_write.do_syscall_64
>        9.02 ±  7%      -3.6        5.42 ± 22%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        7.95 ±  6%      -3.6        4.36 ± 23%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.try_to_wake_up.pollwake.__wake_up_common
>        7.95 ±  6%      -3.6        4.36 ± 23%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.pollwake.__wake_up_common.__wake_up_common_lock
>        7.94 ±  6%      -3.6        4.36 ± 23%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up.pollwake
>       14.89 ±  4%      -3.6       11.31 ± 10%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_write
>       14.94 ±  4%      -3.6       11.37 ± 10%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_write
>       15.40 ±  3%      -3.4       12.01 ± 10%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_write
>       15.42 ±  3%      -3.4       12.04 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__GI___libc_write
>       15.70 ±  3%      -3.3       12.39 ± 10%  perf-profile.calltrace.cycles-pp.__GI___libc_write
>        4.89 ± 13%      -2.0        2.94 ± 25%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.fsnotify_add_event.fanotify_handle_event.fsnotify
>        1.67 ± 23%      -0.6        1.11 ± 10%  perf-profile.calltrace.cycles-pp._raw_spin_lock.fsnotify_add_event.fanotify_handle_event.fsnotify.do_sys_openat2
>        1.98 ±  8%      -0.5        1.50 ± 10%  perf-profile.calltrace.cycles-pp._raw_spin_lock.fsnotify_add_event.fanotify_handle_event.fsnotify.__fput
>        2.54 ±  3%      -0.4        2.14 ±  7%  perf-profile.calltrace.cycles-pp.fsnotify_add_event.fanotify_handle_event.fsnotify.__fput.task_work_run
>        0.66 ±  9%      -0.4        0.27 ±100%  perf-profile.calltrace.cycles-pp._raw_spin_lock.fsnotify_add_event.fanotify_handle_event.fsnotify.vfs_read
>        2.84            -0.3        2.55 ±  6%  perf-profile.calltrace.cycles-pp.fsnotify_add_event.fanotify_handle_event.fsnotify.do_sys_openat2.do_sys_open
>        2.83 ±  2%      -0.3        2.56 ±  4%  perf-profile.calltrace.cycles-pp.fanotify_handle_event.fsnotify.__fput.task_work_run.exit_to_usermode_loop
>        0.69 ±  5%      -0.3        0.43 ± 58%  perf-profile.calltrace.cycles-pp._raw_spin_lock.fsnotify_add_event.fanotify_handle_event.fsnotify.vfs_write
>        2.91 ±  2%      -0.3        2.65 ±  4%  perf-profile.calltrace.cycles-pp.fsnotify.__fput.task_work_run.exit_to_usermode_loop.do_syscall_64
>        7.23            -0.2        6.99        perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        3.10            -0.2        2.90 ±  4%  perf-profile.calltrace.cycles-pp.fanotify_handle_event.fsnotify.do_sys_openat2.do_sys_open.do_syscall_64
>        0.94 ±  8%      -0.1        0.80 ±  3%  perf-profile.calltrace.cycles-pp.pagevec_lru_move_fn.lru_add_drain_cpu.lru_add_drain.unmap_region.__do_munmap
>        0.95 ±  8%      -0.1        0.82 ±  3%  perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.lru_add_drain.unmap_region.__do_munmap.__vm_munmap
>        0.77 ± 10%      -0.1        0.64 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.pagevec_lru_move_fn.lru_add_drain_cpu.lru_add_drain
>        0.79 ± 10%      -0.1        0.66 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.pagevec_lru_move_fn.lru_add_drain_cpu.lru_add_drain.unmap_region
>        0.95 ±  8%      -0.1        0.82 ±  3%  perf-profile.calltrace.cycles-pp.lru_add_drain.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap
>        0.87 ±  3%      -0.1        0.75 ±  6%  perf-profile.calltrace.cycles-pp.fsnotify_add_event.fanotify_handle_event.fsnotify.vfs_read.ksys_read
>        0.85 ±  3%      -0.1        0.74 ±  8%  perf-profile.calltrace.cycles-pp.fsnotify_add_event.fanotify_handle_event.fsnotify.vfs_write.ksys_write
>        1.25 ±  6%      -0.1        1.14 ±  2%  perf-profile.calltrace.cycles-pp.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
>        4.21            -0.1        4.10        perf-profile.calltrace.cycles-pp.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_close
>        4.27            -0.1        4.16        perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_close
>        1.35 ±  5%      -0.1        1.25 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.munmap
>        1.33 ±  5%      -0.1        1.23 ±  2%  perf-profile.calltrace.cycles-pp.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        1.34 ±  5%      -0.1        1.24 ±  2%  perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.munmap
>        1.85            -0.1        1.75 ±  4%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
>        0.97 ±  2%      -0.1        0.89 ±  4%  perf-profile.calltrace.cycles-pp.fanotify_handle_event.fsnotify.vfs_read.ksys_read.do_syscall_64
>        1.02 ±  2%      -0.1        0.96 ±  4%  perf-profile.calltrace.cycles-pp.fsnotify.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.86 ±  8%      +0.1        0.96 ±  5%  perf-profile.calltrace.cycles-pp.copy_page_range.dup_mm.copy_process._do_fork.__x64_sys_clone
>        0.85 ±  7%      +0.1        0.95 ±  4%  perf-profile.calltrace.cycles-pp.copy_p4d_range.copy_page_range.dup_mm.copy_process._do_fork
>        0.66 ±  5%      +0.1        0.79 ± 12%  perf-profile.calltrace.cycles-pp.apparmor_file_alloc_security.security_file_alloc.__alloc_file.alloc_empty_file.dentry_open
>        0.69 ±  4%      +0.1        0.82 ± 11%  perf-profile.calltrace.cycles-pp.security_file_alloc.__alloc_file.alloc_empty_file.dentry_open.fanotify_read
>        0.67 ±  4%      +0.1        0.81 ± 13%  perf-profile.calltrace.cycles-pp.apparmor_file_free_security.security_file_free.__fput.task_work_run.exit_to_usermode_loop
>        0.68 ±  5%      +0.1        0.82 ± 12%  perf-profile.calltrace.cycles-pp.security_file_free.__fput.task_work_run.exit_to_usermode_loop.do_syscall_64
>        0.30 ±100%      +0.4        0.67 ±  5%  perf-profile.calltrace.cycles-pp.fanotify_merge.fsnotify_add_event.fanotify_handle_event.fsnotify.do_sys_openat2
>        5.06 ±  3%      +0.5        5.55 ±  2%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_read
>        5.11 ±  3%      +0.5        5.60 ±  2%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_read
>        5.53 ±  3%      +0.7        6.22 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_read
>        5.55 ±  3%      +0.7        6.24 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__GI___libc_read
>        5.87 ±  3%      +0.8        6.66 ±  3%  perf-profile.calltrace.cycles-pp.__GI___libc_read
>        2.06            +2.0        4.05 ± 71%  perf-profile.calltrace.cycles-pp.page_fault
>        2.00            +2.0        3.99 ± 72%  perf-profile.calltrace.cycles-pp.do_page_fault.page_fault
>        1.72            +2.0        3.73 ± 78%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_page_fault.page_fault
>        1.77            +2.0        3.78 ± 77%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_page_fault.page_fault
>       30.85 ±  2%      -5.8       25.06 ±  4%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>       16.38 ±  4%      -4.0       12.35 ± 10%  perf-profile.children.cycles-pp.try_to_wake_up
>       14.81 ±  3%      -3.9       10.96 ± 11%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>        9.39 ±  6%      -3.8        5.57 ± 20%  perf-profile.children.cycles-pp.__wake_up_common_lock
>        8.72 ±  7%      -3.8        4.90 ± 23%  perf-profile.children.cycles-pp.pollwake
>       13.03 ±  4%      -3.8        9.24 ± 12%  perf-profile.children.cycles-pp.enqueue_task_fair
>       13.03 ±  4%      -3.8        9.26 ± 12%  perf-profile.children.cycles-pp.ttwu_do_activate
>       13.05 ±  4%      -3.8        9.28 ± 12%  perf-profile.children.cycles-pp.activate_task
>       12.34 ±  4%      -3.8        8.58 ± 13%  perf-profile.children.cycles-pp.__account_scheduler_latency
>       12.75 ±  4%      -3.7        9.00 ± 12%  perf-profile.children.cycles-pp.enqueue_entity
>       13.76 ±  4%      -3.7       10.04 ± 11%  perf-profile.children.cycles-pp.__wake_up_common
>        8.93 ±  7%      -3.6        5.31 ± 22%  perf-profile.children.cycles-pp.pipe_write
>        9.30 ±  6%      -3.6        5.72 ± 20%  perf-profile.children.cycles-pp.new_sync_write
>       15.09 ±  3%      -3.5       11.57 ± 10%  perf-profile.children.cycles-pp.ksys_write
>       15.26 ±  3%      -3.5       11.75 ±  9%  perf-profile.children.cycles-pp.vfs_write
>       15.80 ±  3%      -3.3       12.55 ± 10%  perf-profile.children.cycles-pp.__GI___libc_write
>       77.73            -3.0       74.69 ±  4%  perf-profile.children.cycles-pp.do_syscall_64
>       77.85            -3.0       74.83 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>       17.37 ±  4%      -1.7       15.68 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
>        6.95 ±  5%      -1.2        5.79 ± 26%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
>        6.87 ±  5%      -1.2        5.71 ± 26%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
>        7.29 ±  2%      -1.0        6.33 ±  6%  perf-profile.children.cycles-pp.fsnotify_add_event
>        8.05            -0.6        7.42 ±  4%  perf-profile.children.cycles-pp.fanotify_handle_event
>        8.41            -0.6        7.84 ±  4%  perf-profile.children.cycles-pp.fsnotify
>        7.33            -0.3        7.08        perf-profile.children.cycles-pp.__fput
>        7.76            -0.2        7.51        perf-profile.children.cycles-pp.exit_to_usermode_loop
>        1.01 ±  7%      -0.1        0.88 ±  3%  perf-profile.children.cycles-pp.lru_add_drain
>        0.96 ±  7%      -0.1        0.83 ±  5%  perf-profile.children.cycles-pp.__pagevec_release
>        1.03 ±  7%      -0.1        0.91 ±  3%  perf-profile.children.cycles-pp.lru_add_drain_cpu
>        1.02 ±  7%      -0.1        0.90 ±  2%  perf-profile.children.cycles-pp.pagevec_lru_move_fn
>        1.46 ±  6%      -0.1        1.35 ±  2%  perf-profile.children.cycles-pp.unmap_region
>        1.87            -0.1        1.78 ±  4%  perf-profile.children.cycles-pp.schedule_idle
>        1.49 ±  5%      -0.1        1.40        perf-profile.children.cycles-pp.__x64_sys_munmap
>        0.58 ± 11%      -0.1        0.52 ± 12%  perf-profile.children.cycles-pp.load_balance
>        0.60 ±  5%      -0.1        0.54 ±  3%  perf-profile.children.cycles-pp.truncate_inode_pages_range
>        0.11 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.seq_show
>        0.11 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.seq_printf
>        0.11            -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.seq_vprintf
>        0.09 ±  4%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__check_object_size
>        0.09 ±  4%      +0.0        0.11 ± 11%  perf-profile.children.cycles-pp.current_time
>        0.25 ±  2%      +0.0        0.27 ±  2%  perf-profile.children.cycles-pp.update_process_times
>        0.29 ±  4%      +0.0        0.31 ±  2%  perf-profile.children.cycles-pp.generic_file_write_iter
>        0.31 ±  3%      +0.0        0.33        perf-profile.children.cycles-pp.new_inode_pseudo
>        0.18 ±  5%      +0.0        0.21 ±  6%  perf-profile.children.cycles-pp.__might_sleep
>        0.34 ±  4%      +0.0        0.38 ±  6%  perf-profile.children.cycles-pp.do_wp_page
>        0.01 ±173%      +0.0        0.06 ± 16%  perf-profile.children.cycles-pp.icmp_sk_exit
>        0.30 ±  4%      +0.0        0.35 ±  9%  perf-profile.children.cycles-pp.wp_page_copy
>        0.22 ±  3%      +0.0        0.27 ±  2%  perf-profile.children.cycles-pp.fput_many
>        0.60 ±  5%      +0.1        0.66 ±  2%  perf-profile.children.cycles-pp.rcu_core
>        0.23 ±  4%      +0.1        0.28 ±  9%  perf-profile.children.cycles-pp.__pte_alloc
>        0.45 ±  6%      +0.1        0.51 ±  3%  perf-profile.children.cycles-pp.pte_alloc_one
>        0.23 ± 12%      +0.1        0.29 ± 16%  perf-profile.children.cycles-pp.cleanup_net
>        0.42 ±  6%      +0.1        0.48 ±  8%  perf-profile.children.cycles-pp.prep_new_page
>        0.39 ±  6%      +0.1        0.45 ±  2%  perf-profile.children.cycles-pp.memset_erms
>        0.76 ±  2%      +0.1        0.83 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc
>        0.23 ± 19%      +0.1        0.31        perf-profile.children.cycles-pp.path_put
>        0.73 ±  3%      +0.1        0.81 ±  3%  perf-profile.children.cycles-pp.__softirqentry_text_start
>        0.22 ± 13%      +0.1        0.32 ± 14%  perf-profile.children.cycles-pp.put_pid
>        0.47 ±  8%      +0.1        0.57 ±  3%  perf-profile.children.cycles-pp.___might_sleep
>        0.68 ±  4%      +0.1        0.79 ±  6%  perf-profile.children.cycles-pp.get_page_from_freelist
>        0.76 ±  4%      +0.1        0.87 ±  5%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
>        0.35 ±  4%      +0.1        0.48 ± 11%  perf-profile.children.cycles-pp.fanotify_alloc_event
>        0.79 ±  4%      +0.1        0.92 ±  9%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
>        0.86 ±  3%      +0.1        0.99 ±  9%  perf-profile.children.cycles-pp.security_file_alloc
>        1.30 ±  3%      +0.1        1.45 ±  7%  perf-profile.children.cycles-pp.__alloc_file
>        0.85 ±  6%      +0.1        1.00 ±  6%  perf-profile.children.cycles-pp.syscall_return_via_sysret
>        0.73 ±  4%      +0.1        0.88 ± 12%  perf-profile.children.cycles-pp.security_file_free
>        0.72 ±  4%      +0.2        0.87 ± 12%  perf-profile.children.cycles-pp.apparmor_file_free_security
>        1.32 ±  3%      +0.2        1.47 ±  7%  perf-profile.children.cycles-pp.alloc_empty_file
>        1.29 ±  5%      +0.2        1.45 ±  3%  perf-profile.children.cycles-pp.copy_page_range
>        1.26 ±  4%      +0.2        1.41 ±  3%  perf-profile.children.cycles-pp.copy_p4d_range
>        0.46 ± 17%      +0.2        0.64 ±  7%  perf-profile.children.cycles-pp.fanotify_free_event
>        1.45 ± 24%      +0.4        1.90 ±  2%  perf-profile.children.cycles-pp.fanotify_merge
>        5.23 ±  2%      +0.5        5.70 ±  2%  perf-profile.children.cycles-pp.vfs_read
>        5.24 ±  2%      +0.5        5.72 ±  2%  perf-profile.children.cycles-pp.ksys_read
>        5.90 ±  3%      +0.8        6.69 ±  3%  perf-profile.children.cycles-pp.__GI___libc_read
>        2.83 ±  2%      +2.0        4.79 ± 59%  perf-profile.children.cycles-pp.page_fault
>        2.69 ±  2%      +2.0        4.66 ± 61%  perf-profile.children.cycles-pp.do_page_fault
>       30.71            -5.8       24.94 ±  4%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
>        0.09            +0.0        0.11 ± 12%  perf-profile.self.cycles-pp.vma_interval_tree_remove
>        0.10            +0.0        0.12 ± 13%  perf-profile.self.cycles-pp.__rb_insert_augmented
>        0.13 ±  5%      +0.0        0.15 ±  7%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
>        0.15 ±  4%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.fput_many
>        0.28            +0.0        0.32 ±  3%  perf-profile.self.cycles-pp.kmem_cache_alloc
>        0.14 ±  9%      +0.0        0.19 ±  5%  perf-profile.self.cycles-pp.fanotify_alloc_event
>        0.19 ±  3%      +0.0        0.24 ± 21%  perf-profile.self.cycles-pp.anon_vma_clone
>        0.31 ± 10%      +0.1        0.37 ±  4%  perf-profile.self.cycles-pp.fsnotify
>        0.38 ±  7%      +0.1        0.43        perf-profile.self.cycles-pp.memset_erms
>        0.21 ± 13%      +0.1        0.30 ± 14%  perf-profile.self.cycles-pp.put_pid
>        0.68 ±  5%      +0.1        0.78 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>        0.45 ±  8%      +0.1        0.55 ±  3%  perf-profile.self.cycles-pp.___might_sleep
>        0.77 ±  4%      +0.1        0.89 ± 10%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
>        0.99 ±  4%      +0.1        1.12 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
>        0.85 ±  6%      +0.1        1.00 ±  6%  perf-profile.self.cycles-pp.syscall_return_via_sysret
>        0.71 ±  4%      +0.1        0.86 ± 11%  perf-profile.self.cycles-pp.apparmor_file_free_security
>        1.44 ± 23%      +0.4        1.88 ±  2%  perf-profile.self.cycles-pp.fanotify_merge
> 
> 
>                                                                                  
>                           stress-ng.mmapfork.ops_per_sec
>                                                                                  
>    36 +----------------------------------------------------------------------+
>    34 |-+      +                                                             |
>       |       + :             +..           +     +                          |
>    32 |..+.. +  :            +             : :   : :    +..+..               |
>    30 |-+   +    :          +    +..  .+.. :  :  :  :  +              .+..   |
>       |          :  .+..  .+        +.    +   : :   : +       +..+..+.    +..|
>    28 |-+         +.    +.                     +     +                       |
>    26 |-+                                                                    |
>    24 |-+                                                                    |
>       |                                                                      |
>    22 |-+                                                                    |
>    20 |-+               O                                                    |
>       |  O  O  O  O  O                    O O  O  O  O     O     O           |
>    18 |-+                  O  O  O  O  O                O     O              |
>    16 +----------------------------------------------------------------------+
>                                                                                  
>                                                                                  
> [*] bisect-good sample
> [O] bisect-bad  sample
> 
> ***************************************************************************************************
> lkp-csl-2sp5: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory
> =========================================================================================
> class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/testcase/testtime/ucode:
>    vm/gcc-7/performance/1HDD/ext4/x86_64-rhel-7.6/10%/debian-x86_64-20191114.cgz/lkp-csl-2sp5/stress-ng/1s/0x500002c
> 
> commit:
>    e94f80f6c4 ("sched/rt: cpupri_find: Trigger a full search as fallback")
>    6c8116c914 ("sched/fair: Fix condition of avg_load calculation")
> 
> e94f80f6c4902000 6c8116c914b65be5e4d6f66d69c
> ---------------- ---------------------------
>         fail:runs  %reproduction    fail:runs
>             |             |             |
>             :4           50%           2:4     dmesg.WARNING:at_ip_native_sched_clock/0x
>            1:4          -25%            :4     kmsg.Memory_failure:#:recovery_action_for_clean_LRU_page:Recovered
>             :4           25%           1:4     kmsg.Memory_failure:#:recovery_action_for_high-order_kernel_page:Ignored
>            1:4          -25%            :4     kmsg.Memory_failure:#:recovery_action_for_reserved_kernel_page:Failed
>            1:4          -25%            :4     kmsg.Memory_failure:#:reserved_kernel_page_still_referenced_by#users
>            0:4           15%           1:4     perf-profile.calltrace.cycles-pp.error_entry
>            2:4           -9%           1:4     perf-profile.children.cycles-pp.error_entry
>            0:4           -2%           0:4     perf-profile.self.cycles-pp.error_entry
>           %stddev     %change         %stddev
>               \          |                \
>        1.45 ±  4%     -19.2%       1.17        stress-ng.mmapfork.ops_per_sec
>       34.69            +3.8%      36.02        stress-ng.time.elapsed_time
>       34.69            +3.8%      36.02        stress-ng.time.elapsed_time.max
>       25456 ±  3%     +61.0%      40992        stress-ng.time.involuntary_context_switches
>    48979390            -1.7%   48167776        stress-ng.time.minor_page_faults
>        2216            +8.6%       2407        stress-ng.time.percent_of_cpu_this_job_got
>      678.84           +13.8%     772.64        stress-ng.time.system_time
>       90.09 ±  2%      +5.1%      94.70        stress-ng.time.user_time
>     3736135            -8.1%    3432912 ±  4%  stress-ng.vm-splice.ops
>     3736645            -8.1%    3433013 ±  4%  stress-ng.vm-splice.ops_per_sec
>       22.94            +2.9       25.82        mpstat.cpu.all.sys%
>       64068           +20.9%      77445        slabinfo.radix_tree_node.active_objs
>        1191           +24.5%       1483        slabinfo.radix_tree_node.active_slabs
>       66763           +24.5%      83089        slabinfo.radix_tree_node.num_objs
>        1191           +24.5%       1483        slabinfo.radix_tree_node.num_slabs
>       13465 ±  5%      -7.5%      12458 ±  4%  softirqs.CPU54.RCU
>       21991 ±  9%     -12.2%      19314 ±  2%  softirqs.CPU67.TIMER
>       18381 ±  3%     +15.7%      21272 ± 11%  softirqs.CPU78.TIMER
>       19718 ±  5%      -6.2%      18501 ±  6%  softirqs.CPU85.TIMER
>       75.25            -4.3%      72.00        vmstat.cpu.id
>     7158306           +55.5%   11133290        vmstat.memory.cache
>       41.00           +21.1%      49.67        vmstat.procs.r
>      164992            -2.7%     160484        vmstat.system.cs
>        5119 ± 27%     +26.0%       6449        sched_debug.cfs_rq:/.min_vruntime.min
>       40.68 ± 43%     -44.2%      22.70 ± 56%  sched_debug.cfs_rq:/.removed.load_avg.avg
>      193.17 ± 22%     -25.4%     144.08 ± 27%  sched_debug.cfs_rq:/.removed.load_avg.stddev
>       40.68 ± 43%     -44.2%      22.70 ± 56%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
>      193.17 ± 22%     -25.4%     144.08 ± 27%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
>       75.65            -3.8%      72.79        iostat.cpu.idle
>       21.71           +12.9%      24.51        iostat.cpu.system
>        3.38 ±173%    -100.0%       0.00        iostat.sdb.avgqu-sz.max
>       55.24 ±173%    -100.0%       0.00        iostat.sdb.await.max
>        7.86 ±173%    -100.0%       0.00        iostat.sdb.r_await.max
>        0.50 ±173%    -100.0%       0.00        iostat.sdb.svctm.max
>       73.58 ±173%    -100.0%       0.00        iostat.sdb.w_await.max
>     3441402           +37.0%    4713857 ±  2%  meminfo.Active
>     3435631           +37.0%    4708095 ±  2%  meminfo.Active(anon)
>     7080694 ±  2%     +57.1%   11123426        meminfo.Cached
>    15441325           +16.2%   17935592        meminfo.Committed_AS
>     4095008 ±  2%     +64.3%    6730005        meminfo.Inactive
>     4091903 ±  2%     +64.4%    6726722        meminfo.Inactive(anon)
>     3878376 ±  2%     +68.4%    6532231        meminfo.Mapped
>     9729489           +40.4%   13657740        meminfo.Memused
>       24152 ±  2%     +27.3%      30748        meminfo.PageTables
>     5975926 ±  2%     +67.6%   10018605        meminfo.Shmem
>     1449016           +34.8%    1953751        meminfo.max_used_kB
>      858313           +36.8%    1173864 ±  2%  proc-vmstat.nr_active_anon
>      406781            -8.2%     373619 ±  2%  proc-vmstat.nr_anon_pages
>     4645359            -2.1%    4548445        proc-vmstat.nr_dirty_background_threshold
>     9302077            -2.1%    9108013        proc-vmstat.nr_dirty_threshold
>     1771956           +56.2%    2768047        proc-vmstat.nr_file_pages
>    46738540            -2.1%   45771374        proc-vmstat.nr_free_pages
>     1030382 ±  2%     +62.8%    1677583        proc-vmstat.nr_inactive_anon
>      975596 ±  2%     +67.0%    1628805        proc-vmstat.nr_mapped
>       15306 ±  2%      -4.8%      14573 ±  4%  proc-vmstat.nr_mlock
>        6053           +26.9%       7682        proc-vmstat.nr_page_table_pages
>     1495457 ±  2%     +66.6%    2491556        proc-vmstat.nr_shmem
>       28335            +7.4%      30444        proc-vmstat.nr_slab_reclaimable
>      858313           +36.8%    1173863 ±  2%  proc-vmstat.nr_zone_active_anon
>     1030382 ±  2%     +62.8%    1677583        proc-vmstat.nr_zone_inactive_anon
>       44230 ±  7%     +38.1%      61075 ±  6%  proc-vmstat.numa_pages_migrated
>       44230 ±  7%     +38.1%      61075 ±  6%  proc-vmstat.pgmigrate_success
>       21392 ±  7%     +17.8%      25205 ±  3%  interrupts.CPU1.CAL:Function_call_interrupts
>       29824 ±  8%     +60.3%      47813 ± 16%  interrupts.CPU1.TLB:TLB_shootdowns
>       93.75 ± 22%    +298.6%     373.67 ± 34%  interrupts.CPU10.RES:Rescheduling_interrupts
>       28425 ±  9%     +35.6%      38542 ± 10%  interrupts.CPU10.TLB:TLB_shootdowns
>       28648 ±  9%     +21.9%      34913 ±  9%  interrupts.CPU11.TLB:TLB_shootdowns
>       20812 ± 10%     +15.8%      24090 ±  3%  interrupts.CPU12.CAL:Function_call_interrupts
>       28668 ± 11%     +35.8%      38941 ± 13%  interrupts.CPU12.TLB:TLB_shootdowns
>       97.50 ± 18%    +205.3%     297.67 ± 43%  interrupts.CPU14.RES:Rescheduling_interrupts
>      152.00 ± 77%    +627.0%       1105 ± 81%  interrupts.CPU15.RES:Rescheduling_interrupts
>       30393 ± 12%     +43.5%      43611 ± 19%  interrupts.CPU15.TLB:TLB_shootdowns
>       20253 ±  5%     +18.7%      24046 ±  4%  interrupts.CPU18.CAL:Function_call_interrupts
>       19382 ± 14%     +26.8%      24576 ±  8%  interrupts.CPU19.CAL:Function_call_interrupts
>       26649 ± 12%     +57.4%      41941 ± 18%  interrupts.CPU19.TLB:TLB_shootdowns
>       30299 ±  9%     +38.1%      41829 ± 20%  interrupts.CPU22.TLB:TLB_shootdowns
>       43754 ± 18%     -37.5%      27337 ±  2%  interrupts.CPU25.TLB:TLB_shootdowns
>       40282 ± 31%     -27.2%      29321 ± 18%  interrupts.CPU26.TLB:TLB_shootdowns
>      524.75 ± 52%     -62.3%     198.00 ± 57%  interrupts.CPU27.RES:Rescheduling_interrupts
>      381.25 ± 53%     -45.1%     209.33 ±102%  interrupts.CPU30.RES:Rescheduling_interrupts
>      224.00 ± 84%     -54.9%     101.00 ± 54%  interrupts.CPU35.RES:Rescheduling_interrupts
>       39260 ± 29%     -33.2%      26214 ± 25%  interrupts.CPU36.TLB:TLB_shootdowns
>       20901 ± 11%     +13.9%      23801 ±  4%  interrupts.CPU4.CAL:Function_call_interrupts
>       29418 ± 11%     -13.1%      25571 ±  6%  interrupts.CPU40.TLB:TLB_shootdowns
>       22467 ±  6%     -21.6%      17610 ± 10%  interrupts.CPU43.CAL:Function_call_interrupts
>       20028 ±  9%     +20.9%      24219 ±  7%  interrupts.CPU47.CAL:Function_call_interrupts
>       28186 ± 10%     +33.3%      37576 ± 21%  interrupts.CPU47.TLB:TLB_shootdowns
>       20503 ±  4%     +15.4%      23664 ±  3%  interrupts.CPU49.CAL:Function_call_interrupts
>       29724 ±  6%     +44.8%      43046 ± 34%  interrupts.CPU52.TLB:TLB_shootdowns
>       20812 ±  6%     +23.5%      25710 ±  2%  interrupts.CPU53.CAL:Function_call_interrupts
>       28228 ±  7%     +25.4%      35402 ±  3%  interrupts.CPU53.TLB:TLB_shootdowns
>       30617 ±  5%     +13.0%      34602 ±  5%  interrupts.CPU56.TLB:TLB_shootdowns
>       28393 ±  9%     +14.2%      32419 ±  4%  interrupts.CPU59.TLB:TLB_shootdowns
>       26886 ± 14%     +33.6%      35911 ± 17%  interrupts.CPU6.TLB:TLB_shootdowns
>        3607 ± 30%     -71.4%       1031 ± 40%  interrupts.CPU60.NMI:Non-maskable_interrupts
>        3607 ± 30%     -71.4%       1031 ± 40%  interrupts.CPU60.PMI:Performance_monitoring_interrupts
>       20497 ±  7%     +17.8%      24149 ±  6%  interrupts.CPU61.CAL:Function_call_interrupts
>       28713 ± 11%     +29.1%      37066 ± 14%  interrupts.CPU61.TLB:TLB_shootdowns
>       20400 ±  2%     +17.9%      24051 ±  3%  interrupts.CPU63.CAL:Function_call_interrupts
>       28404 ±  2%     +36.6%      38793 ± 21%  interrupts.CPU63.TLB:TLB_shootdowns
>      332.50 ± 74%     -84.0%      53.33 ± 39%  interrupts.CPU88.RES:Rescheduling_interrupts
>       55727 ± 23%     -47.1%      29476 ±  9%  interrupts.CPU91.TLB:TLB_shootdowns
>       41957 ± 29%     -42.7%      24035 ±  6%  interrupts.CPU92.TLB:TLB_shootdowns
>      516.25 ± 57%     -83.0%      88.00 ± 65%  interrupts.CPU93.RES:Rescheduling_interrupts
>       21481 ±  6%     -17.5%      17720 ±  9%  interrupts.CPU95.CAL:Function_call_interrupts
>       43882 ± 33%     -45.1%      24079 ± 10%  interrupts.CPU95.TLB:TLB_shootdowns
>       34.47 ± 18%      -7.4       27.02 ±  3%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
>       36.75 ± 16%      -7.2       29.55 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
>       36.91 ± 15%      -7.1       29.79 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
>       37.86 ± 14%      -6.7       31.20 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
>       37.86 ± 14%      -6.6       31.21 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
>       37.86 ± 14%      -6.6       31.21 ±  2%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
>       38.16 ± 15%      -6.5       31.62 ±  2%  perf-profile.calltrace.cycles-pp.secondary_startup_64
>        0.61 ±  9%      +0.1        0.69 ±  4%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.zap_page_range.do_madvise.__x64_sys_madvise.do_syscall_64
>        0.84 ±  5%      +0.1        0.93 ±  4%  perf-profile.calltrace.cycles-pp.clear_page_erms.prep_new_page.get_page_from_freelist.__alloc_pages_nodemask.alloc_pages_vma
>        0.93 ±  4%      +0.1        1.03 ±  4%  perf-profile.calltrace.cycles-pp.mem_cgroup_try_charge.mem_cgroup_try_charge_delay.handle_pte_fault.__handle_mm_fault.handle_mm_fault
>        1.13 ±  5%      +0.1        1.26 ±  3%  perf-profile.calltrace.cycles-pp.mem_cgroup_try_charge_delay.handle_pte_fault.__handle_mm_fault.handle_mm_fault.do_page_fault
>        1.17 ±  6%      +0.1        1.30 ±  3%  perf-profile.calltrace.cycles-pp.prep_new_page.get_page_from_freelist.__alloc_pages_nodemask.alloc_pages_vma.handle_pte_fault
>        1.55 ±  2%      +0.1        1.70 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.handle_pte_fault.__handle_mm_fault.handle_mm_fault.do_page_fault
>        0.92 ± 13%      +0.2        1.09 ±  5%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
>        1.63 ±  6%      +0.2        1.83 ±  3%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_nodemask.alloc_pages_vma.handle_pte_fault.__handle_mm_fault
>        1.75 ±  6%      +0.2        1.96 ±  2%  perf-profile.calltrace.cycles-pp.__alloc_pages_nodemask.alloc_pages_vma.handle_pte_fault.__handle_mm_fault.handle_mm_fault
>        1.86 ±  6%      +0.2        2.08 ±  2%  perf-profile.calltrace.cycles-pp.alloc_pages_vma.handle_pte_fault.__handle_mm_fault.handle_mm_fault.do_page_fault
>        2.01 ±  9%      +0.3        2.28 ±  2%  perf-profile.calltrace.cycles-pp.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
>        0.28 ±100%      +0.3        0.58 ±  2%  perf-profile.calltrace.cycles-pp.do_brk_flags.__x64_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
>        0.28 ±100%      +0.3        0.59 ±  5%  perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.tlb_flush_mmu.tlb_finish_mmu.zap_page_range.do_madvise
>        0.81 ±  8%      +0.4        1.17 ± 16%  perf-profile.calltrace.cycles-pp.release_pages.__pagevec_release.shmem_undo_range.shmem_truncate_range.shmem_evict_inode
>        0.82 ±  8%      +0.4        1.17 ± 17%  perf-profile.calltrace.cycles-pp.__pagevec_release.shmem_undo_range.shmem_truncate_range.shmem_evict_inode.evict
>        2.18 ±  4%      +0.4        2.57        perf-profile.calltrace.cycles-pp.release_pages.tlb_flush_mmu.unmap_page_range.unmap_vmas.exit_mmap
>        2.22 ±  4%      +0.4        2.62        perf-profile.calltrace.cycles-pp.tlb_flush_mmu.unmap_page_range.unmap_vmas.exit_mmap.mmput
>        2.35 ±  8%      +0.4        2.77 ±  6%  perf-profile.calltrace.cycles-pp.get_signal.do_signal.exit_to_usermode_loop.prepare_exit_to_usermode.swapgs_restore_regs_and_return_to_usermode
>        2.34 ±  8%      +0.4        2.76 ±  6%  perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.do_signal.exit_to_usermode_loop.prepare_exit_to_usermode
>        2.36 ±  8%      +0.4        2.78 ±  7%  perf-profile.calltrace.cycles-pp.do_signal.exit_to_usermode_loop.prepare_exit_to_usermode.swapgs_restore_regs_and_return_to_usermode
>        2.36 ±  8%      +0.4        2.78 ±  6%  perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.prepare_exit_to_usermode.swapgs_restore_regs_and_return_to_usermode
>        2.40 ±  8%      +0.4        2.83 ±  6%  perf-profile.calltrace.cycles-pp.swapgs_restore_regs_and_return_to_usermode
>        2.37 ±  8%      +0.4        2.80 ±  6%  perf-profile.calltrace.cycles-pp.prepare_exit_to_usermode.swapgs_restore_regs_and_return_to_usermode
>        2.76 ±  7%      +0.5        3.27        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.mmput.do_exit
>        2.77 ±  7%      +0.5        3.28        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.mmput.do_exit.do_group_exit
>        5.51 ±  3%      +0.6        6.14 ±  2%  perf-profile.calltrace.cycles-pp.handle_pte_fault.__handle_mm_fault.handle_mm_fault.do_page_fault.page_fault
>        0.35 ±100%      +0.7        1.01 ±  8%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
>        6.29 ± 11%      +1.0        7.33 ±  2%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_read_slowpath.__x64_sys_msync.do_syscall_64
>        7.17 ± 11%      +1.2        8.34 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_read_slowpath.__x64_sys_msync.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        7.57 ± 11%      +1.2        8.81 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.__x64_sys_msync.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        9.61 ± 11%      +1.3       10.93        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.do_madvise
>        9.17 ± 11%      +1.4       10.56 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_msync.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       11.68 ± 11%      +1.6       13.29 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.do_madvise.__x64_sys_madvise
>       12.11 ± 12%      +1.6       13.76 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write_killable.do_madvise.__x64_sys_madvise.do_syscall_64
>       34.59 ± 18%      -7.4       27.14 ±  2%  perf-profile.children.cycles-pp.intel_idle
>       37.20 ± 16%      -7.0       30.20 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
>       37.20 ± 16%      -7.0       30.20 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter
>       37.86 ± 14%      -6.6       31.21 ±  2%  perf-profile.children.cycles-pp.start_secondary
>       38.16 ± 15%      -6.5       31.62 ±  2%  perf-profile.children.cycles-pp.secondary_startup_64
>       38.16 ± 15%      -6.5       31.62 ±  2%  perf-profile.children.cycles-pp.cpu_startup_entry
>       38.17 ± 15%      -6.5       31.63 ±  2%  perf-profile.children.cycles-pp.do_idle
>        0.23 ± 25%      -0.1        0.17 ± 14%  perf-profile.children.cycles-pp.irq_enter
>        0.08 ±  5%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.select_task_rq_fair
>        0.07 ± 13%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.security_file_alloc
>        0.06 ± 11%      +0.0        0.08 ± 10%  perf-profile.children.cycles-pp.__pthread_enable_asynccancel
>        0.18 ±  2%      +0.0        0.21 ±  2%  perf-profile.children.cycles-pp.__perf_sw_event
>        0.04 ± 57%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
>        0.19 ±  7%      +0.0        0.22 ±  3%  perf-profile.children.cycles-pp.page_remove_rmap
>        0.08 ± 13%      +0.0        0.11 ± 12%  perf-profile.children.cycles-pp.uncharge_batch
>        0.15 ± 14%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__alloc_file
>        0.15 ± 10%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.alloc_empty_file
>        0.20 ± 10%      +0.0        0.24 ±  5%  perf-profile.children.cycles-pp.___slab_alloc
>        0.14 ± 11%      +0.0        0.18 ±  9%  perf-profile.children.cycles-pp.alloc_set_pte
>        0.15 ± 14%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.alloc_file
>        0.39 ±  6%      +0.0        0.44 ±  2%  perf-profile.children.cycles-pp.___might_sleep
>        0.01 ±173%      +0.0        0.06 ± 13%  perf-profile.children.cycles-pp.free_pcp_prepare
>        0.28 ± 10%      +0.0        0.33        perf-profile.children.cycles-pp.syscall_return_via_sysret
>        0.10 ± 23%      +0.1        0.15 ± 14%  perf-profile.children.cycles-pp.irq_work_run_list
>        0.00            +0.1        0.05        perf-profile.children.cycles-pp.call_rcu
>        0.52 ±  6%      +0.1        0.58 ±  2%  perf-profile.children.cycles-pp.do_brk_flags
>        0.21 ± 14%      +0.1        0.27        perf-profile.children.cycles-pp.alloc_file_pseudo
>        0.39 ±  9%      +0.1        0.45 ±  2%  perf-profile.children.cycles-pp.up_write
>        0.46 ±  4%      +0.1        0.52 ±  8%  perf-profile.children.cycles-pp.sync_regs
>        0.36 ± 10%      +0.1        0.43 ±  4%  perf-profile.children.cycles-pp.on_each_cpu_cond_mask
>        0.16 ± 33%      +0.1        0.24 ±  5%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
>        0.23 ± 19%      +0.1        0.32 ±  6%  perf-profile.children.cycles-pp.filemap_map_pages
>        0.42 ± 15%      +0.1        0.52 ±  4%  perf-profile.children.cycles-pp.osq_unlock
>        0.61 ± 12%      +0.1        0.72 ±  4%  perf-profile.children.cycles-pp.smp_call_function_many_cond
>        1.28 ±  5%      +0.1        1.39 ±  3%  perf-profile.children.cycles-pp.mem_cgroup_try_charge_delay
>        1.31 ±  5%      +0.1        1.43 ±  3%  perf-profile.children.cycles-pp.prep_new_page
>        0.86 ± 13%      +0.1        1.01        perf-profile.children.cycles-pp.mmap_region
>        2.23 ±  6%      +0.2        2.43 ±  3%  perf-profile.children.cycles-pp.get_page_from_freelist
>        2.44 ±  6%      +0.2        2.67 ±  3%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
>        2.48 ±  7%      +0.2        2.73 ±  3%  perf-profile.children.cycles-pp.alloc_pages_vma
>        2.40 ±  8%      +0.4        2.83 ±  6%  perf-profile.children.cycles-pp.swapgs_restore_regs_and_return_to_usermode
>        2.38 ±  8%      +0.4        2.80 ±  6%  perf-profile.children.cycles-pp.prepare_exit_to_usermode
>        3.12 ±  2%      +0.4        3.55        perf-profile.children.cycles-pp.unmap_page_range
>        3.07 ±  2%      +0.4        3.50        perf-profile.children.cycles-pp.unmap_vmas
>        0.57 ± 25%      +0.5        1.02 ±  8%  perf-profile.children.cycles-pp.menu_select
>        4.06 ±  4%      +0.5        4.58        perf-profile.children.cycles-pp.tlb_flush_mmu
>        4.83 ±  4%      +0.5        5.36        perf-profile.children.cycles-pp.release_pages
>        6.64 ±  5%      +0.8        7.41 ±  2%  perf-profile.children.cycles-pp.handle_pte_fault
>        9.18 ± 11%      +1.4       10.57 ±  3%  perf-profile.children.cycles-pp.__x64_sys_msync
>        9.69 ± 11%      +1.5       11.19        perf-profile.children.cycles-pp.rwsem_down_read_slowpath
>       12.15 ± 12%      +1.7       13.87 ±  2%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
>       17.80 ± 11%      +2.6       20.44 ±  2%  perf-profile.children.cycles-pp.osq_lock
>       20.98 ± 11%      +3.1       24.05 ±  2%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
>       34.59 ± 18%      -7.4       27.14 ±  2%  perf-profile.self.cycles-pp.intel_idle
>        0.05 ±  8%      +0.0        0.07 ±  7%  perf-profile.self.cycles-pp.do_brk_flags
>        0.07 ± 11%      +0.0        0.09        perf-profile.self.cycles-pp.anon_vma_interval_tree_remove
>        0.06 ± 11%      +0.0        0.08 ± 10%  perf-profile.self.cycles-pp.__pthread_enable_asynccancel
>        0.15 ±  7%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.page_remove_rmap
>        0.17 ±  6%      +0.0        0.19 ±  4%  perf-profile.self.cycles-pp.find_get_entries
>        0.17 ±  6%      +0.0        0.19 ±  4%  perf-profile.self.cycles-pp.handle_mm_fault
>        0.23 ±  6%      +0.0        0.26 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irq
>        0.37 ±  6%      +0.0        0.42 ±  2%  perf-profile.self.cycles-pp.___might_sleep
>        0.21 ±  8%      +0.0        0.26 ±  4%  perf-profile.self.cycles-pp.do_madvise
>        0.28 ± 10%      +0.0        0.33        perf-profile.self.cycles-pp.syscall_return_via_sysret
>        0.39 ±  8%      +0.1        0.44 ±  2%  perf-profile.self.cycles-pp.up_write
>        0.13 ± 22%      +0.1        0.19 ±  6%  perf-profile.self.cycles-pp.filemap_map_pages
>        0.45 ±  3%      +0.1        0.52 ±  8%  perf-profile.self.cycles-pp.sync_regs
>        0.67 ±  6%      +0.1        0.75        perf-profile.self.cycles-pp.get_page_from_freelist
>        0.42 ± 16%      +0.1        0.51 ±  3%  perf-profile.self.cycles-pp.osq_unlock
>        0.20 ± 18%      +0.2        0.40 ±  7%  perf-profile.self.cycles-pp.cpuidle_enter_state
>        1.94 ±  5%      +0.2        2.15        perf-profile.self.cycles-pp._raw_spin_lock
>        0.20 ± 39%      +0.4        0.56 ±  5%  perf-profile.self.cycles-pp.menu_select
>       17.31 ± 11%      +2.6       19.86 ±  2%  perf-profile.self.cycles-pp.osq_lock
> 
> 
> 
> ***************************************************************************************************
> lkp-hsw-d01: 8 threads Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz with 8G memory
> 
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
