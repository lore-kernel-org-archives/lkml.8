Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01487C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA3782078C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgDTLhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:37:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:53736 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbgDTLht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:37:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 102A4AED2;
        Mon, 20 Apr 2020 11:37:47 +0000 (UTC)
Subject: Re: [PATCH 01/10] mm/page-flags: introduce PageHighMemZone()
To:     Matthew Wilcox <willy@infradead.org>, js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1587369582-3882-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1587369582-3882-2-git-send-email-iamjoonsoo.kim@lge.com>
 <20200420112010.GA5820@bombadil.infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <2c45bab6-8c29-e227-56b8-307e8bee46c6@suse.cz>
Date:   Mon, 20 Apr 2020 13:37:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420112010.GA5820@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/20 1:20 PM, Matthew Wilcox wrote:
> On Mon, Apr 20, 2020 at 04:59:33PM +0900, js1304@gmail.com wrote:
>> ZONE_MOVABLE is special. It is considered as normal type zone on
>> !CONFIG_HIGHMEM, but, it is considered as highmem type zone
>> on CONFIG_HIGHMEM. Let's focus on later case. In later case, all pages
>> on the ZONE_MOVABLE has no direct mapping until now.
>> 
>> However, following patchset
>> "mm/cma: manage the memory of the CMA area by using the ZONE_MOVABLE"
>> , which is once merged and reverted, will be tried again and will break
>> this assumption that all pages on the ZONE_MOVABLE has no direct mapping.
>> Hence, the ZONE_MOVABLE which is considered as highmem type zone could
>> have the both types of pages, direct mapped and not. Since
>> the ZONE_MOVABLE could have both type of pages, __GFP_HIGHMEM is still
>> required to allocate the memory from it. And, we conservatively need to
>> consider the ZONE_MOVABLE as highmem type zone.
> 
> I don't understand why CMA allocating pages from ZONE_MOVABLE somehow
> gives these pages a direct mapping.  Maybe you have a freaky layout in
> the architecture that makes no sense and that's what needs to be fixed?
> 
> My understanding of the zones is based on x86, and it looks like this
> on a 32-bit system with 8GB of memory:
> 
> ZONE_DMA	0-16MB
> ZONE_NORMAL	16-896MB
> ZONE_HIGHMEM	896-xMB
> ZONE_MOVABLE	x-8192MB
> 
> where x is a boot option used to partition the highmem between movable
> and unmovable.
> 
> Now, why would allocating the CMA from ZONE_NORMAL suddenly make these
> pages part of the direct mapping?

I assume the scenario is that ZONE_MOVABLE could extend into today's ZONE_NORMAL
range, which is the range covered by direct mapping.
At that point, testing page's zone stops being a reliable test of "does this
page have direct mapping"?

I don't know the exact motivation why that will happen but I can imagine two.
1) some CMA user needs the CMA allocations to be in direct mapping range
2) the amount of CMA memory reservation required is so high it won't fit in
highmem range only.

