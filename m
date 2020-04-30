Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB7CC47253
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 966D82070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="XLnBFQL5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgD3Nir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgD3Nio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:38:44 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C0FC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 06:38:42 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v4so7492974wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 06:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=KnR7bkdv4N1Nq9MuZiNtgrfGxSJ17VM7ueK9N7RTvfw=;
        b=XLnBFQL5UUro9alKKy0D0DfX9qkXZAq/iO+O/1OXTpBDq+W8EbPNOI96gbJrDL1z+8
         zLmHUj7VCkJG4KEqGmUU+quv2A2YiGLWJpEhqNnfg1KYU3NVeFD1YDO9jY8cBwTC991M
         YOc88uX9Z8DS1xDqBUFQzgrkK/I5XnhgZliHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=KnR7bkdv4N1Nq9MuZiNtgrfGxSJ17VM7ueK9N7RTvfw=;
        b=Q2N7H6wNFetVzBBCSkUN9KC1geeP0dQ9qWAbTmIrSfDISYBDSIhy0ZGNctd1S364FX
         QUfhSQaNjGz/Dsze6hdpjWM7895G9UD1u2O85h0jcejT1lYCwV/YbhDdT2HBg6DLJoqW
         ILWyOM3dOcuWeDaLUd14rYcwLaYUUoMKRi4y2NCXqnzzyWvd/wAB+17/5SzXmpaHZ82p
         gAle9k9wPdMHwG6g80qwPqdS3DwXtCNHa/SZbULh8kfbqZ3WS6S+qKSYvd9VgEcpAlNA
         nz3zBCP18fM9Lv+Fa9dq0uYFADxNl6zltlOai5Z0JVv1WHQKQD2L/M5jmq9IP224jjdN
         2kxw==
X-Gm-Message-State: AGi0PuY8WGqKpBRlyV0wxA1q6321hc+dw+H2g4YeKo2iiX+R/Chm24Zq
        9lkEmeBxc4XI/h5IxkIwlRbMkg==
X-Google-Smtp-Source: APiQypL+QGXvyVhP/QeAHVWOyWEduq4cr+Jqf1PzGKDCYktsJpNMQ7Lne/j1S3qXZBUt6Kmx+2hfrw==
X-Received: by 2002:a7b:c84f:: with SMTP id c15mr2905324wml.166.1588253921689;
        Thu, 30 Apr 2020 06:38:41 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u127sm12408532wme.8.2020.04.30.06.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 06:38:41 -0700 (PDT)
Date:   Thu, 30 Apr 2020 15:38:39 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Xin Ji <xji@analogixsemi.com>,
        Nicolas Boichat <drinkcat@google.com>,
        devel@driverdev.osuosl.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Sheng Pan <span@analogixsemi.com>,
        Qilin Wen <qwen@analogixsemi.com>,
        Ming Liu <mliu@analogixsemi.com>
Subject: Re: [PATCH v7 2/2] drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to
 DP bridge driver
Message-ID: <20200430133839.GB10381@phenom.ffwll.local>
Mail-Followup-To: Xin Ji <xji@analogixsemi.com>,
        Nicolas Boichat <drinkcat@google.com>, devel@driverdev.osuosl.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Pi-Hsun Shih <pihsun@chromium.org>,
        Sheng Pan <span@analogixsemi.com>,
        Qilin Wen <qwen@analogixsemi.com>, Ming Liu <mliu@analogixsemi.com>
References: <cover.1582529411.git.xji@analogixsemi.com>
 <a81adcf2e79d440edcb7b3989f31efcb80a6e9ff.1582529411.git.xji@analogixsemi.com>
 <CANMq1KBfB6tXFqYGvr=8fV_bpCV5GbVHeEbRs+fuaZba65-OPw@mail.gmail.com>
 <20200424065124.GA31922@xin-VirtualBox>
 <CANMq1KBJ6f74aNAr8BwC3wz8MEeJzwXOQE44gv6C=DNzYmUWCQ@mail.gmail.com>
 <20200428100508.GD3456981@phenom.ffwll.local>
 <20200430033614.GA6645@xin-VirtualBox>
 <20200430133731.GA10381@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430133731.GA10381@phenom.ffwll.local>
X-Operating-System: Linux phenom 5.4.0-4-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 03:37:31PM +0200, Daniel Vetter wrote:
> On Thu, Apr 30, 2020 at 11:36:14AM +0800, Xin Ji wrote:
> > On Tue, Apr 28, 2020 at 12:05:08PM +0200, Daniel Vetter wrote:
> > > On Fri, Apr 24, 2020 at 08:12:04PM +0800, Nicolas Boichat wrote:
> > > > On Fri, Apr 24, 2020 at 2:51 PM Xin Ji <xji@analogixsemi.com> wrote:
> > > > >
> > > > > On Thu, Apr 23, 2020 at 07:55:15PM +0800, Nicolas Boichat wrote:
> > > > > > Hi,
> > > > > >
> > > > > > Just commenting on the mode_fixup function that was added in v7.
> > > > > >
> > > > > [snip]
> > > > > > > +       /*
> > > > > > > +        * once illegal timing detected, use default HFP, HSYNC, HBP
> > > > > > > +        */
> > > > > > > +       if (hblanking < HBLANKING_MIN || (hfp < HP_MIN && hbp < HP_MIN)) {
> > > > > >
> > > > > > should this be adj_hblanking/adj_hfp/adj_hbp?
> > > > > NO, need check original HFP and HBP, if they are not legal, driver need
> > > > > set default value to adj_hsync, adj_hfp, adj_hbp.
> > > > > >
> > > > > > > +               adj_hsync = SYNC_LEN_DEF;
> > > > > > > +               adj_hfp = HFP_HBP_DEF;
> > > > > > > +               adj_hbp = HFP_HBP_DEF;
> > > > > > > +               vref = adj->clock * 1000 / (adj->htotal * adj->vtotal);
> > > > > > > +               if (hblanking < HBLANKING_MIN) {
> > > > > > > +                       delta_adj = HBLANKING_MIN - hblanking;
> > > > > > > +                       adj_clock = vref * delta_adj * adj->vtotal;
> > > > > > > +                       adj->clock += DIV_ROUND_UP(adj_clock, 1000);
> > > > > > > +               } else {
> > > > > > > +                       delta_adj = hblanking - HBLANKING_MIN;
> > > > > > > +                       adj_clock = vref * delta_adj * adj->vtotal;
> > > > > > > +                       adj->clock -= DIV_ROUND_UP(adj_clock, 1000);
> > > > > > > +               }
> > > > > > > +
> > > > > > > +               DRM_WARN("illegal hblanking timing, use default.\n");
> > > > > > > +               DRM_WARN("hfp(%d),hbp(%d),hsync(%d).\n", hfp, hbp, hsync);
> > > > > >
> > > > > > How likely is it that this mode is going to work? Can you just return
> > > > > > false here to reject the mode?
> > > > > We want to set the default minimal Hblancking value, then it may display,
> > > > > otherwise. If we just return false, there is no display for sure.
> > > > 
> > > > Right, understand your argument. I'm pondering if it's not just better
> > > > to reject the mode rather than trying a timing that is definitely
> > > > quite different from what the monitor was asking for. No super strong
> > > > opinion, I'll let other people on the list weigh in.
> > > 
> > > Yeah mode_fixup is supposed to be used to adjust the mode in intermediate
> > > stages (e.g. if you go from progressive to interlaced only at the end of
> > > your pipeline or something like that). It's not meant for adjusting the
> > > mode yout actually put out through a hdmi or dp connector. For fixed
> > > panels adjusting modes to fit the panel is also fairly common, but not for
> > > external outputs.
> > > 
> > > Since this is a DP bridge I'd say no adjusting, just reject what doesn't
> > > fit.
> > We have found some panel which HBP less than 8, if we reject to adjust
> > video timing, then there is no display. The customer does not accept it,
> > they push us to fix it, the only resolve way is to adjust timing.
> 
> Are we talking about external DP screen here, or some built-in panel? For
> the later case we do a lot of mode adjusting in many drivers ...
> 
> I haven't checked, by if our connector type is eDP then this should be all
> fine.

Ok I read the patch now, you seem to support both. Would it work if we
make this adjustement conditional on it being an internal panel only? I
think that would be perfect.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
