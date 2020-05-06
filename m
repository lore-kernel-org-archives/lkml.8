Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB10C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC14920A8B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tegACdaT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgEFPhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgEFPhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:37:13 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAEFC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 08:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GPDrA7f6ewa5DbM6eUJZPi4TI0TortJaQKq7s/AtH4M=; b=tegACdaTWcogPCo3Sq3paz3gQR
        05bZnZFF6rineOCYJnSilD2RBbE+qTkvI5o7JwKYrTP02Ysl+Abtfyb3R9VRfnfR2ORSMaOOe9Rci
        89mKSdfNhTnY9pgXHuPKdAhsCRPTcrw5Y+Tkgj+fDnfbhOKeCmtFeL+3fJg5qSg2AV+ajMj4Rl0Yt
        1+x2RyAzufDy2ymrKJcWYIARKlmPjXsYlwMgKNH20fUbRJQ3ZC2U48FmUvtf2ehztNWPO1kLxWNsn
        EFA6PxfWjL2HVuqkBSP6eyPEE442aqcBBSOTV30Pe8FcM2UUeD331v6znWgmPYQrRRWn30KcedsJE
        7ny9gMIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWM6C-0004qN-Q0; Wed, 06 May 2020 15:36:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 94C083024EA;
        Wed,  6 May 2020 17:36:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 86B18203ECDC1; Wed,  6 May 2020 17:36:39 +0200 (CEST)
Date:   Wed, 6 May 2020 17:36:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [patch V4 part 1 06/36] compiler: Simple READ/WRITE_ONCE()
 implementations
Message-ID: <20200506153639.GD5281@hirez.programming.kicks-ass.net>
References: <20200505131602.633487962@linutronix.de>
 <20200505134058.651504242@linutronix.de>
 <20200506133333.GK8043@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506133333.GK8043@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 02:33:33PM +0100, Will Deacon wrote:
> On Tue, May 05, 2020 at 03:16:08PM +0200, Thomas Gleixner wrote:
> > READ/WRITE_ONCE_NOCHECK() is required for atomics in code which cannot be
> > instrumented like the x86 int3 text poke code. As READ/WRITE_ONCE() is
> > undergoing a rewrite, provide __{READ,WRITE}_ONCE_SCALAR().
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  include/linux/compiler.h |    8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -313,6 +313,14 @@ unsigned long read_word_at_a_time(const
> >  	__u.__val;					\
> >  })
> >  
> > +#define __READ_ONCE_SCALAR(x)				\
> > +	(*(const volatile typeof(x) *)&(x))
> > +
> > +#define __WRITE_ONCE_SCALAR(x, val)			\
> > +do {							\
> > +	*(volatile typeof(x) *)&(x) = val;		\
> > +} while (0)
> 
> FWIW, these end up being called __READ_ONCE() and __WRITE_ONCE() after
> the rewrite; the *_SCALAR() variants will call into kcsan_check_atomic_*().
> 
> If you go with that naming now, then any later conflict should fall out in
> the wash.

Ah excellent, clearly we had slightly different resoltions vs kcsan.
Thanks!
