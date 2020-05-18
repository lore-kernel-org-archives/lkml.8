Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF2CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BAC820671
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="li91YZRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387531AbgERSJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733129AbgERSGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:06:13 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9130AC05BD0A
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:06:13 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id u79so2810260vsu.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c3UXUPcrt3P6Bgw39Gw3bWHJNGcf+91G7bjcoOjFILM=;
        b=li91YZRk4xYKI9MXE0tWUzbZMwcWG60O5oELkyNKU4sTYVNPY20T5Tu/2C4PXO0pSb
         metKaUg3abydKAsYDkjq5QAPkQqK7PqGeCwzCrjMqbAJG1JvjKQ0vB5xZdrqIZcj7Gph
         UoleVSIHc/fp4FoD48l5IFZcAOxm20aQrn4GE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c3UXUPcrt3P6Bgw39Gw3bWHJNGcf+91G7bjcoOjFILM=;
        b=OuHfydW4tb8zEeE/uPIxfnRggWUzQsEF2Tv1XB38J1Em7oMkdHJc94xwNuEdBvb6hS
         c19bxFwhOE5o8J3suc86NWoTjqYnsg5bHSBlmcLHhEq3ve+CZwsISzsBxreovAcL0yhd
         U4QwH+BOOmkk6sOifs/bAiklZLKisLyPdgkPEnIlS4PyS+SDS+pF3gzWcQzK5hK+Vi6b
         jpjV5qgDD6l+1w4DW7IteyZGbBLBn0t/Kpaj1pTTv+ozvLaEYjn8fIY2oxe+BWx9jQdp
         9W9vyyqBuv2uoqIEwNw7GD3OL5rmPE6J4a4WgcEtn9aYk0+CK496WzL/H6OPSrwMvkKL
         Jr7g==
X-Gm-Message-State: AOAM530ORXkLgP36Tk70RJxzCeigSWIzUr3ek9lPteuD13yi/SLQx9nr
        Ptx3l+My6uAFvTktJu2bOeFmIBtXd5E=
X-Google-Smtp-Source: ABdhPJw7QxNHkkwCo84ZJN9+UIYjkfJHIO+8sl7f80GMpWxqD/Zq+TIsQawdZvmkDb81fLqobsIpnQ==
X-Received: by 2002:a67:69ca:: with SMTP id e193mr11642947vsc.19.1589825172561;
        Mon, 18 May 2020 11:06:12 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id m25sm1910231vsr.7.2020.05.18.11.06.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 11:06:11 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id l15so4280928vsr.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:06:10 -0700 (PDT)
X-Received: by 2002:a1f:4e46:: with SMTP id c67mr11262026vkb.92.1589825169814;
 Mon, 18 May 2020 11:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200507213500.241695-1-dianders@chromium.org>
 <20200509201511.GD30802@ravnborg.org> <CAD=FV=VBU7JmTdvgWjyj_ytrFmz6Gkx2OjVr1FxLh9DBG_jN6w@mail.gmail.com>
 <CAD=FV=UNuwb+YYJKw9+HNMKUNfuNFxj+Gr+yB9tXANbXAvDgCg@mail.gmail.com> <20200518175939.GA770425@ravnborg.org>
In-Reply-To: <20200518175939.GA770425@ravnborg.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 18 May 2020 11:05:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XmUrF3nCZF4dDom5RrWrdVe-iJocenU3cJEDx-gGkDRA@mail.gmail.com>
Message-ID: <CAD=FV=XmUrF3nCZF4dDom5RrWrdVe-iJocenU3cJEDx-gGkDRA@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] drm: Prepare to use a GPIO on ti-sn65dsi86 for Hot
 Plug Detect
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     LinusW <linus.walleij@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Sandeep Panda <spanda@codeaurora.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Gross <agross@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sam,

On Mon, May 18, 2020 at 10:59 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Douglas.
>
> > > Given the previous feedback from Linus W, Stephen, and Laurent I
> > > expect things are good enough to land now, but it'd be good to get
> > > confirmation (I removed some of the previous tags just to get
> > > confirmation).  If we can get review tags early next week maybe it'll
> > > still be in time to land for 5.8?
> >
> > I think all the others have reviews now.  Is there anything blocking
> > them from getting applied?
> Applied, including the small fix pointed out by Linus.

Thanks!  Ugh, I just realized what the problem was.  I posted a v6
with this fix but insanely somehow didn't CC you (!!!).  It was here:

https://lore.kernel.org/r/20200513215902.261547-1-dianders@chromium.org

I'm super sorry about that and thanks for fixing the nit.  That was
the only difference between v5 and v6.  I just checked what you pushed
and it looks great, thank you.

-Doug
