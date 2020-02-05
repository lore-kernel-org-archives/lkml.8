Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3D2C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F5D20702
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JyJbaF7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgBENia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 08:38:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32868 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727330AbgBENi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 08:38:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580909907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=Agz9OOSwh/kMogylLZTc8aqiR/PYROY7DvCwBwmTAoo=;
        b=JyJbaF7K1f9l1Jw4WlnYP3K2j6vdJIusrP3tJFueW5yhUaJmTqq/e+sw0wkQ2y5pyLFBiG
        jLzxHils39W3+KClIMcMeg7TUzgh+N09S2e/TlL+ZvAJ0k7MRzSAHKqvag0EnB8n4+16Hj
        6QLTwowJsZl/Llzcw0dtINWuNjXB+O8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-SGBxGYQQOZyggmt3BmxcNA-1; Wed, 05 Feb 2020 08:38:25 -0500
X-MC-Unique: SGBxGYQQOZyggmt3BmxcNA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C391190B2AF;
        Wed,  5 Feb 2020 13:38:23 +0000 (UTC)
Received: from [10.36.116.217] (ovpn-116-217.ams2.redhat.com [10.36.116.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 415235DA83;
        Wed,  5 Feb 2020 13:38:19 +0000 (UTC)
Subject: Re: [PATCH v6 08/10] mm/memory_hotplug: Don't check for "all holes"
 in shrink_zone_span()
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>
References: <20191006085646.5768-1-david@redhat.com>
 <20191006085646.5768-9-david@redhat.com>
 <20200204142516.GD26758@MiWiFi-R3L-srv>
 <e0006cc4-d448-89c6-38c0-51da7fc08715@redhat.com>
 <20200205124329.GE26758@MiWiFi-R3L-srv>
 <cd353848-301a-025d-dd66-44d76e1bbc44@redhat.com>
 <20200205133442.GC8965@MiWiFi-R3L-srv>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <2868343a-745b-e2b6-7e78-d5649c00ee31@redhat.com>
Date:   Wed, 5 Feb 2020 14:38:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200205133442.GC8965@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.02.20 14:34, Baoquan He wrote:
> On 02/05/20 at 02:20pm, David Hildenbrand wrote:
>> On 05.02.20 13:43, Baoquan He wrote:
>>> On 02/04/20 at 03:42pm, David Hildenbrand wrote:
>>>> On 04.02.20 15:25, Baoquan He wrote:
>>>>> On 10/06/19 at 10:56am, David Hildenbrand wrote:
>>>>>> If we have holes, the holes will automatically get detected and removed
>>>>>> once we remove the next bigger/smaller section. The extra checks can
>>>>>> go.
>>>>>>
>>>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>>>> Cc: Oscar Salvador <osalvador@suse.de>
>>>>>> Cc: Michal Hocko <mhocko@suse.com>
>>>>>> Cc: David Hildenbrand <david@redhat.com>
>>>>>> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
>>>>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>>>>> Cc: Wei Yang <richardw.yang@linux.intel.com>
>>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>>> ---
>>>>>>  mm/memory_hotplug.c | 34 +++++++---------------------------
>>>>>>  1 file changed, 7 insertions(+), 27 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>>>>> index f294918f7211..8dafa1ba8d9f 100644
>>>>>> --- a/mm/memory_hotplug.c
>>>>>> +++ b/mm/memory_hotplug.c
>>>>>> @@ -393,6 +393,9 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>>>>>>  		if (pfn) {
>>>>>>  			zone->zone_start_pfn = pfn;
>>>>>>  			zone->spanned_pages = zone_end_pfn - pfn;
>>>>>> +		} else {
>>>>>> +			zone->zone_start_pfn = 0;
>>>>>> +			zone->spanned_pages = 0;
>>>>>>  		}
>>>>>>  	} else if (zone_end_pfn == end_pfn) {
>>>>>>  		/*
>>>>>> @@ -405,34 +408,11 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>>>>>>  					       start_pfn);
>>>>>>  		if (pfn)
>>>>>>  			zone->spanned_pages = pfn - zone_start_pfn + 1;
>>>>>> +		else {
>>>>>> +			zone->zone_start_pfn = 0;
>>>>>> +			zone->spanned_pages = 0;
>>>>>
>>>>> Thinking in which case (zone_start_pfn != start_pfn) and it comes here.
>>>>
>>>> Could only happen in case the zone_start_pfn would have been "out of the
>>>> zone already". If you ask me: unlikely :)
>>>
>>> Yeah, I also think it's unlikely to come here.
>>>
>>> The 'if (zone_start_pfn == start_pfn)' checking also covers the case
>>> (zone_start_pfn == start_pfn && zone_end_pfn == end_pfn). So this
>>> zone_start_pfn/spanned_pages resetting can be removed to avoid
>>> confusion.
>>
>> At least I would find it more confusing without it (or want a comment
>> explaining why this does not have to be handled and why the !pfn case is
>> not possible).
> 
> I don't get why being w/o it will be more confusing, but it's OK since
> it doesn't impact anything. 

Because we could actually BUG_ON(!pfn) here, right? Only having a "if
(pfn)" leaves the reader wondering "why is the other case not handled".

> 
>>
>> Anyhow, that patch is already upstream and I don't consider this high
>> priority. Thanks :)
> 
> Yeah, noticed you told Wei the status in another patch thread, I am fine
> with it, just leave it to you to decide. Thanks.

I am fairly busy right now. Can you send a patch (double-checking and
making this eventually unconditional?). Thanks!

-- 
Thanks,

David / dhildenb

