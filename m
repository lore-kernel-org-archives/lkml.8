Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4113C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A709F20663
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbgFOLZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 07:25:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:43662 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729038AbgFOLZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 07:25:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6D267AECD;
        Mon, 15 Jun 2020 11:25:13 +0000 (UTC)
Subject: Re: [PATCH v2] page_alloc: consider highatomic reserve in wmartermark
 fast
To:     Jaewon Kim <jaewon31.kim@gmail.com>
Cc:     Jaewon Kim <jaewon31.kim@samsung.com>, mgorman@techsingularity.net,
        minchan@kernel.org, mgorman@suse.de, hannes@cmpxchg.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ytk.lee@samsung.com,
        cmlaika.kim@samsung.com
References: <CGME20200612085027epcas1p46383a7eda792eabbd1e74cd08fe988c9@epcas1p4.samsung.com>
 <20200613025102.12880-1-jaewon31.kim@samsung.com>
 <dd899dd9-43cd-f1fd-15af-863706fa62dc@suse.cz>
 <CAJrd-UuTcEJqgvarWWLyKjbZ9B_saLgdLNKWt-gcjY4CgfMSUw@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <62621a8b-5bdd-ed20-d816-5958ab07d44f@suse.cz>
Date:   Mon, 15 Jun 2020 13:25:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAJrd-UuTcEJqgvarWWLyKjbZ9B_saLgdLNKWt-gcjY4CgfMSUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/20 6:16 AM, Jaewon Kim wrote:
> 
> 
> 2020년 6월 12일 (금) 오후 11:34, Vlastimil Babka <vbabka@suse.cz
> <mailto:vbabka@suse.cz>>님이 작성:
>>
>> On 6/13/20 4:51 AM, Jaewon Kim wrote:
>> > zone_watermark_fast was introduced by commit 48ee5f3696f6 ("mm,
>> > page_alloc: shortcut watermark checks for order-0 pages"). The commit
>> > simply checks if free pages is bigger than watermark without additional
>> > calculation such like reducing watermark.
>> >
>> > It considered free cma pages but it did not consider highatomic
>> > reserved. This may incur exhaustion of free pages except high order
>> > atomic free pages.
>> >
>> > Assume that reserved_highatomic pageblock is bigger than watermark min,
>> > and there are only few free pages except high order atomic free. Because
>> > zone_watermark_fast passes the allocation without considering high order
>> > atomic free, normal reclaimable allocation like GFP_HIGHUSER will
>> > consume all the free pages. Then finally order-0 atomic allocation may
>> > fail on allocation.
>>
>> I don't understand why order-0 atomic allocation will fail. Is it because of
>> watermark check, or finding no suitable pages?
>> - watermark check should be OK as atomic allocations can use reserves
>> - suitable pages should be OK, even if all free pages are in the highatomic
>> reserves, because rmqueue() contains:
>>
>> if (alloc_flags & ALLOC_HARDER)
>>         page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
>>
>> So what am I missing?
>>
> Hello
> The order-0 atomic allocation can be failed because of depletion of suitable
> free page.
> Watermark check passes order-0 atomic allocation but it will be failed at
> finding a free page.
> The  __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC) can be used
> only for highorder.

Ah, that's what I missed, rmqueue() will divert all order-0 allocations to
rmqueue_pcplist() so those will not reach the hunk above. Thanks.

>> > @@ -3598,9 +3604,12 @@ static inline bool zone_watermark_fast(struct zone
> *z, unsigned int order,
>>         /*
>>          * Fast check for order-0 only. If this fails then the reserves
>>          * need to be calculated. There is a corner case where the check
>>          * passes but only the high-order atomic reserve are free. If
>> >        * the caller is !atomic then it'll uselessly search the free
>> >        * list. That corner case is then slower but it is harmless.
>> >        */
>>
>> The comment stops being true after this patch? It also suggests that Mel
>> anticipated this corner case, but that it should only cause a false positive
>> zone_watermark_fast() and then rmqueue() fails for !ALLOC_HARDER as it cannot
>> use MIGRATE_HIGHATOMIC blocks. It expects atomic order-0 still works. So what's
>> going on?
> 
> As Mel also agreed with me in v1 mail thread, this highatomic reserved should
> be considered even in watermark fast.
> 
> The comment, I think, may need to be changed. Prior to this patch, non highatomic
> allocation may do useless search, but it also can take ALL non highatomic free.
> 
> With this patch, non highatomic allocation will NOT do useless search. Rather,

Yes, that's what I meant.
