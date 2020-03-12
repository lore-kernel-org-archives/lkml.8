Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FC0C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1E1206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMm/E7Di"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbgCLNzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:55:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36127 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726299AbgCLNzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584021299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qPmvRjIYfa2TuLrWzxiz6LwZ3SWvS2fMU9bF8WC9teY=;
        b=QMm/E7DiXHzS5/bg5jDW8z6eiyeaDgbQqFeUdvuBuEY71GeNeciqf04OGpyC/HGGRfhE4i
        a4WpXFAkJFC7wOhHllYMBXBIjnC7Ly8Zes/bl8VCGM+3msFTMu2fCKa1hEGF9dhXP0FQkT
        6QBhF9PBpe+8tTXerNcwPD+FWQIYWDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-D3zU0jFfPo-qyw89vffB5g-1; Thu, 12 Mar 2020 09:54:54 -0400
X-MC-Unique: D3zU0jFfPo-qyw89vffB5g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2A4A801E72;
        Thu, 12 Mar 2020 13:54:52 +0000 (UTC)
Received: from localhost (ovpn-12-43.pek2.redhat.com [10.72.12.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 89CEF7386F;
        Thu, 12 Mar 2020 13:54:49 +0000 (UTC)
Date:   Thu, 12 Mar 2020 21:54:46 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        akpm@linux-foundation.org, david@redhat.com,
        richard.weiyang@gmail.com
Subject: Re: [PATCH v2] mm/sparse.c: Use kvmalloc_node/kvfree to alloc/free
 memmap for the classic sparse
Message-ID: <20200312135446.GK27711@MiWiFi-R3L-srv>
References: <20200312130822.6589-1-bhe@redhat.com>
 <20200312133416.GI22433@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312133416.GI22433@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/20 at 06:34am, Matthew Wilcox wrote:
> On Thu, Mar 12, 2020 at 09:08:22PM +0800, Baoquan He wrote:
> > This change makes populate_section_memmap()/depopulate_section_memmap
> > much simpler.
> > 
> > Suggested-by: Michal Hocko <mhocko@kernel.org>
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> > v1->v2:
> >   The old version only used __get_free_pages() to replace alloc_pages()
> >   in populate_section_memmap().
> >   http://lkml.kernel.org/r/20200307084229.28251-8-bhe@redhat.com
> > 
> >  mm/sparse.c | 27 +++------------------------
> >  1 file changed, 3 insertions(+), 24 deletions(-)
> > 
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index bf6c00a28045..362018e82e22 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -734,35 +734,14 @@ static void free_map_bootmem(struct page *memmap)
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
> > +	return kvmalloc_node(sizeof(struct page) * PAGES_PER_SECTION,
> > +			     GFP_KERNEL|__GFP_NOWARN, nid);
> 
> Use of NOWARN here is inappropriate, because there's no fallback.

kvmalloc_node has added __GFP_NOWARN internally when try to allocate
continuous pages. I will remove it.

> Also, I'd use array_size(sizeof(struct page), PAGES_PER_SECTION).

It's fine to me, even though we know it has no risk to overflow. I will
use array_size. Thanks.

