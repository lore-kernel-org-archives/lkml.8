Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE520C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E2FE206F2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbgIDMmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 08:42:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:57356 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730151AbgIDMmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:42:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 87E75ACB5;
        Fri,  4 Sep 2020 12:42:21 +0000 (UTC)
Date:   Fri, 4 Sep 2020 14:42:19 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        osalvador@suse.de, richard.weiyang@gmail.com, vbabka@suse.cz,
        rientjes@google.com
Subject: Re: [PATCH v2] mm/memory_hotplug: drain per-cpu pages again during
 memory offline
Message-ID: <20200904124219.GB4610@dhcp22.suse.cz>
References: <20200903140032.380431-1-pasha.tatashin@soleen.com>
 <6ec66eb9-eeba-5076-af97-cef59ed5cbaa@redhat.com>
 <20200903123136.1fa50e773eb58c6200801e65@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903123136.1fa50e773eb58c6200801e65@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-09-20 12:31:36, Andrew Morton wrote:
> On Thu, 3 Sep 2020 19:36:26 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
> > (still on vacation, back next week on Tuesday)
> > 
> > I didn't look into discussions in v1, but to me this looks like we are
> > trying to hide an actual bug by implementing hacks in the caller
> > (repeated calls to drain_all_pages()). What about alloc_contig_range()
> > users - you get more allocation errors just because PCP code doesn't
> > play along.
> > 
> > There *is* strong synchronization with the page allocator - however,
> > there seems to be one corner case race where we allow to allocate pages
> > from isolated pageblocks.
> > 
> > I want that fixed instead if possible, otherwise this is just an ugly
> > hack to make the obvious symptoms (offlining looping forever) disappear.
> > 
> > If that is not possible easily, I'd much rather want to see all
> > drain_all_pages() calls being moved to the caller and have the expected
> > behavior documented instead of specifying "there is no strong
> > synchronization with the page allocator" - which is wrong in all but PCP
> > cases (and there only in one possible race?).
> > 
> 
> It's a two-line hack which fixes a bug in -stable kernels, so I'm
> inclined to proceed with it anyway.  We can undo it later on as part of
> a better fix, OK?

Agreed. http://lkml.kernel.org/r/20200904070235.GA15277@dhcp22.suse.cz
for reference.
-- 
Michal Hocko
SUSE Labs
