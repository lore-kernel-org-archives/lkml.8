Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DEDC4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C95992074F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588020647;
	bh=ojQhW+7FNr+OkzdDBjhoqYPrmS1FcUqaRsR5XmwbCIY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uqWaBBGd2AhlSvQ4/MBP+7TbyrAtNezbGpRmEMk6CNsQUZxgyYxtWr+kAg6AR37z7
	 0f8QPdQvBDYPFkwI+2JIeTFlDZRG7idv/aZ8pl3c4+35rW2eGRpQhJMy4nhPt6r8WE
	 uFq8Gq8AycZ3Ej1PkdqU48kXQW6oUprcTKAdgtCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgD0Uur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:50:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgD0Uuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:50:46 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9938E21835
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 20:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588020645;
        bh=ojQhW+7FNr+OkzdDBjhoqYPrmS1FcUqaRsR5XmwbCIY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n7znioTlY6M1Pur6M7/bXnAM3JAmIUZphxi4IJcXODqlcIjLmd6vjKQ4+QpUKkboy
         vltVRfm+cdS9tNDGa2BG+Kmb/J4YqdPNGcbsUGSw3/fWGcyl0oP03NaVq1DTKCRrvV
         r8px5ZdGsKTnJGduHq8iaR4B3ct5Ri+LNgjJPH6Q=
Received: by mail-il1-f182.google.com with SMTP id m5so9890695ilj.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 13:50:45 -0700 (PDT)
X-Gm-Message-State: AGi0PubGFVFyC8WxW7ofuqQY7A6YrTEDPhdN0ftFZrnCM6olZWmDBKPr
        9KCzmHyVpr4777AtV0zsyPfYs4KApzsMs4YITzY=
X-Google-Smtp-Source: APiQypLjDlebXl7yx26Wx8AaZKJr4XeF/CH78lnbHF77G2+qMMQaWfGEj9yh2jjjOoM10tO6S6CnQODeBxzLuYifo3c=
X-Received: by 2002:a92:607:: with SMTP id x7mr21066130ilg.218.1588020644913;
 Mon, 27 Apr 2020 13:50:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200427160018.243569-1-samitolvanen@google.com> <CAMj1kXGASSCjTjvXJh=_iPwEPG50_pVRe2QO1hoRW+KHtugFVQ@mail.gmail.com>
In-Reply-To: <CAMj1kXGASSCjTjvXJh=_iPwEPG50_pVRe2QO1hoRW+KHtugFVQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 27 Apr 2020 22:50:34 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFYv6YQJ0KGnFh=d6_K-39PYW+2bUj9TDnutA04czhOjQ@mail.gmail.com>
Message-ID: <CAMj1kXFYv6YQJ0KGnFh=d6_K-39PYW+2bUj9TDnutA04czhOjQ@mail.gmail.com>
Subject: Re: [PATCH v13 00/12] add support for Clang's Shadow Call Stack
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Marc Zyngier <maz@kernel.org>,
        kernel-hardening@lists.openwall.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Laura Abbott <labbott@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Apr 2020 at 19:39, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 27 Apr 2020 at 18:00, Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > This patch series adds support for Clang's Shadow Call Stack
> > (SCS) mitigation, which uses a separately allocated shadow stack
> > to protect against return address overwrites. More information
> > can be found here:
> >
> >   https://clang.llvm.org/docs/ShadowCallStack.html
> >
> > SCS provides better protection against traditional buffer
> > overflows than CONFIG_STACKPROTECTOR_*, but it should be noted
> > that SCS security guarantees in the kernel differ from the ones
> > documented for user space. The kernel must store addresses of
> > shadow stacks in memory, which means an attacker capable of
> > reading and writing arbitrary memory may be able to locate them
> > and hijack control flow by modifying the shadow stacks.
> >
> > SCS is currently supported only on arm64, where the compiler
> > requires the x18 register to be reserved for holding the current
> > task's shadow stack pointer.
> >
> > With -fsanitize=shadow-call-stack, the compiler injects
> > instructions to all non-leaf C functions to store the return
> > address to the shadow stack, and unconditionally load it again
> > before returning. As a result, SCS is incompatible with features
> > that rely on modifying function return addresses in the kernel
> > stack to alter control flow. A copy of the return address is
> > still kept in the kernel stack for compatibility with stack
> > unwinding, for example.
> >
> > SCS has a minimal performance overhead, but allocating
> > shadow stacks increases kernel memory usage. The feature is
> > therefore mostly useful on hardware that lacks support for PAC
> > instructions.
> >
> > Changes in v13:
> >  - Changed thread_info::shadow_call_stack to a base address and
> >    an offset instead, and removed the now unneeded __scs_base()
> >    and scs_save().
> >  - Removed alignment from the kmem_cache and static allocations.
> >  - Removed the task_set_scs() helper function.
> >  - Moved the assembly code for loading and storing the offset in
> >    thread_info to scs_load/save macros.
> >  - Added offset checking to scs_corrupted().
> >  - Switched to cmpxchg_relaxed() in scs_check_usage().
> >
>
> OK, so one thing that came up in an offline discussion about SCS is
> the way it interacts with the vmap'ed stack.
>
> The vmap'ed stack is great for robustness, but it only works if things
> don't explode for other reasons in the mean time. This means the
> ordinary-to-shadow-call-stack size ratio should be chosen such that it
> is *really* unlikely you could ever overflow the shadow call stack and
> corrupt another task's call stack before hitting the vmap stack's
> guard region.
>
> Alternatively, I wonder if there is a way we could let the SCS and
> ordinary stack share the [bottom of] the vmap'ed region. That would
> give rather nasty results if the ordinary stack overflows into the
> SCS, but for cases where we really recurse out of control, we could
> catch this occurrence on either stack, whichever one occurs first. And
> the nastiness -when it does occur- will not corrupt any state beyond
> the stack of the current task.

Hmm, I guess that would make it quite hard to keep the SCS address
secret though :-(
