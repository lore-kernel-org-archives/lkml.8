Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62E5C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A136C2073E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgGCJiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 05:38:02 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:38927 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725786AbgGCJiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:38:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U1ZX3m._1593769072;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0U1ZX3m._1593769072)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Jul 2020 17:37:53 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH 1/2] mm/slub: Introduce two counters for the partial
 objects
To:     Pekka Enberg <penberg@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1593678728-128358-1-git-send-email-xlpang@linux.alibaba.com>
 <CAOJsxLErUqY=eBEaj0G3iRAY-YuyyLnxOnBLTP6SkCjhq1On2g@mail.gmail.com>
From:   xunlei <xlpang@linux.alibaba.com>
Message-ID: <7374a9fd-460b-1a51-1ab4-25170337e5f2@linux.alibaba.com>
Date:   Fri, 3 Jul 2020 17:37:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAOJsxLErUqY=eBEaj0G3iRAY-YuyyLnxOnBLTP6SkCjhq1On2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/2 PM 7:59, Pekka Enberg wrote:
> On Thu, Jul 2, 2020 at 11:32 AM Xunlei Pang <xlpang@linux.alibaba.com> wrote:
>> The node list_lock in count_partial() spend long time iterating
>> in case of large amount of partial page lists, which can cause
>> thunder herd effect to the list_lock contention, e.g. it cause
>> business response-time jitters when accessing "/proc/slabinfo"
>> in our production environments.
> 
> Would you have any numbers to share to quantify this jitter? I have no

We have HSF RT(High-speed Service Framework Response-Time) monitors, the
RT figures fluctuated randomly, then we deployed a tool detecting "irq
off" and "preempt off" to dump the culprit's calltrace, capturing the
list_lock cost up to 100ms with irq off issued by "ss", this also caused
network timeouts.

> objections to this approach, but I think the original design
> deliberately made reading "/proc/slabinfo" more expensive to avoid
> atomic operations in the allocation/deallocation paths. It would be
> good to understand what is the gain of this approach before we switch
> to it. Maybe even run some slab-related benchmark (not sure if there's
> something better than hackbench these days) to see if the overhead of
> this approach shows up.

I thought that before, but most atomic operations are serialized by the
list_lock. Another possible way is to hold list_lock in __slab_free(),
then these two counters can be changed from atomic to long.

I also have no idea what's the standard SLUB benchmark for the
regression test, any specific suggestion?

> 
>> This patch introduces two counters to maintain the actual number
>> of partial objects dynamically instead of iterating the partial
>> page lists with list_lock held.
>>
>> New counters of kmem_cache_node are: pfree_objects, ptotal_objects.
>> The main operations are under list_lock in slow path, its performance
>> impact is minimal.
>>
>> Co-developed-by: Wen Yang <wenyang@linux.alibaba.com>
>> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
>> ---
>>  mm/slab.h |  2 ++
>>  mm/slub.c | 38 +++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 39 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/slab.h b/mm/slab.h
>> index 7e94700..5935749 100644
>> --- a/mm/slab.h
>> +++ b/mm/slab.h
>> @@ -616,6 +616,8 @@ struct kmem_cache_node {
>>  #ifdef CONFIG_SLUB
>>         unsigned long nr_partial;
>>         struct list_head partial;
>> +       atomic_long_t pfree_objects; /* partial free objects */
>> +       atomic_long_t ptotal_objects; /* partial total objects */
> 
> You could rename these to "nr_partial_free_objs" and
> "nr_partial_total_objs" for readability.

Sounds good.

Thanks!

> 
> - Pekka
> 
