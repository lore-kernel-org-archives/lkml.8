Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553E6C35672
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 06:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6DF20707
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 06:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgBVGzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 01:55:44 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:51352 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727080AbgBVGzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 01:55:44 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TqaCEln_1582354539;
Received: from IT-C02W23QPG8WN.local(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0TqaCEln_1582354539)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 22 Feb 2020 14:55:40 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
Subject: Re: [PATCH] mm/slub: Detach node lock from counting free objects
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200201031502.92218-1-wenyang@linux.alibaba.com>
 <20200212145247.bf89431272038de53dd9d975@linux-foundation.org>
 <b42f7daa-4aea-1cf8-5bbb-2cd5d48b4e9a@linux.alibaba.com>
 <20200218205312.GA3156@carbon>
 <cb36f3e5-c01c-a99d-9230-af52f806e227@linux.alibaba.com>
 <20200220154036.GA191388@carbon.dhcp.thefacebook.com>
Message-ID: <98c84f23-0636-a877-a96d-d6e58d540aa4@linux.alibaba.com>
Date:   Sat, 22 Feb 2020 14:55:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200220154036.GA191388@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/2/20 11:40 下午, Roman Gushchin wrote:
> On Thu, Feb 20, 2020 at 09:53:26PM +0800, Wen Yang wrote:
>>
>>
>> On 2020/2/19 4:53 上午, Roman Gushchin wrote:
>>> On Sun, Feb 16, 2020 at 12:15:54PM +0800, Wen Yang wrote:
>>>>
>>>>
>>>> On 2020/2/13 6:52 上午, Andrew Morton wrote:
>>>>> On Sat,  1 Feb 2020 11:15:02 +0800 Wen Yang <wenyang@linux.alibaba.com> wrote:
>>>>>
>>>>>> The lock, protecting the node partial list, is taken when couting the free
>>>>>> objects resident in that list. It introduces locking contention when the
>>>>>> page(s) is moved between CPU and node partial lists in allocation path
>>>>>> on another CPU. So reading "/proc/slabinfo" can possibily block the slab
>>>>>> allocation on another CPU for a while, 200ms in extreme cases. If the
>>>>>> slab object is to carry network packet, targeting the far-end disk array,
>>>>>> it causes block IO jitter issue.
>>>>>>
>>>>>> This fixes the block IO jitter issue by caching the total inuse objects in
>>>>>> the node in advance. The value is retrieved without taking the node partial
>>>>>> list lock on reading "/proc/slabinfo".
>>>>>>
>>>>>> ...
>>>>>>
>>>>>> @@ -1768,7 +1774,9 @@ static void free_slab(struct kmem_cache *s, struct page *page)
>>>>>>     static void discard_slab(struct kmem_cache *s, struct page *page)
>>>>>>     {
>>>>>> -	dec_slabs_node(s, page_to_nid(page), page->objects);
>>>>>> +	int inuse = page->objects;
>>>>>> +
>>>>>> +	dec_slabs_node(s, page_to_nid(page), page->objects, inuse);
>>>>>
>>>>> Is this right?  dec_slabs_node(..., page->objects, page->objects)?
>>>>>
>>>>> If no, we could simply pass the page* to inc_slabs_node/dec_slabs_node
>>>>> and save a function argument.
>>>>>
>>>>> If yes then why?
>>>>>
>>>>
>>>> Thanks for your comments.
>>>> We are happy to improve this patch based on your suggestions.
>>>>
>>>>
>>>> When the user reads /proc/slabinfo, in order to obtain the active_objs
>>>> information, the kernel traverses all slabs and executes the following code
>>>> snippet:
>>>> static unsigned long count_partial(struct kmem_cache_node *n,
>>>>                                           int (*get_count)(struct page *))
>>>> {
>>>>           unsigned long flags;
>>>>           unsigned long x = 0;
>>>>           struct page *page;
>>>>
>>>>           spin_lock_irqsave(&n->list_lock, flags);
>>>>           list_for_each_entry(page, &n->partial, slab_list)
>>>>                   x += get_count(page);
>>>>           spin_unlock_irqrestore(&n->list_lock, flags);
>>>>           return x;
>>>> }
>>>>
>>>> It may cause performance issues.
>>>>
>>>> Christoph suggested "you could cache the value in the userspace application?
>>>> Why is this value read continually?", But reading the /proc/slabinfo is
>>>> initiated by the user program. As a cloud provider, we cannot control user
>>>> behavior. If a user program inadvertently executes cat /proc/slabinfo, it
>>>> may affect other user programs.
>>>>
>>>> As Christoph said: "The count is not needed for any operations. Just for the
>>>> slabinfo output. The value has no operational value for the allocator
>>>> itself. So why use extra logic to track it in potentially performance
>>>> critical paths?"
>>>>
>>>> In this way, could we show the approximate value of active_objs in the
>>>> /proc/slabinfo?
>>>>
>>>> Based on the following information:
>>>> In the discard_slab() function, page->inuse is equal to page->total_objects;
>>>> In the allocate_slab() function, page->inuse is also equal to
>>>> page->total_objects (with one exception: for kmem_cache_node, page-> inuse
>>>> equals 1);
>>>> page->inuse will only change continuously when the obj is constantly
>>>> allocated or released. (This should be the performance critical path
>>>> emphasized by Christoph)
>>>>
>>>> When users query the global slabinfo information, we may use total_objects
>>>> to approximate active_objs.
>>>
>>> Well, from one point of view, it makes no sense, because the ratio between
>>> these two numbers is very meaningful: it's the slab utilization rate.
>>>
>>> On the other side, with enabled per-cpu partial lists active_objs has
>>> nothing to do with the reality anyway, so I agree with you, calling
>>> count_partial() is almost useless.
>>>
>>> That said, I wonder if the right thing to do is something like the patch below?
>>>
>>> Thanks!
>>>
>>> Roman
>>>
>>> --
>>>
>>> diff --git a/mm/slub.c b/mm/slub.c
>>> index 1d644143f93e..ba0505e75ecc 100644
>>> --- a/mm/slub.c
>>> +++ b/mm/slub.c
>>> @@ -2411,14 +2411,16 @@ static inline unsigned long node_nr_objs(struct kmem_cache_node *n)
>>>    static unsigned long count_partial(struct kmem_cache_node *n,
>>>                                           int (*get_count)(struct page *))
>>>    {
>>> -       unsigned long flags;
>>>           unsigned long x = 0;
>>> +#ifdef CONFIG_SLUB_CPU_PARTIAL
>>> +       unsigned long flags;
>>>           struct page *page;
>>>           spin_lock_irqsave(&n->list_lock, flags);
>>>           list_for_each_entry(page, &n->partial, slab_list)
>>>                   x += get_count(page);
>>>           spin_unlock_irqrestore(&n->list_lock, flags);
>>> +#endif
>>>           return x;
>>>    }
>>>    #endif /* CONFIG_SLUB_DEBUG || CONFIG_SYSFS */
>>>
>>
>> Hi Roman,
>>
>> Thanks for your comments.
>>
>> In the server scenario, SLUB_CPU_PARTIAL is turned on by default, and can
>> improve the performance of the cloud server, as follows:
> 
> Hello, Wen!
> 
> That's exactly my point: if CONFIG_SLUB_CPU_PARTIAL is on, count_partial() is useless
> anyway because the returned number is far from the reality. So if we define
> active_objects == total_objects, as you basically suggest, we do not introduce any
> regression. Actually I think it's even preferable to show the unrealistic uniform 100%
> slab utilization rather than some very high but incorrect value.
> 
> And on real-time systems uncontrolled readings of /proc/slabinfo is less
> of a concern, I hope.
> 
> Thank you!
> 

Great！
We only need to correct a typo to achieve this goal, as follows:
Change #ifdef CONFIG_SLUB_CPU_PARTIAL to #ifndef CONFIG_SLUB_CPU_PARTIAL

We will continue testing and send the modified patch soon.

Thank you very much.


