Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D64C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 23:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 701D7206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 23:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hymJOGYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390803AbgDOX5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 19:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389935AbgDOX52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 19:57:28 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1DBC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 16:57:26 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b8so784356pfp.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 16:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g+3cVFHINQK8034Q5fMosJmLqjR0x/8UAQMOjZSVJrM=;
        b=hymJOGYOl8wyGrt54ea9ETuKrBuw+wFtIDoosE9VbbTh3G2do1iFapNRgpRzht7cF+
         1h4tsTDnwoUY7vgAf0B6t9n+FyslLxRcQhLeXANSqSnY1BwHGWOO/CGr+ch7TrC7Y1be
         poo1PAE0JVXRF1RDYuyH/o1HSC4r+3OiFuCMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g+3cVFHINQK8034Q5fMosJmLqjR0x/8UAQMOjZSVJrM=;
        b=lVlUu/2apbWMJRFZUQqgIgCG8K9kVSrww963019qHqvL2gqSpplOXKSSXO1vCok1t2
         4tWmRhzEo46Y6w7tTLUEz21Arxkjb1Ueamm21Z8Dcr4dLccwgORJkA/A8kEBsKR8kXOp
         TnKsW2FeLufhFtso9BQY7zGLqtkFIhz9kE04ZvEsebK7YBmsxeghI4M86Wa6K7kycn7t
         NhS358mCuxvJkaAHktOBc1hkTjhIVLZIgCvlhRoWgJUcwXKr+0xtjyHlMwp6nvbOPX4E
         r8m37tqxzMQDrV/ARrxvgLK9bdo4UW1ZFUNaySzsrOhLq3LPdQ3U4R4tL+lipgo8SoNT
         xoaw==
X-Gm-Message-State: AGi0PuYno5lhoDRgE28FOUhOJkYHVRiFFYr7xi8kBXeHP9Vyzh3FJKYj
        lIooW95S9BCGJ5zummWWnv7xYyoFz3I=
X-Google-Smtp-Source: APiQypKWVV1a5GTXBrMkuWqfChPLPkaFl4PHItUYIOhi4bCVaK+dhr2OHCRzP1xRP9ShWZghQVmikQ==
X-Received: by 2002:a63:214a:: with SMTP id s10mr16293084pgm.98.1586995046059;
        Wed, 15 Apr 2020 16:57:26 -0700 (PDT)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com. [209.85.214.174])
        by smtp.gmail.com with ESMTPSA id h27sm323934pgb.90.2020.04.15.16.57.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 16:57:25 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id g2so661405plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 16:57:25 -0700 (PDT)
X-Received: by 2002:a67:1e46:: with SMTP id e67mr7126201vse.106.1586994551498;
 Wed, 15 Apr 2020 16:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200415084758.1.Ifcdc4ecb12742a27862744ee1e8753cb95a38a7f@changeid>
 <20200415084758.2.Ic98f6622c60a1aa547ed85781f2c3b9d3e56b734@changeid>
 <158698038289.105027.2860892334897893887@swboyd.mtv.corp.google.com> <20200415203256.GP4758@pendragon.ideasonboard.com>
In-Reply-To: <20200415203256.GP4758@pendragon.ideasonboard.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 15 Apr 2020 16:49:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U1U7y_U4+zySzA9e_uYE0ECdM1Bd-ew0OxG3ciqjRVSA@mail.gmail.com>
Message-ID: <CAD=FV=U1U7y_U4+zySzA9e_uYE0ECdM1Bd-ew0OxG3ciqjRVSA@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: drm/bridge: ti-sn65dsi86: Add hpd-gpios
 to the bindings
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Panda <spanda@codeaurora.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 15, 2020 at 1:33 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Wed, Apr 15, 2020 at 12:53:02PM -0700, Stephen Boyd wrote:
> > Quoting Douglas Anderson (2020-04-15 08:48:40)
> > > Allow people to specify to use a GPIO for hot-plug-detect.  Add an
> > > example.
> > >
> > > NOTE: The current patch adding support for hpd-gpios to the Linux
> > > driver for hpd-gpios only adds enough support to the driver so that
> > > the bridge can use one of its own GPIOs.  The bindings, however, are
> > > written generically.
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > >
> > >  .../bindings/display/bridge/ti,sn65dsi86.yaml          | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
> > > index 8cacc6db33a9..554bfd003000 100644
> > > --- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
> > > +++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
> > > @@ -60,6 +60,10 @@ properties:
> > >      const: 1
> > >      description: See ../../pwm/pwm.yaml for description of the cell formats.
> > >
> > > +  hpd-gpios:
> > > +    maxItems: 1
> > > +    description: If present use the given GPIO for hot-plug-detect.
> >
> > Shouldn't this go in the panel node? And the panel driver should get the
> > gpio and poll it after powering up the panel? Presumably that's why we
> > have the no-hpd property in the simple panel binding vs. putting it here
> > in the bridge.
>
> Same question really, I think this belongs to the panel (or connector)
> node indeed.

Hrm.

To me "no-hpd" feels OK in the panel because the lack of a connection
is somewhat symmetric.  Thus it's OK to say either "HPD isn't hooked
up to the panel in this system" or "HPD isn't hooked up to the bridge
in this system" and both express the same thing (AKA that there is no
HPD connection between the bridge and the panel).  In the case of
"no-hpd" it's more convenient to express it on the panel side because
the panel driver is the one whose behavior has to change if HPD isn't
hooked up.  The panel datasheet is the one that says how long of a
delay we need if HPD isn't hooked up.

...but when you're talking about where the bridge driver should look
to find the HPD signal that it needs, that really feels like it should
be described as part of the bridge.  Specifically imagine we were
using our bridge for DP, not for eDP.  In that case simple-panel
wouldn't be involved because we could get any type of display plugged
in.  Thus it couldn't go in the panel node.  Here it feels clearer
that hpd-gpio needs to be a property of the bridge driver.

Looking at other usages of "hpd-gpio" in the kernel, it seems like the
usage I'm proposing is also common.  Grepping for "hpd-gpios" shows
numerous examples of "hpd-gpios" being defined at the display
controller level and (effectively) I believe the bridge is at the
equivalent level.


-Doug
