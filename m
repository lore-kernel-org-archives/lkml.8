Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB123C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 12:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 567B720882
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 12:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWGyWqTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbgIJMw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 08:52:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42781 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730785AbgIJMm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599741730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=5m0WkdV639fgCgimjI86esC42l8HUZn+5016+yBe+9I=;
        b=eWGyWqTrYhaqDs7RTFwRHnaY71fNVD6L4eH5axrkwdWFYGGK2HA2EFYKTC6GD5ObryVK6a
        oPWgqtTPysD1MKv3tKFenQQIOx9Srr+Sp/xrIt7yqpDtWCG4HPq1e2ZJ75mN0sODjeu/Mu
        ILU9VOKihjmY3VJSBiTlRn9hNX/8N0c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-E2iP_pULPrGCke5S3vSm8g-1; Thu, 10 Sep 2020 08:42:07 -0400
X-MC-Unique: E2iP_pULPrGCke5S3vSm8g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 161578015DB;
        Thu, 10 Sep 2020 12:42:05 +0000 (UTC)
Received: from [10.36.113.88] (ovpn-113-88.ams2.redhat.com [10.36.113.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 313C55C5AF;
        Thu, 10 Sep 2020 12:42:01 +0000 (UTC)
Subject: Re: [RFC 5/5] mm, page_alloc: disable pcplists during page isolation
To:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20200907163628.26495-1-vbabka@suse.cz>
 <20200907163628.26495-6-vbabka@suse.cz>
 <d5d5ef64-b239-0640-5640-75c7a3c78584@suse.cz>
 <20200909113647.GG7348@dhcp22.suse.cz>
 <b057e618-94f1-3f5a-a4f6-55fc93ac34eb@suse.cz>
 <5c5753b4-8cb9-fa02-a0fa-d5ca22731cbb@redhat.com>
 <3d3b53db-aeaa-ff24-260b-36427fac9b1c@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <f75e4d22-925c-3548-e4af-a96994b7c10f@redhat.com>
Date:   Thu, 10 Sep 2020 14:42:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <3d3b53db-aeaa-ff24-260b-36427fac9b1c@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.09.20 13:05, Vlastimil Babka wrote:
> On 9/10/20 12:29 PM, David Hildenbrand wrote:
>> On 09.09.20 13:55, Vlastimil Babka wrote:
>>> On 9/9/20 1:36 PM, Michal Hocko wrote:
>>>> On Wed 09-09-20 12:48:54, Vlastimil Babka wrote:
>>>>> Here's a version that will apply on top of next-20200908. The first 4 patches need no change.
>>>>> For callers that pair start_isolate_page_range() with
>>>>> undo_isolated_page_range() properly, this is transparent. Currently that's
>>>>> alloc_contig_range(). __offline_pages() doesn't call undo_isolated_page_range()
>>>>> in the succes case, so it has to be carful to handle restoring pcp->high and batch
>>>>> and unlocking pcp_batch_high_lock.
>>>>
>>>> I was hoping that it would be possible to have this completely hidden
>>>> inside start_isolate_page_range code path.
>>>
>>> I hoped so too, but we can't know the moment when all processes that were in the
>>> critical part of freeing pages to pcplists have moved on (they might have been
>>> rescheduled).
>>> We could change free_unref_page() to disable IRQs sooner, before
>>> free_unref_page_prepare(), or at least the get_pfnblock_migratetype() part. Then
>>> after the single drain, we should be safe, AFAICS?
>>
>> At least moving it before getting the migratetype should not be that severe?
>>
>>> RT guys might not be happy though, but it's much simpler than this patch. I
>>> still like some of the cleanups in 1-4 though tbh :)
>>
>> It would certainly make this patch much simpler. Do you have a prototype
>> lying around?
> 
> Below is the critical part, while writing it I realized that there's also
> free_unref_page_list() where it's more ugly.
> 
> So free_unref_page() simply moves the "determine migratetype" part under
> disabled interrupts. For free_unref_page_list() we optimistically determine them
> without disabling interrupts, and with disabled interrupts we check if zone has
> isolated pageblocks and thus we should not trust that value anymore. That's same
> pattern as free_pcppages_bulk uses.
> 
> But unfortunately it means an extra page_zone() plus a test for each page on the
> list :/

That function is mostly called from mm/vmscan.c AFAIKS.

The fist thing free_unref_page_commit() does is doing page_zone().
That's easy to optimize if needed.

> 
> ----8<----
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index defefed79cfb..57e2a341c95c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3103,18 +3103,21 @@ void mark_free_pages(struct zone *zone)
>  }
>  #endif /* CONFIG_PM */
>  
> -static bool free_unref_page_prepare(struct page *page, unsigned long pfn)
> +static bool free_unref_page_prepare(struct page *page)
>  {
> -	int migratetype;
> -
>  	if (!free_pcp_prepare(page))
>  		return false;
>  
> -	migratetype = get_pfnblock_migratetype(page, pfn);
> -	set_pcppage_migratetype(page, migratetype);
>  	return true;
>  }
>  
> +static inline void free_unref_page_set_migratetype(struct page *page, unsigned long pfn)
> +{
> +	int migratetype	= get_pfnblock_migratetype(page, pfn);
> +
> +	set_pcppage_migratetype(page, migratetype);
> +}
> +
>  static void free_unref_page_commit(struct page *page, unsigned long pfn)
>  {
>  	struct zone *zone = page_zone(page);
> @@ -3156,10 +3159,17 @@ void free_unref_page(struct page *page)
>  	unsigned long flags;
>  	unsigned long pfn = page_to_pfn(page);
>  
> -	if (!free_unref_page_prepare(page, pfn))
> +	if (!free_unref_page_prepare(page))
>  		return;
>  
> +	/*
> +	 * by disabling interrupts before reading pageblock's migratetype,
> +	 * we can guarantee that after changing a pageblock to MIGRATE_ISOLATE
> +	 * and drain_all_pages(), there's nobody who would read the old
> +	 * migratetype and put a page from isoalted pageblock to pcplists
> +	 */
>  	local_irq_save(flags);
> +	free_unref_page_set_migratetype(page, pfn);
>  	free_unref_page_commit(page, pfn);
>  	local_irq_restore(flags);
>  }
> @@ -3176,9 +3186,10 @@ void free_unref_page_list(struct list_head *list)
>  	/* Prepare pages for freeing */
>  	list_for_each_entry_safe(page, next, list, lru) {
>  		pfn = page_to_pfn(page);
> -		if (!free_unref_page_prepare(page, pfn))
> +		if (!free_unref_page_prepare(page))
>  			list_del(&page->lru);
>  		set_page_private(page, pfn);
> +		free_unref_page_set_migratetype(page, pfn);
>  	}
>  
>  	local_irq_save(flags);
> @@ -3187,6 +3198,8 @@ void free_unref_page_list(struct list_head *list)
>  
>  		set_page_private(page, 0);
>  		trace_mm_page_free_batched(page);
> +		if (has_isolate_pageblock(page_zone(page)))
> +			free_unref_page_set_migratetype(page, pfn);
>  		free_unref_page_commit(page, pfn);
>  

FWIW: You can safely add unlikely() for the has_isolate_pageblock(), as
for most other users of that function I was able to spot.

-- 
Thanks,

David / dhildenb

