Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FCDC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DFB020575
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pg98rEQi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgELJNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 05:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725776AbgELJNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 05:13:18 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771A7C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 02:13:18 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d22so3879408lfm.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 02:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H5NxWnB44BHoFTIR9JnXXiSNJPnbv0oKAagOIOpcjIg=;
        b=pg98rEQi9dz8iVjoQCSsE9HzyrjoVPvG8UfFtLCrLIB1an3j1kvOIh8NeQAIo3YTc2
         9nVyyShC/pM1Mc1Mp0bj3xRokSkQ1HUL+HS+hgvs+/MoNFpV2LGsX/7zUpieOutmjwPp
         D/kj5jDeM0THsBdKs7IPrldqZjcPEQ/l7e6ZJuQW5bkFoqaydZVfS717yy5yTUagjMvs
         Dy0GoonxfUkj1t1reiOA8O2WQAFDod00DFeTiqsXihCRKrzXejXRa4Q9Gtnibdb3cAuQ
         z2hu3MKxNq9UKchB++UDFLCTFPc3EJW2FRniFJlHKP3Yo1nCLcMVfPXzSS5YvVjWumKR
         S5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H5NxWnB44BHoFTIR9JnXXiSNJPnbv0oKAagOIOpcjIg=;
        b=pviQMv3hGopytrcJxYxcMkB15ivP5hYZGkGErR6R5TQYmZnm7rmDMG8tuEBqSYP1c7
         8rj1ZJUGmNXGSPPPsxh11vtnfeCaVWlovl3K+ZrDWv3cfaOmW+A5x6W8e2lSTGlz4E3e
         9n1L7PMnP1NAU17ILNPKzHdZ/Y0RLZRNTyKxHTj9yo41aNRAPmF64XdCVpIJ8s3NksNE
         4Q1mT26TP75y6oPI2sPJ8IrXXDZiUCjfqG086WycX/IM0E8pkQwhepV4Xxoe5BOwawv9
         1dsnTVaZrTFShhavQ/GY55G0ldOHIv8DkCQqcHdobtnISRZhXHcm0/8OSn9m293WYlIi
         JODg==
X-Gm-Message-State: AOAM533QQbQ2RQzFLQ9WNZ6VyDjGALs0Oo0WK/nl9wywHo1ZVg/pCkRe
        +v/p3w7rvNc58o/ezUoxuf99dA3P4ljg00f/PHU=
X-Google-Smtp-Source: ABdhPJzziA/kF+1nDgz2ztBeSseRDnDo7XcCF7/RMN/HvUjOwe2XANHmyliMhUoumxd9Q5AsfSoOZYwg4Xqu2ltVmA4=
X-Received: by 2002:a19:c6c5:: with SMTP id w188mr13672563lff.65.1589274796910;
 Tue, 12 May 2020 02:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200509031919.9006-1-steves.lee@maximintegrated.com> <20200511110346.GE8216@sirena.org.uk>
In-Reply-To: <20200511110346.GE8216@sirena.org.uk>
From:   Steve Lee <steves.lee.maxim@gmail.com>
Date:   Tue, 12 May 2020 18:13:05 +0900
Message-ID: <CABff4NQXs622x1X6ZvNABHNZoTMS57f4Y5sdo1Cng3JeTgboCw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: max98390: Added Amplifier Driver
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, geert@linux-m68k.org,
        rf@opensource.wolfsonmicro.com, shumingf@realtek.com,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        krzk@kernel.org, dmurphy@ti.com, jack.yu@realtek.com,
        nuno.sa@analog.com, steves.lee@maximintegrated.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        ryan.lee.maxim@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 8:03 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Sat, May 09, 2020 at 12:19:19PM +0900, Steve Lee wrote:
> > Signed-off-by: Steve Lee <steves.lee@maximintegrated.com>
>
> This looks mostly good, a few smallish things below though:
>
> > +++ b/sound/soc/codecs/max98390.c
> > @@ -0,0 +1,1039 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2020, Maxim Integrated.
> > + */
>
> Please make the entire comment a C++ one so things look more
> intentional.
Thank you for feedback.
Modified as requested.
>
> > +     dev_info(component->dev, "Tdm mode : %d\n",
> > +                     max98390->tdm_mode);
>
> This is a bit noisy, please make it at most a dev_dbg().
>
> > +static const char * const max98390_analog_gain_text[] = {
> > +     "Mute", "3dB", "6dB", "9dB", "12dB", "15dB", "18dB"};
>
> Use TLV data with regulator Volume controls for volumes, don't make them
> enums.
>
Remove enums and use TLV.
> > +static const char * const max98390_boost_voltage_text[] = {
> > +     "6.5V", "6.625V", "6.75V", "6.875V", "7V", "7.125V", "7.25V", "7.375V",
> > +     "7.5V", "7.625V", "7.75V", "7.875V", "8V", "8.125V", "8.25V", "8.375V",
> > +     "8.5V", "8.625V", "8.75V", "8.875V", "9V", "9.125V", "9.25V", "9.375V",
> > +     "9.5V", "9.625V", "9.75V", "9.875V", "10V"
> > +};
>
> Is this really something that should be configured at runtime rather
> than through DT?
Since this control is needed while running system according to system
battery situation.
I'd keep this mixer for further use.
>
> > +static const char * const max98390_current_limit_text[] = {
> > +     "0.00A", "0.50A", "1.00A", "1.05A", "1.10A", "1.15A", "1.20A", "1.25A",
> > +     "1.30A", "1.35A", "1.40A", "1.45A", "1.50A", "1.55A", "1.60A", "1.65A",
>
> This looks like it should be in DT too.
Since this control  is needed while running system according to system
battery situation.
I'd keep this mixer for further use.
>
> > +static int max98390_dsm_calib_get(struct snd_kcontrol *kcontrol,
> > +             struct snd_ctl_elem_value *ucontrol)
> > +{
> > +     struct snd_soc_component *component =
> > +             snd_soc_kcontrol_component(kcontrol);
> > +
> > +     dev_warn(component->dev, "Get dsm_calib_get not supported\n");
> > +
> > +     return 0;
> > +}
>
> Just don't implement the operation if you can't implement it.
If this not exist as dummy operation and all mixer was not working and
could not implement better idea.
Could you consider it as with warn message ?
>
> > +     dev_info(component->dev,
> > +             "max98390: param fw size %d\n",
> > +             fw->size);
>
> This should probably be a dev_dbg() too.
Modified as requested.
>
> > +     /* Amp Setting */
> > +     regmap_write(max98390->regmap, MAX98390_CLK_MON, 0x6f);
> > +     regmap_write(max98390->regmap, MAX98390_PCM_RX_EN_A, 0x03);
> > +     regmap_write(max98390->regmap, MAX98390_R203D_SPK_GAIN, 0x05);
> > +     regmap_write(max98390->regmap, MAX98390_MEAS_EN, 0x03);
> > +     regmap_write(max98390->regmap, MAX98390_PWR_GATE_CTL, 0x2d);
> > +     regmap_write(max98390->regmap, MAX98390_ENV_TRACK_VOUT_HEADROOM, 0x0e);
> > +     regmap_write(max98390->regmap, MAX98390_BOOST_BYPASS1, 0x46);
> > +     regmap_write(max98390->regmap, MAX98390_FET_SCALING3, 0x03);
>
> Are some of these things that might vary per system?  If so they
> probably shouldn't be hard code but instead in DT.  Things like the
> speaker gain jump out.
I removed hard-coded Volume setting.
>
> > +static int max98390_suspend(struct device *dev)
> > +{
> > +     struct max98390_priv *max98390 = dev_get_drvdata(dev);
> > +
> > +     dev_info(dev, "%s:Enter\n", __func__);
>
> dev_dbg()
Modified as requested.
>
> > +static int max98390_resume(struct device *dev)
> > +{
> > +     struct max98390_priv *max98390 = dev_get_drvdata(dev);
> > +
> > +     dev_info(dev, "%s:Enter\n", __func__);
>
> dev_dbg()
Modified as requested.
>
> > +     dev_info(&i2c->dev, "ASoC: MAX98390 i2c probe\n");
>
> Just drop this.
Removed.
>
> > +     ret = device_property_read_u32(&i2c->dev, "maxim,temperature_calib",
> > +                                    &max98390->ambient_temp_value);
>
> Normally for DT that'd be maxim,temperature-calib.
This is follow as coreboot in Chromium OS case.
I'd follow this name unchanged.
