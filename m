Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA19C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 06:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D67702082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 06:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="owqEtA0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgD2GGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 02:06:48 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:34865 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgD2GGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 02:06:47 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200429060643epoutp038ef48187842ce02bfeaae997b613aa19~KNUhvKjnC1650316503epoutp03H
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 06:06:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200429060643epoutp038ef48187842ce02bfeaae997b613aa19~KNUhvKjnC1650316503epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588140403;
        bh=98y/XyTwJ4iPZVCs8cYUACoI6a1kWGJu8IFt2uHtaQ0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=owqEtA0WSmA51fWeOcyez05NJd68HG7Ss7u9ixfZjq+GiU18Ef5/6y23MTruvcgR1
         jEJ3lBdW+jm+mHP+zScZ8zWPF07glQXjR1lblw1XKF2vkAXij5Cmwg1D2swqGWKn7p
         h02XHYUC0VUZDFjHlsFdcI7SYx6t15sZTN0cadzQ=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20200429060642epcas5p164315869dcae04fd9849d63deb76e59e~KNUg2q1Bk0304203042epcas5p1L;
        Wed, 29 Apr 2020 06:06:42 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E2.A9.04736.27919AE5; Wed, 29 Apr 2020 15:06:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20200429055946epcas5p2d5faf2b320913d59a4a8380cb017053c~KNOdJYe-82584225842epcas5p2P;
        Wed, 29 Apr 2020 05:59:46 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200429055946epsmtrp219f6ab510ac3c30f8b977dd611d5cf6d~KNOdIUfSt0779007790epsmtrp2e;
        Wed, 29 Apr 2020 05:59:46 +0000 (GMT)
X-AuditID: b6c32a4b-acbff70000001280-07-5ea91972cea9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        BB.03.25866.2D719AE5; Wed, 29 Apr 2020 14:59:46 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.135]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200429055945epsmtip267af4824a0a69a11027c97532fca3d48~KNObvXtWc1947919479epsmtip2L;
        Wed, 29 Apr 2020 05:59:44 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     mhocko@suse.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        a.sahrawat@samsung.com, v.narang@samsung.com,
        Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 1/1] mm/vmscan.c: change prototype for shrink_page_list
Date:   Wed, 29 Apr 2020 11:29:27 +0530
Message-Id: <1588139967-19012-1-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsWy7bCmhm6R5Mo4g8u/jS0u7k61mLN+DZvF
        5V1z2CzurfnPanF4fhuLxf0+B4tDJ+cyOrB7bPo0id3jxIzfLB59W1YxeqzfcpXF4/MmuQDW
        KC6blNSczLLUIn27BK6Mg9vWMhdckKt4dX0eawPjEYkuRk4OCQETifkXOlhBbCGB3YwSO9Y4
        dzFyAdmfGCXO3//PDJH4zCjxf184TMPBuR3sEEW7GCUu7FnKDOF8ZZS43LyUBaSKTUBPYtWu
        PUA2B4cIkP3niQ5IDbPABEaJ47t2MILUCAu4S8w5spgdxGYRUJV4deU5WC8vULxn3UFmiG1y
        EjfPdYItkBBYxy4x5UcbK0TCRaJx7m52CFtY4tXxLVC2lMTnd3vZIBqaGSU+7VvLCOFMYZRY
        evEjVLe9xOvmBiaQ85gFNCXW79KHCMtKTD21jgnEZhbgk+j9/YQJIs4rsWMejK0q0XJzA9QY
        aYnPHz+CfSkh4CFxayoziCkkECtxb2fwBEbZWQjzFzAyrmKUTC0ozk1PLTYtMM5LLdcrTswt
        Ls1L10vOz93ECI55Le8djJvO+RxiFOBgVOLh3cCzIk6INbGsuDL3EKMEB7OSCO+jjGVxQrwp
        iZVVqUX58UWlOanFhxilOViUxHm1GFfGCQmkJ5akZqemFqQWwWSZODilGhiz1sx84W74/dYm
        btWQte3rCx6zWwc84tx4ntNutp7Uh7u5Ow801KXEzTTob1503PnxvAk2Qofm8aqmLv7ZyjA/
        teDv0UfNTlvNV7KyZNjMWfarmHWPx+PVkVfPfHKsXPYzW8aJ351Ffs1Lp4MPxHt843YXsvkW
        8Zyoe2iq8W9XhdC1+3dvP/FSYinOSDTUYi4qTgQAwNY+y/UCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLJMWRmVeSWpSXmKPExsWy7bCSvO4l8ZVxBiuPy1hc3J1qMWf9GjaL
        y7vmsFncW/Of1eLw/DYWi/t9DhaHTs5ldGD32PRpErvHiRm/WTz6tqxi9Fi/5SqLx+dNcgGs
        UVw2Kak5mWWpRfp2CVwZB7etZS64IFfx6vo81gbGIxJdjJwcEgImEgfndrCD2EICOxglXrS4
        Q8SlJX7+e88CYQtLrPz3HKiGC6jmM6PEhOUz2EASbAJ6Eqt27QErEhEwkDg1ZwUTSBGzwBRG
        iYZF/5hAEsIC7hJzjiwG28AioCrx6spzsAZeoHjPuoPMEBvkJG6e62SewMizgJFhFaNkakFx
        bnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcAhpae1g3LPqg94hRiYOxkOMEhzMSiK8jzKWxQnx
        piRWVqUW5ccXleakFh9ilOZgURLn/TprYZyQQHpiSWp2ampBahFMlomDU6qBSeOafoqWMS/n
        aYsH965nTD3bqR2vsnHW5+dvZ/T77mXp+T5ntcHK9Knq6/7vv38y+GfRdvNX/XELep+/MVvh
        N91TZPb2K2tCuabvtfo2SWjVxEsZO+5dkRJ042OSbzPzTP44Lyhlc6DLsoPMxfc6NI/rMK3f
        sl+8qkko+Vj5+w1rUuIvLLEMduTeKzDnocQ0p6SQJxMvbs7yvKxps9bndF6b6J1UtjP2icwm
        1YpnDY/l+ty2OsD8IkHzaU/hv7Nv+nnTt6+2zek4c+Ra2LrGeZeaL8QdmVe9Ii7uXNNLptS6
        zeW9769Y1C0U+ijYuX1Bz2Kxpc7d817sLvsdW6u0vf2u0+1U7pKrj8uMHetfSyuxFGckGmox
        FxUnAgAzokO2kAIAAA==
X-CMS-MailID: 20200429055946epcas5p2d5faf2b320913d59a4a8380cb017053c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200429055946epcas5p2d5faf2b320913d59a4a8380cb017053c
References: <CGME20200429055946epcas5p2d5faf2b320913d59a4a8380cb017053c@epcas5p2.samsung.com>
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
index b06868f..e561ba5 100644
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
@@ -1483,16 +1483,16 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 	return nr_reclaimed;
 }
 
-unsigned long reclaim_clean_pages_from_list(struct zone *zone,
+unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 					    struct list_head *page_list)
 {
+	unsigned int ret;
 	struct scan_control sc = {
 		.gfp_mask = GFP_KERNEL,
 		.priority = DEF_PRIORITY,
 		.may_unmap = 1,
 	};
 	struct reclaim_stat dummy_stat;
-	unsigned long ret;
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

