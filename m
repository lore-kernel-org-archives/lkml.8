Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFCFC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 12:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB72F20826
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 12:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXanpaO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgHPMyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 08:54:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58576 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728440AbgHPMx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 08:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597582436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5/ZhqaemaIZJrodfmnF3I3t2/SfX8dozv9khOOWmeJY=;
        b=YXanpaO2QUItGuRi+bqy4bEZ94Kwr70GOVQ/uePBHzrYXdryC+rv2S49jVB+p7K0RB5NWf
        IIfDuisLtXNuEQB745Mgl4nlJj9YkTXmn+LXrGlb/0JMZ5txMmGzlY5w1YeyJn2MVdCp8E
        M3zvzul/Lm9w0YJksMEPUFG3TiFvhUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-k7p1B1TFNRW7MXrOOuTcsw-1; Sun, 16 Aug 2020 08:53:54 -0400
X-MC-Unique: k7p1B1TFNRW7MXrOOuTcsw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0800F1855199;
        Sun, 16 Aug 2020 12:53:53 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-43.ams2.redhat.com [10.36.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 804746E717;
        Sun, 16 Aug 2020 12:53:48 +0000 (UTC)
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
Subject: [PATCH v5 3/6] mm/page_isolation: drop WARN_ON_ONCE() in set_migratetype_isolate()
Date:   Sun, 16 Aug 2020 14:53:30 +0200
Message-Id: <20200816125333.7434-4-david@redhat.com>
In-Reply-To: <20200816125333.7434-1-david@redhat.com>
References: <20200816125333.7434-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside has_unmovable_pages(), we have a comment describing how unmovable
data could end up in ZONE_MOVABLE - via "movablecore". Also, besides
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

