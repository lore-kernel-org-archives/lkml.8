Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D74C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685C42084E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgBZIID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:08:03 -0500
Received: from outbound-smtp15.blacknight.com ([46.22.139.232]:41423 "EHLO
        outbound-smtp15.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727276AbgBZIIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:08:02 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp15.blacknight.com (Postfix) with ESMTPS id 25A4F1C4553
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 08:08:00 +0000 (GMT)
Received: (qmail 13849 invoked from network); 26 Feb 2020 08:08:00 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Feb 2020 08:07:59 -0000
Date:   Wed, 26 Feb 2020 08:07:57 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Ivan Babrou <ivan@cloudflare.com>,
        Rik van Riel <riel@surriel.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] mm, page_alloc: Disable watermark boosting if THP is
 disabled at boot
Message-ID: <20200226080757.GB3818@techsingularity.net>
References: <20200225141534.5044-1-mgorman@techsingularity.net>
 <20200225141534.5044-3-mgorman@techsingularity.net>
 <alpine.DEB.2.21.2002251728520.14021@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2002251728520.14021@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 05:32:24PM -0800, David Rientjes wrote:
> On Tue, 25 Feb 2020, Mel Gorman wrote:
> 
> > Watermark boosting is intended to increase the success rate and reduce
> > latency of high-order allocations, particularly THP. If THP is disabled
> > at boot, then it makes sense to disable watermark boosting as well. While
> > there are other high-order allocations that potentially benefit, they
> > are relatively rare.
> > 
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > ---
> >  mm/huge_memory.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index b08b199f9a11..565bb9973ff8 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -472,6 +472,7 @@ static int __init setup_transparent_hugepage(char *str)
> >  			  &transparent_hugepage_flags);
> >  		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
> >  			  &transparent_hugepage_flags);
> > +		disable_watermark_boosting();
> >  		ret = 1;
> >  	}
> >  out:
> 
> Seems like watermark boosting can help prevent fragmentation so it 
> benefits all hugepage sized allocations for the long term and that would 
> include dynamic provisioning of hugetlb memory or hugetlb overcommit?

Yes but it's very rare to hear of cases where hugetlb is dynamically
provisioned or overcommitted once THP existed and stopped stalling the
system excessively. I'm happy enough to drop this patch because I'm not
relying on it in the context of this bug.

-- 
Mel Gorman
SUSE Labs
