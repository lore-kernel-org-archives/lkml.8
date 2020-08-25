Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9D5C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C5E320738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TpB+P3NY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgHYN23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgHYN2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:28:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BE6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 06:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gcXa8qEtYBg2gkLUtzB6uYs7+oY38nWOvnxS0FYrRks=; b=TpB+P3NY95kV/waH2Efp7RbsVA
        du/fobJECoILXR2P+Td7LvVpeUJOkCohnM/dHtBl929Bi6SBM2vyQyjarY82G1/AM9MG1hv/jzNVz
        sax1doXOV0XJ/AZOn/id/kk8FGfaJ6/jz2MiPTlm39+9Bu8h0Pai8IM84V33ktojWA8oTUqu9v4OM
        N3lPiXblGzo/947ZMLTdOgMjKN+kun21Ih4lXUbNJ7FbJAaNQyRyHxmyqdm5A3TzA3g2Tbxim6wnK
        vsKqfmHRiBKgRicd9o7VV5zyVyV8MaCTF+gbl6pJTwRMcbbTg1ZnwW3DlmQA5p5DbFptFjh/zenWc
        fg07urCw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAYzm-000782-8X; Tue, 25 Aug 2020 13:28:14 +0000
Date:   Tue, 25 Aug 2020 14:28:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] mm: Pass pvec directly to find_get_entries
Message-ID: <20200825132814.GO17456@casper.infradead.org>
References: <20200819150555.31669-1-willy@infradead.org>
 <20200819150555.31669-7-willy@infradead.org>
 <20200824161620.GK24877@quack2.suse.cz>
 <20200824173639.GD17456@casper.infradead.org>
 <20200825123324.GB32298@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825123324.GB32298@quack2.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 02:33:24PM +0200, Jan Kara wrote:
> On Mon 24-08-20 18:36:39, Matthew Wilcox wrote:
> > We already have functions in filemap which take a pagevec, eg
> > page_cache_delete_batch() and delete_from_page_cache_batch().
> 
> Right but those are really pretty internal helper functions so I don't
> think they form or strong precedence.

To be honest, I saw that as being the way forward for the page cache APIs.
If we're going to use a batching mechanism, it should be pagevecs, and
it should be built into the page cache interfaces rather than hanging
out off on the side.

> > So if we're going to merge the two functions, it seems more natural to
> > have it in filemap.c and called find_get_entries(), but I'm definitely
> > open to persuasion on this!
> 
> I agree that having non-trivial xarray code in mm/swap.c isn't attractive
> either. Dunno, I dislike the inconsistency between find_get_pages() and
> find_get_entries() you create but they aren't completely consistent anyway
> so I can live with that. Or we can just leave the pagevec_lookup_entries()
> wrapper and the API will stay consistent...

I was thinking about this some more [1] [2].  I think we can get to the
point where find_get_pages(), find_get_entries() and find_get_pages_tag()
(and all their variants) end up taking a pagevec as their last argument.

Also, I was thinking that all these names are wrong.  Really, they're
mapping_get_pages(), mapping_get_entries() and mapping_get_marked_pages().
So maybe I should move in that direction.

[1] https://lore.kernel.org/lkml/20200824214841.17132-1-willy@infradead.org/
[2] https://lore.kernel.org/lkml/20200824183424.4222-1-willy@infradead.org/
