Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32093C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 03:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED1552078A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 03:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgFODbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 23:31:47 -0400
Received: from mga18.intel.com ([134.134.136.126]:54403 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727946AbgFODbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 23:31:47 -0400
IronPort-SDR: XCQhc92jseJPq+ZR2KMKBWCbqeI89irapCviXkqd0tDvAgixdTh4C4/bsmGtL/mqh20ElsgU9f
 04el29/ZhD/Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2020 20:21:35 -0700
IronPort-SDR: hylrT828nNo9v2ogCYZwVTDSggOrGC+boiGi6niQ735eEafDbiEXF3Wlew+mlJBv55Ox1KArXD
 pihHDMjKQTzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,513,1583222400"; 
   d="scan'208";a="382390652"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.238.6.47]) ([10.238.6.47])
  by fmsmga001.fm.intel.com with ESMTP; 14 Jun 2020 20:21:33 -0700
Subject: Re: [LKP] [btrfs] c75e839414: aim7.jobs-per-min -9.1% regression
To:     kernel test robot <rong.a.chen@intel.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200612061144.GM12456@shao2-debian>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <cc74fe05-da4e-ba65-a2e9-8df742627445@linux.intel.com>
Date:   Mon, 15 Jun 2020 11:21:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200612061144.GM12456@shao2-debian>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josef,

    Do you have time to take a look at this? Thanks.

On 6/12/2020 2:11 PM, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -9.1% regression of aim7.jobs-per-min due to commit:
> 
> 
> commit: c75e839414d3610e6487ae3145199c500d55f7f7 ("btrfs: kill the subvol_srcu")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: aim7
> on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
> with following parameters:
> 
> 	disk: 4BRD_12G
> 	md: RAID0
> 	fs: btrfs
> 	test: disk_wrt
> 	load: 1500
> 	cpufreq_governor: performance
> 	ucode: 0x500002c
> 
> test-description: AIM7 is a traditional UNIX system level benchmark suite which is used to test and measure the performance of multiuser system.
> test-url: https://sourceforge.net/projects/aimbench/files/aim-suite7/
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
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
> compiler/cpufreq_governor/disk/fs/kconfig/load/md/rootfs/tbox_group/test/testcase/ucode:
>    gcc-7/performance/4BRD_12G/btrfs/x86_64-rhel-7.6/1500/RAID0/debian-x86_64-20191114.cgz/lkp-csl-2ap2/disk_wrt/aim7/0x500002c
> 
> commit:
>    efc3453494 ("btrfs: make btrfs_cleanup_fs_roots use the radix tree lock")
>    c75e839414 ("btrfs: kill the subvol_srcu")
> 
> efc3453494af7818 c75e839414d3610e6487ae31451
> ---------------- ---------------------------
>         fail:runs  %reproduction    fail:runs
>             |             |             |
>            3:9          -33%            :8     dmesg.WARNING:at#for_ip_swapgs_restore_regs_and_return_to_usermode/0x
>           %stddev     %change         %stddev
>               \          |                \
>       29509 ±  2%      -9.1%      26837 ±  2%  aim7.jobs-per-min
>      305.28 ±  2%     +10.0%     335.72 ±  2%  aim7.time.elapsed_time
>      305.28 ±  2%     +10.0%     335.72 ±  2%  aim7.time.elapsed_time.max
>     4883135 ± 10%     +37.9%    6735464 ±  7%  aim7.time.involuntary_context_switches
>       56288 ±  2%     +10.5%      62202 ±  2%  aim7.time.system_time
>     2344783            +6.5%    2497364 ±  2%  aim7.time.voluntary_context_switches
>    62337721 ±  2%      +9.8%   68456490 ±  2%  turbostat.IRQ
>      431.56 ±  6%     +22.3%     527.88 ±  4%  vmstat.procs.r
>       27340 ±  2%     +11.2%      30397 ±  2%  vmstat.system.cs
>      226804 ±  6%     +21.7%     276057 ±  4%  meminfo.Active(file)
>      221309 ±  6%     +22.3%     270668 ±  4%  meminfo.Dirty
>      720.89 ±111%     +49.3%       1076 ± 73%  meminfo.Mlocked
>       14278 ±  2%      -8.3%      13094 ±  2%  meminfo.max_used_kB
>       57228 ±  6%     +22.7%      70195 ±  5%  numa-meminfo.node0.Active(file)
>       55433 ±  6%     +21.6%      67431 ±  4%  numa-meminfo.node0.Dirty
>       56152 ±  6%     +21.4%      68180 ±  5%  numa-meminfo.node1.Active(file)
>       55001 ±  6%     +22.5%      67397 ±  4%  numa-meminfo.node1.Dirty
>       56373 ±  6%     +21.7%      68594 ±  4%  numa-meminfo.node2.Active(file)
>       55222 ±  7%     +22.6%      67726 ±  4%  numa-meminfo.node2.Dirty
>       56671 ±  6%     +20.5%      68317 ±  3%  numa-meminfo.node3.Active(file)
>       55285 ±  6%     +21.8%      67355 ±  4%  numa-meminfo.node3.Dirty
>       56694 ±  6%     +21.7%      69019 ±  4%  proc-vmstat.nr_active_file
>       55342 ±  6%     +22.3%      67662 ±  4%  proc-vmstat.nr_dirty
>      402316            +2.1%     410951        proc-vmstat.nr_file_pages
>      180.22 ±111%     +49.4%     269.25 ± 73%  proc-vmstat.nr_mlock
>       56694 ±  6%     +21.7%      69019 ±  4%  proc-vmstat.nr_zone_active_file
>       54680 ±  6%     +22.8%      67168 ±  4%  proc-vmstat.nr_zone_write_pending
>     3144381 ±  2%      +6.1%    3335275        proc-vmstat.pgactivate
>     1387558 ±  2%      +7.9%    1496754 ±  2%  proc-vmstat.pgfault
>      983.33 ±  4%      +5.4%       1036        proc-vmstat.unevictable_pgs_culled
>       14331 ±  6%     +22.6%      17566 ±  5%  numa-vmstat.node0.nr_active_file
>       13884 ±  6%     +21.6%      16884 ±  4%  numa-vmstat.node0.nr_dirty
>       14330 ±  6%     +22.6%      17566 ±  5%  numa-vmstat.node0.nr_zone_active_file
>       13714 ±  6%     +22.2%      16755 ±  4%  numa-vmstat.node0.nr_zone_write_pending
>       14047 ±  6%     +21.3%      17043 ±  4%  numa-vmstat.node1.nr_active_file
>       13763 ±  6%     +22.3%      16838 ±  4%  numa-vmstat.node1.nr_dirty
>       14047 ±  6%     +21.3%      17043 ±  4%  numa-vmstat.node1.nr_zone_active_file
>       13599 ±  6%     +23.0%      16726 ±  4%  numa-vmstat.node1.nr_zone_write_pending
>       14074 ±  5%     +21.7%      17130 ±  4%  numa-vmstat.node2.nr_active_file
>       13786 ±  6%     +22.6%      16906 ±  4%  numa-vmstat.node2.nr_dirty
>       14074 ±  5%     +21.7%      17130 ±  4%  numa-vmstat.node2.nr_zone_active_file
>       13617 ±  7%     +23.3%      16789 ±  4%  numa-vmstat.node2.nr_zone_write_pending
>       14151 ±  6%     +20.7%      17074 ±  3%  numa-vmstat.node3.nr_active_file
>       13790 ±  6%     +22.1%      16832 ±  4%  numa-vmstat.node3.nr_dirty
>       14152 ±  6%     +20.7%      17074 ±  3%  numa-vmstat.node3.nr_zone_active_file
>       13627 ±  6%     +22.5%      16696 ±  4%  numa-vmstat.node3.nr_zone_write_pending
>      828631 ± 16%     +49.9%    1241934 ±  8%  sched_debug.cfs_rq:/.min_vruntime.stddev
>        1.33 ± 30%     +96.9%       2.61 ± 14%  sched_debug.cfs_rq:/.nr_spread_over.avg
>      831152 ± 16%     +49.7%    1244586 ±  8%  sched_debug.cfs_rq:/.spread0.stddev
>        1.92 ± 14%     +28.4%       2.47 ±  8%  sched_debug.cpu.nr_running.avg
>        5.00 ±  9%     +29.7%       6.48 ±  9%  sched_debug.cpu.nr_running.max
>        0.90 ±  9%     +16.0%       1.05 ±  3%  sched_debug.cpu.nr_running.stddev
>       21790 ± 11%     +16.7%      25440 ±  2%  sched_debug.cpu.nr_switches.avg
>       19761 ± 11%     +17.9%      23289 ±  2%  sched_debug.cpu.nr_switches.min
>       20403 ± 12%     +18.1%      24101 ±  2%  sched_debug.cpu.sched_count.avg
>       27825 ± 10%     +15.8%      32227 ±  4%  sched_debug.cpu.sched_count.max
>       18995 ± 13%     +18.3%      22463 ±  2%  sched_debug.cpu.sched_count.min
>        1143 ± 11%     +15.6%       1322 ±  4%  sched_debug.cpu.sched_count.stddev
>        1404 ±  7%     -31.0%     969.66 ± 11%  sched_debug.cpu.sched_goidle.avg
>        1186 ±  8%     -36.0%     759.25 ± 14%  sched_debug.cpu.sched_goidle.min
>       16821 ± 14%     +20.6%      20284 ±  6%  sched_debug.cpu.ttwu_count.max
>        2790 ± 11%     +21.7%       3395 ±  7%  sched_debug.cpu.ttwu_count.stddev
>      398.19 ± 16%     +28.3%     510.73 ± 10%  sched_debug.cpu.ttwu_local.stddev
>    43238516 ±  5%     +19.0%   51459028 ±  4%  perf-stat.i.cache-misses
>    83870573 ±  4%     +13.8%   95436555 ±  4%  perf-stat.i.cache-references
>       27181 ±  2%     +11.1%      30198 ±  2%  perf-stat.i.context-switches
>        3008 ±  2%      -7.1%       2794        perf-stat.i.cpu-migrations
>       12612 ±  5%     -15.6%      10641 ±  3%  perf-stat.i.cycles-between-cache-misses
>     1.1e+09 ±  2%      -7.3%  1.019e+09 ±  2%  perf-stat.i.dTLB-stores
>    10684629 ±  2%     +10.8%   11842781 ±  2%  perf-stat.i.node-load-misses
>      641429 ±  2%     +24.4%     798190 ±  2%  perf-stat.i.node-loads
>     5915955 ±  2%      -6.3%    5543368 ±  2%  perf-stat.i.node-store-misses
>      380971            -6.7%     355629 ±  2%  perf-stat.i.node-stores
>        1.66 ±  4%     +14.4%       1.90 ±  3%  perf-stat.overall.MPKI
>       13064 ±  5%     -15.8%      10999 ±  4%  perf-stat.overall.cycles-between-cache-misses
>    43484558 ±  5%     +19.2%   51837476 ±  4%  perf-stat.ps.cache-misses
>    83278267 ±  4%     +14.4%   95253129 ±  3%  perf-stat.ps.cache-references
>       27414 ±  2%     +11.2%      30486 ±  2%  perf-stat.ps.context-switches
>        3028 ±  2%      -7.0%       2817        perf-stat.ps.cpu-migrations
>   1.104e+09 ±  2%      -7.3%  1.023e+09 ±  2%  perf-stat.ps.dTLB-stores
>        4394            -1.8%       4315        perf-stat.ps.minor-faults
>    10766873 ±  2%     +11.0%   11947268 ±  2%  perf-stat.ps.node-load-misses
>      645940 ±  2%     +24.7%     805392 ±  2%  perf-stat.ps.node-loads
>     5965618 ±  2%      -6.2%    5595562 ±  2%  perf-stat.ps.node-store-misses
>      383092            -6.5%     358124 ±  2%  perf-stat.ps.node-stores
>        4395            -1.8%       4315        perf-stat.ps.page-faults
>   1.538e+13 ±  2%     +10.0%  1.692e+13 ±  2%  perf-stat.total.instructions
>       27.39            -0.1       27.28        perf-profile.calltrace.cycles-pp.btrfs_dirty_pages.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write
>       35.13            +0.1       35.23        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write
>       35.23            +0.1       35.34        perf-profile.calltrace.cycles-pp._raw_spin_lock.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter
>       35.48            +0.1       35.60        perf-profile.calltrace.cycles-pp.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
>       35.08            +0.1       35.22        perf-profile.calltrace.cycles-pp._raw_spin_lock.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_buffered_write.btrfs_file_write_iter
>       34.97            +0.1       35.12        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_buffered_write
>       35.57            +0.1       35.72        perf-profile.calltrace.cycles-pp.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write
>       35.10            +0.2       35.26        perf-profile.calltrace.cycles-pp.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
>       35.11            +0.2       35.27        perf-profile.calltrace.cycles-pp.btrfs_inode_rsv_release.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write
>       98.71            +0.2       98.88        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>       98.69            +0.2       98.87        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>       98.74            +0.2       98.91        perf-profile.calltrace.cycles-pp.write
>       98.71            +0.2       98.89        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
>       98.68            +0.2       98.86        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>       98.64            +0.2       98.82        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       98.63            +0.2       98.81        perf-profile.calltrace.cycles-pp.btrfs_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
>       98.58            +0.2       98.77        perf-profile.calltrace.cycles-pp.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write.ksys_write
>       27.39            -0.1       27.28        perf-profile.children.cycles-pp.btrfs_dirty_pages
>        0.56 ±  5%      -0.1        0.46 ±  9%  perf-profile.children.cycles-pp.btrfs_get_extent
>        0.51 ±  5%      -0.1        0.41 ±  9%  perf-profile.children.cycles-pp.btrfs_lookup_file_extent
>        0.52 ±  5%      -0.1        0.43 ±  9%  perf-profile.children.cycles-pp.btrfs_search_slot
>        0.44 ±  6%      -0.1        0.35 ± 11%  perf-profile.children.cycles-pp.btrfs_read_lock_root_node
>        0.43 ±  6%      -0.1        0.34 ± 11%  perf-profile.children.cycles-pp.btrfs_tree_read_lock
>        0.19 ± 15%      -0.1        0.11 ± 27%  perf-profile.children.cycles-pp.start_secondary
>        0.19 ± 16%      -0.1        0.10 ± 27%  perf-profile.children.cycles-pp.cpuidle_enter
>        0.19 ± 16%      -0.1        0.10 ± 27%  perf-profile.children.cycles-pp.cpuidle_enter_state
>        0.41 ±  7%      -0.1        0.33 ±  8%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
>        0.46 ±  7%      -0.1        0.38 ±  8%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
>        0.19 ± 15%      -0.1        0.11 ± 25%  perf-profile.children.cycles-pp.secondary_startup_64
>        0.19 ± 15%      -0.1        0.11 ± 25%  perf-profile.children.cycles-pp.cpu_startup_entry
>        0.19 ± 15%      -0.1        0.11 ± 25%  perf-profile.children.cycles-pp.do_idle
>        0.18 ± 15%      -0.1        0.10 ± 24%  perf-profile.children.cycles-pp.intel_idle
>        0.29 ±  9%      -0.1        0.22 ± 11%  perf-profile.children.cycles-pp.osq_lock
>        0.19 ±  6%      -0.0        0.15 ± 16%  perf-profile.children.cycles-pp.finish_wait
>        0.39 ±  5%      -0.0        0.35 ±  6%  perf-profile.children.cycles-pp.do_unlinkat
>        0.39 ±  6%      -0.0        0.35 ±  7%  perf-profile.children.cycles-pp.unlink
>        0.26 ±  5%      -0.0        0.22 ±  6%  perf-profile.children.cycles-pp.do_sys_open
>        0.26 ±  5%      -0.0        0.22 ±  6%  perf-profile.children.cycles-pp.do_sys_openat2
>        0.26 ±  4%      -0.0        0.22 ±  6%  perf-profile.children.cycles-pp.do_filp_open
>        0.26 ±  4%      -0.0        0.22 ±  6%  perf-profile.children.cycles-pp.path_openat
>        0.26 ±  4%      -0.0        0.22 ±  6%  perf-profile.children.cycles-pp.creat
>        0.00            +0.0        0.05        perf-profile.children.cycles-pp.btrfs_calculate_inode_block_rsv_size
>       99.65            +0.1       99.73        perf-profile.children.cycles-pp.do_syscall_64
>       99.66            +0.1       99.74        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>       35.62            +0.1       35.74        perf-profile.children.cycles-pp.btrfs_reserve_metadata_bytes
>       35.57            +0.1       35.72        perf-profile.children.cycles-pp.btrfs_delalloc_reserve_metadata
>       97.55            +0.2       97.72        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>       98.74            +0.2       98.92        perf-profile.children.cycles-pp.write
>       98.70            +0.2       98.88        perf-profile.children.cycles-pp.ksys_write
>       98.69            +0.2       98.87        perf-profile.children.cycles-pp.vfs_write
>       98.65            +0.2       98.83        perf-profile.children.cycles-pp.new_sync_write
>       98.63            +0.2       98.81        perf-profile.children.cycles-pp.btrfs_file_write_iter
>       98.59            +0.2       98.78        perf-profile.children.cycles-pp.btrfs_buffered_write
>       97.60            +0.2       97.79        perf-profile.children.cycles-pp._raw_spin_lock
>        0.18 ± 15%      -0.1        0.10 ± 24%  perf-profile.self.cycles-pp.intel_idle
>        0.28 ±  9%      -0.1        0.21 ± 12%  perf-profile.self.cycles-pp.osq_lock
>        0.45 ±  2%      -0.0        0.41 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
>      135788 ±  2%     +13.1%     153639 ±  3%  softirqs.CPU0.RCU
>      115547 ±  3%      +8.0%     124768 ±  4%  softirqs.CPU0.TIMER
>      135243 ±  3%     +14.0%     154188 ±  2%  softirqs.CPU1.RCU
>      136056 ±  3%     +12.4%     152960 ±  3%  softirqs.CPU10.RCU
>      134253 ±  3%     +14.2%     153260 ±  3%  softirqs.CPU100.RCU
>      134668 ±  4%     +13.7%     153157 ±  2%  softirqs.CPU101.RCU
>      109995 ±  3%      +7.9%     118637 ±  3%  softirqs.CPU101.TIMER
>      134989 ±  4%     +13.9%     153700 ±  2%  softirqs.CPU102.RCU
>      109876 ±  3%      +8.9%     119608 ±  2%  softirqs.CPU102.TIMER
>      134868 ±  4%     +13.8%     153427 ±  3%  softirqs.CPU103.RCU
>      109933 ±  3%      +8.2%     118946 ±  3%  softirqs.CPU103.TIMER
>      134454 ±  3%     +14.0%     153285 ±  3%  softirqs.CPU104.RCU
>      109731 ±  2%      +8.4%     118965 ±  3%  softirqs.CPU104.TIMER
>      134878 ±  3%     +13.6%     153283 ±  3%  softirqs.CPU105.RCU
>      134096 ±  3%     +14.1%     153022 ±  3%  softirqs.CPU106.RCU
>      109821 ±  2%      +8.2%     118845 ±  3%  softirqs.CPU106.TIMER
>      133905 ±  3%     +15.0%     154004 ±  3%  softirqs.CPU107.RCU
>      134117 ±  3%     +14.3%     153232 ±  3%  softirqs.CPU108.RCU
>      109545 ±  2%      +8.8%     119182 ±  3%  softirqs.CPU108.TIMER
>      134574 ±  3%     +13.8%     153202 ±  3%  softirqs.CPU109.RCU
>      109804 ±  3%      +8.2%     118760 ±  3%  softirqs.CPU109.TIMER
>      135106 ±  3%     +14.8%     155124 ±  3%  softirqs.CPU11.RCU
>      111746 ±  4%      +7.8%     120460 ±  3%  softirqs.CPU11.TIMER
>      134482 ±  4%     +14.3%     153687 ±  3%  softirqs.CPU110.RCU
>      110314 ±  3%      +8.1%     119241 ±  3%  softirqs.CPU110.TIMER
>      134464 ±  3%     +14.3%     153634 ±  3%  softirqs.CPU111.RCU
>      110626 ±  3%      +8.3%     119815 ±  3%  softirqs.CPU111.TIMER
>      134895 ±  3%     +14.4%     154257 ±  3%  softirqs.CPU112.RCU
>      110040 ±  3%     +14.6%     126058 ± 16%  softirqs.CPU112.TIMER
>      134644 ±  3%     +13.6%     152993 ±  3%  softirqs.CPU113.RCU
>      109693 ±  3%      +8.1%     118569 ±  3%  softirqs.CPU113.TIMER
>      134313 ±  3%     +13.9%     152993 ±  3%  softirqs.CPU114.RCU
>      109711 ±  3%      +8.6%     119143 ±  3%  softirqs.CPU114.TIMER
>      134559 ±  3%     +13.8%     153115 ±  3%  softirqs.CPU115.RCU
>      110226 ±  3%      +8.2%     119221 ±  3%  softirqs.CPU115.TIMER
>      134087 ±  3%     +14.2%     153077 ±  3%  softirqs.CPU116.RCU
>      110225 ±  3%      +9.0%     120184 ±  3%  softirqs.CPU116.TIMER
>      134271 ±  3%     +14.1%     153220 ±  3%  softirqs.CPU117.RCU
>      109179 ±  2%      +8.3%     118274 ±  3%  softirqs.CPU117.TIMER
>      134281 ±  3%     +14.1%     153230 ±  3%  softirqs.CPU118.RCU
>      134415 ±  3%     +14.0%     153215 ±  3%  softirqs.CPU119.RCU
>      109514 ±  2%      +8.3%     118643 ±  3%  softirqs.CPU119.TIMER
>      135560 ±  3%     +13.5%     153874 ±  3%  softirqs.CPU12.RCU
>      110316 ±  2%      +8.5%     119734 ±  3%  softirqs.CPU12.TIMER
>      134177 ±  3%     +14.6%     153815 ±  3%  softirqs.CPU120.RCU
>      134367 ±  3%     +15.0%     154493 ±  3%  softirqs.CPU121.RCU
>      133972 ±  3%     +14.3%     153173 ±  3%  softirqs.CPU122.RCU
>      134801 ±  4%     +13.6%     153136 ±  3%  softirqs.CPU123.RCU
>      134709 ±  3%     +13.9%     153440 ±  3%  softirqs.CPU124.RCU
>      135185 ±  3%     +13.1%     152925 ±  3%  softirqs.CPU125.RCU
>      134977 ±  3%     +13.8%     153608 ±  3%  softirqs.CPU126.RCU
>      133862 ±  4%     +14.7%     153558 ±  3%  softirqs.CPU127.RCU
>      134554 ±  3%     +13.9%     153237 ±  3%  softirqs.CPU128.RCU
>      134254 ±  3%     +14.1%     153130 ±  3%  softirqs.CPU129.RCU
>      135133 ±  3%     +14.0%     154103 ±  3%  softirqs.CPU13.RCU
>      110389 ±  2%      +8.1%     119382 ±  3%  softirqs.CPU13.TIMER
>      134319 ±  3%     +13.8%     152909 ±  3%  softirqs.CPU130.RCU
>      133590 ±  3%     +14.5%     152925 ±  3%  softirqs.CPU131.RCU
>      134416 ±  4%     +14.0%     153223 ±  3%  softirqs.CPU132.RCU
>      133931 ±  3%     +14.5%     153359 ±  3%  softirqs.CPU133.RCU
>      134031 ±  3%     +14.5%     153527 ±  3%  softirqs.CPU134.RCU
>      133851 ±  4%     +14.3%     153052 ±  3%  softirqs.CPU135.RCU
>      134235 ±  4%     +13.9%     152959 ±  3%  softirqs.CPU136.RCU
>      134003 ±  3%     +14.2%     153037 ±  3%  softirqs.CPU137.RCU
>      133453 ±  3%     +14.4%     152625 ±  3%  softirqs.CPU138.RCU
>      133514 ±  3%     +14.8%     153289 ±  3%  softirqs.CPU139.RCU
>      134952 ±  3%     +13.6%     153372 ±  3%  softirqs.CPU14.RCU
>      134045 ±  3%     +13.7%     152361 ±  3%  softirqs.CPU140.RCU
>      133662 ±  3%     +14.1%     152528 ±  3%  softirqs.CPU141.RCU
>      133643 ±  3%     +14.7%     153283 ±  2%  softirqs.CPU142.RCU
>      133313 ±  3%     +15.0%     153254 ±  3%  softirqs.CPU143.RCU
>      133585 ±  3%     +14.4%     152837 ±  3%  softirqs.CPU144.RCU
>      108590 ±  3%     +12.7%     122339 ±  5%  softirqs.CPU144.TIMER
>      133471 ±  3%     +14.5%     152883 ±  3%  softirqs.CPU145.RCU
>      108095 ±  3%     +14.5%     123726 ±  6%  softirqs.CPU145.TIMER
>      133588 ±  3%     +15.4%     154173 ±  3%  softirqs.CPU146.RCU
>      108268 ±  3%     +19.8%     129684 ± 16%  softirqs.CPU146.TIMER
>      134060 ±  3%     +14.3%     153270 ±  3%  softirqs.CPU147.RCU
>      108731 ±  3%     +13.0%     122902 ±  5%  softirqs.CPU147.TIMER
>      133778 ±  3%     +14.1%     152681 ±  3%  softirqs.CPU148.RCU
>      108208 ±  3%     +12.6%     121875 ±  5%  softirqs.CPU148.TIMER
>      133514 ±  3%     +14.2%     152460 ±  3%  softirqs.CPU149.RCU
>      108054 ±  3%     +15.6%     124938 ±  9%  softirqs.CPU149.TIMER
>      134677 ±  3%     +14.5%     154138 ±  2%  softirqs.CPU15.RCU
>      133245 ±  3%     +14.4%     152373 ±  3%  softirqs.CPU150.RCU
>      107788 ±  3%     +13.1%     121957 ±  5%  softirqs.CPU150.TIMER
>      133747 ±  3%     +14.0%     152473 ±  3%  softirqs.CPU151.RCU
>      108258 ±  4%     +12.4%     121662 ±  5%  softirqs.CPU151.TIMER
>      133819 ±  3%     +14.1%     152726 ±  3%  softirqs.CPU152.RCU
>      108163 ±  3%     +12.7%     121940 ±  5%  softirqs.CPU152.TIMER
>      134057 ±  3%     +14.0%     152844 ±  3%  softirqs.CPU153.RCU
>      107680 ±  3%     +13.1%     121787 ±  5%  softirqs.CPU153.TIMER
>      133660 ±  3%     +14.2%     152675 ±  3%  softirqs.CPU154.RCU
>      107911 ±  3%     +15.4%     124485 ±  9%  softirqs.CPU154.TIMER
>      133349 ±  3%     +14.6%     152811 ±  3%  softirqs.CPU155.RCU
>      107513 ±  3%     +15.1%     123737 ±  6%  softirqs.CPU155.TIMER
>      133901 ±  3%     +14.0%     152615 ±  3%  softirqs.CPU156.RCU
>      107853 ±  3%     +13.0%     121904 ±  5%  softirqs.CPU156.TIMER
>      133621 ±  3%     +14.2%     152615 ±  3%  softirqs.CPU157.RCU
>      108040 ±  3%     +12.6%     121684 ±  5%  softirqs.CPU157.TIMER
>      133891 ±  3%     +14.2%     152862 ±  3%  softirqs.CPU158.RCU
>      108534 ±  3%     +12.7%     122300 ±  5%  softirqs.CPU158.TIMER
>      133925 ±  3%     +14.5%     153347 ±  3%  softirqs.CPU159.RCU
>      108099 ±  3%     +12.9%     122015 ±  5%  softirqs.CPU159.TIMER
>      134893 ±  3%     +14.5%     154389 ±  3%  softirqs.CPU16.RCU
>      134169 ±  3%     +13.9%     152812 ±  3%  softirqs.CPU160.RCU
>      108300 ±  3%     +12.9%     122318 ±  5%  softirqs.CPU160.TIMER
>      133818 ±  3%     +15.1%     154048 ±  4%  softirqs.CPU161.RCU
>      107919 ±  3%     +13.6%     122606 ±  6%  softirqs.CPU161.TIMER
>      133867 ±  3%     +14.2%     152856 ±  3%  softirqs.CPU162.RCU
>      107991 ±  3%     +13.2%     122209 ±  5%  softirqs.CPU162.TIMER
>      133579 ±  3%     +14.3%     152654 ±  3%  softirqs.CPU163.RCU
>      108317 ±  3%     +12.9%     122271 ±  5%  softirqs.CPU163.TIMER
>      133914 ±  3%     +14.4%     153158 ±  3%  softirqs.CPU164.RCU
>      133684 ±  3%     +14.4%     152895 ±  3%  softirqs.CPU165.RCU
>      107435 ±  3%     +12.5%     120877 ±  5%  softirqs.CPU165.TIMER
>      133983 ±  3%     +13.9%     152582 ±  3%  softirqs.CPU166.RCU
>      107432 ±  3%     +13.2%     121641 ±  5%  softirqs.CPU166.TIMER
>      133947 ±  3%     +13.6%     152137 ±  3%  softirqs.CPU167.RCU
>      134005 ±  3%     +14.5%     153385 ±  4%  softirqs.CPU168.RCU
>      115752 ±  4%     +12.0%     129634 ±  4%  softirqs.CPU168.TIMER
>      133557 ±  3%     +15.2%     153865 ±  4%  softirqs.CPU169.RCU
>      115884 ±  3%     +11.7%     129481 ±  4%  softirqs.CPU169.TIMER
>      135348 ±  3%     +13.8%     153977 ±  3%  softirqs.CPU17.RCU
>      110589 ±  3%      +7.9%     119298 ±  3%  softirqs.CPU17.TIMER
>      134463 ±  3%     +14.0%     153229 ±  3%  softirqs.CPU170.RCU
>      133740 ±  3%     +14.1%     152630 ±  3%  softirqs.CPU171.RCU
>      116524 ±  4%     +10.9%     129237 ±  3%  softirqs.CPU171.TIMER
>      133716 ±  3%     +13.8%     152196 ±  3%  softirqs.CPU172.RCU
>      116393 ±  4%     +10.9%     129087 ±  4%  softirqs.CPU172.TIMER
>      133564 ±  3%     +13.9%     152165 ±  3%  softirqs.CPU173.RCU
>      116237 ±  3%     +11.4%     129460 ±  3%  softirqs.CPU173.TIMER
>      133411 ±  3%     +14.5%     152764 ±  3%  softirqs.CPU174.RCU
>      116018 ±  3%     +11.2%     129006 ±  4%  softirqs.CPU174.TIMER
>      133147 ±  3%     +15.0%     153104 ±  2%  softirqs.CPU175.RCU
>      116052 ±  4%     +11.7%     129664 ±  3%  softirqs.CPU175.TIMER
>      133989 ±  3%     +13.8%     152504 ±  3%  softirqs.CPU176.RCU
>      116071 ±  4%     +10.9%     128756 ±  3%  softirqs.CPU176.TIMER
>      133902 ±  3%     +14.1%     152811 ±  3%  softirqs.CPU177.RCU
>      115994 ±  3%     +11.1%     128849 ±  4%  softirqs.CPU177.TIMER
>      133679 ±  3%     +14.4%     152887 ±  3%  softirqs.CPU178.RCU
>      115942 ±  4%     +13.4%     131439 ±  5%  softirqs.CPU178.TIMER
>      133985 ±  3%     +14.0%     152762 ±  3%  softirqs.CPU179.RCU
>      116347 ±  4%     +11.2%     129422 ±  4%  softirqs.CPU179.TIMER
>      134982 ±  3%     +14.0%     153838 ±  3%  softirqs.CPU18.RCU
>      110310 ±  3%      +8.6%     119851 ±  3%  softirqs.CPU18.TIMER
>      133236 ±  3%     +14.7%     152870 ±  3%  softirqs.CPU180.RCU
>      115901 ±  4%     +11.3%     129054 ±  4%  softirqs.CPU180.TIMER
>      133615 ±  3%     +14.4%     152876 ±  3%  softirqs.CPU181.RCU
>      115505 ±  4%     +11.3%     128560 ±  3%  softirqs.CPU181.TIMER
>      133171 ±  3%     +14.7%     152810 ±  3%  softirqs.CPU182.RCU
>      115955 ±  4%     +11.0%     128687 ±  3%  softirqs.CPU182.TIMER
>      133413 ±  3%     +14.4%     152671 ±  3%  softirqs.CPU183.RCU
>      116313 ±  4%     +11.0%     129140 ±  3%  softirqs.CPU183.TIMER
>      133598 ±  3%     +14.8%     153388 ±  3%  softirqs.CPU184.RCU
>      115462 ±  3%     +13.0%     130430 ±  6%  softirqs.CPU184.TIMER
>      133884 ±  3%     +13.9%     152525 ±  3%  softirqs.CPU185.RCU
>      115598 ±  4%     +11.1%     128397 ±  4%  softirqs.CPU185.TIMER
>      133262 ±  3%     +14.5%     152646 ±  3%  softirqs.CPU186.RCU
>      115745 ±  3%     +11.1%     128612 ±  4%  softirqs.CPU186.TIMER
>      133430 ±  3%     +14.5%     152767 ±  3%  softirqs.CPU187.RCU
>      115769 ±  4%     +11.0%     128464 ±  3%  softirqs.CPU187.TIMER
>      133259 ±  3%     +14.8%     153036 ±  3%  softirqs.CPU188.RCU
>      116108 ±  4%     +11.3%     129232 ±  3%  softirqs.CPU188.TIMER
>      133609 ±  3%     +14.1%     152436 ±  3%  softirqs.CPU189.RCU
>      115984 ±  4%     +11.0%     128710 ±  3%  softirqs.CPU189.TIMER
>      135090 ±  3%     +13.9%     153802 ±  3%  softirqs.CPU19.RCU
>      110865 ±  2%      +8.2%     119936 ±  3%  softirqs.CPU19.TIMER
>      133685 ±  3%     +14.2%     152631 ±  3%  softirqs.CPU190.RCU
>      115642 ±  3%     +11.2%     128581 ±  4%  softirqs.CPU190.TIMER
>      131031 ±  3%     +14.6%     150126 ±  3%  softirqs.CPU191.RCU
>      114275 ±  4%     +11.4%     127249 ±  4%  softirqs.CPU191.TIMER
>      134928 ±  3%     +14.3%     154165 ±  3%  softirqs.CPU2.RCU
>      135126 ±  3%     +14.0%     154083 ±  3%  softirqs.CPU20.RCU
>      111013 ±  3%      +8.6%     120549 ±  3%  softirqs.CPU20.TIMER
>      134663 ±  3%     +14.5%     154251 ±  3%  softirqs.CPU21.RCU
>      109671 ±  2%      +8.2%     118708 ±  3%  softirqs.CPU21.TIMER
>      135047 ±  3%     +13.9%     153766 ±  3%  softirqs.CPU22.RCU
>      134437 ±  3%     +14.2%     153492 ±  3%  softirqs.CPU23.RCU
>      109675 ±  2%      +8.3%     118824 ±  3%  softirqs.CPU23.TIMER
>      136114 ±  3%     +13.3%     154277 ±  3%  softirqs.CPU24.RCU
>      134825 ±  3%     +14.2%     154007 ±  3%  softirqs.CPU25.RCU
>      139234 ±  4%     +13.8%     158515 ±  3%  softirqs.CPU26.RCU
>      135056 ±  3%     +14.1%     154062 ±  3%  softirqs.CPU27.RCU
>      135307 ±  3%     +13.7%     153897 ±  3%  softirqs.CPU28.RCU
>      134686 ±  3%     +14.7%     154497 ±  3%  softirqs.CPU29.RCU
>      134688 ±  3%     +14.4%     154115 ±  2%  softirqs.CPU3.RCU
>      134642 ±  3%     +14.5%     154226 ±  3%  softirqs.CPU30.RCU
>      134773 ±  3%     +14.2%     153887 ±  3%  softirqs.CPU31.RCU
>      134523 ±  3%     +14.3%     153733 ±  3%  softirqs.CPU32.RCU
>      134488 ±  3%     +14.4%     153801 ±  3%  softirqs.CPU33.RCU
>      134483 ±  3%     +14.1%     153380 ±  3%  softirqs.CPU34.RCU
>      134886 ±  3%     +13.6%     153180 ±  3%  softirqs.CPU35.RCU
>      135021 ±  3%     +13.6%     153340 ±  3%  softirqs.CPU36.RCU
>      134064 ±  3%     +15.1%     154277 ±  3%  softirqs.CPU37.RCU
>      134166 ±  3%     +14.8%     153967 ±  3%  softirqs.CPU38.RCU
>      134488 ±  3%     +14.4%     153871 ±  3%  softirqs.CPU39.RCU
>      135294 ±  2%     +14.6%     155025 ±  3%  softirqs.CPU4.RCU
>      134598 ±  4%     +14.3%     153848 ±  3%  softirqs.CPU40.RCU
>      134255 ±  3%     +14.8%     154099 ±  3%  softirqs.CPU41.RCU
>      134334 ±  3%     +14.3%     153491 ±  3%  softirqs.CPU42.RCU
>      134201 ±  3%     +14.5%     153654 ±  3%  softirqs.CPU43.RCU
>      134260 ±  3%     +14.2%     153359 ±  3%  softirqs.CPU44.RCU
>      134005 ±  3%     +14.4%     153367 ±  3%  softirqs.CPU45.RCU
>      134236 ±  3%     +14.3%     153419 ±  3%  softirqs.CPU46.RCU
>      134552 ±  3%     +13.8%     153056 ±  3%  softirqs.CPU47.RCU
>      134623 ±  3%     +14.4%     154028 ±  3%  softirqs.CPU48.RCU
>      134348 ±  3%     +14.7%     154080 ±  3%  softirqs.CPU49.RCU
>      109020 ±  3%     +18.6%     129279 ± 14%  softirqs.CPU49.TIMER
>      134334 ±  3%     +15.0%     154455 ±  3%  softirqs.CPU5.RCU
>      110260 ±  2%      +8.8%     119951 ±  4%  softirqs.CPU5.TIMER
>      134377 ±  3%     +13.8%     152954 ±  3%  softirqs.CPU50.RCU
>      109169 ±  3%     +15.0%     125548 ±  9%  softirqs.CPU50.TIMER
>      134780 ±  3%     +14.2%     153967 ±  3%  softirqs.CPU51.RCU
>      109951 ±  3%     +12.5%     123641 ±  5%  softirqs.CPU51.TIMER
>      133929 ±  3%     +15.0%     154012 ±  3%  softirqs.CPU52.RCU
>      108665 ±  3%     +12.8%     122613 ±  5%  softirqs.CPU52.TIMER
>      133761 ±  3%     +14.9%     153675 ±  3%  softirqs.CPU53.RCU
>      108606 ±  3%     +19.6%     129861 ± 16%  softirqs.CPU53.TIMER
>      134369 ±  3%     +14.1%     153255 ±  3%  softirqs.CPU54.RCU
>      108917 ±  3%     +12.5%     122585 ±  5%  softirqs.CPU54.TIMER
>      133810 ±  3%     +14.6%     153282 ±  3%  softirqs.CPU55.RCU
>      108875 ±  3%     +12.5%     122468 ±  5%  softirqs.CPU55.TIMER
>      134038 ±  3%     +14.3%     153248 ±  3%  softirqs.CPU56.RCU
>      108569 ±  3%     +12.8%     122502 ±  5%  softirqs.CPU56.TIMER
>      133993 ±  4%     +14.5%     153426 ±  3%  softirqs.CPU57.RCU
>      108465 ±  3%     +12.8%     122399 ±  5%  softirqs.CPU57.TIMER
>      134049 ±  3%     +14.7%     153708 ±  3%  softirqs.CPU58.RCU
>      108634 ±  4%     +18.8%     129107 ± 16%  softirqs.CPU58.TIMER
>      134025 ±  3%     +14.9%     154015 ±  3%  softirqs.CPU59.RCU
>      108501 ±  3%     +18.6%     128721 ± 13%  softirqs.CPU59.TIMER
>      135247 ±  3%     +14.5%     154804 ±  3%  softirqs.CPU6.RCU
>      133745 ±  4%     +14.7%     153452 ±  3%  softirqs.CPU60.RCU
>      108526 ±  3%     +13.0%     122688 ±  5%  softirqs.CPU60.TIMER
>      133931 ±  3%     +14.6%     153549 ±  3%  softirqs.CPU61.RCU
>      108764 ±  3%     +12.9%     122787 ±  5%  softirqs.CPU61.TIMER
>      134682 ±  3%     +13.8%     153266 ±  3%  softirqs.CPU62.RCU
>      109188 ±  3%     +12.5%     122806 ±  5%  softirqs.CPU62.TIMER
>      134190 ±  3%     +14.6%     153761 ±  2%  softirqs.CPU63.RCU
>      108489 ±  3%     +12.8%     122426 ±  5%  softirqs.CPU63.TIMER
>      134280 ±  3%     +14.3%     153538 ±  3%  softirqs.CPU64.RCU
>      108493 ±  3%     +13.3%     122953 ±  5%  softirqs.CPU64.TIMER
>      134074 ±  3%     +14.7%     153765 ±  3%  softirqs.CPU65.RCU
>      108331 ±  3%     +13.0%     122440 ±  5%  softirqs.CPU65.TIMER
>      134424 ±  4%     +14.3%     153692 ±  3%  softirqs.CPU66.RCU
>      108874 ±  3%     +12.5%     122490 ±  5%  softirqs.CPU66.TIMER
>      133801 ±  3%     +14.9%     153746 ±  3%  softirqs.CPU67.RCU
>      108903 ±  3%     +13.2%     123240 ±  5%  softirqs.CPU67.TIMER
>      134085 ±  3%     +14.4%     153371 ±  3%  softirqs.CPU68.RCU
>      109310 ±  3%     +12.3%     122810 ±  5%  softirqs.CPU68.TIMER
>      134091 ±  3%     +14.5%     153515 ±  3%  softirqs.CPU69.RCU
>      108193 ±  3%     +12.5%     121716 ±  5%  softirqs.CPU69.TIMER
>      134883 ±  3%     +13.6%     153181 ±  3%  softirqs.CPU7.RCU
>      134392 ±  3%     +14.8%     154240 ±  3%  softirqs.CPU70.RCU
>      108056 ±  3%     +13.4%     122578 ±  5%  softirqs.CPU70.TIMER
>      133901 ±  3%     +14.2%     152873 ±  3%  softirqs.CPU71.RCU
>      134273 ±  3%     +14.4%     153630 ±  3%  softirqs.CPU72.RCU
>      116189 ±  3%     +11.5%     129495 ±  3%  softirqs.CPU72.TIMER
>      134231 ±  3%     +14.5%     153682 ±  3%  softirqs.CPU73.RCU
>      116348 ±  3%     +11.3%     129453 ±  3%  softirqs.CPU73.TIMER
>      134235 ±  3%     +14.1%     153158 ±  3%  softirqs.CPU74.RCU
>      133896 ±  3%     +14.6%     153477 ±  3%  softirqs.CPU75.RCU
>      116933 ±  4%     +11.2%     129980 ±  3%  softirqs.CPU75.TIMER
>      134014 ±  3%     +14.3%     153198 ±  3%  softirqs.CPU76.RCU
>      116889 ±  3%     +11.0%     129768 ±  3%  softirqs.CPU76.TIMER
>      134608 ±  3%     +13.7%     152994 ±  3%  softirqs.CPU77.RCU
>      117342 ±  3%     +11.0%     130274 ±  3%  softirqs.CPU77.TIMER
>      134551 ±  3%     +13.9%     153253 ±  3%  softirqs.CPU78.RCU
>      117229 ±  4%     +10.5%     129549 ±  4%  softirqs.CPU78.TIMER
>      134118 ±  3%     +14.3%     153325 ±  3%  softirqs.CPU79.RCU
>      116982 ±  3%     +11.0%     129802 ±  3%  softirqs.CPU79.TIMER
>      135303 ±  3%     +13.9%     154129 ±  3%  softirqs.CPU8.RCU
>      134699 ±  3%     +13.6%     153047 ±  3%  softirqs.CPU80.RCU
>      117058 ±  4%     +10.6%     129470 ±  3%  softirqs.CPU80.TIMER
>      134088 ±  3%     +15.6%     155063 ±  3%  softirqs.CPU81.RCU
>      116539 ±  4%     +12.3%     130886 ±  5%  softirqs.CPU81.TIMER
>      133989 ±  3%     +14.6%     153526 ±  3%  softirqs.CPU82.RCU
>      116614 ±  4%     +16.8%     136238 ± 12%  softirqs.CPU82.TIMER
>      133966 ±  3%     +14.3%     153142 ±  3%  softirqs.CPU83.RCU
>      117140 ±  3%     +11.2%     130205 ±  4%  softirqs.CPU83.TIMER
>      133561 ±  3%     +15.0%     153661 ±  3%  softirqs.CPU84.RCU
>      116648 ±  4%     +11.3%     129844 ±  4%  softirqs.CPU84.TIMER
>      134217 ±  3%     +14.2%     153330 ±  3%  softirqs.CPU85.RCU
>      116247 ±  4%     +11.3%     129336 ±  3%  softirqs.CPU85.TIMER
>      133956 ±  3%     +14.5%     153338 ±  3%  softirqs.CPU86.RCU
>      116654 ±  4%     +11.1%     129560 ±  3%  softirqs.CPU86.TIMER
>      133834 ±  3%     +15.1%     154049 ±  2%  softirqs.CPU87.RCU
>      116898 ±  4%     +12.0%     130912 ±  3%  softirqs.CPU87.TIMER
>      133951 ±  3%     +15.1%     154211 ±  3%  softirqs.CPU88.RCU
>      116139 ±  3%     +16.0%     134676 ± 13%  softirqs.CPU88.TIMER
>      134288 ±  3%     +14.3%     153433 ±  2%  softirqs.CPU89.RCU
>      116227 ±  3%     +11.0%     129064 ±  3%  softirqs.CPU89.TIMER
>      135289 ±  3%     +13.6%     153744 ±  3%  softirqs.CPU9.RCU
>      133598 ±  3%     +14.5%     153019 ±  3%  softirqs.CPU90.RCU
>      116395 ±  3%     +10.9%     129084 ±  4%  softirqs.CPU90.TIMER
>      133854 ±  4%     +14.9%     153799 ±  3%  softirqs.CPU91.RCU
>      116562 ±  4%     +11.1%     129452 ±  3%  softirqs.CPU91.TIMER
>      134107 ±  3%     +14.1%     152958 ±  3%  softirqs.CPU92.RCU
>      117107 ±  4%     +10.6%     129559 ±  3%  softirqs.CPU92.TIMER
>      133800 ±  3%     +14.7%     153465 ±  3%  softirqs.CPU93.RCU
>      116415 ±  3%     +11.5%     129823 ±  4%  softirqs.CPU93.TIMER
>      134092 ±  3%     +14.0%     152835 ±  3%  softirqs.CPU94.RCU
>      116063 ±  3%     +11.4%     129252 ±  4%  softirqs.CPU94.TIMER
>      134284 ±  3%     +14.1%     153230 ±  4%  softirqs.CPU95.RCU
>      117908 ±  3%     +11.0%     130904 ±  4%  softirqs.CPU95.TIMER
>      134264 ±  3%     +14.3%     153455 ±  3%  softirqs.CPU96.RCU
>      109819 ±  3%      +8.6%     119258 ±  3%  softirqs.CPU96.TIMER
>      135000 ±  3%     +13.7%     153529 ±  3%  softirqs.CPU97.RCU
>      134163 ±  3%     +14.2%     153253 ±  3%  softirqs.CPU98.RCU
>      109990 ±  3%      +8.1%     118896 ±  3%  softirqs.CPU98.TIMER
>      134966 ±  3%     +13.5%     153245 ±  3%  softirqs.CPU99.RCU
>    25776297 ±  3%     +14.3%   29452390 ±  3%  softirqs.RCU
>    21445010 ±  3%      +9.5%   23488096 ±  3%  softirqs.TIMER
>      614.00 ±  2%      +9.9%     674.50 ±  2%  interrupts.9:IO-APIC.9-fasteoi.acpi
>      611854 ±  2%     +10.1%     673945 ±  2%  interrupts.CPU0.LOC:Local_timer_interrupts
>      614.00 ±  2%      +9.9%     674.50 ±  2%  interrupts.CPU1.9:IO-APIC.9-fasteoi.acpi
>      611835 ±  2%     +10.1%     673883 ±  2%  interrupts.CPU1.LOC:Local_timer_interrupts
>      611859 ±  2%     +10.2%     673975 ±  2%  interrupts.CPU10.LOC:Local_timer_interrupts
>        7508 ±  5%     +15.5%       8675 ±  4%  interrupts.CPU10.RES:Rescheduling_interrupts
>      611802 ±  2%     +10.2%     673904 ±  2%  interrupts.CPU100.LOC:Local_timer_interrupts
>        7323 ±  5%     +16.1%       8503 ±  3%  interrupts.CPU100.RES:Rescheduling_interrupts
>      611804 ±  2%     +10.2%     673917 ±  2%  interrupts.CPU101.LOC:Local_timer_interrupts
>        7342 ±  3%     +13.8%       8352 ±  3%  interrupts.CPU101.RES:Rescheduling_interrupts
>      611780 ±  2%     +10.2%     673877 ±  2%  interrupts.CPU102.LOC:Local_timer_interrupts
>        7506 ±  5%     +12.2%       8424 ±  4%  interrupts.CPU102.RES:Rescheduling_interrupts
>      611734 ±  2%     +10.2%     673851 ±  2%  interrupts.CPU103.LOC:Local_timer_interrupts
>        7436 ±  3%     +15.8%       8607 ±  4%  interrupts.CPU103.RES:Rescheduling_interrupts
>      611800 ±  2%     +10.2%     673908 ±  2%  interrupts.CPU104.LOC:Local_timer_interrupts
>        7519 ±  5%     +13.1%       8502 ±  2%  interrupts.CPU104.RES:Rescheduling_interrupts
>      611790 ±  2%     +10.1%     673864 ±  2%  interrupts.CPU105.LOC:Local_timer_interrupts
>        7346 ±  5%     +16.4%       8553 ±  2%  interrupts.CPU105.RES:Rescheduling_interrupts
>      611801 ±  2%     +10.1%     673859 ±  2%  interrupts.CPU106.LOC:Local_timer_interrupts
>        7352 ±  5%     +16.5%       8567 ±  2%  interrupts.CPU106.RES:Rescheduling_interrupts
>      611797 ±  2%     +10.1%     673890 ±  2%  interrupts.CPU107.LOC:Local_timer_interrupts
>        7238 ±  6%     +15.3%       8344 ±  4%  interrupts.CPU107.RES:Rescheduling_interrupts
>      611778 ±  2%     +10.2%     673882 ±  2%  interrupts.CPU108.LOC:Local_timer_interrupts
>        7310 ±  5%     +16.3%       8503 ±  5%  interrupts.CPU108.RES:Rescheduling_interrupts
>      611788 ±  2%     +10.1%     673881 ±  2%  interrupts.CPU109.LOC:Local_timer_interrupts
>        7324 ±  6%     +13.4%       8307        interrupts.CPU109.RES:Rescheduling_interrupts
>      611827 ±  2%     +10.2%     673960 ±  2%  interrupts.CPU11.LOC:Local_timer_interrupts
>        7598 ±  6%     +12.6%       8557 ±  5%  interrupts.CPU11.RES:Rescheduling_interrupts
>      611796 ±  2%     +10.1%     673865 ±  2%  interrupts.CPU110.LOC:Local_timer_interrupts
>        7326 ±  4%     +16.2%       8513 ±  4%  interrupts.CPU110.RES:Rescheduling_interrupts
>      611804 ±  2%     +10.1%     673890 ±  2%  interrupts.CPU111.LOC:Local_timer_interrupts
>        7312 ±  3%     +14.4%       8365 ±  3%  interrupts.CPU111.RES:Rescheduling_interrupts
>      611801 ±  2%     +10.1%     673890 ±  2%  interrupts.CPU112.LOC:Local_timer_interrupts
>        7277 ±  2%     +14.6%       8337 ±  5%  interrupts.CPU112.RES:Rescheduling_interrupts
>      611789 ±  2%     +10.2%     673896 ±  2%  interrupts.CPU113.LOC:Local_timer_interrupts
>        7346 ±  4%     +15.2%       8461 ±  4%  interrupts.CPU113.RES:Rescheduling_interrupts
>      611759 ±  2%     +10.2%     673861 ±  2%  interrupts.CPU114.LOC:Local_timer_interrupts
>        7290 ±  4%     +17.9%       8594 ±  4%  interrupts.CPU114.RES:Rescheduling_interrupts
>      611783 ±  2%     +10.2%     673883 ±  2%  interrupts.CPU115.LOC:Local_timer_interrupts
>        7470 ±  4%     +13.6%       8489 ±  5%  interrupts.CPU115.RES:Rescheduling_interrupts
>      611807 ±  2%     +10.2%     673925 ±  2%  interrupts.CPU116.LOC:Local_timer_interrupts
>        7336 ±  4%     +15.3%       8455 ±  2%  interrupts.CPU116.RES:Rescheduling_interrupts
>      611778 ±  2%     +10.2%     673890 ±  2%  interrupts.CPU117.LOC:Local_timer_interrupts
>        7326 ±  5%     +15.9%       8493 ±  3%  interrupts.CPU117.RES:Rescheduling_interrupts
>      611782 ±  2%     +10.1%     673849 ±  2%  interrupts.CPU118.LOC:Local_timer_interrupts
>        7239 ±  4%     +18.4%       8574 ±  5%  interrupts.CPU118.RES:Rescheduling_interrupts
>      611778 ±  2%     +10.2%     673881 ±  2%  interrupts.CPU119.LOC:Local_timer_interrupts
>        7327 ±  4%     +13.7%       8335 ±  6%  interrupts.CPU119.RES:Rescheduling_interrupts
>      611853 ±  2%     +10.1%     673944 ±  2%  interrupts.CPU12.LOC:Local_timer_interrupts
>        7516 ±  4%     +17.0%       8798 ±  6%  interrupts.CPU12.RES:Rescheduling_interrupts
>      611417 ±  2%     +10.2%     673606 ±  2%  interrupts.CPU120.LOC:Local_timer_interrupts
>        7392 ±  4%     +14.2%       8444 ±  5%  interrupts.CPU120.RES:Rescheduling_interrupts
>      611457 ±  2%     +10.2%     673608 ±  2%  interrupts.CPU121.LOC:Local_timer_interrupts
>        7376 ±  3%     +15.6%       8525 ±  4%  interrupts.CPU121.RES:Rescheduling_interrupts
>      611426 ±  2%     +10.2%     673610 ±  2%  interrupts.CPU122.LOC:Local_timer_interrupts
>        7466 ±  5%     +11.7%       8336 ±  4%  interrupts.CPU122.RES:Rescheduling_interrupts
>      611384 ±  2%     +10.2%     673577 ±  2%  interrupts.CPU123.LOC:Local_timer_interrupts
>        7240 ±  5%     +18.2%       8559 ±  3%  interrupts.CPU123.RES:Rescheduling_interrupts
>      611388 ±  2%     +10.2%     673597 ±  2%  interrupts.CPU124.LOC:Local_timer_interrupts
>        7245 ±  5%     +18.0%       8548 ±  5%  interrupts.CPU124.RES:Rescheduling_interrupts
>      611391 ±  2%     +10.2%     673567 ±  2%  interrupts.CPU125.LOC:Local_timer_interrupts
>        7318 ±  3%     +15.3%       8436 ±  5%  interrupts.CPU125.RES:Rescheduling_interrupts
>      611421 ±  2%     +10.2%     673570 ±  2%  interrupts.CPU126.LOC:Local_timer_interrupts
>        7258 ±  5%     +16.4%       8448 ±  4%  interrupts.CPU126.RES:Rescheduling_interrupts
>      611468 ±  2%     +10.2%     673614 ±  2%  interrupts.CPU127.LOC:Local_timer_interrupts
>        7276 ±  5%     +16.9%       8508 ±  5%  interrupts.CPU127.RES:Rescheduling_interrupts
>      611422 ±  2%     +10.2%     673591 ±  2%  interrupts.CPU128.LOC:Local_timer_interrupts
>        7278 ±  4%     +17.0%       8518 ±  3%  interrupts.CPU128.RES:Rescheduling_interrupts
>      611407 ±  2%     +10.2%     673562 ±  2%  interrupts.CPU129.LOC:Local_timer_interrupts
>        7284 ±  3%     +17.0%       8519 ±  5%  interrupts.CPU129.RES:Rescheduling_interrupts
>      611825 ±  2%     +10.1%     673920 ±  2%  interrupts.CPU13.LOC:Local_timer_interrupts
>        7550 ±  4%     +16.2%       8771 ±  3%  interrupts.CPU13.RES:Rescheduling_interrupts
>      611428 ±  2%     +10.2%     673571 ±  2%  interrupts.CPU130.LOC:Local_timer_interrupts
>        7337 ±  5%     +16.4%       8541 ±  5%  interrupts.CPU130.RES:Rescheduling_interrupts
>      611406 ±  2%     +10.2%     673582 ±  2%  interrupts.CPU131.LOC:Local_timer_interrupts
>        7205 ±  5%     +17.1%       8440 ±  6%  interrupts.CPU131.RES:Rescheduling_interrupts
>      611449 ±  2%     +10.2%     673586 ±  2%  interrupts.CPU132.LOC:Local_timer_interrupts
>        7431 ±  4%     +12.7%       8372 ±  3%  interrupts.CPU132.RES:Rescheduling_interrupts
>      611464 ±  2%     +10.2%     673588 ±  2%  interrupts.CPU133.LOC:Local_timer_interrupts
>        7289 ±  4%     +15.9%       8446 ±  3%  interrupts.CPU133.RES:Rescheduling_interrupts
>      611437 ±  2%     +10.2%     673583 ±  2%  interrupts.CPU134.LOC:Local_timer_interrupts
>        7321 ±  4%     +17.7%       8616 ±  4%  interrupts.CPU134.RES:Rescheduling_interrupts
>      611401 ±  2%     +10.2%     673595 ±  2%  interrupts.CPU135.LOC:Local_timer_interrupts
>        7300 ±  4%     +15.7%       8446 ±  4%  interrupts.CPU135.RES:Rescheduling_interrupts
>      611462 ±  2%     +10.2%     673602 ±  2%  interrupts.CPU136.LOC:Local_timer_interrupts
>        7389 ±  4%     +13.9%       8417 ±  5%  interrupts.CPU136.RES:Rescheduling_interrupts
>      611424 ±  2%     +10.2%     673588 ±  2%  interrupts.CPU137.LOC:Local_timer_interrupts
>        7126 ±  4%     +20.0%       8550 ±  5%  interrupts.CPU137.RES:Rescheduling_interrupts
>      611383 ±  2%     +10.2%     673556 ±  2%  interrupts.CPU138.LOC:Local_timer_interrupts
>        7297 ±  5%     +16.1%       8475 ±  5%  interrupts.CPU138.RES:Rescheduling_interrupts
>      611422 ±  2%     +10.2%     673603 ±  2%  interrupts.CPU139.LOC:Local_timer_interrupts
>        7160 ±  4%     +17.6%       8423 ±  4%  interrupts.CPU139.RES:Rescheduling_interrupts
>      611815 ±  2%     +10.1%     673901 ±  2%  interrupts.CPU14.LOC:Local_timer_interrupts
>        7576 ±  5%     +16.3%       8810 ±  3%  interrupts.CPU14.RES:Rescheduling_interrupts
>      611388 ±  2%     +10.2%     673577 ±  2%  interrupts.CPU140.LOC:Local_timer_interrupts
>        7342 ±  6%     +12.9%       8293 ±  4%  interrupts.CPU140.RES:Rescheduling_interrupts
>      611394 ±  2%     +10.2%     673596 ±  2%  interrupts.CPU141.LOC:Local_timer_interrupts
>        7257 ±  4%     +16.1%       8423 ±  5%  interrupts.CPU141.RES:Rescheduling_interrupts
>      611411 ±  2%     +10.2%     673590 ±  2%  interrupts.CPU142.LOC:Local_timer_interrupts
>        7300 ±  6%     +16.1%       8475 ±  3%  interrupts.CPU142.RES:Rescheduling_interrupts
>      611396 ±  2%     +10.2%     673622 ±  2%  interrupts.CPU143.LOC:Local_timer_interrupts
>        7399 ±  5%     +14.0%       8435 ±  4%  interrupts.CPU143.RES:Rescheduling_interrupts
>      610929 ±  2%     +10.3%     673686 ±  2%  interrupts.CPU144.LOC:Local_timer_interrupts
>        7281 ±  5%     +13.4%       8257 ±  5%  interrupts.CPU144.RES:Rescheduling_interrupts
>      610918 ±  2%     +10.3%     673755 ±  2%  interrupts.CPU145.LOC:Local_timer_interrupts
>        7343 ±  5%     +14.5%       8408 ±  4%  interrupts.CPU145.RES:Rescheduling_interrupts
>      610910 ±  2%     +10.3%     673705 ±  2%  interrupts.CPU146.LOC:Local_timer_interrupts
>        7524 ±  4%     +13.6%       8550 ±  6%  interrupts.CPU146.RES:Rescheduling_interrupts
>      610858 ±  2%     +10.3%     673769 ±  2%  interrupts.CPU147.LOC:Local_timer_interrupts
>        7433 ±  4%     +10.8%       8237 ±  3%  interrupts.CPU147.RES:Rescheduling_interrupts
>      610872 ±  2%     +10.3%     673727 ±  2%  interrupts.CPU148.LOC:Local_timer_interrupts
>        7354 ±  3%     +13.1%       8320 ±  4%  interrupts.CPU148.RES:Rescheduling_interrupts
>      610909 ±  2%     +10.3%     673750 ±  2%  interrupts.CPU149.LOC:Local_timer_interrupts
>        7365 ±  3%     +16.5%       8582 ±  3%  interrupts.CPU149.RES:Rescheduling_interrupts
>      611818 ±  2%     +10.2%     673937 ±  2%  interrupts.CPU15.LOC:Local_timer_interrupts
>        7632 ±  4%     +12.5%       8587 ±  4%  interrupts.CPU15.RES:Rescheduling_interrupts
>      610898 ±  2%     +10.3%     673770 ±  2%  interrupts.CPU150.LOC:Local_timer_interrupts
>        7369 ±  4%     +12.4%       8282 ±  3%  interrupts.CPU150.RES:Rescheduling_interrupts
>      610887 ±  2%     +10.3%     673754 ±  2%  interrupts.CPU151.LOC:Local_timer_interrupts
>        7322 ±  4%     +15.3%       8445 ±  3%  interrupts.CPU151.RES:Rescheduling_interrupts
>      610849 ±  2%     +10.3%     673762 ±  2%  interrupts.CPU152.LOC:Local_timer_interrupts
>        7305 ±  4%     +15.5%       8439 ±  5%  interrupts.CPU152.RES:Rescheduling_interrupts
>      610909 ±  2%     +10.3%     673759 ±  2%  interrupts.CPU153.LOC:Local_timer_interrupts
>        7363 ±  6%     +14.5%       8432 ±  2%  interrupts.CPU153.RES:Rescheduling_interrupts
>      610878 ±  2%     +10.3%     673730 ±  2%  interrupts.CPU154.LOC:Local_timer_interrupts
>        7373 ±  4%     +14.1%       8414 ±  4%  interrupts.CPU154.RES:Rescheduling_interrupts
>      610891 ±  2%     +10.3%     673720 ±  2%  interrupts.CPU155.LOC:Local_timer_interrupts
>        7385 ±  5%     +11.8%       8260 ±  4%  interrupts.CPU155.RES:Rescheduling_interrupts
>      610909 ±  2%     +10.3%     673753 ±  2%  interrupts.CPU156.LOC:Local_timer_interrupts
>        7377 ±  5%     +14.0%       8410 ±  5%  interrupts.CPU156.RES:Rescheduling_interrupts
>      610886 ±  2%     +10.3%     673754 ±  2%  interrupts.CPU157.LOC:Local_timer_interrupts
>        7399 ±  5%     +13.1%       8370 ±  4%  interrupts.CPU157.RES:Rescheduling_interrupts
>      610854 ±  2%     +10.3%     673699 ±  2%  interrupts.CPU158.LOC:Local_timer_interrupts
>        7489 ±  4%     +10.5%       8278 ±  2%  interrupts.CPU158.RES:Rescheduling_interrupts
>      610921 ±  2%     +10.3%     673726 ±  2%  interrupts.CPU159.LOC:Local_timer_interrupts
>        7281 ±  5%     +15.4%       8402 ±  4%  interrupts.CPU159.RES:Rescheduling_interrupts
>      611836 ±  2%     +10.1%     673889 ±  2%  interrupts.CPU16.LOC:Local_timer_interrupts
>        7548 ±  4%     +15.6%       8723 ±  5%  interrupts.CPU16.RES:Rescheduling_interrupts
>      610870 ±  2%     +10.3%     673742 ±  2%  interrupts.CPU160.LOC:Local_timer_interrupts
>      610856 ±  2%     +10.3%     673722 ±  2%  interrupts.CPU161.LOC:Local_timer_interrupts
>        7472 ±  5%     +13.4%       8475 ±  5%  interrupts.CPU161.RES:Rescheduling_interrupts
>      610891 ±  2%     +10.3%     673708 ±  2%  interrupts.CPU162.LOC:Local_timer_interrupts
>        7177 ±  5%     +14.8%       8239 ±  5%  interrupts.CPU162.RES:Rescheduling_interrupts
>      610864 ±  2%     +10.3%     673696 ±  2%  interrupts.CPU163.LOC:Local_timer_interrupts
>        7337 ±  5%     +12.7%       8266 ±  4%  interrupts.CPU163.RES:Rescheduling_interrupts
>      610858 ±  2%     +10.3%     673724 ±  2%  interrupts.CPU164.LOC:Local_timer_interrupts
>        7269 ±  5%     +15.2%       8376 ±  4%  interrupts.CPU164.RES:Rescheduling_interrupts
>      610861 ±  2%     +10.3%     673711 ±  2%  interrupts.CPU165.LOC:Local_timer_interrupts
>        7431 ±  4%      +9.4%       8131 ±  4%  interrupts.CPU165.RES:Rescheduling_interrupts
>      610867 ±  2%     +10.3%     673684 ±  2%  interrupts.CPU166.LOC:Local_timer_interrupts
>        7339 ±  2%     +14.1%       8374 ±  4%  interrupts.CPU166.RES:Rescheduling_interrupts
>      610913 ±  2%     +10.3%     673730 ±  2%  interrupts.CPU167.LOC:Local_timer_interrupts
>        7174 ±  3%     +17.5%       8427 ±  4%  interrupts.CPU167.RES:Rescheduling_interrupts
>      611289 ±  2%     +10.2%     673888 ±  2%  interrupts.CPU168.LOC:Local_timer_interrupts
>        7311 ±  5%     +14.7%       8382 ±  3%  interrupts.CPU168.RES:Rescheduling_interrupts
>      611333 ±  2%     +10.2%     673887 ±  2%  interrupts.CPU169.LOC:Local_timer_interrupts
>        7232 ±  2%     +17.8%       8517 ±  5%  interrupts.CPU169.RES:Rescheduling_interrupts
>      611838 ±  2%     +10.1%     673879 ±  2%  interrupts.CPU17.LOC:Local_timer_interrupts
>        7539 ±  2%     +17.7%       8873 ± 10%  interrupts.CPU17.RES:Rescheduling_interrupts
>      611349 ±  2%     +10.2%     673889 ±  2%  interrupts.CPU170.LOC:Local_timer_interrupts
>        7374 ±  2%     +14.2%       8424 ±  5%  interrupts.CPU170.RES:Rescheduling_interrupts
>      611297 ±  2%     +10.2%     673873 ±  2%  interrupts.CPU171.LOC:Local_timer_interrupts
>        7438 ±  4%     +13.9%       8471 ±  5%  interrupts.CPU171.RES:Rescheduling_interrupts
>      611304 ±  2%     +10.2%     673845 ±  2%  interrupts.CPU172.LOC:Local_timer_interrupts
>        7317 ±  3%     +16.6%       8529 ±  5%  interrupts.CPU172.RES:Rescheduling_interrupts
>      611297 ±  2%     +10.2%     673887 ±  2%  interrupts.CPU173.LOC:Local_timer_interrupts
>      611309 ±  2%     +10.2%     673858 ±  2%  interrupts.CPU174.LOC:Local_timer_interrupts
>        7369 ±  5%     +15.8%       8531 ±  5%  interrupts.CPU174.RES:Rescheduling_interrupts
>      611311 ±  2%     +10.2%     673872 ±  2%  interrupts.CPU175.LOC:Local_timer_interrupts
>        7352 ±  4%     +15.1%       8465 ±  4%  interrupts.CPU175.RES:Rescheduling_interrupts
>      611309 ±  2%     +10.2%     673886 ±  2%  interrupts.CPU176.LOC:Local_timer_interrupts
>        7395 ±  2%     +14.0%       8434 ±  5%  interrupts.CPU176.RES:Rescheduling_interrupts
>      611322 ±  2%     +10.2%     673868 ±  2%  interrupts.CPU177.LOC:Local_timer_interrupts
>      611248 ±  2%     +10.2%     673805 ±  2%  interrupts.CPU178.LOC:Local_timer_interrupts
>        7355 ±  5%     +14.1%       8393 ±  4%  interrupts.CPU178.RES:Rescheduling_interrupts
>      611319 ±  2%     +10.2%     673906 ±  2%  interrupts.CPU179.LOC:Local_timer_interrupts
>        7269 ±  4%     +15.2%       8374 ±  6%  interrupts.CPU179.RES:Rescheduling_interrupts
>      611799 ±  2%     +10.1%     673864 ±  2%  interrupts.CPU18.LOC:Local_timer_interrupts
>        7585 ±  4%     +14.5%       8683 ±  4%  interrupts.CPU18.RES:Rescheduling_interrupts
>      611330 ±  2%     +10.2%     673869 ±  2%  interrupts.CPU180.LOC:Local_timer_interrupts
>        7404 ±  4%     +14.0%       8442 ±  5%  interrupts.CPU180.RES:Rescheduling_interrupts
>      611324 ±  2%     +10.2%     673889 ±  2%  interrupts.CPU181.LOC:Local_timer_interrupts
>        7435 ±  2%     +13.0%       8399 ±  3%  interrupts.CPU181.RES:Rescheduling_interrupts
>      611322 ±  2%     +10.2%     673874 ±  2%  interrupts.CPU182.LOC:Local_timer_interrupts
>        7250 ±  4%     +14.6%       8305 ±  4%  interrupts.CPU182.RES:Rescheduling_interrupts
>      611307 ±  2%     +10.2%     673852 ±  2%  interrupts.CPU183.LOC:Local_timer_interrupts
>        7320 ±  4%     +13.2%       8290 ±  5%  interrupts.CPU183.RES:Rescheduling_interrupts
>      611329 ±  2%     +10.2%     673877 ±  2%  interrupts.CPU184.LOC:Local_timer_interrupts
>        7377 ±  4%     +12.5%       8299 ±  5%  interrupts.CPU184.RES:Rescheduling_interrupts
>      611312 ±  2%     +10.2%     673866 ±  2%  interrupts.CPU185.LOC:Local_timer_interrupts
>        7333 ±  4%     +13.9%       8351 ±  5%  interrupts.CPU185.RES:Rescheduling_interrupts
>      611290 ±  2%     +10.2%     673868 ±  2%  interrupts.CPU186.LOC:Local_timer_interrupts
>        7426 ±  4%     +14.1%       8471 ±  3%  interrupts.CPU186.RES:Rescheduling_interrupts
>      611304 ±  2%     +10.2%     673853 ±  2%  interrupts.CPU187.LOC:Local_timer_interrupts
>        7380 ±  3%     +12.5%       8304 ±  5%  interrupts.CPU187.RES:Rescheduling_interrupts
>      611307 ±  2%     +10.2%     673881 ±  2%  interrupts.CPU188.LOC:Local_timer_interrupts
>        7277 ±  5%     +16.3%       8467 ±  6%  interrupts.CPU188.RES:Rescheduling_interrupts
>      611299 ±  2%     +10.2%     673879 ±  2%  interrupts.CPU189.LOC:Local_timer_interrupts
>        7436 ±  3%     +14.5%       8514 ±  6%  interrupts.CPU189.RES:Rescheduling_interrupts
>      611761 ±  2%     +10.2%     673928 ±  2%  interrupts.CPU19.LOC:Local_timer_interrupts
>        7515 ±  6%     +12.7%       8467 ±  4%  interrupts.CPU19.RES:Rescheduling_interrupts
>      611321 ±  2%     +10.2%     673856 ±  2%  interrupts.CPU190.LOC:Local_timer_interrupts
>        7188 ±  3%     +16.4%       8366 ±  5%  interrupts.CPU190.RES:Rescheduling_interrupts
>      611544 ±  2%     +10.2%     674120 ±  2%  interrupts.CPU191.LOC:Local_timer_interrupts
>        7207 ±  3%     +15.3%       8312 ±  3%  interrupts.CPU191.RES:Rescheduling_interrupts
>      611805 ±  2%     +10.2%     673920 ±  2%  interrupts.CPU2.LOC:Local_timer_interrupts
>      611781 ±  2%     +10.2%     673897 ±  2%  interrupts.CPU20.LOC:Local_timer_interrupts
>        7531 ±  5%     +16.4%       8768 ±  3%  interrupts.CPU20.RES:Rescheduling_interrupts
>      611715 ±  2%     +10.2%     673897 ±  2%  interrupts.CPU21.LOC:Local_timer_interrupts
>        7467 ±  3%     +14.9%       8577 ±  4%  interrupts.CPU21.RES:Rescheduling_interrupts
>      611834 ±  2%     +10.1%     673900 ±  2%  interrupts.CPU22.LOC:Local_timer_interrupts
>        7427 ±  6%     +17.9%       8754 ±  4%  interrupts.CPU22.RES:Rescheduling_interrupts
>      611788 ±  2%     +10.1%     673869 ±  2%  interrupts.CPU23.LOC:Local_timer_interrupts
>        7592 ±  4%     +12.2%       8518 ±  4%  interrupts.CPU23.RES:Rescheduling_interrupts
>      611426 ±  2%     +10.2%     673619 ±  2%  interrupts.CPU24.LOC:Local_timer_interrupts
>        7457 ±  4%     +14.7%       8551 ±  3%  interrupts.CPU24.RES:Rescheduling_interrupts
>      611439 ±  2%     +10.2%     673636 ±  2%  interrupts.CPU25.LOC:Local_timer_interrupts
>      611402 ±  2%     +10.2%     673620 ±  2%  interrupts.CPU26.LOC:Local_timer_interrupts
>        7463 ±  3%     +18.4%       8838 ±  7%  interrupts.CPU26.RES:Rescheduling_interrupts
>      611413 ±  2%     +10.2%     673615 ±  2%  interrupts.CPU27.LOC:Local_timer_interrupts
>        7412 ±  4%     +16.1%       8607 ±  4%  interrupts.CPU27.RES:Rescheduling_interrupts
>      611409 ±  2%     +10.2%     673625 ±  2%  interrupts.CPU28.LOC:Local_timer_interrupts
>        7478 ±  5%     +15.6%       8648 ±  3%  interrupts.CPU28.RES:Rescheduling_interrupts
>      611415 ±  2%     +10.2%     673620 ±  2%  interrupts.CPU29.LOC:Local_timer_interrupts
>        7431 ±  2%     +15.5%       8585 ±  2%  interrupts.CPU29.RES:Rescheduling_interrupts
>      611807 ±  2%     +10.1%     673896 ±  2%  interrupts.CPU3.LOC:Local_timer_interrupts
>        7659 ±  5%     +20.9%       9264 ± 10%  interrupts.CPU3.RES:Rescheduling_interrupts
>      611433 ±  2%     +10.2%     673520 ±  2%  interrupts.CPU30.LOC:Local_timer_interrupts
>        7432 ±  3%     +16.5%       8659 ±  4%  interrupts.CPU30.RES:Rescheduling_interrupts
>      611450 ±  2%     +10.2%     673604 ±  2%  interrupts.CPU31.LOC:Local_timer_interrupts
>        7490 ±  4%     +14.6%       8585 ±  5%  interrupts.CPU31.RES:Rescheduling_interrupts
>      611444 ±  2%     +10.2%     673588 ±  2%  interrupts.CPU32.LOC:Local_timer_interrupts
>        7393 ±  4%     +19.0%       8799 ±  3%  interrupts.CPU32.RES:Rescheduling_interrupts
>      611407 ±  2%     +10.2%     673606 ±  2%  interrupts.CPU33.LOC:Local_timer_interrupts
>        7398 ±  4%     +16.8%       8644 ±  4%  interrupts.CPU33.RES:Rescheduling_interrupts
>      611452 ±  2%     +10.2%     673609 ±  2%  interrupts.CPU34.LOC:Local_timer_interrupts
>        7414 ±  5%     +18.8%       8806 ±  4%  interrupts.CPU34.RES:Rescheduling_interrupts
>      611433 ±  2%     +10.2%     673588 ±  2%  interrupts.CPU35.LOC:Local_timer_interrupts
>        7486 ±  5%     +18.6%       8878 ±  3%  interrupts.CPU35.RES:Rescheduling_interrupts
>      611450 ±  2%     +10.2%     673603 ±  2%  interrupts.CPU36.LOC:Local_timer_interrupts
>        7503 ±  3%     +15.0%       8627 ±  3%  interrupts.CPU36.RES:Rescheduling_interrupts
>      611465 ±  2%     +10.2%     673611 ±  2%  interrupts.CPU37.LOC:Local_timer_interrupts
>        7416 ±  3%     +17.6%       8719 ±  2%  interrupts.CPU37.RES:Rescheduling_interrupts
>      611445 ±  2%     +10.2%     673575 ±  2%  interrupts.CPU38.LOC:Local_timer_interrupts
>        7477 ±  5%     +14.2%       8540 ±  3%  interrupts.CPU38.RES:Rescheduling_interrupts
>      611420 ±  2%     +10.2%     673600 ±  2%  interrupts.CPU39.LOC:Local_timer_interrupts
>        7562 ±  5%     +14.0%       8620 ±  4%  interrupts.CPU39.RES:Rescheduling_interrupts
>      611823 ±  2%     +10.2%     673949 ±  2%  interrupts.CPU4.LOC:Local_timer_interrupts
>        7579 ±  4%     +14.9%       8708 ±  3%  interrupts.CPU4.RES:Rescheduling_interrupts
>      611390 ±  2%     +10.2%     673618 ±  2%  interrupts.CPU40.LOC:Local_timer_interrupts
>        7444 ±  4%     +15.9%       8626 ±  3%  interrupts.CPU40.RES:Rescheduling_interrupts
>      611429 ±  2%     +10.2%     673612 ±  2%  interrupts.CPU41.LOC:Local_timer_interrupts
>        7464 ±  5%     +15.3%       8605 ±  2%  interrupts.CPU41.RES:Rescheduling_interrupts
>      611418 ±  2%     +10.2%     673597 ±  2%  interrupts.CPU42.LOC:Local_timer_interrupts
>        7394 ±  4%     +18.6%       8772 ±  5%  interrupts.CPU42.RES:Rescheduling_interrupts
>      611364 ±  2%     +10.2%     673601 ±  2%  interrupts.CPU43.LOC:Local_timer_interrupts
>        7483 ±  5%     +15.3%       8630 ±  3%  interrupts.CPU43.RES:Rescheduling_interrupts
>      611421 ±  2%     +10.2%     673593 ±  2%  interrupts.CPU44.LOC:Local_timer_interrupts
>        7463 ±  2%     +16.0%       8656 ±  4%  interrupts.CPU44.RES:Rescheduling_interrupts
>      611423 ±  2%     +10.2%     673593 ±  2%  interrupts.CPU45.LOC:Local_timer_interrupts
>        7455 ±  4%     +14.8%       8558 ±  3%  interrupts.CPU45.RES:Rescheduling_interrupts
>      611333 ±  2%     +10.2%     673616 ±  2%  interrupts.CPU46.LOC:Local_timer_interrupts
>        7406 ±  3%     +17.4%       8696 ±  3%  interrupts.CPU46.RES:Rescheduling_interrupts
>      611421 ±  2%     +10.2%     673605 ±  2%  interrupts.CPU47.LOC:Local_timer_interrupts
>        7482 ±  5%     +15.7%       8660 ±  2%  interrupts.CPU47.RES:Rescheduling_interrupts
>      610910 ±  2%     +10.3%     673737 ±  2%  interrupts.CPU48.LOC:Local_timer_interrupts
>        7521 ±  6%     +15.1%       8655 ±  4%  interrupts.CPU48.RES:Rescheduling_interrupts
>      610921 ±  2%     +10.3%     673770 ±  2%  interrupts.CPU49.LOC:Local_timer_interrupts
>        7594 ±  5%     +12.7%       8558 ±  3%  interrupts.CPU49.RES:Rescheduling_interrupts
>      611796 ±  2%     +10.1%     673831 ±  2%  interrupts.CPU5.LOC:Local_timer_interrupts
>      610930 ±  2%     +10.3%     673671 ±  2%  interrupts.CPU50.LOC:Local_timer_interrupts
>        7504 ±  2%     +17.6%       8824 ±  4%  interrupts.CPU50.RES:Rescheduling_interrupts
>      610882 ±  2%     +10.3%     673738 ±  2%  interrupts.CPU51.LOC:Local_timer_interrupts
>      610884 ±  2%     +10.3%     673731 ±  2%  interrupts.CPU52.LOC:Local_timer_interrupts
>        7436 ±  4%     +18.1%       8783 ±  3%  interrupts.CPU52.RES:Rescheduling_interrupts
>      610885 ±  2%     +10.3%     673774 ±  2%  interrupts.CPU53.LOC:Local_timer_interrupts
>        7544 ±  4%     +15.3%       8700 ±  4%  interrupts.CPU53.RES:Rescheduling_interrupts
>      610902 ±  2%     +10.3%     673763 ±  2%  interrupts.CPU54.LOC:Local_timer_interrupts
>        7534 ±  4%     +15.6%       8709 ±  6%  interrupts.CPU54.RES:Rescheduling_interrupts
>      610927 ±  2%     +10.3%     673739 ±  2%  interrupts.CPU55.LOC:Local_timer_interrupts
>      610883 ±  2%     +10.3%     673719 ±  2%  interrupts.CPU56.LOC:Local_timer_interrupts
>      610921 ±  2%     +10.3%     673689 ±  2%  interrupts.CPU57.LOC:Local_timer_interrupts
>        7473 ±  5%     +14.8%       8577 ±  4%  interrupts.CPU57.RES:Rescheduling_interrupts
>      610893 ±  2%     +10.3%     673781 ±  2%  interrupts.CPU58.LOC:Local_timer_interrupts
>        7407 ±  5%     +16.6%       8635 ±  3%  interrupts.CPU58.RES:Rescheduling_interrupts
>      610898 ±  2%     +10.3%     673763 ±  2%  interrupts.CPU59.LOC:Local_timer_interrupts
>        7642 ±  5%     +13.1%       8643 ±  3%  interrupts.CPU59.RES:Rescheduling_interrupts
>      611823 ±  2%     +10.1%     673914 ±  2%  interrupts.CPU6.LOC:Local_timer_interrupts
>        7542 ±  3%     +17.3%       8845 ±  3%  interrupts.CPU6.RES:Rescheduling_interrupts
>      610869 ±  2%     +10.3%     673784 ±  2%  interrupts.CPU60.LOC:Local_timer_interrupts
>        7535 ±  4%     +14.8%       8647 ±  5%  interrupts.CPU60.RES:Rescheduling_interrupts
>      610906 ±  2%     +10.3%     673701 ±  2%  interrupts.CPU61.LOC:Local_timer_interrupts
>        7631 ±  4%     +13.5%       8660 ±  4%  interrupts.CPU61.RES:Rescheduling_interrupts
>      610863 ±  2%     +10.3%     673705 ±  2%  interrupts.CPU62.LOC:Local_timer_interrupts
>        7634 ±  4%     +11.8%       8532 ±  4%  interrupts.CPU62.RES:Rescheduling_interrupts
>      610920 ±  2%     +10.3%     673730 ±  2%  interrupts.CPU63.LOC:Local_timer_interrupts
>        7549 ±  5%     +14.8%       8663 ±  5%  interrupts.CPU63.RES:Rescheduling_interrupts
>      610884 ±  2%     +10.3%     673727 ±  2%  interrupts.CPU64.LOC:Local_timer_interrupts
>        7644 ±  3%     +13.4%       8672 ±  3%  interrupts.CPU64.RES:Rescheduling_interrupts
>      610853 ±  2%     +10.3%     673708 ±  2%  interrupts.CPU65.LOC:Local_timer_interrupts
>        7555 ±  5%     +14.8%       8672 ±  3%  interrupts.CPU65.RES:Rescheduling_interrupts
>      610950 ±  2%     +10.3%     673804 ±  2%  interrupts.CPU66.LOC:Local_timer_interrupts
>        7457 ±  5%     +16.8%       8710 ±  4%  interrupts.CPU66.RES:Rescheduling_interrupts
>      610888 ±  2%     +10.3%     673735 ±  2%  interrupts.CPU67.LOC:Local_timer_interrupts
>        7550 ±  4%     +11.5%       8415 ±  5%  interrupts.CPU67.RES:Rescheduling_interrupts
>      610891 ±  2%     +10.3%     673727 ±  2%  interrupts.CPU68.LOC:Local_timer_interrupts
>        7612 ±  4%     +12.1%       8534 ±  3%  interrupts.CPU68.RES:Rescheduling_interrupts
>      610901 ±  2%     +10.3%     673659 ±  2%  interrupts.CPU69.LOC:Local_timer_interrupts
>        7493 ±  4%     +14.8%       8601 ±  4%  interrupts.CPU69.RES:Rescheduling_interrupts
>      611808 ±  2%     +10.1%     673844 ±  2%  interrupts.CPU7.LOC:Local_timer_interrupts
>        7673 ±  5%     +15.0%       8821 ±  4%  interrupts.CPU7.RES:Rescheduling_interrupts
>      610906 ±  2%     +10.3%     673733 ±  2%  interrupts.CPU70.LOC:Local_timer_interrupts
>        7412 ±  3%     +16.9%       8664 ±  4%  interrupts.CPU70.RES:Rescheduling_interrupts
>      610871 ±  2%     +10.3%     673671 ±  2%  interrupts.CPU71.LOC:Local_timer_interrupts
>        7519 ±  4%     +13.8%       8557 ±  5%  interrupts.CPU71.RES:Rescheduling_interrupts
>      611325 ±  2%     +10.2%     673906 ±  2%  interrupts.CPU72.LOC:Local_timer_interrupts
>        7720 ±  4%      +9.6%       8459 ±  4%  interrupts.CPU72.RES:Rescheduling_interrupts
>      611328 ±  2%     +10.2%     673908 ±  2%  interrupts.CPU73.LOC:Local_timer_interrupts
>        7535 ±  4%     +14.6%       8634 ±  4%  interrupts.CPU73.RES:Rescheduling_interrupts
>      611311 ±  2%     +10.2%     673883 ±  2%  interrupts.CPU74.LOC:Local_timer_interrupts
>        7526 ±  5%     +14.7%       8635 ±  6%  interrupts.CPU74.RES:Rescheduling_interrupts
>      611315 ±  2%     +10.2%     673868 ±  2%  interrupts.CPU75.LOC:Local_timer_interrupts
>        7712 ±  5%      +9.8%       8469 ±  4%  interrupts.CPU75.RES:Rescheduling_interrupts
>      611304 ±  2%     +10.2%     673860 ±  2%  interrupts.CPU76.LOC:Local_timer_interrupts
>        7476 ±  5%     +14.2%       8537 ±  5%  interrupts.CPU76.RES:Rescheduling_interrupts
>      611322 ±  2%     +10.2%     673834 ±  2%  interrupts.CPU77.LOC:Local_timer_interrupts
>        7670 ±  3%     +12.5%       8630 ±  5%  interrupts.CPU77.RES:Rescheduling_interrupts
>      611326 ±  2%     +10.2%     673851 ±  2%  interrupts.CPU78.LOC:Local_timer_interrupts
>        7417 ±  3%     +15.6%       8578 ±  4%  interrupts.CPU78.RES:Rescheduling_interrupts
>      611328 ±  2%     +10.2%     673820 ±  2%  interrupts.CPU79.LOC:Local_timer_interrupts
>        7545 ±  4%     +13.9%       8590 ±  4%  interrupts.CPU79.RES:Rescheduling_interrupts
>      611842 ±  2%     +10.1%     673928 ±  2%  interrupts.CPU8.LOC:Local_timer_interrupts
>        7673 ±  3%     +14.9%       8818 ±  4%  interrupts.CPU8.RES:Rescheduling_interrupts
>      611366 ±  2%     +10.2%     673868 ±  2%  interrupts.CPU80.LOC:Local_timer_interrupts
>        7513 ±  3%     +16.1%       8723 ±  5%  interrupts.CPU80.RES:Rescheduling_interrupts
>      611322 ±  2%     +10.2%     673860 ±  2%  interrupts.CPU81.LOC:Local_timer_interrupts
>      611299 ±  2%     +10.2%     673868 ±  2%  interrupts.CPU82.LOC:Local_timer_interrupts
>        7523 ±  4%     +13.8%       8562 ±  4%  interrupts.CPU82.RES:Rescheduling_interrupts
>      611320 ±  2%     +10.2%     673727 ±  2%  interrupts.CPU83.LOC:Local_timer_interrupts
>        7518 ±  5%     +12.4%       8454 ±  5%  interrupts.CPU83.RES:Rescheduling_interrupts
>      611326 ±  2%     +10.2%     673899 ±  2%  interrupts.CPU84.LOC:Local_timer_interrupts
>        7452 ±  6%     +12.3%       8365 ±  5%  interrupts.CPU84.RES:Rescheduling_interrupts
>      611329 ±  2%     +10.2%     673885 ±  2%  interrupts.CPU85.LOC:Local_timer_interrupts
>        7399 ±  5%     +11.1%       8218 ±  5%  interrupts.CPU85.RES:Rescheduling_interrupts
>      611278 ±  2%     +10.2%     673875 ±  2%  interrupts.CPU86.LOC:Local_timer_interrupts
>        7376 ±  4%     +16.3%       8581 ±  3%  interrupts.CPU86.RES:Rescheduling_interrupts
>      611313 ±  2%     +10.2%     673874 ±  2%  interrupts.CPU87.LOC:Local_timer_interrupts
>        7544 ±  4%     +12.8%       8508 ±  4%  interrupts.CPU87.RES:Rescheduling_interrupts
>      611351 ±  2%     +10.2%     673928 ±  2%  interrupts.CPU88.LOC:Local_timer_interrupts
>        7418 ±  6%     +13.3%       8406 ±  4%  interrupts.CPU88.RES:Rescheduling_interrupts
>      611324 ±  2%     +10.2%     673795 ±  2%  interrupts.CPU89.LOC:Local_timer_interrupts
>        7426 ±  4%     +13.6%       8439 ±  5%  interrupts.CPU89.RES:Rescheduling_interrupts
>      611832 ±  2%     +10.2%     673968 ±  2%  interrupts.CPU9.LOC:Local_timer_interrupts
>        7538 ±  3%     +15.6%       8715 ±  4%  interrupts.CPU9.RES:Rescheduling_interrupts
>      611298 ±  2%     +10.2%     673878 ±  2%  interrupts.CPU90.LOC:Local_timer_interrupts
>        7421 ±  3%     +12.7%       8363 ±  4%  interrupts.CPU90.RES:Rescheduling_interrupts
>      611305 ±  2%     +10.2%     673874 ±  2%  interrupts.CPU91.LOC:Local_timer_interrupts
>        7377 ±  5%     +15.6%       8528 ±  5%  interrupts.CPU91.RES:Rescheduling_interrupts
>      611288 ±  2%     +10.2%     673876 ±  2%  interrupts.CPU92.LOC:Local_timer_interrupts
>        7349 ±  4%     +12.0%       8234 ±  4%  interrupts.CPU92.RES:Rescheduling_interrupts
>      611329 ±  2%     +10.2%     673857 ±  2%  interrupts.CPU93.LOC:Local_timer_interrupts
>        7438 ±  3%     +14.7%       8530 ±  4%  interrupts.CPU93.RES:Rescheduling_interrupts
>      611276 ±  2%     +10.2%     673866 ±  2%  interrupts.CPU94.LOC:Local_timer_interrupts
>        7363 ±  4%     +12.7%       8300 ±  5%  interrupts.CPU94.RES:Rescheduling_interrupts
>      611381 ±  2%     +10.2%     673922 ±  2%  interrupts.CPU95.LOC:Local_timer_interrupts
>       10549 ±  3%     +14.9%      12117 ±  4%  interrupts.CPU95.RES:Rescheduling_interrupts
>      611824 ±  2%     +10.1%     673847 ±  2%  interrupts.CPU96.LOC:Local_timer_interrupts
>        7416 ±  3%     +12.9%       8375 ±  5%  interrupts.CPU96.RES:Rescheduling_interrupts
>      611751 ±  2%     +10.2%     673870 ±  2%  interrupts.CPU97.LOC:Local_timer_interrupts
>        7437 ±  4%     +14.0%       8477 ±  4%  interrupts.CPU97.RES:Rescheduling_interrupts
>      611787 ±  2%     +10.1%     673877 ±  2%  interrupts.CPU98.LOC:Local_timer_interrupts
>        7555 ±  4%     +13.0%       8534 ±  3%  interrupts.CPU98.RES:Rescheduling_interrupts
>      611783 ±  2%     +10.1%     673872 ±  2%  interrupts.CPU99.LOC:Local_timer_interrupts
>        7452 ±  3%     +12.8%       8404 ±  5%  interrupts.CPU99.RES:Rescheduling_interrupts
>   1.174e+08 ±  2%     +10.2%  1.294e+08 ±  2%  interrupts.LOC:Local_timer_interrupts
>     1433875 ±  3%     +14.6%    1643307 ±  3%  interrupts.RES:Rescheduling_interrupts
> 
> 
>                                                                                  
>                                    aim7.jobs-per-min
>                                                                                  
>    30500 +-------------------------------------------------------------------+
>          |                               ..+....                            .|
>    30000 |-+                       ......       ...                      ... |
>    29500 |................   ......                ..                 ...    |
>          |                +..                        ...            ..       |
>    29000 |-+                                            ...      ...         |
>    28500 |-+                                               .  ...            |
>          |                                                  +.               |
>    28000 |-+              O                                 O                |
>    27500 |-+                                                                 |
>          |                                                                   |
>    27000 |-+                                                                 |
>    26500 |-+                                                                 |
>          |                                 O                                 |
>    26000 +-------------------------------------------------------------------+
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
> Rong Chen
> 
> 
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
> 

-- 
Zhengjun Xing
