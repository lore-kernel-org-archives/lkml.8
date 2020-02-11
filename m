Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907D6C3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6903F20842
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqZNEJG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgBKMrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:47:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57040 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728023AbgBKMrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:47:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581425220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/aoK1QXCzMorlswoGVCOoMeDkLwKz3AeoTqS+YSOfSw=;
        b=fqZNEJG0yTotnJQV9KTWjyUGl6PyU2DY8qc2Bv2qZjDn2CkS1rS46Mg+wyf8BH89+WwuR7
        rhpcwp0TbbOSiQr34Mg9Q8sDyUpC7kxzbjy72lnRXJjahL/hBDzW/5Ore45lUs24kx8rrb
        f+ZV0bmxm97u8+BqVuEXxvaOc6l79Mg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-SXnDScXhMiOTsLtNUoNaXQ-1; Tue, 11 Feb 2020 07:46:56 -0500
X-MC-Unique: SXnDScXhMiOTsLtNUoNaXQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D097C477;
        Tue, 11 Feb 2020 12:46:54 +0000 (UTC)
Received: from localhost (ovpn-12-50.pek2.redhat.com [10.72.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2754B5D9E2;
        Tue, 11 Feb 2020 12:46:51 +0000 (UTC)
Date:   Tue, 11 Feb 2020 20:46:48 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        richardw.yang@linux.intel.com
Subject: Re: [PATCH 1/7] mm/sparse.c: Introduce new function
 fill_subsection_map()
Message-ID: <20200211124648.GF8965@MiWiFi-R3L-srv>
References: <20200209104826.3385-1-bhe@redhat.com>
 <20200209104826.3385-2-bhe@redhat.com>
 <0463a54b-12cb-667e-7c86-66cd707cec84@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0463a54b-12cb-667e-7c86-66cd707cec84@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/20 at 10:49am, David Hildenbrand wrote:
> On 09.02.20 11:48, Baoquan He wrote:
> > Wrap the codes filling subsection map in section_activate() into
> > fill_subsection_map(), this makes section_activate() cleaner and
> > easier to follow.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  mm/sparse.c | 45 ++++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 34 insertions(+), 11 deletions(-)
> > 
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index c184b69460b7..9ad741ccbeb6 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -788,24 +788,28 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> >  		depopulate_section_memmap(pfn, nr_pages, altmap);
> >  }
> >  
> > -static struct page * __meminit section_activate(int nid, unsigned long pfn,
> > -		unsigned long nr_pages, struct vmem_altmap *altmap)
> > +/**
> > + * fill_subsection_map - fill subsection map of a memory region
> > + * @pfn - start pfn of the memory range
> > + * @nr_pages - number of pfns to add in the region
> > + *
> > + * This clears the related subsection map inside one section, and only
> > + * intended for hotplug.
> > + *
> > + * Return:
> > + * * 0		- On success.
> > + * * -EINVAL	- Invalid memory region.
> > + * * -EEXIST	- Subsection map has been set.
> > + */
> > +static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
> >  {
> > -	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> >  	struct mem_section *ms = __pfn_to_section(pfn);
> > -	struct mem_section_usage *usage = NULL;
> > +	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> >  	unsigned long *subsection_map;
> > -	struct page *memmap;
> >  	int rc = 0;
> >  
> >  	subsection_mask_set(map, pfn, nr_pages);
> >  
> > -	if (!ms->usage) {
> > -		usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
> > -		if (!usage)
> > -			return ERR_PTR(-ENOMEM);
> > -		ms->usage = usage;
> > -	}
> >  	subsection_map = &ms->usage->subsection_map[0];
> >  
> >  	if (bitmap_empty(map, SUBSECTIONS_PER_SECTION))
> > @@ -816,6 +820,25 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
> >  		bitmap_or(subsection_map, map, subsection_map,
> >  				SUBSECTIONS_PER_SECTION);
> >  
> > +	return rc;
> > +}
> > +
> > +static struct page * __meminit section_activate(int nid, unsigned long pfn,
> > +		unsigned long nr_pages, struct vmem_altmap *altmap)
> > +{
> > +	struct mem_section *ms = __pfn_to_section(pfn);
> > +	struct mem_section_usage *usage = NULL;
> > +	struct page *memmap;
> > +	int rc = 0;
> > +
> > +	if (!ms->usage) {
> > +		usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
> > +		if (!usage)
> > +			return ERR_PTR(-ENOMEM);
> > +		ms->usage = usage;
> > +	}
> > +
> > +	rc = fill_subsection_map(pfn, nr_pages);
> >  	if (rc) {
> >  		if (usage)
> >  			ms->usage = NULL;
> > 
> 
> What about having two variants of
> section_activate()/section_deactivate() instead? Then we don't have any
> subsection related stuff in !subsection code.

Thanks for looking into this, David.

Having two variants of section_activate()/section_deactivate() is also
good. Just not like memmap handling which is very different between classic
sparse and vmemmap, makes having two variants very attractive, the code
and logic in section_activate()/section_deactivate() is not too much,
and both of them basically can share the most of code, these make the
variants way not so necessary. I personally prefer the current way, what
do you think?

Thanks
Baoquan

