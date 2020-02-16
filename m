Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3EDC7619B
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 04:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B7F20857
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 04:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgBPEP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 23:15:59 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:40752 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726634AbgBPEP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 23:15:59 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04428;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Tq3BIwr_1581826554;
Received: from IT-C02W23QPG8WN.local(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0Tq3BIwr_1581826554)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 16 Feb 2020 12:15:55 +0800
Subject: Re: [PATCH] mm/slub: Detach node lock from counting free objects
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200201031502.92218-1-wenyang@linux.alibaba.com>
 <20200212145247.bf89431272038de53dd9d975@linux-foundation.org>
From:   Wen Yang <wenyang@linux.alibaba.com>
Message-ID: <b42f7daa-4aea-1cf8-5bbb-2cd5d48b4e9a@linux.alibaba.com>
Date:   Sun, 16 Feb 2020 12:15:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200212145247.bf89431272038de53dd9d975@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/2/13 6:52 上午, Andrew Morton wrote:
> On Sat,  1 Feb 2020 11:15:02 +0800 Wen Yang <wenyang@linux.alibaba.com> wrote:
> 
>> The lock, protecting the node partial list, is taken when couting the free
>> objects resident in that list. It introduces locking contention when the
>> page(s) is moved between CPU and node partial lists in allocation path
>> on another CPU. So reading "/proc/slabinfo" can possibily block the slab
>> allocation on another CPU for a while, 200ms in extreme cases. If the
>> slab object is to carry network packet, targeting the far-end disk array,
>> it causes block IO jitter issue.
>>
>> This fixes the block IO jitter issue by caching the total inuse objects in
>> the node in advance. The value is retrieved without taking the node partial
>> list lock on reading "/proc/slabinfo".
>>
>> ...
>>
>> @@ -1768,7 +1774,9 @@ static void free_slab(struct kmem_cache *s, struct page *page)
>>   
>>   static void discard_slab(struct kmem_cache *s, struct page *page)
>>   {
>> -	dec_slabs_node(s, page_to_nid(page), page->objects);
>> +	int inuse = page->objects;
>> +
>> +	dec_slabs_node(s, page_to_nid(page), page->objects, inuse);
> 
> Is this right?  dec_slabs_node(..., page->objects, page->objects)?
> 
> If no, we could simply pass the page* to inc_slabs_node/dec_slabs_node
> and save a function argument.
> 
> If yes then why?
> 

Thanks for your comments.
We are happy to improve this patch based on your suggestions.


When the user reads /proc/slabinfo, in order to obtain the active_objs 
information, the kernel traverses all slabs and executes the following 
code snippet:
static unsigned long count_partial(struct kmem_cache_node *n,
                                         int (*get_count)(struct page *))
{
         unsigned long flags;
         unsigned long x = 0;
         struct page *page;

         spin_lock_irqsave(&n->list_lock, flags);
         list_for_each_entry(page, &n->partial, slab_list)
                 x += get_count(page);
         spin_unlock_irqrestore(&n->list_lock, flags);
         return x;
}

It may cause performance issues.

Christoph suggested "you could cache the value in the userspace 
application? Why is this value read continually?", But reading the 
/proc/slabinfo is initiated by the user program. As a cloud provider, we 
cannot control user behavior. If a user program inadvertently executes 
cat /proc/slabinfo, it may affect other user programs.

As Christoph said: "The count is not needed for any operations. Just for 
the slabinfo output. The value has no operational value for the 
allocator itself. So why use extra logic to track it in potentially 
performance critical paths?"

In this way, could we show the approximate value of active_objs in the 
/proc/slabinfo?

Based on the following information:
In the discard_slab() function, page->inuse is equal to page->total_objects;
In the allocate_slab() function, page->inuse is also equal to 
page->total_objects (with one exception: for kmem_cache_node, page-> 
inuse equals 1);
page->inuse will only change continuously when the obj is constantly 
allocated or released. (This should be the performance critical path 
emphasized by Christoph)

When users query the global slabinfo information, we may use 
total_objects to approximate active_objs.

In this way, the modified patch is as follows:

diff --git a/mm/slub.c b/mm/slub.c
index a0b335d..ef0e6ac 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5900,17 +5900,15 @@ void get_slabinfo(struct kmem_cache *s, struct 
slabinfo *sinfo)
  {
         unsigned long nr_slabs = 0;
         unsigned long nr_objs = 0;
-       unsigned long nr_free = 0;
         int node;
         struct kmem_cache_node *n;

         for_each_kmem_cache_node(s, node, n) {
                 nr_slabs += node_nr_slabs(n);
                 nr_objs += node_nr_objs(n);
-               nr_free += count_partial(n, count_free);
         }

-       sinfo->active_objs = nr_objs - nr_free;
+       sinfo->active_objs = nr_objs;
         sinfo->num_objs = nr_objs;
         sinfo->active_slabs = nr_slabs;
         sinfo->num_slabs = nr_slabs;


In addition, when the user really needs to view the precise active_obj 
value of a slab, he can query this single slab info through an interface 
similar to the following, which avoids traversing all the slabs.

# cat /sys/kernel/slab/kmalloc-512/total_objects
1472 N0=1472
# cat /sys/kernel/slab/kmalloc-512/objects
1311 N0=1311

or
# cat /sys/kernel/slab/kmalloc-8k/total_objects
60 N0=60
# cat /sys/kernel/slab/kmalloc-8k/objects
60 N0=60


Best wishes,
Wen

>>   	free_slab(s, page);
>>   }
>>   
