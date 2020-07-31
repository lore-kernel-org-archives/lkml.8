Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193ABC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 02:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBE81208A9
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 02:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbgGaCwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 22:52:18 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:51926 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731124AbgGaCwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 22:52:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U4Gz0ZT_1596163932;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0U4Gz0ZT_1596163932)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 31 Jul 2020 10:52:13 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH 1/2] mm/slub: Introduce two counters for the partial
 objects
To:     Christopher Lameter <cl@linux.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1593678728-128358-1-git-send-email-xlpang@linux.alibaba.com>
 <alpine.DEB.2.22.394.2007070656120.1587@www.lameter.com>
From:   xunlei <xlpang@linux.alibaba.com>
Message-ID: <cf0fa2f4-86c3-655b-3a54-353bf8c1635b@linux.alibaba.com>
Date:   Fri, 31 Jul 2020 10:52:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2007070656120.1587@www.lameter.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/7 ÏÂÎç2:59, Christopher Lameter wrote:
> On Thu, 2 Jul 2020, Xunlei Pang wrote:
> 
>> This patch introduces two counters to maintain the actual number
>> of partial objects dynamically instead of iterating the partial
>> page lists with list_lock held.
>>
>> New counters of kmem_cache_node are: pfree_objects, ptotal_objects.
>> The main operations are under list_lock in slow path, its performance
>> impact is minimal.
> 
> 
> If at all then these counters need to be under CONFIG_SLUB_DEBUG.
> 
>> --- a/mm/slab.h
>> +++ b/mm/slab.h
>> @@ -616,6 +616,8 @@ struct kmem_cache_node {
>>  #ifdef CONFIG_SLUB
>>  	unsigned long nr_partial;
>>  	struct list_head partial;
>> +	atomic_long_t pfree_objects; /* partial free objects */
>> +	atomic_long_t ptotal_objects; /* partial total objects */
> 
> Please in the CONFIG_SLUB_DEBUG. Without CONFIG_SLUB_DEBUG we need to
> build with minimal memory footprint.

Thanks for the comments.

show_slab_objects() also calls it with CONFIG_SYSFS:
    if (flags & SO_PARTIAL) {
        struct kmem_cache_node *n;

        for_each_kmem_cache_node(s, node, n) {
            if (flags & SO_TOTAL)
                x = count_partial(n, count_total);
            else if (flags & SO_OBJECTS)
                x = count_partial(n, count_inuse);
            else
                x = n->nr_partial;
            total += x;
            nodes[node] += x;
        }
    }

I'm not sure if it's due to some historical reason, it works without
CONFIG_SLUB_DEBUG.

> 
>>  #ifdef CONFIG_SLUB_DEBUG
>>  	atomic_long_t nr_slabs;
>>  	atomic_long_t total_objects;
>> diff --git a/mm/slub.c b/mm/slub.c
> 
> 
> 
> Also this looks to be quite heavy on the cache and on execution time. Note
> that the list_lock could be taken frequently in the performance sensitive
> case of freeing an object that is not in the partial lists.
> 

Yes, the concurrent __slab_free() has potential lock/atomic contention,
how about using percpu variable for partial free like below?
  static inline void
   __update_partial_free(struct kmem_cache_node *n, long delta)
  {
      atomic_long_add(delta, this_cpu_ptr(n->partial_free_objs));
  }

-Xunlei
