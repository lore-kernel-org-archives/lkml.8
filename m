Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16519C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA59320B80
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BKuMxjb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgD2OGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:06:18 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:48099 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbgD2OGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:06:16 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200429140613epoutp045e77169f26651be97796f157286a1b14~KT3Lc0RPg2636826368epoutp04Y
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 14:06:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200429140613epoutp045e77169f26651be97796f157286a1b14~KT3Lc0RPg2636826368epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588169173;
        bh=oEwo5iuvoaz/Z75vzSm5Xv3zjWzxpEMaF99L3uR/baE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=BKuMxjb2PWur4Wr/hiyJNehprM3N/rFC49JzvsRpElO1OZldWtJxk1RPGOaep3ykZ
         g92xA4hTn7WsVxYgW0se7+RbjO39AEZGhgXhYkF5CdDtl8MO+V2ExRuPFNd/iTYAoD
         3vDLb/82AVm5WmdIOytSMYMfgE5Hrr0zfyJ4oPaw=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20200429140612epcas5p4020b10eea17671f960ab3d96dbf84d5a~KT3KkBy9B0260202602epcas5p49;
        Wed, 29 Apr 2020 14:06:12 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        12.B5.10083.4D989AE5; Wed, 29 Apr 2020 23:06:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20200429135110epcas5p4377ad1a5d783d0634ab06e23993116a7~KTqDA9NUD0604506045epcas5p4Z;
        Wed, 29 Apr 2020 13:51:10 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200429135110epsmtrp2935efb325383037fffe2934f6cb2d81a~KTqDAMyj20135801358epsmtrp2F;
        Wed, 29 Apr 2020 13:51:10 +0000 (GMT)
X-AuditID: b6c32a4a-875ff70000002763-23-5ea989d4510c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.A0.25866.E4689AE5; Wed, 29 Apr 2020 22:51:10 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.135]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200429135109epsmtip2dac40d2a001284e394f5451139ee832d~KTqBh970X1466314663epsmtip2V;
        Wed, 29 Apr 2020 13:51:09 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     mhocko@suse.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        a.sahrawat@samsung.com, v.narang@samsung.com,
        Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH v3] mm/vmscan.c: change prototype for shrink_page_list
Date:   Wed, 29 Apr 2020 19:20:59 +0530
Message-Id: <1588168259-25604-1-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsWy7bCmlu6VzpVxBut+i1hc3J1qMWf9GjaL
        y7vmsFncW/Of1eLw/DYWi/t9DhaHTs5ldGD32PRpErvHiRm/WTz6tqxi9Fi/5SqLx+dNcgGs
        UVw2Kak5mWWpRfp2CVwZFw50MxXslKvoWSvdwLhZoouRk0NCwETi984pTCC2kMBuRolnO+26
        GLmA7E+MEh/uXGWCcD4zSqyevogFpmPqv23sEIldjBILFm5hhHC+Mkr82LqGHaSKTUBPYtWu
        PUAdHBwiQPafJzogNcwCExglju/awQgSFxZwk5jz0wOknEVAVeL206dgZ/AKuEs82XiADWKZ
        nMTNc53MIL0SAuvYJea/bGcH6ZUQcJG4v7seokZY4tXxLewQtpTE53d72SDqmxklPu1bywjh
        TGGUWHrxIytElb3E6+YGJpBBzAKaEut36UOEZSWmnloHdgSzAJ9E7+8nTBBxXokd82BsVYmW
        mxugxkhLfP74ERoqHhIvlz+FhmOsxLNHx1kmMMrOQtiwgJFxFaNkakFxbnpqsWmBUV5quV5x
        Ym5xaV66XnJ+7iZGcMxree1gXHbO5xCjAAejEg+vRerKOCHWxLLiytxDjBIczEoivI8ylsUJ
        8aYkVlalFuXHF5XmpBYfYpTmYFES59ViBKoWSE8sSc1OTS1ILYLJMnFwSjUwWrAdibU7b506
        rUN75cvsyqnvOHOXp9zce0/t39rJHY925/794KMgMInr2YTd3iErs9/I1Bs8YajenXAx4NfX
        LaduJwtmqPF4+E/75LzxgKiq5KmXDv9mznjz1WCpDVP4Be2f5jMPSeX9n2k7o7/50cneuye1
        npscOGMjF2q/hfV3e5mf3MmLCUosxRmJhlrMRcWJAJzUhF31AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDJMWRmVeSWpSXmKPExsWy7bCSvK5f28o4g8lb9C0u7k61mLN+DZvF
        5V1z2CzurfnPanF4fhuLxf0+B4tDJ+cyOrB7bPo0id3jxIzfLB59W1YxeqzfcpXF4/MmuQDW
        KC6blNSczLLUIn27BK6MCwe6mQp2ylX0rJVuYNws0cXIySEhYCIx9d829i5GLg4hgR2MEtPP
        bmOGSEhL/Pz3ngXCFpZY+e85VNFnRomXb+eAJdgE9CRW7doDZosIGEicmrOCCaSIWWAKo0TD
        on9ADgeHsICbxJyfHiA1LAKqErefPmUCsXkF3CWebDzABrFATuLmuU7mCYw8CxgZVjFKphYU
        56bnFhsWGOWllusVJ+YWl+al6yXn525iBAeQltYOxj2rPugdYmTiYDzEKMHBrCTC+yhjWZwQ
        b0piZVVqUX58UWlOavEhRmkOFiVx3q+zFsYJCaQnlqRmp6YWpBbBZJk4OKUamMTb2p497Ixu
        k4nfMjUi5lnzuZRHOfMuy3iFs/usy54X5vricmbWDrXKP+7spxecUV4WM2NFFmdt55q7hvcU
        vTk0r1gx7S5S+2Z08p2XgLvIrRXn763lvH7lwZw0baYKs/OFPT6GLr4JNYklx6b5lz2pXO2f
        fp2pctYF3aBYjzdLNAq+aSUzrai44zVXp4b5YZnA3dcLPXoe253kuP3C7u/l3sO2m6af4ZJz
        Uf5QvH7Wj5Pr+ecZbLBKUTsb/F+s5JsKZ0PJ9/2xLUdET3frXpIPrPn8z1vCJPLf4e0GG2bI
        t693uBnSt0Jn36uyNaZfnp+9+nrOvpSySZ0as+e2H/qx/9e5PyedMuwfTsnir1diKc5INNRi
        LipOBADkgWFYjwIAAA==
X-CMS-MailID: 20200429135110epcas5p4377ad1a5d783d0634ab06e23993116a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200429135110epcas5p4377ad1a5d783d0634ab06e23993116a7
References: <CGME20200429135110epcas5p4377ad1a5d783d0634ab06e23993116a7@epcas5p4.samsung.com>
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
v1 -> v2: position of variable changed mistakenly, thus reverted.
v2 -> v3: Don't change position of any variable, thus reverted.
	  if required then need to send by separate patch.

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
index b06868f..7631725 100644
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
 
@@ -1900,7 +1900,7 @@ static int current_may_throttle(void)
 {
 	LIST_HEAD(page_list);
 	unsigned long nr_scanned;
-	unsigned long nr_reclaimed = 0;
+	unsigned int nr_reclaimed = 0;
 	unsigned long nr_taken;
 	struct reclaim_stat stat;
 	int file = is_file_lru(lru);
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

