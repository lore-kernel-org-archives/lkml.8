Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD11AC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 23:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D01C2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 23:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g6YAWj8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDVXbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 19:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgDVXbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 19:31:41 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E0DC03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 16:31:39 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id z12so3758356ilb.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 16:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B8O4jZZ0F/lKKEmFhigDjMargZ9Oe/sGTpY3jxbERg0=;
        b=g6YAWj8Rl4wNYrHXCFnvgpS/qKcZ6sNQqPWJC59bEGMOh6CTaKDsZsSYquknIynQKx
         9kR7v1Fl1Ww0KgiTWTQA3W8eDSyvsifBsdu4Bswt92/dhZWFT1+nIy0NiP9pBWsPb2jV
         ttnFfVqNh3pNxDE3IHIwvyTx06E+ADiSx+gF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B8O4jZZ0F/lKKEmFhigDjMargZ9Oe/sGTpY3jxbERg0=;
        b=fzbDeR071nn4pMs5oUfcQGX7fKdawMdi1AlMdt22M6r2CA80+q06WfWb5BidcBzDkr
         LKM9rRPzY6lX23wYxE102jmk761FiB+0AD++FkbxL7rgCOx3DAXfhFMGKQtgM3CScvp+
         SKhyAUehwSCnXmsaXqrMBA0i2YogclSV8cjYCJHH9wSScB5e7ZWe5DkYbh3a0ngObBTD
         y2vjkxf1UXd8Pt1SrYTA2Jao+wftrle/nOwq0o8fbcVfrG9o3oLioJNmbN31VPCDjmOz
         omyePmYkxVx7Q0fsj9a2tXvd6h5P4ONrtG5XqyeCceRM0BG5xzyS8RAD8smppuJYmDbY
         Zwzw==
X-Gm-Message-State: AGi0Pua++KSapaoxYanwUr8FIzCgcuWSM5L5hAcj1CqS9EBRFvcAH6ya
        ikPL9YaKWoLiendWnmbF/VHP5mUuRwc=
X-Google-Smtp-Source: APiQypLPNnv723+8shbTpOI6PiL0fxumhUJcFJ69iRBbB9gT5CrzHdn6Vo7tAdCYngg6x4gNVsfqxw==
X-Received: by 2002:a92:8350:: with SMTP id f77mr837339ild.257.1587598298619;
        Wed, 22 Apr 2020 16:31:38 -0700 (PDT)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com. [209.85.166.46])
        by smtp.gmail.com with ESMTPSA id q29sm253452ill.65.2020.04.22.16.31.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 16:31:36 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id k6so4452429iob.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 16:31:36 -0700 (PDT)
X-Received: by 2002:a6b:2b91:: with SMTP id r139mr1178830ior.61.1587598296099;
 Wed, 22 Apr 2020 16:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200421050622.8113-1-dianders@chromium.org> <20200420220458.v2.1.Ia50267a5549392af8b37e67092ca653a59c95886@changeid>
 <158755100643.159702.17904334834962681759@swboyd.mtv.corp.google.com>
 <CAD=FV=WJONhm4ukwZa2vGtozrz_SmLuTCLxVimnGba7wRPPzgQ@mail.gmail.com> <158758963395.230545.16210525372433383386@swboyd.mtv.corp.google.com>
In-Reply-To: <158758963395.230545.16210525372433383386@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 22 Apr 2020 16:31:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UeZS94rgmjBDUfgt3B5f9WkAy-7jrLAcNCe-v4nZB_fg@mail.gmail.com>
Message-ID: <CAD=FV=UeZS94rgmjBDUfgt3B5f9WkAy-7jrLAcNCe-v4nZB_fg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] drm/bridge: ti-sn65dsi86: Export bridge GPIOs to Linux
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>, bgolaszewski@baylibre.com,
        Daniel Vetter <daniel@ffwll.ch>,
        LinusW <linus.walleij@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Panda <spanda@codeaurora.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        =?UTF-8?Q?open_list=3AGPIO_SUBSYSTEM_=3Clinux=2Dgpio=40vger=2Ekernel=2Eorg=3E=2C_linux?=
         =?UTF-8?Q?=2Darm=2Dmsm_=3Clinux=2Darm=2Dmsm=40vger=2Ekernel=2Eorg=3E=2C_dri=2Ddevel_=3Cdri=2Ddev?=
         =?UTF-8?Q?el=40lists=2Efreedesktop=2Eorg=3E=2C_open_list=3AOPEN_FIRMWARE_AND_FLATT?=
         =?UTF-8?Q?ENED_DEVICE_TREE_BINDINGS_=3Cdevicetree=40vger=2Ekernel=2Eorg=3E=2C_Jern?=
         =?UTF-8?Q?ej_Skrabec_=3Cjernej=2Eskrabec=40siol=2Enet=3E=2C_Bjorn_Andersson_=3Cbjorn?=
         =?UTF-8?Q?=2Eandersson=40linaro=2Eorg=3E=2C_Rob_Clark_=3Crobdclark=40chromium=2Eorg=3E=2C_?=
         =?UTF-8?Q?LKML?= <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 22, 2020 at 2:07 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Doug Anderson (2020-04-22 09:09:17)
> > Hi,
> >
> > On Wed, Apr 22, 2020 at 3:23 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Douglas Anderson (2020-04-20 22:06:17)
> > >
> > > > Changes in v2:
> > > > - ("Export...GPIOs") is 1/2 of replacement for ("Allow...bridge GPIOs")
> > > >
> > > >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 165 ++++++++++++++++++++++++++
> > > >  1 file changed, 165 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > > > index 6ad688b320ae..d04c2b83d699 100644
> > > > --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > > > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > > > @@ -874,6 +886,153 @@ static int ti_sn_bridge_parse_dsi_host(struct ti_sn_bridge *pdata)
> > > >         return 0;
> > > >  }
> > > >
> > > > +static struct ti_sn_bridge *gchip_to_pdata(struct gpio_chip *chip)
> > > > +{
> > > > +       return container_of(chip, struct ti_sn_bridge, gchip);
> > > > +}
> > > > +
> > > > +static int ti_sn_bridge_gpio_get_direction(struct gpio_chip *chip,
> > > > +                                          unsigned int offset)
> > > > +{
> > > > +       struct ti_sn_bridge *pdata = gchip_to_pdata(chip);
> > > > +
> > > > +       return (atomic_read(&pdata->gchip_output) & BIT(offset)) ?
> > >
> > > Any reason this isn't a bitmap?
> >
> > Don't bitmaps need an external lock to protect against concurrent
> > access?
>
> Bitmaps are sometimes atomic. See Documentation/atomic_bitops.txt for
> more info. From what I see here it looks like we can have a bitmap for
> this and then use set_bit(), test_and_set_bit(), etc. and it will be the
> same and easier to read.

Hrm.  Somehow I found the wrong place when trying to search for this
previously.  Thanks for pointing me in the right directions.  Much
nicer.


> > When I looked I wasn't convinced that the GPIO subsystem
> > prevented two callers from changing two GPIOs at the same time.  See
> > below for a bigger discussion.
> >
> >
> > > > +               GPIOF_DIR_OUT : GPIOF_DIR_IN;
> > >
> > > And why can't we read the hardware to figure out if it's in output or
> > > input mode?
> >
> [...]
> >
> > In the next version of the patch I'll plan to add a kerneldoc comment
> > to "struct ti_sn_bridge" and add a summary of the above for
> > "gchip_output".
>
> Yeah it deserves a comment in the code indicating why it doesn't read
> the hardware.

OK, added a whole bunch more comments.

Barring something coming up, I'll plan to send v3 tomorrow morning
with all your feedback addressed.  If anyone wants me to wait because
they think I need some more major change, please yell.


-Doug
