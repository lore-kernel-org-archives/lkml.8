Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AECEC2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7092B20714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xXRePv+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgC0Kcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 06:32:43 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35228 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgC0Kcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 06:32:43 -0400
Received: by mail-ot1-f66.google.com with SMTP id v2so4638924oto.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 03:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YYF9IlkYIan1+UFMEoSWkc8FBz64pPNX5SeJSHAu8kg=;
        b=xXRePv+8SgkF6sJVJLkuv6mQ3y/WTJtU4pKOk2h/g4ZRRHoUdhWf7be/9xVvXKJdOJ
         39uHfWxJUgkVtpS11k+sbvlmqrHPQZp4BnoMDUn9WmW3l093QS/IYdfe9Ov6MsLD0orX
         w3om+wu4CpiMG2891c46ivxP+5hF4oDBg/2XwZVmw0wycDU+vm++0LepD4VMusQXW9M8
         3DH+9eMSAFaeaUdQAvQIXWhp1gr1VgSA3s58G7EWE8Lwv+23SbpOZn67vq4HXZzLA10c
         9m/EzI/Ld/dq/n+X1pjXT4ciAgnrosOzyR+x1GIxsSkrvCUkSM+eiZJ1mgeNdRZhOWaY
         lCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YYF9IlkYIan1+UFMEoSWkc8FBz64pPNX5SeJSHAu8kg=;
        b=WwPydPY9aEPmGABzyZAHF5fH0l1do2tj5kcn9ih5JyWpesE2BSMAQAmSMu1Zx3J5Ba
         7NTVNdyU0V+8gEwEIR5RrhfPWonfMqviiDqGWz6JkkKjZOa1vD5Lrf9+dyVANPMADhzu
         RpiBIHldv5ClRBkaYwI/pb39yVYjP7fQEClYSw32GW7VphKiBOLLe5wG1e53zb6DSQnL
         +UYg6jXqaO7a9VI7NFR3vrPxio1uqmGtUh6VkCsMfLWqrgc30WL6jqpsVUMCoI7Dj3+8
         3LKjRw4zPCRcOXVH0CYIp/yPEtUwRoFcAn2DpCL2ivdpoQxbP/tHATzNfhOWdchx9pzM
         oRsw==
X-Gm-Message-State: ANhLgQ1a/PPGJjQnrdTXHiEt33K1FzxkC5ZqTrdss0EN/fgDt32G4j1v
        zfbJfcJ8nG2IWuvg2byTrhFo944/eecXdKwAidwizw==
X-Google-Smtp-Source: ADFU+vseCXoMGXatVYtvuIKCvvYcHpzp5L/GUxqGEUSN7+BRDLJCxO7pyQfJM0X4rU4ScjZZJpwRtscCky9sePUUX9s=
X-Received: by 2002:a9d:27a7:: with SMTP id c36mr9836243otb.68.1585305162293;
 Fri, 27 Mar 2020 03:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200313110350.10864-1-robert.foss@linaro.org>
 <20200313110350.10864-3-robert.foss@linaro.org> <20200313121746.GC5730@valkosipuli.retiisi.org.uk>
 <CAG3jFytpx8_+DKhUVZnUFeMYK82Z1hFWcEnbyD0=4a8p3ojteg@mail.gmail.com> <20200326144725.GA2394@valkosipuli.retiisi.org.uk>
In-Reply-To: <20200326144725.GA2394@valkosipuli.retiisi.org.uk>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 27 Mar 2020 11:32:29 +0100
Message-ID: <CAG3jFyu=HOsWNeRFC2t4HjzYrFrLjsbXzAm4+zD50Xq48mqzcw@mail.gmail.com>
Subject: Re: [v2 2/3] media: ov8856: Add devicetree support
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Mar 2020 at 15:47, Sakari Ailus <sakari.ailus@iki.fi> wrote:
>
> Hi Robert,
>
> On Thu, Mar 26, 2020 at 12:56:37PM +0100, Robert Foss wrote:
> ...
> > > > +static int __ov8856_power_on(struct ov8856 *ov8856)
> > > > +{
> > > > +     struct i2c_client *client = v4l2_get_subdevdata(&ov8856->sd);
> > > > +     int ret;
> > > > +
> > > > +     ret = clk_prepare_enable(ov8856->xvclk);
> > > > +     if (ret < 0) {
> > > > +             dev_err(&client->dev, "failed to enable xvclk\n");
> > > > +             return ret;
> > > > +     }
> > > > +
> > > > +     gpiod_set_value_cansleep(ov8856->reset_gpio, GPIOD_OUT_HIGH);
> > > > +
> > > > +     ret = regulator_bulk_enable(ARRAY_SIZE(ov8856_supply_names),
> > > > +                                 ov8856->supplies);
> > > > +     if (ret < 0) {
> > > > +             dev_err(&client->dev, "failed to enable regulators\n");
> > > > +             goto disable_clk;
> > > > +     }
> > > > +
> > > > +     gpiod_set_value_cansleep(ov8856->reset_gpio, GPIOD_OUT_LOW);
> > > > +
> > > > +     usleep_range(1500, 1800);
> > >
> > > I think you could omit the delay on ACPI based systems. Or just bail out
> > > early in that case.
> >
> > I'll add a check for reset_gpio being NULL, and skip the sleep for that case.
>
> There could also be a regulator but no GPIO.
>
> I think if you don't have either, then certainly there's no need for a
> delay.

Removing the delay if no action is taken makes sense, but I'm not sure
how best to do it.
If there are no regulators dummy ones are created automatically, which
makes distinguishing between a little bit cumbersome. The regulator
structs could of course all be inspected, and if all are dummy ones,
the delay could be skipped. But is there a neater way of doing this?
Manually inspecting the regs strikes me as a bit inelegant.

>
> ...
>
> > > > +             ov8856->xvclk = NULL;
> > > > +     } else if (IS_ERR(ov8856->xvclk)) {
> > > > +             dev_err(&client->dev, "could not get xvclk clock (%ld)\n",
> > > > +                     PTR_ERR(ov8856->xvclk));
> > > > +             return PTR_ERR(ov8856->xvclk);
> > > > +     }
> > > > +
> > > > +     ret = clk_set_rate(ov8856->xvclk, OV8856_XVCLK_24);
> > >
> > > This should either come from platform data, or perhaps it'd be even better
> > > to get the clock rate and use assigned-clock-rates. I guess that's
> > > preferred nowadays.
> >
> > I'm a bit unsure about what this would look like.
> >
> > Are you thinking something like the way ext_clk is used in smiapp_core.c?
> > I went ahead and implemented support for retrieving and storing
> > 'clock-rates' during the ov8856_check_hwcfg() call, and then setting
> > the rate to the configured rate during probing.
>
> With assigned-clock-rates, you can simply use clk_get_rate().

Ah, I see.

I'll switch to that approach then.

>
> As you get the actual rate, it could be somewhat off of the intended one.
>
> --
> Kind regards,
>
> Sakari Ailus
