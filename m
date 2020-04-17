Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB6CC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B627220857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgDQPqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:46:20 -0400
Received: from foss.arm.com ([217.140.110.172]:53060 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728542AbgDQPqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:46:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F0C81FB;
        Fri, 17 Apr 2020 08:46:19 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 920063F73D;
        Fri, 17 Apr 2020 08:46:16 -0700 (PDT)
Date:   Fri, 17 Apr 2020 16:46:14 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 04/12] scs: disable when function graph tracing is
 enabled
Message-ID: <20200417154613.GB9529@lakrids.cambridge.arm.com>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200416161245.148813-1-samitolvanen@google.com>
 <20200416161245.148813-5-samitolvanen@google.com>
 <20200417100039.GS20730@hirez.programming.kicks-ass.net>
 <20200417144620.GA9529@lakrids.cambridge.arm.com>
 <20200417152645.GH20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417152645.GH20730@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 05:26:45PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 17, 2020 at 03:46:21PM +0100, Mark Rutland wrote:
> > > > diff --git a/arch/Kconfig b/arch/Kconfig
> > > > index 691a552c2cc3..c53cb9025ad2 100644
> > > > --- a/arch/Kconfig
> > > > +++ b/arch/Kconfig
> > > > @@ -542,6 +542,7 @@ config ARCH_SUPPORTS_SHADOW_CALL_STACK
> > > >  
> > > >  config SHADOW_CALL_STACK
> > > >  	bool "Clang Shadow Call Stack"
> > > > +	depends on DYNAMIC_FTRACE_WITH_REGS || !FUNCTION_GRAPH_TRACER
> > > >  	depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
> > > >  	help
> > > >  	  This option enables Clang's Shadow Call Stack, which uses a
> >  
> > > AFAICT you also need to kill KRETPROBES, which plays similar games.
> > 
> > Hmm... how does KREPROBES work? If you can only mess with the return
> > address when probing the first instruction in the function, it'll just
> > work for SCS or pointer authentication, as the LR is used at that
> > instant. If KRETPROBES tries to mess with the return address elsewhere
> > it'd be broken today...
> 
> To be fair, I've not looked at the arm64 implementation. x86 does gross
> things like ftrace does. On x86 ftrace_graph and kretprobe also can't
> be on at the same time for the same function, there's some yuck around
> there.

I can imagine the same holds true for us there.

> Rostedt was recently talking about cleaning some of that up.
> 
> But if kretprobe can work on arm64, then ftrace_graph can too, but I
> think that links back to what you said earlier, you didn't want more
> ftrace variants or something.

I just want to avoid yet another implementation of the underlying
mechanism. For DYNAMIC_FTRACE_WITH_REGS we can mess with the LR before
pauth or SCS sees it, so those definitely work.

If KRETPROBES works by messing with the LR at the instnat the function
is entered, that should work similarly. If it works by replacing the
RET it should also work out since any pauth/SCS work will have been
undone by that point. If it attempts to mess with the return address in
the middle of a function then it's not reliable today.

I'll take a look, since 

> > > And doesn't BPF also do stuff like this?
> > 
> > Can BPF mess with return addresses now!?
> 
> At least on x86 I think it does. But what do I know, I can't operate
> that stuff. Rostedt might know.

Sounds like I might need to do some digging...

Mark.
