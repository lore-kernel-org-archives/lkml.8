Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B2FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93704206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4F6O/eF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgHSKNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 06:13:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28056 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726939AbgHSKMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 06:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597831949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sGBNUsemEVYoPvPS2oU0jxVSnfjl+UD7zzvj7A8crrg=;
        b=P4F6O/eF3WidEIK2PIE8mUIlpnIciDGqy7STtUIgajRNSxARaqWoovo//8LJ+EZkrjYPgf
        lT3BgaCVNDxL1uCuV7JZkfqS8+SN7UHecf45OUs6CCK9Gqtq9/CsevXe7GBv4yFNjYSedh
        clxLlmEA62b/8ONZQqsiqEFaxgB7mm0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-QbRKZeYQP_-f5hDIyiPyeg-1; Wed, 19 Aug 2020 06:12:25 -0400
X-MC-Unique: QbRKZeYQP_-f5hDIyiPyeg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FC321084C8F;
        Wed, 19 Aug 2020 10:12:24 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-11.ams2.redhat.com [10.36.114.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3717716597;
        Wed, 19 Aug 2020 10:12:22 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v1 07/11] mm/page_isolation: simplify return value of start_isolate_page_range()
Date:   Wed, 19 Aug 2020 12:11:53 +0200
Message-Id: <20200819101157.12723-8-david@redhat.com>
In-Reply-To: <20200819101157.12723-1-david@redhat.com>
References: <20200819101157.12723-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Callers no longer need the number of isolated pageblocks. Let's
simplify.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 2 +-
 mm/page_alloc.c     | 2 +-
 mm/page_isolation.c | 7 ++-----
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 098361fcb4504..0011a1115381c 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1503,7 +1503,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	ret = start_isolate_page_range(start_pfn, end_pfn,
 				       MIGRATE_MOVABLE,
 				       MEMORY_OFFLINE | REPORT_FAILURE);
-	if (ret < 0) {
+	if (ret) {
 		reason = "failure to isolate range";
 		goto failed_removal;
 	}
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 03f585f95dc60..848664352dfe2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8456,7 +8456,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 
 	ret = start_isolate_page_range(pfn_max_align_down(start),
 				       pfn_max_align_up(end), migratetype, 0);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	/*
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 242c03121d731..b066c860e606e 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -170,8 +170,7 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  * pageblocks we may have modified and return -EBUSY to caller. This
  * prevents two threads from simultaneously working on overlapping ranges.
  *
- * Return: the number of isolated pageblocks on success and -EBUSY if any part
- * of range cannot be isolated.
+ * Return: 0 on success and -EBUSY if any part of range cannot be isolated.
  */
 int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 			     unsigned migratetype, int flags)
@@ -179,7 +178,6 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 	unsigned long pfn;
 	unsigned long undo_pfn;
 	struct page *page;
-	int nr_isolate_pageblock = 0;
 
 	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
 	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
@@ -193,10 +191,9 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 				undo_pfn = pfn;
 				goto undo;
 			}
-			nr_isolate_pageblock++;
 		}
 	}
-	return nr_isolate_pageblock;
+	return 0;
 undo:
 	for (pfn = start_pfn;
 	     pfn < undo_pfn;
-- 
2.26.2

