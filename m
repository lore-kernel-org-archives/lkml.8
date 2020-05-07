Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FAFC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 765E72082E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgEGOMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:12:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:45270 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgEGOMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:12:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 59E05ACED;
        Thu,  7 May 2020 14:12:32 +0000 (UTC)
Subject: Re: [PATCH] slub: limit count of partial slabs scanned to gather
 statistics
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <guro@fb.com>,
        Wen Yang <wenyang@linux.alibaba.com>
References: <158860845968.33385.4165926113074799048.stgit@buzz>
 <09e66344-4d30-9a67-24b8-14a910709157@suse.cz>
 <d6e6adc8-eb65-d04f-aace-03121586752a@yandex-team.ru>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <9579b38f-87a2-269a-7598-f857394bc0a9@suse.cz>
Date:   Thu, 7 May 2020 16:12:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d6e6adc8-eb65-d04f-aace-03121586752a@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/20 7:25 AM, Konstantin Khlebnikov wrote:
> On 06/05/2020 14.56, Vlastimil Babka wrote:
>> On 5/4/20 6:07 PM, Konstantin Khlebnikov wrote:
>>> To get exact count of free and used objects slub have to scan list of
>>> partial slabs. This may take at long time. Scanning holds spinlock and
>>> blocks allocations which move partial slabs to per-cpu lists and back.
>>>
>>> Example found in the wild:
>>>
>>> # cat /sys/kernel/slab/dentry/partial
>>> 14478538 N0=7329569 N1=7148969
>>> # time cat /sys/kernel/slab/dentry/objects
>>> 286225471 N0=136967768 N1=149257703
>>>
>>> real	0m1.722s
>>> user	0m0.001s
>>> sys	0m1.721s
>>>
>>> The same problem in slab was addressed in commit f728b0a5d72a ("mm, slab:
>>> faster active and free stats") by adding more kmem cache statistics.
>>> For slub same approach requires atomic op on fast path when object frees.
>> 
>> In general yeah, but are you sure about this one? AFAICS this is about pages in
>> the n->partial list, where manipulations happen under n->list_lock and shouldn't
>> be fast path. It should be feasible to add a counter under the same lock, so it
>> wouldn't even need to be atomic?
> 
> SLUB allocates objects from prepared per-cpu slabs, they could be subtracted from
> count of free object under this lock in advance when slab moved out of this list.
> 
> But at freeing path object might belong to any slab, including global partials.

Right, freeing can indeed modify a global partial without taking the lock.
Nevermind then.
