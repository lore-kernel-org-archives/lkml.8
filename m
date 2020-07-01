Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD7FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D1BD206BE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGNBSbN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731599AbgGAOmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 10:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgGAOme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 10:42:34 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6957FC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 07:42:34 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id u17so18602576qtq.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 07:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O/LhwyyKWARfsv1wEDYCmI5QIg3iM5SCtu/LXHQSrKs=;
        b=fGNBSbN0rjKxidaUj1l5b4wvjnlT/MjAke6092v4Wp2C/MOYPLl48c+Ogvd6w9Cuvn
         W7jiDAqTli8K9KvJA2MVkRUEAhHCYHY/faDEUevUjUVZnFLvNHhVUuuT6VUYcGimZi+2
         +A6esAcJoVG+7mn9l6J0CKLlWu5E5H3bY+22it1Sh+TG1v/D4dIo1Jq3qEw5NLylfOjG
         Ol2Ue2dn5eATuKN6QUSMTS94dPL5qyGdxAwu34IPDuycVPFgMkZfV+XqnzoNAEPa+vUm
         JWEVPyCYeOTGNoopmAeLu82ZAZk5rineVrw3jWQQ43uwiOw5LyDg5Nn767wbC7aLl7nN
         JjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=O/LhwyyKWARfsv1wEDYCmI5QIg3iM5SCtu/LXHQSrKs=;
        b=B4JLhplW5uk5OFWEZE69IFyGAXegAOfidczQSlNwLfWfFRWznuSktN4dXFvIUSZwHL
         f6dc9wgkizBpud67vHvjx/Cn34q+fRvpwPHSaKzPciH/7pgiA6OqpRLN6BK4yOUwFLMV
         xvPJARKqo/zeyoT4EjRYu4y0cX7BbZaxikmA65//iQ3e5sRKzGb912t4ei45rpGDMuqw
         jH03bGjf2n79UUYrtz2nyqyuzWuIVOve/+MlZrXlpdXtQJUw57vgxgtQIHeCM+0U8Odo
         qsDqgXVkRiuYxKGKISB2xcFlvhwKYAI8zFKj6doAi/N/dor6EzlRiVWFYKa1ZCeyFyz2
         BqIA==
X-Gm-Message-State: AOAM532Se4+95GBIGi8Wy72dfHZvmD9DtwtdxkhcmvsiJq3PXJolR1Av
        sojUx6KmTHZzRI0FvMzSUJU=
X-Google-Smtp-Source: ABdhPJyG9GToNAa1V1UQ61umaCttMmNTDZ2Umx5EF68tFFBH+M1FPha1vXXEi4cssh97Glzw6iQDEQ==
X-Received: by 2002:ac8:4055:: with SMTP id j21mr26518307qtl.76.1593614553563;
        Wed, 01 Jul 2020 07:42:33 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id q47sm6392560qta.16.2020.07.01.07.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 07:42:33 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 1 Jul 2020 10:42:31 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 7/7] x86/boot: Check that there are no runtime
 relocations
Message-ID: <20200701144231.GA3354308@rani.riverdale.lan>
References: <202006290919.93C759C62@keescook>
 <20200629165603.GD900899@rani.riverdale.lan>
 <20200629173735.l3ssrj7m3q5swfup@google.com>
 <CAMj1kXHaXzYFkW_H=w36vMb1qPpuZXsnTd_giq4vsh0bw3S3eA@mail.gmail.com>
 <20200629233405.n56yb4xwlgxrt3fn@google.com>
 <CAMj1kXGTOdNiuU70pFB74UJ6z43AM-UViTSd3=ATV=94W+f1RA@mail.gmail.com>
 <20200630175408.GA2301688@rani.riverdale.lan>
 <20200630220043.4snabunhgvfdktte@google.com>
 <20200630232759.GA2641539@rani.riverdale.lan>
 <CAMj1kXHVJ0eDHcod633P_nt0HbTayBkxwx8LQAV0k9t9oEFZSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHVJ0eDHcod633P_nt0HbTayBkxwx8LQAV0k9t9oEFZSA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 08:44:56AM +0200, Ard Biesheuvel wrote:
> On Wed, 1 Jul 2020 at 01:28, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Tue, Jun 30, 2020 at 03:00:43PM -0700, Fangrui Song wrote:
> > > * Ard Biesheuvel
> > > > On Tue, 30 Jun 2020 at 01:34, Fangrui Song <maskray@google.com> wrote:
> > >
> > > If the executable is purely static, it does not need to have PLT. All
> > > calls to a PLT can be redirected to the function itself.  Some range
> > > extension thunks (other terms: stub groups, veneers, etc) may still be
> > > needed if the distance is too large.
> > >
> > > There are cases where a GOT cannot be avoided, e.g.
> > >
> > > extern char foo[] __attribute__((weak, visibility("hidden")));
> > > char *fun() { return foo; }
> > >
> > > If foo is a SHN_ABS, `movq foo@GOTPCREL(%rip), %rax` can't be optimized
> > > by GOTPCRELX (https://sourceware.org/bugzilla/show_bug.cgi?id=25749 binutils>=2.35 will be good)
> > > Many other architectures don't even have a GOT optimization.
> >
> > Urk -- the example given in that bug report isn't even weak. Are you
> > guys proposing to pessimize every access to a global symbol, regardless
> > of visibility, by going through the GOT on the off chance that somebody
> > might define one of them as SHN_ABS? Can we at least gate it behind
> > something like __attribute__((might_be_shn_abs))?
> >
> 
> SHN_ABS is typically only used for constants emitted by the linker
> script, so I don't think this is a huge deal.
> 
> The example above is not that different from having a statically
> initialized function pointer in your object (which might be NULL), and
> that is something we already have to deal with anyway.
> 
> What I was talking about is the tendency of the compiler to assume
> that every function symbol with external linkage is preemptible, and
> the only way to suppress this behavior is to issue a #pragma that can
> be done in code only, not on the compiler command line.
> 

Yes, SHN_ABS is rare. But supporting it without an explicit annotation
for the compiler requires pessimizing the common case where the symbol
is _not_ SHN_ABS, because the compiler would have to assume that
everything might be defined as SHN_ABS. This includes accessing a simple
extern int variable.

It would have to generate the GOT-referencing code in all cases where it
doesn't see a strong definition, even with hidden visibility. And on
x86, we'd have to bump the toolchain requirement to at least 2.26 so we
can get the linker relaxations, otherwise you'd have GOT references in
the final code.
