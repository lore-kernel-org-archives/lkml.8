Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F51C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE8C206CD
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYna831y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgCLWu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:50:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36791 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgCLWu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 18:50:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id g62so8323327wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 15:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b6WCnrgZfAXuGcjQlMVBnrVIvByNByK2HOkhdy3tgek=;
        b=iYna831ybj1BRt7gffEfAHR3EmXVhCF1hAHBSDLVNeJYHnPHreTVaSKmPy46ohnC4o
         mdLo6f65i82ocaO0YzbOrX4XWATlr97KzuzlBrIQrHtSC5NgPsW0A2GXguLRL6D7Fh5G
         U+CWoEzX8G2QZ9nQXUqZAwfLZ8Au1CVk2RZjmwoS85GJvfNb18cm0j46d5URlqAbe9Nk
         ebc/MjMLaXXnGHZ62Ylw6DjuqjvyELGr8AefW/IGUBb4v1IkcAUwUL2/WJXYk33zseLg
         UL968WTOgbKLRO2bX6jCjworonPKzQZaCaJO5zVUg2ljDHP693KOt9Xxj0vMW5pvbk+D
         qJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=b6WCnrgZfAXuGcjQlMVBnrVIvByNByK2HOkhdy3tgek=;
        b=qbrgAgCeV6pZqIcAJx9D4TVsGqEcxPz04d6xqDiS0uFxJILb4hrlKNyKjsRZsfWYB/
         FDKaAXlKkHMlXn9VlTsTq0OuN4UK8HS/sTicDf+iTRedSZcjzDxP3JKjXU/Q6rWayE5n
         nED3ThM6Y3s3Jt0T/aGQRxbaNShFW/0p9lHx3QuWuWxKflue+XB4r233YpLh31llFcRN
         jcg5mCAGTM6fEEEAcm1jQHfAH/B+aGMNnirD78pQZaWiGpJ7EEgpoe46Vn8BY2z79ev3
         u75QXs5dV/cYsXEhXTNhoTLOpfCSZc1jL6PlIj1QxMMbMKNXzsdh0nzBuvqJDirLq41I
         O/XQ==
X-Gm-Message-State: ANhLgQ0Yh5n6zRzO/lEdC8aiuk+B5/jo6R/TGvg88xYso/JXCHzFWaah
        DqBHrkZ/rfqEteYKTBw1Q4E=
X-Google-Smtp-Source: ADFU+vsZKKH2rqa9+pu6nRdua15A1qPMAakL8FweNfUjhj9oEVqN+2+dww55w7LJz05hE+vb273RxA==
X-Received: by 2002:a1c:f001:: with SMTP id a1mr6665544wmb.76.1584053457129;
        Thu, 12 Mar 2020 15:50:57 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id s22sm13171183wmc.16.2020.03.12.15.50.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Mar 2020 15:50:56 -0700 (PDT)
Date:   Thu, 12 Mar 2020 22:50:55 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, Baoquan He <bhe@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        akpm@linux-foundation.org, david@redhat.com
Subject: Re: [PATCH v2] mm/sparse.c: Use kvmalloc_node/kvfree to alloc/free
 memmap for the classic sparse
Message-ID: <20200312225055.ksn4ujtkpjgkqiaf@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200312130822.6589-1-bhe@redhat.com>
 <20200312133416.GI22433@bombadil.infradead.org>
 <20200312141826.djb7osbekhcnuexv@master>
 <20200312142535.GK22433@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312142535.GK22433@bombadil.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 07:25:35AM -0700, Matthew Wilcox wrote:
>On Thu, Mar 12, 2020 at 02:18:26PM +0000, Wei Yang wrote:
>> On Thu, Mar 12, 2020 at 06:34:16AM -0700, Matthew Wilcox wrote:
>> >On Thu, Mar 12, 2020 at 09:08:22PM +0800, Baoquan He wrote:
>> >> This change makes populate_section_memmap()/depopulate_section_memmap
>> >> much simpler.
>> >> 
>> >> Suggested-by: Michal Hocko <mhocko@kernel.org>
>> >> Signed-off-by: Baoquan He <bhe@redhat.com>
>> >> ---
>> >> v1->v2:
>> >>   The old version only used __get_free_pages() to replace alloc_pages()
>> >>   in populate_section_memmap().
>> >>   http://lkml.kernel.org/r/20200307084229.28251-8-bhe@redhat.com
>> >> 
>> >>  mm/sparse.c | 27 +++------------------------
>> >>  1 file changed, 3 insertions(+), 24 deletions(-)
>> >> 
>> >> diff --git a/mm/sparse.c b/mm/sparse.c
>> >> index bf6c00a28045..362018e82e22 100644
>> >> --- a/mm/sparse.c
>> >> +++ b/mm/sparse.c
>> >> @@ -734,35 +734,14 @@ static void free_map_bootmem(struct page *memmap)
>> >>  struct page * __meminit populate_section_memmap(unsigned long pfn,
>> >>  		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
>> >>  {
>> >> -	struct page *page, *ret;
>> >> -	unsigned long memmap_size = sizeof(struct page) * PAGES_PER_SECTION;
>> >> -
>> >> -	page = alloc_pages(GFP_KERNEL|__GFP_NOWARN, get_order(memmap_size));
>> >> -	if (page)
>> >> -		goto got_map_page;
>> >> -
>> >> -	ret = vmalloc(memmap_size);
>> >> -	if (ret)
>> >> -		goto got_map_ptr;
>> >> -
>> >> -	return NULL;
>> >> -got_map_page:
>> >> -	ret = (struct page *)pfn_to_kaddr(page_to_pfn(page));
>> >> -got_map_ptr:
>> >> -
>> >> -	return ret;
>> >> +	return kvmalloc_node(sizeof(struct page) * PAGES_PER_SECTION,
>> >> +			     GFP_KERNEL|__GFP_NOWARN, nid);
>> >
>> >Use of NOWARN here is inappropriate, because there's no fallback.
>> 
>> Hmm... this replacement is a little tricky.
>> 
>> When you look into kvmalloc_node(), it will do the fallback if the size is
>> bigger than PAGE_SIZE. This means the change here may not be equivalent as
>> before if memmap_size is less than PAGE_SIZE.
>> 
>> For example if :
>>   PAGE_SIZE = 64K 
>>   SECTION_SIZE = 128M
>> 
>> would lead to memmap_size = 2K, which is less than PAGE_SIZE.
>
>Yes, I thought about that.  I decided it wasn't a problem, as long as
>the struct page remains aligned, and we now have a guarantee that allocations
>above 512 bytes in size are aligned.  With a 64 byte struct page, as long

Where is this 512 bytes condition comes from?

>as we're allocating at least 8 pages, we know it'll be naturally aligned.
>
>Your calculation doesn't take into account the size of struct page.
>128M / 64k is indeed 2k, but you forgot to multiply by 64, which takes
>us to 128kB.

You are right. While would there be other combination? Or in the future?

For example, there are definitions of

#define SECTION_SIZE_BITS       26
#define SECTION_SIZE_BITS       24

Are we sure it won't break some thing?

-- 
Wei Yang
Help you, Help me
