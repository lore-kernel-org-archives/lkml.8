Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7DFC33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 17:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1630A2072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 17:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgAQR4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 12:56:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47726 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729263AbgAQR4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 12:56:44 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00HHrp0j064965
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 12:56:43 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xk0qt5tpw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 12:56:42 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 17 Jan 2020 17:56:41 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 17 Jan 2020 17:56:35 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00HHuYxP13304032
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 17:56:34 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0C82A4053;
        Fri, 17 Jan 2020 17:56:34 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6544EA4040;
        Fri, 17 Jan 2020 17:56:32 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 17 Jan 2020 17:56:32 +0000 (GMT)
Date:   Fri, 17 Jan 2020 23:26:31 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small load imbalance between low
 utilisation SD_NUMA domains v4
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20200114101319.GO3466@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200114101319.GO3466@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 20011717-0008-0000-0000-0000034A60FE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011717-0009-0000-0000-00004A6ABEB8
Message-Id: <20200117175631.GC20112@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001170139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mel Gorman <mgorman@techsingularity.net> [2020-01-14 10:13:20]:

> Changelog since V3
> o Allow a fixed imbalance a basic comparison with 2 tasks. This turned out to
>   be as good or better than allowing an imbalance based on the group weight
>   without worrying about potential spillover of the lower scheduler domains.
> 

We certainly are seeing better results than v1.
However numa02, numa03, numa05, numa09 and numa10 still seem to regressing, while
the others are improving.

While numa04 improves by 14%, numa02 regress by around 12%.

Setup:
Architecture:        ppc64le
Byte Order:          Little Endian
CPU(s):              256
On-line CPU(s) list: 0-255
Thread(s) per core:  8
Core(s) per socket:  1
Socket(s):           32
NUMA node(s):        8
Model:               2.1 (pvr 004b 0201)
Model name:          POWER8 (architected), altivec supported
Hypervisor vendor:   pHyp
Virtualization type: para
L1d cache:           64K
L1i cache:           32K
L2 cache:            512K
L3 cache:            8192K
NUMA node0 CPU(s):   0-31
NUMA node1 CPU(s):   32-63
NUMA node2 CPU(s):   64-95
NUMA node3 CPU(s):   96-127
NUMA node4 CPU(s):   128-159
NUMA node5 CPU(s):   160-191
NUMA node6 CPU(s):   192-223
NUMA node7 CPU(s):   224-255

numa01 is a set of 2 process each running 128 threads;
each thread doing 50 loops on 3GB process shared memory operations.

numa02 is a single process with 256 threads;
each thread doing 800 loops on 32MB thread local memory operations.

numa03 is a single process with 256 threads;
each thread doing 50 loops on 3GB process shared memory operations.

numa04 is a set of 8 process (as many nodes) each running 32 threads;
each thread doing 50 loops on 3GB process shared memory operations.

numa05 is a set of 16 process (twice as many nodes) each running 16 threads;
each thread doing 50 loops on 3GB process shared memory operations.

Details below:
Testcase         Time:  Min        Max        Avg        StdDev
./numa01.sh      Real:  513.12     547.37     530.25     17.12
./numa01.sh      Sys:   107.73     146.26     127.00     19.26
./numa01.sh      User:  122812.39  129136.61  125974.50  3162.11
./numa02.sh      Real:  68.23      72.44      70.34      2.10
./numa02.sh      Sys:   52.35      55.65      54.00      1.65
./numa02.sh      User:  14334.37   14907.14   14620.76   286.38
./numa03.sh      Real:  471.36     485.19     478.27     6.92
./numa03.sh      Sys:   74.91      77.03      75.97      1.06
./numa03.sh      User:  118197.30  121238.68  119717.99  1520.69
./numa04.sh      Real:  450.35     454.93     452.64     2.29
./numa04.sh      Sys:   362.49     397.95     380.22     17.73
./numa04.sh      User:  93150.82   93300.60   93225.71   74.89
./numa05.sh      Real:  361.18     366.32     363.75     2.57
./numa05.sh      Sys:   678.72     726.32     702.52     23.80
./numa05.sh      User:  82634.58   85103.97   83869.27   1234.70
Testcase         Time:  Min        Max        Avg        StdDev   %Change
./numa01.sh      Real:  485.45     530.20     507.83     22.37    4.41486%
./numa01.sh      Sys:   123.45     130.62     127.03     3.59     -0.0236165%
./numa01.sh      User:  119152.08  127121.14  123136.61  3984.53  2.30467%
./numa02.sh      Real:  78.87      82.31      80.59      1.72     -12.7187%
./numa02.sh      Sys:   81.18      85.07      83.12      1.94     -35.0337%
./numa02.sh      User:  16303.70   17122.14   16712.92   409.22   -12.5182%
./numa03.sh      Real:  477.20     528.12     502.66     25.46    -4.85219%
./numa03.sh      Sys:   88.93      115.36     102.15     13.21    -25.629%
./numa03.sh      User:  119120.73  129829.89  124475.31  5354.58  -3.8219%
./numa04.sh      Real:  374.70     414.76     394.73     20.03    14.6708%
./numa04.sh      Sys:   357.14     379.20     368.17     11.03    3.27294%
./numa04.sh      User:  87830.73   88547.21   88188.97   358.24   5.7113%
./numa05.sh      Real:  369.50     401.56     385.53     16.03    -5.64937%
./numa05.sh      Sys:   718.99     741.02     730.00     11.01    -3.76438%
./numa05.sh      User:  84989.07   85271.75   85130.41   141.34   -1.48142%

vmstat for numa01
param                   last_patch  with_patch  %Change
-----                   ----------  ----------  -------
numa_foreign            0           0           NA
numa_hint_faults        2170524     2021927     -6.84613%
numa_hint_faults_local  376099      337768      -10.1917%
numa_hit                1177785     1149206     -2.4265%
numa_huge_pte_updates   0           0           NA
numa_interleave         0           0           NA
numa_local              1176900     1149095     -2.36256%
numa_miss               0           0           NA
numa_other              885         111         -87.4576%
numa_pages_migrated     304670      292963      -3.84252%
numa_pte_updates        2171627     2022996     -6.84422%
pgfault                 4469999     4266785     -4.54618%
pgmajfault              280         247         -11.7857%
pgmigrate_fail          1           0           -100%
pgmigrate_success       304670      292963      -3.84252%

vmstat for numa02
param                   last_patch  with_patch  %Change
-----                   ----------  ----------  -------
numa_foreign            0           0           NA
numa_hint_faults        496508      508975      2.51094%
numa_hint_faults_local  295974      282634      -4.50715%
numa_hit                585706      642712      9.73287%
numa_huge_pte_updates   0           0           NA
numa_interleave         0           0           NA
numa_local              585700      642677      9.72802%
numa_miss               0           0           NA
numa_other              6           35          483.333%
numa_pages_migrated     199884      224448      12.2891%
numa_pte_updates        513146      525354      2.37905%
pgfault                 1111950     1238982     11.4243%
pgmajfault              121         141         16.5289%
pgmigrate_fail          0           0           NA
pgmigrate_success       199884      224448      12.2891%

vmstat for numa03
param                   last_patch  with_patch  %Change
-----                   ----------  ----------  -------
numa_foreign            0           0           NA
numa_hint_faults        863404      951850      10.2439%
numa_hint_faults_local  108422      120466      11.1084%
numa_hit                612432      592068      -3.3251%
numa_huge_pte_updates   0           0           NA
numa_interleave         0           0           NA
numa_local              612384      592059      -3.319%
numa_miss               0           0           NA
numa_other              48          9           -81.25%
numa_pages_migrated     118517      121945      2.89241%
numa_pte_updates        865936      952055      9.94519%
pgfault                 2291712     2325598     1.47863%
pgmajfault              155         113         -27.0968%
pgmigrate_fail          0           2           NA
pgmigrate_success       118517      121945      2.89241%

vmstat for numa04
param                   last_patch  with_patch  %Change
-----                   ----------  ----------  -------
numa_foreign            0           0           NA
numa_hint_faults        8122814     7678754     -5.46682%
numa_hint_faults_local  3965028     4202779     5.9962%
numa_hit                2453692     2412929     -1.66129%
numa_huge_pte_updates   0           0           NA
numa_interleave         0           0           NA
numa_local              2453668     2412815     -1.66498%
numa_miss               0           0           NA
numa_other              24          114         375%
numa_pages_migrated     1302687     1249958     -4.04771%
numa_pte_updates        8139895     7683560     -5.60615%
pgfault                 10420191    10002382    -4.00961%
pgmajfault              145         166         14.4828%
pgmigrate_fail          0           1           NA
pgmigrate_success       1302687     1249958     -4.04771%

vmstat for numa05
param                   last_patch  with_patch  %Change
-----                   ----------  ----------  -------
numa_foreign            0           252995      NA
numa_hint_faults        16968844    16706026    -1.54883%
numa_hint_faults_local  10525364    10167507    -3.39995%
numa_hit                4354639     3947252     -9.35524%
numa_huge_pte_updates   0           0           NA
numa_interleave         0           0           NA
numa_local              4354568     3947234     -9.35418%
numa_miss               0           252995      NA
numa_other              71          253013      356256%
numa_pages_migrated     2398713     2288409     -4.59847%
numa_pte_updates        16997456    16760448    -1.39437%
pgfault                 20471213    19945264    -2.56921%
pgmajfault              166         261         57.2289%
pgmigrate_fail          4           2           -50%
pgmigrate_success       2398713     2288409     -4.59847%


numa06 is a set of 2 process each running 32 threads;
each thread doing 50 loops on 3GB process shared memory operations.

numa07 is a single process with 32 threads;
each thread doing 800 loops on 32MB thread local memory operations.

numa08 is a single process with 32 threads;
each thread doing 50 loops on 3GB process shared memory operations.

numa09 is a set of 8 process (as many nodes) each running 4 threads;
each thread doing 50 loops on 3GB process shared memory operations.

numa10 is a set of 16 process (twice as many nodes) each running 2 threads;
each thread doing 50 loops on 3GB process shared memory operations.


Testcase         Time:  Min      Max      Avg      StdDev
./numa06.sh      Real:  81.30    85.29    83.30    2.00
./numa06.sh      Sys:   6.15     8.64     7.40     1.24
./numa06.sh      User:  2493.87  2499.31  2496.59  2.72
./numa07.sh      Real:  17.01    18.47    17.74    0.73
./numa07.sh      Sys:   2.08     2.33     2.21     0.13
./numa07.sh      User:  396.38   427.87   412.12   15.74
./numa08.sh      Real:  77.89    79.05    78.47    0.58
./numa08.sh      Sys:   3.76     4.66     4.21     0.45
./numa08.sh      User:  2396.50  2443.64  2420.07  23.57
./numa09.sh      Real:  60.64    65.37    63.01    2.37
./numa09.sh      Sys:   31.28    33.10    32.19    0.91
./numa09.sh      User:  1666.04  1685.55  1675.80  9.75
./numa10.sh      Real:  56.48    56.64    56.56    0.08
./numa10.sh      Sys:   56.59    63.25    59.92    3.33
./numa10.sh      User:  1487.83  1492.53  1490.18  2.35
Testcase         Time:  Min      Max      Avg      StdDev  %Change
./numa06.sh      Real:  74.43    79.30    76.87    2.43    8.36477%
./numa06.sh      Sys:   8.64     9.16     8.90     0.26    -16.8539%
./numa06.sh      User:  2278.98  2376.25  2327.61  48.64   7.25981%
./numa07.sh      Real:  14.32    14.59    14.46    0.14    22.6833%
./numa07.sh      Sys:   2.02     2.09     2.05     0.04    7.80488%
./numa07.sh      User:  338.27   349.57   343.92   5.65    19.8302%
./numa08.sh      Real:  75.19    81.25    78.22    3.03    0.319611%
./numa08.sh      Sys:   3.92     3.98     3.95     0.03    6.58228%
./numa08.sh      User:  2320.61  2509.58  2415.10  94.48   0.205789%
./numa09.sh      Real:  64.44    64.65    64.55    0.10    -2.38575%
./numa09.sh      Sys:   32.11    39.12    35.61    3.51    -9.60404%
./numa09.sh      User:  1700.54  1771.65  1736.10  35.56   -3.4733%
./numa10.sh      Real:  56.78    57.61    57.20    0.42    -1.11888%
./numa10.sh      Sys:   67.30    67.82    67.56    0.26    -11.3085%
./numa10.sh      User:  1502.38  1502.95  1502.66  0.29    -0.830527%

vmstat for numa06
param                   last_patch  with_patch  %Change
-----                   ----------  ----------  -------
numa_foreign            0           0           NA
numa_hint_faults        1401846     1317738     -5.9998%
numa_hint_faults_local  291501      254441      -12.7135%
numa_hit                490509      495083      0.932501%
numa_huge_pte_updates   0           0           NA
numa_interleave         0           0           NA
numa_local              490506      495068      0.93006%
numa_miss               0           0           NA
numa_other              3           15          400%
numa_pages_migrated     224869      237124      5.44984%
numa_pte_updates        1401947     1317899     -5.99509%
pgfault                 1817481     1775118     -2.33086%
pgmajfault              175         178         1.71429%
pgmigrate_fail          0           0           NA
pgmigrate_success       224869      237124      5.44984%

vmstat for numa07
param                   last_patch  with_patch  %Change
-----                   ----------  ----------  -------
numa_foreign            0           0           NA
numa_hint_faults        90935       87129       -4.18541%
numa_hint_faults_local  52864       49110       -7.10124%
numa_hit                94632       91902       -2.88486%
numa_huge_pte_updates   0           0           NA
numa_interleave         0           0           NA
numa_local              94632       91902       -2.88486%
numa_miss               0           0           NA
numa_other              0           0           NA
numa_pages_migrated     37232       37744       1.37516%
numa_pte_updates        92987       89177       -4.09735%
pgfault                 171811      177212      3.14357%
pgmajfault              65          72          10.7692%
pgmigrate_fail          0           0           NA
pgmigrate_success       37232       37744       1.37516%

vmstat for numa08
param                   last_patch  with_patch  %Change
-----                   ----------  ----------  -------
numa_foreign            0           0           NA
numa_hint_faults        656205      578320      -11.869%
numa_hint_faults_local  77425       85553       10.4979%
numa_hit                262903      246913      -6.08209%
numa_huge_pte_updates   0           0           NA
numa_interleave         0           0           NA
numa_local              262902      246902      -6.08592%
numa_miss               0           0           NA
numa_other              1           11          1000%
numa_pages_migrated     115615      94939       -17.8835%
numa_pte_updates        656300      578399      -11.8697%
pgfault                 1000775     879013      -12.1668%
pgmajfault              80          173         116.25%
pgmigrate_fail          0           0           NA
pgmigrate_success       115615      94939       -17.8835%

vmstat for numa09
param                   last_patch  with_patch  %Change
-----                   ----------  ----------  -------
numa_foreign            0           0           NA
numa_hint_faults        5292059     5086197     -3.89002%
numa_hint_faults_local  2771125     2463519     -11.1004%
numa_hit                1993632     2043106     2.4816%
numa_huge_pte_updates   0           0           NA
numa_interleave         0           0           NA
numa_local              1993631     2043076     2.48015%
numa_miss               0           0           NA
numa_other              1           30          2900%
numa_pages_migrated     1154157     1223564     6.01365%
numa_pte_updates        5313698     5098234     -4.05488%
pgfault                 6531964     6196370     -5.13772%
pgmajfault              83          121         45.7831%
pgmigrate_fail          0           0           NA
pgmigrate_success       1154157     1223564     6.01365%

vmstat for numa10
param                   last_patch  with_patch  %Change
-----                   ----------  ----------  -------
numa_foreign            0           195343      NA
numa_hint_faults        9745914     10968959    12.5493%
numa_hint_faults_local  6331681     7146416     12.8676%
numa_hit                3533392     3466916     -1.88136%
numa_huge_pte_updates   0           0           NA
numa_interleave         0           0           NA
numa_local              3533392     3466908     -1.88159%
numa_miss               0           195343      NA
numa_other              0           195351      NA
numa_pages_migrated     1930180     2050279     6.22217%
numa_pte_updates        9798861     11018095    12.4426%
pgfault                 11544963    12744348    10.3888%
pgmajfault              83          154         85.5422%
pgmigrate_fail          0           0           NA
pgmigrate_success       1930180     2050279     6.22217%

-- 
Thanks and Regards
Srikar Dronamraju

