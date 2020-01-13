Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A13FC33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0374B20CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578916643;
	bh=31ZC9hOEd1GVT60jOXVaks6wlFMfup6HMBgm19H4nA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pPgDU1ZeXs1aW6M74v2DlXI3ZuH9pqpXLuuhzQb/nz0FBIy7/Ix20NDFXvbAiNN4T
	 ScvMofdfvedMC2uYYkUebGiOe4Ceep7ZKzEu+wsAxJ+r5Q60Y3B686Idn6g6HCP5ZM
	 y+MVBVbxs7h9ycgupVQT4b2GVoNMZv80WVSrQkuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgAML5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 06:57:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgAML5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 06:57:21 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82A11207FF;
        Mon, 13 Jan 2020 11:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578916640;
        bh=31ZC9hOEd1GVT60jOXVaks6wlFMfup6HMBgm19H4nA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wLH+4axl9PTu7p9XYgup//bPK+FN/vyS361YfojRzLdLOv1TvF0a+OL9GXXVUuzoJ
         +YQpyE7B4sdcdImWltV7WU9/0ymlojNqoViQCxnqMwA1zX69utc7qSPKuXeIklb6D9
         ZIznY+WdadHnYCqcOosiCL3EsJUBfFevK610dhsQ=
Date:   Mon, 13 Jan 2020 11:57:16 +0000
From:   Will Deacon <will@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org
Subject: Re: [PATCH v2] locking/osq: Use optimized spinning loop for arm64
Message-ID: <20200113115715.GA3260@willie-the-truck>
References: <20200112235854.32089-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200112235854.32089-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Marc]

On Sun, Jan 12, 2020 at 06:58:54PM -0500, Waiman Long wrote:
> Arm64 has a more optimized spinning loop (atomic_cond_read_acquire)
> for spinlock that can boost performance of sibling threads by putting
> the current cpu to a shallow sleep state that is woken up only when
> the monitored variable changes or an external event happens.
> 
> OSQ has a more complicated spinning loop. Besides the lock value, it
> also checks for need_resched() and vcpu_is_preempted(). The check for
> need_resched() is not a problem as it is only set by the tick interrupt
> handler. That will be detected by the spinning cpu right after iret.
> 
> The vcpu_is_preempted() check, however, is a problem as changes to the
> preempt state of of previous node will not affect the sleep state. For
> ARM64, vcpu_is_preempted is not defined and so is a no-op. To guard
> against future addition of vcpu_is_preempted() to arm64, code is added
> to cause build error when vcpu_is_preempted becomes defined in arm64
> without the corresponding changes in the OSQ spinning code.
> 
> On a 2-socket 56-core 224-thread ARM64 system, a kernel mutex locking
> microbenchmark was run for 10s with and without the patch. The
> performance numbers before patch were:
> 
> Running locktest with mutex [runtime = 10s, load = 1]
> Threads = 224, Min/Mean/Max = 316/123,143/2,121,269
> Threads = 224, Total Rate = 2,757 kop/s; Percpu Rate = 12 kop/s
> 
> After patch, the numbers were:
> 
> Running locktest with mutex [runtime = 10s, load = 1]
> Threads = 224, Min/Mean/Max = 334/147,836/1,304,787
> Threads = 224, Total Rate = 3,311 kop/s; Percpu Rate = 15 kop/s
> 
> So there was about 20% performance improvement.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  arch/arm64/include/asm/barrier.h | 10 ++++++++++
>  kernel/locking/osq_lock.c        | 25 ++++++++++++-------------
>  2 files changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> index 7d9cc5ec4971..8eb5f1239885 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h
> @@ -152,6 +152,16 @@ do {									\
>  	VAL;								\
>  })
>  
> +/*
> + * In osq_lock(), smp_cond_load_relaxed() is called with a condition
> + * that includes vcpu_is_preempted(). For arm64, vcpu_is_preempted is not
> + * currently defined. So it is a no-op. If vcpu_is_preempted is defined in
> + * the future, smp_cond_load_relaxed() will not response to changes in the
> + * preempt state in a timely manner. So code changes will have to be made
> + * to address this deficiency.
> + */
> +#define vcpu_is_preempted_not_used
> +
>  #define smp_cond_load_acquire(ptr, cond_expr)				\
>  ({									\
>  	typeof(ptr) __PTR = (ptr);					\
> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index 6ef600aa0f47..69ec5161c3cc 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -13,6 +13,14 @@
>   */
>  static DEFINE_PER_CPU_SHARED_ALIGNED(struct optimistic_spin_node, osq_node);
>  
> +/*
> + * The optimized smp_cond_load_relaxed() spin loop should not be used with
> + * vcpu_is_preempted defined.
> + */
> +#if defined(vcpu_is_preempted) && defined(vcpu_is_preempted_not_used)
> +#error "vcpu_is_preempted() inside smp_cond_load_relaxed() may not work!"
> +#endif

Although I appreciate you going the extra mile for arm64 (thanks!), I think
this is probably a bit overkill given that I don't plan to merge the series
from Zengruan any time soon. Instead, how about just defining
vcpu_is_preempted in arch/arm64/include/asm/spinlock.h with a comment:


	/*
	 * Changing this will break osq_lock() thanks to the call inside
	 * smp_cond_load_relaxed().
	 *
	 * See:
	 * https://lore.kernel.org/lkml/20200110100612.GC2827@hirez.programming.kicks-ass.net
	 */
	#define vcpu_is_preempted(cpu)	false


So we'll notice that when somebody tries to change it.

Will
