Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C954FC433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 993FE2071B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z9wEYcR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbgH1I7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 04:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgH1I7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:59:46 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08B0C06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 01:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4eqhOxy9cHFi0VijKDUn9S8u6mI/BeSMcijpmCfnCcg=; b=z9wEYcR8mtnpcP4B+bLEpsPrXS
        P5a/nHnhKUSPzy9w/s/ZaMGfvktkmv1+iKxGyKWSIxhYdsjojtO7p1FfZPMRdr6cGBEjbSQtNEPr+
        Sg8OAa5q+0RLtg09Poimi2ZemkjTz+eehOYYz8PDhtUKV7CbaT2ujTS0yZmWJg7r3TyFkRcdDVz+U
        y30foQNrtqoiZZN7vknePofxRyLorr3xkjzaFy75C+9ZlOu6eDpy79qHLkMdgce+KvROqaz9EGDW7
        7MdZOC9rJRfX1NKXrZRP0Y/RIUcI07cVNexY6bHk8K9qPMEOR+Uf+EvEdN9YWJ9BcPiYhjqxVrB3R
        9LTYUIPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBaEV-0007t9-TI; Fri, 28 Aug 2020 08:59:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 97670300238;
        Fri, 28 Aug 2020 10:59:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 503782C56E64B; Fri, 28 Aug 2020 10:59:38 +0200 (CEST)
Date:   Fri, 28 Aug 2020 10:59:38 +0200
From:   peterz@infradead.org
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 4/5] seqlock: seqcount_LOCKTYPE_t: Introduce
 PREEMPT_RT support
Message-ID: <20200828085938.GS1362448@hirez.programming.kicks-ass.net>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200828010710.5407-1-a.darwish@linutronix.de>
 <20200828010710.5407-5-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828010710.5407-5-a.darwish@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 03:07:09AM +0200, Ahmed S. Darwish wrote:
> +#define __SEQ_RT	IS_ENABLED(CONFIG_PREEMPT_RT)
> +
> +SEQCOUNT_LOCKTYPE(raw_spinlock, raw_spinlock_t,  false,    s->lock,        raw_spin, raw_spin_lock(s->lock))
> +SEQCOUNT_LOCKTYPE(spinlock,     spinlock_t,      __SEQ_RT, s->lock,        spin,     spin_lock(s->lock))
> +SEQCOUNT_LOCKTYPE(rwlock,       rwlock_t,        __SEQ_RT, s->lock,        read,     read_lock(s->lock))
> +SEQCOUNT_LOCKTYPE(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
> +SEQCOUNT_LOCKTYPE(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))

Ooh, reading is hard, but ^^^^ you already have that.

> +/*
> + * Automatically disable preemption for seqcount_LOCKTYPE_t writers, if the
> + * associated lock does not implicitly disable preemption.
> + *
> + * Don't do it for PREEMPT_RT. Check __SEQ_LOCK().
> + */
> +#define __seq_enforce_preemption_protection(s)				\
> +	(!IS_ENABLED(CONFIG_PREEMPT_RT) && __seqcount_lock_preemptible(s))

Then what is this doing ?!? I'm confused now.
