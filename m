Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6D2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF5720702
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G0G3QKuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgGGGEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgGGGEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 02:04:05 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A73C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 23:04:04 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id m26so24053301lfo.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 23:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UZZfuoHBs6UPr1tWf4DyOh5v+PqYB3B2WwbMcZ/xTQ4=;
        b=G0G3QKuWd6xOkxDOw6USZb4n6oCxxPmZWNq/guSOxlAl6VlpVmBqxHZ61L96aLMc8U
         Yg6RLBFj1duBvMZdUtqXpCBwzS1P3iD+fsa/FHv/Of+fNYYOkWjPn46fY60/nx2vM58x
         BP89ovi4Qwb+opQ7neeZ7nCEOaAZuw+twJGgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UZZfuoHBs6UPr1tWf4DyOh5v+PqYB3B2WwbMcZ/xTQ4=;
        b=ayXV9sLG6CaQpYM1LS18LV5J9Ex/f9F9/bhOBMakXPJ+VD/jE0kLFr9/2LjspbCF/I
         P9M8vNZPv/GdYvI7+/SdIg0RUiMRyDgQebyq0INWm9RUvsNV/qfHSahuyF114NIjNAGH
         72OeTnfRMygzH4uUHZ75a0POr0rWa0UVTKxETX9noEaAaalJXHvlzS62M2JF31ERxV7K
         2cZfudBAv5L8bzPSU7TQE+wgcgX3WKYA2+9EqUCeGQhqBkDRIkEIf6yGedg3HMZFG7c/
         rtjRwwrw1tj9DpoSZ+aJaucE3bEfIiaKYMgqy2kVFrilDibiQZsaAImDqZGVsk0o7CQ8
         GoGw==
X-Gm-Message-State: AOAM533CMA5GIg54Cbpfce/S7gigrU/gmtdqRZqm6veQPOSv7qfL1snO
        gU4JOQF5kvIu2G0FsHSVFCupQwRGndQ0ugLkVA5BxjBomuo5Zg==
X-Google-Smtp-Source: ABdhPJzxmwvqREl7NOVxuGKyaJKb1ZGT35t2pGwTUaSaxw5RyPOzOIeMQ3BFzgVfB8J0dfix80VsZRRnWDvW8/xjGlQ=
X-Received: by 2002:ac2:5f0b:: with SMTP id 11mr31805351lfq.201.1594101842863;
 Mon, 06 Jul 2020 23:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200529071655.739-1-rayagonda.kokatanur@broadcom.com> <2c308101-ba40-2dd4-7304-7e2e29e9aa64@microchip.com>
In-Reply-To: <2c308101-ba40-2dd4-7304-7e2e29e9aa64@microchip.com>
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Date:   Tue, 7 Jul 2020 11:33:50 +0530
Message-ID: <CAHO=5PFyjHJvvy-=exL86OnESH7ypUffyt3bcmQJspzJJ5gO-A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] drivers: mtd: spi-nor: update read capabilities
 for w25q64 and s25fl064k
To:     Tudor Ambarus <Tudor.Ambarus@microchip.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 12:21 PM <Tudor.Ambarus@microchip.com> wrote:
>
> On 5/29/20 10:16 AM, Rayagonda Kokatanur wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > Both w25q64 and s25fl064k nor flash support QUAD and DUAL read
> > command, hence update the same in flash_info table.
> >
> > This is tested on Broadcom Stingray SoC (bcm958742t).
> >
> > Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> > ---
> > Changes from v1:
> >  -Address review comments from Vignesh Raghavendra
> >   Update commit message with testing details.
> >
> >  drivers/mtd/spi-nor/spansion.c | 3 ++-
> >  drivers/mtd/spi-nor/winbond.c  | 3 ++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
> > index 6756202ace4b..c91bbb8d9cd6 100644
> > --- a/drivers/mtd/spi-nor/spansion.c
> > +++ b/drivers/mtd/spi-nor/spansion.c
> > @@ -52,7 +52,8 @@ static const struct flash_info spansion_parts[] = {
> >                              SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> >         { "s25fl016k",  INFO(0xef4015,      0,  64 * 1024,  32,
> >                              SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > -       { "s25fl064k",  INFO(0xef4017,      0,  64 * 1024, 128, SECT_4K) },
> > +       { "s25fl064k",  INFO(0xef4017,      0,  64 * 1024, 128,
> > +                            SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> >         { "s25fl116k",  INFO(0x014015,      0,  64 * 1024,  32,
> >                              SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> >         { "s25fl132k",  INFO(0x014016,      0,  64 * 1024,  64, SECT_4K) },
> > diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
> > index 17deabad57e1..2028cab3eff9 100644
> > --- a/drivers/mtd/spi-nor/winbond.c
> > +++ b/drivers/mtd/spi-nor/winbond.c
> > @@ -39,7 +39,8 @@ static const struct flash_info winbond_parts[] = {
> >                             SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> >                             SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
> >         { "w25x64", INFO(0xef3017, 0, 64 * 1024, 128, SECT_4K) },
> > -       { "w25q64", INFO(0xef4017, 0, 64 * 1024, 128, SECT_4K) },
> > +       { "w25q64", INFO(0xef4017, 0, 64 * 1024, 128,
> > +                        SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>
> I checked the winbond website and from all the w25q64 flashes, W25Q64JV-IQ/JQ
> and W25Q64FV share the 0xef4017 flash ID. Both support 0x3b and 0x6b commands,
> which is fine.
>
> I see that s25fl064k and w25q64 share the same flash ID. The search alg will
> return the first hit, so s25fl064k even for the winbond parts. What is the
> difference between s25fl064k and W25Q64JVQ/W25Q64FV?

I think both are from different vendor.
Please refer link for more info -
https://lore.kernel.org/patchwork/patch/628090/

Best regards,
Rayagonda

>
> Cheers,
> ta
