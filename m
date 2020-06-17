Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D978BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 04:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB81120810
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 04:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/c8YMsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgFQED5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 00:03:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60323 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725808AbgFQED5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 00:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592366635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dUjZV5HGPyTEJs9+tiHKC3ItBOnfHi3MbbIcDCIeAMo=;
        b=g/c8YMsFcH4210ogGNwA3u3UDa5xQ/Uym0u7oUrjr3O/rZ7zSMYCnoLMAUbRTi+vpF11DH
        eL6UKlNYzKx8hRwie9HohvQ0EjOTF/eMfvIk9r5aCifPDDZwF4hwFsKb75v6MgfjAFetAJ
        c0qpbKbePujtBDu38UJWqkZ76fAHTmE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-AybmVhfQO_K0_WKlen-EGw-1; Wed, 17 Jun 2020 00:03:48 -0400
X-MC-Unique: AybmVhfQO_K0_WKlen-EGw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 563581009618;
        Wed, 17 Jun 2020 04:03:46 +0000 (UTC)
Received: from localhost (ovpn-12-37.pek2.redhat.com [10.72.12.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D642379317;
        Wed, 17 Jun 2020 04:03:44 +0000 (UTC)
Date:   Wed, 17 Jun 2020 12:03:42 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Jaewon Kim <jaewon31.kim@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        =?utf-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?7J207Jqp7YOd?= <ytk.lee@samsung.com>,
        =?utf-8?B?6rmA7LKg66+8?= <cmlaika.kim@samsung.com>
Subject: Re: (2) [PATCH v2] page_alloc: consider highatomic reserve in
 wmartermark fast
Message-ID: <20200617040342.GC3346@MiWiFi-R3L-srv>
References: <26a6a2c2-56e6-1a34-84ac-8ff9f74c34ce@suse.cz>
 <20200613025102.12880-1-jaewon31.kim@samsung.com>
 <20200613094228.GB3346@MiWiFi-R3L-srv>
 <CAJrd-Ut=QcK5FQP2TUm6==mowoVK_QVCB7x=LL4iUnZxBLYAmA@mail.gmail.com>
 <20200613231736.GJ20367@MiWiFi-R3L-srv>
 <CGME20200612085027epcas1p46383a7eda792eabbd1e74cd08fe988c9@epcms1p1>
 <20200616073002epcms1p12a14cc85b0aebf8ba88bedee7495b34f@epcms1p1>
 <20200616141717.GN20367@MiWiFi-R3L-srv>
 <CAJrd-UuWas4ctJZVd76fiENaDJY6O1EMBisFfdVws09YLQwmrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJrd-UuWas4ctJZVd76fiENaDJY6O1EMBisFfdVws09YLQwmrQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/17/20 at 12:46am, Jaewon Kim wrote:
...
> > > >>> i.e)
> > > >>> In following situation, watermark check fails (9MB - 8MB < 4MB) though there are
> > > >>> enough free (9MB - 4MB > 4MB). If this is really matter, we need to
> > > >>> count highatomic
> > > >>> free accurately.
> > > >>
> > > >> Seems to make sense. We only use zone->nr_reserved_highatomic to account
> > > >> the reserved highatomic, don't track how much have been used for
> > > >> highatomic allocation. But not sure if this will happen often, or just a
> > > >> very rare case, whether taking that into account will impact anything.
> > > >
> > > >Unfortunately there's a problem when trying to account free pages of a migrate
> > > >type exactly, as e.g. during reserve_highatomic_pageblock(), some pages might be
> > > >in pcplist of other cpu with other migratetype, and once they are freed, the
> > > >buddy merging will merge the different migratetypes and distort the accounting.
> >
> > Yeah, the migratetype could have been cached in page->index before we
> > finish the reserve_highatomic_pageblock(). Seems we take a very coarse
> > grained way to do the highatomic reservation and accounting. When I went
> > through the related code, found out we call
> > reserve_highatomic_pageblock() if below condition is met. So what if
> > order is 1, and all other pages on the page block have been used? Do we
> > possibly have this kind of extreme case?
> 
> If I correctly understand your question, yes I think so.
> If a hight-order free page was allocated on ALLOC_HARDER context, and the page
> was the last order-1, then zone->nr_reserved_highatomic will be increased by
> pageblock_nr_pages even though there was actually no free page moved to the
> highatomic free page list.

Exactly.

> 
> The highatomic logic, I think, was originally designed to reserve in
> that coarse grained
> way to mitigate highatomic allocation failure.
> 
> >
> > From Jaewon's captured information, we can see that the available free
> > highatomic is even less than half the zone->nr_reserved_highatomic.
> > Should we at least limit the reservation to the case with a bigger
> > order. E.g 1/2 of pageblock_nr_pages? Please correct me if I am wrong or
> > miss anyting.
> >
> 
> I do not know well, but I think high-order lower than 1/2 of pageblock_nr_pages
> also should be considered. i.e) a system using huge order-3 atomic allocation
> in a short time.
> 
> > "reserved_highatomic:32768KB and actually 14232kB free."
> 
> I think this unwanted case might happen by freed pages. The pages allocated
> for non-high-atomic also would be freed back into highatomic free
> list. But I guess
> there was sudden huge use of highatomic and partially freed.

OK, thanks for sharing. So we can leave with it, may do some improvement
if any issue is reported in the future.

> 
> >
> > get_page_from_freelist
> > {
> >         ...
> >                         if (unlikely(order && (alloc_flags & ALLOC_HARDER)))
> >                                 reserve_highatomic_pageblock(page, zone, order);
> >         ...
> > }
> > > >Fixing this for all migratetypes would have performance overhead, so we only do
> > > >that for MIGRATE_ISOLATE which is not that frequent (and it took a while to
> > > >eliminate all corner cases), and CMA which doesn't change pageblocks dynamically.
> > >
> > > AFAIK we do not account free cma in pcp either. But yes accurate check could be
> > > overhead. For example, __mod_zone_freepage_state should account highatomic free
> > > as cma free. And we may see some incorrect accounting issue.
> > >
> > > >
> > > >So either we live with the possible overreclaim due to inaccurate counting per
> > > >your example above, or we instead let order-0 atomic allocations use highatomic
> > > >reserves.
> > > >
> > >
> > > Additionally regarding existing Mel's comment, let me remove some of it if you
> > > don't mind.
> > >
> > >         /*
> > >          * Fast check for order-0 only. If this fails then the reserves
> > > -        * need to be calculated. There is a corner case where the check
> > > -        * passes but only the high-order atomic reserve are free. If
> > > -        * the caller is !atomic then it'll uselessly search the free
> > > -        * list. That corner case is then slower but it is harmless.
> > > +        * need to be calculated.
> > >          */
> > >
> > > I will prepare v3 patch.
> > > Thank you again.
> > >
> >
> 

