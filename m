Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6FFC352A1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA9421927
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csholPkl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgBEOsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:48:35 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46599 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726334AbgBEOse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:48:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580914113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=95aJqeVITxcGTfX0TCyAquXczebVTrMMk8jxCMfrdaA=;
        b=csholPklvLJoEHzFfu9LFT9gxzMrcpncGEy7oe69ILdvOfG3/gp7OjkeegT5nqAxbQTmtN
        6BycIpZyO/+3LB+OH97P3R56TU7Hi4xdLVn9jzu7bM0emW4dMZuM0EwzJov31UXAnLWedV
        JRHRNiFNRhAoU4/TI1vNC298FpIqJlY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-CRKct6xKO9GNNI26yrfXjA-1; Wed, 05 Feb 2020 09:48:20 -0500
X-MC-Unique: CRKct6xKO9GNNI26yrfXjA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C1E51083E81;
        Wed,  5 Feb 2020 14:48:18 +0000 (UTC)
Received: from localhost (ovpn-12-38.pek2.redhat.com [10.72.12.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BC77F87B00;
        Wed,  5 Feb 2020 14:48:14 +0000 (UTC)
Date:   Wed, 5 Feb 2020 22:48:11 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v6 08/10] mm/memory_hotplug: Don't check for "all holes"
 in shrink_zone_span()
Message-ID: <20200205144811.GF26758@MiWiFi-R3L-srv>
References: <20191006085646.5768-1-david@redhat.com>
 <20191006085646.5768-9-david@redhat.com>
 <20200205095924.GC24162@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205095924.GC24162@richard>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei Yang,

On 02/05/20 at 05:59pm, Wei Yang wrote:
> >diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> >index f294918f7211..8dafa1ba8d9f 100644
> >--- a/mm/memory_hotplug.c
> >+++ b/mm/memory_hotplug.c
> >@@ -393,6 +393,9 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
> > 		if (pfn) {
> > 			zone->zone_start_pfn = pfn;
> > 			zone->spanned_pages = zone_end_pfn - pfn;
> >+		} else {
> >+			zone->zone_start_pfn = 0;
> >+			zone->spanned_pages = 0;
> > 		}
> > 	} else if (zone_end_pfn == end_pfn) {
> > 		/*
> >@@ -405,34 +408,11 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
> > 					       start_pfn);
> > 		if (pfn)
> > 			zone->spanned_pages = pfn - zone_start_pfn + 1;
> >+		else {
> >+			zone->zone_start_pfn = 0;
> >+			zone->spanned_pages = 0;
> >+		}
> > 	}
> 
> If it is me, I would like to take out these two similar logic out.

I also like this style. 
> 
> For example:
> 
> 	if () {
> 	} else if () {
> 	} else {
> 		goto out;
Here the last else is unnecessary, right?

> 	}
> 
> 

Like this, I believe both David and I will be satisfactory. Even though
I still think his 2nd resetting is not needed :-)

> 	/* The zone has no valid section */
> 	if (!pfn) {
> 			zone->zone_start_pfn = 0;
> 			zone->spanned_pages = 0;
> 	}
> 
> out:
> 	zone_span_writeunlock(zone);
> 
> Well, this is just my personal taste :-)
> 
> >-
> >-	/*
> >-	 * The section is not biggest or smallest mem_section in the zone, it
> >-	 * only creates a hole in the zone. So in this case, we need not
> >-	 * change the zone. But perhaps, the zone has only hole data. Thus
> >-	 * it check the zone has only hole or not.
> >-	 */
> >-	pfn = zone_start_pfn;
> >-	for (; pfn < zone_end_pfn; pfn += PAGES_PER_SUBSECTION) {
> >-		if (unlikely(!pfn_to_online_page(pfn)))
> >-			continue;
> >-
> >-		if (page_zone(pfn_to_page(pfn)) != zone)
> >-			continue;
> >-
> >-		/* Skip range to be removed */
> >-		if (pfn >= start_pfn && pfn < end_pfn)
> >-			continue;
> >-
> >-		/* If we find valid section, we have nothing to do */
> >-		zone_span_writeunlock(zone);
> >-		return;
> >-	}
> >-
> >-	/* The zone has no valid section */
> >-	zone->zone_start_pfn = 0;
> >-	zone->spanned_pages = 0;
> > 	zone_span_writeunlock(zone);
> > }
> > 
> >-- 
> >2.21.0
> 
> -- 
> Wei Yang
> Help you, Help me
> 

