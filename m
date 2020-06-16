Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DE4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 21:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAA282082E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 21:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="F/ghH9X9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgFPVg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 17:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgFPVg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 17:36:26 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F8EC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 14:36:25 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y11so299026ljm.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 14:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bo7plRbMTFleyAjLLTsRUvojzHf3AJoP6Ocr+axXXic=;
        b=F/ghH9X9DmUEWE6zdY70+qW2EMy4XuEYpKrGHIQ46jToI4vLQmarz8uCof2DMWQiSz
         GdovuzqALG4go5E32DX+08pEqL2ucxEKPntYnlYwNg5dG6mCbOLgNuDzmD1+hCSgWDeu
         pRvxT1KbsHiuVxW4QHFDrjERKVelRF+AoaIJYCHptV9YGCQMFPElnMBfiFIUBGUB0XrH
         7stQ8rEUIg7UvnDHigx8WWdekBVRNRrhzbs7ya7d1iyQ726E6VvMPb9IEGL433wTFFe2
         HXbW9Xagif8+xF2SIvEye9cV2Kb+g5b6T8GFkV0s8X/lZJVf4hGwMZNwZQ0m0qDgiZJf
         /p1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bo7plRbMTFleyAjLLTsRUvojzHf3AJoP6Ocr+axXXic=;
        b=sDwlxuoOK2YipNJJJOj6dljNyDm0UfG9wl3hVfDK6Jz85k1g+0mcCQoH0dlfkrBLZn
         mjMvjLAZIsNd0BU8MPqTGwUzT/1uXfM9gnEnyZ/wD8mSQ7xwgEtn9WndhaOuSakG8U14
         q/uKpPESDfWJVa801q73pLfjFwv4lu4fjMtTTQ3M8K6XfVUyhLjlg9XrCLSRktSl65Mv
         LyXeAxoMM0Sdtm7Gd+wArsPJXrwLp82YXqzpaM5kMpFxnurzEDlK1kISVyuNfIBF2/nk
         V149dcv6KtuG61I/+VlCATMrcJjGZjKThGxhHsbA+GDSgGxfKttXcCRDjjNRrIR2TSwQ
         xQFg==
X-Gm-Message-State: AOAM530kx6GXgz7JB+6TtUkMNJa293HFp5LPEG6irHUp8pV4sf5MPkhv
        b3Yt/d+H8JOyS5I47Y4V73A9hqx7r2G9iACYvQ==
X-Google-Smtp-Source: ABdhPJxAnuoORWfKNVUMcdyixjIw7M2htJF5QditBWpjtGDO7qldSubUNMy7jh3MHWqwrLh0i4xsD07mO/9tNfNcnFc=
X-Received: by 2002:a2e:6a05:: with SMTP id f5mr2429121ljc.272.1592343383841;
 Tue, 16 Jun 2020 14:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whfuea587g8rh2DeLFFGYxiVuh-bzq22osJwz3q4SOfmA@mail.gmail.com>
 <CAEJqkgi3w+zvMkRBP4VtAewX1UJxrVNRQ03MtRN_yH-PwOOScQ@mail.gmail.com>
 <20200616203352.GA1815527@rani.riverdale.lan> <CAEJqkghzD_6F2N=M65uYHzpOOJ8bvMw18JCfwsiQoH-kToPKLQ@mail.gmail.com>
In-Reply-To: <CAEJqkghzD_6F2N=M65uYHzpOOJ8bvMw18JCfwsiQoH-kToPKLQ@mail.gmail.com>
From:   Gabriel C <nix.or.die@googlemail.com>
Date:   Tue, 16 Jun 2020 23:35:57 +0200
Message-ID: <CAEJqkggDJEC4W9V6ijmPoE0-soKE7zBUWUiDLdCZArEsDo9vrQ@mail.gmail.com>
Subject: Re: Linux 5.8-rc1
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di., 16. Juni 2020 um 23:17 Uhr schrieb Gabriel C
<nix.or.die@googlemail.com>:
>
> Am Di., 16. Juni 2020 um 22:33 Uhr schrieb Arvind Sankar
> <nivedita@alum.mit.edu>:
> > Does this patch help?
> >
>
> I'll test in a bit and let you know.


With the patch the kernel compiles fine.

> > diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> > index b04e6e72a592..088bd764e0b7 100644
> > --- a/arch/x86/purgatory/Makefile
> > +++ b/arch/x86/purgatory/Makefile
> > @@ -34,6 +34,7 @@ KCOV_INSTRUMENT := n
> >  PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
> >  PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss
> >  PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
> > +PURGATORY_CFLAGS += $(call cc-option,-fno-stack-protector)
> >
> >  # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
> >  # in turn leaves some undefined symbols like __fentry__ in purgatory and not
>
