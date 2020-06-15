Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084A0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D58652067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tn06U7Uv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgFOHlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728641AbgFOHlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:41:37 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A223C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 00:41:25 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c14so14808392qka.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 00:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2KL7qPoxB+SXypXx6JSxpmJJJ1hbOJrXzQ0d7/jA8mo=;
        b=Tn06U7UvLq2rd/h92eFhD/jpOodVbzmscii0VlCpophDsGbW2F9qiBbYiarhF0DuLa
         Men7TemgKDmNqe98NHojSpahmlg5XqMdLqpsICALkSfBICZKEFC7SGgRhXZQeD0vy/AA
         jvfeHaNboLvCQMALl8h+/MJi6P3poJNhJWW2X/pkoK6iRql03qs5UzKZqIp59/GEeXcw
         ACUyJ23vOsg5X8bzLNlPYfTC2ENUsC2sBqvXRyusXenHbVyoED44qDgaYg9tt9BaS2cV
         me9vdnnvkRNMULOgd9fwgSWCMVBKTO33qRcoJneG/pfepO/P6uOppge/vVYOybMxCTiy
         wo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2KL7qPoxB+SXypXx6JSxpmJJJ1hbOJrXzQ0d7/jA8mo=;
        b=lHJybmKBxYUO+zDTT64DBpGJYDtdNsqu5t85ZROr9+CaRqbKltEoceXzoNBPKh0dBv
         oh1lSNuvvl9VFxTsYLbdbF8UjVUGFGe3oH7MpO38FzWT6bP7p5xf+OjPeTaIi5XBzmEt
         g8JIivMThVEw6Rs0aToACIBVfL0fbgdeSO3spsQEQgiiiVUD/CYUzK7BxKBgaogxceee
         GuLDZ0JXnSC9m8+FpIVT2QJ9grbunVu1mJOIwUAMGbdqkxJ0sfaFJ/Nm9jdvskFr8/u6
         UkIgFRteGjcjAeceoXqnOb3Dms/Gy5RNkVht7fg/5ZOxgyGQ5i1cg3gE6X2ao2BUcmuD
         irpA==
X-Gm-Message-State: AOAM5317DvycxdNRCzgB3ugzNm7YU2f3c+WDWQxLohJRPMzMV0z4tcux
        46cWAGon8Z73D9tpRwJpEaeZbIM3OWmAsZXhKN9X6Q==
X-Google-Smtp-Source: ABdhPJwAD+b73mpH1Fzo+cMzffJhtAQj6QcKhYtrbj56harDUaL3yMtSbCai9zQflFKVVKRdpALQgM/PwWs8WOScLp8=
X-Received: by 2002:a05:620a:786:: with SMTP id 6mr12222644qka.407.1592206875597;
 Mon, 15 Jun 2020 00:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200612143034.933422660@infradead.org> <20200612143554.071314718@infradead.org>
In-Reply-To: <20200612143554.071314718@infradead.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 15 Jun 2020 09:41:04 +0200
Message-ID: <CACT4Y+Zj4=4C4rg6Y_EgQRjxS8_BcApxNeQRQVXewAsgQqQj8Q@mail.gmail.com>
Subject: Re: [RFC][PATCH 3/3] objtool: Fix noinstr vs KCOV
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>, mhelsley@vmware.com,
        Steven Rostedt <rostedt@goodmis.org>, jthierry@redhat.com,
        mbenes@suse.cz
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 4:37 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Since many compilers cannot disable KCOV with a function attribute,
> help it to NOP out any __sanitizer_cov_*() calls injected in noinstr
> code.
>
> This turns:
>
> 12:   e8 00 00 00 00          callq  17 <lockdep_hardirqs_on+0x17>
>                 13: R_X86_64_PLT32      __sanitizer_cov_trace_pc-0x4
>
> into:
>
> 12:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>                 13: R_X86_64_NONE      __sanitizer_cov_trace_pc-0x4
>
> Just like recordmcount does.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Dmitry Vyukov <dvyukov@google.com>

Thanks!

> ---
>  tools/objtool/arch.h                      |    2 ++
>  tools/objtool/arch/x86/decode.c           |   18 ++++++++++++++++++
>  tools/objtool/arch/x86/include/arch_elf.h |    6 ++++++
>  tools/objtool/check.c                     |   19 +++++++++++++++++++
>  4 files changed, 45 insertions(+)
>
> --- a/tools/objtool/arch.h
> +++ b/tools/objtool/arch.h
> @@ -84,4 +84,6 @@ unsigned long arch_jump_destination(stru
>
>  unsigned long arch_dest_reloc_offset(int addend);
>
> +const char *arch_nop_insn(int len);
> +
>  #endif /* _ARCH_H */
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -565,3 +565,21 @@ void arch_initial_func_cfi_state(struct
>         state->regs[16].base = CFI_CFA;
>         state->regs[16].offset = -8;
>  }
> +
> +const char *arch_nop_insn(int len)
> +{
> +       static const char nops[5][5] = {
> +               /* 1 */ { 0x90 },
> +               /* 2 */ { 0x66, 0x90 },
> +               /* 3 */ { 0x0f, 0x1f, 0x00 },
> +               /* 4 */ { 0x0f, 0x1f, 0x40, 0x00 },
> +               /* 5 */ { 0x0f, 0x1f, 0x44, 0x00, 0x00 },
> +       };
> +
> +       if (len < 1 || len > 5) {
> +               WARN("invalid NOP size: %d\n", len);
> +               return NULL;
> +       }
> +
> +       return nops[len-1];
> +}
> --- /dev/null
> +++ b/tools/objtool/arch/x86/include/arch_elf.h
> @@ -0,0 +1,6 @@
> +#ifndef _OBJTOOL_ARCH_ELF
> +#define _OBJTOOL_ARCH_ELF
> +
> +#define R_NONE R_X86_64_NONE
> +
> +#endif /* _OBJTOOL_ARCH_ELF */
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -12,6 +12,7 @@
>  #include "check.h"
>  #include "special.h"
>  #include "warn.h"
> +#include "arch_elf.h"
>
>  #include <linux/hashtable.h>
>  #include <linux/kernel.h>
> @@ -744,6 +745,24 @@ static int add_call_destinations(struct
>                         insn->call_dest = reloc->sym;
>
>                 /*
> +                * Many compilers cannot disable KCOV with a function attribute
> +                * so they need a little help, NOP out any KCOV calls from noinstr
> +                * text.
> +                */
> +               if (insn->sec->noinstr &&
> +                   !strncmp(insn->call_dest->name, "__sanitizer_cov_", 16)) {
> +                       if (reloc) {
> +                               reloc->type = R_NONE;
> +                               elf_write_reloc(file->elf, reloc);
> +                       }
> +
> +                       elf_write_insn(file->elf, insn->sec,
> +                                      insn->offset, insn->len,
> +                                      arch_nop_insn(insn->len));
> +                       insn->type = INSN_NOP;
> +               }
> +
> +               /*
>                  * Whatever stack impact regular CALLs have, should be undone
>                  * by the RETURN of the called function.
>                  *
>
>
