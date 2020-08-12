Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E875C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DDF7207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eclypsium.com header.i=@eclypsium.com header.b="HXcUj/8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgHLPlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgHLPls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:41:48 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B289C061384
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 08:41:48 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id r19so1198090qvw.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 08:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=haCZp8d7OZAFbRh0ccsZ5DNIkLr16Zii89E0sXPAORI=;
        b=HXcUj/8nYPyuiRt/bdiw2udHv9wTKOG/PYcKO9Gdsa/+oPPJKPsPVQcmvC83jET7Om
         Jsq1HYXsoxblYI/Zm1SvjAW6qzpb5YPSSHii/6rBssU7Wu2MYDzwZ30Zj3UbS9tu7Ljj
         JDPTUz7lxQdbQkDwDjISjIGUU4mVfXRTgGTdMoa+N04kYDTE82ai1MVZfo249Owbho6G
         5tQqbEnl7yoCIuRT9DFSTclrP8ex43bu6ik/16p5EnaVOtdiPN8hIonEiHZl92rX+IPW
         teGtTYpyvkc8LTR+YbHG6/V3vPaKJ84ZEeySq3IDVJmQA8L3Lf0Wew4fTri8X8Tu5yXL
         2ecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=haCZp8d7OZAFbRh0ccsZ5DNIkLr16Zii89E0sXPAORI=;
        b=ElfCSPAkRRt7SBFnc0u+U7gbLzFuneNLTlhDxX2SlhpntBW/FVA8GfLv77c/j9wnU8
         h0k2ssK8xVHa0lLKnrvekZFPO3XroFntHlEsFToCNPLG9Zd4ACoid8frU9OMrU9lnssx
         1SQXOb8QATTtbaDIsK/9bvMw9kigJDfdpghQ1Fz5tPxJwqtq/NjAjNRn7Ixl3YEijr7l
         PdI1hrTN1j71mixzP+YMS3CqihMNU61KFt8Zga99lDwOty4hdyCpLC1FdlIthSbkVRmQ
         vHDWFQSQ+DHImwh9mv86nzPVyyeXut57h2cFfEww/YBcH814rMrn1ZBJSPqQij37ZuG6
         9HVQ==
X-Gm-Message-State: AOAM531zx5NNiNnKQDbhVwtXymnbM2wRB2Dqok6fELFC3IDXv1gSsbRM
        vaNyir4i5/DIfGDvk6NW9eAPemcEbhm1PVXCbKwz4g==
X-Google-Smtp-Source: ABdhPJzXAxewiJp6SpmJoqd5oXPp1B2xCxwmqfuOwpOLAawT9RWGc8YhA071QWN3Hamy52lLh5Ro0K3VQnLOSTRCjNI=
X-Received: by 2002:ad4:55ca:: with SMTP id bt10mr172844qvb.200.1597246906738;
 Wed, 12 Aug 2020 08:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200804135817.5495-1-daniel.gutson@eclypsium.com>
 <CAK8P3a0_fJ0BfD5Qvxdo0s7CbjPWaGA8QTgYhbXR=omafOHH4Q@mail.gmail.com>
 <CAFmMkTHEm8k+5GZkVJbDZMEhMwpsqVKRb-hGskSpBstdLRuFyA@mail.gmail.com>
 <CAK8P3a27bTYyn3N+tX=i_6f4KrQkOmkUA1zUQfvCW7qw6smSkQ@mail.gmail.com>
 <CAFmMkTF9eVm0tpOKEy2rzdX=Scr3RwqHDFy_i24R3F5ok-4=eA@mail.gmail.com>
 <CAK8P3a3mf8_Y4DWe3WuBO-Xo0N4Jj=-rrtFzD6w0TriGZPu1_g@mail.gmail.com> <CAFmMkTFzmC=aY0gR6urLu-8Oq8aeHBUWi-TodG8XhXKCcC057A@mail.gmail.com>
In-Reply-To: <CAFmMkTFzmC=aY0gR6urLu-8Oq8aeHBUWi-TodG8XhXKCcC057A@mail.gmail.com>
From:   Daniel Gutson <daniel@eclypsium.com>
Date:   Wed, 12 Aug 2020 12:41:35 -0300
Message-ID: <CAFmMkTE+2Qxo43bZkwCszEYbXFV22YdpLJD40gB6LgvnPbvdSA@mail.gmail.com>
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

ping

On Tue, Aug 4, 2020 at 6:26 PM Daniel Gutson <daniel@eclypsium.com> wrote:
>
> On Tue, Aug 4, 2020 at 5:46 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, Aug 4, 2020 at 9:57 PM Daniel Gutson <daniel@eclypsium.com> wrote:
> > > On Tue, Aug 4, 2020 at 4:06 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Tue, Aug 4, 2020 at 5:49 PM Daniel Gutson <daniel@eclypsium.com> wrote:
> > > > > On Tue, Aug 4, 2020 at 12:21 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > >> On Tue, Aug 4, 2020 at 3:58 PM Daniel Gutson
> > > > >> <daniel.gutson@eclypsium.com> wrote:
> > > > >
> > > > > What about just saying
> > > > >
> > > > > "This patch removes the attempt by the intel-spi-pci driver to
> > > > > make the chip always writable."
> > > >
> > > > Yes, that is much better, though it still sounds like it would at the
> > > > moment allow writing to the device from software without also
> > > > setting the module parameter. I would say something like
> > > >
> > > > "Disallow overriding the write protection in the PCI driver
> > > > with a module parameter and instead honor the current
> > > > state of the write protection as set by the firmware."
> > >
> > > But wait, Mika, the author of the file, asked earlier not to remove
> > > the module parameter of intel-spi, and just remove the unconditional
> > > attempt to turn the chip writable in intle-spi-pci.
> >
> > Yes, and I think that is fine (aside from the inconsistency with bay trail
> > that you have not commented on),
>
> There are two inconsistencies before any of my patches:
> 1) in intel-spi.c: uses the module parameter only for bay trail.
> 2) intel-spi.c uses a module parameter whereas intel-spi-pci doesn't
>
> My initial patch addressed #2 by also adding a module parameter to
> intel-spi-pci,
> but then some of you discouraged me to use module parameters.
> Mika showed up and suggested to leave intel-spi.c as is (with its
> module parameter),
> and remove the code in intel-spi-pci that tried to turn the SPI chip
> writable if the BIOS
> was unlocked.
>
> > but that only touches the hardware
> > write-protection, which doesn't really have any effect unless user
> > space also configures the driver module to allow writing to the
> > mtd device.
> >
> > > So I'm not touching intel-pci, just removing that code from
> > > intel-spi-pci without adding a new module parameter.
> > >
> > > Are you aligned on this?
> >
> > One of us is still very confused about what the driver does.
> > You seem to have gone back to saying that without the
> > change a user could just write to the device even without
> > passing the module parameter to intel-spi.ko?
>
> What I'm trying to say is that, if the BIOS is unlocked
> (no driver involvement here), the intel-spi-pci turns the
> chip writable even without changing the module parameter of intel-spi.
> This is because the attempt to turn the chip writable occurs in
> the probing of intel-spi-pci, that is, earlier than the intel-spi
> initialization.
>
> >
> > Maybe you should start by explaining what scenario you
> > actually want to prevent here. Is it
>
> Was it clear from above?
>
> Before commenting below, it's important to note again that
> the driver will succeed in turning the chip writable only if the
> BIOS is unlocked by its build time specification.
> The WPD field (Write Protect Disable) bit only has effect if
> the BIOS is not locked. This WPD bit is the one that the intel-spi-pci
> driver tries to set unconditionally. If the BIOS is locked, it will cause
> no effect. But if the BIOS is not locked, the chip will
> end up in Write Protect Disabled state.
> My latest patch simply leaves alone the WPD bit in intel-spi-pci,
> not trying to set it to 1.
>
> I'm not sure the options below are now fully compatible
> with my explanation above.
>
> >
> > a) the hardware write-protect bit getting changed, which
> >     introduces the possibility of corrupting the flash even
> >     if nothing tries to write to it,
> >
> > b) root users setting the device writable with the intention
> >    of writing to it even though firmware has politely asked
> >    for this not to be done (by setting the write-protect bit
> >    but not preventing it from being disabled again), or
> >
> > c) a writeable mtd device showing up even without
> >     the module parameter being set at all?
> >
> > I thought the initial patch was about c) which turned out
> > to be a non-issue, and then the later patch being about b).
> >
> >      Arnd
>
>
>
> --
> Daniel Gutson
> Argentina Site Director
> Enginieering Director
> Eclypsium
>
> Below The Surface: Get the latest threat research and insights on
> firmware and supply chain threats from the research team at Eclypsium.
> https://eclypsium.com/research/#threatreport



-- 
Daniel Gutson
Argentina Site Director
Enginieering Director
Eclypsium

Below The Surface: Get the latest threat research and insights on
firmware and supply chain threats from the research team at Eclypsium.
https://eclypsium.com/research/#threatreport
