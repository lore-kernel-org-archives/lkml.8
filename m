Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACF0C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 08:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 235FF2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 08:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Sgk74T1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgDVIsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 04:48:40 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:11482 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgDVIsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 04:48:39 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200422084835epoutp03bcac1d1017289299b797647d8a554cc5~IGA2i7ueN2433724337epoutp03t
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 08:48:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200422084835epoutp03bcac1d1017289299b797647d8a554cc5~IGA2i7ueN2433724337epoutp03t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587545315;
        bh=eQSA8h2xg1wXg3fIRq7J83yR47+XW1DnktB+3VwIZXI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Sgk74T1HcYskWRrHtU/QYzDuDnUW4NF/pak9r42uNRkN1HAFs0VAyJ8Tg37LzoPJz
         PUMQEG9lXCkypYIRmdNhdZNk1MVTbgJnFSP71iftBFe29Z9DEavRi41ZycYBduJ9MW
         w1ctan+lmPxfvGuKWV1l+DGTyXecpqMFmfU6uieg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200422084834epcas1p2d258c0bbc7d7a3b2a1d430235488778e~IGA12TL_g2724327243epcas1p2I;
        Wed, 22 Apr 2020 08:48:34 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.162]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 496YxY45wGzMqYkV; Wed, 22 Apr
        2020 08:48:33 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.9D.04744.1E400AE5; Wed, 22 Apr 2020 17:48:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200422084832epcas1p333225f9b6a00c9ce36f5f5d63fe6e3bf~IGAz6cMT90541005410epcas1p3l;
        Wed, 22 Apr 2020 08:48:32 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200422084832epsmtrp1a57fc1df04dbeea36a5614e95117a474~IGAz5ei8E1528715287epsmtrp1Z;
        Wed, 22 Apr 2020 08:48:32 +0000 (GMT)
X-AuditID: b6c32a38-253ff70000001288-4d-5ea004e1aa22
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.C6.04158.0E400AE5; Wed, 22 Apr 2020 17:48:32 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.82]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200422084832epsmtip12c8d7257ca3409a76ed0a09342adb55a~IGAztwAtT0500705007epsmtip1W;
        Wed, 22 Apr 2020 08:48:32 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     minchan@kernel.org, mgorman@suse.de, hannes@cmpxchg.org,
        m.szyprowski@samsung.com, mina86@mina86.com, shli@fb.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, ytk.lee@samsung.com,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH v2] mm/vmscan: count layzfree pages and fix nr_isolated_*
 mismatch
Date:   Wed, 22 Apr 2020 17:48:15 +0900
Message-Id: <20200422084815.21913-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.13.7
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+e3eu01rdVuvX9JjXeih5dyas5+VEWRxowKjKJByXbbrlPbi
        3i16/GO5TFPT9ZAMq/UkNDPuLJo9IJOeYpFkL1aZtUpqC0sTyurOa9R/n3PO98s5nHOUmLpc
        nqDMd7hZzsHYKHk8fulmoja5E/fn6AL741FNwzk5qhNWotJANUDl0W4Zam+qkaOX534TqL4l
        pED7I2GA/Le9BDrTG1WgM8EKHHU1DFs0nL75KYrRvsKIgg4eDiloobZETgs9+xT0nUM/cPr8
        z24ZvbexFtCB+9vpr8LkrPhs24I8lrGwnIZ1mJ2WfIc1g1q+2rTYZEzT6ZP16WgupXEwdjaD
        ylyRlbw03yZOTWk2MzaPmMpieJ5KWbiAc3rcrCbPybszKNZlsbn0OpeWZ+y8x2HVmp32eXqd
        bo5RVG605b3qeoe7gjO2+J724gWgU7MHxCkhmQrvXq/GYqwmLwPYUrp2D4gXuQfAqtPPhwp9
        ADZdZf4afB3VMkl0DcCCijcKKfgO4L3dA4MOOTkLRv37iBiPIQ8A2NdIxEQYWQZgR0+lLFYY
        Ta6BoWJh0ICT0+DA1xAeYxWZAa+0PRZZKbabAo//xmJeSLbK4ZdwAJPGyIS1B0plEo+G3bcb
        FRInwI8VRQrJUAjg5+oAkAIvgCGhHEgqAywve4jFOmBkImxoSpHSU2Hwx5FBCUaOgJHeMkIa
        QgWLi9SSZDr0hnsJiSfCgV/hIaZh5MkNQlrXBviifweoBJMO/2vgB6AWjGNdvN3K8npX6v9X
        EsDgKyahy+Bq24pmQCoBNVz19MHRHDXBbOa32psBVGLUGNWFTjGlsjBbt7Gc08R5bCzfDIzi
        9nxYwlizU3xsh9ukN84xGAwoNW1umtFAjVcdfGLLUZNWxs1uYlkXy/31yZRxCQXAzX2wjHDc
        SRu5V1Zf0plpbre/XrehMkl7Kt3k0Y/q2pXFNe70r1/rqqmbtWTCI2/VvZbkY5HTAvpWP98a
        zH7btqak+Gy49cTbRSsNZRezPcN8M19RXf1CGxYN3crdmRgsPvluVb96pvcZsQzlas3RxZOr
        ZldOqItblnL+evv7JaUUzucx+iSM45k/fDV8vaADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSnO4DlgVxBq2/FS3mrF/DZrF6k69F
        9+aZjBa9718xWVzeNYfN4t6a/6wWa4/cZbeY/O4Zo8WC4y2sFsu+vme3WLazn8Xi8XpuBx6P
        w2/eM3tMbH7H7rFz1l12j02rOtk8Nn2axO5xYsZvFo91f14xefRtWcXosfl0tcfnTXIBXFFc
        NimpOZllqUX6dglcGfcfP2Up2KleMfHGV5YGxocKXYycHBICJhITr81k6mLk4hAS2M0o0d/d
        zQ6RkJF4c/4pSxcjB5AtLHH4cDFEzVdGiVPLXzGD1LAJaEu8XzCJFSQhIjCHUaLjyHc2EIdZ
        YAKjxPGJ01lBqoQFgiSenZjJAmKzCKhK/P18F8zmFbCV2H3uKtQGeYmF/5knMPIsYGRYxSiZ
        WlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHKRaWjsYT5yIP8QowMGoxMN74/y8OCHWxLLi
        ytxDjBIczEoivBseAoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzyucfixQSSE8sSc1OTS1ILYLJ
        MnFwSjUwZmgYbVLKnKVoePP40qU3E7SDvjg8D1fTbvD/lvQ6wSNW68f+hCVmxvXiD9xLf0fz
        yV+x1/oquc5s7s4PIabprye5FfA4z9+6Idxpyq7yJVWGArEdBy94NrzqPq2cGPpPKWXbAb5P
        cc++TzKX7Nt3YGeO5rqPexxPKDx5ffSQ4TX2Ww/VX85rVmIpzkg01GIuKk4EAGrvZJ9OAgAA
X-CMS-MailID: 20200422084832epcas1p333225f9b6a00c9ce36f5f5d63fe6e3bf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200422084832epcas1p333225f9b6a00c9ce36f5f5d63fe6e3bf
References: <CGME20200422084832epcas1p333225f9b6a00c9ce36f5f5d63fe6e3bf@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix nr_isolate_* mismatch problem between cma and dirty
lazyfree page.

If try_to_unmap_one is used for reclaim and it detects a dirty lazyfree
page, then the lazyfree page is changed to a normal anon page having
SwapBacked by commit 802a3a92ad7a ("mm: reclaim MADV_FREE pages"). Even
with the change, reclaim context correctly counts isolated files because
it uses is_file_lru to distinguish file. And the change to anon is not
happened if try_to_unmap_one is used for migration. So migration context
like compaction also correctly counts isolated files even though it uses
page_is_file_lru insted of is_file_lru. Recently page_is_file_cache was
renamed to page_is_file_lru by commit 9de4f22a60f7 ("mm: code cleanup for
MADV_FREE").

But the nr_isolate_* mismatch problem happens on cma alloc. There is
reclaim_clean_pages_from_list which is being used only by cma. It was
introduced by commit 02c6de8d757c ("mm: cma: discard clean pages during
contiguous allocation instead of migration") to reclaim clean file pages
without migration. The cma alloc uses both reclaim_clean_pages_from_list
and migrate_pages, and it uses page_is_file_lru to count isolated
files. If there are dirty lazyfree pages allocated from cma memory
region, the pages are counted as isolated file at the beginging but are
counted as isolated anon after finished.

Mem-Info:
Node 0 active_anon:3045904kB inactive_anon:611448kB active_file:14892kB inactive_file:205636kB unevictable:10416kB isolated(anon):0kB isolated(file):37664kB mapped:630216kB dirty:384kB writeback:0kB shmem:42576kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no

Like log above, there was too much isolated file, 37664kB, which
triggers too_many_isolated in reclaim when there is no isolated file in
system wide. It could be reproducible by running two programs, doing
MADV_FREE, writing and doing cma alloc, respectively. Although isolated
anon is 0, I found that the internal value of isolated anon was the
negative value of isolated file.

Fix this by compensating the isolated count for both LRU lists. Count
non-discarded lazyfree pages in shrink_page_list, then compensate the
counted number in reclaim_clean_pages_from_list.

Reported-by: Yong-Taek Lee <ytk.lee@samsung.com>
Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
Suggested-by: and Acked-by: Minchan Kim <minchan@kernel.org>
---
v2: do not change logic regarding lazyfree
    just count dirty lazyfree pages and fix the count issue
v1: skip dirty lazyfree pages in reclaim_clean_pages_from_list
---
 include/linux/vmstat.h |  1 +
 mm/vmscan.c            | 26 ++++++++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 292485f3d24d..10cc932e209a 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -29,6 +29,7 @@ struct reclaim_stat {
 	unsigned nr_activate[2];
 	unsigned nr_ref_keep;
 	unsigned nr_unmap_fail;
+	unsigned nr_lazyfree_fail;
 };
 
 enum writeback_stat_item {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b06868fc4926..cd6881810ee9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1295,11 +1295,15 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 		 */
 		if (page_mapped(page)) {
 			enum ttu_flags flags = ttu_flags | TTU_BATCH_FLUSH;
+			bool lazyfree = PageAnon(page) && !PageSwapBacked(page);
 
 			if (unlikely(PageTransHuge(page)))
 				flags |= TTU_SPLIT_HUGE_PMD;
+
 			if (!try_to_unmap(page, flags)) {
 				stat->nr_unmap_fail += nr_pages;
+				if (lazyfree && PageSwapBacked(page))
+					stat->nr_lazyfree_fail += nr_pages;
 				goto activate_locked;
 			}
 		}
@@ -1491,8 +1495,8 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
 		.priority = DEF_PRIORITY,
 		.may_unmap = 1,
 	};
-	struct reclaim_stat dummy_stat;
-	unsigned long ret;
+	struct reclaim_stat stat;
+	unsigned long reclaimed;
 	struct page *page, *next;
 	LIST_HEAD(clean_pages);
 
@@ -1504,11 +1508,21 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
 		}
 	}
 
-	ret = shrink_page_list(&clean_pages, zone->zone_pgdat, &sc,
-			TTU_IGNORE_ACCESS, &dummy_stat, true);
+	reclaimed = shrink_page_list(&clean_pages, zone->zone_pgdat, &sc,
+			TTU_IGNORE_ACCESS, &stat, true);
 	list_splice(&clean_pages, page_list);
-	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_FILE, -ret);
-	return ret;
+	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_FILE, -reclaimed);
+	/*
+	 * Since lazyfree pages are isolated from file LRU from the beginning,
+	 * they will rotate back to anonymous LRU in the end if it failed to
+	 * discard so isolated count will be mismatched.
+	 * Compensate the isolated count for both LRU lists.
+	 */
+	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_ANON,
+					stat.nr_lazyfree_fail);
+	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_FILE,
+					-stat.nr_lazyfree_fail);
+	return reclaimed;
 }
 
 /*
-- 
2.13.7

