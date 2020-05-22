Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B07C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB6E92070A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GrI9SuZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbgEVQY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 12:24:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43084 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbgEVQY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kkN05n8AwCXofpqby7bmdZ4Wpf27jnFTOS+pMiMfGAc=; b=GrI9SuZZySt1tElKW+7wdSmUym
        jsPk8svSB7JtRPm767hAejK6eW134ekobve4Zk5UYQV9RuFV+Ba/4DaXh3Q/j5S6dPaZ0VL9Qbdya
        TfblH5j8eA/r3WmSUMq6UJLrfsfbFEyALZQZCSq4IIPoKV9xHiIPZCMsSbe1WbIFJEz03rl3Soa8n
        QmaOWP66+wtIyMPkBhiBZeK3TFcZl6N27s5njC525N6gI1zcmm6P50GSkyUDFF5ZHeoHEg5Lx9LVj
        UIFE/9ZBMDqpb3Zds+L8WifHgImjKDz7e3nw2jQOJ/1becU2Qm0c8nN7aslucQUE1IT5KQ39lhZZw
        jObs8Cfg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcASF-0005wj-FZ; Fri, 22 May 2020 16:23:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D785C306102;
        Fri, 22 May 2020 18:23:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E72C20B5D17E; Fri, 22 May 2020 18:23:18 +0200 (CEST)
Date:   Fri, 22 May 2020 18:23:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Sebastian A. Siewior" <bigeasy@linutronix.de>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-mm@kvack.org
Subject: Re: [PATCH v1 02/25] mm/swap: Don't abuse the seqcount latching API
Message-ID: <20200522162318.GV317569@hirez.programming.kicks-ass.net>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200519214547.352050-3-a.darwish@linutronix.de>
 <20200522145707.GO325280@hirez.programming.kicks-ass.net>
 <20200522151705.vwfua5a4lhzcagea@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522151705.vwfua5a4lhzcagea@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 05:17:05PM +0200, Sebastian A. Siewior wrote:
> On 2020-05-22 16:57:07 [+0200], Peter Zijlstra wrote:
> > > @@ -725,21 +735,48 @@ void lru_add_drain_all(void)
> > >  	if (WARN_ON(!mm_percpu_wq))
> > >  		return;
> > >  
> > 
> > > +	this_gen = READ_ONCE(lru_drain_gen);
> > > +	smp_rmb();
> > 
> > 	this_gen = smp_load_acquire(&lru_drain_gen);
> > >  
> > >  	mutex_lock(&lock);
> > >  
> > >  	/*
> > > +	 * (C) Exit the draining operation if a newer generation, from another
> > > +	 * lru_add_drain_all(), was already scheduled for draining. Check (A).
> > >  	 */
> > > +	if (unlikely(this_gen != lru_drain_gen))
> > >  		goto done;
> > >  
> > 
> > > +	WRITE_ONCE(lru_drain_gen, lru_drain_gen + 1);
> > > +	smp_wmb();
> > 
> > You can leave this smp_wmb() out and rely on the smp_mb() implied by
> > queue_work_on()'s test_and_set_bit().
> 
> This is to avoid smp_store_release() ?

store_release would have the barrier on the other end. If you read the
comments (I so helpfully cut out) you'll see it wants to order against
later stores, not ealier.
