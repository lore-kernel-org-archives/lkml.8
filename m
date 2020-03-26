Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E09C2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708A120719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="oUaa4kKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgCZV4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:56:09 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39548 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgCZV4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:56:09 -0400
Received: by mail-ot1-f68.google.com with SMTP id x11so7658766otp.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 14:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fVDzJ6BDEWFzO6Zb5IeGhEXG4L3sc+hrhgcx0i0PDMc=;
        b=oUaa4kKpgOh9V1+IpaniVvK9yJzz4NLG4abJw0B5W05RL5HKAw+RPj9HZSG1LDDo7o
         xNSfpAIETfqMHJZJ2kZ/CmDopIiWyBUGKtHgBR63U8l1FoAD3J+z3ai7krCy1xFwnqZF
         CLk6cnqkm4ZR9MJyLruD+dTTeGerXRh1epfU1aiZfPAKyrb8jv3L+db6Amf+rr5PN0vO
         KSkimNNpjs/31eJL7+EnW1Si+tG3DjjkCWr5pJz19L2h5DjrQPVdLqeoYNE4ZI4pYkwe
         g04owtoGOG/7cEjU64xMJgZ0jh9+MNk5YnHf30L3vzEZ0zedjjMiIGHAY+bubla2n5sU
         5zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fVDzJ6BDEWFzO6Zb5IeGhEXG4L3sc+hrhgcx0i0PDMc=;
        b=Zr81oXCftvDhmW2rWHwbbK2vgszxoH/TGv/Bt+QsrfO/9caTcmCDcwxGRqler90rVs
         u3K531zzrc/aCFWaZUKHiothDsHxHlSNRccrllFsBOKDzxzPB3IRcHgnnN0zyeoJM9nr
         7XAlRkKBURzvq3/WgUHyrPBIAUzcBLAiR7/tHd7aSg3UyInH/sUqJ8GI5DQyc1KvhjjX
         Tm3Y+UpEJj8XjAMaSu2Iyh0rU9w6BJVTVOFfDEnK4IgprKf7o02sQPmx0r+ZPq2yp1NG
         IRCtH1tjf1Mt2nnNIa2ZO1WW7swoFtG0LHuLAmSpzPNMnYgystJi+nmByUT4p+BcCCmR
         73TA==
X-Gm-Message-State: ANhLgQ0D7dLF9S7LePXa6jpZkafQX0aZTUssUEIQ2KLDkBiNotIO0PZ/
        bTM8FNZW/1X2Y6Tgi8Wq7RjnP5m4H6UcEFl/XKANdA==
X-Google-Smtp-Source: ADFU+vsWTvLX1x18YifbVlDZbfMowYVSThseSulGrqAUkQatpGn5d7UzcL2X3gq8FAmUJ8EfBv414sF7tqsi/FUvBUc=
X-Received: by 2002:a4a:c184:: with SMTP id w4mr6815873oop.39.1585259766176;
 Thu, 26 Mar 2020 14:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <1584736550-7520-1-git-send-email-tharvey@gateworks.com>
 <1584736550-7520-3-git-send-email-tharvey@gateworks.com> <20200326101702.GD603801@dell>
In-Reply-To: <20200326101702.GD603801@dell>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Thu, 26 Mar 2020 14:55:54 -0700
Message-ID: <CAJ+vNU0pPW3n6dnUH4n_3ZtmwGYdtc6gwUkg+aWJYPF7bFUXzQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] mfd: add Gateworks System Controller core driver
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Robert Jones <rjones@gateworks.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 3:16 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Fri, 20 Mar 2020, Tim Harvey wrote:
>
> > The Gateworks System Controller (GSC) is an I2C slave controller
> > implemented with an MSP430 micro-controller whose firmware embeds the
> > following features:
> >  - I/O expander (16 GPIO's) using PCA955x protocol
> >  - Real Time Clock using DS1672 protocol
> >  - User EEPROM using AT24 protocol
> >  - HWMON using custom protocol
> >  - Interrupt controller with tamper detect, user pushbotton
> >  - Watchdog controller capable of full board power-cycle
> >  - Power Control capable of full board power-cycle
> >
<snip>
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 4209008..d84725a 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -407,6 +407,16 @@ config MFD_EXYNOS_LPASS
> >         Select this option to enable support for Samsung Exynos Low Power
> >         Audio Subsystem.
> >
> > +config MFD_GATEWORKS_GSC
> > +     tristate "Gateworks System Controller"
> > +     depends on (I2C && OF)
> > +     select MFD_CORE
> > +     select REGMAP_I2C
> > +     select REGMAP_IRQ
> > +     help
> > +       Enable support for the Gateworks System Controller found
> > +       on Gateworks Single Board Computers.
>
> Please describe which sub-devices are attached.

Hi Lee, thanks for the review!

I will add more description for v8:

Enable common support for the Gateworks System Controller
found on Gateworks Single Board Computers. This device supports
an interrupt controller providing interrupts for pushbutton
events and a sub-device for HWMON and FAN controller via the
gsc-hwmon driver.

>
> >  config MFD_MC13XXX
> >       tristate
> >       depends on (SPI_MASTER || I2C)
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index aed99f0..c82b442 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -15,6 +15,7 @@ obj-$(CONFIG_MFD_BCM590XX)  += bcm590xx.o
> >  obj-$(CONFIG_MFD_BD9571MWV)  += bd9571mwv.o
> >  obj-$(CONFIG_MFD_CROS_EC_DEV)        += cros_ec_dev.o
> >  obj-$(CONFIG_MFD_EXYNOS_LPASS)       += exynos-lpass.o
> > +obj-$(CONFIG_MFD_GATEWORKS_GSC)      += gateworks-gsc.o
> >
> >  obj-$(CONFIG_HTC_PASIC3)     += htc-pasic3.o
> >  obj-$(CONFIG_HTC_I2CPLD)     += htc-i2cpld.o
> > diff --git a/drivers/mfd/gateworks-gsc.c b/drivers/mfd/gateworks-gsc.c
> > new file mode 100644
> > index 00000000..8566123
> > --- /dev/null
> > +++ b/drivers/mfd/gateworks-gsc.c
> > @@ -0,0 +1,291 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * The Gateworks System Controller (GSC) is a multi-function
> > + * device designed for use in Gateworks Single Board Computers.
> > + * The control interface is I2C, with an interrupt. The device supports
> > + * system functions such as pushbutton monitoring, multiple ADC's for
> > + * voltage and temperature, fan controller, and watchdog monitor.
>
> When are you planning on adding support for the other devices?

The pushbutton monitoring is supported via interrupts and the ADC's
and fan controller are supported via the gsc-hwmon driver in this
series. The watchdog is not yet supported via a driver and I'm not
sure if/when I will submit one as the API is rather strange.

>
<snip>
> > +/*
> > + * gsc_powerdown - API to use GSC to power down board for a specific time
> > + *
> > + * secs - number of seconds to remain powered off
> > + */
> > +static int gsc_powerdown(struct gsc_dev *gsc, unsigned long secs)
> > +{
> > +     int ret;
> > +     unsigned char regs[4];
>
> No error checking?  Could be down for a very long time.

understood, but I'm not sure I want to dictate what the max amount of
time to power-down should be. Some remote-sensing use cases may want
to power-down for days, or weeks. I agree powering down for years
seems strange but again, I don't want to dictate usage. If they
accidently power down for a length of time they did not mean to they
still have to remove power, battery, or press a button to power back
on.

>
<snip>
>
> > +gsc_probe(struct i2c_client *client, const struct i2c_device_id *id)
> > +{
> > +     struct device *dev = &client->dev;
> > +     struct gsc_dev *gsc;
> > +     int ret;
> > +     unsigned int reg;
> > +
> > +     gsc = devm_kzalloc(dev, sizeof(*gsc), GFP_KERNEL);
> > +     if (!gsc)
> > +             return -ENOMEM;
> > +
> > +     gsc->dev = &client->dev;
> > +     gsc->i2c = client;
> > +     i2c_set_clientdata(client, gsc);
> > +
> > +     gsc->regmap = devm_regmap_init(dev, &regmap_gsc, client,
> > +                                    &gsc_regmap_config);
> > +     if (IS_ERR(gsc->regmap))
> > +             return PTR_ERR(gsc->regmap);
> > +
> > +     if (regmap_read(gsc->regmap, GSC_FW_VER, &reg))
> > +             return -EIO;
> > +     gsc->fwver = reg;
>
> You not checking this for a valid value?

it's a single byte unsigned char, there really isn't an invalid value.

>
> > +     regmap_read(gsc->regmap, GSC_FW_CRC, &reg);
> > +     gsc->fwcrc = reg;
> > +     regmap_read(gsc->regmap, GSC_FW_CRC + 1, &reg);
> > +     gsc->fwcrc |= reg << 8;
> > +
> > +     gsc->i2c_hwmon = i2c_new_dummy_device(client->adapter, GSC_HWMON);
> > +     if (!gsc->i2c_hwmon) {
> > +             dev_err(dev, "Failed to allocate I2C device for HWMON\n");
> > +             return -ENODEV;
> > +     }
> > +     i2c_set_clientdata(gsc->i2c_hwmon, gsc);
> > +
> > +     gsc->regmap_hwmon = devm_regmap_init(dev, &regmap_gsc, gsc->i2c_hwmon,
> > +                                          &gsc_regmap_hwmon_config);
> > +     if (IS_ERR(gsc->regmap_hwmon)) {
> > +             ret = PTR_ERR(gsc->regmap_hwmon);
> > +             dev_err(dev, "failed to allocate register map: %d\n", ret);
> > +             goto err_regmap;
> > +     }
>
> Why can't the HWMON driver fetch its own Regmap?

I can move this to hwmon. It means I have to share the regmap_bus in
struct gsc_dev instead of sharing the regmap but I suppose it makes
more sense to have hwmon register it's own.

Everything else you suggest makes complete sense and I will put into v8.

Best Regards,

Tim
