Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7CAC47259
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 05:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3E33206CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 05:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Zt0TKXNZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgEEFqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 01:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgEEFqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 01:46:53 -0400
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27B7C061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 22:46:52 -0700 (PDT)
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id E54E92E152C;
        Tue,  5 May 2020 08:46:47 +0300 (MSK)
Received: from iva8-88b7aa9dc799.qloud-c.yandex.net (iva8-88b7aa9dc799.qloud-c.yandex.net [2a02:6b8:c0c:77a0:0:640:88b7:aa9d])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id J8LnfxHcLB-kkbWnYJJ;
        Tue, 05 May 2020 08:46:47 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1588657607; bh=jvG490rWGc5GqhUhuA0SKysCR0pmXtiZsNTw6qj5OqI=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=Zt0TKXNZozq14mw3t2u5RzNa9xJ/1yboSHfqSOzTozGCAafpIZaPvTjwK4fUHA69c
         z9VmelD979LLg2waFsb/pZ8YPJpv5+jRfY0B1PoYDa6k5lfAa0j6H9AhZdEdqdpdSH
         Uyf554/AAUywEOgBa3c3Hpq84NaqWuGPZOIm1Le4=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:7201::1:2])
        by iva8-88b7aa9dc799.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 4YTxxCJg1p-kkWeViGx;
        Tue, 05 May 2020 08:46:46 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH] slub: limit count of partial slabs scanned to gather
 statistics
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <158860845968.33385.4165926113074799048.stgit@buzz>
 <20200504125656.e3d04b350c807aba8a2a7271@linux-foundation.org>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <fa0a6e28-0b68-c6d0-eb5d-8b180b86230f@yandex-team.ru>
Date:   Tue, 5 May 2020 08:46:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504125656.e3d04b350c807aba8a2a7271@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2020 22.56, Andrew Morton wrote:
> On Mon, 04 May 2020 19:07:39 +0300 Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:
> 
>> To get exact count of free and used objects slub have to scan list of
>> partial slabs. This may take at long time. Scanning holds spinlock and
>> blocks allocations which move partial slabs to per-cpu lists and back.
>>
>> Example found in the wild:
>>
>> # cat /sys/kernel/slab/dentry/partial
>> 14478538 N0=7329569 N1=7148969
>> # time cat /sys/kernel/slab/dentry/objects
>> 286225471 N0=136967768 N1=149257703
>>
>> real	0m1.722s
>> user	0m0.001s
>> sys	0m1.721s
> 
> I assume this could trigger the softlockup detector or even NMI
> watchdog in some situations?

Yes, irqs are disabled here. But loop itself is pretty fast.
It requires terabytes of ram to reach common thresholds for watchdogs.

> 
>> The same problem in slab was addressed in commit f728b0a5d72a ("mm, slab:
>> faster active and free stats") by adding more kmem cache statistics.
>> For slub same approach requires atomic op on fast path when object frees.
>>
>> Let's simply limit count of scanned slabs and print warning.
>> Limit set in /sys/module/slub/parameters/max_partial_to_count.
>> Default is 10000 which should be enough for most sane cases.
>>
>> Return linear approximation if list of partials is longer than limit.
>> Nobody should notice difference.
> 
> That's a pretty sad "solution" :(
> 
> But I guess it's better than nothing at all, unless there are
> alternative ideas?

Running this loop till the end adds more problems than gives information.
Adding new  percpu or atomic counters to fast paths seems redundant even for debugging.

Actually there is no much sense in accurate statistics for count of objects,
when there are millions of them.

Memory consumption here is defined by count and size of slabs.

> 
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -2407,16 +2407,29 @@ static inline unsigned long node_nr_objs(struct kmem_cache_node *n)
>>   #endif /* CONFIG_SLUB_DEBUG */
>>   
>>   #if defined(CONFIG_SLUB_DEBUG) || defined(CONFIG_SYSFS)
>> +
>> +static unsigned long max_partial_to_count __read_mostly = 10000;
>> +module_param(max_partial_to_count, ulong, 0644);
>> +
>>   static unsigned long count_partial(struct kmem_cache_node *n,
>>   					int (*get_count)(struct page *))
>>   {
>> +	unsigned long counted = 0;
>>   	unsigned long flags;
>>   	unsigned long x = 0;
>>   	struct page *page;
>>   
>>   	spin_lock_irqsave(&n->list_lock, flags);
>> -	list_for_each_entry(page, &n->partial, slab_list)
>> +	list_for_each_entry(page, &n->partial, slab_list) {
>>   		x += get_count(page);
>> +
>> +		if (++counted > max_partial_to_count) {
>> +			pr_warn_once("SLUB: too much partial slabs to count all objects, increase max_partial_to_count.\n");
>> +			/* Approximate total count of objects */
>> +			x = mult_frac(x, n->nr_partial, counted);
>> +			break;
>> +		}
>> +	}
>>   	spin_unlock_irqrestore(&n->list_lock, flags);
>>   	return x;
>>   }
