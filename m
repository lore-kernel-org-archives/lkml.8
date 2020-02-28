Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36358C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94492246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgB1Hpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 02:45:51 -0500
Received: from mga09.intel.com ([134.134.136.24]:58744 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbgB1Hpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 02:45:51 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 23:45:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,495,1574150400"; 
   d="yaml'?scan'208";a="385430126"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by orsmga004.jf.intel.com with ESMTP; 27 Feb 2020 23:45:27 -0800
Date:   Fri, 28 Feb 2020 15:45:19 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, lkp@lists.01.org
Subject: [locking/qspinlock] 93ee6cfe91:  aim7.jobs-per-min 83.6% improvement
Message-ID: <20200228074519.GO6548@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="f0PSjARDFl/vfYT5"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f0PSjARDFl/vfYT5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Greeting,

FYI, we noticed a 83.6% improvement of aim7.jobs-per-min due to commit:


commit: 93ee6cfe912a19a3faa62c5c28e2592f6711563c ("locking/qspinlock: Introduce CNA into the slow path of qspinlock")
https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git cna.2020.01.24a

in testcase: aim7
on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
with following parameters:

	disk: 4BRD_12G
	md: RAID1
	fs: btrfs
	test: disk_wrt
	load: 1500
	cpufreq_governor: performance
	ucode: 0x500002c

test-description: AIM7 is a traditional UNIX system level benchmark suite which is used to test and measure the performance of multiuser system.
test-url: https://sourceforge.net/projects/aimbench/files/aim-suite7/

In addition to that, the commit also has significant impact on the following tests:

+------------------+-----------------------------------------------------------------------+
| testcase: change | reaim: reaim.jobs_per_min 42.2% improvement                           |
| test machine     | 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory |
| test parameters  | cpufreq_governor=performance                                          |
|                  | nr_task=100%                                                          |
|                  | runtime=300s                                                          |
|                  | test=new_fserver                                                      |
|                  | ucode=0xb000038                                                       |
+------------------+-----------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/md/rootfs/tbox_group/test/testcase/ucode:
  gcc-7/performance/4BRD_12G/btrfs/x86_64-rhel-7.6/1500/RAID1/debian-x86_64-20191114.cgz/lkp-csl-2ap2/disk_wrt/aim7/0x500002c

commit: 
  c560e9d569 ("locking/qspinlock: Refactor the qspinlock slow path")
  93ee6cfe91 ("locking/qspinlock: Introduce CNA into the slow path of qspinlock")

c560e9d569c466f8 93ee6cfe912a19a3faa62c5c28e 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :4           25%           1:4     dmesg.WARNING:at#for_ip_swapgs_restore_regs_and_return_to_usermode/0x
           :4           25%           1:4     dmesg.WARNING:stack_recursion
         %stddev     %change         %stddev
             \          |                \  
     32395 ±  3%     +83.6%      59471        aim7.jobs-per-min
    278.31 ±  3%     -45.6%     151.45        aim7.time.elapsed_time
    278.31 ±  3%     -45.6%     151.45        aim7.time.elapsed_time.max
   3340724 ± 16%     -99.6%      14464        aim7.time.involuntary_context_switches
    294312 ±  4%     -64.6%     104318 ±  2%  aim7.time.minor_page_faults
     51018 ±  4%     -90.2%       4990        aim7.time.system_time
     14.86 ± 15%     -41.3%       8.72 ±  4%  aim7.time.user_time
   2074925           -37.6%    1293971        aim7.time.voluntary_context_switches
      5.24 ±  4%   +1482.1%      82.83        iostat.cpu.idle
     94.70           -81.9%      17.10        iostat.cpu.system
      3457 ± 13%     -83.9%     555.69 ± 49%  iostat.md0.wkB/s
      4.59 ±  4%     +78.0       82.59        mpstat.cpu.all.idle%
      0.00 ± 76%      +0.0        0.00 ± 28%  mpstat.cpu.all.soft%
     95.29           -78.0       17.29        mpstat.cpu.all.sys%
  11375384 ± 19%   +1662.9%  2.005e+08 ± 50%  cpuidle.C1.time
    134623 ± 16%    +854.9%    1285544 ± 45%  cpuidle.C1.usage
   5095761 ± 16%    +666.8%   39073692 ± 24%  cpuidle.C1E.usage
   1309862 ± 16%    +258.6%    4697562 ±  8%  cpuidle.POLL.time
     15496 ± 15%    +275.3%      58161 ±  4%  cpuidle.POLL.usage
      4.75 ±  9%   +1636.8%      82.50        vmstat.cpu.id
     94.25           -82.5%      16.50 ±  3%  vmstat.cpu.sy
      3458 ± 13%     -84.0%     555.00 ± 49%  vmstat.io.bo
   1683290           -19.1%    1362392        vmstat.memory.cache
    345.75 ±  8%     -90.7%      32.25        vmstat.procs.r
     24051 ±  2%     -15.0%      20438 ±  2%  vmstat.system.cs
    398730            -3.2%     385893        vmstat.system.in
      1504           -80.1%     299.25        turbostat.Avg_MHz
     95.39           -76.2       19.14        turbostat.Busy%
     74800 ± 16%    +798.0%     671737 ± 46%  turbostat.C1
      0.01            +0.3        0.35 ± 52%  turbostat.C1%
   2626093 ± 16%    +659.6%   19947401 ± 24%  turbostat.C1E
      1.88 ± 34%     +24.5       26.37 ± 53%  turbostat.C1E%
      4.47 ±  6%   +1693.5%      80.17        turbostat.CPU%c1
     61.75           -17.0%      51.25        turbostat.CoreTmp
  57019097 ±  3%     -46.8%   30340489        turbostat.IRQ
     61.75           -17.8%      50.75        turbostat.PkgTmp
    262.02           -34.8%     170.87        turbostat.PkgWatt
    748119 ±  2%     -44.2%     417663        meminfo.Active
    565429 ±  2%     -33.2%     377560        meminfo.Active(anon)
    182689 ±  8%     -78.0%      40102        meminfo.Active(file)
    173125           -24.5%     130775 ±  2%  meminfo.AnonHugePages
   1565113           -20.6%    1242188        meminfo.Cached
    177022 ±  8%     -81.2%      33195        meminfo.Dirty
     39049 ±  2%     -33.7%      25907        meminfo.Inactive
     34897 ±  3%     -31.8%      23793        meminfo.Inactive(anon)
      4152 ± 11%     -49.1%       2112 ± 23%  meminfo.Inactive(file)
     38844 ±  3%     -36.3%      24746        meminfo.Mapped
   4363847 ±  4%     -24.2%    3309919        meminfo.Memused
    278276 ±  4%     -70.2%      83048 ±  5%  meminfo.Shmem
     17120 ±  6%     +33.1%      22789        meminfo.max_used_kB
    448.75 ±  9%     -51.7%     216.75 ± 12%  slabinfo.biovec-max.active_objs
    472.25 ±  9%     -53.0%     222.00 ± 12%  slabinfo.biovec-max.num_objs
      1040 ± 22%     -85.1%     155.00 ± 33%  slabinfo.btrfs_ordered_extent.active_objs
      1040 ± 22%     -85.1%     155.00 ± 33%  slabinfo.btrfs_ordered_extent.num_objs
      9398 ±  9%     -48.5%       4844 ± 18%  slabinfo.dmaengine-unmap-16.active_objs
    225.75 ±  9%     -48.7%     115.75 ± 18%  slabinfo.dmaengine-unmap-16.active_slabs
      9498 ±  9%     -48.6%       4881 ± 18%  slabinfo.dmaengine-unmap-16.num_objs
    225.75 ±  9%     -48.7%     115.75 ± 18%  slabinfo.dmaengine-unmap-16.num_slabs
      6108 ±  9%     +34.2%       8199 ± 10%  slabinfo.eventpoll_pwq.active_objs
      6108 ±  9%     +34.2%       8199 ± 10%  slabinfo.eventpoll_pwq.num_objs
      9942           -17.2%       8233 ±  5%  slabinfo.files_cache.active_objs
      9942           -17.2%       8233 ±  5%  slabinfo.files_cache.num_objs
     13854 ±  5%     -12.4%      12135        slabinfo.kmalloc-192.active_objs
     13898 ±  5%     -12.3%      12185        slabinfo.kmalloc-192.num_objs
      5187 ±  8%     +16.7%       6053 ±  8%  slabinfo.kmalloc-rcl-64.active_objs
      5187 ±  8%     +16.7%       6053 ±  8%  slabinfo.kmalloc-rcl-64.num_objs
      2427 ± 13%     -41.8%       1413 ±  9%  slabinfo.mnt_cache.active_objs
      2427 ± 13%     -41.8%       1413 ±  9%  slabinfo.mnt_cache.num_objs
    282.75 ± 26%     -32.4%     191.25 ± 38%  slabinfo.nfs_read_data.active_objs
    282.75 ± 26%     -32.4%     191.25 ± 38%  slabinfo.nfs_read_data.num_objs
      8575           -12.8%       7474 ±  4%  slabinfo.signal_cache.active_objs
      8605           -12.9%       7496 ±  4%  slabinfo.signal_cache.num_objs
     12251 ±  2%     -14.1%      10525 ±  4%  slabinfo.task_delay_info.active_objs
     12251 ±  2%     -14.1%      10525 ±  4%  slabinfo.task_delay_info.num_objs
    141444 ±  2%     -33.3%      94401        proc-vmstat.nr_active_anon
     45727 ±  7%     -79.0%       9592 ±  3%  proc-vmstat.nr_active_file
     44306 ±  8%     -82.4%       7809 ±  5%  proc-vmstat.nr_dirty
    391553           -20.8%     309919        proc-vmstat.nr_file_pages
      8606 ±  2%     -30.9%       5948        proc-vmstat.nr_inactive_anon
      1037 ± 11%     -49.1%     528.00 ± 23%  proc-vmstat.nr_inactive_file
      9654           -34.6%       6311        proc-vmstat.nr_mapped
     69552 ±  4%     -70.2%      20751 ±  5%  proc-vmstat.nr_shmem
     30127            -2.1%      29497        proc-vmstat.nr_slab_reclaimable
     84580            -3.0%      82007        proc-vmstat.nr_slab_unreclaimable
    241669 ± 10%     -91.1%      21553 ± 49%  proc-vmstat.nr_written
    141444 ±  2%     -33.3%      94401        proc-vmstat.nr_zone_active_anon
     45727 ±  7%     -79.0%       9592 ±  3%  proc-vmstat.nr_zone_active_file
      8606 ±  2%     -30.9%       5948        proc-vmstat.nr_zone_inactive_anon
      1037 ± 11%     -49.1%     528.00 ± 23%  proc-vmstat.nr_zone_inactive_file
     43552 ±  8%     -88.3%       5075 ±  3%  proc-vmstat.nr_zone_write_pending
    223150 ±  7%     -85.5%      32421 ± 11%  proc-vmstat.numa_hint_faults
    167848 ±  8%     -91.2%      14848 ± 20%  proc-vmstat.numa_hint_faults_local
  39866528            -1.5%   39282848        proc-vmstat.numa_hit
  39770263            -1.5%   39189499        proc-vmstat.numa_local
     96265            -3.0%      93349        proc-vmstat.numa_other
     34022 ± 14%     -44.2%      18977 ± 13%  proc-vmstat.numa_pages_migrated
    253833 ±  2%     -80.8%      48682 ± 33%  proc-vmstat.numa_pte_updates
   2941646 ±  2%     -13.0%    2558709        proc-vmstat.pgactivate
  40029529            -1.4%   39481312        proc-vmstat.pgalloc_normal
   1265757 ±  3%     -47.7%     662610        proc-vmstat.pgfault
     34022 ± 14%     -44.2%      18977 ± 13%  proc-vmstat.pgmigrate_success
    966501 ± 10%     -91.1%      86003 ± 49%  proc-vmstat.pgpgout
    211651 ± 19%     -65.4%      73234 ± 81%  numa-meminfo.node0.Active
    165517 ± 26%     -61.2%      64262 ± 93%  numa-meminfo.node0.Active(anon)
     46133 ±  8%     -80.6%       8971 ±  4%  numa-meminfo.node0.Active(file)
    101028 ± 35%     -82.2%      17997 ±155%  numa-meminfo.node0.AnonHugePages
    164749 ± 26%     -61.8%      62888 ± 95%  numa-meminfo.node0.AnonPages
     44163 ±  8%     -82.4%       7766 ±  5%  numa-meminfo.node0.Dirty
    335737 ±  4%     -10.2%     301415 ±  6%  numa-meminfo.node0.FilePages
      2859 ±131%    +268.0%      10523 ± 58%  numa-meminfo.node0.Inactive(anon)
      1390 ± 27%     -66.3%     469.00 ± 84%  numa-meminfo.node0.Inactive(file)
     45553 ±  9%     -79.6%       9290 ± 15%  numa-meminfo.node1.Active(file)
     44204 ±  8%     -82.8%       7608 ±  5%  numa-meminfo.node1.Dirty
    321574 ±  4%     -12.1%     282641        numa-meminfo.node1.FilePages
      8118 ± 31%     -42.3%       4687        numa-meminfo.node1.Mapped
     45396 ±  6%     -79.7%       9219 ± 13%  numa-meminfo.node2.Active(file)
     44380 ±  8%     -83.2%       7449 ±  6%  numa-meminfo.node2.Dirty
    337300           -12.7%     294405 ±  4%  numa-meminfo.node2.FilePages
     15508 ± 42%     -62.9%       5750 ± 87%  numa-meminfo.node2.Inactive
      9570 ± 27%     -36.7%       6056 ± 39%  numa-meminfo.node2.Mapped
     16185 ± 40%     -61.5%       6239 ± 78%  numa-meminfo.node2.Shmem
    307623 ±  5%     -58.6%     127270 ± 62%  numa-meminfo.node3.Active
    262305 ±  5%     -55.2%     117429 ± 66%  numa-meminfo.node3.Active(anon)
     45317 ±  8%     -78.3%       9840 ± 17%  numa-meminfo.node3.Active(file)
     43851 ±  8%     -83.2%       7365 ±  8%  numa-meminfo.node3.Dirty
    571032 ±  3%     -37.0%     359594 ±  4%  numa-meminfo.node3.FilePages
     15042 ± 24%     -54.6%       6823 ± 39%  numa-meminfo.node3.Inactive
     14063 ± 27%     -57.3%       5999 ± 43%  numa-meminfo.node3.Inactive(anon)
     12501 ±  6%     -47.6%       6553 ± 37%  numa-meminfo.node3.Mapped
    253615 ±  5%     -75.5%      62067 ± 10%  numa-meminfo.node3.Shmem
    267737 ±  2%      +4.6%     279944 ±  5%  numa-meminfo.node3.Unevictable
     41409 ± 26%     -61.2%      16066 ± 92%  numa-vmstat.node0.nr_active_anon
     11542 ±  8%     -81.3%       2160 ±  5%  numa-vmstat.node0.nr_active_file
     41217 ± 26%     -61.9%      15723 ± 95%  numa-vmstat.node0.nr_anon_pages
     11049 ±  8%     -83.4%       1839        numa-vmstat.node0.nr_dirty
     83984 ±  4%     -10.4%      75251 ±  5%  numa-vmstat.node0.nr_file_pages
    714.50 ±131%    +268.2%       2630 ± 58%  numa-vmstat.node0.nr_inactive_anon
    347.50 ± 27%     -66.3%     117.00 ± 84%  numa-vmstat.node0.nr_inactive_file
     29536 ±  9%     -89.7%       3056 ± 20%  numa-vmstat.node0.nr_written
     41409 ± 26%     -61.2%      16066 ± 92%  numa-vmstat.node0.nr_zone_active_anon
     11542 ±  8%     -81.3%       2163 ±  5%  numa-vmstat.node0.nr_zone_active_file
    714.50 ±131%    +268.2%       2630 ± 58%  numa-vmstat.node0.nr_zone_inactive_anon
    347.50 ± 27%     -66.3%     117.00 ± 84%  numa-vmstat.node0.nr_zone_inactive_file
     10889 ±  9%     -88.8%       1224        numa-vmstat.node0.nr_zone_write_pending
     11418 ±  9%     -80.7%       2198 ± 19%  numa-vmstat.node1.nr_active_file
     11078 ±  8%     -84.0%       1776 ±  4%  numa-vmstat.node1.nr_dirty
     80427 ±  4%     -12.1%      70660 ±  2%  numa-vmstat.node1.nr_file_pages
      2034 ± 30%     -42.4%       1172        numa-vmstat.node1.nr_mapped
     28679 ± 14%     -90.8%       2650 ± 56%  numa-vmstat.node1.nr_written
     11419 ±  9%     -80.8%       2196 ± 19%  numa-vmstat.node1.nr_zone_active_file
     10904 ±  8%     -89.2%       1172 ±  3%  numa-vmstat.node1.nr_zone_write_pending
     11406 ±  7%     -80.1%       2265 ± 15%  numa-vmstat.node2.nr_active_file
     11145 ±  8%     -83.6%       1829 ±  6%  numa-vmstat.node2.nr_dirty
     84396 ±  2%     -12.7%      73706 ±  4%  numa-vmstat.node2.nr_file_pages
      2428 ± 26%     -36.4%       1545 ± 37%  numa-vmstat.node2.nr_mapped
      4046 ± 40%     -61.4%       1560 ± 78%  numa-vmstat.node2.nr_shmem
     28498 ± 14%     -89.8%       2915 ± 53%  numa-vmstat.node2.nr_written
     11406 ±  7%     -80.1%       2266 ± 15%  numa-vmstat.node2.nr_zone_active_file
     11021 ±  8%     -88.7%       1243 ±  5%  numa-vmstat.node2.nr_zone_write_pending
     65513 ±  5%     -55.2%      29354 ± 66%  numa-vmstat.node3.nr_active_anon
     11390 ±  8%     -78.8%       2417 ±  8%  numa-vmstat.node3.nr_active_file
     11034 ±  8%     -83.8%       1792 ±  4%  numa-vmstat.node3.nr_dirty
    142818 ±  3%     -37.0%      89958 ±  4%  numa-vmstat.node3.nr_file_pages
      3562 ± 27%     -57.9%       1500 ± 43%  numa-vmstat.node3.nr_inactive_anon
      3216 ±  8%     -46.0%       1738 ± 37%  numa-vmstat.node3.nr_mapped
     63375 ±  5%     -75.5%      15506 ± 10%  numa-vmstat.node3.nr_shmem
     66934 ±  2%      +4.6%      69985 ±  5%  numa-vmstat.node3.nr_unevictable
     26246 ±  8%     -87.8%       3205 ± 43%  numa-vmstat.node3.nr_written
     65513 ±  5%     -55.2%      29354 ± 66%  numa-vmstat.node3.nr_zone_active_anon
     11389 ±  8%     -78.8%       2415 ±  8%  numa-vmstat.node3.nr_zone_active_file
      3562 ± 27%     -57.9%       1500 ± 43%  numa-vmstat.node3.nr_zone_inactive_anon
     66934 ±  2%      +4.6%      69985 ±  5%  numa-vmstat.node3.nr_zone_unevictable
     10862 ±  8%     -89.0%       1198 ±  2%  numa-vmstat.node3.nr_zone_write_pending
      2.32 ± 20%    +292.4%       9.11 ± 22%  perf-stat.i.MPKI
 1.207e+10           -59.7%  4.861e+09 ±  2%  perf-stat.i.branch-instructions
      0.35 ± 20%      +0.4        0.73 ± 27%  perf-stat.i.branch-miss-rate%
  21696037 ±  3%      +6.8%   23177401 ±  4%  perf-stat.i.branch-misses
     53.53           -46.9        6.60 ±  8%  perf-stat.i.cache-miss-rate%
  47756443 ±  5%     -77.7%   10672477 ±  3%  perf-stat.i.cache-misses
  88663230 ±  3%    +108.1%  1.845e+08 ±  5%  perf-stat.i.cache-references
     23946 ±  2%     -14.4%      20509        perf-stat.i.context-switches
     10.84           -56.1%       4.76 ±  2%  perf-stat.i.cpi
 5.582e+11           -80.2%  1.103e+11        perf-stat.i.cpu-cycles
      2893 ±  2%     -76.6%     675.93 ±  5%  perf-stat.i.cpu-migrations
     11316 ±  5%     -10.6%      10120 ±  2%  perf-stat.i.cycles-between-cache-misses
    913670 ± 21%     -56.1%     400645 ± 27%  perf-stat.i.dTLB-load-misses
 1.273e+10           -49.9%  6.372e+09 ±  2%  perf-stat.i.dTLB-loads
 1.171e+09 ±  3%     +74.9%  2.049e+09        perf-stat.i.dTLB-stores
     78.52           -23.0       55.50 ±  2%  perf-stat.i.iTLB-load-miss-rate%
   5672933 ±  6%     +13.5%    6437917        perf-stat.i.iTLB-load-misses
   1535165 ±  8%    +233.6%    5121574 ±  2%  perf-stat.i.iTLB-loads
  4.99e+10           -53.8%  2.306e+10 ±  2%  perf-stat.i.instructions
      8661 ±  7%     -59.6%       3500 ±  2%  perf-stat.i.instructions-per-iTLB-miss
      0.10          +111.0%       0.22 ±  2%  perf-stat.i.ipc
      4471            -5.9%       4206        perf-stat.i.minor-faults
     94.58            -8.1       86.44        perf-stat.i.node-load-miss-rate%
  11292088 ±  2%     -79.6%    2299857 ±  2%  perf-stat.i.node-load-misses
    628056           -39.5%     379872        perf-stat.i.node-loads
     93.94           -31.9       62.00        perf-stat.i.node-store-miss-rate%
   6708354 ±  3%     -89.1%     729297        perf-stat.i.node-store-misses
    399721 ±  2%     +18.6%     473897 ±  2%  perf-stat.i.node-stores
      4471            -5.9%       4206        perf-stat.i.page-faults
      1.77 ±  3%    +352.5%       8.00 ±  4%  perf-stat.overall.MPKI
      0.18 ±  3%      +0.3        0.47 ±  5%  perf-stat.overall.branch-miss-rate%
     54.05 ±  2%     -48.3        5.79 ±  4%  perf-stat.overall.cache-miss-rate%
     11.20           -57.3%       4.79        perf-stat.overall.cpi
     11748 ±  5%     -11.8%      10362 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.00 ± 10%      -0.0        0.00 ± 34%  perf-stat.overall.dTLB-store-miss-rate%
     79.05           -23.3       55.72        perf-stat.overall.iTLB-load-miss-rate%
      8879 ±  7%     -59.6%       3584 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
      0.09          +134.0%       0.21        perf-stat.overall.ipc
     94.73            -8.9       85.81        perf-stat.overall.node-load-miss-rate%
     94.38           -33.8       60.60        perf-stat.overall.node-store-miss-rate%
 1.215e+10           -60.1%  4.843e+09 ±  2%  perf-stat.ps.branch-instructions
  21275967 ±  3%      +7.8%   22926589 ±  4%  perf-stat.ps.branch-misses
  48010577 ±  5%     -77.9%   10616387 ±  3%  perf-stat.ps.cache-misses
  88779431 ±  3%    +107.0%  1.837e+08 ±  5%  perf-stat.ps.cache-references
     24101 ±  2%     -15.2%      20439        perf-stat.ps.context-switches
 5.624e+11           -80.5%  1.099e+11        perf-stat.ps.cpu-cycles
      2911 ±  2%     -76.9%     672.69 ±  5%  perf-stat.ps.cpu-migrations
    917617 ± 20%     -56.9%     395208 ± 27%  perf-stat.ps.dTLB-load-misses
 1.281e+10           -50.4%  6.349e+09 ±  2%  perf-stat.ps.dTLB-loads
 1.175e+09 ±  3%     +73.7%  2.041e+09        perf-stat.ps.dTLB-stores
   5684324 ±  6%     +12.8%    6409782        perf-stat.ps.iTLB-load-misses
   1504571 ±  8%    +238.6%    5094293 ±  2%  perf-stat.ps.iTLB-loads
 5.022e+10           -54.3%  2.297e+10 ±  2%  perf-stat.ps.instructions
      4400            -5.5%       4157        perf-stat.ps.minor-faults
  11368274 ±  2%     -79.9%    2290171 ±  2%  perf-stat.ps.node-load-misses
    632109           -40.1%     378433        perf-stat.ps.node-loads
   6759088 ±  3%     -89.3%     726505        perf-stat.ps.node-store-misses
    402131 ±  2%     +17.5%     472369 ±  2%  perf-stat.ps.node-stores
      4400            -5.5%       4157        perf-stat.ps.page-faults
   1.4e+13 ±  3%     -75.0%  3.505e+12 ±  2%  perf-stat.total.instructions
    110970           -91.1%       9830        sched_debug.cfs_rq:/.exec_clock.avg
    113625           -88.5%      13057 ±  3%  sched_debug.cfs_rq:/.exec_clock.max
    105078           -92.3%       8107 ±  2%  sched_debug.cfs_rq:/.exec_clock.min
    507.36 ±  5%     +40.6%     713.19 ±  2%  sched_debug.cfs_rq:/.exec_clock.stddev
      1038 ± 38%    -100.0%       0.00        sched_debug.cfs_rq:/.load.min
      0.70 ± 14%    -100.0%       0.00        sched_debug.cfs_rq:/.load_avg.min
  28052402           -98.5%     407273 ±  3%  sched_debug.cfs_rq:/.min_vruntime.avg
  29561913 ±  2%     -98.3%     516671        sched_debug.cfs_rq:/.min_vruntime.max
  26393399           -98.7%     336203 ±  4%  sched_debug.cfs_rq:/.min_vruntime.min
    538945 ±  8%     -94.7%      28799 ±  3%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.81           -80.7%       0.16        sched_debug.cfs_rq:/.nr_running.avg
      0.40 ± 35%    -100.0%       0.00        sched_debug.cfs_rq:/.nr_running.min
      0.11 ± 20%    +229.6%       0.35        sched_debug.cfs_rq:/.nr_running.stddev
      0.69 ± 15%    +234.5%       2.32 ±  5%  sched_debug.cfs_rq:/.nr_spread_over.avg
     20.15 ± 12%     -16.9%      16.75 ±  5%  sched_debug.cfs_rq:/.nr_spread_over.max
      4.20 ±  2%     -48.1%       2.18 ± 15%  sched_debug.cfs_rq:/.runnable_load_avg.avg
      0.45 ± 36%    -100.0%       0.00        sched_debug.cfs_rq:/.runnable_load_avg.min
      3.85 ± 14%    +100.5%       7.73 ± 40%  sched_debug.cfs_rq:/.runnable_load_avg.stddev
      1031 ± 37%    -100.0%       0.00        sched_debug.cfs_rq:/.runnable_weight.min
  -1303631          -103.6%      46673 ± 16%  sched_debug.cfs_rq:/.spread0.avg
  -2982462           -99.2%     -24312        sched_debug.cfs_rq:/.spread0.min
    541506 ±  8%     -94.7%      28786 ±  3%  sched_debug.cfs_rq:/.spread0.stddev
    844.61           -78.6%     181.06 ±  4%  sched_debug.cfs_rq:/.util_avg.avg
      2044 ± 10%     -43.6%       1153 ± 12%  sched_debug.cfs_rq:/.util_avg.max
    296.75 ±  4%    -100.0%       0.00        sched_debug.cfs_rq:/.util_avg.min
    938.77 ±  3%     -93.5%      61.07 ± 12%  sched_debug.cfs_rq:/.util_est_enqueued.avg
      2661 ±  5%     -70.9%     774.00 ±  4%  sched_debug.cfs_rq:/.util_est_enqueued.max
     91.70 ± 47%    -100.0%       0.00        sched_debug.cfs_rq:/.util_est_enqueued.min
    453.94 ±  5%     -67.6%     146.88 ±  8%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    432575           +90.3%     822988        sched_debug.cpu.avg_idle.avg
   1097148 ±  7%     +35.6%    1487358 ± 28%  sched_debug.cpu.avg_idle.max
    237093 ±  3%     +42.5%     337840 ±  4%  sched_debug.cpu.avg_idle.stddev
    164999           -36.4%     104928        sched_debug.cpu.clock.avg
    165102           -36.4%     104975        sched_debug.cpu.clock.max
    164879           -36.4%     104875        sched_debug.cpu.clock.min
     62.96 ±  8%     -54.6%      28.56 ±  4%  sched_debug.cpu.clock.stddev
    164999           -36.4%     104928        sched_debug.cpu.clock_task.avg
    165102           -36.4%     104975        sched_debug.cpu.clock_task.max
    164879           -36.4%     104875        sched_debug.cpu.clock_task.min
     62.96 ±  8%     -54.6%      28.56 ±  4%  sched_debug.cpu.clock_task.stddev
      3335           -81.2%     627.73 ±  4%  sched_debug.cpu.curr->pid.avg
      8057           -24.1%       6114        sched_debug.cpu.curr->pid.max
    680.73 ±  2%    +101.9%       1374 ±  4%  sched_debug.cpu.curr->pid.stddev
    502321           +11.8%     561605 ±  2%  sched_debug.cpu.max_idle_balance_cost.avg
      0.00 ± 16%     -41.3%       0.00 ± 40%  sched_debug.cpu.next_balance.stddev
      1.58 ± 12%     -89.9%       0.16        sched_debug.cpu.nr_running.avg
      4.25 ±  9%     -64.7%       1.50 ± 11%  sched_debug.cpu.nr_running.max
      0.75 ± 10%     -51.8%       0.36        sched_debug.cpu.nr_running.stddev
     16878 ±  2%     -50.5%       8361        sched_debug.cpu.nr_switches.avg
     27149 ±  4%     -20.4%      21621 ±  6%  sched_debug.cpu.nr_switches.max
     15094 ±  2%     -56.4%       6576        sched_debug.cpu.nr_switches.min
      1549 ±  2%     +15.5%       1789 ±  4%  sched_debug.cpu.nr_switches.stddev
    240.85 ±  9%     -19.8%     193.25 ±  3%  sched_debug.cpu.nr_uninterruptible.max
   -112.45           -61.7%     -43.08        sched_debug.cpu.nr_uninterruptible.min
     46.80 ±  4%     -57.6%      19.83        sched_debug.cpu.nr_uninterruptible.stddev
     15317 ±  2%     -59.7%       6179        sched_debug.cpu.sched_count.avg
     21804 ±  3%     -22.5%      16903 ± 10%  sched_debug.cpu.sched_count.max
     14134 ±  2%     -64.5%       5018 ±  2%  sched_debug.cpu.sched_count.min
      1022 ±  8%     +17.3%       1198 ±  5%  sched_debug.cpu.sched_count.stddev
      1756 ± 18%     +72.3%       3025        sched_debug.cpu.sched_goidle.avg
      4179 ±  7%    +100.7%       8388 ± 10%  sched_debug.cpu.sched_goidle.max
      1519 ± 20%     +61.4%       2452 ±  2%  sched_debug.cpu.sched_goidle.min
    305.37 ± 10%     +96.1%     598.85 ±  5%  sched_debug.cpu.sched_goidle.stddev
      5628 ±  3%     -42.1%       3258        sched_debug.cpu.ttwu_count.avg
     14579 ±  5%     -38.9%       8914 ± 13%  sched_debug.cpu.ttwu_count.max
      2477 ±  7%     -12.3%       2172 ±  4%  sched_debug.cpu.ttwu_count.min
      2152 ±  6%     -63.3%     790.79 ±  7%  sched_debug.cpu.ttwu_count.stddev
    908.75           -76.9%     210.08        sched_debug.cpu.ttwu_local.avg
      3520 ± 14%     -85.0%     528.83 ±  6%  sched_debug.cpu.ttwu_local.max
    602.05           -77.7%     134.50        sched_debug.cpu.ttwu_local.min
    335.13 ± 15%     -82.2%      59.56 ±  3%  sched_debug.cpu.ttwu_local.stddev
    164879           -36.4%     104876        sched_debug.cpu_clk
    160826           -37.3%     100821        sched_debug.ktime
      3.02           -37.5%       1.89 ± 57%  sched_debug.rt_rq:/.rt_runtime.stddev
    165652           -36.3%     105495        sched_debug.sched_clk
     98.46           -47.6       50.86 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write.ksys_write
     98.52           -47.5       51.06 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
     98.53           -47.4       51.08 ±  7%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     98.61           -47.3       51.35 ±  7%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     98.63           -47.2       51.39 ±  7%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     98.65           -47.2       51.42 ±  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     98.65           -47.2       51.43 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     98.67           -47.2       51.52 ±  7%  perf-profile.calltrace.cycles-pp.write
     35.02           -35.0        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write
     35.02           -35.0        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_buffered_write
     26.44           -26.4        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_clear_delalloc_extent
     35.11           -20.9       14.22 ±  7%  perf-profile.calltrace.cycles-pp._raw_spin_lock.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter
     35.33           -20.5       14.82 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
     35.43           -20.3       15.16 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write
     26.50           -18.7        7.77 ±  7%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_clear_delalloc_extent.clear_state_bit
     26.52           -18.7        7.81 ±  7%  perf-profile.calltrace.cycles-pp.__btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_clear_delalloc_extent.clear_state_bit.__clear_extent_bit
     26.52           -18.7        7.83 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_inode_rsv_release.btrfs_clear_delalloc_extent.clear_state_bit.__clear_extent_bit.clear_extent_bit
     26.64           -18.4        8.19 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_clear_delalloc_extent.clear_state_bit.__clear_extent_bit.clear_extent_bit.btrfs_dirty_pages
     26.65           -18.4        8.20 ±  7%  perf-profile.calltrace.cycles-pp.clear_state_bit.__clear_extent_bit.clear_extent_bit.btrfs_dirty_pages.btrfs_buffered_write
     26.67           -18.3        8.32 ±  7%  perf-profile.calltrace.cycles-pp.clear_extent_bit.btrfs_dirty_pages.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
     26.67           -18.3        8.32 ±  7%  perf-profile.calltrace.cycles-pp.__clear_extent_bit.clear_extent_bit.btrfs_dirty_pages.btrfs_buffered_write.btrfs_file_write_iter
     27.32           -17.8        9.53 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_dirty_pages.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write
     35.11           -11.2       23.93 ±  7%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_buffered_write.btrfs_file_write_iter
     35.13           -11.1       24.00 ±  6%  perf-profile.calltrace.cycles-pp.__btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
     35.14           -11.1       24.02 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_inode_rsv_release.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write
      0.30 ±100%      +0.4        0.75 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_get_extent.btrfs_dirty_pages.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
      0.00            +0.7        0.67 ± 10%  perf-profile.calltrace.cycles-pp.irq_exit.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +0.7        0.68 ± 11%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state
      0.00            +0.8        0.79 ±  7%  perf-profile.calltrace.cycles-pp.prepare_pages.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write
      0.00            +0.8        0.81 ±  5%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64
      0.00            +0.8        0.81 ±  7%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.path_openat.do_filp_open
      0.00            +0.9        0.85 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_create.path_openat.do_filp_open.do_sys_open.do_syscall_64
      0.00            +0.9        0.92 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_unlink.vfs_unlink.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.9        0.92 ±  7%  perf-profile.calltrace.cycles-pp.vfs_unlink.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.00            +1.2        1.19 ±  8%  perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.close
      0.00            +1.2        1.19 ±  8%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.close
      0.00            +1.2        1.19 ±  8%  perf-profile.calltrace.cycles-pp.dput.__fput.task_work_run.exit_to_usermode_loop.do_syscall_64
      0.00            +1.2        1.19 ±  8%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.2        1.19 ±  8%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.task_work_run.exit_to_usermode_loop
      0.00            +1.2        1.19 ±  8%  perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dput.__fput.task_work_run
      0.00            +1.2        1.19 ±  8%  perf-profile.calltrace.cycles-pp.btrfs_evict_inode.evict.__dentry_kill.dput.__fput
      0.00            +1.2        1.19 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.close
      0.00            +1.2        1.19 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.close
      0.00            +1.2        1.20 ±  8%  perf-profile.calltrace.cycles-pp.close
      0.00            +1.4        1.39 ± 13%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +1.8        1.78 ± 18%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      0.00            +2.5        2.47 ± 13%  perf-profile.calltrace.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      0.00            +3.4        3.38 ± 20%  perf-profile.calltrace.cycles-pp.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.00            +3.9        3.94 ± 12%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.path_openat.do_filp_open
      0.00            +4.1        4.12 ± 17%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64
      0.00            +4.8        4.76 ± 11%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_open
      0.00            +4.9        4.93 ± 14%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +5.2        5.18 ± 11%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_open.do_syscall_64
      0.00            +5.4        5.40 ± 15%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.00            +6.1        6.05 ± 10%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat
      0.00            +6.1        6.05 ± 10%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +6.1        6.06 ± 10%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat
      0.00            +6.1        6.06 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat
      0.00            +6.1        6.06 ± 10%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat
      0.00            +6.1        6.06 ± 10%  perf-profile.calltrace.cycles-pp.creat
      0.00            +6.3        6.33 ± 13%  perf-profile.calltrace.cycles-pp.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.00            +6.3        6.33 ± 13%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlink
      0.00            +6.3        6.33 ± 13%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.00            +6.3        6.34 ± 13%  perf-profile.calltrace.cycles-pp.unlink
      0.00            +7.6        7.62 ±  7%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.__btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_clear_delalloc_extent
      0.00           +14.0       14.04 ±  7%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write
      0.00           +23.7       23.70 ±  7%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.__btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_buffered_write
      0.00           +28.4       28.37 ± 17%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.00           +31.6       31.65 ± 14%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
      0.00           +32.1       32.14 ± 13%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      0.00           +34.1       34.15 ± 12%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      0.00           +34.1       34.15 ± 12%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
      0.00           +34.1       34.15 ± 12%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
      0.00           +34.3       34.34 ± 12%  perf-profile.calltrace.cycles-pp.secondary_startup_64
     97.34           -97.3        0.00        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     98.46           -47.6       50.86 ±  7%  perf-profile.children.cycles-pp.btrfs_buffered_write
     98.52           -47.5       51.06 ±  7%  perf-profile.children.cycles-pp.btrfs_file_write_iter
     98.53           -47.4       51.09 ±  7%  perf-profile.children.cycles-pp.new_sync_write
     97.46           -47.3       50.14 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock
     98.63           -47.3       51.36 ±  7%  perf-profile.children.cycles-pp.vfs_write
     98.64           -47.2       51.40 ±  7%  perf-profile.children.cycles-pp.ksys_write
     98.68           -47.1       51.54 ±  7%  perf-profile.children.cycles-pp.write
     99.57           -34.5       65.05 ±  6%  perf-profile.children.cycles-pp.do_syscall_64
     99.57           -34.5       65.06 ±  6%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     61.69           -29.5       32.16 ±  7%  perf-profile.children.cycles-pp.btrfs_inode_rsv_release
     61.95           -28.2       33.75 ±  7%  perf-profile.children.cycles-pp.__btrfs_block_rsv_release
     35.43           -20.3       15.16 ±  7%  perf-profile.children.cycles-pp.btrfs_delalloc_reserve_metadata
     35.46           -19.6       15.87 ±  6%  perf-profile.children.cycles-pp.btrfs_reserve_metadata_bytes
     26.68           -18.2        8.52 ±  7%  perf-profile.children.cycles-pp.btrfs_clear_delalloc_extent
     26.70           -18.1        8.64 ±  7%  perf-profile.children.cycles-pp.clear_extent_bit
     26.70           -18.1        8.65 ±  7%  perf-profile.children.cycles-pp.clear_state_bit
     26.75           -17.9        8.89 ±  7%  perf-profile.children.cycles-pp.__clear_extent_bit
     27.32           -17.8        9.54 ±  7%  perf-profile.children.cycles-pp.btrfs_dirty_pages
      0.41 ± 13%      -0.1        0.27 ± 13%  perf-profile.children.cycles-pp.btrfs_tree_read_lock
      0.40 ± 13%      -0.1        0.30 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.43 ± 12%      -0.1        0.34 ± 10%  perf-profile.children.cycles-pp.btrfs_read_lock_root_node
      0.14 ±  6%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.update_cfs_group
      0.26 ±  4%      +0.0        0.31 ±  6%  perf-profile.children.cycles-pp.scheduler_tick
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.00            +0.1        0.05 ±  9%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.00            +0.1        0.05 ±  9%  perf-profile.children.cycles-pp.__lru_cache_add
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.__sched_text_start
      0.00            +0.1        0.06 ± 15%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.00            +0.1        0.06 ± 22%  perf-profile.children.cycles-pp.poll_idle
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.btrfs_lock_and_flush_ordered_range
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.__might_sleep
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.btrfs_balance_delayed_items
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.pagevec_lru_move_fn
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.find_busiest_group
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.truncate_cleanup_page
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__add_to_page_cache_locked
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.__next_timer_interrupt
      0.00            +0.1        0.07 ± 12%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.00            +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.btrfs_delalloc_release_metadata
      0.04 ± 57%      +0.1        0.11 ± 13%  perf-profile.children.cycles-pp.update_load_avg
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.btrfs_root_node
      0.00            +0.1        0.08 ± 14%  perf-profile.children.cycles-pp.__btrfs_btree_balance_dirty
      0.00            +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.read_tsc
      0.00            +0.1        0.08 ± 19%  perf-profile.children.cycles-pp.run_local_timers
      0.00            +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.merge_state
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.btrfs_set_delalloc_extent
      0.00            +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.load_balance
      0.00            +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.__set_page_dirty_nobuffers
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.free_extent_state
      0.00            +0.1        0.09 ±  9%  perf-profile.children.cycles-pp.___might_sleep
      0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.kmem_cache_free
      0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.memset_erms
      0.00            +0.1        0.09 ±  8%  perf-profile.children.cycles-pp.copyin
      0.00            +0.1        0.10 ±  7%  perf-profile.children.cycles-pp.set_state_bits
      0.01 ±173%      +0.1        0.11 ±  9%  perf-profile.children.cycles-pp.aa_file_perm
      0.00            +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.btrfs_release_path
      0.00            +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.btrfs_delalloc_release_extents
      0.00            +0.1        0.11 ± 10%  perf-profile.children.cycles-pp.__wake_up_common_lock
      0.00            +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.00            +0.1        0.11 ± 10%  perf-profile.children.cycles-pp.mark_page_accessed
      0.00            +0.1        0.11 ±  7%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.00            +0.1        0.11 ± 11%  perf-profile.children.cycles-pp.iov_iter_copy_from_user_atomic
      0.00            +0.1        0.11 ± 11%  perf-profile.children.cycles-pp.find_extent_buffer
      0.00            +0.1        0.11 ±  9%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.00            +0.1        0.11 ±  9%  perf-profile.children.cycles-pp.add_to_page_cache_lru
      0.00            +0.1        0.12 ± 11%  perf-profile.children.cycles-pp.btrfs_commit_inode_delayed_inode
      0.05 ±  8%      +0.1        0.17 ±  8%  perf-profile.children.cycles-pp.lock_extent_bits
      0.06 ±  6%      +0.1        0.19 ±  8%  perf-profile.children.cycles-pp.common_file_perm
      0.05 ±  8%      +0.1        0.18 ±  8%  perf-profile.children.cycles-pp.lock_and_cleanup_extent_if_need
      0.00            +0.1        0.13 ± 18%  perf-profile.children.cycles-pp.btrfs_delete_delayed_dir_index
      0.00            +0.1        0.14 ±  7%  perf-profile.children.cycles-pp.btrfs_copy_from_user
      0.07 ±  7%      +0.1        0.21 ±  6%  perf-profile.children.cycles-pp.security_file_permission
      0.07 ±  5%      +0.1        0.22 ±  5%  perf-profile.children.cycles-pp.btrfs_alloc_data_chunk_ondemand
      0.00            +0.1        0.15 ±  7%  perf-profile.children.cycles-pp.native_write_msr
      0.00            +0.1        0.15 ± 12%  perf-profile.children.cycles-pp.btrfs_csum_bytes_to_leaves
      0.00            +0.1        0.15 ±  7%  perf-profile.children.cycles-pp.read_block_for_search
      0.00            +0.2        0.15 ± 10%  perf-profile.children.cycles-pp.update_blocked_averages
      0.00            +0.2        0.15 ±  8%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.08            +0.2        0.23 ±  7%  perf-profile.children.cycles-pp.btrfs_free_reserved_data_space_noquota
      0.07 ±  5%      +0.2        0.24 ±  4%  perf-profile.children.cycles-pp.btrfs_check_data_free_space
      0.00            +0.2        0.17 ± 12%  perf-profile.children.cycles-pp.btrfs_unlink_inode
      0.00            +0.2        0.17 ± 12%  perf-profile.children.cycles-pp.__btrfs_unlink_inode
      0.00            +0.2        0.17 ±  9%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      0.00            +0.2        0.17 ± 10%  perf-profile.children.cycles-pp.rebalance_domains
      0.00            +0.2        0.17 ± 11%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.06 ±  6%      +0.2        0.24 ±  4%  perf-profile.children.cycles-pp.btrfs_drop_pages
      0.03 ±100%      +0.2        0.21 ±  9%  perf-profile.children.cycles-pp.btrfs_set_extent_delalloc
      0.30 ±  6%      +0.2        0.49 ±  7%  perf-profile.children.cycles-pp.update_process_times
      0.00            +0.2        0.19 ± 13%  perf-profile.children.cycles-pp.btrfs_calculate_inode_block_rsv_size
      0.00            +0.2        0.19 ± 35%  perf-profile.children.cycles-pp.start_kernel
      0.30 ±  5%      +0.2        0.50 ±  7%  perf-profile.children.cycles-pp.tick_sched_handle
      0.00            +0.2        0.20 ±  6%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      0.55 ± 10%      +0.2        0.75 ±  7%  perf-profile.children.cycles-pp.btrfs_get_extent
      0.06 ±  9%      +0.2        0.26 ±  8%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.00            +0.2        0.20 ± 13%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.07            +0.2        0.30 ±  9%  perf-profile.children.cycles-pp.set_extent_bit
      0.09 ±  4%      +0.2        0.34 ±  9%  perf-profile.children.cycles-pp.pagecache_get_page
      0.08 ±  5%      +0.3        0.33 ±  6%  perf-profile.children.cycles-pp.get_alloc_profile
      0.06 ±  6%      +0.3        0.32 ±  6%  perf-profile.children.cycles-pp.alloc_extent_state
      0.08 ±  5%      +0.3        0.36 ±  5%  perf-profile.children.cycles-pp.__do_readpage
      0.40 ±  4%      +0.3        0.72 ±  9%  perf-profile.children.cycles-pp.tick_sched_timer
      0.10 ±  5%      +0.3        0.42 ±  6%  perf-profile.children.cycles-pp.extent_read_full_page
      0.11 ±  4%      +0.3        0.44 ±  6%  perf-profile.children.cycles-pp.prepare_uptodate_page
      0.00            +0.3        0.34 ±  8%  perf-profile.children.cycles-pp.cna_scan_main_queue
      0.15 ±  3%      +0.3        0.49 ±  6%  perf-profile.children.cycles-pp.can_overcommit
      0.07            +0.3        0.42 ± 12%  perf-profile.children.cycles-pp.btrfs_work_helper
      0.07            +0.3        0.42 ± 12%  perf-profile.children.cycles-pp.btrfs_async_run_delayed_root
      0.07            +0.4        0.43 ± 12%  perf-profile.children.cycles-pp.process_one_work
      0.00            +0.4        0.36 ± 26%  perf-profile.children.cycles-pp.tick_irq_enter
      0.07            +0.4        0.44 ± 12%  perf-profile.children.cycles-pp.worker_thread
      0.08 ±  5%      +0.4        0.44 ± 12%  perf-profile.children.cycles-pp.ret_from_fork
      0.08 ±  5%      +0.4        0.44 ± 12%  perf-profile.children.cycles-pp.kthread
      0.00            +0.4        0.38 ± 23%  perf-profile.children.cycles-pp.irq_enter
      0.00            +0.4        0.42 ±  6%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.01 ±173%      +0.4        0.44 ± 12%  perf-profile.children.cycles-pp.btrfs_delayed_inode_release_metadata
      0.05            +0.4        0.48 ± 12%  perf-profile.children.cycles-pp.__btrfs_update_delayed_inode
      0.00            +0.4        0.43 ±  8%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.00            +0.5        0.46 ±  7%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.00            +0.5        0.48 ±  7%  perf-profile.children.cycles-pp.btrfs_start_transaction_fallback_global_rsv
      0.15 ±  3%      +0.5        0.66 ±  7%  perf-profile.children.cycles-pp.__set_extent_bit
      0.46 ±  4%      +0.5        0.99 ±  9%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.08 ± 15%      +0.6        0.64 ± 14%  perf-profile.children.cycles-pp.clockevents_program_event
      0.20 ±  4%      +0.6        0.79 ±  7%  perf-profile.children.cycles-pp.prepare_pages
      0.00            +0.7        0.70 ± 10%  perf-profile.children.cycles-pp.irq_exit
      0.08 ±  5%      +0.8        0.85 ±  6%  perf-profile.children.cycles-pp.btrfs_create
      0.11            +0.8        0.92 ±  7%  perf-profile.children.cycles-pp.btrfs_unlink
      0.11            +0.8        0.92 ±  7%  perf-profile.children.cycles-pp.vfs_unlink
      0.14 ±  3%      +0.9        1.01 ±  8%  perf-profile.children.cycles-pp.__btrfs_end_transaction
      0.14 ±  3%      +0.9        1.01 ±  8%  perf-profile.children.cycles-pp.btrfs_trans_release_metadata
      0.07            +0.9        0.97 ±  6%  perf-profile.children.cycles-pp.btrfs_block_rsv_add
      0.07            +0.9        0.97 ±  6%  perf-profile.children.cycles-pp.start_transaction
      0.27            +0.9        1.19 ±  8%  perf-profile.children.cycles-pp.exit_to_usermode_loop
      0.27            +0.9        1.19 ±  8%  perf-profile.children.cycles-pp.task_work_run
      0.27            +0.9        1.19 ±  8%  perf-profile.children.cycles-pp.dput
      0.27            +0.9        1.19 ±  8%  perf-profile.children.cycles-pp.__fput
      0.27            +0.9        1.19 ±  8%  perf-profile.children.cycles-pp.__dentry_kill
      0.27            +0.9        1.19 ±  8%  perf-profile.children.cycles-pp.evict
      0.27            +0.9        1.19 ±  8%  perf-profile.children.cycles-pp.btrfs_evict_inode
      0.27            +0.9        1.20 ±  8%  perf-profile.children.cycles-pp.close
      0.16 ± 27%      +1.0        1.18 ± 18%  perf-profile.children.cycles-pp.ktime_get
      0.66 ±  6%      +1.2        1.84 ± 11%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.00            +1.8        1.79 ± 18%  perf-profile.children.cycles-pp.menu_select
      0.69 ±  5%      +2.3        2.96 ± 12%  perf-profile.children.cycles-pp.smp_apic_timer_interrupt
      0.16 ±  5%      +2.3        2.50 ±  7%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.73 ±  5%      +2.8        3.49 ± 13%  perf-profile.children.cycles-pp.apic_timer_interrupt
      0.28 ±  9%      +5.8        6.06 ± 10%  perf-profile.children.cycles-pp.do_sys_open
      0.28 ±  8%      +5.8        6.06 ± 10%  perf-profile.children.cycles-pp.do_filp_open
      0.28 ±  8%      +5.8        6.06 ± 10%  perf-profile.children.cycles-pp.path_openat
      0.28 ±  8%      +5.8        6.06 ± 10%  perf-profile.children.cycles-pp.creat
      0.36 ±  6%      +6.0        6.33 ± 13%  perf-profile.children.cycles-pp.do_unlinkat
      0.36 ±  6%      +6.0        6.34 ± 13%  perf-profile.children.cycles-pp.unlink
      0.26 ± 12%      +7.8        8.07 ± 15%  perf-profile.children.cycles-pp.osq_lock
      0.39 ± 11%      +9.3        9.69 ± 13%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      0.43 ± 10%     +10.1       10.58 ± 13%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.26 ± 27%     +28.3       28.53 ± 17%  perf-profile.children.cycles-pp.intel_idle
      0.27 ± 26%     +32.0       32.31 ± 13%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.27 ± 26%     +32.1       32.32 ± 13%  perf-profile.children.cycles-pp.cpuidle_enter
      0.27 ± 27%     +33.9       34.15 ± 12%  perf-profile.children.cycles-pp.start_secondary
      0.27 ± 27%     +34.1       34.34 ± 12%  perf-profile.children.cycles-pp.secondary_startup_64
      0.27 ± 27%     +34.1       34.34 ± 12%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.27 ± 27%     +34.1       34.34 ± 12%  perf-profile.children.cycles-pp.do_idle
      0.00           +48.7       48.65 ±  7%  perf-profile.children.cycles-pp.__cna_queued_spin_lock_slowpath
     96.63           -96.6        0.00        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.14 ±  6%      -0.0        0.09 ±  8%  perf-profile.self.cycles-pp.update_cfs_group
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.btrfs_buffered_write
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.__clear_extent_bit
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.mark_page_accessed
      0.00            +0.1        0.05 ±  9%  perf-profile.self.cycles-pp.btrfs_dirty_pages
      0.00            +0.1        0.05 ±  9%  perf-profile.self.cycles-pp.find_extent_buffer
      0.06 ± 16%      +0.1        0.12 ± 11%  perf-profile.self.cycles-pp.btrfs_reserve_metadata_bytes
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.__might_sleep
      0.00            +0.1        0.06 ± 22%  perf-profile.self.cycles-pp.poll_idle
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.1        0.07 ± 12%  perf-profile.self.cycles-pp.get_alloc_profile
      0.00            +0.1        0.07 ± 10%  perf-profile.self.cycles-pp.perf_mux_hrtimer_handler
      0.00            +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.run_local_timers
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.common_file_perm
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.btrfs_root_node
      0.00            +0.1        0.08 ± 10%  perf-profile.self.cycles-pp.read_tsc
      0.00            +0.1        0.08 ± 14%  perf-profile.self.cycles-pp.update_load_avg
      0.00            +0.1        0.08 ± 13%  perf-profile.self.cycles-pp.___might_sleep
      0.07 ±  7%      +0.1        0.15 ±  7%  perf-profile.self.cycles-pp.can_overcommit
      0.00            +0.1        0.08 ± 10%  perf-profile.self.cycles-pp.free_extent_state
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.00            +0.1        0.09 ±  9%  perf-profile.self.cycles-pp.kmem_cache_free
      0.00            +0.1        0.09 ±  7%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.00            +0.1        0.09 ±  7%  perf-profile.self.cycles-pp.memset_erms
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.__btrfs_block_rsv_release
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.__set_extent_bit
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.1        0.10 ±  7%  perf-profile.self.cycles-pp.alloc_extent_state
      0.01 ±173%      +0.1        0.11 ±  9%  perf-profile.self.cycles-pp.aa_file_perm
      0.00            +0.1        0.10 ±  8%  perf-profile.self.cycles-pp.btrfs_file_write_iter
      0.00            +0.1        0.11 ± 10%  perf-profile.self.cycles-pp.update_blocked_averages
      0.00            +0.1        0.11 ± 11%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.00            +0.1        0.11 ±  9%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.00            +0.1        0.12 ±  8%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.00            +0.1        0.14 ±  9%  perf-profile.self.cycles-pp.btrfs_csum_bytes_to_leaves
      0.00            +0.1        0.15 ±  7%  perf-profile.self.cycles-pp.native_write_msr
      0.06            +0.2        0.23 ±  3%  perf-profile.self.cycles-pp.btrfs_drop_pages
      0.00            +0.2        0.20 ±  6%  perf-profile.self.cycles-pp.timekeeping_max_deferment
      0.00            +0.3        0.33 ±  8%  perf-profile.self.cycles-pp.cna_scan_main_queue
      0.15 ± 29%      +1.0        1.11 ± 19%  perf-profile.self.cycles-pp.ktime_get
      0.00            +1.1        1.09 ± 20%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.52 ±  2%      +1.2        1.69 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock
      0.00            +1.3        1.30 ± 23%  perf-profile.self.cycles-pp.menu_select
      0.16 ±  5%      +2.3        2.48 ±  7%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.26 ± 12%      +7.8        8.01 ± 15%  perf-profile.self.cycles-pp.osq_lock
      0.26 ± 27%     +28.3       28.53 ± 17%  perf-profile.self.cycles-pp.intel_idle
      0.00           +48.0       47.96 ±  7%  perf-profile.self.cycles-pp.__cna_queued_spin_lock_slowpath
     14592 ±  5%     +94.8%      28431 ±  3%  softirqs.CPU0.SCHED
     99814           -35.0%      64847        softirqs.CPU0.TIMER
      7136 ±  4%    +165.6%      18956 ±  2%  softirqs.CPU1.SCHED
     95302           -36.7%      60287 ±  2%  softirqs.CPU1.TIMER
      6810 ±  3%    +186.1%      19484        softirqs.CPU10.SCHED
     97179 ±  2%     -33.1%      64989        softirqs.CPU10.TIMER
      6795 ±  4%    +189.3%      19661 ±  2%  softirqs.CPU100.SCHED
     95469 ±  2%     -32.7%      64293 ±  2%  softirqs.CPU100.TIMER
      6987 ±  2%    +179.7%      19541        softirqs.CPU101.SCHED
     96184 ±  2%     -33.3%      64180        softirqs.CPU101.TIMER
      6786 ±  4%    +188.6%      19587        softirqs.CPU102.SCHED
     94782           -32.4%      64109        softirqs.CPU102.TIMER
      6724 ±  3%    +189.1%      19438        softirqs.CPU103.SCHED
     94877 ±  2%     -33.1%      63519        softirqs.CPU103.TIMER
      6764 ±  3%    +187.9%      19471        softirqs.CPU104.SCHED
     95112           -32.3%      64360        softirqs.CPU104.TIMER
      6724 ±  2%    +187.0%      19296        softirqs.CPU105.SCHED
     95016           -33.4%      63326        softirqs.CPU105.TIMER
      6743 ±  3%    +186.7%      19335        softirqs.CPU106.SCHED
     95512 ±  2%     -32.4%      64572        softirqs.CPU106.TIMER
      6549 ±  3%    +198.2%      19533        softirqs.CPU107.SCHED
     95436           -33.0%      63908        softirqs.CPU107.TIMER
      6754 ±  2%    +185.0%      19249 ±  4%  softirqs.CPU108.SCHED
     94963           -32.8%      63850        softirqs.CPU108.TIMER
      6787 ±  2%    +173.5%      18563 ±  7%  softirqs.CPU109.SCHED
     95281 ±  2%     -33.3%      63533        softirqs.CPU109.TIMER
      7184 ± 10%    +171.6%      19516        softirqs.CPU11.SCHED
     97506 ±  2%     -33.6%      64745 ±  2%  softirqs.CPU11.TIMER
      6779 ±  3%    +188.7%      19569        softirqs.CPU110.SCHED
     95427           -33.0%      63905        softirqs.CPU110.TIMER
      6456 ±  7%    +206.8%      19805 ±  3%  softirqs.CPU111.SCHED
     96457 ±  3%     -33.1%      64522        softirqs.CPU111.TIMER
      6664 ±  5%    +194.7%      19643 ±  3%  softirqs.CPU112.SCHED
     95399 ±  2%     -32.5%      64416        softirqs.CPU112.TIMER
      6761 ±  4%    +194.3%      19899        softirqs.CPU113.SCHED
     95585 ±  2%     -32.9%      64118        softirqs.CPU113.TIMER
      6837 ±  3%    +186.5%      19592        softirqs.CPU114.SCHED
     96249 ±  2%     -33.6%      63899        softirqs.CPU114.TIMER
      6793 ±  3%    +186.7%      19478 ±  2%  softirqs.CPU115.SCHED
     96608 ±  2%     -34.1%      63694        softirqs.CPU115.TIMER
      6819 ±  3%    +187.8%      19626 ±  4%  softirqs.CPU116.SCHED
     95139 ±  2%     -32.6%      64139 ±  2%  softirqs.CPU116.TIMER
      6646 ±  2%    +193.5%      19508 ±  2%  softirqs.CPU117.SCHED
     96048 ±  3%     -33.8%      63559        softirqs.CPU117.TIMER
      6496 ±  4%    +199.9%      19482        softirqs.CPU118.SCHED
     95240           -33.4%      63475        softirqs.CPU118.TIMER
      6638 ±  6%    +189.2%      19200        softirqs.CPU119.SCHED
     94483           -33.4%      62895        softirqs.CPU119.TIMER
      6674 ±  4%    +192.2%      19502        softirqs.CPU12.SCHED
     95708           -32.6%      64544        softirqs.CPU12.TIMER
      6833 ±  2%    +186.4%      19573 ±  2%  softirqs.CPU120.SCHED
     95163 ±  2%     -32.9%      63830 ±  2%  softirqs.CPU120.TIMER
      6859 ±  3%    +192.0%      20029 ±  3%  softirqs.CPU121.SCHED
     94833 ±  2%     -27.1%      69164 ± 14%  softirqs.CPU121.TIMER
      6794 ±  3%    +188.9%      19631 ±  2%  softirqs.CPU122.SCHED
     95094 ±  2%     -33.4%      63357 ±  2%  softirqs.CPU122.TIMER
      6608 ±  4%    +198.7%      19740 ±  2%  softirqs.CPU123.SCHED
     95648           -33.8%      63331 ±  2%  softirqs.CPU123.TIMER
      6666 ±  6%    +192.0%      19462 ±  2%  softirqs.CPU124.SCHED
     95013 ±  2%     -33.9%      62811 ±  2%  softirqs.CPU124.TIMER
      6955          +181.7%      19592 ±  2%  softirqs.CPU125.SCHED
     95559           -34.2%      62877        softirqs.CPU125.TIMER
      6875 ±  2%    +185.8%      19651 ±  2%  softirqs.CPU126.SCHED
     94455 ±  2%     -33.5%      62856 ±  2%  softirqs.CPU126.TIMER
      6651 ±  7%    +199.6%      19926 ±  3%  softirqs.CPU127.SCHED
     94953 ±  2%     -27.5%      68831 ± 14%  softirqs.CPU127.TIMER
      6915 ±  2%    +182.8%      19559 ±  3%  softirqs.CPU128.SCHED
     94759 ±  2%     -33.1%      63429        softirqs.CPU128.TIMER
      6911          +185.8%      19756 ±  2%  softirqs.CPU129.SCHED
     94883 ±  2%     -33.0%      63611 ±  2%  softirqs.CPU129.TIMER
      7005 ±  8%     +34.7%       9435 ±  4%  softirqs.CPU13.RCU
      6836 ±  3%    +185.7%      19533 ±  2%  softirqs.CPU13.SCHED
     96199           -32.6%      64821        softirqs.CPU13.TIMER
      6922 ±  5%    +181.2%      19464        softirqs.CPU130.SCHED
     95525 ±  2%     -34.4%      62704        softirqs.CPU130.TIMER
      6941 ±  4%    +173.8%      19006 ±  7%  softirqs.CPU131.SCHED
     95623 ±  2%     -33.2%      63911 ±  3%  softirqs.CPU131.TIMER
      6883 ±  3%    +186.6%      19728        softirqs.CPU132.SCHED
     94547 ±  2%     -32.9%      63398 ±  2%  softirqs.CPU132.TIMER
      6906 ±  3%    +178.7%      19245 ±  3%  softirqs.CPU133.SCHED
     94641 ±  2%     -34.0%      62457        softirqs.CPU133.TIMER
      6876 ±  3%    +183.7%      19507        softirqs.CPU134.SCHED
     94881 ±  2%     -34.1%      62562        softirqs.CPU134.TIMER
      6788 ±  3%    +189.1%      19623        softirqs.CPU135.SCHED
     94704 ±  2%     -33.5%      62999        softirqs.CPU135.TIMER
      6769 ±  3%    +189.1%      19574 ±  2%  softirqs.CPU136.SCHED
     94965 ±  2%     -33.5%      63190 ±  2%  softirqs.CPU136.TIMER
      6837          +187.0%      19626        softirqs.CPU137.SCHED
     94794 ±  2%     -33.1%      63391        softirqs.CPU137.TIMER
      6862 ±  3%    +187.5%      19731 ±  2%  softirqs.CPU138.SCHED
     95012 ±  2%     -33.2%      63450 ±  2%  softirqs.CPU138.TIMER
      6887 ±  3%    +185.4%      19654        softirqs.CPU139.SCHED
     94874 ±  2%     -33.5%      63072        softirqs.CPU139.TIMER
      6874 ±  6%     +44.0%       9901 ± 10%  softirqs.CPU14.RCU
      6716 ±  4%    +196.2%      19892 ±  4%  softirqs.CPU14.SCHED
     95818           -30.7%      66379 ±  3%  softirqs.CPU14.TIMER
      7146 ±  7%    +173.4%      19539        softirqs.CPU140.SCHED
     95267 ±  3%     -34.2%      62704        softirqs.CPU140.TIMER
      6812 ±  3%    +187.8%      19606        softirqs.CPU141.SCHED
     94594 ±  2%     -33.5%      62914        softirqs.CPU141.TIMER
      6811 ±  3%    +185.4%      19439 ±  2%  softirqs.CPU142.SCHED
     94576 ±  2%     -32.2%      64166 ±  4%  softirqs.CPU142.TIMER
      6809 ±  3%    +183.6%      19309        softirqs.CPU143.SCHED
     94233 ±  2%     -33.7%      62491        softirqs.CPU143.TIMER
      6890 ±  3%    +184.7%      19615        softirqs.CPU144.SCHED
     97377 ±  4%     -34.8%      63494        softirqs.CPU144.TIMER
      6773 ±  2%    +190.0%      19645        softirqs.CPU145.SCHED
     97439 ±  5%     -34.7%      63584        softirqs.CPU145.TIMER
      6823 ±  2%    +188.1%      19656        softirqs.CPU146.SCHED
     97695 ±  5%     -34.8%      63673 ±  2%  softirqs.CPU146.TIMER
      6780 ±  2%    +191.1%      19740        softirqs.CPU147.SCHED
     97608 ±  5%     -34.8%      63609        softirqs.CPU147.TIMER
      7051 ±  8%    +178.7%      19651        softirqs.CPU148.SCHED
     99363 ±  6%     -36.0%      63596 ±  2%  softirqs.CPU148.TIMER
      6722 ±  2%    +194.6%      19806        softirqs.CPU149.SCHED
     98315 ±  5%     -35.0%      63939 ±  2%  softirqs.CPU149.TIMER
      6626 ±  2%    +194.5%      19513        softirqs.CPU15.SCHED
     96942           -32.9%      65083 ±  2%  softirqs.CPU15.TIMER
      6932 ±  2%    +182.1%      19555 ±  2%  softirqs.CPU150.SCHED
     97057 ±  5%     -34.1%      63945        softirqs.CPU150.TIMER
      6745 ±  2%    +188.6%      19466        softirqs.CPU151.SCHED
     96996 ±  4%     -35.2%      62872        softirqs.CPU151.TIMER
      6752 ±  2%    +190.1%      19588        softirqs.CPU152.SCHED
     96805 ±  4%     -34.5%      63422        softirqs.CPU152.TIMER
      6892 ±  5%    +186.3%      19733        softirqs.CPU153.SCHED
     97699 ±  4%     -35.2%      63355        softirqs.CPU153.TIMER
      6815          +189.0%      19692        softirqs.CPU154.SCHED
     97622 ±  5%     -34.6%      63805 ±  2%  softirqs.CPU154.TIMER
      6692 ±  5%    +197.1%      19886        softirqs.CPU155.SCHED
     97167 ±  5%     -34.2%      63912        softirqs.CPU155.TIMER
      6767 ±  2%    +188.8%      19541        softirqs.CPU156.SCHED
     96594 ±  4%     -34.3%      63450        softirqs.CPU156.TIMER
      6709          +189.9%      19447        softirqs.CPU157.SCHED
    100087 ± 10%     -37.0%      63048        softirqs.CPU157.TIMER
      6838 ±  3%    +187.2%      19637        softirqs.CPU158.SCHED
     97300 ±  5%     -34.9%      63385        softirqs.CPU158.TIMER
      6859          +186.3%      19639        softirqs.CPU159.SCHED
     97782 ±  5%     -35.0%      63571        softirqs.CPU159.TIMER
      6815 ±  3%    +184.6%      19396        softirqs.CPU16.SCHED
     96124 ±  2%     -33.3%      64109 ±  2%  softirqs.CPU16.TIMER
      6770 ±  2%    +191.4%      19730 ±  2%  softirqs.CPU160.SCHED
     97278 ±  5%     -34.7%      63480 ±  2%  softirqs.CPU160.TIMER
      6748 ±  4%    +192.2%      19716        softirqs.CPU161.SCHED
     97632 ±  5%     -34.7%      63709 ±  2%  softirqs.CPU161.TIMER
      6857 ±  4%    +184.9%      19536        softirqs.CPU162.SCHED
     97516 ±  4%     -35.3%      63125        softirqs.CPU162.TIMER
      6818 ±  2%    +192.2%      19925        softirqs.CPU163.SCHED
     97279 ±  4%     -34.4%      63821        softirqs.CPU163.TIMER
      6814 ±  3%    +188.1%      19633        softirqs.CPU164.SCHED
    109885 ± 17%     -42.4%      63306        softirqs.CPU164.TIMER
      6824 ±  2%    +181.6%      19216 ±  2%  softirqs.CPU165.SCHED
     98099 ±  4%     -35.8%      62984        softirqs.CPU165.TIMER
      6768 ±  2%    +188.9%      19553        softirqs.CPU166.SCHED
     96925 ±  4%     -34.9%      63092        softirqs.CPU166.TIMER
      7520 ± 10%    +160.2%      19571        softirqs.CPU167.SCHED
     97540 ±  5%     -35.1%      63288        softirqs.CPU167.TIMER
      6730 ± 10%    +187.9%      19378        softirqs.CPU168.SCHED
    100907 ±  2%     -37.6%      62926 ±  2%  softirqs.CPU168.TIMER
      7010 ±  3%    +180.3%      19647        softirqs.CPU169.SCHED
    101151           -37.6%      63136        softirqs.CPU169.TIMER
      6736 ±  2%    +188.0%      19400        softirqs.CPU17.SCHED
     95997 ±  2%     -33.2%      64084 ±  2%  softirqs.CPU17.TIMER
      6844 ±  3%    +182.5%      19336 ±  2%  softirqs.CPU170.SCHED
    100966 ±  2%     -37.2%      63382 ±  2%  softirqs.CPU170.TIMER
      7446 ±  6%    +162.8%      19565 ±  2%  softirqs.CPU171.SCHED
    101966           -37.9%      63320 ±  2%  softirqs.CPU171.TIMER
      6993 ±  4%    +181.3%      19673        softirqs.CPU172.SCHED
    101398           -37.7%      63155        softirqs.CPU172.TIMER
      6929 ±  3%    +183.4%      19640        softirqs.CPU173.SCHED
    100827 ±  2%     -37.6%      62914 ±  2%  softirqs.CPU173.TIMER
      6918 ±  3%    +187.1%      19861 ±  2%  softirqs.CPU174.SCHED
    100435 ±  2%     -36.7%      63579 ±  3%  softirqs.CPU174.TIMER
      6915 ±  3%    +182.8%      19558        softirqs.CPU175.SCHED
    101095 ±  2%     -37.9%      62761        softirqs.CPU175.TIMER
      6864 ±  3%    +184.2%      19510        softirqs.CPU176.SCHED
    100205 ±  2%     -37.5%      62649        softirqs.CPU176.TIMER
      6855 ±  2%    +186.1%      19609        softirqs.CPU177.SCHED
    100665 ±  2%     -36.9%      63509        softirqs.CPU177.TIMER
      6873 ±  3%    +183.5%      19488        softirqs.CPU178.SCHED
    101027 ±  2%     -37.8%      62873        softirqs.CPU178.TIMER
      6810 ±  3%    +189.8%      19734        softirqs.CPU179.SCHED
    101112 ±  2%     -37.1%      63595        softirqs.CPU179.TIMER
      6605 ±  4%    +194.0%      19420        softirqs.CPU18.SCHED
     96403 ±  2%     -33.4%      64188        softirqs.CPU18.TIMER
      6838 ±  3%    +187.0%      19626        softirqs.CPU180.SCHED
    100449 ±  2%     -37.3%      62988        softirqs.CPU180.TIMER
      6926 ±  4%    +182.2%      19546        softirqs.CPU181.SCHED
    100295 ±  2%     -36.9%      63293 ±  2%  softirqs.CPU181.TIMER
      6788 ±  3%    +186.1%      19418        softirqs.CPU182.SCHED
    100742 ±  2%     -36.9%      63557        softirqs.CPU182.TIMER
      6921 ±  3%    +182.0%      19519        softirqs.CPU183.SCHED
    101079           -37.6%      63053 ±  2%  softirqs.CPU183.TIMER
      6801 ±  3%    +185.9%      19443        softirqs.CPU184.SCHED
    100628 ±  2%     -37.9%      62502        softirqs.CPU184.TIMER
      6821 ±  3%    +187.6%      19620        softirqs.CPU185.SCHED
    100772 ±  2%     -37.6%      62928        softirqs.CPU185.TIMER
      6840 ±  4%    +186.6%      19603        softirqs.CPU186.SCHED
    100775 ±  2%     -37.5%      63027        softirqs.CPU186.TIMER
      6789 ±  3%    +186.6%      19458        softirqs.CPU187.SCHED
    100956 ±  2%     -37.7%      62908        softirqs.CPU187.TIMER
      6801 ±  3%    +189.0%      19658        softirqs.CPU188.SCHED
    100524 ±  2%     -37.0%      63306 ±  2%  softirqs.CPU188.TIMER
      6770 ±  2%    +186.9%      19423        softirqs.CPU189.SCHED
    100273 ±  2%     -37.1%      63073        softirqs.CPU189.TIMER
      7024          +175.1%      19324        softirqs.CPU19.SCHED
     96943 ±  2%     -33.9%      64077 ±  2%  softirqs.CPU19.TIMER
      7092 ±  7%    +176.1%      19582        softirqs.CPU190.SCHED
    101337 ±  3%     -37.7%      63147 ±  2%  softirqs.CPU190.TIMER
      6250 ±  3%    +199.6%      18727        softirqs.CPU191.SCHED
     98742 ±  2%     -36.8%      62453        softirqs.CPU191.TIMER
      7050 ±  2%    +177.9%      19589        softirqs.CPU2.SCHED
     96043           -32.9%      64433        softirqs.CPU2.TIMER
      6762 ±  3%    +187.4%      19433        softirqs.CPU20.SCHED
     96053 ±  2%     -33.1%      64261 ±  2%  softirqs.CPU20.TIMER
      6693 ±  3%    +187.6%      19249        softirqs.CPU21.SCHED
     95692 ±  2%     -33.1%      64026 ±  2%  softirqs.CPU21.TIMER
      6850 ±  3%    +183.8%      19445        softirqs.CPU22.SCHED
     95772 ±  2%     -33.0%      64209 ±  2%  softirqs.CPU22.TIMER
      6748 ±  3%    +187.4%      19391        softirqs.CPU23.SCHED
     95083 ±  2%     -32.7%      64032 ±  2%  softirqs.CPU23.TIMER
      6909 ±  2%    +179.9%      19336        softirqs.CPU24.SCHED
     95476           -34.2%      62841 ±  2%  softirqs.CPU24.TIMER
      6834 ±  3%    +187.7%      19660 ±  3%  softirqs.CPU25.SCHED
     95324 ±  2%     -26.3%      70296 ± 14%  softirqs.CPU25.TIMER
      7113          +165.1%      18859 ±  3%  softirqs.CPU26.SCHED
     95952 ±  2%     -33.5%      63788 ±  2%  softirqs.CPU26.TIMER
      6964 ±  4%    +178.7%      19410        softirqs.CPU27.SCHED
     95905 ±  2%     -34.1%      63158 ±  2%  softirqs.CPU27.TIMER
      7075 ±  2%    +173.2%      19331        softirqs.CPU28.SCHED
     96286           -34.5%      63115 ±  2%  softirqs.CPU28.TIMER
      6966          +177.3%      19317        softirqs.CPU29.SCHED
     96183           -34.2%      63296 ±  2%  softirqs.CPU29.TIMER
      6840 ±  3%    +184.8%      19482        softirqs.CPU3.SCHED
     96985           -33.4%      64571 ±  2%  softirqs.CPU3.TIMER
      6721 ±  7%    +186.9%      19285        softirqs.CPU30.SCHED
     94816 ±  2%     -33.3%      63215 ±  3%  softirqs.CPU30.TIMER
      6824 ±  2%    +182.0%      19244        softirqs.CPU31.SCHED
     95537 ±  2%     -33.7%      63330 ±  3%  softirqs.CPU31.TIMER
      7066 ±  7%    +174.5%      19398        softirqs.CPU32.SCHED
     95501 ±  2%     -33.5%      63509 ±  3%  softirqs.CPU32.TIMER
      6848 ±  4%    +183.0%      19381        softirqs.CPU33.SCHED
     95251 ±  2%     -33.2%      63664 ±  2%  softirqs.CPU33.TIMER
      6861 ±  4%     +34.5%       9225 ±  6%  softirqs.CPU34.RCU
      6839 ±  3%    +187.3%      19649 ±  2%  softirqs.CPU34.SCHED
     95539 ±  2%     -32.7%      64301 ±  5%  softirqs.CPU34.TIMER
      7109 ±  6%     +31.1%       9318 ±  6%  softirqs.CPU35.RCU
      6895 ±  4%    +180.8%      19364        softirqs.CPU35.SCHED
     96105 ±  2%     -33.7%      63688 ±  3%  softirqs.CPU35.TIMER
      6840 ±  2%    +186.2%      19580        softirqs.CPU36.SCHED
     95061 ±  2%     -33.0%      63648 ±  3%  softirqs.CPU36.TIMER
      6810 ±  2%    +181.4%      19161        softirqs.CPU37.SCHED
     95033 ±  2%     -33.8%      62920 ±  3%  softirqs.CPU37.TIMER
      6912 ±  3%    +178.8%      19271        softirqs.CPU38.SCHED
     95340 ±  2%     -32.5%      64338 ±  2%  softirqs.CPU38.TIMER
      6775 ±  7%    +186.2%      19389        softirqs.CPU39.SCHED
     95512 ±  2%     -33.8%      63203 ±  3%  softirqs.CPU39.TIMER
      7293 ± 10%    +168.7%      19594        softirqs.CPU4.SCHED
     96230           -32.6%      64849        softirqs.CPU4.TIMER
      6843 ±  2%    +183.1%      19371        softirqs.CPU40.SCHED
     95521 ±  2%     -33.9%      63168 ±  2%  softirqs.CPU40.TIMER
      6768 ±  3%    +185.4%      19314        softirqs.CPU41.SCHED
     95180 ±  2%     -33.9%      62955 ±  3%  softirqs.CPU41.TIMER
      6829 ±  3%    +184.1%      19403        softirqs.CPU42.SCHED
     95450 ±  2%     -33.3%      63665 ±  2%  softirqs.CPU42.TIMER
      6934 ±  2%    +178.8%      19332        softirqs.CPU43.SCHED
     95439 ±  2%     -33.9%      63091 ±  3%  softirqs.CPU43.TIMER
      6905 ±  5%     +31.4%       9076 ± 12%  softirqs.CPU44.RCU
      6797 ±  3%    +187.4%      19540 ±  3%  softirqs.CPU44.SCHED
     95305 ±  2%     -25.5%      70982 ± 13%  softirqs.CPU44.TIMER
      6837 ±  3%    +183.3%      19372        softirqs.CPU45.SCHED
     95168 ±  2%     -33.6%      63173 ±  3%  softirqs.CPU45.TIMER
      6828 ±  2%    +185.0%      19462        softirqs.CPU46.SCHED
     95190 ±  2%     -33.8%      63042 ±  2%  softirqs.CPU46.TIMER
      6895 ±  3%    +183.7%      19565 ±  3%  softirqs.CPU47.SCHED
     95156 ±  2%     -33.2%      63606 ±  3%  softirqs.CPU47.TIMER
      6714 ±  3%    +190.2%      19483        softirqs.CPU48.SCHED
     97203 ±  4%     -34.6%      63569 ±  2%  softirqs.CPU48.TIMER
      6677 ±  2%    +189.6%      19334        softirqs.CPU49.SCHED
     97955 ±  4%     -35.1%      63552 ±  2%  softirqs.CPU49.TIMER
      7333 ± 18%     +32.1%       9684 ±  8%  softirqs.CPU5.RCU
      7173 ±  7%    +176.5%      19832 ±  2%  softirqs.CPU5.SCHED
     97524 ±  2%     -33.1%      65287 ±  3%  softirqs.CPU5.TIMER
      6764 ±  2%    +186.1%      19350        softirqs.CPU50.SCHED
     98331 ±  4%     -35.2%      63704 ±  2%  softirqs.CPU50.TIMER
      6763 ±  3%    +186.1%      19347        softirqs.CPU51.SCHED
     98071 ±  5%     -35.1%      63622 ±  2%  softirqs.CPU51.TIMER
      6863 ±  4%    +183.1%      19430        softirqs.CPU52.SCHED
    114246 ± 19%     -44.2%      63767 ±  2%  softirqs.CPU52.TIMER
      6962 ±  5%    +179.9%      19487        softirqs.CPU53.SCHED
     98493 ±  4%     -35.4%      63673 ±  2%  softirqs.CPU53.TIMER
      6723 ±  3%    +188.5%      19398        softirqs.CPU54.SCHED
     97089 ±  5%     -34.4%      63723 ±  2%  softirqs.CPU54.TIMER
      6831 ±  4%    +182.3%      19281        softirqs.CPU55.SCHED
     97765 ±  3%     -35.1%      63472 ±  2%  softirqs.CPU55.TIMER
      6655 ±  2%    +192.0%      19435        softirqs.CPU56.SCHED
     98076 ±  6%     -35.1%      63687 ±  2%  softirqs.CPU56.TIMER
      6708 ±  2%    +188.4%      19347        softirqs.CPU57.SCHED
     98029 ±  5%     -35.0%      63727 ±  2%  softirqs.CPU57.TIMER
      6795 ±  3%    +185.3%      19383        softirqs.CPU58.SCHED
     98439 ±  5%     -35.3%      63714 ±  2%  softirqs.CPU58.TIMER
      6789 ±  3%    +186.0%      19418        softirqs.CPU59.SCHED
     98505 ±  5%     -35.4%      63676 ±  2%  softirqs.CPU59.TIMER
      7209 ± 12%    +176.6%      19945 ±  3%  softirqs.CPU6.SCHED
     95260 ±  2%     -31.7%      65069 ±  2%  softirqs.CPU6.TIMER
      6697 ±  2%    +189.0%      19354        softirqs.CPU60.SCHED
     97374 ±  4%     -34.6%      63650 ±  2%  softirqs.CPU60.TIMER
      6619 ±  4%    +192.3%      19348        softirqs.CPU61.SCHED
    111226 ± 24%     -42.8%      63647 ±  2%  softirqs.CPU61.TIMER
      6768 ±  3%    +187.6%      19467        softirqs.CPU62.SCHED
     97767 ±  5%     -34.8%      63722 ±  2%  softirqs.CPU62.TIMER
      6740 ±  3%    +187.3%      19365        softirqs.CPU63.SCHED
     98212 ±  5%     -35.2%      63689 ±  2%  softirqs.CPU63.TIMER
      6735 ±  2%    +184.6%      19166 ±  2%  softirqs.CPU64.SCHED
     97738 ±  5%     -34.9%      63593 ±  2%  softirqs.CPU64.TIMER
      6719 ±  6%    +189.6%      19463        softirqs.CPU65.SCHED
     97758 ±  4%     -34.9%      63669 ±  2%  softirqs.CPU65.TIMER
      6794          +184.8%      19348        softirqs.CPU66.SCHED
     97784 ±  5%     -34.8%      63717 ±  2%  softirqs.CPU66.TIMER
      6836 ±  4%    +183.0%      19347        softirqs.CPU67.SCHED
     97869 ±  4%     -34.8%      63762 ±  2%  softirqs.CPU67.TIMER
      6715 ±  4%    +189.0%      19408        softirqs.CPU68.SCHED
     98304 ±  3%     -35.2%      63747 ±  2%  softirqs.CPU68.TIMER
      7010 ±  5%    +176.0%      19350        softirqs.CPU69.SCHED
    110648 ± 19%     -42.5%      63622 ±  2%  softirqs.CPU69.TIMER
      6729 ±  4%    +188.8%      19438        softirqs.CPU7.SCHED
     95632           -32.4%      64621 ±  2%  softirqs.CPU7.TIMER
      6781 ±  3%     +38.4%       9385 ±  4%  softirqs.CPU70.RCU
      6749 ±  4%    +185.3%      19258 ±  2%  softirqs.CPU70.SCHED
     97741 ±  4%     -34.1%      64401 ±  2%  softirqs.CPU70.TIMER
      6682 ±  4%     +40.1%       9360 ±  4%  softirqs.CPU71.RCU
      6919 ±  4%    +183.5%      19613        softirqs.CPU71.SCHED
     97272 ±  5%     -34.0%      64163 ±  2%  softirqs.CPU71.TIMER
      7191 ±  8%    +177.7%      19969 ±  3%  softirqs.CPU72.SCHED
    101893 ±  2%     -37.0%      64220 ±  2%  softirqs.CPU72.TIMER
      7014 ±  6%    +175.2%      19302        softirqs.CPU73.SCHED
    101890 ±  2%     -38.0%      63200 ±  2%  softirqs.CPU73.TIMER
      6949 ±  4%    +179.2%      19406        softirqs.CPU74.SCHED
    101634 ±  2%     -37.5%      63563 ±  3%  softirqs.CPU74.TIMER
      7045 ±  4%    +177.2%      19530        softirqs.CPU75.SCHED
    101688 ±  2%     -37.6%      63497 ±  2%  softirqs.CPU75.TIMER
      7100 ±  4%    +174.4%      19485        softirqs.CPU76.SCHED
    102191 ±  2%     -37.9%      63464 ±  2%  softirqs.CPU76.TIMER
      7045 ±  4%    +175.6%      19415        softirqs.CPU77.SCHED
    102040 ±  2%     -37.9%      63406 ±  2%  softirqs.CPU77.TIMER
      6758 ±  4%    +187.7%      19446        softirqs.CPU78.SCHED
    100791 ±  2%     -36.9%      63574 ±  2%  softirqs.CPU78.TIMER
      6811 ±  4%    +183.2%      19291        softirqs.CPU79.SCHED
    101040 ±  2%     -37.4%      63256 ±  2%  softirqs.CPU79.TIMER
      6782 ±  3%    +193.1%      19879 ±  3%  softirqs.CPU8.SCHED
     95699 ±  2%     -32.3%      64767 ±  2%  softirqs.CPU8.TIMER
      6804 ±  3%    +183.7%      19307        softirqs.CPU80.SCHED
    100615 ±  2%     -36.8%      63545 ±  3%  softirqs.CPU80.TIMER
      6791 ±  3%    +186.2%      19435        softirqs.CPU81.SCHED
    100944 ±  2%     -36.9%      63696 ±  2%  softirqs.CPU81.TIMER
      6837 ±  3%    +182.3%      19300        softirqs.CPU82.SCHED
    101267           -37.5%      63290 ±  2%  softirqs.CPU82.TIMER
      6939 ±  2%    +181.8%      19556        softirqs.CPU83.SCHED
    101972 ±  2%     -37.2%      64025 ±  3%  softirqs.CPU83.TIMER
      6759 ±  2%    +186.3%      19353        softirqs.CPU84.SCHED
    100731 ±  2%     -36.9%      63576 ±  2%  softirqs.CPU84.TIMER
      6554 ±  5%     +34.1%       8791 ±  8%  softirqs.CPU85.RCU
      6844 ±  3%    +187.2%      19657 ±  2%  softirqs.CPU85.SCHED
    100899 ±  2%     -36.2%      64395 ±  4%  softirqs.CPU85.TIMER
      6892 ±  3%    +181.5%      19401        softirqs.CPU86.SCHED
    101282           -36.4%      64430 ±  3%  softirqs.CPU86.TIMER
      6914 ±  4%    +183.2%      19581        softirqs.CPU87.SCHED
    101511           -36.7%      64283 ±  3%  softirqs.CPU87.TIMER
      6847 ±  4%    +182.6%      19352        softirqs.CPU88.SCHED
    101185           -37.6%      63106 ±  2%  softirqs.CPU88.TIMER
      6868 ±  4%    +178.2%      19108 ±  3%  softirqs.CPU89.SCHED
    101467           -37.6%      63364        softirqs.CPU89.TIMER
      6829 ±  3%    +183.9%      19392        softirqs.CPU9.SCHED
     95894           -32.7%      64548 ±  2%  softirqs.CPU9.TIMER
      6890 ±  3%    +181.8%      19413        softirqs.CPU90.SCHED
    101717 ±  2%     -37.8%      63222 ±  2%  softirqs.CPU90.TIMER
      6575 ±  6%     +35.9%       8937 ±  8%  softirqs.CPU91.RCU
      6869 ±  4%    +184.8%      19561 ±  2%  softirqs.CPU91.SCHED
    101249           -36.1%      64650 ±  3%  softirqs.CPU91.TIMER
      7055 ±  7%    +172.6%      19235 ±  2%  softirqs.CPU92.SCHED
    101737           -37.2%      63855 ±  2%  softirqs.CPU92.TIMER
      6944 ±  5%    +178.3%      19326        softirqs.CPU93.SCHED
    101119 ±  2%     -37.3%      63384 ±  2%  softirqs.CPU93.TIMER
      6936 ±  6%    +179.8%      19409        softirqs.CPU94.SCHED
    101487           -37.6%      63339 ±  2%  softirqs.CPU94.TIMER
    101618           -37.1%      63923        softirqs.CPU95.TIMER
      5778 ± 17%    +217.4%      18341 ±  3%  softirqs.CPU96.SCHED
     93769 ±  3%     -32.0%      63784 ±  2%  softirqs.CPU96.TIMER
      6115 ±  8%    +216.6%      19358 ±  2%  softirqs.CPU97.SCHED
     94072 ±  2%     -32.3%      63732 ±  2%  softirqs.CPU97.TIMER
      6993 ± 14%     +93.7%      13549        softirqs.CPU98.RCU
      6676 ±  3%    +197.2%      19842 ±  2%  softirqs.CPU98.SCHED
     95690 ±  2%     -27.8%      69082 ±  2%  softirqs.CPU98.TIMER
      6976 ±  4%    +184.2%      19830 ±  2%  softirqs.CPU99.SCHED
     96177 ±  2%     -32.8%      64589 ±  2%  softirqs.CPU99.TIMER
   1269326 ±  4%     +31.6%    1671034 ±  2%  softirqs.RCU
   1319694 ±  3%    +183.4%    3740623        softirqs.SCHED
  18769976 ±  2%     -34.8%   12244934        softirqs.TIMER
      2417 ±133%     -88.5%     279.25 ± 70%  interrupts.33:PCI-MSI.524291-edge.eth0-TxRx-2
    559.00 ±  3%     -45.3%     306.00        interrupts.9:IO-APIC.9-fasteoi.acpi
    165388 ±  7%      -5.7%     156030        interrupts.CAL:Function_call_interrupts
    559036 ±  3%     -45.6%     304036        interrupts.CPU0.LOC:Local_timer_interrupts
      6548 ± 33%     -68.2%       2083 ± 32%  interrupts.CPU0.NMI:Non-maskable_interrupts
      6548 ± 33%     -68.2%       2083 ± 32%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
      7188 ± 11%     -84.0%       1148 ± 63%  interrupts.CPU0.RES:Rescheduling_interrupts
    559.00 ±  3%     -45.3%     306.00        interrupts.CPU1.9:IO-APIC.9-fasteoi.acpi
    559001 ±  3%     -45.6%     304105        interrupts.CPU1.LOC:Local_timer_interrupts
      8748           -78.4%       1887 ± 42%  interrupts.CPU1.NMI:Non-maskable_interrupts
      8748           -78.4%       1887 ± 42%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
      6398 ±  7%     -79.4%       1316 ± 56%  interrupts.CPU1.RES:Rescheduling_interrupts
    559045 ±  3%     -45.6%     304144        interrupts.CPU10.LOC:Local_timer_interrupts
      7646 ± 24%     -69.6%       2322 ± 13%  interrupts.CPU10.NMI:Non-maskable_interrupts
      7646 ± 24%     -69.6%       2322 ± 13%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
      6027 ±  6%     -97.4%     157.25 ± 11%  interrupts.CPU10.RES:Rescheduling_interrupts
    559018 ±  3%     -45.6%     304126        interrupts.CPU100.LOC:Local_timer_interrupts
      8751           -74.0%       2276 ± 23%  interrupts.CPU100.NMI:Non-maskable_interrupts
      8751           -74.0%       2276 ± 23%  interrupts.CPU100.PMI:Performance_monitoring_interrupts
      5789 ±  6%     -97.8%     126.75 ± 10%  interrupts.CPU100.RES:Rescheduling_interrupts
    559000 ±  3%     -45.6%     304101        interrupts.CPU101.LOC:Local_timer_interrupts
      8732           -72.4%       2408 ± 25%  interrupts.CPU101.NMI:Non-maskable_interrupts
      8732           -72.4%       2408 ± 25%  interrupts.CPU101.PMI:Performance_monitoring_interrupts
      5891 ±  7%     -97.7%     136.75 ±  5%  interrupts.CPU101.RES:Rescheduling_interrupts
    558958 ±  3%     -45.6%     304140        interrupts.CPU102.LOC:Local_timer_interrupts
      8741           -75.1%       2174 ± 35%  interrupts.CPU102.NMI:Non-maskable_interrupts
      8741           -75.1%       2174 ± 35%  interrupts.CPU102.PMI:Performance_monitoring_interrupts
      5757 ±  7%     -97.7%     130.75 ± 12%  interrupts.CPU102.RES:Rescheduling_interrupts
    558940 ±  3%     -45.6%     304063        interrupts.CPU103.LOC:Local_timer_interrupts
      8745           -74.6%       2217 ± 26%  interrupts.CPU103.NMI:Non-maskable_interrupts
      8745           -74.6%       2217 ± 26%  interrupts.CPU103.PMI:Performance_monitoring_interrupts
      5869 ±  6%     -97.5%     146.50 ±  9%  interrupts.CPU103.RES:Rescheduling_interrupts
    559002 ±  3%     -45.6%     304068        interrupts.CPU104.LOC:Local_timer_interrupts
      8743           -75.4%       2151 ± 29%  interrupts.CPU104.NMI:Non-maskable_interrupts
      8743           -75.4%       2151 ± 29%  interrupts.CPU104.PMI:Performance_monitoring_interrupts
      5787 ±  4%     -97.6%     136.25 ±  6%  interrupts.CPU104.RES:Rescheduling_interrupts
    558963 ±  3%     -45.6%     304066        interrupts.CPU105.LOC:Local_timer_interrupts
      8721           -73.6%       2298 ± 29%  interrupts.CPU105.NMI:Non-maskable_interrupts
      8721           -73.6%       2298 ± 29%  interrupts.CPU105.PMI:Performance_monitoring_interrupts
      5765 ±  7%     -97.8%     124.00 ±  7%  interrupts.CPU105.RES:Rescheduling_interrupts
    558952 ±  3%     -45.6%     304076        interrupts.CPU106.LOC:Local_timer_interrupts
      7644 ± 24%     -75.8%       1850 ± 39%  interrupts.CPU106.NMI:Non-maskable_interrupts
      7644 ± 24%     -75.8%       1850 ± 39%  interrupts.CPU106.PMI:Performance_monitoring_interrupts
      5845 ±  7%     -97.8%     128.25 ±  5%  interrupts.CPU106.RES:Rescheduling_interrupts
    558948 ±  3%     -45.6%     304067        interrupts.CPU107.LOC:Local_timer_interrupts
      7647 ± 24%     -69.6%       2326 ± 28%  interrupts.CPU107.NMI:Non-maskable_interrupts
      7647 ± 24%     -69.6%       2326 ± 28%  interrupts.CPU107.PMI:Performance_monitoring_interrupts
      5717 ±  4%     -97.6%     135.25 ±  8%  interrupts.CPU107.RES:Rescheduling_interrupts
    558949 ±  3%     -45.6%     304092        interrupts.CPU108.LOC:Local_timer_interrupts
      7632 ± 24%     -69.9%       2295 ± 27%  interrupts.CPU108.NMI:Non-maskable_interrupts
      7632 ± 24%     -69.9%       2295 ± 27%  interrupts.CPU108.PMI:Performance_monitoring_interrupts
      5731 ±  4%     -97.6%     137.75 ±  7%  interrupts.CPU108.RES:Rescheduling_interrupts
    558950 ±  3%     -45.6%     304072        interrupts.CPU109.LOC:Local_timer_interrupts
      7655 ± 24%     -71.4%       2188 ± 25%  interrupts.CPU109.NMI:Non-maskable_interrupts
      7655 ± 24%     -71.4%       2188 ± 25%  interrupts.CPU109.PMI:Performance_monitoring_interrupts
      5786 ±  8%     -97.8%     130.00 ± 17%  interrupts.CPU109.RES:Rescheduling_interrupts
      2417 ±133%     -88.5%     279.25 ± 70%  interrupts.CPU11.33:PCI-MSI.524291-edge.eth0-TxRx-2
    558980 ±  3%     -45.6%     304086        interrupts.CPU11.LOC:Local_timer_interrupts
      8760           -71.4%       2502 ± 12%  interrupts.CPU11.NMI:Non-maskable_interrupts
      8760           -71.4%       2502 ± 12%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
      5959 ±  7%     -97.6%     144.50 ±  4%  interrupts.CPU11.RES:Rescheduling_interrupts
      1.75 ±109%   +5142.9%      91.75 ±132%  interrupts.CPU11.TLB:TLB_shootdowns
    558926 ±  3%     -45.6%     304064        interrupts.CPU110.LOC:Local_timer_interrupts
      7628 ± 24%     -65.8%       2607 ±  5%  interrupts.CPU110.NMI:Non-maskable_interrupts
      7628 ± 24%     -65.8%       2607 ±  5%  interrupts.CPU110.PMI:Performance_monitoring_interrupts
      5989 ±  7%     -97.9%     123.25 ±  3%  interrupts.CPU110.RES:Rescheduling_interrupts
    558956 ±  3%     -45.6%     304061        interrupts.CPU111.LOC:Local_timer_interrupts
      7658 ± 24%     -65.8%       2616 ±  8%  interrupts.CPU111.NMI:Non-maskable_interrupts
      7658 ± 24%     -65.8%       2616 ±  8%  interrupts.CPU111.PMI:Performance_monitoring_interrupts
      5811 ±  5%     -97.7%     134.75 ±  6%  interrupts.CPU111.RES:Rescheduling_interrupts
    558922 ±  3%     -45.6%     304085        interrupts.CPU112.LOC:Local_timer_interrupts
      7643 ± 24%     -65.9%       2603 ±  9%  interrupts.CPU112.NMI:Non-maskable_interrupts
      7643 ± 24%     -65.9%       2603 ±  9%  interrupts.CPU112.PMI:Performance_monitoring_interrupts
      5791 ±  7%     -97.9%     121.00 ± 14%  interrupts.CPU112.RES:Rescheduling_interrupts
    558954 ±  3%     -45.6%     304054        interrupts.CPU113.LOC:Local_timer_interrupts
      8751           -70.1%       2613 ±  8%  interrupts.CPU113.NMI:Non-maskable_interrupts
      8751           -70.1%       2613 ±  8%  interrupts.CPU113.PMI:Performance_monitoring_interrupts
      5769 ±  8%     -97.6%     137.50 ±  6%  interrupts.CPU113.RES:Rescheduling_interrupts
    558963 ±  3%     -45.6%     304053        interrupts.CPU114.LOC:Local_timer_interrupts
      8724           -69.7%       2642 ± 12%  interrupts.CPU114.NMI:Non-maskable_interrupts
      8724           -69.7%       2642 ± 12%  interrupts.CPU114.PMI:Performance_monitoring_interrupts
      5792 ±  9%     -97.8%     125.50 ±  4%  interrupts.CPU114.RES:Rescheduling_interrupts
    558926 ±  3%     -45.6%     304059        interrupts.CPU115.LOC:Local_timer_interrupts
      8750           -71.0%       2539 ±  9%  interrupts.CPU115.NMI:Non-maskable_interrupts
      8750           -71.0%       2539 ±  9%  interrupts.CPU115.PMI:Performance_monitoring_interrupts
      5843 ± 10%     -97.7%     131.50 ±  8%  interrupts.CPU115.RES:Rescheduling_interrupts
    558952 ±  3%     -45.6%     304065        interrupts.CPU116.LOC:Local_timer_interrupts
      8743           -75.2%       2166 ± 10%  interrupts.CPU116.NMI:Non-maskable_interrupts
      8743           -75.2%       2166 ± 10%  interrupts.CPU116.PMI:Performance_monitoring_interrupts
      5874 ±  7%     -97.8%     128.75 ±  7%  interrupts.CPU116.RES:Rescheduling_interrupts
    558927 ±  3%     -45.6%     304072        interrupts.CPU117.LOC:Local_timer_interrupts
      8736           -70.2%       2607 ± 10%  interrupts.CPU117.NMI:Non-maskable_interrupts
      8736           -70.2%       2607 ± 10%  interrupts.CPU117.PMI:Performance_monitoring_interrupts
      5838 ±  8%     -97.8%     128.25 ± 12%  interrupts.CPU117.RES:Rescheduling_interrupts
    558951 ±  3%     -45.6%     304063        interrupts.CPU118.LOC:Local_timer_interrupts
      7642 ± 24%     -66.7%       2541 ± 11%  interrupts.CPU118.NMI:Non-maskable_interrupts
      7642 ± 24%     -66.7%       2541 ± 11%  interrupts.CPU118.PMI:Performance_monitoring_interrupts
      5810 ±  7%     -98.0%     118.75 ± 10%  interrupts.CPU118.RES:Rescheduling_interrupts
    558954 ±  3%     -45.6%     304064        interrupts.CPU119.LOC:Local_timer_interrupts
      7634 ± 24%     -66.1%       2587 ±  9%  interrupts.CPU119.NMI:Non-maskable_interrupts
      7634 ± 24%     -66.1%       2587 ±  9%  interrupts.CPU119.PMI:Performance_monitoring_interrupts
      5656 ±  8%     -97.4%     145.75 ± 13%  interrupts.CPU119.RES:Rescheduling_interrupts
     35.50 ±160%    +554.9%     232.50 ± 14%  interrupts.CPU119.TLB:TLB_shootdowns
    559004 ±  3%     -45.6%     304084        interrupts.CPU12.LOC:Local_timer_interrupts
      8723           -74.4%       2236 ± 23%  interrupts.CPU12.NMI:Non-maskable_interrupts
      8723           -74.4%       2236 ± 23%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
      5799 ±  6%     -97.7%     133.50 ±  8%  interrupts.CPU12.RES:Rescheduling_interrupts
    559021 ±  3%     -45.6%     304158        interrupts.CPU120.LOC:Local_timer_interrupts
      7655 ± 24%     -65.7%       2626 ±  5%  interrupts.CPU120.NMI:Non-maskable_interrupts
      7655 ± 24%     -65.7%       2626 ±  5%  interrupts.CPU120.PMI:Performance_monitoring_interrupts
      5726 ±  6%     -97.6%     136.75 ±  7%  interrupts.CPU120.RES:Rescheduling_interrupts
    558997 ±  3%     -45.6%     304092        interrupts.CPU121.LOC:Local_timer_interrupts
      7644 ± 24%     -67.0%       2519 ± 11%  interrupts.CPU121.NMI:Non-maskable_interrupts
      7644 ± 24%     -67.0%       2519 ± 11%  interrupts.CPU121.PMI:Performance_monitoring_interrupts
      5886 ±  6%     -97.8%     129.50 ±  8%  interrupts.CPU121.RES:Rescheduling_interrupts
    559024 ±  3%     -45.6%     304139        interrupts.CPU122.LOC:Local_timer_interrupts
      7649 ± 24%     -68.7%       2398 ± 20%  interrupts.CPU122.NMI:Non-maskable_interrupts
      7649 ± 24%     -68.7%       2398 ± 20%  interrupts.CPU122.PMI:Performance_monitoring_interrupts
      5835 ±  4%     -97.7%     133.50 ±  5%  interrupts.CPU122.RES:Rescheduling_interrupts
    558992 ±  3%     -45.6%     304158        interrupts.CPU123.LOC:Local_timer_interrupts
      7633 ± 24%     -67.9%       2448 ± 13%  interrupts.CPU123.NMI:Non-maskable_interrupts
      7633 ± 24%     -67.9%       2448 ± 13%  interrupts.CPU123.PMI:Performance_monitoring_interrupts
      5739 ±  5%     -97.8%     126.75 ±  3%  interrupts.CPU123.RES:Rescheduling_interrupts
    559003 ±  3%     -45.6%     304163        interrupts.CPU124.LOC:Local_timer_interrupts
      7660 ± 24%     -69.4%       2341 ± 12%  interrupts.CPU124.NMI:Non-maskable_interrupts
      7660 ± 24%     -69.4%       2341 ± 12%  interrupts.CPU124.PMI:Performance_monitoring_interrupts
      5846 ±  7%     -98.0%     119.75 ± 10%  interrupts.CPU124.RES:Rescheduling_interrupts
    559058 ±  3%     -45.6%     304166        interrupts.CPU125.LOC:Local_timer_interrupts
      7639 ± 24%     -63.0%       2827 ±  2%  interrupts.CPU125.NMI:Non-maskable_interrupts
      7639 ± 24%     -63.0%       2827 ±  2%  interrupts.CPU125.PMI:Performance_monitoring_interrupts
      5665 ±  3%     -97.6%     133.50 ± 13%  interrupts.CPU125.RES:Rescheduling_interrupts
    559000 ±  3%     -45.6%     304169        interrupts.CPU126.LOC:Local_timer_interrupts
      8746           -70.0%       2627 ±  7%  interrupts.CPU126.NMI:Non-maskable_interrupts
      8746           -70.0%       2627 ±  7%  interrupts.CPU126.PMI:Performance_monitoring_interrupts
      5878 ±  5%     -97.9%     122.00 ±  6%  interrupts.CPU126.RES:Rescheduling_interrupts
    558985 ±  3%     -45.6%     304051        interrupts.CPU127.LOC:Local_timer_interrupts
      8735           -73.5%       2311 ± 17%  interrupts.CPU127.NMI:Non-maskable_interrupts
      8735           -73.5%       2311 ± 17%  interrupts.CPU127.PMI:Performance_monitoring_interrupts
      5851 ±  8%     -97.6%     139.25 ±  7%  interrupts.CPU127.RES:Rescheduling_interrupts
    558997 ±  3%     -45.6%     304168        interrupts.CPU128.LOC:Local_timer_interrupts
      8699           -72.3%       2406 ±  6%  interrupts.CPU128.NMI:Non-maskable_interrupts
      8699           -72.3%       2406 ±  6%  interrupts.CPU128.PMI:Performance_monitoring_interrupts
      5984 ±  7%     -97.9%     124.00 ± 10%  interrupts.CPU128.RES:Rescheduling_interrupts
    559017 ±  3%     -45.6%     304188        interrupts.CPU129.LOC:Local_timer_interrupts
      8747           -73.2%       2347 ± 16%  interrupts.CPU129.NMI:Non-maskable_interrupts
      8747           -73.2%       2347 ± 16%  interrupts.CPU129.PMI:Performance_monitoring_interrupts
      5798 ±  7%     -97.8%     128.00 ± 13%  interrupts.CPU129.RES:Rescheduling_interrupts
    559022 ±  3%     -45.6%     304134        interrupts.CPU13.LOC:Local_timer_interrupts
      8743           -72.1%       2439 ± 18%  interrupts.CPU13.NMI:Non-maskable_interrupts
      8743           -72.1%       2439 ± 18%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
      6001 ±  7%     -97.4%     157.25 ± 11%  interrupts.CPU13.RES:Rescheduling_interrupts
    558999 ±  3%     -45.6%     304180        interrupts.CPU130.LOC:Local_timer_interrupts
      7662 ± 24%     -68.2%       2440 ± 14%  interrupts.CPU130.NMI:Non-maskable_interrupts
      7662 ± 24%     -68.2%       2440 ± 14%  interrupts.CPU130.PMI:Performance_monitoring_interrupts
      5754 ±  5%     -97.9%     122.75 ±  7%  interrupts.CPU130.RES:Rescheduling_interrupts
    558992 ±  3%     -45.6%     304172        interrupts.CPU131.LOC:Local_timer_interrupts
      7632 ± 24%     -67.3%       2498 ±  9%  interrupts.CPU131.NMI:Non-maskable_interrupts
      7632 ± 24%     -67.3%       2498 ±  9%  interrupts.CPU131.PMI:Performance_monitoring_interrupts
      5723 ±  6%     -97.7%     131.75 ±  7%  interrupts.CPU131.RES:Rescheduling_interrupts
    559010 ±  3%     -45.6%     304177        interrupts.CPU132.LOC:Local_timer_interrupts
      7666 ± 25%     -66.1%       2596 ±  7%  interrupts.CPU132.NMI:Non-maskable_interrupts
      7666 ± 25%     -66.1%       2596 ±  7%  interrupts.CPU132.PMI:Performance_monitoring_interrupts
      5807 ±  7%     -97.7%     132.25 ±  6%  interrupts.CPU132.RES:Rescheduling_interrupts
    559014 ±  3%     -45.6%     304177        interrupts.CPU133.LOC:Local_timer_interrupts
      7647 ± 24%     -68.2%       2429 ±  4%  interrupts.CPU133.NMI:Non-maskable_interrupts
      7647 ± 24%     -68.2%       2429 ±  4%  interrupts.CPU133.PMI:Performance_monitoring_interrupts
      5813 ±  4%     -97.9%     119.25 ±  6%  interrupts.CPU133.RES:Rescheduling_interrupts
    559015 ±  3%     -45.6%     304180        interrupts.CPU134.LOC:Local_timer_interrupts
      7636 ± 24%     -66.8%       2531 ±  7%  interrupts.CPU134.NMI:Non-maskable_interrupts
      7636 ± 24%     -66.8%       2531 ±  7%  interrupts.CPU134.PMI:Performance_monitoring_interrupts
      5753 ±  4%     -97.9%     123.50 ± 11%  interrupts.CPU134.RES:Rescheduling_interrupts
    559069 ±  3%     -45.6%     304171        interrupts.CPU135.LOC:Local_timer_interrupts
      7653 ± 24%     -67.9%       2453 ± 15%  interrupts.CPU135.NMI:Non-maskable_interrupts
      7653 ± 24%     -67.9%       2453 ± 15%  interrupts.CPU135.PMI:Performance_monitoring_interrupts
      5770 ±  5%     -97.9%     122.25 ±  4%  interrupts.CPU135.RES:Rescheduling_interrupts
    559038 ±  3%     -45.6%     304176        interrupts.CPU136.LOC:Local_timer_interrupts
      7637 ± 24%     -67.7%       2467 ± 17%  interrupts.CPU136.NMI:Non-maskable_interrupts
      7637 ± 24%     -67.7%       2467 ± 17%  interrupts.CPU136.PMI:Performance_monitoring_interrupts
      5815 ±  7%     -97.6%     140.50 ±  2%  interrupts.CPU136.RES:Rescheduling_interrupts
    559036 ±  3%     -45.6%     304176        interrupts.CPU137.LOC:Local_timer_interrupts
      7627 ± 24%     -66.8%       2531 ± 15%  interrupts.CPU137.NMI:Non-maskable_interrupts
      7627 ± 24%     -66.8%       2531 ± 15%  interrupts.CPU137.PMI:Performance_monitoring_interrupts
      5667 ±  7%     -97.8%     125.00 ± 10%  interrupts.CPU137.RES:Rescheduling_interrupts
    559038 ±  3%     -45.6%     304194        interrupts.CPU138.LOC:Local_timer_interrupts
      7645 ± 24%     -64.8%       2694 ± 10%  interrupts.CPU138.NMI:Non-maskable_interrupts
      7645 ± 24%     -64.8%       2694 ± 10%  interrupts.CPU138.PMI:Performance_monitoring_interrupts
      5623 ±  5%     -97.7%     127.00 ±  6%  interrupts.CPU138.RES:Rescheduling_interrupts
    559016 ±  3%     -45.6%     304171        interrupts.CPU139.LOC:Local_timer_interrupts
      7655 ± 24%     -71.7%       2168 ± 27%  interrupts.CPU139.NMI:Non-maskable_interrupts
      7655 ± 24%     -71.7%       2168 ± 27%  interrupts.CPU139.PMI:Performance_monitoring_interrupts
      5860 ±  7%     -97.9%     125.25 ±  3%  interrupts.CPU139.RES:Rescheduling_interrupts
    558999 ±  3%     -45.6%     304074        interrupts.CPU14.LOC:Local_timer_interrupts
      8754           -69.7%       2656 ±  4%  interrupts.CPU14.NMI:Non-maskable_interrupts
      8754           -69.7%       2656 ±  4%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
      5953 ±  6%     -97.5%     150.75 ± 10%  interrupts.CPU14.RES:Rescheduling_interrupts
    558996 ±  3%     -45.6%     304189        interrupts.CPU140.LOC:Local_timer_interrupts
      7646 ± 24%     -66.8%       2538 ± 19%  interrupts.CPU140.NMI:Non-maskable_interrupts
      7646 ± 24%     -66.8%       2538 ± 19%  interrupts.CPU140.PMI:Performance_monitoring_interrupts
      5798 ±  7%     -97.8%     128.50 ±  9%  interrupts.CPU140.RES:Rescheduling_interrupts
    559032 ±  3%     -45.6%     304165        interrupts.CPU141.LOC:Local_timer_interrupts
      7657 ± 24%     -68.9%       2378 ± 17%  interrupts.CPU141.NMI:Non-maskable_interrupts
      7657 ± 24%     -68.9%       2378 ± 17%  interrupts.CPU141.PMI:Performance_monitoring_interrupts
      5894 ±  5%     -97.9%     124.75 ±  5%  interrupts.CPU141.RES:Rescheduling_interrupts
    558989 ±  3%     -45.6%     304180        interrupts.CPU142.LOC:Local_timer_interrupts
      7644 ± 24%     -67.6%       2474 ± 13%  interrupts.CPU142.NMI:Non-maskable_interrupts
      7644 ± 24%     -67.6%       2474 ± 13%  interrupts.CPU142.PMI:Performance_monitoring_interrupts
      5693 ±  8%     -97.9%     117.50 ±  9%  interrupts.CPU142.RES:Rescheduling_interrupts
      4.00 ± 30%   +2168.8%      90.75 ± 28%  interrupts.CPU142.TLB:TLB_shootdowns
    559024 ±  3%     -45.6%     304137        interrupts.CPU143.LOC:Local_timer_interrupts
      8737           -71.4%       2498 ± 15%  interrupts.CPU143.NMI:Non-maskable_interrupts
      8737           -71.4%       2498 ± 15%  interrupts.CPU143.PMI:Performance_monitoring_interrupts
      5841 ±  7%     -97.7%     134.50 ± 14%  interrupts.CPU143.RES:Rescheduling_interrupts
      6.50 ± 72%   +3130.8%     210.00 ± 29%  interrupts.CPU143.TLB:TLB_shootdowns
    558934 ±  3%     -45.7%     303384        interrupts.CPU144.LOC:Local_timer_interrupts
      8725           -71.0%       2527 ±  9%  interrupts.CPU144.NMI:Non-maskable_interrupts
      8725           -71.0%       2527 ±  9%  interrupts.CPU144.PMI:Performance_monitoring_interrupts
      5913 ±  8%     -97.9%     125.25 ± 12%  interrupts.CPU144.RES:Rescheduling_interrupts
    558942 ±  3%     -45.7%     303375        interrupts.CPU145.LOC:Local_timer_interrupts
      8737           -69.5%       2667 ± 20%  interrupts.CPU145.NMI:Non-maskable_interrupts
      8737           -69.5%       2667 ± 20%  interrupts.CPU145.PMI:Performance_monitoring_interrupts
      5892 ±  6%     -97.8%     127.25 ± 14%  interrupts.CPU145.RES:Rescheduling_interrupts
    558841 ±  3%     -45.7%     303385        interrupts.CPU146.LOC:Local_timer_interrupts
      7659 ± 24%     -68.7%       2395 ± 13%  interrupts.CPU146.NMI:Non-maskable_interrupts
      7659 ± 24%     -68.7%       2395 ± 13%  interrupts.CPU146.PMI:Performance_monitoring_interrupts
      5741 ±  8%     -97.7%     132.25 ±  7%  interrupts.CPU146.RES:Rescheduling_interrupts
    558885 ±  3%     -45.7%     303379        interrupts.CPU147.LOC:Local_timer_interrupts
      7652 ± 24%     -69.3%       2352 ±  8%  interrupts.CPU147.NMI:Non-maskable_interrupts
      7652 ± 24%     -69.3%       2352 ±  8%  interrupts.CPU147.PMI:Performance_monitoring_interrupts
      6010 ±  7%     -97.8%     132.75 ± 12%  interrupts.CPU147.RES:Rescheduling_interrupts
    558961 ±  3%     -45.7%     303378        interrupts.CPU148.LOC:Local_timer_interrupts
      8732           -72.6%       2393 ± 14%  interrupts.CPU148.NMI:Non-maskable_interrupts
      8732           -72.6%       2393 ± 14%  interrupts.CPU148.PMI:Performance_monitoring_interrupts
      5832 ±  5%     -97.8%     130.50 ±  9%  interrupts.CPU148.RES:Rescheduling_interrupts
    558933 ±  3%     -45.7%     303376        interrupts.CPU149.LOC:Local_timer_interrupts
      7655 ± 24%     -65.7%       2628 ±  9%  interrupts.CPU149.NMI:Non-maskable_interrupts
      7655 ± 24%     -65.7%       2628 ±  9%  interrupts.CPU149.PMI:Performance_monitoring_interrupts
      5828 ±  5%     -97.6%     139.50        interrupts.CPU149.RES:Rescheduling_interrupts
    558993 ±  3%     -45.6%     304093        interrupts.CPU15.LOC:Local_timer_interrupts
      8732           -71.5%       2487 ±  9%  interrupts.CPU15.NMI:Non-maskable_interrupts
      8732           -71.5%       2487 ±  9%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
      5942 ±  7%     -97.4%     156.75 ±  6%  interrupts.CPU15.RES:Rescheduling_interrupts
      2.75 ± 97%   +1854.5%      53.75 ± 60%  interrupts.CPU15.TLB:TLB_shootdowns
    558946 ±  3%     -45.7%     303382        interrupts.CPU150.LOC:Local_timer_interrupts
      7647 ± 24%     -65.8%       2617 ± 20%  interrupts.CPU150.NMI:Non-maskable_interrupts
      7647 ± 24%     -65.8%       2617 ± 20%  interrupts.CPU150.PMI:Performance_monitoring_interrupts
      6012 ±  6%     -97.8%     133.75 ±  7%  interrupts.CPU150.RES:Rescheduling_interrupts
    558937 ±  3%     -45.7%     303374        interrupts.CPU151.LOC:Local_timer_interrupts
      7648 ± 24%     -64.9%       2687 ±  9%  interrupts.CPU151.NMI:Non-maskable_interrupts
      7648 ± 24%     -64.9%       2687 ±  9%  interrupts.CPU151.PMI:Performance_monitoring_interrupts
      5834 ±  6%     -97.8%     129.75 ±  8%  interrupts.CPU151.RES:Rescheduling_interrupts
    558939 ±  3%     -45.7%     303417        interrupts.CPU152.LOC:Local_timer_interrupts
      7645 ± 24%     -67.3%       2500 ± 11%  interrupts.CPU152.NMI:Non-maskable_interrupts
      7645 ± 24%     -67.3%       2500 ± 11%  interrupts.CPU152.PMI:Performance_monitoring_interrupts
      5828 ±  4%     -98.0%     117.00 ± 13%  interrupts.CPU152.RES:Rescheduling_interrupts
    558943 ±  3%     -45.7%     303403        interrupts.CPU153.LOC:Local_timer_interrupts
      7652 ± 24%     -70.4%       2267 ± 35%  interrupts.CPU153.NMI:Non-maskable_interrupts
      7652 ± 24%     -70.4%       2267 ± 35%  interrupts.CPU153.PMI:Performance_monitoring_interrupts
      5877 ±  6%     -97.9%     124.00 ± 13%  interrupts.CPU153.RES:Rescheduling_interrupts
    558862 ±  3%     -45.7%     303386        interrupts.CPU154.LOC:Local_timer_interrupts
      7644 ± 24%     -69.2%       2351 ± 29%  interrupts.CPU154.NMI:Non-maskable_interrupts
      7644 ± 24%     -69.2%       2351 ± 29%  interrupts.CPU154.PMI:Performance_monitoring_interrupts
      5736 ±  6%     -97.8%     123.75 ±  5%  interrupts.CPU154.RES:Rescheduling_interrupts
    558936 ±  3%     -45.7%     303359        interrupts.CPU155.LOC:Local_timer_interrupts
      8730           -74.2%       2252 ± 28%  interrupts.CPU155.NMI:Non-maskable_interrupts
      8730           -74.2%       2252 ± 28%  interrupts.CPU155.PMI:Performance_monitoring_interrupts
      5975 ±  8%     -97.8%     129.00 ±  9%  interrupts.CPU155.RES:Rescheduling_interrupts
    558930 ±  3%     -45.7%     303407        interrupts.CPU156.LOC:Local_timer_interrupts
      8739           -75.1%       2179 ± 18%  interrupts.CPU156.NMI:Non-maskable_interrupts
      8739           -75.1%       2179 ± 18%  interrupts.CPU156.PMI:Performance_monitoring_interrupts
      5857 ±  3%     -97.9%     125.75 ±  5%  interrupts.CPU156.RES:Rescheduling_interrupts
    558850 ±  3%     -45.7%     303364        interrupts.CPU157.LOC:Local_timer_interrupts
      8750           -74.5%       2227 ± 28%  interrupts.CPU157.NMI:Non-maskable_interrupts
      8750           -74.5%       2227 ± 28%  interrupts.CPU157.PMI:Performance_monitoring_interrupts
      5889 ±  8%     -97.8%     129.00 ±  7%  interrupts.CPU157.RES:Rescheduling_interrupts
    558854 ±  3%     -45.7%     303403        interrupts.CPU158.LOC:Local_timer_interrupts
      8718           -75.2%       2161 ± 28%  interrupts.CPU158.NMI:Non-maskable_interrupts
      8718           -75.2%       2161 ± 28%  interrupts.CPU158.PMI:Performance_monitoring_interrupts
      5734 ±  6%     -97.8%     128.75 ± 17%  interrupts.CPU158.RES:Rescheduling_interrupts
    558928 ±  3%     -45.7%     303395        interrupts.CPU159.LOC:Local_timer_interrupts
      8759           -73.8%       2296 ± 25%  interrupts.CPU159.NMI:Non-maskable_interrupts
      8759           -73.8%       2296 ± 25%  interrupts.CPU159.PMI:Performance_monitoring_interrupts
      5814 ±  7%     -98.0%     118.25 ± 10%  interrupts.CPU159.RES:Rescheduling_interrupts
    558995 ±  3%     -45.6%     304088        interrupts.CPU16.LOC:Local_timer_interrupts
      8747           -70.9%       2545 ±  9%  interrupts.CPU16.NMI:Non-maskable_interrupts
      8747           -70.9%       2545 ±  9%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
      6095 ±  7%     -97.3%     163.50 ± 19%  interrupts.CPU16.RES:Rescheduling_interrupts
    558970 ±  3%     -45.7%     303382        interrupts.CPU160.LOC:Local_timer_interrupts
      8723           -75.8%       2115 ± 23%  interrupts.CPU160.NMI:Non-maskable_interrupts
      8723           -75.8%       2115 ± 23%  interrupts.CPU160.PMI:Performance_monitoring_interrupts
      5541 ±  8%     -97.8%     121.00 ±  2%  interrupts.CPU160.RES:Rescheduling_interrupts
    558951 ±  3%     -45.7%     303388        interrupts.CPU161.LOC:Local_timer_interrupts
      8733           -74.7%       2209 ± 27%  interrupts.CPU161.NMI:Non-maskable_interrupts
      8733           -74.7%       2209 ± 27%  interrupts.CPU161.PMI:Performance_monitoring_interrupts
      5699 ±  6%     -97.8%     124.00 ±  8%  interrupts.CPU161.RES:Rescheduling_interrupts
    558962 ±  3%     -45.7%     303406        interrupts.CPU162.LOC:Local_timer_interrupts
      8737           -75.7%       2125 ± 21%  interrupts.CPU162.NMI:Non-maskable_interrupts
      8737           -75.7%       2125 ± 21%  interrupts.CPU162.PMI:Performance_monitoring_interrupts
      5849 ±  9%     -98.0%     114.75 ± 13%  interrupts.CPU162.RES:Rescheduling_interrupts
    558944 ±  3%     -45.7%     303370        interrupts.CPU163.LOC:Local_timer_interrupts
      8728           -72.4%       2412 ± 27%  interrupts.CPU163.NMI:Non-maskable_interrupts
      8728           -72.4%       2412 ± 27%  interrupts.CPU163.PMI:Performance_monitoring_interrupts
      6027 ±  7%     -98.0%     120.50 ±  5%  interrupts.CPU163.RES:Rescheduling_interrupts
    558979 ±  3%     -45.7%     303369        interrupts.CPU164.LOC:Local_timer_interrupts
      8746           -72.7%       2383 ± 27%  interrupts.CPU164.NMI:Non-maskable_interrupts
      8746           -72.7%       2383 ± 27%  interrupts.CPU164.PMI:Performance_monitoring_interrupts
      5879 ±  6%     -97.8%     131.50 ±  8%  interrupts.CPU164.RES:Rescheduling_interrupts
    558958 ±  3%     -45.7%     303360        interrupts.CPU165.LOC:Local_timer_interrupts
      8751           -74.3%       2245 ± 32%  interrupts.CPU165.NMI:Non-maskable_interrupts
      8751           -74.3%       2245 ± 32%  interrupts.CPU165.PMI:Performance_monitoring_interrupts
      5807 ±  6%     -98.0%     116.25 ±  6%  interrupts.CPU165.RES:Rescheduling_interrupts
    558677 ±  3%     -45.7%     303360        interrupts.CPU166.LOC:Local_timer_interrupts
      8728           -74.4%       2237 ± 28%  interrupts.CPU166.NMI:Non-maskable_interrupts
      8728           -74.4%       2237 ± 28%  interrupts.CPU166.PMI:Performance_monitoring_interrupts
      5650 ±  8%     -97.8%     126.75 ± 10%  interrupts.CPU166.RES:Rescheduling_interrupts
      4.00 ± 63%   +1956.2%      82.25 ± 36%  interrupts.CPU166.TLB:TLB_shootdowns
    558755 ±  3%     -45.7%     303382        interrupts.CPU167.LOC:Local_timer_interrupts
      6549 ± 33%     -65.7%       2249 ± 30%  interrupts.CPU167.NMI:Non-maskable_interrupts
      6549 ± 33%     -65.7%       2249 ± 30%  interrupts.CPU167.PMI:Performance_monitoring_interrupts
      5663 ±  5%     -97.5%     139.00 ±  2%  interrupts.CPU167.RES:Rescheduling_interrupts
      6.75 ± 79%   +3463.0%     240.50 ± 26%  interrupts.CPU167.TLB:TLB_shootdowns
    558974 ±  3%     -45.7%     303334        interrupts.CPU168.LOC:Local_timer_interrupts
      7635 ± 24%     -68.0%       2446 ± 30%  interrupts.CPU168.NMI:Non-maskable_interrupts
      7635 ± 24%     -68.0%       2446 ± 30%  interrupts.CPU168.PMI:Performance_monitoring_interrupts
      5557 ±  4%     -97.6%     130.75 ±  7%  interrupts.CPU168.RES:Rescheduling_interrupts
    558985 ±  3%     -45.7%     303328        interrupts.CPU169.LOC:Local_timer_interrupts
      7634 ± 24%     -71.2%       2201 ± 26%  interrupts.CPU169.NMI:Non-maskable_interrupts
      7634 ± 24%     -71.2%       2201 ± 26%  interrupts.CPU169.PMI:Performance_monitoring_interrupts
      5678 ±  6%     -97.7%     128.00 ±  3%  interrupts.CPU169.RES:Rescheduling_interrupts
    558990 ±  3%     -45.6%     304093        interrupts.CPU17.LOC:Local_timer_interrupts
      8725           -70.5%       2572        interrupts.CPU17.NMI:Non-maskable_interrupts
      8725           -70.5%       2572        interrupts.CPU17.PMI:Performance_monitoring_interrupts
      5984 ±  5%     -97.6%     144.00 ±  9%  interrupts.CPU17.RES:Rescheduling_interrupts
    559000 ±  3%     -45.7%     303294        interrupts.CPU170.LOC:Local_timer_interrupts
      7653 ± 24%     -71.1%       2208 ± 29%  interrupts.CPU170.NMI:Non-maskable_interrupts
      7653 ± 24%     -71.1%       2208 ± 29%  interrupts.CPU170.PMI:Performance_monitoring_interrupts
      5745 ±  8%     -98.0%     114.00 ± 13%  interrupts.CPU170.RES:Rescheduling_interrupts
    558962 ±  3%     -45.7%     303327        interrupts.CPU171.LOC:Local_timer_interrupts
      7656 ± 24%     -67.6%       2480 ±  6%  interrupts.CPU171.NMI:Non-maskable_interrupts
      7656 ± 24%     -67.6%       2480 ±  6%  interrupts.CPU171.PMI:Performance_monitoring_interrupts
      5750 ±  7%     -97.9%     120.50 ±  5%  interrupts.CPU171.RES:Rescheduling_interrupts
    558961 ±  3%     -45.7%     303324        interrupts.CPU172.LOC:Local_timer_interrupts
      8739           -70.5%       2577 ± 12%  interrupts.CPU172.NMI:Non-maskable_interrupts
      8739           -70.5%       2577 ± 12%  interrupts.CPU172.PMI:Performance_monitoring_interrupts
      5736 ±  7%     -97.8%     124.50 ±  9%  interrupts.CPU172.RES:Rescheduling_interrupts
    558968 ±  3%     -45.7%     303331        interrupts.CPU173.LOC:Local_timer_interrupts
      8739           -72.4%       2408 ±  9%  interrupts.CPU173.NMI:Non-maskable_interrupts
      8739           -72.4%       2408 ±  9%  interrupts.CPU173.PMI:Performance_monitoring_interrupts
      5646 ±  5%     -97.7%     127.75 ±  8%  interrupts.CPU173.RES:Rescheduling_interrupts
    558995 ±  3%     -45.7%     303317        interrupts.CPU174.LOC:Local_timer_interrupts
      8720           -69.6%       2648 ±  4%  interrupts.CPU174.NMI:Non-maskable_interrupts
      8720           -69.6%       2648 ±  4%  interrupts.CPU174.PMI:Performance_monitoring_interrupts
      5678 ±  5%     -97.7%     128.50 ±  3%  interrupts.CPU174.RES:Rescheduling_interrupts
    558941 ±  3%     -45.7%     303325        interrupts.CPU175.LOC:Local_timer_interrupts
      8743           -69.9%       2630 ± 10%  interrupts.CPU175.NMI:Non-maskable_interrupts
      8743           -69.9%       2630 ± 10%  interrupts.CPU175.PMI:Performance_monitoring_interrupts
      5777 ±  9%     -97.7%     130.25 ±  3%  interrupts.CPU175.RES:Rescheduling_interrupts
    558957 ±  3%     -45.7%     303308        interrupts.CPU176.LOC:Local_timer_interrupts
      8755           -70.6%       2577 ±  4%  interrupts.CPU176.NMI:Non-maskable_interrupts
      8755           -70.6%       2577 ±  4%  interrupts.CPU176.PMI:Performance_monitoring_interrupts
      5693 ±  6%     -97.9%     117.00 ± 10%  interrupts.CPU176.RES:Rescheduling_interrupts
    559045 ±  3%     -45.7%     303359        interrupts.CPU177.LOC:Local_timer_interrupts
      8720           -71.6%       2475 ± 11%  interrupts.CPU177.NMI:Non-maskable_interrupts
      8720           -71.6%       2475 ± 11%  interrupts.CPU177.PMI:Performance_monitoring_interrupts
      5769 ±  6%     -97.8%     128.75 ±  9%  interrupts.CPU177.RES:Rescheduling_interrupts
    558974 ±  3%     -45.7%     303319        interrupts.CPU178.LOC:Local_timer_interrupts
      8724           -71.4%       2491 ±  7%  interrupts.CPU178.NMI:Non-maskable_interrupts
      8724           -71.4%       2491 ±  7%  interrupts.CPU178.PMI:Performance_monitoring_interrupts
      5685 ±  4%     -97.9%     119.50 ± 14%  interrupts.CPU178.RES:Rescheduling_interrupts
    558978 ±  3%     -45.7%     303305        interrupts.CPU179.LOC:Local_timer_interrupts
      8741           -73.2%       2345 ±  5%  interrupts.CPU179.NMI:Non-maskable_interrupts
      8741           -73.2%       2345 ±  5%  interrupts.CPU179.PMI:Performance_monitoring_interrupts
      5716 ±  4%     -98.0%     114.75 ±  9%  interrupts.CPU179.RES:Rescheduling_interrupts
    558952 ±  3%     -45.6%     304068        interrupts.CPU18.LOC:Local_timer_interrupts
      8745           -71.6%       2484 ± 14%  interrupts.CPU18.NMI:Non-maskable_interrupts
      8745           -71.6%       2484 ± 14%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
      5919 ±  7%     -95.9%     241.75 ± 69%  interrupts.CPU18.RES:Rescheduling_interrupts
    558994 ±  3%     -45.7%     303312        interrupts.CPU180.LOC:Local_timer_interrupts
      8741           -69.7%       2649 ±  5%  interrupts.CPU180.NMI:Non-maskable_interrupts
      8741           -69.7%       2649 ±  5%  interrupts.CPU180.PMI:Performance_monitoring_interrupts
      5584 ±  7%     -97.9%     114.50 ±  7%  interrupts.CPU180.RES:Rescheduling_interrupts
    558990 ±  3%     -45.7%     303300        interrupts.CPU181.LOC:Local_timer_interrupts
      7636 ± 24%     -66.0%       2595 ±  9%  interrupts.CPU181.NMI:Non-maskable_interrupts
      7636 ± 24%     -66.0%       2595 ±  9%  interrupts.CPU181.PMI:Performance_monitoring_interrupts
      5730 ±  4%     -98.1%     108.75 ± 10%  interrupts.CPU181.RES:Rescheduling_interrupts
    558958 ±  3%     -45.7%     303330        interrupts.CPU182.LOC:Local_timer_interrupts
      7626 ± 24%     -66.6%       2549 ± 13%  interrupts.CPU182.NMI:Non-maskable_interrupts
      7626 ± 24%     -66.6%       2549 ± 13%  interrupts.CPU182.PMI:Performance_monitoring_interrupts
      5682 ±  4%     -97.9%     118.50 ±  7%  interrupts.CPU182.RES:Rescheduling_interrupts
    558963 ±  3%     -45.7%     303324        interrupts.CPU183.LOC:Local_timer_interrupts
      7633 ± 24%     -68.1%       2431 ±  9%  interrupts.CPU183.NMI:Non-maskable_interrupts
      7633 ± 24%     -68.1%       2431 ±  9%  interrupts.CPU183.PMI:Performance_monitoring_interrupts
      5757 ±  6%     -97.8%     125.25 ± 12%  interrupts.CPU183.RES:Rescheduling_interrupts
    558944 ±  3%     -45.7%     303305        interrupts.CPU184.LOC:Local_timer_interrupts
      7644 ± 24%     -69.8%       2305 ±  7%  interrupts.CPU184.NMI:Non-maskable_interrupts
      7644 ± 24%     -69.8%       2305 ±  7%  interrupts.CPU184.PMI:Performance_monitoring_interrupts
      5777 ±  6%     -98.1%     110.75 ±  8%  interrupts.CPU184.RES:Rescheduling_interrupts
    558962 ±  3%     -45.7%     303311        interrupts.CPU185.LOC:Local_timer_interrupts
      7642 ± 24%     -64.6%       2703 ± 11%  interrupts.CPU185.NMI:Non-maskable_interrupts
      7642 ± 24%     -64.6%       2703 ± 11%  interrupts.CPU185.PMI:Performance_monitoring_interrupts
      5636 ±  7%     -97.9%     119.75 ±  9%  interrupts.CPU185.RES:Rescheduling_interrupts
    558965 ±  3%     -45.7%     303290        interrupts.CPU186.LOC:Local_timer_interrupts
      7648 ± 24%     -67.6%       2475 ± 14%  interrupts.CPU186.NMI:Non-maskable_interrupts
      7648 ± 24%     -67.6%       2475 ± 14%  interrupts.CPU186.PMI:Performance_monitoring_interrupts
      5785 ±  5%     -98.0%     115.50 ± 16%  interrupts.CPU186.RES:Rescheduling_interrupts
    558968 ±  3%     -45.7%     303321        interrupts.CPU187.LOC:Local_timer_interrupts
      7619 ± 24%     -64.2%       2728 ± 10%  interrupts.CPU187.NMI:Non-maskable_interrupts
      7619 ± 24%     -64.2%       2728 ± 10%  interrupts.CPU187.PMI:Performance_monitoring_interrupts
      5760 ±  7%     -97.8%     129.25 ±  8%  interrupts.CPU187.RES:Rescheduling_interrupts
    558954 ±  3%     -45.7%     303303        interrupts.CPU188.LOC:Local_timer_interrupts
      7642 ± 24%     -67.7%       2467 ±  6%  interrupts.CPU188.NMI:Non-maskable_interrupts
      7642 ± 24%     -67.7%       2467 ±  6%  interrupts.CPU188.PMI:Performance_monitoring_interrupts
      5810 ±  7%     -98.1%     107.50 ±  9%  interrupts.CPU188.RES:Rescheduling_interrupts
    558954 ±  3%     -45.7%     303319        interrupts.CPU189.LOC:Local_timer_interrupts
      7664 ± 24%     -68.9%       2386 ± 10%  interrupts.CPU189.NMI:Non-maskable_interrupts
      7664 ± 24%     -68.9%       2386 ± 10%  interrupts.CPU189.PMI:Performance_monitoring_interrupts
      5604 ±  5%     -97.9%     115.00 ±  8%  interrupts.CPU189.RES:Rescheduling_interrupts
    558992 ±  3%     -45.6%     304081        interrupts.CPU19.LOC:Local_timer_interrupts
      8744           -71.1%       2524 ±  9%  interrupts.CPU19.NMI:Non-maskable_interrupts
      8744           -71.1%       2524 ±  9%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
      5801 ±  6%     -97.4%     150.75 ±  6%  interrupts.CPU19.RES:Rescheduling_interrupts
    558965 ±  3%     -45.7%     303325        interrupts.CPU190.LOC:Local_timer_interrupts
      7616 ± 24%     -65.0%       2666 ± 12%  interrupts.CPU190.NMI:Non-maskable_interrupts
      7616 ± 24%     -65.0%       2666 ± 12%  interrupts.CPU190.PMI:Performance_monitoring_interrupts
      5632 ±  7%     -97.9%     116.75 ±  6%  interrupts.CPU190.RES:Rescheduling_interrupts
    559191 ±  3%     -45.7%     303455        interrupts.CPU191.LOC:Local_timer_interrupts
      7647 ± 24%     -68.7%       2390 ±  9%  interrupts.CPU191.NMI:Non-maskable_interrupts
      7647 ± 24%     -68.7%       2390 ±  9%  interrupts.CPU191.PMI:Performance_monitoring_interrupts
      5816 ±  4%     -98.0%     116.25 ±  9%  interrupts.CPU191.RES:Rescheduling_interrupts
     14.00 ± 41%   +1517.9%     226.50 ±  9%  interrupts.CPU191.TLB:TLB_shootdowns
    558981 ±  3%     -45.6%     304079        interrupts.CPU2.LOC:Local_timer_interrupts
      6556 ± 33%     -67.3%       2143 ± 23%  interrupts.CPU2.NMI:Non-maskable_interrupts
      6556 ± 33%     -67.3%       2143 ± 23%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
      6255 ±  7%     -96.2%     239.75 ± 60%  interrupts.CPU2.RES:Rescheduling_interrupts
    558983 ±  3%     -45.6%     304092        interrupts.CPU20.LOC:Local_timer_interrupts
      8731           -74.5%       2229 ± 10%  interrupts.CPU20.NMI:Non-maskable_interrupts
      8731           -74.5%       2229 ± 10%  interrupts.CPU20.PMI:Performance_monitoring_interrupts
      6016 ±  7%     -97.6%     142.00 ± 12%  interrupts.CPU20.RES:Rescheduling_interrupts
    558969 ±  3%     -45.6%     304086        interrupts.CPU21.LOC:Local_timer_interrupts
      8732           -70.9%       2541 ± 10%  interrupts.CPU21.NMI:Non-maskable_interrupts
      8732           -70.9%       2541 ± 10%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
      5920 ±  6%     -97.4%     151.25 ±  8%  interrupts.CPU21.RES:Rescheduling_interrupts
    558988 ±  3%     -45.6%     304108        interrupts.CPU22.LOC:Local_timer_interrupts
      8736           -70.1%       2614 ± 15%  interrupts.CPU22.NMI:Non-maskable_interrupts
      8736           -70.1%       2614 ± 15%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
      6019 ±  5%     -97.7%     140.25 ± 15%  interrupts.CPU22.RES:Rescheduling_interrupts
    558898 ±  3%     -45.6%     304078        interrupts.CPU23.LOC:Local_timer_interrupts
      7645 ± 24%     -64.7%       2696 ±  8%  interrupts.CPU23.NMI:Non-maskable_interrupts
      7645 ± 24%     -64.7%       2696 ±  8%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
      6059 ±  4%     -97.5%     152.25 ±  8%  interrupts.CPU23.RES:Rescheduling_interrupts
    559031 ±  3%     -45.6%     304178        interrupts.CPU24.LOC:Local_timer_interrupts
      7651 ± 24%     -65.0%       2680 ± 14%  interrupts.CPU24.NMI:Non-maskable_interrupts
      7651 ± 24%     -65.0%       2680 ± 14%  interrupts.CPU24.PMI:Performance_monitoring_interrupts
      5906 ±  7%     -97.0%     175.50 ±  3%  interrupts.CPU24.RES:Rescheduling_interrupts
    559033 ±  3%     -45.6%     304186        interrupts.CPU25.LOC:Local_timer_interrupts
      7633 ± 24%     -71.9%       2148 ± 21%  interrupts.CPU25.NMI:Non-maskable_interrupts
      7633 ± 24%     -71.9%       2148 ± 21%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
      5942 ±  4%     -96.9%     185.75 ± 37%  interrupts.CPU25.RES:Rescheduling_interrupts
    559054 ±  3%     -45.6%     304033        interrupts.CPU26.LOC:Local_timer_interrupts
      7640 ± 24%     -68.0%       2444 ± 14%  interrupts.CPU26.NMI:Non-maskable_interrupts
      7640 ± 24%     -68.0%       2444 ± 14%  interrupts.CPU26.PMI:Performance_monitoring_interrupts
      6172 ±  9%     -97.5%     155.75 ±  4%  interrupts.CPU26.RES:Rescheduling_interrupts
    559040 ±  3%     -45.6%     304216        interrupts.CPU27.LOC:Local_timer_interrupts
      8739           -72.5%       2399 ± 11%  interrupts.CPU27.NMI:Non-maskable_interrupts
      8739           -72.5%       2399 ± 11%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
      6028 ±  7%     -97.4%     156.00 ± 12%  interrupts.CPU27.RES:Rescheduling_interrupts
    559063 ±  3%     -45.6%     304014        interrupts.CPU28.LOC:Local_timer_interrupts
      8740           -73.3%       2336 ± 12%  interrupts.CPU28.NMI:Non-maskable_interrupts
      8740           -73.3%       2336 ± 12%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
      5983 ±  5%     -97.6%     144.25 ±  2%  interrupts.CPU28.RES:Rescheduling_interrupts
    559025 ±  3%     -45.6%     304198        interrupts.CPU29.LOC:Local_timer_interrupts
      8718           -68.5%       2748 ±  7%  interrupts.CPU29.NMI:Non-maskable_interrupts
      8718           -68.5%       2748 ±  7%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
      5921 ±  5%     -97.4%     151.25 ±  7%  interrupts.CPU29.RES:Rescheduling_interrupts
    559007 ±  3%     -45.6%     304094        interrupts.CPU3.LOC:Local_timer_interrupts
      8737           -71.0%       2536 ± 11%  interrupts.CPU3.NMI:Non-maskable_interrupts
      8737           -71.0%       2536 ± 11%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
      5935 ±  5%     -97.3%     163.00 ± 11%  interrupts.CPU3.RES:Rescheduling_interrupts
    559020 ±  3%     -45.6%     304196        interrupts.CPU30.LOC:Local_timer_interrupts
      8724           -71.7%       2465 ± 14%  interrupts.CPU30.NMI:Non-maskable_interrupts
      8724           -71.7%       2465 ± 14%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
      5950 ±  7%     -97.4%     156.50 ±  5%  interrupts.CPU30.RES:Rescheduling_interrupts
    559057 ±  3%     -45.6%     304135        interrupts.CPU31.LOC:Local_timer_interrupts
      8758           -73.1%       2354 ±  8%  interrupts.CPU31.NMI:Non-maskable_interrupts
      8758           -73.1%       2354 ±  8%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
      5892 ±  7%     -97.7%     137.00 ±  6%  interrupts.CPU31.RES:Rescheduling_interrupts
    559036 ±  3%     -45.6%     304036        interrupts.CPU32.LOC:Local_timer_interrupts
      7641 ± 24%     -67.4%       2488 ±  8%  interrupts.CPU32.NMI:Non-maskable_interrupts
      7641 ± 24%     -67.4%       2488 ±  8%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
      5924 ±  7%     -97.4%     156.75 ±  5%  interrupts.CPU32.RES:Rescheduling_interrupts
    559037 ±  3%     -45.6%     304189        interrupts.CPU33.LOC:Local_timer_interrupts
      7639 ± 24%     -69.2%       2354 ± 18%  interrupts.CPU33.NMI:Non-maskable_interrupts
      7639 ± 24%     -69.2%       2354 ± 18%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
      6050 ±  6%     -97.8%     135.00 ±  9%  interrupts.CPU33.RES:Rescheduling_interrupts
    559027 ±  3%     -45.6%     304196        interrupts.CPU34.LOC:Local_timer_interrupts
      7658 ± 24%     -67.1%       2519 ± 10%  interrupts.CPU34.NMI:Non-maskable_interrupts
      7658 ± 24%     -67.1%       2519 ± 10%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
      5887 ±  6%     -97.6%     143.50 ±  7%  interrupts.CPU34.RES:Rescheduling_interrupts
    559019 ±  3%     -45.6%     304200        interrupts.CPU35.LOC:Local_timer_interrupts
      7657 ± 24%     -66.6%       2558 ±  8%  interrupts.CPU35.NMI:Non-maskable_interrupts
      7657 ± 24%     -66.6%       2558 ±  8%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
      5912 ±  3%     -97.6%     144.75 ± 16%  interrupts.CPU35.RES:Rescheduling_interrupts
    559009 ±  3%     -45.6%     304180        interrupts.CPU36.LOC:Local_timer_interrupts
      7640 ± 24%     -66.5%       2563 ±  7%  interrupts.CPU36.NMI:Non-maskable_interrupts
      7640 ± 24%     -66.5%       2563 ±  7%  interrupts.CPU36.PMI:Performance_monitoring_interrupts
      6100 ±  5%     -97.5%     153.50 ±  6%  interrupts.CPU36.RES:Rescheduling_interrupts
    559015 ±  3%     -45.6%     304200        interrupts.CPU37.LOC:Local_timer_interrupts
      7681 ± 24%     -68.8%       2400 ±  6%  interrupts.CPU37.NMI:Non-maskable_interrupts
      7681 ± 24%     -68.8%       2400 ±  6%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
      5894 ± 12%     -97.5%     147.00 ±  3%  interrupts.CPU37.RES:Rescheduling_interrupts
    559046 ±  3%     -45.6%     304195        interrupts.CPU38.LOC:Local_timer_interrupts
      7641 ± 24%     -66.8%       2537 ±  8%  interrupts.CPU38.NMI:Non-maskable_interrupts
      7641 ± 24%     -66.8%       2537 ±  8%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
      6075 ±  8%     -97.7%     139.25 ± 11%  interrupts.CPU38.RES:Rescheduling_interrupts
    559014 ±  3%     -45.6%     304168        interrupts.CPU39.LOC:Local_timer_interrupts
      8746           -70.8%       2558 ± 14%  interrupts.CPU39.NMI:Non-maskable_interrupts
      8746           -70.8%       2558 ± 14%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
      5906 ±  3%     -97.6%     144.00 ±  8%  interrupts.CPU39.RES:Rescheduling_interrupts
    558987 ±  3%     -45.6%     304096        interrupts.CPU4.LOC:Local_timer_interrupts
      8746           -71.0%       2538 ±  8%  interrupts.CPU4.NMI:Non-maskable_interrupts
      8746           -71.0%       2538 ±  8%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
      6733 ± 18%     -97.5%     170.00 ±  8%  interrupts.CPU4.RES:Rescheduling_interrupts
    558997 ±  3%     -45.6%     304199        interrupts.CPU40.LOC:Local_timer_interrupts
      8746           -71.8%       2468 ± 13%  interrupts.CPU40.NMI:Non-maskable_interrupts
      8746           -71.8%       2468 ± 13%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
      6029 ±  7%     -97.7%     137.75 ±  3%  interrupts.CPU40.RES:Rescheduling_interrupts
    559025 ±  3%     -45.6%     304186        interrupts.CPU41.LOC:Local_timer_interrupts
      7637 ± 24%     -67.4%       2489 ± 17%  interrupts.CPU41.NMI:Non-maskable_interrupts
      7637 ± 24%     -67.4%       2489 ± 17%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
      5939 ±  6%     -97.6%     143.25 ±  5%  interrupts.CPU41.RES:Rescheduling_interrupts
    559050 ±  3%     -45.6%     304189        interrupts.CPU42.LOC:Local_timer_interrupts
      7668 ± 24%     -67.4%       2496 ± 11%  interrupts.CPU42.NMI:Non-maskable_interrupts
      7668 ± 24%     -67.4%       2496 ± 11%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
      6030 ±  5%     -97.6%     145.00 ± 11%  interrupts.CPU42.RES:Rescheduling_interrupts
    558996 ±  3%     -45.6%     304028        interrupts.CPU43.LOC:Local_timer_interrupts
      7641 ± 24%     -67.7%       2469 ± 13%  interrupts.CPU43.NMI:Non-maskable_interrupts
      7641 ± 24%     -67.7%       2469 ± 13%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
      6115 ±  7%     -97.6%     145.00 ±  5%  interrupts.CPU43.RES:Rescheduling_interrupts
    559077 ±  3%     -45.6%     304204        interrupts.CPU44.LOC:Local_timer_interrupts
      8739           -71.3%       2504 ± 19%  interrupts.CPU44.NMI:Non-maskable_interrupts
      8739           -71.3%       2504 ± 19%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
      5902 ±  6%     -97.5%     150.25 ± 10%  interrupts.CPU44.RES:Rescheduling_interrupts
      6.25 ±127%    +612.0%      44.50 ± 80%  interrupts.CPU44.TLB:TLB_shootdowns
    559032 ±  3%     -45.6%     304169        interrupts.CPU45.LOC:Local_timer_interrupts
      8739           -72.2%       2433 ± 11%  interrupts.CPU45.NMI:Non-maskable_interrupts
      8739           -72.2%       2433 ± 11%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
      5916 ±  5%     -97.5%     150.00 ±  8%  interrupts.CPU45.RES:Rescheduling_interrupts
    559076 ±  3%     -45.6%     304216        interrupts.CPU46.LOC:Local_timer_interrupts
      8742           -71.4%       2501 ± 14%  interrupts.CPU46.NMI:Non-maskable_interrupts
      8742           -71.4%       2501 ± 14%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
      6010 ±  6%     -97.5%     150.00 ± 10%  interrupts.CPU46.RES:Rescheduling_interrupts
    559043 ±  3%     -45.6%     304170        interrupts.CPU47.LOC:Local_timer_interrupts
      8736           -70.3%       2591 ± 17%  interrupts.CPU47.NMI:Non-maskable_interrupts
      8736           -70.3%       2591 ± 17%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
      6039 ±  5%     -97.4%     154.00 ±  5%  interrupts.CPU47.RES:Rescheduling_interrupts
    558960 ±  3%     -45.7%     303401        interrupts.CPU48.LOC:Local_timer_interrupts
      8743           -71.6%       2481 ±  6%  interrupts.CPU48.NMI:Non-maskable_interrupts
      8743           -71.6%       2481 ±  6%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
      6204 ±  5%     -97.1%     181.25 ±  7%  interrupts.CPU48.RES:Rescheduling_interrupts
    558950 ±  3%     -45.7%     303398        interrupts.CPU49.LOC:Local_timer_interrupts
      8744           -71.0%       2537 ± 24%  interrupts.CPU49.NMI:Non-maskable_interrupts
      8744           -71.0%       2537 ± 24%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
      5835 ±  5%     -97.2%     163.75 ±  4%  interrupts.CPU49.RES:Rescheduling_interrupts
    559014 ±  3%     -45.6%     304137        interrupts.CPU5.LOC:Local_timer_interrupts
      8735           -68.8%       2725 ±  9%  interrupts.CPU5.NMI:Non-maskable_interrupts
      8735           -68.8%       2725 ±  9%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
      6663 ± 20%     -97.7%     152.00 ±  9%  interrupts.CPU5.RES:Rescheduling_interrupts
    558948 ±  3%     -45.7%     303287        interrupts.CPU50.LOC:Local_timer_interrupts
      8731           -76.5%       2054 ± 28%  interrupts.CPU50.NMI:Non-maskable_interrupts
      8731           -76.5%       2054 ± 28%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
      6033 ±  9%     -97.3%     165.75 ± 10%  interrupts.CPU50.RES:Rescheduling_interrupts
    558960 ±  3%     -45.7%     303416        interrupts.CPU51.LOC:Local_timer_interrupts
      7652 ± 24%     -71.1%       2215 ± 25%  interrupts.CPU51.NMI:Non-maskable_interrupts
      7652 ± 24%     -71.1%       2215 ± 25%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
      5942 ±  6%     -97.1%     169.75 ±  2%  interrupts.CPU51.RES:Rescheduling_interrupts
    559025 ±  3%     -45.7%     303327        interrupts.CPU52.LOC:Local_timer_interrupts
      8769           -75.2%       2173 ± 25%  interrupts.CPU52.NMI:Non-maskable_interrupts
      8769           -75.2%       2173 ± 25%  interrupts.CPU52.PMI:Performance_monitoring_interrupts
      6061 ±  6%     -97.6%     144.00 ±  5%  interrupts.CPU52.RES:Rescheduling_interrupts
    558979 ±  3%     -45.7%     303385        interrupts.CPU53.LOC:Local_timer_interrupts
      8740           -74.6%       2217 ± 30%  interrupts.CPU53.NMI:Non-maskable_interrupts
      8740           -74.6%       2217 ± 30%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
      6108 ±  6%     -97.6%     147.75 ± 11%  interrupts.CPU53.RES:Rescheduling_interrupts
    558955 ±  3%     -45.7%     303398        interrupts.CPU54.LOC:Local_timer_interrupts
      8746           -78.6%       1868 ± 30%  interrupts.CPU54.NMI:Non-maskable_interrupts
      8746           -78.6%       1868 ± 30%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
      6140 ±  5%     -97.5%     152.50 ±  9%  interrupts.CPU54.RES:Rescheduling_interrupts
    558955 ±  3%     -45.7%     303393        interrupts.CPU55.LOC:Local_timer_interrupts
      8743           -78.0%       1922 ± 31%  interrupts.CPU55.NMI:Non-maskable_interrupts
      8743           -78.0%       1922 ± 31%  interrupts.CPU55.PMI:Performance_monitoring_interrupts
      6091 ±  8%     -97.4%     159.00 ±  9%  interrupts.CPU55.RES:Rescheduling_interrupts
    558968 ±  3%     -45.7%     303397        interrupts.CPU56.LOC:Local_timer_interrupts
      8736           -78.9%       1843 ± 33%  interrupts.CPU56.NMI:Non-maskable_interrupts
      8736           -78.9%       1843 ± 33%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
      5969 ±  7%     -97.6%     140.50 ±  8%  interrupts.CPU56.RES:Rescheduling_interrupts
    558977 ±  3%     -45.7%     303387        interrupts.CPU57.LOC:Local_timer_interrupts
      8736           -79.6%       1785 ± 40%  interrupts.CPU57.NMI:Non-maskable_interrupts
      8736           -79.6%       1785 ± 40%  interrupts.CPU57.PMI:Performance_monitoring_interrupts
      5874 ±  4%     -97.6%     141.25 ±  8%  interrupts.CPU57.RES:Rescheduling_interrupts
    558928 ±  3%     -45.7%     303412        interrupts.CPU58.LOC:Local_timer_interrupts
      8738           -73.0%       2357 ± 25%  interrupts.CPU58.NMI:Non-maskable_interrupts
      8738           -73.0%       2357 ± 25%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
      6070 ±  6%     -97.5%     149.50 ±  9%  interrupts.CPU58.RES:Rescheduling_interrupts
    558968 ±  3%     -45.7%     303352        interrupts.CPU59.LOC:Local_timer_interrupts
      8734           -80.0%       1743 ± 26%  interrupts.CPU59.NMI:Non-maskable_interrupts
      8734           -80.0%       1743 ± 26%  interrupts.CPU59.PMI:Performance_monitoring_interrupts
      6030 ±  8%     -97.5%     153.00 ± 13%  interrupts.CPU59.RES:Rescheduling_interrupts
    558866 ±  3%     -45.6%     304133        interrupts.CPU6.LOC:Local_timer_interrupts
      7653 ± 24%     -68.8%       2389 ± 16%  interrupts.CPU6.NMI:Non-maskable_interrupts
      7653 ± 24%     -68.8%       2389 ± 16%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
      6900 ± 21%     -86.7%     920.25 ±144%  interrupts.CPU6.RES:Rescheduling_interrupts
    558962 ±  3%     -45.7%     303383        interrupts.CPU60.LOC:Local_timer_interrupts
      8735           -77.7%       1948 ± 33%  interrupts.CPU60.NMI:Non-maskable_interrupts
      8735           -77.7%       1948 ± 33%  interrupts.CPU60.PMI:Performance_monitoring_interrupts
      5900 ±  7%     -97.5%     149.75 ±  5%  interrupts.CPU60.RES:Rescheduling_interrupts
    558939 ±  3%     -45.7%     303370        interrupts.CPU61.LOC:Local_timer_interrupts
      8743           -77.6%       1961 ± 36%  interrupts.CPU61.NMI:Non-maskable_interrupts
      8743           -77.6%       1961 ± 36%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
      6069 ±  8%     -97.5%     151.50 ±  9%  interrupts.CPU61.RES:Rescheduling_interrupts
    558805 ±  3%     -45.7%     303392        interrupts.CPU62.LOC:Local_timer_interrupts
      8743           -79.4%       1798 ± 32%  interrupts.CPU62.NMI:Non-maskable_interrupts
      8743           -79.4%       1798 ± 32%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
      6118 ±  4%     -97.6%     147.00 ±  4%  interrupts.CPU62.RES:Rescheduling_interrupts
    558901 ±  3%     -45.7%     303394        interrupts.CPU63.LOC:Local_timer_interrupts
      8735           -78.8%       1850 ± 38%  interrupts.CPU63.NMI:Non-maskable_interrupts
      8735           -78.8%       1850 ± 38%  interrupts.CPU63.PMI:Performance_monitoring_interrupts
      6010 ±  6%     -97.6%     144.00 ±  8%  interrupts.CPU63.RES:Rescheduling_interrupts
    558959 ±  3%     -45.7%     303425        interrupts.CPU64.LOC:Local_timer_interrupts
      8745           -82.5%       1527 ± 34%  interrupts.CPU64.NMI:Non-maskable_interrupts
      8745           -82.5%       1527 ± 34%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
      5945 ±  5%     -97.4%     154.50 ±  6%  interrupts.CPU64.RES:Rescheduling_interrupts
    558873 ±  3%     -45.7%     303410        interrupts.CPU65.LOC:Local_timer_interrupts
      8753           -81.5%       1616 ± 40%  interrupts.CPU65.NMI:Non-maskable_interrupts
      8753           -81.5%       1616 ± 40%  interrupts.CPU65.PMI:Performance_monitoring_interrupts
      6081 ±  9%     -97.6%     146.25 ±  6%  interrupts.CPU65.RES:Rescheduling_interrupts
    558972 ±  3%     -45.7%     303440        interrupts.CPU66.LOC:Local_timer_interrupts
      8721           -81.3%       1628 ± 42%  interrupts.CPU66.NMI:Non-maskable_interrupts
      8721           -81.3%       1628 ± 42%  interrupts.CPU66.PMI:Performance_monitoring_interrupts
      6052 ±  5%     -97.6%     146.00 ±  6%  interrupts.CPU66.RES:Rescheduling_interrupts
    558970 ±  3%     -45.7%     303440        interrupts.CPU67.LOC:Local_timer_interrupts
      8719           -75.2%       2158 ± 38%  interrupts.CPU67.NMI:Non-maskable_interrupts
      8719           -75.2%       2158 ± 38%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
      6025 ±  8%     -97.5%     149.50 ±  6%  interrupts.CPU67.RES:Rescheduling_interrupts
    558937 ±  3%     -45.7%     303396        interrupts.CPU68.LOC:Local_timer_interrupts
      7647 ± 24%     -75.4%       1884 ± 37%  interrupts.CPU68.NMI:Non-maskable_interrupts
      7647 ± 24%     -75.4%       1884 ± 37%  interrupts.CPU68.PMI:Performance_monitoring_interrupts
      5978 ±  5%     -97.7%     136.00 ±  6%  interrupts.CPU68.RES:Rescheduling_interrupts
    559004 ±  3%     -45.7%     303384        interrupts.CPU69.LOC:Local_timer_interrupts
      6557 ± 33%     -77.6%       1467 ± 32%  interrupts.CPU69.NMI:Non-maskable_interrupts
      6557 ± 33%     -77.6%       1467 ± 32%  interrupts.CPU69.PMI:Performance_monitoring_interrupts
      6109 ±  6%     -97.7%     142.00 ±  3%  interrupts.CPU69.RES:Rescheduling_interrupts
    558988 ±  3%     -45.6%     304112        interrupts.CPU7.LOC:Local_timer_interrupts
      8740           -73.3%       2335 ±  5%  interrupts.CPU7.NMI:Non-maskable_interrupts
      8740           -73.3%       2335 ±  5%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
      5983 ±  5%     -97.4%     158.25 ± 11%  interrupts.CPU7.RES:Rescheduling_interrupts
    558953 ±  3%     -45.7%     303383        interrupts.CPU70.LOC:Local_timer_interrupts
      8716           -77.9%       1925 ± 37%  interrupts.CPU70.NMI:Non-maskable_interrupts
      8716           -77.9%       1925 ± 37%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
      5929 ±  7%     -97.5%     147.75 ±  3%  interrupts.CPU70.RES:Rescheduling_interrupts
    558905 ±  3%     -45.7%     303378        interrupts.CPU71.LOC:Local_timer_interrupts
      6561 ± 33%     -69.6%       1994 ± 44%  interrupts.CPU71.NMI:Non-maskable_interrupts
      6561 ± 33%     -69.6%       1994 ± 44%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
      5991 ±  7%     -97.7%     136.50 ± 11%  interrupts.CPU71.RES:Rescheduling_interrupts
    558992 ±  3%     -45.7%     303333        interrupts.CPU72.LOC:Local_timer_interrupts
      8745           -72.1%       2437 ± 32%  interrupts.CPU72.NMI:Non-maskable_interrupts
      8745           -72.1%       2437 ± 32%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
      5960 ±  8%     -97.2%     169.50 ±  7%  interrupts.CPU72.RES:Rescheduling_interrupts
    559002 ±  3%     -45.7%     303348        interrupts.CPU73.LOC:Local_timer_interrupts
      8734           -71.0%       2532 ± 13%  interrupts.CPU73.NMI:Non-maskable_interrupts
      8734           -71.0%       2532 ± 13%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
      5996 ±  6%     -97.3%     164.25 ±  5%  interrupts.CPU73.RES:Rescheduling_interrupts
    559015 ±  3%     -45.7%     303322        interrupts.CPU74.LOC:Local_timer_interrupts
      8743           -72.4%       2411 ± 14%  interrupts.CPU74.NMI:Non-maskable_interrupts
      8743           -72.4%       2411 ± 14%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
      6027 ±  4%     -97.4%     157.50 ±  7%  interrupts.CPU74.RES:Rescheduling_interrupts
    558985 ±  3%     -45.8%     303233        interrupts.CPU75.LOC:Local_timer_interrupts
      7641 ± 24%     -72.6%       2090 ± 25%  interrupts.CPU75.NMI:Non-maskable_interrupts
      7641 ± 24%     -72.6%       2090 ± 25%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
      5923 ±  6%     -97.2%     166.00 ± 10%  interrupts.CPU75.RES:Rescheduling_interrupts
    558973 ±  3%     -45.7%     303359        interrupts.CPU76.LOC:Local_timer_interrupts
      7651 ± 24%     -66.8%       2538 ± 13%  interrupts.CPU76.NMI:Non-maskable_interrupts
      7651 ± 24%     -66.8%       2538 ± 13%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
      5908 ±  6%     -97.3%     157.25 ± 13%  interrupts.CPU76.RES:Rescheduling_interrupts
    558965 ±  3%     -45.7%     303365        interrupts.CPU77.LOC:Local_timer_interrupts
      7651 ± 24%     -70.0%       2299 ± 12%  interrupts.CPU77.NMI:Non-maskable_interrupts
      7651 ± 24%     -70.0%       2299 ± 12%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
      5903 ±  7%     -97.4%     155.75 ±  9%  interrupts.CPU77.RES:Rescheduling_interrupts
    558976 ±  3%     -45.7%     303346        interrupts.CPU78.LOC:Local_timer_interrupts
      7641 ± 24%     -66.2%       2585 ±  7%  interrupts.CPU78.NMI:Non-maskable_interrupts
      7641 ± 24%     -66.2%       2585 ±  7%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
      5821 ±  5%     -97.4%     149.00 ±  7%  interrupts.CPU78.RES:Rescheduling_interrupts
    558989 ±  3%     -45.7%     303332        interrupts.CPU79.LOC:Local_timer_interrupts
      7646 ± 24%     -67.5%       2488 ± 13%  interrupts.CPU79.NMI:Non-maskable_interrupts
      7646 ± 24%     -67.5%       2488 ± 13%  interrupts.CPU79.PMI:Performance_monitoring_interrupts
      5937 ±  7%     -97.5%     150.25        interrupts.CPU79.RES:Rescheduling_interrupts
    558991 ±  3%     -45.6%     304110        interrupts.CPU8.LOC:Local_timer_interrupts
      7652 ± 24%     -68.0%       2450 ± 14%  interrupts.CPU8.NMI:Non-maskable_interrupts
      7652 ± 24%     -68.0%       2450 ± 14%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
      5967 ±  6%     -81.4%       1110 ±145%  interrupts.CPU8.RES:Rescheduling_interrupts
    559010 ±  3%     -45.7%     303336        interrupts.CPU80.LOC:Local_timer_interrupts
      7662 ± 24%     -68.0%       2450 ±  3%  interrupts.CPU80.NMI:Non-maskable_interrupts
      7662 ± 24%     -68.0%       2450 ±  3%  interrupts.CPU80.PMI:Performance_monitoring_interrupts
      5863 ±  4%     -97.5%     148.00 ±  4%  interrupts.CPU80.RES:Rescheduling_interrupts
    558975 ±  3%     -45.7%     303322        interrupts.CPU81.LOC:Local_timer_interrupts
      7657 ± 24%     -67.9%       2459 ± 10%  interrupts.CPU81.NMI:Non-maskable_interrupts
      7657 ± 24%     -67.9%       2459 ± 10%  interrupts.CPU81.PMI:Performance_monitoring_interrupts
      5822 ±  5%     -97.6%     142.00 ± 13%  interrupts.CPU81.RES:Rescheduling_interrupts
    558986 ±  3%     -45.7%     303330        interrupts.CPU82.LOC:Local_timer_interrupts
      7649 ± 24%     -70.5%       2260 ± 24%  interrupts.CPU82.NMI:Non-maskable_interrupts
      7649 ± 24%     -70.5%       2260 ± 24%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
      6017 ±  4%     -97.3%     159.75 ±  8%  interrupts.CPU82.RES:Rescheduling_interrupts
    558989 ±  3%     -45.7%     303327        interrupts.CPU83.LOC:Local_timer_interrupts
      8728           -74.7%       2211 ± 31%  interrupts.CPU83.NMI:Non-maskable_interrupts
      8728           -74.7%       2211 ± 31%  interrupts.CPU83.PMI:Performance_monitoring_interrupts
      5952 ±  9%     -97.7%     134.75 ±  6%  interrupts.CPU83.RES:Rescheduling_interrupts
    558990 ±  3%     -45.7%     303327        interrupts.CPU84.LOC:Local_timer_interrupts
      7644 ± 24%     -70.0%       2292 ± 29%  interrupts.CPU84.NMI:Non-maskable_interrupts
      7644 ± 24%     -70.0%       2292 ± 29%  interrupts.CPU84.PMI:Performance_monitoring_interrupts
      5790 ±  8%     -97.4%     148.75 ±  9%  interrupts.CPU84.RES:Rescheduling_interrupts
    558979 ±  3%     -45.7%     303342        interrupts.CPU85.LOC:Local_timer_interrupts
      7660 ± 24%     -66.1%       2598 ± 12%  interrupts.CPU85.NMI:Non-maskable_interrupts
      7660 ± 24%     -66.1%       2598 ± 12%  interrupts.CPU85.PMI:Performance_monitoring_interrupts
      5870 ±  5%     -97.5%     149.25 ±  4%  interrupts.CPU85.RES:Rescheduling_interrupts
    559016 ±  3%     -45.7%     303322        interrupts.CPU86.LOC:Local_timer_interrupts
      7643 ± 24%     -66.1%       2590 ±  7%  interrupts.CPU86.NMI:Non-maskable_interrupts
      7643 ± 24%     -66.1%       2590 ±  7%  interrupts.CPU86.PMI:Performance_monitoring_interrupts
      5749 ±  6%     -97.4%     150.75 ±  8%  interrupts.CPU86.RES:Rescheduling_interrupts
    559023 ±  3%     -45.7%     303334        interrupts.CPU87.LOC:Local_timer_interrupts
      7650 ± 24%     -67.1%       2519 ± 14%  interrupts.CPU87.NMI:Non-maskable_interrupts
      7650 ± 24%     -67.1%       2519 ± 14%  interrupts.CPU87.PMI:Performance_monitoring_interrupts
      5935 ±  7%     -97.6%     140.00 ±  6%  interrupts.CPU87.RES:Rescheduling_interrupts
    559038 ±  3%     -45.7%     303341        interrupts.CPU88.LOC:Local_timer_interrupts
      7648 ± 24%     -74.6%       1942 ± 29%  interrupts.CPU88.NMI:Non-maskable_interrupts
      7648 ± 24%     -74.6%       1942 ± 29%  interrupts.CPU88.PMI:Performance_monitoring_interrupts
      5639 ±  4%     -97.2%     160.50 ±  7%  interrupts.CPU88.RES:Rescheduling_interrupts
    558986 ±  3%     -45.7%     303337        interrupts.CPU89.LOC:Local_timer_interrupts
      8741           -74.0%       2271 ± 31%  interrupts.CPU89.NMI:Non-maskable_interrupts
      8741           -74.0%       2271 ± 31%  interrupts.CPU89.PMI:Performance_monitoring_interrupts
      5971 ±  7%     -97.5%     146.75 ±  3%  interrupts.CPU89.RES:Rescheduling_interrupts
    559036 ±  3%     -45.6%     304125        interrupts.CPU9.LOC:Local_timer_interrupts
      6551 ± 33%     -64.7%       2310 ± 29%  interrupts.CPU9.NMI:Non-maskable_interrupts
      6551 ± 33%     -64.7%       2310 ± 29%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
      5918 ±  7%     -97.4%     152.50 ± 17%  interrupts.CPU9.RES:Rescheduling_interrupts
    558994 ±  3%     -45.8%     303209        interrupts.CPU90.LOC:Local_timer_interrupts
      8744           -78.1%       1912 ± 34%  interrupts.CPU90.NMI:Non-maskable_interrupts
      8744           -78.1%       1912 ± 34%  interrupts.CPU90.PMI:Performance_monitoring_interrupts
      5829 ±  4%     -97.4%     149.00 ±  7%  interrupts.CPU90.RES:Rescheduling_interrupts
    558995 ±  3%     -45.7%     303319        interrupts.CPU91.LOC:Local_timer_interrupts
      8728           -73.6%       2307 ± 30%  interrupts.CPU91.NMI:Non-maskable_interrupts
      8728           -73.6%       2307 ± 30%  interrupts.CPU91.PMI:Performance_monitoring_interrupts
      5847 ±  6%     -97.6%     141.25 ± 12%  interrupts.CPU91.RES:Rescheduling_interrupts
    558996 ±  3%     -45.7%     303312        interrupts.CPU92.LOC:Local_timer_interrupts
      8737           -75.2%       2163 ± 26%  interrupts.CPU92.NMI:Non-maskable_interrupts
      8737           -75.2%       2163 ± 26%  interrupts.CPU92.PMI:Performance_monitoring_interrupts
      5808 ±  4%     -97.4%     151.75 ±  6%  interrupts.CPU92.RES:Rescheduling_interrupts
    558971 ±  3%     -45.7%     303327        interrupts.CPU93.LOC:Local_timer_interrupts
      8745           -72.5%       2404 ± 14%  interrupts.CPU93.NMI:Non-maskable_interrupts
      8745           -72.5%       2404 ± 14%  interrupts.CPU93.PMI:Performance_monitoring_interrupts
      5771 ±  9%     -97.3%     153.50 ± 17%  interrupts.CPU93.RES:Rescheduling_interrupts
    558992 ±  3%     -45.7%     303317        interrupts.CPU94.LOC:Local_timer_interrupts
      7626 ± 24%     -65.4%       2637 ±  4%  interrupts.CPU94.NMI:Non-maskable_interrupts
      7626 ± 24%     -65.4%       2637 ±  4%  interrupts.CPU94.PMI:Performance_monitoring_interrupts
      5737 ±  4%     -97.4%     152.00 ±  5%  interrupts.CPU94.RES:Rescheduling_interrupts
    559041 ±  3%     -45.7%     303381        interrupts.CPU95.LOC:Local_timer_interrupts
      7654 ± 24%     -67.1%       2521 ±  3%  interrupts.CPU95.NMI:Non-maskable_interrupts
      7654 ± 24%     -67.1%       2521 ±  3%  interrupts.CPU95.PMI:Performance_monitoring_interrupts
      8818 ±  8%     -98.2%     155.50 ±  5%  interrupts.CPU95.RES:Rescheduling_interrupts
    558958 ±  3%     -45.6%     304115        interrupts.CPU96.LOC:Local_timer_interrupts
      7648 ± 24%     -67.4%       2493 ± 15%  interrupts.CPU96.NMI:Non-maskable_interrupts
      7648 ± 24%     -67.4%       2493 ± 15%  interrupts.CPU96.PMI:Performance_monitoring_interrupts
      5766 ±  8%     -97.6%     138.00 ±  9%  interrupts.CPU96.RES:Rescheduling_interrupts
    558917 ±  3%     -45.6%     304089        interrupts.CPU97.LOC:Local_timer_interrupts
      7648 ± 24%     -65.4%       2644 ±  8%  interrupts.CPU97.NMI:Non-maskable_interrupts
      7648 ± 24%     -65.4%       2644 ±  8%  interrupts.CPU97.PMI:Performance_monitoring_interrupts
      5847 ±  6%     -97.7%     133.00 ± 11%  interrupts.CPU97.RES:Rescheduling_interrupts
    558965 ±  3%     -45.6%     304082        interrupts.CPU98.LOC:Local_timer_interrupts
      7663 ± 24%     -65.9%       2615 ±  4%  interrupts.CPU98.NMI:Non-maskable_interrupts
      7663 ± 24%     -65.9%       2615 ±  4%  interrupts.CPU98.PMI:Performance_monitoring_interrupts
      5880 ±  4%     -97.4%     153.25 ± 17%  interrupts.CPU98.RES:Rescheduling_interrupts
    558939 ±  3%     -45.6%     304083        interrupts.CPU99.LOC:Local_timer_interrupts
      8741           -73.8%       2288 ± 23%  interrupts.CPU99.NMI:Non-maskable_interrupts
      8741           -73.8%       2288 ± 23%  interrupts.CPU99.PMI:Performance_monitoring_interrupts
      5705 ±  7%     -97.7%     130.25 ±  7%  interrupts.CPU99.RES:Rescheduling_interrupts
    373.00 ±  6%     -99.5%       1.75 ± 74%  interrupts.IWI:IRQ_work_interrupts
 1.073e+08 ±  3%     -45.7%   58318185        interrupts.LOC:Local_timer_interrupts
   1568584 ±  5%     -71.0%     455275 ±  9%  interrupts.NMI:Non-maskable_interrupts
   1568584 ±  5%     -71.0%     455275 ±  9%  interrupts.PMI:Performance_monitoring_interrupts
   1134704 ±  6%     -97.3%      30761 ±  3%  interrupts.RES:Rescheduling_interrupts
    934.50 ± 19%    +537.7%       5959 ± 41%  interrupts.TLB:TLB_shootdowns


                                                                                
                                  aim7.jobs-per-min                             
                                                                                
  60000 +-------------------------------------------------------------------+   
        |                                                                   |   
  50000 |-+                                                                 |   
        |                                                                   |   
        |                                                                   |   
  40000 |-+                                                                 |   
        |..+.+..+.+..+..+.       .+..         .+..+.       .+..    .+.. .+..|   
  30000 |-+               +..+..+    +.+..+..+      +..+..+    +..+    +    |   
        |                                                                   |   
  20000 |-+                                                                 |   
        |                                                                   |   
        |                                                                   |   
  10000 |-+                                                                 |   
        |                                                                   |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                aim7.time.system_time                           
                                                                                
  60000 +-------------------------------------------------------------------+   
        |                      .+.                                     +.   |   
  50000 |..+.  .+.+..+..+.+..+.   +..+.+..+..+.  .+.+..+..+.+..+..+. ..  +..|   
        |    +.                                +.                   +       |   
        |                                                                   |   
  40000 |-+                                                                 |   
        |                                                                   |   
  30000 |-+                                                                 |   
        |                                                                   |   
  20000 |-+                                                                 |   
        |                                                                   |   
        |                                                                   |   
  10000 |-+                                                                 |   
        |  O O  O O  O  O O  O  O O  O O     O O  O    O  O O  O  O O  O    |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                              aim7.time.elapsed_time                            
                                                                                
  350 +---------------------------------------------------------------------+   
      |                                                                     |   
  300 |-+                    .+..                                     .+.   |   
      |..+.+..+..+.+..+..+..+    +..+.+..+..+.+..+..+.+..+..+..+.+..+.   +..|   
  250 |-+                                                                   |   
      |                                                                     |   
  200 |-+                                                                   |   
      |                                                                     |   
  150 |-+O O  O  O O  O  O  O O  O  O O     O O  O    O  O  O  O O  O  O    |   
      |                                                                     |   
  100 |-+                                                                   |   
      |                                                                     |   
   50 |-+                                                                   |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                            aim7.time.elapsed_time.max                          
                                                                                
  350 +---------------------------------------------------------------------+   
      |                                                                     |   
  300 |-+                    .+..                                     .+.   |   
      |..+.+..+..+.+..+..+..+    +..+.+..+..+.+..+..+.+..+..+..+.+..+.   +..|   
  250 |-+                                                                   |   
      |                                                                     |   
  200 |-+                                                                   |   
      |                                                                     |   
  150 |-+O O  O  O O  O  O  O O  O  O O     O O  O    O  O  O  O O  O  O    |   
      |                                                                     |   
  100 |-+                                                                   |   
      |                                                                     |   
   50 |-+                                                                   |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                             aim7.time.minor_page_faults                        
                                                                                
  350000 +------------------------------------------------------------------+   
         |                                                             +    |   
  300000 |..+.+..    .+.+..+..+.+..+.+..+..+.+..+.  .+.+..+..+.+..+. .. +  .|   
         |       +.+.                             +.                +    +. |   
  250000 |-+                                                                |   
         |                                                                  |   
  200000 |-+                                                                |   
         |                                                                  |   
  150000 |-+                                                                |   
         |                                                                  |   
  100000 |-+O O  O O  O O  O  O O  O O  O    O  O O    O  O  O O  O O  O    |   
         |                                                                  |   
   50000 |-+                                                                |   
         |                                                                  |   
       0 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                         aim7.time.voluntary_context_switches                   
                                                                                
  2.5e+06 +-----------------------------------------------------------------+   
          |             .+..                             .+..               |   
          |..         .+    +.+.. .+..+.+..+..+.  .+.+..+    +.+..+.+..+.+..|   
    2e+06 |-++.+..+.+.           +              +.                          |   
          |                                                                 |   
          |                                                                 |   
  1.5e+06 |-+                                                               |   
          |                                                    O  O O  O    |   
    1e+06 |-+O O  O O  O O  O O  O O  O O     O O  O    O O  O              |   
          |                                                                 |   
          |                                                                 |   
   500000 |-+                                                               |   
          |                                                                 |   
          |                                                                 |   
        0 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                        aim7.time.involuntary_context_switches                  
                                                                                
    5e+06 +-----------------------------------------------------------------+   
  4.5e+06 |-+                    +                                          |   
          |                     + :                                    +    |   
    4e+06 |-+                  +  :  .+.  .+..      .+.. .+           : +   |   
  3.5e+06 |-+               +.+    +.   +.    +    +    +  +   +..+   :  +..|   
          |..    .+.+..+. ..                   + ..         + +    + :      |   
    3e+06 |-++.+.        +                      +            +      +       |   
  2.5e+06 |-+                                                               |   
    2e+06 |-+                                                               |   
          |                                                                 |   
  1.5e+06 |-+                                                               |   
    1e+06 |-+                                                               |   
          |                                                                 |   
   500000 |-+                                                               |   
        0 +-----------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-bdw-ep6: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase/ucode:
  gcc-7/performance/x86_64-rhel-7.6/100%/debian-x86_64-20191114.cgz/300s/lkp-bdw-ep6/new_fserver/reaim/0xb000038

commit: 
  c560e9d569 ("locking/qspinlock: Refactor the qspinlock slow path")
  93ee6cfe91 ("locking/qspinlock: Introduce CNA into the slow path of qspinlock")

c560e9d569c466f8 93ee6cfe912a19a3faa62c5c28e 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          1:4          -25%            :4     dmesg.WARNING:at_ip_ip_finish_output2/0x
          0:4           12%           1:4     perf-profile.children.cycles-pp.error_entry
          0:4            9%           1:4     perf-profile.self.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
     61.27 ±  4%     -51.3%      29.81        reaim.child_systime
    455587 ±  2%     +42.2%     647868        reaim.jobs_per_min
      5177 ±  2%     +42.2%       7362        reaim.jobs_per_min_child
     95.42            -2.3%      93.26        reaim.jti
    478154           +45.3%     694642        reaim.max_jobs_per_min
      1.14 ±  2%     -29.7%       0.80        reaim.parent_time
      4.09 ±  2%     +52.7%       6.24 ±  2%  reaim.std_dev_percent
    319068           +34.3%     428603        reaim.time.involuntary_context_switches
 1.675e+08           +12.0%  1.877e+08        reaim.time.minor_page_faults
      2793           -27.5%       2024        reaim.time.percent_of_cpu_this_job_got
      5836 ±  3%     -45.6%       3177        reaim.time.system_time
      2601           +12.7%       2931        reaim.time.user_time
   1596555           +20.1%    1918162        reaim.time.voluntary_context_switches
    838200           +11.8%     937200        reaim.workload
  11805684 ± 68%    +556.0%   77442141 ±126%  cpuidle.C1.time
  74277459 ± 43%     +95.4%  1.451e+08 ± 44%  cpuidle.C1E.time
    763168 ± 42%    +111.6%    1614918 ± 52%  cpuidle.C1E.usage
     64.63            +7.4       72.01        mpstat.cpu.all.idle%
      0.02 ± 11%      +0.0        0.03        mpstat.cpu.all.soft%
     19.21 ±  3%      -8.9       10.34        mpstat.cpu.all.sys%
  78728545           +10.9%   87293704        numa-numastat.node0.local_node
  78728594           +10.9%   87293755        numa-numastat.node0.numa_hit
  78623490           +12.9%   88756866        numa-numastat.node1.local_node
  78651996           +12.9%   88785405        numa-numastat.node1.numa_hit
  39647653           +10.9%   43973857        numa-vmstat.node0.numa_hit
  39545475           +11.1%   43939654        numa-vmstat.node0.numa_local
  39541907           +12.9%   44642944        numa-vmstat.node1.numa_hit
  39464199           +12.8%   44497109        numa-vmstat.node1.numa_local
     67.75           +12.5%      76.25        vmstat.cpu.id
      9.00           +11.1%      10.00        vmstat.cpu.us
     29.25 ±  2%     -23.1%      22.50 ±  2%  vmstat.procs.r
     15701           +19.3%      18739        vmstat.system.cs
    956.50 ±  2%     -24.6%     721.50        turbostat.Avg_MHz
     36.19 ±  2%      -8.4       27.82        turbostat.Busy%
      0.04 ± 71%      +0.2        0.29 ±127%  turbostat.C1%
    760788 ± 42%    +111.9%    1611981 ± 52%  turbostat.C1E
      0.28 ± 44%      +0.3        0.55 ± 44%  turbostat.C1E%
    130.20 ±  3%     -10.9%     116.00 ±  4%  turbostat.PkgWatt
     76199            -1.2%      75256        proc-vmstat.nr_active_anon
     68401            -1.0%      67734        proc-vmstat.nr_anon_pages
      2444 ±  3%      +5.6%       2581 ±  2%  proc-vmstat.nr_page_table_pages
     52906            -2.3%      51675        proc-vmstat.nr_slab_unreclaimable
     76199            -1.2%      75256        proc-vmstat.nr_zone_active_anon
  1.57e+08           +12.2%  1.761e+08        proc-vmstat.numa_hit
 1.569e+08           +12.2%   1.76e+08        proc-vmstat.numa_local
    105682            +9.1%     115250        proc-vmstat.pgactivate
 1.616e+08           +11.6%  1.803e+08        proc-vmstat.pgalloc_normal
 1.684e+08           +12.0%  1.886e+08        proc-vmstat.pgfault
 1.616e+08           +11.6%  1.803e+08        proc-vmstat.pgfree
      7060           +11.8%       7896        slabinfo.files_cache.active_objs
      7060           +11.8%       7896        slabinfo.files_cache.num_objs
     50433           -17.8%      41452        slabinfo.filp.active_objs
      1603           -17.4%       1324        slabinfo.filp.active_slabs
     51326           -17.4%      42393        slabinfo.filp.num_objs
      1603           -17.4%       1324        slabinfo.filp.num_slabs
     25835 ±  2%     -16.6%      21559 ±  2%  slabinfo.pid.active_objs
    808.00 ±  2%     -16.6%     673.50 ±  2%  slabinfo.pid.active_slabs
     25866 ±  2%     -16.6%      21573 ±  2%  slabinfo.pid.num_objs
    808.00 ±  2%     -16.6%     673.50 ±  2%  slabinfo.pid.num_slabs
     24870 ±  3%     -34.6%      16274 ±  2%  slabinfo.task_delay_info.active_objs
    487.25 ±  3%     -34.6%     318.75 ±  2%  slabinfo.task_delay_info.active_slabs
     24876 ±  3%     -34.6%      16274 ±  2%  slabinfo.task_delay_info.num_objs
    487.25 ±  3%     -34.6%     318.75 ±  2%  slabinfo.task_delay_info.num_slabs
     45323 ±  7%     -27.0%      33069 ±  9%  sched_debug.cfs_rq:/.exec_clock.avg
     47651 ±  7%     -26.2%      35166 ±  9%  sched_debug.cfs_rq:/.exec_clock.max
     44682 ±  7%     -27.4%      32450 ±  9%  sched_debug.cfs_rq:/.exec_clock.min
     15516 ± 18%    +121.2%      34317 ± 32%  sched_debug.cfs_rq:/.load.avg
     54983 ± 57%    +131.6%     127345 ± 15%  sched_debug.cfs_rq:/.load.stddev
   3914939 ±  7%     -31.3%    2690436 ±  9%  sched_debug.cfs_rq:/.min_vruntime.avg
   3986297 ±  7%     -30.8%    2757704 ±  9%  sched_debug.cfs_rq:/.min_vruntime.max
   3825910 ±  7%     -31.6%    2616810 ±  9%  sched_debug.cfs_rq:/.min_vruntime.min
      0.23 ± 11%     +16.0%       0.26 ± 10%  sched_debug.cfs_rq:/.nr_running.stddev
      0.55 ± 21%  +15614.3%      86.83 ± 10%  sched_debug.cfs_rq:/.nr_spread_over.avg
     11.96 ± 31%   +1168.2%     151.65 ± 11%  sched_debug.cfs_rq:/.nr_spread_over.max
      1.65 ± 29%    +725.0%      13.57 ± 15%  sched_debug.cfs_rq:/.nr_spread_over.stddev
    185.43 ± 30%     -38.8%     113.47 ± 36%  sched_debug.cfs_rq:/.removed.util_avg.max
      9.69 ±  8%    +103.8%      19.74 ± 45%  sched_debug.cfs_rq:/.runnable_load_avg.avg
    257.18 ± 46%    +122.3%     571.67 ± 10%  sched_debug.cfs_rq:/.runnable_load_avg.max
     31.35 ± 48%    +191.7%      91.46 ± 30%  sched_debug.cfs_rq:/.runnable_load_avg.stddev
     14721 ± 21%    +129.8%      33831 ± 33%  sched_debug.cfs_rq:/.runnable_weight.avg
     53703 ± 60%    +136.1%     126811 ± 16%  sched_debug.cfs_rq:/.runnable_weight.stddev
      2998 ±1266%   -1716.7%     -48478        sched_debug.cfs_rq:/.spread0.avg
     74372 ± 48%     -74.7%      18833 ±108%  sched_debug.cfs_rq:/.spread0.max
    873.82 ± 37%     -60.6%     343.98 ± 26%  sched_debug.cfs_rq:/.util_est_enqueued.max
    706212 ± 15%     +20.4%     850087 ±  6%  sched_debug.cpu.avg_idle.avg
    258788 ± 10%     -31.3%     177738 ± 14%  sched_debug.cpu.avg_idle.stddev
      4.14 ± 18%     -40.1%       2.48 ± 10%  sched_debug.cpu.clock.stddev
      4.14 ± 18%     -40.1%       2.48 ± 10%  sched_debug.cpu.clock_task.stddev
     18574 ± 27%    +134.9%      43638 ±  2%  sched_debug.cpu.curr->pid.max
      3096 ± 32%     +81.1%       5608 ± 14%  sched_debug.cpu.curr->pid.stddev
      0.00 ± 31%    -100.0%       0.00        sched_debug.cpu.nr_uninterruptible.avg
      8474 ±  9%     +26.0%      10675 ±  9%  sched_debug.cpu.sched_goidle.min
      3146 ±  9%     +32.0%       4153 ±  8%  sched_debug.cpu.ttwu_local.avg
      4300 ±  6%     +22.2%       5257 ±  7%  sched_debug.cpu.ttwu_local.max
      2773 ± 10%     +36.4%       3781 ±  8%  sched_debug.cpu.ttwu_local.min
 8.595e+09            -8.2%  7.892e+09        perf-stat.i.branch-instructions
      5.78 ±  2%      -2.9        2.91 ±  4%  perf-stat.i.cache-miss-rate%
  21746088 ±  3%     -40.5%   12949418 ±  2%  perf-stat.i.cache-misses
 2.651e+08           +10.8%  2.939e+08        perf-stat.i.cache-references
     15679           +18.4%      18567        perf-stat.i.context-switches
  8.42e+10 ±  2%     -24.9%  6.327e+10        perf-stat.i.cpu-cycles
      3218           +19.1%       3834        perf-stat.i.cpu-migrations
 8.619e+09            -8.3%  7.906e+09        perf-stat.i.dTLB-loads
 2.589e+09            +9.8%  2.843e+09        perf-stat.i.dTLB-stores
   5707279 ±  3%      +5.8%    6039213 ±  2%  perf-stat.i.iTLB-load-misses
   3797999           +15.8%    4399549 ±  4%  perf-stat.i.iTLB-loads
 4.346e+10            -4.1%  4.166e+10        perf-stat.i.instructions
      5469 ±  2%     -14.6%       4672 ±  5%  perf-stat.i.instructions-per-iTLB-miss
      0.40 ±  3%     +14.2%       0.45 ±  2%  perf-stat.i.ipc
    545724           +10.8%     604720        perf-stat.i.minor-faults
     87.47            -2.7       84.79        perf-stat.i.node-load-miss-rate%
   5592203           -30.2%    3905790 ±  2%  perf-stat.i.node-load-misses
    484525 ±  2%      +8.8%     527239        perf-stat.i.node-loads
     61.13 ±  3%      -6.4       54.70 ±  5%  perf-stat.i.node-store-miss-rate%
   3117889           -50.1%    1556501 ±  2%  perf-stat.i.node-store-misses
   1447299           -20.5%    1150336        perf-stat.i.node-stores
    545724           +10.8%     604720        perf-stat.i.page-faults
      6.10           +15.8%       7.06 ±  2%  perf-stat.overall.MPKI
      0.72            +0.1        0.83 ±  6%  perf-stat.overall.branch-miss-rate%
      8.20 ±  4%      -3.8        4.43 ±  3%  perf-stat.overall.cache-miss-rate%
      1.93 ±  2%     -21.9%       1.51        perf-stat.overall.cpi
      3874 ±  5%     +24.9%       4838        perf-stat.overall.cycles-between-cache-misses
      0.12 ±  4%      +0.0        0.14 ±  4%  perf-stat.overall.dTLB-load-miss-rate%
      7623 ±  3%      -9.6%       6892 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
      0.52 ±  2%     +27.9%       0.66        perf-stat.overall.ipc
     92.00            -3.9       88.09        perf-stat.overall.node-load-miss-rate%
     68.27           -10.7       57.53        perf-stat.overall.node-store-miss-rate%
  15740753           -14.1%   13527602        perf-stat.overall.path-length
 8.617e+09            -7.7%   7.95e+09        perf-stat.ps.branch-instructions
  21794040 ±  3%     -39.9%   13104696 ±  2%  perf-stat.ps.cache-misses
 2.658e+08           +11.5%  2.962e+08        perf-stat.ps.cache-references
     15738           +19.2%      18753        perf-stat.ps.context-switches
 8.426e+10 ±  2%     -24.8%  6.339e+10        perf-stat.ps.cpu-cycles
      3230           +19.9%       3872        perf-stat.ps.cpu-migrations
 8.644e+09            -7.8%  7.972e+09        perf-stat.ps.dTLB-loads
 2.597e+09           +10.5%   2.87e+09        perf-stat.ps.dTLB-stores
   5719969 ±  3%      +6.4%    6087577 ±  2%  perf-stat.ps.iTLB-load-misses
   3823631           +16.8%    4467207 ±  4%  perf-stat.ps.iTLB-loads
 4.356e+10            -3.7%  4.193e+10        perf-stat.ps.instructions
    549083           +11.8%     613998        perf-stat.ps.minor-faults
   5606090           -29.5%    3954746 ±  2%  perf-stat.ps.node-load-misses
    487640            +9.6%     534486        perf-stat.ps.node-loads
   3122973           -49.6%    1574368 ±  2%  perf-stat.ps.node-store-misses
   1451187           -19.9%    1162269 ±  2%  perf-stat.ps.node-stores
    549083           +11.8%     613998        perf-stat.ps.page-faults
 1.319e+13            -3.9%  1.268e+13        perf-stat.total.instructions
     48977           +17.7%      57654 ±  4%  softirqs.CPU0.RCU
     38485 ±  2%     +12.7%      43366 ±  3%  softirqs.CPU0.SCHED
     46454 ±  2%     +15.4%      53627        softirqs.CPU1.NET_RX
     49074 ±  2%     +19.8%      58788 ±  6%  softirqs.CPU1.RCU
     46394           +13.0%      52433 ±  2%  softirqs.CPU10.NET_RX
     47709 ±  2%     +19.4%      56952 ±  2%  softirqs.CPU10.RCU
     32923 ±  2%     +10.9%      36503        softirqs.CPU10.SCHED
     47853 ±  3%     +10.4%      52854 ±  3%  softirqs.CPU11.NET_RX
     49167 ±  2%     +17.6%      57823 ±  5%  softirqs.CPU11.RCU
     33231 ±  2%      +9.9%      36531 ±  2%  softirqs.CPU11.SCHED
     49517 ±  3%     +16.5%      57695 ±  3%  softirqs.CPU12.RCU
     33226 ±  2%     +11.4%      37007 ±  3%  softirqs.CPU12.SCHED
     49849 ±  3%     +16.7%      58173 ±  3%  softirqs.CPU13.RCU
     49252 ±  4%     +18.5%      58350 ±  4%  softirqs.CPU14.RCU
     47974 ±  2%      +9.6%      52583 ±  3%  softirqs.CPU15.NET_RX
     48790 ±  2%     +20.1%      58593 ±  2%  softirqs.CPU15.RCU
     48756 ±  2%     +16.4%      56762 ±  2%  softirqs.CPU16.RCU
     46825           +18.7%      55571        softirqs.CPU17.RCU
     47688           +18.6%      56574 ±  5%  softirqs.CPU18.RCU
     47860 ±  3%     +18.3%      56599        softirqs.CPU19.RCU
     46492 ±  2%     +11.7%      51925 ±  3%  softirqs.CPU2.NET_RX
     48834 ±  3%     +19.2%      58217 ±  3%  softirqs.CPU2.RCU
     33560 ±  2%     +10.7%      37166 ±  2%  softirqs.CPU2.SCHED
     49356 ±  3%     +17.5%      58008 ±  3%  softirqs.CPU20.RCU
     48743 ±  3%     +18.5%      57779 ±  4%  softirqs.CPU21.RCU
     33857 ±  2%     +11.6%      37781        softirqs.CPU21.SCHED
     49364 ±  3%     +14.9%      56722 ±  3%  softirqs.CPU22.NET_RX
     48953 ±  3%     +16.9%      57206 ±  3%  softirqs.CPU22.RCU
     32547 ±  2%     +12.9%      36747        softirqs.CPU22.SCHED
     47832           +15.4%      55205 ±  6%  softirqs.CPU23.NET_RX
     50220 ±  5%     +13.1%      56778 ±  3%  softirqs.CPU23.RCU
     32511           +13.4%      36868        softirqs.CPU23.SCHED
     47408 ±  3%     +15.7%      54873        softirqs.CPU24.NET_RX
     48937 ±  3%     +18.1%      57812        softirqs.CPU24.RCU
     33044 ±  3%     +12.7%      37231        softirqs.CPU24.SCHED
     47942 ±  4%     +15.2%      55233 ±  4%  softirqs.CPU25.NET_RX
     47429 ±  4%     +21.0%      57378 ±  3%  softirqs.CPU25.RCU
     32792           +14.7%      37625        softirqs.CPU25.SCHED
     48144 ±  2%     +15.2%      55445 ±  4%  softirqs.CPU26.NET_RX
     48296 ±  3%     +19.3%      57602 ±  3%  softirqs.CPU26.RCU
     32422           +13.6%      36829        softirqs.CPU26.SCHED
     49959 ±  4%     +11.7%      55786 ±  2%  softirqs.CPU27.NET_RX
     47393 ±  2%     +19.8%      56774 ±  4%  softirqs.CPU27.RCU
     32071           +13.9%      36530        softirqs.CPU27.SCHED
     48059 ±  3%     +15.1%      55330 ±  6%  softirqs.CPU28.NET_RX
     48212 ±  4%     +16.3%      56088 ±  2%  softirqs.CPU28.RCU
     32315           +13.9%      36806        softirqs.CPU28.SCHED
     49095 ±  2%     +10.4%      54176 ±  2%  softirqs.CPU29.NET_RX
     47544 ±  3%     +18.5%      56333 ±  2%  softirqs.CPU29.RCU
     31995 ±  2%     +13.5%      36300        softirqs.CPU29.SCHED
     48637           +24.0%      60291 ±  6%  softirqs.CPU3.RCU
     33556 ±  2%     +11.0%      37232 ±  2%  softirqs.CPU3.SCHED
     47361 ±  4%     +15.2%      54546 ±  2%  softirqs.CPU30.NET_RX
     47054           +19.1%      56025 ±  6%  softirqs.CPU30.RCU
     31890           +13.4%      36170        softirqs.CPU30.SCHED
     46697 ±  2%     +23.3%      57565 ±  4%  softirqs.CPU31.RCU
     31701 ±  2%     +14.7%      36377        softirqs.CPU31.SCHED
     48243           +12.3%      54177 ±  3%  softirqs.CPU32.NET_RX
     48500 ±  3%     +17.9%      57190 ±  2%  softirqs.CPU32.RCU
     32208 ±  2%     +13.4%      36535        softirqs.CPU32.SCHED
     48099 ±  5%     +17.8%      56657 ±  3%  softirqs.CPU33.NET_RX
     48528 ±  3%     +19.0%      57767 ±  2%  softirqs.CPU33.RCU
     32245           +15.0%      37073        softirqs.CPU33.SCHED
     47398 ±  4%     +16.3%      55126 ±  2%  softirqs.CPU34.NET_RX
     48581 ±  5%     +18.8%      57729 ±  4%  softirqs.CPU34.RCU
     32457           +15.0%      37337 ±  3%  softirqs.CPU34.SCHED
     49290           +13.5%      55946 ±  4%  softirqs.CPU35.NET_RX
     49758 ±  4%     +15.6%      57530 ±  4%  softirqs.CPU35.RCU
     32505           +14.2%      37112        softirqs.CPU35.SCHED
     49292 ±  4%     +13.0%      55697 ±  2%  softirqs.CPU36.NET_RX
     51230 ±  4%     +16.2%      59515 ±  5%  softirqs.CPU36.RCU
     32667           +14.2%      37320 ±  2%  softirqs.CPU36.SCHED
     47577 ±  2%     +12.1%      53344 ±  2%  softirqs.CPU37.NET_RX
     50677 ±  4%     +17.6%      59595 ±  5%  softirqs.CPU37.RCU
     32829           +14.4%      37563        softirqs.CPU37.SCHED
     48443           +15.4%      55922 ±  2%  softirqs.CPU38.NET_RX
     49047 ±  4%     +19.6%      58660 ±  4%  softirqs.CPU38.RCU
     32547           +13.6%      36985 ±  2%  softirqs.CPU38.SCHED
     49396 ±  3%     +16.9%      57737 ±  3%  softirqs.CPU39.RCU
     32349           +13.9%      36834        softirqs.CPU39.SCHED
     48630 ±  2%      +9.6%      53286 ±  3%  softirqs.CPU4.NET_RX
     48739 ±  4%     +19.2%      58073 ±  4%  softirqs.CPU4.RCU
     33265 ±  2%     +11.1%      36963 ±  2%  softirqs.CPU4.SCHED
     46348           +17.3%      54386 ±  3%  softirqs.CPU40.NET_RX
     50463 ±  3%     +16.5%      58769 ±  4%  softirqs.CPU40.RCU
     32412           +14.6%      37132        softirqs.CPU40.SCHED
     49209 ±  3%     +20.7%      59376 ±  3%  softirqs.CPU41.RCU
     32391           +14.5%      37102        softirqs.CPU41.SCHED
     46766 ±  4%     +15.3%      53933 ±  4%  softirqs.CPU42.NET_RX
     49979 ±  5%     +18.6%      59297 ±  4%  softirqs.CPU42.RCU
     32566           +14.5%      37284 ±  2%  softirqs.CPU42.SCHED
     46787 ±  5%     +17.3%      54901        softirqs.CPU43.NET_RX
     50400 ±  4%     +18.4%      59698 ±  4%  softirqs.CPU43.RCU
     32587           +13.8%      37077 ±  2%  softirqs.CPU43.SCHED
     44229           +17.0%      51763        softirqs.CPU44.RCU
     49592 ±  4%     +16.8%      57938 ±  6%  softirqs.CPU45.RCU
     33227 ±  2%     +11.1%      36909 ±  2%  softirqs.CPU45.SCHED
     48764 ±  3%     +19.2%      58111 ±  3%  softirqs.CPU46.RCU
     47141 ±  3%     +13.1%      53330 ±  2%  softirqs.CPU47.NET_RX
     48440           +20.9%      58548 ±  5%  softirqs.CPU47.RCU
     33268 ±  2%     +13.0%      37601 ±  4%  softirqs.CPU47.SCHED
     49415 ±  2%     +19.4%      59015 ±  5%  softirqs.CPU48.RCU
     32966 ±  2%     +13.7%      37467 ±  2%  softirqs.CPU48.SCHED
     47575 ±  5%     +11.0%      52787 ±  4%  softirqs.CPU49.NET_RX
     48265 ±  3%     +21.6%      58709 ±  4%  softirqs.CPU49.RCU
     32912 ±  2%     +13.3%      37286 ±  3%  softirqs.CPU49.SCHED
     48110 ±  3%     +12.4%      54070 ±  2%  softirqs.CPU5.NET_RX
     48597 ±  4%     +20.2%      58410 ±  2%  softirqs.CPU5.RCU
     33064 ±  2%     +11.0%      36712        softirqs.CPU5.SCHED
     47582 ±  3%     +15.3%      54852 ±  2%  softirqs.CPU50.NET_RX
     48641 ±  2%     +20.3%      58527 ±  2%  softirqs.CPU50.RCU
     33158            +9.8%      36396 ±  2%  softirqs.CPU50.SCHED
     46879 ±  4%     +15.3%      54032 ±  2%  softirqs.CPU51.NET_RX
     48351 ±  3%     +18.0%      57064 ±  2%  softirqs.CPU51.RCU
     33012 ±  2%     +10.9%      36609 ±  2%  softirqs.CPU51.SCHED
     46576 ±  2%     +21.7%      56694 ±  5%  softirqs.CPU52.RCU
     47553 ±  4%     +13.8%      54124 ±  3%  softirqs.CPU53.NET_RX
     46721           +22.7%      57349 ±  4%  softirqs.CPU53.RCU
     32065           +13.0%      36230 ±  2%  softirqs.CPU53.SCHED
     46800 ±  4%     +10.9%      51904 ±  2%  softirqs.CPU54.NET_RX
     49287 ±  6%     +18.9%      58609 ±  4%  softirqs.CPU54.RCU
     32804 ±  2%     +11.1%      36447        softirqs.CPU54.SCHED
     49656 ±  4%     +18.2%      58704 ±  5%  softirqs.CPU55.RCU
     33472 ±  2%     +10.0%      36820 ±  3%  softirqs.CPU55.SCHED
     48968 ±  3%     +18.9%      58211 ±  3%  softirqs.CPU56.RCU
     33468 ±  2%     +11.0%      37154 ±  3%  softirqs.CPU56.SCHED
     47961 ±  4%     +10.3%      52909 ±  3%  softirqs.CPU57.NET_RX
     49563 ±  3%     +18.6%      58788 ±  4%  softirqs.CPU57.RCU
     46461 ±  3%     +13.7%      52805 ±  3%  softirqs.CPU58.NET_RX
     49184 ±  5%     +20.5%      59258 ±  4%  softirqs.CPU58.RCU
     49212 ±  4%     +19.4%      58775 ±  4%  softirqs.CPU59.RCU
     46988 ±  3%     +10.0%      51704        softirqs.CPU6.NET_RX
     49174 ±  3%     +16.6%      57332 ±  3%  softirqs.CPU6.RCU
     33750 ±  4%      +7.8%      36380 ±  3%  softirqs.CPU6.SCHED
     49159           +14.4%      56249 ±  2%  softirqs.CPU60.RCU
     49247           +10.6%      54491 ±  3%  softirqs.CPU61.NET_RX
     46734 ±  2%     +19.2%      55687 ±  2%  softirqs.CPU61.RCU
     47538 ±  2%     +17.9%      56030 ±  2%  softirqs.CPU62.RCU
     47763           +18.2%      56448 ±  2%  softirqs.CPU63.RCU
     33265 ±  3%     +12.0%      37265 ±  2%  softirqs.CPU63.SCHED
     47590 ±  3%     +10.4%      52534        softirqs.CPU64.NET_RX
     48434 ±  3%     +18.3%      57283 ±  3%  softirqs.CPU64.RCU
     47709           +12.0%      53456        softirqs.CPU65.NET_RX
     48087 ±  4%     +18.3%      56868 ±  4%  softirqs.CPU65.RCU
     48972 ±  2%     +18.5%      58015 ±  3%  softirqs.CPU66.RCU
     32409           +13.7%      36847        softirqs.CPU66.SCHED
     47519 ±  4%     +15.2%      54725 ±  4%  softirqs.CPU67.NET_RX
     47696 ±  4%     +17.9%      56247 ±  4%  softirqs.CPU67.RCU
     32208 ±  3%     +14.1%      36739        softirqs.CPU67.SCHED
     47075 ±  3%     +15.9%      54560        softirqs.CPU68.NET_RX
     47792           +20.5%      57575 ±  2%  softirqs.CPU68.RCU
     32138           +14.6%      36816 ±  2%  softirqs.CPU68.SCHED
     47433 ±  3%     +16.2%      55121 ±  4%  softirqs.CPU69.NET_RX
     47301 ±  4%     +22.1%      57758 ±  3%  softirqs.CPU69.RCU
     32299 ±  2%     +13.7%      36737        softirqs.CPU69.SCHED
     48390 ±  3%     +18.7%      57419 ±  2%  softirqs.CPU7.RCU
     32880           +12.8%      37099 ±  3%  softirqs.CPU7.SCHED
     50307            +9.5%      55080 ±  3%  softirqs.CPU70.NET_RX
     48452 ±  3%     +18.6%      57447 ±  3%  softirqs.CPU70.RCU
     32125           +15.3%      37040        softirqs.CPU70.SCHED
     48611 ±  3%     +17.8%      57283 ±  3%  softirqs.CPU71.RCU
     32318 ±  2%     +13.1%      36563        softirqs.CPU71.SCHED
     48893 ±  6%     +14.3%      55899 ±  6%  softirqs.CPU72.NET_RX
     47550 ±  3%     +19.3%      56721 ±  2%  softirqs.CPU72.RCU
     32326 ±  2%     +13.8%      36773        softirqs.CPU72.SCHED
     47527 ±  2%     +17.5%      55861 ±  2%  softirqs.CPU73.RCU
     31993 ±  2%     +13.7%      36378        softirqs.CPU73.SCHED
     48460 ±  2%     +13.1%      54787 ±  4%  softirqs.CPU74.NET_RX
     46467 ±  2%     +20.3%      55888 ±  3%  softirqs.CPU74.RCU
     31978           +12.6%      36016        softirqs.CPU74.SCHED
     46684 ±  4%     +14.7%      53541 ±  2%  softirqs.CPU75.NET_RX
     45960           +23.9%      56941 ±  3%  softirqs.CPU75.RCU
     31671           +15.4%      36536        softirqs.CPU75.SCHED
     47422 ±  2%     +16.0%      55001 ±  2%  softirqs.CPU76.NET_RX
     47343 ±  4%     +18.3%      56008 ±  2%  softirqs.CPU76.RCU
     32138           +14.2%      36694        softirqs.CPU76.SCHED
     49195 ±  4%     +10.9%      54560 ±  4%  softirqs.CPU77.NET_RX
     48501 ±  2%     +16.1%      56316 ±  2%  softirqs.CPU77.RCU
     32173           +14.4%      36800        softirqs.CPU77.SCHED
     47701 ±  4%     +15.5%      55115 ±  2%  softirqs.CPU78.NET_RX
     48593 ±  2%     +16.1%      56436 ±  3%  softirqs.CPU78.RCU
     32985 ±  2%     +12.7%      37174 ±  2%  softirqs.CPU78.SCHED
     49741 ±  4%      +9.9%      54646 ±  2%  softirqs.CPU79.NET_RX
     48675 ±  4%     +19.8%      58311 ±  4%  softirqs.CPU79.RCU
     32505           +14.3%      37142        softirqs.CPU79.SCHED
     45969 ±  2%     +17.7%      54111 ±  3%  softirqs.CPU8.NET_RX
     47255 ±  2%     +19.9%      56650 ±  4%  softirqs.CPU8.RCU
     47895 ±  3%     +12.7%      53960 ±  4%  softirqs.CPU80.NET_RX
     50318 ±  6%     +17.1%      58921 ±  4%  softirqs.CPU80.RCU
     32726           +14.4%      37435        softirqs.CPU80.SCHED
     45379 ±  2%     +16.5%      52874 ±  2%  softirqs.CPU81.NET_RX
     50045 ±  5%     +17.2%      58667 ±  5%  softirqs.CPU81.RCU
     32729           +14.8%      37575        softirqs.CPU81.SCHED
     49694 ±  4%     +18.0%      58656 ±  3%  softirqs.CPU82.RCU
     32657           +13.8%      37172        softirqs.CPU82.SCHED
     49069           +17.2%      57532 ±  2%  softirqs.CPU83.NET_RX
     47673 ±  4%     +20.5%      57437 ±  3%  softirqs.CPU83.RCU
     32623 ±  2%     +13.4%      37009        softirqs.CPU83.SCHED
     46996 ±  2%     +12.8%      53031 ±  4%  softirqs.CPU84.NET_RX
     49512 ±  5%     +16.3%      57584 ±  3%  softirqs.CPU84.RCU
     32752           +13.5%      37183 ±  2%  softirqs.CPU84.SCHED
     47454 ±  3%     +15.6%      54839 ±  2%  softirqs.CPU85.NET_RX
     49028 ±  2%     +17.8%      57755 ±  3%  softirqs.CPU85.RCU
     32466           +13.7%      36922 ±  2%  softirqs.CPU85.SCHED
     46441 ±  2%     +20.7%      56057        softirqs.CPU86.NET_RX
     49653 ±  5%     +19.7%      59434 ±  4%  softirqs.CPU86.RCU
     32804           +13.3%      37175 ±  2%  softirqs.CPU86.SCHED
     48708 ±  2%     +12.1%      54604 ±  4%  softirqs.CPU87.NET_RX
     49069 ±  5%     +18.7%      58246 ±  5%  softirqs.CPU87.RCU
     32397           +13.7%      36843 ±  2%  softirqs.CPU87.SCHED
     47016 ±  2%     +13.0%      53123 ±  3%  softirqs.CPU9.NET_RX
     47242 ±  2%     +21.5%      57378 ±  4%  softirqs.CPU9.RCU
     31940           +12.6%      35979 ±  2%  softirqs.CPU9.SCHED
   4230778           +11.8%    4730043        softirqs.NET_RX
   4272003 ±  3%     +18.7%    5069707 ±  3%  softirqs.RCU
   2899405           +12.4%    3259875        softirqs.SCHED
    412.75 ± 20%     -54.5%     187.75 ± 18%  interrupts.40:IR-PCI-MSI.1572871-edge.eth0-TxRx-6
     46705           +16.5%      54398 ±  3%  interrupts.CAL:Function_call_interrupts
    347.50 ±  3%     +27.4%     442.75 ±  6%  interrupts.CPU0.CAL:Function_call_interrupts
     91.75 ± 22%     +99.5%     183.00 ± 11%  interrupts.CPU0.TLB:TLB_shootdowns
    544.00           +16.6%     634.50 ±  4%  interrupts.CPU1.CAL:Function_call_interrupts
      3153 ±  4%     -15.4%       2668 ±  5%  interrupts.CPU1.NMI:Non-maskable_interrupts
      3153 ±  4%     -15.4%       2668 ±  5%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
     98.25 ± 15%     +95.4%     192.00 ± 13%  interrupts.CPU1.TLB:TLB_shootdowns
    542.75           +14.7%     622.50 ±  3%  interrupts.CPU10.CAL:Function_call_interrupts
      3181 ±  4%     -25.9%       2359 ± 29%  interrupts.CPU10.NMI:Non-maskable_interrupts
      3181 ±  4%     -25.9%       2359 ± 29%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
    895.00 ± 14%     +26.0%       1128        interrupts.CPU10.RES:Rescheduling_interrupts
     97.00 ± 11%    +154.9%     247.25 ± 25%  interrupts.CPU10.TLB:TLB_shootdowns
    526.25           +18.7%     624.75        interrupts.CPU11.CAL:Function_call_interrupts
      3169 ±  3%     -27.2%       2308 ± 23%  interrupts.CPU11.NMI:Non-maskable_interrupts
      3169 ±  3%     -27.2%       2308 ± 23%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
    848.00           +51.8%       1287 ± 23%  interrupts.CPU11.RES:Rescheduling_interrupts
     75.50 ±  6%    +166.6%     201.25 ±  7%  interrupts.CPU11.TLB:TLB_shootdowns
    534.00 ±  3%     +14.7%     612.50 ±  3%  interrupts.CPU12.CAL:Function_call_interrupts
    822.25 ±  4%     +42.2%       1169 ±  8%  interrupts.CPU12.RES:Rescheduling_interrupts
     89.50 ± 17%    +104.2%     182.75 ±  8%  interrupts.CPU12.TLB:TLB_shootdowns
    523.00           +17.0%     612.00 ±  3%  interrupts.CPU13.CAL:Function_call_interrupts
      3146 ±  4%     -15.4%       2661 ±  5%  interrupts.CPU13.NMI:Non-maskable_interrupts
      3146 ±  4%     -15.4%       2661 ±  5%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
    843.25           +33.3%       1124 ±  3%  interrupts.CPU13.RES:Rescheduling_interrupts
     78.50 ±  7%    +110.8%     165.50 ± 17%  interrupts.CPU13.TLB:TLB_shootdowns
    528.25           +17.8%     622.50        interrupts.CPU14.CAL:Function_call_interrupts
      3231 ±  3%     -18.0%       2650 ±  7%  interrupts.CPU14.NMI:Non-maskable_interrupts
      3231 ±  3%     -18.0%       2650 ±  7%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
    954.50 ± 15%     +25.0%       1193 ±  4%  interrupts.CPU14.RES:Rescheduling_interrupts
     84.25 ± 16%    +119.3%     184.75 ± 21%  interrupts.CPU14.TLB:TLB_shootdowns
    529.50           +18.2%     625.75 ±  4%  interrupts.CPU15.CAL:Function_call_interrupts
      3188 ±  5%     -26.9%       2329 ± 23%  interrupts.CPU15.NMI:Non-maskable_interrupts
      3188 ±  5%     -26.9%       2329 ± 23%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
    885.75 ±  3%     +30.0%       1151 ±  4%  interrupts.CPU15.RES:Rescheduling_interrupts
     76.50 ±  8%    +162.1%     200.50 ± 18%  interrupts.CPU15.TLB:TLB_shootdowns
    531.25 ±  2%     +16.1%     617.00        interrupts.CPU16.CAL:Function_call_interrupts
      3194 ±  4%     -27.2%       2326 ± 23%  interrupts.CPU16.NMI:Non-maskable_interrupts
      3194 ±  4%     -27.2%       2326 ± 23%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
    842.25 ±  3%     +33.6%       1125 ±  3%  interrupts.CPU16.RES:Rescheduling_interrupts
     80.00 ± 10%    +102.2%     161.75 ±  7%  interrupts.CPU16.TLB:TLB_shootdowns
    532.75           +15.9%     617.50 ±  3%  interrupts.CPU17.CAL:Function_call_interrupts
      3168 ±  4%     -39.1%       1931 ± 30%  interrupts.CPU17.NMI:Non-maskable_interrupts
      3168 ±  4%     -39.1%       1931 ± 30%  interrupts.CPU17.PMI:Performance_monitoring_interrupts
    820.75 ±  3%     +35.6%       1112 ±  2%  interrupts.CPU17.RES:Rescheduling_interrupts
     88.75 ± 11%     +99.7%     177.25 ± 15%  interrupts.CPU17.TLB:TLB_shootdowns
    530.00 ±  2%     +17.7%     623.75 ±  3%  interrupts.CPU18.CAL:Function_call_interrupts
      3188 ±  4%     -28.1%       2291 ± 23%  interrupts.CPU18.NMI:Non-maskable_interrupts
      3188 ±  4%     -28.1%       2291 ± 23%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
     81.50 ± 12%    +127.6%     185.50 ± 22%  interrupts.CPU18.TLB:TLB_shootdowns
    412.75 ± 20%     -54.5%     187.75 ± 18%  interrupts.CPU19.40:IR-PCI-MSI.1572871-edge.eth0-TxRx-6
    528.75 ±  3%     +15.7%     611.50 ±  2%  interrupts.CPU19.CAL:Function_call_interrupts
      3173 ±  4%     -38.4%       1955 ± 31%  interrupts.CPU19.NMI:Non-maskable_interrupts
      3173 ±  4%     -38.4%       1955 ± 31%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
    813.50 ±  2%     +35.4%       1101 ±  2%  interrupts.CPU19.RES:Rescheduling_interrupts
     85.00 ± 16%     +93.5%     164.50 ± 14%  interrupts.CPU19.TLB:TLB_shootdowns
    529.75           +16.6%     617.50 ±  3%  interrupts.CPU2.CAL:Function_call_interrupts
      3168 ±  4%     -16.3%       2651 ±  6%  interrupts.CPU2.NMI:Non-maskable_interrupts
      3168 ±  4%     -16.3%       2651 ±  6%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
     82.00 ±  7%    +102.1%     165.75 ± 13%  interrupts.CPU2.TLB:TLB_shootdowns
    535.50 ±  2%     +14.7%     614.25 ±  6%  interrupts.CPU20.CAL:Function_call_interrupts
      3183 ±  4%     -27.6%       2303 ± 23%  interrupts.CPU20.NMI:Non-maskable_interrupts
      3183 ±  4%     -27.6%       2303 ± 23%  interrupts.CPU20.PMI:Performance_monitoring_interrupts
    913.25 ± 12%     +40.3%       1281 ± 12%  interrupts.CPU20.RES:Rescheduling_interrupts
     87.50 ± 22%    +105.1%     179.50 ± 27%  interrupts.CPU20.TLB:TLB_shootdowns
    534.75           +15.2%     616.25 ±  3%  interrupts.CPU21.CAL:Function_call_interrupts
      3212 ±  3%     -25.2%       2401 ± 24%  interrupts.CPU21.NMI:Non-maskable_interrupts
      3212 ±  3%     -25.2%       2401 ± 24%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
    836.25 ±  3%     +37.3%       1148 ±  4%  interrupts.CPU21.RES:Rescheduling_interrupts
     82.50 ± 10%    +100.0%     165.00 ±  8%  interrupts.CPU21.TLB:TLB_shootdowns
    533.75           +15.7%     617.50 ±  4%  interrupts.CPU22.CAL:Function_call_interrupts
    904.25 ±  2%     +36.7%       1236 ±  5%  interrupts.CPU22.RES:Rescheduling_interrupts
     83.25 ± 12%    +103.0%     169.00 ± 17%  interrupts.CPU22.TLB:TLB_shootdowns
      3229 ±  5%     -18.0%       2649 ±  8%  interrupts.CPU23.NMI:Non-maskable_interrupts
      3229 ±  5%     -18.0%       2649 ±  8%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
    872.25           +41.0%       1229 ±  5%  interrupts.CPU23.RES:Rescheduling_interrupts
    108.75 ± 25%     +64.8%     179.25 ± 12%  interrupts.CPU23.TLB:TLB_shootdowns
    531.75           +18.3%     629.00 ±  3%  interrupts.CPU24.CAL:Function_call_interrupts
    823.00 ±  4%     +46.0%       1201 ±  4%  interrupts.CPU24.RES:Rescheduling_interrupts
     83.50 ± 11%    +125.1%     188.00 ± 10%  interrupts.CPU24.TLB:TLB_shootdowns
    488.00 ± 14%     +27.5%     622.25 ±  5%  interrupts.CPU25.CAL:Function_call_interrupts
      3176 ±  4%     -26.7%       2326 ± 29%  interrupts.CPU25.NMI:Non-maskable_interrupts
      3176 ±  4%     -26.7%       2326 ± 29%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
    851.00 ±  6%     +35.8%       1155 ±  2%  interrupts.CPU25.RES:Rescheduling_interrupts
     92.00 ± 10%    +167.4%     246.00 ± 44%  interrupts.CPU25.TLB:TLB_shootdowns
    484.00 ± 13%     +28.5%     621.75 ±  3%  interrupts.CPU26.CAL:Function_call_interrupts
    889.25 ±  4%     +31.3%       1167 ±  2%  interrupts.CPU26.RES:Rescheduling_interrupts
     82.00 ± 22%    +131.7%     190.00 ± 17%  interrupts.CPU26.TLB:TLB_shootdowns
    532.25           +15.0%     612.00 ±  2%  interrupts.CPU27.CAL:Function_call_interrupts
      3184 ±  4%     -17.0%       2643 ±  7%  interrupts.CPU27.NMI:Non-maskable_interrupts
      3184 ±  4%     -17.0%       2643 ±  7%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
    850.00 ±  7%     +31.5%       1117 ±  3%  interrupts.CPU27.RES:Rescheduling_interrupts
     88.75 ± 14%     +85.1%     164.25 ±  8%  interrupts.CPU27.TLB:TLB_shootdowns
    528.00           +17.2%     619.00 ±  4%  interrupts.CPU28.CAL:Function_call_interrupts
      3170 ±  3%     -28.1%       2279 ± 23%  interrupts.CPU28.NMI:Non-maskable_interrupts
      3170 ±  3%     -28.1%       2279 ± 23%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
    886.75 ±  6%     +32.6%       1176        interrupts.CPU28.RES:Rescheduling_interrupts
    107.25 ± 19%     +67.1%     179.25 ± 24%  interrupts.CPU28.TLB:TLB_shootdowns
    513.50           +21.4%     623.25 ±  5%  interrupts.CPU29.CAL:Function_call_interrupts
    897.50 ±  4%     +29.3%       1160 ±  3%  interrupts.CPU29.RES:Rescheduling_interrupts
    527.50 ±  2%     +18.0%     622.25 ±  3%  interrupts.CPU3.CAL:Function_call_interrupts
      3165 ±  4%     -27.9%       2281 ± 25%  interrupts.CPU3.NMI:Non-maskable_interrupts
      3165 ±  4%     -27.9%       2281 ± 25%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
    872.50           +42.2%       1240 ± 11%  interrupts.CPU3.RES:Rescheduling_interrupts
     83.25 ± 19%    +121.0%     184.00 ± 13%  interrupts.CPU3.TLB:TLB_shootdowns
    531.25           +15.5%     613.75 ±  5%  interrupts.CPU30.CAL:Function_call_interrupts
    852.75 ±  2%     +38.3%       1179 ±  2%  interrupts.CPU30.RES:Rescheduling_interrupts
     86.75 ± 18%     +86.2%     161.50 ± 21%  interrupts.CPU30.TLB:TLB_shootdowns
    530.00           +19.9%     635.50 ±  3%  interrupts.CPU31.CAL:Function_call_interrupts
      3124 ±  5%     -27.1%       2277 ± 22%  interrupts.CPU31.NMI:Non-maskable_interrupts
      3124 ±  5%     -27.1%       2277 ± 22%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
    810.25 ±  6%     +47.7%       1197 ±  2%  interrupts.CPU31.RES:Rescheduling_interrupts
     79.75 ±  8%    +138.6%     190.25 ±  6%  interrupts.CPU31.TLB:TLB_shootdowns
    529.25 ±  2%     +16.0%     613.75 ±  5%  interrupts.CPU32.CAL:Function_call_interrupts
      3155 ±  4%     -27.2%       2296 ± 23%  interrupts.CPU32.NMI:Non-maskable_interrupts
      3155 ±  4%     -27.2%       2296 ± 23%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
    862.25 ±  3%     +33.1%       1148        interrupts.CPU32.RES:Rescheduling_interrupts
     80.25 ± 13%    +119.6%     176.25 ± 14%  interrupts.CPU32.TLB:TLB_shootdowns
    534.50           +16.0%     620.00 ±  3%  interrupts.CPU33.CAL:Function_call_interrupts
    863.75 ±  3%     +34.0%       1157 ±  2%  interrupts.CPU33.RES:Rescheduling_interrupts
     95.75 ± 27%    +154.0%     243.25 ± 51%  interrupts.CPU33.TLB:TLB_shootdowns
    523.75           +17.8%     617.00 ±  4%  interrupts.CPU34.CAL:Function_call_interrupts
    859.50 ±  7%     +37.2%       1179 ±  4%  interrupts.CPU34.RES:Rescheduling_interrupts
     72.00 ±  9%    +160.1%     187.25 ± 14%  interrupts.CPU34.TLB:TLB_shootdowns
    525.00           +18.0%     619.25 ±  5%  interrupts.CPU35.CAL:Function_call_interrupts
    830.00 ±  2%     +39.6%       1158        interrupts.CPU35.RES:Rescheduling_interrupts
     81.50 ± 10%    +108.9%     170.25 ± 21%  interrupts.CPU35.TLB:TLB_shootdowns
    530.25           +15.6%     613.00 ±  2%  interrupts.CPU36.CAL:Function_call_interrupts
    890.25 ±  3%     +34.3%       1195 ±  7%  interrupts.CPU36.RES:Rescheduling_interrupts
     95.75 ± 17%     +82.2%     174.50 ± 22%  interrupts.CPU36.TLB:TLB_shootdowns
    534.75           +15.1%     615.25 ±  4%  interrupts.CPU37.CAL:Function_call_interrupts
    902.50 ±  4%     +34.8%       1216 ±  4%  interrupts.CPU37.RES:Rescheduling_interrupts
     88.00 ± 13%    +193.2%     258.00 ± 51%  interrupts.CPU37.TLB:TLB_shootdowns
    528.50           +16.3%     614.50 ±  4%  interrupts.CPU38.CAL:Function_call_interrupts
    894.25 ±  4%     +26.7%       1132 ±  5%  interrupts.CPU38.RES:Rescheduling_interrupts
     85.50 ± 22%     +89.8%     162.25 ± 21%  interrupts.CPU38.TLB:TLB_shootdowns
    531.25           +17.6%     624.75 ±  4%  interrupts.CPU39.CAL:Function_call_interrupts
    847.00 ±  2%     +37.7%       1166 ±  6%  interrupts.CPU39.RES:Rescheduling_interrupts
     80.50 ±  8%    +135.1%     189.25 ± 17%  interrupts.CPU39.TLB:TLB_shootdowns
    536.00 ±  2%     +17.2%     628.00 ±  3%  interrupts.CPU4.CAL:Function_call_interrupts
      3163 ±  4%     -16.0%       2657 ±  9%  interrupts.CPU4.NMI:Non-maskable_interrupts
      3163 ±  4%     -16.0%       2657 ±  9%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
    834.25 ±  6%     +34.8%       1124 ±  2%  interrupts.CPU4.RES:Rescheduling_interrupts
     99.50 ±  9%     +80.4%     179.50 ±  9%  interrupts.CPU4.TLB:TLB_shootdowns
    528.75           +16.8%     617.50 ±  4%  interrupts.CPU40.CAL:Function_call_interrupts
      3144 ±  4%     -16.7%       2620 ±  8%  interrupts.CPU40.NMI:Non-maskable_interrupts
      3144 ±  4%     -16.7%       2620 ±  8%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
    863.00 ±  5%     +28.7%       1110 ±  4%  interrupts.CPU40.RES:Rescheduling_interrupts
     83.50 ±  9%    +133.2%     194.75 ± 16%  interrupts.CPU40.TLB:TLB_shootdowns
    522.00 ±  2%     +19.9%     625.75 ±  4%  interrupts.CPU41.CAL:Function_call_interrupts
      3163 ±  4%     -26.4%       2329 ± 29%  interrupts.CPU41.NMI:Non-maskable_interrupts
      3163 ±  4%     -26.4%       2329 ± 29%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
    855.00 ±  4%     +35.2%       1155 ±  4%  interrupts.CPU41.RES:Rescheduling_interrupts
     71.50 ± 14%    +159.8%     185.75 ± 20%  interrupts.CPU41.TLB:TLB_shootdowns
    532.25 ±  3%     +17.7%     626.50 ±  4%  interrupts.CPU42.CAL:Function_call_interrupts
    858.00           +36.8%       1173 ±  2%  interrupts.CPU42.RES:Rescheduling_interrupts
     87.75 ± 24%    +116.8%     190.25 ± 15%  interrupts.CPU42.TLB:TLB_shootdowns
    499.25           +16.8%     583.25 ±  4%  interrupts.CPU43.CAL:Function_call_interrupts
    103.75 ± 15%     +91.8%     199.00 ± 18%  interrupts.CPU43.TLB:TLB_shootdowns
    542.00 ±  2%     +13.5%     615.25 ±  2%  interrupts.CPU44.CAL:Function_call_interrupts
      3155 ±  4%     -15.0%       2683 ±  6%  interrupts.CPU44.NMI:Non-maskable_interrupts
      3155 ±  4%     -15.0%       2683 ±  6%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
    880.00 ± 10%     +28.8%       1133 ±  5%  interrupts.CPU44.RES:Rescheduling_interrupts
     93.75 ± 23%     +80.3%     169.00 ± 13%  interrupts.CPU44.TLB:TLB_shootdowns
    535.75           +15.7%     619.75 ±  3%  interrupts.CPU45.CAL:Function_call_interrupts
    836.25 ±  2%     +34.5%       1124 ±  3%  interrupts.CPU45.RES:Rescheduling_interrupts
     93.00 ±  9%    +115.9%     200.75 ± 21%  interrupts.CPU45.TLB:TLB_shootdowns
    527.00 ±  2%     +14.8%     605.00        interrupts.CPU46.CAL:Function_call_interrupts
    804.25 ±  4%     +37.2%       1103 ±  5%  interrupts.CPU46.RES:Rescheduling_interrupts
     73.75 ± 12%    +121.0%     163.00 ±  9%  interrupts.CPU46.TLB:TLB_shootdowns
    528.25 ±  2%     +14.3%     603.75 ±  3%  interrupts.CPU47.CAL:Function_call_interrupts
    843.75 ±  4%     +32.3%       1116 ±  4%  interrupts.CPU47.RES:Rescheduling_interrupts
     86.25 ± 18%     +76.8%     152.50 ± 15%  interrupts.CPU47.TLB:TLB_shootdowns
    534.25           +14.7%     613.00 ±  3%  interrupts.CPU48.CAL:Function_call_interrupts
    813.75           +39.2%       1132 ±  2%  interrupts.CPU48.RES:Rescheduling_interrupts
     83.25 ± 10%    +100.9%     167.25 ± 11%  interrupts.CPU48.TLB:TLB_shootdowns
    534.00           +15.4%     616.50 ±  3%  interrupts.CPU49.CAL:Function_call_interrupts
    832.25 ±  4%     +37.4%       1143 ±  3%  interrupts.CPU49.RES:Rescheduling_interrupts
     83.50 ±  7%    +113.2%     178.00 ± 15%  interrupts.CPU49.TLB:TLB_shootdowns
    530.00           +17.2%     621.00 ±  2%  interrupts.CPU5.CAL:Function_call_interrupts
      3193 ±  5%     -28.2%       2292 ± 23%  interrupts.CPU5.NMI:Non-maskable_interrupts
      3193 ±  5%     -28.2%       2292 ± 23%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
    855.00 ±  2%     +50.9%       1290 ± 12%  interrupts.CPU5.RES:Rescheduling_interrupts
     79.25 ± 11%    +125.6%     178.75 ± 16%  interrupts.CPU5.TLB:TLB_shootdowns
    533.75           +16.0%     619.25 ±  3%  interrupts.CPU50.CAL:Function_call_interrupts
    854.25 ±  3%     +34.5%       1149        interrupts.CPU50.RES:Rescheduling_interrupts
     95.50 ± 19%     +91.9%     183.25 ± 14%  interrupts.CPU50.TLB:TLB_shootdowns
    525.75           +17.2%     616.00 ±  2%  interrupts.CPU51.CAL:Function_call_interrupts
      3167 ±  4%     -14.3%       2713 ± 11%  interrupts.CPU51.NMI:Non-maskable_interrupts
      3167 ±  4%     -14.3%       2713 ± 11%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
    846.50 ±  4%     +34.6%       1139 ±  2%  interrupts.CPU51.RES:Rescheduling_interrupts
     80.00 ± 14%    +138.8%     191.00 ± 14%  interrupts.CPU51.TLB:TLB_shootdowns
    536.75           +15.6%     620.50 ±  5%  interrupts.CPU52.CAL:Function_call_interrupts
      3109 ±  5%     -17.3%       2571 ±  8%  interrupts.CPU52.NMI:Non-maskable_interrupts
      3109 ±  5%     -17.3%       2571 ±  8%  interrupts.CPU52.PMI:Performance_monitoring_interrupts
    853.75 ±  6%     +31.4%       1122 ±  2%  interrupts.CPU52.RES:Rescheduling_interrupts
     84.00 ±  7%    +107.1%     174.00 ± 22%  interrupts.CPU52.TLB:TLB_shootdowns
    533.25 ±  2%     +17.0%     624.00 ±  4%  interrupts.CPU53.CAL:Function_call_interrupts
      3135 ±  6%     -17.0%       2600 ±  7%  interrupts.CPU53.NMI:Non-maskable_interrupts
      3135 ±  6%     -17.0%       2600 ±  7%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
    811.75 ±  5%     +38.7%       1126 ±  4%  interrupts.CPU53.RES:Rescheduling_interrupts
     80.50 ± 13%    +114.0%     172.25 ± 15%  interrupts.CPU53.TLB:TLB_shootdowns
    529.50           +15.7%     612.75        interrupts.CPU54.CAL:Function_call_interrupts
      3120 ±  4%     -16.9%       2593 ±  7%  interrupts.CPU54.NMI:Non-maskable_interrupts
      3120 ±  4%     -16.9%       2593 ±  7%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
    846.25 ±  2%     +31.4%       1111 ±  4%  interrupts.CPU54.RES:Rescheduling_interrupts
     79.25 ±  8%    +110.1%     166.50 ± 14%  interrupts.CPU54.TLB:TLB_shootdowns
    523.75 ±  2%     +20.4%     630.75 ±  5%  interrupts.CPU55.CAL:Function_call_interrupts
      3165 ±  4%     -17.6%       2607 ±  9%  interrupts.CPU55.NMI:Non-maskable_interrupts
      3165 ±  4%     -17.6%       2607 ±  9%  interrupts.CPU55.PMI:Performance_monitoring_interrupts
    847.50 ±  5%     +35.9%       1151 ±  4%  interrupts.CPU55.RES:Rescheduling_interrupts
     78.25 ± 23%    +135.1%     184.00 ± 20%  interrupts.CPU55.TLB:TLB_shootdowns
    524.25 ±  2%     +17.5%     616.00 ±  3%  interrupts.CPU56.CAL:Function_call_interrupts
      3201 ±  4%     -28.6%       2284 ± 23%  interrupts.CPU56.NMI:Non-maskable_interrupts
      3201 ±  4%     -28.6%       2284 ± 23%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
    844.00 ±  4%     +37.4%       1160 ±  5%  interrupts.CPU56.RES:Rescheduling_interrupts
     81.75 ± 14%    +107.3%     169.50 ±  8%  interrupts.CPU56.TLB:TLB_shootdowns
    536.25           +14.9%     616.25 ±  2%  interrupts.CPU57.CAL:Function_call_interrupts
    856.25 ±  8%     +29.3%       1107 ±  2%  interrupts.CPU57.RES:Rescheduling_interrupts
     90.00 ± 10%     +93.6%     174.25 ±  6%  interrupts.CPU57.TLB:TLB_shootdowns
    523.50 ±  2%     +18.6%     621.00 ±  4%  interrupts.CPU58.CAL:Function_call_interrupts
      3172 ±  3%     -17.8%       2608 ±  7%  interrupts.CPU58.NMI:Non-maskable_interrupts
      3172 ±  3%     -17.8%       2608 ±  7%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
    812.50 ±  3%     +35.0%       1096 ±  6%  interrupts.CPU58.RES:Rescheduling_interrupts
     91.00 ± 24%     +84.9%     168.25 ± 17%  interrupts.CPU58.TLB:TLB_shootdowns
    538.00 ±  2%     +14.6%     616.50 ±  4%  interrupts.CPU59.CAL:Function_call_interrupts
      3192 ±  4%     -15.4%       2701 ±  5%  interrupts.CPU59.NMI:Non-maskable_interrupts
      3192 ±  4%     -15.4%       2701 ±  5%  interrupts.CPU59.PMI:Performance_monitoring_interrupts
    844.00 ±  3%     +31.5%       1109 ±  2%  interrupts.CPU59.RES:Rescheduling_interrupts
    531.25 ±  2%     +17.5%     624.00 ±  4%  interrupts.CPU6.CAL:Function_call_interrupts
      3290 ±  2%     -30.4%       2291 ± 23%  interrupts.CPU6.NMI:Non-maskable_interrupts
      3290 ±  2%     -30.4%       2291 ± 23%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
    853.50 ±  3%     +37.3%       1172 ±  2%  interrupts.CPU6.RES:Rescheduling_interrupts
     80.75 ± 16%    +124.1%     181.00 ± 13%  interrupts.CPU6.TLB:TLB_shootdowns
    532.50 ±  2%     +15.3%     614.00 ±  3%  interrupts.CPU60.CAL:Function_call_interrupts
      3217 ±  4%     -27.9%       2320 ± 24%  interrupts.CPU60.NMI:Non-maskable_interrupts
      3217 ±  4%     -27.9%       2320 ± 24%  interrupts.CPU60.PMI:Performance_monitoring_interrupts
    885.50 ±  4%     +26.7%       1121 ±  3%  interrupts.CPU60.RES:Rescheduling_interrupts
     83.75 ± 13%    +117.3%     182.00 ± 18%  interrupts.CPU60.TLB:TLB_shootdowns
    536.25           +13.9%     611.00 ±  3%  interrupts.CPU61.CAL:Function_call_interrupts
    815.25           +37.6%       1122 ±  2%  interrupts.CPU61.RES:Rescheduling_interrupts
     84.00 ±  9%     +94.6%     163.50 ± 16%  interrupts.CPU61.TLB:TLB_shootdowns
    534.00 ±  2%     +16.6%     622.50 ±  3%  interrupts.CPU62.CAL:Function_call_interrupts
      3205 ±  4%     -17.3%       2650 ±  7%  interrupts.CPU62.NMI:Non-maskable_interrupts
      3205 ±  4%     -17.3%       2650 ±  7%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
    829.75           +33.2%       1105 ±  3%  interrupts.CPU62.RES:Rescheduling_interrupts
    102.50 ± 23%     +71.0%     175.25 ± 18%  interrupts.CPU62.TLB:TLB_shootdowns
    539.25 ±  2%     +14.4%     616.75 ±  3%  interrupts.CPU63.CAL:Function_call_interrupts
      3200 ±  4%     -17.0%       2657 ±  6%  interrupts.CPU63.NMI:Non-maskable_interrupts
      3200 ±  4%     -17.0%       2657 ±  6%  interrupts.CPU63.PMI:Performance_monitoring_interrupts
    861.25 ±  8%     +31.9%       1136 ±  5%  interrupts.CPU63.RES:Rescheduling_interrupts
     87.75 ± 11%    +112.3%     186.25 ± 10%  interrupts.CPU63.TLB:TLB_shootdowns
    540.75           +16.2%     628.50 ±  3%  interrupts.CPU64.CAL:Function_call_interrupts
      3175 ±  5%     -16.7%       2643 ±  7%  interrupts.CPU64.NMI:Non-maskable_interrupts
      3175 ±  5%     -16.7%       2643 ±  7%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
    816.00 ±  4%     +33.6%       1090 ±  3%  interrupts.CPU64.RES:Rescheduling_interrupts
     88.25 ±  6%     +97.2%     174.00 ± 11%  interrupts.CPU64.TLB:TLB_shootdowns
    534.00 ±  2%     +18.3%     631.75 ±  4%  interrupts.CPU65.CAL:Function_call_interrupts
    820.75 ±  3%     +40.9%       1156 ±  6%  interrupts.CPU65.RES:Rescheduling_interrupts
     82.25 ± 17%    +107.6%     170.75 ± 14%  interrupts.CPU65.TLB:TLB_shootdowns
    531.75           +18.8%     631.50 ±  3%  interrupts.CPU66.CAL:Function_call_interrupts
    929.50 ±  6%     +20.2%       1117 ±  3%  interrupts.CPU66.RES:Rescheduling_interrupts
     85.50 ± 10%    +121.3%     189.25 ± 12%  interrupts.CPU66.TLB:TLB_shootdowns
    846.75           +35.4%       1146 ±  3%  interrupts.CPU67.RES:Rescheduling_interrupts
     85.25 ± 14%    +107.6%     177.00 ±  5%  interrupts.CPU67.TLB:TLB_shootdowns
    529.50           +20.1%     635.75 ±  2%  interrupts.CPU68.CAL:Function_call_interrupts
    842.75 ±  4%     +39.0%       1171 ±  6%  interrupts.CPU68.RES:Rescheduling_interrupts
     88.50 ± 13%    +128.5%     202.25 ± 15%  interrupts.CPU68.TLB:TLB_shootdowns
    902.00 ± 12%     +23.3%       1112 ±  4%  interrupts.CPU69.RES:Rescheduling_interrupts
     86.75 ± 10%    +107.5%     180.00 ± 18%  interrupts.CPU69.TLB:TLB_shootdowns
    544.50           +12.2%     610.75 ±  2%  interrupts.CPU7.CAL:Function_call_interrupts
      3169 ±  4%     -27.0%       2313 ± 25%  interrupts.CPU7.NMI:Non-maskable_interrupts
      3169 ±  4%     -27.0%       2313 ± 25%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
    104.00 ± 20%     +69.7%     176.50 ±  8%  interrupts.CPU7.TLB:TLB_shootdowns
    535.75           +17.9%     631.50 ±  3%  interrupts.CPU70.CAL:Function_call_interrupts
      3159 ±  5%     -16.5%       2638 ±  8%  interrupts.CPU70.NMI:Non-maskable_interrupts
      3159 ±  5%     -16.5%       2638 ±  8%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
    843.75 ±  4%     +36.1%       1148 ±  5%  interrupts.CPU70.RES:Rescheduling_interrupts
     91.75 ± 18%    +103.3%     186.50 ±  8%  interrupts.CPU70.TLB:TLB_shootdowns
    527.50 ±  2%     +17.0%     617.25 ±  3%  interrupts.CPU71.CAL:Function_call_interrupts
    840.75 ±  4%     +40.5%       1181 ±  9%  interrupts.CPU71.RES:Rescheduling_interrupts
     76.00 ± 12%    +137.8%     180.75 ± 16%  interrupts.CPU71.TLB:TLB_shootdowns
    536.00 ±  2%     +16.4%     624.00 ±  3%  interrupts.CPU72.CAL:Function_call_interrupts
    835.00 ±  6%     +40.0%       1169 ±  6%  interrupts.CPU72.RES:Rescheduling_interrupts
     90.25 ± 15%     +94.5%     175.50 ±  9%  interrupts.CPU72.TLB:TLB_shootdowns
    534.50 ±  2%     +15.9%     619.25 ±  2%  interrupts.CPU73.CAL:Function_call_interrupts
      3250 ±  6%     -18.3%       2655 ±  6%  interrupts.CPU73.NMI:Non-maskable_interrupts
      3250 ±  6%     -18.3%       2655 ±  6%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
    839.50 ±  7%     +33.2%       1118 ±  2%  interrupts.CPU73.RES:Rescheduling_interrupts
     72.50 ± 17%    +135.5%     170.75 ± 18%  interrupts.CPU73.TLB:TLB_shootdowns
    543.00           +14.1%     619.50 ±  2%  interrupts.CPU74.CAL:Function_call_interrupts
    859.00 ±  5%     +27.5%       1095 ±  2%  interrupts.CPU74.RES:Rescheduling_interrupts
     91.75 ± 20%     +80.1%     165.25 ± 24%  interrupts.CPU74.TLB:TLB_shootdowns
    547.25 ±  3%     +16.8%     639.00 ±  3%  interrupts.CPU75.CAL:Function_call_interrupts
      3174 ±  5%     -17.6%       2615 ±  8%  interrupts.CPU75.NMI:Non-maskable_interrupts
      3174 ±  5%     -17.6%       2615 ±  8%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
    825.75           +43.4%       1184 ±  3%  interrupts.CPU75.RES:Rescheduling_interrupts
     81.50 ± 11%    +135.0%     191.50 ±  9%  interrupts.CPU75.TLB:TLB_shootdowns
    546.00 ±  2%     +17.4%     641.00 ±  4%  interrupts.CPU76.CAL:Function_call_interrupts
      3135 ±  4%     -15.4%       2652 ±  8%  interrupts.CPU76.NMI:Non-maskable_interrupts
      3135 ±  4%     -15.4%       2652 ±  8%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
    834.75 ±  6%     +40.3%       1171 ±  4%  interrupts.CPU76.RES:Rescheduling_interrupts
     74.50 ±  6%    +178.9%     207.75 ± 22%  interrupts.CPU76.TLB:TLB_shootdowns
    563.25           +11.3%     626.75 ±  4%  interrupts.CPU77.CAL:Function_call_interrupts
    834.25 ±  4%     +32.4%       1104 ±  3%  interrupts.CPU77.RES:Rescheduling_interrupts
     93.50 ±  7%    +102.1%     189.00 ± 11%  interrupts.CPU77.TLB:TLB_shootdowns
    558.50 ±  2%     +13.7%     635.00 ±  4%  interrupts.CPU78.CAL:Function_call_interrupts
      3162 ±  4%     -25.8%       2345 ± 23%  interrupts.CPU78.NMI:Non-maskable_interrupts
      3162 ±  4%     -25.8%       2345 ± 23%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
    865.00 ±  4%     +37.0%       1185 ±  7%  interrupts.CPU78.RES:Rescheduling_interrupts
     84.25 ± 18%    +112.8%     179.25 ± 19%  interrupts.CPU78.TLB:TLB_shootdowns
    559.50           +13.4%     634.25 ±  3%  interrupts.CPU79.CAL:Function_call_interrupts
    850.75 ±  2%     +28.6%       1094 ±  5%  interrupts.CPU79.RES:Rescheduling_interrupts
     94.25 ± 12%    +111.7%     199.50 ± 16%  interrupts.CPU79.TLB:TLB_shootdowns
    535.00           +15.6%     618.50 ±  3%  interrupts.CPU8.CAL:Function_call_interrupts
      3147 ±  5%     -38.7%       1929 ± 29%  interrupts.CPU8.NMI:Non-maskable_interrupts
      3147 ±  5%     -38.7%       1929 ± 29%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
    891.25 ±  3%     +25.6%       1119        interrupts.CPU8.RES:Rescheduling_interrupts
    102.50 ± 22%     +85.9%     190.50 ± 15%  interrupts.CPU8.TLB:TLB_shootdowns
      3189 ±  3%     -15.4%       2698 ±  7%  interrupts.CPU80.NMI:Non-maskable_interrupts
      3189 ±  3%     -15.4%       2698 ±  7%  interrupts.CPU80.PMI:Performance_monitoring_interrupts
    838.75 ±  2%     +33.0%       1115 ±  2%  interrupts.CPU80.RES:Rescheduling_interrupts
     80.75 ± 19%    +113.9%     172.75 ± 10%  interrupts.CPU80.TLB:TLB_shootdowns
    554.50           +15.6%     641.00 ±  4%  interrupts.CPU81.CAL:Function_call_interrupts
    824.50 ±  3%     +34.9%       1112 ±  2%  interrupts.CPU81.RES:Rescheduling_interrupts
     84.25 ± 14%     +94.1%     163.50 ± 21%  interrupts.CPU81.TLB:TLB_shootdowns
    554.50 ±  2%     +14.2%     633.25 ±  2%  interrupts.CPU82.CAL:Function_call_interrupts
    861.00 ±  3%     +33.6%       1150 ±  3%  interrupts.CPU82.RES:Rescheduling_interrupts
     81.75 ± 11%    +109.8%     171.50 ± 13%  interrupts.CPU82.TLB:TLB_shootdowns
    559.75           +15.1%     644.50 ±  3%  interrupts.CPU83.CAL:Function_call_interrupts
    858.50 ±  5%     +31.3%       1127 ±  4%  interrupts.CPU83.RES:Rescheduling_interrupts
     99.50 ± 36%     +87.4%     186.50 ± 17%  interrupts.CPU83.TLB:TLB_shootdowns
    551.75           +18.1%     651.50 ±  3%  interrupts.CPU84.CAL:Function_call_interrupts
    884.75 ±  6%     +28.6%       1137 ±  3%  interrupts.CPU84.RES:Rescheduling_interrupts
     98.50 ± 18%     +88.6%     185.75 ± 14%  interrupts.CPU84.TLB:TLB_shootdowns
    556.75 ±  2%     +15.6%     643.50 ±  2%  interrupts.CPU85.CAL:Function_call_interrupts
    831.00 ±  5%     +34.1%       1114 ±  2%  interrupts.CPU85.RES:Rescheduling_interrupts
     89.00 ± 30%    +108.7%     185.75 ±  6%  interrupts.CPU85.TLB:TLB_shootdowns
    555.75           +14.5%     636.25 ±  3%  interrupts.CPU86.CAL:Function_call_interrupts
    838.75 ±  4%     +31.9%       1106 ±  3%  interrupts.CPU86.RES:Rescheduling_interrupts
     80.00 ±  8%    +140.9%     192.75 ± 18%  interrupts.CPU86.TLB:TLB_shootdowns
    553.25 ±  2%     +13.6%     628.50 ±  5%  interrupts.CPU87.CAL:Function_call_interrupts
      3189 ±  4%     -24.3%       2413 ± 27%  interrupts.CPU87.NMI:Non-maskable_interrupts
      3189 ±  4%     -24.3%       2413 ± 27%  interrupts.CPU87.PMI:Performance_monitoring_interrupts
    927.00 ±  4%     +24.0%       1149 ±  2%  interrupts.CPU87.RES:Rescheduling_interrupts
    104.75 ± 16%     +72.6%     180.75 ± 20%  interrupts.CPU87.TLB:TLB_shootdowns
    528.50 ±  2%     +17.9%     623.00 ±  4%  interrupts.CPU9.CAL:Function_call_interrupts
      3144 ±  5%     -38.6%       1929 ± 27%  interrupts.CPU9.NMI:Non-maskable_interrupts
      3144 ±  5%     -38.6%       1929 ± 27%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
    834.00 ±  2%     +36.5%       1138 ±  4%  interrupts.CPU9.RES:Rescheduling_interrupts
    257373 ±  5%     -14.2%     220795 ±  6%  interrupts.NMI:Non-maskable_interrupts
    257373 ±  5%     -14.2%     220795 ±  6%  interrupts.PMI:Performance_monitoring_interrupts
     78020           +31.8%     102837        interrupts.RES:Rescheduling_interrupts
      7822 ±  5%    +105.5%      16071 ± 11%  interrupts.TLB:TLB_shootdowns
     55.27 ±  3%     -55.3        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.scan_positives.dcache_readdir.iterate_dir
     57.41 ±  3%     -42.3       15.07 ±  4%  perf-profile.calltrace.cycles-pp.dcache_readdir.iterate_dir.__x64_sys_getdents.do_syscall_64.entry_SYSCALL_64_after_hwframe
     57.44 ±  3%     -42.3       15.11 ±  4%  perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents.do_syscall_64.entry_SYSCALL_64_after_hwframe
     57.44 ±  3%     -42.3       15.11 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_getdents.do_syscall_64.entry_SYSCALL_64_after_hwframe
     56.40 ±  3%     -42.1       14.27 ±  4%  perf-profile.calltrace.cycles-pp.scan_positives.dcache_readdir.iterate_dir.__x64_sys_getdents.do_syscall_64
     55.92 ±  3%     -42.0       13.92 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock.scan_positives.dcache_readdir.iterate_dir.__x64_sys_getdents
     60.88 ±  3%     -35.2       25.67 ± 16%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     60.88 ±  3%     -35.2       25.69 ± 16%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.81            -0.5        0.28 ±100%  perf-profile.calltrace.cycles-pp._raw_spin_lock.dcache_readdir.iterate_dir.__x64_sys_getdents.do_syscall_64
      0.63 ±  4%      +0.3        0.97 ±  6%  perf-profile.calltrace.cycles-pp.swapgs_restore_regs_and_return_to_usermode
      0.75 ±  5%      +0.4        1.12 ±  4%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat
      0.83 ±  6%      +0.4        1.23 ±  4%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat
      0.91 ±  6%      +0.4        1.35 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat
      0.92 ±  6%      +0.4        1.36 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat
      0.99 ±  6%      +0.5        1.45 ±  4%  perf-profile.calltrace.cycles-pp.creat
      0.68 ±  5%      +0.5        1.16 ±  8%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.do_exit.do_group_exit.__x64_sys_exit_group
      0.27 ±100%      +0.5        0.75 ±  7%  perf-profile.calltrace.cycles-pp.release_pages.tlb_flush_mmu.tlb_finish_mmu.unmap_region.__do_munmap
      0.69 ±  4%      +0.5        1.17 ±  8%  perf-profile.calltrace.cycles-pp.mmput.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.13 ±173%      +0.5        0.63 ± 24%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry
      0.74 ± 14%      +0.5        1.25 ± 13%  perf-profile.calltrace.cycles-pp.tlb_flush_mmu.tlb_finish_mmu.unmap_region.__do_munmap.__x64_sys_brk
      0.75 ± 13%      +0.5        1.27 ± 13%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.unmap_region.__do_munmap.__x64_sys_brk.do_syscall_64
      0.25 ±100%      +0.5        0.78 ±  5%  perf-profile.calltrace.cycles-pp.setlocale
      0.00            +0.6        0.55 ±  6%  perf-profile.calltrace.cycles-pp.__alloc_pages_nodemask.alloc_pages_vma.handle_pte_fault.__handle_mm_fault.handle_mm_fault
      1.04 ± 17%      +0.6        1.60 ± 17%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      0.00            +0.6        0.60 ±  6%  perf-profile.calltrace.cycles-pp.alloc_pages_vma.handle_pte_fault.__handle_mm_fault.handle_mm_fault.__do_page_fault
      1.21 ± 14%      +0.6        1.82 ±  6%  perf-profile.calltrace.cycles-pp.__do_munmap.__x64_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.94 ±  3%      +0.6        1.55 ±  8%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.94 ±  3%      +0.6        1.55 ±  8%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.94 ±  3%      +0.6        1.55 ±  8%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.17 ±173%      +0.6        0.78 ± 22%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry.start_secondary
      0.41 ± 58%      +0.6        1.03 ± 27%  perf-profile.calltrace.cycles-pp.flush_old_exec.load_elf_binary.search_binary_handler.__do_execve_file.__x64_sys_execve
      1.48 ± 10%      +0.6        2.11 ±  5%  perf-profile.calltrace.cycles-pp.__strcat_chk
      1.31 ± 14%      +0.6        1.96 ±  6%  perf-profile.calltrace.cycles-pp.__x64_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.00            +0.7        0.65 ±  8%  perf-profile.calltrace.cycles-pp.filemap_map_pages.handle_pte_fault.__handle_mm_fault.handle_mm_fault.__do_page_fault
      0.00            +0.7        0.65 ±  9%  perf-profile.calltrace.cycles-pp.__libc_fork
      0.00            +0.7        0.69 ±  5%  perf-profile.calltrace.cycles-pp.prepare_exit_to_usermode.swapgs_restore_regs_and_return_to_usermode
      1.44 ± 14%      +0.7        2.17 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      1.46 ± 14%      +0.7        2.18 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.brk
      0.27 ±100%      +0.7        0.99 ± 28%  perf-profile.calltrace.cycles-pp.mmput.flush_old_exec.load_elf_binary.search_binary_handler.__do_execve_file
      0.26 ±100%      +0.7        0.98 ± 28%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.flush_old_exec.load_elf_binary.search_binary_handler
      1.57 ± 14%      +0.8        2.34 ±  7%  perf-profile.calltrace.cycles-pp.brk
      0.12 ±173%      +0.8        0.96 ± 27%  perf-profile.calltrace.cycles-pp.__x64_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.12 ±173%      +0.8        0.96 ± 27%  perf-profile.calltrace.cycles-pp._do_fork.__x64_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.07 ±  6%      +0.8        1.91 ± 17%  perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.__do_execve_file.__x64_sys_execve.do_syscall_64
      1.07 ±  5%      +0.8        1.92 ± 17%  perf-profile.calltrace.cycles-pp.search_binary_handler.__do_execve_file.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.9        0.85 ± 30%  perf-profile.calltrace.cycles-pp.copy_process._do_fork.__x64_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.48 ±  4%      +0.9        2.35 ±  7%  perf-profile.calltrace.cycles-pp.handle_pte_fault.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault
      0.00            +0.9        0.92 ±  7%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.dcache_dir_lseek.ksys_lseek.do_syscall_64
      1.59 ±  4%      +0.9        2.50 ±  7%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page_fault.page_fault
      0.00            +0.9        0.92 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock.dcache_dir_lseek.ksys_lseek.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.9        0.93 ±  7%  perf-profile.calltrace.cycles-pp.dcache_dir_lseek.ksys_lseek.do_syscall_64.entry_SYSCALL_64_after_hwframe.lseek64
      0.00            +0.9        0.93 ±  7%  perf-profile.calltrace.cycles-pp.ksys_lseek.do_syscall_64.entry_SYSCALL_64_after_hwframe.lseek64
      0.99 ± 13%      +0.9        1.92 ± 11%  perf-profile.calltrace.cycles-pp.unmap_region.__do_munmap.__x64_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.9        0.95 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.lseek64
      0.00            +0.9        0.95 ±  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.lseek64
      1.67 ±  4%      +1.0        2.62 ±  7%  perf-profile.calltrace.cycles-pp.handle_mm_fault.__do_page_fault.do_page_fault.page_fault
      0.00            +1.0        0.97 ±  7%  perf-profile.calltrace.cycles-pp.lseek64
      2.26 ± 13%      +1.1        3.35 ± 24%  perf-profile.calltrace.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      1.91 ±  4%      +1.1        3.01 ±  7%  perf-profile.calltrace.cycles-pp.__do_page_fault.do_page_fault.page_fault
      1.97 ±  4%      +1.1        3.11 ±  7%  perf-profile.calltrace.cycles-pp.do_page_fault.page_fault
      2.02 ±  4%      +1.2        3.19 ±  7%  perf-profile.calltrace.cycles-pp.page_fault
      2.44 ± 11%      +1.2        3.62 ± 21%  perf-profile.calltrace.cycles-pp.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      2.63 ±  9%      +1.2        3.84 ±  7%  perf-profile.calltrace.cycles-pp.__strncat_chk
      0.00            +4.1        4.11 ± 18%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.opendir
      0.00            +4.1        4.11 ± 18%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.opendir
      0.00            +4.1        4.11 ± 18%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.opendir
      0.00            +4.1        4.11 ± 18%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.opendir
      0.00            +4.1        4.11 ± 18%  perf-profile.calltrace.cycles-pp.opendir
      0.00            +4.8        4.83 ± 13%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.legitimize_path.unlazy_walk.complete_walk
      0.00            +4.8        4.83 ± 13%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.legitimize_path.unlazy_walk.complete_walk.path_openat
      0.00            +4.8        4.83 ± 13%  perf-profile.calltrace.cycles-pp.unlazy_walk.complete_walk.path_openat.do_filp_open.do_sys_open
      0.00            +4.8        4.83 ± 13%  perf-profile.calltrace.cycles-pp.legitimize_path.unlazy_walk.complete_walk.path_openat.do_filp_open
      0.00            +4.8        4.84 ± 13%  perf-profile.calltrace.cycles-pp.complete_walk.path_openat.do_filp_open.do_sys_open.do_syscall_64
      0.75 ±  5%      +5.9        6.62 ±  9%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.77            +8.9       25.71 ± 10%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     19.79 ±  5%     +10.7       30.51 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     19.95 ±  5%     +10.8       30.74 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      1.62 ±  5%     +11.1       12.68 ± 15%  perf-profile.calltrace.cycles-pp.__do_execve_file.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      1.65 ±  5%     +11.1       12.70 ± 15%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      1.65 ±  5%     +11.1       12.70 ± 15%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      1.65 ±  5%     +11.1       12.70 ± 15%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      1.67 ±  5%     +11.1       12.73 ± 15%  perf-profile.calltrace.cycles-pp.execve
     21.40 ±  6%     +11.6       32.97 ±  6%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     21.42 ±  6%     +11.6       32.99 ±  6%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
     21.42 ±  6%     +11.6       32.99 ±  6%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
     21.66 ±  6%     +11.7       33.35 ±  6%  perf-profile.calltrace.cycles-pp.secondary_startup_64
      0.00           +12.6       12.62 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.legitimize_path.unlazy_walk.trailing_symlink
      0.00           +12.6       12.62 ±  4%  perf-profile.calltrace.cycles-pp.unlazy_walk.trailing_symlink.path_openat.do_filp_open.do_open_execat
      0.00           +12.6       12.62 ±  4%  perf-profile.calltrace.cycles-pp.legitimize_path.unlazy_walk.trailing_symlink.path_openat.do_filp_open
      0.00           +12.6       12.62 ±  4%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.legitimize_path.unlazy_walk.trailing_symlink.path_openat
      0.00           +12.6       12.62 ±  4%  perf-profile.calltrace.cycles-pp.trailing_symlink.path_openat.do_filp_open.do_open_execat.__do_execve_file
      0.00           +12.9       12.90 ±  4%  perf-profile.calltrace.cycles-pp.do_filp_open.do_open_execat.__do_execve_file.__x64_sys_execve.do_syscall_64
      0.00           +12.9       12.90 ±  4%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_open_execat.__do_execve_file.__x64_sys_execve
      0.00           +12.9       12.91 ±  4%  perf-profile.calltrace.cycles-pp.do_open_execat.__do_execve_file.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +13.2       13.17 ±  4%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.scan_positives.dcache_readdir.iterate_dir
      0.00           +17.4       17.43 ±  5%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.lockref_get_not_dead.legitimize_path.unlazy_walk
     57.19 ±  3%     -57.2        0.00        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     57.41 ±  3%     -42.3       15.07 ±  4%  perf-profile.children.cycles-pp.dcache_readdir
     57.44 ±  3%     -42.3       15.11 ±  4%  perf-profile.children.cycles-pp.iterate_dir
     57.44 ±  3%     -42.3       15.11 ±  4%  perf-profile.children.cycles-pp.__x64_sys_getdents
     56.41 ±  3%     -42.1       14.28 ±  4%  perf-profile.children.cycles-pp.scan_positives
     57.69 ±  3%     -23.6       34.10 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock
     68.15 ±  2%     -16.9       51.29 ±  3%  perf-profile.children.cycles-pp.do_syscall_64
     68.19 ±  2%     -16.8       51.35 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.05 ±  8%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.do_task_dead
      0.06 ±  6%      +0.0        0.08 ± 13%  perf-profile.children.cycles-pp.native_apic_msr_eoi_write
      0.06 ± 11%      +0.0        0.08 ± 10%  perf-profile.children.cycles-pp.memcpy
      0.05 ±  9%      +0.0        0.08 ± 10%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      0.07            +0.0        0.10 ±  9%  perf-profile.children.cycles-pp.generic_file_write_iter
      0.06 ±  6%      +0.0        0.09 ± 12%  perf-profile.children.cycles-pp.net_rx_action
      0.06            +0.0        0.08 ± 10%  perf-profile.children.cycles-pp.generic_perform_write
      0.05 ±  8%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.update_ts_time_stats
      0.05            +0.0        0.07 ± 11%  perf-profile.children.cycles-pp.__netif_receive_skb_one_core
      0.06 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.strlen
      0.05 ±  8%      +0.0        0.08 ± 10%  perf-profile.children.cycles-pp.___slab_alloc
      0.06 ±  9%      +0.0        0.08 ±  8%  perf-profile.children.cycles-pp.__slab_alloc
      0.07 ±  6%      +0.0        0.10 ±  9%  perf-profile.children.cycles-pp.ip_send_skb
      0.06 ±  6%      +0.0        0.09 ± 13%  perf-profile.children.cycles-pp.__generic_file_write_iter
      0.07 ±  6%      +0.0        0.10 ± 11%  perf-profile.children.cycles-pp.unlock_page
      0.07 ±  7%      +0.0        0.09 ± 14%  perf-profile.children.cycles-pp.__waitpid
      0.06 ±  7%      +0.0        0.09 ± 10%  perf-profile.children.cycles-pp.get_user_arg_ptr
      0.06 ±  7%      +0.0        0.09 ± 10%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.05 ±  8%      +0.0        0.08 ± 13%  perf-profile.children.cycles-pp.__dentry_kill
      0.04 ± 57%      +0.0        0.07 ± 12%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.04 ± 58%      +0.0        0.07 ± 10%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.07 ± 15%      +0.0        0.11 ± 17%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.06 ±  6%      +0.0        0.10 ± 11%  perf-profile.children.cycles-pp.__might_fault
      0.06 ±  6%      +0.0        0.10 ±  9%  perf-profile.children.cycles-pp.do_softirq_own_stack
      0.07            +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.do_brk_flags
      0.06 ±  7%      +0.0        0.09 ± 17%  perf-profile.children.cycles-pp.link
      0.08 ± 10%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.__x64_sys_rt_sigreturn
      0.07 ±  6%      +0.0        0.10 ± 12%  perf-profile.children.cycles-pp.udp_send_skb
      0.07 ± 10%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.vfprintf
      0.07 ±  7%      +0.0        0.10 ± 12%  perf-profile.children.cycles-pp.do_softirq
      0.05 ±  9%      +0.0        0.09 ± 13%  perf-profile.children.cycles-pp.copy_strings_kernel
      0.07 ±  7%      +0.0        0.10 ± 12%  perf-profile.children.cycles-pp.vmacache_find
      0.06 ± 14%      +0.0        0.09 ±  8%  perf-profile.children.cycles-pp.copy_user_generic_unrolled
      0.05 ±  9%      +0.0        0.09 ± 13%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.06 ±  7%      +0.0        0.09 ± 20%  perf-profile.children.cycles-pp.setup_arg_pages
      0.07 ±  5%      +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.time
      0.07 ± 10%      +0.0        0.11 ± 10%  perf-profile.children.cycles-pp.__local_bh_enable_ip
      0.07 ±  5%      +0.0        0.11 ±  6%  perf-profile.children.cycles-pp._copy_from_user
      0.08 ±  8%      +0.0        0.12 ±  7%  perf-profile.children.cycles-pp.__fxstat64
      0.07 ± 12%      +0.0        0.10 ± 10%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.06 ± 15%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      0.09 ± 11%      +0.0        0.13 ± 12%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.10 ±  8%      +0.0        0.14 ± 15%  perf-profile.children.cycles-pp.free
      0.07 ±  7%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.06 ±  6%      +0.0        0.10 ±  7%  perf-profile.children.cycles-pp.mem_cgroup_try_charge
      0.12 ± 19%      +0.0        0.16 ± 16%  perf-profile.children.cycles-pp.io_serial_in
      0.06 ± 14%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.activate_task
      0.04 ± 58%      +0.0        0.08        perf-profile.children.cycles-pp.do_send_sig_info
      0.08 ±  5%      +0.0        0.12 ± 13%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.09 ±  7%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.newidle_balance
      0.09 ± 12%      +0.0        0.13 ±  6%  perf-profile.children.cycles-pp.update_load_avg
      0.06 ±  7%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.change_protection
      0.06 ±  6%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.vm_area_dup
      0.07 ±  7%      +0.0        0.11 ± 10%  perf-profile.children.cycles-pp.notify_change
      0.10 ± 14%      +0.0        0.15 ± 10%  perf-profile.children.cycles-pp.__libc_calloc
      0.07 ±  7%      +0.0        0.11 ± 16%  perf-profile.children.cycles-pp.follow_managed
      0.05 ±  8%      +0.0        0.10 ± 11%  perf-profile.children.cycles-pp.__x64_sys_link
      0.05 ±  8%      +0.0        0.10 ± 11%  perf-profile.children.cycles-pp.do_linkat
      0.03 ±100%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__d_alloc
      0.10 ±  8%      +0.0        0.15 ±  7%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.06 ±  7%      +0.0        0.10 ±  7%  perf-profile.children.cycles-pp.rcu_all_qs
      0.07 ± 10%      +0.0        0.11 ± 13%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.07 ± 16%      +0.0        0.11 ±  7%  perf-profile.children.cycles-pp.update_cfs_group
      0.07 ±  6%      +0.0        0.11 ± 13%  perf-profile.children.cycles-pp.do_notify_parent
      0.07 ±  5%      +0.0        0.12 ±  7%  perf-profile.children.cycles-pp.d_alloc
      0.06 ±  6%      +0.0        0.11 ± 10%  perf-profile.children.cycles-pp.down_read
      0.04 ± 57%      +0.0        0.08 ± 10%  perf-profile.children.cycles-pp.__tcp_transmit_skb
      0.09 ±  5%      +0.0        0.13 ± 13%  perf-profile.children.cycles-pp.security_file_permission
      0.08 ± 15%      +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.get_user_pages_remote
      0.08 ± 10%      +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.__get_user_pages
      0.05 ±  8%      +0.0        0.10 ± 11%  perf-profile.children.cycles-pp.sock_read_iter
      0.03 ±100%      +0.0        0.07 ± 10%  perf-profile.children.cycles-pp.call_rcu
      0.08 ± 19%      +0.0        0.12 ± 16%  perf-profile.children.cycles-pp.native_sched_clock
      0.07 ±  6%      +0.0        0.11 ± 14%  perf-profile.children.cycles-pp.security_task_kill
      0.08 ± 11%      +0.0        0.12 ± 12%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
      0.08 ±  6%      +0.0        0.12 ± 12%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.04 ± 60%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.enqueue_entity
      0.08 ± 30%      +0.0        0.13 ± 14%  perf-profile.children.cycles-pp.irq_work_run_list
      0.07 ±  7%      +0.0        0.11 ± 18%  perf-profile.children.cycles-pp.apparmor_task_kill
      0.08 ±  5%      +0.0        0.13 ± 10%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.01 ±173%      +0.0        0.06 ± 11%  perf-profile.children.cycles-pp.up_read
      0.03 ±100%      +0.0        0.07 ± 11%  perf-profile.children.cycles-pp.__ip_queue_xmit
      0.10 ±  4%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.mem_cgroup_try_charge_delay
      0.08 ±  5%      +0.0        0.13 ±  6%  perf-profile.children.cycles-pp.__check_object_size
      0.08 ± 19%      +0.0        0.13 ± 18%  perf-profile.children.cycles-pp.sched_clock
      0.07 ±  5%      +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.__send_signal
      0.07 ±  5%      +0.0        0.12 ± 12%  perf-profile.children.cycles-pp.security_file_free
      0.07 ± 10%      +0.0        0.12 ±  5%  perf-profile.children.cycles-pp.__pte_alloc
      0.08 ±  5%      +0.1        0.13 ±  6%  perf-profile.children.cycles-pp.page_add_file_rmap
      0.06 ± 14%      +0.1        0.11 ± 10%  perf-profile.children.cycles-pp.__get_free_pages
      0.03 ±100%      +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.ptep_clear_flush
      0.01 ±173%      +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.__x64_sys_rt_sigaction
      0.01 ±173%      +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__do_sys_newfstat
      0.01 ±173%      +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.user_path_at_empty
      0.01 ±173%      +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.__strcasecmp
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__fpu__restore_sig
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.dequeue_entity
      0.03 ±100%      +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.__vma_link_rb
      0.07 ±  6%      +0.1        0.12 ± 15%  perf-profile.children.cycles-pp.group_send_sig_info
      0.03 ±100%      +0.1        0.08 ± 14%  perf-profile.children.cycles-pp.mm_init
      0.08            +0.1        0.13 ± 13%  perf-profile.children.cycles-pp.sched_exec
      0.01 ±173%      +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.perf_event_mmap_output
      0.01 ±173%      +0.1        0.07 ± 13%  perf-profile.children.cycles-pp.__list_add_valid
      0.01 ±173%      +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.shmem_setattr
      0.01 ±173%      +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.sched_move_task
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.finish_task_switch
      0.18 ±  9%      +0.1        0.24 ±  4%  perf-profile.children.cycles-pp.task_tick_fair
      0.09 ±  7%      +0.1        0.14 ± 14%  perf-profile.children.cycles-pp.ip_finish_output2
      0.00            +0.1        0.05 ±  9%  perf-profile.children.cycles-pp.free_pgd_range
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.fsnotify
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.open_exec
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.new_slab
      0.08 ±  5%      +0.1        0.13 ± 14%  perf-profile.children.cycles-pp.aa_file_perm
      0.01 ±173%      +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.copy_fpstate_to_sigframe
      0.00            +0.1        0.06 ± 15%  perf-profile.children.cycles-pp.mnt_want_write
      0.01 ±173%      +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.put_cred_rcu
      0.11 ±  4%      +0.1        0.17 ±  7%  perf-profile.children.cycles-pp.udp_sendmsg
      0.08 ±  5%      +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.remove_vma
      0.03 ±100%      +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.inet_recvmsg
      0.14 ±  3%      +0.1        0.19 ± 14%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.10 ± 15%      +0.1        0.15 ± 19%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.11 ±  4%      +0.1        0.16 ± 11%  perf-profile.children.cycles-pp.ip_output
      0.10 ±  4%      +0.1        0.15 ± 11%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.08 ±  6%      +0.1        0.13 ± 14%  perf-profile.children.cycles-pp.copy_page
      0.07 ±  5%      +0.1        0.13 ±  7%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.01 ±173%      +0.1        0.07 ± 31%  perf-profile.children.cycles-pp.rcu_idle_exit
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.memchr
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.fput_many
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp._IO_file_open
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.pagecache_get_page
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.03 ±100%      +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.schedule_idle
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.dentry_needs_remove_privs
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.uncharge_batch
      0.08 ± 10%      +0.1        0.14 ± 13%  perf-profile.children.cycles-pp.copy_user_highpage
      0.01 ±173%      +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.__x64_sys_close
      0.15 ±  5%      +0.1        0.21 ± 14%  perf-profile.children.cycles-pp.native_write_msr
      0.07 ±  7%      +0.1        0.12 ± 17%  perf-profile.children.cycles-pp.aa_get_task_label
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.__pmd_alloc
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.simple_lookup
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.ip_local_deliver
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.release_task
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.__wake_up_common_lock
      0.10 ± 10%      +0.1        0.17 ±  9%  perf-profile.children.cycles-pp.wake_up_new_task
      0.08 ±  5%      +0.1        0.14 ± 18%  perf-profile.children.cycles-pp.apparmor_file_open
      0.12 ± 13%      +0.1        0.18 ± 10%  perf-profile.children.cycles-pp.unlink
      0.10 ±  7%      +0.1        0.16 ±  7%  perf-profile.children.cycles-pp.schedule
      0.10            +0.1        0.16 ±  9%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.08 ±  5%      +0.1        0.15 ±  7%  perf-profile.children.cycles-pp.up_write
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.count
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.signal_wake_up_state
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.ip_make_skb
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__put_user_4
      0.01 ±173%      +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.wait_consider_task
      0.12 ±  8%      +0.1        0.19 ± 13%  perf-profile.children.cycles-pp.read_tsc
      0.19 ±  3%      +0.1        0.26 ± 10%  perf-profile.children.cycles-pp.tick_irq_enter
      0.10 ±  5%      +0.1        0.16 ± 15%  perf-profile.children.cycles-pp.__clear_user
      0.10 ± 11%      +0.1        0.16 ±  4%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.09            +0.1        0.15 ±  7%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.08 ± 10%      +0.1        0.15 ±  7%  perf-profile.children.cycles-pp.wait4
      0.08 ±  5%      +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.try_to_wake_up
      0.06 ±  9%      +0.1        0.12 ± 27%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.06 ±  9%      +0.1        0.12 ± 33%  perf-profile.children.cycles-pp.terminate_walk
      0.01 ±173%      +0.1        0.08 ± 12%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.00            +0.1        0.07 ± 13%  perf-profile.children.cycles-pp.tcp_sendmsg
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.find_get_entry
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.get_signal
      0.00            +0.1        0.07 ± 13%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.09 ±  4%      +0.1        0.15 ± 19%  perf-profile.children.cycles-pp.security_file_open
      0.11 ±  4%      +0.1        0.17 ±  9%  perf-profile.children.cycles-pp.do_faccessat
      0.12 ±  6%      +0.1        0.19 ±  9%  perf-profile.children.cycles-pp.strnlen_user
      0.11 ±  3%      +0.1        0.18 ± 13%  perf-profile.children.cycles-pp.common_file_perm
      0.12 ±  3%      +0.1        0.19 ±  5%  perf-profile.children.cycles-pp.__might_sleep
      0.11 ±  4%      +0.1        0.18 ±  8%  perf-profile.children.cycles-pp.___perf_sw_event
      0.00            +0.1        0.07 ± 16%  perf-profile.children.cycles-pp.prepare_binprm
      0.00            +0.1        0.07 ± 16%  perf-profile.children.cycles-pp.pgd_alloc
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.sync_regs
      0.14 ±  8%      +0.1        0.21 ± 10%  perf-profile.children.cycles-pp.find_next_bit
      0.10 ±  4%      +0.1        0.17 ±  8%  perf-profile.children.cycles-pp.strncpy_from_user
      0.10 ±  7%      +0.1        0.17 ±  7%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.08 ±  5%      +0.1        0.15 ±  7%  perf-profile.children.cycles-pp.free_unref_page_list
      0.17 ± 10%      +0.1        0.24 ±  6%  perf-profile.children.cycles-pp.read
      0.00            +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.security_mmap_file
      0.10 ±  5%      +0.1        0.17 ±  7%  perf-profile.children.cycles-pp.pte_alloc_one
      0.11 ±  4%      +0.1        0.19 ±  6%  perf-profile.children.cycles-pp._cond_resched
      0.11 ± 11%      +0.1        0.18 ±  8%  perf-profile.children.cycles-pp.do_truncate
      0.07 ±  7%      +0.1        0.14 ± 13%  perf-profile.children.cycles-pp.apparmor_task_getsecid
      0.00            +0.1        0.08 ± 20%  perf-profile.children.cycles-pp.anon_vma_interval_tree_remove
      0.17 ±  5%      +0.1        0.24 ±  8%  perf-profile.children.cycles-pp.filldir
      0.09 ±  7%      +0.1        0.17 ±  6%  perf-profile.children.cycles-pp.__slab_free
      0.10            +0.1        0.18 ±  7%  perf-profile.children.cycles-pp.do_unlinkat
      0.12 ±  5%      +0.1        0.20 ± 11%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.12 ±  3%      +0.1        0.20 ±  6%  perf-profile.children.cycles-pp.security_file_alloc
      0.11 ±  3%      +0.1        0.19 ± 11%  perf-profile.children.cycles-pp.new_sync_read
      0.07 ±  6%      +0.1        0.15 ± 11%  perf-profile.children.cycles-pp.ima_file_check
      0.07 ±  7%      +0.1        0.15 ± 11%  perf-profile.children.cycles-pp.security_task_getsecid
      0.17 ±  4%      +0.1        0.25 ±  9%  perf-profile.children.cycles-pp.sock_write_iter
      0.17 ±  5%      +0.1        0.25 ±  8%  perf-profile.children.cycles-pp.sock_sendmsg
      0.10 ±  4%      +0.1        0.18 ±  8%  perf-profile.children.cycles-pp.__lookup_slow
      0.13 ±  5%      +0.1        0.21 ±  5%  perf-profile.children.cycles-pp.do_wait
      0.06            +0.1        0.14 ± 14%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.25 ±  4%      +0.1        0.33 ± 10%  perf-profile.children.cycles-pp.irq_enter
      0.12 ±  7%      +0.1        0.20 ± 10%  perf-profile.children.cycles-pp.kill_pid_info
      0.11 ±  9%      +0.1        0.20 ±  7%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.14 ±  3%      +0.1        0.22 ±  9%  perf-profile.children.cycles-pp.find_idlest_group
      0.14 ±  6%      +0.1        0.22 ±  9%  perf-profile.children.cycles-pp.ksys_read
      0.14 ±  3%      +0.1        0.22 ± 10%  perf-profile.children.cycles-pp.find_vma
      0.16 ±  5%      +0.1        0.24 ±  8%  perf-profile.children.cycles-pp.perf_event_mmap
      0.15            +0.1        0.24 ±  6%  perf-profile.children.cycles-pp.__pagevec_lru_add_fn
      0.18 ±  7%      +0.1        0.27 ±  4%  perf-profile.children.cycles-pp.malloc
      0.14 ±  6%      +0.1        0.23 ± 10%  perf-profile.children.cycles-pp.__x64_sys_kill
      0.12 ±  8%      +0.1        0.21 ± 10%  perf-profile.children.cycles-pp.kill_something_info
      0.14 ±  8%      +0.1        0.23 ±  7%  perf-profile.children.cycles-pp.__perf_sw_event
      0.12            +0.1        0.21 ±  9%  perf-profile.children.cycles-pp.lookup_slow
      0.13 ±  5%      +0.1        0.22 ±  6%  perf-profile.children.cycles-pp.__do_sys_wait4
      0.13 ±  5%      +0.1        0.22 ±  6%  perf-profile.children.cycles-pp.kernel_wait4
      0.13 ±  5%      +0.1        0.22 ±  6%  perf-profile.children.cycles-pp.do_signal
      0.15            +0.1        0.24 ±  8%  perf-profile.children.cycles-pp.getname_flags
      0.19 ±  2%      +0.1        0.29 ±  5%  perf-profile.children.cycles-pp.alloc_set_pte
      0.18 ±  8%      +0.1        0.28 ± 19%  perf-profile.children.cycles-pp.__next_timer_interrupt
      0.19 ± 18%      +0.1        0.29 ± 22%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.15 ±  5%      +0.1        0.25 ±  9%  perf-profile.children.cycles-pp.__vm_munmap
      0.16 ±  9%      +0.1        0.27 ±  8%  perf-profile.children.cycles-pp.down_write
      0.00            +0.1        0.11 ± 67%  perf-profile.children.cycles-pp.lockref_get
      0.18 ±  2%      +0.1        0.29 ±  9%  perf-profile.children.cycles-pp.mmap64
      0.16 ±  2%      +0.1        0.27 ± 10%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.20 ±  4%      +0.1        0.32 ±  9%  perf-profile.children.cycles-pp.___might_sleep
      0.17 ±  7%      +0.1        0.28 ± 10%  perf-profile.children.cycles-pp.vfs_read
      0.20 ±  4%      +0.1        0.32 ±  3%  perf-profile.children.cycles-pp.__sched_text_start
      0.15 ±  4%      +0.1        0.27 ± 10%  perf-profile.children.cycles-pp.vma_link
      0.18 ±  3%      +0.1        0.30 ±  6%  perf-profile.children.cycles-pp.copy_p4d_range
      0.17 ±  5%      +0.1        0.29 ±  8%  perf-profile.children.cycles-pp.__lru_cache_add
      0.19 ±  7%      +0.1        0.32 ±  5%  perf-profile.children.cycles-pp.lookup_fast
      0.17 ±  8%      +0.1        0.30 ±  6%  perf-profile.children.cycles-pp.kmem_cache_free
      0.16 ±  8%      +0.1        0.29 ±  3%  perf-profile.children.cycles-pp.rcu_do_batch
      0.32 ± 10%      +0.1        0.45 ±  4%  perf-profile.children.cycles-pp.close
      0.38 ±  6%      +0.1        0.50 ± 11%  perf-profile.children.cycles-pp.scheduler_tick
      0.19 ±  2%      +0.1        0.32 ±  5%  perf-profile.children.cycles-pp.copy_page_range
      0.18 ±  8%      +0.1        0.31 ±  8%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.44 ± 11%      +0.1        0.57 ± 12%  perf-profile.children.cycles-pp.write
      0.20 ±  9%      +0.1        0.33 ±  6%  perf-profile.children.cycles-pp.wp_page_copy
      0.18 ±  8%      +0.1        0.32 ±  7%  perf-profile.children.cycles-pp.lru_add_drain
      0.19 ±  4%      +0.1        0.32 ± 11%  perf-profile.children.cycles-pp.page_remove_rmap
      0.13 ±  9%      +0.1        0.27 ± 17%  perf-profile.children.cycles-pp.unlink_file_vma
      0.25 ±  9%      +0.1        0.39 ±  9%  perf-profile.children.cycles-pp.clockevents_program_event
      0.27 ± 13%      +0.1        0.41 ± 20%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.29 ±  5%      +0.1        0.43 ±  6%  perf-profile.children.cycles-pp.copy_strings
      0.35 ± 11%      +0.1        0.50 ±  4%  perf-profile.children.cycles-pp.new_sync_write
      0.36 ±  6%      +0.1        0.51 ±  6%  perf-profile.children.cycles-pp.kill
      0.19 ±  4%      +0.1        0.33 ± 11%  perf-profile.children.cycles-pp.elf_map
      0.20 ± 14%      +0.1        0.35 ±  7%  perf-profile.children.cycles-pp.rcu_core
      0.26 ±  3%      +0.1        0.41 ±  9%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.22 ±  8%      +0.2        0.37 ±  6%  perf-profile.children.cycles-pp.do_wp_page
      0.28 ±  7%      +0.2        0.43 ±  5%  perf-profile.children.cycles-pp.__xstat64
      0.25            +0.2        0.41 ±  9%  perf-profile.children.cycles-pp._dl_addr
      0.41 ±  8%      +0.2        0.57 ±  3%  perf-profile.children.cycles-pp.ksys_write
      0.40 ±  8%      +0.2        0.56 ±  3%  perf-profile.children.cycles-pp.vfs_write
      0.25            +0.2        0.41 ±  6%  perf-profile.children.cycles-pp.__alloc_file
      0.37 ± 18%      +0.2        0.53 ±  9%  perf-profile.children.cycles-pp.kthread
      0.26            +0.2        0.42 ±  7%  perf-profile.children.cycles-pp.alloc_empty_file
      0.21 ±  4%      +0.2        0.38 ± 24%  perf-profile.children.cycles-pp.__fput
      0.17 ±  4%      +0.2        0.35 ±  9%  perf-profile.children.cycles-pp.iterate_supers
      0.23 ±  3%      +0.2        0.41 ± 10%  perf-profile.children.cycles-pp.mprotect_fixup
      0.41 ± 16%      +0.2        0.59 ±  7%  perf-profile.children.cycles-pp.ret_from_fork
      0.23 ±  3%      +0.2        0.42 ±  9%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      0.23 ±  3%      +0.2        0.42 ±  9%  perf-profile.children.cycles-pp.do_mprotect_pkey
      0.30 ±  2%      +0.2        0.49 ±  5%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.18 ±  4%      +0.2        0.37 ±  9%  perf-profile.children.cycles-pp.__x64_sys_sync
      0.18 ±  4%      +0.2        0.37 ±  9%  perf-profile.children.cycles-pp.ksys_sync
      0.16 ±  4%      +0.2        0.34 ± 25%  perf-profile.children.cycles-pp.do_dentry_open
      0.19 ±  5%      +0.2        0.37 ±  9%  perf-profile.children.cycles-pp.sync
      0.32 ±  4%      +0.2        0.51 ±  6%  perf-profile.children.cycles-pp.flush_tlb_func_common
      0.28 ±  2%      +0.2        0.47 ± 23%  perf-profile.children.cycles-pp.ktime_get
      0.36 ±  3%      +0.2        0.56 ±  5%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.29 ±  2%      +0.2        0.49 ± 10%  perf-profile.children.cycles-pp.vfs_statx
      0.35 ±  4%      +0.2        0.55 ±  8%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.33 ±  5%      +0.2        0.53 ±  7%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.29            +0.2        0.50 ± 10%  perf-profile.children.cycles-pp.__do_sys_newstat
      0.31 ±  5%      +0.2        0.52 ±  8%  perf-profile.children.cycles-pp.clear_page_erms
      0.27 ±  4%      +0.2        0.47 ± 19%  perf-profile.children.cycles-pp.task_work_run
      0.25            +0.2        0.46 ± 10%  perf-profile.children.cycles-pp.__vma_adjust
      0.37 ±  3%      +0.2        0.58 ±  6%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.30            +0.2        0.51 ±  8%  perf-profile.children.cycles-pp.path_lookupat
      0.31            +0.2        0.53 ±  9%  perf-profile.children.cycles-pp.filename_lookup
      0.12 ±  7%      +0.2        0.34 ± 70%  perf-profile.children.cycles-pp.anon_vma_fork
      0.14 ±  6%      +0.2        0.36 ± 62%  perf-profile.children.cycles-pp.anon_vma_clone
      0.39 ±  2%      +0.2        0.61 ±  7%  perf-profile.children.cycles-pp.link_path_walk
      0.33 ±  5%      +0.2        0.56 ±  7%  perf-profile.children.cycles-pp.prep_new_page
      0.32 ±  5%      +0.2        0.55 ±  8%  perf-profile.children.cycles-pp.pagevec_lru_move_fn
      0.41 ± 16%      +0.2        0.65 ± 25%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.62 ±  6%      +0.2        0.86 ± 15%  perf-profile.children.cycles-pp.update_process_times
      0.15 ±  7%      +0.2        0.39 ± 55%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.00            +0.2        0.24 ±  9%  perf-profile.children.cycles-pp.cna_scan_main_queue
      0.37 ±  3%      +0.2        0.62 ±  8%  perf-profile.children.cycles-pp.walk_component
      0.42 ±  6%      +0.2        0.67 ±  9%  perf-profile.children.cycles-pp.__libc_fork
      0.66 ±  6%      +0.3        0.91 ± 16%  perf-profile.children.cycles-pp.tick_sched_handle
      0.44 ±  5%      +0.3        0.70 ±  6%  perf-profile.children.cycles-pp.alloc_pages_vma
      0.34            +0.3        0.60 ±  7%  perf-profile.children.cycles-pp.__split_vma
      0.53 ± 18%      +0.3        0.80 ± 22%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.40            +0.3        0.67 ±  9%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.51 ±  4%      +0.3        0.78 ±  6%  perf-profile.children.cycles-pp.prepare_exit_to_usermode
      0.49 ±  2%      +0.3        0.78 ±  5%  perf-profile.children.cycles-pp.setlocale
      0.40            +0.3        0.68 ±  9%  perf-profile.children.cycles-pp.mmap_region
      0.36 ±  3%      +0.3        0.66 ± 15%  perf-profile.children.cycles-pp.exit_to_usermode_loop
      0.76 ±  6%      +0.3        1.06 ± 17%  perf-profile.children.cycles-pp.tick_sched_timer
      0.45            +0.3        0.77 ±  9%  perf-profile.children.cycles-pp.do_mmap
      0.49 ±  3%      +0.3        0.82 ±  6%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.60            +0.3        0.93 ±  7%  perf-profile.children.cycles-pp.dput
      0.50            +0.4        0.86 ±  9%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.57 ±  4%      +0.4        0.95 ±  5%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      0.71 ±  4%      +0.4        1.09 ±  6%  perf-profile.children.cycles-pp.swapgs_restore_regs_and_return_to_usermode
      0.77 ±  2%      +0.4        1.17 ±  7%  perf-profile.children.cycles-pp.filemap_map_pages
      0.33 ±  5%      +0.4        0.74 ± 34%  perf-profile.children.cycles-pp.free_pgtables
      0.69 ±  4%      +0.4        1.14 ±  8%  perf-profile.children.cycles-pp.unmap_page_range
      0.09 ± 17%      +0.5        0.54 ± 84%  perf-profile.children.cycles-pp.osq_lock
      0.99 ±  6%      +0.5        1.46 ±  4%  perf-profile.children.cycles-pp.creat
      0.74 ±  4%      +0.5        1.21 ±  8%  perf-profile.children.cycles-pp.unmap_vmas
      0.46 ±  4%      +0.5        0.94 ± 27%  perf-profile.children.cycles-pp.dup_mm
      0.54 ±  9%      +0.5        1.03 ± 12%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.43 ±  4%      +0.5        0.97 ±  7%  perf-profile.children.cycles-pp.lseek64
      0.56 ±  2%      +0.5        1.11 ± 21%  perf-profile.children.cycles-pp.flush_old_exec
      0.15 ±  9%      +0.6        0.71 ± 66%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      1.06 ± 17%      +0.6        1.62 ± 17%  perf-profile.children.cycles-pp.menu_select
      0.16 ± 10%      +0.6        0.73 ± 65%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.67 ±  4%      +0.6        1.28 ± 21%  perf-profile.children.cycles-pp.copy_process
      0.96 ±  3%      +0.6        1.58 ±  8%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.96 ±  3%      +0.6        1.58 ±  8%  perf-profile.children.cycles-pp.do_group_exit
      0.96 ±  3%      +0.6        1.58 ±  8%  perf-profile.children.cycles-pp.do_exit
      1.48 ± 10%      +0.6        2.11 ±  5%  perf-profile.children.cycles-pp.__strcat_chk
      0.78 ±  3%      +0.7        1.44 ± 12%  perf-profile.children.cycles-pp.release_pages
      1.78 ±  3%      +0.7        2.46 ± 15%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.80 ±  5%      +0.7        1.49 ± 18%  perf-profile.children.cycles-pp.__x64_sys_clone
      0.80 ±  5%      +0.7        1.49 ± 18%  perf-profile.children.cycles-pp._do_fork
      0.42 ±  6%      +0.7        1.11 ±  8%  perf-profile.children.cycles-pp.dcache_dir_lseek
      0.42 ±  7%      +0.7        1.12 ±  8%  perf-profile.children.cycles-pp.ksys_lseek
      1.58 ± 14%      +0.8        2.36 ±  6%  perf-profile.children.cycles-pp.brk
      1.14 ±  2%      +0.9        2.00 ± 10%  perf-profile.children.cycles-pp.tlb_flush_mmu
      1.16 ±  2%      +0.9        2.02 ± 10%  perf-profile.children.cycles-pp.tlb_finish_mmu
      1.27 ±  3%      +0.9        2.19 ± 10%  perf-profile.children.cycles-pp.unmap_region
      1.14 ±  2%      +0.9        2.07 ± 14%  perf-profile.children.cycles-pp.load_elf_binary
      1.14 ±  3%      +0.9        2.08 ± 14%  perf-profile.children.cycles-pp.search_binary_handler
      1.21 ±  3%      +1.0        2.22 ± 13%  perf-profile.children.cycles-pp.exit_mmap
      1.22 ±  3%      +1.0        2.23 ± 13%  perf-profile.children.cycles-pp.mmput
      1.48 ±  4%      +1.0        2.49 ± 10%  perf-profile.children.cycles-pp.__x64_sys_brk
      1.99 ±  3%      +1.1        3.12 ±  7%  perf-profile.children.cycles-pp.handle_pte_fault
      1.60 ±  3%      +1.1        2.75 ±  9%  perf-profile.children.cycles-pp.__do_munmap
      2.63 ±  9%      +1.2        3.84 ±  7%  perf-profile.children.cycles-pp.__strncat_chk
      2.15 ±  3%      +1.2        3.37 ±  7%  perf-profile.children.cycles-pp.__handle_mm_fault
      2.86 ± 10%      +1.3        4.13 ± 19%  perf-profile.children.cycles-pp.smp_apic_timer_interrupt
      2.24 ±  3%      +1.3        3.51 ±  7%  perf-profile.children.cycles-pp.handle_mm_fault
      3.11 ±  8%      +1.3        4.45 ± 17%  perf-profile.children.cycles-pp.apic_timer_interrupt
      2.49 ±  3%      +1.4        3.92 ±  7%  perf-profile.children.cycles-pp.__do_page_fault
      2.56 ±  3%      +1.5        4.03 ±  7%  perf-profile.children.cycles-pp.do_page_fault
      2.66 ±  3%      +1.5        4.19 ±  7%  perf-profile.children.cycles-pp.page_fault
      0.00            +4.1        4.11 ± 18%  perf-profile.children.cycles-pp.opendir
      0.06 ± 17%      +4.9        4.92 ± 12%  perf-profile.children.cycles-pp.complete_walk
      1.40            +5.9        7.28 ±  8%  perf-profile.children.cycles-pp.do_sys_open
     16.96            +9.0       26.01 ± 10%  perf-profile.children.cycles-pp.intel_idle
     20.18 ±  5%     +10.9       31.07 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter_state
     20.18 ±  5%     +10.9       31.08 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter
      1.68 ±  4%     +11.1       12.75 ± 15%  perf-profile.children.cycles-pp.execve
     21.42 ±  6%     +11.6       32.99 ±  6%  perf-profile.children.cycles-pp.start_secondary
     21.66 ±  6%     +11.7       33.35 ±  6%  perf-profile.children.cycles-pp.secondary_startup_64
     21.66 ±  6%     +11.7       33.35 ±  6%  perf-profile.children.cycles-pp.cpu_startup_entry
     21.67 ±  6%     +11.7       33.36 ±  6%  perf-profile.children.cycles-pp.do_idle
      0.15 ± 63%     +12.5       12.69 ±  4%  perf-profile.children.cycles-pp.trailing_symlink
      0.20 ± 48%     +12.8       12.96 ±  4%  perf-profile.children.cycles-pp.do_open_execat
      1.81 ±  6%     +14.0       15.77        perf-profile.children.cycles-pp.__do_execve_file
      1.83 ±  6%     +14.0       15.81        perf-profile.children.cycles-pp.__x64_sys_execve
      0.16 ± 61%     +17.4       17.53 ±  5%  perf-profile.children.cycles-pp.lockref_get_not_dead
      0.19 ± 51%     +17.4       17.57 ±  5%  perf-profile.children.cycles-pp.legitimize_path
      0.19 ± 47%     +17.4       17.59 ±  5%  perf-profile.children.cycles-pp.unlazy_walk
      1.43 ±  7%     +18.5       19.96 ±  4%  perf-profile.children.cycles-pp.path_openat
      1.44 ±  7%     +18.5       19.98 ±  4%  perf-profile.children.cycles-pp.do_filp_open
      0.00           +33.7       33.74 ±  3%  perf-profile.children.cycles-pp.__cna_queued_spin_lock_slowpath
     56.88 ±  3%     -56.9        0.00        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.31 ±  4%      -0.1        0.25 ±  6%  perf-profile.self.cycles-pp.lockref_put_or_lock
      0.09 ± 11%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.scan_positives
      0.07 ± 12%      +0.0        0.09 ±  7%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.06 ± 11%      +0.0        0.08 ± 13%  perf-profile.self.cycles-pp.native_apic_msr_eoi_write
      0.06 ±  7%      +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.07 ±  6%      +0.0        0.10 ±  9%  perf-profile.self.cycles-pp.link_path_walk
      0.07 ± 12%      +0.0        0.10 ± 15%  perf-profile.self.cycles-pp.free
      0.08 ± 14%      +0.0        0.11 ± 10%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.07 ± 13%      +0.0        0.10 ± 18%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.06            +0.0        0.09        perf-profile.self.cycles-pp.alloc_set_pte
      0.08 ±  5%      +0.0        0.11 ± 11%  perf-profile.self.cycles-pp.__x86_indirect_thunk_rax
      0.05 ±  8%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.down_read
      0.05 ±  9%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.__alloc_pages_nodemask
      0.08 ±  6%      +0.0        0.11 ± 11%  perf-profile.self.cycles-pp.handle_pte_fault
      0.07 ±  6%      +0.0        0.10 ± 12%  perf-profile.self.cycles-pp.page_add_file_rmap
      0.04 ± 58%      +0.0        0.07 ± 14%  perf-profile.self.cycles-pp.__rb_insert_augmented
      0.07 ±  7%      +0.0        0.10 ± 12%  perf-profile.self.cycles-pp.vmacache_find
      0.04 ± 58%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.memcpy
      0.06 ± 15%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      0.06 ± 13%      +0.0        0.10 ± 12%  perf-profile.self.cycles-pp.handle_mm_fault
      0.07 ± 13%      +0.0        0.10 ±  8%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.07 ±  6%      +0.0        0.11 ± 10%  perf-profile.self.cycles-pp.__alloc_file
      0.07 ± 16%      +0.0        0.11 ±  7%  perf-profile.self.cycles-pp.update_cfs_group
      0.03 ±100%      +0.0        0.07 ±  7%  perf-profile.self.cycles-pp.vfprintf
      0.10 ± 11%      +0.0        0.14 ± 10%  perf-profile.self.cycles-pp.__libc_calloc
      0.07 ± 17%      +0.0        0.11 ± 17%  perf-profile.self.cycles-pp.native_sched_clock
      0.07 ± 11%      +0.0        0.12 ±  7%  perf-profile.self.cycles-pp.kmem_cache_free
      0.07 ±  5%      +0.0        0.12 ± 13%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.03 ±100%      +0.0        0.07 ± 12%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.01 ±173%      +0.0        0.06 ± 14%  perf-profile.self.cycles-pp.strlen
      0.03 ±100%      +0.0        0.07 ± 10%  perf-profile.self.cycles-pp.rcu_all_qs
      0.03 ±100%      +0.0        0.07 ± 10%  perf-profile.self.cycles-pp.copy_user_generic_unrolled
      0.08 ± 10%      +0.0        0.12 ± 12%  perf-profile.self.cycles-pp.__do_page_fault
      0.03 ±100%      +0.0        0.07 ± 11%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.01 ±173%      +0.0        0.06 ± 20%  perf-profile.self.cycles-pp.smp_apic_timer_interrupt
      0.09 ±  9%      +0.0        0.14 ± 16%  perf-profile.self.cycles-pp.__next_timer_interrupt
      0.07 ±  7%      +0.0        0.11 ± 13%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.06 ±  6%      +0.0        0.11 ± 13%  perf-profile.self.cycles-pp.find_vma
      0.01 ±173%      +0.1        0.06 ± 13%  perf-profile.self.cycles-pp.__do_munmap
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.lapic_next_deadline
      0.03 ±100%      +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.__vma_link_rb
      0.08 ±  6%      +0.1        0.13 ± 11%  perf-profile.self.cycles-pp.copy_page
      0.07 ±  5%      +0.1        0.12 ±  8%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.04 ± 57%      +0.1        0.09 ± 13%  perf-profile.self.cycles-pp._cond_resched
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.anon_vma_clone
      0.10 ±  5%      +0.1        0.15 ±  8%  perf-profile.self.cycles-pp.__pagevec_lru_add_fn
      0.10 ±  7%      +0.1        0.15 ±  7%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.00            +0.1        0.05 ±  9%  perf-profile.self.cycles-pp.memchr
      0.00            +0.1        0.05 ±  9%  perf-profile.self.cycles-pp.perf_iterate_sb
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.anon_vma_interval_tree_remove
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.fsnotify
      0.08 ±  5%      +0.1        0.13 ± 14%  perf-profile.self.cycles-pp.aa_file_perm
      0.01 ±173%      +0.1        0.07 ± 12%  perf-profile.self.cycles-pp.update_load_avg
      0.08 ±  5%      +0.1        0.14 ±  5%  perf-profile.self.cycles-pp.up_write
      0.13 ±  6%      +0.1        0.18 ±  9%  perf-profile.self.cycles-pp.filldir
      0.10 ±  4%      +0.1        0.15 ±  7%  perf-profile.self.cycles-pp.___perf_sw_event
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.path_openat
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.unlink_anon_vmas
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.00            +0.1        0.06 ± 14%  perf-profile.self.cycles-pp.apparmor_task_getsecid
      0.11            +0.1        0.17 ±  7%  perf-profile.self.cycles-pp.__might_sleep
      0.01 ±173%      +0.1        0.07 ± 22%  perf-profile.self.cycles-pp.update_rq_clock
      0.12 ±  7%      +0.1        0.18 ± 12%  perf-profile.self.cycles-pp.read_tsc
      0.15 ±  5%      +0.1        0.21 ± 14%  perf-profile.self.cycles-pp.native_write_msr
      0.10 ± 10%      +0.1        0.16 ± 11%  perf-profile.self.cycles-pp.strnlen_user
      0.08 ±  6%      +0.1        0.14 ± 11%  perf-profile.self.cycles-pp.copy_p4d_range
      0.06 ±  6%      +0.1        0.12 ± 17%  perf-profile.self.cycles-pp.aa_get_task_label
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.__list_add_valid
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.sync_regs
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.up_read
      0.08            +0.1        0.14 ± 20%  perf-profile.self.cycles-pp.apparmor_file_open
      0.12 ±  4%      +0.1        0.19 ± 10%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.strncpy_from_user
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.12 ± 10%      +0.1        0.19 ± 11%  perf-profile.self.cycles-pp.find_next_bit
      0.08            +0.1        0.15 ±  7%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.10 ±  7%      +0.1        0.17 ±  8%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.16 ±  9%      +0.1        0.23 ±  4%  perf-profile.self.cycles-pp.malloc
      0.11 ±  7%      +0.1        0.18 ± 11%  perf-profile.self.cycles-pp.down_write
      0.14 ±  3%      +0.1        0.21 ± 13%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.12 ± 13%      +0.1        0.19 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.12 ±  3%      +0.1        0.20 ±  9%  perf-profile.self.cycles-pp.find_idlest_group
      0.09 ±  7%      +0.1        0.17 ±  5%  perf-profile.self.cycles-pp.__slab_free
      0.00            +0.1        0.08 ± 14%  perf-profile.self.cycles-pp.__vma_adjust
      0.12 ±  3%      +0.1        0.20 ± 11%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.06            +0.1        0.14 ± 14%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.20 ±  2%      +0.1        0.30 ±  8%  perf-profile.self.cycles-pp.___might_sleep
      0.20 ±  7%      +0.1        0.31 ±  9%  perf-profile.self.cycles-pp.swapgs_restore_regs_and_return_to_usermode
      0.16 ±  5%      +0.1        0.27 ± 12%  perf-profile.self.cycles-pp.page_remove_rmap
      0.28 ±  4%      +0.1        0.41 ±  7%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.18 ±  4%      +0.1        0.31 ± 36%  perf-profile.self.cycles-pp.ktime_get
      0.25            +0.1        0.40 ±  9%  perf-profile.self.cycles-pp._dl_addr
      0.19 ±  3%      +0.1        0.34 ± 10%  perf-profile.self.cycles-pp.release_pages
      0.30 ±  2%      +0.2        0.49 ±  5%  perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.32 ±  3%      +0.2        0.51 ± 10%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.36 ±  3%      +0.2        0.56 ±  4%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.33 ±  5%      +0.2        0.53 ±  7%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.31 ±  6%      +0.2        0.51 ±  8%  perf-profile.self.cycles-pp.clear_page_erms
      0.00            +0.2        0.23 ± 10%  perf-profile.self.cycles-pp.cna_scan_main_queue
      0.37 ± 19%      +0.2        0.60 ± 14%  perf-profile.self.cycles-pp.menu_select
      0.39 ±  2%      +0.2        0.62 ±  7%  perf-profile.self.cycles-pp.unmap_page_range
      0.48 ±  3%      +0.3        0.74 ±  9%  perf-profile.self.cycles-pp.filemap_map_pages
      0.49 ±  4%      +0.3        0.77 ±  5%  perf-profile.self.cycles-pp.prepare_exit_to_usermode
      0.93            +0.3        1.20 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock
      0.09 ± 17%      +0.4        0.53 ± 85%  perf-profile.self.cycles-pp.osq_lock
      0.90            +0.6        1.49 ±  7%  perf-profile.self.cycles-pp.do_syscall_64
      1.47 ± 10%      +0.6        2.09 ±  5%  perf-profile.self.cycles-pp.__strcat_chk
      2.61 ±  9%      +1.2        3.81 ±  7%  perf-profile.self.cycles-pp.__strncat_chk
     16.93            +9.0       25.96 ± 10%  perf-profile.self.cycles-pp.intel_idle
      0.00           +33.3       33.31 ±  4%  perf-profile.self.cycles-pp.__cna_queued_spin_lock_slowpath





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Rong Chen


--f0PSjARDFl/vfYT5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.5.0-rc1-00190-g93ee6cfe912a1"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.5.0-rc1 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.5.0-5) 7.5.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70500
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
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
CONFIG_BPF_JIT_ALWAYS_ON=y
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
CONFIG_NUMA_AWARE_SPINLOCKS=y
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
CONFIG_X86_INTEL_MPX=y
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

CONFIG_X86_DEV_DMA_OPS=y

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
CONFIG_HAVE_RCU_TABLE_FREE=y
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

#
# GCC plugins
#
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
# end of GCC plugins
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
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
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
# CONFIG_VIRTIO_BLK_SCSI is not set
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
CONFIG_THUNDERBOLT_NET=m
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
CONFIG_ISDN=y
CONFIG_ISDN_CAPI=m
# CONFIG_CAPI_TRACE is not set
CONFIG_ISDN_CAPI_CAPI20=m
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
CONFIG_I2C_PARPORT_LIGHT=m
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
# CONFIG_SPI_PXA2XX is not set
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
# CONFIG_PINCTRL_EQUILIBRIUM is not set
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
# CONFIG_GPIO_LYNXPOINT is not set
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
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
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
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
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
CONFIG_SND_HDA_PREALLOC_SIZE=512
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
CONFIG_SND_SOC_INTEL_HASWELL_MACH=m
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
CONFIG_INTEL_IOATDMA=m
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

#
# ISDN CAPI drivers
#
CONFIG_CAPI_AVM=y
CONFIG_ISDN_DRV_AVMB1_B1PCI=m
CONFIG_ISDN_DRV_AVMB1_B1PCIV4=y
CONFIG_ISDN_DRV_AVMB1_T1PCI=m
CONFIG_ISDN_DRV_AVMB1_C4=m
CONFIG_ISDN_DRV_GIGASET=m
CONFIG_GIGASET_CAPI=y
CONFIG_GIGASET_BASE=m
CONFIG_GIGASET_M105=m
CONFIG_GIGASET_M101=m
# CONFIG_GIGASET_DEBUG is not set
CONFIG_HYSDN=m
CONFIG_HYSDN_CAPI=y
# end of ISDN CAPI drivers

CONFIG_USB_WUSB=m
CONFIG_USB_WUSB_CBAF=m
# CONFIG_USB_WUSB_CBAF_DEBUG is not set
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=m
CONFIG_UWB=m
CONFIG_UWB_HWA=m
CONFIG_UWB_WHCI=m
CONFIG_UWB_I1480U=m
# CONFIG_EXFAT_FS is not set
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
CONFIG_THUNDERBOLT=y

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
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
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
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
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
CONFIG_KEYS_COMPAT=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
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
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
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
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
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
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
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
# CONFIG_CRYPTO_BLAKE2B is not set
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
CONFIG_CRYPTO_SHA512=y
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
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=4
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
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
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
CONFIG_HAVE_ARCH_KCSAN=y
# CONFIG_KCSAN is not set
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
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_STACK_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_FUNCTION_PROFILER=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
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
# end of Kernel hacking

#
# Kernel Testing and Coverage
#
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
# CONFIG_X86_PTDUMP is not set
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

# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage

--f0PSjARDFl/vfYT5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='aim7'
	export testcase='aim7'
	export category='benchmark'
	export job_origin='/lkp/lkp/.src-20200129-125004/allot/cyclic:p1:linux-devel:devel-hourly/lkp-csl-2ap2/aim7-fs-raid.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-csl-2ap2'
	export tbox_group='lkp-csl-2ap2'
	export submit_id='5e580625046bb217376c1e0d'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2ap2/aim7-performance-4BRD_12G-btrfs-1500-RAID1-disk_wrt-ucode=0x500002c-debian-x86_64-20191114.cgz-93ee6cfe912a19a3faa62c5c28e2592f6-20200228-5943-1q1nz3v-3.yaml'
	export id='25203f80a4240dc02305317185e690887db1f682'
	export queuer_version='/lkp-src'
	export arch='x86_64'
	export model='Cascade Lake'
	export nr_node=4
	export nr_cpu=192
	export memory='192G'
	export hdd_partitions=
	export ssd_partitions=
	export rootfs_partition='LABEL=LKP-ROOTFS'
	export kernel_cmdline_hw='acpi_rsdp=0x67f44014'
	export brand='Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz'
	export commit='93ee6cfe912a19a3faa62c5c28e2592f6711563c'
	export need_kconfig_hw='CONFIG_IGB=y
CONFIG_BLK_DEV_NVME'
	export ucode='0x500002c'
	export need_kconfig='CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV=y
CONFIG_BLOCK=y
CONFIG_MD_RAID1
CONFIG_BTRFS_FS'
	export kconfig='x86_64-rhel-7.6'
	export compiler='gcc-7'
	export enqueue_time='2020-02-28 02:10:49 +0800'
	export _id='5e580629046bb217376c1e0e'
	export _rt='/result/aim7/performance-4BRD_12G-btrfs-1500-RAID1-disk_wrt-ucode=0x500002c/lkp-csl-2ap2/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/93ee6cfe912a19a3faa62c5c28e2592f6711563c'
	export user='lkp'
	export head_commit='f21d8fe3cfb149c72f84bd47948849bf5d7fe91c'
	export base_commit='d5226fa6dbae0569ee43ecfc08bdcd6770fc4755'
	export branch='linux-devel/devel-hourly-2020013013'
	export rootfs='debian-x86_64-20191114.cgz'
	export result_root='/result/aim7/performance-4BRD_12G-btrfs-1500-RAID1-disk_wrt-ucode=0x500002c/lkp-csl-2ap2/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/93ee6cfe912a19a3faa62c5c28e2592f6711563c/3'
	export scheduler_version='/lkp/lkp/.src-20200227-195704'
	export LKP_SERVER='inn'
	export max_uptime=1262.0
	export initrd='/osimage/debian/debian-x86_64-20191114.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-csl-2ap2/aim7-performance-4BRD_12G-btrfs-1500-RAID1-disk_wrt-ucode=0x500002c-debian-x86_64-20191114.cgz-93ee6cfe912a19a3faa62c5c28e2592f6-20200228-5943-1q1nz3v-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.6
branch=linux-devel/devel-hourly-2020013013
commit=93ee6cfe912a19a3faa62c5c28e2592f6711563c
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/93ee6cfe912a19a3faa62c5c28e2592f6711563c/vmlinuz-5.5.0-rc1-00190-g93ee6cfe912a1
acpi_rsdp=0x67f44014
max_uptime=1262
RESULT_ROOT=/result/aim7/performance-4BRD_12G-btrfs-1500-RAID1-disk_wrt-ucode=0x500002c/lkp-csl-2ap2/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/93ee6cfe912a19a3faa62c5c28e2592f6711563c/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-7.6/gcc-7/93ee6cfe912a19a3faa62c5c28e2592f6711563c/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-20180403.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/lkp_2019-08-05.cgz,/osimage/deps/debian-x86_64-20180403.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/perf_2020-01-04.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/perf-x86_64-c5f86891185c-1_20200226.cgz,/osimage/deps/debian-x86_64-20180403.cgz/md_2019-06-26.cgz,/osimage/deps/debian-x86_64-20180403.cgz/fs_2020-01-02.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/aim7-x86_64-1-1_2020-01-01.cgz,/osimage/deps/debian-x86_64-20180403.cgz/mpstat_2020-01-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/vmstat_2020-01-07.cgz,/osimage/deps/debian-x86_64-20180403.cgz/turbostat_2020-01-06.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/turbostat-x86_64-3.7-4_2020-01-06.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/sar-x86_64-e011d97-1_2020-01-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/hw_2020-01-02.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.5.0'
	export repeat_to=4
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-7.6/gcc-7/93ee6cfe912a19a3faa62c5c28e2592f6711563c/vmlinuz-5.5.0-rc1-00190-g93ee6cfe912a1'
	export dequeue_time='2020-02-28 02:16:47 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2ap2/aim7-performance-4BRD_12G-btrfs-1500-RAID1-disk_wrt-ucode=0x500002c-debian-x86_64-20191114.cgz-93ee6cfe912a19a3faa62c5c28e2592f6-20200228-5943-1q1nz3v-3.cgz'

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

	run_setup nr_brd=4 ramdisk_size=12884901888 $LKP_SRC/setup/disk

	run_setup raid_level='raid1' $LKP_SRC/setup/md

	run_setup fs='btrfs' $LKP_SRC/setup/fs

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
	run_monitor $LKP_SRC/monitors/wrapper turbostat
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='disk_wrt' load=1500 $LKP_SRC/tests/wrapper aim7
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
	$LKP_SRC/stats/wrapper turbostat
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

--f0PSjARDFl/vfYT5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/aim7-fs-raid.yaml
suite: aim7
testcase: aim7
category: benchmark
perf-profile:
  delay: 15
disk: 4BRD_12G
md: RAID1
fs: btrfs
aim7:
  test: disk_wrt
  load: 1500
job_origin: "/lkp/lkp/.src-20200129-125004/allot/cyclic:p1:linux-devel:devel-hourly/lkp-csl-2ap2/aim7-fs-raid.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-csl-2ap2
tbox_group: lkp-csl-2ap2
submit_id: 5e57f87c046bb2164e593f72
job_file: "/lkp/jobs/scheduled/lkp-csl-2ap2/aim7-performance-4BRD_12G-btrfs-1500-RAID1-disk_wrt-ucode=0x500002c-debian-x86_64-20191114.cgz-93ee6cfe912a19a3faa62c5c28e2592f6-20200228-5710-1d0a4v4-0.yaml"
id: 40ce75166037945d38e828b0351f59bd443b08c9
queuer_version: "/lkp-src"
arch: x86_64

#! hosts/lkp-csl-2ap2
model: Cascade Lake
nr_node: 4
nr_cpu: 192
memory: 192G
hdd_partitions: 
ssd_partitions: 
rootfs_partition: LABEL=LKP-ROOTFS
kernel_cmdline_hw: acpi_rsdp=0x67f44014
brand: Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz

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
turbostat: 
sched_debug: 
perf-stat: 
mpstat: 

#! include/category/ALL
cpufreq_governor: performance

#! include/queue/cyclic
commit: 93ee6cfe912a19a3faa62c5c28e2592f6711563c

#! include/testbox/lkp-csl-2ap2
need_kconfig_hw:
- CONFIG_IGB=y
- CONFIG_BLK_DEV_NVME
ucode: '0x500002c'

#! include/disk/nr_brd
need_kconfig:
- CONFIG_BLK_DEV_RAM=m
- CONFIG_BLK_DEV=y
- CONFIG_BLOCK=y
- CONFIG_MD_RAID1
- CONFIG_BTRFS_FS

#! include/md/raid_level

#! include/fs/OTHERS

#! default params
kconfig: x86_64-rhel-7.6
compiler: gcc-7
enqueue_time: 2020-02-28 01:12:32.302241799 +08:00
_id: 5e57f87c046bb2164e593f72
_rt: "/result/aim7/performance-4BRD_12G-btrfs-1500-RAID1-disk_wrt-ucode=0x500002c/lkp-csl-2ap2/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/93ee6cfe912a19a3faa62c5c28e2592f6711563c"

#! schedule options
user: lkp
head_commit: f21d8fe3cfb149c72f84bd47948849bf5d7fe91c
base_commit: d5226fa6dbae0569ee43ecfc08bdcd6770fc4755
branch: linux-devel/devel-hourly-2020013013
rootfs: debian-x86_64-20191114.cgz
result_root: "/result/aim7/performance-4BRD_12G-btrfs-1500-RAID1-disk_wrt-ucode=0x500002c/lkp-csl-2ap2/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/93ee6cfe912a19a3faa62c5c28e2592f6711563c/0"
scheduler_version: "/lkp/lkp/.src-20200227-195704"
LKP_SERVER: inn
max_uptime: 1262.0
initrd: "/osimage/debian/debian-x86_64-20191114.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-csl-2ap2/aim7-performance-4BRD_12G-btrfs-1500-RAID1-disk_wrt-ucode=0x500002c-debian-x86_64-20191114.cgz-93ee6cfe912a19a3faa62c5c28e2592f6-20200228-5710-1d0a4v4-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-7.6
- branch=linux-devel/devel-hourly-2020013013
- commit=93ee6cfe912a19a3faa62c5c28e2592f6711563c
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/93ee6cfe912a19a3faa62c5c28e2592f6711563c/vmlinuz-5.5.0-rc1-00190-g93ee6cfe912a1
- acpi_rsdp=0x67f44014
- max_uptime=1262
- RESULT_ROOT=/result/aim7/performance-4BRD_12G-btrfs-1500-RAID1-disk_wrt-ucode=0x500002c/lkp-csl-2ap2/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/93ee6cfe912a19a3faa62c5c28e2592f6711563c/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-7.6/gcc-7/93ee6cfe912a19a3faa62c5c28e2592f6711563c/modules.cgz"
bm_initrd: "/osimage/deps/debian-x86_64-20180403.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/lkp_2019-08-05.cgz,/osimage/deps/debian-x86_64-20180403.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/perf_2020-01-04.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/perf-x86_64-c5f86891185c-1_20200226.cgz,/osimage/deps/debian-x86_64-20180403.cgz/md_2019-06-26.cgz,/osimage/deps/debian-x86_64-20180403.cgz/fs_2020-01-02.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/aim7-x86_64-1-1_2020-01-01.cgz,/osimage/deps/debian-x86_64-20180403.cgz/mpstat_2020-01-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/vmstat_2020-01-07.cgz,/osimage/deps/debian-x86_64-20180403.cgz/turbostat_2020-01-06.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/turbostat-x86_64-3.7-4_2020-01-06.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/sar-x86_64-e011d97-1_2020-01-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/hw_2020-01-02.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20200130-191928/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.4.0-04150-g77a05940eee7e
repeat_to: 2
schedule_notify_address: 

#! user overrides
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-7.6/gcc-7/93ee6cfe912a19a3faa62c5c28e2592f6711563c/vmlinuz-5.5.0-rc1-00190-g93ee6cfe912a1"
dequeue_time: 2020-02-28 01:59:19.508804797 +08:00

#! /lkp/lkp/.src-20200227-195704/include/site/inn
job_state: finished
loadavg: 1003.55 520.97 202.36 1/1365 9681
start_time: '1582826430'
end_time: '1582826582'
version: "/lkp/lkp/.src-20200227-195737:82061ed6:e6d8487ef-dirty"

--f0PSjARDFl/vfYT5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

 "modprobe" "-r" "brd"
 "modprobe" "brd" "rd_nr=4" "rd_size=12582912"
 "dmsetup" "remove_all"
 "wipefs" "-a" "--force" "/dev/ram0"
 "wipefs" "-a" "--force" "/dev/ram1"
 "wipefs" "-a" "--force" "/dev/ram2"
 "wipefs" "-a" "--force" "/dev/ram3"
 "mdadm" "-q" "--create" "/dev/md0" "--chunk=256" "--level=raid1" "--raid-devices=4" "--force" "--assume-clean" "/dev/ram0" "/dev/ram1" "/dev/ram2" "/dev/ram3"
wipefs -a --force /dev/md0
mkfs -t btrfs /dev/md0
mkdir -p /fs/md0
mount -t btrfs /dev/md0 /fs/md0

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
10 disk_wrt
EOF
echo "/fs/md0" > config

	(
		echo lkp-csl-2ap2
		echo disk_wrt

		echo 1
		echo 1500
		echo 2
		echo 1500
		echo 1
	) | ./multitask -t &

--f0PSjARDFl/vfYT5--
