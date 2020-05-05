Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F81C47256
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 06:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41C88206E6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 06:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="QpdrQKhf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgEEGUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 02:20:31 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:52770 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725320AbgEEGUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 02:20:31 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id A6D5B2E146B;
        Tue,  5 May 2020 09:20:24 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id jRyCxRebX9-KNbW608l;
        Tue, 05 May 2020 09:20:24 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1588659624; bh=UHG2ZtUAk5L53n9yzMVjWb3inH3CddC60PlPMECd9bY=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=QpdrQKhf49jn0PcjbsTwKeUhLXiisTH2LZLPEkz3WN3WInWIRIwj1Cz/IMcP/vI6g
         PWFO5HplqMQ7b2KkI1+bvL8iheJOoBWAggN0GEAcpAq3zLtHeBaL7rwapC0Lzu3KMc
         GpnHCUtXbmow9G/vBQp2ahpOPZYKxPmJsWCFcvAc=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:7201::1:2])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id h9MkKKOG5c-KMWiAFd5;
        Tue, 05 May 2020 09:20:23 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH] slub: limit count of partial slabs scanned to gather
 statistics
To:     David Rientjes <rientjes@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <158860845968.33385.4165926113074799048.stgit@buzz>
 <alpine.DEB.2.22.394.2005041411020.224786@chino.kir.corp.google.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <57ff4c05-bf97-b546-44a3-163cfbe7cad4@yandex-team.ru>
Date:   Tue, 5 May 2020 09:20:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2005041411020.224786@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2020 00.19, David Rientjes wrote:
> On Mon, 4 May 2020, Konstantin Khlebnikov wrote:
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
>>
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
>>
> 
> Hi Konstantin,
> 
> Do you only exhibit this on slub for SO_ALL|SO_OBJECTS?  I notice the
> timing in the changelog is only looking at "objects" and not "partial".

"partial" is a count of partial slabs which simply sums per-numa counters.
Affected only "objects" and "objects_partial" which walk the list.

> 
> If so, it seems this is also a problem for get_slabinfo() since it also
> uses the count_free() callback for count_partial().

Yep, /proc/slabinfo also affected.

Actually it's more affected than sysfs - it walks all cgroups while sysfs shows only root.

> 
> Concern would be that the kernel has now drastically changed a statistic
> that it exports to userspace.  There was some discussion about this back
> in 2016[*] and one idea was that slabinfo would truncate its scanning and
> append a '+' to the end of the value to indicate it exceeds the max, i.e.
> 10000+.  I think that '+' actually caused the problem itself for userspace
> processes.

Yep, "+" will break everything for sure.
I thought about returning "-1" or INT_MAX without counting,
but approximation gives almost correct result without breaking anything.

Each partial slab has at least one used and free object thus approximated
result will be somewhere between nr_partial_slabs and nr_partial_objects.

> 
> I think the patch is too far reaching, however, since it impacts all
> count_partial() counting and not only for the case cited in the changelog.
> Are there examples for things other than the count_free() callback?

Nope, this is just a statistics for used/free objects.
Total count of objects and slabs are counted precisely.

> 
>   [*] https://lore.kernel.org/patchwork/patch/708427/
> 
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> ---
>>   mm/slub.c |   15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 9bf44955c4f1..86a366f7acb6 100644
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
>>
>>
