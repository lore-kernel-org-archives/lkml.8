Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027D7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 10:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C33AB20838
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 10:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rli980ko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732607AbgGaK6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 06:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729141AbgGaK6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 06:58:34 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C6EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 03:58:33 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id e64so31222861iof.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 03:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=atvDp6J9S9UphQS2KC0AkwktCLxJNBc+ILJ3smYnHdU=;
        b=rli980koGd1kgmFsVlyqWdra6dMO4bC6Yi4MNRh/aFjXRN3u6MB4SVjncpEbbnQF/H
         pjELWlbAvBZ48IThZhDem+4gL6v1C4AneETr/pWXAem2wofMVuJwW5zr5UDwLrh7brJE
         ymiOBKCj0SoVI5Tbav8PcOzOd2z3c3TgNRA3PMTdgEq/FFCqEprvwlmUoUfaI8dgCKxd
         2MgMe81U/1R3EHnW1ZX1azw7Y3/S3Iq/e69QWRVeuyg+4xKNrltzzf7ppYnEDgQ4PN6F
         2fHI2eh5NdmGxNibPHYEdUfogGvy9mVXpJl7q7MA9/whIEerId3Hbegl/oO9hzBP8EOU
         /C3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=atvDp6J9S9UphQS2KC0AkwktCLxJNBc+ILJ3smYnHdU=;
        b=MdD53mbeYOqfPeYYTjCL5Ij18Kw/hshogatUz26oPC36J96xijjFoVBewmn9dToF7m
         JRtSRpnoB7VF1JjImLdPxpRevOXGZGdQ0jUwKbcyfaY6pfUbzHkv4Frev4UlL4A8p8p2
         0Ntm1sBTb2oK5It8bi9SoyF7FU3jVB7twV66fJvSNNYlFv6LlYHDxeOn5/ppRmMagEzo
         kd6d+SaV9u+mHY0EnMVUMWRb5WHDESZCpL3TVfnsvan96XUHW5eYn8+lZxWSPqmzCAfg
         M888XEN8Afrqu8MqkrKNIOdglEsyyedHNvBB5Kqi5rjQV9gwmp/OOoID9WnTeLi7/1WS
         qIVg==
X-Gm-Message-State: AOAM532hhBcAdWvbxDjfmhia9l6BRkCePqlvgA+jWppHU3vA8276V8Fz
        JI046PG0Kv9mNFJXciR1nGc+13y1dmiF8yFe1DE=
X-Google-Smtp-Source: ABdhPJw3IUJGVTABwss1bI3N0AsfeVswdlGTGp6kTwD01l5sJFonpgH2ry/SoQ8R0bi1Z2nP/8iAoO4Oy0c24W0+u90=
X-Received: by 2002:a5e:d519:: with SMTP id e25mr3084419iom.36.1596193113186;
 Fri, 31 Jul 2020 03:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
 <1594983811-25908-5-git-send-email-gene.chen.richtek@gmail.com>
 <20200727112921.GK1850026@dell> <CAE+NS36cxY9KqxxcmuctK_W_3ZmZnC_xK8VVVaTZqC3vSoqbUw@mail.gmail.com>
 <20200728065422.GB1850026@dell>
In-Reply-To: <20200728065422.GB1850026@dell>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Fri, 31 Jul 2020 10:58:21 +0800
Message-ID: <CAE+NS34OFVf36zp7Nn0ETZ5KEaTet-P_VdPMuiZgqo1HfNxeYA@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] mfd: mt6360: Combine mt6360 pmic/ldo resouces into
 mt6360 regulator resources
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

Lee Jones <lee.jones@linaro.org> =E6=96=BC 2020=E5=B9=B47=E6=9C=8828=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=882:54=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, 28 Jul 2020, Gene Chen wrote:
>
> > Lee Jones <lee.jones@linaro.org> =E6=96=BC 2020=E5=B9=B47=E6=9C=8827=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:29=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Fri, 17 Jul 2020, Gene Chen wrote:
> > >
> > > > From: Gene Chen <gene_chen@richtek.com>
> > > >
> > > > Combine mt6360 pmic/ldo resouces into mt6360 regulator resources
> > > > to simplify the similar resources object.
> > >
> > > Do the sub-devices actually share these resources, or are you doing
> > > this just to make the code simpler?
> > >
> >
> > They are different resources used by different bucks and ldos without
> > sharing relations.
> > I just to make the code simpler.
>
> I don't think that's sensible.
>
> You should only share resources with child devices that consume them.
>

At first, I separated regulators into two drivers, mt6360-pmic.c and
mt6360-ldo.c, according to default-on power or not.
Then, I merged two drivers into mt6360-regulator.c and merged their
resources as well.
Therefore, for every device of BUCK/LDO, I'll find resources according
to their name and request IRQs.

> > > > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > > > ---
> > > >  drivers/mfd/mt6360-core.c | 11 +++--------
> > > >  1 file changed, 3 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> > > > index 7cc1b59..665e26f 100644
> > > > --- a/drivers/mfd/mt6360-core.c
> > > > +++ b/drivers/mfd/mt6360-core.c
> > > > @@ -265,7 +265,7 @@ static const struct resource mt6360_led_resourc=
es[] =3D {
> > > >       DEFINE_RES_IRQ_NAMED(MT6360_FLED1_STRB_TO_EVT, "fled1_strb_to=
_evt"),
> > > >  };
> > > >
> > > > -static const struct resource mt6360_pmic_resources[] =3D {
> > > > +static const struct resource mt6360_regulator_resources[] =3D {
> > > >       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_PGB_EVT, "buck1_pgb_evt"),
> > > >       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OC_EVT, "buck1_oc_evt"),
> > > >       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OV_EVT, "buck1_ov_evt"),
> > > > @@ -278,9 +278,6 @@ static const struct resource mt6360_pmic_resour=
ces[] =3D {
> > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO7_OC_EVT, "ldo7_oc_evt"),
> > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO6_PGB_EVT, "ldo6_pgb_evt"),
> > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO7_PGB_EVT, "ldo7_pgb_evt"),
> > > > -};
> > > > -
> > > > -static const struct resource mt6360_ldo_resources[] =3D {
> > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO1_OC_EVT, "ldo1_oc_evt"),
> > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO2_OC_EVT, "ldo2_oc_evt"),
> > > >       DEFINE_RES_IRQ_NAMED(MT6360_LDO3_OC_EVT, "ldo3_oc_evt"),
> > > > @@ -298,10 +295,8 @@ static const struct mfd_cell mt6360_devs[] =3D=
 {
> > > >                   NULL, 0, 0, "mediatek,mt6360-chg"),
> > > >       OF_MFD_CELL("mt6360-led", mt6360_led_resources,
> > > >                   NULL, 0, 0, "mediatek,mt6360-led"),
> > > > -     OF_MFD_CELL("mt6360-pmic", mt6360_pmic_resources,
> > > > -                 NULL, 0, 0, "mediatek,mt6360-pmic"),
> > > > -     OF_MFD_CELL("mt6360-ldo", mt6360_ldo_resources,
> > > > -                 NULL, 0, 0, "mediatek,mt6360-ldo"),
> > > > +     OF_MFD_CELL("mt6360-regulator", mt6360_regulator_resources,
> > > > +                 NULL, 0, 0, "mediatek,mt6360-regulator"),
> > > >       OF_MFD_CELL("mt6360-tcpc", NULL,
> > > >                   NULL, 0, 0, "mediatek,mt6360-tcpc"),
> > > >  };
> > >
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
