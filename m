Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992B4C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 05:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70F772075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 05:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="hn29/fUl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgEGFZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 01:25:32 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:35768 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725802AbgEGFZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 01:25:32 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 9B9E82E09D9;
        Thu,  7 May 2020 08:25:29 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id DF4XlFMxI9-PRAib7aj;
        Thu, 07 May 2020 08:25:29 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1588829129; bh=V6kBtjVKjFX6HYVR9qh/1K6i8VRT9wRgPeHFmSUFSc8=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=hn29/fUlwks21CBb1kVzj3Mm8I9elMMDYJuWIQkQRKFx+RF99fO28HAu9pshVuinj
         CZSbqhWxO3LtP9KAou1MT6sQzTXNe4WPsvntGDbhNbalT9vKc+M/VzxvpKioAmDOqN
         K2tBeyXdo1cNJvzCs+kSxMRU4Xq1oTMtGg1GTiR4=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:7313::1:1])
        by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id zgF2fO4rzy-PRXWG57F;
        Thu, 07 May 2020 08:25:27 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH] slub: limit count of partial slabs scanned to gather
 statistics
To:     Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <guro@fb.com>,
        Wen Yang <wenyang@linux.alibaba.com>
References: <158860845968.33385.4165926113074799048.stgit@buzz>
 <09e66344-4d30-9a67-24b8-14a910709157@suse.cz>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <d6e6adc8-eb65-d04f-aace-03121586752a@yandex-team.ru>
Date:   Thu, 7 May 2020 08:25:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <09e66344-4d30-9a67-24b8-14a910709157@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2020 14.56, Vlastimil Babka wrote:
> On 5/4/20 6:07 PM, Konstantin Khlebnikov wrote:
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
> 
> In general yeah, but are you sure about this one? AFAICS this is about pages in
> the n->partial list, where manipulations happen under n->list_lock and shouldn't
> be fast path. It should be feasible to add a counter under the same lock, so it
> wouldn't even need to be atomic?

SLUB allocates objects from prepared per-cpu slabs, they could be subtracted from
count of free object under this lock in advance when slab moved out of this list.

But at freeing path object might belong to any slab, including global partials.

> 
>> Let's simply limit count of scanned slabs and print warning.
>> Limit set in /sys/module/slub/parameters/max_partial_to_count.
>> Default is 10000 which should be enough for most sane cases.
>>
>> Return linear approximation if list of partials is longer than limit.
>> Nobody should notice difference.
>>
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> 
> BTW there was a different patch in that area proposed recently [1] for slabinfo.
> Christopher argued that we can do that for slabinfo but leave /sys stats
> precise. Guess not then?
> 
> [1]
> https://lore.kernel.org/linux-mm/20200222092428.99488-1-wenyang@linux.alibaba.com/
> 
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
> 
