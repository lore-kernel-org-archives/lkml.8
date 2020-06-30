Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A311C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36F27206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YxYVnapP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbgF3Jl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 05:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731939AbgF3Jl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 05:41:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B889CC03E979;
        Tue, 30 Jun 2020 02:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ObiET+eN9wPISA69yMBAjLsRR+NFaZ4l0xk8JBk7804=; b=YxYVnapPrNLDtKA1tIbiaacSX5
        ZAYioY8ULLtGnawpbkokHrxzK+nUrSkEF0L09yUL8NLcQdrEpxv7PMoMmS6qf8unE1c5M2AhC0TU/
        1cY7d/vUPxWxB+SRzRxgdSjYXnTbXUlhczgIMZvS/cInvnmDeoIcS1G7ikHH+rj+PlXkDbwFuoUHz
        tb8903egHL1o5Nbw6dvVBCBkcCfRA/qz/W3unSbaTs7QP3ecC/6V1h9WMCbcQl+hJUBbYW39j0KHw
        JD+4egP8OPWq0pUvcxFGGKFFx2ano6jdwqVG+BFTkOahPzwI+V6dH/FmiFRYeplwMXqNG4jjxVX8p
        UC+CT2mg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqCka-0004MK-9L; Tue, 30 Jun 2020 09:40:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 835593013E5;
        Tue, 30 Jun 2020 11:40:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 703772147FFB9; Tue, 30 Jun 2020 11:40:19 +0200 (CEST)
Date:   Tue, 30 Jun 2020 11:40:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     mingo@kernel.org, will@kernel.org, tglx@linutronix.de,
        x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        bigeasy@linutronix.de, davem@davemloft.net,
        sparclinux@vger.kernel.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com,
        linux-s390@vger.kernel.org, linux@armlinux.org.uk
Subject: Re: [PATCH v4 7/8] lockdep: Change hardirq{s_enabled,_context} to
 per-cpu variables
Message-ID: <20200630094019.GL4800@hirez.programming.kicks-ass.net>
References: <20200623083645.277342609@infradead.org>
 <20200623083721.512673481@infradead.org>
 <20200630055939.GA3676007@debian-buster-darwi.lab.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630055939.GA3676007@debian-buster-darwi.lab.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 07:59:39AM +0200, Ahmed S. Darwish wrote:
> Peter Zijlstra wrote:
> 
> ...
> 
> > -#define lockdep_assert_irqs_disabled()	do {			\
> > -		WARN_ONCE(debug_locks && !current->lockdep_recursion &&	\
> > -			  current->hardirqs_enabled,			\
> > -			  "IRQs not disabled as expected\n");		\
> > -	} while (0)
> 
> ...
> 
> > +#define lockdep_assert_irqs_disabled()				\
> > +do {									\
> > +	WARN_ON_ONCE(debug_locks && this_cpu_read(hardirqs_enabled));	\
> > +} while (0)
> 
> I think it would be nice to keep the "IRQs not disabled as expected"
> message. It makes the lockdep splat much more readable.
> 
> This is similarly the case for the v3 lockdep preemption macros:
> 
>   https://lkml.kernel.org/r/20200630054452.3675847-5-a.darwish@linutronix.de
> 
> I did not add a message though to get in-sync with the IRQ macros above.

Hurmph.. the file:line output of a splat is usually all I look at, also
__WARN_printf() generates such atrocious crap code that try and not use
it.

I suppose I should do a __WARN_str() or something, but then people are
unlikely to want to use that, too much variation etc. :/

Cursed if you do, cursed if you don't.
