Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A670C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31986206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JwFAosiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgFKOfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbgFKOfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 10:35:03 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12EAC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 07:35:01 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id p187so1512556vkf.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 07:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eYtkvOUUq+F5r82ywOVrxc+PmLG4PLG1lF6L9X8WFAQ=;
        b=JwFAosiRGgcrMccXp1IcrdjBYmsOftrJJLrKaDYIaNTLD9IBnNdJ/9+Ge95yVw1pJa
         eF10R5r9IN/uc14Ot157EujMysw2LUwRvzGGFjvQj442e3rJwy2e5HV86KQ59kiP6wuB
         K6NfRIJ5BQPDixgmT9dpTvt1o6OnC0PEQk1t8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eYtkvOUUq+F5r82ywOVrxc+PmLG4PLG1lF6L9X8WFAQ=;
        b=e1pvzZE/tBzt1DGhH7i/zmZCqCRNbDb3/PZEI5Zc7T5eEy9Utrki5yWXZIo3I9p7UQ
         /MI1Sk9U+l2I6X+g46sFqXayvoEhxGN1TBCALvaJCnKtJ5+r+O3E24Y0C/GDJ9iHd+sD
         hCYPQl3JI3X7to4FjSDmLzUlzVJaLU3teVupT6niJ66t+dtn4QB/bZyjepVmULt64Ob0
         JN7fpVRmjia5tp8fkWgtDoULxNdLEO3luN6xRP7YnAvXjlgOASBOQ3OJuXfvS6QPT0di
         xu7cq9Uym7crr1uKOPjJcmYKrJlK2jpKjTGrGNuumjmRJnDmuqLmvHy3vrAgCYs3dydb
         oFTA==
X-Gm-Message-State: AOAM530PayD/KbIQTzqGsnPBmcwbVUZOhIupliM0Q+uvqnybDTpeRzG6
        qkJFh2NIgHSG4/MxXkDp/9IqKHFqkAc=
X-Google-Smtp-Source: ABdhPJyR5Tbqt6MRdlIaXrUjxtYeXqVnusdrlmuvYI0q+4YdgrWDOuZ4LA3ddHvWgwsEBxcdPd13gQ==
X-Received: by 2002:a1f:205:: with SMTP id 5mr6427117vkc.32.1591886100712;
        Thu, 11 Jun 2020 07:35:00 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id t2sm462265vka.28.2020.06.11.07.34.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 07:34:59 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id d21so3483841vsh.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 07:34:59 -0700 (PDT)
X-Received: by 2002:a05:6102:20c8:: with SMTP id i8mr7101389vsr.106.1591886098468;
 Thu, 11 Jun 2020 07:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200608104832.1.Ibe95d8f3daef01e5c57d4c8c398f04d6a839492c@changeid>
 <20200608104832.4.Ia4376fd88cdc6e8f8b43c65548458305f82f1d61@changeid> <159186950406.242598.11120838219466948342@swboyd.mtv.corp.google.com>
In-Reply-To: <159186950406.242598.11120838219466948342@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 11 Jun 2020 07:34:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xt8AdnemnKLgxwkC-W=LWC06OU9x20RszXPLfAvUm9Og@mail.gmail.com>
Message-ID: <CAD=FV=Xt8AdnemnKLgxwkC-W=LWC06OU9x20RszXPLfAvUm9Og@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/bridge: ti-sn65dsi86: Check the regmap return
 value when setting a GPIO
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sandeep Panda <spanda@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 11, 2020 at 2:58 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Douglas Anderson (2020-06-08 10:48:35)
> > The ti_sn_bridge_gpio_set() got the return value of
> > regmap_update_bits() but didn't check it.  The function can't return
> > an error value, but we should at least print a warning if it didn't
> > work.
> >
> > This fixes a compiler warning about setting "ret" but not using it.
> >
> > Fixes: 27ed2b3f22ed ("drm/bridge: ti-sn65dsi86: Export bridge GPIOs to Linux")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > index 1080e4f9df96..526add27dc03 100644
> > --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > @@ -999,6 +999,9 @@ static void ti_sn_bridge_gpio_set(struct gpio_chip *chip, unsigned int offset,
> >         ret = regmap_update_bits(pdata->regmap, SN_GPIO_IO_REG,
> >                                  BIT(SN_GPIO_OUTPUT_SHIFT + offset),
> >                                  val << (SN_GPIO_OUTPUT_SHIFT + offset));
> > +       if (ret)
> > +               dev_warn(pdata->dev,
> > +                        "Failed to set bridge GPIO %d: %d\n", offset, ret);
>
> GPIO %u because it's unsigned?

Sure.  I'll plan to spin tomorrow in case anyone else has any
feedback.  If any maintainer would prefer me not to spin and would
rather fix this when applying, please shout and I won't send out a v2.

-Doug
