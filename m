Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E403C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 17:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46602207FC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 17:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CwCGk+Hs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgHDRDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 13:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbgHDRCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 13:02:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA6FC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 10:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZJzXwOxbCfW8r8F6D6OIBH2hwsyGZnD1BkGyF7iIWDw=; b=CwCGk+Hs8UrOvgV3xxite97qfY
        PQAryBv0z8bbjhJ0/ylCabUh7eBXLJx3/xTWSb9Sj04b2mmOrMfn0ZDhN+b+W2t+OoOowvFJNzvc1
        DiDEuHL3GqviNbY6ZKk5BPHtuD/r5itHHrF3UBzSdUsk4nAmYawx45aM1j3+4PQS0UKQTOM9mM8Ta
        d6WtctMWpFZCZK8pmrO/WivExlSrj+cGaOi739Zt85BR0VzpvRZW4AGOHDgophJR2uVGiyo21q1Sy
        GMQbRKqx6Qe7xzIi5iup6AcN+9xpp6s+ltu4XMS1r+lam8+Mmhqx1J7H3W+dXAAyKVW1xMvJc8qm2
        yRjUs5mA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k30K2-000535-UI; Tue, 04 Aug 2020 17:01:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AAC1E301A66;
        Tue,  4 Aug 2020 19:01:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 81A032B90EB46; Tue,  4 Aug 2020 19:01:53 +0200 (CEST)
Date:   Tue, 4 Aug 2020 19:01:53 +0200
From:   peterz@infradead.org
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 2/2] sched: membarrier: cover kthread_use_mm
Message-ID: <20200804170153.GO2657@hirez.programming.kicks-ass.net>
References: <20200728160010.3314-1-mathieu.desnoyers@efficios.com>
 <20200728160010.3314-2-mathieu.desnoyers@efficios.com>
 <20200804145145.GM2657@hirez.programming.kicks-ass.net>
 <1708074166.39992.1596553173337.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1708074166.39992.1596553173337.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 10:59:33AM -0400, Mathieu Desnoyers wrote:
> ----- On Aug 4, 2020, at 10:51 AM, Peter Zijlstra peterz@infradead.org wrote:
> > On Tue, Jul 28, 2020 at 12:00:10PM -0400, Mathieu Desnoyers wrote:

> >>  	task_lock(tsk);
> >> +	/*
> >> +	 * When a kthread stops operating on an address space, the loop
> >> +	 * in membarrier_{private,global}_expedited() may not observe
> >> +	 * that tsk->mm, and not issue an IPI. Membarrier requires a
> >> +	 * memory barrier after accessing user-space memory, before
> >> +	 * clearing tsk->mm.
> >> +	 */
> >> +	smp_mb();
> >>  	sync_mm_rss(mm);
> >>  	local_irq_disable();
> > 
> > Would it make sense to put the smp_mb() inside the IRQ disable region?
> 
> I've initially placed it right after task_lock so we could eventually
> have a smp_mb__after_non_raw_spinlock or something with a much better naming,
> which would allow removing the extra barrier when it is implied by the
> spinlock.

Oh, right, fair enough. I'll go think about if smp_mb__after_spinlock()
will work for mutexes too.

It basically needs to upgrade atomic*_acquire() to smp_mb(). So that's
all architectures that have their own _acquire() and an actual
smp_mb__after_atomic().

Which, from the top of my head are only arm64, power and possibly riscv.
And if I then git-grep smp_mb__after_spinlock, all those seem to be
covered.

But let me do a better audit..
