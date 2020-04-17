Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6C9C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 254A22223C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgDQOqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 10:46:35 -0400
Received: from foss.arm.com ([217.140.110.172]:52198 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbgDQOqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:46:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D964330E;
        Fri, 17 Apr 2020 07:46:33 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 061A33F73D;
        Fri, 17 Apr 2020 07:46:30 -0700 (PDT)
Date:   Fri, 17 Apr 2020 15:46:21 +0100
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
Message-ID: <20200417144620.GA9529@lakrids.cambridge.arm.com>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200416161245.148813-1-samitolvanen@google.com>
 <20200416161245.148813-5-samitolvanen@google.com>
 <20200417100039.GS20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417100039.GS20730@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri, Apr 17, 2020 at 12:00:39PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 16, 2020 at 09:12:37AM -0700, Sami Tolvanen wrote:
> > The graph tracer hooks returns by modifying frame records on the
> > (regular) stack, but with SCS the return address is taken from the
> > shadow stack, and the value in the frame record has no effect. As we
> > don't currently have a mechanism to determine the corresponding slot
> > on the shadow stack (and to pass this through the ftrace
> > infrastructure), for now let's disable SCS when the graph tracer is
> > enabled.
> > 
> > With SCS the return address is taken from the shadow stack and the
> > value in the frame record has no effect. The mcount based graph tracer
> > hooks returns by modifying frame records on the (regular) stack, and
> > thus is not compatible. The patchable-function-entry graph tracer
> > used for DYNAMIC_FTRACE_WITH_REGS modifies the LR before it is saved
> > to the shadow stack, and is compatible.
> > 
> > Modifying the mcount based graph tracer to work with SCS would require
> > a mechanism to determine the corresponding slot on the shadow stack
> > (and to pass this through the ftrace infrastructure), and we expect
> > that everyone will eventually move to the patchable-function-entry
> > based graph tracer anyway, so for now let's disable SCS when the
> > mcount-based graph tracer is enabled.
> > 
> > SCS and patchable-function-entry are both supported from LLVM 10.x.
> 
> SCS would actually provide another way to do return hooking. An arguably
> much saner model at that.
> 
> The 'normal' way is to (temporary) replace the on-stack return value,
> and then replace it back in the return handler. This is because we can't
> simply push a fake return on the stack, because that would wreck the
> expected stack layout of the regular function.
> 
> But there is nothing that would stop us from pushing an extra entry on
> the SCS. It would in fact be a much cleaner solution. The entry hook
> sticks an extra entry on the SCS, the function ignores what's on the
> normal stack and pops from the SCS, we return to the exit handler, which
> in turn pops from the SCS stack at which point we're back to regular.

For background: on arm64 we wanted to use DYNAMIC_FTRACE_WITH_REGS since
we already have to use that to handle pointer authentication, and didn't
want to gain more ways of implementing ftrace.

Arguably we should move the dependency into the arm64 Kconfig for
ARCH_SUPPORTS_SHADOW_CALL_STACK.

> The only 'funny' is that the exit handler itself should not push to the
> SCS, or we should frob the return-to-exit-handler such that it lands
> after the push.
> 
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> > ---
> >  arch/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 691a552c2cc3..c53cb9025ad2 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -542,6 +542,7 @@ config ARCH_SUPPORTS_SHADOW_CALL_STACK
> >  
> >  config SHADOW_CALL_STACK
> >  	bool "Clang Shadow Call Stack"
> > +	depends on DYNAMIC_FTRACE_WITH_REGS || !FUNCTION_GRAPH_TRACER
> >  	depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
> >  	help
> >  	  This option enables Clang's Shadow Call Stack, which uses a
 
> AFAICT you also need to kill KRETPROBES, which plays similar games.

Hmm... how does KREPROBES work? If you can only mess with the return
address when probing the first instruction in the function, it'll just
work for SCS or pointer authentication, as the LR is used at that
instant. If KRETPROBES tries to mess with the return address elsewhere
it'd be broken today...

> And doesn't BPF also do stuff like this?

Can BPF mess with return addresses now!?

Thanks,
Mark.
