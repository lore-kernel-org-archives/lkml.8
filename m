Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1722C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EA9D20857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PsghyDdO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgDQP11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728542AbgDQP11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:27:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C298C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 08:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Yqtf2Cr9VCQpUS0GldnV7JK60DFB1BUHRTQDFzdrac0=; b=PsghyDdOxbKQz5ubAHKB+S1KQ1
        4WGvoF0mQLZg7hUM7fMf8NP5ldMyeI3yCYJx6RLRak2X5e+/Q9xDAZRUP0QQU9W1n2QQPTfGOggc1
        7CqiU9OJaaxVW+QPFi4Dyfve2Njq9xOAD+9mHA8/u+KFHkSdq1bH9aDEzeFKrnuisXCs6Ycf4toKF
        88xJh20yh3d3gSYbH10L6SP20nwScbLCX/6eZFXn2BOF4GtsdEOGKzF6nUJuak+7+vX9OIjbkXrE0
        DUV9lrpFh2d5OVlZ+pHRjXK3TL/SFRewlLfAK1go3ND7b0enqZh42kTCvyg04auwwc3DAZLklUu69
        Lr0cyH0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPStE-0008Sz-Ht; Fri, 17 Apr 2020 15:26:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DF502304E03;
        Fri, 17 Apr 2020 17:26:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BFFE02B12192B; Fri, 17 Apr 2020 17:26:45 +0200 (CEST)
Date:   Fri, 17 Apr 2020 17:26:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
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
Message-ID: <20200417152645.GH20730@hirez.programming.kicks-ass.net>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200416161245.148813-1-samitolvanen@google.com>
 <20200416161245.148813-5-samitolvanen@google.com>
 <20200417100039.GS20730@hirez.programming.kicks-ass.net>
 <20200417144620.GA9529@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417144620.GA9529@lakrids.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 03:46:21PM +0100, Mark Rutland wrote:
> > > diff --git a/arch/Kconfig b/arch/Kconfig
> > > index 691a552c2cc3..c53cb9025ad2 100644
> > > --- a/arch/Kconfig
> > > +++ b/arch/Kconfig
> > > @@ -542,6 +542,7 @@ config ARCH_SUPPORTS_SHADOW_CALL_STACK
> > >  
> > >  config SHADOW_CALL_STACK
> > >  	bool "Clang Shadow Call Stack"
> > > +	depends on DYNAMIC_FTRACE_WITH_REGS || !FUNCTION_GRAPH_TRACER
> > >  	depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
> > >  	help
> > >  	  This option enables Clang's Shadow Call Stack, which uses a
>  
> > AFAICT you also need to kill KRETPROBES, which plays similar games.
> 
> Hmm... how does KREPROBES work? If you can only mess with the return
> address when probing the first instruction in the function, it'll just
> work for SCS or pointer authentication, as the LR is used at that
> instant. If KRETPROBES tries to mess with the return address elsewhere
> it'd be broken today...

To be fair, I've not looked at the arm64 implementation. x86 does gross
things like ftrace does. On x86 ftrace_graph and kretprobe also can't
be on at the same time for the same function, there's some yuck around
there.

Rostedt was recently talking about cleaning some of that up.

But if kretprobe can work on arm64, then ftrace_graph can too, but I
think that links back to what you said earlier, you didn't want more
ftrace variants or something.

> > And doesn't BPF also do stuff like this?
> 
> Can BPF mess with return addresses now!?

At least on x86 I think it does. But what do I know, I can't operate
that stuff. Rostedt might know.
