Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107BEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE042085B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CKfuFKGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgFQOcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgFQOcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:32:17 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D0EC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 07:32:16 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y20so2242893wmi.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 07:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/NUSA9pglzD7yNhWCpeHZkfqenFsYSN7ZT6sKeOF1qQ=;
        b=CKfuFKGDV8j2Tll2XFCQJlY/kaHRQmZ/hX9qH1Zz4l3by7rS7EgfRVTc8Mw7hDh5lH
         Gl25mKlwQs2nfxqXeJiw8Xh4inDN5W+lHwBBw2amk1+5spkXnQ61kK5RXoZn4AfeUzsv
         /sVeJpsEauHghysJ852dBvFupPJuINrajqtyze1B2t6u41PKf/efhftv8kwNlUyWWp/6
         Mwt/vOZaEA2wG5yC4heBhsUg5KDPNhZCKyHZLTrn9JQHVgSYySIF0H61iaByymWlaMQg
         wIFjAJsvQxXG8aj3zSouyHk0TRrJzcN4Z+5x96APUyWUPVsIysfAQmGLhopGm7GIDVAc
         Me6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/NUSA9pglzD7yNhWCpeHZkfqenFsYSN7ZT6sKeOF1qQ=;
        b=W3GQD1gr1MputcSSwD/qKSn2UZ7CpeZXF8vGWO1kqQtzmdaieBFyelkS/XMzn4zj9Y
         sU3LZxPUiM9VoFqIqIddulvWAh0SaTPz3/vTQB4/GjYhZj3fgig5zZteuxx0h9TvoSRN
         v85X47nBzPQW3yG9100undZYmnBLFSTewDnjMa60AmicKcOOdCgrVQg7chkUxq2Q37lL
         m/BnTUnSbfAoBsEiPuGEZd7EBFl4xVVqGVGnJQoeolZeCnfUuY/3EPbyYcqk1/Gy/QZa
         9uHhBBfDuRH/3Uvlo9wQl0/kcbCj6X2pAGDl2l4yJXQyQKh0UIfXAn+60bqkq0PhEOb3
         PLqQ==
X-Gm-Message-State: AOAM531HSwcUIvqp3jy9zReta+s7vWiWdbOD0/vQ4cpRQBBpzJTK6h0/
        uPobm4DAElyz4j6hXH+4o1ZIZA==
X-Google-Smtp-Source: ABdhPJxDNwNN+dguaLV1N6nCZ8uF/v5ILPkkjsz6De5cIuagmhqadcAl1QeLepQ9h6DDhby8o2EzBg==
X-Received: by 2002:a1c:2d83:: with SMTP id t125mr9257993wmt.187.1592404335139;
        Wed, 17 Jun 2020 07:32:15 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id h7sm628623wml.24.2020.06.17.07.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 07:32:14 -0700 (PDT)
Date:   Wed, 17 Jun 2020 16:32:08 +0200
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, ndesaulniers@google.com
Subject: Re: [PATCH -tip v3 1/2] kcov: Make runtime functions
 noinstr-compatible
Message-ID: <20200617143208.GA56208@elver.google.com>
References: <20200608110108.GB2497@hirez.programming.kicks-ass.net>
 <20200611215538.GE4496@worktop.programming.kicks-ass.net>
 <CACT4Y+aKVKEp1yoBYSH0ebJxeqKj8TPR9MVtHC1Mh=jgX0ZvLw@mail.gmail.com>
 <20200612114900.GA187027@google.com>
 <CACT4Y+bBtCbEk2tg60gn5bgfBjARQFBgtqkQg8VnLLg5JwyL5g@mail.gmail.com>
 <CANpmjNM+Tcn40MsfFKvKxNTtev-TXDsosN+z9ATL8hVJdK1yug@mail.gmail.com>
 <20200615142949.GT2531@hirez.programming.kicks-ass.net>
 <20200615145336.GA220132@google.com>
 <20200615150327.GW2531@hirez.programming.kicks-ass.net>
 <20200615152056.GF2554@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615152056.GF2554@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.13.2 (2019-12-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 05:20PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 15, 2020 at 05:03:27PM +0200, Peter Zijlstra wrote:
> 
> > Yes, I think so. x86_64 needs lib/memcpy_64.S in .noinstr.text then. For
> > i386 it's an __always_inline inline-asm thing.
> 
> Bah, I tried writing it without memcpy, but clang inserts memcpy anyway
> :/

Hmm, __builtin_memcpy() won't help either.

Turns out, Clang 11 got __builtin_memcpy_inline(): https://reviews.llvm.org/D73543

The below works, no more crash on either KASAN or KCSAN with Clang. We
can test if we have it with __has_feature(__builtin_memcpy_inline)
(although that's currently not working as expected, trying to fix :-/).

Would a memcpy_inline() be generally useful? It's not just Clang but
also GCC that isn't entirely upfront about which memcpy is inlined and
which isn't. If the compiler has __builtin_memcpy_inline(), we can use
it, otherwise the arch likely has to provide the implementation.

Thoughts?

Thanks,
-- Marco

------ >8 ------

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index af75109485c2..3e07beae2a75 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -690,13 +690,13 @@ struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s)
 		(struct bad_iret_stack *)__this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
 
 	/* Copy the IRET target to the temporary storage. */
-	memcpy(&tmp.regs.ip, (void *)s->regs.sp, 5*8);
+	__builtin_memcpy_inline(&tmp.regs.ip, (void *)s->regs.sp, 5*8);
 
 	/* Copy the remainder of the stack from the current stack. */
-	memcpy(&tmp, s, offsetof(struct bad_iret_stack, regs.ip));
+	__builtin_memcpy_inline(&tmp, s, offsetof(struct bad_iret_stack, regs.ip));
 
 	/* Update the entry stack */
-	memcpy(new_stack, &tmp, sizeof(tmp));
+	__builtin_memcpy_inline(new_stack, &tmp, sizeof(tmp));
 
 	BUG_ON(!user_mode(&new_stack->regs));
 	return new_stack;
