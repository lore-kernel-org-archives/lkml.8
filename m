Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4242C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C73FC2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dXLX4YjQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgG3Jer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:34:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31283 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729362AbgG3Jeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 05:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596101684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=94kv3iM7voNuc/GuCMOJeaJASAgCqOV3S0igLlKUpuI=;
        b=dXLX4YjQNpvvJedn7pAEJOcR3GWiNoByNPvE5myBGUlKP2c+RbZYmWugnr56gRW/toxfSU
        SteQxtFEJFQDkIdJtWrgYCALzK2kiui5Y4GCldOQ3hmnY4xIjSG5LONutiKF+y7srDuest
        I1eXDEWDbw6dElIFepmIjrLmqAzS3ys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-2H-Ycm88OFC9QgFeOjH7fw-1; Thu, 30 Jul 2020 05:34:40 -0400
X-MC-Unique: 2H-Ycm88OFC9QgFeOjH7fw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E10FF106B24A;
        Thu, 30 Jul 2020 09:34:24 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-185.ams2.redhat.com [10.36.113.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF9BD6179D;
        Thu, 30 Jul 2020 09:34:22 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v2 2/6] mm/page_alloc: tweak comments in has_unmovable_pages()
Date:   Thu, 30 Jul 2020 11:34:12 +0200
Message-Id: <20200730093416.36210-3-david@redhat.com>
In-Reply-To: <20200730093416.36210-1-david@redhat.com>
References: <20200730093416.36210-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's move the split comment regarding bootmem allocations and memory
holes, especially in the context of ZONE_MOVABLE, to the PageReserved()
check.

Reviewed-by: Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e028b87ce2942..042ba09d70c5d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8207,14 +8207,6 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 	unsigned long iter = 0;
 	unsigned long pfn = page_to_pfn(page);
 
-	/*
-	 * TODO we could make this much more efficient by not checking every
-	 * page in the range if we know all of them are in MOVABLE_ZONE and
-	 * that the movable zone guarantees that pages are migratable but
-	 * the later is not the case right now unfortunatelly. E.g. movablecore
-	 * can still lead to having bootmem allocations in zone_movable.
-	 */
-
 	if (is_migrate_cma_page(page)) {
 		/*
 		 * CMA allocations (alloc_contig_range) really need to mark
@@ -8233,6 +8225,12 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 
 		page = pfn_to_page(pfn + iter);
 
+		/*
+		 * Both, bootmem allocations and memory holes are marked
+		 * PG_reserved and are unmovable. We can even have unmovable
+		 * allocations inside ZONE_MOVABLE, for example when
+		 * specifying "movablecore".
+		 */
 		if (PageReserved(page))
 			return page;
 
@@ -8306,14 +8304,6 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 		 * it.  But now, memory offline itself doesn't call
 		 * shrink_node_slabs() and it still to be fixed.
 		 */
-		/*
-		 * If the page is not RAM, page_count()should be 0.
-		 * we don't need more check. This is an _used_ not-movable page.
-		 *
-		 * The problematic thing here is PG_reserved pages. PG_reserved
-		 * is set to both of a memory hole page and a _used_ kernel
-		 * page at boot.
-		 */
 		return page;
 	}
 	return NULL;
-- 
2.26.2

