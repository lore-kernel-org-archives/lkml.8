Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80364C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6847F20784
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgDVLNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:13:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:55962 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgDVLNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:13:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6DE4AAE6D;
        Wed, 22 Apr 2020 11:13:36 +0000 (UTC)
Subject: Re: ppc64 early slub caches have zero random value
To:     Nicolai Stange <nstange@suse.de>
Cc:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <keescook@chromium.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
References: <20200417165304.GF25468@kitsune.suse.cz>
 <8c93960b-587e-a576-91b8-666f106f8b60@suse.cz> <871rohz0zk.fsf@suse.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <ec2e236a-0b9d-b4dd-10d4-1585efdcc515@suse.cz>
Date:   Wed, 22 Apr 2020 13:13:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <871rohz0zk.fsf@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/20 10:39 AM, Nicolai Stange wrote:
> Hi
> 
> [adding some drivers/char/random folks + LKML to CC]
> 
> Vlastimil Babka <vbabka@suse.cz> writes:
> 
>> On 4/17/20 6:53 PM, Michal Suchánek wrote:
>>> Hello,
>>
>> Hi, thanks for reproducing on latest upstream!
>>
>>> instrumenting the kernel with the following patch
>>> 
>>> ---
>>>  mm/slub.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>> 
>>> diff --git a/mm/slub.c b/mm/slub.c
>>> index d6787bbe0248..d40995d5f8ff 100644
>>> --- a/mm/slub.c
>>> +++ b/mm/slub.c
>>> @@ -3633,6 +3633,7 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
>>>  	s->flags = kmem_cache_flags(s->size, flags, s->name, s->ctor);
>>>  #ifdef CONFIG_SLAB_FREELIST_HARDENED
>>>  	s->random = get_random_long();
>>> +	pr_notice("Creating cache %s with s->random=%ld\n", s->name, s->random);
>>>  #endif
>>>  
>>>  	if (!calculate_sizes(s, -1))
>>> 
>>> I get:
>>> 
>>> [    0.000000] random: get_random_u64 called from kmem_cache_open+0x3c/0x5b0
>> with crng_init=0
>>> [    0.000000] Creating cache kmem_cache_node with s->random=0
>>> [    0.000000] Creating cache kmem_cache with s->random=0
>>> [    0.000000] Creating cache kmalloc-8 with s->random=0
>>> [    0.000000] Creating cache kmalloc-16 with s->random=0
>>> [    0.000000] Creating cache kmalloc-32 with s->random=0
>>> [    0.000000] Creating cache kmalloc-64 with s->random=0
>>> [    0.000000] Creating cache kmalloc-96 with s->random=0
>>> [    0.000000] Creating cache kmalloc-128 with s->random=0
>>> [    0.000000] Creating cache kmalloc-192 with s->random=-682532147323126958
>>> 
>>> The earliest caches created invariably end up with s->random of zero.

I have also realized that the rest of the early created caches is initialized
with albeit non-zero, but in fact deterministically same same sequence values.

>> It seems that reliably it's the first 8 calls get_random_u64(), which sounds
>> more like some off-by-X bug than a genuine lack entropy that would become fixed
>> in the meanwhile?
>>
>>> This is a problem for crash which does not recognize these as randomized
>>> and fails to read them. While this can be addressed in crash is it
>>> intended to create caches with zero random value in the kernel?
>>
>> Definitely not. The question is more likely what guarantees we have with
>> crng_init=0. Probably we can't expect cryptographically strong randomness, but
>> zeroes still do look like a bug to me?
>>
>>> This is broken at least in the 5.4~5.7 range but it is not clear if this
>>> ever worked. All examples of earlier kernels I have at hand use slab mm.
>>> 
>>> Thanks
>>> 
>>> Michal
>>>
> 
> FWIW, I've seen something similar in a slightly different context,
> c.f. [1].
> 
> Basically, the issue is that on anything but x86_64 (and perhaps arm64
> IIRC), arch_get_random_long() is unavailable and thus, get_random_u64()
> falls through to that batched extract_crng() extraction. That is, it
> extracts eight random longs from the chacha20 based RNG at once and
> batches them up for consumption by the current and subsequent
> get_random_u64() invocations. Which is in line with your observation
> that get_random_u64() returned zero exactly eight times in a row.
> 
> The fact that extract_crng() actually extracted eight successive zero
> values surprised me though. But from looking at chacha20_block(), called
> from _extract_crng() with the primary_crng instance's state buffer as
> input, it seems like a zeroed state buffer gets identity transformed and
> that all this fancy shifting and rolling and whatnot in chacha_permute()
> would have no effect at all. So I suppose that the primary_crng's state
> buffer is still zeroed out at that point during boot.

Looks so, thanks for explanation. So there's simply no entropy and the kmalloc-X
caches have deterministic s->random. Zeroes are just more obvious and may fail
e.g. to prevent detection for random corruptions (so we should still fix
those?), while for an attacker anything predictable is bad, and I don't know
what to do about it. If we were to e.g. reseed the early created kmalloc caches
later where crng is fully inited, we would have to basically "stop the world"
and rewrite existing freelists.

> Thanks,
> 
> Nicolai
> 
> [1] https://lkml.kernel.org/r/87d08rbbg9.fsf@suse.de
> 

