Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501EAC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3037E20728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hwQepM/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgDXMMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgDXMMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:12:16 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B625C09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 05:12:16 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id 36so5081481uaf.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 05:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h0z5ld1WSv+uCtbs/DgylXlcT9i3DCsdVOPXc/hPY7o=;
        b=hwQepM/bXpUDZkqdGyGGTFFGFNmGx+VGOU1xAn2w6kWh7TpIs1TVzUvC7Y8WfV5Avv
         eBW9GDKE1srlE8pjEXdpZU4tXNiz4H7u5pefQcy0FulLXzcxvs79P05uhucqMfCVMQYQ
         7XujRwL1+db0Xik9NlNhqzowuqaVg69dHl2J8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h0z5ld1WSv+uCtbs/DgylXlcT9i3DCsdVOPXc/hPY7o=;
        b=OMxlyFhXMZlydlOjy7VDfOHfkh87HjkhUzQP3UX5rxm66PzGTHB3ML+aTPlt0/e4zD
         23h1WFYRGZmTLpSpWu2LUeWcFfOrTN2YUrCTbjJeG39YpxAplZXhbkNPkqWnEcPVqXSg
         /IH5NOHuyxDV7nFUnHTXNjHa6p+6j7zZA7JyCZckPYbq1d0GLL5A2aTACmD1QeFButB2
         Bpx9lrzkk2Tb9mxERHeYTDM5Mz/mEcu+gwXvGnZmrMGuc5u9sDdoab2hyqKb2LuQVrLI
         oDpk9CeKQfht1EDyEYiW8KIDmZAwq9sMCxvUJKQeM+JN/HLXPJ5nqjP5gRc4eGGMyFER
         Mscw==
X-Gm-Message-State: AGi0PuaKj3+83KWRv2JDJJYq2b2p7ObE/xHXY+62vB1kq7T3ACfDg2rJ
        hAT/z7M84MinhD/NMmW2AZCEeaKU+7ibkhPJumCEeQ==
X-Google-Smtp-Source: APiQypJlKxen8G2zO7JAXCkFHrtJVs6fTHB/52uvBVD1WuZXJLx6iNR7mkvt90cHOCFrx1bhwh1bwttJBXrxJvTAToE=
X-Received: by 2002:a05:6102:308b:: with SMTP id l11mr6943000vsb.14.1587730335778;
 Fri, 24 Apr 2020 05:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1582529411.git.xji@analogixsemi.com> <a81adcf2e79d440edcb7b3989f31efcb80a6e9ff.1582529411.git.xji@analogixsemi.com>
 <CANMq1KBfB6tXFqYGvr=8fV_bpCV5GbVHeEbRs+fuaZba65-OPw@mail.gmail.com> <20200424065124.GA31922@xin-VirtualBox>
In-Reply-To: <20200424065124.GA31922@xin-VirtualBox>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 24 Apr 2020 20:12:04 +0800
Message-ID: <CANMq1KBJ6f74aNAr8BwC3wz8MEeJzwXOQE44gv6C=DNzYmUWCQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to
 DP bridge driver
To:     Xin Ji <xji@analogixsemi.com>
Cc:     devel@driverdev.osuosl.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Sheng Pan <span@analogixsemi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 2:51 PM Xin Ji <xji@analogixsemi.com> wrote:
>
> On Thu, Apr 23, 2020 at 07:55:15PM +0800, Nicolas Boichat wrote:
> > Hi,
> >
> > Just commenting on the mode_fixup function that was added in v7.
> >
> [snip]
> > > +       /*
> > > +        * once illegal timing detected, use default HFP, HSYNC, HBP
> > > +        */
> > > +       if (hblanking < HBLANKING_MIN || (hfp < HP_MIN && hbp < HP_MIN)) {
> >
> > should this be adj_hblanking/adj_hfp/adj_hbp?
> NO, need check original HFP and HBP, if they are not legal, driver need
> set default value to adj_hsync, adj_hfp, adj_hbp.
> >
> > > +               adj_hsync = SYNC_LEN_DEF;
> > > +               adj_hfp = HFP_HBP_DEF;
> > > +               adj_hbp = HFP_HBP_DEF;
> > > +               vref = adj->clock * 1000 / (adj->htotal * adj->vtotal);
> > > +               if (hblanking < HBLANKING_MIN) {
> > > +                       delta_adj = HBLANKING_MIN - hblanking;
> > > +                       adj_clock = vref * delta_adj * adj->vtotal;
> > > +                       adj->clock += DIV_ROUND_UP(adj_clock, 1000);
> > > +               } else {
> > > +                       delta_adj = hblanking - HBLANKING_MIN;
> > > +                       adj_clock = vref * delta_adj * adj->vtotal;
> > > +                       adj->clock -= DIV_ROUND_UP(adj_clock, 1000);
> > > +               }
> > > +
> > > +               DRM_WARN("illegal hblanking timing, use default.\n");
> > > +               DRM_WARN("hfp(%d),hbp(%d),hsync(%d).\n", hfp, hbp, hsync);
> >
> > How likely is it that this mode is going to work? Can you just return
> > false here to reject the mode?
> We want to set the default minimal Hblancking value, then it may display,
> otherwise. If we just return false, there is no display for sure.

Right, understand your argument. I'm pondering if it's not just better
to reject the mode rather than trying a timing that is definitely
quite different from what the monitor was asking for. No super strong
opinion, I'll let other people on the list weigh in.
