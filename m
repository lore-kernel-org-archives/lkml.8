Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A32FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0008720776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t5yTsL+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbgEZQSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 12:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgEZQST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:18:19 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B36C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 09:18:19 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id b71so20997400ilg.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 09:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=W2wCu2SdkHFkQ1Ckp39G9Z9PbrnS7bq9ACqqoB/0oa0=;
        b=t5yTsL+h2v6+Ce1k3GlaF5U0JrOWNaUPUg/e1r1fcDTUHtAK5AnNjKMAhyWAOHlLI/
         xxJDCc9kLYKPIdB8NbL3qbEES2tg+Fpsmjiscv77V2oH2qwD6dLsBAByDOzObFY3Iqu1
         u33Pm/cHUJUpMWEb0wEa8zA85tblduq1Aj5yENvu3jXcAKpYTIue9wxmkvZ4wVmwHyOX
         7W+OPgEGiyGjkGqIpXxeAK7Oy0q5SCtyPv79OrunKD2WCopoKMsGkb/mVHAD7aElf0TE
         v6RRFvUsk2Vz3c1kn59aRZnd4+Il4p0okDB++weWCUGWM71V42o/K0dc+6sl7htA/fae
         oZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=W2wCu2SdkHFkQ1Ckp39G9Z9PbrnS7bq9ACqqoB/0oa0=;
        b=Y0di3fUq2is1tSg3F/pW+ounzvub7Xqs3vMX02DmZ/EiAv37oMeG4jGLdVdfPCDVId
         49ItDVdMA/XmFMIicyCfSGNh8hX9KjqieSmmopxJJjMu8+X6q601PxN9rdzdAD2ksoOA
         LP/91j67MZ8E26hjW2DprlhWWJiTfZmyFuciNqnxlLvTKVVpjvuOE+l3AKjUmm99pccE
         x8Sd7J/HGCBINWRyo0z5jYcx0bjTBYR7hO4PsAfZCZQeF2XJ3IiJj6TfWx6G2eT6DaKR
         L4QDDMgyE6P+8BnBt4gnitXykSiet+MNdDKJ5v7+awbgvhEKkgjjq6EZt8S6sIIpaLOA
         HoBA==
X-Gm-Message-State: AOAM533d1wCT3SbS3LE4hFSj+GcTTCYdQ+i5sVdUmpOR4TpWzUBZyXBk
        tb7UBUndELu8vge5UU0XGtCQ7Ex6PaYCfhF8CLw=
X-Google-Smtp-Source: ABdhPJykHuavW6UtEQRUWuCrUgwkuPBC0czhoJQVGm4eoWyDiIj2oNgHKKrpwlJ0ewPymE+knZ8REsyv6WVfZ7jQHqM=
X-Received: by 2002:a92:5893:: with SMTP id z19mr1947013ilf.255.1590509898761;
 Tue, 26 May 2020 09:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200524212816.243139-1-nivedita@alum.mit.edu>
 <20200525225918.1624470-1-nivedita@alum.mit.edu> <CA+icZUVa8FhhwHgXn1o_hFmgqFG6-KE1F+qvkdCzQjmSSSDWDw@mail.gmail.com>
 <CAMj1kXHVFgRsbssJQD2C0GZnOgG=rMYbPGJQtiKhSw6sZj5PaA@mail.gmail.com>
 <CA+icZUWyFDgieQswvfhWemzymDh_UiVqH2uH52a+0otcr2Pd4w@mail.gmail.com>
 <CA+icZUVKRZPFX_Q8RRJnFsHrkM5VbiWUEam+6O5XSzgNaqAzPg@mail.gmail.com>
 <CA+icZUWTKJ=-OGJPzqm6HNQMkB1uS_B0ydU-9Xa035wB7vA4iw@mail.gmail.com>
 <CA+icZUU54K8z2--6fS=LEaMJGgeWfudViT7ETMsSYF1i59_4mg@mail.gmail.com> <CA+icZUWH9fFURgbiCuRr5-mc5s=Ft97_TMP4YofDMX5zEu4_eA@mail.gmail.com>
In-Reply-To: <CA+icZUWH9fFURgbiCuRr5-mc5s=Ft97_TMP4YofDMX5zEu4_eA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 26 May 2020 18:18:07 +0200
Message-ID: <CA+icZUV2fvwQTnzUmWCiv4unzFb7HjUSTrYgHeYd0dgFi=oLMw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] x86/boot: Remove runtime relocations from
 compressed kernel
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 5:07 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:

...

> > > patchset to previous build:
> > >
> > > $ git log --no-merges --oneline 5.7.0-rc7-1-amd64-clang..5.7.0-rc7-2-amd64-clang
> > > 8b74901cb9e5 (for-5.7/x86-boot-remove-runtime-relocations-from-compressed-kernel-v2-nivedita76)
> > > x86/boot: Check that there are no runtime relocations
> > > 83fb1bc3b076 x86/boot: Remove runtime relocations from head_{32,64}.S
> > > fede23dacbbd x86/boot: Remove run-time relocations from .head.text code
> > > 3e5ea481b8fb x86/boot: Add .text.* to setup.ld
> > > bec910ba3d67 x86/boot/compressed: Get rid of GOT fixup code
> > > be834cee6f39 x86/boot/compressed: Force hidden visibility for all
> > > symbol references
> > > 9b7c7d8d2d7b x86/boot/compressed: Move .got.plt entries out of the .got section
> > > ba6a49f806a0 (for-5.7/kbuild-compressed-debug-info) Makefile: support
> > > compressed debug info
> > > a1fb11944d11 (for-5.7/x86-boot-nivedita76) x86/boot: Correct
> > > relocation destination on old linkers
> > > c70e3890058f (for-5.7/x86-build-maskray) x86/boot: Discard
> > > .discard.unreachable for arch/x86/boot/compressed/vmlinux

...

> This works:
>
> [ arch/x86/boot/compressed/Makefile ]
>
> -KBUILD_CFLAGS += -include hidden.h
> +KBUILD_CFLAGS += -include ./arch/x86/boot/compressed/hidden.h
>
> $ ll arch/x86/boot/bzImage arch/x86/boot/compressed/vmlinux
> -rw-r--r-- 1 dileks dileks 6,5M Mai 26 17:05 arch/x86/boot/bzImage
> -rwxr-xr-x 1 dileks dileks 6,5M Mai 26 17:05 arch/x86/boot/compressed/vmlinux
>

I was able to build/link and boot on bare metal.

root@iniza:~# cat /proc/version
Linux version 5.7.0-rc7-2-amd64-clang (sedat.dilek@gmail.com@iniza)
(clang version 10.0.1rc1, LLD 10.0.1rc1) #2~bullseye+dileks1 SMP
2020-05-26

- Sedat -
