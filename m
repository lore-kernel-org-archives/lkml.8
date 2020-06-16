Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414D3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 02:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F29512074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 02:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgFPC6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 22:58:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:35336 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgFPC6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 22:58:40 -0400
IronPort-SDR: Nuf4ZmwjQtTi+CzsBRVakhNcYQd2JoER3aMjCGj9/VL/Yen7T1fOTeUgMKxTQsHSBb6XgxPwRH
 RuJhOfiYKwwg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 19:51:22 -0700
IronPort-SDR: kcgBMKaGzUMMBZ2cMl5EFzoI1KG5QXbbKXYW5V9dtNyehdlWXAMVQscrjJnhP3NSbT/Ybkx4O9
 8QP0CYV6LD9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,517,1583222400"; 
   d="scan'208";a="261998515"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga007.jf.intel.com with ESMTP; 15 Jun 2020 19:51:20 -0700
Subject: Re: [btrfs] e678934cbe: reaim.jobs_per_min -30.7% regression
To:     Filipe Manana <fdmanana@suse.com>,
        Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200611090233.GL12456@shao2-debian>
 <7b474586-0d13-5a9d-8aed-17a99b69d80b@suse.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <ba013cb2-1d97-156d-813d-2526465ee738@intel.com>
Date:   Tue, 16 Jun 2020 10:51:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7b474586-0d13-5a9d-8aed-17a99b69d80b@suse.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/20 7:50 PM, Filipe Manana wrote:
>
> On 11/06/20 10:02, kernel test robot wrote:
>> Greeting,
>>
>> FYI, we noticed a -30.7% regression of reaim.jobs_per_min due to commit:
>
> Hello,
>
> In the future, can you please always CC linux-btrfs@vger.kernel.org for
> btrfs related reports?

Thanks for the advice, we'll cc the mailing list next time.

Best Regards,
Rong Chen

>
> Thanks.
>
>>
>> commit: e678934cbe5f026c2765a1da651e61daa5724fb3 ("btrfs: Remove unnecessary check from join_running_log_trans")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> in testcase: reaim
>> on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 256G memory
>> with following parameters:
>>
>> 	runtime: 300s
>> 	nr_task: 100
>> 	disk: 1HDD
>> 	fs: btrfs
>> 	test: disk
>> 	cpufreq_governor: performance
>> 	ucode: 0x500002c
>>
>> test-description: REAIM is an updated and improved version of AIM 7 benchmark.
>> test-url: https://sourceforge.net/projects/re-aim-7/
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
>>          git clone https://github.com/intel/lkp-tests.git
>>          cd lkp-tests
>>          bin/lkp install job.yaml  # job file is attached in this email
>>          bin/lkp run     job.yaml
>>
>> =========================================================================================
>> compiler/cpufreq_governor/disk/fs/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase/ucode:
>>    gcc-9/performance/1HDD/btrfs/x86_64-rhel-7.6/100/debian-x86_64-20191114.cgz/300s/lkp-csl-2sp6/disk/reaim/0x500002c
>>
>> commit:
>>    32e534402a ("Btrfs: wake up inode cache waiters sooner to reduce waiting time")
>>    e678934cbe ("btrfs: Remove unnecessary check from join_running_log_trans")
>>
>> 32e534402ad52e9f e678934cbe5f026c2765a1da651
>> ---------------- ---------------------------
>>         fail:runs  %reproduction    fail:runs
>>             |             |             |
>>             :4           25%           1:4     dmesg.WARNING:at#for_ip_swapgs_restore_regs_and_return_to_usermode/0x
>>           %stddev     %change         %stddev
>>               \          |                \
>>        5.39            +6.4%       5.73 ±  6%  reaim.child_utime
>>        6882 ±  2%     -30.7%       4771 ±  2%  reaim.jobs_per_min
>>       68.82 ±  2%     -30.7%      47.72 ±  2%  reaim.jobs_per_min_child
>>       98.56            -3.4%      95.25        reaim.jti
>>        6978 ±  2%     -29.5%       4917 ±  2%  reaim.max_jobs_per_min
>>       87.24 ±  2%     +44.3%     125.92 ±  2%  reaim.parent_time
>>        0.97 ±  5%    +337.7%       4.26 ±  9%  reaim.std_dev_percent
>>        0.84 ±  5%    +504.3%       5.05 ±  7%  reaim.std_dev_time
>>      357.77 ±  2%      +7.4%     384.27 ±  2%  reaim.time.elapsed_time
>>      357.77 ±  2%      +7.4%     384.27 ±  2%  reaim.time.elapsed_time.max
>>      276434           -25.6%     205672        reaim.time.file_system_inputs
>>    10740316           -20.1%    8583748 ±  2%  reaim.time.file_system_outputs
>>       63443           -13.8%      54688        reaim.time.involuntary_context_switches
>>     6205791           -24.9%    4661554        reaim.time.minor_page_faults
>>       84.25 ±  2%     -34.4%      55.25 ± 11%  reaim.time.percent_of_cpu_this_job_got
>>      281.73           -30.3%     196.49 ± 11%  reaim.time.system_time
>>       21.59           -20.2%      17.23 ±  6%  reaim.time.user_time
>>     2253123           -10.4%    2017718        reaim.time.voluntary_context_switches
>>       40000           -25.0%      30000        reaim.workload
>>       92.59            +2.6%      95.01        iostat.cpu.idle
>>        6.37           -32.9%       4.27        iostat.cpu.iowait
>>        0.97 ±  4%     -32.4%       0.65 ± 13%  iostat.cpu.system
>>        6.41            -2.1        4.29        mpstat.cpu.all.iowait%
>>        0.02 ±  6%      -0.0        0.01 ±  4%  mpstat.cpu.all.soft%
>>        0.95 ±  4%      -0.3        0.64 ± 13%  mpstat.cpu.all.sys%
>>        0.07 ±  2%      -0.0        0.06 ±  3%  mpstat.cpu.all.usr%
>>     3177396 ±  4%     -17.2%    2630192 ±  2%  numa-numastat.node0.local_node
>>     3208408 ±  3%     -17.3%    2653430 ±  3%  numa-numastat.node0.numa_hit
>>     3183435 ±  4%     -21.0%    2515397 ±  2%  numa-numastat.node1.local_node
>>     3183678 ±  4%     -20.7%    2523398 ±  2%  numa-numastat.node1.numa_hit
>>       92.00            +2.4%      94.25        vmstat.cpu.id
>>      382.00           -30.6%     265.25        vmstat.io.bi
>>       26136           -29.9%      18312        vmstat.io.bo
>>        6.00           -37.5%       3.75 ± 11%  vmstat.procs.b
>>       20123 ±  2%     -19.6%      16189        vmstat.system.cs
>>     1044628           -21.1%     824233 ±  4%  meminfo.Active
>>      758190           -28.5%     542058 ±  7%  meminfo.Active(file)
>>      163791           +76.7%     289387 ±  6%  meminfo.Inactive
>>      145927           +86.1%     271504 ±  6%  meminfo.Inactive(file)
>>       10778           -11.3%       9561 ±  2%  meminfo.PageTables
>>        9802 ±  2%     -10.0%       8822        meminfo.max_used_kB
>>      393822 ±  4%     -27.8%     284411 ±  6%  numa-meminfo.node0.Active(file)
>>       82276           +84.5%     151788 ±  6%  numa-meminfo.node0.Inactive
>>       75693 ±  6%     +88.5%     142679 ±  7%  numa-meminfo.node0.Inactive(file)
>>      507925           -30.0%     355305 ± 10%  numa-meminfo.node1.Active
>>      364589 ±  5%     -29.3%     257593 ±  8%  numa-meminfo.node1.Active(file)
>>       81386 ±  2%     +69.3%     137792 ±  7%  numa-meminfo.node1.Inactive
>>       70106 ±  5%     +84.0%     129017 ±  5%  numa-meminfo.node1.Inactive(file)
>>       50197 ±  5%     -11.4%      44453 ±  9%  numa-meminfo.node1.KReclaimable
>>       50197 ±  5%     -11.4%      44453 ±  9%  numa-meminfo.node1.SReclaimable
>>        9800           -18.9%       7948 ±  2%  slabinfo.Acpi-State.active_objs
>>        9800           -18.9%       7948 ±  2%  slabinfo.Acpi-State.num_objs
>>       61202           -10.9%      54561        slabinfo.anon_vma_chain.active_objs
>>      957.00           -10.9%     852.50        slabinfo.anon_vma_chain.active_slabs
>>       61275           -10.9%      54584        slabinfo.anon_vma_chain.num_objs
>>      957.00           -10.9%     852.50        slabinfo.anon_vma_chain.num_slabs
>>        7797           -32.6%       5252 ±  5%  slabinfo.btrfs_inode.active_objs
>>        7797           -32.6%       5252 ±  5%  slabinfo.btrfs_inode.num_objs
>>       11253 ±  3%     -18.5%       9167 ±  5%  slabinfo.kmalloc-192.active_objs
>>       11446 ±  3%     -18.2%       9362 ±  5%  slabinfo.kmalloc-192.num_objs
>>       14849 ±  2%     -24.5%      11214 ±  9%  slabinfo.mnt_cache.active_objs
>>       15056           -24.2%      11408 ±  9%  slabinfo.mnt_cache.num_objs
>>       53294           -21.2%      42015 ±  5%  slabinfo.numa_policy.active_objs
>>      864.00           -21.6%     677.50 ±  5%  slabinfo.numa_policy.active_slabs
>>       53592           -21.6%      42027 ±  5%  slabinfo.numa_policy.num_objs
>>      864.00           -21.6%     677.50 ±  5%  slabinfo.numa_policy.num_slabs
>>       98443 ±  4%     -27.7%      71126 ±  6%  numa-vmstat.node0.nr_active_file
>>      388731 ±  4%     -19.3%     313594 ±  2%  numa-vmstat.node0.nr_dirtied
>>       18914 ±  6%     +88.6%      35671 ±  7%  numa-vmstat.node0.nr_inactive_file
>>      380485 ±  4%     -18.1%     311805 ±  2%  numa-vmstat.node0.nr_written
>>       98443 ±  4%     -27.7%      71126 ±  6%  numa-vmstat.node0.nr_zone_active_file
>>       18914 ±  6%     +88.6%      35671 ±  7%  numa-vmstat.node0.nr_zone_inactive_file
>>     2280462 ±  3%     -11.6%    2015812 ±  7%  numa-vmstat.node0.numa_hit
>>     2248911 ±  3%     -11.4%    1992035 ±  7%  numa-vmstat.node0.numa_local
>>       91143 ±  5%     -29.3%      64421 ±  8%  numa-vmstat.node1.nr_active_file
>>      365567 ±  4%     -20.3%     291379 ±  4%  numa-vmstat.node1.nr_dirtied
>>       17511 ±  5%     +84.2%      32252 ±  5%  numa-vmstat.node1.nr_inactive_file
>>       12549 ±  5%     -11.4%      11114 ±  9%  numa-vmstat.node1.nr_slab_reclaimable
>>      357895 ±  4%     -19.1%     289635 ±  4%  numa-vmstat.node1.nr_written
>>       91143 ±  5%     -29.3%      64421 ±  8%  numa-vmstat.node1.nr_zone_active_file
>>       17511 ±  5%     +84.2%      32252 ±  5%  numa-vmstat.node1.nr_zone_inactive_file
>>     2266610 ±  3%     -16.4%    1894459 ±  6%  numa-vmstat.node1.numa_hit
>>     2086214 ±  3%     -18.2%    1706683 ±  6%  numa-vmstat.node1.numa_local
>>       71614            -1.5%      70550        proc-vmstat.nr_active_anon
>>      189614           -28.6%     135443 ±  7%  proc-vmstat.nr_active_file
>>       70104            -1.4%      69155        proc-vmstat.nr_anon_pages
>>     1488872           -19.1%    1204232 ±  2%  proc-vmstat.nr_dirtied
>>      523478            -4.4%     500692        proc-vmstat.nr_file_pages
>>       36441           +86.5%      67961 ±  6%  proc-vmstat.nr_inactive_file
>>       19617            -2.9%      19052        proc-vmstat.nr_kernel_stack
>>        2693           -11.3%       2390 ±  2%  proc-vmstat.nr_page_table_pages
>>       22683            -4.7%      21619        proc-vmstat.nr_slab_reclaimable
>>       50336            -3.6%      48543        proc-vmstat.nr_slab_unreclaimable
>>       89.00 ± 15%     -65.7%      30.50 ± 42%  proc-vmstat.nr_writeback
>>     1455988           -17.8%    1196186 ±  2%  proc-vmstat.nr_written
>>       71614            -1.5%      70550        proc-vmstat.nr_zone_active_anon
>>      189614           -28.6%     135443 ±  7%  proc-vmstat.nr_zone_active_file
>>       36441           +86.5%      67961 ±  6%  proc-vmstat.nr_zone_inactive_file
>>        2776 ±107%     -99.0%      28.25 ±147%  proc-vmstat.numa_hint_faults_local
>>     6417381           -18.9%    5202057        proc-vmstat.numa_hit
>>     6386111           -19.0%    5170800        proc-vmstat.numa_local
>>      306132           +14.7%     351100        proc-vmstat.pgactivate
>>     6709006           -19.1%    5428521        proc-vmstat.pgalloc_normal
>>        1457 ±  8%     -12.0%       1282 ±  3%  proc-vmstat.pgdeactivate
>>     7158861           -20.7%    5673879        proc-vmstat.pgfault
>>     6408449           -19.9%    5130409        proc-vmstat.pgfree
>>      138345           -25.7%     102836        proc-vmstat.pgpgin
>>     9452237           -25.0%    7088229 ±  3%  proc-vmstat.pgpgout
>>       26661           -20.8%      21116 ±  2%  proc-vmstat.pgrotated
>>        1844 ±  7%     -33.1%       1234 ± 12%  sched_debug.cfs_rq:/.exec_clock.avg
>>        1505 ±  7%     -38.7%     923.14 ± 14%  sched_debug.cfs_rq:/.exec_clock.min
>>       54.76 ± 10%     +33.5%      73.09 ± 14%  sched_debug.cfs_rq:/.load_avg.stddev
>>       95267 ±  6%     -10.4%      85364 ±  6%  sched_debug.cfs_rq:/.min_vruntime.max
>>        9148 ±  7%     -17.4%       7559 ± 11%  sched_debug.cfs_rq:/.min_vruntime.stddev
>>        1.75 ± 10%     +35.4%       2.36 ± 10%  sched_debug.cfs_rq:/.runnable_load_avg.avg
>>      119.14 ±  6%     +47.1%     175.24 ± 11%  sched_debug.cfs_rq:/.runnable_load_avg.max
>>       12.85 ±  5%     +45.6%      18.71 ± 11%  sched_debug.cfs_rq:/.runnable_load_avg.stddev
>>        9148 ±  7%     -17.4%       7560 ± 11%  sched_debug.cfs_rq:/.spread0.stddev
>>      111.56 ± 11%     -22.9%      86.03 ±  8%  sched_debug.cfs_rq:/.util_avg.avg
>>        1.92 ±142%     -96.3%       0.07 ±173%  sched_debug.cfs_rq:/.util_avg.min
>>       43523 ±  7%     -28.3%      31204 ±  7%  sched_debug.cpu.curr->pid.max
>>       36713 ±  7%     -21.7%      28764 ±  7%  sched_debug.cpu.nr_switches.avg
>>       81053 ±  6%     -25.8%      60160 ±  6%  sched_debug.cpu.nr_switches.max
>>       27742 ±  9%     -22.3%      21563 ±  7%  sched_debug.cpu.nr_switches.min
>>        6727 ±  5%     -21.5%       5279 ±  5%  sched_debug.cpu.nr_switches.stddev
>>       49.15 ±  9%     -25.3%      36.73 ±  5%  sched_debug.cpu.nr_uninterruptible.max
>>       21.72 ±  5%     -28.2%      15.59 ±  7%  sched_debug.cpu.nr_uninterruptible.stddev
>>       36248 ±  7%     -22.7%      28023 ±  7%  sched_debug.cpu.sched_count.avg
>>       79747 ±  6%     -26.2%      58891 ±  6%  sched_debug.cpu.sched_count.max
>>       27418 ±  9%     -23.6%      20937 ±  8%  sched_debug.cpu.sched_count.min
>>        6826 ±  5%     -23.6%       5213 ±  6%  sched_debug.cpu.sched_count.stddev
>>       17024 ±  7%     -22.6%      13178 ±  7%  sched_debug.cpu.sched_goidle.avg
>>       36338 ±  6%     -25.3%      27136 ±  6%  sched_debug.cpu.sched_goidle.max
>>       12859 ±  9%     -23.9%       9780 ±  8%  sched_debug.cpu.sched_goidle.min
>>        3065 ±  5%     -21.4%       2411 ±  6%  sched_debug.cpu.sched_goidle.stddev
>>       17247 ±  7%     -22.7%      13336 ±  7%  sched_debug.cpu.ttwu_count.avg
>>      158379 ±  8%     -26.5%     116451 ±  8%  sched_debug.cpu.ttwu_count.max
>>       10466 ±  9%     -21.9%       8171 ±  8%  sched_debug.cpu.ttwu_count.min
>>       14739 ±  8%     -26.7%      10796 ±  8%  sched_debug.cpu.ttwu_count.stddev
>>        1635 ±  8%     -18.2%       1338 ±  7%  sched_debug.cpu.ttwu_local.avg
>>       22339 ±  8%     -31.2%      15365 ±  7%  sched_debug.cpu.ttwu_local.max
>>      814.63 ± 15%     -22.1%     634.73 ±  6%  sched_debug.cpu.ttwu_local.min
>>        2155 ±  8%     -32.0%       1466 ±  7%  sched_debug.cpu.ttwu_local.stddev
>>       29.24 ± 56%     -30.4%      20.35 ± 70%  perf-stat.i.MPKI
>>   3.626e+08 ±  3%     -16.0%  3.045e+08 ±  5%  perf-stat.i.branch-instructions
>>        3.86 ± 42%      -1.0        2.85 ± 44%  perf-stat.i.branch-miss-rate%
>>    14174438 ± 36%     -36.3%    9031272 ± 32%  perf-stat.i.branch-misses
>>    47929206 ± 53%     -43.8%   26957442 ± 60%  perf-stat.i.cache-references
>>       20264 ±  2%     -19.7%      16279        perf-stat.i.context-switches
>>   6.435e+09 ± 15%     -25.7%  4.779e+09 ±  9%  perf-stat.i.cpu-cycles
>>      635.90 ±  4%     -43.7%     358.03 ±  3%  perf-stat.i.cpu-migrations
>>   4.497e+08 ±  2%     -16.5%  3.756e+08 ±  5%  perf-stat.i.dTLB-loads
>>   2.237e+08           -14.1%  1.923e+08 ±  4%  perf-stat.i.dTLB-stores
>>   1.766e+09 ±  2%     -16.5%  1.474e+09 ±  5%  perf-stat.i.instructions
>>        1312 ± 13%     -20.7%       1040 ±  9%  perf-stat.i.instructions-per-iTLB-miss
>>        0.07 ± 15%     -25.7%       0.05 ±  9%  perf-stat.i.metric.GHz
>>       11.32           -17.0%       9.39 ±  3%  perf-stat.i.metric.M/sec
>>       19413 ±  2%     -26.0%      14368 ±  2%  perf-stat.i.minor-faults
>>      852393 ±  2%     -24.3%     645664 ±  4%  perf-stat.i.node-load-misses
>>      102904 ±  3%     -33.7%      68205 ±  4%  perf-stat.i.node-loads
>>      338073 ±  2%     -25.7%     251343 ±  5%  perf-stat.i.node-store-misses
>>       64597 ± 13%     -37.7%      40227 ± 21%  perf-stat.i.node-stores
>>       19413 ±  2%     -26.0%      14368 ±  2%  perf-stat.i.page-faults
>>       27.55 ± 55%     -31.9%      18.76 ± 66%  perf-stat.overall.MPKI
>>        3.95 ± 38%      -0.9        3.01 ± 36%  perf-stat.overall.branch-miss-rate%
>>        1324 ± 14%     -20.6%       1052 ± 10%  perf-stat.overall.instructions-per-iTLB-miss
>>    15824784           +19.1%   18853609 ±  4%  perf-stat.overall.path-length
>>   3.615e+08 ±  3%     -16.0%  3.037e+08 ±  5%  perf-stat.ps.branch-instructions
>>    14134307 ± 36%     -36.3%    9007742 ± 32%  perf-stat.ps.branch-misses
>>    47797365 ± 53%     -43.7%   26888329 ± 60%  perf-stat.ps.cache-references
>>       20207 ±  2%     -19.6%      16238        perf-stat.ps.context-switches
>>   6.417e+09 ± 15%     -25.7%  4.767e+09 ±  9%  perf-stat.ps.cpu-cycles
>>      634.12 ±  4%     -43.7%     357.12 ±  3%  perf-stat.ps.cpu-migrations
>>   4.484e+08 ±  2%     -16.5%  3.746e+08 ±  4%  perf-stat.ps.dTLB-loads
>>   2.231e+08           -14.0%  1.918e+08 ±  4%  perf-stat.ps.dTLB-stores
>>   1.761e+09 ±  2%     -16.5%   1.47e+09 ±  5%  perf-stat.ps.instructions
>>       19358 ±  2%     -26.0%      14330 ±  2%  perf-stat.ps.minor-faults
>>      850011 ±  2%     -24.2%     644018 ±  4%  perf-stat.ps.node-load-misses
>>      102630 ±  3%     -33.7%      68042 ±  4%  perf-stat.ps.node-loads
>>      337128 ±  2%     -25.6%     250695 ±  5%  perf-stat.ps.node-store-misses
>>       64423 ± 13%     -37.7%      40127 ± 21%  perf-stat.ps.node-stores
>>       19358 ±  2%     -26.0%      14330 ±  2%  perf-stat.ps.page-faults
>>    6.33e+11           -10.6%  5.656e+11 ±  4%  perf-stat.total.instructions
>>      100667           -14.7%      85872        softirqs.BLOCK
>>       60141           +17.3%      70538        softirqs.CPU0.RCU
>>       63937 ±  5%     +12.6%      72018 ±  2%  softirqs.CPU10.RCU
>>       62649 ± 11%     +17.6%      73663 ±  2%  softirqs.CPU12.RCU
>>       62307 ±  4%     +13.9%      70968        softirqs.CPU13.RCU
>>       62419 ±  5%     +13.7%      70983        softirqs.CPU14.RCU
>>       60854           +15.2%      70118 ±  3%  softirqs.CPU16.RCU
>>       62245 ±  3%     +13.6%      70738 ±  3%  softirqs.CPU17.RCU
>>       62187 ±  2%     +15.2%      71660 ±  3%  softirqs.CPU18.RCU
>>       62576 ±  2%     +14.1%      71421 ±  3%  softirqs.CPU19.RCU
>>       63593 ±  5%     +14.1%      72579 ±  3%  softirqs.CPU2.RCU
>>       62793 ±  2%     +14.4%      71859 ±  2%  softirqs.CPU20.RCU
>>       61362           +15.7%      70991 ±  3%  softirqs.CPU21.RCU
>>       62651 ±  2%     +13.4%      71066 ±  4%  softirqs.CPU22.RCU
>>       62138 ±  3%     +14.9%      71384 ±  3%  softirqs.CPU23.RCU
>>       62643           +13.9%      71337 ±  4%  softirqs.CPU24.RCU
>>       60674           +16.2%      70500 ±  4%  softirqs.CPU25.RCU
>>       60125 ±  2%     +16.7%      70195 ±  4%  softirqs.CPU26.RCU
>>       61988 ±  2%     +14.5%      70986 ±  3%  softirqs.CPU27.RCU
>>       62161 ±  2%     +14.2%      71010 ±  2%  softirqs.CPU29.RCU
>>       62196 ±  2%     +14.2%      71030 ±  2%  softirqs.CPU30.RCU
>>       61878 ±  2%     +12.2%      69444 ±  4%  softirqs.CPU31.RCU
>>       63376 ±  4%     +11.7%      70774 ±  2%  softirqs.CPU33.RCU
>>       62797 ±  3%     +14.2%      71719        softirqs.CPU36.RCU
>>       63162 ±  4%     +12.3%      70932        softirqs.CPU39.RCU
>>       62956 ±  4%     +13.1%      71204 ±  2%  softirqs.CPU41.RCU
>>       61758 ±  2%     +13.6%      70144        softirqs.CPU42.RCU
>>       61374           +19.4%      73261        softirqs.CPU48.RCU
>>       63016 ±  2%     +15.4%      72724        softirqs.CPU49.RCU
>>       65073 ±  6%     +11.1%      72314        softirqs.CPU5.RCU
>>       64069 ±  5%     +15.3%      73902 ±  2%  softirqs.CPU50.RCU
>>       65325 ±  6%     +12.2%      73274        softirqs.CPU51.RCU
>>       65316 ±  6%     +11.5%      72824 ±  2%  softirqs.CPU52.RCU
>>       64811 ±  6%     +13.2%      73390        softirqs.CPU53.RCU
>>       64697 ±  6%     +13.4%      73341        softirqs.CPU54.RCU
>>       64966 ±  5%     +14.5%      74379        softirqs.CPU55.RCU
>>       65101 ±  5%     +14.2%      74361        softirqs.CPU56.RCU
>>       65644 ±  6%     +13.7%      74637 ±  2%  softirqs.CPU57.RCU
>>       64201 ±  5%     +14.7%      73664        softirqs.CPU58.RCU
>>       64557 ±  6%     +14.7%      74025 ±  2%  softirqs.CPU59.RCU
>>       64884 ±  6%     +11.7%      72453        softirqs.CPU6.RCU
>>       65105 ±  6%     +13.7%      74019        softirqs.CPU60.RCU
>>       63695 ±  3%     +15.8%      73787        softirqs.CPU61.RCU
>>       63720 ±  5%     +14.9%      73243 ±  2%  softirqs.CPU62.RCU
>>       64893 ±  5%     +14.0%      73992        softirqs.CPU63.RCU
>>       61359 ±  2%     +17.6%      72168 ±  4%  softirqs.CPU64.RCU
>>       63378 ±  3%     +13.1%      71687 ±  4%  softirqs.CPU65.RCU
>>       63198 ±  2%     +15.4%      72913 ±  3%  softirqs.CPU66.RCU
>>       62881 ±  2%     +16.2%      73041 ±  4%  softirqs.CPU67.RCU
>>       63601 ±  2%     +14.4%      72792 ±  2%  softirqs.CPU68.RCU
>>       62434           +15.3%      71994 ±  4%  softirqs.CPU69.RCU
>>       64013 ±  4%     +11.6%      71456        softirqs.CPU7.RCU
>>       62883 ±  2%     +15.2%      72467 ±  4%  softirqs.CPU70.RCU
>>       62818 ±  2%     +15.5%      72584 ±  4%  softirqs.CPU71.RCU
>>       62226           +15.1%      71598 ±  5%  softirqs.CPU72.RCU
>>       60714 ±  2%     +17.3%      71207 ±  4%  softirqs.CPU73.RCU
>>       60463 ±  2%     +18.4%      71587 ±  5%  softirqs.CPU74.RCU
>>       62460           +14.9%      71746 ±  3%  softirqs.CPU75.RCU
>>       62215 ±  2%     +16.3%      72328 ±  6%  softirqs.CPU76.RCU
>>       62743 ±  2%     +14.1%      71611 ±  3%  softirqs.CPU77.RCU
>>       62533           +14.7%      71715 ±  3%  softirqs.CPU78.RCU
>>       61946           +15.0%      71227 ±  5%  softirqs.CPU79.RCU
>>       63756 ±  6%     +13.6%      72416 ±  2%  softirqs.CPU8.RCU
>>       64308 ±  4%     +13.3%      72856        softirqs.CPU81.RCU
>>       63725 ±  3%     +14.6%      73053        softirqs.CPU85.RCU
>>       64254 ±  4%     +13.1%      72670        softirqs.CPU86.RCU
>>       63584 ±  4%     +14.1%      72546        softirqs.CPU87.RCU
>>       61794 ±  8%     +17.0%      72310 ±  2%  softirqs.CPU9.RCU
>>       62085 ±  2%     +16.1%      72067        softirqs.CPU90.RCU
>>     6086570 ±  3%     +13.5%    6907274        softirqs.RCU
>>        7.91 ± 31%      -4.9        3.00 ± 39%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>        7.90 ± 31%      -4.9        3.00 ± 39%  perf-profile.calltrace.cycles-pp.btrfs_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
>>        7.91 ± 31%      -4.9        3.01 ± 39%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>        7.91 ± 31%      -4.9        3.01 ± 39%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>        7.45 ± 33%      -4.9        2.59 ± 40%  perf-profile.calltrace.cycles-pp.btrfs_sync_file.btrfs_file_write_iter.new_sync_write.vfs_write.ksys_write
>>        6.33 ± 36%      -4.4        1.95 ± 40%  perf-profile.calltrace.cycles-pp.btrfs_log_dentry_safe.btrfs_sync_file.btrfs_file_write_iter.new_sync_write.vfs_write
>>        6.32 ± 36%      -4.4        1.95 ± 40%  perf-profile.calltrace.cycles-pp.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file.btrfs_file_write_iter.new_sync_write
>>        5.96 ± 38%      -4.3        1.66 ± 47%  perf-profile.calltrace.cycles-pp.btrfs_log_inode.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file.btrfs_file_write_iter
>>        3.74 ± 38%      -2.8        0.95 ± 70%  perf-profile.calltrace.cycles-pp.btrfs_log_changed_extents.btrfs_log_inode.btrfs_log_inode_parent.btrfs_log_dentry_safe.btrfs_sync_file
>>        3.74 ± 38%      -2.8        0.95 ± 70%  perf-profile.calltrace.cycles-pp.log_one_extent.btrfs_log_changed_extents.btrfs_log_inode.btrfs_log_inode_parent.btrfs_log_dentry_safe
>>        2.51 ± 39%      -1.9        0.56 ±100%  perf-profile.calltrace.cycles-pp.btrfs_csum_file_blocks.log_one_extent.btrfs_log_changed_extents.btrfs_log_inode.btrfs_log_inode_parent
>>        1.64 ± 17%      -0.8        0.81 ± 70%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>        1.64 ± 17%      -0.8        0.81 ± 70%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>        1.64 ± 17%      -0.8        0.81 ± 70%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>        0.85 ± 25%      -0.6        0.28 ±100%  perf-profile.calltrace.cycles-pp.btrfs_commit_transaction.iterate_supers.ksys_sync.__x64_sys_sync.do_syscall_64
>>        0.66 ± 14%      -0.4        0.27 ±100%  perf-profile.calltrace.cycles-pp.tlb_flush_mmu.tlb_finish_mmu.exit_mmap.mmput.do_exit
>>        0.66 ± 14%      -0.4        0.27 ±100%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.exit_mmap.mmput.do_exit.do_group_exit
>>        0.54 ±  4%      +0.1        0.66 ± 11%  perf-profile.calltrace.cycles-pp.hrtimer_next_event_without.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry
>>        0.96 ±  9%      +0.2        1.14 ±  8%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
>>        1.15 ±  8%      +0.2        1.38 ±  3%  perf-profile.calltrace.cycles-pp.__next_timer_interrupt.get_next_timer_interrupt.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select
>>        0.62 ± 16%      +0.3        0.90 ±  4%  perf-profile.calltrace.cycles-pp.rcu_core.__softirqentry_text_start.irq_exit.smp_apic_timer_interrupt.apic_timer_interrupt
>>        0.56 ±  6%      +0.3        0.87 ± 29%  perf-profile.calltrace.cycles-pp.load_balance.rebalance_domains.__softirqentry_text_start.irq_exit.smp_apic_timer_interrupt
>>        2.88 ±  3%      +0.3        3.22 ±  7%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt
>>        1.90 ±  3%      +0.3        2.25        perf-profile.calltrace.cycles-pp.get_next_timer_interrupt.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle
>>        2.70 ±  3%      +0.4        3.08 ±  9%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
>>        0.92 ±  6%      +0.6        1.48 ± 16%  perf-profile.calltrace.cycles-pp.rebalance_domains.__softirqentry_text_start.irq_exit.smp_apic_timer_interrupt.apic_timer_interrupt
>>        0.88 ± 41%      +0.6        1.48 ± 21%  perf-profile.calltrace.cycles-pp.tick_nohz_irq_exit.irq_exit.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state
>>        3.67 ±  7%      +0.7        4.40 ±  7%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt
>>        2.76 ±  8%      +0.8        3.57 ±  4%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry
>>        5.82 ±  3%      +0.9        6.69 ±  3%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state
>>        3.45 ±  5%      +1.0        4.43 ±  2%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry.start_secondary
>>        0.00            +1.1        1.11 ± 35%  perf-profile.calltrace.cycles-pp.btrfs_create.lookup_open.do_last.path_openat.do_filp_open
>>        0.13 ±173%      +1.1        1.26 ± 33%  perf-profile.calltrace.cycles-pp.lookup_open.do_last.path_openat.do_filp_open.do_sys_open
>>        3.18 ± 15%      +1.2        4.33 ± 12%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.irq_exit.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state
>>        0.29 ±100%      +1.2        1.44 ± 35%  perf-profile.calltrace.cycles-pp.do_last.path_openat.do_filp_open.do_sys_open.do_syscall_64
>>        0.32 ±100%      +1.2        1.52 ± 34%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>        0.32 ±100%      +1.2        1.52 ± 34%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>        0.33 ±100%      +1.2        1.54 ± 34%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>        0.00            +1.2        1.24 ± 37%  perf-profile.calltrace.cycles-pp.btrfs_unlink.vfs_unlink.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>        0.00            +1.2        1.25 ± 36%  perf-profile.calltrace.cycles-pp.vfs_unlink.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>        4.55 ± 18%      +1.8        6.38 ±  6%  perf-profile.calltrace.cycles-pp.irq_exit.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
>>        0.71 ± 11%      +1.9        2.66 ± 41%  perf-profile.calltrace.cycles-pp.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>>       17.20 ±  8%      +4.0       21.17 ±  4%  perf-profile.calltrace.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
>>       20.46 ±  9%      +4.6       25.07 ±  5%  perf-profile.calltrace.cycles-pp.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
>>        7.95 ± 31%      -4.9        3.04 ± 39%  perf-profile.children.cycles-pp.vfs_write
>>        7.95 ± 31%      -4.9        3.04 ± 39%  perf-profile.children.cycles-pp.ksys_write
>>        7.93 ± 31%      -4.9        3.03 ± 39%  perf-profile.children.cycles-pp.new_sync_write
>>        7.90 ± 31%      -4.9        3.00 ± 39%  perf-profile.children.cycles-pp.btrfs_file_write_iter
>>        7.45 ± 33%      -4.9        2.59 ± 40%  perf-profile.children.cycles-pp.btrfs_sync_file
>>        6.33 ± 36%      -4.4        1.95 ± 40%  perf-profile.children.cycles-pp.btrfs_log_dentry_safe
>>        6.32 ± 36%      -4.4        1.95 ± 40%  perf-profile.children.cycles-pp.btrfs_log_inode_parent
>>        5.96 ± 38%      -4.3        1.66 ± 47%  perf-profile.children.cycles-pp.btrfs_log_inode
>>        3.74 ± 38%      -2.7        1.07 ± 48%  perf-profile.children.cycles-pp.btrfs_log_changed_extents
>>        3.74 ± 38%      -2.7        1.07 ± 48%  perf-profile.children.cycles-pp.log_one_extent
>>        2.63 ± 38%      -1.8        0.81 ± 49%  perf-profile.children.cycles-pp.btrfs_csum_file_blocks
>>        2.59 ± 28%      -1.2        1.37 ± 33%  perf-profile.children.cycles-pp.__btrfs_drop_extents
>>        2.34 ± 28%      -1.1        1.26 ± 32%  perf-profile.children.cycles-pp.btrfs_lookup_file_extent
>>        1.07 ± 37%      -0.7        0.33 ± 52%  perf-profile.children.cycles-pp.btrfs_lookup_csum
>>        1.65 ± 16%      -0.7        0.94 ± 44%  perf-profile.children.cycles-pp.do_exit
>>        1.65 ± 16%      -0.7        0.94 ± 44%  perf-profile.children.cycles-pp.__x64_sys_exit_group
>>        1.65 ± 16%      -0.7        0.94 ± 44%  perf-profile.children.cycles-pp.do_group_exit
>>        0.65 ± 29%      -0.4        0.21 ± 27%  perf-profile.children.cycles-pp.btrfs_run_delayed_refs
>>        0.65 ± 29%      -0.4        0.21 ± 27%  perf-profile.children.cycles-pp.__btrfs_run_delayed_refs
>>        0.85 ± 16%      -0.4        0.41 ± 34%  perf-profile.children.cycles-pp.osq_lock
>>        0.60 ± 28%      -0.4        0.17 ± 29%  perf-profile.children.cycles-pp.btrfs_run_delayed_refs_for_head
>>        0.72 ± 27%      -0.4        0.32 ± 37%  perf-profile.children.cycles-pp.queued_write_lock_slowpath
>>        0.89 ± 25%      -0.4        0.50 ± 11%  perf-profile.children.cycles-pp.btrfs_commit_transaction
>>        0.84 ± 16%      -0.4        0.47 ± 32%  perf-profile.children.cycles-pp.__mutex_lock
>>        0.63 ± 45%      -0.3        0.28 ± 29%  perf-profile.children.cycles-pp.queued_read_lock_slowpath
>>        0.52 ± 25%      -0.3        0.20 ± 45%  perf-profile.children.cycles-pp.wait_log_commit
>>        0.72 ± 15%      -0.3        0.41 ± 48%  perf-profile.children.cycles-pp.tlb_flush_mmu
>>        0.72 ± 15%      -0.3        0.41 ± 48%  perf-profile.children.cycles-pp.tlb_finish_mmu
>>        0.55 ± 25%      -0.3        0.24 ± 35%  perf-profile.children.cycles-pp.btrfs_sync_log
>>        0.67 ± 15%      -0.3        0.38 ± 49%  perf-profile.children.cycles-pp.release_pages
>>        0.48 ± 30%      -0.3        0.21 ± 63%  perf-profile.children.cycles-pp.iterate_bdevs
>>        0.35 ± 29%      -0.3        0.10 ± 30%  perf-profile.children.cycles-pp.__btrfs_free_extent
>>        0.87 ± 17%      -0.3        0.62 ± 24%  perf-profile.children.cycles-pp.__handle_mm_fault
>>        0.90 ± 17%      -0.2        0.65 ± 24%  perf-profile.children.cycles-pp.handle_mm_fault
>>        0.27 ± 36%      -0.2        0.03 ±100%  perf-profile.children.cycles-pp.lookup_inline_extent_backref
>>        0.39 ± 12%      -0.2        0.16 ± 30%  perf-profile.children.cycles-pp.__do_sys_wait4
>>        0.39 ± 12%      -0.2        0.16 ± 30%  perf-profile.children.cycles-pp.kernel_wait4
>>        0.39 ± 11%      -0.2        0.15 ± 29%  perf-profile.children.cycles-pp.do_wait
>>        0.43 ± 29%      -0.2        0.23 ± 35%  perf-profile.children.cycles-pp.setup_items_for_insert
>>        0.20 ± 24%      -0.2        0.03 ±100%  perf-profile.children.cycles-pp.alloc_reserved_file_extent
>>        0.20 ± 54%      -0.2        0.05 ±106%  perf-profile.children.cycles-pp.btrfs_next_old_leaf
>>        0.28 ± 29%      -0.1        0.14 ± 45%  perf-profile.children.cycles-pp.btrfs_unlock_up_safe
>>        0.30 ± 17%      -0.1        0.15 ± 38%  perf-profile.children.cycles-pp.start_ordered_ops
>>        0.22 ± 14%      -0.1        0.10 ± 38%  perf-profile.children.cycles-pp.wait4
>>        0.19 ± 11%      -0.1        0.08 ± 27%  perf-profile.children.cycles-pp.wait_task_zombie
>>        0.19 ± 13%      -0.1        0.08 ± 27%  perf-profile.children.cycles-pp.release_task
>>        0.23 ± 23%      -0.1        0.15 ± 30%  perf-profile.children.cycles-pp.page_remove_rmap
>>        0.30 ±  7%      -0.1        0.22 ± 11%  perf-profile.children.cycles-pp.update_load_avg
>>        0.16 ± 22%      -0.1        0.09 ± 44%  perf-profile.children.cycles-pp.copy_page
>>        0.28 ± 15%      -0.1        0.21 ± 20%  perf-profile.children.cycles-pp.mmap_region
>>        0.11 ± 12%      -0.1        0.04 ±106%  perf-profile.children.cycles-pp.blk_flush_plug_list
>>        0.11 ± 13%      -0.1        0.04 ±106%  perf-profile.children.cycles-pp.blk_mq_flush_plug_list
>>        0.10 ± 10%      -0.1        0.04 ±106%  perf-profile.children.cycles-pp.blk_finish_plug
>>        0.11 ± 10%      -0.1        0.04 ±106%  perf-profile.children.cycles-pp.blk_mq_sched_insert_requests
>>        0.13 ±  8%      -0.1        0.07 ± 62%  perf-profile.children.cycles-pp.do_wp_page
>>        0.08 ± 19%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.unlock_page
>>        0.11 ±  7%      -0.1        0.06 ± 62%  perf-profile.children.cycles-pp.wp_page_copy
>>        0.18 ± 16%      -0.0        0.13 ± 11%  perf-profile.children.cycles-pp.rcu_irq_enter
>>        0.09 ± 13%      -0.0        0.05 ± 61%  perf-profile.children.cycles-pp.btrfs_submit_bio_hook
>>        0.09 ± 17%      -0.0        0.07 ± 23%  perf-profile.children.cycles-pp.__vm_munmap
>>        0.12 ± 15%      +0.0        0.16 ±  5%  perf-profile.children.cycles-pp.cpumask_next_and
>>        0.10 ±  8%      +0.0        0.14 ± 12%  perf-profile.children.cycles-pp.find_next_and_bit
>>        0.04 ± 60%      +0.0        0.09 ± 36%  perf-profile.children.cycles-pp.__btrfs_run_delayed_items
>>        0.06 ± 62%      +0.1        0.13 ± 12%  perf-profile.children.cycles-pp.tick_check_broadcast_expired
>>        0.15 ± 12%      +0.1        0.22 ±  5%  perf-profile.children.cycles-pp.call_cpuidle
>>        0.25 ±  9%      +0.1        0.33 ± 11%  perf-profile.children.cycles-pp._raw_spin_lock_irq
>>        0.00            +0.1        0.10 ± 31%  perf-profile.children.cycles-pp.btrfs_del_dir_entries_in_log
>>        0.00            +0.1        0.10 ± 52%  perf-profile.children.cycles-pp.btrfs_del_inode_ref
>>        0.00            +0.1        0.11 ± 48%  perf-profile.children.cycles-pp.btrfs_del_inode_ref_in_log
>>        0.01 ±173%      +0.1        0.14 ± 39%  perf-profile.children.cycles-pp.btrfs_lookup
>>        0.01 ±173%      +0.1        0.14 ± 39%  perf-profile.children.cycles-pp.btrfs_lookup_dentry
>>        0.56 ±  4%      +0.1        0.69 ± 11%  perf-profile.children.cycles-pp.hrtimer_next_event_without
>>        0.34 ± 13%      +0.1        0.48 ± 14%  perf-profile.children.cycles-pp.io_serial_in
>>        0.28 ± 17%      +0.1        0.43 ±  9%  perf-profile.children.cycles-pp.note_gp_changes
>>        0.79 ± 13%      +0.2        0.95 ±  6%  perf-profile.children.cycles-pp.find_next_bit
>>        1.02 ± 11%      +0.2        1.19 ±  9%  perf-profile.children.cycles-pp.scheduler_tick
>>        0.84 ±  7%      +0.2        1.06 ±  9%  perf-profile.children.cycles-pp.read_tsc
>>        1.30 ±  8%      +0.2        1.54 ±  2%  perf-profile.children.cycles-pp.__next_timer_interrupt
>>        0.34 ± 28%      +0.2        0.59 ± 18%  perf-profile.children.cycles-pp._raw_spin_trylock
>>        0.10 ± 15%      +0.2        0.35 ± 44%  perf-profile.children.cycles-pp.btrfs_orphan_add
>>        0.10 ± 15%      +0.2        0.35 ± 44%  perf-profile.children.cycles-pp.btrfs_insert_orphan_item
>>        0.64 ± 16%      +0.3        0.92 ±  4%  perf-profile.children.cycles-pp.rcu_core
>>        0.08 ± 14%      +0.3        0.36 ± 47%  perf-profile.children.cycles-pp.btrfs_del_orphan_item
>>        0.17 ± 33%      +0.3        0.47 ± 37%  perf-profile.children.cycles-pp.btrfs_insert_dir_item
>>        0.16 ± 34%      +0.3        0.46 ± 37%  perf-profile.children.cycles-pp.insert_with_overflow
>>        0.18 ± 31%      +0.3        0.49 ± 38%  perf-profile.children.cycles-pp.btrfs_add_link
>>        2.97 ±  3%      +0.3        3.29 ±  8%  perf-profile.children.cycles-pp.tick_sched_handle
>>        1.93 ±  3%      +0.3        2.28        perf-profile.children.cycles-pp.get_next_timer_interrupt
>>        2.80 ±  4%      +0.4        3.17 ±  9%  perf-profile.children.cycles-pp.update_process_times
>>        0.12 ± 29%      +0.4        0.56 ± 36%  perf-profile.children.cycles-pp.btrfs_new_inode
>>        0.15 ± 15%      +0.5        0.62 ± 33%  perf-profile.children.cycles-pp.btrfs_lookup_dir_item
>>        0.94 ±  7%      +0.5        1.49 ± 16%  perf-profile.children.cycles-pp.rebalance_domains
>>        0.24 ± 17%      +0.6        0.83 ± 35%  perf-profile.children.cycles-pp.btrfs_unlink_inode
>>        0.24 ± 16%      +0.6        0.83 ± 35%  perf-profile.children.cycles-pp.__btrfs_unlink_inode
>>        0.90 ± 41%      +0.6        1.51 ± 20%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
>>        3.79 ±  8%      +0.7        4.49 ±  8%  perf-profile.children.cycles-pp.tick_sched_timer
>>        0.33 ± 32%      +0.8        1.11 ± 35%  perf-profile.children.cycles-pp.btrfs_create
>>        2.81 ±  7%      +0.8        3.63 ±  4%  perf-profile.children.cycles-pp.tick_nohz_next_event
>>        5.99 ±  3%      +0.9        6.85 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
>>        0.37 ± 15%      +0.9        1.25 ± 36%  perf-profile.children.cycles-pp.vfs_unlink
>>        0.36 ± 14%      +0.9        1.24 ± 37%  perf-profile.children.cycles-pp.btrfs_unlink
>>        0.37 ± 30%      +0.9        1.26 ± 33%  perf-profile.children.cycles-pp.lookup_open
>>        0.65 ± 21%      +1.0        1.62 ± 33%  perf-profile.children.cycles-pp.path_openat
>>        0.65 ± 21%      +1.0        1.62 ± 33%  perf-profile.children.cycles-pp.do_filp_open
>>        3.51 ±  6%      +1.0        4.48 ±  2%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
>>        0.63 ± 23%      +1.0        1.61 ± 33%  perf-profile.children.cycles-pp.do_sys_open
>>        0.51 ± 25%      +1.0        1.49 ± 35%  perf-profile.children.cycles-pp.do_last
>>        0.34 ±  7%      +1.0        1.35 ± 43%  perf-profile.children.cycles-pp.evict
>>        0.34 ±  8%      +1.0        1.35 ± 43%  perf-profile.children.cycles-pp.btrfs_evict_inode
>>        3.50 ± 14%      +1.1        4.63 ± 10%  perf-profile.children.cycles-pp.__softirqentry_text_start
>>        4.92 ± 16%      +1.8        6.73 ±  5%  perf-profile.children.cycles-pp.irq_exit
>>        0.72 ± 11%      +1.9        2.66 ± 41%  perf-profile.children.cycles-pp.do_unlinkat
>>       17.65 ±  8%      +3.9       21.52 ±  4%  perf-profile.children.cycles-pp.smp_apic_timer_interrupt
>>       19.41 ±  9%      +4.2       23.61 ±  4%  perf-profile.children.cycles-pp.apic_timer_interrupt
>>        0.84 ± 16%      -0.4        0.41 ± 34%  perf-profile.self.cycles-pp.osq_lock
>>        0.16 ± 22%      -0.1        0.09 ± 44%  perf-profile.self.cycles-pp.copy_page
>>        0.08 ± 19%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.unlock_page
>>        0.10 ± 12%      -0.0        0.06 ± 28%  perf-profile.self.cycles-pp.update_load_avg
>>        0.04 ± 58%      +0.0        0.07 ± 12%  perf-profile.self.cycles-pp.retint_kernel
>>        0.09 ±  8%      +0.0        0.13 ±  9%  perf-profile.self.cycles-pp.find_next_and_bit
>>        0.11 ±  7%      +0.0        0.16 ± 13%  perf-profile.self.cycles-pp.sched_clock_cpu
>>        0.01 ±173%      +0.1        0.08 ± 27%  perf-profile.self.cycles-pp.run_timer_softirq
>>        0.15 ± 12%      +0.1        0.21 ±  6%  perf-profile.self.cycles-pp.call_cpuidle
>>        0.17 ± 20%      +0.1        0.24 ± 11%  perf-profile.self.cycles-pp.rcu_idle_exit
>>        0.06 ± 62%      +0.1        0.12 ± 13%  perf-profile.self.cycles-pp.tick_check_broadcast_expired
>>        0.24 ± 10%      +0.1        0.32 ± 12%  perf-profile.self.cycles-pp._raw_spin_lock_irq
>>        0.15 ± 23%      +0.1        0.25 ± 14%  perf-profile.self.cycles-pp.note_gp_changes
>>        0.18 ± 14%      +0.1        0.28 ± 14%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
>>        0.63 ±  4%      +0.1        0.73 ±  7%  perf-profile.self.cycles-pp.__next_timer_interrupt
>>        0.54 ± 14%      +0.1        0.67 ±  8%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
>>        0.34 ± 13%      +0.1        0.48 ± 14%  perf-profile.self.cycles-pp.io_serial_in
>>        0.33 ± 21%      +0.1        0.48 ± 12%  perf-profile.self.cycles-pp.__softirqentry_text_start
>>        0.52 ± 12%      +0.2        0.69 ±  4%  perf-profile.self.cycles-pp.do_idle
>>        0.81 ±  7%      +0.2        1.04 ±  9%  perf-profile.self.cycles-pp.read_tsc
>>        0.34 ± 28%      +0.2        0.58 ± 18%  perf-profile.self.cycles-pp._raw_spin_trylock
>>        2.17 ±  4%      +0.3        2.47 ±  5%  perf-profile.self.cycles-pp.cpuidle_enter_state
>>      201960           -14.9%     171842        interrupts.316:PCI-MSI.376832-edge.ahci[0000:00:17.0]
>>      308.00 ±  5%     +17.7%     362.50 ±  8%  interrupts.35:PCI-MSI.31981568-edge.i40e-0000:3d:00.0:misc
>>      151734           -13.9%     130662 ±  3%  interrupts.CAL:Function_call_interrupts
>>      114.25 ± 11%     -32.6%      77.00 ± 26%  interrupts.CPU0.TLB:TLB_shootdowns
>>      584.00           -10.5%     522.75 ±  2%  interrupts.CPU1.CAL:Function_call_interrupts
>>      343.25 ± 22%     -41.1%     202.25 ± 41%  interrupts.CPU1.NMI:Non-maskable_interrupts
>>      343.25 ± 22%     -41.1%     202.25 ± 41%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
>>      147.00 ±  7%     -42.3%      84.75 ± 18%  interrupts.CPU1.TLB:TLB_shootdowns
>>      325.25 ± 13%     -50.0%     162.75 ± 37%  interrupts.CPU10.NMI:Non-maskable_interrupts
>>      325.25 ± 13%     -50.0%     162.75 ± 37%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
>>      528.75 ±  6%     -15.4%     447.25 ±  2%  interrupts.CPU10.RES:Rescheduling_interrupts
>>      145.50 ± 10%     -37.1%      91.50 ± 19%  interrupts.CPU10.TLB:TLB_shootdowns
>>      590.75 ±  6%     -11.0%     525.50 ±  2%  interrupts.CPU11.CAL:Function_call_interrupts
>>      344.00 ± 17%     -44.7%     190.25 ± 27%  interrupts.CPU11.NMI:Non-maskable_interrupts
>>      344.00 ± 17%     -44.7%     190.25 ± 27%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
>>      548.00 ±  7%     -30.6%     380.50 ±  7%  interrupts.CPU11.RES:Rescheduling_interrupts
>>      153.25 ± 21%     -42.9%      87.50 ± 10%  interrupts.CPU11.TLB:TLB_shootdowns
>>      577.00            -9.7%     521.25        interrupts.CPU12.CAL:Function_call_interrupts
>>      305.25 ± 28%     -44.3%     170.00 ± 33%  interrupts.CPU12.NMI:Non-maskable_interrupts
>>      305.25 ± 28%     -44.3%     170.00 ± 33%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
>>      524.75 ±  8%     -14.8%     447.25 ±  6%  interrupts.CPU12.RES:Rescheduling_interrupts
>>      139.50 ±  4%     -38.7%      85.50 ±  6%  interrupts.CPU12.TLB:TLB_shootdowns
>>      601.25 ±  4%     -11.2%     534.00 ±  4%  interrupts.CPU13.CAL:Function_call_interrupts
>>      351.50 ± 17%     -46.9%     186.50 ± 29%  interrupts.CPU13.NMI:Non-maskable_interrupts
>>      351.50 ± 17%     -46.9%     186.50 ± 29%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
>>      545.75 ±  6%     -22.7%     422.00 ± 12%  interrupts.CPU13.RES:Rescheduling_interrupts
>>      164.50 ± 18%     -41.6%      96.00 ± 20%  interrupts.CPU13.TLB:TLB_shootdowns
>>      578.00 ±  2%     -11.2%     513.00        interrupts.CPU14.CAL:Function_call_interrupts
>>      339.00 ± 20%     -41.7%     197.50 ± 26%  interrupts.CPU14.NMI:Non-maskable_interrupts
>>      339.00 ± 20%     -41.7%     197.50 ± 26%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
>>      146.00 ±  7%     -48.6%      75.00 ± 15%  interrupts.CPU14.TLB:TLB_shootdowns
>>      542.50 ±  9%     -19.0%     439.25        interrupts.CPU15.RES:Rescheduling_interrupts
>>      147.75 ± 13%     -37.4%      92.50 ± 25%  interrupts.CPU15.TLB:TLB_shootdowns
>>      139.00 ± 16%     -40.3%      83.00 ± 17%  interrupts.CPU16.TLB:TLB_shootdowns
>>      605.50 ±  2%     -15.1%     514.25 ±  6%  interrupts.CPU17.CAL:Function_call_interrupts
>>      168.00 ±  8%     -54.6%      76.25 ± 39%  interrupts.CPU17.TLB:TLB_shootdowns
>>      573.25 ±  4%      -8.0%     527.50 ±  2%  interrupts.CPU2.CAL:Function_call_interrupts
>>      339.00 ± 14%     -39.3%     205.75 ± 44%  interrupts.CPU2.NMI:Non-maskable_interrupts
>>      339.00 ± 14%     -39.3%     205.75 ± 44%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
>>      875.50 ±  4%     -24.9%     657.50 ±  3%  interrupts.CPU20.RES:Rescheduling_interrupts
>>      846.25 ±  6%     -26.6%     621.00 ±  6%  interrupts.CPU21.RES:Rescheduling_interrupts
>>      811.00 ±  7%     -22.9%     625.25 ±  6%  interrupts.CPU22.RES:Rescheduling_interrupts
>>      775.50 ±  8%     -22.3%     602.50 ±  5%  interrupts.CPU23.RES:Rescheduling_interrupts
>>      115.75 ±  4%     -42.5%      66.50 ± 24%  interrupts.CPU23.TLB:TLB_shootdowns
>>        2534 ±  5%     -12.3%       2223 ± 10%  interrupts.CPU24.CAL:Function_call_interrupts
>>      691.00 ±  6%     -14.8%     588.75 ±  8%  interrupts.CPU24.RES:Rescheduling_interrupts
>>      118.00 ± 13%     -45.8%      64.00 ±  4%  interrupts.CPU24.TLB:TLB_shootdowns
>>      691.00 ±  5%     -27.6%     500.50 ±  8%  interrupts.CPU25.RES:Rescheduling_interrupts
>>        2729 ±  4%     -16.3%       2286 ±  6%  interrupts.CPU26.CAL:Function_call_interrupts
>>      692.25 ±  7%     -25.3%     517.00 ±  6%  interrupts.CPU26.RES:Rescheduling_interrupts
>>      121.50 ±  8%     -42.6%      69.75 ±  5%  interrupts.CPU26.TLB:TLB_shootdowns
>>        2606 ±  4%     -12.5%       2280 ±  3%  interrupts.CPU27.CAL:Function_call_interrupts
>>      701.50 ±  7%     -21.9%     547.75 ± 10%  interrupts.CPU27.RES:Rescheduling_interrupts
>>      146.75 ± 10%     -44.8%      81.00 ± 24%  interrupts.CPU27.TLB:TLB_shootdowns
>>        2570 ±  2%     -13.3%       2229 ±  7%  interrupts.CPU28.CAL:Function_call_interrupts
>>      672.50 ±  6%     -22.2%     523.50 ±  4%  interrupts.CPU28.RES:Rescheduling_interrupts
>>      118.00 ±  7%     -40.9%      69.75 ± 13%  interrupts.CPU28.TLB:TLB_shootdowns
>>        2675 ±  5%     -14.8%       2280 ±  7%  interrupts.CPU29.CAL:Function_call_interrupts
>>      130.00 ± 16%     -46.2%      70.00 ± 21%  interrupts.CPU29.TLB:TLB_shootdowns
>>      594.00 ±  3%     -12.8%     518.00 ±  3%  interrupts.CPU3.CAL:Function_call_interrupts
>>      156.50 ± 17%     -48.9%      80.00 ± 18%  interrupts.CPU3.TLB:TLB_shootdowns
>>        2632 ±  2%     -13.1%       2288 ±  5%  interrupts.CPU30.CAL:Function_call_interrupts
>>      676.00 ± 14%     -27.2%     492.00 ±  5%  interrupts.CPU30.RES:Rescheduling_interrupts
>>      140.50 ± 20%     -48.6%      72.25 ± 15%  interrupts.CPU30.TLB:TLB_shootdowns
>>      650.00 ±  8%     -23.9%     494.50 ±  9%  interrupts.CPU31.RES:Rescheduling_interrupts
>>      121.50 ± 13%     -36.4%      77.25 ± 15%  interrupts.CPU31.TLB:TLB_shootdowns
>>        2542 ±  3%     -11.9%       2240 ±  3%  interrupts.CPU32.CAL:Function_call_interrupts
>>      673.25 ±  9%     -19.1%     544.50 ± 16%  interrupts.CPU32.RES:Rescheduling_interrupts
>>      119.25 ± 18%     -42.8%      68.25 ±  6%  interrupts.CPU32.TLB:TLB_shootdowns
>>        2539 ±  6%     -15.3%       2151 ±  6%  interrupts.CPU33.CAL:Function_call_interrupts
>>      693.50 ±  4%     -25.3%     518.25 ± 12%  interrupts.CPU33.RES:Rescheduling_interrupts
>>      125.50 ±  4%     -42.6%      72.00 ± 17%  interrupts.CPU33.TLB:TLB_shootdowns
>>        2512 ±  3%      -9.6%       2272 ±  5%  interrupts.CPU34.CAL:Function_call_interrupts
>>      673.75 ±  6%     -24.7%     507.50 ±  9%  interrupts.CPU34.RES:Rescheduling_interrupts
>>      124.25 ± 12%     -38.2%      76.75 ± 21%  interrupts.CPU34.TLB:TLB_shootdowns
>>        2531 ±  3%     -13.8%       2181 ±  4%  interrupts.CPU35.CAL:Function_call_interrupts
>>      678.75 ±  8%     -25.0%     508.75 ±  6%  interrupts.CPU35.RES:Rescheduling_interrupts
>>      113.50 ±  8%     -34.8%      74.00 ± 10%  interrupts.CPU35.TLB:TLB_shootdowns
>>        2512 ±  3%     -13.0%       2185 ±  4%  interrupts.CPU36.CAL:Function_call_interrupts
>>      655.25 ±  6%     -18.3%     535.25 ±  9%  interrupts.CPU36.RES:Rescheduling_interrupts
>>      150.50 ± 12%     -54.3%      68.75 ± 13%  interrupts.CPU36.TLB:TLB_shootdowns
>>        2614 ±  5%     -11.7%       2308 ±  4%  interrupts.CPU37.CAL:Function_call_interrupts
>>      666.50 ±  9%     -16.7%     555.25 ±  6%  interrupts.CPU37.RES:Rescheduling_interrupts
>>      124.00 ± 14%     -41.5%      72.50 ± 16%  interrupts.CPU37.TLB:TLB_shootdowns
>>        2610 ±  5%     -14.8%       2223 ±  7%  interrupts.CPU38.CAL:Function_call_interrupts
>>      343.75 ± 16%     -25.6%     255.75 ± 10%  interrupts.CPU38.NMI:Non-maskable_interrupts
>>      343.75 ± 16%     -25.6%     255.75 ± 10%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
>>      644.50 ±  6%     -15.5%     544.50 ± 10%  interrupts.CPU38.RES:Rescheduling_interrupts
>>      600.75 ±  8%     -19.9%     481.00 ± 13%  interrupts.CPU39.RES:Rescheduling_interrupts
>>      130.50 ± 13%     -37.7%      81.25 ± 22%  interrupts.CPU39.TLB:TLB_shootdowns
>>      346.00 ± 18%     -41.8%     201.50 ± 37%  interrupts.CPU4.NMI:Non-maskable_interrupts
>>      346.00 ± 18%     -41.8%     201.50 ± 37%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
>>      553.75 ±  2%     -16.8%     460.50 ±  6%  interrupts.CPU4.RES:Rescheduling_interrupts
>>      147.50 ± 11%     -30.2%     103.00 ± 12%  interrupts.CPU4.TLB:TLB_shootdowns
>>        2573 ±  4%     -10.3%       2306 ±  4%  interrupts.CPU40.CAL:Function_call_interrupts
>>      350.00 ± 14%     -20.7%     277.50 ± 16%  interrupts.CPU40.NMI:Non-maskable_interrupts
>>      350.00 ± 14%     -20.7%     277.50 ± 16%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
>>      672.75 ±  6%     -16.2%     563.50 ±  7%  interrupts.CPU40.RES:Rescheduling_interrupts
>>      152.00 ±  8%     -47.0%      80.50 ± 18%  interrupts.CPU40.TLB:TLB_shootdowns
>>      122.25 ± 15%     -41.9%      71.00 ± 15%  interrupts.CPU41.TLB:TLB_shootdowns
>>      688.75 ±  6%     -18.8%     559.00 ± 10%  interrupts.CPU42.RES:Rescheduling_interrupts
>>      115.50 ± 16%     -34.4%      75.75 ± 19%  interrupts.CPU42.TLB:TLB_shootdowns
>>        2744 ±  7%     -15.5%       2318 ±  7%  interrupts.CPU43.CAL:Function_call_interrupts
>>      689.50 ±  7%     -17.2%     570.75 ± 10%  interrupts.CPU43.RES:Rescheduling_interrupts
>>      133.50 ± 14%     -46.4%      71.50 ± 10%  interrupts.CPU43.TLB:TLB_shootdowns
>>      678.75 ±  5%     -17.6%     559.50 ±  9%  interrupts.CPU44.RES:Rescheduling_interrupts
>>      124.00 ±  9%     -39.7%      74.75 ±  7%  interrupts.CPU44.TLB:TLB_shootdowns
>>        2729 ±  3%     -16.7%       2272 ±  6%  interrupts.CPU45.CAL:Function_call_interrupts
>>      666.50 ±  7%     -24.0%     506.25 ±  5%  interrupts.CPU45.RES:Rescheduling_interrupts
>>      132.25 ± 19%     -31.8%      90.25 ± 14%  interrupts.CPU45.TLB:TLB_shootdowns
>>        2609 ±  8%     -16.9%       2167 ±  5%  interrupts.CPU46.CAL:Function_call_interrupts
>>      641.50 ±  6%     -14.3%     549.50 ±  5%  interrupts.CPU46.RES:Rescheduling_interrupts
>>      137.50 ± 15%     -37.8%      85.50 ± 13%  interrupts.CPU46.TLB:TLB_shootdowns
>>        2603 ±  5%     -16.3%       2178 ±  7%  interrupts.CPU47.CAL:Function_call_interrupts
>>      687.00 ±  7%     -24.1%     521.75 ±  8%  interrupts.CPU47.RES:Rescheduling_interrupts
>>      146.25 ±  7%     -40.2%      87.50 ± 23%  interrupts.CPU47.TLB:TLB_shootdowns
>>      396.75 ± 11%     -26.7%     290.75 ± 11%  interrupts.CPU48.NMI:Non-maskable_interrupts
>>      396.75 ± 11%     -26.7%     290.75 ± 11%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
>>      772.75 ±  7%     -23.2%     593.50 ± 10%  interrupts.CPU48.RES:Rescheduling_interrupts
>>      111.25 ± 20%     -39.3%      67.50 ± 20%  interrupts.CPU48.TLB:TLB_shootdowns
>>      563.00           -10.7%     502.75 ±  2%  interrupts.CPU49.CAL:Function_call_interrupts
>>      375.00 ± 19%     -28.1%     269.50 ± 12%  interrupts.CPU49.NMI:Non-maskable_interrupts
>>      375.00 ± 19%     -28.1%     269.50 ± 12%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
>>      711.00 ±  6%     -24.3%     538.25 ± 11%  interrupts.CPU49.RES:Rescheduling_interrupts
>>      125.75 ± 10%     -48.3%      65.00 ± 17%  interrupts.CPU49.TLB:TLB_shootdowns
>>      367.50 ± 17%     -44.3%     204.75 ± 44%  interrupts.CPU5.NMI:Non-maskable_interrupts
>>      367.50 ± 17%     -44.3%     204.75 ± 44%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
>>      723.75 ± 50%     -37.2%     454.75 ±  8%  interrupts.CPU5.RES:Rescheduling_interrupts
>>      141.25 ±  9%     -37.2%      88.75 ±  2%  interrupts.CPU5.TLB:TLB_shootdowns
>>      547.00 ±  3%      -8.4%     501.00        interrupts.CPU50.CAL:Function_call_interrupts
>>      362.00 ± 16%     -26.5%     266.25 ± 16%  interrupts.CPU50.NMI:Non-maskable_interrupts
>>      362.00 ± 16%     -26.5%     266.25 ± 16%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
>>      699.25 ±  5%     -18.6%     569.00 ±  4%  interrupts.CPU50.RES:Rescheduling_interrupts
>>      109.50 ± 23%     -40.9%      64.75 ± 12%  interrupts.CPU50.TLB:TLB_shootdowns
>>      363.50 ± 14%     -26.3%     268.00 ± 16%  interrupts.CPU51.NMI:Non-maskable_interrupts
>>      363.50 ± 14%     -26.3%     268.00 ± 16%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
>>      707.25 ±  4%     -18.7%     574.75 ±  4%  interrupts.CPU51.RES:Rescheduling_interrupts
>>      120.00 ± 13%     -33.3%      80.00 ± 22%  interrupts.CPU51.TLB:TLB_shootdowns
>>      352.75 ± 20%     -35.9%     226.25 ± 17%  interrupts.CPU52.NMI:Non-maskable_interrupts
>>      352.75 ± 20%     -35.9%     226.25 ± 17%  interrupts.CPU52.PMI:Performance_monitoring_interrupts
>>      372.50 ± 14%     -26.2%     275.00 ± 17%  interrupts.CPU53.NMI:Non-maskable_interrupts
>>      372.50 ± 14%     -26.2%     275.00 ± 17%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
>>      646.25 ±  3%     -17.9%     530.25 ±  7%  interrupts.CPU53.RES:Rescheduling_interrupts
>>      126.25 ±  2%     -40.6%      75.00 ± 17%  interrupts.CPU53.TLB:TLB_shootdowns
>>      623.75 ±  6%     -14.4%     534.00 ±  3%  interrupts.CPU54.RES:Rescheduling_interrupts
>>      128.50 ± 14%     -34.8%      83.75 ± 32%  interrupts.CPU54.TLB:TLB_shootdowns
>>      566.75           -11.2%     503.00        interrupts.CPU55.CAL:Function_call_interrupts
>>      350.00 ± 14%     -22.5%     271.25 ±  7%  interrupts.CPU55.NMI:Non-maskable_interrupts
>>      350.00 ± 14%     -22.5%     271.25 ±  7%  interrupts.CPU55.PMI:Performance_monitoring_interrupts
>>      614.00 ±  3%     -20.9%     485.75 ±  7%  interrupts.CPU55.RES:Rescheduling_interrupts
>>      129.25 ±  8%     -49.1%      65.75 ± 17%  interrupts.CPU55.TLB:TLB_shootdowns
>>      587.50 ±  3%     -12.9%     511.75 ±  3%  interrupts.CPU56.CAL:Function_call_interrupts
>>      369.50 ± 18%     -28.8%     263.00 ±  9%  interrupts.CPU56.NMI:Non-maskable_interrupts
>>      369.50 ± 18%     -28.8%     263.00 ±  9%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
>>      623.50 ±  4%     -21.6%     488.75 ±  8%  interrupts.CPU56.RES:Rescheduling_interrupts
>>      167.00 ± 23%     -55.2%      74.75 ± 20%  interrupts.CPU56.TLB:TLB_shootdowns
>>      350.25 ± 14%     -21.5%     275.00 ± 13%  interrupts.CPU57.NMI:Non-maskable_interrupts
>>      350.25 ± 14%     -21.5%     275.00 ± 13%  interrupts.CPU57.PMI:Performance_monitoring_interrupts
>>      647.00 ±  7%     -28.9%     459.75 ±  4%  interrupts.CPU57.RES:Rescheduling_interrupts
>>      142.75 ± 17%     -31.2%      98.25 ± 13%  interrupts.CPU57.TLB:TLB_shootdowns
>>      570.25 ±  2%     -10.6%     509.75 ±  3%  interrupts.CPU58.CAL:Function_call_interrupts
>>      334.00 ± 13%     -25.4%     249.25 ± 17%  interrupts.CPU58.NMI:Non-maskable_interrupts
>>      334.00 ± 13%     -25.4%     249.25 ± 17%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
>>      606.75 ±  7%     -21.5%     476.00 ±  7%  interrupts.CPU58.RES:Rescheduling_interrupts
>>      132.75 ± 13%     -45.8%      72.00 ± 19%  interrupts.CPU58.TLB:TLB_shootdowns
>>      583.75            -9.9%     526.25 ±  3%  interrupts.CPU59.CAL:Function_call_interrupts
>>      354.00 ± 16%     -27.3%     257.50 ± 19%  interrupts.CPU59.NMI:Non-maskable_interrupts
>>      354.00 ± 16%     -27.3%     257.50 ± 19%  interrupts.CPU59.PMI:Performance_monitoring_interrupts
>>      622.25 ±  5%     -20.3%     495.75 ±  4%  interrupts.CPU59.RES:Rescheduling_interrupts
>>      146.25 ±  8%     -39.7%      88.25 ± 17%  interrupts.CPU59.TLB:TLB_shootdowns
>>      584.00           -10.3%     523.75        interrupts.CPU6.CAL:Function_call_interrupts
>>      352.00 ± 21%     -35.1%     228.50 ± 50%  interrupts.CPU6.NMI:Non-maskable_interrupts
>>      352.00 ± 21%     -35.1%     228.50 ± 50%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
>>      146.50 ±  6%     -41.3%      86.00 ± 14%  interrupts.CPU6.TLB:TLB_shootdowns
>>      594.50 ±  2%     -14.6%     507.50        interrupts.CPU60.CAL:Function_call_interrupts
>>      615.00 ±  7%     -25.5%     458.25 ±  6%  interrupts.CPU60.RES:Rescheduling_interrupts
>>      158.25 ± 11%     -52.8%      74.75 ± 10%  interrupts.CPU60.TLB:TLB_shootdowns
>>      589.75 ±  2%     -11.0%     525.00 ±  2%  interrupts.CPU61.CAL:Function_call_interrupts
>>      609.75 ±  8%     -20.9%     482.25 ±  6%  interrupts.CPU61.RES:Rescheduling_interrupts
>>      152.25 ± 11%     -42.9%      87.00 ± 12%  interrupts.CPU61.TLB:TLB_shootdowns
>>      577.50 ±  2%     -10.4%     517.50 ±  2%  interrupts.CPU62.CAL:Function_call_interrupts
>>      605.75           -23.7%     462.25 ±  7%  interrupts.CPU62.RES:Rescheduling_interrupts
>>      140.00 ± 13%     -40.7%      83.00 ± 20%  interrupts.CPU62.TLB:TLB_shootdowns
>>      576.25 ±  2%      -9.1%     523.75        interrupts.CPU63.CAL:Function_call_interrupts
>>      575.00 ±  3%     -24.8%     432.50 ±  9%  interrupts.CPU63.RES:Rescheduling_interrupts
>>      141.50 ± 16%     -39.4%      85.75 ±  9%  interrupts.CPU63.TLB:TLB_shootdowns
>>      562.25 ±  3%      -7.6%     519.25        interrupts.CPU64.CAL:Function_call_interrupts
>>      347.75 ± 12%     -23.7%     265.50 ± 10%  interrupts.CPU64.NMI:Non-maskable_interrupts
>>      347.75 ± 12%     -23.7%     265.50 ± 10%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
>>      572.25 ±  4%     -27.0%     418.00 ±  7%  interrupts.CPU64.RES:Rescheduling_interrupts
>>      124.75 ± 18%     -34.9%      81.25 ± 14%  interrupts.CPU64.TLB:TLB_shootdowns
>>      580.25 ±  4%     -13.4%     502.75 ±  5%  interrupts.CPU65.CAL:Function_call_interrupts
>>      368.75 ± 14%     -21.3%     290.25 ± 13%  interrupts.CPU65.NMI:Non-maskable_interrupts
>>      368.75 ± 14%     -21.3%     290.25 ± 13%  interrupts.CPU65.PMI:Performance_monitoring_interrupts
>>      588.00 ±  3%     -25.0%     440.75 ±  9%  interrupts.CPU65.RES:Rescheduling_interrupts
>>      142.75 ± 18%     -56.2%      62.50 ± 38%  interrupts.CPU65.TLB:TLB_shootdowns
>>      528.75 ±  7%     -19.7%     424.50 ±  7%  interrupts.CPU66.RES:Rescheduling_interrupts
>>      385.50 ±  8%     -23.2%     296.00 ± 18%  interrupts.CPU67.NMI:Non-maskable_interrupts
>>      385.50 ±  8%     -23.2%     296.00 ± 18%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
>>      551.50 ±  7%     -21.7%     432.00 ±  7%  interrupts.CPU67.RES:Rescheduling_interrupts
>>      380.25 ± 14%     -28.5%     272.00 ± 17%  interrupts.CPU68.NMI:Non-maskable_interrupts
>>      380.25 ± 14%     -28.5%     272.00 ± 17%  interrupts.CPU68.PMI:Performance_monitoring_interrupts
>>      581.75 ±  2%     -25.1%     435.50 ±  8%  interrupts.CPU68.RES:Rescheduling_interrupts
>>      113.00 ± 13%     -20.4%      90.00 ± 14%  interrupts.CPU68.TLB:TLB_shootdowns
>>      119.00 ±  9%     -39.5%      72.00 ± 13%  interrupts.CPU69.TLB:TLB_shootdowns
>>      308.00 ±  5%     +17.7%     362.50 ±  8%  interrupts.CPU7.35:PCI-MSI.31981568-edge.i40e-0000:3d:00.0:misc
>>      345.50 ± 19%     -48.5%     178.00 ± 44%  interrupts.CPU7.NMI:Non-maskable_interrupts
>>      345.50 ± 19%     -48.5%     178.00 ± 44%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
>>      132.75 ± 14%     -35.0%      86.25 ± 13%  interrupts.CPU7.TLB:TLB_shootdowns
>>      570.50 ±  2%      -9.3%     517.25 ±  3%  interrupts.CPU70.CAL:Function_call_interrupts
>>      371.75 ± 19%     -25.4%     277.50 ± 21%  interrupts.CPU70.NMI:Non-maskable_interrupts
>>      371.75 ± 19%     -25.4%     277.50 ± 21%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
>>      541.00 ±  4%     -25.6%     402.25 ±  7%  interrupts.CPU70.RES:Rescheduling_interrupts
>>      133.00 ±  9%     -44.7%      73.50 ± 11%  interrupts.CPU70.TLB:TLB_shootdowns
>>      581.50 ±  3%      -9.1%     528.50 ±  3%  interrupts.CPU71.CAL:Function_call_interrupts
>>      377.50 ± 18%     -33.7%     250.25 ± 15%  interrupts.CPU71.NMI:Non-maskable_interrupts
>>      377.50 ± 18%     -33.7%     250.25 ± 15%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
>>      536.25           -23.3%     411.25 ±  9%  interrupts.CPU71.RES:Rescheduling_interrupts
>>      161.75 ± 25%     -47.4%      85.00 ± 12%  interrupts.CPU71.TLB:TLB_shootdowns
>>        2648 ±  6%     -22.7%       2047 ±  3%  interrupts.CPU72.CAL:Function_call_interrupts
>>      681.50 ±  6%     -26.4%     501.25 ±  3%  interrupts.CPU72.RES:Rescheduling_interrupts
>>      130.75 ± 10%     -42.8%      74.75 ±  8%  interrupts.CPU72.TLB:TLB_shootdowns
>>        2619 ±  6%     -21.7%       2049 ±  8%  interrupts.CPU73.CAL:Function_call_interrupts
>>      378.75 ± 14%     -29.8%     266.00 ± 17%  interrupts.CPU73.NMI:Non-maskable_interrupts
>>      378.75 ± 14%     -29.8%     266.00 ± 17%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
>>      660.50 ± 11%     -31.3%     453.50 ± 12%  interrupts.CPU73.RES:Rescheduling_interrupts
>>      693.25 ±  7%     -30.8%     480.00 ±  6%  interrupts.CPU74.RES:Rescheduling_interrupts
>>      130.50 ± 15%     -40.4%      77.75 ± 12%  interrupts.CPU74.TLB:TLB_shootdowns
>>        2696 ±  3%     -23.8%       2055        interrupts.CPU75.CAL:Function_call_interrupts
>>      709.75 ±  3%     -26.2%     523.50 ± 10%  interrupts.CPU75.RES:Rescheduling_interrupts
>>      132.25 ± 15%     -40.3%      79.00 ± 24%  interrupts.CPU75.TLB:TLB_shootdowns
>>        2720 ±  7%     -22.2%       2117 ±  8%  interrupts.CPU76.CAL:Function_call_interrupts
>>      684.00 ±  8%     -28.4%     489.50 ±  6%  interrupts.CPU76.RES:Rescheduling_interrupts
>>      133.75 ±  7%     -47.3%      70.50 ± 12%  interrupts.CPU76.TLB:TLB_shootdowns
>>        2605           -20.7%       2065 ±  5%  interrupts.CPU77.CAL:Function_call_interrupts
>>      699.25 ±  6%     -25.3%     522.50 ± 16%  interrupts.CPU77.RES:Rescheduling_interrupts
>>      118.25 ±  5%     -36.2%      75.50 ±  9%  interrupts.CPU77.TLB:TLB_shootdowns
>>        2747 ±  7%     -23.9%       2089 ±  6%  interrupts.CPU78.CAL:Function_call_interrupts
>>      657.25 ± 11%     -22.8%     507.25 ± 17%  interrupts.CPU78.RES:Rescheduling_interrupts
>>      131.00 ±  4%     -42.7%      75.00 ± 14%  interrupts.CPU78.TLB:TLB_shootdowns
>>        2666 ±  5%     -16.0%       2239 ± 10%  interrupts.CPU79.CAL:Function_call_interrupts
>>      693.00 ± 11%     -26.2%     511.75 ± 11%  interrupts.CPU79.RES:Rescheduling_interrupts
>>      146.50 ± 18%     -48.5%      75.50 ± 13%  interrupts.CPU79.TLB:TLB_shootdowns
>>      589.25 ±  2%     -10.2%     529.00        interrupts.CPU8.CAL:Function_call_interrupts
>>      342.75 ± 20%     -52.7%     162.00 ± 35%  interrupts.CPU8.NMI:Non-maskable_interrupts
>>      342.75 ± 20%     -52.7%     162.00 ± 35%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
>>      152.50 ±  9%     -40.2%      91.25 ± 13%  interrupts.CPU8.TLB:TLB_shootdowns
>>      651.25 ±  6%     -27.8%     470.50 ± 13%  interrupts.CPU80.RES:Rescheduling_interrupts
>>      149.25 ±  9%     -55.6%      66.25 ± 17%  interrupts.CPU80.TLB:TLB_shootdowns
>>      644.25 ±  7%     -25.1%     482.75 ± 10%  interrupts.CPU81.RES:Rescheduling_interrupts
>>      135.00 ± 13%     -38.7%      82.75 ± 15%  interrupts.CPU81.TLB:TLB_shootdowns
>>        2656 ±  3%     -11.4%       2352 ±  8%  interrupts.CPU82.CAL:Function_call_interrupts
>>      669.00 ± 11%     -24.7%     504.00 ± 11%  interrupts.CPU82.RES:Rescheduling_interrupts
>>      144.50 ± 17%     -41.9%      84.00 ± 18%  interrupts.CPU82.TLB:TLB_shootdowns
>>        2587 ±  5%     -19.8%       2074 ±  7%  interrupts.CPU83.CAL:Function_call_interrupts
>>      687.25 ±  9%     -29.2%     486.25 ±  8%  interrupts.CPU83.RES:Rescheduling_interrupts
>>      126.75 ± 13%     -48.5%      65.25 ± 10%  interrupts.CPU83.TLB:TLB_shootdowns
>>        2607 ±  5%     -17.5%       2152 ±  7%  interrupts.CPU84.CAL:Function_call_interrupts
>>      133.25 ±  7%     -42.2%      77.00 ± 27%  interrupts.CPU84.TLB:TLB_shootdowns
>>        2506 ±  5%     -12.7%       2187 ±  3%  interrupts.CPU85.CAL:Function_call_interrupts
>>      667.25 ± 10%     -29.7%     469.25 ± 11%  interrupts.CPU85.RES:Rescheduling_interrupts
>>      148.50 ±  7%     -47.3%      78.25 ± 16%  interrupts.CPU85.TLB:TLB_shootdowns
>>        2691 ±  2%     -18.0%       2208 ±  9%  interrupts.CPU86.CAL:Function_call_interrupts
>>      638.75 ±  2%     -22.9%     492.25 ± 10%  interrupts.CPU86.RES:Rescheduling_interrupts
>>      132.75 ± 16%     -46.3%      71.25 ± 15%  interrupts.CPU86.TLB:TLB_shootdowns
>>        2581 ±  4%     -13.9%       2223 ±  5%  interrupts.CPU87.CAL:Function_call_interrupts
>>      339.25 ± 15%     -18.3%     277.00 ±  8%  interrupts.CPU87.NMI:Non-maskable_interrupts
>>      339.25 ± 15%     -18.3%     277.00 ±  8%  interrupts.CPU87.PMI:Performance_monitoring_interrupts
>>      659.50 ± 10%     -29.3%     466.00 ±  7%  interrupts.CPU87.RES:Rescheduling_interrupts
>>      139.75 ± 10%     -47.2%      73.75 ± 14%  interrupts.CPU87.TLB:TLB_shootdowns
>>        2689 ±  5%     -18.2%       2198 ±  9%  interrupts.CPU88.CAL:Function_call_interrupts
>>      642.75 ±  8%     -19.1%     520.25 ±  8%  interrupts.CPU88.RES:Rescheduling_interrupts
>>      143.50 ±  6%     -44.1%      80.25 ± 16%  interrupts.CPU88.TLB:TLB_shootdowns
>>        2794 ±  5%     -23.9%       2126 ±  2%  interrupts.CPU89.CAL:Function_call_interrupts
>>      361.00 ± 19%     -22.3%     280.50 ±  9%  interrupts.CPU89.NMI:Non-maskable_interrupts
>>      361.00 ± 19%     -22.3%     280.50 ±  9%  interrupts.CPU89.PMI:Performance_monitoring_interrupts
>>      695.00 ±  7%     -22.7%     537.00 ±  7%  interrupts.CPU89.RES:Rescheduling_interrupts
>>      128.25 ± 13%     -37.6%      80.00 ± 12%  interrupts.CPU89.TLB:TLB_shootdowns
>>      577.75 ±  2%      -9.1%     525.25        interrupts.CPU9.CAL:Function_call_interrupts
>>      338.75 ± 18%     -50.9%     166.25 ± 39%  interrupts.CPU9.NMI:Non-maskable_interrupts
>>      338.75 ± 18%     -50.9%     166.25 ± 39%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
>>      535.25 ±  9%     -19.0%     433.75 ± 11%  interrupts.CPU9.RES:Rescheduling_interrupts
>>      140.25 ± 10%     -37.8%      87.25 ± 12%  interrupts.CPU9.TLB:TLB_shootdowns
>>      351.25 ± 17%     -20.8%     278.25 ±  5%  interrupts.CPU90.NMI:Non-maskable_interrupts
>>      351.25 ± 17%     -20.8%     278.25 ±  5%  interrupts.CPU90.PMI:Performance_monitoring_interrupts
>>      840.25 ± 43%     -41.0%     495.75 ± 12%  interrupts.CPU90.RES:Rescheduling_interrupts
>>      129.00 ± 20%     -43.4%      73.00 ± 28%  interrupts.CPU90.TLB:TLB_shootdowns
>>      653.00 ±  6%     -23.0%     502.75 ± 11%  interrupts.CPU91.RES:Rescheduling_interrupts
>>      125.75 ±  3%     -40.0%      75.50 ± 12%  interrupts.CPU91.TLB:TLB_shootdowns
>>        2613           -20.3%       2082 ±  2%  interrupts.CPU92.CAL:Function_call_interrupts
>>      661.50 ± 10%     -28.4%     473.50 ±  9%  interrupts.CPU92.RES:Rescheduling_interrupts
>>      140.50 ±  9%     -40.2%      84.00 ± 20%  interrupts.CPU92.TLB:TLB_shootdowns
>>        2555 ±  4%     -15.7%       2155 ±  6%  interrupts.CPU93.CAL:Function_call_interrupts
>>      639.50 ±  7%     -21.4%     502.75 ±  7%  interrupts.CPU93.RES:Rescheduling_interrupts
>>      122.25 ±  7%     -33.3%      81.50 ± 16%  interrupts.CPU93.TLB:TLB_shootdowns
>>        2624           -17.8%       2156 ±  7%  interrupts.CPU94.CAL:Function_call_interrupts
>>      669.00 ±  7%     -22.3%     520.00 ± 13%  interrupts.CPU94.RES:Rescheduling_interrupts
>>      154.25 ± 13%     -52.7%      73.00 ±  6%  interrupts.CPU94.TLB:TLB_shootdowns
>>        2581 ±  6%     -19.7%       2072 ±  7%  interrupts.CPU95.CAL:Function_call_interrupts
>>      692.75 ± 12%     -29.7%     487.25 ±  8%  interrupts.CPU95.RES:Rescheduling_interrupts
>>       31535 ± 19%     -23.8%      24025 ±  9%  interrupts.NMI:Non-maskable_interrupts
>>       31535 ± 19%     -23.8%      24025 ±  9%  interrupts.PMI:Performance_monitoring_interrupts
>>       64652 ±  4%     -22.0%      50444        interrupts.RES:Rescheduling_interrupts
>>       12540 ±  5%     -39.8%       7554 ±  9%  interrupts.TLB:TLB_shootdowns
>>
>>
>>                                                                                  
>>                               reaim.time.minor_page_faults
>>                                                                                  
>>    6.4e+06 +-----------------------------------------------------------------+
>>            |.+..+.+.+.  .+.+.+.+..+.+.+.. .+. .+..+.+.+..+.      .+.+. .+..  |
>>    6.2e+06 |-+        +.                 +   +             +.+.+.     +    + |
>>      6e+06 |-+                                                               |
>>            |                                                                 |
>>    5.8e+06 |-+                                                               |
>>    5.6e+06 |-+                                                               |
>>            |                                                                 |
>>    5.4e+06 |-+                                                               |
>>    5.2e+06 |-+                                                               |
>>            |                                                                 |
>>      5e+06 |-+                                                               |
>>    4.8e+06 |-+                                                               |
>>            |    O   O          O    O        O O             O      O      O |
>>    4.6e+06 +-----------------------------------------------------------------+
>>                                                                                  
>>                                                                                                                                                                  
>>                           reaim.time.voluntary_context_switches
>>                                                                                  
>>     2.3e+06 +----------------------------------------------------------------+
>>             |       .+.+.      .+.+..+.   +    +  +.+.. .+.    .+.+.      +  |
>>    2.25e+06 |.+.+..+     +.. .+        +.+    +        +   +.+.     +.+..+   |
>>             |               +                                                |
>>     2.2e+06 |-+                                                              |
>>    2.15e+06 |-+                                                              |
>>             |                                                                |
>>     2.1e+06 |-+                                                              |
>>             |                                                                |
>>    2.05e+06 |-+                                                              |
>>       2e+06 |-+                   O                               O O O  O O |
>>             |   O  O   O O    O O          O           O   O O               |
>>    1.95e+06 |-O      O      O        O O        O   O    O                   |
>>             |                            O    O   O             O            |
>>     1.9e+06 +----------------------------------------------------------------+
>>                                                                                  
>>                                                                                                                                                                  
>>                         reaim.time.involuntary_context_switches
>>                                                                                  
>>    66000 +-------------------------------------------------------------------+
>>          |                                                                   |
>>    64000 |-+   .+.+..   .+..+.+.                .+.       +..        .+.  .+ |
>>          |.+..+      +.+        +..+. .+..+.+..+   +..+. +   +.+.+..+   +.   |
>>    62000 |-+                         +                  +                    |
>>          |                                                                   |
>>    60000 |-+                                                                 |
>>          |                                                                   |
>>    58000 |-+                                                                 |
>>          | O      O                O   O         O             O             |
>>    56000 |-+                O               O      O    O                    |
>>          |      O    O O                       O                 O           |
>>    54000 |-+  O          O    O O    O    O           O   O  O      O O O  O |
>>          |                                                                   |
>>    52000 +-------------------------------------------------------------------+
>>                                                                                  
>>                                                                                                                                                                  
>>                              reaim.time.file_system_inputs
>>                                                                                  
>>    290000 +------------------------------------------------------------------+
>>           |                   .+.                                            |
>>    280000 |.+..+.+.+..+.+.+.+.   +.+..+.+.+..+.+.+..+.+.  .+.+. .+..+.+.+..+ |
>>    270000 |-+                                           +.     +             |
>>           |                                                                  |
>>    260000 |-+                                                                |
>>    250000 |-+                                                                |
>>           |                                                                  |
>>    240000 |-+                                                                |
>>    230000 |-+                                                                |
>>           |                                                                  |
>>    220000 |-+                                                                |
>>    210000 |-+                      O                                         |
>>           | O  O O O  O O O O  O O    O O O  O O O  O O O  O O O O  O O O  O |
>>    200000 +------------------------------------------------------------------+
>>                                                                                  
>>                                                                                                                                                                  
>>                              reaim.time.file_system_outputs
>>                                                                                  
>>    1.15e+07 +----------------------------------------------------------------+
>>             |                                     +.                         |
>>     1.1e+07 |-+         .+..                      : +..  +                 + |
>>             |.+.  .+.+.+    +.+. .+..+. .+    +  :      + + .+..+.+.+.+.. +  |
>>    1.05e+07 |-+ +.              +      +  + .. + :     +   +             +   |
>>             |                              +    +                            |
>>       1e+07 |-+                                                              |
>>             |                                                                |
>>     9.5e+06 |-+                                                              |
>>             |                                                                |
>>       9e+06 |-+      O               O   O        O             O            |
>>             | O               O               O O   O    O                   |
>>     8.5e+06 |-+ O  O            O O    O   O           O   O      O O O  O O |
>>             |          O O  O                                O               |
>>       8e+06 +----------------------------------------------------------------+
>>                                                                                  
>>                                                                                                                                                                  
>>                                   reaim.parent_time
>>                                                                                  
>>    140 +---------------------------------------------------------------------+
>>        |         O                                                           |
>>    130 |-+                        O        O  O O O    O                     |
>>        | O         O      O           O                        O O      O    |
>>        |      O      O  O      O    O    O                         O  O    O |
>>    120 |-+  O                O                       O    O O                |
>>        |                                                                     |
>>    110 |-+                                                                   |
>>        |                                                                     |
>>    100 |-+                                                                   |
>>        |                                                                     |
>>        |                                        +.                           |
>>     90 |-+   .+..   .+..+.+..+.      .+.. .+.. +  +..             .+..    .+ |
>>        |.+..+    +.+           +..+.+    +    +      +.+..+.+..+.+    +.+.   |
>>     80 +---------------------------------------------------------------------+
>>                                                                                  
>>                                                                                                                                                                  
>>                                  reaim.jobs_per_min
>>                                                                                  
>>    7500 +--------------------------------------------------------------------+
>>         |                                                                    |
>>    7000 |.+..+.  .+.+.         .+.+..+. .+.. .+    +.+..+.+.+..+.+.  .+.+..  |
>>         |      +.     +..+.+.+.        +    +  + ..                +.      + |
>>    6500 |-+                                     +                            |
>>         |                                                                    |
>>    6000 |-+                                                                  |
>>         |                                                                    |
>>    5500 |-+                                                                  |
>>         |                                                                    |
>>    5000 |-+  O O      O  O   O  O    O               O    O O                |
>>         | O         O      O           O O         O    O      O O O  O O  O |
>>    4500 |-+       O               O         O O O                            |
>>         |                                                                    |
>>    4000 +--------------------------------------------------------------------+
>>                                                                                  
>>                                                                                                                                                                  
>>                              reaim.jobs_per_min_child
>>                                                                                  
>>    75 +----------------------------------------------------------------------+
>>       |                                                                      |
>>    70 |.+..+.  .+.+..        .+..+.+.. .+.. .+..  +..+.+.+..+.+..+.  .+.+..  |
>>       |      +.      +.+..+.+         +    +     +                 +.      + |
>>    65 |-+                                       +                            |
>>       |                                                                      |
>>    60 |-+                                                                    |
>>       |                                                                      |
>>    55 |-+                                                                    |
>>       |                                                                      |
>>    50 |-+  O O       O O    O O    O                 O   O  O                |
>>       | O         O       O           O O         O    O      O  O O  O O  O |
>>    45 |-+       O                O         O O  O                            |
>>       |                                                                      |
>>    40 +----------------------------------------------------------------------+
>>                                                                                  
>>                                                                                                                                                                  
>>                                 reaim.std_dev_time
>>                                                                                  
>>    7 +-----------------------------------------------------------------------+
>>      |                                                                       |
>>    6 |-+         O                                               O           |
>>      |                                  O                             O      |
>>    5 |-+              O  O    O    O         O                     O    O  O |
>>      |    O O                        O    O    O  O    O    O                |
>>    4 |-O       O    O           O                   O    O                   |
>>      |                     O                                  O              |
>>    3 |-+                                                                     |
>>      |                                                                       |
>>    2 |-+                                                                     |
>>      |                                                                       |
>>    1 |.+.. .+..+.+..+.+..+.+..+.+..+.+..+.+..+.+..+.+..+.  .+.+..+.+..+.+..+ |
>>      |    +                                              +.                  |
>>    0 +-----------------------------------------------------------------------+
>>                                                                                  
>>                                                                                                                                                                  
>>                                 reaim.std_dev_percent
>>                                                                                  
>>    5.5 +---------------------------------------------------------------------+
>>      5 |-+         O                                                         |
>>        |                                 O                       O    O      |
>>    4.5 |-+              O      O                                   O    O  O |
>>      4 |-+  O O           O         O         O             O                |
>>        |                              O    O      O  O O  O                  |
>>    3.5 |-O       O   O            O             O                            |
>>      3 |-+                   O                                               |
>>    2.5 |-+                                                     O             |
>>        |                                                                     |
>>      2 |-+                                                                   |
>>    1.5 |-+                                                                   |
>>        |            .+..+.    .+..      .+.  .+. .+..                     .+ |
>>      1 |.+..+.+..+.+      +..+    +.+.+.   +.   +    +.+..+.+..+.+.+..+.+.   |
>>    0.5 +---------------------------------------------------------------------+
>>                                                                                  
>>                                                                                                                                                                  
>>                                       reaim.jti
>>                                                                                  
>>      99 +--------------------------------------------------------------------+
>>    98.5 |.+..+.+..+.+.    .+.    .+..+.+.  .+. .+.. .+..+        +.+..+.+..+ |
>>         |             +..+   +..+        +.   +    +                         |
>>      98 |-+                                                                  |
>>    97.5 |-+                                                                  |
>>         |                                                                    |
>>      97 |-+                                                                  |
>>    96.5 |-O       O          O    O                            O             |
>>      96 |-+                                     O                            |
>>         |    O O      O    O           O    O      O O  O O                  |
>>    95.5 |-+                          O        O             O      O    O    |
>>      95 |-+              O      O                                          O |
>>         |                                O                            O      |
>>    94.5 |-+         O                                            O           |
>>      94 +--------------------------------------------------------------------+
>>                                                                                  
>>                                                                                                                                                                  
>>                                reaim.max_jobs_per_min
>>                                                                                  
>>    7500 +--------------------------------------------------------------------+
>>         |.+..                   +.                                           |
>>    7000 |-+  +.  .+.+         ..  +..+. .+.. .+    +.+..+.+.+..+.+.  .+.+..  |
>>         |      +.    +  .+. .+         +    +  + ..                +.      + |
>>         |             +.   +                    +                            |
>>    6500 |-+                                                                  |
>>         |                                                                    |
>>    6000 |-+                                                                  |
>>         |                                                                    |
>>    5500 |-+                                                                  |
>>         |                                                                    |
>>         |    O O      O      O       O               O    O O         O      |
>>    5000 |-O              O O    O        O  O                      O    O  O |
>>         |         O O             O    O      O    O    O      O O           |
>>    4500 +--------------------------------------------------------------------+
>>                                                                                  
>>                                                                                                                                                                  
>>                                     reaim.workload
>>                                                                                  
>>    40000 +-------------------------------------------------------------------+
>>          |                                                                   |
>>          |                                                                   |
>>    38000 |-+                                                                 |
>>          |                                                                   |
>>          |                                                                   |
>>    36000 |-+                                                                 |
>>          |                                                                   |
>>    34000 |-+                                                                 |
>>          |                                                                   |
>>          |                                                                   |
>>    32000 |-+                                                                 |
>>          |                                                                   |
>>          |                                                                   |
>>    30000 +-------------------------------------------------------------------+
>>                                                                                  
>>                                                                                  
>> [*] bisect-good sample
>> [O] bisect-bad  sample
>>
>>
>>
>> Disclaimer:
>> Results have been estimated based on internal Intel analysis and are provided
>> for informational purposes only. Any difference in system hardware or software
>> design or configuration may affect actual performance.
>>
>>
>> Thanks,
>> Rong Chen
>>

