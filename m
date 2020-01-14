Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51633C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 20:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C32C24658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 20:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4bLiApX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgANUUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 15:20:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40643 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726839AbgANUUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 15:20:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579033216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=MhMlbBIaWlMMKOQuvxy0cVU4OMKORfPbFJr1sfcbtEg=;
        b=A4bLiApXbMwc4ML9FQWYSto1MwpGifgAtN3acTFNy3SV0LCT/BRJtTx3pw6CFxeESrxxNn
        0n6OqOkTn+Y1a28rpSvuuABcg9G+ht3GXjCB7Hd0PCEd6nHxE9E011r2nbjyr8OkQM4RJj
        dyyJNpr1br8BeRYUWw92JvDrocJX9DU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-blNuwuAXMT-nTxg8za3kiA-1; Tue, 14 Jan 2020 15:20:13 -0500
X-MC-Unique: blNuwuAXMT-nTxg8za3kiA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FD6A107ACC4;
        Tue, 14 Jan 2020 20:20:11 +0000 (UTC)
Received: from [10.36.118.60] (unknown [10.36.118.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4397E10372C0;
        Tue, 14 Jan 2020 20:20:09 +0000 (UTC)
Subject: Re: [PATCH -next] mm/hotplug: silence a lockdep splat with printk()
To:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org
Cc:     mhocko@kernel.org, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200114201114.14696-1-cai@lca.pw>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <6d9d2923-a44c-60fb-5caa-e6228cb8aaf5@redhat.com>
Date:   Tue, 14 Jan 2020 21:20:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200114201114.14696-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.01.20 21:11, Qian Cai wrote:
> Similar to the recent commit [1] merged into the random and -next trees,
> it is not a good idea to call printk() with zone->lock held. The
> standard fix is to use printk_deferred() in those places, but memory
> offline will call dump_page() which need to defer after the lock. While
> at it, remove a similar but unnecessary debug printk() as well.
> 
> [1] https://lore.kernel.org/lkml/1573679785-21068-1-git-send-email-cai@lca.pw/
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  include/linux/page-isolation.h |  2 +-
>  mm/memory_hotplug.c            |  2 +-
>  mm/page_alloc.c                | 12 +++++-------
>  mm/page_isolation.c            | 10 +++++++++-
>  4 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
> index 148e65a9c606..5d8ba078006f 100644
> --- a/include/linux/page-isolation.h
> +++ b/include/linux/page-isolation.h
> @@ -34,7 +34,7 @@ static inline bool is_migrate_isolate(int migratetype)
>  #define REPORT_FAILURE	0x2
>  
>  bool has_unmovable_pages(struct zone *zone, struct page *page, int migratetype,
> -			 int flags);
> +			 int flags, char *dump);
>  void set_pageblock_migratetype(struct page *page, int migratetype);
>  int move_freepages_block(struct zone *zone, struct page *page,
>  				int migratetype, int *num_movable);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 7a6de9b0dcab..f10928538fa3 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1149,7 +1149,7 @@ static bool is_pageblock_removable_nolock(unsigned long pfn)
>  		return false;
>  
>  	return !has_unmovable_pages(zone, page, MIGRATE_MOVABLE,
> -				    MEMORY_OFFLINE);
> +				    MEMORY_OFFLINE, NULL);
>  }
>  
>  /* Checks if this range of memory is likely to be hot-removable. */
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e56cd1f33242..b6bec3925e80 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8204,7 +8204,7 @@ void *__init alloc_large_system_hash(const char *tablename,
>   * race condition. So you can't expect this function should be exact.
>   */
>  bool has_unmovable_pages(struct zone *zone, struct page *page, int migratetype,
> -			 int flags)
> +			 int flags, char *dump)
>  {
>  	unsigned long iter = 0;
>  	unsigned long pfn = page_to_pfn(page);
> @@ -8305,8 +8305,10 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int migratetype,
>  	return false;
>  unmovable:
>  	WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
> -	if (flags & REPORT_FAILURE)
> -		dump_page(pfn_to_page(pfn + iter), reason);
> +	if (flags & REPORT_FAILURE) {
> +		page = pfn_to_page(pfn + iter);
> +		strscpy(dump, reason, 64);
> +	}
>  	return true;
>  }
>  
> @@ -8711,10 +8713,6 @@ __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
>  		BUG_ON(!PageBuddy(page));
>  		order = page_order(page);
>  		offlined_pages += 1 << order;
> -#ifdef CONFIG_DEBUG_VM
> -		pr_info("remove from free list %lx %d %lx\n",
> -			pfn, 1 << order, end_pfn);
> -#endif

ack to getting rid of this.

Regarding the other stuff, I remember Michal had an opinion about the
previous approach, so it's best if he comments.

-- 
Thanks,

David / dhildenb

