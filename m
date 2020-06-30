Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34501C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1324620724
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XA6CWCMP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388765AbgF3RyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgF3RyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:54:11 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC80BC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 10:54:11 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id u12so16252424qth.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 10:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=78g2lNiWm2EDkYkQ5OSAtg/8SeeBhLbfJO295zn42p8=;
        b=XA6CWCMPQSNY/lSvYbaLKBUIMMmjG5vFufhTOuMoRkZp6z67LEQ8zSo7CBizOO+K7q
         uN39hMYB8A2muMtV6Of4DH1J8ONz4zffuv5uYdPmizyY+dZI8z0JqexJRQg97sH1kUwY
         azE3yxl2KZUobeKBn6FJ9hu21+0KRZ93tmM7Lm+TOxhR+6PKyLJhDD1DE+Wrn+2J9aJw
         cEfz3+sWHcU+q8v1p7Hiy1e5sLjbh4XPO4czu411igsMod/E7FGUyXLV3IcLChh9Z6oT
         lnL6DXKT35vZBvaTFu+QREcpcYEmC5JEWrLMQ1NUfnn5DGJ0EjgpafLl/HHAaBmSCnaV
         +I8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=78g2lNiWm2EDkYkQ5OSAtg/8SeeBhLbfJO295zn42p8=;
        b=s59bIslW9DYHKkS/WhxH7jqV96TP00StrAB7aomc/l+aO6zPJrslpP/DXrYeZUHWyO
         MpRwmTQzyklOJBaAGfrWsNGcA4YW/+/QuWdf+zab51jcvS1J+IPf96PFkrtCzvXgz/sF
         o3EqxX9peoMS6PPhotBk9W2r7Q3aKPgVsALQkt28Gy5wP3b3P0EzkJVfVFXXVun6GUl4
         CjrISPeKrp2pt333YIwd3zcCWxF2xi9N9i+2qKp/HaJMGHjU+C26gNinvKPAojfSj89Q
         HzHTAB1szipa+VWgLCmEQLPZC+d2mldUNl4Z6EVnj2qSDyUuwSrc4CcGfP3QvC+pKCOb
         zP6A==
X-Gm-Message-State: AOAM532J6LtZQgwXymT41H25W4XlxHgVfHAuu+deWdxvHZ9pzzDnvB3E
        oAo+ZEwchL8shUZWAz1eQpQ=
X-Google-Smtp-Source: ABdhPJwAvvqu+S3QRt0UlOOrjmCSmyPn6znVgnsKnlz1pn0iWvwoPeSXpy7v4ynCBLQ4U8Wx6HpOIQ==
X-Received: by 2002:ac8:47d0:: with SMTP id d16mr22196554qtr.349.1593539650703;
        Tue, 30 Jun 2020 10:54:10 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p66sm3581099qkf.58.2020.06.30.10.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 10:54:10 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 30 Jun 2020 13:54:08 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
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
Message-ID: <20200630175408.GA2301688@rani.riverdale.lan>
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200629140928.858507-8-nivedita@alum.mit.edu>
 <202006290907.E5EF18A@keescook>
 <CAMj1kXFge5aWL2BY8Y1=m1TonB+SrDq6p7TQWuO5JkzcR2dhjQ@mail.gmail.com>
 <202006290919.93C759C62@keescook>
 <20200629165603.GD900899@rani.riverdale.lan>
 <20200629173735.l3ssrj7m3q5swfup@google.com>
 <CAMj1kXHaXzYFkW_H=w36vMb1qPpuZXsnTd_giq4vsh0bw3S3eA@mail.gmail.com>
 <20200629233405.n56yb4xwlgxrt3fn@google.com>
 <CAMj1kXGTOdNiuU70pFB74UJ6z43AM-UViTSd3=ATV=94W+f1RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGTOdNiuU70pFB74UJ6z43AM-UViTSd3=ATV=94W+f1RA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 06:26:43PM +0200, Ard Biesheuvel wrote:
> On Tue, 30 Jun 2020 at 01:34, Fangrui Song <maskray@google.com> wrote:
> 
> > If (1) is not satisfied, the created .got.plt is just served as an anchor for
> > things that want to reference (the distance from GOT base to some point). The
> > linker will still reserve 3 words but the words are likely not needed.
> >
> > I don't think there is a specific need for another option to teach the linker
> > (GNU ld or LLD) that this is a kernel link.  For -ffreestanding builds, cc
> > -static (ld -no-pie))/-static-pie (-pie) already work quite well.
> 
> You mean 'ld -static -pie' right? That seems to work. Is that a recent
> invention?

gcc -static-pie is fairly recent [0], but it just influences how the
linker is invoked AFAIK (at least for gcc) -- in addition to passing
some linker flags, it will change what startup files get linked in (for
non-freestanding). It does not even imply -fPIE to the compiler, which
is confusing as hell. It _would_ be nice if this also told the compiler
that all symbols (perhaps unless explicitly marked) will be resolved at
static link time, so there is no need to use the GOT or PLT for globals.

As it stands, the executable can still have relocations, GOT and PLT, it
just needs to have startup code to handle them (provided by libc
typically) instead of relying on an external dynamic linker.

I don't think it's really relevant for the kernel build -- all we get is
ld -static --no-dynamic-linker, all -static does is prevent searching
shared libraries, and we already pass --no-dynamic-linker if it's
supported.

[0] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81498
