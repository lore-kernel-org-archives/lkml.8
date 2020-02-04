Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C57C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB202051A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/7fY+cM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgBDLCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:02:25 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34876 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgBDLCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:02:25 -0500
Received: by mail-pg1-f196.google.com with SMTP id l24so9491688pgk.2;
        Tue, 04 Feb 2020 03:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MiVnXA5aK8v20oDCHLDkGqJHHt/3RuU8j03946ozZx8=;
        b=C/7fY+cMEWaYIsU59xq5MgwiO1lxUZrinkvDRndlKhHPJ03TzDh6HNMVcQvJLgGvnz
         gl9mnJ6lkYtzZRWawwUFKNA7uajR3g8VAPT4tD0m93yeBS+kiWEpHXLIZoJmVKspQPKS
         6QlAAyM4LhNZ9MHZYY1J1luMx09P18cUD0OMHB01vy1rDUy76/A/OTXNK/4m2jr7m5Ri
         kO17apQysvKiT0XrFfQYxMJJ5vnA6H3PNE37mhqyZCrDcYI9GOHvq3VGD4oO9zfpj0G9
         wiHjKEoqHO8IL472uM44+GAAoj9tGPeGj7mY44pJauuUUk2I9LtO/AbKeB7padn8IYVl
         syKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MiVnXA5aK8v20oDCHLDkGqJHHt/3RuU8j03946ozZx8=;
        b=IWB3R9+Newo+T4slJA4ynjsTFE+MHEMeUf+3mqJYMrFeCQANa5uwJ9ZcufUsfZGLPL
         JZIC5JvDBAAgb3svEZJETeaDlr3YkEEwwIggwLOeAR/27C1FMj1x32QMYdVnm6A1wRln
         ekfwQWv8WkEIhFVvg/DThr3zdix3B3Qrh7smkExTI89YImgTRDPy/W/NcwZVKZkTMBL6
         1646m6gRelrZ2tvo0ThERXw5PQGg1ogv7ld+mWd/ry5wjAVvk+DTPtWSuQqD5x+7yCZ+
         JBNhPeZpYsuDUoxtuS9f/CLED/5vS6Jj3QXEQ3kJoQhvo5d3e54PUk1f3AVCdPMflYH0
         dIPA==
X-Gm-Message-State: APjAAAXKtbBSBgmEcz24biq2nhXA6JwPbhgTiLkVu1At1xgMqSewu+tG
        Zidc8gbLiufLcXfzyTpio83+Wvf4N9cwzmjwfTM=
X-Google-Smtp-Source: APXvYqwDC2BKvXqVTtDrxFRG/p/PCwQ6zoauDmrlD/SHKfk+1Gqa/D6QEirF0Jbh8RBnQQF1Qmn787N9MZj6s/1hdEA=
X-Received: by 2002:a63:5a23:: with SMTP id o35mr30392695pgb.4.1580814143283;
 Tue, 04 Feb 2020 03:02:23 -0800 (PST)
MIME-Version: 1.0
References: <1580328504-436-1-git-send-email-eajames@linux.ibm.com>
 <CAHp75VeNs9Zr1vayO8TwVq6=B8fwvv0chOt0in6Dw+WLCezL2g@mail.gmail.com> <29f6cc86-69ca-bc88-b6ae-2b1a24c0dae3@linux.vnet.ibm.com>
In-Reply-To: <29f6cc86-69ca-bc88-b6ae-2b1a24c0dae3@linux.vnet.ibm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 Feb 2020 13:02:15 +0200
Message-ID: <CAHp75Vf3NCkbw39E+d_nf+AyViG2o-u5HxrCjXXmbGk4LaFLog@mail.gmail.com>
Subject: Re: [PATCH] spi: Add FSI-attached SPI controller driver
To:     Eddie James <eajames@linux.vnet.ibm.com>
Cc:     Eddie James <eajames@linux.ibm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 3, 2020 at 10:33 PM Eddie James <eajames@linux.vnet.ibm.com> wrote:
> On 1/30/20 10:37 AM, Andy Shevchenko wrote:
> > On Wed, Jan 29, 2020 at 10:09 PM Eddie James <eajames@linux.ibm.com> wrote:

...

> >> +       struct device *dev;
> > Isn't fsl->dev the same?
> > Perhaps kernel doc to explain the difference?
>
>
> No, it's not the same, as dev here is the SPI controller. I'll add a
> comment.

Why to have duplication then?

> >> +       struct fsi_device *fsi;

...

> >> +       for (i = 0; i < num_bytes; ++i)
> >> +               rx[i] = (u8)((in >> (8 * ((num_bytes - 1) - i))) & 0xffULL);
> > Redundant & 0xffULL part.
> >
> > Isn't it NIH of get_unalinged_be64 / le64 or something similar?
>
>
> No, these are shift in/out operations. The read register will also have
> previous operations data in them and must be extracted with only the
> correct number of bytes.

Why not to call put_unaligned() how the tail in this case (it's 0 or
can be easily made to be 0) will affect the result?

> >> +       return num_bytes;
> >> +}

> >> +static int fsi_spi_data_out(u64 *out, const u8 *tx, int len)
> >> +{
> > Ditto as for above function. (put_unaligned ...)

Ditto.

> >> +}

...

> >> +static int fsi_spi_transfer_data(struct fsi_spi *ctx,
> >> +                                struct spi_transfer *transfer)
> >> +{
> > Can you refactor to tx and rx parts?
>
>
> Why?

It's way too long function to read. Indentation level also can improve
readability.
That's basically what refactoring is for.

> >> +       return 0;
> >> +}

...

> >> +       if ((clock_cfg & (SPI_FSI_CLOCK_CFG_MM_ENABLE |
> >> +                         SPI_FSI_CLOCK_CFG_ECC_DISABLE |
> >> +                         SPI_FSI_CLOCK_CFG_MODE |
> >> +                         SPI_FSI_CLOCK_CFG_SCK_RECV_DEL |
> >> +                         SPI_FSI_CLOCK_CFG_SCK_DIV)) != wanted_clock_cfg)
> >> +               rc = fsi_spi_write_reg(ctx, SPI_FSI_CLOCK_CFG,
> >> +                                      wanted_clock_cfg);
> > Missed {} ?
>
>
> No? It's one line under the if.

One statement, but *two* lines.
What does checkpatch.pl tell you about this?

-- 
With Best Regards,
Andy Shevchenko
