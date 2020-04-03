Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35187C2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F0D20757
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JR09QoXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388210AbgDCFld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 01:41:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36086 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729349AbgDCFlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 01:41:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id c23so3002078pgj.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 22:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PGmzb8UxKP2obZ2hRRmNukkpDvHaqG21Hk67bEIKtgs=;
        b=JR09QoXSNbBg28nXbmYJlqlma5NOT/BgLD7wvGBTcGFvGFAgYtLCu9nwNnjHYHQbOr
         ckoEOrXwaHenjnuBQpp76655Fa9RoUQBOIh2xtKt0s51R+krtPiiB4JXvkDqIRttqHac
         D07zPODRsve+ZnUojsGvjnBE5Ae4ZjtpAzb20e5/FBsedcY+05C00GR14mJWEi7rMKmW
         nk1QQoUuK6iuxsqdWhUaGiG4EjCCUSpVLrbfLtdP9EoA8KrfdyXTPRQiwq8FniJKd1MY
         9xF1BUt7WX4khFtCnUjj1WHB1jQMlg3R6M9eYNprhtBGUAyw9eoda8F04p394gFIg5lE
         yazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PGmzb8UxKP2obZ2hRRmNukkpDvHaqG21Hk67bEIKtgs=;
        b=mhhaICbD/joDUeBc7c3TXClmSjCKCKnnRapMt9hNwE4vaHHjgQqhNnCWFtdlk3yPsW
         5m32VcQs5xAUABZmrUoQ42diSmeEABgSqKNlFPqaLg86fm0C+whGsqlY0ohKr96zeD87
         qsVWUguTsYcwv/7IQmlPSDWZzXzzEdzHPKzawcBvgg93lx0BVpS0thdOYRA1mLULWQ/T
         MQc9jbhVnBryPpzUSAvcihaG5k4owJQbvD1/X363b3KXqaoniRafNDPNfNRG1yumE412
         rwNiorqQi87tuZzauNlUICfU1BlUgD8CaqlIbOwGDRCDM7+aCLDtht2vko08TDrpoBiZ
         kK0A==
X-Gm-Message-State: AGi0PuapXggmG9qTorNrCzi02yhwC9RewtkEzcTTr/oafzE27vklt2Ds
        xY6RsuwnMReBVMRyWXzyD/c=
X-Google-Smtp-Source: APiQypJVYeiNLUHoSnC+GoIJQaU/PRi7OFSvzEsO+JLkwBbacDZJjhcy/+34LUl0RfMG2wUiSaD02Q==
X-Received: by 2002:aa7:8f29:: with SMTP id y9mr5726738pfr.19.1585892490028;
        Thu, 02 Apr 2020 22:41:30 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id e6sm4568295pgu.44.2020.04.02.22.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Apr 2020 22:41:29 -0700 (PDT)
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
Subject: [PATCH v5 07/10] mm/workingset: support to remember the previous owner of the page
Date:   Fri,  3 Apr 2020 14:40:45 +0900
Message-Id: <1585892447-32059-8-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585892447-32059-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1585892447-32059-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

This patch supports to remember the previous owner of the page.
Since there is not enough spare bits in shadow entry for this information,
only a few bits of the memcg id of the page is stored. Although this
information is insufficient, it would provide enough level of the ability
to check the previous owner.

This patch is for the preparation of the following patch, "mm/swap:
do not readahead if the previous owner of the swap entry isn't me".

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/workingset.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 59415e0..871b867 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -168,8 +168,20 @@
  * refault distance will immediately activate the refaulting page.
  */
 
+/*
+ * memcg_tag will be used to check the previous owner of the page.
+ * Since we don't have enough spare bits in shadow entry, just a few
+ * bits are used to approximate the previous owner.
+ */
+#if BITS_PER_LONG == 32
+#define PAGE_MEMCG_TAG_SHIFT 4
+#else
+#define PAGE_MEMCG_TAG_SHIFT 8
+#endif
+
 #define EVICTION_SHIFT	((BITS_PER_LONG - BITS_PER_XA_VALUE) +	\
-			 1 + NODES_SHIFT + MEM_CGROUP_ID_SHIFT)
+			 1 + NODES_SHIFT + MEM_CGROUP_ID_SHIFT + \
+			 PAGE_MEMCG_TAG_SHIFT)
 #define EVICTION_MASK	(~0UL >> EVICTION_SHIFT)
 
 /*
@@ -182,11 +194,12 @@
  */
 static unsigned int bucket_order __read_mostly;
 
-static void *pack_shadow(int memcgid, pg_data_t *pgdat, unsigned long eviction,
-			 bool workingset)
+static void *pack_shadow(int memcgid, int page_memcg_tag, pg_data_t *pgdat,
+			unsigned long eviction, bool workingset)
 {
 	eviction >>= bucket_order;
 	eviction &= EVICTION_MASK;
+	eviction = (eviction << PAGE_MEMCG_TAG_SHIFT) | page_memcg_tag;
 	eviction = (eviction << MEM_CGROUP_ID_SHIFT) | memcgid;
 	eviction = (eviction << NODES_SHIFT) | pgdat->node_id;
 	eviction = (eviction << 1) | workingset;
@@ -194,11 +207,12 @@ static void *pack_shadow(int memcgid, pg_data_t *pgdat, unsigned long eviction,
 	return xa_mk_value(eviction);
 }
 
-static void unpack_shadow(void *shadow, int *memcgidp, pg_data_t **pgdat,
-			  unsigned long *evictionp, bool *workingsetp)
+static void unpack_shadow(void *shadow, int *memcgidp, int *page_memcg_tagp,
+			pg_data_t **pgdat, unsigned long *evictionp,
+			bool *workingsetp)
 {
 	unsigned long entry = xa_to_value(shadow);
-	int memcgid, nid;
+	int memcgid, page_memcg_tag, nid;
 	bool workingset;
 
 	workingset = entry & 1;
@@ -207,8 +221,11 @@ static void unpack_shadow(void *shadow, int *memcgidp, pg_data_t **pgdat,
 	entry >>= NODES_SHIFT;
 	memcgid = entry & ((1UL << MEM_CGROUP_ID_SHIFT) - 1);
 	entry >>= MEM_CGROUP_ID_SHIFT;
+	page_memcg_tag = entry & ((1UL << PAGE_MEMCG_TAG_SHIFT) - 1);
+	entry >>= PAGE_MEMCG_TAG_SHIFT;
 
 	*memcgidp = memcgid;
+	*page_memcg_tagp = page_memcg_tag;
 	*pgdat = NODE_DATA(nid);
 	*evictionp = entry << bucket_order;
 	*workingsetp = workingset;
@@ -248,9 +265,9 @@ void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg)
 {
 	struct pglist_data *pgdat = page_pgdat(page);
 	bool file = page_is_file_cache(page);
+	int memcgid, page_memcg_tag;
 	unsigned long eviction;
 	struct lruvec *lruvec;
-	int memcgid;
 
 	/* Page is fully exclusive and pins page->mem_cgroup */
 	VM_BUG_ON_PAGE(PageLRU(page), page);
@@ -262,8 +279,11 @@ void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg)
 	lruvec = mem_cgroup_lruvec(target_memcg, pgdat);
 	/* XXX: target_memcg can be NULL, go through lruvec */
 	memcgid = mem_cgroup_id(lruvec_memcg(lruvec));
+	page_memcg_tag = mem_cgroup_id(page_memcg(page));
+	page_memcg_tag &= (1UL << PAGE_MEMCG_TAG_SHIFT) - 1;
 	eviction = atomic_long_read(&lruvec->inactive_age[file]);
-	return pack_shadow(memcgid, pgdat, eviction, PageWorkingset(page));
+	return pack_shadow(memcgid, page_memcg_tag, pgdat, eviction,
+			PageWorkingset(page));
 }
 
 /**
@@ -281,6 +301,7 @@ void workingset_refault(struct page *page, void *shadow)
 	struct mem_cgroup *eviction_memcg;
 	struct lruvec *eviction_lruvec;
 	unsigned long refault_distance;
+	int memcgid, page_memcg_tag;
 	struct pglist_data *pgdat;
 	struct mem_cgroup *memcg;
 	unsigned long eviction;
@@ -288,9 +309,9 @@ void workingset_refault(struct page *page, void *shadow)
 	unsigned long refault;
 	unsigned long active;
 	bool workingset;
-	int memcgid;
 
-	unpack_shadow(shadow, &memcgid, &pgdat, &eviction, &workingset);
+	unpack_shadow(shadow, &memcgid, &page_memcg_tag,
+			&pgdat, &eviction, &workingset);
 
 	rcu_read_lock();
 	/*
-- 
2.7.4

