Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767BFC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 09:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5E724670
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 09:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pnm/dt9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgB0JfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 04:35:01 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37695 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbgB0JfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 04:35:00 -0500
Received: by mail-wm1-f65.google.com with SMTP id a141so2552348wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 01:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=z/+7H3+acEhMvhJMpuhkWxQh6HRDrwFcpIXhWjeSO+4=;
        b=Pnm/dt9ojjNIqzkFOndD0o4EYdusWVksbPf2ZbhIEMYsmNaLNGjkLwrl2ZWx5cKBtz
         i/+k4uYXWcFg+6Cs37K3Uje3NGrICWUx7hxDwbKMlIhE91kk7Ys8/zOqhokykeH/UMFT
         m30c8FbJhKFDHFdwumbAqSvqiNV7BPe2arWfxT5jUY8/dkeRpU1/AoGyGKHkdCP7e1ze
         CmZwBz9WiGfXDup/qnaE46UmKEkosuzGpWRiZuyj55N+qSklpnxhISwYaiJ3oYlLubJG
         RaBuoctpaHv/GhMGA3+xkzDCuIGp/wRrgvGFUNTyUJ6yXS8joJm4brcx3/D2k1L71t1k
         ufQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=z/+7H3+acEhMvhJMpuhkWxQh6HRDrwFcpIXhWjeSO+4=;
        b=pngVsnjXwX/AS7wMzxe/aEhL7OvWv7IsMPgaib2qxYboruyQxQOcjNOP2GIuzIHB6G
         KgitCbVpiJx3M3Pv//4hFpDsgJqeWB0C5+1vJ0FLv8J0hrKmxk0g/Js1jBTtzGRhUrZd
         TD0IKdMp0zSPQchfZUD34y3P2HvvXKMhnGgCGXIIZ13a19sqMxqNzEy+fM3skzzfF88H
         9p2lvnG0C0P3LQ+ZLrtOoY+YOUAOHlmVWjqAOjlBoa9Z3gk0zThu9+3H3JkWjpbeParv
         fFUEP8+MWg3/abm07KioXH8qrIZJOaCTIxePt0UYiFa3nLSkyy35jq4hDmJ4Kj+IGE9F
         C0fw==
X-Gm-Message-State: APjAAAVZdQ0ZQR54npJ1pq14AyP4fpHamhAi5VtuQ6jUKXkr9qkz3JqR
        Pa+Y3cqqi9Wo0HEYktRU5Glz2g==
X-Google-Smtp-Source: APXvYqwqkiL1IM2kGGiEUoAMVFsmE1V88QrICuOdPfN78IZ0muQ/Tz5Z7egTRQwANt4TgahjVHnhGg==
X-Received: by 2002:a05:600c:22c8:: with SMTP id 8mr4151965wmg.178.1582796097872;
        Thu, 27 Feb 2020 01:34:57 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id n8sm6668488wrx.42.2020.02.27.01.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 01:34:57 -0800 (PST)
Date:   Thu, 27 Feb 2020 09:35:30 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH] mfd: sc27xx: Add USB charger type detection
 support
Message-ID: <20200227093530.GU3494@dell>
References: <049eb16cf995d3a2dd0de01f4c0ed09965e36f92.1581906151.git.baolin.wang7@gmail.com>
 <20200224113926.GU3494@dell>
 <CADBw62ry=+2Rm-Xnar-oeGe_JipvZ9zw=stT7vMHd+QR_m-JEw@mail.gmail.com>
 <20200225085012.GW3494@dell>
 <CADBw62q3wF_h83x3SwcX059N5EvMzm0mjVue+8vxn4Nbq0_Xng@mail.gmail.com>
 <CADBw62o=nw_S9Q4x8S-NK+8Xa6jhzXxRgy0PxEJvcPKrs6WbOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADBw62o=nw_S9Q4x8S-NK+8Xa6jhzXxRgy0PxEJvcPKrs6WbOg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020, Baolin Wang wrote:

> Hi Lee,
> 
> On Tue, Feb 25, 2020 at 5:27 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > On Tue, Feb 25, 2020 at 4:49 PM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > On Tue, 25 Feb 2020, Baolin Wang wrote:
> > >
> > > > Hi Lee,
> > > >
> > > > On Mon, Feb 24, 2020 at 7:38 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > >
> > > > > On Mon, 17 Feb 2020, Baolin Wang wrote:
> > > > >
> > > > > > The Spreadtrum SC27XX series PMICs supply the USB charger type detection
> > > > > > function, and related registers are located on the PMIC global registers
> > > > > > region, thus we implement and export this function in the MFD driver for
> > > > > > users to get the USB charger type.
> > > > > >
> > > > > > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > > > > > ---
> > > > > >  drivers/mfd/sprd-sc27xx-spi.c   |   52 +++++++++++++++++++++++++++++++++++++++
> > > > > >  include/linux/mfd/sc27xx-pmic.h |    7 ++++++
> > > > > >  2 files changed, 59 insertions(+)
> > > > > >  create mode 100644 include/linux/mfd/sc27xx-pmic.h
> > > > >
> > > > > [...]
> > > > >
> > > > > > +enum usb_charger_type sprd_pmic_detect_charger_type(struct device *dev)
> > > > > > +{
> > > > > > +     struct spi_device *spi = to_spi_device(dev);
> > > > > > +     struct sprd_pmic *ddata = spi_get_drvdata(spi);
> > > > > > +     const struct sprd_pmic_data *pdata = ddata->pdata;
> > > > > > +     enum usb_charger_type type;
> > > > > > +     u32 val;
> > > > > > +     int ret;
> > > > > > +
> > > > > > +     ret = regmap_read_poll_timeout(ddata->regmap, pdata->charger_det, val,
> > > > > > +                                    (val & SPRD_PMIC_CHG_DET_DONE),
> > > > > > +                                    SPRD_PMIC_CHG_DET_DELAY_US,
> > > > > > +                                    SPRD_PMIC_CHG_DET_TIMEOUT);
> > > > > > +     if (ret) {
> > > > > > +             dev_err(&spi->dev, "failed to detect charger type\n");
> > > > > > +             return UNKNOWN_TYPE;
> > > > > > +     }
> > > > > > +
> > > > > > +     switch (val & SPRD_PMIC_CHG_TYPE_MASK) {
> > > > > > +     case SPRD_PMIC_CDP_TYPE:
> > > > > > +             type = CDP_TYPE;
> > > > > > +             break;
> > > > > > +     case SPRD_PMIC_DCP_TYPE:
> > > > > > +             type = DCP_TYPE;
> > > > > > +             break;
> > > > > > +     case SPRD_PMIC_SDP_TYPE:
> > > > > > +             type = SDP_TYPE;
> > > > > > +             break;
> > > > > > +     default:
> > > > > > +             type = UNKNOWN_TYPE;
> > > > > > +             break;
> > > > > > +     }
> > > > > > +
> > > > > > +     return type;
> > > > > > +}
> > > > > > +EXPORT_SYMBOL_GPL(sprd_pmic_detect_charger_type);
> > > > >
> > > > > Where is this called from?
> > > >
> > > > Our USB phy driver will call this API to get the charger type, which
> > > > is used to notify the corresponding current can be drawn to charger
> > > > drivers. And we will introduce users after this patch getting applied.
> > > >
> > > > > Why isn't the charger type detected in the charger driver?
> > > >
> > > > The charger type detection operation is not a part of charger, and its
> > > > related registers are located on the PMIC global registers area. So I
> > > > think the PMIC driver is the right place to implement. Moreover Arnd
> > > > also suggested us to implement these APIs in the PMIC driver if I
> > > > remember correctly.
> > >
> > > You shouldn't think of this as a PMIC driver.  This is a device's
> > > parent were functional drivers are allocated and registered.  Any
> >
> > Right.
> >
> > > useful functionality should be farmed out to the child devices which
> > > are to be appropriately dispersed and located into the subsystems.
> > >
> > > It looks like the charger has access to the same register map as this
> > > parent driver.  I do not see any compelling reason to provide charger
> > > specific functionality in the parent driver at this point.
> >
> > Actually the charger detection is not belonging to the charger
> > subsystem, at least in the hardware design level. The charger
> > detection's theory is detetcing the USB phy D+/D- line to get the
> > charger type, then the hardware will save the charger type into the
> > PMIC global reigsters automatically for users to get. So this is not
> > related with the charger driver, which only supplies charging
> > services, and this is also not belonging to the USB phy, since the
> > related registers are located on the PMIC gloabl registers area. So
> > you still think we should not provide this funcion here?
> 
> After more investigation, I found I can not move the charger detection
> into the charger driver.
> 
> Cause the USB phy will implement the USB charger support by
> implementing phy->charger_detect() ops (which will call
> sprd_pmic_detect_charger_type() to get the charger type), which means
> the USB phy driver need to get a power supply object by a
> 'power-supply' phandle firstly, if we move the charger detection part
> into the charger driver.
> 
> But our charger driver also need to register a USB phy notifier to be
> notified how much current can be drawn from the USB charger framework,
> which means the charger driver need to get a usb_phy object by a
> 'phys' phandle[1]. So this two drivers are interdependent and
> dead-lock.
> 
> If we implement the charger type detection in the MFD, the USB phy
> driver can get the PMIC device by a phandle easily to get the charger
> type. Moreover from my previous description of the hardware design, I
> still think implementing the charger type detection in the MFD driver
> is a good way now.
> 
> What do you think? Thanks.

Thanks for the explanation.  Patch applied.

> [1] https://elixir.bootlin.com/linux/v5.6-rc3/source/drivers/power/supply/sc2731_charger.c#L496

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
