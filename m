Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F305C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E2320714
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732620AbgDANI0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 09:08:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:39374 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732296AbgDANIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 09:08:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 33325AD4F;
        Wed,  1 Apr 2020 13:08:23 +0000 (UTC)
From:   Nicolai Stange <nstange@suse.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     tytso@mit.edu, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2] random: always use batched entropy for get_random_u{32,64}
References: <CAHmME9o+Nh0=0QBimOJLXpLitQ9p6rsAut+Zvb4A1-iEjGn3jw@mail.gmail.com>
        <20200221201037.30231-1-Jason@zx2c4.com>
Date:   Wed, 01 Apr 2020 15:08:22 +0200
In-Reply-To: <20200221201037.30231-1-Jason@zx2c4.com> (Jason A. Donenfeld's
        message of "Fri, 21 Feb 2020 21:10:37 +0100")
Message-ID: <87d08rbbg9.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:

> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index c7f9584de2c8..a6b77a850ddd 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -2149,11 +2149,11 @@ struct batched_entropy {
>  
>  /*
>   * Get a random word for internal kernel use only. The quality of the random
> - * number is either as good as RDRAND or as good as /dev/urandom, with the
> - * goal of being quite fast and not depleting entropy. In order to ensure
> + * number is good as /dev/urandom, but there is no backtrack protection, with
> + * the goal of being quite fast and not depleting entropy. In order to ensure
>   * that the randomness provided by this function is okay, the function
> - * wait_for_random_bytes() should be called and return 0 at least once
> - * at any point prior.
> + * wait_for_random_bytes() should be called and return 0 at least once at any
> + * point prior.
>   */
>  static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u64) = {
>  	.batch_lock	= __SPIN_LOCK_UNLOCKED(batched_entropy_u64.lock),
> @@ -2166,15 +2166,6 @@ u64 get_random_u64(void)
>  	struct batched_entropy *batch;
>  	static void *previous;
>  
> -#if BITS_PER_LONG == 64
> -	if (arch_get_random_long((unsigned long *)&ret))
> -		return ret;
> -#else
> -	if (arch_get_random_long((unsigned long *)&ret) &&
> -	    arch_get_random_long((unsigned long *)&ret + 1))
> -	    return ret;
> -#endif
> -
>  	warn_unseeded_randomness(&previous);

I don't know if this has been reported elsewhere already, but this
warning triggers on x86_64 with CONFIG_SLAB_FREELIST_HARDENED and
CONFIG_SLAB_FREELIST_RANDOM during early boot now:

  [    0.079775] random: random: get_random_u64 called from __kmem_cache_create+0x40/0x550 with crng_init=0

Strictly speaking, this isn't really a problem with this patch -- other
archs without arch_get_random_long() support (like e.g. ppc64le) have
showed this behaviour before.

FWIW, I added a dump_stack() to warn_unseeded_randomness() in order to
capture the resp. call paths of the offending get_random_u64/u32()
callers, i.e. those invoked before rand_initialize(). Those are

  - __kmem_cache_create() and
     init_cache_random_seq()->cache_random_seq_create(), called
     indirectly quite a number of times from
     - kmem_cache_init()
     - kmem_cache_init()->create_kmalloc_caches()
     - vmalloc_init()->kmem_cache_create()
     - sched_init()->kmem_cache_create()
     - radix_tree_init()->kmem_cache_create()
     - workqueue_init_early()->kmem_cache_create()
     - trace_event_init()->kmem_cache_create()

  - __kmalloc()/kmem_cache_alloc()/kmem_cache_alloc_node()/kmem_cache_alloc_trace()
      ->__slab_alloc->___slab_alloc()->new_slab()
    called indirectly through
    - vmalloc_init()
    - workqueue_init_early()
    - trace_event_init()
    - early_irq_init()->alloc_desc()

Two possible ways to work around this came to my mind:
1.) Either reintroduce arch_get_random_long() to get_random_u64/u32(),
    but only for the case that crng_init <= 1.
2.) Or introduce something like
      arch_seed_primary_crng_early()
    to be called early from start_kernel().
    For x86_64 this could be implemented by filling the crng state with
    RDRAND data whereas other archs would fall back to get_cycles(),
    something jitterentropish-like or whatever.

What do you think?

Thanks,

Nicolai


>  
>  	batch = raw_cpu_ptr(&batched_entropy_u64);
> @@ -2199,9 +2190,6 @@ u32 get_random_u32(void)
>  	struct batched_entropy *batch;
>  	static void *previous;
>  
> -	if (arch_get_random_int(&ret))
> -		return ret;
> -
>  	warn_unseeded_randomness(&previous);
>  
>  	batch = raw_cpu_ptr(&batched_entropy_u32);

-- 
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
(HRB 36809, AG Nürnberg), GF: Felix Imendörffer
