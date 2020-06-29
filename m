Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5806DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B0E7206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593457827;
	bh=eQgDUs7J8VJ3ysHeL4WQSn/WO/okfHnq/562AgtsAk0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ENHYA0GkvMg/rnD59zOsIosknfHxgDIHdmxcQTJgG2c6SwqdaS5QQmZtAKkcTV8DD
	 TCRZviTTB9JTj4yD/eiTVynOH8AuCLpibyrhaCEqGB5oWYPWUjLcsar9IGW46ETqcq
	 dh3wNx7RfYqCkAxSFl1Fz2DFs8pc88zhuzsds5Xg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbgF2TKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:10:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730958AbgF2TKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:10:18 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD12B2549E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 15:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445872;
        bh=eQgDUs7J8VJ3ysHeL4WQSn/WO/okfHnq/562AgtsAk0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sWtK2vH7PYP2j67ezQzJinF0yOJF+6ZsFB2IytMjLVWP4giLRm4ykPrk7oDW5qgSg
         wIN8EeaGhVXUlPqcRVpEQe8bSW7YUQ0m6YRDEgbRsnB/EgKnOFVKBctGnOJS3AT4th
         MK5gWfzupsZmaePqKZCKr/bdvO+Ji/aHR2/+ONrE=
Received: by mail-ot1-f51.google.com with SMTP id w17so8097543otl.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:51:12 -0700 (PDT)
X-Gm-Message-State: AOAM533LJJIOmfTx51AOC/NQqrLoXjHPjkAE6Fr3KLs2T+A1e/iNQQbl
        4Bs3GuQvu2C677ybgpZcC0urwkg5WQ9VqWxc204=
X-Google-Smtp-Source: ABdhPJxoGhtLOjs947FbLWqrlNCz9FYMKZhXHzbCv6ALUOXtCy7zU3GxZ2fjFFMn6idB3tk9YO4q0/ZbO7nZZNkcxmQ=
X-Received: by 2002:a9d:688:: with SMTP id 8mr13766245otx.108.1593445871914;
 Mon, 29 Jun 2020 08:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200629140928.858507-2-nivedita@alum.mit.edu> <202006290846.5A5C76A4D7@keescook>
 <20200629155011.GA900899@rani.riverdale.lan>
In-Reply-To: <20200629155011.GA900899@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 29 Jun 2020 17:51:00 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH1Fx3c4fZRVgNPeXnPFbHWVhgywU0Jvu65=wBaR_5yjA@mail.gmail.com>
Message-ID: <CAMj1kXH1Fx3c4fZRVgNPeXnPFbHWVhgywU0Jvu65=wBaR_5yjA@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] x86/boot/compressed: Move .got.plt entries out of
 the .got section
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
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

On Mon, 29 Jun 2020 at 17:50, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Mon, Jun 29, 2020 at 08:48:05AM -0700, Kees Cook wrote:
> > On Mon, Jun 29, 2020 at 10:09:22AM -0400, Arvind Sankar wrote:
> >
> > This is also being done on arm64, and the section was specified slightly
> > differently (with INFO) which maybe should be done here too?
>
> I was actually just about to email you to ask what that INFO is for :)
> What does it do?
>

It makes the section non-allocatable, so it is dropped from the final image

> >
> >        .got.plt (INFO) : { *(.got.plt) }
> >        ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, ".got.plt not empty")
> >
> > Otherwise, yes, looks good.
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> >
> > > +
> > >     .data : {
> > >             _data = . ;
> > >             *(.data)
> > > @@ -77,3 +80,9 @@ SECTIONS
> > >
> > >     DISCARDS
> > >  }
> > > +
> > > +#ifdef CONFIG_X86_64
> > > +ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")
> > > +#else
> > > +ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0xc, "Unexpected GOT/PLT entries detected!")
> > > +#endif
> > > --
> > > 2.26.2
> > >
> >
> > --
> > Kees Cook
