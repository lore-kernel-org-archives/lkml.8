Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC66C3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A862146E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgCEMkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 07:40:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:54154 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgCEMkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 07:40:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AEEB9AE8C;
        Thu,  5 Mar 2020 12:40:18 +0000 (UTC)
Subject: Re: [PATCH] mm: slub: reinitialize random sequence cache on slab
 object update
To:     vjitta@codeaurora.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vinmenon@codeaurora.org, kernel-team@android.com,
        Jann Horn <jannh@google.com>
References: <1580379523-32272-1-git-send-email-vjitta@codeaurora.org>
 <1580383064-16536-1-git-send-email-vjitta@codeaurora.org>
 <d3acc069-a5c6-f40a-f95c-b546664bc4ee@suse.cz>
 <da7f86610add1ea78234dfc88178472e@codeaurora.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <23b443b5-1748-28ed-7d8e-654115047b14@suse.cz>
Date:   Thu, 5 Mar 2020 13:40:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <da7f86610add1ea78234dfc88178472e@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/20 6:48 AM, vjitta@codeaurora.org wrote:
> On 2020-02-27 22:23, Vlastimil Babka wrote:
>> 
>> This is even more nasty as it doesn't seem to require that no objects 
>> exist.
>> Also there is no synchronization against concurrent allocations/frees? 
>> Gasp.
> 
> Since, random sequence cache is only used to update the freelist in 
> shuffle_freelist
> which is done only when a new slab is created incase if objects 
> allocations are
> done without a need of new slab creation they will use the existing 
> freelist which
> should be fine as object size doesn't change after order_store() and 
> incase if a new
> slab is created we will get the updated freelist. so in both cases i 
> think it should
> be fine.

I have some doubts. With reinit_cache_random_seq() for SLUB, s->random_seq will
in turn:
cache_random_seq_destroy()
- point to an object that's been kfree'd
- point to NULL
init_cache_random_seq()
  cache_random_seq_create()
  - point to freshly allocated zeroed out object
    freelist_randomize()
    - the object is gradually initialized
- the indices are gradually transformed to page offsets

At any point of this, new slab can be allocated in parallel and observe
s->random_seq in shuffle_freelist(), and it's only ok if it's currently NULL.

Could it be fixed? In the reinit part you would need to
- atomically update a valid s->random_seq to another valid s->random_seq
(perhaps with NULL in between which means some freelist won't be perhaps randomized)
- write barrier
- call calculate_sizes() with updated flags / new order, make sure all the
fields of s-> are updated in a safe order and with write barries (i.e. update
s->oo and s->flags would be probably last, but maybe that's not all) so that
anyone allocating a new slab will always get something valid (maybe that path
would need also new read barriers?)

No, I don't think it's worth the trouble?

