Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAD3C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 19:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BF8A2184D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 19:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aGj4Wnxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgEHTjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 15:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726913AbgEHTjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 15:39:17 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA161C05BD09
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 12:39:15 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w20so2919558ljj.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 12:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gjrGLJHLzoxchg9f/7+BzZ/emAWiNvtOkRqlM0vdoIg=;
        b=aGj4Wnxz1/aQyFPMr7NUm4zXJhJ8h7VAryh5DVU6ZQt6AVBxS9tmKQlupGJ5KeXejP
         KSz+L58WUX50UeLf1ShwLZkVfus9ZX0lgD06QjMNC3/zKkfIiXkiwYge15T1/gUc27aO
         SkBLyUASa8xg9hfhlhGe48TZ8pL8eEM/DPhjceFCm41s4igWICxrTAtxmj/XVBmMuxC4
         E0I1gaydT5OWK5CYVJmqK9YvykFVgSYts/bi6SSXxHBh3rqtCTLdTb3PJAIbT3TVcvcg
         VNqziYQkuxX1HykgiPzPe2jl2OWQ4sEXFDROXuEuqS3AeWyiXcSOnUPjvLntH8TtjK2v
         OUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gjrGLJHLzoxchg9f/7+BzZ/emAWiNvtOkRqlM0vdoIg=;
        b=clXgYDle7BbD1jTpzLb9IMEFQCHyFB7I4y58kjvZijmbAe74tJWJhyWoIUp++VGesp
         MRTMh+2KeEwzSMP+FGXISE2rYC1B/AwugosbuXy2D6GGeoP/bnEiHRY2AoMb7dzzcOcz
         v412NlCVnWcqDzv51TqCqqOltg9VSiFrD0dFY29jCCnmjH3qwEj3oDrMjBJlmddbMW2R
         HqjTz+vToIfzsUsepGr61TKqoNxA7CukfxuVC6oOmHl48R3yBeRSr7RRB3rqXnZZJXX/
         mQHq/E3sUiSBIwishL+SuHqRYaxLOTN1uSDJe0GquL1NzMejk6e9eXdrzVFHZtQr+yAI
         f88w==
X-Gm-Message-State: AOAM533WxMEeBG/XlPeHR8DB9+Kd7nFt1y7GtCLGT2c+t0KKzmY+IJK0
        9DyLxE9TyC+YhoI0xXAS74IdFl6m0b8o/hzcVCRXNA==
X-Google-Smtp-Source: ABdhPJzVNt0K7k0tLrvgknOBlVHyrZtBVYfRv9CoX9LYJ+b2t/u4YporDzh0yTsMzYpoIig38TiOGb/ERqa5Fzvduw8=
X-Received: by 2002:a2e:8087:: with SMTP id i7mr2546861ljg.99.1588966753962;
 Fri, 08 May 2020 12:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru> <20200508132943.9826-12-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200508132943.9826-12-Sergey.Semin@baikalelectronics.ru>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 May 2020 21:39:02 +0200
Message-ID: <CACRpkdY=wkgnYPcqSzyzNpS6ckJZs-9kXfTfdwa1E+POzOBQGA@mail.gmail.com>
Subject: Re: [PATCH 11/17] spi: dw: Fix native CS being unset
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        "wuxu.wu" <wuxu.wu@huawei.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 3:31 PM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:

> Commit 6e0a32d6f376 ("spi: dw: Fix default polarity of native
> chipselect") attempted to fix the problem when GPIO active-high
> chip-select is utilized to communicate with some SPI slave. It fixed
> the problem, but broke the normal native CS support. At the same time
> the reversion commit ada9e3fcc175 ("spi: dw: Correct handling of native
> chipselect") didn't solve the problem either, since it just inverted
> the set_cs() polarity perception without taking into account that
> CS-high might be applicable. Here is what is done to finally fix the
> problem.

I'm not sure this is the whole story.

I think Charles' fix made it work, and then commit
3e5ec1db8bfee845d9f8560d1c64aeaccd586398
"spi: Fix SPI_CS_HIGH setting when using native and GPIO CS"
fixed it broken again.

This commit will make sure only set SPI_CS_HIGH on a
spi_device if it is using a GPIO as CS. Before this change,
the core would set that on everything, and expect the
.set_cs() callback to cope.

I think we fixed that and that fix should have been undone
when applying commit 3e5ec1db8bfe.

So possibly Fixes: should be set only to this commit, so
that the fix is not backported to kernels without it.

> DW SPI controller demands any native CS being set in order to proceed
> with data transfer. So in order to activate the SPI communications we
> must set any bit in the Slave Select DW SPI controller register no
> matter whether the platform requests the GPIO- or native CS.

Ah-ha! Maybe we should even add a comment explaining that.
And that is why SPI_MASTER_GPIO_SS is set.

I suppose my naive understanding was:
"bit set to 1" = CS asserted (driven low)
"bit set to 0" = CS de-asserted  (driven high)
So that is not how this register works at all.

> This commit fixes the problem for all described cases. So no matter
> whether an SPI slave needs GPIO- or native-based CS with active-high
> or low signal the corresponding bit will be set in SER.

Makes sense.

>         struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
>         struct chip_data *chip = spi_get_ctldata(spi);
> +       bool cs_high = !!(spi->mode & SPI_CS_HIGH);
>
>         /* Chip select logic is inverted from spi_set_cs() */
>         if (chip && chip->cs_control)
>                 chip->cs_control(!enable);
>
> -       if (!enable)
> +       if (cs_high == enable)
>                 dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));

This is the correct fix now but I an afraid not correct before
commit 3e5ec1db8bfe.

What I can't help but asking is: can the native chip select even
handle active high chip select if not backed by a GPIO?
Which register would set that polarity?

Yours,
Linus Walleij
