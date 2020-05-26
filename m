Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0937AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBF1920723
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlMqhymq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbgEZPbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 11:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbgEZPbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 11:31:07 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CE1C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 08:31:07 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x12so16390886qts.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 08:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nVAali8dSpr9v23zA2CiQyVc5uAWU4kfctYwAsBlH/o=;
        b=MlMqhymqjZPS+Xk2oM/nsOGlwmsVKEvRj4bQK8+GHRYvx7kOElq385DciMHFdWZ2pN
         GASgbbgs5hMREcR6xa8j4+PrKAcUIuIBVetVBWfpypo0erTrV+EC1lpQSQmubuOlzucY
         hPblqe0W+D0iSCX2mYKLxLF9ycsTl5mJ7XTnOXIWbOztP301r5zS4/LWrcSFzWRFamxz
         Ng5lqfW4+c8KpRlAtmj+N7aQvvugxtYrPSLWk2xEhuPvLDW7ZbSvJBR3nscZTHMEt2wc
         d6Qx7q2Wld8mQ8o9zjYRS5SH6TO3ik47KhkD9QwpkXfO5t6Ooj89/j5cbP1Zf+mPboKl
         d1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=nVAali8dSpr9v23zA2CiQyVc5uAWU4kfctYwAsBlH/o=;
        b=A3KTFr907yXAcjCcPh0+h1gZuJX+9KjdSRiDEjBm+t0F/ZAN9CvJxuJxszX9Ae4QGi
         FP9rYs4eNYUo7xJ3rnhinpJVuy+HZmZl70Qatwms+jVFG4BOIArBzd7jZslT4KYBGjqO
         JPX4yyTd1CxcLsRS+VXfI/cv5l2xpBnk/WEcbNRlY+lNkmlkbYHEk58vcXdaGHQzFce+
         gn/bIvbyOQw44U6FV/ROLg4+flZnhGh9XJ/1usreMcKVr9t7xtBdtIWXQyTZuBFQxpBA
         8NLm27bTv/fMmZhLfqkHrj9I9/rseZUA7aFj7xvQmiYl6OYneesyWYbjkgdLlJXZ6v8p
         fltQ==
X-Gm-Message-State: AOAM533IlImyph6zD91nZmjODT7vBgwqhjpVIUR4gIpU2uPatc8onse1
        XNCqlPHQUXrSikRthHCSLpQ=
X-Google-Smtp-Source: ABdhPJxnBiPFtjIpt6qPHHje38BhJSIddHhrmpv1FHc/VrjNRsNLAJGH/3oSj7NAnqQw0VXpp90IGQ==
X-Received: by 2002:ac8:768c:: with SMTP id g12mr1859594qtr.51.1590507066478;
        Tue, 26 May 2020 08:31:06 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n63sm7791312qkn.104.2020.05.26.08.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 08:31:05 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 26 May 2020 11:31:04 -0400
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
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
Subject: Re: [PATCH v2 0/4] x86/boot: Remove runtime relocations from
 compressed kernel
Message-ID: <20200526153104.GC2190602@rani.riverdale.lan>
References: <20200524212816.243139-1-nivedita@alum.mit.edu>
 <20200525225918.1624470-1-nivedita@alum.mit.edu>
 <CA+icZUVa8FhhwHgXn1o_hFmgqFG6-KE1F+qvkdCzQjmSSSDWDw@mail.gmail.com>
 <CAMj1kXHVFgRsbssJQD2C0GZnOgG=rMYbPGJQtiKhSw6sZj5PaA@mail.gmail.com>
 <CA+icZUWyFDgieQswvfhWemzymDh_UiVqH2uH52a+0otcr2Pd4w@mail.gmail.com>
 <CA+icZUVKRZPFX_Q8RRJnFsHrkM5VbiWUEam+6O5XSzgNaqAzPg@mail.gmail.com>
 <CA+icZUWTKJ=-OGJPzqm6HNQMkB1uS_B0ydU-9Xa035wB7vA4iw@mail.gmail.com>
 <CA+icZUU54K8z2--6fS=LEaMJGgeWfudViT7ETMsSYF1i59_4mg@mail.gmail.com>
 <CA+icZUWH9fFURgbiCuRr5-mc5s=Ft97_TMP4YofDMX5zEu4_eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+icZUWH9fFURgbiCuRr5-mc5s=Ft97_TMP4YofDMX5zEu4_eA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 05:07:24PM +0200, Sedat Dilek wrote:
> > >
> >
> > Maybe this should be:
> >
> > [ arch/x86/boot/compressed/Makefile ]
> >
> > -KBUILD_CFLAGS += -include hidden.h
> > +KBUILD_CFLAGS += -include ./hidden.h
> >
> 
> NOPE.
> 
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
> - Sedat -

It needs to either be $(srctree)/$(src)/hidden.h, or we should add
-I $(srctree)/$(src) to the KBUILD_CFLAGS. The latter option is added
automatically when building in a separate builddir with O=${KOBJ} (which
is how I, and I assume Ard, was testing), but for some reason is not
added when building in-tree. The -include option doesn't automatically
search the directory of the source file.

-include file Process file as if "#include "file"" appeared as the first
line of the primary source file.  However, the first directory searched
for file is the preprocessor's working directory instead of the
directory containing the main source file.  If not found there, it is
searched for in the remainder of the "#include "..."" search chain as
normal.
