Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=BITCOIN_SPAM_02,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_BTC_ID,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD23C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 06:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2BC5217A0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 06:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgFRGQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 02:16:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:36839 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgFRGQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 02:16:38 -0400
IronPort-SDR: BOyUG5YykbDFquU956bituXSS8fvkEIpIcrDNF+mFksuZmSbyTM/5/SJZTiqd1Yyl1B9MTxFnl
 U4R06dt1+FNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9655"; a="139963677"
X-IronPort-AV: E=Sophos;i="5.73,525,1583222400"; 
   d="scan'208";a="139963677"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 23:16:30 -0700
IronPort-SDR: bJQh40ZI1LnlnsjUsSuGnaAm2Ivsr5ZM4httlFKYJJxIv1/RRGcwYVOIYnDjVEjm3tttA1bl68
 VFSLkkwquq9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,525,1583222400"; 
   d="scan'208";a="291665951"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.238.6.47]) ([10.238.6.47])
  by orsmga002.jf.intel.com with ESMTP; 17 Jun 2020 23:16:27 -0700
Subject: Re: [LKP] Re: [mm] 1431d4d11a: vm-scalability.throughput -11.5%
 regression
To:     Johannes Weiner <hannes@cmpxchg.org>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200616075750.GM5653@shao2-debian>
 <20200616144529.GA616830@cmpxchg.org>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <38efcb29-14c1-6b8b-ef9b-f42e0de14010@linux.intel.com>
Date:   Thu, 18 Jun 2020 14:16:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200616144529.GA616830@cmpxchg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/2020 10:45 PM, Johannes Weiner wrote:
> On Tue, Jun 16, 2020 at 03:57:50PM +0800, kernel test robot wrote:
>> Greeting,
>>
>> FYI, we noticed a -11.5% regression of vm-scalability.throughput due to commit:
>>
>>
>> commit: 1431d4d11abb265e79cd44bed2f5ea93f1bcc57b ("mm: base LRU balancing on an explicit cost model")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> That's a really curious result.
> 
> An bit of an increase in system time is expected in the series as a
> whole:
> 
> 1. When thrashing is detected in the file cache, it intentionally
> makes more effort to find reclaimable anon pages than before - in an
> effort to converge on a stable state that has *neither* page reclaim
> nor refault IO.
> 
> 2. There are a couple of XXX about unrealized lock batching
> opportunities. Those weren't/aren't expected to have too much of a
> practical impact, and require a bit more infrastructure work that
> would have interferred with other ongoing work in the area.
> 
> However, this patch in particular doesn't add any locked sections (it
> adds a function call to an existing one, I guess?), and the workload
> is doing streaming mmapped IO and shouldn't experience any thrashing.
> 
> In addition, we shouldn't even scan anon pages - from below:
> 
>> swap_partitions:
>> rootfs_partition: "/dev/disk/by-id/wwn-0x5000c50067b47753-part1"
> 
> Does that mean that no swap space (not even a file) is configured?
> 

In this case, the swap is disabled (if enabled, you should find the 
"swap:" in the job file), "swap_patitions:" is just the description of 
the hardware.

>> in testcase: vm-scalability
>> on test machine: 160 threads Intel(R) Xeon(R) CPU E7-8890 v4 @ 2.20GHz with 256G memory
>> with following parameters:
>>
>> 	runtime: 300s
>> 	test: lru-file-mmap-read
>> 	cpufreq_governor: performance
>> 	ucode: 0xb000038
>>
>> test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
>> test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/
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
>> compiler/cpufreq_governor/kconfig/rootfs/runtime/tbox_group/test/testcase/ucode:
>>    gcc-9/performance/x86_64-rhel-7.6/debian-x86_64-20191114.cgz/300s/lkp-bdw-ex2/lru-file-mmap-read/vm-scalability/0xb000038
>>
>> commit:
>>    a4fe1631f3 ("mm: vmscan: drop unnecessary div0 avoidance rounding in get_scan_count()")
>>    1431d4d11a ("mm: base LRU balancing on an explicit cost model")
>>
>> a4fe1631f313f75c 1431d4d11abb265e79cd44bed2f
>> ---------------- ---------------------------
>>           %stddev     %change         %stddev
>>               \          |                \
>>        0.23 ±  2%     +11.7%       0.26        vm-scalability.free_time
> 
> What's free_time?

The average of the time to free memory(unit: second) , you can see the 
output of vm-scalability( 
https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/) 
benchamrk log "xxxxxxx usecs to free memory"
> 
>>      103991           -11.6%      91935        vm-scalability.median
>>    20717269           -11.5%   18336098        vm-scalability.throughput
>>      376.47            +8.3%     407.78        vm-scalability.time.elapsed_time
>>      376.47            +8.3%     407.78        vm-scalability.time.elapsed_time.max
>>      392226            +7.2%     420612        vm-scalability.time.involuntary_context_switches
>>       11731            +4.4%      12247        vm-scalability.time.percent_of_cpu_this_job_got
>>       41005           +14.5%      46936        vm-scalability.time.system_time
>>        3156            -4.8%       3005        vm-scalability.time.user_time
>>    52662860 ±  5%     -14.0%   45266760 ±  5%  meminfo.DirectMap2M
>>        4.43            -0.5        3.90 ±  2%  mpstat.cpu.all.usr%
>>        1442 ±  5%     -14.9%       1227 ± 10%  slabinfo.kmalloc-rcl-96.active_objs
>>        1442 ±  5%     -14.9%       1227 ± 10%  slabinfo.kmalloc-rcl-96.num_objs
>>       37.50 ±  2%      -7.3%      34.75        vmstat.cpu.id
>>       57.25            +5.2%      60.25        vmstat.cpu.sy
>>       54428 ± 60%     -96.5%       1895 ±173%  numa-meminfo.node1.AnonHugePages
>>      116516 ± 48%     -88.2%      13709 ± 26%  numa-meminfo.node1.AnonPages
>>      132303 ± 84%     -88.9%      14731 ± 61%  numa-meminfo.node3.Inactive(anon)
> 
> These counters capture present state, not history. Are these averages
> or snapshots? If snapshots, when are they taken during the test?

These are averages.

> 
>>      311.75 ±  8%     +16.0%     361.75 ±  2%  numa-vmstat.node0.nr_isolated_file
>>       29136 ± 48%     -88.4%       3367 ± 24%  numa-vmstat.node1.nr_anon_pages
>>    35935841 ±  6%     -17.0%   29839972 ±  6%  numa-vmstat.node2.numa_foreign
>>       33046 ± 84%     -89.1%       3595 ± 61%  numa-vmstat.node3.nr_inactive_anon
>>       33046 ± 84%     -89.1%       3596 ± 61%  numa-vmstat.node3.nr_zone_inactive_anon
>>       21.43 ± 15%     +79.4%      38.44 ± 54%  sched_debug.cfs_rq:/.load_avg.avg
>>       95.92 ±  9%     +96.7%     188.64 ± 67%  sched_debug.cfs_rq:/.load_avg.stddev
>>       36.18 ±  7%     +13.6%      41.10 ±  4%  sched_debug.cfs_rq:/.nr_spread_over.avg
>>     1075687 ±102%    +233.3%    3585792 ± 70%  sched_debug.cfs_rq:/.spread0.avg
>>     2865813 ± 41%     +87.3%    5367329 ± 42%  sched_debug.cfs_rq:/.spread0.max
>>    -6253423           -61.1%   -2430118        sched_debug.cfs_rq:/.spread0.min
>>      351.68 ±  8%     -14.8%     299.58 ±  6%  sched_debug.cpu.sched_goidle.avg
>>        9441 ± 11%     -21.9%       7376 ±  7%  sched_debug.cpu.sched_goidle.max
>>       54.46 ±  5%     -19.5%      43.82 ±  6%  sched_debug.cpu.sched_goidle.min
>>      873.06 ±  8%     -19.2%     705.36 ±  4%  sched_debug.cpu.sched_goidle.stddev
>>      898.25 ± 10%     -15.5%     759.25 ± 12%  proc-vmstat.kswapd_low_wmark_hit_quickly
>>      108483            +4.0%     112790        proc-vmstat.nr_active_anon
>>        1006 ±  4%      +9.3%       1099 ±  2%  proc-vmstat.nr_isolated_file
>>    72985192            +4.5%   76275208        proc-vmstat.nr_mapped
>>      634868            +5.0%     666703 ±  2%  proc-vmstat.nr_page_table_pages
>>      106506            +3.6%     110328        proc-vmstat.nr_shmem
>>      108486            +4.0%     112792        proc-vmstat.nr_zone_active_anon
>>        7453 ± 42%     +67.4%      12474 ± 12%  proc-vmstat.numa_hint_faults
>>        1597 ±  5%      -8.8%       1457 ±  6%  proc-vmstat.pageoutrun
>>       55272            +3.6%      57288        proc-vmstat.pgactivate
>>   1.603e+09            -2.7%   1.56e+09        proc-vmstat.pgscan_direct
>>   2.935e+08 ±  3%     +13.1%   3.32e+08 ±  2%  proc-vmstat.pgscan_kswapd
> 
> More scan activity. The patch can affect the scan ratio between anon
> and file, so this only makes sense when there is swap space configured
> and anon pages are actually scanned.
> 
> Would it be possible to capture deltas of the new pgscan_anon &
> pgscan_file vmstat counters? As well as the workingset_* ones?
> 

In fact, all the data supported by the vmstat will be captured, but it 
only shows the deltas > 1%, for pgscan_file the delta should < 1%.

> Thanks!
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
> 

-- 
Zhengjun Xing
