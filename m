Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3063C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 846BD206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABeyLQRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgHSKMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 06:12:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50558 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727798AbgHSKMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 06:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597831937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ygYF8AfHKYq7FFtUYuO8Zbjd9G+c4jkdgGgMMa4Az1w=;
        b=ABeyLQRlrySpz2CPcN2hpQwjuhFBOB0qmbDJHWWjRqmacgaJI75wkvHD7/eUcghDd/VYQe
        U/Nu/6snuZPks92QDswY59G/8GOccjyDiod8cHeUFAA4M3hfxIXz80E3Zm6XNCHdjQrnK5
        6yrAXLvC2Y9aS6J3s6Pu54EBJJRJVR8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-XJQTw8nvM5OudnJKj_bo_w-1; Wed, 19 Aug 2020 06:12:14 -0400
X-MC-Unique: XJQTw8nvM5OudnJKj_bo_w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A69811DDFD;
        Wed, 19 Aug 2020 10:12:12 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-11.ams2.redhat.com [10.36.114.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA105277B7;
        Wed, 19 Aug 2020 10:12:10 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v1 03/11] mm/memory_hotplug: simplify checking if all pages are isolated in offline_pages()
Date:   Wed, 19 Aug 2020 12:11:49 +0200
Message-Id: <20200819101157.12723-4-david@redhat.com>
In-Reply-To: <20200819101157.12723-1-david@redhat.com>
References: <20200819101157.12723-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We make sure that we cannot have any memory holes right at the beginning
of offline_pages(). We no longer need walk_system_ram_range() and can
call test_pages_isolated() directly.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 6856702af68d9..f64478349148d 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1384,17 +1384,6 @@ offline_isolated_pages_cb(unsigned long start, unsigned long nr_pages,
 	return 0;
 }
 
-/*
- * Check all pages in range, recorded as memory resource, are isolated.
- */
-static int
-check_pages_isolated_cb(unsigned long start_pfn, unsigned long nr_pages,
-			void *data)
-{
-	return test_pages_isolated(start_pfn, start_pfn + nr_pages,
-				   MEMORY_OFFLINE);
-}
-
 static int __init cmdline_parse_movable_node(char *p)
 {
 	movable_node_enabled = true;
@@ -1579,10 +1568,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 			reason = "failure to dissolve huge pages";
 			goto failed_removal_isolated;
 		}
-		/* check again */
-		ret = walk_system_ram_range(start_pfn, end_pfn - start_pfn,
-					    NULL, check_pages_isolated_cb);
-	} while (ret);
+	} while (test_pages_isolated(start_pfn, end_pfn, MEMORY_OFFLINE));
 
 	/* Ok, all of our target is isolated.
 	   We cannot do rollback at this point. */
-- 
2.26.2

