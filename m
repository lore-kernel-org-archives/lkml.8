Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C88DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 02:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40DA922B48
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 02:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwyof/uT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgG3C4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 22:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgG3C4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 22:56:32 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6483DC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 19:56:32 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id j9so17885482ilc.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 19:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lJV4G/ayY7v3aHr8PfR5TyW5DC7MpKrmWx1XR8lPPtk=;
        b=cwyof/uTWciGX+0+6gKr4P7jhFOYq557Gcl/xCn7CdA9w9Jyeaq8IS6iRcjwUVfWQp
         r2WV7pc3cbJ1pPIhhbMYtQKqTSOL7wiZUuCsfV9FiKJqlVSgP9iVvlRNTJL4CoqwCBqC
         Klqijp9mcf43HgmygRKAk1nWQiGcIO7Vekf7ffn2QCBf4VIpq+/I4UrKlGP3V3M5Ijo8
         9SYk05TOKWNNbLyKFpF6Jo1H4z/Zlc4bopegdjbDToI3ky4HHw1+IzlTD7bfHyQ0Ua3M
         oIh4MRRjINhNtd9tJvI+6g7JLyk/9oe51xSw0Kwxoc73akxY7GFGkeqKBE0zxWvVp4UD
         GgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lJV4G/ayY7v3aHr8PfR5TyW5DC7MpKrmWx1XR8lPPtk=;
        b=BKxvTjKTijC+r+ja6gjSgCohKs2cFt3qwcS+VXQNRQcrOg/+gAJore8bsLHLpGayls
         SDnmtMX/XOFm6+maaIKs7Gbd+l4+6X0X8JNxiKrhy7ZibQ7TRCdMKs4xHMMvkJauUohy
         Jk+yuQSxgLk7joCX+zhHERSqnbvc9zWdGKvyJfSxBJx89LzuAsAUnCtcWAN4LkO2oKwm
         IYNCaRKx8q4Ri/IA7XWLE0N+hyHq0LGuGPll4UjccXwWdUsOKKHlvsU4qM8bU5COI8zm
         OxxMal6O3yFUf66QVQktF49bdCEfMIHxfjJSi0/8LJcbEhyAGD/fOxBuv0+OUTS94gVD
         aj5Q==
X-Gm-Message-State: AOAM533Ye6lFVmZxQYRUYBnNTkLw65z+gy3Xq5Ydg+V2aDNh594UYVp5
        ywLIWtJzdaqfz+2VLWBKgrQz00a/qNNoshdRQFxPywJK
X-Google-Smtp-Source: ABdhPJzZ6zt01CbLo9OGjn/b7DoZkBMdvFsqWqE6Z4JQV3UEjUCjBo0Y6f1i/rY2tfb/TRYHGUwmajCbOIzLRR0b6LU=
X-Received: by 2002:a05:6e02:e89:: with SMTP id t9mr33987204ilj.292.1596077791714;
 Wed, 29 Jul 2020 19:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
 <1594983811-25908-10-git-send-email-gene.chen.richtek@gmail.com>
 <20200727124306.GP1850026@dell> <CAE+NS354H-j5UKa+JxHzvwinpPN9QR176ugFVt+UYyJFsOMg0w@mail.gmail.com>
 <20200729101244.GH2419169@dell>
In-Reply-To: <20200729101244.GH2419169@dell>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Thu, 30 Jul 2020 10:56:20 +0800
Message-ID: <CAE+NS37hURYnWqsewnc+T9yn62pFdSHUTqL4BvdsH_3mRf6Yrg@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] mfd: mt6360: Merge different sub-devices i2c read/write
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

Lee Jones <lee.jones@linaro.org> =E6=96=BC 2020=E5=B9=B47=E6=9C=8829=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:12=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, 29 Jul 2020, Gene Chen wrote:
>
> > Lee Jones <lee.jones@linaro.org> =E6=96=BC 2020=E5=B9=B47=E6=9C=8827=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=888:43=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Fri, 17 Jul 2020, Gene Chen wrote:
> > >
> > > > From: Gene Chen <gene_chen@richtek.com>
> > > >
> > > > Remove unuse register definition.
> > >
> > > This should not be in here.
> > >
> > > > Merge different sub-devices i2c read/write function into one regmap=
,
> > >
> > > "I2C", "functions", "Regmap".
> > >
> >
> > ACK
> >
> > > > because pmic and ldo part need crc bits for access protection.
> > >
> > > "PMIC", "LDO", "CRC".
> > >
> >
> > ACK
> >
> > > > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > > > ---
> > > >  drivers/mfd/Kconfig        |   1 +
> > > >  drivers/mfd/mt6360-core.c  | 229 +++++++++++++++++++++++++++++++++=
++++-----
> > > >  include/linux/mfd/mt6360.h | 240 ---------------------------------=
------------
> > > >  3 files changed, 204 insertions(+), 266 deletions(-)
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
> > > > index 3186a7c..97ef1ad 100644
> > > > --- a/drivers/mfd/mt6360-core.c
> > > > +++ b/drivers/mfd/mt6360-core.c
> > > > @@ -14,7 +14,46 @@
> > > >  #include <linux/interrupt.h>
> > > >  #include <linux/mfd/core.h>
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
> > > > +struct mt6360_data {
> > > > +     struct i2c_client *i2c[MT6360_SLAVE_MAX];
> > > > +     struct device *dev;
> > > > +     struct regmap *regmap;
> > > > +     struct regmap_irq_chip_data *irq_data;
> > > > +     unsigned int chip_rev;mt6360_data
> > > > +     u8 crc8_tbl[CRC8_TABLE_SIZE];
> > > > +};
> > >
> > > Make sure all of these entries are still used.
> > >
> > > > +#define MT6360_PMU_SLAVEID           0x34
> > > > +#define MT6360_PMIC_SLAVEID          0x1A
> > > > +#define MT6360_LDO_SLAVEID           0x64
> > > > +#define MT6360_TCPC_SLAVEID          0x4E
> > >
> > > Can these be placed into ID order?
> > >
> >
> > ACK
> >
> > > > +#define MT6360_REG_TCPCSTART         0x00
> > > > +#define MT6360_REG_TCPCEND           0xFF
> > > > +#define MT6360_REG_PMICSTART         0x100
> > > > +#define MT6360_REG_PMICEND           0x13B
> > > > +#define MT6360_REG_LDOSTART          0x200
> > > > +#define MT6360_REG_LDOEND            0x21C
> > > > +#define MT6360_REG_PMUSTART          0x300
> > > > +#define MT6360_PMU_DEV_INFO          0x300
> > > > +#define MT6360_PMU_CHG_IRQ1          0x3D0
> > > > +#define MT6360_PMU_CHG_MASK1         0x3F0
> > > > +#define MT6360_REG_PMUEND            0x3FF
> > > > +
> > > > +/* from 0x3D0 to 0x3DF */
> > >
> > > We don't need this in here.
> > >
> >
> > ACK
> >
> > > > +#define MT6360_PMU_IRQ_REGNUM                16
> > > > +
> > > > +#define CHIP_VEN_MASK                0xF0
> > > > +#define CHIP_VEN_MT6360              0x50
> > > > +#define CHIP_REV_MASK                0x0F
> > > >
> > > >  /* reg 0 -> 0 ~ 7 */
> > > >  #define MT6360_CHG_TREG_EVT          4
> > > > @@ -220,12 +259,6 @@ static const struct regmap_irq_chip mt6360_irq=
_chip =3D {
> > > >       .use_ack =3D true,
> > > >  };
> > > >
> > > > -static const struct regmap_config mt6360_pmu_regmap_config =3D {
> > > > -     .reg_bits =3D 8,
> > > > -     .val_bits =3D 8,
> > > > -     .max_register =3D MT6360_PMU_MAXREG,
> > > > -};
> > > > -
> > > >  static const struct resource mt6360_adc_resources[] =3D {
> > > >       DEFINE_RES_IRQ_NAMED(MT6360_ADC_DONEI, "adc_donei"),
> > > >  };
> > > > @@ -310,11 +343,153 @@ static int mt6360_check_vendor_info(struct m=
t6360_data *data)
> > > >       return 0;
> > > >  }
> > > >
> > > > -static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] =
=3D {
> > > > -     MT6360_PMU_SLAVEID,
> > > > +static const u16 mt6360_slave_addrs[MT6360_SLAVE_MAX] =3D {
> > > > +     MT6360_TCPC_SLAVEID,
> > > >       MT6360_PMIC_SLAVEID,
> > > >       MT6360_LDO_SLAVEID,
> > > > -     MT6360_TCPC_SLAVEID,
> > > > +     MT6360_PMU_SLAVEID,
> > > > +};
> > > > +
> > > > +static int mt6360_xlate_pmicldo_addr(u8 *addr, int rw_size)
> > > > +{
> > > > +     u8 flags[4] =3D { 0x00, 0x40, 0x80, 0xc0 };
> > > > +
> > > > +     if (rw_size < 1 || rw_size > 4)
> > > > +             return -EINVAL;
> > > > +
> > > > +     *addr &=3D 0x3f;
> > > > +     *addr |=3D flags[rw_size - 1];
> > > > +
> > > > +     return 0;
> > > > +}
> > >
> > > You need some comments in here to explain what's going on.
> > >
> >
> > ACK
> >
> > Is this comment readable?
> >
> > /*
> >  * When access sud-device PMIC and LDO part which only addressed
> > 0x00~0x3F, read and write action need crc for protection.
> >
> >  * Addr[5:0] is real access real register address.
> >  * Addr[7:6] use to store size, maximum 4 bytes.
> >
> >  * When received the Addr, ic can interpret real register address and s=
ize to calculate or check crc
> >  * /
>
> Don't you think this reads better?
>
> No need for comments then:
>
>  #define MT6360_ADDRESS_MASK 0x3f
>  #define MT6360_DATA_SIZE_1_BYTE  0x00
>  #define MT6360_DATA_SIZE_2_BYTES 0x40
>  #define MT6360_DATA_SIZE_3_BYTES 0x80
>  #define MT6360_DATA_SIZE_4_BYTES 0xC0
>
>  static int mt6360_xlate_pmicldo_addr(u8 *addr, int rw_size)
>  {
>         /* Address is already in encoded [5:0] */
>         *addr &=3D MT6360_ADDRESS_MASK;
>
>         /* Encode size [7:6] */
>         switch (rw_size) {
>         case 1:
>                 *addr |=3D MT6360_DATA_SIZE_1_BYTE
>                 break;
>         case 2:
>                 *addr |=3D MT6360_DATA_SIZE_2_BYTES
>                 break;
>         case 3:
>                 *addr |=3D MT6360_DATA_SIZE_3_BYTES
>                 break;
>         case 4:
>                 *addr |=3D MT6360_DATA_SIZE_4_BYTES
>                 break;
>         default:
>                 return -EINVAL;
>         }
>
>         return 0;
>  }
>

ACK. Thanks for your suggestions.

> > /*
> >  * CRC calculation
> >  * total size is 2 byte and number of access bytes
> >  * 2 bytes include i2c device address, r/w bit and address which want t=
o access
> >  * others for read or write data
> >  * /
> >
> > > > +static int mt6360_regmap_read(void *context, const void *reg, size=
_t reg_size,
> > > > +                           void *val, size_t val_size)
> > > > +{
> > > > +     struct mt6360_data *data =3D context;
> > > > +     u8 bank =3D *(u8 *)reg, reg_addr =3D *(u8 *)(reg + 1);
> > > > +     struct i2c_client *i2c =3D data->i2c[bank];
> > > > +     bool crc_needed =3D false;
> > > > +     u8 *buf;
> > > > +     /* first two is i2c_addr + reg_addr , last is crc8 */
> > > > +     int alloc_size =3D 2 + val_size + 1, read_size =3D val_size;
> > > > +     u8 crc;
> > > > +     int ret;
> > > > +
> > > > +     if (bank =3D=3D MT6360_SLAVE_PMIC || bank =3D=3D MT6360_SLAVE=
_LDO) {
> > > > +             crc_needed =3D true;
> > > > +             ret =3D mt6360_xlate_pmicldo_addr(&reg_addr, val_size=
);
> > > > +             if (ret < 0)
> > > > +                     return ret;
> > > > +             read_size +=3D 1;
> > > > +     }
> > > > +
> > > > +     buf =3D kzalloc(alloc_size, GFP_KERNEL);
> > > > +     if (!buf)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     /* 7 bit slave addr + read bit */
> > > > +     buf[0] =3D ((i2c->addr & 0x7f) << 1) + 1;
> > > > +     buf[1] =3D reg_addr;
> > > > +
> > > > +     ret =3D i2c_smbus_read_i2c_block_data(i2c, reg_addr, read_siz=
e, buf + 2);
> > > > +
> > > > +     if (ret =3D=3D read_size) {
> > > > +             memcpy(val, buf + 2, val_size);
> > > > +             if (crc_needed) {
> > > > +                     crc =3D crc8(data->crc8_tbl, buf, val_size + =
2, 0);
> > > > +                     if (crc !=3D buf[val_size + 2])
> > > > +                             ret =3D -EIO;
> > > > +             }
> > > > +     }
> > > > +
> > > > +     kfree(buf);
> > > > +
> > > > +     if (ret < 0)
> > > > +             return ret;
> > > > +     else if (ret !=3D read_size)
> > > > +             return -EIO;
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int mt6360_regmap_write(void *context, const void *val, siz=
e_t val_size)
> > > > +{
> > > > +     struct mt6360_data *data =3D context;
> > > > +     u8 bank =3D *(u8 *)val, reg_addr =3D *(u8 *)(val + 1);
> > > > +     struct i2c_client *i2c =3D data->i2c[bank];
> > > > +     bool crc_needed =3D false;
> > > > +     u8 *buf;
> > > > +     /* first two is i2c_addr + reg_addr , last crc8 + dummy */
> > > > +     int alloc_size =3D 2 + val_size + 2, write_size =3D val_size =
- 2;
> > > > +     int ret;
> > > > +
> > > > +     if (bank =3D=3D MT6360_SLAVE_PMIC || bank =3D=3D MT6360_SLAVE=
_LDO) {
> > > > +             crc_needed =3D true;
> > > > +             ret =3D mt6360_xlate_pmicldo_addr(&reg_addr, val_size=
 - 2);
> > > > +             if (ret < 0)
> > > > +                     return ret;
> > > > +     }
> > > > +
> > > > +     buf =3D kzalloc(alloc_size, GFP_KERNEL);
> > > > +     if (!buf)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     /* 7 bit slave addr + write bit */
> > > > +     buf[0] =3D ((i2c->addr & 0x7f) << 1);
> > > > +     buf[1] =3D reg_addr;
> > > > +     /* val need to minus regaddr 16bit */
> > > > +     memcpy(buf + 2, val + 2, write_size);
> > > > +
> > > > +     if (crc_needed) {
> > > > +             buf[val_size] =3D crc8(data->crc8_tbl, buf, val_size,=
 0);
> > > > +             write_size +=3D 2;
> > > > +     }
> > > > +
> > > > +     ret =3D i2c_smbus_write_i2c_block_data(i2c,
> > > > +                                          reg_addr, write_size, bu=
f + 2);
> > > > +
> > > > +     kfree(buf);
> > > > +
> > > > +     if (ret < 0)
> > > > +             return ret;
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static const struct regmap_bus mt6360_regmap_bus =3D {
> > > > +     .read           =3D mt6360_regmap_read,
> > > > +     .write          =3D mt6360_regmap_write,
> > > > +
> > > > +     /* due to pmic and ldo crc access size limit */
> > > > +     .max_raw_read   =3D 4,
> > > > +     .max_raw_write  =3D 4,
> > > > +};
> > >
> > > Why isn't all of the above in a Regmap driver?
> > >
> >
> > Do you means split out like drivers/base/regmap/regmap-ac97.c?
>
> Yes, I do.
>
> [...]
>

ACK

> > > > +     i2c_set_clientdata(client, data);
> > >
> > > Where is this used?
> >
> > I can use device to get chip_rev from dev_get_drvdata.
> > According to different chip_rev, I may need apply different way to do.
> >
> > > Didn't you just move the definition into this file?
> >
> > ACK, I will seperate move definition into this file to new patch
>
> That's not the point I'm making.
>
> You can't use 'data' outside of this file, so why are you setting it
> inside the clientdata area?
>

I see. It's my logical defect
I will remove set clientdata.

> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
