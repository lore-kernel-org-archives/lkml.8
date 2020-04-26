Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF670C55185
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 01:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A431C20714
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 01:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Tyg6WqMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgDZBRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 21:17:54 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:20509 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgDZBRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 21:17:53 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200426011749epoutp04e76796630a70f166c2f91bf4305cceee~JOcaolASy0845008450epoutp04L
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 01:17:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200426011749epoutp04e76796630a70f166c2f91bf4305cceee~JOcaolASy0845008450epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587863869;
        bh=ZFWUN6SwqhbZKTinzJo6P5hYJfST8OnlARc+KdAxrtw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Tyg6WqMnph77OViEMzVDVfr1PX9BlnWY3NlIFKCQ6Uis+8BQbOv5EDf2aCoCqfRwm
         uLBw0dN3/nldCdIcnN9LtfFoKtqYGz8gzZ8FFQjX5P6svqBsSH0E8IkzmCYqFQqiIB
         Q5ZbtlI5jyQbPwyT3PXD0sXPeYJA1ANuRuxoM4wY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200426011748epcas1p2bfac8646092af2f903f7a5f4c568f472~JOcZ4dTiz2184821848epcas1p2L;
        Sun, 26 Apr 2020 01:17:48 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.165]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 498qlb1ptLzMqYkZ; Sun, 26 Apr
        2020 01:17:47 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        4C.48.04648.A31E4AE5; Sun, 26 Apr 2020 10:17:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200426011745epcas1p2255acdcaac77a0efc930337a2cb51aff~JOcX0Codx1719317193epcas1p2u;
        Sun, 26 Apr 2020 01:17:45 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200426011745epsmtrp128ce6ba78e8f1929b66a10dbd69b6bbd~JOcXzCRsA0818008180epsmtrp1i;
        Sun, 26 Apr 2020 01:17:45 +0000 (GMT)
X-AuditID: b6c32a37-1dbff70000001228-63-5ea4e13ae040
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        17.DD.25866.931E4AE5; Sun, 26 Apr 2020 10:17:45 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.82]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200426011745epsmtip1f3ce8b3e3185a0a375ab6086a5038ba5~JOcXnAx-V2682426824epsmtip1c;
        Sun, 26 Apr 2020 01:17:45 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     minchan@kernel.org, mgorman@suse.de, hannes@cmpxchg.org,
        m.szyprowski@samsung.com, mina86@mina86.com, shli@fb.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, ytk.lee@samsung.com,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH v3] mm/vmscan: count layzfree pages and fix nr_isolated_*
 mismatch
Date:   Sun, 26 Apr 2020 10:17:18 +0900
Message-Id: <20200426011718.30246-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.13.7
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju82w7y1wcptWHaK1DRRnLrTk9lYugiAMVCvWni66D+1Lp7NLO
        JplghmuozZZllKagaRfWyppmum5kXrpQiWFhZVGWpJiSokFqa9tR6t/zPu/zvM/L971iTOoU
        RYozDRZkNjAsKQoVND5epZBv+Fybqph24VRFnVtEXfPsoE7UlwGqeGQwhHrtrRBRH90+IXW9
        tRenzgz3A6qqwyakLo+P4NTlZqeA6qubtymMfjw0gtEl+cM43Vzei9MeV6GI9oyexukn5ycF
        9I2pwRD6ZIML0PXPc+gxz+Lk0D1sYgZidMgsQ4Y0oy7TkK4ht+3Ubtaq4xVKuXIdlUDKDIwe
        acgt25PlWzNZ/9akLIthrX4qmeE4MnZjotlotSBZhpGzaEhk0rEmpcK0hmP0nNWQvibNqF+v
        VCjWqv3K/WzGxKMOzHRm5WHH3U5RHnAvLQJzxZCIg89KXHgRCBVLiSYAi+qeCvhiFMDy0mEh
        X4wB6D3xC5u1tH3IA3zDC+Dvc99n/L8AvH/vriigEhGr4UjVaWEARxClAE40BEdhhAPAN6On
        QgKNcGIXnPDZgmMFxHLY2PkpyEsIDSxsb/MPEvvjlsBqHxbwQmIahz3dDTi/xhZ47+TQDA6H
        gx2zfCQccNpx3pAP4I+yesAXNgB7PcWAV6lgsaMTCyRgxCpY543l6aWwebIyKMGI+XB43CHk
        l5DAAruUl6yAtv5xIY+j4PSf/hlMwy8/SwQBLCVSoP12OzgFosv/BVQB4AILkYnTpyNOaVL9
        /08eEDzGmIQmcPPl9hZAiAEZJilAtalSIZPFZetbABRjZIRkn+ViqlSiY7KPILNRa7ayiGsB
        av/rlWCRC9KM/tM2WLRK9VqVSkXFxSfEq1XkIsnZt2yqlEhnLOggQiZknvWFiOdG5gHjuTtT
        8sqaqFxzn/29b38ElVMjRU0FrQ630udcrcBv0W9kmujXpVePlb2rtGKa+WMvJm3Xklbo7zsr
        NvV8Pe4Jv2D7jSV0hXKHagxsd9EBLfWgOlEvM+U+3PXtaorO2pPiaVy2aCzGPWel0Lv7imyv
        erSrOKkwZ+BtU++lV0dJAZfBKGMwM8f8BUN131iiAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHLMWRmVeSWpSXmKPExsWy7bCSnK7lwyVxBmt3mlrMWb+GzWL1Jl+L
        7s0zGS16379isri8aw6bxb01/1kt1h65y24x+d0zRosFx1tYLZZ9fc9usWxnP4vF4/XcDjwe
        h9+8Z/aY2PyO3WPnrLvsHptWdbJ5bPo0id3jxIzfLB7r/rxi8ujbsorRY/Ppao/Pm+QCuKK4
        bFJSczLLUov07RK4Mr4dPM5cMFmjomf3BbYGxjWKXYycHBICJhJH7zQwdjFycQgJ7GCUWPt8
        CTNEQkbizfmnLF2MHEC2sMThw8UQNV8ZJQ5ve8QGUsMmoC3xfsEkVpCEiMAcRomOI9/ZQBxm
        gQmMEscnTmcFqRIWCJL419jJAmKzCKhKbLtwnwnE5hWwleg8dpQNYoO8xML/zBMYeRYwMqxi
        lEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAgOUi2tHYx7Vn3QO8TIxMF4iFGCg1lJhDem
        ZFGcEG9KYmVValF+fFFpTmrxIUZpDhYlcd6vsxbGCQmkJ5akZqemFqQWwWSZODilGpjMCg58
        3fNOdlpbj+cEeQe+u29rg5Zlv645d4T/hNKj7Lssl/jfK7nbHzHKYf3eLpHRY3jryEGbKjOZ
        xEvaIWJKc3lnJvxYda5Zxup/6k5bi3nPp5xP61xyT+3lFp0pKW6Zzz5+sZ/anx66OvdOu+L0
        /yHcMmcyNgqtLnooLlAv1Nor9uhO6pp7u9a8naKmxlORs2jeuVuLpC3qWkMLZmg59ds7f7AX
        Wjv79R6na7W//k603aL8qD40f6PF3GeL3j93jDn27v/chMyw9prAHQpvWm+KFTKvVFtWIHx/
        0Y3pbu46AbwFbfKdvZxvFx4x/99x8dH61MVbdvQvlZ0XUfDc07vV4ZkD80HHFTWyn3OVWIoz
        Eg21mIuKEwGB3h5PwQIAAA==
X-CMS-MailID: 20200426011745epcas1p2255acdcaac77a0efc930337a2cb51aff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200426011745epcas1p2255acdcaac77a0efc930337a2cb51aff
References: <CGME20200426011745epcas1p2255acdcaac77a0efc930337a2cb51aff@epcas1p2.samsung.com>
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

Like log above, there were too much isolated files, 37664kB, which
triggers too_many_isolated in reclaim even when there is no actually
isolated file in system wide. It could be reproducible by running two
programs, writing on MADV_FREE page and doing cma alloc, respectively.
Although isolated anon is 0, I found that the internal value of isolated
anon was the negative value of isolated file.

Fix this by compensating the isolated count for both LRU lists. Count
non-discarded lazyfree pages in shrink_page_list, then compensate the
counted number in reclaim_clean_pages_from_list.

Reported-by: Yong-Taek Lee <ytk.lee@samsung.com>
Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
Suggested-by: and Acked-by: Minchan Kim <minchan@kernel.org>
---
v3: remove redundant PageAnon check and rename some variables
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
index b06868fc4926..5c78d480db98 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1295,11 +1295,15 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 		 */
 		if (page_mapped(page)) {
 			enum ttu_flags flags = ttu_flags | TTU_BATCH_FLUSH;
+			bool was_swapbacked = PageSwapBacked(page);
 
 			if (unlikely(PageTransHuge(page)))
 				flags |= TTU_SPLIT_HUGE_PMD;
+
 			if (!try_to_unmap(page, flags)) {
 				stat->nr_unmap_fail += nr_pages;
+				if (!was_swapbacked && PageSwapBacked(page))
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
+	unsigned long nr_reclaimed;
 	struct page *page, *next;
 	LIST_HEAD(clean_pages);
 
@@ -1504,11 +1508,21 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
 		}
 	}
 
-	ret = shrink_page_list(&clean_pages, zone->zone_pgdat, &sc,
-			TTU_IGNORE_ACCESS, &dummy_stat, true);
+	nr_reclaimed = shrink_page_list(&clean_pages, zone->zone_pgdat, &sc,
+			TTU_IGNORE_ACCESS, &stat, true);
 	list_splice(&clean_pages, page_list);
-	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_FILE, -ret);
-	return ret;
+	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_FILE, -nr_reclaimed);
+	/*
+	 * Since lazyfree pages are isolated from file LRU from the beginning,
+	 * they will rotate back to anonymous LRU in the end if it failed to
+	 * discard so isolated count will be mismatched.
+	 * Compensate the isolated count for both LRU lists.
+	 */
+	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_ANON,
+			    stat.nr_lazyfree_fail);
+	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_FILE,
+			    -stat.nr_lazyfree_fail);
+	return nr_reclaimed;
 }
 
 /*
-- 
2.13.7

