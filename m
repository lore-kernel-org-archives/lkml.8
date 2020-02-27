Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BA2C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 05:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5266421556
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 05:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1XyANOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgB0Flj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 00:41:39 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33419 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgB0Fli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 00:41:38 -0500
Received: by mail-qk1-f193.google.com with SMTP id h4so2080502qkm.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 21:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hw6QZPX2qEuN9qM/QrRO1SiFsJK0I5hW92E65JUrSnQ=;
        b=H1XyANOT4P+YdU62R2o0kOX5KGJssSg9lyyWUVxXWVeXXk2ltMFLHvp3BFtn0YFHdG
         IMq7rn+/Rex3r8CFCz8vyFIHc15sFy6r3Reb3f5ev05T5CD2XRE6FVDXPs3dylhBmaKp
         SHAKXEyrR4fiobTKs7vSCOMtzXxrrRfvzjgIOCYcju6V4HK51zjgp32W12aNb+Ywra2R
         0sEuCjaM7LfdwQqWht+8RRSfZhmG5fa9ovKWKMLBFmHrLjCSmkZ4F/i4UOgxlxAtQH7z
         ArxRllUhP9QgfxgPbBBliisLaQ7bfwCIZ45k874t3DQfO4p5am0FvR67Bcu3JrmTpElK
         3IyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hw6QZPX2qEuN9qM/QrRO1SiFsJK0I5hW92E65JUrSnQ=;
        b=ZlHidKn+dXv3c3o1ITcPEGmP89KPyCKfr3UXQEnis+Sx5EAaUhZIKyCRmBj+Re9p83
         5gx6a3gQrw9jN7312yZ6Mj6WfvZEEQ7mZb5kFIm/46aEaOAAOIMaDWrK4M29ZjqfxvpH
         G2hpso3OKZEXmSx4LURmUs+IR8NQjAkVPuj77MvVO0yr9FjrNSC183Cq8hhljTUEXIH4
         E/SqK38V42Wu4cLGt+AnzgA7RG+bNxQjWp8cS++LnnzuPsTSUJjimjk14pmhfJ6rUdx9
         hWQqQ3Ci9eJc43IPbhrZNBA2J91TzZu0f/mWH1juaYOT1p5+l70jQPTpxnjuWOPJVLUd
         yAcQ==
X-Gm-Message-State: APjAAAWleRq63NbZurKlHhSsZwRK4HVMlXpkL+yNo5FxJBHMbrjRZuTG
        /G+6iCHsz9GZBotsaPD9nRwMG08LMPywDREL4JXxD/ni
X-Google-Smtp-Source: APXvYqwRCDTK7/PQmCPexZFvtKN2S33XvqLew6GYL6ph3qna4WnuRZ/2PPJuyNHAogAmfDTWLHxM5biJ+XnNXD75vuM=
X-Received: by 2002:a05:620a:7ee:: with SMTP id k14mr3379095qkk.170.1582782097545;
 Wed, 26 Feb 2020 21:41:37 -0800 (PST)
MIME-Version: 1.0
References: <049eb16cf995d3a2dd0de01f4c0ed09965e36f92.1581906151.git.baolin.wang7@gmail.com>
 <20200224113926.GU3494@dell> <CADBw62ry=+2Rm-Xnar-oeGe_JipvZ9zw=stT7vMHd+QR_m-JEw@mail.gmail.com>
 <20200225085012.GW3494@dell> <CADBw62q3wF_h83x3SwcX059N5EvMzm0mjVue+8vxn4Nbq0_Xng@mail.gmail.com>
In-Reply-To: <CADBw62q3wF_h83x3SwcX059N5EvMzm0mjVue+8vxn4Nbq0_Xng@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Thu, 27 Feb 2020 13:41:26 +0800
Message-ID: <CADBw62o=nw_S9Q4x8S-NK+8Xa6jhzXxRgy0PxEJvcPKrs6WbOg@mail.gmail.com>
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

On Tue, Feb 25, 2020 at 5:27 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> On Tue, Feb 25, 2020 at 4:49 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Tue, 25 Feb 2020, Baolin Wang wrote:
> >
> > > Hi Lee,
> > >
> > > On Mon, Feb 24, 2020 at 7:38 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > >
> > > > On Mon, 17 Feb 2020, Baolin Wang wrote:
> > > >
> > > > > The Spreadtrum SC27XX series PMICs supply the USB charger type detection
> > > > > function, and related registers are located on the PMIC global registers
> > > > > region, thus we implement and export this function in the MFD driver for
> > > > > users to get the USB charger type.
> > > > >
> > > > > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > > > > ---
> > > > >  drivers/mfd/sprd-sc27xx-spi.c   |   52 +++++++++++++++++++++++++++++++++++++++
> > > > >  include/linux/mfd/sc27xx-pmic.h |    7 ++++++
> > > > >  2 files changed, 59 insertions(+)
> > > > >  create mode 100644 include/linux/mfd/sc27xx-pmic.h
> > > >
> > > > [...]
> > > >
> > > > > +enum usb_charger_type sprd_pmic_detect_charger_type(struct device *dev)
> > > > > +{
> > > > > +     struct spi_device *spi = to_spi_device(dev);
> > > > > +     struct sprd_pmic *ddata = spi_get_drvdata(spi);
> > > > > +     const struct sprd_pmic_data *pdata = ddata->pdata;
> > > > > +     enum usb_charger_type type;
> > > > > +     u32 val;
> > > > > +     int ret;
> > > > > +
> > > > > +     ret = regmap_read_poll_timeout(ddata->regmap, pdata->charger_det, val,
> > > > > +                                    (val & SPRD_PMIC_CHG_DET_DONE),
> > > > > +                                    SPRD_PMIC_CHG_DET_DELAY_US,
> > > > > +                                    SPRD_PMIC_CHG_DET_TIMEOUT);
> > > > > +     if (ret) {
> > > > > +             dev_err(&spi->dev, "failed to detect charger type\n");
> > > > > +             return UNKNOWN_TYPE;
> > > > > +     }
> > > > > +
> > > > > +     switch (val & SPRD_PMIC_CHG_TYPE_MASK) {
> > > > > +     case SPRD_PMIC_CDP_TYPE:
> > > > > +             type = CDP_TYPE;
> > > > > +             break;
> > > > > +     case SPRD_PMIC_DCP_TYPE:
> > > > > +             type = DCP_TYPE;
> > > > > +             break;
> > > > > +     case SPRD_PMIC_SDP_TYPE:
> > > > > +             type = SDP_TYPE;
> > > > > +             break;
> > > > > +     default:
> > > > > +             type = UNKNOWN_TYPE;
> > > > > +             break;
> > > > > +     }
> > > > > +
> > > > > +     return type;
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(sprd_pmic_detect_charger_type);
> > > >
> > > > Where is this called from?
> > >
> > > Our USB phy driver will call this API to get the charger type, which
> > > is used to notify the corresponding current can be drawn to charger
> > > drivers. And we will introduce users after this patch getting applied.
> > >
> > > > Why isn't the charger type detected in the charger driver?
> > >
> > > The charger type detection operation is not a part of charger, and its
> > > related registers are located on the PMIC global registers area. So I
> > > think the PMIC driver is the right place to implement. Moreover Arnd
> > > also suggested us to implement these APIs in the PMIC driver if I
> > > remember correctly.
> >
> > You shouldn't think of this as a PMIC driver.  This is a device's
> > parent were functional drivers are allocated and registered.  Any
>
> Right.
>
> > useful functionality should be farmed out to the child devices which
> > are to be appropriately dispersed and located into the subsystems.
> >
> > It looks like the charger has access to the same register map as this
> > parent driver.  I do not see any compelling reason to provide charger
> > specific functionality in the parent driver at this point.
>
> Actually the charger detection is not belonging to the charger
> subsystem, at least in the hardware design level. The charger
> detection's theory is detetcing the USB phy D+/D- line to get the
> charger type, then the hardware will save the charger type into the
> PMIC global reigsters automatically for users to get. So this is not
> related with the charger driver, which only supplies charging
> services, and this is also not belonging to the USB phy, since the
> related registers are located on the PMIC gloabl registers area. So
> you still think we should not provide this funcion here?

After more investigation, I found I can not move the charger detection
into the charger driver.

Cause the USB phy will implement the USB charger support by
implementing phy->charger_detect() ops (which will call
sprd_pmic_detect_charger_type() to get the charger type), which means
the USB phy driver need to get a power supply object by a
'power-supply' phandle firstly, if we move the charger detection part
into the charger driver.

But our charger driver also need to register a USB phy notifier to be
notified how much current can be drawn from the USB charger framework,
which means the charger driver need to get a usb_phy object by a
'phys' phandle[1]. So this two drivers are interdependent and
dead-lock.

If we implement the charger type detection in the MFD, the USB phy
driver can get the PMIC device by a phandle easily to get the charger
type. Moreover from my previous description of the hardware design, I
still think implementing the charger type detection in the MFD driver
is a good way now.

What do you think? Thanks.

[1] https://elixir.bootlin.com/linux/v5.6-rc3/source/drivers/power/supply/sc2731_charger.c#L496
