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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C054DC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 15:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96DF320735
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 15:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kek4xuub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgHPPXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 11:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgHPPXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 11:23:36 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DBFC061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 08:23:36 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id b2so6640621qvp.9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 08:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZSsQfyI5SIsyIr1d2hd10y1kYresPy7/xEx4V1MJNQA=;
        b=kek4xuubACnt25VOzJ56L4Duh1WO3Q4hhIkyHWsYAD9V4KuPGu3ww8lA2lDWDWldp4
         Pi2d5mMbch5vS8s75F97+WOsTigVJRhdB60V7JWx7Uv308cL3XOJNLl9CGIdDZc0h7Ua
         q+4NyxogAVdRvIkehNjJLQCkz6RVc0QBO4ajO+3s8iJFu7WPdkNI4vPPOsEAi1N+o8V9
         sMQUIuPIvBdS5HBfnVfy8juSPz+7qdQRyLj7RcWVLrU6gLf21XbnWyDtu/7vK1HG6ewM
         sfX97PugBH1dCCV+TA6ahmWdXwN/g5q7mMOH62Cl/8XBg67li/T798Sdm/aiumrCd1dV
         mgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZSsQfyI5SIsyIr1d2hd10y1kYresPy7/xEx4V1MJNQA=;
        b=bT8rTaSj0kR6VdvQ8vwKrqTuS0Tq67Ba+oKtjZuu0E0f5Xt3Wfg2CLD6kVqns5VehW
         3QHD1/jnCCevs1F6hM0F/ITH+qNDnWraKfSMrq8Mopqqh1C9+YPDwU0rZ0bCM1gOp6tI
         4BFdGWZ+zwtM+AEB1p6I0jiJYnkrpecm8/alCVpFvysIvYuCWVCOBTuye5eIn9ClaPxZ
         AOnCtEQfokSCn0Qnyy7Ft6MwnW0TU2Id3kr8tD4gXYQeK1UBuyjNYeYpKJScV4IkMZ1M
         n8jjCyLNx42UY7nk3EZpYs2jmFOcXhd4aWCzDFdKY+27hs8FuEHHMaUzGp+uZ64nzI44
         rGAg==
X-Gm-Message-State: AOAM5306710rq0tBh5AfQQuyQcSvwMRntPZdLoQMqO9yvt43weNeyAvo
        NGu+/pbGFaiJB5zfpczQVPI=
X-Google-Smtp-Source: ABdhPJxcFUP7pPB4jSaWyI6xl6cio0huCBsw8GaBreokm/yKKBm+U/dT9vonOd1o1lME5DznAg04Lw==
X-Received: by 2002:ad4:4365:: with SMTP id u5mr10880053qvt.109.1597591415715;
        Sun, 16 Aug 2020 08:23:35 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id x12sm17337484qta.67.2020.08.16.08.23.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Aug 2020 08:23:34 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id DE96927C0054;
        Sun, 16 Aug 2020 11:23:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 16 Aug 2020 11:23:33 -0400
X-ME-Sender: <xms:dE85X-TbFlaHUQoxGberTo9_6b78ZxniNCYg5D36xHPcQ5GvngoUKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddtuddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecukfhppeehvddrudehhedrudduuddrjedunecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:dE85XzyUcOePgCZTSc8tHM8wAL6HNNICFBP5MQX7BubiE0UBHjLkSA>
    <xmx:dE85X71dzVY16F5WZxxttSnTPThJx-LvhG9cvNTYQqaYDx7laFiQ-A>
    <xmx:dE85X6AjyAyQATpDFYF_H0W3-sudKkER1hbs2zqx8zjQIgVujnwBdw>
    <xmx:dU85X2NsrRAT-aX3ewgun3g4sqXNmmD69yLFeIz9MB2HRYBuNxfspR84zB8>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 30073328005A;
        Sun, 16 Aug 2020 11:23:32 -0400 (EDT)
Date:   Sun, 16 Aug 2020 23:23:30 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/3] sched: fix exit_mm vs membarrier (v2)
Message-ID: <20200816152330.GA87259@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200814164358.4783-1-mathieu.desnoyers@efficios.com>
 <20200814164358.4783-2-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814164358.4783-2-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Fri, Aug 14, 2020 at 12:43:56PM -0400, Mathieu Desnoyers wrote:
> exit_mm should issue memory barriers after user-space memory accesses,
> before clearing current->mm, to order user-space memory accesses
> performed prior to exit_mm before clearing tsk->mm, which has the
> effect of skipping the membarrier private expedited IPIs.
> 
> The membarrier system call can be issued concurrently with do_exit
> if we have thread groups created with CLONE_VM but not CLONE_THREAD.
> 
> Here is the scenario I have in mind:
> 
> Two thread groups are created, A and B. Thread group B is created by
> issuing clone from group A with flag CLONE_VM set, but not CLONE_THREAD.
> Let's assume we have a single thread within each thread group (Thread A
> and Thread B).
> 
> The AFAIU we can have:
> 
> Userspace variables:
> 
> int x = 0, y = 0;
> 
> CPU 0                   CPU 1
> Thread A                Thread B
> (in thread group A)     (in thread group B)
> 
> x = 1
> barrier()
> y = 1
> exit()
> exit_mm()
> current->mm = NULL;
>                         r1 = load y
>                         membarrier()
>                           skips CPU 0 (no IPI) because its current mm is NULL
>                         r2 = load x
>                         BUG_ON(r1 == 1 && r2 == 0)
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: linux-mm@kvack.org
> ---
> Changes since v1:
> - Use smp_mb__after_spinlock rather than smp_mb.
> - Document race scenario in commit message.
> ---
>  kernel/exit.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 733e80f334e7..fe64e6e28dd5 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -475,6 +475,14 @@ static void exit_mm(void)
>  	BUG_ON(mm != current->active_mm);
>  	/* more a memory barrier than a real lock */
>  	task_lock(current);
> +	/*
> +	 * When a thread stops operating on an address space, the loop
> +	 * in membarrier_{private,global}_expedited() may not observe

Is it accurate to say that the correctness of
membarrier_global_expedited() relies on the observation of ->mm? Because
IIUC membarrier_global_expedited() loop doesn't check ->mm.

Regards,
Boqun

> +	 * that tsk->mm, and not issue an IPI. Membarrier requires a
> +	 * memory barrier after accessing user-space memory, before
> +	 * clearing tsk->mm.
> +	 */
> +	smp_mb__after_spinlock();
>  	current->mm = NULL;
>  	mmap_read_unlock(mm);
>  	enter_lazy_tlb(mm, current);
> -- 
> 2.11.0
> 
