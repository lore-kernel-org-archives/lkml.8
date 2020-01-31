Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBC9C33CB7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 04:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28AF92082E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 04:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580445753;
	bh=tc8PQxhVfKJfQcbTG/KVfgOoLmbQ/ZhkxfIbKyRJClI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=iYa3H6mja86Q+dmVlipfPG2Yt+xv3Dlw43AbxJLfe3p0Y3Me7GkmDr03V/Lp5ZRzL
	 xwK24/4+6UUsANCNNnV5msiUFMcNLKqcCsx5TDy0WBe+u8u9uGAU1Mg8LK1uTk88+6
	 tleTwNZrkvcQOmHO87XQ8uqfesAOjCBB0RZjtvkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgAaEmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 23:42:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbgAaEmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 23:42:32 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B85D12082E;
        Fri, 31 Jan 2020 04:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580445750;
        bh=tc8PQxhVfKJfQcbTG/KVfgOoLmbQ/ZhkxfIbKyRJClI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ws65Cw8vqHXxmgx/LrHV0jnY6y+W/njbgykt2jklMrNNoZIAKz1qrjRNZGcXbMNSh
         U1i11F6nU1fTEKK+Mmkmq3ewgNgu2jH36/V8RANO93wSFq5s0d/BnGckSBWApbRYmp
         FPt0mHyWP9fnZeN39g12gs5xS4bFsnLFpRqazyWw=
Date:   Thu, 30 Jan 2020 20:42:29 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1] mm/memory_hotplug: drop valid_start/valid_end from
 test_pages_in_a_zone()
Message-Id: <20200130204229.c305b86ab9082062516b9995@linux-foundation.org>
In-Reply-To: <20200110183308.11849-1-david@redhat.com>
References: <20200110183308.11849-1-david@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 19:33:08 +0100 David Hildenbrand <david@redhat.com> wrote:

> The callers are only interested in the actual zone, they don't care
> about boundaries. Return the zone instead to simplify.
> 

Any reviewers for this one?

From: David Hildenbrand <david@redhat.com>
Subject: mm/memory_hotplug: drop valid_start/valid_end from test_pages_in_a_zone()

The callers are only interested in the actual zone, they don't care about
boundaries.  Return the zone instead to simplify.

Link: http://lkml.kernel.org/r/20200110183308.11849-1-david@redhat.com
Signed-off-by: David Hildenbrand <david@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/base/memory.c          |    9 ++++-----
 include/linux/memory_hotplug.h |    4 ++--
 mm/memory_hotplug.c            |   31 +++++++++----------------------
 3 files changed, 15 insertions(+), 29 deletions(-)

--- a/drivers/base/memory.c~mm-memory_hotplug-drop-valid_start-valid_end-from-test_pages_in_a_zone
+++ a/drivers/base/memory.c
@@ -376,7 +376,6 @@ static ssize_t valid_zones_show(struct d
 	struct memory_block *mem = to_memory_block(dev);
 	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
 	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
-	unsigned long valid_start_pfn, valid_end_pfn;
 	struct zone *default_zone;
 	int nid;
 
@@ -389,11 +388,11 @@ static ssize_t valid_zones_show(struct d
 		 * The block contains more than one zone can not be offlined.
 		 * This can happen e.g. for ZONE_DMA and ZONE_DMA32
 		 */
-		if (!test_pages_in_a_zone(start_pfn, start_pfn + nr_pages,
-					  &valid_start_pfn, &valid_end_pfn))
+		default_zone = test_pages_in_a_zone(start_pfn,
+						    start_pfn + nr_pages);
+		if (!default_zone)
 			return sprintf(buf, "none\n");
-		start_pfn = valid_start_pfn;
-		strcat(buf, page_zone(pfn_to_page(start_pfn))->name);
+		strcat(buf, default_zone->name);
 		goto out;
 	}
 
--- a/include/linux/memory_hotplug.h~mm-memory_hotplug-drop-valid_start-valid_end-from-test_pages_in_a_zone
+++ a/include/linux/memory_hotplug.h
@@ -95,8 +95,8 @@ extern int zone_grow_waitqueues(struct z
 extern int add_one_highpage(struct page *page, int pfn, int bad_ppro);
 /* VM interface that may be used by firmware interface */
 extern int online_pages(unsigned long, unsigned long, int);
-extern int test_pages_in_a_zone(unsigned long start_pfn, unsigned long end_pfn,
-	unsigned long *valid_start, unsigned long *valid_end);
+extern struct zone *test_pages_in_a_zone(unsigned long start_pfn,
+					 unsigned long end_pfn);
 extern unsigned long __offline_isolated_pages(unsigned long start_pfn,
 						unsigned long end_pfn);
 
--- a/mm/memory_hotplug.c~mm-memory_hotplug-drop-valid_start-valid_end-from-test_pages_in_a_zone
+++ a/mm/memory_hotplug.c
@@ -1206,14 +1206,13 @@ bool is_mem_section_removable(unsigned l
 }
 
 /*
- * Confirm all pages in a range [start, end) belong to the same zone.
- * When true, return its valid [start, end).
+ * Confirm all pages in a range [start, end) belong to the same zone (skipping
+ * memory holes). When true, return the zone.
  */
-int test_pages_in_a_zone(unsigned long start_pfn, unsigned long end_pfn,
-			 unsigned long *valid_start, unsigned long *valid_end)
+struct zone *test_pages_in_a_zone(unsigned long start_pfn,
+				  unsigned long end_pfn)
 {
 	unsigned long pfn, sec_end_pfn;
-	unsigned long start, end;
 	struct zone *zone = NULL;
 	struct page *page;
 	int i;
@@ -1234,24 +1233,15 @@ int test_pages_in_a_zone(unsigned long s
 				continue;
 			/* Check if we got outside of the zone */
 			if (zone && !zone_spans_pfn(zone, pfn + i))
-				return 0;
+				return NULL;
 			page = pfn_to_page(pfn + i);
 			if (zone && page_zone(page) != zone)
-				return 0;
-			if (!zone)
-				start = pfn + i;
+				return NULL;
 			zone = page_zone(page);
-			end = pfn + MAX_ORDER_NR_PAGES;
 		}
 	}
 
-	if (zone) {
-		*valid_start = start;
-		*valid_end = min(end, end_pfn);
-		return 1;
-	} else {
-		return 0;
-	}
+	return zone;
 }
 
 /*
@@ -1496,7 +1486,6 @@ static int __ref __offline_pages(unsigne
 	unsigned long offlined_pages = 0;
 	int ret, node, nr_isolate_pageblock;
 	unsigned long flags;
-	unsigned long valid_start, valid_end;
 	struct zone *zone;
 	struct memory_notify arg;
 	char *reason;
@@ -1521,14 +1510,12 @@ static int __ref __offline_pages(unsigne
 
 	/* This makes hotplug much easier...and readable.
 	   we assume this for now. .*/
-	if (!test_pages_in_a_zone(start_pfn, end_pfn, &valid_start,
-				  &valid_end)) {
+	zone = test_pages_in_a_zone(start_pfn, end_pfn);
+	if (!zone) {
 		ret = -EINVAL;
 		reason = "multizone range";
 		goto failed_removal;
 	}
-
-	zone = page_zone(pfn_to_page(valid_start));
 	node = zone_to_nid(zone);
 
 	/* set above range as isolated */
_

