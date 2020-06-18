Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6F6C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 22:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37A1A208B3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 22:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lVrFJvl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbgFRWJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 18:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731675AbgFRWJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 18:09:31 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCB5C0613EF
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 15:09:29 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id r5so1927689vso.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 15:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rIJ2X6dOzoq0wY6kg8iKEYYmkTTN8+C1IDuvViUAAlw=;
        b=lVrFJvl5mDjocLA105kchQDYwRR/Mq9nlcXy/owwADieAZYgAuGsjK3xpftm0NXclu
         BDh1QPoJU1TPpXMWq0DmrgoRSIGzBPlrIy8he0In3LWP8m83XqE+r0HZadf/sXAFVj2e
         IayO8IVxHmcZK2mLywOzCBqLmikiRhPA0Z8ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rIJ2X6dOzoq0wY6kg8iKEYYmkTTN8+C1IDuvViUAAlw=;
        b=mNbhDWgB/LrL/Z8p3Ol8NCZTH7ktGhphkHxSyLGnpkbUilkw/yQyJhQ3JCaBUwWb5J
         XPlGxogeDO4lMI56M0EQw9PwU9NXZ+uxNB2TnaF8VVrp6DFjgWT6AQ5UOpuXe9PAzjiQ
         rhxsPGO9iEg+ryRUSiXE6pPn8lKalnz5dMZAQH84OEBsD67xnWkLcBkEQyDS+cJzAzKb
         0mG5jT3z5PnZoqRcJyr7QFPmxYDU6zhXLCz3KXqMaQjDfjOMEqEREj8yyLbFkDVkO6Ce
         mE2dvATPAUyBlais25sdSm/GW3pX4i4LbkQCEeDyfw1h0w/7u4tAH4QyX+8OI4hApHju
         lvEg==
X-Gm-Message-State: AOAM5314Pc599wv6f3+rt+4kFAvm0liGctc4+29Ok82aW2NXdbtZXC3b
        34OQ/3fIxgVQDeFc5BhNMTg1NSCWHZ0=
X-Google-Smtp-Source: ABdhPJypfXN8JATWp43sgdPidltYpOIjrL1QYkXkFt2SAlaKvXjksWMXu3WO1qlLEifhOyITgln5NA==
X-Received: by 2002:a67:fb52:: with SMTP id e18mr5238585vsr.168.1592518167463;
        Thu, 18 Jun 2020 15:09:27 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id j15sm472421vsd.19.2020.06.18.15.09.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 15:09:25 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id w20so2532485uaa.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 15:09:25 -0700 (PDT)
X-Received: by 2002:a9f:3b1c:: with SMTP id i28mr501831uah.22.1592518164952;
 Thu, 18 Jun 2020 15:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200609120455.20458-1-harigovi@codeaurora.org>
In-Reply-To: <20200609120455.20458-1-harigovi@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 18 Jun 2020 15:09:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XHHAAWNkJGMJESf4C=hcbaswFamGVeyMJ9eRd6dWAy8Q@mail.gmail.com>
Message-ID: <CAD=FV=XHHAAWNkJGMJESf4C=hcbaswFamGVeyMJ9eRd6dWAy8Q@mail.gmail.com>
Subject: Re: [v3] drm/bridge: ti-sn65dsi86: ensure bridge suspend happens
 during PM sleep
To:     Harigovindan P <harigovi@codeaurora.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>, nganji@codeaurora.org,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 9, 2020 at 5:05 AM Harigovindan P <harigovi@codeaurora.org> wrote:
>
> ti-sn65dsi86 bridge is enumerated as a runtime device. When
> suspend is triggered, PM core adds a refcount on all the
> devices and calls device suspend, since usage count is
> already incremented, runtime suspend will not be called
> and it kept the bridge regulators and gpios ON which resulted
> in platform not entering into XO shutdown.
>
> Add changes to force suspend on the runtime device during pm sleep.
>
> Signed-off-by: Harigovindan P <harigovi@codeaurora.org>
> ---
>
> Changes in v2:
>         - Include bridge name in the commit message and
>         remove dependent patchwork link from the commit
>         text as bridge is independent of OEM(Stephen Boyd)
>
> Changes in v3:
>         - Updating changelog to explain the need for patch
>
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 ++
>  1 file changed, 2 insertions(+)

I think this patch is good to go now (has both Stephen's and my
reviews).  I noticed that Neil landed my other patches to this driver
recently (thanks!) and wondered why he didn't land this one.  Then, I
realized that you didn't send it to him or the other bridge
maintainer.  :(  Have you tried running get_maintainer?

$ ./scripts/get_maintainer.pl -f drivers/gpu/drm/bridge/ti-sn65dsi86.c
Andrzej Hajda <a.hajda@samsung.com> (maintainer:DRM DRIVERS FOR BRIDGE CHIPS)
Neil Armstrong <narmstrong@baylibre.com> (maintainer:DRM DRIVERS FOR
BRIDGE CHIPS)
Laurent Pinchart <Laurent.pinchart@ideasonboard.com> (reviewer:DRM
DRIVERS FOR BRIDGE CHIPS)
Jonas Karlman <jonas@kwiboo.se> (reviewer:DRM DRIVERS FOR BRIDGE CHIPS)
Jernej Skrabec <jernej.skrabec@siol.net> (reviewer:DRM DRIVERS FOR BRIDGE CHIPS)
David Airlie <airlied@linux.ie> (maintainer:DRM DRIVERS)
Daniel Vetter <daniel@ffwll.ch> (maintainer:DRM DRIVERS)
dri-devel@lists.freedesktop.org (open list:DRM DRIVERS)
linux-kernel@vger.kernel.org (open list)

In any case, unless someone has extra feedback on this patch I think
it's ready to land.

Neil: If you're willing to land this patch too, can you let
Harigovindan know if it needs to be re-sent with you in the "To:" list
or if you can find it on the dri-devel list?

Thanks!

-Doug
