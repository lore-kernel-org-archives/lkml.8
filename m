Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8536C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61E02206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jibHKywq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgD1KFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727107AbgD1KFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:05:12 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45C2C03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 03:05:12 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k12so2058324wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 03:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=l+k7yFMhMisNWSRZhvrwWfroBahbWYYcttXSTYKeIwQ=;
        b=jibHKywqEOHP7s5Uq17E8ygefJpPB+KB36cR9akz/wwH6GF74Ovy8y7nrJQgKD/v86
         +ADgY4xegjPKGLTcL6BJ0oyxEBc/3ebLDa6cz/R1bKVedxmKa2fGhgObMZIWZ0aSYDV9
         qIlGzv7MRvovl3lA5TeZpfsQe5hz34ij7dOQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=l+k7yFMhMisNWSRZhvrwWfroBahbWYYcttXSTYKeIwQ=;
        b=nq02ZieKS0OLfQ/diBePwp+ou8+dUj7QMkDnfqp1TcWNfU6WQkCwJ8iekFOIi8QLB2
         abMfKHmJc9A0wt3uHU7BzTiT0btkr2s3YFmMjx9UCLX4nIy/D9U90FnWPNyeu/yrvV55
         L7euDK49P3l4Yv7aO8fkjpbl1ofl9lF3mcO0pCdl49Rly9kd5N7nL0cPlw5NwchBWIZH
         IBJzRxTPAKZBu+JY0wzPv+sw2jZodPX1fCtF204UlNb+p5GoIhiA5u0Nxb70+95xR9Hl
         dmQOyj9JK1DBLc2r3Cp/TfkvBXH8EjgaEsuMO9okAW3UbHyc402bBdHNi2uD29qE8KAr
         Jwog==
X-Gm-Message-State: AGi0PuZgEdF5/xMxibrZiFr5m9bQNURY76NutNNW+L3a/SeTd0fCTtG3
        kFgvcz780VigkTEloWrGcO5U8g==
X-Google-Smtp-Source: APiQypKQTCBtHEwl9qfvTCZEBaYghpXpXAL7yjy18ziiEevrdg+jQUjp5/w1QV7rvuqsCLOMh3LRRQ==
X-Received: by 2002:a1c:dc8b:: with SMTP id t133mr3745031wmg.117.1588068311327;
        Tue, 28 Apr 2020 03:05:11 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 138sm2786040wmb.14.2020.04.28.03.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 03:05:10 -0700 (PDT)
Date:   Tue, 28 Apr 2020 12:05:08 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Xin Ji <xji@analogixsemi.com>, devel@driverdev.osuosl.org,
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
Subject: Re: [PATCH v7 2/2] drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to
 DP bridge driver
Message-ID: <20200428100508.GD3456981@phenom.ffwll.local>
Mail-Followup-To: Nicolas Boichat <drinkcat@chromium.org>,
        Xin Ji <xji@analogixsemi.com>, devel@driverdev.osuosl.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Sheng Pan <span@analogixsemi.com>
References: <cover.1582529411.git.xji@analogixsemi.com>
 <a81adcf2e79d440edcb7b3989f31efcb80a6e9ff.1582529411.git.xji@analogixsemi.com>
 <CANMq1KBfB6tXFqYGvr=8fV_bpCV5GbVHeEbRs+fuaZba65-OPw@mail.gmail.com>
 <20200424065124.GA31922@xin-VirtualBox>
 <CANMq1KBJ6f74aNAr8BwC3wz8MEeJzwXOQE44gv6C=DNzYmUWCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANMq1KBJ6f74aNAr8BwC3wz8MEeJzwXOQE44gv6C=DNzYmUWCQ@mail.gmail.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 08:12:04PM +0800, Nicolas Boichat wrote:
> On Fri, Apr 24, 2020 at 2:51 PM Xin Ji <xji@analogixsemi.com> wrote:
> >
> > On Thu, Apr 23, 2020 at 07:55:15PM +0800, Nicolas Boichat wrote:
> > > Hi,
> > >
> > > Just commenting on the mode_fixup function that was added in v7.
> > >
> > [snip]
> > > > +       /*
> > > > +        * once illegal timing detected, use default HFP, HSYNC, HBP
> > > > +        */
> > > > +       if (hblanking < HBLANKING_MIN || (hfp < HP_MIN && hbp < HP_MIN)) {
> > >
> > > should this be adj_hblanking/adj_hfp/adj_hbp?
> > NO, need check original HFP and HBP, if they are not legal, driver need
> > set default value to adj_hsync, adj_hfp, adj_hbp.
> > >
> > > > +               adj_hsync = SYNC_LEN_DEF;
> > > > +               adj_hfp = HFP_HBP_DEF;
> > > > +               adj_hbp = HFP_HBP_DEF;
> > > > +               vref = adj->clock * 1000 / (adj->htotal * adj->vtotal);
> > > > +               if (hblanking < HBLANKING_MIN) {
> > > > +                       delta_adj = HBLANKING_MIN - hblanking;
> > > > +                       adj_clock = vref * delta_adj * adj->vtotal;
> > > > +                       adj->clock += DIV_ROUND_UP(adj_clock, 1000);
> > > > +               } else {
> > > > +                       delta_adj = hblanking - HBLANKING_MIN;
> > > > +                       adj_clock = vref * delta_adj * adj->vtotal;
> > > > +                       adj->clock -= DIV_ROUND_UP(adj_clock, 1000);
> > > > +               }
> > > > +
> > > > +               DRM_WARN("illegal hblanking timing, use default.\n");
> > > > +               DRM_WARN("hfp(%d),hbp(%d),hsync(%d).\n", hfp, hbp, hsync);
> > >
> > > How likely is it that this mode is going to work? Can you just return
> > > false here to reject the mode?
> > We want to set the default minimal Hblancking value, then it may display,
> > otherwise. If we just return false, there is no display for sure.
> 
> Right, understand your argument. I'm pondering if it's not just better
> to reject the mode rather than trying a timing that is definitely
> quite different from what the monitor was asking for. No super strong
> opinion, I'll let other people on the list weigh in.

Yeah mode_fixup is supposed to be used to adjust the mode in intermediate
stages (e.g. if you go from progressive to interlaced only at the end of
your pipeline or something like that). It's not meant for adjusting the
mode yout actually put out through a hdmi or dp connector. For fixed
panels adjusting modes to fit the panel is also fairly common, but not for
external outputs.

Since this is a DP bridge I'd say no adjusting, just reject what doesn't
fit.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
