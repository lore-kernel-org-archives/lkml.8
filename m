Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3248FC35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22A721556
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEiHhc8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbgBYJ17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 04:27:59 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36288 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgBYJ17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 04:27:59 -0500
Received: by mail-qk1-f194.google.com with SMTP id f3so8406308qkh.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 01:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QRG2PghZrwb3dGb8lOhFhJFv2KKsjZVPjqM/nt46UBo=;
        b=eEiHhc8zl+0ReOz3L4SnCrVCAPsNFhLZNgOYYCTUF3H7R2nOREFcrhlYgNK4hJ7tSi
         gbMRkfLUI124Jp8oQMe27+w40fGnhGRXhHNtfKU/a433Sn86jV9ALpncejsMDSBobdZA
         4hqMEBQzIMpA8DWiyTWkgVAqnhQ8FqBig8SoIEjM/wBQLff70IhnvYh3zyOE/G2Zhapu
         hjyjkH7zuoTYYLFvcW2dpYp+Z3vT2QdbNVGbldwPQoaIKFaYqh/OqW+n3WKWTMf5Rtib
         O9ncXNkBZ461X68Y+VHRK+/Jz2auGi6c3coI83bOBpXOrUWopsyAdnS4shOIY1/JXQt8
         Q11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QRG2PghZrwb3dGb8lOhFhJFv2KKsjZVPjqM/nt46UBo=;
        b=Fg6hDqdwSQvyF0Ee0FTBPoXD2NGBbtxCmVhTCw92o34Xp38BOpcrK6nSo2tx6Jdk5v
         bxZvlRscOC+wjIKu/boKFWUzuD9rOtx4uHZgLT50N0mSH1rP+RkhKeZXIAHMq0Nvv4Pm
         Fmx7g0yB91KAHkPthAjJFfeu46wFpB0FG5KD+Bhihpqq4ob8vdL09lTuA8sZzxh4dA6U
         kQi39Z+RNAv7dHdxFw8g39wqkqyGTn8PH3tuCroNf5M4T+CanPh+8IiJtYiC8A0CvX8x
         2beRPI7roWW6W/SS/f3SOazHXWUIzHfI5sLQk5JXkh96XV5dHszAiTQxsqcXidA5F36Z
         wSoQ==
X-Gm-Message-State: APjAAAVgqThKZsEV4CYvc57x7e4+zLZlpcyEUlUxHVQLKGfdcSBuTsD7
        rGPYawDsVwpm6iaRfbIBvdwpjhgaeUSHbru1g0I=
X-Google-Smtp-Source: APXvYqzfnkLrsgnE4o/fUMMr+Xp6jXqCXeBDwC5BD9xGrb0+Bm1xIyCOj36WWdEyE25dUOW8IwwgEhnAWs1byFWXaUY=
X-Received: by 2002:a05:620a:1353:: with SMTP id c19mr31005517qkl.114.1582622877710;
 Tue, 25 Feb 2020 01:27:57 -0800 (PST)
MIME-Version: 1.0
References: <049eb16cf995d3a2dd0de01f4c0ed09965e36f92.1581906151.git.baolin.wang7@gmail.com>
 <20200224113926.GU3494@dell> <CADBw62ry=+2Rm-Xnar-oeGe_JipvZ9zw=stT7vMHd+QR_m-JEw@mail.gmail.com>
 <20200225085012.GW3494@dell>
In-Reply-To: <20200225085012.GW3494@dell>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 25 Feb 2020 17:27:45 +0800
Message-ID: <CADBw62q3wF_h83x3SwcX059N5EvMzm0mjVue+8vxn4Nbq0_Xng@mail.gmail.com>
Subject: Re: [RESEND PATCH] mfd: sc27xx: Add USB charger type detection support
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 4:49 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Tue, 25 Feb 2020, Baolin Wang wrote:
>
> > Hi Lee,
> >
> > On Mon, Feb 24, 2020 at 7:38 PM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > On Mon, 17 Feb 2020, Baolin Wang wrote:
> > >
> > > > The Spreadtrum SC27XX series PMICs supply the USB charger type detection
> > > > function, and related registers are located on the PMIC global registers
> > > > region, thus we implement and export this function in the MFD driver for
> > > > users to get the USB charger type.
> > > >
> > > > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > > > ---
> > > >  drivers/mfd/sprd-sc27xx-spi.c   |   52 +++++++++++++++++++++++++++++++++++++++
> > > >  include/linux/mfd/sc27xx-pmic.h |    7 ++++++
> > > >  2 files changed, 59 insertions(+)
> > > >  create mode 100644 include/linux/mfd/sc27xx-pmic.h
> > >
> > > [...]
> > >
> > > > +enum usb_charger_type sprd_pmic_detect_charger_type(struct device *dev)
> > > > +{
> > > > +     struct spi_device *spi = to_spi_device(dev);
> > > > +     struct sprd_pmic *ddata = spi_get_drvdata(spi);
> > > > +     const struct sprd_pmic_data *pdata = ddata->pdata;
> > > > +     enum usb_charger_type type;
> > > > +     u32 val;
> > > > +     int ret;
> > > > +
> > > > +     ret = regmap_read_poll_timeout(ddata->regmap, pdata->charger_det, val,
> > > > +                                    (val & SPRD_PMIC_CHG_DET_DONE),
> > > > +                                    SPRD_PMIC_CHG_DET_DELAY_US,
> > > > +                                    SPRD_PMIC_CHG_DET_TIMEOUT);
> > > > +     if (ret) {
> > > > +             dev_err(&spi->dev, "failed to detect charger type\n");
> > > > +             return UNKNOWN_TYPE;
> > > > +     }
> > > > +
> > > > +     switch (val & SPRD_PMIC_CHG_TYPE_MASK) {
> > > > +     case SPRD_PMIC_CDP_TYPE:
> > > > +             type = CDP_TYPE;
> > > > +             break;
> > > > +     case SPRD_PMIC_DCP_TYPE:
> > > > +             type = DCP_TYPE;
> > > > +             break;
> > > > +     case SPRD_PMIC_SDP_TYPE:
> > > > +             type = SDP_TYPE;
> > > > +             break;
> > > > +     default:
> > > > +             type = UNKNOWN_TYPE;
> > > > +             break;
> > > > +     }
> > > > +
> > > > +     return type;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(sprd_pmic_detect_charger_type);
> > >
> > > Where is this called from?
> >
> > Our USB phy driver will call this API to get the charger type, which
> > is used to notify the corresponding current can be drawn to charger
> > drivers. And we will introduce users after this patch getting applied.
> >
> > > Why isn't the charger type detected in the charger driver?
> >
> > The charger type detection operation is not a part of charger, and its
> > related registers are located on the PMIC global registers area. So I
> > think the PMIC driver is the right place to implement. Moreover Arnd
> > also suggested us to implement these APIs in the PMIC driver if I
> > remember correctly.
>
> You shouldn't think of this as a PMIC driver.  This is a device's
> parent were functional drivers are allocated and registered.  Any

Right.

> useful functionality should be farmed out to the child devices which
> are to be appropriately dispersed and located into the subsystems.
>
> It looks like the charger has access to the same register map as this
> parent driver.  I do not see any compelling reason to provide charger
> specific functionality in the parent driver at this point.

Actually the charger detection is not belonging to the charger
subsystem, at least in the hardware design level. The charger
detection's theory is detetcing the USB phy D+/D- line to get the
charger type, then the hardware will save the charger type into the
PMIC global reigsters automatically for users to get. So this is not
related with the charger driver, which only supplies charging
services, and this is also not belonging to the USB phy, since the
related registers are located on the PMIC gloabl registers area. So
you still think we should not provide this funcion here?
