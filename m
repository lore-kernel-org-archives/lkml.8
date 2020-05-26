Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50075C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28FE6207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLDQnXvJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgEZOuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 10:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbgEZOuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 10:50:51 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA302C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 07:50:49 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id h10so22241040iob.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 07:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=FbUiuUW4vTI9FkH1b9x6UXie+S/h0OMRQDnvFR1qG2g=;
        b=VLDQnXvJ1Iip6WbrHt2B62N+h4BW0KXsSq3hB842v+m08Fxi52u03Wqlm7swF7dWqg
         oupSrbl8cpjdvNASkd7UrHQlo8MUX/wNKYiQ8tLQ7+4Jwrlq31ZUwZYkgtbFdWdKYDum
         g3kfW5rjKlvPkhqg2x+d1kCo0y0sXLvJd3NsCh/uBKJn/9q3GdUycW+29cvPSeogXCC8
         x+VspJc4PFV0VSpzmt4Yv2Nz+iGNqStxTWRFSQQE4w1skhwW6W0siPyKQGk0Fn0wS3hV
         pcjGI5RfGwEScytz/QV66rqQ5Gg7XGl0/XmPSOcwN7aBo/y2R+mQKA3yuTzO3PHCV5du
         ZKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=FbUiuUW4vTI9FkH1b9x6UXie+S/h0OMRQDnvFR1qG2g=;
        b=hiF1WeHEWBb1AGIM3wHzj/u/pIo8lXS/jbPbxlytFqJPkMieqxIrXRMXN/nrwbR56w
         n37SpUKO4ltZDOKyTJrxVnuevh9/+3JghrG742Fp97Fu6HKlQw2fYu9YD1gaNS71Hqzx
         O40Kf5sAOWcuoShMwbrGGhV67l40w9jQGxkkHxPPgoo0X1zjBCPEBAV+gISMl35IfTyt
         UOu//zeCum6UzVHJI4fpjpHzT152Mj8oeXk1jpAORbxtgIvg4FdgNY+5PAvC4woq9sKO
         vFddNIKphmw1RxVrSG5YGL4Aqy93Xbn19X4KwW+RnyAaQCM2v/zt1pxx+jRY/r8M4cz0
         8HGw==
X-Gm-Message-State: AOAM531VIoEtZLtcffjyiYVn/5t9yTzzSccBoMOLzjjxaVVerKZGijXM
        4l2BnO5REdAP4HsUPqrhDrxbodylk7/94vj8CiE=
X-Google-Smtp-Source: ABdhPJzcMjbFl0XVgjnxbZ+rm2vYythLblOR+XyGClha8X2NcS+QC0VZ8cr8QGoMettERFZyhRJuPE5ad+ts3sCKJDg=
X-Received: by 2002:a05:6602:1616:: with SMTP id x22mr17674825iow.70.1590504648661;
 Tue, 26 May 2020 07:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200524212816.243139-1-nivedita@alum.mit.edu>
 <20200525225918.1624470-1-nivedita@alum.mit.edu> <CA+icZUVa8FhhwHgXn1o_hFmgqFG6-KE1F+qvkdCzQjmSSSDWDw@mail.gmail.com>
 <CAMj1kXHVFgRsbssJQD2C0GZnOgG=rMYbPGJQtiKhSw6sZj5PaA@mail.gmail.com>
 <CA+icZUWyFDgieQswvfhWemzymDh_UiVqH2uH52a+0otcr2Pd4w@mail.gmail.com>
 <CA+icZUVKRZPFX_Q8RRJnFsHrkM5VbiWUEam+6O5XSzgNaqAzPg@mail.gmail.com> <20200526144748.GA2190602@rani.riverdale.lan>
In-Reply-To: <20200526144748.GA2190602@rani.riverdale.lan>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 26 May 2020 16:50:38 +0200
Message-ID: <CA+icZUUY7a5XGwcQQ511OeoTjOzWbrgF8BZdTrLDK09QWG4hwQ@mail.gmail.com>
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

On Tue, May 26, 2020 at 4:47 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, May 26, 2020 at 02:44:29PM +0200, Sedat Dilek wrote:
> >
> > Are those diffs correct when using "x86/boot: Correct relocation
> > destination on old linkers"?
> >
>
> It looks ok, but that patch (and even marking the other symbols .hidden)
> should be unnecessary after this series.

You mean _bss, _ebss and _end?

- Sedat -
