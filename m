Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD3AC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17EC20650
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R5SqUbWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbgCLOZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:25:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47786 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbgCLOZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vL6sfuk3fuzxavJdZVNm+qaxWtqP+qflLERWgWf6HbQ=; b=R5SqUbWo2imaSWG4yGbXnTLMSz
        gluVYEw+cG6l1HN1uF9b1d2lZkrYDc15dttQvfdQM+wVxhPEXrX7G+Mwv+YWtdfA+cPlHd7gKQGdY
        D4zhhC9whbwrHwOMEFmlvPAyWzOuxOsstsBN+vlVu04kRyNoSUnr0rqfISXkE4sIrfc9C485+SNhn
        srDyRMt22jwT2rnvldj4eNpbu5LJiCznQmeOl5hKRydaU0biFqBImNCtFmZfwbTw7U5OHEdhkfeq7
        4ypAR754EOSI9I3pgpH50r5dMhaxW/HBMNQx3MPwkzbSFYIvIh6srIYIjNMK69r3R2cNbWW46fz+/
        +Mn5NdyQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCOmF-0006q1-Dz; Thu, 12 Mar 2020 14:25:35 +0000
Date:   Thu, 12 Mar 2020 07:25:35 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@suse.com, akpm@linux-foundation.org,
        david@redhat.com
Subject: Re: [PATCH v2] mm/sparse.c: Use kvmalloc_node/kvfree to alloc/free
 memmap for the classic sparse
Message-ID: <20200312142535.GK22433@bombadil.infradead.org>
References: <20200312130822.6589-1-bhe@redhat.com>
 <20200312133416.GI22433@bombadil.infradead.org>
 <20200312141826.djb7osbekhcnuexv@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312141826.djb7osbekhcnuexv@master>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 02:18:26PM +0000, Wei Yang wrote:
> On Thu, Mar 12, 2020 at 06:34:16AM -0700, Matthew Wilcox wrote:
> >On Thu, Mar 12, 2020 at 09:08:22PM +0800, Baoquan He wrote:
> >> This change makes populate_section_memmap()/depopulate_section_memmap
> >> much simpler.
> >> 
> >> Suggested-by: Michal Hocko <mhocko@kernel.org>
> >> Signed-off-by: Baoquan He <bhe@redhat.com>
> >> ---
> >> v1->v2:
> >>   The old version only used __get_free_pages() to replace alloc_pages()
> >>   in populate_section_memmap().
> >>   http://lkml.kernel.org/r/20200307084229.28251-8-bhe@redhat.com
> >> 
> >>  mm/sparse.c | 27 +++------------------------
> >>  1 file changed, 3 insertions(+), 24 deletions(-)
> >> 
> >> diff --git a/mm/sparse.c b/mm/sparse.c
> >> index bf6c00a28045..362018e82e22 100644
> >> --- a/mm/sparse.c
> >> +++ b/mm/sparse.c
> >> @@ -734,35 +734,14 @@ static void free_map_bootmem(struct page *memmap)
> >>  struct page * __meminit populate_section_memmap(unsigned long pfn,
> >>  		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
> >>  {
> >> -	struct page *page, *ret;
> >> -	unsigned long memmap_size = sizeof(struct page) * PAGES_PER_SECTION;
> >> -
> >> -	page = alloc_pages(GFP_KERNEL|__GFP_NOWARN, get_order(memmap_size));
> >> -	if (page)
> >> -		goto got_map_page;
> >> -
> >> -	ret = vmalloc(memmap_size);
> >> -	if (ret)
> >> -		goto got_map_ptr;
> >> -
> >> -	return NULL;
> >> -got_map_page:
> >> -	ret = (struct page *)pfn_to_kaddr(page_to_pfn(page));
> >> -got_map_ptr:
> >> -
> >> -	return ret;
> >> +	return kvmalloc_node(sizeof(struct page) * PAGES_PER_SECTION,
> >> +			     GFP_KERNEL|__GFP_NOWARN, nid);
> >
> >Use of NOWARN here is inappropriate, because there's no fallback.
> 
> Hmm... this replacement is a little tricky.
> 
> When you look into kvmalloc_node(), it will do the fallback if the size is
> bigger than PAGE_SIZE. This means the change here may not be equivalent as
> before if memmap_size is less than PAGE_SIZE.
> 
> For example if :
>   PAGE_SIZE = 64K 
>   SECTION_SIZE = 128M
> 
> would lead to memmap_size = 2K, which is less than PAGE_SIZE.

Yes, I thought about that.  I decided it wasn't a problem, as long as
the struct page remains aligned, and we now have a guarantee that allocations
above 512 bytes in size are aligned.  With a 64 byte struct page, as long
as we're allocating at least 8 pages, we know it'll be naturally aligned.

Your calculation doesn't take into account the size of struct page.
128M / 64k is indeed 2k, but you forgot to multiply by 64, which takes
us to 128kB.
