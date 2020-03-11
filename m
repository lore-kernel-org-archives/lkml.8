Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F342C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F384C208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dT0pZcxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgCKMpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:45:11 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35837 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbgCKMpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:45:10 -0400
Received: by mail-qt1-f193.google.com with SMTP id v15so1413992qto.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 05:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7snnG2HZlswbBJSz223TSuoJZEBBjKBU34cy2pxEXn0=;
        b=dT0pZcxvwIPX12xfO4t487Fl0GOHZ/A6IaR2M6mQ5GM+E/wk7iNUrFXHT9FF+0NYI9
         GHEFu91lwkPTexBWbmw+gJ/MTIAdNRydvdbLjgD2Ry7C4IoHXnUuxKqP98n4UKOpPzGO
         hKJw5rM5rPUNzTVDN079X7RLLDw9qBEj2Kxb1QAJsIq/AXle7eLexfHmwAy2jEAyvqF2
         UPyUdHDVL6KcS6FtNjZpylVb2pRDg2l4OzByfRPIfiZWWJBLBkUv6lg/mf1cNrvx8cak
         n5/xcp5ZyE4GXgE/3ZG8qDhGC3hmCnXM1T/weA8ISyyBQHNoVu+ifljhKf1CTXr+p8k7
         c4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7snnG2HZlswbBJSz223TSuoJZEBBjKBU34cy2pxEXn0=;
        b=M/UDOs1I9pOGfp600n0hCnUT/IiDbWCxFtzyEUdildKkLTN2eKD9Q+x/elv2zwWc2f
         KrLfslg3AP+cer9FMp5rLgcDaZxnNoapTT3MvfjS2TZoTIanEKuTaAK6O1q/BIDvMkkD
         rzIoa+k/wsylBG0ddNLY6RRoPsDeBanOrH5CL1mLojhc7mUJHzFV3RYi1v0DKRXty4oi
         Dhgq6akI1fBeK5ws9a+/9HtiDLtQzoKiqPVAWdP9CS1BrfpQkYb32MBHpRWpNKvotX99
         t9GdV47Vjgf7tLjuelNZ4HCrzQ/pEhxml5Rc5mFgYDdF8rs9ZGii324kMkq/X2EtVDvf
         H+Gw==
X-Gm-Message-State: ANhLgQ0Mps6cs97qO2cZrUPMbQsfu/dE80ZjefBj1YJjm330jPnQBDIc
        y9KnDSfAlplHEcFykXdAchMbP+vHfv2EoxjqzJN/fw==
X-Google-Smtp-Source: ADFU+vs4VPyLyCMdpaRb3Mw9YsCh4XInG4OPRetr+tK0zFze5UffR48usFwGSLRHCwJzcCynq75BaoCR2JKyG66qP/U=
X-Received: by 2002:ac8:3a63:: with SMTP id w90mr2379643qte.27.1583930707972;
 Wed, 11 Mar 2020 05:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <1583780521-45702-1-git-send-email-opendmb@gmail.com>
In-Reply-To: <1583780521-45702-1-git-send-email-opendmb@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 11 Mar 2020 13:44:56 +0100
Message-ID: <CAMpxmJXNQQTxRWZSP0RZTUuefAk3+AeDMVeVkgERy7f9X=CBsA@mail.gmail.com>
Subject: Re: [PATCH V2] gpio: brcmstb: support gpio-line-names property
To:     Doug Berger <opendmb@gmail.com>
Cc:     Gregory Fong <gregory.0xf0@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-gpio <linux-gpio@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 9 mar 2020 o 20:02 Doug Berger <opendmb@gmail.com> napisa=C5=82(a):
>
> The default handling of the gpio-line-names property by the
> gpiolib-of implementation does not work with the multiple
> gpiochip banks per device structure used by the gpio-brcmstb
> driver.
>
> This commit adds driver level support for the device tree
> property so that GPIO lines can be assigned friendly names.
>
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> ---
>  drivers/gpio/gpio-brcmstb.c | 44 +++++++++++++++++++++++++++++++++++++++=
+++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
> index 05e3f99ae59c..fcfc1a1f1a5c 100644
> --- a/drivers/gpio/gpio-brcmstb.c
> +++ b/drivers/gpio/gpio-brcmstb.c
> @@ -603,6 +603,49 @@ static const struct dev_pm_ops brcmstb_gpio_pm_ops =
=3D {
>         .resume_noirq =3D brcmstb_gpio_resume,
>  };
>
> +static void brcmstb_gpio_set_names(struct device *dev,
> +                                  struct brcmstb_gpio_bank *bank)
> +{
> +       struct device_node *np =3D dev->of_node;
> +       const char **names;
> +       int nstrings, base;
> +       unsigned int i;
> +
> +       base =3D bank->id * MAX_GPIO_PER_BANK;
> +
> +       nstrings =3D of_property_count_strings(np, "gpio-line-names");
> +       if (nstrings <=3D base)
> +               /* Line names not present */
> +               return;
> +
> +       names =3D devm_kcalloc(dev, MAX_GPIO_PER_BANK, sizeof(*names),
> +                            GFP_KERNEL);
> +       if (!names)
> +               return;
> +
> +       /*
> +        * Make sure to not index beyond the end of the number of descrip=
tors
> +        * of the GPIO device.
> +        */
> +       for (i =3D 0; i < bank->width; i++) {
> +               const char *name;
> +               int ret;
> +
> +               ret =3D of_property_read_string_index(np, "gpio-line-name=
s",
> +                                                   base + i, &name);
> +               if (ret) {
> +                       if (ret !=3D -ENODATA)
> +                               dev_err(dev, "unable to name line %d: %d\=
n",
> +                                       base + i, ret);
> +                       break;
> +               }

This bit is confusing to me. If we can't read the property we break
the loop and leave the remaining line names null but at the same time
it isn't considered a probe failure? Would you mind at least
commenting on this in the code?

Bart

> +               if (*name)
> +                       names[i] =3D name;
> +       }
> +
> +       bank->gc.names =3D names;
> +}
> +
>  static int brcmstb_gpio_probe(struct platform_device *pdev)
>  {
>         struct device *dev =3D &pdev->dev;
> @@ -726,6 +769,7 @@ static int brcmstb_gpio_probe(struct platform_device =
*pdev)
>                 need_wakeup_event |=3D !!__brcmstb_gpio_get_active_irqs(b=
ank);
>                 gc->write_reg(reg_base + GIO_MASK(bank->id), 0);
>
> +               brcmstb_gpio_set_names(dev, bank);
>                 err =3D gpiochip_add_data(gc, bank);
>                 if (err) {
>                         dev_err(dev, "Could not add gpiochip for bank %d\=
n",
> --
> 2.7.4
>
