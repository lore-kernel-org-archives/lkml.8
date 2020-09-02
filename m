Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4CDC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60C382083B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgIBRvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 13:51:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:46328 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgIBRvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 13:51:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DD109AD5C;
        Wed,  2 Sep 2020 17:51:46 +0000 (UTC)
Subject: Re: [PATCH] mm/memory_hotplug: drain per-cpu pages again during
 memory offline
To:     Michal Hocko <mhocko@suse.com>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
References: <20200901124615.137200-1-pasha.tatashin@soleen.com>
 <20200902140851.GJ4617@dhcp22.suse.cz>
 <CA+CK2bBZdN56fmsC2jyY_ju8rQfG2-9hForf1CEdcUVL1+wrrA@mail.gmail.com>
 <74f2341a-7834-3e37-0346-7fbc48d74df3@suse.cz>
 <20200902151306.GL4617@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <e6bf05cb-044c-47a9-3c65-e41b1e42b702@suse.cz>
Date:   Wed, 2 Sep 2020 19:51:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902151306.GL4617@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/20 5:13 PM, Michal Hocko wrote:
> On Wed 02-09-20 16:55:05, Vlastimil Babka wrote:
>> On 9/2/20 4:26 PM, Pavel Tatashin wrote:
>> > On Wed, Sep 2, 2020 at 10:08 AM Michal Hocko <mhocko@suse.com> wrote:
>> >>
>> >> >
>> >> > Thread#1 - continue
>> >> >          free_unref_page_commit
>> >> >            migratetype = get_pcppage_migratetype(page);
>> >> >               // get old migration type
>> >> >            list_add(&page->lru, &pcp->lists[migratetype]);
>> >> >               // add new page to already drained pcp list
>> >> >
>> >> > Thread#2
>> >> > Never drains pcp again, and therefore gets stuck in the loop.
>> >> >
>> >> > The fix is to try to drain per-cpu lists again after
>> >> > check_pages_isolated_cb() fails.
>> >>
>> >> But this means that the page is not isolated and so it could be reused
>> >> for something else. No?
>> > 
>> > The page is in a movable zone, has zero references, and the section is
>> > isolated (i.e. set_pageblock_migratetype(page, MIGRATE_ISOLATE);) is
>> > set. The page should be offlinable, but it is lost in a pcp list as
>> > that list is never drained again after the first failure to migrate
>> > all pages in the range.
>> 
>> Yeah. To answer Michal's "it could be reused for something else" - yes, somebody
>> could allocate it from the pcplist before we do the extra drain. But then it
>> becomes "visible again" and the loop in __offline_pages() should catch it by
>> scan_movable_pages() - do_migrate_range(). And this time the pageblock is
>> already marked as isolated, so the page (freed by migration) won't end up on the
>> pcplist again.
> 
> So the page block is marked MIGRATE_ISOLATE but the allocation itself
> could be used for non migrateable objects. Or does anything prevent that
> from happening?

In a movable zone, the allocation should not be used for non migrateable
objects. E.g. if the zone was not ZONE_MOVABLE, the offlining could fail
regardless of this race (analogically for migrating away from CMA pageblocks).

> We really do depend on isolation to not allow reuse when offlining.

This is not really different than if the page on pcplist was allocated just a
moment before the offlining, thus isolation started. We ultimately rely on being
able to migrate any allocated pages away during the isolation. This "freeing to
pcplists" race doesn't fundamentally change anything in this regard. We just
have to guarantee that pages on pcplists will be eventually flushed, to make
forward progress, and there was a bug in this aspect.
