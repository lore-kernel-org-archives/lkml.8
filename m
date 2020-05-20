Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE4BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB221207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AF783d4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgETKyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 06:54:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54766 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgETKyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Yq27b7ObxQImP0IhKad7is0YDQIJNP7DgoreIpDDvKc=; b=AF783d4CouNOb7lX75QxKlZqNP
        tnmu5QM0kAImJUE9qD/nFznrBVnuXzCl9+Os0lnMhrDYQ604j+8R0UN08wOF2Saxe6xwoyKf7y8Bo
        TX8aJhSDoDbmlGZPwdWJSlk6RudKXvsN0ebzN28bY45f5MPTa1Acgkryx+qphd5qEYltr2YzDKtz5
        9/Rx7hGRPuqiuDZ4I8uMJT8xk4qfoXas6DFfp/0RqMBHr0lH6ibyg+dMue6Nbrps1r77+PHO1RPZ6
        HuFyC1AgAahCjEdIOxsJWgMnjRz6ZG+1SsXoL6gX+I2P76EoDpWd38LrPxuOFdZmA4kzjO2Dhe9b6
        RwuT/rVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbMLk-0005wq-6A; Wed, 20 May 2020 10:53:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A043A30067C;
        Wed, 20 May 2020 12:53:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5989029D896D4; Wed, 20 May 2020 12:53:22 +0200 (CEST)
Date:   Wed, 20 May 2020 12:53:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH 4/8] mm/swap: Use local_lock for protection
Message-ID: <20200520105322.GG317569@hirez.programming.kicks-ass.net>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-5-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519201912.1564477-5-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 10:19:08PM +0200, Sebastian Andrzej Siewior wrote:
> diff --git a/mm/swap.c b/mm/swap.c
> index bf9a79fed62d7..03c97d15fcd69 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -44,8 +44,14 @@
>  /* How many pages do we try to swap or page in/out together? */
>  int page_cluster;
>  
> -static DEFINE_PER_CPU(struct pagevec, lru_add_pvec);
> +
> +/* Protecting lru_rotate_pvecs */
> +static DEFINE_LOCAL_LOCK(rotate_lock);
>  static DEFINE_PER_CPU(struct pagevec, lru_rotate_pvecs);
> +
> +/* Protecting the following struct pagevec */
> +DEFINE_LOCAL_LOCK(swapvec_lock);
> +static DEFINE_PER_CPU(struct pagevec, lru_add_pvec);
>  static DEFINE_PER_CPU(struct pagevec, lru_deactivate_file_pvecs);
>  static DEFINE_PER_CPU(struct pagevec, lru_deactivate_pvecs);
>  static DEFINE_PER_CPU(struct pagevec, lru_lazyfree_pvecs);

So personally I'd prefer to have this look like:

struct lru_vecs {
	struct local_lock lock;
	struct pagevec add;
	struct pagevec rotate;
	struct pagevec deact_file;
	struct pagevec deact;
	struct pagevec lazyfree;
#ifdef CONFIG_SMP
	struct pagevec active;
#endif
};

DEFINE_PER_CPU(struct lru_pvec, lru_pvec);

or something, but I realize that is a lot of churn (although highly
automated), so I'll leave that to the mm folks.
