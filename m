Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA0DC83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 593B22073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mc66UOQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgD2QdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726511AbgD2QdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 12:33:12 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E4BC03C1AE;
        Wed, 29 Apr 2020 09:33:12 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id c2so2888218iow.7;
        Wed, 29 Apr 2020 09:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xrYwlO7xNNj9fkAP9oHGsbabPQftzUzMxzOAeS45YvA=;
        b=Mc66UOQw3PSrCzfUt6SnAmBJoNfERd9Wgtuu4ajltmzI21Ad5iqV7T71c8OI9Ovx1v
         UxxzA7h0TGO5GWL2VglyGBffnr0d9cScTY/ANtdLj0LwQo17VUHpUGaHhYFzDP/1b7BU
         BfZr9vzg7bEQgtQESFGg168Xj7ZbCChxBeJCm2xCHo5xHMwqcMWh7EjbdDjwYLXpiWdZ
         WTO4n9KOYAOMQ2e2FzTKWPrQn/hqw7ZzpvEdmn8h8jKEvVkwydzGC1PJkMhEo1I34irb
         w4g4l2QH3Po8cb4YZCx2yMeR8mEoalay7vXdec9wI4PhU7O8tihJA0koPXKOOtxaarIq
         JCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xrYwlO7xNNj9fkAP9oHGsbabPQftzUzMxzOAeS45YvA=;
        b=WdPlFEKgH2s7a07g2m9dMZ8IEkvKkFEW+dG3TWMhm+BeAD2eK//i9j2p+jtbaN3jYW
         lRp3/b0vBL+5e0d2hssWWbnemma0dGQfSDMSd6fIua+7vlsYRIphytwW5uNrCS05O8kc
         mUc6upGo18DAjDS1egZK3MVIcNOrBAHZGiPdrNF5n70Dl9Z3z8e0wv0rftx6vaatXpon
         JE7vRTsms5n98zogR/5vIq+Qb1vfUedBMYembnirYf7ooVHW60FdFErmFMORmOCHWv3e
         fpB4DHLrUeSkcpMKD9nlqWg1n31OUJhzIBvQwAQDbKQK0140B3cYPFSnP1P9Y0X2dZW8
         fyVw==
X-Gm-Message-State: AGi0PubTZRecdgfupUO+qJBG7xhZtMBpUtm7dQ4sWw/csCRJLnlYgv6G
        cwmZbQu8mj2mZ6XkkdD20Yb9pLinxVHK7keUGCk=
X-Google-Smtp-Source: APiQypKu3/he3vcgwJi5RApDarGi5QWrtRiRJCHqu6zQTJlBLBWHScAvv0k9XsP7FCPb/0GQhJgoWCNAfwSwS562ako=
X-Received: by 2002:a05:6602:2fcd:: with SMTP id v13mr30928449iow.124.1588177991512;
 Wed, 29 Apr 2020 09:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200426104115.22630-1-peron.clem@gmail.com> <20200426104115.22630-4-peron.clem@gmail.com>
 <20200428081321.ht3el26yqhsnyfm4@gilmour.lan> <CAJiuCcdVs_drs40Q6537BYfz24F7NmC6B8S5-Lt4V4ggs-FXWA@mail.gmail.com>
 <20200429123529.y24dpy63wxq7uvkt@gilmour.lan>
In-Reply-To: <20200429123529.y24dpy63wxq7uvkt@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Wed, 29 Apr 2020 18:33:00 +0200
Message-ID: <CAJiuCcfXqizcq_JuXRCsqEqM2562cr1SGJ0pmy07jcJxAXojOw@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] ASoC: sun4i-i2s: Add support for H6 I2S
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Marcus Cooper <codekipper@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Wed, 29 Apr 2020 at 14:35, Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Tue, Apr 28, 2020 at 10:55:47AM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > > > +static int sun50i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
> > > > +                              unsigned int fmt)
> > >
> > > The alignment is off here
> > >
> > > > +{
> > > > +     u32 mode, val;
> > > > +     u8 offset;
> > > > +
> > > > +     /*
> > > > +      * DAI clock polarity
> > > > +      *
> > > > +      * The setup for LRCK contradicts the datasheet, but under a
> > > > +      * scope it's clear that the LRCK polarity is reversed
> > > > +      * compared to the expected polarity on the bus.
> > > > +      */
> > >
> > > Did you check this or has it been copy-pasted?
> >
> > copy-pasted, I will check this.
>
> It's not going to be easy to do this if you only have a board with HDMI. =
If you
> can't test that easily, just remove the comment (or make it explicit that=
 you
> copy pasted it?), no comment is better than a wrong one.

I have talked with Marcus Cooper it may be able to test this this week-end.
Also this can explain why we need the "
simple-audio-card,frame-inversion;" in the device-tree.

If think this fix has been introduced by you, correct? Could you say
on which SoC did you see this issue?

Thanks
Clement

>
> Maxime
