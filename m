Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADC5C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F81D20770
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgIDKuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:50:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:35900 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbgIDKuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:50:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7B96EAED8;
        Fri,  4 Sep 2020 10:50:03 +0000 (UTC)
Date:   Fri, 4 Sep 2020 12:50:01 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: use
 add_page_to_lru_list()/page_lru()/page_off_lru()
Message-ID: <20200904105001.GH15277@dhcp22.suse.cz>
References: <20200831175042.3527153-1-yuzhao@google.com>
 <20200903082832.GR4617@dhcp22.suse.cz>
 <20200904032400.GA4102421@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904032400.GA4102421@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-09-20 21:24:00, Yu Zhao wrote:
> On Thu, Sep 03, 2020 at 10:28:32AM +0200, Michal Hocko wrote:
> > On Mon 31-08-20 11:50:41, Yu Zhao wrote:
> > [...]
> > > @@ -1860,16 +1859,11 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
> > >  		lruvec = mem_cgroup_page_lruvec(page, pgdat);
> > >  
> > >  		SetPageLRU(page);
> > > -		lru = page_lru(page);
> > > -
> > > -		nr_pages = thp_nr_pages(page);
> > > -		update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
> > > -		list_move(&page->lru, &lruvec->lists[lru]);
> > > +		add_page_to_lru_list(page, lruvec, page_lru(page));
> > >  
> > >  		if (put_page_testzero(page)) {
> > >  			__ClearPageLRU(page);
> > > -			__ClearPageActive(page);
> > 
> > This should go into its own patch. The rest is a mechanical and clear.
> 
> Thanks for reviewing.
> 
> I assume you are worrying about PG_unevictable being set on the page
> because page_off_lru() checks it first.

No, I was referring to __ClearPageActive. You are right that this is
cleared in page_off_lru but that is hidden in a release path and e.g.
compound pages are released via their destructor which for some might
not involve releasing the page - e.g. hugetlb pages. This should be fine
because hugetlb pages are not on LRU so as I've said this is fine but it
belongs to its own patch because it is not a pure mechanical change like
the rest of the patch.
-- 
Michal Hocko
SUSE Labs
