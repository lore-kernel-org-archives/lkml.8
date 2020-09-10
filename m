Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CF4C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C9A22076D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPQnq/zd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbgIJI1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:27:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56844 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730412AbgIJI1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599726451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=CAceJYo8i16bUPVAl+qJrQMnEColNt7dWId2KccjTlI=;
        b=QPQnq/zdOjSoNw2iuhq1U3aY8Of/tEtzJKnRVTsWMMXnEvmSVDHwZ7DUbNf2HfbjoAcljO
        zM7yg+dw82dVPdYR8liLYtZ7c52idJ7VY1oVHHX0VLKn5hpuMU8beBBXWGfDEVAnKumth3
        AY1HSOpYjSpTChyLD1WfZjKRt/EcojQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-JwGAtMAyNteUJIZ7HxwWNQ-1; Thu, 10 Sep 2020 04:27:28 -0400
X-MC-Unique: JwGAtMAyNteUJIZ7HxwWNQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96CCF10ABDAC;
        Thu, 10 Sep 2020 08:27:25 +0000 (UTC)
Received: from [10.36.113.88] (ovpn-113-88.ams2.redhat.com [10.36.113.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 885AE7E46E;
        Thu, 10 Sep 2020 08:27:22 +0000 (UTC)
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
To:     Michal Hocko <mhocko@suse.com>
Cc:     Rik van Riel <riel@surriel.com>, Zi Yan <ziy@nvidia.com>,
        Roman Gushchin <guro@fb.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200903142300.bjq2um5y5nwocvar@box>
 <20200903163020.GG60440@carbon.dhcp.thefacebook.com>
 <8e677ead-206d-08dd-d73e-569bd3803e3b@redhat.com>
 <7E20392E-5ED7-4C22-9555-F3BAABF3CBE9@nvidia.com>
 <20200908143503.GE26850@dhcp22.suse.cz>
 <7ed82cb06074b30c2956638082c515fb179f69a3.camel@surriel.com>
 <20200909070445.GA7348@dhcp22.suse.cz>
 <054d02f3b34d9946905929ff268b685c91494b3e.camel@surriel.com>
 <6135d2c5-2a74-6ca8-4b3b-8ceb25c0d4b1@redhat.com>
 <20200910073213.GC28354@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <9ffa345f-fd45-aeac-691d-54d1364bff6d@redhat.com>
Date:   Thu, 10 Sep 2020 10:27:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200910073213.GC28354@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.09.20 09:32, Michal Hocko wrote:
> [Cc Vlastimil and Mel - the whole email thread starts
>  http://lkml.kernel.org/r/20200902180628.4052244-1-zi.yan@sent.com
>  but this particular subthread has diverged a bit and you might find it
>  interesting]
> 
> On Wed 09-09-20 15:43:55, David Hildenbrand wrote:
>> On 09.09.20 15:19, Rik van Riel wrote:
>>> On Wed, 2020-09-09 at 09:04 +0200, Michal Hocko wrote:
>>>> On Tue 08-09-20 10:41:10, Rik van Riel wrote:
>>>>> On Tue, 2020-09-08 at 16:35 +0200, Michal Hocko wrote:
>>>>>
>>>>>> A global knob is insufficient. 1G pages will become a very
>>>>>> precious
>>>>>> resource as it requires a pre-allocation (reservation). So it
>>>>>> really
>>>>>> has
>>>>>> to be an opt-in and the question is whether there is also some
>>>>>> sort
>>>>>> of
>>>>>> access control needed.
>>>>>
>>>>> The 1GB pages do not require that much in the way of
>>>>> pre-allocation. The memory can be obtained through CMA,
>>>>> which means it can be used for movable 4kB and 2MB
>>>>> allocations when not
>>>>> being used for 1GB pages.
>>>>
>>>> That CMA has to be pre-reserved, right? That requires a
>>>> configuration.
>>>
>>> To some extent, yes.
>>>
>>> However, because that pool can be used for movable
>>> 4kB and 2MB
>>> pages as well as for 1GB pages, it would be easy to just set
>>> the size of that pool to eg. 1/3 or even 1/2 of memory for every
>>> system.
>>>
>>> It isn't like the pool needs to be the exact right size. We
>>> just need to avoid the "highmem problem" of having too little
>>> memory for kernel allocations.
>>>
>>
>> I am not sure I like the trend towards CMA that we are seeing, reserving
>> huge buffers for specific users (and eventually even doing it
>> automatically).
>>
>> What we actually want is ZONE_MOVABLE with relaxed guarantees, such that
>> anybody who requires large, unmovable allocations can use it.
>>
>> I once played with the idea of having ZONE_PREFER_MOVABLE, which
>> a) Is the primary choice for movable allocations
>> b) Is allowed to contain unmovable allocations (esp., gigantic pages)
>> c) Is the fallback for ZONE_NORMAL for unmovable allocations, instead of
>> running out of memory
> 
> I might be missing something but how can this work longterm? Or put in
> another words why would this work any better than existing fragmentation
> avoidance techniques that page allocator implements already - movability
> grouping etc. Please note that I am not deeply familiar with those but
> my high level understanding is that we already try hard to not mix
> movable and unmovable objects in same page blocks as much as we can.

Note that we group in pageblock granularity, which avoids fragmentation
on a pageblock level, not on anything bigger than that. Especially
MAX_ORDER - 1 pages (e.g., on x86-64) and gigantic pages.

So once you run for some time on a system (especially thinking about
page shuffling *within* a zone), trying to allocate a gigantic page will
simply always fail - even if you always had plenty of free memory in
your single zone.

> 
> My suspicion is that a separate zone would work in a similar fashion. As
> long as there is a lot of free memory then zone will be effectively
> MOVABLE. Similar applies to normal zone when unmovable allocations are

Note the difference to MOVABLE: if you really want, you *can* put
movable allocations into that zone. So you can happily allocate gigantic
pages from it. Or anything else you like. As the name suggests "prefer
movable allocations".

> in minority. As long as the Normal zone gets full of unmovable objects
> they start overflowing to ZONE_PREFER_MOVABLE and it will resemble page
> block stealing when unmovable objects start spreading over movable page
> blocks.

Right, the long-term goal would be
1. To limit the chance of that happening. (e.g., size it in a way that's
safe for 99.9% of all setups, resize dynamically on demand)
2. To limit the physical area where that is happening (e.g., find lowest
possible pageblock etc.). That's more tricky but I consider this a pure
optimization on top.

As long as we stay in safe zone boundaries you get a benefit in most
scenarios. As soon as we would have a (temporary) workload that would
require more unmovable allocations we would fallback to polluting some
pageblocks only.

> 
> Again, my level of expertise to page allocator is quite low so all the
> above might be simply wrong...

Same over here. I had this idea in my mind for quite a while but
obviously didn't get to figure out the details/implement yet - that's
why I decided to share the basic idea just now.

-- 
Thanks,

David / dhildenb

