Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD6DC35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6E1217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIc0vkYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgBEMno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 07:43:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47195 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727068AbgBEMno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 07:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580906623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s7mEVqJKQjbMj0sSKh4xXiDWpaH1dr5EPgu2ctTv8CU=;
        b=WIc0vkYloQVaE4yPIwInu5iK8slR5G0VhX7sP04FCkMYyP1Dw5DB9vmwMxnhV7DaKRNyzA
        u513lrNZ0v1MzIlXsTn0hvLsLOrgBZ74ABSji8VvGpxnxPFPfcolpcgf6EiuAeQqrx0WBi
        L03DA+w9C4e0zvG9BjCJd+MI7d60j3M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-7rVIiLSTMrGSBsygAly1VQ-1; Wed, 05 Feb 2020 07:43:39 -0500
X-MC-Unique: 7rVIiLSTMrGSBsygAly1VQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22F4185EE6C;
        Wed,  5 Feb 2020 12:43:36 +0000 (UTC)
Received: from localhost (ovpn-12-97.pek2.redhat.com [10.72.12.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F1B681213;
        Wed,  5 Feb 2020 12:43:32 +0000 (UTC)
Date:   Wed, 5 Feb 2020 20:43:29 +0800
From:   Baoquan He <bhe@redhat.com>
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
Message-ID: <20200205124329.GE26758@MiWiFi-R3L-srv>
References: <20191006085646.5768-1-david@redhat.com>
 <20191006085646.5768-9-david@redhat.com>
 <20200204142516.GD26758@MiWiFi-R3L-srv>
 <e0006cc4-d448-89c6-38c0-51da7fc08715@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0006cc4-d448-89c6-38c0-51da7fc08715@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/20 at 03:42pm, David Hildenbrand wrote:
> On 04.02.20 15:25, Baoquan He wrote:
> > On 10/06/19 at 10:56am, David Hildenbrand wrote:
> >> If we have holes, the holes will automatically get detected and removed
> >> once we remove the next bigger/smaller section. The extra checks can
> >> go.
> >>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Oscar Salvador <osalvador@suse.de>
> >> Cc: Michal Hocko <mhocko@suse.com>
> >> Cc: David Hildenbrand <david@redhat.com>
> >> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> >> Cc: Dan Williams <dan.j.williams@intel.com>
> >> Cc: Wei Yang <richardw.yang@linux.intel.com>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  mm/memory_hotplug.c | 34 +++++++---------------------------
> >>  1 file changed, 7 insertions(+), 27 deletions(-)
> >>
> >> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> >> index f294918f7211..8dafa1ba8d9f 100644
> >> --- a/mm/memory_hotplug.c
> >> +++ b/mm/memory_hotplug.c
> >> @@ -393,6 +393,9 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
> >>  		if (pfn) {
> >>  			zone->zone_start_pfn = pfn;
> >>  			zone->spanned_pages = zone_end_pfn - pfn;
> >> +		} else {
> >> +			zone->zone_start_pfn = 0;
> >> +			zone->spanned_pages = 0;
> >>  		}
> >>  	} else if (zone_end_pfn == end_pfn) {
> >>  		/*
> >> @@ -405,34 +408,11 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
> >>  					       start_pfn);
> >>  		if (pfn)
> >>  			zone->spanned_pages = pfn - zone_start_pfn + 1;
> >> +		else {
> >> +			zone->zone_start_pfn = 0;
> >> +			zone->spanned_pages = 0;
> > 
> > Thinking in which case (zone_start_pfn != start_pfn) and it comes here.
> 
> Could only happen in case the zone_start_pfn would have been "out of the
> zone already". If you ask me: unlikely :)

Yeah, I also think it's unlikely to come here.

The 'if (zone_start_pfn == start_pfn)' checking also covers the case
(zone_start_pfn == start_pfn && zone_end_pfn == end_pfn). So this
zone_start_pfn/spanned_pages resetting can be removed to avoid
confusion.

