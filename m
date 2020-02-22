Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D9FC35669
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 03:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D062071E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 03:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="b8sXekKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgBVDIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 22:08:49 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38938 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgBVDIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 22:08:49 -0500
Received: by mail-qt1-f195.google.com with SMTP id p34so2795984qtb.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 19:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CP6atjRwhdDbnoorKkqcf5kaCRKftzd9xcwwbnPKUYc=;
        b=b8sXekKgEQH6+jxePbWcLlA5uslQdfxzNedSgSBwsWEcqggyq7jiipBUxz4n7cl9KC
         hye7uA7MM7Hgq92KAt5L90XEnBO5zTQWW2oUrcCagbPu2Zr7yM+n6xGEZIC0l/IJ90sy
         mKurXKiNnfZDtJ5onWavJwQs1jcVzU51pUB9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CP6atjRwhdDbnoorKkqcf5kaCRKftzd9xcwwbnPKUYc=;
        b=EMdeqexo7BvHh2ktf3XRwEjHDIEaikeQxTaIgOPuJf33fSxku1jSop7zob+GkIphP8
         sawe1J9N3wnW00Q7ICkgB/arWFfURu7YVcFXDC1kkk5E2E/hU0Qpr0nUN3oh+FIGKUE+
         jxl/qT8/eLcU3PziDEhSpBRF21YhKS27QcWs3QIJzkPdKH+6FACy9PN0oZQ4/DA8qY1O
         TCEzIcDeNY6evQ//OTda/1lUrzmSG0+b3lx/85KkeWNZALgWvQYaNMfRy4yp/9SZrI44
         UQzNfvyhHq2zBv687DytpwWbLETN0RrIVz81CLaxDx5VLQ3cPrxLVa7ispOrQXItTYcG
         AJLA==
X-Gm-Message-State: APjAAAW+BCRtuahPNeYdTYE7UqphnCVhuXT4tbekGuUQ4TtGOb98DPsI
        ZRZAgYMQMOj1TUnpb+ALgMyhQw==
X-Google-Smtp-Source: APXvYqxsnqWMcaf7bIfKSBiNID3M78w4lFmVk2MV1D93TRWZ63pRswgtXzpuBhYRx4HIWbI9QLbTLQ==
X-Received: by 2002:ac8:6f73:: with SMTP id u19mr34598485qtv.326.1582340926493;
        Fri, 21 Feb 2020 19:08:46 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id w18sm304561qki.40.2020.02.21.19.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 19:08:45 -0800 (PST)
Date:   Fri, 21 Feb 2020 22:08:43 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com,
        frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v4 01/27] lockdep: Teach lockdep about "USED" <- "IN-NMI"
 inversions
Message-ID: <20200222030843.GA191380@google.com>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.090538203@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221134215.090538203@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 02:34:17PM +0100, Peter Zijlstra wrote:
> nmi_enter() does lockdep_off() and hence lockdep ignores everything.
> 
> And NMI context makes it impossible to do full IN-NMI tracking like we
> do IN-HARDIRQ, that could result in graph_lock recursion.

The patch makes sense to me.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

NOTE:
Also, I was wondering if we can detect the graph_lock recursion case and
avoid doing anything bad, that way we enable more of the lockdep
functionality for NMI where possible. Not sure if the suggestion makes sense
though!

thanks,

 - Joel


> However, since look_up_lock_class() is lockless, we can find the class
> of a lock that has prior use and detect IN-NMI after USED, just not
> USED after IN-NMI.
> 
> NOTE: By shifting the lockdep_off() recursion count to bit-16, we can
> easily differentiate between actual recursion and off.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/locking/lockdep.c |   53 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 50 insertions(+), 3 deletions(-)
> 
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -379,13 +379,13 @@ void lockdep_init_task(struct task_struc
>  
>  void lockdep_off(void)
>  {
> -	current->lockdep_recursion++;
> +	current->lockdep_recursion += BIT(16);
>  }
>  EXPORT_SYMBOL(lockdep_off);
>  
>  void lockdep_on(void)
>  {
> -	current->lockdep_recursion--;
> +	current->lockdep_recursion -= BIT(16);
>  }
>  EXPORT_SYMBOL(lockdep_on);
>  
> @@ -575,6 +575,7 @@ static const char *usage_str[] =
>  #include "lockdep_states.h"
>  #undef LOCKDEP_STATE
>  	[LOCK_USED] = "INITIAL USE",
> +	[LOCK_USAGE_STATES] = "IN-NMI",
>  };
>  #endif
>  
> @@ -787,6 +788,7 @@ static int count_matching_names(struct l
>  	return count + 1;
>  }
>  
> +/* used from NMI context -- must be lockless */
>  static inline struct lock_class *
>  look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
>  {
> @@ -4463,6 +4465,34 @@ void lock_downgrade(struct lockdep_map *
>  }
>  EXPORT_SYMBOL_GPL(lock_downgrade);
>  
> +/* NMI context !!! */
> +static void verify_lock_unused(struct lockdep_map *lock, struct held_lock *hlock, int subclass)
> +{
> +	struct lock_class *class = look_up_lock_class(lock, subclass);
> +
> +	/* if it doesn't have a class (yet), it certainly hasn't been used yet */
> +	if (!class)
> +		return;
> +
> +	if (!(class->usage_mask & LOCK_USED))
> +		return;
> +
> +	hlock->class_idx = class - lock_classes;
> +
> +	print_usage_bug(current, hlock, LOCK_USED, LOCK_USAGE_STATES);
> +}
> +
> +static bool lockdep_nmi(void)
> +{
> +	if (current->lockdep_recursion & 0xFFFF)
> +		return false;
> +
> +	if (!in_nmi())
> +		return false;
> +
> +	return true;
> +}
> +
>  /*
>   * We are not always called with irqs disabled - do that here,
>   * and also avoid lockdep recursion:
> @@ -4473,8 +4503,25 @@ void lock_acquire(struct lockdep_map *lo
>  {
>  	unsigned long flags;
>  
> -	if (unlikely(current->lockdep_recursion))
> +	if (unlikely(current->lockdep_recursion)) {
> +		/* XXX allow trylock from NMI ?!? */
> +		if (lockdep_nmi() && !trylock) {
> +			struct held_lock hlock;
> +
> +			hlock.acquire_ip = ip;
> +			hlock.instance = lock;
> +			hlock.nest_lock = nest_lock;
> +			hlock.irq_context = 2; // XXX
> +			hlock.trylock = trylock;
> +			hlock.read = read;
> +			hlock.check = check;
> +			hlock.hardirqs_off = true;
> +			hlock.references = 0;
> +
> +			verify_lock_unused(lock, &hlock, subclass);
> +		}
>  		return;
> +	}
>  
>  	raw_local_irq_save(flags);
>  	check_flags(flags);
> 
> 
