Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA7FC2D0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9100220CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbgCaPwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:52:08 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2622 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730105AbgCaPwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:52:08 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id B15ECDC9B871BA5E86A4;
        Tue, 31 Mar 2020 16:52:05 +0100 (IST)
Received: from localhost (10.47.93.255) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 31 Mar
 2020 16:52:04 +0100
Date:   Tue, 31 Mar 2020 16:51:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     SeongJae Park <sjpark@amazon.com>,
        <alexander.shishkin@linux.intel.com>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, SeongJae Park <sjpark@amazon.de>,
        <aarcange@redhat.com>, <acme@kernel.org>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shakeelb@google.com>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v5 0/7] Implement Data Access Monitoring-based Memory
 Operation Schemes
Message-ID: <20200331165155.000028e4@Huawei.com>
In-Reply-To: <20200330115042.17431-1-sjpark@amazon.com>
References: <20200330115042.17431-1-sjpark@amazon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.93.255]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Mar 2020 13:50:35 +0200
SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> DAMON[1] can be used as a primitive for data access awared memory management
> optimizations.  That said, users who want such optimizations should run DAMON,
> read the monitoring results, analyze it, plan a new memory management scheme,
> and apply the new scheme by themselves.  Such efforts will be inevitable for
> some complicated optimizations.
> 
> However, in many other cases, the users could simply want the system to apply a
> memory management action to a memory region of a specific size having a
> specific access frequency for a specific time.  For example, "page out a memory
> region larger than 100 MiB keeping only rare accesses more than 2 minutes", or
> "Do not use THP for a memory region larger than 2 MiB rarely accessed for more
> than 1 seconds".
> 
> This RFC patchset makes DAMON to handle such data access monitoring-based
> operation schemes.  With this change, users can do the data access awared
> optimizations by simply specifying their schemes to DAMON.


Hi SeongJae,

I'm wondering if I'm misreading the results below or a data handling mixup
occured. See inline.

Thanks,

Jonathan

> 
> 
> Evaluations
> ===========
> 
> Setup
> -----
> 
> On my personal QEMU/KVM based virtual machine on an Intel i7 host machine
> running Ubuntu 18.04, I measure runtime and consumed system memory while
> running various realistic workloads with several configurations.  I use 13 and
> 12 workloads in PARSEC3[3] and SPLASH-2X[4] benchmark suites, respectively.  I
> personally use another wrapper scripts[5] for setup and run of the workloads.
> On top of this patchset, we also applied the DAMON-based operation schemes
> patchset[6] for this evaluation.
> 
> Measurement
> ~~~~~~~~~~~
> 
> For the measurement of the amount of consumed memory in system global scope, I
> drop caches before starting each of the workloads and monitor 'MemFree' in the
> '/proc/meminfo' file.  To make results more stable, I repeat the runs 5 times
> and average results.  You can get stdev, min, and max of the numbers among the
> repeated runs in appendix below.
> 
> Configurations
> ~~~~~~~~~~~~~~
> 
> The configurations I use are as below.
> 
> orig: Linux v5.5 with 'madvise' THP policy
> rec: 'orig' plus DAMON running with record feature
> thp: same with 'orig', but use 'always' THP policy
> ethp: 'orig' plus a DAMON operation scheme[6], 'efficient THP'
> prcl: 'orig' plus a DAMON operation scheme, 'proactive reclaim[7]'
> 
> I use 'rec' for measurement of DAMON overheads to target workloads and system
> memory.  The remaining configs including 'thp', 'ethp', and 'prcl' are for
> measurement of DAMON monitoring accuracy.
> 
> 'ethp' and 'prcl' is simple DAMON-based operation schemes developed for
> proof of concepts of DAMON.  'ethp' reduces memory space waste of THP by using
> DAMON for decision of promotions and demotion for huge pages, while 'prcl' is
> as similar as the original work.  Those are implemented as below:
> 
> # format: <min/max size> <min/max frequency (0-100)> <min/max age> <action>
> # ethp: Use huge pages if a region >2MB shows >5% access rate, use regular
> # pages if a region >2MB shows <5% access rate for >1 second
> 2M null    5 null    null null    hugepage
> 2M null    null 5    1s null      nohugepage
> 
> # prcl: If a region >4KB shows <5% access rate for >5 seconds, page out.
> 4K null    null 5    5s null      pageout
> 
> Note that both 'ethp' and 'prcl' are designed with my only straightforward
> intuition, because those are for only proof of concepts and monitoring accuracy
> of DAMON.  In other words, those are not for production.  For production use,
> those should be tuned more.
> 
> 
> [1] "Redis latency problems troubleshooting", https://redis.io/topics/latency
> [2] "Disable Transparent Huge Pages (THP)",
>     https://docs.mongodb.com/manual/tutorial/transparent-huge-pages/
> [3] "The PARSEC Becnhmark Suite", https://parsec.cs.princeton.edu/index.htm
> [4] "SPLASH-2x", https://parsec.cs.princeton.edu/parsec3-doc.htm#splash2x
> [5] "parsec3_on_ubuntu", https://github.com/sjp38/parsec3_on_ubuntu
> [6] "[RFC v4 0/7] Implement Data Access Monitoring-based Memory Operation
>     Schemes",
>     https://lore.kernel.org/linux-mm/20200303121406.20954-1-sjpark@amazon.com/
> [7] "Proactively reclaiming idle memory", https://lwn.net/Articles/787611/
> 
> 
> Results
> -------
> 
> Below two tables show the measurement results.  The runtimes are in seconds
> while the memory usages are in KiB.  Each configurations except 'orig' shows
> its overhead relative to 'orig' in percent within parenthesises.
> 
> runtime                 orig     rec      (overhead) thp      (overhead) ethp     (overhead) prcl     (overhead)
> parsec3/blackscholes    107.594  107.956  (0.34)     106.750  (-0.78)    107.672  (0.07)     111.916  (4.02)    
> parsec3/bodytrack       79.230   79.368   (0.17)     78.908   (-0.41)    79.705   (0.60)     80.423   (1.50)    
> parsec3/canneal         142.831  143.810  (0.69)     123.530  (-13.51)   133.778  (-6.34)    144.998  (1.52)    
> parsec3/dedup           11.986   11.959   (-0.23)    11.762   (-1.87)    12.028   (0.35)     13.313   (11.07)   
> parsec3/facesim         210.125  209.007  (-0.53)    205.226  (-2.33)    207.766  (-1.12)    209.815  (-0.15)   
> parsec3/ferret          191.601  191.177  (-0.22)    190.420  (-0.62)    191.775  (0.09)     192.638  (0.54)    
> parsec3/fluidanimate    212.735  212.970  (0.11)     209.151  (-1.68)    211.904  (-0.39)    218.573  (2.74)    
> parsec3/freqmine        291.225  290.873  (-0.12)    289.258  (-0.68)    289.884  (-0.46)    298.373  (2.45)    
> parsec3/raytrace        118.289  119.586  (1.10)     119.045  (0.64)     119.064  (0.66)     137.919  (16.60)   
> parsec3/streamcluster   323.565  328.168  (1.42)     279.565  (-13.60)   287.452  (-11.16)   333.244  (2.99)    
> parsec3/swaptions       155.140  155.473  (0.21)     153.816  (-0.85)    156.423  (0.83)     156.237  (0.71)    
> parsec3/vips            58.979   59.311   (0.56)     58.733   (-0.42)    59.005   (0.04)     61.062   (3.53)    
> parsec3/x264            70.539   68.413   (-3.01)    64.760   (-8.19)    67.180   (-4.76)    68.103   (-3.45)   
> splash2x/barnes         80.414   81.751   (1.66)     73.585   (-8.49)    80.232   (-0.23)    115.753  (43.95)   
> splash2x/fft            33.902   34.111   (0.62)     24.228   (-28.53)   29.926   (-11.73)   44.438   (31.08)   
> splash2x/lu_cb          85.556   86.001   (0.52)     84.538   (-1.19)    86.000   (0.52)     91.447   (6.89)    
> splash2x/lu_ncb         93.399   93.652   (0.27)     90.463   (-3.14)    94.008   (0.65)     93.901   (0.54)    
> splash2x/ocean_cp       45.253   45.191   (-0.14)    43.049   (-4.87)    44.022   (-2.72)    46.588   (2.95)    
> splash2x/ocean_ncp      86.927   87.065   (0.16)     50.747   (-41.62)   86.855   (-0.08)    199.553  (129.57)  
> splash2x/radiosity      91.433   91.511   (0.09)     90.626   (-0.88)    91.865   (0.47)     104.524  (14.32)   
> splash2x/radix          31.923   32.023   (0.31)     25.194   (-21.08)   32.035   (0.35)     39.231   (22.89)   
> splash2x/raytrace       84.367   84.677   (0.37)     82.417   (-2.31)    83.505   (-1.02)    84.857   (0.58)    
> splash2x/volrend        87.499   87.495   (-0.00)    86.775   (-0.83)    87.311   (-0.21)    87.511   (0.01)    
> splash2x/water_nsquared 236.397  236.759  (0.15)     219.902  (-6.98)    224.228  (-5.15)    238.562  (0.92)    
> splash2x/water_spatial  89.646   89.767   (0.14)     89.735   (0.10)     90.347   (0.78)     103.585  (15.55)   
> total                   3020.570 3028.080 (0.25)     2852.190 (-5.57)    2953.960 (-2.21)    3276.550 (8.47)    
> 
> 
> memused.avg             orig         rec          (overhead) thp          (overhead) ethp         (overhead) prcl         (overhead)
> parsec3/blackscholes    1785916.600  1834201.400  (2.70)     1826249.200  (2.26)     1828079.200  (2.36)     1712210.600  (-4.13)   
> parsec3/bodytrack       1415049.400  1434317.600  (1.36)     1423715.000  (0.61)     1430392.600  (1.08)     1435136.000  (1.42)    
> parsec3/canneal         1043489.800  1058617.600  (1.45)     1040484.600  (-0.29)    1048664.800  (0.50)     1050280.000  (0.65)    
> parsec3/dedup           2414453.200  2458493.200  (1.82)     2411379.400  (-0.13)    2400516.000  (-0.58)    2461120.800  (1.93)    
> parsec3/facesim         541597.200   550097.400   (1.57)     544364.600   (0.51)     553240.000   (2.15)     552316.400   (1.98)    
> parsec3/ferret          317986.600   332346.000   (4.52)     320218.000   (0.70)     331085.000   (4.12)     330895.200   (4.06)    
> parsec3/fluidanimate    576183.400   585442.000   (1.61)     577780.200   (0.28)     587703.400   (2.00)     506501.000   (-12.09)  
> parsec3/freqmine        990869.200   997817.000   (0.70)     990350.400   (-0.05)    997669.000   (0.69)     763325.800   (-22.96)  
> parsec3/raytrace        1748370.800  1757109.200  (0.50)     1746153.800  (-0.13)    1757830.400  (0.54)     1581455.800  (-9.55)   
> parsec3/streamcluster   121521.800   140452.400   (15.58)    129725.400   (6.75)     132266.000   (8.84)     130558.200   (7.44)    
> parsec3/swaptions       15592.400    29018.800    (86.11)    14765.800    (-5.30)    27260.200    (74.83)    26631.600    (70.80)   
> parsec3/vips            2957567.600  2967993.800  (0.35)     2956623.200  (-0.03)    2973062.600  (0.52)     2951402.000  (-0.21)   
> parsec3/x264            3169012.400  3175048.800  (0.19)     3190345.400  (0.67)     3189353.000  (0.64)     3172924.200  (0.12)    
> splash2x/barnes         1209066.000  1213125.400  (0.34)     1217261.400  (0.68)     1209661.600  (0.05)     921041.800   (-23.82)  
> splash2x/fft            9359313.200  9195213.000  (-1.75)    9377562.400  (0.19)     9050957.600  (-3.29)    9517977.000  (1.70)    
> splash2x/lu_cb          514966.200   522939.400   (1.55)     520870.400   (1.15)     522635.000   (1.49)     329933.600   (-35.93)  
> splash2x/lu_ncb         514180.400   525974.800   (2.29)     521420.200   (1.41)     521063.600   (1.34)     523557.000   (1.82)    
> splash2x/ocean_cp       3346493.400  3288078.000  (-1.75)    3382253.800  (1.07)     3289477.600  (-1.70)    3260810.400  (-2.56)   
> splash2x/ocean_ncp      3909966.400  3882968.800  (-0.69)    7037196.000  (79.98)    4046363.400  (3.49)     3471452.400  (-11.22)  
> splash2x/radiosity      1471119.400  1470626.800  (-0.03)    1482604.200  (0.78)     1472718.400  (0.11)     546893.600   (-62.82)  
> splash2x/radix          1748360.800  1729163.400  (-1.10)    1371463.200  (-21.56)   1701993.600  (-2.65)    1817519.600  (3.96)    
> splash2x/raytrace       46670.000    60172.200    (28.93)    51901.600    (11.21)    60782.600    (30.24)    52644.800    (12.80)   
> splash2x/volrend        150666.600   167444.200   (11.14)    151335.200   (0.44)     163345.000   (8.41)     162760.000   (8.03)    
> splash2x/water_nsquared 45720.200    59422.400    (29.97)    46031.000    (0.68)     61801.400    (35.17)    62627.000    (36.98)   
> splash2x/water_spatial  663052.200   672855.800   (1.48)     665787.600   (0.41)     674696.200   (1.76)     471052.600   (-28.96)  
> total                   40077300.000 40108900.000 (0.08)     42997900.000 (7.29)     40032700.000 (-0.11)    37813000.000 (-5.65)   
> 
> 
> DAMON Overheads
> ~~~~~~~~~~~~~~~
> 
> In total, DAMON recording feature incurs 0.25% runtime overhead (up to 1.66% in
> worst case with 'splash2x/barnes') and 0.08% memory space overhead.
> 
> For convenience test run of 'rec', I use a Python wrapper.  The wrapper
> constantly consumes about 10-15MB of memory.  This becomes high memory overhead
> if the target workload has small memory footprint.  In detail, 16%, 86%, 29%,
> 11%, and 30% overheads shown for parsec3/streamcluster (125 MiB),
> parsec3/swaptions (15 MiB), splash2x/raytrace (45 MiB), splash2x/volrend (151
> MiB), and splash2x/water_nsquared (46 MiB)).  Nonetheless, the overheads are
> not from DAMON, but from the wrapper, and thus should be ignored.  This fake
> memory overhead continues in 'ethp' and 'prcl', as those configurations are
> also using the Python wrapper.
> 
> 
> Efficient THP
> ~~~~~~~~~~~~~
> 
> THP 'always' enabled policy achieves 5.57% speedup but incurs 7.29% memory
> overhead.  It achieves 41.62% speedup in best case, but 79.98% memory overhead
> in worst case.  Interestingly, both the best and worst case are with
> 'splash2x/ocean_ncp').

The results above don't seems to support this any more? 

> runtime                 orig     rec      (overhead) thp      (overhead) ethp     (overhead) prcl     (overhead)
> splash2x/ocean_ncp      86.927   87.065   (0.16)     50.747   (-41.62)   86.855   (-0.08)    199.553  (129.57) 




> 
> The 2-lines implementation of data access monitoring based THP version ('ethp')
> shows 2.21% speedup and -0.11% memory overhead.  In other words, 'ethp' removes
> 100% of THP memory waste while preserving 39.67% of THP speedup in total.
> 
> 
> Proactive Reclamation
> ~~~~~~~~~~~~~~~~~~~~
> 
> As same to the original work, I use 'zram' swap device for this configuration.
> 
> In total, our 1 line implementation of Proactive Reclamation, 'prcl', incurred
> 8.47% runtime overhead in total while achieving 5.65% system memory usage
> reduction.
> 
> Nonetheless, as the memory usage is calculated with 'MemFree' in
> '/proc/meminfo', it contains the SwapCached pages.  As the swapcached pages can
> be easily evicted, I also measured the residential set size of the workloads:
> 
> rss.avg                 orig         rec          (overhead) thp          (overhead) ethp         (overhead) prcl         (overhead)
> parsec3/blackscholes    592502.000   589764.400   (-0.46)    592132.600   (-0.06)    593702.000   (0.20)     406639.400   (-31.37)  
> parsec3/bodytrack       32365.400    32195.000    (-0.53)    32210.800    (-0.48)    32114.600    (-0.77)    21537.600    (-33.45)  
> parsec3/canneal         839904.200   840292.200   (0.05)     836866.400   (-0.36)    838263.200   (-0.20)    837895.800   (-0.24)   
> parsec3/dedup           1208337.200  1218465.600  (0.84)     1233278.600  (2.06)     1200490.200  (-0.65)    882911.400   (-26.93)  
> parsec3/facesim         311380.800   311363.600   (-0.01)    315642.600   (1.37)     312573.400   (0.38)     310257.400   (-0.36)   
> parsec3/ferret          99514.800    99542.000    (0.03)     100454.200   (0.94)     99879.800    (0.37)     89679.200    (-9.88)   
> parsec3/fluidanimate    531760.800   531735.200   (-0.00)    531865.400   (0.02)     531940.800   (0.03)     440781.000   (-17.11)  
> parsec3/freqmine        552455.400   552882.600   (0.08)     555793.600   (0.60)     553019.800   (0.10)     58067.000    (-89.49)  
> parsec3/raytrace        894798.400   894953.400   (0.02)     892223.400   (-0.29)    893012.400   (-0.20)    315259.800   (-64.77)  
> parsec3/streamcluster   110780.400   110856.800   (0.07)     110954.000   (0.16)     111310.800   (0.48)     108066.800   (-2.45)   
> parsec3/swaptions       5614.600     5645.600     (0.55)     5553.200     (-1.09)    5552.600     (-1.10)    3251.800     (-42.08)  
> parsec3/vips            31942.200    31752.800    (-0.59)    32042.600    (0.31)     32226.600    (0.89)     29012.200    (-9.17)   
> parsec3/x264            81770.800    81609.200    (-0.20)    82800.800    (1.26)     82612.200    (1.03)     81805.800    (0.04)    
> splash2x/barnes         1216515.600  1217113.800  (0.05)     1225605.600  (0.75)     1217325.000  (0.07)     540108.400   (-55.60)  
> splash2x/fft            9668660.600  9751350.800  (0.86)     9773806.400  (1.09)     9613555.400  (-0.57)    7951241.800  (-17.76)  
> splash2x/lu_cb          510368.800   510095.800   (-0.05)    514350.600   (0.78)     510276.000   (-0.02)    311584.800   (-38.95)  
> splash2x/lu_ncb         509904.800   510001.600   (0.02)     513847.000   (0.77)     510073.400   (0.03)     509905.600   (0.00)    
> splash2x/ocean_cp       3389550.600  3404466.000  (0.44)     3443363.600  (1.59)     3410388.000  (0.61)     3330608.600  (-1.74)   
> splash2x/ocean_ncp      3923723.200  3911148.200  (-0.32)    7175800.400  (82.88)    4104482.400  (4.61)     2030525.000  (-48.25)  
> splash2x/radiosity      1472994.600  1475946.400  (0.20)     1485636.800  (0.86)     1476193.000  (0.22)     262161.400   (-82.20)  
> splash2x/radix          1750329.800  1765697.000  (0.88)     1413304.000  (-19.25)   1754154.400  (0.22)     1516142.600  (-13.38)  
> splash2x/raytrace       23149.600    23208.000    (0.25)     28574.400    (23.43)    26694.600    (15.31)    16257.800    (-29.77)  
> splash2x/volrend        43968.800    43919.000    (-0.11)    44087.600    (0.27)     44224.000    (0.58)     32484.400    (-26.12)  
> splash2x/water_nsquared 29348.000    29338.400    (-0.03)    29604.600    (0.87)     29779.400    (1.47)     23644.800    (-19.43)  
> splash2x/water_spatial  655263.600   655097.800   (-0.03)    655199.200   (-0.01)    656282.400   (0.16)     379816.800   (-42.04)  
> total                   28486900.000 28598400.000 (0.39)     31625000.000 (11.02)    28640100.000 (0.54)     20489600.000 (-28.07)  
> 
> In total, 28.07% of residential sets were reduced.
> 
> With parsec3/freqmine, 'prcl' reduced 22.96% of system memory usage and 89.49%
> of residential sets while incurring only 2.45% runtime overhead.
> 
> 
> Sequence Of Patches
> ===================
> 
> The patches are based on the v5.6 plus v7 DAMON patchset[1] and Minchan's
> ``do_madvise()`` patch[2].  Minchan's patch was necessary for reuse of
> ``madvise()`` code in DAMON.  You can also clone the complete git tree:
> 
>     $ git clone git://github.com/sjp38/linux -b damos/rfc/v5
> 
> The web is also available:
> https://github.com/sjp38/linux/releases/tag/damos/rfc/v5
> 
> 
> [1] https://lore.kernel.org/linux-mm/20200318112722.30143-1-sjpark@amazon.com/
> [2] https://lore.kernel.org/linux-mm/20200302193630.68771-2-minchan@kernel.org/
> 
> The first patch allows DAMON to reuse ``madvise()`` code for the actions.  The
> second patch accounts age of each region.  The third patch implements the
> handling of the schemes in DAMON and exports a kernel space programming
> interface for it.  The fourth patch implements a debugfs interface for
> privileged people and programs.  The fifth and sixth patches each adds
> kunittests and selftests for these changes, and finally the seventhe patch
> modifies the user space tool for DAMON to support description and applying of
> schemes in human freiendly way.
> 
> 
> Patch History
> =============
> 
> Changes from RFC v4
> (https://lore.kernel.org/linux-mm/20200303121406.20954-1-sjpark@amazon.com/)
>  - Handle CONFIG_ADVISE_SYSCALL
>  - Clean up code (Jonathan Cameron)
>  - Update test results
>  - Rebase on v5.6 + DAMON v7
> 
> Changes from RFC v3
> (https://lore.kernel.org/linux-mm/20200225102300.23895-1-sjpark@amazon.com/)
>  - Add Reviewed-by from Brendan Higgins
>  - Code cleanup: Modularize madvise() call
>  - Fix a trivial bug in the wrapper python script
>  - Add more stable and detailed evaluation results with updated ETHP scheme
> 
> Changes from RFC v2
> (https://lore.kernel.org/linux-mm/20200218085309.18346-1-sjpark@amazon.com/)
>  - Fix aging mechanism for more better 'old region' selection
>  - Add more kunittests and kselftests for this patchset
>  - Support more human friedly description and application of 'schemes'
> 
> Changes from RFC v1
> (https://lore.kernel.org/linux-mm/20200210150921.32482-1-sjpark@amazon.com/)
>  - Properly adjust age accounting related properties after splitting, merging,
>    and action applying
> SeongJae Park (7):
>   mm/madvise: Export do_madvise() to external GPL modules
>   mm/damon: Account age of target regions
>   mm/damon: Implement data access monitoring-based operation schemes
>   mm/damon/schemes: Implement a debugfs interface
>   mm/damon-test: Add kunit test case for regions age accounting
>   mm/damon/selftests: Add 'schemes' debugfs tests
>   damon/tools: Support more human friendly 'schemes' control
> 
>  include/linux/damon.h                         |  29 ++
>  mm/damon-test.h                               |   5 +
>  mm/damon.c                                    | 428 +++++++++++++++++-
>  mm/madvise.c                                  |   1 +
>  tools/damon/_convert_damos.py                 | 125 +++++
>  tools/damon/_damon.py                         | 143 ++++++
>  tools/damon/damo                              |   7 +
>  tools/damon/record.py                         | 135 +-----
>  tools/damon/schemes.py                        | 105 +++++
>  .../testing/selftests/damon/debugfs_attrs.sh  |  29 ++
>  10 files changed, 878 insertions(+), 129 deletions(-)
>  create mode 100755 tools/damon/_convert_damos.py
>  create mode 100644 tools/damon/_damon.py
>  create mode 100644 tools/damon/schemes.py
> 


