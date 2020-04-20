Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1B5C54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 09:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4355E21D79
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 09:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDTJ3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 05:29:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:38668 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgDTJ3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 05:29:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 73A92AEAA;
        Mon, 20 Apr 2020 09:29:22 +0000 (UTC)
Subject: Re: [PATCH RFC] mm: compaction: avoid migrating non-cma pages to a
 cma area
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Qian Cai <cai@lca.pw>, Andrea Arcangeli <aarcange@redhat.com>,
        Joonsoo Kim <js1304@gmail.com>
References: <20200408194119.1076232-1-guro@fb.com>
 <225868db-b9b0-3614-de0f-4b264023df2b@suse.cz>
 <20200414154204.GC42877@carbon.lan>
 <c60fc30f-463c-31cd-0100-d26a92b83c9d@suse.cz>
 <20200417192116.GA338526@carbon.DHCP.thefacebook.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <1fb8832f-18c1-cc12-7616-1d724b2bdb4f@suse.cz>
Date:   Mon, 20 Apr 2020 11:29:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200417192116.GA338526@carbon.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/20 9:21 PM, Roman Gushchin wrote:
> On Fri, Apr 17, 2020 at 10:37:14AM +0200, Vlastimil Babka wrote:
>> But I've only now also realized how dynamic setting cc->cma is. So in case a
>> zone consists mostly of CMA blocks, removing ALLOC_CMA in
>> __compaction_suitable() would be actually wrong and prevent compaction from
>> doing any work? Sigh. Any idea about that?
> 
> Hm, idk, is it a realistic setup? Looks like it depends significantly on
> the exact usecase.

Yes :/ depends e.g. on how many hugepages are reserved, right?

> Another option is to move the cma area closer to the beginning of a zone.

That wouldn't hurt I guess.

>> 
>> >> 
>> >> And long-term what happens if the "CMA using ZONE_MOVABLE" approach is merged
>> >> and there are not more CMA migratetypes to test? Might this change actually also
>> >> avoid your issue, as said pages without __GFP_MOVABLE won't end up in a
>> >> ZONE_MOVABLE?
>> > 
>> > Yeah, this is what I was thinking about. Basically I want to mimic this behavior
>> > right now. Once this approach will be implemented and merged, it will happen
>> > automatically: obviously, compaction won't move pages between different zones.
> 
> After the second thought it's not so obvious: CMA would need to migrate pages
> (data) between zones, right? It might bring some other complications.

I don't recall how it was implemented, but I assume yeah. There shouldn't be
complications I think, migrating out of CMA area should cause no issue for CMA,
and such migrations between zones or even nodes already happen.

>> 
>> That will be much better. Can't wait, then :)
> 
> Yeah, if it will happen soon-ish, we can just wait. I just don't know
> how hard it is and how many edge cases are there to be figured out first.
> 
> Do you think that it's better to wait and do not merge this patch upstream?

We could probably merge it and watch for issues, but I'd like to have also Mel
and Joonsoo comment on it :)

Thanks,
Vlastimil

> Thanks!
> 

