Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F25C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 07:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF8120663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 07:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVR2OVGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbgCPHO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 03:14:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43616 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728302AbgCPHO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 03:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584342897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JPNnOddM2c90CWFUfutbV41h/MSedE2cTHjorY7SiB4=;
        b=GVR2OVGVSiyuz3ouQ9lCLOTgpvSmKkXg5jw1vJEu3iup3OSwEJ3/UIaXbtncIWFCASIvnf
        TYeCkNwjgo2vKM55fSULBPYRDZyJFeVatItpLQK8mQrnX80BORi47Y4/zKDE4mKjQB7E4c
        rsqGfcOnSv4BH20Z4skHGR6Mrt0IvAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-S2ZhaITeMfu5QyHDlb3BYA-1; Mon, 16 Mar 2020 03:14:54 -0400
X-MC-Unique: S2ZhaITeMfu5QyHDlb3BYA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DAE3107ACC9;
        Mon, 16 Mar 2020 07:14:53 +0000 (UTC)
Received: from localhost (ovpn-12-129.pek2.redhat.com [10.72.12.129])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7866F5C1B2;
        Mon, 16 Mar 2020 07:14:49 +0000 (UTC)
Date:   Mon, 16 Mar 2020 15:14:47 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, willy@infradead.org,
        linux-mm@kvack.org, mhocko@suse.com, akpm@linux-foundation.org,
        richard.weiyang@gmail.com
Subject: Re: [PATCH v3] mm/sparse.c: Use kvmalloc_node/kvfree to alloc/free
 memmap for the classic sparse
Message-ID: <20200316071447.GD3486@MiWiFi-R3L-srv>
References: <20200312130822.6589-1-bhe@redhat.com>
 <20200312141749.GL27711@MiWiFi-R3L-srv>
 <5c6351e9-1539-40c9-0057-cc58116ecc3a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c6351e9-1539-40c9-0057-cc58116ecc3a@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/13/20 at 04:04pm, David Hildenbrand wrote:
> On 12.03.20 15:17, Baoquan He wrote:
> > This change makes populate_section_memmap()/depopulate_section_memmap
> > much simpler.
> > 
> > Suggested-by: Michal Hocko <mhocko@kernel.org>
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> > v2->v3:
> >   Remove __GFP_NOWARN and use array_size when calling kvmalloc_node()
> >   per Matthew's comments.
> > 
> >  mm/sparse.c | 27 +++------------------------
> >  1 file changed, 3 insertions(+), 24 deletions(-)
> > 
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index bf6c00a28045..bb99633575b5 100644
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
> > +	return kvmalloc_node(array_size(sizeof(struct page),
> > +			PAGES_PER_SECTION), GFP_KERNEL, nid);
> 
> 
> Indentation of the parameters looks wrong/weird. Maybe just calculate
> memmap_size outside of the call, makes it easier to read IMHO.

I'll fix the indentation issue. Adding variable memmap_size seems not so
necessary.

> 
> Apart from that, looks good to me.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> -- 
> Thanks,
> 
> David / dhildenb

