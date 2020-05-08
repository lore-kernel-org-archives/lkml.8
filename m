Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B662C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2627120731
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eJR2hVqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgEHI7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgEHI7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:59:46 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C13C05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 01:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UfGx38+9SPoHmQP8CC+ox/bYJfMTGqebo8LnVqZgVDM=; b=eJR2hVquXIeQmSloH7/BYjJIyL
        zCo2BBfDa/pTVRdt6/rlMB36uR8FqUGXJrjwKk6ASbvHTiMhwWVYf6B5gvGcE7PEusj/0XCDUDslN
        wabpLFEQNhIwd14QhOo1aYWb/C+/p6vKoTtGSSmsIpfJWRBGPyNt2FpwbGFMCRIMi5XqL/1MVf2Th
        X21rCSyVMEz8CJ8fzvqRAba4eafy+1aoh8FikoKFB0soAS8JlPj+fvuX3nKGbqm0QD6Dx8I3QuR/E
        GlGeavif47GWl+U7tUAeUy+2cGoih9Gc0kq5JkUijSImRkSKAVyrO8m+gjM9IFi0zw1CxEktk9kSl
        cfXWiiDA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWyqd-0004k3-9U; Fri, 08 May 2020 08:59:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A785030018B;
        Fri,  8 May 2020 10:59:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B9702B93BDC1; Fri,  8 May 2020 10:59:09 +0200 (CEST)
Date:   Fri, 8 May 2020 10:59:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 4 15/24] x86/db: Split out dr6/7 handling
Message-ID: <20200508085909.GU5298@hirez.programming.kicks-ass.net>
References: <20200505134926.578885807@linutronix.de>
 <20200505135314.808628211@linutronix.de>
 <16c57a7e-8d39-d77e-915d-41b7f5e042fd@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16c57a7e-8d39-d77e-915d-41b7f5e042fd@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 07:18:45PM +0200, Alexandre Chartre wrote:
> 
> On 5/5/20 3:49 PM, Thomas Gleixner wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > DR6/7 should be handled before nmi_enter() is invoked and restore after
> > nmi_exit() to minimize the exposure.
> > 
> > Split it out into helper inlines and bring it into the correct order.
> > 
> > Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >   arch/x86/kernel/hw_breakpoint.c |    6 ---
> >   arch/x86/kernel/traps.c         |   62 +++++++++++++++++++++++++++-------------
> >   2 files changed, 44 insertions(+), 24 deletions(-)
> > 
> ...
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -691,6 +691,44 @@ static bool is_sysenter_singlestep(struc
> >   #endif
> >   }
> > +static __always_inline void debug_enter(unsigned long *dr6, unsigned long *dr7)
> > +{
> > +	/*
> > +	 * Disable breakpoints during exception handling; recursive exceptions
> > +	 * are exceedingly 'fun'.
> > +	 *
> > +	 * Since this function is NOKPROBE, and that also applies to
> > +	 * HW_BREAKPOINT_X, we can't hit a breakpoint before this (XXX except a
> > +	 * HW_BREAKPOINT_W on our stack)
> > +	 *
> > +	 * Entry text is excluded for HW_BP_X and cpu_entry_area, which
> > +	 * includes the entry stack is excluded for everything.
> > +	 */
> > +	get_debugreg(*dr7, 6);
> 
> Do you mean  get_debugreg(*dr7, 7); ?

Shees, I have to go buy a new stack of brown paper bags at this rate,
don't I :/
