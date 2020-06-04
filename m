Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04C7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A68AB2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z/jlrBjK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgFDIFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgFDIFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:05:36 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BCBC05BD1E
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 01:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KNW9NL3uD47FUjnpw82UUardVK7E6+mLshnuYV72GPY=; b=Z/jlrBjKW0MRevBunVgGpP3jxt
        9zJmaTnmIvj7HFbmAOIvv4XWEeGYATe/HU2elxWGE8vfdjJ72zSzTDkJf9JFeEGGpDoKpo/wC7X/e
        v9nahNm2MloAxtMNgTskxxRt9vBYLkiXLVOxnPjPoS6ngb3v8QktpPl99X3camS3Z59VJQA00+VJq
        8g/yIJ4zUwgPF7yn5ziabEvp4J/meFJdJbTG8zAhNqcsMvSXOc1EBfE43GLLzienRwx2sltACZs1i
        9W3b+bljl/zwWevxmETiS7pbqgbOhzotTwrN+KtCsQJUbgqhZPi/6t+S62Y+lLQUp2ZkS0lSdc91q
        J4DsKyQQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgksE-0000Go-TI; Thu, 04 Jun 2020 08:05:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 45B8D301DFD;
        Thu,  4 Jun 2020 10:05:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 31B5620CC68B2; Thu,  4 Jun 2020 10:05:12 +0200 (CEST)
Date:   Thu, 4 Jun 2020 10:05:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     tglx@linutronix.de, x86@kernel.org, elver@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        will@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com
Subject: Re: [PATCH 2/9] rcu: Fixup noinstr warnings
Message-ID: <20200604080512.GA2587@hirez.programming.kicks-ass.net>
References: <20200603114014.152292216@infradead.org>
 <20200603114051.896465666@infradead.org>
 <20200603164600.GQ29598@paulmck-ThinkPad-P72>
 <20200603171320.GE2570@hirez.programming.kicks-ass.net>
 <20200604033409.GX29598@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604033409.GX29598@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 08:34:09PM -0700, Paul E. McKenney wrote:
> On Wed, Jun 03, 2020 at 07:13:20PM +0200, Peter Zijlstra wrote:
> > On Wed, Jun 03, 2020 at 09:46:00AM -0700, Paul E. McKenney wrote:

> > > > @@ -313,7 +313,7 @@ static __always_inline bool rcu_dynticks
> > > >  {
> > > >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > > >  
> > > > -	return !(atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR);
> > > > +	return !(arch_atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR);
> > 
> > The above is actually instrumented by KCSAN, due to arch_atomic_read()
> > being a READ_ONCE() and it now understanding volatile.
> > 
> > > Also instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks)) as
> 
> Right, this should instead be instrument_read(...).
> 
> Though if KCSAN is unconditionally instrumenting volatile, how does
> this help?  Or does KCSAN's instrumentation of volatile somehow avoid
> causing trouble?

As Marco already explained, when used inside noinstr no instrumentation
will be emitted, when used outside noinstr it will emit the right
instrumentation.

> > > o	In theory in rcu_irq_exit_preempt(), but as this generates code
> > > 	only in lockdep builds, it might not be worth worrying about.
> > > 
> > > o	Ditto for rcu_irq_exit_check_preempt().
> > > 
> > > o	Ditto for __rcu_irq_enter_check_tick().
> > 
> > Not these, afaict they're all the above arch_atomic_read(), which is
> > instrumented due to volatile in these cases.

I this case, the above call-sites are all not noinstr (double negative!)
and will thus cause instrumentation to be emitted.

This is all a 'special' case for arch_atomic_read() (and _set()),
because they're basically READ_ONCE() (and WRITE_ONCE() resp.). The
normal atomics are asm() and it doesn't do anything for those (although
I suppose clang could, since it has this internal assembler to parse the
inline asm, but afaiu that's not something GCC ever wants to do).
