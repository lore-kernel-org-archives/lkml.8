Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B539BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 19:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0C7722BED
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 19:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="huVrgs/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgHDTmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 15:42:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28179 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728216AbgHDTmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 15:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596570122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dyDrSr/R3IYIedmMJp2EbzPQ1RIZu9oQIJgsVrWfxkI=;
        b=huVrgs/gRsetzl+fMFENhIJOYpppEbPfUk93qe0xSTRWUuwsj8EIQ2NaI7QAjTD01ya8Oh
        9fzIFkayRtV5+eRXTNVlFySa0OBQkixaoTOzH6+EGhmNJHa8wHJj61SovEmJXtJBNnNIDv
        KbHNnyTqlo8ZLuPu7K7cOSu7G9mcGfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-9Z2g_H3fPSev2zFAXNtB6A-1; Tue, 04 Aug 2020 15:41:58 -0400
X-MC-Unique: 9Z2g_H3fPSev2zFAXNtB6A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBE488015F3;
        Tue,  4 Aug 2020 19:41:56 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-95.ams2.redhat.com [10.36.113.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCF3672E4F;
        Tue,  4 Aug 2020 19:41:54 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S . Tsirkin" <mst@redhat.com>, Qian Cai <cai@lca.pw>
Subject: [PATCH v4 1/6] mm/page_isolation: don't dump_page(NULL) in set_migratetype_isolate()
Date:   Tue,  4 Aug 2020 21:41:37 +0200
Message-Id: <20200804194142.28279-2-david@redhat.com>
In-Reply-To: <20200804194142.28279-1-david@redhat.com>
References: <20200804194142.28279-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, if we have two isolations racing, we might trigger the
WARN_ON_ONCE() and to dump_page(NULL), dereferencing NULL. Let's just
return directly.

In the future, we might want to report -EAGAIN to the caller instead, as
this could indicate a temporary isolation failure only.

Reviewed-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Fixes: 4a55c0474a92 ("mm/hotplug: silence a lockdep splat with printk()")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Qian Cai <cai@lca.pw>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_isolation.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index f6d07c5f0d34d..7d7d263ce7f4b 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -29,10 +29,12 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	/*
 	 * We assume the caller intended to SET migrate type to isolate.
 	 * If it is already set, then someone else must have raced and
-	 * set it before us.  Return -EBUSY
+	 * set it before us.
 	 */
-	if (is_migrate_isolate_page(page))
-		goto out;
+	if (is_migrate_isolate_page(page)) {
+		spin_unlock_irqrestore(&zone->lock, flags);
+		return -EBUSY;
+	}
 
 	/*
 	 * FIXME: Now, memory hotplug doesn't call shrink_slab() by itself.
@@ -52,7 +54,6 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 		ret = 0;
 	}
 
-out:
 	spin_unlock_irqrestore(&zone->lock, flags);
 	if (!ret) {
 		drain_all_pages(zone);
-- 
2.26.2

