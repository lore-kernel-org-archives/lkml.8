Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E8EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F4992075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lNIV2LUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgESIfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 04:35:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50702 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgESIfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 04:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QwmitSwlirACqCyCNTRUZhDaJ4HYS/kaW8Cx57bX5c8=; b=lNIV2LUUjHNOY9YH9V1SHZvupD
        Ap9O81Ry9Mm7QRxv1ir9txOzUjABze72YWF4n+e8jqzVQPpOz2Y0k1MmDdIem/y+1xlA+52ci/GBr
        VhJgaAxUx6I8Pg8EKqkDJhytF0BSAvxYY8F35JnXJDYpJXdc/fpka+wNKxUlBo4ZaW9kOSumZRxwM
        gKB/gcUCuqJkWEkWT/BdfO6O4Emzg6cUb6jUonsMqRKDT0LOMPDGPTFrM/zHqvdgFJG4hF0ZYeAHA
        PyG8RS7VYQpLmw+y265BUaXen5nOl2xMNwH1nvP2Qiz8LHKmvzOVpG3SLpwUxDRCINsZ9jcDhybYT
        ZjTch/FA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jaxd4-0006F1-1E; Tue, 19 May 2020 08:29:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8C8AB304A59;
        Tue, 19 May 2020 10:29:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 47C4C29E21566; Tue, 19 May 2020 10:29:26 +0200 (CEST)
Date:   Tue, 19 May 2020 10:29:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
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
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [patch V6 00/37] x86/entry: Rework leftovers and merge plan
Message-ID: <20200519082926.GB279861@hirez.programming.kicks-ass.net>
References: <20200515234547.710474468@linutronix.de>
 <20200518160750.GA279861@hirez.programming.kicks-ass.net>
 <87h7wdvzuq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7wdvzuq.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 08:53:49PM +0200, Thomas Gleixner wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> > So on top of you entry-v8-full; I had to chase one of those
> > instrumentation_end() escapes an (extended) basic block chase (again!).
> >  
> > +#ifdef CONFIG_DEBUG_ENTRY
> 
> Why this? We lose the kprobes runtime protection that way.

Oh bugger indeed. I forgot about that :-(

I added the CONFIG_DEBUG_ENTRY dependency to
instrumentation_{begin,end}() because they now emit actual code, and I
figured we shouldn't bother 'production' kernels with all them extra
NOPs.

And then I figured (wrongly!) that since I have that, I might as well
add noinstr to is.

> > +/* Section for code which can't be instrumented at all */
> > +#define noinstr								\
> > +	noinline notrace __attribute((__section__(".noinstr.text")))
> > +
> >  /* Begin/end of an instrumentation safe region */
> > -#define instrumentation_begin() ({						\
> > +#define instrumentation_begin() ({					\
> >  	asm volatile("%c0:\n\t"						\
> >  		     ".pushsection .discard.instr_begin\n\t"		\
> >  		     ".long %c0b - .\n\t"				\
> >  		     ".popsection\n\t" : : "i" (__COUNTER__));
> 
> Nifty.

Yeah, took a bit of fiddling because objtool is a bit weird vs UD2, but
if you order it just right in the WARN thing it works :-)

You want a new delta without the noinstr thing on?
