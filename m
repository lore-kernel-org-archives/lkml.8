Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1BDC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A93421744
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMvV/kdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgG3Je4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:34:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50401 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729389AbgG3Jeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 05:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596101689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lt1g0htUa/bc8OboHGsnEp9sr/LuEltQUA5QpsfHh1k=;
        b=VMvV/kdBjG35uTcJ0MJfQT+Q4pqsWodjUnkR6Kwvi1e202CEb65qxpqz7V4VwI5FZ/HgpY
        JFYo/maP3a+oNb2qIyKBpNh0fD668D54g3raPTakyKclGfun/9lg6vjqbUfXjOftKh/X9I
        hhrZHoix/IJ8DUppHPTD36gcNkAfBSo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-np1QuLGtNa--F5CHcmUTlA-1; Thu, 30 Jul 2020 05:34:45 -0400
X-MC-Unique: np1QuLGtNa--F5CHcmUTlA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 330898DFFC8;
        Thu, 30 Jul 2020 09:34:27 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-185.ams2.redhat.com [10.36.113.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3AEE05FC31;
        Thu, 30 Jul 2020 09:34:25 +0000 (UTC)
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
Subject: [PATCH v2 3/6] mm/page_isolation: drop WARN_ON_ONCE() in set_migratetype_isolate()
Date:   Thu, 30 Jul 2020 11:34:13 +0200
Message-Id: <20200730093416.36210-4-david@redhat.com>
In-Reply-To: <20200730093416.36210-1-david@redhat.com>
References: <20200730093416.36210-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside has_unmovable_pages(), we have a comment describing how unmovable
data could end up in ZONE_MOVABLE - via "movable_core". Also, besides
checking if the first page in the pageblock is reserved, we don't
perform any further checks in case of ZONE_MOVABLE.

In case of memory offlining, we set REPORT_FAILURE, properly
dump_page() the page and handle the error gracefully.
alloc_contig_pages() users currently never allocate from ZONE_MOVABLE.
E.g., hugetlb uses alloc_contig_pages() for the allocation of gigantic
pages only, which will never end up on the MOVABLE zone
(see htlb_alloc_mask()).

Reviewed-by: Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_isolation.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 7d7d263ce7f4b..d099aac479601 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -57,15 +57,12 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	spin_unlock_irqrestore(&zone->lock, flags);
 	if (!ret) {
 		drain_all_pages(zone);
-	} else {
-		WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
-
-		if ((isol_flags & REPORT_FAILURE) && unmovable)
-			/*
-			 * printk() with zone->lock held will likely trigger a
-			 * lockdep splat, so defer it here.
-			 */
-			dump_page(unmovable, "unmovable page");
+	} else if ((isol_flags & REPORT_FAILURE) && unmovable) {
+		/*
+		 * printk() with zone->lock held will likely trigger a
+		 * lockdep splat, so defer it here.
+		 */
+		dump_page(unmovable, "unmovable page");
 	}
 
 	return ret;
-- 
2.26.2

