Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B24C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 214702072C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgESML3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 08:11:29 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:43530 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgESML2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 08:11:28 -0400
Received: by mail-oo1-f66.google.com with SMTP id u190so2748469ooa.10;
        Tue, 19 May 2020 05:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YzPr5ME/rx0mm8f1HXcVFMEaGYLRdecJyu3Hp8Rox/0=;
        b=moydElpkACHe9AeTwO5yZCdav/cqu2Cm4tEQBeiqbdy7nUEpIgzpOskOEriVHtqbDR
         yRt425jmPMTGEZpOwQ702EhmcXkfAwK4ARALS4S4L2ydMXYkYsjCUKjTOukiFTSkSiIO
         2jiEt9c5QhXCc61YXdtGaMUyEYatM/AV2GRfspOpFZMMy/64xwzBRrGjq/HY5ZsLubaf
         ftgPu0v1wAbM0aaqDznfCnWKn/NuGPH2za15WAA/ezX64lMIaNy2mPgpaTfyQodjdfFy
         bsUMn1XksnPiYuLAmE8Wixq9aBKBIavjGHWq40gUmf2ZdvpfzAHE+En1qhAEw9fvoYpV
         gJ7g==
X-Gm-Message-State: AOAM530jjRlgdXmrADi4so0mXY9sQ0pDLt391lYH9VyJTC3JcRk4EXqn
        4oLRoCmbkmMpOQ4h7Rt06GhK0ctUtIyJQR+1Wa0=
X-Google-Smtp-Source: ABdhPJyRSziZNrfSrilLC08tU525imlrr6yhGihg5O4ZATTVfbhCA5/40gAFoQqsQv6KSsH1dU3TNKmkqJKDRrsQJwc=
X-Received: by 2002:a4a:95d0:: with SMTP id p16mr16485117ooi.40.1589890287441;
 Tue, 19 May 2020 05:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200429082134eucas1p2415c5269202529e6b019f2d70c1b5572@eucas1p2.samsung.com>
 <20200429082120.16259-1-geert+renesas@glider.be> <dleftjmu645mqn.fsf%l.stelmach@samsung.com>
 <CAMuHMdXxq6m6gebQbWvxDynDcZ7dLyZzKC_QroK63L8FGeac1Q@mail.gmail.com>
 <20200519094637.GZ1551@shell.armlinux.org.uk> <CAMuHMdU5DG06G4H=+PH+OONMT_9oE==KS=wP+bLgY9xVCez6Ww@mail.gmail.com>
 <CAK8P3a3H=7qx+Rz9sScTVCSMKWGwQ_ROnyoyK73A5yUd+_jbTw@mail.gmail.com>
In-Reply-To: <CAK8P3a3H=7qx+Rz9sScTVCSMKWGwQ_ROnyoyK73A5yUd+_jbTw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 May 2020 14:11:14 +0200
Message-ID: <CAMuHMdV0_GTop+YTPeu+aSFB=1YHsyzLXn-+0fa8upkNMq10bQ@mail.gmail.com>
Subject: Re: [PATCH v6] ARM: boot: Obtain start of physical memory from DTB
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Lukasz Stelmach <l.stelmach@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Eric Miao <eric.miao@nvidia.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Grant Likely <grant.likely@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, May 19, 2020 at 1:28 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, May 19, 2020 at 1:21 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, May 19, 2020 at 11:46 AM Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
>
> > >
> > > > However, something under /chosen should work.
> > >
> > > Yet another sticky plaster...
> >
> > IMHO the old masking technique is the hacky solution covered by
> > plasters.
> >
> > DT describes the hardware.  In general, where to put the kernel is a
> > software policy, and thus doesn't belong in DT, except perhaps under
> > /chosen.  But that would open another can of worms, as people usually
> > have no business in specifying where the kernel should be located.
> > In the crashkernel case, there is a clear separation between memory to
> > be used by the crashkernel, and memory to be solely inspected by the
> > crashkernel.
> >
> > Devicetree Specification, Release v0.3, Section 3.4 "/memory node" says:
> >
> >     "The client program may access memory not covered by any memory
> >      reservations (see section 5.3)"
> >
> > (Section 5.3 "Memory Reservation Block" only talks about structures in
> > the FDT, not about DTS)
> >
> > Hence according to the above, the crashkernel is rightfully allowed to
> > do whatever it wants with all memory under the /memory node.
> > However, there is also
> > Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt.
> > This suggests the crashkernel should be passed a DTB that contains a
> > /reserved-memory node, describing which memory cannot be used freely.
> > Then the decompressor needs to take this into account when deciding
> > where the put the kernel.
> >
> > Yes, the above requires changing code. But at least it provides a
> > path forward, getting rid of the fragile old masking technique.
>
> There is an existing "linux,usable-memory-range" property documented
> in Documentation/devicetree/bindings/chosen.txt, which as I understand
> is exactly what you are looking for, except that it is currently only
> documented for arm64.

Thank you, that looks appropriate!

It seems this is not really used by the early startup code.
Is that because the early startup code always runs in-place, and the
kernel image is not even copied?

> Would extending this to arm work?

Let's see.... Th arm early boot code seems to be more complex than the
arm64 code ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
