Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BFFC18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 03:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1954C215A4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 03:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="W/Q3/dTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgCKDo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 23:44:59 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:41189 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbgCKDo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 23:44:58 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200311034456epoutp01464b690fca77d9183b68ed9b752f5a23~7IxvbvEKh1735217352epoutp01u
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 03:44:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200311034456epoutp01464b690fca77d9183b68ed9b752f5a23~7IxvbvEKh1735217352epoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583898296;
        bh=wp2cFwnqDyNEEIaeviKHa2XHuK9yxoCAVHYH+F5foz4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=W/Q3/dTc6T0nY+lG4yukbI4L3Z0P2MB7JztVika1Bc1CxiETEgMmBfOqP1cePmlQY
         nRjRsvh1tzbid7VpWaS3vM7AMLWq5wkytX3lgs27REEaTKqxoOWNqP61XeHEe8gNik
         2AMWe1/UmELpHHrMZaepHcvCB8dnVyGencG7+sBM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200311034455epcas1p44a809bb9190d877e69950d8bae1301dd~7Ixuykp281814418144epcas1p4J;
        Wed, 11 Mar 2020 03:44:55 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.162]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 48cdBZ6czBzMqYlm; Wed, 11 Mar
        2020 03:44:54 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.D7.51241.6BE586E5; Wed, 11 Mar 2020 12:44:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200311034454epcas1p2ef0c0081971dd82282583559398e58b2~7IxtZu_na2491724917epcas1p2-;
        Wed, 11 Mar 2020 03:44:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200311034454epsmtrp1b7078a0cb278d44a6385cdacc92f46d7~7IxtY2hb33056430564epsmtrp1u;
        Wed, 11 Mar 2020 03:44:54 +0000 (GMT)
X-AuditID: b6c32a39-163ff7000001c829-18-5e685eb6dac5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9E.9E.10238.6BE586E5; Wed, 11 Mar 2020 12:44:54 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.82]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200311034454epsmtip186fee546420bed6a21c64897ebcbc7d5~7IxtLESTJ2352723527epsmtip1x;
        Wed, 11 Mar 2020 03:44:54 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org, labbott@redhat.com,
        sumit.semwal@linaro.org, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [RFC PATCH 0/3] meminfo: introduce extra meminfo
Date:   Wed, 11 Mar 2020 12:44:38 +0900
Message-Id: <20200311034441.23243-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.13.7
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdlhTV3dbXEacwbVJ5hbTG70s5qxfw2bR
        vXkmo0Xv+1dMFiv3/GCyuLxrDpvFvTX/WS2WfX3PbrGhZRa7xaMJk5gsTt39zO7A7bFz1l12
        j02rOtk8Nn2axO5x59oeNo8TM36zeLzfd5XNo2/LKkaPnZ82s3p83iQXwBmVY5ORmpiSWqSQ
        mpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdK2SQlliTilQKCCxuFhJ
        386mKL+0JFUhI7+4xFYptSAlp8DQoECvODG3uDQvXS85P9fK0MDAyBSoMiEnY+m0k2wFa4Uq
        7s3ZztbA2MjXxcjJISFgInFr2US2LkYuDiGBHYwS7dfOQjmfGCUO3dvHAuF8Y5T4uXweE0zL
        +f2fGSESexklnrf2MkE43xklVi6eyg5SxSagLfF+wSRWkISIwFpGib9NS1hAEswCpRJv35xg
        BrGFBSwltj2azwpiswioSqzdeh8szitgK7HyySMgmwNonbzEwv/MIHMkBA6wSRzsX8gGcYaL
        xLfmTVC2sMSr41vYIWwpiZf9bewQDc2MEm9nbmaEcFoYJe5u6mWEqDKW6O25ALaBWUBTYv0u
        fYiwosTO33MZIQ7lk3j3tYcV4gheiY42IYgSNYmWZ19ZIWwZib//nkHZHhK7P1wGs4UEYiV2
        b3rLPoFRdhbCggWMjKsYxVILinPTU4sNC0yR42kTIzgRalnuYDx2zucQowAHoxIP74u69Dgh
        1sSy4srcQ4wSHMxKIrzx8kAh3pTEyqrUovz4otKc1OJDjKbA0JvILCWanA9M0nkl8YamRsbG
        xhYmZuZmpsZK4rwPIzXjhATSE0tSs1NTC1KLYPqYODilGhilb/4y+OO6YOXrA/uSt/kx8Ul3
        cdXYGG57qF5z588xa8EcdgHF82vllnp8D+IVfHll8h7PFJt1HRG/31y/bSMarxX4qlLux6e3
        CjuqGeeqil98ereNdfc+z56mmoKs/sQi7Xu33tTu4115K27XorkvHSt3OSyWsekOijWe/emT
        dvuLF6I+KwWVWIozEg21mIuKEwG8G5FPmgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsWy7bCSnO62uIw4g8tfuCymN3pZzFm/hs2i
        e/NMRove96+YLFbu+cFkcXnXHDaLe2v+s1os+/qe3WJDyyx2i0cTJjFZnLr7md2B22PnrLvs
        HptWdbJ5bPo0id3jzrU9bB4nZvxm8Xi/7yqbR9+WVYweOz9tZvX4vEkugDOKyyYlNSezLLVI
        3y6BK2PptJNsBWuFKu7N2c7WwNjI18XIySEhYCJxfv9nxi5GLg4hgd2MEltOtbNDJGQk3px/
        ytLFyAFkC0scPlwMUfOVUWLRukuMIDVsAtoS7xdMYgVJiAhsZZT48Gc9C0iCWaBS4t/tW6wg
        trCApcS2R/PBbBYBVYm1W+8zg9i8ArYSK588YoZYIC+x8D/zBEaeBYwMqxglUwuKc9Nziw0L
        DPNSy/WKE3OLS/PS9ZLzczcxgkNSS3MH4+Ul8YcYBTgYlXh4X9SlxwmxJpYVV+YeYpTgYFYS
        4Y2XBwrxpiRWVqUW5ccXleakFh9ilOZgURLnfZp3LFJIID2xJDU7NbUgtQgmy8TBKdXAKDyV
        3dqo4ZXUnVT3bRE8a8vD5DN+bXndm39/Tuz8+6utl+dp6uXxt1TPPPRftOu9NN8L/5pgFaZV
        eVadv7+aiDK9rfTc5PvyzfPvq94YSi3KW1Mwf/5JSzHFQ/+XxX1VVWNYVXCu8fmK0AU7uCwb
        Vn2bfSX+EGcC51afE1Kz7RPkS7k1c1tFlFiKMxINtZiLihMBTrrDYEUCAAA=
X-CMS-MailID: 20200311034454epcas1p2ef0c0081971dd82282583559398e58b2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200311034454epcas1p2ef0c0081971dd82282583559398e58b2
References: <CGME20200311034454epcas1p2ef0c0081971dd82282583559398e58b2@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/meminfo or show_free_areas does not show full system wide memory
usage status. There seems to be huge hidden memory especially on
embedded Android system. Because it usually have some HW IP which do not
have internal memory and use common DRAM memory.

In Android system, most of those hidden memory seems to be vmalloc pages
, ion system heap memory, graphics memory, and memory for DRAM based
compressed swap storage. They may be shown in other node but it seems to
useful if /proc/meminfo shows all those extra memory information. And
show_mem also need to print the info in oom situation.

Fortunately vmalloc pages is alread shown by commit 97105f0ab7b8
("mm: vmalloc: show number of vmalloc pages in /proc/meminfo"). Swap
memory using zsmalloc can be seen through vmstat by commit 91537fee0013
("mm: add NR_ZSMALLOC to vmstat") but not on /proc/meminfo.

Memory usage of specific driver can be various so that showing the usage
through upstream meminfo.c is not easy. To print the extra memory usage
of a driver, introduce following APIs. Each driver needs to count as
atomic_long_t.

int register_extra_meminfo(atomic_long_t *val, int shift,
			   const char *name);
int unregister_extra_meminfo(atomic_long_t *val);

Currently register ION system heap allocator and zsmalloc pages.
Additionally tested on local graphics driver.

i.e) cat /proc/meminfo | tail -3
IonSystemHeap:    242620 kB
ZsPages:          203860 kB
GraphicDriver:    196576 kB

i.e.) show_mem on oom
<6>[  420.856428]  Mem-Info:
<6>[  420.856433]  IonSystemHeap:32813kB ZsPages:44114kB GraphicDriver::13091kB
<6>[  420.856450]  active_anon:957205 inactive_anon:159383 isolated_anon:0

Jaewon Kim (3):
  proc/meminfo: introduce extra meminfo
  mm: zsmalloc: include zs page size in proc/meminfo
  android: ion: include system heap size in proc/meminfo

 drivers/staging/android/ion/ion.c             |   2 +
 drivers/staging/android/ion/ion.h             |   1 +
 drivers/staging/android/ion/ion_system_heap.c |   2 +
 fs/proc/meminfo.c                             | 103 ++++++++++++++++++++++++++
 include/linux/mm.h                            |   4 +
 lib/show_mem.c                                |   1 +
 mm/zsmalloc.c                                 |   2 +
 7 files changed, 115 insertions(+)

-- 
2.13.7

