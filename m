Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE412C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1DB1206A5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgICJhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 05:37:02 -0400
Received: from outbound-smtp31.blacknight.com ([81.17.249.62]:39521 "EHLO
        outbound-smtp31.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726268AbgICJg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 05:36:59 -0400
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Sep 2020 05:36:58 EDT
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp31.blacknight.com (Postfix) with ESMTPS id 18CABC0D01
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 10:31:36 +0100 (IST)
Received: (qmail 17395 invoked from network); 3 Sep 2020 09:31:35 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.127])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 3 Sep 2020 09:31:35 -0000
Date:   Thu, 3 Sep 2020 10:31:34 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] mm/pageblock: mitigation cmpxchg false sharing in
 pageblock flags
Message-ID: <20200903093134.GC3179@techsingularity.net>
References: <1599116482-7410-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200903072447.GB3179@techsingularity.net>
 <8275cc70-fd35-25c8-36d4-525a10f05e41@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <8275cc70-fd35-25c8-36d4-525a10f05e41@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 04:32:54PM +0800, Alex Shi wrote:
> 
> 
> ??? 2020/9/3 ??????3:24, Mel Gorman ??????:
> > On Thu, Sep 03, 2020 at 03:01:20PM +0800, Alex Shi wrote:
> >> pageblock_flags is used as long, since every pageblock_flags is just 4
> >> bits, 'long' size will include 8(32bit machine) or 16 pageblocks' flags,
> >> that flag setting has to sync in cmpxchg with 7 or 15 other pageblock
> >> flags. It would cause long waiting for sync.
> >>
> >> If we could change the pageblock_flags variable as char, we could use
> >> char size cmpxchg, which just sync up with 2 pageblock flags. it could
> >> relief the false sharing in cmpxchg.
> >>
> >> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> > 
> > Page block types were not known to change at high frequency that would
> > cause a measurable performance drop. If anything, the performance hit
> > from pageblocks is the lookup paths which is a lot more frequent.
> 
> Yes, it is not hot path. But it's still a meaningful points to reduce cmpxchg
> level false sharing which isn't right on logical.
> 

Except there is no guarantee that false sharing was reduced. cmpxchg is
still used except using the byte as the comparison for the old value
and in some cases, that width will still be 32-bit for the exchange.
It would be up to each architecture to see if that can be translated to a
better instruction but it may not even matter.  As the instruction will
be prefixed with the lock instruction, the bus will be locked and bus
locking is probably on the cache line boundary so there is a collision
anyway while the atomic update takes place.

End result -- reducing false sharing in this case is not guaranteed to help
performance and may not be detectable when it's a low frequency operation
but the code will behave differently depending on the architecture and
CPU family.

Your justification path measured the number of times a cmpxchg was retried
but it did not track how many pageblock updates there were or how many
potentially collided. As the workload is uncontrolled with respect to
pageblock updates, you do not know if the difference in retries is due to
a real reduction in collisions or a difference in the number of pageblock
updates that potentially collide. Either way, because the frequency of
the operation was so low relative too your target load, any difference
in performance would be indistinguishable from noise.

I don't think it's worth the churn in this case for an impact that will
be very difficult to detect and variable across architectures and CPU
families.

-- 
Mel Gorman
SUSE Labs
