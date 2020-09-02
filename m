Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5303BC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31558207D3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgIBPOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:14:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:32808 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgIBPNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:13:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AFE3CB1D1;
        Wed,  2 Sep 2020 15:13:08 +0000 (UTC)
Date:   Wed, 2 Sep 2020 17:13:06 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/memory_hotplug: drain per-cpu pages again during
 memory offline
Message-ID: <20200902151306.GL4617@dhcp22.suse.cz>
References: <20200901124615.137200-1-pasha.tatashin@soleen.com>
 <20200902140851.GJ4617@dhcp22.suse.cz>
 <CA+CK2bBZdN56fmsC2jyY_ju8rQfG2-9hForf1CEdcUVL1+wrrA@mail.gmail.com>
 <74f2341a-7834-3e37-0346-7fbc48d74df3@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74f2341a-7834-3e37-0346-7fbc48d74df3@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02-09-20 16:55:05, Vlastimil Babka wrote:
> On 9/2/20 4:26 PM, Pavel Tatashin wrote:
> > On Wed, Sep 2, 2020 at 10:08 AM Michal Hocko <mhocko@suse.com> wrote:
> >>
> >> >
> >> > Thread#1 - continue
> >> >          free_unref_page_commit
> >> >            migratetype = get_pcppage_migratetype(page);
> >> >               // get old migration type
> >> >            list_add(&page->lru, &pcp->lists[migratetype]);
> >> >               // add new page to already drained pcp list
> >> >
> >> > Thread#2
> >> > Never drains pcp again, and therefore gets stuck in the loop.
> >> >
> >> > The fix is to try to drain per-cpu lists again after
> >> > check_pages_isolated_cb() fails.
> >>
> >> But this means that the page is not isolated and so it could be reused
> >> for something else. No?
> > 
> > The page is in a movable zone, has zero references, and the section is
> > isolated (i.e. set_pageblock_migratetype(page, MIGRATE_ISOLATE);) is
> > set. The page should be offlinable, but it is lost in a pcp list as
> > that list is never drained again after the first failure to migrate
> > all pages in the range.
> 
> Yeah. To answer Michal's "it could be reused for something else" - yes, somebody
> could allocate it from the pcplist before we do the extra drain. But then it
> becomes "visible again" and the loop in __offline_pages() should catch it by
> scan_movable_pages() - do_migrate_range(). And this time the pageblock is
> already marked as isolated, so the page (freed by migration) won't end up on the
> pcplist again.

So the page block is marked MIGRATE_ISOLATE but the allocation itself
could be used for non migrateable objects. Or does anything prevent that
from happening?

We really do depend on isolation to not allow reuse when offlining.
-- 
Michal Hocko
SUSE Labs
