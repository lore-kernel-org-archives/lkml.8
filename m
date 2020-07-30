Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0A3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 631F72070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eclypsium.com header.i=@eclypsium.com header.b="ajYisd7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgG3OSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgG3OSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:18:32 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584E6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 07:18:32 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l6so25686971qkc.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 07:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XZbJJB2Vd7z56HA7iaeVyLLV94QolOdPT5I5Lnt/lZQ=;
        b=ajYisd7S9lMISpmj4yTD1guZg5Hd2IkN+h3NlyEOzRtlvrIgkGLifmMGxwp1h27nIC
         DmY758wMp1tqUHR1ddz5M59vrwtpyXhRrnppwWk2HqR+BOBLQEBPCkaCdvF5kjnmqkzx
         wiyX8jzOUI2hOo5EBoQf/R5yVQPlA5xhinTUzvt7SdRhrZga21gPabubZN54/pccIHZJ
         sMNRKZh2ENDhLuV2kQc6+N1xMO1LaJ1JlKjgTsaSwSCjmJeAqHOEJdQTBLhDYlPGErkm
         8UuarO+tg1nolZW9zlEK4MDxlU6WQscwrfB4CsaL/3X5fFjW5TWuYDCrvlRGNmBFhQFf
         V5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XZbJJB2Vd7z56HA7iaeVyLLV94QolOdPT5I5Lnt/lZQ=;
        b=FsWQwmXnPJSeVhX5Tjk4jh2Bc5vjT2U97BSLeK54goPd5LmzNo+oVli3tOZ0bwr3Xi
         HWDhQs8x48ZtRiq3w/LvHBfXLPGDdpVRkE5HU/aTzy/rxXftR/fhKw9DjbdUT+lQxiE7
         51pk0LZkGk//J6lPPP8aJ8sx8NaeMF+6PT6sPsNPzR0zIlK83UftDD6TPpBTsMb+45b7
         gGAVEIKNwrGGkt0OeJx2vbgVAJnRsWK97wxyJKriX2Hs9t55ECm3wAEq9qTLEFSgQnmT
         T9Bl/cU5soVgwPF/JPLbDqpIONwohg4Vas7VFfZvHrqTSxqLrzJ5T7YhhlEryE6/eKf0
         WexA==
X-Gm-Message-State: AOAM531Or6MZiSH/l0MkIcCsM9YOcUrgT+sqalysaB1TawuXKcVUcciR
        vl8ebwAjHqEuFCjwiWSP79V5hyRt/yjTxPdp+F/L9w==
X-Google-Smtp-Source: ABdhPJwNx1NlAJN42KEtdc2tz5YZMN4qeL9gMeY2g8ZNBeMlC7ltpPhdhuYSolG5jTfD4SdcSZBBXm/FOEZqqQJJqNM=
X-Received: by 2002:a37:9f0a:: with SMTP id i10mr7133510qke.368.1596118711204;
 Thu, 30 Jul 2020 07:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200724212853.11601-1-daniel.gutson@eclypsium.com>
 <20200725055649.GA1047853@kroah.com> <CAFmMkTE_dT9+WJYyb19uQ_HmgJWZSARBy6PveheQJk++NuGbkQ@mail.gmail.com>
 <20200726071723.GB441916@kroah.com> <CAFmMkTFzGfFDrJrdgHztzLK2K-zBWy6T2Tv+G4-rrbVpbahkgg@mail.gmail.com>
 <CAK8P3a1nA7K15Cxz84Q8Grw3tKfgkUmsfURcytJEWb_0Wjqm5w@mail.gmail.com>
 <CAFmMkTExBY3V_Ghej7Bzjatg+vFtWq3UZmKzjAiEoR9EqnFN9Q@mail.gmail.com>
 <CAFmMkTEO7VNKJeYz2uoHsS-yN_aY8UuiQ2GcCq9NyAD5481ZGA@mail.gmail.com>
 <20200730053108.GA3861609@kroah.com> <CAFmMkTHXjfG7zMr0i_h65PvjAe4opPgvzdABH8W1EUGOmcA4Zg@mail.gmail.com>
 <CAK8P3a2SN3pdXV8=0jXfrsz8L64yV46fEM4zrSXfA25QK0GNuA@mail.gmail.com>
In-Reply-To: <CAK8P3a2SN3pdXV8=0jXfrsz8L64yV46fEM4zrSXfA25QK0GNuA@mail.gmail.com>
From:   Daniel Gutson <daniel@eclypsium.com>
Date:   Thu, 30 Jul 2020 11:18:20 -0300
Message-ID: <CAFmMkTFiqDtTw2v8RJktzY--WxGd7Fdz2fKA3YxXzA8ZiDS1XQ@mail.gmail.com>
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

On Thu, Jul 30, 2020 at 11:09 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jul 30, 2020 at 2:21 PM Daniel Gutson <daniel@eclypsium.com> wrot=
e:
> > El jue., 30 jul. 2020 2:31 a. m., Greg Kroah-Hartman <gregkh@linuxfound=
ation.org> escribi=C3=B3:
> >>
> >> Again, module parameters are working on a per-chunk-of-code basis, whi=
le
> >> you want to work on a per-device basis,
> >
> >
> > I think there is a misunderstanding.  What I want is to control (turn o=
n or off) is a very specific code snippet that provides the "functionality"=
 of trying to turn the chip writable. The rest of the device driver is fine=
.
> > I assume that the one that doesn't understand is me.
> >
>
> I looked at the source code again and found that the existing module
> parameter applies to both the platform and pci device front-ends, both
> of which go through
>
>         /* Prevent writes if not explicitly enabled */
>         if (!ispi->writeable || !writeable)
>                 ispi->nor.mtd.flags &=3D ~MTD_WRITEABLE;
>

I think you missed
https://elixir.bootlin.com/linux/latest/source/drivers/mtd/spi-nor/controll=
ers/intel-spi-pci.c#L44

    /* Try to make the chip read/write */
    pci_read_config_dword(pdev, BCR, &bcr);
    if (!(bcr & BCR_WPD)) {
        bcr |=3D BCR_WPD;
        pci_write_config_dword(pdev, BCR, bcr);
        pci_read_config_dword(pdev, BCR, &bcr);
    }

in the probe function, and is executed always and unconditionally.

/* Try to make the chip read/write */
pci_read_config_dword(pdev, BCR, &bcr);
if (!(bcr & BCR_WPD)) {
bcr |=3D BCR_WPD;
pci_write_config_dword(pdev, BCR, bcr);
pci_read_config_dword(pdev, BCR, &bcr);
}

> Setting the PCI device writable in hardware makes it possible to
> actually write to it *only* if the module parameter is also set to '1'.
> One might disagree with that design, but I don't think your patch
> would make it any better, it just means one would have to set
> two module parameters instead of one.
>
>      Arnd



--=20
Daniel Gutson
Argentina Site Director
Enginieering Director
Eclypsium

Below The Surface: Get the latest threat research and insights on
firmware and supply chain threats from the research team at Eclypsium.
https://eclypsium.com/research/#threatreport
