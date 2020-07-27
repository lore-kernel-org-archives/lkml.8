Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D433C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 115102070A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iq4q/uAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgG1C2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 22:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgG1C2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 22:28:47 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B24EC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 19:28:47 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id s21so14893139ilk.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 19:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X81wKNuIN/ZBgNP01q1lrp0XDb3zK0TgXb0/3enbG4E=;
        b=Iq4q/uAaaDFkDFJLGD5NrMQMX3PCt6qe6l9b/3p4udFexbBIOpyOdQGnKowNmd9NGe
         JYOD9gV20hNjhE3+pvKP8ttNKhKZbDhE/IRlUbPz45F2qT8JflGxdO4vAnTjTxj2R+ra
         wAu8h7vIehJPG17+zKn2uj2ajEa75hYZv1A4+RvYYzDys/+NZz4BSp5mGbMnDvhhfoQe
         1ki1EQcbyal983V0gHpZVTWSGiCPfUXCWqRqbfvoIobWiRv44kSw33psx/RAnukmTa7N
         Qysm6luz3Vb9xSjjP1NmqtoxjazUrUu/sc5h5tS0+77Io/q8RmCnSC1cujDVc9ZECnUl
         cmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X81wKNuIN/ZBgNP01q1lrp0XDb3zK0TgXb0/3enbG4E=;
        b=aD12j7Sfw+sVJZfTcbBLNiJIUA8lpA7iGn1u55u6cH1Dx1XqbmxTXCo4+uU4kezJGD
         agPNOV8mF7fi3Rg4kZ1K8zDBexinqQAjgN82XPf4BpYgyKB87Odezgoa8ycXlL8cYePI
         OWk2XZnOwqKc+qy/V8lnxRBybErwS6juaYjIRvmy1ct+qEgeb/sAIgeNrCXuZqhteuzo
         ZJyKZ+vw0XzDZl8SES6CNJkwDtMfApHqDIs0awT4050eFNDw9BueaZ0AqK4CgZ+R9Ab5
         HCmwEnUv2TjL+EURrflh5AcrRDalMLnu4Mah9c9oMRM4KhgD6tjO3/Smy7dxqAlWnPS3
         J4Rg==
X-Gm-Message-State: AOAM533nHtk1YPovCLWUgBAFGqnQ8Nzwtbr4imfxE65ml1LU5Qp+hvE0
        dWmfcpfyLfuyQKmSha6D8gMmuJE1ckuZJMAH6PU=
X-Google-Smtp-Source: ABdhPJzyKdyXWVAX9P7Mf/nv1KVhHyZI+2eMBipAvoOzXxrE76PZ1ClBhDf1EO76moVzQz4JrEMxm7qkX2iNE66y7cg=
X-Received: by 2002:a92:9f96:: with SMTP id z22mr27519152ilk.266.1595903326578;
 Mon, 27 Jul 2020 19:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
 <1594983811-25908-5-git-send-email-gene.chen.richtek@gmail.com> <20200727112921.GK1850026@dell>
In-Reply-To: <20200727112921.GK1850026@dell>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Tue, 28 Jul 2020 02:28:32 +0800
Message-ID: <CAE+NS36cxY9KqxxcmuctK_W_3ZmZnC_xK8VVVaTZqC3vSoqbUw@mail.gmail.com>
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

Lee Jones <lee.jones@linaro.org> =E6=96=BC 2020=E5=B9=B47=E6=9C=8827=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:29=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, 17 Jul 2020, Gene Chen wrote:
>
> > From: Gene Chen <gene_chen@richtek.com>
> >
> > Combine mt6360 pmic/ldo resouces into mt6360 regulator resources
> > to simplify the similar resources object.
>
> Do the sub-devices actually share these resources, or are you doing
> this just to make the code simpler?
>

They are different resources used by different bucks and ldos without
sharing relations.
I just to make the code simpler.

> > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > ---
> >  drivers/mfd/mt6360-core.c | 11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> > index 7cc1b59..665e26f 100644
> > --- a/drivers/mfd/mt6360-core.c
> > +++ b/drivers/mfd/mt6360-core.c
> > @@ -265,7 +265,7 @@ static const struct resource mt6360_led_resources[]=
 =3D {
> >       DEFINE_RES_IRQ_NAMED(MT6360_FLED1_STRB_TO_EVT, "fled1_strb_to_evt=
"),
> >  };
> >
> > -static const struct resource mt6360_pmic_resources[] =3D {
> > +static const struct resource mt6360_regulator_resources[] =3D {
> >       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_PGB_EVT, "buck1_pgb_evt"),
> >       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OC_EVT, "buck1_oc_evt"),
> >       DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OV_EVT, "buck1_ov_evt"),
> > @@ -278,9 +278,6 @@ static const struct resource mt6360_pmic_resources[=
] =3D {
> >       DEFINE_RES_IRQ_NAMED(MT6360_LDO7_OC_EVT, "ldo7_oc_evt"),
> >       DEFINE_RES_IRQ_NAMED(MT6360_LDO6_PGB_EVT, "ldo6_pgb_evt"),
> >       DEFINE_RES_IRQ_NAMED(MT6360_LDO7_PGB_EVT, "ldo7_pgb_evt"),
> > -};
> > -
> > -static const struct resource mt6360_ldo_resources[] =3D {
> >       DEFINE_RES_IRQ_NAMED(MT6360_LDO1_OC_EVT, "ldo1_oc_evt"),
> >       DEFINE_RES_IRQ_NAMED(MT6360_LDO2_OC_EVT, "ldo2_oc_evt"),
> >       DEFINE_RES_IRQ_NAMED(MT6360_LDO3_OC_EVT, "ldo3_oc_evt"),
> > @@ -298,10 +295,8 @@ static const struct mfd_cell mt6360_devs[] =3D {
> >                   NULL, 0, 0, "mediatek,mt6360-chg"),
> >       OF_MFD_CELL("mt6360-led", mt6360_led_resources,
> >                   NULL, 0, 0, "mediatek,mt6360-led"),
> > -     OF_MFD_CELL("mt6360-pmic", mt6360_pmic_resources,
> > -                 NULL, 0, 0, "mediatek,mt6360-pmic"),
> > -     OF_MFD_CELL("mt6360-ldo", mt6360_ldo_resources,
> > -                 NULL, 0, 0, "mediatek,mt6360-ldo"),
> > +     OF_MFD_CELL("mt6360-regulator", mt6360_regulator_resources,
> > +                 NULL, 0, 0, "mediatek,mt6360-regulator"),
> >       OF_MFD_CELL("mt6360-tcpc", NULL,
> >                   NULL, 0, 0, "mediatek,mt6360-tcpc"),
> >  };
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
