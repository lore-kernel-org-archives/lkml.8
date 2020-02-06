Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDDAC352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DBF20720
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2LQcvcf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgBFJfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 04:35:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46079 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727398AbgBFJfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 04:35:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580981742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GQ1cUTREQNuJAu5bUl8Fv+OR09amMOpiErx1l97ZOCA=;
        b=R2LQcvcffXcLT5VQX76lNJAOPL1NvOLawRezzeWqgpd1bwIWRQ+o95SjKTTPVCtYAbY/pH
        QIzU2oRCs1/DoVBG7TjJQWE+GA0GGVTti+tFPVu5IC08plq4uTVGGzn4HpskY8Efg3PZki
        B4ibNmUgb1crXrwVy4CXsnU5FAlX+6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-GWDkqie6OSu9-T2rBII9QA-1; Thu, 06 Feb 2020 04:35:38 -0500
X-MC-Unique: GWDkqie6OSu9-T2rBII9QA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B918418A6EC0;
        Thu,  6 Feb 2020 09:35:36 +0000 (UTC)
Received: from localhost (ovpn-12-19.pek2.redhat.com [10.72.12.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2089D1A8E4;
        Thu,  6 Feb 2020 09:35:33 +0000 (UTC)
Date:   Thu, 6 Feb 2020 17:35:30 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, richardw.yang@linux.intel.com,
        mhocko@suse.com, osalvador@suse.de
Subject: Re: [PATCH] mm/hotplug: Adjust shrink_zone_span() to keep the old
 logic
Message-ID: <20200206093530.GO8965@MiWiFi-R3L-srv>
References: <20200206053912.1211-1-bhe@redhat.com>
 <7ecaf36f-9f70-05bd-05fc-6dec82b7d559@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ecaf36f-9f70-05bd-05fc-6dec82b7d559@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/20 at 09:50am, David Hildenbrand wrote:
> On 06.02.20 06:39, Baoquan He wrote:
> > In commit 950b68d9178b ("mm/memory_hotplug: don't check for "all holes"
> > in shrink_zone_span()"), the zone->zone_start_pfn/->spanned_pages
> > resetting is moved into the if()/else if() branches, if the zone becomes
> > empty. However the 2nd resetting code block may cause misunderstanding.
> > 
> > So take the resetting codes out of the conditional checking and handling
> > branches just as the old code does, the find_smallest_section_pfn()and
> > find_biggest_section_pfn() searching have done the the same thing as
> > the old for loop did, the logic is kept the same as the old code. This
> > can remove the possible confusion.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  mm/memory_hotplug.c | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> > 
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 089b6c826a9e..475d0d68a32c 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -398,7 +398,7 @@ static unsigned long find_biggest_section_pfn(int nid, struct zone *zone,
> >  static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
> >  			     unsigned long end_pfn)
> >  {
> > -	unsigned long pfn;
> > +	unsigned long pfn = zone->zone_start_pfn;
> >  	int nid = zone_to_nid(zone);
> >  
> >  	zone_span_writelock(zone);
> > @@ -414,9 +414,6 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
> >  		if (pfn) {
> >  			zone->spanned_pages = zone_end_pfn(zone) - pfn;
> >  			zone->zone_start_pfn = pfn;
> > -		} else {
> > -			zone->zone_start_pfn = 0;
> > -			zone->spanned_pages = 0;
> >  		}
> >  	} else if (zone_end_pfn(zone) == end_pfn) {
> >  		/*
> > @@ -429,10 +426,11 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
> >  					       start_pfn);
> >  		if (pfn)
> >  			zone->spanned_pages = pfn - zone->zone_start_pfn + 1;
> > -		else {
> > -			zone->zone_start_pfn = 0;
> > -			zone->spanned_pages = 0;
> > -		}
> > +	}
> > +
> > +	if (!pfn) {
> > +		zone->zone_start_pfn = 0;
> > +		zone->spanned_pages = 0;
> >  	}
> >  	zone_span_writeunlock(zone);
> >  }
> > 
> 
> So, what if your zone starts at pfn 0? Unlikely that we can actually
> offline that, but still it is more confusing than the old code IMHO.
> Then I prefer to drop the second else case as discussed instead.

Hmm, pfn is initialized as zone->zone_start_pfn, does it matter?
The impossible empty zone won't go wrong if it really happen.

