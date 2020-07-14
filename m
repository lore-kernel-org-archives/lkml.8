Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA56C433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C836321D7D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KcKwB+in"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgGNJyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgGNJyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:54:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6211FC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 02:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rI8ZkdxzAGxRqivQR1biIpq+VnvU8V+UKoGMFvEGLU4=; b=KcKwB+inVWdkrv7Tx+s0bj+fO1
        +E86Owrg0QaSYtm6O2sH30fs6cUAjZP10Lzgp0xlAIx2erdNE02aOvOgMedTWZST5yb9i08Ky2YaD
        daiehXc+RDK6tIICkcuOJpuwG8JnYPqarmrJULhSsqJRsCDgL9tuC30HlhDG1tM79geZ57wiYaUqX
        8Z02SkzTpD9Ez/rHKDMyy1uA3FiJGEB62e5M4n62JXVO82/TWgZdUZG+kAoGBqMNPsy+gDKDgyfoI
        E71IDo/DeIR/e4nlrFROTH6/mz+TW5cxwMn6vh5X1+ANUzJ4Xa679hgIkIJxPVH/sT0wbSQ0lNvKN
        yIva8Ppg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvHdA-0003Db-OS; Tue, 14 Jul 2020 09:53:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AAF28300130;
        Tue, 14 Jul 2020 11:53:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 82DE628B9107B; Tue, 14 Jul 2020 11:53:42 +0200 (CEST)
Date:   Tue, 14 Jul 2020 11:53:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v6 13/17] static_call: Add static_call_cond()
Message-ID: <20200714095342.GT10769@hirez.programming.kicks-ass.net>
References: <20200710133831.943894387@infradead.org>
 <20200710134336.918547865@infradead.org>
 <20200710190825.02c75c04@oasis.local.home>
 <20200711104930.GE597537@hirez.programming.kicks-ass.net>
 <20200713163239.5701f5d1@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713163239.5701f5d1@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 04:32:39PM -0400, Steven Rostedt wrote:
> On Sat, 11 Jul 2020 12:49:30 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > Something like so (on top of the next patch) ?
> > 
> > I'm not convinced it actually helps much, but if it makes you feel
> > better :-)
> 
> After you have bricked a bunch of people's NICs, you would be paranoid
> about this too!
> 
> You work for Intel, next time you go to an office, see if you can find
> my picture on any dartboards in there ;-)

I'll tell em it was bad hardware for being able to get bricked like that
instead, how's that? ;-)

> > --- a/arch/x86/kernel/static_call.c
> > +++ b/arch/x86/kernel/static_call.c
> > @@ -56,15 +56,36 @@ static inline enum insn_type __sc_insn(b
> >  	return 2*tail + null;
> >  }
> >  
> > +static void __static_call_validate(void *insn, bool tail)
> > +{
> > +	u8 opcode = *(u8 *)insn;
> > +
> > +	if (tail) {
> > +		if (opcode == JMP32_INSN_OPCODE ||
> > +		    opcode == RET_INSN_OPCODE)
> > +			return;
> > +	} else {
> > +		if (opcode == CALL_INSN_OPCODE ||
> > +		    !memcmp(insn, ideal_nops[NOP_ATOMIC5], 5))
> > +			return;
> > +	}
> > +
> > +	WARN_ONCE(1, "unexpected static_call insn opcode 0x%x at %pS\n", opcode, insn);
> > +}
> > +
> >  void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
> >  {
> >  	mutex_lock(&text_mutex);
> >  
> > -	if (tramp)
> > +	if (tramp) {
> > +		__static_call_validate(tramp, true);
> >  		__static_call_transform(tramp, __sc_insn(!func, true), func);
> > +	}
> >  
> > -	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE) && site)
> > +	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE) && site) {
> > +		__static_call_validate(site, tail);
> 
> I'd feel even more better if the validate failed, we just don't do the
> update.

It is either this or BUG()/panic(), you pick ;-)
