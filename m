Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4460CC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 09:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1409520775
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 09:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gb1zTsF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgGPJxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 05:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgGPJxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 05:53:48 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A18FC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 02:53:48 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id l17so5348308iok.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 02:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+x0RURjDsb6r2gazasWw0snGZpzKhvm0nC6pQGgI0Is=;
        b=Gb1zTsF12JWdG85+D5/yO7b7v1H0ENSfY/qywxTruBppe7aQcsXMRKHYb4N+aBeMui
         yJBoiSi+LAuTUJpA0LVkMW44oLxuRm6frqvAURwtRY/FsEoij0vDo/pX1Js5lCbbuXIT
         yf5DdFGbUxmYRBs4jNLU+IwoWjRLFH8MPBkJ2UIlSRv+0RxjL+lva3GJoUZKRLNamhhU
         j5hBzLXUZqQH1HAZEiUFUZDgtcl+SE/wBOWvclTPFsp7nUIevbigsoKct8m5v0FuFAKL
         B9CCDuIdPd/TKmCaVHQRMX+f1eMP7zrOgoGP5Qx6/CMx74aySIqWfARTcqww2yTgO67M
         +nJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+x0RURjDsb6r2gazasWw0snGZpzKhvm0nC6pQGgI0Is=;
        b=mxhecEDfgHXFSFdh7D+zlAasl4v6uIsydgxkbSx4HJHfMLz/QQUfBu8X/1kKKWBa8M
         fGFOForKORi7DJtFOlPRVSBRAL2P8KCGoTZRHi4DHh/aaIJE0CnjxYlIHBa+GVwElOWT
         kTKyrknus92K08nhGKeQ7Ln2v/Vk9RwCKfcrB8Md5hykz1NvqMIVSefpKryfVwAUIHH7
         Im3BzB3mSkT1f+jixXUYw8lrPDrAVAB0FuXcv7iexhX3fEuxtK6b2J08uY9ky9MARoHS
         KjYwmw7+l6Hc62kiXcQqQyJWTsslN0qU50E3jk9J4d3+mLmi3oFPd2KHRMghPaEAhad5
         VFXA==
X-Gm-Message-State: AOAM533ImM88Ukbxj6S4+MsxiYUYZBwHD7QopWCvQ6h8t3Ow2LixTtan
        CP8vtKdb4PKxwIdkoOqKaqBi7Px47bCAGGWAJFM=
X-Google-Smtp-Source: ABdhPJxgaqlVL9z0xbOCPaV1IajyUWWKOmB+QsBAeF5HXryQlDNC6lZkU9CaVx+4BEf1/DlbTF2Vk7Nc07pLpnWeCYg=
X-Received: by 2002:a02:30ca:: with SMTP id q193mr4259586jaq.125.1594893227833;
 Thu, 16 Jul 2020 02:53:47 -0700 (PDT)
MIME-Version: 1.0
References: <1594117856-14343-1-git-send-email-gene.chen.richtek@gmail.com>
 <1594117856-14343-4-git-send-email-gene.chen.richtek@gmail.com> <3205bb9b-c7b4-c99a-2673-f3a56cc0addf@gmail.com>
In-Reply-To: <3205bb9b-c7b4-c99a-2673-f3a56cc0addf@gmail.com>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Thu, 16 Jul 2020 17:53:36 +0800
Message-ID: <CAE+NS36LOqnG+toSQcxVAeQHUqyvs9Z39tU7-ijkAntRUH6uqg@mail.gmail.com>
Subject: Re: [PATCH 3/4] mfd: mt6360: Fix flow which is used to check ic exist
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>, shufan_lee@richtek.com,
        cy_huang@richtek.com, benjamin.chao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Brugger <matthias.bgg@gmail.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=88=
10=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8810:25=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
>
>
> On 07/07/2020 12:30, Gene Chen wrote:
> > From: Gene Chen <gene_chen@richtek.com>
> >
> > Fix flow which is used to check ic exist
> >
> > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > ---
> >   drivers/mfd/mt6360-core.c  | 28 +++++++++++++++++++---------
> >   include/linux/mfd/mt6360.h |  8 ++++----
> >   2 files changed, 23 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> > index 2dd5918..4bb2949 100644
> > --- a/drivers/mfd/mt6360-core.c
> > +++ b/drivers/mfd/mt6360-core.c
> > @@ -293,6 +293,23 @@ static const struct mfd_cell mt6360_devs[] =3D {
> >                   NULL, 0, 0, "mediatek,mt6360-tcpc"),
> >   };
> >
> > +static int mt6360_check_vendor_info(struct mt6360_data *data)
> > +{
> > +     u32 info;
> > +     int ret;
> > +
> > +     ret =3D regmap_read(data->regmap, MT6360_REG_PMU_DEVINFO, &info);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     if ((info & MT6360_CHIPVEN_MASK) !=3D MT6360_CHIPVEN_VAL)
> > +             return -ENODEV;
> > +
> > +     data->chip_rev =3D info & MT6360_CHIPREV_MASK;
> > +
> > +     return 0;
> > +}
> > +
> >   static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] =3D {
> >       MT6360_PMU_SLAVEID,
> >       MT6360_PMIC_SLAVEID,
> > @@ -303,7 +320,6 @@ static const unsigned short mt6360_slave_addr[MT636=
0_SLAVE_MAX] =3D {
> >   static int mt6360_probe(struct i2c_client *client)
> >   {
> >       struct mt6360_data *data;
> > -     unsigned int reg_data;
> >       int i, ret;
> >
> >       data =3D devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
> > @@ -319,16 +335,10 @@ static int mt6360_probe(struct i2c_client *client=
)
> >               return PTR_ERR(data->regmap);
> >       }
> >
> > -     ret =3D regmap_read(data->regmap, MT6360_PMU_DEV_INFO, &reg_data)=
;
> > +     ret =3D mt6360_check_vendor_info(data);
> >       if (ret) {
> > -             dev_err(&client->dev, "Device not found\n");
> > -             return ret;
> > -     }
> > -
> > -     data->chip_rev =3D reg_data & CHIP_REV_MASK;
> > -     if (data->chip_rev !=3D CHIP_VEN_MT6360) {
>
> Why not only applying the MASK here instead of put this all in a new func=
tion?
>

I think merge the ic check flow into function is well-organized.
if not, i can restore the same as before.

> >               dev_err(&client->dev, "Device not supported\n");
> > -             return -ENODEV;
> > +             return ret;
> >       }
> >
> >       ret =3D devm_regmap_add_irq_chip(&client->dev, data->regmap, clie=
nt->irq,
> > diff --git a/include/linux/mfd/mt6360.h b/include/linux/mfd/mt6360.h
> > index 9fc6718..5ec0f5d 100644
> > --- a/include/linux/mfd/mt6360.h
> > +++ b/include/linux/mfd/mt6360.h
> > @@ -30,7 +30,7 @@ struct mt6360_data {
> >   };
> >
> >   /* PMU register defininition */
> > -#define MT6360_PMU_DEV_INFO                  (0x00)
> > +#define MT6360_REG_PMU_DEVINFO                       (0x00)
> >   #define MT6360_PMU_CORE_CTRL1                       (0x01)
> >   #define MT6360_PMU_RST1                             (0x02)
> >   #define MT6360_PMU_CRCEN                    (0x03)
> > @@ -233,8 +233,8 @@ struct mt6360_data {
> >   #define MT6360_IRQ_REGNUM   16
> >   #define MT6360_IRQ_RETRIG   BIT(2)
> >
> > -#define CHIP_VEN_MASK                                (0xF0)
> > -#define CHIP_VEN_MT6360                              (0x50)
> > -#define CHIP_REV_MASK                                (0x0F)
> > +#define MT6360_CHIPVEN_MASK                  (0xF0)
> > +#define MT6360_CHIPVEN_VAL                   (0x50)
> > +#define MT6360_CHIPREV_MASK                  (0x0F)
>
> Same here as in the other patches. Don't just rename defines if there is =
no good
> reason.
>

Is easy to read a good reason to rename it?
if not, i can restore the same as before.

> Regards,
> Matthias
>
> >
> >   #endif /* __MT6360_H__ */
> >
