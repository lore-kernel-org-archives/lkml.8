Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9521C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13A021655
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="td+5kHMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbgCKNcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 09:32:43 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39209 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729481AbgCKNcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 09:32:43 -0400
Received: by mail-ot1-f68.google.com with SMTP id a9so1925510otl.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 06:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WXC1eWa5pSBG2kIwwU8A6k/UEnvKcy01RlKUph7V4qM=;
        b=td+5kHMW+m3MVBsqw6o60BiEUQM11VPK4Kmh6+o9kx56easM8WTmyDdwACmJXVwUZd
         Y3mNeZAelp/0KETvaK/iXwk30HHYKuPHn56/5S0C1t+KAWiG5LzJ830W9dNGjaj7mGUf
         HkipB2yqLYOpQeTzXhe5YhQGnAbqxhfj0yZt7cNhEOn2seEwaOeXCsv4XbCoDco+ar6q
         /butQOQmyQRPfew3tJNTsKkKyHRkcX/RnO6Ls5CbaG5eg8waBDvfY7h0Cg7K9LerZZaL
         14LK6pY9ol2BbcmwqqW7Y7WaqNbtYiOu9niM5b2ZqqKcL7w+8DZ9jxo4dIHvZ2lbExwB
         kp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WXC1eWa5pSBG2kIwwU8A6k/UEnvKcy01RlKUph7V4qM=;
        b=dZdn5ck9AmKVBCK5BmzgYDf604Zl+UE6RywoUyEGbYyKmX3Ltr0IA5/ttuQmYhJ0Nu
         X/GZLe1pcEzTDqaPd15Drhk9EDZiM4DALCkU8bDzEl5FuGftG9foO9irpwV4hghjbDbY
         SscdYG9o1OBzGBOwhoxJVecXU7aPjNmi2hJdCE6YS7ZDBzc9OCoAJqJbLCkdPdWG0gJ4
         L8zYPbmggN2Nd236v3kBvo4C1+T8Qob01axtPlISTzvopInm9+TDCfHH7z/5HI42Cy3s
         /G54sP6XMFPRNQa/K6/aQIHxWGZeEPZFZs2UJRATBVVu5rqHSJJ4eSX5ZwXifAQx7fMk
         GnCQ==
X-Gm-Message-State: ANhLgQ0W6FHmvUFVoFmiH0xxQBKVueecH2Lrjz3BAo1e0WtqQQG1pJVm
        OptwkdSQh9V1y8Fhj9m+nyKx09QxsFv9cJlcuHMBcg==
X-Google-Smtp-Source: ADFU+vuCkXbpyI/txzrlxd2TEETHHaxmMQrvc+sXtCR9ejrce9Y8dHGpDSGyvjIcCus/wkaa6oNRCw01tVw1hY82qlo=
X-Received: by 2002:a9d:19e9:: with SMTP id k96mr2402209otk.68.1583933561847;
 Wed, 11 Mar 2020 06:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200310134603.30260-1-robert.foss@linaro.org>
 <20200310134603.30260-3-robert.foss@linaro.org> <20200310142652.GK1922688@smile.fi.intel.com>
 <CAG3jFyu5S1H=r6pV92tc_a2LoCUnhb0mDbOegP2BCO8a5C1nVg@mail.gmail.com> <20200311114848.GJ2619@valkosipuli.retiisi.org.uk>
In-Reply-To: <20200311114848.GJ2619@valkosipuli.retiisi.org.uk>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 11 Mar 2020 14:32:30 +0100
Message-ID: <CAG3jFyv8X=k=1EGMCHnSNqDaRBZ68pht42yDzc5hJPui0wdAjQ@mail.gmail.com>
Subject: Re: [v1 2/3] media: ov8856: Add devicetree support
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ben.kao@intel.com, Rob Herring <robh+dt@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Sakari,

On Wed, 11 Mar 2020 at 12:49, Sakari Ailus <sakari.ailus@iki.fi> wrote:
>
> Hi Robert,
>
> On Tue, Mar 10, 2020 at 04:55:20PM +0100, Robert Foss wrote:
> > Hi Andy,
> >
> > On Tue, 10 Mar 2020 at 15:26, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Tue, Mar 10, 2020 at 02:46:02PM +0100, Robert Foss wrote:
> > > > Add devicetree match table, and enable ov8856_probe()
> > > > to initialize power, clocks and reset pins.
> > >
> > > ...
> > >
> > > > +#define OV8856_NUM_SUPPLIES ARRAY_SIZE(ov8856_supply_names)
> > >
> > > Use ARRAY_SIZE() directly.
> >
> > Ack.
> >
> > >
> > > Have you seen Sakari's comments?
> > > Sakari, do I have d=C3=A9j=C4=85 vu or you indeed commented this driv=
er?
> >
> > Yes, I may have missed some part of it, so please tell me if I have.
> >
> > There is a patchset floating around that implements a larger chunk of
> > functionality,
> > including a couple of new modes. This is based on that series.
>
> Please see earlier comments given against an earlier variant of this set.
> They're on LMML.
>
> >
> > >
> > > ...
> > >
> > > > +     gpiod_set_value_cansleep(ov8856->n_shutdn_gpio, GPIOD_OUT_LOW=
);
> > >
> > > > +     gpiod_set_value_cansleep(ov8856->n_shutdn_gpio, GPIOD_OUT_HIG=
H);
> > >
> > > Yes, seems this one is inverted.
> > >
> > > ...
> > >
> > > > +{
> > > > +     gpiod_set_value_cansleep(ov8856->n_shutdn_gpio, GPIOD_OUT_LOW=
);
> > > > +     regulator_bulk_disable(OV8856_NUM_SUPPLIES, ov8856->supplies)=
;
> > > > +     clk_disable_unprepare(ov8856->xvclk);
> > > > +}
> > > > +
> > > > +
> > >
> > > One blank line is enough.
> > >
> > > ...
> > >
> > > > +     ov8856->xvclk =3D devm_clk_get(&client->dev, "xvclk");
> > > > +     if (IS_ERR(ov8856->xvclk)) {
> > > > +             dev_err(&client->dev, "failed to get xvclk\n");
> > > > +             return -EINVAL;
> > > > +     }
> > >
> > > Previously it worked without clock provider, now you make a dependenc=
y.
> > >
> > > This won't work.
> >
> > So the ideal behavior would be to only use the xclk if it is provided?
>
> See e.g. the smiapp driver on how to do this so it continues to work on
> ACPI.

Thanks for the pointer!

>
> I think it'd be also appropriate to add the usleep() after lifting reset
> only if the reset GPIO is defined for the device.

Ack
