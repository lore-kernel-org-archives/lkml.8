Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8058C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A45A420DD4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZSRxq2t3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732690AbgFSNYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:24:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24789 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732644AbgFSNYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592573084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eGlNqou5LDoam9OH21SBUp2++cVRlrtERoD4CCiv5eg=;
        b=ZSRxq2t3FfWZtlGW034m7BFz7WsrEqsRTH9TOQvsEEvHP/4y0vZKTbWOdj6t5gmwXkugr5
        QtkITl+ofpY0f6aalocauzIje/HanSiHu1kB9GgMsWgcDygKkZHuXB7hUbyC0S2054adMc
        DiKmTktyWc6KwwhW4bUXW8gMY4rI4kU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-oAxdefiAP_u9TarLyJnNkA-1; Fri, 19 Jun 2020 09:24:42 -0400
X-MC-Unique: oAxdefiAP_u9TarLyJnNkA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED09A80F5C6;
        Fri, 19 Jun 2020 13:24:20 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-137.ams2.redhat.com [10.36.113.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 150C719D61;
        Fri, 19 Jun 2020 13:24:18 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v1 2/2] mm/page_alloc: drop nr_free_pagecache_pages()
Date:   Fri, 19 Jun 2020 15:24:10 +0200
Message-Id: <20200619132410.23859-3-david@redhat.com>
In-Reply-To: <20200619132410.23859-1-david@redhat.com>
References: <20200619132410.23859-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nr_free_pagecache_pages() isn't used outside page_alloc.c anymore - and
the name does not really help to understand what's going on. Let's inline
it instead and add a comment.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/swap.h |  1 -
 mm/page_alloc.c      | 16 ++--------------
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 124261acd5d0a..9bde6c6b2c045 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -327,7 +327,6 @@ void workingset_update_node(struct xa_node *node);
 /* linux/mm/page_alloc.c */
 extern unsigned long totalreserve_pages;
 extern unsigned long nr_free_buffer_pages(void);
-extern unsigned long nr_free_pagecache_pages(void);
 
 /* Definition of global_zone_page_state not available yet */
 #define nr_free_pages() global_zone_page_state(NR_FREE_PAGES)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7b0dde69748c1..c38903d1b3b4d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5177,19 +5177,6 @@ unsigned long nr_free_buffer_pages(void)
 }
 EXPORT_SYMBOL_GPL(nr_free_buffer_pages);
 
-/**
- * nr_free_pagecache_pages - count number of pages beyond high watermark
- *
- * nr_free_pagecache_pages() counts the number of pages which are beyond the
- * high watermark within all zones.
- *
- * Return: number of pages beyond high watermark within all zones.
- */
-unsigned long nr_free_pagecache_pages(void)
-{
-	return nr_free_zone_pages(gfp_zone(GFP_HIGHUSER_MOVABLE));
-}
-
 static inline void show_node(struct zone *zone)
 {
 	if (IS_ENABLED(CONFIG_NUMA))
@@ -5911,7 +5898,8 @@ void __ref build_all_zonelists(pg_data_t *pgdat)
 		__build_all_zonelists(pgdat);
 		/* cpuset refresh routine should be here */
 	}
-	vm_total_pages = nr_free_pagecache_pages();
+	/* Get the number of free pages beyond high watermark in all zones. */
+	vm_total_pages = nr_free_zone_pages(gfp_zone(GFP_HIGHUSER_MOVABLE));
 	/*
 	 * Disable grouping by mobility if the number of pages in the
 	 * system is too low to allow the mechanism to work. It would be
-- 
2.26.2

