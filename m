Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B310C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72DA220CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Q8SznlHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbgCaQS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:18:57 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:18588 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCaQS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585671536; x=1617207536;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=j47iG3/6ABXelKOEb1VGsazRAbxs1IaTL1RoQDUKVho=;
  b=Q8SznlHnJW4Qu6v4PNcf9Hau0f7dZPKoZdjc9B4Xq/zT4KvbiO3UWnCP
   HzIkINpvfJwdeldBIdh0vbTfoR/xv0ISELNkPTAE/CNrPG3+Uq87PUITz
   8dXRYsbVFacwBEAxoc9DJqWDBkZ0uLws84DLHru33Ea8+iCDnHbSTNh4I
   U=;
IronPort-SDR: bzVRkZ3wQEhXMzphCLlpGcJWfFkJzlY0Vji48fr6khF9wVdOljVbRVialA9y7Y4Lv43xtq1EWI
 +GXhjTXNDvYg==
X-IronPort-AV: E=Sophos;i="5.72,328,1580774400"; 
   d="scan'208";a="26124928"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-2225282c.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 31 Mar 2020 16:18:53 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-2225282c.us-west-2.amazon.com (Postfix) with ESMTPS id 0E57BA0706;
        Tue, 31 Mar 2020 16:18:51 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 31 Mar 2020 16:18:50 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.134) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 31 Mar 2020 16:18:35 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     SeongJae Park <sjpark@amazon.com>,
        <alexander.shishkin@linux.intel.com>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>, SeongJae Park <sjpark@amazon.de>,
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
Subject: Re: Re: [RFC v5 0/7] Implement Data Access Monitoring-based Memory Operation Schemes
Date:   Tue, 31 Mar 2020 18:18:19 +0200
Message-ID: <20200331161819.28544-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200331165155.000028e4@Huawei.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.134]
X-ClientProxiedBy: EX13D15UWB002.ant.amazon.com (10.43.161.9) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Mar 2020 16:51:55 +0100 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 30 Mar 2020 13:50:35 +0200
> SeongJae Park <sjpark@amazon.com> wrote:
> 
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > DAMON[1] can be used as a primitive for data access awared memory management
> > optimizations.  That said, users who want such optimizations should run DAMON,
> > read the monitoring results, analyze it, plan a new memory management scheme,
> > and apply the new scheme by themselves.  Such efforts will be inevitable for
> > some complicated optimizations.
> > 
> > However, in many other cases, the users could simply want the system to apply a
> > memory management action to a memory region of a specific size having a
> > specific access frequency for a specific time.  For example, "page out a memory
> > region larger than 100 MiB keeping only rare accesses more than 2 minutes", or
> > "Do not use THP for a memory region larger than 2 MiB rarely accessed for more
> > than 1 seconds".
> > 
> > This RFC patchset makes DAMON to handle such data access monitoring-based
> > operation schemes.  With this change, users can do the data access awared
> > optimizations by simply specifying their schemes to DAMON.
> 
> 
> Hi SeongJae,
> 
> I'm wondering if I'm misreading the results below or a data handling mixup
> occured. See inline.

Thank you for question, Jonathan!

> 
> Thanks,
> 
> Jonathan
> 
> > 
[...]
> > Results
> > -------
> > 
> > Below two tables show the measurement results.  The runtimes are in seconds
> > while the memory usages are in KiB.  Each configurations except 'orig' shows
> > its overhead relative to 'orig' in percent within parenthesises.
> > 
> > runtime                 orig     rec      (overhead) thp      (overhead) ethp     (overhead) prcl     (overhead)
> > parsec3/blackscholes    107.594  107.956  (0.34)     106.750  (-0.78)    107.672  (0.07)     111.916  (4.02)    
> > parsec3/bodytrack       79.230   79.368   (0.17)     78.908   (-0.41)    79.705   (0.60)     80.423   (1.50)    
> > parsec3/canneal         142.831  143.810  (0.69)     123.530  (-13.51)   133.778  (-6.34)    144.998  (1.52)    
> > parsec3/dedup           11.986   11.959   (-0.23)    11.762   (-1.87)    12.028   (0.35)     13.313   (11.07)   
> > parsec3/facesim         210.125  209.007  (-0.53)    205.226  (-2.33)    207.766  (-1.12)    209.815  (-0.15)   
> > parsec3/ferret          191.601  191.177  (-0.22)    190.420  (-0.62)    191.775  (0.09)     192.638  (0.54)    
> > parsec3/fluidanimate    212.735  212.970  (0.11)     209.151  (-1.68)    211.904  (-0.39)    218.573  (2.74)    
> > parsec3/freqmine        291.225  290.873  (-0.12)    289.258  (-0.68)    289.884  (-0.46)    298.373  (2.45)    
> > parsec3/raytrace        118.289  119.586  (1.10)     119.045  (0.64)     119.064  (0.66)     137.919  (16.60)   
> > parsec3/streamcluster   323.565  328.168  (1.42)     279.565  (-13.60)   287.452  (-11.16)   333.244  (2.99)    
> > parsec3/swaptions       155.140  155.473  (0.21)     153.816  (-0.85)    156.423  (0.83)     156.237  (0.71)    
> > parsec3/vips            58.979   59.311   (0.56)     58.733   (-0.42)    59.005   (0.04)     61.062   (3.53)    
> > parsec3/x264            70.539   68.413   (-3.01)    64.760   (-8.19)    67.180   (-4.76)    68.103   (-3.45)   
> > splash2x/barnes         80.414   81.751   (1.66)     73.585   (-8.49)    80.232   (-0.23)    115.753  (43.95)   
> > splash2x/fft            33.902   34.111   (0.62)     24.228   (-28.53)   29.926   (-11.73)   44.438   (31.08)   
> > splash2x/lu_cb          85.556   86.001   (0.52)     84.538   (-1.19)    86.000   (0.52)     91.447   (6.89)    
> > splash2x/lu_ncb         93.399   93.652   (0.27)     90.463   (-3.14)    94.008   (0.65)     93.901   (0.54)    
> > splash2x/ocean_cp       45.253   45.191   (-0.14)    43.049   (-4.87)    44.022   (-2.72)    46.588   (2.95)    
> > splash2x/ocean_ncp      86.927   87.065   (0.16)     50.747   (-41.62)   86.855   (-0.08)    199.553  (129.57)  
> > splash2x/radiosity      91.433   91.511   (0.09)     90.626   (-0.88)    91.865   (0.47)     104.524  (14.32)   
> > splash2x/radix          31.923   32.023   (0.31)     25.194   (-21.08)   32.035   (0.35)     39.231   (22.89)   
> > splash2x/raytrace       84.367   84.677   (0.37)     82.417   (-2.31)    83.505   (-1.02)    84.857   (0.58)    
> > splash2x/volrend        87.499   87.495   (-0.00)    86.775   (-0.83)    87.311   (-0.21)    87.511   (0.01)    
> > splash2x/water_nsquared 236.397  236.759  (0.15)     219.902  (-6.98)    224.228  (-5.15)    238.562  (0.92)    
> > splash2x/water_spatial  89.646   89.767   (0.14)     89.735   (0.10)     90.347   (0.78)     103.585  (15.55)   
> > total                   3020.570 3028.080 (0.25)     2852.190 (-5.57)    2953.960 (-2.21)    3276.550 (8.47)    
> > 
> > 
> > memused.avg             orig         rec          (overhead) thp          (overhead) ethp         (overhead) prcl         (overhead)
> > parsec3/blackscholes    1785916.600  1834201.400  (2.70)     1826249.200  (2.26)     1828079.200  (2.36)     1712210.600  (-4.13)   
> > parsec3/bodytrack       1415049.400  1434317.600  (1.36)     1423715.000  (0.61)     1430392.600  (1.08)     1435136.000  (1.42)    
> > parsec3/canneal         1043489.800  1058617.600  (1.45)     1040484.600  (-0.29)    1048664.800  (0.50)     1050280.000  (0.65)    
> > parsec3/dedup           2414453.200  2458493.200  (1.82)     2411379.400  (-0.13)    2400516.000  (-0.58)    2461120.800  (1.93)    
> > parsec3/facesim         541597.200   550097.400   (1.57)     544364.600   (0.51)     553240.000   (2.15)     552316.400   (1.98)    
> > parsec3/ferret          317986.600   332346.000   (4.52)     320218.000   (0.70)     331085.000   (4.12)     330895.200   (4.06)    
> > parsec3/fluidanimate    576183.400   585442.000   (1.61)     577780.200   (0.28)     587703.400   (2.00)     506501.000   (-12.09)  
> > parsec3/freqmine        990869.200   997817.000   (0.70)     990350.400   (-0.05)    997669.000   (0.69)     763325.800   (-22.96)  
> > parsec3/raytrace        1748370.800  1757109.200  (0.50)     1746153.800  (-0.13)    1757830.400  (0.54)     1581455.800  (-9.55)   
> > parsec3/streamcluster   121521.800   140452.400   (15.58)    129725.400   (6.75)     132266.000   (8.84)     130558.200   (7.44)    
> > parsec3/swaptions       15592.400    29018.800    (86.11)    14765.800    (-5.30)    27260.200    (74.83)    26631.600    (70.80)   
> > parsec3/vips            2957567.600  2967993.800  (0.35)     2956623.200  (-0.03)    2973062.600  (0.52)     2951402.000  (-0.21)   
> > parsec3/x264            3169012.400  3175048.800  (0.19)     3190345.400  (0.67)     3189353.000  (0.64)     3172924.200  (0.12)    
> > splash2x/barnes         1209066.000  1213125.400  (0.34)     1217261.400  (0.68)     1209661.600  (0.05)     921041.800   (-23.82)  
> > splash2x/fft            9359313.200  9195213.000  (-1.75)    9377562.400  (0.19)     9050957.600  (-3.29)    9517977.000  (1.70)    
> > splash2x/lu_cb          514966.200   522939.400   (1.55)     520870.400   (1.15)     522635.000   (1.49)     329933.600   (-35.93)  
> > splash2x/lu_ncb         514180.400   525974.800   (2.29)     521420.200   (1.41)     521063.600   (1.34)     523557.000   (1.82)    
> > splash2x/ocean_cp       3346493.400  3288078.000  (-1.75)    3382253.800  (1.07)     3289477.600  (-1.70)    3260810.400  (-2.56)   
> > splash2x/ocean_ncp      3909966.400  3882968.800  (-0.69)    7037196.000  (79.98)    4046363.400  (3.49)     3471452.400  (-11.22)  
> > splash2x/radiosity      1471119.400  1470626.800  (-0.03)    1482604.200  (0.78)     1472718.400  (0.11)     546893.600   (-62.82)  
> > splash2x/radix          1748360.800  1729163.400  (-1.10)    1371463.200  (-21.56)   1701993.600  (-2.65)    1817519.600  (3.96)    
> > splash2x/raytrace       46670.000    60172.200    (28.93)    51901.600    (11.21)    60782.600    (30.24)    52644.800    (12.80)   
> > splash2x/volrend        150666.600   167444.200   (11.14)    151335.200   (0.44)     163345.000   (8.41)     162760.000   (8.03)    
> > splash2x/water_nsquared 45720.200    59422.400    (29.97)    46031.000    (0.68)     61801.400    (35.17)    62627.000    (36.98)   
> > splash2x/water_spatial  663052.200   672855.800   (1.48)     665787.600   (0.41)     674696.200   (1.76)     471052.600   (-28.96)  
> > total                   40077300.000 40108900.000 (0.08)     42997900.000 (7.29)     40032700.000 (-0.11)    37813000.000 (-5.65)   
> > 
> > 
[...]
> > 
> > Efficient THP
> > ~~~~~~~~~~~~~
> > 
> > THP 'always' enabled policy achieves 5.57% speedup but incurs 7.29% memory
> > overhead.  It achieves 41.62% speedup in best case, but 79.98% memory overhead
> > in worst case.  Interestingly, both the best and worst case are with
> > 'splash2x/ocean_ncp').
> 
> The results above don't seems to support this any more? 
> 
> > runtime                 orig     rec      (overhead) thp      (overhead) ethp     (overhead) prcl     (overhead)
> > splash2x/ocean_ncp      86.927   87.065   (0.16)     50.747   (-41.62)   86.855   (-0.08)    199.553  (129.57) 

Hmm... But, I don't get what point you meaning...  In the data, column of 'thp'
means the THP 'always' enabled policy.  And, the following column shows the
overhead of it compared to that of 'orig', in percent.  Thus, the data says THP
'always' enabled policy enabled kernel consumes 50.747 seconds to finish
splash2x/ocean_ncp, while THP disabled original kernel consumes 86.927 seconds.
Thus, the overhead is ``(50.747 - 86.927) / 86.927 = -0.4162``.  In other
words, 41.62% speedup.

Also, 5.57% speedup and 7.29% memory overhead is for _total_.  This data shows
it.

> > runtime                 orig     rec      (overhead) thp      (overhead) ethp     (overhead) prcl     (overhead)
> > total                   3020.570 3028.080 (0.25)     2852.190 (-5.57)    2953.960 (-2.21)    3276.550 (8.47)    

Maybe I made you confused by ambiguously saying this.  Sorry if so.  Or, if I'm
still misunderstanding your point, please let me know.


Thanks,
SeongJae Park
 
[...]
