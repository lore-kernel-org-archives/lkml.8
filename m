Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9D5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 332102078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lXFKb9OH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fSa5QNiI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgHTJFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgHTJFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:05:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3558C061757
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 02:05:14 -0700 (PDT)
Date:   Thu, 20 Aug 2020 11:05:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597914313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BY1/xe/W0Y+FdQUFvwqmNldvnhuLkfAT2vY3hzSmrP8=;
        b=lXFKb9OHDKQqEf+67ZO1kFvvmi0vohKIO5L3mG0fPdTWjm/MPHZtNTJz0d9TNJRIk8AeuO
        K8PZOKYFWxnCspweD/H0akoSic2XHSIGYrYqZNalRi1BO9OCe99J/n0VmzHZ7rJ2iH2OF3
        K3So+rwweUVVLeJg0wcZKcjUsiQtFN+Rdb3Abc7oL782vKdKyyLSYxc8i/2hZjGM27rqCR
        2MhVx3UaTrANSte1jP1qkAtf/qO27ssz4he6AaU5BTSDH1cW92WDpi3No3noKvyxUbSPNU
        kGQnQGKvVy6mSA27pfeGrH8puFH3R8ZnlfsexiAmKkK4edLDppDVkYP0Qjnu9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597914313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BY1/xe/W0Y+FdQUFvwqmNldvnhuLkfAT2vY3hzSmrP8=;
        b=fSa5QNiIU0KSMTXI+TV0iAlN7J79hsJjN7pO5UQm2+hK36BsIa2OmYnIeawOdKzbcaFcyT
        qxOWxX//3R9KGQBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        tglx@linutronix.de
Subject: Re: [PATCH] lockdep: Do no validate wait context for novalidate class
Message-ID: <20200820090511.umk4x7xmdylnxcen@linutronix.de>
References: <20200629201529.1017485-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200629201529.1017485-1-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-29 22:15:29 [+0200], To linux-kernel@vger.kernel.org wrote:
> The novalidate class is ignored in the lockchain validation but is
> considered in the wait context validation.
> If a mutex and a spinlock_t is ignored by using
> lockdep_set_novalidate_class() then both locks will share the same lock
> class. From the wait validation point of view the mutex will then appear
> like a spinlock_t and the validator will complain if another mutex will
> be acquired.
> 
> Ignore the nonvalidate locks from wait context checking.

ping :)

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/locking/lockdep.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 29a8de4c50b90..fb9a642d8ebef 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -4067,7 +4067,7 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
>  	 */
>  	for (depth = curr->lockdep_depth - 1; depth >= 0; depth--) {
>  		struct held_lock *prev = curr->held_locks + depth;
> -		if (prev->irq_context != next->irq_context)
> +		if (prev->check && prev->irq_context != next->irq_context)
>  			break;
>  	}
>  	depth++;
> @@ -4078,6 +4078,9 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
>  		struct held_lock *prev = curr->held_locks + depth;
>  		short prev_inner = hlock_class(prev)->wait_type_inner;
>  
> +		if (!prev->check)
> +			continue;
> +
>  		if (prev_inner) {
>  			/*
>  			 * We can have a bigger inner than a previous one

Sebastian
