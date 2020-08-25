Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE392C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0D1420786
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgHYPYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:24:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:35106 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726113AbgHYPYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:24:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C8787ACBA;
        Tue, 25 Aug 2020 15:24:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C0D531E1316; Tue, 25 Aug 2020 17:24:03 +0200 (CEST)
Date:   Tue, 25 Aug 2020 17:24:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] mm: Pass pvec directly to find_get_entries
Message-ID: <20200825152403.GE32298@quack2.suse.cz>
References: <20200819150555.31669-1-willy@infradead.org>
 <20200819150555.31669-7-willy@infradead.org>
 <20200824161620.GK24877@quack2.suse.cz>
 <20200824173639.GD17456@casper.infradead.org>
 <20200825123324.GB32298@quack2.suse.cz>
 <20200825132814.GO17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825132814.GO17456@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25-08-20 14:28:14, Matthew Wilcox wrote:
> On Tue, Aug 25, 2020 at 02:33:24PM +0200, Jan Kara wrote:
> > On Mon 24-08-20 18:36:39, Matthew Wilcox wrote:
> > > We already have functions in filemap which take a pagevec, eg
> > > page_cache_delete_batch() and delete_from_page_cache_batch().
> > 
> > Right but those are really pretty internal helper functions so I don't
> > think they form or strong precedence.
> 
> To be honest, I saw that as being the way forward for the page cache APIs.
> If we're going to use a batching mechanism, it should be pagevecs, and
> it should be built into the page cache interfaces rather than hanging
> out off on the side.
> 
> > > So if we're going to merge the two functions, it seems more natural to
> > > have it in filemap.c and called find_get_entries(), but I'm definitely
> > > open to persuasion on this!
> > 
> > I agree that having non-trivial xarray code in mm/swap.c isn't attractive
> > either. Dunno, I dislike the inconsistency between find_get_pages() and
> > find_get_entries() you create but they aren't completely consistent anyway
> > so I can live with that. Or we can just leave the pagevec_lookup_entries()
> > wrapper and the API will stay consistent...
> 
> I was thinking about this some more [1] [2].  I think we can get to the
> point where find_get_pages(), find_get_entries() and find_get_pages_tag()
> (and all their variants) end up taking a pagevec as their last argument.
> 
> Also, I was thinking that all these names are wrong.  Really, they're
> mapping_get_pages(), mapping_get_entries() and mapping_get_marked_pages().
> So maybe I should move in that direction.

Well, as I wrote to you in one of the replies. IMO pagevec unnecessarily
complicate matters and we should rather have for_each_mapping_page() and
for_each_mapping_entry() magic macros that hide pagevecs inside. Most of
users process returned pages/entries one by one so these macros would
simplify them. So it would seem better to me to go more into this direction
than to spread pagevecs...

> [1] https://lore.kernel.org/lkml/20200824214841.17132-1-willy@infradead.org/
> [2] https://lore.kernel.org/lkml/20200824183424.4222-1-willy@infradead.org/

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
