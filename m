Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC55AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 03:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90B0720674
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 03:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWKuumJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgESDis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 23:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgESDis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 23:38:48 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D4AC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 20:38:47 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id s10so13042449iog.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 20:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AmoSinb004QBItlczFEt+9SkY2V///JRTZUjH4ZHNBQ=;
        b=hWKuumJ0qsNkKGUydur5dT61kC1W1kJNIPtC3QojiRprZEplH0oMQWn8HqFe8udhHX
         hw+AUGbiPb8uNxQWmv1UMjCe/suc/nmMdKJjSURkqN2IBUpDGJKMA6xoKm2+Ht8xykC1
         LLbZRI+8gTsSxUfnMR2zEjn4l16gAveE6iS3zX1tC5YReGjOhtrMJA1mi1VmlS6nNzTC
         LMxbxNLqSkw3LkqSHfK4/qIcNN1uenuF9pLQzLFJU3bMN2xlJFjuO5hxIq/YTvoxc/hk
         IrsE5y57UXbGLj0ByxGHQc4Na2lnYmXDOzOeZkBOSuKxho11O33B36lKSCzrsqEKY0z8
         OCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AmoSinb004QBItlczFEt+9SkY2V///JRTZUjH4ZHNBQ=;
        b=g74glZjc3/mshNnXWLo9Hq650lT0ySzB0LOQZCbgCjFy565LU4skziZOqeBWj2E62M
         TaJJkAmQGf2rU4+0TlDtZHp2O11hSYY5W/zUn/RjfQ1LoKeAbOobaRniffNewrzVqaEF
         0/O6Gn+P+YvwuWjQHzffASH/JFOQ3KgkIbS3+ww3xOee89tONy6Fhfpj5uLpfy2cT9Mp
         CgjMScbug/r7RVzYdDOKei2KCQBphWU5n6wTFlHRhx6hNsPnwg5oqkBBjh3IC9IjBX7h
         o8ub98i3CY8CNyHcbe3OsTE56PHvkpXw+95o5tkpR5qNGDrf/lQeGU+EBHXAo2r1An2q
         5Kjw==
X-Gm-Message-State: AOAM531JWAVw+pb85O/O2iiu5ZMZ/RA1fNMO0hYApm85Wy18MPvdKAaS
        2XEZGZE3x7GXNE2OxclYJ9mPA373zFTmv5qctA==
X-Google-Smtp-Source: ABdhPJwejThxBcFi1wrqIV4aOVEm7IVUj3kJdt+7p+hDhsbNCilDuWhwHAdbVQ9xW9jx27VoEyW6FN4NuBB7Uk6Cu7M=
X-Received: by 2002:a6b:d909:: with SMTP id r9mr17480387ioc.22.1589859525551;
 Mon, 18 May 2020 20:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200517152916.3146539-1-brgerst@gmail.com> <20200517152916.3146539-3-brgerst@gmail.com>
 <CAKwvOdnCcpS_9A2y9tMqeiAg2NfcVx=gNeA2V=+zHknit7wGkg@mail.gmail.com>
In-Reply-To: <CAKwvOdnCcpS_9A2y9tMqeiAg2NfcVx=gNeA2V=+zHknit7wGkg@mail.gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Mon, 18 May 2020 23:38:34 -0400
Message-ID: <CAMzpN2gGbZABjtLQyiTdtaL5LYW-cfVQZqj6w=oZNa9Fw9GdCQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] x86/percpu: Clean up percpu_to_op()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 5:15 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, May 17, 2020 at 8:29 AM Brian Gerst <brgerst@gmail.com> wrote:
> >
> > The core percpu macros already have a switch on the data size, so the switch
> > in the x86 code is redundant and produces more dead code.
> >
> > Also use appropriate types for the width of the instructions.  This avoids
> > errors when compiling with Clang.
> >
> > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > ---
> >  arch/x86/include/asm/percpu.h | 90 ++++++++++++++---------------------
> >  1 file changed, 35 insertions(+), 55 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
> > index 89f918a3e99b..233c7a78d1a6 100644
> > --- a/arch/x86/include/asm/percpu.h
> > +++ b/arch/x86/include/asm/percpu.h
> > @@ -117,37 +117,17 @@ extern void __bad_percpu_size(void);
> >  #define __pcpu_reg_imm_4(x) "ri" (x)
> >  #define __pcpu_reg_imm_8(x) "re" (x)
> >
> > -#define percpu_to_op(qual, op, var, val)               \
> > -do {                                                   \
> > -       typedef typeof(var) pto_T__;                    \
> > -       if (0) {                                        \
> > -               pto_T__ pto_tmp__;                      \
> > -               pto_tmp__ = (val);                      \
> > -               (void)pto_tmp__;                        \
> > -       }                                               \
> > -       switch (sizeof(var)) {                          \
> > -       case 1:                                         \
> > -               asm qual (op "b %1,"__percpu_arg(0)     \
> > -                   : "+m" (var)                        \
> > -                   : "qi" ((pto_T__)(val)));           \
> > -               break;                                  \
> > -       case 2:                                         \
> > -               asm qual (op "w %1,"__percpu_arg(0)     \
> > -                   : "+m" (var)                        \
> > -                   : "ri" ((pto_T__)(val)));           \
> > -               break;                                  \
> > -       case 4:                                         \
> > -               asm qual (op "l %1,"__percpu_arg(0)     \
> > -                   : "+m" (var)                        \
> > -                   : "ri" ((pto_T__)(val)));           \
> > -               break;                                  \
> > -       case 8:                                         \
> > -               asm qual (op "q %1,"__percpu_arg(0)     \
> > -                   : "+m" (var)                        \
> > -                   : "re" ((pto_T__)(val)));           \
> > -               break;                                  \
> > -       default: __bad_percpu_size();                   \
> > -       }                                               \
> > +#define percpu_to_op(size, qual, op, _var, _val)                       \
> > +do {                                                                   \
> > +       __pcpu_type_##size pto_val__ = __pcpu_cast_##size(_val);        \
> > +       if (0) {                                                        \
> > +               typeof(_var) pto_tmp__;                                 \
> > +               pto_tmp__ = (_val);                                     \
> > +               (void)pto_tmp__;                                        \
> > +       }                                                               \
>
> Please replace the whole `if (0)` block with:
> ```c
> __same_type(_var, _val);
> ```
> from include/linux/compiler.h.

The problem with __builtin_types_compatible_p() is that it considers
unsigned long and u64 (aka unsigned long long) as different types even
though they are the same width on x86-64.  While this may be a good
cleanup to look at in the future, it's not a simple drop-in
replacement.

--
Brian Gerst
