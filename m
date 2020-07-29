Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C4FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 10:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EB96207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 10:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPWPuGqr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgG2KsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 06:48:08 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:27555 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726299AbgG2KsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 06:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596019686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nb/oG6MtRg7ZezXWKteZXhsfM84O+Ip9PKe2JE7RZUo=;
        b=RPWPuGqrDnegS8ZOd9pCA1BWfeoLA8hrulyao+aEle1u/gyb0AeFH2p/6lP5pgxOyh+BmR
        9A9vDLzAQsXP4CyvdijgYDNWZAGVRfjm6B6LgLQSF7E7vMu2Jm9YB2Kc4EYOU9eaB3JFqT
        qhIBY/mPvo4d/g+z1LJsABdOIoa7gxo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-o_VbQsfvPlSCfQQ6kserAw-1; Wed, 29 Jul 2020 06:48:04 -0400
X-MC-Unique: o_VbQsfvPlSCfQQ6kserAw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 656EE79EC6;
        Wed, 29 Jul 2020 10:48:03 +0000 (UTC)
Received: from localhost (ovpn-12-32.pek2.redhat.com [10.72.12.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 203867191C;
        Wed, 29 Jul 2020 10:47:55 +0000 (UTC)
Date:   Wed, 29 Jul 2020 18:47:53 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1 1/6] mm/page_alloc: tweak comments in
 has_unmovable_pages()
Message-ID: <20200729104753.GF14854@MiWiFi-R3L-srv>
References: <20200630142639.22770-1-david@redhat.com>
 <20200630142639.22770-2-david@redhat.com>
 <20200728134826.GC14854@MiWiFi-R3L-srv>
 <c0371385-c7b4-226f-aac5-f668c74d765a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0371385-c7b4-226f-aac5-f668c74d765a@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/28/20 at 04:07pm, David Hildenbrand wrote:
> On 28.07.20 15:48, Baoquan He wrote:
> > On 06/30/20 at 04:26pm, David Hildenbrand wrote:
> >> Let's move the split comment regarding bootmem allocations and memory
> >> holes, especially in the context of ZONE_MOVABLE, to the PageReserved()
> >> check.
> >>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Michal Hocko <mhocko@suse.com>
> >> Cc: Michael S. Tsirkin <mst@redhat.com>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  mm/page_alloc.c | 22 ++++++----------------
> >>  1 file changed, 6 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >> index 48eb0f1410d47..bd3ebf08f09b9 100644
> >> --- a/mm/page_alloc.c
> >> +++ b/mm/page_alloc.c
> >> @@ -8207,14 +8207,6 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
> >>  	unsigned long iter = 0;
> >>  	unsigned long pfn = page_to_pfn(page);
> >>  
> >> -	/*
> >> -	 * TODO we could make this much more efficient by not checking every
> >> -	 * page in the range if we know all of them are in MOVABLE_ZONE and
> >> -	 * that the movable zone guarantees that pages are migratable but
> >> -	 * the later is not the case right now unfortunatelly. E.g. movablecore
> >> -	 * can still lead to having bootmem allocations in zone_movable.
> >> -	 */
> >> -
> >>  	if (is_migrate_cma_page(page)) {
> >>  		/*
> >>  		 * CMA allocations (alloc_contig_range) really need to mark
> >> @@ -8233,6 +8225,12 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
> >>  
> >>  		page = pfn_to_page(pfn + iter);
> >>  
> >> +		/*
> >> +		 * Both, bootmem allocations and memory holes are marked
> >> +		 * PG_reserved and are unmovable. We can even have unmovable
> >> +		 * allocations inside ZONE_MOVABLE, for example when
> >> +		 * specifying "movable_core".
> >                                ~~~~ should be 'movablecore', we don't
> > have kernel parameter 'movable_core'.
> 
> Agreed!
> 
> > 
> > Otherwise, this looks good to me. Esp the code comment at below had been
> > added very long time ago and obsolete.
> > 
> > Reviewed-by: Baoquan He <bhe@redhat.com>
> > 
> > By the way, David, do you know what is the situation of having unmovable
> > allocations inside ZONE_MOVABLE when specifying 'movablecore'? I quickly
> > went through find_zone_movable_pfns_for_nodes(), but didn't get why.
> > Could you tell a little more detail about it?
> 
> As far as I understand, it can happen that we have memblock allocations
> during boot that fall into an area the kernel later configures to span
> the movable zone (via movable_core).

Seems yes, thanks a lot. Wondering who is still using
movablecore|kernelcore in what use case.

