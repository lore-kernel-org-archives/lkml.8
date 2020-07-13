Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6870AC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4084620773
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IjL64yYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbgGMKRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 06:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbgGMKRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 06:17:51 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BD1C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 03:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ud1IsX7wO593VJeRHFjjGLfNyXPoZGi2fGXVKSaIDmc=; b=IjL64yYdvaSo01+DmeO4cZkCWO
        4isRGDwsPsROQuaTQTTRGlLR+VAQ4i5DDY5VoJaXkBBTY0z8grOaftwWp2Moh/8u5IJM/vjGvWDAa
        zWXBKH7iVn/u6wrqt1dMLVLm9eZX5396eSFh60/Xul0DLiut9Ulhzn8x78ad2incCDq0JDACcHQ6Q
        nQh69uZK1RjgQATLjS1Ar4OuPRwjGAxtBrjS9CV3YymySn9rSET76sQdnKFNn4YLMt3BRkq6uPcxV
        KVtZw0NCRmZJQNJ5jU8F8DzkUBoOkpcWm08PQ18YIsRVc6uEhbxWMpUA1f3YgK7FrKuysOA4f+08N
        4RKPIT2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1juvWU-0006rA-Gf; Mon, 13 Jul 2020 10:17:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A3935305C22;
        Mon, 13 Jul 2020 12:17:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8DA5820D27C82; Mon, 13 Jul 2020 12:17:19 +0200 (CEST)
Date:   Mon, 13 Jul 2020 12:17:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Alexandre Ghiti <alex@ghiti.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH RFC] kprobes: Remove MODULES dependency
Message-ID: <20200713101719.GD10769@hirez.programming.kicks-ass.net>
References: <20200709234521.194005-1-jarkko.sakkinen@linux.intel.com>
 <20200710090344.GX4800@hirez.programming.kicks-ass.net>
 <20200710103638.GA2614@linux.intel.com>
 <20200710104910.GG4800@hirez.programming.kicks-ass.net>
 <20200713050549.GA956284@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713050549.GA956284@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 08:05:49AM +0300, Jarkko Sakkinen wrote:
> On Fri, Jul 10, 2020 at 12:49:10PM +0200, Peter Zijlstra wrote:
> > On Fri, Jul 10, 2020 at 01:36:38PM +0300, Jarkko Sakkinen wrote:
> > > Just so that I know (and learn), what did exactly disable optprobes?
> > 
> > So regular, old-skool style kprobe is:
> > 
> >   - copy original instruction out
> >   - replace instruction with breakpoint (int3 on x86)
> >   - have exception handler return to the copied instruction with
> >     single-step on
> >   - have single step exception handler return to the original
> >     instruction stream
> > 
> > which is 2 exceptions.
> 
> Out of pure interest, how does it handle a jump (as the original
> opcode), given that it single steps a copy?

Good question, I hadn't ever looked at that detail. Anyway, I dug around
a little and it disallows 'boosting' (replacing single-step with a jmp)
for jump instructions and takes the double exception. It single steps
the original jump into 'thin-air' and does a relative fixup of the
resulting IP in the single-step exception.

For more details also see
arch/x86/kernel/kprobes/core.c:resume_execution().

> > optprobes avoid the single-step by not only writing a single
> > instruction, but additionally placing a JMP instruction behind it such
> > that it will automagically continue in the original instruction stream.
> > 
> > This brings the requirement that the copied instruction is placed
> > within the JMP displacement of the regular kernel text (s32 on x86).
> > 
> > module_alloc() ensures the memory provided is within that range.
> 
> Right, a relative jump is placed instead of 0xcc to the breakpoint?

So there's all sorts of optimizations. The one I was talking about is
apparently called boosting. That one still uses INT3 but avoids (where
possible) the single-step #DB trap by appending a JMP.d32 after it.

There's also optimized kprobes and that avoids all traps by replacing
the original instruction(s) with a JMP.d32 to a trampoline, this
trampoline calls the kprobe handler, after which it runs the original
instruction(s) and then a JMP.d32 back into where we came from.

These fully optimized kprobes have very specific constraints, best to
read the code if you want more details.

Anyway, the common theme here is that all the various optimizations rely
on the out-of-line text being withing the s32 displacement of relative
jumps.
