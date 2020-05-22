Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E5CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 15:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26FB62065C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 15:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbgEVPRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 11:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729929AbgEVPRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 11:17:12 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88F7C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 08:17:11 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jc9Q1-0007ZR-HW; Fri, 22 May 2020 17:17:05 +0200
Date:   Fri, 22 May 2020 17:17:05 +0200
From:   "Sebastian A. Siewior" <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20200522151705.vwfua5a4lhzcagea@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200519214547.352050-3-a.darwish@linutronix.de>
 <20200522145707.GO325280@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200522145707.GO325280@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-22 16:57:07 [+0200], Peter Zijlstra wrote:
> > @@ -725,21 +735,48 @@ void lru_add_drain_all(void)
> >  	if (WARN_ON(!mm_percpu_wq))
> >  		return;
> >  
> 
> > +	this_gen = READ_ONCE(lru_drain_gen);
> > +	smp_rmb();
> 
> 	this_gen = smp_load_acquire(&lru_drain_gen);
> >  
> >  	mutex_lock(&lock);
> >  
> >  	/*
> > +	 * (C) Exit the draining operation if a newer generation, from another
> > +	 * lru_add_drain_all(), was already scheduled for draining. Check (A).
> >  	 */
> > +	if (unlikely(this_gen != lru_drain_gen))
> >  		goto done;
> >  
> 
> > +	WRITE_ONCE(lru_drain_gen, lru_drain_gen + 1);
> > +	smp_wmb();
> 
> You can leave this smp_wmb() out and rely on the smp_mb() implied by
> queue_work_on()'s test_and_set_bit().

This is to avoid smp_store_release() ?

Sebastian
