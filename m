Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F67C33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB79E2081E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgAMKbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 05:31:42 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37438 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgAMKbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 05:31:41 -0500
Received: by mail-ot1-f68.google.com with SMTP id k14so8478178otn.4;
        Mon, 13 Jan 2020 02:31:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nwyBnoSEdinELT85igJHsZ1qY8Qx+jTBntFKXstTepA=;
        b=B7mKVSuMOCBukSilfxNL742xDQ26NZ+obebecp4V/JX9Ohc+62LdRDCjSyYobO5/g2
         C7pkRv4NhaWccAqa/iPZ0Bw54YE1ZgQTfN7Kfxkw3hdu8yo1PbVq/QtPPaGVEGHEEZRw
         dBvW7BbOWO3wUDXCTazoae9WDa7L8iLc4GOaDK2YYo53iMbrZEUg2mwW7w0ej14MD9us
         W/f63WPbIOUOrfqPOi8EAvDd6eaNCvG0AJnk9G6HOQ43R8592h/M/lpb012k/GeeWEzf
         HXC4K1Xetf/8Pmp0J65RCOl4N0QOq8hvO/cEvuF7m5o45LISK1tC/TvMids0sDa6t9A+
         ukqw==
X-Gm-Message-State: APjAAAUd4ufLX/KNbJXcnkbg+KT8Om+KZEZ3zw7bg3c4RG28E+n3SUmt
        m8vDu1c4CXLLUk7wmIm83BJWkBBKHHYUQpgMLGuUBg==
X-Google-Smtp-Source: APXvYqzXC+kjI3P9VmAc9lrc8grWeRQCK7wyWr3YakvTRRoWeD/XCowwWztxgieS3MEY9G4HyvWAaeyWr69CLc8Awis=
X-Received: by 2002:a05:6830:18c6:: with SMTP id v6mr7675555ote.145.1578911500717;
 Mon, 13 Jan 2020 02:31:40 -0800 (PST)
MIME-Version: 1.0
References: <20191124195225.31230-1-jongk@linux-m68k.org> <CAMuHMdXQAbw_Skj99q_PWXKn77bzVbJf60n38Etmq-zhOoHsHQ@mail.gmail.com>
 <CAMuHMdU9hu+EAAnBD5dH3+LS5pNi9fOjFNesv3eFSCoqbW3CCA@mail.gmail.com>
 <20200113091813.zkye72cubpfhemww@wittgenstein> <CAMuHMdXTqjPQN4UbH5a1BGjFTNLRrwDu97B=JxDii2VCoRjorA@mail.gmail.com>
 <20200113101714.75v5gmg3rb5tlhze@wittgenstein>
In-Reply-To: <20200113101714.75v5gmg3rb5tlhze@wittgenstein>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Jan 2020 11:31:29 +0100
Message-ID: <CAMuHMdUmP4moBKAURp61E=K0-6Jiwi1OFayKS0h-yT17+mKCgQ@mail.gmail.com>
Subject: Re: [PATCH] m68k: Wire up clone3() syscall
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Kars de Jong <jongk@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        "Amanieu d'Antras" <amanieu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On Mon, Jan 13, 2020 at 11:18 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> On Mon, Jan 13, 2020 at 10:34:35AM +0100, Geert Uytterhoeven wrote:
> > On Mon, Jan 13, 2020 at 10:18 AM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> > > On Mon, Jan 13, 2020 at 10:10:26AM +0100, Geert Uytterhoeven wrote:
> > > > On Sun, Jan 12, 2020 at 5:06 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > On Sun, Nov 24, 2019 at 8:52 PM Kars de Jong <jongk@linux-m68k.org> wrote:
> > > > > > Wire up the clone3() syscall for m68k. The special entry point is done in
> > > > > > assembler as was done for clone() as well. This is needed because all
> > > > > > registers need to be saved. The C wrapper then calls the generic
> > > > > > sys_clone3() with the correct arguments.
> > > > > >
> > > > > > Tested on A1200 using the simple test program from:
> > > > > >
> > > > > >   https://lore.kernel.org/lkml/20190716130631.tohj4ub54md25dys@brauner.io/
> > > > > >
> > > > > > Cc: linux-m68k@vger.kernel.org
> > > > > > Signed-off-by: Kars de Jong <jongk@linux-m68k.org>
> > > > >
> > > > > Thanks, applied and queued for v5.6.
> > > >
> > > > Which is now broken because of commit dd499f7a7e342702 ("clone3: ensure
> > > > copy_thread_tls is implemented") in v5.5-rc6 :-(
> > >
> > > Sorry, just for clarification what and how is it broken by
> > > dd499f7a7e342702 ("clone3: ensure > copy_thread_tls is implemented")
> > > ?
> >
> > Because m68k does not implement copy_thread_tls() yet, and doesn't
> > select HAVE_COPY_THREAD_TLS yet.
>
> Oh right, sorry. I forgot that m68k has a patchset to enable clone3() up
> for merging. I should've remembered that and warned you that we will
> have to require copy_thread_tls() going forward. I hope the merge is
> explanatory enough why we're doing it this way.

Yeah, an early warning would have been nice...

> > Looking into fixing that...
>
> Thank you! Much appreciated!

Patch sent.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
