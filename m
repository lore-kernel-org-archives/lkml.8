Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38042C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D57E2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/EF5Gjc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgG2M3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:29:41 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:35338 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726054AbgG2M3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596025778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=stNpq+nZVBf7QBNhpKBEVIyH7rzCTGS8JQdSuPznJRw=;
        b=U/EF5Gjcu7RAEe+Jf4wvDWjrB7RbaFrxIDd5enBX6ZlDBG8MXCsBkKdZAErElJuXiRXqmX
        IjteYr+PAcQJCaVypYVNm/WrTuz5mawhc+ldOGFg7CGMAIoBItzTlp1V8Hr5TpKwcoWEdO
        BFQsL9eosWbkpyPKU/GtGkbKkLz3jCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-ANH5a0kLMuuwH3bHQVdJuw-1; Wed, 29 Jul 2020 08:29:36 -0400
X-MC-Unique: ANH5a0kLMuuwH3bHQVdJuw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F18BF8005B0;
        Wed, 29 Jul 2020 12:29:34 +0000 (UTC)
Received: from [10.36.113.153] (ovpn-113-153.ams2.redhat.com [10.36.113.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 002431002393;
        Wed, 29 Jul 2020 12:29:29 +0000 (UTC)
Subject: Re: [PATCH v1 1/6] mm/page_alloc: tweak comments in
 has_unmovable_pages()
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
References: <20200630142639.22770-1-david@redhat.com>
 <20200630142639.22770-2-david@redhat.com>
 <20200728134826.GC14854@MiWiFi-R3L-srv>
 <c0371385-c7b4-226f-aac5-f668c74d765a@redhat.com>
 <20200729104753.GF14854@MiWiFi-R3L-srv>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <8a8c2306-3066-103a-17e1-22fb3b8484ba@redhat.com>
Date:   Wed, 29 Jul 2020 14:29:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200729104753.GF14854@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.07.20 12:47, Baoquan He wrote:
> On 07/28/20 at 04:07pm, David Hildenbrand wrote:
>> On 28.07.20 15:48, Baoquan He wrote:
>>> On 06/30/20 at 04:26pm, David Hildenbrand wrote:
>>>> Let's move the split comment regarding bootmem allocations and memory
>>>> holes, especially in the context of ZONE_MOVABLE, to the PageReserved()
>>>> check.
>>>>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: Michal Hocko <mhocko@suse.com>
>>>> Cc: Michael S. Tsirkin <mst@redhat.com>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>  mm/page_alloc.c | 22 ++++++----------------
>>>>  1 file changed, 6 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>> index 48eb0f1410d47..bd3ebf08f09b9 100644
>>>> --- a/mm/page_alloc.c
>>>> +++ b/mm/page_alloc.c
>>>> @@ -8207,14 +8207,6 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>>>>  	unsigned long iter = 0;
>>>>  	unsigned long pfn = page_to_pfn(page);
>>>>  
>>>> -	/*
>>>> -	 * TODO we could make this much more efficient by not checking every
>>>> -	 * page in the range if we know all of them are in MOVABLE_ZONE and
>>>> -	 * that the movable zone guarantees that pages are migratable but
>>>> -	 * the later is not the case right now unfortunatelly. E.g. movablecore
>>>> -	 * can still lead to having bootmem allocations in zone_movable.
>>>> -	 */
>>>> -
>>>>  	if (is_migrate_cma_page(page)) {
>>>>  		/*
>>>>  		 * CMA allocations (alloc_contig_range) really need to mark
>>>> @@ -8233,6 +8225,12 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>>>>  
>>>>  		page = pfn_to_page(pfn + iter);
>>>>  
>>>> +		/*
>>>> +		 * Both, bootmem allocations and memory holes are marked
>>>> +		 * PG_reserved and are unmovable. We can even have unmovable
>>>> +		 * allocations inside ZONE_MOVABLE, for example when
>>>> +		 * specifying "movable_core".
>>>                                ~~~~ should be 'movablecore', we don't
>>> have kernel parameter 'movable_core'.
>>
>> Agreed!
>>
>>>
>>> Otherwise, this looks good to me. Esp the code comment at below had been
>>> added very long time ago and obsolete.
>>>
>>> Reviewed-by: Baoquan He <bhe@redhat.com>
>>>
>>> By the way, David, do you know what is the situation of having unmovable
>>> allocations inside ZONE_MOVABLE when specifying 'movablecore'? I quickly
>>> went through find_zone_movable_pfns_for_nodes(), but didn't get why.
>>> Could you tell a little more detail about it?
>>
>> As far as I understand, it can happen that we have memblock allocations
>> during boot that fall into an area the kernel later configures to span
>> the movable zone (via movable_core).
> 
> Seems yes, thanks a lot. Wondering who is still using
> movablecore|kernelcore in what use case.
> 

AFAIK, it's the only (guaranteed) way to get ZONE_MOVABLE without
involving memory hotplug. As I learned, the movable zone is also
interesting beyond memory hotunplug. It limits unmovable fragmentation
and e.g., makes THP/huge pages more likely/easier to allocate.

-- 
Thanks,

David / dhildenb

