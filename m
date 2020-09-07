Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5BBC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2679F20757
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgIGH0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:26:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:40780 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726888AbgIGH0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:26:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0F480AD6B;
        Mon,  7 Sep 2020 07:26:10 +0000 (UTC)
Date:   Mon, 7 Sep 2020 09:26:08 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/memory_hotplug: drain per-cpu pages again during
 memory offline
Message-ID: <20200907072608.GE30144@dhcp22.suse.cz>
References: <CA+CK2bBZdN56fmsC2jyY_ju8rQfG2-9hForf1CEdcUVL1+wrrA@mail.gmail.com>
 <74f2341a-7834-3e37-0346-7fbc48d74df3@suse.cz>
 <20200902151306.GL4617@dhcp22.suse.cz>
 <e6bf05cb-044c-47a9-3c65-e41b1e42b702@suse.cz>
 <20200903063806.GM4617@dhcp22.suse.cz>
 <c6b11905-2456-52a0-3b15-d4ceae6e7f54@redhat.com>
 <CA+CK2bBTfmhTWNRrxnVKi=iknqq-iZxNZSnwNA9C9tWAJzRxmw@mail.gmail.com>
 <d89510b1-a6a2-a874-7ffc-ba7a37d4212d@redhat.com>
 <20200904070235.GA15277@dhcp22.suse.cz>
 <CA+CK2bDON8A5AmKqPFWOytP-B29U-YAc9maQAvV-oGffaek6Yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bDON8A5AmKqPFWOytP-B29U-YAc9maQAvV-oGffaek6Yg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-09-20 10:25:02, Pavel Tatashin wrote:
> > Another alternative would be to enable/disable static branch only from
> > users who really care but this is quite tricky because how do you tell
> > you need or not? It seems that alloc_contig_range would be just fine
> > with a weaker semantic because it would "only" to a spurious failure.
> > Memory hotplug on the other hand really needs to have a point where
> > nobody interferes with the offlined memory so it could ask for a
> > stronger semantic.
> >
> > Yet another option would be to make draining stronger and actually
> > guarantee there are no in-flight pages to be freed to the pcp list.
> > One way would be to tweak pcp->high and implement a strong barrier
> > (IPI?) to sync with all CPUs. Quite expensive, especially when there are
> > many draining requests (read cma users because hotplug doesn't really
> > matter much as it happens seldom).
> >
> > So no nice&cheap solution I can think of...
> 
> I think start_isolate_page_range() should not be doing page draining
> at all. It should isolate ranges, meaning set appropriate flags, but
> draining should be performed by the users when appropriate: next to
> lru_add_drain_all() calls both in CMA and hotplug.

I disagree. The pcp draining is an implementation detail and we
shouldn't bother callers to be aware of it.

> Currently, the way start_isolate_page_range() drains pages is very
> inefficient. It calls drain_all_pages() for every valid page block,
> which is a slow call as it starts a thread per cpu, and waits for
> those threads to finish before returning.

This is an implementation detail.

> We could optimize by moving the drain_all_pages() calls from
> set_migratetype_isolate() to start_isolate_page_range() and call it
> once for every different zone, but both current users of this
> interface guarantee that all pfns [start_pfn, end_pfn] are within the
> same zone, and I think we should keep it this way, so again the extra
> traversal is going to be overhead overhead.

Again this just leads to tricky code. Just look at how easy it was to
break this by removing something that looked clearly a duplicate call.
It is true that memory isolation usage is limited to only few usecasaes
but I would strongly prefer to make the semantic clear so that we do not
repeat this regressions.
-- 
Michal Hocko
SUSE Labs
