Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBF5C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D548D20787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgDVOJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 10:09:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:59046 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgDVOJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 10:09:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 817B3ABCF;
        Wed, 22 Apr 2020 14:09:02 +0000 (UTC)
Subject: Re: [RFC PATCH 4/4] mm: Add PG_zero support
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20200412090945.GA19582@open-light-1.localdomain>
 <20200412101223.GK21484@bombadil.infradead.org>
 <5eb37d79-6420-fcb9-2b4c-6cc6194afcd9@linux.intel.com>
 <20200413140537.eb674579cf8c71b4e20581ab@linux-foundation.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <344a3a78-62ad-48fe-40cf-18993175d1e0@suse.cz>
Date:   Wed, 22 Apr 2020 16:09:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200413140537.eb674579cf8c71b4e20581ab@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/20 11:05 PM, Andrew Morton wrote:
> On Mon, 13 Apr 2020 08:11:59 -0700 Alexander Duyck <alexander.h.duyck@linux.intel.com> wrote:
> 
>> In addition, unlike madvising the page away there is a pretty 
>> significant performance penalty for having to clear the page a second 
>> time when the page is split or merged.
> 
> I wonder if there might be an issue with increased memory traffic (and
> increased energy consumption, etc).  If a page is zeroed immediately
> before getting data written into it (eg, plain old file write(),
> anonymous pagefault) then we can expect that those 4096 zeroes will be
> in CPU cache and mostly not written back.  But if that page was zeroed
> a "long" time ago, the caches will probably have been written back. 
> Net result: we go from 4k of memory traffic for a 4k page up to 8k of
> memory traffic?

Heh, I was quite sure that this is not the first time background zeroing is
proposed, so I went to google for it... and found that one BSD kernel actually
removed this functionality in 2016 [1] and this was one of the reasons.

[1]
https://gitweb.dragonflybsd.org/dragonfly.git/commitdiff/afd2da4dc9056ea79cdf15e8a9386a3d3998f33e

> Also, the name CONFIG_ZERO_PAGE sounds like it has something to do with
> the long established "zero page".  Confusing.  CONFIG_PREZERO_PAGE,
> maybe?
> 

