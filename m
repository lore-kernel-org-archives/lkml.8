Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB762C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 05:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6435214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 05:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gf3ZYuJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgBFFj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 00:39:27 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57923 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725809AbgBFFj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 00:39:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580967565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=+ZgCDJ3lYDHO7PerX7DHQHL7BbjicVXkT8EFJG70WMU=;
        b=gf3ZYuJXHiNGRlxW1iral6tsOt3oVAS6LOfGPIbJglk8X26jOc5PP7xpGRWhfLjdqbOiNM
        eFIDF8CKML6pb/xNgLxHOY0JwueWYF+vT4mgFvOU8uAIDRMGGedHt1MEw+rq+KQfXg5rk9
        t4q5wlQdYYQWd2pY3izv1H3YM4VkomA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-IzDqwx8BMTm_-srL3eoidw-1; Thu, 06 Feb 2020 00:39:21 -0500
X-MC-Unique: IzDqwx8BMTm_-srL3eoidw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25DF31800D42;
        Thu,  6 Feb 2020 05:39:20 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-19.pek2.redhat.com [10.72.12.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1F0185732;
        Thu,  6 Feb 2020 05:39:14 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        richardw.yang@linux.intel.com, david@redhat.com, mhocko@suse.com,
        osalvador@suse.de, bhe@redhat.com
Subject: [PATCH] mm/hotplug: Adjust shrink_zone_span() to keep the old logic
Date:   Thu,  6 Feb 2020 13:39:12 +0800
Message-Id: <20200206053912.1211-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 950b68d9178b ("mm/memory_hotplug: don't check for "all holes"
in shrink_zone_span()"), the zone->zone_start_pfn/->spanned_pages
resetting is moved into the if()/else if() branches, if the zone becomes
empty. However the 2nd resetting code block may cause misunderstanding.

So take the resetting codes out of the conditional checking and handling
branches just as the old code does, the find_smallest_section_pfn()and
find_biggest_section_pfn() searching have done the the same thing as
the old for loop did, the logic is kept the same as the old code. This
can remove the possible confusion.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/memory_hotplug.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 089b6c826a9e..475d0d68a32c 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -398,7 +398,7 @@ static unsigned long find_biggest_section_pfn(int nid, struct zone *zone,
 static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 			     unsigned long end_pfn)
 {
-	unsigned long pfn;
+	unsigned long pfn = zone->zone_start_pfn;
 	int nid = zone_to_nid(zone);
 
 	zone_span_writelock(zone);
@@ -414,9 +414,6 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 		if (pfn) {
 			zone->spanned_pages = zone_end_pfn(zone) - pfn;
 			zone->zone_start_pfn = pfn;
-		} else {
-			zone->zone_start_pfn = 0;
-			zone->spanned_pages = 0;
 		}
 	} else if (zone_end_pfn(zone) == end_pfn) {
 		/*
@@ -429,10 +426,11 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 					       start_pfn);
 		if (pfn)
 			zone->spanned_pages = pfn - zone->zone_start_pfn + 1;
-		else {
-			zone->zone_start_pfn = 0;
-			zone->spanned_pages = 0;
-		}
+	}
+
+	if (!pfn) {
+		zone->zone_start_pfn = 0;
+		zone->spanned_pages = 0;
 	}
 	zone_span_writeunlock(zone);
 }
-- 
2.17.2

