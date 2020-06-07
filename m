Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5926DC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 17:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C22420659
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 17:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgFGRl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 13:41:58 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37850 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgFGRl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 13:41:57 -0400
Received: by mail-oi1-f193.google.com with SMTP id a3so1216804oid.4;
        Sun, 07 Jun 2020 10:41:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mQJfVlcJ7JmVpiY5UxgE7ElosJdOo6Jg9Pl/1tvjxg0=;
        b=YTroi0TLnjCdJSXQ4oOv4L2nVx5RIj8UquLyqmxP3opAx8YFoGOI6s1gppj43f/jZl
         HjwjFs0T2QNF8R4PvYyMaaVxrRkr9xky7xT1VFo1iP/Yh6xpyxJoMDsWlNsUuLIQmh9n
         /kUHAjJ2jYrrKa6jLMx18FVE3QnN2+hK4m2y6hSwwFgqLqWqHaX0Fk8oDBEUdK7HQ19F
         3bb7dSpq1ABuRMMniA3lIl/ojEm0BVSIHCKOEMmWbjCMw5UPR4VQPO5kUE2eODiFHL1t
         ptGbK5u5P1FD/0HXBdYPNEoop/Eh7k9STsM5w7NAuSez3SwfTrRf8OmM7aqj9DAnkXaO
         fJug==
X-Gm-Message-State: AOAM53396pTA+cmbew+iU+vALUK537EkZUCBYzuVtIYavt2XOTK7QxRh
        M4LvDc0P2dPuq1XrwIxqXdvzfvmOkuB3zz2gKMM=
X-Google-Smtp-Source: ABdhPJxvgvICQ9ES5Ct5NdRo84WTGl2cg/CETWMVmgEhmPtU9IV6i+KCWwpnNVXMICyGZI7QrL+MYFKgfYQi8KhtI/o=
X-Received: by 2002:a54:4006:: with SMTP id x6mr1041165oie.148.1591551716688;
 Sun, 07 Jun 2020 10:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <1590586141-21006-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdX+M+k-JRy1Ps=hRZR=mSuexSQbJ0+Cw1337uO6nak_qQ@mail.gmail.com> <CA+V-a8vDVa0DSX_XT=NsmBta4O=v0p_Nn9M5x9N7gw_zc0yoyg@mail.gmail.com>
In-Reply-To: <CA+V-a8vDVa0DSX_XT=NsmBta4O=v0p_Nn9M5x9N7gw_zc0yoyg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 7 Jun 2020 19:41:44 +0200
Message-ID: <CAMuHMdUpqbzvbm4Dwt3PYB_irzNXERdSnH5KOmO-myo_=r7cAA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: r8a7742-iwg21d-q7-dbcm-ca: Add device tree for
 camera DB
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Sun, Jun 7, 2020 at 6:19 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Fri, Jun 5, 2020 at 1:27 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Wed, May 27, 2020 at 3:29 PM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > Add support for the camera daughter board which is connected to
> > > iWave's RZ/G1H Qseven carrier board. Also enable ttySC[0135] and
> > > ethernet1 interfaces.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > > --- /dev/null
> > > +++ b/arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ca.dts
> >
> > > +&scifb1 {
> > > +       pinctrl-0 = <&scifb1_pins>;
> > > +       pinctrl-names = "default";
> > > +       status = "okay";
> >
> > Before I queue this in renesas-devel for v5.9, I have on question:
> > As this port carries RTS/CTS signals, perhaps you want to add
> >
> >     rts-gpios = <&gpio4 21 GPIO_ACTIVE_LOW>;
> >     cts-gpios = <&gpio4 17 GPIO_ACTIVE_LOW>;
> >
> Aaha the user manual mentioned RTS/CTS wasn't connected, but I tested
> this with the above which disproves the Doc. Shall I post it as a

RTS/CTS are indeed not connected to the dedicated RTS/CTS pins of
SCIFB1, so the documentation is right.
However, the pins on the serial port connector can be used as GPIOs,
hence they can be used with software-controlled RTS/CTS.

> separate patch or post a v2 including it.

Up to you, I can handle both.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
