Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33143C3F2CE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBB620828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgCEBpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 20:45:16 -0500
Received: from mga17.intel.com ([192.55.52.151]:6212 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgCEBpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 20:45:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 17:45:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,516,1574150400"; 
   d="scan'208";a="263809050"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by fmsmga004.fm.intel.com with ESMTP; 04 Mar 2020 17:45:12 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mel Gorman <mgorman@suse.de>, David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [RFC 0/3] mm: Discard lazily freed pages when migrating
References: <20200228094954.GB3772@suse.de>
        <87h7z76lwf.fsf@yhuang-dev.intel.com> <20200302151607.GC3772@suse.de>
        <87zhcy5hoj.fsf@yhuang-dev.intel.com>
        <20200303080945.GX4380@dhcp22.suse.cz>
        <87o8td4yf9.fsf@yhuang-dev.intel.com>
        <20200303085805.GB4380@dhcp22.suse.cz>
        <87ftep4pzy.fsf@yhuang-dev.intel.com>
        <20200304095802.GE16139@dhcp22.suse.cz>
        <87blpc2wxj.fsf@yhuang-dev.intel.com>
        <20200304112653.GH16139@dhcp22.suse.cz>
Date:   Thu, 05 Mar 2020 09:45:11 +0800
In-Reply-To: <20200304112653.GH16139@dhcp22.suse.cz> (Michal Hocko's message
        of "Wed, 4 Mar 2020 12:26:53 +0100")
Message-ID: <8736an3788.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:

> On Wed 04-03-20 19:15:20, Huang, Ying wrote:
>> Michal Hocko <mhocko@kernel.org> writes:
>> 
>> > On Tue 03-03-20 19:49:53, Huang, Ying wrote:
> [...]
>> >> Because the penalty difference is so large, I
>> >> think it may be a good idea to always put clean MADV_FREE pages at the
>> >> tail of the inactive file LRU list?
>> >
>> > You are again making assumptions without giving any actual real
>> > examples. Reconstructing MADV_FREE pages cost can differ a lot.
>> 
>> In which situation the cost to reconstruct MADV_FREE pages can be higher
>> than the cost to allocate file cache page and read from disk?  Heavy
>> contention on mmap_sem?
>
> Allocating a page might be really costly but even without that.

File cache page needs to be allocated too.

> Reconstructnig the content of the page can be really high and actually
> much larger than an IO to get a page from the storage. Consider
> decompression or some other transformations to get the content.
> Userspace has means to detect that the content is still up-to-date as
> already has been mentioned so all those steps can be avoided.

Although I don't believe someone has really done this.  It's possible at
least in theory.

Best Regards,
Huang, Ying
