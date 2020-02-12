Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3B4C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C40206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVR5trMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgBLLVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:21:41 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39962 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727054AbgBLLVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 06:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581506500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nyWKTYu2WVz0laYq03PXmBiLoDtz0a+w3PSsjOOR0hM=;
        b=CVR5trMfgV8PGC0XW+LdLVNgu8ruezEh1D3SKL3vRavi3zXVN1nJCQcpTPaRaXTg/IldSK
        6BtrAuGVu97Ilr6diK1Wf34sEEJKw0Hc3sacEbVupbMFWUlfGnmTg6iwSHciEbDsoMHTBI
        Z6lmrmHkmHmqHeGj8NfVMByY3rftGQ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-xtVBKsuLMTuY51FtNIlNuQ-1; Wed, 12 Feb 2020 06:21:35 -0500
X-MC-Unique: xtVBKsuLMTuY51FtNIlNuQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5E9F1005502;
        Wed, 12 Feb 2020 11:21:33 +0000 (UTC)
Received: from localhost (ovpn-12-47.pek2.redhat.com [10.72.12.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F8C55C102;
        Wed, 12 Feb 2020 11:21:30 +0000 (UTC)
Date:   Wed, 12 Feb 2020 19:21:28 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        richardw.yang@linux.intel.com
Subject: Re: [PATCH 1/7] mm/sparse.c: Introduce new function
 fill_subsection_map()
Message-ID: <20200212112128.GI8965@MiWiFi-R3L-srv>
References: <20200209104826.3385-1-bhe@redhat.com>
 <20200209104826.3385-2-bhe@redhat.com>
 <0463a54b-12cb-667e-7c86-66cd707cec84@redhat.com>
 <20200211124648.GF8965@MiWiFi-R3L-srv>
 <659d16c9-79f7-a1d6-ca05-d6164c9c11a6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <659d16c9-79f7-a1d6-ca05-d6164c9c11a6@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/20 at 03:44pm, David Hildenbrand wrote:
> On 11.02.20 13:46, Baoquan He wrote:
> > On 02/10/20 at 10:49am, David Hildenbrand wrote:
> >> On 09.02.20 11:48, Baoquan He wrote:
> >>> Wrap the codes filling subsection map in section_activate() into
> >>> fill_subsection_map(), this makes section_activate() cleaner and
> >>> easier to follow.
> >>>
> >>> Signed-off-by: Baoquan He <bhe@redhat.com>
> >>> ---
> >>>  mm/sparse.c | 45 ++++++++++++++++++++++++++++++++++-----------
> >>>  1 file changed, 34 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/mm/sparse.c b/mm/sparse.c
> >>> index c184b69460b7..9ad741ccbeb6 100644
> >>> --- a/mm/sparse.c
> >>> +++ b/mm/sparse.c
> >>> @@ -788,24 +788,28 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> >>>  		depopulate_section_memmap(pfn, nr_pages, altmap);
> >>>  }
> >>>  
> >>> -static struct page * __meminit section_activate(int nid, unsigned long pfn,
> >>> -		unsigned long nr_pages, struct vmem_altmap *altmap)
> >>> +/**
> >>> + * fill_subsection_map - fill subsection map of a memory region
> >>> + * @pfn - start pfn of the memory range
> >>> + * @nr_pages - number of pfns to add in the region
> >>> + *
> >>> + * This clears the related subsection map inside one section, and only
> >>> + * intended for hotplug.
> >>> + *
> >>> + * Return:
> >>> + * * 0		- On success.
> >>> + * * -EINVAL	- Invalid memory region.
> >>> + * * -EEXIST	- Subsection map has been set.
> >>> + */
> >>> +static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
> >>>  {
> >>> -	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> >>>  	struct mem_section *ms = __pfn_to_section(pfn);
> >>> -	struct mem_section_usage *usage = NULL;
> >>> +	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> >>>  	unsigned long *subsection_map;
> >>> -	struct page *memmap;
> >>>  	int rc = 0;
> >>>  
> >>>  	subsection_mask_set(map, pfn, nr_pages);
> >>>  
> >>> -	if (!ms->usage) {
> >>> -		usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
> >>> -		if (!usage)
> >>> -			return ERR_PTR(-ENOMEM);
> >>> -		ms->usage = usage;
> >>> -	}
> >>>  	subsection_map = &ms->usage->subsection_map[0];
> >>>  
> >>>  	if (bitmap_empty(map, SUBSECTIONS_PER_SECTION))
> >>> @@ -816,6 +820,25 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
> >>>  		bitmap_or(subsection_map, map, subsection_map,
> >>>  				SUBSECTIONS_PER_SECTION);
> >>>  
> >>> +	return rc;
> >>> +}
> >>> +
> >>> +static struct page * __meminit section_activate(int nid, unsigned long pfn,
> >>> +		unsigned long nr_pages, struct vmem_altmap *altmap)
> >>> +{
> >>> +	struct mem_section *ms = __pfn_to_section(pfn);
> >>> +	struct mem_section_usage *usage = NULL;
> >>> +	struct page *memmap;
> >>> +	int rc = 0;
> >>> +
> >>> +	if (!ms->usage) {
> >>> +		usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
> >>> +		if (!usage)
> >>> +			return ERR_PTR(-ENOMEM);
> >>> +		ms->usage = usage;
> >>> +	}
> >>> +
> >>> +	rc = fill_subsection_map(pfn, nr_pages);
> >>>  	if (rc) {
> >>>  		if (usage)
> >>>  			ms->usage = NULL;
> >>>
> >>
> >> What about having two variants of
> >> section_activate()/section_deactivate() instead? Then we don't have any
> >> subsection related stuff in !subsection code.
> > 
> > Thanks for looking into this, David.
> > 
> > Having two variants of section_activate()/section_deactivate() is also
> > good. Just not like memmap handling which is very different between classic
> > sparse and vmemmap, makes having two variants very attractive, the code
> > and logic in section_activate()/section_deactivate() is not too much,
> > and both of them basically can share the most of code, these make the
> > variants way not so necessary. I personally prefer the current way, what
> > do you think?
> 
> I was looking at
> 
> if (nr_pages < PAGES_PER_SECTION && early_section(ms))
> 	return pfn_to_page(pfn);
> 
> and thought that it is also specific to sub-section handling. I wonder
> if we can simply move that into the VMEMMAP variant of
> populate_section_memmap()?
> 
> But apart from that I agree that the end result with the current
> approach is also nice.
> 
> Can you reshuffle the patches, moving the fixes to the very front so we
> can backport more easily?

Sure, I will move it as the 1st one. Thanks.

