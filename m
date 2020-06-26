Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B82C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 01:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F32BC207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 01:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hCTUZM6O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgFZBNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 21:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgFZBNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 21:13:14 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D16C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 18:13:12 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y13so4241625lfe.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 18:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=awA+aJfmww2/ao85b7H7RA9mG8f4CnoPqX5UUEk/kak=;
        b=hCTUZM6Ox/OvQ/JlyZz8Suae/jeQnSvAiK8yyi8MhvucZxipYA1+1KVp9Z4H28F5r/
         oFI7lN/vhXdgyScwRCqTZTX5p9QjEcai4GEW009ru/kVfwEVvZby1d1/rbTsC4JvkgIG
         AAUWxi2snR0VIT41gDC/cSVmrV1LvEpce5IzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=awA+aJfmww2/ao85b7H7RA9mG8f4CnoPqX5UUEk/kak=;
        b=H1XQ9O2CoeQP6/C+Pdz8Lrn+0OXt7RRmzQ9xyooOcJoihavj1DEyk3ico72xibUF7c
         y76v9Nt+ijjj/EakW85+JHAUBQvzteHj4NkGM5sFESypXgUQftQlhY2EjDe/uJ2ToWiO
         F/i5zelYPCHlNMYSgA1UzrnrNLfMEoBFnB6j4txWsH7jMcaTwwBD1N6TS43FjGEJeZaV
         AwT71fNcJ8GWVPFOL8OMntlI/H8P3AE7Ge8dL1z9ZrNZ8cX+4kQfBaDBoJ+YkPJFafWg
         OF71D0kxHrL8vFufYo2IOgei+GPRgWPR24E6uJjsz5xMXTOx/XJA8H7HezDaV28JAUYg
         7B+A==
X-Gm-Message-State: AOAM530McwV5D2Cg7dv2Rv0UnQQhX9caFfBqnDQYUCwQXGtoVm4yrIxp
        PZDyYDMipmcpo78mO+4BAqowLEVw9Cgd/zvrlhC20w==
X-Google-Smtp-Source: ABdhPJwZCTMBJV8xuYwi09a06rapO6vlykG3STqzwWAy7jky+t7DKQ1dMepMyJh5nLNleaSot9l2JcmKUk7gcBd9bAg=
X-Received: by 2002:a05:6512:328d:: with SMTP id p13mr383775lfe.139.1593133990435;
 Thu, 25 Jun 2020 18:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200612164632.25648-1-nsaenzjulienne@suse.de>
 <20200612164632.25648-5-nsaenzjulienne@suse.de> <CAPnjgZ2jarQArKN=0h0mNnxE7gAL0juvGhMxMF4a0CehqxWcRw@mail.gmail.com>
 <d3346d7cb9655eb111b4126d72a08499c6254fef.camel@suse.de> <CAPnjgZ3PwTWBQ2Vi4=Sc7JB699TrSxr=PAJupL_3POhJ00qSsA@mail.gmail.com>
 <954083bf13bd7c24c31c9673269ea0eedb925f43.camel@suse.de>
In-Reply-To: <954083bf13bd7c24c31c9673269ea0eedb925f43.camel@suse.de>
From:   Simon Glass <sjg@chromium.org>
Date:   Thu, 25 Jun 2020 19:12:02 -0600
Message-ID: <CAPnjgZ3CuidKZpTzBiH_F5WhEO3RzEcmHGMyJN9ynu2eOirkUQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] dm: pci: Assign controller device node to root bridge
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Matthias Brugger <mbrugger@suse.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>,
        lk <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On Wed, 17 Jun 2020 at 13:15, Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> On Tue, 2020-06-16 at 17:31 -0600, Simon Glass wrote:
> > Hi Nicolas,
> >
> > On Tue, 16 Jun 2020 at 08:09, Nicolas Saenz Julienne
> > <nsaenzjulienne@suse.de> wrote:
> > > On Tue, 2020-06-16 at 07:43 -0600, Simon Glass wrote:
> > > > Hi Nicolas,
> > > >
> > > > On Fri, 12 Jun 2020 at 10:47, Nicolas Saenz Julienne
> > > > <nsaenzjulienne@suse.de> wrote:
> > > > > There is no distinction in DT between the PCI controller device and the
> > > > > root bridge, whereas such distinction exists from dm's perspective. Make
> > > > > sure the root bridge ofnode is assigned to the controller's platform
> > > > > device node.
> > > > >
> > > > > This permits setups like this to work correctly:
> > > > >
> > > > >         pcie {
> > > > >                 compatible = "...";
> > > > >                 ...
> > > > >                 dev {
> > > > >                         reg = <0 0 0 0 0>;
> > > > >                         ...
> > > > >                 };
> > > > >         };
> > > > >
> > > > > Without this the dev node is assigned to the root bridge and the
> > > > > actual device search starts one level lower than expected.
> > > > >
> > > > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > > > ---
> > > > >  drivers/pci/pci-uclass.c | 15 ++++++++++++++-
> > > > >  1 file changed, 14 insertions(+), 1 deletion(-)
> > > >
> > > > Can you update the tests to handle this case please?
> > >
> > > I'd be glad to, but I'm not familiar with the test FW in u-booy, coud give
> > > me
> > > some pointers on where/how to test this?
> > >
> >
> > Yes it is at test/dm/pci.c and the device tree is test.dts
> >
> > 'make qcheck' to run all tests. To run one test, build for sandbox and
> > then something like
> >
> > u-boot -T -c "ut dm pci_swapcase"
> >
> > for example.
> >
> > You can perhaps use an existing PCI controller in test.dts but feel
> > free to add one more if you need it for your test. Make sure that you
> > don't break other tests.
>
> Thanks for the info.
>
> Actually adding the tests made me doubleguess myself, and now I'm pretty sure
> that what I shoudl've done in DT is the following:
>
>         &pcie0 {
>                pci@0 {
>                        #address-cells = <3>;
>                        #size-cells = <2>;
>                        ranges;
>
>                        reg = <0 0 0 0 0>;
>
>                        usb@1,0 {
>                                reg = <0x10000 0 0 0 0>;
>                                resets = <&reset RASPBERRYPI_FIRMWARE_RESET_ID_USB>;
>                        };
>                };
>         };
>
>
> (with "lspci -tv": [0000:00]---00.0-[01]----00.0  VIA Technologies, Inc. VL805 USB 3.0 Host Controller)
>
> With this the patch above isn't needed, which is great.
>
> I'll send this to upstream Linux just to get a confirmation this is correct,
> although if you have any comments it'll be appreciated.

Yes it looks OK to me. U-Boot allows PCI and USB devices to be
represented in the device tree.

Regards,
Simon
