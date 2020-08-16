Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A3FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 15:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ED0420708
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 15:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYqMOi69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgHPP3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 11:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgHPP3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 11:29:11 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1185CC061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 08:29:11 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d27so10632437qtg.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 08:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OCx+RS8NPX726H3XUFLncrukio6tPMlhHsFehrH4Fpc=;
        b=UYqMOi69M7V+6Xdj76vGNOrkX3GlTqRKL2cFb/yFsz07THalfRDk44oMYmS2RxHS4/
         V+3AZ119emRJ/PFUu+WxU861gxE8HZE7slv8whMGK075quVkpDd3qMHzCc19JPBv1ZCr
         zVaipyiyS36OqWPuMlvomQknO81ufTY1ElhiJSV6KEpO9i4cy5mQJk/+wmbtTvFeV2nC
         A160I1BZrW0UDy+ATRnnn6w51p/b5COsOVaFhCTDwP+Ca6LodnZUt1YSJJPbSKokFvc6
         78C/Gcf9nAHUiXz3EoeYbN+1UTjYQITAUZnznM068cKQ/P5P+JxxQCcZHtlnvEUEsYLh
         CoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OCx+RS8NPX726H3XUFLncrukio6tPMlhHsFehrH4Fpc=;
        b=LaD2PvZWztWeDjMQUIYiXzR86GGe2bOLHUK3qLVmy0iq5JIRlzsFMt5rAG2+gHe+Ia
         31iWAcN05z0frg5aaADU0fVpAs7gUOOJbHzoEn5UDRJJlppDZKBwWEsjT1+UCfXWFUy4
         qhNWjxwAba65+w0JDdsVZ2/JYLnbmTv/fr3ex/QJd4WjVBhea+NgEt9inGbESgu1tJmY
         GyD2QgDgB/yCi0LuLC0abbQqSozGxBu2Xza4OhuMh728ohBZuZBCifAFrrr4Q/kqlEfF
         bfkfYpNPwIAcQgYpezBeLC0uv6qwYgCMHbglSeLPtc2eqYPIR0IhXpk8/ZdQ1P7O7tu7
         Q8Xw==
X-Gm-Message-State: AOAM532/d8Wwm7zpoN3Ya/pVnnJGs33PHZN0EphTuLpo35ZMTGPSXSiv
        6qipncVdjHQdwGAZtEFVNg8=
X-Google-Smtp-Source: ABdhPJwMms2XqQQJcBbF2/+GO8LN1v8NxBbNwSx0uZ9756CtCJqTftGnjBqf5aveYY1YJJV4xFjm7w==
X-Received: by 2002:aed:2352:: with SMTP id i18mr10272753qtc.167.1597591750197;
        Sun, 16 Aug 2020 08:29:10 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id p202sm14190937qke.97.2020.08.16.08.29.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Aug 2020 08:29:09 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 51A1D27C0054;
        Sun, 16 Aug 2020 11:29:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 16 Aug 2020 11:29:09 -0400
X-ME-Sender: <xms:xFA5X9QMT5E2f64TW6FwQc0nHeeBWzskFpgI1hq_B_eZnqvek1WVKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddtuddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecukfhppeehvddrudehhedrudduuddrjedunecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:xFA5X2wKldcHwHYf69_Up6jdfIvU_kJWuqS3lN2ngk2srGQsryTNFQ>
    <xmx:xFA5Xy3Qwuwewwy-ZjWOIMTHQAfTbcKfI6DlJ1egBdqs8g_0ylfRjg>
    <xmx:xFA5X1B9WgqYSXUc7e6o2BFGsfWZynnKTdMnNY31WScCnumx0020aA>
    <xmx:xVA5XxVPqX4u1tNQ1eAaArjJ2pt1ITSynYGSGPMw_i13kEAj7LOb2w>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7160330600A6;
        Sun, 16 Aug 2020 11:29:08 -0400 (EDT)
Date:   Sun, 16 Aug 2020 23:29:07 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 2/3] sched: membarrier: cover kthread_use_mm (v2)
Message-ID: <20200816152907.GB87259@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200814164358.4783-1-mathieu.desnoyers@efficios.com>
 <20200814164358.4783-3-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814164358.4783-3-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 12:43:57PM -0400, Mathieu Desnoyers wrote:
> Add comments and memory barrier to kthread_use_mm and kthread_unuse_mm
> to allow the effect of membarrier(2) to apply to kthreads accessing
> user-space memory as well.
> 
> Given that no prior kthread use this guarantee and that it only affects
> kthreads, adding this guarantee does not affect user-space ABI.
> 
> Refine the check in membarrier_global_expedited to exclude runqueues
> running the idle thread rather than all kthreads from the IPI cpumask.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
> Changes since v1:
> - Add WARN_ON_ONCE(current->mm) in play_idle_precise (PeterZ),
> - Use smp_mb__after_spinlock rather than smp_mb after task_lock.
> ---
>  kernel/kthread.c          | 19 +++++++++++++++++++
>  kernel/sched/idle.c       |  1 +
>  kernel/sched/membarrier.c |  8 ++------
>  3 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 3edaa380dc7b..77aaaa7bc8d9 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -1255,8 +1255,19 @@ void kthread_use_mm(struct mm_struct *mm)
>  	finish_arch_post_lock_switch();
>  #endif
>  
> +	/*
> +	 * When a kthread starts operating on an address space, the loop
> +	 * in membarrier_{private,global}_expedited() may not observe
> +	 * that tsk->mm, and not issue an IPI. Membarrier requires a
> +	 * memory barrier after storing to tsk->mm, before accessing
> +	 * user-space memory. A full memory barrier for membarrier
> +	 * {PRIVATE,GLOBAL}_EXPEDITED is implicitly provided by
> +	 * mmdrop(), or explicitly with smp_mb().
> +	 */
>  	if (active_mm != mm)
>  		mmdrop(active_mm);
> +	else
> +		smp_mb();

Similar question here: could smp_mb() guarantee the correctness of
GLOBAL_EXPEDITED? Don't you need membarrier_switch_mm() here and in
kthread_unuse_mm(), too?

Am I miss something here?

Regards,
Boqun

>  
>  	to_kthread(tsk)->oldfs = force_uaccess_begin();
>  }
> @@ -1276,6 +1287,14 @@ void kthread_unuse_mm(struct mm_struct *mm)
>  	force_uaccess_end(to_kthread(tsk)->oldfs);
>  
>  	task_lock(tsk);
> +	/*
> +	 * When a kthread stops operating on an address space, the loop
> +	 * in membarrier_{private,global}_expedited() may not observe
> +	 * that tsk->mm, and not issue an IPI. Membarrier requires a
> +	 * memory barrier after accessing user-space memory, before
> +	 * clearing tsk->mm.
> +	 */
> +	smp_mb__after_spinlock();
>  	sync_mm_rss(mm);
>  	local_irq_disable();
>  	tsk->mm = NULL;
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 6bf34986f45c..3443ee8335d0 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -341,6 +341,7 @@ void play_idle_precise(u64 duration_ns, u64 latency_ns)
>  	WARN_ON_ONCE(!(current->flags & PF_KTHREAD));
>  	WARN_ON_ONCE(!(current->flags & PF_NO_SETAFFINITY));
>  	WARN_ON_ONCE(!duration_ns);
> +	WARN_ON_ONCE(current->mm);
>  
>  	rcu_sleep_check();
>  	preempt_disable();
> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
> index 168479a7d61b..8a294483074d 100644
> --- a/kernel/sched/membarrier.c
> +++ b/kernel/sched/membarrier.c
> @@ -100,13 +100,9 @@ static int membarrier_global_expedited(void)
>  		    MEMBARRIER_STATE_GLOBAL_EXPEDITED))
>  			continue;
>  
> -		/*
> -		 * Skip the CPU if it runs a kernel thread. The scheduler
> -		 * leaves the prior task mm in place as an optimization when
> -		 * scheduling a kthread.
> -		 */
> +		/* Skip the CPU if it runs the idle thread. */
>  		p = rcu_dereference(cpu_rq(cpu)->curr);
> -		if (p->flags & PF_KTHREAD)
> +		if (is_idle_task(p))
>  			continue;
>  
>  		__cpumask_set_cpu(cpu, tmpmask);
> -- 
> 2.11.0
> 
