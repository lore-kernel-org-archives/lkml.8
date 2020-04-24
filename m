Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090FDC2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 07:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6E2620704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 07:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgDXHze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 03:55:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:45914 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbgDXHzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 03:55:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D04A6AAC7;
        Fri, 24 Apr 2020 07:55:30 +0000 (UTC)
Subject: Re: [RFC PATCH 4/4] mm: Add PG_zero support
To:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20200412090945.GA19582@open-light-1.localdomain>
 <20200412101223.GK21484@bombadil.infradead.org>
 <5eb37d79-6420-fcb9-2b4c-6cc6194afcd9@linux.intel.com>
 <20200413140537.eb674579cf8c71b4e20581ab@linux-foundation.org>
 <344a3a78-62ad-48fe-40cf-18993175d1e0@suse.cz>
 <20200423173700.b2c954b3960e4379a4f82e80@linux-foundation.org>
 <20200424004152.GD13910@bombadil.infradead.org>
 <d15623f5-5c89-b9e5-1787-61ad70519774@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <09885eda-9772-4228-dece-3dfd42840580@suse.cz>
Date:   Fri, 24 Apr 2020 09:55:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d15623f5-5c89-b9e5-1787-61ad70519774@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/20 9:28 AM, David Hildenbrand wrote:
> On 24.04.20 02:41, Matthew Wilcox wrote:
>> On Thu, Apr 23, 2020 at 05:37:00PM -0700, Andrew Morton wrote:
>>> On Wed, 22 Apr 2020 16:09:00 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
>>>> Heh, I was quite sure that this is not the first time background zeroing is
>>>> proposed, so I went to google for it... and found that one BSD kernel actually
>>>> removed this functionality in 2016 [1] and this was one of the reasons.
>>>>
>>>> [1]
>>>> https://gitweb.dragonflybsd.org/dragonfly.git/commitdiff/afd2da4dc9056ea79cdf15e8a9386a3d3998f33e
>>>
>>> Interesting.
>>>
>>> However this:
>>>
>>>   - Pre-zeroing a page leads to a cold-cache case on-use, forcing the fault
>>>     source (e.g. a userland program) to actually get the data from main
>>>     memory in its likely immediate use of the faulted page, reducing
>>>     performance.
>>>
>>> implies that BSD was zeroing with non-temporal stores which bypass the
>>> CPU cache.  And which presumably invalidate any part of the target
>>> memory which was already in cache.  We wouldn't do it that way so
>>> perhaps the results would differ.
>> 
>> Or just that the page was zeroed far enough in advance that it fell out
>> of cache naturally.

Agreed.

>> I know Arjan looked at zeroing on free instead of zeroing on alloc,
>> and that didn't get merged (or even submitted afaik), so presumably the
>> results weren't good.
> 
> We do have INIT_ON_FREE_DEFAULT_ON
> 
> via
> 
> commit 6471384af2a6530696fc0203bafe4de41a23c9ef
> Author: Alexander Potapenko <glider@google.com>
> Date:   Thu Jul 11 20:59:19 2019 -0700
> 
>     mm: security: introduce init_on_alloc=1 and init_on_free=1 boot options
> 
> which seems to do exactly that (although for a different use case)

Yeah, except the security use case wants to do that immediately, while the
proposal here is a background thread.
