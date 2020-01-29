Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152CCC35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C0B2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6JkylZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgA2K5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 05:57:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49159 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726067AbgA2K5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 05:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580295469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=RphSGqyTuI0QtWcV9ADVS6c+v3znqgIhNcXMW4Wb8u4=;
        b=X6JkylZ3Be9QmbycSjpoMIDMvmRXvDX1VxWHFO23Jp5if0nlVt6+JUaGyP7TMfLNL6+ANg
        NZe0Cpkn3AShPe7bvqcfnDgneSRQ+vjPG5gA0Ir+C/QK4QXBBffpr4/iyiffSFJSf2NM1i
        Ow7H9gHZgdwmmPyJdaer3M0hmXUgLgw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-E0kvWZG7PFiktut5s8hPGw-1; Wed, 29 Jan 2020 05:57:45 -0500
X-MC-Unique: E0kvWZG7PFiktut5s8hPGw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29DD5800D54;
        Wed, 29 Jan 2020 10:57:43 +0000 (UTC)
Received: from [10.36.118.36] (unknown [10.36.118.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81D2E5D9C5;
        Wed, 29 Jan 2020 10:57:40 +0000 (UTC)
Subject: Re: [PATCH] mm/page_counter: fix various data races
To:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200129105224.4016-1-cai@lca.pw>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <f5105746-2642-472a-e097-c9a427be5556@redhat.com>
Date:   Wed, 29 Jan 2020 11:57:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200129105224.4016-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.01.20 11:52, Qian Cai wrote:
> The commit 3e32cb2e0a12 ("mm: memcontrol: lockless page counters") could
> had memcg->memsw->watermark been accessed concurrently as reported by
> KCSAN,
> 
>  Reported by Kernel Concurrency Sanitizer on:
>  BUG: KCSAN: data-race in page_counter_try_charge / page_counter_try_charge
> 
>  read to 0xffff8fb18c4cd190 of 8 bytes by task 1081 on cpu 59:
>   page_counter_try_charge+0x4d/0x150 mm/page_counter.c:138
>   try_charge+0x131/0xd50 mm/memcontrol.c:2405
>   __memcg_kmem_charge_memcg+0x58/0x140
>   __memcg_kmem_charge+0xcc/0x280
>   __alloc_pages_nodemask+0x1e1/0x450
>   alloc_pages_current+0xa6/0x120
>   pte_alloc_one+0x17/0xd0
>   __pte_alloc+0x3a/0x1f0
>   copy_p4d_range+0xc36/0x1990
>   copy_page_range+0x21d/0x360
>   dup_mmap+0x5f5/0x7a0
>   dup_mm+0xa2/0x240
>   copy_process+0x1b3f/0x3460
>   _do_fork+0xaa/0xa20
>   __x64_sys_clone+0x13b/0x170
>   do_syscall_64+0x91/0xb47
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
>  write to 0xffff8fb18c4cd190 of 8 bytes by task 1153 on cpu 120:
>   page_counter_try_charge+0x5b/0x150 mm/page_counter.c:139
>   try_charge+0x131/0xd50 mm/memcontrol.c:2405
>   mem_cgroup_try_charge+0x159/0x460
>   mem_cgroup_try_charge_delay+0x3d/0xa0
>   wp_page_copy+0x14d/0x930
>   do_wp_page+0x107/0x7b0
>   __handle_mm_fault+0xce6/0xd40
>   handle_mm_fault+0xfc/0x2f0
>   do_page_fault+0x263/0x6f9
>   page_fault+0x34/0x40
> 
> Since watermark could be compared or set to garbage due to load or
> store tearing which would change the code logic, fix it by adding a pair
> of READ_ONCE() and WRITE_ONCE() in those places.
> 
> Fixes: 3e32cb2e0a12 ("mm: memcontrol: lockless page counters")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  mm/page_counter.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page_counter.c b/mm/page_counter.c
> index de31470655f6..a17841150906 100644
> --- a/mm/page_counter.c
> +++ b/mm/page_counter.c
> @@ -82,8 +82,8 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
>  		 * This is indeed racy, but we can live with some
>  		 * inaccuracy in the watermark.
>  		 */
> -		if (new > c->watermark)
> -			c->watermark = new;
> +		if (new > READ_ONCE(c->watermark))
> +			WRITE_ONCE(c->watermark, new);
>  	}
>  }
>  
> @@ -135,8 +135,8 @@ bool page_counter_try_charge(struct page_counter *counter,
>  		 * Just like with failcnt, we can live with some
>  		 * inaccuracy in the watermark.
>  		 */
> -		if (new > c->watermark)
> -			c->watermark = new;
> +		if (new > READ_ONCE(c->watermark))
> +			WRITE_ONCE(c->watermark, new);

So, if this is racy, isn't it a problem that that "new" could suddenly
be < c->watermark (concurrent writer). So you would use the "higher"
watermark.


-- 
Thanks,

David / dhildenb

