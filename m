Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB31BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FF46206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgENO2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:28:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:49590 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbgENO2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:28:14 -0400
IronPort-SDR: R+f4i0HzNTCJQ7juUf61gUyNK+iIAKvOiRmU3CDhPy+Gu9MK+fTF47Taq6/7Ov19QZiezE5h2b
 6UY2yMI7WjlQ==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 07:05:33 -0700
IronPort-SDR: 8fb732DF5DYwOFQoMXEC5fohHmnexM3sh4fRRhfwXtGEjVxmQfCk5NMIkcCv2gIQi0UbtFv4KO
 RA2dS4PU0MVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,391,1583222400"; 
   d="yaml'?scan'208";a="464343087"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga005.fm.intel.com with ESMTP; 14 May 2020 07:05:27 -0700
Date:   Thu, 14 May 2020 22:15:26 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        OTC LSE PnP <otc.lse.pnp@intel.com>
Subject: [sched/fair]  0b0695f2b3:
 phoronix-test-suite.compress-gzip.0.seconds 19.8% regression
Message-ID: <20200514141526.GA30976@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Vincent Guittot,

Below report FYI.
Last year, we actually reported an improvement "[sched/fair] 0b0695f2b3:
vm-scalability.median 3.1% improvement" on link [1].
but now we found the regression on pts.compress-gzip.
This seems align with what showed in "[v4,00/10] sched/fair: rework the CFS
load balance" (link [2]), where showed the reworked load balance could have
both positive and negative effect for different test suites.
And also from link [3], the patch set risks regressions.

We also confirmed this regression on another platform
(Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz with 8G memory),
below is the data (lower is better).
v5.4    4.1
fcf0553db6f4c79387864f6e4ab4a891601f395e    4.01
0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912    4.89
v5.5    5.18
v5.6    4.62
v5.7-rc2    4.53
v5.7-rc3    4.59

It seems there are some recovery on latest kernels, but not fully back.
We were just wondering whether you could share some lights the further works
on the load balance after patch set [2] which could cause the performance
change?
And whether you have plan to refine the load balance algorithm further?
thanks

[1] https://lists.01.org/hyperkitty/list/lkp@lists.01.org/thread/SANC7QLYZKUNMM6O7UNR3OAQAKS5BESE/
[2] https://lore.kernel.org/patchwork/cover/1141687/
[3] https://www.phoronix.com/scan.php?page=news_item&px=Linux-5.5-Scheduler



Below is the detail regression report FYI.

Greeting,

FYI, we noticed a 19.8% regression of phoronix-test-suite.compress-gzip.0.seconds due to commit:


commit: 0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912 ("sched/fair: Rework load_balance()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: phoronix-test-suite
on test machine: 16 threads Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz with 32G memory
with following parameters:

	test: compress-gzip-1.2.0
	cpufreq_governor: performance
	ucode: 0xca

test-description: The Phoronix Test Suite is the most comprehensive testing and benchmarking platform available that provides an extensible framework for which new tests can be easily added.
test-url: http://www.phoronix-test-suite.com/

In addition to that, the commit also has significant impact on the following tests:

+------------------+-----------------------------------------------------------------------+
| testcase: change | phoronix-test-suite:                                                  |
| test machine     | 12 threads Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz with 8G memory     |
| test parameters  | cpufreq_governor=performance                                          |
|                  | test=compress-gzip-1.2.0                                              |
+------------------+-----------------------------------------------------------------------+
| testcase: change | vm-scalability: vm-scalability.median 3.1% improvement                |
| test machine     | 104 threads Skylake with 192G memory                                  |
| test parameters  | cpufreq_governor=performance                                          |
|                  | runtime=300s                                                          |
|                  | size=8T                                                               |
|                  | test=anon-cow-seq                                                     |
|                  | ucode=0x2000064                                                       |
+------------------+-----------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.fault.ops_per_sec -23.1% regression              |
| test machine     | 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory |
| test parameters  | class=scheduler                                                       |
|                  | cpufreq_governor=performance                                          |
|                  | disk=1HDD                                                             |
|                  | nr_threads=100%                                                       |
|                  | sc_pid_max=4194304                                                    |
|                  | testtime=1s                                                           |
|                  | ucode=0xb000038                                                       |
+------------------+-----------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.schedpolicy.ops_per_sec -33.3% regression        |
| test machine     | 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory  |
| test parameters  | class=interrupt                                                       |
|                  | cpufreq_governor=performance                                          |
|                  | disk=1HDD                                                             |
|                  | nr_threads=100%                                                       |
|                  | testtime=1s                                                           |
|                  | ucode=0x500002c                                                       |
+------------------+-----------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.schedpolicy.ops_per_sec 42.3% improvement        |
| test machine     | 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory |
| test parameters  | class=interrupt                                                       |
|                  | cpufreq_governor=performance                                          |
|                  | disk=1HDD                                                             |
|                  | nr_threads=100%                                                       |
|                  | testtime=30s                                                          |
|                  | ucode=0xb000038                                                       |
+------------------+-----------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.schedpolicy.ops_per_sec 35.1% improvement        |
| test machine     | 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory |
| test parameters  | class=interrupt                                                       |
|                  | cpufreq_governor=performance                                          |
|                  | disk=1HDD                                                             |
|                  | nr_threads=100%                                                       |
|                  | testtime=1s                                                           |
|                  | ucode=0xb000038                                                       |
+------------------+-----------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.ioprio.ops_per_sec -20.7% regression             |
| test machine     | 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory  |
| test parameters  | class=os                                                              |
|                  | cpufreq_governor=performance                                          |
|                  | disk=1HDD                                                             |
|                  | fs=ext4                                                               |
|                  | nr_threads=100%                                                       |
|                  | testtime=1s                                                           |
|                  | ucode=0x500002b                                                       |
+------------------+-----------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.schedpolicy.ops_per_sec 43.0% improvement        |
| test machine     | 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory |
| test parameters  | class=interrupt                                                       |
|                  | cpufreq_governor=performance                                          |
|                  | disk=1HDD                                                             |
|                  | nr_threads=100%                                                       |
|                  | testtime=30s                                                          |
|                  | ucode=0xb000038                                                       |
+------------------+-----------------------------------------------------------------------+


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/ucode:
  gcc-7/performance/x86_64-lck-7983/clear-x86_64-phoronix-30140/lkp-cfl-e1/compress-gzip-1.2.0/phoronix-test-suite/0xca

commit: 
  fcf0553db6 ("sched/fair: Remove meaningless imbalance calculation")
  0b0695f2b3 ("sched/fair: Rework load_balance()")

fcf0553db6f4c793 0b0695f2b34a4afa3f6e9aa1ff0 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :4            4%           0:7     perf-profile.children.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
      6.01           +19.8%       7.20        phoronix-test-suite.compress-gzip.0.seconds
    147.57 ±  8%     +25.1%     184.54        phoronix-test-suite.time.elapsed_time
    147.57 ±  8%     +25.1%     184.54        phoronix-test-suite.time.elapsed_time.max
     52926 ±  8%     -23.8%      40312        meminfo.max_used_kB
      0.11 ±  7%      -0.0        0.09 ±  3%  mpstat.cpu.all.soft%
    242384            -1.4%     238931        proc-vmstat.nr_inactive_anon
    242384            -1.4%     238931        proc-vmstat.nr_zone_inactive_anon
 1.052e+08 ± 27%     +56.5%  1.647e+08 ± 10%  cpuidle.C1E.time
   1041078 ± 22%     +54.7%    1610786 ±  7%  cpuidle.C1E.usage
 3.414e+08 ±  6%     +57.6%  5.381e+08 ± 28%  cpuidle.C6.time
    817897 ±  3%     +50.1%    1227607 ± 11%  cpuidle.C6.usage
      2884            -4.2%       2762        turbostat.Avg_MHz
   1041024 ± 22%     +54.7%    1610657 ±  7%  turbostat.C1E
    817802 ±  3%     +50.1%    1227380 ± 11%  turbostat.C6
     66.75            -2.0%      65.42        turbostat.CorWatt
     67.28            -2.0%      65.94        turbostat.PkgWatt
     32.50            +6.2%      34.50        vmstat.cpu.id
     62.50            -2.4%      61.00        vmstat.cpu.us
      2443 ±  2%     -28.9%       1738 ±  2%  vmstat.io.bi
     23765 ±  4%     +16.5%      27685        vmstat.system.cs
     37860            -7.1%      35180 ±  2%  vmstat.system.in
 3.474e+09 ±  3%     -12.7%  3.032e+09        perf-stat.i.branch-instructions
 1.344e+08 ±  2%     -11.6%  1.188e+08        perf-stat.i.branch-misses
  13033225 ±  4%     -19.0%   10561032        perf-stat.i.cache-misses
 5.105e+08 ±  3%     -15.3%  4.322e+08        perf-stat.i.cache-references
     24205 ±  4%     +16.3%      28161        perf-stat.i.context-switches
     30.25 ±  2%     +39.7%      42.27 ±  2%  perf-stat.i.cpi
  4.63e+10            -4.7%  4.412e+10        perf-stat.i.cpu-cycles
      3147 ±  4%      -8.4%       2882 ±  2%  perf-stat.i.cpu-migrations
     16724 ±  2%     +45.9%      24406 ±  5%  perf-stat.i.cycles-between-cache-misses
      0.18 ± 13%      -0.1        0.12 ±  4%  perf-stat.i.dTLB-load-miss-rate%
 4.822e+09 ±  3%     -11.9%  4.248e+09        perf-stat.i.dTLB-loads
      0.07 ±  8%      -0.0        0.05 ± 16%  perf-stat.i.dTLB-store-miss-rate%
 1.623e+09 ±  2%     -11.5%  1.436e+09        perf-stat.i.dTLB-stores
   1007120 ±  3%      -8.9%     917854 ±  2%  perf-stat.i.iTLB-load-misses
 1.816e+10 ±  3%     -12.2%  1.594e+10        perf-stat.i.instructions
      2.06 ± 54%     -66.0%       0.70        perf-stat.i.major-faults
     29896 ± 13%     -35.2%      19362 ±  8%  perf-stat.i.minor-faults
      0.00 ±  9%      -0.0        0.00 ±  6%  perf-stat.i.node-load-miss-rate%
   1295134 ±  3%     -14.2%    1111173        perf-stat.i.node-loads
   3064949 ±  4%     -18.7%    2491063 ±  2%  perf-stat.i.node-stores
     29898 ± 13%     -35.2%      19363 ±  8%  perf-stat.i.page-faults
     28.10            -3.5%      27.12        perf-stat.overall.MPKI
      2.55            -0.1        2.44 ±  2%  perf-stat.overall.cache-miss-rate%
      2.56 ±  3%      +8.5%       2.77        perf-stat.overall.cpi
      3567 ±  5%     +17.3%       4186        perf-stat.overall.cycles-between-cache-misses
      0.02 ±  3%      +0.0        0.02 ±  3%  perf-stat.overall.dTLB-load-miss-rate%
     18031            -3.6%      17375 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
      0.39 ±  3%      -7.9%       0.36        perf-stat.overall.ipc
 3.446e+09 ±  3%     -12.6%  3.011e+09        perf-stat.ps.branch-instructions
 1.333e+08 ±  2%     -11.5%   1.18e+08        perf-stat.ps.branch-misses
  12927998 ±  4%     -18.8%   10491818        perf-stat.ps.cache-misses
 5.064e+08 ±  3%     -15.2%  4.293e+08        perf-stat.ps.cache-references
     24011 ±  4%     +16.5%      27973        perf-stat.ps.context-switches
 4.601e+10            -4.6%  4.391e+10        perf-stat.ps.cpu-cycles
      3121 ±  4%      -8.3%       2863 ±  2%  perf-stat.ps.cpu-migrations
 4.783e+09 ±  3%     -11.8%  4.219e+09        perf-stat.ps.dTLB-loads
  1.61e+09 ±  2%     -11.4%  1.426e+09        perf-stat.ps.dTLB-stores
    999100 ±  3%      -8.7%     911974 ±  2%  perf-stat.ps.iTLB-load-misses
 1.802e+10 ±  3%     -12.1%  1.584e+10        perf-stat.ps.instructions
      2.04 ± 54%     -65.9%       0.70        perf-stat.ps.major-faults
     29656 ± 13%     -35.1%      19237 ±  8%  perf-stat.ps.minor-faults
   1284601 ±  3%     -14.1%    1103823        perf-stat.ps.node-loads
   3039931 ±  4%     -18.6%    2474451 ±  2%  perf-stat.ps.node-stores
     29658 ± 13%     -35.1%      19238 ±  8%  perf-stat.ps.page-faults
     50384 ±  2%     +16.5%      58713 ±  4%  softirqs.CPU0.RCU
     33143 ±  2%     +19.9%      39731 ±  2%  softirqs.CPU0.SCHED
     72672           +24.0%      90109        softirqs.CPU0.TIMER
     22182 ±  4%     +26.3%      28008 ±  4%  softirqs.CPU1.SCHED
     74465 ±  4%     +26.3%      94027 ±  3%  softirqs.CPU1.TIMER
     18680 ±  7%     +29.2%      24135 ±  3%  softirqs.CPU10.SCHED
     75941 ±  2%     +21.8%      92486 ±  7%  softirqs.CPU10.TIMER
     48991 ±  4%     +22.7%      60105 ±  5%  softirqs.CPU11.RCU
     18666 ±  6%     +28.4%      23976 ±  4%  softirqs.CPU11.SCHED
     74896 ±  6%     +24.4%      93173 ±  3%  softirqs.CPU11.TIMER
     49490           +20.5%      59659 ±  2%  softirqs.CPU12.RCU
     18973 ±  7%     +26.0%      23909 ±  3%  softirqs.CPU12.SCHED
     50620           +19.9%      60677 ±  6%  softirqs.CPU13.RCU
     19136 ±  6%     +23.2%      23577 ±  4%  softirqs.CPU13.SCHED
     74812           +33.3%      99756 ±  7%  softirqs.CPU13.TIMER
     50824           +15.9%      58881 ±  3%  softirqs.CPU14.RCU
     19550 ±  5%     +24.1%      24270 ±  4%  softirqs.CPU14.SCHED
     76801           +22.8%      94309 ±  4%  softirqs.CPU14.TIMER
     51844           +11.5%      57795 ±  3%  softirqs.CPU15.RCU
     19204 ±  8%     +28.4%      24662 ±  2%  softirqs.CPU15.SCHED
     74751           +29.9%      97127 ±  3%  softirqs.CPU15.TIMER
     50307           +17.4%      59062 ±  4%  softirqs.CPU2.RCU
     22150           +12.2%      24848        softirqs.CPU2.SCHED
     79653 ±  2%     +21.6%      96829 ± 10%  softirqs.CPU2.TIMER
     50833           +21.1%      61534 ±  4%  softirqs.CPU3.RCU
     18935 ±  2%     +32.0%      25002 ±  3%  softirqs.CPU3.SCHED
     50569           +15.8%      58570 ±  4%  softirqs.CPU4.RCU
     20509 ±  5%     +18.3%      24271        softirqs.CPU4.SCHED
     80942 ±  2%     +15.3%      93304 ±  3%  softirqs.CPU4.TIMER
     50692           +16.5%      59067 ±  4%  softirqs.CPU5.RCU
     20237 ±  3%     +18.2%      23914 ±  3%  softirqs.CPU5.SCHED
     78963           +21.8%      96151 ±  2%  softirqs.CPU5.TIMER
     19709 ±  7%     +20.1%      23663        softirqs.CPU6.SCHED
     81250           +15.9%      94185        softirqs.CPU6.TIMER
     51379           +15.0%      59108        softirqs.CPU7.RCU
     19642 ±  5%     +28.4%      25227 ±  3%  softirqs.CPU7.SCHED
     78299 ±  2%     +30.3%     102021 ±  4%  softirqs.CPU7.TIMER
     49723           +19.0%      59169 ±  4%  softirqs.CPU8.RCU
     20138 ±  6%     +21.7%      24501 ±  2%  softirqs.CPU8.SCHED
     75256 ±  3%     +22.8%      92419 ±  2%  softirqs.CPU8.TIMER
     50406 ±  2%     +17.4%      59178 ±  4%  softirqs.CPU9.RCU
     19182 ±  9%     +24.2%      23831 ±  6%  softirqs.CPU9.SCHED
     73572 ±  5%     +30.4%      95951 ±  8%  softirqs.CPU9.TIMER
    812363           +16.6%     946858 ±  3%  softirqs.RCU
    330042 ±  4%     +23.5%     407533        softirqs.SCHED
   1240046           +22.5%    1519539        softirqs.TIMER
    251015 ± 21%     -84.2%      39587 ±106%  sched_debug.cfs_rq:/.MIN_vruntime.avg
    537847 ±  4%     -44.8%     297100 ± 66%  sched_debug.cfs_rq:/.MIN_vruntime.max
    257990 ±  5%     -63.4%      94515 ± 82%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
     38935           +47.9%      57601        sched_debug.cfs_rq:/.exec_clock.avg
     44119           +40.6%      62013        sched_debug.cfs_rq:/.exec_clock.max
     37622           +49.9%      56404        sched_debug.cfs_rq:/.exec_clock.min
     47287 ±  7%     -70.3%      14036 ± 88%  sched_debug.cfs_rq:/.load.min
     67.17           -52.9%      31.62 ± 31%  sched_debug.cfs_rq:/.load_avg.min
    251015 ± 21%     -84.2%      39588 ±106%  sched_debug.cfs_rq:/.max_vruntime.avg
    537847 ±  4%     -44.8%     297103 ± 66%  sched_debug.cfs_rq:/.max_vruntime.max
    257991 ±  5%     -63.4%      94516 ± 82%  sched_debug.cfs_rq:/.max_vruntime.stddev
    529078 ±  3%     +45.2%     768398        sched_debug.cfs_rq:/.min_vruntime.avg
    547175 ±  2%     +44.1%     788582        sched_debug.cfs_rq:/.min_vruntime.max
    496420           +48.3%     736148 ±  2%  sched_debug.cfs_rq:/.min_vruntime.min
      1.33 ± 15%     -44.0%       0.75 ± 32%  sched_debug.cfs_rq:/.nr_running.avg
      0.83 ± 20%     -70.0%       0.25 ± 70%  sched_debug.cfs_rq:/.nr_running.min
      0.54 ±  8%     -15.9%       0.45 ±  7%  sched_debug.cfs_rq:/.nr_running.stddev
      0.33           +62.9%       0.54 ±  8%  sched_debug.cfs_rq:/.nr_spread_over.avg
      1.33           +54.7%       2.06 ± 17%  sched_debug.cfs_rq:/.nr_spread_over.max
      0.44 ±  7%     +56.4%       0.69 ±  6%  sched_debug.cfs_rq:/.nr_spread_over.stddev
    130.83 ± 14%     -25.6%      97.37 ± 15%  sched_debug.cfs_rq:/.runnable_load_avg.avg
     45.33 ±  6%     -79.3%       9.38 ± 70%  sched_debug.cfs_rq:/.runnable_load_avg.min
     47283 ±  7%     -70.9%      13741 ± 89%  sched_debug.cfs_rq:/.runnable_weight.min
      1098 ±  8%     -27.6%     795.02 ± 24%  sched_debug.cfs_rq:/.util_avg.avg
    757.50 ±  9%     -51.3%     369.25 ± 10%  sched_debug.cfs_rq:/.util_avg.min
    762.39 ± 11%     -44.4%     424.04 ± 46%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    314.00 ± 18%     -78.5%      67.38 ±100%  sched_debug.cfs_rq:/.util_est_enqueued.min
    142951 ±  5%     +22.8%     175502 ±  3%  sched_debug.cpu.avg_idle.avg
     72112           -18.3%      58937 ± 13%  sched_debug.cpu.avg_idle.stddev
    127638 ±  7%     +39.3%     177858 ±  5%  sched_debug.cpu.clock.avg
    127643 ±  7%     +39.3%     177862 ±  5%  sched_debug.cpu.clock.max
    127633 ±  7%     +39.3%     177855 ±  5%  sched_debug.cpu.clock.min
    126720 ±  7%     +39.4%     176681 ±  5%  sched_debug.cpu.clock_task.avg
    127168 ±  7%     +39.3%     177179 ±  5%  sched_debug.cpu.clock_task.max
    125240 ±  7%     +39.5%     174767 ±  5%  sched_debug.cpu.clock_task.min
    563.60 ±  2%     +25.9%     709.78 ±  9%  sched_debug.cpu.clock_task.stddev
      1.66 ± 18%     -37.5%       1.04 ± 32%  sched_debug.cpu.nr_running.avg
      0.83 ± 20%     -62.5%       0.31 ± 87%  sched_debug.cpu.nr_running.min
    127617 ±  3%     +52.9%     195080        sched_debug.cpu.nr_switches.avg
    149901 ±  6%     +45.2%     217652        sched_debug.cpu.nr_switches.max
    108182 ±  5%     +61.6%     174808        sched_debug.cpu.nr_switches.min
      0.20 ±  5%     -62.5%       0.07 ± 67%  sched_debug.cpu.nr_uninterruptible.avg
    -29.33           -13.5%     -25.38        sched_debug.cpu.nr_uninterruptible.min
     92666 ±  8%     +66.8%     154559        sched_debug.cpu.sched_count.avg
    104565 ± 11%     +57.2%     164374        sched_debug.cpu.sched_count.max
     80272 ± 10%     +77.2%     142238        sched_debug.cpu.sched_count.min
     38029 ± 10%     +80.4%      68608        sched_debug.cpu.sched_goidle.avg
     43413 ± 11%     +68.5%      73149        sched_debug.cpu.sched_goidle.max
     32420 ± 11%     +94.5%      63069        sched_debug.cpu.sched_goidle.min
     51567 ±  8%     +60.7%      82878        sched_debug.cpu.ttwu_count.avg
     79015 ±  9%     +45.2%     114717 ±  4%  sched_debug.cpu.ttwu_count.max
     42919 ±  9%     +63.3%      70086        sched_debug.cpu.ttwu_count.min
    127632 ±  7%     +39.3%     177854 ±  5%  sched_debug.cpu_clk
    125087 ±  7%     +40.1%     175285 ±  5%  sched_debug.ktime
    127882 ±  6%     +39.3%     178163 ±  5%  sched_debug.sched_clk
    146.00 ± 13%    +902.9%       1464 ±143%  interrupts.133:IR-PCI-MSI.2097153-edge.eth1-TxRx-0
      3375 ± 93%     -94.8%     174.75 ± 26%  interrupts.134:IR-PCI-MSI.2097154-edge.eth1-TxRx-1
    297595 ±  8%     +22.8%     365351 ±  2%  interrupts.CPU0.LOC:Local_timer_interrupts
      8402           -21.7%       6577 ± 25%  interrupts.CPU0.NMI:Non-maskable_interrupts
      8402           -21.7%       6577 ± 25%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
    937.00 ±  2%     +18.1%       1106 ± 11%  interrupts.CPU0.RES:Rescheduling_interrupts
    146.00 ± 13%    +902.9%       1464 ±143%  interrupts.CPU1.133:IR-PCI-MSI.2097153-edge.eth1-TxRx-0
    297695 ±  8%     +22.7%     365189 ±  2%  interrupts.CPU1.LOC:Local_timer_interrupts
      8412           -20.9%       6655 ± 25%  interrupts.CPU1.NMI:Non-maskable_interrupts
      8412           -20.9%       6655 ± 25%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
    297641 ±  8%     +22.7%     365268 ±  2%  interrupts.CPU10.LOC:Local_timer_interrupts
      8365           -10.9%       7455 ±  3%  interrupts.CPU10.NMI:Non-maskable_interrupts
      8365           -10.9%       7455 ±  3%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
    297729 ±  8%     +22.7%     365238 ±  2%  interrupts.CPU11.LOC:Local_timer_interrupts
      8376           -21.8%       6554 ± 26%  interrupts.CPU11.NMI:Non-maskable_interrupts
      8376           -21.8%       6554 ± 26%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
    297394 ±  8%     +22.8%     365274 ±  2%  interrupts.CPU12.LOC:Local_timer_interrupts
      8393           -10.5%       7512 ±  3%  interrupts.CPU12.NMI:Non-maskable_interrupts
      8393           -10.5%       7512 ±  3%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
    297744 ±  8%     +22.7%     365243 ±  2%  interrupts.CPU13.LOC:Local_timer_interrupts
      8353           -10.6%       7469 ±  3%  interrupts.CPU13.NMI:Non-maskable_interrupts
      8353           -10.6%       7469 ±  3%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
    148.50 ± 17%     -24.2%     112.50 ±  8%  interrupts.CPU13.TLB:TLB_shootdowns
    297692 ±  8%     +22.7%     365311 ±  2%  interrupts.CPU14.LOC:Local_timer_interrupts
      8374           -10.4%       7501 ±  4%  interrupts.CPU14.NMI:Non-maskable_interrupts
      8374           -10.4%       7501 ±  4%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
    297453 ±  8%     +22.8%     365311 ±  2%  interrupts.CPU15.LOC:Local_timer_interrupts
      8336           -22.8%       6433 ± 26%  interrupts.CPU15.NMI:Non-maskable_interrupts
      8336           -22.8%       6433 ± 26%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
    699.50 ± 21%     +51.3%       1058 ± 10%  interrupts.CPU15.RES:Rescheduling_interrupts
      3375 ± 93%     -94.8%     174.75 ± 26%  interrupts.CPU2.134:IR-PCI-MSI.2097154-edge.eth1-TxRx-1
    297685 ±  8%     +22.7%     365273 ±  2%  interrupts.CPU2.LOC:Local_timer_interrupts
      8357           -21.2%       6584 ± 25%  interrupts.CPU2.NMI:Non-maskable_interrupts
      8357           -21.2%       6584 ± 25%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
    164.00 ± 30%     -23.0%     126.25 ± 32%  interrupts.CPU2.TLB:TLB_shootdowns
    297352 ±  8%     +22.9%     365371 ±  2%  interrupts.CPU3.LOC:Local_timer_interrupts
      8383           -10.6%       7493 ±  4%  interrupts.CPU3.NMI:Non-maskable_interrupts
      8383           -10.6%       7493 ±  4%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
    780.50 ±  3%     +32.7%       1035 ±  6%  interrupts.CPU3.RES:Rescheduling_interrupts
    297595 ±  8%     +22.8%     365415 ±  2%  interrupts.CPU4.LOC:Local_timer_interrupts
      8382           -21.4%       6584 ± 25%  interrupts.CPU4.NMI:Non-maskable_interrupts
      8382           -21.4%       6584 ± 25%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
    297720 ±  8%     +22.7%     365347 ±  2%  interrupts.CPU5.LOC:Local_timer_interrupts
      8353           -32.0%       5679 ± 34%  interrupts.CPU5.NMI:Non-maskable_interrupts
      8353           -32.0%       5679 ± 34%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
    727.00 ± 16%     +98.3%       1442 ± 47%  interrupts.CPU5.RES:Rescheduling_interrupts
    297620 ±  8%     +22.8%     365343 ±  2%  interrupts.CPU6.LOC:Local_timer_interrupts
      8388           -10.3%       7526 ±  4%  interrupts.CPU6.NMI:Non-maskable_interrupts
      8388           -10.3%       7526 ±  4%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
    156.50 ±  3%     -27.6%     113.25 ± 16%  interrupts.CPU6.TLB:TLB_shootdowns
    297690 ±  8%     +22.7%     365363 ±  2%  interrupts.CPU7.LOC:Local_timer_interrupts
      8390           -23.1%       6449 ± 25%  interrupts.CPU7.NMI:Non-maskable_interrupts
      8390           -23.1%       6449 ± 25%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
    918.00 ± 16%     +49.4%       1371 ±  7%  interrupts.CPU7.RES:Rescheduling_interrupts
    120.00 ± 35%     +70.8%     205.00 ± 17%  interrupts.CPU7.TLB:TLB_shootdowns
    297731 ±  8%     +22.7%     365368 ±  2%  interrupts.CPU8.LOC:Local_timer_interrupts
      8393           -32.5%       5668 ± 35%  interrupts.CPU8.NMI:Non-maskable_interrupts
      8393           -32.5%       5668 ± 35%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
    297779 ±  8%     +22.7%     365399 ±  2%  interrupts.CPU9.LOC:Local_timer_interrupts
      8430           -10.8%       7517 ±  2%  interrupts.CPU9.NMI:Non-maskable_interrupts
      8430           -10.8%       7517 ±  2%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
    956.50           +13.5%       1085 ±  4%  interrupts.CPU9.RES:Rescheduling_interrupts
   4762118 ±  8%     +22.7%    5845069 ±  2%  interrupts.LOC:Local_timer_interrupts
    134093           -18.2%     109662 ± 11%  interrupts.NMI:Non-maskable_interrupts
    134093           -18.2%     109662 ± 11%  interrupts.PMI:Performance_monitoring_interrupts
     66.97 ±  9%     -29.9       37.12 ± 49%  perf-profile.calltrace.cycles-pp.deflate
     66.67 ±  9%     -29.7       36.97 ± 50%  perf-profile.calltrace.cycles-pp.deflate_medium.deflate
     43.24 ±  9%     -18.6       24.61 ± 49%  perf-profile.calltrace.cycles-pp.longest_match.deflate_medium.deflate
      2.29 ± 14%      -1.2        1.05 ± 58%  perf-profile.calltrace.cycles-pp.deflateSetDictionary
      0.74 ±  6%      -0.5        0.27 ±100%  perf-profile.calltrace.cycles-pp.read.__libc_start_main
      0.74 ±  7%      -0.5        0.27 ±100%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read.__libc_start_main
      0.73 ±  7%      -0.5        0.27 ±100%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read.__libc_start_main
      0.73 ±  7%      -0.5        0.27 ±100%  perf-profile.calltrace.cycles-pp.__x64_sys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read.__libc_start_main
      0.73 ±  7%      -0.5        0.27 ±100%  perf-profile.calltrace.cycles-pp.ksys_read.__x64_sys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.26 ±100%      +0.6        0.88 ± 45%  perf-profile.calltrace.cycles-pp.vfs_statx.__do_sys_newfstatat.__x64_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.34 ±100%      +0.7        1.02 ± 42%  perf-profile.calltrace.cycles-pp.do_sys_open.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.28 ±100%      +0.7        0.96 ± 44%  perf-profile.calltrace.cycles-pp.__do_sys_newfstatat.__x64_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.28 ±100%      +0.7        0.96 ± 44%  perf-profile.calltrace.cycles-pp.__x64_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.34 ±100%      +0.7        1.03 ± 42%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.8        0.77 ± 35%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.56 ±  9%      +0.8        1.40 ± 45%  perf-profile.calltrace.cycles-pp.__schedule.schedule.futex_wait_queue_me.futex_wait.do_futex
      0.58 ± 10%      +0.9        1.43 ± 45%  perf-profile.calltrace.cycles-pp.schedule.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      0.33 ±100%      +0.9        1.21 ± 28%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_select.do_idle.cpu_startup_entry.start_secondary
      0.34 ± 99%      +0.9        1.27 ± 30%  perf-profile.calltrace.cycles-pp.cpuidle_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      0.00            +1.0        0.96 ± 62%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.62 ±  9%      +1.0        1.60 ± 52%  perf-profile.calltrace.cycles-pp.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex.do_syscall_64
      0.68 ± 10%      +1.0        1.73 ± 51%  perf-profile.calltrace.cycles-pp.futex_wait.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.46 ±100%      +1.1        1.60 ± 43%  perf-profile.calltrace.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      0.47 ±100%      +1.2        1.62 ± 43%  perf-profile.calltrace.cycles-pp.apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     17.73 ± 21%     +19.1       36.84 ± 25%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     17.75 ± 20%     +19.9       37.63 ± 26%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     17.84 ± 20%     +20.0       37.82 ± 26%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     18.83 ± 20%     +21.2       40.05 ± 27%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     18.89 ± 20%     +21.2       40.11 ± 27%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
     18.89 ± 20%     +21.2       40.12 ± 27%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
     20.14 ± 20%     +22.5       42.66 ± 27%  perf-profile.calltrace.cycles-pp.secondary_startup_64
     66.97 ±  9%     -29.9       37.12 ± 49%  perf-profile.children.cycles-pp.deflate
     66.83 ±  9%     -29.8       37.06 ± 49%  perf-profile.children.cycles-pp.deflate_medium
     43.58 ±  9%     -18.8       24.80 ± 49%  perf-profile.children.cycles-pp.longest_match
      2.29 ± 14%      -1.2        1.12 ± 43%  perf-profile.children.cycles-pp.deflateSetDictionary
      0.84            -0.3        0.58 ± 19%  perf-profile.children.cycles-pp.read
      0.52 ± 13%      -0.2        0.27 ± 43%  perf-profile.children.cycles-pp.fill_window
      0.06            +0.0        0.08 ± 13%  perf-profile.children.cycles-pp.update_stack_state
      0.07 ± 14%      +0.0        0.11 ± 24%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.03 ±100%      +0.1        0.09 ± 19%  perf-profile.children.cycles-pp.find_next_and_bit
      0.00            +0.1        0.06 ± 15%  perf-profile.children.cycles-pp.refcount_inc_not_zero_checked
      0.03 ±100%      +0.1        0.08 ± 33%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.07 ±  7%      +0.1        0.12 ± 36%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.00            +0.1        0.06 ± 28%  perf-profile.children.cycles-pp.rb_erase
      0.03 ±100%      +0.1        0.09 ± 24%  perf-profile.children.cycles-pp.shmem_undo_range
      0.03 ±100%      +0.1        0.09 ± 28%  perf-profile.children.cycles-pp.unlinkat
      0.03 ±100%      +0.1        0.09 ± 28%  perf-profile.children.cycles-pp.__x64_sys_unlinkat
      0.03 ±100%      +0.1        0.09 ± 28%  perf-profile.children.cycles-pp.do_unlinkat
      0.03 ±100%      +0.1        0.09 ± 28%  perf-profile.children.cycles-pp.ovl_destroy_inode
      0.03 ±100%      +0.1        0.09 ± 28%  perf-profile.children.cycles-pp.shmem_evict_inode
      0.03 ±100%      +0.1        0.09 ± 28%  perf-profile.children.cycles-pp.shmem_truncate_range
      0.05            +0.1        0.12 ± 38%  perf-profile.children.cycles-pp.unmap_vmas
      0.00            +0.1        0.07 ± 30%  perf-profile.children.cycles-pp.timerqueue_del
      0.00            +0.1        0.07 ± 26%  perf-profile.children.cycles-pp.idle_cpu
      0.09 ± 17%      +0.1        0.15 ± 19%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.00            +0.1        0.07 ± 33%  perf-profile.children.cycles-pp.unmap_region
      0.00            +0.1        0.07 ± 33%  perf-profile.children.cycles-pp.__alloc_fd
      0.03 ±100%      +0.1        0.10 ± 31%  perf-profile.children.cycles-pp.destroy_inode
      0.03 ±100%      +0.1        0.10 ± 30%  perf-profile.children.cycles-pp.evict
      0.06 ± 16%      +0.1        0.13 ± 35%  perf-profile.children.cycles-pp.ovl_override_creds
      0.00            +0.1        0.07 ± 26%  perf-profile.children.cycles-pp.kernel_text_address
      0.00            +0.1        0.07 ± 41%  perf-profile.children.cycles-pp.file_remove_privs
      0.07 ± 23%      +0.1        0.14 ± 47%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.03 ±100%      +0.1        0.10 ± 24%  perf-profile.children.cycles-pp.__dentry_kill
      0.03 ±100%      +0.1        0.10 ± 29%  perf-profile.children.cycles-pp.dentry_unlink_inode
      0.03 ±100%      +0.1        0.10 ± 29%  perf-profile.children.cycles-pp.iput
      0.03 ±100%      +0.1        0.10 ± 54%  perf-profile.children.cycles-pp.__close_fd
      0.08 ± 25%      +0.1        0.15 ± 35%  perf-profile.children.cycles-pp.__switch_to
      0.00            +0.1        0.07 ± 29%  perf-profile.children.cycles-pp.__switch_to_asm
      0.00            +0.1        0.08 ± 24%  perf-profile.children.cycles-pp.__kernel_text_address
      0.03 ±100%      +0.1        0.11 ± 51%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.03 ±100%      +0.1        0.11 ± 33%  perf-profile.children.cycles-pp.rcu_gp_kthread_wake
      0.03 ±100%      +0.1        0.11 ± 33%  perf-profile.children.cycles-pp.swake_up_one
      0.03 ±100%      +0.1        0.11 ± 33%  perf-profile.children.cycles-pp.swake_up_locked
      0.10 ± 30%      +0.1        0.18 ± 17%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.03 ±100%      +0.1        0.11 ± 38%  perf-profile.children.cycles-pp.unmap_page_range
      0.00            +0.1        0.09 ± 37%  perf-profile.children.cycles-pp.putname
      0.03 ±100%      +0.1        0.11 ± 28%  perf-profile.children.cycles-pp.filemap_map_pages
      0.07 ± 28%      +0.1        0.16 ± 35%  perf-profile.children.cycles-pp.getname
      0.03 ±100%      +0.1        0.11 ± 40%  perf-profile.children.cycles-pp.unmap_single_vma
      0.08 ± 29%      +0.1        0.17 ± 38%  perf-profile.children.cycles-pp.queued_spin_lock_slowpath
      0.03 ±100%      +0.1        0.12 ± 54%  perf-profile.children.cycles-pp.setlocale
      0.03 ±100%      +0.1        0.12 ± 60%  perf-profile.children.cycles-pp.__open64_nocancel
      0.00            +0.1        0.09 ± 31%  perf-profile.children.cycles-pp.__hrtimer_get_next_event
      0.00            +0.1        0.10 ± 28%  perf-profile.children.cycles-pp.get_unused_fd_flags
      0.00            +0.1        0.10 ± 65%  perf-profile.children.cycles-pp.timerqueue_add
      0.07 ± 28%      +0.1        0.17 ± 42%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.03 ±100%      +0.1        0.12 ± 51%  perf-profile.children.cycles-pp.__x64_sys_close
      0.00            +0.1        0.10 ± 38%  perf-profile.children.cycles-pp.do_lookup_x
      0.03 ±100%      +0.1        0.12 ± 23%  perf-profile.children.cycles-pp.kmem_cache_free
      0.04 ±100%      +0.1        0.14 ± 53%  perf-profile.children.cycles-pp.__do_munmap
      0.00            +0.1        0.10 ± 35%  perf-profile.children.cycles-pp.unwind_get_return_address
      0.00            +0.1        0.10 ± 49%  perf-profile.children.cycles-pp.shmem_add_to_page_cache
      0.07 ± 20%      +0.1        0.18 ± 25%  perf-profile.children.cycles-pp.find_next_bit
      0.08 ± 25%      +0.1        0.18 ± 34%  perf-profile.children.cycles-pp.dput
      0.11 ± 33%      +0.1        0.21 ± 37%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.08 ±  5%      +0.1        0.19 ± 27%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.1        0.11 ± 52%  perf-profile.children.cycles-pp.rcu_idle_exit
      0.03 ±100%      +0.1        0.14 ± 18%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.08            +0.1        0.19 ± 43%  perf-profile.children.cycles-pp.exit_mmap
      0.09 ± 22%      +0.1        0.20 ± 57%  perf-profile.children.cycles-pp.set_next_entity
      0.07 ±  7%      +0.1        0.18 ± 60%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.10 ± 26%      +0.1        0.21 ± 32%  perf-profile.children.cycles-pp.sched_clock
      0.12 ± 25%      +0.1        0.23 ± 39%  perf-profile.children.cycles-pp.update_cfs_group
      0.07 ± 14%      +0.1        0.18 ± 45%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.08 ±  5%      +0.1        0.20 ± 44%  perf-profile.children.cycles-pp.mmput
      0.11 ± 18%      +0.1        0.23 ± 41%  perf-profile.children.cycles-pp.clockevents_program_event
      0.07 ±  7%      +0.1        0.18 ± 40%  perf-profile.children.cycles-pp.strncpy_from_user
      0.00            +0.1        0.12 ± 48%  perf-profile.children.cycles-pp.flush_old_exec
      0.11 ± 18%      +0.1        0.23 ± 37%  perf-profile.children.cycles-pp.native_sched_clock
      0.09 ± 17%      +0.1        0.21 ± 46%  perf-profile.children.cycles-pp._dl_sysdep_start
      0.12 ± 19%      +0.1        0.26 ± 37%  perf-profile.children.cycles-pp.tick_program_event
      0.09 ± 33%      +0.1        0.23 ± 61%  perf-profile.children.cycles-pp.mmap_region
      0.14 ± 21%      +0.1        0.28 ± 39%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.11 ± 27%      +0.1        0.25 ± 56%  perf-profile.children.cycles-pp.do_mmap
      0.11 ± 36%      +0.1        0.26 ± 57%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.09 ± 17%      +0.1        0.23 ± 48%  perf-profile.children.cycles-pp.lookup_fast
      0.04 ±100%      +0.2        0.19 ± 48%  perf-profile.children.cycles-pp.open_path
      0.11 ± 30%      +0.2        0.27 ± 58%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.11 ± 27%      +0.2        0.28 ± 37%  perf-profile.children.cycles-pp.update_blocked_averages
      0.11            +0.2        0.29 ± 38%  perf-profile.children.cycles-pp.search_binary_handler
      0.11 ±  4%      +0.2        0.29 ± 39%  perf-profile.children.cycles-pp.load_elf_binary
      0.11 ± 30%      +0.2        0.30 ± 50%  perf-profile.children.cycles-pp.inode_permission
      0.04 ±100%      +0.2        0.24 ± 55%  perf-profile.children.cycles-pp.__GI___open64_nocancel
      0.15 ± 29%      +0.2        0.35 ± 34%  perf-profile.children.cycles-pp.getname_flags
      0.16 ± 25%      +0.2        0.38 ± 26%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.18 ± 11%      +0.2        0.41 ± 39%  perf-profile.children.cycles-pp.execve
      0.19 ±  5%      +0.2        0.42 ± 37%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.18 ±  2%      +0.2        0.42 ± 37%  perf-profile.children.cycles-pp.__do_execve_file
      0.32 ± 18%      +0.3        0.57 ± 33%  perf-profile.children.cycles-pp.__account_scheduler_latency
      0.21 ± 17%      +0.3        0.48 ± 47%  perf-profile.children.cycles-pp.schedule_idle
      0.20 ± 19%      +0.3        0.49 ± 33%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.21 ± 26%      +0.3        0.55 ± 41%  perf-profile.children.cycles-pp.find_busiest_group
      0.32 ± 26%      +0.3        0.67 ± 52%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.22 ± 25%      +0.4        0.57 ± 49%  perf-profile.children.cycles-pp.filename_lookup
      0.34 ± 27%      +0.4        0.72 ± 50%  perf-profile.children.cycles-pp.handle_mm_fault
      0.42 ± 32%      +0.4        0.80 ± 43%  perf-profile.children.cycles-pp.shmem_getpage_gfp
      0.36 ± 23%      +0.4        0.77 ± 41%  perf-profile.children.cycles-pp.load_balance
      0.41 ± 30%      +0.4        0.82 ± 50%  perf-profile.children.cycles-pp.do_page_fault
      0.39 ± 30%      +0.4        0.80 ± 50%  perf-profile.children.cycles-pp.__do_page_fault
      0.28 ± 22%      +0.4        0.70 ± 37%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.43 ± 31%      +0.4        0.86 ± 49%  perf-profile.children.cycles-pp.page_fault
      0.31 ± 25%      +0.5        0.77 ± 46%  perf-profile.children.cycles-pp.user_path_at_empty
      0.36 ± 20%      +0.5        0.84 ± 34%  perf-profile.children.cycles-pp.newidle_balance
      0.45 ± 21%      +0.5        0.95 ± 44%  perf-profile.children.cycles-pp.vfs_statx
      0.46 ± 20%      +0.5        0.97 ± 43%  perf-profile.children.cycles-pp.__do_sys_newfstatat
      0.47 ± 20%      +0.5        0.98 ± 44%  perf-profile.children.cycles-pp.__x64_sys_newfstatat
      0.29 ± 37%      +0.5        0.81 ± 32%  perf-profile.children.cycles-pp.io_serial_in
      0.53 ± 25%      +0.5        1.06 ± 49%  perf-profile.children.cycles-pp.path_openat
      0.55 ± 24%      +0.5        1.09 ± 50%  perf-profile.children.cycles-pp.do_filp_open
      0.35 ±  2%      +0.5        0.90 ± 60%  perf-profile.children.cycles-pp.uart_console_write
      0.35 ±  4%      +0.6        0.91 ± 60%  perf-profile.children.cycles-pp.console_unlock
      0.35 ±  4%      +0.6        0.91 ± 60%  perf-profile.children.cycles-pp.univ8250_console_write
      0.35 ±  4%      +0.6        0.91 ± 60%  perf-profile.children.cycles-pp.serial8250_console_write
      0.82 ± 23%      +0.6        1.42 ± 31%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.47 ± 28%      +0.6        1.10 ± 39%  perf-profile.children.cycles-pp.irq_work_interrupt
      0.47 ± 28%      +0.6        1.10 ± 39%  perf-profile.children.cycles-pp.smp_irq_work_interrupt
      0.47 ± 28%      +0.6        1.10 ± 39%  perf-profile.children.cycles-pp.irq_work_run
      0.47 ± 28%      +0.6        1.10 ± 39%  perf-profile.children.cycles-pp.perf_duration_warn
      0.47 ± 28%      +0.6        1.10 ± 39%  perf-profile.children.cycles-pp.printk
      0.47 ± 28%      +0.6        1.10 ± 39%  perf-profile.children.cycles-pp.vprintk_func
      0.47 ± 28%      +0.6        1.10 ± 39%  perf-profile.children.cycles-pp.vprintk_default
      0.47 ± 28%      +0.6        1.11 ± 39%  perf-profile.children.cycles-pp.irq_work_run_list
      0.49 ± 31%      +0.6        1.13 ± 39%  perf-profile.children.cycles-pp.vprintk_emit
      0.54 ± 19%      +0.6        1.17 ± 38%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.32 ±  7%      +0.7        1.02 ± 56%  perf-profile.children.cycles-pp.poll_idle
      0.60 ± 15%      +0.7        1.31 ± 29%  perf-profile.children.cycles-pp.menu_select
      0.65 ± 27%      +0.7        1.36 ± 45%  perf-profile.children.cycles-pp.do_sys_open
      0.62 ± 15%      +0.7        1.36 ± 31%  perf-profile.children.cycles-pp.cpuidle_select
      0.66 ± 26%      +0.7        1.39 ± 44%  perf-profile.children.cycles-pp.__x64_sys_openat
      1.11 ± 22%      +0.9        2.03 ± 31%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.89 ± 24%      +0.9        1.81 ± 42%  perf-profile.children.cycles-pp.futex_wait_queue_me
      1.16 ± 27%      +1.0        2.13 ± 36%  perf-profile.children.cycles-pp.schedule
      0.97 ± 23%      +1.0        1.97 ± 42%  perf-profile.children.cycles-pp.futex_wait
      1.33 ± 25%      +1.2        2.55 ± 39%  perf-profile.children.cycles-pp.__schedule
      1.84 ± 26%      +1.6        3.42 ± 36%  perf-profile.children.cycles-pp.smp_apic_timer_interrupt
      1.76 ± 22%      +1.6        3.41 ± 40%  perf-profile.children.cycles-pp.do_futex
      1.79 ± 22%      +1.7        3.49 ± 41%  perf-profile.children.cycles-pp.__x64_sys_futex
      2.23 ± 20%      +1.7        3.98 ± 37%  perf-profile.children.cycles-pp.apic_timer_interrupt
     17.73 ± 21%     +19.1       36.86 ± 25%  perf-profile.children.cycles-pp.intel_idle
     19.00 ± 21%     +21.1       40.13 ± 26%  perf-profile.children.cycles-pp.cpuidle_enter_state
     19.02 ± 21%     +21.2       40.19 ± 26%  perf-profile.children.cycles-pp.cpuidle_enter
     18.89 ± 20%     +21.2       40.12 ± 27%  perf-profile.children.cycles-pp.start_secondary
     20.14 ± 20%     +22.5       42.65 ± 27%  perf-profile.children.cycles-pp.cpu_startup_entry
     20.08 ± 20%     +22.5       42.59 ± 27%  perf-profile.children.cycles-pp.do_idle
     20.14 ± 20%     +22.5       42.66 ± 27%  perf-profile.children.cycles-pp.secondary_startup_64
     43.25 ±  9%     -18.6       24.63 ± 49%  perf-profile.self.cycles-pp.longest_match
     22.74 ± 11%     -10.8       11.97 ± 50%  perf-profile.self.cycles-pp.deflate_medium
      2.26 ± 14%      -1.2        1.11 ± 44%  perf-profile.self.cycles-pp.deflateSetDictionary
      0.51 ± 12%      -0.3        0.24 ± 57%  perf-profile.self.cycles-pp.fill_window
      0.07 ±  7%      +0.0        0.10 ± 24%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.07 ±  7%      +0.1        0.12 ± 36%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.08 ± 12%      +0.1        0.14 ± 15%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.06            +0.1        0.13 ± 27%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.08 ± 25%      +0.1        0.15 ± 37%  perf-profile.self.cycles-pp.__switch_to
      0.06 ± 16%      +0.1        0.13 ± 29%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.00            +0.1        0.07 ± 29%  perf-profile.self.cycles-pp.__switch_to_asm
      0.05            +0.1        0.13 ± 57%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.00            +0.1        0.08 ± 41%  perf-profile.self.cycles-pp.interrupt_entry
      0.00            +0.1        0.08 ± 61%  perf-profile.self.cycles-pp.run_timer_softirq
      0.07 ± 23%      +0.1        0.15 ± 43%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.03 ±100%      +0.1        0.12 ± 43%  perf-profile.self.cycles-pp.update_cfs_group
      0.08 ± 29%      +0.1        0.17 ± 38%  perf-profile.self.cycles-pp.queued_spin_lock_slowpath
      0.00            +0.1        0.09 ± 29%  perf-profile.self.cycles-pp.strncpy_from_user
      0.06 ± 16%      +0.1        0.15 ± 24%  perf-profile.self.cycles-pp.find_next_bit
      0.00            +0.1        0.10 ± 35%  perf-profile.self.cycles-pp.do_lookup_x
      0.00            +0.1        0.10 ± 13%  perf-profile.self.cycles-pp.kmem_cache_free
      0.06 ± 16%      +0.1        0.16 ± 30%  perf-profile.self.cycles-pp.do_idle
      0.03 ±100%      +0.1        0.13 ± 18%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.03 ±100%      +0.1        0.14 ± 41%  perf-profile.self.cycles-pp.update_blocked_averages
      0.11 ± 18%      +0.1        0.22 ± 37%  perf-profile.self.cycles-pp.native_sched_clock
      0.07 ± 14%      +0.1        0.18 ± 46%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.00            +0.1        0.12 ± 65%  perf-profile.self.cycles-pp.set_next_entity
      0.12 ± 28%      +0.1        0.27 ± 32%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.15 ±  3%      +0.2        0.32 ± 39%  perf-profile.self.cycles-pp.io_serial_out
      0.25 ±  4%      +0.2        0.48 ± 19%  perf-profile.self.cycles-pp.menu_select
      0.15 ± 22%      +0.3        0.42 ± 46%  perf-profile.self.cycles-pp.find_busiest_group
      0.29 ± 37%      +0.4        0.71 ± 42%  perf-profile.self.cycles-pp.io_serial_in
      0.32 ±  7%      +0.7        1.02 ± 56%  perf-profile.self.cycles-pp.poll_idle
     17.73 ± 21%     +19.1       36.79 ± 25%  perf-profile.self.cycles-pp.intel_idle


                                                                                
                   phoronix-test-suite.compress-gzip.0.seconds                  
                                                                                
  8 +-----------------------------------------------------------------------+   
    |                       O   O    O   O                 O   O   O    O   |   
  7 |-+ O  O   O   O    O              O     O    O   O                     |   
  6 |-+      +                     +                    +                   |   
    |   +    :   +   +             :       +    +   +   :                   |   
  5 |-+ :    :   :   :            ::       :    :   :   :                   |   
    |   ::  : :  :   ::           : :      :   ::   :  :                    |   
  4 |:+: :  : : : : : :           : :     : :  : : : : :                    |   
    |: : :  : : : : : :   +   +   : :  +  : :  : : : : :                    |   
  3 |:+:  : : : : : :  :  :   :  :  :  :  : :  : : : : :                    |   
  2 |:+:  : : : : : :  : : : : : :  : : : : : :  : : : :                    |   
    |: :  : : : : : :  : : : : : :  : : : : : :  : : : :                    |   
  1 |-:   ::   :   :   : : : : : :   :: ::   ::   :   :                     |   
    | :    :   :   :    :   :   :    :   :   :    :   :                     |   
  0 +-----------------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-cfl-d1: 12 threads Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz with 8G memory


***************************************************************************************************
lkp-skl-fpga01: 104 threads Skylake with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase/ucode:
  gcc-7/performance/x86_64-rhel-7.6/debian-x86_64-2019-09-23.cgz/300s/8T/lkp-skl-fpga01/anon-cow-seq/vm-scalability/0x2000064

commit: 
  fcf0553db6 ("sched/fair: Remove meaningless imbalance calculation")
  0b0695f2b3 ("sched/fair: Rework load_balance()")

fcf0553db6f4c793 0b0695f2b34a4afa3f6e9aa1ff0 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    413301            +3.1%     426103        vm-scalability.median
      0.04 ±  2%     -34.0%       0.03 ± 12%  vm-scalability.median_stddev
  43837589            +2.4%   44902458        vm-scalability.throughput
    181085           -18.7%     147221        vm-scalability.time.involuntary_context_switches
  12762365 ±  2%      +3.9%   13262025        vm-scalability.time.minor_page_faults
      7773            +2.9%       7997        vm-scalability.time.percent_of_cpu_this_job_got
     11449            +1.2%      11589        vm-scalability.time.system_time
     12024            +4.7%      12584        vm-scalability.time.user_time
    439194 ±  2%     +46.0%     641402 ±  2%  vm-scalability.time.voluntary_context_switches
 1.148e+10            +5.0%  1.206e+10        vm-scalability.workload
      0.00 ± 54%      +0.0        0.00 ± 17%  mpstat.cpu.all.iowait%
   4767597           +52.5%    7268430 ± 41%  numa-numastat.node1.local_node
   4781030           +52.3%    7280347 ± 41%  numa-numastat.node1.numa_hit
     24.75            -9.1%      22.50 ±  2%  vmstat.cpu.id
     37.50            +4.7%      39.25        vmstat.cpu.us
      6643 ±  3%     +15.1%       7647        vmstat.system.cs
  12220504           +33.4%   16298593 ±  4%  cpuidle.C1.time
    260215 ±  6%     +55.3%     404158 ±  3%  cpuidle.C1.usage
   4986034 ±  3%     +56.2%    7786811 ±  2%  cpuidle.POLL.time
    145941 ±  3%     +61.2%     235218 ±  2%  cpuidle.POLL.usage
      1990            +3.0%       2049        turbostat.Avg_MHz
    254633 ±  6%     +56.7%     398892 ±  4%  turbostat.C1
      0.04            +0.0        0.05        turbostat.C1%
    309.99            +1.5%     314.75        turbostat.RAMWatt
      1688 ± 11%     +17.4%       1983 ±  5%  slabinfo.UNIX.active_objs
      1688 ± 11%     +17.4%       1983 ±  5%  slabinfo.UNIX.num_objs
      2460 ±  3%     -15.8%       2072 ± 11%  slabinfo.dmaengine-unmap-16.active_objs
      2460 ±  3%     -15.8%       2072 ± 11%  slabinfo.dmaengine-unmap-16.num_objs
      2814 ±  9%     +14.6%       3225 ±  4%  slabinfo.sock_inode_cache.active_objs
      2814 ±  9%     +14.6%       3225 ±  4%  slabinfo.sock_inode_cache.num_objs
      0.67 ±  5%      +0.1        0.73 ±  3%  perf-profile.calltrace.cycles-pp.__alloc_pages_nodemask.alloc_pages_vma.do_huge_pmd_wp_page.__handle_mm_fault.handle_mm_fault
      0.68 ±  6%      +0.1        0.74 ±  2%  perf-profile.calltrace.cycles-pp.alloc_pages_vma.do_huge_pmd_wp_page.__handle_mm_fault.handle_mm_fault.__do_page_fault
      0.05            +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.schedule
      0.06            +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__wake_up_common
      0.06 ±  7%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.wake_up_page_bit
      0.23 ±  7%      +0.0        0.28 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.drm_fb_helper_sys_imageblit
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.sys_imageblit
     29026 ±  3%     -26.7%      21283 ± 44%  numa-vmstat.node0.nr_inactive_anon
     30069 ±  3%     -20.5%      23905 ± 26%  numa-vmstat.node0.nr_shmem
     12120 ±  2%     -15.5%      10241 ± 12%  numa-vmstat.node0.nr_slab_reclaimable
     29026 ±  3%     -26.7%      21283 ± 44%  numa-vmstat.node0.nr_zone_inactive_anon
   4010893           +16.1%    4655889 ±  9%  numa-vmstat.node1.nr_active_anon
   3982581           +16.3%    4632344 ±  9%  numa-vmstat.node1.nr_anon_pages
      6861           +16.1%       7964 ±  8%  numa-vmstat.node1.nr_anon_transparent_hugepages
      2317 ± 42%    +336.9%      10125 ± 93%  numa-vmstat.node1.nr_inactive_anon
      6596 ±  4%     +18.2%       7799 ± 14%  numa-vmstat.node1.nr_kernel_stack
      9629 ±  8%     +66.4%      16020 ± 41%  numa-vmstat.node1.nr_shmem
      7558 ±  3%     +26.5%       9561 ± 14%  numa-vmstat.node1.nr_slab_reclaimable
   4010227           +16.1%    4655056 ±  9%  numa-vmstat.node1.nr_zone_active_anon
      2317 ± 42%    +336.9%      10125 ± 93%  numa-vmstat.node1.nr_zone_inactive_anon
   2859663 ±  2%     +46.2%    4179500 ± 36%  numa-vmstat.node1.numa_hit
   2680260 ±  2%     +49.3%    4002218 ± 37%  numa-vmstat.node1.numa_local
    116661 ±  3%     -26.3%      86010 ± 44%  numa-meminfo.node0.Inactive
    116192 ±  3%     -26.7%      85146 ± 44%  numa-meminfo.node0.Inactive(anon)
     48486 ±  2%     -15.5%      40966 ± 12%  numa-meminfo.node0.KReclaimable
     48486 ±  2%     -15.5%      40966 ± 12%  numa-meminfo.node0.SReclaimable
    120367 ±  3%     -20.5%      95642 ± 26%  numa-meminfo.node0.Shmem
  16210528           +15.2%   18673368 ±  6%  numa-meminfo.node1.Active
  16210394           +15.2%   18673287 ±  6%  numa-meminfo.node1.Active(anon)
  14170064           +15.6%   16379835 ±  7%  numa-meminfo.node1.AnonHugePages
  16113351           +15.3%   18577254 ±  7%  numa-meminfo.node1.AnonPages
     10534 ± 33%    +293.8%      41480 ± 92%  numa-meminfo.node1.Inactive
      9262 ± 42%    +338.2%      40589 ± 93%  numa-meminfo.node1.Inactive(anon)
     30235 ±  3%     +26.5%      38242 ± 14%  numa-meminfo.node1.KReclaimable
      6594 ±  4%     +18.3%       7802 ± 14%  numa-meminfo.node1.KernelStack
  17083646           +15.1%   19656922 ±  7%  numa-meminfo.node1.MemUsed
     30235 ±  3%     +26.5%      38242 ± 14%  numa-meminfo.node1.SReclaimable
     38540 ±  8%     +66.4%      64117 ± 42%  numa-meminfo.node1.Shmem
    106342           +19.8%     127451 ± 11%  numa-meminfo.node1.Slab
   9479688            +4.5%    9905902        proc-vmstat.nr_active_anon
   9434298            +4.5%    9856978        proc-vmstat.nr_anon_pages
     16194            +4.3%      16895        proc-vmstat.nr_anon_transparent_hugepages
    276.75            +3.6%     286.75        proc-vmstat.nr_dirtied
   3888633            -1.1%    3845882        proc-vmstat.nr_dirty_background_threshold
   7786774            -1.1%    7701168        proc-vmstat.nr_dirty_threshold
  39168820            -1.1%   38741444        proc-vmstat.nr_free_pages
     50391            +1.0%      50904        proc-vmstat.nr_slab_unreclaimable
    257.50            +3.6%     266.75        proc-vmstat.nr_written
   9479678            +4.5%    9905895        proc-vmstat.nr_zone_active_anon
   1501517            -5.9%    1412958        proc-vmstat.numa_hint_faults
   1075936           -13.1%     934706        proc-vmstat.numa_hint_faults_local
  17306395            +4.8%   18141722        proc-vmstat.numa_hit
   5211079            +4.2%    5427541        proc-vmstat.numa_huge_pte_updates
  17272620            +4.8%   18107691        proc-vmstat.numa_local
     33774            +0.8%      34031        proc-vmstat.numa_other
    690793 ±  3%     -13.7%     596166 ±  2%  proc-vmstat.numa_pages_migrated
 2.669e+09            +4.2%   2.78e+09        proc-vmstat.numa_pte_updates
 2.755e+09            +5.6%  2.909e+09        proc-vmstat.pgalloc_normal
  13573227 ±  2%      +3.6%   14060842        proc-vmstat.pgfault
 2.752e+09            +5.6%  2.906e+09        proc-vmstat.pgfree
 1.723e+08 ±  2%     +14.3%   1.97e+08 ±  8%  proc-vmstat.pgmigrate_fail
    690793 ±  3%     -13.7%     596166 ±  2%  proc-vmstat.pgmigrate_success
   5015265            +5.0%    5266730        proc-vmstat.thp_deferred_split_page
   5019661            +5.0%    5271482        proc-vmstat.thp_fault_alloc
     18284 ± 62%     -79.9%       3681 ±172%  sched_debug.cfs_rq:/.MIN_vruntime.avg
   1901618 ± 62%     -89.9%     192494 ±172%  sched_debug.cfs_rq:/.MIN_vruntime.max
    185571 ± 62%     -85.8%      26313 ±172%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
     15241 ±  6%     -36.6%       9655 ±  6%  sched_debug.cfs_rq:/.exec_clock.stddev
     18284 ± 62%     -79.9%       3681 ±172%  sched_debug.cfs_rq:/.max_vruntime.avg
   1901618 ± 62%     -89.9%     192494 ±172%  sched_debug.cfs_rq:/.max_vruntime.max
    185571 ± 62%     -85.8%      26313 ±172%  sched_debug.cfs_rq:/.max_vruntime.stddev
    898812 ±  7%     -31.2%     618552 ±  5%  sched_debug.cfs_rq:/.min_vruntime.stddev
     10.30 ± 12%     +34.5%      13.86 ±  6%  sched_debug.cfs_rq:/.nr_spread_over.avg
     34.75 ±  8%     +95.9%      68.08 ±  4%  sched_debug.cfs_rq:/.nr_spread_over.max
      9.12 ± 11%     +82.3%      16.62 ±  9%  sched_debug.cfs_rq:/.nr_spread_over.stddev
  -1470498           -31.9%   -1000709        sched_debug.cfs_rq:/.spread0.min
    899820 ±  7%     -31.2%     618970 ±  5%  sched_debug.cfs_rq:/.spread0.stddev
      1589 ±  9%     -19.2%       1284 ±  9%  sched_debug.cfs_rq:/.util_avg.max
      0.54 ± 39%   +7484.6%      41.08 ± 92%  sched_debug.cfs_rq:/.util_est_enqueued.min
    238.84 ±  8%     -33.2%     159.61 ± 26%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
     10787 ±  2%     +13.8%      12274        sched_debug.cpu.nr_switches.avg
     35242 ±  9%     +32.3%      46641 ± 25%  sched_debug.cpu.nr_switches.max
      9139 ±  3%     +16.4%      10636        sched_debug.cpu.sched_count.avg
     32025 ± 10%     +34.6%      43091 ± 27%  sched_debug.cpu.sched_count.max
      4016 ±  2%     +14.7%       4606 ±  5%  sched_debug.cpu.sched_count.min
      2960           +38.3%       4093        sched_debug.cpu.sched_goidle.avg
     11201 ± 24%     +75.8%      19691 ± 26%  sched_debug.cpu.sched_goidle.max
      1099 ±  6%     +56.9%       1725 ±  6%  sched_debug.cpu.sched_goidle.min
      1877 ± 10%     +32.5%       2487 ± 17%  sched_debug.cpu.sched_goidle.stddev
      4348 ±  3%     +19.3%       5188        sched_debug.cpu.ttwu_count.avg
     17832 ± 11%     +78.6%      31852 ± 29%  sched_debug.cpu.ttwu_count.max
      1699 ±  6%     +28.2%       2178 ±  7%  sched_debug.cpu.ttwu_count.min
      1357 ± 10%     -22.6%       1050 ±  4%  sched_debug.cpu.ttwu_local.avg
     11483 ±  5%     -25.0%       8614 ± 15%  sched_debug.cpu.ttwu_local.max
      1979 ± 12%     -36.8%       1251 ± 10%  sched_debug.cpu.ttwu_local.stddev
 3.941e+10            +5.0%  4.137e+10        perf-stat.i.branch-instructions
      0.02 ± 50%      -0.0        0.02 ±  5%  perf-stat.i.branch-miss-rate%
     67.94            -3.9       63.99        perf-stat.i.cache-miss-rate%
 8.329e+08            -1.9%   8.17e+08        perf-stat.i.cache-misses
 1.224e+09            +4.5%   1.28e+09        perf-stat.i.cache-references
      6650 ±  3%     +15.5%       7678        perf-stat.i.context-switches
      1.64            -1.8%       1.61        perf-stat.i.cpi
 2.037e+11            +2.8%  2.095e+11        perf-stat.i.cpu-cycles
    257.56            -4.0%     247.13        perf-stat.i.cpu-migrations
    244.94            +4.5%     255.91        perf-stat.i.cycles-between-cache-misses
   1189446 ±  2%      +3.2%    1227527        perf-stat.i.dTLB-load-misses
 2.669e+10            +4.7%  2.794e+10        perf-stat.i.dTLB-loads
      0.00 ±  7%      -0.0        0.00        perf-stat.i.dTLB-store-miss-rate%
    337782            +4.5%     353044        perf-stat.i.dTLB-store-misses
 9.096e+09            +4.7%  9.526e+09        perf-stat.i.dTLB-stores
     39.50            +2.1       41.64        perf-stat.i.iTLB-load-miss-rate%
    296305 ±  2%      +9.0%     323020        perf-stat.i.iTLB-load-misses
 1.238e+11            +4.9%  1.299e+11        perf-stat.i.instructions
    428249 ±  2%      -4.4%     409553        perf-stat.i.instructions-per-iTLB-miss
      0.61            +1.6%       0.62        perf-stat.i.ipc
     44430            +3.8%      46121        perf-stat.i.minor-faults
     54.82            +3.9       58.73        perf-stat.i.node-load-miss-rate%
  68519419 ±  4%     -11.7%   60479057 ±  6%  perf-stat.i.node-load-misses
  49879161 ±  3%     -20.7%   39554915 ±  4%  perf-stat.i.node-loads
     44428            +3.8%      46119        perf-stat.i.page-faults
      0.02            -0.0        0.01 ±  5%  perf-stat.overall.branch-miss-rate%
     68.03            -4.2       63.83        perf-stat.overall.cache-miss-rate%
      1.65            -2.0%       1.61        perf-stat.overall.cpi
    244.61            +4.8%     256.41        perf-stat.overall.cycles-between-cache-misses
     30.21            +2.2       32.38        perf-stat.overall.iTLB-load-miss-rate%
    417920 ±  2%      -3.7%     402452        perf-stat.overall.instructions-per-iTLB-miss
      0.61            +2.1%       0.62        perf-stat.overall.ipc
     57.84            +2.6       60.44        perf-stat.overall.node-load-miss-rate%
 3.925e+10            +5.1%  4.124e+10        perf-stat.ps.branch-instructions
 8.295e+08            -1.8%  8.144e+08        perf-stat.ps.cache-misses
 1.219e+09            +4.6%  1.276e+09        perf-stat.ps.cache-references
      6625 ±  3%     +15.4%       7648        perf-stat.ps.context-switches
 2.029e+11            +2.9%  2.088e+11        perf-stat.ps.cpu-cycles
    256.82            -4.2%     246.09        perf-stat.ps.cpu-migrations
   1184763 ±  2%      +3.3%    1223366        perf-stat.ps.dTLB-load-misses
 2.658e+10            +4.8%  2.786e+10        perf-stat.ps.dTLB-loads
    336658            +4.5%     351710        perf-stat.ps.dTLB-store-misses
 9.059e+09            +4.8%  9.497e+09        perf-stat.ps.dTLB-stores
    295140 ±  2%      +9.0%     321824        perf-stat.ps.iTLB-load-misses
 1.233e+11            +5.0%  1.295e+11        perf-stat.ps.instructions
     44309            +3.7%      45933        perf-stat.ps.minor-faults
  68208972 ±  4%     -11.6%   60272675 ±  6%  perf-stat.ps.node-load-misses
  49689740 ±  3%     -20.7%   39401789 ±  4%  perf-stat.ps.node-loads
     44308            +3.7%      45932        perf-stat.ps.page-faults
 3.732e+13            +5.1%  3.922e+13        perf-stat.total.instructions
     14949 ±  2%     +14.5%      17124 ± 11%  softirqs.CPU0.SCHED
      9940           +37.8%      13700 ± 24%  softirqs.CPU1.SCHED
      9370 ±  2%     +28.2%      12014 ± 16%  softirqs.CPU10.SCHED
     17637 ±  2%     -16.5%      14733 ± 16%  softirqs.CPU101.SCHED
     17846 ±  3%     -17.4%      14745 ± 16%  softirqs.CPU103.SCHED
      9552           +24.7%      11916 ± 17%  softirqs.CPU11.SCHED
      9210 ±  5%     +27.9%      11784 ± 16%  softirqs.CPU12.SCHED
      9378 ±  3%     +27.7%      11974 ± 16%  softirqs.CPU13.SCHED
      9164 ±  2%     +29.4%      11856 ± 18%  softirqs.CPU14.SCHED
      9215           +21.2%      11170 ± 19%  softirqs.CPU15.SCHED
      9118 ±  2%     +29.1%      11772 ± 16%  softirqs.CPU16.SCHED
      9413           +29.2%      12165 ± 18%  softirqs.CPU17.SCHED
      9309 ±  2%     +29.9%      12097 ± 17%  softirqs.CPU18.SCHED
      9423           +26.1%      11880 ± 15%  softirqs.CPU19.SCHED
      9010 ±  7%     +37.8%      12420 ± 18%  softirqs.CPU2.SCHED
      9382 ±  3%     +27.0%      11916 ± 15%  softirqs.CPU20.SCHED
      9102 ±  4%     +30.0%      11830 ± 16%  softirqs.CPU21.SCHED
      9543 ±  3%     +23.4%      11780 ± 18%  softirqs.CPU22.SCHED
      8998 ±  5%     +29.2%      11630 ± 18%  softirqs.CPU24.SCHED
      9254 ±  2%     +23.9%      11462 ± 19%  softirqs.CPU25.SCHED
     18450 ±  4%     -16.9%      15341 ± 16%  softirqs.CPU26.SCHED
     17551 ±  4%     -14.8%      14956 ± 13%  softirqs.CPU27.SCHED
     17575 ±  4%     -14.6%      15010 ± 14%  softirqs.CPU28.SCHED
     17515 ±  5%     -14.2%      15021 ± 13%  softirqs.CPU29.SCHED
     17715 ±  2%     -16.1%      14856 ± 13%  softirqs.CPU30.SCHED
     17754 ±  4%     -16.1%      14904 ± 13%  softirqs.CPU31.SCHED
     17675 ±  2%     -17.0%      14679 ± 21%  softirqs.CPU32.SCHED
     17625 ±  2%     -16.0%      14813 ± 13%  softirqs.CPU34.SCHED
     17619 ±  2%     -14.7%      15024 ± 14%  softirqs.CPU35.SCHED
     17887 ±  3%     -17.0%      14841 ± 14%  softirqs.CPU36.SCHED
     17658 ±  3%     -16.3%      14771 ± 12%  softirqs.CPU38.SCHED
     17501 ±  2%     -15.3%      14816 ± 14%  softirqs.CPU39.SCHED
      9360 ±  2%     +25.4%      11740 ± 14%  softirqs.CPU4.SCHED
     17699 ±  4%     -16.2%      14827 ± 14%  softirqs.CPU42.SCHED
     17580 ±  3%     -16.5%      14679 ± 15%  softirqs.CPU43.SCHED
     17658 ±  3%     -17.1%      14644 ± 14%  softirqs.CPU44.SCHED
     17452 ±  4%     -14.0%      15001 ± 15%  softirqs.CPU46.SCHED
     17599 ±  4%     -17.4%      14544 ± 14%  softirqs.CPU47.SCHED
     17792 ±  3%     -16.5%      14864 ± 14%  softirqs.CPU48.SCHED
     17333 ±  2%     -16.7%      14445 ± 14%  softirqs.CPU49.SCHED
      9483           +32.3%      12547 ± 24%  softirqs.CPU5.SCHED
     17842 ±  3%     -15.9%      14997 ± 16%  softirqs.CPU51.SCHED
      9051 ±  2%     +23.3%      11160 ± 13%  softirqs.CPU52.SCHED
      9385 ±  3%     +25.2%      11752 ± 16%  softirqs.CPU53.SCHED
      9446 ±  6%     +24.9%      11798 ± 14%  softirqs.CPU54.SCHED
     10006 ±  6%     +22.4%      12249 ± 14%  softirqs.CPU55.SCHED
      9657           +22.0%      11780 ± 16%  softirqs.CPU57.SCHED
      9399           +27.5%      11980 ± 15%  softirqs.CPU58.SCHED
      9234 ±  3%     +27.7%      11795 ± 14%  softirqs.CPU59.SCHED
      9726 ±  6%     +24.0%      12062 ± 16%  softirqs.CPU6.SCHED
      9165 ±  2%     +23.7%      11342 ± 14%  softirqs.CPU60.SCHED
      9357 ±  2%     +25.8%      11774 ± 15%  softirqs.CPU61.SCHED
      9406 ±  3%     +25.2%      11780 ± 16%  softirqs.CPU62.SCHED
      9489           +23.2%      11688 ± 15%  softirqs.CPU63.SCHED
      9399 ±  2%     +23.5%      11604 ± 16%  softirqs.CPU65.SCHED
      8950 ±  2%     +31.6%      11774 ± 16%  softirqs.CPU66.SCHED
      9260           +21.7%      11267 ± 19%  softirqs.CPU67.SCHED
      9187           +27.1%      11672 ± 17%  softirqs.CPU68.SCHED
      9443 ±  2%     +25.5%      11847 ± 17%  softirqs.CPU69.SCHED
      9144 ±  3%     +28.0%      11706 ± 16%  softirqs.CPU7.SCHED
      9276 ±  2%     +28.0%      11871 ± 17%  softirqs.CPU70.SCHED
      9494           +21.4%      11526 ± 14%  softirqs.CPU71.SCHED
      9124 ±  3%     +27.8%      11657 ± 17%  softirqs.CPU72.SCHED
      9189 ±  3%     +25.9%      11568 ± 16%  softirqs.CPU73.SCHED
      9392 ±  2%     +23.7%      11619 ± 16%  softirqs.CPU74.SCHED
     17821 ±  3%     -14.7%      15197 ± 17%  softirqs.CPU78.SCHED
     17581 ±  2%     -15.7%      14827 ± 15%  softirqs.CPU79.SCHED
      9123           +28.2%      11695 ± 15%  softirqs.CPU8.SCHED
     17524 ±  2%     -16.7%      14601 ± 14%  softirqs.CPU80.SCHED
     17644 ±  3%     -16.2%      14782 ± 14%  softirqs.CPU81.SCHED
     17705 ±  3%     -18.6%      14414 ± 22%  softirqs.CPU84.SCHED
     17679 ±  2%     -14.1%      15185 ± 11%  softirqs.CPU85.SCHED
     17434 ±  3%     -15.5%      14724 ± 14%  softirqs.CPU86.SCHED
     17409 ±  2%     -15.0%      14794 ± 13%  softirqs.CPU87.SCHED
     17470 ±  3%     -15.7%      14730 ± 13%  softirqs.CPU88.SCHED
     17748 ±  4%     -17.1%      14721 ± 12%  softirqs.CPU89.SCHED
      9323           +28.0%      11929 ± 17%  softirqs.CPU9.SCHED
     17471 ±  2%     -16.9%      14525 ± 13%  softirqs.CPU90.SCHED
     17900 ±  3%     -17.0%      14850 ± 14%  softirqs.CPU94.SCHED
     17599 ±  4%     -17.4%      14544 ± 15%  softirqs.CPU95.SCHED
     17697 ±  4%     -17.7%      14569 ± 13%  softirqs.CPU96.SCHED
     17561 ±  3%     -15.1%      14901 ± 13%  softirqs.CPU97.SCHED
     17404 ±  3%     -16.1%      14601 ± 13%  softirqs.CPU98.SCHED
     17802 ±  3%     -19.4%      14344 ± 15%  softirqs.CPU99.SCHED
      1310 ± 10%     -17.0%       1088 ±  5%  interrupts.CPU1.RES:Rescheduling_interrupts
      3427           +13.3%       3883 ±  9%  interrupts.CPU10.CAL:Function_call_interrupts
    736.50 ± 20%     +34.4%     989.75 ± 17%  interrupts.CPU100.RES:Rescheduling_interrupts
      3421 ±  3%     +14.6%       3921 ±  9%  interrupts.CPU101.CAL:Function_call_interrupts
      4873 ±  8%     +16.2%       5662 ±  7%  interrupts.CPU101.NMI:Non-maskable_interrupts
      4873 ±  8%     +16.2%       5662 ±  7%  interrupts.CPU101.PMI:Performance_monitoring_interrupts
    629.50 ± 19%     +83.2%       1153 ± 46%  interrupts.CPU101.RES:Rescheduling_interrupts
    661.75 ± 14%     +25.7%     832.00 ± 13%  interrupts.CPU102.RES:Rescheduling_interrupts
      4695 ±  5%     +15.5%       5420 ±  9%  interrupts.CPU103.NMI:Non-maskable_interrupts
      4695 ±  5%     +15.5%       5420 ±  9%  interrupts.CPU103.PMI:Performance_monitoring_interrupts
      3460           +12.1%       3877 ±  9%  interrupts.CPU11.CAL:Function_call_interrupts
    691.50 ±  7%     +41.0%     975.00 ± 32%  interrupts.CPU19.RES:Rescheduling_interrupts
      3413 ±  2%     +13.4%       3870 ± 10%  interrupts.CPU20.CAL:Function_call_interrupts
      3413 ±  2%     +13.4%       3871 ± 10%  interrupts.CPU22.CAL:Function_call_interrupts
    863.00 ± 36%     +45.3%       1254 ± 24%  interrupts.CPU23.RES:Rescheduling_interrupts
    659.75 ± 12%     +83.4%       1209 ± 20%  interrupts.CPU26.RES:Rescheduling_interrupts
    615.00 ± 10%     +87.8%       1155 ± 14%  interrupts.CPU27.RES:Rescheduling_interrupts
    663.75 ±  5%     +67.9%       1114 ±  7%  interrupts.CPU28.RES:Rescheduling_interrupts
      3421 ±  4%     +13.4%       3879 ±  9%  interrupts.CPU29.CAL:Function_call_interrupts
    805.25 ± 16%     +33.0%       1071 ± 15%  interrupts.CPU29.RES:Rescheduling_interrupts
      3482 ±  3%     +11.0%       3864 ±  8%  interrupts.CPU3.CAL:Function_call_interrupts
    819.75 ± 19%     +48.4%       1216 ± 12%  interrupts.CPU30.RES:Rescheduling_interrupts
    777.25 ±  8%     +31.6%       1023 ±  6%  interrupts.CPU31.RES:Rescheduling_interrupts
    844.50 ± 25%     +41.7%       1196 ± 20%  interrupts.CPU32.RES:Rescheduling_interrupts
    722.75 ± 14%     +94.2%       1403 ± 26%  interrupts.CPU33.RES:Rescheduling_interrupts
      3944 ± 25%     +36.8%       5394 ±  9%  interrupts.CPU34.NMI:Non-maskable_interrupts
      3944 ± 25%     +36.8%       5394 ±  9%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
    781.75 ±  9%     +45.3%       1136 ± 27%  interrupts.CPU34.RES:Rescheduling_interrupts
    735.50 ±  9%     +33.3%     980.75 ±  4%  interrupts.CPU35.RES:Rescheduling_interrupts
    691.75 ± 10%     +41.6%     979.50 ± 13%  interrupts.CPU36.RES:Rescheduling_interrupts
    727.00 ± 16%     +47.7%       1074 ± 15%  interrupts.CPU37.RES:Rescheduling_interrupts
      4413 ±  7%     +24.9%       5511 ±  9%  interrupts.CPU38.NMI:Non-maskable_interrupts
      4413 ±  7%     +24.9%       5511 ±  9%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
    708.75 ± 25%     +62.6%       1152 ± 22%  interrupts.CPU38.RES:Rescheduling_interrupts
    666.50 ±  7%     +57.8%       1052 ± 13%  interrupts.CPU39.RES:Rescheduling_interrupts
    765.75 ± 11%     +25.2%     958.75 ± 14%  interrupts.CPU4.RES:Rescheduling_interrupts
      3395 ±  2%     +15.1%       3908 ± 10%  interrupts.CPU40.CAL:Function_call_interrupts
    770.00 ± 16%     +45.3%       1119 ± 18%  interrupts.CPU40.RES:Rescheduling_interrupts
    740.50 ± 26%     +61.9%       1198 ± 19%  interrupts.CPU41.RES:Rescheduling_interrupts
      3459 ±  2%     +12.9%       3905 ± 11%  interrupts.CPU42.CAL:Function_call_interrupts
      4530 ±  5%     +22.8%       5564 ±  9%  interrupts.CPU42.NMI:Non-maskable_interrupts
      4530 ±  5%     +22.8%       5564 ±  9%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
      3330 ± 25%     +60.0%       5328 ± 10%  interrupts.CPU44.NMI:Non-maskable_interrupts
      3330 ± 25%     +60.0%       5328 ± 10%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
    686.25 ±  9%     +48.4%       1018 ± 10%  interrupts.CPU44.RES:Rescheduling_interrupts
    702.00 ± 15%     +38.6%     973.25 ±  5%  interrupts.CPU45.RES:Rescheduling_interrupts
      4742 ±  7%     +19.3%       5657 ±  8%  interrupts.CPU46.NMI:Non-maskable_interrupts
      4742 ±  7%     +19.3%       5657 ±  8%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
    732.75 ±  6%     +51.9%       1113 ±  7%  interrupts.CPU46.RES:Rescheduling_interrupts
    775.50 ± 17%     +41.3%       1095 ±  6%  interrupts.CPU47.RES:Rescheduling_interrupts
    670.75 ±  5%     +60.7%       1078 ±  6%  interrupts.CPU48.RES:Rescheduling_interrupts
      4870 ±  8%     +16.5%       5676 ±  7%  interrupts.CPU49.NMI:Non-maskable_interrupts
      4870 ±  8%     +16.5%       5676 ±  7%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
    694.75 ± 12%     +25.8%     874.00 ± 11%  interrupts.CPU49.RES:Rescheduling_interrupts
    686.00 ±  9%     +52.0%       1042 ± 20%  interrupts.CPU50.RES:Rescheduling_interrupts
      3361           +17.2%       3938 ±  9%  interrupts.CPU51.CAL:Function_call_interrupts
      4707 ±  6%     +16.0%       5463 ±  8%  interrupts.CPU51.NMI:Non-maskable_interrupts
      4707 ±  6%     +16.0%       5463 ±  8%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
    638.75 ± 12%     +28.6%     821.25 ± 15%  interrupts.CPU54.RES:Rescheduling_interrupts
    677.50 ±  8%     +51.8%       1028 ± 29%  interrupts.CPU58.RES:Rescheduling_interrupts
      3465 ±  2%     +12.0%       3880 ±  9%  interrupts.CPU6.CAL:Function_call_interrupts
    641.25 ±  2%     +26.1%     808.75 ± 10%  interrupts.CPU60.RES:Rescheduling_interrupts
    599.75 ±  2%     +45.6%     873.50 ±  8%  interrupts.CPU62.RES:Rescheduling_interrupts
    661.50 ±  9%     +52.4%       1008 ± 27%  interrupts.CPU63.RES:Rescheduling_interrupts
    611.00 ± 12%     +31.1%     801.00 ± 13%  interrupts.CPU69.RES:Rescheduling_interrupts
      3507 ±  2%     +10.8%       3888 ±  9%  interrupts.CPU7.CAL:Function_call_interrupts
    664.00 ±  5%     +32.3%     878.50 ± 23%  interrupts.CPU70.RES:Rescheduling_interrupts
      5780 ±  9%     -38.8%       3540 ± 37%  interrupts.CPU73.NMI:Non-maskable_interrupts
      5780 ±  9%     -38.8%       3540 ± 37%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
      5787 ±  9%     -26.7%       4243 ± 28%  interrupts.CPU76.NMI:Non-maskable_interrupts
      5787 ±  9%     -26.7%       4243 ± 28%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
    751.50 ± 15%     +88.0%       1413 ± 37%  interrupts.CPU78.RES:Rescheduling_interrupts
    725.50 ± 12%     +82.9%       1327 ± 36%  interrupts.CPU79.RES:Rescheduling_interrupts
    714.00 ± 18%     +33.2%     951.00 ± 15%  interrupts.CPU80.RES:Rescheduling_interrupts
    706.25 ± 19%     +55.6%       1098 ± 27%  interrupts.CPU82.RES:Rescheduling_interrupts
      4524 ±  6%     +19.6%       5409 ±  8%  interrupts.CPU83.NMI:Non-maskable_interrupts
      4524 ±  6%     +19.6%       5409 ±  8%  interrupts.CPU83.PMI:Performance_monitoring_interrupts
    666.75 ± 15%     +37.3%     915.50 ±  4%  interrupts.CPU83.RES:Rescheduling_interrupts
    782.50 ± 26%     +57.6%       1233 ± 21%  interrupts.CPU84.RES:Rescheduling_interrupts
    622.75 ± 12%     +77.8%       1107 ± 17%  interrupts.CPU85.RES:Rescheduling_interrupts
      3465 ±  3%     +13.5%       3933 ±  9%  interrupts.CPU86.CAL:Function_call_interrupts
    714.75 ± 14%     +47.0%       1050 ± 10%  interrupts.CPU86.RES:Rescheduling_interrupts
      3519 ±  2%     +11.7%       3929 ±  9%  interrupts.CPU87.CAL:Function_call_interrupts
    582.75 ± 10%     +54.2%     898.75 ± 11%  interrupts.CPU87.RES:Rescheduling_interrupts
    713.00 ± 10%     +36.6%     974.25 ± 11%  interrupts.CPU88.RES:Rescheduling_interrupts
    690.50 ± 13%     +53.0%       1056 ± 13%  interrupts.CPU89.RES:Rescheduling_interrupts
      3477           +11.0%       3860 ±  8%  interrupts.CPU9.CAL:Function_call_interrupts
    684.50 ± 14%     +39.7%     956.25 ± 11%  interrupts.CPU90.RES:Rescheduling_interrupts
      3946 ± 21%     +39.8%       5516 ± 10%  interrupts.CPU91.NMI:Non-maskable_interrupts
      3946 ± 21%     +39.8%       5516 ± 10%  interrupts.CPU91.PMI:Performance_monitoring_interrupts
    649.00 ± 13%     +54.3%       1001 ±  6%  interrupts.CPU91.RES:Rescheduling_interrupts
    674.25 ± 21%     +39.5%     940.25 ± 11%  interrupts.CPU92.RES:Rescheduling_interrupts
      3971 ± 26%     +41.2%       5606 ±  8%  interrupts.CPU94.NMI:Non-maskable_interrupts
      3971 ± 26%     +41.2%       5606 ±  8%  interrupts.CPU94.PMI:Performance_monitoring_interrupts
      4129 ± 22%     +33.2%       5499 ±  9%  interrupts.CPU95.NMI:Non-maskable_interrupts
      4129 ± 22%     +33.2%       5499 ±  9%  interrupts.CPU95.PMI:Performance_monitoring_interrupts
    685.75 ± 14%     +38.0%     946.50 ±  9%  interrupts.CPU96.RES:Rescheduling_interrupts
      4630 ± 11%     +18.3%       5477 ±  8%  interrupts.CPU97.NMI:Non-maskable_interrupts
      4630 ± 11%     +18.3%       5477 ±  8%  interrupts.CPU97.PMI:Performance_monitoring_interrupts
      4835 ±  9%     +16.3%       5622 ±  9%  interrupts.CPU98.NMI:Non-maskable_interrupts
      4835 ±  9%     +16.3%       5622 ±  9%  interrupts.CPU98.PMI:Performance_monitoring_interrupts
    596.25 ± 11%     +81.8%       1083 ±  9%  interrupts.CPU98.RES:Rescheduling_interrupts
    674.75 ± 17%     +43.7%     969.50 ±  5%  interrupts.CPU99.RES:Rescheduling_interrupts
     78.25 ± 13%     +21.4%      95.00 ± 10%  interrupts.IWI:IRQ_work_interrupts
     85705 ±  6%     +26.0%     107990 ±  6%  interrupts.RES:Rescheduling_interrupts



***************************************************************************************************
lkp-bdw-ep6: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/sc_pid_max/tbox_group/testcase/testtime/ucode:
  scheduler/gcc-7/performance/1HDD/x86_64-rhel-7.6/100%/debian-x86_64-2019-11-14.cgz/4194304/lkp-bdw-ep6/stress-ng/1s/0xb000038

commit: 
  fcf0553db6 ("sched/fair: Remove meaningless imbalance calculation")
  0b0695f2b3 ("sched/fair: Rework load_balance()")

fcf0553db6f4c793 0b0695f2b34a4afa3f6e9aa1ff0 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    887157 ±  4%     -23.1%     682080 ±  3%  stress-ng.fault.ops
    887743 ±  4%     -23.1%     682337 ±  3%  stress-ng.fault.ops_per_sec
   9537184 ± 10%     -21.2%    7518352 ± 14%  stress-ng.hrtimers.ops_per_sec
    360922 ± 13%     -21.1%     284734 ±  6%  stress-ng.kill.ops
    361115 ± 13%     -21.1%     284810 ±  6%  stress-ng.kill.ops_per_sec
  23260649           -26.9%   17006477 ± 24%  stress-ng.mq.ops
  23255884           -26.9%   17004540 ± 24%  stress-ng.mq.ops_per_sec
   3291588 ±  3%     +42.5%    4690316 ±  2%  stress-ng.schedpolicy.ops
   3327913 ±  3%     +41.5%    4709770 ±  2%  stress-ng.schedpolicy.ops_per_sec
     48.14            -2.2%      47.09        stress-ng.time.elapsed_time
     48.14            -2.2%      47.09        stress-ng.time.elapsed_time.max
      5480            +3.7%       5681        stress-ng.time.percent_of_cpu_this_job_got
      2249            +1.3%       2278        stress-ng.time.system_time
    902759 ±  4%     -22.6%     698616 ±  3%  proc-vmstat.unevictable_pgs_culled
  98767954 ±  7%     +16.4%   1.15e+08 ±  7%  cpuidle.C1.time
   1181676 ± 12%     -43.2%     671022 ± 37%  cpuidle.C6.usage
      2.21 ±  7%      +0.4        2.62 ± 10%  turbostat.C1%
   1176838 ± 12%     -43.2%     668921 ± 37%  turbostat.C6
   3961223 ±  4%     +12.8%    4469620 ±  5%  vmstat.memory.cache
    439.50 ±  3%     +14.7%     504.00 ±  9%  vmstat.procs.r
      0.42 ±  7%     -15.6%       0.35 ± 13%  sched_debug.cfs_rq:/.nr_running.stddev
      0.00 ±  4%     -18.1%       0.00 ± 16%  sched_debug.cpu.next_balance.stddev
      0.41 ±  7%     -15.1%       0.35 ± 13%  sched_debug.cpu.nr_running.stddev
      9367 ±  9%     -12.8%       8166 ±  2%  softirqs.CPU1.SCHED
     35143 ±  6%     -12.0%      30930 ±  2%  softirqs.CPU22.TIMER
     31997 ±  4%      -7.5%      29595 ±  2%  softirqs.CPU27.TIMER
      3.64 ±173%    -100.0%       0.00        iostat.sda.await.max
      3.64 ±173%    -100.0%       0.00        iostat.sda.r_await.max
      3.90 ±173%    -100.0%       0.00        iostat.sdc.await.max
      3.90 ±173%    -100.0%       0.00        iostat.sdc.r_await.max
  12991737 ± 10%     +61.5%   20979642 ±  8%  numa-numastat.node0.local_node
  13073590 ± 10%     +61.1%   21059448 ±  8%  numa-numastat.node0.numa_hit
  20903562 ±  3%     -32.2%   14164789 ±  3%  numa-numastat.node1.local_node
  20993788 ±  3%     -32.1%   14245636 ±  3%  numa-numastat.node1.numa_hit
     90229 ±  4%     -10.4%      80843 ±  9%  numa-numastat.node1.other_node
     50.75 ± 90%   +1732.0%     929.75 ±147%  interrupts.CPU23.IWI:IRQ_work_interrupts
     40391 ± 59%     -57.0%      17359 ± 11%  interrupts.CPU24.RES:Rescheduling_interrupts
     65670 ± 11%     -48.7%      33716 ± 54%  interrupts.CPU42.RES:Rescheduling_interrupts
     42201 ± 46%     -57.1%      18121 ± 35%  interrupts.CPU49.RES:Rescheduling_interrupts
    293869 ± 44%    +103.5%     598082 ± 23%  interrupts.CPU52.LOC:Local_timer_interrupts
     17367 ±  8%    +120.5%      38299 ± 44%  interrupts.CPU55.RES:Rescheduling_interrupts
 1.127e+08            +3.8%   1.17e+08 ±  2%  perf-stat.i.branch-misses
     11.10            +1.2       12.26 ±  6%  perf-stat.i.cache-miss-rate%
 4.833e+10 ±  3%      +4.7%   5.06e+10        perf-stat.i.instructions
  15009442 ±  4%     +14.3%   17150138 ±  3%  perf-stat.i.node-load-misses
     47.12 ±  5%      +3.2       50.37 ±  5%  perf-stat.i.node-store-miss-rate%
   6016833 ±  7%     +17.0%    7036803 ±  3%  perf-stat.i.node-store-misses
 1.044e+10 ±  2%      +4.0%  1.086e+10        perf-stat.ps.branch-instructions
 1.364e+10 ±  3%      +4.0%  1.418e+10        perf-stat.ps.dTLB-loads
 4.804e+10 ±  2%      +4.1%  5.003e+10        perf-stat.ps.instructions
  14785608 ±  5%     +11.3%   16451530 ±  3%  perf-stat.ps.node-load-misses
   5968712 ±  7%     +13.4%    6769847 ±  3%  perf-stat.ps.node-store-misses
     13588 ±  4%     +29.4%      17585 ±  9%  slabinfo.Acpi-State.active_objs
     13588 ±  4%     +29.4%      17585 ±  9%  slabinfo.Acpi-State.num_objs
     20859 ±  3%      -8.6%      19060 ±  4%  slabinfo.kmalloc-192.num_objs
    488.00 ± 25%     +41.0%     688.00 ±  5%  slabinfo.kmalloc-rcl-128.active_objs
    488.00 ± 25%     +41.0%     688.00 ±  5%  slabinfo.kmalloc-rcl-128.num_objs
     39660 ±  3%     +11.8%      44348 ±  2%  slabinfo.radix_tree_node.active_objs
     44284 ±  3%     +12.3%      49720        slabinfo.radix_tree_node.num_objs
      5811 ± 15%     +16.1%       6746 ± 14%  slabinfo.sighand_cache.active_objs
    402.00 ± 15%     +17.5%     472.50 ± 14%  slabinfo.sighand_cache.active_slabs
      6035 ± 15%     +17.5%       7091 ± 14%  slabinfo.sighand_cache.num_objs
    402.00 ± 15%     +17.5%     472.50 ± 14%  slabinfo.sighand_cache.num_slabs
     10282 ± 10%     +12.9%      11604 ±  9%  slabinfo.signal_cache.active_objs
     11350 ± 10%     +12.8%      12808 ±  9%  slabinfo.signal_cache.num_objs
    732920 ±  9%    +162.0%    1919987 ± 11%  numa-meminfo.node0.Active
    732868 ±  9%    +162.0%    1919814 ± 11%  numa-meminfo.node0.Active(anon)
    545019 ±  6%     +61.0%     877443 ± 17%  numa-meminfo.node0.AnonHugePages
    695015 ± 10%     +46.8%    1020150 ± 14%  numa-meminfo.node0.AnonPages
    638322 ±  4%    +448.2%    3499399 ±  5%  numa-meminfo.node0.FilePages
     81008 ± 14%   +2443.4%    2060329 ±  3%  numa-meminfo.node0.Inactive
     80866 ± 14%   +2447.4%    2060022 ±  3%  numa-meminfo.node0.Inactive(anon)
     86504 ± 10%   +2287.3%    2065084 ±  3%  numa-meminfo.node0.Mapped
   2010104          +160.8%    5242366 ±  5%  numa-meminfo.node0.MemUsed
     16453 ± 15%    +159.2%      42640        numa-meminfo.node0.PageTables
    112769 ± 13%   +2521.1%    2955821 ±  7%  numa-meminfo.node0.Shmem
   1839527 ±  4%     -60.2%     732645 ± 23%  numa-meminfo.node1.Active
   1839399 ±  4%     -60.2%     732637 ± 23%  numa-meminfo.node1.Active(anon)
    982237 ±  7%     -45.9%     531445 ± 27%  numa-meminfo.node1.AnonHugePages
   1149348 ±  8%     -41.2%     676067 ± 25%  numa-meminfo.node1.AnonPages
   3170649 ±  4%     -77.2%     723230 ±  7%  numa-meminfo.node1.FilePages
   1960718 ±  4%     -91.8%     160773 ± 31%  numa-meminfo.node1.Inactive
   1960515 ±  4%     -91.8%     160722 ± 31%  numa-meminfo.node1.Inactive(anon)
    118489 ± 11%     -20.2%      94603 ±  3%  numa-meminfo.node1.KReclaimable
   1966065 ±  4%     -91.5%     166789 ± 29%  numa-meminfo.node1.Mapped
   5034310 ±  3%     -60.2%    2003121 ±  9%  numa-meminfo.node1.MemUsed
     42684 ± 10%     -64.2%      15283 ± 21%  numa-meminfo.node1.PageTables
    118489 ± 11%     -20.2%      94603 ±  3%  numa-meminfo.node1.SReclaimable
   2644708 ±  5%     -91.9%     214268 ± 24%  numa-meminfo.node1.Shmem
    147513 ± 20%    +244.2%     507737 ±  7%  numa-vmstat.node0.nr_active_anon
    137512 ± 21%    +105.8%     282999 ±  3%  numa-vmstat.node0.nr_anon_pages
    210.25 ± 33%    +124.7%     472.50 ± 11%  numa-vmstat.node0.nr_anon_transparent_hugepages
    158008 ±  4%    +454.7%     876519 ±  6%  numa-vmstat.node0.nr_file_pages
     18416 ± 27%   +2711.4%     517747 ±  3%  numa-vmstat.node0.nr_inactive_anon
     26255 ± 22%     +34.3%      35251 ± 10%  numa-vmstat.node0.nr_kernel_stack
     19893 ± 23%   +2509.5%     519129 ±  3%  numa-vmstat.node0.nr_mapped
      3928 ± 22%    +179.4%      10976 ±  4%  numa-vmstat.node0.nr_page_table_pages
     26623 ± 18%   +2681.9%     740635 ±  7%  numa-vmstat.node0.nr_shmem
    147520 ± 20%    +244.3%     507885 ±  7%  numa-vmstat.node0.nr_zone_active_anon
     18415 ± 27%   +2711.5%     517739 ±  3%  numa-vmstat.node0.nr_zone_inactive_anon
   6937137 ±  8%     +55.9%   10814957 ±  7%  numa-vmstat.node0.numa_hit
   6860210 ±  8%     +56.6%   10739902 ±  7%  numa-vmstat.node0.numa_local
    425559 ± 13%     -52.9%     200300 ± 17%  numa-vmstat.node1.nr_active_anon
    786341 ±  4%     -76.6%     183664 ±  7%  numa-vmstat.node1.nr_file_pages
    483646 ±  4%     -90.8%      44606 ± 29%  numa-vmstat.node1.nr_inactive_anon
    485120 ±  4%     -90.5%      46130 ± 27%  numa-vmstat.node1.nr_mapped
     10471 ±  6%     -61.3%       4048 ± 18%  numa-vmstat.node1.nr_page_table_pages
    654852 ±  5%     -91.4%      56439 ± 25%  numa-vmstat.node1.nr_shmem
     29681 ± 11%     -20.3%      23669 ±  3%  numa-vmstat.node1.nr_slab_reclaimable
    425556 ± 13%     -52.9%     200359 ± 17%  numa-vmstat.node1.nr_zone_active_anon
    483649 ±  4%     -90.8%      44600 ± 29%  numa-vmstat.node1.nr_zone_inactive_anon
  10527487 ±  5%     -31.3%    7233899 ±  6%  numa-vmstat.node1.numa_hit
  10290625 ±  5%     -31.9%    7006050 ±  7%  numa-vmstat.node1.numa_local



***************************************************************************************************
lkp-csl-2sp5: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/testcase/testtime/ucode:
  interrupt/gcc-7/performance/1HDD/x86_64-fedora-25/100%/debian-x86_64-2019-11-14.cgz/lkp-csl-2sp5/stress-ng/1s/0x500002c

commit: 
  fcf0553db6 ("sched/fair: Remove meaningless imbalance calculation")
  0b0695f2b3 ("sched/fair: Rework load_balance()")

fcf0553db6f4c793 0b0695f2b34a4afa3f6e9aa1ff0 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   6684836           -33.3%    4457559 ±  4%  stress-ng.schedpolicy.ops
   6684766           -33.3%    4457633 ±  4%  stress-ng.schedpolicy.ops_per_sec
  19978129           -28.8%   14231813 ± 16%  stress-ng.time.involuntary_context_switches
     82.49 ±  2%      -5.2%      78.23        stress-ng.time.user_time
    106716 ± 29%     +40.3%     149697 ±  2%  meminfo.max_used_kB
      4.07 ± 22%      +1.2        5.23 ±  5%  mpstat.cpu.all.irq%
   2721317 ± 10%     +66.5%    4531100 ± 22%  cpuidle.POLL.time
     71470 ± 18%     +41.1%     100822 ± 11%  cpuidle.POLL.usage
    841.00 ± 41%     -50.4%     417.25 ± 17%  numa-meminfo.node0.Dirty
      7096 ±  7%     +25.8%       8930 ±  9%  numa-meminfo.node1.KernelStack
     68752 ± 90%     -45.9%      37169 ±143%  sched_debug.cfs_rq:/.runnable_weight.stddev
    654.93 ± 11%     +19.3%     781.09 ±  2%  sched_debug.cpu.clock_task.stddev
    183.06 ± 83%     -76.9%      42.20 ± 17%  iostat.sda.await.max
    627.47 ±102%     -96.7%      20.52 ± 38%  iostat.sda.r_await.max
    183.08 ± 83%     -76.9%      42.24 ± 17%  iostat.sda.w_await.max
    209.00 ± 41%     -50.2%     104.00 ± 17%  numa-vmstat.node0.nr_dirty
    209.50 ± 41%     -50.4%     104.00 ± 17%  numa-vmstat.node0.nr_zone_write_pending
      6792 ±  8%     +34.4%       9131 ±  7%  numa-vmstat.node1.nr_kernel_stack
      3.57 ±173%      +9.8       13.38 ± 25%  perf-profile.calltrace.cycles-pp.proc_reg_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.57 ±173%      +9.8       13.38 ± 25%  perf-profile.calltrace.cycles-pp.seq_read.proc_reg_read.vfs_read.ksys_read.do_syscall_64
      3.57 ±173%      +9.8       13.39 ± 25%  perf-profile.children.cycles-pp.proc_reg_read
      3.57 ±173%     +12.6       16.16 ± 28%  perf-profile.children.cycles-pp.seq_read
      7948 ± 56%     -53.1%       3730 ±  5%  softirqs.CPU25.RCU
      6701 ± 33%     -46.7%       3570 ±  5%  softirqs.CPU34.RCU
      8232 ± 89%     -60.5%       3247        softirqs.CPU50.RCU
    326269 ± 16%     -27.4%     236940        softirqs.RCU
     68066            +7.9%      73438        proc-vmstat.nr_active_anon
     67504            +7.8%      72783        proc-vmstat.nr_anon_pages
      7198 ± 19%     +34.2%       9658 ±  2%  proc-vmstat.nr_page_table_pages
     40664 ±  8%     +10.1%      44766        proc-vmstat.nr_slab_unreclaimable
     68066            +7.9%      73438        proc-vmstat.nr_zone_active_anon
   1980169 ±  4%      -5.3%    1875307        proc-vmstat.numa_hit
   1960247 ±  4%      -5.4%    1855033        proc-vmstat.numa_local
    956008 ± 16%     -17.8%     786247        proc-vmstat.pgfault
     26598 ± 76%    +301.2%     106716 ± 45%  interrupts.CPU1.RES:Rescheduling_interrupts
    151212 ± 39%     -67.3%      49451 ± 57%  interrupts.CPU26.RES:Rescheduling_interrupts
   1013586 ±  2%     -10.9%     903528 ±  7%  interrupts.CPU27.LOC:Local_timer_interrupts
   1000980 ±  2%     -11.4%     886740 ±  8%  interrupts.CPU31.LOC:Local_timer_interrupts
   1021043 ±  3%      -9.9%     919686 ±  6%  interrupts.CPU32.LOC:Local_timer_interrupts
    125222 ± 51%     -86.0%      17483 ±106%  interrupts.CPU33.RES:Rescheduling_interrupts
   1003735 ±  2%     -11.1%     891833 ±  8%  interrupts.CPU34.LOC:Local_timer_interrupts
   1021799 ±  2%     -13.2%     886665 ±  8%  interrupts.CPU38.LOC:Local_timer_interrupts
    997788 ±  2%     -13.2%     866427 ± 10%  interrupts.CPU42.LOC:Local_timer_interrupts
   1001618           -11.6%     885490 ±  9%  interrupts.CPU45.LOC:Local_timer_interrupts
     22321 ± 58%    +550.3%     145153 ± 22%  interrupts.CPU9.RES:Rescheduling_interrupts
      3151 ± 53%     +67.3%       5273 ±  8%  slabinfo.avc_xperms_data.active_objs
      3151 ± 53%     +67.3%       5273 ±  8%  slabinfo.avc_xperms_data.num_objs
    348.75 ± 13%     +39.8%     487.50 ±  5%  slabinfo.biovec-128.active_objs
    348.75 ± 13%     +39.8%     487.50 ±  5%  slabinfo.biovec-128.num_objs
     13422 ± 97%    +121.1%      29678 ±  2%  slabinfo.btrfs_extent_map.active_objs
     14638 ± 98%    +117.8%      31888 ±  2%  slabinfo.btrfs_extent_map.num_objs
      3835 ± 18%     +40.9%       5404 ±  7%  slabinfo.dmaengine-unmap-16.active_objs
      3924 ± 18%     +39.9%       5490 ±  8%  slabinfo.dmaengine-unmap-16.num_objs
      3482 ± 96%    +119.1%       7631 ± 10%  slabinfo.khugepaged_mm_slot.active_objs
      3573 ± 96%    +119.4%       7839 ± 10%  slabinfo.khugepaged_mm_slot.num_objs
      8629 ± 52%     -49.2%       4384        slabinfo.kmalloc-rcl-64.active_objs
      8629 ± 52%     -49.2%       4384        slabinfo.kmalloc-rcl-64.num_objs
      2309 ± 57%     +82.1%       4206 ±  5%  slabinfo.mnt_cache.active_objs
      2336 ± 57%     +80.8%       4224 ±  5%  slabinfo.mnt_cache.num_objs
      5320 ± 48%     +69.1%       8999 ± 23%  slabinfo.pool_workqueue.active_objs
    165.75 ± 48%     +69.4%     280.75 ± 23%  slabinfo.pool_workqueue.active_slabs
      5320 ± 48%     +69.2%       8999 ± 23%  slabinfo.pool_workqueue.num_objs
    165.75 ± 48%     +69.4%     280.75 ± 23%  slabinfo.pool_workqueue.num_slabs
      3306 ± 15%     +27.0%       4199 ±  3%  slabinfo.task_group.active_objs
      3333 ± 16%     +30.1%       4336 ±  3%  slabinfo.task_group.num_objs
     14.74 ±  2%      +1.8       16.53 ±  2%  perf-stat.i.cache-miss-rate%
  22459727 ± 20%     +46.7%   32955572 ±  4%  perf-stat.i.cache-misses
     33575 ± 19%     +68.8%      56658 ± 13%  perf-stat.i.cpu-migrations
      0.03 ± 20%      +0.0        0.05 ±  8%  perf-stat.i.dTLB-load-miss-rate%
   6351703 ± 33%     +47.2%    9352532 ±  9%  perf-stat.i.dTLB-load-misses
      0.45 ±  3%      -3.0%       0.44        perf-stat.i.ipc
   4711345 ± 18%     +43.9%    6780944 ±  7%  perf-stat.i.node-load-misses
     82.51            +4.5       86.97        perf-stat.i.node-store-miss-rate%
   2861142 ± 31%     +60.8%    4601146 ±  5%  perf-stat.i.node-store-misses
      0.92 ±  6%      -0.1        0.85 ±  2%  perf-stat.overall.branch-miss-rate%
      0.02 ±  3%      +0.0        0.02 ±  4%  perf-stat.overall.dTLB-store-miss-rate%
    715.05 ±  5%      +9.9%     785.50 ±  4%  perf-stat.overall.instructions-per-iTLB-miss
      0.44 ±  2%      -5.4%       0.42 ±  2%  perf-stat.overall.ipc
     79.67            +2.1       81.80 ±  2%  perf-stat.overall.node-store-miss-rate%
  22237897 ± 19%     +46.4%   32560557 ±  5%  perf-stat.ps.cache-misses
     32491 ± 18%     +70.5%      55390 ± 13%  perf-stat.ps.cpu-migrations
   6071108 ± 31%     +45.0%    8804767 ±  9%  perf-stat.ps.dTLB-load-misses
      1866 ± 98%     -91.9%     150.48 ±  2%  perf-stat.ps.major-faults
   4593546 ± 16%     +42.4%    6541402 ±  7%  perf-stat.ps.node-load-misses
   2757176 ± 29%     +58.4%    4368169 ±  5%  perf-stat.ps.node-store-misses
 1.303e+12 ±  3%      -9.8%  1.175e+12 ±  3%  perf-stat.total.instructions



***************************************************************************************************
lkp-bdw-ep6: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/testcase/testtime/ucode:
  interrupt/gcc-7/performance/1HDD/x86_64-rhel-7.6/100%/debian-x86_64-2019-11-14.cgz/lkp-bdw-ep6/stress-ng/30s/0xb000038

commit: 
  fcf0553db6 ("sched/fair: Remove meaningless imbalance calculation")
  0b0695f2b3 ("sched/fair: Rework load_balance()")

fcf0553db6f4c793 0b0695f2b34a4afa3f6e9aa1ff0 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          1:4          -25%            :4     dmesg.WARNING:at#for_ip_interrupt_entry/0x
         %stddev     %change         %stddev
             \          |                \  
  98245522           +42.3%  1.398e+08        stress-ng.schedpolicy.ops
   3274860           +42.3%    4661027        stress-ng.schedpolicy.ops_per_sec
 3.473e+08            -9.7%  3.137e+08        stress-ng.sigq.ops
  11576537            -9.7%   10454846        stress-ng.sigq.ops_per_sec
  38097605 ±  6%     +10.3%   42011440 ±  4%  stress-ng.sigrt.ops
   1269646 ±  6%     +10.3%    1400024 ±  4%  stress-ng.sigrt.ops_per_sec
 3.628e+08 ±  4%     -21.5%  2.848e+08 ± 10%  stress-ng.time.involuntary_context_switches
      7040            +2.9%       7245        stress-ng.time.percent_of_cpu_this_job_got
     15.09 ±  3%     -13.4%      13.07 ±  5%  iostat.cpu.idle
     14.82 ±  3%      -2.0       12.80 ±  5%  mpstat.cpu.all.idle%
 3.333e+08 ± 17%     +59.9%  5.331e+08 ± 22%  cpuidle.C1.time
   5985148 ± 23%    +112.5%   12719679 ± 20%  cpuidle.C1E.usage
     14.50 ±  3%     -12.1%      12.75 ±  6%  vmstat.cpu.id
   1113131 ±  2%     -10.5%     996285 ±  3%  vmstat.system.cs
      2269            +2.4%       2324        turbostat.Avg_MHz
      0.64 ± 17%      +0.4        1.02 ± 23%  turbostat.C1%
   5984799 ± 23%    +112.5%   12719086 ± 20%  turbostat.C1E
      4.17 ± 32%     -46.0%       2.25 ± 38%  turbostat.Pkg%pc2
    216.57            +2.1%     221.12        turbostat.PkgWatt
     13.33 ±  3%      +3.9%      13.84        turbostat.RAMWatt
     99920           +13.6%     113486 ± 15%  proc-vmstat.nr_active_anon
      5738            +1.2%       5806        proc-vmstat.nr_inactive_anon
     46788            +2.1%      47749        proc-vmstat.nr_slab_unreclaimable
     99920           +13.6%     113486 ± 15%  proc-vmstat.nr_zone_active_anon
      5738            +1.2%       5806        proc-vmstat.nr_zone_inactive_anon
      3150 ±  2%     +35.4%       4265 ± 33%  proc-vmstat.numa_huge_pte_updates
   1641223           +34.3%    2203844 ± 32%  proc-vmstat.numa_pte_updates
     13575 ± 18%     +62.1%      21999 ±  4%  slabinfo.ext4_extent_status.active_objs
     13954 ± 17%     +57.7%      21999 ±  4%  slabinfo.ext4_extent_status.num_objs
      2527 ±  4%      +9.8%       2774 ±  2%  slabinfo.khugepaged_mm_slot.active_objs
      2527 ±  4%      +9.8%       2774 ±  2%  slabinfo.khugepaged_mm_slot.num_objs
     57547 ±  8%     -15.3%      48743 ±  9%  slabinfo.kmalloc-rcl-64.active_objs
    898.75 ±  8%     -15.3%     761.00 ±  9%  slabinfo.kmalloc-rcl-64.active_slabs
     57547 ±  8%     -15.3%      48743 ±  9%  slabinfo.kmalloc-rcl-64.num_objs
    898.75 ±  8%     -15.3%     761.00 ±  9%  slabinfo.kmalloc-rcl-64.num_slabs
 1.014e+10            +1.7%  1.031e+10        perf-stat.i.branch-instructions
     13.37 ±  4%      +2.0       15.33 ±  3%  perf-stat.i.cache-miss-rate%
 1.965e+11            +2.6%  2.015e+11        perf-stat.i.cpu-cycles
  20057708 ±  4%     +13.9%   22841468 ±  4%  perf-stat.i.iTLB-loads
 4.973e+10            +1.4%  5.042e+10        perf-stat.i.instructions
      3272 ±  2%      +2.9%       3366        perf-stat.i.minor-faults
   4500892 ±  3%     +18.9%    5351518 ±  6%  perf-stat.i.node-store-misses
      3.91            +1.3%       3.96        perf-stat.overall.cpi
     69.62            -1.5       68.11        perf-stat.overall.iTLB-load-miss-rate%
 1.047e+10            +1.3%  1.061e+10        perf-stat.ps.branch-instructions
   1117454 ±  2%     -10.6%     999467 ±  3%  perf-stat.ps.context-switches
 1.986e+11            +2.4%  2.033e+11        perf-stat.ps.cpu-cycles
  19614413 ±  4%     +13.6%   22288555 ±  4%  perf-stat.ps.iTLB-loads
      3493            -1.1%       3453        perf-stat.ps.minor-faults
   4546636 ±  3%     +17.0%    5321658 ±  5%  perf-stat.ps.node-store-misses
      0.64 ±  3%      -0.2        0.44 ± 57%  perf-profile.calltrace.cycles-pp.common_timer_get.do_timer_gettime.__x64_sys_timer_gettime.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.66 ±  3%      -0.1        0.58 ±  7%  perf-profile.children.cycles-pp.common_timer_get
      0.44 ±  4%      -0.1        0.39 ±  5%  perf-profile.children.cycles-pp.posix_ktime_get_ts
      0.39 ±  5%      -0.0        0.34 ±  6%  perf-profile.children.cycles-pp.ktime_get_ts64
      0.07 ± 17%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.task_tick_fair
      0.08 ± 15%      +0.0        0.11 ±  7%  perf-profile.children.cycles-pp.scheduler_tick
      0.46 ±  5%      +0.1        0.54 ±  6%  perf-profile.children.cycles-pp.__might_sleep
      0.69 ±  8%      +0.2        0.85 ± 12%  perf-profile.children.cycles-pp.___might_sleep
      0.90 ±  5%      -0.2        0.73 ±  9%  perf-profile.self.cycles-pp.__might_fault
      0.40 ±  6%      -0.1        0.33 ±  9%  perf-profile.self.cycles-pp.do_timer_gettime
      0.50 ±  4%      -0.1        0.45 ±  7%  perf-profile.self.cycles-pp.put_itimerspec64
      0.32 ±  2%      -0.0        0.27 ±  9%  perf-profile.self.cycles-pp.update_curr_fair
      0.20 ±  6%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.ktime_get_ts64
      0.08 ± 23%      +0.0        0.12 ±  8%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.42 ±  5%      +0.1        0.50 ±  6%  perf-profile.self.cycles-pp.__might_sleep
      0.66 ±  9%      +0.2        0.82 ± 12%  perf-profile.self.cycles-pp.___might_sleep
     47297 ± 13%     +19.7%      56608 ±  5%  softirqs.CPU13.SCHED
     47070 ±  3%     +20.5%      56735 ±  7%  softirqs.CPU2.SCHED
     55443 ±  9%     -20.2%      44250 ±  2%  softirqs.CPU28.SCHED
     56633 ±  3%     -12.6%      49520 ±  7%  softirqs.CPU34.SCHED
     56599 ± 11%     -18.0%      46384 ±  2%  softirqs.CPU36.SCHED
     56909 ±  9%     -18.4%      46438 ±  6%  softirqs.CPU40.SCHED
     45062 ±  9%     +28.1%      57709 ±  9%  softirqs.CPU45.SCHED
     43959           +28.7%      56593 ±  9%  softirqs.CPU49.SCHED
     46235 ± 10%     +22.2%      56506 ± 11%  softirqs.CPU5.SCHED
     44779 ± 12%     +22.5%      54859 ± 11%  softirqs.CPU57.SCHED
     46739 ± 10%     +21.1%      56579 ±  8%  softirqs.CPU6.SCHED
     53129 ±  4%     -13.1%      46149 ±  8%  softirqs.CPU70.SCHED
     55822 ±  7%     -20.5%      44389 ±  8%  softirqs.CPU73.SCHED
     56011 ±  5%     -11.4%      49610 ±  7%  softirqs.CPU77.SCHED
     55263 ±  9%     -13.2%      47942 ± 12%  softirqs.CPU78.SCHED
     58792 ± 14%     -21.3%      46291 ±  9%  softirqs.CPU81.SCHED
     53341 ±  7%     -13.7%      46041 ± 10%  softirqs.CPU83.SCHED
     59096 ± 15%     -23.9%      44998 ±  6%  softirqs.CPU85.SCHED
     36647           -98.5%     543.00 ± 61%  numa-meminfo.node0.Active(file)
    620922 ±  4%     -10.4%     556566 ±  5%  numa-meminfo.node0.FilePages
     21243 ±  3%     -36.2%      13543 ± 41%  numa-meminfo.node0.Inactive
     20802 ±  3%     -35.3%      13455 ± 42%  numa-meminfo.node0.Inactive(anon)
     15374 ±  9%     -27.2%      11193 ±  8%  numa-meminfo.node0.KernelStack
     21573           -34.7%      14084 ± 14%  numa-meminfo.node0.Mapped
   1136795 ±  5%     -12.4%     995965 ±  6%  numa-meminfo.node0.MemUsed
     16420 ±  6%     -66.0%       5580 ± 18%  numa-meminfo.node0.PageTables
    108182 ±  2%     -18.5%      88150 ±  3%  numa-meminfo.node0.SUnreclaim
    166467 ±  2%     -15.8%     140184 ±  4%  numa-meminfo.node0.Slab
    181705 ± 36%     +63.8%     297623 ± 10%  numa-meminfo.node1.Active
    320.75 ± 27%  +11187.0%      36203        numa-meminfo.node1.Active(file)
      2208 ± 38%    +362.1%      10207 ± 54%  numa-meminfo.node1.Inactive
      2150 ± 39%    +356.0%       9804 ± 58%  numa-meminfo.node1.Inactive(anon)
     41819 ± 10%     +17.3%      49068 ±  6%  numa-meminfo.node1.KReclaimable
     11711 ±  5%     +47.2%      17238 ± 22%  numa-meminfo.node1.KernelStack
     10642           +68.3%      17911 ± 11%  numa-meminfo.node1.Mapped
    952520 ±  6%     +20.3%    1146337 ±  3%  numa-meminfo.node1.MemUsed
     12342 ± 15%     +92.4%      23741 ±  9%  numa-meminfo.node1.PageTables
     41819 ± 10%     +17.3%      49068 ±  6%  numa-meminfo.node1.SReclaimable
     80394 ±  3%     +27.1%     102206 ±  3%  numa-meminfo.node1.SUnreclaim
    122214 ±  3%     +23.8%     151275 ±  3%  numa-meminfo.node1.Slab
      9160           -98.5%     135.25 ± 61%  numa-vmstat.node0.nr_active_file
    155223 ±  4%     -10.4%     139122 ±  5%  numa-vmstat.node0.nr_file_pages
      5202 ±  3%     -35.4%       3362 ± 42%  numa-vmstat.node0.nr_inactive_anon
    109.50 ± 14%     -80.1%      21.75 ±160%  numa-vmstat.node0.nr_inactive_file
     14757 ±  3%     -34.4%       9676 ± 12%  numa-vmstat.node0.nr_kernel_stack
      5455           -34.9%       3549 ± 12%  numa-vmstat.node0.nr_mapped
      4069 ±  6%     -68.3%       1289 ± 24%  numa-vmstat.node0.nr_page_table_pages
     26943 ±  2%     -19.2%      21761 ±  3%  numa-vmstat.node0.nr_slab_unreclaimable
      2240 ±  6%     -97.8%      49.00 ± 69%  numa-vmstat.node0.nr_written
      9160           -98.5%     135.25 ± 61%  numa-vmstat.node0.nr_zone_active_file
      5202 ±  3%     -35.4%       3362 ± 42%  numa-vmstat.node0.nr_zone_inactive_anon
    109.50 ± 14%     -80.1%      21.75 ±160%  numa-vmstat.node0.nr_zone_inactive_file
     79.75 ± 28%  +11247.0%       9049        numa-vmstat.node1.nr_active_file
    542.25 ± 41%    +352.1%       2451 ± 58%  numa-vmstat.node1.nr_inactive_anon
     14.00 ±140%    +617.9%     100.50 ± 35%  numa-vmstat.node1.nr_inactive_file
     11182 ±  4%     +28.9%      14415 ±  4%  numa-vmstat.node1.nr_kernel_stack
      2728 ±  3%     +67.7%       4576 ±  9%  numa-vmstat.node1.nr_mapped
      3056 ± 15%     +88.2%       5754 ±  8%  numa-vmstat.node1.nr_page_table_pages
     10454 ± 10%     +17.3%      12262 ±  7%  numa-vmstat.node1.nr_slab_reclaimable
     20006 ±  3%     +25.0%      25016 ±  3%  numa-vmstat.node1.nr_slab_unreclaimable
     19.00 ± 52%  +11859.2%       2272 ±  2%  numa-vmstat.node1.nr_written
     79.75 ± 28%  +11247.0%       9049        numa-vmstat.node1.nr_zone_active_file
    542.25 ± 41%    +352.1%       2451 ± 58%  numa-vmstat.node1.nr_zone_inactive_anon
     14.00 ±140%    +617.9%     100.50 ± 35%  numa-vmstat.node1.nr_zone_inactive_file
    173580 ± 21%    +349.5%     780280 ±  7%  sched_debug.cfs_rq:/.MIN_vruntime.avg
   6891819 ± 37%    +109.1%   14412817 ±  9%  sched_debug.cfs_rq:/.MIN_vruntime.max
   1031500 ± 25%    +189.1%    2982452 ±  8%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
    149079           +13.6%     169354 ±  2%  sched_debug.cfs_rq:/.exec_clock.min
      8550 ±  3%     -59.7%       3442 ± 32%  sched_debug.cfs_rq:/.exec_clock.stddev
      4.95 ±  6%     -15.2%       4.20 ± 10%  sched_debug.cfs_rq:/.load_avg.min
    173580 ± 21%    +349.5%     780280 ±  7%  sched_debug.cfs_rq:/.max_vruntime.avg
   6891819 ± 37%    +109.1%   14412817 ±  9%  sched_debug.cfs_rq:/.max_vruntime.max
   1031500 ± 25%    +189.1%    2982452 ±  8%  sched_debug.cfs_rq:/.max_vruntime.stddev
  16144141           +27.9%   20645199 ±  6%  sched_debug.cfs_rq:/.min_vruntime.avg
  17660392           +27.7%   22546402 ±  4%  sched_debug.cfs_rq:/.min_vruntime.max
  13747718           +36.8%   18802595 ±  5%  sched_debug.cfs_rq:/.min_vruntime.min
      0.17 ± 11%     +35.0%       0.22 ± 15%  sched_debug.cfs_rq:/.nr_running.stddev
     10.64 ± 14%     -26.4%       7.83 ± 12%  sched_debug.cpu.clock.stddev
     10.64 ± 14%     -26.4%       7.83 ± 12%  sched_debug.cpu.clock_task.stddev
      7093 ± 42%     -65.9%       2420 ±120%  sched_debug.cpu.curr->pid.min
   2434979 ±  2%     -18.6%    1981697 ±  3%  sched_debug.cpu.nr_switches.avg
   3993189 ±  6%     -22.2%    3104832 ±  5%  sched_debug.cpu.nr_switches.max
   -145.03           -42.8%     -82.90        sched_debug.cpu.nr_uninterruptible.min
   2097122 ±  6%     +38.7%    2908923 ±  6%  sched_debug.cpu.sched_count.min
    809684 ± 13%     -30.5%     562929 ± 17%  sched_debug.cpu.sched_count.stddev
    307565 ±  4%     -15.1%     261231 ±  3%  sched_debug.cpu.ttwu_count.min
    207286 ±  6%     -16.4%     173387 ±  3%  sched_debug.cpu.ttwu_local.min
    125963 ± 23%     +53.1%     192849 ±  2%  sched_debug.cpu.ttwu_local.stddev
   2527246           +10.8%    2800959 ±  3%  sched_debug.cpu.yld_count.avg
   1294266 ±  4%     +53.7%    1989264 ±  2%  sched_debug.cpu.yld_count.min
    621332 ±  9%     -38.4%     382813 ± 22%  sched_debug.cpu.yld_count.stddev
    899.50 ± 28%     -48.2%     465.75 ± 42%  interrupts.37:IR-PCI-MSI.1572868-edge.eth0-TxRx-3
    372.50 ±  7%    +169.5%       1004 ± 40%  interrupts.40:IR-PCI-MSI.1572871-edge.eth0-TxRx-6
      6201 ±  8%     +17.9%       7309 ±  3%  interrupts.CPU0.CAL:Function_call_interrupts
    653368 ± 47%    +159.4%    1695029 ± 17%  interrupts.CPU0.RES:Rescheduling_interrupts
      7104 ±  7%     +13.6%       8067        interrupts.CPU1.CAL:Function_call_interrupts
      2094 ± 59%     +89.1%       3962 ± 10%  interrupts.CPU10.TLB:TLB_shootdowns
      7309 ±  8%     +11.2%       8125        interrupts.CPU11.CAL:Function_call_interrupts
      2089 ± 62%     +86.2%       3890 ± 11%  interrupts.CPU13.TLB:TLB_shootdowns
      7068 ±  8%     +15.2%       8144 ±  2%  interrupts.CPU14.CAL:Function_call_interrupts
      7112 ±  7%     +13.6%       8079 ±  3%  interrupts.CPU15.CAL:Function_call_interrupts
      1950 ± 61%    +103.5%       3968 ± 11%  interrupts.CPU15.TLB:TLB_shootdowns
    899.50 ± 28%     -48.2%     465.75 ± 42%  interrupts.CPU16.37:IR-PCI-MSI.1572868-edge.eth0-TxRx-3
      2252 ± 47%     +62.6%       3664 ± 15%  interrupts.CPU16.TLB:TLB_shootdowns
      7111 ±  8%     +14.8%       8167 ±  3%  interrupts.CPU18.CAL:Function_call_interrupts
      1972 ± 60%     +96.3%       3872 ±  9%  interrupts.CPU18.TLB:TLB_shootdowns
    372.50 ±  7%    +169.5%       1004 ± 40%  interrupts.CPU19.40:IR-PCI-MSI.1572871-edge.eth0-TxRx-6
      2942 ± 12%     -57.5%       1251 ± 22%  interrupts.CPU22.TLB:TLB_shootdowns
      7819           -12.2%       6861 ±  3%  interrupts.CPU23.CAL:Function_call_interrupts
      3327 ± 12%     -62.7%       1241 ± 29%  interrupts.CPU23.TLB:TLB_shootdowns
      7767 ±  3%     -14.0%       6683 ±  5%  interrupts.CPU24.CAL:Function_call_interrupts
      3185 ± 21%     -63.8%       1154 ± 14%  interrupts.CPU24.TLB:TLB_shootdowns
      7679 ±  4%     -11.3%       6812 ±  2%  interrupts.CPU25.CAL:Function_call_interrupts
      3004 ± 28%     -63.4%       1100 ±  7%  interrupts.CPU25.TLB:TLB_shootdowns
      3187 ± 17%     -61.3%       1232 ± 35%  interrupts.CPU26.TLB:TLB_shootdowns
      3193 ± 16%     -59.3%       1299 ± 34%  interrupts.CPU27.TLB:TLB_shootdowns
      3059 ± 21%     -58.0%       1285 ± 32%  interrupts.CPU28.TLB:TLB_shootdowns
      7798 ±  4%     -13.8%       6719 ±  7%  interrupts.CPU29.CAL:Function_call_interrupts
      3122 ± 20%     -62.3%       1178 ± 37%  interrupts.CPU29.TLB:TLB_shootdowns
      7727 ±  2%     -11.6%       6827 ±  5%  interrupts.CPU30.CAL:Function_call_interrupts
      3102 ± 18%     -59.4%       1259 ± 33%  interrupts.CPU30.TLB:TLB_shootdowns
      3269 ± 24%     -58.1%       1371 ± 48%  interrupts.CPU31.TLB:TLB_shootdowns
      7918 ±  3%     -14.5%       6771        interrupts.CPU32.CAL:Function_call_interrupts
      3324 ± 18%     -70.7%     973.50 ± 18%  interrupts.CPU32.TLB:TLB_shootdowns
      2817 ± 27%     -60.2%       1121 ± 26%  interrupts.CPU33.TLB:TLB_shootdowns
      7956 ±  3%     -11.8%       7018 ±  4%  interrupts.CPU34.CAL:Function_call_interrupts
      3426 ± 21%     -70.3%       1018 ± 29%  interrupts.CPU34.TLB:TLB_shootdowns
      3121 ± 17%     -70.3%     926.75 ± 22%  interrupts.CPU35.TLB:TLB_shootdowns
      7596 ±  4%     -10.6%       6793 ±  3%  interrupts.CPU36.CAL:Function_call_interrupts
      2900 ± 30%     -62.3%       1094 ± 34%  interrupts.CPU36.TLB:TLB_shootdowns
      7863           -13.1%       6833 ±  2%  interrupts.CPU37.CAL:Function_call_interrupts
      3259 ± 15%     -65.9%       1111 ± 20%  interrupts.CPU37.TLB:TLB_shootdowns
      3230 ± 26%     -64.0%       1163 ± 39%  interrupts.CPU38.TLB:TLB_shootdowns
      7728 ±  5%     -13.8%       6662 ±  7%  interrupts.CPU39.CAL:Function_call_interrupts
      2950 ± 29%     -61.6%       1133 ± 26%  interrupts.CPU39.TLB:TLB_shootdowns
      6864 ±  3%     +18.7%       8147        interrupts.CPU4.CAL:Function_call_interrupts
      1847 ± 59%    +118.7%       4039 ±  7%  interrupts.CPU4.TLB:TLB_shootdowns
      7951 ±  6%     -15.0%       6760 ±  2%  interrupts.CPU40.CAL:Function_call_interrupts
      3200 ± 30%     -72.3%     886.50 ± 39%  interrupts.CPU40.TLB:TLB_shootdowns
      7819 ±  6%     -11.3%       6933 ±  2%  interrupts.CPU41.CAL:Function_call_interrupts
      3149 ± 28%     -62.9%       1169 ± 24%  interrupts.CPU41.TLB:TLB_shootdowns
      7884 ±  4%     -11.0%       7019 ±  2%  interrupts.CPU42.CAL:Function_call_interrupts
      3248 ± 16%     -63.4%       1190 ± 23%  interrupts.CPU42.TLB:TLB_shootdowns
      7659 ±  5%     -12.7%       6690 ±  3%  interrupts.CPU43.CAL:Function_call_interrupts
    490732 ± 20%    +114.5%    1052606 ± 47%  interrupts.CPU43.RES:Rescheduling_interrupts
   1432688 ± 34%     -67.4%     467217 ± 43%  interrupts.CPU47.RES:Rescheduling_interrupts
      7122 ±  8%     +16.0%       8259 ±  3%  interrupts.CPU48.CAL:Function_call_interrupts
      1868 ± 65%    +118.4%       4079 ±  8%  interrupts.CPU48.TLB:TLB_shootdowns
      7165 ±  8%     +11.3%       7977 ±  5%  interrupts.CPU49.CAL:Function_call_interrupts
      1961 ± 59%     +98.4%       3891 ±  4%  interrupts.CPU49.TLB:TLB_shootdowns
    461807 ± 47%    +190.8%    1342990 ± 48%  interrupts.CPU5.RES:Rescheduling_interrupts
      7167 ±  7%     +15.4%       8273        interrupts.CPU50.CAL:Function_call_interrupts
      2027 ± 51%    +103.9%       4134 ±  8%  interrupts.CPU50.TLB:TLB_shootdowns
      7163 ±  9%     +16.3%       8328        interrupts.CPU51.CAL:Function_call_interrupts
    660073 ± 33%     +74.0%    1148640 ± 25%  interrupts.CPU51.RES:Rescheduling_interrupts
      2043 ± 64%     +95.8%       4000 ±  5%  interrupts.CPU51.TLB:TLB_shootdowns
      7428 ±  9%     +13.5%       8434 ±  2%  interrupts.CPU52.CAL:Function_call_interrupts
      2280 ± 61%     +85.8%       4236 ±  9%  interrupts.CPU52.TLB:TLB_shootdowns
      7144 ± 11%     +17.8%       8413        interrupts.CPU53.CAL:Function_call_interrupts
      1967 ± 67%    +104.7%       4026 ±  5%  interrupts.CPU53.TLB:TLB_shootdowns
      7264 ± 10%     +15.6%       8394 ±  4%  interrupts.CPU54.CAL:Function_call_interrupts
      7045 ± 11%     +18.7%       8365 ±  2%  interrupts.CPU56.CAL:Function_call_interrupts
      2109 ± 59%     +91.6%       4041 ± 10%  interrupts.CPU56.TLB:TLB_shootdowns
      7307 ±  9%     +15.3%       8428 ±  2%  interrupts.CPU57.CAL:Function_call_interrupts
      2078 ± 64%     +96.5%       4085 ±  6%  interrupts.CPU57.TLB:TLB_shootdowns
      6834 ± 12%     +19.8%       8190 ±  3%  interrupts.CPU58.CAL:Function_call_interrupts
    612496 ± 85%    +122.5%    1362815 ± 27%  interrupts.CPU58.RES:Rescheduling_interrupts
      1884 ± 69%    +112.0%       3995 ±  8%  interrupts.CPU58.TLB:TLB_shootdowns
      7185 ±  8%     +15.9%       8329        interrupts.CPU59.CAL:Function_call_interrupts
      1982 ± 58%    +101.1%       3986 ±  5%  interrupts.CPU59.TLB:TLB_shootdowns
      7051 ±  6%     +13.1%       7975        interrupts.CPU6.CAL:Function_call_interrupts
      1831 ± 49%    +102.1%       3701 ±  8%  interrupts.CPU6.TLB:TLB_shootdowns
      7356 ±  8%     +16.2%       8548        interrupts.CPU60.CAL:Function_call_interrupts
      2124 ± 57%     +92.8%       4096 ±  5%  interrupts.CPU60.TLB:TLB_shootdowns
      7243 ±  9%     +15.1%       8334        interrupts.CPU61.CAL:Function_call_interrupts
    572423 ± 71%    +110.0%    1201919 ± 40%  interrupts.CPU61.RES:Rescheduling_interrupts
      7295 ±  9%     +14.7%       8369        interrupts.CPU63.CAL:Function_call_interrupts
      2139 ± 57%     +85.7%       3971 ±  3%  interrupts.CPU63.TLB:TLB_shootdowns
      7964 ±  2%     -15.6%       6726 ±  5%  interrupts.CPU66.CAL:Function_call_interrupts
      3198 ± 21%     -65.0%       1119 ± 24%  interrupts.CPU66.TLB:TLB_shootdowns
      8103 ±  2%     -17.5%       6687 ±  9%  interrupts.CPU67.CAL:Function_call_interrupts
      3357 ± 18%     -62.9%       1244 ± 32%  interrupts.CPU67.TLB:TLB_shootdowns
      7772 ±  2%     -14.0%       6687 ±  8%  interrupts.CPU68.CAL:Function_call_interrupts
      2983 ± 17%     -59.2%       1217 ± 15%  interrupts.CPU68.TLB:TLB_shootdowns
      7986 ±  4%     -13.8%       6887 ±  4%  interrupts.CPU69.CAL:Function_call_interrupts
      3192 ± 24%     -65.0%       1117 ± 30%  interrupts.CPU69.TLB:TLB_shootdowns
      7070 ±  6%     +14.6%       8100 ±  2%  interrupts.CPU7.CAL:Function_call_interrupts
    697891 ± 32%     +54.4%    1077890 ± 18%  interrupts.CPU7.RES:Rescheduling_interrupts
      1998 ± 55%     +97.1%       3938 ± 10%  interrupts.CPU7.TLB:TLB_shootdowns
      8085           -13.4%       7002 ±  3%  interrupts.CPU70.CAL:Function_call_interrupts
   1064985 ± 35%     -62.5%     398986 ± 29%  interrupts.CPU70.RES:Rescheduling_interrupts
      3347 ± 12%     -61.7%       1280 ± 24%  interrupts.CPU70.TLB:TLB_shootdowns
      2916 ± 16%     -58.8%       1201 ± 39%  interrupts.CPU71.TLB:TLB_shootdowns
      3314 ± 19%     -61.3%       1281 ± 26%  interrupts.CPU72.TLB:TLB_shootdowns
      3119 ± 18%     -61.5%       1200 ± 39%  interrupts.CPU73.TLB:TLB_shootdowns
      7992 ±  4%     -12.6%       6984 ±  3%  interrupts.CPU74.CAL:Function_call_interrupts
      3187 ± 21%     -56.8%       1378 ± 40%  interrupts.CPU74.TLB:TLB_shootdowns
      7953 ±  4%     -12.0%       6999 ±  4%  interrupts.CPU75.CAL:Function_call_interrupts
      3072 ± 26%     -56.8%       1327 ± 34%  interrupts.CPU75.TLB:TLB_shootdowns
      8119 ±  5%     -12.4%       7109 ±  7%  interrupts.CPU76.CAL:Function_call_interrupts
      3418 ± 20%     -67.5%       1111 ± 31%  interrupts.CPU76.TLB:TLB_shootdowns
      7804 ±  5%     -11.4%       6916 ±  4%  interrupts.CPU77.CAL:Function_call_interrupts
      7976 ±  5%     -14.4%       6826 ±  3%  interrupts.CPU78.CAL:Function_call_interrupts
      3209 ± 27%     -71.8%     904.75 ± 28%  interrupts.CPU78.TLB:TLB_shootdowns
      8187 ±  4%     -14.6%       6991 ±  3%  interrupts.CPU79.CAL:Function_call_interrupts
      3458 ± 20%     -67.5%       1125 ± 36%  interrupts.CPU79.TLB:TLB_shootdowns
      7122 ±  7%     +14.2%       8136 ±  2%  interrupts.CPU8.CAL:Function_call_interrupts
      2096 ± 63%     +87.4%       3928 ±  8%  interrupts.CPU8.TLB:TLB_shootdowns
      8130 ±  5%     -17.2%       6728 ±  5%  interrupts.CPU81.CAL:Function_call_interrupts
      3253 ± 24%     -70.6%     955.00 ± 38%  interrupts.CPU81.TLB:TLB_shootdowns
      7940 ±  5%     -13.9%       6839 ±  5%  interrupts.CPU82.CAL:Function_call_interrupts
      2952 ± 26%     -66.3%     996.00 ± 51%  interrupts.CPU82.TLB:TLB_shootdowns
      7900 ±  6%     -13.4%       6844 ±  3%  interrupts.CPU83.CAL:Function_call_interrupts
      3012 ± 34%     -68.3%     956.00 ± 17%  interrupts.CPU83.TLB:TLB_shootdowns
      7952 ±  6%     -15.8%       6695 ±  2%  interrupts.CPU84.CAL:Function_call_interrupts
      3049 ± 31%     -75.5%     746.50 ± 27%  interrupts.CPU84.TLB:TLB_shootdowns
      8065 ±  6%     -15.7%       6798        interrupts.CPU85.CAL:Function_call_interrupts
      3222 ± 23%     -69.7%     976.00 ± 13%  interrupts.CPU85.TLB:TLB_shootdowns
      8049 ±  5%     -13.2%       6983 ±  4%  interrupts.CPU86.CAL:Function_call_interrupts
      3159 ± 19%     -61.9%       1202 ± 27%  interrupts.CPU86.TLB:TLB_shootdowns
      8154 ±  8%     -16.9%       6773 ±  3%  interrupts.CPU87.CAL:Function_call_interrupts
   1432962 ± 21%     -48.5%     737989 ± 30%  interrupts.CPU87.RES:Rescheduling_interrupts
      3186 ± 33%     -72.3%     881.75 ± 21%  interrupts.CPU87.TLB:TLB_shootdowns



***************************************************************************************************
lkp-bdw-ep6: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/testcase/testtime/ucode:
  interrupt/gcc-7/performance/1HDD/x86_64-rhel-7.6/100%/debian-x86_64-2019-11-14.cgz/lkp-bdw-ep6/stress-ng/1s/0xb000038

commit: 
  fcf0553db6 ("sched/fair: Remove meaningless imbalance calculation")
  0b0695f2b3 ("sched/fair: Rework load_balance()")

fcf0553db6f4c793 0b0695f2b34a4afa3f6e9aa1ff0 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   3345449           +35.1%    4518187 ±  5%  stress-ng.schedpolicy.ops
   3347036           +35.1%    4520740 ±  5%  stress-ng.schedpolicy.ops_per_sec
  11464910 ±  6%     -23.3%    8796455 ± 11%  stress-ng.sigq.ops
  11452565 ±  6%     -23.3%    8786844 ± 11%  stress-ng.sigq.ops_per_sec
    228736           +20.7%     276087 ± 20%  stress-ng.sleep.ops
    157479           +23.0%     193722 ± 21%  stress-ng.sleep.ops_per_sec
  14584704            -5.8%   13744640 ±  4%  stress-ng.timerfd.ops
  14546032            -5.7%   13718862 ±  4%  stress-ng.timerfd.ops_per_sec
     27.24 ±105%    +283.9%     104.58 ±109%  iostat.sdb.r_await.max
    122324 ± 35%     +63.9%     200505 ± 21%  meminfo.AnonHugePages
     47267 ± 26%    +155.2%     120638 ± 45%  numa-meminfo.node1.AnonHugePages
     22880 ±  6%      -9.9%      20605 ±  3%  softirqs.CPU57.TIMER
    636196 ± 24%     +38.5%     880847 ±  7%  cpuidle.C1.usage
  55936214 ± 20%     +63.9%   91684673 ± 18%  cpuidle.C1E.time
 1.175e+08 ± 22%    +101.8%  2.372e+08 ± 29%  cpuidle.C3.time
 4.242e+08 ±  6%     -39.1%  2.584e+08 ± 39%  cpuidle.C6.time
     59.50 ± 34%     +66.0%      98.75 ± 22%  proc-vmstat.nr_anon_transparent_hugepages
     25612 ± 10%     +13.8%      29146 ±  4%  proc-vmstat.nr_kernel_stack
   2783465 ±  9%     +14.5%    3187157 ±  9%  proc-vmstat.pgalloc_normal
      1743 ± 28%     +43.8%       2507 ± 23%  proc-vmstat.thp_deferred_split_page
      1765 ± 30%     +43.2%       2529 ± 22%  proc-vmstat.thp_fault_alloc
    811.00 ±  3%     -13.8%     699.00 ±  7%  slabinfo.kmem_cache_node.active_objs
    864.00 ±  3%     -13.0%     752.00 ±  7%  slabinfo.kmem_cache_node.num_objs
      8686 ±  7%     +13.6%       9869 ±  3%  slabinfo.pid.active_objs
      8690 ±  7%     +13.8%       9890 ±  3%  slabinfo.pid.num_objs
      9813 ±  6%     +15.7%      11352 ±  3%  slabinfo.task_delay_info.active_objs
      9813 ±  6%     +15.7%      11352 ±  3%  slabinfo.task_delay_info.num_objs
     79.22 ± 10%     -41.1%      46.68 ± 22%  sched_debug.cfs_rq:/.load_avg.avg
    242.49 ±  6%     -29.6%     170.70 ± 17%  sched_debug.cfs_rq:/.load_avg.stddev
     43.14 ± 29%     -67.1%      14.18 ± 66%  sched_debug.cfs_rq:/.removed.load_avg.avg
    201.73 ± 15%     -50.1%     100.68 ± 60%  sched_debug.cfs_rq:/.removed.load_avg.stddev
      1987 ± 28%     -67.3%     650.09 ± 66%  sched_debug.cfs_rq:/.removed.runnable_sum.avg
      9298 ± 15%     -50.3%       4616 ± 60%  sched_debug.cfs_rq:/.removed.runnable_sum.stddev
     18.17 ± 27%     -68.6%       5.70 ± 63%  sched_debug.cfs_rq:/.removed.util_avg.avg
     87.61 ± 13%     -52.6%      41.48 ± 59%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    633327 ± 24%     +38.4%     876596 ±  7%  turbostat.C1
      2.75 ± 22%      +1.8        4.52 ± 17%  turbostat.C1E%
      5.76 ± 22%      +6.1       11.82 ± 30%  turbostat.C3%
     20.69 ±  5%      -8.1       12.63 ± 38%  turbostat.C6%
     15.62 ±  6%     +18.4%      18.50 ±  8%  turbostat.CPU%c1
      1.56 ± 16%    +208.5%       4.82 ± 38%  turbostat.CPU%c3
     12.81 ±  4%     -48.1%       6.65 ± 43%  turbostat.CPU%c6
      5.02 ±  8%     -34.6%       3.28 ± 14%  turbostat.Pkg%pc2
      0.85 ± 57%     -84.7%       0.13 ±173%  turbostat.Pkg%pc6
     88.25 ± 13%    +262.6%     320.00 ± 71%  interrupts.CPU10.TLB:TLB_shootdowns
    116.25 ± 36%    +151.6%     292.50 ± 68%  interrupts.CPU19.TLB:TLB_shootdowns
    109.25 ±  8%    +217.4%     346.75 ±106%  interrupts.CPU2.TLB:TLB_shootdowns
     15180 ±111%    +303.9%      61314 ± 32%  interrupts.CPU23.RES:Rescheduling_interrupts
    111.50 ± 26%    +210.3%     346.00 ± 79%  interrupts.CPU3.TLB:TLB_shootdowns
     86.50 ± 35%    +413.0%     443.75 ± 66%  interrupts.CPU33.TLB:TLB_shootdowns
    728.00 ±  8%     +29.6%     943.50 ± 16%  interrupts.CPU38.CAL:Function_call_interrupts
      1070 ± 72%     +84.9%       1979 ±  9%  interrupts.CPU54.76:IR-PCI-MSI.512000-edge.ahci[0000:00:1f.2]
     41429 ± 64%     -73.7%      10882 ± 73%  interrupts.CPU59.RES:Rescheduling_interrupts
     26330 ± 85%     -73.3%       7022 ± 86%  interrupts.CPU62.RES:Rescheduling_interrupts
    103.00 ± 22%    +181.3%     289.75 ± 92%  interrupts.CPU65.TLB:TLB_shootdowns
    100.00 ± 40%    +365.0%     465.00 ± 71%  interrupts.CPU70.TLB:TLB_shootdowns
    110.25 ± 18%    +308.4%     450.25 ± 71%  interrupts.CPU80.TLB:TLB_shootdowns
     93.50 ± 42%    +355.1%     425.50 ± 82%  interrupts.CPU84.TLB:TLB_shootdowns
    104.50 ± 18%    +289.7%     407.25 ± 68%  interrupts.CPU87.TLB:TLB_shootdowns
      1.76 ±  3%      -0.1        1.66 ±  4%  perf-stat.i.branch-miss-rate%
      8.08 ±  6%      +2.0       10.04        perf-stat.i.cache-miss-rate%
  18031213 ±  4%     +27.2%   22939937 ±  3%  perf-stat.i.cache-misses
 4.041e+08            -1.9%  3.965e+08        perf-stat.i.cache-references
     31764 ± 26%     -40.6%      18859 ± 10%  perf-stat.i.cycles-between-cache-misses
     66.18            -1.5       64.71        perf-stat.i.iTLB-load-miss-rate%
   4503482 ±  8%     +19.5%    5382698 ±  5%  perf-stat.i.node-load-misses
   3892859 ±  2%     +16.6%    4538750 ±  4%  perf-stat.i.node-store-misses
   1526815 ± 13%     +25.8%    1921178 ±  9%  perf-stat.i.node-stores
      4.72 ±  4%      +1.3        6.00 ±  3%  perf-stat.overall.cache-miss-rate%
      9120 ±  6%     -18.9%       7394 ±  2%  perf-stat.overall.cycles-between-cache-misses
  18237318 ±  4%     +25.4%   22866104 ±  3%  perf-stat.ps.cache-misses
   4392089 ±  8%     +18.1%    5189251 ±  5%  perf-stat.ps.node-load-misses
   1629766 ±  2%     +17.9%    1920947 ± 13%  perf-stat.ps.node-loads
   3694566 ±  2%     +16.1%    4288126 ±  4%  perf-stat.ps.node-store-misses
   1536866 ± 12%     +23.7%    1901141 ±  7%  perf-stat.ps.node-stores
     38.20 ± 18%     -13.2       24.96 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     38.20 ± 18%     -13.2       24.96 ± 10%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.98 ± 67%      -7.2        0.73 ±173%  perf-profile.calltrace.cycles-pp.smp_call_function_single.event_function_call.perf_remove_from_context.perf_event_release_kernel.perf_release
      7.98 ± 67%      -7.2        0.73 ±173%  perf-profile.calltrace.cycles-pp.event_function_call.perf_remove_from_context.perf_event_release_kernel.perf_release.__fput
      7.98 ± 67%      -7.2        0.73 ±173%  perf-profile.calltrace.cycles-pp.perf_remove_from_context.perf_event_release_kernel.perf_release.__fput.task_work_run
     11.86 ± 41%      -6.8        5.07 ± 62%  perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.86 ± 41%      -6.8        5.07 ± 62%  perf-profile.calltrace.cycles-pp.do_signal.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.86 ± 41%      -6.8        5.07 ± 62%  perf-profile.calltrace.cycles-pp.get_signal.do_signal.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.86 ± 41%      -6.8        5.07 ± 62%  perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.do_signal.exit_to_usermode_loop.do_syscall_64
     11.86 ± 41%      -6.8        5.07 ± 62%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.do_signal.exit_to_usermode_loop
     11.86 ± 41%      -6.8        5.07 ± 62%  perf-profile.calltrace.cycles-pp.task_work_run.do_exit.do_group_exit.get_signal.do_signal
      4.27 ± 66%      -3.5        0.73 ±173%  perf-profile.calltrace.cycles-pp.read
      4.05 ± 71%      -3.3        0.73 ±173%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      4.05 ± 71%      -3.3        0.73 ±173%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     13.30 ± 38%      -8.2        5.07 ± 62%  perf-profile.children.cycles-pp.task_work_run
     12.47 ± 46%      -7.4        5.07 ± 62%  perf-profile.children.cycles-pp.exit_to_usermode_loop
     12.47 ± 46%      -7.4        5.07 ± 62%  perf-profile.children.cycles-pp.__fput
      7.98 ± 67%      -7.2        0.73 ±173%  perf-profile.children.cycles-pp.perf_remove_from_context
     11.86 ± 41%      -6.8        5.07 ± 62%  perf-profile.children.cycles-pp.do_signal
     11.86 ± 41%      -6.8        5.07 ± 62%  perf-profile.children.cycles-pp.get_signal
      9.43 ± 21%      -4.7        4.72 ± 67%  perf-profile.children.cycles-pp.ksys_read
      9.43 ± 21%      -4.7        4.72 ± 67%  perf-profile.children.cycles-pp.vfs_read
      4.27 ± 66%      -3.5        0.73 ±173%  perf-profile.children.cycles-pp.read
      3.86 ±101%      -3.1        0.71 ±173%  perf-profile.children.cycles-pp._raw_spin_lock
      3.86 ±101%      -3.1        0.71 ±173%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      3.86 ±101%      -3.1        0.71 ±173%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



***************************************************************************************************
lkp-csl-2sp5: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/testcase/testtime/ucode:
  os/gcc-7/performance/1HDD/ext4/x86_64-rhel-7.6/100%/debian-x86_64-2019-09-23.cgz/lkp-csl-2sp5/stress-ng/1s/0x500002b

commit: 
  fcf0553db6 ("sched/fair: Remove meaningless imbalance calculation")
  0b0695f2b3 ("sched/fair: Rework load_balance()")

fcf0553db6f4c793 0b0695f2b34a4afa3f6e9aa1ff0 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :2           50%           1:8     dmesg.WARNING:at_ip_selinux_file_ioctl/0x
         %stddev     %change         %stddev
             \          |                \  
    122451 ± 11%     -19.9%      98072 ± 15%  stress-ng.ioprio.ops
    116979 ± 11%     -20.7%      92815 ± 16%  stress-ng.ioprio.ops_per_sec
    274187 ± 21%     -26.7%     201013 ± 11%  stress-ng.kill.ops
    274219 ± 21%     -26.7%     201040 ± 11%  stress-ng.kill.ops_per_sec
   3973765           -10.1%    3570462 ±  5%  stress-ng.lockf.ops
   3972581           -10.2%    3568935 ±  5%  stress-ng.lockf.ops_per_sec
     10719 ±  8%     -39.9%       6442 ± 22%  stress-ng.procfs.ops
      9683 ±  3%     -39.3%       5878 ± 22%  stress-ng.procfs.ops_per_sec
   6562721           -35.1%    4260609 ±  8%  stress-ng.schedpolicy.ops
   6564233           -35.1%    4261479 ±  8%  stress-ng.schedpolicy.ops_per_sec
   1070988           +21.4%    1299977 ±  7%  stress-ng.sigrt.ops
   1061773           +21.2%    1286618 ±  7%  stress-ng.sigrt.ops_per_sec
   1155684 ±  5%     -14.8%     984531 ± 16%  stress-ng.symlink.ops
    991624 ±  4%     -23.8%     755147 ± 41%  stress-ng.symlink.ops_per_sec
      6925           -12.1%       6086 ± 27%  stress-ng.time.percent_of_cpu_this_job_got
     24.68            +9.3       33.96 ± 52%  mpstat.cpu.all.idle%
    171.00 ±  2%     -55.3%      76.50 ± 60%  numa-vmstat.node1.nr_inactive_file
    171.00 ±  2%     -55.3%      76.50 ± 60%  numa-vmstat.node1.nr_zone_inactive_file
 2.032e+11           -12.5%  1.777e+11 ± 27%  perf-stat.i.cpu-cycles
 2.025e+11           -12.0%  1.782e+11 ± 27%  perf-stat.ps.cpu-cycles
     25.00           +37.5%      34.38 ± 51%  vmstat.cpu.id
     68.00           -13.2%      59.00 ± 27%  vmstat.cpu.sy
     25.24           +37.0%      34.57 ± 51%  iostat.cpu.idle
     68.21           -12.7%      59.53 ± 27%  iostat.cpu.system
      4.31 ±100%    +200.6%      12.96 ± 63%  iostat.sda.r_await.max
      1014 ±  2%     -17.1%     841.00 ± 10%  meminfo.Inactive(file)
     30692 ± 12%     -20.9%      24280 ± 30%  meminfo.Mlocked
    103627 ± 27%     -32.7%      69720        meminfo.Percpu
    255.50 ±  2%     -18.1%     209.25 ± 10%  proc-vmstat.nr_inactive_file
    255.50 ±  2%     -18.1%     209.25 ± 10%  proc-vmstat.nr_zone_inactive_file
    185035 ± 22%     -22.2%     143917 ± 25%  proc-vmstat.pgmigrate_success
      2107           -12.3%       1848 ± 27%  turbostat.Avg_MHz
     69.00            -7.1%      64.12 ±  8%  turbostat.PkgTmp
     94.63            -2.2%      92.58 ±  4%  turbostat.RAMWatt
     96048           +26.8%     121800 ±  8%  softirqs.CPU10.NET_RX
     96671 ±  4%     +34.2%     129776 ±  6%  softirqs.CPU15.NET_RX
    171243 ±  3%     -12.9%     149135 ±  8%  softirqs.CPU25.NET_RX
    165317 ±  4%     -11.4%     146494 ±  9%  softirqs.CPU27.NET_RX
    139558           -24.5%     105430 ± 14%  softirqs.CPU58.NET_RX
    147836           -15.8%     124408 ±  6%  softirqs.CPU63.NET_RX
    129568           -13.8%     111624 ± 10%  softirqs.CPU66.NET_RX
      1050 ±  2%     +14.2%       1198 ±  9%  slabinfo.biovec-128.active_objs
      1050 ±  2%     +14.2%       1198 ±  9%  slabinfo.biovec-128.num_objs
     23129           +19.6%      27668 ±  6%  slabinfo.kmalloc-512.active_objs
    766.50           +17.4%     899.75 ±  6%  slabinfo.kmalloc-512.active_slabs
     24535           +17.4%      28806 ±  6%  slabinfo.kmalloc-512.num_objs
    766.50           +17.4%     899.75 ±  6%  slabinfo.kmalloc-512.num_slabs
      1039 ±  4%      -4.3%     994.12 ±  6%  slabinfo.sock_inode_cache.active_slabs
     40527 ±  4%      -4.3%      38785 ±  6%  slabinfo.sock_inode_cache.num_objs
      1039 ±  4%      -4.3%     994.12 ±  6%  slabinfo.sock_inode_cache.num_slabs
   1549456           -43.6%     873443 ± 24%  sched_debug.cfs_rq:/.min_vruntime.stddev
     73.25 ±  5%     +74.8%     128.03 ± 31%  sched_debug.cfs_rq:/.nr_spread_over.stddev
     18.60 ± 57%     -63.8%       6.73 ± 64%  sched_debug.cfs_rq:/.removed.load_avg.avg
     79.57 ± 44%     -44.1%      44.52 ± 55%  sched_debug.cfs_rq:/.removed.load_avg.stddev
    857.10 ± 57%     -63.8%     310.09 ± 64%  sched_debug.cfs_rq:/.removed.runnable_sum.avg
      3664 ± 44%     -44.1%       2049 ± 55%  sched_debug.cfs_rq:/.removed.runnable_sum.stddev
      4.91 ± 42%     -45.3%       2.69 ± 61%  sched_debug.cfs_rq:/.removed.util_avg.avg
   1549544           -43.6%     874006 ± 24%  sched_debug.cfs_rq:/.spread0.stddev
    786.14 ±  6%     -20.1%     628.46 ± 23%  sched_debug.cfs_rq:/.util_avg.avg
      1415 ±  8%     -16.7%       1178 ± 18%  sched_debug.cfs_rq:/.util_avg.max
    467435 ± 15%     +46.7%     685829 ± 15%  sched_debug.cpu.avg_idle.avg
     17972 ±  8%    +631.2%     131410 ± 34%  sched_debug.cpu.avg_idle.min
      7.66 ± 26%    +209.7%      23.72 ± 54%  sched_debug.cpu.clock.stddev
      7.66 ± 26%    +209.7%      23.72 ± 54%  sched_debug.cpu.clock_task.stddev
    618063 ±  5%     -17.0%     513085 ±  5%  sched_debug.cpu.max_idle_balance_cost.max
     12083 ± 28%     -85.4%       1768 ±231%  sched_debug.cpu.max_idle_balance_cost.stddev
     12857 ± 16%   +2117.7%     285128 ±106%  sched_debug.cpu.yld_count.min
      0.55 ±  6%      -0.2        0.37 ± 51%  perf-profile.children.cycles-pp.fpregs_assert_state_consistent
      0.30 ± 21%      -0.2        0.14 ±105%  perf-profile.children.cycles-pp.yield_task_fair
      0.32 ±  6%      -0.2        0.16 ± 86%  perf-profile.children.cycles-pp.rmap_walk_anon
      0.19            -0.1        0.10 ± 86%  perf-profile.children.cycles-pp.page_mapcount_is_zero
      0.19            -0.1        0.10 ± 86%  perf-profile.children.cycles-pp.total_mapcount
      0.14            -0.1        0.09 ± 29%  perf-profile.children.cycles-pp.start_kernel
      0.11 ±  9%      -0.0        0.07 ± 47%  perf-profile.children.cycles-pp.__switch_to
      0.10 ± 14%      -0.0        0.06 ± 45%  perf-profile.children.cycles-pp.switch_fpu_return
      0.08 ±  6%      -0.0        0.04 ± 79%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.12 ± 13%      -0.0        0.09 ± 23%  perf-profile.children.cycles-pp.native_write_msr
      0.31 ±  6%      -0.2        0.15 ± 81%  perf-profile.self.cycles-pp.poll_idle
      0.50 ±  6%      -0.2        0.35 ± 50%  perf-profile.self.cycles-pp.fpregs_assert_state_consistent
      0.18 ±  2%      -0.1        0.10 ± 86%  perf-profile.self.cycles-pp.total_mapcount
      0.10 ± 14%      -0.0        0.06 ± 45%  perf-profile.self.cycles-pp.switch_fpu_return
      0.10 ± 10%      -0.0        0.06 ± 47%  perf-profile.self.cycles-pp.__switch_to
      0.07 ±  7%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.prep_new_page
      0.07 ±  7%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.llist_add_batch
      0.07 ± 14%      -0.0        0.04 ± 79%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.12 ± 13%      -0.0        0.09 ± 23%  perf-profile.self.cycles-pp.native_write_msr
     66096 ± 99%     -99.8%     148.50 ± 92%  interrupts.109:PCI-MSI.31981642-edge.i40e-eth0-TxRx-73
    543.50 ± 39%     -73.3%     145.38 ± 81%  interrupts.112:PCI-MSI.31981645-edge.i40e-eth0-TxRx-76
    169.00 ± 28%     -55.3%      75.50 ± 83%  interrupts.116:PCI-MSI.31981649-edge.i40e-eth0-TxRx-80
    224.00 ± 14%     -57.6%      95.00 ± 87%  interrupts.121:PCI-MSI.31981654-edge.i40e-eth0-TxRx-85
    680.00 ± 28%     -80.5%     132.75 ± 82%  interrupts.43:PCI-MSI.31981576-edge.i40e-eth0-TxRx-7
    327.50 ± 31%     -39.0%     199.62 ± 60%  interrupts.60:PCI-MSI.31981593-edge.i40e-eth0-TxRx-24
    217.50 ± 19%     -51.7%     105.12 ± 79%  interrupts.63:PCI-MSI.31981596-edge.i40e-eth0-TxRx-27
    375.00 ± 46%     -78.5%      80.50 ± 82%  interrupts.70:PCI-MSI.31981603-edge.i40e-eth0-TxRx-34
    196.50 ±  3%     -51.6%      95.12 ± 74%  interrupts.72:PCI-MSI.31981605-edge.i40e-eth0-TxRx-36
    442.50 ± 45%     -73.1%     118.88 ± 90%  interrupts.79:PCI-MSI.31981612-edge.i40e-eth0-TxRx-43
    271.00 ±  8%     -53.2%     126.88 ± 75%  interrupts.82:PCI-MSI.31981615-edge.i40e-eth0-TxRx-46
    145448 ±  4%     -41.6%      84975 ± 42%  interrupts.CPU1.RES:Rescheduling_interrupts
     11773 ± 19%     -38.1%       7290 ± 52%  interrupts.CPU13.TLB:TLB_shootdowns
     24177 ± 15%    +356.5%     110368 ± 58%  interrupts.CPU16.RES:Rescheduling_interrupts
      3395 ±  3%     +78.3%       6055 ± 18%  interrupts.CPU17.NMI:Non-maskable_interrupts
      3395 ±  3%     +78.3%       6055 ± 18%  interrupts.CPU17.PMI:Performance_monitoring_interrupts
    106701 ± 41%     -55.6%      47425 ± 56%  interrupts.CPU18.RES:Rescheduling_interrupts
    327.50 ± 31%     -39.3%     198.88 ± 60%  interrupts.CPU24.60:PCI-MSI.31981593-edge.i40e-eth0-TxRx-24
    411618           +53.6%     632283 ± 77%  interrupts.CPU25.LOC:Local_timer_interrupts
     16189 ± 26%     -53.0%       7611 ± 66%  interrupts.CPU25.TLB:TLB_shootdowns
    407253           +54.4%     628596 ± 78%  interrupts.CPU26.LOC:Local_timer_interrupts
    216.50 ± 19%     -51.8%     104.25 ± 80%  interrupts.CPU27.63:PCI-MSI.31981596-edge.i40e-eth0-TxRx-27
      7180           -20.9%       5682 ± 25%  interrupts.CPU29.NMI:Non-maskable_interrupts
      7180           -20.9%       5682 ± 25%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
     15186 ± 12%     -45.5%       8276 ± 49%  interrupts.CPU3.TLB:TLB_shootdowns
     13092 ± 19%     -29.5%       9231 ± 35%  interrupts.CPU30.TLB:TLB_shootdowns
     13204 ± 26%     -29.3%       9336 ± 19%  interrupts.CPU31.TLB:TLB_shootdowns
    374.50 ± 46%     -78.7%      79.62 ± 83%  interrupts.CPU34.70:PCI-MSI.31981603-edge.i40e-eth0-TxRx-34
      7188           -25.6%       5345 ± 26%  interrupts.CPU35.NMI:Non-maskable_interrupts
      7188           -25.6%       5345 ± 26%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
    196.00 ±  4%     -52.0%      94.12 ± 75%  interrupts.CPU36.72:PCI-MSI.31981605-edge.i40e-eth0-TxRx-36
     12170 ± 20%     -34.3%       7998 ± 32%  interrupts.CPU39.TLB:TLB_shootdowns
    442.00 ± 45%     -73.3%     118.12 ± 91%  interrupts.CPU43.79:PCI-MSI.31981612-edge.i40e-eth0-TxRx-43
     12070 ± 15%     -37.2%       7581 ± 49%  interrupts.CPU43.TLB:TLB_shootdowns
      7177           -27.6%       5195 ± 26%  interrupts.CPU45.NMI:Non-maskable_interrupts
      7177           -27.6%       5195 ± 26%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
    271.00 ±  8%     -53.4%     126.38 ± 75%  interrupts.CPU46.82:PCI-MSI.31981615-edge.i40e-eth0-TxRx-46
      3591           +84.0%       6607 ± 12%  interrupts.CPU46.NMI:Non-maskable_interrupts
      3591           +84.0%       6607 ± 12%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
     57614 ± 30%     -34.0%      38015 ± 28%  interrupts.CPU46.RES:Rescheduling_interrupts
    149154 ± 41%     -47.2%      78808 ± 51%  interrupts.CPU51.RES:Rescheduling_interrupts
     30366 ± 28%    +279.5%     115229 ± 42%  interrupts.CPU52.RES:Rescheduling_interrupts
     29690          +355.5%     135237 ± 57%  interrupts.CPU54.RES:Rescheduling_interrupts
    213106 ±  2%     -66.9%      70545 ± 43%  interrupts.CPU59.RES:Rescheduling_interrupts
    225753 ±  7%     -72.9%      61212 ± 72%  interrupts.CPU60.RES:Rescheduling_interrupts
     12430 ± 14%     -41.5%       7276 ± 52%  interrupts.CPU61.TLB:TLB_shootdowns
     44552 ± 22%    +229.6%     146864 ± 36%  interrupts.CPU65.RES:Rescheduling_interrupts
    126088 ± 56%     -35.3%      81516 ± 73%  interrupts.CPU66.RES:Rescheduling_interrupts
    170880 ± 15%     -62.9%      63320 ± 52%  interrupts.CPU68.RES:Rescheduling_interrupts
    186033 ± 10%     -39.8%     112012 ± 41%  interrupts.CPU69.RES:Rescheduling_interrupts
    679.50 ± 29%     -80.5%     132.25 ± 82%  interrupts.CPU7.43:PCI-MSI.31981576-edge.i40e-eth0-TxRx-7
    124750 ± 18%     -39.4%      75553 ± 43%  interrupts.CPU7.RES:Rescheduling_interrupts
    158500 ± 47%     -52.1%      75915 ± 67%  interrupts.CPU71.RES:Rescheduling_interrupts
     11846 ± 11%     -32.5%       8001 ± 47%  interrupts.CPU72.TLB:TLB_shootdowns
     66095 ± 99%     -99.8%     147.62 ± 93%  interrupts.CPU73.109:PCI-MSI.31981642-edge.i40e-eth0-TxRx-73
      7221 ±  2%     -31.0%       4982 ± 35%  interrupts.CPU73.NMI:Non-maskable_interrupts
      7221 ±  2%     -31.0%       4982 ± 35%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
     15304 ± 14%     -47.9%       7972 ± 31%  interrupts.CPU73.TLB:TLB_shootdowns
     10918 ±  3%     -31.9%       7436 ± 36%  interrupts.CPU74.TLB:TLB_shootdowns
    543.00 ± 39%     -73.3%     144.75 ± 81%  interrupts.CPU76.112:PCI-MSI.31981645-edge.i40e-eth0-TxRx-76
     12214 ± 14%     -40.9%       7220 ± 38%  interrupts.CPU79.TLB:TLB_shootdowns
    168.00 ± 29%     -55.7%      74.50 ± 85%  interrupts.CPU80.116:PCI-MSI.31981649-edge.i40e-eth0-TxRx-80
     28619 ±  3%    +158.4%      73939 ± 44%  interrupts.CPU80.RES:Rescheduling_interrupts
     12258           -34.3%       8056 ± 29%  interrupts.CPU80.TLB:TLB_shootdowns
      7214           -19.5%       5809 ± 24%  interrupts.CPU82.NMI:Non-maskable_interrupts
      7214           -19.5%       5809 ± 24%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
     13522 ± 11%     -41.2%       7949 ± 29%  interrupts.CPU84.TLB:TLB_shootdowns
    223.50 ± 14%     -57.8%      94.25 ± 88%  interrupts.CPU85.121:PCI-MSI.31981654-edge.i40e-eth0-TxRx-85
     11989 ±  2%     -31.7%       8194 ± 22%  interrupts.CPU85.TLB:TLB_shootdowns
    121153 ± 29%     -41.4%      70964 ± 58%  interrupts.CPU86.RES:Rescheduling_interrupts
     11731 ±  8%     -40.7%       6957 ± 36%  interrupts.CPU86.TLB:TLB_shootdowns
     12192 ± 22%     -35.8%       7824 ± 43%  interrupts.CPU87.TLB:TLB_shootdowns
     11603 ± 19%     -31.8%       7915 ± 41%  interrupts.CPU89.TLB:TLB_shootdowns
     10471 ±  5%     -27.0%       7641 ± 31%  interrupts.CPU91.TLB:TLB_shootdowns
      7156           -20.9%       5658 ± 23%  interrupts.CPU92.NMI:Non-maskable_interrupts
      7156           -20.9%       5658 ± 23%  interrupts.CPU92.PMI:Performance_monitoring_interrupts
     99802 ± 20%     -43.6%      56270 ± 47%  interrupts.CPU92.RES:Rescheduling_interrupts
    109162 ± 18%     -28.7%      77839 ± 26%  interrupts.CPU93.RES:Rescheduling_interrupts
     15044 ± 29%     -44.4%       8359 ± 30%  interrupts.CPU93.TLB:TLB_shootdowns
    110749 ± 19%     -47.3%      58345 ± 48%  interrupts.CPU94.RES:Rescheduling_interrupts
      7245           -21.4%       5697 ± 25%  interrupts.CPU95.NMI:Non-maskable_interrupts
      7245           -21.4%       5697 ± 25%  interrupts.CPU95.PMI:Performance_monitoring_interrupts
      1969 ±  5%    +491.7%      11653 ± 81%  interrupts.IWI:IRQ_work_interrupts



***************************************************************************************************
lkp-bdw-ep6: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/testcase/testtime/ucode:
  interrupt/gcc-7/performance/1HDD/x86_64-rhel-7.6/100%/debian-x86_64-2019-09-23.cgz/lkp-bdw-ep6/stress-ng/30s/0xb000038

commit: 
  fcf0553db6 ("sched/fair: Remove meaningless imbalance calculation")
  0b0695f2b3 ("sched/fair: Rework load_balance()")

fcf0553db6f4c793 0b0695f2b34a4afa3f6e9aa1ff0 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  98318389           +43.0%  1.406e+08        stress-ng.schedpolicy.ops
   3277346           +43.0%    4685146        stress-ng.schedpolicy.ops_per_sec
 3.506e+08 ±  4%     -10.3%  3.146e+08 ±  3%  stress-ng.sigq.ops
  11684738 ±  4%     -10.3%   10485353 ±  3%  stress-ng.sigq.ops_per_sec
 3.628e+08 ±  6%     -19.4%  2.925e+08 ±  6%  stress-ng.time.involuntary_context_switches
     29456            +2.8%      30285        stress-ng.time.system_time
   7636655 ±  9%     +46.6%   11197377 ± 27%  cpuidle.C1E.usage
   1111483 ±  3%      -9.5%    1005829        vmstat.system.cs
  22638222 ±  4%     +16.5%   26370816 ± 11%  meminfo.Committed_AS
     28908 ±  6%     +24.6%      36020 ± 16%  meminfo.KernelStack
   7636543 ±  9%     +46.6%   11196090 ± 27%  turbostat.C1E
      3.46 ± 16%     -61.2%       1.35 ±  7%  turbostat.Pkg%pc2
    217.54            +1.7%     221.33        turbostat.PkgWatt
     13.34 ±  2%      +5.8%      14.11        turbostat.RAMWatt
    525.50 ±  8%     -15.7%     443.00 ± 12%  slabinfo.biovec-128.active_objs
    525.50 ±  8%     -15.7%     443.00 ± 12%  slabinfo.biovec-128.num_objs
     28089 ± 12%     -33.0%      18833 ± 22%  slabinfo.pool_workqueue.active_objs
    877.25 ± 12%     -32.6%     591.00 ± 21%  slabinfo.pool_workqueue.active_slabs
     28089 ± 12%     -32.6%      18925 ± 21%  slabinfo.pool_workqueue.num_objs
    877.25 ± 12%     -32.6%     591.00 ± 21%  slabinfo.pool_workqueue.num_slabs
    846.75 ±  6%     -18.0%     694.75 ±  9%  slabinfo.skbuff_fclone_cache.active_objs
    846.75 ±  6%     -18.0%     694.75 ±  9%  slabinfo.skbuff_fclone_cache.num_objs
     63348 ±  6%     -20.7%      50261 ±  4%  softirqs.CPU14.SCHED
     44394 ±  4%     +21.4%      53880 ±  8%  softirqs.CPU42.SCHED
     52246 ±  7%     -15.1%      44352        softirqs.CPU47.SCHED
     58350 ±  4%     -11.0%      51914 ±  7%  softirqs.CPU6.SCHED
     58009 ±  7%     -23.8%      44206 ±  4%  softirqs.CPU63.SCHED
     49166 ±  6%     +23.4%      60683 ±  9%  softirqs.CPU68.SCHED
     44594 ±  7%     +14.3%      50951 ±  8%  softirqs.CPU78.SCHED
     46407 ±  9%     +19.6%      55515 ±  8%  softirqs.CPU84.SCHED
     55555 ±  8%     -15.5%      46933 ±  4%  softirqs.CPU9.SCHED
    198757 ± 18%     +44.1%     286316 ±  9%  numa-meminfo.node0.Active
    189280 ± 19%     +37.1%     259422 ±  7%  numa-meminfo.node0.Active(anon)
    110438 ± 33%     +68.3%     185869 ± 16%  numa-meminfo.node0.AnonHugePages
    143458 ± 28%     +67.7%     240547 ± 13%  numa-meminfo.node0.AnonPages
     12438 ± 16%     +61.9%      20134 ± 37%  numa-meminfo.node0.KernelStack
   1004379 ±  7%     +16.4%    1168764 ±  4%  numa-meminfo.node0.MemUsed
    357111 ± 24%     -41.6%     208655 ± 29%  numa-meminfo.node1.Active
    330094 ± 22%     -39.6%     199339 ± 32%  numa-meminfo.node1.Active(anon)
    265924 ± 25%     -52.2%     127138 ± 46%  numa-meminfo.node1.AnonHugePages
    314059 ± 22%     -49.6%     158305 ± 36%  numa-meminfo.node1.AnonPages
     15386 ± 16%     -25.1%      11525 ± 15%  numa-meminfo.node1.KernelStack
   1200805 ± 11%     -18.6%     977595 ±  7%  numa-meminfo.node1.MemUsed
    965.50 ± 15%     -29.3%     682.25 ± 43%  numa-meminfo.node1.Mlocked
     46762 ± 18%     +37.8%      64452 ±  8%  numa-vmstat.node0.nr_active_anon
     35393 ± 27%     +68.9%      59793 ± 12%  numa-vmstat.node0.nr_anon_pages
     52.75 ± 33%     +71.1%      90.25 ± 15%  numa-vmstat.node0.nr_anon_transparent_hugepages
     15.00 ± 96%    +598.3%     104.75 ± 15%  numa-vmstat.node0.nr_inactive_file
     11555 ± 22%     +68.9%      19513 ± 41%  numa-vmstat.node0.nr_kernel_stack
    550.25 ±162%    +207.5%       1691 ± 48%  numa-vmstat.node0.nr_written
     46762 ± 18%     +37.8%      64452 ±  8%  numa-vmstat.node0.nr_zone_active_anon
     15.00 ± 96%    +598.3%     104.75 ± 15%  numa-vmstat.node0.nr_zone_inactive_file
     82094 ± 22%     -39.5%      49641 ± 32%  numa-vmstat.node1.nr_active_anon
     78146 ± 23%     -49.5%      39455 ± 37%  numa-vmstat.node1.nr_anon_pages
    129.00 ± 25%     -52.3%      61.50 ± 47%  numa-vmstat.node1.nr_anon_transparent_hugepages
    107.75 ± 12%     -85.4%      15.75 ±103%  numa-vmstat.node1.nr_inactive_file
     14322 ± 11%     -21.1%      11304 ± 11%  numa-vmstat.node1.nr_kernel_stack
    241.00 ± 15%     -29.5%     170.00 ± 43%  numa-vmstat.node1.nr_mlock
     82094 ± 22%     -39.5%      49641 ± 32%  numa-vmstat.node1.nr_zone_active_anon
    107.75 ± 12%     -85.4%      15.75 ±103%  numa-vmstat.node1.nr_zone_inactive_file
      0.81 ±  5%      +0.2        0.99 ± 10%  perf-profile.calltrace.cycles-pp.task_rq_lock.task_sched_runtime.cpu_clock_sample.posix_cpu_timer_get.do_timer_gettime
      0.60 ± 11%      +0.2        0.83 ±  9%  perf-profile.calltrace.cycles-pp.___might_sleep.__might_fault._copy_to_user.put_itimerspec64.__x64_sys_timer_gettime
      1.73 ±  9%      +0.3        2.05 ±  8%  perf-profile.calltrace.cycles-pp.__might_fault._copy_to_user.put_itimerspec64.__x64_sys_timer_gettime.do_syscall_64
      3.92 ±  5%      +0.6        4.49 ±  7%  perf-profile.calltrace.cycles-pp.task_sched_runtime.cpu_clock_sample.posix_cpu_timer_get.do_timer_gettime.__x64_sys_timer_gettime
      4.17 ±  4%      +0.6        4.78 ±  7%  perf-profile.calltrace.cycles-pp.cpu_clock_sample.posix_cpu_timer_get.do_timer_gettime.__x64_sys_timer_gettime.do_syscall_64
      5.72 ±  3%      +0.7        6.43 ±  7%  perf-profile.calltrace.cycles-pp.posix_cpu_timer_get.do_timer_gettime.__x64_sys_timer_gettime.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.24 ± 54%      -0.2        0.07 ±131%  perf-profile.children.cycles-pp.ext4_inode_csum_set
      0.45 ±  3%      +0.1        0.56 ±  4%  perf-profile.children.cycles-pp.__might_sleep
      0.84 ±  5%      +0.2        1.03 ±  9%  perf-profile.children.cycles-pp.task_rq_lock
      0.66 ±  8%      +0.2        0.88 ±  7%  perf-profile.children.cycles-pp.___might_sleep
      1.83 ±  9%      +0.3        2.16 ±  8%  perf-profile.children.cycles-pp.__might_fault
      4.04 ±  5%      +0.6        4.62 ±  7%  perf-profile.children.cycles-pp.task_sched_runtime
      4.24 ±  4%      +0.6        4.87 ±  7%  perf-profile.children.cycles-pp.cpu_clock_sample
      5.77 ±  3%      +0.7        6.48 ±  7%  perf-profile.children.cycles-pp.posix_cpu_timer_get
      0.22 ± 11%      +0.1        0.28 ± 15%  perf-profile.self.cycles-pp.cpu_clock_sample
      0.47 ±  7%      +0.1        0.55 ±  5%  perf-profile.self.cycles-pp.update_curr
      0.28 ±  5%      +0.1        0.38 ± 14%  perf-profile.self.cycles-pp.task_rq_lock
      0.42 ±  3%      +0.1        0.53 ±  4%  perf-profile.self.cycles-pp.__might_sleep
      0.50 ±  5%      +0.1        0.61 ± 11%  perf-profile.self.cycles-pp.task_sched_runtime
      0.63 ±  9%      +0.2        0.85 ±  7%  perf-profile.self.cycles-pp.___might_sleep
   9180611 ±  5%     +40.1%   12859327 ± 14%  sched_debug.cfs_rq:/.MIN_vruntime.max
   1479571 ±  6%     +57.6%    2331469 ± 14%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
      7951 ±  6%     -52.5%       3773 ± 17%  sched_debug.cfs_rq:/.exec_clock.stddev
    321306 ± 39%     -44.2%     179273        sched_debug.cfs_rq:/.load.max
   9180613 ±  5%     +40.1%   12859327 ± 14%  sched_debug.cfs_rq:/.max_vruntime.max
   1479571 ±  6%     +57.6%    2331469 ± 14%  sched_debug.cfs_rq:/.max_vruntime.stddev
  16622378           +20.0%   19940069 ±  7%  sched_debug.cfs_rq:/.min_vruntime.avg
  18123901           +19.7%   21686545 ±  6%  sched_debug.cfs_rq:/.min_vruntime.max
  14338218 ±  3%     +27.4%   18267927 ±  7%  sched_debug.cfs_rq:/.min_vruntime.min
      0.17 ± 16%     +23.4%       0.21 ± 11%  sched_debug.cfs_rq:/.nr_running.stddev
    319990 ± 39%     -44.6%     177347        sched_debug.cfs_rq:/.runnable_weight.max
  -2067420           -33.5%   -1375445        sched_debug.cfs_rq:/.spread0.min
      1033 ±  8%     -13.7%     891.85 ±  3%  sched_debug.cfs_rq:/.util_est_enqueued.max
     93676 ± 16%     -29.0%      66471 ± 17%  sched_debug.cpu.avg_idle.min
     10391 ± 52%    +118.9%      22750 ± 15%  sched_debug.cpu.curr->pid.avg
     14393 ± 35%    +113.2%      30689 ± 17%  sched_debug.cpu.curr->pid.max
      3041 ± 38%    +161.8%       7963 ± 11%  sched_debug.cpu.curr->pid.stddev
      3.38 ±  6%     -16.3%       2.83 ±  5%  sched_debug.cpu.nr_running.max
   2412687 ±  4%     -16.0%    2027251 ±  3%  sched_debug.cpu.nr_switches.avg
   4038819 ±  3%     -20.2%    3223112 ±  5%  sched_debug.cpu.nr_switches.max
    834203 ± 17%     -37.8%     518798 ± 27%  sched_debug.cpu.nr_switches.stddev
     45.85 ± 13%     +41.2%      64.75 ± 18%  sched_debug.cpu.nr_uninterruptible.max
   1937209 ±  2%     +58.5%    3070891 ±  3%  sched_debug.cpu.sched_count.min
   1074023 ± 13%     -57.9%     451958 ± 12%  sched_debug.cpu.sched_count.stddev
   1283769 ±  7%     +65.1%    2118907 ±  7%  sched_debug.cpu.yld_count.min
    714244 ±  5%     -51.9%     343373 ± 22%  sched_debug.cpu.yld_count.stddev
     12.54 ±  9%     -18.8%      10.18 ± 15%  perf-stat.i.MPKI
 1.011e+10            +2.6%  1.038e+10        perf-stat.i.branch-instructions
     13.22 ±  5%      +2.5       15.75 ±  3%  perf-stat.i.cache-miss-rate%
  21084021 ±  6%     +33.9%   28231058 ±  6%  perf-stat.i.cache-misses
   1143861 ±  5%     -12.1%    1005721 ±  6%  perf-stat.i.context-switches
 1.984e+11            +1.8%   2.02e+11        perf-stat.i.cpu-cycles
 1.525e+10            +1.3%  1.544e+10        perf-stat.i.dTLB-loads
     65.46            -2.7       62.76 ±  3%  perf-stat.i.iTLB-load-miss-rate%
  20360883 ±  4%     +10.5%   22500874 ±  4%  perf-stat.i.iTLB-loads
 4.963e+10            +2.0%  5.062e+10        perf-stat.i.instructions
    181557            -2.4%     177113        perf-stat.i.msec
   5350122 ±  8%     +26.5%    6765332 ±  7%  perf-stat.i.node-load-misses
   4264320 ±  3%     +24.8%    5321600 ±  4%  perf-stat.i.node-store-misses
      6.12 ±  5%      +1.5        7.60 ±  2%  perf-stat.overall.cache-miss-rate%
      7646 ±  6%     -17.7%       6295 ±  3%  perf-stat.overall.cycles-between-cache-misses
     69.29            -1.1       68.22        perf-stat.overall.iTLB-load-miss-rate%
     61.11 ±  2%      +6.6       67.71 ±  5%  perf-stat.overall.node-load-miss-rate%
     74.82            +1.8       76.58        perf-stat.overall.node-store-miss-rate%
 1.044e+10            +1.8%  1.063e+10        perf-stat.ps.branch-instructions
  26325951 ±  6%     +22.9%   32366684 ±  2%  perf-stat.ps.cache-misses
   1115530 ±  3%      -9.5%    1009780        perf-stat.ps.context-switches
 1.536e+10            +1.0%  1.552e+10        perf-stat.ps.dTLB-loads
  44718416 ±  2%      +5.8%   47308605 ±  3%  perf-stat.ps.iTLB-load-misses
  19831973 ±  4%     +11.1%   22040029 ±  4%  perf-stat.ps.iTLB-loads
 5.064e+10            +1.4%  5.137e+10        perf-stat.ps.instructions
   5454694 ±  9%     +26.4%    6892365 ±  6%  perf-stat.ps.node-load-misses
   4263688 ±  4%     +24.9%    5325279 ±  4%  perf-stat.ps.node-store-misses
 3.001e+13            +1.7%  3.052e+13        perf-stat.total.instructions
     18550           -74.9%       4650 ±173%  interrupts.76:IR-PCI-MSI.512000-edge.ahci[0000:00:1f.2]
      7642 ±  9%     -20.4%       6086 ±  2%  interrupts.CPU0.CAL:Function_call_interrupts
      4376 ± 22%     -75.4%       1077 ± 41%  interrupts.CPU0.TLB:TLB_shootdowns
      8402 ±  5%     -19.0%       6806        interrupts.CPU1.CAL:Function_call_interrupts
      4559 ± 20%     -73.7%       1199 ± 15%  interrupts.CPU1.TLB:TLB_shootdowns
      8423 ±  4%     -20.2%       6725 ±  2%  interrupts.CPU10.CAL:Function_call_interrupts
      4536 ± 14%     -75.0%       1135 ± 20%  interrupts.CPU10.TLB:TLB_shootdowns
      8303 ±  3%     -18.2%       6795 ±  2%  interrupts.CPU11.CAL:Function_call_interrupts
      4404 ± 11%     -71.6%       1250 ± 35%  interrupts.CPU11.TLB:TLB_shootdowns
      8491 ±  6%     -21.3%       6683        interrupts.CPU12.CAL:Function_call_interrupts
      4723 ± 20%     -77.2%       1077 ± 17%  interrupts.CPU12.TLB:TLB_shootdowns
      8403 ±  5%     -20.3%       6700 ±  2%  interrupts.CPU13.CAL:Function_call_interrupts
      4557 ± 19%     -74.2%       1175 ± 22%  interrupts.CPU13.TLB:TLB_shootdowns
      8459 ±  4%     -18.6%       6884        interrupts.CPU14.CAL:Function_call_interrupts
      4559 ± 18%     -69.8%       1376 ± 13%  interrupts.CPU14.TLB:TLB_shootdowns
      8305 ±  7%     -17.7%       6833 ±  2%  interrupts.CPU15.CAL:Function_call_interrupts
      4261 ± 25%     -67.6%       1382 ± 24%  interrupts.CPU15.TLB:TLB_shootdowns
      8277 ±  5%     -19.1%       6696 ±  3%  interrupts.CPU16.CAL:Function_call_interrupts
      4214 ± 22%     -69.6%       1282 ±  8%  interrupts.CPU16.TLB:TLB_shootdowns
      8258 ±  5%     -18.9%       6694 ±  3%  interrupts.CPU17.CAL:Function_call_interrupts
      4461 ± 19%     -74.1%       1155 ± 21%  interrupts.CPU17.TLB:TLB_shootdowns
      8457 ±  6%     -20.6%       6717        interrupts.CPU18.CAL:Function_call_interrupts
      4889 ± 34%     +60.0%       7822        interrupts.CPU18.NMI:Non-maskable_interrupts
      4889 ± 34%     +60.0%       7822        interrupts.CPU18.PMI:Performance_monitoring_interrupts
      4731 ± 22%     -77.2%       1078 ± 10%  interrupts.CPU18.TLB:TLB_shootdowns
      8160 ±  5%     -18.1%       6684        interrupts.CPU19.CAL:Function_call_interrupts
      4311 ± 20%     -74.2%       1114 ± 13%  interrupts.CPU19.TLB:TLB_shootdowns
      8464 ±  2%     -18.2%       6927 ±  3%  interrupts.CPU2.CAL:Function_call_interrupts
      4938 ± 14%     -70.5%       1457 ± 18%  interrupts.CPU2.TLB:TLB_shootdowns
      8358 ±  6%     -19.7%       6715 ±  3%  interrupts.CPU20.CAL:Function_call_interrupts
      4567 ± 24%     -74.6%       1160 ± 35%  interrupts.CPU20.TLB:TLB_shootdowns
      8460 ±  4%     -22.3%       6577 ±  2%  interrupts.CPU21.CAL:Function_call_interrupts
      4514 ± 18%     -76.0%       1084 ± 22%  interrupts.CPU21.TLB:TLB_shootdowns
      6677 ±  6%     +19.6%       7988 ±  9%  interrupts.CPU22.CAL:Function_call_interrupts
      1288 ± 14%    +209.1%       3983 ± 35%  interrupts.CPU22.TLB:TLB_shootdowns
      6751 ±  2%     +24.0%       8370 ±  9%  interrupts.CPU23.CAL:Function_call_interrupts
      1037 ± 29%    +323.0%       4388 ± 36%  interrupts.CPU23.TLB:TLB_shootdowns
      6844           +20.6%       8251 ±  9%  interrupts.CPU24.CAL:Function_call_interrupts
      1205 ± 17%    +229.2%       3967 ± 40%  interrupts.CPU24.TLB:TLB_shootdowns
      6880           +21.9%       8389 ±  7%  interrupts.CPU25.CAL:Function_call_interrupts
      1228 ± 19%    +245.2%       4240 ± 35%  interrupts.CPU25.TLB:TLB_shootdowns
      6494 ±  8%     +25.1%       8123 ±  9%  interrupts.CPU26.CAL:Function_call_interrupts
      1141 ± 13%    +262.5%       4139 ± 32%  interrupts.CPU26.TLB:TLB_shootdowns
      6852           +19.2%       8166 ±  7%  interrupts.CPU27.CAL:Function_call_interrupts
      1298 ±  8%    +197.1%       3857 ± 31%  interrupts.CPU27.TLB:TLB_shootdowns
      6563 ±  6%     +25.2%       8214 ±  8%  interrupts.CPU28.CAL:Function_call_interrupts
      1176 ±  8%    +237.1%       3964 ± 33%  interrupts.CPU28.TLB:TLB_shootdowns
      6842 ±  2%     +21.4%       8308 ±  8%  interrupts.CPU29.CAL:Function_call_interrupts
      1271 ± 11%    +223.8%       4118 ± 33%  interrupts.CPU29.TLB:TLB_shootdowns
      8418 ±  3%     -21.1%       6643 ±  2%  interrupts.CPU3.CAL:Function_call_interrupts
      4677 ± 11%     -75.1%       1164 ± 16%  interrupts.CPU3.TLB:TLB_shootdowns
      6798 ±  3%     +21.8%       8284 ±  7%  interrupts.CPU30.CAL:Function_call_interrupts
      1219 ± 12%    +236.3%       4102 ± 30%  interrupts.CPU30.TLB:TLB_shootdowns
      6503 ±  4%     +25.9%       8186 ±  6%  interrupts.CPU31.CAL:Function_call_interrupts
      1046 ± 15%    +289.1%       4072 ± 32%  interrupts.CPU31.TLB:TLB_shootdowns
      6949 ±  3%     +17.2%       8141 ±  8%  interrupts.CPU32.CAL:Function_call_interrupts
      1241 ± 23%    +210.6%       3854 ± 34%  interrupts.CPU32.TLB:TLB_shootdowns
      1487 ± 26%    +161.6%       3889 ± 46%  interrupts.CPU33.TLB:TLB_shootdowns
      1710 ± 44%    +140.1%       4105 ± 36%  interrupts.CPU34.TLB:TLB_shootdowns
      6957 ±  2%     +15.2%       8012 ±  9%  interrupts.CPU35.CAL:Function_call_interrupts
      1165 ±  8%    +223.1%       3765 ± 38%  interrupts.CPU35.TLB:TLB_shootdowns
      1423 ± 24%    +173.4%       3892 ± 33%  interrupts.CPU36.TLB:TLB_shootdowns
      1279 ± 29%    +224.2%       4148 ± 39%  interrupts.CPU37.TLB:TLB_shootdowns
      1301 ± 20%    +226.1%       4244 ± 35%  interrupts.CPU38.TLB:TLB_shootdowns
      6906 ±  2%     +18.5%       8181 ±  8%  interrupts.CPU39.CAL:Function_call_interrupts
    368828 ± 20%     +96.2%     723710 ±  7%  interrupts.CPU39.RES:Rescheduling_interrupts
      1438 ± 12%    +174.8%       3951 ± 33%  interrupts.CPU39.TLB:TLB_shootdowns
      8399 ±  5%     -19.2%       6788 ±  2%  interrupts.CPU4.CAL:Function_call_interrupts
      4567 ± 18%     -72.7%       1245 ± 28%  interrupts.CPU4.TLB:TLB_shootdowns
      6895           +22.4%       8439 ±  9%  interrupts.CPU40.CAL:Function_call_interrupts
      1233 ± 11%    +247.1%       4280 ± 36%  interrupts.CPU40.TLB:TLB_shootdowns
      6819 ±  2%     +21.3%       8274 ±  9%  interrupts.CPU41.CAL:Function_call_interrupts
      1260 ± 14%    +207.1%       3871 ± 38%  interrupts.CPU41.TLB:TLB_shootdowns
      1301 ±  9%    +204.7%       3963 ± 36%  interrupts.CPU42.TLB:TLB_shootdowns
      6721 ±  3%     +22.3%       8221 ±  7%  interrupts.CPU43.CAL:Function_call_interrupts
      1237 ± 19%    +224.8%       4017 ± 35%  interrupts.CPU43.TLB:TLB_shootdowns
      8422 ±  8%     -22.7%       6506 ±  5%  interrupts.CPU44.CAL:Function_call_interrupts
  15261375 ±  7%      -7.8%   14064176        interrupts.CPU44.LOC:Local_timer_interrupts
      4376 ± 25%     -75.7%       1063 ± 26%  interrupts.CPU44.TLB:TLB_shootdowns
      8451 ±  5%     -23.7%       6448 ±  6%  interrupts.CPU45.CAL:Function_call_interrupts
      4351 ± 18%     -74.9%       1094 ± 12%  interrupts.CPU45.TLB:TLB_shootdowns
      8705 ±  6%     -21.2%       6860 ±  2%  interrupts.CPU46.CAL:Function_call_interrupts
      4787 ± 20%     -69.5%       1462 ± 16%  interrupts.CPU46.TLB:TLB_shootdowns
      8334 ±  3%     -18.9%       6763        interrupts.CPU47.CAL:Function_call_interrupts
      4126 ± 10%     -71.3%       1186 ± 18%  interrupts.CPU47.TLB:TLB_shootdowns
      8578 ±  4%     -21.7%       6713        interrupts.CPU48.CAL:Function_call_interrupts
      4520 ± 15%     -74.5%       1154 ± 23%  interrupts.CPU48.TLB:TLB_shootdowns
      8450 ±  8%     -18.8%       6863 ±  3%  interrupts.CPU49.CAL:Function_call_interrupts
      4494 ± 24%     -66.5%       1505 ± 22%  interrupts.CPU49.TLB:TLB_shootdowns
      8307 ±  4%     -18.0%       6816 ±  2%  interrupts.CPU5.CAL:Function_call_interrupts
      7845           -37.4%       4908 ± 34%  interrupts.CPU5.NMI:Non-maskable_interrupts
      7845           -37.4%       4908 ± 34%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
      4429 ± 17%     -69.8%       1339 ± 20%  interrupts.CPU5.TLB:TLB_shootdowns
      8444 ±  4%     -21.7%       6613        interrupts.CPU50.CAL:Function_call_interrupts
      4282 ± 16%     -76.0%       1029 ± 17%  interrupts.CPU50.TLB:TLB_shootdowns
      8750 ±  6%     -22.2%       6803        interrupts.CPU51.CAL:Function_call_interrupts
      4755 ± 20%     -73.1%       1277 ± 15%  interrupts.CPU51.TLB:TLB_shootdowns
      8478 ±  6%     -20.2%       6766 ±  2%  interrupts.CPU52.CAL:Function_call_interrupts
      4337 ± 20%     -72.6%       1190 ± 22%  interrupts.CPU52.TLB:TLB_shootdowns
      8604 ±  7%     -21.5%       6750 ±  4%  interrupts.CPU53.CAL:Function_call_interrupts
      4649 ± 17%     -74.3%       1193 ± 23%  interrupts.CPU53.TLB:TLB_shootdowns
      8317 ±  9%     -19.4%       6706 ±  3%  interrupts.CPU54.CAL:Function_call_interrupts
      4372 ± 12%     -75.4%       1076 ± 29%  interrupts.CPU54.TLB:TLB_shootdowns
      8439 ±  3%     -18.5%       6876        interrupts.CPU55.CAL:Function_call_interrupts
      4415 ± 11%     -71.6%       1254 ± 17%  interrupts.CPU55.TLB:TLB_shootdowns
      8869 ±  6%     -22.6%       6864 ±  2%  interrupts.CPU56.CAL:Function_call_interrupts
    517594 ± 13%    +123.3%    1155539 ± 25%  interrupts.CPU56.RES:Rescheduling_interrupts
      5085 ± 22%     -74.9%       1278 ± 17%  interrupts.CPU56.TLB:TLB_shootdowns
      8682 ±  4%     -21.7%       6796 ±  2%  interrupts.CPU57.CAL:Function_call_interrupts
      4808 ± 19%     -74.1%       1243 ± 13%  interrupts.CPU57.TLB:TLB_shootdowns
      8626 ±  7%     -21.8%       6746 ±  2%  interrupts.CPU58.CAL:Function_call_interrupts
      4816 ± 20%     -79.1%       1007 ± 28%  interrupts.CPU58.TLB:TLB_shootdowns
      8759 ±  8%     -20.3%       6984        interrupts.CPU59.CAL:Function_call_interrupts
      4840 ± 22%     -70.6%       1423 ± 14%  interrupts.CPU59.TLB:TLB_shootdowns
      8167 ±  6%     -19.0%       6615 ±  2%  interrupts.CPU6.CAL:Function_call_interrupts
      4129 ± 21%     -75.4%       1017 ± 24%  interrupts.CPU6.TLB:TLB_shootdowns
      8910 ±  4%     -23.7%       6794 ±  3%  interrupts.CPU60.CAL:Function_call_interrupts
      5017 ± 12%     -77.8%       1113 ± 15%  interrupts.CPU60.TLB:TLB_shootdowns
      8689 ±  5%     -21.6%       6808        interrupts.CPU61.CAL:Function_call_interrupts
      4715 ± 20%     -77.6%       1055 ± 19%  interrupts.CPU61.TLB:TLB_shootdowns
      8574 ±  4%     -18.9%       6953 ±  2%  interrupts.CPU62.CAL:Function_call_interrupts
      4494 ± 17%     -72.3%       1244 ±  7%  interrupts.CPU62.TLB:TLB_shootdowns
      8865 ±  3%     -25.4%       6614 ±  7%  interrupts.CPU63.CAL:Function_call_interrupts
      4870 ± 12%     -76.8%       1130 ± 12%  interrupts.CPU63.TLB:TLB_shootdowns
      8724 ±  7%     -20.2%       6958 ±  3%  interrupts.CPU64.CAL:Function_call_interrupts
      4736 ± 16%     -72.6%       1295 ±  7%  interrupts.CPU64.TLB:TLB_shootdowns
      8717 ±  6%     -23.7%       6653 ±  4%  interrupts.CPU65.CAL:Function_call_interrupts
      4626 ± 19%     -76.5%       1087 ± 21%  interrupts.CPU65.TLB:TLB_shootdowns
      6671           +24.7%       8318 ±  9%  interrupts.CPU66.CAL:Function_call_interrupts
      1091 ±  8%    +249.8%       3819 ± 32%  interrupts.CPU66.TLB:TLB_shootdowns
      6795 ±  2%     +26.9%       8624 ±  9%  interrupts.CPU67.CAL:Function_call_interrupts
      1098 ± 24%    +299.5%       4388 ± 39%  interrupts.CPU67.TLB:TLB_shootdowns
      6704 ±  5%     +25.8%       8431 ±  8%  interrupts.CPU68.CAL:Function_call_interrupts
      1214 ± 15%    +236.1%       4083 ± 36%  interrupts.CPU68.TLB:TLB_shootdowns
      1049 ± 15%    +326.2%       4473 ± 33%  interrupts.CPU69.TLB:TLB_shootdowns
      8554 ±  6%     -19.6%       6874 ±  2%  interrupts.CPU7.CAL:Function_call_interrupts
      4753 ± 19%     -71.7%       1344 ± 16%  interrupts.CPU7.TLB:TLB_shootdowns
      1298 ± 13%    +227.4%       4249 ± 38%  interrupts.CPU70.TLB:TLB_shootdowns
      6976           +19.9%       8362 ±  7%  interrupts.CPU71.CAL:Function_call_interrupts
   1232748 ± 18%     -57.3%     525824 ± 33%  interrupts.CPU71.RES:Rescheduling_interrupts
      1253 ±  9%    +211.8%       3909 ± 31%  interrupts.CPU71.TLB:TLB_shootdowns
      1316 ± 22%    +188.7%       3800 ± 33%  interrupts.CPU72.TLB:TLB_shootdowns
      6665 ±  5%     +26.5%       8429 ±  8%  interrupts.CPU73.CAL:Function_call_interrupts
      1202 ± 13%    +234.1%       4017 ± 37%  interrupts.CPU73.TLB:TLB_shootdowns
      6639 ±  5%     +27.0%       8434 ±  8%  interrupts.CPU74.CAL:Function_call_interrupts
      1079 ± 16%    +269.4%       3986 ± 36%  interrupts.CPU74.TLB:TLB_shootdowns
      1055 ± 12%    +301.2%       4235 ± 34%  interrupts.CPU75.TLB:TLB_shootdowns
      7011 ±  3%     +21.6%       8522 ±  8%  interrupts.CPU76.CAL:Function_call_interrupts
      1223 ± 13%    +230.7%       4047 ± 35%  interrupts.CPU76.TLB:TLB_shootdowns
      6886 ±  7%     +25.6%       8652 ± 10%  interrupts.CPU77.CAL:Function_call_interrupts
      1316 ± 16%    +229.8%       4339 ± 36%  interrupts.CPU77.TLB:TLB_shootdowns
      7343 ±  5%     +19.1%       8743 ±  9%  interrupts.CPU78.CAL:Function_call_interrupts
      1699 ± 37%    +144.4%       4152 ± 31%  interrupts.CPU78.TLB:TLB_shootdowns
      7136 ±  4%     +21.4%       8666 ±  9%  interrupts.CPU79.CAL:Function_call_interrupts
      1094 ± 13%    +276.2%       4118 ± 34%  interrupts.CPU79.TLB:TLB_shootdowns
      8531 ±  5%     -19.5%       6869 ±  2%  interrupts.CPU8.CAL:Function_call_interrupts
      4764 ± 16%     -71.0%       1382 ± 14%  interrupts.CPU8.TLB:TLB_shootdowns
      1387 ± 29%    +181.8%       3910 ± 38%  interrupts.CPU80.TLB:TLB_shootdowns
      1114 ± 30%    +259.7%       4007 ± 36%  interrupts.CPU81.TLB:TLB_shootdowns
      7012           +23.9%       8685 ±  8%  interrupts.CPU82.CAL:Function_call_interrupts
      1274 ± 12%    +255.4%       4530 ± 27%  interrupts.CPU82.TLB:TLB_shootdowns
      6971 ±  3%     +23.8%       8628 ±  9%  interrupts.CPU83.CAL:Function_call_interrupts
      1156 ± 18%    +260.1%       4162 ± 34%  interrupts.CPU83.TLB:TLB_shootdowns
      7030 ±  4%     +21.0%       8504 ±  8%  interrupts.CPU84.CAL:Function_call_interrupts
      1286 ± 23%    +224.0%       4166 ± 31%  interrupts.CPU84.TLB:TLB_shootdowns
      7059           +22.4%       8644 ± 11%  interrupts.CPU85.CAL:Function_call_interrupts
      1421 ± 22%    +208.8%       4388 ± 33%  interrupts.CPU85.TLB:TLB_shootdowns
      7018 ±  2%     +22.8%       8615 ±  9%  interrupts.CPU86.CAL:Function_call_interrupts
      1258 ±  8%    +231.1%       4167 ± 34%  interrupts.CPU86.TLB:TLB_shootdowns
      1338 ±  3%    +217.9%       4255 ± 31%  interrupts.CPU87.TLB:TLB_shootdowns
      8376 ±  4%     -19.0%       6787 ±  2%  interrupts.CPU9.CAL:Function_call_interrupts
      4466 ± 17%     -71.2%       1286 ± 18%  interrupts.CPU9.TLB:TLB_shootdowns





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Oliver Sang


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.4.0-rc1-00010-g0b0695f2b34a4"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.4.0-rc1 Kernel Configuration
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
# CONFIG_HEADER_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
CONFIG_KERNEL_LZ4=y
CONFIG_DEFAULT_HOSTNAME="clr"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
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
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
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
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
CONFIG_PSI=y
# CONFIG_PSI_DEFAULT_DISABLED is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_FAST_NO_HZ=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

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
# CONFIG_CGROUP_RDMA is not set
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
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
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
# CONFIG_UID16 is not set
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_SYSCTL_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
# CONFIG_PCSPKR_PLATFORM is not set
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
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_SLUB_DEBUG is not set
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
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
# CONFIG_X86_EXTENDED_PLATFORM is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
CONFIG_MCORE2=y
# CONFIG_MATOM is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_P6_NOP=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
# CONFIG_CALGARY_IOMMU is not set
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=512
CONFIG_NR_CPUS_DEFAULT=64
CONFIG_NR_CPUS=320
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
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
CONFIG_PERF_EVENTS_AMD_POWER=m
# end of Performance monitoring

CONFIG_X86_VSYSCALL_EMULATION=y
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
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=0
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
# CONFIG_X86_INTEL_MPX is not set
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
# CONFIG_EFI_MIXED is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
# CONFIG_KEXEC is not set
# CONFIG_KEXEC_FILE is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x100000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x1000000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0x1
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_HAVE_LIVEPATCH=y
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
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ENERGY_MODEL=y
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
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_NUMA=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_TABLE_UPGRADE is not set
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_BGRT is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_HMAT=y
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=m
CONFIG_DPTF_POWER=m
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_CONFIGFS=m
CONFIG_X86_PM_TIMER=y
# CONFIG_SFI is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ=y
# CONFIG_X86_ACPI_CPUFREQ_CPB is not set
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_P4_CLOCKMOD is not set

#
# shared options
#
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
CONFIG_CPU_IDLE_GOV_TEO=y
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
CONFIG_ISCSI_IBFT=y
CONFIG_FW_CFG_SYSFS=m
CONFIG_FW_CFG_SYSFS_CMDLINE=y
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
# CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE is not set
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_BOOTLOADER_CONTROL=y
CONFIG_EFI_CAPSULE_LOADER=y
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
CONFIG_EFI_RCI2_TABLE=y
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
CONFIG_KVM=y
CONFIG_KVM_INTEL=y
CONFIG_KVM_AMD=m
CONFIG_KVM_AMD_SEV=y
CONFIG_KVM_MMU_AUDIT=y
CONFIG_VHOST_NET=y
CONFIG_VHOST_SCSI=m
CONFIG_VHOST_VSOCK=m
CONFIG_VHOST=y
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# General architecture-dependent options
#
CONFIG_HOTPLUG_SMT=y
# CONFIG_OPROFILE is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
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
# CONFIG_STACKPROTECTOR_STRONG is not set
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
CONFIG_64BIT_TIME=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
CONFIG_REFCOUNT_FULL=y
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
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
CONFIG_MODULE_SIG_FORCE=y
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
# CONFIG_MODULE_SIG_SHA256 is not set
# CONFIG_MODULE_SIG_SHA384 is not set
CONFIG_MODULE_SIG_SHA512=y
CONFIG_MODULE_SIG_HASH="sha512"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
CONFIG_BLK_DEV_THROTTLING_LOW=y
# CONFIG_BLK_CMDLINE_PARSER is not set
CONFIG_BLK_WBT=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_DEBUG_FS is not set
CONFIG_BLK_SED_OPAL=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
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
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
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
CONFIG_BINFMT_MISC=y
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
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
# CONFIG_BALLOON_COMPACTION is not set
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
# CONFIG_HWPOISON_INJECT is not set
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_ZSWAP=y
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
CONFIG_Z3FOLD=y
CONFIG_ZSMALLOC=m
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
# CONFIG_DEVICE_PRIVATE is not set
CONFIG_FRAME_VECTOR=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
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
CONFIG_PACKET_DIAG=y
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
CONFIG_XFRM_INTERFACE=m
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_XDP_SOCKETS=y
CONFIG_XDP_SOCKETS_DIAG=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_IP_FIB_TRIE_STATS is not set
CONFIG_IP_MULTIPLE_TABLES=y
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
# CONFIG_NET_IPGRE_BROADCAST is not set
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
# CONFIG_IP_PIMSM_V1 is not set
# CONFIG_IP_PIMSM_V2 is not set
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
# CONFIG_INET_DIAG is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=m
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
CONFIG_TCP_CONG_CDG=m
CONFIG_TCP_CONG_BBR=y
CONFIG_DEFAULT_BBR=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="bbr"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
CONFIG_IPV6_ILA=m
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_FOU=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_NETLABEL=y
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=y

#
# Core Netfilter Configuration
#
# CONFIG_NETFILTER_INGRESS is not set
CONFIG_NETFILTER_NETLINK=y
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=y
CONFIG_NETFILTER_NETLINK_QUEUE=y
CONFIG_NETFILTER_NETLINK_LOG=y
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
CONFIG_NF_LOG_NETDEV=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_ZONES=y
# CONFIG_NF_CONNTRACK_PROCFS is not set
CONFIG_NF_CONNTRACK_EVENTS=y
# CONFIG_NF_CONNTRACK_TIMEOUT is not set
# CONFIG_NF_CONNTRACK_TIMESTAMP is not set
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
CONFIG_NF_TABLES_SET=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_COUNTER=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
CONFIG_NFT_TUNNEL=m
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
CONFIG_NFT_XFRM=m
CONFIG_NFT_SOCKET=m
CONFIG_NFT_OSF=m
CONFIG_NFT_TPROXY=m
CONFIG_NFT_SYNPROXY=m
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=y
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
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
CONFIG_NETFILTER_XT_MATCH_IPCOMP=m
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

CONFIG_IP_SET=y
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=y
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
CONFIG_IP_VS_TAB_BITS=15

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
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_MH=m
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
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=y
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
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=y
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
CONFIG_IP6_NF_MATCH_SRH=m
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
CONFIG_NF_TABLES_BRIDGE=m
CONFIG_NFT_BRIDGE_META=m
CONFIG_NFT_BRIDGE_REJECT=m
CONFIG_NF_LOG_BRIDGE=m
CONFIG_NF_CONNTRACK_BRIDGE=m
CONFIG_BRIDGE_NF_EBTABLES=y
CONFIG_BRIDGE_EBT_BROUTE=y
CONFIG_BRIDGE_EBT_T_FILTER=y
CONFIG_BRIDGE_EBT_T_NAT=y
CONFIG_BRIDGE_EBT_802_3=y
CONFIG_BRIDGE_EBT_AMONG=y
CONFIG_BRIDGE_EBT_ARP=y
CONFIG_BRIDGE_EBT_IP=y
CONFIG_BRIDGE_EBT_IP6=y
CONFIG_BRIDGE_EBT_LIMIT=y
CONFIG_BRIDGE_EBT_MARK=y
CONFIG_BRIDGE_EBT_PKTTYPE=y
CONFIG_BRIDGE_EBT_STP=y
CONFIG_BRIDGE_EBT_VLAN=y
CONFIG_BRIDGE_EBT_ARPREPLY=y
CONFIG_BRIDGE_EBT_DNAT=y
CONFIG_BRIDGE_EBT_MARK_T=y
CONFIG_BRIDGE_EBT_REDIRECT=y
CONFIG_BRIDGE_EBT_SNAT=y
CONFIG_BRIDGE_EBT_LOG=y
CONFIG_BRIDGE_EBT_NFLOG=y
CONFIG_BPFILTER=y
CONFIG_BPFILTER_UMH=m
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
# CONFIG_SCTP_COOKIE_HMAC_SHA1 is not set
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_DIAG=m
# CONFIG_ATM is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
# CONFIG_L2TP_V3 is not set
CONFIG_STP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_HAVE_NET_DSA=y
CONFIG_NET_DSA=m
CONFIG_NET_DSA_TAG_8021Q=m
CONFIG_NET_DSA_TAG_BRCM_COMMON=m
CONFIG_NET_DSA_TAG_BRCM=m
CONFIG_NET_DSA_TAG_BRCM_PREPEND=m
CONFIG_NET_DSA_TAG_GSWIP=m
CONFIG_NET_DSA_TAG_DSA=m
CONFIG_NET_DSA_TAG_EDSA=m
CONFIG_NET_DSA_TAG_MTK=m
CONFIG_NET_DSA_TAG_KSZ=m
CONFIG_NET_DSA_TAG_QCA=m
CONFIG_NET_DSA_TAG_LAN9303=m
CONFIG_NET_DSA_TAG_SJA1105=m
CONFIG_NET_DSA_TAG_TRAILER=m
CONFIG_VLAN_8021Q=m
# CONFIG_VLAN_8021Q_GVRP is not set
# CONFIG_VLAN_8021Q_MVRP is not set
# CONFIG_DECNET is not set
CONFIG_LLC=y
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
CONFIG_6LOWPAN_GHC_EXT_HDR_HOP=m
CONFIG_6LOWPAN_GHC_UDP=m
CONFIG_6LOWPAN_GHC_ICMPV6=m
CONFIG_6LOWPAN_GHC_EXT_HDR_DEST=m
CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG=m
CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE=m
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=y
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=y
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_CBS=m
CONFIG_NET_SCH_ETF=m
CONFIG_NET_SCH_TAPRIO=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=y
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=y
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
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
# CONFIG_CLS_U32_PERF is not set
# CONFIG_CLS_U32_MARK is not set
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=y
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_EMATCH_CANID=m
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
# CONFIG_GACT_PROB is not set
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_MPLS=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_CTINFO=m
CONFIG_NET_ACT_SKBMOD=m
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_CT=m
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=m
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
CONFIG_BATMAN_ADV=m
CONFIG_BATMAN_ADV_BATMAN_V=y
CONFIG_BATMAN_ADV_BLA=y
CONFIG_BATMAN_ADV_DAT=y
# CONFIG_BATMAN_ADV_NC is not set
# CONFIG_BATMAN_ADV_MCAST is not set
# CONFIG_BATMAN_ADV_DEBUGFS is not set
# CONFIG_BATMAN_ADV_DEBUG is not set
CONFIG_BATMAN_ADV_SYSFS=y
# CONFIG_BATMAN_ADV_TRACING is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
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
CONFIG_CGROUP_NET_PRIO=y
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
CONFIG_CAN_J1939=m

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
CONFIG_CAN_VXCAN=m
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
CONFIG_CAN_KVASER_PCIEFD=m
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
CONFIG_CAN_IFI_CANFD=m
CONFIG_CAN_M_CAN=m
CONFIG_CAN_M_CAN_PLATFORM=m
CONFIG_CAN_M_CAN_TCAN4X5X=m
CONFIG_CAN_PEAK_PCIEFD=m
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
CONFIG_CAN_F81601=m
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
CONFIG_CAN_HI311X=m
# CONFIG_CAN_MCP251X is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
CONFIG_CAN_8DEV_USB=m
CONFIG_CAN_EMS_USB=m
CONFIG_CAN_ESD_USB2=m
CONFIG_CAN_GS_USB=m
CONFIG_CAN_KVASER_USB=m
CONFIG_CAN_MCBA_USB=m
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
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
CONFIG_BT_6LOWPAN=m
# CONFIG_BT_LEDS is not set
# CONFIG_BT_SELFTEST is not set
# CONFIG_BT_DEBUGFS is not set

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_RTL=m
CONFIG_BT_HCIBTUSB=m
CONFIG_BT_HCIBTUSB_AUTOSUSPEND=y
CONFIG_BT_HCIBTUSB_BCM=y
CONFIG_BT_HCIBTUSB_MTK=y
CONFIG_BT_HCIBTUSB_RTL=y
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_SERDEV=y
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_NOKIA=m
# CONFIG_BT_HCIUART_BCSP is not set
# CONFIG_BT_HCIUART_ATH3K is not set
# CONFIG_BT_HCIUART_LL is not set
# CONFIG_BT_HCIUART_3WIRE is not set
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_RTL is not set
# CONFIG_BT_HCIUART_QCA is not set
# CONFIG_BT_HCIUART_AG6XX is not set
# CONFIG_BT_HCIUART_MRVL is not set
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_BT_ATH3K=m
CONFIG_BT_MTKSDIO=m
# CONFIG_BT_MTKUART is not set
CONFIG_BT_HCIRSI=m
# end of Bluetooth device drivers

CONFIG_AF_RXRPC=m
# CONFIG_AF_RXRPC_IPV6 is not set
# CONFIG_AF_RXRPC_INJECT_LOSS is not set
# CONFIG_AF_RXRPC_DEBUG is not set
# CONFIG_RXKAD is not set
CONFIG_AF_KCM=m
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_SPY=y
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
CONFIG_CFG80211_WEXT_EXPORT=y
CONFIG_LIB80211=m
CONFIG_LIB80211_CRYPT_WEP=m
CONFIG_LIB80211_CRYPT_CCMP=m
CONFIG_LIB80211_CRYPT_TKIP=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
# CONFIG_MAC80211_DEBUGFS is not set
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
CONFIG_RFKILL_GPIO=m
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
# CONFIG_CEPH_LIB_USE_DNS_RESOLVER is not set
CONFIG_NFC=m
CONFIG_NFC_DIGITAL=m
CONFIG_NFC_NCI=m
# CONFIG_NFC_NCI_SPI is not set
# CONFIG_NFC_NCI_UART is not set
CONFIG_NFC_HCI=m
# CONFIG_NFC_SHDLC is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_TRF7970A=m
CONFIG_NFC_MEI_PHY=m
CONFIG_NFC_SIM=m
CONFIG_NFC_PORT100=m
# CONFIG_NFC_FDP is not set
CONFIG_NFC_PN544=m
CONFIG_NFC_PN544_MEI=m
CONFIG_NFC_PN533=m
CONFIG_NFC_PN533_USB=m
CONFIG_NFC_PN533_I2C=m
CONFIG_NFC_MICROREAD=m
CONFIG_NFC_MICROREAD_MEI=m
CONFIG_NFC_MRVL=m
CONFIG_NFC_MRVL_USB=m
# CONFIG_NFC_MRVL_I2C is not set
# CONFIG_NFC_ST_NCI_I2C is not set
# CONFIG_NFC_ST_NCI_SPI is not set
CONFIG_NFC_NXP_NCI=m
CONFIG_NFC_NXP_NCI_I2C=m
# CONFIG_NFC_S3FWRN5_I2C is not set
# CONFIG_NFC_ST95HF is not set
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=m
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
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
# CONFIG_PCIEAER_INJECT is not set
# CONFIG_PCIE_ECRC is not set
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEBUG is not set
# CONFIG_PCIEASPM_DEFAULT is not set
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
CONFIG_PCIEASPM_PERFORMANCE=y
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
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support

CONFIG_VMD=m

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCIE_DW_EP=y
CONFIG_PCIE_DW_PLAT=y
CONFIG_PCIE_DW_PLAT_HOST=y
CONFIG_PCIE_DW_PLAT_EP=y
CONFIG_PCI_MESON=y
# end of DesignWare PCI Core Support
# end of PCI controller drivers

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
CONFIG_PCI_ENDPOINT_CONFIGFS=y
# CONFIG_PCI_EPF_TEST is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=m
# end of PCI switch controller drivers

# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
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
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_HMEM_REPORTING=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_MMIO=m
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SCCB=m
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
CONFIG_MTD_CFI=m
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=m
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_NOSWAP=y
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
CONFIG_MTD_CFI_GEOMETRY=y
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_MAP_BANK_WIDTH_8=y
CONFIG_MTD_MAP_BANK_WIDTH_16=y
CONFIG_MTD_MAP_BANK_WIDTH_32=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_I4=y
CONFIG_MTD_CFI_I8=y
# CONFIG_MTD_OTP is not set
CONFIG_MTD_CFI_INTELEXT=m
# CONFIG_MTD_CFI_AMDSTD is not set
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=m
CONFIG_MTD_RAM=m
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_SBC_GXX is not set
# CONFIG_MTD_PCI is not set
CONFIG_MTD_INTEL_VR_NOR=m
CONFIG_MTD_PLATRAM=m
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
CONFIG_MTD_BLOCK2MTD=m

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

CONFIG_MTD_NAND_CORE=m
# CONFIG_MTD_ONENAND is not set
CONFIG_MTD_NAND_ECC_SW_HAMMING=m
# CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
CONFIG_MTD_RAW_NAND=m
# CONFIG_MTD_NAND_ECC_SW_BCH is not set

#
# Raw/parallel NAND flash controllers
#
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_CAFE is not set
# CONFIG_MTD_NAND_MXIC is not set
CONFIG_MTD_NAND_GPIO=m
CONFIG_MTD_NAND_PLATFORM=m

#
# Misc
#
CONFIG_MTD_SM_COMMON=m
# CONFIG_MTD_NAND_NANDSIM is not set
CONFIG_MTD_NAND_RICOH=m
# CONFIG_MTD_NAND_DISKONCHIP is not set
CONFIG_MTD_SPI_NAND=m

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
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
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
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
# CONFIG_ZRAM is not set
CONFIG_BLK_DEV_UMEM=m
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
CONFIG_BLK_DEV_CRYPTOLOOP=y
CONFIG_BLK_DEV_DRBD=m
# CONFIG_DRBD_FAULT_INJECTION is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_SKD=m
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=y
CONFIG_VIRTIO_BLK_SCSI=y
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
CONFIG_NVME_TCP=m
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
CONFIG_NVME_TARGET_TCP=m
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
CONFIG_IBM_ASM=m
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_HP_ILO=m
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
CONFIG_MISC_RTSX=y
CONFIG_PVPANIC=m
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
CONFIG_EEPROM_IDT_89HPESX=m
CONFIG_EEPROM_EE1004=m
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
CONFIG_INTEL_MEI_TXE=m
CONFIG_INTEL_MEI_HDCP=m
CONFIG_VMWARE_VMCI=m

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
CONFIG_INTEL_MIC_BUS=m

#
# SCIF Bus Driver
#
CONFIG_SCIF_BUS=m

#
# VOP Bus Driver
#
CONFIG_VOP_BUS=m

#
# Intel MIC Host Driver
#
CONFIG_INTEL_MIC_HOST=m

#
# Intel MIC Card Driver
#
CONFIG_INTEL_MIC_CARD=m

#
# SCIF Driver
#
CONFIG_SCIF=m

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#
CONFIG_MIC_COSM=m

#
# VOP Driver
#
CONFIG_VOP=m
CONFIG_VHOST_RING=m
# end of Intel MIC & related support

# CONFIG_GENWQE is not set
CONFIG_ECHO=m
CONFIG_MISC_ALCOR_PCI=m
CONFIG_MISC_RTSX_PCI=y
CONFIG_MISC_RTSX_USB=m
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_FC_ATTRS=y
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=y
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
CONFIG_BLK_DEV_3W_XXXX_RAID=m
CONFIG_SCSI_HPSA=y
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
CONFIG_SCSI_ACARD=m
CONFIG_SCSI_AACRAID=m
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=5000
CONFIG_AIC79XX_DEBUG_ENABLE=y
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_AIC79XX_REG_PRETTY_PRINT=y
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
CONFIG_SCSI_MVSAS_DEBUG=y
# CONFIG_SCSI_MVSAS_TASKLET is not set
CONFIG_SCSI_MVUMI=m
# CONFIG_SCSI_DPT_I2O is not set
CONFIG_SCSI_ADVANSYS=m
CONFIG_SCSI_ARCMSR=m
CONFIG_SCSI_ESAS2R=m
# CONFIG_MEGARAID_NEWGEN is not set
CONFIG_MEGARAID_LEGACY=m
CONFIG_MEGARAID_SAS=y
CONFIG_SCSI_MPT3SAS=y
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=y
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
CONFIG_SCSI_UFS_BSG=y
CONFIG_SCSI_HPTIOP=m
CONFIG_SCSI_BUSLOGIC=y
# CONFIG_SCSI_FLASHPOINT is not set
CONFIG_SCSI_MYRB=m
CONFIG_SCSI_MYRS=m
CONFIG_VMWARE_PVSCSI=y
CONFIG_LIBFC=y
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
CONFIG_SCSI_SNIC=m
# CONFIG_SCSI_SNIC_DEBUG_FS is not set
CONFIG_SCSI_DMX3191D=m
CONFIG_SCSI_FDOMAIN=m
CONFIG_SCSI_FDOMAIN_PCI=m
CONFIG_SCSI_GDTH=m
CONFIG_SCSI_ISCI=y
CONFIG_SCSI_IPS=m
CONFIG_SCSI_INITIO=m
CONFIG_SCSI_INIA100=m
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_STEX=m
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
CONFIG_SCSI_SYM53C8XX_MMIO=y
CONFIG_SCSI_IPR=m
CONFIG_SCSI_IPR_TRACE=y
CONFIG_SCSI_IPR_DUMP=y
CONFIG_SCSI_QLOGIC_1280=m
CONFIG_SCSI_QLA_FC=m
CONFIG_TCM_QLA2XXX=m
# CONFIG_TCM_QLA2XXX_DEBUG is not set
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_QEDI is not set
# CONFIG_QEDF is not set
# CONFIG_SCSI_LPFC is not set
CONFIG_SCSI_DC395x=m
CONFIG_SCSI_AM53C974=m
CONFIG_SCSI_WD719X=m
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=y
CONFIG_SCSI_CHELSIO_FCOE=m
# CONFIG_SCSI_DH is not set
# end of SCSI device support

CONFIG_ATA=y
# CONFIG_ATA_VERBOSE_ERROR is not set
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=y
CONFIG_SATA_INIC162X=m
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
CONFIG_ATA_PIIX=y
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
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
CONFIG_PATA_SCH=y
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
CONFIG_PATA_SIS=m
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
CONFIG_PATA_MPIIX=y
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=m
CONFIG_ATA_GENERIC=y
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_AUTODETECT is not set
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID10=y
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
# CONFIG_MD_CLUSTER is not set
CONFIG_BCACHE=m
# CONFIG_BCACHE_DEBUG is not set
# CONFIG_BCACHE_CLOSURES_DEBUG is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=y
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
CONFIG_DM_UNSTRIPED=m
CONFIG_DM_CRYPT=y
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_ERA is not set
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
# CONFIG_DM_INIT is not set
# CONFIG_DM_UEVENT is not set
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=y
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_DM_ZONED=m
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
CONFIG_ISCSI_TARGET_CXGB4=m
CONFIG_FUSION=y
CONFIG_FUSION_SPI=y
CONFIG_FUSION_FC=m
CONFIG_FUSION_SAS=y
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
# CONFIG_FUSION_LOGGING is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
CONFIG_EQUALIZER=m
# CONFIG_NET_FC is not set
CONFIG_IFB=m
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=y
CONFIG_MACVTAP=y
CONFIG_IPVLAN_L3S=y
CONFIG_IPVLAN=m
CONFIG_IPVTAP=m
CONFIG_VXLAN=m
CONFIG_GENEVE=m
CONFIG_GTP=m
CONFIG_MACSEC=m
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_NTB_NETDEV=m
CONFIG_TUN=y
CONFIG_TAP=y
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
CONFIG_NLMON=m
CONFIG_NET_VRF=m
CONFIG_VSOCKMON=m
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_B53=m
CONFIG_B53_SPI_DRIVER=m
CONFIG_B53_MDIO_DRIVER=m
CONFIG_B53_MMAP_DRIVER=m
CONFIG_B53_SRAB_DRIVER=m
CONFIG_B53_SERDES=m
CONFIG_NET_DSA_BCM_SF2=m
CONFIG_NET_DSA_LOOP=m
CONFIG_NET_DSA_LANTIQ_GSWIP=m
CONFIG_NET_DSA_MT7530=m
CONFIG_NET_DSA_MV88E6060=m
CONFIG_NET_DSA_MICROCHIP_KSZ_COMMON=m
CONFIG_NET_DSA_MICROCHIP_KSZ9477=m
CONFIG_NET_DSA_MICROCHIP_KSZ9477_I2C=m
CONFIG_NET_DSA_MICROCHIP_KSZ9477_SPI=m
# CONFIG_NET_DSA_MICROCHIP_KSZ8795 is not set
CONFIG_NET_DSA_MV88E6XXX=m
CONFIG_NET_DSA_MV88E6XXX_GLOBAL2=y
# CONFIG_NET_DSA_MV88E6XXX_PTP is not set
CONFIG_NET_DSA_SJA1105=m
CONFIG_NET_DSA_SJA1105_PTP=y
# CONFIG_NET_DSA_SJA1105_TAS is not set
CONFIG_NET_DSA_QCA8K=m
# CONFIG_NET_DSA_REALTEK_SMI is not set
CONFIG_NET_DSA_SMSC_LAN9303=m
CONFIG_NET_DSA_SMSC_LAN9303_I2C=m
CONFIG_NET_DSA_SMSC_LAN9303_MDIO=m
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=m
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
CONFIG_ET131X=m
# CONFIG_NET_VENDOR_ALACRITECH is not set
# CONFIG_NET_VENDOR_ALTEON is not set
CONFIG_ALTERA_TSE=m
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_ENA_ETHERNET=m
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
CONFIG_PCNET32=y
# CONFIG_AMD_XGBE is not set
# CONFIG_NET_VENDOR_AQUANTIA is not set
# CONFIG_NET_VENDOR_ARC is not set
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=m
CONFIG_ATL1=m
CONFIG_ATL1E=m
CONFIG_ATL1C=m
CONFIG_ALX=m
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
CONFIG_BCMGENET=m
CONFIG_BNX2=m
CONFIG_CNIC=m
CONFIG_TIGON3=m
# CONFIG_TIGON3_HWMON is not set
CONFIG_BNX2X=m
CONFIG_BNX2X_SRIOV=y
# CONFIG_SYSTEMPORT is not set
CONFIG_BNXT=m
CONFIG_BNXT_SRIOV=y
CONFIG_BNXT_FLOWER_OFFLOAD=y
# CONFIG_BNXT_DCB is not set
CONFIG_BNXT_HWMON=y
# CONFIG_NET_VENDOR_BROCADE is not set
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_MACB=m
CONFIG_MACB_USE_HWSTAMP=y
CONFIG_MACB_PCI=m
# CONFIG_NET_VENDOR_CAVIUM is not set
CONFIG_NET_VENDOR_CHELSIO=y
CONFIG_CHELSIO_T1=m
# CONFIG_CHELSIO_T1_1G is not set
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
# CONFIG_NET_VENDOR_DEC is not set
CONFIG_NET_VENDOR_DLINK=y
CONFIG_DL2K=m
CONFIG_SUNDANCE=m
CONFIG_SUNDANCE_MMIO=y
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
# CONFIG_NET_VENDOR_EZCHIP is not set
CONFIG_NET_VENDOR_GOOGLE=y
CONFIG_GVE=m
# CONFIG_NET_VENDOR_HP is not set
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_HINIC=m
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
CONFIG_E100=y
CONFIG_E1000=y
CONFIG_E1000E=m
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
# CONFIG_IGB_HWMON is not set
CONFIG_IGB_DCA=y
CONFIG_IGBVF=m
CONFIG_IXGB=m
CONFIG_IXGBE=m
# CONFIG_IXGBE_HWMON is not set
CONFIG_IXGBE_DCA=y
# CONFIG_IXGBE_DCB is not set
CONFIG_IXGBE_IPSEC=y
CONFIG_IXGBEVF=m
CONFIG_IXGBEVF_IPSEC=y
CONFIG_I40E=m
CONFIG_I40E_DCB=y
CONFIG_IAVF=m
CONFIG_I40EVF=m
CONFIG_ICE=m
CONFIG_FM10K=m
CONFIG_IGC=m
CONFIG_JME=m
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
CONFIG_SKGE=m
CONFIG_SKGE_DEBUG=y
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
# CONFIG_NET_VENDOR_MICROSEMI is not set
# CONFIG_NET_VENDOR_MYRI is not set
CONFIG_FEALNX=m
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_NET_VENDOR_NETERION is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NFP=m
CONFIG_NFP_APP_FLOWER=y
CONFIG_NFP_APP_ABM_NIC=y
# CONFIG_NFP_DEBUG is not set
CONFIG_NET_VENDOR_NI=y
CONFIG_NI_XGE_MANAGEMENT_ENET=m
# CONFIG_NET_VENDOR_NVIDIA is not set
# CONFIG_NET_VENDOR_OKI is not set
CONFIG_ETHOC=m
CONFIG_NET_VENDOR_PACKET_ENGINES=y
CONFIG_HAMACHI=m
CONFIG_YELLOWFIN=m
# CONFIG_NET_VENDOR_PENSANDO is not set
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
CONFIG_NETXEN_NIC=m
CONFIG_QED=m
CONFIG_QED_SRIOV=y
# CONFIG_QEDE is not set
# CONFIG_NET_VENDOR_QUALCOMM is not set
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
CONFIG_ATP=m
CONFIG_8139CP=m
CONFIG_8139TOO=m
CONFIG_8139TOO_PIO=y
CONFIG_8139TOO_TUNE_TWISTER=y
CONFIG_8139TOO_8129=y
CONFIG_8139_OLD_RX_RESET=y
CONFIG_R8169=m
# CONFIG_NET_VENDOR_RENESAS is not set
# CONFIG_NET_VENDOR_ROCKER is not set
# CONFIG_NET_VENDOR_SAMSUNG is not set
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
# CONFIG_NET_VENDOR_SMSC is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
# CONFIG_NET_VENDOR_SYNOPSYS is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_NET_VENDOR_XILINX is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=m
CONFIG_MDIO_BUS=m
CONFIG_MDIO_BCM_UNIMAC=m
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_GPIO is not set
CONFIG_MDIO_I2C=m
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLINK=m
CONFIG_PHYLIB=m
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
CONFIG_SFP=m
# CONFIG_ADIN_PHY is not set
CONFIG_AMD_PHY=m
CONFIG_AQUANTIA_PHY=m
CONFIG_AX88796B_PHY=m
CONFIG_AT803X_PHY=m
CONFIG_BCM7XXX_PHY=m
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_BROADCOM_PHY=m
CONFIG_CICADA_PHY=m
CONFIG_CORTINA_PHY=m
CONFIG_DAVICOM_PHY=m
CONFIG_DP83822_PHY=m
# CONFIG_DP83TC811_PHY is not set
CONFIG_DP83848_PHY=m
# CONFIG_DP83867_PHY is not set
CONFIG_FIXED_PHY=m
CONFIG_ICPLUS_PHY=m
CONFIG_INTEL_XWAY_PHY=m
CONFIG_LSI_ET1011C_PHY=m
CONFIG_LXT_PHY=m
CONFIG_MARVELL_PHY=m
CONFIG_MARVELL_10G_PHY=m
CONFIG_MICREL_PHY=m
CONFIG_MICROCHIP_PHY=m
# CONFIG_MICROCHIP_T1_PHY is not set
CONFIG_MICROSEMI_PHY=m
CONFIG_NATIONAL_PHY=m
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=m
CONFIG_RENESAS_PHY=m
CONFIG_ROCKCHIP_PHY=m
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
CONFIG_TERANETICS_PHY=m
CONFIG_VITESSE_PHY=m
CONFIG_XILINX_GMII2RGMII=m
# CONFIG_MICREL_KS8995MA is not set
CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_MPPE=m
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=m
# CONFIG_SLIP_COMPRESSED is not set
# CONFIG_SLIP_SMART is not set
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_USB_NET_DRIVERS=m
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_RTL8152=m
CONFIG_USB_LAN78XX=m
CONFIG_USB_USBNET=m
CONFIG_USB_NET_AX8817X=m
CONFIG_USB_NET_AX88179_178A=m
CONFIG_USB_NET_CDCETHER=m
CONFIG_USB_NET_CDC_EEM=m
CONFIG_USB_NET_CDC_NCM=m
CONFIG_USB_NET_HUAWEI_CDC_NCM=m
CONFIG_USB_NET_CDC_MBIM=m
CONFIG_USB_NET_DM9601=m
CONFIG_USB_NET_SR9700=m
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=m
CONFIG_USB_NET_SMSC95XX=m
CONFIG_USB_NET_GL620A=m
CONFIG_USB_NET_NET1080=m
CONFIG_USB_NET_PLUSB=m
CONFIG_USB_NET_MCS7830=m
CONFIG_USB_NET_RNDIS_HOST=m
CONFIG_USB_NET_CDC_SUBSET_ENABLE=m
CONFIG_USB_NET_CDC_SUBSET=m
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
# CONFIG_USB_EPSON2888 is not set
# CONFIG_USB_KC2190 is not set
CONFIG_USB_NET_ZAURUS=m
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
CONFIG_USB_NET_INT51X1=m
CONFIG_USB_IPHETH=m
CONFIG_USB_SIERRA_NET=m
CONFIG_USB_VL600=m
CONFIG_USB_NET_CH9200=m
CONFIG_USB_NET_AQC111=m
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_ATH_COMMON=m
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
CONFIG_ATH5K=m
# CONFIG_ATH5K_DEBUG is not set
# CONFIG_ATH5K_TRACER is not set
CONFIG_ATH5K_PCI=y
CONFIG_ATH9K_HW=m
CONFIG_ATH9K_COMMON=m
CONFIG_ATH9K_BTCOEX_SUPPORT=y
# CONFIG_ATH9K is not set
CONFIG_ATH9K_HTC=m
# CONFIG_ATH9K_HTC_DEBUGFS is not set
# CONFIG_CARL9170 is not set
CONFIG_ATH6KL=m
CONFIG_ATH6KL_SDIO=m
CONFIG_ATH6KL_USB=m
# CONFIG_ATH6KL_DEBUG is not set
# CONFIG_ATH6KL_TRACING is not set
CONFIG_AR5523=m
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
CONFIG_WCN36XX=m
# CONFIG_WCN36XX_DEBUGFS is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_B43=m
CONFIG_B43_BCMA=y
CONFIG_B43_SSB=y
CONFIG_B43_BUSES_BCMA_AND_SSB=y
# CONFIG_B43_BUSES_BCMA is not set
# CONFIG_B43_BUSES_SSB is not set
CONFIG_B43_PCI_AUTOSELECT=y
CONFIG_B43_PCICORE_AUTOSELECT=y
CONFIG_B43_SDIO=y
CONFIG_B43_BCMA_PIO=y
CONFIG_B43_PIO=y
CONFIG_B43_PHY_G=y
CONFIG_B43_PHY_N=y
CONFIG_B43_PHY_LP=y
CONFIG_B43_PHY_HT=y
CONFIG_B43_LEDS=y
CONFIG_B43_HWRNG=y
# CONFIG_B43_DEBUG is not set
CONFIG_B43LEGACY=m
CONFIG_B43LEGACY_PCI_AUTOSELECT=y
CONFIG_B43LEGACY_PCICORE_AUTOSELECT=y
CONFIG_B43LEGACY_LEDS=y
CONFIG_B43LEGACY_HWRNG=y
CONFIG_B43LEGACY_DEBUG=y
CONFIG_B43LEGACY_DMA=y
CONFIG_B43LEGACY_PIO=y
CONFIG_B43LEGACY_DMA_AND_PIO_MODE=y
# CONFIG_B43LEGACY_DMA_MODE is not set
# CONFIG_B43LEGACY_PIO_MODE is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_IPW2100=m
# CONFIG_IPW2100_MONITOR is not set
# CONFIG_IPW2100_DEBUG is not set
CONFIG_IPW2200=m
# CONFIG_IPW2200_MONITOR is not set
# CONFIG_IPW2200_QOS is not set
# CONFIG_IPW2200_DEBUG is not set
CONFIG_LIBIPW=m
# CONFIG_LIBIPW_DEBUG is not set
CONFIG_IWLEGACY=m
CONFIG_IWL4965=m
CONFIG_IWL3945=m

#
# iwl3945 / iwl4965 Debugging Options
#
# CONFIG_IWLEGACY_DEBUG is not set
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
# CONFIG_IWLWIFI_DEVICE_TRACING is not set
# end of Debugging Options

CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
CONFIG_HERMES=m
# CONFIG_HERMES_PRISM is not set
CONFIG_HERMES_CACHE_FW_ON_INIT=y
CONFIG_PLX_HERMES=m
# CONFIG_TMD_HERMES is not set
CONFIG_NORTEL_HERMES=m
CONFIG_ORINOCO_USB=m
CONFIG_P54_COMMON=m
CONFIG_P54_USB=m
CONFIG_P54_PCI=m
# CONFIG_P54_SPI is not set
CONFIG_P54_LEDS=y
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_LIBERTAS=m
CONFIG_LIBERTAS_USB=m
CONFIG_LIBERTAS_SDIO=m
# CONFIG_LIBERTAS_SPI is not set
# CONFIG_LIBERTAS_DEBUG is not set
# CONFIG_LIBERTAS_MESH is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_MT7601U=m
CONFIG_MT76_CORE=m
CONFIG_MT76_LEDS=y
CONFIG_MT76_USB=m
CONFIG_MT76x02_LIB=m
CONFIG_MT76x02_USB=m
CONFIG_MT76x0_COMMON=m
CONFIG_MT76x0U=m
CONFIG_MT76x0E=m
CONFIG_MT76x2_COMMON=m
CONFIG_MT76x2E=m
CONFIG_MT76x2U=m
# CONFIG_MT7603E is not set
CONFIG_MT7615E=m
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_RTL8180=m
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
CONFIG_RTL8192CE=m
CONFIG_RTL8192SE=m
CONFIG_RTL8192DE=m
CONFIG_RTL8723AE=m
CONFIG_RTL8723BE=m
CONFIG_RTL8188EE=m
CONFIG_RTL8192EE=m
CONFIG_RTL8821AE=m
CONFIG_RTL8192CU=m
CONFIG_RTLWIFI=m
CONFIG_RTLWIFI_PCI=m
CONFIG_RTLWIFI_USB=m
# CONFIG_RTLWIFI_DEBUG is not set
CONFIG_RTL8192C_COMMON=m
CONFIG_RTL8723_COMMON=m
CONFIG_RTLBTCOEXIST=m
CONFIG_RTL8XXXU=m
# CONFIG_RTL8XXXU_UNTESTED is not set
CONFIG_RTW88=m
CONFIG_RTW88_CORE=m
CONFIG_RTW88_PCI=m
CONFIG_RTW88_8822BE=y
CONFIG_RTW88_8822CE=y
# CONFIG_RTW88_DEBUG is not set
# CONFIG_RTW88_DEBUGFS is not set
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_RSI_91X=m
CONFIG_RSI_DEBUGFS=y
CONFIG_RSI_SDIO=m
CONFIG_RSI_USB=m
CONFIG_RSI_COEX=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_CW1200=m
CONFIG_CW1200_WLAN_SDIO=m
CONFIG_CW1200_WLAN_SPI=m
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WL1251=m
CONFIG_WL1251_SPI=m
CONFIG_WL1251_SDIO=m
CONFIG_WL12XX=m
CONFIG_WL18XX=m
CONFIG_WLCORE=m
CONFIG_WLCORE_SDIO=m
CONFIG_WILINK_PLATFORM_DATA=y
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
CONFIG_ZD1211RW=m
# CONFIG_ZD1211RW_DEBUG is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
CONFIG_QTNFMAC=m
CONFIG_QTNFMAC_PCIE=m
CONFIG_MAC80211_HWSIM=m
CONFIG_USB_NET_RNDIS_WLAN=m
CONFIG_VIRT_WIFI=m

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
CONFIG_IEEE802154_AT86RF230=m
# CONFIG_IEEE802154_AT86RF230_DEBUGFS is not set
CONFIG_IEEE802154_MRF24J40=m
CONFIG_IEEE802154_CC2520=m
CONFIG_IEEE802154_ATUSB=m
CONFIG_IEEE802154_ADF7242=m
CONFIG_IEEE802154_CA8210=m
# CONFIG_IEEE802154_CA8210_DEBUGFS is not set
CONFIG_IEEE802154_MCR20A=m
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_VMXNET3=m
CONFIG_FUJITSU_ES=y
CONFIG_THUNDERBOLT_NET=m
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
CONFIG_INPUT_MATRIXKMAP=m

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
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
CONFIG_KEYBOARD_APPLESPI=m
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1050=m
CONFIG_KEYBOARD_QT1070=m
# CONFIG_KEYBOARD_QT2160 is not set
CONFIG_KEYBOARD_DLINK_DIR685=m
# CONFIG_KEYBOARD_LKKBD is not set
CONFIG_KEYBOARD_GPIO=m
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
CONFIG_KEYBOARD_LM8323=m
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
CONFIG_KEYBOARD_TM2_TOUCHKEY=m
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_KEYBOARD_CROS_EC=m
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_MOUSE_PS2_ALPS=y
# CONFIG_MOUSE_PS2_BYD is not set
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
# CONFIG_MOUSE_ELAN_I2C_SMBUS is not set
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_GRIP_MP is not set
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDJOY is not set
# CONFIG_JOYSTICK_ZHENHUA is not set
# CONFIG_JOYSTICK_DB9 is not set
# CONFIG_JOYSTICK_GAMECON is not set
# CONFIG_JOYSTICK_TURBOGRAFX is not set
# CONFIG_JOYSTICK_AS5011 is not set
# CONFIG_JOYSTICK_JOYDUMP is not set
CONFIG_JOYSTICK_XPAD=m
CONFIG_JOYSTICK_XPAD_FF=y
CONFIG_JOYSTICK_XPAD_LEDS=y
# CONFIG_JOYSTICK_WALKERA0701 is not set
# CONFIG_JOYSTICK_PSXPAD_SPI is not set
# CONFIG_JOYSTICK_PXRC is not set
# CONFIG_JOYSTICK_FSIA6B is not set
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
CONFIG_TOUCHSCREEN_ADS7846=m
CONFIG_TOUCHSCREEN_AD7877=m
CONFIG_TOUCHSCREEN_AD7879=m
CONFIG_TOUCHSCREEN_AD7879_I2C=m
CONFIG_TOUCHSCREEN_AD7879_SPI=m
CONFIG_TOUCHSCREEN_ADC=m
CONFIG_TOUCHSCREEN_ATMEL_MXT=m
CONFIG_TOUCHSCREEN_ATMEL_MXT_T37=y
CONFIG_TOUCHSCREEN_AUO_PIXCIR=m
CONFIG_TOUCHSCREEN_BU21013=m
CONFIG_TOUCHSCREEN_BU21029=m
CONFIG_TOUCHSCREEN_CHIPONE_ICN8505=m
CONFIG_TOUCHSCREEN_CY8CTMG110=m
CONFIG_TOUCHSCREEN_CYTTSP_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP_I2C=m
CONFIG_TOUCHSCREEN_CYTTSP_SPI=m
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=m
CONFIG_TOUCHSCREEN_CYTTSP4_SPI=m
CONFIG_TOUCHSCREEN_DYNAPRO=m
CONFIG_TOUCHSCREEN_HAMPSHIRE=m
CONFIG_TOUCHSCREEN_EETI=m
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=m
CONFIG_TOUCHSCREEN_EXC3000=m
CONFIG_TOUCHSCREEN_FUJITSU=m
CONFIG_TOUCHSCREEN_GOODIX=m
CONFIG_TOUCHSCREEN_HIDEEP=m
CONFIG_TOUCHSCREEN_ILI210X=m
CONFIG_TOUCHSCREEN_S6SY761=m
CONFIG_TOUCHSCREEN_GUNZE=m
CONFIG_TOUCHSCREEN_EKTF2127=m
CONFIG_TOUCHSCREEN_ELAN=m
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
CONFIG_TOUCHSCREEN_MAX11801=m
CONFIG_TOUCHSCREEN_MCS5000=m
CONFIG_TOUCHSCREEN_MMS114=m
CONFIG_TOUCHSCREEN_MELFAS_MIP4=m
CONFIG_TOUCHSCREEN_MTOUCH=m
CONFIG_TOUCHSCREEN_INEXIO=m
CONFIG_TOUCHSCREEN_MK712=m
CONFIG_TOUCHSCREEN_PENMOUNT=m
CONFIG_TOUCHSCREEN_EDT_FT5X06=m
CONFIG_TOUCHSCREEN_TOUCHRIGHT=m
CONFIG_TOUCHSCREEN_TOUCHWIN=m
CONFIG_TOUCHSCREEN_PIXCIR=m
CONFIG_TOUCHSCREEN_WDT87XX_I2C=m
CONFIG_TOUCHSCREEN_WM97XX=m
CONFIG_TOUCHSCREEN_WM9705=y
CONFIG_TOUCHSCREEN_WM9712=y
CONFIG_TOUCHSCREEN_WM9713=y
CONFIG_TOUCHSCREEN_USB_COMPOSITE=m
CONFIG_TOUCHSCREEN_USB_EGALAX=y
CONFIG_TOUCHSCREEN_USB_PANJIT=y
CONFIG_TOUCHSCREEN_USB_3M=y
CONFIG_TOUCHSCREEN_USB_ITM=y
CONFIG_TOUCHSCREEN_USB_ETURBO=y
CONFIG_TOUCHSCREEN_USB_GUNZE=y
CONFIG_TOUCHSCREEN_USB_DMC_TSC10=y
CONFIG_TOUCHSCREEN_USB_IRTOUCH=y
CONFIG_TOUCHSCREEN_USB_IDEALTEK=y
CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=y
CONFIG_TOUCHSCREEN_USB_GOTOP=y
CONFIG_TOUCHSCREEN_USB_JASTEC=y
CONFIG_TOUCHSCREEN_USB_ELO=y
CONFIG_TOUCHSCREEN_USB_E2I=y
CONFIG_TOUCHSCREEN_USB_ZYTRONIC=y
CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
CONFIG_TOUCHSCREEN_USB_NEXIO=y
CONFIG_TOUCHSCREEN_USB_EASYTOUCH=y
CONFIG_TOUCHSCREEN_TOUCHIT213=m
CONFIG_TOUCHSCREEN_TSC_SERIO=m
CONFIG_TOUCHSCREEN_TSC200X_CORE=m
CONFIG_TOUCHSCREEN_TSC2004=m
CONFIG_TOUCHSCREEN_TSC2005=m
CONFIG_TOUCHSCREEN_TSC2007=m
# CONFIG_TOUCHSCREEN_TSC2007_IIO is not set
CONFIG_TOUCHSCREEN_RM_TS=m
CONFIG_TOUCHSCREEN_SILEAD=m
CONFIG_TOUCHSCREEN_SIS_I2C=m
CONFIG_TOUCHSCREEN_ST1232=m
CONFIG_TOUCHSCREEN_STMFTS=m
CONFIG_TOUCHSCREEN_SUR40=m
CONFIG_TOUCHSCREEN_SURFACE3_SPI=m
CONFIG_TOUCHSCREEN_SX8654=m
CONFIG_TOUCHSCREEN_TPS6507X=m
CONFIG_TOUCHSCREEN_ZET6223=m
CONFIG_TOUCHSCREEN_ZFORCE=m
CONFIG_TOUCHSCREEN_ROHM_BU21023=m
CONFIG_TOUCHSCREEN_IQS5XX=m
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
CONFIG_INPUT_E3X0_BUTTON=m
# CONFIG_INPUT_MSM_VIBRATOR is not set
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
CONFIG_INPUT_GP2A=m
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
CONFIG_INPUT_KXTJ9=m
# CONFIG_INPUT_KXTJ9_POLLED_MODE is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
# CONFIG_INPUT_REGULATOR_HAPTIC is not set
CONFIG_INPUT_UINPUT=y
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
CONFIG_INPUT_PWM_VIBRA=m
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
CONFIG_INPUT_CMA3000=m
CONFIG_INPUT_CMA3000_I2C=m
CONFIG_INPUT_IDEAPAD_SLIDEBAR=m
CONFIG_INPUT_SOC_BUTTON_ARRAY=m
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_SERIO_GPIO_PS2=m
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_GAMEPORT_FM801=m
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
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_NOZOMI=m
CONFIG_N_GSM=m
# CONFIG_TRACE_SINK is not set
CONFIG_NULL_TTY=m
CONFIG_LDISC_AUTOLOAD=y
# CONFIG_DEVMEM is not set
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=m
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=m
# CONFIG_SERIAL_8250_MID is not set

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
CONFIG_SERIAL_DEV_BUS=m
CONFIG_TTY_PRINTK=y
CONFIG_TTY_PRINTK_LEVEL=6
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_HVC_DRIVER=y
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
CONFIG_IPMB_DEVICE_INTERFACE=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=m
# CONFIG_APPLICOM is not set
CONFIG_MWAVE=m
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_HPET_MMAP_DEFAULT=y
CONFIG_HANGCHECK_TIMER=m
CONFIG_TCG_TPM=m
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=m
CONFIG_TCG_TIS=m
CONFIG_TCG_TIS_SPI=m
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=m
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
CONFIG_DEVPORT=y
CONFIG_XILLYBUS=m
CONFIG_XILLYBUS_PCIE=m
# end of Character devices

CONFIG_RANDOM_TRUST_CPU=y
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=m
CONFIG_I2C_MUX_LTC4306=m
CONFIG_I2C_MUX_PCA9541=m
CONFIG_I2C_MUX_PCA954x=m
CONFIG_I2C_MUX_REG=m
CONFIG_I2C_MUX_MLXCPLD=m
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
CONFIG_I2C_AMD_MP2=m
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
CONFIG_I2C_NVIDIA_GPU=m
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
CONFIG_I2C_DESIGNWARE_SLAVE=y
CONFIG_I2C_DESIGNWARE_PCI=y
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
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
CONFIG_I2C_MLXCPLD=m
CONFIG_I2C_CROS_EC_TUNNEL=m
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=m
CONFIG_CDNS_I3C_MASTER=m
CONFIG_DW_I3C_MASTER=m
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=m
# CONFIG_SPI_AXI_SPI_ENGINE is not set
CONFIG_SPI_BITBANG=m
# CONFIG_SPI_BUTTERFLY is not set
CONFIG_SPI_CADENCE=m
CONFIG_SPI_DESIGNWARE=m
CONFIG_SPI_DW_PCI=m
CONFIG_SPI_DW_MID_DMA=y
CONFIG_SPI_DW_MMIO=m
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_OC_TINY is not set
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
# CONFIG_SPI_ROCKCHIP is not set
CONFIG_SPI_SC18IS602=m
# CONFIG_SPI_SIFIVE is not set
CONFIG_SPI_MXIC=m
CONFIG_SPI_XCOMM=m
CONFIG_SPI_XILINX=m
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
CONFIG_PTP_1588_CLOCK_KVM=y
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
CONFIG_PINCTRL_CHERRYVIEW=m
CONFIG_PINCTRL_INTEL=m
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=m
CONFIG_PINCTRL_GEMINILAKE=m
CONFIG_PINCTRL_ICELAKE=m
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
CONFIG_GPIO_EXAR=m
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
CONFIG_GPIO_LYNXPOINT=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
CONFIG_GPIO_IT87=m
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
CONFIG_GPIO_BD9571MWV=m
CONFIG_GPIO_CRYSTAL_COVE=m
CONFIG_GPIO_WHISKEY_COVE=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_ML_IOH is not set
CONFIG_GPIO_PCI_IDIO_16=m
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
CONFIG_W1=m
CONFIG_W1_CON=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=m
CONFIG_W1_MASTER_DS2482=m
# CONFIG_W1_MASTER_DS1WM is not set
# CONFIG_W1_MASTER_GPIO is not set
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=m
CONFIG_W1_SLAVE_DS2405=m
CONFIG_W1_SLAVE_DS2408=m
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=m
CONFIG_W1_SLAVE_DS2406=m
CONFIG_W1_SLAVE_DS2423=m
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2431=m
CONFIG_W1_SLAVE_DS2433=m
# CONFIG_W1_SLAVE_DS2433_CRC is not set
CONFIG_W1_SLAVE_DS2438=m
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=m
CONFIG_W1_SLAVE_DS28E04=m
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_DS2760 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
CONFIG_MANAGER_SBS=m
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=m
# CONFIG_BATTERY_MAX1721X is not set
# CONFIG_CHARGER_ISP1704 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
CONFIG_CHARGER_BQ24190=m
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_CHARGER_CROS_USBPD=m
# CONFIG_CHARGER_WILCO is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
CONFIG_SENSORS_AD7314=m
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7310=m
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
CONFIG_SENSORS_ASPEED=m
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
CONFIG_SENSORS_G762=m
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_IIO_HWMON is not set
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
CONFIG_SENSORS_POWR1220=m
CONFIG_SENSORS_LINEAGE=m
CONFIG_SENSORS_LTC2945=m
CONFIG_SENSORS_LTC2990=m
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
CONFIG_SENSORS_LTC4222=m
CONFIG_SENSORS_LTC4245=m
CONFIG_SENSORS_LTC4260=m
CONFIG_SENSORS_LTC4261=m
CONFIG_SENSORS_MAX1111=m
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
CONFIG_SENSORS_MAX31722=m
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=m
CONFIG_SENSORS_MCP3021=m
CONFIG_SENSORS_MLXREG_FAN=m
CONFIG_SENSORS_TC654=m
CONFIG_SENSORS_ADCXX=m
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM70=m
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
CONFIG_SENSORS_NCT6683=m
CONFIG_SENSORS_NCT6775=m
CONFIG_SENSORS_NCT7802=m
CONFIG_SENSORS_NCT7904=m
CONFIG_SENSORS_NPCM7XX=m
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC2978_REGULATOR is not set
CONFIG_SENSORS_LTC3815=m
CONFIG_SENSORS_MAX16064=m
CONFIG_SENSORS_MAX20751=m
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_PXE1610 is not set
CONFIG_SENSORS_TPS40422=m
CONFIG_SENSORS_TPS53679=m
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
CONFIG_SENSORS_SHT3x=m
CONFIG_SENSORS_SHTC1=m
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=m
CONFIG_SENSORS_ADS7828=m
CONFIG_SENSORS_ADS7871=m
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
CONFIG_SENSORS_INA3221=m
CONFIG_SENSORS_TC74=m
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
CONFIG_SENSORS_TMP103=m
CONFIG_SENSORS_TMP108=m
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83773G=m
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
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=100
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
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
CONFIG_THERMAL_EMULATION=y

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=y
CONFIG_X86_PKG_TEMP_THERMAL=y
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
CONFIG_INTEL_SOC_DTS_THERMAL=m

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
CONFIG_INT3406_THERMAL=m
CONFIG_PROC_THERMAL_MMIO_RAPL=y
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_BXT_PMIC_THERMAL=m
CONFIG_INTEL_PCH_THERMAL=m
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_BLOCKIO=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_B43_PCI_BRIDGE=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_BLOCKIO=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_BCM590XX=m
CONFIG_MFD_BD9571MWV=m
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_CROS_EC_DEV=m
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
CONFIG_INTEL_SOC_PMIC=y
CONFIG_INTEL_SOC_PMIC_BXTWC=m
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
CONFIG_INTEL_SOC_PMIC_CHTDC_TI=m
CONFIG_MFD_INTEL_LPSS=m
CONFIG_MFD_INTEL_LPSS_ACPI=m
CONFIG_MFD_INTEL_LPSS_PCI=m
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
# CONFIG_MFD_SM501_GPIO is not set
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
# CONFIG_MFD_TPS68470 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=m
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
# CONFIG_RAVE_SP_CORE is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
# CONFIG_REGULATOR_FIXED_VOLTAGE is not set
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
# CONFIG_REGULATOR_88PG86X is not set
# CONFIG_REGULATOR_ACT8865 is not set
# CONFIG_REGULATOR_AD5398 is not set
# CONFIG_REGULATOR_BCM590XX is not set
# CONFIG_REGULATOR_BD9571MWV is not set
# CONFIG_REGULATOR_DA9210 is not set
# CONFIG_REGULATOR_DA9211 is not set
# CONFIG_REGULATOR_FAN53555 is not set
# CONFIG_REGULATOR_GPIO is not set
# CONFIG_REGULATOR_ISL9305 is not set
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LP3971 is not set
# CONFIG_REGULATOR_LP3972 is not set
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP8755 is not set
# CONFIG_REGULATOR_LTC3589 is not set
# CONFIG_REGULATOR_LTC3676 is not set
# CONFIG_REGULATOR_MAX1586 is not set
# CONFIG_REGULATOR_MAX8649 is not set
# CONFIG_REGULATOR_MAX8660 is not set
# CONFIG_REGULATOR_MAX8952 is not set
# CONFIG_REGULATOR_MT6311 is not set
# CONFIG_REGULATOR_PFUZE100 is not set
# CONFIG_REGULATOR_PV88060 is not set
# CONFIG_REGULATOR_PV88080 is not set
# CONFIG_REGULATOR_PV88090 is not set
# CONFIG_REGULATOR_PWM is not set
# CONFIG_REGULATOR_SLG51000 is not set
# CONFIG_REGULATOR_TPS51632 is not set
# CONFIG_REGULATOR_TPS62360 is not set
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
# CONFIG_REGULATOR_TPS65132 is not set
# CONFIG_REGULATOR_TPS6524X is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
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
CONFIG_IR_XMP_DECODER=m
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=m
CONFIG_IR_ENE=m
CONFIG_IR_IMON=m
CONFIG_IR_IMON_RAW=m
CONFIG_IR_MCEUSB=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
CONFIG_IR_REDRAT3=m
CONFIG_IR_STREAMZAP=m
CONFIG_IR_WINBOND_CIR=m
CONFIG_IR_IGORPLUGUSB=m
CONFIG_IR_IGUANA=m
CONFIG_IR_TTUSBIR=m
CONFIG_RC_LOOPBACK=m
CONFIG_IR_SERIAL=m
# CONFIG_IR_SERIAL_TRANSMITTER is not set
CONFIG_IR_SIR=m
CONFIG_RC_XBOX_DVD=m
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_MEDIA_CONTROLLER_DVB=y
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
# CONFIG_V4L2_FLASH_LED_CLASS is not set
CONFIG_V4L2_FWNODE=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_VIDEOBUF_VMALLOC=m
CONFIG_DVB_CORE=m
CONFIG_DVB_MMAP=y
CONFIG_DVB_NET=y
CONFIG_TTPCI_EEPROM=m
CONFIG_DVB_MAX_ADAPTERS=16
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
CONFIG_USB_GSPCA_DTCS033=m
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
CONFIG_USB_GSPCA_KINECT=m
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
CONFIG_USB_GSPCA_STK1135=m
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
CONFIG_USB_GSPCA_TOUPTEK=m
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
CONFIG_VIDEO_CPIA2=m
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m
CONFIG_VIDEO_USBTV=m

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=m
CONFIG_VIDEO_USBVISION=m
CONFIG_VIDEO_STK1160_COMMON=m
CONFIG_VIDEO_STK1160=m
CONFIG_VIDEO_GO7007=m
CONFIG_VIDEO_GO7007_USB=m
CONFIG_VIDEO_GO7007_LOADER=m
# CONFIG_VIDEO_GO7007_USB_S2250_BOARD is not set

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
# CONFIG_VIDEO_TM6000 is not set

#
# Digital TV USB devices
#
# CONFIG_DVB_USB is not set
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
CONFIG_DVB_USB_AZ6007=m
CONFIG_DVB_USB_CE6230=m
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
# CONFIG_DVB_USB_LME2510 is not set
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
CONFIG_DVB_USB_DVBSKY=m
CONFIG_DVB_USB_ZD1301=m
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
CONFIG_DVB_AS102=m

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
CONFIG_VIDEO_EM28XX_V4L2=m
CONFIG_VIDEO_EM28XX_ALSA=m
CONFIG_VIDEO_EM28XX_DVB=m
CONFIG_VIDEO_EM28XX_RC=m

#
# Software defined radio USB devices
#
CONFIG_USB_AIRSPY=m
CONFIG_USB_HACKRF=m
# CONFIG_USB_MSI2500 is not set

#
# USB HDMI CEC adapters
#
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_MEYE is not set
CONFIG_VIDEO_SOLO6X10=m
CONFIG_VIDEO_TW5864=m
CONFIG_VIDEO_TW68=m
CONFIG_VIDEO_TW686X=m

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=m
# CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
CONFIG_VIDEO_IVTV_ALSA=m
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_FB_IVTV_FORCE_PAT is not set
CONFIG_VIDEO_HEXIUM_GEMINI=m
CONFIG_VIDEO_HEXIUM_ORION=m
CONFIG_VIDEO_MXB=m
CONFIG_VIDEO_DT3155=m

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
CONFIG_VIDEO_CX23885=m
CONFIG_MEDIA_ALTERA_CI=m
CONFIG_VIDEO_CX25821=m
CONFIG_VIDEO_CX25821_ALSA=m
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
CONFIG_VIDEO_SAA7134_GO7007=m
CONFIG_VIDEO_SAA7164=m
# CONFIG_VIDEO_COBALT is not set

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110_IR=y
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET_CORE=m
# CONFIG_DVB_BUDGET is not set
# CONFIG_DVB_BUDGET_CI is not set
# CONFIG_DVB_BUDGET_AV is not set
# CONFIG_DVB_BUDGET_PATCH is not set
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_DM1105=m
CONFIG_DVB_PT1=m
CONFIG_DVB_PT3=m
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
CONFIG_DVB_SMIPCIE=m
# CONFIG_DVB_NETUP_UNIDVB is not set
CONFIG_VIDEO_IPU3_CIO2=m
CONFIG_V4L_PLATFORM_DRIVERS=y
# CONFIG_VIDEO_CAFE_CCIC is not set
CONFIG_VIDEO_CADENCE=y
# CONFIG_VIDEO_CADENCE_CSI2RX is not set
# CONFIG_VIDEO_CADENCE_CSI2TX is not set
# CONFIG_VIDEO_ASPEED is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
CONFIG_CEC_PLATFORM_DRIVERS=y
CONFIG_VIDEO_CROS_EC_CEC=m
CONFIG_VIDEO_SECO_CEC=m
CONFIG_VIDEO_SECO_RC=y
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
# CONFIG_SMS_SDIO_DRV is not set
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
CONFIG_RADIO_SI470X=m
CONFIG_USB_SI470X=m
CONFIG_I2C_SI470X=m
CONFIG_RADIO_SI4713=m
# CONFIG_USB_SI4713 is not set
# CONFIG_PLATFORM_SI4713 is not set
# CONFIG_I2C_SI4713 is not set
CONFIG_USB_MR800=m
CONFIG_USB_DSBR=m
CONFIG_RADIO_MAXIRADIO=m
CONFIG_RADIO_SHARK=m
CONFIG_RADIO_SHARK2=m
CONFIG_USB_KEENE=m
# CONFIG_USB_RAREMONO is not set
CONFIG_USB_MA901=m
CONFIG_RADIO_TEA5764=m
CONFIG_RADIO_SAA7706H=m
# CONFIG_RADIO_TEF6862 is not set
CONFIG_RADIO_WL1273=m

#
# Texas Instruments WL128x FM driver (ST based)
#
# end of Texas Instruments WL128x FM driver (ST based)

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
CONFIG_VIDEOBUF2_DMA_CONTIG=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y

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
CONFIG_VIDEO_TDA9840=m
# CONFIG_VIDEO_TDA1997X is not set
CONFIG_VIDEO_TEA6415C=m
CONFIG_VIDEO_TEA6420=m
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
# CONFIG_VIDEO_TLV320AIC23B is not set
CONFIG_VIDEO_UDA1342=m
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m
CONFIG_VIDEO_SONY_BTF_MPX=m

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
CONFIG_VIDEO_ADV7180=m
CONFIG_VIDEO_ADV7183=m
CONFIG_VIDEO_ADV7604=m
CONFIG_VIDEO_ADV7604_CEC=y
CONFIG_VIDEO_ADV7842=m
CONFIG_VIDEO_ADV7842_CEC=y
CONFIG_VIDEO_BT819=m
CONFIG_VIDEO_BT856=m
CONFIG_VIDEO_BT866=m
CONFIG_VIDEO_KS0127=m
CONFIG_VIDEO_ML86V7667=m
CONFIG_VIDEO_SAA7110=m
CONFIG_VIDEO_SAA711X=m
CONFIG_VIDEO_TC358743=m
CONFIG_VIDEO_TC358743_CEC=y
CONFIG_VIDEO_TVP514X=m
CONFIG_VIDEO_TVP5150=m
CONFIG_VIDEO_TVP7002=m
CONFIG_VIDEO_TW2804=m
CONFIG_VIDEO_TW9903=m
CONFIG_VIDEO_TW9906=m
CONFIG_VIDEO_TW9910=m
CONFIG_VIDEO_VPX3220=m

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m
CONFIG_VIDEO_SAA7185=m
CONFIG_VIDEO_ADV7170=m
CONFIG_VIDEO_ADV7175=m
CONFIG_VIDEO_ADV7343=m
CONFIG_VIDEO_ADV7393=m
CONFIG_VIDEO_ADV7511=m
CONFIG_VIDEO_ADV7511_CEC=y
CONFIG_VIDEO_AD9389B=m
CONFIG_VIDEO_AK881X=m
CONFIG_VIDEO_THS8200=m

#
# Camera sensor devices
#
CONFIG_VIDEO_APTINA_PLL=m
CONFIG_VIDEO_SMIAPP_PLL=m
CONFIG_VIDEO_IMX214=m
CONFIG_VIDEO_IMX258=m
CONFIG_VIDEO_IMX274=m
CONFIG_VIDEO_IMX319=m
CONFIG_VIDEO_IMX355=m
CONFIG_VIDEO_OV2640=m
CONFIG_VIDEO_OV2659=m
CONFIG_VIDEO_OV2680=m
CONFIG_VIDEO_OV2685=m
CONFIG_VIDEO_OV5647=m
CONFIG_VIDEO_OV6650=m
CONFIG_VIDEO_OV5670=m
CONFIG_VIDEO_OV5675=m
CONFIG_VIDEO_OV5695=m
CONFIG_VIDEO_OV7251=m
CONFIG_VIDEO_OV772X=m
CONFIG_VIDEO_OV7640=m
CONFIG_VIDEO_OV7670=m
CONFIG_VIDEO_OV7740=m
CONFIG_VIDEO_OV8856=m
CONFIG_VIDEO_OV9640=m
CONFIG_VIDEO_OV9650=m
CONFIG_VIDEO_OV13858=m
CONFIG_VIDEO_VS6624=m
CONFIG_VIDEO_MT9M001=m
CONFIG_VIDEO_MT9M032=m
CONFIG_VIDEO_MT9M111=m
CONFIG_VIDEO_MT9P031=m
CONFIG_VIDEO_MT9T001=m
CONFIG_VIDEO_MT9T112=m
CONFIG_VIDEO_MT9V011=m
CONFIG_VIDEO_MT9V032=m
CONFIG_VIDEO_MT9V111=m
CONFIG_VIDEO_SR030PC30=m
CONFIG_VIDEO_NOON010PC30=m
CONFIG_VIDEO_M5MOLS=m
CONFIG_VIDEO_RJ54N1=m
CONFIG_VIDEO_S5K6AA=m
CONFIG_VIDEO_S5K6A3=m
CONFIG_VIDEO_S5K4ECGX=m
CONFIG_VIDEO_S5K5BAF=m
CONFIG_VIDEO_SMIAPP=m
CONFIG_VIDEO_ET8EK8=m
CONFIG_VIDEO_S5C73M3=m

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9807_VCM is not set

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
# CONFIG_SDR_MAX2175 is not set

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
CONFIG_VIDEO_M52790=m
# CONFIG_VIDEO_I2C is not set
# CONFIG_VIDEO_ST_MIPID02 is not set
# end of I2C Encoders, decoders, sensors and other helper chips

#
# SPI helper chips
#
# CONFIG_VIDEO_GS1662 is not set
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
# CONFIG_MEDIA_TUNER_TDA18250 is not set
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
CONFIG_MEDIA_TUNER_MXL301RF=m
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
# CONFIG_DVB_TUA6100 is not set
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
CONFIG_DVB_S5H1432=m
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
CONFIG_DVB_DIB9000=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_RTL2832_SDR=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_AS102_FE=m
CONFIG_DVB_ZD1301_DEMOD=m
CONFIG_DVB_CXD2880=m

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
CONFIG_DVB_MN88443X=m

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
CONFIG_DVB_LNBH29=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_HELENE=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
CONFIG_DVB_SP2=m

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m
# end of Customise DVB Frontends

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=10
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DBI=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_TTM=y
CONFIG_DRM_VRAM_HELPER=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_VM=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=m
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
CONFIG_DRM_I915=y
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=y

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
CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS=y
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
CONFIG_DRM_I915_DEBUG_RUNTIME_PM=y
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_SPIN_REQUEST=5
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_ATI_PCIGART=y
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
# CONFIG_DRM_GMA500 is not set
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_CIRRUS_QEMU=y
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=y
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=m
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=m
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_GM12U320=m
CONFIG_TINYDRM_HX8357D=m
CONFIG_TINYDRM_ILI9225=m
CONFIG_TINYDRM_ILI9341=m
CONFIG_TINYDRM_MI0283QT=m
CONFIG_TINYDRM_REPAPER=m
CONFIG_TINYDRM_ST7586=m
CONFIG_TINYDRM_ST7735R=m
CONFIG_DRM_VBOXVIDEO=m
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DDC=m
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_BACKLIGHT=m
CONFIG_FB_MODE_HELPERS=y
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
# CONFIG_FB_VESA is not set
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
CONFIG_FB_NVIDIA=m
CONFIG_FB_NVIDIA_I2C=y
# CONFIG_FB_NVIDIA_DEBUG is not set
CONFIG_FB_NVIDIA_BACKLIGHT=y
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=m
CONFIG_FB_RADEON_I2C=y
CONFIG_FB_RADEON_BACKLIGHT=y
# CONFIG_FB_RADEON_DEBUG is not set
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
CONFIG_FB_VIRTUAL=m
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
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
CONFIG_BACKLIGHT_PWM=m
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=m
# end of Backlight & LCD device support

CONFIG_VGASTATE=m
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

# CONFIG_LOGO is not set
# end of Graphics support

CONFIG_SOUND=m
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_VERBOSE=y
# CONFIG_SND_PCM_XRUN_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
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
# CONFIG_SND_DUMMY is not set
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set
# CONFIG_SND_PORTMAN2X4 is not set
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=1
CONFIG_SND_SB_COMMON=m
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
CONFIG_SND_ALS300=m
CONFIG_SND_ALS4000=m
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
CONFIG_SND_AZT3328=m
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
CONFIG_SND_CS4281=m
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
CONFIG_SND_ES1938=m
CONFIG_SND_ES1968=m
# CONFIG_SND_ES1968_INPUT is not set
# CONFIG_SND_ES1968_RADIO is not set
CONFIG_SND_FM801=m
# CONFIG_SND_FM801_TEA575X_BOOL is not set
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
# CONFIG_SND_MAESTRO3_INPUT is not set
CONFIG_SND_MIXART=m
CONFIG_SND_NM256=m
CONFIG_SND_PCXHR=m
CONFIG_SND_RIPTIDE=m
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
CONFIG_SND_SONICVIBES=m
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
CONFIG_SND_YMFPCI=m

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_INTEL_DETECT_DMIC=y
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
# CONFIG_SND_HDA_INPUT_BEEP is not set
# CONFIG_SND_HDA_PATCH_LOADER is not set
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
# CONFIG_SND_HDA_CODEC_CA0132_DSP is not set
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=10
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=64
CONFIG_SND_INTEL_NHLT=m
# CONFIG_SND_SPI is not set
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
# CONFIG_SND_USB_CAIAQ_INPUT is not set
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
CONFIG_SND_USB_HIFACE=m
CONFIG_SND_BCD2000=m
CONFIG_SND_USB_LINE6=m
CONFIG_SND_USB_POD=m
CONFIG_SND_USB_PODHD=m
CONFIG_SND_USB_TONEPORT=m
CONFIG_SND_USB_VARIAX=m
CONFIG_SND_SOC=m
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=m
CONFIG_SND_SOC_AMD_ACP=m
CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH=m
CONFIG_SND_SOC_AMD_CZ_RT5645_MACH=m
CONFIG_SND_SOC_AMD_ACP3x=m
# CONFIG_SND_ATMEL_SOC is not set
CONFIG_SND_DESIGNWARE_I2S=m
# CONFIG_SND_DESIGNWARE_PCM is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
CONFIG_SND_SOC_FSL_AUDMIX=m
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

CONFIG_SND_I2S_HI6210_I2S=m
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_IPC=m
CONFIG_SND_SST_IPC_PCI=m
CONFIG_SND_SST_IPC_ACPI=m
CONFIG_SND_SOC_INTEL_SST_ACPI=m
CONFIG_SND_SOC_INTEL_SST=m
CONFIG_SND_SOC_INTEL_SST_FIRMWARE=m
CONFIG_SND_SOC_INTEL_HASWELL=m
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI=m
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
CONFIG_SND_SOC_INTEL_SKYLAKE=m
CONFIG_SND_SOC_INTEL_SKL=m
CONFIG_SND_SOC_INTEL_APL=m
CONFIG_SND_SOC_INTEL_KBL=m
CONFIG_SND_SOC_INTEL_GLK=m
CONFIG_SND_SOC_INTEL_CNL=m
CONFIG_SND_SOC_INTEL_CFL=m
CONFIG_SND_SOC_INTEL_CML_H=m
CONFIG_SND_SOC_INTEL_CML_LP=m
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=m
CONFIG_SND_SOC_INTEL_SKYLAKE_SSP_CLK=m
CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC=y
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
CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH=m
CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_DA7219_MAX98357A_GENERIC=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH=m
CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH=m
# CONFIG_SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH is not set
CONFIG_SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=m
CONFIG_SND_SOC_INTEL_SOF_RT5682_MACH=m
# CONFIG_SND_SOC_MTK_BTCVSD is not set
CONFIG_SND_SOC_SOF_TOPLEVEL=y
CONFIG_SND_SOC_SOF_PCI=m
CONFIG_SND_SOC_SOF_ACPI=m
CONFIG_SND_SOC_SOF_OPTIONS=m
CONFIG_SND_SOC_SOF_NOCODEC=m
CONFIG_SND_SOC_SOF_NOCODEC_SUPPORT=y
CONFIG_SND_SOC_SOF_STRICT_ABI_CHECKS=y
# CONFIG_SND_SOC_SOF_DEBUG is not set
CONFIG_SND_SOC_SOF=m
CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL=y
CONFIG_SND_SOC_SOF_INTEL_ACPI=m
CONFIG_SND_SOC_SOF_INTEL_PCI=m
CONFIG_SND_SOC_SOF_INTEL_HIFI_EP_IPC=m
CONFIG_SND_SOC_SOF_INTEL_ATOM_HIFI_EP=m
CONFIG_SND_SOC_SOF_INTEL_COMMON=m
CONFIG_SND_SOC_SOF_BAYTRAIL_SUPPORT=y
CONFIG_SND_SOC_SOF_BAYTRAIL=m
# CONFIG_SND_SOC_SOF_BROADWELL_SUPPORT is not set
CONFIG_SND_SOC_SOF_MERRIFIELD_SUPPORT=y
CONFIG_SND_SOC_SOF_MERRIFIELD=m
CONFIG_SND_SOC_SOF_APOLLOLAKE_SUPPORT=y
CONFIG_SND_SOC_SOF_APOLLOLAKE=m
CONFIG_SND_SOC_SOF_GEMINILAKE_SUPPORT=y
CONFIG_SND_SOC_SOF_GEMINILAKE=m
CONFIG_SND_SOC_SOF_CANNONLAKE_SUPPORT=y
CONFIG_SND_SOC_SOF_CANNONLAKE=m
CONFIG_SND_SOC_SOF_COFFEELAKE_SUPPORT=y
CONFIG_SND_SOC_SOF_COFFEELAKE=m
CONFIG_SND_SOC_SOF_ICELAKE_SUPPORT=y
CONFIG_SND_SOC_SOF_ICELAKE=m
CONFIG_SND_SOC_SOF_COMETLAKE_LP=m
CONFIG_SND_SOC_SOF_COMETLAKE_LP_SUPPORT=y
CONFIG_SND_SOC_SOF_COMETLAKE_H=m
CONFIG_SND_SOC_SOF_COMETLAKE_H_SUPPORT=y
CONFIG_SND_SOC_SOF_TIGERLAKE_SUPPORT=y
CONFIG_SND_SOC_SOF_TIGERLAKE=m
CONFIG_SND_SOC_SOF_ELKHARTLAKE_SUPPORT=y
CONFIG_SND_SOC_SOF_ELKHARTLAKE=m
CONFIG_SND_SOC_SOF_HDA_COMMON=m
CONFIG_SND_SOC_SOF_HDA_LINK_BASELINE=m
CONFIG_SND_SOC_SOF_XTENSA=m

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
CONFIG_SND_SOC_AC97_CODEC=m
CONFIG_SND_SOC_ADAU_UTILS=m
# CONFIG_SND_SOC_ADAU1701 is not set
CONFIG_SND_SOC_ADAU17X1=m
CONFIG_SND_SOC_ADAU1761=m
CONFIG_SND_SOC_ADAU1761_I2C=m
CONFIG_SND_SOC_ADAU1761_SPI=m
CONFIG_SND_SOC_ADAU7002=m
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
CONFIG_SND_SOC_AK4458=m
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
CONFIG_SND_SOC_AK5558=m
# CONFIG_SND_SOC_ALC5623 is not set
CONFIG_SND_SOC_BD28623=m
# CONFIG_SND_SOC_BT_SCO is not set
CONFIG_SND_SOC_CROS_EC_CODEC=m
# CONFIG_SND_SOC_CS35L32 is not set
# CONFIG_SND_SOC_CS35L33 is not set
CONFIG_SND_SOC_CS35L34=m
CONFIG_SND_SOC_CS35L35=m
# CONFIG_SND_SOC_CS35L36 is not set
CONFIG_SND_SOC_CS42L42=m
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
# CONFIG_SND_SOC_CS4265 is not set
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS4271_SPI is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
CONFIG_SND_SOC_CS43130=m
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_CS53L30 is not set
CONFIG_SND_SOC_CX2072X=m
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DMIC=m
CONFIG_SND_SOC_HDMI_CODEC=m
CONFIG_SND_SOC_ES7134=m
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8316=m
CONFIG_SND_SOC_ES8328=m
CONFIG_SND_SOC_ES8328_I2C=m
CONFIG_SND_SOC_ES8328_SPI=m
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDAC_HDMI=m
CONFIG_SND_SOC_HDAC_HDA=m
# CONFIG_SND_SOC_INNO_RK3036 is not set
CONFIG_SND_SOC_MAX98088=m
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98357A=m
# CONFIG_SND_SOC_MAX98504 is not set
CONFIG_SND_SOC_MAX9867=m
CONFIG_SND_SOC_MAX98927=m
CONFIG_SND_SOC_MAX98373=m
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
CONFIG_SND_SOC_PCM1789=m
CONFIG_SND_SOC_PCM1789_I2C=m
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM179X_SPI is not set
CONFIG_SND_SOC_PCM186X=m
CONFIG_SND_SOC_PCM186X_I2C=m
CONFIG_SND_SOC_PCM186X_SPI=m
CONFIG_SND_SOC_PCM3060=m
CONFIG_SND_SOC_PCM3060_I2C=m
CONFIG_SND_SOC_PCM3060_SPI=m
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
CONFIG_SND_SOC_RT5660=m
CONFIG_SND_SOC_RT5663=m
CONFIG_SND_SOC_RT5670=m
CONFIG_SND_SOC_RT5677=m
CONFIG_SND_SOC_RT5677_SPI=m
CONFIG_SND_SOC_RT5682=m
# CONFIG_SND_SOC_SGTL5000 is not set
CONFIG_SND_SOC_SIGMADSP=m
CONFIG_SND_SOC_SIGMADSP_REGMAP=m
CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
# CONFIG_SND_SOC_SIRF_AUDIO_CODEC is not set
CONFIG_SND_SOC_SPDIF=m
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=m
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
# CONFIG_SND_SOC_TAS5720 is not set
CONFIG_SND_SOC_TAS6424=m
CONFIG_SND_SOC_TDA7419=m
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
CONFIG_SND_SOC_TLV320AIC32X4=m
CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
CONFIG_SND_SOC_TLV320AIC32X4_SPI=m
# CONFIG_SND_SOC_TLV320AIC3X is not set
CONFIG_SND_SOC_TS3A227E=m
CONFIG_SND_SOC_TSCS42XX=m
# CONFIG_SND_SOC_TSCS454 is not set
CONFIG_SND_SOC_UDA1334=m
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
CONFIG_SND_SOC_WM8524=m
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
CONFIG_SND_SOC_MAX9759=m
# CONFIG_SND_SOC_MT6351 is not set
# CONFIG_SND_SOC_MT6358 is not set
CONFIG_SND_SOC_NAU8540=m
# CONFIG_SND_SOC_NAU8810 is not set
CONFIG_SND_SOC_NAU8822=m
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_NAU8825=m
# CONFIG_SND_SOC_TPA6130A2 is not set
# end of CODEC drivers

CONFIG_SND_SIMPLE_CARD_UTILS=m
CONFIG_SND_SIMPLE_CARD=m
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=m
CONFIG_SND_SYNTH_EMUX=m
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=y
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACCUTOUCH=m
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
CONFIG_HID_APPLEIR=m
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
CONFIG_HID_BETOP_FF=m
CONFIG_HID_BIGBEN_FF=m
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
CONFIG_HID_CORSAIR=m
CONFIG_HID_COUGAR=m
# CONFIG_HID_MACALLY is not set
CONFIG_HID_PRODIKEYS=m
CONFIG_HID_CMEDIA=m
CONFIG_HID_CP2112=m
CONFIG_HID_CREATIVE_SB0540=m
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
CONFIG_HID_EMS_FF=m
CONFIG_HID_ELAN=m
CONFIG_HID_ELECOM=m
CONFIG_HID_ELO=m
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
CONFIG_HID_HOLTEK=y
# CONFIG_HOLTEK_FF is not set
CONFIG_HID_GOOGLE_HAMMER=m
CONFIG_HID_GT683R=m
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=y
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
CONFIG_LOGITECH_FF=y
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
CONFIG_LOGIWHEELS_FF=y
CONFIG_HID_MAGICMOUSE=m
# CONFIG_HID_MALTRON is not set
CONFIG_HID_MAYFLASH=m
CONFIG_HID_REDRAGON=m
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
CONFIG_HID_NTRIG=m
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
CONFIG_HID_PENMOUNT=m
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
# CONFIG_HID_PICOLCD_FB is not set
# CONFIG_HID_PICOLCD_BACKLIGHT is not set
# CONFIG_HID_PICOLCD_LCD is not set
# CONFIG_HID_PICOLCD_LEDS is not set
# CONFIG_HID_PICOLCD_CIR is not set
CONFIG_HID_PLANTRONICS=m
CONFIG_HID_PRIMAX=m
CONFIG_HID_RETRODE=m
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=y
CONFIG_HID_SONY=m
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=m
CONFIG_HID_STEAM=m
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_UDRAW_PS3=m
CONFIG_HID_U2FZERO=m
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
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
CONFIG_INTEL_ISH_HID=m
CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER=m
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
CONFIG_USB_ULPI_BUS=m
CONFIG_USB_CONN_GPIO=m
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
CONFIG_USB_MON=m

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PLATFORM=m
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
CONFIG_USB_EHCI_HCD_PLATFORM=m
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
CONFIG_USB_MAX3421_HCD=m
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
CONFIG_USB_OHCI_HCD_PLATFORM=m
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_U132_HCD is not set
CONFIG_USB_SL811_HCD=m
# CONFIG_USB_SL811_HCD_ISO is not set
# CONFIG_USB_R8A66597_HCD is not set
CONFIG_USB_HCD_BCMA=m
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
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=y
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
CONFIG_USB_UAS=y

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USBIP_CORE=m
CONFIG_USBIP_VHCI_HCD=m
CONFIG_USBIP_VHCI_HC_PORTS=8
CONFIG_USBIP_VHCI_NR_HCS=1
CONFIG_USBIP_HOST=m
# CONFIG_USBIP_VUDC is not set
# CONFIG_USBIP_DEBUG is not set
CONFIG_USB_CDNS3=m
# CONFIG_USB_CDNS3_GADGET is not set
# CONFIG_USB_CDNS3_HOST is not set
CONFIG_USB_CDNS3_PCI_WRAP=m
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_SIMPLE=m
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
CONFIG_USB_SERIAL_F81232=m
CONFIG_USB_SERIAL_F8153X=m
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_METRO=m
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
CONFIG_USB_SERIAL_MXUPORT=m
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
CONFIG_USB_SERIAL_WISHBONE=m
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
CONFIG_USB_SERIAL_UPD78F0730=m
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
# CONFIG_USB_RIO500 is not set
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_USB_SISUSBVGA=m
# CONFIG_USB_SISUSBVGA_CON is not set
CONFIG_USB_LD=m
CONFIG_USB_TRANCEVIBRATOR=m
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
CONFIG_USB_YUREX=m
CONFIG_USB_EZUSB_FX2=m
CONFIG_USB_HUB_USB251XB=m
CONFIG_USB_HSIC_USB3503=m
CONFIG_USB_HSIC_USB4604=m
# CONFIG_USB_LINK_LAYER_TEST is not set
CONFIG_USB_CHAOSKEY=m

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=m
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=m
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
# CONFIG_USB_FOTG210_UDC is not set
# CONFIG_USB_GR_UDC is not set
# CONFIG_USB_R8A66597 is not set
# CONFIG_USB_PXA27X is not set
# CONFIG_USB_MV_UDC is not set
# CONFIG_USB_MV_U3D is not set
# CONFIG_USB_M66592 is not set
# CONFIG_USB_BDC_UDC is not set
# CONFIG_USB_AMD5536UDC is not set
# CONFIG_USB_NET2272 is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
# CONFIG_USB_DUMMY_HCD is not set
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=m
CONFIG_USB_U_AUDIO=m
CONFIG_USB_F_UAC2=m
CONFIG_USB_F_HID=m
# CONFIG_USB_CONFIGFS is not set
# CONFIG_USB_ZERO is not set
CONFIG_USB_AUDIO=m
# CONFIG_GADGET_UAC1 is not set
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
# CONFIG_USB_GADGETFS is not set
# CONFIG_USB_FUNCTIONFS is not set
# CONFIG_USB_MASS_STORAGE is not set
# CONFIG_USB_GADGET_TARGET is not set
# CONFIG_USB_G_SERIAL is not set
# CONFIG_USB_MIDI_GADGET is not set
# CONFIG_USB_G_PRINTER is not set
# CONFIG_USB_CDC_COMPOSITE is not set
# CONFIG_USB_G_ACM_MS is not set
# CONFIG_USB_G_MULTI is not set
CONFIG_USB_G_HID=m
# CONFIG_USB_G_DBGP is not set
# CONFIG_USB_G_WEBCAM is not set
CONFIG_TYPEC=m
CONFIG_TYPEC_TCPM=m
CONFIG_TYPEC_TCPCI=m
CONFIG_TYPEC_RT1711H=m
CONFIG_TYPEC_FUSB302=m
CONFIG_TYPEC_UCSI=m
CONFIG_UCSI_CCG=m
CONFIG_UCSI_ACPI=m
CONFIG_TYPEC_TPS6598X=m

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_PI3USB30532=m
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
CONFIG_TYPEC_DP_ALTMODE=m
CONFIG_TYPEC_NVIDIA_ALTMODE=m
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=m
CONFIG_USB_ROLES_INTEL_XHCI=m
CONFIG_MMC=y
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=y
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=y
CONFIG_MMC_SDHCI_PLTFM=m
CONFIG_MMC_SDHCI_F_SDH30=m
CONFIG_MMC_WBSD=m
# CONFIG_MMC_ALCOR is not set
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_REALTEK_PCI=y
CONFIG_MMC_REALTEK_USB=m
CONFIG_MMC_CQHCI=y
CONFIG_MMC_TOSHIBA_PCI=m
# CONFIG_MMC_MTK is not set
CONFIG_MMC_SDHCI_XENON=m
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
CONFIG_MEMSTICK_REALTEK_PCI=m
CONFIG_MEMSTICK_REALTEK_USB=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_APU=m
CONFIG_LEDS_AS3645A=m
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3532=m
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_LM3601X is not set
CONFIG_LEDS_PCA9532=m
# CONFIG_LEDS_PCA9532_GPIO is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=m
# CONFIG_LEDS_LP5521 is not set
# CONFIG_LEDS_LP5523 is not set
# CONFIG_LEDS_LP5562 is not set
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
CONFIG_LEDS_MLXREG=m
CONFIG_LEDS_USER=m
CONFIG_LEDS_NIC78BX=m
CONFIG_LEDS_TI_LMU_COMMON=m

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
CONFIG_LEDS_TRIGGER_ACTIVITY=m
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
CONFIG_LEDS_TRIGGER_NETDEV=m
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
# CONFIG_RTC_NVMEM is not set

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
CONFIG_RTC_DRV_ABX80X=m
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
CONFIG_RTC_DRV_PCF85063=m
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
# CONFIG_RTC_DRV_M41T80_WDT is not set
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
CONFIG_RTC_DRV_RX8010=m
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=m
CONFIG_RTC_DRV_M41T94=m
# CONFIG_RTC_DRV_DS1302 is not set
CONFIG_RTC_DRV_DS1305=m
CONFIG_RTC_DRV_DS1343=m
CONFIG_RTC_DRV_DS1347=m
CONFIG_RTC_DRV_DS1390=m
CONFIG_RTC_DRV_MAX6916=m
CONFIG_RTC_DRV_R9701=m
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RX6110 is not set
CONFIG_RTC_DRV_RS5C348=m
CONFIG_RTC_DRV_MAX6902=m
CONFIG_RTC_DRV_PCF2123=m
CONFIG_RTC_DRV_MCP795=m
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
CONFIG_RTC_DRV_PCF2127=m
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
CONFIG_RTC_DRV_DS1685_FAMILY=m
CONFIG_RTC_DRV_DS1685=y
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
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
CONFIG_RTC_DRV_CROS_EC=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
CONFIG_RTC_DRV_HID_SENSOR_TIME=m
CONFIG_RTC_DRV_WILCO_EC=m
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=m
CONFIG_DMA_ACPI=y
CONFIG_ALTERA_MSGDMA=m
CONFIG_INTEL_IDMA64=m
CONFIG_INTEL_IOATDMA=y
CONFIG_INTEL_MIC_X100_DMA=m
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=m
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=m
CONFIG_DW_EDMA=m
CONFIG_DW_EDMA_PCIE=m

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
CONFIG_UDMABUF=y
# CONFIG_DMABUF_SELFTESTS is not set
# end of DMABUF options

CONFIG_DCA=y
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
# CONFIG_UIO_PDRV_GENIRQ is not set
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_VFIO_IOMMU_TYPE1=y
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=y
# CONFIG_VFIO_NOIOMMU is not set
CONFIG_VFIO_PCI=m
CONFIG_VFIO_PCI_VGA=y
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI_IGD=y
CONFIG_VFIO_MDEV=y
CONFIG_VFIO_MDEV_DEVICE=y
CONFIG_IRQ_BYPASS_MANAGER=y
CONFIG_VIRT_DRIVERS=y
CONFIG_VBOXGUEST=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_VIRTIO_PMEM=m
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_INPUT=m
CONFIG_VIRTIO_MMIO=m
# CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
CONFIG_STAGING=y
CONFIG_PRISM2_USB=m
# CONFIG_COMEDI is not set
CONFIG_RTL8192U=m
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m
CONFIG_RTL8723BS=m
CONFIG_R8712U=m
CONFIG_R8188EU=m
# CONFIG_88EU_AP_MODE is not set
CONFIG_RTS5208=m
CONFIG_VT6655=m
CONFIG_VT6656=m

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
# end of Android

# CONFIG_LTE_GDM724X is not set
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

CONFIG_FIELDBUS_DEV=m
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
CONFIG_EXFAT_FS=m
CONFIG_EXFAT_DONT_MOUNT_VFAT=y
CONFIG_EXFAT_DISCARD=y
# CONFIG_EXFAT_DELAYED_SYNC is not set
# CONFIG_EXFAT_KERNEL_DEBUG is not set
# CONFIG_EXFAT_DEBUG_MSG is not set
CONFIG_EXFAT_DEFAULT_CODEPAGE=437
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
CONFIG_QLGE=m
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=m
CONFIG_ACER_WIRELESS=m
CONFIG_ACERHDF=m
CONFIG_ALIENWARE_WMI=m
CONFIG_ASUS_LAPTOP=m
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
# CONFIG_DELL_SMBIOS_SMM is not set
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_WMI=m
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=m
CONFIG_DELL_WMI_LED=m
CONFIG_DELL_SMO8800=m
CONFIG_DELL_RBTN=m
# CONFIG_DELL_RBU is not set
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_AMILO_RFKILL=m
CONFIG_GPD_POCKET_FAN=m
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
CONFIG_LG_LAPTOP=m
CONFIG_MSI_LAPTOP=m
CONFIG_PANASONIC_LAPTOP=m
CONFIG_COMPAL_LAPTOP=m
CONFIG_SONY_LAPTOP=m
# CONFIG_SONYPI_COMPAT is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SURFACE3_WMI=m
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
CONFIG_ASUS_WIRELESS=m
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_XIAOMI_WMI=m
CONFIG_MSI_WMI=m
CONFIG_PEAQ_WMI=m
CONFIG_TOPSTAR_LAPTOP=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_TOSHIBA_BT_RFKILL=m
CONFIG_TOSHIBA_HAPS=m
CONFIG_TOSHIBA_WMI=m
CONFIG_ACPI_CMPC=m
CONFIG_INTEL_CHT_INT33FE=m
CONFIG_INTEL_INT0002_VGPIO=m
CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
CONFIG_INTEL_IPS=y
CONFIG_INTEL_PMC_CORE=m
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_MXM_WMI=m
# CONFIG_INTEL_OAKTRAIL is not set
CONFIG_SAMSUNG_Q10=m
CONFIG_APPLE_GMUX=m
CONFIG_INTEL_RST=m
CONFIG_INTEL_SMARTCONNECT=m
CONFIG_INTEL_PMC_IPC=m
CONFIG_INTEL_BXTWC_PMIC_TMU=m
CONFIG_SURFACE_PRO3_BUTTON=m
CONFIG_SURFACE_3_BUTTON=m
CONFIG_INTEL_PUNIT_IPC=m
CONFIG_INTEL_TELEMETRY=m
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_TOUCHSCREEN_DMI is not set
CONFIG_INTEL_CHTDC_TI_PWRBTN=m
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_INTEL_ATOMISP2_PM=y
CONFIG_HUAWEI_WMI=m
# CONFIG_PCENGINES_APU2 is not set

#
# Intel Speed Select Technology interface support
#
CONFIG_INTEL_SPEED_SELECT_INTERFACE=m
# end of Intel Speed Select Technology interface support

CONFIG_PMC_ATOM=y
CONFIG_MFD_CROS_EC=m
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=m
CONFIG_CHROMEOS_PSTORE=m
CONFIG_CHROMEOS_TBMC=m
CONFIG_CROS_EC=m
CONFIG_CROS_EC_I2C=m
CONFIG_CROS_EC_ISHTP=m
CONFIG_CROS_EC_SPI=m
CONFIG_CROS_EC_LPC=m
CONFIG_CROS_EC_PROTO=y
CONFIG_CROS_KBD_LED_BACKLIGHT=m
CONFIG_CROS_EC_CHARDEV=m
CONFIG_CROS_EC_LIGHTBAR=m
# CONFIG_CROS_EC_DEBUGFS is not set
CONFIG_CROS_EC_SYSFS=m
CONFIG_CROS_USBPD_LOGGER=m
CONFIG_WILCO_EC=m
CONFIG_WILCO_EC_DEBUGFS=m
CONFIG_WILCO_EC_EVENTS=m
CONFIG_WILCO_EC_TELEMETRY=m
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
CONFIG_MLXREG_IO=m
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_MAX9485 is not set
CONFIG_COMMON_CLK_SI5341=m
# CONFIG_COMMON_CLK_SI5351 is not set
CONFIG_COMMON_CLK_SI544=m
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# end of Common Clock Framework

# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
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
CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
CONFIG_INTEL_IOMMU_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_IRQ_REMAP=y

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=m
# CONFIG_RPMSG_CHAR is not set
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
CONFIG_RPMSG_VIRTIO=m
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
CONFIG_XILINX_VCU=m
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ADC_JACK is not set
CONFIG_EXTCON_FSA9480=m
# CONFIG_EXTCON_GPIO is not set
CONFIG_EXTCON_INTEL_INT3496=m
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_PTN5150 is not set
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_EXTCON_USBC_CROS_EC=m
# CONFIG_MEMORY is not set
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
CONFIG_IIO_BUFFER_HW_CONSUMER=m
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_TRIGGERED_BUFFER=m
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=m
CONFIG_IIO_SW_TRIGGER=m

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16209 is not set
# CONFIG_ADXL345_I2C is not set
# CONFIG_ADXL345_SPI is not set
CONFIG_ADXL372=m
CONFIG_ADXL372_SPI=m
CONFIG_ADXL372_I2C=m
# CONFIG_BMA180 is not set
# CONFIG_BMA220 is not set
CONFIG_BMC150_ACCEL=m
CONFIG_BMC150_ACCEL_I2C=m
CONFIG_BMC150_ACCEL_SPI=m
CONFIG_DA280=m
CONFIG_DA311=m
# CONFIG_DMARD09 is not set
CONFIG_DMARD10=m
CONFIG_HID_SENSOR_ACCEL_3D=m
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=m
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
CONFIG_IIO_ST_ACCEL_SPI_3AXIS=m
# CONFIG_KXSD9 is not set
CONFIG_KXCJK1013=m
# CONFIG_MC3230 is not set
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7455_SPI is not set
CONFIG_MMA7660=m
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
# CONFIG_AD7298 is not set
# CONFIG_AD7476 is not set
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD7606_IFACE_SPI is not set
CONFIG_AD7766=m
# CONFIG_AD7768_1 is not set
# CONFIG_AD7780 is not set
# CONFIG_AD7791 is not set
# CONFIG_AD7793 is not set
# CONFIG_AD7887 is not set
# CONFIG_AD7923 is not set
# CONFIG_AD7949 is not set
# CONFIG_AD799X is not set
# CONFIG_CC10001_ADC is not set
# CONFIG_HI8435 is not set
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
# CONFIG_LTC2471 is not set
# CONFIG_LTC2485 is not set
# CONFIG_LTC2497 is not set
# CONFIG_MAX1027 is not set
# CONFIG_MAX11100 is not set
# CONFIG_MAX1118 is not set
CONFIG_MAX1363=m
# CONFIG_MAX9611 is not set
# CONFIG_MCP320X is not set
# CONFIG_MCP3422 is not set
CONFIG_MCP3911=m
# CONFIG_NAU7802 is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
# CONFIG_TI_ADC108S102 is not set
# CONFIG_TI_ADC128S052 is not set
# CONFIG_TI_ADC161S626 is not set
CONFIG_TI_ADS1015=m
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
# CONFIG_PMS7003 is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SPS30 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

CONFIG_IIO_CROS_EC_SENSORS_CORE=m
CONFIG_IIO_CROS_EC_SENSORS=m
CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE=m

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
# end of Hid Sensor IIO Common

#
# SSP Sensor Common
#
CONFIG_IIO_SSP_SENSORS_COMMONS=m
CONFIG_IIO_SSP_SENSORHUB=m
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_SPI=m
CONFIG_IIO_ST_SENSORS_CORE=m

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
CONFIG_LTC1660=m
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
# CONFIG_IIO_SIMPLE_DUMMY is not set
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
CONFIG_MPU3050=m
CONFIG_MPU3050_I2C=m
CONFIG_IIO_ST_GYRO_3AXIS=m
CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
CONFIG_IIO_ST_GYRO_SPI_3AXIS=m
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
CONFIG_MAX30100=m
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
CONFIG_DHT11=m
# CONFIG_HDC100X is not set
CONFIG_HID_SENSOR_HUMIDITY=m
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
CONFIG_HTS221_SPI=m
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
# CONFIG_KMX61 is not set
CONFIG_INV_MPU6050_IIO=m
CONFIG_INV_MPU6050_I2C=m
# CONFIG_INV_MPU6050_SPI is not set
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

#
# Light sensors
#
CONFIG_ACPI_ALS=m
# CONFIG_ADJD_S311 is not set
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
CONFIG_BH1750=m
# CONFIG_BH1780 is not set
CONFIG_CM32181=m
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM36651 is not set
CONFIG_IIO_CROS_EC_LIGHT_PROX=m
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
CONFIG_SENSORS_ISL29028=m
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=m
CONFIG_HID_SENSOR_PROX=m
# CONFIG_JSA1212 is not set
CONFIG_RPR0521=m
# CONFIG_LTR501 is not set
CONFIG_LV0104CS=m
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
# CONFIG_NOA1305 is not set
CONFIG_OPT3001=m
CONFIG_PA12203001=m
# CONFIG_SI1133 is not set
# CONFIG_SI1145 is not set
CONFIG_STK3310=m
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
CONFIG_ST_UVIS25_SPI=m
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
CONFIG_TSL2772=m
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6070 is not set
CONFIG_VL6180=m
CONFIG_ZOPT2201=m
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8975=m
CONFIG_AK09911=m
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_BMC150_MAGN_SPI is not set
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
# CONFIG_MMC35240 is not set
CONFIG_IIO_ST_MAGN_3AXIS=m
CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
CONFIG_IIO_ST_MAGN_SPI_3AXIS=m
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
# CONFIG_IIO_HRTIMER_TRIGGER is not set
CONFIG_IIO_INTERRUPT_TRIGGER=m
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=m
# end of Triggers - standalone

#
# Digital potentiometers
#
CONFIG_AD5272=m
# CONFIG_DS1803 is not set
# CONFIG_MAX5432 is not set
# CONFIG_MAX5481 is not set
# CONFIG_MAX5487 is not set
CONFIG_MCP4018=m
# CONFIG_MCP4131 is not set
# CONFIG_MCP4531 is not set
# CONFIG_MCP41010 is not set
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=m
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=m
CONFIG_BMP280=m
CONFIG_BMP280_I2C=m
CONFIG_BMP280_SPI=m
CONFIG_IIO_CROS_EC_BARO=m
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
CONFIG_SRF04=m
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
CONFIG_VL53L0X_I2C=m
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
CONFIG_MAXIM_THERMOCOUPLE=m
CONFIG_HID_SENSOR_TEMP=m
CONFIG_MLX90614=m
CONFIG_MLX90632=m
# CONFIG_TMP006 is not set
# CONFIG_TMP007 is not set
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# CONFIG_MAX31856 is not set
# end of Temperature sensors

CONFIG_NTB=m
CONFIG_NTB_MSI=y
CONFIG_NTB_AMD=m
CONFIG_NTB_IDT=m
CONFIG_NTB_INTEL=m
CONFIG_NTB_SWITCHTEC=m
CONFIG_NTB_PINGPONG=m
CONFIG_NTB_TOOL=m
CONFIG_NTB_PERF=m
CONFIG_NTB_MSI_TEST=m
CONFIG_NTB_TRANSPORT=m
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_CRC=y
CONFIG_PWM_CROS_EC=m
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
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
CONFIG_PHY_CPCAP_USB=m
# CONFIG_PHY_QCOM_USB_HS is not set
# CONFIG_PHY_QCOM_USB_HSIC is not set
# CONFIG_PHY_TUSB1210 is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=y
CONFIG_INTEL_RAPL=y
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_RAS_CEC=y
# CONFIG_RAS_CEC_DEBUG is not set
CONFIG_THUNDERBOLT=m

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
CONFIG_DEV_DAX=y
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

CONFIG_FPGA=m
CONFIG_ALTERA_PR_IP_CORE=m
CONFIG_FPGA_MGR_ALTERA_PS_SPI=m
CONFIG_FPGA_MGR_ALTERA_CVP=m
CONFIG_FPGA_MGR_XILINX_SPI=m
CONFIG_FPGA_MGR_MACHXO2_SPI=m
CONFIG_FPGA_BRIDGE=m
CONFIG_ALTERA_FREEZE_BRIDGE=m
CONFIG_XILINX_PR_DECOUPLER=m
CONFIG_FPGA_REGION=m
CONFIG_FPGA_DFL=m
CONFIG_FPGA_DFL_FME=m
CONFIG_FPGA_DFL_FME_MGR=m
CONFIG_FPGA_DFL_FME_BRIDGE=m
CONFIG_FPGA_DFL_FME_REGION=m
CONFIG_FPGA_DFL_AFU=m
CONFIG_FPGA_DFL_PCI=m
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
CONFIG_COUNTER=m
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_QUOTA is not set
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
# CONFIG_XFS_ONLINE_SCRUB is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
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
# CONFIG_QUOTA is not set
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=m
CONFIG_VIRTIO_FS=m
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
# CONFIG_FSCACHE_STATS is not set
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
CONFIG_FAT_FS=y
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
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
CONFIG_ECRYPT_FS=m
# CONFIG_ECRYPT_FS_MESSAGING is not set
# CONFIG_HFS_FS is not set
CONFIG_HFSPLUS_FS=m
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
CONFIG_SQUASHFS_DECOMP_MULTI=y
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
# CONFIG_SQUASHFS_XATTR is not set
CONFIG_SQUASHFS_ZLIB=y
CONFIG_SQUASHFS_LZ4=y
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
CONFIG_SQUASHFS_ZSTD=y
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=m
CONFIG_PSTORE_LZO_COMPRESS=m
CONFIG_PSTORE_LZ4_COMPRESS=m
CONFIG_PSTORE_LZ4HC_COMPRESS=m
# CONFIG_PSTORE_842_COMPRESS is not set
CONFIG_PSTORE_ZSTD_COMPRESS=y
CONFIG_PSTORE_COMPRESS=y
# CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZO_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_ZSTD_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="zstd"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
CONFIG_PSTORE_RAM=m
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="clearlinux.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V3_ACL is not set
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
CONFIG_NFSD_BLOCKLAYOUT=y
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_SECURITY_LABEL is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES=y
# CONFIG_SUNRPC_DEBUG is not set
CONFIG_CEPH_FS=m
CONFIG_CEPH_FSCACHE=y
CONFIG_CEPH_FS_POSIX_ACL=y
CONFIG_CEPH_FS_SECURITY_LABEL=y
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
# CONFIG_CIFS_ALLOW_INSECURE_LEGACY is not set
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_DEBUG is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=m
# CONFIG_9P_FSCACHE is not set
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
CONFIG_NLS_ISO8859_1=y
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
CONFIG_NLS_UTF8=y
CONFIG_DLM=m
# CONFIG_DLM_DEBUG is not set
CONFIG_UNICODE=y
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
# CONFIG_KEYS_REQUEST_CACHE is not set
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=m
CONFIG_ENCRYPTED_KEYS=m
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_SECURITY_NETWORK_XFRM is not set
CONFIG_SECURITY_PATH=y
# CONFIG_INTEL_TXT is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
# CONFIG_HARDENED_USERCOPY_FALLBACK is not set
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
CONFIG_SECURITY_SAFESETID=y
CONFIG_SECURITY_LOCKDOWN_LSM=y
# CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is not set
CONFIG_LOCK_DOWN_KERNEL_FORCE_NONE=y
# CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY is not set
# CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY is not set
# CONFIG_INTEGRITY is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="yama,loadpin,safesetid,integrity"

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
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
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
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y
CONFIG_CRYPTO_ENGINE=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
CONFIG_CRYPTO_ECRDSA=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=m
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=m
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=m
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=y

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
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=m
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_CRCT10DIF=y
# CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
CONFIG_CRYPTO_GHASH=m
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=y
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
CONFIG_CRYPTO_STREEBOG=m
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
# CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL is not set

#
# Ciphers
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_LIB_ARC4=y
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
CONFIG_CRYPTO_CHACHA20=m
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=y
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
# CONFIG_CRYPTO_TWOFISH_X86_64 is not set
# CONFIG_CRYPTO_TWOFISH_X86_64_3WAY is not set
# CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=m
CONFIG_CRYPTO_ZSTD=y

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
CONFIG_CRYPTO_USER_API_AEAD=m
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
CONFIG_CRYPTO_DEV_ATMEL_I2C=m
CONFIG_CRYPTO_DEV_ATMEL_ECC=m
CONFIG_CRYPTO_DEV_ATMEL_SHA204A=m
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=y
CONFIG_CRYPTO_DEV_QAT_DH895xCC=y
CONFIG_CRYPTO_DEV_QAT_C3XXX=y
CONFIG_CRYPTO_DEV_QAT_C62X=y
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=y
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=y
CONFIG_CRYPTO_DEV_QAT_C62XVF=y
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
CONFIG_CRYPTO_DEV_CHELSIO=m
# CONFIG_CHELSIO_IPSEC_INLINE is not set
# CONFIG_CRYPTO_DEV_CHELSIO_TLS is not set
CONFIG_CRYPTO_DEV_VIRTIO=y
CONFIG_CRYPTO_DEV_SAFEXCEL=m
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE=m
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=m
CONFIG_TPM_KEY_PARSER=m
CONFIG_PKCS7_MESSAGE_PARSER=y
CONFIG_PKCS7_TEST_KEY=m
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_RAID6_PQ_BENCHMARK=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=y
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
CONFIG_CRC64=m
CONFIG_CRC4=m
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
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
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_LRU_CACHE=m
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
CONFIG_FONT_7x14=y
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_6x10 is not set
CONFIG_FONT_10x18=y
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
# CONFIG_FONT_TER16x32 is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
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
CONFIG_FRAME_WARN=1024
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_INSTALL is not set
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_SECTION_MISMATCH=y
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
CONFIG_FRAME_POINTER=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
# CONFIG_MAGIC_SYSRQ_SERIAL is not set
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
# CONFIG_DEBUG_RODATA_TEST is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_CC_HAS_KASAN_GENERIC=y
# CONFIG_KASAN is not set
CONFIG_KASAN_STACK=1
# end of Memory Debugging

CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# end of Debug Lockups and Hangs

# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
CONFIG_SCHED_STACK_END_CHECK=y
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
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_STACK_TRACER is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
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
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_UBSAN_ALIGNMENT=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
# CONFIG_UNWINDER_ORC is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# end of Kernel hacking

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='phoronix-test-suite'
	export testcase='phoronix-test-suite'
	export category='benchmark'
	export need_memory='8G'
	export rootfs='internal-lkp-server:/osimage/clear/clear-x86_64-phoronix-30140'
	export kconfig='x86_64-lck-7983'
	export run_on_local_disk=true
	export job_origin='phoronix-test-suite-clear.yaml'
	export testbox='lkp-cfl-e1'
	export arch='x86_64'
	export tbox_group='lkp-cfl-e1'
	export serial_servers='lkp-wildcat lkp-os lkp-nhm-dp1 lkp-nhm-dp2 lkp-nhm-d01 lkp-serial01'
	export boot_watchdog_mail='ignore'
	export compiler='gcc-7'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export branch='oracle-dtrace-linux-kernel/v1/5.5.2'
	export commit='0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912'
	export submit_id='5e5e5f22bfb2321da76fc5e4'
	export job_file='/lkp/jobs/scheduled/lkp-cfl-e1/phoronix-test-suite-performance-compress-gzip-1.2.0-ucode=0xca-clear-x86_64-phoronix-30140-0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad-20200303-7591-1q6gztk-2.yaml'
	export id='2fb4b2712c99b77ce6ebba1dd6e08bb01710142b'
	export queuer_version='/lkp-src'
	export model='Coffee Lake'
	export nr_node=1
	export nr_cpu=16
	export memory='32G'
	export nr_hdd_partitions=1
	export hdd_partitions='/dev/disk/by-id/ata-WDC_WD1005FBYZ-01YCBB1_WD-WMC6M0D4MD6W-part2'
	export swap_partitions='LABEL=SWAP'
	export rootfs_partition='/dev/disk/by-id/ata-WDC_WD1005FBYZ-01YCBB1_WD-WMC6M0D4MD6W-part1'
	export brand='Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz'
	export ucode='0xca'
	export need_kconfig_hw='CONFIG_IGB=y
CONFIG_SATA_AHCI'
	export enqueue_time='2020-03-03 21:44:05 +0800'
	export _id='5e5e5f22bfb2321da76fc5e4'
	export _rt='/result/phoronix-test-suite/performance-compress-gzip-1.2.0-ucode=0xca/lkp-cfl-e1/clear-x86_64-phoronix-30140/x86_64-lck-7983/gcc-7/0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912'
	export user='lkp'
	export result_root='/result/phoronix-test-suite/performance-compress-gzip-1.2.0-ucode=0xca/lkp-cfl-e1/clear-x86_64-phoronix-30140/x86_64-lck-7983/gcc-7/0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912/2'
	export scheduler_version='/lkp/lkp/.src-20200302-232359'
	export LKP_SERVER='inn'
	export max_uptime=2089.38
	export initrd='/osimage/initramfs/initramfs-20191118.cgz'
	export bootloader_append='root=/dev/disk/by-id/ata-WDC_WD1005FBYZ-01YCBB1_WD-WMC6M0D4MD6W-part1
rootflags=subvol=clear-x86_64-phoronix-30140
remote_rootfs=internal-lkp-server:/osimage/clear/clear-x86_64-phoronix-30140
user=lkp
job=/lkp/jobs/scheduled/lkp-cfl-e1/phoronix-test-suite-performance-compress-gzip-1.2.0-ucode=0xca-clear-x86_64-phoronix-30140-0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad-20200303-7591-1q6gztk-2.yaml
ARCH=x86_64
kconfig=x86_64-lck-7983
branch=oracle-dtrace-linux-kernel/v1/5.5.2
commit=0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912
BOOT_IMAGE=/pkg/linux/x86_64-lck-7983/gcc-7/0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912/vmlinuz-5.4.0-rc1-00010-g0b0695f2b34a4
max_uptime=2089
RESULT_ROOT=/result/phoronix-test-suite/performance-compress-gzip-1.2.0-ucode=0xca/lkp-cfl-e1/clear-x86_64-phoronix-30140/x86_64-lck-7983/gcc-7/0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912/2
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
	export modules_initrd='/pkg/linux/x86_64-lck-7983/gcc-7/0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912/modules.cgz'
	export bm_initrd='/osimage/pkg/clear-x86_64-phoronix-24300/turbostat-x86_64-d5256b2_2019-04-30.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.6.0-rc2'
	export repeat_to=4
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-lck-7983/gcc-7/0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912/vmlinuz-5.4.0-rc1-00010-g0b0695f2b34a4'
	export dequeue_time='2020-03-03 21:49:26 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-cfl-e1/phoronix-test-suite-performance-compress-gzip-1.2.0-ucode=0xca-clear-x86_64-phoronix-30140-0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad-20200303-7591-1q6gztk-2.cgz'

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
	run_monitor $LKP_SRC/monitors/wrapper turbostat
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='compress-gzip-1.2.0' $LKP_SRC/tests/wrapper phoronix-test-suite
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper phoronix-test-suite
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
	$LKP_SRC/stats/wrapper perf-profile

	$LKP_SRC/stats/wrapper time phoronix-test-suite.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! phoronix-test-suite-clear.yaml
suite: phoronix-test-suite
testcase: phoronix-test-suite
category: benchmark
need_memory: 8G
phoronix-test-suite:
  test: compress-gzip-1.2.0
rootfs: internal-lkp-server:/osimage/clear/clear-x86_64-phoronix-30140
kconfig: x86_64-lck-7983
run_on_local_disk: true
job_origin: phoronix-test-suite-clear.yaml
testbox: lkp-cfl-e1
arch: x86_64
tbox_group: lkp-cfl-e1

#! hosts/inn
serial_servers: lkp-wildcat lkp-os lkp-nhm-dp1 lkp-nhm-dp2 lkp-nhm-d01 lkp-serial01
boot_watchdog_mail: ignore

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
perf-profile: 

#! include/category/ALL
cpufreq_governor: performance

#! include/phoronix-test-suite

#! default params
compiler: gcc-7

#! queue options
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
branch: oracle-dtrace-linux-kernel/v1/5.5.2
commit: 0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912
submit_id: 5e5e54f8bfb2321cc1233b62
job_file: "/lkp/jobs/scheduled/lkp-cfl-e1/phoronix-test-suite-performance-compress-gzip-1.2.0-ucode=0xca-clear-x86_64-phoronix-30140-0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad-20200303-7361-114hz8h-0.yaml"
id: b738d304bffccbddd09012d8c82e5feee064ad05
queuer_version: "/lkp-src"

#! hosts/lkp-cfl-e1
model: Coffee Lake
nr_node: 1
nr_cpu: 16
memory: 32G
nr_hdd_partitions: 1
hdd_partitions: "/dev/disk/by-id/ata-WDC_WD1005FBYZ-01YCBB1_WD-WMC6M0D4MD6W-part2"
swap_partitions: LABEL=SWAP
rootfs_partition: "/dev/disk/by-id/ata-WDC_WD1005FBYZ-01YCBB1_WD-WMC6M0D4MD6W-part1"
brand: Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz

#! include/testbox/lkp-cfl-e1
ucode: '0xca'
need_kconfig_hw:
- CONFIG_IGB=y
- CONFIG_SATA_AHCI
enqueue_time: 2020-03-03 21:00:44.693826132 +08:00
_id: 5e5e54f8bfb2321cc1233b62
_rt: "/result/phoronix-test-suite/performance-compress-gzip-1.2.0-ucode=0xca/lkp-cfl-e1/clear-x86_64-phoronix-30140/x86_64-lck-7983/gcc-7/0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912"

#! schedule options
user: lkp
result_root: "/result/phoronix-test-suite/performance-compress-gzip-1.2.0-ucode=0xca/lkp-cfl-e1/clear-x86_64-phoronix-30140/x86_64-lck-7983/gcc-7/0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912/0"
scheduler_version: "/lkp/lkp/.src-20200302-232359"
LKP_SERVER: inn
max_uptime: 2089.38
initrd: "/osimage/initramfs/initramfs-20191118.cgz"
bootloader_append:
- root=/dev/disk/by-id/ata-WDC_WD1005FBYZ-01YCBB1_WD-WMC6M0D4MD6W-part1
- rootflags=subvol=clear-x86_64-phoronix-30140
- remote_rootfs=internal-lkp-server:/osimage/clear/clear-x86_64-phoronix-30140
- user=lkp
- job=/lkp/jobs/scheduled/lkp-cfl-e1/phoronix-test-suite-performance-compress-gzip-1.2.0-ucode=0xca-clear-x86_64-phoronix-30140-0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad-20200303-7361-114hz8h-0.yaml
- ARCH=x86_64
- kconfig=x86_64-lck-7983
- branch=oracle-dtrace-linux-kernel/v1/5.5.2
- commit=0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912
- BOOT_IMAGE=/pkg/linux/x86_64-lck-7983/gcc-7/0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912/vmlinuz-5.4.0-rc1-00010-g0b0695f2b34a4
- max_uptime=2089
- RESULT_ROOT=/result/phoronix-test-suite/performance-compress-gzip-1.2.0-ucode=0xca/lkp-cfl-e1/clear-x86_64-phoronix-30140/x86_64-lck-7983/gcc-7/0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912/0
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
modules_initrd: "/pkg/linux/x86_64-lck-7983/gcc-7/0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912/modules.cgz"
bm_initrd: "/osimage/pkg/clear-x86_64-phoronix-24300/turbostat-x86_64-d5256b2_2019-04-30.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20200220-180705/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.6.0-rc4-07215-g5387c31becf66
repeat_to: 2
schedule_notify_address: 

#! user overrides
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-lck-7983/gcc-7/0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912/vmlinuz-5.4.0-rc1-00010-g0b0695f2b34a4"
dequeue_time: 2020-03-03 21:33:02.364642004 +08:00

#! /lkp/lkp/.src-20200302-232359/include/site/inn
job_state: finished
loadavg: 19.61 10.59 4.29 1/772 3138
start_time: '1583242492'
end_time: '1583242677'
version: "/lkp/lkp/.src-20200302-232429:05b74346:59ce53d2c"

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done


--fdj2RfSjLxBAspz7--
