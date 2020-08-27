Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DD1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D140C20786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgH0N7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 09:59:24 -0400
Received: from outbound-smtp46.blacknight.com ([46.22.136.58]:53063 "EHLO
        outbound-smtp46.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726803AbgH0Nnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:43:55 -0400
X-Greylist: delayed 505 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Aug 2020 09:43:54 EDT
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp46.blacknight.com (Postfix) with ESMTPS id 0F2FFFAF62
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 14:35:25 +0100 (IST)
Received: (qmail 15080 invoked from network); 27 Aug 2020 13:35:24 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.16.65])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 Aug 2020 13:35:24 -0000
Date:   Thu, 27 Aug 2020 14:35:23 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        kernel-team@lge.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH for v5.9] mm/page_alloc: handle a missing case for
 memalloc_nocma_{save/restore} APIs
Message-ID: <20200827133523.GC3090@techsingularity.net>
References: <1598331582-19923-1-git-send-email-iamjoonsoo.kim@lge.com>
 <e83100ae-d687-3b4e-8256-aee242191ada@suse.cz>
 <CAAmzW4MRizKRbdt_ZBqs_+OQGsP4f2F6iYDk88u78kYqOZA9NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAAmzW4MRizKRbdt_ZBqs_+OQGsP4f2F6iYDk88u78kYqOZA9NQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 02:12:44PM +0900, Joonsoo Kim wrote:
> > > And, it requires to break current code
> > > layering that order-0 page is always handled by the pcplist. I'd prefer
> > > to avoid it so this patch uses different way to skip CMA page allocation
> > > from the pcplist.
> >
> > Well it would be much simpler and won't affect most of allocations. Better than
> > flushing pcplists IMHO.
> 
> Hmm...Still, I'd prefer my approach.

I prefer the pcp bypass approach. It's simpler and it does not incur a
pcp drain/refill penalty. 

> There are two reasons. First,
> layering problem
> mentioned above. In rmqueue(), there is a code for MIGRATE_HIGHATOMIC.
> As the name shows, it's for high order atomic allocation. But, after
> skipping pcplist
> allocation as you suggested, we could get there with order 0 request.

I guess your concern is that under some circumstances that a request that
passes a watermark check could fail due to a highatomic reserve and to
an extent this is true. However, in that case the system is already low
on memory depending on the allocation context, the pcp lists may get
flushed anyway.

> We can also
> change this code, but, I'd hope to maintain current layering. Second,
> a performance
> reason. After the flag for nocma is up, a burst of nocma allocation
> could come. After
> flushing the pcplist one times, we can use the free page on the
> pcplist as usual until
> the context is changed.

It's not guaranteed because CMA pages could be freed between the nocma save
and restore triggering further drains due to a reschedule.  Similarly,
a CMA allocation in parallel could refill with CMA pages on the per-cpu
list. While both cases are unlikely, it's more unpredictable than a
straight-forward pcp bypass.

I don't really see it as a layering violation of the API because all
order-0 pages go through the PCP lists. The fact that order-0 is serviced
from the pcp list is an internal implementation detail, the API doesn't
care.

-- 
Mel Gorman
SUSE Labs
