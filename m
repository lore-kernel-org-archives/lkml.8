Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A6BC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D894922482
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+1F/opQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgGTG0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 02:26:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57573 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725805AbgGTG0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 02:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595226395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=Zyt3oU1PwvKyyQwBguqx/PgkPJhshO7+egL1SG4muyY=;
        b=K+1F/opQGiWAl6TncOlxcNAdUkNDrUhDmGMVLLiiarRJQh0Cuv5SfWIvZktmW22ZOp/n2x
        saxi8A0epaiMtATgMv05//B0f3zecKmQ1Aea34EyB4wji53K5t2Pi5BH5GT7prxm2vWzoi
        yEmThlOi7UIW60ewu4CkTfuyxHc3k+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-xk7XVNNwOJG2WQNrkNYSjw-1; Mon, 20 Jul 2020 02:26:30 -0400
X-MC-Unique: xk7XVNNwOJG2WQNrkNYSjw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D01E107ACCA;
        Mon, 20 Jul 2020 06:26:29 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-150.pek2.redhat.com [10.72.12.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7AF37852B;
        Mon, 20 Jul 2020 06:26:27 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, bhe@redhat.com
Subject: [PATCH 1/5] mm/hugetlb.c: Fix typo of glb_reserve
Date:   Mon, 20 Jul 2020 14:26:19 +0800
Message-Id: <20200720062623.13135-2-bhe@redhat.com>
In-Reply-To: <20200720062623.13135-1-bhe@redhat.com>
References: <20200720062623.13135-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local variable is for global reservation of region.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/hugetlb.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f24acb3af741..191a585bb315 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3649,7 +3649,7 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)
 	struct resv_map *resv = vma_resv_map(vma);
 	struct hugepage_subpool *spool = subpool_vma(vma);
 	unsigned long reserve, start, end;
-	long gbl_reserve;
+	long glb_reserve;
 
 	if (!resv || !is_vma_resv_set(vma, HPAGE_RESV_OWNER))
 		return;
@@ -3664,8 +3664,8 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)
 		 * Decrement reserve counts.  The global reserve count may be
 		 * adjusted if the subpool has a minimum size.
 		 */
-		gbl_reserve = hugepage_subpool_put_pages(spool, reserve);
-		hugetlb_acct_memory(h, -gbl_reserve);
+		glb_reserve = hugepage_subpool_put_pages(spool, reserve);
+		hugetlb_acct_memory(h, -glb_reserve);
 	}
 
 	kref_put(&resv->refs, resv_map_release);
@@ -5054,7 +5054,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	struct resv_map *resv_map;
 	struct hugetlb_cgroup *h_cg = NULL;
-	long gbl_reserve, regions_needed = 0;
+	long glb_reserve, regions_needed = 0;
 
 	/* This should never happen */
 	if (from > to) {
@@ -5121,10 +5121,10 @@ int hugetlb_reserve_pages(struct inode *inode,
 	/*
 	 * There must be enough pages in the subpool for the mapping. If
 	 * the subpool has a minimum size, there may be some global
-	 * reservations already in place (gbl_reserve).
+	 * reservations already in place (glb_reserve).
 	 */
-	gbl_reserve = hugepage_subpool_get_pages(spool, chg);
-	if (gbl_reserve < 0) {
+	glb_reserve = hugepage_subpool_get_pages(spool, chg);
+	if (glb_reserve < 0) {
 		ret = -ENOSPC;
 		goto out_uncharge_cgroup;
 	}
@@ -5133,7 +5133,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	 * Check enough hugepages are available for the reservation.
 	 * Hand the pages back to the subpool if there are not
 	 */
-	ret = hugetlb_acct_memory(h, gbl_reserve);
+	ret = hugetlb_acct_memory(h, glb_reserve);
 	if (ret < 0) {
 		goto out_put_pages;
 	}
@@ -5153,7 +5153,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 		add = region_add(resv_map, from, to, regions_needed, h, h_cg);
 
 		if (unlikely(add < 0)) {
-			hugetlb_acct_memory(h, -gbl_reserve);
+			hugetlb_acct_memory(h, -glb_reserve);
 			goto out_put_pages;
 		} else if (unlikely(chg > add)) {
 			/*
@@ -5200,7 +5200,7 @@ long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 	struct resv_map *resv_map = inode_resv_map(inode);
 	long chg = 0;
 	struct hugepage_subpool *spool = subpool_inode(inode);
-	long gbl_reserve;
+	long glb_reserve;
 
 	/*
 	 * Since this routine can be called in the evict inode path for all
@@ -5225,8 +5225,8 @@ long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 	 * If the subpool has a minimum size, the number of global
 	 * reservations to be released may be adjusted.
 	 */
-	gbl_reserve = hugepage_subpool_put_pages(spool, (chg - freed));
-	hugetlb_acct_memory(h, -gbl_reserve);
+	glb_reserve = hugepage_subpool_put_pages(spool, (chg - freed));
+	hugetlb_acct_memory(h, -glb_reserve);
 
 	return 0;
 }
-- 
2.17.2

