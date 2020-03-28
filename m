Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9204FC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 13:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E077220716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 13:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgC1NYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 09:24:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:6046 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgC1NYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 09:24:05 -0400
IronPort-SDR: JyCf1/AT8DRXqCWJRWAqkoozurTPojaWjh8gnv+D1eOykC5KSbV1mzey9mXMZLTk03OVzISTXf
 vdgkJrc2x6jA==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2020 06:23:49 -0700
IronPort-SDR: IHPkkIB11y9F1g4bUyuqULTN+NhDyS/oykhMcuxj+Z/imSFzGG5TYyl9IqULey1a9mqT39yFCs
 ksDRuGGr5MCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,316,1580803200"; 
   d="yaml'?scan'208";a="447734854"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by fmsmga005.fm.intel.com with ESMTP; 28 Mar 2020 06:23:43 -0700
Date:   Sat, 28 Mar 2020 21:23:25 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Aubrey Li <aubrey.li@intel.com>
Cc:     vincent.guittot@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, tim.c.chen@linux.intel.com,
        vpillai@digitalocean.com, joel@joelfernandes.org,
        Aubrey Li <aubrey.li@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>, lkp@lists.01.org
Subject: [sched/fair] 59901cb452: netperf.Throughput_Mbps -27.3% regression
Message-ID: <20200328132325.GC11705@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+7aqSd/VAgMzTgew"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1585140388-61802-1-git-send-email-aubrey.li@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+7aqSd/VAgMzTgew
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Greeting,

FYI, we noticed a -27.3% regression of netperf.Throughput_Mbps due to commit:


commit: 59901cb4520c44bfce81f523bc61e7284a931ad1 ("[PATCH] sched/fair: Don't pull task if local group is more loaded than busiest group")
url: https://github.com/0day-ci/linux/commits/Aubrey-Li/sched-fair-Don-t-pull-task-if-local-group-is-more-loaded-than-busiest-group/20200326-080334


in testcase: netperf
on test machine: 72 threads Intel(R) Xeon(R) Gold 6139 CPU @ 2.30GHz with 128G memory
with following parameters:

	ip: ipv4
	runtime: 300s
	nr_threads: 25%
	cluster: cs-localhost
	send_size: 5K
	test: TCP_SENDFILE
	cpufreq_governor: performance
	ucode: 0x2000065

test-description: Netperf is a benchmark that can be use to measure various aspect of networking performance.
test-url: http://www.netperf.org/netperf/

In addition to that, the commit also has significant impact on the following tests:

+------------------+------------------------------------------------------------------------+
| testcase: change | netperf: netperf.Throughput_Mbps -31.1% regression                     |
| test machine     | 160 threads Intel(R) Xeon(R) CPU E7-8890 v4 @ 2.20GHz with 256G memory |
| test parameters  | cluster=cs-localhost                                                   |
|                  | cpufreq_governor=performance                                           |
|                  | ip=ipv4                                                                |
|                  | nr_threads=25%                                                         |
|                  | runtime=300s                                                           |
|                  | send_size=10K                                                          |
|                  | test=SCTP_STREAM_MANY                                                  |
|                  | ucode=0xb000038                                                        |
+------------------+------------------------------------------------------------------------+
| testcase: change | unixbench: unixbench.score -4.0% regression                            |
| test machine     | 104 threads Skylake with 192G memory                                   |
| test parameters  | cpufreq_governor=performance                                           |
|                  | nr_task=30%                                                            |
|                  | runtime=300s                                                           |
|                  | test=whetstone-double                                                  |
|                  | ucode=0x2000065                                                        |
+------------------+------------------------------------------------------------------------+
| testcase: change | unixbench: unixbench.score 29.1% improvement                           |
| test machine     | 104 threads Skylake with 192G memory                                   |
| test parameters  | cpufreq_governor=performance                                           |
|                  | nr_task=30%                                                            |
|                  | runtime=300s                                                           |
|                  | test=context1                                                          |
|                  | ucode=0x2000065                                                        |
+------------------+------------------------------------------------------------------------+
| testcase: change | kbuild: kbuild.buildtime_per_iteration 7.5% regression                 |
| test machine     | 8 threads Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz with 8G memory       |
| test parameters  | cpufreq_governor=performance                                           |
|                  | nr_task=50%                                                            |
|                  | runtime=300s                                                           |
|                  | target=vmlinux_prereq                                                  |
|                  | ucode=0x27                                                             |
+------------------+------------------------------------------------------------------------+


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
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/send_size/tbox_group/test/testcase/ucode:
  cs-localhost/gcc-7/performance/ipv4/x86_64-rhel-7.6/25%/debian-x86_64-20191114.cgz/300s/5K/lkp-skl-2sp7/TCP_SENDFILE/netperf/0x2000065

commit: 
  9c40365a65 ("threads: Update PID limit comment according to futex UAPI change")
  59901cb452 ("sched/fair: Don't pull task if local group is more loaded than busiest group")

9c40365a65d62d7c 59901cb4520c44bfce81f523bc6 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          1:4          -25%            :4     dmesg.WARNING:at#for_ip_interrupt_entry/0x
           :4           50%           2:4     dmesg.WARNING:at_ip__fsnotify_parent/0x
         %stddev     %change         %stddev
             \          |                \  
     18708           -27.3%      13593        netperf.Throughput_Mbps
    336757           -27.3%     244677        netperf.Throughput_total_Mbps
      8293 ±  2%     +82.7%      15156 ± 57%  netperf.time.involuntary_context_switches
      2291            +2.6%       2350        netperf.time.maximum_resident_set_size
      5103            -8.9%       4651        netperf.time.minor_page_faults
      4704            +1.4%       4771        netperf.time.system_time
    695.32            -9.7%     627.59        netperf.time.user_time
    431.25 ± 51%    +394.1%       2131 ± 59%  netperf.time.voluntary_context_switches
 2.466e+09           -27.3%  1.792e+09        netperf.workload
    526188 ±  5%     -21.3%     414060 ±  7%  meminfo.DirectMap4k
     53993 ±  3%     -13.9%      46507 ±  5%  meminfo.Shmem
   1482325 ±  2%     -24.4%    1120083        vmstat.system.cs
    150508            -1.5%     148218        vmstat.system.in
      3999 ±  8%     -10.8%       3566 ±  5%  slabinfo.kmalloc-rcl-64.active_objs
      3999 ±  8%     -10.8%       3566 ±  5%  slabinfo.kmalloc-rcl-64.num_objs
     10897           +12.6%      12274 ±  4%  slabinfo.vmap_area.active_objs
     10898           +12.7%      12277 ±  4%  slabinfo.vmap_area.num_objs
 2.208e+08           -20.9%  1.746e+08        cpuidle.C1.usage
   5894730 ± 24%   +7005.1%  4.188e+08 ± 25%  cpuidle.C6.time
     19279 ±  3%   +2594.5%     519470 ± 17%  cpuidle.C6.usage
  35085456 ±  9%     -39.3%   21307532 ±  7%  cpuidle.POLL.time
   4822644 ± 12%     -49.7%    2423791 ±  9%  cpuidle.POLL.usage
     76807            -2.7%      74740        proc-vmstat.nr_active_anon
     13500 ±  3%     -13.8%      11639 ±  5%  proc-vmstat.nr_shmem
     76807            -2.7%      74740        proc-vmstat.nr_zone_active_anon
     15013 ± 91%     -86.2%       2071 ±151%  proc-vmstat.numa_hint_faults
     13589 ±  5%     -15.5%      11476 ± 11%  proc-vmstat.pgactivate
    833769            -2.1%     815970        proc-vmstat.pgfault
    754892            +1.1%     762828        proc-vmstat.pgfree
    152278 ± 42%     -96.3%       5569 ± 23%  sched_debug.cfs_rq:/.min_vruntime.min
   1169341           +30.4%    1524450 ±  7%  sched_debug.cfs_rq:/.min_vruntime.stddev
   1169341           +30.4%    1524462 ±  7%  sched_debug.cfs_rq:/.spread0.stddev
      1.58 ±  6%     +22.0%       1.93 ±  7%  sched_debug.cpu.clock.stddev
      1.58 ±  6%     +22.1%       1.93 ±  7%  sched_debug.cpu.clock_task.stddev
   3098435           -28.6%    2211323 ±  9%  sched_debug.cpu.nr_switches.avg
      1573 ± 16%     -21.6%       1233 ±  9%  sched_debug.cpu.nr_switches.min
     56.75 ± 11%     +18.5%      67.25 ±  4%  sched_debug.cpu.nr_uninterruptible.max
      6543 ±  8%     +16.6%       7631 ±  5%  numa-vmstat.node0.nr_kernel_stack
    574.25 ± 30%     +86.8%       1072 ± 22%  numa-vmstat.node0.nr_page_table_pages
      8042 ± 19%     +23.3%       9919 ± 13%  numa-vmstat.node0.nr_slab_reclaimable
     34409 ± 22%     -56.6%      14946 ± 54%  numa-vmstat.node1.nr_active_anon
     25847 ± 30%     -67.3%       8458 ± 93%  numa-vmstat.node1.nr_anon_pages
      6123 ±  8%     -18.0%       5022 ±  8%  numa-vmstat.node1.nr_kernel_stack
    854.50 ± 19%     -56.5%     372.00 ± 65%  numa-vmstat.node1.nr_page_table_pages
     18421 ±  7%     -17.9%      15125 ±  7%  numa-vmstat.node1.nr_slab_unreclaimable
     34409 ± 22%     -56.6%      14946 ± 54%  numa-vmstat.node1.nr_zone_active_anon
     21046 ± 47%     +55.4%      32703 ± 30%  numa-vmstat.node1.numa_other
     32169 ± 19%     +23.3%      39680 ± 13%  numa-meminfo.node0.KReclaimable
      6543 ±  8%     +16.6%       7630 ±  5%  numa-meminfo.node0.KernelStack
   1001821 ±  9%     +14.4%    1145780 ±  4%  numa-meminfo.node0.MemUsed
      2299 ± 30%     +86.6%       4290 ± 22%  numa-meminfo.node0.PageTables
     32169 ± 19%     +23.3%      39680 ± 13%  numa-meminfo.node0.SReclaimable
    102778 ±  7%     +19.9%     123222 ±  6%  numa-meminfo.node0.Slab
    137587 ± 22%     -56.6%      59688 ± 54%  numa-meminfo.node1.Active
    137493 ± 22%     -56.6%      59648 ± 54%  numa-meminfo.node1.Active(anon)
     52091 ± 42%     -68.4%      16453 ±161%  numa-meminfo.node1.AnonHugePages
    103405 ± 30%     -67.3%      33836 ± 93%  numa-meminfo.node1.AnonPages
      6116 ±  8%     -18.0%       5017 ±  8%  numa-meminfo.node1.KernelStack
   1050635 ±  8%     -13.4%     909860 ±  5%  numa-meminfo.node1.MemUsed
      3416 ± 19%     -56.6%       1483 ± 65%  numa-meminfo.node1.PageTables
     73684 ±  7%     -17.9%      60503 ±  7%  numa-meminfo.node1.SUnreclaim
    108980 ±  7%     -19.1%      88152 ± 10%  numa-meminfo.node1.Slab
     81937 ±  6%     +25.2%     102562 ±  9%  softirqs.CPU16.RCU
     21615 ± 70%    +204.7%      65858 ± 22%  softirqs.CPU16.SCHED
   5010947 ± 28%     -67.3%    1637461 ±148%  softirqs.CPU25.NET_RX
     45054 ±  5%     -21.6%      35310 ± 26%  softirqs.CPU25.SCHED
   4691793 ± 34%     -69.2%    1444457 ±170%  softirqs.CPU26.NET_RX
     48190 ±  9%     -29.8%      33825 ± 34%  softirqs.CPU26.SCHED
   5045331 ± 36%     -77.2%    1148265 ±171%  softirqs.CPU29.NET_RX
     51391 ± 23%     -69.3%      15752 ±133%  softirqs.CPU36.SCHED
     52040 ± 11%     -73.0%      14042 ±111%  softirqs.CPU46.SCHED
     37936 ± 50%     -78.3%       8234 ±104%  softirqs.CPU47.SCHED
     46988 ± 16%     -67.0%      15513 ± 99%  softirqs.CPU52.SCHED
   5967380 ± 30%     -80.4%    1169737 ±173%  softirqs.CPU54.NET_RX
   6170696 ± 42%     -76.1%    1472055 ±173%  softirqs.CPU57.NET_RX
   6718083 ± 40%     -77.3%    1528221 ±173%  softirqs.CPU58.NET_RX
   6397847 ± 27%     -74.5%    1629273 ±173%  softirqs.CPU59.NET_RX
     57352 ±  5%     -35.6%      36922 ± 10%  softirqs.CPU63.SCHED
   4947229 ± 28%     -76.6%    1159904 ±173%  softirqs.CPU64.NET_RX
   4902059 ± 41%     -72.8%    1331256 ±169%  softirqs.CPU68.NET_RX
 3.636e+08           -23.0%  2.799e+08        softirqs.NET_RX
    106.50 ± 96%     -96.7%       3.50 ±125%  interrupts.55:PCI-MSI.31981588-edge.i40e-eth0-TxRx-19
     24013            -1.8%      23590        interrupts.CAL:Function_call_interrupts
     14701 ± 60%     -99.2%     123.75 ± 89%  interrupts.CPU11.RES:Rescheduling_interrupts
    106.00 ± 97%     -97.2%       3.00 ±135%  interrupts.CPU19.55:PCI-MSI.31981588-edge.i40e-eth0-TxRx-19
     23189 ± 24%     -94.6%       1242 ±139%  interrupts.CPU25.RES:Rescheduling_interrupts
     23527 ± 34%     -95.2%       1129 ±152%  interrupts.CPU26.RES:Rescheduling_interrupts
     13122 ± 50%     -98.4%     207.50 ±143%  interrupts.CPU29.RES:Rescheduling_interrupts
     21974 ± 29%     -77.8%       4872 ±172%  interrupts.CPU3.RES:Rescheduling_interrupts
     28365 ± 52%     -79.1%       5941 ±171%  interrupts.CPU36.RES:Rescheduling_interrupts
     27230 ± 58%     -98.1%     518.00 ± 98%  interrupts.CPU46.RES:Rescheduling_interrupts
     21075 ± 63%     -99.0%     205.25 ± 58%  interrupts.CPU47.RES:Rescheduling_interrupts
      6718 ± 19%     -43.9%       3772 ± 63%  interrupts.CPU48.NMI:Non-maskable_interrupts
      6718 ± 19%     -43.9%       3772 ± 63%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
      7806 ± 72%     -73.1%       2100 ±147%  interrupts.CPU52.RES:Rescheduling_interrupts
      7343 ± 23%     -57.7%       3106 ± 96%  interrupts.CPU54.NMI:Non-maskable_interrupts
      7343 ± 23%     -57.7%       3106 ± 96%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
      7679 ± 84%     -98.4%     123.75 ±104%  interrupts.CPU54.RES:Rescheduling_interrupts
     35789 ± 57%     -75.5%       8758 ±173%  interrupts.CPU56.RES:Rescheduling_interrupts
     23882 ± 72%     -94.9%       1212 ±172%  interrupts.CPU57.RES:Rescheduling_interrupts
     21256 ± 72%     -94.7%       1134 ±170%  interrupts.CPU58.RES:Rescheduling_interrupts
     73.50 ±145%     -90.8%       6.75 ± 72%  interrupts.CPU6.TLB:TLB_shootdowns
     32631 ± 47%     -68.2%      10387 ± 72%  interrupts.CPU61.RES:Rescheduling_interrupts
     29653 ± 29%     -81.4%       5518 ±171%  interrupts.CPU62.RES:Rescheduling_interrupts
     25421 ± 21%     -91.3%       2218 ±165%  interrupts.CPU63.RES:Rescheduling_interrupts
     14735 ± 54%     -98.6%     200.50 ±155%  interrupts.CPU64.RES:Rescheduling_interrupts
     11691 ± 85%     -64.2%       4184 ±172%  interrupts.CPU66.RES:Rescheduling_interrupts
      6240 ± 32%     -68.2%       1982 ±140%  interrupts.CPU67.NMI:Non-maskable_interrupts
      6240 ± 32%     -68.2%       1982 ±140%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
      6781 ±120%     -93.8%     423.50 ±145%  interrupts.CPU68.RES:Rescheduling_interrupts
     12981 ± 64%     -98.7%     174.50 ±105%  interrupts.CPU70.RES:Rescheduling_interrupts
     14238 ± 44%     -65.1%       4975 ±168%  interrupts.CPU71.RES:Rescheduling_interrupts
    107.00 ±  5%     -17.1%      88.75 ± 11%  interrupts.IWI:IRQ_work_interrupts
    389189 ±  4%     -31.5%     266460 ±  8%  interrupts.NMI:Non-maskable_interrupts
    389189 ±  4%     -31.5%     266460 ±  8%  interrupts.PMI:Performance_monitoring_interrupts
   1296392 ±  4%     -34.6%     847860 ± 22%  interrupts.RES:Rescheduling_interrupts
      1588 ± 29%     -61.8%     607.25 ± 35%  interrupts.TLB:TLB_shootdowns
     10.18            -4.0%       9.77        perf-stat.i.MPKI
 1.552e+10           -25.5%  1.157e+10        perf-stat.i.branch-instructions
  3.48e+08           -25.2%  2.605e+08        perf-stat.i.branch-misses
      1.52 ± 28%      -1.1        0.43 ± 27%  perf-stat.i.cache-miss-rate%
  11586741 ± 29%     -83.7%    1894187 ± 32%  perf-stat.i.cache-misses
 8.042e+08           -28.5%  5.749e+08        perf-stat.i.cache-references
   1492579 ±  2%     -24.4%    1127729        perf-stat.i.context-switches
      1.22           +23.5%       1.51 ±  2%  perf-stat.i.cpi
 9.616e+10            -7.9%  8.853e+10        perf-stat.i.cpu-cycles
    162.88 ±  9%     +39.8%     227.77 ±  4%  perf-stat.i.cpu-migrations
     10318 ± 43%    +758.6%      88595 ± 30%  perf-stat.i.cycles-between-cache-misses
  10338031           -26.2%    7628495        perf-stat.i.dTLB-load-misses
 2.437e+10           -25.5%  1.815e+10        perf-stat.i.dTLB-loads
      0.00 ±  5%      +0.0        0.00 ±  2%  perf-stat.i.dTLB-store-miss-rate%
     12952 ±  3%     +12.2%      14538 ±  2%  perf-stat.i.dTLB-store-misses
 1.401e+10           -25.6%  1.041e+10        perf-stat.i.dTLB-stores
     49.00           -13.4       35.64 ±  6%  perf-stat.i.iTLB-load-miss-rate%
  11130067 ±  2%     -29.9%    7798895 ±  3%  perf-stat.i.iTLB-load-misses
  11481481           +22.6%   14080265 ±  7%  perf-stat.i.iTLB-loads
 7.868e+10           -25.5%  5.862e+10        perf-stat.i.instructions
      7290 ±  2%      +6.5%       7762        perf-stat.i.instructions-per-iTLB-miss
      0.82           -18.9%       0.66 ±  2%  perf-stat.i.ipc
      2680            -2.2%       2621        perf-stat.i.minor-faults
     95.89            -3.7       92.22        perf-stat.i.node-load-miss-rate%
   1617319 ± 41%     -83.8%     262514 ± 32%  perf-stat.i.node-load-misses
     53805 ± 29%     -57.3%      22960 ± 19%  perf-stat.i.node-loads
     96.01            -7.8       88.18 ±  2%  perf-stat.i.node-store-miss-rate%
    213867 ± 31%     -86.0%      29841 ± 10%  perf-stat.i.node-store-misses
      6788 ±  7%     -22.0%       5294 ± 12%  perf-stat.i.node-stores
      2680            -2.2%       2621        perf-stat.i.page-faults
     10.22            -4.1%       9.81        perf-stat.overall.MPKI
      1.44 ± 29%      -1.1        0.33 ± 32%  perf-stat.overall.cache-miss-rate%
      1.22           +23.6%       1.51 ±  2%  perf-stat.overall.cpi
      9226 ± 34%    +470.3%      52623 ± 35%  perf-stat.overall.cycles-between-cache-misses
      0.00 ±  3%      +0.0        0.00 ±  3%  perf-stat.overall.dTLB-store-miss-rate%
     49.22           -13.5       35.72 ±  6%  perf-stat.overall.iTLB-load-miss-rate%
      7072 ±  2%      +6.3%       7520        perf-stat.overall.instructions-per-iTLB-miss
      0.82           -19.0%       0.66 ±  2%  perf-stat.overall.ipc
     96.27            -4.6       91.64        perf-stat.overall.node-load-miss-rate%
     96.53           -11.8       84.69 ±  3%  perf-stat.overall.node-store-miss-rate%
      9587            +2.7%       9844        perf-stat.overall.path-length
 1.547e+10           -25.5%  1.153e+10        perf-stat.ps.branch-instructions
 3.468e+08           -25.1%  2.596e+08        perf-stat.ps.branch-misses
  11548381 ± 29%     -83.6%    1888636 ± 32%  perf-stat.ps.cache-misses
 8.015e+08           -28.5%   5.73e+08        perf-stat.ps.cache-references
   1487561 ±  2%     -24.4%    1123929        perf-stat.ps.context-switches
 9.583e+10            -7.9%  8.823e+10        perf-stat.ps.cpu-cycles
    162.41 ±  9%     +40.1%     227.57 ±  4%  perf-stat.ps.cpu-migrations
  10302904           -26.2%    7603035        perf-stat.ps.dTLB-load-misses
 2.429e+10           -25.5%  1.809e+10        perf-stat.ps.dTLB-loads
     12914 ±  3%     +12.4%      14511 ±  2%  perf-stat.ps.dTLB-store-misses
 1.396e+10           -25.6%  1.038e+10        perf-stat.ps.dTLB-stores
  11092764 ±  2%     -29.9%    7772733 ±  3%  perf-stat.ps.iTLB-load-misses
  11443703           +22.6%   14033574 ±  7%  perf-stat.ps.iTLB-loads
 7.841e+10           -25.5%  5.843e+10        perf-stat.ps.instructions
      2671            -2.2%       2612        perf-stat.ps.minor-faults
   1611848 ± 41%     -83.8%     261634 ± 32%  perf-stat.ps.node-load-misses
     53714 ± 29%     -57.3%      22938 ± 19%  perf-stat.ps.node-loads
    213258 ± 31%     -86.0%      29755 ± 10%  perf-stat.ps.node-store-misses
      6777 ±  7%     -21.8%       5301 ± 12%  perf-stat.ps.node-stores
      2671            -2.2%       2612        perf-stat.ps.page-faults
 2.365e+13           -25.4%  1.764e+13        perf-stat.total.instructions
     37.98 ±  2%     -20.6       17.33 ±  5%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     38.08 ±  2%     -20.1       17.96 ±  5%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     38.03 ±  2%     -20.1       17.91 ±  5%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     40.82 ±  2%     -19.6       21.26 ±  4%  perf-profile.calltrace.cycles-pp.secondary_startup_64
     40.23 ±  2%     -19.3       20.91 ±  4%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     40.24 ±  2%     -19.3       20.93 ±  4%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
     40.24 ±  2%     -19.3       20.94 ±  4%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
      0.89 ±  3%      +0.1        1.03 ±  2%  perf-profile.calltrace.cycles-pp.skb_release_data.__kfree_skb.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established
      0.62 ±  4%      +0.1        0.77 ±  3%  perf-profile.calltrace.cycles-pp.common_file_perm.security_file_permission.do_sendfile.__x64_sys_sendfile64.do_syscall_64
      0.59 ±  5%      +0.2        0.75 ±  6%  perf-profile.calltrace.cycles-pp.__inet_lookup_established.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver
      0.54 ±  4%      +0.2        0.73 ±  4%  perf-profile.calltrace.cycles-pp.page_cache_pipe_buf_release.__splice_from_pipe.splice_from_pipe.direct_splice_actor.splice_direct_to_actor
      0.42 ± 57%      +0.2        0.62 ±  2%  perf-profile.calltrace.cycles-pp.page_cache_pipe_buf_confirm.__splice_from_pipe.splice_from_pipe.direct_splice_actor.splice_direct_to_actor
      0.58 ±  5%      +0.2        0.80 ±  4%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__sched_text_start.schedule.schedule_timeout.wait_woken
      1.74            +0.2        1.96        perf-profile.calltrace.cycles-pp.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg
      0.57 ±  4%      +0.2        0.79 ±  3%  perf-profile.calltrace.cycles-pp.__release_sock.release_sock.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
      0.68 ±  2%      +0.3        0.94        perf-profile.calltrace.cycles-pp.do_splice_to.splice_direct_to_actor.do_splice_direct.do_sendfile.__x64_sys_sendfile64
      0.63 ±  4%      +0.3        0.89 ±  2%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      0.68 ±  4%      +0.3        0.93 ±  3%  perf-profile.calltrace.cycles-pp.release_sock.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
      1.09 ±  4%      +0.3        1.37        perf-profile.calltrace.cycles-pp.__kfree_skb.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv
      2.04 ±  2%      +0.3        2.31 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64
      0.61 ±  5%      +0.3        0.89        perf-profile.calltrace.cycles-pp.copy_page_to_iter.generic_file_read_iter.generic_file_splice_read.splice_direct_to_actor.do_splice_direct
      0.63 ±  6%      +0.3        0.91 ±  3%  perf-profile.calltrace.cycles-pp.ipv4_mtu.tcp_current_mss.tcp_send_mss.do_tcp_sendpages.tcp_sendpage_locked
      1.91 ±  2%      +0.3        2.19 ±  2%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret
      0.83 ±  4%      +0.3        1.14        perf-profile.calltrace.cycles-pp.security_file_permission.do_sendfile.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.69 ±  2%      +0.3        1.02        perf-profile.calltrace.cycles-pp.__alloc_skb.sk_stream_alloc_skb.do_tcp_sendpages.tcp_sendpage_locked.tcp_sendpage
      2.07 ±  6%      +0.3        2.40 ±  4%  perf-profile.calltrace.cycles-pp.find_get_entry.pagecache_get_page.generic_file_read_iter.generic_file_splice_read.splice_direct_to_actor
      0.72 ±  3%      +0.3        1.06        perf-profile.calltrace.cycles-pp.sk_stream_alloc_skb.do_tcp_sendpages.tcp_sendpage_locked.tcp_sendpage.inet_sendpage
      2.17 ±  6%      +0.4        2.53 ±  3%  perf-profile.calltrace.cycles-pp.pagecache_get_page.generic_file_read_iter.generic_file_splice_read.splice_direct_to_actor.do_splice_direct
      2.04            +0.4        2.41        perf-profile.calltrace.cycles-pp.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg.inet_recvmsg
      0.84 ±  3%      +0.4        1.21 ±  4%  perf-profile.calltrace.cycles-pp.__sched_text_start.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.87 ±  3%      +0.4        1.24 ±  4%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      1.15 ±  3%      +0.4        1.59 ±  3%  perf-profile.calltrace.cycles-pp.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg.inet_recvmsg
      1.03 ±  3%      +0.4        1.48 ±  3%  perf-profile.calltrace.cycles-pp.__sched_text_start.schedule.schedule_timeout.wait_woken.sk_wait_data
      1.06 ±  3%      +0.5        1.52 ±  3%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg
      0.13 ±173%      +0.5        0.60 ±  3%  perf-profile.calltrace.cycles-pp._copy_from_user.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.13 ±173%      +0.5        0.64        perf-profile.calltrace.cycles-pp.security_file_permission.do_splice_to.splice_direct_to_actor.do_splice_direct.do_sendfile
      1.70 ±  4%      +0.5        2.20        perf-profile.calltrace.cycles-pp.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
      1.25 ±  3%      +0.5        1.76 ±  3%  perf-profile.calltrace.cycles-pp.wait_woken.sk_wait_data.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
      1.38 ±  3%      +0.5        1.90 ±  3%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.sock_def_readable.tcp_rcv_established.tcp_v4_do_rcv
      0.00            +0.5        0.53        perf-profile.calltrace.cycles-pp.security_file_permission.do_splice_direct.do_sendfile.__x64_sys_sendfile64.do_syscall_64
      0.00            +0.5        0.53 ±  2%  perf-profile.calltrace.cycles-pp.__x86_indirect_thunk_rax
      3.01 ±  2%      +0.5        3.55        perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
      0.00            +0.5        0.54 ±  4%  perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock.tcp_recvmsg
      1.50 ±  3%      +0.5        2.04 ±  3%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.sock_def_readable.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
      1.25            +0.6        1.81 ±  2%  perf-profile.calltrace.cycles-pp.tcp_current_mss.tcp_send_mss.do_tcp_sendpages.tcp_sendpage_locked.tcp_sendpage
      0.00            +0.6        0.56 ±  4%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry.start_secondary
      0.13 ±173%      +0.6        0.69 ±  5%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__sched_text_start.schedule.schedule_timeout
      1.60 ±  3%      +0.6        2.16 ±  3%  perf-profile.calltrace.cycles-pp.sock_def_readable.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      0.00            +0.6        0.57 ±  3%  perf-profile.calltrace.cycles-pp.fsnotify.do_sendfile.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.15 ±  2%      +0.6        3.74        perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg
      1.20 ± 21%      +0.6        1.78 ±  3%  perf-profile.calltrace.cycles-pp.try_to_wake_up.__wake_up_common.__wake_up_common_lock.sock_def_readable.tcp_rcv_established
      1.66 ±  3%      +0.6        2.26 ±  3%  perf-profile.calltrace.cycles-pp.sk_wait_data.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
      0.00            +0.6        0.60 ±  2%  perf-profile.calltrace.cycles-pp.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_output
      0.00            +0.6        0.61 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_bh.release_sock.tcp_sendpage.inet_sendpage.kernel_sendpage
      0.00            +0.6        0.62 ± 13%  perf-profile.calltrace.cycles-pp.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      1.41            +0.6        2.03 ±  2%  perf-profile.calltrace.cycles-pp.tcp_send_mss.do_tcp_sendpages.tcp_sendpage_locked.tcp_sendpage.inet_sendpage
      0.00            +0.6        0.64 ±  4%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__sched_text_start.schedule_idle.do_idle.cpu_startup_entry
      0.00            +0.7        0.68 ±  3%  perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.__release_sock.release_sock.tcp_recvmsg.inet_recvmsg
      1.30 ±  8%      +0.7        2.00 ±  9%  perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendpage
      1.82 ±  2%      +0.7        2.52        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.do_tcp_sendpages
      2.09 ±  4%      +0.7        2.79        perf-profile.calltrace.cycles-pp.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      1.33 ±  9%      +0.7        2.04 ±  9%  perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendpage.inet_sendpage
      0.98 ± 28%      +0.7        1.73        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb
      2.00            +0.8        2.77        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.do_tcp_sendpages.tcp_sendpage_locked
      3.62 ±  3%      +0.8        4.41        perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg.inet_recvmsg
      1.57 ±  9%      +0.8        2.37 ±  9%  perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.__release_sock
      1.57 ±  9%      +0.8        2.38 ±  9%  perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock
      0.00            +0.9        0.90 ± 29%  perf-profile.calltrace.cycles-pp.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_output.__ip_queue_xmit
      2.21 ±  9%      +1.1        3.30 ±  9%  perf-profile.calltrace.cycles-pp.__release_sock.release_sock.tcp_sendpage.inet_sendpage.kernel_sendpage
      2.56 ±  4%      +1.1        3.65        perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
      2.33 ±  3%      +1.1        3.43 ±  5%  perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established
      2.57 ±  4%      +1.1        3.68        perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      4.25 ±  2%      +1.1        5.36        perf-profile.calltrace.cycles-pp.generic_file_read_iter.generic_file_splice_read.splice_direct_to_actor.do_splice_direct.do_sendfile
      3.06 ±  2%      +1.2        4.27        perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.do_tcp_sendpages.tcp_sendpage_locked.tcp_sendpage
      3.09            +1.2        4.32        perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.do_tcp_sendpages.tcp_sendpage_locked.tcp_sendpage.inet_sendpage
      3.83 ±  4%      +1.4        5.18 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_bh.lock_sock_nested.tcp_sendpage.inet_sendpage
      6.54 ±  2%      +1.4        7.91        perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
      6.57 ±  2%      +1.4        7.96        perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
      2.85 ±  7%      +1.4        4.27 ±  7%  perf-profile.calltrace.cycles-pp.release_sock.tcp_sendpage.inet_sendpage.kernel_sendpage.sock_sendpage
      4.88 ±  2%      +1.5        6.33        perf-profile.calltrace.cycles-pp.generic_file_splice_read.splice_direct_to_actor.do_splice_direct.do_sendfile.__x64_sys_sendfile64
      3.58            +1.5        5.04 ±  2%  perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit
      4.26 ±  3%      +1.5        5.76 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_bh.lock_sock_nested.tcp_sendpage.inet_sendpage.kernel_sendpage
      3.34            +1.5        4.88 ±  4%  perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv
      3.74            +1.6        5.38 ±  2%  perf-profile.calltrace.cycles-pp.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames
      4.67 ±  4%      +1.7        6.36 ±  2%  perf-profile.calltrace.cycles-pp.lock_sock_nested.tcp_sendpage.inet_sendpage.kernel_sendpage.sock_sendpage
      7.08            +2.7        9.80        perf-profile.calltrace.cycles-pp.do_tcp_sendpages.tcp_sendpage_locked.tcp_sendpage.inet_sendpage.kernel_sendpage
      7.22 ±  2%      +2.7        9.96        perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      7.26 ±  2%      +2.8       10.01        perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver
      7.66            +2.8       10.47        perf-profile.calltrace.cycles-pp.tcp_sendpage_locked.tcp_sendpage.inet_sendpage.kernel_sendpage.sock_sendpage
      8.00 ±  2%      +3.2       11.16        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
      8.20 ±  2%      +3.3       11.50        perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg
      8.45 ±  2%      +3.3       11.79        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
      8.32 ±  2%      +3.3       11.65        perf-profile.calltrace.cycles-pp.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg.inet_recvmsg
      9.22            +3.5       12.69        perf-profile.calltrace.cycles-pp.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver.ip_rcv
      9.33            +3.5       12.84        perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core
      9.37            +3.5       12.90        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core.process_backlog
      9.48            +3.6       13.05        perf-profile.calltrace.cycles-pp.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core.process_backlog.net_rx_action
      9.67            +3.7       13.39        perf-profile.calltrace.cycles-pp.ip_rcv.__netif_receive_skb_one_core.process_backlog.net_rx_action.__softirqentry_text_start
      9.87            +3.9       13.76        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.net_rx_action.__softirqentry_text_start.do_softirq_own_stack
     10.15            +4.0       14.14        perf-profile.calltrace.cycles-pp.process_backlog.net_rx_action.__softirqentry_text_start.do_softirq_own_stack.do_softirq
     10.35            +4.1       14.43        perf-profile.calltrace.cycles-pp.net_rx_action.__softirqentry_text_start.do_softirq_own_stack.do_softirq.__local_bh_enable_ip
     10.48            +4.2       14.65        perf-profile.calltrace.cycles-pp.do_softirq_own_stack.do_softirq.__local_bh_enable_ip.ip_finish_output2.ip_output
     10.46            +4.2       14.64        perf-profile.calltrace.cycles-pp.__softirqentry_text_start.do_softirq_own_stack.do_softirq.__local_bh_enable_ip.ip_finish_output2
     10.55            +4.2       14.76        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.ip_finish_output2.ip_output.__ip_queue_xmit
     10.55            +4.2       14.78        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb
     15.87 ±  2%      +6.1       21.99 ±  2%  perf-profile.calltrace.cycles-pp.tcp_sendpage.inet_sendpage.kernel_sendpage.sock_sendpage.pipe_to_sendpage
     16.60 ±  2%      +6.3       22.89 ±  2%  perf-profile.calltrace.cycles-pp.inet_sendpage.kernel_sendpage.sock_sendpage.pipe_to_sendpage.__splice_from_pipe
     16.70 ±  2%      +6.4       23.05 ±  2%  perf-profile.calltrace.cycles-pp.kernel_sendpage.sock_sendpage.pipe_to_sendpage.__splice_from_pipe.splice_from_pipe
     17.05 ±  2%      +6.4       23.46 ±  2%  perf-profile.calltrace.cycles-pp.sock_sendpage.pipe_to_sendpage.__splice_from_pipe.splice_from_pipe.direct_splice_actor
     17.48 ±  2%      +6.5       24.01 ±  2%  perf-profile.calltrace.cycles-pp.pipe_to_sendpage.__splice_from_pipe.splice_from_pipe.direct_splice_actor.splice_direct_to_actor
     20.28            +6.8       27.05        perf-profile.calltrace.cycles-pp.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
     20.33            +6.8       27.13        perf-profile.calltrace.cycles-pp.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.76            +6.9       27.67        perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.80            +6.9       27.72        perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
     19.00 ±  2%      +7.0       26.05 ±  2%  perf-profile.calltrace.cycles-pp.__splice_from_pipe.splice_from_pipe.direct_splice_actor.splice_direct_to_actor.do_splice_direct
     19.36 ±  2%      +7.1       26.49 ±  2%  perf-profile.calltrace.cycles-pp.splice_from_pipe.direct_splice_actor.splice_direct_to_actor.do_splice_direct.do_sendfile
     19.67 ±  2%      +7.3       26.97 ±  2%  perf-profile.calltrace.cycles-pp.direct_splice_actor.splice_direct_to_actor.do_splice_direct.do_sendfile.__x64_sys_sendfile64
     25.77 ±  2%      +9.3       35.08        perf-profile.calltrace.cycles-pp.splice_direct_to_actor.do_splice_direct.do_sendfile.__x64_sys_sendfile64.do_syscall_64
     26.29 ±  2%      +9.5       35.75        perf-profile.calltrace.cycles-pp.do_splice_direct.do_sendfile.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe
     28.65 ±  2%     +10.4       39.06        perf-profile.calltrace.cycles-pp.do_sendfile.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe
     29.77 ±  2%     +10.7       40.51        perf-profile.calltrace.cycles-pp.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe
     54.03           +18.5       72.54        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     54.22           +18.5       72.75        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     37.98 ±  2%     -20.6       17.34 ±  5%  perf-profile.children.cycles-pp.intel_idle
     38.62 ±  2%     -20.4       18.26 ±  5%  perf-profile.children.cycles-pp.cpuidle_enter
     38.62 ±  2%     -20.4       18.26 ±  5%  perf-profile.children.cycles-pp.cpuidle_enter_state
     40.82 ±  2%     -19.6       21.26 ±  4%  perf-profile.children.cycles-pp.secondary_startup_64
     40.82 ±  2%     -19.6       21.26 ±  4%  perf-profile.children.cycles-pp.cpu_startup_entry
     40.82 ±  2%     -19.6       21.26 ±  4%  perf-profile.children.cycles-pp.do_idle
     40.24 ±  2%     -19.3       20.94 ±  4%  perf-profile.children.cycles-pp.start_secondary
      0.05            +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.08            +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.tcp_update_skb_after_send
      0.11 ±  3%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.07 ±  6%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.05            +0.0        0.07 ± 12%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.06 ±  7%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.rb_next
      0.07 ± 10%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.10 ± 10%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.09 ±  5%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.16 ±  6%      +0.0        0.18 ±  4%  perf-profile.children.cycles-pp.tcp_check_space
      0.05 ±  9%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__x86_indirect_thunk_r14
      0.11 ±  8%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.rcu_idle_exit
      0.06 ±  6%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.pick_next_entity
      0.09 ±  7%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.sock_rfree
      0.05 ±  8%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.tcp_tx_timestamp
      0.12 ±  7%      +0.0        0.14 ±  5%  perf-profile.children.cycles-pp.remove_wait_queue
      0.11 ± 11%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.native_write_msr
      0.20 ±  2%      +0.0        0.22 ±  3%  perf-profile.children.cycles-pp.copy_user_generic_unrolled
      0.05 ±  9%      +0.0        0.08 ±  8%  perf-profile.children.cycles-pp.tcp_recv_timestamp
      0.23 ±  2%      +0.0        0.25 ±  6%  perf-profile.children.cycles-pp.ip_send_check
      0.08 ±  5%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.__x86_indirect_thunk_r10
      0.07 ±  6%      +0.0        0.10 ±  9%  perf-profile.children.cycles-pp.cpus_share_cache
      0.11 ±  4%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.check_stack_object
      0.09 ±  8%      +0.0        0.12 ± 10%  perf-profile.children.cycles-pp.update_cfs_group
      0.07 ±  5%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.finish_task_switch
      0.18 ±  4%      +0.0        0.21 ±  5%  perf-profile.children.cycles-pp.generic_splice_sendpage
      0.12            +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.aa_sk_perm
      0.12 ±  4%      +0.0        0.16 ±  2%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.11 ±  8%      +0.0        0.14 ±  6%  perf-profile.children.cycles-pp.update_ts_time_stats
      0.10 ±  8%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.sched_clock
      0.06            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.tcp_event_data_recv
      0.04 ± 57%      +0.0        0.07        perf-profile.children.cycles-pp.task_tick_fair
      0.04 ± 58%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.bictcp_acked
      0.10 ±  7%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.native_sched_clock
      0.08 ±  8%      +0.0        0.12 ±  7%  perf-profile.children.cycles-pp.check_preempt_curr
      0.05 ±  8%      +0.0        0.09 ±  9%  perf-profile.children.cycles-pp.fpregs_assert_state_consistent
      0.05            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.kfree_skbmem
      0.06 ±  9%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.__copy_skb_header
      0.16 ±  2%      +0.0        0.20 ±  3%  perf-profile.children.cycles-pp.tcp_wfree
      0.14 ±  3%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.sockfd_lookup_light
      0.06            +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.newidle_balance
      0.11 ±  7%      +0.0        0.15 ±  6%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.15 ±  3%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.sock_recvmsg
      0.07            +0.0        0.11        perf-profile.children.cycles-pp.inet_ehashfn
      0.07 ± 11%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.tcp_update_pacing_rate
      0.03 ±100%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.tcp_chrono_stop
      0.13 ±  3%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.security_socket_recvmsg
      0.10 ±  5%      +0.0        0.14 ±  6%  perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.18 ±  4%      +0.0        0.22 ±  3%  perf-profile.children.cycles-pp.inet_send_prepare
      0.06 ±  9%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.tcp_push
      0.22 ±  3%      +0.0        0.26 ±  3%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.12 ±  4%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.__switch_to_asm
      0.09 ±  7%      +0.0        0.13 ±  6%  perf-profile.children.cycles-pp.__tcp_select_window
      0.21 ±  4%      +0.0        0.26 ±  4%  perf-profile.children.cycles-pp.tcp_rcv_space_adjust
      0.07 ± 10%      +0.0        0.12 ±  9%  perf-profile.children.cycles-pp.netif_skb_features
      0.01 ±173%      +0.0        0.06 ± 14%  perf-profile.children.cycles-pp.raw_local_deliver
      0.21 ±  6%      +0.0        0.26 ±  6%  perf-profile.children.cycles-pp.__put_user_8
      0.05 ±  8%      +0.0        0.10        perf-profile.children.cycles-pp.___perf_sw_event
      0.32 ±  3%      +0.0        0.36        perf-profile.children.cycles-pp.tcp_rate_check_app_limited
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.default_wake_function
      0.08 ± 10%      +0.1        0.13 ±  9%  perf-profile.children.cycles-pp.sanity
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.tcp_v4_inbound_md5_hash
      0.03 ±100%      +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.ip_queue_xmit
      0.21 ±  3%      +0.1        0.26 ±  3%  perf-profile.children.cycles-pp.aa_file_perm
      0.15 ±  5%      +0.1        0.20 ±  5%  perf-profile.children.cycles-pp.__switch_to
      0.15 ±  3%      +0.1        0.20 ±  7%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.iov_iter_pipe
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.__usecs_to_jiffies
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.bictcp_cong_avoid
      0.07 ±  6%      +0.1        0.12 ± 11%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.01 ±173%      +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.resched_curr
      0.15 ±  9%      +0.1        0.21 ±  3%  perf-profile.children.cycles-pp.rcu_all_qs
      0.09 ±  7%      +0.1        0.15 ± 12%  perf-profile.children.cycles-pp._find_next_bit
      0.07 ± 12%      +0.1        0.13 ±  6%  perf-profile.children.cycles-pp.kfree
      0.07 ±  7%      +0.1        0.12 ±  6%  perf-profile.children.cycles-pp.tcp_ack_update_rtt
      0.04 ± 57%      +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.apparmor_ipv4_postroute
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.tcp_v4_fill_cb
      0.00            +0.1        0.06        perf-profile.children.cycles-pp._raw_spin_unlock_bh
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.tcp_options_write
      0.08 ± 10%      +0.1        0.14 ± 10%  perf-profile.children.cycles-pp.scheduler_tick
      0.26            +0.1        0.32 ±  4%  perf-profile.children.cycles-pp.__ip_local_out
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.eth_type_trans
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.rcu_eqs_enter
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.tcp_stream_memory_free
      0.28            +0.1        0.34 ±  5%  perf-profile.children.cycles-pp.ip_local_out
      0.07 ± 10%      +0.1        0.14 ±  8%  perf-profile.children.cycles-pp.ip_rcv_finish
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.ksoftirqd_running
      0.11 ±  4%      +0.1        0.17 ±  6%  perf-profile.children.cycles-pp.tcp_v4_send_check
      0.35            +0.1        0.42 ±  5%  perf-profile.children.cycles-pp.__ksize
      0.12 ±  7%      +0.1        0.18 ±  6%  perf-profile.children.cycles-pp.validate_xmit_skb
      0.09 ±  4%      +0.1        0.16 ±  5%  perf-profile.children.cycles-pp.skb_entail
      0.24 ±  2%      +0.1        0.32 ±  4%  perf-profile.children.cycles-pp.__sk_dst_check
      0.20 ±  5%      +0.1        0.27 ±  4%  perf-profile.children.cycles-pp.sock_put
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.put_prev_task_fair
      0.00            +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.account_entity_dequeue
      0.09            +0.1        0.16 ±  7%  perf-profile.children.cycles-pp.ip_rcv_core
      0.42            +0.1        0.49 ±  3%  perf-profile.children.cycles-pp.skb_release_head_state
      0.24 ±  4%      +0.1        0.31 ±  2%  perf-profile.children.cycles-pp.rw_verify_area
      0.21 ±  2%      +0.1        0.28 ±  3%  perf-profile.children.cycles-pp.ipv4_dst_check
      0.44            +0.1        0.51 ±  3%  perf-profile.children.cycles-pp.skb_release_all
      0.04 ± 57%      +0.1        0.11 ±  7%  perf-profile.children.cycles-pp.tcp_rearm_rto
      0.01 ±173%      +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.ip_rcv_finish_core
      0.23 ±  6%      +0.1        0.30 ±  2%  perf-profile.children.cycles-pp.update_curr
      0.00            +0.1        0.08 ± 11%  perf-profile.children.cycles-pp.__tcp_ack_snd_check
      0.17 ±  7%      +0.1        0.25 ±  5%  perf-profile.children.cycles-pp.skb_clone
      0.11 ± 17%      +0.1        0.19 ±  3%  perf-profile.children.cycles-pp.xas_start
      0.17 ±  4%      +0.1        0.25 ±  5%  perf-profile.children.cycles-pp.kmem_cache_free
      0.00            +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.tcp_rack_advance
      0.55 ±  4%      +0.1        0.64 ±  2%  perf-profile.children.cycles-pp.page_cache_pipe_buf_confirm
      0.12 ±  4%      +0.1        0.21 ±  3%  perf-profile.children.cycles-pp.timestamp_truncate
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.rb_first
      0.30 ±  8%      +0.1        0.39 ±  2%  perf-profile.children.cycles-pp._cond_resched
      0.16 ±  2%      +0.1        0.25 ±  7%  perf-profile.children.cycles-pp.tcp_add_backlog
      0.17 ±  4%      +0.1        0.26 ±  9%  perf-profile.children.cycles-pp.__next_timer_interrupt
      0.38            +0.1        0.47 ±  5%  perf-profile.children.cycles-pp.__skb_clone
      0.17 ±  2%      +0.1        0.26 ±  4%  perf-profile.children.cycles-pp.ktime_get_with_offset
      0.12 ±  4%      +0.1        0.22 ± 11%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.tcp_cleanup_rbuf
      0.11 ±  6%      +0.1        0.20 ±  7%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.00            +0.1        0.10 ± 11%  perf-profile.children.cycles-pp.apparmor_socket_sock_rcv_skb
      0.37            +0.1        0.47 ±  3%  perf-profile.children.cycles-pp.dst_release
      0.25 ±  3%      +0.1        0.35 ±  2%  perf-profile.children.cycles-pp.enqueue_to_backlog
      0.17 ±  6%      +0.1        0.28 ±  3%  perf-profile.children.cycles-pp.__ip_finish_output
      0.11 ±  6%      +0.1        0.22 ±  8%  perf-profile.children.cycles-pp.nf_hook_slow
      0.36 ±  3%      +0.1        0.47 ±  4%  perf-profile.children.cycles-pp.set_next_entity
      0.20 ±  2%      +0.1        0.31 ±  4%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
      0.12 ±  5%      +0.1        0.23 ±  4%  perf-profile.children.cycles-pp.update_process_times
      0.00            +0.1        0.11 ± 15%  perf-profile.children.cycles-pp.rcu_core
      0.04 ± 57%      +0.1        0.15 ± 13%  perf-profile.children.cycles-pp.security_sock_rcv_skb
      0.26 ±  4%      +0.1        0.38 ±  6%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.49 ±  3%      +0.1        0.61 ±  3%  perf-profile.children.cycles-pp._copy_from_user
      0.12 ±  5%      +0.1        0.24 ±  5%  perf-profile.children.cycles-pp.tick_sched_handle
      0.27 ±  8%      +0.1        0.39        perf-profile.children.cycles-pp.xas_load
      0.24 ±  8%      +0.1        0.37 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.21 ±  2%      +0.1        0.34        perf-profile.children.cycles-pp.tcp_schedule_loss_probe
      0.48 ±  4%      +0.1        0.60        perf-profile.children.cycles-pp.__fget_light
      0.21 ±  3%      +0.1        0.34 ±  5%  perf-profile.children.cycles-pp.__kmalloc_node_track_caller
      0.23 ±  3%      +0.1        0.36 ±  6%  perf-profile.children.cycles-pp.__kmalloc_reserve
      0.32 ±  3%      +0.1        0.46 ±  6%  perf-profile.children.cycles-pp.__tcp_send_ack
      0.32 ±  4%      +0.1        0.45 ±  5%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.10 ± 11%      +0.1        0.24 ±  8%  perf-profile.children.cycles-pp.sk_filter_trim_cap
      0.18 ± 10%      +0.1        0.32 ±  2%  perf-profile.children.cycles-pp.__netif_receive_skb_core
      0.12 ± 10%      +0.1        0.27 ± 14%  perf-profile.children.cycles-pp.clockevents_program_event
      0.53            +0.1        0.68        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.31 ±  3%      +0.1        0.45 ±  4%  perf-profile.children.cycles-pp.tcp_established_options
      0.14 ±  5%      +0.1        0.29 ±  5%  perf-profile.children.cycles-pp.tick_sched_timer
      0.10 ±  4%      +0.1        0.25 ±  5%  perf-profile.children.cycles-pp.tcp_release_cb
      0.35 ±  2%      +0.2        0.50        perf-profile.children.cycles-pp.__might_sleep
      0.30 ±  8%      +0.2        0.45 ±  7%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.34 ±  2%      +0.2        0.50 ±  6%  perf-profile.children.cycles-pp.tcp_mstamp_refresh
      0.41 ±  5%      +0.2        0.57 ±  4%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.29 ±  2%      +0.2        0.46        perf-profile.children.cycles-pp.__fsnotify_parent
      0.26 ±  2%      +0.2        0.43 ±  4%  perf-profile.children.cycles-pp.__slab_free
      0.34 ±  5%      +0.2        0.52 ±  2%  perf-profile.children.cycles-pp.mod_timer
      0.08 ± 13%      +0.2        0.26 ± 15%  perf-profile.children.cycles-pp.irq_exit
      0.18 ±  8%      +0.2        0.36 ±  3%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.33 ±  4%      +0.2        0.51 ±  4%  perf-profile.children.cycles-pp.current_time
      0.35 ±  5%      +0.2        0.54 ±  2%  perf-profile.children.cycles-pp.sk_reset_timer
      0.55 ±  4%      +0.2        0.73 ±  4%  perf-profile.children.cycles-pp.page_cache_pipe_buf_release
      0.31 ±  6%      +0.2        0.51 ±  2%  perf-profile.children.cycles-pp.tcp_event_new_data_sent
      0.78 ±  4%      +0.2        0.97 ±  3%  perf-profile.children.cycles-pp.__inet_lookup_established
      1.16            +0.2        1.37 ±  2%  perf-profile.children.cycles-pp.skb_release_data
      0.44            +0.2        0.65        perf-profile.children.cycles-pp.netif_rx_internal
      0.45 ±  2%      +0.2        0.66 ±  2%  perf-profile.children.cycles-pp.netif_rx
      0.48 ±  5%      +0.2        0.70 ±  5%  perf-profile.children.cycles-pp.dequeue_entity
      0.48 ±  3%      +0.2        0.70 ±  3%  perf-profile.children.cycles-pp.__might_fault
      0.59 ±  5%      +0.2        0.81 ±  3%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.76            +0.2        0.99 ±  4%  perf-profile.children.cycles-pp.read_tsc
      0.53 ±  2%      +0.2        0.76 ±  4%  perf-profile.children.cycles-pp.pick_next_task_fair
      1.77            +0.2        2.00        perf-profile.children.cycles-pp.__check_object_size
      0.48 ±  4%      +0.2        0.72 ±  3%  perf-profile.children.cycles-pp.enqueue_entity
      1.24 ±  4%      +0.2        1.48        perf-profile.children.cycles-pp.common_file_perm
      0.69 ±  2%      +0.2        0.94        perf-profile.children.cycles-pp.do_splice_to
      0.65 ±  5%      +0.3        0.90 ±  2%  perf-profile.children.cycles-pp.menu_select
      0.49 ±  5%      +0.3        0.76 ±  2%  perf-profile.children.cycles-pp.fsnotify
      0.62 ±  5%      +0.3        0.90        perf-profile.children.cycles-pp.copy_page_to_iter
      0.63 ±  2%      +0.3        0.90        perf-profile.children.cycles-pp._raw_spin_lock
      2.04 ±  2%      +0.3        2.32 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.42 ± 10%      +0.3        0.71 ± 10%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.44 ±  4%      +0.3        0.74 ±  4%  perf-profile.children.cycles-pp.update_load_avg
      0.89 ±  2%      +0.3        1.20        perf-profile.children.cycles-pp.___might_sleep
      0.57 ±  3%      +0.3        0.90 ±  4%  perf-profile.children.cycles-pp.enqueue_task_fair
      2.17 ±  2%      +0.3        2.49        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.58 ±  3%      +0.3        0.93 ±  3%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.58 ±  3%      +0.3        0.92 ±  3%  perf-profile.children.cycles-pp.activate_task
      0.53 ±  4%      +0.3        0.87 ±  2%  perf-profile.children.cycles-pp.atime_needs_update
      0.72 ±  2%      +0.3        1.07        perf-profile.children.cycles-pp.sk_stream_alloc_skb
      2.08 ±  6%      +0.3        2.42 ±  4%  perf-profile.children.cycles-pp.find_get_entry
      0.77 ±  6%      +0.4        1.13 ±  3%  perf-profile.children.cycles-pp.ipv4_mtu
      2.06            +0.4        2.42        perf-profile.children.cycles-pp.simple_copy_to_iter
      2.19 ±  6%      +0.4        2.55 ±  3%  perf-profile.children.cycles-pp.pagecache_get_page
      0.88 ±  3%      +0.4        1.25 ±  3%  perf-profile.children.cycles-pp.schedule_idle
      0.96 ±  2%      +0.4        1.37        perf-profile.children.cycles-pp.loopback_xmit
      1.16 ±  3%      +0.4        1.59 ±  3%  perf-profile.children.cycles-pp.schedule_timeout
      1.01 ±  2%      +0.4        1.46        perf-profile.children.cycles-pp.dev_hard_start_xmit
      0.98            +0.4        1.43 ±  2%  perf-profile.children.cycles-pp.__alloc_skb
      0.66 ±  4%      +0.5        1.12 ±  2%  perf-profile.children.cycles-pp.touch_atime
      1.06 ±  3%      +0.5        1.52 ±  3%  perf-profile.children.cycles-pp.schedule
      1.32 ±  3%      +0.5        1.78 ±  3%  perf-profile.children.cycles-pp.try_to_wake_up
      0.98 ±  2%      +0.5        1.45        perf-profile.children.cycles-pp.ktime_get
      1.84            +0.5        2.31 ±  2%  perf-profile.children.cycles-pp.__kfree_skb
      0.77 ±  2%      +0.5        1.25        perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.56 ± 11%      +0.5        1.04 ±  7%  perf-profile.children.cycles-pp.smp_apic_timer_interrupt
      0.65 ± 12%      +0.5        1.12 ±  6%  perf-profile.children.cycles-pp.apic_timer_interrupt
      1.25 ±  3%      +0.5        1.76 ±  3%  perf-profile.children.cycles-pp.wait_woken
      1.38 ±  3%      +0.5        1.91 ±  3%  perf-profile.children.cycles-pp.__wake_up_common
      1.49 ±  3%      +0.6        2.04 ±  2%  perf-profile.children.cycles-pp.__wake_up_common_lock
      1.77 ±  3%      +0.6        2.33        perf-profile.children.cycles-pp.security_file_permission
      3.19 ±  2%      +0.6        3.78        perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      1.66 ±  3%      +0.6        2.25 ±  2%  perf-profile.children.cycles-pp.sock_def_readable
      3.17 ±  2%      +0.6        3.75        perf-profile.children.cycles-pp.copyout
      1.67 ±  3%      +0.6        2.27 ±  3%  perf-profile.children.cycles-pp.sk_wait_data
      1.36            +0.6        1.97 ±  2%  perf-profile.children.cycles-pp.tcp_current_mss
      1.41            +0.6        2.05 ±  2%  perf-profile.children.cycles-pp.tcp_send_mss
      2.01 ±  2%      +0.7        2.66 ±  2%  perf-profile.children.cycles-pp.tcp_clean_rtx_queue
      1.54 ±  2%      +0.7        2.21        perf-profile.children.cycles-pp.__dev_queue_xmit
      3.65 ±  3%      +0.8        4.44        perf-profile.children.cycles-pp._copy_to_iter
      1.91 ±  3%      +0.8        2.73 ±  3%  perf-profile.children.cycles-pp.__sched_text_start
      2.45 ±  2%      +0.9        3.35 ±  2%  perf-profile.children.cycles-pp.tcp_ack
      4.28 ±  2%      +1.1        5.41        perf-profile.children.cycles-pp.generic_file_read_iter
      2.78 ±  7%      +1.3        4.10 ±  7%  perf-profile.children.cycles-pp.__release_sock
      6.55 ±  2%      +1.4        7.93        perf-profile.children.cycles-pp.__skb_datagram_iter
      6.57 ±  2%      +1.4        7.96        perf-profile.children.cycles-pp.skb_copy_datagram_iter
      3.92 ±  4%      +1.4        5.33 ±  3%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      4.88 ±  2%      +1.5        6.34        perf-profile.children.cycles-pp.generic_file_splice_read
      3.58 ±  6%      +1.7        5.26 ±  6%  perf-profile.children.cycles-pp.release_sock
      4.98 ±  3%      +1.7        6.70 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_bh
      4.96 ±  3%      +1.8        6.72 ±  2%  perf-profile.children.cycles-pp.lock_sock_nested
      7.11            +2.7        9.84        perf-profile.children.cycles-pp.do_tcp_sendpages
      7.67            +2.8       10.50        perf-profile.children.cycles-pp.tcp_sendpage_locked
      7.20            +3.1       10.33 ±  2%  perf-profile.children.cycles-pp.tcp_write_xmit
      7.25            +3.1       10.39 ±  2%  perf-profile.children.cycles-pp.__tcp_push_pending_frames
      9.24            +3.5       12.71        perf-profile.children.cycles-pp.tcp_v4_rcv
      9.33            +3.5       12.84        perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
      9.37            +3.5       12.90        perf-profile.children.cycles-pp.ip_local_deliver_finish
      9.49            +3.6       13.07        perf-profile.children.cycles-pp.ip_local_deliver
      8.91            +3.6       12.53 ±  2%  perf-profile.children.cycles-pp.tcp_rcv_established
      9.07            +3.7       12.73 ±  2%  perf-profile.children.cycles-pp.tcp_v4_do_rcv
      9.67            +3.7       13.41        perf-profile.children.cycles-pp.ip_rcv
      9.88            +3.9       13.77        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
     10.16            +4.0       14.16        perf-profile.children.cycles-pp.process_backlog
     10.36            +4.1       14.44        perf-profile.children.cycles-pp.net_rx_action
     10.48            +4.2       14.66        perf-profile.children.cycles-pp.do_softirq_own_stack
     10.56            +4.2       14.79        perf-profile.children.cycles-pp.do_softirq
     10.52            +4.3       14.84        perf-profile.children.cycles-pp.__softirqentry_text_start
     10.80            +4.3       15.14        perf-profile.children.cycles-pp.__local_bh_enable_ip
     11.79            +4.8       16.56        perf-profile.children.cycles-pp.ip_finish_output2
     12.06            +5.0       17.04        perf-profile.children.cycles-pp.ip_output
     12.61            +5.1       17.74        perf-profile.children.cycles-pp.__ip_queue_xmit
     13.35            +5.5       18.82        perf-profile.children.cycles-pp.__tcp_transmit_skb
     15.91 ±  2%      +6.1       22.05 ±  2%  perf-profile.children.cycles-pp.tcp_sendpage
     16.62 ±  2%      +6.3       22.92 ±  2%  perf-profile.children.cycles-pp.inet_sendpage
     16.71 ±  2%      +6.4       23.07 ±  2%  perf-profile.children.cycles-pp.kernel_sendpage
     17.06 ±  2%      +6.4       23.48 ±  2%  perf-profile.children.cycles-pp.sock_sendpage
     17.48 ±  2%      +6.5       24.02 ±  2%  perf-profile.children.cycles-pp.pipe_to_sendpage
     20.29            +6.8       27.07        perf-profile.children.cycles-pp.tcp_recvmsg
     20.33            +6.8       27.13        perf-profile.children.cycles-pp.inet_recvmsg
     20.76            +6.9       27.67        perf-profile.children.cycles-pp.__sys_recvfrom
     20.81            +6.9       27.73        perf-profile.children.cycles-pp.__x64_sys_recvfrom
     19.04 ±  2%      +7.1       26.10 ±  2%  perf-profile.children.cycles-pp.__splice_from_pipe
     19.37 ±  2%      +7.1       26.51 ±  2%  perf-profile.children.cycles-pp.splice_from_pipe
     19.68 ±  2%      +7.3       26.97 ±  2%  perf-profile.children.cycles-pp.direct_splice_actor
     25.77 ±  2%      +9.3       35.09        perf-profile.children.cycles-pp.splice_direct_to_actor
     26.31 ±  2%      +9.5       35.77        perf-profile.children.cycles-pp.do_splice_direct
     28.69 ±  2%     +10.4       39.12        perf-profile.children.cycles-pp.do_sendfile
     29.79 ±  2%     +10.7       40.54        perf-profile.children.cycles-pp.__x64_sys_sendfile64
     54.10           +18.5       72.61        perf-profile.children.cycles-pp.do_syscall_64
     54.27           +18.5       72.80        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     37.98 ±  2%     -20.6       17.34 ±  5%  perf-profile.self.cycles-pp.intel_idle
      0.10 ±  4%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.schedule_timeout
      0.09            +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.check_stack_object
      0.06            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.finish_task_switch
      0.08 ±  5%      +0.0        0.10 ± 10%  perf-profile.self.cycles-pp.tcp_rcv_space_adjust
      0.06 ±  6%      +0.0        0.08        perf-profile.self.cycles-pp.pick_next_entity
      0.06 ±  9%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.do_softirq
      0.05 ±  9%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.tcp_recv_timestamp
      0.11 ±  6%      +0.0        0.13 ±  5%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.09 ±  7%      +0.0        0.11 ±  6%  perf-profile.self.cycles-pp.sock_rfree
      0.08 ±  5%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.__x86_indirect_thunk_r10
      0.17 ±  4%      +0.0        0.19 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.10 ±  5%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.__sk_dst_check
      0.11 ± 11%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.native_write_msr
      0.10 ±  5%      +0.0        0.12 ±  5%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.05            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.ip_protocol_deliver_rcu
      0.11 ±  4%      +0.0        0.14 ±  5%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.10 ±  9%      +0.0        0.12 ±  8%  perf-profile.self.cycles-pp.__sys_recvfrom
      0.08 ±  6%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.do_splice_direct
      0.07 ± 10%      +0.0        0.10 ± 11%  perf-profile.self.cycles-pp.kmem_cache_free
      0.07 ±  6%      +0.0        0.10 ±  9%  perf-profile.self.cycles-pp.cpus_share_cache
      0.09 ±  9%      +0.0        0.12 ±  7%  perf-profile.self.cycles-pp.update_cfs_group
      0.22 ±  3%      +0.0        0.25 ±  4%  perf-profile.self.cycles-pp.ip_send_check
      0.17 ±  4%      +0.0        0.20 ±  3%  perf-profile.self.cycles-pp.inet_send_prepare
      0.09 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.aa_sk_perm
      0.10 ±  4%      +0.0        0.13 ±  6%  perf-profile.self.cycles-pp.native_sched_clock
      0.06            +0.0        0.09 ±  7%  perf-profile.self.cycles-pp.do_splice_to
      0.11 ±  7%      +0.0        0.14 ±  5%  perf-profile.self.cycles-pp.pagecache_get_page
      0.15 ±  5%      +0.0        0.18        perf-profile.self.cycles-pp._cond_resched
      0.05            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.kfree_skbmem
      0.15 ±  3%      +0.0        0.19 ±  4%  perf-profile.self.cycles-pp.tcp_wfree
      0.15 ±  4%      +0.0        0.18 ±  5%  perf-profile.self.cycles-pp.generic_splice_sendpage
      0.05 ±  9%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.ktime_get_with_offset
      0.05 ±  8%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.fpregs_assert_state_consistent
      0.04 ± 57%      +0.0        0.07 ± 10%  perf-profile.self.cycles-pp._copy_from_user
      0.04 ± 57%      +0.0        0.07        perf-profile.self.cycles-pp.validate_xmit_skb
      0.04 ± 58%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.rb_next
      0.07 ± 10%      +0.0        0.10 ± 10%  perf-profile.self.cycles-pp.__next_timer_interrupt
      0.05 ±  8%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.dev_hard_start_xmit
      0.16 ±  2%      +0.0        0.20 ±  5%  perf-profile.self.cycles-pp.sock_def_readable
      0.07 ±  7%      +0.0        0.10 ±  7%  perf-profile.self.cycles-pp.copyout
      0.06            +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.newidle_balance
      0.04 ± 57%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.skb_release_head_state
      0.04 ± 58%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.bictcp_acked
      0.05            +0.0        0.09 ±  9%  perf-profile.self.cycles-pp.tcp_push
      0.05 ±  8%      +0.0        0.09 ±  7%  perf-profile.self.cycles-pp.tcp_event_data_recv
      0.05            +0.0        0.09 ± 14%  perf-profile.self.cycles-pp.nf_hook_slow
      0.06 ±  9%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.__copy_skb_header
      0.06 ±  6%      +0.0        0.10        perf-profile.self.cycles-pp.tcp_schedule_loss_probe
      0.07 ±  6%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.inet_ehashfn
      0.11 ±  4%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.ip_local_deliver
      0.01 ±173%      +0.0        0.06 ±  9%  perf-profile.self.cycles-pp.raw_local_deliver
      0.04 ± 58%      +0.0        0.08 ± 10%  perf-profile.self.cycles-pp.netif_skb_features
      0.12 ±  4%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.__switch_to_asm
      0.09 ±  7%      +0.0        0.13 ±  6%  perf-profile.self.cycles-pp.__tcp_select_window
      0.20 ±  4%      +0.0        0.24 ±  2%  perf-profile.self.cycles-pp.set_next_entity
      0.08 ±  8%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.skb_entail
      0.07 ±  6%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.tcp_update_pacing_rate
      0.32 ±  3%      +0.0        0.36        perf-profile.self.cycles-pp.tcp_rate_check_app_limited
      0.23 ±  4%      +0.0        0.28 ±  6%  perf-profile.self.cycles-pp.security_file_permission
      0.21 ±  6%      +0.0        0.26 ±  4%  perf-profile.self.cycles-pp.__put_user_8
      0.01 ±173%      +0.0        0.06        perf-profile.self.cycles-pp.__x86_indirect_thunk_r14
      0.24 ±  2%      +0.0        0.29 ±  6%  perf-profile.self.cycles-pp.tcp_sendpage_locked
      0.10 ±  8%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.rcu_all_qs
      0.04 ± 58%      +0.0        0.09        perf-profile.self.cycles-pp.sk_filter_trim_cap
      0.06 ±  9%      +0.1        0.11 ±  8%  perf-profile.self.cycles-pp.tcp_ack_update_rtt
      0.21 ±  3%      +0.1        0.26 ±  2%  perf-profile.self.cycles-pp.aa_file_perm
      0.07 ±  5%      +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.tcp_event_new_data_sent
      0.09 ±  5%      +0.1        0.14 ±  9%  perf-profile.self.cycles-pp.kernel_sendpage
      0.01 ±173%      +0.1        0.07 ± 13%  perf-profile.self.cycles-pp.inet_recvmsg
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.tcp_v4_fill_cb
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.ip_local_deliver_finish
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp._raw_spin_unlock_bh
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.iov_iter_pipe
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.bictcp_cong_avoid
      0.33            +0.1        0.38 ±  6%  perf-profile.self.cycles-pp.__skb_clone
      0.17            +0.1        0.23 ±  3%  perf-profile.self.cycles-pp.net_rx_action
      0.14 ±  7%      +0.1        0.20 ±  4%  perf-profile.self.cycles-pp.__switch_to
      0.07 ±  6%      +0.1        0.12 ±  8%  perf-profile.self.cycles-pp.sanity
      0.00            +0.1        0.05 ±  9%  perf-profile.self.cycles-pp.tcp_rack_advance
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.tcp_chrono_stop
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.__tcp_send_ack
      0.08 ±  5%      +0.1        0.13 ±  6%  perf-profile.self.cycles-pp.__ip_finish_output
      0.15 ±  4%      +0.1        0.21 ±  2%  perf-profile.self.cycles-pp.xas_load
      0.15 ±  4%      +0.1        0.21 ±  2%  perf-profile.self.cycles-pp.enqueue_to_backlog
      0.09 ±  7%      +0.1        0.15 ± 15%  perf-profile.self.cycles-pp._find_next_bit
      0.14 ± 14%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.lock_sock_nested
      0.07 ±  7%      +0.1        0.12 ±  8%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.07 ±  7%      +0.1        0.12 ± 12%  perf-profile.self.cycles-pp.kfree
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.tcp_options_write
      0.01 ±173%      +0.1        0.07 ± 10%  perf-profile.self.cycles-pp.resched_curr
      0.16 ±  5%      +0.1        0.22        perf-profile.self.cycles-pp.process_backlog
      0.15 ±  5%      +0.1        0.21 ±  7%  perf-profile.self.cycles-pp.release_sock
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.__ip_local_out
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.tcp_tx_timestamp
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.rcu_eqs_enter
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.netif_rx_internal
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.tcp_stream_memory_free
      0.10 ±  4%      +0.1        0.16 ±  6%  perf-profile.self.cycles-pp.tcp_v4_send_check
      0.13 ±  8%      +0.1        0.19 ±  3%  perf-profile.self.cycles-pp.update_curr
      0.00            +0.1        0.06 ± 13%  perf-profile.self.cycles-pp.eth_type_trans
      0.09 ±  7%      +0.1        0.15 ±  5%  perf-profile.self.cycles-pp.ip_output
      0.35            +0.1        0.42 ±  5%  perf-profile.self.cycles-pp.__ksize
      0.11 ± 17%      +0.1        0.17 ±  4%  perf-profile.self.cycles-pp.xas_start
      0.20 ±  2%      +0.1        0.26 ±  3%  perf-profile.self.cycles-pp.ipv4_dst_check
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.ksoftirqd_running
      0.20 ±  3%      +0.1        0.27 ±  5%  perf-profile.self.cycles-pp.sock_put
      0.17 ±  7%      +0.1        0.24 ±  5%  perf-profile.self.cycles-pp.menu_select
      0.09            +0.1        0.16 ±  5%  perf-profile.self.cycles-pp.ip_rcv_core
      0.00            +0.1        0.07 ± 16%  perf-profile.self.cycles-pp.account_entity_dequeue
      0.14 ±  5%      +0.1        0.21 ±  6%  perf-profile.self.cycles-pp.enqueue_entity
      0.15 ±  7%      +0.1        0.22 ± 12%  perf-profile.self.cycles-pp.__might_fault
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.__tcp_push_pending_frames
      0.00            +0.1        0.07 ± 10%  perf-profile.self.cycles-pp.__tcp_ack_snd_check
      0.00            +0.1        0.07 ± 10%  perf-profile.self.cycles-pp.ip_queue_xmit
      0.01 ±173%      +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.ip_rcv_finish_core
      0.53 ±  5%      +0.1        0.60 ±  2%  perf-profile.self.cycles-pp.page_cache_pipe_buf_confirm
      0.22 ±  5%      +0.1        0.29 ±  2%  perf-profile.self.cycles-pp.rw_verify_area
      0.13 ±  6%      +0.1        0.21 ±  3%  perf-profile.self.cycles-pp.mod_timer
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.rb_first
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.tcp_mstamp_refresh
      0.29            +0.1        0.36        perf-profile.self.cycles-pp.sock_sendpage
      0.28 ±  2%      +0.1        0.36 ±  4%  perf-profile.self.cycles-pp.__x64_sys_sendfile64
      0.11 ±  4%      +0.1        0.19 ±  4%  perf-profile.self.cycles-pp.timestamp_truncate
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.apparmor_ipv4_postroute
      0.16 ± 10%      +0.1        0.24 ±  3%  perf-profile.self.cycles-pp.skb_clone
      0.14 ±  3%      +0.1        0.21 ±  5%  perf-profile.self.cycles-pp.kmem_cache_alloc_node
      0.10 ±  8%      +0.1        0.18 ±  8%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.___perf_sw_event
      0.00            +0.1        0.08 ±  8%  perf-profile.self.cycles-pp.tcp_rearm_rto
      0.14            +0.1        0.22 ±  3%  perf-profile.self.cycles-pp.tcp_send_mss
      0.13 ±  3%      +0.1        0.22 ±  6%  perf-profile.self.cycles-pp.__kmalloc_node_track_caller
      0.08 ±  5%      +0.1        0.17 ±  9%  perf-profile.self.cycles-pp.wait_woken
      0.11 ±  6%      +0.1        0.20 ±  7%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.13 ±  6%      +0.1        0.21 ±  5%  perf-profile.self.cycles-pp.current_time
      0.00            +0.1        0.09 ± 14%  perf-profile.self.cycles-pp.apparmor_socket_sock_rcv_skb
      0.12 ±  3%      +0.1        0.21 ± 11%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.1        0.09 ±  7%  perf-profile.self.cycles-pp.tcp_cleanup_rbuf
      0.52            +0.1        0.61        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.15 ±  8%      +0.1        0.24 ±  4%  perf-profile.self.cycles-pp.direct_splice_actor
      0.36            +0.1        0.45 ±  4%  perf-profile.self.cycles-pp.dst_release
      0.16 ±  5%      +0.1        0.25        perf-profile.self.cycles-pp.loopback_xmit
      0.10 ±  8%      +0.1        0.19 ±  7%  perf-profile.self.cycles-pp.__softirqentry_text_start
      0.40            +0.1        0.50 ±  2%  perf-profile.self.cycles-pp.pipe_to_sendpage
      0.26 ±  4%      +0.1        0.36 ±  2%  perf-profile.self.cycles-pp.splice_from_pipe
      0.35 ±  5%      +0.1        0.46 ±  4%  perf-profile.self.cycles-pp.__sched_text_start
      0.28 ±  2%      +0.1        0.39 ±  2%  perf-profile.self.cycles-pp.simple_copy_to_iter
      0.13 ±  5%      +0.1        0.24 ±  5%  perf-profile.self.cycles-pp.touch_atime
      0.26 ±  7%      +0.1        0.37        perf-profile.self.cycles-pp.__local_bh_enable_ip
      0.28            +0.1        0.39 ±  3%  perf-profile.self.cycles-pp.__ip_queue_xmit
      0.27 ±  7%      +0.1        0.38 ±  3%  perf-profile.self.cycles-pp.ip_finish_output2
      0.40 ±  2%      +0.1        0.52 ±  3%  perf-profile.self.cycles-pp.tcp_rcv_established
      0.35 ±  2%      +0.1        0.47 ±  4%  perf-profile.self.cycles-pp.tcp_clean_rtx_queue
      0.44 ±  4%      +0.1        0.56        perf-profile.self.cycles-pp.tcp_sendpage
      0.48 ±  3%      +0.1        0.60 ±  2%  perf-profile.self.cycles-pp.inet_sendpage
      0.29 ±  4%      +0.1        0.41 ±  2%  perf-profile.self.cycles-pp._copy_to_iter
      0.21 ±  6%      +0.1        0.34 ±  2%  perf-profile.self.cycles-pp.update_load_avg
      0.46 ±  4%      +0.1        0.59        perf-profile.self.cycles-pp.__fget_light
      0.38 ±  2%      +0.1        0.51 ±  3%  perf-profile.self.cycles-pp.tcp_v4_rcv
      0.41            +0.1        0.55 ±  3%  perf-profile.self.cycles-pp.tcp_recvmsg
      0.20 ±  4%      +0.1        0.33 ±  3%  perf-profile.self.cycles-pp.__alloc_skb
      0.35 ±  3%      +0.1        0.49 ±  2%  perf-profile.self.cycles-pp.generic_file_splice_read
      0.29 ±  4%      +0.1        0.43 ±  4%  perf-profile.self.cycles-pp.tcp_established_options
      0.24 ±  3%      +0.1        0.38 ±  4%  perf-profile.self.cycles-pp.tcp_ack
      0.09 ±  4%      +0.1        0.23 ±  6%  perf-profile.self.cycles-pp.tcp_release_cb
      0.33            +0.1        0.47 ±  2%  perf-profile.self.cycles-pp.__might_sleep
      0.38 ±  4%      +0.1        0.52 ±  4%  perf-profile.self.cycles-pp.__dev_queue_xmit
      0.17 ±  8%      +0.1        0.32 ±  2%  perf-profile.self.cycles-pp.__netif_receive_skb_core
      0.60            +0.1        0.75        perf-profile.self.cycles-pp.__skb_datagram_iter
      0.28 ±  3%      +0.1        0.43 ±  2%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.28 ±  7%      +0.2        0.44 ±  7%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.15 ± 12%      +0.2        0.30 ±  5%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.70 ±  4%      +0.2        0.86 ±  4%  perf-profile.self.cycles-pp.__inet_lookup_established
      0.20 ±  6%      +0.2        0.36 ±  4%  perf-profile.self.cycles-pp.atime_needs_update
      0.52 ±  3%      +0.2        0.69 ±  3%  perf-profile.self.cycles-pp.page_cache_pipe_buf_release
      0.25 ± 11%      +0.2        0.42 ±  3%  perf-profile.self.cycles-pp.splice_direct_to_actor
      0.26 ±  3%      +0.2        0.43 ±  4%  perf-profile.self.cycles-pp.__slab_free
      0.45 ±  9%      +0.2        0.63 ±  5%  perf-profile.self.cycles-pp.tcp_current_mss
      1.00 ±  5%      +0.2        1.20        perf-profile.self.cycles-pp.common_file_perm
      0.33 ±  3%      +0.2        0.53 ±  3%  perf-profile.self.cycles-pp.__splice_from_pipe
      0.73 ±  2%      +0.2        0.93 ±  4%  perf-profile.self.cycles-pp.read_tsc
      1.15            +0.2        1.36        perf-profile.self.cycles-pp.skb_release_data
      1.77 ±  5%      +0.2        1.98 ±  4%  perf-profile.self.cycles-pp.find_get_entry
      0.54 ±  5%      +0.2        0.77        perf-profile.self.cycles-pp.copy_page_to_iter
      0.51 ±  4%      +0.2        0.75        perf-profile.self.cycles-pp.do_sendfile
      0.59            +0.3        0.84 ±  3%  perf-profile.self.cycles-pp.__tcp_transmit_skb
      0.47 ±  3%      +0.3        0.73        perf-profile.self.cycles-pp.fsnotify
      0.93 ±  3%      +0.3        1.19        perf-profile.self.cycles-pp.generic_file_read_iter
      0.59            +0.3        0.85        perf-profile.self.cycles-pp._raw_spin_lock
      2.04 ±  2%      +0.3        2.32 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.34 ±  6%      +0.3        0.63 ±  5%  perf-profile.self.cycles-pp.ktime_get
      0.86 ±  2%      +0.3        1.15        perf-profile.self.cycles-pp.___might_sleep
      2.17 ±  2%      +0.3        2.49 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.74 ±  6%      +0.3        1.07 ±  4%  perf-profile.self.cycles-pp.ipv4_mtu
      1.08            +0.3        1.42        perf-profile.self.cycles-pp._raw_spin_lock_bh
      1.67 ±  2%      +0.3        2.01 ±  2%  perf-profile.self.cycles-pp.do_tcp_sendpages
      0.81 ±  2%      +0.4        1.18 ±  2%  perf-profile.self.cycles-pp.tcp_write_xmit
      0.72 ±  3%      +0.4        1.16        perf-profile.self.cycles-pp.__x86_indirect_thunk_rax
      3.17 ±  2%      +0.6        3.75        perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      3.36            +0.8        4.15        perf-profile.self.cycles-pp.do_syscall_64
      3.89 ±  4%      +1.4        5.29 ±  4%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


                                                                                
                               netperf.Throughput_Mbps                          
                                                                                
  20000 +-------------------------------------------------------------------+   
  18000 |.+..+.+.+.+..+.+.+.+..+.+.+.+..+.+.+..+.+.+.+..+.+.+.+..+.+.+.+..+.|   
        |                                                                   |   
  16000 |-+                                                                 |   
  14000 |-O    O                          O O      O O                      |   
        |          O    O   O  O O O O  O      O O      O O                 |   
  12000 |-+                                                                 |   
  10000 |-+                                                                 |   
   8000 |-+                                                                 |   
        |                                                                   |   
   6000 |-+                                                                 |   
   4000 |-+                                                                 |   
        |                                                                   |   
   2000 |-+                                                                 |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                            netperf.Throughput_total_Mbps                       
                                                                                
  350000 +------------------------------------------------------------------+   
         |.+.+..+.+.+.+..+.+.+.+..+.+.+.+..+.+.+.+.+..+.+   +..+.+.+    +.+.|   
  300000 |-+                                                                |   
         |                                                                  |   
  250000 |-O    O                   O      O O O O O  O O O                 |   
         |          O    O   O O  O   O O                                   |   
  200000 |-+                                                                |   
         |                                                                  |   
  150000 |-+                                                                |   
         |                                                                  |   
  100000 |-+                                                                |   
         |                                                                  |   
   50000 |-+                                                                |   
         |                                                                  |   
       0 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                   netperf.workload                             
                                                                                
  2.5e+09 +-----------------------------------------------------------------+   
          |            +.+.                                                 |   
          |                                                                 |   
    2e+09 |-+                                                               |   
          | O    O       O          O  O O O O O  O O O O O                 |   
          |          O        O O O                                         |   
  1.5e+09 |-+                                                               |   
          |                                                                 |   
    1e+09 |-+                                                               |   
          |                                                                 |   
          |                                                                 |   
    5e+08 |-+                                                               |   
          |                                                                 |   
          |                                                                 |   
        0 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                              netperf.time.user_time                            
                                                                                
  700 +---------------------------------------------------------------------+   
      | O    O                    +      O O    O O  O   O                  |   
  600 |-+         O   O    O O  O O O  O      O        O                    |   
      |                                                                     |   
  500 |-+                                                                   |   
      |                                                                     |   
  400 |-+                                                                   |   
      |                                                                     |   
  300 |-+                                                                   |   
      |                                                                     |   
  200 |-+                                                                   |   
      |                                                                     |   
  100 |-+                                                                   |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                             netperf.time.system_time                           
                                                                                
  5000 +--------------------------------------------------------------------+   
  4500 |.+..+.+.+..+.+.+.+..+.+.+..+.+.+..+.+.+.+..+.+.+..+.+.+..+.+.+.+..+.|   
       |                                                                    |   
  4000 |-+                                                                  |   
  3500 |-+                                                                  |   
       |                                                                    |   
  3000 |-+                                                                  |   
  2500 |-+                                                                  |   
  2000 |-+                                                                  |   
       |                                                                    |   
  1500 |-+                                                                  |   
  1000 |-+                                                                  |   
       |                                                                    |   
   500 |-+                                                                  |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-bdw-ex2: 160 threads Intel(R) Xeon(R) CPU E7-8890 v4 @ 2.20GHz with 256G memory
=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/send_size/tbox_group/test/testcase/ucode:
  cs-localhost/gcc-7/performance/ipv4/x86_64-rhel-7.6/25%/debian-x86_64-20191114.cgz/300s/10K/lkp-bdw-ex2/SCTP_STREAM_MANY/netperf/0xb000038

commit: 
  9c40365a65 ("threads: Update PID limit comment according to futex UAPI change")
  59901cb452 ("sched/fair: Don't pull task if local group is more loaded than busiest group")

9c40365a65d62d7c 59901cb4520c44bfce81f523bc6 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :4           25%           1:4     dmesg.WARNING:at#for_ip_interrupt_entry/0x
         %stddev     %change         %stddev
             \          |                \  
      8310           -31.1%       5723 ±  8%  netperf.Throughput_Mbps
    332426           -31.1%     228942 ±  8%  netperf.Throughput_total_Mbps
     13748 ±  2%     -15.8%      11583 ±  7%  netperf.time.minor_page_faults
    587.05           -26.0%     434.31 ±  6%  netperf.time.user_time
 1.217e+09           -31.1%  8.384e+08 ±  8%  netperf.workload
    763112 ±  5%     +19.0%     908201 ±  4%  meminfo.Committed_AS
  10662925 ± 10%     +16.3%   12404278        meminfo.DirectMap2M
      3.24            -0.8        2.48 ± 11%  mpstat.cpu.all.soft%
      2.02            -0.5        1.50 ±  6%  mpstat.cpu.all.usr%
     72.00            +2.1%      73.50        vmstat.cpu.id
   2290192           -31.3%    1573919 ±  8%  vmstat.system.cs
  6.88e+09 ±  6%     -54.1%  3.157e+09 ± 16%  cpuidle.C1.time
 3.412e+08 ±  2%     -50.4%  1.691e+08 ± 17%  cpuidle.C1.usage
  45203190 ± 48%    +165.0%  1.198e+08 ± 22%  cpuidle.C1E.usage
     25963            -4.1%      24904        proc-vmstat.nr_slab_reclaimable
     66104            -6.4%      61871        proc-vmstat.nr_slab_unreclaimable
      9019 ± 34%     -77.7%       2009 ± 72%  proc-vmstat.numa_hint_faults_local
 1.565e+09           -31.1%  1.078e+09 ±  8%  proc-vmstat.numa_hit
 1.565e+09           -31.1%  1.078e+09 ±  8%  proc-vmstat.numa_local
 9.044e+09           -31.1%  6.228e+09 ±  8%  proc-vmstat.pgalloc_normal
 9.044e+09           -31.1%  6.228e+09 ±  8%  proc-vmstat.pgfree
     39376 ± 22%     -56.0%      17319 ± 38%  sched_debug.cfs_rq:/.MIN_vruntime.avg
   3360482 ± 13%     -57.8%    1416646 ± 30%  sched_debug.cfs_rq:/.MIN_vruntime.max
    333186 ± 18%     -56.4%     145249 ± 31%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
     39376 ± 22%     -56.0%      17319 ± 38%  sched_debug.cfs_rq:/.max_vruntime.avg
   3360482 ± 13%     -57.8%    1416646 ± 30%  sched_debug.cfs_rq:/.max_vruntime.max
    333186 ± 18%     -56.4%     145249 ± 31%  sched_debug.cfs_rq:/.max_vruntime.stddev
     54158 ± 49%     -81.3%      10104 ± 32%  sched_debug.cfs_rq:/.min_vruntime.min
   1726678 ±  2%     +32.7%    2291681 ± 13%  sched_debug.cfs_rq:/.min_vruntime.stddev
      1387 ±  7%     +21.8%       1689 ± 12%  sched_debug.cfs_rq:/.runnable_avg.max
    460.02 ±  2%     +11.2%     511.65 ±  4%  sched_debug.cfs_rq:/.runnable_avg.stddev
   1726688 ±  2%     +32.7%    2291718 ± 13%  sched_debug.cfs_rq:/.spread0.stddev
     14277 ± 28%     -30.3%       9949 ±  4%  sched_debug.cpu.avg_idle.min
   1784858           -34.9%    1161189 ±  4%  sched_debug.cpu.nr_switches.avg
   6522465 ± 11%     +32.0%    8612184 ± 16%  sched_debug.cpu.nr_switches.max
      2464 ± 11%     -21.9%       1924 ±  2%  sched_debug.cpu.nr_switches.min
      7868 ±  7%     +10.8%       8717 ±  5%  numa-vmstat.node0.nr_kernel_stack
    677.50 ± 50%     +88.2%       1274 ± 29%  numa-vmstat.node0.nr_page_table_pages
      5910 ± 22%     +56.5%       9251 ±  7%  numa-vmstat.node0.nr_slab_reclaimable
      4052 ±  9%     -77.4%     917.50 ± 98%  numa-vmstat.node1.nr_inactive_anon
      6752 ±  2%     -16.2%       5660        numa-vmstat.node1.nr_kernel_stack
      2939 ± 17%     -39.0%       1793 ± 20%  numa-vmstat.node1.nr_mapped
    434.25 ± 54%     -90.8%      39.75 ± 53%  numa-vmstat.node1.nr_page_table_pages
      4467 ±  8%     -75.3%       1102 ± 82%  numa-vmstat.node1.nr_shmem
      6931 ± 22%     -49.3%       3517 ± 13%  numa-vmstat.node1.nr_slab_reclaimable
     17688 ±  8%     -37.7%      11019 ±  7%  numa-vmstat.node1.nr_slab_unreclaimable
      4052 ±  9%     -77.4%     917.50 ± 98%  numa-vmstat.node1.nr_zone_inactive_anon
 1.873e+08 ±  2%     -51.3%   91255968 ± 63%  numa-vmstat.node1.numa_hit
 1.872e+08 ±  2%     -51.3%   91208577 ± 63%  numa-vmstat.node1.numa_local
     25632 ± 87%     -75.5%       6288 ±130%  numa-vmstat.node2.nr_active_anon
     25596 ± 87%     -75.5%       6267 ±131%  numa-vmstat.node2.nr_anon_pages
     25632 ± 87%     -75.5%       6288 ±130%  numa-vmstat.node2.nr_zone_active_anon
     23643 ± 22%     +56.5%      37005 ±  7%  numa-meminfo.node0.KReclaimable
      7871 ±  7%     +10.7%       8713 ±  5%  numa-meminfo.node0.KernelStack
      7269 ± 24%     +24.6%       9060 ± 20%  numa-meminfo.node0.Mapped
    737950 ±  7%     +23.2%     909436        numa-meminfo.node0.MemUsed
      2710 ± 50%     +88.1%       5098 ± 29%  numa-meminfo.node0.PageTables
     23643 ± 22%     +56.5%      37005 ±  7%  numa-meminfo.node0.SReclaimable
     98061 ±  8%     +26.1%     123682 ±  6%  numa-meminfo.node0.Slab
     16278 ± 10%     -77.1%       3725 ± 96%  numa-meminfo.node1.Inactive
     16210 ±  9%     -77.3%       3672 ± 98%  numa-meminfo.node1.Inactive(anon)
     27728 ± 22%     -49.3%      14069 ± 13%  numa-meminfo.node1.KReclaimable
      6748 ±  2%     -16.0%       5670        numa-meminfo.node1.KernelStack
     11640 ± 18%     -39.3%       7065 ± 21%  numa-meminfo.node1.Mapped
    593633 ±  3%     -10.8%     529651 ±  5%  numa-meminfo.node1.MemUsed
      1736 ± 55%     -90.4%     167.00 ± 51%  numa-meminfo.node1.PageTables
     27728 ± 22%     -49.3%      14069 ± 13%  numa-meminfo.node1.SReclaimable
     70762 ±  8%     -37.7%      44079 ±  7%  numa-meminfo.node1.SUnreclaim
     17873 ±  8%     -75.3%       4415 ± 82%  numa-meminfo.node1.Shmem
     98490 ±  5%     -41.0%      58148 ±  8%  numa-meminfo.node1.Slab
    102626 ± 86%     -75.4%      25195 ±130%  numa-meminfo.node2.Active
    102494 ± 87%     -75.4%      25163 ±130%  numa-meminfo.node2.Active(anon)
     71781 ±102%     -84.3%      11236 ±162%  numa-meminfo.node2.AnonHugePages
    102350 ± 87%     -75.5%      25082 ±131%  numa-meminfo.node2.AnonPages
      9418 ±  4%     -25.7%       6997 ±  9%  slabinfo.Acpi-State.active_objs
      9418 ±  4%     -25.7%       6997 ±  9%  slabinfo.Acpi-State.num_objs
     10164            -9.7%       9182 ±  3%  slabinfo.cred_jar.active_objs
     10164            -9.7%       9182 ±  3%  slabinfo.cred_jar.num_objs
      7263 ±  6%     -30.8%       5027 ± 10%  slabinfo.files_cache.active_objs
      7263 ±  6%     -30.8%       5027 ± 10%  slabinfo.files_cache.num_objs
     52454 ±  5%     -16.9%      43590 ±  4%  slabinfo.filp.active_objs
    820.50 ±  5%     -16.6%     684.50 ±  4%  slabinfo.filp.active_slabs
     52535 ±  5%     -16.6%      43839 ±  4%  slabinfo.filp.num_objs
    820.50 ±  5%     -16.6%     684.50 ±  4%  slabinfo.filp.num_slabs
      5691 ±  2%     -25.7%       4226 ±  7%  slabinfo.mm_struct.active_objs
      5691 ±  2%     -25.7%       4226 ±  7%  slabinfo.mm_struct.num_objs
     18729           -13.4%      16227 ±  6%  slabinfo.pde_opener.active_objs
     18729           -13.4%      16227 ±  6%  slabinfo.pde_opener.num_objs
     11365           -23.0%       8755 ± 12%  slabinfo.pool_workqueue.active_objs
     11366           -23.0%       8756 ± 12%  slabinfo.pool_workqueue.num_objs
      3857 ±  4%     -18.9%       3126 ±  5%  slabinfo.sighand_cache.active_objs
      3859 ±  4%     -18.8%       3135 ±  4%  slabinfo.sighand_cache.num_objs
      6370 ±  5%     -22.4%       4942 ±  6%  slabinfo.signal_cache.active_objs
      6372 ±  5%     -22.3%       4950 ±  6%  slabinfo.signal_cache.num_objs
      9525 ±  4%     -24.2%       7218 ±  9%  slabinfo.task_delay_info.active_objs
      9525 ±  4%     -24.2%       7218 ±  9%  slabinfo.task_delay_info.num_objs
      2720 ±  3%     -12.5%       2379        slabinfo.task_struct.active_objs
    909.25 ±  3%     -11.9%     801.00        slabinfo.task_struct.active_slabs
      2728 ±  3%     -11.9%       2403        slabinfo.task_struct.num_objs
    909.25 ±  3%     -11.9%     801.00        slabinfo.task_struct.num_slabs
     62.27            -6.7%      58.10        perf-stat.i.MPKI
 1.506e+10           -18.1%  1.233e+10 ±  4%  perf-stat.i.branch-instructions
      1.93            -0.2        1.68 ±  4%  perf-stat.i.branch-miss-rate%
 2.872e+08           -28.3%  2.058e+08 ±  8%  perf-stat.i.branch-misses
      0.75 ± 11%      -0.4        0.38 ± 30%  perf-stat.i.cache-miss-rate%
  34087325 ± 11%     -61.2%   13229676 ± 41%  perf-stat.i.cache-misses
 4.561e+09           -25.3%  3.405e+09 ±  6%  perf-stat.i.cache-references
   2306970           -31.2%    1587675 ±  8%  perf-stat.i.context-switches
      2.02           +21.0%       2.44 ±  2%  perf-stat.i.cpi
 1.472e+11            -4.0%  1.413e+11 ±  2%  perf-stat.i.cpu-cycles
    778.21 ± 23%   +1447.9%      12045 ± 71%  perf-stat.i.cpu-migrations
      4566 ± 11%    +244.8%      15744 ± 36%  perf-stat.i.cycles-between-cache-misses
  23558623           -23.0%   18146040 ±  8%  perf-stat.i.dTLB-load-misses
 2.475e+10           -23.0%  1.905e+10 ±  5%  perf-stat.i.dTLB-loads
      0.06            +0.0        0.09 ±  9%  perf-stat.i.dTLB-store-miss-rate%
 1.639e+10           -29.7%  1.153e+10 ±  8%  perf-stat.i.dTLB-stores
     32.24 ±  6%      -7.0       25.20 ±  6%  perf-stat.i.iTLB-load-miss-rate%
  17483265 ±  6%     -24.0%   13290898 ±  7%  perf-stat.i.iTLB-load-misses
  36909400 ±  4%      +7.2%   39555285        perf-stat.i.iTLB-loads
 7.295e+10           -20.2%   5.82e+10 ±  4%  perf-stat.i.instructions
      0.50           -17.0%       0.41 ±  3%  perf-stat.i.ipc
   7892760 ± 14%     -56.1%    3466546 ± 33%  perf-stat.i.node-load-misses
     82559 ±  5%     -49.5%      41717 ± 30%  perf-stat.i.node-loads
     85.39 ±  2%     -21.2       64.20 ± 12%  perf-stat.i.node-store-miss-rate%
   4935653 ± 12%     -64.6%    1747970 ± 45%  perf-stat.i.node-store-misses
     62.52            -6.5%      58.45 ±  2%  perf-stat.overall.MPKI
      1.91            -0.2        1.67 ±  4%  perf-stat.overall.branch-miss-rate%
      0.75 ± 11%      -0.4        0.38 ± 34%  perf-stat.overall.cache-miss-rate%
      2.02           +20.6%       2.43 ±  3%  perf-stat.overall.cpi
      4380 ± 12%    +188.2%      12623 ± 39%  perf-stat.overall.cycles-between-cache-misses
      0.06            +0.0        0.09 ± 10%  perf-stat.overall.dTLB-store-miss-rate%
     32.16 ±  6%      -7.0       25.13 ±  6%  perf-stat.overall.iTLB-load-miss-rate%
      0.50           -17.0%       0.41 ±  3%  perf-stat.overall.ipc
     85.86 ±  2%     -19.6       66.27 ± 14%  perf-stat.overall.node-store-miss-rate%
     18033           +16.1%      20929 ±  3%  perf-stat.overall.path-length
 1.501e+10           -18.2%  1.228e+10 ±  4%  perf-stat.ps.branch-instructions
 2.862e+08           -28.4%  2.048e+08 ±  8%  perf-stat.ps.branch-misses
  33952691 ± 11%     -61.3%   13129750 ± 41%  perf-stat.ps.cache-misses
 4.544e+09           -25.4%   3.39e+09 ±  6%  perf-stat.ps.cache-references
   2298503           -31.3%    1580015 ±  8%  perf-stat.ps.context-switches
 1.466e+11            -4.0%  1.408e+11 ±  2%  perf-stat.ps.cpu-cycles
    794.78 ± 24%   +1419.0%      12072 ± 70%  perf-stat.ps.cpu-migrations
  23475449           -23.0%   18074421 ±  8%  perf-stat.ps.dTLB-load-misses
 2.466e+10           -23.1%  1.896e+10 ±  5%  perf-stat.ps.dTLB-loads
 1.633e+10           -29.8%  1.147e+10 ±  8%  perf-stat.ps.dTLB-stores
  17419953 ±  6%     -24.0%   13232122 ±  7%  perf-stat.ps.iTLB-load-misses
  36786011 ±  4%      +7.1%   39405794 ±  2%  perf-stat.ps.iTLB-loads
 7.268e+10           -20.3%  5.795e+10 ±  4%  perf-stat.ps.instructions
   7861951 ± 14%     -56.2%    3443289 ± 33%  perf-stat.ps.node-load-misses
     82432 ±  5%     -49.5%      41606 ± 30%  perf-stat.ps.node-loads
   4916204 ± 12%     -64.7%    1734707 ± 45%  perf-stat.ps.node-store-misses
 2.195e+13           -20.3%   1.75e+13 ±  4%  perf-stat.total.instructions
      3037 ± 66%     +68.9%       5130 ± 41%  interrupts.CPU10.NMI:Non-maskable_interrupts
      3037 ± 66%     +68.9%       5130 ± 41%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
      2687 ± 97%    +145.3%       6592 ± 13%  interrupts.CPU103.NMI:Non-maskable_interrupts
      2687 ± 97%    +145.3%       6592 ± 13%  interrupts.CPU103.PMI:Performance_monitoring_interrupts
      2179 ± 35%    +216.1%       6887 ±  2%  interrupts.CPU106.NMI:Non-maskable_interrupts
      2179 ± 35%    +216.1%       6887 ±  2%  interrupts.CPU106.PMI:Performance_monitoring_interrupts
      3006 ± 56%    +126.1%       6798 ±  9%  interrupts.CPU107.RES:Rescheduling_interrupts
      1996 ± 27%    +197.3%       5935 ± 31%  interrupts.CPU108.NMI:Non-maskable_interrupts
      1996 ± 27%    +197.3%       5935 ± 31%  interrupts.CPU108.PMI:Performance_monitoring_interrupts
      2101 ± 92%    +151.9%       5294 ± 49%  interrupts.CPU109.RES:Rescheduling_interrupts
      1580 ± 57%    +330.4%       6801 ± 38%  interrupts.CPU118.RES:Rescheduling_interrupts
      1362 ± 14%    +274.5%       5101 ± 39%  interrupts.CPU119.RES:Rescheduling_interrupts
      3530 ± 35%     -83.7%     574.75 ±115%  interrupts.CPU122.RES:Rescheduling_interrupts
      1343 ± 43%     -74.1%     348.00 ±147%  interrupts.CPU137.RES:Rescheduling_interrupts
      2221 ± 39%     -60.7%     874.25 ±131%  interrupts.CPU141.NMI:Non-maskable_interrupts
      2221 ± 39%     -60.7%     874.25 ±131%  interrupts.CPU141.PMI:Performance_monitoring_interrupts
      3578 ± 57%     -80.8%     688.00 ±134%  interrupts.CPU142.NMI:Non-maskable_interrupts
      3578 ± 57%     -80.8%     688.00 ±134%  interrupts.CPU142.PMI:Performance_monitoring_interrupts
      2935 ± 38%     -73.7%     772.00 ±171%  interrupts.CPU146.RES:Rescheduling_interrupts
      3052 ± 84%   +1035.4%      34656 ±135%  interrupts.CPU15.RES:Rescheduling_interrupts
      2687 ± 13%     -59.0%       1102 ± 98%  interrupts.CPU157.RES:Rescheduling_interrupts
      4192 ± 70%     -65.3%       1455 ±141%  interrupts.CPU166.NMI:Non-maskable_interrupts
      4192 ± 70%     -65.3%       1455 ±141%  interrupts.CPU166.PMI:Performance_monitoring_interrupts
      3234 ± 75%     -72.2%     898.25 ±139%  interrupts.CPU167.NMI:Non-maskable_interrupts
      3234 ± 75%     -72.2%     898.25 ±139%  interrupts.CPU167.PMI:Performance_monitoring_interrupts
      3496 ± 55%     -74.3%     897.00 ±133%  interrupts.CPU172.NMI:Non-maskable_interrupts
      3496 ± 55%     -74.3%     897.00 ±133%  interrupts.CPU172.PMI:Performance_monitoring_interrupts
      3794 ± 51%     -88.5%     435.00 ± 68%  interrupts.CPU173.NMI:Non-maskable_interrupts
      3794 ± 51%     -88.5%     435.00 ± 68%  interrupts.CPU173.PMI:Performance_monitoring_interrupts
      4717 ± 56%     -79.4%     972.75 ±136%  interrupts.CPU174.NMI:Non-maskable_interrupts
      4717 ± 56%     -79.4%     972.75 ±136%  interrupts.CPU174.PMI:Performance_monitoring_interrupts
      4786 ± 13%     -95.5%     213.25 ± 87%  interrupts.CPU175.RES:Rescheduling_interrupts
      3500 ± 64%     -76.2%     832.50 ±107%  interrupts.CPU184.NMI:Non-maskable_interrupts
      3500 ± 64%     -76.2%     832.50 ±107%  interrupts.CPU184.PMI:Performance_monitoring_interrupts
      2748 ±  4%     -71.9%     772.25 ± 95%  interrupts.CPU185.NMI:Non-maskable_interrupts
      2748 ±  4%     -71.9%     772.25 ± 95%  interrupts.CPU185.PMI:Performance_monitoring_interrupts
      3896 ± 50%     -84.2%     616.50 ±115%  interrupts.CPU186.NMI:Non-maskable_interrupts
      3896 ± 50%     -84.2%     616.50 ±115%  interrupts.CPU186.PMI:Performance_monitoring_interrupts
      6332 ± 22%     -90.6%     597.50 ±110%  interrupts.CPU187.NMI:Non-maskable_interrupts
      6332 ± 22%     -90.6%     597.50 ±110%  interrupts.CPU187.PMI:Performance_monitoring_interrupts
      2798 ± 62%     -91.2%     246.25 ±163%  interrupts.CPU188.RES:Rescheduling_interrupts
      7445 ± 30%     -89.6%     776.00 ±126%  interrupts.CPU33.RES:Rescheduling_interrupts
      2500 ± 31%     -88.3%     293.75 ±158%  interrupts.CPU35.RES:Rescheduling_interrupts
      3157 ± 15%     -81.9%     572.25 ±164%  interrupts.CPU36.RES:Rescheduling_interrupts
      4402 ± 61%     -80.8%     844.50 ±168%  interrupts.CPU39.RES:Rescheduling_interrupts
      6686 ± 71%     -91.7%     553.00 ±169%  interrupts.CPU41.RES:Rescheduling_interrupts
      5143 ± 37%     -64.2%       1841 ±149%  interrupts.CPU42.NMI:Non-maskable_interrupts
      5143 ± 37%     -64.2%       1841 ±149%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
      5837 ± 32%     -68.2%       1855 ±159%  interrupts.CPU43.NMI:Non-maskable_interrupts
      5837 ± 32%     -68.2%       1855 ±159%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
      3557 ± 47%     -97.9%      75.25 ±126%  interrupts.CPU44.RES:Rescheduling_interrupts
      3370 ± 37%    +130.1%       7754 ± 39%  interrupts.CPU5.RES:Rescheduling_interrupts
      4376 ± 37%     -78.9%     924.75 ± 65%  interrupts.CPU58.RES:Rescheduling_interrupts
      2807 ± 64%    +108.3%       5847 ± 36%  interrupts.CPU6.RES:Rescheduling_interrupts
      7502 ± 52%     -83.6%       1226 ±112%  interrupts.CPU61.RES:Rescheduling_interrupts
      3688 ± 67%     -88.3%     430.75 ±167%  interrupts.CPU65.RES:Rescheduling_interrupts
      2911 ± 16%     -51.7%       1405 ± 62%  interrupts.CPU75.NMI:Non-maskable_interrupts
      2911 ± 16%     -51.7%       1405 ± 62%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
      2318 ± 21%     -66.1%     786.25 ±117%  interrupts.CPU76.NMI:Non-maskable_interrupts
      2318 ± 21%     -66.1%     786.25 ±117%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
      2279 ± 27%     -86.4%     310.75 ± 34%  interrupts.CPU77.NMI:Non-maskable_interrupts
      2279 ± 27%     -86.4%     310.75 ± 34%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
      5185 ± 35%     -91.0%     465.00 ± 34%  interrupts.CPU77.RES:Rescheduling_interrupts
      4118 ± 34%     -74.6%       1047 ± 87%  interrupts.CPU79.RES:Rescheduling_interrupts
      5165 ± 22%     -63.7%       1875 ±107%  interrupts.CPU86.RES:Rescheduling_interrupts
      3514 ± 65%     -70.4%       1041 ±106%  interrupts.CPU88.NMI:Non-maskable_interrupts
      3514 ± 65%     -70.4%       1041 ±106%  interrupts.CPU88.PMI:Performance_monitoring_interrupts
      4784 ± 50%     -78.3%       1037 ± 96%  interrupts.CPU89.NMI:Non-maskable_interrupts
      4784 ± 50%     -78.3%       1037 ± 96%  interrupts.CPU89.PMI:Performance_monitoring_interrupts
      2389 ± 60%    +193.3%       7009 ± 21%  interrupts.CPU9.RES:Rescheduling_interrupts
      3639 ± 19%     -78.3%     789.75 ±128%  interrupts.CPU90.NMI:Non-maskable_interrupts
      3639 ± 19%     -78.3%     789.75 ±128%  interrupts.CPU90.PMI:Performance_monitoring_interrupts
      2414 ± 45%     -68.2%     768.50 ±126%  interrupts.CPU91.NMI:Non-maskable_interrupts
      2414 ± 45%     -68.2%     768.50 ±126%  interrupts.CPU91.PMI:Performance_monitoring_interrupts
      3940 ± 28%     -99.7%      11.00 ± 94%  interrupts.CPU93.RES:Rescheduling_interrupts
      4768 ± 51%     -82.2%     849.75 ±136%  interrupts.CPU94.NMI:Non-maskable_interrupts
      4768 ± 51%     -82.2%     849.75 ±136%  interrupts.CPU94.PMI:Performance_monitoring_interrupts
      3071 ± 51%     -96.3%     114.25 ±129%  interrupts.CPU94.RES:Rescheduling_interrupts
      2672 ± 40%     -73.5%     707.25 ±171%  interrupts.CPU95.RES:Rescheduling_interrupts
    644992 ± 20%     +28.1%     826353 ±  9%  interrupts.RES:Rescheduling_interrupts
    141316 ±  2%     -10.7%     126249 ±  8%  softirqs.CPU10.RCU
     38660 ±  4%     -39.7%      23314 ± 40%  softirqs.CPU10.SCHED
     40648           -24.3%      30768 ± 18%  softirqs.CPU101.SCHED
    135335 ±  2%     -10.6%     120927 ±  7%  softirqs.CPU102.RCU
     39708 ± 24%     -48.1%      20612 ± 50%  softirqs.CPU102.SCHED
    357756 ± 92%    +233.0%    1191209 ± 45%  softirqs.CPU108.NET_RX
    140033 ±  4%     -11.5%     123936 ± 10%  softirqs.CPU108.RCU
     39682 ±  2%     -40.4%      23651 ± 53%  softirqs.CPU108.SCHED
   1162992 ± 22%     -62.5%     436694 ± 91%  softirqs.CPU113.NET_RX
     36929 ±  7%     -37.5%      23090 ± 43%  softirqs.CPU114.SCHED
     39419 ± 15%     -29.6%      27760 ± 23%  softirqs.CPU116.SCHED
     37471 ± 14%     -20.4%      29821 ±  8%  softirqs.CPU117.SCHED
     38725 ±  4%     -29.5%      27287 ± 24%  softirqs.CPU122.SCHED
    380987 ±112%    -100.0%       4.75 ± 60%  softirqs.CPU124.NET_RX
    684082 ±108%    -100.0%       6.50 ± 82%  softirqs.CPU126.NET_RX
     35779 ± 14%     +17.7%      42122 ±  5%  softirqs.CPU126.SCHED
    136179 ±  4%      -7.4%     126126 ±  5%  softirqs.CPU136.RCU
    136482 ±  3%     -10.7%     121892 ±  3%  softirqs.CPU137.RCU
     37701 ± 13%     -19.4%      30389 ± 19%  softirqs.CPU14.SCHED
    138037 ±  5%      -7.9%     127161 ±  6%  softirqs.CPU143.RCU
    135813 ±  4%     -11.1%     120675 ±  2%  softirqs.CPU144.RCU
    136752 ±  3%      -9.5%     123693 ±  2%  softirqs.CPU146.RCU
    140989 ±  2%      -7.0%     131118 ±  4%  softirqs.CPU147.RCU
    140477 ±  4%      -7.0%     130636 ±  5%  softirqs.CPU151.RCU
    140183 ±  3%      -9.2%     127229 ±  4%  softirqs.CPU157.RCU
     41010 ±  3%     -41.3%      24083 ± 51%  softirqs.CPU157.SCHED
     34115 ± 11%     +19.5%      40766 ± 12%  softirqs.CPU159.SCHED
   1225282 ± 94%     -94.6%      66471 ±173%  softirqs.CPU160.NET_RX
     38414 ±  9%     -38.0%      23813 ± 45%  softirqs.CPU161.SCHED
    137423 ±  4%      -7.0%     127861 ±  3%  softirqs.CPU162.RCU
     30810 ± 31%     +27.3%      39228 ±  6%  softirqs.CPU164.SCHED
    138560 ±  3%     -13.0%     120523 ±  5%  softirqs.CPU165.RCU
     42022 ±  5%     -24.5%      31709 ± 38%  softirqs.CPU165.SCHED
    973700 ± 95%     -96.8%      30927 ±173%  softirqs.CPU172.NET_RX
    977062 ± 77%    -100.0%       2.75 ± 69%  softirqs.CPU173.NET_RX
    547399 ±162%    -100.0%       2.75 ± 86%  softirqs.CPU179.NET_RX
     64145 ±114%    -100.0%       7.00 ± 66%  softirqs.CPU183.NET_RX
     39496           +10.4%      43614 ±  6%  softirqs.CPU183.SCHED
     26478 ± 28%     +53.6%      40670        softirqs.CPU186.SCHED
   1601031 ± 85%    -100.0%     477.00 ±173%  softirqs.CPU187.NET_RX
    133259 ±  2%      -6.6%     124422 ±  4%  softirqs.CPU189.RCU
    137106 ±  2%      -8.4%     125547 ±  2%  softirqs.CPU190.RCU
    102176 ± 68%     -72.1%      28546 ±173%  softirqs.CPU191.NET_RX
   1500188 ± 32%     -71.1%     433553 ± 99%  softirqs.CPU23.NET_RX
   1456825 ± 48%     -78.7%     310211 ±145%  softirqs.CPU27.NET_RX
     30211 ± 21%     +32.5%      40018 ± 16%  softirqs.CPU27.SCHED
   1249314 ± 45%     -83.4%     207506 ±173%  softirqs.CPU28.NET_RX
     32688 ± 12%     +22.9%      40167 ± 10%  softirqs.CPU28.SCHED
    614013 ± 33%     -91.8%      50330 ±172%  softirqs.CPU31.NET_RX
    856129 ± 54%     -92.1%      67308 ±172%  softirqs.CPU32.NET_RX
    826453 ± 88%     -92.6%      61272 ±153%  softirqs.CPU33.NET_RX
    572160 ± 58%     -92.0%      45490 ±172%  softirqs.CPU34.NET_RX
   1198932 ± 26%     -80.2%     237504 ±173%  softirqs.CPU35.NET_RX
    764186 ± 42%     -98.9%       8411 ±170%  softirqs.CPU36.NET_RX
   1957332 ± 39%     -97.6%      47130 ±172%  softirqs.CPU38.NET_RX
     25563 ± 24%     +51.2%      38644 ± 12%  softirqs.CPU38.SCHED
   1904800 ± 68%     -69.5%     581766 ±173%  softirqs.CPU39.NET_RX
    136554           -10.5%     122273 ±  3%  softirqs.CPU41.RCU
   1937742 ± 65%     -83.7%     316430 ±173%  softirqs.CPU42.NET_RX
   1965972 ± 41%     -84.5%     305614 ±173%  softirqs.CPU43.NET_RX
    138112 ±  5%      -8.5%     126429 ±  4%  softirqs.CPU44.RCU
    938187 ± 79%     -88.1%     111510 ±172%  softirqs.CPU45.NET_RX
   1859081 ± 63%    -100.0%     142.50 ±  6%  softirqs.CPU47.NET_RX
   1418766 ± 55%     -96.3%      51993 ±172%  softirqs.CPU56.NET_RX
     31415 ± 16%     +33.4%      41922 ±  8%  softirqs.CPU56.SCHED
   1608741 ± 92%     -93.1%     110943 ±172%  softirqs.CPU57.NET_RX
   1185884 ± 49%     -52.3%     565791 ±113%  softirqs.CPU58.NET_RX
   2280687 ± 64%     -86.8%     301429 ±153%  softirqs.CPU60.NET_RX
    989103 ± 66%     -84.0%     158376 ±173%  softirqs.CPU63.NET_RX
   1357266 ± 62%     -87.3%     172102 ±173%  softirqs.CPU64.NET_RX
   1353050 ± 14%     -77.5%     305024 ±170%  softirqs.CPU67.NET_RX
   1061562 ± 62%     -70.1%     317101 ±173%  softirqs.CPU68.NET_RX
    135927 ±  4%      -9.8%     122670 ±  7%  softirqs.CPU70.RCU
   1219305 ± 63%     -66.8%     404442 ±163%  softirqs.CPU71.NET_RX
    138945 ±  3%     -12.6%     121504 ±  7%  softirqs.CPU71.RCU
   1342914 ± 22%     -57.5%     570854 ±101%  softirqs.CPU75.NET_RX
   1370885 ± 17%     -60.3%     543996 ±107%  softirqs.CPU76.NET_RX
     38700 ±  6%     -20.6%      30718 ± 21%  softirqs.CPU77.SCHED
     37200 ± 11%     -32.2%      25215 ± 53%  softirqs.CPU8.SCHED
   2042132 ± 26%     -76.3%     484633 ±140%  softirqs.CPU84.NET_RX
   1162850 ± 36%     -69.4%     355800 ±116%  softirqs.CPU85.NET_RX
   1454966 ± 30%     -92.4%     109880 ±173%  softirqs.CPU87.NET_RX
     29191 ± 28%     +48.1%      43243 ± 10%  softirqs.CPU87.SCHED
   1982705 ± 30%     -90.8%     181832 ± 87%  softirqs.CPU88.NET_RX
     26016 ± 21%     +60.9%      41872 ± 10%  softirqs.CPU88.SCHED
   2230453 ±  9%     -92.5%     166989 ±173%  softirqs.CPU89.NET_RX
     23850 ± 15%     +65.7%      39517 ±  6%  softirqs.CPU89.SCHED
   1324547 ± 34%    -100.0%       3.25 ± 70%  softirqs.CPU90.NET_RX
     30624 ± 11%     +34.9%      41296 ± 10%  softirqs.CPU90.SCHED
    392004 ±131%    -100.0%       3.75 ± 87%  softirqs.CPU91.NET_RX
    716600 ± 98%     -97.2%      20120 ±173%  softirqs.CPU92.NET_RX
 1.739e+08           -31.1%  1.198e+08 ±  8%  softirqs.NET_RX
     35.60            -2.7       32.88 ±  4%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     38.93            -2.7       36.26 ±  4%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
     38.93            -2.7       36.26 ±  4%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
     38.91            -2.7       36.25 ±  4%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     39.06            -2.6       36.42 ±  4%  perf-profile.calltrace.cycles-pp.secondary_startup_64
     36.62            -2.5       34.09 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     36.69            -2.5       34.17 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      7.72 ±  2%      -1.7        5.99 ±  4%  perf-profile.calltrace.cycles-pp.__ip_queue_xmit.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm
      7.62 ±  2%      -1.7        5.91 ±  4%  perf-profile.calltrace.cycles-pp.ip_output.__ip_queue_xmit.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter
      7.53 ±  2%      -1.7        5.83 ±  4%  perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_output.__ip_queue_xmit.sctp_packet_transmit.sctp_outq_flush
      7.26 ±  2%      -1.7        5.60 ±  4%  perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.ip_finish_output2.ip_output.__ip_queue_xmit.sctp_packet_transmit
      7.24 ±  2%      -1.7        5.58 ±  4%  perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.ip_finish_output2.ip_output.__ip_queue_xmit
      7.16 ±  2%      -1.6        5.52 ±  4%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.do_softirq_own_stack.do_softirq.__local_bh_enable_ip.ip_finish_output2
      7.18 ±  2%      -1.6        5.54 ±  4%  perf-profile.calltrace.cycles-pp.do_softirq_own_stack.do_softirq.__local_bh_enable_ip.ip_finish_output2.ip_output
      7.06 ±  2%      -1.6        5.45 ±  4%  perf-profile.calltrace.cycles-pp.net_rx_action.__softirqentry_text_start.do_softirq_own_stack.do_softirq.__local_bh_enable_ip
      6.98 ±  2%      -1.6        5.36 ±  4%  perf-profile.calltrace.cycles-pp.process_backlog.net_rx_action.__softirqentry_text_start.do_softirq_own_stack.do_softirq
      6.87 ±  2%      -1.6        5.27 ±  4%  perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.net_rx_action.__softirqentry_text_start.do_softirq_own_stack
      6.71 ±  2%      -1.6        5.14 ±  4%  perf-profile.calltrace.cycles-pp.ip_rcv.__netif_receive_skb_one_core.process_backlog.net_rx_action.__softirqentry_text_start
      6.57 ±  2%      -1.6        5.01 ±  4%  perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core
      6.51 ±  2%      -1.6        4.96 ±  4%  perf-profile.calltrace.cycles-pp.sctp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver.ip_rcv
      6.62 ±  2%      -1.6        5.07 ±  4%  perf-profile.calltrace.cycles-pp.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core.process_backlog.net_rx_action
      6.58 ±  2%      -1.5        5.03 ±  4%  perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core.process_backlog
     10.09 ±  2%      -1.4        8.72 ±  3%  perf-profile.calltrace.cycles-pp.sctp_primitive_SEND.sctp_sendmsg_to_asoc.sctp_sendmsg.sock_sendmsg.____sys_sendmsg
      8.06            -1.3        6.75 ±  4%  perf-profile.calltrace.cycles-pp.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv
      5.28 ±  2%      -1.2        4.05 ±  4%  perf-profile.calltrace.cycles-pp.sctp_assoc_bh_rcv.sctp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver
      5.26            -1.2        4.09 ±  5%  perf-profile.calltrace.cycles-pp.memcpy_erms.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm
      4.95 ±  2%      -1.2        3.78 ±  4%  perf-profile.calltrace.cycles-pp.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      8.95 ±  2%      -1.1        7.82 ±  3%  perf-profile.calltrace.cycles-pp.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND.sctp_sendmsg_to_asoc
      4.45 ±  2%      -1.1        3.36 ±  4%  perf-profile.calltrace.cycles-pp.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv.ip_protocol_deliver_rcu
      4.45            -1.0        3.45 ±  5%  perf-profile.calltrace.cycles-pp.sctp_user_addto_chunk.sctp_datamsg_from_user.sctp_sendmsg_to_asoc.sctp_sendmsg.sock_sendmsg
      4.31            -1.0        3.33 ±  5%  perf-profile.calltrace.cycles-pp._copy_from_iter_full.sctp_user_addto_chunk.sctp_datamsg_from_user.sctp_sendmsg_to_asoc.sctp_sendmsg
      4.20            -1.0        3.23 ±  5%  perf-profile.calltrace.cycles-pp.copyin._copy_from_iter_full.sctp_user_addto_chunk.sctp_datamsg_from_user.sctp_sendmsg_to_asoc
      4.17            -0.9        3.22 ±  5%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin._copy_from_iter_full.sctp_user_addto_chunk.sctp_datamsg_from_user
      8.12            -0.9        7.23 ±  4%  perf-profile.calltrace.cycles-pp.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_backlog_rcv
      7.75            -0.9        6.87 ±  3%  perf-profile.calltrace.cycles-pp.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND
      3.15 ±  2%      -0.8        2.36 ±  5%  perf-profile.calltrace.cycles-pp.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv
      7.22 ±  2%      -0.7        6.56 ±  3%  perf-profile.calltrace.cycles-pp.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND.sctp_sendmsg_to_asoc.sctp_sendmsg
      7.06 ±  2%      -0.6        6.44 ±  3%  perf-profile.calltrace.cycles-pp.sctp_do_sm.sctp_primitive_SEND.sctp_sendmsg_to_asoc.sctp_sendmsg.sock_sendmsg
      4.18 ±  3%      -0.6        3.59 ±  7%  perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.sctp_recvmsg.inet_recvmsg.____sys_recvmsg.___sys_recvmsg
      4.17 ±  3%      -0.6        3.57 ±  7%  perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.sctp_recvmsg.inet_recvmsg.____sys_recvmsg
      1.42            -0.6        0.86 ± 57%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.sctp_data_ready.sctp_ulpq_tail_event
      1.39            -0.6        0.84 ± 57%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.sctp_data_ready
      3.76 ±  3%      -0.5        3.21 ±  7%  perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.sctp_recvmsg.inet_recvmsg
      2.45            -0.5        1.90 ±  3%  perf-profile.calltrace.cycles-pp.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg.____sys_recvmsg.___sys_recvmsg
      3.66 ±  3%      -0.5        3.12 ±  7%  perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.sctp_recvmsg
      3.63 ±  3%      -0.5        3.10 ±  7%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
      1.92            -0.5        1.44 ±  5%  perf-profile.calltrace.cycles-pp.sctp_ulpq_tail_event.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv
      1.75            -0.4        1.33 ±  5%  perf-profile.calltrace.cycles-pp.sctp_data_ready.sctp_ulpq_tail_event.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm
      1.08            -0.4        0.72 ±  5%  perf-profile.calltrace.cycles-pp.lock_sock_nested.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg.____sys_recvmsg
      1.56            -0.4        1.21 ±  6%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.sctp_data_ready.sctp_ulpq_tail_event.sctp_ulpq_tail_data.sctp_cmd_interpreter
      1.46            -0.3        1.14 ±  6%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.sctp_data_ready.sctp_ulpq_tail_event.sctp_ulpq_tail_data
      0.96            -0.3        0.64 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_bh.lock_sock_nested.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg
      0.72 ±  2%      -0.3        0.40 ± 57%  perf-profile.calltrace.cycles-pp.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv
      0.93            -0.3        0.62 ±  6%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_bh.lock_sock_nested.sctp_skb_recv_datagram.sctp_recvmsg
      0.65 ±  2%      -0.2        0.41 ± 57%  perf-profile.calltrace.cycles-pp.copy_msghdr_from_user.sendmsg_copy_msghdr.___sys_sendmsg.__sys_sendmsg.do_syscall_64
      0.65 ±  2%      -0.2        0.41 ± 57%  perf-profile.calltrace.cycles-pp.sendmsg_copy_msghdr.___sys_sendmsg.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.92 ±  2%      -0.2        0.70 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64
      0.87 ±  2%      -0.2        0.67        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret
      0.76 ±  4%      -0.2        0.57 ±  4%  perf-profile.calltrace.cycles-pp.sctp_ulpevent_free.sctp_recvmsg.inet_recvmsg.____sys_recvmsg.___sys_recvmsg
      0.87 ±  3%      -0.1        0.74 ±  6%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      0.85 ±  3%      -0.1        0.72 ±  7%  perf-profile.calltrace.cycles-pp.__sched_text_start.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      1.00 ±  3%      -0.1        0.89 ±  3%  perf-profile.calltrace.cycles-pp.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg.____sys_recvmsg
      0.98 ±  3%      -0.1        0.88 ±  3%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg
      0.96 ±  3%      -0.1        0.86 ±  3%  perf-profile.calltrace.cycles-pp.__sched_text_start.schedule.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg
      2.75 ±  5%      +0.9        3.69 ± 13%  perf-profile.calltrace.cycles-pp.kfree_skb.sctp_recvmsg.inet_recvmsg.____sys_recvmsg.___sys_recvmsg
      2.07 ±  5%      +1.1        3.14 ± 14%  perf-profile.calltrace.cycles-pp.free_one_page.__free_pages_ok.kfree_skb.sctp_recvmsg.inet_recvmsg
      2.21 ±  6%      +1.1        3.27 ± 14%  perf-profile.calltrace.cycles-pp.__free_pages_ok.kfree_skb.sctp_recvmsg.inet_recvmsg.____sys_recvmsg
      1.90 ±  6%      +1.1        3.02 ± 14%  perf-profile.calltrace.cycles-pp._raw_spin_lock.free_one_page.__free_pages_ok.kfree_skb.sctp_recvmsg
      1.75 ±  6%      +1.2        2.92 ± 15%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.free_one_page.__free_pages_ok.kfree_skb
      1.99            +1.3        3.29 ±  3%  perf-profile.calltrace.cycles-pp.__alloc_skb.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm
      1.85            +1.3        3.19 ±  3%  perf-profile.calltrace.cycles-pp.__kmalloc_reserve.__alloc_skb.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter
      1.82 ±  2%      +1.4        3.17 ±  3%  perf-profile.calltrace.cycles-pp.__kmalloc_node_track_caller.__kmalloc_reserve.__alloc_skb.sctp_packet_transmit.sctp_outq_flush
      1.81            +1.4        3.17 ±  3%  perf-profile.calltrace.cycles-pp.kmalloc_large_node.__kmalloc_node_track_caller.__kmalloc_reserve.__alloc_skb.sctp_packet_transmit
     23.40            +2.0       25.38 ±  2%  perf-profile.calltrace.cycles-pp.sctp_sendmsg_to_asoc.sctp_sendmsg.sock_sendmsg.____sys_sendmsg.___sys_sendmsg
     58.47            +3.2       61.64 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     58.27            +3.2       61.47 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.29            +3.2       19.53 ±  2%  perf-profile.calltrace.cycles-pp.release_sock.sctp_sendmsg.sock_sendmsg.____sys_sendmsg.___sys_sendmsg
     16.19            +3.3       19.45 ±  2%  perf-profile.calltrace.cycles-pp.__release_sock.release_sock.sctp_sendmsg.sock_sendmsg.____sys_sendmsg
     16.10            +3.3       19.40 ±  2%  perf-profile.calltrace.cycles-pp.sctp_backlog_rcv.__release_sock.release_sock.sctp_sendmsg.sock_sendmsg
     12.86            +3.4       16.27 ±  2%  perf-profile.calltrace.cycles-pp.sctp_datamsg_from_user.sctp_sendmsg_to_asoc.sctp_sendmsg.sock_sendmsg.____sys_sendmsg
     14.14            +3.7       17.89 ±  2%  perf-profile.calltrace.cycles-pp.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_backlog_rcv.__release_sock
     13.93            +3.8       17.70 ±  2%  perf-profile.calltrace.cycles-pp.sctp_assoc_bh_rcv.sctp_backlog_rcv.__release_sock.release_sock.sctp_sendmsg
     13.93            +3.8       17.70 ±  2%  perf-profile.calltrace.cycles-pp.sctp_do_sm.sctp_assoc_bh_rcv.sctp_backlog_rcv.__release_sock.release_sock
      7.65 ±  2%      +4.2       11.90        perf-profile.calltrace.cycles-pp.sctp_outq_sack.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_backlog_rcv
      6.70 ±  2%      +4.5       11.22        perf-profile.calltrace.cycles-pp.sctp_chunk_put.sctp_outq_sack.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv
      6.50 ±  2%      +4.6       11.08        perf-profile.calltrace.cycles-pp.consume_skb.sctp_chunk_put.sctp_outq_sack.sctp_cmd_interpreter.sctp_do_sm
     42.95            +4.6       47.55 ±  2%  perf-profile.calltrace.cycles-pp.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.73            +4.6       12.34 ±  2%  perf-profile.calltrace.cycles-pp.sctp_make_datafrag_empty.sctp_datamsg_from_user.sctp_sendmsg_to_asoc.sctp_sendmsg.sock_sendmsg
     42.69            +4.7       47.35 ±  2%  perf-profile.calltrace.cycles-pp.___sys_sendmsg.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.90 ±  2%      +4.7       10.56 ±  2%  perf-profile.calltrace.cycles-pp.__free_pages_ok.consume_skb.sctp_chunk_put.sctp_outq_sack.sctp_cmd_interpreter
      5.67 ±  2%      +4.7       10.33 ±  2%  perf-profile.calltrace.cycles-pp.free_one_page.__free_pages_ok.consume_skb.sctp_chunk_put.sctp_outq_sack
      7.36            +4.7       12.04 ±  2%  perf-profile.calltrace.cycles-pp._sctp_make_chunk.sctp_make_datafrag_empty.sctp_datamsg_from_user.sctp_sendmsg_to_asoc.sctp_sendmsg
     41.99            +4.8       46.77 ±  2%  perf-profile.calltrace.cycles-pp.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.82            +4.8       11.62 ±  2%  perf-profile.calltrace.cycles-pp.__alloc_skb._sctp_make_chunk.sctp_make_datafrag_empty.sctp_datamsg_from_user.sctp_sendmsg_to_asoc
      5.18 ±  2%      +4.8        9.99 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.free_one_page.__free_pages_ok.consume_skb.sctp_chunk_put
     41.20            +4.9       46.11 ±  2%  perf-profile.calltrace.cycles-pp.sock_sendmsg.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg.do_syscall_64
      4.89 ±  2%      +4.9        9.80 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.free_one_page.__free_pages_ok.consume_skb
     40.83            +5.0       45.80 ±  2%  perf-profile.calltrace.cycles-pp.sctp_sendmsg.sock_sendmsg.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg
      5.99            +5.1       11.06 ±  2%  perf-profile.calltrace.cycles-pp.__kmalloc_reserve.__alloc_skb._sctp_make_chunk.sctp_make_datafrag_empty.sctp_datamsg_from_user
      5.96            +5.1       11.03 ±  2%  perf-profile.calltrace.cycles-pp.kmalloc_large_node.__kmalloc_node_track_caller.__kmalloc_reserve.__alloc_skb._sctp_make_chunk
      5.97            +5.1       11.05 ±  2%  perf-profile.calltrace.cycles-pp.__kmalloc_node_track_caller.__kmalloc_reserve.__alloc_skb._sctp_make_chunk.sctp_make_datafrag_empty
      7.63            +6.5       14.09 ±  3%  perf-profile.calltrace.cycles-pp.__alloc_pages_nodemask.kmalloc_large_node.__kmalloc_node_track_caller.__kmalloc_reserve.__alloc_skb
      7.33            +6.5       13.86 ±  3%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_nodemask.kmalloc_large_node.__kmalloc_node_track_caller.__kmalloc_reserve
      5.58 ±  2%      +6.9       12.47 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.get_page_from_freelist.__alloc_pages_nodemask.kmalloc_large_node.__kmalloc_node_track_caller
      5.26 ±  2%      +7.0       12.24 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.get_page_from_freelist.__alloc_pages_nodemask.kmalloc_large_node
     35.73            -2.7       33.02 ±  5%  perf-profile.children.cycles-pp.intel_idle
     38.93            -2.7       36.26 ±  4%  perf-profile.children.cycles-pp.start_secondary
     39.06            -2.6       36.42 ±  4%  perf-profile.children.cycles-pp.do_idle
     39.06            -2.6       36.42 ±  4%  perf-profile.children.cycles-pp.secondary_startup_64
     39.06            -2.6       36.42 ±  4%  perf-profile.children.cycles-pp.cpu_startup_entry
     36.82            -2.5       34.32 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter
     36.81            -2.5       34.32 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter_state
     17.84 ±  2%      -2.2       15.63 ±  4%  perf-profile.children.cycles-pp.sctp_outq_flush
      7.99 ±  2%      -1.8        6.19 ±  4%  perf-profile.children.cycles-pp.__ip_queue_xmit
     15.83            -1.8       14.03 ±  4%  perf-profile.children.cycles-pp.sctp_packet_transmit
      7.83 ±  2%      -1.8        6.07 ±  4%  perf-profile.children.cycles-pp.ip_output
      7.69 ±  2%      -1.7        5.95 ±  4%  perf-profile.children.cycles-pp.ip_finish_output2
      7.33 ±  2%      -1.7        5.66 ±  4%  perf-profile.children.cycles-pp.__local_bh_enable_ip
      7.25 ±  2%      -1.7        5.59 ±  4%  perf-profile.children.cycles-pp.do_softirq
      7.19 ±  2%      -1.6        5.54 ±  4%  perf-profile.children.cycles-pp.do_softirq_own_stack
      7.07 ±  2%      -1.6        5.45 ±  4%  perf-profile.children.cycles-pp.net_rx_action
      6.98 ±  2%      -1.6        5.37 ±  4%  perf-profile.children.cycles-pp.process_backlog
      6.87 ±  2%      -1.6        5.28 ±  4%  perf-profile.children.cycles-pp.__netif_receive_skb_one_core
      7.43 ±  2%      -1.6        5.85 ±  5%  perf-profile.children.cycles-pp.__softirqentry_text_start
      6.71 ±  2%      -1.6        5.15 ±  4%  perf-profile.children.cycles-pp.ip_rcv
      6.63 ±  2%      -1.6        5.07 ±  4%  perf-profile.children.cycles-pp.ip_local_deliver
      6.59 ±  2%      -1.6        5.04 ±  4%  perf-profile.children.cycles-pp.ip_local_deliver_finish
      6.52 ±  2%      -1.6        4.97 ±  4%  perf-profile.children.cycles-pp.sctp_rcv
      6.57 ±  2%      -1.5        5.02 ±  4%  perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
      8.00            -1.5        6.48 ±  2%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
     10.09 ±  2%      -1.4        8.72 ±  3%  perf-profile.children.cycles-pp.sctp_primitive_SEND
      5.45            -1.2        4.23 ±  5%  perf-profile.children.cycles-pp.memcpy_erms
      4.45            -1.0        3.46 ±  5%  perf-profile.children.cycles-pp.sctp_user_addto_chunk
      4.32            -1.0        3.33 ±  5%  perf-profile.children.cycles-pp._copy_from_iter_full
      4.21            -1.0        3.24 ±  5%  perf-profile.children.cycles-pp.copyin
      3.16 ±  2%      -0.8        2.37 ±  5%  perf-profile.children.cycles-pp.sctp_ulpq_tail_data
      4.19 ±  3%      -0.6        3.59 ±  7%  perf-profile.children.cycles-pp.skb_copy_datagram_iter
      4.17 ±  3%      -0.6        3.58 ±  7%  perf-profile.children.cycles-pp.__skb_datagram_iter
      3.77 ±  3%      -0.5        3.22 ±  7%  perf-profile.children.cycles-pp._copy_to_iter
      2.45            -0.5        1.91 ±  3%  perf-profile.children.cycles-pp.sctp_skb_recv_datagram
      3.66 ±  3%      -0.5        3.12 ±  7%  perf-profile.children.cycles-pp.copyout
      1.93            -0.5        1.46 ±  5%  perf-profile.children.cycles-pp.sctp_ulpq_tail_event
      1.75            -0.4        1.33 ±  5%  perf-profile.children.cycles-pp.sctp_data_ready
      1.33            -0.4        0.93 ±  4%  perf-profile.children.cycles-pp.lock_sock_nested
      1.22            -0.4        0.85 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_bh
      1.57            -0.4        1.21 ±  6%  perf-profile.children.cycles-pp.__wake_up_common_lock
      1.46            -0.3        1.14 ±  6%  perf-profile.children.cycles-pp.__wake_up_common
      1.42            -0.3        1.10 ±  6%  perf-profile.children.cycles-pp.autoremove_wake_function
      1.39            -0.3        1.08 ±  6%  perf-profile.children.cycles-pp.try_to_wake_up
      1.07 ±  6%      -0.3        0.77 ±  5%  perf-profile.children.cycles-pp.sctp_ulpevent_make_rcvmsg
      0.83 ±  2%      -0.2        0.58 ±  5%  perf-profile.children.cycles-pp.__list_del_entry_valid
      1.84 ±  3%      -0.2        1.61 ±  4%  perf-profile.children.cycles-pp.__sched_text_start
      0.56 ±  3%      -0.2        0.33 ±  7%  perf-profile.children.cycles-pp.sctp_datamsg_put
      1.00            -0.2        0.77        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.53 ±  3%      -0.2        0.31 ±  7%  perf-profile.children.cycles-pp.sctp_chunk_free
      0.74 ±  8%      -0.2        0.52 ±  4%  perf-profile.children.cycles-pp.sctp_outq_select_transport
      0.92 ±  2%      -0.2        0.70 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.67 ±  9%      -0.2        0.46 ±  2%  perf-profile.children.cycles-pp.sctp_packet_config
      0.77 ±  4%      -0.2        0.57 ±  4%  perf-profile.children.cycles-pp.sctp_ulpevent_free
      0.73            -0.2        0.54 ±  3%  perf-profile.children.cycles-pp.kmem_cache_free
      0.85            -0.2        0.67        perf-profile.children.cycles-pp.skb_release_all
      0.84            -0.2        0.66        perf-profile.children.cycles-pp.skb_release_head_state
      1.10            -0.2        0.92 ±  4%  perf-profile.children.cycles-pp.copy_msghdr_from_user
      0.54 ±  8%      -0.2        0.37 ±  5%  perf-profile.children.cycles-pp.__skb_clone
      0.89            -0.1        0.74 ±  3%  perf-profile.children.cycles-pp._copy_from_user
      0.55 ±  2%      -0.1        0.41 ±  6%  perf-profile.children.cycles-pp.enqueue_entity
      0.65 ±  2%      -0.1        0.51 ±  7%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.64            -0.1        0.50 ±  7%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.87 ±  3%      -0.1        0.74 ±  6%  perf-profile.children.cycles-pp.schedule_idle
      0.64            -0.1        0.51 ±  8%  perf-profile.children.cycles-pp.activate_task
      0.58            -0.1        0.45 ±  5%  perf-profile.children.cycles-pp.sctp_chunkify
      0.40            -0.1        0.28 ±  5%  perf-profile.children.cycles-pp.__list_add_valid
      0.66 ±  2%      -0.1        0.54 ±  5%  perf-profile.children.cycles-pp.sendmsg_copy_msghdr
      0.41 ±  2%      -0.1        0.29 ±  5%  perf-profile.children.cycles-pp.__slab_free
      0.31 ± 14%      -0.1        0.20 ±  4%  perf-profile.children.cycles-pp.ipv4_dst_check
      1.00 ±  3%      -0.1        0.89 ±  3%  perf-profile.children.cycles-pp.schedule_timeout
      0.41 ±  7%      -0.1        0.30 ±  5%  perf-profile.children.cycles-pp.sctp_hash_cmp
      0.99 ±  3%      -0.1        0.88 ±  3%  perf-profile.children.cycles-pp.schedule
      0.28 ± 15%      -0.1        0.17 ±  4%  perf-profile.children.cycles-pp.__copy_skb_header
      0.39 ±  2%      -0.1        0.28 ±  4%  perf-profile.children.cycles-pp.sctp_addrs_lookup_transport
      0.42 ±  2%      -0.1        0.32 ±  3%  perf-profile.children.cycles-pp.copy_user_generic_unrolled
      0.22 ± 12%      -0.1        0.13 ±  5%  perf-profile.children.cycles-pp.sctp_transport_hold
      0.41 ±  8%      -0.1        0.33 ±  6%  perf-profile.children.cycles-pp.sctp_endpoint_lookup_assoc
      0.39 ±  7%      -0.1        0.30 ±  8%  perf-profile.children.cycles-pp.sctp_epaddr_lookup_transport
      0.45            -0.1        0.36 ±  4%  perf-profile.children.cycles-pp.__dev_queue_xmit
      0.48            -0.1        0.40 ±  7%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.41            -0.1        0.34 ±  5%  perf-profile.children.cycles-pp.___might_sleep
      0.32 ±  2%      -0.1        0.24 ±  6%  perf-profile.children.cycles-pp.sctp_addto_chunk
      0.32 ±  4%      -0.1        0.24 ±  4%  perf-profile.children.cycles-pp.sctp_eat_data
      0.47 ±  2%      -0.1        0.40 ±  4%  perf-profile.children.cycles-pp.import_iovec
      0.36            -0.1        0.29 ±  4%  perf-profile.children.cycles-pp.sockfd_lookup_light
      0.36 ±  2%      -0.1        0.29 ±  3%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.32            -0.1        0.25 ±  4%  perf-profile.children.cycles-pp.security_socket_sendmsg
      0.48            -0.1        0.41 ±  4%  perf-profile.children.cycles-pp.update_load_avg
      0.43            -0.1        0.36 ±  3%  perf-profile.children.cycles-pp.sctp_sf_eat_data_6_2
      0.23 ±  4%      -0.1        0.16 ±  6%  perf-profile.children.cycles-pp.skb_release_data
      0.35 ±  3%      -0.1        0.28 ±  4%  perf-profile.children.cycles-pp.sctp_wfree
      0.41 ±  3%      -0.1        0.35 ±  5%  perf-profile.children.cycles-pp.rw_copy_check_uvector
      0.23 ±  3%      -0.1        0.17 ±  5%  perf-profile.children.cycles-pp.memset_erms
      0.25 ±  2%      -0.1        0.19 ±  9%  perf-profile.children.cycles-pp.sctp_sock_rfree
      0.21 ±  3%      -0.1        0.15 ±  7%  perf-profile.children.cycles-pp.__switch_to
      0.15 ±  9%      -0.1        0.09 ±  8%  perf-profile.children.cycles-pp.ip_local_out
      0.22 ±  5%      -0.1        0.16 ±  6%  perf-profile.children.cycles-pp.skb_set_owner_w
      0.46 ±  5%      -0.1        0.40 ±  8%  perf-profile.children.cycles-pp.recvmsg_copy_msghdr
      0.52 ±  3%      -0.1        0.46 ±  3%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.29 ±  2%      -0.1        0.23 ±  2%  perf-profile.children.cycles-pp.__might_sleep
      0.36 ±  5%      -0.1        0.31 ±  3%  perf-profile.children.cycles-pp.aa_sk_perm
      0.29            -0.1        0.24 ±  5%  perf-profile.children.cycles-pp.__fget_light
      0.16 ±  2%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.36 ±  3%      -0.1        0.30 ±  3%  perf-profile.children.cycles-pp.sctp_sched_fcfs_dequeue
      0.15 ±  5%      -0.1        0.10 ±  5%  perf-profile.children.cycles-pp.rcu_idle_exit
      0.16 ±  2%      -0.1        0.11 ±  6%  perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.60 ±  2%      -0.1        0.55 ±  2%  perf-profile.children.cycles-pp.__check_object_size
      0.30            -0.1        0.24 ±  3%  perf-profile.children.cycles-pp.dev_hard_start_xmit
      0.26 ±  3%      -0.1        0.21 ±  5%  perf-profile.children.cycles-pp.sctp_make_sack
      0.27 ±  4%      -0.1        0.22        perf-profile.children.cycles-pp.loopback_xmit
      0.16 ±  9%      -0.1        0.11 ±  7%  perf-profile.children.cycles-pp.ipv4_mtu
      0.13 ±  6%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.rcu_eqs_exit
      0.22            -0.0        0.17 ±  6%  perf-profile.children.cycles-pp.sctp_inq_pop
      0.15 ±  3%      -0.0        0.11 ±  8%  perf-profile.children.cycles-pp.check_preempt_curr
      0.12 ±  5%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.ip_send_check
      0.17 ±  4%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.sctp_outq_flush_ctrl
      0.11 ±  3%      -0.0        0.07 ± 17%  perf-profile.children.cycles-pp.resched_curr
      0.22 ±  3%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.sock_kmalloc
      0.14 ±  5%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.sock_wfree
      0.14 ±  8%      -0.0        0.09 ±  7%  perf-profile.children.cycles-pp.__ip_local_out
      0.25 ±  3%      -0.0        0.20 ±  7%  perf-profile.children.cycles-pp.sctp_check_transmitted
      0.15 ±  3%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.sctp_transport_put
      0.22 ±  3%      -0.0        0.18 ±  9%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
      0.44 ±  5%      -0.0        0.40 ±  3%  perf-profile.children.cycles-pp.dequeue_entity
      0.18 ±  6%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.12 ±  8%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.sctp_chunk_hold
      0.11 ± 15%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__ip_finish_output
      0.07 ±  7%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.sctp_hash_key
      0.14 ± 11%      -0.0        0.10 ± 11%  perf-profile.children.cycles-pp.dst_release
      0.23 ±  2%      -0.0        0.20 ±  4%  perf-profile.children.cycles-pp.move_addr_to_kernel
      0.19 ±  5%      -0.0        0.15 ±  4%  perf-profile.children.cycles-pp.sctp_ulpevent_receive_data
      0.24 ±  2%      -0.0        0.21 ±  7%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.17 ±  2%      -0.0        0.14 ±  6%  perf-profile.children.cycles-pp.sctp_v4_addr_valid
      0.08 ±  6%      -0.0        0.04 ± 57%  perf-profile.children.cycles-pp.rcu_dynticks_eqs_exit
      0.06 ±  6%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.sctp_bind_addr_match
      0.17 ±  5%      -0.0        0.13        perf-profile.children.cycles-pp.sctp_association_put
      0.16 ±  2%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.sock_kfree_s
      0.19            -0.0        0.16 ±  7%  perf-profile.children.cycles-pp.update_rq_clock
      0.17            -0.0        0.14 ±  6%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.18 ±  2%      -0.0        0.15 ±  8%  perf-profile.children.cycles-pp.__zone_watermark_ok
      0.13 ±  9%      -0.0        0.10 ±  7%  perf-profile.children.cycles-pp.__netif_receive_skb_core
      0.36            -0.0        0.33 ±  5%  perf-profile.children.cycles-pp.kfree
      0.20 ±  4%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.sctp_sched_dequeue_common
      0.11 ±  4%      -0.0        0.08 ± 14%  perf-profile.children.cycles-pp.sctp_association_hold
      0.07 ±  5%      -0.0        0.04 ± 57%  perf-profile.children.cycles-pp.sctp_v4_from_skb
      0.07 ±  6%      -0.0        0.04 ± 58%  perf-profile.children.cycles-pp.pick_next_entity
      0.07 ±  7%      -0.0        0.04 ± 57%  perf-profile.children.cycles-pp.validate_xmit_skb
      0.30            -0.0        0.28 ±  5%  perf-profile.children.cycles-pp.sctp_packet_transmit_chunk
      0.20 ±  4%      -0.0        0.18 ±  6%  perf-profile.children.cycles-pp.update_curr
      0.14            -0.0        0.12 ±  7%  perf-profile.children.cycles-pp.sctp_sockaddr_af
      0.14 ±  3%      -0.0        0.11        perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.10 ±  7%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.del_timer
      0.09 ±  9%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.sctp_transport_reset_t3_rtx
      0.12 ±  8%      -0.0        0.10 ±  7%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.09 ±  4%      -0.0        0.07 ± 14%  perf-profile.children.cycles-pp.sctp_assoc_rwnd_increase
      0.13 ±  6%      -0.0        0.11 ± 10%  perf-profile.children.cycles-pp.skb_clone
      0.08 ± 10%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.sctp_v4_ecn_capable
      0.12 ±  5%      -0.0        0.10 ±  7%  perf-profile.children.cycles-pp.mod_timer
      0.14 ±  6%      -0.0        0.12 ±  5%  perf-profile.children.cycles-pp.__kmalloc
      0.08 ±  6%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.account_entity_dequeue
      0.08 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.09 ±  4%      -0.0        0.07        perf-profile.children.cycles-pp.lock_timer_base
      0.14 ±  6%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.mod_node_page_state
      0.10 ±  4%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.sctp_validate_data
      0.08 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.enqueue_to_backlog
      0.11 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__switch_to_asm
      0.09 ±  4%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.netif_rx
      0.09            -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.netif_rx_internal
      0.08            -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.__x64_sys_sendmsg
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.__free_pages
      0.07 ± 10%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.___perf_sw_event
      0.05 ± 60%      +0.0        0.09 ± 15%  perf-profile.children.cycles-pp.irq_enter
      0.01 ±173%      +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.tick_irq_enter
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.load_balance
      2.75 ±  5%      +0.9        3.69 ± 13%  perf-profile.children.cycles-pp.kfree_skb
     25.85            +2.0       27.81 ±  2%  perf-profile.children.cycles-pp.sctp_cmd_interpreter
     23.41            +2.0       25.38 ±  2%  perf-profile.children.cycles-pp.sctp_sendmsg_to_asoc
     25.96            +2.0       27.94 ±  2%  perf-profile.children.cycles-pp.sctp_do_sm
     19.22            +2.5       21.76 ±  2%  perf-profile.children.cycles-pp.sctp_assoc_bh_rcv
     58.51            +3.2       61.68 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     58.31            +3.2       61.52 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
     16.37            +3.2       19.60 ±  2%  perf-profile.children.cycles-pp.release_sock
     16.19            +3.3       19.46 ±  2%  perf-profile.children.cycles-pp.__release_sock
     16.11            +3.3       19.40 ±  2%  perf-profile.children.cycles-pp.sctp_backlog_rcv
     12.87            +3.4       16.28 ±  2%  perf-profile.children.cycles-pp.sctp_datamsg_from_user
      7.65 ±  2%      +4.3       11.90        perf-profile.children.cycles-pp.sctp_outq_sack
      7.37 ±  2%      +4.4       11.72        perf-profile.children.cycles-pp.sctp_chunk_put
      6.81 ±  2%      +4.5       11.31        perf-profile.children.cycles-pp.consume_skb
     42.95            +4.6       47.55 ±  2%  perf-profile.children.cycles-pp.__sys_sendmsg
      7.74            +4.6       12.34 ±  2%  perf-profile.children.cycles-pp.sctp_make_datafrag_empty
     42.70            +4.6       47.35 ±  2%  perf-profile.children.cycles-pp.___sys_sendmsg
      7.52            +4.7       12.17 ±  2%  perf-profile.children.cycles-pp._sctp_make_chunk
     42.00            +4.8       46.78 ±  2%  perf-profile.children.cycles-pp.____sys_sendmsg
     41.21            +4.9       46.12 ±  2%  perf-profile.children.cycles-pp.sock_sendmsg
     40.84            +5.0       45.82 ±  2%  perf-profile.children.cycles-pp.sctp_sendmsg
      7.75 ±  2%      +5.7       13.48 ±  4%  perf-profile.children.cycles-pp.free_one_page
      8.12 ±  2%      +5.7       13.86 ±  4%  perf-profile.children.cycles-pp.__free_pages_ok
      7.47 ±  2%      +5.8       13.30 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock
      8.98            +6.1       15.05 ±  2%  perf-profile.children.cycles-pp.__alloc_skb
      7.92            +6.4       14.31 ±  3%  perf-profile.children.cycles-pp.__kmalloc_reserve
      7.87            +6.4       14.29 ±  2%  perf-profile.children.cycles-pp.__kmalloc_node_track_caller
      7.77            +6.4       14.21 ±  2%  perf-profile.children.cycles-pp.kmalloc_large_node
      7.64            +6.5       14.10 ±  3%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      7.35            +6.5       13.88 ±  3%  perf-profile.children.cycles-pp.get_page_from_freelist
      6.01 ±  2%      +6.8       12.84 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     12.88 ±  2%     +12.8       25.66 ±  4%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     35.73            -2.7       33.02 ±  5%  perf-profile.self.cycles-pp.intel_idle
      7.95            -1.5        6.43 ±  2%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      5.40            -1.2        4.20 ±  5%  perf-profile.self.cycles-pp.memcpy_erms
      2.65            -0.6        2.05        perf-profile.self.cycles-pp.do_syscall_64
      0.78            -0.3        0.50 ±  4%  perf-profile.self.cycles-pp.__alloc_skb
      0.81            -0.3        0.56        perf-profile.self.cycles-pp._raw_spin_lock
      0.81 ±  2%      -0.2        0.56 ±  5%  perf-profile.self.cycles-pp.__list_del_entry_valid
      1.00            -0.2        0.77        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.92 ±  2%      -0.2        0.70 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.51 ±  4%      -0.2        0.29 ±  7%  perf-profile.self.cycles-pp.sctp_datamsg_put
      0.57            -0.2        0.38 ±  2%  perf-profile.self.cycles-pp.sctp_datamsg_from_user
      0.70 ±  3%      -0.2        0.53 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.75 ±  2%      -0.1        0.61 ±  5%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.38            -0.1        0.26 ±  7%  perf-profile.self.cycles-pp.__list_add_valid
      0.41            -0.1        0.30 ±  6%  perf-profile.self.cycles-pp.sctp_recvmsg
      0.30 ± 14%      -0.1        0.19 ±  6%  perf-profile.self.cycles-pp.ipv4_dst_check
      0.28 ± 15%      -0.1        0.17 ±  7%  perf-profile.self.cycles-pp.__copy_skb_header
      0.40 ±  2%      -0.1        0.29 ±  5%  perf-profile.self.cycles-pp.__slab_free
      0.33 ±  2%      -0.1        0.24 ±  7%  perf-profile.self.cycles-pp.free_one_page
      0.39 ±  2%      -0.1        0.30 ±  3%  perf-profile.self.cycles-pp.copy_user_generic_unrolled
      0.34 ± 13%      -0.1        0.25        perf-profile.self.cycles-pp.sctp_cmd_interpreter
      0.21 ± 13%      -0.1        0.12 ±  4%  perf-profile.self.cycles-pp.sctp_transport_hold
      0.39 ±  5%      -0.1        0.31 ±  5%  perf-profile.self.cycles-pp.sctp_packet_transmit
      0.46 ±  2%      -0.1        0.38 ±  5%  perf-profile.self.cycles-pp.sctp_outq_flush
      0.30 ±  2%      -0.1        0.22 ±  3%  perf-profile.self.cycles-pp.sctp_chunk_put
      0.33            -0.1        0.25 ±  7%  perf-profile.self.cycles-pp.kmem_cache_free
      0.40            -0.1        0.33 ±  6%  perf-profile.self.cycles-pp.___might_sleep
      0.27 ±  5%      -0.1        0.20 ±  6%  perf-profile.self.cycles-pp.sctp_rcv
      0.26 ±  7%      -0.1        0.18 ±  8%  perf-profile.self.cycles-pp.sctp_packet_config
      0.18 ±  3%      -0.1        0.11 ± 11%  perf-profile.self.cycles-pp.sctp_ulpq_tail_event
      0.18 ±  2%      -0.1        0.11        perf-profile.self.cycles-pp.sctp_chunkify
      0.23 ±  4%      -0.1        0.16 ±  6%  perf-profile.self.cycles-pp.skb_release_data
      0.23 ±  6%      -0.1        0.16 ±  5%  perf-profile.self.cycles-pp.__alloc_pages_nodemask
      0.33 ±  3%      -0.1        0.27 ±  7%  perf-profile.self.cycles-pp.__sched_text_start
      0.26 ±  2%      -0.1        0.20 ±  7%  perf-profile.self.cycles-pp.__skb_clone
      0.22 ±  3%      -0.1        0.16 ±  4%  perf-profile.self.cycles-pp.memset_erms
      0.22 ±  5%      -0.1        0.16 ±  5%  perf-profile.self.cycles-pp.skb_set_owner_w
      0.20 ±  4%      -0.1        0.14 ±  7%  perf-profile.self.cycles-pp.__switch_to
      0.15 ±  3%      -0.1        0.10 ±  5%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.24            -0.1        0.18 ±  9%  perf-profile.self.cycles-pp.sctp_sock_rfree
      0.28            -0.1        0.22 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock_bh
      0.31 ±  2%      -0.1        0.26 ±  3%  perf-profile.self.cycles-pp.__x86_indirect_thunk_rax
      0.18 ± 10%      -0.1        0.12 ±  6%  perf-profile.self.cycles-pp.sctp_data_ready
      0.27 ±  2%      -0.1        0.21 ±  4%  perf-profile.self.cycles-pp.__might_sleep
      0.29 ±  2%      -0.1        0.24 ±  5%  perf-profile.self.cycles-pp.__fget_light
      0.12 ±  7%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.ip_send_check
      0.29 ±  6%      -0.0        0.24 ±  4%  perf-profile.self.cycles-pp.__check_object_size
      0.27 ±  4%      -0.0        0.22        perf-profile.self.cycles-pp.sctp_wfree
      0.26 ±  7%      -0.0        0.21 ±  5%  perf-profile.self.cycles-pp.sctp_sendmsg
      0.15 ± 10%      -0.0        0.10 ±  7%  perf-profile.self.cycles-pp.ipv4_mtu
      0.11 ±  3%      -0.0        0.07 ± 17%  perf-profile.self.cycles-pp.resched_curr
      0.22 ±  9%      -0.0        0.17 ±  4%  perf-profile.self.cycles-pp.sctp_skb_recv_datagram
      0.14 ±  5%      -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.sock_wfree
      0.15 ±  3%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.sctp_eat_data
      0.13 ± 13%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.dst_release
      0.15 ±  4%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.sctp_transport_put
      0.08 ± 12%      -0.0        0.04 ± 57%  perf-profile.self.cycles-pp.sctp_ulpevent_free
      0.07 ±  7%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.pick_next_entity
      0.07 ±  7%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.sctp_hash_key
      0.33 ±  2%      -0.0        0.29 ±  6%  perf-profile.self.cycles-pp.__free_pages_ok
      0.12 ±  5%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.sctp_chunk_hold
      0.08 ±  6%      -0.0        0.04 ± 57%  perf-profile.self.cycles-pp.rcu_dynticks_eqs_exit
      0.14 ±  3%      -0.0        0.10 ±  8%  perf-profile.self.cycles-pp.enqueue_entity
      0.18 ±  7%      -0.0        0.14 ±  5%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.17 ±  5%      -0.0        0.13        perf-profile.self.cycles-pp.sctp_association_put
      0.21 ±  5%      -0.0        0.18 ±  7%  perf-profile.self.cycles-pp.____sys_recvmsg
      0.20 ±  2%      -0.0        0.17 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.15 ±  3%      -0.0        0.12 ±  6%  perf-profile.self.cycles-pp.sctp_v4_addr_valid
      0.14 ±  8%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.sctp_epaddr_lookup_transport
      0.14 ±  3%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.set_next_entity
      0.16 ±  4%      -0.0        0.13        perf-profile.self.cycles-pp.do_idle
      0.16 ±  2%      -0.0        0.13 ±  8%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.13 ±  9%      -0.0        0.10 ±  7%  perf-profile.self.cycles-pp.__netif_receive_skb_core
      0.18 ±  2%      -0.0        0.15 ±  8%  perf-profile.self.cycles-pp.__zone_watermark_ok
      0.20 ±  4%      -0.0        0.17 ±  7%  perf-profile.self.cycles-pp.sctp_sendmsg_to_asoc
      0.09 ±  7%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.sctp_assoc_rwnd_increase
      0.15 ±  4%      -0.0        0.12 ± 12%  perf-profile.self.cycles-pp.kmem_cache_alloc_node
      0.12 ±  7%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.__softirqentry_text_start
      0.11 ±  4%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.sctp_check_transmitted
      0.10 ±  7%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.sctp_ulpevent_make_rcvmsg
      0.14 ±  3%      -0.0        0.11 ±  6%  perf-profile.self.cycles-pp.__skb_datagram_iter
      0.16 ±  2%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.sctp_sched_fcfs_dequeue
      0.12 ±  4%      -0.0        0.10        perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.12 ±  5%      -0.0        0.10 ± 11%  perf-profile.self.cycles-pp.ip_finish_output2
      0.08 ±  5%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.sock_kmalloc
      0.06 ±  6%      -0.0        0.04 ± 57%  perf-profile.self.cycles-pp.sockfd_lookup_light
      0.10 ±  7%      -0.0        0.08 ± 14%  perf-profile.self.cycles-pp.sctp_association_hold
      0.09 ±  4%      -0.0        0.07 ± 10%  perf-profile.self.cycles-pp.__local_bh_enable_ip
      0.11 ±  4%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.sctp_ulpevent_receive_data
      0.11 ±  4%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.sctp_make_datafrag_empty
      0.09 ±  4%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.consume_skb
      0.09 ±  4%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.sctp_inq_pop
      0.08 ±  5%      -0.0        0.06 ± 13%  perf-profile.self.cycles-pp.__kmalloc_node_track_caller
      0.14 ±  3%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.mod_node_page_state
      0.07 ±  5%      -0.0        0.05 ±  9%  perf-profile.self.cycles-pp.account_entity_dequeue
      0.08 ±  6%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.sctp_v4_ecn_capable
      0.09 ± 10%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.rw_copy_check_uvector
      0.11 ±  3%      -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.__switch_to_asm
      0.11 ±  4%      -0.0        0.10 ±  8%  perf-profile.self.cycles-pp.sctp_sched_dequeue_common
      0.08 ±  5%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.11 ±  4%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.update_curr
      0.09 ±  4%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.copy_msghdr_from_user
      0.08            -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.__sctp_packet_append_chunk
      0.08 ±  5%      -0.0        0.07        perf-profile.self.cycles-pp.sctp_addrs_lookup_transport
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.__free_pages
      0.06 ±  7%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.___perf_sw_event
     12.88 ±  2%     +12.8       25.66 ±  4%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



***************************************************************************************************
lkp-skl-fpga01: 104 threads Skylake with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase/ucode:
  gcc-7/performance/x86_64-rhel-7.6/30%/debian-x86_64-20191114.cgz/300s/lkp-skl-fpga01/whetstone-double/unixbench/0x2000065

commit: 
  9c40365a65 ("threads: Update PID limit comment according to futex UAPI change")
  59901cb452 ("sched/fair: Don't pull task if local group is more loaded than busiest group")

9c40365a65d62d7c 59901cb4520c44bfce81f523bc6 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     23098            -4.0%      22179        unixbench.score
    474.19            +2.0%     483.52        unixbench.time.elapsed_time
    474.19            +2.0%     483.52        unixbench.time.elapsed_time.max
     20407           -15.6%      17220        unixbench.time.involuntary_context_switches
     11653            +2.5%      11940        unixbench.time.user_time
      6674            -2.7%       6494        unixbench.time.voluntary_context_switches
  60218701            -2.2%   58918844        unixbench.workload
     51504 ±  2%     +61.4%      83147 ± 16%  cpuidle.C1.usage
     45407 ±  4%      +9.0%      49503 ±  6%  meminfo.Shmem
      0.00 ±117%      +0.0        0.03 ± 78%  mpstat.cpu.all.soft%
      1505            +5.3%       1584        vmstat.system.cs
      9163            -9.2%       8320 ±  6%  numa-meminfo.node0.KernelStack
    992.75 ± 12%     -49.9%     497.00 ± 65%  numa-meminfo.node1.Mlocked
    535099 ±  2%      -7.3%     496178 ±  3%  numa-meminfo.node1.Unevictable
      9165            -9.1%       8327 ±  6%  numa-vmstat.node0.nr_kernel_stack
    133774 ±  2%      -7.3%     124044 ±  3%  numa-vmstat.node1.nr_unevictable
    133774 ±  2%      -7.3%     124044 ±  3%  numa-vmstat.node1.nr_zone_unevictable
      1.24 ± 16%      -0.7        0.49 ± 32%  perf-profile.children.cycles-pp.ktime_get
      0.94 ± 18%      -0.5        0.43 ± 29%  perf-profile.children.cycles-pp.clockevents_program_event
      0.11 ± 36%      +0.1        0.20 ± 32%  perf-profile.children.cycles-pp.tick_irq_enter
      1.12 ± 17%      -0.7        0.38 ± 49%  perf-profile.self.cycles-pp.ktime_get
    842912 ± 13%     -42.0%     489022 ± 36%  numa-numastat.node0.local_node
    851323 ± 14%     -39.6%     514237 ± 31%  numa-numastat.node0.numa_hit
      8420 ±172%    +199.5%      25221 ± 57%  numa-numastat.node0.other_node
    780061 ± 13%     +47.3%    1149237 ± 15%  numa-numastat.node1.local_node
    805331 ± 14%     +43.8%    1157736 ± 14%  numa-numastat.node1.numa_hit
     92.00 ±  6%      -5.4%      87.00        proc-vmstat.nr_dirtied
     11349 ±  4%      +9.0%      12374 ±  6%  proc-vmstat.nr_shmem
     19448            -1.5%      19147        proc-vmstat.nr_slab_reclaimable
     44561            -3.1%      43181        proc-vmstat.nr_slab_unreclaimable
     13330 ± 44%     -84.1%       2121 ± 82%  proc-vmstat.numa_hint_faults
      5558 ±107%     -99.3%      37.25 ±148%  proc-vmstat.numa_hint_faults_local
     51552 ± 33%     -54.6%      23426 ± 53%  proc-vmstat.numa_pte_updates
      5345 ± 12%     +24.6%       6662 ± 16%  proc-vmstat.pgactivate
   1739692            +1.0%    1756902        proc-vmstat.pgfree
      1018 ±  7%     -16.4%     850.75 ±  5%  slabinfo.file_lock_cache.active_objs
      1018 ±  7%     -16.4%     850.75 ±  5%  slabinfo.file_lock_cache.num_objs
      4826           -11.2%       4285 ±  3%  slabinfo.files_cache.active_objs
      4826           -11.2%       4285 ±  3%  slabinfo.files_cache.num_objs
      2826 ±  2%     -11.0%       2515        slabinfo.sighand_cache.active_objs
      2828 ±  2%     -11.0%       2517        slabinfo.sighand_cache.num_objs
      1151 ±  2%     -24.1%     873.25 ± 22%  slabinfo.task_group.active_objs
      1151 ±  2%     -24.1%     873.25 ± 22%  slabinfo.task_group.num_objs
     59534 ±  2%      -9.2%      54079 ±  3%  slabinfo.vm_area_struct.active_objs
      1490 ±  2%      -9.1%       1354 ±  3%  slabinfo.vm_area_struct.active_slabs
     59640 ±  2%      -9.1%      54195 ±  3%  slabinfo.vm_area_struct.num_objs
      1490 ±  2%      -9.1%       1354 ±  3%  slabinfo.vm_area_struct.num_slabs
 7.107e+09            -2.7%  6.915e+09        perf-stat.i.branch-instructions
     12.39 ± 15%      -6.0        6.37 ± 23%  perf-stat.i.cache-miss-rate%
      1477            +5.5%       1558        perf-stat.i.context-switches
    111.88            -1.3%     110.46        perf-stat.i.cpu-migrations
 1.099e+10            -2.5%  1.071e+10        perf-stat.i.dTLB-loads
 3.823e+09            -2.6%  3.724e+09        perf-stat.i.dTLB-stores
   2132180           -20.1%    1703908 ± 14%  perf-stat.i.iTLB-loads
 6.802e+10            -2.7%  6.618e+10        perf-stat.i.instructions
      0.88            -4.5%       0.84 ±  2%  perf-stat.i.ipc
      4076            -1.5%       4014        perf-stat.i.minor-faults
    107204 ±  2%     -31.1%      73884 ± 11%  perf-stat.i.node-load-misses
     14357 ±  5%      -9.6%      12974 ±  3%  perf-stat.i.node-loads
     26949 ±  4%     -51.0%      13212 ± 18%  perf-stat.i.node-store-misses
      4076            -1.5%       4014        perf-stat.i.page-faults
     12.57 ± 16%      -6.1        6.42 ± 24%  perf-stat.overall.cache-miss-rate%
      1.04            +3.8%       1.08        perf-stat.overall.cpi
      0.96            -3.6%       0.93        perf-stat.overall.ipc
     88.19            -3.3       84.92        perf-stat.overall.node-load-miss-rate%
     78.98           -11.9       67.04 ±  8%  perf-stat.overall.node-store-miss-rate%
    536500            +1.3%     543249        perf-stat.overall.path-length
 7.106e+09            -2.8%  6.907e+09        perf-stat.ps.branch-instructions
      1474            +5.5%       1554        perf-stat.ps.context-switches
    111.66            -1.3%     110.22        perf-stat.ps.cpu-migrations
 1.098e+10            -2.6%   1.07e+10        perf-stat.ps.dTLB-loads
 3.823e+09            -2.7%  3.719e+09        perf-stat.ps.dTLB-stores
   2128273           -20.1%    1700626 ± 14%  perf-stat.ps.iTLB-loads
 6.801e+10            -2.8%   6.61e+10        perf-stat.ps.instructions
      4061            -1.4%       4004        perf-stat.ps.minor-faults
    107032 ±  2%     -31.1%      73785 ± 11%  perf-stat.ps.node-load-misses
     14320 ±  5%      -9.5%      12960 ±  3%  perf-stat.ps.node-loads
     26906 ±  4%     -51.0%      13193 ± 18%  perf-stat.ps.node-store-misses
      4061            -1.4%       4004        perf-stat.ps.page-faults
     51615 ±  9%     +38.7%      71599 ± 14%  sched_debug.cfs_rq:/.exec_clock.avg
     89952 ±  7%     +79.0%     160981 ± 14%  sched_debug.cfs_rq:/.exec_clock.max
      6590 ± 39%     -88.3%     770.93 ±168%  sched_debug.cfs_rq:/.exec_clock.min
     21438 ±  5%    +140.7%      51593 ± 19%  sched_debug.cfs_rq:/.exec_clock.stddev
   1649313 ±  8%     +39.8%    2305637 ± 14%  sched_debug.cfs_rq:/.min_vruntime.avg
   2846100 ±  7%     +82.5%    5195365 ± 14%  sched_debug.cfs_rq:/.min_vruntime.max
    225248 ± 36%     -87.1%      29096 ±143%  sched_debug.cfs_rq:/.min_vruntime.min
    677866 ±  5%    +145.1%    1661129 ± 19%  sched_debug.cfs_rq:/.min_vruntime.stddev
    130.54 ±  7%     -54.9%      58.93 ±100%  sched_debug.cfs_rq:/.removed.load_avg.max
     19.52 ± 32%     -67.2%       6.41 ±100%  sched_debug.cfs_rq:/.removed.load_avg.stddev
    130.54 ±  7%     -54.9%      58.93 ±100%  sched_debug.cfs_rq:/.removed.runnable_avg.max
     19.52 ± 32%     -67.2%       6.41 ±100%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
  -1075371          -254.5%    1660977 ± 63%  sched_debug.cfs_rq:/.spread0.avg
    121453 ± 95%   +3646.9%    4550704 ± 34%  sched_debug.cfs_rq:/.spread0.max
  -2499411           -75.4%    -615566        sched_debug.cfs_rq:/.spread0.min
    677861 ±  5%    +145.1%    1661130 ± 19%  sched_debug.cfs_rq:/.spread0.stddev
      6.00 ±  7%     -31.6%       4.10 ± 10%  sched_debug.cfs_rq:/.util_est_enqueued.avg
     25.29 ±  7%     -22.8%      19.52 ±  7%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    241338 ±  5%     +12.8%     272122 ±  4%  sched_debug.cpu.clock.avg
    241342 ±  5%     +12.8%     272127 ±  4%  sched_debug.cpu.clock.max
    241333 ±  5%     +12.8%     272117 ±  4%  sched_debug.cpu.clock.min
      2.47 ±  2%     +12.0%       2.76 ±  4%  sched_debug.cpu.clock.stddev
    241338 ±  5%     +12.8%     272122 ±  4%  sched_debug.cpu.clock_task.avg
    241342 ±  5%     +12.8%     272127 ±  4%  sched_debug.cpu.clock_task.max
    241333 ±  5%     +12.8%     272117 ±  4%  sched_debug.cpu.clock_task.min
      2.47 ±  2%     +12.0%       2.76 ±  4%  sched_debug.cpu.clock_task.stddev
      4932 ±  3%     +12.7%       5557 ±  3%  sched_debug.cpu.nr_switches.avg
      3525 ±  5%     +43.7%       5065 ± 17%  sched_debug.cpu.nr_switches.stddev
      2933 ±  5%     +20.6%       3536 ±  5%  sched_debug.cpu.sched_count.avg
     19139 ± 27%     +56.8%      30011 ± 48%  sched_debug.cpu.sched_count.max
      2773 ± 10%     +55.8%       4320 ± 18%  sched_debug.cpu.sched_count.stddev
      1280 ±  5%     +22.6%       1568 ±  6%  sched_debug.cpu.sched_goidle.avg
      9370 ± 27%     +57.8%      14789 ± 48%  sched_debug.cpu.sched_goidle.max
      1374 ± 10%     +56.0%       2144 ± 19%  sched_debug.cpu.sched_goidle.stddev
      1302 ±  5%     +21.4%       1581 ±  6%  sched_debug.cpu.ttwu_count.avg
      1455 ±  4%     +56.4%       2276 ± 19%  sched_debug.cpu.ttwu_count.stddev
    594.81 ±  4%     +28.4%     763.77 ±  7%  sched_debug.cpu.ttwu_local.avg
      2311 ± 24%     +79.3%       4143 ± 10%  sched_debug.cpu.ttwu_local.max
    345.75 ±  7%    +105.0%     708.72 ±  4%  sched_debug.cpu.ttwu_local.stddev
    241334 ±  5%     +12.8%     272118 ±  4%  sched_debug.cpu_clk
    240831 ±  5%     +12.8%     271615 ±  4%  sched_debug.ktime
    241752 ±  5%     +12.7%     272537 ±  4%  sched_debug.sched_clk
     74.25 ±159%     -97.0%       2.25 ±101%  interrupts.CPU1.TLB:TLB_shootdowns
    105.75 ± 40%   +3409.2%       3711 ± 64%  interrupts.CPU100.NMI:Non-maskable_interrupts
    105.75 ± 40%   +3409.2%       3711 ± 64%  interrupts.CPU100.PMI:Performance_monitoring_interrupts
    159.00 ± 10%     +64.2%     261.00 ± 22%  interrupts.CPU100.RES:Rescheduling_interrupts
      1558 ±163%    +190.8%       4532 ± 53%  interrupts.CPU101.NMI:Non-maskable_interrupts
      1558 ±163%    +190.8%       4532 ± 53%  interrupts.CPU101.PMI:Performance_monitoring_interrupts
    179.25 ±  6%     +48.5%     266.25 ± 12%  interrupts.CPU101.RES:Rescheduling_interrupts
    143.00 ± 82%   +2066.4%       3098 ± 83%  interrupts.CPU102.NMI:Non-maskable_interrupts
    143.00 ± 82%   +2066.4%       3098 ± 83%  interrupts.CPU102.PMI:Performance_monitoring_interrupts
    173.50 ± 19%     +66.9%     289.50 ±  9%  interrupts.CPU102.RES:Rescheduling_interrupts
    193.75 ±  6%     +68.5%     326.50 ± 17%  interrupts.CPU103.RES:Rescheduling_interrupts
      3261 ±140%     -96.0%     129.00 ±128%  interrupts.CPU12.RES:Rescheduling_interrupts
    398.25 ±110%     -99.4%       2.50 ±103%  interrupts.CPU16.TLB:TLB_shootdowns
    146.25 ±160%     -97.9%       3.00 ± 62%  interrupts.CPU26.TLB:TLB_shootdowns
    372.25 ± 79%     -99.0%       3.75 ± 51%  interrupts.CPU29.TLB:TLB_shootdowns
    101.50 ±107%     -97.0%       3.00 ± 84%  interrupts.CPU3.TLB:TLB_shootdowns
     98.75 ± 21%   +6523.3%       6540 ±168%  interrupts.CPU31.RES:Rescheduling_interrupts
     94.50 ± 38%    +110.3%     198.75 ± 22%  interrupts.CPU33.RES:Rescheduling_interrupts
    100.25 ± 38%    +114.2%     214.75 ± 31%  interrupts.CPU34.RES:Rescheduling_interrupts
     81.50 ± 18%    +140.8%     196.25 ± 49%  interrupts.CPU35.RES:Rescheduling_interrupts
     88.75 ± 45%   +5932.7%       5354 ±167%  interrupts.CPU36.RES:Rescheduling_interrupts
     71.25 ± 26%    +111.2%     150.50 ± 16%  interrupts.CPU38.RES:Rescheduling_interrupts
     65.25 ± 28%    +136.8%     154.50 ± 20%  interrupts.CPU39.RES:Rescheduling_interrupts
     45.75 ± 12%    +288.0%     177.50 ± 51%  interrupts.CPU40.RES:Rescheduling_interrupts
     75.00 ± 21%     +69.0%     126.75 ±  7%  interrupts.CPU41.RES:Rescheduling_interrupts
    618.25 ±144%    +554.8%       4048 ± 51%  interrupts.CPU42.NMI:Non-maskable_interrupts
    618.25 ±144%    +554.8%       4048 ± 51%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
     80.25 ± 16%    +132.1%     186.25 ± 23%  interrupts.CPU42.RES:Rescheduling_interrupts
    861.75 ± 99%    +596.3%       6000 ± 30%  interrupts.CPU43.NMI:Non-maskable_interrupts
    861.75 ± 99%    +596.3%       6000 ± 30%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
     69.25 ± 17%    +173.6%     189.50 ± 10%  interrupts.CPU43.RES:Rescheduling_interrupts
     96.25 ± 50%     +99.0%     191.50 ± 13%  interrupts.CPU44.RES:Rescheduling_interrupts
      1133 ± 91%    +246.8%       3931 ± 27%  interrupts.CPU45.NMI:Non-maskable_interrupts
      1133 ± 91%    +246.8%       3931 ± 27%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
    617.00 ±146%    +614.5%       4408 ± 38%  interrupts.CPU47.NMI:Non-maskable_interrupts
    617.00 ±146%    +614.5%       4408 ± 38%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
    617.00 ±146%    +945.3%       6449 ± 22%  interrupts.CPU49.NMI:Non-maskable_interrupts
    617.00 ±146%    +945.3%       6449 ± 22%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
     81.00 ± 55%   +2323.5%       1963 ±159%  interrupts.CPU49.RES:Rescheduling_interrupts
      3679 ± 63%     -96.8%     116.25 ± 40%  interrupts.CPU5.NMI:Non-maskable_interrupts
      3679 ± 63%     -96.8%     116.25 ± 40%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
      3501 ± 37%     -96.4%     124.50 ± 43%  interrupts.CPU57.NMI:Non-maskable_interrupts
      3501 ± 37%     -96.4%     124.50 ± 43%  interrupts.CPU57.PMI:Performance_monitoring_interrupts
      4911 ±  6%     -72.3%       1362 ±157%  interrupts.CPU62.NMI:Non-maskable_interrupts
      4911 ±  6%     -72.3%       1362 ±157%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
      4086 ± 36%     -67.1%       1342 ±157%  interrupts.CPU64.NMI:Non-maskable_interrupts
      4086 ± 36%     -67.1%       1342 ±157%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
    245.25 ± 44%     -85.4%      35.75 ± 97%  interrupts.CPU7.RES:Rescheduling_interrupts
     63.00 ± 71%     -94.4%       3.50 ± 95%  interrupts.CPU77.RES:Rescheduling_interrupts
      2334 ± 51%    +217.0%       7399 ±  6%  interrupts.CPU78.NMI:Non-maskable_interrupts
      2334 ± 51%    +217.0%       7399 ±  6%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
    132.75 ± 21%    +157.6%     342.00 ± 22%  interrupts.CPU78.RES:Rescheduling_interrupts
    128.25 ± 27%    +103.5%     261.00 ± 14%  interrupts.CPU79.RES:Rescheduling_interrupts
      3236 ±143%     -99.0%      33.00 ±101%  interrupts.CPU8.RES:Rescheduling_interrupts
      2481 ± 43%    +179.1%       6924 ± 17%  interrupts.CPU80.NMI:Non-maskable_interrupts
      2481 ± 43%    +179.1%       6924 ± 17%  interrupts.CPU80.PMI:Performance_monitoring_interrupts
    132.50 ±  9%    +100.9%     266.25 ± 14%  interrupts.CPU80.RES:Rescheduling_interrupts
    131.50 ± 33%     +90.3%     250.25 ± 20%  interrupts.CPU81.RES:Rescheduling_interrupts
      1570 ± 63%    +371.1%       7400 ±  6%  interrupts.CPU82.NMI:Non-maskable_interrupts
      1570 ± 63%    +371.1%       7400 ±  6%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
    131.75 ± 13%   +2020.3%       2793 ±159%  interrupts.CPU82.RES:Rescheduling_interrupts
    769.50 ±130%     -87.3%      97.50 ±105%  interrupts.CPU9.RES:Rescheduling_interrupts
    147.50 ± 19%     +79.3%     264.50 ± 21%  interrupts.CPU90.RES:Rescheduling_interrupts
    180.50 ±  9%   +1677.8%       3209 ±158%  interrupts.CPU91.RES:Rescheduling_interrupts
    164.50 ± 20%    +119.1%     360.50 ± 26%  interrupts.CPU93.RES:Rescheduling_interrupts
      1573 ±162%    +307.6%       6411 ± 23%  interrupts.CPU94.NMI:Non-maskable_interrupts
      1573 ±162%    +307.6%       6411 ± 23%  interrupts.CPU94.PMI:Performance_monitoring_interrupts
    148.25 ± 20%     +76.9%     262.25 ± 17%  interrupts.CPU94.RES:Rescheduling_interrupts
    143.75 ±  8%     +68.5%     242.25 ± 16%  interrupts.CPU95.RES:Rescheduling_interrupts
    168.75 ±  6%    +127.0%     383.00 ± 48%  interrupts.CPU96.RES:Rescheduling_interrupts
      2281 ±106%    +181.2%       6415 ± 23%  interrupts.CPU97.NMI:Non-maskable_interrupts
      2281 ±106%    +181.2%       6415 ± 23%  interrupts.CPU97.PMI:Performance_monitoring_interrupts
    163.75 ± 17%     +71.3%     280.50 ± 16%  interrupts.CPU97.RES:Rescheduling_interrupts
     84.75 ± 27%   +5459.6%       4711 ± 64%  interrupts.CPU98.NMI:Non-maskable_interrupts
     84.75 ± 27%   +5459.6%       4711 ± 64%  interrupts.CPU98.PMI:Performance_monitoring_interrupts
    176.25 ±  8%     +91.2%     337.00 ± 23%  interrupts.CPU98.RES:Rescheduling_interrupts
    164.25 ±  8%     +61.5%     265.25 ± 20%  interrupts.CPU99.RES:Rescheduling_interrupts
    242630 ± 11%     +27.8%     310009 ± 13%  interrupts.NMI:Non-maskable_interrupts
    242630 ± 11%     +27.8%     310009 ± 13%  interrupts.PMI:Performance_monitoring_interrupts
      3842 ± 14%     -81.4%     714.00 ± 62%  interrupts.TLB:TLB_shootdowns
     39213 ±  2%     +59.4%      62496 ±  8%  softirqs.CPU1.SCHED
    112479 ±  3%     +11.6%     125580 ±  6%  softirqs.CPU10.RCU
     47544 ±  5%     +34.8%      64105 ±  6%  softirqs.CPU10.SCHED
    115525 ±  5%     +34.5%     155325 ±  5%  softirqs.CPU100.RCU
     42079 ±  4%     -34.4%      27593 ± 14%  softirqs.CPU100.SCHED
    115645 ±  4%     +33.4%     154231 ±  4%  softirqs.CPU101.RCU
     42390 ±  5%     -32.4%      28661 ±  9%  softirqs.CPU101.SCHED
    113237 ±  5%     +37.9%     156145 ±  4%  softirqs.CPU102.RCU
     43877 ±  3%     -42.3%      25316 ± 19%  softirqs.CPU102.SCHED
    115048 ±  4%     +35.3%     155692 ±  6%  softirqs.CPU103.RCU
     42057 ±  2%     -34.8%      27428 ± 19%  softirqs.CPU103.SCHED
     50287 ±  2%     +26.8%      63739 ±  2%  softirqs.CPU12.SCHED
     51055 ±  3%     +24.5%      63567 ±  2%  softirqs.CPU13.SCHED
    111557 ±  4%     +15.1%     128441 ±  6%  softirqs.CPU14.RCU
     51201 ±  8%     +21.9%      62437 ±  6%  softirqs.CPU14.SCHED
    106509 ±  4%     +31.4%     139927 ±  7%  softirqs.CPU15.RCU
    106554 ±  5%     +31.4%     140038 ± 10%  softirqs.CPU16.RCU
    102888 ±  3%     +22.9%     126467 ±  7%  softirqs.CPU17.RCU
    102645 ±  4%     +23.8%     127097 ±  8%  softirqs.CPU18.RCU
    103074 ±  3%     +27.2%     131067 ±  8%  softirqs.CPU19.RCU
     40123 ±  2%     +64.7%      66094 ± 16%  softirqs.CPU2.SCHED
    105947 ±  4%     +31.3%     139080 ± 11%  softirqs.CPU20.RCU
     56698 ±  3%     +10.3%      62534 ±  4%  softirqs.CPU20.SCHED
    107845 ±  4%     +25.5%     135380 ±  7%  softirqs.CPU21.RCU
    104635 ±  2%     +22.9%     128563 ±  7%  softirqs.CPU22.RCU
     57459 ±  2%      +9.0%      62636 ±  4%  softirqs.CPU22.SCHED
    107558 ±  4%     +26.9%     136472 ±  9%  softirqs.CPU23.RCU
    103404 ±  2%     +21.9%     126077 ±  9%  softirqs.CPU24.RCU
     57845            +8.9%      63018 ±  3%  softirqs.CPU24.SCHED
    103795 ±  3%     +27.4%     132281 ± 10%  softirqs.CPU25.RCU
    116855 ±  3%     +39.2%     162714 ±  3%  softirqs.CPU26.RCU
     40401 ±  3%     +14.5%      46275 ± 10%  softirqs.CPU26.SCHED
    117905 ±  5%     +38.2%     163001 ±  3%  softirqs.CPU27.RCU
    119161           +36.5%     162677 ±  2%  softirqs.CPU28.RCU
    155833 ±  4%     +31.8%     205398 ± 11%  softirqs.CPU28.TIMER
    120298 ±  6%     +39.4%     167637 ±  3%  softirqs.CPU29.RCU
    165459 ±  5%     +28.9%     213346 ±  9%  softirqs.CPU29.TIMER
     41776 ±  2%     +47.3%      61528 ± 12%  softirqs.CPU3.SCHED
    111332 ±  3%     +27.8%     142261 ±  3%  softirqs.CPU30.RCU
    109782 ±  4%     +19.3%     130961 ±  4%  softirqs.CPU31.RCU
    163967 ±  3%     +27.8%     209524 ± 10%  softirqs.CPU31.TIMER
    110345 ±  4%     +25.3%     138304 ± 12%  softirqs.CPU32.RCU
    110912 ±  4%     +27.2%     141121 ±  4%  softirqs.CPU33.RCU
    111899 ±  5%     +27.5%     142697 ±  8%  softirqs.CPU34.RCU
    164801 ±  4%     +25.8%     207277 ± 10%  softirqs.CPU34.TIMER
    110069 ±  3%     +27.6%     140414 ± 11%  softirqs.CPU35.RCU
    166154 ±  2%     +26.4%     210021 ±  9%  softirqs.CPU35.TIMER
    107927 ±  3%     +26.8%     136882 ±  4%  softirqs.CPU36.RCU
    167316 ±  2%     +23.4%     206530 ± 11%  softirqs.CPU36.TIMER
    107149 ±  3%     +28.0%     137185 ±  7%  softirqs.CPU37.RCU
     52823 ±  5%     -24.0%      40128 ± 16%  softirqs.CPU37.SCHED
    172148 ±  2%     +20.5%     207427 ± 11%  softirqs.CPU37.TIMER
    106831 ±  4%     +18.7%     126777 ±  6%  softirqs.CPU38.RCU
    169088 ±  3%     +24.9%     211164 ±  9%  softirqs.CPU38.TIMER
    109008 ±  4%     +29.2%     140872 ± 10%  softirqs.CPU39.RCU
     52842 ±  4%     -12.9%      46051 ±  3%  softirqs.CPU39.SCHED
    168352 ±  2%     +25.8%     211848 ±  8%  softirqs.CPU39.TIMER
     43344 ±  5%     +40.9%      61065 ±  9%  softirqs.CPU4.SCHED
    109019 ±  4%     +29.5%     141157 ±  8%  softirqs.CPU40.RCU
     53829 ±  2%     -23.8%      41002 ± 25%  softirqs.CPU40.SCHED
    107752 ±  9%     +19.7%     128985 ±  5%  softirqs.CPU41.RCU
     57665           -16.3%      48293 ±  5%  softirqs.CPU41.SCHED
    104372 ±  4%     +29.1%     134762 ±  6%  softirqs.CPU42.RCU
     56657           -22.2%      44093 ±  8%  softirqs.CPU42.SCHED
    176519 ±  2%     +18.9%     209864 ±  9%  softirqs.CPU42.TIMER
    102140 ±  4%     +30.8%     133570 ±  3%  softirqs.CPU43.RCU
     57875 ±  2%     -28.5%      41392 ±  6%  softirqs.CPU43.SCHED
    177283 ±  3%     +17.1%     207557 ±  9%  softirqs.CPU43.TIMER
    102750 ±  4%     +27.6%     131155 ±  6%  softirqs.CPU44.RCU
     57039 ±  5%     -22.0%      44481 ±  7%  softirqs.CPU44.SCHED
    180258 ±  3%     +17.0%     210978 ±  8%  softirqs.CPU44.TIMER
    103951 ±  3%     +47.1%     152906 ±  2%  softirqs.CPU45.RCU
     57950 ±  2%     -19.4%      46698 ±  7%  softirqs.CPU45.SCHED
    180059 ±  2%     +17.5%     211546 ±  8%  softirqs.CPU45.TIMER
    106543 ±  4%     +46.6%     156185 ±  3%  softirqs.CPU46.RCU
     58936 ±  3%     -24.8%      44309 ±  6%  softirqs.CPU46.SCHED
    175875 ±  2%     +16.8%     205464 ± 11%  softirqs.CPU46.TIMER
    107599 ±  4%     +45.6%     156681 ±  2%  softirqs.CPU47.RCU
     61135 ± 11%     -26.8%      44767 ±  9%  softirqs.CPU47.SCHED
    175037 ±  3%     +18.6%     207548 ± 10%  softirqs.CPU47.TIMER
    104196 ±  4%     +47.8%     154014 ±  3%  softirqs.CPU48.RCU
     56551 ±  6%     -19.3%      45611 ± 16%  softirqs.CPU48.SCHED
    178334 ±  5%     +18.4%     211119 ±  8%  softirqs.CPU48.TIMER
    105321 ±  4%     +46.8%     154628 ±  3%  softirqs.CPU49.RCU
    176284 ±  2%     +18.9%     209524 ±  9%  softirqs.CPU49.TIMER
     43643 ±  3%     +40.7%      61423 ± 11%  softirqs.CPU5.SCHED
    104189 ±  4%     +46.2%     152326 ±  3%  softirqs.CPU50.RCU
     58720 ±  2%     -15.3%      49718 ± 11%  softirqs.CPU50.SCHED
    180182 ±  3%     +16.7%     210254 ±  9%  softirqs.CPU50.TIMER
    105511 ±  3%     +46.2%     154243 ±  2%  softirqs.CPU51.RCU
    106737 ±  4%     +39.1%     148420 ± 10%  softirqs.CPU52.RCU
    108068 ±  4%     +35.5%     146416 ± 11%  softirqs.CPU53.RCU
     50659 ±  3%     +21.0%      61284 ±  9%  softirqs.CPU53.SCHED
    110776 ±  5%     +29.5%     143423 ±  8%  softirqs.CPU54.RCU
     49820 ±  3%     +24.6%      62062 ±  6%  softirqs.CPU54.SCHED
    108892 ±  4%     +29.6%     141149 ±  9%  softirqs.CPU55.RCU
     48807 ±  3%     +28.1%      62502 ±  6%  softirqs.CPU55.SCHED
    109303 ±  4%     +30.2%     142335 ± 10%  softirqs.CPU56.RCU
     48744 ±  4%     +29.7%      63244 ±  4%  softirqs.CPU56.SCHED
    107665 ±  4%     +32.4%     142500 ±  8%  softirqs.CPU57.RCU
     46939 ±  4%     +32.8%      62320 ±  6%  softirqs.CPU57.SCHED
    107899 ±  5%     +32.1%     142541 ±  9%  softirqs.CPU58.RCU
     47890 ±  6%     +29.7%      62112 ± 10%  softirqs.CPU58.SCHED
    112252 ±  5%     +31.6%     147720 ±  9%  softirqs.CPU59.RCU
     45201 ±  5%     +33.9%      60536 ± 11%  softirqs.CPU59.SCHED
     43271 ±  3%     +44.9%      62698 ±  5%  softirqs.CPU6.SCHED
     42947 ±  4%     +41.6%      60815 ± 10%  softirqs.CPU60.SCHED
     41118 ±  3%     +48.2%      60919 ± 10%  softirqs.CPU61.SCHED
     43558 ±  9%     +41.0%      61422 ±  8%  softirqs.CPU62.SCHED
     42404 ±  5%     +45.0%      61473 ±  8%  softirqs.CPU63.SCHED
     44782 ±  6%     +35.2%      60539 ± 11%  softirqs.CPU65.SCHED
     45270 ±  8%     +34.9%      61049 ±  9%  softirqs.CPU67.SCHED
     46135 ±  6%     +32.4%      61099 ± 12%  softirqs.CPU69.SCHED
    114120 ±  4%     +13.0%     128950 ±  9%  softirqs.CPU7.RCU
     43859 ±  4%     +42.6%      62558 ±  4%  softirqs.CPU7.SCHED
     45007 ±  4%     +42.1%      63939 ±  2%  softirqs.CPU70.SCHED
     46279 ±  4%     +31.2%      60706 ± 10%  softirqs.CPU71.SCHED
     47194 ±  7%     +29.5%      61097 ±  9%  softirqs.CPU72.SCHED
     45037 ±  4%     +37.5%      61916 ±  7%  softirqs.CPU73.SCHED
     44473 ±  7%     +38.4%      61533 ±  8%  softirqs.CPU74.SCHED
    116513 ±  5%     +32.7%     154642 ±  7%  softirqs.CPU75.RCU
     43065 ±  8%     +41.5%      60952 ± 10%  softirqs.CPU75.SCHED
    114917 ±  4%     +33.8%     153786 ±  7%  softirqs.CPU76.RCU
     44462           +40.3%      62390 ± 14%  softirqs.CPU76.SCHED
    114722 ±  3%     +34.1%     153870 ±  7%  softirqs.CPU77.RCU
     46507 ±  2%     +31.3%      61066 ±  8%  softirqs.CPU77.SCHED
    109126 ±  4%     +39.8%     152515 ±  3%  softirqs.CPU78.RCU
     52943 ±  4%     -44.1%      29615 ± 22%  softirqs.CPU78.SCHED
    113274 ±  2%     +34.9%     152829 ±  3%  softirqs.CPU79.RCU
     49330 ±  4%     -39.3%      29950 ± 19%  softirqs.CPU79.SCHED
    114525 ±  4%     +10.7%     126743 ±  6%  softirqs.CPU8.RCU
     45993 ±  5%     +35.6%      62367 ±  5%  softirqs.CPU8.SCHED
    107326 ±  4%     +40.3%     150622 ±  3%  softirqs.CPU80.RCU
     51636 ±  4%     -40.0%      30997 ± 16%  softirqs.CPU80.SCHED
    103564 ±  4%     +48.3%     153578 ±  3%  softirqs.CPU81.RCU
     54621 ±  3%     -45.0%      30058 ± 18%  softirqs.CPU81.SCHED
    106692 ±  5%     +38.1%     147383 ±  6%  softirqs.CPU82.RCU
    107429 ±  4%     +38.3%     148549 ±  3%  softirqs.CPU83.RCU
     48429 ±  3%     -29.7%      34026 ± 15%  softirqs.CPU83.SCHED
    109037 ±  3%     +30.6%     142391 ± 11%  softirqs.CPU84.RCU
    111642 ±  5%     +30.6%     145830 ±  7%  softirqs.CPU85.RCU
    110949 ±  5%     +33.3%     147882 ±  3%  softirqs.CPU86.RCU
    110815 ±  5%     +31.2%     145429 ±  7%  softirqs.CPU87.RCU
    111916 ±  5%     +34.2%     150213 ±  3%  softirqs.CPU88.RCU
     42154 ±  5%     -22.1%      32856 ± 15%  softirqs.CPU88.SCHED
    111872 ±  4%     +33.9%     149766 ±  3%  softirqs.CPU89.RCU
     47628 ±  3%     +32.5%      63122 ±  3%  softirqs.CPU9.SCHED
    112803 ±  5%     +38.3%     155970 ±  5%  softirqs.CPU90.RCU
     45236 ±  5%     -37.4%      28321 ± 23%  softirqs.CPU90.SCHED
    117379 ±  5%     +32.4%     155399 ±  4%  softirqs.CPU91.RCU
    116981 ±  3%     +26.6%     148101 ±  6%  softirqs.CPU92.RCU
    113561 ±  5%     +39.4%     158341 ±  4%  softirqs.CPU93.RCU
     45469 ±  3%     -43.2%      25823 ± 27%  softirqs.CPU93.SCHED
    112230 ±  5%     +38.5%     155456 ±  3%  softirqs.CPU94.RCU
    113604 ±  4%     +34.2%     152470 ±  5%  softirqs.CPU95.RCU
     45422 ±  4%     -33.9%      30021 ± 17%  softirqs.CPU95.SCHED
    112933 ±  4%     +38.3%     156199 ±  4%  softirqs.CPU96.RCU
     44320 ±  6%     -40.9%      26191 ± 20%  softirqs.CPU96.SCHED
    113319 ±  5%     +36.9%     155146 ±  6%  softirqs.CPU97.RCU
     43834 ±  2%     -40.0%      26290 ± 19%  softirqs.CPU97.SCHED
    116386 ±  6%     +32.5%     154262 ±  7%  softirqs.CPU98.RCU
     41001 ±  8%     -31.1%      28239 ± 22%  softirqs.CPU98.SCHED
    116165 ±  5%     +33.7%     155277 ±  5%  softirqs.CPU99.RCU
     41299 ±  5%     -33.7%      27372 ± 20%  softirqs.CPU99.SCHED
  11518008 ±  4%     +25.8%   14489368 ±  4%  softirqs.RCU
  17583486 ±  3%     +16.4%   20469522 ±  4%  softirqs.TIMER



***************************************************************************************************
lkp-skl-fpga01: 104 threads Skylake with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase/ucode:
  gcc-7/performance/x86_64-rhel-7.6/30%/debian-x86_64-20191114.cgz/300s/lkp-skl-fpga01/context1/unixbench/0x2000065

commit: 
  9c40365a65 ("threads: Update PID limit comment according to futex UAPI change")
  59901cb452 ("sched/fair: Don't pull task if local group is more loaded than busiest group")

9c40365a65d62d7c 59901cb4520c44bfce81f523bc6 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          1:4          -25%            :4     kmsg.ipmi_si_dmi-ipmi-si.#:IRQ_index#not_found
         %stddev     %change         %stddev
             \          |                \  
      3115           +29.1%       4022 ±  3%  unixbench.score
     15433 ±  2%     -36.2%       9850 ± 12%  unixbench.time.involuntary_context_switches
      2114           -15.0%       1797 ±  3%  unixbench.time.percent_of_cpu_this_job_got
      7797           -17.5%       6433 ±  3%  unixbench.time.system_time
    477.52           +24.2%     593.20        unixbench.time.user_time
  3.69e+08           +23.6%  4.561e+08 ±  2%  unixbench.time.voluntary_context_switches
 4.873e+08           +29.0%  6.288e+08 ±  3%  unixbench.workload
    747856 ±  6%     -13.1%     649552 ±  6%  meminfo.DirectMap4k
      1.40            +0.6        1.99 ±  3%  mpstat.cpu.all.usr%
    181.50 ± 14%    +205.5%     554.50 ± 61%  numa-meminfo.node0.Mlocked
     45.00 ± 14%    +207.2%     138.25 ± 61%  numa-vmstat.node0.nr_mlock
     76.00            +1.3%      77.00        vmstat.cpu.id
   3747208           +20.0%    4498355 ±  2%  vmstat.system.cs
    237644            -4.2%     227776        vmstat.system.in
      2932 ±  2%     -11.5%       2596 ±  5%  slabinfo.khugepaged_mm_slot.active_objs
      2932 ±  2%     -11.5%       2596 ±  5%  slabinfo.khugepaged_mm_slot.num_objs
      1160 ±  8%     -22.8%     895.75 ± 10%  slabinfo.task_group.active_objs
      1160 ±  8%     -22.8%     895.75 ± 10%  slabinfo.task_group.num_objs
 7.874e+09           -24.7%  5.932e+09 ±  5%  cpuidle.C1.time
 8.948e+09 ± 82%     +99.3%  1.783e+10 ± 30%  cpuidle.C1E.time
  28927686 ± 31%     +37.6%   39802094 ± 20%  cpuidle.C1E.usage
  32968312         +1040.8%  3.761e+08 ± 16%  cpuidle.POLL.time
   3321066         +3571.2%  1.219e+08 ± 17%  cpuidle.POLL.usage
     77470            -1.2%      76570        proc-vmstat.nr_active_anon
     44723            -1.6%      44026        proc-vmstat.nr_slab_unreclaimable
     77470            -1.2%      76570        proc-vmstat.nr_zone_active_anon
     11008 ± 26%     -56.0%       4844 ± 56%  proc-vmstat.numa_hint_faults
      1806 ± 10%     -87.9%     218.75 ± 52%  proc-vmstat.numa_hint_faults_local
     10143 ±  5%     -11.1%       9016 ±  3%  proc-vmstat.pgactivate
   3687542 ±  3%     -16.9%    3066128 ± 10%  sched_debug.cfs_rq:/.MIN_vruntime.max
   1247933 ±  4%     -15.6%    1053151 ± 11%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
     73039           -14.6%      62394 ±  5%  sched_debug.cfs_rq:/.exec_clock.avg
     46502           -38.8%      28463 ± 28%  sched_debug.cfs_rq:/.exec_clock.min
     10133 ±  6%     +94.8%      19737 ± 27%  sched_debug.cfs_rq:/.exec_clock.stddev
     12925 ±  8%     +37.1%      17715 ± 27%  sched_debug.cfs_rq:/.load.avg
   3687542 ±  3%     -16.9%    3066129 ± 10%  sched_debug.cfs_rq:/.max_vruntime.max
   1247933 ±  4%     -15.6%    1053152 ± 11%  sched_debug.cfs_rq:/.max_vruntime.stddev
   3425325           -21.7%    2680459 ±  5%  sched_debug.cfs_rq:/.min_vruntime.avg
   2191093           -44.6%    1213462 ± 28%  sched_debug.cfs_rq:/.min_vruntime.min
    471746 ±  6%     +77.8%     838686 ± 25%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.24 ± 26%     +90.8%       0.46 ± 19%  sched_debug.cfs_rq:/.nr_spread_over.avg
      2.64 ± 36%    +151.8%       6.65 ± 55%  sched_debug.cfs_rq:/.nr_spread_over.max
      0.51 ± 26%    +137.0%       1.20 ± 44%  sched_debug.cfs_rq:/.nr_spread_over.stddev
      1437 ±  3%     +37.1%       1970 ±  6%  sched_debug.cfs_rq:/.runnable_avg.max
    375.43 ±  2%     +15.1%     432.07 ±  4%  sched_debug.cfs_rq:/.runnable_avg.stddev
    -96957         +1058.8%   -1123518        sched_debug.cfs_rq:/.spread0.min
    471746 ±  6%     +77.8%     838694 ± 25%  sched_debug.cfs_rq:/.spread0.stddev
    858.93 ±  5%     +45.9%       1253 ± 13%  sched_debug.cfs_rq:/.util_avg.max
    649.39 ±  6%     +56.7%       1017 ± 15%  sched_debug.cfs_rq:/.util_est_enqueued.max
    442164 ±  3%     +19.3%     527581 ±  3%  sched_debug.cpu.avg_idle.avg
    514800 ±  4%     +15.5%     594740 ± 13%  sched_debug.cpu.max_idle_balance_cost.max
      1444 ±148%    +613.0%      10298 ± 72%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.00 ±  3%     -16.2%       0.00 ±  8%  sched_debug.cpu.next_balance.stddev
      1.04 ±  5%     +81.0%       1.88 ± 22%  sched_debug.cpu.nr_running.max
      0.41           +12.1%       0.46 ±  6%  sched_debug.cpu.nr_running.stddev
   8064604 ±  2%     +33.5%   10769101 ± 11%  sched_debug.cpu.nr_switches.max
    915034 ±  6%    +206.7%    2806624 ± 32%  sched_debug.cpu.nr_switches.stddev
   8061279 ±  2%     +33.5%   10761752 ± 11%  sched_debug.cpu.sched_count.max
    914923 ±  6%    +206.7%    2806145 ± 32%  sched_debug.cpu.sched_count.stddev
   4029443 ±  2%     +29.7%    5227316 ± 11%  sched_debug.cpu.sched_goidle.max
    457354 ±  6%    +196.6%    1356319 ± 31%  sched_debug.cpu.sched_goidle.stddev
   3230031           +17.6%    3799652 ±  8%  sched_debug.cpu.ttwu_count.avg
   4032123           +37.2%    5533499 ± 11%  sched_debug.cpu.ttwu_count.max
    457261 ±  6%    +217.1%    1449903 ± 33%  sched_debug.cpu.ttwu_count.stddev
    497.05          +952.2%       5229 ± 17%  sched_debug.cpu.ttwu_local.avg
      1512          +449.7%       8311 ± 24%  sched_debug.cpu.ttwu_local.max
    354.64 ±  4%    +688.8%       2797 ± 29%  sched_debug.cpu.ttwu_local.min
    130.66 ±  6%   +1584.8%       2201 ± 49%  sched_debug.cpu.ttwu_local.stddev
     97364 ±  2%     -15.3%      82438 ± 10%  softirqs.CPU100.SCHED
     95732           -13.2%      83091 ± 10%  softirqs.CPU101.SCHED
     98020           -15.3%      83044 ± 11%  softirqs.CPU102.SCHED
    134854 ±  2%      +9.5%     147696 ±  3%  softirqs.CPU33.TIMER
    100296 ±  4%      -9.8%      90488 ±  8%  softirqs.CPU34.SCHED
     98665 ±  4%     -10.0%      88752 ±  8%  softirqs.CPU36.SCHED
    101562 ±  2%     -12.5%      88834 ±  8%  softirqs.CPU37.SCHED
    103241           -14.5%      88256 ± 10%  softirqs.CPU38.SCHED
    102016           -15.1%      86641 ±  9%  softirqs.CPU39.SCHED
    103072 ±  2%     -15.9%      86642 ± 11%  softirqs.CPU40.SCHED
    103642           -16.7%      86299 ± 10%  softirqs.CPU41.SCHED
    136281            +8.1%     147364 ±  3%  softirqs.CPU41.TIMER
    104080           -18.4%      84916 ± 11%  softirqs.CPU42.SCHED
    104161           -25.6%      77445 ± 19%  softirqs.CPU43.SCHED
    103794 ±  2%     -18.3%      84779 ± 11%  softirqs.CPU44.SCHED
    104881           -19.0%      84947 ± 12%  softirqs.CPU45.SCHED
    106249           -21.7%      83209 ± 11%  softirqs.CPU46.SCHED
    105901           -21.9%      82708 ± 12%  softirqs.CPU47.SCHED
    106109           -21.0%      83838 ± 10%  softirqs.CPU48.SCHED
    104208 ±  3%     -20.5%      82800 ± 11%  softirqs.CPU49.SCHED
    105449           -20.8%      83521 ± 10%  softirqs.CPU50.SCHED
    106650           -12.8%      92988 ±  6%  softirqs.CPU52.SCHED
    110131           -23.6%      84129 ± 11%  softirqs.CPU78.SCHED
    107950 ±  3%     -22.3%      83897 ± 11%  softirqs.CPU79.SCHED
    110414           -23.5%      84412 ± 10%  softirqs.CPU80.SCHED
    107954 ±  2%     -21.3%      84966 ± 10%  softirqs.CPU81.SCHED
    107635           -22.6%      83318 ± 13%  softirqs.CPU82.SCHED
    107434 ±  2%     -22.4%      83344 ± 11%  softirqs.CPU83.SCHED
    106151 ±  2%     -21.5%      83345 ± 12%  softirqs.CPU84.SCHED
    104935 ±  5%     -20.0%      83933 ± 11%  softirqs.CPU85.SCHED
    103760 ±  2%     -19.3%      83770 ± 11%  softirqs.CPU86.SCHED
    103250 ±  4%     -18.6%      84093 ± 11%  softirqs.CPU87.SCHED
    104851 ±  2%     -20.2%      83629 ± 12%  softirqs.CPU88.SCHED
    104007           -19.5%      83676 ± 12%  softirqs.CPU89.SCHED
    101221           -17.8%      83192 ± 11%  softirqs.CPU90.SCHED
    103382 ±  2%     -19.4%      83322 ± 11%  softirqs.CPU91.SCHED
     99759 ±  3%     -16.9%      82889 ± 12%  softirqs.CPU92.SCHED
     99723           -15.8%      84012 ± 11%  softirqs.CPU93.SCHED
     99706 ±  2%     -15.8%      83927 ± 11%  softirqs.CPU94.SCHED
    100802           -17.3%      83351 ± 11%  softirqs.CPU95.SCHED
     99622 ±  2%     -16.3%      83351 ± 10%  softirqs.CPU96.SCHED
     98714 ±  2%     -16.4%      82483 ± 11%  softirqs.CPU97.SCHED
     99272           -16.5%      82919 ± 11%  softirqs.CPU98.SCHED
     97699 ±  2%     -15.7%      82320 ± 11%  softirqs.CPU99.SCHED
     30.70 ± 17%     -41.8%      17.86 ±  2%  perf-stat.i.MPKI
 6.229e+09           +21.0%  7.537e+09 ±  2%  perf-stat.i.branch-instructions
  87521494 ±  2%     +26.1%  1.103e+08 ±  2%  perf-stat.i.branch-misses
  26161990           -61.0%   10190442 ± 20%  perf-stat.i.cache-misses
 7.094e+08            -3.2%  6.866e+08        perf-stat.i.cache-references
   3766575           +20.0%    4520959 ±  2%  perf-stat.i.context-switches
      3.51 ±  8%     -22.6%       2.72 ±  3%  perf-stat.i.cpi
 8.561e+10            +2.8%    8.8e+10        perf-stat.i.cpu-cycles
      1199 ± 10%  +12547.8%     151679 ± 18%  perf-stat.i.cpu-migrations
      3326 ±  8%   +1896.7%      66426 ± 59%  perf-stat.i.cycles-between-cache-misses
   4368880 ±  5%    +260.9%   15765930 ± 11%  perf-stat.i.dTLB-load-misses
 7.644e+09           +21.3%  9.275e+09 ±  2%  perf-stat.i.dTLB-loads
     83528 ± 41%   +1345.4%    1207309 ± 15%  perf-stat.i.dTLB-store-misses
   4.5e+09           +22.5%  5.512e+09 ±  2%  perf-stat.i.dTLB-stores
   4412580           +49.5%    6597934 ±  4%  perf-stat.i.iTLB-load-misses
  29081328           +25.9%   36603347        perf-stat.i.iTLB-loads
 2.835e+10           +21.5%  3.444e+10 ±  2%  perf-stat.i.instructions
      0.31 ±  4%     +21.5%       0.38 ±  3%  perf-stat.i.ipc
     94.83            -2.4       92.45        perf-stat.i.node-load-miss-rate%
   4078999           -58.8%    1678711 ± 18%  perf-stat.i.node-load-misses
    146125           -60.1%      58372 ± 13%  perf-stat.i.node-loads
     95.95           -10.6       85.36        perf-stat.i.node-store-miss-rate%
   3822185           -59.7%    1539813 ± 20%  perf-stat.i.node-store-misses
     11551 ±  3%      -8.5%      10571 ±  5%  perf-stat.i.node-stores
     25.02           -20.3%      19.94 ±  2%  perf-stat.overall.MPKI
      1.41            +0.1        1.46        perf-stat.overall.branch-miss-rate%
      3.69            -2.2        1.49 ± 21%  perf-stat.overall.cache-miss-rate%
      3.02           -15.4%       2.56 ±  2%  perf-stat.overall.cpi
      3272          +178.9%       9127 ± 25%  perf-stat.overall.cycles-between-cache-misses
      0.06 ±  5%      +0.1        0.17 ±  9%  perf-stat.overall.dTLB-load-miss-rate%
      0.00 ± 41%      +0.0        0.02 ± 13%  perf-stat.overall.dTLB-store-miss-rate%
     13.18            +2.1       15.27 ±  3%  perf-stat.overall.iTLB-load-miss-rate%
      6425           -18.7%       5224 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
      0.33           +18.2%       0.39 ±  2%  perf-stat.overall.ipc
     22735            -5.8%      21419        perf-stat.overall.path-length
  6.21e+09           +21.1%  7.518e+09 ±  2%  perf-stat.ps.branch-instructions
  87263324 ±  2%     +26.1%  1.101e+08 ±  2%  perf-stat.ps.branch-misses
  26081704           -61.1%   10158408 ± 20%  perf-stat.ps.cache-misses
 7.072e+08            -3.2%  6.848e+08        perf-stat.ps.cache-references
   3754979           +20.1%    4509479 ±  2%  perf-stat.ps.context-switches
 8.535e+10            +2.8%  8.777e+10        perf-stat.ps.cpu-cycles
      1197 ± 10%  +12540.5%     151373 ± 18%  perf-stat.ps.cpu-migrations
   4356788 ±  5%    +261.1%   15731108 ± 11%  perf-stat.ps.dTLB-load-misses
 7.621e+09           +21.4%  9.251e+09 ±  2%  perf-stat.ps.dTLB-loads
     83463 ± 41%   +1343.5%    1204761 ± 15%  perf-stat.ps.dTLB-store-misses
 4.487e+09           +22.5%  5.498e+09 ±  2%  perf-stat.ps.dTLB-stores
   4399472           +49.6%    6581866 ±  4%  perf-stat.ps.iTLB-load-misses
  28993919           +25.9%   36508403        perf-stat.ps.iTLB-loads
 2.826e+10           +21.6%  3.436e+10 ±  2%  perf-stat.ps.instructions
   4066345           -58.8%    1673367 ± 18%  perf-stat.ps.node-load-misses
    145705           -60.0%      58229 ± 13%  perf-stat.ps.node-loads
   3810301           -59.7%    1534753 ± 20%  perf-stat.ps.node-store-misses
     11533 ±  3%      -8.5%      10555 ±  5%  perf-stat.ps.node-stores
 1.108e+13           +21.5%  1.346e+13 ±  2%  perf-stat.total.instructions
     49518            -1.5%      48784        interrupts.CAL:Function_call_interrupts
     75573 ±  2%     -21.1%      59624 ± 19%  interrupts.CPU0.RES:Rescheduling_interrupts
    293.50 ± 46%     -83.7%      47.75 ± 39%  interrupts.CPU0.TLB:TLB_shootdowns
      1651 ± 43%     -90.6%     155.75 ± 89%  interrupts.CPU1.TLB:TLB_shootdowns
    107991 ±  2%     -25.4%      80516 ± 13%  interrupts.CPU10.RES:Rescheduling_interrupts
     53.00 ± 95%     -70.3%      15.75 ± 34%  interrupts.CPU10.TLB:TLB_shootdowns
    104860 ±  3%     -45.3%      57407 ± 29%  interrupts.CPU100.RES:Rescheduling_interrupts
    101815 ±  3%     -42.4%      58608 ± 28%  interrupts.CPU101.RES:Rescheduling_interrupts
    104224 ±  3%     -45.2%      57146 ± 32%  interrupts.CPU102.RES:Rescheduling_interrupts
      3026 ±  8%     -70.6%     891.00 ±149%  interrupts.CPU103.NMI:Non-maskable_interrupts
      3026 ±  8%     -70.6%     891.00 ±149%  interrupts.CPU103.PMI:Performance_monitoring_interrupts
     97748 ±  3%     -43.9%      54866 ± 25%  interrupts.CPU103.RES:Rescheduling_interrupts
    106274 ±  2%     -25.2%      79442 ± 18%  interrupts.CPU11.RES:Rescheduling_interrupts
    109794 ±  3%     -26.2%      81077 ± 13%  interrupts.CPU12.RES:Rescheduling_interrupts
    110641 ±  4%     -28.4%      79170 ± 17%  interrupts.CPU13.RES:Rescheduling_interrupts
    112578 ±  4%     -28.9%      80064 ± 13%  interrupts.CPU14.RES:Rescheduling_interrupts
    203.50 ±101%     -92.1%      16.00 ± 76%  interrupts.CPU14.TLB:TLB_shootdowns
    115653 ±  3%     -29.9%      81035 ± 16%  interrupts.CPU15.RES:Rescheduling_interrupts
      2336 ± 30%     +56.1%       3646 ± 24%  interrupts.CPU16.NMI:Non-maskable_interrupts
      2336 ± 30%     +56.1%       3646 ± 24%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
    113166 ±  4%     -31.0%      78040 ± 14%  interrupts.CPU16.RES:Rescheduling_interrupts
    117545 ±  6%     -34.2%      77376 ± 15%  interrupts.CPU17.RES:Rescheduling_interrupts
    119816 ±  5%     -35.9%      76821 ± 18%  interrupts.CPU18.RES:Rescheduling_interrupts
    208.00 ±115%     -93.0%      14.50 ± 51%  interrupts.CPU18.TLB:TLB_shootdowns
    116298 ±  5%     -33.1%      77798 ± 18%  interrupts.CPU19.RES:Rescheduling_interrupts
    118.50 ± 93%     -87.8%      14.50 ± 51%  interrupts.CPU19.TLB:TLB_shootdowns
    471.50 ± 54%     -97.1%      13.75 ± 37%  interrupts.CPU2.TLB:TLB_shootdowns
    119931 ±  4%     -34.2%      78873 ± 16%  interrupts.CPU20.RES:Rescheduling_interrupts
    119193 ±  3%     -33.7%      79035 ± 10%  interrupts.CPU21.RES:Rescheduling_interrupts
    119705 ±  4%     -33.6%      79531 ± 21%  interrupts.CPU22.RES:Rescheduling_interrupts
    119224           -33.6%      79145 ± 15%  interrupts.CPU23.RES:Rescheduling_interrupts
    239.50 ± 82%     -94.8%      12.50 ± 47%  interrupts.CPU23.TLB:TLB_shootdowns
    114268 ±  5%     -32.0%      77747 ± 18%  interrupts.CPU24.RES:Rescheduling_interrupts
    130.75 ± 54%     -87.2%      16.75 ± 80%  interrupts.CPU24.TLB:TLB_shootdowns
    114570 ±  2%     -27.4%      83205 ± 15%  interrupts.CPU25.RES:Rescheduling_interrupts
    401.00 ± 34%     -90.8%      36.75 ± 37%  interrupts.CPU26.TLB:TLB_shootdowns
      2215 ± 26%     -81.2%     417.25 ± 96%  interrupts.CPU27.TLB:TLB_shootdowns
      1056 ± 71%     -76.4%     249.75 ± 54%  interrupts.CPU29.TLB:TLB_shootdowns
     94273 ±  4%     -14.7%      80458 ± 17%  interrupts.CPU3.RES:Rescheduling_interrupts
    438.75 ± 54%     -80.6%      85.25 ±138%  interrupts.CPU3.TLB:TLB_shootdowns
    297.75 ± 52%     -69.4%      91.00 ±123%  interrupts.CPU30.TLB:TLB_shootdowns
     99323 ±  4%     -17.3%      82125 ± 18%  interrupts.CPU31.RES:Rescheduling_interrupts
    101813 ±  4%     -22.1%      79310 ± 22%  interrupts.CPU32.RES:Rescheduling_interrupts
    104108 ±  4%     -23.9%      79216 ± 21%  interrupts.CPU33.RES:Rescheduling_interrupts
    108408 ±  6%     -30.2%      75649 ± 19%  interrupts.CPU34.RES:Rescheduling_interrupts
    107851 ±  7%     -30.2%      75255 ± 22%  interrupts.CPU35.RES:Rescheduling_interrupts
      3050 ±  5%     -38.5%       1875 ± 56%  interrupts.CPU36.NMI:Non-maskable_interrupts
      3050 ±  5%     -38.5%       1875 ± 56%  interrupts.CPU36.PMI:Performance_monitoring_interrupts
    110860 ±  5%     -36.0%      70961 ± 21%  interrupts.CPU36.RES:Rescheduling_interrupts
      2994 ±  5%     -47.5%       1573 ± 56%  interrupts.CPU37.NMI:Non-maskable_interrupts
      2994 ±  5%     -47.5%       1573 ± 56%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
    110701 ±  6%     -35.9%      70912 ± 21%  interrupts.CPU37.RES:Rescheduling_interrupts
      2950 ±  3%     -60.7%       1158 ± 70%  interrupts.CPU38.NMI:Non-maskable_interrupts
      2950 ±  3%     -60.7%       1158 ± 70%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
    114683 ±  2%     -39.3%      69605 ± 27%  interrupts.CPU38.RES:Rescheduling_interrupts
      2959 ±  3%     -53.1%       1387 ± 64%  interrupts.CPU39.NMI:Non-maskable_interrupts
      2959 ±  3%     -53.1%       1387 ± 64%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
    112794 ±  3%     -41.0%      66597 ± 21%  interrupts.CPU39.RES:Rescheduling_interrupts
     96299 ±  6%     -19.1%      77895 ± 15%  interrupts.CPU4.RES:Rescheduling_interrupts
      3084 ±  6%     -62.4%       1158 ± 67%  interrupts.CPU40.NMI:Non-maskable_interrupts
      3084 ±  6%     -62.4%       1158 ± 67%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
    115740 ±  6%     -42.7%      66275 ± 28%  interrupts.CPU40.RES:Rescheduling_interrupts
    336.75 ± 73%     -94.3%      19.25 ± 40%  interrupts.CPU40.TLB:TLB_shootdowns
      3109 ±  5%     -59.0%       1273 ± 57%  interrupts.CPU41.NMI:Non-maskable_interrupts
      3109 ±  5%     -59.0%       1273 ± 57%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
    117515 ±  3%     -45.4%      64133 ± 26%  interrupts.CPU41.RES:Rescheduling_interrupts
      3074 ± 12%     -64.3%       1097 ± 89%  interrupts.CPU42.NMI:Non-maskable_interrupts
      3074 ± 12%     -64.3%       1097 ± 89%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
    118729 ±  3%     -47.7%      62131 ± 30%  interrupts.CPU42.RES:Rescheduling_interrupts
      3026 ±  7%     -70.3%     898.50 ± 83%  interrupts.CPU43.NMI:Non-maskable_interrupts
      3026 ±  7%     -70.3%     898.50 ± 83%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
    116750 ±  3%     -48.2%      60473 ± 29%  interrupts.CPU43.RES:Rescheduling_interrupts
      2999 ± 13%     -71.5%     853.50 ±116%  interrupts.CPU44.NMI:Non-maskable_interrupts
      2999 ± 13%     -71.5%     853.50 ±116%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
    119184           -48.6%      61233 ± 30%  interrupts.CPU44.RES:Rescheduling_interrupts
    119035 ±  2%     -48.7%      61050 ± 32%  interrupts.CPU45.RES:Rescheduling_interrupts
    122760 ±  3%     -52.1%      58842 ± 30%  interrupts.CPU46.RES:Rescheduling_interrupts
    122662 ±  2%     -53.5%      57035 ± 33%  interrupts.CPU47.RES:Rescheduling_interrupts
    123349 ±  2%     -51.7%      59540 ± 29%  interrupts.CPU48.RES:Rescheduling_interrupts
    123.00 ±107%     -88.6%      14.00 ± 36%  interrupts.CPU48.TLB:TLB_shootdowns
    123038 ±  2%     -53.4%      57374 ± 32%  interrupts.CPU49.RES:Rescheduling_interrupts
    174.50 ± 70%     -92.3%      13.50 ± 24%  interrupts.CPU49.TLB:TLB_shootdowns
     94491 ±  3%     -16.2%      79161 ± 17%  interrupts.CPU5.RES:Rescheduling_interrupts
    120948 ±  2%     -51.3%      58853 ± 28%  interrupts.CPU50.RES:Rescheduling_interrupts
    121202 ±  3%     -53.5%      56355 ± 35%  interrupts.CPU51.RES:Rescheduling_interrupts
    127597 ±  3%     -32.8%      85784 ± 14%  interrupts.CPU52.RES:Rescheduling_interrupts
    122288 ±  4%     -33.4%      81461 ± 14%  interrupts.CPU53.RES:Rescheduling_interrupts
    119757 ±  3%     -32.0%      81484 ± 19%  interrupts.CPU54.RES:Rescheduling_interrupts
    232.50 ± 97%     -94.3%      13.25 ± 86%  interrupts.CPU54.TLB:TLB_shootdowns
    114657 ±  4%     -27.8%      82728 ± 16%  interrupts.CPU55.RES:Rescheduling_interrupts
     91.50 ±132%     -84.7%      14.00 ± 59%  interrupts.CPU55.TLB:TLB_shootdowns
    112537 ±  6%     -28.0%      80980 ± 19%  interrupts.CPU56.RES:Rescheduling_interrupts
    180.00 ± 94%     -95.1%       8.75 ± 74%  interrupts.CPU56.TLB:TLB_shootdowns
    110747 ±  4%     -26.4%      81457 ± 17%  interrupts.CPU57.RES:Rescheduling_interrupts
    309.25 ± 99%     -97.1%       9.00 ± 73%  interrupts.CPU57.TLB:TLB_shootdowns
    108297           -26.4%      79689 ± 20%  interrupts.CPU58.RES:Rescheduling_interrupts
     96801 ±  2%     -18.7%      78664 ± 16%  interrupts.CPU6.RES:Rescheduling_interrupts
    104449 ±  5%     -21.7%      81825 ± 18%  interrupts.CPU60.RES:Rescheduling_interrupts
    150.50 ± 85%     -93.7%       9.50 ± 28%  interrupts.CPU60.TLB:TLB_shootdowns
    103863 ±  5%     -21.9%      81091 ± 19%  interrupts.CPU61.RES:Rescheduling_interrupts
     99849 ±  5%     -18.8%      81035 ± 19%  interrupts.CPU62.RES:Rescheduling_interrupts
     99399 ±  4%     -18.8%      80732 ± 16%  interrupts.CPU63.RES:Rescheduling_interrupts
    134.50 ± 88%     -92.8%       9.75 ± 38%  interrupts.CPU64.TLB:TLB_shootdowns
     94400 ±  3%     -21.2%      74427 ± 22%  interrupts.CPU66.RES:Rescheduling_interrupts
     96.75 ±136%     -89.1%      10.50 ± 86%  interrupts.CPU66.TLB:TLB_shootdowns
     93400 ±  6%     -21.2%      73562 ± 23%  interrupts.CPU68.RES:Rescheduling_interrupts
    147.25 ±147%     -94.2%       8.50 ± 55%  interrupts.CPU69.TLB:TLB_shootdowns
    101127 ±  6%     -21.5%      79428 ± 17%  interrupts.CPU7.RES:Rescheduling_interrupts
     43.25 ±101%     -76.9%      10.00 ± 86%  interrupts.CPU71.TLB:TLB_shootdowns
     93.00 ±134%     -90.6%       8.75 ± 45%  interrupts.CPU73.TLB:TLB_shootdowns
     73.50 ±129%     -86.4%      10.00 ± 57%  interrupts.CPU74.TLB:TLB_shootdowns
     78700 ±  4%     -18.1%      64461 ± 26%  interrupts.CPU75.RES:Rescheduling_interrupts
     82332 ±  5%     -23.2%      63213 ± 19%  interrupts.CPU76.RES:Rescheduling_interrupts
     80750 ±  3%     -20.5%      64217 ± 21%  interrupts.CPU77.RES:Rescheduling_interrupts
    167.00 ± 86%     -53.9%      77.00 ±158%  interrupts.CPU77.TLB:TLB_shootdowns
    132925 ±  2%     -55.5%      59127 ± 32%  interrupts.CPU78.RES:Rescheduling_interrupts
    130753 ±  3%     -52.1%      62630 ± 28%  interrupts.CPU79.RES:Rescheduling_interrupts
      2129 ± 28%    +106.7%       4402 ± 20%  interrupts.CPU8.NMI:Non-maskable_interrupts
      2129 ± 28%    +106.7%       4402 ± 20%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
    102071 ±  3%     -20.1%      81537 ± 15%  interrupts.CPU8.RES:Rescheduling_interrupts
    130307 ±  5%     -54.5%      59229 ± 29%  interrupts.CPU80.RES:Rescheduling_interrupts
    130176 ±  3%     -52.9%      61349 ± 29%  interrupts.CPU81.RES:Rescheduling_interrupts
    125592 ±  2%     -52.8%      59330 ± 35%  interrupts.CPU82.RES:Rescheduling_interrupts
    126379 ±  2%     -53.4%      58871 ± 30%  interrupts.CPU83.RES:Rescheduling_interrupts
    122387 ±  4%     -52.3%      58375 ± 32%  interrupts.CPU84.RES:Rescheduling_interrupts
    123520 ±  5%     -51.6%      59756 ± 29%  interrupts.CPU85.RES:Rescheduling_interrupts
    122586 ±  6%     -50.6%      60556 ± 30%  interrupts.CPU86.RES:Rescheduling_interrupts
    119406 ±  5%     -49.8%      59963 ± 29%  interrupts.CPU87.RES:Rescheduling_interrupts
    119861 ±  4%     -51.1%      58631 ± 33%  interrupts.CPU88.RES:Rescheduling_interrupts
    117115 ±  4%     -50.0%      58574 ± 32%  interrupts.CPU89.RES:Rescheduling_interrupts
    104723 ±  2%     -25.1%      78456 ± 20%  interrupts.CPU9.RES:Rescheduling_interrupts
    113197 ±  3%     -49.1%      57667 ± 31%  interrupts.CPU90.RES:Rescheduling_interrupts
    117511 ±  3%     -49.1%      59777 ± 31%  interrupts.CPU91.RES:Rescheduling_interrupts
    113502 ±  2%     -48.6%      58311 ± 35%  interrupts.CPU92.RES:Rescheduling_interrupts
    111247           -46.3%      59729 ± 29%  interrupts.CPU93.RES:Rescheduling_interrupts
    109067 ±  4%     -45.0%      60027 ± 29%  interrupts.CPU94.RES:Rescheduling_interrupts
    109639 ±  2%     -46.4%      58724 ± 29%  interrupts.CPU95.RES:Rescheduling_interrupts
    107661 ±  3%     -45.2%      59031 ± 29%  interrupts.CPU96.RES:Rescheduling_interrupts
      2987 ±  7%     -69.8%     900.75 ±117%  interrupts.CPU97.NMI:Non-maskable_interrupts
      2987 ±  7%     -69.8%     900.75 ±117%  interrupts.CPU97.PMI:Performance_monitoring_interrupts
    107034 ±  2%     -47.6%      56109 ± 29%  interrupts.CPU97.RES:Rescheduling_interrupts
     96.00 ±125%     -86.5%      13.00 ± 12%  interrupts.CPU97.TLB:TLB_shootdowns
    107585 ±  2%     -46.3%      57788 ± 31%  interrupts.CPU98.RES:Rescheduling_interrupts
    104668 ±  5%     -46.5%      55991 ± 33%  interrupts.CPU99.RES:Rescheduling_interrupts
     93.25 ±108%     -84.2%      14.75 ± 14%  interrupts.CPU99.TLB:TLB_shootdowns
  11221741           -34.2%    7378335 ±  9%  interrupts.RES:Rescheduling_interrupts
     19833 ± 39%     -56.4%       8648 ± 38%  interrupts.TLB:TLB_shootdowns
     30.31            -8.5       21.77 ± 28%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__account_scheduler_latency.enqueue_entity.enqueue_task_fair
     31.04            -8.5       22.53 ± 27%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__account_scheduler_latency.enqueue_entity.enqueue_task_fair.activate_task
     34.59            -6.9       27.65 ± 18%  perf-profile.calltrace.cycles-pp.__account_scheduler_latency.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
     36.44            -6.3       30.10 ± 15%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up
     36.85            -6.1       30.70 ± 14%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
     36.88            -6.1       30.77 ± 14%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
     36.89            -6.1       30.79 ± 14%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
     39.76            -5.9       33.83 ± 14%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     40.65            -4.6       36.05 ±  8%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     40.72            -4.6       36.15 ±  8%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     38.95            -4.4       34.52 ±  8%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write
     39.08            -4.4       34.68 ±  8%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write.new_sync_write
     39.31            -4.4       34.93 ±  8%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write
     39.59            -4.3       35.27 ±  8%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write.ksys_write
     40.70            -3.9       36.76 ±  7%  perf-profile.calltrace.cycles-pp.pipe_write.new_sync_write.vfs_write.ksys_write.do_syscall_64
     40.77            -3.9       36.87 ±  7%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     46.74            -1.8       44.95 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     46.77            -1.8       45.00 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
     46.78            -1.8       45.02 ±  2%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
     47.29            -1.5       45.81 ±  2%  perf-profile.calltrace.cycles-pp.secondary_startup_64
      6.01 ±  7%      -1.3        4.68 ±  9%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      6.03 ±  7%      -1.3        4.73 ±  9%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      6.17 ±  7%      -1.2        4.99 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      6.16 ±  6%      -1.2        4.98 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      6.33 ±  6%      -1.1        5.26 ±  9%  perf-profile.calltrace.cycles-pp.write
      0.53 ±  2%      +0.1        0.63 ± 14%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.pipe_read.new_sync_read.vfs_read.ksys_read
      0.55 ±  2%      +0.2        0.74 ± 23%  perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      0.70 ±  2%      +0.2        0.91 ± 19%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret
      0.70 ±  2%      +0.2        0.93 ± 21%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64
      0.54            +0.2        0.79 ± 24%  perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_task_fair.__sched_text_start.schedule
      1.16            +0.3        1.43 ± 11%  perf-profile.calltrace.cycles-pp.set_next_entity.pick_next_task_fair.__sched_text_start.schedule_idle.do_idle
      0.64 ±  4%      +0.3        0.95 ± 22%  perf-profile.calltrace.cycles-pp.get_next_timer_interrupt.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle
      0.78 ±  3%      +0.3        1.12 ± 21%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry
      1.53            +0.4        1.94 ± 10%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__sched_text_start.schedule_idle.do_idle.cpu_startup_entry
      1.02 ±  2%      +0.4        1.43 ± 21%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry.start_secondary
      1.27 ±  2%      +0.5        1.73 ± 22%  perf-profile.calltrace.cycles-pp.unwind_next_frame.arch_stack_walk.stack_trace_save_tsk.__account_scheduler_latency.enqueue_entity
      0.26 ±100%      +0.6        0.85 ± 46%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      1.60 ±  3%      +0.7        2.28 ± 21%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      1.02 ±  6%      +0.8        1.83 ±  9%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.05 ±  6%      +0.8        1.87 ±  9%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.24            +0.8        2.08 ± 38%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__sched_text_start.schedule.pipe_read
      1.22 ±  7%      +0.9        2.16 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.23 ±  7%      +0.9        2.18 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      1.44 ±  7%      +1.1        2.56 ±  9%  perf-profile.calltrace.cycles-pp.read
      1.46            +1.4        2.90 ± 25%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__sched_text_start.schedule.pipe_read.new_sync_read
      2.73            +1.5        4.22 ± 28%  perf-profile.calltrace.cycles-pp.__sched_text_start.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      2.78            +1.5        4.30 ± 27%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      0.00            +1.6        1.55 ± 85%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      3.23 ±  6%      +1.6        4.84 ± 21%  perf-profile.calltrace.cycles-pp.stack_trace_save_tsk.__account_scheduler_latency.enqueue_entity.enqueue_task_fair.activate_task
      2.29 ±  2%      +1.8        4.12 ± 23%  perf-profile.calltrace.cycles-pp.arch_stack_walk.stack_trace_save_tsk.__account_scheduler_latency.enqueue_entity.enqueue_task_fair
      3.08 ±  7%      +2.1        5.15 ± 26%  perf-profile.calltrace.cycles-pp.__sched_text_start.schedule.pipe_read.new_sync_read.vfs_read
      3.17 ±  6%      +2.1        5.27 ± 26%  perf-profile.calltrace.cycles-pp.schedule.pipe_read.new_sync_read.vfs_read.ksys_read
      5.35            +2.2        7.56 ± 25%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.50            +2.3        7.76 ± 25%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.79            +2.7        8.48 ± 21%  perf-profile.calltrace.cycles-pp.pipe_read.new_sync_read.vfs_read.ksys_read.do_syscall_64
      5.90            +2.8        8.67 ± 22%  perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     31.89            -8.3       23.59 ± 25%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     34.59            -6.9       27.66 ± 18%  perf-profile.children.cycles-pp.__account_scheduler_latency
     30.51            -6.9       23.60 ± 19%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     36.58            -6.3       30.26 ± 15%  perf-profile.children.cycles-pp.enqueue_entity
     36.85            -6.1       30.71 ± 14%  perf-profile.children.cycles-pp.enqueue_task_fair
     36.88            -6.1       30.77 ± 14%  perf-profile.children.cycles-pp.activate_task
     36.90            -6.1       30.80 ± 14%  perf-profile.children.cycles-pp.ttwu_do_activate
     39.93            -6.0       33.95 ± 13%  perf-profile.children.cycles-pp.intel_idle
     38.96            -4.4       34.52 ±  8%  perf-profile.children.cycles-pp.try_to_wake_up
     39.09            -4.4       34.69 ±  8%  perf-profile.children.cycles-pp.autoremove_wake_function
     41.17            -4.4       36.79 ±  8%  perf-profile.children.cycles-pp.cpuidle_enter_state
     39.31            -4.4       34.93 ±  8%  perf-profile.children.cycles-pp.__wake_up_common
     41.18            -4.4       36.81 ±  8%  perf-profile.children.cycles-pp.cpuidle_enter
     39.59            -4.3       35.28 ±  8%  perf-profile.children.cycles-pp.__wake_up_common_lock
     40.71            -3.9       36.77 ±  7%  perf-profile.children.cycles-pp.pipe_write
     40.79            -3.9       36.89 ±  7%  perf-profile.children.cycles-pp.new_sync_write
     41.10            -3.8       37.30 ±  6%  perf-profile.children.cycles-pp.vfs_write
     41.23            -3.7       37.53 ±  6%  perf-profile.children.cycles-pp.ksys_write
     46.78            -1.8       45.02 ±  2%  perf-profile.children.cycles-pp.start_secondary
     47.29            -1.5       45.81 ±  2%  perf-profile.children.cycles-pp.secondary_startup_64
     47.29            -1.5       45.81 ±  2%  perf-profile.children.cycles-pp.cpu_startup_entry
     47.29            -1.5       45.82 ±  2%  perf-profile.children.cycles-pp.do_idle
      6.34 ±  6%      -1.1        5.29 ±  9%  perf-profile.children.cycles-pp.write
      0.34 ±  5%      -0.1        0.29 ± 12%  perf-profile.children.cycles-pp.tick_sched_handle
      0.33 ±  5%      -0.0        0.29 ± 11%  perf-profile.children.cycles-pp.update_process_times
      0.24 ±  3%      -0.0        0.20 ± 14%  perf-profile.children.cycles-pp.scheduler_tick
      0.05 ±  8%      +0.0        0.08 ± 16%  perf-profile.children.cycles-pp.generic_pipe_buf_confirm
      0.23            +0.0        0.26 ±  4%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.12 ±  4%      +0.0        0.16 ±  7%  perf-profile.children.cycles-pp.cpus_share_cache
      0.06            +0.0        0.09 ± 26%  perf-profile.children.cycles-pp.atime_needs_update
      0.26 ±  4%      +0.0        0.30 ±  9%  perf-profile.children.cycles-pp.rcu_idle_exit
      0.08 ±  5%      +0.0        0.12 ± 26%  perf-profile.children.cycles-pp.copyin
      0.09 ±  7%      +0.0        0.13 ± 25%  perf-profile.children.cycles-pp.stack_access_ok
      0.09            +0.0        0.13 ± 20%  perf-profile.children.cycles-pp.__calc_delta
      0.04 ± 57%      +0.0        0.08 ± 20%  perf-profile.children.cycles-pp.is_bpf_text_address
      0.23            +0.0        0.27 ±  6%  perf-profile.children.cycles-pp.update_ts_time_stats
      0.12 ±  7%      +0.0        0.16 ± 19%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.09 ±  4%      +0.0        0.13 ± 25%  perf-profile.children.cycles-pp.touch_atime
      0.06 ±  6%      +0.0        0.10 ± 31%  perf-profile.children.cycles-pp.__might_fault
      0.03 ±100%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.rcu_core
      0.12 ±  6%      +0.0        0.17 ± 13%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.21 ±  3%      +0.0        0.26 ± 10%  perf-profile.children.cycles-pp.newidle_balance
      0.11            +0.0        0.16 ± 23%  perf-profile.children.cycles-pp.in_sched_functions
      0.09 ±  5%      +0.0        0.13 ± 26%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.01 ±173%      +0.0        0.06 ± 11%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.01 ±173%      +0.1        0.06 ± 26%  perf-profile.children.cycles-pp.__x64_sys_write
      0.04 ± 57%      +0.1        0.09 ± 40%  perf-profile.children.cycles-pp.set_next_task_idle
      0.06 ±  6%      +0.1        0.12 ± 39%  perf-profile.children.cycles-pp.pick_next_task_idle
      0.09 ±  7%      +0.1        0.14 ± 26%  perf-profile.children.cycles-pp.menu_reflect
      0.06 ±  7%      +0.1        0.11 ± 25%  perf-profile.children.cycles-pp.find_next_bit
      0.01 ±173%      +0.1        0.07 ± 19%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.00            +0.1        0.06 ± 15%  perf-profile.children.cycles-pp.bpf_prog_kallsyms_find
      0.00            +0.1        0.06 ± 15%  perf-profile.children.cycles-pp.get_cpu_device
      0.29 ±  4%      +0.1        0.35 ±  8%  perf-profile.children.cycles-pp.copyout
      0.00            +0.1        0.06 ± 28%  perf-profile.children.cycles-pp.in_lock_functions
      0.09 ±  5%      +0.1        0.15 ± 26%  perf-profile.children.cycles-pp.current_time
      0.23            +0.1        0.29 ± 10%  perf-profile.children.cycles-pp.mutex_unlock
      0.12 ±  5%      +0.1        0.18 ± 25%  perf-profile.children.cycles-pp.fsnotify
      0.08 ±  5%      +0.1        0.15 ± 30%  perf-profile.children.cycles-pp.file_update_time
      0.20 ±  2%      +0.1        0.26 ±  3%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.07            +0.1        0.13 ± 38%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rbx
      0.04 ± 57%      +0.1        0.11 ± 24%  perf-profile.children.cycles-pp.put_prev_entity
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.00            +0.1        0.06 ± 17%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
      0.14 ±  3%      +0.1        0.21 ± 21%  perf-profile.children.cycles-pp.resched_curr
      0.00            +0.1        0.07 ± 31%  perf-profile.children.cycles-pp.timestamp_truncate
      0.00            +0.1        0.07 ± 30%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.11 ±  6%      +0.1        0.18 ± 21%  perf-profile.children.cycles-pp.rcu_eqs_enter
      0.32 ±  6%      +0.1        0.39 ± 11%  perf-profile.children.cycles-pp.copy_user_generic_unrolled
      0.11 ±  4%      +0.1        0.19 ± 23%  perf-profile.children.cycles-pp.account_entity_dequeue
      0.00            +0.1        0.07 ± 43%  perf-profile.children.cycles-pp.__update_idle_core
      0.28 ±  3%      +0.1        0.35 ±  6%  perf-profile.children.cycles-pp.irq_exit
      0.17 ±  4%      +0.1        0.25 ± 24%  perf-profile.children.cycles-pp.__fget_light
      0.23 ±  3%      +0.1        0.31 ± 20%  perf-profile.children.cycles-pp.reweight_entity
      0.19 ±  4%      +0.1        0.27 ± 13%  perf-profile.children.cycles-pp.pick_next_entity
      0.23 ±  2%      +0.1        0.30 ± 16%  perf-profile.children.cycles-pp.check_preempt_curr
      0.27 ±  4%      +0.1        0.35 ± 14%  perf-profile.children.cycles-pp.native_write_msr
      0.11 ± 11%      +0.1        0.19 ± 21%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.11 ±  3%      +0.1        0.20 ± 25%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.38            +0.1        0.46 ±  9%  perf-profile.children.cycles-pp.___might_sleep
      0.19 ±  3%      +0.1        0.28 ± 22%  perf-profile.children.cycles-pp.__fdget_pos
      0.13 ±  9%      +0.1        0.22 ± 15%  perf-profile.children.cycles-pp.clockevents_program_event
      0.13 ±  6%      +0.1        0.23 ± 25%  perf-profile.children.cycles-pp.__might_sleep
      0.53 ±  3%      +0.1        0.63 ± 11%  perf-profile.children.cycles-pp.update_rq_clock
      0.19 ±  5%      +0.1        0.29 ± 17%  perf-profile.children.cycles-pp.read_tsc
      0.26 ±  2%      +0.1        0.36 ± 17%  perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.26 ±  3%      +0.1        0.36 ± 22%  perf-profile.children.cycles-pp.common_file_perm
      0.18 ±  2%      +0.1        0.28 ± 16%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.09 ±  8%      +0.1        0.19 ± 28%  perf-profile.children.cycles-pp.put_prev_task_fair
      0.16 ±  4%      +0.1        0.26 ± 32%  perf-profile.children.cycles-pp.switch_fpu_return
      0.16 ±  2%      +0.1        0.28 ± 30%  perf-profile.children.cycles-pp.___perf_sw_event
      0.25            +0.1        0.38 ± 20%  perf-profile.children.cycles-pp.native_sched_clock
      0.19 ±  4%      +0.1        0.32 ± 31%  perf-profile.children.cycles-pp.orc_find
      0.34            +0.1        0.47 ± 16%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.29 ±  2%      +0.1        0.43 ± 21%  perf-profile.children.cycles-pp.__orc_find
      0.26            +0.1        0.40 ± 20%  perf-profile.children.cycles-pp.sched_clock
      0.24 ±  3%      +0.1        0.38 ± 27%  perf-profile.children.cycles-pp.finish_task_switch
      0.23 ±  7%      +0.1        0.37 ± 22%  perf-profile.children.cycles-pp.kernel_text_address
      0.28 ±  3%      +0.1        0.42 ± 22%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.74            +0.1        0.89 ±  6%  perf-profile.children.cycles-pp.mutex_lock
      0.23            +0.1        0.38 ± 26%  perf-profile.children.cycles-pp.copy_page_from_iter
      0.56 ±  5%      +0.2        0.71 ± 11%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.28            +0.2        0.43 ± 21%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.45 ±  3%      +0.2        0.60 ± 13%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.63            +0.2        0.79 ± 13%  perf-profile.children.cycles-pp.prepare_to_wait_event
      0.52 ±  4%      +0.2        0.69 ± 19%  perf-profile.children.cycles-pp.__switch_to
      0.39 ±  2%      +0.2        0.55 ± 18%  perf-profile.children.cycles-pp.__switch_to_asm
      0.35 ±  3%      +0.2        0.52 ± 23%  perf-profile.children.cycles-pp.security_file_permission
      0.24            +0.2        0.41 ± 32%  perf-profile.children.cycles-pp._find_next_bit
      1.16 ±  5%      +0.2        1.33 ±  5%  perf-profile.children.cycles-pp.apic_timer_interrupt
      0.35 ±  4%      +0.2        0.53 ± 28%  perf-profile.children.cycles-pp.update_cfs_group
      0.28 ±  5%      +0.2        0.45 ± 24%  perf-profile.children.cycles-pp.__kernel_text_address
      0.44            +0.2        0.65 ± 23%  perf-profile.children.cycles-pp.stack_trace_consume_entry_nosched
      0.16 ±  2%      +0.2        0.38 ± 51%  perf-profile.children.cycles-pp.available_idle_cpu
      0.33 ±  3%      +0.2        0.55 ± 26%  perf-profile.children.cycles-pp.unwind_get_return_address
      0.43 ±  4%      +0.2        0.67 ± 24%  perf-profile.children.cycles-pp.__next_timer_interrupt
      0.35 ±  4%      +0.3        0.61 ± 13%  perf-profile.children.cycles-pp.ktime_get
      0.60 ±  2%      +0.3        0.88 ± 16%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.40 ±  2%      +0.3        0.69 ± 28%  perf-profile.children.cycles-pp.__unwind_start
      0.85            +0.3        1.17 ± 19%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.65 ±  3%      +0.3        0.97 ± 22%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      1.18            +0.3        1.50 ± 12%  perf-profile.children.cycles-pp.set_next_entity
      0.94            +0.3        1.28 ± 17%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.79 ±  3%      +0.4        1.15 ± 21%  perf-profile.children.cycles-pp.tick_nohz_next_event
      1.03 ±  2%      +0.4        1.45 ± 21%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.74 ±  2%      +0.4        1.17 ± 24%  perf-profile.children.cycles-pp.update_curr
      0.59 ±  2%      +0.5        1.13 ± 37%  perf-profile.children.cycles-pp.select_task_rq_fair
      1.77            +0.6        2.33 ± 13%  perf-profile.children.cycles-pp.pick_next_task_fair
      1.62 ±  3%      +0.7        2.33 ± 21%  perf-profile.children.cycles-pp.menu_select
      1.73            +0.8        2.57 ± 22%  perf-profile.children.cycles-pp.unwind_next_frame
      1.52 ±  2%      +0.9        2.44 ± 24%  perf-profile.children.cycles-pp.update_load_avg
      1.51            +0.9        2.46 ± 25%  perf-profile.children.cycles-pp.dequeue_entity
      1.46 ±  6%      +1.1        2.59 ±  9%  perf-profile.children.cycles-pp.read
      1.76            +1.1        2.91 ± 25%  perf-profile.children.cycles-pp.dequeue_task_fair
      2.76            +1.4        4.17 ± 23%  perf-profile.children.cycles-pp.arch_stack_walk
      0.14 ±  5%      +1.4        1.59 ± 85%  perf-profile.children.cycles-pp.poll_idle
      3.35            +1.5        4.84 ± 21%  perf-profile.children.cycles-pp.stack_trace_save_tsk
      2.80            +1.6        4.37 ± 28%  perf-profile.children.cycles-pp.schedule_idle
      0.55 ±  2%      +1.8        2.33 ± 71%  perf-profile.children.cycles-pp._raw_spin_lock
      3.29            +2.0        5.28 ± 26%  perf-profile.children.cycles-pp.schedule
      5.81            +2.7        8.51 ± 21%  perf-profile.children.cycles-pp.pipe_read
      5.91            +2.8        8.68 ± 22%  perf-profile.children.cycles-pp.new_sync_read
      6.38            +3.0        9.40 ± 21%  perf-profile.children.cycles-pp.vfs_read
      6.56            +3.1        9.63 ± 21%  perf-profile.children.cycles-pp.ksys_read
      5.99            +3.5        9.51 ± 27%  perf-profile.children.cycles-pp.__sched_text_start
     30.51            -6.9       23.59 ± 19%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
     39.93            -6.0       33.94 ± 13%  perf-profile.self.cycles-pp.intel_idle
      0.05            +0.0        0.07 ± 13%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.08 ±  5%      +0.0        0.10 ±  8%  perf-profile.self.cycles-pp.check_preempt_curr
      0.23            +0.0        0.26 ±  4%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.08            +0.0        0.11 ± 19%  perf-profile.self.cycles-pp.in_sched_functions
      0.06 ±  6%      +0.0        0.09 ± 16%  perf-profile.self.cycles-pp.schedule
      0.05            +0.0        0.08 ± 20%  perf-profile.self.cycles-pp.generic_pipe_buf_confirm
      0.05            +0.0        0.08 ± 30%  perf-profile.self.cycles-pp.__kernel_text_address
      0.05 ±  8%      +0.0        0.08 ± 27%  perf-profile.self.cycles-pp.put_task_stack
      0.12 ±  4%      +0.0        0.16 ±  7%  perf-profile.self.cycles-pp.cpus_share_cache
      0.08 ±  5%      +0.0        0.11 ± 23%  perf-profile.self.cycles-pp.stack_access_ok
      0.08 ±  5%      +0.0        0.11 ± 17%  perf-profile.self.cycles-pp.ksys_read
      0.06 ± 11%      +0.0        0.09 ± 23%  perf-profile.self.cycles-pp.kernel_text_address
      0.06 ±  6%      +0.0        0.10 ± 21%  perf-profile.self.cycles-pp.menu_reflect
      0.04 ± 58%      +0.0        0.08 ± 19%  perf-profile.self.cycles-pp.copy_page_from_iter
      0.20 ±  4%      +0.0        0.24 ±  9%  perf-profile.self.cycles-pp.newidle_balance
      0.12 ±  6%      +0.0        0.16 ± 14%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.05 ±  8%      +0.0        0.10 ± 39%  perf-profile.self.cycles-pp.unwind_get_return_address
      0.10 ±  4%      +0.0        0.15 ± 27%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.08 ±  8%      +0.0        0.13 ± 24%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.01 ±173%      +0.0        0.06 ± 20%  perf-profile.self.cycles-pp.security_file_permission
      0.05 ±  9%      +0.1        0.10 ± 35%  perf-profile.self.cycles-pp.__x86_indirect_thunk_rbx
      0.18 ±  2%      +0.1        0.24 ± 15%  perf-profile.self.cycles-pp.prepare_to_wait_event
      0.04 ± 57%      +0.1        0.09 ± 27%  perf-profile.self.cycles-pp.put_prev_entity
      0.09 ±  5%      +0.1        0.14 ± 19%  perf-profile.self.cycles-pp.copy_page_to_iter
      0.05 ±  8%      +0.1        0.11 ± 40%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.01 ±173%      +0.1        0.07 ± 19%  perf-profile.self.cycles-pp.sched_ttwu_pending
      0.00            +0.1        0.06 ± 15%  perf-profile.self.cycles-pp.bpf_prog_kallsyms_find
      0.00            +0.1        0.06 ± 15%  perf-profile.self.cycles-pp.get_cpu_device
      0.23 ±  3%      +0.1        0.29 ± 14%  perf-profile.self.cycles-pp.reweight_entity
      0.20 ±  2%      +0.1        0.25 ±  3%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.18 ±  3%      +0.1        0.24 ±  9%  perf-profile.self.cycles-pp.pick_next_entity
      0.00            +0.1        0.06 ± 22%  perf-profile.self.cycles-pp.activate_task
      0.00            +0.1        0.06 ± 14%  perf-profile.self.cycles-pp.__is_insn_slot_addr
      0.08 ±  8%      +0.1        0.14 ± 32%  perf-profile.self.cycles-pp.arch_stack_walk
      0.00            +0.1        0.06 ± 28%  perf-profile.self.cycles-pp.__x64_sys_write
      0.23            +0.1        0.29 ± 10%  perf-profile.self.cycles-pp.mutex_unlock
      0.11 ±  7%      +0.1        0.18 ± 25%  perf-profile.self.cycles-pp.fsnotify
      0.30 ±  2%      +0.1        0.36 ± 16%  perf-profile.self.cycles-pp.try_to_wake_up
      0.11 ±  4%      +0.1        0.17 ± 23%  perf-profile.self.cycles-pp.rcu_eqs_enter
      0.00            +0.1        0.06 ± 17%  perf-profile.self.cycles-pp.cpuidle_governor_latency_req
      0.17 ±  2%      +0.1        0.24 ± 24%  perf-profile.self.cycles-pp.__unwind_start
      0.14 ±  3%      +0.1        0.21 ± 21%  perf-profile.self.cycles-pp.resched_curr
      0.09 ±  7%      +0.1        0.15 ± 33%  perf-profile.self.cycles-pp.new_sync_read
      0.00            +0.1        0.07 ± 31%  perf-profile.self.cycles-pp.timestamp_truncate
      0.17 ±  2%      +0.1        0.24 ± 17%  perf-profile.self.cycles-pp.__account_scheduler_latency
      0.00            +0.1        0.07 ± 12%  perf-profile.self.cycles-pp.ksys_write
      0.11 ±  6%      +0.1        0.18 ± 24%  perf-profile.self.cycles-pp.account_entity_dequeue
      0.31 ±  6%      +0.1        0.38 ± 11%  perf-profile.self.cycles-pp.copy_user_generic_unrolled
      0.00            +0.1        0.07 ± 39%  perf-profile.self.cycles-pp.__update_idle_core
      0.39 ±  4%      +0.1        0.46 ±  8%  perf-profile.self.cycles-pp.mutex_lock
      0.17 ±  2%      +0.1        0.24 ± 23%  perf-profile.self.cycles-pp.__fget_light
      0.11 ±  4%      +0.1        0.18 ± 24%  perf-profile.self.cycles-pp.__x86_indirect_thunk_rax
      0.12 ± 10%      +0.1        0.20 ± 25%  perf-profile.self.cycles-pp.__might_sleep
      0.08 ±  8%      +0.1        0.16 ± 28%  perf-profile.self.cycles-pp.dequeue_entity
      0.00            +0.1        0.08 ± 34%  perf-profile.self.cycles-pp.put_prev_task_fair
      0.37            +0.1        0.46 ±  9%  perf-profile.self.cycles-pp.___might_sleep
      0.15 ±  3%      +0.1        0.24 ± 17%  perf-profile.self.cycles-pp.vfs_read
      0.26 ±  4%      +0.1        0.35 ± 14%  perf-profile.self.cycles-pp.native_write_msr
      0.23 ±  2%      +0.1        0.31 ± 21%  perf-profile.self.cycles-pp.common_file_perm
      0.20 ±  2%      +0.1        0.28 ± 24%  perf-profile.self.cycles-pp.finish_task_switch
      0.18 ±  4%      +0.1        0.27 ± 16%  perf-profile.self.cycles-pp.read_tsc
      0.17 ±  8%      +0.1        0.26 ± 22%  perf-profile.self.cycles-pp.__next_timer_interrupt
      0.15 ±  4%      +0.1        0.25 ± 31%  perf-profile.self.cycles-pp.switch_fpu_return
      0.42            +0.1        0.53 ± 17%  perf-profile.self.cycles-pp.do_idle
      0.12 ±  4%      +0.1        0.24 ± 31%  perf-profile.self.cycles-pp.___perf_sw_event
      0.38 ±  2%      +0.1        0.49 ± 16%  perf-profile.self.cycles-pp.pipe_read
      0.27 ±  3%      +0.1        0.39 ± 19%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.18 ±  4%      +0.1        0.31 ± 29%  perf-profile.self.cycles-pp.orc_find
      0.24            +0.1        0.37 ± 19%  perf-profile.self.cycles-pp.native_sched_clock
      0.28 ±  2%      +0.1        0.41 ± 21%  perf-profile.self.cycles-pp.__orc_find
      0.30            +0.1        0.44 ± 24%  perf-profile.self.cycles-pp.stack_trace_consume_entry_nosched
      0.21 ±  2%      +0.1        0.34 ± 22%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.38 ±  3%      +0.1        0.52 ± 17%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.27 ±  3%      +0.1        0.41 ± 22%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.48 ±  4%      +0.2        0.64 ± 18%  perf-profile.self.cycles-pp.__switch_to
      0.74            +0.2        0.91 ± 11%  perf-profile.self.cycles-pp.enqueue_entity
      0.39 ±  2%      +0.2        0.55 ± 19%  perf-profile.self.cycles-pp.__switch_to_asm
      0.23            +0.2        0.40 ± 32%  perf-profile.self.cycles-pp._find_next_bit
      0.16 ± 14%      +0.2        0.34 ± 13%  perf-profile.self.cycles-pp.ktime_get
      0.37 ±  3%      +0.2        0.55 ± 20%  perf-profile.self.cycles-pp._raw_spin_lock
      0.44 ±  6%      +0.2        0.62 ± 22%  perf-profile.self.cycles-pp.menu_select
      0.28 ±  4%      +0.2        0.46 ± 37%  perf-profile.self.cycles-pp.update_cfs_group
      0.16 ±  2%      +0.2        0.37 ± 51%  perf-profile.self.cycles-pp.available_idle_cpu
      1.55            +0.2        1.76 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.30 ±  3%      +0.2        0.53 ± 28%  perf-profile.self.cycles-pp.select_task_rq_fair
      1.09 ±  2%      +0.2        1.32 ± 15%  perf-profile.self.cycles-pp.__sched_text_start
      0.59 ±  3%      +0.3        0.86 ± 17%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.83            +0.3        1.14 ± 19%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.94 ±  2%      +0.3        1.27 ± 17%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.55 ±  2%      +0.3        0.90 ± 24%  perf-profile.self.cycles-pp.update_curr
      0.62 ±  2%      +0.4        1.07 ± 29%  perf-profile.self.cycles-pp.update_load_avg
      1.15            +0.5        1.68 ± 21%  perf-profile.self.cycles-pp.unwind_next_frame
      1.58            +0.8        2.35 ± 22%  perf-profile.self.cycles-pp.do_syscall_64
      0.09 ±  5%      +1.4        1.50 ± 89%  perf-profile.self.cycles-pp.poll_idle



***************************************************************************************************
lkp-hsw-d01: 8 threads Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz with 8G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/target/tbox_group/testcase/ucode:
  gcc-7/performance/x86_64-rhel-7.6/50%/debian-x86_64-20191114.cgz/300s/vmlinux_prereq/lkp-hsw-d01/kbuild/0x27

commit: 
  9c40365a65 ("threads: Update PID limit comment according to futex UAPI change")
  59901cb452 ("sched/fair: Don't pull task if local group is more loaded than busiest group")

9c40365a65d62d7c 59901cb4520c44bfce81f523bc6 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          1:4          -25%            :4     dmesg.BUG:Bad_page_map_in_process
          1:4          -25%            :4     dmesg.BUG:Bad_rss-counter_state_mm:#type:MM_ANONPAGES_val
          1:4          -25%            :4     dmesg.BUG:Bad_rss-counter_state_mm:#type:MM_SWAPENTS_val
           :4           25%           1:4     dmesg.Kernel_panic-not_syncing:Fatal_exception
           :4           25%           1:4     dmesg.RIP:__d_lookup_rcu
           :4           25%           1:4     dmesg.canonical_address#:#[##]
          1:4          -25%            :4     kmsg.file:libuuid.so.#fault:filemap_fault_mmap:generic_file_mmap_readpage:simple_readpage
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#a07fffffa0ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#a17fffffa1ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#a27fffffa2ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#a37fffffa3ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#a47fffffa4ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#a57fffffa5ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#a67fffffa6ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#a77fffffa7ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#a7fffff8aff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#a7fffff9aff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#a87fffffa8ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#a97fffffa9ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#aa7fffffaaff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#ab7fffffabff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#ac7fffffacff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#ad7fffffadff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#ae7fffffaeff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#af7fffffafff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#b07fffffb0ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#b17fffffb1ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#b27fffffb2ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#b37fffffb3ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#b47fffffb4ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#b57fffffb5ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#b67fffffb6ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#b77fffffb7ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#b7fffff8bff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#b7fffff9bff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#b87fffffb8ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#b97fffffb9ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#ba7fffffbaff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#bb7fffffbbff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#bc7fffffbcff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#bd7fffffbdff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#be7fffffbeff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#bf7fffffbfff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#c07fffffc0ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#c17fffffc1ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#c27fffffc2ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#c37fffffc3ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#c47fffffc4ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#c57fffffc5ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#c67fffffc6ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#c77fffffc7ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#c7fffff8cff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#c7fffff9cff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#c87fffffc8ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#c97fffffc9ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#ca7fffffcaff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#cb7fffffcbff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#cc7fffffccff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#cd7fffffcdff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#ce7fffffceff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#cf7fffffcfff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#d07fffffd0ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#d17fffffd1ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#d27fffffd2ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#d37fffffd3ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#d47fffffd4ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#d57fffffd5ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#d67fffffd6ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#d77fffffd7ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#d7fffff8dff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#d7fffff9dff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#d87fffffd8ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#d97fffffd9ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#da7fffffdaff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#db7fffffdbff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#dc7fffffdcff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#dd7fffffddff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#de7fffffdeff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#df7fffffdfff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#e07fffffe0ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#e17fffffe1ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#e27fffffe2ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#e37fffffe3ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#e47fffffe4ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#e57fffffe5ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#e67fffffe6ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#e77fffffe7ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#e7fffff8eff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#e7fffff9eff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#e87fffffe8ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#e97fffffe9ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#ea7fffffeaff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#eb7fffffebff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#ec7fffffecff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#ed7fffffedff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#ee7fffffeeff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#ef7fffffefff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#f07ffffff0ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#f17ffffff1ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#f27ffffff2ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#f37ffffff3ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#f47ffffff4ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#f57ffffff5ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#f67ffffff6ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#f77ffffff7ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#f7fffff8fff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#f7fffff9fff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#f87ffffff8ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#f97ffffff9ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#fa7ffffffaff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#fb7ffffffbff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#fc7ffffffcff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#fd7ffffffdff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#fe7ffffffeff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#ff7fffffffff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#fffff80ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#fffff81ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#fffff82ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#fffff83ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#fffff84ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#fffff85ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#fffff86ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#fffff87ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#fffff88ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#fffff89ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#fffff90ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#fffff91ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#fffff92ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#fffff93ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#fffff94ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#fffff95ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#fffff96ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#fffff97ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#fffff98ff
          1:4          -25%            :4     kmsg.swap_info_get:Bad_swap_file_entry#fffff99ff
          0:4            0%           0:4     perf-profile.children.cycles-pp.warning_at
          0:4            3%           0:4     perf-profile.children.cycles-pp.warning
          0:4            4%           1:4     perf-profile.children.cycles-pp.error_entry
          0:4            4%           0:4     perf-profile.self.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
    173.17            +7.5%     186.17        kbuild.buildtime_per_iteration
    346.13            +7.5%     372.13        kbuild.time.elapsed_time
    346.13            +7.5%     372.13        kbuild.time.elapsed_time.max
     62328            -4.4%      59613        kbuild.time.involuntary_context_switches
    119.99            +3.7%     124.42        kbuild.time.system_time
      1258            +7.8%       1357        kbuild.time.user_time
      3976 ±  2%      -5.2%       3768 ±  2%  proc-vmstat.pgactivate
      8581            -7.6%       7925        vmstat.system.cs
     29.08 ±  6%     +27.4%      37.06 ± 21%  boot-time.boot
    190.33 ±  5%     +31.2%     249.80 ± 20%  boot-time.idle
 2.474e+08 ± 62%     +85.2%   4.58e+08 ± 21%  cpuidle.C6.time
    361421 ± 60%     +70.5%     616268 ±  5%  cpuidle.C6.usage
      2265 ±  6%     -16.4%       1895 ± 10%  slabinfo.cred_jar.active_objs
      2301 ±  5%     -15.3%       1950 ±  9%  slabinfo.cred_jar.num_objs
    793.33           +14.3%     907.00 ±  4%  slabinfo.task_delay_info.active_objs
    793.33           +14.3%     907.00 ±  4%  slabinfo.task_delay_info.num_objs
    249422           +10.7%     276098 ±  4%  softirqs.CPU0.RCU
    138168           +30.3%     180101 ± 12%  softirqs.CPU0.TIMER
    139666            +9.2%     152539 ±  2%  softirqs.CPU2.TIMER
    138194 ±  2%     +11.1%     153534 ±  2%  softirqs.CPU4.TIMER
    139323 ±  2%     +11.9%     155966        softirqs.CPU7.TIMER
   1153221           +10.4%    1273097        softirqs.TIMER
    267.67 ± 15%     -37.9%     166.33 ±  9%  interrupts.CPU0.CAL:Function_call_interrupts
      3697 ± 14%     -17.8%       3040 ±  9%  interrupts.CPU0.RES:Rescheduling_interrupts
    245.00 ± 19%     -48.6%     126.00 ±  8%  interrupts.CPU0.TLB:TLB_shootdowns
    188.67 ± 19%     -39.2%     114.67 ± 22%  interrupts.CPU1.TLB:TLB_shootdowns
    292.33 ±  9%     -13.1%     254.00 ± 12%  interrupts.CPU2.CAL:Function_call_interrupts
    241.67 ± 23%     -31.6%     165.33 ±  7%  interrupts.CPU2.TLB:TLB_shootdowns
      7195 ± 19%     -37.5%       4497 ± 29%  interrupts.CPU4.NMI:Non-maskable_interrupts
      7195 ± 19%     -37.5%       4497 ± 29%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
      1361 ±  5%     -16.8%       1132 ± 10%  interrupts.TLB:TLB_shootdowns
      0.00        +1.4e+11%       1382 ±114%  sched_debug.cfs_rq:/.MIN_vruntime.avg
      0.00        +1.1e+12%      11058 ±114%  sched_debug.cfs_rq:/.MIN_vruntime.max
     77852           +20.1%      93480        sched_debug.cfs_rq:/.exec_clock.avg
     82443           +20.3%      99210        sched_debug.cfs_rq:/.exec_clock.max
     72993           +18.4%      86426        sched_debug.cfs_rq:/.exec_clock.min
      2882 ±  6%     +33.9%       3858 ±  9%  sched_debug.cfs_rq:/.exec_clock.stddev
    119503 ±  2%     +20.2%     143687 ±  8%  sched_debug.cfs_rq:/.load.avg
      0.00        +1.4e+11%       1382 ±114%  sched_debug.cfs_rq:/.max_vruntime.avg
      0.00        +1.1e+12%      11058 ±114%  sched_debug.cfs_rq:/.max_vruntime.max
    463036           +18.8%     549986        sched_debug.cfs_rq:/.min_vruntime.avg
    489987           +18.7%     581626        sched_debug.cfs_rq:/.min_vruntime.max
    434924           +17.3%     510306        sched_debug.cfs_rq:/.min_vruntime.min
     17242           +24.4%      21446 ±  6%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.68 ±  6%     +18.1%       0.80 ±  3%  sched_debug.cfs_rq:/.nr_running.avg
      0.44 ±  3%     -18.2%       0.36 ±  5%  sched_debug.cfs_rq:/.nr_running.stddev
     17242           +24.4%      21446 ±  6%  sched_debug.cfs_rq:/.spread0.stddev
    180483           +21.0%     218362 ±  3%  sched_debug.cpu.clock.avg
    180483           +21.0%     218363 ±  3%  sched_debug.cpu.clock.max
    180482           +21.0%     218361 ±  3%  sched_debug.cpu.clock.min
    180483           +21.0%     218362 ±  3%  sched_debug.cpu.clock_task.avg
    180483           +21.0%     218363 ±  3%  sched_debug.cpu.clock_task.max
    180482           +21.0%     218361 ±  3%  sched_debug.cpu.clock_task.min
      9075 ±  6%     +37.6%      12486        sched_debug.cpu.curr->pid.avg
     13910           +37.2%      19088        sched_debug.cpu.curr->pid.max
      6416 ±  2%     +37.6%       8831        sched_debug.cpu.curr->pid.stddev
      1.83 ± 19%     -24.7%       1.38 ± 12%  sched_debug.cpu.nr_running.max
      0.66 ± 18%     -30.6%       0.46 ±  4%  sched_debug.cpu.nr_running.stddev
     22.33 ± 28%     -53.9%      10.29 ± 11%  sched_debug.cpu.nr_uninterruptible.max
     10.96 ±  9%     -35.3%       7.10 ±  7%  sched_debug.cpu.nr_uninterruptible.stddev
    180482           +21.0%     218362 ±  3%  sched_debug.cpu_clk
    179957           +21.0%     217836 ±  3%  sched_debug.ktime
    181437           +20.8%     219109 ±  3%  sched_debug.sched_clk
     13.61            +6.4%      14.47        perf-stat.i.MPKI
 3.762e+09            -7.5%  3.478e+09        perf-stat.i.branch-instructions
      3.00            +0.1        3.08        perf-stat.i.branch-miss-rate%
 1.126e+08            -5.5%  1.064e+08        perf-stat.i.branch-misses
      8.73            -0.6        8.17 ±  2%  perf-stat.i.cache-miss-rate%
  20492578           -10.3%   18373371        perf-stat.i.cache-misses
 2.365e+08            -2.6%  2.303e+08        perf-stat.i.cache-references
      8639            -7.7%       7977        perf-stat.i.context-switches
      0.92            +9.1%       1.00 ±  2%  perf-stat.i.cpi
 1.582e+10            -1.2%  1.562e+10        perf-stat.i.cpu-cycles
    182.40           -11.9%     160.76        perf-stat.i.cpu-migrations
    799.50            +9.7%     877.23        perf-stat.i.cycles-between-cache-misses
      0.31            +0.0        0.33        perf-stat.i.dTLB-load-miss-rate%
  14810335            -4.5%   14149852        perf-stat.i.dTLB-load-misses
 4.694e+09            -7.5%  4.341e+09        perf-stat.i.dTLB-loads
  2.55e+09            -7.0%  2.373e+09        perf-stat.i.dTLB-stores
   4617509            +8.3%    4998953 ±  2%  perf-stat.i.iTLB-load-misses
  17720319            +7.6%   19060873        perf-stat.i.iTLB-loads
 1.731e+10            -7.5%  1.601e+10        perf-stat.i.instructions
      3841           -13.1%       3339 ±  2%  perf-stat.i.instructions-per-iTLB-miss
      1.09            -6.6%       1.02        perf-stat.i.ipc
    164253            -7.3%     152206        perf-stat.i.minor-faults
  13452948           -11.3%   11934691        perf-stat.i.node-loads
   1875909 ±  3%     -11.5%    1659475 ±  3%  perf-stat.i.node-stores
    164253            -7.3%     152206        perf-stat.i.page-faults
     13.66            +5.3%      14.38        perf-stat.overall.MPKI
      2.99            +0.1        3.06        perf-stat.overall.branch-miss-rate%
      8.67            -0.7        7.98        perf-stat.overall.cache-miss-rate%
      0.91            +6.8%       0.98        perf-stat.overall.cpi
    771.90           +10.2%     850.28        perf-stat.overall.cycles-between-cache-misses
      0.31            +0.0        0.32        perf-stat.overall.dTLB-load-miss-rate%
      3749           -14.5%       3205 ±  3%  perf-stat.overall.instructions-per-iTLB-miss
      1.09            -6.4%       1.02        perf-stat.overall.ipc
 3.751e+09            -7.5%  3.469e+09        perf-stat.ps.branch-instructions
 1.123e+08            -5.5%  1.062e+08        perf-stat.ps.branch-misses
  20432412           -10.3%   18323590        perf-stat.ps.cache-misses
 2.358e+08            -2.6%  2.297e+08        perf-stat.ps.cache-references
      8613            -7.6%       7955        perf-stat.ps.context-switches
 1.577e+10            -1.2%  1.558e+10        perf-stat.ps.cpu-cycles
    181.89           -11.9%     160.32        perf-stat.ps.cpu-migrations
  14766724            -4.4%   14111258        perf-stat.ps.dTLB-load-misses
  4.68e+09            -7.5%   4.33e+09        perf-stat.ps.dTLB-loads
 2.543e+09            -6.9%  2.366e+09        perf-stat.ps.dTLB-stores
   4603933            +8.3%    4985424 ±  2%  perf-stat.ps.iTLB-load-misses
  17668225            +7.6%   19009302        perf-stat.ps.iTLB-loads
 1.726e+10            -7.5%  1.597e+10        perf-stat.ps.instructions
    163774            -7.3%     151790        perf-stat.ps.minor-faults
  13413384           -11.3%   11902353        perf-stat.ps.node-loads
   1870377 ±  3%     -11.5%    1654965 ±  3%  perf-stat.ps.node-stores
    163774            -7.3%     151790        perf-stat.ps.page-faults
      4.07 ± 13%      -1.8        2.30 ± 20%  perf-profile.calltrace.cycles-pp.write._fini
      4.07 ± 13%      -1.8        2.30 ± 20%  perf-profile.calltrace.cycles-pp._fini
      4.07 ± 13%      -1.8        2.30 ± 21%  perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.new_sync_write
      4.07 ± 13%      -1.8        2.30 ± 20%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write._fini
      4.07 ± 13%      -1.8        2.30 ± 20%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write._fini
      4.07 ± 13%      -1.8        2.30 ± 20%  perf-profile.calltrace.cycles-pp.vprintk_emit.devkmsg_emit.devkmsg_write.new_sync_write.vfs_write
      4.07 ± 13%      -1.8        2.30 ± 20%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write._fini
      4.07 ± 13%      -1.8        2.30 ± 20%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      4.07 ± 13%      -1.8        2.30 ± 20%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.07 ± 13%      -1.8        2.30 ± 20%  perf-profile.calltrace.cycles-pp.devkmsg_write.new_sync_write.vfs_write.ksys_write.do_syscall_64
      4.07 ± 13%      -1.8        2.30 ± 20%  perf-profile.calltrace.cycles-pp.devkmsg_emit.devkmsg_write.new_sync_write.vfs_write.ksys_write
      3.46 ± 14%      -1.4        2.03 ± 21%  perf-profile.calltrace.cycles-pp.serial8250_console_write.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write
      3.27 ± 13%      -1.4        1.90 ± 20%  perf-profile.calltrace.cycles-pp.uart_console_write.serial8250_console_write.console_unlock.vprintk_emit.devkmsg_emit
      3.20 ± 14%      -1.1        2.08 ± 29%  perf-profile.calltrace.cycles-pp.wait_for_xmitr.serial8250_console_putchar.uart_console_write.serial8250_console_write.console_unlock
      3.20 ± 14%      -1.1        2.08 ± 29%  perf-profile.calltrace.cycles-pp.serial8250_console_putchar.uart_console_write.serial8250_console_write.console_unlock.vprintk_emit
      2.16 ± 14%      -0.9        1.27 ± 18%  perf-profile.calltrace.cycles-pp.io_serial_in.wait_for_xmitr.serial8250_console_putchar.uart_console_write.serial8250_console_write
      1.02 ± 14%      -0.6        0.45 ± 72%  perf-profile.calltrace.cycles-pp.delay_tsc.wait_for_xmitr.serial8250_console_putchar.uart_console_write.serial8250_console_write
      1.24 ±  2%      -0.3        0.95 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.24 ±  2%      -0.3        0.95 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.56 ±  3%      -0.2        0.36 ± 70%  perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.84 ±  8%      -0.2        0.66 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.84 ±  8%      -0.2        0.66 ±  3%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.84 ±  8%      -0.2        0.66 ±  3%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.80 ±  8%      -0.2        0.63 ±  3%  perf-profile.calltrace.cycles-pp.mmput.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.80 ±  8%      -0.2        0.63 ±  3%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.do_exit.do_group_exit.__x64_sys_exit_group
      0.79 ±  3%      -0.1        0.71 ±  6%  perf-profile.calltrace.cycles-pp.read
      0.73 ±  3%      -0.1        0.65 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      0.73 ±  3%      -0.1        0.65 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.63 ±  4%      -0.1        0.56 ±  6%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.98 ±  3%      -0.1        0.91 ±  6%  perf-profile.calltrace.cycles-pp.swapgs_restore_regs_and_return_to_usermode
      0.65 ±  4%      -0.1        0.58 ±  4%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.58 ±  2%      +0.1        0.67 ±  7%  perf-profile.calltrace.cycles-pp.wide_int_to_tree
      0.66 ± 11%      +0.1        0.78 ± 11%  perf-profile.calltrace.cycles-pp.c_lex_with_flags
      0.65 ±  6%      +0.2        0.81 ±  7%  perf-profile.calltrace.cycles-pp.linemap_lookup
      0.34 ± 70%      +0.2        0.54 ±  2%  perf-profile.calltrace.cycles-pp.pop_scope
      2.11 ±  5%      +0.2        2.36 ±  3%  perf-profile.calltrace.cycles-pp._cpp_lex_direct
      1.14 ±  2%      +0.3        1.44 ± 11%  perf-profile.calltrace.cycles-pp.memchr
      8.11 ±  5%      -2.4        5.75 ± 11%  perf-profile.children.cycles-pp.do_syscall_64
      8.13 ±  5%      -2.4        5.77 ± 11%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      4.19 ± 12%      -1.8        2.36 ± 20%  perf-profile.children.cycles-pp.ksys_write
      4.21 ± 12%      -1.8        2.38 ± 20%  perf-profile.children.cycles-pp.write
      4.18 ± 12%      -1.8        2.36 ± 20%  perf-profile.children.cycles-pp.vfs_write
      4.17 ± 13%      -1.8        2.36 ± 20%  perf-profile.children.cycles-pp.new_sync_write
      4.07 ± 13%      -1.8        2.30 ± 20%  perf-profile.children.cycles-pp._fini
      4.07 ± 13%      -1.8        2.30 ± 20%  perf-profile.children.cycles-pp.devkmsg_write
      4.07 ± 13%      -1.8        2.30 ± 20%  perf-profile.children.cycles-pp.devkmsg_emit
      4.65 ± 13%      -1.5        3.13 ± 20%  perf-profile.children.cycles-pp.vprintk_emit
      4.73 ± 14%      -1.5        3.25 ± 16%  perf-profile.children.cycles-pp.console_unlock
      4.09 ± 15%      -1.2        2.94 ± 16%  perf-profile.children.cycles-pp.serial8250_console_write
      3.99 ± 15%      -1.1        2.88 ± 16%  perf-profile.children.cycles-pp.wait_for_xmitr
      3.89 ± 15%      -1.1        2.80 ± 16%  perf-profile.children.cycles-pp.uart_console_write
      3.80 ± 15%      -1.0        2.75 ± 15%  perf-profile.children.cycles-pp.serial8250_console_putchar
      2.71 ± 15%      -0.8        1.94 ± 15%  perf-profile.children.cycles-pp.io_serial_in
      1.27 ± 15%      -0.3        0.94 ± 18%  perf-profile.children.cycles-pp.delay_tsc
      0.63 ±  7%      -0.3        0.31 ± 18%  perf-profile.children.cycles-pp.vt_console_print
      0.62 ±  9%      -0.3        0.31 ± 18%  perf-profile.children.cycles-pp.lf
      0.62 ±  9%      -0.3        0.31 ± 18%  perf-profile.children.cycles-pp.con_scroll
      0.62 ±  9%      -0.3        0.31 ± 18%  perf-profile.children.cycles-pp.fbcon_scroll
      0.61 ±  8%      -0.3        0.30 ± 17%  perf-profile.children.cycles-pp.fbcon_redraw
      0.59 ±  7%      -0.3        0.29 ± 18%  perf-profile.children.cycles-pp.fbcon_putcs
      0.59 ±  7%      -0.3        0.29 ± 18%  perf-profile.children.cycles-pp.bit_putcs
      0.50 ±  4%      -0.3        0.24 ± 22%  perf-profile.children.cycles-pp.drm_fb_helper_cfb_imageblit
      0.49 ±  3%      -0.2        0.24 ± 22%  perf-profile.children.cycles-pp.cfb_imageblit
      0.86 ±  7%      -0.2        0.66 ±  3%  perf-profile.children.cycles-pp.mmput
      0.84 ±  8%      -0.2        0.66 ±  3%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.84 ±  8%      -0.2        0.66 ±  3%  perf-profile.children.cycles-pp.do_group_exit
      0.84 ±  8%      -0.2        0.66 ±  3%  perf-profile.children.cycles-pp.do_exit
      0.85 ±  7%      -0.2        0.66 ±  3%  perf-profile.children.cycles-pp.exit_mmap
      0.62 ±  6%      -0.2        0.47 ±  3%  perf-profile.children.cycles-pp.unmap_vmas
      0.61 ±  7%      -0.1        0.47 ±  3%  perf-profile.children.cycles-pp.unmap_page_range
      0.52 ± 11%      -0.1        0.41 ±  7%  perf-profile.children.cycles-pp.tlb_flush_mmu
      0.84 ±  3%      -0.1        0.73 ±  6%  perf-profile.children.cycles-pp.read
      0.92 ±  7%      -0.1        0.82 ±  5%  perf-profile.children.cycles-pp.do_sys_open
      0.70 ±  5%      -0.1        0.61 ±  4%  perf-profile.children.cycles-pp.ksys_read
      0.90 ±  7%      -0.1        0.81 ±  5%  perf-profile.children.cycles-pp.do_sys_openat2
      0.69 ±  7%      -0.1        0.59 ±  5%  perf-profile.children.cycles-pp.vfs_read
      1.25            -0.1        1.16 ±  4%  perf-profile.children.cycles-pp.swapgs_restore_regs_and_return_to_usermode
      0.49 ±  9%      -0.1        0.41 ±  7%  perf-profile.children.cycles-pp.release_pages
      0.45            -0.1        0.37 ± 11%  perf-profile.children.cycles-pp.bitmap_clear_bit
      0.22 ±  9%      -0.1        0.14 ± 11%  perf-profile.children.cycles-pp.execve
      0.24 ±  5%      -0.1        0.17 ± 12%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.24 ±  5%      -0.1        0.17 ± 12%  perf-profile.children.cycles-pp.__do_execve_file
      0.20 ±  8%      -0.1        0.13 ± 24%  perf-profile.children.cycles-pp.statistics_fini_pass
      0.10 ± 16%      -0.1        0.04 ± 70%  perf-profile.children.cycles-pp.__libc_fork
      0.20 ±  8%      -0.1        0.14 ± 17%  perf-profile.children.cycles-pp.filemap_map_pages
      0.32 ±  7%      -0.1        0.26 ±  9%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.29 ±  9%      -0.1        0.24 ±  5%  perf-profile.children.cycles-pp.irq_exit
      0.27 ±  7%      -0.1        0.21 ± 17%  perf-profile.children.cycles-pp.bitmap_bit_p
      0.12 ±  6%      -0.1        0.07 ± 25%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.20 ±  8%      -0.0        0.16 ± 13%  perf-profile.children.cycles-pp.side_effects_p
      0.12 ± 25%      -0.0        0.08 ± 30%  perf-profile.children.cycles-pp.alloc_empty_file
      0.09 ± 13%      -0.0        0.05 ± 72%  perf-profile.children.cycles-pp.io_serial_out
      0.17 ± 10%      -0.0        0.13 ±  9%  perf-profile.children.cycles-pp.note_stores
      0.18 ± 10%      -0.0        0.13 ± 16%  perf-profile.children.cycles-pp.bitmap_copy
      0.14 ±  8%      -0.0        0.10 ± 24%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.24 ±  7%      -0.0        0.19 ± 14%  perf-profile.children.cycles-pp.rcu_core
      0.14 ± 14%      -0.0        0.10 ±  8%  perf-profile.children.cycles-pp.load_elf_binary
      0.09 ± 24%      -0.0        0.05 ± 78%  perf-profile.children.cycles-pp.copy_page
      0.25 ±  5%      -0.0        0.20 ±  6%  perf-profile.children.cycles-pp.init_alias_analysis
      0.12 ± 14%      -0.0        0.07 ± 28%  perf-profile.children.cycles-pp.find_unreachable_blocks
      0.16 ± 10%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.14 ± 14%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.search_binary_handler
      0.11 ± 25%      -0.0        0.07 ± 17%  perf-profile.children.cycles-pp.ret_from_fork
      0.11 ± 27%      -0.0        0.07 ± 35%  perf-profile.children.cycles-pp.__alloc_file
      0.09 ± 14%      -0.0        0.05 ± 72%  perf-profile.children.cycles-pp.lra_inheritance
      0.09 ±  5%      -0.0        0.05 ± 72%  perf-profile.children.cycles-pp.page_remove_rmap
      0.19 ± 11%      -0.0        0.15 ± 16%  perf-profile.children.cycles-pp.get_attribute_name
      0.12 ± 10%      -0.0        0.08 ± 32%  perf-profile.children.cycles-pp.for_each_inc_dec
      0.15 ±  8%      -0.0        0.11 ± 22%  perf-profile.children.cycles-pp.update_stmt_operands
      0.07 ±  6%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.wrapup_global_declaration_2
      0.18 ±  9%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.12 ± 14%      -0.0        0.08 ± 20%  perf-profile.children.cycles-pp.gimple_simplify
      0.10 ± 25%      -0.0        0.06 ± 19%  perf-profile.children.cycles-pp.kthread
      0.16 ± 10%      -0.0        0.13 ± 10%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.17 ±  9%      -0.0        0.14 ± 17%  perf-profile.children.cycles-pp.walk_stmt_load_store_addr_ops
      0.11 ±  7%      -0.0        0.08 ± 22%  perf-profile.children.cycles-pp.execute_update_addresses_taken
      0.09 ± 14%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.bitmap_and
      0.08 ±  5%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.alloc_set_pte
      0.10 ± 14%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.et_set_father
      0.12 ±  7%      -0.0        0.10 ± 14%  perf-profile.children.cycles-pp.hash_rtx_cb
      0.09 ± 15%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__do_munmap
      0.13 ±  6%      -0.0        0.11 ± 11%  perf-profile.children.cycles-pp.is_gimple_reg
      0.09 ± 10%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.find_get_entry
      0.10 ±  8%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.pagecache_get_page
      0.10 ±  4%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.substitute_and_fold_dom_walker::before_dom_children
      0.09 ±  5%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.realloc
      0.09 ± 10%      +0.0        0.11 ± 12%  perf-profile.children.cycles-pp.rtx_equal_p
      0.07 ±  6%      +0.0        0.10 ± 12%  perf-profile.children.cycles-pp.c_fully_fold
      0.05 ±  8%      +0.0        0.08 ± 12%  perf-profile.children.cycles-pp._cond_resched
      0.09 ±  5%      +0.0        0.12 ±  8%  perf-profile.children.cycles-pp.build_unary_op
      0.04 ± 71%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.cpp_interpret_integer
      0.13 ±  6%      +0.0        0.16 ±  5%  perf-profile.children.cycles-pp.declspecs_add_type
      0.10 ± 17%      +0.0        0.13 ±  6%  perf-profile.children.cycles-pp.task_work_run
      0.09 ±  9%      +0.0        0.12 ± 13%  perf-profile.children.cycles-pp.pushdecl
      0.08 ± 16%      +0.0        0.11 ± 12%  perf-profile.children.cycles-pp.force_fit_type
      0.04 ± 73%      +0.0        0.07 ± 12%  perf-profile.children.cycles-pp.__fput
      0.09 ± 13%      +0.0        0.13 ± 13%  perf-profile.children.cycles-pp.is_typedef_decl
      0.11 ± 14%      +0.0        0.15 ± 11%  perf-profile.children.cycles-pp.convert
      0.03 ± 70%      +0.0        0.07 ± 20%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.03 ± 70%      +0.0        0.07        perf-profile.children.cycles-pp.do_dentry_open
      0.04 ± 73%      +0.0        0.08 ± 16%  perf-profile.children.cycles-pp.page_add_new_anon_rmap
      0.04 ± 70%      +0.0        0.08 ± 10%  perf-profile.children.cycles-pp.start_function
      0.16 ± 11%      +0.0        0.21 ±  6%  perf-profile.children.cycles-pp.decl_attributes
      0.04 ± 71%      +0.0        0.08        perf-profile.children.cycles-pp.alloc_stmt_list
      0.02 ±141%      +0.0        0.06 ± 14%  perf-profile.children.cycles-pp.tree_int_cst_sgn
      0.02 ±141%      +0.0        0.06 ± 13%  perf-profile.children.cycles-pp.gimple_call_flags
      0.02 ±141%      +0.0        0.06 ± 13%  perf-profile.children.cycles-pp.build_asm_expr
      0.08 ± 11%      +0.0        0.13 ± 12%  perf-profile.children.cycles-pp.wi::divmod_internal
      0.49 ±  4%      +0.0        0.54 ±  2%  perf-profile.children.cycles-pp.pop_scope
      0.03 ± 70%      +0.1        0.09 ± 19%  perf-profile.children.cycles-pp.pop_stmt_list
      0.10 ±  4%      +0.1        0.16 ± 10%  perf-profile.children.cycles-pp.get_range_from_loc
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.build_component_ref
      0.16 ± 10%      +0.1        0.23 ±  6%  perf-profile.children.cycles-pp.build_null_declspecs
      0.00            +0.1        0.07 ± 35%  perf-profile.children.cycles-pp.vma_merge
      0.34 ± 13%      +0.1        0.41 ±  6%  perf-profile.children.cycles-pp.fold_binary_loc
      0.59 ±  3%      +0.1        0.69 ±  7%  perf-profile.children.cycles-pp.wide_int_to_tree
      0.17 ± 14%      +0.1        0.28 ± 12%  perf-profile.children.cycles-pp.linemap_add_macro_token
      0.72 ± 10%      +0.1        0.85 ± 11%  perf-profile.children.cycles-pp.c_lex_with_flags
      0.58 ±  5%      +0.2        0.74 ± 16%  perf-profile.children.cycles-pp.htab_find_slot_with_hash
      0.76 ±  4%      +0.2        0.96 ± 10%  perf-profile.children.cycles-pp.linemap_lookup
      0.58 ± 11%      +0.2        0.83 ± 22%  perf-profile.children.cycles-pp.irq_work_interrupt
      0.58 ± 11%      +0.2        0.83 ± 22%  perf-profile.children.cycles-pp.smp_irq_work_interrupt
      0.58 ± 11%      +0.2        0.83 ± 22%  perf-profile.children.cycles-pp.irq_work_run
      0.58 ± 11%      +0.2        0.83 ± 22%  perf-profile.children.cycles-pp.printk
      2.21 ±  5%      +0.3        2.47 ±  3%  perf-profile.children.cycles-pp._cpp_lex_direct
      1.16 ±  3%      +0.3        1.46 ± 12%  perf-profile.children.cycles-pp.memchr
      0.66 ± 26%      +0.3        0.97 ±  9%  perf-profile.children.cycles-pp.irq_work_run_list
      2.71 ± 15%      -0.8        1.94 ± 15%  perf-profile.self.cycles-pp.io_serial_in
      1.27 ± 15%      -0.3        0.94 ± 18%  perf-profile.self.cycles-pp.delay_tsc
      0.49 ±  3%      -0.2        0.24 ± 22%  perf-profile.self.cycles-pp.cfb_imageblit
      0.43 ±  3%      -0.1        0.35 ± 12%  perf-profile.self.cycles-pp.bitmap_clear_bit
      0.20 ±  8%      -0.1        0.13 ± 24%  perf-profile.self.cycles-pp.statistics_fini_pass
      0.22 ±  5%      -0.1        0.16 ±  8%  perf-profile.self.cycles-pp.unmap_page_range
      0.32 ±  7%      -0.1        0.26 ± 11%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.26 ±  8%      -0.1        0.21 ± 19%  perf-profile.self.cycles-pp.bitmap_bit_p
      0.09 ± 18%      -0.1        0.04 ± 73%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.18 ± 10%      -0.1        0.12 ± 19%  perf-profile.self.cycles-pp.bitmap_copy
      0.20 ±  8%      -0.1        0.15 ± 13%  perf-profile.self.cycles-pp.side_effects_p
      0.09 ± 13%      -0.0        0.05 ± 72%  perf-profile.self.cycles-pp.io_serial_out
      0.17 ±  5%      -0.0        0.12 ±  6%  perf-profile.self.cycles-pp.note_stores
      0.16 ± 10%      -0.0        0.12 ± 10%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.09 ± 24%      -0.0        0.05 ± 78%  perf-profile.self.cycles-pp.copy_page
      0.17 ±  9%      -0.0        0.13 ±  9%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.18 ± 12%      -0.0        0.14 ±  9%  perf-profile.self.cycles-pp.get_attribute_name
      0.09 ± 14%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.lra_inheritance
      0.24 ±  5%      -0.0        0.20 ±  8%  perf-profile.self.cycles-pp.init_alias_analysis
      0.11 ± 18%      -0.0        0.07 ± 28%  perf-profile.self.cycles-pp.find_unreachable_blocks
      0.12 ± 10%      -0.0        0.08 ± 32%  perf-profile.self.cycles-pp.for_each_inc_dec
      0.07 ±  6%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.wrapup_global_declaration_2
      0.13 ± 12%      -0.0        0.10 ± 14%  perf-profile.self.cycles-pp.free_pcppages_bulk
      0.09 ± 14%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.bitmap_and
      0.07 ±  7%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.page_remove_rmap
      0.10 ±  8%      -0.0        0.07 ± 23%  perf-profile.self.cycles-pp.update_stmt_operands
      0.12 ±  7%      -0.0        0.10 ± 14%  perf-profile.self.cycles-pp.hash_rtx_cb
      0.10 ±  9%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.et_set_father
      0.10 ±  4%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.substitute_and_fold_dom_walker::before_dom_children
      0.08            +0.0        0.09        perf-profile.self.cycles-pp.realloc
      0.07 ±  6%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.htab_traverse
      0.08 ±  5%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.build_unary_op
      0.08 ±  5%      +0.0        0.11 ± 11%  perf-profile.self.cycles-pp.rtx_equal_p
      0.07 ± 11%      +0.0        0.10 ±  9%  perf-profile.self.cycles-pp.force_fit_type
      0.07 ±  7%      +0.0        0.09 ± 10%  perf-profile.self.cycles-pp.c_fully_fold
      0.13 ±  6%      +0.0        0.16 ±  5%  perf-profile.self.cycles-pp.declspecs_add_type
      0.10 ± 12%      +0.0        0.13 ±  6%  perf-profile.self.cycles-pp.convert
      0.08 ± 10%      +0.0        0.11 ± 11%  perf-profile.self.cycles-pp.pushdecl
      0.04 ± 71%      +0.0        0.07 ± 11%  perf-profile.self.cycles-pp.start_function
      0.15 ± 11%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.decl_attributes
      0.03 ± 70%      +0.0        0.07 ± 11%  perf-profile.self.cycles-pp.malloc@plt
      0.09 ± 10%      +0.0        0.13 ± 13%  perf-profile.self.cycles-pp.is_typedef_decl
      0.04 ± 71%      +0.0        0.08        perf-profile.self.cycles-pp.alloc_stmt_list
      0.02 ±141%      +0.0        0.06 ± 13%  perf-profile.self.cycles-pp.mark_irreducible_loops
      0.08 ± 17%      +0.1        0.13 ± 12%  perf-profile.self.cycles-pp.wi::divmod_internal
      0.02 ±141%      +0.1        0.07 ± 25%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.49 ±  3%      +0.1        0.54 ±  2%  perf-profile.self.cycles-pp.pop_scope
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.build_component_ref
      0.00            +0.1        0.06 ± 16%  perf-profile.self.cycles-pp.gimple_call_flags
      0.09 ±  5%      +0.1        0.15 ± 12%  perf-profile.self.cycles-pp.get_range_from_loc
      0.02 ±141%      +0.1        0.08 ± 12%  perf-profile.self.cycles-pp.pop_stmt_list
      0.16 ± 10%      +0.1        0.23 ±  4%  perf-profile.self.cycles-pp.build_null_declspecs
      0.29 ±  9%      +0.1        0.35 ±  9%  perf-profile.self.cycles-pp.fold_binary_loc
      0.13 ±  6%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.linemap_add_macro_token
      0.57 ±  4%      +0.1        0.67 ±  8%  perf-profile.self.cycles-pp.wide_int_to_tree
      0.70 ±  3%      +0.2        0.89 ± 10%  perf-profile.self.cycles-pp.linemap_lookup
      2.14 ±  6%      +0.2        2.39 ±  3%  perf-profile.self.cycles-pp._cpp_lex_direct
      1.12 ±  2%      +0.3        1.40 ± 12%  perf-profile.self.cycles-pp.memchr





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Rong Chen


--+7aqSd/VAgMzTgew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.6.0-rc4-00106-g59901cb4520c4"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.6.0-rc4 Kernel Configuration
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
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
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
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
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
CONFIG_KVM_WERROR=y
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

CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
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
CONFIG_MPTCP=y
CONFIG_MPTCP_IPV6=y
# CONFIG_MPTCP_HMAC_TEST is not set
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
CONFIG_VSOCKETS_LOOPBACK=m
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
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
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
CONFIG_DRM_EXPORT_FOR_TESTS=y
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
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
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
CONFIG_USB_WUSB=m
CONFIG_USB_WUSB_CBAF=m
# CONFIG_USB_WUSB_CBAF_DEBUG is not set
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=m
CONFIG_UWB=m
CONFIG_UWB_HWA=m
CONFIG_UWB_WHCI=m
CONFIG_UWB_I1480U=m
# CONFIG_STAGING_EXFAT_FS is not set
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
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set

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
# CONFIG_DLHL60D is not set
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
# CONFIG_TEE is not set
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
# CONFIG_UNWINDER_GUESS is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
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
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--+7aqSd/VAgMzTgew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='netperf'
	export testcase='netperf'
	export category='benchmark'
	export disable_latency_stats=1
	export set_nic_irq_affinity=1
	export ip='ipv4'
	export runtime=300
	export nr_threads=18
	export cluster='cs-localhost'
	export job_origin='/lkp/lkp/.src-20200324-153215/allot/cyclic:p1:linux-devel:devel-hourly/lkp-skl-2sp7/netperf-small-threads.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-skl-2sp7'
	export tbox_group='lkp-skl-2sp7'
	export submit_id='5e7e938627aa2c53de3a7ee3'
	export job_file='/lkp/jobs/scheduled/lkp-skl-2sp7/netperf-cs-localhost-performance-ipv4-25%-300s-5K-TCP_SENDFILE-ucode=0x2000065-debian-x86_64-20191114.cgz-59901cb4520c44bfce81f5-20200328-21470-1tz55a1-3.yaml'
	export id='a87fdb1d54d9ffd97859a65659ba1eece6bc46f4'
	export queuer_version='/lkp-src'
	export model='Skylake-SP'
	export nr_node=2
	export nr_cpu=72
	export memory='128G'
	export nr_ssd_partitions=4
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BG012T4_BTHC428202321P2OGN-part*'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_CVWL34260041800RGN-part1'
	export kernel_cmdline_hw='acpi_rsdp=0x6c030014'
	export brand='Intel(R) Xeon(R) Gold 6139 CPU @ 2.30GHz'
	export commit='59901cb4520c44bfce81f523bc61e7284a931ad1'
	export ucode='0x2000065'
	export need_kconfig_hw='CONFIG_I40E=y
CONFIG_SATA_AHCI'
	export kconfig='x86_64-rhel-7.6'
	export compiler='gcc-7'
	export enqueue_time='2020-03-28 08:00:10 +0800'
	export _id='5e7e938a27aa2c53de3a7ee4'
	export _rt='/result/netperf/cs-localhost-performance-ipv4-25%-300s-5K-TCP_SENDFILE-ucode=0x2000065/lkp-skl-2sp7/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/59901cb4520c44bfce81f523bc61e7284a931ad1'
	export user='lkp'
	export head_commit='15cb34f8ce86972da30317198ccef0c4bd3dbb80'
	export base_commit='16fbf79b0f83bc752cee8589279f1ebfe57b3b6e'
	export branch='linux-devel/devel-hourly-2020032714'
	export rootfs='debian-x86_64-20191114.cgz'
	export result_root='/result/netperf/cs-localhost-performance-ipv4-25%-300s-5K-TCP_SENDFILE-ucode=0x2000065/lkp-skl-2sp7/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/59901cb4520c44bfce81f523bc61e7284a931ad1/3'
	export scheduler_version='/lkp/lkp/.src-20200327-172825'
	export LKP_SERVER='inn'
	export arch='x86_64'
	export max_uptime=1500
	export initrd='/osimage/debian/debian-x86_64-20191114.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-skl-2sp7/netperf-cs-localhost-performance-ipv4-25%-300s-5K-TCP_SENDFILE-ucode=0x2000065-debian-x86_64-20191114.cgz-59901cb4520c44bfce81f5-20200328-21470-1tz55a1-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.6
branch=linux-devel/devel-hourly-2020032714
commit=59901cb4520c44bfce81f523bc61e7284a931ad1
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/59901cb4520c44bfce81f523bc61e7284a931ad1/vmlinuz-5.6.0-rc4-00106-g59901cb4520c4
acpi_rsdp=0x6c030014
max_uptime=1500
RESULT_ROOT=/result/netperf/cs-localhost-performance-ipv4-25%-300s-5K-TCP_SENDFILE-ucode=0x2000065/lkp-skl-2sp7/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/59901cb4520c44bfce81f523bc61e7284a931ad1/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-7.6/gcc-7/59901cb4520c44bfce81f523bc61e7284a931ad1/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-20180403.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/lkp_2019-08-05.cgz,/osimage/deps/debian-x86_64-20180403.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/netperf_2020-01-03.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/netperf-x86_64-2.7-0_2020-01-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/mpstat_2020-01-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/vmstat_2020-01-07.cgz,/osimage/deps/debian-x86_64-20180403.cgz/perf_20200325.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/perf-x86_64-76ccd234269b-1_20200325.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/sar-x86_64-e011d97-1_2020-01-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/hw_2020-01-02.cgz,/osimage/deps/debian-x86_64-20180403.cgz/cluster_2016-11-24.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='4.20.0'
	export repeat_to=4
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-7.6/gcc-7/59901cb4520c44bfce81f523bc61e7284a931ad1/vmlinuz-5.6.0-rc4-00106-g59901cb4520c4'
	export dequeue_time='2020-03-28 08:10:23 +0800'
	export node_roles='server client'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-2sp7/netperf-cs-localhost-performance-ipv4-25%-300s-5K-TCP_SENDFILE-ucode=0x2000065-debian-x86_64-20191114.cgz-59901cb4520c44bfce81f5-20200328-21470-1tz55a1-3.cgz'

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

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

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
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	if role server
	then
		start_daemon $LKP_SRC/daemon/netserver
	fi

	if role client
	then
		run_test send_size='5K' test='TCP_SENDFILE' $LKP_SRC/tests/wrapper netperf
	fi
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper netperf
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
	$LKP_SRC/stats/wrapper perf-profile

	$LKP_SRC/stats/wrapper time netperf.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--+7aqSd/VAgMzTgew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/netperf-small-threads.yaml
suite: netperf
testcase: netperf
category: benchmark

# upto 90% CPU cycles may be used by latency stats
disable_latency_stats: 1
set_nic_irq_affinity: 1
ip: ipv4
runtime: 300s
nr_threads: 25%
cluster: cs-localhost
if role server:
  netserver: 
if role client:
  netperf:
    send_size: 5K
    test: TCP_SENDFILE
job_origin: "/lkp/lkp/.src-20200324-153215/allot/cyclic:p1:linux-devel:devel-hourly/lkp-skl-2sp7/netperf-small-threads.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-skl-2sp7
tbox_group: lkp-skl-2sp7
submit_id: 5e7e727327aa2c4f3ca1eabf
job_file: "/lkp/jobs/scheduled/lkp-skl-2sp7/netperf-cs-localhost-performance-ipv4-25%-300s-5K-TCP_SENDFILE-ucode=0x2000065-debian-x86_64-20191114.cgz-59901cb4520c44bfce81f5-20200328-20284-c7s257-0.yaml"
id: 685338d4240077038f2d78acaf906eddc9e7bd9d
queuer_version: "/lkp-src"

#! hosts/lkp-skl-2sp7
model: Skylake-SP
nr_node: 2
nr_cpu: 72
memory: 128G
nr_ssd_partitions: 4
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BG012T4_BTHC428202321P2OGN-part*"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_CVWL34260041800RGN-part1"
kernel_cmdline_hw: acpi_rsdp=0x6c030014
brand: Intel(R) Xeon(R) Gold 6139 CPU @ 2.30GHz

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
perf-profile: 

#! include/category/ALL
cpufreq_governor: performance

#! include/queue/cyclic
commit: 59901cb4520c44bfce81f523bc61e7284a931ad1

#! include/testbox/lkp-skl-2sp7
ucode: '0x2000065'
need_kconfig_hw:
- CONFIG_I40E=y
- CONFIG_SATA_AHCI

#! default params
kconfig: x86_64-rhel-7.6
compiler: gcc-7
enqueue_time: 2020-03-28 05:39:02.881736044 +08:00
_id: 5e7e727327aa2c4f3ca1eabf
_rt: "/result/netperf/cs-localhost-performance-ipv4-25%-300s-5K-TCP_SENDFILE-ucode=0x2000065/lkp-skl-2sp7/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/59901cb4520c44bfce81f523bc61e7284a931ad1"

#! schedule options
user: lkp
head_commit: 15cb34f8ce86972da30317198ccef0c4bd3dbb80
base_commit: 16fbf79b0f83bc752cee8589279f1ebfe57b3b6e
branch: linux-devel/devel-hourly-2020032714
rootfs: debian-x86_64-20191114.cgz
result_root: "/result/netperf/cs-localhost-performance-ipv4-25%-300s-5K-TCP_SENDFILE-ucode=0x2000065/lkp-skl-2sp7/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/59901cb4520c44bfce81f523bc61e7284a931ad1/0"
scheduler_version: "/lkp/lkp/.src-20200327-172825"
LKP_SERVER: inn
arch: x86_64
max_uptime: 1500
initrd: "/osimage/debian/debian-x86_64-20191114.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-skl-2sp7/netperf-cs-localhost-performance-ipv4-25%-300s-5K-TCP_SENDFILE-ucode=0x2000065-debian-x86_64-20191114.cgz-59901cb4520c44bfce81f5-20200328-20284-c7s257-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-7.6
- branch=linux-devel/devel-hourly-2020032714
- commit=59901cb4520c44bfce81f523bc61e7284a931ad1
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/59901cb4520c44bfce81f523bc61e7284a931ad1/vmlinuz-5.6.0-rc4-00106-g59901cb4520c4
- acpi_rsdp=0x6c030014
- max_uptime=1500
- RESULT_ROOT=/result/netperf/cs-localhost-performance-ipv4-25%-300s-5K-TCP_SENDFILE-ucode=0x2000065/lkp-skl-2sp7/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/59901cb4520c44bfce81f523bc61e7284a931ad1/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-7.6/gcc-7/59901cb4520c44bfce81f523bc61e7284a931ad1/modules.cgz"
bm_initrd: "/osimage/deps/debian-x86_64-20180403.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/lkp_2019-08-05.cgz,/osimage/deps/debian-x86_64-20180403.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/netperf_2020-01-03.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/netperf-x86_64-2.7-0_2020-01-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/mpstat_2020-01-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/vmstat_2020-01-07.cgz,/osimage/deps/debian-x86_64-20180403.cgz/perf_20200325.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/perf-x86_64-76ccd234269b-1_20200325.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/sar-x86_64-e011d97-1_2020-01-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/hw_2020-01-02.cgz,/osimage/deps/debian-x86_64-20180403.cgz/cluster_2016-11-24.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20200327-172825/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.6.0-rc7-06906-gf9233d1bb6e96
repeat_to: 2
schedule_notify_address: 

#! user overrides
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-7.6/gcc-7/59901cb4520c44bfce81f523bc61e7284a931ad1/vmlinuz-5.6.0-rc4-00106-g59901cb4520c4"
dequeue_time: 2020-03-28 05:40:31.899485043 +08:00
job_state: finished
loadavg: 25.95 18.68 8.31 1/585 9517
start_time: '1585345277'
end_time: '1585345578'
version: "/lkp/lkp/.src-20200327-172855:1a2d9638:5a9d8b33b"

--+7aqSd/VAgMzTgew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

netserver -4 -D
netperf -4 -H 127.0.0.1 -t TCP_SENDFILE -c -C -l 300 -- -m 5K  &
netperf -4 -H 127.0.0.1 -t TCP_SENDFILE -c -C -l 300 -- -m 5K  &
netperf -4 -H 127.0.0.1 -t TCP_SENDFILE -c -C -l 300 -- -m 5K  &
netperf -4 -H 127.0.0.1 -t TCP_SENDFILE -c -C -l 300 -- -m 5K  &
netperf -4 -H 127.0.0.1 -t TCP_SENDFILE -c -C -l 300 -- -m 5K  &
netperf -4 -H 127.0.0.1 -t TCP_SENDFILE -c -C -l 300 -- -m 5K  &
netperf -4 -H 127.0.0.1 -t TCP_SENDFILE -c -C -l 300 -- -m 5K  &
netperf -4 -H 127.0.0.1 -t TCP_SENDFILE -c -C -l 300 -- -m 5K  &
netperf -4 -H 127.0.0.1 -t TCP_SENDFILE -c -C -l 300 -- -m 5K  &
netperf -4 -H 127.0.0.1 -t TCP_SENDFILE -c -C -l 300 -- -m 5K  &
netperf -4 -H 127.0.0.1 -t TCP_SENDFILE -c -C -l 300 -- -m 5K  &
netperf -4 -H 127.0.0.1 -t TCP_SENDFILE -c -C -l 300 -- -m 5K  &
netperf -4 -H 127.0.0.1 -t TCP_SENDFILE -c -C -l 300 -- -m 5K  &
netperf -4 -H 127.0.0.1 -t TCP_SENDFILE -c -C -l 300 -- -m 5K  &
netperf -4 -H 127.0.0.1 -t TCP_SENDFILE -c -C -l 300 -- -m 5K  &
netperf -4 -H 127.0.0.1 -t TCP_SENDFILE -c -C -l 300 -- -m 5K  &
netperf -4 -H 127.0.0.1 -t TCP_SENDFILE -c -C -l 300 -- -m 5K  &
netperf -4 -H 127.0.0.1 -t TCP_SENDFILE -c -C -l 300 -- -m 5K  &
wait

--+7aqSd/VAgMzTgew--
