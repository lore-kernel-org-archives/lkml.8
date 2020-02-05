Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7B4C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9ADD2051A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgBEJ7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 04:59:12 -0500
Received: from mga02.intel.com ([134.134.136.20]:6920 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbgBEJ7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 04:59:11 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 01:59:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,405,1574150400"; 
   d="scan'208";a="343395725"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga001.fm.intel.com with ESMTP; 05 Feb 2020 01:59:07 -0800
Date:   Wed, 5 Feb 2020 17:59:24 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH v6 08/10] mm/memory_hotplug: Don't check for "all holes"
 in shrink_zone_span()
Message-ID: <20200205095924.GC24162@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20191006085646.5768-1-david@redhat.com>
 <20191006085646.5768-9-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191006085646.5768-9-david@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2019 at 10:56:44AM +0200, David Hildenbrand wrote:
>If we have holes, the holes will automatically get detected and removed
>once we remove the next bigger/smaller section. The extra checks can
>go.
>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Oscar Salvador <osalvador@suse.de>
>Cc: Michal Hocko <mhocko@suse.com>
>Cc: David Hildenbrand <david@redhat.com>
>Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
>Cc: Dan Williams <dan.j.williams@intel.com>
>Cc: Wei Yang <richardw.yang@linux.intel.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>
>---
> mm/memory_hotplug.c | 34 +++++++---------------------------
> 1 file changed, 7 insertions(+), 27 deletions(-)
>
>diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>index f294918f7211..8dafa1ba8d9f 100644
>--- a/mm/memory_hotplug.c
>+++ b/mm/memory_hotplug.c
>@@ -393,6 +393,9 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
> 		if (pfn) {
> 			zone->zone_start_pfn = pfn;
> 			zone->spanned_pages = zone_end_pfn - pfn;
>+		} else {
>+			zone->zone_start_pfn = 0;
>+			zone->spanned_pages = 0;
> 		}
> 	} else if (zone_end_pfn == end_pfn) {
> 		/*
>@@ -405,34 +408,11 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
> 					       start_pfn);
> 		if (pfn)
> 			zone->spanned_pages = pfn - zone_start_pfn + 1;
>+		else {
>+			zone->zone_start_pfn = 0;
>+			zone->spanned_pages = 0;
>+		}
> 	}

If it is me, I would like to take out these two similar logic out.

For example:

	if () {
	} else if () {
	} else {
		goto out;
	}


	/* The zone has no valid section */
	if (!pfn) {
			zone->zone_start_pfn = 0;
			zone->spanned_pages = 0;
	}

out:
	zone_span_writeunlock(zone);

Well, this is just my personal taste :-)

>-
>-	/*
>-	 * The section is not biggest or smallest mem_section in the zone, it
>-	 * only creates a hole in the zone. So in this case, we need not
>-	 * change the zone. But perhaps, the zone has only hole data. Thus
>-	 * it check the zone has only hole or not.
>-	 */
>-	pfn = zone_start_pfn;
>-	for (; pfn < zone_end_pfn; pfn += PAGES_PER_SUBSECTION) {
>-		if (unlikely(!pfn_to_online_page(pfn)))
>-			continue;
>-
>-		if (page_zone(pfn_to_page(pfn)) != zone)
>-			continue;
>-
>-		/* Skip range to be removed */
>-		if (pfn >= start_pfn && pfn < end_pfn)
>-			continue;
>-
>-		/* If we find valid section, we have nothing to do */
>-		zone_span_writeunlock(zone);
>-		return;
>-	}
>-
>-	/* The zone has no valid section */
>-	zone->zone_start_pfn = 0;
>-	zone->spanned_pages = 0;
> 	zone_span_writeunlock(zone);
> }
> 
>-- 
>2.21.0

-- 
Wei Yang
Help you, Help me
