Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF6EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61C23204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/evREF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgHYCGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgHYCGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:06:46 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CA6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 19:06:46 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id s16so7981502qtn.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 19:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EaF77NJMAWw/fTsCibd6/5Mh5Y7m4+23Kl4l34hTorQ=;
        b=e/evREF2Q7zTiBD4oTgLvduJzEQ5OqeUPm69cf9QOEZ23f3W5UzjFg5NoXkv0sQxWZ
         4hHOgq2Tc9vaenfbwpCcUe5xTIxxZET+j9ZswwUY9SYHo5ZWFSNYuZkNHxlLZskTPzYC
         545iSCM5tBlBmUYw1iEATx7mwUr56JDNISypKIfJjVNcQ5bcjVHmcnIAUiETjH1YaWu6
         rSF/GF4j3FBjrE9VnGOXpoeUtwYnqsWWyi+KjHTvAJWxtR8QQTyByWlBk2Vl/fvrkJGF
         xbkipkw44eyzgo3WOQ83TSS+g2fBim9Yb2ojtb7/UG5e28L3YUSud89Eqx0Lujwjokjz
         WxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EaF77NJMAWw/fTsCibd6/5Mh5Y7m4+23Kl4l34hTorQ=;
        b=AcOf4DfWdv7prHo6HvyN4xn8DMbkI7fG8BYchfeukigXjShc15daBNyBvhrKm9kQJU
         oiH4H2TS2CnYqvg+16iVCukUz1Rd8xJ+xyJhGpaS+yK8RC2uwCXb6gkiFmIYGZBvORny
         oiBJwAodLHa3FWHSnSEn7SWASSbFtN/YqGzx6KALqbKohoAZurE1XzKrawfvsgtg78Vz
         Pfa/qjMHCzaiR5b/kgT8HN4UE/NeQnRqs7vCevCJ3X3i6x4L9tudtS4wGal+TDGnBJA7
         DqAAOL0h3skkOXI8Er9Aq6/5Jn762rFv5MLvj+uoI1zObHYBmE1PAKVme+nFOcdt/n+j
         2E1A==
X-Gm-Message-State: AOAM530Sw/yYrQwOxVG6cD7nwsWv4vVZvPQ8BkAH/j5OUkQnWLJgmQub
        0SvkepOyfpLYj8K7NUOTXIY=
X-Google-Smtp-Source: ABdhPJxo7ANBLoEm3XkTR9T9ekNo5kghKRhhxHT2emjvlEXz8fgHiV6u474uDLk1SMfAQ0JHh+JzWA==
X-Received: by 2002:ac8:428f:: with SMTP id o15mr7018039qtl.213.1598321205547;
        Mon, 24 Aug 2020 19:06:45 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id q7sm10745122qkf.35.2020.08.24.19.06.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 19:06:44 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id E15EB27C005A;
        Mon, 24 Aug 2020 22:06:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Aug 2020 22:06:43 -0400
X-ME-Sender: <xms:MnJEX50n-3KG9ghebsfNfHl8eIniq7YyCzSHx1vxMkxqKJ9G9t2smA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudduledghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepieevheevhfelgeejleehheeghffgvdejfeduieevtddutddtteefiefhffel
    tddvnecuffhomhgrihhnpegvfhhfihgtihhoshdrtghomhenucfkphephedvrdduheehrd
    duuddurdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvge
    ehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhm
    sehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:MnJEXwEIOY3DZq_aINNShtwGQwQQ5oXZytQ0ckj7ZiAjo02N0BwVZA>
    <xmx:MnJEX56mxZTgOpukUkXSfuKQ5nRCaRgCQ9iN4qTv1YIhiteHeoYKBA>
    <xmx:MnJEX21RZc5Fgxuc_JH3gBE9bIsWL_XjSGLmuFFhH7Dvl22j1KgTAg>
    <xmx:M3JEXx6upabsYzGQsjepIn41D2QafkWTgsvOsE59MCv7g7Q7mRgOrw>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id D4CB130600B7;
        Mon, 24 Aug 2020 22:06:41 -0400 (EDT)
Date:   Tue, 25 Aug 2020 10:06:40 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 2/3] sched: membarrier: cover kthread_use_mm (v2)
Message-ID: <20200825020640.GA72178@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200814164358.4783-1-mathieu.desnoyers@efficios.com>
 <20200814164358.4783-3-mathieu.desnoyers@efficios.com>
 <20200816152907.GB87259@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <764014395.16126.1598282869127.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <764014395.16126.1598282869127.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 11:27:49AM -0400, Mathieu Desnoyers wrote:
> ----- On Aug 16, 2020, at 11:29 AM, Boqun Feng boqun.feng@gmail.com wrote:
> 
> > On Fri, Aug 14, 2020 at 12:43:57PM -0400, Mathieu Desnoyers wrote:
> >> Add comments and memory barrier to kthread_use_mm and kthread_unuse_mm
> >> to allow the effect of membarrier(2) to apply to kthreads accessing
> >> user-space memory as well.
> >> 
> >> Given that no prior kthread use this guarantee and that it only affects
> >> kthreads, adding this guarantee does not affect user-space ABI.
> >> 
> >> Refine the check in membarrier_global_expedited to exclude runqueues
> >> running the idle thread rather than all kthreads from the IPI cpumask.
> >> 
> >> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> >> Cc: Will Deacon <will@kernel.org>
> >> Cc: Paul E. McKenney <paulmck@kernel.org>
> >> Cc: Nicholas Piggin <npiggin@gmail.com>
> >> Cc: Andy Lutomirski <luto@amacapital.net>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> ---
> >> Changes since v1:
> >> - Add WARN_ON_ONCE(current->mm) in play_idle_precise (PeterZ),
> >> - Use smp_mb__after_spinlock rather than smp_mb after task_lock.
> >> ---
> >>  kernel/kthread.c          | 19 +++++++++++++++++++
> >>  kernel/sched/idle.c       |  1 +
> >>  kernel/sched/membarrier.c |  8 ++------
> >>  3 files changed, 22 insertions(+), 6 deletions(-)
> >> 
> >> diff --git a/kernel/kthread.c b/kernel/kthread.c
> >> index 3edaa380dc7b..77aaaa7bc8d9 100644
> >> --- a/kernel/kthread.c
> >> +++ b/kernel/kthread.c
> >> @@ -1255,8 +1255,19 @@ void kthread_use_mm(struct mm_struct *mm)
> >>  	finish_arch_post_lock_switch();
> >>  #endif
> >>  
> >> +	/*
> >> +	 * When a kthread starts operating on an address space, the loop
> >> +	 * in membarrier_{private,global}_expedited() may not observe
> >> +	 * that tsk->mm, and not issue an IPI. Membarrier requires a
> >> +	 * memory barrier after storing to tsk->mm, before accessing
> >> +	 * user-space memory. A full memory barrier for membarrier
> >> +	 * {PRIVATE,GLOBAL}_EXPEDITED is implicitly provided by
> >> +	 * mmdrop(), or explicitly with smp_mb().
> >> +	 */
> >>  	if (active_mm != mm)
> >>  		mmdrop(active_mm);
> >> +	else
> >> +		smp_mb();
> > 
> > Similar question here: could smp_mb() guarantee the correctness of
> > GLOBAL_EXPEDITED? Don't you need membarrier_switch_mm() here and in
> > kthread_unuse_mm(), too?
> > 
> > Am I miss something here?
> 
> I think you have a good point there. Which brings me to wonder why we
> don't have membarrier_switch_mm() when entering/leaving lazy TLB mode.
> This means an IPI can be sent to a kthread even if it does not use an
> mm, just because the membarrier state in the runqueue is that of the
> active_mm.
> 
> Thoughts ?
> 

Right, I think we should also handle the percpu membarrier_state. The
basic rule is whenever we change current->mm or current (i.e. rq->curr)
itself, we need to update the percpu membarrier_state accordingly.

Regards,
Boqun

> Thanks,
> 
> Mathieu
> 
> > 
> > Regards,
> > Boqun
> > 
> >>  
> >>  	to_kthread(tsk)->oldfs = force_uaccess_begin();
> >>  }
> >> @@ -1276,6 +1287,14 @@ void kthread_unuse_mm(struct mm_struct *mm)
> >>  	force_uaccess_end(to_kthread(tsk)->oldfs);
> >>  
> >>  	task_lock(tsk);
> >> +	/*
> >> +	 * When a kthread stops operating on an address space, the loop
> >> +	 * in membarrier_{private,global}_expedited() may not observe
> >> +	 * that tsk->mm, and not issue an IPI. Membarrier requires a
> >> +	 * memory barrier after accessing user-space memory, before
> >> +	 * clearing tsk->mm.
> >> +	 */
> >> +	smp_mb__after_spinlock();
> >>  	sync_mm_rss(mm);
> >>  	local_irq_disable();
> >>  	tsk->mm = NULL;
> >> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> >> index 6bf34986f45c..3443ee8335d0 100644
> >> --- a/kernel/sched/idle.c
> >> +++ b/kernel/sched/idle.c
> >> @@ -341,6 +341,7 @@ void play_idle_precise(u64 duration_ns, u64 latency_ns)
> >>  	WARN_ON_ONCE(!(current->flags & PF_KTHREAD));
> >>  	WARN_ON_ONCE(!(current->flags & PF_NO_SETAFFINITY));
> >>  	WARN_ON_ONCE(!duration_ns);
> >> +	WARN_ON_ONCE(current->mm);
> >>  
> >>  	rcu_sleep_check();
> >>  	preempt_disable();
> >> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
> >> index 168479a7d61b..8a294483074d 100644
> >> --- a/kernel/sched/membarrier.c
> >> +++ b/kernel/sched/membarrier.c
> >> @@ -100,13 +100,9 @@ static int membarrier_global_expedited(void)
> >>  		    MEMBARRIER_STATE_GLOBAL_EXPEDITED))
> >>  			continue;
> >>  
> >> -		/*
> >> -		 * Skip the CPU if it runs a kernel thread. The scheduler
> >> -		 * leaves the prior task mm in place as an optimization when
> >> -		 * scheduling a kthread.
> >> -		 */
> >> +		/* Skip the CPU if it runs the idle thread. */
> >>  		p = rcu_dereference(cpu_rq(cpu)->curr);
> >> -		if (p->flags & PF_KTHREAD)
> >> +		if (is_idle_task(p))
> >>  			continue;
> >>  
> >>  		__cpumask_set_cpu(cpu, tmpmask);
> >> --
> >> 2.11.0
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
