Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC97C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B0BB2071A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lt1Mz1UB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbgFRLft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 07:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729504AbgFRLfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 07:35:37 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59279C0613EE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 04:35:37 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id l6so5438218ilo.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 04:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JoImTQwHdtw7/u/D4MJchsr+Ube0p5e5ttJYUSlUpgQ=;
        b=Lt1Mz1UBqn4v0w8t7F1YhIpWSQuFgNS/kCO/yeKmffOJRhoRO+kswwtX1bZg/CpcA3
         FxITHVZSEmAmA71HhXzsRUZdkJRwqWC/a11ZPhaaLg6rMCnRBLYv1ulNZC3rlSblgSsg
         k8csSswosgP0RAkGNLL+0jYWSnrCKIuPRd5q+02CaO853Vig0Z/gZciiWM/Kh9cyOPV1
         6PKpS3M6+0MwYqXDcONvLlJkdVAorcB7+EJxZLfr/dUH54KK9+bXAhlQMtNbW2bzG3sI
         fpmMu60fQv0YuJ5GdrONJuc9o8D0fY4wEI8Nab6IdBIoUEaedWlE/XAFBRE9l1vWozHB
         9nkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JoImTQwHdtw7/u/D4MJchsr+Ube0p5e5ttJYUSlUpgQ=;
        b=EktuU93ghSp1HfYKV4T3cuXvr42aaSjwX2+yGz54TaV+rzjh3IJIRqecShfU6yEidf
         F9L11sDSi7cftau7MO+huTdmB65FcvZOsWWvnLcgNjxPj2z3l1m2qAnOMojVRGrsQOdt
         ISssqJpSoVXZCtyCxKSFZCnP11lIERPuJjMHKRIDjzhx/byGUuf0kGXeJgx8+OBBJ+8W
         beFNe+5Z+0eq9xMtKHB87HDAlTUeqql88K2PVNPKV7tOTyxZgRqToFaaKu2Jtd/fKZJ8
         J2/gpB5DWua+2YfC3VGpuMAPO0Jtp3qsHABmrSWDp3Ceozf6wZxp7h3V5XOwN1Xn0zU6
         ma8g==
X-Gm-Message-State: AOAM5305gjTHrp6DXsPZFiajjl53vQY9OrtC/mmRXl5iz8A4nkgY/F/r
        inILqXAgDA+JOqPyn8Gmh5BeGQLCVgHKR6Rs+Lf/Xa34
X-Google-Smtp-Source: ABdhPJzYeEnhdGZ/i7kYQ2XISNyEFrlAzlCA0rOukEZlRzPYdf0l9uZob5Z3q9PBbsJtN04Vv2QSj45/3Ti31rK/Pts=
X-Received: by 2002:a92:ab04:: with SMTP id v4mr3631570ilh.186.1592480136715;
 Thu, 18 Jun 2020 04:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <1591254387-10304-1-git-send-email-gene.chen.richtek@gmail.com> <20200604133943.GE6644@sirena.org.uk>
In-Reply-To: <20200604133943.GE6644@sirena.org.uk>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Thu, 18 Jun 2020 19:35:24 +0800
Message-ID: <CAE+NS34dkz6p6Zgr0SU5ETPMe0uuDiVUOrqT4W0g_m=SnvNg3g@mail.gmail.com>
Subject: Re: [PATCH] regulator: mt6360: Add support for MT6360 regulator
To:     Mark Brown <broonie@kernel.org>
Cc:     matthias.bgg@gmail.com, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> =E6=96=BC 2020=E5=B9=B46=E6=9C=884=E6=97=A5=
 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=889:39=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, Jun 04, 2020 at 03:06:27PM +0800, Gene Chen wrote:
>
> This looks nice and simple, a few fairly small comments below but high
> level it's basically fine.
>
> > --- /dev/null
> > +++ b/drivers/regulator/mt6360-regulator.c
> > @@ -0,0 +1,571 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2020 MediaTek Inc.
>
> Please make the entire comment a C++ one so things look more
> intentional.
>

ACK

> > +     for (i =3D 0; i < devdata->num_irq_descs; i++) {
> > +             irq_desc =3D devdata->irq_descs + i;
> > +             if (unlikely(!irq_desc->name))
> > +                     continue;
>
> Do we really need an unlikely here?  This shouldn't be a hot path.
>
> > +static int mt6360_regulator_set_mode(
> > +                               struct regulator_dev *rdev, unsigned in=
t mode)
> > +{
>
> > +     switch (1 << (ffs(mode) - 1)) {
> > +     case REGULATOR_MODE_NORMAL:
>
> I don't understand why this isn't just a straight switch on mode?
>

ACK, we will fix it

> > +static unsigned int mt6360_regulator_get_mode(struct regulator_dev *rd=
ev)
> > +{
> > +     const struct mt6360_regulator_desc *desc =3D
> > +                            (const struct mt6360_regulator_desc *)rdev=
->desc;
> > +     int shift =3D ffs(desc->mode_get_mask) - 1, ret;
> > +     unsigned int val =3D 0;
> > +
> > +     default:
> > +             ret =3D 0;
> > +     }
>
> If we can't parse a valid value from the hardware then that's an error.
>

ACK

> > +static int mt6360_regulator_reg_write(void *context,
> > +                                   unsigned int reg, unsigned int val)
> > +{
> > +     struct mt6360_regulator_data *mrd =3D context;
> > +     u8 chunk[4] =3D {0};
> > +
> > +     /* chunk 0 ->i2c addr, 1 -> reg_addr, 2 -> reg_val 3-> crc8 */
> > +     chunk[0] =3D (mrd->i2c->addr & 0x7f) << 1;
> > +     chunk[1] =3D reg & 0x3f;
> > +     chunk[2] =3D (u8)val;
> > +     chunk[3] =3D crc8(mrd->crc8_table, chunk, 3, 0);
> > +     /* also dummy one byte */
> > +     return i2c_smbus_write_i2c_block_data(mrd->i2c, chunk[1], 3, chun=
k + 2);
> > +}
>
> Oh, wow - that's a fun I/O interface!
>

MT6360 PMIC/LDO part use CRC to avoid i2c write mistaken

> > +static const struct of_device_id __maybe_unused mt6360_regulator_of_id=
[] =3D {
> > +     {
> > +             .compatible =3D "mediatek,mt6360_pmic",
> > +             .data =3D (void *)&mt6360_pmic_devdata,
> > +     },
> > +     {
> > +             .compatible =3D "mediatek,mt6360_ldo",
> > +             .data =3D (void *)&mt6360_ldo_devdata,
> > +     },
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(of, mt6360_regulator_of_id);
>
> I don't see any DT bindings documentation for this, documentation is
> required for all new bindings.
>

ACK, we will update binding document

> > +     mrd->regmap =3D devm_regmap_init(&(mrd->i2c->dev),
> > +                                    NULL, mrd, devdata->regmap_config)=
;
> > +     if (IS_ERR(mrd->regmap)) {
> > +             dev_err(&pdev->dev, "Failed to register regmap\n");
> > +             return PTR_ERR(mrd->regmap);
> > +     }
>
> This looks like a MFD so it's surprising to see us defining a regmap at
> this level.  Why are we doing this?

because other sub-device (e.g. CHARGER/LED/ADC) no need CRC when i2c R/W
we will merge remgap into mfd, and use "bank" strategy to distinguish
different part
