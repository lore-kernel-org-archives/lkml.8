Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223ABC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF2A2145D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588785430;
	bh=LweYlv7/DkoD4SGJEwXckAeYD0SGWxgTKPB6ydhEoXI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IjedDR/URCdEiwTzAyN/i1cBI4jV29ccyPr6MvaFIGajTqfHhEL07OR2DJCu7nYHc
	 ZNSbzhBUUL9fjDDGLJ8mqaHJBPdbIHJ9SaIagQsHw95AnjHpATDIyPHQTyoK59jjLm
	 HRJXaIAm46/qo53LhEcpfbVvhGfMimEC7uLaC6wE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbgEFRRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 13:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgEFRRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:17:08 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E001FC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 10:17:07 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u6so3215171ljl.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 10:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=07w3M3fjX49pguIvUyZoChyUZSwRCf3IidBIG7ARz+M=;
        b=Bv/hOfS/WKD94FxyU/YzCqrVj0cnpXp1XV6cBa438o2cwpkU6Wr+f350ViQfVa6Pks
         wl5GeBrkIxOCebVW+g8QQLUTBHtaBKpbeQzuqS1y1aUAfuuPYRirIXsPMGsWo+2i2yP+
         2Y7tG8jeDeIFeF0PTzl6ilF5ps4kaSpbd4RHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=07w3M3fjX49pguIvUyZoChyUZSwRCf3IidBIG7ARz+M=;
        b=ls3ocgNOSAqfiVb3NMpNvqkcDe52MN+p4I2LhR5y/pm2FsXRPxIhGxxiKQodmFJEvD
         XrZ+YgYuOgnuOCFhwABG9zX6BnFafxBj/yY68LPS2Zyzozxn4fIA2i9xQv6fDyZtlibU
         1Ohm6JpU007zkCzthbxebbGatJwzvnMCG4JmlvjghqzlX97amqmRhb/P4VWo4KEF830D
         m3FFuu4kBAgrKCOTBIMcIsoH8Ia5Uh09Hu8qelhhP55RRRCjVLCV6a5PV4AuqPtR8g5j
         5b3kZPFuKYrU8N6VDlmzvsosQfhhcCuwpsr7dPO4kAM9jOjXwLlH5AdfUYiGlonzGlzn
         PUWg==
X-Gm-Message-State: AGi0PuaTIKOUMEmPRK89svQy581T5wwHAJazzvtL008OOdEjKVRE8Lp7
        t1ja0GdwzP4OeISAt6SiFCUiGviAwWM=
X-Google-Smtp-Source: APiQypLQtfOorSSp8sRQJ6Lgkm3ya5zROd4trcLNhk1Nh6dHOoxKQ1bE/gZNEsKDtmDfGRc/fSYoIA==
X-Received: by 2002:a2e:a292:: with SMTP id k18mr5489575lja.263.1588785425673;
        Wed, 06 May 2020 10:17:05 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id o22sm1709115ljj.100.2020.05.06.10.17.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 10:17:04 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id b2so3228030ljp.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 10:17:04 -0700 (PDT)
X-Received: by 2002:a2e:814e:: with SMTP id t14mr5608093ljg.204.1588785423772;
 Wed, 06 May 2020 10:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200501202849.647891881@infradead.org> <20200501202944.593400184@infradead.org>
 <1238787e-d97d-f09b-d76d-2df2dc273f4b@rasmusvillemoes.dk> <20200503125813.GL3762@hirez.programming.kicks-ass.net>
 <a53369f3-665a-af0e-efad-09ae456af847@rasmusvillemoes.dk> <20200504201445.GQ3762@hirez.programming.kicks-ass.net>
 <20200505093625.GE5298@hirez.programming.kicks-ass.net> <CAKwvOd=cP8UCX0+5pZ3AqzvOM8LKzLJJ_heDhrghqJdOnHoGMg@mail.gmail.com>
 <20200506135128.GR3762@hirez.programming.kicks-ass.net>
In-Reply-To: <20200506135128.GR3762@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 May 2020 10:16:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjdLY-E3m21_QcHUauakW3qAAOCe2rxzuFEm-Af_oqG0g@mail.gmail.com>
Message-ID: <CAHk-=wjdLY-E3m21_QcHUauakW3qAAOCe2rxzuFEm-Af_oqG0g@mail.gmail.com>
Subject: Re: [PATCH v4 14/18] static_call: Add static_cond_call()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 6, 2020 at 6:51 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> I was hoping for:
>
>         bar:                                    # @bar
>                 movl    %edi, .L_x$local(%rip)
>                 retq
>         ponies:                                 # @ponies
>                 movq    .Lfoo$local(%rip), %rax
>                 testq   %rax, %rax
>                 jz      1f
>                 jmpq    *%rcx                   # TAILCALL
>         1:
>                 retq

If you want to just avoid the 'cmov', the best way to do that is to
insert a barrier() on one side of the if-statement.

That breaks the ability to turn the conditional jump into a cmov.

HOWEVER.

It looks like noth clang and gcc will move the indirect jump to the
conditional sites, but then neither of them is smart enough to just
turn the indirect jump into one direct jump.

Strange. So you still get an indirect call for just the "ret" case.
The code looks actively stupid with

gcc:
  .L7:
        movl    $__static_call_nop, %eax
        jmp     *%rax

clang:
  .LBB1_1:
        mov     eax, offset __static_call_nop
        jmp     rax                     # TAILCALL

despite the barrier not being between those two points. The only
difference is the assembler syntax.

Odd. That's such a trivial and obvious optimization. But presumably
it's a pattern that just doesn't happen normally.

                Linus
