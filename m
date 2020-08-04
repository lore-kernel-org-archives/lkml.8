Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90C6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B722020842
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eclypsium.com header.i=@eclypsium.com header.b="NnLic8Mv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgHDV02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgHDV02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:26:28 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2564C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 14:26:27 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id w2so7702034qvh.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 14:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EIijXqczA+fJ6ljet3cDCIUDRtSrnljLBcPwrEPIX1I=;
        b=NnLic8Mve8V7Vn5BnI+2aE5Qj9cAudq14M8IldzGj4HmlvW/KE+/PvgoPdjFUIzzVA
         ovpOrHj6UrwT/KFYHpe2OF2gPnl434X7L9XP5gyfwBlzPGhvBU4IHO/Ia+ZTNUMzLmtB
         Gu78Ru+PyTpkN8YLdM5zvj7fj0EmcMiRT8Fn1nIQNTq7O/C/k29VTasIfZvhsES96FsW
         16jj98++LlFxieMbt8m2oLc2i9Llz6HrmTPt5lYYfZp1d78kXWx+HMnyvoX8axmRU+bw
         NtFKluqhjAqZaoRrq6T39LyCkITvmN25fmY2VrUmdVyHx3kYHW5+A66gQaX0SwYDSiDf
         7lIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EIijXqczA+fJ6ljet3cDCIUDRtSrnljLBcPwrEPIX1I=;
        b=Aqo40jhF4qDzosKBfbs2CP7OcK0TFDJjLfbMGm9CZgTzy2VrSVmHXQCr/H8Uybh/Ba
         3c3osVfJYoV2vAlF3WJSwPvVAUDGGVotmY3Ippnk9IcfxM50fLhK9/iK8rnm5CHSnxiH
         TLNo11z1/b0cLcJHxd2nJ/5jHtOZDt42PLCtteXYKXREadh9y0tgcgUSKIE+C576JWNz
         yphdCxpSjKeLPp8o+WNmN58gcqvAP9RGfYVLgLWhT6cJ8OMzBhOkBf/ELw7BoVfY86Xy
         CPrUoUjcD1PEZT2//WG7yKGTRrEUHQnmN+IexVYATMHhsaJvbUlJwo8G86jEGUFSGUCJ
         /aRA==
X-Gm-Message-State: AOAM532CBseg4uRdVX9d6xXOPXDM9653Lc2FnsIGlyVfnqVheHSUnD8O
        CIAgCo7jk7e+/0vHPR8h/j6dB3x3lUdFjxo99+C5BA==
X-Google-Smtp-Source: ABdhPJwIUJCuwei8hSV3a4TkiS+iC3YNpjfJ4ecvLLDgt9aGNNY9t56c7/1MEk2DbmD6pDwFam+EQdlp2nNaYzfUAF8=
X-Received: by 2002:ad4:5502:: with SMTP id az2mr377046qvb.148.1596576386950;
 Tue, 04 Aug 2020 14:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200804135817.5495-1-daniel.gutson@eclypsium.com>
 <CAK8P3a0_fJ0BfD5Qvxdo0s7CbjPWaGA8QTgYhbXR=omafOHH4Q@mail.gmail.com>
 <CAFmMkTHEm8k+5GZkVJbDZMEhMwpsqVKRb-hGskSpBstdLRuFyA@mail.gmail.com>
 <CAK8P3a27bTYyn3N+tX=i_6f4KrQkOmkUA1zUQfvCW7qw6smSkQ@mail.gmail.com>
 <CAFmMkTF9eVm0tpOKEy2rzdX=Scr3RwqHDFy_i24R3F5ok-4=eA@mail.gmail.com> <CAK8P3a3mf8_Y4DWe3WuBO-Xo0N4Jj=-rrtFzD6w0TriGZPu1_g@mail.gmail.com>
In-Reply-To: <CAK8P3a3mf8_Y4DWe3WuBO-Xo0N4Jj=-rrtFzD6w0TriGZPu1_g@mail.gmail.com>
From:   Daniel Gutson <daniel@eclypsium.com>
Date:   Tue, 4 Aug 2020 18:26:15 -0300
Message-ID: <CAFmMkTFzmC=aY0gR6urLu-8Oq8aeHBUWi-TodG8XhXKCcC057A@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: intel-spi: Do not try to make the SPI flash
 chip writable
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
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

On Tue, Aug 4, 2020 at 5:46 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Aug 4, 2020 at 9:57 PM Daniel Gutson <daniel@eclypsium.com> wrote:
> > On Tue, Aug 4, 2020 at 4:06 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Tue, Aug 4, 2020 at 5:49 PM Daniel Gutson <daniel@eclypsium.com> wrote:
> > > > On Tue, Aug 4, 2020 at 12:21 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > >> On Tue, Aug 4, 2020 at 3:58 PM Daniel Gutson
> > > >> <daniel.gutson@eclypsium.com> wrote:
> > > >
> > > > What about just saying
> > > >
> > > > "This patch removes the attempt by the intel-spi-pci driver to
> > > > make the chip always writable."
> > >
> > > Yes, that is much better, though it still sounds like it would at the
> > > moment allow writing to the device from software without also
> > > setting the module parameter. I would say something like
> > >
> > > "Disallow overriding the write protection in the PCI driver
> > > with a module parameter and instead honor the current
> > > state of the write protection as set by the firmware."
> >
> > But wait, Mika, the author of the file, asked earlier not to remove
> > the module parameter of intel-spi, and just remove the unconditional
> > attempt to turn the chip writable in intle-spi-pci.
>
> Yes, and I think that is fine (aside from the inconsistency with bay trail
> that you have not commented on),

There are two inconsistencies before any of my patches:
1) in intel-spi.c: uses the module parameter only for bay trail.
2) intel-spi.c uses a module parameter whereas intel-spi-pci doesn't

My initial patch addressed #2 by also adding a module parameter to
intel-spi-pci,
but then some of you discouraged me to use module parameters.
Mika showed up and suggested to leave intel-spi.c as is (with its
module parameter),
and remove the code in intel-spi-pci that tried to turn the SPI chip
writable if the BIOS
was unlocked.

> but that only touches the hardware
> write-protection, which doesn't really have any effect unless user
> space also configures the driver module to allow writing to the
> mtd device.
>
> > So I'm not touching intel-pci, just removing that code from
> > intel-spi-pci without adding a new module parameter.
> >
> > Are you aligned on this?
>
> One of us is still very confused about what the driver does.
> You seem to have gone back to saying that without the
> change a user could just write to the device even without
> passing the module parameter to intel-spi.ko?

What I'm trying to say is that, if the BIOS is unlocked
(no driver involvement here), the intel-spi-pci turns the
chip writable even without changing the module parameter of intel-spi.
This is because the attempt to turn the chip writable occurs in
the probing of intel-spi-pci, that is, earlier than the intel-spi
initialization.

>
> Maybe you should start by explaining what scenario you
> actually want to prevent here. Is it

Was it clear from above?

Before commenting below, it's important to note again that
the driver will succeed in turning the chip writable only if the
BIOS is unlocked by its build time specification.
The WPD field (Write Protect Disable) bit only has effect if
the BIOS is not locked. This WPD bit is the one that the intel-spi-pci
driver tries to set unconditionally. If the BIOS is locked, it will cause
no effect. But if the BIOS is not locked, the chip will
end up in Write Protect Disabled state.
My latest patch simply leaves alone the WPD bit in intel-spi-pci,
not trying to set it to 1.

I'm not sure the options below are now fully compatible
with my explanation above.

>
> a) the hardware write-protect bit getting changed, which
>     introduces the possibility of corrupting the flash even
>     if nothing tries to write to it,
>
> b) root users setting the device writable with the intention
>    of writing to it even though firmware has politely asked
>    for this not to be done (by setting the write-protect bit
>    but not preventing it from being disabled again), or
>
> c) a writeable mtd device showing up even without
>     the module parameter being set at all?
>
> I thought the initial patch was about c) which turned out
> to be a non-issue, and then the later patch being about b).
>
>      Arnd



-- 
Daniel Gutson
Argentina Site Director
Enginieering Director
Eclypsium

Below The Surface: Get the latest threat research and insights on
firmware and supply chain threats from the research team at Eclypsium.
https://eclypsium.com/research/#threatreport
