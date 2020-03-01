Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF30C3F2CE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 05:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D41820857
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 05:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gRZRSd+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgCAFUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 00:20:40 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52901 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgCAFUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 00:20:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583040038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pg9ZRsmecyfUU9m9Kxgrd4qFs1nicsCEDDgmEeAkBZg=;
        b=gRZRSd+Et5nforjHmdgkU/Hqb6KEyudn915Yr3ZNuTdXEjjVvE6QG5sLMQgzAAvoNVYj49
        /rZUmju9a5P1RSLUSusrSF7v+UeiEy8DxO47Hk8G6xhWyXyrnVtCyx3gKc/4ImIhIqDAkw
        PpUCrrREaWDqKV2zMbXyMmOIs35uXm0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-rwPKMaytNMG09MMBQsiRcA-1; Sun, 01 Mar 2020 00:20:36 -0500
X-MC-Unique: rwPKMaytNMG09MMBQsiRcA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3D9413E2;
        Sun,  1 Mar 2020 05:20:34 +0000 (UTC)
Received: from localhost (ovpn-12-59.pek2.redhat.com [10.72.12.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ED13F8C091;
        Sun,  1 Mar 2020 05:20:31 +0000 (UTC)
Date:   Sun, 1 Mar 2020 13:20:28 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, richardw.yang@linux.intel.com,
        osalvador@suse.de, dan.j.williams@intel.com, mhocko@suse.com,
        rppt@linux.ibm.com, robin.murphy@arm.com
Subject: Re: [PATCH v2 3/7] mm/sparse.c: introduce a new function
 clear_subsection_map()
Message-ID: <20200301052028.GN24216@MiWiFi-R3L-srv>
References: <20200220043316.19668-1-bhe@redhat.com>
 <20200220043316.19668-4-bhe@redhat.com>
 <dc5ab1b1-65e2-e20f-66aa-b71d739a5b6d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc5ab1b1-65e2-e20f-66aa-b71d739a5b6d@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/20 at 03:36pm, David Hildenbrand wrote:
> On 20.02.20 05:33, Baoquan He wrote:
> > Wrap the codes which clear subsection map of one memory region from
> > section_deactivate() into clear_subsection_map().
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  mm/sparse.c | 46 ++++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 38 insertions(+), 8 deletions(-)
> > 
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index 977b47acd38d..df857ee9330c 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -726,14 +726,25 @@ static void free_map_bootmem(struct page *memmap)
> >  }
> >  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
> >  
> > -static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> > -		struct vmem_altmap *altmap)
> > +/**
> > + * clear_subsection_map - Clear subsection map of one memory region
> > + *
> > + * @pfn - start pfn of the memory range
> > + * @nr_pages - number of pfns to add in the region
> > + *
> > + * This is only intended for hotplug, and clear the related subsection
> > + * map inside one section.
> > + *
> > + * Return:
> > + * * -EINVAL	- Section already deactived.
> > + * * 0		- Subsection map is emptied.
> > + * * 1		- Subsection map is not empty.
> > + */
> 
> Less verbose please (in my preference: none and simplify return handling)
> 
> > +static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
> >  {
> >  	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> >  	DECLARE_BITMAP(tmp, SUBSECTIONS_PER_SECTION) = { 0 };
> >  	struct mem_section *ms = __pfn_to_section(pfn);
> > -	bool section_is_early = early_section(ms);
> > -	struct page *memmap = NULL;
> >  	unsigned long *subsection_map = ms->usage
> >  		? &ms->usage->subsection_map[0] : NULL;
> >  
> > @@ -744,8 +755,28 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> >  	if (WARN(!subsection_map || !bitmap_equal(tmp, map, SUBSECTIONS_PER_SECTION),
> >  				"section already deactivated (%#lx + %ld)\n",
> >  				pfn, nr_pages))
> > -		return;
> > +		return -EINVAL;
> > +
> > +	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
> >  
> > +	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION))
> > +		return 0;
> > +
> 
> Can we please just have a
> 
> subsection_map_empty() instead and handle that in the caller?
> (you can then always return true in the !VMEMMAP variant)

I don't follow. Could you be more specific? or pseudo code please?

The old code has to handle below case in which subsection_map has been
cleared. And I introduce clear_subsection_map() to encapsulate all
subsection map realted code so that !VMEMMAP won't have to see it any
more.

        if (WARN(!subsection_map || !bitmap_equal(tmp, map, SUBSECTIONS_PER_SECTION),
                                "section already deactivated (%#lx + %ld)\n",
                                pfn, nr_pages))
                return;


> 
> I dislike the "rc" handling in the caller.
> 
> > +	return 1;
> > +}
> > +
> > +static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> > +		struct vmem_altmap *altmap)
> > +{
> > +	struct mem_section *ms = __pfn_to_section(pfn);
> > +	bool section_is_early = early_section(ms);
> > +	struct page *memmap = NULL;
> > +	int rc;
> > +
> > +
> 
> one superfluous empty line
> 
> > +	rc = clear_subsection_map(pfn, nr_pages);
> > +	if (IS_ERR_VALUE((unsigned long)rc))
> 
> huh? "if (rc < 0)" ? or am I missing something?

Both is fine to me, I have no preference, can change like this.

> 
> > +		return;
> >  	/*
> >  	 * There are 3 cases to handle across two configurations
> >  	 * (SPARSEMEM_VMEMMAP={y,n}):
> > @@ -763,8 +794,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> >  	 *
> >  	 * For 2/ and 3/ the SPARSEMEM_VMEMMAP={y,n} cases are unified
> >  	 */
> > -	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
> > -	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION)) {
> > +	if (!rc) {
> >  		unsigned long section_nr = pfn_to_section_nr(pfn);
> >  
> >  		/*
> > @@ -786,7 +816,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> >  	else
> >  		depopulate_section_memmap(pfn, nr_pages, altmap);
> >  
> > -	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION))
> > +	if (!rc)
> 
> I don't really like that handling.
> 
> Either
> 
> s/rc/section_empty/
> 
> or use a separate subsection_map_empty()
> 
> >  		ms->section_mem_map = (unsigned long)NULL;
> >  }
> >  
> > 
> 
> Thanks!
> 
> -- 
> Thanks,
> 
> David / dhildenb

