Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EDCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F7F02078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0yHuXuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgE0GqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgE0GqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:46:03 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103BDC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:46:03 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ci21so1134160pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DH1Hdew4VRZCZhJxkyQryefaoqzOycwYmvHf5lPUN74=;
        b=Q0yHuXuLI71c7kOPwlXr4t8Ok3o0qsTJXGkXSY/LyuptMkVYki8i92yDxlVja+6Cx2
         syU3Ry3ooaq1PJB9xEX7wVoGXTExvIfwtMRXIHLSzpdvYfi/5x5R/6kN/s7HuSwN1Yi1
         1MM0d8k5TRhX3GI/TgygXGGqTIAbhato8S01QOHnNzfiYrBrqU3P4hA/cX7bi+rzdggM
         a6r/chg95PsnR6sc9sS92doJZIH2Q9Dxf3ZiXzhZWlLl6gFzR7/xteGxdluPTAhjMfr8
         eXEKJ2suLE1n7QhcCk7UGzsF8Tu6rHyvHfgNbK5FU7+5GKgO2QT5GhrdF16PbTcY94ZO
         hSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DH1Hdew4VRZCZhJxkyQryefaoqzOycwYmvHf5lPUN74=;
        b=t8oOKlsUHeeRbRJKo3TdBjRdqAevxpAKrG5kRKB6h7nQDXfkfmM3N2oKOBnHxVfHdD
         YmmAaOYl8a/ZZBueOb6IzmTLjVxJPMvKaSw62aM8nN689a5lxZcDHv0KUTvRHJzXJ2MO
         xBT8klQxkpaov+iiR305n0uKxuLwBTlsQzDWalALKG7Z0cdoV4MV7w++PI7b+F+8tlIv
         P5TMC0LILBl4IxQ1PFtiOAQ+2JTnTDkE8KWHjnNCmpM1WVuEjWY6s5KAsV7vq23Gt4DH
         BHVeLCFQyvRHrbej3WDjlSoBoVOkQ2IP+F425Wfau/dIcfTCLa4ZZ1g19Kx5U5qfedy/
         S9GQ==
X-Gm-Message-State: AOAM5336l1vGd66nLwZe7oql/lp3u79GMT/RhUQuNQnIXRaLU1CEE4P/
        9J1JBX3uCLHVINv/MIo4xRA=
X-Google-Smtp-Source: ABdhPJyx0G41Rs4o8104XqHZYQ36JBYP1fUYGFzqqpMG0zG/bKxDfppyxVjKUtDKNinBCmUScK644w==
X-Received: by 2002:a17:902:7e4e:: with SMTP id a14mr4452265pln.329.1590561962552;
        Tue, 26 May 2020 23:46:02 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id r13sm443883pgv.50.2020.05.26.23.45.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 23:46:02 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v2 06/12] mm/hugetlb: make hugetlb migration target allocation APIs CMA aware
Date:   Wed, 27 May 2020 15:44:57 +0900
Message-Id: <1590561903-13186-7-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

There is a user who do not want to use CMA memory for migration. Until
now, it is implemented by caller side but it's not optimal since there
is limited information on caller. This patch implements it on callee side
to get better result.

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/hugetlb.h |  2 --
 mm/gup.c                |  9 +++------
 mm/hugetlb.c            | 21 +++++++++++++++++----
 mm/internal.h           |  1 +
 4 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index f482563..3d05f7d 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -503,8 +503,6 @@ struct huge_bootmem_page {
 	struct hstate *hstate;
 };
 
-struct page *alloc_migrate_huge_page(struct hstate *h,
-				struct alloc_control *ac);
 struct page *alloc_huge_page_nodemask(struct hstate *h,
 				struct alloc_control *ac);
 struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
diff --git a/mm/gup.c b/mm/gup.c
index 6b78f11..87eca79 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1617,14 +1617,11 @@ static struct page *new_non_cma_page(struct page *page, unsigned long private)
 		struct alloc_control ac = {
 			.nid = nid,
 			.nmask = NULL,
-			.gfp_mask = gfp_mask,
+			.gfp_mask = __GFP_NOWARN,
+			.skip_cma = true,
 		};
 
-		/*
-		 * We don't want to dequeue from the pool because pool pages will
-		 * mostly be from the CMA region.
-		 */
-		return alloc_migrate_huge_page(h, &ac);
+		return alloc_huge_page_nodemask(h, &ac);
 	}
 
 	if (PageTransHuge(page)) {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8132985..e465582 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1033,13 +1033,19 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
 	h->free_huge_pages_node[nid]++;
 }
 
-static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
+static struct page *dequeue_huge_page_node_exact(struct hstate *h,
+						int nid, bool skip_cma)
 {
 	struct page *page;
 
-	list_for_each_entry(page, &h->hugepage_freelists[nid], lru)
+	list_for_each_entry(page, &h->hugepage_freelists[nid], lru) {
+		if (skip_cma && is_migrate_cma_page(page))
+			continue;
+
 		if (!PageHWPoison(page))
 			break;
+	}
+
 	/*
 	 * if 'non-isolated free hugepage' not found on the list,
 	 * the allocation fails.
@@ -1080,7 +1086,7 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h,
 			continue;
 		node = zone_to_nid(zone);
 
-		page = dequeue_huge_page_node_exact(h, node);
+		page = dequeue_huge_page_node_exact(h, node, ac->skip_cma);
 		if (page)
 			return page;
 	}
@@ -1937,7 +1943,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	return page;
 }
 
-struct page *alloc_migrate_huge_page(struct hstate *h,
+static struct page *alloc_migrate_huge_page(struct hstate *h,
 				struct alloc_control *ac)
 {
 	struct page *page;
@@ -1999,6 +2005,13 @@ struct page *alloc_huge_page_nodemask(struct hstate *h,
 	}
 	spin_unlock(&hugetlb_lock);
 
+	/*
+	 * clearing __GFP_MOVABLE flag ensure that allocated page
+	 * will not come from CMA area
+	 */
+	if (ac->skip_cma)
+		ac->gfp_mask &= ~__GFP_MOVABLE;
+
 	return alloc_migrate_huge_page(h, ac);
 }
 
diff --git a/mm/internal.h b/mm/internal.h
index 6e613ce..159cfd6 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -618,6 +618,7 @@ struct alloc_control {
 	int nid;		/* preferred node id */
 	nodemask_t *nmask;
 	gfp_t gfp_mask;
+	bool skip_cma;
 };
 
 #endif	/* __MM_INTERNAL_H */
-- 
2.7.4

