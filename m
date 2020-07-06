Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NORMAL_HTTP_TO_IP,
	NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC90C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89DC720720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fMjT3u/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgGFL6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 07:58:43 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:19146 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729062AbgGFL6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 07:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594036680; x=1625572680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ko0vpgy02JEFekxbxwTtiofkc4jbkaq/7gzJ34iGgAE=;
  b=fMjT3u/RsMc/ePKTtw9Wut3I8GZ0mC3gx6J6jjaOnW/dFISKUaLM3Q1e
   drBRbcXLWBniWpiILiqMm32dixEXbp/LabYn3Qdsf89fTumjaV6Yhr3lC
   eCDEZUx2/hJnS6hXT0DgOZbrv/9r24oT8+Eo6FC7bt6Ui8Ce6RLXfSFTo
   k=;
IronPort-SDR: 9Hk813sbLvigrNVVqsCBajQQydwaAaU1y3AKa8p/0BpMkjwkikXr/6Ququq25kKF08lLUX8rFv
 gQpIV80b9trw==
X-IronPort-AV: E=Sophos;i="5.75,318,1589241600"; 
   d="scan'208";a="40227611"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 06 Jul 2020 11:57:53 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id AA633A1E01;
        Mon,  6 Jul 2020 11:57:50 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Jul 2020 11:57:49 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.100) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Jul 2020 11:57:31 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <foersleo@amazon.de>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <sblbir@amazon.com>, <shakeelb@google.com>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <snu@amazon.de>, <vbabka@suse.cz>,
        <vdavydov.dev@gmail.com>, <yang.shi@linux.alibaba.com>,
        <ying.huang@intel.com>, <david@redhat.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v17 12/15] Documentation/admin-guide/mm: Add a document for DAMON
Date:   Mon, 6 Jul 2020 13:53:19 +0200
Message-ID: <20200706115322.29598-13-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706115322.29598-1-sjpark@amazon.com>
References: <20200706115322.29598-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D21UWA003.ant.amazon.com (10.43.160.184) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds a document for DAMON under
`Documentation/admin-guide/mm/damon/`.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/admin-guide/mm/damon/api.rst    |  20 ++
 .../admin-guide/mm/damon/damon_heatmap.png    | Bin 0 -> 8366 bytes
 .../admin-guide/mm/damon/damon_wss_change.png | Bin 0 -> 7211 bytes
 .../admin-guide/mm/damon/damon_wss_dist.png   | Bin 0 -> 6173 bytes
 Documentation/admin-guide/mm/damon/eval.rst   | 222 +++++++++++++
 Documentation/admin-guide/mm/damon/faq.rst    |  59 ++++
 .../admin-guide/mm/damon/freqmine_heatmap.png | Bin 0 -> 9999 bytes
 .../admin-guide/mm/damon/freqmine_wss_sz.png  | Bin 0 -> 5589 bytes
 .../mm/damon/freqmine_wss_time.png            | Bin 0 -> 6550 bytes
 Documentation/admin-guide/mm/damon/guide.rst  | 194 ++++++++++++
 Documentation/admin-guide/mm/damon/index.rst  |  35 +++
 .../admin-guide/mm/damon/mechanisms.rst       | 159 ++++++++++
 Documentation/admin-guide/mm/damon/plans.rst  |  29 ++
 Documentation/admin-guide/mm/damon/start.rst  | 117 +++++++
 .../mm/damon/streamcluster_heatmap.png        | Bin 0 -> 42210 bytes
 .../mm/damon/streamcluster_wss_sz.png         | Bin 0 -> 6327 bytes
 .../mm/damon/streamcluster_wss_time.png       | Bin 0 -> 8830 bytes
 Documentation/admin-guide/mm/damon/usage.rst  | 296 ++++++++++++++++++
 Documentation/admin-guide/mm/index.rst        |   1 +
 19 files changed, 1132 insertions(+)
 create mode 100644 Documentation/admin-guide/mm/damon/api.rst
 create mode 100644 Documentation/admin-guide/mm/damon/damon_heatmap.png
 create mode 100644 Documentation/admin-guide/mm/damon/damon_wss_change.png
 create mode 100644 Documentation/admin-guide/mm/damon/damon_wss_dist.png
 create mode 100644 Documentation/admin-guide/mm/damon/eval.rst
 create mode 100644 Documentation/admin-guide/mm/damon/faq.rst
 create mode 100644 Documentation/admin-guide/mm/damon/freqmine_heatmap.png
 create mode 100644 Documentation/admin-guide/mm/damon/freqmine_wss_sz.png
 create mode 100644 Documentation/admin-guide/mm/damon/freqmine_wss_time.png
 create mode 100644 Documentation/admin-guide/mm/damon/guide.rst
 create mode 100644 Documentation/admin-guide/mm/damon/index.rst
 create mode 100644 Documentation/admin-guide/mm/damon/mechanisms.rst
 create mode 100644 Documentation/admin-guide/mm/damon/plans.rst
 create mode 100644 Documentation/admin-guide/mm/damon/start.rst
 create mode 100644 Documentation/admin-guide/mm/damon/streamcluster_heatmap.png
 create mode 100644 Documentation/admin-guide/mm/damon/streamcluster_wss_sz.png
 create mode 100644 Documentation/admin-guide/mm/damon/streamcluster_wss_time.png
 create mode 100644 Documentation/admin-guide/mm/damon/usage.rst

diff --git a/Documentation/admin-guide/mm/damon/api.rst b/Documentation/admin-guide/mm/damon/api.rst
new file mode 100644
index 000000000000..649409828eab
--- /dev/null
+++ b/Documentation/admin-guide/mm/damon/api.rst
@@ -0,0 +1,20 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+API Reference
+=============
+
+Kernel space programs can use every feature of DAMON using below APIs.  All you
+need to do is including ``damon.h``, which is located in ``include/linux/`` of
+the source tree.
+
+Structures
+==========
+
+.. kernel-doc:: include/linux/damon.h
+
+
+Functions
+=========
+
+.. kernel-doc:: mm/damon.c
diff --git a/Documentation/admin-guide/mm/damon/damon_heatmap.png b/Documentation/admin-guide/mm/damon/damon_heatmap.png
new file mode 100644
index 0000000000000000000000000000000000000000..ff485f9f59ca2717f5221b2824eaaed616b22c0e
GIT binary patch
literal 8366
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
A^#A|>

literal 0
HcmV?d00001

diff --git a/Documentation/admin-guide/mm/damon/damon_wss_change.png b/Documentation/admin-guide/mm/damon/damon_wss_change.png
new file mode 100644
index 0000000000000000000000000000000000000000..36699547c342cd05c9f416c78bc3fc86b9dc415e
GIT binary patch
literal 7211
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

literal 0
HcmV?d00001

diff --git a/Documentation/admin-guide/mm/damon/damon_wss_dist.png b/Documentation/admin-guide/mm/damon/damon_wss_dist.png
new file mode 100644
index 0000000000000000000000000000000000000000..3c390f5115af9bcf7bd76ccdf9414de8ace9799b
GIT binary patch
literal 6173
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
Rl5p7TIjd!;S)y(m_Fp#ycijL0

literal 0
HcmV?d00001

diff --git a/Documentation/admin-guide/mm/damon/eval.rst b/Documentation/admin-guide/mm/damon/eval.rst
new file mode 100644
index 000000000000..b233890b4e45
--- /dev/null
+++ b/Documentation/admin-guide/mm/damon/eval.rst
@@ -0,0 +1,222 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========
+Evaluation
+==========
+
+DAMON is lightweight.  It increases system memory usage by only -0.25% and
+consumes less than 1% CPU time in most case.  It slows target workloads down by
+only 0.94%.
+
+DAMON is accurate and useful for memory management optimizations.  An
+experimental DAMON-based operation scheme for THP, 'ethp', removes 31.29% of
+THP memory overheads while preserving 60.64% of THP speedup.  Another
+experimental DAMON-based 'proactive reclamation' implementation, 'prcl',
+reduces 87.95% of residential sets and 29.52% of system memory footprint while
+incurring only 2.15% runtime overhead in the best case (parsec3/freqmine).
+
+Setup
+=====
+
+On a QEMU/KVM based virtual machine utilizing 20GB of RAM and hosted by an
+Intel i7 machine that running a kernel that v16 DAMON patchset is applied, I
+measure runtime and consumed system memory while running various realistic
+workloads with several configurations.  I use 13 and 12 workloads in PARSEC3
+[3]_ and SPLASH-2X [4]_ benchmark suites, respectively.  I use another wrapper
+scripts [5]_ for convenient setup and run of the workloads.
+
+Measurement
+-----------
+
+For the measurement of the amount of consumed memory in system global scope, I
+drop caches before starting each of the workloads and monitor 'MemFree' in the
+'/proc/meminfo' file.  To make results more stable, I repeat the runs 5 times
+and average results.
+
+Configurations
+--------------
+
+The configurations I use are as below.
+
+- orig: Linux v5.7 with 'madvise' THP policy
+- rec: 'orig' plus DAMON running with virtual memory access recording
+- prec: 'orig' plus DAMON running with physical memory access recording
+- thp: same with 'orig', but use 'always' THP policy
+- ethp: 'orig' plus a DAMON operation scheme, 'efficient THP'
+- prcl: 'orig' plus a DAMON operation scheme, 'proactive reclaim [6]_'
+
+I use 'rec' for measurement of DAMON overheads to target workloads and system
+memory.  'prec' is for physical memory monitroing and recording.  It monitors
+17GB sized 'System RAM' region.  The remaining configs including 'thp', 'ethp',
+and 'prcl' are for measurement of DAMON monitoring accuracy.
+
+'ethp' and 'prcl' are simple DAMON-based operation schemes developed for
+proof of concepts of DAMON.  'ethp' reduces memory space waste of THP by using
+DAMON for the decision of promotions and demotion for huge pages, while 'prcl'
+is as similar as the original work.  Those are implemented as below::
+
+    # format: <min/max size> <min/max frequency (0-100)> <min/max age> <action>
+    # ethp: Use huge pages if a region shows >=5% access rate, use regular
+    # pages if a region >=2MB shows <5% access rate for >=13 seconds
+    null    null    5       null    null    null    hugepage
+    2M      null    null    null    13s     null    nohugepage
+
+    # prcl: If a region >=4KB shows <=5% access rate for >=7 seconds, page out.
+    4K null    null 5    7s null      pageout
+
+Note that both 'ethp' and 'prcl' are designed with my only straightforward
+intuition because those are for only proof of concepts and monitoring accuracy
+of DAMON.  In other words, those are not for production.  For production use,
+those should be more tuned.
+
+.. [1] "Redis latency problems troubleshooting", https://redis.io/topics/latency
+.. [2] "Disable Transparent Huge Pages (THP)",
+    https://docs.mongodb.com/manual/tutorial/transparent-huge-pages/
+.. [3] "The PARSEC Becnhmark Suite", https://parsec.cs.princeton.edu/index.htm
+.. [4] "SPLASH-2x", https://parsec.cs.princeton.edu/parsec3-doc.htm#splash2x
+.. [5] "parsec3_on_ubuntu", https://github.com/sjp38/parsec3_on_ubuntu
+.. [6] "Proactively reclaiming idle memory", https://lwn.net/Articles/787611/
+
+Results
+=======
+
+Below two tables show the measurement results.  The runtimes are in seconds
+while the memory usages are in KiB.  Each configuration except 'orig' shows
+its overhead relative to 'orig' in percent within parenthesizes.::
+
+    runtime                 orig     rec      (overhead) prec     (overhead) thp      (overhead) ethp     (overhead) prcl     (overhead)
+    parsec3/blackscholes    107.228  107.859  (0.59)     108.110  (0.82)     107.381  (0.14)     106.811  (-0.39)    114.766  (7.03)
+    parsec3/bodytrack       79.292   79.609   (0.40)     79.777   (0.61)     79.313   (0.03)     78.892   (-0.50)    80.398   (1.40)
+    parsec3/canneal         148.887  150.878  (1.34)     153.337  (2.99)     127.873  (-14.11)   132.272  (-11.16)   167.631  (12.59)
+    parsec3/dedup           11.970   11.975   (0.04)     12.024   (0.45)     11.752   (-1.82)    11.921   (-0.41)    13.244   (10.64)
+    parsec3/facesim         212.800  215.927  (1.47)     215.004  (1.04)     205.117  (-3.61)    207.401  (-2.54)    220.834  (3.78)
+    parsec3/ferret          190.646  192.560  (1.00)     192.414  (0.93)     190.662  (0.01)     192.309  (0.87)     193.497  (1.50)
+    parsec3/fluidanimate    213.951  216.459  (1.17)     217.578  (1.70)     209.500  (-2.08)    211.826  (-0.99)    218.299  (2.03)
+    parsec3/freqmine        291.050  292.117  (0.37)     293.279  (0.77)     289.553  (-0.51)    291.768  (0.25)     297.309  (2.15)
+    parsec3/raytrace        118.645  119.734  (0.92)     119.521  (0.74)     117.715  (-0.78)    118.844  (0.17)     134.045  (12.98)
+    parsec3/streamcluster   332.843  336.997  (1.25)     337.049  (1.26)     279.716  (-15.96)   290.985  (-12.58)   346.646  (4.15)
+    parsec3/swaptions       155.437  157.174  (1.12)     156.159  (0.46)     155.017  (-0.27)    154.955  (-0.31)    156.555  (0.72)
+    parsec3/vips            59.215   59.426   (0.36)     59.156   (-0.10)    59.243   (0.05)     58.858   (-0.60)    60.184   (1.64)
+    parsec3/x264            67.445   71.400   (5.86)     71.122   (5.45)     64.078   (-4.99)    66.027   (-2.10)    71.489   (6.00)
+    splash2x/barnes         81.826   81.800   (-0.03)    82.648   (1.00)     74.343   (-9.15)    79.063   (-3.38)    103.785  (26.84)
+    splash2x/fft            33.850   34.148   (0.88)     33.912   (0.18)     23.493   (-30.60)   32.684   (-3.44)    48.303   (42.70)
+    splash2x/lu_cb          86.404   86.333   (-0.08)    86.988   (0.68)     85.720   (-0.79)    85.944   (-0.53)    89.338   (3.40)
+    splash2x/lu_ncb         94.908   98.021   (3.28)     96.041   (1.19)     90.304   (-4.85)    93.279   (-1.72)    97.270   (2.49)
+    splash2x/ocean_cp       47.122   47.391   (0.57)     47.902   (1.65)     43.227   (-8.26)    44.609   (-5.33)    51.410   (9.10)
+    splash2x/ocean_ncp      93.147   92.911   (-0.25)    93.886   (0.79)     51.451   (-44.76)   71.107   (-23.66)   112.554  (20.83)
+    splash2x/radiosity      92.150   92.604   (0.49)     93.339   (1.29)     90.802   (-1.46)    91.824   (-0.35)    104.439  (13.34)
+    splash2x/radix          31.961   32.113   (0.48)     32.066   (0.33)     25.184   (-21.20)   30.412   (-4.84)    49.989   (56.41)
+    splash2x/raytrace       84.781   85.278   (0.59)     84.763   (-0.02)    83.192   (-1.87)    83.970   (-0.96)    85.382   (0.71)
+    splash2x/volrend        87.401   87.978   (0.66)     87.977   (0.66)     86.636   (-0.88)    87.169   (-0.26)    88.043   (0.73)
+    splash2x/water_nsquared 239.140  239.570  (0.18)     240.901  (0.74)     221.323  (-7.45)    224.670  (-6.05)    244.492  (2.24)
+    splash2x/water_spatial  89.538   89.978   (0.49)     90.171   (0.71)     89.729   (0.21)     89.238   (-0.34)    99.331   (10.94)
+    total                   3051.620 3080.230 (0.94)     3085.130 (1.10)     2862.320 (-6.20)    2936.830 (-3.76)    3249.240 (6.48)
+
+
+    memused.avg             orig         rec          (overhead) prec         (overhead) thp          (overhead) ethp         (overhead) prcl         (overhead)
+    parsec3/blackscholes    1676679.200  1683789.200  (0.42)     1680281.200  (0.21)     1613817.400  (-3.75)    1835229.200  (9.46)     1407952.800  (-16.03)
+    parsec3/bodytrack       1295736.000  1308412.600  (0.98)     1311988.000  (1.25)     1243417.400  (-4.04)    1435410.600  (10.78)    1255566.400  (-3.10)
+    parsec3/canneal         1004062.000  1008823.800  (0.47)     1000100.200  (-0.39)    983976.000   (-2.00)    1051719.600  (4.75)     993055.800   (-1.10)
+    parsec3/dedup           2389765.800  2393381.000  (0.15)     2366668.200  (-0.97)    2412948.600  (0.97)     2435885.600  (1.93)     2380172.800  (-0.40)
+    parsec3/facesim         488927.200   498228.000   (1.90)     496683.800   (1.59)     476327.800   (-2.58)    552890.000   (13.08)    449143.600   (-8.14)
+    parsec3/ferret          280324.600   282032.400   (0.61)     282284.400   (0.70)     258211.000   (-7.89)    331493.800   (18.25)    265850.400   (-5.16)
+    parsec3/fluidanimate    560636.200   569038.200   (1.50)     565067.400   (0.79)     556923.600   (-0.66)    588021.200   (4.88)     512901.600   (-8.51)
+    parsec3/freqmine        883286.000   904960.200   (2.45)     886105.200   (0.32)     849347.400   (-3.84)    998358.000   (13.03)    622542.800   (-29.52)
+    parsec3/raytrace        1639370.200  1642318.200  (0.18)     1626673.200  (-0.77)    1591284.200  (-2.93)    1755088.400  (7.06)     1410261.600  (-13.98)
+    parsec3/streamcluster   116955.600   127251.400   (8.80)     121441.000   (3.84)     113853.800   (-2.65)    139659.400   (19.41)    120335.200   (2.89)
+    parsec3/swaptions       8342.400     18555.600    (122.43)   16581.200    (98.76)    6745.800     (-19.14)   27487.200    (229.49)   14275.600    (71.12)
+    parsec3/vips            2776417.600  2784989.400  (0.31)     2820564.600  (1.59)     2694060.800  (-2.97)    2968650.000  (6.92)     2713590.000  (-2.26)
+    parsec3/x264            2912885.000  2936474.600  (0.81)     2936775.800  (0.82)     2799599.200  (-3.89)    3168695.000  (8.78)     2829085.800  (-2.88)
+    splash2x/barnes         1206459.600  1204145.600  (-0.19)    1177390.000  (-2.41)    1210556.800  (0.34)     1214978.800  (0.71)     907737.000   (-24.76)
+    splash2x/fft            9384156.400  9258749.600  (-1.34)    8560377.800  (-8.78)    9337563.000  (-0.50)    9228873.600  (-1.65)    9823394.400  (4.68)
+    splash2x/lu_cb          510210.800   514052.800   (0.75)     502735.200   (-1.47)    514459.800   (0.83)     523884.200   (2.68)     367563.200   (-27.96)
+    splash2x/lu_ncb         510091.200   516046.800   (1.17)     505327.600   (-0.93)    512568.200   (0.49)     524178.400   (2.76)     427981.800   (-16.10)
+    splash2x/ocean_cp       3342260.200  3294531.200  (-1.43)    3171236.000  (-5.12)    3379693.600  (1.12)     3314896.600  (-0.82)    3252406.000  (-2.69)
+    splash2x/ocean_ncp      3900447.200  3881682.600  (-0.48)    3816493.200  (-2.15)    7065506.200  (81.15)    4449224.400  (14.07)    3829931.200  (-1.81)
+    splash2x/radiosity      1466372.000  1463840.200  (-0.17)    1438554.000  (-1.90)    1475151.600  (0.60)     1474828.800  (0.58)     496636.000   (-66.13)
+    splash2x/radix          1760056.600  1691719.000  (-3.88)    1613057.400  (-8.35)    1384416.400  (-21.34)   1632274.400  (-7.26)    2141640.200  (21.68)
+    splash2x/raytrace       38794.000    48187.400    (24.21)    46728.400    (20.45)    41323.400    (6.52)     61499.800    (58.53)    68455.200    (76.46)
+    splash2x/volrend        138107.400   148197.000   (7.31)     146223.400   (5.88)     128076.400   (-7.26)    164593.800   (19.18)    140885.200   (2.01)
+    splash2x/water_nsquared 39072.000    49889.200    (27.69)    47548.400    (21.69)    37546.400    (-3.90)    57195.400    (46.38)    42994.200    (10.04)
+    splash2x/water_spatial  662099.800   665964.800   (0.58)     651017.000   (-1.67)    659808.400   (-0.35)    674475.600   (1.87)     519677.600   (-21.51)
+    total                   38991500.000 38895300.000 (-0.25)    37787817.000 (-3.09)    41347200.000 (6.04)     40609600.000 (4.15)     36994100.000 (-5.12)
+
+
+DAMON Overheads
+---------------
+
+In total, DAMON virtual memory access recording feature ('rec') incurs 0.94%
+runtime overhead and -0.25% memory space overhead.  Even though the size of the
+monitoring target region becomes much larger with the physical memory access
+recording ('prec'), it still shows only modest amount of overhead (1.10% for
+runtime and -3.09% for memory footprint).
+
+For a convenience test run of 'rec' and 'prec', I use a Python wrapper.  The
+wrapper constantly consumes about 10-15MB of memory.  This becomes a high
+memory overhead if the target workload has a small memory footprint.
+Nonetheless, the overheads are not from DAMON, but from the wrapper, and thus
+should be ignored.  This fake memory overhead continues in 'ethp' and 'prcl',
+as those configurations are also using the Python wrapper.
+
+
+Efficient THP
+-------------
+
+THP 'always' enabled policy achieves 6.20% speedup but incurs 6.04% memory
+overhead.  It achieves 44.76% speedup in the best case, but 81.15% memory
+overhead in the worst case.  Interestingly, both the best and worst-case are
+with 'splash2x/ocean_ncp').
+
+The 2-lines implementation of data access monitoring based THP version ('ethp')
+shows 3.76% speedup and 4.15% memory overhead.  In other words, 'ethp' removes
+31.29% of THP memory waste while preserving 60.64% of THP speedup in total.  In
+the case of the 'splash2x/ocean_ncp', 'ethp' removes 82.66% of THP memory waste
+while preserving 52.85% of THP speedup.
+
+
+Proactive Reclamation
+---------------------
+
+As similar to the original work, I use 4G 'zram' swap device for this
+configuration.
+
+In total, our 1 line implementation of Proactive Reclamation, 'prcl', incurred
+6.48% runtime overhead in total while achieving 5.12% system memory usage
+reduction.
+
+Nonetheless, as the memory usage is calculated with 'MemFree' in
+'/proc/meminfo', it contains the SwapCached pages.  As the swapcached pages can
+be easily evicted, I also measured the residential set size of the workloads::
+
+    rss.avg                 orig         rec          (overhead) prec         (overhead) thp          (overhead) ethp         (overhead) prcl         (overhead)
+    parsec3/blackscholes    590412.200   589991.400   (-0.07)    591716.400   (0.22)     591131.000   (0.12)     591055.200   (0.11)     274623.600   (-53.49)
+    parsec3/bodytrack       32202.200    32297.400    (0.30)     32301.400    (0.31)     32328.000    (0.39)     32169.800    (-0.10)    25311.200    (-21.40)
+    parsec3/canneal         840063.600   839145.200   (-0.11)    839506.200   (-0.07)    835102.600   (-0.59)    839766.000   (-0.04)    833091.800   (-0.83)
+    parsec3/dedup           1185493.200  1202688.800  (1.45)     1204597.000  (1.61)     1238071.400  (4.44)     1201689.400  (1.37)     920688.600   (-22.34)
+    parsec3/facesim         311570.400   311542.000   (-0.01)    311665.000   (0.03)     316106.400   (1.46)     312003.400   (0.14)     252646.000   (-18.91)
+    parsec3/ferret          99783.200    99330.000    (-0.45)    99735.000    (-0.05)    102000.600   (2.22)     99927.400    (0.14)     90967.400    (-8.83)
+    parsec3/fluidanimate    531780.800   531800.800   (0.00)     531754.600   (-0.00)    532009.600   (0.04)     531822.400   (0.01)     479116.000   (-9.90)
+    parsec3/freqmine        551787.600   551550.600   (-0.04)    551950.000   (0.03)     556030.000   (0.77)     553720.400   (0.35)     66480.000    (-87.95)
+    parsec3/raytrace        895247.000   895240.200   (-0.00)    895770.400   (0.06)     895880.200   (0.07)     893516.600   (-0.19)    327339.600   (-63.44)
+    parsec3/streamcluster   110862.200   110840.400   (-0.02)    110878.600   (0.01)     112067.200   (1.09)     112010.800   (1.04)     109763.600   (-0.99)
+    parsec3/swaptions       5630.000     5580.800     (-0.87)    5599.600     (-0.54)    5624.200     (-0.10)    5697.400     (1.20)     3792.400     (-32.64)
+    parsec3/vips            31677.200    31881.800    (0.65)     31785.800    (0.34)     32177.000    (1.58)     32456.800    (2.46)     29692.000    (-6.27)
+    parsec3/x264            81796.400    81918.600    (0.15)     81827.600    (0.04)     82734.800    (1.15)     82854.000    (1.29)     81478.200    (-0.39)
+    splash2x/barnes         1216014.600  1215462.000  (-0.05)    1218535.200  (0.21)     1227689.400  (0.96)     1219022.000  (0.25)     650771.000   (-46.48)
+    splash2x/fft            9622775.200  9511973.400  (-1.15)    9688178.600  (0.68)     9733868.400  (1.15)     9651488.000  (0.30)     7567077.400  (-21.36)
+    splash2x/lu_cb          511102.400   509911.600   (-0.23)    511123.800   (0.00)     514466.800   (0.66)     510462.800   (-0.13)    361014.000   (-29.37)
+    splash2x/lu_ncb         510569.800   510724.600   (0.03)     510888.800   (0.06)     513951.600   (0.66)     509474.400   (-0.21)    424030.400   (-16.95)
+    splash2x/ocean_cp       3413563.600  3413721.800  (0.00)     3398399.600  (-0.44)    3446878.000  (0.98)     3404799.200  (-0.26)    3244787.400  (-4.94)
+    splash2x/ocean_ncp      3927797.400  3936294.400  (0.22)     3917698.800  (-0.26)    7181781.200  (82.85)    4525783.600  (15.22)    3693747.800  (-5.96)
+    splash2x/radiosity      1477264.800  1477569.200  (0.02)     1476954.200  (-0.02)    1485724.800  (0.57)     1474684.800  (-0.17)    230128.000   (-84.42)
+    splash2x/radix          1773025.000  1754424.200  (-1.05)    1743194.400  (-1.68)    1445575.200  (-18.47)   1694855.200  (-4.41)    1769750.000  (-0.18)
+    splash2x/raytrace       23292.000    23284.000    (-0.03)    23292.800    (0.00)     28704.800    (23.24)    26489.600    (13.73)    15753.000    (-32.37)
+    splash2x/volrend        44095.800    44068.200    (-0.06)    44107.600    (0.03)     44114.600    (0.04)     44054.000    (-0.09)    31616.000    (-28.30)
+    splash2x/water_nsquared 29416.800    29403.200    (-0.05)    29406.400    (-0.04)    30103.200    (2.33)     29433.600    (0.06)     24927.400    (-15.26)
+    splash2x/water_spatial  657791.000   657840.400   (0.01)     657826.600   (0.01)     657595.800   (-0.03)    656617.800   (-0.18)    481334.800   (-26.83)
+    total                   28475091.000 28368400.000 (-0.37)    28508700.000 (0.12)     31641800.000 (11.12)    29036000.000 (1.97)     21989800.000 (-22.78)
+
+In total, 22.78% of residential sets were reduced.
+
+With parsec3/freqmine, 'prcl' reduced 87.95% of residential sets and 29.52% of
+system memory usage while incurring only 2.15% runtime overhead.
diff --git a/Documentation/admin-guide/mm/damon/faq.rst b/Documentation/admin-guide/mm/damon/faq.rst
new file mode 100644
index 000000000000..f55d1d719999
--- /dev/null
+++ b/Documentation/admin-guide/mm/damon/faq.rst
@@ -0,0 +1,59 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+Frequently Asked Questions
+==========================
+
+Why a new module, instead of extending perf or other user space tools?
+======================================================================
+
+First, because it needs to be lightweight as much as possible so that it can be
+used online, any unnecessary overhead such as kernel - user space context
+switching cost should be avoided.  Second, DAMON aims to be used by other
+programs including the kernel.  Therefore, having a dependency on specific
+tools like perf is not desirable.  These are the two biggest reasons why DAMON
+is implemented in the kernel space.
+
+
+Can 'idle pages tracking' or 'perf mem' substitute DAMON?
+=========================================================
+
+Idle page tracking is a low level primitive for access check of the physical
+address space.  'perf mem' is similar, though it can use sampling to minimize
+the overhead.  On the other hand, DAMON is a higher-level framework for the
+monitoring of various address spaces.  It is focused on memory management
+optimization and provides sophisticated accuracy/overhead handling mechanisms.
+Therefore, 'idle pages tracking' and 'perf mem' could provide a subset of
+DAMON's output, but cannot substitute DAMON.  Rather than that, thouse could be
+configured as DAMON's low-level primitives for specific address spaces.
+
+
+How can I optimize my system's memory management using DAMON?
+=============================================================
+
+Because there are several ways for the DAMON-based optimizations, we wrote a
+separate document, :doc:`guide`.  Please refer to that.
+
+
+Does DAMON support virtual memory only?
+=======================================
+
+No.  The core of the DAMON is address space independent.  The address space
+specific low level primitive parts including monitoring target regions
+constructions and actual access checks can be implemented and configured on the
+DAMON core by the users.  In this way, DAMON users can monitor any address
+space with any access check technique.
+
+Nonetheless, DAMON provides a vma tracking and PTE Accessed bit check based
+implementation of the address space dependent functions for the virtual memory
+by default, for a reference and convenient use.  In near future, we will also
+provide that for physical memory address space.
+
+
+Can I simply monitor page granularity?
+======================================
+
+Yes.  You can do so by setting the ``min_nr_regions`` attribute higher than the
+working set size divided by the page size.  Because the monitoring target
+regions size is forced to be ``>=page size``, the region split will make no
+effect.
diff --git a/Documentation/admin-guide/mm/damon/freqmine_heatmap.png b/Documentation/admin-guide/mm/damon/freqmine_heatmap.png
new file mode 100644
index 0000000000000000000000000000000000000000..4bdde033017856246a47c338084c31761296b27c
GIT binary patch
literal 9999
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

literal 0
HcmV?d00001

diff --git a/Documentation/admin-guide/mm/damon/freqmine_wss_sz.png b/Documentation/admin-guide/mm/damon/freqmine_wss_sz.png
new file mode 100644
index 0000000000000000000000000000000000000000..83cb1bd67734b340be690dd3a5a058069d0286cd
GIT binary patch
literal 5589
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

literal 0
HcmV?d00001

diff --git a/Documentation/admin-guide/mm/damon/freqmine_wss_time.png b/Documentation/admin-guide/mm/damon/freqmine_wss_time.png
new file mode 100644
index 0000000000000000000000000000000000000000..a61ded5c5cb9d018109fee3971ef3620b6126eef
GIT binary patch
literal 6550
zcmdUTc|25a`~RF{hMBPqV+%2|RkAPHVhEA7KDH1eg``kI6vrS-l(J`=WJ`#T7Q3+~
zyA~~$21T+oA1b@~p3(R9d!Fa@d;a|W^PAV1Irn|t*L~mDeO>SCJ=Zz$Hde<tvBFpc
z0>No!YIG8T03iedprKh{3CMkD1n#KVSlAjf7z|iKp-`ANDgps9s0apPX^Bcibax{R
z&QCI^1O!B+LJTDmbPItXLI?)Lh+w=eI(QJCN~8_J^Mr+kRaI3jEiFAgJtHC_va+&j
zYHFxdYF}U9*RNmUE$AvL$xF!<A7<!wbQ*)PG)`tbZ+)_~#CVT@cSD?oe<SwY+NW^K
zVYh#4&mMo+6a=C_c3>XCG?9TA7-sOLFd}T|5X3M>Y(SUi(nIMpiA^sq)ZS$O^=pg*
z5g0{?CGt`#;>|c^JlTe5cR>;2LqL3d5D~s0h(v`*42WqzkwJkk5`*H;pi&v|c^K6G
z7kP9Bo$|cDmC@Qyt-8)2QW%8h=H}0zKfAfPiHnQt>+9#|=eM-9<OtiB!)M0$o1VIY
zKyY<1zd)KCmk0tOgf%lVunoys%*6yn5%`SH?Ol3#mGEun#SntaREej@tEXZ1sii2?
z;f%B0QGyrwx6fXxSL+w2dOn(0mbAF%31)+*_p!j)#z1A_Xt`>QwA0ter%x|w3|A~Q
z|5^)GH(v(Hm8ZU{IDwVEGwt2!*_P2?6xmk$r9H^ph%Ihs>fJ}5+bZ5aw-nfpP4ay3
zwsIMOA|?fG%xf=QoqQfYciDF@_kb;TrdGc?;=u>-@`K0E?CK6TPrT}tnW?z@^Via|
zIkGTrE5ls19@}M6@%y#SQb|YyRMT`MLx>HD@z;^KJ|Eq<AvAwA<uQbiY85!1u(H}#
zSo7)`=65S`H5pqg*Y$3Wq8lpIY!&B5{ZiDM1LzTVICRwsZxq+7yL32GN&>S~schZ(
zt)3ZTmrwO+(KItFtN1c3b0WVT`lG(YVbP$ls@$@Da;$7#Yrr!sC30|~kuT$6;754o
z{=C+f(uP0+a8-P&-kgos<{yc?;`pZU<AN;7C##{Oi$yG$(oNj^)7r^UJ$JzP|8Lz;
zu4+Ylmm@_iMsKgg-Kd`Weqb-5An)kHEq({<IRwum?rOZ;B}Zxe^tg<hN2dXG$?SSu
zu46!ZTYBW3;p!<N8L#=hpUisd^nZ>_I|ksY!n{$s9#BVTLKHN9RJ7ROHW_oo`I>FH
zCi=sXj!2(O$Mph{kEOesr6^mI#YvyG-DM>%kw4Z+9kd@a;<4bc1#gtsuJb7=*o*p5
zCm!(oAIYZGGUo()dvrEEb^b*P^kuH7(@{O;%2_UUGd_u*4G1e)`s+Hp4GzbL0?7qL
zq75G!od5y`CkTZ7SR~Ro5~A$?e>wP_XGo+R2mZD?0)|HM8&W489V7Zx8NznGZN<Jb
z`nobM^LbY;!DX+>amycRRAopq&@pdL7^tdMCy@EccptzmsZ0RZij5RJ1K3e;@~{+C
z>;TLB{e9Unv7{K<-YJ{Y$LkhFnL2DI0ZZynOCnMZ$@Qfb>+rmKpQ8l*=s3IBZ(-&*
z_Y^5c`_?sLm7zb&)vC5ubQ~#$YCT@E2FK+;eNc26U=#YF^<TYlJQJGVACo-2aidp_
zNL|A4`12&b5=@N$x;b(Hg2wR#3ZLZRCnG1i?_?K)V30KgO)rY55J;;OJea_{pCE3_
zl4ylCHO_>3%f+O%#py+?uvRAIGXrXIo98K@ky}6;^6aRTVcmeJ1Zg$;k<{BQgYObo
z3SQST_rv?A-x3B~hLKT5(U|U{ypFfI9SIz8U{82m(G8He6bX$-MS9z$5&?$;u3-!B
zqhG-ie29)fijQ`S@?aVXy~cv%GP>h=2-mJe;E7}z9$PR7nEAGg5!vI!d%{B^a$IoO
zNO;}(BQr0CR5A1}7_UuuO<aFRx5>J@>*j@WO+9S!RK%F?@)3Jc<U;PyCLq13`REZ|
z&MM)mV@&Pnm#|#~PL5-C&NazX#41l^ZKB_-?4lI>aWi0NBP3foU#@c>6W$Y;W^www
zs~@P)Q`Wt!Qh;<h>O;IV08F3h+zT3ZSYddQ_g)vi8GuS1#Y>&2o+6NbM58rt`@X%N
zBiPF0GhsbnaHjJSDPV&ixsXhE46tUUJOOVvL<Ce%C5EI(l$KIB<2*W(j!D(Rnc__j
zlck>=i!zH}a17{mcR0IiYb4mbA)cSlR@aq)56hR<_;WDxfbUb6it9eI!fuPsXDJKA
zG}}hKVg`B`bAoerHeGcO3?DMeMG7zJb}rrP4IDD0UTR?|=LTQ0*R?!699-Hnnn(Hs
zpiVF~plv}$MYSxj(BHhr!OA94<PhLa%12^L_o<&1MMuNy%Fw!J&YhmI&hSeCfd*N6
z`t`q7<=4GTASjpj>aoB)<xBwFK}@EkavOV^#=ycgQhhVJvHs5e6adyI5+4k`I2pe%
z3*lKo9cd~19MtJZ1sFN!&nCE{KghwLmX>m@x+>^X9Ik|1$U^{LGJ=(^<qx;kyhF8N
zoJOm)ZrFRTr1F#;9OQ>_^}t=Y>)L>zf@9i1984oczpc>71=0VTJNnURmQ5r~EpPFP
zAH?Cz53)M)4|%&4D?yt5KO(NHjkF7N!{EDnD~6al&wJXZjYSndU|hc`)LZZ_a@wN-
z=NKbuW=LxuQEjuJS8aWV6oad>GevHRDX#6+IoK~y;lJ9)#djGGPuF<0(yb6bjSACj
z)5sad4k~fZ<X)Tpvq&MUEuFd;JX-D@6AJ}ZX+|))=b+jw6y`q%-MGC{uj=%`ftvl=
zfNJt!4&~SHXA{>x{sb1j!2F(lDbpkXYP^h^<`*kZmbduUY)I8Rrb~lIpWvqkxz$NE
zLvJC)q*P;N&}kUk)UI^6C<;n4l%jlRyQ2(#8pdw34DW0aNDpl=rQ$Xb&F{ssh7#;U
zSmm~aE8tVJ=R!}?RX=k)f=}jM8SNW!*)oM27>)5IXv^ZNPQPYf^9fn4b00!R`4tNK
zi^guL78+9R=gKg85s~%~Ow?-NvVrAr`o(Y!^alkgP@zT)b+(Qp8d@~GqBBzF*Xy=y
ze4Gqb7zW8Z+C|jGx)VrY$>{xWPp=paqBbE|Z6EEB;8pzju3hJPSE9_fzg2F2V}-$d
zdjCt{TA!6Nks5SO=rbS7FvR+w!It2$(TsQ$3H2|lRT}giHLK-gYc@PcOAy9gk2IuC
z$0u7%mPwG>ZQ%Uu)8)B0|HuNiQO(l7^1dG%sKK5D)z!gJaVDD*+f2>$2(T;Brh5*&
zVng~02m=QsrL%U_TNI*T<JGvjk4j3%1PC6$fEsL%ptFO~n(l@KQUgxCwe{{j+b71Z
z&+6m(SI-1=-h}!MB}x8;g=upLm*<f$s;36_<AUZ0q--2#d$h@M6$zo}z>NERIc7cY
z4_8aTdvY4BBqvz|Eu9G>6Ac7hm3yfVRl@i3K7~Mhqh1{U>IA9|y{5ahw-gWt+GS;(
zIxnnLeA*P1TWVrIbNn!8DIgMEDk!S0b@zKTy#miG2y^Ch%ty{g?kV`JZnc?UmvT*3
zAp1)^H2Efp&D!dzT-QU7&bbx+6)sQ%IlK)$NWouJCx{d<2~a~qIF2hf$6I+8^0>|<
zBbma(h0C+qOBqvt#^+{kd&AQI`iF!a?njGUDVB|bPi2GYjut)@zI`_SEdt1n`PTX~
zi~BoyY~!SIqs62PDms$Wz?S9mc5H8?m)5mt*k`LQbS3Xi0$~lA1htK6sV7)W!rWSe
zJA!ZfQk(d_>$O&|R2r`8RClr0U%@B8CfK2Y(V}~^WCjN5n?5%==`(j6jr2wD1Kxjh
z!NwmriG+2%kuI6ZHT%jeCW%zf2Rt@k?q>(H{0aP^5YzQ&O)n7$#uq%8?4<!`G5fF<
zg=De6pofoZ7X&YJOI2c6fNT`Y@NP{KLnL+$#I;s;Vv(?NB=kg8KZk`JOTn-jpSPxF
zGcjx#chmiOi*0aw2$}y=u!bQuh)^%!d#NM;(RWL0X68%1AqMKC*Yh2Y)lF+YJ~MU{
zFTf-a%v~t7c$UCOcPQ$58G)3GhAa)GX-e#Sro<z-ThyabyAm0a<F*&-K|GULvZD=&
z?j(uec2lk9Ae)g+)?Ez=n)g3}`58Cl+yW&<cA1Us1YUGY>0VaX#XA{%dzf6ub{A^(
zO4K%eU+fsjG)e3ZlB4B`bjZoua5bmrD1r3lE)Z5)%S!&`OP-G6Z)Qj1FT|Qs>0X9~
zj=xAhBgp)D;>cj>r{G<PXO(5ZQ)ot?$*y5Amc2UVXlM7^$<U+oP@*<0Biw1QlQblL
z+OD61;7oeQ9-jMmzl=|)0D<%vhuJSJZku|uafQW@`kPYE+x9D8*T9e!&Qcg)F=ZHy
zV97*pa;sMy(j{vs!0@u=YgU+)eT0gMImzy1Xwd+!1fo{s*udw<k2%2kc*`c2r7QKT
z_!xRkje~DL>pLZm6b~zm1nIHO=>%ubyMHl>H#Ile*fW>H3qJ1-+}bd#IzGRDPp=k^
z6L5|;CCa;X)evDNBTz+SIqtO)3%s8x@g181C%QT63S6pc14)ssVV%IPTs}WjQ0zpZ
zP$D!NhW>y(n~TeOCJ4eqWvqz@di9wH4&lng!|VMkVNzL9jkn-3*tyUE;BRIY8OFl=
zLxOTk%gV)zhmqwu_mMdtuU_7!?hYN~_2+Q_jxuvo04`e<1WH&r68UHOajf=mIorI!
z??nCP81Mts3#Xy@9ts0?Ijr)eKxXFddxtJ92&k6d=KvD`+<k^F4HFvGBJI`~`_j<f
zQ+9r!NoT^9Gb%)?Nr)6Fq`cO~{&{uR%Y>txANHlag`CCeSreJnm~){X0CNV@1S{&A
zV}KxmBxx&6(#2JskeOfgA`l3OKZSg1zJSt%rDHA@Erdc^ppc0mSUeSs3as4AhHH@x
znGQy6HGXHWQsi$rMAJX0jLyWOzb!0t{Og{ugKGQ{Q+t6x0_p|mE3pk&p^<0XB@lfT
z0lEfXLnAFZe_+?b!`EDHF|2A405^el^_A+5G@+~d;%?K1MaH9kYu(5T4At(&RUujq
z(vZMB#Tj^a42xHyJ>>vproB+t-B5rzJp~lo9(oK7HbKy<H8X%Mf-}>S*f$yq0u{zM
zC4JnG6B1Zq`7a&)gOnd0N2$C|_tP#`wXs_x8_UBgV|2(uSfuXx6U3Oqj*}=SfKh~l
zyLRxSMjJb>3RA|De1{yL<(3}9D%S{eB1IS|a*VZeX~c5bhe+5`A-oPc^R^H2tx3hD
zUSWZ9dfU&rb_1$YsR@zOA)%8^u2E_IkVuZPF>=dKwqEW#um6cpOsUN?NXftCAW)~p
zmI$u|fEosNV2`|syYHWUeR%yRoJUGYF_+XD&_KQq0KECfg1AA7iF$ouMN!*vGR7LT
z@>3*`B)&faUV0=;!y**=1M(fZRy2sY!5>>=>Rz6+;%AbFfjYR8VhZFs3_i`=iq~TW
zoruIuJNQ+M4SKi9kL=?@K6N8f7ht)u0Kf>teiXzFh2OO%3e^I@q99I52krtu%}NSr
zm6w65;@HN9SZQJaIacr!Y)BA+vJHYWGdsH5NkORVDf9MJFDD{3kVu_pM`vc0fL3oh
z%D5E2;^`Y@R)E~j@tUEloZe0KU0&I`&IZ(dTM1CRG`5?8<X9WfTY&NMP)3iTQZj?e
z(Y@fpqk{JSdiH(q9Lm>lZk7Qhv1@YjV>P2ip%01QXB?0@Ijero=LG4mc~hcsHz6(f
zv1-}(>iWuhujv6wi$^MCUvP#I2RS_P;iY$LHXZskdKih;R3B&GF$SDV8R3T18s$(K
z+WW3sCe$zd0?59eRXGXu5$Fw3hQ@cAS{^7zD-yesx-LV@sF$pO!YngC38FJIWYuX;
zFdxW~)~KBO&3v<m)(_HV{T^a~JGOFcU^Dxg<;_4aFWm^eMl<3EXQofh>E1{@h`j!K
zwa$FD-3gs}#~a8!hkpkBK5QjJ8QsKM9}#Skp_H7dRk+{WL$Ce(`^M_rV&}B29=E+A
z(J-epKm-7_#nqjtwMXxpP$#cAj60YemZvy5--32tg^H&u94ES^Y&UO7j4T~f=l@iC
z;hZ1psn5$-HHUcjMU3L<p7qPJMcIw9tw&Cdyl%a=s74cSsc}A1KDA)Jg#0O*JNIF_
zoizMq^q+i(nF2ju;@|z~5Pa3-c}~ry8@4S_kg?|Co-ypV_2117*|E@@onITspI@(y
zxlC#my)*yJJ^$2sUh!L0L<YBWZur{swfYj-l2MMHEBL=>0`Ob*0b`ij_v+3S*W}uF
zE`+-Me7+nSNx#Qmv%HmAKHj!blRb8)reQWbLH6UvYbFcpXNzWg16Rw<h!I1Tv$Ie}
zarelD&m=dG39FPx1;sBc^{>CoxVV@$A^X>D;gN`;!H%(gYe}`?&GO2<bfLd;?xc)Z
z4Q9-Z*02Ldyr%7Qr^Z@Id;J_DFW#D*LHLd?ndHcv`n>kr$8C;hD1GOCLDOt!(u+G@
z4ulD^_W2M-(gXwe%>I4zMS~~Zl=|Z0Jf2>RVIBXAs=@8{u<ORT<;EL+<lL_V5f5vO
ziM=xiUY<^P@hbe&P7wQG3HrR8zNcWmFA?v8VJdg7p3lRCG{ns6h+VSR>sz^0BpZ)K
zZq@#+3bdFcnRn(Y3=}l@(J$SKJup$xI6Z9@Y!!+P+&r)p6!F_Hu%TpjzM;9on(B9A
z`rlqRB5q8zSn8YgJS3f&Da`8gEw+eAvq%iwQ@)(`-7sZGyJoR6MfGC6$2Rx3%G;*Z
zT#s?7S%=!trl~t^>F-;H4bxhCTp4+il4cQUz2T#8vVtn*+$FXc8+3W?e!Ckjwpsqw
z-a!28*-uH4hghz--K#$qFSTt+RlV5ev3HR1BYB;}AwT0_$|)`<V!_Wrk@wyznkXr=
z2t3^)d&BWqz?C~B6<axzv{ya$l7tf*C(CL+#2jK_R>!<WEtrsE%NyknYwOIl`Cal^
zc+VBwQwMpA20MBL?PBofs<2&s2MER+4bZVq9WS-HrVPz~F)UN#^>T~(ZTMZWWgND$
z(eqZ_itMIN@`E#Kc~bZ{#)OOHEVFd{IYQ^oW^6X;HU3S&yve<@e=iN{l-r7*(L)x#
zA_<cBZ)<2vq@G?0uufOP_qb>N@+O~G`QStR{ia<hIx3}i{luJ##NIgjqjT*2#OgC}
zMJ;(^<06L<exg{>f?X@c^KZ9=hh`BIH{Ih@suVkmtUg~~U%say_Uhjw^B?WCwuiG9
zJ=cHu?&N~slJ4fV=(qoh5@Ymu;(9X{sZajdI@KOw2RUnaoaRoCv`8eIYluV@zWw2~
z($`g<7lG^IZc59`?A2w^LtlP5HJ>GG+;8GJ^Xx{G*+ifFb8R^bJ!g&4>C3eDLY<9E
zc9}f%U#^1{XAZae%$XNlopG^5QTrcyH7IB6gi3BxN9!h}p3GV}&%WTFd1pU7^4nXo
zn>^gjOV3$t7qF54T2>$|5Ttuu?vC0*VRTctt{BTmt(>i11H?O??A9R~?o8c&XGi>X
z@<N?Tvz`6RQ=@(5h3UPaH4CL<WBgvX(~D>sN&+7(>HqA!Mn2BShU9|5bXR0!<$Imw
z)5PGI0XA?)?V<XM_>ldSuzHP+3slu>C9F@E)4a(MqLSovsHOzeu3X4XUJ<o%P0=3&
za`~S_-=epqOpxO`xw$eSTAOXRA)l4VJF&`}N_~x%o0lsO>$rxt{!Tcx^l{5iNkpx8
zB*pP9B43h{*V!pY5qpo9{ES!59-W3ZH{{nn)&@^K2!8vKL=f)q@Oi>G5N#en5W6z4
nCJqFsf@_N2M!^4u4$A+^o!(TdT%_+C%@mm#TNzavlF0u9cBXpq

literal 0
HcmV?d00001

diff --git a/Documentation/admin-guide/mm/damon/guide.rst b/Documentation/admin-guide/mm/damon/guide.rst
new file mode 100644
index 000000000000..15adbe2b4331
--- /dev/null
+++ b/Documentation/admin-guide/mm/damon/guide.rst
@@ -0,0 +1,194 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================
+Optimization Guide
+==================
+
+This document helps you estimating the amount of benefit that you could get
+from DAMON-based optimizations, and describes how you could achieve it.  You
+are assumed to already read :doc:`start`.
+
+
+Check The Signs
+===============
+
+No optimization can provide same extent of benefit to every case.  Therefore
+you should first guess how much improvements you could get using DAMON.  If
+some of below conditions match your situation, you could consider using DAMON.
+
+- *Low IPC and High Cache Miss Ratios.*  Low IPC means most of the CPU time is
+  spent waiting for the completion of time-consuming operations such as memory
+  access, while high cache miss ratios mean the caches don't help it well.
+  DAMON is not for cache level optimization, but DRAM level.  However,
+  improving DRAM management will also help this case by reducing the memory
+  operation latency.
+- *Memory Over-commitment and Unknown Users.*  If you are doing memory
+  overcommitment and you cannot control every user of your system, a memory
+  bank run could happen at any time.  You can estimate when it will happen
+  based on DAMON's monitoring results and act earlier to avoid or deal better
+  with the crisis.
+- *Frequent Memory Pressure.*  Frequent memory pressure means your system has
+  wrong configurations or memory hogs.  DAMON will help you find the right
+  configuration and/or the criminals.
+- *Heterogeneous Memory System.*  If your system is utilizing memory devices
+  that placed between DRAM and traditional hard disks, such as non-volatile
+  memory or fast SSDs, DAMON could help you utilizing the devices more
+  efficiently.
+
+
+Profile
+=======
+
+If you found some positive signals, you could start by profiling your workloads
+using DAMON.  Find major workloads on your systems and analyze their data
+access pattern to find something wrong or can be improved.  The DAMON user
+space tool (``damo``) will be useful for this.
+
+We recommend you to start from working set size distribution check using ``damo
+report wss``.  If the distribution is ununiform or quite different from what
+you estimated, you could consider `Memory Configuration`_ optimization.
+
+Then, review the overall access pattern in heatmap form using ``damo report
+heats``.  If it shows a simple pattern consists of a small number of memory
+regions having high contrast of access temperature, you could consider manual
+`Program Modification`_.
+
+If you still want to absorb more benefits, you should develop `Personalized
+DAMON Application`_ for your special case.
+
+You don't need to take only one approach among the above plans, but you could
+use multiple of the above approaches to maximize the benefit.
+
+
+Optimize
+========
+
+If the profiling result also says it's worth trying some optimization, you
+could consider below approaches.  Note that some of the below approaches assume
+that your systems are configured with swap devices or other types of auxiliary
+memory so that you don't strictly required to accommodate the whole working set
+in the main memory.  Most of the detailed optimization should be made on your
+concrete understanding of your memory devices.
+
+
+Memory Configuration
+--------------------
+
+No more no less, DRAM should be large enough to accommodate only important
+working sets, because DRAM is highly performance critical but expensive and
+heavily consumes the power.  However, knowing the size of the real important
+working sets is difficult.  As a consequence, people usually equips
+unnecessarily large or too small DRAM.  Many problems stem from such wrong
+configurations.
+
+Using the working set size distribution report provided by ``damo report wss``,
+you can know the appropriate DRAM size for you.  For example, roughly speaking,
+if you worry about only 95 percentile latency, you don't need to equip DRAM of
+a size larger than 95 percentile working set size.
+
+Let's see a real example.  Below are the heatmap and the working set size
+distributions/changes of ``freqmine`` workload in PARSEC3 benchmark suite.  The
+working set size spikes up to 180 MiB, but keeps smaller than 50 MiB for more
+than 95% of the time.  Even though you give only 50 MiB of memory space to the
+workload, it will work well for 95% of the time.  Meanwhile, you can save the
+130 MiB of memory space.
+
+.. list-table::
+
+   * - .. kernel-figure::  freqmine_heatmap.png
+          :alt:   the access pattern in heatmap format
+          :align: center
+
+          The access pattern in heatmap format.
+
+     - .. kernel-figure::  freqmine_wss_sz.png
+          :alt:    the distribution of working set size
+          :align: center
+
+          The distribution of working set size.
+
+     - .. kernel-figure::  freqmine_wss_time.png
+          :alt:    the chronological changes of working set size
+          :align: center
+
+          The chronological changes of working set size.
+
+
+Program Modification
+--------------------
+
+If the data access pattern heatmap plotted by ``damo report heats`` is quite
+simple so that you can understand how the things are going in the workload with
+your human eye, you could manually optimize the memory management.
+
+For example, suppose that the workload has two big memory object but only one
+object is frequently accessed while the other one is only occasionally
+accessed.  Then, you could modify the program source code to keep the hot
+object in the main memory by invoking ``mlock()`` or ``madvise()`` with
+``MADV_WILLNEED``.  Or, you could proactively evict the cold object using
+``madvise()`` with ``MADV_COLD`` or ``MADV_PAGEOUT``.  Using both together
+would be also worthy.
+
+A research work [1]_ using the ``mlock()`` achieved up to 2.55x performance
+speedup.
+
+Let's see another realistic example access pattern for this kind of
+optimizations.  Below are the visualized access patterns of streamcluster
+workload in PARSEC3 benchmark suite.  We can easily identify the 100 MiB sized
+hot object.
+
+.. list-table::
+
+   * - .. kernel-figure::  streamcluster_heatmap.png
+          :alt:   the access pattern in heatmap format
+          :align: center
+
+          The access pattern in heatmap format.
+
+     - .. kernel-figure::  streamcluster_wss_sz.png
+          :alt:    the distribution of working set size
+          :align: center
+
+          The distribution of working set size.
+
+     - .. kernel-figure::  streamcluster_wss_time.png
+          :alt:    the chronological changes of working set size
+          :align: center
+
+          The chronological changes of working set size.
+
+
+Personalized DAMON Application
+------------------------------
+
+Above approaches will work well for many general cases, but would not enough
+for some special cases.
+
+If this is the case, it might be the time to forget the comfortable use of the
+user space tool and dive into the debugfs interface (refer to :doc:`usage` for
+the detail) of DAMON.  Using the interface, you can control the DAMON more
+flexibly.  Therefore, you can write your personalized DAMON application that
+controls the monitoring via the debugfs interface, analyzes the result, and
+applies complex optimizations itself.  Using this, you can make more creative
+and wise optimizations.
+
+If you are a kernel space programmer, writing kernel space DAMON applications
+using the API (refer to :doc:`api` for more detail) would be also an option.
+
+
+Reference Practices
+===================
+
+Referencing previously done successful practices could help you getting the
+sense for this kind of optimizations.  There is an academic paper [1]_
+reporting the visualized access pattern and manual `Program
+Modification`_ results for a number of realistic workloads.  You can also get
+the visualized access patterns [3]_ [4]_ [5]_ and automated DAMON-based
+memory operations results for other realistic workloads that collected with
+latest version of DAMON [2]_.
+
+.. [1] https://dl.acm.org/doi/10.1145/3366626.3368125
+.. [2] https://damonitor.github.io/test/result/perf/latest/html/
+.. [3] https://damonitor.github.io/test/result/visual/latest/rec.heatmap.1.png.html
+.. [4] https://damonitor.github.io/test/result/visual/latest/rec.wss_sz.png.html
+.. [5] https://damonitor.github.io/test/result/visual/latest/rec.wss_time.png.html
diff --git a/Documentation/admin-guide/mm/damon/index.rst b/Documentation/admin-guide/mm/damon/index.rst
new file mode 100644
index 000000000000..c6e657f8e90c
--- /dev/null
+++ b/Documentation/admin-guide/mm/damon/index.rst
@@ -0,0 +1,35 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+DAMON: Data Access MONitor
+==========================
+
+DAMON is a data access monitoring framework subsystem for the Linux kernel.
+The core mechanisms of DAMON (refer to :doc:`mechanisms` for the detail) make
+it
+
+ - *accurate* (the monitoring output is useful enough for DRAM level memory
+   management; It might not appropriate for CPU Cache levels, though),
+ - *light-weight* (the monitoring overhead is low enough to be applied online),
+   and
+ - *scalable* (the upper-bound of the overhead is in constant range regardless
+   of the size of target workloads).
+
+Using this framework, therefore, the kernel's memory management mechanisms can
+make advanced decisions.  Experimental memory management optimization works
+that incurring high data accesses monitoring overhead could implemented again.
+In user space, meanwhile, users who have some special workloads can write
+personalized applications for better understanding and optimizations of their
+workloads and systems.
+
+.. toctree::
+   :maxdepth: 2
+
+   start
+   guide
+   usage
+   api
+   faq
+   mechanisms
+   eval
+   plans
diff --git a/Documentation/admin-guide/mm/damon/mechanisms.rst b/Documentation/admin-guide/mm/damon/mechanisms.rst
new file mode 100644
index 000000000000..16066477bb2c
--- /dev/null
+++ b/Documentation/admin-guide/mm/damon/mechanisms.rst
@@ -0,0 +1,159 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========
+Mechanisms
+==========
+
+Address Space Specific Low Level Access Monitoring Primitives
+=============================================================
+
+The target address space independent core logics of DAMON, which mainly
+controls the accuracy/overhead of the monitoring, are separated from the
+address space dependent low level access monitoring primitives.  The primitives
+are defined in two parts as below.
+
+1. Identification of the monitoring target address range for the address space.
+2. Access check of specific address range in the target space.
+
+For flexible support of various address spaces, DAMON's API further export an
+interface for configuration of the primitives.  Therefore, anyone can configure
+DAMON with appropriate implementations for their use cases and even use their
+own implementation if necessary. In this way, DAMON can be expanded for any
+address space while keeping the optimized performance.  For example, physical
+memory, virtual memory, swap space, those for specific processes, NUMA nodes,
+files, and backing devices would be supportable.  Also, if some architectures
+or kernel module support special access check primitives for specific address
+space, those will be easily configurable.
+
+DAMON currently provides an implementation of the primitives for the virtual
+address space.  It uses VMA for the target address range identification and PTE
+Accessed bit for the access check.
+
+Below four sections describe the address independent core mechanisms and the
+five knobs for tuning, that is, ``sampling interval``, ``aggregation
+interval``, ``regions update interval``, ``minimum number of regions``, and
+``maximum number of regions``.  After that, more details about the DAMON's
+reference implementation of the primitives for the virtual address space
+follows.
+
+
+Basic Access Check
+==================
+
+The output of DAMON says what pages are how frequently accessed for a given
+duration.  The resolution of the access frequency is controlled by setting
+``sampling interval`` and ``aggregation interval``.  In detail, DAMON checks
+access to each page per ``sampling interval`` and aggregates the results.  In
+other words, counts the number of the accesses to each page.  After each
+``aggregation interval`` passes, DAMON calls callback functions that previously
+registered by users so that users can read the aggregated results and then
+clears the results.  This can be described in below simple pseudo-code::
+
+    while monitoring_on:
+        for page in monitoring_target:
+            if accessed(page):
+                nr_accesses[page] += 1
+        if time() % aggregation_interval == 0:
+            for callback in user_registered_callbacks:
+                callback(monitoring_target, nr_accesses)
+            for page in monitoring_target:
+                nr_accesses[page] = 0
+        sleep(sampling interval)
+
+The monitoring overhead of this mechanism will arbitrarily increase as the
+size of the target workload grows.
+
+
+Region Based Sampling
+=====================
+
+To avoid the unbounded increase of the overhead, DAMON groups adjacent pages
+that assumed to have the same access frequencies into a region.  As long as the
+assumption (pages in a region have the same access frequencies) is kept, only
+one page in the region is required to be checked.  Thus, for each ``sampling
+interval``, DAMON randomly picks one page in each region, waits for one
+``sampling interval``, checks whether the page is accessed meanwhile, and
+increases the access frequency of the region if so.  Therefore, the monitoring
+overhead is controllable by setting the number of regions.  DAMON allows users
+to set the minimum and the maximum number of regions for the trade-off.
+
+This scheme, however, cannot preserve the quality of the output if the
+assumption is not guaranteed.
+
+
+Adaptive Regions Adjustment
+===========================
+
+At the beginning of the monitoring, DAMON constructs the initial regions by
+evenly splitting the monitoring target memory region into the user-specified
+minimum number of regions.  In this initial state, the assumption is normally
+not kept and therefore the quality would be low.  To keep the assumption as
+much as possible, DAMON adaptively merges and splits each region based on their
+access frequency.
+
+For each ``aggregation interval``, it compares the access frequencies of
+adjacent regions and merges those if the frequency difference is small.  Then,
+after it reports and clears the aggregated access frequency of each region, it
+splits each region into two or three regions if the total number of regions
+will not exceed the user-specified maximum number of regions after the split.
+
+In this way, DAMON provides its best-effort quality and minimal overhead while
+keeping the bounds users set for their trade-off.
+
+
+Handling Dynamic Target Space Changes
+=====================================
+
+The monitoring target address range could dynamically changed.  For example,
+virtual memory could be dynamically mapped and unmapped.  Physical memory could
+be hot-plugged.
+
+As the changes could be quite frequent in some cases, DAMON checks the dynamic
+memory mapping changes and applies it to the abstracted target area only for
+each of a user-specified time interval (``regions update interval``).
+
+
+Virtual Address Space Specific Low Primitives
+=============================================
+
+This is for the DAMON's reference implementation of the virtual memory address
+specific low level primitive only.
+
+
+PTE Accessed-bit Based Access Check
+-----------------------------------
+
+The implementation uses PTE Accessed-bit for basic access checks.  That is, it
+clears the bit for next sampling target page and checks whether it set again
+after one sampling period.  To avoid disturbing other Accessed bit users such
+as the reclamation logic, this implementation adjusts the ``PG_Idle`` and
+``PG_Young`` appropriately, as same to the 'Idle Page Tracking'.
+
+
+VMA-based Target Address Range Construction
+-------------------------------------------
+
+Only small parts in the super-huge virtual address space of the processes are
+mapped to the physical memory and accessed.  Thus, tracking the unmapped
+address regions is just wasteful.  However, because DAMON can deal with some
+level of noise using the adaptive regions adjustment mechanism, tracking every
+mapping is not strictly required but could even incur a high overhead in some
+cases.  That said, too huge unmapped areas inside the monitoring target should
+be removed to not take the time for the adaptive mechanism.
+
+For the reason, this implementation converts the complex mappings to three
+distinct regions that cover every mapped area of the address space.  The two
+gaps between the three regions are the two biggest unmapped areas in the given
+address space.  The two biggest unmapped areas would be the gap between the
+heap and the uppermost mmap()-ed region, and the gap between the lowermost
+mmap()-ed region and the stack in most of the cases.  Because these gaps are
+exceptionally huge in usual address spaces, excluding these will be sufficient
+to make a reasonable trade-off.  Below shows this in detail::
+
+    <heap>
+    <BIG UNMAPPED REGION 1>
+    <uppermost mmap()-ed region>
+    (small mmap()-ed regions and munmap()-ed regions)
+    <lowermost mmap()-ed region>
+    <BIG UNMAPPED REGION 2>
+    <stack>
diff --git a/Documentation/admin-guide/mm/damon/plans.rst b/Documentation/admin-guide/mm/damon/plans.rst
new file mode 100644
index 000000000000..e3aa5ab96c29
--- /dev/null
+++ b/Documentation/admin-guide/mm/damon/plans.rst
@@ -0,0 +1,29 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
+Future Plans
+============
+
+DAMON is still on its first stage.  Below plans are still under development.
+
+
+Automate Data Access Monitoring-based Memory Operation Schemes Execution
+========================================================================
+
+The ultimate goal of DAMON is to be used as a building block for the data
+access pattern aware kernel memory management optimization.  It will make
+system just works efficiently.  However, some users having very special
+workloads will want to further do their own optimization.  DAMON will automate
+most of the tasks for such manual optimizations in near future.  Users will be
+required to only describe what kind of data access pattern-based operation
+schemes they want in a simple form.
+
+By applying a very simple scheme for THP promotion/demotion with a prototype
+implementation, DAMON reduced 60% of THP memory footprint overhead while
+preserving 50% of the THP performance benefit.  The detailed results can be
+seen on an external web page [1]_.
+
+Several RFC patchsets for this plan are available [2]_.
+
+.. [1] https://damonitor.github.io/test/result/perf/latest/html/
+.. [2] https://lore.kernel.org/linux-mm/20200616073828.16509-1-sjpark@amazon.com/
diff --git a/Documentation/admin-guide/mm/damon/start.rst b/Documentation/admin-guide/mm/damon/start.rst
new file mode 100644
index 000000000000..4b861509565d
--- /dev/null
+++ b/Documentation/admin-guide/mm/damon/start.rst
@@ -0,0 +1,117 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+Getting Started
+===============
+
+This document briefly describes how you can use DAMON by demonstrating its
+default user space tool.  Please note that this document describes only a part
+of its features for brevity.  Please refer to :doc:`usage` for more details.
+
+
+TL; DR
+======
+
+Follow below 5 commands to monitor and visualize the access pattern of your
+workload. ::
+
+    $ git clone https://github.com/sjp38/linux -b damon/master
+    /* build the kernel with CONFIG_DAMON=y, install, reboot */
+    $ mount -t debugfs none /sys/kernel/debug/
+    $ cd linux/tools/damon
+    $ ./damo record $(pidof <your workload>)
+    $ ./damo report heats --heatmap access_pattern.png
+
+
+Prerequisites
+=============
+
+Kernel
+------
+
+You should first ensure your system is running on a kernel built with
+``CONFIG_DAMON``.  If the value is set to ``m``, load the module first::
+
+    # modprobe damon
+
+
+User Space Tool
+---------------
+
+For the demonstration, we will use the default user space tool for DAMON,
+called DAMON Operator (DAMO).  It is located at ``tools/damon/damo`` of the
+kernel source tree.  For brevity, below examples assume you set ``$PATH`` to
+point it.  It's not mandatory, though.
+
+Because DAMO is using the debugfs interface (refer to :doc:`usage` for the
+detail) of DAMON, you should ensure debugfs is mounted.  Mount it manually as
+below::
+
+    # mount -t debugfs none /sys/kernel/debug/
+
+or append below line to your ``/etc/fstab`` file so that your system can
+automatically mount debugfs from next booting::
+
+    debugfs /sys/kernel/debug debugfs defaults 0 0
+
+
+Recording Data Access Patterns
+==============================
+
+Below commands record memory access pattern of a program and save the
+monitoring results in a file. ::
+
+    $ git clone https://github.com/sjp38/masim
+    $ cd masim; make; ./masim ./configs/zigzag.cfg &
+    $ sudo damo record -o damon.data $(pidof masim)
+
+The first two lines of the commands get an artificial memory access generator
+program and runs it in the background.  It will repeatedly access two 100 MiB
+sized memory regions one by one.  You can substitute this with your real
+workload.  The last line asks ``damo`` to record the access pattern in
+``damon.data`` file.
+
+
+Visualizing Recorded Patterns
+=============================
+
+Below three commands visualize the recorded access patterns into three
+image files. ::
+
+    $ damo report heats --heatmap access_pattern_heatmap.png
+    $ damo report wss --range 0 101 1 --plot wss_dist.png
+    $ damo report wss --range 0 101 1 --sortby time --plot wss_chron_change.png
+
+- ``access_pattern_heatmap.png`` will show the data access pattern in a
+  heatmap, which shows when (x-axis) what memory region (y-axis) is how
+  frequently accessed (color).
+- ``wss_dist.png`` will show the distribution of the working set size.
+- ``wss_chron_change.png`` will show how the working set size has
+  chronologically changed.
+
+Below are the three images.  You can show those made with other realistic
+workloads at external web pages [1]_ [2]_ [3]_.
+
+.. list-table::
+
+   * - .. kernel-figure::  damon_heatmap.png
+          :alt:   the access pattern in heatmap format
+          :align: center
+
+          The access pattern in heatmap format.
+
+     - .. kernel-figure::  damon_wss_dist.png
+          :alt:    the distribution of working set size
+          :align: center
+
+          The distribution of working set size.
+
+     - .. kernel-figure::  damon_wss_change.png
+          :alt:    the chronological changes of working set size
+          :align: center
+
+          The chronological changes of working set size.
+
+.. [1] https://damonitor.github.io/test/result/visual/latest/rec.heatmap.1.png.html
+.. [2] https://damonitor.github.io/test/result/visual/latest/rec.wss_sz.png.html
+.. [3] https://damonitor.github.io/test/result/visual/latest/rec.wss_time.png.html
diff --git a/Documentation/admin-guide/mm/damon/streamcluster_heatmap.png b/Documentation/admin-guide/mm/damon/streamcluster_heatmap.png
new file mode 100644
index 0000000000000000000000000000000000000000..0ad6cdc01e693c7954471ee593c9cfa7c756ce7e
GIT binary patch
literal 42210
zcmZ^~by!qi)Hb}&3=G{3f(U{j(kVHLpdu-VNRD)OOB_WJkre3~Kmh>(0cmhhNokOd
zQ9?Q-CFC1_&-;GgKi_j*lV{F4v)0~cuek5EU+8Mzq#|c02LMprzIEd+00<ZW2v3S6
z96``r836zZbTtjs&d$yVN3dAzzc(BJ@EH!AfsG9u8gz7kYYsooaNGb!<KQzf4Ez!R
zGz`w*v(U5Qx0f#yMA7(uf*d<LyQHL~mX?;St!-#%XliO|Wo0D}hwJX{URYQl{Kb}p
zMBGN)`?1BXdt3OkvyJH|XVoob8yjb%fbeg?n(!LR^O8s8<^BJ@zhq-`C#V8I&-30@
z@K41v&^vI(m~a-Vy9L8%YTyX=TuutyT8wI{ajFfc*xQ@J!rW(X!N!w~*I;NGI~}Ks
zzUL$gGXj{A5k?apFpR;$m^1jF{^&C-;ek2Bx}V{2X9RoBa6L6yTW4F?>YkRfmL6Pr
z&>0$g#@*c9Ot6j-kaGe?Uce;)1cZTv1W=R#>Q{k|5_o_Hma4!>9eCdc!I~gk8^q{=
zWPOlr2=a|UsWJ4?3~IE1zC46Ft)M;|=(`;>;Q-A#LGvz%B{#&H2V%<;vEz-{_eC7~
zBaZ`+Cy$V)!N|WML}xJ3*<+%!Fyg<@h)=_bk0Ve=FHi?BN%o>he#ek(#FDPWkuJU>
z`<XyCok%{GL@}65(Va@!mPUz7r>e`OuE?S;%BIQ7p-s=FOUR>(d_(^vpCO=t(Y=t#
z?j5sP5sN_ytHyh_Yo+Y6WgNog=XgJGvQ=`?RGlaO$PKD_Kn*Xby$I^~LH#ArC;*x+
zgJvP{Nf_WnK#LgoEDpX%g0Iq`RR*-lfp&S&p$IyaL6-{nb`5l^f*v){dlU5C2K|~~
zKpPC|f}y)$*Z_RL4@Mq<QByEx4#qKH!U{~<f+>42?F43A!HheY^#XWb@FM{H3<7hZ
zVEzeMcm@_Dz^|9!S1ee11(p-RN-9{*0BcyVo(DDxz(x_+ECpK?V7nUpt_M3!V7CSA
zwt~Gbu-^*~2EpM7_%i|i%z~piaJ&Rg*1+jDINbw(j|g`bVAv6xBFr(F`>h9F08oGZ
z_k<FKs5t=O2DfiqGw{z?n;v&PH~vxfFxUM06C%<e=`SRIm8DF>zLD5tE$|I1FPoP`
zo;EMB$l?5g@RzeIE>fq8uLaB~<ZHgVn>blOvitOJS%l`R%U#~%rGo}_Yq_tiB_t&d
zL`TepB*Jx+uYSEi?Gd4R?kDYYx&NP!yb*KlG_hPt!J~IPBC=f+L%dHq=bmo{3Q})Z
zMn9*CBaV%k-M)M7XM0pZY-~(SvPrDiCnbN9ms|LOfiIg{C9-!uYBn@X>Ifi}1Jl3x
zMr6xnDF<%NFZnn7>>eH_T)OFIfe*W+le4x|jZ1%fedLihWmtn77boYs8`n>(7t^{b
zS98l~X77bu4LmtIcm&fdhQ?-f&nl*k#?RGM>pu7A*v<k$6_0)w+@YUQFbRxVSl!Ox
zpS|`<`Ku0FLymHYTtTv5WxQ3Yb@ufi+pbJwNYiGskr*9&y7Oxx9ucv8`>LnAKL!RG
zIz<e|mCTrlGyAul?(A)Czu$~G&smKO3Gyf=yBflxMcUd-2DKKH34dP&G~42BuI}fR
z8vh(oTc$dmKez7GFRR_+7MZ8oXyI|z(fE+aPqpd%@?2=gz$|BF5F>odc#_XQAHALI
z@Hg=g{=21WJYoXQJ~epI;LK1b$Fpxjuh^amfP<}>TDC>4?Q1bT$7iqI&f~-0qE5c?
zp6a*Gk+d&~6z-=#+A^ctTBI6qi=gpzo;fQBastVz0W;trMmaLCZ^Hh#tC1;OW?!kf
z$zV9!G?eim|B$<V@iernCIwR2IwZ9iB;l+9e?R%n@t%7hyTupW?*aTH{Mbq0=l%sA
z6!<eQS>?|INB^DoKga(2nIJOzzl!+$Zz9?MtBA+{CbIdziG)r?$GTT3e@@=L)(+t>
z%s89_Tt740{`)wEIQ-SHO&2qA^YE4Ok{nR{st}FDsWuMP5^sezah(5QAN*8wIV|SC
zWB>CrVf4NKKOI7aa3;ybK}SnVKPFXFH&qD3v3dU_8n~G;Z?z1B>BM9QxsSHUgP>18
znQ@yNZAzB}RsN#OT71D_Nb4-sR+dvs<LLHdk^P$-p|ZG}u~~|WfrmeAT9CK{Ay+8K
zM|J}u4c3W0-x#*~^d!vVpOgxS6Ja>)EoD0JBiM7yM37tHF*`qFBS-^g%W8?^elBR8
zB)())RwkGeOIrh)8#xX@P+-avnr+^%vsASES-l*2D&=zjqf~K&hhLQ|LEY_#lHC{n
z{x~#&Lbk-q(4P+Zf=_jBeyaCz*|6X|ebs!nAnG@J_H!t2y2oN|^Y_d2M`uH`egRwA
z{2_azo4;M>nzw7~_9~Hw#iQyQ+08Ut+0-Dkq}EN*)zyqJ1swS4_~V5Eu4$)<jXwjA
z=t$u6y4`La5PmZHxNUB6q>mQQ@e^!aiumsv#N7(vb!ZQw+k4)xPZLxXp4rMf;GqVy
zLvkS}TT25&qoL}X?V_RE$+N{sTsHRxTV5<Xe(q*_w&LHJ=g)RS&VlBITDvG$Xlg2&
z<{Wphu2+!v$wc4MX)O)jr}2lf%6#99+Bxv|wTI>-a~0*8&|~iqwb?sPvh6E9l^cJ1
z|8qR2rMsgfu-nxQwwZ(T-0QnryFWhG7Tj$2+wfd9YI+_U^Uyss`6l+LsbT1tFgZzc
zSwEVH-Rn6vk+^_@vx3ov=|(dArP1Rh#gw!0^8#C>FLsU}T^anp=LVlay&gfqTb)$6
z=dsFl@pZFW`#*Z_pV0Z>W+$zpW@3@JnsWzHYb1!RmiLskqGZ{Kh3zk9FKSfoE)4wc
z`K?+%`-;Ks$^UzvFg!QyZvnVwi=gat`nUa0$gVy*vbXrT4k<V9^;~L?{ky*ok8Xz_
zpTwy=Vj(E3-=3E@%C>H6y~}!>{fQ2r{(rAUxlRIYZD%T-CBNHm8Q7Ca`sby{162qU
z;5jA9Tm$y~=1#%k{6_pGNhwBn^izO7!|yiiXwZLy&~gfZa^0h&XEx;OkiXJ+vxj8&
z|9k1Ejbj>uIl^KcezE7*(&H`}fQ?v+;GOU#S)!)%Bygxw$hMX8n9`R=6c|6*84{Q#
zd34L4Bu?2WUG|G&=0mO_QCH4lzmvnI#k^YC)}X0&(GcA6armR4vzwu(*JiX&lF#<r
zL%S_bQfPc<{imh^b)df;9=q8gity&Q_}ga-p(oqtcUV*w!=`1qWNSkB!P#?*(}J@_
zm9rI<(Ctal(4F+zpl#ydKfgpj9a1$Pue*ir@VN$Wx4LbsOdb8CI63%}{3$2<G<;*L
z&*EqL?8&~YMfX|ApVrWWg_GwNA=gwst62P%RAT3{e(~pn$7tWON9gh7pWfZjqq)B2
zfGs0`1I5nYUqlx_eV!Zg+xgkQJ{uygGT&He5%lM3(#E&hkgK91rz^6%#b<v*|E^W`
zsT}VWWQXi8+hqsuFP|*z{AnwQun1K@J6qe)@%waiGSs)+ptJ1edvLOM(pQjuc2vo?
zl&-TpnjPBQFjS^;`cpD+S5&z`VQB8>g~f)@$md_mex;9wp8P3WUj2J1`@do6nm%NO
z{_60j^gr{xlKQPP-vuw47co%(ZD!%yo%S@nzb|xTh&HbGXOfOIl6&TL%dkw24}>cl
zUSkQi^_-hi|DHLgS~XI^YGtE;w{vMN@m8c7N1EjwSyxqEUx9d8*EEAaR*dx(t&;Z)
z-oDn-l#ai;TK_)!u03Z)jnDaLzsO@&GZR6<&w|O55`0`usXqm(c7m(Vet%;9^>i=t
z!R&(qeYbfTxwo0O+oW%A^UV2X=6M?Ll+;+B%lw$*9dLP%@nu)(_<m63%4D(wWoG*B
zCyw`W$pg1bU(R(i<%Ma6Qk$zQiZNrPqFwymt64=}+o`?t?b4E)^>%hN5_|O^DeA?<
z|Ggdh=CHX-^Q`nj;nK+xjZ(QptLjnB!44O*=byznBt+dEzqlOvaf)M^6jPBmyDv_{
z`TkYT_KHn<iG!C+YNrgp4Ee*1b<^4MbJos*HAzHb9QjE6n7!2IUuj~C%$uVrFv$=3
zqx##B4u2Heqq*QmGZVfM>d)H7Xst}%v%qEb4wA?#d2zsK?bC_4vFK3s!?t_5Rc#W$
zS#!NgHjC}N+yRTkewTQA-HgoJUn7T83nKSQh4}#1Cf#SYajlID^iYhmx70~KxNT>`
zmlt}W_N=l!Fh65KFt&SHlIvA;m#w5@vOkOEItOAY>SLSh)BTo7|9>mxC>2O)|7jNX
zG%$XHxqPoKxy}1pLreXd1$(QgO&`5yWD?I@ba$_Uhz*A?@S26N(W=9P$1652Q4Urz
zxvlbUwQj88SKbQsA}i~C?>p&r)%whkGKJ|)W4!*<l=%2;obx38O$t`(x5;jgkLbVX
zeRS_*<N8+F%RyA?<UPIzaxM$S9`*KleJo!DYIi!vL*G$)##jLMFIpyb#8@J<YvT`>
zP{B)xrGWm)>Rq}Qf_`R?V^IzxGA1)^)x}UbEza)e6zR+RBZA9hn7g8i$)Wp#-9U{k
zRn{qtQckd2AZ+_qW#e%EjGPRc19uSbFtgK;_dmlm{N}8P?0N4iEk4tG@XWe)<X(Wo
zxkYP)(MjS5P#e$T7Wq^7cbcG#`<!;_c^0_U``uGzizFNcNYavWA#Ibot008$d}z*|
zFOXA}`2D*EqpWY(=;tkrf6bm?h_uYxqKrr%j1~o)tDaxkNG1d*<2&snan3=Pv}o&s
zAKqZn78*xlqS>}&(3(k!7vL=oioq3XNtHoCpn)iqFgGaU5hChOWDJw4OZTLG`(nzZ
zS}k9ns9z0n_`H5Fg_)E)9im=Q`?=Bg!CUIQm?3I0o<)4<xpB11Wt7(k4+`82zEy1f
zndsXc61e840M>IwvpSECpXFY9q*+?MYK!cc%%A8F>u-YuE3b9(P3ZB}3%+jpJw%Nu
zsCNeCH6n~UUgL}=Q5EIFI@gO)3#kjL0~$Gvo@+(MG`=S^R*<ejaO8^+)Yv`xPo?o%
z#*_Dez>nC;y?n;=Q7WlW+qZ`|i22o<erwX>VnDc*Ydf7+uy)MZolX5AW8i%aSLMJ+
zi0A+;+9r5a=kvnPZX)b8=snlHrsiq;&Ouf8(<b{{ll?V7Rp>40SP=%?h)K@y+kkk@
zg8~D3^XJI|PJH*zv6WjE^0L1c&^u6`LUiQ4qssSfuKSmKoN9s<y|n9q_X`WSA!Ioc
zj5m5r#{CMi6-tfYHDB_5eLGj)86_Ez0BA$?Nil2s)dNUuoR%e#Zc+8V(;ZMrl`qyh
zNEs&^#{Q|eBpu39m>)hoj)(Brbq&ivzjr9K=$|5)Roz!VMzV!L`zCOw%`<B?BsPD+
zhP{1S%cf=we6?&JG|zW@`Mg|?9Am%{!NTNquMa@e%*tIy!F9yeMSAoZ=Uh=Yct_S5
zy5xA}3Rq;r>LxE=O!a>j*?alTcSQbOafZ9ClXY?K9q(MB4hraXOGycPtsH1%x|xy6
zHPlMk&nVc|tC_!|o}Xwah`{o}^*X=V08b66N(EhGlrcd0TmyQie)&-;r%%2M?-eIj
zyy5`oJcl|3F_ATC9&ggIZJsgb-hE7elVI3BOVc<Py|%`-a!1qVL6dz~e@Ri}zMhF)
zyfGPmEcx~aZRe6*AaHrchsZsljY{6)4mcZoQKj)C(ee7$<##8FEA&2-{(AI-OpBl6
z$gme-Z5Jk>J~ja`pRyz|f2$4iDYyB!A&fkPlN2Z&xT#<eydiN<&^vEc!s-lyMRFgP
zQH?O?cttZ^Bk7Inrz&D8!Gc0>Bev;0^8e<vwP9NiA?0%ce(MgbhsGYf?w&U21Cl@;
zFy?N)h0u+s%C3JRK9$=-DZZeF0!;%mXTDkPr{+-rnB~<OM^5Vx^$+~w!S9_oQoN8P
zQgNLWE3tnCV4{cjo+Q3Ac6i*zZspMAe$u$3dK<{SaGRslg)kT3R3IPT`5GAhefEV{
z_Nvp&w-W@YbY*wDW9j3@nl|nPo99xXaJj#WdsqXRdF+UES7Si#+X$jK2&<n6Dcf;s
zA~39GDBR}Op@<CmyLuG*brPGF7G9bcPA~!NocDWAI|#LdP>gRv;0f=bzk<it$Az-4
z0tPX~l`iKwH07s>E>7I&f|tn?Dps1}n1Rv_*MQ|HCqAG7=I=iPz8URup3=xQ@>8ok
zYcTdl<IywJ_1wVWWa`-W&B`>Kz!6jde@p)#{<dJP%9yJ0UP*0H(xT$1%VO8dj=m#I
zO6obo2sefCDuK<5?c|cfrP_1P4y1_d_cj|o`gQu0id^Q)_vEnY%%w6nd{_D{V;!P3
zqXU=g?xjCO9ZuVlE8R31vEO%bIn97<1jGvxxYW=drmTG#H4{|tR>HoOPL_{+%$K8!
zf9+!vKl?ta^DRz~nF72v8+1aXj9%E+`-@wLRfzEK=lYcY%(r}@q351yZLvl~7%*11
zDr|Nk;%uojokY{g^q)WMxC)kT%-D}_f3<}lYV6evQI=ai&Os;Sd{|eLka;#Ej;NJR
zte$veePLpWcb*Ez4w^=`ySJVWPD7aCcM^@CZ%oqRBzsKjQDYyOzh6o!O=g1T8;25t
zsPN18Kk&d1c(&SGJY}m_@s%+u;}$qhiKnZ{0=W$JROQ{Em<_Y9TAu+Oc}rZZsSu!v
zl1qoe*|4649N#J9IKDL6cC6A<k$S4Ua<XHF_1;gHBbP!2aPG1j3O9EzwbPsriUS{K
zkyW1|>;UU3F*b&4L8ZZn0o^7CQC6F{iQUZW%wyMWr2^^*doqkDD6gQ`xK94z3V86=
zYD;n0=ej3GUZ4RO>=8>~hqs@#R*5L(W5QBD#S^)oBgG4He4!Kr7>($39-!V`LR9{}
z1`OIdBS^_4(dKd3(VnOLSnDr0yhBWZYrUm;4~Sl3h65luI-E50x|1f}u}2eBs<x}L
z^-IYDaVDz`T?j;<f4din<mQEQqTin%qjZlfYC<i2)gjv2&eKu81t(b`olR@6Fdbz1
zApxp8H^yXmdZym98Jw#)wbiIlP3`HS#us}b>@V{_&_(^}saJm3tfp=TJZG4{IF+)h
zczFP{MIQ)I%K7Onqg-?HS-_(IDJFa|5S1cSb&KFf09<tK(Oh&qAJI)V!g6w^0%;tu
zdEJnk{9?l`K-D*J!6g8^)(TU8h#JfEHY+y~V*2&jk72bzet#5bA#gmIFN3+^hY;(4
z?vGD&v83?ZvOp)zvS9%4{>Y*qxWg8hLzVQYyy%08XjF>WcpsbYf=^7Vv<elvUi%9P
zxfq18(6|HI?-FO*B&(riill*jtIL)HBoN-Mlg~wLD3ihOfRM|C@Zmt_5gaD@Sz@(^
zQcTEOtd(++$6-O8bAr(g)W7isyufi*j&X}fj1GrI!)#>?UL~Z$@wHFHQl{?{^+VYA
znbtLc8Z1F#mJ3gK+pd7DJIv2kR*QCmqC+~<C3ED=4Mr=K&5@1usEC6WdUOqPX<!d)
zoslbP$nnXeHTSWe=M5e{IGh0;$Cx5>dDgJY_2v}U0kAQT1x9CR_^;~}NnFg?A6iIb
zZVv02{POF3t{3fio@3{ZZ4%epXtn);2?Q2_Rwg2bnb)(O<A2)1PbBd92HnHgJkIN?
z#X!<;%^JjzYZbq`QXz|BMgwv!@?u>^;Of(ru$;}-d;wm(azPC%R%{0^IVrR#28V<b
z;YaFT{b~XDd)Z@kxqY_sita8aoy@?artS2YVD%WjeD@h~Um7X=zKAzDxM{|DD^mVQ
zQ~Nez>DXu6=jG=uc8nU(&!htK-9^exDaN1p;GFi0<nV;0`I4^6ik{;*icOW5!SK@s
z-tmTyZV$F6$-pCofX{$LC6`Om>21*4z!@3=27-^Eb)sP3;lqpK8;4vVcz`7%A0H5A
z2%%MheimfwhO#*TP8`P&xVOMGImS9=Pj1`&F}()qs_=%UyM3pi!%%6~I_8x!qXixA
zf=+HIKPgs}9teTm9%*zdh8URXY9)Dc22CLqrNI&@=4t>L?4Q<l`VeJ*0Hh;z5D@{2
z<cNq%n*vB<6C}5HGV0D}QoMl%4=fFis<I$<E_D#qL(N^JLk2I|H)>I!`E=r-_pj7w
z(V8u#zolb6Xvzgt0mC=*^mQG`z0Q2^IcfiI;NIMCr$IGpe0g<FJ}Ua7CA|PvtOtLI
z6HE}n%_XGR@+BkA$}ZQt1|NlkCo$yas%rvz@pj)I<iB1*KpEcJ?|YgmKRVt!_M{yJ
z?Y<o>xo70S#flVT3Sl6e^1a(B-O(-%EX<?sT$E{K!}+-YYYIw9F`<7w=Q!mvmC!El
zQ=vgueIhZ&_^>I1)soLizEt*#gVHK$HN)XQomJ*HHI}acdBoWM;1r@z{*&4}ILqk5
zM<nKTbacKbQTaoEmZ}kFRAH1ybeZHx*B!81F&czo?ayc38Jzl8qzg=GoxC-Bzyj+W
zC^RSse=(c+B}XnWzyc3Q|I$#6j`iVU|K|T%5^dlRBY}wmth*~gD~X0Oj)+3pcj*wj
zxp;MHCA0lwtLJs$RE5!jU{~teN8beD@W}L0K<(JUeO#8IUnh+$VTOw(kZV8j6M>MC
zk1-jSOB!VCQRD|~Y62ew{iuPu*f2f0%#t{&;H+DqT?}nk_$FR6D~%4Ur><0<m12`g
zaJ6Yr5gT@q4BUUXTEhuRc|!Jlm3sS4YZvKN=*1tEu5hBCJH7^sRNuoYhPpR^yo34n
zKg=tsf#blpB|9jE%^fNf4+Q@C;z^hNiQ&?P+kHUcttmJBBp=gkncmILl~9XX0%Gqt
z(FvT!D7PCXM79c`q+jX=h{}CuEZF)j2G{}v>HJ3n9~6;{6lfHjtLH<0?@6xWI4AC|
zOGfwgNpno8b$I580t};IP7U3;ECyT^$yiB6$r`1uHH$55U;UmfmGRZGKI2=(4u*l7
z2f`pcJl&nD-$jw#7?cbQ#H4~FPPA}cv{trF{N3;Vt{*&sfGbjy4kUJ`O<>u$2OX6O
z$tmcVyjI;hXzrIORW)Jtx`1B~rD=cdyMO~yl#q*blLH2)AP=gU`!=N5Y)D4!gM8i?
zJ<4HN+-Bfm=p7(w1>}rB$d|1@m{LcKA+c>l8Eg5ekcKMAd#51mpU0i6VK1G?D2X0Y
zAK`dW&9lp62VPU4omTcPS{zkCxOrp5(#acJ`1dn$p^xB(-E}}Rk=Gw(gC-v?2)ce>
z6-4iVl$8-vQzWB4zzx>TcDk@3UoKsU`$oon_d|5wkpPIhDyNEk(yU4O0!Wz9$S~`G
z9%<YRbxPR%f7qn3m+VH9;nbz`0_e6eX&l#PvihFLQ2#s|HVO#5p?PNvlGw1H-`HK{
zzpxPQ1S`r-zsag5PSY^H7}+tz2Qe~He9VFfaZC?^e=9EY?&MLgxI)fHWs3TZNas>0
z_r6&^25UsfYNLqC%|<Pu+KC8G^ycI&9qz9qRM_m$qmeRy`c+nRhZJsF|83vaQq+Co
zAW0~d$pz`rz7&K-8hBt)cRA06$J5S;O~{8~WEb*@bp+BF+*IT%4-_jIcQ!<AC=kQ;
z3{Xqrl-ahe5GVM#j;g+C*v}6oM_w|n8sWd1HdXc5hVJDA`|D5#1nzqwpsjSh1|^z(
zDIu)*UZ7{0U11uf-nRUiB2T|)2wPhw-~H=>j$w(;`)tUz_)&Y&pm|Q&4fE49FW!OC
zZV>P3m>>Asp;Ie$-_nAEP)_rvxsbqI>uRfxi4CYQiwFC6!-ch4n*UChC%LjG2^tkp
ze0-Jfhw}SG+5D<bw)K{z{Ah(hU%9&(`8gn(aRD}VH4JgRo~Geg0L1Dl-;-0|o~rwz
zYRTD(5s*|dmZ6MtL>Eyz1HCpDxKO9@3N)udNf)Vs8wpfJ4DOLp;M&3qmB7zwH&X7&
z3I3-}uqPC;8&Ap|xsmaWQaAN4ag9hCQ*fJ);~TBjxJ2@MNz&^p7&Wh--yS@-ET5ym
zg@Z+6?mM7%zsPm6RAv;|{3;{mHVk9KIQfAFLwa=4S~_9c`adJE?i>vy{({9)NNb)4
zw}H>QM7Axll1fP&bb3UEo}uWwE=iB;+9Jk3BX8n`MXmr&=!W_n5$%JF(M-wrSy1>U
zWN_v0I@tS%)kW?<^8o@Bj@abE;ld;Pu+r+b-y;r<3;yki2tpn=RiD@kjL1mfAD0)i
zd^NQS+o&!IZv1p~d3nx^ULx}jaMnn=B$fQIHxsfQ0s))O(gu^({0hjZJ!1Li^*^MC
zOm?qNJk<oPLR><(0oxtLB#j1T5iqHQev!qQnPA<Tvgr2=!nWN7nDjtzeOn&*RSXJ3
zU-WhJGF(bRNCG+jc2ew`!meCnfok&QU}U*hXvRuEA=jLQN;Ed;(>$a!glxpWH)E1O
zj8g)y)!s#BSg|u)O-;Z2<68v+;!lb#jf)(f&p4~3esX&h!kDVX)+FTk`|5F!!Lvq$
zycnx=lO-Zxb%6`Jp{Ei!;|~;zc@$%fMu+O$H3mome_2tVi~jv0_7@#+pjja1*6N|a
zt&jr~ga8?K3aS#_7Fx(7Mz^<nx|TsBM7q;JYB%0%M`1-()~SUVwuK@B^#i}LL2u0R
z%H+KZ(tHa&Iq#Y_fGeXQkp%5S<!(9+tUF4Dp(%i20OcsOmj;-Y#;sFx-}wu+MB6CK
zQMhvH(&Jf!IG1&Kx<;dC*91nmWs4BT4j55WAF3@PAFb{XlDNzD+N_k+gZ7I0oD<34
zo}TMey91<Egqr3$4KHbzYW54$TW(9@^e)u_QwvaUip17Z^;^*6Sa~6-;H$~5Q3KD|
zu)Ue)1TXP5NDjG6)L+Bb1I8)0G_P$_V;Gx*p10-X(VV#gV{i_{y?QVHhaIzV0Fa9&
zcI8<{GRSU0fHe~*hJR5OI}`F_8r@!S=S%n}PHa8Ld0w=`h_+GcB_^|j^IftCkofzt
zj?34;5M#OXmgbk9jogiLjPym>OL4T9lh|vn5N&#S%ipj=J!ln-tZsiz0;dF<QNCC;
z${eoRTsC&ms}`CB_-E9z;ANb!ij`%aEldSsw!0pZhx^6|$|VK4sw0*j*crGm!%=`e
zyPFHs@PM~R1oTkqhHGp>KkYV57`e)SO%lOY6UcMK!83OUw1+Bwteguq8zhCbSi{?h
zORQy#*izm{PEsn%=BS4wamE$*6<~h(5oaM`u~;wW0u%5Z!aI3<&7|1X3)CF<Gy5uk
z2Z*o#e!r8_WzOgr_f38SP^T!$c4nzvY*WHjJOHjFiE6Y{a+KfZZ@ipR2LrbW*?fYm
z!aK>e((h_Fe&#97AAr6a2=u%JqHqk+PftL1K1Pf~SYMgU9L_@uu#*9uF})`}?_WfU
z=NCjoEVg+4C^7z)L5gjX08665&zMBDf+treff8iOfcB$upF-{$GLLivmy56fu`SF}
z11i|C@uuMvpo#()txQ-LG3o}6t5@=h>-HxH!>jXB9jc@+dq3O_a4TdoS9mr+f{P1l
z(#Vz*==i_A07-diWhjIIq{}8bXf9;CWJT+UV$CenBcem+$n}^_v4i1Ds6C@AMEwB)
z;^vDn1!a8~jcva?pnyB7H5kxRBuEgm>tO6#c*~)ErIH^v#R+>eYFr<;OFN7F+Zr(<
zYcs!HktT_0)p0S)S$tG#`Kpt2;VYtiJ4V~ApV5m1PY#x)cokqlB=#mdl_68x2oY_u
zW?^M1Gn~$bkwg+Ac!}v{e-y05)DwiI3E1F>O*i@J8WaTvxb_R%cx^Eb`Te#s7|pq-
zuYW?{WP1;6A<|cpXcCrlZ?!Zx78bZLDg@Aj{$jH#Pn6;C+jwDqV-QsvTSX480+}`j
z+#1hf8-@I<<yFZ9!>FmMlh<H^6BnYHtOWSMS9#ixN?%~vmVkkr4^1e7b1(%OSFTwK
zIN#g=w9~QiYm}hQSL2us`+@0x*rzI?O#>u6?mRDz`!%!8hS_6BFV{vZz(3be+(CW7
zqFUZJ^#LI({xb^sLf}E!9|*rLr*S**{OZpX2OqsF1s=QAM$+L1;XFQK<q;EWC@fpT
zufc90x(^y&-Agm=ZxQ@b@!6Em=mv{rWm2S@mfL$O;2&Z+{EW?kJijkG%yYbEV^vbB
zj@$V9HyyEYW069#P7$Aw-+JvCS3zXS`q2$mM4>`=9bHfLM`ZBuy^$twN!;a!xs<+;
zkx3Ukp8YQWr%&+!xe%xd^DI5Q!>i|8F1S66l0=$9-11J<*0_HlCAw;dKkzl`oLfH?
z`fYDJF}Lxy^#`%u4>2H6$_FeN+|}oS)jXUw|IL&N1MHI{SzC4Wy>~Ia*TfMQs8jur
ztQuF}t1S#n>|Ww%lu(&MW~BI$b%;l0er+8MIKZ&F`}EL->UiTDF^Z0=m7r0otRfql
zD7@b9j1tI*vyY4C85f2f>xtu#n2!~uR7+|K49kVOQH3pcZh1^ATtzA(LDf73Ze%j0
zduba1`f1URHD6xNIb_423+lDbt(P>Q?AJ0N0=Pnq4xQ-%CcnaX;os~SzQp=rNp!gu
z0Vn7MLzH6e_!~MTKR#T+9sEaNOF|ttFJ;h!LgR5q{a2#ik>Znn;ylrUl&jR-nHS!F
zxXQhXRWXpnMK?oBcf-SAvN#r|Hv>~i^6Ow_W+*=)Aq~R&?dNKdy=&<bST`h515{r$
zU3`Jbyb)RdZI@;e-Fv}<kKjdiY)#c0NnGOj>$<kzb%@HxVgNfLWvQcpjk`~4eiW3^
zldP138-wkR7eTo(=widCR9t{_jD(osFO*x23*P*(qaeJV7Oj9>)2FVVgubT#<8ath
z8@9y}28PKo`TCE$y6wNL1Z;MHj`S!JI<>cYgLJ*<({h;I6+j~PZr*$v!K$QwtCbC3
zsL3I{>e-_zBP8#jQS>Zf<4rYKnzwF}fii_&8I4*?U10v6yeo;8kIZWs1l-1t+3>ys
zV5zoW=KYo_C|t6)zN!w^#22rXR&KF@PckzsQc7<>kpfl(aCHu2f5NPu%Mqhq;%W79
zC%K8DBZ#Q{MazK_Fb5cZ*onVSD+5w~NhEgPsPS%GwGuSkgQbF;yYHE-L(JjKf+G$u
zxk?150G@A9afkx97J}y*Alz|Fl)pP(65&3^PgLza-Ic|5$n+K%s59Hl@j+FR1W=@7
z98nIT9iV<B28EWo5CxcfP!F;Xd!-@^Fnl##wCLz&>)%UWUV}2e9q;ORVRe#=1)R7@
zVQ@)Yr)APZ5^0dO|9p173Uqt!29-j{#zS9}zb&7wUyK^N8&u+`Zs*fa6vyUK4H~Z-
z#{^74l&4$lXlmF78e505SQhezuNxBSZkvEVR5&icffyq+fpn_%)kaC8MgQ|}1RI3i
zg5EGBUzBon%Dlf<ExBKTnNfQ&WZWrHoQM@Z8p#>_#jam|0X9?7X>kIKSzzL&^H-RC
zRtj`Pnp@yK_C{{_g^08AQ7EW5tf%T%PcRqTOm(p4t$43AE7#<ySJ$zV5nOK%qP#rl
zsvR0p`vYAmZacI<jBO(BFA*Qm=5=D%9L;p~|CvrmrnGH;gIn2gTlfj)$|e&KBmT!g
z!~!|ipoIHalDZg1V3;_e-CstYyVbrBt0Kfm6nDD@$!ZJhIpi>?#!otlzFFMhlfGc|
zUjqko1IPJGI4?$RbLoNGfYOqLb~Aa>yTW}w*9orfFBPr<<}T+z%x5|R?$V${7&c9e
zh_LsQr=?bn6t94B*_BB`CrwOVuR*5p^yo;83-eyY&&@Z0n-6ytDdFV+l{>Fd<7<qy
zrZXUysx@|OrPI(KiS2y4+quDRYH6<~pmTE2Yi?ILhR<T3z}E=|8NTO}AhQm|YRvqL
z|0&qFDmDF4_$utR0|_Bw@33JCq4I1=3_!2yB3A-QbVsM&Mp9i)N8(I8hM8A%!c0MK
zz#A)DGOSmrY0ib)hTn}I+rjKZvF;S;Ip99w52nO!6F{JOI?(R(@YbUgVYB`)>w)}`
z)>`pmNkEyU%vCxH1Y~()ieA1wMx9<$o2In@^6J@-ZHoC9OD{qh8XU6cu9lQhttvvh
z12U56VL0c5lOs0LVTJ$r!l)K|eu?OPNnFSciAopyw`#-%ws0V1Z^1mU4hW#L5h&WL
zUvfm*gYr#DsLICXQqKY4g-ov^#yW-CWnS=;A(rGd4;YHr5r>~8AFf}f^etchKhCb!
zw^8z0OeQf-vOqsN9|qx_d&E??9oJmo`;M~2d6qgNF2;z6jQ|o_hMIdO>W>oeGv;G$
z7a2ZGWQ$S0;e#_{vpABy$qJ(=A<Ai4{#faWti5^yi+z3DgQWbTW=pU`!RKHEx?yFJ
z|LdbB@FoxD_|PW7h$~80c6Q<OOn&6|Cxhh5^*%`V<C^vN#3z@Tn%pI`hZ;rAbie|d
zPylHP1NM(VaezoyY1MJ|mqDs!S6#NjN5YjO_%mef98raKa6HAu(+LP$-E^-T!jER%
zUS@{>{Il=-Omr+AzN@POX}>2c!tUCz!-j85d_rmO-R=tp#EK~dSzx}OTH5;3$aw`g
zE9Z+YhgBUjQCwbGH9yq{rHAqbgyr8d@L({UJ2C}Y+2Ck^aBs{@CZ(a_lK4^JGMGN*
zcg042rK#+@W7d;L-JuldDy?fB_YjUZfdWuWY+EG*s~B!Gz%5^5>^QGzD-AqRaQfiQ
zG($I#MMM5FznikZM~E7FT}snTPn_VsG#&^=d=!7Wb5xQE9kF4IfTIa1Hb%&zDs<6;
z)n;<=JZR>+`KoxGl9n&q^y<sx7uwqutcjiibo$%&#<4|?B<}XU(ioPbF22SAfse+9
z5Vndfnlf-&s|&@)3N#+Cy;&j}{<Xxp^DG782{rS4_`E;RA#w$BZxYW_Ei&~2YjJ1x
zH}eUx=u;wCI@Z3?Hrcs<{W~31JbUg%I3<J(`@2{<M<fHvUG~2)O@%hMg`;yS60|Qr
z|D!7=e|(3`=}ka_^$ekNO(tJ|A}#CKG4tCCd$juL1tdlXxLmWkPDqIcHfV9*>oX^O
zrk|St4i^RQpTU=Ot`8nP3k~N<)XC&3`SgEyTjTsvv3(-<S5qwGRWe=Q=mLaz#Tltw
z?}bHX3}pfPpG9U=DJRre%`b>JC&U;%P7c|vEs^?KpTn-NF2+X4kPxv>>n_6AkoXkf
zepwQyfxxqtL0z3=+WeBpwc?};oF4avvYvx65im!E6NYZ+iMO(hvh}mdw=7WVCTVgs
z<n$G4aVSY(Qe=ZR2o;uTof5j)m*rB?3fNkG!vb@PGF^`HNrPNb2>)hBq{*m$D#RZ%
zrHGXJ>^z0oiqcLcD|lh|_P;Et=U>ro+ZH)a1a^1n>R&PSB@aFo%#S*1!ivdiRgU<Q
z^fv^Oh*@j4oN9E?n(UtgiCvm>xMT;3Kw<A)fh!6xN%jkVNksMtECo64-Vl-UAk6|<
zOe8QT)SU%N+nVXFLs-9u68sIEH~^cfy)g`{Ah3@c4X8pg{8O%sBI7$GY5~e?KqHJ&
zKr2CGo_E4Ph~9W}Vj*PiGJ-WpkQG=EfKiZwYS0E9k|2cG@G&5tIGU4N)xELAzFzr-
zajM$TK;R+d{yDI?oedLvqU_^{S_*dhTA%ug;WyYaJQsZqkO0kb7w5Tv)|apN>2Y2l
z>an(6zeY7OVnx_|j2JJ5^d{Phr9eL_<tUbK8b@}Q?r{AnGWOa~pXj}!P?j<0t_hf+
zH<T%hluM(4wLOPUIvpyy!&@ozjnNtO?_6B70Am-@jq6?M@`L?cU;jF##$OHYCxIb0
z_bXCo>WP|_B=#k*)0NP>Hw&mwYiA(>0Lrff?WR19A2}>$!@jF%4ciIdDe~P*oD04l
zX#%u?+%93<IjUV{7Qoh?T;vDA!kU4nC3WI1OW8voRF%yEKJ~mMdFBv*ir#Nxy!{YD
zEc_cAhBAINftXumNa*F`P(ET{NGQGHt22B<EUT*?!5Tf_7(12$nXS(=2XxqcFKrN%
znI{HJ#&^Q2_-d*?B^McAoNq+bhJzv}*bya{od=y2<u2>yFlbJ=nhrek(tcm9*FV1I
zrDlgsC={X38=`c*TSlU07kvTtwa<5i##}+anK&P6ln#e3U}t9D?06>G^L6FgL8)Kk
zHM^m-ddIxL<txD(LM-roa~Xf{M(MUgi4=CwaGtuHP}%dLzsMBETh9^eSf$hdD~9wx
zUE4?VU21%+T?3>7p|R(8=vZJ+lJX9HguvmQae#G`y3Zj<#$8e9XA7}bm=ho`4Au)#
zq)Ad?g&(!)k_FGt>3driv%s!Vb?O{B5}?`-njq$0|B+`0BlFd{3`OMYZ$yiDpdy~C
zT#QB4&qn=`!Tm?#twi2_%%m1dAYOtgS=j3s!M#kGnaF(K#CIkH?Zvm)xQkdHv_~tm
z(HF&KltF)SnRJAnJ%-32RlDt-wz2o_+gEGy$r~tZ^?(2p<bI-*#8JGnh3jOKUDC~w
zW2tQ1zwY*dI;8=YMm{)$ZIl2`!vd$iAQQsT`Z%8>SFIAa|1x@?Au|hrm-qML#P1t_
zupyLgPGSom#{PszT_#W#zW;zP{_nTxn)u*#%sPVBn+1L!^<pO+1YW&WN8(=xUW;r(
zzbh|rBiWfxZh-iLnhu!XAgl<M8@!fGRrq6uNQ|WWcRZlJJwm9%s*)W^ww}veAmo4|
zM>9k@Bj%56gc7qQT}D*7;SMz@Y?T4BuBtTG<A_Lsl0;0mWh9uwSd4uy3x03dN$B#7
zawbH*nQh_kS|9KMTj#ttN_w3p2$53vc2Cy}4S9*@cio1~$Ob+kaBX)w6Jmd<j$}nI
zTE5Q2q^yX&LV%r!KL!Zw7q<^aDZiM=5lsZ*3sA;f8s$I;+<g;v3tq_BuM%c5yE#N+
zkX(H;uLRXrz=qLIwnWvoMV5DF5gg&#_sxrUdKG{a<fP$n9f9-8Q&qod=ryih&ox8o
zek1h(`}7UbRQA2j6zAtWTfhHI(4o(eQ0ZpdO>*~2@J7{*1x7IX0sYIuXDC3-5QK^d
z*#5lDhA$pepRvR|9fK(MB-L0roIeL@wUaeiia5TQrD4ci8MYCAhjM=9`5T2#(bobN
zd=vYma5HlrkyJKfgYoGDKtAnh!>ZK+{HbGeQ8;_Z9bT^TC{{wx@kEFM2RBJ1%m$c1
z>D9b__Vv>B>G>;=6jAv<oRu*>f@?W4Q5sVens6nJ))o#QdLA1r$@-%GhEkC^;O6?~
zRtm*Lw>=7Ljr(b>3c>{YF4yEpV$Oq^$UHHm6j5B|$6r6Lk|dV2vEiTT@NG%AX;gH5
z2mWj((>CJBsicvuiJ_~<OZ8MBV&7m=J|`N5POoK1irI`S4w*|B<XP3=nQbX^`6<Sl
z!}Pau{4BkIl2uBcX;vrFWgr=~x?`i7Y+^R~Qrr)rzn?N!uP*;BFK7lqsBO^*wAlu@
zq2XO-zjG_M$=MEeKouHM&)ycIAk@S<V3J;A9GZ81_SKCC_>%3tJ!-P*v^61<UuwL|
zYx^W*OaID)RP{=`S3dh)v^YBS%?Xagc7Bg~4fl(%S$ej#Lmsq6vJthl4JrQDczw`|
z4KT<(FAY6q{8H)L_iTB7Y@V3=AlQKEVC3OlCx_w>rO#H0d10$-#wA*PWZYlIP%Lw8
zBWkxlxdzkbjA;Q0;GLx{lDenCe^pu|f}f^rOM%i=o%!esWxu^}*e1Wc!V1FuOJsy3
z?n4;;1q}rH{%?V-p?4@qjK^yhND=klw(b(}-1y>mZ~aEsKf>G$6o~}c-E&+YnE`L4
z9U;<XAtoN+`XE_V_vZl@VZT`T@YRynh~PWFp1XEmm+>|pXT#T$q=;U28FT{rAtThG
z6u9rxhd4<2fA*-9ovjtpxC)z<MSs6MRJSg~_qeQ&(A*Zz)yk0>5bdG*Yq{3(TxF9S
z!`nHlOD;};R^ND(9<5*v)?Up!F$G1}Tl8K+TG;UF(L;Ez)HHfF7Oiol=EKXsh|1lT
ztY`YMPQ&}_l<wtMpOFKK%+Y7sT+Ky#!$`~*X4pRHeI2Th6XYU4c&t>v&E^5WiMh>L
z0uxE$Hop~xZzB_~-)PPHAHk)Bl=9Ts58MYv8Ht}puQ<2~xg5V7;IEg9FrrbdN)?|@
zN#uo-_Ip_q922g6*_X#Dui9lvU|CekDgGV;<skH>O68DsyPKIgN(-0d746@gQa&+|
zFx{#^cG$wXd~jD}u8X}b90|0$s+j?YuQoWP##}olfvZOroxgh(43nQ;6PWN<15Ng|
zr3Y+cZ*@OYmREkB%&AJSY5w4{CF8afSBN9!o)aoT&K<oG0diP&6EFz1b*@2eoam@f
zJ2Fhq6&)Lrexk&7Pg^sCSsTNlth@Fiw(uN6S3A+YE<pkQRj;qKh@TY#&Mx1d{<TDt
z-}si(E#`gs=8tsKtKU1{>j)ya6HrQ%h&W%fOelsE9I@ePPOcmxA^(&49|K?7+sjVZ
zMwr$X9sK-`$!u^p%cge{c<1>jF(U$BtMhxqOK0eL`V?SA2K0>Wa|EFujCv9DCvy`j
z3SS?~OGNHtP}FUMXwr%wztaO>O9{2jSi7wuXjAIm5kogVCA?Y=M37QPYbu%TRorF0
zy6HU8|3VF!%nLc!+D#6vXn|8o!XhFEiFd<eE)(Mt7b(z;K%7`Q>Q5AV&L#>(HBBO~
zNaEfUbk#Sn0Y|I)3)2WA2=i6+jk_X^_cj|sAk{1L-1U`sh}XWY_8Y85ppM_`m;&6c
zDwH)H{Yb>{ke|ejk4q`&sB`FfnN~?n8RlSXV0$}=?8Tqvn>UZskLAb>-lgJA-cUTO
z-6D$HRy?{m^7lFh&p4y`lBuo~qIGleZhCMq&W?y+7b8;x6i^fxdqa%<m}$HkFJfOA
z$tt8>-)H^V!2Awavmln|p&=6+uVll>c>lN{ymwXKDS@9uc1XrHij5ck<utpW?^>=I
zP&mznO)xGHS}**?4PPp>75`8mSDU46^Cf_6rr|NL6uwrR@WzlOtaSO7p2L+)4r^3x
zoi_zx<L3JpD9~;#eB9LyQmIZ~tF0}OkJdF_KVtw}v#WmsHD?Y2g|;beuaGTsfrMu0
zFgJ&iHB=LpRXs(KxLwNX{w8k0_j6w-Hs)98`R+5W9>1e`I>Wfhf~tJE>+iYlC?LB{
zKMwM`L6|yJM^9wTBj+F$<hcw^vrQq)BvcjC>)-!9FO3=Q5TrosUj&97H{DwXwnP9Y
zxU64!c-e>;_RcD?OKAtX4f{-q-hGX>#u|iC8OP~`(&H*W+R1{v1c5!%5fsCQdjJ)I
z>9V@@A&+v*sr4lyh7HpW(O%UkUdNJRowcY1w4w5+4y(I-gz+{a#a@E#qnp#dBKj>q
z;>|i0VBgQLCo<^K)@!VL)%WVY4Ell&dIAsd*8?gH>8A8o8g}#Ds{WZ0p%mm@N&3j{
zPTz+hrL3|G+f8bUgGL^AI29{fs~M7C0nZp)5wh3jxfX8|6TPEZOXhM@h%v9{xVUS6
z8J7Q={sWH?GQ9U{LWttV2akjYu9WZuw>`Gx`u^ZD1<u(b7e#1%V;@%5C)%3i_J8iC
z7q`eVY@#kjR_8T@33{k$5V8)5$;pc@1lh=dH~eEA19B!APOpS!0d~J?I~K%fd?;zs
zA-M5i>2T8$KtOsP$e5vLiQ$JRLR-VMdTA6N{1|BDd}8-yiyJ7AA@0$z2Vw@)_ipIF
z&tT{)yqe5AGT)0mLz$0wxY@ykVu!#5=^(b+S{foqzOD#nogV(k8%=Wjv)@^PH{ekm
zJGDH2b9-0<A@Dx<yQVWFFd3rht+Y(>!|*gRhL=8ULG!B=p#t$iG0K><X?F#v$LkPC
zmtoDPLmFg=F;WV+tpdOT<K$jUfWL<7^PXdryA*Oa`7*_)q{3rcI36VRhr6gCy%R0i
zhN@7&YaB`G&E<17*D~WGm{>;P`*oCWli7`ep;lHIWl}PjDrCS`UWs(&Np2amB9Z0<
zJ3y@Q@5U+ny(qpaz)tO;Tz%h5)ZUgfe~*aPE&d@eI-$ly66BS511Rvz(}zyrd}AJ^
ze`EKlPE3~a#CLzf`u01W-p-SCCeh@1=}DkZmZ-faNgpze97{Pg&;@;e-=8sfHIa{j
z3@9Ls%7&!T^9)`h@yhoKuFpK>#4Qk!2z;*lMyQHE%)OLc)${1pFXs@8x=$WU-$NNk
zeHcTRs_9kS7Y_wb1x_TOoz^Q0l?sa0C~QP9r#yqHiiZd>6NDTq3Dd$KX`Hx@eTYpp
zQF(TaOBT0ZY`2Uil{a2LFV4R%SJHh0nE$N1^Fs(P6Qo@%6(2Ih_}=>>Z1?e7%9Ez@
zNs9KIAp)DYbNNvx?<M%wH{j3nt>}hJaE0kJY_A^(#e1}bD&Xe)^pJNIC(N+R1AB>S
zGo)Ku9#s%->pBDOTU)>kPo*`-H_Cpur$)~{QYoihL-BWU;RA_b0-(<<CD>=ZR>$rK
z?s1Y~8t8>L`@al2%t!l7tg!qVwwDX%f1}RKL<edvuPC8e9y!RjTfJ;H>IHKX@1cGK
z*0-DQ-BOS_u-E=@ivmYW0=`C~0ij3jkkN_;?pSU$UMEl=+nO=c_ID}ZBsOuR0g+hb
zBrvNa<R)=s2TzFK5&HfDqodf~m#0&_PJRs~Mw*2r1yK)C_HTmldu`JLd0q?FSKZF}
zv}{~L9xid36|Qb8Z!6a}TXu33;AL9}E>=*9E(#vzdKhfly>?al2l1H^pj;x5>KvSW
z#EH&oteZkgf!ZGplqupqBOOVXTC#TPQ}KqqVEN+quMUQ1g5eV7bd%gWiCKXkNN(8~
zuWyGI&s`PD?FKs&(pdqw!CPO>{9!sUK<GcpMU&c~I;6qA6C&b;s13rNZx)&-Do?Uf
z$(@yOY(&{Jjx_qScMsDMP}%^L05iO`_e8;ZMib~&dJfYFY~(B9@)0-<S+hoiD6n5-
z0xWI5WN-`&|JrCA01;_FMWb7t?uRMJ*Kr&mgHB@j@t2N&sX?`${`}k5>S0ZWVLF#7
zT;a*P(%5K84PH*s<7&;oQOR<ehM<Bh^6O#ReIh~>ZRrrAyLS<8QuoC>D=r%l!+BQg
zh<>en&D&PDnAT(Vy8VdysW^={?b3iNQ;mSg%LF3Y_p8*{G^m1#ogH!O(hAjuZGC1V
z^f)n`nJtNRJu3an4s0&zTXF)45GvYr=1hf)(Qos4?-ON1D6j_NkXQ>Kk#GfiBl*tu
z*MMyH9ot&mkmS{z#qay~N{;>_Iz3Ufxzo)Ym%<O%DV`H&J3jzzxy*2WI+SZIz;Zyj
zcpzfv&oSG?BGkB!7j92j?Ij_`hdBJVPxl(&{2lR1=4iynRLa1*2MoEuy@FA?TlP}6
zup^B-?yIVm<ezwI^lt+B%MM;z3jfl3$%eUkoR@2@&m65o7F6q*{#kX0DqE5}bM@w+
z&jnKKjxsHJkq0p6h)A1ZjU(~L#2AWyWP}~?21YBh1KI+FwR_mPeZ<a9KZ(zCx0<Zd
zj&7WQ3?9MWGGQ<7Os5&Rf;0qN{k_P|h|tHO!dKnIene4&^ta9IG=0%&A&2n4iu8Uc
z-HHP7JL|f=t8AD9B=ncCYo$|R1wL=8vdK^c2)T&MJM&rE({MRsNuap%AXnSX>1~+$
z534}y7pzcujERXpRfKW4$*fNc8Mx9Dpy3PI>q`|SuH^ccWlSTjFPZ6ARtvtk4Gbpo
zJD;-hRZK;c2xW+VST2nt32<oc^`h!<^hSGk`ZOSL^9vEq0fY{QL2C#O=%LS<Mc&Xr
z;Zz156zl_H&^%AnzX1)tNb-+V`b!IJCgt^7iC|?SA)xz}Ru_^}0^F0xs1bg<b5Kbg
z>OKUM2ftRYxbpwdbQXS5ec#tVcV>v8JBAQZI;FuHX({QBQR!|8(Q6=`(gKcjgEWXZ
ziXZ~g-3ASc2#BKi+|T#-dj5o&d+*tMul-)@Y!viz5*dSa1Tf}*1XQY;b=kJaeq0aw
z=+NqTzVYT0)6;0te-EI}*8e=UyEV<E3$~ILKSLI&)NJna-t|AG3VxTARC75t+=RP&
z&h}4CY5z+Gygkd#?InuwtL&IMPdzWAcrT_f)W|JYa!}`CQ47Vd2S*VP=m;phA9|P(
ze-kOL9S?UeIF`$IymfB95At)Cv`|^N(`1vFXWOytYT%`@OU=(fvKwtB7Z%=&+SPH7
z(h=&WfRP|TcIn%kP+&M532rFA++~x;0Q0O@KHbzT9{-;OfZk$uBVc!EogJ<UdUVa1
z+|ow*K$M<6lNvuUU1^CjXTEE7zXD=N$R4<UP!WE8S_N80WV4eL$e#Y7=>ffXqA4w$
zm30BS@G;|3iG1+>nTk;GWllU8c<gdWcBFP6crOehoSg)-T9HRoyrG8{h!{W)(=z}e
zquTT%f%Oc5Zc=mXs@{h>)}UpR1J($pHw!8<;wYKNgso2wq2~*3tEdUM8Xc7Dynh{d
z^tWFnDpd}0l-SERwb~E)ima3qQtrx#e8^PNXlg?Xf9@^(c`3+p!f-(O3K&Bs0dxaq
zSg{OZh0+p1Pa?=yI-Nil7};}mHmCe~fTf1iwO^F*Grw*cPFn5G=`aU~FE3Liib}xS
z^k&9w3d56Kks}Ic68!~a!?JrXnA7{3TkQ3o#>FHz@?LLXUM>iu0L6<ETE^N(&pc%O
zAC9LRxQBS(Z!n39!GSS1LO4tgroj5JGS|%6kIpb7klMpxtA0N?4Tt4DyfvV{F<o&M
z#bFH^7wMFhfLuwxrnh-NMXyBrAt#aMQ*l5&(tXSCu>wSq-EpTF?x_Rf&#Jk_nyrBI
zdrHFPurqmAg(s$e(F_j(H1y|ZBC9?~IaUIj{9Xp^nF&uo-RI6M+6ucs{qCQbVa+oe
zOnJf@PEm*96o%a$fA4{(O9?GtcjK`Z{i#b~dy~y;+`q{9>>l^%R`}_8{IUKD)v&_~
z-h1y+hCev@els155?ZkY>GXk$3jt+|C4+-tp|8H(9j8Jywwn)}eFg+l*?Kg0pgU`m
zWlKZ<grVdK(zLSoeLBx{>@v{;2p<AgyDJN8C|Eh02meKL3~?N`U&J?>iO5eXKj8Gs
zLB3CYWggt8+f_iih=(M>%K{W_^y=K8kY)-FX?d=x?z<KjtkQ1*E|sOYXoM8wSBQ~h
zdVW=w#ODmp6sG_5F1TH@*N9dUa8T%q`0N+3We0A<*?$;6A&z_-_wuB98ip;8IDS_a
z)?4ZO@~@&lr`13u9EuB~;{{7c!-sU~b57Bp`1kW~N**d($kfjdN7|H1YHI+GZuf=Z
zcj0ujMb<CW*~f2hw5nPyYNMvJKVHLL)KtEh2g%rn>kT|!yF%>!!;Al28T_G`dIu+y
z$_IN>)S>a|0wA__c&OPfE;s7YgF)5~N78$8;2D3*`YD=^JKLFDIEr(b68?8N{8sbX
zcPWc8opDlEINUV5Dj_prn9v~N=INRL(RPq4{zHP}m_8F%rgxJyPM&={HT!vM)He^$
z?55-eEfp2#c9nlpG9GB{y0Ay$hBt*8rH#^Uoc?^W;lDU<!_#m5{06G^+nHG@77n{3
z)dA!FA2=f3@P{=<oiu7N)%pawJ`=*$wMkSy4O4D`>3BJg(-@)`EfAFWQ6D~W(%O1}
z1B+olcILKhzIFUvt+rS^csJXummM}y$sh=a396c%cTTdsycz(D(1Knp@%sTGs@U>b
z9hVRyv_+|^XBZag1CJ5PbI<@YzB@q)t@MZr2>jlWC*AFjT<;X=Bw&&ybAQZoLqsx?
zk0M~S5`;5W!6*Ly+2OJ}f3$Qh6t<PT_d@*SG<~~4WL%&Tl|Gra$3<v4AB}(HZQrT}
z8l$^C;8jtQ=5u#MzD&g=-}=}ewiHW?|9Btw651}j>AexIBSjv=uUQKPQv=Vx+@OEt
zx!`YUg%V^Z8}E7Sf%>z#vQtWabole+v(OwR;f?noM%p7OX>`&+@ceKr#g6~SQWox>
z&%p*BB8;TTc;y7vHJ-i_ERl<9s{WxulcL=v6kY@cCffwzbY#)Xy!PNO9bCYo5G7A)
z-Y{69@nhd<&Z-=gd;gswmT*l0+#7oeHQE~5X@fX<eD=la$FlskSP=N>)RQZUbXZeO
zYpW7GyB-<^4UfF7xh>p?!S_(0XVV5o=KHB(&FB7zC$#-w*>a^TbLEo5?lyK=FYyAo
zO*l{=(KQNwUNqq(pz>`Z-q=@K_g)d=JT^V!q!=bQbYvK~nz&}MlN4uDi$HMGVAwT|
zqm_Jm|Aw2Gkaa@=waBc1{s}F7>CPB$hV?b@17oN#p^QhvXx-d$^T1FtZ_F?t3Jbx-
z$*iC`mp1G!s@Kb#QSSHM9}x?`nC^YZg~s>0vqbJMfq9n+hTmzF#GTg7IUN2&$Pp7>
z5&9#9nifWJl)wI%&(8;bWBG0bZ3&}{X?2ov5cI{>(gO{NccKZ;ljUmJK*d=u$6r{2
zoNLm`M;&CSW!sCDe<T1r1>yI*n!mlB4wyiCzy82f?x|gQsN*lS4oPw9p<|s2I;5a&
zRo6x(U0>=pz*{@9f~Fy|&rP4S<@uv>O<4SB5uW0iQAVk0_S>M7F&yEURd@HtvWMwn
zfjkN&<E;kVhE#{5v=Z{C|7Gah49w@e&JgbD=JxyIR28Jaj5lw4J<7tvmObR(_}T*w
z2W5&Npdd7#3w-&coHJ44h9%06ve`mJ6bW_Uf`4awwXrMYa=Y`h#K7lkWTb5!qg8qQ
zh7_1=2z%BL45pQ)*zC%0U%FJ19e^96zlP9ejW@&;5_lDLO(?k;jIM!e@n0QHM7hJ-
zUI>z;9FVM`WiFqQt2@<PT$6PZ8KblI2H<=`m`h-BL(HW5o(CKQHXnAFwX8c2f!S>#
zq*SFu?cs>8P=*Zn(+S*Uc8d8-mrmsI<ztjr+yAlGrl)kxM^gbeIUXOSybGt{6-=F^
zG88z%PvBha)&(DKp$4eQ;j3KPk=-w*fn%ep#{yA$f*EhZ9ty!9QcI|nDTMpKlEGiO
z2^c)LuQ#v!kG4~PmO))kp7zbW8q=nN_tjERTERIC1JrW8uV3=kk|M|T*;DK-_VjpM
z?X9h9hYmkk3Ca)jmQ=5xb({9h%SlcTnpw}2j^**&m-YXp%3r#Sp$GAS<+m<T2rB}Q
zn>8Q}gAidt1DyD9@;Wpr?P7$~cGSf)vD#PX_M_8hj<L%(cpwegBWn1oI4U*()}(hM
z`h~~mL0_Ps$FeJ4-pH{vU-<EXmmR&WJz2=KmZB{P{6hxEHBe5Y2^^2DblmpetPOjC
z!6bb~ExQdeiCI}F5cFDZNBX0H?t=R>>wI6zPWQXE^I;c3i-OvkPX%HiM;4#R&L3s@
z+iAvKV2q)1Sn{SzIyvb9;k+D@gR*w+3lTl0KgC2MZ1%|ALDw<;$^w0)3R)7u(N(Yh
z9w4`1AZgl+P%Wgr9xc%Af^G#CJefFhQ{uUQ2JVmC0MZI7Gnd?p_87IIFQ%aMVa^Xf
zRP0e@pbk$-j$iXdzYMKZS<vA=rA&E;u1<<eMb?|qht<w3jZP&TyF5R|4pKUKK1}SV
z^TQIfhCDX;5{vRu{B+a_{BO%^Rea<vln4D;T20oyJn3$K5dY&el7Jbelvhyx?`-_E
zvO{j#akX&O&2i$|KjSe?1TFEDg0@|o>`~K&>q~&UDlMu95Uv(JYcy&+S)_#5k#$=^
zZe`9q6Q1>mlXU&RuJ+Wb2W;J_$F9Ad-n8JG{F{F>b>gP~%6DoI`6F0e9`PN%Id_MA
zxQ!YPL^)}KSNqXzGY}z|D(b#0rjCRDp#`SS#1w4+c%A^k4Nbr;2p@Oy!Ey%aK-6)P
zp|gIA#q(l<S_9?mBPqS@%r`5ek+mvcxn*Mv?5S~)*TixmK7E6WhXq`~(7o7v^xpu~
z8MH;Kf<78dC|(v|f3G?9G#71~{_>e!h1k?6O}tJHk^aGZ1D7eMcY(bx70R0CuzZz<
zt8y`*e%Q1^>zO|ISAN5(fqXgyiCNQre_)sst+o6yzW<H%&Ijq+>2|Nr81E{j6+<L4
zNZj)>^rd%Qc)yB+QNPIR3&v0n6c5bnSwOULNEtko8SWsh<H_=h8`AD~=Wa%0m+P53
z6M?XMj-k>Qv{{?aTmRln2v;ji#?{Su($zWRQxO3Im76Qidijj!0)M%)lIt0tW!0R0
zKQq#?)58Y5>Z@yA-;taJuj+|<lZcypdoHxQht(US3+z%0NAH`zfvkRkYd!hsqW1#(
z*CQD;Oxl{>i(GT?h%tQ%sk2Vea00*SsXt7l9tCF7Z*GERR#)t#sLb??Uf-K)=p-O9
z(yh4cfRv3PxnF_?kTJW-x2#(HROTD!2i~`7ljj0pa<2mcIHVG2j|q%ezr^^G`||!`
z5NVbAjHxrKn6!XmvCDPj)5k?f64RqP3V06&C22{rsF_C3s>>^ZbZH+p;%<Dt@%Rxd
zAXm&HyBvLCVD`H!;t$<&PIt5Gy<pG0eEC(!!h9%cPVqq1M)!>CvYk@-9GzRK<mc<5
zD416y3uul{2jS`CI$56HVOLXM`Nl|@TxN6&P4KFdq8OjL`Vf>M4$Iw2onMB#SfW?F
zmnKk8RY_X|I~eIK4BVcW(vvUgQUdT7GaKpNVtg6Gu79xwMC~}qx(;&7Xk8F$?FCMZ
z6kgK>JpEiR-6o$W2n*zOJOPgwl+BXXtvPNsvh672gP>utoJ~%R8(8=-G#`xKe`fWI
zcW8rdO>>Kxu_yH2tck4G?XRYqy9uK~(VY|{x6uiO?5^gxhbEJO>o4>|{?~z7LyObR
zP5U>9ACcMB6iin^1(JFo3rlpoQaGs->4af8h1iv~=1Wr?$T-eV9&!RRK6rKjIUy65
zgd)oVvBbw@IoWLB)u5bn5n~mn^R_Q#sF@w$cDq7oP&5EfSgeM|%-}>(_;F;JBp4(_
z5At<~U|^#(Zxn~6SDVfFYa}Sh!^#0{H&A=P-<j}@^-+r#z72ss@tt*w9V}tMAA>iI
zX&*eAT5gB8PuqD=p_H;%cCp7;f`y#$&D~!w|94#KgQd0uLHpJ1^B<qyp4&vM3X$^o
z{Y)@jVy+KF&RfJ`3EtFvdS$nK%g}`Nt=uWF!-<c`HQBU5adb_kr<xzj!to}|spI5?
zEHJ6@j)8fUL=<RK#?3ruT4886>xyWZ21O&?-ag8ZY0!<7wMy`vfD-;S{;&$dIga1}
z(m<?ggEJS*nm&4y!#j$ZfZtqV#KsO3oo*;B6-fuf>)2)9hXqz^-s&y|tJ<%js9uDM
zFQmq9+&y40PNyWEhQD(Y8yDI451c*kPJ*SGc8#gJmk}nPD_dqG>*O46y@D(mNLkj7
zNMmQlE&Xf<Q+I`_$@QKHs@+`l9AC}zu%KXmYxF!GY^ZKuR3|0YJa46`d+bar4e<rb
zJ#{B}6C};wf5>8bSE5Gsb@tJUH$9+->WclSWINs(Hzy0CK?#=N@={%5qm<Gz>t6lI
zCD4Ao<l3X>ntEG?Vcof6A~{6v12)qwXjuu;dyOXknWBdMQPC&2y5(U;(q1Tvv}U(1
z8#j<ZHdc|(wMO5>C1L!)oDy!lgQbt5#Yo3JPzMX678nNk8wt0*%^v1-JwI9NpVQBc
zz7rlHx!YsV)mS{d1~gEliVIh7&YkV1B(B^RjO2%#%(OqqEtHLdR#l5IEP)@szm)-U
zutcQGm2&|b>ifoaV8F~Vr1hus#9fJq^gkBVF0&Vo<VpEpQ!OyJnl5GtN?wigOqF8?
zXX^iwk-l>ia=LviXhCyecljWX4SKxrijCJ1j?aP%UUit^#NUDH_~D$3nJf81a0JPQ
zb6fzXpjI5c*x{Nc8J^^r>#DF}-f}}zO~9mKKL9lya%O7~y}W03{Q1-57StLP{#Vd@
zTfNavyaK>W1|Yyr-J<yf12oit(F=+AWrfwEDjff;?*3~!U=;NfqHzJ))`4n6)#lI5
z*dp7ctGTwvAG+#?CVW>j!N#zqbCNGswncaRxZBv1bd@!~rHxj1B8Uq<WVljkCLfWP
z@{8)6dNEN7tV$mDGfFe#BY9hCx>DQ<48)kLhP<u<qZ%p)Dvhy+j%Pv(u|%_hlgg){
zj~sl)5h?In43b!)CHjK<%hgA~T@x_szROKNXMEguwpK=>d);=f@dgC*zRP|30!xhR
zPjulX)c&u_5+gl{gS|&gg{!52^<`+>17=*XrG+J(#pI!V4B~0O1M%%O)F8&8J`97O
zKy0j53zRi0tjhFKjLt3bFP2Y*s#7%Z%axOJeVu3ExcTlQ{h0#`U|rlw3(5?)%Z*y)
z@ps4#(S)zqWi0d-`YhUhSQDe);=e!K0cB-Napi2YZhS`(pO<b6z`t83=?rG>iPKNx
zmRnv&BgnDWB%lX%xw@29M)0tI-l)fz!dE8zSlE}aop!ow`L)^i|81=72paF&j6Dh2
zDyi|F^)EAW<k>fFkzg;E)N^Rw9%9?5XJmoM8tSiWzIclR@p2*!eKNJfY7C_2Y!F=j
zUhbEnEC*1(wD&=z)&uAXWkAbiLU7urqBC&1FHYcQR7OFngV4iCPhE%8=ywxU3Hl?q
zh8SUbyTb5tVz0}hhh<!dWuluvY#Yy>D49xTYRDlO)devBxI>|4(;|;$_CW6J`887?
z;Eb|N_ke?SUawp4h%%DQ6*5KyhD@j~InBQJc8mg93V`uWx4SsiTTN7%SmTWvrDS4d
z!f>F02foioLtqn&_}eL@Dw^$z5(9qzAP))O`q0v{*x3|xTza?M4Nbb)zsZ-RHs|Lu
z2yG&d#r|3HrL0i}KU6dU3;zwg*m4@qt2rL7g8GK}79pasirl;Ac_izj^^*tO9?y&b
zfx#(ZI5xB1HQiD_iwvVCu2WXl=y6Ql_{%Fxe&o`cF-&r$2p1AOAa+WJ8W!BbB53}8
zx8>bYvvV(AV=FK}$oZ^CQ!|{N0tIt>z#U<ro8>6i`U{1;oJRGsaG51CDN@5Uwda-|
zV-uqN>hW{U<J9R6sOZAbX7Z2^SNk03@xMjCOjzulv~q!(4nTT5T+=E9FDN6EA@W|{
zp+#Vo9bEgekrycFo(Fnn$ZAgK=ZDdZcyMxA#pWIyNp3`wZ6Wc6UkF7E;l=Ho@%dm6
zbTIRSW4UIHGy>2c>s+YuL<TPpIr=$Eg5R_x<hzwog5a=7`<P1p-(P76GUc8fw&;Bi
zxXSO2_RG_V!``j9Gyq<V|6@2QzM~JWW&7;AJ9@yXhw)bGa}fgkU%AO_Oz)ICX9Bie
zES&K6T(S_n{l5d`a%abap^NXav%T|dbMAU>{1r*HN-UrIH-98G0Yq#yexE%RD}t!0
zq%Ze*T;CttRy<qbe(!~rF0RY{!K~e6-E21|y5y@^bho9Ntz5$fzAro`N@vaIZvN(W
z`ja*;C7WMs8H0<0<98ngyLrrGhB^JpbXG39k6?+!HsKGdF4>7@Mntlmh%83D253-8
zA<K_Dr2#x&q@VNDYx?%Wv&r>_276+remyFCzE`we#mYfmvZ=f@dqxXYmRm1ZAAA;;
z0QICd0V4T74NnCwB>F!q&VFKiD6D7{%S|39<II+L;10p5Ks1drak4QeVC1)P^Kk_Q
zY5xcL(JJ-7zvYU6`y#~6BRx`Hfn84V5`wRc-fE4q21s#s2Su#IDZ&k^7d|Wd0RM^7
zLNZ+yKSd~BhkUi2mh{CE2{lQfB%CM8&HZE&dCBzhcdWCil|Wj`?M2~{U$~df|016P
zcOC_BK4$XWapWver}Bmj(R_DIh!NzZS_MEcL8}Q}*<pZ=4ay9E`=Ft>=WWq?LGBlB
zMD$_m0@_HgWudCTxxxuUOx=2@jq6F!l1AokOOq1Db@P*PO(QZs)R<k7s`Bnp2JR^B
z!qeRT_vKx{h`C>$|3SrHKfkR5Fdz2u)#YDX&m6ShP^39^VGQ-bu?Sgzuod7t18d*E
z3K63Rhi^C74>2wbLa~yZH7^P;G?-wjCV>~(`+wdeDuSo2EMtph11RA51fDzR$6r(A
z82{mOTwS)C>sVSR>VF(2-cF#9RF72RM*TeZ!#qR+6JeqNy*&|xqsAYOXR}{7ylb$K
znfORQuCw^yQrbs~1j+XKU{%)*ixKt<JVuzn`ot0g>W|+!0b%e#|07jDLxoi=!EMfn
zd#`?@i2~o@#vG<VqbD0mH@p`yPP~$F>0rke&8Oc)3lEM28Tm`{Lx0*!g5K58?$S&7
zC{pa^amB&GuQCQGuG`%rBjzG9ji%8lR~6=+UpT&s-Ph8Us~5b%Z`&ZuaARd*pC`b9
zqA^Ei65l!tA2fbH9A%k+x<~$kS>ulMUJ_{4(SLj(S|&N0B52H$%s*m*=KEy%7)ktU
zR8qr)qIwO9D+Ea}dnID)g_J9X8WaeAz%V=ue#A15mCAES47PVk%V){wfIRzl`SG<v
zaNb05VaimAr}f6fROkhn`GezbypTUm=XENWq`(;ZJ)s58Ebl^=z<M5K9>8<zY`l^I
z9L9_Pr(>!B?>ryHU|i22n`%jNs$AeN%N^58N$_(XmkU%Dq9uA%ezeja>6Cm`bZsM`
zY!Xzf<`maQ6>d$`6Ip*h<W&F*m|^#ukJIj_yP7(lb~~`!X!~;!&}jvb=bH!HcWb=<
zQb%l)4~aDBkTWjS!mbq94!@xj`T1@$d2WPEEuc*g=r$NHHUG^t7)|bSy64P8K|S`S
zqR>-?(Pr%$mZ%%>fi;>L?_eJTQ!b2#1MykOb(wW6-}#!3oHf5X>z452Y_^}1N6*WY
zpj_k`{#Jo#?xTtPusuc1{`^#g$gdwrBi`_T@*aA5&d2BFMK48#iRBC)k8=f94`S~Z
zI{p-$5@R{`fd78v&M7zpyXsDYbe$aV>FJCzilagu^kc~5fl9U0gy?&fUv_|%f<$Bi
zns<wC>x1rACSy~-WN)`Cjj3J3p*KT{IVCnmh_@(@HQLGyd_x#W5rF%AV~1Xe2nrVq
zyA4rc0-t|r<4M2?oJ{1e&KvQxL#>{2E`vPJRv^5nn*Y~^PK+TFzSe3v6RNrI{cuT5
zs30PU&QKP3K1>mKvzlvO4&kqY07_QKb6a&!O#`UaI5b_B^!|H-v;>;!|MsQ)oaXAi
z7=(I?69JW@dU{s{M5-fKGC^HUFMrF$J+OXXq{~tWsv{?5QS#wzQI<h7+=U;|qz-az
zc6)CmS;^8ZXUaYY2NpQ-ZdrfS25!h}o0*@ZY%1u^6kVj3r|qcu!VS32QIOU&tTykU
zLW+Kd^8Ur~xj({#gBHP^@cEhOV!6=baaThJq{MPGUEZNwj+yKbgx3>)%TNLCA@Jxc
zH=qAqM7lCfzvjPMp7Swj<k<xZ;T>*$>P*$R8O*RgczJje5f-gJKy_F0I8@tLLrGKU
z-I5jw-OLt<*d;^<7g}Heh4Teyn~pJ#p(^V)dH1tINz3Vnv3i<j;lFP@M54bMF}^c7
zXD+ED+E$}n2@Xpfd_#XPvQsak<VORwxuu+JeK6xfOy$NChUc4TV{t0AM|MME7LB2<
zP@U$KP5WZGde>7|ND5Vk<x7OkceP~`x2QlkV4+YDaQ2$&DspFn21=EUSrYwr0Y_6V
z7^RVN6F<Ky2@M$8qNblhjtMfWZ>cjPC)ZQDI;5SlQINPxnW3Rl`z8Z8Q=lw=TFEmr
zP(`znmQ;(A0J}Ml(_ZnyE#4vdOA=4QGPyFt&Ov&Jc-f65RLsWK)B-&I8H+8p6Y8DE
z)Y+ipLuq}#JkZd#MOTfyEZYAjsD4HE@2|mx9!oo|K{mFF(aOF?r<bPw&|m3K|M|@R
zY|Th$T<`pk*N$%)Uq6bJTF_AeRi4Q`jQCqc^pJF8NQ^E>$$usHUVbwDL7FhVP4&a3
z(iwpit~s7i>M#`pFjBmUMUbrOOEJn#lT7$d@+=jA=tuR>jelbz!ZO|r<M^3L>jHpH
zmZxWWqFtp?HsQhOFD#NzsXx}xj{}vphKirGU#<qdzWZ<QFt+JaO%>JAtLF=<|NI^Y
z?D%Lrd~Ddp@+%f-`j~L%Sn7g5&9p(1d?X}A!1G}%>Kq!7y?Hx|CcMJnZOEgVGtq=N
zN=uP!WytZli1F{c)$e}L-kapLfBz+DCKCr9#~w>=PHx`+`?1bXEa|J-fL(II51uJA
zxy2_{)5AwSP5bifcQ$q19}2;&rylx57Ltt#!R=G0XV8@I?>);>$2bNF7=`9LH_Bjk
z-_F^_VTt!IkGHEmC(qLQTWdFno#6%Fqg;S(^9>eilfjIrAI(z(!mn*9A57Jsg+r9N
znTFWk*gUGU;)&&qql+<@dj!a@lp0pA2K4YGHI<IE{BI7aLGO;%!<Xeae+0F-O>{k>
zet?ml?F)U^l?zlTIdd*RwoVqMsJ}oZc@p9Ql9M3Y=XNF~q7hlXlSed^y2pB!rYCnb
zxezlXK9(mmTA>X~FqZ&50`>JrQT#ZdzG78;`fd7<t!dkL!Tk?NUETD2?CB-cChXY&
zSq|%+?)?g~<iR9HI!8kwcPu-@gN*c-%4!c8Fu@*{aI?%<w{3kByDSaGd%$M7V3o~I
zT6Tqf;p4z)aj?$WqCk|T#200JBBhn<mxWkh9l%PkMaS!BfyDp&d90As2S)vWzx)Ja
zOX|W*uKV^M&u;Z`e%@+hqpp5}U521-8^t8yJhAnMsj0@k4G;$|$<R%0DayJ>##GM8
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
G;XeQyeRg92

literal 0
HcmV?d00001

diff --git a/Documentation/admin-guide/mm/damon/streamcluster_wss_sz.png b/Documentation/admin-guide/mm/damon/streamcluster_wss_sz.png
new file mode 100644
index 0000000000000000000000000000000000000000..4b74829f084490489ed9f866a1076f7c9594a0f3
GIT binary patch
literal 6327
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
ZK{5}#DsLBdC5qK{{D`sc6K%WD{{rQqV}Aeu

literal 0
HcmV?d00001

diff --git a/Documentation/admin-guide/mm/damon/streamcluster_wss_time.png b/Documentation/admin-guide/mm/damon/streamcluster_wss_time.png
new file mode 100644
index 0000000000000000000000000000000000000000..84a9fd3de09fb0529aeb1051f1ce33a0a209e86a
GIT binary patch
literal 8830
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

literal 0
HcmV?d00001

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
new file mode 100644
index 000000000000..9d71f04d12ee
--- /dev/null
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -0,0 +1,296 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+Detailed Usages
+===============
+
+DAMON provides below three interfaces for different users.
+
+- *DAMON user space tool.*
+  This is for privileged people such as system administrators who want a
+  just-working human-friendly interface.  Using this, users can use the DAMON’s
+  major features in a human-friendly way.  It may not be highly tuned for
+  special cases, though.  It supports virtual address space monitoring only.
+- *debugfs interface.*
+  This is for privileged user space programmers who want more optimized use of
+  DAMON.  Using this, users can use DAMON’s major features by reading
+  from and writing to special debugfs files.  Therefore, you can write and use
+  your personalized DAMON debugfs wrapper programs that reads/writes the
+  debugfs files instead of you.  The DAMON user space tool is also a reference
+  implementation of such programs.  It supports virtual address space
+  monitoring only.
+- *Kernel Space Programming Interface.*
+  This is for kernel space programmers.  Using this, users can utilize every
+  feature of DAMON most flexibly and efficiently by writing kernel space
+  DAMON application programs for you.  You can even extend DAMON for various
+  address spaces.
+
+This document does not describe the kernel space programming interface in
+detail.  For that, please refer to :doc:`api`.
+
+
+DAMON User Sapce Tool
+=====================
+
+A reference implementation of the DAMON user space tools which provides a
+convenient user interface is in the kernel source tree.  It is located at
+``tools/damon/damo`` of the tree.
+
+The tool provides a subcommands based interface.  Every subcommand provides
+``-h`` option, which provides the minimal usage of it.  Currently, the tool
+supports two subcommands, ``record`` and ``report``.
+
+Below example commands assume you set ``$PATH`` to point ``tools/damon/`` for
+brevity.  It is not mandatory for use of ``damo``, though.
+
+
+Recording Data Access Pattern
+-----------------------------
+
+The ``record`` subcommand records the data access pattern of target workloads
+in a file (``./damon.data`` by default).  You can specify the target as either
+process id of running target or a command for execution of it.  Below example
+shows a command target usage::
+
+    # cd <kernel>/tools/damon/
+    # damo record "sleep 5"
+
+The tool will execute ``sleep 5`` by itself and record the data access patterns
+of the process.  Below example shows a pid target usage::
+
+    # sleep 5 &
+    # damo record `pidof sleep`
+
+The location of the recorded file can be explicitly set using ``-o`` option.
+You can further tune this by setting the monitoring attributes.  To know about
+the monitoring attributes in detail, please refer to :doc:`mechanisms`.
+
+
+Analyzing Data Access Pattern
+-----------------------------
+
+The ``report`` subcommand reads a data access pattern record file (if not
+explicitly specified using ``-i`` option, reads ``./damon.data`` file by
+default) and generates human-readable reports.  You can specify what type of
+report you want using a sub-subcommand to ``report`` subcommand.  ``raw``,
+``heats``, and ``wss`` report types are supported for now.
+
+
+raw
+~~~
+
+``raw`` sub-subcommand simply transforms the binary record into a
+human-readable text.  For example::
+
+    $ damo report raw
+    start_time:  193485829398
+    rel time:                0
+    nr_tasks:  1
+    pid:  1348
+    nr_regions:  4
+    560189609000-56018abce000(  22827008):  0
+    7fbdff59a000-7fbdffaf1a00(   5601792):  0
+    7fbdffaf1a00-7fbdffbb5000(    800256):  1
+    7ffea0dc0000-7ffea0dfd000(    249856):  0
+
+    rel time:        100000731
+    nr_tasks:  1
+    pid:  1348
+    nr_regions:  6
+    560189609000-56018abce000(  22827008):  0
+    7fbdff59a000-7fbdff8ce933(   3361075):  0
+    7fbdff8ce933-7fbdffaf1a00(   2240717):  1
+    7fbdffaf1a00-7fbdffb66d99(    480153):  0
+    7fbdffb66d99-7fbdffbb5000(    320103):  1
+    7ffea0dc0000-7ffea0dfd000(    249856):  0
+
+The first line shows the recording started timestamp (nanosecond).  Records of
+data access patterns follows.  Each record is separated by a blank line.  Each
+record first specifies the recorded time (``rel time``) in relative to the
+start time, the number of monitored tasks in this record (``nr_tasks``).
+Recorded data access patterns of each task follow.  Each data access pattern
+for each task shows the target's pid (``pid``) and a number of monitored
+address regions in this access pattern (``nr_regions``) first.  After that,
+each line shows the start/end address, size, and the number of observed
+accesses of each region.
+
+
+heats
+~~~~~
+
+The ``raw`` output is very detailed but hard to manually read.  ``heats``
+sub-subcommand plots the data in 3-dimensional form, which represents the time
+in x-axis, address of regions in y-axis, and the access frequency in z-axis.
+Users can set the resolution of the map (``--tres`` and ``--ares``) and
+start/end point of each axis (``--tmin``, ``--tmax``, ``--amin``, and
+``--amax``) via optional arguments.  For example::
+
+    $ damo report heats --tres 3 --ares 3
+    0               0               0.0
+    0               7609002         0.0
+    0               15218004        0.0
+    66112620851     0               0.0
+    66112620851     7609002         0.0
+    66112620851     15218004        0.0
+    132225241702    0               0.0
+    132225241702    7609002         0.0
+    132225241702    15218004        0.0
+
+This command shows a recorded access pattern in heatmap of 3x3 resolution.
+Therefore it shows 9 data points in total.  Each line shows each of the data
+points.  The three numbers in each line represent time in nanosecond, address,
+and the observed access frequency.
+
+Users will be able to convert this text output into a heatmap image (represents
+z-axis values with colors) or other 3D representations using various tools such
+as 'gnuplot'.  For more convenience, ``heats`` sub-subcommand provides the
+'gnuplot' based heatmap image creation.  For this, you can use ``--heatmap``
+option.  Also, note that because it uses 'gnuplot' internally, it will fail if
+'gnuplot' is not installed on your system.  For example::
+
+    $ ./damo report heats --heatmap heatmap.png
+
+Creates the heatmap image in ``heatmap.png`` file.  It supports ``pdf``,
+``png``, ``jpeg``, and ``svg``.
+
+If the target address space is virtual memory address space and you plot the
+entire address space, the huge unmapped regions will make the picture looks
+only black.  Therefore you should do proper zoom in / zoom out using the
+resolution and axis boundary-setting arguments.  To make this effort minimal,
+you can use ``--guide`` option as below::
+
+    $ ./damo report heats --guide
+    pid:1348
+    time: 193485829398-198337863555 (4852034157)
+    region   0: 00000094564599762944-00000094564622589952 (22827008)
+    region   1: 00000140454009610240-00000140454016012288 (6402048)
+    region   2: 00000140731597193216-00000140731597443072 (249856)
+
+The output shows unions of monitored regions (start and end addresses in byte)
+and the union of monitored time duration (start and end time in nanoseconds) of
+each target task.  Therefore, it would be wise to plot the data points in each
+union.  If no axis boundary option is given, it will automatically find the
+biggest union in ``--guide`` output and set the boundary in it.
+
+
+wss
+~~~
+
+The ``wss`` type extracts the distribution and chronological working set size
+changes from the records.  For example::
+
+    $ ./damo report wss
+    # <percentile> <wss>
+    # pid   1348
+    # avr:  66228
+    0       0
+    25      0
+    50      0
+    75      0
+    100     1920615
+
+Without any option, it shows the distribution of the working set sizes as
+above.  It shows 0th, 25th, 50th, 75th, and 100th percentile and the average of
+the measured working set sizes in the access pattern records.  In this case,
+the working set size was zero for 75th percentile but 1,920,615 bytes in max
+and 66,228 bytes on average.
+
+By setting the sort key of the percentile using '--sortby', you can show how
+the working set size has chronologically changed.  For example::
+
+    $ ./damo report wss --sortby time
+    # <percentile> <wss>
+    # pid   1348
+    # avr:  66228
+    0       0
+    25      0
+    50      0
+    75      0
+    100     0
+
+The average is still 66,228.  And, because the access was spiked in very short
+duration and this command plots only 4 data points, we cannot show when the
+access spikes made.  Users can specify the resolution of the distribution
+(``--range``).  By giving more fine resolution, the short duration spikes could
+be found.
+
+Similar to that of ``heats --heatmap``, it also supports 'gnuplot' based simple
+visualization of the distribution via ``--plot`` option.
+
+
+debugfs Interface
+=================
+
+DAMON exports four files, ``attrs``, ``pids``, ``record``, and ``monitor_on``
+under its debugfs directory, ``<debugfs>/damon/``.
+
+
+Attributes
+----------
+
+Users can get and set the ``sampling interval``, ``aggregation interval``,
+``regions update interval``, and min/max number of monitoring target regions by
+reading from and writing to the ``attrs`` file.  To know about the monitoring
+attributes in detail, please refer to :doc:`mechanisms`.  For example, below
+commands set those values to 5 ms, 100 ms, 1,000 ms, 10 and 1000, and then
+check it again::
+
+    # cd <debugfs>/damon
+    # echo 5000 100000 1000000 10 1000 > attrs
+    # cat attrs
+    5000 100000 1000000 10 1000
+
+
+Target PIDs
+-----------
+
+Users can get and set the pids of monitoring target processes by reading from
+and writing to the ``pids`` file.  For example, below commands set processes
+having pids 42 and 4242 as the processes to be monitored and check it again::
+
+    # cd <debugfs>/damon
+    # echo 42 4242 > pids
+    # cat pids
+    42 4242
+
+Note that setting the pids doesn't start the monitoring.
+
+
+Record
+------
+
+This debugfs file allows you to record monitored access patterns in a regular
+binary file.  The recorded results are first written in an in-memory buffer and
+flushed to a file in batch.  Users can get and set the size of the buffer and
+the path to the result file by reading from and writing to the ``record`` file.
+For example, below commands set the buffer to be 4 KiB and the result to be
+saved in ``/damon.data``. ::
+
+    # cd <debugfs>/damon
+    # echo "4096 /damon.data" > record
+    # cat record
+    4096 /damon.data
+
+The recording can be disabled by setting the buffer size zero.
+
+
+Turning On/Off
+--------------
+
+Setting the files as described above doesn't incur effect unless you
+explicitly start the monitoring.  You can start, stop, and check the current
+status of the monitoring by writing to and reading from the ``monitor_on``
+file.  Writing ``on`` to the file starts the monitoring and recording of the
+targets with the attributes.  Writing ``off`` to the file stops those.  DAMON
+also stops if every target process is terminated.  Below example commands turn
+on, off, and check the status of DAMON::
+
+    # cd <debugfs>/damon
+    # echo on > monitor_on
+    # echo off > monitor_on
+    # cat monitor_on
+    off
+
+Please note that you cannot write to the above-mentioned debugfs files while
+the monitoring is turned on.  If you write to the files while DAMON is running,
+an error code such as ``-EBUSY`` will be returned.
diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
index 11db46448354..d3d0ba373eb6 100644
--- a/Documentation/admin-guide/mm/index.rst
+++ b/Documentation/admin-guide/mm/index.rst
@@ -27,6 +27,7 @@ the Linux memory management.
 
    concepts
    cma_debugfs
+   data_access_monitor
    hugetlbpage
    idle_page_tracking
    ksm
-- 
2.17.1

