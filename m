Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_ABUSE_SURBL,
	URIBL_BLACK autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE23C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFB172074F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbgDTPJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:09:19 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:33771 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgDTPJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:09:18 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MSLAe-1jolyG1rNA-00Sdja; Mon, 20 Apr 2020 17:09:16 +0200
Received: by mail-qt1-f180.google.com with SMTP id s30so8728005qth.2;
        Mon, 20 Apr 2020 08:09:16 -0700 (PDT)
X-Gm-Message-State: AGi0PuY3z8D16zKoWUD4YVPM+iyj+k1LVIvV+OUtnVYjaA39ULZVS5yE
        fGpt8ftaLogAq3qRxhKIjow6BwsS1MWO+M/AlV8=
X-Google-Smtp-Source: APiQypJgseXmlO6GHKcMOD3zsvuToKgCjFz6eeo4chliJJ+LnwdpDCUCjr2uKYzQRrYo6R5GA9ERvuoEBEzqxVkv29Y=
X-Received: by 2002:ac8:2bce:: with SMTP id n14mr5618911qtn.18.1587395355149;
 Mon, 20 Apr 2020 08:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200420123844.3998746-1-arnd@arndb.de> <CAMuHMdUZR9A+nCYL_uUOJt48FQnJTJ9eMwWUuV-Z0UWJZ8SaSA@mail.gmail.com>
In-Reply-To: <CAMuHMdUZR9A+nCYL_uUOJt48FQnJTJ9eMwWUuV-Z0UWJZ8SaSA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Apr 2020 17:08:58 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2y4n-jv3eNWW4q__YP=QA7UDuybs4nBwdTuiqWm247Tg@mail.gmail.com>
Message-ID: <CAK8P3a2y4n-jv3eNWW4q__YP=QA7UDuybs4nBwdTuiqWm247Tg@mail.gmail.com>
Subject: Re: [PATCH 1/2] sh: remove sh5 support
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:K0FNXlbtXhDJYQno5K5L8jeEwJIrm2WxH8RgAIO5FZWELRYRGtN
 APx6kiZrV8Qj/f+nUBcEE3BTMjihf3MLusHcMmyXDC4l5wc4eitrTOWQRseIU41KFxRdsFe
 hUgae+wAhC51FljF56shldTh62uRaIvGXhQBWZAVUfpB4okzsuF8b4kaoYTp2sS/HamroT1
 GeAUlXDcxV8H2kPAHeBig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:urC7Rm9uIhA=:BdHT/5sokzOpk/ze7DDZfr
 8GjCVmtbmj559dHAZa8paq3Dy24r82QXm3d807d6Ekxy6AQd/4gUtDiD05eeEwjRAmqtS2sMh
 QdW3H6h+2cmdRT1cK/Q9pW2abH43e8PnIHHiRUaUWUzAHlttH8jNxQg4N3WfJsPHUHrbgnCRb
 evLDrPstXa43hY5R44s9GGRVoXs9GCVe3P0hR76U75ZUhbJntmRgTeRga1wesaYVZzqvFxRkR
 FQd8TyKXT7WtBfFTqioOMSAuiNCu5PqTL3y1F3Prb6RZ5NZcaYxoIQmWTIDqhVdAQ76S1o6la
 upp4RJ68hdnqyQQyFuYblr9e6gOeV6CQeaA300ez3Ld5XIDIO/Ju4C3skcWRvA/a9YTz8Iip0
 kVvIONVHOlLTDAHnWJHhqxzuyYGF+noifDq+jC7Vnl1ms5RrJxosy54CisbonJ/pGEC6S0toz
 RYIx7rT8KEEE1XuvESMaCj1p7gL+JkSKRE2dxLSVh5dUQ40wLA3Z/Z+8X5GU4wSmUowMoYyQs
 ds1pK2p6ykRLEFg8zknfpsF5FUSVo1g/rQaDf42XiCeKwq590BBT5LBX133g/hBdkg+SGbxeJ
 BT2dtVW63Mf1v+jIk7fCx8qyvUlRFJZp5ZAk5Cwl36YsgTpeiiJjq7/y4irokWycQF/+lh9lj
 q6Ls2ks5cm8nKuN713gNKBv69Tw4sgGgXU0yr7vQGmYrCvfAXiCjEMSLHD7F3fo8kdorVgyqx
 7+5SEddf63C3RfbIOUACo8624KAMD50++PeyMdWLRo72Dbul89iU/T3YnA+Xs7aFSncZIqowj
 JlctqlWyTo/2nEOiHxqLzEwqFn/BC3xfEmIjG6xlR52qvHzudM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 4:40 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Arnd,
>
> On Mon, Apr 20, 2020 at 2:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > sh5 never became a product and has probably never really worked.
> >
> > Remove it by recursively deleting all associated Kconfig options
> > and all corresponding files.
>
> Thanks a lot!
>
> > For review purposes, this leaves out the files that can now be
> > removed, in particular
> >
> >  arch/sh/drivers/pci/*-sh5.c
> >  arch/sh/include/asm/*_64.h
> >  arch/sh/include/uapi/asm/*_64.h
> >  arch/sh/include/cpu-sh5/*
> >  arch/sh/kernel/cpu/sh5/*
> >  arch/sh/lib64/*
> >  arch/sh/mm/*-sh5.c
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> A few nits below...
>
> > --- a/arch/sh/Kconfig
> > +++ b/arch/sh/Kconfig
> > @@ -62,7 +62,7 @@ config SUPERH
> >           <http://www.linux-sh.org/>.
> >
> >  config SUPERH32
>
> Why keep the SUPERH32 symbol?
> Because you forgot to clean a few files?

It seemed simpler this way, but I can remove it as well.

>     arch/sh/include/asm/bl_bit.h:#ifdef CONFIG_SUPERH32
>     arch/sh/include/asm/cache_insns.h:#ifdef CONFIG_SUPERH32
>     arch/sh/include/asm/checksum.h:#ifdef CONFIG_SUPERH32

Ah, I had removed these at first when I renamed the *_32.h over
those files, but then decided to not do that, to keep the patch
easier to review.

> > --- a/arch/sh/include/asm/vmlinux.lds.h
> > +++ b/arch/sh/include/asm/vmlinux.lds.h
> > @@ -15,12 +15,6 @@
> >  #define DWARF_EH_FRAME
> >  #endif
> >
> > -#ifdef CONFIG_SUPERH64
> > -#define EXTRA_TEXT             \
> > -       *(.text64)              \
> > -       *(.text..SHmedia32)
> > -#else
> >  #define EXTRA_TEXT
> > -#endif
>
> You might remove the empty definition, too, as you removed the sole user...

Right, I planned to remove that one and forgot.

> > --- a/arch/sh/kernel/vmlinux.lds.S
> > +++ b/arch/sh/kernel/vmlinux.lds.S
>
> > @@ -28,14 +21,13 @@ SECTIONS
> >
> >         _text = .;              /* Text and read-only data */
> >
> > -       .empty_zero_page : AT(ADDR(.empty_zero_page) - LOAD_OFFSET) {
> > +       .empty_zero_page : AT(ADDR(.empty_zero_page)) {
> >                 *(.empty_zero_page)
> >         } = 0
> >
> > -       .text : AT(ADDR(.text) - LOAD_OFFSET) {
> > +       .text : AT(ADDR(.text)) {
> >                 HEAD_TEXT
> >                 TEXT_TEXT
> > -               EXTRA_TEXT
>
> ... here.
>
> >                 SCHED_TEXT
> >                 CPUIDLE_TEXT
> >                 LOCK_TEXT
>
> I think at least some of the following should be cleant, too:
>
> arch/sh/include/asm/elf.h:#ifdef __SH5__
> arch/sh/include/uapi/asm/posix_types.h:# ifdef __SH5__
> arch/sh/include/uapi/asm/swab.h:#ifdef __SH5__
> arch/sh/include/uapi/asm/swab.h:#ifdef __SH5__
> arch/sh/include/uapi/asm/unistd.h:# ifdef __SH5__
> tools/arch/sh/include/asm/barrier.h:#if defined(__SH4A__) || defined(__SH5__)

Good catch, thanks!

        Arnd
