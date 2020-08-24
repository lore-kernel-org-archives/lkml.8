Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F276C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AF3A2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eclypsium.com header.i=@eclypsium.com header.b="faxhd+E/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgHXQBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgHXQAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:00:54 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7B7C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 09:00:54 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id cs12so3955374qvb.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 09:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wo1WKRputxQ5WEmQk/gfcqmvWhqh/EvoPHmhOwUKjX8=;
        b=faxhd+E/EzFyd/c68LZgtAVunAl5IlW4VnAzDC/LPPaQqJAjfXfz1Zv3ouYnuFvQbr
         Fjy+/maJndRntNt2Z9xRNria6z74hHH7EBXKX8IZyFXp4UfwR2+SPrDfbnftHoGu149l
         5QW/NTTmJxaD9hFTK+idq2D4J0LAzu8R72eImcM1Ndmrm5R3+3rJQwtBz38Culyj77nf
         +ccE2m+1yVQXIaHoDgs0UyvdWHfZTO0g0ED4g/KnQr0M9DMO1m1zmiG6lbIsRZW8+Fze
         9xYmeRGu6X5GUYF4sfN3U3reo8HXANvRGwyyoPHAUGtdnlAAc94bDTR8C4X77KmLP7kI
         kpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wo1WKRputxQ5WEmQk/gfcqmvWhqh/EvoPHmhOwUKjX8=;
        b=iO+gjEtfCmOTxBQH4qunTZM740C4R2c3EEkIGGs7QKHrxFgZBEbI0+NZlLaTww7Xr9
         bw3KFfPa1lROnSE9pLaPoRdXhjdFxtLJ24xBo5tngsytc13W6NAPyOrffC4wXx5iC0PX
         JGmpl0tVHJzy3ENppeR9Jpr88RqOY6iYpC+fZTe/tc/paf6ZZ+nXbqu0yYlahHV3k+vF
         i3hhY8HUwrrdeHdefJRzvxUlrz+vTM38vOB0wOLjUxql2/qlUEwIgoVeRYAwU8Hc4Ick
         VIDiE8YZLX6aZA2LTBnCrxdi1LNGqIFsB9LAB7ov0cLKP1liAyXjqpfFj2ivqQLpl+UZ
         xj6A==
X-Gm-Message-State: AOAM532QDdU3LyT+VHKAvpjR8GtBk+Gtgs/RdHXR0zQ0QDzwXKhL6/zX
        3tvus/IxWEaVyNmIbU8DT/6jjbSY2i74Ir7XXMFrdg==
X-Google-Smtp-Source: ABdhPJz9Uq9KfBaA/7xCW6fnYSxivTewgXPC1ApnfvXHigkpcg5iq1x4FMZbrqUsBPU5PZfwuip2Yxzi0/Zj0fYxZgw=
X-Received: by 2002:ad4:55ca:: with SMTP id bt10mr5553951qvb.200.1598284853742;
 Mon, 24 Aug 2020 09:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2_RV33kiJ0c34aopZ4iG7LYBR-u=-+BbC+Upyjh1T0Eg@mail.gmail.com>
 <CAFmMkTHqQO1Gj7VeXr4Y_Umb1KzZc2Pf=1pDQvPPpb_XeAFPqQ@mail.gmail.com>
 <20200819065721.GA1375436@lahna.fi.intel.com> <CAK8P3a0Bq-ucgC4Xue+B_HV97pTX8YRr4hYh1gfrfGBV_H1EUQ@mail.gmail.com>
 <20200819091123.GE1375436@lahna.fi.intel.com> <CAK8P3a19MLfQARXEWzCD-ySq4t9nsyryB+con33HsQ193+muMw@mail.gmail.com>
 <20200824082227.GU1375436@lahna.fi.intel.com> <CAK8P3a0==cZDHwZfqvCuvUg9jfjBOBG+AAomE9eqJ2xm-xNLvQ@mail.gmail.com>
 <20200824091542.GC1375436@lahna.fi.intel.com> <CAK8P3a2ipcVLOzZ5jsDSmWkm=rsE7UQ8rgTU-o6me+vX+gVa9g@mail.gmail.com>
 <20200824094448.GE1375436@lahna.fi.intel.com>
In-Reply-To: <20200824094448.GE1375436@lahna.fi.intel.com>
From:   Daniel Gutson <daniel@eclypsium.com>
Date:   Mon, 24 Aug 2020 13:00:42 -0300
Message-ID: <CAFmMkTFVVxqeg6bWj_4iSfSRwcOhxgBpMbyO8mFA2ze4q6LUFA@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: intel-spi: Do not try to make the SPI flash
 chip writable
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 6:44 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Mon, Aug 24, 2020 at 11:31:40AM +0200, Arnd Bergmann wrote:
> > On Mon, Aug 24, 2020 at 11:15 AM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > > On Mon, Aug 24, 2020 at 11:08:33AM +0200, Arnd Bergmann wrote:
> > > > On Mon, Aug 24, 2020 at 10:22 AM Mika Westerberg
> > > > <mika.westerberg@linux.intel.com> wrote:
> > > > > On Sat, Aug 22, 2020 at 06:06:03PM +0200, Arnd Bergmann wrote:
> > > > > > On Wed, Aug 19, 2020 at 11:11 AM Mika Westerberg
> > > > > >
> > > > > > The mtd core just checks both the permissions on the device node (which
> > > > > > default to 0600 without any special udev rules) and the MTD_WRITEABLE
> > > > > > on the underlying device that is controlled by the module parameter
> > > > > > in case of intel-spi{,-platform,-pci}.c.
> > > > >
> > > > > OK, thanks.
> > > > >
> > > > > Since we cannot really get rid of the module parameter (AFAIK there are
> > > > > users for it), I still think we should just make the "writeable" to
> > > > > apply to the PCI part as well. That should at least make it consistent,
> > > > > and it also solves Daniel's case.
> > > >
> > > > Can you explain Daniel's case then? I still don't understand what he
> > > > actually wants.
> > > >
> > > > As I keep repeating, the module parameter *does* apply to the pci
> > > > driver front-end since it determines whether the driver will disallow
> > > > writes to the mtd device without it. The only difference is that the pci
> > > > driver will attempt to set the hardware bit without checking the
> > > > module parameter first, while the platform driver does not. If the
> > > > module parameter is not set however, the state of the hardware
> > > > bit is never checked again.
> > >
> > > I think Daniel wants the PCI driver not to set the hardware bit by
> > > default (same as the platform driver).
> >
> > Sure, but *why*?
>
> Because this is part of the platform firmware security check patch he is
> also working on and, I guess making the flash chip writeable by default
> is triggering some of the checks in that patch. Or something along those
> lines ;-)

Correct. I need these drivers to be enabled by default, but they are
documented as "DANGEROUS", so I want to also split the driver
in read-only mode and R/W mode. Currently, the driver is R/W,
and this would be a little first step in that direction.

-- 
Daniel Gutson
Argentina Site Director
Enginieering Director
Eclypsium

Below The Surface: Get the latest threat research and insights on
firmware and supply chain threats from the research team at Eclypsium.
https://eclypsium.com/research/#threatreport
