Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1374C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 21:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D3B124697
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 21:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKCgtsN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgFTVIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 17:08:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25096 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728847AbgFTVH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 17:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592687274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ElsSujjnbSCF3teuh6MgB0z7RKk6AGLjsvNWSDWa9zk=;
        b=dKCgtsN7LQd6n+dmKTIzyH8jGzZLEIRBdTUh24UtH7mrNm3K2bf1WvkMCd0ZTE5+FKgKTV
        /fwxG81ECZWoS4rymdurfVKFNitYTgUpWejzyvMcdmnVByD/U6h+tuIOTACiPTaap6BQgO
        NrKLOFCmO7bEnyjR/StIY0kr5wOeXcw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-2amfQcsDPBGdYCy889iMsA-1; Sat, 20 Jun 2020 17:07:51 -0400
X-MC-Unique: 2amfQcsDPBGdYCy889iMsA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83D73835B40;
        Sat, 20 Jun 2020 21:07:47 +0000 (UTC)
Received: from llong.remote.csb (ovpn-112-81.rdu2.redhat.com [10.10.112.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B5555BAE0;
        Sat, 20 Jun 2020 21:07:45 +0000 (UTC)
Subject: Re: [PATCH] mm, slab: Fix sign conversion problem in
 memcg_uncharge_slab()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200620184719.10994-1-longman@redhat.com>
 <20200620140018.a305aebd01b2cf4226547944@linux-foundation.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <56e11b90-1b25-deb1-55d0-ba17371583ee@redhat.com>
Date:   Sat, 20 Jun 2020 17:07:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200620140018.a305aebd01b2cf4226547944@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/20 5:00 PM, Andrew Morton wrote:
> On Sat, 20 Jun 2020 14:47:19 -0400 Waiman Long <longman@redhat.com> wrote:
>
>> It was found that running the LTP test on a PowerPC system could produce
>> erroneous values in /proc/meminfo, like:
>>
>>    MemTotal:       531915072 kB
>>    MemFree:        507962176 kB
>>    MemAvailable:   1100020596352 kB
>>
>> Using bisection, the problem is tracked down to commit 9c315e4d7d8c
>> ("mm: memcg/slab: cache page number in memcg_(un)charge_slab()").
>>
>> In memcg_uncharge_slab() with a "int order" argument:
>>
>>    unsigned int nr_pages = 1 << order;
>>      :
>>    mod_lruvec_state(lruvec, cache_vmstat_idx(s), -nr_pages);
>>
>> The mod_lruvec_state() function will eventually call the
>> __mod_zone_page_state() which accepts a long argument.  Depending on
>> the compiler and how inlining is done, "-nr_pages" may be treated as
>> a negative number or a very large positive number. Apparently, it was
>> treated as a large positive number in that PowerPC system leading to
>> incorrect stat counts. This problem hasn't been seen in x86-64 yet,
>> perhaps the gcc compiler there has some slight difference in behavior.
>>
>> It is fixed by making nr_pages a signed value. For consistency, a
>> similar change is applied to memcg_charge_slab() as well.
> This is somewhat disturbing.
>
>> --- a/mm/slab.h
>> +++ b/mm/slab.h
>> @@ -348,7 +348,7 @@ static __always_inline int memcg_charge_slab(struct page *page,
>>   					     gfp_t gfp, int order,
>>   					     struct kmem_cache *s)
>>   {
>> -	unsigned int nr_pages = 1 << order;
>> +	int nr_pages = 1 << order;
>>   	struct mem_cgroup *memcg;
>>   	struct lruvec *lruvec;
>>   	int ret;
>> @@ -388,7 +388,7 @@ static __always_inline int memcg_charge_slab(struct page *page,
>>   static __always_inline void memcg_uncharge_slab(struct page *page, int order,
>>   						struct kmem_cache *s)
>>   {
>> -	unsigned int nr_pages = 1 << order;
>> +	int nr_pages = 1 << order;
>>   	struct mem_cgroup *memcg;
>>   	struct lruvec *lruvec;
>>   
> I grabbed the patch, but Roman's "mm: memcg/slab: charge individual
> slab objects instead of pages"
> (http://lkml.kernel.org/r/20200608230654.828134-10-guro@fb.com) deletes
> both these functions.
>
> It replaces the offending code with, afaict,
>
>
> static inline void memcg_slab_free_hook(struct kmem_cache *s, struct page *page,
> 					void *p)
> {
> 	struct obj_cgroup *objcg;
> 	unsigned int off;
>
> 	if (!memcg_kmem_enabled() || is_root_cache(s))
> 		return;
>
> 	off = obj_to_index(s, page, p);
> 	objcg = page_obj_cgroups(page)[off];
> 	page_obj_cgroups(page)[off] = NULL;
>
> 	obj_cgroup_uncharge(objcg, obj_full_size(s));
> 	mod_objcg_state(objcg, page_pgdat(page), cache_vmstat_idx(s),
>>>> 			-obj_full_size(s));
> 	obj_cgroup_put(objcg);
> }
>
> -obj_full_size() returns size_t so I guess that's OK.

size_t is unsigned long. So there is no sign extension. It should be 
fine then.


>
>
>
> Also
>
>
> static __always_inline void uncharge_slab_page(struct page *page, int order,
> 					       struct kmem_cache *s)
> {
> #ifdef CONFIG_MEMCG_KMEM
> 	if (memcg_kmem_enabled() && !is_root_cache(s)) {
> 		memcg_free_page_obj_cgroups(page);
> 		percpu_ref_put_many(&s->memcg_params.refcnt, 1 << order);
> 	}
> #endif
> 	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
>>>> 			    -(PAGE_SIZE << order));
> }
>
> PAGE_SIZE is unsigned long so I guess that's OK as well.
>
>
> Still, perhaps both could be improved.  Negating an unsigned scalar is
> a pretty ugly thing to do.
>
> Am I wrong in thinking that all those mod_foo() functions need careful
> review?
>
Yes, we may need to review code that has sign extension to make sure 
such an error is not happening again.

BTW, is it possible to place my patch before Roman's patch and modifying 
his patch accordingly? This patch needs to be ported to 5.7-stable.

Cheers,
Longman

