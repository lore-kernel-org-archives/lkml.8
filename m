Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D160C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 21:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BE32074F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 21:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m14Kzkut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgCMVyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 17:54:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43521 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgCMVyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 17:54:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id b2so7720561wrj.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 14:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DMDFdwarsdbVSCJ0xBP2YyrYrg2TJzQKZsVAwkwokGs=;
        b=m14KzkutTMyeW+QlroyOI1WiuIXtV1yscF4qyxRRapEiq0/KQxCq5TRn9WZb+2S7jq
         BP4cY6zEmbWS9Zg6Ea4C24VS0uhQXaGrqs6UCqk0cwq3OSyaBaIsdS2GYQOeM2tN1LKo
         MI6sP7xfj43WhRD7tOeXaMhLTX6BVSI+70XKjMP0m+9r+SVUoKJHzbnc+8+vywG9R6C1
         FQV8yszqdSJw2zaQalvXbAV7H54z8dtE7IkWqzmgWg6ks9TCO+RtmeNqrZk0MDdU/7wq
         ylEmD7MXv254W40WkgDamBpypW9SzeFgaVmKcWLzh6kWXcd2u5k1aSocJ+4mY0NkhRTR
         fQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DMDFdwarsdbVSCJ0xBP2YyrYrg2TJzQKZsVAwkwokGs=;
        b=G/cfl3QY7YqBsAFk157BT5tuzCIYXjgJFXvOkxRGFwwvxL/g23BIgdJYWEQh7PzAv0
         6FWEIL/uBHELYn3S4MMw15yyJgGusDct3lfN02UfCD8F5pMCaaox2fuBiBtlGRdC0nno
         ICB0bSY6f7ceRWOx8hMsP+YmYHzQrDCUSrDdlND0OUjqZ+YmeZA7HbnLmDRcvIOog/T+
         NSb4S8YpKk452uNOPMG80c6gzidTSXj8rVNn5RJNtaQLgtfC4q5I+TurFaEK3sfXF13t
         aVyxP6ybPiNyTpyeH8HsW9RbR/T82yaBLoOjuI6gQp4sicon0pXNbtvCpqTHm54tvIK9
         s3Qg==
X-Gm-Message-State: ANhLgQ3EBXuPJKG0g1/smzm89cgiSnyqwLdROexiFdwJbhJnc47rdOwl
        Y4fRCgnLX1k3+5+zAMBEOpw=
X-Google-Smtp-Source: ADFU+vtNjwrn2LwHy0J2bZuAbHBxeDe79tl25HpqVFe5dFvy8pynq5lW6bB8dhaG5p/OSEuc/DIngA==
X-Received: by 2002:a5d:6446:: with SMTP id d6mr18993263wrw.335.1584136478245;
        Fri, 13 Mar 2020 14:54:38 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id k5sm15971065wmj.18.2020.03.13.14.54.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 14:54:37 -0700 (PDT)
Date:   Fri, 13 Mar 2020 21:54:36 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com
Subject: Re: [PATCH v2] mm/sparse.c: Use kvmalloc_node/kvfree to alloc/free
 memmap for the classic sparse
Message-ID: <20200313215436.df7tqqhrywingujs@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200312130822.6589-1-bhe@redhat.com>
 <20200312133416.GI22433@bombadil.infradead.org>
 <20200312141826.djb7osbekhcnuexv@master>
 <20200313145733.GE21007@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313145733.GE21007@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 03:57:33PM +0100, Michal Hocko wrote:
>On Thu 12-03-20 14:18:26, Wei Yang wrote:
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
>
>I do not understand your concern to be honest. Even if a sub page memmap
>size was possible (I haven't checked), I fail to see why kmalloc would
>fail to allocate while vmalloc would have a bigger chance to succeed.
>

You are right. My concern is just at kvmalloc_node() level.

After I look deep into the implementation, __vmalloc_area_node(), it will
still allocate memory on PAGE_SIZE base and fill up kernel page table.

That's why kvmalloc_node() stops trying when size is less than PAGE_SIZE.

Learned one more point. Thanks

>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
