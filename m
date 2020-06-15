Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2895C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 550692078A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpG1v374"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbgFOPI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729875AbgFOPI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:08:26 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FD3C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:08:25 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c12so9735655lfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+wmoyb0CAL/LuhyaYWGTYXhkQwz3N5+E6mLs3ScOlYA=;
        b=JpG1v374tQ+JD8JP3ukzFO5K3qzXy06U7rK7ck9F9YGJ5GwNp5lDIxkK71DMR2COXr
         lShPHgDOS8IbkETbBFQ4c9RD/CeHFsfb1TUlXxtTUl2ibKTy7q/ZQU+128NSsmObej/l
         a1z3TQPxOuazkTUAyePjpva/6QJ6N3Di2bPrlg5R4ZMtZ6Wo4TgYVw0gmwjIeOcv1XEq
         Zi0FcYIprt3ItL/YGaXfRqtzbv3MCFTRNIA91/SYb/NULP41p8wKTUcnp0+v/DqK2Fvs
         /m+fhYWGoD5xaWb3gAq0md6hRYGk9N8Vna2w//Smrg3pelOIzBDlj/kCAdaqZP2I0/Rp
         1GdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+wmoyb0CAL/LuhyaYWGTYXhkQwz3N5+E6mLs3ScOlYA=;
        b=VnN3kkRKoH7UPodGAHlkqwjmwRdc9tMzQSAGzih9kE40F09uVC0ll6F2rSFLyLhYFr
         UgmuWU0WxDOtQw/4d4UhoaSU1nmSers3F6/4BqZu3bEjKXBPc1ejl03sNSC0Nc4Z2Taw
         JbmH3y+LmgNAUC82RVN+5Z0Uf4rjfzwGyXVmHKkaZ07lD5nDj4UWqdKAXmk/rQyt5ZWc
         /bLBOcgzC7dHQOoCL7XkYVsCBPwk2CAo0JnRpld1q41Biwcz3Bpq6ecsEBEtqJJiq8Zd
         vUM7tJ98IefGPGOsLTiLb25ESB9Hp4SyD5w6jZYwnhrdLkQt8ZTH61iKLPI/w+v9QWJm
         OKvQ==
X-Gm-Message-State: AOAM531KqJE34tKmpi3rMPqEr3gyyJW8JM7Zmz/LINuLFpIq05anY/CR
        xIb/KovxpZnLpkDH4gRq7aDF8hrnoCwDLEjsGao=
X-Google-Smtp-Source: ABdhPJxnb16s3HzpwAQcogzDTuHatdlI1VVy/3H4sed0It4QaNIaVF3ia1LCclY05FYXohLe+n3Z9rWH0s639w6yG0c=
X-Received: by 2002:a19:8389:: with SMTP id f131mr2452754lfd.16.1592233704228;
 Mon, 15 Jun 2020 08:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200615034715.11438-1-zhang.lyra@gmail.com> <CADBw62oCNrvTgu9k-iykaX4bbpVWjbg3GN+v5yPBCc9R2bR3Pg@mail.gmail.com>
In-Reply-To: <CADBw62oCNrvTgu9k-iykaX4bbpVWjbg3GN+v5yPBCc9R2bR3Pg@mail.gmail.com>
From:   Orson Zhai <orsonzhai@gmail.com>
Date:   Mon, 15 Jun 2020 23:08:12 +0800
Message-ID: <CA+H2tpF95rLRb8qbgCsrKBtjTV7JMTenuaYBHf19tpAXFqmqMQ@mail.gmail.com>
Subject: Re: [PATCH] mfd: sprd: get subdevices from DT instead for SC27XX SPI
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 10:12 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> On Mon, Jun 15, 2020 at 11:47 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> >
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > SC27XX-SPI added subdevices according to a pre-defined mfd_cell array,
> > no matter these devices were really included on board. So with this
> > patch we switch to a new way of detecting subdevices which are
> > defined in the devicetree.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  drivers/mfd/sprd-sc27xx-spi.c | 102 +++++++++++-----------------------
> >  1 file changed, 31 insertions(+), 71 deletions(-)
> >
> > diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
> > index 33336cde4724..aa3daa0cfcf5 100644
> > --- a/drivers/mfd/sprd-sc27xx-spi.c
> > +++ b/drivers/mfd/sprd-sc27xx-spi.c
> > @@ -93,73 +93,6 @@ enum usb_charger_type sprd_pmic_detect_charger_type(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(sprd_pmic_detect_charger_type);
> >
> > -static const struct mfd_cell sprd_pmic_devs[] = {
> > -       {
> > -               .name = "sc27xx-wdt",
> > -               .of_compatible = "sprd,sc2731-wdt",
> > -       }, {
> > -               .name = "sc27xx-rtc",
> > -               .of_compatible = "sprd,sc2731-rtc",
> > -       }, {
> > -               .name = "sc27xx-charger",
> > -               .of_compatible = "sprd,sc2731-charger",
> > -       }, {
> > -               .name = "sc27xx-chg-timer",
> > -               .of_compatible = "sprd,sc2731-chg-timer",
> > -       }, {
> > -               .name = "sc27xx-fast-chg",
> > -               .of_compatible = "sprd,sc2731-fast-chg",
> > -       }, {
> > -               .name = "sc27xx-chg-wdt",
> > -               .of_compatible = "sprd,sc2731-chg-wdt",
> > -       }, {
> > -               .name = "sc27xx-typec",
> > -               .of_compatible = "sprd,sc2731-typec",
> > -       }, {
> > -               .name = "sc27xx-flash",
> > -               .of_compatible = "sprd,sc2731-flash",
> > -       }, {
> > -               .name = "sc27xx-eic",
> > -               .of_compatible = "sprd,sc2731-eic",
> > -       }, {
> > -               .name = "sc27xx-efuse",
> > -               .of_compatible = "sprd,sc2731-efuse",
> > -       }, {
> > -               .name = "sc27xx-thermal",
> > -               .of_compatible = "sprd,sc2731-thermal",
> > -       }, {
> > -               .name = "sc27xx-adc",
> > -               .of_compatible = "sprd,sc2731-adc",
> > -       }, {
> > -               .name = "sc27xx-audio-codec",
> > -               .of_compatible = "sprd,sc2731-audio-codec",
> > -       }, {
> > -               .name = "sc27xx-regulator",
> > -               .of_compatible = "sprd,sc2731-regulator",
> > -       }, {
> > -               .name = "sc27xx-vibrator",
> > -               .of_compatible = "sprd,sc2731-vibrator",
> > -       }, {
> > -               .name = "sc27xx-keypad-led",
> > -               .of_compatible = "sprd,sc2731-keypad-led",
> > -       }, {
> > -               .name = "sc27xx-bltc",
> > -               .of_compatible = "sprd,sc2731-bltc",
> > -       }, {
> > -               .name = "sc27xx-fgu",
> > -               .of_compatible = "sprd,sc2731-fgu",
> > -       }, {
> > -               .name = "sc27xx-7sreset",
> > -               .of_compatible = "sprd,sc2731-7sreset",
> > -       }, {
> > -               .name = "sc27xx-poweroff",
> > -               .of_compatible = "sprd,sc2731-poweroff",
> > -       }, {
> > -               .name = "sc27xx-syscon",
> > -               .of_compatible = "sprd,sc2731-syscon",
> > -       },
> > -};
> > -
> >  static int sprd_pmic_spi_write(void *context, const void *data, size_t count)
> >  {
> >         struct device *dev = context;
> > @@ -205,6 +138,35 @@ static const struct regmap_config sprd_pmic_config = {
> >         .max_register = 0xffff,
> >  };
> >
> > +static int sprd_pmic_add_subdevices(struct device *dev, int id,
> > +                        struct irq_domain *domain)
> > +{
> > +       int ret = 0;
> > +       struct device_node *child, *parent = dev->of_node;
> > +       struct mfd_cell cell = {0};
> > +       const char *comp;
> > +       unsigned int prefix_len = strlen("sprd,");
> > +       char buf[30];
> > +
> > +       for_each_child_of_node(parent, child) {
> > +               comp = of_get_property(child, "compatible", NULL);
> > +               if (!comp || strncmp("sprd,", comp, prefix_len))
> > +                       return -EINVAL;
> > +
> > +               memcpy(buf, comp, strlen(comp) + 1);
> > +               cell.of_compatible = buf;
> > +               cell.name = buf + prefix_len;
>
> I feel it is a little hackish, you can create any device nodes from DT
> even the PMIC does not support.

In the old code, if sub cells have wrong compatible strings, he will not get
an opportunity to be probed.
It is confused to user for  there is no any error and warning message.
I think it maybe better to let them being probed even when they might be wrong.
The cell will check by itself --  return success in probing if in the
right place or return error if any
thing is wrong there.

Best,
Orson

>
> I am not sure the problem caused by the original method, you can use
> the compatible string to be compatible with different PMICs, such as
> SC2730 ADC:
> compatible = "sprd,sc2731-adc", "sprd,sc2730-adc";
>
> Moreover I think you can add the "sprd,sc2730-xxx" compatible string
> for the mfd_cell in this driver if you are sure we want to support
> SC2730 PMIC.
>
> > +
> > +               ret = devm_mfd_add_devices(dev, id, &cell, 1, NULL, 0, domain);
> > +               if (ret) {
> > +                       pr_err("devm_mfd_add_devices return fail ret=%d\n", ret);
> > +                       break;
> > +               }
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> >  static int sprd_pmic_probe(struct spi_device *spi)
> >  {
> >         struct sprd_pmic *ddata;
> > @@ -263,10 +225,8 @@ static int sprd_pmic_probe(struct spi_device *spi)
> >                 return ret;
> >         }
> >
> > -       ret = devm_mfd_add_devices(&spi->dev, PLATFORM_DEVID_AUTO,
> > -                                  sprd_pmic_devs, ARRAY_SIZE(sprd_pmic_devs),
> > -                                  NULL, 0,
> > -                                  regmap_irq_get_domain(ddata->irq_data));
> > +       ret = sprd_pmic_add_subdevices(&spi->dev, PLATFORM_DEVID_AUTO,
> > +                                      regmap_irq_get_domain(ddata->irq_data));
> >         if (ret) {
> >                 dev_err(&spi->dev, "Failed to register device %d\n", ret);
> >                 return ret;
> > --
> > 2.20.1
> >
>
>
> --
> Baolin Wang
