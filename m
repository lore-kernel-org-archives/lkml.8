Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927FEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 23:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58EBF20575
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 23:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjNVqpi2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgHKXzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 19:55:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55988 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726143AbgHKXzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 19:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597190152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mnLMHaakfxc+cNWzhniTVkvXK0bv6PGfjmotkXoeg6A=;
        b=cjNVqpi2Z6c7RHqB4GLxtB/ecGmnDmnUilPHRZlVBIdMKO6tUeV4dPGug9Am8nYVpTf0Ob
        jxFGZq9YlayUaYPIlf9pfXvLO383Hgmu9eCg2rn1yMkzaknLn/4dtqbitDyiJawxNTeMIH
        ilL1XyR6hmdHgWHIRV3dh8xxS2aaRQo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-I302rRN-MKCcX7WNVNUCYQ-1; Tue, 11 Aug 2020 19:55:50 -0400
X-MC-Unique: I302rRN-MKCcX7WNVNUCYQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8B1410059A2;
        Tue, 11 Aug 2020 23:55:48 +0000 (UTC)
Received: from localhost (ovpn-12-45.pek2.redhat.com [10.72.12.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 25BDB79CF3;
        Tue, 11 Aug 2020 23:55:47 +0000 (UTC)
Date:   Wed, 12 Aug 2020 07:55:45 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] mm/hugetlb: not necessary to abuse temporary page
 to workaround the nasty free_huge_page
Message-ID: <20200811235545.GY14854@MiWiFi-R3L-srv>
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
 <20200807091251.12129-11-richard.weiyang@linux.alibaba.com>
 <20200810021737.GV14854@MiWiFi-R3L-srv>
 <129cc03e-c6d5-24f8-2f3c-f5a3cc821e76@oracle.com>
 <20200811015148.GA10792@MiWiFi-R3L-srv>
 <20200811065406.GC4793@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811065406.GC4793@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/20 at 08:54am, Michal Hocko wrote:
> On Tue 11-08-20 09:51:48, Baoquan He wrote:
> > On 08/10/20 at 05:19pm, Mike Kravetz wrote:
> > > On 8/9/20 7:17 PM, Baoquan He wrote:
> > > > On 08/07/20 at 05:12pm, Wei Yang wrote:
> > > >> Let's always increase surplus_huge_pages and so that free_huge_page
> > > >> could decrease it at free time.
> > > >>
> > > >> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> > > >> ---
> > > >>  mm/hugetlb.c | 14 ++++++--------
> > > >>  1 file changed, 6 insertions(+), 8 deletions(-)
> > > >>
> > > >> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > >> index 1f2010c9dd8d..a0eb81e0e4c5 100644
> > > >> --- a/mm/hugetlb.c
> > > >> +++ b/mm/hugetlb.c
> > > >> @@ -1913,21 +1913,19 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
> > > >>  		return NULL;
> > > >>  
> > > >>  	spin_lock(&hugetlb_lock);
> > > >> +
> > > >> +	h->surplus_huge_pages++;
> > > >> +	h->surplus_huge_pages_node[page_to_nid(page)]++;
> > > >> +
> > > >>  	/*
> > > >>  	 * We could have raced with the pool size change.
> > > >>  	 * Double check that and simply deallocate the new page
> > > >> -	 * if we would end up overcommiting the surpluses. Abuse
> > > >> -	 * temporary page to workaround the nasty free_huge_page
> > > >> -	 * codeflow
> > > >> +	 * if we would end up overcommiting the surpluses.
> > > >>  	 */
> > > >> -	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
> > > >> -		SetPageHugeTemporary(page);
> > > > 
> > > > Hmm, the temporary page way is taken intentionally in
> > > > commit 9980d744a0428 ("mm, hugetlb: get rid of surplus page accounting tricks").
> > > > From code, this is done inside hugetlb_lock holding, and the code flow
> > > > is straightforward, should be safe. Adding Michal to CC.
> 
> But the lock is not held during the migration, right?

I see what I misunderstoold about the hugetlb_lock holding. The
put_page() is called after releasing hugetlb_lock in
alloc_surplus_huge_page(), I mistakenly got put_page() is inside
hugetlb_lock. Yes, there's obviously a race window, and the temporary
page way is an effective way to not mess up the surplus_huge_pages
accounting.

> 
> > > I remember when the temporary page code was added for page migration.
> > > The use of temporary page here was added at about the same time.  Temporary
> > > page does have one advantage in that it will not CAUSE surplus count to
> > > exceed overcommit.  This patch could cause surplus to exceed overcommit
> > > for a very short period of time.  However, do note that for this to happen
> > > the code needs to race with a pool resize which itself could cause surplus
> > > to exceed overcommit.
> 
> Correct.
> 
> > > IMO both approaches are valid.
> > > - Advantage of temporary page is that it can not cause surplus to exceed
> > >   overcommit.  Disadvantage is as mentioned in the comment 'abuse of temporary
> > >   page'.
> > > - Advantage of this patch is that it uses existing counters.  Disadvantage
> > >   is that it can momentarily cause surplus to exceed overcommit.
> 
> Do I remember correctly that this can cause an allocation failure due to
> overcommit check? In other words it would be user space visible thing?
> 
> > Yeah, since it's all done inside hugetlb_lock, should be OK even
> > though it may cause surplus to exceed overcommit.
> > > 
> > > Unless someone has a strong opinion, I prefer the changes in this patch.
> > 
> > Agree, I also prefer the code change in this patch, to remove the
> > unnecessary confusion about the temporary page.
> 
> I have managed to forgot all the juicy details since I have made that
> change. All that remains is that the surplus pages accounting was quite
> tricky and back then I didn't figure out a simpler method that would
> achieve the consistent look at those counters. As mentioned above I
> suspect this could lead to pre-mature allocation failures while the
> migration is ongoing. Sure quite unlikely to happen and the race window
> is likely very small. Maybe this is even acceptable but I would strongly
> recommend to have all this thinking documented in the changelog.
> -- 
> Michal Hocko
> SUSE Labs
> 

