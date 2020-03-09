Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DCEC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398CA20727
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMG/nLQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgCIOIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 10:08:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49249 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgCIOIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 10:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583762882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6dtQXBYkSvo/QSH2sKMw4uKtQfyzCBAXlUczQmaYAt4=;
        b=MMG/nLQsykTFRyzQ8EEM86PvYqnkk0uUEZ4idrxI3Pr5KDkzYyx6iF6A3POsJT38GPI6L5
        kZG17KCkphWZMCyRub7I8KQQXFtc0R+0+y7wvlzTwiq79meR9VmeCkGGl/+lPf7g3QASEm
        6y/RSd3mXz5p9GggkSOp3vmzJGWgy3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-WMmfnamZOC-1fqGphKUIdg-1; Mon, 09 Mar 2020 10:08:00 -0400
X-MC-Unique: WMmfnamZOC-1fqGphKUIdg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1610B107ACC4;
        Mon,  9 Mar 2020 14:07:59 +0000 (UTC)
Received: from localhost (ovpn-12-179.pek2.redhat.com [10.72.12.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F4B61001DC0;
        Mon,  9 Mar 2020 14:07:55 +0000 (UTC)
Date:   Mon, 9 Mar 2020 22:07:53 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mhocko@suse.com,
        richardw.yang@linux.intel.com, dan.j.williams@intel.com,
        osalvador@suse.de, rppt@linux.ibm.com
Subject: Re: [PATCH v3 3/7] mm/sparse.c: introduce a new function
 clear_subsection_map()
Message-ID: <20200309140753.GF27711@MiWiFi-R3L-srv>
References: <20200307084229.28251-1-bhe@redhat.com>
 <20200307084229.28251-4-bhe@redhat.com>
 <d09c9598-4fbf-71c8-151f-f34921ed565b@redhat.com>
 <20200309133218.GD27711@MiWiFi-R3L-srv>
 <504654de-a9e1-3b95-1ef1-147f18eb0834@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <504654de-a9e1-3b95-1ef1-147f18eb0834@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/20 at 02:38pm, David Hildenbrand wrote:
> On 09.03.20 14:32, Baoquan He wrote:
> > On 03/09/20 at 09:59am, David Hildenbrand wrote:
> >> On 07.03.20 09:42, Baoquan He wrote:
> >>> Factor out the code which clear subsection map of one memory region from
> >>> section_deactivate() into clear_subsection_map().
> >>>
> >>> Signed-off-by: Baoquan He <bhe@redhat.com>
> >>> ---
> >>>  mm/sparse.c | 31 ++++++++++++++++++++++++-------
> >>>  1 file changed, 24 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/mm/sparse.c b/mm/sparse.c
> >>> index e37c0abcdc89..d9dcd58d5c1d 100644
> >>> --- a/mm/sparse.c
> >>> +++ b/mm/sparse.c
> >>> @@ -726,15 +726,11 @@ static void free_map_bootmem(struct page *memmap)
> >>>  }
> >>>  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
> >>>  
> >>> -static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> >>> -		struct vmem_altmap *altmap)
> >>> +static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
> >>>  {
> >>>  	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> >>>  	DECLARE_BITMAP(tmp, SUBSECTIONS_PER_SECTION) = { 0 };
> >>>  	struct mem_section *ms = __pfn_to_section(pfn);
> >>> -	bool section_is_early = early_section(ms);
> >>> -	struct page *memmap = NULL;
> >>> -	bool empty = false;
> >>>  	unsigned long *subsection_map = ms->usage
> >>>  		? &ms->usage->subsection_map[0] : NULL;
> >>>  
> >>> @@ -745,8 +741,31 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> >>>  	if (WARN(!subsection_map || !bitmap_equal(tmp, map, SUBSECTIONS_PER_SECTION),
> >>>  				"section already deactivated (%#lx + %ld)\n",
> >>>  				pfn, nr_pages))
> >>> +		return -EINVAL;
> >>> +
> >>> +	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
> >>> +
> >>
> >> Nit: I'd drop this line.
> > 
> > It's fine to me. I usually keep one line for the returning. I will
> > remove it when update.
> > 
> >>
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static bool is_subsection_map_empty(struct mem_section *ms)
> >>> +{
> >>> +	return bitmap_empty(&ms->usage->subsection_map[0],
> >>> +			    SUBSECTIONS_PER_SECTION);
> >>> +}
> >>> +
> >>> +static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> >>> +		struct vmem_altmap *altmap)
> >>> +{
> >>> +	struct mem_section *ms = __pfn_to_section(pfn);
> >>> +	bool section_is_early = early_section(ms);
> >>> +	struct page *memmap = NULL;
> >>> +	bool empty = false;
> >>
> >> Nit: No need to initialize empty.
> > 
> > This is inherited from patch 1.
> > 
> >>
> >>> +
> >>> +	if (clear_subsection_map(pfn, nr_pages))
> >>>  		return;
> >>>  
> >>
> >> Nit: I'd drop this empty line.
> >>
> >>> +	empty = is_subsection_map_empty(ms);
> >>>  	/*
> >>>  	 * There are 3 cases to handle across two configurations
> >>>  	 * (SPARSEMEM_VMEMMAP={y,n}):
> >>> @@ -764,8 +783,6 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> >>>  	 *
> >>>  	 * For 2/ and 3/ the SPARSEMEM_VMEMMAP={y,n} cases are unified
> >>>  	 */
> >>> -	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
> >>> -	empty = bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION);
> >>
> >> I do wonder why you moved this up the comment?
> > 
> > Since this empty will cover two places of handling, so moved it up,
> > seems this is what I was thinking. Can move it back here.
> 
> You're moving the whole comment later, was just wondering (makes it
> slightly harder to review).

I see, sorry for the confusion. I will move it back when repost.

