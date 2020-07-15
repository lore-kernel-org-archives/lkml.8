Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA4EC433EB
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5246720663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgGOPnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:43:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:45314 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgGOPnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:43:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BBB49AB76;
        Wed, 15 Jul 2020 15:43:11 +0000 (UTC)
Subject: Re: [External] Re: [PATCH v5.4.y, v4.19.y] mm: memcg/slab: fix memory
 leak at non-root kmem_cache destroy
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>
References: <20200707062754.8383-1-songmuchun@bytedance.com>
 <3d06418e-e75c-e7b8-91cd-ba56283045be@suse.cz>
 <CAMZfGtXK9yQOJy7BPnTBzhG4tithRs=9R4O3rDg1Rjz0zUFKnQ@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <4c1bba23-56c5-f69c-28cb-48dd3db30880@suse.cz>
Date:   Wed, 15 Jul 2020 17:43:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtXK9yQOJy7BPnTBzhG4tithRs=9R4O3rDg1Rjz0zUFKnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/20 5:13 PM, Muchun Song wrote:
> On Wed, Jul 15, 2020 at 7:32 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 7/7/20 8:27 AM, Muchun Song wrote:
>> > If the kmem_cache refcount is greater than one, we should not
>> > mark the root kmem_cache as dying. If we mark the root kmem_cache
>> > dying incorrectly, the non-root kmem_cache can never be destroyed.
>> > It resulted in memory leak when memcg was destroyed. We can use the
>> > following steps to reproduce.
>> >
>> >   1) Use kmem_cache_create() to create a new kmem_cache named A.
>> >   2) Coincidentally, the kmem_cache A is an alias for kmem_cache B,
>> >      so the refcount of B is just increased.
>> >   3) Use kmem_cache_destroy() to destroy the kmem_cache A, just
>> >      decrease the B's refcount but mark the B as dying.
>> >   4) Create a new memory cgroup and alloc memory from the kmem_cache
>> >      A. It leads to create a non-root kmem_cache for allocating.
>> >   5) When destroy the memory cgroup created in the step 4), the
>> >      non-root kmem_cache can never be destroyed.
>> >
>> > If we repeat steps 4) and 5), this will cause a lot of memory leak.
>> > So only when refcount reach zero, we mark the root kmem_cache as dying.
>> >
>> > Fixes: 92ee383f6daa ("mm: fix race between kmem_cache destroy, create and deactivate")
>> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>
>> CC Roman, who worked in this area recently.
>>
>> Also why is this marked "[PATCH v5.4.y, v4.19.y]"? Has it been fixed otherwise
>> in 5.5+ ?
> 
> Because the memcg slab/slub is reworked by Roman since v5.8.

That rework is in mmotm, so scheduled for 5.9, AFAIK. If you mean "The new
cgroup slab memory controller" series.

> Therefore, this problem exists in v5.7 and below.

Even 5.7 has a stable series, so no need to list only the LTS's.
To sum up, the patch (once reviewed) should be queued for mainline as usual,
perhaps sent before 5.8 is final, if deemed safe enough, and with added

Cc: <stable@vger.kernel.org>

and the Fixes: tag you provided, the applicable stable versions will pick it.

Vlastimil
