Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D505C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 179D1208B3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="19xIPU0M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aHunRBTH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgHML6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 07:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgHMLzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 07:55:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEB9C061383
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 04:49:20 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597319290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZlgM8Obqrq40lXXZU4JOaZIlny7V1P2EsiDmKMcB++g=;
        b=19xIPU0MprratrQ8DWWKKPXdeF1YeDe/0fGmScmgOSPwt0ygGapx9nJcuiYZjZeeQ3u03v
        fCBh9RQEd9XQrAmxLF7AYmb9pxFaG/UjkfSeslA+UEj0aPzMoRFhaN/01fpeW+WRKKQ0ZK
        wdhNisGNFEJsNMTkJQYZSClR1XOiRFz8mPB47b3QioYJR8Xq41mN/ZYUrs+jxRj15YgibI
        DsRCR0YsA30xHD4mTpRlxwnV1Yv4mombKxHVOFtfO316Yor1i0cQDiKvARQiJ/ZbOCPrQj
        /yQebkqX3gC6BiugKhKvJxNOKi5U0TLxPuvDuZ/U6Ul2YtwCxulF/ZDC3U6YBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597319290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZlgM8Obqrq40lXXZU4JOaZIlny7V1P2EsiDmKMcB++g=;
        b=aHunRBTHEwQleDYARlcD8oyakuVrUCLzsIwEZGv3n4EZ/4ZQapihc74hfKAQVmrDAjgeuk
        OyTARcn3Ve9ep6DA==
To:     Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: Re: [PATCH 1/5] timer: kasan: record and print timer stack
In-Reply-To: <20200810072313.529-1-walter-zh.wu@mediatek.com>
References: <20200810072313.529-1-walter-zh.wu@mediatek.com>
Date:   Thu, 13 Aug 2020 13:48:10 +0200
Message-ID: <87d03ulqbp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Walter,

Walter Wu <walter-zh.wu@mediatek.com> writes:
> This patch records the last two timer queueing stacks and prints

"This patch" is useless information as we already know from the subject
line that this is a patch.

git grep 'This patch' Documentation/process/

> up to 2 timer stacks in KASAN report. It is useful for programmers
> to solve use-after-free or double-free memory timer issues.
>
> When timer_setup() or timer_setup_on_stack() is called, then it
> prepares to use this timer and sets timer callback, we store
> this call stack in order to print it in KASAN report.

we store nothing. Don't impersonate code please.

Also please structure the changelog in a way that it's easy to
understand what this is about instead of telling first what the patch
does and then some half baken information why this is useful followed by
more information about what it does.

Something like this:

  For analysing use after free or double free of objects it is helpful
  to preserve usage history which potentially gives a hint about the
  affected code.

  For timers it has turned out to be useful to record the stack trace
  of the timer init call. <ADD technical explanation why this is useful>
 
  Record the most recent two timer init calls in KASAN which are printed
  on failure in the KASAN report.

See, this gives a clear context, an explanation why it is useful and a
high level description of what it does. The details are in the patch
ifself and do not have to be epxlained in the changelog.

For the technical explanation which you need to add, you really need to
tell what's the advantage or additional coverage vs. existing debug
facilities like debugobjects. Just claiming that it's useful does not
make an argument.

The UAF problem with timers is nasty because if you free an active timer
then either the softirq which expires the timer will corrupt potentially
reused memory or the reuse will corrupt the linked list which makes the
softirq or some unrelated code which adds/removes a different timer
explode in undebuggable ways. debugobject prevents that because it
tracks per timer state and invokes the fixup function which keeps the
system alive and also tells you exactly where the free of the active
object happens which is the really interesting place to look at. The
init function is pretty uninteresting in that case because you really
want to know where the freeing of the active object happens.

So if KASAN detects UAF in the timer softirq then the init trace is not
giving any information especially not in cases where the timer is part
of a common and frequently allocated/freed other data structure.

>  static inline void kasan_cache_shrink(struct kmem_cache *cache) {}
>  static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
>  static inline void kasan_record_aux_stack(void *ptr) {}
> +static inline void kasan_record_tmr_stack(void *ptr) {}

Duh, so you are adding per object type functions and storage? That's
going to be a huge copy and pasta orgy as every object requires the same
code and extra storage space.

Why not just using kasan_record_aux_stack() for all of this?

The 'call_rcu' 'timer' 'whatever next' printout is not really required
because the stack trace already tells you the function which was
invoked. If TOS is call_rcu() or do_timer_init() then it's entirely
clear which object is affected. If the two aux records are not enough
then making the array larger is not the end of the world.

>  #endif /* CONFIG_KASAN_GENERIC */
>  
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index a5221abb4594..ef2da9ddfac7 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -783,6 +783,8 @@ static void do_init_timer(struct timer_list *timer,
>  	timer->function = func;
>  	timer->flags = flags | raw_smp_processor_id();
>  	lockdep_init_map(&timer->lockdep_map, name, key, 0);
> +
> +	kasan_record_tmr_stack(timer);
>  }

Are you sure this is correct for all timers?

This is also called for timers which are temporarily allocated on stack
and for timers which are statically allocated at compile time. How is
that supposed to work?

These kind of things want to be explained upfront an not left to the
reviewer as an exercise.

Thanks,

        tglx
