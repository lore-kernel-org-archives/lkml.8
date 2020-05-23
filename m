Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4B9C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 02:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3476206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 02:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxUpicDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387658AbgEWCwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 22:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387481AbgEWCwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 22:52:36 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7ACC061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 19:52:36 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id p20so202649iop.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 19:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xmAJ72ZodSQPB9GQTcZc5m3h7JN9shWGEOhEZ9gi9Uk=;
        b=sxUpicDSra9P9lNgsoRTqewWTnywmfeSeqHXvm7JJ0IY3KRVXVHUgAX93uDIMknust
         ZIynhkYUMl13pAqoGpYnVbHMMhMaAXQgR2lboLLwyAZEdKOPvoSwFKohYFMUAqs0dJ/I
         u0KF56/qNbRg1brCQA7Wv2u4yaos8bqDPQ7MvA7x3jKLgl5ZJOAeWeeYZeoGO7dVjMHV
         WgN0qHWDYWplkafI1sgdtezAHYahfibUJCZwfLHK1xVeb/T2F0VW6WxUKxejkJLvQLwx
         UMn7/w9eZKSj2FDVDBddujV8DuaAy4xQvho5iZAkDxlx9a/GY2gqr0HShERNVTq0hL/q
         R9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xmAJ72ZodSQPB9GQTcZc5m3h7JN9shWGEOhEZ9gi9Uk=;
        b=nGN2hcKC8wjCF11xeZoL8Ng5PKpb7EEutx1UqJ4WcKkVPEHnTpwlexqPlNcpWEk0Dc
         hVjOZEFkPS1h6tWIBFKcJN4LipUAohSSKcPUcPZdnaa5EvAT8WZan0e9wTCqoMXXDKEW
         x0udqFoKJM8BeTAEh9sgHovCRT1F7w1En+z409yfzuISvYmYTDweHToz4fNKoQ0UAjA2
         IRCxNHDIN0A/pQhujBD3ZLSx6r4ufY1OqdKcjb5/h7f/7cq1/+leI3owEsdIlcS8l4aG
         6k8WT72Q8wNPhfYXNSZuf5BlcHtGs5Z1C8sOhlm1w0t2d8G93Q9XMQ64kyqYrmcNQO3F
         8k2A==
X-Gm-Message-State: AOAM5333woBD8rM5BJLVg6L3UXOT6yHnapqSYeeM/hEEu1Q8qlR91Xw7
        WcU55MuKIuppu0UcRlLmTA1BMIzfGLVsgq4H9JU=
X-Google-Smtp-Source: ABdhPJyVBia3RcF7qraQSjY8xFJ7L1SRxDXM3+9DrguITm5hOoOI62hpauA+ig17o4GZ7tMZPckkz4neCjukPj5fh6E=
X-Received: by 2002:a02:6d46:: with SMTP id e6mr2321953jaf.43.1590202355441;
 Fri, 22 May 2020 19:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200518160750.GA279861@hirez.programming.kicks-ass.net>
 <87367xvvmy.fsf@nanos.tec.linutronix.de> <20200519083826.GC279861@hirez.programming.kicks-ass.net>
 <20200519090226.GD279861@hirez.programming.kicks-ass.net>
In-Reply-To: <20200519090226.GD279861@hirez.programming.kicks-ass.net>
From:   Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date:   Sat, 23 May 2020 10:52:24 +0800
Message-ID: <CAJhGHyCStHRzqv2Di57ALnBiPCpKjob4TG6Hj76+NowpNLqD7w@mail.gmail.com>
Subject: Re: [patch V6 00/37] x86/entry: Rework leftovers and merge plan
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 5:04 PM Peter Zijlstra <peterz@infradead.org> wrote:

> +#ifdef CONFIG_DEBUG_ENTRY
>  /* Begin/end of an instrumentation safe region */
> -#define instrumentation_begin() ({                                             \
> +#define instrumentation_begin() ({                                     \
>         asm volatile("%c0:\n\t"                                         \
>                      ".pushsection .discard.instr_begin\n\t"            \
>                      ".long %c0b - .\n\t"                               \
>                      ".popsection\n\t" : : "i" (__COUNTER__));          \
>  })
>
> -#define instrumentation_end() ({                                                       \
> -       asm volatile("%c0:\n\t"                                         \
> +/*
> + * Because instrumentation_{begin,end}() can nest, objtool validation considers
> + * _begin() a +1 and _end() a -1 and computes a sum over the instructions.
> + * When the value is greater than 0, we consider instrumentation allowed.
> + *
> + * There is a problem with code like:
> + *
> + * noinstr void foo()
> + * {
> + *     instrumentation_begin();
> + *     ...
> + *     if (cond) {
> + *             instrumentation_begin();
> + *             ...
> + *             instrumentation_end();
> + *     }
> + *     bar();
> + *     instrumentation_end();
> + * }
> + *
> + * If instrumentation_end() would be an empty label, like all the other
> + * annotations, the inner _end(), which is at the end of a conditional block,
> + * would land on the instruction after the block.
> + *
> + * If we then consider the sum of the !cond path, we'll see that the call to
> + * bar() is with a 0-value, even though, we meant it to happen with a positive
> + * value.
> + *
> + * To avoid this, have _end() be a NOP instruction, this ensures it will be
> + * part of the condition block and does not escape.
> + */
> +#define instrumentation_end() ({                                       \
> +       asm volatile("%c0: nop\n\t"                                     \
>                      ".pushsection .discard.instr_end\n\t"              \
>                      ".long %c0b - .\n\t"                               \
>                      ".popsection\n\t" : : "i" (__COUNTER__));          \
>  })

Hello,

I, who don't know how does the objtool handle it, am just curious.
_begin() and _end() are symmetrical, which means if _end() (without nop)
can escape, so can _begin() in a reverse way. For example:

noinstr void foo()
{
    instrumentation_begin();
    do {
            instrumentation_begin();
            ...
            instrumentation_end();
    } while (cond);
    bar();
    instrumentation_end();
}

Here, the first _begin() can be "dragged" into the do-while block.
Expectedly, objtool validation should not complain here.

But objtool validation's not complaining means it can handle it
magically correctly (by distinguishing how many _begin()s should
be taken around the jmp target when jmp in a specific path), or
handle it by not checking if all paths have the same count onto
a jmp target (a little nervous to me), or other possible ways.

Sorry for my curiosity.
Thanks
Lai.
