Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F891C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFB4420888
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gll3QKgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgGWHtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgGWHtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:49:39 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348C2C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 00:49:39 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mn17so2778970pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 00:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=B1MlukV7EqIgSxY82oCtff+QEc7IiaqdhWmB0nCcIj4=;
        b=Gll3QKgf1+5p9oO0RnP3RBfo8+jK1jCv3eKk6CrOap+6xkjCvKdDYI+frZ7S9kfNPw
         p0jaNngF12aQjmhOl4PPB4AOxgMjLlt0Ukv2Jg5r8IOTR80gSk8ayqgCa294R4iFJm5D
         60GckswFMEzQuMBDyGrhdVFGVAjT+57euGBuPmqcvT1UcG36QjSAoo3QDMZMyCtLqF4z
         X2M1XLPFDtQbUgmkSj0KaDTU5edisNflVlHlK6vAH5RQP+NytO77Ihy9p81EWITV2FQA
         XueLbxe6C8gx8youxqeiXsBCOEkQR0sVRwEXptkc0qykjtWcs7ApCgGFA6N4wgZzfx8y
         Nfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B1MlukV7EqIgSxY82oCtff+QEc7IiaqdhWmB0nCcIj4=;
        b=RmU9XUVfFiq5Vu0rT6kzWZvByKW0bTP2vfuDQVFDGeFEaMC34J8HPQrVJ8MxHe54bn
         x7wsqkVnGcgueTMouGsmXRID8k2pyGFHpoiwO4GSKlAPpqwfZX+9GVUD1fp10JOVTCCz
         WSfAjraO00dmsW094FoPabT2jvF5Md+ab4YzKgyzznyw/jQLzz1u1JC8YcOR8Kknez2G
         HRve3hUmK9dET9lQFpthHy/OLfvnN6haUCeU3+t4k5ipKpz4BuRQ+Lsx141FQuc4Luqf
         I9QJhO7Yqem/rc0eHajJZSgeOHX8oppa6xG76YI098TYAeSeyXeDGn+ZyqWdMpfVOYq3
         nf/g==
X-Gm-Message-State: AOAM531K7EiQRIBEiv34h9/0GmPag86FApYN1lJir8SthcvXR8C/OzyC
        LchMxb47bSnH9zb1zwzeNF4=
X-Google-Smtp-Source: ABdhPJxSSC5rJ7fooxZEjo/VmeC8A/RHRqdE8UPM6ZPJOuMVShm896g2ElB9YdC+0+c/zN5T2jl3iQ==
X-Received: by 2002:a17:90a:3d49:: with SMTP id o9mr3299743pjf.156.1595490578334;
        Thu, 23 Jul 2020 00:49:38 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id f71sm9164879pje.0.2020.07.23.00.49.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2020 00:49:37 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v7 0/6] workingset protection/detection on the anonymous LRU list
Date:   Thu, 23 Jul 2020 16:49:14 +0900
Message-Id: <1595490560-15117-1-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Hello,

This patchset implements workingset protection and detection on
the anonymous LRU list.

* Changes on v7
- fix a bug on clear_shadow_from_swap_cache()
- enhance the commit description
- fix workingset detection formula

* Changes on v6
- rework to reflect a new LRU balance model
- remove memcg charge timing stuff on v5 since alternative is already
merged on mainline
- remove readahead stuff on v5 (reason is the same with above)
- clear shadow entry if corresponding swap entry is deleted
(mm/swapcache: support to handle the exceptional entries in swapcache)
- change experiment environment
(from ssd swap to ram swap, for fast evaluation and for reducing side-effect of I/O)
- update performance number

* Changes on v5
- change memcg charge timing for the swapped-in page (fault -> swap-in)
- avoid readahead if previous owner of the swapped-out page isn't me
- use another lruvec to update the reclaim_stat for a new anonymous page
- add two more cases to fix up the reclaim_stat

* Changes on v4
- In the patch "mm/swapcache: support to handle the exceptional
entries in swapcache":
-- replace the word "value" with "exceptional entries"
-- add to handle the shadow entry in add_to_swap_cache()
-- support the huge page
-- remove the registration code for shadow shrinker

- remove the patch "mm/workingset: use the node counter
if memcg is the root memcg" since workingset detection for
anonymous page doesn't use shadow shrinker now
- minor style fixes

* Changes on v3
- rework the patch, "mm/vmscan: protect the workingset on anonymous LRU"
(use almost same reference tracking algorithm to the one for the file
mapped page)

* Changes on v2
- fix a critical bug that uses out of index lru list in
workingset_refault()
- fix a bug that reuses the rotate value for previous page

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

* OVERALL TEST (ebizzy using modified random function)

ebizzy is the test program that main thread allocates lots of memory and
child threads access them randomly during the given times. Swap-in
will happen if allocated memory is larger than the system memory.

The random function that represents the zipf distribution is used to
make hot/cold memory. Hot/cold ratio is controlled by the parameter. If
the parameter is high, hot memory is accessed much larger than cold one.
If the parameter is low, the number of access on each memory would be
similar. I uses various parameters in order to show the effect of
patchset on various hot/cold ratio workload.

My test setup is a virtual machine with 8 cpus, 1024 MB memory and
5120 MB ram swap.

Result format is as following.

param: 1-1024-0.1
- 1 (number of thread)
- 1024 (allocated memory size, MB)
- 0.1 (zipf distribution alpha,
0.1 works like as roughly uniform random,
1.3 works like as small portion of memory is hot and the others are cold)

pswpin: smaller is better
std: standard deviation
improvement: negative is better

* single thread
           param        pswpin       std       improvement
      base 1-1024.0-0.1 14101983.40   79441.19
      prot 1-1024.0-0.1 14065875.80  136413.01  (   -0.26 )
    detect 1-1024.0-0.1 13910435.60  100804.82  (   -1.36 )
      base 1-1024.0-0.7 7998368.80   43469.32
      prot 1-1024.0-0.7 7622245.80   88318.74  (   -4.70 )
    detect 1-1024.0-0.7 7618515.20   59742.07  (   -4.75 )
      base 1-1024.0-1.3 1017400.80   38756.30
      prot 1-1024.0-1.3  940464.60   29310.69  (   -7.56 )
    detect 1-1024.0-1.3  945511.40   24579.52  (   -7.07 )
      base 1-1280.0-0.1 22895541.40   50016.08
      prot 1-1280.0-0.1 22860305.40   51952.37  (   -0.15 )
    detect 1-1280.0-0.1 22705565.20   93380.35  (   -0.83 )
      base 1-1280.0-0.7 13717645.60   46250.65
      prot 1-1280.0-0.7 12935355.80   64754.43  (   -5.70 )
    detect 1-1280.0-0.7 13040232.00   63304.00  (   -4.94 )
      base 1-1280.0-1.3 1654251.40    4159.68
      prot 1-1280.0-1.3 1522680.60   33673.50  (   -7.95 )
    detect 1-1280.0-1.3 1599207.00   70327.89  (   -3.33 )
      base 1-1536.0-0.1 31621775.40   31156.28
      prot 1-1536.0-0.1 31540355.20   62241.36  (   -0.26 )
    detect 1-1536.0-0.1 31420056.00  123831.27  (   -0.64 )
      base 1-1536.0-0.7 19620760.60   60937.60
      prot 1-1536.0-0.7 18337839.60   56102.58  (   -6.54 )
    detect 1-1536.0-0.7 18599128.00   75289.48  (   -5.21 )
      base 1-1536.0-1.3 2378142.40   20994.43
      prot 1-1536.0-1.3 2166260.60   48455.46  (   -8.91 )
    detect 1-1536.0-1.3 2183762.20   16883.24  (   -8.17 )
      base 1-1792.0-0.1 40259714.80   90750.70
      prot 1-1792.0-0.1 40053917.20   64509.47  (   -0.51 )
    detect 1-1792.0-0.1 39949736.40  104989.64  (   -0.77 )
      base 1-1792.0-0.7 25704884.40   69429.68
      prot 1-1792.0-0.7 23937389.00   79945.60  (   -6.88 )
    detect 1-1792.0-0.7 24271902.00   35044.30  (   -5.57 )
      base 1-1792.0-1.3 3129497.00   32731.86
      prot 1-1792.0-1.3 2796994.40   19017.26  (  -10.62 )
    detect 1-1792.0-1.3 2886840.40   33938.82  (   -7.75 )
      base 1-2048.0-0.1 48746924.40   50863.88
      prot 1-2048.0-0.1 48631954.40   24537.30  (   -0.24 )
    detect 1-2048.0-0.1 48509419.80   27085.34  (   -0.49 )
      base 1-2048.0-0.7 32046424.40   78624.22
      prot 1-2048.0-0.7 29764182.20   86002.26  (   -7.12 )
    detect 1-2048.0-0.7 30250315.80  101282.14  (   -5.60 )
      base 1-2048.0-1.3 3916723.60   24048.55
      prot 1-2048.0-1.3 3490781.60   33292.61  (  -10.87 )
    detect 1-2048.0-1.3 3585002.20   44942.04  (   -8.47 )

* multi thread
           param        pswpin       std       improvement
      base 8-1024.0-0.1 16219822.60  329474.01
      prot 8-1024.0-0.1 15959494.00  654597.45  (   -1.61 )
    detect 8-1024.0-0.1 15773790.80  502275.25  (   -2.75 )
      base 8-1024.0-0.7 9174107.80  537619.33
      prot 8-1024.0-0.7 8571915.00  385230.08  (   -6.56 )
    detect 8-1024.0-0.7 8489484.20  364683.00  (   -7.46 )
      base 8-1024.0-1.3 1108495.60   83555.98
      prot 8-1024.0-1.3 1038906.20   63465.20  (   -6.28 )
    detect 8-1024.0-1.3  941817.80   32648.80  (  -15.04 )
      base 8-1280.0-0.1 25776114.20  450480.45
      prot 8-1280.0-0.1 25430847.00  465627.07  (   -1.34 )
    detect 8-1280.0-0.1 25282555.00  465666.55  (   -1.91 )
      base 8-1280.0-0.7 15218968.00  702007.69
      prot 8-1280.0-0.7 13957947.80  492643.86  (   -8.29 )
    detect 8-1280.0-0.7 14158331.20  238656.02  (   -6.97 )
      base 8-1280.0-1.3 1792482.80   30512.90
      prot 8-1280.0-1.3 1577686.40   34002.62  (  -11.98 )
    detect 8-1280.0-1.3 1556133.00   22944.79  (  -13.19 )
      base 8-1536.0-0.1 33923761.40  575455.85
      prot 8-1536.0-0.1 32715766.20  300633.51  (   -3.56 )
    detect 8-1536.0-0.1 33158477.40  117764.51  (   -2.26 )
      base 8-1536.0-0.7 20628907.80  303851.34
      prot 8-1536.0-0.7 19329511.20  341719.31  (   -6.30 )
    detect 8-1536.0-0.7 20013934.00  385358.66  (   -2.98 )
      base 8-1536.0-1.3 2588106.40  130769.20
      prot 8-1536.0-1.3 2275222.40   89637.06  (  -12.09 )
    detect 8-1536.0-1.3 2365008.40  124412.55  (   -8.62 )
      base 8-1792.0-0.1 43328279.20  946469.12
      prot 8-1792.0-0.1 41481980.80  525690.89  (   -4.26 )
    detect 8-1792.0-0.1 41713944.60  406798.93  (   -3.73 )
      base 8-1792.0-0.7 27155647.40  536253.57
      prot 8-1792.0-0.7 24989406.80  502734.52  (   -7.98 )
    detect 8-1792.0-0.7 25524806.40  263237.87  (   -6.01 )
      base 8-1792.0-1.3 3260372.80  137907.92
      prot 8-1792.0-1.3 2879187.80   63597.26  (  -11.69 )
    detect 8-1792.0-1.3 2892962.20   33229.13  (  -11.27 )
      base 8-2048.0-0.1 50583989.80  710121.48
      prot 8-2048.0-0.1 49599984.40  228782.42  (   -1.95 )
    detect 8-2048.0-0.1 50578596.00  660971.66  (   -0.01 )
      base 8-2048.0-0.7 33765479.60  812659.55
      prot 8-2048.0-0.7 30767021.20  462907.24  (   -8.88 )
    detect 8-2048.0-0.7 32213068.80  211884.24  (   -4.60 )
      base 8-2048.0-1.3 3941675.80   28436.45
      prot 8-2048.0-1.3 3538742.40   76856.08  (  -10.22 )
    detect 8-2048.0-1.3 3579397.80   58630.95  (   -9.19 )

As we can see, all the cases show improvement. Especially,
test case with zipf distribution 1.3 show more improvements.
It means that if there is a hot/cold tendency in anon pages,
this patchset works better.

Patchset is based on next-20200722.

Full patchset can also be available at

https://github.com/JoonsooKim/linux/tree/improve-anonymous-lru-management-v7.00-next-20200722

Enjoy it.

Thanks.

Joonsoo Kim (6):
  mm/vmscan: make active/inactive ratio as 1:1 for anon lru
  mm/vmscan: protect the workingset on anonymous LRU
  mm/workingset: prepare the workingset detection infrastructure for
    anon LRU
  mm/swapcache: support to handle the shadow entries
  mm/swap: implement workingset detection for anonymous LRU
  mm/vmscan: restore active/inactive ratio for anonymous LRU

 include/linux/mmzone.h  | 16 ++++++----
 include/linux/swap.h    | 25 ++++++++++++----
 kernel/events/uprobes.c |  2 +-
 mm/huge_memory.c        |  2 +-
 mm/khugepaged.c         |  2 +-
 mm/memcontrol.c         | 16 ++++++----
 mm/memory.c             | 20 +++++--------
 mm/migrate.c            |  2 +-
 mm/shmem.c              |  3 +-
 mm/swap.c               | 13 +++++----
 mm/swap_state.c         | 78 ++++++++++++++++++++++++++++++++++++++++++-------
 mm/swapfile.c           |  4 ++-
 mm/userfaultfd.c        |  2 +-
 mm/vmscan.c             | 26 ++++++++++-------
 mm/vmstat.c             |  9 ++++--
 mm/workingset.c         | 23 ++++++++++-----
 16 files changed, 172 insertions(+), 71 deletions(-)

-- 
2.7.4

