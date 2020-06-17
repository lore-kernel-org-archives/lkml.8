Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7C0C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 12:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BA1320786
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 12:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P5WYbDs+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgFQMRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 08:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQMRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 08:17:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98333C061573
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 05:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RldClxLNf1hmXc0hhlCmSSdwgcV44W4PDkE7rUAE2fU=; b=P5WYbDs+GCsATNmQJKc2bzaDoc
        vlrWZEbh0/JIdsel1YSi5xhiIkrItaHY70ygHRr3kh8KIgqhHmZInZ3wctEf5ElFP+LvNgwWn0qfy
        zgf1jydSLWjaMr2VYXBznVgLV1dIr0W7XEFeplCTKg29iYC7WHmgL1LzsxXVR/X2tqjF4/mwr2yJ6
        PoE/hZdDdMRocr9zLZAOTNVC5SLcwBBv9WqXiRtO1lUFTcIX0B5KZSuY1UoBaoFB+Kyuh5rQROXnL
        V7pdNw1fs9pFegg1qzapS0Q9N7qpunCdBsO9PPsFpzdv+5+n1Qa/ZcmSXz/WJ8bJTWS1Vvx03i64W
        FScdij6w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlX0H-0002nH-8L; Wed, 17 Jun 2020 12:17:17 +0000
Date:   Wed, 17 Jun 2020 05:17:17 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v6 4/6] mm/swapcache: support to handle the exceptional
 entries in swapcache
Message-ID: <20200617121717.GI8681@bombadil.infradead.org>
References: <1592371583-30672-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592371583-30672-5-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592371583-30672-5-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 02:26:21PM +0900, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> Swapcache doesn't handle the exceptional entries since there is no case

Don't call them exceptional entries.

The radix tree has/had the concecpt of exceptional entries.  The swapcache
doesn't use the radix tree any more, it uses the XArray.  The XArray
has value entries.

But you shouldn't call them value entries either; that's an XArray
concept.  The swap cache and indeed page cache use value entries to
implement shadow entries (they're also used to implement dax entries and
swap entries in the page cache).  So just call them shadow entries here.

I know there are still places which use the term 'nrexceptional' in
the kernel.  I just haven't got round to replacing them yet.  Please
don't add more.

> +void clear_shadow_from_swap_cache(int type, unsigned long begin,
> +				unsigned long end)
> +{
> +	unsigned long curr;
> +	void *old;
> +	swp_entry_t entry = swp_entry(type, begin);
> +	struct address_space *address_space = swap_address_space(entry);
> +	XA_STATE(xas, &address_space->i_pages, begin);
> +
> +retry:
> +	xa_lock_irq(&address_space->i_pages);
> +	for (curr = begin; curr <= end; curr++) {
> +		entry = swp_entry(type, curr);
> +		if (swap_address_space(entry) != address_space) {
> +			xa_unlock_irq(&address_space->i_pages);
> +			address_space = swap_address_space(entry);
> +			begin = curr;
> +			xas_set(&xas, begin);
> +			goto retry;
> +		}
> +
> +		old = xas_load(&xas);
> +		if (!xa_is_value(old))
> +			continue;
> +		xas_store(&xas, NULL);
> +		address_space->nrexceptional--;
> +		xas_next(&xas);
> +	}
> +	xa_unlock_irq(&address_space->i_pages);
> +}

This is a very clunky loop.  I'm not sure it's even right, given that
you change address space without changing the xas's address space.  How
about this?

	for (;;) {
		XA_STATE(xas, &address_space->i_pages, begin);
		unsigned long nr_shadows = 0;

		xas_lock_irq(&xas);
		xas_for_each(&xas, entry, end) {
			if (!xa_is_value(entry))
				continue;
			xas_store(&xas, NULL);
			nr_shadows++;
		}
		address_space->nr_exceptionals -= nr_shadows;
		xas_unlock_irq(&xas);

		if (xas.xa_index >= end)
			break;
		entry = swp_entry(type, xas.xa_index);
		address_space = swap_address_space(entry);
	}

