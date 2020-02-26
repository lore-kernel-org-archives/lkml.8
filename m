Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89111C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6342084E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V7rKnQLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgBZJUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:20:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51350 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgBZJUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:20:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T5hihDBQQpHndGa1huLjobEba30S9LiISjOQ+UQG2uM=; b=V7rKnQLjdz8MCJZzThtGfkvK1y
        KhgBfrRPIVqCPgSvV2B+Z44Box+9J0bdO+fE6kzONnPts2ZssJ0VXAapeLHS8iFQqPmcoPMB+ABSp
        x9d9n/YkmwBIjJxjbJQh79aTEZG+bmph9qNo3YTfVFWfmHPsQFV6kZKt4JdX5ZkzNo4PlSJnH3GBj
        +1Z7sCty7K5gsdbAIuKYlyfvIOS7CCZMkJ2AkX4aIDPtcMyXs1tgifJcfa+tqV8ftC+78Dwt0NsOD
        YmDIriKt2j2h9xMZAlWbMSaMfpEbnRMCrnaHbZcV6rW/zYqPTK6jxsUF2nFNu5M59L4GzWnd+obxK
        dfdM3o9g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6srd-0002md-2J; Wed, 26 Feb 2020 09:20:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A09C9306060;
        Wed, 26 Feb 2020 10:18:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1272D2013DAEE; Wed, 26 Feb 2020 10:20:18 +0100 (CET)
Date:   Wed, 26 Feb 2020 10:20:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 13/16] x86/entry: Move irqflags and context tracking to C
 for simple idtentries
Message-ID: <20200226092018.GR18400@hirez.programming.kicks-ass.net>
References: <20200225223321.231477305@linutronix.de>
 <20200225224145.444611199@linutronix.de>
 <20200226080538.GO18400@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226080538.GO18400@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 09:05:38AM +0100, Peter Zijlstra wrote:
> On Tue, Feb 25, 2020 at 11:33:34PM +0100, Thomas Gleixner wrote:
> 
> > --- a/arch/x86/include/asm/idtentry.h
> > +++ b/arch/x86/include/asm/idtentry.h
> > @@ -7,14 +7,31 @@
> >  
> >  #ifndef __ASSEMBLY__
> >  
> > +#ifdef CONFIG_CONTEXT_TRACKING
> > +static __always_inline void enter_from_user_context(void)
> > +{
> > +	CT_WARN_ON(ct_state() != CONTEXT_USER);
> > +	user_exit_irqoff();
> > +}
> > +#else
> > +static __always_inline void enter_from_user_context(void) { }
> > +#endif
> > +
> >  /**
> >   * idtentry_enter - Handle state tracking on idtentry
> >   * @regs:	Pointer to pt_regs of interrupted context
> >   *
> > - * Place holder for now.
> > + * Invokes:
> > + *  - The hardirq tracer to keep the state consistent as low level ASM
> > + *    entry disabled interrupts.
> > + *
> > + *  - Context tracking if the exception hit user mode
> >   */
> >  static __always_inline void idtentry_enter(struct pt_regs *regs)
> >  {
> > +	trace_hardirqs_off();
> > +	if (user_mode(regs))
> > +		enter_from_user_context();
> >  }
> 
> So:
> 
> 	asm_exc_int3
> 	  exc_int3
> 	    idtentry_enter()
> 	      enter_from_user_context
> 	        if (context_tracking_enabled())
> 
> 	    poke_int3_handler();
> 
> Is, AFAICT, completely buggered.
> 
> You can't have a static_branch before the poke_int3_handler that deals
> with text_poke.

Forgot to say that this isn't new with this patch, just noticed it when
chasing after tracepoints.

After my patch series we can actually fix this by moving the
poke_int3_handler() before idtentry_enter().
