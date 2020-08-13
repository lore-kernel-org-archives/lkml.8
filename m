Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A464C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 21:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA2F20768
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 21:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eclypsium.com header.i=@eclypsium.com header.b="V5j1ZdhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgHMVkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 17:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgHMVkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 17:40:47 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40D5C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 14:40:46 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id cs12so3390012qvb.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 14:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q0ojIysJtPe9HFSEWoGVpZim3QRqJX9wLnTMO9Q2Ah4=;
        b=V5j1ZdhLi9JoGsI1Mg59PBoNNDoUiDIptYbdhxaXyy9hzzbT1Agh3YKti4OfRdPLXq
         XpzGEB/84iroQZQQU07vwFQHNGIq4cK4qJf6uhxBGZVxk6Am7k/KVA4Dbl/IVpK+d7DS
         IJ5cZd8fvRfyxk8lxoH5uRks8ypm1mF3uAGmNoQK2HtdlMX97NJa2vZl/zfzOw2UhIbg
         27Uuz4l4sHV58/a3/2D0jlOrVpoluSjM/UiAuInA9tnmE5B32As7a8YaE0JEg6HPfM9i
         l89FeKArSLc6CmYcNxRBK63JTJp7uut9pVWy7T1dxj8R2ErbvE6RiJhqb501/9N2Ft5d
         GZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q0ojIysJtPe9HFSEWoGVpZim3QRqJX9wLnTMO9Q2Ah4=;
        b=DJQaiftTDfb4PDGeTiIX8bfewbM2nAsaHdq4GRcQEvPMUJmt6REnt2mLim/GAr2ae6
         /OAwLVx8CUZM3jslsUSWmo0jXpHrTzo6IQNJGBjsJ3+Mswxqp2sJrhHCuuQQNpS4uwXz
         1vQaIvXxKIqd0lGZLlQwcG9dhrBGY5f0IMATeVZNAyg3W2XwUas6Qdi7atu38Ycyp+U+
         s/HUBgqQ+ngmKn1iyAMMGbL3Htg8mHVQxtin9K8VCK+NL1cZQJrY6chiZfPjm1VW6t33
         V4PKoPAILPJI8M9pdegyQglkDIJLY6LAME052AkAOdNsmx9qoiNCVA+cCafQVEyNa80r
         LJ2Q==
X-Gm-Message-State: AOAM532fHQJGssNk0hyxCC/JKjVOUdpL6OaaQqqzyrkb1xKkuCJv1Lzg
        JXqsQbnfImEehnuToeXahe1T1KqUkZF8TTTR9b1ikA==
X-Google-Smtp-Source: ABdhPJz26JMnJY2pl3AV9GgZ7zaj6tqMi0U/+2mh3l4fvVM2Jgrrb6S5lOzCQeSKmO9F2GpbSDh/RhfijmRfBdAN6e4=
X-Received: by 2002:ad4:46ac:: with SMTP id br12mr6701109qvb.236.1597354845858;
 Thu, 13 Aug 2020 14:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200804135817.5495-1-daniel.gutson@eclypsium.com>
 <CAK8P3a0_fJ0BfD5Qvxdo0s7CbjPWaGA8QTgYhbXR=omafOHH4Q@mail.gmail.com>
 <CAFmMkTHEm8k+5GZkVJbDZMEhMwpsqVKRb-hGskSpBstdLRuFyA@mail.gmail.com>
 <CAK8P3a27bTYyn3N+tX=i_6f4KrQkOmkUA1zUQfvCW7qw6smSkQ@mail.gmail.com>
 <CAFmMkTF9eVm0tpOKEy2rzdX=Scr3RwqHDFy_i24R3F5ok-4=eA@mail.gmail.com>
 <CAK8P3a3mf8_Y4DWe3WuBO-Xo0N4Jj=-rrtFzD6w0TriGZPu1_g@mail.gmail.com>
 <CAFmMkTFzmC=aY0gR6urLu-8Oq8aeHBUWi-TodG8XhXKCcC057A@mail.gmail.com> <CAK8P3a13N_wNORz_3cYHTN8t29pPrY+dJ+g+1Ga_MmG1TmrUQw@mail.gmail.com>
In-Reply-To: <CAK8P3a13N_wNORz_3cYHTN8t29pPrY+dJ+g+1Ga_MmG1TmrUQw@mail.gmail.com>
From:   Daniel Gutson <daniel@eclypsium.com>
Date:   Thu, 13 Aug 2020 18:40:34 -0300
Message-ID: <CAFmMkTGm3pMsBzEenYOsRbhOZKFhbHiZ5LxPyVmTdYTTRpKzVQ@mail.gmail.com>
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

On Thu, Aug 13, 2020 at 12:41 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Aug 4, 2020 at 11:26 PM Daniel Gutson <daniel@eclypsium.com> wrote:
> > On Tue, Aug 4, 2020 at 5:46 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > But wait, Mika, the author of the file, asked earlier not to remove
> > > > the module parameter of intel-spi, and just remove the unconditional
> > > > attempt to turn the chip writable in intle-spi-pci.
> > >
> > > Yes, and I think that is fine (aside from the inconsistency with bay trail
> > > that you have not commented on),
> >
> > There are two inconsistencies before any of my patches:
> > 1) in intel-spi.c: uses the module parameter only for bay trail.
> > 2) intel-spi.c uses a module parameter whereas intel-spi-pci doesn't
>
> Neither of these matches what I see in the source code. Please
> check again.
>
> Once more: intel-spi.c has a module parameter that controls writing
> to the device regardless of the back-end (platform or pci), purely
> in software.

If I understand you correctly, this is not what I see:
If the deviceID is listed in intel-spi-pci.c
(https://elixir.bootlin.com/linux/latest/source/drivers/mtd/spi-nor/controllers/intel-spi-pci.c#L66)
then intel_spi_pci_probe will be called, where it unconditionally will
try to make the chip writable
https://elixir.bootlin.com/linux/latest/source/drivers/mtd/spi-nor/controllers/intel-spi-pci.c#L44
These devices correspond to the BXT and CNL devices (lines 19 and 23 resp.).

Lines later (53), it will call intel-spi.c 's intel_spi_probe
function, which ends up calling intel_spi_init,
which checks for the type
(https://elixir.bootlin.com/linux/latest/source/drivers/mtd/spi-nor/controllers/intel-spi.c#L313)
It is in this switch where the module parameter is checked, but only
in the BYT case; however,
flow coming from intel-spi-pci is BXT and CNL as mentioned before,
landing in their case labels (lines 343 and 351 respectively)
where the module parameter is not checked.

Therefore, for BXT and CNL probed in intel-spi-pci, the chip is turned
writable and later the module parameter is not honored.

> The hardware write-protect setting where available
> works in addition that and prevents writing even if the module
> parameter is set to writeable.
>
> > > but that only touches the hardware
> > > write-protection, which doesn't really have any effect unless user
> > > space also configures the driver module to allow writing to the
> > > mtd device.
> > >
> > > > So I'm not touching intel-pci, just removing that code from
> > > > intel-spi-pci without adding a new module parameter.
> > > >
> > > > Are you aligned on this?
> > >
> > > One of us is still very confused about what the driver does.
> > > You seem to have gone back to saying that without the
> > > change a user could just write to the device even without
> > > passing the module parameter to intel-spi.ko?
> >
> > What I'm trying to say is that, if the BIOS is unlocked
> > (no driver involvement here), the intel-spi-pci turns the
> > chip writable even without changing the module parameter of intel-spi.
> > This is because the attempt to turn the chip writable occurs in
> > the probing of intel-spi-pci, that is, earlier than the intel-spi
> > initialization.
>
> My question was why you even care whether the hardware
> bit is set to writeable if the driver disallows writing. I think the
> answer is that you misread the driver.
>
>        Arnd



-- 
Daniel Gutson
Argentina Site Director
Enginieering Director
Eclypsium

Below The Surface: Get the latest threat research and insights on
firmware and supply chain threats from the research team at Eclypsium.
https://eclypsium.com/research/#threatreport
