Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D5BC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 11:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2168C2072C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 11:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgDMLEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 07:04:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41708 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728620AbgDMLEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 07:04:11 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E3D0D33E6353EBE66D09;
        Mon, 13 Apr 2020 19:04:02 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 13 Apr
 2020 19:04:00 +0800
Subject: Re: [LKP] [f2fs] fe1897eaa6: aim7.jobs-per-min -60.9% regression
To:     Feng Tang <feng.tang@intel.com>,
        kernel test robot <rong.a.chen@intel.com>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <lkp@lists.01.org>
References: <20191208154145.GM32275@shao2-debian>
 <20200413105124.GA49945@shbuild999.sh.intel.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <1c5007a1-26fe-650b-0a34-5b12f749b384@huawei.com>
Date:   Mon, 13 Apr 2020 19:03:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200413105124.GA49945@shbuild999.sh.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/13 18:51, Feng Tang wrote:
> On Sun, Dec 08, 2019 at 11:41:46PM +0800, kernel test robot wrote:
>> Greeting,
>>
>> FYI, we noticed a -60.9% regression of aim7.jobs-per-min due to commit:
>>
>>
>> commit: fe1897eaa6646f5a64a4cee0e6473ed9887d324b ("f2fs: fix to update time in lazytime mode")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> in testcase: aim7
>> on test machine: 48 threads Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz with 64G memory
>> with following parameters:
>>
>> 	disk: 4BRD_12G
>> 	md: RAID1
>> 	fs: f2fs
>> 	test: sync_disk_rw
>> 	load: 200
>> 	cpufreq_governor: performance
>> 	ucode: 0x42e
>>
>> test-description: AIM7 is a traditional UNIX system level benchmark suite which is used to test and measure the performance of multiuser system.
>> test-url: https://sourceforge.net/projects/aimbench/files/aim-suite7/
>>
>>
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kernel test robot <rong.a.chen@intel.com>
>>
>>
>> Details are as below:
>> -------------------------------------------------------------------------------------------------->
>>
>>
>> To reproduce:
>>
>>         git clone https://github.com/intel/lkp-tests.git
>>         cd lkp-tests
>>         bin/lkp install job.yaml  # job file is attached in this email
>>         bin/lkp run     job.yaml
>>
>> =========================================================================================
>> compiler/cpufreq_governor/disk/fs/kconfig/load/md/rootfs/tbox_group/test/testcase/ucode:
>>   gcc-7/performance/4BRD_12G/f2fs/x86_64-rhel-7.6/200/RAID1/debian-x86_64-2019-11-14.cgz/lkp-ivb-2ep1/sync_disk_rw/aim7/0x42e
>>
>> commit: 
>>   b145b0eb20 (" ARM and x86 bugfixes of all kinds.  The most visible one is that migrating")
>>   fe1897eaa6 ("f2fs: fix to update time in lazytime mode")
>>
>> b145b0eb2031a620 fe1897eaa6646f5a64a4cee0e64 
>> ---------------- --------------------------- 
>>        fail:runs  %reproduction    fail:runs
>>            |             |             |    
>>           1:4          -25%            :4     dmesg.WARNING:at#for_ip_interrupt_entry/0x
>>          %stddev     %change         %stddev
>>              \          |                \  
>>       1208           -60.9%     473.12        aim7.jobs-per-min
> 
> Hi Chao Yu,
> 
> Any thoughts on this? 
> 
> IIUC, this commit is a fix, and if you think it is necessary, we will
> stop tracking this regresion.

Hi Feng Tang,

Sorry, I missed to reply this thread.

Anyway, we need this fix patch to avoid losing atime issue in some cases,
let's stop tracking this regression please.

Thanks for noticing/reporting this regression. :)

Thanks,

> 
> Thanks,
> Feng
> 
> 
>>     992.70          +155.6%       2537        aim7.time.elapsed_time
>>     992.70          +155.6%       2537        aim7.time.elapsed_time.max
>>  1.078e+08           +60.0%  1.724e+08        aim7.time.file_system_outputs
>>    9646301            -4.2%    9238717        aim7.time.involuntary_context_switches
>>      24107 ±  3%     +58.2%      38130 ± 17%  aim7.time.minor_page_faults
>>       3295          +202.3%       9963        aim7.time.system_time
>>      26.75           +51.4%      40.49        aim7.time.user_time
>>   5.02e+08          +210.5%  1.559e+09        aim7.time.voluntary_context_switches
>>    9294452 ±  4%     -15.7%    7835497 ± 16%  numa-numastat.node0.local_node
>>    9298417 ±  4%     -15.7%    7840991 ± 16%  numa-numastat.node0.numa_hit
>>       3.66 ±  3%      +4.2        7.82 ± 18%  mpstat.cpu.all.idle%
>>       0.01 ± 32%      -0.0        0.00 ± 31%  mpstat.cpu.all.soft%
>>       0.06            -0.0        0.04        mpstat.cpu.all.usr%
>>       3.85 ±  3%    +105.0%       7.89 ± 17%  iostat.cpu.idle
>>      89.80            -4.9%      85.36        iostat.cpu.iowait
>>       6.29            +6.6%       6.70        iostat.cpu.system
>>      23968           -48.4%      12356        iostat.md0.w/s
>>      53780           -37.1%      33824        iostat.md0.wkB/s
>>      89.00            -4.8%      84.75        vmstat.cpu.wa
>>      53779           -37.1%      33833        vmstat.io.bo
>>   29311046           -28.6%   20935254        vmstat.memory.free
>>    1026388           +19.4%    1225080        vmstat.system.cs
>>     103289            +8.5%     112038        vmstat.system.in
>>      24013 ± 29%     -58.5%       9976 ±120%  numa-meminfo.node0.Dirty
>>     119019 ± 10%     +44.6%     172139 ± 13%  numa-meminfo.node1.Active
>>       3503 ± 56%    +464.8%      19786 ± 38%  numa-meminfo.node1.Active(file)
>>      40477 ± 16%     -38.5%      24896 ± 47%  numa-meminfo.node1.Dirty
>>   19966008 ±  2%     -29.5%   14084594 ± 44%  numa-meminfo.node1.MemFree
>>   13014643 ±  4%     +45.2%   18896052 ± 32%  numa-meminfo.node1.MemUsed
>>      12018 ± 41%    +184.8%      34228 ± 35%  numa-meminfo.node1.Shmem
>>   2.09e+10          +127.4%  4.752e+10 ±  4%  cpuidle.C1.time
>>  2.558e+08          +140.1%  6.143e+08 ±  4%  cpuidle.C1.usage
>>  3.017e+09 ± 10%    +301.2%  1.211e+10 ±  9%  cpuidle.C1E.time
>>   18225961 ±  9%    +430.1%   96624314 ±  6%  cpuidle.C1E.usage
>>  4.627e+08 ± 14%    +147.5%  1.145e+09 ± 20%  cpuidle.C6.time
>>     802166 ± 17%    +186.9%    2301023 ± 26%  cpuidle.C6.usage
>>  1.799e+10          +148.9%  4.476e+10        cpuidle.POLL.time
>>  2.616e+08 ±  2%    +246.4%  9.063e+08 ±  2%  cpuidle.POLL.usage
>>       6017 ± 29%     -58.5%       2496 ±120%  numa-vmstat.node0.nr_dirty
>>       5742 ± 29%     -65.0%       2011 ±120%  numa-vmstat.node0.nr_zone_write_pending
>>     874.50 ± 56%    +465.6%       4946 ± 38%  numa-vmstat.node1.nr_active_file
>>      10139 ± 16%     -38.6%       6224 ± 47%  numa-vmstat.node1.nr_dirty
>>    4992144 ±  2%     -29.5%    3521200 ± 44%  numa-vmstat.node1.nr_free_pages
>>       3003 ± 41%    +184.9%       8556 ± 35%  numa-vmstat.node1.nr_shmem
>>     874.50 ± 56%    +465.6%       4946 ± 38%  numa-vmstat.node1.nr_zone_active_file
>>       9775 ± 16%     -47.9%       5089 ± 47%  numa-vmstat.node1.nr_zone_write_pending
>>  2.558e+08          +140.1%  6.143e+08 ±  4%  turbostat.C1
>>      43.77            -4.8       38.98 ±  3%  turbostat.C1%
>>   18225642 ±  9%    +430.2%   96624037 ±  6%  turbostat.C1E
>>       6.31 ± 10%      +3.6        9.94 ±  9%  turbostat.C1E%
>>     795117 ± 17%    +188.4%    2292823 ± 26%  turbostat.C6
>>       0.38 ± 42%     -63.6%       0.14 ± 13%  turbostat.CPU%c6
>>  1.028e+08          +176.7%  2.844e+08        turbostat.IRQ
>>       0.23 ± 33%     -69.1%       0.07 ± 22%  turbostat.Pkg%pc2
>>     275064           +12.3%     308846 ±  4%  meminfo.Active
>>       8036 ± 21%    +261.7%      29072 ± 52%  meminfo.Active(file)
>>      64400           -45.9%      34850        meminfo.Dirty
>>      16481           +10.8%      18264        meminfo.Inactive(anon)
>>     147067           +12.8%     165858 ±  2%  meminfo.KReclaimable
>>   29120417           -28.8%   20740075        meminfo.MemAvailable
>>   29335165           -28.6%   20936804        meminfo.MemFree
>>   36511133           +23.0%   44909491        meminfo.Memused
>>     147067           +12.8%     165858 ±  2%  meminfo.SReclaimable
>>      36567 ±  6%     +37.2%      50173        meminfo.Shmem
>>      51580           -60.8%      20220        meminfo.max_used_kB
>>       4.27 ±  7%     -13.9%       3.67 ±  4%  perf-stat.i.MPKI
>>       0.71 ±  3%      -0.0        0.67        perf-stat.i.branch-miss-rate%
>>      17.93            +3.5       21.41 ±  2%  perf-stat.i.cache-miss-rate%
>>    1029337           +19.1%    1226025        perf-stat.i.context-switches
>>      11421 ±  4%     +41.1%      16120 ±  6%  perf-stat.i.cpu-migrations
>>       0.42 ±  2%      +0.0        0.45 ±  6%  perf-stat.i.dTLB-load-miss-rate%
>>       0.11 ± 27%      -0.0        0.08 ±  3%  perf-stat.i.dTLB-store-miss-rate%
>>      84.04 ±  2%      -2.3       81.75 ±  2%  perf-stat.i.iTLB-load-miss-rate%
>>    7375571            +7.3%    7917282        perf-stat.i.iTLB-load-misses
>>       3.91 ±  7%      -9.2%       3.56 ±  4%  perf-stat.overall.MPKI
>>      17.90            +4.1       21.96 ±  3%  perf-stat.overall.cache-miss-rate%
>>       0.41 ±  2%      +0.0        0.45 ±  6%  perf-stat.overall.dTLB-load-miss-rate%
>>       0.10 ± 27%      -0.0        0.08 ±  3%  perf-stat.overall.dTLB-store-miss-rate%
>>      83.99 ±  2%      -2.3       81.72 ±  2%  perf-stat.overall.iTLB-load-miss-rate%
>>    1028292           +19.2%    1225532        perf-stat.ps.context-switches
>>      11410 ±  4%     +41.2%      16114 ±  6%  perf-stat.ps.cpu-migrations
>>    7368087            +7.4%    7914119        perf-stat.ps.iTLB-load-misses
>>  2.558e+13 ±  2%    +157.0%  6.575e+13 ±  3%  perf-stat.total.instructions
>>       9128 ±  2%     -25.3%       6821 ±  4%  slabinfo.dmaengine-unmap-16.active_objs
>>       9175 ±  2%     -24.4%       6938 ±  4%  slabinfo.dmaengine-unmap-16.num_objs
>>      28309           +12.5%      31840        slabinfo.f2fs_extent_node.active_objs
>>      28704           +13.0%      32429        slabinfo.f2fs_extent_node.num_objs
>>     964.00 ±  5%     -13.3%     836.00 ±  6%  slabinfo.kmem_cache_node.active_objs
>>       1008 ±  5%     -12.7%     880.00 ±  6%  slabinfo.kmem_cache_node.num_objs
>>      13017           -33.1%       8707        slabinfo.nat_entry.active_objs
>>      13036           -33.2%       8707        slabinfo.nat_entry.num_objs
>>     433.75 ±  9%     +32.4%     574.50 ±  2%  slabinfo.nfs_read_data.active_objs
>>     433.75 ±  9%     +32.4%     574.50 ±  2%  slabinfo.nfs_read_data.num_objs
>>     697.50 ±  3%     +48.6%       1036 ± 33%  slabinfo.numa_policy.active_objs
>>     697.50 ±  3%     +48.6%       1036 ± 33%  slabinfo.numa_policy.num_objs
>>     153098           +22.3%     187296        slabinfo.radix_tree_node.active_objs
>>       2733           +22.3%       3344        slabinfo.radix_tree_node.active_slabs
>>     153098           +22.3%     187296        slabinfo.radix_tree_node.num_objs
>>       2733           +22.3%       3344        slabinfo.radix_tree_node.num_slabs
>>     542.00 ± 10%     +29.5%     702.00 ±  6%  slabinfo.xfrm_state.active_objs
>>     542.00 ± 10%     +29.5%     702.00 ±  6%  slabinfo.xfrm_state.num_objs
>>      66757            +4.8%      69942        proc-vmstat.nr_active_anon
>>       2009 ± 21%    +261.7%       7267 ± 52%  proc-vmstat.nr_active_file
>>      96.00            +3.9%      99.75        proc-vmstat.nr_anon_transparent_hugepages
>>   13466177           +60.0%   21542226        proc-vmstat.nr_dirtied
>>      16154           -46.0%       8719        proc-vmstat.nr_dirty
>>     726643           -28.8%     517541        proc-vmstat.nr_dirty_background_threshold
>>    1455064           -28.8%    1036348        proc-vmstat.nr_dirty_threshold
>>     311402            +2.4%     318957        proc-vmstat.nr_file_pages
>>    7332853           -28.6%    5234441        proc-vmstat.nr_free_pages
>>       4120           +10.8%       4565        proc-vmstat.nr_inactive_anon
>>      13939            -1.2%      13772        proc-vmstat.nr_kernel_stack
>>       2845            -1.5%       2803        proc-vmstat.nr_page_table_pages
>>       9142 ±  6%     +37.2%      12542        proc-vmstat.nr_shmem
>>      36767           +12.8%      41463 ±  2%  proc-vmstat.nr_slab_reclaimable
>>   13387539           +60.3%   21463781        proc-vmstat.nr_written
>>      66757            +4.8%      69942        proc-vmstat.nr_zone_active_anon
>>       2009 ± 21%    +261.7%       7267 ± 52%  proc-vmstat.nr_zone_active_file
>>       4120           +10.8%       4565        proc-vmstat.nr_zone_inactive_anon
>>      15494           -54.2%       7089        proc-vmstat.nr_zone_write_pending
>>     582146 ±102%    +628.1%    4238850 ±  6%  proc-vmstat.numa_foreign
>>      13506 ±  3%    +114.5%      28974 ± 31%  proc-vmstat.numa_hint_faults
>>       8913 ±  6%    +148.6%      22154 ± 35%  proc-vmstat.numa_hint_faults_local
>>     582146 ±102%    +628.1%    4238850 ±  6%  proc-vmstat.numa_miss
>>     597885 ± 99%    +611.6%    4254585 ±  6%  proc-vmstat.numa_other
>>    1014174 ± 20%     -46.1%     547135 ± 57%  proc-vmstat.pgalloc_dma32
>>   16157005           +22.4%   19769138        proc-vmstat.pgalloc_normal
>>    2516271          +152.8%    6360808        proc-vmstat.pgfault
>>    4866589           +64.4%    8002519        proc-vmstat.pgfree
>>   53553588           +60.3%   85856803        proc-vmstat.pgpgout
>>       1.55 ±  4%      +0.1        1.65        perf-profile.calltrace.cycles-pp.__schedule.schedule.io_schedule.wait_on_page_bit.f2fs_wait_on_page_writeback
>>       1.58 ±  4%      +0.1        1.69        perf-profile.calltrace.cycles-pp.schedule.io_schedule.wait_on_page_bit.f2fs_wait_on_page_writeback.f2fs_wait_on_node_pages_writeback
>>       1.60 ±  4%      +0.1        1.71        perf-profile.calltrace.cycles-pp.io_schedule.wait_on_page_bit.f2fs_wait_on_page_writeback.f2fs_wait_on_node_pages_writeback.f2fs_do_sync_file
>>       0.75 ±  2%      +0.2        0.91 ±  2%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
>>       0.70 ±  4%      -0.3        0.36 ±  7%  perf-profile.children.cycles-pp.__generic_file_write_iter
>>       0.69 ±  4%      -0.3        0.35 ±  7%  perf-profile.children.cycles-pp.generic_perform_write
>>       0.57 ±  5%      -0.3        0.25 ±  6%  perf-profile.children.cycles-pp.__filemap_fdatawrite_range
>>       0.58 ±  5%      -0.3        0.26 ±  7%  perf-profile.children.cycles-pp.file_write_and_wait_range
>>       0.57 ±  6%      -0.3        0.25 ±  6%  perf-profile.children.cycles-pp.do_writepages
>>       0.57 ±  5%      -0.3        0.25 ±  6%  perf-profile.children.cycles-pp.f2fs_write_data_pages
>>       0.64 ±  5%      -0.3        0.34 ±  6%  perf-profile.children.cycles-pp.f2fs_write_begin
>>       0.57 ±  5%      -0.2        0.32 ±  7%  perf-profile.children.cycles-pp.f2fs_put_page
>>       0.31 ± 10%      -0.2        0.11 ±  7%  perf-profile.children.cycles-pp.blk_finish_plug
>>       0.31 ± 10%      -0.2        0.11 ±  7%  perf-profile.children.cycles-pp.blk_flush_plug_list
>>       0.30 ± 11%      -0.2        0.11 ±  6%  perf-profile.children.cycles-pp.raid1_unplug
>>       0.26            -0.1        0.14 ± 12%  perf-profile.children.cycles-pp.f2fs_write_cache_pages
>>       0.22 ± 20%      -0.1        0.11 ± 41%  perf-profile.children.cycles-pp.brd_do_bvec
>>       0.14 ± 12%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.submit_bio_wait
>>       0.21 ± 10%      -0.1        0.11 ± 10%  perf-profile.children.cycles-pp.submit_bio
>>       0.23 ± 17%      -0.1        0.13 ± 31%  perf-profile.children.cycles-pp.worker_thread
>>       0.20 ±  3%      -0.1        0.11 ± 14%  perf-profile.children.cycles-pp.__write_data_page
>>       0.14 ± 15%      -0.1        0.05 ±  9%  perf-profile.children.cycles-pp.__submit_flush_wait
>>       0.17 ± 12%      -0.1        0.09 ± 12%  perf-profile.children.cycles-pp.md_make_request
>>       0.16 ± 11%      -0.1        0.08 ± 14%  perf-profile.children.cycles-pp.md_handle_request
>>       0.15 ±  9%      -0.1        0.07 ± 11%  perf-profile.children.cycles-pp.raid1_make_request
>>       0.14 ± 17%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.f2fs_issue_flush
>>       0.14 ±  6%      -0.1        0.08 ± 19%  perf-profile.children.cycles-pp.f2fs_do_write_data_page
>>       0.10 ± 33%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.reschedule_interrupt
>>       0.09 ± 37%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.scheduler_ipi
>>       0.06 ±  6%      +0.0        0.08 ± 10%  perf-profile.children.cycles-pp.up_read
>>       0.10 ±  4%      +0.0        0.12 ± 13%  perf-profile.children.cycles-pp.pick_next_task_idle
>>       0.20 ±  2%      +0.0        0.23 ±  5%  perf-profile.children.cycles-pp.get_next_timer_interrupt
>>       0.16 ±  6%      +0.0        0.19 ±  4%  perf-profile.children.cycles-pp.irq_exit
>>       0.01 ±173%      +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.put_prev_task_fair
>>       0.27 ±  3%      +0.1        0.33 ±  4%  perf-profile.children.cycles-pp.tick_nohz_next_event
>>       0.35 ±  3%      +0.1        0.42 ±  3%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
>>       1.60 ±  4%      +0.1        1.72        perf-profile.children.cycles-pp.io_schedule
>>       0.78 ±  2%      +0.1        0.92 ±  2%  perf-profile.children.cycles-pp.menu_select
>>       0.06 ±  6%      +0.0        0.08 ± 10%  perf-profile.self.cycles-pp.up_read
>>       0.08 ±  5%      +0.0        0.11 ± 11%  perf-profile.self.cycles-pp.cpuidle_enter_state
>>       0.35 ±  5%      +0.0        0.39 ±  5%  perf-profile.self.cycles-pp.f2fs_wait_on_node_pages_writeback
>>       0.35 ±  4%      +0.1        0.41 ±  3%  perf-profile.self.cycles-pp.menu_select
>>       8096 ± 28%    +278.9%      30679 ± 20%  sched_debug.cfs_rq:/.MIN_vruntime.avg
>>     158062 ± 17%    +299.5%     631442 ±  8%  sched_debug.cfs_rq:/.MIN_vruntime.max
>>      32629 ± 22%    +289.7%     127148 ± 13%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
>>      44053          +192.3%     128774        sched_debug.cfs_rq:/.exec_clock.avg
>>     140530 ±  9%    +377.8%     671471 ± 29%  sched_debug.cfs_rq:/.exec_clock.max
>>      33108 ±  2%    +109.9%      69484 ±  2%  sched_debug.cfs_rq:/.exec_clock.min
>>      20291 ±  7%    +386.1%      98642 ± 21%  sched_debug.cfs_rq:/.exec_clock.stddev
>>       0.25 ± 82%     -88.4%       0.03 ±131%  sched_debug.cfs_rq:/.load_avg.min
>>       8096 ± 28%    +278.9%      30679 ± 20%  sched_debug.cfs_rq:/.max_vruntime.avg
>>     158062 ± 17%    +299.5%     631442 ±  8%  sched_debug.cfs_rq:/.max_vruntime.max
>>      32629 ± 22%    +289.7%     127148 ± 13%  sched_debug.cfs_rq:/.max_vruntime.stddev
>>     184170          +218.6%     586859 ±  2%  sched_debug.cfs_rq:/.min_vruntime.avg
>>     251516 ±  4%    +254.5%     891702 ± 11%  sched_debug.cfs_rq:/.min_vruntime.max
>>     165614          +131.3%     383025 ±  2%  sched_debug.cfs_rq:/.min_vruntime.min
>>      15286 ±  9%   +1057.3%     176903 ± 10%  sched_debug.cfs_rq:/.min_vruntime.stddev
>>       0.67 ±  6%     +45.5%       0.98 ±  9%  sched_debug.cfs_rq:/.nr_spread_over.avg
>>       0.74 ± 20%     +32.4%       0.98 ± 13%  sched_debug.cfs_rq:/.nr_spread_over.stddev
>>       3.43 ± 29%     -60.7%       1.35 ±100%  sched_debug.cfs_rq:/.removed.load_avg.avg
>>      75.10 ± 34%     -84.1%      11.91 ±100%  sched_debug.cfs_rq:/.removed.load_avg.max
>>      15.24 ± 23%     -75.5%       3.74 ±100%  sched_debug.cfs_rq:/.removed.load_avg.stddev
>>     157.58 ± 29%     -60.5%      62.19 ±100%  sched_debug.cfs_rq:/.removed.runnable_sum.avg
>>       3459 ± 34%     -84.0%     552.75 ± 99%  sched_debug.cfs_rq:/.removed.runnable_sum.max
>>     700.79 ± 23%     -75.4%     172.66 ±100%  sched_debug.cfs_rq:/.removed.runnable_sum.stddev
>>      34.81 ± 42%     -87.0%       4.53 ±100%  sched_debug.cfs_rq:/.removed.util_avg.max
>>       5.89 ± 31%     -79.0%       1.23 ±100%  sched_debug.cfs_rq:/.removed.util_avg.stddev
>>      59642 ± 58%    +506.4%     361657 ± 61%  sched_debug.cfs_rq:/.spread0.max
>>      15286 ±  9%   +1057.2%     176904 ± 10%  sched_debug.cfs_rq:/.spread0.stddev
>>      15.81 ± 15%     +28.7%      20.34 ±  2%  sched_debug.cfs_rq:/.util_est_enqueued.avg
>>     553.04 ± 15%     +42.8%     789.60 ±  2%  sched_debug.cfs_rq:/.util_est_enqueued.max
>>      83.37 ± 15%     +37.7%     114.78 ±  2%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
>>     130721           -17.9%     107295        sched_debug.cpu.avg_idle.avg
>>      32650 ±  7%     -16.9%      27145 ±  6%  sched_debug.cpu.avg_idle.min
>>     509212          +151.7%    1281639        sched_debug.cpu.clock.avg
>>     509215          +151.7%    1281642        sched_debug.cpu.clock.max
>>     509209          +151.7%    1281636        sched_debug.cpu.clock.min
>>     509212          +151.7%    1281639        sched_debug.cpu.clock_task.avg
>>     509215          +151.7%    1281642        sched_debug.cpu.clock_task.max
>>     509209          +151.7%    1281636        sched_debug.cpu.clock_task.min
>>     480.69 ±  2%     +89.2%     909.42 ±  3%  sched_debug.cpu.curr->pid.avg
>>      14037          +135.4%      33040        sched_debug.cpu.curr->pid.max
>>       2146 ±  2%    +125.6%       4843        sched_debug.cpu.curr->pid.stddev
>>       0.12 ±  5%     +10.2%       0.13 ±  3%  sched_debug.cpu.nr_running.avg
>>   10174129          +208.2%   31360192        sched_debug.cpu.nr_switches.avg
>>   10849045          +290.1%   42321541 ±  3%  sched_debug.cpu.nr_switches.max
>>     564008 ± 15%   +1719.4%   10261545 ±  8%  sched_debug.cpu.nr_switches.stddev
>>     -87.16          +262.4%    -315.83        sched_debug.cpu.nr_uninterruptible.min
>>      66.84 ± 14%    +143.1%     162.48 ± 21%  sched_debug.cpu.nr_uninterruptible.stddev
>>   10172460          +208.3%   31358619        sched_debug.cpu.sched_count.avg
>>   10847113          +290.1%   42319816 ±  3%  sched_debug.cpu.sched_count.max
>>     563945 ± 15%   +1719.6%   10261603 ±  8%  sched_debug.cpu.sched_count.stddev
>>    4957584          +211.1%   15425344        sched_debug.cpu.sched_goidle.avg
>>    5286410          +291.7%   20709361 ±  3%  sched_debug.cpu.sched_goidle.max
>>     272603 ± 14%   +1717.5%    4954528 ±  7%  sched_debug.cpu.sched_goidle.stddev
>>    5120024          +209.4%   15841794        sched_debug.cpu.ttwu_count.avg
>>   58965381 ± 14%    +567.2%  3.934e+08 ± 33%  sched_debug.cpu.ttwu_count.max
>>     132694 ±  2%     -41.0%      78274 ±  5%  sched_debug.cpu.ttwu_count.min
>>   11266172 ±  8%    +482.6%   65635267 ± 21%  sched_debug.cpu.ttwu_count.stddev
>>     114955           +26.1%     144930 ±  3%  sched_debug.cpu.ttwu_local.max
>>      83595 ±  4%     -53.0%      39284 ± 30%  sched_debug.cpu.ttwu_local.min
>>       5967 ± 16%    +460.9%      33468 ±  9%  sched_debug.cpu.ttwu_local.stddev
>>     509209          +151.7%    1281636        sched_debug.cpu_clk
>>     506629          +152.5%    1279056        sched_debug.ktime
>>     509627          +151.6%    1282053        sched_debug.sched_clk
> .
> 
