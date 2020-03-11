Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF55C3F2D0
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26A92192A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ct9nHCHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgCKJcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 05:32:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39129 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbgCKJbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 05:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583919101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JOheGtB+L2Yo5ffuolvSHNR5FjE6tnky7v9a+7CjbEI=;
        b=Ct9nHCHyS2kF2EmfXwlUohrbhw1miBmrVb2R9IiWA6SS3fn+QhXPgv9h7T1u42w7qXBUbQ
        nTUyOXj/CIgbv2O7M+gVidx6l6rzZdQll6/PQ1Ip0fQ3wIcBx4I1MpxZJY9YHKonfQmHoC
        v2fVFx0ZsyOWjm7BYYht/CRVKo4lXms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-PYgklzj7PY6_u4F23HELig-1; Wed, 11 Mar 2020 05:31:39 -0400
X-MC-Unique: PYgklzj7PY6_u4F23HELig-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE7AE1922985;
        Wed, 11 Mar 2020 09:31:37 +0000 (UTC)
Received: from localhost (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A2D2272D1;
        Wed, 11 Mar 2020 09:31:34 +0000 (UTC)
Date:   Wed, 11 Mar 2020 17:31:32 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, david@redhat.com,
        richardw.yang@linux.intel.com, dan.j.williams@intel.com,
        osalvador@suse.de, rppt@linux.ibm.com
Subject: Re: [PATCH v3 7/7] mm/sparse.c: Use __get_free_pages() instead in
 populate_section_memmap()
Message-ID: <20200311093132.GJ27711@MiWiFi-R3L-srv>
References: <20200307084229.28251-1-bhe@redhat.com>
 <20200307084229.28251-8-bhe@redhat.com>
 <20200310145647.GN8447@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310145647.GN8447@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/20 at 03:56pm, Michal Hocko wrote:
> On Sat 07-03-20 16:42:29, Baoquan He wrote:
> > This removes the unnecessary goto, and simplify codes.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
> > ---
> >  mm/sparse.c | 16 ++++++----------
> >  1 file changed, 6 insertions(+), 10 deletions(-)
> > 
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index fde651ab8741..266f7f5040fb 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -735,23 +735,19 @@ static void free_map_bootmem(struct page *memmap)
> >  struct page * __meminit populate_section_memmap(unsigned long pfn,
> >  		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
> >  {
> > -	struct page *page, *ret;
> > +	struct page *ret;
> >  	unsigned long memmap_size = sizeof(struct page) * PAGES_PER_SECTION;
> >  
> > -	page = alloc_pages(GFP_KERNEL|__GFP_NOWARN, get_order(memmap_size));
> > -	if (page)
> > -		goto got_map_page;
> > +	ret = (void*)__get_free_pages(GFP_KERNEL|__GFP_NOWARN,
> > +				get_order(memmap_size));
> > +	if (ret)
> > +		return ret;
> >  
> >  	ret = vmalloc(memmap_size);
> >  	if (ret)
> > -		goto got_map_ptr;
> > +		return ret;
> >  
> >  	return NULL;
> > -got_map_page:
> > -	ret = (struct page *)pfn_to_kaddr(page_to_pfn(page));
> > -got_map_ptr:
> > -
> > -	return ret;
> >  }
> 
> Boy this code is ugly. Is there any reason we cannot simply use
> kvmalloc_array(PAGES_PER_SECTION, sizeof(struct page), GFP_KERNEL | __GFP_NOWARN)
> 
> And if we care about locality then go even one step further
> kvmalloc_node(PAGES_PER_SECTION * sizeof(struct page), GFP_KERNEL | __GFP_NOWARN, nid)

Yes, this looks better. I will use this to make a new version. Thanks.

