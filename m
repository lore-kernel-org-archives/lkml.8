Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE701C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9473221741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jgWPg7Yh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgHZOyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728420AbgHZOyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:54:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF2CC061574;
        Wed, 26 Aug 2020 07:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZzsUdze8ZxaoitbjHVszLwTb08J5c1Hia45JcEtljE4=; b=jgWPg7Yh9RXA+VJEzrAs7yZ/cv
        +6tN1LkkGojOebzqvD2JVawUFjCGG8yz0u3rvFz6guuz0w3WLWXCE2k+oUxZZAW0Pw8Z4yBYImyEb
        eDFlYc5+atk/9+/V+mG6AfdNRYL1RsPPEgmLItcpiUa60+BoQv8XhlBO6Mg9Y50S1qMzHBW7biAD6
        IKG4ppnZvdtgSSnPglew/3F6cvM+/E0QB+NL0Bz4Cd/IsDMhZIcs2xcP6T3HvkjVevxf54/EddYV7
        1s2e3+aaPq/jvT8+AYFsONTFGnqNFl/zEhPqPGbwgccPvl9AACur8zEmREPk7vnlcEvygyUxxt5YY
        lRKWXq3Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAwoY-0001wl-7b; Wed, 26 Aug 2020 14:54:14 +0000
Date:   Wed, 26 Aug 2020 15:54:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        intel-gfx@lists.freedesktop.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] mm: Use find_get_swap_page in memcontrol
Message-ID: <20200826145414.GS17456@casper.infradead.org>
References: <20200819184850.24779-1-willy@infradead.org>
 <20200819184850.24779-3-willy@infradead.org>
 <20200826142002.GA988805@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826142002.GA988805@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 10:20:02AM -0400, Johannes Weiner wrote:
> On Wed, Aug 19, 2020 at 07:48:44PM +0100, Matthew Wilcox (Oracle) wrote:
> > +	return find_get_swap_page(vma->vm_file->f_mapping,
> > +			linear_page_index(vma, addr));
> 
> The refactor makes sense to me, but the name is confusing. We're not
> looking for a swap page, we're primarily looking for a file page in
> the page cache mapping that's handed in. Only in the special case
> where it's a shmem mapping and there is a swap entry do we consult the
> auxiliary swap cache.
> 
> How about find_get_page_or_swapcache()? find_get_page_shmemswap()?
> Maybe you have a better idea. It's a fairly specialized operation that
> isn't widely used, so a longer name isn't a bad thing IMO.

Yeah, I had trouble with the naming here too.

get_page_even_from_swap()
find_get_shmem_page()

or maybe refactor the whole thing:

	struct page *page = find_get_entry(mapping, index);
	page = find_swap_page(mapping, page);

struct page *find_swap_page(struct address_space *mapping, struct page *page)
{
	swp_entry_t swp;
	struct swap_info_struct *si;

	if (!xa_is_value(page))
		return page;
	if (!shmem_mapping(mapping))
		return NULL;

	...
}
