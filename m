Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBCEC10DCE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 00:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2B12074C
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 00:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UrNFuATq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbgCNAxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 20:53:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47897 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727629AbgCNAxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 20:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584147224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y9gJ39nM22R6BINLHw3+oLq/uGsj2PXaZMR61+u7WNg=;
        b=UrNFuATqm2haZeZ0wBboASLjVwF2k6+ReBMRzrPrzWYMuTkJzbsV4Msil5fDqRhUsfF8Sq
        MUhqVKOxbwpR/G6meJOBKOHNigZbCV4m2HoQQrN5Ksb7AMmI2bkgNevmUadXTXZwSX4Tna
        bjKK+eOWCy1Z6YLoQ0A4Q9BcgQSd/Jg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-ezN-Em1yPKWNPoaIkECnTA-1; Fri, 13 Mar 2020 20:53:42 -0400
X-MC-Unique: ezN-Em1yPKWNPoaIkECnTA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC6AE477;
        Sat, 14 Mar 2020 00:53:40 +0000 (UTC)
Received: from localhost (ovpn-12-20.pek2.redhat.com [10.72.12.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 89D335DA2C;
        Sat, 14 Mar 2020 00:53:37 +0000 (UTC)
Date:   Sat, 14 Mar 2020 08:53:34 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, willy@infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com,
        richard.weiyang@gmail.com
Subject: Re: [PATCH v3] mm/sparse.c: Use kvmalloc_node/kvfree to alloc/free
 memmap for the classic sparse
Message-ID: <20200314005334.GO27711@MiWiFi-R3L-srv>
References: <20200312130822.6589-1-bhe@redhat.com>
 <20200312141749.GL27711@MiWiFi-R3L-srv>
 <20200313145619.GD21007@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313145619.GD21007@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/13/20 at 03:56pm, Michal Hocko wrote:
> On Thu 12-03-20 22:17:49, Baoquan He wrote:
> > This change makes populate_section_memmap()/depopulate_section_memmap
> > much simpler.
> 
> Not only and you should make it more explicit. It also tries to allocate
> memmaps from the target numa node so this is a functional change. I
> would prefer to have that in a separate patch in case we hit some weird
> NUMA setups which would choke on memory less nodes and similar horrors.

Yes, splitting sounds more reasonable, I would love to do that. One
question is I noticed Andrew had picked this into -mm tree, if I post a
new patchset including these two small patches, whether it's convenient
to drop the old one and get these two merged.

Sorry, I don't know very well how this works in mm maintaining.

> 
> > Suggested-by: Michal Hocko <mhocko@kernel.org>
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> 
> I do not see any reason this shouldn't work. Btw. did you get to test
> it?
> 
> Feel free to add
> Acked-by: Michal Hocko <mhocko@suse.com>
> to both patches if you go and split.
> 
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
> >  }
> >  
> >  static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
> >  		struct vmem_altmap *altmap)
> >  {
> > -	struct page *memmap = pfn_to_page(pfn);
> > -
> > -	if (is_vmalloc_addr(memmap))
> > -		vfree(memmap);
> > -	else
> > -		free_pages((unsigned long)memmap,
> > -			   get_order(sizeof(struct page) * PAGES_PER_SECTION));
> > +	kvfree(pfn_to_page(pfn));
> >  }
> >  
> >  static void free_map_bootmem(struct page *memmap)
> > -- 
> > 2.17.2
> > 
> 
> -- 
> Michal Hocko
> SUSE Labs
> 

