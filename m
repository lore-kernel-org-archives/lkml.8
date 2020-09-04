Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A49C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2F19206D4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgIDHCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 03:02:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:38418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728170AbgIDHCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 03:02:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3C6B7ACCF;
        Fri,  4 Sep 2020 07:02:37 +0000 (UTC)
Date:   Fri, 4 Sep 2020 09:02:35 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/memory_hotplug: drain per-cpu pages again during
 memory offline
Message-ID: <20200904070235.GA15277@dhcp22.suse.cz>
References: <20200901124615.137200-1-pasha.tatashin@soleen.com>
 <20200902140851.GJ4617@dhcp22.suse.cz>
 <CA+CK2bBZdN56fmsC2jyY_ju8rQfG2-9hForf1CEdcUVL1+wrrA@mail.gmail.com>
 <74f2341a-7834-3e37-0346-7fbc48d74df3@suse.cz>
 <20200902151306.GL4617@dhcp22.suse.cz>
 <e6bf05cb-044c-47a9-3c65-e41b1e42b702@suse.cz>
 <20200903063806.GM4617@dhcp22.suse.cz>
 <c6b11905-2456-52a0-3b15-d4ceae6e7f54@redhat.com>
 <CA+CK2bBTfmhTWNRrxnVKi=iknqq-iZxNZSnwNA9C9tWAJzRxmw@mail.gmail.com>
 <d89510b1-a6a2-a874-7ffc-ba7a37d4212d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d89510b1-a6a2-a874-7ffc-ba7a37d4212d@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-09-20 20:31:04, David Hildenbrand wrote:
> On 03.09.20 20:23, Pavel Tatashin wrote:
> > On Thu, Sep 3, 2020 at 2:20 PM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 03.09.20 08:38, Michal Hocko wrote:
[...]
> >>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> >>> index 242c03121d73..56d4892bceb8 100644
> >>> --- a/mm/page_isolation.c
> >>> +++ b/mm/page_isolation.c
> >>> @@ -170,6 +170,14 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
> >>>   * pageblocks we may have modified and return -EBUSY to caller. This
> >>>   * prevents two threads from simultaneously working on overlapping ranges.
> >>>   *
> >>> + * Please note that there is no strong synchronization with the page allocator
> >>> + * either. Pages might be freed while their page blocks are marked ISOLATED.
> >>> + * In some cases pages might still end up on pcp lists and that would allow
> >>> + * for their allocation even when they are in fact isolated already. Depending on
> >>> + * how strong of a guarantee the caller needs drain_all_pages might be needed
> >>> + * (e.g. __offline_pages will need to call it after check for isolated range for
> >>> + * a next retry).
> >>> + *
> >>
> >> As expressed in reply to v2, I dislike this hack. There is strong
> >> synchronization, just PCP is special. Allocating from MIGRATE_ISOLATE is
> >> just plain ugly.

Completely agreed! I am not happy about that either. But I believe this
hack is the easiest way forward for stable trees and as an immediate
fix. We can build on top of that of course.

> >> Can't we temporarily disable PCP (while some pageblock in the zone is
> >> isolated, which we know e.g., due to the counter), so no new pages get
> >> put into PCP lists after draining, and re-enable after no pageblocks are
> >> isolated again? We keep draining the PCP, so it doesn't seem to be of a
> >> lot of use during that period, no? It's a performance hit already.

This is a good point.

> >> Then, we would only need exactly one drain. And we would only have to
> >> check on the free path whether PCP is temporarily disabled.
> > 
> > Hm, we could use a static branches to disable it, that would keep
> > release code just as fast, but I am worried it will make code even
> > uglier. Let's see what others in this thread think about this idea.

I know that static branches are a very effective way to enable/disable
features but I have no experience in how they perform for a very
shortlived use. Maybe that is just fine for a single place which needs
to be patched. This would be especially a problem if the static branch
is to be enabled from start_isolate_page_range because that includes all
cma allocator users.

Another alternative would be to enable/disable static branch only from
users who really care but this is quite tricky because how do you tell
you need or not? It seems that alloc_contig_range would be just fine
with a weaker semantic because it would "only" to a spurious failure.
Memory hotplug on the other hand really needs to have a point where
nobody interferes with the offlined memory so it could ask for a
stronger semantic.

Yet another option would be to make draining stronger and actually
guarantee there are no in-flight pages to be freed to the pcp list.
One way would be to tweak pcp->high and implement a strong barrier
(IPI?) to sync with all CPUs. Quite expensive, especially when there are
many draining requests (read cma users because hotplug doesn't really
matter much as it happens seldom).

So no nice&cheap solution I can think of...
-- 
Michal Hocko
SUSE Labs
