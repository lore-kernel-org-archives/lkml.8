Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30B6C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 18:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D572082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 18:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODV+Ck8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgAJSdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 13:33:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52702 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726346AbgAJSdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 13:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578681198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AfY6I+Jr68YEu7YUFTcg4DnPY/tyhy8K9GXAwlaWuVA=;
        b=ODV+Ck8H7kp1kMdM3TxBfYq+gjqW4utndZ4T02qMjeL5vr4uWZ9ayKH35uLTno+5+1vF83
        awd4dsa52TejWtH9WQEP5zS5N24KmKnldNNoDiPZJocVkjY/IdZSqml1m2Zko8ZrEaBBV9
        5xNBORRWPn0Cq8N4WIXP1RKyujnBAGI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-Ege3kR3sPWasfHwKMAAzVA-1; Fri, 10 Jan 2020 13:33:15 -0500
X-MC-Unique: Ege3kR3sPWasfHwKMAAzVA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 650D0477;
        Fri, 10 Jan 2020 18:33:13 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.36.118.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2847C5C1C3;
        Fri, 10 Jan 2020 18:33:09 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v1] mm/memory_hotplug: drop valid_start/valid_end from test_pages_in_a_zone()
Date:   Fri, 10 Jan 2020 19:33:08 +0100
Message-Id: <20200110183308.11849-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The callers are only interested in the actual zone, they don't care
about boundaries. Return the zone instead to simplify.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c          |  9 ++++-----
 include/linux/memory_hotplug.h |  4 ++--
 mm/memory_hotplug.c            | 31 +++++++++----------------------
 3 files changed, 15 insertions(+), 29 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index d4b9178aaf81..8b3ab910b812 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -406,7 +406,6 @@ static ssize_t valid_zones_show(struct device *dev,
 	struct memory_block *mem =3D to_memory_block(dev);
 	unsigned long start_pfn =3D section_nr_to_pfn(mem->start_section_nr);
 	unsigned long nr_pages =3D PAGES_PER_SECTION * sections_per_block;
-	unsigned long valid_start_pfn, valid_end_pfn;
 	struct zone *default_zone;
 	int nid;
=20
@@ -419,11 +418,11 @@ static ssize_t valid_zones_show(struct device *dev,
 		 * The block contains more than one zone can not be offlined.
 		 * This can happen e.g. for ZONE_DMA and ZONE_DMA32
 		 */
-		if (!test_pages_in_a_zone(start_pfn, start_pfn + nr_pages,
-					  &valid_start_pfn, &valid_end_pfn))
+		default_zone =3D test_pages_in_a_zone(start_pfn,
+						    start_pfn + nr_pages);
+		if (!default_zone)
 			return sprintf(buf, "none\n");
-		start_pfn =3D valid_start_pfn;
-		strcat(buf, page_zone(pfn_to_page(start_pfn))->name);
+		strcat(buf, default_zone->name);
 		goto out;
 	}
=20
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplu=
g.h
index ffa6ad12d84a..f4d59155f3d4 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -96,8 +96,8 @@ extern int add_one_highpage(struct page *page, int pfn,=
 int bad_ppro);
 /* VM interface that may be used by firmware interface */
 extern int online_pages(unsigned long pfn, unsigned long nr_pages,
 			int online_type, int nid);
-extern int test_pages_in_a_zone(unsigned long start_pfn, unsigned long e=
nd_pfn,
-	unsigned long *valid_start, unsigned long *valid_end);
+extern struct zone *test_pages_in_a_zone(unsigned long start_pfn,
+					 unsigned long end_pfn);
 extern unsigned long __offline_isolated_pages(unsigned long start_pfn,
 						unsigned long end_pfn);
=20
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index a7611c80d65a..fb1c878d054d 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1172,14 +1172,13 @@ bool is_mem_section_removable(unsigned long start=
_pfn, unsigned long nr_pages)
 }
=20
 /*
- * Confirm all pages in a range [start, end) belong to the same zone.
- * When true, return its valid [start, end).
+ * Confirm all pages in a range [start, end) belong to the same zone (sk=
ipping
+ * memory holes). When true, return the zone.
  */
-int test_pages_in_a_zone(unsigned long start_pfn, unsigned long end_pfn,
-			 unsigned long *valid_start, unsigned long *valid_end)
+struct zone *test_pages_in_a_zone(unsigned long start_pfn,
+				  unsigned long end_pfn)
 {
 	unsigned long pfn, sec_end_pfn;
-	unsigned long start, end;
 	struct zone *zone =3D NULL;
 	struct page *page;
 	int i;
@@ -1200,24 +1199,15 @@ int test_pages_in_a_zone(unsigned long start_pfn,=
 unsigned long end_pfn,
 				continue;
 			/* Check if we got outside of the zone */
 			if (zone && !zone_spans_pfn(zone, pfn + i))
-				return 0;
+				return NULL;
 			page =3D pfn_to_page(pfn + i);
 			if (zone && page_zone(page) !=3D zone)
-				return 0;
-			if (!zone)
-				start =3D pfn + i;
+				return NULL;
 			zone =3D page_zone(page);
-			end =3D pfn + MAX_ORDER_NR_PAGES;
 		}
 	}
=20
-	if (zone) {
-		*valid_start =3D start;
-		*valid_end =3D min(end, end_pfn);
-		return 1;
-	} else {
-		return 0;
-	}
+	return zone;
 }
=20
 /*
@@ -1462,7 +1452,6 @@ static int __ref __offline_pages(unsigned long star=
t_pfn,
 	unsigned long offlined_pages =3D 0;
 	int ret, node, nr_isolate_pageblock;
 	unsigned long flags;
-	unsigned long valid_start, valid_end;
 	struct zone *zone;
 	struct memory_notify arg;
 	char *reason;
@@ -1487,14 +1476,12 @@ static int __ref __offline_pages(unsigned long st=
art_pfn,
=20
 	/* This makes hotplug much easier...and readable.
 	   we assume this for now. .*/
-	if (!test_pages_in_a_zone(start_pfn, end_pfn, &valid_start,
-				  &valid_end)) {
+	zone =3D test_pages_in_a_zone(start_pfn, end_pfn);
+	if (!zone) {
 		ret =3D -EINVAL;
 		reason =3D "multizone range";
 		goto failed_removal;
 	}
-
-	zone =3D page_zone(pfn_to_page(valid_start));
 	node =3D zone_to_nid(zone);
=20
 	/* set above range as isolated */
--=20
2.24.1

