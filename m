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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886C2C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB5C20716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u7IR8Qh8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgCLOSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:18:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40247 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgCLOS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:18:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id e26so6494781wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F0IhKEaTTcWpE5Fn1fkhWdQJNVEo2VhovEBEWKbfH3g=;
        b=u7IR8Qh8/CE43moOv2OJQMdZex8zd0QQZAN8RtmWk9d0n188wwxsEwikjuuWgN+sK8
         8J2R9SwQ0axOinqRRtdzZJH35Wx+bW3mJkGJbAU8SE7G7VXt84AzctjGZz67hsFOwlOl
         a2PTKs77fidFJCxYuHz3X1FPfxdUOeqZR6xuGNBYL4un17MtKDeIVFBBdSdYzKPioJ17
         Bd+1QjgcScT6cW2f0VuffTwpVQndhkBwauWUkNSORI+XgtrVY1fKakTUi3P8UXo9Wg1C
         vsJJJcsmixNl1gkJs7ckMT2SzFk9WAuVa8W6YcFIZVhIfFcufopZIerrmsOgIx2RNt50
         4dpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=F0IhKEaTTcWpE5Fn1fkhWdQJNVEo2VhovEBEWKbfH3g=;
        b=dSqE1X5IfkJpwUK8lJZoAhDgysacjGQ4mrs2bKEstMiOWLNWUUukgJ0HXOSUCdpr/i
         hD61cxsn+UllAhnYX5CHeHAksEyLnmOHjj9ARfT+YE4wabtYYefVNSYfuvtKngZ06+Oz
         SCO4IS0ZXB4iO7q6Kp7D1fqY+/g2WacahoGJxwZrxVOw738OSH2j7apOocx/awd9IhhZ
         /7xGLfR+RDLtfd51B3QBuXRJ71jjpUA2OQbEcP2hO/BiWcz5UuQNolKc3n8oqAK74xj5
         A/6n5/UBjDA+Gssql0yNmoe4V3J06JOf7j9nXKEJMdqLNnvRohYufcjugFX/cLV5iThm
         S6HA==
X-Gm-Message-State: ANhLgQ3ABRyccHImggARzebOLT6jwuNXj3gmt/ybrRyzlnTXw4arEDGR
        uCge8Uv6Wfmb1smAKQQ7QlbTkQbV
X-Google-Smtp-Source: ADFU+vvqr3a10Ep4vRXoev2a0hw9mI4Klh9SU6wUTihYm4Ii8tQMH6UTPYhabqSa5Q9gr5TKZWEJNA==
X-Received: by 2002:a7b:c62a:: with SMTP id p10mr3716222wmk.46.1584022708215;
        Thu, 12 Mar 2020 07:18:28 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id q7sm22604918wrd.54.2020.03.12.07.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Mar 2020 07:18:27 -0700 (PDT)
Date:   Thu, 12 Mar 2020 14:18:26 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@suse.com, akpm@linux-foundation.org,
        david@redhat.com, richard.weiyang@gmail.com
Subject: Re: [PATCH v2] mm/sparse.c: Use kvmalloc_node/kvfree to alloc/free
 memmap for the classic sparse
Message-ID: <20200312141826.djb7osbekhcnuexv@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200312130822.6589-1-bhe@redhat.com>
 <20200312133416.GI22433@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312133416.GI22433@bombadil.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 06:34:16AM -0700, Matthew Wilcox wrote:
>On Thu, Mar 12, 2020 at 09:08:22PM +0800, Baoquan He wrote:
>> This change makes populate_section_memmap()/depopulate_section_memmap
>> much simpler.
>> 
>> Suggested-by: Michal Hocko <mhocko@kernel.org>
>> Signed-off-by: Baoquan He <bhe@redhat.com>
>> ---
>> v1->v2:
>>   The old version only used __get_free_pages() to replace alloc_pages()
>>   in populate_section_memmap().
>>   http://lkml.kernel.org/r/20200307084229.28251-8-bhe@redhat.com
>> 
>>  mm/sparse.c | 27 +++------------------------
>>  1 file changed, 3 insertions(+), 24 deletions(-)
>> 
>> diff --git a/mm/sparse.c b/mm/sparse.c
>> index bf6c00a28045..362018e82e22 100644
>> --- a/mm/sparse.c
>> +++ b/mm/sparse.c
>> @@ -734,35 +734,14 @@ static void free_map_bootmem(struct page *memmap)
>>  struct page * __meminit populate_section_memmap(unsigned long pfn,
>>  		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
>>  {
>> -	struct page *page, *ret;
>> -	unsigned long memmap_size = sizeof(struct page) * PAGES_PER_SECTION;
>> -
>> -	page = alloc_pages(GFP_KERNEL|__GFP_NOWARN, get_order(memmap_size));
>> -	if (page)
>> -		goto got_map_page;
>> -
>> -	ret = vmalloc(memmap_size);
>> -	if (ret)
>> -		goto got_map_ptr;
>> -
>> -	return NULL;
>> -got_map_page:
>> -	ret = (struct page *)pfn_to_kaddr(page_to_pfn(page));
>> -got_map_ptr:
>> -
>> -	return ret;
>> +	return kvmalloc_node(sizeof(struct page) * PAGES_PER_SECTION,
>> +			     GFP_KERNEL|__GFP_NOWARN, nid);
>
>Use of NOWARN here is inappropriate, because there's no fallback.

Hmm... this replacement is a little tricky.

When you look into kvmalloc_node(), it will do the fallback if the size is
bigger than PAGE_SIZE. This means the change here may not be equivalent as
before if memmap_size is less than PAGE_SIZE.

For example if :
  PAGE_SIZE = 64K 
  SECTION_SIZE = 128M

would lead to memmap_size = 2K, which is less than PAGE_SIZE.

Not sure this combination would happen?

>Also, I'd use array_size(sizeof(struct page), PAGES_PER_SECTION).

-- 
Wei Yang
Help you, Help me
