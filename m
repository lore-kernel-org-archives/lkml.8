Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC02C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8812B20873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k01xuh9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbgCISss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 14:48:48 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39979 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbgCISss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:48:48 -0400
Received: by mail-ed1-f65.google.com with SMTP id a13so13235619edu.7;
        Mon, 09 Mar 2020 11:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qWrsl32qHpilWV/XCx5BXLITX0gPhJAl46t1TBxRgR4=;
        b=k01xuh9XG1Z4SBrMkd/zGm4p4yp74gMOhxa0n7xVJdPk3+qhOQ69G0t87RP1C9N59r
         rAS1VAIhu7t0cRdcdpXJl+7b5AdlGuKOTn9wAeKU1KBzSWAXTuUd8jiDLWbIujGeL1iZ
         +nHZng86v2VrroZj7hNgVNMmdVvDA77Z0Qoq2Ysa3oC6WCrCFx6Kas+tiwD0/09pk05/
         rNXefV+wqToBBQXUNogGDJsctPBhHVXsuoJpvIzIBAmXKFzgBmHh54SZDZvz9ZJ46ub7
         tcpwa3VZoiEEmIEm0GUkw7B+1PRS2FspF1f+gkW1wRy09OLpqrx4MJznpjLNF1XdSJy3
         DSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qWrsl32qHpilWV/XCx5BXLITX0gPhJAl46t1TBxRgR4=;
        b=FMEdOp1vFpLd9qV/8NArbIT0DFzKRLW7Fm+YkrBDffnCU4QppsQUzpptJQOs5ksgJM
         nGBXCylIs6N5Vnbf+TZ0XqR3YMjdY1L5AqulOCJ+gFvqu66UQhnE2QNBQS2sZetmE7Jb
         RcFJBew8LM+KBVNQ8Py5OAqhO12tLrvYTOIzb5EdXo3hwxgZY+B07NqcSWOtr+R7RI7D
         vecd273a/fzu4jRWVJe9p1qZ437gEeevcFe5QIu/1Sr+rapUkK5wLRyOa466BLX8Jpmp
         P0CPfl+l/P4Fr4/kpyLutFz4XuLa0TBZOVu+0UVrTXzHVQqcgJHGlsCVZj0OGbt3ePsa
         LP0A==
X-Gm-Message-State: ANhLgQ09EiK4Vktg4DNBGFbrQEOuc+9hScr2AuyZTs2o4YL1fSmVsa+c
        86Qi5M+I9729wF7DSA8D9KP+ClJfmSMntIVTp5s=
X-Google-Smtp-Source: ADFU+vuyelPYuKsivLfPWAbf49oyaiuulrte7wYNhTJ0Yy6rU/GC2YkYyD6frR1DJpShkNmH8LGgYxj26XGaOqEnreo=
X-Received: by 2002:a50:fd89:: with SMTP id o9mr18930405edt.179.1583779725569;
 Mon, 09 Mar 2020 11:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200309145624.10026-1-olteanv@gmail.com> <f530a0740f34b2cf26a8055d4eae2527@walle.cc>
 <CA+h21hrSezjwKJDCd1wN8qk5koWfPmwT0Mx+sR7fHxo1sCGcjw@mail.gmail.com> <6da04c9a17fa9e6259a462cb52312930@walle.cc>
In-Reply-To: <6da04c9a17fa9e6259a462cb52312930@walle.cc>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Mon, 9 Mar 2020 20:48:34 +0200
Message-ID: <CA+h21hopP2XTx55iu_pG=xBx-TSPRBbdmoU7T2F0Gc9Qt=CsSQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] NXP DSPI bugfixes and support for LS1028A
To:     Michael Walle <michael@walle.cc>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        angelo@sysam.it, andrew.smirnov@gmail.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wei Chen <weic@nvidia.com>, Mohamed Hosny <mhosny@nvidia.com>,
        peng.ma@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Mar 2020 at 20:31, Michael Walle <michael@walle.cc> wrote:
>
> Am 2020-03-09 19:14, schrieb Vladimir Oltean:
> > On Mon, 9 Mar 2020 at 20:03, Michael Walle <michael@walle.cc> wrote:
> >> Am 2020-03-09 15:56, schrieb Vladimir Oltean:
> >> > From: Vladimir Oltean <vladimir.oltean@nxp.com>
> >> >
> >> > This series addresses a few issues that were missed during the previous
> >> > series "[PATCH 00/12] TCFQ to XSPI migration for NXP DSPI driver", on
> >> > SoCs other than LS1021A and LS1043A. DMA mode has been completely
> >> > broken
> >> > by that series, and XSPI mode never worked on little-endian
> >> > controllers.
> >> >
> >> > Then it introduces support for the LS1028A chip, whose compatible has
> >> > recently been documented here:
> >> >
> >> > https://lore.kernel.org/linux-devicetree/20200218171418.18297-1-michael@walle.cc/
> >>
> >> If it is not compatible with the LS1021A the second compatible string
> >> should be removed. Depending on the other remark about the endianess,
> >> it might still be compatible, though.
> >>
> >
> > Please feel free to remove it. I wasn't actually planning to add it in
> > the first place, but now it that it's there it doesn't really bother
> > anybody either.
>
> But it won't work if the endianess depends on the compatible string ;)
>

True.

> >>
> >> > The device tree for the LS1028A SoC is extended with DMA channels
> >> > definition, such that even though the default operating mode is XSPI,
> >> > one can simply change DSPI_XSPI_MODE to DSPI_DMA_MODE in the
> >> > devtype_data structure of the driver and use that instead.
> >>
> >> wouldn't it make more sense, to use DMA is the dma node is present
> >> in the device tree? otherwise use XSPI mode? I don't think it is
> >> really handy to change the mode inside the driver.
> >>
> >
> > Let's keep it simple. The driver should configure the hardware in the
> > most efficient and least buggy mode available. Right now that is XSPI.
> > The hardware description (aka the device tree) is a separate topic. If
> > there ever arises any situation where there are corner cases with XSPI
> > mode, it's good to have a fallback in the form of DMA mode, and not
> > have to worry about yet another problem (which is that there are 2
> > sets of device tree blobs in deployment).
>
> Point taken. But this is not how other drivers behave, which uses the
> DMA if its given in the device node.
>

Also true.

> Btw. do other SoCs perform better with DMA?
>

Not that I know of.
My general rule of thumb for this controller is: if it supports XSPI
then use that, otherwise use DMA. Luckily there is just one controller
that supports none of those, and that would be Coldfire, which uses
the braindead EOQ mode. I don't have the hardware to do testing on
that, but in principle if I did, I would have converted that as well
to the more functional but less efficient TCFQ mode (now removed).

> -michael
>
> > TL;DR: These DMA channels don't really bother anybody but you never
> > know when they might come in handy.
> >
> >> -michael
> >>
> >> >
> >> > For testing, benchmarking and debugging, the mikroBUS connector on the
> >> > LS1028A-RDB is made available via spidev.
> >> >
> >> > Vladimir Oltean (6):
> >> >   spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
> >> >   spi: spi-fsl-dspi: Fix little endian access to PUSHR CMD and TXDATA
> >> >   spi: spi-fsl-dspi: Fix oper_word_size of zero for DMA mode
> >> >   spi: spi-fsl-dspi: Add support for LS1028A
> >> >   arm64: dts: ls1028a: Specify the DMA channels for the DSPI
> >> > controllers
> >> >   arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS
> >> >
> >> >  .../boot/dts/freescale/fsl-ls1028a-rdb.dts    | 14 +++++
> >> >  .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |  6 +++
> >> >  drivers/spi/spi-fsl-dspi.c                    | 54 +++++++++++++++----
> >> >  3 files changed, 64 insertions(+), 10 deletions(-)
> >
> > Thanks,
> > -Vladimir

-Vladimir
