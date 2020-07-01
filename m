Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD43CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A81AB20773
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593585910;
	bh=V86J3jgURHSdZsyXulxAnsXOcGyXU5usoo+RFkulY4s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=k+7XxqySnCL+xIYqxP6sxVfgXrFLlRWQmzjhzDNmyEmgrgovpkn46Hob/pJUgRQ4h
	 MHnodYaPLw8x+1bn0/t7Tisr6r3Lt/qO6sAw1uyLQc54UA9EF5URZsHcQNsT6LAjpb
	 7HwB0+bKzo4uu5YdrWfk9bu6qCbA4WOyzy4/DSSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgGAGpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgGAGpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:45:09 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27F39207D4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 06:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593585908;
        bh=V86J3jgURHSdZsyXulxAnsXOcGyXU5usoo+RFkulY4s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OQzC8wBFpBQCqYh5C94NtLJpj4JYoVqRA9r7zs6jT+bP7y7Gtb5VAwpSc3pEhRKYW
         p32WsdLFpASecpHsn5civsVvTSZlVWKKLak3KIQWsuotKlXxlvZGse2M1sywiRO0Az
         4qVaa3DLq5V3e7xQstDEA0qkU4b++WMnMXztbNi8=
Received: by mail-ot1-f41.google.com with SMTP id m2so20601832otr.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 23:45:08 -0700 (PDT)
X-Gm-Message-State: AOAM532ErFhtav5D157Kr7cUAQkb86M4njHuTxkfo0fD3MtdRwpocbpg
        3pw8qQHvFu77D3UI3Q1/u+os6urRyGlsv4B1vzQ=
X-Google-Smtp-Source: ABdhPJzkllfSrkVjVRmkL64xW0OFGAH2LVAQjLBGmm+x67KpPW6KvfPoiTTZgc1feVe4Iw/ywmnvgsZnK0WPJo3pBq8=
X-Received: by 2002:a9d:4a8f:: with SMTP id i15mr22646743otf.77.1593585907399;
 Tue, 30 Jun 2020 23:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <202006290907.E5EF18A@keescook> <CAMj1kXFge5aWL2BY8Y1=m1TonB+SrDq6p7TQWuO5JkzcR2dhjQ@mail.gmail.com>
 <202006290919.93C759C62@keescook> <20200629165603.GD900899@rani.riverdale.lan>
 <20200629173735.l3ssrj7m3q5swfup@google.com> <CAMj1kXHaXzYFkW_H=w36vMb1qPpuZXsnTd_giq4vsh0bw3S3eA@mail.gmail.com>
 <20200629233405.n56yb4xwlgxrt3fn@google.com> <CAMj1kXGTOdNiuU70pFB74UJ6z43AM-UViTSd3=ATV=94W+f1RA@mail.gmail.com>
 <20200630175408.GA2301688@rani.riverdale.lan> <20200630220043.4snabunhgvfdktte@google.com>
 <20200630232759.GA2641539@rani.riverdale.lan>
In-Reply-To: <20200630232759.GA2641539@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 1 Jul 2020 08:44:56 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHVJ0eDHcod633P_nt0HbTayBkxwx8LQAV0k9t9oEFZSA@mail.gmail.com>
Message-ID: <CAMj1kXHVJ0eDHcod633P_nt0HbTayBkxwx8LQAV0k9t9oEFZSA@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] x86/boot: Check that there are no runtime relocations
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Fangrui Song <maskray@google.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jul 2020 at 01:28, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, Jun 30, 2020 at 03:00:43PM -0700, Fangrui Song wrote:
> > * Ard Biesheuvel
> > > On Tue, 30 Jun 2020 at 01:34, Fangrui Song <maskray@google.com> wrote:
> >
> > If the executable is purely static, it does not need to have PLT. All
> > calls to a PLT can be redirected to the function itself.  Some range
> > extension thunks (other terms: stub groups, veneers, etc) may still be
> > needed if the distance is too large.
> >
> > There are cases where a GOT cannot be avoided, e.g.
> >
> > extern char foo[] __attribute__((weak, visibility("hidden")));
> > char *fun() { return foo; }
> >
> > If foo is a SHN_ABS, `movq foo@GOTPCREL(%rip), %rax` can't be optimized
> > by GOTPCRELX (https://sourceware.org/bugzilla/show_bug.cgi?id=25749 binutils>=2.35 will be good)
> > Many other architectures don't even have a GOT optimization.
>
> Urk -- the example given in that bug report isn't even weak. Are you
> guys proposing to pessimize every access to a global symbol, regardless
> of visibility, by going through the GOT on the off chance that somebody
> might define one of them as SHN_ABS? Can we at least gate it behind
> something like __attribute__((might_be_shn_abs))?
>

SHN_ABS is typically only used for constants emitted by the linker
script, so I don't think this is a huge deal.

The example above is not that different from having a statically
initialized function pointer in your object (which might be NULL), and
that is something we already have to deal with anyway.

What I was talking about is the tendency of the compiler to assume
that every function symbol with external linkage is preemptible, and
the only way to suppress this behavior is to issue a #pragma that can
be done in code only, not on the compiler command line.

> >
> > >I don't think it's really relevant for the kernel build -- all we get is
> > >ld -static --no-dynamic-linker, all -static does is prevent searching
> > >shared libraries, and we already pass --no-dynamic-linker if it's
> > >supported.
> > >
> > >[0] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81498
