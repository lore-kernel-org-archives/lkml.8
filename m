Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDFAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A6862065F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stNWaVR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbgFOJtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgFOJtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:49:07 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0BFC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 02:49:07 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id s18so17155500ioe.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 02:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VXrYkWGJrAVwMKl7EpALp308abGzBC/xarfEjXsxyt8=;
        b=stNWaVR9mILoXoa35qUlmQKoIfjReV21Ygcw+kmOknzdyAd47EecdwrcHgyRIiCHc1
         kQCq9ajBuZH0EJcKAEy41F5r1lmg3Xev/NaEqR0jd32aw7B93AXyVciu8HlaioBsrRMa
         K7pPbZ5Hun7PnTPlPf5NuynGDQOxVE/YVHxIVl0QfCfgsQXN3QkPEgKr16OI3zfTVvXm
         jpxgMZCcczb2muIjitZvQEWmx8fQMMOFJUYtyfZ8LcgYQiO9lgA8ZWnm1GzkJnvbizYr
         568nqQkmYJRdlD94NgsZ4GOm/ePu02U7PzSC2Tb7IfKNchJUi/Aeb/K1M6dPJXfapOmD
         A7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VXrYkWGJrAVwMKl7EpALp308abGzBC/xarfEjXsxyt8=;
        b=oiNY1bLyeNMp44K2IseSivqdQBc0BxWS7XSmvuf1Nh5UgPzHa69G/PRyWsf9ZDalpq
         /QI/9IGkTjHXlnVE0k/CsnrZG1knoX1pHNmHQyu+406Ohch44JOqDIP5M74l9DxDzZQA
         zDRHEYob3Orv/eHezOM6zNS8AgYe3B3pgcHJZpSqX7kTTWUFdSNE1qjB6t1g0dBN63zH
         vDLkzmrGf3tZN+w9LsobWK0pEjYZ9t+Kp+ta4YTAcvBh1iodVSdiZDHK9wNZagQ4Y4oT
         kQYYOy8pgp1xq4WPBufb697A4BZAUqJQ0hW7Kr3izpFBaLSU6djZcsELHu966rArtT1R
         1a7g==
X-Gm-Message-State: AOAM531IV61LDpe4gXQuzu4zIsMqD3/J8CypRdMdiLxaTWPfFG3mtlwp
        zzpKNK3t2IPtRAqXqYO2NcluIQZtfRcQDX7LDOY=
X-Google-Smtp-Source: ABdhPJxtXsKmf8Rv/T8eBzugDRbZKh4vUmXzvKagG59avK0BfoIYZLDJkcITgkfHBgVawjBi74gfiqsC3RANgxO/XoI=
X-Received: by 2002:a5e:aa14:: with SMTP id s20mr27326679ioe.58.1592214546938;
 Mon, 15 Jun 2020 02:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <1591254387-10304-1-git-send-email-gene.chen.richtek@gmail.com> <20200604133943.GE6644@sirena.org.uk>
In-Reply-To: <20200604133943.GE6644@sirena.org.uk>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Mon, 15 Jun 2020 17:48:55 +0800
Message-ID: <CAE+NS35ktxq2MiNXNWh7Q-gzdbm7Xoj2tXqrgzjkkv8W_tR3Sw@mail.gmail.com>
Subject: Re: [PATCH] regulator: mt6360: Add support for MT6360 regulator
To:     Mark Brown <broonie@kernel.org>
Cc:     matthias.bgg@gmail.com, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com, Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loop MFD maintainer,

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

ACK, we will remove it

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

ACK

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

ACK, we will update binding document later.

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

Because MT6360 include PMU/PMIC/LDO/TYPEC part, only PMIC/LDO i2c R/W
need contain CRC format.
We will update new patch to conclude r/w in mfd driver.
According to different register address with bank number, we can
distinguish different part of module.
