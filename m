Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EB0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F311207FB
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590389082;
	bh=spOf7XyfeMiKrgGl89egq96GzZ/GiodoxXCqwgKFryw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pLVdnXeKT4odTkYKuIZdIqhqACXFLPrM9kijtAmmNSdJU0VeFoSGRrHoN0F0pjEI3
	 9Bvx2rhYjiQWxby3hxN4yUILTAjEMJnIxPaLYeTqxyTKRPIleILN9LoIIxfULBrb63
	 UA39kq6QZ0PEdT+2FBbCHb6ndoEu6e4IM1PZESEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388903AbgEYGol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 02:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388385AbgEYGok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 02:44:40 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856BCC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 23:44:40 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r9so3982340wmh.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 23:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j3A3p7RwQnDPKk8y171UjzjlpaAeUZfU5UzTOAlkuUc=;
        b=BF+jrK+tHyMuCWDta7VDyvEPQQBuOXK660UPEDnJ5HomWsjm8jnp2ix+pSnmD3A3RN
         hXXxCfR7wECpK13pp1c5ItPfD9kNbXwQppSWIyBWuT2hiasBxW2Qe/SjOdT+OE39DS5Y
         MHk/dvzCkc8cMDsqFugK04WYObVVcXDDp6uqbvdDhUPNDV/c5Kja+po/BOBohxrS+bH6
         GBTJmU2D3tV/MIPD2fAPVYbKcCSwM0ZtCX4F0vvBSd4wvcbkeCvmKX30itj7GxwgJF/N
         2xVK+VLRJ71VENspTC9CxSaCY8tppMWKDorEHoAtxAgFCT8jFyvY1ART3t1dPqb5V2Yh
         hi5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=j3A3p7RwQnDPKk8y171UjzjlpaAeUZfU5UzTOAlkuUc=;
        b=kkxUFD7tn1/zK+HoP73fqOTZEW1FJ+JH8NupDqpSifR9VdnVhAZDzdnDO3vYIs8vN2
         nrNXKpqIJZ/wIv8oOzxJGUYp0cATFlXKzXXPgnYlozr1gyct6OBHryubt/HHeSVLRE7U
         JYDV4EwVJ+qmItGIlKATV8xjyl+4ahECuQPjlDfdsToo9KWxXG/DY56Yx670HOijQmrD
         ccLF8m7reKt/9ZUsczFqPUiff5NSNYfOVh8379LDg6sBlpauoGEfxFE4V7nvUA82TauY
         3rhFtd/gOidfQhz2qm0p9q38Gi8fKzd9ZSrTemlvkd2ZLAi4SpSIAFLcLSPrkzk+O3Fz
         Cx3A==
X-Gm-Message-State: AOAM5312SFnTQGaHkAlrAfbjDaSaMMfd5fpGCxd7HauMz1kvn9WViYKc
        HAZG637ONxjQXnzflJl/MN0=
X-Google-Smtp-Source: ABdhPJw0DTykOnvt5kt6wjW8ImOFwP1s74wj30T4UGm2lNJ5nn5j3clCR8grgAnHyZhZR1e29HlyoA==
X-Received: by 2002:a1c:b7d5:: with SMTP id h204mr5178757wmf.39.1590389079338;
        Sun, 24 May 2020 23:44:39 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id d18sm15018861wrn.34.2020.05.24.23.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 23:44:38 -0700 (PDT)
Date:   Mon, 25 May 2020 08:44:36 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH v2 3/7] mm/swap: Use local_lock for protection
Message-ID: <20200525064436.GA329373@gmail.com>
References: <20200524215739.551568-1-bigeasy@linutronix.de>
 <20200524215739.551568-4-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524215739.551568-4-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



* Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> From: Ingo Molnar <mingo@kernel.org>
> 
> The various struct pagevec per CPU variables are protected by disabling
> either preemption or interrupts across the critical sections. Inside
> these sections spinlocks have to be acquired.

> diff --git a/mm/swap.c b/mm/swap.c
> index bf9a79fed62d7..4f965292044ca 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -35,6 +35,7 @@
>  #include <linux/uio.h>
>  #include <linux/hugetlb.h>
>  #include <linux/page_idle.h>
> +#include <linux/locallock.h>
>  
>  #include "internal.h"
>  
> @@ -44,14 +45,29 @@
>  /* How many pages do we try to swap or page in/out together? */
>  int page_cluster;
>  
> -static DEFINE_PER_CPU(struct pagevec, lru_add_pvec);
> -static DEFINE_PER_CPU(struct pagevec, lru_rotate_pvecs);
> -static DEFINE_PER_CPU(struct pagevec, lru_deactivate_file_pvecs);
> -static DEFINE_PER_CPU(struct pagevec, lru_deactivate_pvecs);
> -static DEFINE_PER_CPU(struct pagevec, lru_lazyfree_pvecs);
> +/* Protecting lru_rotate_pvecs */
> +struct lru_rotate_pvecs {
> +	struct local_lock lock;
> +	struct pagevec pvec;
> +};
> +static DEFINE_PER_CPU(struct lru_rotate_pvecs, lru_rotate_pvecs) = {
> +	.lock = INIT_LOCAL_LOCK(lock),
> +};
> +
> +/* Protecting the following struct pagevec */
> +struct lru_pvecs {
> +	struct local_lock lock;
> +	struct pagevec lru_add_pvec;
> +	struct pagevec lru_deactivate_file_pvecs;
> +	struct pagevec lru_deactivate_pvecs;
> +	struct pagevec lru_lazyfree_pvecs;

Ack on coalescing these into the 'struct lru_pvecs' helper structure, 
but a minor namespace organization nit: I'd drop the _pvec/_pvecs 
postfix from the field names, i.e. make it something like this:

/* Protecting the following struct pagevec */
struct lru_pvecs {
	struct local_lock lock;
	struct pagevec lru_add;
	struct pagevec lru_deactivate_file;
	struct pagevec lru_deactivate;
	struct pagevec lru_lazyfree;

With that change, usage is a straightforward:

   pvec->lru_deactivate

instead of the double-pvec name:

   pvec->lru_deactivate_pvec

> +		local_lock_irqsave(&lru_rotate_pvecs.lock, flags);


Also:

> +		pvec = this_cpu_ptr(&lru_rotate_pvecs.pvec);

s/lru_rotate_pvecs
 /lru_rotate_pvec

it's a single pagevec, using plural is confusing when reading the 
code.

I'd also suggest adding a comment explaining why the lru_rotate_pvec 
local lock is split away from lru_add/deactivate/deactivate/lazyfree 
pagevec local lock.

Thanks,

	Ingo
