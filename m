Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB51C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 137F020738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgHYMdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:33:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:53218 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgHYMda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 08:33:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 88B06AD77;
        Tue, 25 Aug 2020 12:33:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 434B31E1316; Tue, 25 Aug 2020 14:33:24 +0200 (CEST)
Date:   Tue, 25 Aug 2020 14:33:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] mm: Pass pvec directly to find_get_entries
Message-ID: <20200825123324.GB32298@quack2.suse.cz>
References: <20200819150555.31669-1-willy@infradead.org>
 <20200819150555.31669-7-willy@infradead.org>
 <20200824161620.GK24877@quack2.suse.cz>
 <20200824173639.GD17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824173639.GD17456@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 24-08-20 18:36:39, Matthew Wilcox wrote:
> On Mon, Aug 24, 2020 at 06:16:20PM +0200, Jan Kara wrote:
> > On Wed 19-08-20 16:05:54, Matthew Wilcox (Oracle) wrote:
> > > All callers of find_get_entries() use a pvec, so pass it directly
> > > instead of manipulating it in the caller.
> > > 
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > 
> > Rather than passing pvec to find_get_entries() and then making everybody
> > use it, won't it more consistent WRT the naming to make everybody use
> > pagevec_lookup_entries() (which is trivial at this point in the series) and
> > then rename find_get_entries() to pagevec_lookup_entries()? I.e., I'd prefer
> > if the final function was called pagevec_lookup_entries() because that is
> > IMO more consistent with how other functions are named in this area...
> 
> It seemed more consistent to me to have everybody using
> find_get_entries().  To me the pagevec functions:
> 
> 1. Are in mm/swap.c (not really sure why)

Historical :). AFAIK pagevec abstraction was first created to make swapping
out and reclaim of pages more effective. It has grown a bit since then...

> 2. Take pvec as the first argument, not the last

Well, yes, I'd keep the argument order to match original
pagevec_lookup_entries().

> 3. Wrap a find_* function
> 
> Whereas the find_* functions:
> 
> 1. Are in mm/filemap.c
> 2. Take mapping as the first argument
> 3. Manipulate the XArray directly

Agreed.

> We already have functions in filemap which take a pagevec, eg
> page_cache_delete_batch() and delete_from_page_cache_batch().

Right but those are really pretty internal helper functions so I don't
think they form or strong precedence.

> So if we're going to merge the two functions, it seems more natural to
> have it in filemap.c and called find_get_entries(), but I'm definitely
> open to persuasion on this!

I agree that having non-trivial xarray code in mm/swap.c isn't attractive
either. Dunno, I dislike the inconsistency between find_get_pages() and
find_get_entries() you create but they aren't completely consistent anyway
so I can live with that. Or we can just leave the pagevec_lookup_entries()
wrapper and the API will stay consistent...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
