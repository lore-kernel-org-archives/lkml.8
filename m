Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56567C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC792072C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584111459;
	bh=nrUw1FQl23OEWupYqSFNOsf1M91BH364XC27GKVVJtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OB3B8W7QhyERmeoCl07MYuVX2EIfW1wLDxpI6akU5nkV37IrtLS6Zv26hLllQcdS0
	 35lHrHdbMbiHALPw243wklae492Sb7ZqL1GJprSaPBS+hobO/e7DI7TgkUtmE/KAmF
	 sI1ZoyaxeC7Iav2Rui1+k+qdwCxmTTCyTSJRW23I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgCMO5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:57:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46346 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgCMO5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:57:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id n15so12460436wrw.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 07:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=923AOhkC6CgfcnsEfd2Ewky7X/CQDVkHRNsMNS/03nE=;
        b=Z/ocRIoqvhWUmfCi7WRUsectKVQWKMNfHpWEshksUNOwVAIziYI7zV4YneohRbLRaH
         G1T+ysWGcAG2exf+9uUgfPF+/5YWeAhQLLql7ADZoff+TQEzsqSro+Bg+yQvhtlwaJbO
         HiOF4gMErPA5PLl5nRFvvkRvC4Ln9bhuDfssA9ZYJxR4hfY/etlfXLGw+nGBALHlkQJu
         Z7JYxryuNoBsvRT0JB1G6+cOnUzjut/J9OYdrJZa4bh+88mZ4q/B/RBY8Odmji2FBNM8
         GxXqpsa25tU0mcJKJ+uDRq1hw6Rw6HRLF7XuBfW8v2nDjzBfbgbSiQ51LavyOckIGKjE
         EZTA==
X-Gm-Message-State: ANhLgQ1J4NBrYHjIupa2/7Nw8ukx5uWwhh1yPLVTjN77gIA3tn9h8a+M
        UGhFCKPwjnU8F846cwY8o7c=
X-Google-Smtp-Source: ADFU+vt94FqhFJiatryexDq8ri3tlf1agQzN8HKR3zGTYttNBVVuywugylzVo2UdX9a/QZde4kAHiA==
X-Received: by 2002:adf:8b1b:: with SMTP id n27mr9187015wra.349.1584111455610;
        Fri, 13 Mar 2020 07:57:35 -0700 (PDT)
Received: from localhost (ip-37-188-247-35.eurotel.cz. [37.188.247.35])
        by smtp.gmail.com with ESMTPSA id s7sm13606579wro.10.2020.03.13.07.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 07:57:34 -0700 (PDT)
Date:   Fri, 13 Mar 2020 15:57:33 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Baoquan He <bhe@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, david@redhat.com
Subject: Re: [PATCH v2] mm/sparse.c: Use kvmalloc_node/kvfree to alloc/free
 memmap for the classic sparse
Message-ID: <20200313145733.GE21007@dhcp22.suse.cz>
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

On Thu 12-03-20 14:18:26, Wei Yang wrote:
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

I do not understand your concern to be honest. Even if a sub page memmap
size was possible (I haven't checked), I fail to see why kmalloc would
fail to allocate while vmalloc would have a bigger chance to succeed.

-- 
Michal Hocko
SUSE Labs
