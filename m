Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5909CC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DB7B21D79
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HX+OlvYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgIIHKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgIIHJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:09:58 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97E5C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 00:09:57 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t18so742859ilp.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 00:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K5nt6NW95MoUAw6MEltboJP4x+aHBBR4bvSni/nMTG8=;
        b=HX+OlvYfFmyRY5KpnVk1/SUaMZH+K1Xnbx4XAYBPTuFmyWdcLqS50beKODjTdFXU38
         ueuKrhflniqebAemuOkyT7bjtG/DbEI26PRkrdAVlMTxbNRBHL3FVNHv6rRbySPWYwM2
         oinTrfj9fbCM547HrtJlFn1ROfb8IdjVvi1E17ndMY9F6Oub5qfD4i3uxav+hRjHKbmn
         otQy3DKscJbCeBBmuAZ951ikCqkzbXQCMWcCjUNIqDQEzJuPP8axmWCPpa6CALAZPRrd
         SncUjs/kvzfLyisAKFoz1NhI/4LYSp1QG4p7E+nthO8NTQeq73mjmjB7o8fGjOtymCxv
         GTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K5nt6NW95MoUAw6MEltboJP4x+aHBBR4bvSni/nMTG8=;
        b=XkOAAgEVSiNcAagopaS2LdKjF+K7J9yMdgZD+DG+NWvP64hQGOu15jFc2c2Mu8U3kP
         uEf8G9D++/Yo1RcdjwLDJZQGkm4i2dWSw4PzXnxegTzSpDwuozbh16R2g7DXMAslHVTN
         EM3catmwTbU/C/iELg59+ciOBJUyVYR/uONXzDTmusPm8rabLP+nC0U2bvyNr6RiW41t
         t3rmkUgFVRSUrIigrlbl1juR4cf4RpuxhTzWDjB/Lb0ZR7wuTSPaEja3IdV9GEEZXAbs
         QK3qKC4d9vaNDfJnTASuNXZg4OZLh3HzHLFsVLSQbsBa3z3mfJE/cWEo6sWi8hsyDgi1
         EITA==
X-Gm-Message-State: AOAM5306r2jQ3N6S0RmpqH4JBOTiYVjiMm//kX/9G2muwv+ucuH+NPPN
        q9cPFA8ougvdjZEVreCnkFfG6WzvjQvybPHZ0ns=
X-Google-Smtp-Source: ABdhPJwIA2ommqfDJurjDZrxOv9h0V7R0Dq40OXozD6jcy0NEPGLU4HA7zRSMsxBa1m/L5xOhP6cWc1IIKoPAjG7CgQ=
X-Received: by 2002:a92:d188:: with SMTP id z8mr2525174ilz.292.1599635395503;
 Wed, 09 Sep 2020 00:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <1597661277-27862-1-git-send-email-gene.chen.richtek@gmail.com>
 <1597661277-27862-10-git-send-email-gene.chen.richtek@gmail.com>
 <20200828104053.GM1826686@dell> <CAE+NS37uFoDhWyGkw0WTu+tR+_85EwzYRqecNMG6nK6b2J=9jg@mail.gmail.com>
 <20200908114819.GO4400@dell>
In-Reply-To: <20200908114819.GO4400@dell>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Wed, 9 Sep 2020 07:09:44 +0800
Message-ID: <CAE+NS36MVA=9e0Ev73gpJ-gOcY+_aNveTr+DhquD6iqY-GKXCQ@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] mfd: mt6360: Merge different sub-devices I2C read/write
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Jones <lee.jones@linaro.org> =E6=96=BC 2020=E5=B9=B49=E6=9C=888=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:48=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, 01 Sep 2020, Gene Chen wrote:
>
> > Lee Jones <lee.jones@linaro.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=8828=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:40=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Mon, 17 Aug 2020, Gene Chen wrote:
> > >
> > > > From: Gene Chen <gene_chen@richtek.com>
> > > >
> > > > Remove unuse register definition.
> > >
> > > This should be in a separate patch.
> > >
> > > > Merge different sub-devices I2C read/write functions into one Regma=
p,
> > > > because PMIC and LDO part need CRC bits for access protection.
> > > >
> > > > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > > > ---
> > > >  drivers/mfd/Kconfig        |   1 +
> > > >  drivers/mfd/mt6360-core.c  | 260 +++++++++++++++++++++++++++++++++=
++++++------
> > > >  include/linux/mfd/mt6360.h | 240 ---------------------------------=
--------
> > > >  3 files changed, 226 insertions(+), 275 deletions(-)
> > > >  delete mode 100644 include/linux/mfd/mt6360.h
> > > >
> > > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > > index a37d7d1..0684ddc 100644
> > > > --- a/drivers/mfd/Kconfig
> > > > +++ b/drivers/mfd/Kconfig
> > > > @@ -913,6 +913,7 @@ config MFD_MT6360
> > > >       select MFD_CORE
> > > >       select REGMAP_I2C
> > > >       select REGMAP_IRQ
> > > > +     select CRC8
> > > >       depends on I2C
> > > >       help
> > > >         Say Y here to enable MT6360 PMU/PMIC/LDO functional support=
.
> > > > diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> > > > index 677c974..e995220 100644
> > > > --- a/drivers/mfd/mt6360-core.c
> > > > +++ b/drivers/mfd/mt6360-core.c
> > > > @@ -14,7 +14,53 @@
> > > >  #include <linux/regmap.h>
> > > >  #include <linux/slab.h>
> > > >
> > > > -#include <linux/mfd/mt6360.h>
> > > > +enum {
> > > > +     MT6360_SLAVE_TCPC =3D 0,
> > > > +     MT6360_SLAVE_PMIC,
> > > > +     MT6360_SLAVE_LDO,
> > > > +     MT6360_SLAVE_PMU,
> > > > +     MT6360_SLAVE_MAX,
> > > > +};
> > > > +
> > > > +struct mt6360_ddata {
> > > > +     struct i2c_client *i2c[MT6360_SLAVE_MAX];
> > > > +     struct device *dev;
> > > > +     struct regmap *regmap;
> > > > +     struct regmap_irq_chip_data *irq_data;
> > > > +     unsigned int chip_rev;
> > > > +     u8 crc8_tbl[CRC8_TABLE_SIZE];
> > > > +};
> > >
> > > This is not a new structure, right?  Where was this before?  Surely i=
t
> > > should be removed from wherever it was in the same patch that places
> > > it here?
> > >
> >
> > No, it is merge from header file to source code for unuse in other sub-=
module.
>
> So where did it come from and why don't I see the removal in this
> patch?
>

Change is in the bottom of this patch.
There is a little confuse part in "[PATCH v4 5/9] mfd: mt6360: Rename
mt6360_pmu_data by mt6360_ddata"
The "PATCH 5/9" change mt6360_pmu_data to mt6360_ddata instead of mt6360_da=
ta.
I will update PATCH v5 to fix it.

[PATCH v4 9/9]
diff --git a/include/linux/mfd/mt6360.h b/include/linux/mfd/mt6360.h
-struct mt6360_data {
-       struct i2c_client *i2c[MT6360_SLAVE_MAX];
-       struct device *dev;
-       struct regmap *regmap;
-       struct regmap_irq_chip_data *irq_data;
-       unsigned int chip_rev;
-};

[PATCH v4 5/9]
diff --git a/include/linux/mfd/mt6360.h b/include/linux/mfd/mt6360.h
-struct mt6360_pmu_data {
+struct mt6360_data {
        struct i2c_client *i2c[MT6360_SLAVE_MAX];
        struct device *dev;
        struct regmap *regmap;


> [...]
>
> > > > -static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] =
=3D {
> > > > -     MT6360_PMU_SLAVEID,
> > > > +static const u16 mt6360_slave_addrs[MT6360_SLAVE_MAX] =3D {
> > >
> > > Why are you changing the data type?
> > >
> >
> > Easy to read.
> > I think it's the same?
>
> It's an unrelated change and should not be in this patch.
>
> Please separate patches into functional changes.
>

ACK. It's not very important change. I will revert it.

> > > > +     MT6360_TCPC_SLAVEID,
> > > >       MT6360_PMIC_SLAVEID,
> > > >       MT6360_LDO_SLAVEID,
> > > > -     MT6360_TCPC_SLAVEID,
> > > > +     MT6360_PMU_SLAVEID,
> > > > +};
>
> [...]
>
> > > >  static int mt6360_probe(struct i2c_client *client)
> > > > @@ -329,9 +521,23 @@ static int mt6360_probe(struct i2c_client *cli=
ent)
> > > >               return -ENOMEM;
> > > >
> > > >       ddata->dev =3D &client->dev;
> > > > -     i2c_set_clientdata(client, ddata);
> > > >
> > > > -     ddata->regmap =3D devm_regmap_init_i2c(client, &mt6360_pmu_re=
gmap_config);
> > > > +     for (i =3D 0; i < MT6360_SLAVE_MAX - 1; i++) {
> > > > +             ddata->i2c[i] =3D devm_i2c_new_dummy_device(&client->=
dev,
> > > > +                                                       client->ada=
pter,
> > > > +                                                       mt6360_slav=
e_addrs[i]);
> > > > +             if (IS_ERR(ddata->i2c[i])) {
> > > > +                     dev_err(&client->dev,
> > > > +                             "Failed to get new dummy I2C device f=
or address 0x%x",
> > > > +                             mt6360_slave_addrs[i]);
> > > > +                     return PTR_ERR(ddata->i2c[i]);
> > >
> > > Do you have to free the new devices you just allocated?
> > >
> >
> > Usually no need to free devm_i2c_new_dummy_device,
> > Should I use kfree(ddata->i2c[i]);?
>
> You tell me.
>

I survey the upstream code e.q. drivers/mfd/tps80031.c
It' should not have to free the memory.

> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
