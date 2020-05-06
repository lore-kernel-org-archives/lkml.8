Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1566C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9607206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZVZfWssV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbgEFQT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729239AbgEFQT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:19:26 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E21DC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 09:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5mLMqArBW6jfYF76Y9dmQCS1j4NzrBHjUeYojdIbkfo=; b=ZVZfWssVFJEVUhUMfYX0vnZGSG
        JeVMiXeUfkUhUl5IY9mGmlv7ffd2UtQ35YDWAA9sn0Lvb73fpzSpm7MLJ2Wi//itVW9a16aLkfc1O
        tQT5MWXK0Vddk1UoHs4Pw6hatzgOjEHrFTXw6qm6fZNi0vBz4HA+0mprVYOLfzasAcNeumH1qP8nI
        J9wbpxd3p810ti+I5sASRPjH7Y9n1Z9994wzt3FdxJvoiOlJaLaaR5xBF1biyeC/m1N3FjMdo1RYL
        i6GNYnfW2nCTr3JsoXD5H1Y9WX3MC71I/8oJtxsRdT02l8w4+z3at+gdYcmaktEwTHRfeC5jLBxtw
        8xIuiaCw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWMl0-00066N-Ou; Wed, 06 May 2020 16:18:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 397C4300238;
        Wed,  6 May 2020 18:18:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 198A9203ECDC2; Wed,  6 May 2020 18:18:49 +0200 (CEST)
Date:   Wed, 6 May 2020 18:18:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     ndesaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        bristot <bristot@redhat.com>, jbaron <jbaron@akamai.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v4 14/18] static_call: Add static_cond_call()
Message-ID: <20200506161849.GV3762@hirez.programming.kicks-ass.net>
References: <20200501202849.647891881@infradead.org>
 <CAKwvOd=cP8UCX0+5pZ3AqzvOM8LKzLJJ_heDhrghqJdOnHoGMg@mail.gmail.com>
 <CAKwvOdkL+2Gvn2mkZ8cdHN=1F5cHQHii57ocD0RFeLJxEt=TUQ@mail.gmail.com>
 <CAHk-=wiUd=fcpegFLK4VK9iFfrO5BmpGKDszGpuyJkDdz4JaoQ@mail.gmail.com>
 <656098739.766.1588705237442.JavaMail.zimbra@efficios.com>
 <CAKwvOdnLze0e3Vwmb1Xdqwcwe9h6gnAwGnt3ksiNX7ENb_3Y9w@mail.gmail.com>
 <470458191.1021.1588710464160.JavaMail.zimbra@efficios.com>
 <20200506135502.GS3762@hirez.programming.kicks-ass.net>
 <482526608.2543.1588773672085.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <482526608.2543.1588773672085.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 10:01:12AM -0400, Mathieu Desnoyers wrote:
> ----- On May 6, 2020, at 9:55 AM, Peter Zijlstra peterz@infradead.org wrote:
> 
> > On Tue, May 05, 2020 at 04:27:44PM -0400, Mathieu Desnoyers wrote:
> >> Actually, if the goal is to do code patching of the call, I wonder
> >> what makes it OK to "guess" all the call patterns generated by the compiler ?
> > 
> > We're not guessing, have have objtool read the compiler output and
> > record the location for us. The compiler can generate whatever it likes.
> 
> So is the plan to adapt objtool if future compilers change the generated
> instruction patterns ?

If needed, sure. I don't really see what a compiler can do differently
though.

objtool looks for:

	JMP/CALL	__SCT__##foo

and writes a .static_call_sites table entry for it. Anything else we
can't rewrite anyway and will have to keep relying on the trampoline
working (which we also update, so that's fine).
