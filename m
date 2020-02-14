Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDFFC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 04:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A44420661
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 04:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZFLtWz86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgBNEH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 23:07:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39466 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgBNEH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 23:07:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a/kS7RBgvMPezQ8mrVCoFpKH0m8y283o0jw3J9zoGew=; b=ZFLtWz86Yr7Hs41S4dTIXvIb8M
        K8bwkhbY1QKk5Wsz0QJ4Ov1SDMXk1StCcvh4WDKxlFNbNZDRvaVD/T1Fxr24mcx+MVm9EtxdhxMBi
        /7ERHgAJM/ghzrmnYqs0pC/PKWH7krgrsMQNM8h48RK8sqE6GKWlyCGOMS6m19GR6kK9Xfi5NlinU
        DvlbsLV0YKUwmNFYCMZR1ff0GjnQiyDfPN2xgU9iDP1Tm/k3Wyyvgsi6YVyTx/LrR6FINmP/KSJGM
        LhyLRvug299r2QflD7lDbOjbbm8kmKUAIiaq8NlcUoK0BH/G3fDKDmY7LrBQhuaQbHpsrZCSjEbdE
        jLYmN+4Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2SGC-00040d-T1; Fri, 14 Feb 2020 04:07:24 +0000
Date:   Thu, 13 Feb 2020 20:07:24 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, mhocko@suse.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: migrate.c: migrate PG_readahead flag
Message-ID: <20200214040724.GV7778@bombadil.infradead.org>
References: <1581640185-95731-1-git-send-email-yang.shi@linux.alibaba.com>
 <20200213185511.4660aca17553562d764dc7ea@linux-foundation.org>
 <c5936806-dc0b-e0a2-33f0-6d6dce45e0a9@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5936806-dc0b-e0a2-33f0-6d6dce45e0a9@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 07:58:40PM -0800, Yang Shi wrote:
> On 2/13/20 6:55 PM, Andrew Morton wrote:
> > On Fri, 14 Feb 2020 08:29:45 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:
> > > Currently migration code doesn't migrate PG_readahead flag.
> > > Theoretically this would incur slight performance loss as the
> > > application might have to ramp its readahead back up again.  Even though
> > > such problem happens, it might be hidden by something else since
> > > migration is typically triggered by compaction and NUMA balancing, any
> > > of which should be more noticeable.
> > > 
> > > Migrate the flag after end_page_writeback() since it may clear
> > > PG_reclaim flag, which is the same bit as PG_readahead, for the new
> > > page.
> > > 
> > > --- a/mm/migrate.c
> > > +++ b/mm/migrate.c
> > > @@ -647,6 +647,14 @@ void migrate_page_states(struct page *newpage, struct page *page)
> > >   	if (PageWriteback(newpage))
> > >   		end_page_writeback(newpage);
> > > +	/*
> > > +	 * PG_readahead share the same bit with PG_reclaim, the above
> > > +	 * end_page_writeback() may clear PG_readahead mistakenly, so set
> > > +	 * the bit after that.
> > > +	 */
> > > +	if (PageReadahead(page))
> > > +		SetPageReadahead(newpage);
> > > +
> > >   	copy_page_owner(page, newpage);
> > Why not
> 
> The newpage may not have writeback set, migrating readahead flag should not
> depend on it.

Indeed, if the page has writeback set, then the page does not have the
readahead flag set; it has the reclaim flag set.  The original patch is
correct, afaict.

> >    	if (PageWriteback(newpage)) {
> >    		end_page_writeback(newpage);
> > 		/*
> > 		 * PG_readahead share the same bit with PG_reclaim, the above
> > 		 * end_page_writeback() may clear PG_readahead mistakenly, so
> > 		 * set the bit after that.
> > 		 */
> > 		if (PageReadahead(page))
> > 			SetPageReadahead(newpage);
> > 	}
> > 
> > ?
> 
