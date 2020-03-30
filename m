Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4DCC2D0E9
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91FA2073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rmJvzWn2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgC3Kyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 06:54:38 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:41410 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgC3Kyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 06:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585565677; x=1617101677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=angxrAvN4hY5mEDtSdK83VVTNfHHsluhCQx7nUIWsI0=;
  b=rmJvzWn2/EIV4PSZmRm5oG+lNBK1A59T9UezY1eprPsfF7aKaXZ/q/YT
   Tn7MhJFqbHyQTvBR/JHBjBQdPqYJIqJgbwBzP+nce2laxS+TYUvZFT3d0
   XZX0FHOtJlpQJ+X3xhHLG1yr2ZsB+GQ4KMnl7QJKnZ4DTHE7BMnKW0zoo
   4=;
IronPort-SDR: agNHx4eRoFU2jZGAbQ1pSxLVyo6NQ4oq+8hn7wK919XcTkMbIyMZrAsSBuxh7b+WThd0lYx7i/
 8H+dt/R8GByw==
X-IronPort-AV: E=Sophos;i="5.72,324,1580774400"; 
   d="scan'208";a="23454830"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 30 Mar 2020 10:54:22 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS id A6E6BA24C1;
        Mon, 30 Mar 2020 10:54:19 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 30 Mar 2020 10:54:19 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.9) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 30 Mar 2020 10:54:04 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <akpm@linux-foundation.org>, SeongJae Park <sjpark@amazon.de>,
        <Jonathan.Cameron@Huawei.com>, <aarcange@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shakeelb@google.com>
Subject: Re: [PATCH v7 00/15] Introduce Data Access MONitor (DAMON)
Date:   Mon, 30 Mar 2020 12:53:48 +0200
Message-ID: <20200330105348.2258-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318112722.30143-1-sjpark@amazon.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.9]
X-ClientProxiedBy: EX13D06UWA001.ant.amazon.com (10.43.160.220) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Mar 2020 12:27:07 +0100 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> Introduction
> ============
> 
> Memory management decisions can be improved if finer data access information is
> available.  However, because such finer information usually comes with higher
> overhead, most systems including Linux forgives the potential benefit and rely
> on only coarse information or some light-weight heuristics.  The pseudo-LRU and
> the aggressive THP promotions are such examples.
> 
> A number of data access pattern awared memory management optimizations (refer
> to 'Appendix A' for more details) consistently say the potential benefit is not
> small.  However, none of those has successfully merged to the mainline Linux
> kernel mainly due to the absence of a scalable and efficient data access
> monitoring mechanism.  Refer to 'Appendix B' to see the limitations of existing
> memory monitoring mechanisms.
> 
> DAMON is a data access monitoring subsystem for the problem.  It is 1) accurate
> enough to be used for the DRAM level memory management (a straightforward
> DAMON-based optimization achieved up to 2.55x speedup), 2) light-weight enough
> to be applied online (compared to a straightforward access monitoring scheme,
> DAMON is up to 94,242.42x lighter) and 3) keeps predefined upper-bound overhead
> regardless of the size of target workloads (thus scalable).  Refer to 'Appendix
> C' if you interested in how it is possible, and 'Appendix F' to know how the
> numbers collected.
> 
> DAMON has mainly designed for the kernel's memory management mechanisms.
> However, because it is implemented as a standalone kernel module and provides
> several interfaces, it can be used by a wide range of users including kernel
> space programs, user space programs, programmers, and administrators.  DAMON
> is now supporting the monitoring only, but it will also provide simple and
> convenient data access pattern awared memory managements by itself.  Refer to
> 'Appendix D' for more detailed expected usages of DAMON.

There was no review but a few of comments from Shakeel in last week, and
therefore I made no change in this patchset.  Instead, I'm preparing extending
DAMON for physical memory monitoring.

Also, I ran the whole evaluation tests including those for DAMON-based
operation schemes again, because this version (v7) patchset fixed an access
check related bug, thanks to Jonathan's finding, while the attached evaluation
results are measured with the previous version (v6).  Overall, it shows only
subtle changes.

In short, v7 DAMON increases system memory footprint by 0.08%, make the target
workloads 0.25% slower.  The numbers of v6 were -0.08% and 0.76%, respectively.

DAMON-based THP promotion/demotion scheme removes 100% memory overhead
of THP, and even shows 0.11% smaller system memory footprint, compared to THP
disabled case, while preserving 39.67% of THP speedup.  The numbers of v6 were
83.66% and 40.67%, respectively.

DAMON-based proactive reclamation scheme reduced 22.96% of system memory
fooprint and 89.49% of residential sets while incurring only 2.45% runtime
overhead in best case (parsec3/freqmine).  The numbers of v6 were 22.42%,
88.86% and 3.07%, respectively.

The detailed numbers are attached below.  For the detailed numbers of v6, refer
to the CV of v6 DAMON patchset:
https://lore.kernel.org/linux-mm/20200318112722.30143-1-sjpark@amazon.com/

I hope this numbers make more REVIEWS/COMMENTS than my patchsets ;)


Thanks,
SeongJae Park

================================ >8 ===========================================

runtime                 orig     rec      (overhead) thp      (overhead) ethp     (overhead) prcl     (overhead)
parsec3/blackscholes    107.594  107.956  (0.34)     106.750  (-0.78)    107.672  (0.07)     111.916  (4.02)
parsec3/bodytrack       79.230   79.368   (0.17)     78.908   (-0.41)    79.705   (0.60)     80.423   (1.50)
parsec3/canneal         142.831  143.810  (0.69)     123.530  (-13.51)   133.778  (-6.34)    144.998  (1.52)
parsec3/dedup           11.986   11.959   (-0.23)    11.762   (-1.87)    12.028   (0.35)     13.313   (11.07)
parsec3/facesim         210.125  209.007  (-0.53)    205.226  (-2.33)    207.766  (-1.12)    209.815  (-0.15)
parsec3/ferret          191.601  191.177  (-0.22)    190.420  (-0.62)    191.775  (0.09)     192.638  (0.54)
parsec3/fluidanimate    212.735  212.970  (0.11)     209.151  (-1.68)    211.904  (-0.39)    218.573  (2.74)
parsec3/freqmine        291.225  290.873  (-0.12)    289.258  (-0.68)    289.884  (-0.46)    298.373  (2.45)
parsec3/raytrace        118.289  119.586  (1.10)     119.045  (0.64)     119.064  (0.66)     137.919  (16.60)
parsec3/streamcluster   323.565  328.168  (1.42)     279.565  (-13.60)   287.452  (-11.16)   333.244  (2.99)
parsec3/swaptions       155.140  155.473  (0.21)     153.816  (-0.85)    156.423  (0.83)     156.237  (0.71)
parsec3/vips            58.979   59.311   (0.56)     58.733   (-0.42)    59.005   (0.04)     61.062   (3.53)
parsec3/x264            70.539   68.413   (-3.01)    64.760   (-8.19)    67.180   (-4.76)    68.103   (-3.45)
splash2x/barnes         80.414   81.751   (1.66)     73.585   (-8.49)    80.232   (-0.23)    115.753  (43.95)
splash2x/fft            33.902   34.111   (0.62)     24.228   (-28.53)   29.926   (-11.73)   44.438   (31.08)
splash2x/lu_cb          85.556   86.001   (0.52)     84.538   (-1.19)    86.000   (0.52)     91.447   (6.89)
splash2x/lu_ncb         93.399   93.652   (0.27)     90.463   (-3.14)    94.008   (0.65)     93.901   (0.54)
splash2x/ocean_cp       45.253   45.191   (-0.14)    43.049   (-4.87)    44.022   (-2.72)    46.588   (2.95)
splash2x/ocean_ncp      86.927   87.065   (0.16)     50.747   (-41.62)   86.855   (-0.08)    199.553  (129.57)
splash2x/radiosity      91.433   91.511   (0.09)     90.626   (-0.88)    91.865   (0.47)     104.524  (14.32)
splash2x/radix          31.923   32.023   (0.31)     25.194   (-21.08)   32.035   (0.35)     39.231   (22.89)
splash2x/raytrace       84.367   84.677   (0.37)     82.417   (-2.31)    83.505   (-1.02)    84.857   (0.58)
splash2x/volrend        87.499   87.495   (-0.00)    86.775   (-0.83)    87.311   (-0.21)    87.511   (0.01)
splash2x/water_nsquared 236.397  236.759  (0.15)     219.902  (-6.98)    224.228  (-5.15)    238.562  (0.92)
splash2x/water_spatial  89.646   89.767   (0.14)     89.735   (0.10)     90.347   (0.78)     103.585  (15.55)
total                   3020.570 3028.080 (0.25)     2852.190 (-5.57)    2953.960 (-2.21)    3276.550 (8.47)


memused.avg             orig         rec          (overhead) thp          (overhead) ethp         (overhead) prcl         (overhead)
parsec3/blackscholes    1785916.600  1834201.400  (2.70)     1826249.200  (2.26)     1828079.200  (2.36)     1712210.600  (-4.13)
parsec3/bodytrack       1415049.400  1434317.600  (1.36)     1423715.000  (0.61)     1430392.600  (1.08)     1435136.000  (1.42)
parsec3/canneal         1043489.800  1058617.600  (1.45)     1040484.600  (-0.29)    1048664.800  (0.50)     1050280.000  (0.65)
parsec3/dedup           2414453.200  2458493.200  (1.82)     2411379.400  (-0.13)    2400516.000  (-0.58)    2461120.800  (1.93)
parsec3/facesim         541597.200   550097.400   (1.57)     544364.600   (0.51)     553240.000   (2.15)     552316.400   (1.98)
parsec3/ferret          317986.600   332346.000   (4.52)     320218.000   (0.70)     331085.000   (4.12)     330895.200   (4.06)
parsec3/fluidanimate    576183.400   585442.000   (1.61)     577780.200   (0.28)     587703.400   (2.00)     506501.000   (-12.09)
parsec3/freqmine        990869.200   997817.000   (0.70)     990350.400   (-0.05)    997669.000   (0.69)     763325.800   (-22.96)
parsec3/raytrace        1748370.800  1757109.200  (0.50)     1746153.800  (-0.13)    1757830.400  (0.54)     1581455.800  (-9.55)
parsec3/streamcluster   121521.800   140452.400   (15.58)    129725.400   (6.75)     132266.000   (8.84)     130558.200   (7.44)
parsec3/swaptions       15592.400    29018.800    (86.11)    14765.800    (-5.30)    27260.200    (74.83)    26631.600    (70.80)
parsec3/vips            2957567.600  2967993.800  (0.35)     2956623.200  (-0.03)    2973062.600  (0.52)     2951402.000  (-0.21)
parsec3/x264            3169012.400  3175048.800  (0.19)     3190345.400  (0.67)     3189353.000  (0.64)     3172924.200  (0.12)
splash2x/barnes         1209066.000  1213125.400  (0.34)     1217261.400  (0.68)     1209661.600  (0.05)     921041.800   (-23.82)
splash2x/fft            9359313.200  9195213.000  (-1.75)    9377562.400  (0.19)     9050957.600  (-3.29)    9517977.000  (1.70)
splash2x/lu_cb          514966.200   522939.400   (1.55)     520870.400   (1.15)     522635.000   (1.49)     329933.600   (-35.93)
splash2x/lu_ncb         514180.400   525974.800   (2.29)     521420.200   (1.41)     521063.600   (1.34)     523557.000   (1.82)
splash2x/ocean_cp       3346493.400  3288078.000  (-1.75)    3382253.800  (1.07)     3289477.600  (-1.70)    3260810.400  (-2.56)
splash2x/ocean_ncp      3909966.400  3882968.800  (-0.69)    7037196.000  (79.98)    4046363.400  (3.49)     3471452.400  (-11.22)
splash2x/radiosity      1471119.400  1470626.800  (-0.03)    1482604.200  (0.78)     1472718.400  (0.11)     546893.600   (-62.82)
splash2x/radix          1748360.800  1729163.400  (-1.10)    1371463.200  (-21.56)   1701993.600  (-2.65)    1817519.600  (3.96)
splash2x/raytrace       46670.000    60172.200    (28.93)    51901.600    (11.21)    60782.600    (30.24)    52644.800    (12.80)
splash2x/volrend        150666.600   167444.200   (11.14)    151335.200   (0.44)     163345.000   (8.41)     162760.000   (8.03)
splash2x/water_nsquared 45720.200    59422.400    (29.97)    46031.000    (0.68)     61801.400    (35.17)    62627.000    (36.98)
splash2x/water_spatial  663052.200   672855.800   (1.48)     665787.600   (0.41)     674696.200   (1.76)     471052.600   (-28.96)
total                   40077300.000 40108900.000 (0.08)     42997900.000 (7.29)     40032700.000 (-0.11)    37813000.000 (-5.65)


rss.avg                 orig         rec          (overhead) thp          (overhead) ethp         (overhead) prcl         (overhead)
parsec3/blackscholes    592502.000   589764.400   (-0.46)    592132.600   (-0.06)    593702.000   (0.20)     406639.400   (-31.37)
parsec3/bodytrack       32365.400    32195.000    (-0.53)    32210.800    (-0.48)    32114.600    (-0.77)    21537.600    (-33.45)
parsec3/canneal         839904.200   840292.200   (0.05)     836866.400   (-0.36)    838263.200   (-0.20)    837895.800   (-0.24)
parsec3/dedup           1208337.200  1218465.600  (0.84)     1233278.600  (2.06)     1200490.200  (-0.65)    882911.400   (-26.93)
parsec3/facesim         311380.800   311363.600   (-0.01)    315642.600   (1.37)     312573.400   (0.38)     310257.400   (-0.36)
parsec3/ferret          99514.800    99542.000    (0.03)     100454.200   (0.94)     99879.800    (0.37)     89679.200    (-9.88)
parsec3/fluidanimate    531760.800   531735.200   (-0.00)    531865.400   (0.02)     531940.800   (0.03)     440781.000   (-17.11)
parsec3/freqmine        552455.400   552882.600   (0.08)     555793.600   (0.60)     553019.800   (0.10)     58067.000    (-89.49)
parsec3/raytrace        894798.400   894953.400   (0.02)     892223.400   (-0.29)    893012.400   (-0.20)    315259.800   (-64.77)
parsec3/streamcluster   110780.400   110856.800   (0.07)     110954.000   (0.16)     111310.800   (0.48)     108066.800   (-2.45)
parsec3/swaptions       5614.600     5645.600     (0.55)     5553.200     (-1.09)    5552.600     (-1.10)    3251.800     (-42.08)
parsec3/vips            31942.200    31752.800    (-0.59)    32042.600    (0.31)     32226.600    (0.89)     29012.200    (-9.17)
parsec3/x264            81770.800    81609.200    (-0.20)    82800.800    (1.26)     82612.200    (1.03)     81805.800    (0.04)
splash2x/barnes         1216515.600  1217113.800  (0.05)     1225605.600  (0.75)     1217325.000  (0.07)     540108.400   (-55.60)
splash2x/fft            9668660.600  9751350.800  (0.86)     9773806.400  (1.09)     9613555.400  (-0.57)    7951241.800  (-17.76)
splash2x/lu_cb          510368.800   510095.800   (-0.05)    514350.600   (0.78)     510276.000   (-0.02)    311584.800   (-38.95)
splash2x/lu_ncb         509904.800   510001.600   (0.02)     513847.000   (0.77)     510073.400   (0.03)     509905.600   (0.00)
splash2x/ocean_cp       3389550.600  3404466.000  (0.44)     3443363.600  (1.59)     3410388.000  (0.61)     3330608.600  (-1.74)
splash2x/ocean_ncp      3923723.200  3911148.200  (-0.32)    7175800.400  (82.88)    4104482.400  (4.61)     2030525.000  (-48.25)
splash2x/radiosity      1472994.600  1475946.400  (0.20)     1485636.800  (0.86)     1476193.000  (0.22)     262161.400   (-82.20)
splash2x/radix          1750329.800  1765697.000  (0.88)     1413304.000  (-19.25)   1754154.400  (0.22)     1516142.600  (-13.38)
splash2x/raytrace       23149.600    23208.000    (0.25)     28574.400    (23.43)    26694.600    (15.31)    16257.800    (-29.77)
splash2x/volrend        43968.800    43919.000    (-0.11)    44087.600    (0.27)     44224.000    (0.58)     32484.400    (-26.12)
splash2x/water_nsquared 29348.000    29338.400    (-0.03)    29604.600    (0.87)     29779.400    (1.47)     23644.800    (-19.43)
splash2x/water_spatial  655263.600   655097.800   (-0.03)    655199.200   (-0.01)    656282.400   (0.16)     379816.800   (-42.04)
total                   28486900.000 28598400.000 (0.39)     31625000.000 (11.02)    28640100.000 (0.54)     20489600.000 (-28.07)
