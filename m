Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533EBC35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 16:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D522173E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 16:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNMMt0D4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgA3QoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 11:44:01 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38256 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbgA3QoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 11:44:01 -0500
Received: by mail-pj1-f68.google.com with SMTP id j17so1576074pjz.3;
        Thu, 30 Jan 2020 08:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ycendjGGLSJJKfAddBUkv4GJlX2it4/z973MJkVu4LQ=;
        b=QNMMt0D4HauFvbceWCYa4yl3fmMXCwgOzLBSGRqGg4xXXov2lZqkxZAwhHal5r1V3i
         +1oiOouohVEWcUf9vRBzBQ/ZbfhwvmGhDimwvZ8OwDNLhB68j8Ffky2c/bxYAzL7btHr
         +ZyXXemTp2aF+9WFM+6moabMxJzblgl12e3dQ6OX6UaUbFXmJ/1DS/kK/BKlvb7Nc3zb
         3wnuVNnrTbzGbzav9yhf7aB3AhmLAh25EsrZNYk59Hr0aQQIe2oHeXjNpZcz1UkWCuTq
         S9czNlkoP1QcyI4tJD6mf8OuzrDueiCaYnoJ7If3X9QVhU5wNvCun/AgbDw2y3wKa7xQ
         +4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ycendjGGLSJJKfAddBUkv4GJlX2it4/z973MJkVu4LQ=;
        b=KfFJQba8ZwX71Ob5IkXa4rfBHuwWN/pByblL7WF1Y0AztvqBnkdR4xz+CvZMMRZY0h
         geRcNBk6tqplNg6g/6w9HDAoUxHyIjz0jRx6uIqXuRusxWW0jZuKoypyLJuBjeYT2kpN
         G+ddMykA63SSf7SNEKx9D4VjEmXReB4w5PCrYWMTylTryZwFji2U2gbFySaC5tywj2qM
         /SVFn9L/y4MlhEp8+2Ee2tgSs+L8CTxnSMhmXitSK0W5vPzdapZjxgiurp58JrIEjCaa
         siq+LOMyvAxgpbmoXKXSc5a5TYret5Q8aBOksiP9MnC/idI27fr6Vr2CKYXs4JjGZkAs
         NKOg==
X-Gm-Message-State: APjAAAVOdMnwIfEH6Y49vWO+nRi+ga7TtyI0c9fYQtXRwqtfFFXBX1U/
        xP4s8iSS5gkklB4BL+5xGFi5y1oAWDChY6gpjBE=
X-Google-Smtp-Source: APXvYqyvQUPN02uVigJHi7v9slp8OLJElsr+cBUH7gHdJaw4tTtV5sPNiocWAArfhdKm1Uuc3mV3V8am+LG6yGz8adk=
X-Received: by 2002:a17:90b:3109:: with SMTP id gc9mr6947188pjb.30.1580402640436;
 Thu, 30 Jan 2020 08:44:00 -0800 (PST)
MIME-Version: 1.0
References: <20200127210415.5708-1-chris.packham@alliedtelesis.co.nz> <20200127210415.5708-3-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20200127210415.5708-3-chris.packham@alliedtelesis.co.nz>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 30 Jan 2020 18:43:52 +0200
Message-ID: <CAHp75Vd1i2rDwVcK54tox_5=q3b5HHjTa2dcsQqK_UE5ODcsVQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] spi: Add generic SPI multiplexer
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 11:04 PM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> Add a SPI device driver that sits in-band and provides a SPI controller
> which supports chip selects via a mux-control. This enables extra SPI
> devices to be connected with limited native chip selects.

...

>  obj-$(CONFIG_SPI_MEM)                  += spi-mem.o
>  obj-$(CONFIG_SPI_SPIDEV)               += spidev.o
>  obj-$(CONFIG_SPI_LOOPBACK_TEST)                += spi-loopback-test.o
> +obj-$(CONFIG_SPI_MUX)                  += spi-mux.o

Maybe after SPI_MEM ?

...

> +struct spi_mux_priv {
> +       struct spi_device       *spi;
> +       unsigned int            current_cs;
> +

> +       void                    (*child_mesg_complete)(void *context);
> +       void                    *child_mesg_context;
> +       struct spi_device       *child_mesg_dev;

mesg -> msg ?

> +       struct mux_control      *mux;
> +};

...

> +static int spi_mux_select(struct spi_device *spi)
> +{
> +       struct spi_mux_priv *priv = spi_controller_get_devdata(spi->controller);

> +       int ret = 0;

Drop this assignment...

> +       if (priv->current_cs != spi->chip_select) {

...convert this to
 if (cs == chip_select)
    return 0;

> +               dev_dbg(&priv->spi->dev,
> +                       "setting up the mux for cs %d\n",
> +                       spi->chip_select);

After above changes this perhaps fits one line (now it fits two, by
the way, not three).

> +}

-- 
With Best Regards,
Andy Shevchenko
