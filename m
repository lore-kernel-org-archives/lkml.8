Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA616C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 570CD20795
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbgIJHcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 03:32:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:59368 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbgIJHcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 03:32:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C5650B339;
        Thu, 10 Sep 2020 07:32:30 +0000 (UTC)
Date:   Thu, 10 Sep 2020 09:32:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Rik van Riel <riel@surriel.com>, Zi Yan <ziy@nvidia.com>,
        Roman Gushchin <guro@fb.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
Message-ID: <20200910073213.GC28354@dhcp22.suse.cz>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200903142300.bjq2um5y5nwocvar@box>
 <20200903163020.GG60440@carbon.dhcp.thefacebook.com>
 <8e677ead-206d-08dd-d73e-569bd3803e3b@redhat.com>
 <7E20392E-5ED7-4C22-9555-F3BAABF3CBE9@nvidia.com>
 <20200908143503.GE26850@dhcp22.suse.cz>
 <7ed82cb06074b30c2956638082c515fb179f69a3.camel@surriel.com>
 <20200909070445.GA7348@dhcp22.suse.cz>
 <054d02f3b34d9946905929ff268b685c91494b3e.camel@surriel.com>
 <6135d2c5-2a74-6ca8-4b3b-8ceb25c0d4b1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6135d2c5-2a74-6ca8-4b3b-8ceb25c0d4b1@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Vlastimil and Mel - the whole email thread starts
 http://lkml.kernel.org/r/20200902180628.4052244-1-zi.yan@sent.com
 but this particular subthread has diverged a bit and you might find it
 interesting]

On Wed 09-09-20 15:43:55, David Hildenbrand wrote:
> On 09.09.20 15:19, Rik van Riel wrote:
> > On Wed, 2020-09-09 at 09:04 +0200, Michal Hocko wrote:
> >> On Tue 08-09-20 10:41:10, Rik van Riel wrote:
> >>> On Tue, 2020-09-08 at 16:35 +0200, Michal Hocko wrote:
> >>>
> >>>> A global knob is insufficient. 1G pages will become a very
> >>>> precious
> >>>> resource as it requires a pre-allocation (reservation). So it
> >>>> really
> >>>> has
> >>>> to be an opt-in and the question is whether there is also some
> >>>> sort
> >>>> of
> >>>> access control needed.
> >>>
> >>> The 1GB pages do not require that much in the way of
> >>> pre-allocation. The memory can be obtained through CMA,
> >>> which means it can be used for movable 4kB and 2MB
> >>> allocations when not
> >>> being used for 1GB pages.
> >>
> >> That CMA has to be pre-reserved, right? That requires a
> >> configuration.
> > 
> > To some extent, yes.
> > 
> > However, because that pool can be used for movable
> > 4kB and 2MB
> > pages as well as for 1GB pages, it would be easy to just set
> > the size of that pool to eg. 1/3 or even 1/2 of memory for every
> > system.
> > 
> > It isn't like the pool needs to be the exact right size. We
> > just need to avoid the "highmem problem" of having too little
> > memory for kernel allocations.
> > 
> 
> I am not sure I like the trend towards CMA that we are seeing, reserving
> huge buffers for specific users (and eventually even doing it
> automatically).
> 
> What we actually want is ZONE_MOVABLE with relaxed guarantees, such that
> anybody who requires large, unmovable allocations can use it.
> 
> I once played with the idea of having ZONE_PREFER_MOVABLE, which
> a) Is the primary choice for movable allocations
> b) Is allowed to contain unmovable allocations (esp., gigantic pages)
> c) Is the fallback for ZONE_NORMAL for unmovable allocations, instead of
> running out of memory

I might be missing something but how can this work longterm? Or put in
another words why would this work any better than existing fragmentation
avoidance techniques that page allocator implements already - movability
grouping etc. Please note that I am not deeply familiar with those but
my high level understanding is that we already try hard to not mix
movable and unmovable objects in same page blocks as much as we can.

My suspicion is that a separate zone would work in a similar fashion. As
long as there is a lot of free memory then zone will be effectively
MOVABLE. Similar applies to normal zone when unmovable allocations are
in minority. As long as the Normal zone gets full of unmovable objects
they start overflowing to ZONE_PREFER_MOVABLE and it will resemble page
block stealing when unmovable objects start spreading over movable page
blocks.

Again, my level of expertise to page allocator is quite low so all the
above might be simply wrong...

> If someone messes up the zone ratio, issues known from zone imbalances
> are avoided - large allocations simply become less likely to succeed. In
> contrast to ZONE_MOVABLE, memory offlining is not guaranteed to work.
-- 
Michal Hocko
SUSE Labs
