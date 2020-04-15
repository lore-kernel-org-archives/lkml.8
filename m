Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AFEC3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 902162076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vy4tGFrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411426AbgDORim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411203AbgDORi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:38:28 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6A9C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 10:38:26 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v9so4578016ljk.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 10:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sHqR2C2kxuUQojnOegpnVpnZsXBDzDgx0iHXx8OBUys=;
        b=Vy4tGFrR/UDz2J5FSZuzqmOKo1GCzxTWtZYw44vcauEzWQop68wvIG9gTD/GD6vSVx
         XU/sx8wBiHWMnElHjd+vgG43Pu0fwjE3OO6i10GBubZa9VgOL7U0dcLRL7z//U4t7RVc
         yLc9JmltDVJ99nNme9B93oOoyJNrRlTztgoU7PoT7uk9kJpOkDNL2nlKBeZazkdblE01
         TYsbPQTSf+oLWvQov5xMyKCCjZmXaHOs4Oj2N8do8WbBa1c82XNc6T+bPgKB33ZBEsEE
         wlFNw5pM/M5kzUb6Trl6SkDgQkpS5pamRzWGqC8x2YCx0gKHq/ICFrqJXnZTr9ti2G55
         KnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sHqR2C2kxuUQojnOegpnVpnZsXBDzDgx0iHXx8OBUys=;
        b=S+6a6F13jU1R0r6tXTdLfHQjtdeFFvmNdCr/qlK1XVxUTDmSYBxb2F45I7+HXT2YVR
         XTaAr3UZJrvZFU6F9FjRzQRtSh87J2m5YemWhmPIhh9EFx8l6jvt07im8UiiEsbdRyrJ
         EkpHc8qn/tlK9NZhkxa8xMPfX/HMf1leVZHkYzyYImpNETXDd3EZ/XROkJZKCzwSgsAb
         97AD0/ApXdkjeJNMU6hD+UnxLtwQYVqEhWwNijV/e9gVyetaI/MtfIqy5cOj7EehsCgH
         0y/Jyt0nu+KMJqpOWGJKou/brfEn6OnUNgEC/Kx14aj350XOgLBVGT5ef+XMy84aUbLb
         /mCA==
X-Gm-Message-State: AGi0PubX6bUY/AJdiYe32mAh0CwRncm3e/jDBpGS67KjGugu5RDKU8Jk
        ycllNaFjfqqkMRYu2gif99P4HtSVd2A3Yedi6W7kNQ==
X-Google-Smtp-Source: APiQypLDAmF2P6A5YCpLFM2PBnROKXHaBtzTgdG+1WeYnzrJQ57PGXzD+r87BQuOOpT+tLulD2nVxdXC0mh6T+pWCAQ=
X-Received: by 2002:a2e:9455:: with SMTP id o21mr3998409ljh.245.1586972304780;
 Wed, 15 Apr 2020 10:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200228103752.1944629-1-christian.gmeiner@gmail.com> <4a5436201ff4345194f64aac1553f9656887203a.camel@pengutronix.de>
In-Reply-To: <4a5436201ff4345194f64aac1553f9656887203a.camel@pengutronix.de>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 15 Apr 2020 23:08:13 +0530
Message-ID: <CA+G9fYvVC8TYk1u-B98MvABqQUuG6hEB6Y7AYd0Qnzs0=-pFUw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/etnaviv: rework perfmon query infrastructure
To:     Lucas Stach <l.stach@pengutronix.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux- stable <stable@vger.kernel.org>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Mar 2020 at 17:19, Lucas Stach <l.stach@pengutronix.de> wrote:
>
> On Fr, 2020-02-28 at 11:37 +0100, Christian Gmeiner wrote:
> > Report the correct perfmon domains and signals depending
> > on the supported feature flags.
> >
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Fixes: 9e2c2e273012 ("drm/etnaviv: add infrastructure to query perf counter")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
>
> Thanks, applied to etnaviv/next.
>
> Regards,
> Lucas
>
> >
> > ---
> > Changes V1 -> V2:
> >   - Handle domain == NULL case better to get rid of BUG_ON(..) usage.
> > ---
> >  drivers/gpu/drm/etnaviv/etnaviv_perfmon.c | 59 ++++++++++++++++++++---
> >  1 file changed, 52 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
> > index 8adbf2861bff..e6795bafcbb9 100644
> > --- a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
> > +++ b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
> > @@ -32,6 +32,7 @@ struct etnaviv_pm_domain {
> >  };
> >
> >  struct etnaviv_pm_domain_meta {
> > +     unsigned int feature;
> >       const struct etnaviv_pm_domain *domains;
> >       u32 nr_domains;
> >  };
> > @@ -410,36 +411,78 @@ static const struct etnaviv_pm_domain doms_vg[] = {
> >
> >  static const struct etnaviv_pm_domain_meta doms_meta[] = {
> >       {
> > +             .feature = chipFeatures_PIPE_3D,

make modules failed for arm architecture on stable rc 4.19 branch.

drivers/gpu/drm/etnaviv/etnaviv_perfmon.c:392:14: error:
'chipFeatures_PIPE_3D' undeclared here (not in a function)
   .feature = chipFeatures_PIPE_3D,
              ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/etnaviv/etnaviv_perfmon.c:397:14: error:
'chipFeatures_PIPE_2D' undeclared here (not in a function); did you
mean 'chipFeatures_PIPE_3D'?
   .feature = chipFeatures_PIPE_2D,
              ^~~~~~~~~~~~~~~~~~~~
              chipFeatures_PIPE_3D
drivers/gpu/drm/etnaviv/etnaviv_perfmon.c:402:14: error:
'chipFeatures_PIPE_VG' undeclared here (not in a function); did you
mean 'chipFeatures_PIPE_2D'?
   .feature = chipFeatures_PIPE_VG,
              ^~~~~~~~~~~~~~~~~~~~
              chipFeatures_PIPE_2D


ref:
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-4.19/DISTRO=lkft,MACHINE=am57xx-evm,label=docker-lkft/511/consoleText
