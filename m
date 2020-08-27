Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97145C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AE7822CAE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgH0Mra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 08:47:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:52164 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728830AbgH0MeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:34:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 11DF2AD63;
        Thu, 27 Aug 2020 12:16:31 +0000 (UTC)
Subject: Re: [PATCH for v5.9] mm/page_alloc: handle a missing case for
 memalloc_nocma_{save/restore} APIs
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        kernel-team@lge.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <1598331582-19923-1-git-send-email-iamjoonsoo.kim@lge.com>
 <e83100ae-d687-3b4e-8256-aee242191ada@suse.cz>
 <CAAmzW4MRizKRbdt_ZBqs_+OQGsP4f2F6iYDk88u78kYqOZA9NQ@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <77c6dfeb-06e9-0347-6f3d-188bb67b263c@suse.cz>
Date:   Thu, 27 Aug 2020 14:15:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAAmzW4MRizKRbdt_ZBqs_+OQGsP4f2F6iYDk88u78kYqOZA9NQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/20 7:12 AM, Joonsoo Kim wrote:
> 2020년 8월 25일 (화) 오후 6:43, Vlastimil Babka <vbabka@suse.cz>님이 작성:
>>
>>
>> On 8/25/20 6:59 AM, js1304@gmail.com wrote:
>> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>> >
>> > memalloc_nocma_{save/restore} APIs can be used to skip page allocation
>> > on CMA area, but, there is a missing case and the page on CMA area could
>> > be allocated even if APIs are used. This patch handles this case to fix
>> > the potential issue.
>> >
>> > Missing case is an allocation from the pcplist. MIGRATE_MOVABLE pcplist
>> > could have the pages on CMA area so we need to skip it if ALLOC_CMA isn't
>> > specified.
>> >
>> > This patch implements this behaviour by checking allocated page from
>> > the pcplist rather than skipping an allocation from the pcplist entirely.
>> > Skipping the pcplist entirely would result in a mismatch between watermark
>> > check and actual page allocation.
>>
>> Are you sure? I think a mismatch exists already. Pages can be on the pcplist but
>> they are not considered as free in the watermark check. So passing watermark
>> check means there should be also pages on free lists. So skipping pcplists would
>> be safe, no?
> 
> You are right.
> 
>> > And, it requires to break current code
>> > layering that order-0 page is always handled by the pcplist. I'd prefer
>> > to avoid it so this patch uses different way to skip CMA page allocation
>> > from the pcplist.
>>
>> Well it would be much simpler and won't affect most of allocations. Better than
>> flushing pcplists IMHO.
> 
> Hmm...Still, I'd prefer my approach. There are two reasons. First,
> layering problem
> mentioned above. In rmqueue(), there is a code for MIGRATE_HIGHATOMIC.
> As the name shows, it's for high order atomic allocation. But, after
> skipping pcplist
> allocation as you suggested, we could get there with order 0 request.
> We can also
> change this code, but, I'd hope to maintain current layering. Second,
> a performance
> reason. After the flag for nocma is up, a burst of nocma allocation
> could come. After
> flushing the pcplist one times, we can use the free page on the
> pcplist as usual until
> the context is changed.

Both solutions are ugly and we should have CMA in ZONE_MOVABLE or get rid of it
completely. Let's CC Mel what he thinks.

> How about my reasoning?
> 
> Thanks.
> 

