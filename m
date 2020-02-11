Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9F9C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 06:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4DE20714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 06:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLz8Qb7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgBKGUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 01:20:10 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38779 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbgBKGUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 01:20:10 -0500
Received: by mail-pl1-f196.google.com with SMTP id t6so3836020plj.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 22:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+GX+U/YAlbrFVH4Jy/mwMSE0MaFfivkYs9tNLSolUTg=;
        b=bLz8Qb7S6kdZhGwPRt8sZcoEPEtzMruFUTRZjItDteoCcmyl/wBYR379FOpFoK7ofx
         E8gcpyt251nAU/zC+npgp5iT2sHxf7Fs+g7fHjnU2msbVubm3715KkwKrNbSWXhkLr2f
         x9jD3o7HJzc8nAEU7pz639REbhcqVqVvkz7PrS+fNNbXotYsv1ph+FZvgibkefURrE3J
         yTdraCzqaVVHb7tXrC21Ljjcal1+pMtRLLe6TVgvmPH0cf7TcRJJdVwpFqqqg+6eb7XK
         dZ+HIyoogLeTi2xpZUJyIcPuvXtQNVC+6ga0ZnQz5RBLisxmlRU/Y7JMJRrBe4H9JHQ2
         c6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+GX+U/YAlbrFVH4Jy/mwMSE0MaFfivkYs9tNLSolUTg=;
        b=YktlOTyISZ6ty2uznjM0NLx5q8LVr2dJejTsOv2GpCvQ283YpuKiCyXAdscL8zcS2z
         +0bjXvJwD0iW+hU5Kl94QWkROt24DEPradl1oZKb5j0W1w7Ms9v8BjVP+JD6ug54XjEm
         BDksv85WRaj5Z1lgGP7h3oxvqEp7Mqd7rOZInnxx5OZoQ8n78Oj4zPq5RoXdJKU3nyG9
         Vf/HZUVMU/mjCPTBEg8DmbXsVwOOpwWfAcwL2jVFkvL1kcZ4ZegPI+P39ZwomgAVozNC
         0/iuB5Ov/6B6nwsUGTtfTpWpjjolerBw16o8ZHUhDt+fBIu4jMI7NdDQtLuIqqoVH/oB
         /ucA==
X-Gm-Message-State: APjAAAV+jrurODQQVLiM5aZNCglHvE4ovqt7MCTbysaarR7THbiqs6M3
        WdS5aOCX+Rj49U6DsylpX043kHTtP18=
X-Google-Smtp-Source: APXvYqykipxxKWtolEDKDvzzd8lLbN5L+HPHoUBG8/89nTs4VriPqnDdsVokhxCM2tTUBdm0Oip0VQ==
X-Received: by 2002:a17:902:d20f:: with SMTP id t15mr17264741ply.55.1581402009309;
        Mon, 10 Feb 2020 22:20:09 -0800 (PST)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id x197sm2578696pfc.1.2020.02.10.22.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Feb 2020 22:20:08 -0800 (PST)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH 0/9] workingset protection/detection on the anonymous LRU list
Date:   Tue, 11 Feb 2020 15:19:44 +0900
Message-Id: <1581401993-20041-1-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Hello,

This patchset implements workingset protection and detection on
the anonymous LRU list.

* SUBJECT
workingset protection

* PROBLEM
In current implementation, newly created or swap-in anonymous page is
started on the active list. Growing the active list results in rebalancing
active/inactive list so old pages on the active list are demoted to the
inactive list. Hence, hot page on the active list isn't protected at all.

Following is an example of this situation.

Assume that 50 hot pages on active list and system can contain total
100 pages. Numbers denote the number of pages on active/inactive
list (active | inactive). (h) stands for hot pages and (uo) stands for
used-once pages.

1. 50 hot pages on active list
50(h) | 0

2. workload: 50 newly created (used-once) pages
50(uo) | 50(h)

3. workload: another 50 newly created (used-once) pages
50(uo) | 50(uo), swap-out 50(h)

As we can see, hot pages are swapped-out and it would cause swap-in later.

* SOLUTION
Since this is what we want to avoid, this patchset implements workingset
protection. Like as the file LRU list, newly created or swap-in anonymous
page is started on the inactive list. Also, like as the file LRU list,
if enough reference happens, the page will be promoted. This simple
modification changes the above example as following.

1. 50 hot pages on active list
50(h) | 0

2. workload: 50 newly created (used-once) pages
50(h) | 50(uo)

3. workload: another 50 newly created (used-once) pages
50(h) | 50(uo), swap-out 50(uo)

hot pages remains in the active list. :)

* EXPERIMENT
I tested this scenario on my test bed and confirmed that this problem
happens on current implementation. I also checked that it is fixed by
this patchset.

I did another test to show the performance effect of this patchset.

- ebizzy (with modified random function)
ebizzy is the test program that main thread allocates lots of memory and
child threads access them randomly during the given times. Swap-in/out
will happen if allocated memory is larger than the system memory.

The random function that represents the zipf distribution is used to
make hot/cold memory. Hot/cold ratio is controlled by the parameter. If
the parameter is high, hot memory is accessed much larger than cold one.
If the parameter is low, the number of access on each memory would be
similar. I uses various parameters in order to show the effect of
patchset on various hot/cold ratio workload.

My test setup is a virtual machine with 8 cpus and 1024MB memory.

Result format is as following.

Parameter 0.1 ... 1.3
Allocated memory size
Throughput for base (larger is better)
Throughput for patchset (larger is better)
Improvement (larger is better)


* single thread

     0.1      0.3      0.5      0.7      0.9      1.1      1.3
<512M>
  7009.0   7372.0   7774.0   8523.0   9569.0  10724.0  11936.0
  6973.0   7342.0   7745.0   8576.0   9441.0  10730.0  12033.0
   -0.01     -0.0     -0.0     0.01    -0.01      0.0     0.01
<768M>
   915.0   1039.0   1275.0   1687.0   2328.0   3486.0   5445.0
   920.0   1037.0   1238.0   1689.0   2384.0   3638.0   5381.0
    0.01     -0.0    -0.03      0.0     0.02     0.04    -0.01
<1024M>
   425.0    471.0    539.0    753.0   1183.0   2130.0   3839.0
   414.0    468.0    553.0    770.0   1242.0   2187.0   3932.0
   -0.03    -0.01     0.03     0.02     0.05     0.03     0.02
<1280M>
   320.0    346.0    410.0    556.0    871.0   1654.0   3298.0
   316.0    346.0    411.0    550.0    892.0   1652.0   3293.0
   -0.01      0.0      0.0    -0.01     0.02     -0.0     -0.0
<1536M>
   273.0    290.0    341.0    458.0    733.0   1381.0   2925.0
   271.0    293.0    344.0    462.0    740.0   1398.0   2969.0
   -0.01     0.01     0.01     0.01     0.01     0.01     0.02
<2048M>
    77.0     79.0     95.0    147.0    276.0    690.0   1816.0
    91.0     94.0    115.0    170.0    321.0    770.0   2018.0
    0.18     0.19     0.21     0.16     0.16     0.12     0.11


* multi thread (8)

     0.1      0.3      0.5      0.7      0.9      1.1      1.3
<512M>
 29083.0  29648.0  30145.0  31668.0  33964.0  38414.0  43707.0
 29238.0  29701.0  30301.0  31328.0  33809.0  37991.0  43667.0
    0.01      0.0     0.01    -0.01     -0.0    -0.01     -0.0
<768M>
  3332.0   3699.0   4673.0   5830.0   8307.0  12969.0  17665.0
  3579.0   3992.0   4432.0   6111.0   8699.0  12604.0  18061.0
    0.07     0.08    -0.05     0.05     0.05    -0.03     0.02
<1024M>
  1921.0   2141.0   2484.0   3296.0   5391.0   8227.0  14574.0
  1989.0   2155.0   2609.0   3565.0   5463.0   8170.0  15642.0
    0.04     0.01     0.05     0.08     0.01    -0.01     0.07
<1280M>
  1524.0   1625.0   1931.0   2581.0   4155.0   6959.0  12443.0
  1560.0   1707.0   2016.0   2714.0   4262.0   7518.0  13910.0
    0.02     0.05     0.04     0.05     0.03     0.08     0.12
<1536M>
  1303.0   1399.0   1550.0   2137.0   3469.0   6712.0  12944.0
  1356.0   1465.0   1701.0   2237.0   3583.0   6830.0  13580.0
    0.04     0.05      0.1     0.05     0.03     0.02     0.05
<2048M>
   172.0    184.0    215.0    289.0    514.0   1318.0   4153.0
   175.0    190.0    225.0    329.0    606.0   1585.0   5170.0
    0.02     0.03     0.05     0.14     0.18      0.2     0.24

As we can see, as allocated memory grows, patched kernel get the better
result. Maximum improvement is 21% for the single thread test and
24% for the multi thread test.


* SUBJECT
workingset detection

* PROBLEM
Later part of the patchset implements the workingset detection for
the anonymous LRU list. There is a corner case that workingset protection
could cause thrashing. If we can avoid thrashing by workingset detection,
we can get the better performance.

Following is an example of thrashing due to the workingset protection.

1. 50 hot pages on active list
50(h) | 0

2. workload: 50 newly created (will be hot) pages
50(h) | 50(wh)

3. workload: another 50 newly created (used-once) pages
50(h) | 50(uo), swap-out 50(wh)

4. workload: 50 (will be hot) pages
50(h) | 50(wh), swap-in 50(wh)

5. workload: another 50 newly created (used-once) pages
50(h) | 50(uo), swap-out 50(wh)

6. repeat 4, 5

Without workingset detection, this kind of workload cannot be promoted
and thrashing happens forever.

* SOLUTION
Therefore, this patchset implements workingset detection.
All the infrastructure for workingset detecion is already implemented,
so there is not much work to do. First, extend workingset detection
code to deal with the anonymous LRU list. Then, make swap cache handles
the exceptional value for the shadow entry. Lastly, install/retrieve
the shadow value into/from the swap cache and check the refault distance.

* EXPERIMENT
I made a test program to imitates above scenario and confirmed that
problem exists. Then, I checked that this patchset fixes it.

My test setup is a virtual machine with 8 cpus and 6100MB memory. But,
the amount of the memory that the test program can use is about 280 MB.
This is because the system uses large ram-backed swap and large ramdisk
to capture the trace.

Test scenario is like as below.

1. allocate cold memory (512MB)
2. allocate hot-1 memory (96MB)
3. activate hot-1 memory (96MB)
4. allocate another hot-2 memory (96MB)
5. access cold memory (128MB)
6. access hot-2 memory (96MB)
7. repeat 5, 6

Since hot-1 memory (96MB) is on the active list, the inactive list can
contains roughly 190MB pages. hot-2 memory's re-access interval
(96+128 MB) is more 190MB, so it cannot be promoted without workingset
detection and swap-in/out happens repeatedly. With this patchset,
workingset detection works and promotion happens. Therefore, swap-in/out
occurs less.

Here is the result. (average of 5 runs)

type swap-in swap-out
base 863240 989945
patch 681565 809273

As we can see, patched kernel do less swap-in/out.

Note that, this result is gotten from v5.1. Although workingset detection
works on v5.1, it doesn't work well on v5.5. It looks like that recent
code change on workingset.c is the reason of this problem. I will
track it soon.

Patchset is based on v5.5.
Patchset can also be available at

https://github.com/JoonsooKim/linux/tree/improve-anonymous-lru-management-v1.00-v5.5

Enjoy it.

Thanks.

Joonsoo Kim (9):
  mm/vmscan: make active/inactive ratio as 1:1 for anon lru
  mm/vmscan: protect the workingset on anonymous LRU
  mm/workingset: extend the workingset detection for anon LRU
  mm/swapcache: support to handle the value in swapcache
  mm/workingset: use the node counter if memcg is the root memcg
  mm/workingset: handle the page without memcg
  mm/swap: implement workingset detection for anonymous LRU
  mm/vmscan: restore active/inactive ratio for anonymous LRU
  mm/swap: count a new anonymous page as a reclaim_state's rotate

 include/linux/mmzone.h  | 14 ++++++++-----
 include/linux/swap.h    | 18 ++++++++++++-----
 kernel/events/uprobes.c |  2 +-
 mm/huge_memory.c        |  6 +++---
 mm/khugepaged.c         |  2 +-
 mm/memcontrol.c         | 12 ++++++++----
 mm/memory.c             | 16 +++++++++------
 mm/migrate.c            |  2 +-
 mm/shmem.c              |  3 ++-
 mm/swap.c               | 40 ++++++++++++++++++++++++++++++-------
 mm/swap_state.c         | 52 ++++++++++++++++++++++++++++++++++++++++++-------
 mm/swapfile.c           |  2 +-
 mm/userfaultfd.c        |  2 +-
 mm/vmscan.c             | 43 +++++++++++++++++++++++++++++++---------
 mm/vmstat.c             |  6 ++++--
 mm/workingset.c         | 47 +++++++++++++++++++++++++++++++-------------
 16 files changed, 199 insertions(+), 68 deletions(-)

-- 
2.7.4

