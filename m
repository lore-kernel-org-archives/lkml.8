Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F9BC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B27F5221E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K6gi7hfk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgIJTpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:45:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58772 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730704AbgIJPaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599751831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=x0Dzw4EXUB8Gad1df8MZePd7Ws6OGtwvrfdwG/tOL4M=;
        b=K6gi7hfky9vjk6AfHGdamvIKEhuMj7wbOZbQr8octym4uyoRKB47rID9gPBp96R0cm/HXA
        uYXUl7tnNX2+Ar/wbEcaZxgTEX7k/clz8RQ+BB4/Ln7HdTHt3UzC4uEEM1opEzvhVBu63f
        mMcdQzfJMvaOEthw7TQNM0hLNtC6RmM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-BDo1H3fnNiaOKK0H12zsgg-1; Thu, 10 Sep 2020 11:15:17 -0400
X-MC-Unique: BDo1H3fnNiaOKK0H12zsgg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64DFD8015A5;
        Thu, 10 Sep 2020 15:15:14 +0000 (UTC)
Received: from [10.36.113.88] (ovpn-113-88.ams2.redhat.com [10.36.113.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75AC119C66;
        Thu, 10 Sep 2020 15:15:10 +0000 (UTC)
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
To:     Zi Yan <ziy@nvidia.com>
Cc:     Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
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
 <9ffa345f-fd45-aeac-691d-54d1364bff6d@redhat.com>
 <C249991F-A64E-4262-892F-F1587B800264@nvidia.com>
 <46604da8-55d0-111d-7854-cbaa8bb65925@redhat.com>
 <3684BEAF-C8A2-4EEC-8FC2-55EA5F8F7DA5@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <4b3006cf-3391-6839-904e-b415613198cb@redhat.com>
Date:   Thu, 10 Sep 2020 17:15:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <3684BEAF-C8A2-4EEC-8FC2-55EA5F8F7DA5@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.09.20 16:41, Zi Yan wrote:
> On 10 Sep 2020, at 10:34, David Hildenbrand wrote:
> 
>>>> As long as we stay in safe zone boundaries you get a benefit in most
>>>> scenarios. As soon as we would have a (temporary) workload that would
>>>> require more unmovable allocations we would fallback to polluting some
>>>> pageblocks only.
>>>
>>> The idea would work well until unmoveable pages begin to overflow into
>>> ZONE_PREFER_MOVABLE or we move the boundary of ZONE_PREFER_MOVABLE to
>>> avoid unmoveable page overflow. The issue comes from the lifetime of
>>> the unmoveable pages. Since some long-live ones can be around the boundary,
>>> there is no guarantee that ZONE_PREFER_MOVABLE cannot grow back
>>> even if other unmoveable pages are deallocated. Ultimately,
>>> ZONE_PREFER_MOVABLE would be shrink to a small size and the situation is
>>> back to what we have now.
>>
>> As discussed this would not happen in the usual case in case we size it
>> reasonable. Of course, if you push it to the extreme (which was never
>> suggested!), you would create mess. There is always a way to create a
>> mess if you abuse such mechanism. Also see Rik's reply regarding reclaim.
>>
>>>
>>> OK. I have a stupid question here. Why not just grow pageblock to a larger
>>> size, like 1GB? So the fragmentation of unmoveable pages will be at larger
>>> granularity. But it is less likely unmoveable pages will be allocated at
>>> a movable pageblock, since the kernel has 1GB pageblock for them after
>>> a pageblock stealing. If other kinds of pageblocks run out, moveable and
>>> reclaimable pages can fall back to unmoveable pageblocks.
>>> What am I missing here?
>>
>> Oh no. For example pageblocks have to completely fit into a single
>> section (that's where metadata is maintained). Please refrain from
>> suggesting to increase the section size ;)
> 
> Thank you for the explanation. I have no idea about the restrictions on
> pageblock and section. Out of curiosity, what prevents the growth of
> the section size?

The section size (and based on that the Linux memory block size) defines
- the minimum size in which we can add_memory()
- the alignment requirement in which we can add_memory()

This is applicable
- in physical environments, where the bios will decide where to place
  DIMMs/NVDIMMs. The coarser the granularity, the less memory we might
  be able to make use of in corner cases.
- in virtualized environments, where we want to add memory in fairly
  small granularity. The coarser the granularity, the less flexibility
  we have.

arm64 has a section size of 1GB (and a THP/MAX_ORDER - 1 size of 512MB
with 64k base pages :/ ). That already turned out to be a problem - see
[1] regarding thoughts on how to shrink the section size. I once read
about thoughts of switching to 2MB THP on arm64 with any base page size,
not sure if that will become real at one point (and we might be able to
reduce the pageblock size there as well ... )

[1]
https://lkml.kernel.org/r/AM6PR08MB40690714A2E77A7128B2B2ADF7700@AM6PR08MB4069.eurprd08.prod.outlook.com
See [1] as

> 
> —
> Best Regards,
> Yan Zi
> 


-- 
Thanks,

David / dhildenb

