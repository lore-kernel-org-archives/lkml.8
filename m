Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E29C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 04:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396A32168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 04:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IXvAvnZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgBNE1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 23:27:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41076 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgBNE1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 23:27:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y9qRuXj1GHqlZlu09Ji7YSdKyATEG7P2lkAEuD9k0xM=; b=IXvAvnZCURmI6e84J6x6WGLhVv
        xe6VLkjQQhPEhDCeEphzu0rrTIJLFW7IUgSqkjOuhLFVVeO+nsHoHrWjmkYg2LOlzExN4E7b+ybFq
        n9U49l66JQ8pFT17uO+yk12ZN1uCsSzS+vW9Mo4U5w+SQEFY4LgT/uMoQOvyT8lT+VCzS0oEgX2pm
        yD9Ss6ubPG2+dsJMfqF73oskbIw1/hDc8mkoISHfutkl+nMEUcNJiEFjD7tx4OFGgtSy+BxGPB5Cy
        PweZE+ivg5wz68f1+/6BS7SPGuAlla/whIq6zGK+AViroZKsRpUsNaK86jJcEFbIU2FCCFI4CYLL2
        IrJmBY0g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2SZY-0001yX-Ka; Fri, 14 Feb 2020 04:27:24 +0000
Date:   Thu, 13 Feb 2020 20:27:24 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: avoid blocking lock_page() in kcompactd
Message-ID: <20200214042724.GY7778@bombadil.infradead.org>
References: <20200127150024.GN1183@dhcp22.suse.cz>
 <20200127190653.GA8708@bombadil.infradead.org>
 <20200128081712.GA18145@dhcp22.suse.cz>
 <20200128083044.GB6615@bombadil.infradead.org>
 <20200128091352.GC18145@dhcp22.suse.cz>
 <20200128104857.GC6615@bombadil.infradead.org>
 <20200128113953.GA24244@dhcp22.suse.cz>
 <20200213074847.GB31689@dhcp22.suse.cz>
 <20200213164607.GR7778@bombadil.infradead.org>
 <20200213170824.GJ31689@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213170824.GJ31689@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 06:08:24PM +0100, Michal Hocko wrote:
> On Thu 13-02-20 08:46:07, Matthew Wilcox wrote:
> > On Thu, Feb 13, 2020 at 08:48:47AM +0100, Michal Hocko wrote:
> > > Can we pursue on this please? An explicit NOFS scope annotation with a
> > > reference to compaction potentially locking up on pages in the readahead
> > > would be a great start.
> > 
> > How about this (on top of the current readahead series):
> > 
> > diff --git a/mm/readahead.c b/mm/readahead.c
> > index 29ca25c8f01e..32fd32b913da 100644
> > --- a/mm/readahead.c
> > +++ b/mm/readahead.c
> > @@ -160,6 +160,16 @@ unsigned long page_cache_readahead_limit(struct address_space *mapping,
> >  		.nr_pages = 0,
> >  	};
> >  
> > +	/*
> > +	 * Partway through the readahead operation, we will have added
> > +	 * locked pages to the page cache, but will not yet have submitted
> > +	 * them for I/O.  Adding another page may need to allocate
> > +	 * memory, which can trigger memory migration.	Telling the VM
> 
> I would go with s@migration@compaction@ because it would make it more
> obvious that this is about high order allocations.

Perhaps even just 'reclaim' -- it's about compaction today, but tomorrow's
VM might try to reclaim these pages too.  They are on the LRU, after all.

So I currently have:

        /*
         * Partway through the readahead operation, we will have added
         * locked pages to the page cache, but will not yet have submitted
         * them for I/O.  Adding another page may need to allocate memory,
         * which can trigger memory reclaim.  Telling the VM we're in
         * the middle of a filesystem operation will cause it to not
         * touch file-backed pages, preventing a deadlock.  Most (all?)
         * filesystems already specify __GFP_NOFS in their mapping's
         * gfp_mask, but let's be explicit here.
         */

Thanks!
