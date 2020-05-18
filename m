Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBB5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 454DA207D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CxtilwHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgERIKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 04:10:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56720 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgERIKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 04:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Iqm24iEcNucTMf6Splm9sZE31pThskAEE0cgautDMiA=; b=CxtilwHRWrNOBYZqwwg63gS68t
        zfiFiPm0vagijAvdVfx3a1AMm1nlTz8fkXw7mt8X/YMhiRtmNL8jGMgonq13QHfGmgun8wTaBWqhg
        SYxW/+LrdoeX7B3ihWGRweAm5ZW4I2hibuF42qRBaEnKRcGch8hmCDbZ48TJlbAqmG3SWeBUbQIhr
        iuYAL7yOC8m0xDWFr9vpKEXh1c58RV6pQWhtgWKSRSUvYmW13v0YovB4E8zuGxC3QBnEWv3vn72KB
        0z6kctMotILE430FP6CvS+yKlkSqAYujqXv/nQuqjKpv4ytJ1ydYoZOux2AF4jm7nBfXTtvmVKD5R
        nhSQe2OA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jaaoq-0003ab-HU; Mon, 18 May 2020 08:08:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 53F92306089;
        Mon, 18 May 2020 10:08:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0D79B2B3CDC70; Mon, 18 May 2020 10:08:14 +0200 (CEST)
Date:   Mon, 18 May 2020 10:08:14 +0200
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
Subject: Re: [patch V6 04/37] x86: Make hardware latency tracing explicit
Message-ID: <20200518080814.GJ2940@hirez.programming.kicks-ass.net>
References: <20200515234547.710474468@linutronix.de>
 <20200515235124.783722942@linutronix.de>
 <20200518080133.GI2940@hirez.programming.kicks-ass.net>
 <874ksdzmzf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874ksdzmzf.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 10:05:56AM +0200, Thomas Gleixner wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> > On Sat, May 16, 2020 at 01:45:51AM +0200, Thomas Gleixner wrote:
> >> --- a/arch/x86/kernel/nmi.c
> >> +++ b/arch/x86/kernel/nmi.c
> >> @@ -334,6 +334,7 @@ static noinstr void default_do_nmi(struc
> >>  	__this_cpu_write(last_nmi_rip, regs->ip);
> >>  
> >>  	instrumentation_begin();
> >> +	ftrace_nmi_handler_enter();
> >>  
> >>  	handled = nmi_handle(NMI_LOCAL, regs);
> >>  	__this_cpu_add(nmi_stats.normal, handled);
> >> @@ -420,6 +421,7 @@ static noinstr void default_do_nmi(struc
> >>  		unknown_nmi_error(reason, regs);
> >>  
> >>  out:
> >> +	ftrace_nmi_handler_exit();
> >>  	instrumentation_end();
> >>  }
> >
> > Yeah, so I'm confused about this and the previous patch too. Why not
> > do just this? Remove that ftrace_nmi_handler.* crud from
> > nmi_{enter,exit}() and stick it here? Why do we needs the
> > nmi_{enter,exit}_notrace() thing?
> 
> Because you then have to fixup _all_ architectures which use
> nmi_enter/exit().

We probably have to anyway. But I can do that later I suppose.
