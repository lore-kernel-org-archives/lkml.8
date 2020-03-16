Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABF8C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E99B20663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZDlfug2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbgCPMlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:41:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23870 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730878AbgCPMlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584362468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fcAZwGWS+0RpVKIFFUi8FSdQbOhSVmHnkXWx/lxohog=;
        b=gZDlfug2vxTmpHrN2/hGQyQWGMHqtNkCMC6FObi4EiInWGBEWJjT0AKYG87k6j1icK0zLH
        jPb+pGuTAbFH6BaMDuJgYXqd63pB7X8dhlwoN3E71kARYsRzc6V+15U8QW5XHcOTwbwwWq
        Tp5PgHsLP9vONSJ/qsnx0cPiBxpGj6o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-ewh3LtoUOzC0UL7GGYiLqg-1; Mon, 16 Mar 2020 08:41:02 -0400
X-MC-Unique: ewh3LtoUOzC0UL7GGYiLqg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B71038017DF;
        Mon, 16 Mar 2020 12:41:00 +0000 (UTC)
Received: from localhost (ovpn-12-129.pek2.redhat.com [10.72.12.129])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23B387A411;
        Mon, 16 Mar 2020 12:40:57 +0000 (UTC)
Date:   Mon, 16 Mar 2020 20:40:54 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        akpm@linux-foundation.org, willy@infradead.org,
        richard.weiyang@gmail.com, vbabka@suse.cz
Subject: Re: [PATCH v4 1/2] mm/sparse.c: Use kvmalloc/kvfree to alloc/free
 memmap for the classic sparse
Message-ID: <20200316124054.GF3486@MiWiFi-R3L-srv>
References: <20200316102150.16487-1-bhe@redhat.com>
 <1f5b22ac-283e-3b69-f443-528f09edaf60@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f5b22ac-283e-3b69-f443-528f09edaf60@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/16/20 at 12:00pm, David Hildenbrand wrote:
> On 16.03.20 11:21, Baoquan He wrote:
> > This change makes populate_section_memmap()/depopulate_section_memmap
> > much simpler.
> > 
> > Suggested-by: Michal Hocko <mhocko@kernel.org>
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > ---
> > v3->v4:
> >   Split the old v3 into two patches, to carve out the using 'nid'
> >   as preferred node to allocate memmap into a separate patch. This
> >   is suggested by Michal, and the carving out is put in patch 2.
> > 
> > v2->v3:
> >   Remove __GFP_NOWARN and use array_size when calling kvmalloc_node()
> >   per Matthew's comments.
> > http://lkml.kernel.org/r/20200312141749.GL27711@MiWiFi-R3L-srv
> > 
> >  mm/sparse.c | 27 +++------------------------
> >  1 file changed, 3 insertions(+), 24 deletions(-)
> > 
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index e747a238a860..d01d09cc7d99 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -719,35 +719,14 @@ static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
> >  struct page * __meminit populate_section_memmap(unsigned long pfn,
> >  		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
> >  {
> > -	struct page *page, *ret;
> > -	unsigned long memmap_size = sizeof(struct page) * PAGES_PER_SECTION;
> > -
> > -	page = alloc_pages(GFP_KERNEL|__GFP_NOWARN, get_order(memmap_size));
> > -	if (page)
> > -		goto got_map_page;
> > -
> > -	ret = vmalloc(memmap_size);
> > -	if (ret)
> > -		goto got_map_ptr;
> > -
> > -	return NULL;
> > -got_map_page:
> > -	ret = (struct page *)pfn_to_kaddr(page_to_pfn(page));
> > -got_map_ptr:
> > -
> > -	return ret;
> > +	return kvmalloc(array_size(sizeof(struct page),
> > +			PAGES_PER_SECTION), GFP_KERNEL);
> 
> FWIW, this is what I meant:
> 
>         return kvmalloc(array_size(sizeof(struct page),
>                                    PAGES_PER_SECTION), GFP_KERNEL);
Since there's another parameter, I didn't indent it with sizeof. But
Pankaj and Matthew have added other two votes on this, I will change it,
thanks.

