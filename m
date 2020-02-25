Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB69C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326DB21556
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EPUIycS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgBYItn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 03:49:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38315 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbgBYItn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 03:49:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id e8so13671579wrm.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 00:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cnofqUXRGJIN4pxgWdVN1/yaAjfW7JomRgm1+ntQ8Xw=;
        b=EPUIycS8dIQcn0+d2qhh474RooYVtU6/d7a/56OKgbnyb/hTHvFZli8OgwvSJLKS23
         Y57gA9Fe9lX4HdDk9iGNF8BBmrLiPQNOFG72YK48jSu3HjFkVqSwb1ndBgC/kEEqo6wT
         3rue1Gj59uI15SbRc5/fmRBVTWBndrCkHcWG1mY29SpYTwOlXRQAw9DOV5jwBvy6btZC
         abygQyIWqD12WZbsr2Z/Mk6QuvGDl9T78PoNJEAd5i2s9334EI6R+P19Q/YlzczgxSC+
         mYA9Q2E2l8Mk3zIt5DdYUf6CPEzqL83yM7wdWKlw2/NkIqyWE8vRSz5xfKexTUZ9sSSF
         tLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cnofqUXRGJIN4pxgWdVN1/yaAjfW7JomRgm1+ntQ8Xw=;
        b=RrO3TcoGpX5l5LJu1cweao2VQN1GsQAETLHvPUWk8t7PC59gPMDEfEN72Jjxi060KF
         zWA9LtRgey7Cvx1tlmfPArgDYg7yIkivRQxUUWpS51TT7U+s0FlUnv6EB3mdenU6gSqW
         AF0pxJzg3jXinuahsckjTo0ZN3m2w0ZO8rbERrNfzq61dBy6G7blQiJgUL5ki5VjtOSy
         hpIKI04FSibQMmA6nk0AE9PGt48OOhe5+C8ut/iBoUYnzzwchEWcp/bBgWFxQcJTq+da
         KyUfM51CyuibgCpMHCaEvhu0g42LdTT1u+gTFrg4nyrhpucBAu+2aD0P0FiBXY0VN5mY
         DYbA==
X-Gm-Message-State: APjAAAUaeUIo7/GXcE5V+cQ254HnqAFItXO5Vt7W5u81WnnxMpcTw2A9
        pIl5grX/X8P7hLtFCzgHXZT9XQ==
X-Google-Smtp-Source: APXvYqxxuYv8m+X3ZqXUykIUrv6we6k4NcBbA+MNXbJUfsEB/CPvZdEG1qytk8+tdA2vEGN2wc0BcQ==
X-Received: by 2002:a5d:4d4a:: with SMTP id a10mr75744408wru.220.1582620581241;
        Tue, 25 Feb 2020 00:49:41 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id i4sm3174232wmd.23.2020.02.25.00.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 00:49:40 -0800 (PST)
Date:   Tue, 25 Feb 2020 08:50:12 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH] mfd: sc27xx: Add USB charger type detection
 support
Message-ID: <20200225085012.GW3494@dell>
References: <049eb16cf995d3a2dd0de01f4c0ed09965e36f92.1581906151.git.baolin.wang7@gmail.com>
 <20200224113926.GU3494@dell>
 <CADBw62ry=+2Rm-Xnar-oeGe_JipvZ9zw=stT7vMHd+QR_m-JEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADBw62ry=+2Rm-Xnar-oeGe_JipvZ9zw=stT7vMHd+QR_m-JEw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020, Baolin Wang wrote:

> Hi Lee,
> 
> On Mon, Feb 24, 2020 at 7:38 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Mon, 17 Feb 2020, Baolin Wang wrote:
> >
> > > The Spreadtrum SC27XX series PMICs supply the USB charger type detection
> > > function, and related registers are located on the PMIC global registers
> > > region, thus we implement and export this function in the MFD driver for
> > > users to get the USB charger type.
> > >
> > > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > > ---
> > >  drivers/mfd/sprd-sc27xx-spi.c   |   52 +++++++++++++++++++++++++++++++++++++++
> > >  include/linux/mfd/sc27xx-pmic.h |    7 ++++++
> > >  2 files changed, 59 insertions(+)
> > >  create mode 100644 include/linux/mfd/sc27xx-pmic.h
> >
> > [...]
> >
> > > +enum usb_charger_type sprd_pmic_detect_charger_type(struct device *dev)
> > > +{
> > > +     struct spi_device *spi = to_spi_device(dev);
> > > +     struct sprd_pmic *ddata = spi_get_drvdata(spi);
> > > +     const struct sprd_pmic_data *pdata = ddata->pdata;
> > > +     enum usb_charger_type type;
> > > +     u32 val;
> > > +     int ret;
> > > +
> > > +     ret = regmap_read_poll_timeout(ddata->regmap, pdata->charger_det, val,
> > > +                                    (val & SPRD_PMIC_CHG_DET_DONE),
> > > +                                    SPRD_PMIC_CHG_DET_DELAY_US,
> > > +                                    SPRD_PMIC_CHG_DET_TIMEOUT);
> > > +     if (ret) {
> > > +             dev_err(&spi->dev, "failed to detect charger type\n");
> > > +             return UNKNOWN_TYPE;
> > > +     }
> > > +
> > > +     switch (val & SPRD_PMIC_CHG_TYPE_MASK) {
> > > +     case SPRD_PMIC_CDP_TYPE:
> > > +             type = CDP_TYPE;
> > > +             break;
> > > +     case SPRD_PMIC_DCP_TYPE:
> > > +             type = DCP_TYPE;
> > > +             break;
> > > +     case SPRD_PMIC_SDP_TYPE:
> > > +             type = SDP_TYPE;
> > > +             break;
> > > +     default:
> > > +             type = UNKNOWN_TYPE;
> > > +             break;
> > > +     }
> > > +
> > > +     return type;
> > > +}
> > > +EXPORT_SYMBOL_GPL(sprd_pmic_detect_charger_type);
> >
> > Where is this called from?
> 
> Our USB phy driver will call this API to get the charger type, which
> is used to notify the corresponding current can be drawn to charger
> drivers. And we will introduce users after this patch getting applied.
> 
> > Why isn't the charger type detected in the charger driver?
> 
> The charger type detection operation is not a part of charger, and its
> related registers are located on the PMIC global registers area. So I
> think the PMIC driver is the right place to implement. Moreover Arnd
> also suggested us to implement these APIs in the PMIC driver if I
> remember correctly.

You shouldn't think of this as a PMIC driver.  This is a device's
parent were functional drivers are allocated and registered.  Any
useful functionality should be farmed out to the child devices which
are to be appropriately dispersed and located into the subsystems.

It looks like the charger has access to the same register map as this
parent driver.  I do not see any compelling reason to provide charger
specific functionality in the parent driver at this point.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
