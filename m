Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745CDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D06820787
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTa4zg/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgE0GYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgE0GYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:24:37 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E252EC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:24:36 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id p20so11287416iop.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=LKkJBDDmDnUelXQ6SdnZ3yjotczg+ijTtnQ1G5n/CZI=;
        b=qTa4zg/kB8RUMV6+ZrT87sAhVt0VKd/pe5awQVBeSnQNe+hXtvbc47KeuQ4Ra55ips
         cLQDye/ZnBjLNphTPjLu/vO02z/qBHuE6uLEsnS/nVbpN6qVx91OwWNcTQO26dfwSAjr
         I+I228+hogx9XQRdfPLbXb5hJv/nXcX0qZiv5sQv6yRnP58NW4MpAwQlCvNiS90FqP8z
         4SLKJGHRd9bAoqbqlfkuGhKtKCsWQ/yofXzegcSeUllfPbTSlA9U1lAfEfEx36oMJLOA
         tJIMkc2bBztsLzh5o+auXTj/26URwHSRShn2+xIowzj9kqTqbIUaaj3SsObYFnhdbIB9
         /BJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=LKkJBDDmDnUelXQ6SdnZ3yjotczg+ijTtnQ1G5n/CZI=;
        b=FzLDWJBT3EaUkkuFbubsu99mwfuG1OdCLVlJcaxtDUpVykMsvg5+w3Z/B75Qg3qQAJ
         kG4EtoQCTPAeYLL3wnw5pQ5Kzsfi9atv0Z/pJs/jFu0/1FXrrlZZzMq7t148WnvsTPmI
         rrXvD1GiUcdJg2tKIKPovdW6gfmEW7FNBGQEWIXBvRk96qfC2PqSuwbLAiAusvWoeEJI
         nrZL0I1faEhTpNmFLEfyiMPrgvY207giP/TEHWzBn4d+LdPsLUd/e7BG+ERbTS0QC5s4
         qwdInbD20jEZyHkW4ZFFNfT9ub9SwoN7IkfuCbg5k1JkFpsqnXwmwuZwsQr4Gsol9X7D
         8kjg==
X-Gm-Message-State: AOAM5330LS9jENFSb68HGEKQ79zAucn4dtJRU/TMfu9dSWtRQkSq9uzu
        yeX4XVDLXzjFxhmbjeJkHteZYH0PodGng6ShKKI=
X-Google-Smtp-Source: ABdhPJxqpy9fr4YgzdFZPoW85wjj4f3FVV5gKI8JezQjtXRzE5yjML78Xrs2My8MAN62PI5W2P3Xrasd+Fe3j/je1Rg=
X-Received: by 2002:a02:ca18:: with SMTP id i24mr4295860jak.70.1590560676311;
 Tue, 26 May 2020 23:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200524212816.243139-1-nivedita@alum.mit.edu>
 <20200525225918.1624470-1-nivedita@alum.mit.edu> <CA+icZUVa8FhhwHgXn1o_hFmgqFG6-KE1F+qvkdCzQjmSSSDWDw@mail.gmail.com>
 <CAMj1kXHVFgRsbssJQD2C0GZnOgG=rMYbPGJQtiKhSw6sZj5PaA@mail.gmail.com>
 <CA+icZUWyFDgieQswvfhWemzymDh_UiVqH2uH52a+0otcr2Pd4w@mail.gmail.com>
 <CA+icZUVKRZPFX_Q8RRJnFsHrkM5VbiWUEam+6O5XSzgNaqAzPg@mail.gmail.com>
 <CA+icZUWTKJ=-OGJPzqm6HNQMkB1uS_B0ydU-9Xa035wB7vA4iw@mail.gmail.com>
 <CA+icZUU54K8z2--6fS=LEaMJGgeWfudViT7ETMsSYF1i59_4mg@mail.gmail.com>
 <CA+icZUWH9fFURgbiCuRr5-mc5s=Ft97_TMP4YofDMX5zEu4_eA@mail.gmail.com> <20200526153104.GC2190602@rani.riverdale.lan>
In-Reply-To: <20200526153104.GC2190602@rani.riverdale.lan>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 27 May 2020 08:24:26 +0200
Message-ID: <CA+icZUWzfOnaSL2vOB+UdiXZQe-Ywn9RVpdFkbHqozcDzcyo2Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] x86/boot: Remove runtime relocations from
 compressed kernel
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
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

On Tue, May 26, 2020 at 5:31 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, May 26, 2020 at 05:07:24PM +0200, Sedat Dilek wrote:
> > > >
> > >
> > > Maybe this should be:
> > >
> > > [ arch/x86/boot/compressed/Makefile ]
> > >
> > > -KBUILD_CFLAGS += -include hidden.h
> > > +KBUILD_CFLAGS += -include ./hidden.h
> > >
> >
> > NOPE.
> >
> > This works:
> >
> > [ arch/x86/boot/compressed/Makefile ]
> >
> > -KBUILD_CFLAGS += -include hidden.h
> > +KBUILD_CFLAGS += -include ./arch/x86/boot/compressed/hidden.h
> >
> > $ ll arch/x86/boot/bzImage arch/x86/boot/compressed/vmlinux
> > -rw-r--r-- 1 dileks dileks 6,5M Mai 26 17:05 arch/x86/boot/bzImage
> > -rwxr-xr-x 1 dileks dileks 6,5M Mai 26 17:05 arch/x86/boot/compressed/vmlinux
> >
> > - Sedat -
>
> It needs to either be $(srctree)/$(src)/hidden.h, or we should add
> -I $(srctree)/$(src) to the KBUILD_CFLAGS. The latter option is added
> automatically when building in a separate builddir with O=${KOBJ} (which
> is how I, and I assume Ard, was testing), but for some reason is not
> added when building in-tree. The -include option doesn't automatically
> search the directory of the source file.
>
> -include file Process file as if "#include "file"" appeared as the first
> line of the primary source file.  However, the first directory searched
> for file is the preprocessor's working directory instead of the
> directory containing the main source file.  If not found there, it is
> searched for in the remainder of the "#include "..."" search chain as
> normal.

Will you send a follow-up or a v3 for this?

- Sedat -
