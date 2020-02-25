Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C086CC35DF0
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 02:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C5F24650
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 02:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOghHRtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgBYCxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 21:53:06 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43573 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbgBYCxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 21:53:05 -0500
Received: by mail-qk1-f195.google.com with SMTP id p7so10667900qkh.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 18:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l/bd6Mw5UBXhKzo1wTzbT84L4xVj8bH26ZgdQxsHA0s=;
        b=nOghHRtCf7Alr2k3I+9cnFeSzq6fln62uR/3O+T0Z4lJ8N0bAWFtm8gA7x6e3lA4vn
         GhUDueFRrxRSDBTo47Z4dCf3z8RHpfC6NFbe2rhp/WpxRSShbcZnugkVepqyqLFpDbth
         mx6eXP4dwAPhFAAvp4R9RnSWP+a+1y3GR9gptFExNct0llaxfiX3ol0b94MeNdnmb4Wr
         LXBJPKAbzU3IJUuUiD1RnARmBwr52XpVU8uLKZOL8FqmLAAmnjxaaPj1SQFBW6ePyQez
         1ZgHKTIx4aVtYP3sWuHRooirMPOo24RE2eIdaaK4fsRfIihBPkI2FizDm+H+s+wvOixo
         lYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l/bd6Mw5UBXhKzo1wTzbT84L4xVj8bH26ZgdQxsHA0s=;
        b=V0van1PD89UC4o9IcTxOXMJmVM+eDqGI+/cwLASIo2id8AdA7cFk2FobXhLx+UiNX/
         T1VvNgHnsxKj00U4DAUiiFwXGCS4hv8l6ZuR8pEh5S/QvBB7ImHcCy5OfAUM4t67YfE7
         2IEMDCBmm/EAclmujzyU/4ye8rlgZDBDojNbymNL4IjKUX0efKcTuUShongNDsjahy1R
         ru8zHLnYYr6AtOM27Vemj59DOMfitTQjHzwESNok90R9ddbxl6vKK+eIdAke8mY6wpuh
         Z72UBQHTw6C+Ise2BExkK9mL/BaVeReUP5J8PzyVHOjVNm8qtsNqH8+3avzIWs9YdV63
         eSLg==
X-Gm-Message-State: APjAAAU1JKGzr+QOM2xPCkWqYEHrwdUAsdTIu4qdpZlKEiMuNjMf5gA3
        GGRwzkledFkgnlnE8UmZkWMY+f5JvRdleKo1ToE=
X-Google-Smtp-Source: APXvYqxYVtB7+Pjjz9SvFKGPOWH6dgrGMwRsxyD3WTrbpxTJyypul19d4364K8lBMYnsJ8wtp/Bb9pVmcKSpuESQq0A=
X-Received: by 2002:a37:8e03:: with SMTP id q3mr52989468qkd.395.1582599184955;
 Mon, 24 Feb 2020 18:53:04 -0800 (PST)
MIME-Version: 1.0
References: <049eb16cf995d3a2dd0de01f4c0ed09965e36f92.1581906151.git.baolin.wang7@gmail.com>
 <20200224113926.GU3494@dell>
In-Reply-To: <20200224113926.GU3494@dell>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 25 Feb 2020 10:52:53 +0800
Message-ID: <CADBw62ry=+2Rm-Xnar-oeGe_JipvZ9zw=stT7vMHd+QR_m-JEw@mail.gmail.com>
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

Hi Lee,

On Mon, Feb 24, 2020 at 7:38 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Mon, 17 Feb 2020, Baolin Wang wrote:
>
> > The Spreadtrum SC27XX series PMICs supply the USB charger type detection
> > function, and related registers are located on the PMIC global registers
> > region, thus we implement and export this function in the MFD driver for
> > users to get the USB charger type.
> >
> > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > ---
> >  drivers/mfd/sprd-sc27xx-spi.c   |   52 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/sc27xx-pmic.h |    7 ++++++
> >  2 files changed, 59 insertions(+)
> >  create mode 100644 include/linux/mfd/sc27xx-pmic.h
>
> [...]
>
> > +enum usb_charger_type sprd_pmic_detect_charger_type(struct device *dev)
> > +{
> > +     struct spi_device *spi = to_spi_device(dev);
> > +     struct sprd_pmic *ddata = spi_get_drvdata(spi);
> > +     const struct sprd_pmic_data *pdata = ddata->pdata;
> > +     enum usb_charger_type type;
> > +     u32 val;
> > +     int ret;
> > +
> > +     ret = regmap_read_poll_timeout(ddata->regmap, pdata->charger_det, val,
> > +                                    (val & SPRD_PMIC_CHG_DET_DONE),
> > +                                    SPRD_PMIC_CHG_DET_DELAY_US,
> > +                                    SPRD_PMIC_CHG_DET_TIMEOUT);
> > +     if (ret) {
> > +             dev_err(&spi->dev, "failed to detect charger type\n");
> > +             return UNKNOWN_TYPE;
> > +     }
> > +
> > +     switch (val & SPRD_PMIC_CHG_TYPE_MASK) {
> > +     case SPRD_PMIC_CDP_TYPE:
> > +             type = CDP_TYPE;
> > +             break;
> > +     case SPRD_PMIC_DCP_TYPE:
> > +             type = DCP_TYPE;
> > +             break;
> > +     case SPRD_PMIC_SDP_TYPE:
> > +             type = SDP_TYPE;
> > +             break;
> > +     default:
> > +             type = UNKNOWN_TYPE;
> > +             break;
> > +     }
> > +
> > +     return type;
> > +}
> > +EXPORT_SYMBOL_GPL(sprd_pmic_detect_charger_type);
>
> Where is this called from?

Our USB phy driver will call this API to get the charger type, which
is used to notify the corresponding current can be drawn to charger
drivers. And we will introduce users after this patch getting applied.

> Why isn't the charger type detected in the charger driver?

The charger type detection operation is not a part of charger, and its
related registers are located on the PMIC global registers area. So I
think the PMIC driver is the right place to implement. Moreover Arnd
also suggested us to implement these APIs in the PMIC driver if I
remember correctly.
