Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA286C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EEA120727
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HFzfhr00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgCIKY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 06:24:26 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:49928 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgCIKY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 06:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583749463; x=1615285463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=p4T4DRWInqMTWLZizWtJxvA7+iNVvnCfQVwxkhTPCiA=;
  b=HFzfhr003rHkzUSeTHb6PfgBywMup5aZwY8k17EGaw7zMusKtya+Y5sw
   ynz6kK4dj8nZiTAATsuq8d59lw3toVg83ygjV8ZzlFDo5vs8UfNVHP+52
   fqAGP1Wxi2C68wdiIyQuQZfJ2nt7Dag3p3USxHCGEMw1CgVH2PrUiVUR3
   Y=;
IronPort-SDR: aRNdBnsUB85FwzNBohBGTsy/xcHg03IJ8E4w2ivyPphGCzVrV+gxnZyEDJOEPi0yZOtk43RBKX
 EwYC+TCJVEhw==
X-IronPort-AV: E=Sophos;i="5.70,532,1574121600"; 
   d="scan'208";a="21678970"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 09 Mar 2020 10:24:18 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id 1A12DA246D;
        Mon,  9 Mar 2020 10:24:16 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 9 Mar 2020 10:24:15 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.164) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 9 Mar 2020 10:24:03 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <riel@surriel.com>,
        <aarcange@redhat.com>, <yang.shi@linux.alibaba.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.com>
Subject: Re: Re: [PATCH v6 00/14] Introduce Data Access MONitor (DAMON)
Date:   Mon, 9 Mar 2020 11:23:45 +0100
Message-ID: <20200309102345.13427-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302113512.8880-1-sjpark@amazon.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.164]
X-ClientProxiedBy: EX13D03UWA002.ant.amazon.com (10.43.160.144) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Mar 2020 12:35:12 +0100 SeongJae Park <sjpark@amazon.com> wrote:

> Hello,
> 
> On Mon, 24 Feb 2020 13:30:33 +0100 SeongJae Park <sjpark@amazon.com> wrote:
> 
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > Introduction
> > ============
> > 
> > Memory management decisions can be improved if finer data access information is
> > available.  However, because such finer information usually comes with higher
> > overhead, most systems including Linux forgives the potential improvement and
> > rely on only coarse information or some light-weight heuristics.  The
> > pseudo-LRU and the aggressive THP promotions are such examples.
> > 
> > A number of experimental data access pattern awared memory management
> > optimizations (refer to 'Appendix A' for more details) say the sacrifices are
> > huge.  However, none of those has successfully adopted to Linux kernel mainly
> > due to the absence of a scalable and efficient data access monitoring
> > mechanism.  Refer to 'Appendix B' to see the limitations of existing memory
> > monitoring mechanisms.
> > 
> > DAMON is a data access monitoring subsystem for the problem.  It is 1) accurate
> > enough to be used for the DRAM level memory management (a straightforward
> > DAMON-based optimization achieved up to 2.55x speedup), 2) light-weight enough
> > to be applied online (compared to a straightforward access monitoring scheme,
> > DAMON is up to 94.242.42x lighter) and 3) keeps predefined upper-bound overhead
> > regardless of the size of target workloads (thus scalable).  Refer to 'Appendix
> > C' if you interested in how it is possible.
> > 
> > DAMON has mainly designed for the kernel's memory management mechanisms.
> > However, because it is implemented as a standalone kernel module and provides
> > several interfaces, it can be used by a wide range of users including kernel
> > space programs, user space programs, programmers, and administrators.  DAMON
> > is now supporting the monitoring only, but it will also provide simple and
> > convenient data access pattern awared memory managements by itself.  Refer to
> > 'Appendix D' for more detailed expected usages of DAMON.
> 
> I have posted this patchset once per week, but skip this week because there
> were no comments in last week and therefore made no change in the patchset.
> 
> I think I answered to all previous comments and fixed all bugs previously
> found.  May I ask some more comments or reviews?  If I missed something or
> doing wrong, please let me know.

There was no review/comment in last week, and therefore I made no change in the
patchset.  Instead, I ran more evaluation tests to prove the concepts in more
formal way.  Sharing the results with you.

I hope this evaluation results makes more REVIEWS/COMMENTS than my patchsets ;)


Thanks,
SeongJae Park

================================== >8 =========================================


TL;DR
-----

DAMON is lightweight.  It makes target worloads only 0.76% slower and consumes
only -0.08% more system memory.

DAMON is accurate and useful for memory management optimizations.
An experimental DAMON-based operation scheme for THP removes 83.66% of THP
memory overheads while preserving 40.67% of THP speedup.
Another experimental DAMON-based 'proactive reclamation' implementation reduced
22.42% of system memory usage and 88.86% of residential sets while incurring
only 3.07% runtime overhead in best case.

NOTE that the experimentail THP optimization and proactive reclamation are not
for production, just only for proof of concepts.


Setup
-----

On my personal QEMU/KVM based virtual machine on an Intel i7 host machine
running Ubuntu 18.04, I measure runtime and consumed system memory while
running various realistic workloads with several configurations.  I use 13 and
12 workloads in PARSEC3[3] and SPLASH-2X[4] benchmark suites, respectively.  I
personally use another wrapper scripts[5] for setup and run of the workloads.
On top of this patchset, we also applied the DAMON-based operation schemes
patchset[6] for this evaluation.

Measurement
~~~~~~~~~~~

For the measurement of the amount of consumed memory in system global scope, I
drop caches before starting each of the workloads and monitor 'MemFree' in the
'/proc/meminfo' file.  To make results more stable, I repeat the runs 5 times
and average results.  You can get stdev, min, and max of the numbers among the
repeated runs in appendix below.

Configurations
~~~~~~~~~~~~~~

The configurations I use are as below.

    orig: Linux v5.5 with 'madvise' THP policy
    rec: 'orig' plus DAMON running with record feature
    thp: same with 'orig', but use 'always' THP policy
    ethp: 'orig' plus a DAMON operation scheme[6], 'efficient THP'
    prcl: 'orig' plus a DAMON operation scheme, 'proactive reclaim[7]'

I use 'rec' for measurement of DAMON overheads to target workloads and system
memory.  The remaining configs including 'thp', 'ethp', and 'prcl' are for
measurement of DAMON monitoring accuracy.

'ethp' and 'prcl' is simple DAMON-based operation schemes developed for
proof of concepts of DAMON.  'ethp' reduces memory space waste of THP by using
DAMON for decision of promotions and demotion for huge pages, while 'prcl' is
as similar as the original work.  Those are implemented as below:

    # format: <min/max size> <min/max frequency (0-100)> <min/max age> <action>
    # ethp: Use huge pages if a region >2MB shows >5% access rate, use regular
    # pages if a region >2MB shows <5% access rate for >1 second
    2M null    5 null    null null    hugepage
    2M null    null 5    1s null      nohugepage

    # prcl: If a region >4KB shows <5% access rate for >5 seconds, page out.
    4K null    null 5    5s null      pageout

Note that both 'ethp' and 'prcl' are designed with my only straightforward
intuition, because those are for only proof of concepts and monitoring accuracy
of DAMON.  In other words, those are not for production.  For production use,
those should be tuned more.


[1] "Redis latency problems troubleshooting", https://redis.io/topics/latency
[2] "Disable Transparent Huge Pages (THP)",
    https://docs.mongodb.com/manual/tutorial/transparent-huge-pages/
[3] "The PARSEC Becnhmark Suite", https://parsec.cs.princeton.edu/index.htm
[4] "SPLASH-2x", https://parsec.cs.princeton.edu/parsec3-doc.htm#splash2x
[5] "parsec3_on_ubuntu", https://github.com/sjp38/parsec3_on_ubuntu
[6] "[RFC v4 0/7] Implement Data Access Monitoring-based Memory Operation
    Schemes",
    https://lore.kernel.org/linux-mm/20200303121406.20954-1-sjpark@amazon.com/
[7] "Proactively reclaiming idle memory", https://lwn.net/Articles/787611/


Results
-------

Below two tables show the measurement results.  The runtimes are in seconds
while the memory usages are in KiB.  Each configurations except 'orig' shows
its overhead relative to 'orig' in percent within parenthesises.

runtime                 orig     rec      (overhead) thp      (overhead) ethp     (overhead) prcl     (overhead)
parsec3/blackscholes    106.586  107.160  (0.54)     106.535  (-0.05)    107.393  (0.76)     114.543  (7.47)    
parsec3/bodytrack       78.621   79.220   (0.76)     78.678   (0.07)     79.169   (0.70)     80.793   (2.76)    
parsec3/canneal         138.951  142.258  (2.38)     123.555  (-11.08)   133.588  (-3.86)    143.239  (3.09)    
parsec3/dedup           11.876   11.918   (0.35)     11.767   (-0.92)    11.957   (0.68)     13.235   (11.44)   
parsec3/facesim         207.761  208.159  (0.19)     204.735  (-1.46)    207.172  (-0.28)    208.663  (0.43)    
parsec3/ferret          190.694  192.004  (0.69)     190.345  (-0.18)    190.453  (-0.13)    192.081  (0.73)    
parsec3/fluidanimate    210.189  212.511  (1.10)     208.695  (-0.71)    210.843  (0.31)     213.379  (1.52)    
parsec3/freqmine        289.000  289.483  (0.17)     287.724  (-0.44)    289.761  (0.26)     297.878  (3.07)    
parsec3/raytrace        118.482  119.346  (0.73)     118.861  (0.32)     119.151  (0.56)     136.566  (15.26)   
parsec3/streamcluster   323.338  328.431  (1.58)     285.039  (-11.85)   296.830  (-8.20)    331.670  (2.58)    
parsec3/swaptions       155.853  156.826  (0.62)     154.089  (-1.13)    156.332  (0.31)     155.422  (-0.28)   
parsec3/vips            58.864   59.408   (0.92)     58.450   (-0.70)    58.976   (0.19)     61.068   (3.74)    
parsec3/x264            69.201   69.208   (0.01)     68.795   (-0.59)    71.501   (3.32)     71.766   (3.71)    
splash2x/barnes         81.140   80.869   (-0.33)    74.734   (-7.90)    79.859   (-1.58)    108.875  (34.18)   
splash2x/fft            33.442   33.579   (0.41)     22.949   (-31.38)   27.055   (-19.10)   40.261   (20.39)   
splash2x/lu_cb          85.064   85.441   (0.44)     84.688   (-0.44)    85.868   (0.95)     88.949   (4.57)    
splash2x/lu_ncb         92.606   93.615   (1.09)     90.484   (-2.29)    93.368   (0.82)     93.279   (0.73)    
splash2x/ocean_cp       44.672   44.826   (0.34)     43.024   (-3.69)    43.671   (-2.24)    45.889   (2.72)    
splash2x/ocean_ncp      81.360   81.434   (0.09)     51.157   (-37.12)   66.711   (-18.00)   91.611   (12.60)   
splash2x/radiosity      91.374   91.568   (0.21)     90.406   (-1.06)    91.609   (0.26)     103.790  (13.59)   
splash2x/radix          31.330   31.509   (0.57)     25.145   (-19.74)   26.296   (-16.07)   31.835   (1.61)    
splash2x/raytrace       84.715   85.274   (0.66)     82.034   (-3.16)    84.458   (-0.30)    84.967   (0.30)    
splash2x/volrend        86.625   87.844   (1.41)     86.206   (-0.48)    87.851   (1.42)     87.809   (1.37)    
splash2x/water_nsquared 231.661  233.817  (0.93)     221.024  (-4.59)    228.020  (-1.57)    236.306  (2.01)    
splash2x/water_spatial  89.101   89.616   (0.58)     88.845   (-0.29)    89.710   (0.68)     103.370  (16.01)   
total                   2992.490 3015.330 (0.76)     2857.950 (-4.50)    2937.610 (-1.83)    3137.260 (4.84)    


memused.avg             orig         rec          (overhead) thp          (overhead) ethp         (overhead) prcl         (overhead)
parsec3/blackscholes    1822704.400  1833697.600  (0.60)     1826160.400  (0.19)     1833316.800  (0.58)     1657871.000  (-9.04)   
parsec3/bodytrack       1417677.600  1434893.200  (1.21)     1420652.200  (0.21)     1431637.000  (0.98)     1433359.800  (1.11)    
parsec3/canneal         1044807.000  1056496.200  (1.12)     1037582.400  (-0.69)    1050845.200  (0.58)     1051668.200  (0.66)    
parsec3/dedup           2408896.200  2433019.000  (1.00)     2403343.200  (-0.23)    2421191.800  (0.51)     2461284.400  (2.17)    
parsec3/facesim         541808.200   554404.200   (2.32)     545591.600   (0.70)     553669.600   (2.19)     553910.600   (2.23)    
parsec3/ferret          319697.200   331642.400   (3.74)     320722.000   (0.32)     332126.000   (3.89)     330581.800   (3.40)    
parsec3/fluidanimate    573267.400   587376.200   (2.46)     574660.200   (0.24)     596108.600   (3.98)     538974.600   (-5.98)   
parsec3/freqmine        986872.400   998956.200   (1.22)     992037.800   (0.52)     989680.800   (0.28)     765626.800   (-22.42)  
parsec3/raytrace        1749641.800  1761473.200  (0.68)     1743617.800  (-0.34)    1753105.600  (0.20)     1580514.800  (-9.67)   
parsec3/streamcluster   125165.400   149479.600   (19.43)    122082.000   (-2.46)    140484.200   (12.24)    132027.000   (5.48)    
parsec3/swaptions       15515.400    29577.200    (90.63)    15692.000    (1.14)     26733.200    (72.30)    28423.000    (83.19)   
parsec3/vips            2954233.800  2970852.400  (0.56)     2954338.800  (0.00)     2959100.200  (0.16)     2951979.600  (-0.08)   
parsec3/x264            3174959.000  3191900.200  (0.53)     3192736.200  (0.56)     3201927.200  (0.85)     3194867.400  (0.63)    
splash2x/barnes         1215064.400  1209725.600  (-0.44)    1215945.600  (0.07)     1212294.600  (-0.23)    937605.800   (-22.83)  
splash2x/fft            9429331.600  9187727.600  (-2.56)    9290976.600  (-1.47)    9036430.800  (-4.17)    9409815.800  (-0.21)   
splash2x/lu_cb          512744.800   521964.600   (1.80)     521795.800   (1.77)     522445.600   (1.89)     346352.200   (-32.45)  
splash2x/lu_ncb         516623.000   523673.200   (1.36)     520129.200   (0.68)     522398.800   (1.12)     522246.200   (1.09)    
splash2x/ocean_cp       3325422.200  3287326.200  (-1.15)    3381646.400  (1.69)     3294803.400  (-0.92)    3287401.800  (-1.14)   
splash2x/ocean_ncp      3894128.600  3868638.400  (-0.65)    7065137.400  (81.43)    4844981.600  (24.42)    3811968.400  (-2.11)   
splash2x/radiosity      1471464.000  1470680.800  (-0.05)    1481054.600  (0.65)     1472332.200  (0.06)     521064.000   (-64.59)  
splash2x/radix          1698164.400  1707518.400  (0.55)     1385276.800  (-18.42)   1415885.000  (-16.62)   1717103.600  (1.12)    
splash2x/raytrace       45334.200    59478.400    (31.20)    52893.400    (16.67)    62366.000    (37.57)    53765.800    (18.60)   
splash2x/volrend        151118.400   167429.800   (10.79)    151600.000   (0.32)     163950.800   (8.49)     162873.800   (7.78)    
splash2x/water_nsquared 46839.000    61947.000    (32.26)    49173.600    (4.98)     58301.200    (24.47)    56678.400    (21.01)   
splash2x/water_spatial  666960.000   674851.600   (1.18)     668957.600   (0.30)     673287.400   (0.95)     463938.800   (-30.44)  
total                   40108199.000 40074800.000 (-0.08)    42933800.000 (7.04)     40569300.000 (1.15)     37972000.000 (-5.33)   


DAMON Overheads
~~~~~~~~~~~~~~~

In total, DAMON recording feature incurs 0.76% runtime overhead (up to 2.38% in
worst case with 'parsec3/canneal') and -0.08% memory space overhead.

For convenience test run of 'rec', I use a Python wrapper.  The wrapper
constantly consumes about 10-15MB of memory.  This becomes high memory overhead
if the target workload has small memory footprint.  In detail, 19%, 90%, 31%,
10%, and 32% overheads shown for parsec3/streamcluster (125 MiB),
parsec3/swaptions (15 MiB), splash2x/raytrace (45 MiB), splash2x/volrend (151
MiB), and splash2x/water_nsquared (46 MiB)).  Nonetheless, the overheads are
not from DAMON, but from the wrapper, and thus should be ignored.  This fake
memory overhead continues in 'ethp' and 'prcl', as those configurations are
also using the Python wrapper.


Efficient THP
~~~~~~~~~~~~~

THP 'always' enabled policy achieves 4.5% speedup but incurs 7.04% memory
overhead.  It achieves 37.12% speedup in best case, but 81.43% memory overhead
in worst case.  Interestingly, both the best and worst case are with
'splash2x/ocean_ncp').

The 2-lines implementation of data access monitoring based THP version ('ethp')
shows 1.83% speedup and 1.15% memory overhead.  In other words, 'ethp' removes
83.66% of THP memory waste while preserving 40.67% of THP speedup in total.

In case of the 'splash2x/ocean_ncp', which is best for speedup but worst for
memory overhead of THP, 'ethp' removes 70% of THP memory space overhead while
preserving 48.49% of THP speedup.


Proactive Reclamation
~~~~~~~~~~~~~~~~~~~~~

As same to the original work, I use 'zram' swap device for this configuration.

In total, our 1 line implementation of Proactive Reclamation, 'prcl', incurred
4.84% runtime overhead in total while achieving 5.33% system memory usage
reduction.

Nonetheless, as the memory usage is calculated with 'MemFree' in
'/proc/meminfo', it contains the SwapCached pages.  As the swapcached pages can
be easily evicted, I also measured the residential set size of the workloads:

rss.avg                 orig         prcl         (overhead)
parsec3/blackscholes    589633.600   329611.400   (-44.10)
parsec3/bodytrack       32217.600    21652.200    (-32.79)
parsec3/canneal         840411.600   838931.000   (-0.18)
parsec3/dedup           1223907.600  835473.600   (-31.74)
parsec3/facesim         311271.600   311070.200   (-0.06)
parsec3/ferret          99635.600    89290.800    (-10.38)
parsec3/fluidanimate    531760.000   484945.600   (-8.80)
parsec3/freqmine        552609.400   61583.600    (-88.86)
parsec3/raytrace        896446.600   317792.000   (-64.55)
parsec3/streamcluster   110793.600   108061.600   (-2.47)
parsec3/swaptions       5604.600     2694.400     (-51.93)
parsec3/vips            31779.600    28422.200    (-10.56)
parsec3/x264            81943.800    81874.600    (-0.08)
splash2x/barnes         1219389.600  619038.600   (-49.23)
splash2x/fft            9597789.600  7264542.200  (-24.31)
splash2x/lu_cb          510524.000   327813.600   (-35.79)
splash2x/lu_ncb         510131.200   510146.800   (0.00)
splash2x/ocean_cp       3406968.600  3341620.400  (-1.92)
splash2x/ocean_ncp      3919926.800  3670768.800  (-6.36)
splash2x/radiosity      1474387.800  254678.600   (-82.73)
splash2x/radix          1723283.200  1763916.000  (2.36)
splash2x/raytrace       23194.400    17454.000    (-24.75)
splash2x/volrend        43980.000    32524.600    (-26.05)
splash2x/water_nsquared 29327.200    23989.200    (-18.20)
splash2x/water_spatial  656323.200   381068.600   (-41.94)
total                   28423300.000 21719000.000 (-23.59)

In total, 23.59% of residential sets were reduced.

With parsec3/freqmine, 'prcl' reduced 22.42% of system memory
usage and 88.86% of residential sets while incurring only 3.07% runtime
overhead.
