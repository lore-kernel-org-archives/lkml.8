Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D83C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB93820838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eclypsium.com header.i=@eclypsium.com header.b="Nj1mCKyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbgG3OVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbgG3OVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:21:01 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E92C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 07:21:01 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g26so25749797qka.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 07:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F/jomJ6uLuwf7Rw57RY5/Ap0B+MxWKyeViCBM/4WQzw=;
        b=Nj1mCKyvWXQ5WMAXKRNDk1pZNoJQX9fEIaJ63VFKTqrfKPJhxiM/Nml+21topTFOy4
         G0TNK2Lz76W+LEenbSDrvqkaNJJxtL6L8J4wb4XkkwRmnFrEAh7u6babGn2OmNid7r7e
         djWhNr8OkPrZ071irRX2XiZCW0QB2JU4bSb6VyuTkfSY7Tb3vng6EQ1Nc5T5jgnYQ41n
         WlULoSZF6vgp8GYCcXSHCdXlUU1CXvs3gYtVhc/82lVnMlWSGs3IqR/TIZO5aRHc32pQ
         w0j7uEZIT1BIxkpYu0JelNwyCBxw5xSJ77BWWKPhlwSBzA/INGmz839oOgc+MSMXFU5e
         rn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F/jomJ6uLuwf7Rw57RY5/Ap0B+MxWKyeViCBM/4WQzw=;
        b=aerAriStoOLSPMqpMKmwsoVdwYXR6/5CnNFoPGEZ8csrswdusYCKqHw4Wu3OP+X9w0
         zoY22Km1d8KJD/0l6rpc60lnVJZ5NdNI19+zDDByLSUidaQWumxvs0yBFfMTRTyYIGH6
         i93gb0Z0A+S5xbDJL8iztRaFS3qpmEf2DWrhCtxDXVxeHrj185DEFDINjqAC8NM8c4Lo
         zKvNCugFImc+CM2x3aTFZlAD50pRhU1fyhFMASugiHGuwHvO+3fZTY3dmXiTVTCGKZBc
         hQ/GBKpwa58bkGm2EMDIhQCoJPDr6b/9nHsLmJqcbeATyGxlUJqqX7qTc0n4E3Zkb+vF
         EzrQ==
X-Gm-Message-State: AOAM530BfTSfCO5bDl/uCU7psRqYq5V7trykxIr5JPu14eLkmLMRxLfE
        PPtPAKrXrd+E0Rt4VnK0bmbp0Y7Uoo1mLXO+h3Of5A==
X-Google-Smtp-Source: ABdhPJxY8vBzd8PV7ZptzGOU4HwrJqwhHLac85B6YDcDX282dEOhwvgNuUaHLjh4D+n6fwlJFNl4ifNbnQwyMbXcODk=
X-Received: by 2002:ae9:eb81:: with SMTP id b123mr38265818qkg.288.1596118860878;
 Thu, 30 Jul 2020 07:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200724212853.11601-1-daniel.gutson@eclypsium.com>
 <20200725055649.GA1047853@kroah.com> <CAFmMkTE_dT9+WJYyb19uQ_HmgJWZSARBy6PveheQJk++NuGbkQ@mail.gmail.com>
 <20200726071723.GB441916@kroah.com> <CAFmMkTFzGfFDrJrdgHztzLK2K-zBWy6T2Tv+G4-rrbVpbahkgg@mail.gmail.com>
 <CAK8P3a1nA7K15Cxz84Q8Grw3tKfgkUmsfURcytJEWb_0Wjqm5w@mail.gmail.com>
 <CAFmMkTExBY3V_Ghej7Bzjatg+vFtWq3UZmKzjAiEoR9EqnFN9Q@mail.gmail.com>
 <CAFmMkTEO7VNKJeYz2uoHsS-yN_aY8UuiQ2GcCq9NyAD5481ZGA@mail.gmail.com>
 <20200730053108.GA3861609@kroah.com> <CAFmMkTHXjfG7zMr0i_h65PvjAe4opPgvzdABH8W1EUGOmcA4Zg@mail.gmail.com>
 <CAK8P3a2SN3pdXV8=0jXfrsz8L64yV46fEM4zrSXfA25QK0GNuA@mail.gmail.com> <CAFmMkTFiqDtTw2v8RJktzY--WxGd7Fdz2fKA3YxXzA8ZiDS1XQ@mail.gmail.com>
In-Reply-To: <CAFmMkTFiqDtTw2v8RJktzY--WxGd7Fdz2fKA3YxXzA8ZiDS1XQ@mail.gmail.com>
From:   Daniel Gutson <daniel@eclypsium.com>
Date:   Thu, 30 Jul 2020 11:20:48 -0300
Message-ID: <CAFmMkTFyKSUWYgKeTBGh9wkB4dajhdJ3xZ9CUvQwk8hS1LGU-Q@mail.gmail.com>
Subject: Re: [PATCH] Module argument to control whether intel-spi-pci attempts
 to turn the SPI flash chip writeable
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 11:18 AM Daniel Gutson <daniel@eclypsium.com> wrote=
:
>
> On Thu, Jul 30, 2020 at 11:09 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Thu, Jul 30, 2020 at 2:21 PM Daniel Gutson <daniel@eclypsium.com> wr=
ote:
> > > El jue., 30 jul. 2020 2:31 a. m., Greg Kroah-Hartman <gregkh@linuxfou=
ndation.org> escribi=C3=B3:
> > >>
> > >> Again, module parameters are working on a per-chunk-of-code basis, w=
hile
> > >> you want to work on a per-device basis,
> > >
> > >
> > > I think there is a misunderstanding.  What I want is to control (turn=
 on or off) is a very specific code snippet that provides the "functionalit=
y" of trying to turn the chip writable. The rest of the device driver is fi=
ne.
> > > I assume that the one that doesn't understand is me.
> > >
> >
> > I looked at the source code again and found that the existing module
> > parameter applies to both the platform and pci device front-ends, both
> > of which go through
> >
> >         /* Prevent writes if not explicitly enabled */
> >         if (!ispi->writeable || !writeable)
> >                 ispi->nor.mtd.flags &=3D ~MTD_WRITEABLE;
> >
>
> I think you missed
> https://elixir.bootlin.com/linux/latest/source/drivers/mtd/spi-nor/contro=
llers/intel-spi-pci.c#L44
>
>     /* Try to make the chip read/write */
>     pci_read_config_dword(pdev, BCR, &bcr);
>     if (!(bcr & BCR_WPD)) {
>         bcr |=3D BCR_WPD;
>         pci_write_config_dword(pdev, BCR, bcr);
>         pci_read_config_dword(pdev, BCR, &bcr);
>     }
>
> in the probe function, and is executed always and unconditionally.

To clarify, this is executed before intel-spi code.

>
> /* Try to make the chip read/write */
> pci_read_config_dword(pdev, BCR, &bcr);
> if (!(bcr & BCR_WPD)) {
> bcr |=3D BCR_WPD;
> pci_write_config_dword(pdev, BCR, bcr);
> pci_read_config_dword(pdev, BCR, &bcr);
> }
>
> > Setting the PCI device writable in hardware makes it possible to
> > actually write to it *only* if the module parameter is also set to '1'.
> > One might disagree with that design, but I don't think your patch
> > would make it any better, it just means one would have to set
> > two module parameters instead of one.
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



--=20
Daniel Gutson
Argentina Site Director
Enginieering Director
Eclypsium

Below The Surface: Get the latest threat research and insights on
firmware and supply chain threats from the research team at Eclypsium.
https://eclypsium.com/research/#threatreport
