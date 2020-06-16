Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_BTC_ID,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056FFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D178F208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="cQZFlTLv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgFPOqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgFPOqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:46:09 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83065C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 07:46:09 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 205so19360681qkg.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 07:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=t1VECONrgvLF/rC+9HfQqT0MTH5om676p3k8XrFKigY=;
        b=cQZFlTLvtuF9gPEzR6HpLQGd2IU8Wj+oV3QtmZponI7HM9Tl5abQo8a/m7AxGmmbyw
         z1lybO+SpJ7NUG90S5qoILZYLXg4+SMKfVacqnQJ7qv/xQRYf2WdoTES29JdPqtWn11S
         IUcqyRhn2kQU3Ao9zoADJzHItnHUZOqvTirEvaNjuavKxFskjsygpmBPjn9DtD2W80Ii
         cUL+3tmpHUTanCgr+XUmxTTkaOxqdelHjM+vRy7FrHraZ0Kqs4HjLboqUKelwGgwR44R
         lS/0/YkoiibDGn26FoWhM8vItoMeC3nUGpqj2UZhjasWIRGWn9Tu2D3KHHgFQ+7OB58i
         9WwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=t1VECONrgvLF/rC+9HfQqT0MTH5om676p3k8XrFKigY=;
        b=eloVZaQ3RuOI3beQqZCty7wMVi7JS/uagowRzxLurcJ6hc4liGg5MvEZ1N2AiRh8M6
         epCTi8+xqgadXr7Qc14ueia9qMR4cR1YvYvI8Rcq1UCHzlv97eXtCBzqqgyt7mOsDXzT
         1ysNjUzhyJHH3yyEXrWgKMiBm7uWUcWLno1qvEgGYWzH+LQ5GxHmPO3W7FHhvWZbbF7J
         K0DcVukw3BpcjTsg0IA+zSsilAhFf6sM3BYB4u4CCnYIlV472f8F35ljOqFe3xYm8fEr
         9HkLamQha85kCBS+0MXbfo/9L9KFxOGbsd3Gp2TP4HASKq+GH4aptU6LtT3Aiv1Cm3Cd
         rV9A==
X-Gm-Message-State: AOAM532r9xhV+OzYNccymNtMQoBRqwNXROVErNDSInCLdwr5DvOAA9Ny
        eSHmoem2ZDC1CxJbbBLOcZoDSQ==
X-Google-Smtp-Source: ABdhPJz1+TkYAWMBsaEvvw5YqLgqJjMYa+cx1eVc3nJTvdQTCokEkOByu3DOK4xlHS9SBtoBG/0sBg==
X-Received: by 2002:a05:620a:1407:: with SMTP id d7mr19233358qkj.89.1592318768164;
        Tue, 16 Jun 2020 07:46:08 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id d140sm14715406qkc.22.2020.06.16.07.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 07:46:07 -0700 (PDT)
Date:   Tue, 16 Jun 2020 10:45:29 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [mm] 1431d4d11a: vm-scalability.throughput -11.5% regression
Message-ID: <20200616144529.GA616830@cmpxchg.org>
References: <20200616075750.GM5653@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200616075750.GM5653@shao2-debian>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 03:57:50PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -11.5% regression of vm-scalability.throughput due to commit:
> 
> 
> commit: 1431d4d11abb265e79cd44bed2f5ea93f1bcc57b ("mm: base LRU balancing on an explicit cost model")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

That's a really curious result.

An bit of an increase in system time is expected in the series as a
whole:

1. When thrashing is detected in the file cache, it intentionally
makes more effort to find reclaimable anon pages than before - in an
effort to converge on a stable state that has *neither* page reclaim
nor refault IO.

2. There are a couple of XXX about unrealized lock batching
opportunities. Those weren't/aren't expected to have too much of a
practical impact, and require a bit more infrastructure work that
would have interferred with other ongoing work in the area.

However, this patch in particular doesn't add any locked sections (it
adds a function call to an existing one, I guess?), and the workload
is doing streaming mmapped IO and shouldn't experience any thrashing.

In addition, we shouldn't even scan anon pages - from below:

> swap_partitions: 
> rootfs_partition: "/dev/disk/by-id/wwn-0x5000c50067b47753-part1"

Does that mean that no swap space (not even a file) is configured?

> in testcase: vm-scalability
> on test machine: 160 threads Intel(R) Xeon(R) CPU E7-8890 v4 @ 2.20GHz with 256G memory
> with following parameters:
> 
> 	runtime: 300s
> 	test: lru-file-mmap-read
> 	cpufreq_governor: performance
> 	ucode: 0xb000038
> 
> test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
> test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/
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
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
> 
> =========================================================================================
> compiler/cpufreq_governor/kconfig/rootfs/runtime/tbox_group/test/testcase/ucode:
>   gcc-9/performance/x86_64-rhel-7.6/debian-x86_64-20191114.cgz/300s/lkp-bdw-ex2/lru-file-mmap-read/vm-scalability/0xb000038
> 
> commit: 
>   a4fe1631f3 ("mm: vmscan: drop unnecessary div0 avoidance rounding in get_scan_count()")
>   1431d4d11a ("mm: base LRU balancing on an explicit cost model")
> 
> a4fe1631f313f75c 1431d4d11abb265e79cd44bed2f 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>       0.23 ±  2%     +11.7%       0.26        vm-scalability.free_time

What's free_time?

>     103991           -11.6%      91935        vm-scalability.median
>   20717269           -11.5%   18336098        vm-scalability.throughput
>     376.47            +8.3%     407.78        vm-scalability.time.elapsed_time
>     376.47            +8.3%     407.78        vm-scalability.time.elapsed_time.max
>     392226            +7.2%     420612        vm-scalability.time.involuntary_context_switches
>      11731            +4.4%      12247        vm-scalability.time.percent_of_cpu_this_job_got
>      41005           +14.5%      46936        vm-scalability.time.system_time
>       3156            -4.8%       3005        vm-scalability.time.user_time
>   52662860 ±  5%     -14.0%   45266760 ±  5%  meminfo.DirectMap2M
>       4.43            -0.5        3.90 ±  2%  mpstat.cpu.all.usr%
>       1442 ±  5%     -14.9%       1227 ± 10%  slabinfo.kmalloc-rcl-96.active_objs
>       1442 ±  5%     -14.9%       1227 ± 10%  slabinfo.kmalloc-rcl-96.num_objs
>      37.50 ±  2%      -7.3%      34.75        vmstat.cpu.id
>      57.25            +5.2%      60.25        vmstat.cpu.sy
>      54428 ± 60%     -96.5%       1895 ±173%  numa-meminfo.node1.AnonHugePages
>     116516 ± 48%     -88.2%      13709 ± 26%  numa-meminfo.node1.AnonPages
>     132303 ± 84%     -88.9%      14731 ± 61%  numa-meminfo.node3.Inactive(anon)

These counters capture present state, not history. Are these averages
or snapshots? If snapshots, when are they taken during the test?

>     311.75 ±  8%     +16.0%     361.75 ±  2%  numa-vmstat.node0.nr_isolated_file
>      29136 ± 48%     -88.4%       3367 ± 24%  numa-vmstat.node1.nr_anon_pages
>   35935841 ±  6%     -17.0%   29839972 ±  6%  numa-vmstat.node2.numa_foreign
>      33046 ± 84%     -89.1%       3595 ± 61%  numa-vmstat.node3.nr_inactive_anon
>      33046 ± 84%     -89.1%       3596 ± 61%  numa-vmstat.node3.nr_zone_inactive_anon
>      21.43 ± 15%     +79.4%      38.44 ± 54%  sched_debug.cfs_rq:/.load_avg.avg
>      95.92 ±  9%     +96.7%     188.64 ± 67%  sched_debug.cfs_rq:/.load_avg.stddev
>      36.18 ±  7%     +13.6%      41.10 ±  4%  sched_debug.cfs_rq:/.nr_spread_over.avg
>    1075687 ±102%    +233.3%    3585792 ± 70%  sched_debug.cfs_rq:/.spread0.avg
>    2865813 ± 41%     +87.3%    5367329 ± 42%  sched_debug.cfs_rq:/.spread0.max
>   -6253423           -61.1%   -2430118        sched_debug.cfs_rq:/.spread0.min
>     351.68 ±  8%     -14.8%     299.58 ±  6%  sched_debug.cpu.sched_goidle.avg
>       9441 ± 11%     -21.9%       7376 ±  7%  sched_debug.cpu.sched_goidle.max
>      54.46 ±  5%     -19.5%      43.82 ±  6%  sched_debug.cpu.sched_goidle.min
>     873.06 ±  8%     -19.2%     705.36 ±  4%  sched_debug.cpu.sched_goidle.stddev
>     898.25 ± 10%     -15.5%     759.25 ± 12%  proc-vmstat.kswapd_low_wmark_hit_quickly
>     108483            +4.0%     112790        proc-vmstat.nr_active_anon
>       1006 ±  4%      +9.3%       1099 ±  2%  proc-vmstat.nr_isolated_file
>   72985192            +4.5%   76275208        proc-vmstat.nr_mapped
>     634868            +5.0%     666703 ±  2%  proc-vmstat.nr_page_table_pages
>     106506            +3.6%     110328        proc-vmstat.nr_shmem
>     108486            +4.0%     112792        proc-vmstat.nr_zone_active_anon
>       7453 ± 42%     +67.4%      12474 ± 12%  proc-vmstat.numa_hint_faults
>       1597 ±  5%      -8.8%       1457 ±  6%  proc-vmstat.pageoutrun
>      55272            +3.6%      57288        proc-vmstat.pgactivate
>  1.603e+09            -2.7%   1.56e+09        proc-vmstat.pgscan_direct
>  2.935e+08 ±  3%     +13.1%   3.32e+08 ±  2%  proc-vmstat.pgscan_kswapd

More scan activity. The patch can affect the scan ratio between anon
and file, so this only makes sense when there is swap space configured
and anon pages are actually scanned.

Would it be possible to capture deltas of the new pgscan_anon &
pgscan_file vmstat counters? As well as the workingset_* ones?

Thanks!
