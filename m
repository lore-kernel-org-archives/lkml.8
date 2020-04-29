Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6D9C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14DC7214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="T4sqCGUz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgD2NAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:00:44 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:49204 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgD2NAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:00:43 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200429130040epoutp03a370fb86393d6332c04504b70738913e~KS98wms6n0144201442epoutp03c
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 13:00:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200429130040epoutp03a370fb86393d6332c04504b70738913e~KS98wms6n0144201442epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588165240;
        bh=uRUQIukj/rCNvkl85MJQQAAdTNwuw5HToUOLXDyKcto=;
        h=From:To:Cc:Subject:Date:References:From;
        b=T4sqCGUzHY/+1xE0AMFIHTIMs/jwRCmy+JwKB/RR77HHVEO3hM6bKFATlgQR64WMn
         zKekYepMRK9xHtcylI2+cl+i5dttYn4XO9/bT8V9N25c7lAdrAPjZvd7Ge0MUM4tj+
         pvmUTPwnuOO+Y4IXphQaDgU34uaBNSsa6xpxiw5k=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20200429130039epcas5p470bbeef7ad11480f89fa277a75c3962b~KS97pOyMb2186221862epcas5p4y;
        Wed, 29 Apr 2020 13:00:39 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.B7.04736.77A79AE5; Wed, 29 Apr 2020 22:00:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20200429125853epcas5p494c3f081a7610f42d293d08d3daf7dee~KS8YqyYRZ2186621866epcas5p4s;
        Wed, 29 Apr 2020 12:58:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200429125853epsmtrp26ad7c606db305c51d9789c49d6986b0c~KS8YqD1jL0566405664epsmtrp2E;
        Wed, 29 Apr 2020 12:58:53 +0000 (GMT)
X-AuditID: b6c32a4b-ae3ff70000001280-f5-5ea97a77ce9c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.C1.18461.C0A79AE5; Wed, 29 Apr 2020 21:58:52 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.135]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200429125851epsmtip2dcccc7be7bfe1d8beeed5d185cdae578~KS8XPA4fA2342223422epsmtip2H;
        Wed, 29 Apr 2020 12:58:51 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     mhocko@suse.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        a.sahrawat@samsung.com, v.narang@samsung.com,
        Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH v2] mm/vmscan.c: change prototype for shrink_page_list
Date:   Wed, 29 Apr 2020 18:28:34 +0530
Message-Id: <1588165114-24954-1-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsWy7bCmhm551co4g1c7hC0u7k61mLN+DZvF
        5V1z2CzurfnPanF4fhuLxf0+B4tDJ+cyOrB7bPo0id3jxIzfLB59W1YxeqzfcpXF4/MmuQDW
        KC6blNSczLLUIn27BK6Mjfs/MBWskq+Yu+AJewPjNMkuRk4OCQETiaNXD7N0MXJxCAnsZpS4
        N+s0K4TziVHi6t6vUJlvjBLrdh1kgmm5ffUOVGIvo8S110/ZIJyvjBLTTzSzgVSxCehJrNq1
        B6iKg0MEyP7zRAekhllgAqPE8V07GEFqhAXcJK79eMsKYrMIqErMufSCHaSeV8Bd4tTTIohl
        chI3z3Uyg/RKCKxjl9i2s5kZIuEiMXXpEUYIW1ji1fEt7BC2lMTnd3vZIBqaGSU+7VvLCOFM
        YZRYevEjK0SVvcTr5gYmkG3MApoS63fpQ4RlJaaeWgf2JrMAn0Tv7ydQL/NK7JgHY6tKtNzc
        ADVGWuLzx48sELaHRPfrg2BHCAnESjRMm8IygVF2FsKGBYyMqxglUwuKc9NTi00LjPNSy/WK
        E3OLS/PS9ZLzczcxgiNfy3sH46ZzPocYBTgYlXh4LVJXxgmxJpYVV+YeYpTgYFYS4X2UsSxO
        iDclsbIqtSg/vqg0J7X4EKM0B4uSOK8WI1C1QHpiSWp2ampBahFMlomDU6qBUZs1/8yS5Tb7
        v24K5blWNv/S057/vwoinga2uf14uO3vBPNgHalb+02+Ld3s46TaEGoyOea+/dOvwl1FfBE/
        Ugu8Vyvz8L8/f8VFqDH5bUwsz26H3T2vo79umj7Fqoux4Ev4V6kasceuUxfad/yaUvXnT8j9
        fct+LbJyNCy1EjNbV+see0F/jxJLcUaioRZzUXEiAEpw86r4AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLJMWRmVeSWpSXmKPExsWy7bCSvC5P1co4gy0nrC0u7k61mLN+DZvF
        5V1z2CzurfnPanF4fhuLxf0+B4tDJ+cyOrB7bPo0id3jxIzfLB59W1YxeqzfcpXF4/MmuQDW
        KC6blNSczLLUIn27BK6Mjfs/MBWskq+Yu+AJewPjNMkuRk4OCQETidtX77B0MXJxCAnsZpTo
        vjyJDSIhLfHz33sWCFtYYuW/5+wQRZ8ZJea/3AlWxCagJ7Fq1x6wIhEBA4lTc1YwgRQxC0xh
        lGhY9I8JJCEs4CZx7cdbVhCbRUBVYs6lF0CTODh4BdwlTj0tglggJ3HzXCfzBEaeBYwMqxgl
        UwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgkNIS3MH4/ZVH/QOMTJxMB5ilOBgVhLhfZSx
        LE6INyWxsiq1KD++qDQntfgQozQHi5I4743ChXFCAumJJanZqakFqUUwWSYOTqkGpgUSr7+t
        KPwtpjPb+shND4HYKWclZjFotN1cX/tvS2j/TA3/A3dk9R0FZe58EZkuzzkvhcOpTOeZ3EnJ
        4EMVL7J1fZYtM/8Q03hLw2hW3GSRrACxBetVrN+frSoQWjHlbOyHO2kZPlKN36Z/nxL3/W2I
        qLHLMouQr9tePTsz/VB9TN4Cy7qZEfcX1y0puf+prPKp455jhZEbUlM6r3DdZdNSf64a7uZ2
        ZUbhbYVZ0Vuyz132UApxnhBwnP+3cqRd3rdbtycFyhjJ8tnfW5CwsPa7Z5ZeVozZbUZhP+WI
        BGaDl22pR3Rd2/+vm7DQPX7LiT5dq1v5Vz59ik2cv+Ha96NcIjUmrx7a9DXrbOvkUWIpzkg0
        1GIuKk4EALOun0qQAgAA
X-CMS-MailID: 20200429125853epcas5p494c3f081a7610f42d293d08d3daf7dee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200429125853epcas5p494c3f081a7610f42d293d08d3daf7dee
References: <CGME20200429125853epcas5p494c3f081a7610f42d293d08d3daf7dee@epcas5p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'commit 3c710c1ad11b ("mm, vmscan:
extract shrink_page_list reclaim counters into a struct")'

changed data type for the function,
so changing return type for funciton and its caller.

Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
v1 -> v2: position of variable changed mistakenly, reverted.

 mm/internal.h   |  2 +-
 mm/page_alloc.c |  2 +-
 mm/vmscan.c     | 24 ++++++++++++------------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index b5634e7..c3eeec8 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -527,7 +527,7 @@ extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
         unsigned long, unsigned long);
 
 extern void set_pageblock_order(void);
-unsigned long reclaim_clean_pages_from_list(struct zone *zone,
+unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 					    struct list_head *page_list);
 /* The ALLOC_WMARK bits are used as an index to zone->watermark */
 #define ALLOC_WMARK_MIN		WMARK_MIN
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1385d78..f17d88c6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8416,7 +8416,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 					unsigned long start, unsigned long end)
 {
 	/* This function is based on compact_zone() from compaction.c. */
-	unsigned long nr_reclaimed;
+	unsigned int nr_reclaimed;
 	unsigned long pfn = start;
 	unsigned int tries = 0;
 	int ret = 0;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b06868f..8076012 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1066,17 +1066,17 @@ static void page_check_dirty_writeback(struct page *page,
 /*
  * shrink_page_list() returns the number of reclaimed pages
  */
-static unsigned long shrink_page_list(struct list_head *page_list,
-				      struct pglist_data *pgdat,
-				      struct scan_control *sc,
-				      enum ttu_flags ttu_flags,
-				      struct reclaim_stat *stat,
-				      bool ignore_references)
+static unsigned int shrink_page_list(struct list_head *page_list,
+				     struct pglist_data *pgdat,
+				     struct scan_control *sc,
+				     enum ttu_flags ttu_flags,
+				     struct reclaim_stat *stat,
+				     bool ignore_references)
 {
 	LIST_HEAD(ret_pages);
 	LIST_HEAD(free_pages);
-	unsigned nr_reclaimed = 0;
-	unsigned pgactivate = 0;
+	unsigned int nr_reclaimed = 0;
+	unsigned int pgactivate = 0;
 
 	memset(stat, 0, sizeof(*stat));
 	cond_resched();
@@ -1483,7 +1483,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 	return nr_reclaimed;
 }
 
-unsigned long reclaim_clean_pages_from_list(struct zone *zone,
+unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 					    struct list_head *page_list)
 {
 	struct scan_control sc = {
@@ -1492,7 +1492,7 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
 		.may_unmap = 1,
 	};
 	struct reclaim_stat dummy_stat;
-	unsigned long ret;
+	unsigned int ret;
 	struct page *page, *next;
 	LIST_HEAD(clean_pages);
 
@@ -1900,13 +1900,13 @@ static int current_may_throttle(void)
 {
 	LIST_HEAD(page_list);
 	unsigned long nr_scanned;
-	unsigned long nr_reclaimed = 0;
 	unsigned long nr_taken;
 	struct reclaim_stat stat;
 	int file = is_file_lru(lru);
 	enum vm_event_item item;
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 	struct zone_reclaim_stat *reclaim_stat = &lruvec->reclaim_stat;
+	unsigned int nr_reclaimed = 0;
 	bool stalled = false;
 
 	while (unlikely(too_many_isolated(pgdat, file, sc))) {
@@ -2096,7 +2096,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 unsigned long reclaim_pages(struct list_head *page_list)
 {
 	int nid = NUMA_NO_NODE;
-	unsigned long nr_reclaimed = 0;
+	unsigned int nr_reclaimed = 0;
 	LIST_HEAD(node_page_list);
 	struct reclaim_stat dummy_stat;
 	struct page *page;
-- 
1.9.1

