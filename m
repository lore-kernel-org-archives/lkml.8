Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0B2C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0739206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgGPK6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:58:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:61886 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbgGPK6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 06:58:45 -0400
IronPort-SDR: gAanSd639nPvZ1m+rChJApAxJbhZ4Z2lWB6UzqFbtqV3oSVnPZnKG7ahfr3PdlyNbfdfaqJg1o
 hwAJe21EFOoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="167477942"
X-IronPort-AV: E=Sophos;i="5.75,358,1589266800"; 
   d="yaml'?scan'208";a="167477942"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 02:17:18 -0700
IronPort-SDR: 8wXoIj16d4rnZp71LV+xO6DQbC1pPhK3L05FA3GGnrA/DgFpjONDBivjqPINCC0vZ2VOi5IjZq
 i2TP7BQkW8dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,358,1589266800"; 
   d="yaml'?scan'208";a="318363124"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by fmsmga002.fm.intel.com with ESMTP; 16 Jul 2020 02:17:14 -0700
Date:   Thu, 16 Jul 2020 17:16:46 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: [f2fs] ca7f76e680: aim7.jobs-per-min -84.0% regression
Message-ID: <20200716091646.GQ3874@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="v525F/vnNBtUxgKg"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v525F/vnNBtUxgKg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Greeting,

FYI, we noticed a -84.0% regression of aim7.jobs-per-min due to commit:


commit: ca7f76e680745d3b8a386638045f85dac1c4b2f4 ("f2fs: fix wrong discard space")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: aim7
on test machine: 192 threads Cooper Lake with 128G memory
with following parameters:

	disk: 1BRD_48G
	fs: f2fs
	test: sync_disk_rw
	load: 200
	cpufreq_governor: performance
	ucode: 0x86000017

test-description: AIM7 is a traditional UNIX system level benchmark suite which is used to test and measure the performance of multiuser system.
test-url: https://sourceforge.net/projects/aimbench/files/aim-suite7/

In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------+
| testcase: change | aim7: aim7.jobs-per-min -21.5% regression                            |
| test machine     | 72 threads Intel(R) Xeon(R) Gold 6139 CPU @ 2.30GHz with 128G memory |
| test parameters  | cpufreq_governor=performance                                         |
|                  | disk=4BRD_12G                                                        |
|                  | fs=f2fs                                                              |
|                  | load=100                                                             |
|                  | md=RAID0                                                             |
|                  | test=sync_disk_rw                                                    |
|                  | ucode=0x2006906                                                      |
+------------------+----------------------------------------------------------------------+
| testcase: change | aim7: aim7.jobs-per-min 41.5% improvement                            |
| test machine     | 48 threads Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz with 64G memory |
| test parameters  | cpufreq_governor=performance                                         |
|                  | disk=4BRD_12G                                                        |
|                  | fs=f2fs                                                              |
|                  | load=100                                                             |
|                  | md=RAID0                                                             |
|                  | test=sync_disk_rw                                                    |
|                  | ucode=0x42e                                                          |
+------------------+----------------------------------------------------------------------+


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
compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/1BRD_48G/f2fs/x86_64-rhel-7.6/200/debian-x86_64-20191114.cgz/lkp-cpx-4s1/sync_disk_rw/aim7/0x86000017

commit: 
  dc35d73a42 ("f2fs: compress: don't compress any datas after cp stop")
  ca7f76e680 ("f2fs: fix wrong discard space")

dc35d73a42291b2a ca7f76e680745d3b8a386638045 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          1:4          -25%            :4     dmesg.WARNING:at#for_ip_swapgs_restore_regs_and_return_to_usermode/0x
          1:4          -25%            :4     dmesg.WARNING:stack_recursion
         %stddev     %change         %stddev
             \          |                \  
      9718 ±  5%     -84.0%       1551 ±  2%  aim7.jobs-per-min
    123.86 ±  5%    +524.8%     773.86 ±  2%  aim7.time.elapsed_time
    123.86 ±  5%    +524.8%     773.86 ±  2%  aim7.time.elapsed_time.max
 1.677e+08            -4.7%  1.598e+08        aim7.time.file_system_outputs
     14409 ±  6%    +174.7%      39584        aim7.time.involuntary_context_switches
     43161 ±  5%    +165.1%     114401 ±  5%  aim7.time.minor_page_faults
      5084 ± 10%    +235.0%      17032 ±  2%  aim7.time.system_time
  37818809 ±  8%     -59.8%   15196997        aim7.time.voluntary_context_switches
     78.96           +12.0%      88.44        iostat.cpu.idle
     20.99 ±  5%     -44.9%      11.55        iostat.cpu.system
 2.442e+08 ± 10%     +34.5%  3.286e+08 ±  3%  cpuidle.C1.time
 1.835e+10 ±  4%    +602.9%   1.29e+11 ±  2%  cpuidle.C1E.time
  71315489 ±  7%    +286.7%  2.758e+08 ±  2%  cpuidle.C1E.usage
  16095925 ± 11%     -64.7%    5678857 ±  3%  cpuidle.POLL.time
   2746738 ± 18%     -57.8%    1158560 ±  3%  cpuidle.POLL.usage
     78.65            +9.8       88.41        mpstat.cpu.all.idle%
      0.00 ± 67%      -0.0        0.00        mpstat.cpu.all.iowait%
      0.00 ± 46%      -0.0        0.00 ± 32%  mpstat.cpu.all.soft%
     21.30 ±  5%      -9.7       11.58        mpstat.cpu.all.sys%
      0.05 ±  4%      -0.0        0.01        mpstat.cpu.all.usr%
     78.25           +12.5%      88.00        vmstat.cpu.id
    660515 ±  4%     -84.5%     102450        vmstat.io.bo
     39.00 ±  8%     -42.9%      22.25 ±  8%  vmstat.procs.r
    609170 ±  4%     -92.8%      43844        vmstat.system.cs
    393936            -2.3%     384708        vmstat.system.in
   3893167           +14.4%    4454392 ±  6%  numa-numastat.node0.local_node
   3916385           +14.3%    4477678 ±  6%  numa-numastat.node0.numa_hit
   3957801           +15.6%    4573717 ±  4%  numa-numastat.node1.local_node
   3988828           +15.2%    4597022 ±  4%  numa-numastat.node1.numa_hit
   3959446 ±  2%     +10.2%    4364905 ±  4%  numa-numastat.node2.local_node
   3982775 ±  2%     +10.2%    4388228 ±  4%  numa-numastat.node2.numa_hit
      8762 ±  3%     -13.1%       7615        meminfo.Active(file)
    105691 ±  2%     +97.8%     209021        meminfo.AnonHugePages
     94343 ±  5%     -26.5%      69352        meminfo.Dirty
     34124           -11.6%      30157        meminfo.Mapped
    385.50 ±100%    +366.7%       1799 ± 16%  meminfo.Mlocked
    117986 ±  2%     -18.8%      95836 ±  2%  meminfo.Shmem
      4537 ± 22%     -88.2%     537.25 ±  4%  meminfo.Writeback
    430496 ±  5%     -83.8%      69535 ±  2%  meminfo.max_used_kB
     24403 ±  4%     -27.6%      17676        numa-meminfo.node0.Dirty
     46840 ±  4%     +12.0%      52454        numa-meminfo.node0.Inactive
     45240           +12.5%      50914        numa-meminfo.node0.Inactive(file)
     86470 ±  4%      +8.4%      93692 ±  3%  numa-meminfo.node0.SUnreclaim
      1600 ± 14%     -84.1%     253.75 ±  5%  numa-meminfo.node0.Writeback
     24402 ±  2%     -27.2%      17773 ±  3%  numa-meminfo.node1.Dirty
     45722 ±  2%     +11.8%      51115 ±  4%  numa-meminfo.node1.Inactive(file)
      1460 ± 14%     -84.6%     225.25 ±  6%  numa-meminfo.node1.Writeback
      2133 ± 36%     -34.3%       1402 ±  2%  numa-meminfo.node2.Active(file)
     24071 ±  4%     -29.5%      16978 ±  2%  numa-meminfo.node2.Dirty
      1388 ± 22%     -85.1%     207.00 ±  5%  numa-meminfo.node2.Writeback
      2703 ± 41%     -29.8%       1898 ± 44%  numa-meminfo.node3.Active(file)
     23839 ±  5%     -28.8%      16968 ±  3%  numa-meminfo.node3.Dirty
     89570 ± 13%     -30.8%      61969 ± 18%  numa-meminfo.node3.Shmem
      1453 ± 20%     -85.5%     210.00 ±  8%  numa-meminfo.node3.Writeback
    547.00 ± 12%     +30.2%     712.25 ±  9%  slabinfo.UDP.active_objs
    547.00 ± 12%     +30.2%     712.25 ±  9%  slabinfo.UDP.num_objs
    199.75 ±  9%     +61.6%     322.75 ± 14%  slabinfo.biovec-128.active_objs
    199.75 ±  9%     +61.6%     322.75 ± 14%  slabinfo.biovec-128.num_objs
      4714 ± 15%     +29.7%       6112 ±  6%  slabinfo.blkdev_ioc.active_objs
      4714 ± 15%     +29.7%       6112 ±  6%  slabinfo.blkdev_ioc.num_objs
    133196 ±  2%     +11.1%     147989        slabinfo.dentry.active_objs
     22643           +18.8%      26897        slabinfo.f2fs_nat_entry.active_objs
     22643           +18.8%      26897        slabinfo.f2fs_nat_entry.num_objs
      7481 ±  7%     +16.0%       8674 ±  2%  slabinfo.files_cache.active_objs
      7481 ±  7%     +16.0%       8674 ±  2%  slabinfo.files_cache.num_objs
     53957 ±  4%     +13.2%      61099 ±  3%  slabinfo.filp.active_objs
    147.75 ± 12%    +195.1%     436.00 ± 34%  slabinfo.nfs_read_data.active_objs
    147.75 ± 12%    +195.1%     436.00 ± 34%  slabinfo.nfs_read_data.num_objs
      6205 ±  5%     +12.2%       6960 ±  3%  slabinfo.signal_cache.active_objs
      6209 ±  5%     +12.1%       6961 ±  3%  slabinfo.signal_cache.num_objs
    914.25 ± 12%     +48.1%       1354 ± 11%  slabinfo.skbuff_fclone_cache.active_objs
    914.25 ± 12%     +48.1%       1354 ± 11%  slabinfo.skbuff_fclone_cache.num_objs
      9691 ±  5%     +12.9%      10940 ±  2%  slabinfo.task_delay_info.active_objs
      9691 ±  5%     +12.9%      10940 ±  2%  slabinfo.task_delay_info.num_objs
      1172 ±  3%     +25.8%       1474 ±  6%  slabinfo.task_group.active_objs
      1172 ±  3%     +25.8%       1474 ±  6%  slabinfo.task_group.num_objs
     18617           +36.7%      25447        slabinfo.vmap_area.active_objs
    291.25           +48.7%     433.00        slabinfo.vmap_area.active_slabs
     18668           +48.6%      27746        slabinfo.vmap_area.num_objs
    291.25           +48.7%     433.00        slabinfo.vmap_area.num_slabs
      5829           -24.2%       4420        numa-vmstat.node0.nr_dirty
     11276           +12.9%      12735        numa-vmstat.node0.nr_inactive_file
     34.75 ±100%    +171.9%      94.50 ± 16%  numa-vmstat.node0.nr_mlock
     21619 ±  4%      +8.3%      23422 ±  3%  numa-vmstat.node0.nr_slab_unreclaimable
    355.50 ±  6%     -82.8%      61.00 ±  7%  numa-vmstat.node0.nr_writeback
     11276           +12.9%      12735        numa-vmstat.node0.nr_zone_inactive_file
      5746 ±  2%     -20.6%       4563        numa-vmstat.node0.nr_zone_write_pending
   2584629           +15.0%    2973365 ±  4%  numa-vmstat.node0.numa_hit
   2479967           +16.5%    2888507 ±  3%  numa-vmstat.node0.numa_local
      5899           -24.8%       4438 ±  3%  numa-vmstat.node1.nr_dirty
     11430 ±  2%     +11.8%      12777 ±  4%  numa-vmstat.node1.nr_inactive_file
     20.00 ±100%    +565.0%     133.00 ± 37%  numa-vmstat.node1.nr_mlock
    340.75 ±  4%     -83.1%      57.50 ±  7%  numa-vmstat.node1.nr_writeback
     11430 ±  2%     +11.8%      12778 ±  4%  numa-vmstat.node1.nr_zone_inactive_file
      5759 ±  2%     -20.4%       4583 ±  3%  numa-vmstat.node1.nr_zone_write_pending
   2739452 ±  5%     +18.3%    3239642 ±  4%  numa-vmstat.node1.numa_hit
   2699034 ±  5%     +18.1%    3186470 ±  4%  numa-vmstat.node1.numa_local
    539.25 ± 34%     -35.1%     350.00 ±  2%  numa-vmstat.node2.nr_active_file
      5901           -28.1%       4244 ±  2%  numa-vmstat.node2.nr_dirty
     20.00 ±100%    +432.5%     106.50 ±  5%  numa-vmstat.node2.nr_mlock
    316.75 ±  5%     -83.5%      52.25 ±  7%  numa-vmstat.node2.nr_writeback
    539.25 ± 34%     -35.1%     350.00 ±  2%  numa-vmstat.node2.nr_zone_active_file
      5744           -23.7%       4384 ±  2%  numa-vmstat.node2.nr_zone_write_pending
    683.50 ± 42%     -30.7%     474.00 ± 44%  numa-vmstat.node3.nr_active_file
      5895           -28.0%       4244 ±  3%  numa-vmstat.node3.nr_dirty
     20.00 ±100%    +468.8%     113.75 ± 35%  numa-vmstat.node3.nr_mlock
     22381 ± 13%     -30.8%      15490 ± 18%  numa-vmstat.node3.nr_shmem
    372.00 ± 14%     -86.3%      51.00 ±  7%  numa-vmstat.node3.nr_writeback
    683.50 ± 42%     -30.7%     474.00 ± 44%  numa-vmstat.node3.nr_zone_active_file
      5812           -24.6%       4383 ±  3%  numa-vmstat.node3.nr_zone_write_pending
     88147 ±  2%      -6.8%      82115        proc-vmstat.nr_active_anon
      2195 ±  3%     -13.5%       1899        proc-vmstat.nr_active_file
     51.00           +99.0%     101.50        proc-vmstat.nr_anon_transparent_hugepages
  20908425            -4.6%   19945976        proc-vmstat.nr_dirtied
     24004 ±  4%     -27.7%      17350        proc-vmstat.nr_dirty
    808024            -4.3%     773187        proc-vmstat.nr_dirty_background_threshold
   1618025            -4.3%    1548265        proc-vmstat.nr_dirty_threshold
   8129014            -4.3%    7776423        proc-vmstat.nr_free_pages
      9763            -4.0%       9369        proc-vmstat.nr_inactive_anon
     45357            +8.8%      49351        proc-vmstat.nr_inactive_file
     28741            -1.6%      28286        proc-vmstat.nr_kernel_stack
      8679           -11.7%       7665        proc-vmstat.nr_mapped
     96.00 ±100%    +368.2%     449.50 ± 16%  proc-vmstat.nr_mlock
     29512 ±  2%     -18.8%      23957 ±  2%  proc-vmstat.nr_shmem
     46356            +4.9%      48651        proc-vmstat.nr_slab_reclaimable
     84413            +2.9%      86874        proc-vmstat.nr_slab_unreclaimable
      1263 ± 20%     -89.2%     137.00 ±  2%  proc-vmstat.nr_writeback
  20817479            -4.6%   19855139        proc-vmstat.nr_written
     88147 ±  2%      -6.8%      82115        proc-vmstat.nr_zone_active_anon
      2195 ±  3%     -13.5%       1899        proc-vmstat.nr_zone_active_file
      9763            -4.0%       9369        proc-vmstat.nr_zone_inactive_anon
     45357            +8.8%      49351        proc-vmstat.nr_zone_inactive_file
     23820 ±  2%     -24.8%      17918        proc-vmstat.nr_zone_write_pending
     36458 ± 17%    +185.1%     103944 ±  5%  proc-vmstat.numa_hint_faults
     23603 ± 12%    +206.8%      72416 ±  7%  proc-vmstat.numa_hint_faults_local
  15799084           +10.7%   17491603        proc-vmstat.numa_hit
  15705866           +10.8%   17398307        proc-vmstat.numa_local
     45418 ± 25%    +150.3%     113680 ±  7%  proc-vmstat.numa_pte_updates
     38808 ±  2%     -34.8%      25292 ±  8%  proc-vmstat.pgactivate
  15902348           +11.1%   17664258        proc-vmstat.pgalloc_normal
     19611            -6.6%      18308        proc-vmstat.pgdeactivate
    517780 ±  4%    +425.5%    2721050 ±  2%  proc-vmstat.pgfault
   3286881           +56.0%    5126703        proc-vmstat.pgfree
  83335427            -4.6%   79469428        proc-vmstat.pgpgout
     39214            -6.7%      36580        proc-vmstat.pgrotated
    426.00 ±173%    +305.5%       1727 ± 25%  sched_debug.ISf2fs_discard-1
      2568           -44.4%       1428 ± 48%  sched_debug.SSf2fs_discard-1
      9509 ± 58%    +343.8%      42207 ±  3%  sched_debug.cfs_rq:/.exec_clock.avg
     10662 ± 58%    +430.8%      56597 ±  4%  sched_debug.cfs_rq:/.exec_clock.max
      9159 ± 58%    +314.6%      37973 ±  3%  sched_debug.cfs_rq:/.exec_clock.min
    168.21 ± 59%   +1167.7%       2132 ±  4%  sched_debug.cfs_rq:/.exec_clock.stddev
     96.23 ±158%     -96.0%       3.86 ±  2%  sched_debug.cfs_rq:/.load_avg.avg
     15350 ±168%     -99.2%     118.49 ±  6%  sched_debug.cfs_rq:/.load_avg.max
      1169 ±166%     -98.7%      14.65 ±  6%  sched_debug.cfs_rq:/.load_avg.stddev
    577658 ± 63%    +144.6%    1412797 ±  3%  sched_debug.cfs_rq:/.min_vruntime.avg
    629123 ± 61%    +178.8%    1753846 ±  5%  sched_debug.cfs_rq:/.min_vruntime.max
    536280 ± 64%    +136.6%    1268825 ±  3%  sched_debug.cfs_rq:/.min_vruntime.min
     15252 ± 57%    +300.0%      61008 ±  6%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.01 ± 77%   +1816.5%       0.22 ± 24%  sched_debug.cfs_rq:/.nr_spread_over.avg
      1.17 ± 65%    +225.7%       3.80 ± 46%  sched_debug.cfs_rq:/.nr_spread_over.max
      0.10 ± 69%    +390.4%       0.51 ± 19%  sched_debug.cfs_rq:/.nr_spread_over.stddev
    264.93 ±  5%     -47.9%     137.98 ±  6%  sched_debug.cfs_rq:/.runnable_avg.avg
      1944 ± 10%     -37.2%       1220 ±  5%  sched_debug.cfs_rq:/.runnable_avg.max
    354.10 ± 22%     -41.1%     208.59 ±  6%  sched_debug.cfs_rq:/.runnable_avg.stddev
     12322 ±118%    -568.9%     -57775        sched_debug.cfs_rq:/.spread0.avg
     63781 ± 55%    +344.2%     283311 ± 18%  sched_debug.cfs_rq:/.spread0.max
    -29081          +593.7%    -201735        sched_debug.cfs_rq:/.spread0.min
     15257 ± 57%    +299.9%      61010 ±  6%  sched_debug.cfs_rq:/.spread0.stddev
    429.50 ± 14%     +36.1%     584.46 ±  9%  sched_debug.cfs_rq:/.util_est_enqueued.max
   2454485 ± 68%     -56.7%    1062120 ±  5%  sched_debug.cpu.avg_idle.max
     86934 ± 29%    +370.8%     409324 ±  3%  sched_debug.cpu.clock.avg
     86949 ± 29%    +370.8%     409337 ±  3%  sched_debug.cpu.clock.max
     86920 ± 29%    +370.9%     409310 ±  3%  sched_debug.cpu.clock.min
     86934 ± 29%    +370.8%     409324 ±  3%  sched_debug.cpu.clock_task.avg
     86949 ± 29%    +370.8%     409337 ±  3%  sched_debug.cpu.clock_task.max
     86920 ± 29%    +370.9%     409310 ±  3%  sched_debug.cpu.clock_task.min
      4589 ± 19%    +217.5%      14570 ±  2%  sched_debug.cpu.curr->pid.max
    989.99 ± 23%     +39.1%       1377 ±  2%  sched_debug.cpu.curr->pid.stddev
   1309320 ± 61%     -59.4%     531938 ±  4%  sched_debug.cpu.max_idle_balance_cost.max
     76969 ± 71%     -94.8%       3992 ± 92%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.00 ±  6%     +24.3%       0.00 ±  4%  sched_debug.cpu.next_balance.stddev
      2061 ± 21%    +148.9%       5133 ±  8%  sched_debug.cpu.nr_switches.stddev
      0.44 ± 44%     +98.8%       0.88 ±  2%  sched_debug.cpu.nr_uninterruptible.avg
    369.83 ± 31%    +264.6%       1348 ±  3%  sched_debug.cpu.nr_uninterruptible.max
    -41.67          +123.5%     -93.14        sched_debug.cpu.nr_uninterruptible.min
     42.47 ± 35%    +302.5%     170.97 ±  3%  sched_debug.cpu.nr_uninterruptible.stddev
      1434 ± 51%    +238.3%       4853 ±  8%  sched_debug.cpu.sched_count.stddev
    708.18 ± 51%    +241.7%       2419 ±  8%  sched_debug.cpu.sched_goidle.stddev
    160.40 ± 57%    +751.6%       1365 ±  3%  sched_debug.cpu.ttwu_local.avg
    409.58 ± 50%    +673.3%       3167 ±  3%  sched_debug.cpu.ttwu_local.max
    123.92 ± 57%    +709.8%       1003 ±  3%  sched_debug.cpu.ttwu_local.min
     28.84 ± 50%    +697.6%     230.03 ±  2%  sched_debug.cpu.ttwu_local.stddev
     86920 ± 29%    +370.9%     409310 ±  3%  sched_debug.cpu_clk
     86165 ± 29%    +374.2%     408555 ±  3%  sched_debug.ktime
     87471 ± 28%    +368.6%     409862 ±  3%  sched_debug.sched_clk
     11.72 ±  3%     -61.9%       4.47        perf-stat.i.MPKI
 4.366e+09 ±  2%     -52.7%  2.065e+09        perf-stat.i.branch-instructions
      0.90            -0.4        0.47        perf-stat.i.branch-miss-rate%
  33346673           -72.5%    9156237        perf-stat.i.branch-misses
     46.06 ±  2%      -6.8       39.25        perf-stat.i.cache-miss-rate%
 1.133e+08 ±  4%     -85.2%   16812699        perf-stat.i.cache-misses
 2.365e+08 ±  2%     -82.1%   42330026        perf-stat.i.cache-references
    619615 ±  4%     -92.9%      43846        perf-stat.i.context-switches
      8.07           +23.6%       9.98        perf-stat.i.cpi
 1.715e+11 ±  4%     -42.6%   9.84e+10        perf-stat.i.cpu-cycles
     15218 ±  3%     -91.7%       1257        perf-stat.i.cpu-migrations
      1754 ± 15%    +245.6%       6063        perf-stat.i.cycles-between-cache-misses
      0.11 ± 15%      -0.1        0.03 ±  5%  perf-stat.i.dTLB-load-miss-rate%
   5760569 ± 14%     -88.8%     646357 ±  6%  perf-stat.i.dTLB-load-misses
 5.158e+09 ±  2%     -52.0%  2.476e+09        perf-stat.i.dTLB-loads
      0.02 ±  4%      -0.0        0.01 ±  5%  perf-stat.i.dTLB-store-miss-rate%
    301489 ±  4%     -88.8%      33754 ±  5%  perf-stat.i.dTLB-store-misses
 1.438e+09           -73.4%  3.826e+08        perf-stat.i.dTLB-stores
     26.80 ±  2%      +7.0       33.83        perf-stat.i.iTLB-load-miss-rate%
   5449055 ±  2%     -51.1%    2663883        perf-stat.i.iTLB-load-misses
  15569126 ±  2%     -66.5%    5213640        perf-stat.i.iTLB-loads
 2.033e+10 ±  2%     -52.0%  9.767e+09        perf-stat.i.instructions
      0.14           -24.4%       0.10        perf-stat.i.ipc
      0.89 ±  4%     -42.6%       0.51        perf-stat.i.metric.GHz
      0.24 ±  6%    +310.4%       0.99 ±  9%  perf-stat.i.metric.K/sec
     58.77           -55.9%      25.93        perf-stat.i.metric.M/sec
      3991           -14.0%       3433        perf-stat.i.minor-faults
  49266301 ±  3%     -87.7%    6077578        perf-stat.i.node-load-misses
   2597551 ±  5%     -85.8%     369668        perf-stat.i.node-loads
  15916313 ±  2%     -88.1%    1895324        perf-stat.i.node-store-misses
    786887 ±  2%     -85.9%     111094 ± 16%  perf-stat.i.node-stores
      3991           -14.0%       3433        perf-stat.i.page-faults
     11.65 ±  4%     -62.8%       4.34        perf-stat.overall.MPKI
      0.76 ±  3%      -0.3        0.44        perf-stat.overall.branch-miss-rate%
     47.88 ±  2%      -8.2       39.72        perf-stat.overall.cache-miss-rate%
      8.43 ±  2%     +19.5%      10.08        perf-stat.overall.cpi
      1520 ±  9%    +285.1%       5853 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.11 ± 14%      -0.1        0.03 ±  5%  perf-stat.overall.dTLB-load-miss-rate%
      0.02 ±  5%      -0.0        0.01 ±  5%  perf-stat.overall.dTLB-store-miss-rate%
     25.93 ±  2%      +7.9       33.82        perf-stat.overall.iTLB-load-miss-rate%
      0.12 ±  2%     -16.3%       0.10        perf-stat.overall.ipc
 4.332e+09 ±  2%     -52.4%  2.062e+09        perf-stat.ps.branch-instructions
  33080319           -72.3%    9148763        perf-stat.ps.branch-misses
 1.124e+08 ±  4%     -85.1%   16790400        perf-stat.ps.cache-misses
 2.347e+08 ±  2%     -82.0%   42274864        perf-stat.ps.cache-references
    614846 ±  4%     -92.9%      43787        perf-stat.ps.context-switches
 1.702e+11 ±  4%     -42.3%  9.827e+10        perf-stat.ps.cpu-cycles
     15105 ±  3%     -91.7%       1256        perf-stat.ps.cpu-migrations
   5707734 ± 14%     -88.7%     645484 ±  6%  perf-stat.ps.dTLB-load-misses
 5.117e+09 ±  2%     -51.7%  2.473e+09        perf-stat.ps.dTLB-loads
    299077 ±  4%     -88.7%      33716 ±  5%  perf-stat.ps.dTLB-store-misses
 1.426e+09           -73.2%  3.822e+08        perf-stat.ps.dTLB-stores
   5405745           -50.8%    2660424        perf-stat.ps.iTLB-load-misses
  15446967 ±  2%     -66.3%    5206800        perf-stat.ps.iTLB-loads
 2.017e+10 ±  2%     -51.6%  9.754e+09        perf-stat.ps.instructions
      3949           -13.2%       3429        perf-stat.ps.minor-faults
  48882546 ±  3%     -87.6%    6069413        perf-stat.ps.node-load-misses
   2577627 ±  5%     -85.7%     369180        perf-stat.ps.node-loads
  15787108 ±  2%     -88.0%    1892764        perf-stat.ps.node-store-misses
    780361 ±  2%     -85.8%     110953 ± 16%  perf-stat.ps.node-stores
      3949           -13.2%       3429        perf-stat.ps.page-faults
 2.514e+12 ±  7%    +200.6%  7.558e+12        perf-stat.total.instructions
     35.61 ±  3%     -16.0       19.57 ±  2%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     36.91 ±  3%     -14.9       22.03 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     36.98 ±  3%     -14.4       22.55 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     39.29 ±  3%     -13.8       25.52 ±  3%  perf-profile.calltrace.cycles-pp.secondary_startup_64
     39.06 ±  3%     -13.7       25.38 ±  3%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
     39.06 ±  3%     -13.7       25.38 ±  3%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
     39.06 ±  3%     -13.7       25.38 ±  3%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     10.62 ±  4%     -10.6        0.00        perf-profile.calltrace.cycles-pp.set_node_addr.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
     10.50 ±  4%     -10.5        0.00        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.set_node_addr.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
     10.15 ±  4%     -10.1        0.00        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.set_node_addr.__write_node_page.f2fs_fsync_node_pages
      9.47 ±  4%      -9.5        0.00        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.set_node_addr.__write_node_page
      9.31            -7.6        1.68 ±  7%  perf-profile.calltrace.cycles-pp.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      8.52 ±  2%      -7.1        1.40 ±  8%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      8.48 ±  2%      -7.1        1.39 ±  8%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file
      8.23 ±  2%      -6.9        1.35 ±  8%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_fsync_node_pages
      4.19 ±  8%      -2.9        1.33 ±  3%  perf-profile.calltrace.cycles-pp.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page
      4.00 ±  9%      -2.7        1.29 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page
      4.00 ±  9%      -2.7        1.29 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data
      3.44 ± 28%      -2.7        0.78 ± 23%  perf-profile.calltrace.cycles-pp.f2fs_space_for_roll_forward.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
      3.42 ± 28%      -2.7        0.77 ± 22%  perf-profile.calltrace.cycles-pp.__percpu_counter_sum.f2fs_space_for_roll_forward.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      3.73 ±  2%      -2.4        1.35 ± 10%  perf-profile.calltrace.cycles-pp.f2fs_allocate_data_block.do_write_page.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages
      2.94 ± 30%      -2.3        0.66 ± 24%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__percpu_counter_sum.f2fs_space_for_roll_forward.f2fs_do_sync_file.f2fs_file_write_iter
      2.90 ± 31%      -2.3        0.65 ± 24%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__percpu_counter_sum.f2fs_space_for_roll_forward.f2fs_do_sync_file
      2.89 ±  5%      -2.0        0.91 ±  4%  perf-profile.calltrace.cycles-pp.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.__filemap_fdatawrite_range
      3.21 ±  2%      -2.0        1.25 ± 10%  perf-profile.calltrace.cycles-pp.__mutex_lock.f2fs_allocate_data_block.do_write_page.f2fs_do_write_node_page.__write_node_page
      7.10 ±  4%      -1.8        5.32 ±  8%  perf-profile.calltrace.cycles-pp.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      7.10 ±  4%      -1.8        5.32 ±  8%  perf-profile.calltrace.cycles-pp.do_write_page.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      6.75 ±  2%      -1.7        5.03 ±  7%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page
      2.88 ±  3%      -1.7        1.18 ± 10%  perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.f2fs_allocate_data_block.do_write_page.f2fs_do_write_node_page
      2.03 ±  7%      -1.3        0.69 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages
      2.00 ±  7%      -1.3        0.68 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages
      1.85 ±  8%      -1.2        0.63 ±  3%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_write_cache_pages
      0.57 ±  4%      +0.5        1.02 ± 14%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +0.6        0.60 ± 10%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry
      3.33 ±  6%      +0.6        3.95 ±  9%  perf-profile.calltrace.cycles-pp.f2fs_submit_page_write.do_write_page.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages
      0.00            +0.6        0.64 ± 10%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry.start_secondary
      3.16 ±  6%      +0.7        3.90 ±  9%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_do_write_node_page.__write_node_page
      3.16 ±  6%      +0.7        3.89 ±  9%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_do_write_node_page
      1.00 ±  3%      +0.9        1.87 ± 12%  perf-profile.calltrace.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      1.07 ±  3%      +1.6        2.71 ± 20%  perf-profile.calltrace.cycles-pp.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.00            +2.5        2.52 ± 11%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     13.59 ±  2%      +4.8       18.40 ±  3%  perf-profile.calltrace.cycles-pp.file_write_and_wait_range.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
     13.57 ±  2%      +4.8       18.39 ±  3%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.file_write_and_wait_range.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
     13.55 ±  2%      +4.8       18.39 ±  3%  perf-profile.calltrace.cycles-pp.do_writepages.__filemap_fdatawrite_range.file_write_and_wait_range.f2fs_do_sync_file.f2fs_file_write_iter
     13.55 ±  2%      +4.8       18.39 ±  3%  perf-profile.calltrace.cycles-pp.f2fs_write_data_pages.do_writepages.__filemap_fdatawrite_range.file_write_and_wait_range.f2fs_do_sync_file
     13.46 ±  2%      +4.9       18.36 ±  3%  perf-profile.calltrace.cycles-pp.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.__filemap_fdatawrite_range.file_write_and_wait_range
     10.34            +7.1       17.40 ±  3%  perf-profile.calltrace.cycles-pp.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.__filemap_fdatawrite_range
     10.12            +7.2       17.36 ±  3%  perf-profile.calltrace.cycles-pp.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages
      7.90 ±  4%      +9.2       17.14 ±  3%  perf-profile.calltrace.cycles-pp.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages
      7.69 ±  4%      +9.4       17.07 ±  3%  perf-profile.calltrace.cycles-pp.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages
      3.46           +12.3       15.73 ±  3%  perf-profile.calltrace.cycles-pp.f2fs_allocate_data_block.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page
     60.07 ±  2%     +14.2       74.27        perf-profile.calltrace.cycles-pp.write
     60.02 ±  2%     +14.2       74.26        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     60.02 ±  2%     +14.2       74.26        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     59.99 ±  2%     +14.3       74.26        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     59.98 ±  2%     +14.3       74.25        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     59.95 ±  2%     +14.3       74.24        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     59.94 ±  2%     +14.3       74.24        perf-profile.calltrace.cycles-pp.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
     59.16 ±  2%     +14.6       73.76        perf-profile.calltrace.cycles-pp.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_write
      0.00           +15.3       15.25 ±  4%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.f2fs_allocate_data_block.do_write_page
      0.00           +15.5       15.45 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.f2fs_allocate_data_block.do_write_page.f2fs_outplace_write_data
      0.00           +15.5       15.53 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.f2fs_allocate_data_block.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page
     34.81 ±  3%     +19.2       54.03 ±  2%  perf-profile.calltrace.cycles-pp.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
     20.27 ±  5%     +31.5       51.73 ±  3%  perf-profile.calltrace.cycles-pp.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.00           +42.8       42.85 ±  5%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_read_slowpath.__write_node_page.f2fs_fsync_node_pages
      0.00           +45.8       45.75 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_read_slowpath.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00           +45.9       45.94 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
     35.82 ±  3%     -16.1       19.67 ±  2%  perf-profile.children.cycles-pp.intel_idle
     37.19 ±  3%     -14.5       22.68 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter
     37.19 ±  3%     -14.5       22.68 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter_state
     39.29 ±  3%     -13.8       25.52 ±  3%  perf-profile.children.cycles-pp.secondary_startup_64
     39.29 ±  3%     -13.8       25.52 ±  3%  perf-profile.children.cycles-pp.cpu_startup_entry
     39.30 ±  3%     -13.8       25.53 ±  3%  perf-profile.children.cycles-pp.do_idle
     39.06 ±  3%     -13.7       25.38 ±  3%  perf-profile.children.cycles-pp.start_secondary
     10.65 ±  4%     -10.4        0.28 ±  5%  perf-profile.children.cycles-pp.set_node_addr
     12.25 ±  2%      -9.6        2.69 ±  6%  perf-profile.children.cycles-pp.__submit_merged_write_cond
      6.55 ± 17%      -5.7        0.81 ± 20%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      6.10            -4.8        1.25 ± 10%  perf-profile.children.cycles-pp.__mutex_lock
      3.76 ± 14%      -3.5        0.21 ±  5%  perf-profile.children.cycles-pp.f2fs_need_inode_block_update
      3.34 ±  6%      -3.3        0.09 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      3.77 ± 24%      -2.9        0.88 ± 19%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      2.96 ± 24%      -2.8        0.14 ±  7%  perf-profile.children.cycles-pp.f2fs_get_node_info
      2.84 ± 25%      -2.8        0.04 ± 58%  perf-profile.children.cycles-pp.f2fs_is_checkpointed_node
      3.44 ± 28%      -2.7        0.78 ± 23%  perf-profile.children.cycles-pp.f2fs_space_for_roll_forward
      3.42 ± 28%      -2.6        0.77 ± 22%  perf-profile.children.cycles-pp.__percpu_counter_sum
      7.52            -2.2        5.28 ±  7%  perf-profile.children.cycles-pp.f2fs_submit_page_write
      7.10 ±  4%      -1.8        5.32 ±  8%  perf-profile.children.cycles-pp.f2fs_do_write_node_page
      2.15            -1.8        0.37 ±  9%  perf-profile.children.cycles-pp.find_get_pages_range_tag
      2.15            -1.8        0.37 ±  8%  perf-profile.children.cycles-pp.pagevec_lookup_range_tag
      1.41 ±  6%      -1.3        0.15 ±  8%  perf-profile.children.cycles-pp.ttwu_do_activate
      1.41 ±  5%      -1.3        0.15 ±  8%  perf-profile.children.cycles-pp.activate_task
      1.41 ±  6%      -1.3        0.15 ±  8%  perf-profile.children.cycles-pp.enqueue_task_fair
      1.36 ±  2%      -1.2        0.14 ±  8%  perf-profile.children.cycles-pp.rwsem_wake
      1.31 ±  6%      -1.2        0.14 ±  9%  perf-profile.children.cycles-pp.enqueue_entity
      1.27 ±  3%      -1.1        0.16 ±  5%  perf-profile.children.cycles-pp.try_to_wake_up
      1.20 ±  2%      -1.1        0.12 ±  6%  perf-profile.children.cycles-pp.wake_up_q
      1.21            -1.1        0.14 ± 12%  perf-profile.children.cycles-pp.release_pages
      1.21            -1.1        0.14 ± 12%  perf-profile.children.cycles-pp.__pagevec_release
      1.18 ±  6%      -1.0        0.13 ±  6%  perf-profile.children.cycles-pp.sched_ttwu_pending
      1.41 ±  3%      -0.9        0.50 ±  4%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.98 ±  6%      -0.9        0.11 ±  7%  perf-profile.children.cycles-pp.__account_scheduler_latency
      0.88 ±  2%      -0.7        0.23 ± 10%  perf-profile.children.cycles-pp.submit_bio
      0.88 ±  2%      -0.6        0.23 ± 10%  perf-profile.children.cycles-pp.generic_make_request
      0.72 ±  5%      -0.6        0.08 ± 10%  perf-profile.children.cycles-pp.stack_trace_save_tsk
      0.86 ±  2%      -0.6        0.22 ± 12%  perf-profile.children.cycles-pp.brd_make_request
      0.67 ±  5%      -0.6        0.08 ±  5%  perf-profile.children.cycles-pp.arch_stack_walk
      0.77 ±  3%      -0.6        0.20 ± 12%  perf-profile.children.cycles-pp.__submit_merged_bio
      0.61 ±  6%      -0.6        0.06 ±  9%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      0.67 ±  2%      -0.5        0.16 ±  4%  perf-profile.children.cycles-pp.__generic_file_write_iter
      0.55 ±  5%      -0.5        0.06 ± 11%  perf-profile.children.cycles-pp.unwind_next_frame
      0.64 ±  2%      -0.5        0.16 ±  5%  perf-profile.children.cycles-pp.generic_perform_write
      0.60 ±  4%      -0.4        0.16 ±  5%  perf-profile.children.cycles-pp.__sched_text_start
      0.53            -0.4        0.15 ± 11%  perf-profile.children.cycles-pp._raw_spin_lock
      0.50 ±  2%      -0.4        0.13 ± 11%  perf-profile.children.cycles-pp.brd_do_bvec
      0.45 ±  3%      -0.3        0.14 ±  6%  perf-profile.children.cycles-pp.schedule
      0.41 ±  5%      -0.3        0.10 ±  5%  perf-profile.children.cycles-pp.down_read
      0.36 ±  3%      -0.3        0.08 ±  5%  perf-profile.children.cycles-pp.f2fs_write_begin
      0.34 ±  3%      -0.2        0.09 ±  9%  perf-profile.children.cycles-pp.f2fs_write_end_io
      0.30 ±  2%      -0.2        0.06 ±  6%  perf-profile.children.cycles-pp.__get_node_page
      0.23 ±  2%      -0.2        0.03 ±100%  perf-profile.children.cycles-pp.update_sit_entry
      0.24 ±  3%      -0.2        0.06 ± 14%  perf-profile.children.cycles-pp.brd_insert_page
      0.24 ±  3%      -0.2        0.06 ±  6%  perf-profile.children.cycles-pp.f2fs_set_node_page_dirty
      0.25            -0.2        0.07        perf-profile.children.cycles-pp.__set_page_dirty_nobuffers
      0.23 ±  5%      -0.2        0.06 ±  9%  perf-profile.children.cycles-pp.f2fs_is_valid_blkaddr
      0.20 ±  2%      -0.2        0.04 ± 58%  perf-profile.children.cycles-pp.f2fs_write_end
      0.20 ±  3%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.f2fs_update_data_blkaddr
      0.20 ±  3%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.f2fs_set_data_blkaddr
      0.21 ±  2%      -0.1        0.07 ±  5%  perf-profile.children.cycles-pp.ret_from_fork
      0.21 ±  3%      -0.1        0.07 ±  5%  perf-profile.children.cycles-pp.kthread
      0.15 ±  2%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.down_write
      0.21 ±  3%      -0.1        0.09 ±  7%  perf-profile.children.cycles-pp.f2fs_issue_flush
      0.23 ±  3%      -0.1        0.12 ±  7%  perf-profile.children.cycles-pp.update_load_avg
      0.17            -0.1        0.07 ± 10%  perf-profile.children.cycles-pp.__test_set_page_writeback
      0.23 ±  6%      -0.1        0.14 ± 17%  perf-profile.children.cycles-pp.start_kernel
      0.15 ±  3%      -0.1        0.09 ±  9%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.11 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.wait_for_completion
      0.10 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.schedule_timeout
      0.08 ±  8%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.08            -0.0        0.07 ±  6%  perf-profile.children.cycles-pp._find_next_bit
      0.07 ±  6%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.__next_timer_interrupt
      0.11 ±  6%      +0.0        0.13 ±  9%  perf-profile.children.cycles-pp.update_cfs_group
      0.10            +0.0        0.13 ±  9%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.09 ±  9%      +0.0        0.12 ±  7%  perf-profile.children.cycles-pp.find_busiest_group
      0.08 ±  5%      +0.0        0.11 ±  7%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.08 ±  5%      +0.0        0.11 ± 11%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.10 ±  7%      +0.0        0.14 ±  8%  perf-profile.children.cycles-pp.load_balance
      0.07            +0.0        0.11 ±  8%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.07 ± 21%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.f2fs_wait_on_page_writeback
      0.07 ±  6%      +0.0        0.11 ± 12%  perf-profile.children.cycles-pp.native_write_msr
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.read_tsc
      0.01 ±173%      +0.1        0.08 ± 24%  perf-profile.children.cycles-pp.run_local_timers
      0.08 ±  8%      +0.1        0.15 ± 11%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.00            +0.1        0.08 ± 11%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.00            +0.1        0.10 ± 13%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.11 ±  4%      +0.1        0.21 ± 11%  perf-profile.children.cycles-pp.rebalance_domains
      0.14 ±  3%      +0.1        0.24 ± 16%  perf-profile.children.cycles-pp.tick_irq_enter
      0.00            +0.1        0.11 ±  7%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.00            +0.1        0.11 ±  7%  perf-profile.children.cycles-pp.update_blocked_averages
      0.15 ±  3%      +0.1        0.26 ± 13%  perf-profile.children.cycles-pp.irq_enter
      0.00            +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.10 ± 12%      +0.1        0.24 ±  7%  perf-profile.children.cycles-pp.task_tick_fair
      0.32 ±  3%      +0.1        0.46 ± 19%  perf-profile.children.cycles-pp.clockevents_program_event
      0.23 ±  3%      +0.2        0.41 ±  9%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.19 ±  3%      +0.2        0.38 ±  2%  perf-profile.children.cycles-pp.scheduler_tick
      0.10 ± 14%      +0.2        0.33 ± 11%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      0.29 ±  4%      +0.2        0.52 ±  5%  perf-profile.children.cycles-pp.update_process_times
      0.30 ±  2%      +0.2        0.53 ±  5%  perf-profile.children.cycles-pp.tick_sched_handle
      0.56 ±  3%      +0.3        0.82 ± 16%  perf-profile.children.cycles-pp.ktime_get
      0.33 ±  3%      +0.3        0.59 ±  9%  perf-profile.children.cycles-pp.irq_exit
      0.38 ±  2%      +0.3        0.64 ±  5%  perf-profile.children.cycles-pp.tick_sched_timer
      0.00            +0.3        0.29 ± 16%  perf-profile.children.cycles-pp.f2fs_preallocate_blocks
      0.00            +0.3        0.29 ± 16%  perf-profile.children.cycles-pp.f2fs_convert_inline_inode
      0.00            +0.3        0.29 ± 16%  perf-profile.children.cycles-pp.f2fs_convert_inline_page
      0.26 ±  9%      +0.3        0.60 ± 10%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.29 ±  8%      +0.4        0.65 ±  9%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.45 ±  2%      +0.4        0.83 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.86 ±  3%      +0.6        1.45 ± 10%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.36 ±  2%      +1.0        2.33 ±  9%  perf-profile.children.cycles-pp.smp_apic_timer_interrupt
      1.45 ±  2%      +1.5        2.90 ±  9%  perf-profile.children.cycles-pp.apic_timer_interrupt
      0.47 ±  6%      +2.1        2.53 ± 11%  perf-profile.children.cycles-pp.menu_select
     18.71            +2.8       21.52 ±  3%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     13.59 ±  2%      +4.8       18.40 ±  3%  perf-profile.children.cycles-pp.file_write_and_wait_range
     13.57 ±  2%      +4.8       18.39 ±  3%  perf-profile.children.cycles-pp.__filemap_fdatawrite_range
     13.55 ±  2%      +4.8       18.39 ±  3%  perf-profile.children.cycles-pp.do_writepages
     13.55 ±  2%      +4.8       18.39 ±  3%  perf-profile.children.cycles-pp.f2fs_write_data_pages
     13.46 ±  2%      +4.9       18.36 ±  3%  perf-profile.children.cycles-pp.f2fs_write_cache_pages
     10.34            +7.1       17.40 ±  3%  perf-profile.children.cycles-pp.f2fs_write_single_data_page
     10.12            +7.2       17.36 ±  3%  perf-profile.children.cycles-pp.f2fs_do_write_data_page
     14.79            +7.9       22.69 ±  4%  perf-profile.children.cycles-pp.do_write_page
      7.91 ±  4%      +9.5       17.43 ±  3%  perf-profile.children.cycles-pp.f2fs_outplace_write_data
      7.19           +10.2       17.36 ±  4%  perf-profile.children.cycles-pp.f2fs_allocate_data_block
     60.35 ±  2%     +14.0       74.34        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     60.34 ±  2%     +14.0       74.34        perf-profile.children.cycles-pp.do_syscall_64
     60.08 ±  2%     +14.2       74.27        perf-profile.children.cycles-pp.write
     60.00 ±  2%     +14.3       74.26        perf-profile.children.cycles-pp.ksys_write
     60.00 ±  2%     +14.3       74.25        perf-profile.children.cycles-pp.vfs_write
     59.97 ±  2%     +14.3       74.24        perf-profile.children.cycles-pp.new_sync_write
     59.94 ±  2%     +14.3       74.24        perf-profile.children.cycles-pp.f2fs_file_write_iter
     59.16 ±  2%     +14.6       73.76        perf-profile.children.cycles-pp.f2fs_do_sync_file
     34.81 ±  3%     +19.2       54.03 ±  2%  perf-profile.children.cycles-pp.f2fs_fsync_node_pages
     20.74 ±  8%     +27.7       48.45 ±  4%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
     38.52 ±  5%     +28.9       67.45 ±  2%  perf-profile.children.cycles-pp.osq_lock
     20.27 ±  5%     +31.5       51.73 ±  3%  perf-profile.children.cycles-pp.__write_node_page
     35.20 ±  6%     +34.6       69.76        perf-profile.children.cycles-pp.rwsem_optimistic_spin
     35.82 ±  3%     -16.1       19.67 ±  2%  perf-profile.self.cycles-pp.intel_idle
      6.55 ± 17%      -5.7        0.81 ± 21%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.97            -1.6        0.33 ±  9%  perf-profile.self.cycles-pp.find_get_pages_range_tag
      1.18            -1.0        0.14 ± 16%  perf-profile.self.cycles-pp.release_pages
      1.39 ±  3%      -1.0        0.41 ±  4%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.60 ±  6%      -0.5        0.06 ±  9%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      0.41 ±  5%      -0.4        0.03 ±100%  perf-profile.self.cycles-pp.unwind_next_frame
      0.49            -0.4        0.14 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.47 ±  2%      -0.3        0.14 ± 11%  perf-profile.self.cycles-pp._raw_spin_lock
      0.41 ± 15%      -0.3        0.10 ± 15%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.39 ±  5%      -0.3        0.10 ±  5%  perf-profile.self.cycles-pp.down_read
      0.35 ±  4%      -0.3        0.08 ±  6%  perf-profile.self.cycles-pp.f2fs_fsync_node_pages
      0.23 ±  2%      -0.2        0.03 ±100%  perf-profile.self.cycles-pp.update_sit_entry
      0.23 ±  3%      -0.2        0.06 ±  9%  perf-profile.self.cycles-pp.f2fs_is_valid_blkaddr
      0.20 ±  2%      -0.2        0.03 ±100%  perf-profile.self.cycles-pp.brd_do_bvec
      0.11 ±  6%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.update_load_avg
      0.06 ± 14%      +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.11 ±  6%      +0.0        0.13 ±  9%  perf-profile.self.cycles-pp.update_cfs_group
      0.07 ±  7%      +0.0        0.09 ± 13%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.08 ±  5%      +0.0        0.11 ± 11%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.07 ±  6%      +0.0        0.10 ± 10%  perf-profile.self.cycles-pp.native_write_msr
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.read_tsc
      0.00            +0.1        0.07 ± 24%  perf-profile.self.cycles-pp.run_local_timers
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.update_blocked_averages
      0.00            +0.1        0.10 ± 13%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.04 ± 57%      +0.1        0.14 ± 14%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.10 ± 14%      +0.2        0.33 ± 11%  perf-profile.self.cycles-pp.timekeeping_max_deferment
      0.53 ±  4%      +0.2        0.77 ± 17%  perf-profile.self.cycles-pp.ktime_get
      0.09 ±  9%      +0.9        0.96 ± 10%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.15            +1.7        1.86 ± 12%  perf-profile.self.cycles-pp.menu_select
      0.54 ±  3%      +2.5        3.04 ±  4%  perf-profile.self.cycles-pp.rwsem_optimistic_spin
     38.28 ±  5%     +28.7       67.02 ±  2%  perf-profile.self.cycles-pp.osq_lock
     24401 ± 11%     +43.5%      35014        softirqs.CPU0.RCU
     28116 ±  5%    +258.8%     100877 ±  2%  softirqs.CPU0.SCHED
     54628 ±  3%    +435.2%     292346 ±  2%  softirqs.CPU0.TIMER
     25280 ± 12%     +44.1%      36429        softirqs.CPU1.RCU
     21111 ±  4%    +321.6%      89013 ±  4%  softirqs.CPU1.SCHED
     50523          +486.0%     296070 ±  7%  softirqs.CPU1.TIMER
     26100 ± 12%     +41.5%      36928        softirqs.CPU10.RCU
     21502 ± 11%    +326.5%      91703 ±  2%  softirqs.CPU10.SCHED
     59789 ± 29%    +395.8%     296432 ±  6%  softirqs.CPU10.TIMER
     24849 ± 10%     +43.7%      35707 ±  2%  softirqs.CPU100.RCU
     20253 ±  3%    +341.1%      89334 ±  5%  softirqs.CPU100.SCHED
     49976 ±  3%    +464.3%     282020 ±  2%  softirqs.CPU100.TIMER
     24883 ± 10%     +45.4%      36186 ±  2%  softirqs.CPU101.RCU
     18885 ± 14%    +385.7%      91733 ±  2%  softirqs.CPU101.SCHED
     49098 ±  3%    +473.4%     281512 ±  2%  softirqs.CPU101.TIMER
     25203 ± 11%     +43.2%      36100        softirqs.CPU102.RCU
     20413 ±  4%    +351.8%      92238        softirqs.CPU102.SCHED
     49211 ±  3%    +474.9%     282914 ±  3%  softirqs.CPU102.TIMER
     25062 ± 11%     +44.0%      36090 ±  2%  softirqs.CPU103.RCU
     20402 ±  4%    +350.4%      91888 ±  2%  softirqs.CPU103.SCHED
     49182 ±  3%    +471.0%     280825 ±  2%  softirqs.CPU103.TIMER
     24634 ± 11%     +42.4%      35086 ±  4%  softirqs.CPU104.RCU
     20321 ±  3%    +348.5%      91134 ±  2%  softirqs.CPU104.SCHED
     49356 ±  3%    +481.6%     287070 ±  3%  softirqs.CPU104.TIMER
     25236 ± 11%     +42.2%      35897        softirqs.CPU105.RCU
     20353 ±  4%    +354.7%      92538        softirqs.CPU105.SCHED
     50003 ±  3%    +465.3%     282688 ±  2%  softirqs.CPU105.TIMER
     24280 ± 12%     +46.7%      35613 ±  2%  softirqs.CPU106.RCU
     20371 ±  4%    +345.0%      90656 ±  4%  softirqs.CPU106.SCHED
     49082 ±  2%    +473.9%     281676 ±  2%  softirqs.CPU106.TIMER
     24947 ± 11%     +43.4%      35783        softirqs.CPU107.RCU
     20554 ±  4%    +349.0%      92295 ±  2%  softirqs.CPU107.SCHED
     49649 ±  3%    +467.5%     281776 ±  2%  softirqs.CPU107.TIMER
     25256 ± 10%     +44.0%      36366 ±  2%  softirqs.CPU108.RCU
     20535 ±  4%    +347.8%      91951 ±  2%  softirqs.CPU108.SCHED
     49448 ±  4%    +470.9%     282320 ±  2%  softirqs.CPU108.TIMER
     25079 ± 11%     +44.0%      36104        softirqs.CPU109.RCU
     20349 ±  4%    +346.4%      90846 ±  3%  softirqs.CPU109.SCHED
     48936 ±  4%    +476.0%     281876 ±  2%  softirqs.CPU109.TIMER
     26035 ± 15%     +40.4%      36550 ±  3%  softirqs.CPU11.RCU
     21115 ±  3%    +333.1%      91461 ±  2%  softirqs.CPU11.SCHED
     52726 ±  6%    +458.9%     294668 ±  7%  softirqs.CPU11.TIMER
     24946 ± 11%     +43.8%      35877 ±  2%  softirqs.CPU110.RCU
     20469 ±  4%    +353.5%      92828 ±  2%  softirqs.CPU110.SCHED
     49412 ±  3%    +472.3%     282773        softirqs.CPU110.TIMER
     24905 ± 11%     +44.2%      35912 ±  2%  softirqs.CPU111.RCU
     20400 ±  4%    +341.6%      90082        softirqs.CPU111.SCHED
     49156 ±  3%    +473.0%     281654 ±  2%  softirqs.CPU111.TIMER
     25516 ± 12%     +40.5%      35844 ±  2%  softirqs.CPU112.RCU
     19036 ± 16%    +383.5%      92039 ±  2%  softirqs.CPU112.SCHED
     49486 ±  3%    +471.2%     282686        softirqs.CPU112.TIMER
     25576 ± 12%     +40.4%      35896        softirqs.CPU113.RCU
     20744 ±  3%    +347.2%      92773        softirqs.CPU113.SCHED
     49804 ±  2%    +467.8%     282805 ±  2%  softirqs.CPU113.TIMER
     25574 ± 11%     +40.4%      35912 ±  2%  softirqs.CPU114.RCU
     20516 ±  3%    +350.1%      92339 ±  2%  softirqs.CPU114.SCHED
     49117 ±  2%    +472.4%     281168 ±  2%  softirqs.CPU114.TIMER
     25632 ± 13%     +38.5%      35498 ±  4%  softirqs.CPU115.RCU
     18115 ± 26%    +409.7%      92327        softirqs.CPU115.SCHED
     49083 ±  3%    +477.9%     283659        softirqs.CPU115.TIMER
     25616 ± 13%     +40.6%      36018        softirqs.CPU116.RCU
     20671 ±  3%    +337.8%      90503 ±  3%  softirqs.CPU116.SCHED
     49949          +466.2%     282793 ±  2%  softirqs.CPU116.TIMER
     25412 ± 11%     +42.8%      36280 ±  2%  softirqs.CPU117.RCU
     20437 ±  4%    +353.1%      92604 ±  2%  softirqs.CPU117.SCHED
     49211 ±  2%    +474.0%     282487 ±  2%  softirqs.CPU117.TIMER
     25027 ± 13%     +43.6%      35951 ±  2%  softirqs.CPU118.RCU
     20494 ±  4%    +351.7%      92562 ±  2%  softirqs.CPU118.SCHED
     49342 ±  3%    +474.3%     283376 ±  2%  softirqs.CPU118.TIMER
     25569 ± 11%     +42.4%      36411 ±  2%  softirqs.CPU119.RCU
     20507 ±  4%    +352.9%      92878        softirqs.CPU119.SCHED
     49335 ±  4%    +476.1%     284229 ±  2%  softirqs.CPU119.TIMER
    220.50 ± 31%   +6133.9%      13745 ±166%  softirqs.CPU12.NET_RX
     25282 ± 11%     +41.8%      35856 ±  2%  softirqs.CPU12.RCU
     20676 ±  4%    +338.5%      90663 ±  2%  softirqs.CPU12.SCHED
     50120 ±  2%    +490.2%     295812 ±  6%  softirqs.CPU12.TIMER
     25763 ± 10%     +40.9%      36289        softirqs.CPU120.RCU
     20458 ±  4%    +340.5%      90125 ±  4%  softirqs.CPU120.SCHED
     49337 ±  4%    +471.5%     281981        softirqs.CPU120.TIMER
     25572 ± 10%     +37.1%      35050        softirqs.CPU121.RCU
     20596 ±  4%    +340.1%      90638        softirqs.CPU121.SCHED
     49874 ±  4%    +483.5%     291000 ±  2%  softirqs.CPU121.TIMER
     25730 ± 11%     +41.6%      36434        softirqs.CPU122.RCU
     20457 ±  3%    +350.7%      92210        softirqs.CPU122.SCHED
     49828 ±  4%    +466.3%     282191        softirqs.CPU122.TIMER
     25959 ±  9%     +39.8%      36288        softirqs.CPU123.RCU
     20020 ±  6%    +360.5%      92195        softirqs.CPU123.SCHED
     47932 ±  8%    +486.5%     281115        softirqs.CPU123.TIMER
     27280 ± 12%     +36.7%      37294 ±  5%  softirqs.CPU124.RCU
     20539 ±  4%    +344.5%      91301 ±  2%  softirqs.CPU124.SCHED
     50778 ±  7%    +457.8%     283231        softirqs.CPU124.TIMER
     26595 ± 10%     +36.0%      36172        softirqs.CPU125.RCU
     21139 ±  4%    +336.1%      92178        softirqs.CPU125.SCHED
     50876 ±  3%    +454.8%     282245        softirqs.CPU125.TIMER
     25903 ± 10%     +40.5%      36401        softirqs.CPU126.RCU
     20544 ±  4%    +345.7%      91561        softirqs.CPU126.SCHED
     49718 ±  4%    +467.2%     282019        softirqs.CPU126.TIMER
     25520 ± 10%     +40.6%      35888        softirqs.CPU127.RCU
     20397 ±  4%    +348.5%      91474        softirqs.CPU127.SCHED
     49385 ±  4%    +474.6%     283769        softirqs.CPU127.TIMER
     25028 ± 10%     +43.1%      35814        softirqs.CPU128.RCU
     20545 ±  4%    +344.3%      91284 ±  3%  softirqs.CPU128.SCHED
     49919 ±  3%    +466.8%     282927        softirqs.CPU128.TIMER
     24861 ± 10%     +44.3%      35876        softirqs.CPU129.RCU
     20470 ±  3%    +352.0%      92514        softirqs.CPU129.SCHED
     49676 ±  3%    +470.0%     283138        softirqs.CPU129.TIMER
     25466 ± 10%     +42.5%      36278        softirqs.CPU13.RCU
     19922 ±  2%    +356.1%      90860 ±  2%  softirqs.CPU13.SCHED
     50318 ±  3%    +486.9%     295294 ±  7%  softirqs.CPU13.TIMER
     24870 ± 10%     +42.6%      35456        softirqs.CPU130.RCU
     20471 ±  3%    +348.3%      91769        softirqs.CPU130.SCHED
     49850 ±  3%    +465.7%     282023        softirqs.CPU130.TIMER
     24799 ± 10%     +42.6%      35367        softirqs.CPU131.RCU
     20431 ±  3%    +361.9%      94365 ±  6%  softirqs.CPU131.SCHED
     49776 ±  3%    +535.1%     316120 ± 18%  softirqs.CPU131.TIMER
     25047 ±  9%     +42.7%      35750        softirqs.CPU132.RCU
     20482 ±  4%    +347.9%      91740        softirqs.CPU132.SCHED
     49597 ±  4%    +471.6%     283503        softirqs.CPU132.TIMER
     25004 ±  9%     +42.5%      35632        softirqs.CPU133.RCU
     20343 ±  4%    +351.8%      91912        softirqs.CPU133.SCHED
     49691 ±  4%    +471.0%     283725        softirqs.CPU133.TIMER
     24904 ± 10%     +42.1%      35383        softirqs.CPU134.RCU
     20412 ±  3%    +347.1%      91272 ±  2%  softirqs.CPU134.SCHED
     49973 ±  3%    +467.2%     283472        softirqs.CPU134.TIMER
     25022 ± 10%     +42.6%      35688        softirqs.CPU135.RCU
     20626 ±  4%    +333.2%      89353 ±  6%  softirqs.CPU135.SCHED
     49836 ±  3%    +467.7%     282930        softirqs.CPU135.TIMER
     24932 ± 10%     +42.1%      35430        softirqs.CPU136.RCU
     20496 ±  3%    +350.6%      92348        softirqs.CPU136.SCHED
     50011 ±  3%    +466.2%     283151        softirqs.CPU136.TIMER
     24797 ± 10%     +42.8%      35408        softirqs.CPU137.RCU
     20026 ±  2%    +357.6%      91636        softirqs.CPU137.SCHED
     49598 ±  4%    +470.3%     282875        softirqs.CPU137.TIMER
     24861 ± 11%     +41.8%      35246        softirqs.CPU138.RCU
     20295 ±  4%    +351.0%      91542        softirqs.CPU138.SCHED
     49587 ±  4%    +472.9%     284104        softirqs.CPU138.TIMER
     24744 ± 10%     +42.7%      35316        softirqs.CPU139.RCU
     20416 ±  3%    +349.2%      91703        softirqs.CPU139.SCHED
     49625 ±  3%    +473.8%     284739        softirqs.CPU139.TIMER
     25330 ± 11%     +44.0%      36463 ±  2%  softirqs.CPU14.RCU
     20362 ±  3%    +350.8%      91789 ±  2%  softirqs.CPU14.SCHED
     50537 ±  2%    +482.1%     294184 ±  6%  softirqs.CPU14.TIMER
     25004 ± 10%     +43.1%      35771        softirqs.CPU140.RCU
     20480 ±  4%    +352.4%      92653        softirqs.CPU140.SCHED
     50024 ±  3%    +466.5%     283409        softirqs.CPU140.TIMER
     24820 ± 10%     +42.7%      35428        softirqs.CPU141.RCU
     20523 ±  3%    +348.8%      92119        softirqs.CPU141.SCHED
     49918 ±  3%    +465.9%     282480        softirqs.CPU141.TIMER
     24589 ± 10%     +43.6%      35317        softirqs.CPU142.RCU
     20408 ±  3%    +352.8%      92411        softirqs.CPU142.SCHED
     49844 ±  3%    +466.9%     282550        softirqs.CPU142.TIMER
     24639 ± 10%     +43.0%      35246        softirqs.CPU143.RCU
     20289 ±  3%    +351.3%      91572 ±  2%  softirqs.CPU143.SCHED
     49652 ±  3%    +468.7%     282389        softirqs.CPU143.TIMER
     23793 ± 11%     +48.9%      35426 ±  2%  softirqs.CPU144.RCU
     20349 ±  4%    +351.7%      91918 ±  2%  softirqs.CPU144.SCHED
     48792 ±  5%    +478.8%     282399 ±  2%  softirqs.CPU144.TIMER
     24336 ±  9%     +44.7%      35219 ±  2%  softirqs.CPU145.RCU
     20382 ±  3%    +353.4%      92423 ±  2%  softirqs.CPU145.SCHED
     49104 ±  5%    +475.0%     282352 ±  2%  softirqs.CPU145.TIMER
     24312 ±  9%     +43.0%      34778 ±  3%  softirqs.CPU146.RCU
     20127 ±  3%    +354.3%      91446 ±  2%  softirqs.CPU146.SCHED
     49550 ±  4%    +476.3%     285557 ±  2%  softirqs.CPU146.TIMER
     24543 ± 10%     +44.5%      35452 ±  2%  softirqs.CPU147.RCU
     20378 ±  4%    +355.0%      92718 ±  2%  softirqs.CPU147.SCHED
     49484 ±  4%    +472.3%     283173 ±  2%  softirqs.CPU147.TIMER
     24879 ±  9%     +43.6%      35729 ±  2%  softirqs.CPU148.RCU
     20438 ±  3%    +352.3%      92450 ±  2%  softirqs.CPU148.SCHED
     49495 ±  5%    +472.8%     283518 ±  2%  softirqs.CPU148.TIMER
     24584 ± 10%     +45.6%      35790 ±  2%  softirqs.CPU149.RCU
     20457 ±  4%    +350.8%      92233 ±  2%  softirqs.CPU149.SCHED
     49280 ±  4%    +472.9%     282305 ±  2%  softirqs.CPU149.TIMER
     25392 ± 11%     +42.9%      36289 ±  2%  softirqs.CPU15.RCU
     20396 ±  3%    +346.5%      91065 ±  2%  softirqs.CPU15.SCHED
     50393 ±  2%    +484.5%     294548 ±  6%  softirqs.CPU15.TIMER
     23919 ±  8%     +46.3%      34987 ±  3%  softirqs.CPU150.RCU
     20636 ±  2%    +334.2%      89605 ±  2%  softirqs.CPU150.SCHED
     54400 ± 13%    +424.0%     285044        softirqs.CPU150.TIMER
     24344 ±  9%     +44.5%      35183 ±  2%  softirqs.CPU151.RCU
     20398 ±  3%    +348.6%      91514 ±  2%  softirqs.CPU151.SCHED
     49230 ±  4%    +473.6%     282370 ±  2%  softirqs.CPU151.TIMER
     24373 ±  9%     +45.8%      35525 ±  2%  softirqs.CPU152.RCU
     20307 ±  3%    +352.6%      91908 ±  2%  softirqs.CPU152.SCHED
     49326 ±  4%    +476.3%     284272 ±  3%  softirqs.CPU152.TIMER
     24567 ± 10%     +45.2%      35669 ±  2%  softirqs.CPU153.RCU
     20256 ±  5%    +352.1%      91578 ±  2%  softirqs.CPU153.SCHED
     49444 ±  4%    +472.9%     283288 ±  2%  softirqs.CPU153.TIMER
     24852 ± 10%     +43.8%      35747 ±  2%  softirqs.CPU154.RCU
     20439 ±  4%    +350.1%      91998 ±  2%  softirqs.CPU154.SCHED
     49787 ±  7%    +466.4%     282011 ±  2%  softirqs.CPU154.TIMER
     24781 ± 10%     +44.1%      35709 ±  2%  softirqs.CPU155.RCU
     18918 ± 14%    +387.4%      92212 ±  2%  softirqs.CPU155.SCHED
     49458 ±  4%    +471.2%     282505 ±  2%  softirqs.CPU155.TIMER
     24002 ± 10%     +43.0%      34327 ±  4%  softirqs.CPU156.RCU
     20385 ±  4%    +359.4%      93653 ±  2%  softirqs.CPU156.SCHED
     49116 ±  5%    +540.8%     314754 ± 14%  softirqs.CPU156.TIMER
     23954 ±  9%     +45.4%      34818        softirqs.CPU157.RCU
     20278 ±  4%    +351.9%      91637 ±  2%  softirqs.CPU157.SCHED
     48749 ±  5%    +489.8%     287506 ±  2%  softirqs.CPU157.TIMER
     24204 ±  9%     +45.9%      35314 ±  2%  softirqs.CPU158.RCU
     20378 ±  4%    +346.3%      90955        softirqs.CPU158.SCHED
     49021 ±  5%    +476.3%     282508 ±  2%  softirqs.CPU158.TIMER
     24475 ±  9%     +45.7%      35652 ±  2%  softirqs.CPU159.RCU
     20452 ±  3%    +352.9%      92631 ±  2%  softirqs.CPU159.SCHED
     49429 ±  4%    +472.7%     283079 ±  2%  softirqs.CPU159.TIMER
     26064 ± 12%     +41.0%      36750 ±  2%  softirqs.CPU16.RCU
     20425 ±  3%    +343.4%      90560 ±  3%  softirqs.CPU16.SCHED
     50222 ±  2%    +483.1%     292869 ±  6%  softirqs.CPU16.TIMER
     26219 ±  9%     +41.6%      37136 ±  2%  softirqs.CPU160.RCU
     20489 ±  5%    +352.0%      92619 ±  2%  softirqs.CPU160.SCHED
     49521 ±  6%    +471.0%     282774 ±  3%  softirqs.CPU160.TIMER
     25946 ±  9%     +43.8%      37298 ±  2%  softirqs.CPU161.RCU
     20151 ±  4%    +358.2%      92342 ±  2%  softirqs.CPU161.SCHED
     49011 ±  4%    +476.6%     282615 ±  3%  softirqs.CPU161.TIMER
     25455 ±  9%     +43.1%      36430 ±  3%  softirqs.CPU162.RCU
     20379 ±  4%    +349.3%      91559 ±  2%  softirqs.CPU162.SCHED
     48666 ±  5%    +483.0%     283747        softirqs.CPU162.TIMER
     25779 ±  9%     +43.0%      36865        softirqs.CPU163.RCU
     20502 ±  4%    +348.4%      91934 ±  2%  softirqs.CPU163.SCHED
     49177 ±  5%    +477.4%     283927 ±  3%  softirqs.CPU163.TIMER
     25927 ± 10%     +43.3%      37165 ±  2%  softirqs.CPU164.RCU
     20637 ±  2%    +348.8%      92619 ±  2%  softirqs.CPU164.SCHED
     49812 ±  2%    +467.1%     282494 ±  2%  softirqs.CPU164.TIMER
     26087 ± 10%     +42.6%      37201 ±  2%  softirqs.CPU165.RCU
     20411 ±  3%    +352.9%      92443 ±  2%  softirqs.CPU165.SCHED
     49839 ±  2%    +466.1%     282160 ±  2%  softirqs.CPU165.TIMER
     26103 ±  8%     +43.5%      37469 ±  3%  softirqs.CPU166.RCU
     20556 ±  4%    +349.3%      92368 ±  2%  softirqs.CPU166.SCHED
     49415 ±  5%    +471.0%     282151 ±  2%  softirqs.CPU166.TIMER
     25799 ±  9%     +44.7%      37332 ±  3%  softirqs.CPU167.RCU
     20451 ±  3%    +347.7%      91565 ±  3%  softirqs.CPU167.SCHED
     49062 ±  3%    +475.3%     282249 ±  2%  softirqs.CPU167.TIMER
     24422 ±  8%     +39.8%      34147 ±  4%  softirqs.CPU168.RCU
     20721 ±  4%    +352.8%      93823 ±  2%  softirqs.CPU168.SCHED
     50048 ±  4%    +526.2%     313399 ± 15%  softirqs.CPU168.TIMER
     24555 ± 11%     +40.3%      34441        softirqs.CPU169.RCU
     20582 ±  4%    +346.6%      91922 ±  2%  softirqs.CPU169.SCHED
     49599 ±  3%    +474.3%     284867 ±  4%  softirqs.CPU169.TIMER
     26033 ± 11%     +40.6%      36593 ±  2%  softirqs.CPU17.RCU
     20386 ±  3%    +347.4%      91218 ±  2%  softirqs.CPU17.SCHED
     49996 ±  3%    +488.0%     293991 ±  7%  softirqs.CPU17.TIMER
     24363 ± 10%     +42.1%      34629 ±  2%  softirqs.CPU170.RCU
     20372 ±  3%    +336.9%      88996 ±  2%  softirqs.CPU170.SCHED
     49272 ±  4%    +473.2%     282449 ±  2%  softirqs.CPU170.TIMER
     24183 ± 10%     +44.9%      35042 ±  4%  softirqs.CPU171.RCU
     20379 ±  3%    +351.3%      91965 ±  2%  softirqs.CPU171.SCHED
     48868 ±  4%    +483.0%     284915        softirqs.CPU171.TIMER
     24403 ± 10%     +42.5%      34763 ±  2%  softirqs.CPU172.RCU
     20611 ±  4%    +347.2%      92181 ±  2%  softirqs.CPU172.SCHED
     49583 ±  3%    +467.8%     281543 ±  2%  softirqs.CPU172.TIMER
     24399 ± 10%     +42.4%      34744 ±  2%  softirqs.CPU173.RCU
     20545 ±  3%    +349.7%      92401 ±  2%  softirqs.CPU173.SCHED
     49501 ±  2%    +472.3%     283271 ±  2%  softirqs.CPU173.TIMER
     24263 ± 10%     +42.6%      34601 ±  2%  softirqs.CPU174.RCU
     20507 ±  4%    +345.3%      91321 ±  2%  softirqs.CPU174.SCHED
     49072 ±  4%    +471.9%     280644 ±  2%  softirqs.CPU174.TIMER
     24198 ± 10%     +43.1%      34622 ±  2%  softirqs.CPU175.RCU
     20446 ±  3%    +344.8%      90944        softirqs.CPU175.SCHED
     48870 ±  4%    +482.1%     284465        softirqs.CPU175.TIMER
     24104 ± 10%     +43.0%      34467 ±  2%  softirqs.CPU176.RCU
     19930 ±  3%    +362.3%      92133 ±  2%  softirqs.CPU176.SCHED
     49729 ±  3%    +469.3%     283131 ±  2%  softirqs.CPU176.TIMER
     23983 ± 10%     +43.0%      34297        softirqs.CPU177.RCU
     20485 ±  3%    +349.9%      92158        softirqs.CPU177.SCHED
     49688 ±  3%    +470.3%     283368 ±  3%  softirqs.CPU177.TIMER
     23862 ± 10%     +44.1%      34382        softirqs.CPU178.RCU
     20345 ±  3%    +351.7%      91906 ±  2%  softirqs.CPU178.SCHED
     49535 ±  4%    +468.3%     281527 ±  2%  softirqs.CPU178.TIMER
     23863 ± 10%     +43.4%      34219        softirqs.CPU179.RCU
     20416 ±  3%    +344.4%      90739        softirqs.CPU179.SCHED
     49272 ±  3%    +472.7%     282161 ±  2%  softirqs.CPU179.TIMER
     25795 ± 11%     +41.4%      36463 ±  2%  softirqs.CPU18.RCU
     20419 ±  3%    +335.3%      88873 ±  7%  softirqs.CPU18.SCHED
     49649 ±  2%    +492.4%     294146 ±  7%  softirqs.CPU18.TIMER
     24068 ± 11%     +44.1%      34673 ±  2%  softirqs.CPU180.RCU
     20468 ±  4%    +347.4%      91585 ±  2%  softirqs.CPU180.SCHED
     49389 ±  3%    +468.4%     280735 ±  2%  softirqs.CPU180.TIMER
     24205 ± 11%     +42.0%      34370        softirqs.CPU181.RCU
     20617 ±  2%    +344.6%      91659 ±  2%  softirqs.CPU181.SCHED
     49968 ±  2%    +475.3%     287474 ±  2%  softirqs.CPU181.TIMER
     23902 ± 11%     +45.5%      34784        softirqs.CPU182.RCU
     20369 ±  3%    +352.9%      92247 ±  2%  softirqs.CPU182.SCHED
     49268 ±  4%    +477.0%     284294 ±  2%  softirqs.CPU182.TIMER
     23938 ± 11%     +43.9%      34456        softirqs.CPU183.RCU
     20340 ±  3%    +348.2%      91168 ±  3%  softirqs.CPU183.SCHED
     49379 ±  4%    +471.3%     282089 ±  2%  softirqs.CPU183.TIMER
     23995 ± 10%     +43.4%      34417 ±  2%  softirqs.CPU184.RCU
     20345 ±  4%    +353.4%      92239 ±  2%  softirqs.CPU184.SCHED
     49390 ±  3%    +474.0%     283489 ±  2%  softirqs.CPU184.TIMER
     23879 ± 11%     +43.5%      34272 ±  2%  softirqs.CPU185.RCU
     20530 ±  4%    +348.6%      92090 ±  2%  softirqs.CPU185.SCHED
     49613 ±  3%    +470.4%     282978 ±  2%  softirqs.CPU185.TIMER
     23796 ± 10%     +43.1%      34042 ±  2%  softirqs.CPU186.RCU
     20077 ±  2%    +354.4%      91225 ±  2%  softirqs.CPU186.SCHED
     49077 ±  4%    +484.5%     286868        softirqs.CPU186.TIMER
     24045 ± 10%     +41.5%      34022        softirqs.CPU187.RCU
     20391 ±  4%    +338.4%      89393 ±  4%  softirqs.CPU187.SCHED
     49678 ±  3%    +470.3%     283337 ±  2%  softirqs.CPU187.TIMER
     23986 ± 10%     +43.4%      34393 ±  2%  softirqs.CPU188.RCU
     20277 ±  3%    +356.7%      92602 ±  2%  softirqs.CPU188.SCHED
     49855 ±  3%    +468.0%     283161 ±  3%  softirqs.CPU188.TIMER
     23933 ± 10%     +43.4%      34319 ±  2%  softirqs.CPU189.RCU
     20488 ±  3%    +350.3%      92260 ±  2%  softirqs.CPU189.SCHED
     49424 ±  3%    +471.6%     282491 ±  2%  softirqs.CPU189.TIMER
     25663 ± 11%     +39.3%      35748 ±  4%  softirqs.CPU19.RCU
     20362 ±  3%    +357.1%      93080 ±  3%  softirqs.CPU19.SCHED
     49813 ±  2%    +557.3%     327415 ± 11%  softirqs.CPU19.TIMER
     24144 ± 10%     +42.0%      34279        softirqs.CPU190.RCU
     19974 ±  7%    +360.7%      92023 ±  2%  softirqs.CPU190.SCHED
     50194 ±  5%    +462.0%     282075 ±  2%  softirqs.CPU190.TIMER
     24352 ±  9%     +40.7%      34256        softirqs.CPU191.RCU
     20511 ±  4%    +349.9%      92288 ±  2%  softirqs.CPU191.SCHED
     50352 ±  3%    +459.8%     281889 ±  2%  softirqs.CPU191.TIMER
     25381 ±  9%     +43.9%      36521 ±  2%  softirqs.CPU2.RCU
     20581 ±  5%    +340.0%      90569 ±  2%  softirqs.CPU2.SCHED
     51115 ±  3%    +480.1%     296530 ±  6%  softirqs.CPU2.TIMER
     25978 ± 12%     +40.6%      36523 ±  2%  softirqs.CPU20.RCU
     20228 ±  2%    +351.2%      91280 ±  2%  softirqs.CPU20.SCHED
     50619 ±  2%    +479.1%     293111 ±  6%  softirqs.CPU20.TIMER
     25841 ± 11%     +41.6%      36603 ±  2%  softirqs.CPU21.RCU
     20365 ±  3%    +341.0%      89804 ±  4%  softirqs.CPU21.SCHED
     50038 ±  2%    +484.9%     292698 ±  6%  softirqs.CPU21.TIMER
     25561 ± 13%     +44.5%      36935 ±  3%  softirqs.CPU22.RCU
     19887 ±  5%    +361.3%      91748 ±  2%  softirqs.CPU22.SCHED
     56277 ± 17%    +418.3%     291673 ±  6%  softirqs.CPU22.TIMER
     25902 ± 11%     +42.3%      36861 ±  3%  softirqs.CPU23.RCU
     20418 ±  3%    +343.3%      90515        softirqs.CPU23.SCHED
     50173 ±  3%    +485.6%     293799 ±  6%  softirqs.CPU23.TIMER
     26145 ± 10%     +39.8%      36560        softirqs.CPU24.RCU
     20622 ±  3%    +330.8%      88845        softirqs.CPU24.SCHED
     50102 ±  3%    +490.9%     296049 ±  4%  softirqs.CPU24.TIMER
     26077 ± 10%     +39.1%      36282        softirqs.CPU25.RCU
     20421 ±  3%    +345.0%      90877 ±  2%  softirqs.CPU25.SCHED
     50234 ±  2%    +502.3%     302550 ±  4%  softirqs.CPU25.TIMER
     26094 ± 10%     +39.9%      36500        softirqs.CPU26.RCU
     20399 ±  3%    +344.5%      90681        softirqs.CPU26.SCHED
     50683 ±  3%    +485.7%     296869 ±  3%  softirqs.CPU26.TIMER
     28365 ±  5%     +33.7%      37937 ±  4%  softirqs.CPU27.RCU
     19443 ±  5%    +366.5%      90704 ±  2%  softirqs.CPU27.SCHED
     49823 ±  4%    +495.3%     296606 ±  3%  softirqs.CPU27.TIMER
     27913 ± 14%     +38.2%      38590 ±  4%  softirqs.CPU28.RCU
     20779 ±  3%    +341.7%      91782        softirqs.CPU28.SCHED
     51802          +476.6%     298670 ±  4%  softirqs.CPU28.TIMER
     26364 ±  9%     +41.3%      37250        softirqs.CPU29.RCU
     20542 ±  3%    +345.8%      91573        softirqs.CPU29.SCHED
     50776 ±  2%    +485.9%     297492 ±  4%  softirqs.CPU29.TIMER
     25802 ± 12%     +41.4%      36489 ±  2%  softirqs.CPU3.RCU
     20985 ±  2%    +335.8%      91463 ±  2%  softirqs.CPU3.SCHED
     51361          +471.5%     293554 ±  6%  softirqs.CPU3.TIMER
     25955 ± 10%     +40.8%      36536        softirqs.CPU30.RCU
     20496 ±  3%    +346.1%      91432        softirqs.CPU30.SCHED
     50412 ±  3%    +492.6%     298742 ±  4%  softirqs.CPU30.TIMER
     26020 ± 10%     +40.5%      36548        softirqs.CPU31.RCU
     20432 ±  4%    +346.2%      91176        softirqs.CPU31.SCHED
     50065 ±  3%    +497.9%     299341 ±  4%  softirqs.CPU31.TIMER
     25489 ±  9%     +42.6%      36349        softirqs.CPU32.RCU
     20409 ±  3%    +345.7%      90961        softirqs.CPU32.SCHED
     50637 ±  3%    +489.6%     298572 ±  3%  softirqs.CPU32.TIMER
     26315 ±  7%     +39.3%      36658        softirqs.CPU33.RCU
     20594 ±  4%    +344.2%      91486        softirqs.CPU33.SCHED
     51143 ±  4%    +480.8%     297031 ±  3%  softirqs.CPU33.TIMER
     25631 ±  9%     +43.5%      36772        softirqs.CPU34.RCU
     20350 ±  3%    +348.6%      91293        softirqs.CPU34.SCHED
     50278 ±  3%    +496.1%     299688 ±  3%  softirqs.CPU34.TIMER
     25548 ±  9%     +39.9%      35733 ±  3%  softirqs.CPU35.RCU
     20357 ±  3%    +343.6%      90304 ±  3%  softirqs.CPU35.SCHED
     50388 ±  3%    +498.1%     301373 ±  4%  softirqs.CPU35.TIMER
     25312 ±  9%     +42.5%      36066        softirqs.CPU36.RCU
     20380 ±  3%    +348.1%      91327        softirqs.CPU36.SCHED
     50350 ±  3%    +495.3%     299741 ±  4%  softirqs.CPU36.TIMER
     25276 ±  9%     +43.1%      36162        softirqs.CPU37.RCU
     20335 ±  3%    +336.6%      88785 ±  4%  softirqs.CPU37.SCHED
     50203 ±  3%    +496.8%     299616 ±  4%  softirqs.CPU37.TIMER
     25444 ± 10%     +42.8%      36342        softirqs.CPU38.RCU
     20357 ±  3%    +348.2%      91235        softirqs.CPU38.SCHED
     50560 ±  2%    +491.9%     299260 ±  3%  softirqs.CPU38.TIMER
     25531 ± 10%     +44.2%      36812        softirqs.CPU39.RCU
     20306 ±  3%    +348.5%      91063 ±  2%  softirqs.CPU39.SCHED
     50503 ±  2%    +490.8%     298378 ±  4%  softirqs.CPU39.TIMER
     25418 ± 11%     +44.1%      36622 ±  3%  softirqs.CPU4.RCU
     20003 ±  5%    +357.2%      91447 ±  2%  softirqs.CPU4.SCHED
     50214 ±  2%    +491.2%     296863 ±  7%  softirqs.CPU4.TIMER
     25871 ± 10%     +42.2%      36790        softirqs.CPU40.RCU
     20610 ±  4%    +333.2%      89287        softirqs.CPU40.SCHED
     51103 ±  3%    +483.6%     298251 ±  4%  softirqs.CPU40.TIMER
     25677 ± 10%     +43.1%      36749        softirqs.CPU41.RCU
     20374 ±  3%    +348.4%      91356        softirqs.CPU41.SCHED
     50378 ±  2%    +492.7%     298605 ±  4%  softirqs.CPU41.TIMER
     25243 ± 10%     +43.6%      36255 ±  2%  softirqs.CPU42.RCU
     20383 ±  3%    +347.7%      91250        softirqs.CPU42.SCHED
     50255 ±  3%    +497.7%     300355 ±  3%  softirqs.CPU42.TIMER
     25240 ± 10%     +41.6%      35742        softirqs.CPU43.RCU
     20379 ±  3%    +347.6%      91210        softirqs.CPU43.SCHED
     50399 ±  3%    +496.2%     300458 ±  3%  softirqs.CPU43.TIMER
     25420 ± 10%     +43.7%      36519        softirqs.CPU44.RCU
     20445 ±  3%    +348.0%      91591        softirqs.CPU44.SCHED
     50662 ±  3%    +486.4%     297072 ±  3%  softirqs.CPU44.TIMER
     25509 ± 10%     +43.5%      36603        softirqs.CPU45.RCU
     20402 ±  3%    +347.9%      91389        softirqs.CPU45.SCHED
     50663 ±  3%    +487.4%     297595 ±  3%  softirqs.CPU45.TIMER
     25791 ± 10%     +42.4%      36716        softirqs.CPU46.RCU
     20330 ±  3%    +343.5%      90161 ±  3%  softirqs.CPU46.SCHED
     50640 ±  3%    +486.9%     297219 ±  3%  softirqs.CPU46.TIMER
     25574 ± 10%     +43.0%      36571        softirqs.CPU47.RCU
     20381 ±  3%    +347.6%      91229        softirqs.CPU47.SCHED
     50288 ±  2%    +491.8%     297625 ±  3%  softirqs.CPU47.TIMER
     24992 ±  9%     +46.0%      36485        softirqs.CPU48.RCU
     20697 ±  4%    +331.9%      89398 ±  2%  softirqs.CPU48.SCHED
     56685 ± 18%    +425.9%     298113 ±  4%  softirqs.CPU48.TIMER
     25827 ± 10%     +40.3%      36241 ±  2%  softirqs.CPU49.RCU
     20600 ±  4%    +340.9%      90830 ±  2%  softirqs.CPU49.SCHED
     50525 ±  5%    +490.6%     298393 ±  4%  softirqs.CPU49.TIMER
     25302 ± 11%     +43.3%      36263        softirqs.CPU5.RCU
     20450 ±  3%    +342.8%      90542 ±  3%  softirqs.CPU5.SCHED
     50130 ±  2%    +486.6%     294083 ±  7%  softirqs.CPU5.TIMER
     24835 ±  9%     +43.8%      35709 ±  2%  softirqs.CPU50.RCU
     20342 ±  3%    +346.5%      90833        softirqs.CPU50.SCHED
     50022 ±  3%    +501.7%     300961 ±  3%  softirqs.CPU50.TIMER
     24939 ± 10%     +43.9%      35894 ±  2%  softirqs.CPU51.RCU
     20520 ±  4%    +344.3%      91164 ±  2%  softirqs.CPU51.SCHED
     50565 ±  4%    +488.3%     297455 ±  4%  softirqs.CPU51.TIMER
     25295 ±  7%     +43.6%      36334 ±  2%  softirqs.CPU52.RCU
     20022 ±  4%    +355.5%      91193 ±  2%  softirqs.CPU52.SCHED
     50959 ±  5%    +485.9%     298586 ±  4%  softirqs.CPU52.TIMER
     25090 ±  9%     +45.5%      36510 ±  2%  softirqs.CPU53.RCU
     20440 ±  3%    +347.4%      91453 ±  2%  softirqs.CPU53.SCHED
     50096 ±  3%    +494.7%     297907 ±  4%  softirqs.CPU53.TIMER
     24306 ±  8%     +47.3%      35813 ±  2%  softirqs.CPU54.RCU
     20349 ±  3%    +346.8%      90920 ±  2%  softirqs.CPU54.SCHED
     49735 ±  3%    +506.9%     301848 ±  4%  softirqs.CPU54.TIMER
     25334 ±  9%     +42.7%      36140 ±  2%  softirqs.CPU55.RCU
     20344 ±  3%    +349.1%      91360 ±  2%  softirqs.CPU55.SCHED
     50724 ±  3%    +492.3%     300451 ±  4%  softirqs.CPU55.TIMER
     24888 ± 10%     +44.4%      35928        softirqs.CPU56.RCU
     20288 ±  3%    +341.5%      89570        softirqs.CPU56.SCHED
     49886 ±  3%    +499.3%     298973 ±  4%  softirqs.CPU56.TIMER
     24913 ±  9%     +45.1%      36158 ±  2%  softirqs.CPU57.RCU
     20355 ±  3%    +350.5%      91704 ±  2%  softirqs.CPU57.SCHED
     49993 ±  3%    +495.5%     297722 ±  4%  softirqs.CPU57.TIMER
     24895 ± 10%     +45.1%      36115 ±  2%  softirqs.CPU58.RCU
     20346 ±  3%    +349.7%      91493 ±  2%  softirqs.CPU58.SCHED
     50014 ±  4%    +497.1%     298646 ±  4%  softirqs.CPU58.TIMER
     25001 ±  9%     +44.6%      36146 ±  2%  softirqs.CPU59.RCU
     20321 ±  3%    +349.4%      91316 ±  2%  softirqs.CPU59.SCHED
     49988 ±  3%    +497.8%     298852 ±  4%  softirqs.CPU59.TIMER
     25081 ± 11%     +42.2%      35668        softirqs.CPU6.RCU
     20427 ±  3%    +348.6%      91637 ±  2%  softirqs.CPU6.SCHED
     50219 ±  2%    +489.0%     295790 ±  7%  softirqs.CPU6.TIMER
     24839 ± 10%     +41.6%      35182 ±  5%  softirqs.CPU60.RCU
     20247 ±  3%    +347.0%      90495 ±  3%  softirqs.CPU60.SCHED
     49446 ±  4%    +508.6%     300954 ±  3%  softirqs.CPU60.TIMER
     24773 ±  9%     +44.7%      35837        softirqs.CPU61.RCU
     20287 ±  3%    +349.9%      91275 ±  2%  softirqs.CPU61.SCHED
     49472 ±  4%    +509.2%     301363 ±  4%  softirqs.CPU61.TIMER
     24900 ± 10%     +45.1%      36132 ±  2%  softirqs.CPU62.RCU
     20353 ±  3%    +346.2%      90825 ±  2%  softirqs.CPU62.SCHED
     50018 ±  3%    +494.6%     297406 ±  3%  softirqs.CPU62.TIMER
     24923 ± 10%     +44.4%      35979 ±  2%  softirqs.CPU63.RCU
     19761 ±  3%    +363.3%      91564 ±  2%  softirqs.CPU63.SCHED
     50196 ±  4%    +493.3%     297839 ±  4%  softirqs.CPU63.TIMER
     25965 ±  9%     +43.1%      37158 ±  2%  softirqs.CPU64.RCU
     19872 ±  3%    +358.1%      91027 ±  2%  softirqs.CPU64.SCHED
     49826 ±  4%    +496.0%     296974 ±  4%  softirqs.CPU64.TIMER
     26031 ±  9%     +42.9%      37209 ±  2%  softirqs.CPU65.RCU
     20089 ±  2%    +355.0%      91403 ±  2%  softirqs.CPU65.SCHED
     49774 ±  4%    +498.8%     298027 ±  4%  softirqs.CPU65.TIMER
     26025 ±  9%     +43.1%      37251 ±  2%  softirqs.CPU66.RCU
     20286 ±  3%    +350.3%      91346 ±  2%  softirqs.CPU66.SCHED
     49418 ±  4%    +506.6%     299762 ±  4%  softirqs.CPU66.TIMER
     26363 ± 11%     +41.8%      37370 ±  2%  softirqs.CPU67.RCU
     20639 ±  2%    +344.6%      91758 ±  2%  softirqs.CPU67.SCHED
     50912 ±  2%    +484.9%     297788 ±  4%  softirqs.CPU67.TIMER
     26191 ± 10%     +43.4%      37567 ±  2%  softirqs.CPU68.RCU
     20446 ±  3%    +344.4%      90862 ±  3%  softirqs.CPU68.SCHED
     50275 ±  2%    +490.3%     296785 ±  4%  softirqs.CPU68.TIMER
     26056 ± 10%     +43.3%      37350 ±  2%  softirqs.CPU69.RCU
     20432 ±  3%    +343.9%      90690 ±  3%  softirqs.CPU69.SCHED
     49843 ±  3%    +497.4%     297749 ±  4%  softirqs.CPU69.TIMER
     25354 ± 12%     +41.4%      35842 ±  2%  softirqs.CPU7.RCU
     20475 ±  3%    +346.0%      91319 ±  2%  softirqs.CPU7.SCHED
     51059          +478.6%     295447 ±  7%  softirqs.CPU7.TIMER
     25955 ± 10%     +43.6%      37278 ±  2%  softirqs.CPU70.RCU
     20363 ±  3%    +350.0%      91641 ±  2%  softirqs.CPU70.SCHED
     49793 ±  3%    +496.9%     297228 ±  4%  softirqs.CPU70.TIMER
     25917 ±  9%     +42.6%      36946 ±  2%  softirqs.CPU71.RCU
     20280 ±  3%    +350.5%      91372 ±  2%  softirqs.CPU71.SCHED
     49602 ±  3%    +501.5%     298355 ±  4%  softirqs.CPU71.TIMER
     24788 ±  9%     +39.9%      34670 ±  3%  softirqs.CPU72.RCU
     20824 ±  4%    +329.9%      89530 ±  2%  softirqs.CPU72.SCHED
     50627 ±  3%    +482.2%     294728 ±  4%  softirqs.CPU72.TIMER
     24666 ± 10%     +41.9%      35004        softirqs.CPU73.RCU
     20572 ±  3%    +338.4%      90197 ±  2%  softirqs.CPU73.SCHED
     50393 ±  3%    +488.8%     296692 ±  4%  softirqs.CPU73.TIMER
     24748 ± 10%     +41.5%      35013        softirqs.CPU74.RCU
     20542 ±  3%    +342.9%      90983 ±  2%  softirqs.CPU74.SCHED
     50269 ±  2%    +490.3%     296748 ±  4%  softirqs.CPU74.TIMER
     24917 ± 12%     +40.6%      35037 ±  2%  softirqs.CPU75.RCU
     20512 ±  3%    +344.2%      91120 ±  2%  softirqs.CPU75.SCHED
     49959 ±  2%    +493.5%     296492 ±  4%  softirqs.CPU75.TIMER
     24601 ± 10%     +42.2%      34994        softirqs.CPU76.RCU
     20498 ±  3%    +345.5%      91326 ±  2%  softirqs.CPU76.SCHED
     50469 ±  3%    +484.5%     294970 ±  4%  softirqs.CPU76.TIMER
     24613 ± 10%     +43.4%      35302 ±  2%  softirqs.CPU77.RCU
     20230 ±  6%    +351.2%      91268 ±  2%  softirqs.CPU77.SCHED
     50322 ±  3%    +487.4%     295568 ±  4%  softirqs.CPU77.TIMER
     24588 ± 10%     +42.7%      35076 ±  2%  softirqs.CPU78.RCU
     20493 ±  3%    +345.7%      91337 ±  2%  softirqs.CPU78.SCHED
     50114 ±  3%    +491.8%     296565 ±  4%  softirqs.CPU78.TIMER
     24620 ± 10%     +42.2%      34998 ±  2%  softirqs.CPU79.RCU
     20427 ±  3%    +345.8%      91066 ±  2%  softirqs.CPU79.SCHED
     49972 ±  3%    +494.0%     296815 ±  4%  softirqs.CPU79.TIMER
     25594 ±  9%     +38.6%      35481 ±  3%  softirqs.CPU8.RCU
     20260 ±  3%    +351.2%      91408 ±  2%  softirqs.CPU8.SCHED
     51425 ±  3%    +478.8%     297676 ±  6%  softirqs.CPU8.TIMER
     24865 ± 11%     +42.9%      35523 ±  2%  softirqs.CPU80.RCU
     20551 ±  3%    +344.7%      91398 ±  2%  softirqs.CPU80.SCHED
     50609 ±  3%    +485.0%     296053 ±  4%  softirqs.CPU80.TIMER
     24784 ± 10%     +43.2%      35492        softirqs.CPU81.RCU
     20538 ±  3%    +343.1%      91013        softirqs.CPU81.SCHED
     50541 ±  3%    +486.2%     296282 ±  4%  softirqs.CPU81.TIMER
     24768 ± 10%     +44.5%      35788 ±  2%  softirqs.CPU82.RCU
     20516 ±  4%    +345.8%      91467 ±  2%  softirqs.CPU82.SCHED
     50348 ±  3%    +488.0%     296055 ±  4%  softirqs.CPU82.TIMER
     24804 ± 10%     +43.6%      35624 ±  2%  softirqs.CPU83.RCU
     20494 ±  4%    +345.4%      91278 ±  2%  softirqs.CPU83.SCHED
     50250 ±  3%    +489.5%     296213 ±  4%  softirqs.CPU83.TIMER
     24454 ± 10%     +43.7%      35133 ±  2%  softirqs.CPU84.RCU
     20078 ±  4%    +354.3%      91224 ±  2%  softirqs.CPU84.SCHED
     50096 ±  3%    +494.1%     297597 ±  4%  softirqs.CPU84.TIMER
     24538 ± 10%     +41.9%      34808        softirqs.CPU85.RCU
     20615 ±  4%    +342.7%      91255 ±  2%  softirqs.CPU85.SCHED
     50295 ±  3%    +494.3%     298914 ±  4%  softirqs.CPU85.TIMER
     24637 ± 11%     +43.9%      35465        softirqs.CPU86.RCU
     20580 ±  4%    +345.0%      91577 ±  2%  softirqs.CPU86.SCHED
     50380 ±  3%    +487.8%     296126 ±  3%  softirqs.CPU86.TIMER
     24843 ± 11%     +43.1%      35560        softirqs.CPU87.RCU
     20237 ±  3%    +345.4%      90132 ±  4%  softirqs.CPU87.SCHED
     50601 ±  4%    +485.0%     296001 ±  4%  softirqs.CPU87.TIMER
     24820 ± 10%     +44.2%      35798        softirqs.CPU88.RCU
     20489 ±  3%    +338.1%      89765 ±  4%  softirqs.CPU88.SCHED
     50054 ±  3%    +491.9%     296271 ±  4%  softirqs.CPU88.TIMER
     24770 ± 10%     +44.5%      35784        softirqs.CPU89.RCU
     20471 ±  3%    +341.1%      90293 ±  3%  softirqs.CPU89.SCHED
     50362 ±  3%    +488.3%     296271 ±  4%  softirqs.CPU89.TIMER
     25341 ± 11%     +42.4%      36083        softirqs.CPU9.RCU
     20377 ±  3%    +343.0%      90264 ±  3%  softirqs.CPU9.SCHED
     50377 ±  2%    +485.8%     295104 ±  7%  softirqs.CPU9.TIMER
     24246 ± 10%     +43.6%      34813        softirqs.CPU90.RCU
     20488 ±  3%    +340.2%      90192        softirqs.CPU90.SCHED
     49924 ±  3%    +497.7%     298417 ±  4%  softirqs.CPU90.TIMER
     24536 ± 10%     +42.4%      34937        softirqs.CPU91.RCU
     19965 ±  5%    +355.6%      90962 ±  2%  softirqs.CPU91.SCHED
     50256 ±  3%    +490.7%     296842 ±  4%  softirqs.CPU91.TIMER
     25005 ± 10%     +41.6%      35419        softirqs.CPU92.RCU
     20599 ±  3%    +345.4%      91737 ±  2%  softirqs.CPU92.SCHED
     51263 ±  3%    +476.5%     295558 ±  3%  softirqs.CPU92.TIMER
     25023 ± 11%     +42.1%      35551        softirqs.CPU93.RCU
     20669 ±  4%    +342.1%      91378 ±  2%  softirqs.CPU93.SCHED
     50659 ±  4%    +482.7%     295203 ±  3%  softirqs.CPU93.TIMER
     24945 ± 10%     +43.9%      35907        softirqs.CPU94.RCU
     20478 ±  3%    +344.5%      91022 ±  2%  softirqs.CPU94.SCHED
     50677 ±  4%    +483.3%     295586 ±  4%  softirqs.CPU94.TIMER
     25398 ±  8%     +40.6%      35700 ±  2%  softirqs.CPU95.RCU
     13025 ± 47%    +580.9%      88689 ±  2%  softirqs.CPU95.SCHED
     50346 ±  3%    +485.7%     294897 ±  4%  softirqs.CPU95.TIMER
     25009 ± 10%     +45.4%      36355        softirqs.CPU96.RCU
     20197 ±  4%    +333.5%      87556 ±  6%  softirqs.CPU96.SCHED
     49133 ±  3%    +474.0%     282014 ±  2%  softirqs.CPU96.TIMER
     25257 ± 11%     +41.9%      35835        softirqs.CPU97.RCU
     20525 ±  4%    +349.2%      92195        softirqs.CPU97.SCHED
     49569 ±  3%    +471.1%     283108 ±  3%  softirqs.CPU97.TIMER
     25343 ± 10%     +43.0%      36238        softirqs.CPU98.RCU
     19400 ±  8%    +366.6%      90520        softirqs.CPU98.SCHED
     49594 ±  3%    +471.4%     283390 ±  2%  softirqs.CPU98.TIMER
     25005 ± 10%     +45.5%      36385        softirqs.CPU99.RCU
     20393 ±  4%    +355.8%      92942        softirqs.CPU99.SCHED
     49533 ±  4%    +472.4%     283507        softirqs.CPU99.TIMER
   4823683 ± 10%     +42.7%    6882676        softirqs.RCU
   3913543 ±  3%    +348.4%   17550216 ±  2%  softirqs.SCHED
   9617502 ±  3%    +480.4%   55821174 ±  2%  softirqs.TIMER
    229.00 ± 24%    +537.2%       1459 ± 34%  interrupts.31:PCI-MSI.524289-edge.eth0-TxRx-0
    232.00 ± 60%  +11650.3%      27260 ±167%  interrupts.34:PCI-MSI.524292-edge.eth0-TxRx-3
    250242 ±  5%    +519.7%    1550870 ±  2%  interrupts.CPU0.LOC:Local_timer_interrupts
      3594           -57.6%       1525 ± 10%  interrupts.CPU0.NMI:Non-maskable_interrupts
      3594           -57.6%       1525 ± 10%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
     78.75 ± 11%    +223.2%     254.50 ± 16%  interrupts.CPU0.TLB:TLB_shootdowns
    250270 ±  5%    +519.7%    1550866 ±  2%  interrupts.CPU1.LOC:Local_timer_interrupts
      3681 ±  3%     -57.4%       1567 ± 15%  interrupts.CPU1.NMI:Non-maskable_interrupts
      3681 ±  3%     -57.4%       1567 ± 15%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
      2002 ± 10%     -45.0%       1101 ±  2%  interrupts.CPU1.RES:Rescheduling_interrupts
     22.50 ± 25%    +246.7%      78.00 ± 24%  interrupts.CPU1.TLB:TLB_shootdowns
    250330 ±  5%    +519.5%    1550902 ±  2%  interrupts.CPU10.LOC:Local_timer_interrupts
      1845 ±  2%     -49.1%     939.75 ±  3%  interrupts.CPU10.RES:Rescheduling_interrupts
    250260 ±  5%    +519.7%    1550834 ±  2%  interrupts.CPU100.LOC:Local_timer_interrupts
      3542 ±  3%     -59.5%       1436 ± 38%  interrupts.CPU100.NMI:Non-maskable_interrupts
      3542 ±  3%     -59.5%       1436 ± 38%  interrupts.CPU100.PMI:Performance_monitoring_interrupts
      1894 ±  4%     -47.3%     999.25        interrupts.CPU100.RES:Rescheduling_interrupts
    250262 ±  5%    +519.7%    1550862 ±  2%  interrupts.CPU101.LOC:Local_timer_interrupts
      3109 ± 25%     -53.0%       1460 ± 29%  interrupts.CPU101.NMI:Non-maskable_interrupts
      3109 ± 25%     -53.0%       1460 ± 29%  interrupts.CPU101.PMI:Performance_monitoring_interrupts
      1812 ±  4%     -47.3%     955.75 ±  2%  interrupts.CPU101.RES:Rescheduling_interrupts
      6.00 ± 28%   +1012.5%      66.75 ± 82%  interrupts.CPU101.TLB:TLB_shootdowns
    250258 ±  5%    +519.7%    1550832 ±  2%  interrupts.CPU102.LOC:Local_timer_interrupts
      3154 ± 26%     -52.2%       1509 ± 17%  interrupts.CPU102.NMI:Non-maskable_interrupts
      3154 ± 26%     -52.2%       1509 ± 17%  interrupts.CPU102.PMI:Performance_monitoring_interrupts
      1879 ±  4%     -45.4%       1026        interrupts.CPU102.RES:Rescheduling_interrupts
    250274 ±  5%    +519.7%    1550840 ±  2%  interrupts.CPU103.LOC:Local_timer_interrupts
      1901 ±  4%     -48.6%     977.25 ±  2%  interrupts.CPU103.RES:Rescheduling_interrupts
    250295 ±  5%    +519.6%    1550819 ±  2%  interrupts.CPU104.LOC:Local_timer_interrupts
      3145 ± 25%     -47.6%       1646 ±  7%  interrupts.CPU104.NMI:Non-maskable_interrupts
      3145 ± 25%     -47.6%       1646 ±  7%  interrupts.CPU104.PMI:Performance_monitoring_interrupts
      1890 ±  2%     -47.8%     986.00 ±  2%  interrupts.CPU104.RES:Rescheduling_interrupts
     13.00 ± 35%    +315.4%      54.00 ± 60%  interrupts.CPU104.TLB:TLB_shootdowns
    250303 ±  5%    +519.6%    1550845 ±  2%  interrupts.CPU105.LOC:Local_timer_interrupts
      3191 ± 26%     -57.9%       1342 ± 38%  interrupts.CPU105.NMI:Non-maskable_interrupts
      3191 ± 26%     -57.9%       1342 ± 38%  interrupts.CPU105.PMI:Performance_monitoring_interrupts
      1846 ±  2%     -46.3%     990.75 ±  2%  interrupts.CPU105.RES:Rescheduling_interrupts
    250296 ±  5%    +519.6%    1550812 ±  2%  interrupts.CPU106.LOC:Local_timer_interrupts
      1809 ±  2%     -48.3%     935.75 ±  3%  interrupts.CPU106.RES:Rescheduling_interrupts
    250301 ±  5%    +519.6%    1550854 ±  2%  interrupts.CPU107.LOC:Local_timer_interrupts
      1828 ±  2%     -47.2%     965.75 ±  4%  interrupts.CPU107.RES:Rescheduling_interrupts
    250288 ±  5%    +519.6%    1550847 ±  2%  interrupts.CPU108.LOC:Local_timer_interrupts
      1900 ±  3%     -48.7%     974.00 ±  2%  interrupts.CPU108.RES:Rescheduling_interrupts
    250289 ±  5%    +519.6%    1550815 ±  2%  interrupts.CPU109.LOC:Local_timer_interrupts
      1860 ±  4%     -46.2%       1001 ±  4%  interrupts.CPU109.RES:Rescheduling_interrupts
    250301 ±  5%    +519.6%    1550857 ±  2%  interrupts.CPU11.LOC:Local_timer_interrupts
      1666 ± 18%     -44.1%     931.75 ±  3%  interrupts.CPU11.RES:Rescheduling_interrupts
    250268 ±  5%    +519.7%    1550817 ±  2%  interrupts.CPU110.LOC:Local_timer_interrupts
      1786 ±  4%     -46.7%     952.25 ±  4%  interrupts.CPU110.RES:Rescheduling_interrupts
     14.25 ± 12%    +259.6%      51.25 ± 61%  interrupts.CPU110.TLB:TLB_shootdowns
    250277 ±  5%    +519.6%    1550825 ±  2%  interrupts.CPU111.LOC:Local_timer_interrupts
      1890 ±  3%     -48.7%     969.00 ±  3%  interrupts.CPU111.RES:Rescheduling_interrupts
     16.50 ± 28%    +225.8%      53.75 ± 76%  interrupts.CPU111.TLB:TLB_shootdowns
    250293 ±  5%    +519.6%    1550839 ±  2%  interrupts.CPU112.LOC:Local_timer_interrupts
      3213 ± 25%     -50.7%       1584 ± 23%  interrupts.CPU112.NMI:Non-maskable_interrupts
      3213 ± 25%     -50.7%       1584 ± 23%  interrupts.CPU112.PMI:Performance_monitoring_interrupts
      1774 ±  3%     -46.8%     944.25 ±  4%  interrupts.CPU112.RES:Rescheduling_interrupts
    250284 ±  5%    +519.6%    1550826 ±  2%  interrupts.CPU113.LOC:Local_timer_interrupts
      3554 ±  2%     -58.9%       1461 ± 19%  interrupts.CPU113.NMI:Non-maskable_interrupts
      3554 ±  2%     -58.9%       1461 ± 19%  interrupts.CPU113.PMI:Performance_monitoring_interrupts
      1793 ±  3%     -47.7%     937.50 ±  4%  interrupts.CPU113.RES:Rescheduling_interrupts
    250248 ±  5%    +519.7%    1550805 ±  2%  interrupts.CPU114.LOC:Local_timer_interrupts
      1915 ±  2%     -47.2%       1011 ±  2%  interrupts.CPU114.RES:Rescheduling_interrupts
    250262 ±  5%    +519.7%    1550799 ±  2%  interrupts.CPU115.LOC:Local_timer_interrupts
      3118 ± 25%     -49.6%       1571 ± 31%  interrupts.CPU115.NMI:Non-maskable_interrupts
      3118 ± 25%     -49.6%       1571 ± 31%  interrupts.CPU115.PMI:Performance_monitoring_interrupts
      1845 ±  2%     -47.8%     963.75 ±  3%  interrupts.CPU115.RES:Rescheduling_interrupts
    250239 ±  5%    +519.7%    1550835 ±  2%  interrupts.CPU116.LOC:Local_timer_interrupts
      1882 ±  4%     -49.5%     949.75 ±  4%  interrupts.CPU116.RES:Rescheduling_interrupts
    250246 ±  5%    +519.7%    1550817 ±  2%  interrupts.CPU117.LOC:Local_timer_interrupts
      3125 ± 25%     -52.3%       1489 ± 22%  interrupts.CPU117.NMI:Non-maskable_interrupts
      3125 ± 25%     -52.3%       1489 ± 22%  interrupts.CPU117.PMI:Performance_monitoring_interrupts
      1762 ±  4%     -44.8%     973.00 ±  2%  interrupts.CPU117.RES:Rescheduling_interrupts
    250163 ±  5%    +519.9%    1550807 ±  2%  interrupts.CPU118.LOC:Local_timer_interrupts
      3544           -58.2%       1480 ± 21%  interrupts.CPU118.NMI:Non-maskable_interrupts
      3544           -58.2%       1480 ± 21%  interrupts.CPU118.PMI:Performance_monitoring_interrupts
      1842 ±  3%     -48.6%     947.50        interrupts.CPU118.RES:Rescheduling_interrupts
    250251 ±  5%    +519.7%    1550846 ±  2%  interrupts.CPU119.LOC:Local_timer_interrupts
      3168 ± 25%     -53.1%       1486 ± 24%  interrupts.CPU119.NMI:Non-maskable_interrupts
      3168 ± 25%     -53.1%       1486 ± 24%  interrupts.CPU119.PMI:Performance_monitoring_interrupts
      1824 ±  3%     -47.2%     962.75 ±  3%  interrupts.CPU119.RES:Rescheduling_interrupts
    232.00 ± 60%  +11650.3%      27260 ±167%  interrupts.CPU12.34:PCI-MSI.524292-edge.eth0-TxRx-3
    250258 ±  5%    +519.7%    1550834 ±  2%  interrupts.CPU12.LOC:Local_timer_interrupts
      2713 ± 33%     -47.4%       1425 ± 17%  interrupts.CPU12.NMI:Non-maskable_interrupts
      2713 ± 33%     -47.4%       1425 ± 17%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
      1772 ±  6%     -47.3%     933.75 ±  7%  interrupts.CPU12.RES:Rescheduling_interrupts
    250233 ±  5%    +519.7%    1550720 ±  2%  interrupts.CPU120.LOC:Local_timer_interrupts
      3617 ±  2%     -52.6%       1713 ± 10%  interrupts.CPU120.NMI:Non-maskable_interrupts
      3617 ±  2%     -52.6%       1713 ± 10%  interrupts.CPU120.PMI:Performance_monitoring_interrupts
      1875 ±  3%     -45.1%       1030 ±  3%  interrupts.CPU120.RES:Rescheduling_interrupts
    250241 ±  5%    +519.7%    1550837 ±  2%  interrupts.CPU121.LOC:Local_timer_interrupts
      3583           -61.2%       1390 ± 31%  interrupts.CPU121.NMI:Non-maskable_interrupts
      3583           -61.2%       1390 ± 31%  interrupts.CPU121.PMI:Performance_monitoring_interrupts
      1869 ±  6%     -44.4%       1040 ±  3%  interrupts.CPU121.RES:Rescheduling_interrupts
    250265 ±  5%    +519.7%    1550837 ±  2%  interrupts.CPU122.LOC:Local_timer_interrupts
      3606           -52.4%       1718 ± 30%  interrupts.CPU122.NMI:Non-maskable_interrupts
      3606           -52.4%       1718 ± 30%  interrupts.CPU122.PMI:Performance_monitoring_interrupts
      1916           -46.2%       1031        interrupts.CPU122.RES:Rescheduling_interrupts
    250238 ±  5%    +519.7%    1550815 ±  2%  interrupts.CPU123.LOC:Local_timer_interrupts
      3595 ±  2%     -56.8%       1553 ± 29%  interrupts.CPU123.NMI:Non-maskable_interrupts
      3595 ±  2%     -56.8%       1553 ± 29%  interrupts.CPU123.PMI:Performance_monitoring_interrupts
      1875 ±  3%     -46.5%       1002 ±  4%  interrupts.CPU123.RES:Rescheduling_interrupts
    250241 ±  5%    +519.7%    1550822 ±  2%  interrupts.CPU124.LOC:Local_timer_interrupts
      3647 ±  2%     -48.3%       1884 ± 15%  interrupts.CPU124.NMI:Non-maskable_interrupts
      3647 ±  2%     -48.3%       1884 ± 15%  interrupts.CPU124.PMI:Performance_monitoring_interrupts
      1797 ±  2%     -44.9%     990.50 ±  3%  interrupts.CPU124.RES:Rescheduling_interrupts
    250247 ±  5%    +519.7%    1550832 ±  2%  interrupts.CPU125.LOC:Local_timer_interrupts
      3600 ±  2%     -49.4%       1820 ± 31%  interrupts.CPU125.NMI:Non-maskable_interrupts
      3600 ±  2%     -49.4%       1820 ± 31%  interrupts.CPU125.PMI:Performance_monitoring_interrupts
      1846 ±  3%     -48.5%     951.50 ±  4%  interrupts.CPU125.RES:Rescheduling_interrupts
    250257 ±  5%    +519.7%    1550762 ±  2%  interrupts.CPU126.LOC:Local_timer_interrupts
      1871 ±  2%     -46.0%       1010 ±  2%  interrupts.CPU126.RES:Rescheduling_interrupts
    250246 ±  5%    +519.7%    1550823 ±  2%  interrupts.CPU127.LOC:Local_timer_interrupts
      3607           -55.1%       1621 ± 33%  interrupts.CPU127.NMI:Non-maskable_interrupts
      3607           -55.1%       1621 ± 33%  interrupts.CPU127.PMI:Performance_monitoring_interrupts
      1941 ±  3%     -47.1%       1026 ±  4%  interrupts.CPU127.RES:Rescheduling_interrupts
    250252 ±  5%    +519.7%    1550817 ±  2%  interrupts.CPU128.LOC:Local_timer_interrupts
      3224 ± 24%     -55.0%       1451 ± 31%  interrupts.CPU128.NMI:Non-maskable_interrupts
      3224 ± 24%     -55.0%       1451 ± 31%  interrupts.CPU128.PMI:Performance_monitoring_interrupts
      1914 ±  2%     -47.2%       1010 ±  3%  interrupts.CPU128.RES:Rescheduling_interrupts
    250248 ±  5%    +519.7%    1550819 ±  2%  interrupts.CPU129.LOC:Local_timer_interrupts
      1849 ±  3%     -46.9%     982.75 ±  4%  interrupts.CPU129.RES:Rescheduling_interrupts
    250283 ±  5%    +519.6%    1550865 ±  2%  interrupts.CPU13.LOC:Local_timer_interrupts
      3168 ± 26%     -56.5%       1379 ± 18%  interrupts.CPU13.NMI:Non-maskable_interrupts
      3168 ± 26%     -56.5%       1379 ± 18%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
      1848 ±  3%     -46.6%     987.50 ±  6%  interrupts.CPU13.RES:Rescheduling_interrupts
    250247 ±  5%    +519.7%    1550821 ±  2%  interrupts.CPU130.LOC:Local_timer_interrupts
      3232 ± 24%     -53.8%       1493 ± 33%  interrupts.CPU130.NMI:Non-maskable_interrupts
      3232 ± 24%     -53.8%       1493 ± 33%  interrupts.CPU130.PMI:Performance_monitoring_interrupts
      1731 ±  2%     -44.0%     970.50 ±  2%  interrupts.CPU130.RES:Rescheduling_interrupts
    250246 ±  5%    +519.7%    1550828 ±  2%  interrupts.CPU131.LOC:Local_timer_interrupts
      1895 ±  2%     -47.9%     987.00 ±  4%  interrupts.CPU131.RES:Rescheduling_interrupts
    250241 ±  5%    +519.7%    1550786 ±  2%  interrupts.CPU132.LOC:Local_timer_interrupts
      3167 ± 24%     -53.4%       1475 ± 26%  interrupts.CPU132.NMI:Non-maskable_interrupts
      3167 ± 24%     -53.4%       1475 ± 26%  interrupts.CPU132.PMI:Performance_monitoring_interrupts
      1762 ±  2%     -42.5%       1013 ±  3%  interrupts.CPU132.RES:Rescheduling_interrupts
    250239 ±  5%    +519.7%    1550809 ±  2%  interrupts.CPU133.LOC:Local_timer_interrupts
      1823           -45.6%     992.25 ±  4%  interrupts.CPU133.RES:Rescheduling_interrupts
    250238 ±  5%    +519.7%    1550851 ±  2%  interrupts.CPU134.LOC:Local_timer_interrupts
      1831 ±  2%     -45.0%       1007        interrupts.CPU134.RES:Rescheduling_interrupts
    250243 ±  5%    +519.7%    1550859 ±  2%  interrupts.CPU135.LOC:Local_timer_interrupts
      1859 ±  2%     -46.9%     987.50 ±  2%  interrupts.CPU135.RES:Rescheduling_interrupts
    250241 ±  5%    +519.7%    1550840 ±  2%  interrupts.CPU136.LOC:Local_timer_interrupts
      1937 ±  3%     -48.2%       1003 ±  6%  interrupts.CPU136.RES:Rescheduling_interrupts
    250240 ±  5%    +519.7%    1550809 ±  2%  interrupts.CPU137.LOC:Local_timer_interrupts
      3221 ± 24%     -45.4%       1758 ± 12%  interrupts.CPU137.NMI:Non-maskable_interrupts
      3221 ± 24%     -45.4%       1758 ± 12%  interrupts.CPU137.PMI:Performance_monitoring_interrupts
      1851 ±  2%     -45.7%       1005 ±  2%  interrupts.CPU137.RES:Rescheduling_interrupts
    250253 ±  5%    +519.7%    1550832 ±  2%  interrupts.CPU138.LOC:Local_timer_interrupts
      3231 ± 24%     -52.9%       1521 ± 34%  interrupts.CPU138.NMI:Non-maskable_interrupts
      3231 ± 24%     -52.9%       1521 ± 34%  interrupts.CPU138.PMI:Performance_monitoring_interrupts
      1858 ±  2%     -45.8%       1007 ±  2%  interrupts.CPU138.RES:Rescheduling_interrupts
    250261 ±  5%    +519.7%    1550814 ±  2%  interrupts.CPU139.LOC:Local_timer_interrupts
      3149 ± 24%     -52.1%       1507 ± 33%  interrupts.CPU139.NMI:Non-maskable_interrupts
      3149 ± 24%     -52.1%       1507 ± 33%  interrupts.CPU139.PMI:Performance_monitoring_interrupts
      1827 ±  3%     -48.3%     944.50 ±  2%  interrupts.CPU139.RES:Rescheduling_interrupts
    250277 ±  5%    +519.6%    1550825 ±  2%  interrupts.CPU14.LOC:Local_timer_interrupts
      1913           -49.2%     971.00 ±  3%  interrupts.CPU14.RES:Rescheduling_interrupts
    250259 ±  5%    +519.7%    1550853 ±  2%  interrupts.CPU140.LOC:Local_timer_interrupts
      3175 ± 25%     -53.4%       1479 ± 32%  interrupts.CPU140.NMI:Non-maskable_interrupts
      3175 ± 25%     -53.4%       1479 ± 32%  interrupts.CPU140.PMI:Performance_monitoring_interrupts
      1857 ±  2%     -47.7%     971.25 ±  3%  interrupts.CPU140.RES:Rescheduling_interrupts
    250239 ±  5%    +519.7%    1550753 ±  2%  interrupts.CPU141.LOC:Local_timer_interrupts
      3119 ± 24%     -49.0%       1591 ±  5%  interrupts.CPU141.NMI:Non-maskable_interrupts
      3119 ± 24%     -49.0%       1591 ±  5%  interrupts.CPU141.PMI:Performance_monitoring_interrupts
      1879           -47.6%     985.75 ±  3%  interrupts.CPU141.RES:Rescheduling_interrupts
    250260 ±  5%    +519.7%    1550838 ±  2%  interrupts.CPU142.LOC:Local_timer_interrupts
      1763           -47.3%     928.75 ±  2%  interrupts.CPU142.RES:Rescheduling_interrupts
    250263 ±  5%    +519.7%    1550792 ±  2%  interrupts.CPU143.LOC:Local_timer_interrupts
      1802 ±  3%     -47.2%     951.75        interrupts.CPU143.RES:Rescheduling_interrupts
    250149 ±  5%    +519.9%    1550704 ±  2%  interrupts.CPU144.LOC:Local_timer_interrupts
      3632           -55.1%       1630 ± 10%  interrupts.CPU144.NMI:Non-maskable_interrupts
      3632           -55.1%       1630 ± 10%  interrupts.CPU144.PMI:Performance_monitoring_interrupts
      1873 ±  2%     -46.8%     996.50 ±  3%  interrupts.CPU144.RES:Rescheduling_interrupts
    250250 ±  5%    +519.7%    1550807 ±  2%  interrupts.CPU145.LOC:Local_timer_interrupts
      3147 ± 24%     -45.6%       1711 ± 16%  interrupts.CPU145.NMI:Non-maskable_interrupts
      3147 ± 24%     -45.6%       1711 ± 16%  interrupts.CPU145.PMI:Performance_monitoring_interrupts
      1797 ±  4%     -44.9%     990.50 ±  2%  interrupts.CPU145.RES:Rescheduling_interrupts
    250229 ±  5%    +519.8%    1550794 ±  2%  interrupts.CPU146.LOC:Local_timer_interrupts
      3168 ± 24%     -45.5%       1726 ±  5%  interrupts.CPU146.NMI:Non-maskable_interrupts
      3168 ± 24%     -45.5%       1726 ±  5%  interrupts.CPU146.PMI:Performance_monitoring_interrupts
      1858           -43.9%       1043 ±  3%  interrupts.CPU146.RES:Rescheduling_interrupts
    250261 ±  5%    +519.7%    1550823 ±  2%  interrupts.CPU147.LOC:Local_timer_interrupts
      3614           -49.2%       1837 ± 20%  interrupts.CPU147.NMI:Non-maskable_interrupts
      3614           -49.2%       1837 ± 20%  interrupts.CPU147.PMI:Performance_monitoring_interrupts
      1901 ±  3%     -47.2%       1004        interrupts.CPU147.RES:Rescheduling_interrupts
    250262 ±  5%    +519.7%    1550813 ±  2%  interrupts.CPU148.LOC:Local_timer_interrupts
      3626           -48.5%       1866 ± 21%  interrupts.CPU148.NMI:Non-maskable_interrupts
      3626           -48.5%       1866 ± 21%  interrupts.CPU148.PMI:Performance_monitoring_interrupts
      1809 ±  2%     -46.3%     971.00 ±  3%  interrupts.CPU148.RES:Rescheduling_interrupts
    250233 ±  5%    +519.7%    1550808 ±  2%  interrupts.CPU149.LOC:Local_timer_interrupts
      3602           -48.7%       1848 ±  5%  interrupts.CPU149.NMI:Non-maskable_interrupts
      3602           -48.7%       1848 ±  5%  interrupts.CPU149.PMI:Performance_monitoring_interrupts
      1903 ±  4%     -47.9%     992.50 ±  4%  interrupts.CPU149.RES:Rescheduling_interrupts
    250259 ±  5%    +519.7%    1550738 ±  2%  interrupts.CPU15.LOC:Local_timer_interrupts
      3148 ± 26%     -58.4%       1310 ± 22%  interrupts.CPU15.NMI:Non-maskable_interrupts
      3148 ± 26%     -58.4%       1310 ± 22%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
      1808 ±  2%     -48.1%     939.25 ±  2%  interrupts.CPU15.RES:Rescheduling_interrupts
    250276 ±  5%    +519.7%    1550847 ±  2%  interrupts.CPU150.LOC:Local_timer_interrupts
      3602           -44.2%       2011 ± 23%  interrupts.CPU150.NMI:Non-maskable_interrupts
      3602           -44.2%       2011 ± 23%  interrupts.CPU150.PMI:Performance_monitoring_interrupts
      1936 ±  6%     -46.5%       1037 ±  6%  interrupts.CPU150.RES:Rescheduling_interrupts
    250242 ±  5%    +519.7%    1550784 ±  2%  interrupts.CPU151.LOC:Local_timer_interrupts
      3574 ±  2%     -53.8%       1651 ± 12%  interrupts.CPU151.NMI:Non-maskable_interrupts
      3574 ±  2%     -53.8%       1651 ± 12%  interrupts.CPU151.PMI:Performance_monitoring_interrupts
      1887 ±  2%     -48.4%     974.50 ±  2%  interrupts.CPU151.RES:Rescheduling_interrupts
    250242 ±  5%    +519.7%    1550845 ±  2%  interrupts.CPU152.LOC:Local_timer_interrupts
      3637           -53.4%       1693 ± 20%  interrupts.CPU152.NMI:Non-maskable_interrupts
      3637           -53.4%       1693 ± 20%  interrupts.CPU152.PMI:Performance_monitoring_interrupts
      1826 ±  2%     -46.8%     971.75 ±  6%  interrupts.CPU152.RES:Rescheduling_interrupts
    250242 ±  5%    +519.7%    1550803 ±  2%  interrupts.CPU153.LOC:Local_timer_interrupts
      3636 ±  2%     -45.6%       1978 ± 12%  interrupts.CPU153.NMI:Non-maskable_interrupts
      3636 ±  2%     -45.6%       1978 ± 12%  interrupts.CPU153.PMI:Performance_monitoring_interrupts
      1857 ±  2%     -47.7%     971.00        interrupts.CPU153.RES:Rescheduling_interrupts
    250148 ±  5%    +520.0%    1550811 ±  2%  interrupts.CPU154.LOC:Local_timer_interrupts
      3556 ±  3%     -49.6%       1791 ± 20%  interrupts.CPU154.NMI:Non-maskable_interrupts
      3556 ±  3%     -49.6%       1791 ± 20%  interrupts.CPU154.PMI:Performance_monitoring_interrupts
      1864 ±  2%     -48.0%     970.25 ±  5%  interrupts.CPU154.RES:Rescheduling_interrupts
    250231 ±  5%    +519.8%    1550818 ±  2%  interrupts.CPU155.LOC:Local_timer_interrupts
      3627 ±  2%     -46.1%       1956 ±  6%  interrupts.CPU155.NMI:Non-maskable_interrupts
      3627 ±  2%     -46.1%       1956 ±  6%  interrupts.CPU155.PMI:Performance_monitoring_interrupts
      1822 ±  3%     -45.5%     992.75 ±  2%  interrupts.CPU155.RES:Rescheduling_interrupts
    250227 ±  5%    +519.8%    1550828 ±  2%  interrupts.CPU156.LOC:Local_timer_interrupts
      3608           -59.3%       1468 ± 28%  interrupts.CPU156.NMI:Non-maskable_interrupts
      3608           -59.3%       1468 ± 28%  interrupts.CPU156.PMI:Performance_monitoring_interrupts
      1860 ±  3%     -47.3%     980.50 ±  7%  interrupts.CPU156.RES:Rescheduling_interrupts
    250229 ±  5%    +519.8%    1550805 ±  2%  interrupts.CPU157.LOC:Local_timer_interrupts
      3596           -58.6%       1489 ± 11%  interrupts.CPU157.NMI:Non-maskable_interrupts
      3596           -58.6%       1489 ± 11%  interrupts.CPU157.PMI:Performance_monitoring_interrupts
      1914 ±  4%     -49.8%     960.50 ±  4%  interrupts.CPU157.RES:Rescheduling_interrupts
    250228 ±  5%    +519.7%    1550772 ±  2%  interrupts.CPU158.LOC:Local_timer_interrupts
      3715 ±  2%     -49.4%       1880 ±  3%  interrupts.CPU158.NMI:Non-maskable_interrupts
      3715 ±  2%     -49.4%       1880 ±  3%  interrupts.CPU158.PMI:Performance_monitoring_interrupts
      1882 ±  3%     -48.0%     978.25 ±  3%  interrupts.CPU158.RES:Rescheduling_interrupts
    250246 ±  5%    +519.7%    1550822 ±  2%  interrupts.CPU159.LOC:Local_timer_interrupts
      3557 ±  3%     -46.2%       1914 ± 21%  interrupts.CPU159.NMI:Non-maskable_interrupts
      3557 ±  3%     -46.2%       1914 ± 21%  interrupts.CPU159.PMI:Performance_monitoring_interrupts
      1811 ±  3%     -47.5%     951.00        interrupts.CPU159.RES:Rescheduling_interrupts
    250253 ±  5%    +519.7%    1550700 ±  2%  interrupts.CPU16.LOC:Local_timer_interrupts
      1851 ±  3%     -49.2%     941.00 ±  4%  interrupts.CPU16.RES:Rescheduling_interrupts
    250221 ±  5%    +519.8%    1550790 ±  2%  interrupts.CPU160.LOC:Local_timer_interrupts
      3608 ±  3%     -54.2%       1653 ±  4%  interrupts.CPU160.NMI:Non-maskable_interrupts
      3608 ±  3%     -54.2%       1653 ±  4%  interrupts.CPU160.PMI:Performance_monitoring_interrupts
      1798 ±  2%     -47.7%     940.00 ±  2%  interrupts.CPU160.RES:Rescheduling_interrupts
     11.00 ± 24%    +404.5%      55.50 ± 58%  interrupts.CPU160.TLB:TLB_shootdowns
    250247 ±  5%    +519.7%    1550827 ±  2%  interrupts.CPU161.LOC:Local_timer_interrupts
      3583           -45.0%       1971 ± 20%  interrupts.CPU161.NMI:Non-maskable_interrupts
      3583           -45.0%       1971 ± 20%  interrupts.CPU161.PMI:Performance_monitoring_interrupts
      1800 ±  3%     -48.4%     928.25 ±  4%  interrupts.CPU161.RES:Rescheduling_interrupts
    250247 ±  5%    +519.7%    1550796 ±  2%  interrupts.CPU162.LOC:Local_timer_interrupts
      3633           -58.5%       1508 ± 16%  interrupts.CPU162.NMI:Non-maskable_interrupts
      3633           -58.5%       1508 ± 16%  interrupts.CPU162.PMI:Performance_monitoring_interrupts
      1848 ±  4%     -45.9%       1000 ±  3%  interrupts.CPU162.RES:Rescheduling_interrupts
    250240 ±  5%    +519.7%    1550803 ±  2%  interrupts.CPU163.LOC:Local_timer_interrupts
      3601 ±  2%     -49.3%       1827 ± 18%  interrupts.CPU163.NMI:Non-maskable_interrupts
      3601 ±  2%     -49.3%       1827 ± 18%  interrupts.CPU163.PMI:Performance_monitoring_interrupts
      1784 ±  3%     -45.6%     971.75 ±  9%  interrupts.CPU163.RES:Rescheduling_interrupts
    250161 ±  5%    +519.9%    1550731 ±  2%  interrupts.CPU164.LOC:Local_timer_interrupts
      3592           -57.0%       1543 ±  6%  interrupts.CPU164.NMI:Non-maskable_interrupts
      3592           -57.0%       1543 ±  6%  interrupts.CPU164.PMI:Performance_monitoring_interrupts
      1843 ±  3%     -45.3%       1008 ±  2%  interrupts.CPU164.RES:Rescheduling_interrupts
    250235 ±  5%    +519.7%    1550793 ±  2%  interrupts.CPU165.LOC:Local_timer_interrupts
      3576 ±  2%     -54.3%       1634 ±  3%  interrupts.CPU165.NMI:Non-maskable_interrupts
      3576 ±  2%     -54.3%       1634 ±  3%  interrupts.CPU165.PMI:Performance_monitoring_interrupts
      1852 ±  2%     -46.8%     984.75 ±  3%  interrupts.CPU165.RES:Rescheduling_interrupts
    250242 ±  5%    +519.7%    1550816 ±  2%  interrupts.CPU166.LOC:Local_timer_interrupts
      3564           -59.1%       1457 ± 26%  interrupts.CPU166.NMI:Non-maskable_interrupts
      3564           -59.1%       1457 ± 26%  interrupts.CPU166.PMI:Performance_monitoring_interrupts
      1777 ±  3%     -48.4%     916.75 ±  5%  interrupts.CPU166.RES:Rescheduling_interrupts
    250239 ±  5%    +519.7%    1550824 ±  2%  interrupts.CPU167.LOC:Local_timer_interrupts
      3566 ±  2%     -58.5%       1480 ± 28%  interrupts.CPU167.NMI:Non-maskable_interrupts
      3566 ±  2%     -58.5%       1480 ± 28%  interrupts.CPU167.PMI:Performance_monitoring_interrupts
      1759 ±  2%     -47.9%     916.00 ±  4%  interrupts.CPU167.RES:Rescheduling_interrupts
    250260 ±  5%    +519.7%    1550854 ±  2%  interrupts.CPU168.LOC:Local_timer_interrupts
      3660 ±  2%     -51.7%       1766 ± 12%  interrupts.CPU168.NMI:Non-maskable_interrupts
      3660 ±  2%     -51.7%       1766 ± 12%  interrupts.CPU168.PMI:Performance_monitoring_interrupts
      2046 ±  8%     -50.5%       1012 ±  6%  interrupts.CPU168.RES:Rescheduling_interrupts
    822.50           +22.9%       1011 ± 13%  interrupts.CPU169.CAL:Function_call_interrupts
    250261 ±  5%    +519.7%    1550836 ±  2%  interrupts.CPU169.LOC:Local_timer_interrupts
      3657           -58.0%       1537 ± 21%  interrupts.CPU169.NMI:Non-maskable_interrupts
      3657           -58.0%       1537 ± 21%  interrupts.CPU169.PMI:Performance_monitoring_interrupts
      1977 ±  5%     -49.8%     992.25        interrupts.CPU169.RES:Rescheduling_interrupts
    250261 ±  5%    +519.7%    1550825 ±  2%  interrupts.CPU17.LOC:Local_timer_interrupts
      1860 ±  2%     -49.2%     945.25 ±  4%  interrupts.CPU17.RES:Rescheduling_interrupts
    250273 ±  5%    +519.7%    1550832 ±  2%  interrupts.CPU170.LOC:Local_timer_interrupts
      3572 ±  2%     -54.5%       1625 ± 28%  interrupts.CPU170.NMI:Non-maskable_interrupts
      3572 ±  2%     -54.5%       1625 ± 28%  interrupts.CPU170.PMI:Performance_monitoring_interrupts
      1952 ±  4%     -49.1%     994.00 ±  3%  interrupts.CPU170.RES:Rescheduling_interrupts
    250260 ±  5%    +519.7%    1550898 ±  2%  interrupts.CPU171.LOC:Local_timer_interrupts
      3624           -59.4%       1469 ± 25%  interrupts.CPU171.NMI:Non-maskable_interrupts
      3624           -59.4%       1469 ± 25%  interrupts.CPU171.PMI:Performance_monitoring_interrupts
      1867 ±  2%     -47.1%     987.75        interrupts.CPU171.RES:Rescheduling_interrupts
    250241 ±  5%    +519.7%    1550871 ±  2%  interrupts.CPU172.LOC:Local_timer_interrupts
      3643           -54.5%       1658 ± 37%  interrupts.CPU172.NMI:Non-maskable_interrupts
      3643           -54.5%       1658 ± 37%  interrupts.CPU172.PMI:Performance_monitoring_interrupts
      1994 ±  7%     -51.6%     964.75 ±  3%  interrupts.CPU172.RES:Rescheduling_interrupts
    250267 ±  5%    +519.7%    1550882 ±  2%  interrupts.CPU173.LOC:Local_timer_interrupts
      3646           -59.0%       1496 ± 32%  interrupts.CPU173.NMI:Non-maskable_interrupts
      3646           -59.0%       1496 ± 32%  interrupts.CPU173.PMI:Performance_monitoring_interrupts
      1977 ±  2%     -50.0%     988.50        interrupts.CPU173.RES:Rescheduling_interrupts
    250260 ±  5%    +519.7%    1550880 ±  2%  interrupts.CPU174.LOC:Local_timer_interrupts
      1937 ±  4%     -50.7%     955.50 ±  3%  interrupts.CPU174.RES:Rescheduling_interrupts
    250249 ±  5%    +519.7%    1550838 ±  2%  interrupts.CPU175.LOC:Local_timer_interrupts
      3641           -58.1%       1527 ± 16%  interrupts.CPU175.NMI:Non-maskable_interrupts
      3641           -58.1%       1527 ± 16%  interrupts.CPU175.PMI:Performance_monitoring_interrupts
      1991 ±  5%     -49.5%       1005 ±  2%  interrupts.CPU175.RES:Rescheduling_interrupts
    250251 ±  5%    +519.7%    1550859 ±  2%  interrupts.CPU176.LOC:Local_timer_interrupts
      3586           -58.7%       1481 ± 27%  interrupts.CPU176.NMI:Non-maskable_interrupts
      3586           -58.7%       1481 ± 27%  interrupts.CPU176.PMI:Performance_monitoring_interrupts
      1942 ±  3%     -48.4%       1001 ±  3%  interrupts.CPU176.RES:Rescheduling_interrupts
    250272 ±  5%    +519.7%    1550863 ±  2%  interrupts.CPU177.LOC:Local_timer_interrupts
      3656 ±  2%     -60.0%       1462 ± 24%  interrupts.CPU177.NMI:Non-maskable_interrupts
      3656 ±  2%     -60.0%       1462 ± 24%  interrupts.CPU177.PMI:Performance_monitoring_interrupts
      1894 ±  4%     -49.1%     964.25 ±  3%  interrupts.CPU177.RES:Rescheduling_interrupts
    250266 ±  5%    +519.7%    1550835 ±  2%  interrupts.CPU178.LOC:Local_timer_interrupts
      3672           -60.3%       1457 ± 20%  interrupts.CPU178.NMI:Non-maskable_interrupts
      3672           -60.3%       1457 ± 20%  interrupts.CPU178.PMI:Performance_monitoring_interrupts
      1828 ±  2%     -48.0%     951.25 ±  2%  interrupts.CPU178.RES:Rescheduling_interrupts
    250146 ±  5%    +520.0%    1550851 ±  2%  interrupts.CPU179.LOC:Local_timer_interrupts
      3635           -60.1%       1449 ± 21%  interrupts.CPU179.NMI:Non-maskable_interrupts
      3635           -60.1%       1449 ± 21%  interrupts.CPU179.PMI:Performance_monitoring_interrupts
      1848 ±  4%     -48.9%     945.00 ±  2%  interrupts.CPU179.RES:Rescheduling_interrupts
    250259 ±  5%    +519.7%    1550818 ±  2%  interrupts.CPU18.LOC:Local_timer_interrupts
      3176 ± 23%     -51.1%       1554 ± 25%  interrupts.CPU18.NMI:Non-maskable_interrupts
      3176 ± 23%     -51.1%       1554 ± 25%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
      1910 ±  3%     -50.4%     948.25 ±  2%  interrupts.CPU18.RES:Rescheduling_interrupts
    250264 ±  5%    +519.7%    1550841 ±  2%  interrupts.CPU180.LOC:Local_timer_interrupts
      3583 ±  2%     -60.1%       1429 ± 25%  interrupts.CPU180.NMI:Non-maskable_interrupts
      3583 ±  2%     -60.1%       1429 ± 25%  interrupts.CPU180.PMI:Performance_monitoring_interrupts
      1933 ±  4%     -50.5%     957.50 ±  4%  interrupts.CPU180.RES:Rescheduling_interrupts
    250299 ±  5%    +519.6%    1550792 ±  2%  interrupts.CPU181.LOC:Local_timer_interrupts
      3569           -56.4%       1557 ± 23%  interrupts.CPU181.NMI:Non-maskable_interrupts
      3569           -56.4%       1557 ± 23%  interrupts.CPU181.PMI:Performance_monitoring_interrupts
      1848 ±  5%     -48.3%     956.25 ±  4%  interrupts.CPU181.RES:Rescheduling_interrupts
    250278 ±  5%    +519.6%    1550805 ±  2%  interrupts.CPU182.LOC:Local_timer_interrupts
      3650 ±  2%     -53.7%       1691 ± 24%  interrupts.CPU182.NMI:Non-maskable_interrupts
      3650 ±  2%     -53.7%       1691 ± 24%  interrupts.CPU182.PMI:Performance_monitoring_interrupts
      1824 ±  4%     -48.1%     947.00 ±  3%  interrupts.CPU182.RES:Rescheduling_interrupts
    250270 ±  5%    +519.7%    1550821 ±  2%  interrupts.CPU183.LOC:Local_timer_interrupts
      3657           -55.7%       1618 ± 23%  interrupts.CPU183.NMI:Non-maskable_interrupts
      3657           -55.7%       1618 ± 23%  interrupts.CPU183.PMI:Performance_monitoring_interrupts
      1857 ±  4%     -49.4%     940.50 ±  3%  interrupts.CPU183.RES:Rescheduling_interrupts
    250267 ±  5%    +519.7%    1550820 ±  2%  interrupts.CPU184.LOC:Local_timer_interrupts
      3653 ±  3%     -55.9%       1610 ± 16%  interrupts.CPU184.NMI:Non-maskable_interrupts
      3653 ±  3%     -55.9%       1610 ± 16%  interrupts.CPU184.PMI:Performance_monitoring_interrupts
      1884 ±  4%     -51.1%     920.50 ±  2%  interrupts.CPU184.RES:Rescheduling_interrupts
    250274 ±  5%    +519.7%    1550834 ±  2%  interrupts.CPU185.LOC:Local_timer_interrupts
      3643           -52.8%       1718 ± 30%  interrupts.CPU185.NMI:Non-maskable_interrupts
      3643           -52.8%       1718 ± 30%  interrupts.CPU185.PMI:Performance_monitoring_interrupts
      1953 ±  2%     -50.5%     966.50 ±  2%  interrupts.CPU185.RES:Rescheduling_interrupts
    250263 ±  5%    +519.7%    1550859 ±  2%  interrupts.CPU186.LOC:Local_timer_interrupts
      3670           -55.2%       1642 ± 23%  interrupts.CPU186.NMI:Non-maskable_interrupts
      3670           -55.2%       1642 ± 23%  interrupts.CPU186.PMI:Performance_monitoring_interrupts
      1883 ±  2%     -50.0%     942.50        interrupts.CPU186.RES:Rescheduling_interrupts
    250257 ±  5%    +519.7%    1550831 ±  2%  interrupts.CPU187.LOC:Local_timer_interrupts
      3587           -56.9%       1547 ± 29%  interrupts.CPU187.NMI:Non-maskable_interrupts
      3587           -56.9%       1547 ± 29%  interrupts.CPU187.PMI:Performance_monitoring_interrupts
      1874 ±  6%     -49.5%     947.25 ±  2%  interrupts.CPU187.RES:Rescheduling_interrupts
    250267 ±  5%    +519.7%    1550837 ±  2%  interrupts.CPU188.LOC:Local_timer_interrupts
      3549 ±  2%     -55.2%       1591 ± 18%  interrupts.CPU188.NMI:Non-maskable_interrupts
      3549 ±  2%     -55.2%       1591 ± 18%  interrupts.CPU188.PMI:Performance_monitoring_interrupts
      1897 ±  6%     -50.3%     943.00 ±  2%  interrupts.CPU188.RES:Rescheduling_interrupts
    250254 ±  5%    +519.7%    1550805 ±  2%  interrupts.CPU189.LOC:Local_timer_interrupts
      3664 ±  2%     -49.3%       1858 ± 16%  interrupts.CPU189.NMI:Non-maskable_interrupts
      3664 ±  2%     -49.3%       1858 ± 16%  interrupts.CPU189.PMI:Performance_monitoring_interrupts
      1905 ±  4%     -51.0%     934.25 ±  2%  interrupts.CPU189.RES:Rescheduling_interrupts
    250224 ±  5%    +519.8%    1550863 ±  2%  interrupts.CPU19.LOC:Local_timer_interrupts
      3628           -54.3%       1656 ± 30%  interrupts.CPU19.NMI:Non-maskable_interrupts
      3628           -54.3%       1656 ± 30%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
      1798 ±  3%     -45.4%     982.25 ±  5%  interrupts.CPU19.RES:Rescheduling_interrupts
    250249 ±  5%    +519.7%    1550821 ±  2%  interrupts.CPU190.LOC:Local_timer_interrupts
      3639           -54.7%       1647 ± 27%  interrupts.CPU190.NMI:Non-maskable_interrupts
      3639           -54.7%       1647 ± 27%  interrupts.CPU190.PMI:Performance_monitoring_interrupts
      1882 ±  5%     -47.6%     986.75 ±  3%  interrupts.CPU190.RES:Rescheduling_interrupts
    250365 ±  5%    +519.7%    1551524 ±  2%  interrupts.CPU191.LOC:Local_timer_interrupts
      3534 ±  3%     -51.1%       1728 ± 26%  interrupts.CPU191.NMI:Non-maskable_interrupts
      3534 ±  3%     -51.1%       1728 ± 26%  interrupts.CPU191.PMI:Performance_monitoring_interrupts
      1787 ±  3%     -48.6%     918.50 ±  3%  interrupts.CPU191.RES:Rescheduling_interrupts
     27.25 ±  9%    +293.6%     107.25 ± 40%  interrupts.CPU191.TLB:TLB_shootdowns
    250227 ±  5%    +519.8%    1550836 ±  2%  interrupts.CPU2.LOC:Local_timer_interrupts
      3702 ±  2%     -53.3%       1727 ± 13%  interrupts.CPU2.NMI:Non-maskable_interrupts
      3702 ±  2%     -53.3%       1727 ± 13%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
      2675 ± 27%     -59.4%       1086 ±  3%  interrupts.CPU2.RES:Rescheduling_interrupts
    250256 ±  5%    +519.7%    1550840 ±  2%  interrupts.CPU20.LOC:Local_timer_interrupts
      1837 ±  2%     -49.9%     921.25 ±  5%  interrupts.CPU20.RES:Rescheduling_interrupts
    250262 ±  5%    +519.7%    1550839 ±  2%  interrupts.CPU21.LOC:Local_timer_interrupts
      3200 ± 24%     -53.0%       1505 ± 28%  interrupts.CPU21.NMI:Non-maskable_interrupts
      3200 ± 24%     -53.0%       1505 ± 28%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
      1829 ±  4%     -49.0%     933.25 ±  2%  interrupts.CPU21.RES:Rescheduling_interrupts
    250155 ±  5%    +519.9%    1550728 ±  2%  interrupts.CPU22.LOC:Local_timer_interrupts
      3620 ±  2%     -53.6%       1679 ±  5%  interrupts.CPU22.NMI:Non-maskable_interrupts
      3620 ±  2%     -53.6%       1679 ±  5%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
      1871 ±  4%     -49.6%     943.00        interrupts.CPU22.RES:Rescheduling_interrupts
    250266 ±  5%    +519.7%    1550836 ±  2%  interrupts.CPU23.LOC:Local_timer_interrupts
      3640           -54.7%       1650 ± 28%  interrupts.CPU23.NMI:Non-maskable_interrupts
      3640           -54.7%       1650 ± 28%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
      1829 ±  3%     -49.8%     917.75 ±  2%  interrupts.CPU23.RES:Rescheduling_interrupts
    250266 ±  5%    +519.7%    1550827 ±  2%  interrupts.CPU24.LOC:Local_timer_interrupts
      3673           -57.3%       1568 ± 19%  interrupts.CPU24.NMI:Non-maskable_interrupts
      3673           -57.3%       1568 ± 19%  interrupts.CPU24.PMI:Performance_monitoring_interrupts
      1890 ±  3%     -35.5%       1219 ± 14%  interrupts.CPU24.RES:Rescheduling_interrupts
     88.25 ± 33%    +230.3%     291.50 ± 16%  interrupts.CPU24.TLB:TLB_shootdowns
    250266 ±  5%    +519.7%    1550834 ±  2%  interrupts.CPU25.LOC:Local_timer_interrupts
      3570 ±  3%     -46.8%       1900 ±  7%  interrupts.CPU25.NMI:Non-maskable_interrupts
      3570 ±  3%     -46.8%       1900 ±  7%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
      1926 ±  3%     -43.4%       1091 ±  4%  interrupts.CPU25.RES:Rescheduling_interrupts
     36.75 ± 34%    +126.5%      83.25 ± 44%  interrupts.CPU25.TLB:TLB_shootdowns
    250260 ±  5%    +519.6%    1550730 ±  2%  interrupts.CPU26.LOC:Local_timer_interrupts
      1990 ±  2%     -43.9%       1117 ±  2%  interrupts.CPU26.RES:Rescheduling_interrupts
    250270 ±  5%    +519.7%    1550814 ±  2%  interrupts.CPU27.LOC:Local_timer_interrupts
      1827 ±  2%     -43.3%       1036 ±  5%  interrupts.CPU27.RES:Rescheduling_interrupts
    250257 ±  5%    +519.7%    1550824 ±  2%  interrupts.CPU28.LOC:Local_timer_interrupts
      1932           -45.2%       1059        interrupts.CPU28.RES:Rescheduling_interrupts
    250276 ±  5%    +519.6%    1550836 ±  2%  interrupts.CPU29.LOC:Local_timer_interrupts
      1810 ±  2%     -43.1%       1030        interrupts.CPU29.RES:Rescheduling_interrupts
    250184 ±  5%    +519.9%    1550847 ±  2%  interrupts.CPU3.LOC:Local_timer_interrupts
      1901 ±  2%     -46.5%       1016 ±  3%  interrupts.CPU3.RES:Rescheduling_interrupts
    250250 ±  5%    +519.7%    1550811 ±  2%  interrupts.CPU30.LOC:Local_timer_interrupts
      3201 ± 23%     -45.9%       1732 ± 15%  interrupts.CPU30.NMI:Non-maskable_interrupts
      3201 ± 23%     -45.9%       1732 ± 15%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
      1908 ±  2%     -44.9%       1050        interrupts.CPU30.RES:Rescheduling_interrupts
     13.00 ± 21%    +475.0%      74.75 ±100%  interrupts.CPU30.TLB:TLB_shootdowns
    250242 ±  5%    +519.7%    1550818 ±  2%  interrupts.CPU31.LOC:Local_timer_interrupts
      3185 ± 24%     -48.9%       1627 ± 21%  interrupts.CPU31.NMI:Non-maskable_interrupts
      3185 ± 24%     -48.9%       1627 ± 21%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
      1896 ±  2%     -44.9%       1044 ±  2%  interrupts.CPU31.RES:Rescheduling_interrupts
    250240 ±  5%    +519.7%    1550851 ±  2%  interrupts.CPU32.LOC:Local_timer_interrupts
      1937 ±  4%     -45.2%       1061 ±  3%  interrupts.CPU32.RES:Rescheduling_interrupts
    250254 ±  5%    +519.7%    1550818 ±  2%  interrupts.CPU33.LOC:Local_timer_interrupts
      3195 ± 25%     -54.0%       1470 ± 27%  interrupts.CPU33.NMI:Non-maskable_interrupts
      3195 ± 25%     -54.0%       1470 ± 27%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
      1758 ±  2%     -41.2%       1034 ±  3%  interrupts.CPU33.RES:Rescheduling_interrupts
    250243 ±  5%    +519.7%    1550835 ±  2%  interrupts.CPU34.LOC:Local_timer_interrupts
      3206 ± 24%     -51.9%       1543 ± 38%  interrupts.CPU34.NMI:Non-maskable_interrupts
      3206 ± 24%     -51.9%       1543 ± 38%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
      1864 ±  3%     -44.2%       1040 ±  2%  interrupts.CPU34.RES:Rescheduling_interrupts
    250251 ±  5%    +519.7%    1550751 ±  2%  interrupts.CPU35.LOC:Local_timer_interrupts
      3137 ± 23%     -51.6%       1518 ± 23%  interrupts.CPU35.NMI:Non-maskable_interrupts
      3137 ± 23%     -51.6%       1518 ± 23%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
      1811 ±  4%     -44.3%       1009 ±  3%  interrupts.CPU35.RES:Rescheduling_interrupts
    250253 ±  5%    +519.7%    1550849 ±  2%  interrupts.CPU36.LOC:Local_timer_interrupts
      3198 ± 25%     -50.8%       1574 ± 41%  interrupts.CPU36.NMI:Non-maskable_interrupts
      3198 ± 25%     -50.8%       1574 ± 41%  interrupts.CPU36.PMI:Performance_monitoring_interrupts
      1901 ±  4%     -45.9%       1029 ±  2%  interrupts.CPU36.RES:Rescheduling_interrupts
    250250 ±  5%    +519.7%    1550842 ±  2%  interrupts.CPU37.LOC:Local_timer_interrupts
      2719 ± 33%     -47.2%       1436 ± 23%  interrupts.CPU37.NMI:Non-maskable_interrupts
      2719 ± 33%     -47.2%       1436 ± 23%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
      1878 ±  4%     -43.4%       1063 ±  2%  interrupts.CPU37.RES:Rescheduling_interrupts
    250276 ±  5%    +519.6%    1550817 ±  2%  interrupts.CPU38.LOC:Local_timer_interrupts
      2720 ± 31%     -45.0%       1496 ± 27%  interrupts.CPU38.NMI:Non-maskable_interrupts
      2720 ± 31%     -45.0%       1496 ± 27%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
      1910           -44.7%       1056 ±  4%  interrupts.CPU38.RES:Rescheduling_interrupts
    250257 ±  5%    +519.7%    1550840 ±  2%  interrupts.CPU39.LOC:Local_timer_interrupts
      1849 ±  2%     -43.5%       1045        interrupts.CPU39.RES:Rescheduling_interrupts
    250284 ±  5%    +519.6%    1550737 ±  2%  interrupts.CPU4.LOC:Local_timer_interrupts
      3177 ± 24%     -51.0%       1556 ± 18%  interrupts.CPU4.NMI:Non-maskable_interrupts
      3177 ± 24%     -51.0%       1556 ± 18%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
      1785           -42.2%       1032 ±  4%  interrupts.CPU4.RES:Rescheduling_interrupts
    250256 ±  5%    +519.7%    1550814 ±  2%  interrupts.CPU40.LOC:Local_timer_interrupts
      3148 ± 23%     -53.2%       1474 ± 25%  interrupts.CPU40.NMI:Non-maskable_interrupts
      3148 ± 23%     -53.2%       1474 ± 25%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
      1914 ±  2%     -45.0%       1054 ±  5%  interrupts.CPU40.RES:Rescheduling_interrupts
    250244 ±  5%    +519.7%    1550861 ±  2%  interrupts.CPU41.LOC:Local_timer_interrupts
      3147 ± 25%     -55.0%       1417 ± 26%  interrupts.CPU41.NMI:Non-maskable_interrupts
      3147 ± 25%     -55.0%       1417 ± 26%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
      1840           -44.0%       1030 ±  5%  interrupts.CPU41.RES:Rescheduling_interrupts
    250256 ±  5%    +519.7%    1550845 ±  2%  interrupts.CPU42.LOC:Local_timer_interrupts
      3178 ± 25%     -52.4%       1513 ± 16%  interrupts.CPU42.NMI:Non-maskable_interrupts
      3178 ± 25%     -52.4%       1513 ± 16%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
      1847 ±  3%     -43.3%       1047 ±  3%  interrupts.CPU42.RES:Rescheduling_interrupts
    250251 ±  5%    +519.7%    1550834 ±  2%  interrupts.CPU43.LOC:Local_timer_interrupts
      1869 ±  2%     -44.6%       1035 ±  2%  interrupts.CPU43.RES:Rescheduling_interrupts
    250251 ±  5%    +519.7%    1550847 ±  2%  interrupts.CPU44.LOC:Local_timer_interrupts
      3183 ± 24%     -48.0%       1656 ±  7%  interrupts.CPU44.NMI:Non-maskable_interrupts
      3183 ± 24%     -48.0%       1656 ±  7%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
      1842           -44.4%       1024        interrupts.CPU44.RES:Rescheduling_interrupts
    250232 ±  5%    +519.7%    1550809 ±  2%  interrupts.CPU45.LOC:Local_timer_interrupts
      3138 ± 25%     -55.6%       1394 ± 20%  interrupts.CPU45.NMI:Non-maskable_interrupts
      3138 ± 25%     -55.6%       1394 ± 20%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
      1840 ±  2%     -44.6%       1019 ±  2%  interrupts.CPU45.RES:Rescheduling_interrupts
    250233 ±  5%    +519.7%    1550820 ±  2%  interrupts.CPU46.LOC:Local_timer_interrupts
      1738 ±  4%     -41.5%       1017 ±  3%  interrupts.CPU46.RES:Rescheduling_interrupts
    250233 ±  5%    +519.7%    1550819 ±  2%  interrupts.CPU47.LOC:Local_timer_interrupts
      2727 ± 33%     -38.0%       1692 ± 13%  interrupts.CPU47.NMI:Non-maskable_interrupts
      2727 ± 33%     -38.0%       1692 ± 13%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
      1826 ±  2%     -44.2%       1019 ±  3%  interrupts.CPU47.RES:Rescheduling_interrupts
      8.50 ± 65%    +520.6%      52.75 ± 65%  interrupts.CPU47.TLB:TLB_shootdowns
    250236 ±  5%    +519.7%    1550804 ±  2%  interrupts.CPU48.LOC:Local_timer_interrupts
      3269 ± 24%     -55.1%       1469 ± 17%  interrupts.CPU48.NMI:Non-maskable_interrupts
      3269 ± 24%     -55.1%       1469 ± 17%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
      1994 ±  3%     -41.4%       1169 ±  2%  interrupts.CPU48.RES:Rescheduling_interrupts
     83.75 ± 25%    +193.4%     245.75 ±  8%  interrupts.CPU48.TLB:TLB_shootdowns
    250259 ±  5%    +519.7%    1550841 ±  2%  interrupts.CPU49.LOC:Local_timer_interrupts
      2665 ± 31%     -36.5%       1692 ± 15%  interrupts.CPU49.NMI:Non-maskable_interrupts
      2665 ± 31%     -36.5%       1692 ± 15%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
      1948           -39.3%       1182 ±  2%  interrupts.CPU49.RES:Rescheduling_interrupts
    250221 ±  5%    +519.8%    1550822 ±  2%  interrupts.CPU5.LOC:Local_timer_interrupts
      3185 ± 26%     -62.3%       1200 ± 23%  interrupts.CPU5.NMI:Non-maskable_interrupts
      3185 ± 26%     -62.3%       1200 ± 23%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
      1838 ±  2%     -44.5%       1020 ±  3%  interrupts.CPU5.RES:Rescheduling_interrupts
    250263 ±  5%    +519.7%    1550817 ±  2%  interrupts.CPU50.LOC:Local_timer_interrupts
      1880 ±  2%     -40.5%       1119 ±  2%  interrupts.CPU50.RES:Rescheduling_interrupts
    250231 ±  5%    +519.8%    1550822 ±  2%  interrupts.CPU51.LOC:Local_timer_interrupts
      2702 ± 32%     -39.8%       1627 ± 10%  interrupts.CPU51.NMI:Non-maskable_interrupts
      2702 ± 32%     -39.8%       1627 ± 10%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
      1827 ±  4%     -39.9%       1098 ±  5%  interrupts.CPU51.RES:Rescheduling_interrupts
    250249 ±  5%    +519.7%    1550826 ±  2%  interrupts.CPU52.LOC:Local_timer_interrupts
      1887 ±  4%     -41.2%       1109 ±  2%  interrupts.CPU52.RES:Rescheduling_interrupts
    250277 ±  5%    +519.7%    1550850 ±  2%  interrupts.CPU53.LOC:Local_timer_interrupts
      3137 ± 24%     -51.3%       1527 ± 22%  interrupts.CPU53.NMI:Non-maskable_interrupts
      3137 ± 24%     -51.3%       1527 ± 22%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
      1851 ±  6%     -41.0%       1091 ±  2%  interrupts.CPU53.RES:Rescheduling_interrupts
    250252 ±  5%    +519.7%    1550804 ±  2%  interrupts.CPU54.LOC:Local_timer_interrupts
      3140 ± 24%     -46.3%       1686 ± 22%  interrupts.CPU54.NMI:Non-maskable_interrupts
      3140 ± 24%     -46.3%       1686 ± 22%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
      1939 ±  2%     -41.6%       1131 ±  2%  interrupts.CPU54.RES:Rescheduling_interrupts
    250241 ±  5%    +519.7%    1550816 ±  2%  interrupts.CPU55.LOC:Local_timer_interrupts
      2704 ± 32%     -46.4%       1449 ± 28%  interrupts.CPU55.NMI:Non-maskable_interrupts
      2704 ± 32%     -46.4%       1449 ± 28%  interrupts.CPU55.PMI:Performance_monitoring_interrupts
      1954 ±  5%     -43.4%       1105 ±  2%  interrupts.CPU55.RES:Rescheduling_interrupts
    250261 ±  5%    +519.7%    1550823 ±  2%  interrupts.CPU56.LOC:Local_timer_interrupts
      2703 ± 33%     -49.5%       1365 ± 34%  interrupts.CPU56.NMI:Non-maskable_interrupts
      2703 ± 33%     -49.5%       1365 ± 34%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
      1836 ±  4%     -40.6%       1091 ±  2%  interrupts.CPU56.RES:Rescheduling_interrupts
    250252 ±  5%    +519.7%    1550845 ±  2%  interrupts.CPU57.LOC:Local_timer_interrupts
      2672 ± 31%     -42.2%       1544 ± 29%  interrupts.CPU57.NMI:Non-maskable_interrupts
      2672 ± 31%     -42.2%       1544 ± 29%  interrupts.CPU57.PMI:Performance_monitoring_interrupts
      1846 ±  2%     -42.9%       1054        interrupts.CPU57.RES:Rescheduling_interrupts
    250269 ±  5%    +519.6%    1550796 ±  2%  interrupts.CPU58.LOC:Local_timer_interrupts
      2665 ± 30%     -49.6%       1344 ± 33%  interrupts.CPU58.NMI:Non-maskable_interrupts
      2665 ± 30%     -49.6%       1344 ± 33%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
      1908 ±  3%     -44.6%       1057 ±  2%  interrupts.CPU58.RES:Rescheduling_interrupts
    250255 ±  5%    +519.7%    1550819 ±  2%  interrupts.CPU59.LOC:Local_timer_interrupts
      1859 ±  3%     -43.2%       1056 ±  5%  interrupts.CPU59.RES:Rescheduling_interrupts
    250271 ±  5%    +519.7%    1550857 ±  2%  interrupts.CPU6.LOC:Local_timer_interrupts
      3171 ± 24%     -52.8%       1498 ± 26%  interrupts.CPU6.NMI:Non-maskable_interrupts
      3171 ± 24%     -52.8%       1498 ± 26%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
    250261 ±  5%    +519.7%    1550770 ±  2%  interrupts.CPU60.LOC:Local_timer_interrupts
      1845 ±  2%     -42.5%       1061 ±  2%  interrupts.CPU60.RES:Rescheduling_interrupts
    250263 ±  5%    +519.7%    1550828 ±  2%  interrupts.CPU61.LOC:Local_timer_interrupts
      3191 ± 24%     -54.0%       1469 ±  9%  interrupts.CPU61.NMI:Non-maskable_interrupts
      3191 ± 24%     -54.0%       1469 ±  9%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
      1848 ±  3%     -40.2%       1105        interrupts.CPU61.RES:Rescheduling_interrupts
    250142 ±  5%    +520.0%    1550811 ±  2%  interrupts.CPU62.LOC:Local_timer_interrupts
      1860           -42.4%       1071 ±  3%  interrupts.CPU62.RES:Rescheduling_interrupts
    250249 ±  5%    +519.7%    1550813 ±  2%  interrupts.CPU63.LOC:Local_timer_interrupts
      1797           -43.8%       1010        interrupts.CPU63.RES:Rescheduling_interrupts
    250129 ±  5%    +520.0%    1550812 ±  2%  interrupts.CPU64.LOC:Local_timer_interrupts
      3170 ± 24%     -45.9%       1716 ± 11%  interrupts.CPU64.NMI:Non-maskable_interrupts
      3170 ± 24%     -45.9%       1716 ± 11%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
      1795 ±  4%     -41.6%       1047        interrupts.CPU64.RES:Rescheduling_interrupts
    250268 ±  5%    +519.7%    1550790 ±  2%  interrupts.CPU65.LOC:Local_timer_interrupts
      2716 ± 34%     -36.1%       1735 ±  2%  interrupts.CPU65.NMI:Non-maskable_interrupts
      2716 ± 34%     -36.1%       1735 ±  2%  interrupts.CPU65.PMI:Performance_monitoring_interrupts
      1789 ±  3%     -43.5%       1011 ±  4%  interrupts.CPU65.RES:Rescheduling_interrupts
    250257 ±  5%    +519.7%    1550846 ±  2%  interrupts.CPU66.LOC:Local_timer_interrupts
      2692 ± 32%     -50.1%       1344 ± 26%  interrupts.CPU66.NMI:Non-maskable_interrupts
      2692 ± 32%     -50.1%       1344 ± 26%  interrupts.CPU66.PMI:Performance_monitoring_interrupts
      1926 ±  3%     -45.8%       1044 ±  3%  interrupts.CPU66.RES:Rescheduling_interrupts
    250254 ±  5%    +519.7%    1550821 ±  2%  interrupts.CPU67.LOC:Local_timer_interrupts
      1836 ±  3%     -42.1%       1064 ±  3%  interrupts.CPU67.RES:Rescheduling_interrupts
    250257 ±  5%    +519.7%    1550785 ±  2%  interrupts.CPU68.LOC:Local_timer_interrupts
      1831 ±  5%     -43.1%       1041 ±  4%  interrupts.CPU68.RES:Rescheduling_interrupts
    250251 ±  5%    +519.7%    1550814 ±  2%  interrupts.CPU69.LOC:Local_timer_interrupts
      2696 ± 34%     -42.1%       1561 ± 27%  interrupts.CPU69.NMI:Non-maskable_interrupts
      2696 ± 34%     -42.1%       1561 ± 27%  interrupts.CPU69.PMI:Performance_monitoring_interrupts
      1833 ±  4%     -40.2%       1095 ±  8%  interrupts.CPU69.RES:Rescheduling_interrupts
    250259 ±  5%    +519.7%    1550842 ±  2%  interrupts.CPU7.LOC:Local_timer_interrupts
      3229 ± 25%     -52.2%       1544 ± 32%  interrupts.CPU7.NMI:Non-maskable_interrupts
      3229 ± 25%     -52.2%       1544 ± 32%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
      1856 ±  3%     -46.8%     988.00 ±  4%  interrupts.CPU7.RES:Rescheduling_interrupts
    250255 ±  5%    +519.7%    1550819 ±  2%  interrupts.CPU70.LOC:Local_timer_interrupts
      2645 ± 33%     -41.1%       1559 ± 11%  interrupts.CPU70.NMI:Non-maskable_interrupts
      2645 ± 33%     -41.1%       1559 ± 11%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
      1830 ±  2%     -43.2%       1039 ±  2%  interrupts.CPU70.RES:Rescheduling_interrupts
    250258 ±  5%    +519.7%    1550809 ±  2%  interrupts.CPU71.LOC:Local_timer_interrupts
      2658 ± 32%     -39.2%       1616 ± 28%  interrupts.CPU71.NMI:Non-maskable_interrupts
      2658 ± 32%     -39.2%       1616 ± 28%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
      1838 ±  4%     -44.1%       1027        interrupts.CPU71.RES:Rescheduling_interrupts
    250274 ±  5%    +519.6%    1550801 ±  2%  interrupts.CPU72.LOC:Local_timer_interrupts
      2015 ±  5%     -40.4%       1201 ±  4%  interrupts.CPU72.RES:Rescheduling_interrupts
     86.50 ± 24%    +142.2%     209.50 ± 19%  interrupts.CPU72.TLB:TLB_shootdowns
    250275 ±  5%    +519.7%    1550874 ±  2%  interrupts.CPU73.LOC:Local_timer_interrupts
      1922 ±  5%     -38.6%       1180        interrupts.CPU73.RES:Rescheduling_interrupts
     23.00 ± 17%    +244.6%      79.25 ± 20%  interrupts.CPU73.TLB:TLB_shootdowns
    250254 ±  5%    +519.7%    1550884 ±  2%  interrupts.CPU74.LOC:Local_timer_interrupts
      1961 ±  4%     -41.6%       1145 ±  3%  interrupts.CPU74.RES:Rescheduling_interrupts
    250282 ±  5%    +519.6%    1550834 ±  2%  interrupts.CPU75.LOC:Local_timer_interrupts
      3140 ± 25%     -65.4%       1087 ± 31%  interrupts.CPU75.NMI:Non-maskable_interrupts
      3140 ± 25%     -65.4%       1087 ± 31%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
      1896 ±  3%     -39.9%       1140 ±  3%  interrupts.CPU75.RES:Rescheduling_interrupts
    250271 ±  5%    +519.7%    1550889 ±  2%  interrupts.CPU76.LOC:Local_timer_interrupts
      3193 ± 24%     -58.7%       1320 ± 28%  interrupts.CPU76.NMI:Non-maskable_interrupts
      3193 ± 24%     -58.7%       1320 ± 28%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
      1856           -39.1%       1130 ±  3%  interrupts.CPU76.RES:Rescheduling_interrupts
    250248 ±  5%    +519.7%    1550865 ±  2%  interrupts.CPU77.LOC:Local_timer_interrupts
      3606           -67.6%       1169 ± 39%  interrupts.CPU77.NMI:Non-maskable_interrupts
      3606           -67.6%       1169 ± 39%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
      1893 ±  4%     -42.9%       1081 ±  3%  interrupts.CPU77.RES:Rescheduling_interrupts
    250244 ±  5%    +519.7%    1550821 ±  2%  interrupts.CPU78.LOC:Local_timer_interrupts
      2694 ± 32%     -44.6%       1492 ± 23%  interrupts.CPU78.NMI:Non-maskable_interrupts
      2694 ± 32%     -44.6%       1492 ± 23%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
      2075 ±  9%     -44.4%       1154        interrupts.CPU78.RES:Rescheduling_interrupts
    250249 ±  5%    +519.7%    1550866 ±  2%  interrupts.CPU79.LOC:Local_timer_interrupts
      2709 ± 33%     -61.0%       1057 ± 43%  interrupts.CPU79.NMI:Non-maskable_interrupts
      2709 ± 33%     -61.0%       1057 ± 43%  interrupts.CPU79.PMI:Performance_monitoring_interrupts
      1952 ±  5%     -42.8%       1117 ±  3%  interrupts.CPU79.RES:Rescheduling_interrupts
    250260 ±  5%    +519.6%    1550723 ±  2%  interrupts.CPU8.LOC:Local_timer_interrupts
      3227 ± 25%     -53.9%       1489 ± 29%  interrupts.CPU8.NMI:Non-maskable_interrupts
      3227 ± 25%     -53.9%       1489 ± 29%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
      1884 ±  2%     -49.2%     958.00 ±  2%  interrupts.CPU8.RES:Rescheduling_interrupts
    250278 ±  5%    +519.7%    1550870 ±  2%  interrupts.CPU80.LOC:Local_timer_interrupts
      1913 ±  4%     -44.3%       1064 ±  3%  interrupts.CPU80.RES:Rescheduling_interrupts
    250164 ±  5%    +519.9%    1550840 ±  2%  interrupts.CPU81.LOC:Local_timer_interrupts
      3118 ± 23%     -56.6%       1352 ± 38%  interrupts.CPU81.NMI:Non-maskable_interrupts
      3118 ± 23%     -56.6%       1352 ± 38%  interrupts.CPU81.PMI:Performance_monitoring_interrupts
      1938 ±  3%     -45.0%       1067 ±  2%  interrupts.CPU81.RES:Rescheduling_interrupts
    250258 ±  5%    +519.7%    1550858 ±  2%  interrupts.CPU82.LOC:Local_timer_interrupts
      3143 ± 24%     -65.0%       1099 ± 49%  interrupts.CPU82.NMI:Non-maskable_interrupts
      3143 ± 24%     -65.0%       1099 ± 49%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
      1954 ±  4%     -44.9%       1076        interrupts.CPU82.RES:Rescheduling_interrupts
    250251 ±  5%    +519.7%    1550855 ±  2%  interrupts.CPU83.LOC:Local_timer_interrupts
      3567           -59.3%       1452 ± 23%  interrupts.CPU83.NMI:Non-maskable_interrupts
      3567           -59.3%       1452 ± 23%  interrupts.CPU83.PMI:Performance_monitoring_interrupts
      1823           -43.9%       1022 ±  2%  interrupts.CPU83.RES:Rescheduling_interrupts
    250278 ±  5%    +519.7%    1550863 ±  2%  interrupts.CPU84.LOC:Local_timer_interrupts
      3131 ± 24%     -58.2%       1308 ± 48%  interrupts.CPU84.NMI:Non-maskable_interrupts
      3131 ± 24%     -58.2%       1308 ± 48%  interrupts.CPU84.PMI:Performance_monitoring_interrupts
      1855 ±  4%     -42.5%       1066        interrupts.CPU84.RES:Rescheduling_interrupts
    250281 ±  5%    +519.7%    1550876 ±  2%  interrupts.CPU85.LOC:Local_timer_interrupts
      3158 ± 25%     -47.2%       1668 ± 17%  interrupts.CPU85.NMI:Non-maskable_interrupts
      3158 ± 25%     -47.2%       1668 ± 17%  interrupts.CPU85.PMI:Performance_monitoring_interrupts
      1934 ±  5%     -44.8%       1068 ±  4%  interrupts.CPU85.RES:Rescheduling_interrupts
    250271 ±  5%    +519.7%    1550851 ±  2%  interrupts.CPU86.LOC:Local_timer_interrupts
      1941 ±  4%     -45.1%       1065 ±  2%  interrupts.CPU86.RES:Rescheduling_interrupts
    250273 ±  5%    +519.6%    1550746 ±  2%  interrupts.CPU87.LOC:Local_timer_interrupts
      3136 ± 23%     -51.1%       1534 ± 24%  interrupts.CPU87.NMI:Non-maskable_interrupts
      3136 ± 23%     -51.1%       1534 ± 24%  interrupts.CPU87.PMI:Performance_monitoring_interrupts
      1864 ±  2%     -43.4%       1055        interrupts.CPU87.RES:Rescheduling_interrupts
    250288 ±  5%    +519.6%    1550849 ±  2%  interrupts.CPU88.LOC:Local_timer_interrupts
      3619 ±  2%     -53.6%       1680 ± 38%  interrupts.CPU88.NMI:Non-maskable_interrupts
      3619 ±  2%     -53.6%       1680 ± 38%  interrupts.CPU88.PMI:Performance_monitoring_interrupts
      1910 ±  5%     -46.1%       1030 ±  3%  interrupts.CPU88.RES:Rescheduling_interrupts
    250280 ±  5%    +519.6%    1550844 ±  2%  interrupts.CPU89.LOC:Local_timer_interrupts
      3553           -52.4%       1692 ± 31%  interrupts.CPU89.NMI:Non-maskable_interrupts
      3553           -52.4%       1692 ± 31%  interrupts.CPU89.PMI:Performance_monitoring_interrupts
      1868 ±  4%     -46.4%       1000        interrupts.CPU89.RES:Rescheduling_interrupts
    229.00 ± 24%    +537.2%       1459 ± 34%  interrupts.CPU9.31:PCI-MSI.524289-edge.eth0-TxRx-0
    250259 ±  5%    +519.7%    1550849 ±  2%  interrupts.CPU9.LOC:Local_timer_interrupts
      3207 ± 23%     -52.1%       1535 ± 20%  interrupts.CPU9.NMI:Non-maskable_interrupts
      3207 ± 23%     -52.1%       1535 ± 20%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
      1827 ±  3%     -47.2%     964.25 ±  2%  interrupts.CPU9.RES:Rescheduling_interrupts
    250271 ±  5%    +519.7%    1550856 ±  2%  interrupts.CPU90.LOC:Local_timer_interrupts
      3642           -55.8%       1609 ± 31%  interrupts.CPU90.NMI:Non-maskable_interrupts
      3642           -55.8%       1609 ± 31%  interrupts.CPU90.PMI:Performance_monitoring_interrupts
      2004 ±  6%     -48.3%       1037 ±  3%  interrupts.CPU90.RES:Rescheduling_interrupts
    250300 ±  5%    +519.6%    1550839 ±  2%  interrupts.CPU91.LOC:Local_timer_interrupts
      3674           -54.5%       1671 ± 24%  interrupts.CPU91.NMI:Non-maskable_interrupts
      3674           -54.5%       1671 ± 24%  interrupts.CPU91.PMI:Performance_monitoring_interrupts
      1959 ±  5%     -45.9%       1060 ±  4%  interrupts.CPU91.RES:Rescheduling_interrupts
     18.75 ± 23%    +224.0%      60.75 ± 60%  interrupts.CPU91.TLB:TLB_shootdowns
    250265 ±  5%    +519.7%    1550830 ±  2%  interrupts.CPU92.LOC:Local_timer_interrupts
      3150 ± 24%     -53.0%       1480 ± 26%  interrupts.CPU92.NMI:Non-maskable_interrupts
      3150 ± 24%     -53.0%       1480 ± 26%  interrupts.CPU92.PMI:Performance_monitoring_interrupts
      1871 ±  3%     -45.6%       1018 ±  2%  interrupts.CPU92.RES:Rescheduling_interrupts
    250266 ±  5%    +519.7%    1550831 ±  2%  interrupts.CPU93.LOC:Local_timer_interrupts
      3195 ± 25%     -54.2%       1464 ± 22%  interrupts.CPU93.NMI:Non-maskable_interrupts
      3195 ± 25%     -54.2%       1464 ± 22%  interrupts.CPU93.PMI:Performance_monitoring_interrupts
      1851 ±  6%     -47.4%     974.25 ±  2%  interrupts.CPU93.RES:Rescheduling_interrupts
    250262 ±  5%    +519.7%    1550849 ±  2%  interrupts.CPU94.LOC:Local_timer_interrupts
      3557           -63.2%       1309 ± 45%  interrupts.CPU94.NMI:Non-maskable_interrupts
      3557           -63.2%       1309 ± 45%  interrupts.CPU94.PMI:Performance_monitoring_interrupts
      1753 ±  4%     -41.5%       1026 ±  5%  interrupts.CPU94.RES:Rescheduling_interrupts
    250260 ±  5%    +519.7%    1550881 ±  2%  interrupts.CPU95.LOC:Local_timer_interrupts
      1761 ±  4%     -46.4%     943.50 ±  2%  interrupts.CPU95.RES:Rescheduling_interrupts
    250245 ±  5%    +519.7%    1550830 ±  2%  interrupts.CPU96.LOC:Local_timer_interrupts
      3121 ± 25%     -55.0%       1405 ± 27%  interrupts.CPU96.NMI:Non-maskable_interrupts
      3121 ± 25%     -55.0%       1405 ± 27%  interrupts.CPU96.PMI:Performance_monitoring_interrupts
      1893 ±  4%     -44.4%       1053 ±  2%  interrupts.CPU96.RES:Rescheduling_interrupts
    250264 ±  5%    +519.7%    1550786 ±  2%  interrupts.CPU97.LOC:Local_timer_interrupts
      1821           -45.6%     990.50 ±  2%  interrupts.CPU97.RES:Rescheduling_interrupts
    250248 ±  5%    +519.7%    1550826 ±  2%  interrupts.CPU98.LOC:Local_timer_interrupts
      1909           -47.7%     998.25        interrupts.CPU98.RES:Rescheduling_interrupts
    250342 ±  5%    +519.5%    1550849 ±  2%  interrupts.CPU99.LOC:Local_timer_interrupts
      3170 ± 25%     -50.2%       1579 ± 35%  interrupts.CPU99.NMI:Non-maskable_interrupts
      3170 ± 25%     -50.2%       1579 ± 35%  interrupts.CPU99.PMI:Performance_monitoring_interrupts
      1795 ±  2%     -45.1%     985.75        interrupts.CPU99.RES:Rescheduling_interrupts
    155.00 ±  9%     -99.2%       1.25 ± 34%  interrupts.IWI:IRQ_work_interrupts
  48048720 ±  5%    +519.7%  2.978e+08 ±  2%  interrupts.LOC:Local_timer_interrupts
      0.00       +3.8e+104%     384.00        interrupts.MCP:Machine_check_polls
    624268 ±  4%     -51.0%     306052 ±  4%  interrupts.NMI:Non-maskable_interrupts
    624268 ±  4%     -51.0%     306052 ±  4%  interrupts.PMI:Performance_monitoring_interrupts
    360901           -45.7%     196100        interrupts.RES:Rescheduling_interrupts
      2900 ±  2%    +173.0%       7918 ±  3%  interrupts.TLB:TLB_shootdowns


                                                                                
                                  aim7.jobs-per-min                             
                                                                                
  12000 +-------------------------------------------------------------------+   
        |                                                                   |   
  10000 |-+              +.....   ..+                         ...+          |   
        |.....+          :     +..   :          +....+.....+..              |   
        |     :         :            :         :                            |   
   8000 |-+    :        :             :        :                            |   
        |      :       :              :       :                             |   
   6000 |-+     :      :               :      :                             |   
        |       :     :                :     :                              |   
   4000 |-+      :    :                 :    :                              |   
        |        :   :                  :   :                               |   
        |         :  :                   :  :                               |   
   2000 |-+   O   :O:    O     O         :O:         O     O     O    O     |   
        |          ::                     ::                                |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                aim7.time.system_time                           
                                                                                
  18000 +-------------------------------------------------------------------+   
        |     O    O     O     O          O          O     O     O          |   
  16000 |-+                                                                 |   
  14000 |-+                                                                 |   
        |                                                                   |   
  12000 |-+                                                                 |   
  10000 |-+                                                                 |   
        |                                                                   |   
   8000 |-+                                                                 |   
   6000 |-+                                             ...+.....           |   
        |.....+.            ...+....+..         +....+..         +          |   
   4000 |-+     ..      .+..           .      ..                            |   
   2000 |-+       .   ..                ..   .                              |   
        |           ..                     ..                               |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                              aim7.time.elapsed_time                            
                                                                                
  900 +---------------------------------------------------------------------+   
      |                                                                     |   
  800 |-+         O     O                            O     O    O     O     |   
  700 |-+   O                O           O                                  |   
      |                                                                     |   
  600 |-+                                                                   |   
  500 |-+                                                                   |   
      |                                                                     |   
  400 |-+                                                                   |   
  300 |-+                                                                   |   
      |                                                                     |   
  200 |-+                                                                   |   
  100 |.....+....      .+....+.....+....      .+.....+.....+....+           |   
      |          .  ...                 .  ...                              |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                            aim7.time.elapsed_time.max                          
                                                                                
  900 +---------------------------------------------------------------------+   
      |                                                                     |   
  800 |-+         O     O                            O     O    O     O     |   
  700 |-+   O                O           O                                  |   
      |                                                                     |   
  600 |-+                                                                   |   
  500 |-+                                                                   |   
      |                                                                     |   
  400 |-+                                                                   |   
  300 |-+                                                                   |   
      |                                                                     |   
  200 |-+                                                                   |   
  100 |.....+....      .+....+.....+....      .+.....+.....+....+           |   
      |          .  ...                 .  ...                              |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                             aim7.time.minor_page_faults                        
                                                                                
  120000 +------------------------------------------------------------------+   
         |     O          O    O                                            |   
  100000 |-+                                                                |   
         |                                                                  |   
         |                                                                  |   
   80000 |-+                                                                |   
         |                                                                  |   
   60000 |-+                                                                |   
         |                                               ..+.....           |   
   40000 |.....+          +....+.....+.         +.....+..        +          |   
         |      +        .             .       +                            |   
         |       +     ..               ..    +                             |   
   20000 |-+      +   .                   .  +                              |   
         |         + .                      +                               |   
       0 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                         aim7.time.voluntary_context_switches                   
                                                                                
  4.5e+07 +-----------------------------------------------------------------+   
          |                                              ...+..             |   
    4e+07 |.....+              .+....            +....+..      ..           |   
  3.5e+07 |-+   :            ..      .           :                          |   
          |      :         +.         +         :                +          |   
    3e+07 |-+    :        :            :        :                           |   
  2.5e+07 |-+     :       :            :       :                            |   
          |       :      :              :      :                            |   
    2e+07 |-+      :     :              :     :                             |   
  1.5e+07 |-+   O  : O  :  O    O        : O  :       O     O    O     O    |   
          |        :   :                 :   :                              |   
    1e+07 |-+       :  :                  :  :                              |   
    5e+06 |-+       : :                   : :                               |   
          |          ::                    ::                               |   
        0 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                       aim7.time.involuntary_context_switches                   
                                                                                
  45000 +-------------------------------------------------------------------+   
        |                                                  O                |   
  40000 |-+   O    O     O     O          O          O           O    O     |   
  35000 |-+                                                                 |   
        |                                                                   |   
  30000 |-+                                                                 |   
  25000 |-+                                                                 |   
        |                                                                   |   
  20000 |-+                                                                 |   
  15000 |-+...+             ...+....                    ...+.....           |   
        |..    +         +..        +..         +....+..         +          |   
  10000 |-+     +      ..              .      ..                            |   
   5000 |-+      +    .                 ..   .                              |   
        |         + ..                     ..                               |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                             aim7.time.file_system_outputs                      
                                                                                
  1.8e+08 +-----------------------------------------------------------------+   
          |.....+          +....+.....+          +....+.....+....+          |   
  1.6e+08 |-+   :    O     :    O     :    O     :    O     O    O     O    |   
  1.4e+08 |-+    :        :            :        :                           |   
          |      :        :            :        :                           |   
  1.2e+08 |-+     :      :              :      :                            |   
    1e+08 |-+     :      :              :      :                            |   
          |       :     :               :     :                             |   
    8e+07 |-+      :    :                :    :                             |   
    6e+07 |-+      :   :                 :   :                              |   
          |        :   :                 :   :                              |   
    4e+07 |-+       : :                   : :                               |   
    2e+07 |-+       : :                   : :                               |   
          |          :                     :                                |   
        0 +-----------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-skl-2sp7: 72 threads Intel(R) Xeon(R) Gold 6139 CPU @ 2.30GHz with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/md/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/4BRD_12G/f2fs/x86_64-rhel-7.6/100/RAID0/debian-x86_64-20191114.cgz/lkp-skl-2sp7/sync_disk_rw/aim7/0x2006906

commit: 
  dc35d73a42 ("f2fs: compress: don't compress any datas after cp stop")
  ca7f76e680 ("f2fs: fix wrong discard space")

dc35d73a42291b2a ca7f76e680745d3b8a386638045 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :4           25%           1:4     dmesg.WARNING:at#for_ip_interrupt_entry/0x
         %stddev     %change         %stddev
             \          |                \  
      7939           -21.5%       6231 ±  8%  aim7.jobs-per-min
     75.59           +28.4%      97.03 ±  8%  aim7.time.elapsed_time
     75.59           +28.4%      97.03 ±  8%  aim7.time.elapsed_time.max
  87041324            -7.8%   80266132        aim7.time.file_system_outputs
    753426           +41.0%    1062368 ±  2%  aim7.time.involuntary_context_switches
     11088 ±  3%      -6.1%      10410 ±  4%  aim7.time.minor_page_faults
  24272076 ±  2%     -66.2%    8208104        aim7.time.voluntary_context_switches
      2398 ±167%    +387.1%      11680 ± 99%  numa-numastat.node1.other_node
     67953 ±  7%     +27.3%      86519 ± 11%  meminfo.AnonHugePages
    517426           -28.1%     372052 ±  8%  meminfo.max_used_kB
     18.44 ±  3%      -3.9       14.53 ±  2%  mpstat.cpu.all.sys%
      0.31 ±  2%      -0.1        0.23 ±  6%  mpstat.cpu.all.usr%
    961.00 ±  9%     +12.4%       1080 ±  8%  slabinfo.task_group.active_objs
    961.00 ±  9%     +12.4%       1080 ±  8%  slabinfo.task_group.num_objs
     81.61            +4.7%      85.48        iostat.cpu.idle
     18.07 ±  3%     -21.0%      14.29 ±  2%  iostat.cpu.system
    588701           -30.6%     408288 ±  7%  iostat.md0.wkB/s
    382.75 ±  7%    +375.9%       1821 ± 43%  numa-meminfo.node0.Active(file)
      2203           -66.5%     738.25 ±107%  numa-meminfo.node1.Active(file)
     70564 ±  4%     -11.0%      62805 ±  4%  numa-meminfo.node1.SUnreclaim
 3.001e+08 ± 17%     +50.6%  4.521e+08        cpuidle.C1.time
   4608776 ± 12%     +39.0%    6404093        cpuidle.C1.usage
  27832417 ±  5%     -51.0%   13632241 ± 13%  cpuidle.C1E.usage
    455971 ±  9%     -28.7%     325257 ±  3%  cpuidle.POLL.usage
     81.25            +4.6%      85.00        vmstat.cpu.id
    553455           -27.4%     402053 ±  7%  vmstat.io.bo
     13.00           -25.0%       9.75 ±  4%  vmstat.procs.r
    685834 ±  2%     -62.7%     255957 ±  7%  vmstat.system.cs
     96.25 ±  7%    +372.5%     454.75 ± 43%  numa-vmstat.node0.nr_active_file
     57.00 ± 15%     +73.2%      98.75 ±  8%  numa-vmstat.node0.nr_writeback
     96.25 ±  7%    +372.5%     454.75 ± 43%  numa-vmstat.node0.nr_zone_active_file
      6019 ±  2%     +15.0%       6921        numa-vmstat.node0.nr_zone_write_pending
    549.50           -66.4%     184.75 ±106%  numa-vmstat.node1.nr_active_file
     17640 ±  4%     -11.0%      15700 ±  4%  numa-vmstat.node1.nr_slab_unreclaimable
     62.75 ± 15%     +72.9%     108.50 ± 17%  numa-vmstat.node1.nr_writeback
    549.50           -66.4%     184.75 ±106%  numa-vmstat.node1.nr_zone_active_file
      6116           +11.4%       6814 ±  2%  numa-vmstat.node1.nr_zone_write_pending
     70491            -1.2%      69639        proc-vmstat.nr_active_anon
  10854038            -8.2%    9959728        proc-vmstat.nr_dirtied
      4461            -1.2%       4405        proc-vmstat.nr_inactive_anon
      7355            -3.3%       7115        proc-vmstat.nr_mapped
     10062 ±  2%      -9.0%       9156 ±  3%  proc-vmstat.nr_shmem
     73.75 ± 22%     +61.0%     118.75 ± 15%  proc-vmstat.nr_writeback
  10799705            -8.3%    9906371        proc-vmstat.nr_written
     70491            -1.2%      69639        proc-vmstat.nr_zone_active_anon
      4461            -1.2%       4405        proc-vmstat.nr_zone_inactive_anon
     12004           +14.4%      13738        proc-vmstat.nr_zone_write_pending
  10993690            -8.0%   10111845        proc-vmstat.numa_hit
  10970397            -8.0%   10088529        proc-vmstat.numa_local
      3070 ± 25%     -50.5%       1521 ± 45%  proc-vmstat.numa_pages_migrated
      9395 ±  3%     -35.6%       6048 ±  8%  proc-vmstat.pgactivate
  11113189            -7.6%   10266834        proc-vmstat.pgalloc_normal
      9745            -8.2%       8943        proc-vmstat.pgdeactivate
    243777           +20.5%     293801 ±  8%  proc-vmstat.pgfault
   1663430            +2.9%    1711891        proc-vmstat.pgfree
      3070 ± 25%     -50.5%       1521 ± 45%  proc-vmstat.pgmigrate_success
  43214576            -8.3%   39643409        proc-vmstat.pgpgout
     19482            -8.5%      17823        proc-vmstat.pgrotated
      1721           -75.2%     426.50 ±173%  sched_debug.SSf2fs_discard-9
      9988 ± 14%    +411.8%      51127 ± 39%  sched_debug.cfs_rq:/.min_vruntime.avg
     20903 ± 13%    +207.7%      64318 ± 37%  sched_debug.cfs_rq:/.min_vruntime.max
      4918 ± 32%    +749.7%      41789 ± 46%  sched_debug.cfs_rq:/.min_vruntime.min
     -3597           +59.3%      -5731        sched_debug.cfs_rq:/.spread0.min
      1623 ± 12%    +692.9%      12868 ±109%  sched_debug.cpu.avg_idle.min
     27522           +83.0%      50377 ± 26%  sched_debug.cpu.clock.avg
     27525           +83.0%      50380 ± 26%  sched_debug.cpu.clock.max
     27517           +83.1%      50373 ± 26%  sched_debug.cpu.clock.min
     27522           +83.0%      50377 ± 26%  sched_debug.cpu.clock_task.avg
     27525           +83.0%      50380 ± 26%  sched_debug.cpu.clock_task.max
     27517           +83.1%      50373 ± 26%  sched_debug.cpu.clock_task.min
      2132           +28.7%       2744 ± 12%  sched_debug.cpu.curr->pid.max
      6153 ± 13%   +1640.9%     107127 ± 53%  sched_debug.cpu.nr_switches.max
    586.75 ± 15%  +11414.7%      67562 ± 57%  sched_debug.cpu.nr_switches.min
    993.73 ±  8%    +659.9%       7551 ± 48%  sched_debug.cpu.nr_switches.stddev
      0.00       +4.8e+101%       0.48 ± 54%  sched_debug.cpu.nr_uninterruptible.avg
    -42.50           +37.6%     -58.50        sched_debug.cpu.nr_uninterruptible.min
     11.58 ± 12%     +60.4%      18.59 ±  9%  sched_debug.cpu.nr_uninterruptible.stddev
     27520           +83.0%      50375 ± 26%  sched_debug.cpu_clk
     27017           +84.6%      49874 ± 26%  sched_debug.ktime
     27912           +81.9%      50770 ± 26%  sched_debug.sched_clk
     17.12 ± 18%     -22.9%      13.20 ± 16%  perf-stat.i.MPKI
 2.613e+09           -36.8%  1.652e+09 ±  4%  perf-stat.i.branch-instructions
      1.93 ± 14%      -0.4        1.49 ± 15%  perf-stat.i.branch-miss-rate%
  38971857 ±  2%     -43.3%   22082567 ±  6%  perf-stat.i.branch-misses
     28.43            +4.6       33.07 ±  2%  perf-stat.i.cache-miss-rate%
  55318307           -39.3%   33565583 ±  6%  perf-stat.i.cache-misses
  1.81e+08           -46.3%   97183454 ±  7%  perf-stat.i.cache-references
    699515 ±  2%     -63.1%     258388 ±  8%  perf-stat.i.context-switches
      3.95 ±  4%     +18.1%       4.67 ±  2%  perf-stat.i.cpi
 4.696e+10 ±  2%     -24.2%  3.559e+10 ±  2%  perf-stat.i.cpu-cycles
     28258 ±  2%     -88.7%       3186 ±  7%  perf-stat.i.cpu-migrations
      0.31 ± 10%      -0.2        0.12 ± 21%  perf-stat.i.dTLB-load-miss-rate%
   9156005 ±  4%     -76.4%    2160209 ±  7%  perf-stat.i.dTLB-load-misses
  2.98e+09           -34.5%  1.952e+09 ±  4%  perf-stat.i.dTLB-loads
      0.05 ± 15%      -0.0        0.02 ± 33%  perf-stat.i.dTLB-store-miss-rate%
    558425 ±  8%     -80.1%     111023 ±  8%  perf-stat.i.dTLB-store-misses
 1.263e+09           -43.1%  7.188e+08 ±  6%  perf-stat.i.dTLB-stores
     14.21 ± 19%      -5.9        8.34 ± 20%  perf-stat.i.iTLB-load-miss-rate%
   1708664 ±  3%     -73.8%     447288 ± 10%  perf-stat.i.iTLB-load-misses
  11350228 ±  3%     -54.5%    5166619 ±  6%  perf-stat.i.iTLB-loads
  1.19e+10           -35.7%  7.649e+09 ±  4%  perf-stat.i.instructions
      0.29 ±  3%     -15.4%       0.25 ±  3%  perf-stat.i.ipc
      0.65 ±  2%     -24.3%       0.49 ±  2%  perf-stat.i.metric.GHz
      0.64 ±  8%     -54.1%       0.29 ±  8%  perf-stat.i.metric.K/sec
     98.23           -37.3%      61.57 ±  4%  perf-stat.i.metric.M/sec
      3011            -5.6%       2843        perf-stat.i.minor-faults
  21284832           -45.4%   11630660 ±  7%  perf-stat.i.node-load-misses
   2215116           -34.0%    1460923 ±  6%  perf-stat.i.node-loads
   5567601           -46.5%    2981164 ±  8%  perf-stat.i.node-store-misses
    681820           -35.0%     443032 ±  7%  perf-stat.i.node-stores
      3011            -5.6%       2843        perf-stat.i.page-faults
     15.20           -16.5%      12.69 ±  3%  perf-stat.overall.MPKI
      1.49            -0.2        1.34 ±  3%  perf-stat.overall.branch-miss-rate%
     30.57            +4.0       34.55        perf-stat.overall.cache-miss-rate%
      3.94 ±  2%     +18.1%       4.66 ±  2%  perf-stat.overall.cpi
    848.99 ±  2%     +25.3%       1064 ±  5%  perf-stat.overall.cycles-between-cache-misses
      0.31 ±  4%      -0.2        0.11 ±  3%  perf-stat.overall.dTLB-load-miss-rate%
      0.04 ±  7%      -0.0        0.02 ±  4%  perf-stat.overall.dTLB-store-miss-rate%
     13.09 ±  3%      -5.1        7.96 ±  5%  perf-stat.overall.iTLB-load-miss-rate%
      6976 ±  3%    +146.8%      17222 ±  7%  perf-stat.overall.instructions-per-iTLB-miss
      0.25 ±  2%     -15.3%       0.21 ±  2%  perf-stat.overall.ipc
     90.57            -1.7       88.84        perf-stat.overall.node-load-miss-rate%
     89.09            -2.0       87.06        perf-stat.overall.node-store-miss-rate%
 2.578e+09           -36.6%  1.634e+09 ±  4%  perf-stat.ps.branch-instructions
  38465596 ±  2%     -43.2%   21847480 ±  6%  perf-stat.ps.branch-misses
  54568349           -39.2%   33188814 ±  6%  perf-stat.ps.cache-misses
 1.785e+08           -46.2%   96117013 ±  6%  perf-stat.ps.cache-references
    690012 ±  2%     -63.0%     255472 ±  7%  perf-stat.ps.context-switches
 4.632e+10 ±  2%     -24.0%   3.52e+10 ±  2%  perf-stat.ps.cpu-cycles
     27875 ±  2%     -88.7%       3150 ±  7%  perf-stat.ps.cpu-migrations
   9031964 ±  4%     -76.3%    2136711 ±  6%  perf-stat.ps.dTLB-load-misses
  2.94e+09           -34.4%   1.93e+09 ±  4%  perf-stat.ps.dTLB-loads
    550895 ±  8%     -80.1%     109900 ±  8%  perf-stat.ps.dTLB-store-misses
 1.246e+09           -42.9%  7.108e+08 ±  6%  perf-stat.ps.dTLB-stores
   1685566 ±  3%     -73.7%     442500 ± 10%  perf-stat.ps.iTLB-load-misses
  11196470 ±  3%     -54.4%    5108956 ±  6%  perf-stat.ps.iTLB-loads
 1.174e+10           -35.6%  7.564e+09 ±  4%  perf-stat.ps.instructions
      2973            -5.4%       2814        perf-stat.ps.minor-faults
  20995806           -45.2%   11499541 ±  7%  perf-stat.ps.node-load-misses
   2185068           -33.9%    1444484 ±  6%  perf-stat.ps.node-loads
   5492004           -46.3%    2947547 ±  8%  perf-stat.ps.node-store-misses
    672590           -34.9%     438044 ±  7%  perf-stat.ps.node-stores
      2973            -5.4%       2814        perf-stat.ps.page-faults
 8.985e+11           -18.1%   7.36e+11 ±  4%  perf-stat.total.instructions
     16580 ±  4%     -25.0%      12428 ±  9%  softirqs.CPU0.RCU
     17857           +22.7%      21913 ±  4%  softirqs.CPU0.SCHED
     32695           +41.0%      46093 ± 10%  softirqs.CPU0.TIMER
     16807 ±  5%     -24.9%      12622 ±  9%  softirqs.CPU1.RCU
     13377 ±  5%     +19.7%      16008 ±  9%  softirqs.CPU1.SCHED
     16698 ±  4%     -25.9%      12376 ±  9%  softirqs.CPU10.RCU
     12568 ±  2%     +17.4%      14752 ±  8%  softirqs.CPU10.SCHED
     30563 ±  2%     +25.1%      38229 ±  8%  softirqs.CPU10.TIMER
     16835 ±  3%     -25.4%      12552 ±  9%  softirqs.CPU11.RCU
     12716 ±  4%     +15.2%      14644 ±  6%  softirqs.CPU11.SCHED
     30324 ±  3%     +27.9%      38791 ±  7%  softirqs.CPU11.TIMER
     16108 ±  3%     -23.4%      12333 ± 10%  softirqs.CPU12.RCU
     12964           +14.7%      14865 ±  7%  softirqs.CPU12.SCHED
     31771 ±  2%     +21.3%      38524 ±  8%  softirqs.CPU12.TIMER
     16660 ±  4%     -23.4%      12754 ± 12%  softirqs.CPU13.RCU
     12916           +16.6%      15059 ±  4%  softirqs.CPU13.SCHED
     30430 ±  2%     +28.5%      39103 ±  7%  softirqs.CPU13.TIMER
     16701 ±  2%     -27.0%      12197 ±  9%  softirqs.CPU14.RCU
     12419 ±  4%     +21.7%      15119 ±  7%  softirqs.CPU14.SCHED
     16109 ±  4%     -26.6%      11818 ± 11%  softirqs.CPU15.RCU
     12884           +16.8%      15048 ±  5%  softirqs.CPU15.SCHED
     30302 ±  3%     +27.1%      38512 ±  7%  softirqs.CPU15.TIMER
     16084 ±  4%     -26.8%      11777 ± 12%  softirqs.CPU16.RCU
     12962           +15.0%      14908 ±  7%  softirqs.CPU16.SCHED
     30936 ±  3%     +26.2%      39038 ±  8%  softirqs.CPU16.TIMER
     16091 ±  4%     -25.8%      11937 ± 13%  softirqs.CPU17.RCU
     12619 ±  2%     +18.7%      14975 ±  7%  softirqs.CPU17.SCHED
     30710 ±  2%     +26.8%      38952 ±  7%  softirqs.CPU17.TIMER
     18768 ±  4%     -27.9%      13537 ± 11%  softirqs.CPU18.RCU
     17724 ±  3%     -25.5%      13210 ± 11%  softirqs.CPU19.RCU
     12797           +20.3%      15399 ±  7%  softirqs.CPU19.SCHED
     30443 ±  2%     +28.2%      39027 ±  7%  softirqs.CPU19.TIMER
     16610 ±  4%     -23.2%      12749 ±  9%  softirqs.CPU2.RCU
     13107 ±  4%     +18.5%      15537 ±  5%  softirqs.CPU2.SCHED
     30552 ±  2%     +28.1%      39151 ±  6%  softirqs.CPU2.TIMER
     18682 ± 10%     -31.1%      12874 ± 10%  softirqs.CPU20.RCU
     12409 ±  2%     +18.7%      14729 ±  8%  softirqs.CPU20.SCHED
     30878           +23.0%      37977 ±  8%  softirqs.CPU20.TIMER
     12841 ±  3%     +18.9%      15272 ±  8%  softirqs.CPU21.SCHED
     32787 ± 10%     +27.3%      41731 ± 12%  softirqs.CPU21.TIMER
     17683 ±  2%     -26.1%      13073 ± 11%  softirqs.CPU22.RCU
     12771           +19.4%      15254 ±  7%  softirqs.CPU22.SCHED
     30408 ±  2%     +26.3%      38406 ±  8%  softirqs.CPU22.TIMER
     17782 ±  4%     -27.0%      12985 ±  9%  softirqs.CPU23.RCU
     12452 ±  2%     +21.5%      15133 ±  6%  softirqs.CPU23.SCHED
     30950 ±  7%     +20.8%      37393 ±  7%  softirqs.CPU23.TIMER
     17531 ±  4%     -26.4%      12903 ±  9%  softirqs.CPU24.RCU
     12839 ±  2%     +15.6%      14843 ±  5%  softirqs.CPU24.SCHED
     30179 ±  3%     +26.2%      38084 ±  8%  softirqs.CPU24.TIMER
     12258 ±  3%     +28.6%      15765 ±  9%  softirqs.CPU25.SCHED
     30169 ±  3%     +48.0%      44649 ± 25%  softirqs.CPU25.TIMER
     17639 ±  5%     -27.2%      12833 ±  9%  softirqs.CPU26.RCU
     12957           +16.4%      15079 ±  6%  softirqs.CPU26.SCHED
     30560 ±  4%     +27.6%      38980 ±  7%  softirqs.CPU26.TIMER
     17557 ±  4%     -27.5%      12722 ±  9%  softirqs.CPU27.RCU
     12364 ±  2%     +21.9%      15069 ±  7%  softirqs.CPU27.SCHED
     29835 ±  3%     +24.5%      37152 ±  8%  softirqs.CPU27.TIMER
     17505 ±  4%     -26.4%      12879 ±  9%  softirqs.CPU28.RCU
     12588 ±  3%     +18.1%      14868 ±  8%  softirqs.CPU28.SCHED
     29894 ±  3%     +25.9%      37649 ±  8%  softirqs.CPU28.TIMER
     17503 ±  3%     -27.3%      12729 ±  9%  softirqs.CPU29.RCU
     12185 ±  3%     +25.0%      15226 ±  6%  softirqs.CPU29.SCHED
     30167 ±  3%     +25.4%      37844 ±  7%  softirqs.CPU29.TIMER
     16667 ±  4%     -24.8%      12536 ± 10%  softirqs.CPU3.RCU
     13374 ±  2%     +14.7%      15334 ±  6%  softirqs.CPU3.SCHED
     30331 ±  2%     +26.3%      38309 ±  8%  softirqs.CPU3.TIMER
     16776 ±  3%     -28.0%      12074 ± 12%  softirqs.CPU30.RCU
     12438           +16.7%      14520 ±  6%  softirqs.CPU30.SCHED
     29995 ±  2%     +25.7%      37700 ±  8%  softirqs.CPU30.TIMER
     16807 ±  3%     -25.9%      12458 ±  9%  softirqs.CPU31.RCU
     12840           +17.8%      15123 ±  7%  softirqs.CPU31.SCHED
     30075 ±  2%     +26.3%      37974 ±  8%  softirqs.CPU31.TIMER
     16904 ±  4%     -25.9%      12519 ±  8%  softirqs.CPU32.RCU
     12883           +16.3%      14983 ±  8%  softirqs.CPU32.SCHED
     29587 ±  3%     +25.9%      37265 ±  9%  softirqs.CPU32.TIMER
     16989 ±  3%     -26.5%      12484 ±  9%  softirqs.CPU33.RCU
     11634 ±  8%     +28.7%      14970 ±  8%  softirqs.CPU33.SCHED
     29908 ±  2%     +24.3%      37190 ±  8%  softirqs.CPU33.TIMER
     17160 ±  5%     -27.5%      12433 ±  9%  softirqs.CPU34.RCU
     12737 ±  2%     +18.7%      15122 ±  7%  softirqs.CPU34.SCHED
     31209 ±  6%     +21.9%      38045 ±  8%  softirqs.CPU34.TIMER
     12652 ±  3%     +18.2%      14958 ±  7%  softirqs.CPU35.SCHED
     30751 ±  2%     +24.8%      38365 ±  6%  softirqs.CPU35.TIMER
     17888 ±  5%     -27.2%      13017 ± 10%  softirqs.CPU36.RCU
     11687 ± 12%     +22.8%      14352 ±  6%  softirqs.CPU36.SCHED
     28997 ±  3%     +25.9%      36510 ±  7%  softirqs.CPU36.TIMER
     17437 ±  6%     -26.0%      12910 ± 10%  softirqs.CPU37.RCU
     12251           +19.2%      14600 ±  7%  softirqs.CPU37.SCHED
     29465 ±  3%     +24.7%      36735 ±  8%  softirqs.CPU37.TIMER
     17832 ±  4%     -27.0%      13009 ± 10%  softirqs.CPU38.RCU
     12254 ±  4%     +20.4%      14751 ±  7%  softirqs.CPU38.SCHED
     28959           +26.9%      36747 ±  7%  softirqs.CPU38.TIMER
     17614 ±  4%     -26.9%      12868 ±  8%  softirqs.CPU39.RCU
     12469 ±  2%     +16.6%      14541 ±  7%  softirqs.CPU39.SCHED
     28920 ±  2%     +26.1%      36456 ±  7%  softirqs.CPU39.TIMER
     16790 ±  4%     -23.9%      12772 ± 10%  softirqs.CPU4.RCU
     12984 ±  2%     +16.4%      15114 ±  8%  softirqs.CPU4.SCHED
     30730 ±  2%     +24.6%      38277 ±  9%  softirqs.CPU4.TIMER
     18101 ±  4%     -21.5%      14217 ± 14%  softirqs.CPU40.RCU
     12366 ±  4%     +20.0%      14837 ±  6%  softirqs.CPU40.SCHED
     29748           +29.6%      38555 ± 11%  softirqs.CPU40.TIMER
     17811 ±  4%     -25.6%      13256 ±  9%  softirqs.CPU41.RCU
     29048 ±  2%     +27.4%      36999 ±  7%  softirqs.CPU41.TIMER
     17906 ±  4%     -25.4%      13361 ± 10%  softirqs.CPU42.RCU
     12196 ±  3%     +21.9%      14871 ±  8%  softirqs.CPU42.SCHED
     29512 ±  2%     +29.4%      38188 ±  6%  softirqs.CPU42.TIMER
     17884 ±  4%     -27.2%      13012 ±  9%  softirqs.CPU43.RCU
     12895           +15.8%      14932 ±  6%  softirqs.CPU43.SCHED
     29328 ±  2%     +26.1%      36974 ±  7%  softirqs.CPU43.TIMER
     17819 ±  4%     -26.6%      13077 ± 10%  softirqs.CPU44.RCU
     12271 ±  4%     +20.6%      14802 ±  5%  softirqs.CPU44.SCHED
     29355           +25.9%      36944 ±  6%  softirqs.CPU44.TIMER
     17481 ±  4%     -23.9%      13294 ±  8%  softirqs.CPU45.RCU
     12640           +18.6%      14990 ±  7%  softirqs.CPU45.SCHED
     28518           +31.4%      37469 ±  6%  softirqs.CPU45.TIMER
     17426 ±  4%     -25.7%      12949 ±  9%  softirqs.CPU46.RCU
     12684           +16.2%      14736 ±  5%  softirqs.CPU46.SCHED
     29278 ±  3%     +26.9%      37154 ±  7%  softirqs.CPU46.TIMER
     17695 ±  3%     -25.5%      13191 ± 10%  softirqs.CPU47.RCU
     12945           +15.9%      15003 ±  7%  softirqs.CPU47.SCHED
     29374 ±  3%     +30.0%      38181 ±  8%  softirqs.CPU47.TIMER
     18249 ±  4%     -28.8%      13000 ±  9%  softirqs.CPU48.RCU
     12720 ±  3%     +15.4%      14679 ±  5%  softirqs.CPU48.SCHED
     17620 ±  3%     -25.5%      13131 ±  9%  softirqs.CPU49.RCU
     12178 ±  4%     +22.0%      14857 ±  6%  softirqs.CPU49.SCHED
     28771 ±  2%     +27.9%      36805 ±  8%  softirqs.CPU49.TIMER
     16454 ±  4%     -24.1%      12496 ± 10%  softirqs.CPU5.RCU
     12567           +19.0%      14956 ±  8%  softirqs.CPU5.SCHED
     29273 ±  4%     +31.0%      38346 ±  8%  softirqs.CPU5.TIMER
     16859 ± 11%     -23.7%      12870 ±  9%  softirqs.CPU50.RCU
     12728           +12.4%      14307 ±  6%  softirqs.CPU50.SCHED
     28479 ±  2%     +28.1%      36474 ±  7%  softirqs.CPU50.TIMER
     17621 ±  4%     -26.1%      13024 ±  9%  softirqs.CPU51.RCU
     12752           +16.8%      14890 ±  6%  softirqs.CPU51.SCHED
     29034 ±  2%     +27.6%      37053 ±  7%  softirqs.CPU51.TIMER
     17692 ±  4%     -25.8%      13119 ±  9%  softirqs.CPU52.RCU
     11702 ±  3%     +27.9%      14971 ±  5%  softirqs.CPU52.SCHED
     29520 ±  3%     +29.8%      38315 ±  9%  softirqs.CPU52.TIMER
     17695 ±  3%     -26.4%      13029 ±  9%  softirqs.CPU53.RCU
     12576 ±  3%     +18.6%      14914 ±  6%  softirqs.CPU53.SCHED
     29882 ±  2%     +24.0%      37041 ±  7%  softirqs.CPU53.TIMER
     16438 ±  7%     -24.0%      12495 ± 10%  softirqs.CPU54.RCU
     12455 ±  4%     +20.2%      14966 ±  7%  softirqs.CPU54.SCHED
     29759 ±  4%     +21.7%      36207 ±  7%  softirqs.CPU54.TIMER
     16817 ±  4%     -25.0%      12607 ±  9%  softirqs.CPU55.RCU
     12670 ±  2%     +19.7%      15166 ±  7%  softirqs.CPU55.SCHED
     29678 ±  2%     +25.2%      37151 ±  8%  softirqs.CPU55.TIMER
     17119 ±  5%     -26.5%      12578 ± 11%  softirqs.CPU56.RCU
     12617 ±  2%     +16.6%      14709 ±  7%  softirqs.CPU56.SCHED
     28601 ±  5%     +23.4%      35301 ±  8%  softirqs.CPU56.TIMER
     17116 ±  4%     -26.2%      12630 ± 10%  softirqs.CPU57.RCU
     12398           +20.1%      14893 ±  8%  softirqs.CPU57.SCHED
     29751 ±  3%     +26.2%      37538 ±  7%  softirqs.CPU57.TIMER
     17989 ± 14%     -30.2%      12554 ±  9%  softirqs.CPU58.RCU
     12586 ±  4%     +20.1%      15122 ±  6%  softirqs.CPU58.SCHED
     30272 ±  6%     +20.3%      36429 ±  6%  softirqs.CPU58.TIMER
     16799 ±  4%     -24.7%      12653 ±  9%  softirqs.CPU59.RCU
     12709 ±  4%     +16.0%      14743 ±  6%  softirqs.CPU59.SCHED
     29422 ±  3%     +20.1%      35345 ±  6%  softirqs.CPU59.TIMER
     16699 ±  6%     -26.2%      12320 ±  9%  softirqs.CPU6.RCU
     12820 ± 10%     +20.0%      15389 ±  7%  softirqs.CPU6.SCHED
     30458 ±  2%     +25.9%      38347 ±  8%  softirqs.CPU6.TIMER
     16003 ±  4%     -26.4%      11774 ± 15%  softirqs.CPU60.RCU
     12051 ±  5%     +25.6%      15132 ±  8%  softirqs.CPU60.SCHED
     29638 ±  4%     +30.7%      38736 ±  7%  softirqs.CPU60.TIMER
     15738 ±  4%     -27.9%      11342 ±  7%  softirqs.CPU61.RCU
     12822           +20.7%      15475 ±  9%  softirqs.CPU61.SCHED
     29934 ±  3%     +55.8%      46647 ± 25%  softirqs.CPU61.TIMER
     15840 ±  4%     -28.0%      11398 ± 10%  softirqs.CPU62.RCU
     12801 ±  2%     +18.7%      15200 ±  7%  softirqs.CPU62.SCHED
     29643 ±  2%     +25.7%      37269 ±  7%  softirqs.CPU62.TIMER
     15627 ±  4%     -26.0%      11559 ± 10%  softirqs.CPU63.RCU
     29127 ±  2%     +24.7%      36323 ±  6%  softirqs.CPU63.TIMER
     15717 ±  3%     -26.0%      11631 ± 11%  softirqs.CPU64.RCU
     12646 ±  2%     +17.4%      14845 ±  8%  softirqs.CPU64.SCHED
     29100 ±  2%     +25.3%      36451 ±  7%  softirqs.CPU64.TIMER
     15485 ±  4%     -26.6%      11361 ± 11%  softirqs.CPU65.RCU
     12234 ±  4%     +23.5%      15110 ±  8%  softirqs.CPU65.SCHED
     29359 ±  3%     +25.3%      36785 ±  8%  softirqs.CPU65.TIMER
     15416 ±  4%     -26.7%      11297 ±  9%  softirqs.CPU66.RCU
     12161 ±  6%     +25.1%      15208 ±  7%  softirqs.CPU66.SCHED
     29030 ±  2%     +39.9%      40627 ± 19%  softirqs.CPU66.TIMER
     15728 ±  5%     -27.9%      11340 ± 10%  softirqs.CPU67.RCU
     12875           +15.9%      14925 ±  6%  softirqs.CPU67.SCHED
     30000 ±  4%     +21.2%      36356 ±  8%  softirqs.CPU67.TIMER
     15416 ±  4%     -26.6%      11315 ±  9%  softirqs.CPU68.RCU
     12459 ±  4%     +18.8%      14806 ±  8%  softirqs.CPU68.SCHED
     28716 ±  2%     +24.3%      35698 ±  7%  softirqs.CPU68.TIMER
     15661 ±  6%     -26.3%      11546 ±  8%  softirqs.CPU69.RCU
     12889           +15.4%      14870 ±  9%  softirqs.CPU69.SCHED
     29403 ±  3%     +24.3%      36536 ±  6%  softirqs.CPU69.TIMER
     17719 ± 12%     -28.6%      12643 ± 10%  softirqs.CPU7.RCU
     13001           +15.5%      15022 ±  7%  softirqs.CPU7.SCHED
     31242 ±  6%     +23.2%      38476 ±  8%  softirqs.CPU7.TIMER
     15721 ±  3%     -28.0%      11320 ± 10%  softirqs.CPU70.RCU
     12965           +17.0%      15166 ±  7%  softirqs.CPU70.SCHED
     29662 ±  3%     +24.4%      36899 ±  7%  softirqs.CPU70.TIMER
     15709 ±  3%     -26.9%      11489 ± 10%  softirqs.CPU71.RCU
     12844           +17.8%      15128 ±  7%  softirqs.CPU71.SCHED
     30054 ±  3%     +21.2%      36425 ±  8%  softirqs.CPU71.TIMER
     16832 ±  4%     -25.7%      12511 ± 10%  softirqs.CPU8.RCU
     12734 ±  3%     +16.6%      14843 ±  7%  softirqs.CPU8.SCHED
     30744 ±  2%     +25.1%      38460 ±  8%  softirqs.CPU8.TIMER
     16382 ±  4%     -26.1%      12107 ± 10%  softirqs.CPU9.RCU
     12685 ±  2%     +17.6%      14921 ±  7%  softirqs.CPU9.SCHED
     29280 ±  3%     +29.1%      37789 ±  8%  softirqs.CPU9.TIMER
   1224645 ±  4%     -26.0%     905993 ± 10%  softirqs.RCU
    915351           +18.7%    1086131 ±  6%  softirqs.SCHED
   2174969 ±  2%     +26.0%    2739843 ±  7%  softirqs.TIMER
    154.00           +27.3%     196.00 ±  8%  interrupts.9:IO-APIC.9-fasteoi.acpi
    151406           +29.5%     196026 ±  8%  interrupts.CPU0.LOC:Local_timer_interrupts
    154.00           +27.3%     196.00 ±  8%  interrupts.CPU1.9:IO-APIC.9-fasteoi.acpi
    151397           +29.5%     196098 ±  8%  interrupts.CPU1.LOC:Local_timer_interrupts
    151478           +29.4%     196086 ±  8%  interrupts.CPU10.LOC:Local_timer_interrupts
      3056 ±  5%     -28.1%       2197 ± 16%  interrupts.CPU10.NMI:Non-maskable_interrupts
      3056 ±  5%     -28.1%       2197 ± 16%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
      2593 ±  2%     -42.4%       1495 ±  2%  interrupts.CPU10.RES:Rescheduling_interrupts
    151449           +29.5%     196122 ±  8%  interrupts.CPU11.LOC:Local_timer_interrupts
      3160 ±  3%     -31.9%       2153 ± 14%  interrupts.CPU11.NMI:Non-maskable_interrupts
      3160 ±  3%     -31.9%       2153 ± 14%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
      2410 ±  4%     -40.1%       1443 ± 15%  interrupts.CPU11.RES:Rescheduling_interrupts
    151568           +29.4%     196095 ±  8%  interrupts.CPU12.LOC:Local_timer_interrupts
      3138 ±  5%     -33.4%       2090 ± 11%  interrupts.CPU12.NMI:Non-maskable_interrupts
      3138 ±  5%     -33.4%       2090 ± 11%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
      2473 ±  4%     -45.8%       1340        interrupts.CPU12.RES:Rescheduling_interrupts
    151418           +29.5%     196081 ±  8%  interrupts.CPU13.LOC:Local_timer_interrupts
      3164 ±  4%     -35.9%       2027 ± 18%  interrupts.CPU13.NMI:Non-maskable_interrupts
      3164 ±  4%     -35.9%       2027 ± 18%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
      2369           -44.7%       1311 ±  2%  interrupts.CPU13.RES:Rescheduling_interrupts
    151337           +29.6%     196059 ±  8%  interrupts.CPU14.LOC:Local_timer_interrupts
      2531           -37.9%       1573 ± 23%  interrupts.CPU14.RES:Rescheduling_interrupts
    151448           +29.5%     196067 ±  8%  interrupts.CPU15.LOC:Local_timer_interrupts
      3131 ±  3%     -32.1%       2125 ± 16%  interrupts.CPU15.NMI:Non-maskable_interrupts
      3131 ±  3%     -32.1%       2125 ± 16%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
      2339           -41.8%       1361 ±  2%  interrupts.CPU15.RES:Rescheduling_interrupts
    151491           +29.6%     196269 ±  8%  interrupts.CPU16.LOC:Local_timer_interrupts
      3128 ±  5%     -34.8%       2038 ± 11%  interrupts.CPU16.NMI:Non-maskable_interrupts
      3128 ±  5%     -34.8%       2038 ± 11%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
      2542 ±  2%     -41.7%       1482 ±  2%  interrupts.CPU16.RES:Rescheduling_interrupts
    151421           +29.5%     196085 ±  8%  interrupts.CPU17.LOC:Local_timer_interrupts
      3148 ±  4%     -34.6%       2059 ± 21%  interrupts.CPU17.NMI:Non-maskable_interrupts
      3148 ±  4%     -34.6%       2059 ± 21%  interrupts.CPU17.PMI:Performance_monitoring_interrupts
      2319           -45.0%       1276        interrupts.CPU17.RES:Rescheduling_interrupts
    150763           +30.0%     196050 ±  8%  interrupts.CPU18.LOC:Local_timer_interrupts
      3225 ±  3%     -31.8%       2200 ± 17%  interrupts.CPU18.NMI:Non-maskable_interrupts
      3225 ±  3%     -31.8%       2200 ± 17%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
      2573 ±  2%     -41.4%       1508 ±  3%  interrupts.CPU18.RES:Rescheduling_interrupts
    150740           +30.1%     196041 ±  8%  interrupts.CPU19.LOC:Local_timer_interrupts
      3176 ±  3%     -36.5%       2016 ±  9%  interrupts.CPU19.NMI:Non-maskable_interrupts
      3176 ±  3%     -36.5%       2016 ±  9%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
      2391 ±  2%     -39.9%       1437 ± 14%  interrupts.CPU19.RES:Rescheduling_interrupts
    151352           +29.6%     196112 ±  8%  interrupts.CPU2.LOC:Local_timer_interrupts
      3110 ±  3%     -42.8%       1778 ± 33%  interrupts.CPU2.NMI:Non-maskable_interrupts
      3110 ±  3%     -42.8%       1778 ± 33%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
      3403 ± 27%     -43.7%       1916 ± 58%  interrupts.CPU2.RES:Rescheduling_interrupts
    150733           +30.0%     195978 ±  8%  interrupts.CPU20.LOC:Local_timer_interrupts
      3162 ±  3%     -31.7%       2159 ± 10%  interrupts.CPU20.NMI:Non-maskable_interrupts
      3162 ±  3%     -31.7%       2159 ± 10%  interrupts.CPU20.PMI:Performance_monitoring_interrupts
      2416           -44.8%       1332 ±  3%  interrupts.CPU20.RES:Rescheduling_interrupts
    150708           +30.0%     195981 ±  8%  interrupts.CPU21.LOC:Local_timer_interrupts
      3164 ±  4%     -41.2%       1861 ± 15%  interrupts.CPU21.NMI:Non-maskable_interrupts
      3164 ±  4%     -41.2%       1861 ± 15%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
      2435 ±  6%     -44.9%       1341 ±  4%  interrupts.CPU21.RES:Rescheduling_interrupts
    150598           +30.2%     196024 ±  8%  interrupts.CPU22.LOC:Local_timer_interrupts
      2415           -45.8%       1309 ±  3%  interrupts.CPU22.RES:Rescheduling_interrupts
    150759           +30.0%     196061 ±  8%  interrupts.CPU23.LOC:Local_timer_interrupts
      2426           -41.2%       1427 ±  4%  interrupts.CPU23.RES:Rescheduling_interrupts
    150754           +30.0%     196018 ±  8%  interrupts.CPU24.LOC:Local_timer_interrupts
      3193 ±  3%     -37.3%       2001 ± 14%  interrupts.CPU24.NMI:Non-maskable_interrupts
      3193 ±  3%     -37.3%       2001 ± 14%  interrupts.CPU24.PMI:Performance_monitoring_interrupts
      2540 ±  4%     -43.4%       1436 ±  3%  interrupts.CPU24.RES:Rescheduling_interrupts
    150661           +30.1%     195982 ±  8%  interrupts.CPU25.LOC:Local_timer_interrupts
      3124 ±  4%     -34.6%       2042 ± 12%  interrupts.CPU25.NMI:Non-maskable_interrupts
      3124 ±  4%     -34.6%       2042 ± 12%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
      2399 ±  2%     -43.8%       1349 ±  3%  interrupts.CPU25.RES:Rescheduling_interrupts
    150711           +30.0%     195989 ±  8%  interrupts.CPU26.LOC:Local_timer_interrupts
      3153 ±  4%     -42.1%       1825 ± 23%  interrupts.CPU26.NMI:Non-maskable_interrupts
      3153 ±  4%     -42.1%       1825 ± 23%  interrupts.CPU26.PMI:Performance_monitoring_interrupts
      2496 ±  6%     -43.2%       1417 ±  3%  interrupts.CPU26.RES:Rescheduling_interrupts
    150789           +30.0%     196036 ±  8%  interrupts.CPU27.LOC:Local_timer_interrupts
      2499 ±  2%     -44.3%       1392 ±  6%  interrupts.CPU27.RES:Rescheduling_interrupts
    150736           +30.0%     195895 ±  8%  interrupts.CPU28.LOC:Local_timer_interrupts
      3163 ±  4%     -53.3%       1478 ± 23%  interrupts.CPU28.NMI:Non-maskable_interrupts
      3163 ±  4%     -53.3%       1478 ± 23%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
      2435           -37.3%       1527 ±  9%  interrupts.CPU28.RES:Rescheduling_interrupts
    150690           +30.1%     195992 ±  8%  interrupts.CPU29.LOC:Local_timer_interrupts
      3138 ±  4%     -45.8%       1700 ± 17%  interrupts.CPU29.NMI:Non-maskable_interrupts
      3138 ±  4%     -45.8%       1700 ± 17%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
      2440 ±  6%     -36.7%       1545 ± 16%  interrupts.CPU29.RES:Rescheduling_interrupts
    151439           +29.5%     196054 ±  8%  interrupts.CPU3.LOC:Local_timer_interrupts
      3184 ±  2%     -33.3%       2123 ± 15%  interrupts.CPU3.NMI:Non-maskable_interrupts
      3184 ±  2%     -33.3%       2123 ± 15%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
    150691           +30.1%     196021 ±  8%  interrupts.CPU30.LOC:Local_timer_interrupts
      3162 ±  4%     -47.7%       1653 ± 29%  interrupts.CPU30.NMI:Non-maskable_interrupts
      3162 ±  4%     -47.7%       1653 ± 29%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
      2465 ±  3%     -38.7%       1510 ±  4%  interrupts.CPU30.RES:Rescheduling_interrupts
    150683           +30.0%     195957 ±  8%  interrupts.CPU31.LOC:Local_timer_interrupts
      3194 ±  4%     -36.9%       2014 ± 13%  interrupts.CPU31.NMI:Non-maskable_interrupts
      3194 ±  4%     -36.9%       2014 ± 13%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
      2537           -42.4%       1460 ±  5%  interrupts.CPU31.RES:Rescheduling_interrupts
    150743           +29.9%     195848 ±  9%  interrupts.CPU32.LOC:Local_timer_interrupts
      3194 ±  2%     -36.3%       2035 ±  8%  interrupts.CPU32.NMI:Non-maskable_interrupts
      3194 ±  2%     -36.3%       2035 ±  8%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
      2432 ±  2%     -44.3%       1355 ±  5%  interrupts.CPU32.RES:Rescheduling_interrupts
    150713           +30.0%     195959 ±  8%  interrupts.CPU33.LOC:Local_timer_interrupts
      3143 ±  3%     -32.5%       2121 ±  4%  interrupts.CPU33.NMI:Non-maskable_interrupts
      3143 ±  3%     -32.5%       2121 ±  4%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
      2445 ±  3%     -45.9%       1322 ±  2%  interrupts.CPU33.RES:Rescheduling_interrupts
    150725           +30.0%     195922 ±  8%  interrupts.CPU34.LOC:Local_timer_interrupts
      3168           -35.6%       2040 ± 13%  interrupts.CPU34.NMI:Non-maskable_interrupts
      3168           -35.6%       2040 ± 13%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
      2493           -43.9%       1398 ±  4%  interrupts.CPU34.RES:Rescheduling_interrupts
    150854           +29.9%     195915 ±  8%  interrupts.CPU35.LOC:Local_timer_interrupts
      3155 ±  4%     -30.9%       2179 ± 10%  interrupts.CPU35.NMI:Non-maskable_interrupts
      3155 ±  4%     -30.9%       2179 ± 10%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
      2423 ±  2%     -40.9%       1432        interrupts.CPU35.RES:Rescheduling_interrupts
    151533           +29.5%     196210 ±  8%  interrupts.CPU36.LOC:Local_timer_interrupts
      3132 ±  5%     -45.8%       1698 ± 25%  interrupts.CPU36.NMI:Non-maskable_interrupts
      3132 ±  5%     -45.8%       1698 ± 25%  interrupts.CPU36.PMI:Performance_monitoring_interrupts
      2579           -42.6%       1480 ±  3%  interrupts.CPU36.RES:Rescheduling_interrupts
    151421           +29.6%     196237 ±  8%  interrupts.CPU37.LOC:Local_timer_interrupts
      3107 ±  4%     -44.1%       1738 ± 15%  interrupts.CPU37.NMI:Non-maskable_interrupts
      3107 ±  4%     -44.1%       1738 ± 15%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
      2479 ±  2%     -48.2%       1284 ±  3%  interrupts.CPU37.RES:Rescheduling_interrupts
    151425           +29.6%     196222 ±  9%  interrupts.CPU38.LOC:Local_timer_interrupts
      3145 ±  2%     -45.7%       1708 ± 16%  interrupts.CPU38.NMI:Non-maskable_interrupts
      3145 ±  2%     -45.7%       1708 ± 16%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
      2492 ±  2%     -46.0%       1345 ±  6%  interrupts.CPU38.RES:Rescheduling_interrupts
    151435           +29.5%     196098 ±  8%  interrupts.CPU39.LOC:Local_timer_interrupts
      3150 ±  4%     -33.0%       2112 ± 14%  interrupts.CPU39.NMI:Non-maskable_interrupts
      3150 ±  4%     -33.0%       2112 ± 14%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
      2490 ±  2%     -46.4%       1334 ±  6%  interrupts.CPU39.RES:Rescheduling_interrupts
    151404           +29.5%     196047 ±  8%  interrupts.CPU4.LOC:Local_timer_interrupts
      3182 ±  2%     -35.6%       2048 ± 14%  interrupts.CPU4.NMI:Non-maskable_interrupts
      3182 ±  2%     -35.6%       2048 ± 14%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
    151439           +29.5%     196063 ±  8%  interrupts.CPU40.LOC:Local_timer_interrupts
      3189 ±  3%     -37.4%       1995 ± 13%  interrupts.CPU40.NMI:Non-maskable_interrupts
      3189 ±  3%     -37.4%       1995 ± 13%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
      2543 ±  2%     -40.5%       1513 ± 10%  interrupts.CPU40.RES:Rescheduling_interrupts
    151524           +29.4%     196107 ±  8%  interrupts.CPU41.LOC:Local_timer_interrupts
      3146 ±  4%     -37.9%       1954 ± 18%  interrupts.CPU41.NMI:Non-maskable_interrupts
      3146 ±  4%     -37.9%       1954 ± 18%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
      2474 ±  7%     -47.4%       1302 ±  6%  interrupts.CPU41.RES:Rescheduling_interrupts
    151508           +29.4%     196036 ±  8%  interrupts.CPU42.LOC:Local_timer_interrupts
      3127 ±  3%     -30.3%       2180 ± 19%  interrupts.CPU42.NMI:Non-maskable_interrupts
      3127 ±  3%     -30.3%       2180 ± 19%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
      2445 ±  4%     -47.6%       1281 ±  4%  interrupts.CPU42.RES:Rescheduling_interrupts
    151485           +29.5%     196124 ±  8%  interrupts.CPU43.LOC:Local_timer_interrupts
      3107 ±  3%     -32.3%       2103 ± 14%  interrupts.CPU43.NMI:Non-maskable_interrupts
      3107 ±  3%     -32.3%       2103 ± 14%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
      2509 ±  3%     -42.1%       1453 ±  9%  interrupts.CPU43.RES:Rescheduling_interrupts
    151459           +29.4%     195956 ±  8%  interrupts.CPU44.LOC:Local_timer_interrupts
      3140 ±  3%     -35.9%       2013 ± 16%  interrupts.CPU44.NMI:Non-maskable_interrupts
      3140 ±  3%     -35.9%       2013 ± 16%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
      2561 ±  3%     -49.3%       1297 ±  2%  interrupts.CPU44.RES:Rescheduling_interrupts
    151228           +29.7%     196153 ±  8%  interrupts.CPU45.LOC:Local_timer_interrupts
      3139 ±  3%     -33.3%       2093 ± 20%  interrupts.CPU45.NMI:Non-maskable_interrupts
      3139 ±  3%     -33.3%       2093 ± 20%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
      2550 ±  2%     -45.2%       1396 ±  2%  interrupts.CPU45.RES:Rescheduling_interrupts
    151429           +29.5%     196102 ±  8%  interrupts.CPU46.LOC:Local_timer_interrupts
      3143 ±  2%     -31.6%       2149 ± 15%  interrupts.CPU46.NMI:Non-maskable_interrupts
      3143 ±  2%     -31.6%       2149 ± 15%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
      2786 ±  3%     -44.7%       1540 ±  3%  interrupts.CPU46.RES:Rescheduling_interrupts
    151504           +29.5%     196164 ±  8%  interrupts.CPU47.LOC:Local_timer_interrupts
      3185 ±  2%     -34.2%       2095 ± 17%  interrupts.CPU47.NMI:Non-maskable_interrupts
      3185 ±  2%     -34.2%       2095 ± 17%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
      2636 ±  4%     -37.5%       1647 ±  8%  interrupts.CPU47.RES:Rescheduling_interrupts
    151422           +29.5%     196064 ±  8%  interrupts.CPU48.LOC:Local_timer_interrupts
      3076 ±  7%     -35.0%       1998 ±  7%  interrupts.CPU48.NMI:Non-maskable_interrupts
      3076 ±  7%     -35.0%       1998 ±  7%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
      2528 ±  5%     -46.9%       1342 ±  3%  interrupts.CPU48.RES:Rescheduling_interrupts
    151345           +29.6%     196083 ±  8%  interrupts.CPU49.LOC:Local_timer_interrupts
      3174 ±  2%     -35.8%       2037 ± 19%  interrupts.CPU49.NMI:Non-maskable_interrupts
      3174 ±  2%     -35.8%       2037 ± 19%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
      2736           -45.4%       1495 ±  3%  interrupts.CPU49.RES:Rescheduling_interrupts
    151534           +29.5%     196161 ±  8%  interrupts.CPU5.LOC:Local_timer_interrupts
      3168 ±  3%     -36.1%       2023 ± 16%  interrupts.CPU5.NMI:Non-maskable_interrupts
      3168 ±  3%     -36.1%       2023 ± 16%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
      2945 ± 15%     -48.0%       1532 ±  5%  interrupts.CPU5.RES:Rescheduling_interrupts
    151466           +29.5%     196093 ±  8%  interrupts.CPU50.LOC:Local_timer_interrupts
      2614 ±  2%     -51.0%       1280 ±  6%  interrupts.CPU50.RES:Rescheduling_interrupts
    151438           +29.5%     196100 ±  8%  interrupts.CPU51.LOC:Local_timer_interrupts
      2722           -45.4%       1485        interrupts.CPU51.RES:Rescheduling_interrupts
    151458           +29.5%     196126 ±  8%  interrupts.CPU52.LOC:Local_timer_interrupts
      2441 ±  4%     -45.2%       1337 ±  7%  interrupts.CPU52.RES:Rescheduling_interrupts
    151419           +29.5%     196096 ±  8%  interrupts.CPU53.LOC:Local_timer_interrupts
      2593 ±  2%     -41.9%       1507 ±  6%  interrupts.CPU53.RES:Rescheduling_interrupts
    150741           +30.0%     196001 ±  8%  interrupts.CPU54.LOC:Local_timer_interrupts
      2487 ±  5%     -43.2%       1412 ±  5%  interrupts.CPU54.RES:Rescheduling_interrupts
    150746           +30.0%     196001 ±  8%  interrupts.CPU55.LOC:Local_timer_interrupts
      2558 ±  3%     -37.8%       1590 ± 14%  interrupts.CPU55.RES:Rescheduling_interrupts
    150748           +30.0%     196007 ±  8%  interrupts.CPU56.LOC:Local_timer_interrupts
      2470           -42.4%       1423        interrupts.CPU56.RES:Rescheduling_interrupts
    150723           +30.0%     196003 ±  8%  interrupts.CPU57.LOC:Local_timer_interrupts
      2469 ±  3%     -42.8%       1411        interrupts.CPU57.RES:Rescheduling_interrupts
    150707           +30.1%     195996 ±  8%  interrupts.CPU58.LOC:Local_timer_interrupts
      2475 ±  3%     -43.2%       1405 ±  3%  interrupts.CPU58.RES:Rescheduling_interrupts
    150785           +30.0%     196061 ±  8%  interrupts.CPU59.LOC:Local_timer_interrupts
      2544 ±  4%     -46.3%       1365 ±  5%  interrupts.CPU59.RES:Rescheduling_interrupts
    151396           +29.6%     196180 ±  8%  interrupts.CPU6.LOC:Local_timer_interrupts
      3123 ±  3%     -33.1%       2089 ± 16%  interrupts.CPU6.NMI:Non-maskable_interrupts
      3123 ±  3%     -33.1%       2089 ± 16%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
    150761           +30.0%     196003 ±  8%  interrupts.CPU60.LOC:Local_timer_interrupts
      2466 ±  5%     -46.0%       1331 ±  4%  interrupts.CPU60.RES:Rescheduling_interrupts
    150750           +30.0%     196014 ±  8%  interrupts.CPU61.LOC:Local_timer_interrupts
      2403 ±  2%     -43.8%       1350 ±  7%  interrupts.CPU61.RES:Rescheduling_interrupts
    150705           +30.0%     195988 ±  8%  interrupts.CPU62.LOC:Local_timer_interrupts
      2483 ±  6%     -46.7%       1324 ±  3%  interrupts.CPU62.RES:Rescheduling_interrupts
    150823           +30.0%     196033 ±  8%  interrupts.CPU63.LOC:Local_timer_interrupts
      2427 ±  5%     -43.6%       1369 ±  2%  interrupts.CPU63.RES:Rescheduling_interrupts
    150883           +29.9%     196013 ±  8%  interrupts.CPU64.LOC:Local_timer_interrupts
      2556 ±  2%     -39.4%       1549 ±  8%  interrupts.CPU64.RES:Rescheduling_interrupts
    150691           +30.1%     196019 ±  8%  interrupts.CPU65.LOC:Local_timer_interrupts
      2452 ±  3%     -36.7%       1553 ± 13%  interrupts.CPU65.RES:Rescheduling_interrupts
    150722           +30.0%     195898 ±  8%  interrupts.CPU66.LOC:Local_timer_interrupts
      2540 ±  4%     -43.6%       1433 ±  2%  interrupts.CPU66.RES:Rescheduling_interrupts
    150678           +30.1%     195992 ±  8%  interrupts.CPU67.LOC:Local_timer_interrupts
      2433 ±  2%     -44.7%       1345 ±  4%  interrupts.CPU67.RES:Rescheduling_interrupts
    150743           +30.0%     195912 ±  8%  interrupts.CPU68.LOC:Local_timer_interrupts
      2447 ±  3%     -45.7%       1328 ±  6%  interrupts.CPU68.RES:Rescheduling_interrupts
    150725           +30.0%     195990 ±  8%  interrupts.CPU69.LOC:Local_timer_interrupts
      2568 ±  3%     -45.1%       1409 ±  5%  interrupts.CPU69.RES:Rescheduling_interrupts
    151472           +29.5%     196140 ±  8%  interrupts.CPU7.LOC:Local_timer_interrupts
      2541 ±  4%     -40.1%       1522 ±  8%  interrupts.CPU7.RES:Rescheduling_interrupts
    150728           +30.0%     195933 ±  8%  interrupts.CPU70.LOC:Local_timer_interrupts
      2403 ±  2%     -46.9%       1275 ±  3%  interrupts.CPU70.RES:Rescheduling_interrupts
    150805           +30.0%     196089 ±  8%  interrupts.CPU71.LOC:Local_timer_interrupts
      2507 ±  3%     -40.2%       1498 ±  2%  interrupts.CPU71.RES:Rescheduling_interrupts
    151452           +29.5%     196081 ±  8%  interrupts.CPU8.LOC:Local_timer_interrupts
      3114 ±  3%     -34.4%       2043 ± 18%  interrupts.CPU8.NMI:Non-maskable_interrupts
      3114 ±  3%     -34.4%       2043 ± 18%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
      2494           -42.2%       1442 ±  3%  interrupts.CPU8.RES:Rescheduling_interrupts
    151505           +29.4%     196089 ±  8%  interrupts.CPU9.LOC:Local_timer_interrupts
      3160 ±  4%     -33.7%       2094 ± 19%  interrupts.CPU9.NMI:Non-maskable_interrupts
      3160 ±  4%     -33.7%       2094 ± 19%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
      2376 ±  5%     -44.3%       1324 ±  2%  interrupts.CPU9.RES:Rescheduling_interrupts
  10878450           +29.8%   14115538 ±  8%  interrupts.LOC:Local_timer_interrupts
    213127 ±  3%     -32.8%     143192 ±  9%  interrupts.NMI:Non-maskable_interrupts
    213127 ±  3%     -32.8%     143192 ±  9%  interrupts.PMI:Performance_monitoring_interrupts
    184146           -42.5%     105903        interrupts.RES:Rescheduling_interrupts
     12.45 ±  4%     -12.4        0.00        perf-profile.calltrace.cycles-pp.set_node_addr.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
     12.28 ±  4%     -12.3        0.00        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.set_node_addr.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
     11.96 ±  4%     -12.0        0.00        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.set_node_addr.__write_node_page.f2fs_fsync_node_pages
     46.88 ±  4%     -11.0       35.91 ±  6%  perf-profile.calltrace.cycles-pp.secondary_startup_64
     46.28 ±  4%     -10.9       35.40 ±  6%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
     46.28 ±  4%     -10.9       35.40 ±  6%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
     46.26 ±  4%     -10.9       35.39 ±  6%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     10.37 ±  4%     -10.4        0.00        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.set_node_addr.__write_node_page
     41.22 ±  4%      -9.0       32.26 ±  7%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     42.03 ±  4%      -8.6       33.38 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     42.11 ±  4%      -8.6       33.49 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      7.54 ±  6%      -5.5        2.07 ±  5%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      7.50 ±  6%      -5.5        2.04 ±  5%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file
      7.08 ±  6%      -5.4        1.72 ±  4%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_fsync_node_pages
      8.58 ±  5%      -5.2        3.39 ±  4%  perf-profile.calltrace.cycles-pp.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      2.01 ±  7%      -1.2        0.79 ±  4%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      2.38 ±  5%      -1.1        1.24 ± 20%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data
      2.39 ±  5%      -1.1        1.26 ± 19%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page
      1.76 ±  7%      -1.1        0.67 ±  4%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending.do_idle
      1.76 ±  7%      -1.1        0.67 ±  4%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.do_idle.cpu_startup_entry
      1.76 ±  7%      -1.1        0.67 ±  4%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.do_idle.cpu_startup_entry.start_secondary
      2.62 ±  5%      -1.1        1.54 ± 17%  perf-profile.calltrace.cycles-pp.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page
      1.64 ±  7%      -1.0        0.62 ±  3%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending
      0.86 ±  4%      -0.6        0.27 ±100%  perf-profile.calltrace.cycles-pp.release_pages.__pagevec_release.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.86 ±  3%      -0.6        0.27 ±100%  perf-profile.calltrace.cycles-pp.__pagevec_release.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      1.27 ±  6%      -0.4        0.87 ± 21%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_write_cache_pages
      0.81 ±  5%      -0.4        0.41 ± 57%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      1.54 ±  5%      -0.3        1.22 ± 17%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages
      1.52 ±  6%      -0.3        1.20 ± 18%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages
      1.52 ±  4%      -0.3        1.24 ±  5%  perf-profile.calltrace.cycles-pp.pagevec_lookup_range_tag.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      1.52 ±  4%      -0.3        1.24 ±  5%  perf-profile.calltrace.cycles-pp.find_get_pages_range_tag.pagevec_lookup_range_tag.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.54 ±  2%      +0.1        0.63 ±  4%  perf-profile.calltrace.cycles-pp.swake_up_locked.complete.issue_flush_thread.kthread.ret_from_fork
      0.55 ±  3%      +0.1        0.64 ±  4%  perf-profile.calltrace.cycles-pp.complete.issue_flush_thread.kthread.ret_from_fork
      0.84 ±  6%      +0.2        1.01 ±  8%  perf-profile.calltrace.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      0.69 ±  3%      +0.2        0.88 ±  6%  perf-profile.calltrace.cycles-pp.generic_make_request.submit_bio.__submit_merged_bio.__submit_merged_write_cond.f2fs_write_cache_pages
      0.70 ±  3%      +0.2        0.89 ±  7%  perf-profile.calltrace.cycles-pp.submit_bio.__submit_merged_bio.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages
      0.72 ±  3%      +0.2        0.92 ±  7%  perf-profile.calltrace.cycles-pp.__submit_merged_bio.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages
      0.92 ±  7%      +0.2        1.13 ±  7%  perf-profile.calltrace.cycles-pp.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.97 ±  4%      +0.2        1.19 ±  5%  perf-profile.calltrace.cycles-pp.__generic_file_write_iter.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_write
      0.59 ±  3%      +0.2        0.81 ±  5%  perf-profile.calltrace.cycles-pp.generic_make_request.submit_bio.__submit_merged_bio.__submit_merged_write_cond.f2fs_fsync_node_pages
      0.60 ±  3%      +0.2        0.83 ±  5%  perf-profile.calltrace.cycles-pp.submit_bio.__submit_merged_bio.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.60 ±  3%      +0.2        0.84 ±  4%  perf-profile.calltrace.cycles-pp.__submit_merged_bio.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.90 ±  4%      +0.2        1.14 ±  5%  perf-profile.calltrace.cycles-pp.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter.new_sync_write.vfs_write
      0.69 ± 22%      +0.3        0.95 ± 15%  perf-profile.calltrace.cycles-pp.__percpu_counter_sum.f2fs_space_for_roll_forward.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.72 ± 20%      +0.3        0.99 ± 14%  perf-profile.calltrace.cycles-pp.f2fs_space_for_roll_forward.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
      0.77 ±  3%      +0.3        1.07 ±  4%  perf-profile.calltrace.cycles-pp.issue_flush_thread.kthread.ret_from_fork
      0.27 ±100%      +0.3        0.60 ±  4%  perf-profile.calltrace.cycles-pp.try_to_wake_up.swake_up_locked.complete.issue_flush_thread.kthread
      1.17 ±  3%      +0.3        1.51 ±  5%  perf-profile.calltrace.cycles-pp.brd_make_request.generic_make_request.submit_bio.__submit_merged_bio.__submit_merged_write_cond
      0.26 ±100%      +0.4        0.66 ±  6%  perf-profile.calltrace.cycles-pp.f2fs_write_begin.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter.new_sync_write
      1.07 ±  3%      +0.5        1.55 ±  5%  perf-profile.calltrace.cycles-pp.ret_from_fork
      1.07 ±  3%      +0.5        1.55 ±  5%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      0.00            +0.5        0.53 ±  2%  perf-profile.calltrace.cycles-pp.__sched_text_start.schedule.schedule_timeout.wait_for_completion.f2fs_issue_flush
      0.54 ±  3%      +0.5        1.07 ±  4%  perf-profile.calltrace.cycles-pp.f2fs_issue_flush.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
      0.00            +0.6        0.56 ±  2%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.wait_for_completion.f2fs_issue_flush.f2fs_do_sync_file
      0.00            +0.6        0.57 ±  2%  perf-profile.calltrace.cycles-pp.schedule_timeout.wait_for_completion.f2fs_issue_flush.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +0.6        0.60 ±  5%  perf-profile.calltrace.cycles-pp.try_to_wake_up.wake_up_q.rwsem_wake.f2fs_allocate_data_block.do_write_page
      0.00            +0.6        0.61 ±  3%  perf-profile.calltrace.cycles-pp.wait_for_completion.f2fs_issue_flush.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.00            +0.6        0.61 ±  5%  perf-profile.calltrace.cycles-pp.wake_up_q.rwsem_wake.f2fs_allocate_data_block.do_write_page.f2fs_outplace_write_data
      0.00            +0.7        0.72 ±  5%  perf-profile.calltrace.cycles-pp.rwsem_wake.f2fs_allocate_data_block.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page
      2.98 ±  4%      +1.2        4.21 ±  9%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page
      1.03 ±  4%      +2.5        3.57 ±  6%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_do_write_node_page
      1.03 ±  3%      +2.5        3.58 ±  6%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_do_write_node_page.__write_node_page
      1.25 ±  4%      +2.6        3.85 ±  6%  perf-profile.calltrace.cycles-pp.f2fs_submit_page_write.do_write_page.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages
      2.18 ± 14%      +2.7        4.88 ±  5%  perf-profile.calltrace.cycles-pp.do_write_page.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      2.19 ± 14%      +2.7        4.88 ±  5%  perf-profile.calltrace.cycles-pp.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
     19.21 ±  3%      +7.2       26.41 ±  6%  perf-profile.calltrace.cycles-pp.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
     49.59 ±  4%     +10.0       59.56 ±  3%  perf-profile.calltrace.cycles-pp.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_write
     50.76 ±  4%     +10.6       61.33 ±  3%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     50.87 ±  4%     +10.6       61.44 ±  3%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     50.73 ±  4%     +10.6       61.31 ±  3%  perf-profile.calltrace.cycles-pp.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
     51.32 ±  4%     +10.6       61.90 ±  3%  perf-profile.calltrace.cycles-pp.write
     50.88 ±  4%     +10.6       61.47 ±  3%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     51.03 ±  4%     +10.6       61.64 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     51.04 ±  4%     +10.6       61.66 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      9.50 ±  7%     +15.1       24.55 ±  2%  perf-profile.calltrace.cycles-pp.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.__filemap_fdatawrite_range.file_write_and_wait_range
      9.64 ±  7%     +15.1       24.72 ±  2%  perf-profile.calltrace.cycles-pp.file_write_and_wait_range.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
      9.59 ±  7%     +15.1       24.66 ±  2%  perf-profile.calltrace.cycles-pp.f2fs_write_data_pages.do_writepages.__filemap_fdatawrite_range.file_write_and_wait_range.f2fs_do_sync_file
      9.59 ±  7%     +15.1       24.66 ±  2%  perf-profile.calltrace.cycles-pp.do_writepages.__filemap_fdatawrite_range.file_write_and_wait_range.f2fs_do_sync_file.f2fs_file_write_iter
      9.60 ±  7%     +15.1       24.68 ±  2%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.file_write_and_wait_range.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      6.13 ± 13%     +15.1       21.25 ±  2%  perf-profile.calltrace.cycles-pp.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages
      6.30 ± 13%     +15.2       21.48 ±  2%  perf-profile.calltrace.cycles-pp.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.__filemap_fdatawrite_range
      0.00           +15.6       15.61 ±  4%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.f2fs_allocate_data_block.do_write_page
      0.00           +16.6       16.59 ±  9%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_read_slowpath.__write_node_page.f2fs_fsync_node_pages
      3.47 ±  6%     +16.7       20.16 ±  2%  perf-profile.calltrace.cycles-pp.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages
      3.72 ±  6%     +16.8       20.55 ±  2%  perf-profile.calltrace.cycles-pp.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages
      0.00           +16.9       16.85 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.f2fs_allocate_data_block.do_write_page.f2fs_outplace_write_data
      0.00           +17.2       17.23 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.f2fs_allocate_data_block.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page
      0.80 ±  9%     +17.8       18.55 ±  3%  perf-profile.calltrace.cycles-pp.f2fs_allocate_data_block.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page
      0.00           +19.7       19.73 ±  9%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_read_slowpath.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00           +20.1       20.11 ±  9%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
     12.48 ±  4%     -12.2        0.30 ±  9%  perf-profile.children.cycles-pp.set_node_addr
     46.88 ±  4%     -11.0       35.91 ±  6%  perf-profile.children.cycles-pp.do_idle
     46.88 ±  4%     -11.0       35.91 ±  6%  perf-profile.children.cycles-pp.secondary_startup_64
     46.88 ±  4%     -11.0       35.91 ±  6%  perf-profile.children.cycles-pp.cpu_startup_entry
     46.28 ±  4%     -10.9       35.40 ±  6%  perf-profile.children.cycles-pp.start_secondary
     41.43 ±  4%      -8.8       32.59 ±  7%  perf-profile.children.cycles-pp.intel_idle
     42.65 ±  4%      -8.7       33.97 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter
     42.64 ±  4%      -8.7       33.97 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter_state
     11.40 ±  5%      -5.3        6.08 ±  8%  perf-profile.children.cycles-pp.__submit_merged_write_cond
      3.22 ± 31%      -3.0        0.18 ± 11%  perf-profile.children.cycles-pp.f2fs_need_inode_block_update
      3.23 ± 41%      -3.0        0.20 ±  5%  perf-profile.children.cycles-pp.f2fs_get_node_info
      2.65 ± 52%      -2.5        0.19 ±  6%  perf-profile.children.cycles-pp.f2fs_is_checkpointed_node
      3.38 ±  4%      -2.3        1.05 ±  4%  perf-profile.children.cycles-pp.rwsem_wake
      3.17 ±  5%      -2.2        0.94 ±  4%  perf-profile.children.cycles-pp.wake_up_q
      3.65 ±  6%      -2.1        1.56 ±  5%  perf-profile.children.cycles-pp.ttwu_do_activate
      3.08 ±  4%      -2.1        1.00 ±  8%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      3.65 ±  5%      -2.1        1.56 ±  5%  perf-profile.children.cycles-pp.activate_task
      3.64 ±  5%      -2.1        1.56 ±  5%  perf-profile.children.cycles-pp.enqueue_task_fair
      3.46 ±  6%      -2.0        1.46 ±  5%  perf-profile.children.cycles-pp.enqueue_entity
      3.75 ±  4%      -1.9        1.83 ±  4%  perf-profile.children.cycles-pp.try_to_wake_up
      2.08            -1.9        0.18        perf-profile.children.cycles-pp._raw_spin_lock_irq
      2.86 ±  6%      -1.6        1.21 ±  4%  perf-profile.children.cycles-pp.__account_scheduler_latency
      1.65 ± 32%      -1.5        0.10 ±  8%  perf-profile.children.cycles-pp.f2fs_need_dentry_mark
      2.31 ±  6%      -1.3        1.01 ±  5%  perf-profile.children.cycles-pp.stack_trace_save_tsk
      2.06 ±  6%      -1.2        0.81 ±  4%  perf-profile.children.cycles-pp.sched_ttwu_pending
      2.13 ±  6%      -1.2        0.94 ±  5%  perf-profile.children.cycles-pp.arch_stack_walk
      1.58 ±  6%      -0.9        0.68 ±  6%  perf-profile.children.cycles-pp.unwind_next_frame
      1.83 ±  7%      -0.5        1.34 ±  3%  perf-profile.children.cycles-pp.__sched_text_start
      0.71 ±  8%      -0.4        0.27 ±  8%  perf-profile.children.cycles-pp.schedule_idle
      0.89 ±  3%      -0.4        0.52 ±  9%  perf-profile.children.cycles-pp.release_pages
      0.53 ±  7%      -0.4        0.16 ±  5%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.90 ±  3%      -0.4        0.53 ±  9%  perf-profile.children.cycles-pp.__pagevec_release
      0.56 ±  7%      -0.3        0.27 ±  6%  perf-profile.children.cycles-pp.dequeue_task_fair
      1.56 ±  3%      -0.3        1.28 ±  5%  perf-profile.children.cycles-pp.pagevec_lookup_range_tag
      0.82 ±  5%      -0.3        0.53 ±  7%  perf-profile.children.cycles-pp.menu_select
      1.56 ±  4%      -0.3        1.27 ±  5%  perf-profile.children.cycles-pp.find_get_pages_range_tag
      0.37 ±  3%      -0.3        0.09 ± 11%  perf-profile.children.cycles-pp.rwsem_mark_wake
      0.51 ±  6%      -0.3        0.22 ±  4%  perf-profile.children.cycles-pp.dequeue_entity
      1.85 ±  6%      -0.3        1.57 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.68 ± 40%      -0.3        0.41 ±  6%  perf-profile.children.cycles-pp.__mutex_lock
      0.24 ±  8%      -0.2        0.04 ± 58%  perf-profile.children.cycles-pp.update_cfs_rq_h_load
      0.43 ±  6%      -0.2        0.23        perf-profile.children.cycles-pp.update_load_avg
      0.33 ±  6%      -0.2        0.13 ±  7%  perf-profile.children.cycles-pp.__lookup_nat_cache
      0.36 ±  9%      -0.2        0.17 ±  6%  perf-profile.children.cycles-pp.orc_find
      0.27 ±  4%      -0.2        0.11 ±  6%  perf-profile.children.cycles-pp.unwind_get_return_address
      0.30 ±  9%      -0.1        0.15 ±  7%  perf-profile.children.cycles-pp.__orc_find
      0.25 ±  4%      -0.1        0.10 ±  7%  perf-profile.children.cycles-pp.__kernel_text_address
      0.27 ±  4%      -0.1        0.14 ±  3%  perf-profile.children.cycles-pp.update_curr
      0.22 ±  6%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.kernel_text_address
      0.21 ±  5%      -0.1        0.09 ± 17%  perf-profile.children.cycles-pp.f2fs_write_inode
      0.40 ±  6%      -0.1        0.28 ±  5%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.19 ±  6%      -0.1        0.08 ± 15%  perf-profile.children.cycles-pp.f2fs_update_inode_page
      0.23 ±  3%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.22 ±  3%      -0.1        0.11 ±  7%  perf-profile.children.cycles-pp.stack_trace_consume_entry_nosched
      0.22 ±  8%      -0.1        0.12 ±  7%  perf-profile.children.cycles-pp.set_next_entity
      0.15 ±  5%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.21 ± 10%      -0.1        0.11 ± 17%  perf-profile.children.cycles-pp.__unwind_start
      0.16 ±  7%      -0.1        0.07 ± 11%  perf-profile.children.cycles-pp.__module_address
      0.12 ±  6%      -0.1        0.04 ± 57%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.14 ±  3%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.update_cfs_group
      0.31 ±  4%      -0.1        0.23 ±  5%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.15 ±  2%      -0.1        0.07 ± 11%  perf-profile.children.cycles-pp.__switch_to
      0.11 ±  7%      -0.1        0.04 ± 57%  perf-profile.children.cycles-pp.__module_text_address
      0.12 ±  8%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.is_module_text_address
      0.23 ±  4%      -0.1        0.17 ±  6%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.14 ±  6%      -0.1        0.07 ± 14%  perf-profile.children.cycles-pp.__list_add_valid
      0.27 ±  9%      -0.1        0.20 ±  5%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.13 ±  8%      -0.1        0.07 ±  5%  perf-profile.children.cycles-pp.__switch_to_asm
      0.22 ± 10%      -0.1        0.16 ± 11%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      0.10 ±  4%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.wake_q_add
      0.07 ± 11%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.13 ±  9%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.09 ±  4%      -0.0        0.04 ± 58%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.18 ±  2%      -0.0        0.14 ±  6%  perf-profile.children.cycles-pp.osq_unlock
      0.18 ±  8%      -0.0        0.14 ±  6%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.10 ±  4%      -0.0        0.06        perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.15 ±  5%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp.__next_timer_interrupt
      0.11 ±  9%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.native_sched_clock
      0.11 ±  7%      -0.0        0.08 ± 11%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.13 ±  9%      -0.0        0.10 ±  8%  perf-profile.children.cycles-pp.native_write_msr
      0.12 ± 13%      -0.0        0.09 ± 10%  perf-profile.children.cycles-pp.sched_clock
      0.08 ±  5%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.check_preempt_curr
      0.08 ± 10%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.select_idle_sibling
      0.12 ±  8%      -0.0        0.10 ±  7%  perf-profile.children.cycles-pp.update_rq_clock
      0.09 ±  4%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.clear_page_dirty_for_io
      0.07 ± 10%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.cpumask_next
      0.10 ±  5%      +0.0        0.12 ±  7%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.04 ± 57%      +0.0        0.06        perf-profile.children.cycles-pp.lapic_next_deadline
      0.09 ±  9%      +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.f2fs_del_fsync_node_entry
      0.07 ± 10%      +0.0        0.10 ± 11%  perf-profile.children.cycles-pp.rebalance_domains
      0.09 ±  4%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__is_cp_guaranteed
      0.07            +0.0        0.10 ± 13%  perf-profile.children.cycles-pp.f2fs_wait_on_node_pages_writeback
      0.05 ±  8%      +0.0        0.08 ±  8%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.20 ±  4%      +0.0        0.23 ±  8%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.06 ±  9%      +0.0        0.09 ± 12%  perf-profile.children.cycles-pp.wait_for_completion_io
      0.04 ± 57%      +0.0        0.07 ± 10%  perf-profile.children.cycles-pp.f2fs_inode_chksum_verify
      0.04 ± 58%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.f2fs_update_dirty_page
      0.11 ±  7%      +0.0        0.15 ± 10%  perf-profile.children.cycles-pp.clear_page_erms
      0.22 ±  6%      +0.0        0.25 ±  4%  perf-profile.children.cycles-pp.down_write
      0.04 ± 57%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.f2fs_get_block
      0.15 ±  7%      +0.0        0.19 ± 10%  perf-profile.children.cycles-pp.f2fs_balance_fs
      0.04 ± 58%      +0.0        0.08 ±  8%  perf-profile.children.cycles-pp.mempool_alloc
      0.20 ±  7%      +0.0        0.24 ±  5%  perf-profile.children.cycles-pp.f2fs_set_data_page_dirty
      0.07 ±  7%      +0.0        0.11 ± 10%  perf-profile.children.cycles-pp.bio_alloc_bioset
      0.12 ±  9%      +0.0        0.16 ±  8%  perf-profile.children.cycles-pp.brd_lookup_page
      0.12 ±  7%      +0.0        0.16 ± 11%  perf-profile.children.cycles-pp.read_node_page
      0.06 ±  6%      +0.0        0.11 ± 15%  perf-profile.children.cycles-pp.__bio_alloc
      0.15 ±  2%      +0.0        0.20 ±  4%  perf-profile.children.cycles-pp.scheduler_tick
      0.03 ±100%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.sb_clear_inode_writeback
      0.26 ±  5%      +0.0        0.31 ±  6%  perf-profile.children.cycles-pp.irq_exit
      0.07 ±  7%      +0.1        0.12 ± 15%  perf-profile.children.cycles-pp._cond_resched
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.f2fs_reserve_new_blocks
      0.03 ±100%      +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.f2fs_lookup_extent_cache
      0.25 ±  4%      +0.1        0.30 ±  8%  perf-profile.children.cycles-pp.f2fs_is_valid_blkaddr
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.f2fs_reserve_block
      0.22 ±  5%      +0.1        0.28 ± 10%  perf-profile.children.cycles-pp.update_sit_entry
      0.29 ±  5%      +0.1        0.35 ±  6%  perf-profile.children.cycles-pp.f2fs_write_end
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.update_blocked_averages
      0.11 ±  7%      +0.1        0.18 ± 14%  perf-profile.children.cycles-pp.generic_make_request_checks
      0.33 ±  4%      +0.1        0.40 ±  2%  perf-profile.children.cycles-pp.__set_page_dirty_nobuffers
      0.26 ±  6%      +0.1        0.33 ±  4%  perf-profile.children.cycles-pp.__test_set_page_writeback
      0.05            +0.1        0.12 ± 10%  perf-profile.children.cycles-pp.__wake_up_common
      0.50 ±  6%      +0.1        0.57 ±  4%  perf-profile.children.cycles-pp.brd_insert_page
      0.00            +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.preempt_schedule_common
      0.26 ±  7%      +0.1        0.34 ±  7%  perf-profile.children.cycles-pp.update_process_times
      0.27 ±  3%      +0.1        0.35 ±  5%  perf-profile.children.cycles-pp.f2fs_set_node_page_dirty
      0.03 ±100%      +0.1        0.11 ±  7%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.27 ±  5%      +0.1        0.35 ±  7%  perf-profile.children.cycles-pp.tick_sched_handle
      0.14 ±  9%      +0.1        0.22 ±  4%  perf-profile.children.cycles-pp.up_write
      0.32 ±  8%      +0.1        0.41 ±  7%  perf-profile.children.cycles-pp.tick_sched_timer
      0.00            +0.1        0.09 ± 11%  perf-profile.children.cycles-pp.idle_cpu
      0.18 ±  8%      +0.1        0.27 ±  6%  perf-profile.children.cycles-pp.test_clear_page_writeback
      0.19 ± 10%      +0.1        0.28 ±  4%  perf-profile.children.cycles-pp.end_page_writeback
      0.08 ±  5%      +0.1        0.18 ±  7%  perf-profile.children.cycles-pp.__wake_up_common_lock
      0.43 ±  5%      +0.1        0.54 ±  5%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.24 ±  3%      +0.1        0.35 ±  5%  perf-profile.children.cycles-pp.f2fs_update_data_blkaddr
      0.12 ±  4%      +0.1        0.24 ±  5%  perf-profile.children.cycles-pp.__queue_work
      0.24 ±  6%      +0.1        0.36 ±  8%  perf-profile.children.cycles-pp.process_one_work
      0.24 ±  3%      +0.1        0.35 ±  5%  perf-profile.children.cycles-pp.f2fs_set_data_blkaddr
      0.14 ±  3%      +0.1        0.26 ±  5%  perf-profile.children.cycles-pp.queue_work_on
      0.15 ±  5%      +0.1        0.27 ±  6%  perf-profile.children.cycles-pp.md_flush_request
      0.13 ±  9%      +0.1        0.26 ±  6%  perf-profile.children.cycles-pp.submit_flushes
      0.92 ±  3%      +0.2        1.08 ±  6%  perf-profile.children.cycles-pp.brd_do_bvec
      0.22            +0.2        0.38 ±  9%  perf-profile.children.cycles-pp.raid0_make_request
      0.50 ±  3%      +0.2        0.67 ±  7%  perf-profile.children.cycles-pp.f2fs_write_begin
      0.29 ±  6%      +0.2        0.46 ±  8%  perf-profile.children.cycles-pp.worker_thread
      0.41 ±  5%      +0.2        0.60 ±  4%  perf-profile.children.cycles-pp.f2fs_write_end_io
      0.24            +0.2        0.43 ±  9%  perf-profile.children.cycles-pp.md_handle_request
      0.25 ±  7%      +0.2        0.44 ±  7%  perf-profile.children.cycles-pp.submit_bio_wait
      1.13 ±  3%      +0.2        1.34 ±  6%  perf-profile.children.cycles-pp.smp_apic_timer_interrupt
      0.98 ±  4%      +0.2        1.19 ±  5%  perf-profile.children.cycles-pp.__generic_file_write_iter
      0.27 ±  5%      +0.2        0.47 ±  7%  perf-profile.children.cycles-pp.__submit_flush_wait
      0.30 ±  2%      +0.2        0.53 ±  6%  perf-profile.children.cycles-pp.md_make_request
      0.91 ±  4%      +0.2        1.14 ±  5%  perf-profile.children.cycles-pp.generic_perform_write
      0.43 ± 10%      +0.2        0.66 ±  2%  perf-profile.children.cycles-pp.pick_next_task_fair
      1.24 ±  3%      +0.3        1.49 ±  6%  perf-profile.children.cycles-pp.apic_timer_interrupt
      0.69 ± 21%      +0.3        0.95 ± 15%  perf-profile.children.cycles-pp.__percpu_counter_sum
      1.83 ±  4%      +0.3        2.09 ±  5%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.72 ± 20%      +0.3        0.99 ± 14%  perf-profile.children.cycles-pp.f2fs_space_for_roll_forward
      0.77 ±  3%      +0.3        1.08 ±  4%  perf-profile.children.cycles-pp.issue_flush_thread
      0.24            +0.3        0.57 ±  2%  perf-profile.children.cycles-pp.schedule_timeout
      0.00            +0.3        0.35 ± 44%  perf-profile.children.cycles-pp.f2fs_convert_inline_page
      0.08 ±  6%      +0.3        0.42 ±  5%  perf-profile.children.cycles-pp.find_busiest_group
      0.07 ± 10%      +0.3        0.42 ±  5%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.26 ±  3%      +0.4        0.61 ±  3%  perf-profile.children.cycles-pp.wait_for_completion
      0.00            +0.4        0.35 ± 43%  perf-profile.children.cycles-pp.f2fs_convert_inline_inode
      1.37 ±  3%      +0.4        1.73 ±  5%  perf-profile.children.cycles-pp.brd_make_request
      0.00            +0.4        0.37 ± 41%  perf-profile.children.cycles-pp.f2fs_preallocate_blocks
      0.10 ± 10%      +0.4        0.47 ±  6%  perf-profile.children.cycles-pp.newidle_balance
      0.09 ±  9%      +0.4        0.48 ±  5%  perf-profile.children.cycles-pp.load_balance
      1.33 ±  3%      +0.4        1.77 ±  5%  perf-profile.children.cycles-pp.__submit_merged_bio
      1.07 ±  3%      +0.5        1.55 ±  5%  perf-profile.children.cycles-pp.ret_from_fork
      1.07 ±  3%      +0.5        1.55 ±  5%  perf-profile.children.cycles-pp.kthread
      0.54 ±  3%      +0.5        1.07 ±  4%  perf-profile.children.cycles-pp.f2fs_issue_flush
      1.78 ±  3%      +0.6        2.43 ±  6%  perf-profile.children.cycles-pp.generic_make_request
      1.78 ±  3%      +0.6        2.43 ±  5%  perf-profile.children.cycles-pp.submit_bio
      3.87 ±  4%      +1.5        5.40 ±  8%  perf-profile.children.cycles-pp.f2fs_submit_page_write
      2.19 ± 14%      +2.7        4.88 ±  5%  perf-profile.children.cycles-pp.f2fs_do_write_node_page
     16.46 ±  4%      +6.7       23.12 ±  2%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     19.21 ±  3%      +7.2       26.41 ±  6%  perf-profile.children.cycles-pp.__write_node_page
     49.59 ±  4%     +10.0       59.56 ±  3%  perf-profile.children.cycles-pp.f2fs_do_sync_file
     51.35 ±  4%     +10.6       61.92 ±  3%  perf-profile.children.cycles-pp.write
     50.76 ±  4%     +10.6       61.34 ±  3%  perf-profile.children.cycles-pp.new_sync_write
     50.73 ±  4%     +10.6       61.31 ±  3%  perf-profile.children.cycles-pp.f2fs_file_write_iter
     50.89 ±  4%     +10.6       61.47 ±  3%  perf-profile.children.cycles-pp.ksys_write
     50.87 ±  4%     +10.6       61.45 ±  3%  perf-profile.children.cycles-pp.vfs_write
     51.39 ±  4%     +10.6       62.01 ±  3%  perf-profile.children.cycles-pp.do_syscall_64
     51.40 ±  4%     +10.6       62.02 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     28.15 ± 11%     +12.0       40.12 ±  4%  perf-profile.children.cycles-pp.osq_lock
     31.07 ± 10%     +14.9       45.97 ±  5%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      9.50 ±  7%     +15.0       24.55 ±  2%  perf-profile.children.cycles-pp.f2fs_write_cache_pages
      9.64 ±  7%     +15.1       24.72 ±  2%  perf-profile.children.cycles-pp.file_write_and_wait_range
      9.59 ±  7%     +15.1       24.66 ±  2%  perf-profile.children.cycles-pp.do_writepages
      9.59 ±  7%     +15.1       24.66 ±  2%  perf-profile.children.cycles-pp.f2fs_write_data_pages
      9.60 ±  7%     +15.1       24.68 ±  2%  perf-profile.children.cycles-pp.__filemap_fdatawrite_range
      6.13 ± 13%     +15.1       21.25 ±  2%  perf-profile.children.cycles-pp.f2fs_do_write_data_page
      6.30 ± 13%     +15.2       21.48 ±  2%  perf-profile.children.cycles-pp.f2fs_write_single_data_page
      3.72 ±  6%     +17.2       20.88 ±  3%  perf-profile.children.cycles-pp.f2fs_outplace_write_data
      1.69 ± 17%     +18.2       19.84 ±  3%  perf-profile.children.cycles-pp.f2fs_allocate_data_block
      5.65 ±  7%     +19.7       25.38 ±  2%  perf-profile.children.cycles-pp.do_write_page
     41.43 ±  4%      -8.8       32.59 ±  7%  perf-profile.self.cycles-pp.intel_idle
      3.08 ±  4%      -2.1        1.00 ±  8%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.08 ±  6%      -0.7        0.43 ±  8%  perf-profile.self.cycles-pp.unwind_next_frame
      0.55            -0.4        0.17 ±  6%  perf-profile.self.cycles-pp.rwsem_down_read_slowpath
      0.85 ±  3%      -0.4        0.48 ±  8%  perf-profile.self.cycles-pp.release_pages
      1.37 ±  3%      -0.3        1.09 ±  6%  perf-profile.self.cycles-pp.find_get_pages_range_tag
      0.31 ±  6%      -0.2        0.10 ±  4%  perf-profile.self.cycles-pp.__account_scheduler_latency
      0.24 ±  8%      -0.2        0.04 ± 58%  perf-profile.self.cycles-pp.update_cfs_rq_h_load
      0.29 ±  5%      -0.1        0.15 ±  5%  perf-profile.self.cycles-pp.__sched_text_start
      0.30 ±  9%      -0.1        0.15 ±  7%  perf-profile.self.cycles-pp.__orc_find
      0.35 ±  7%      -0.1        0.21 ± 10%  perf-profile.self.cycles-pp.menu_select
      0.19 ±  7%      -0.1        0.05 ±  8%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.23 ±  3%      -0.1        0.12 ±  3%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.21 ±  7%      -0.1        0.10 ±  8%  perf-profile.self.cycles-pp.do_idle
      0.22 ±  5%      -0.1        0.11 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.19 ±  8%      -0.1        0.09 ±  4%  perf-profile.self.cycles-pp.update_load_avg
      0.43 ±  4%      -0.1        0.34 ±  6%  perf-profile.self.cycles-pp.try_to_wake_up
      0.16 ±  7%      -0.1        0.07 ± 11%  perf-profile.self.cycles-pp.__module_address
      0.15 ±  8%      -0.1        0.07 ±  7%  perf-profile.self.cycles-pp.stack_trace_save_tsk
      0.12 ±  6%      -0.1        0.04 ± 57%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.18 ±  8%      -0.1        0.10 ± 11%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.15 ±  7%      -0.1        0.07 ±  7%  perf-profile.self.cycles-pp.set_next_entity
      0.16 ±  9%      -0.1        0.08        perf-profile.self.cycles-pp.update_curr
      0.14 ±  3%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.update_cfs_group
      0.10 ±  4%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.enqueue_entity
      0.16 ±  2%      -0.1        0.08 ±  8%  perf-profile.self.cycles-pp.stack_trace_consume_entry_nosched
      0.14 ±  3%      -0.1        0.07 ± 14%  perf-profile.self.cycles-pp.__list_add_valid
      0.26 ± 11%      -0.1        0.20 ±  5%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.13 ±  6%      -0.1        0.07 ± 17%  perf-profile.self.cycles-pp.__switch_to
      0.13 ±  5%      -0.1        0.07 ±  5%  perf-profile.self.cycles-pp.__switch_to_asm
      0.10 ± 10%      -0.1        0.05        perf-profile.self.cycles-pp.sched_ttwu_pending
      0.21 ±  9%      -0.1        0.16 ± 11%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      0.10 ±  4%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.wake_q_add
      0.13 ±  9%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.09 ±  4%      -0.0        0.04 ± 58%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.18 ±  2%      -0.0        0.14 ±  6%  perf-profile.self.cycles-pp.osq_unlock
      0.13 ±  9%      -0.0        0.10 ±  8%  perf-profile.self.cycles-pp.native_write_msr
      0.11 ± 12%      -0.0        0.08 ± 11%  perf-profile.self.cycles-pp.native_sched_clock
      0.14 ±  8%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.27 ±  4%      -0.0        0.24 ±  2%  perf-profile.self.cycles-pp.up_read
      0.07            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__set_page_dirty_nobuffers
      0.10 ±  5%      +0.0        0.12 ±  7%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.08 ±  6%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.f2fs_write_data_pages
      0.09 ±  7%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.__write_node_page
      0.13 ±  6%      +0.0        0.15 ±  7%  perf-profile.self.cycles-pp.f2fs_do_sync_file
      0.09 ±  7%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.f2fs_submit_page_write
      0.09 ±  4%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.__is_cp_guaranteed
      0.08 ±  6%      +0.0        0.10 ±  8%  perf-profile.self.cycles-pp.f2fs_set_node_page_dirty
      0.11 ±  7%      +0.0        0.14 ±  5%  perf-profile.self.cycles-pp.clear_page_erms
      0.05            +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.f2fs_write_single_data_page
      0.11 ± 12%      +0.0        0.14 ±  6%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.19 ±  5%      +0.0        0.22 ±  3%  perf-profile.self.cycles-pp.down_write
      0.07 ± 10%      +0.0        0.10 ± 10%  perf-profile.self.cycles-pp.f2fs_write_begin
      0.04 ± 57%      +0.0        0.07        perf-profile.self.cycles-pp.f2fs_do_write_data_page
      0.04 ± 58%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.__submit_merged_write_cond
      0.31 ±  2%      +0.0        0.34 ±  8%  perf-profile.self.cycles-pp.brd_do_bvec
      0.07 ±  7%      +0.0        0.10 ±  7%  perf-profile.self.cycles-pp.f2fs_issue_flush
      0.15 ±  7%      +0.0        0.18 ±  8%  perf-profile.self.cycles-pp.f2fs_balance_fs
      0.07 ± 11%      +0.0        0.12 ±  7%  perf-profile.self.cycles-pp.f2fs_write_end_io
      0.15 ±  8%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.do_syscall_64
      0.01 ±173%      +0.0        0.06 ± 16%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.09 ±  9%      +0.1        0.14 ±  5%  perf-profile.self.cycles-pp.f2fs_file_write_iter
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.issue_flush_thread
      0.24 ±  4%      +0.1        0.30 ±  7%  perf-profile.self.cycles-pp.f2fs_is_valid_blkaddr
      0.00            +0.1        0.05 ±  9%  perf-profile.self.cycles-pp.md_handle_request
      0.03 ±100%      +0.1        0.08 ± 12%  perf-profile.self.cycles-pp.md_make_request
      0.06 ±  9%      +0.1        0.11 ±  7%  perf-profile.self.cycles-pp.submit_flushes
      0.00            +0.1        0.06 ± 14%  perf-profile.self.cycles-pp.f2fs_lookup_extent_cache
      0.21 ±  4%      +0.1        0.27 ± 10%  perf-profile.self.cycles-pp.update_sit_entry
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.do_write_page
      0.14 ±  3%      +0.1        0.21 ±  5%  perf-profile.self.cycles-pp.f2fs_allocate_data_block
      0.74 ±  2%      +0.1        0.83 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock
      0.13 ±  8%      +0.1        0.22 ±  5%  perf-profile.self.cycles-pp.up_write
      0.00            +0.1        0.09 ± 11%  perf-profile.self.cycles-pp.idle_cpu
      0.24 ± 22%      +0.1        0.37 ± 15%  perf-profile.self.cycles-pp.__percpu_counter_sum
      1.78 ±  4%      +0.2        1.97 ±  5%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.04 ± 58%      +0.3        0.30 ±  4%  perf-profile.self.cycles-pp.update_sd_lb_stats
      1.35 ±  3%      +2.5        3.90 ± 11%  perf-profile.self.cycles-pp.rwsem_optimistic_spin
     28.00 ± 11%     +11.9       39.92 ±  4%  perf-profile.self.cycles-pp.osq_lock



***************************************************************************************************
lkp-ivb-2ep1: 48 threads Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz with 64G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/md/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/4BRD_12G/f2fs/x86_64-rhel-7.6/100/RAID0/debian-x86_64-20191114.cgz/lkp-ivb-2ep1/sync_disk_rw/aim7/0x42e

commit: 
  dc35d73a42 ("f2fs: compress: don't compress any datas after cp stop")
  ca7f76e680 ("f2fs: fix wrong discard space")

dc35d73a42291b2a ca7f76e680745d3b8a386638045 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          2:4          -50%            :4     dmesg.WARNING:at#for_ip_interrupt_entry/0x
         %stddev     %change         %stddev
             \          |                \  
      7998           +41.5%      11320        aim7.jobs-per-min
     75.06           -29.3%      53.04        aim7.time.elapsed_time
     75.06           -29.3%      53.04        aim7.time.elapsed_time.max
  85958910            -6.6%   80295428        aim7.time.file_system_outputs
    602222            +1.6%     611895        aim7.time.involuntary_context_switches
     10270 ±  3%     -14.9%       8743 ±  2%  aim7.time.minor_page_faults
    890.41           -35.4%     575.08        aim7.time.system_time
     10.52           -18.2%       8.61        aim7.time.user_time
  20399073           -59.1%    8346573        aim7.time.voluntary_context_switches
      0.58 ±  3%      +0.2        0.75        mpstat.cpu.all.usr%
     23.66            +2.5%      24.25        boot-time.boot
    950.90            +2.6%     975.47        boot-time.idle
   5501204            -9.7%    4966671        numa-numastat.node0.local_node
   5503559            -9.7%    4970571        numa-numastat.node0.numa_hit
    548367           +30.7%     716543        vmstat.io.bo
    586187           -25.6%     435987        vmstat.system.cs
     23.21            -3.6%      22.38        iostat.cpu.system
     90248           +77.3%     159991        iostat.md0.w/s
    577606           +25.9%     727269        iostat.md0.wkB/s
     71559 ±  3%     -21.0%      56538        meminfo.AnonHugePages
    116092            -9.0%     105645        meminfo.Inactive
     99685           -10.8%      88920        meminfo.Inactive(file)
  17955986           -12.3%   15739104        meminfo.Memused
     32249 ±  2%     -11.4%      28568        meminfo.Shmem
    510766           +29.6%     661837        meminfo.max_used_kB
     48979 ±  4%     -13.6%      42299 ±  3%  numa-meminfo.node0.Inactive(file)
     52129 ±  2%     -14.3%      44685 ±  2%  numa-meminfo.node0.KReclaimable
   8981460           -13.4%    7780127        numa-meminfo.node0.MemUsed
     52129 ±  2%     -14.3%      44685 ±  2%  numa-meminfo.node0.SReclaimable
    106708 ±  5%      -7.5%      98756 ±  2%  numa-meminfo.node0.Slab
   8924236           -11.7%    7884151 ±  2%  numa-meminfo.node1.MemUsed
 1.134e+09 ±  6%     -55.8%  5.013e+08        cpuidle.C1.time
  16571069 ±  6%     -51.2%    8080515        cpuidle.C1.usage
 9.877e+08 ± 13%     -31.4%  6.775e+08 ±  5%  cpuidle.C1E.time
   8259195 ± 12%     -59.7%    3332136 ± 10%  cpuidle.C1E.usage
 5.364e+08 ± 19%     +38.8%  7.447e+08 ±  5%  cpuidle.C6.time
   1073451 ± 41%     +54.6%    1659694 ± 24%  cpuidle.C6.usage
    415787           -54.4%     189765        cpuidle.POLL.time
     67117 ±  2%     -54.8%      30351        cpuidle.POLL.usage
      1536 ± 13%     +29.2%       1984 ± 10%  slabinfo.fsnotify_mark_connector.active_objs
      1536 ± 13%     +29.2%       1984 ± 10%  slabinfo.fsnotify_mark_connector.num_objs
    464.00 ±  5%     +37.9%     640.00 ±  7%  slabinfo.kmalloc-rcl-128.active_objs
    464.00 ±  5%     +37.9%     640.00 ±  7%  slabinfo.kmalloc-rcl-128.num_objs
      1092 ±  4%     +14.4%       1249 ±  6%  slabinfo.kmalloc-rcl-96.active_objs
      1092 ±  4%     +14.4%       1249 ±  6%  slabinfo.kmalloc-rcl-96.num_objs
     78622           -11.2%      69811        slabinfo.radix_tree_node.active_objs
      1403           -11.2%       1246        slabinfo.radix_tree_node.active_slabs
     78622           -11.2%      69811        slabinfo.radix_tree_node.num_objs
      1403           -11.2%       1246        slabinfo.radix_tree_node.num_slabs
   2285879           -14.4%    1955601        numa-vmstat.node0.nr_dirtied
     12271 ±  5%     -13.1%      10660 ±  3%  numa-vmstat.node0.nr_inactive_file
     13032 ±  2%     -14.4%      11156        numa-vmstat.node0.nr_slab_reclaimable
   2272917           -14.5%    1943710        numa-vmstat.node0.nr_written
     12271 ±  5%     -13.1%      10661 ±  3%  numa-vmstat.node0.nr_zone_inactive_file
   2758058           -12.5%    2413771        numa-vmstat.node0.numa_hit
   2601941           -13.3%    2256178 ±  2%  numa-vmstat.node0.numa_local
   2300478           -13.1%    1999423        numa-vmstat.node1.nr_dirtied
   2287494           -13.1%    1987272        numa-vmstat.node1.nr_written
   2793838           -11.4%    2475375        numa-vmstat.node1.numa_hit
   2765728           -11.5%    2448996        numa-vmstat.node1.numa_local
     72.97 ± 40%     +45.1%     105.91 ± 33%  sched_debug.cfs_rq:/.load_avg.avg
    780.25 ± 21%     +88.7%       1472 ± 30%  sched_debug.cfs_rq:/.load_avg.max
    182.33 ± 35%     +62.1%     295.54 ± 19%  sched_debug.cfs_rq:/.load_avg.stddev
     91231 ± 54%     -95.6%       4001 ± 18%  sched_debug.cfs_rq:/.min_vruntime.min
    992.05 ± 21%     +43.8%       1426 ±  6%  sched_debug.cfs_rq:/.runnable_avg.avg
      3045 ± 15%     +46.2%       4452 ± 13%  sched_debug.cfs_rq:/.runnable_avg.max
    702.16 ± 20%     +50.0%       1053 ± 13%  sched_debug.cfs_rq:/.runnable_avg.stddev
    425.23 ±  8%     +15.8%     492.35 ±  3%  sched_debug.cfs_rq:/.util_avg.avg
      1031           +34.0%       1382 ± 18%  sched_debug.cfs_rq:/.util_avg.max
    262.75 ±  9%     +34.0%     351.99 ±  6%  sched_debug.cfs_rq:/.util_avg.stddev
     53.53 ± 15%     -22.0%      41.78 ±  7%  sched_debug.cfs_rq:/.util_est_enqueued.avg
     17200 ± 44%     -89.1%       1868 ± 17%  sched_debug.cpu.avg_idle.min
      0.00 ± 15%     +82.9%       0.00 ± 48%  sched_debug.cpu.next_balance.stddev
     83.50 ± 23%     -42.5%      48.00 ± 21%  sched_debug.cpu.nr_uninterruptible.max
     21.46 ± 19%     -35.0%      13.95 ± 13%  sched_debug.cpu.nr_uninterruptible.stddev
     67893            -1.7%      66731        proc-vmstat.nr_active_anon
  10691167            -7.2%    9925885        proc-vmstat.nr_dirtied
     12978            -7.5%      12003 ±  3%  proc-vmstat.nr_dirty
   1190397            +4.7%    1246050        proc-vmstat.nr_dirty_background_threshold
   2383706            +4.7%    2495147        proc-vmstat.nr_dirty_threshold
    332216            -1.1%     328636        proc-vmstat.nr_file_pages
  11982444            +4.7%   12542388        proc-vmstat.nr_free_pages
      4102            +2.2%       4191        proc-vmstat.nr_inactive_anon
     24952           -10.4%      22354        proc-vmstat.nr_inactive_file
      7052            +3.0%       7263        proc-vmstat.nr_mapped
      2025 ±  2%      -3.0%       1964        proc-vmstat.nr_page_table_pages
      8055 ±  2%     -11.4%       7139        proc-vmstat.nr_shmem
     25569            -5.7%      24121        proc-vmstat.nr_slab_reclaimable
     60.75 ± 23%    +100.0%     121.50 ± 33%  proc-vmstat.nr_writeback
  10635151            -7.2%    9871766        proc-vmstat.nr_written
     67893            -1.7%      66731        proc-vmstat.nr_zone_active_anon
      4102            +2.2%       4191        proc-vmstat.nr_zone_inactive_anon
     24952           -10.4%      22354        proc-vmstat.nr_zone_inactive_file
  10793514            -7.3%   10004830        proc-vmstat.numa_hit
  10777815            -7.3%    9989143        proc-vmstat.numa_local
      3895 ± 74%     -68.1%       1244 ± 32%  proc-vmstat.numa_pages_migrated
      7023 ±  2%     -30.8%       4861        proc-vmstat.pgactivate
  10928413            -7.5%   10104541        proc-vmstat.pgalloc_normal
      9654           -10.4%       8651        proc-vmstat.pgdeactivate
    237080 ±  2%     -25.6%     176491 ±  3%  proc-vmstat.pgfault
   1640892            -3.9%    1576599        proc-vmstat.pgfree
      3895 ± 74%     -68.1%       1244 ± 32%  proc-vmstat.pgmigrate_success
  42552033            -7.2%   39495741        proc-vmstat.pgpgout
     19298           -10.8%      17219        proc-vmstat.pgrotated
     13.90 ±  4%      +7.8%      14.99 ±  3%  perf-stat.i.MPKI
 4.317e+09            -6.7%  4.029e+09        perf-stat.i.branch-instructions
      1.95 ±  3%      +0.6        2.52 ±  2%  perf-stat.i.branch-miss-rate%
  45918409 ±  2%      +7.0%   49118114 ±  3%  perf-stat.i.branch-misses
     17.13            +2.5       19.60        perf-stat.i.cache-miss-rate%
  39926130            +9.6%   43744236        perf-stat.i.cache-misses
 2.523e+08            -5.2%  2.392e+08        perf-stat.i.cache-references
    599901           -25.7%     445546        perf-stat.i.context-switches
      2.26 ±  3%      +6.2%       2.40        perf-stat.i.cpi
 3.977e+10            -5.9%  3.741e+10        perf-stat.i.cpu-cycles
     48176           -72.7%      13133        perf-stat.i.cpu-migrations
      1009           -12.7%     880.94 ±  2%  perf-stat.i.cycles-between-cache-misses
      0.64            -0.0        0.61 ±  3%  perf-stat.i.dTLB-load-miss-rate%
  33152560           -10.8%   29565873 ±  3%  perf-stat.i.dTLB-load-misses
 4.966e+09            -5.5%  4.693e+09        perf-stat.i.dTLB-loads
      0.18 ±  4%      -0.0        0.15 ±  2%  perf-stat.i.dTLB-store-miss-rate%
   2378797 ±  4%     -12.1%    2091893 ±  3%  perf-stat.i.dTLB-store-misses
 1.317e+09            +3.0%  1.357e+09        perf-stat.i.dTLB-stores
     68.47           -15.1       53.42        perf-stat.i.iTLB-load-miss-rate%
   8216629           -42.9%    4691920        perf-stat.i.iTLB-load-misses
   4301064           +30.6%    5615809 ±  3%  perf-stat.i.iTLB-loads
 1.981e+10            -6.2%  1.858e+10        perf-stat.i.instructions
      2788 ±  3%     +46.3%       4078 ±  3%  perf-stat.i.instructions-per-iTLB-miss
      0.83            -5.9%       0.78        perf-stat.i.metric.GHz
      0.24 ± 10%    +131.1%       0.56 ±  6%  perf-stat.i.metric.K/sec
    227.35            -4.8%     216.32        perf-stat.i.metric.M/sec
     45.27            -1.5       43.80        perf-stat.i.node-load-miss-rate%
  18589033            -1.5%   18304945        perf-stat.i.node-load-misses
  12517155           +13.7%   14232925        perf-stat.i.node-store-misses
  18575324           +11.3%   20676441        perf-stat.i.node-stores
      1.06 ±  2%      +0.2        1.22 ±  3%  perf-stat.overall.branch-miss-rate%
     15.83            +2.5       18.29        perf-stat.overall.cache-miss-rate%
    996.16           -14.1%     855.28        perf-stat.overall.cycles-between-cache-misses
      0.66            -0.0        0.63 ±  3%  perf-stat.overall.dTLB-load-miss-rate%
      0.18 ±  4%      -0.0        0.15 ±  2%  perf-stat.overall.dTLB-store-miss-rate%
     65.64           -20.1       45.54 ±  2%  perf-stat.overall.iTLB-load-miss-rate%
      2411           +64.2%       3960        perf-stat.overall.instructions-per-iTLB-miss
     47.60            -0.6       47.03        perf-stat.overall.node-load-miss-rate%
     40.26            +0.5       40.77        perf-stat.overall.node-store-miss-rate%
 4.257e+09            -7.2%  3.951e+09        perf-stat.ps.branch-instructions
  45324442 ±  2%      +6.4%   48223476 ±  3%  perf-stat.ps.branch-misses
  39373167            +8.9%   42887411        perf-stat.ps.cache-misses
 2.488e+08            -5.8%  2.345e+08        perf-stat.ps.cache-references
    591509           -26.2%     436737        perf-stat.ps.context-switches
 3.922e+10            -6.5%  3.668e+10        perf-stat.ps.cpu-cycles
     47502           -72.9%      12874        perf-stat.ps.cpu-migrations
  32689942           -11.3%   28983395 ±  3%  perf-stat.ps.dTLB-load-misses
 4.897e+09            -6.0%  4.601e+09        perf-stat.ps.dTLB-loads
   2345925 ±  4%     -12.6%    2051157 ±  3%  perf-stat.ps.dTLB-store-misses
 1.299e+09            +2.4%  1.331e+09        perf-stat.ps.dTLB-stores
   8102419           -43.2%    4600177        perf-stat.ps.iTLB-load-misses
   4240977           +29.8%    5504884 ±  3%  perf-stat.ps.iTLB-loads
 1.954e+10            -6.8%  1.822e+10        perf-stat.ps.instructions
  18329122            -2.1%   17943105        perf-stat.ps.node-load-misses
  12342162           +13.0%   13951584        perf-stat.ps.node-store-misses
  18315870           +10.7%   20267915        perf-stat.ps.node-stores
  1.48e+12           -34.2%  9.735e+11        perf-stat.total.instructions
    122.75 ± 89%     -74.5%      31.25 ±  7%  interrupts.42:PCI-MSI.2621448-edge.eth0-TxRx-7
    152826           -29.0%     108455        interrupts.CPU0.LOC:Local_timer_interrupts
      6665 ± 15%     -36.3%       4246 ± 14%  interrupts.CPU0.RES:Rescheduling_interrupts
    152828           -29.2%     108194        interrupts.CPU1.LOC:Local_timer_interrupts
      5599 ±  8%     -37.9%       3474 ±  3%  interrupts.CPU1.RES:Rescheduling_interrupts
    152281           -28.8%     108431        interrupts.CPU10.LOC:Local_timer_interrupts
      3939 ±  4%     -44.8%       2172 ± 30%  interrupts.CPU10.NMI:Non-maskable_interrupts
      3939 ±  4%     -44.8%       2172 ± 30%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
      5445 ±  3%     -37.8%       3388        interrupts.CPU10.RES:Rescheduling_interrupts
    152253           -28.8%     108417        interrupts.CPU11.LOC:Local_timer_interrupts
      3187 ± 28%     -25.5%       2373 ± 36%  interrupts.CPU11.NMI:Non-maskable_interrupts
      3187 ± 28%     -25.5%       2373 ± 36%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
    152655           -28.9%     108471        interrupts.CPU12.LOC:Local_timer_interrupts
      6315 ± 13%     -43.3%       3579 ±  2%  interrupts.CPU12.RES:Rescheduling_interrupts
    152850           -29.0%     108475        interrupts.CPU13.LOC:Local_timer_interrupts
      3349 ± 21%     -27.4%       2431 ± 36%  interrupts.CPU13.NMI:Non-maskable_interrupts
      3349 ± 21%     -27.4%       2431 ± 36%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
      5711 ±  2%     -32.8%       3836 ± 19%  interrupts.CPU13.RES:Rescheduling_interrupts
    152819           -29.1%     108317        interrupts.CPU14.LOC:Local_timer_interrupts
      3019 ± 32%     -38.3%       1862 ±  2%  interrupts.CPU14.NMI:Non-maskable_interrupts
      3019 ± 32%     -38.3%       1862 ±  2%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
      5738           -38.2%       3546 ±  2%  interrupts.CPU14.RES:Rescheduling_interrupts
    152859           -29.2%     108233        interrupts.CPU15.LOC:Local_timer_interrupts
      2611 ± 23%     -18.2%       2135 ± 21%  interrupts.CPU15.NMI:Non-maskable_interrupts
      2611 ± 23%     -18.2%       2135 ± 21%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
      5669           -39.5%       3430        interrupts.CPU15.RES:Rescheduling_interrupts
    152721           -29.0%     108431        interrupts.CPU16.LOC:Local_timer_interrupts
      5619           -39.6%       3396        interrupts.CPU16.RES:Rescheduling_interrupts
    152667           -29.0%     108459        interrupts.CPU17.LOC:Local_timer_interrupts
      5614           -37.8%       3490 ±  2%  interrupts.CPU17.RES:Rescheduling_interrupts
    152713           -29.0%     108449        interrupts.CPU18.LOC:Local_timer_interrupts
      5683 ±  2%     -28.5%       4066 ± 18%  interrupts.CPU18.RES:Rescheduling_interrupts
    152924           -29.1%     108456        interrupts.CPU19.LOC:Local_timer_interrupts
      5601           -37.9%       3478 ±  3%  interrupts.CPU19.RES:Rescheduling_interrupts
    152728           -29.0%     108459        interrupts.CPU2.LOC:Local_timer_interrupts
      2882 ± 30%     -24.7%       2171 ± 24%  interrupts.CPU2.NMI:Non-maskable_interrupts
      2882 ± 30%     -24.7%       2171 ± 24%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
      5413 ±  2%     -31.5%       3706 ± 10%  interrupts.CPU2.RES:Rescheduling_interrupts
    152541           -28.9%     108435        interrupts.CPU20.LOC:Local_timer_interrupts
      5860           -37.0%       3691        interrupts.CPU20.RES:Rescheduling_interrupts
    152329           -28.8%     108387        interrupts.CPU21.LOC:Local_timer_interrupts
      5582           -37.7%       3477 ±  4%  interrupts.CPU21.RES:Rescheduling_interrupts
    152212           -28.6%     108706        interrupts.CPU22.LOC:Local_timer_interrupts
      5723           -38.2%       3536 ±  2%  interrupts.CPU22.RES:Rescheduling_interrupts
    152451           -28.9%     108455        interrupts.CPU23.LOC:Local_timer_interrupts
      5645           -37.5%       3531        interrupts.CPU23.RES:Rescheduling_interrupts
    152813           -29.0%     108450        interrupts.CPU24.LOC:Local_timer_interrupts
      3192 ± 28%     -28.4%       2286 ± 34%  interrupts.CPU24.NMI:Non-maskable_interrupts
      3192 ± 28%     -28.4%       2286 ± 34%  interrupts.CPU24.PMI:Performance_monitoring_interrupts
      5587 ±  2%     -37.1%       3511        interrupts.CPU24.RES:Rescheduling_interrupts
    152870           -29.1%     108438        interrupts.CPU25.LOC:Local_timer_interrupts
      5629 ±  2%     -36.0%       3603 ±  3%  interrupts.CPU25.RES:Rescheduling_interrupts
    152727           -29.0%     108410        interrupts.CPU26.LOC:Local_timer_interrupts
      5516           -36.4%       3511        interrupts.CPU26.RES:Rescheduling_interrupts
    152618           -29.1%     108171        interrupts.CPU27.LOC:Local_timer_interrupts
      2562 ± 33%     -27.9%       1848 ±  4%  interrupts.CPU27.NMI:Non-maskable_interrupts
      2562 ± 33%     -27.9%       1848 ±  4%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
      5501           -37.6%       3435 ±  2%  interrupts.CPU27.RES:Rescheduling_interrupts
    152552           -28.9%     108426        interrupts.CPU28.LOC:Local_timer_interrupts
      5527 ±  2%     -35.3%       3575 ±  2%  interrupts.CPU28.RES:Rescheduling_interrupts
    152168           -28.7%     108462        interrupts.CPU29.LOC:Local_timer_interrupts
      5429 ±  2%     -38.1%       3358 ±  3%  interrupts.CPU29.RES:Rescheduling_interrupts
    152691           -29.2%     108172        interrupts.CPU3.LOC:Local_timer_interrupts
    152496           -28.9%     108442        interrupts.CPU30.LOC:Local_timer_interrupts
      5439           -37.2%       3417 ±  3%  interrupts.CPU30.RES:Rescheduling_interrupts
    152408           -28.9%     108434        interrupts.CPU31.LOC:Local_timer_interrupts
      1996           +72.7%       3448 ±  7%  interrupts.CPU31.NMI:Non-maskable_interrupts
      1996           +72.7%       3448 ±  7%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
      5405           -37.9%       3358        interrupts.CPU31.RES:Rescheduling_interrupts
    152368           -29.0%     108213        interrupts.CPU32.LOC:Local_timer_interrupts
      5487 ±  4%     -34.9%       3570 ±  5%  interrupts.CPU32.RES:Rescheduling_interrupts
    122.75 ± 89%     -74.5%      31.25 ±  7%  interrupts.CPU33.42:PCI-MSI.2621448-edge.eth0-TxRx-7
    152190           -28.8%     108434        interrupts.CPU33.LOC:Local_timer_interrupts
      5397 ±  3%     -37.0%       3398 ±  2%  interrupts.CPU33.RES:Rescheduling_interrupts
    152274           -28.8%     108410        interrupts.CPU34.LOC:Local_timer_interrupts
      5644 ±  2%     -37.5%       3526        interrupts.CPU34.RES:Rescheduling_interrupts
    152204           -28.8%     108394        interrupts.CPU35.LOC:Local_timer_interrupts
      5440           -36.9%       3434        interrupts.CPU35.RES:Rescheduling_interrupts
    152846           -29.0%     108452        interrupts.CPU36.LOC:Local_timer_interrupts
      5751 ±  2%     -38.7%       3526 ±  2%  interrupts.CPU36.RES:Rescheduling_interrupts
    152906           -29.1%     108450        interrupts.CPU37.LOC:Local_timer_interrupts
      5655           -38.3%       3489 ±  2%  interrupts.CPU37.RES:Rescheduling_interrupts
    152894           -29.1%     108466        interrupts.CPU38.LOC:Local_timer_interrupts
      5718           -40.1%       3426        interrupts.CPU38.RES:Rescheduling_interrupts
    152859           -29.1%     108396        interrupts.CPU39.LOC:Local_timer_interrupts
      5705 ±  2%     -39.1%       3477 ±  2%  interrupts.CPU39.RES:Rescheduling_interrupts
    152552           -28.9%     108451        interrupts.CPU4.LOC:Local_timer_interrupts
      5646 ± 10%     -37.0%       3558 ± 10%  interrupts.CPU4.RES:Rescheduling_interrupts
    152750           -29.0%     108474        interrupts.CPU40.LOC:Local_timer_interrupts
      3276 ± 24%     -26.8%       2399 ± 35%  interrupts.CPU40.NMI:Non-maskable_interrupts
      3276 ± 24%     -26.8%       2399 ± 35%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
      5576           -38.9%       3406 ±  3%  interrupts.CPU40.RES:Rescheduling_interrupts
    152315           -28.8%     108444        interrupts.CPU41.LOC:Local_timer_interrupts
      5628           -39.3%       3415 ±  2%  interrupts.CPU41.RES:Rescheduling_interrupts
    152653           -29.0%     108402        interrupts.CPU42.LOC:Local_timer_interrupts
      5601           -38.8%       3429        interrupts.CPU42.RES:Rescheduling_interrupts
    152608           -28.9%     108444        interrupts.CPU43.LOC:Local_timer_interrupts
      5697           -37.9%       3539 ±  3%  interrupts.CPU43.RES:Rescheduling_interrupts
    152559           -28.7%     108808        interrupts.CPU44.LOC:Local_timer_interrupts
      4041           -41.9%       2349 ± 35%  interrupts.CPU44.NMI:Non-maskable_interrupts
      4041           -41.9%       2349 ± 35%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
      5733           -38.3%       3535        interrupts.CPU44.RES:Rescheduling_interrupts
    152335           -28.7%     108551        interrupts.CPU45.LOC:Local_timer_interrupts
      5763           -39.1%       3510 ±  3%  interrupts.CPU45.RES:Rescheduling_interrupts
    152247           -28.4%     109025        interrupts.CPU46.LOC:Local_timer_interrupts
      5638           -38.9%       3446 ±  3%  interrupts.CPU46.RES:Rescheduling_interrupts
    152218           -28.7%     108515        interrupts.CPU47.LOC:Local_timer_interrupts
      5622           -38.3%       3467        interrupts.CPU47.RES:Rescheduling_interrupts
    152536           -28.9%     108438        interrupts.CPU5.LOC:Local_timer_interrupts
      5818 ± 13%     -32.9%       3902 ± 24%  interrupts.CPU5.RES:Rescheduling_interrupts
    152446           -28.8%     108470        interrupts.CPU6.LOC:Local_timer_interrupts
      5329 ±  2%     -34.8%       3477        interrupts.CPU6.RES:Rescheduling_interrupts
    152385           -28.8%     108460        interrupts.CPU7.LOC:Local_timer_interrupts
      3418 ± 24%     -32.0%       2325 ± 36%  interrupts.CPU7.NMI:Non-maskable_interrupts
      3418 ± 24%     -32.0%       2325 ± 36%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
      6075 ± 15%     -39.9%       3652 ±  3%  interrupts.CPU7.RES:Rescheduling_interrupts
    152777           -29.1%     108340        interrupts.CPU8.LOC:Local_timer_interrupts
      3062 ± 31%     -39.2%       1862 ±  2%  interrupts.CPU8.NMI:Non-maskable_interrupts
      3062 ± 31%     -39.2%       1862 ±  2%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
      5715           -37.9%       3547 ±  2%  interrupts.CPU8.RES:Rescheduling_interrupts
    152182           -28.8%     108424        interrupts.CPU9.LOC:Local_timer_interrupts
      3430 ± 24%     -46.5%       1833 ±  2%  interrupts.CPU9.NMI:Non-maskable_interrupts
      3430 ± 24%     -46.5%       1833 ±  2%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
      5429           -31.8%       3703 ± 12%  interrupts.CPU9.RES:Rescheduling_interrupts
   7323124           -28.9%    5205113        interrupts.LOC:Local_timer_interrupts
    146059 ±  4%     -10.9%     130082        interrupts.NMI:Non-maskable_interrupts
    146059 ±  4%     -10.9%     130082        interrupts.PMI:Performance_monitoring_interrupts
    271567           -36.9%     171453        interrupts.RES:Rescheduling_interrupts
     17140 ±  3%     -34.8%      11168        softirqs.CPU0.RCU
     17986 ±  5%     -19.6%      14464 ±  7%  softirqs.CPU0.SCHED
     28979 ±  4%     -20.9%      22922 ±  5%  softirqs.CPU0.TIMER
     17619           -38.8%      10778 ±  4%  softirqs.CPU1.RCU
     15605 ±  7%     -27.1%      11383 ±  4%  softirqs.CPU1.SCHED
     16585 ±  3%     -33.9%      10961 ±  2%  softirqs.CPU10.RCU
     13799 ±  2%     -28.2%       9904        softirqs.CPU10.SCHED
     27653 ±  2%     -14.0%      23789 ±  6%  softirqs.CPU10.TIMER
     16548 ±  2%     -31.8%      11278 ±  4%  softirqs.CPU11.RCU
     13273 ±  3%     -22.9%      10231 ±  6%  softirqs.CPU11.SCHED
     16266 ±  6%     -29.5%      11463 ±  2%  softirqs.CPU12.RCU
     14858 ±  6%     -28.1%      10682 ±  6%  softirqs.CPU12.SCHED
     33722 ± 18%     -24.9%      25329 ±  5%  softirqs.CPU12.TIMER
     15708 ±  2%     -32.1%      10673 ±  2%  softirqs.CPU13.RCU
     13743 ±  5%     -26.4%      10119 ±  4%  softirqs.CPU13.SCHED
     29036 ±  3%     -20.1%      23189 ±  4%  softirqs.CPU13.TIMER
     16055 ±  2%     -31.6%      10986 ±  3%  softirqs.CPU14.RCU
     13325 ±  5%     -25.8%       9883 ±  8%  softirqs.CPU14.SCHED
     28544 ±  5%     -19.1%      23081 ±  7%  softirqs.CPU14.TIMER
     15921 ±  2%     -33.5%      10587 ±  2%  softirqs.CPU15.RCU
     13359 ±  3%     -27.2%       9729 ±  4%  softirqs.CPU15.SCHED
     29422 ±  5%     -23.2%      22599 ±  5%  softirqs.CPU15.TIMER
     17193           -35.9%      11025        softirqs.CPU16.RCU
     13323 ±  4%     -26.9%       9736 ±  7%  softirqs.CPU16.SCHED
     28613 ±  5%     -20.4%      22775 ±  4%  softirqs.CPU16.TIMER
     17197           -34.9%      11191        softirqs.CPU17.RCU
     13120 ±  4%     -22.6%      10151        softirqs.CPU17.SCHED
     28246 ±  2%     -19.0%      22875 ±  4%  softirqs.CPU17.TIMER
     17045           -35.2%      11052        softirqs.CPU18.RCU
     13658           -25.2%      10221 ±  2%  softirqs.CPU18.SCHED
     28477           -20.0%      22794 ±  4%  softirqs.CPU18.TIMER
     16917           -34.6%      11063        softirqs.CPU19.RCU
     13777           -27.5%       9992 ±  3%  softirqs.CPU19.SCHED
     28454 ±  3%     -20.0%      22775 ±  6%  softirqs.CPU19.TIMER
     17271 ±  2%     -35.6%      11124        softirqs.CPU2.RCU
     13807 ±  5%     -25.7%      10262 ±  4%  softirqs.CPU2.SCHED
     28069 ±  3%     -17.6%      23118 ±  6%  softirqs.CPU2.TIMER
     16727           -34.9%      10886        softirqs.CPU20.RCU
     13544 ±  2%     -27.3%       9849 ±  3%  softirqs.CPU20.SCHED
     29083 ±  4%     -21.0%      22987 ±  6%  softirqs.CPU20.TIMER
     16432           -33.7%      10899 ±  2%  softirqs.CPU21.RCU
     13384 ±  2%     -25.1%      10027 ±  3%  softirqs.CPU21.SCHED
     28221 ±  2%     -17.1%      23402 ±  6%  softirqs.CPU21.TIMER
     16478           -33.8%      10916 ±  2%  softirqs.CPU22.RCU
     13285 ±  2%     -24.9%       9976        softirqs.CPU22.SCHED
     29361 ±  6%     -21.8%      22961 ±  5%  softirqs.CPU22.TIMER
     16217 ±  2%     -33.8%      10734 ±  2%  softirqs.CPU23.RCU
     13344 ±  4%     -26.6%       9798 ±  5%  softirqs.CPU23.SCHED
     28138 ±  2%     -18.2%      23016 ±  5%  softirqs.CPU23.TIMER
     17081 ±  4%     -36.5%      10849 ±  2%  softirqs.CPU24.RCU
     13721           -28.8%       9765 ±  2%  softirqs.CPU24.SCHED
     17285 ±  3%     -38.9%      10567 ±  4%  softirqs.CPU25.RCU
     13652           -26.3%      10065        softirqs.CPU25.SCHED
     28148           -19.8%      22575 ±  7%  softirqs.CPU25.TIMER
     17536 ±  4%     -36.7%      11092        softirqs.CPU26.RCU
     13498 ±  3%     -25.8%      10009 ±  3%  softirqs.CPU26.SCHED
     28293 ±  5%     -19.4%      22798 ±  7%  softirqs.CPU26.TIMER
     17772 ±  3%     -37.7%      11066        softirqs.CPU27.RCU
     13915 ±  4%     -32.9%       9342 ±  7%  softirqs.CPU27.SCHED
     28883 ±  5%     -20.9%      22856 ±  6%  softirqs.CPU27.TIMER
     17120 ±  2%     -36.1%      10944 ±  4%  softirqs.CPU28.RCU
     13447 ±  3%     -25.5%      10016        softirqs.CPU28.SCHED
     28693 ±  2%     -22.8%      22153 ±  9%  softirqs.CPU28.TIMER
     17768 ±  3%     -36.7%      11247        softirqs.CPU29.RCU
     13008 ±  6%     -21.2%      10256 ±  2%  softirqs.CPU29.SCHED
     17261 ±  2%     -35.6%      11109        softirqs.CPU3.RCU
     13617 ±  9%     -22.1%      10603 ±  5%  softirqs.CPU3.SCHED
     27993 ±  2%     -16.6%      23351 ±  7%  softirqs.CPU3.TIMER
     17527 ±  2%     -35.6%      11282        softirqs.CPU30.RCU
     13802 ±  3%     -28.8%       9831 ±  6%  softirqs.CPU30.SCHED
     29335 ±  4%     -19.1%      23743 ±  7%  softirqs.CPU30.TIMER
     17177 ±  2%     -36.7%      10880        softirqs.CPU31.RCU
     13970           -27.7%      10107        softirqs.CPU31.SCHED
     27907 ±  4%     -17.1%      23143 ±  7%  softirqs.CPU31.TIMER
     15513 ±  6%     -31.1%      10683        softirqs.CPU32.RCU
     13604 ±  4%     -24.9%      10219        softirqs.CPU32.SCHED
     28401 ±  3%     -16.8%      23636 ±  8%  softirqs.CPU32.TIMER
     16438           -35.5%      10602        softirqs.CPU33.RCU
     13884 ±  2%     -29.3%       9817 ±  5%  softirqs.CPU33.SCHED
     28035 ±  4%     -16.0%      23546 ±  8%  softirqs.CPU33.TIMER
     16511 ±  3%     -35.0%      10725 ±  2%  softirqs.CPU34.RCU
     13845           -28.6%       9883 ±  7%  softirqs.CPU34.SCHED
     27630 ±  4%     -13.9%      23784 ±  8%  softirqs.CPU34.TIMER
     16437 ±  4%     -34.5%      10759        softirqs.CPU35.RCU
     13764 ±  2%     -27.9%       9925 ±  5%  softirqs.CPU35.SCHED
     16989 ±  4%     -35.6%      10948        softirqs.CPU36.RCU
     12964 ±  5%     -24.0%       9857        softirqs.CPU36.SCHED
     27393           -18.1%      22447 ±  5%  softirqs.CPU36.TIMER
     17454           -35.7%      11223 ±  2%  softirqs.CPU37.RCU
     13500 ±  4%     -26.8%       9882 ±  4%  softirqs.CPU37.SCHED
     28336 ±  3%     -19.4%      22833 ±  3%  softirqs.CPU37.TIMER
     20134 ± 14%     -31.1%      13870 ± 16%  softirqs.CPU38.RCU
     13271 ±  4%     -25.0%       9947 ±  3%  softirqs.CPU38.SCHED
     29935 ±  6%     -17.0%      24854 ±  2%  softirqs.CPU38.TIMER
     19850 ± 11%     -37.6%      12384 ± 16%  softirqs.CPU39.RCU
     13570           -27.8%       9803 ±  5%  softirqs.CPU39.SCHED
     30276 ±  8%     -24.1%      22994 ± 11%  softirqs.CPU39.TIMER
     16670 ±  3%     -34.2%      10963 ±  4%  softirqs.CPU4.RCU
     13283 ±  5%     -22.7%      10262 ±  2%  softirqs.CPU4.SCHED
     17482           -29.6%      12315 ± 15%  softirqs.CPU40.RCU
     13702 ±  3%     -27.5%       9935 ±  3%  softirqs.CPU40.SCHED
     28521 ±  3%     -16.9%      23697 ±  8%  softirqs.CPU40.TIMER
     17356 ±  2%     -35.5%      11192 ±  2%  softirqs.CPU41.RCU
     13463 ±  2%     -27.6%       9746 ±  6%  softirqs.CPU41.SCHED
     28259 ±  2%     -20.0%      22603 ±  5%  softirqs.CPU41.TIMER
     17727 ±  2%     -36.2%      11301 ±  2%  softirqs.CPU42.RCU
     13690           -28.3%       9820 ±  3%  softirqs.CPU42.SCHED
     17241 ±  2%     -35.4%      11134        softirqs.CPU43.RCU
     13661           -25.7%      10155 ±  2%  softirqs.CPU43.SCHED
     28137 ±  3%     -19.3%      22717 ±  6%  softirqs.CPU43.TIMER
     16832           -35.4%      10877        softirqs.CPU44.RCU
     13715           -26.8%      10036 ±  3%  softirqs.CPU44.SCHED
     29149 ±  7%     -22.2%      22690 ±  5%  softirqs.CPU44.TIMER
     16717           -35.1%      10851        softirqs.CPU45.RCU
     13690 ±  2%     -26.4%      10072        softirqs.CPU45.SCHED
     28192 ±  2%     -19.7%      22641 ±  5%  softirqs.CPU45.TIMER
     16561           -35.1%      10755        softirqs.CPU46.RCU
     13475 ±  2%     -26.6%       9886        softirqs.CPU46.SCHED
     29227 ±  8%     -21.8%      22861 ±  5%  softirqs.CPU46.TIMER
     16988 ±  2%     -35.7%      10928        softirqs.CPU47.RCU
     13693           -26.3%      10094        softirqs.CPU47.SCHED
     28344 ±  2%     -19.5%      22803 ±  4%  softirqs.CPU47.TIMER
     17152 ±  2%     -34.3%      11277 ±  2%  softirqs.CPU5.RCU
     13954 ±  6%     -27.4%      10125 ±  5%  softirqs.CPU5.SCHED
     28016 ±  3%     -12.9%      24406 ± 10%  softirqs.CPU5.TIMER
     17496 ±  3%     -35.9%      11212        softirqs.CPU6.RCU
     13667           -28.0%       9843 ±  9%  softirqs.CPU6.SCHED
     29313 ±  6%     -17.1%      24297 ± 10%  softirqs.CPU6.TIMER
     16871 ±  2%     -34.0%      11134 ±  2%  softirqs.CPU7.RCU
     14093 ±  3%     -27.2%      10263        softirqs.CPU7.SCHED
     27786 ±  2%     -11.1%      24697 ±  9%  softirqs.CPU7.TIMER
     15933 ±  4%     -32.9%      10697        softirqs.CPU8.RCU
     13506 ±  4%     -26.3%       9949 ±  3%  softirqs.CPU8.SCHED
     35708 ± 22%     -35.1%      23168 ±  7%  softirqs.CPU8.TIMER
     16502 ±  3%     -34.5%      10801        softirqs.CPU9.RCU
     13399 ±  4%     -27.0%       9786 ±  4%  softirqs.CPU9.SCHED
     27553 ±  3%     -14.8%      23461 ±  7%  softirqs.CPU9.TIMER
    816730 ±  2%     -34.8%     532482        softirqs.RCU
    659242           -26.3%     485737        softirqs.SCHED
   1382277 ±  2%     -18.2%    1131336 ±  5%  softirqs.TIMER
     15.54 ±  2%     -15.5        0.00        perf-profile.calltrace.cycles-pp.set_node_addr.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
     15.31 ±  2%     -15.3        0.00        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.set_node_addr.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
     14.76 ±  2%     -14.8        0.00        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.set_node_addr.__write_node_page.f2fs_fsync_node_pages
     13.15 ±  2%     -13.2        0.00        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.set_node_addr.__write_node_page
     33.69            -9.1       24.59 ±  2%  perf-profile.calltrace.cycles-pp.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
     22.33            -6.6       15.70 ±  3%  perf-profile.calltrace.cycles-pp.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
     44.27            -6.0       38.26 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
     44.25            -6.0       38.24 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     44.27            -6.0       38.27 ±  2%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
     44.90            -6.0       38.94        perf-profile.calltrace.cycles-pp.secondary_startup_64
     38.50            -4.9       33.63        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     39.04            -4.8       34.24 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     39.11            -4.8       34.31 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      5.73            -2.7        2.99        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_fsync_node_pages
      6.22            -2.6        3.59        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file
      6.25            -2.6        3.62        perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      2.77            -2.5        0.26 ±100%  perf-profile.calltrace.cycles-pp.rwsem_wake.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      7.53            -1.7        5.83        perf-profile.calltrace.cycles-pp.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      2.42 ±  2%      -1.2        1.21 ± 20%  perf-profile.calltrace.cycles-pp.__account_scheduler_latency.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      1.99            -1.0        0.95 ±  2%  perf-profile.calltrace.cycles-pp.stack_trace_save_tsk.__account_scheduler_latency.enqueue_entity.enqueue_task_fair.activate_task
      1.87            -1.0        0.91 ±  2%  perf-profile.calltrace.cycles-pp.arch_stack_walk.stack_trace_save_tsk.__account_scheduler_latency.enqueue_entity.enqueue_task_fair
      1.19 ±  3%      -0.6        0.59        perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up
      2.25            -0.5        1.72        perf-profile.calltrace.cycles-pp.sched_ttwu_pending.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      1.96            -0.5        1.48 ±  2%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.do_idle.cpu_startup_entry.start_secondary
      1.96            -0.5        1.48 ±  2%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.do_idle.cpu_startup_entry
      1.95            -0.5        1.47 ±  2%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending.do_idle
      1.84            -0.5        1.38 ±  3%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending
      1.12 ±  2%      -0.4        0.71 ±  4%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      1.10 ±  2%      -0.4        0.69 ±  5%  perf-profile.calltrace.cycles-pp.__sched_text_start.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.61 ±  2%      -0.4        0.25 ±100%  perf-profile.calltrace.cycles-pp.unwind_next_frame.arch_stack_walk.stack_trace_save_tsk.__account_scheduler_latency.enqueue_entity
      1.04            -0.1        0.90 ±  5%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      0.78            +0.0        0.82 ±  4%  perf-profile.calltrace.cycles-pp.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      1.47 ±  4%      +0.2        1.67 ±  3%  perf-profile.calltrace.cycles-pp.pagevec_lookup_range_tag.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      1.46 ±  4%      +0.2        1.66 ±  3%  perf-profile.calltrace.cycles-pp.find_get_pages_range_tag.pagevec_lookup_range_tag.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.59 ±  8%      +0.3        0.86 ±  4%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      0.58 ±  4%      +0.4        1.01        perf-profile.calltrace.cycles-pp.try_to_wake_up.swake_up_locked.complete.issue_flush_thread.kthread
      0.60 ±  4%      +0.4        1.05        perf-profile.calltrace.cycles-pp.swake_up_locked.complete.issue_flush_thread.kthread.ret_from_fork
      0.61 ±  4%      +0.5        1.06        perf-profile.calltrace.cycles-pp.complete.issue_flush_thread.kthread.ret_from_fork
      0.74 ±  4%      +0.5        1.25        perf-profile.calltrace.cycles-pp.f2fs_write_begin.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter.new_sync_write
      0.13 ±173%      +0.5        0.65 ±  4%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +0.5        0.52 ±  2%  perf-profile.calltrace.cycles-pp.f2fs_update_data_blkaddr.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages
      0.00            +0.5        0.54 ±  5%  perf-profile.calltrace.cycles-pp.submit_bio_wait.__submit_flush_wait.issue_flush_thread.kthread.ret_from_fork
      0.00            +0.5        0.54 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page
      0.00            +0.6        0.55        perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_fsync_node_pages
      0.00            +0.6        0.56        perf-profile.calltrace.cycles-pp.f2fs_submit_merged_ipu_write.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.__filemap_fdatawrite_range
      0.00            +0.6        0.56        perf-profile.calltrace.cycles-pp.__mutex_lock.f2fs_allocate_data_block.do_write_page.f2fs_do_write_node_page.__write_node_page
      0.77 ±  3%      +0.6        1.35        perf-profile.calltrace.cycles-pp.f2fs_allocate_data_block.do_write_page.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages
      0.00            +0.6        0.59 ±  5%  perf-profile.calltrace.cycles-pp.__submit_flush_wait.issue_flush_thread.kthread.ret_from_fork
      0.00            +0.6        0.60 ±  6%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_write_cache_pages
      0.96 ±  3%      +0.6        1.56        perf-profile.calltrace.cycles-pp.generic_make_request.submit_bio.__submit_merged_bio.__submit_merged_write_cond.f2fs_write_cache_pages
      0.76            +0.6        1.37        perf-profile.calltrace.cycles-pp.generic_make_request.submit_bio.__submit_merged_bio.__submit_merged_write_cond.f2fs_fsync_node_pages
      1.00 ±  3%      +0.6        1.61        perf-profile.calltrace.cycles-pp.submit_bio.__submit_merged_bio.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages
      1.02 ±  3%      +0.6        1.64        perf-profile.calltrace.cycles-pp.__submit_merged_bio.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages
      0.00            +0.6        0.62        perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up.swake_up_locked
      0.78            +0.6        1.40        perf-profile.calltrace.cycles-pp.submit_bio.__submit_merged_bio.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +0.6        0.63        perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.swake_up_locked.complete.issue_flush_thread
      0.00            +0.6        0.63        perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.try_to_wake_up.swake_up_locked.complete
      2.33 ± 17%      +0.6        2.97 ±  7%  perf-profile.calltrace.cycles-pp.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page
      0.78            +0.6        1.42        perf-profile.calltrace.cycles-pp.__submit_merged_bio.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +0.6        0.64 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.f2fs_allocate_data_block.do_write_page
      0.00            +0.7        0.67 ±  6%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__percpu_counter_sum.f2fs_space_for_roll_forward.f2fs_do_sync_file
      1.19 ±  8%      +0.7        1.86 ±  3%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_write_cache_pages
      0.00            +0.7        0.73 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__percpu_counter_sum.f2fs_space_for_roll_forward.f2fs_do_sync_file.f2fs_file_write_iter
      0.72 ±  7%      +0.7        1.47 ±  5%  perf-profile.calltrace.cycles-pp.__percpu_counter_sum.f2fs_space_for_roll_forward.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.75 ±  7%      +0.8        1.51 ±  5%  perf-profile.calltrace.cycles-pp.f2fs_space_for_roll_forward.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
      0.89 ±  4%      +0.8        1.69 ±  2%  perf-profile.calltrace.cycles-pp.f2fs_issue_flush.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
      0.00            +0.8        0.80        perf-profile.calltrace.cycles-pp.__sched_text_start.schedule.schedule_timeout.wait_for_completion.f2fs_issue_flush
      1.29 ±  4%      +0.8        2.10        perf-profile.calltrace.cycles-pp.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter.new_sync_write.vfs_write
      0.14 ±173%      +0.8        0.98        perf-profile.calltrace.cycles-pp.wait_for_completion.f2fs_issue_flush.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.00            +0.9        0.86        perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.wait_for_completion.f2fs_issue_flush.f2fs_do_sync_file
      1.44 ±  4%      +0.9        2.31        perf-profile.calltrace.cycles-pp.__generic_file_write_iter.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_write
      0.00            +0.9        0.89        perf-profile.calltrace.cycles-pp.schedule_timeout.wait_for_completion.f2fs_issue_flush.f2fs_do_sync_file.f2fs_file_write_iter
      0.98 ±  2%      +0.9        1.89 ±  2%  perf-profile.calltrace.cycles-pp.issue_flush_thread.kthread.ret_from_fork
      1.54 ±  5%      +1.0        2.51 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages
      1.57 ±  5%      +1.0        2.54 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages
      1.50 ±  2%      +1.0        2.51        perf-profile.calltrace.cycles-pp.brd_make_request.generic_make_request.submit_bio.__submit_merged_bio.__submit_merged_write_cond
      0.53 ±  2%      +1.1        1.62        perf-profile.calltrace.cycles-pp.brd_do_bvec.brd_make_request.generic_make_request.submit_bio.__submit_merged_bio
      0.00            +1.1        1.10        perf-profile.calltrace.cycles-pp.try_to_wake_up.wake_up_q.rwsem_wake.f2fs_allocate_data_block.do_write_page
      0.00            +1.1        1.13        perf-profile.calltrace.cycles-pp.wake_up_q.rwsem_wake.f2fs_allocate_data_block.do_write_page.f2fs_outplace_write_data
      1.58 ±  4%      +1.2        2.76 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork
      1.58 ±  4%      +1.2        2.76 ±  2%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      0.00            +1.3        1.28        perf-profile.calltrace.cycles-pp.rwsem_wake.f2fs_allocate_data_block.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page
      3.06 ±  3%      +2.0        5.06 ±  2%  perf-profile.calltrace.cycles-pp.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.__filemap_fdatawrite_range
     49.92            +3.1       53.02        perf-profile.calltrace.cycles-pp.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_write
      2.81 ± 14%      +3.9        6.73 ±  2%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page
      1.31            +4.0        5.32        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_do_write_node_page
      1.33            +4.0        5.35        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_do_write_node_page.__write_node_page
      1.58            +4.2        5.76        perf-profile.calltrace.cycles-pp.f2fs_submit_page_write.do_write_page.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages
     51.62            +4.2       55.84        perf-profile.calltrace.cycles-pp.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
     51.67            +4.2       55.90        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     51.89            +4.3       56.23        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     51.93            +4.4       56.29        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     52.14            +4.5       56.63        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     52.16            +4.5       56.66        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     52.57            +4.6       57.19        perf-profile.calltrace.cycles-pp.write
      2.44            +4.8        7.23        perf-profile.calltrace.cycles-pp.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      2.43            +4.8        7.22        perf-profile.calltrace.cycles-pp.do_write_page.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +5.3        5.34 ± 11%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_read_slowpath.__write_node_page.f2fs_fsync_node_pages
      0.00            +6.0        5.98 ±  9%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_read_slowpath.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +6.4        6.44 ±  8%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +8.2        8.21 ±  6%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.f2fs_allocate_data_block.do_write_page
      0.00            +9.8        9.79 ±  5%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.f2fs_allocate_data_block.do_write_page.f2fs_outplace_write_data
      0.00           +10.3       10.34 ±  5%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.f2fs_allocate_data_block.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page
      0.70 ±  2%     +11.8       12.47 ±  4%  perf-profile.calltrace.cycles-pp.f2fs_allocate_data_block.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page
      5.36 ±  8%     +11.9       17.27 ±  4%  perf-profile.calltrace.cycles-pp.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages
      5.51 ±  8%     +12.0       17.53 ±  3%  perf-profile.calltrace.cycles-pp.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.__filemap_fdatawrite_range
      3.10 ± 13%     +12.5       15.57 ±  4%  perf-profile.calltrace.cycles-pp.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages
      3.40 ± 11%     +12.7       16.13 ±  4%  perf-profile.calltrace.cycles-pp.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages
      9.22 ±  5%     +14.3       23.56 ±  3%  perf-profile.calltrace.cycles-pp.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.__filemap_fdatawrite_range.file_write_and_wait_range
      9.36 ±  5%     +14.4       23.75 ±  3%  perf-profile.calltrace.cycles-pp.do_writepages.__filemap_fdatawrite_range.file_write_and_wait_range.f2fs_do_sync_file.f2fs_file_write_iter
      9.34 ±  5%     +14.4       23.73 ±  3%  perf-profile.calltrace.cycles-pp.f2fs_write_data_pages.do_writepages.__filemap_fdatawrite_range.file_write_and_wait_range.f2fs_do_sync_file
      9.39 ±  5%     +14.4       23.79 ±  3%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.file_write_and_wait_range.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      9.48 ±  5%     +14.4       23.93 ±  3%  perf-profile.calltrace.cycles-pp.file_write_and_wait_range.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
     15.57 ±  2%     -15.1        0.46 ±  3%  perf-profile.children.cycles-pp.set_node_addr
     33.70            -9.1       24.60 ±  2%  perf-profile.children.cycles-pp.f2fs_fsync_node_pages
     22.33            -6.6       15.70 ±  3%  perf-profile.children.cycles-pp.__write_node_page
     44.27            -6.0       38.27 ±  2%  perf-profile.children.cycles-pp.start_secondary
     44.90            -6.0       38.94        perf-profile.children.cycles-pp.secondary_startup_64
     44.90            -6.0       38.94        perf-profile.children.cycles-pp.cpu_startup_entry
     44.90            -6.0       38.94        perf-profile.children.cycles-pp.do_idle
     38.62            -4.8       33.87        perf-profile.children.cycles-pp.intel_idle
     39.65            -4.7       34.92        perf-profile.children.cycles-pp.cpuidle_enter_state
     39.66            -4.7       34.93        perf-profile.children.cycles-pp.cpuidle_enter
      2.34 ± 15%      -2.0        0.30 ±  3%  perf-profile.children.cycles-pp.f2fs_get_node_info
      2.34 ± 35%      -2.0        0.30 ±  4%  perf-profile.children.cycles-pp.f2fs_is_checkpointed_node
      3.66 ±  2%      -2.0        1.69        perf-profile.children.cycles-pp.wake_up_q
      3.81 ±  2%      -2.0        1.85        perf-profile.children.cycles-pp.rwsem_wake
      2.14 ± 12%      -1.9        0.22 ±  6%  perf-profile.children.cycles-pp.f2fs_need_inode_block_update
      4.53 ±  2%      -1.3        3.24        perf-profile.children.cycles-pp.try_to_wake_up
      1.29 ±  4%      -1.1        0.23 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      2.67 ±  3%      -1.0        1.65        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.11 ± 10%      -1.0        0.12 ±  5%  perf-profile.children.cycles-pp.f2fs_need_dentry_mark
      4.19            -1.0        3.21        perf-profile.children.cycles-pp.ttwu_do_activate
      4.19            -1.0        3.21        perf-profile.children.cycles-pp.activate_task
      4.16            -1.0        3.18        perf-profile.children.cycles-pp.enqueue_task_fair
      3.99            -1.0        3.04        perf-profile.children.cycles-pp.enqueue_entity
      3.22            -0.8        2.45        perf-profile.children.cycles-pp.__account_scheduler_latency
      2.64            -0.5        2.10        perf-profile.children.cycles-pp.stack_trace_save_tsk
      2.33            -0.5        1.80        perf-profile.children.cycles-pp.sched_ttwu_pending
      2.49 ±  2%      -0.5        1.98        perf-profile.children.cycles-pp.arch_stack_walk
      2.79 ±  2%      -0.4        2.35        perf-profile.children.cycles-pp.__sched_text_start
      1.14 ±  2%      -0.4        0.73 ±  5%  perf-profile.children.cycles-pp.schedule_idle
      1.61 ±  2%      -0.3        1.28 ±  2%  perf-profile.children.cycles-pp.unwind_next_frame
      0.34 ±  7%      -0.2        0.13 ±  5%  perf-profile.children.cycles-pp.rwsem_mark_wake
      0.71 ±  3%      -0.2        0.53        perf-profile.children.cycles-pp.dequeue_entity
      0.81 ±  2%      -0.2        0.63 ±  2%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.67 ±  3%      -0.1        0.52        perf-profile.children.cycles-pp.update_load_avg
      0.49 ±  4%      -0.1        0.35 ±  3%  perf-profile.children.cycles-pp.select_task_rq_fair
      1.06            -0.1        0.93 ±  4%  perf-profile.children.cycles-pp.menu_select
      1.68            -0.1        1.56        perf-profile.children.cycles-pp.schedule
      0.24 ±  2%      -0.1        0.12 ±  8%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.50 ±  6%      -0.1        0.42 ±  2%  perf-profile.children.cycles-pp.orc_find
      0.36 ±  3%      -0.1        0.28 ±  2%  perf-profile.children.cycles-pp.__lookup_nat_cache
      0.42 ±  5%      -0.1        0.35 ±  5%  perf-profile.children.cycles-pp.unwind_get_return_address
      0.40 ±  6%      -0.1        0.33 ±  3%  perf-profile.children.cycles-pp.__kernel_text_address
      0.37 ±  9%      -0.1        0.30 ±  3%  perf-profile.children.cycles-pp.kernel_text_address
      0.14 ±  8%      -0.1        0.08 ± 10%  perf-profile.children.cycles-pp.update_cfs_rq_h_load
      0.32 ±  5%      -0.1        0.25 ±  4%  perf-profile.children.cycles-pp.stack_trace_consume_entry_nosched
      0.24 ±  3%      -0.1        0.18 ±  4%  perf-profile.children.cycles-pp.f2fs_update_inode_page
      0.41 ±  5%      -0.1        0.35 ±  2%  perf-profile.children.cycles-pp.__orc_find
      0.15 ±  7%      -0.1        0.10 ± 13%  perf-profile.children.cycles-pp.update_cfs_group
      0.27 ±  2%      -0.1        0.22 ±  3%  perf-profile.children.cycles-pp.f2fs_write_inode
      0.31 ±  4%      -0.0        0.26 ±  2%  perf-profile.children.cycles-pp.update_curr
      0.30 ±  4%      -0.0        0.26 ±  6%  perf-profile.children.cycles-pp.set_next_entity
      0.12 ±  5%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.wake_q_add
      0.20 ±  7%      -0.0        0.16 ±  5%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.08 ±  5%      -0.0        0.04 ± 57%  perf-profile.children.cycles-pp.cpuacct_charge
      0.18 ±  7%      -0.0        0.14 ±  7%  perf-profile.children.cycles-pp.__list_add_valid
      0.13 ±  9%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.12 ±  4%      -0.0        0.09 ±  9%  perf-profile.children.cycles-pp.f2fs_update_inode
      0.14 ±  7%      -0.0        0.10 ± 10%  perf-profile.children.cycles-pp.native_write_msr
      0.52 ±  2%      -0.0        0.48 ±  3%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.14 ±  5%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.finish_task_switch
      0.29 ±  2%      -0.0        0.26 ±  3%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.18 ±  8%      -0.0        0.15 ±  5%  perf-profile.children.cycles-pp.select_idle_sibling
      0.18 ±  4%      -0.0        0.15 ±  8%  perf-profile.children.cycles-pp.__switch_to_asm
      0.09 ± 14%      -0.0        0.07 ± 13%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.38 ±  4%      -0.0        0.35 ±  3%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.20 ±  4%      -0.0        0.18 ±  4%  perf-profile.children.cycles-pp.native_sched_clock
      0.24 ±  3%      -0.0        0.22 ±  6%  perf-profile.children.cycles-pp.update_rq_clock
      0.18 ±  6%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.__next_timer_interrupt
      0.17 ±  2%      -0.0        0.15 ±  5%  perf-profile.children.cycles-pp.___perf_sw_event
      0.09 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.08 ±  5%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.in_sched_functions
      0.07 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.rcu_idle_exit
      0.08 ±  5%      +0.0        0.10 ±  7%  perf-profile.children.cycles-pp.__set_nat_cache_dirty
      0.06 ± 15%      +0.0        0.07 ± 11%  perf-profile.children.cycles-pp.__get_segment_type
      0.05 ±  9%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__fdget_pos
      0.10 ±  4%      +0.0        0.12 ±  5%  perf-profile.children.cycles-pp.ksys_lseek
      0.06 ±  7%      +0.0        0.08 ± 10%  perf-profile.children.cycles-pp.f2fs_inode_chksum_verify
      0.07 ±  6%      +0.0        0.09 ±  8%  perf-profile.children.cycles-pp.common_file_perm
      0.68 ±  2%      +0.0        0.71        perf-profile.children.cycles-pp.hrtimer_interrupt
      0.13            +0.0        0.16 ±  6%  perf-profile.children.cycles-pp.read_tsc
      0.06 ± 13%      +0.0        0.09        perf-profile.children.cycles-pp.xas_set_mark
      0.06 ± 13%      +0.0        0.09        perf-profile.children.cycles-pp.__xa_set_mark
      0.05 ±  8%      +0.0        0.08 ±  8%  perf-profile.children.cycles-pp.tag_pages_for_writeback
      0.04 ± 57%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.put_prev_entity
      0.10 ± 14%      +0.0        0.13 ±  9%  perf-profile.children.cycles-pp.file_update_time
      0.06 ± 13%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.bio_associate_blkg_from_css
      0.06 ± 13%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.08 ±  5%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.cpumask_next
      0.09 ±  4%      +0.0        0.12 ±  9%  perf-profile.children.cycles-pp.security_file_permission
      0.25 ±  4%      +0.0        0.28 ±  6%  perf-profile.children.cycles-pp.up_read
      0.08 ± 10%      +0.0        0.11        perf-profile.children.cycles-pp.rmqueue
      0.07 ±  5%      +0.0        0.11 ±  8%  perf-profile.children.cycles-pp.unlock_page
      0.04 ± 58%      +0.0        0.07 ± 15%  perf-profile.children.cycles-pp.update_blocked_averages
      0.07 ± 11%      +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.bio_associate_blkg
      0.18 ±  7%      +0.0        0.22 ±  7%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      0.10 ±  8%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.account_page_dirtied
      0.11 ±  4%      +0.0        0.15 ±  8%  perf-profile.children.cycles-pp.kmem_cache_free
      0.04 ± 58%      +0.0        0.08 ±  8%  perf-profile.children.cycles-pp.__filemap_fdatawait_range
      0.15 ±  8%      +0.0        0.19 ±  9%  perf-profile.children.cycles-pp.dput
      0.15 ±  8%      +0.0        0.19 ±  7%  perf-profile.children.cycles-pp.__dentry_kill
      0.15 ±  5%      +0.0        0.19 ±  7%  perf-profile.children.cycles-pp.evict
      0.15 ±  5%      +0.0        0.19 ±  7%  perf-profile.children.cycles-pp.f2fs_evict_inode
      0.05 ±  8%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.sb_clear_inode_writeback
      0.15 ±  5%      +0.0        0.20 ±  7%  perf-profile.children.cycles-pp.exit_to_usermode_loop
      0.15 ±  5%      +0.0        0.20 ±  7%  perf-profile.children.cycles-pp.__fput
      0.12 ± 12%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.___might_sleep
      0.10 ± 11%      +0.0        0.14 ±  8%  perf-profile.children.cycles-pp.__mark_inode_dirty
      0.06 ± 11%      +0.0        0.11 ±  8%  perf-profile.children.cycles-pp.f2fs_truncate_data_blocks_range
      0.07 ± 10%      +0.0        0.12 ±  7%  perf-profile.children.cycles-pp.blk_throtl_bio
      0.08 ±  8%      +0.0        0.13 ±  6%  perf-profile.children.cycles-pp.f2fs_merge_page_bio
      0.01 ±173%      +0.0        0.06 ± 16%  perf-profile.children.cycles-pp.f2fs_llseek
      0.15 ±  5%      +0.0        0.20 ±  7%  perf-profile.children.cycles-pp.close
      0.15 ±  5%      +0.0        0.20 ±  7%  perf-profile.children.cycles-pp.task_work_run
      0.13 ±  3%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.update_stats_enqueue_sleeper
      0.11 ±  4%      +0.0        0.16 ±  6%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.06 ±  6%      +0.0        0.11 ± 15%  perf-profile.children.cycles-pp.f2fs_truncate
      0.06 ±  6%      +0.0        0.11 ± 15%  perf-profile.children.cycles-pp.f2fs_do_truncate_blocks
      0.03 ±100%      +0.0        0.07 ± 14%  perf-profile.children.cycles-pp.__xa_clear_mark
      0.12 ±  7%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.locate_dirty_segment
      0.82            +0.1        0.87 ±  3%  perf-profile.children.cycles-pp.release_pages
      0.07 ± 13%      +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.f2fs_update_dirty_page
      0.01 ±173%      +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.bvec_alloc
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__bio_associate_blkg
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.bio_free
      0.01 ±173%      +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      0.01 ±173%      +0.1        0.07 ± 12%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited
      0.31 ±  7%      +0.1        0.37 ±  3%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.07 ± 10%      +0.1        0.13 ± 12%  perf-profile.children.cycles-pp.f2fs_wait_on_node_pages_writeback
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.set_page_dirty
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.down_read_trylock
      0.04 ± 58%      +0.1        0.10 ± 15%  perf-profile.children.cycles-pp.f2fs_get_block
      0.04 ± 60%      +0.1        0.10 ±  7%  perf-profile.children.cycles-pp.mutex_unlock
      0.03 ±100%      +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.f2fs_invalidate_blocks
      0.08 ± 10%      +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.f2fs_del_fsync_node_entry
      0.09 ±  7%      +0.1        0.15 ±  8%  perf-profile.children.cycles-pp.__has_merged_page
      0.07 ±  5%      +0.1        0.13 ±  8%  perf-profile.children.cycles-pp.sb_mark_inode_writeback
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.bio_endio
      0.00            +0.1        0.06 ± 20%  perf-profile.children.cycles-pp.__sb_start_write
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.rcu_all_qs
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.xas_clear_mark
      0.13 ± 12%      +0.1        0.20 ±  4%  perf-profile.children.cycles-pp.copyin
      0.12 ± 12%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.f2fs_balance_fs
      0.00            +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.f2fs_target_device
      0.01 ±173%      +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.f2fs_reserve_new_blocks
      0.11 ±  7%      +0.1        0.18 ±  6%  perf-profile.children.cycles-pp.__remove_ino_entry
      0.12 ± 13%      +0.1        0.19 ±  2%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.01 ±173%      +0.1        0.08 ± 15%  perf-profile.children.cycles-pp.f2fs_reserve_block
      0.11 ±  7%      +0.1        0.18 ±  4%  perf-profile.children.cycles-pp.f2fs_inplace_write_data
      0.10 ± 10%      +0.1        0.17 ±  8%  perf-profile.children.cycles-pp.wait_for_completion_io
      0.17 ±  8%      +0.1        0.24 ±  7%  perf-profile.children.cycles-pp.xas_load
      0.08 ± 14%      +0.1        0.15 ±  4%  perf-profile.children.cycles-pp.__might_sleep
      0.10 ±  9%      +0.1        0.17 ±  4%  perf-profile.children.cycles-pp.__is_cp_guaranteed
      1.05 ±  2%      +0.1        1.13 ±  3%  perf-profile.children.cycles-pp.smp_apic_timer_interrupt
      0.14 ± 10%      +0.1        0.22        perf-profile.children.cycles-pp.iov_iter_copy_from_user_atomic
      0.14 ±  8%      +0.1        0.21 ±  7%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.03 ±100%      +0.1        0.11 ±  6%  perf-profile.children.cycles-pp.f2fs_lookup_extent_cache
      0.14 ±  3%      +0.1        0.23 ±  4%  perf-profile.children.cycles-pp.read_node_page
      0.57 ±  2%      +0.1        0.65 ±  3%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.13 ± 11%      +0.1        0.22 ±  5%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.12 ± 14%      +0.1        0.20 ±  7%  perf-profile.children.cycles-pp.mempool_alloc
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.md_submit_flush_data
      1.15 ±  2%      +0.1        1.24 ±  3%  perf-profile.children.cycles-pp.apic_timer_interrupt
      0.13 ±  3%      +0.1        0.22 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.15 ±  4%      +0.1        0.24 ±  9%  perf-profile.children.cycles-pp.mutex_lock
      0.14 ±  7%      +0.1        0.23 ±  3%  perf-profile.children.cycles-pp.__bio_alloc
      0.00            +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.f2fs_wait_on_page_writeback
      0.16 ±  7%      +0.1        0.27 ±  3%  perf-profile.children.cycles-pp.f2fs_get_dnode_of_data
      0.15 ±  8%      +0.1        0.27 ±  6%  perf-profile.children.cycles-pp.bio_alloc_bioset
      0.09 ±  8%      +0.1        0.21 ± 23%  perf-profile.children.cycles-pp.f2fs_preallocate_blocks
      0.22 ±  3%      +0.1        0.34 ±  6%  perf-profile.children.cycles-pp.find_get_entry
      0.23 ±  7%      +0.1        0.35        perf-profile.children.cycles-pp.f2fs_set_data_page_dirty
      0.27            +0.1        0.39 ±  4%  perf-profile.children.cycles-pp.f2fs_is_valid_blkaddr
      0.01 ±173%      +0.1        0.14 ±  9%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.07 ±  7%      +0.1        0.19 ±  8%  perf-profile.children.cycles-pp.load_balance
      0.21 ± 12%      +0.1        0.34 ±  5%  perf-profile.children.cycles-pp.xas_find_marked
      0.16 ±  7%      +0.1        0.29 ±  3%  perf-profile.children.cycles-pp.brd_lookup_page
      0.08 ±  8%      +0.1        0.21 ±  4%  perf-profile.children.cycles-pp.newidle_balance
      0.01 ±173%      +0.1        0.15 ±  5%  perf-profile.children.cycles-pp.find_busiest_group
      0.07 ± 11%      +0.1        0.21 ±  3%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.29 ±  4%      +0.1        0.43 ±  4%  perf-profile.children.cycles-pp.lseek64
      0.00            +0.1        0.14 ± 32%  perf-profile.children.cycles-pp.f2fs_convert_inline_inode
      0.12 ±  4%      +0.1        0.27 ±  5%  perf-profile.children.cycles-pp.up_write
      0.27 ±  4%      +0.1        0.41 ±  5%  perf-profile.children.cycles-pp.update_sit_entry
      0.08 ± 10%      +0.1        0.23 ±  6%  perf-profile.children.cycles-pp.__wake_up_common
      0.01 ±173%      +0.1        0.16 ± 10%  perf-profile.children.cycles-pp.preempt_schedule_common
      2.22 ±  2%      +0.2        2.38        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.48 ±  9%      +0.2        0.65 ±  4%  perf-profile.children.cycles-pp.process_one_work
      0.12 ±  7%      +0.2        0.28 ±  8%  perf-profile.children.cycles-pp._cond_resched
      0.21 ±  5%      +0.2        0.39 ±  4%  perf-profile.children.cycles-pp.down_write
      0.39 ±  4%      +0.2        0.56        perf-profile.children.cycles-pp.__mutex_lock
      0.39 ± 10%      +0.2        0.56        perf-profile.children.cycles-pp.f2fs_submit_merged_ipu_write
      0.32 ±  8%      +0.2        0.50        perf-profile.children.cycles-pp.f2fs_write_end
      0.34 ±  2%      +0.2        0.52 ±  5%  perf-profile.children.cycles-pp.pagecache_get_page
      0.21 ± 10%      +0.2        0.40        perf-profile.children.cycles-pp.generic_make_request_checks
      0.16 ±  4%      +0.2        0.35 ±  8%  perf-profile.children.cycles-pp.submit_flushes
      0.35 ±  3%      +0.2        0.55 ±  3%  perf-profile.children.cycles-pp.__test_set_page_writeback
      0.29 ±  4%      +0.2        0.50 ±  2%  perf-profile.children.cycles-pp.test_clear_page_writeback
      0.38 ±  4%      +0.2        0.58        perf-profile.children.cycles-pp.__get_node_page
      0.30 ±  3%      +0.2        0.51 ±  2%  perf-profile.children.cycles-pp.end_page_writeback
      0.15            +0.2        0.36        perf-profile.children.cycles-pp.__wake_up_common_lock
      0.30 ±  3%      +0.2        0.51 ±  2%  perf-profile.children.cycles-pp.f2fs_set_node_page_dirty
      0.20 ±  7%      +0.2        0.42 ±  3%  perf-profile.children.cycles-pp.__queue_work
      0.37 ±  5%      +0.2        0.60 ±  3%  perf-profile.children.cycles-pp.clear_page_erms
      0.38 ±  4%      +0.2        0.61 ±  3%  perf-profile.children.cycles-pp.prep_new_page
      0.36 ±  5%      +0.2        0.59        perf-profile.children.cycles-pp.__set_page_dirty_nobuffers
      0.51 ±  2%      +0.2        0.74        perf-profile.children.cycles-pp.down_read
      0.28            +0.2        0.52 ±  2%  perf-profile.children.cycles-pp.f2fs_update_data_blkaddr
      0.28 ±  2%      +0.2        0.53 ±  2%  perf-profile.children.cycles-pp.f2fs_set_data_blkaddr
      0.71 ±  2%      +0.2        0.96 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      0.21 ±  7%      +0.2        0.45 ±  2%  perf-profile.children.cycles-pp.queue_work_on
      1.52 ±  4%      +0.3        1.78 ±  3%  perf-profile.children.cycles-pp.find_get_pages_range_tag
      1.54 ±  4%      +0.3        1.79 ±  3%  perf-profile.children.cycles-pp.pagevec_lookup_range_tag
      0.59 ±  8%      +0.3        0.86 ±  4%  perf-profile.children.cycles-pp.worker_thread
      0.22 ±  7%      +0.3        0.49 ±  2%  perf-profile.children.cycles-pp.md_flush_request
      0.47 ±  3%      +0.3        0.75 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.75 ±  4%      +0.3        1.05        perf-profile.children.cycles-pp.swake_up_locked
      0.52 ±  3%      +0.3        0.82 ±  2%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      0.77 ±  5%      +0.3        1.07        perf-profile.children.cycles-pp.complete
     10.60            +0.4       10.96        perf-profile.children.cycles-pp.__submit_merged_write_cond
      0.63 ±  2%      +0.4        1.00 ±  2%  perf-profile.children.cycles-pp.brd_insert_page
      0.37 ±  9%      +0.4        0.75 ±  2%  perf-profile.children.cycles-pp.raid0_make_request
      0.51 ±  2%      +0.4        0.91        perf-profile.children.cycles-pp.f2fs_write_end_io
      0.41 ±  4%      +0.4        0.81 ±  4%  perf-profile.children.cycles-pp.submit_bio_wait
      0.41 ±  8%      +0.4        0.82 ±  2%  perf-profile.children.cycles-pp.md_handle_request
      0.48 ±  3%      +0.4        0.89        perf-profile.children.cycles-pp.schedule_timeout
      0.45 ±  3%      +0.4        0.88 ±  3%  perf-profile.children.cycles-pp.__submit_flush_wait
      0.49 ±  6%      +0.5        0.96        perf-profile.children.cycles-pp.md_make_request
      0.49 ±  6%      +0.5        0.98        perf-profile.children.cycles-pp.wait_for_completion
      0.74 ±  4%      +0.5        1.25        perf-profile.children.cycles-pp.f2fs_write_begin
      1.14 ±  3%      +0.7        1.84        perf-profile.children.cycles-pp.brd_do_bvec
      0.73 ±  6%      +0.7        1.47 ±  5%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.75 ±  7%      +0.8        1.51 ±  5%  perf-profile.children.cycles-pp.f2fs_space_for_roll_forward
      0.89 ±  4%      +0.8        1.69 ±  2%  perf-profile.children.cycles-pp.f2fs_issue_flush
      1.30 ±  4%      +0.8        2.14        perf-profile.children.cycles-pp.generic_perform_write
      1.45 ±  4%      +0.9        2.32        perf-profile.children.cycles-pp.__generic_file_write_iter
      0.98 ±  2%      +0.9        1.89 ±  2%  perf-profile.children.cycles-pp.issue_flush_thread
      1.74 ±  2%      +1.2        2.89        perf-profile.children.cycles-pp.brd_make_request
      1.58 ±  4%      +1.2        2.76 ±  2%  perf-profile.children.cycles-pp.ret_from_fork
      1.58 ±  4%      +1.2        2.76 ±  2%  perf-profile.children.cycles-pp.kthread
      2.38            +1.2        3.58 ±  2%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      1.81 ±  2%      +1.3        3.08        perf-profile.children.cycles-pp.__submit_merged_bio
      2.46 ±  3%      +1.8        4.27        perf-profile.children.cycles-pp.generic_make_request
      2.47 ±  3%      +1.8        4.29        perf-profile.children.cycles-pp.submit_bio
     49.92            +3.1       53.02        perf-profile.children.cycles-pp.f2fs_do_sync_file
     51.63            +4.2       55.84        perf-profile.children.cycles-pp.f2fs_file_write_iter
     51.68            +4.2       55.91        perf-profile.children.cycles-pp.new_sync_write
     51.91            +4.3       56.24        perf-profile.children.cycles-pp.vfs_write
     51.94            +4.4       56.30        perf-profile.children.cycles-pp.ksys_write
     52.61            +4.6       57.24        perf-profile.children.cycles-pp.write
     52.63            +4.6       57.27        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     52.61            +4.6       57.25        perf-profile.children.cycles-pp.do_syscall_64
      2.44            +4.8        7.23        perf-profile.children.cycles-pp.f2fs_do_write_node_page
      3.92 ± 10%      +4.8        8.73 ±  2%  perf-profile.children.cycles-pp.f2fs_submit_page_write
      5.36 ±  8%     +11.9       17.27 ±  4%  perf-profile.children.cycles-pp.f2fs_do_write_data_page
      5.51 ±  8%     +12.0       17.53 ±  3%  perf-profile.children.cycles-pp.f2fs_write_single_data_page
      1.47 ±  2%     +12.4       13.92 ±  3%  perf-profile.children.cycles-pp.f2fs_allocate_data_block
      3.41 ± 11%     +12.8       16.22 ±  4%  perf-profile.children.cycles-pp.f2fs_outplace_write_data
      9.23 ±  5%     +14.3       23.56 ±  3%  perf-profile.children.cycles-pp.f2fs_write_cache_pages
      9.36 ±  5%     +14.4       23.75 ±  3%  perf-profile.children.cycles-pp.do_writepages
      9.35 ±  5%     +14.4       23.73 ±  3%  perf-profile.children.cycles-pp.f2fs_write_data_pages
      9.39 ±  5%     +14.4       23.79 ±  3%  perf-profile.children.cycles-pp.__filemap_fdatawrite_range
      9.48 ±  5%     +14.4       23.93 ±  3%  perf-profile.children.cycles-pp.file_write_and_wait_range
      5.53 ±  7%     +17.4       22.89 ±  2%  perf-profile.children.cycles-pp.do_write_page
     38.61            -4.8       33.85        perf-profile.self.cycles-pp.intel_idle
      2.66 ±  3%      -1.0        1.65        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.92            -0.2        0.68 ±  4%  perf-profile.self.cycles-pp.unwind_next_frame
      0.42 ±  6%      -0.2        0.19 ±  2%  perf-profile.self.cycles-pp.rwsem_down_read_slowpath
      0.39 ±  2%      -0.2        0.22 ±  5%  perf-profile.self.cycles-pp.__account_scheduler_latency
      0.45 ±  2%      -0.1        0.32 ±  6%  perf-profile.self.cycles-pp.__sched_text_start
      0.11 ±  3%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.rwsem_mark_wake
      0.30 ±  4%      -0.1        0.22 ±  3%  perf-profile.self.cycles-pp.update_load_avg
      0.11 ±  7%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.wake_up_q
      0.41 ±  3%      -0.1        0.33 ±  6%  perf-profile.self.cycles-pp.menu_select
      0.14 ±  8%      -0.1        0.08 ± 10%  perf-profile.self.cycles-pp.update_cfs_rq_h_load
      0.23 ±  7%      -0.1        0.18 ±  8%  perf-profile.self.cycles-pp.stack_trace_consume_entry_nosched
      0.15 ±  6%      -0.1        0.10 ± 11%  perf-profile.self.cycles-pp.update_cfs_group
      0.40 ±  4%      -0.1        0.35        perf-profile.self.cycles-pp.__orc_find
      0.13 ±  5%      -0.1        0.08 ± 15%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.44 ±  3%      -0.0        0.39 ±  2%  perf-profile.self.cycles-pp.try_to_wake_up
      0.16 ±  7%      -0.0        0.11 ±  7%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.12 ±  5%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.wake_q_add
      0.08 ±  5%      -0.0        0.04 ± 57%  perf-profile.self.cycles-pp.cpuacct_charge
      0.17 ±  6%      -0.0        0.14 ±  8%  perf-profile.self.cycles-pp.do_idle
      0.20 ±  7%      -0.0        0.16 ±  5%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.14 ±  7%      -0.0        0.10 ±  7%  perf-profile.self.cycles-pp.native_write_msr
      0.17 ±  6%      -0.0        0.14 ±  9%  perf-profile.self.cycles-pp.__list_add_valid
      0.20 ±  9%      -0.0        0.17 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.16 ±  5%      -0.0        0.13 ±  7%  perf-profile.self.cycles-pp.set_next_entity
      0.12 ±  6%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.enqueue_entity
      0.09 ± 14%      -0.0        0.07 ± 13%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.18 ±  6%      -0.0        0.15 ±  8%  perf-profile.self.cycles-pp.__switch_to_asm
      0.15 ±  2%      -0.0        0.12 ±  6%  perf-profile.self.cycles-pp.___perf_sw_event
      0.11 ±  7%      -0.0        0.09 ±  9%  perf-profile.self.cycles-pp.stack_trace_save_tsk
      0.19 ±  2%      -0.0        0.17 ±  4%  perf-profile.self.cycles-pp.update_rq_clock
      0.18 ±  3%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.update_curr
      0.19 ±  4%      -0.0        0.17 ±  4%  perf-profile.self.cycles-pp.native_sched_clock
      0.10 ±  7%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.finish_task_switch
      0.09 ± 11%      -0.0        0.07 ± 10%  perf-profile.self.cycles-pp.kernel_text_address
      0.10 ±  5%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.update_stats_enqueue_sleeper
      0.07 ± 10%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.schedule
      0.06 ±  7%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.write
      0.10 ±  8%      +0.0        0.12 ±  8%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.10 ±  7%      +0.0        0.12 ±  8%  perf-profile.self.cycles-pp.__test_set_page_writeback
      0.05 ±  8%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.f2fs_get_node_info
      0.12 ±  3%      +0.0        0.15 ±  7%  perf-profile.self.cycles-pp.read_tsc
      0.07 ± 14%      +0.0        0.10        perf-profile.self.cycles-pp.f2fs_write_cache_pages
      0.06 ± 13%      +0.0        0.09        perf-profile.self.cycles-pp.xas_set_mark
      0.05 ±  9%      +0.0        0.08 ± 10%  perf-profile.self.cycles-pp.locate_dirty_segment
      0.05 ±  8%      +0.0        0.08 ± 10%  perf-profile.self.cycles-pp.test_clear_page_writeback
      0.08 ±  5%      +0.0        0.11 ±  9%  perf-profile.self.cycles-pp.kmem_cache_free
      0.04 ± 58%      +0.0        0.07 ± 17%  perf-profile.self.cycles-pp.generic_make_request
      0.04 ± 60%      +0.0        0.07 ± 11%  perf-profile.self.cycles-pp.__get_segment_type
      0.07 ±  5%      +0.0        0.11 ±  8%  perf-profile.self.cycles-pp.unlock_page
      0.07 ±  6%      +0.0        0.10 ±  7%  perf-profile.self.cycles-pp.f2fs_do_write_data_page
      0.18 ±  7%      +0.0        0.22 ±  7%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      0.10 ± 12%      +0.0        0.14 ±  7%  perf-profile.self.cycles-pp.__write_node_page
      0.08 ±  6%      +0.0        0.11 ±  7%  perf-profile.self.cycles-pp.__mark_inode_dirty
      0.07            +0.0        0.11 ±  6%  perf-profile.self.cycles-pp.f2fs_set_node_page_dirty
      0.05 ±  8%      +0.0        0.09 ±  8%  perf-profile.self.cycles-pp.raid0_make_request
      0.07 ± 12%      +0.0        0.11 ±  6%  perf-profile.self.cycles-pp.f2fs_get_dnode_of_data
      0.11 ±  4%      +0.0        0.15 ±  4%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.07 ±  7%      +0.0        0.11 ±  6%  perf-profile.self.cycles-pp.md_make_request
      0.12 ±  8%      +0.0        0.17 ±  3%  perf-profile.self.cycles-pp.___might_sleep
      0.06 ± 11%      +0.0        0.11 ±  7%  perf-profile.self.cycles-pp.f2fs_write_single_data_page
      0.08 ± 11%      +0.0        0.12 ±  6%  perf-profile.self.cycles-pp.f2fs_issue_flush
      0.03 ±100%      +0.0        0.07 ± 17%  perf-profile.self.cycles-pp.__submit_merged_write_cond
      0.03 ±100%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.md_handle_request
      0.08 ±  8%      +0.1        0.13 ±  9%  perf-profile.self.cycles-pp.__get_node_page
      0.01 ±173%      +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.f2fs_write_end
      0.01 ±173%      +0.1        0.06 ± 13%  perf-profile.self.cycles-pp.account_page_dirtied
      0.01 ±173%      +0.1        0.06 ± 13%  perf-profile.self.cycles-pp.blk_throtl_bio
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.f2fs_write_inode
      0.09 ±  7%      +0.1        0.14 ±  7%  perf-profile.self.cycles-pp.f2fs_write_data_pages
      0.08 ±  5%      +0.1        0.14 ± 11%  perf-profile.self.cycles-pp.read_node_page
      0.10 ±  7%      +0.1        0.15 ±  7%  perf-profile.self.cycles-pp.xas_load
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.__bio_associate_blkg
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.bio_alloc_bioset
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.generic_perform_write
      0.05 ± 58%      +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.generic_make_request_checks
      0.00            +0.1        0.06 ± 14%  perf-profile.self.cycles-pp.f2fs_llseek
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.down_read_trylock
      0.01 ±173%      +0.1        0.07 ± 10%  perf-profile.self.cycles-pp.__set_page_dirty_nobuffers
      0.09 ±  7%      +0.1        0.15 ±  8%  perf-profile.self.cycles-pp.__has_merged_page
      0.09 ±  4%      +0.1        0.15 ± 12%  perf-profile.self.cycles-pp.f2fs_submit_page_write
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.issue_flush_thread
      0.15 ± 12%      +0.1        0.21 ±  4%  perf-profile.self.cycles-pp.f2fs_do_sync_file
      0.30 ±  7%      +0.1        0.36 ±  3%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.do_write_page
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.xas_clear_mark
      0.11 ± 10%      +0.1        0.17 ±  8%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.07 ± 10%      +0.1        0.14 ±  6%  perf-profile.self.cycles-pp.__might_sleep
      0.03 ±100%      +0.1        0.09 ±  8%  perf-profile.self.cycles-pp.mutex_unlock
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp._cond_resched
      0.13 ±  5%      +0.1        0.20 ±  5%  perf-profile.self.cycles-pp.find_get_entry
      0.12 ± 15%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.01 ±173%      +0.1        0.08        perf-profile.self.cycles-pp.f2fs_lookup_extent_cache
      0.10 ±  9%      +0.1        0.17 ±  3%  perf-profile.self.cycles-pp.__is_cp_guaranteed
      0.11 ±  7%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.f2fs_balance_fs
      0.13 ±  5%      +0.1        0.21 ±  8%  perf-profile.self.cycles-pp.mutex_lock
      0.08 ± 12%      +0.1        0.16 ±  6%  perf-profile.self.cycles-pp.f2fs_write_end_io
      0.08 ±  8%      +0.1        0.16 ±  7%  perf-profile.self.cycles-pp.f2fs_file_write_iter
      0.12 ±  8%      +0.1        0.20 ±  3%  perf-profile.self.cycles-pp.f2fs_write_begin
      0.12 ±  3%      +0.1        0.20 ±  5%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.13 ±  9%      +0.1        0.22 ±  5%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.03 ±100%      +0.1        0.11 ± 14%  perf-profile.self.cycles-pp.submit_flushes
      0.15 ±  5%      +0.1        0.24 ±  6%  perf-profile.self.cycles-pp.f2fs_allocate_data_block
      0.00            +0.1        0.10 ±  8%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.27            +0.1        0.39 ±  3%  perf-profile.self.cycles-pp.f2fs_is_valid_blkaddr
      0.21 ± 10%      +0.1        0.34 ±  5%  perf-profile.self.cycles-pp.xas_find_marked
      0.18 ±  6%      +0.1        0.32 ±  4%  perf-profile.self.cycles-pp.down_write
      0.12 ±  3%      +0.1        0.26 ±  4%  perf-profile.self.cycles-pp.up_write
      0.26 ±  5%      +0.1        0.39 ±  3%  perf-profile.self.cycles-pp.update_sit_entry
      0.70 ±  4%      +0.1        0.84 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.29 ±  2%      +0.2        1.44 ±  2%  perf-profile.self.cycles-pp.find_get_pages_range_tag
      0.24 ±  4%      +0.2        0.40 ±  6%  perf-profile.self.cycles-pp.do_syscall_64
      0.35 ±  6%      +0.2        0.55        perf-profile.self.cycles-pp.brd_do_bvec
      0.44            +0.2        0.65        perf-profile.self.cycles-pp.down_read
      0.37 ±  4%      +0.2        0.58 ±  3%  perf-profile.self.cycles-pp.clear_page_erms
      0.62            +0.3        0.87 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock
      0.34 ± 11%      +0.3        0.63 ±  6%  perf-profile.self.cycles-pp.__percpu_counter_sum
      1.31 ±  2%      +0.3        1.65 ±  6%  perf-profile.self.cycles-pp.rwsem_optimistic_spin
      2.17 ±  2%      +1.1        3.31        perf-profile.self.cycles-pp.rwsem_spin_on_owner





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Rong Chen


--v525F/vnNBtUxgKg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.6.0-11903-gca7f76e680745"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.6.0 Kernel Configuration
#

#
# Compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
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

CONFIG_PLUGIN_HOSTCC=""
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
# CONFIG_KUNIT_DRIVER_PE_TEST is not set
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
# CONFIG_DEBUG_INFO_BTF is not set
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

--v525F/vnNBtUxgKg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='aim7'
	export testcase='aim7'
	export category='benchmark'
	export job_origin='/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-cpx-4s1/aim7-fs-1brd.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-cpx-4s1'
	export tbox_group='lkp-cpx-4s1'
	export kconfig='x86_64-rhel-7.6'
	export submit_id='5efc84d71308f40d3e5aedd8'
	export job_file='/lkp/jobs/scheduled/lkp-cpx-4s1/aim7-performance-1BRD_48G-f2fs-200-sync_disk_rw-ucode=0x86000017-debian-x86_64-20191114.cgz-ca7f76e680745d3b8a386638045f85dac1c4-20200701-3390-1v71agf-2.yaml'
	export id='bd0432f3b7bdbcf873c335770210f9355a139fb9'
	export queuer_version='/lkp-src'
	export model='Cooper Lake'
	export nr_node=4
	export nr_cpu=192
	export memory='128G'
	export nr_hdd_partitions=
	export nr_ssd_partitions=2
	export hdd_partitions=
	export ssd_partitions='/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401H84P0IGN-part4
/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401H84P0IGN-part5'
	export swap_partitions=
	export rootfs_partition='/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401H84P0IGN-part3'
	export kernel_cmdline_hw='acpi_rsdp=0x693fd014'
	export brand=
	export commit='ca7f76e680745d3b8a386638045f85dac1c4b2f4'
	export need_kconfig_hw='CONFIG_IGB=y
CONFIG_SATA_AHCI'
	export ucode='0x86000017'
	export need_kconfig='CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV=y
CONFIG_BLOCK=y
CONFIG_F2FS_FS'
	export enqueue_time='2020-07-01 20:43:03 +0800'
	export _id='5efc84d71308f40d3e5aedd8'
	export _rt='/result/aim7/performance-1BRD_48G-f2fs-200-sync_disk_rw-ucode=0x86000017/lkp-cpx-4s1/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-9/ca7f76e680745d3b8a386638045f85dac1c4b2f4'
	export user='lkp'
	export compiler='gcc-9'
	export head_commit='5738b9d0c91e26c87c93a03972cc1a5a809d4af6'
	export base_commit='b3a9e3b9622ae10064826dccb4f7a52bd88c7407'
	export branch='linux-devel/devel-hourly-2020061608'
	export rootfs='debian-x86_64-20191114.cgz'
	export result_root='/result/aim7/performance-1BRD_48G-f2fs-200-sync_disk_rw-ucode=0x86000017/lkp-cpx-4s1/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-9/ca7f76e680745d3b8a386638045f85dac1c4b2f4/3'
	export scheduler_version='/lkp/lkp/.src-20200630-145836'
	export LKP_SERVER='inn'
	export arch='x86_64'
	export max_uptime=3600
	export initrd='/osimage/debian/debian-x86_64-20191114.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-cpx-4s1/aim7-performance-1BRD_48G-f2fs-200-sync_disk_rw-ucode=0x86000017-debian-x86_64-20191114.cgz-ca7f76e680745d3b8a386638045f85dac1c4-20200701-3390-1v71agf-2.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.6
branch=linux-devel/devel-hourly-2020061608
commit=ca7f76e680745d3b8a386638045f85dac1c4b2f4
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-9/ca7f76e680745d3b8a386638045f85dac1c4b2f4/vmlinuz-5.6.0-11903-gca7f76e680745
acpi_rsdp=0x693fd014
max_uptime=3600
RESULT_ROOT=/result/aim7/performance-1BRD_48G-f2fs-200-sync_disk_rw-ucode=0x86000017/lkp-cpx-4s1/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-9/ca7f76e680745d3b8a386638045f85dac1c4b2f4/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-7.6/gcc-9/ca7f76e680745d3b8a386638045f85dac1c4b2f4/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-20180403.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/lkp_2019-08-05.cgz,/osimage/deps/debian-x86_64-20180403.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/perf_20200325.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/perf-x86_64-3e08a95294a4-1_20200624.cgz,/osimage/deps/debian-x86_64-20180403.cgz/fs_2020-01-02.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/aim7-x86_64-1-1_20200318.cgz,/osimage/deps/debian-x86_64-20180403.cgz/mpstat_2020-01-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/vmstat_2020-01-07.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/sar-x86_64-e011d97-1_2020-01-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/hw_2020-01-02.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20191114.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.8.0-rc1'
	export repeat_to=4
	export queue_at_least_once=1
	export schedule_notify_address=
	export kernel='/pkg/linux/x86_64-rhel-7.6/gcc-9/ca7f76e680745d3b8a386638045f85dac1c4b2f4/vmlinuz-5.6.0-11903-gca7f76e680745'
	export dequeue_time='2020-07-01 21:03:01 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-cpx-4s1/aim7-performance-1BRD_48G-f2fs-200-sync_disk_rw-ucode=0x86000017-debian-x86_64-20191114.cgz-ca7f76e680745d3b8a386638045f85dac1c4-20200701-3390-1v71agf-2.cgz'

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

	run_setup nr_brd=1 ramdisk_size=51539607552 $LKP_SRC/setup/disk

	run_setup fs='f2fs' $LKP_SRC/setup/fs

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_monitor delay=15 $LKP_SRC/monitors/no-stdout/wrapper perf-profile
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
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='sync_disk_rw' load=200 $LKP_SRC/tests/wrapper aim7
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper perf-profile
	$LKP_SRC/stats/wrapper aim7
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

	$LKP_SRC/stats/wrapper time aim7.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--v525F/vnNBtUxgKg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/aim7-fs-1brd.yaml
suite: aim7
testcase: aim7
category: benchmark
perf-profile:
  delay: 15
disk: 1BRD_48G
fs: f2fs
aim7:
  test: sync_disk_rw
  load: 200
job_origin: "/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-cpx-4s1/aim7-fs-1brd.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-cpx-4s1
tbox_group: lkp-cpx-4s1
kconfig: x86_64-rhel-7.6
submit_id: 5efbe20658feaa22df93d55f
job_file: "/lkp/jobs/scheduled/lkp-cpx-4s1/aim7-performance-1BRD_48G-f2fs-200-sync_disk_rw-ucode=0x86000017-debian-x86_64-20191114.cgz-ca7f76e680745d3b8a386638045f85dac1c4-20200701-8927-t2pvj7-1.yaml"
id: cd7f737e90282efb9d6b8ce56cac627a003dfef7
queuer_version: "/lkp-src"

#! hosts/lkp-cpx-4s1
model: Cooper Lake
nr_node: 4
nr_cpu: 192
memory: 128G
nr_hdd_partitions: 
nr_ssd_partitions: 2
hdd_partitions: 
ssd_partitions:
- "/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401H84P0IGN-part4"
- "/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401H84P0IGN-part5"
swap_partitions: 
rootfs_partition: "/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401H84P0IGN-part3"
kernel_cmdline_hw: acpi_rsdp=0x693fd014
brand: 

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

#! include/category/ALL
cpufreq_governor: performance

#! include/queue/cyclic
commit: ca7f76e680745d3b8a386638045f85dac1c4b2f4

#! include/testbox/lkp-cpx-4s1
need_kconfig_hw:
- CONFIG_IGB=y
- CONFIG_SATA_AHCI
ucode: '0x86000017'

#! include/disk/nr_brd
need_kconfig:
- CONFIG_BLK_DEV_RAM=m
- CONFIG_BLK_DEV=y
- CONFIG_BLOCK=y
- CONFIG_F2FS_FS

#! include/fs/OTHERS
enqueue_time: 2020-07-01 09:08:22.499498597 +08:00
_id: 5efbe20a58feaa22df93d560
_rt: "/result/aim7/performance-1BRD_48G-f2fs-200-sync_disk_rw-ucode=0x86000017/lkp-cpx-4s1/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-9/ca7f76e680745d3b8a386638045f85dac1c4b2f4"

#! schedule options
user: lkp
compiler: gcc-9
head_commit: 5738b9d0c91e26c87c93a03972cc1a5a809d4af6
base_commit: b3a9e3b9622ae10064826dccb4f7a52bd88c7407
branch: linux-devel/devel-hourly-2020061608
rootfs: debian-x86_64-20191114.cgz
result_root: "/result/aim7/performance-1BRD_48G-f2fs-200-sync_disk_rw-ucode=0x86000017/lkp-cpx-4s1/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-9/ca7f76e680745d3b8a386638045f85dac1c4b2f4/0"
scheduler_version: "/lkp/lkp/.src-20200630-145836"
LKP_SERVER: inn
arch: x86_64
max_uptime: 3600
initrd: "/osimage/debian/debian-x86_64-20191114.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-cpx-4s1/aim7-performance-1BRD_48G-f2fs-200-sync_disk_rw-ucode=0x86000017-debian-x86_64-20191114.cgz-ca7f76e680745d3b8a386638045f85dac1c4-20200701-8927-t2pvj7-1.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-7.6
- branch=linux-devel/devel-hourly-2020061608
- commit=ca7f76e680745d3b8a386638045f85dac1c4b2f4
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-9/ca7f76e680745d3b8a386638045f85dac1c4b2f4/vmlinuz-5.6.0-11903-gca7f76e680745
- acpi_rsdp=0x693fd014
- max_uptime=3600
- RESULT_ROOT=/result/aim7/performance-1BRD_48G-f2fs-200-sync_disk_rw-ucode=0x86000017/lkp-cpx-4s1/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-9/ca7f76e680745d3b8a386638045f85dac1c4b2f4/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-7.6/gcc-9/ca7f76e680745d3b8a386638045f85dac1c4b2f4/modules.cgz"
bm_initrd: "/osimage/deps/debian-x86_64-20180403.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/lkp_2019-08-05.cgz,/osimage/deps/debian-x86_64-20180403.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/perf_20200325.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/perf-x86_64-3e08a95294a4-1_20200624.cgz,/osimage/deps/debian-x86_64-20180403.cgz/fs_2020-01-02.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/aim7-x86_64-1-1_20200318.cgz,/osimage/deps/debian-x86_64-20180403.cgz/mpstat_2020-01-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/vmstat_2020-01-07.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/sar-x86_64-e011d97-1_2020-01-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/hw_2020-01-02.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20191114.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20200618-180844/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.8.0-rc3-04072-g0f6f2b1fe9f21
repeat_to: 2
schedule_notify_address: 

#! user overrides
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-7.6/gcc-9/ca7f76e680745d3b8a386638045f85dac1c4b2f4/vmlinuz-5.6.0-11903-gca7f76e680745"
dequeue_time: 2020-07-01 10:24:05.287924865 +08:00

#! /lkp/lkp/.src-20200630-145836/include/site/inn
job_state: finished
loadavg: 160.08 177.96 113.61 1/1293 28017
start_time: '1593570313'
end_time: '1593571114'
version: "/lkp/lkp/.src-20200630-145912:60ef038d:2805bad30"

--v525F/vnNBtUxgKg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

 "modprobe" "-r" "brd"
 "modprobe" "brd" "rd_nr=1" "rd_size=50331648"
dmsetup remove_all
wipefs -a --force /dev/ram0
mkfs -t f2fs /dev/ram0
mkdir -p /fs/ram0
mount -t f2fs /dev/ram0 /fs/ram0

for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

echo "500 32000 128 512" > /proc/sys/kernel/sem
cat > workfile <<EOF
FILESIZE: 1M
POOLSIZE: 10M
10 sync_disk_rw
EOF
echo "/fs/ram0" > config

	(
		echo lkp-cpx-4s1
		echo sync_disk_rw

		echo 1
		echo 200
		echo 2
		echo 200
		echo 1
	) | ./multitask -t &

--v525F/vnNBtUxgKg--
