Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A89C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B0020873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sy344zC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgCINih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 09:38:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50073 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726427AbgCINih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583761114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=hc8Q51sdG5CQynkjElDQIdZ5VONlVbD7Y26Zp8XeurY=;
        b=Sy344zC3CXsWOjRHio5LJTDlhHbKimtucJJ+8gUMHoplIQGJwOezo4Q+bWYXEKb//8KOdc
        tjD7ZHCQBMHUH53jyr6Py9aL1i0hE4Wl35wTNU/CD3GH8yCJ3uAo/xBLgampTqqqi70ith
        M++0a/utuet8GEiOMLGGuS71nokLzXQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-s2X5L2nQOXWa1UJtTsbW3w-1; Mon, 09 Mar 2020 09:38:33 -0400
X-MC-Unique: s2X5L2nQOXWa1UJtTsbW3w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BA4918C8C00;
        Mon,  9 Mar 2020 13:38:31 +0000 (UTC)
Received: from [10.36.118.226] (unknown [10.36.118.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CB375C1C3;
        Mon,  9 Mar 2020 13:38:25 +0000 (UTC)
Subject: Re: [PATCH v3 3/7] mm/sparse.c: introduce a new function
 clear_subsection_map()
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mhocko@suse.com,
        richardw.yang@linux.intel.com, dan.j.williams@intel.com,
        osalvador@suse.de, rppt@linux.ibm.com
References: <20200307084229.28251-1-bhe@redhat.com>
 <20200307084229.28251-4-bhe@redhat.com>
 <d09c9598-4fbf-71c8-151f-f34921ed565b@redhat.com>
 <20200309133218.GD27711@MiWiFi-R3L-srv>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <504654de-a9e1-3b95-1ef1-147f18eb0834@redhat.com>
Date:   Mon, 9 Mar 2020 14:38:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309133218.GD27711@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.03.20 14:32, Baoquan He wrote:
> On 03/09/20 at 09:59am, David Hildenbrand wrote:
>> On 07.03.20 09:42, Baoquan He wrote:
>>> Factor out the code which clear subsection map of one memory region from
>>> section_deactivate() into clear_subsection_map().
>>>
>>> Signed-off-by: Baoquan He <bhe@redhat.com>
>>> ---
>>>  mm/sparse.c | 31 ++++++++++++++++++++++++-------
>>>  1 file changed, 24 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/mm/sparse.c b/mm/sparse.c
>>> index e37c0abcdc89..d9dcd58d5c1d 100644
>>> --- a/mm/sparse.c
>>> +++ b/mm/sparse.c
>>> @@ -726,15 +726,11 @@ static void free_map_bootmem(struct page *memmap)
>>>  }
>>>  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
>>>  
>>> -static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>>> -		struct vmem_altmap *altmap)
>>> +static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
>>>  {
>>>  	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
>>>  	DECLARE_BITMAP(tmp, SUBSECTIONS_PER_SECTION) = { 0 };
>>>  	struct mem_section *ms = __pfn_to_section(pfn);
>>> -	bool section_is_early = early_section(ms);
>>> -	struct page *memmap = NULL;
>>> -	bool empty = false;
>>>  	unsigned long *subsection_map = ms->usage
>>>  		? &ms->usage->subsection_map[0] : NULL;
>>>  
>>> @@ -745,8 +741,31 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>>>  	if (WARN(!subsection_map || !bitmap_equal(tmp, map, SUBSECTIONS_PER_SECTION),
>>>  				"section already deactivated (%#lx + %ld)\n",
>>>  				pfn, nr_pages))
>>> +		return -EINVAL;
>>> +
>>> +	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
>>> +
>>
>> Nit: I'd drop this line.
> 
> It's fine to me. I usually keep one line for the returning. I will
> remove it when update.
> 
>>
>>> +	return 0;
>>> +}
>>> +
>>> +static bool is_subsection_map_empty(struct mem_section *ms)
>>> +{
>>> +	return bitmap_empty(&ms->usage->subsection_map[0],
>>> +			    SUBSECTIONS_PER_SECTION);
>>> +}
>>> +
>>> +static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>>> +		struct vmem_altmap *altmap)
>>> +{
>>> +	struct mem_section *ms = __pfn_to_section(pfn);
>>> +	bool section_is_early = early_section(ms);
>>> +	struct page *memmap = NULL;
>>> +	bool empty = false;
>>
>> Nit: No need to initialize empty.
> 
> This is inherited from patch 1.
> 
>>
>>> +
>>> +	if (clear_subsection_map(pfn, nr_pages))
>>>  		return;
>>>  
>>
>> Nit: I'd drop this empty line.
>>
>>> +	empty = is_subsection_map_empty(ms);
>>>  	/*
>>>  	 * There are 3 cases to handle across two configurations
>>>  	 * (SPARSEMEM_VMEMMAP={y,n}):
>>> @@ -764,8 +783,6 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>>>  	 *
>>>  	 * For 2/ and 3/ the SPARSEMEM_VMEMMAP={y,n} cases are unified
>>>  	 */
>>> -	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
>>> -	empty = bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION);
>>
>> I do wonder why you moved this up the comment?
> 
> Since this empty will cover two places of handling, so moved it up,
> seems this is what I was thinking. Can move it back here.

You're moving the whole comment later, was just wondering (makes it
slightly harder to review).


-- 
Thanks,

David / dhildenb

