Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9A3C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D933520828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgCEBm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 20:42:57 -0500
Received: from mga09.intel.com ([134.134.136.24]:1074 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgCEBm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 20:42:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 17:42:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,516,1574150400"; 
   d="scan'208";a="287527628"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Mar 2020 17:42:52 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Minchan Kim" <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [RFC 0/3] mm: Discard lazily freed pages when migrating
References: <871rqf850z.fsf@yhuang-dev.intel.com>
        <20200228094954.GB3772@suse.de> <87h7z76lwf.fsf@yhuang-dev.intel.com>
        <20200302151607.GC3772@suse.de> <87zhcy5hoj.fsf@yhuang-dev.intel.com>
        <20200303080945.GX4380@dhcp22.suse.cz>
        <87o8td4yf9.fsf@yhuang-dev.intel.com>
        <20200303085805.GB4380@dhcp22.suse.cz>
        <87ftep4pzy.fsf@yhuang-dev.intel.com>
        <20200304095802.GE16139@dhcp22.suse.cz>
        <20200304105607.GF3772@suse.de>
Date:   Thu, 05 Mar 2020 09:42:52 +0800
In-Reply-To: <20200304105607.GF3772@suse.de> (Mel Gorman's message of "Wed, 4
        Mar 2020 10:56:07 +0000")
Message-ID: <877dzz37c3.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mgorman@suse.de> writes:

> On Wed, Mar 04, 2020 at 10:58:02AM +0100, Michal Hocko wrote:
>> > >> If my understanding were correct, the newly migrated clean MADV_FREE
>> > >> pages will be put at the head of inactive file LRU list instead of the
>> > >> tail.  So it's possible that some useful file cache pages will be
>> > >> reclaimed.
>> > >
>> > > This is the case also when you migrate other pages, right? We simply
>> > > cannot preserve the aging.
>> > 
>> > So you consider the priority of the clean MADV_FREE pages is same as
>> > that of page cache pages?
>> 
>> This is how MADV_FREE has been implemented, yes. See f7ad2a6cb9f7 ("mm:
>> move MADV_FREE pages into LRU_INACTIVE_FILE list") for the
>> justification.
>> 
>> > Because the penalty difference is so large, I
>> > think it may be a good idea to always put clean MADV_FREE pages at the
>> > tail of the inactive file LRU list?
>> 
>> You are again making assumptions without giving any actual real
>> examples. Reconstructing MADV_FREE pages cost can differ a lot. This
>> really depends on the specific usecase. Moving pages to the tail of LRU
>> would make them the primary candidate for the reclaim with a strange
>> LIFO semantic. Adding them to the head might be not the universal win
>> but it will at least provide a reasonable FIFO semantic. I also find
>> it much more easier to reason about MADV_FREE as an inactive cache.
>
> I tend to agree, that would make MADV_FREE behave more like a
> PageReclaim page that gets tagged for immediate reclaim when writeback
> completes. Immediate reclaim is in response to heavy memory pressure where
> there is trouble finding clean file pages to reclaim and dirty/writeback
> pages are getting artifically preserved over hot-but-clean file
> pages. That is a clear inversion of the order pages should be reclaimed
> and is justified.  While there *might* be a basis for reclaiming MADV_FREE
> sooner rather than later, there would have to be some evidence of a Page
> inversion problem where a known hot page was getting reclaimed before
> MADV_FREE pages. For example, it could easily be considered a bug to free
> MADV_FREE pages over a page that was last touched at boot time.

Yes.  This sounds reasonable.  Although the current solution isn't
perfect, it can avoid the really bad situation as above.

Best Regards,
Huang, Ying
