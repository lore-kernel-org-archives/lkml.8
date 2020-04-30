Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB96C8300E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA0432074A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="AUQMg9Bf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgD3Nhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbgD3Nhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:37:41 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC2FC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 06:37:40 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g13so6926582wrb.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 06:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=cIp9DbU+6rRfiPbG8uAVaJPBU9twoue+ADTvawohLJ4=;
        b=AUQMg9Bfr7hBR51Z28J9x9t2Irvw2vW5PyG4R/MxI6yDPK6/b/N3PFe0ZbPEv/oNXD
         MX/9JYqZK8jR0AvdRC6mo7BRI2JjjnAX3A4N7FC2xazulqlbx3GfSuQFUyJZhPZ12dNt
         UQTEgyH586iFrg6yerVwQymf3ZQWBP7qFMeTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=cIp9DbU+6rRfiPbG8uAVaJPBU9twoue+ADTvawohLJ4=;
        b=gATfWVpwsKt6WtpbGRnBJfAbH9FkepGMIgHDiu12Gz56c5oKS5pZm/I8jcq59Q9u2G
         qkKDOIoFbVY+Y0QolzycMSJ0x+I6/58EsuJSHDv77UfCVOktdOY+OkwtIkYjc6RgS728
         KCP5Zn0l4FIwodqOd+zyciQOUM74U75JJOEqu5wI3hu1F9J/dOCSxdP06RHymQWCM4g1
         Pqa5HNbqpThUqEx7T2UenqWZ9p1CkO+uZppFamnG7NA1eaY+qRf86beQc79FXno5Cjoe
         iUL4i0KdpcnFmLCW6+ezPD/7KhtASEyHPb80CuXPdFU0JenvxiGxow7TrZ6AN2JDjOJ+
         Ezzg==
X-Gm-Message-State: AGi0PubeqcIn8O2Q4YI+GyihN3FTvFqqiW6tbw8jsCEwXg6nNe3kYutL
        0PhLRwPKC1HPGz3X5YMF/QI/FQ==
X-Google-Smtp-Source: APiQypL9RK8HI6QxyV+3Rq7Wl6MRj5xlTTsfy+Y6JwCeDq2W1PgLcVkhMuTOPlnyqwhEdYENozbNbQ==
X-Received: by 2002:adf:df8d:: with SMTP id z13mr4003100wrl.304.1588253859692;
        Thu, 30 Apr 2020 06:37:39 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o3sm4146326wru.68.2020.04.30.06.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 06:37:38 -0700 (PDT)
Date:   Thu, 30 Apr 2020 15:37:31 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
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
Message-ID: <20200430133731.GA10381@phenom.ffwll.local>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430033614.GA6645@xin-VirtualBox>
X-Operating-System: Linux phenom 5.4.0-4-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 11:36:14AM +0800, Xin Ji wrote:
> On Tue, Apr 28, 2020 at 12:05:08PM +0200, Daniel Vetter wrote:
> > On Fri, Apr 24, 2020 at 08:12:04PM +0800, Nicolas Boichat wrote:
> > > On Fri, Apr 24, 2020 at 2:51 PM Xin Ji <xji@analogixsemi.com> wrote:
> > > >
> > > > On Thu, Apr 23, 2020 at 07:55:15PM +0800, Nicolas Boichat wrote:
> > > > > Hi,
> > > > >
> > > > > Just commenting on the mode_fixup function that was added in v7.
> > > > >
> > > > [snip]
> > > > > > +       /*
> > > > > > +        * once illegal timing detected, use default HFP, HSYNC, HBP
> > > > > > +        */
> > > > > > +       if (hblanking < HBLANKING_MIN || (hfp < HP_MIN && hbp < HP_MIN)) {
> > > > >
> > > > > should this be adj_hblanking/adj_hfp/adj_hbp?
> > > > NO, need check original HFP and HBP, if they are not legal, driver need
> > > > set default value to adj_hsync, adj_hfp, adj_hbp.
> > > > >
> > > > > > +               adj_hsync = SYNC_LEN_DEF;
> > > > > > +               adj_hfp = HFP_HBP_DEF;
> > > > > > +               adj_hbp = HFP_HBP_DEF;
> > > > > > +               vref = adj->clock * 1000 / (adj->htotal * adj->vtotal);
> > > > > > +               if (hblanking < HBLANKING_MIN) {
> > > > > > +                       delta_adj = HBLANKING_MIN - hblanking;
> > > > > > +                       adj_clock = vref * delta_adj * adj->vtotal;
> > > > > > +                       adj->clock += DIV_ROUND_UP(adj_clock, 1000);
> > > > > > +               } else {
> > > > > > +                       delta_adj = hblanking - HBLANKING_MIN;
> > > > > > +                       adj_clock = vref * delta_adj * adj->vtotal;
> > > > > > +                       adj->clock -= DIV_ROUND_UP(adj_clock, 1000);
> > > > > > +               }
> > > > > > +
> > > > > > +               DRM_WARN("illegal hblanking timing, use default.\n");
> > > > > > +               DRM_WARN("hfp(%d),hbp(%d),hsync(%d).\n", hfp, hbp, hsync);
> > > > >
> > > > > How likely is it that this mode is going to work? Can you just return
> > > > > false here to reject the mode?
> > > > We want to set the default minimal Hblancking value, then it may display,
> > > > otherwise. If we just return false, there is no display for sure.
> > > 
> > > Right, understand your argument. I'm pondering if it's not just better
> > > to reject the mode rather than trying a timing that is definitely
> > > quite different from what the monitor was asking for. No super strong
> > > opinion, I'll let other people on the list weigh in.
> > 
> > Yeah mode_fixup is supposed to be used to adjust the mode in intermediate
> > stages (e.g. if you go from progressive to interlaced only at the end of
> > your pipeline or something like that). It's not meant for adjusting the
> > mode yout actually put out through a hdmi or dp connector. For fixed
> > panels adjusting modes to fit the panel is also fairly common, but not for
> > external outputs.
> > 
> > Since this is a DP bridge I'd say no adjusting, just reject what doesn't
> > fit.
> We have found some panel which HBP less than 8, if we reject to adjust
> video timing, then there is no display. The customer does not accept it,
> they push us to fix it, the only resolve way is to adjust timing.

Are we talking about external DP screen here, or some built-in panel? For
the later case we do a lot of mode adjusting in many drivers ...

I haven't checked, by if our connector type is eDP then this should be all
fine.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
