Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD11C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634582072A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VcVywV//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgAJKGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:06:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41302 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbgAJKGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 05:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=W+8o31v5SZYC8i8sg35zrJwWXEuILI8LPiA6P2pCM1o=; b=VcVywV//8iXSRdFbjuO6fx0ne
        2BsVLzpVmvmt/pK4bmbDn20yOno2JKEKh12YS+kr9Enu+vsGhZB2EJ0JzGxI4OREeTml4bKg85XQ1
        2sLOq9LDX4ai2CH9N/bRuxiXUVLnxzHxCItgmF9JZ49lIIQi6o85Y1hRaMJOYS8M2fbmo4WTjmxiJ
        Xe7gsCBT79FnWe2Gzzk8C1TLn9tHwmGc4ln1kW3UrZL30Rh3yGwtUEfS7yI22JIjgYOfewQTyW084
        wT21mZZBlK1/3gVIt3VdIFlJJUPgYltTj2jCmTA9JZNeaVLG2ocy1nRWXuWJkFDoJidDDiO++mj4g
        9gQ/c7Bxg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iprBH-0004PE-WC; Fri, 10 Jan 2020 10:06:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1234C30018B;
        Fri, 10 Jan 2020 11:04:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C15EF20D3D41E; Fri, 10 Jan 2020 11:06:12 +0100 (CET)
Date:   Fri, 10 Jan 2020 11:06:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/osq: Use more optimized spinning for arm64
Message-ID: <20200110100612.GC2827@hirez.programming.kicks-ass.net>
References: <20200109153831.29993-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109153831.29993-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 10:38:31AM -0500, Waiman Long wrote:

> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -134,6 +134,27 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>  	 * cmpxchg in an attempt to undo our queueing.
>  	 */
>  
> +	/*
> +	 * If vcpu_is_preempted is not defined, we can skip the check
> +	 * and use smp_cond_load_relaxed() instead. For arm64, this
> +	 * could lead to the use of the more optimized wfe instruction.
> +	 * As need_sched() is set by interrupt handler, it will break
> +	 * out and do the unqueue in a timely manner.
> +	 *
> +	 * TODO: We may need to add a static_key like vcpu_is_preemptible
> +	 *	 as vcpu_is_preempted() will always return false with
> +	 *	 bare metal even if it is defined.
> +	 */
> +#ifndef vcpu_is_preempted
> +	{
> +		int locked = smp_cond_load_relaxed(&node->locked,
> +						   VAL || need_resched());
> +		if (!locked)
> +			goto unqueue;
> +		return true;
> +	}
> +#endif

Much yuck :-/

With ARM64 being the only arch that currently makes use of this; another
approach is doing something like:

That is also rather yuck, and definitely needs a few comments sprinked
on it, but it should just work for everyone.

It basically relies on an arch having a spinning *cond_load*()
implementation if it has vcpu_is_preempted(), which is true today.

---
diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 6ef600aa0f47..6e00d7c077ba 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -133,18 +133,10 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 	 * guaranteed their existence -- this allows us to apply
 	 * cmpxchg in an attempt to undo our queueing.
 	 */
+	if (!smp_cond_load_relaxed(&node->locked, VAL || need_resched() ||
+						  vcpu_is_preempetd(node_cpu(node->prev))))
+		goto unqueue;
 
-	while (!READ_ONCE(node->locked)) {
-		/*
-		 * If we need to reschedule bail... so we can block.
-		 * Use vcpu_is_preempted() to avoid waiting for a preempted
-		 * lock holder:
-		 */
-		if (need_resched() || vcpu_is_preempted(node_cpu(node->prev)))
-			goto unqueue;
-
-		cpu_relax();
-	}
 	return true;
 
 unqueue:
