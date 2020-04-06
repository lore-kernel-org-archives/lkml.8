Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13C4C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80509206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgDFVHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:07:35 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:53083 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgDFVHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:07:34 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MCbR7-1jTZSQ1KSJ-009fZ9 for <linux-kernel@vger.kernel.org>; Mon, 06 Apr
 2020 23:07:33 +0200
Received: by mail-qt1-f176.google.com with SMTP id s30so1068998qth.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:07:33 -0700 (PDT)
X-Gm-Message-State: AGi0PuaJFNRJ9ONkviZnrWdzXCbpgxHEu5RsBIl1A2lIiHUtudGOnLey
        Fau0AEzAJdnPL8+0pD+5tItE7vXO/kwZbyAEokk=
X-Google-Smtp-Source: APiQypJvklR62BVRGmCZcvjKj2DUR396sO33hXiHjlqoLa5XgLlgK1Lmk/ehDPxtINzw/SMzw9QCa/BxrvxJYEp+N5w=
X-Received: by 2002:aed:3b4c:: with SMTP id q12mr1557697qte.18.1586207252117;
 Mon, 06 Apr 2020 14:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190205133821.1a243836@gandalf.local.home> <20190206021611.2nsqomt6a7wuaket@treble>
 <20190206121638.3d2230c1@gandalf.local.home>
In-Reply-To: <20190206121638.3d2230c1@gandalf.local.home>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 6 Apr 2020 23:07:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1hsca02=jPQmBG68RTUAt-jDR-qo=UFwf13nZ0k-nDgA@mail.gmail.com>
Message-ID: <CAK8P3a1hsca02=jPQmBG68RTUAt-jDR-qo=UFwf13nZ0k-nDgA@mail.gmail.com>
Subject: Re: libelf-0.175 breaks objtool
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Q8bdLmC5tEAIZFp9/SOoK1IX+IJYkawfUsrp3gONHw2Vmpchyj1
 tKKGao3nbFICBfP7KV9/UOTc9TsiYCd7BAPelScioSxF/dBJ+pbLuDjnh6JO9L2uAz3ypzx
 gTW6/yUTPHx/nxw3i3n9d6Z2HlPeX+Ay3iueI+M/pTpGBJVi+JaOaS8TboZMeGbXGTTm5ko
 2TvEeSMuczXFv1m+nwFcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3rERGaLmkAE=:9RXn0pg/y+LS+zVhhdQlcG
 Zlt3pXqX7qsAVQd/U0e6cqyWq3/+SBjxm/bucyrUVjzclLAORE6/A3qGzEjiGuBENYEQV9fep
 uK3ICiZgwCccCk0N9KDkpgWNofWn3RUFfxK2bQXCYOogK9kpIh/4SUsMxhbMtKg9ZninMgV7A
 NxK+LFs+D/bBS1cGNRlHgu260sWi9v/C5Ekztn5u/RsX3EMi3k5AjNNjx/wdvxOFPGNBpUFut
 iywfQe6Ywps5YeYgaMpxd4L2Gl2vUbZSpR6TA1bM43WxU1FhoGQB7Oe0iD+f1pBxVz6TcvCkq
 aulD42J1R+4Xgxh/dux16OqK+Ir66X/+5zu6Jgbx0OGMHKjbe7Sm2+f+B1xB1HjFatH1dTh99
 kHTfYtHyaiegN4wk7GJff+D/VGH8Ft89615RFQO/2BTlKJwQfc7pDyCDbscPYuH26D7anL8uE
 l+fXHzzqlCA4dWLaZMlMAyBgPhQLlE8bw1izZRCzNtptqKwRAHyVm3Hoh27TIn6RY1JbAMtJ/
 FXoxBGP5taY2lX5kmjgM8sGbkmdIYmI1x0zq5ghQ81thhr9CdyNYl0Z9hzZuyi3xoqqCxbKDW
 E5KSBhzxVWIIPOxlaI3DkXqgwKEHGoyP1FbAO7mAtFmB2AyAdGSTpQCOqn9MKGZkgVTb1JGvX
 pSRNjeK3+QvSIJXh7ZfsPS9cXJj4lbykqd5glCTl5LaGXffI/Cx0I12EqTyeuda8FeJxdSnXx
 LsfWTzDBY2C5u1NfSLTB/aW47e+2HozfxX/cKzZhwoRBeiUxp2obc5TgWy/1K0kJzjuGgOzIM
 /v1Lr085oG9iqbbE7n2yglTTQp4LuOG9QpWDV/kV4jFYvPC1z4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 6, 2019 at 7:32 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 5 Feb 2019 20:16:11 -0600 Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> > On Tue, Feb 05, 2019 at 01:38:21PM -0500, Steven Rostedt wrote:
> > > Just a FYI.
> > >
> > > After a recent upgrade in debian testing, I was not able to build the
> > > kernel. I have a custom build of gcc, so I thought it was strange that
> > > I was getting something like this (took this from the web, as I don't
> > > have the error anymore with the work around, and currently doing a full
> > > build):
> > >
> > > objdump: kernel/.tmp_signal.o: unable to initialize decompress status for section .debug_info
> > > objdump: kernel/.tmp_signal.o: unable to initialize decompress status for section .debug_info
> > > objdump: kernel/.tmp_signal.o: file format not recognized
> > >   CC      arch/x86/kernel/platform-quirks.o
> > > objdump: arch/x86/kernel/.tmp_ebda.o: unable to initialize decompress status for section .debug_info
> > > objdump: arch/x86/kernel/.tmp_ebda.o: unable to initialize decompress status for section .debug_info
> > > objdump: arch/x86/kernel/.tmp_ebda.o: file format not recognized
> > > objdump: mm/.tmp_swap_slots.o: unable to initialize decompress status for section .debug_info
> > > objdump: mm/.tmp_swap_slots.o: unable to initialize decompress status for section .debug_info
> > > objdump: mm/.tmp_swap_slots.o: file format not recognized
> >
> > I installed debian testing on a VM, which has libelf 0.175-2, but I
>
> Hmm, I only have libelf-0.175 (no -2)
>
> > can't recreate.  Can you share your config?
> >
>
> It's just a distro config. Ah, I think it's because I'm compiling my
> own home built gcc. There seems to be an incompatibility with the
> binutils that I used and with libelf-0.175. If I build with just the
> distro gcc, it works.
>
> Bah, this means I need to recreate my gcc that I use to build my
> kernels with :-p As I like to control which gcc I use.

I now see the same problem that you reported using the gcc-9
toolchain I provide on https://kernel.org/pub/tools/crosstool/.

Do you have any other information that might help me fix it?

       Arnd
