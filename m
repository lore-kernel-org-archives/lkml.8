Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF14C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D62206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgD1JiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 05:38:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:41084 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727042AbgD1JiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 05:38:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D6BF0AD92;
        Tue, 28 Apr 2020 09:38:19 +0000 (UTC)
Subject: Re: [patch] mm, oom: stop reclaiming if GFP_ATOMIC will start failing
 soon
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
References: <alpine.DEB.2.22.394.2004241347310.70176@chino.kir.corp.google.com>
 <20200425172706.26b5011293e8dc77b1dccaf3@linux-foundation.org>
 <alpine.DEB.2.22.394.2004261959310.80211@chino.kir.corp.google.com>
 <20200427133051.b71f961c1bc53a8e72c4f003@linux-foundation.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <28e35a8b-400e-9320-5a97-accfccf4b9a8@suse.cz>
Date:   Tue, 28 Apr 2020 11:38:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427133051.b71f961c1bc53a8e72c4f003@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/20 10:30 PM, Andrew Morton wrote:
> On Sun, 26 Apr 2020 20:12:58 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:
> 
>> 
>> GFP_ATOMIC allocators can access below these per-zone watermarks.  So the 
>> issue is that per-zone free pages stays between ALLOC_HIGH watermarks 
>> (the watermark that GFP_ATOMIC allocators can allocate to) and min 
>> watermarks.  We never reclaim enough memory to get back to min watermarks 
>> because reclaim cannot keep up with the amount of GFP_ATOMIC allocations.
> 
> But there should be an upper bound upon the total amount of in-flight
> GFP_ATOMIC memory at any point in time?  These aren't like pagecache

If it's a network receive path, then this is effectively bounded by link speed 
vs ability to deal with the packets quickly and free the buffers. And the bursts 
of incoming packets might be out of control of the admin. With my "enterprise 
kernel support" hat on, it's it's annoying enough to explain GFP_ATOMIC failures 
(usually high-order) in dmesg every once in a while (the usual suggestion is to 
bump min_free_kbytes and stress that unless they are frequent, there's no actual 
harm as networking can defer the allocation to non-atomic context). If there was 
an OOM kill as a result, that could not be disabled, I can well imagine we would 
have to revert such patch in our kernel as a result due to the DOS (intentional 
or not) potential.

> which will take more if we give it more.  Setting the various
> thresholds appropriately should ensure that blockable allocations don't
> get their memory stolen by GPP_ATOMIC allocations?

I agree with the view that GFP_ATOMIC is only a (perhaps more visible) part of 
the problem that there's no fairness guarantee in reclaim, and allocators can 
steal from each other. GFP_ATOMIC allocations just have it easier thanks to 
lower thresholds.

> I took a look at doing a quick-fix for the
> direct-reclaimers-get-their-stuff-stolen issue about a million years
> ago.  I don't recall where it ended up.  It's pretty trivial for the
> direct reclaimer to free pages into current->reclaimed_pages and to
> take a look in there on the allocation path, etc.  But it's only
> practical for order-0 pages.

FWIW there's already such approach added to compaction by Mel some time ago, so 
order>0 allocations are covered to some extent. But in this case I imagine that 
compaction won't even start because order-0 watermarks are too low.

The order-0 reclaim capture might work though - as a result the GFP_ATOMIC 
allocations would more likely fail and defer to their fallback context.
