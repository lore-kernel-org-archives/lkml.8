Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785A3C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5662C20679
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgBQJbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:31:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:49106 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728773AbgBQJbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:31:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CD095C05B;
        Mon, 17 Feb 2020 09:31:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C981E1E0D47; Mon, 17 Feb 2020 10:31:28 +0100 (CET)
Date:   Mon, 17 Feb 2020 10:31:28 +0100
From:   Jan Kara <jack@suse.cz>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Robert Stupp <snazy@gmx.de>
Subject: Re: [PATCH 3/3] mm: make PageReadahead more strict
Message-ID: <20200217093128.GB12032@quack2.suse.cz>
References: <20200212221614.215302-1-minchan@kernel.org>
 <20200212221614.215302-3-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212221614.215302-3-minchan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-02-20 14:16:14, Minchan Kim wrote:
> PG_readahead flag is shared with PG_reclaim but PG_reclaim is only
> used in write context while PG_readahead is used for read context.
> 
> To make it clear, let's introduce PageReadahead wrapper with
> !PageWriteback so it could make code clear and we could drop
> PageWriteback check in page_cache_async_readahead, which removes
> pointless dropping mmap_sem.
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>

...

> +/* Clear PG_readahead only if it's PG_readahead, not PG_reclaim */
> +static inline int TestClearPageReadahead(struct page *page)
> +{
> +	VM_BUG_ON_PGFLAGS(PageCompound(page), page);
> +
> +	return !PageWriteback(page) ||
> +			test_and_clear_bit(PG_reclaim, &page->flags);
> +}

I think this is still wrong - if PageWriteback is not set, it will never
clear PG_reclaim bit so effectively the page will stay in PageReadahead
state!

The logic you really want to implement is:

	if (PageReadahead(page)) { <- this is your new PageReadahead
				    implementation
		clear_bit(PG_reclaim, &page->flags);
		return 1;
	}
	return 0;

Now this has the problem that it is not atomic. The only way I see to make
this fully atomic is using cmpxchg(). If we wanted to make this kinda-sorta
OK, the proper condition would look like:

	return !PageWriteback(page) **&&**
			test_and_clear_bit(PG_reclaim, &page->flags);

Which is similar to what you originally had but different because in C '&&'
operator is not commutative due to side-effects committed at sequence points.

BTW: I share Andrew's view that we are piling hacks to fix problems caused
by older hacks. But I don't see any good option how to unalias
PG_readahead and PG_reclaim.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
