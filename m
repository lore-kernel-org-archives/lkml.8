Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AF5C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD3A720781
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NGc3nSr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732442AbgGAQiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgGAQiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:38:07 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE69C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 09:38:06 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y18so14048440lfh.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 09:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=b+AvB/0HQsEmT/6dVyBt3aUmExGSI3jLVgR9pfCU6xI=;
        b=NGc3nSr+n0h4fP2ID26hOQgQ2mGQdX3utJApv6cBWQXcVI3h7Fc+D1QRBIQaXZnr11
         YgeqOntiAqKrnsCCfaKpVcqsrtPXTzfVbTUkjmkkNrnOIPMZykmbNj/2u4WCkAliAREg
         srt7gl91XjqmoYUp20v+a/dbguhGPKL1fabJgEWJI6T56t9/1CNQ8lqfXza8DolyiRh6
         YxcJG9lxOqaRR4KuOUA6S0lwFg3/kr+z1P4eliDfSaqRZvBfkOqJO2GlrsIs8/2UUGY3
         8VYcedkvX4qpBycLPBECUs7hYIk9hfSJ36kCPXDg9vPZk30LJD4yXA32EQ3JE1OeBAZY
         JHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=b+AvB/0HQsEmT/6dVyBt3aUmExGSI3jLVgR9pfCU6xI=;
        b=R/QcAqUI07xNQ8Leb2582qn7zDh+aN9J2KgImLpsZTqJlukswpFrGcfgdQrspU+MZG
         pq899AP6zWVLHT8HYEyb5oaZNs0TJOVY09VG5MQgRiaivhj86t3mt5cw4EJuJ6FGj3cj
         F9ShvZ9tAvIhRDlcLfLuduQQXHZlsG1KwSPQRVE7ZD0L6ARSUlb9cO3APyHYKU24svvb
         bKwUO63y5p9mcqqf7OIZqowFgiVn/Kjvby4Lk3G82GJLK4MjtM2wstlpLr+D0veXx+m9
         Y1pK9EQXzAVek2PVudmnsKW2rRTMLAgU05/f+b4m0AbBWrDjAv3eF90XndBZvIOtV9zG
         e6Sg==
X-Gm-Message-State: AOAM5321bAZDXiCW6msj1Z/5dPCUJp086Q8xImsuthpUJWQp1wafvZkH
        0ONFyXKVWa8TNaDc/jvgLt8wKUyj6fJi6rN7+Q7OhEtBSNQ=
X-Google-Smtp-Source: ABdhPJxK/nguThkBJd2Ux3XYuXE4KGHsrekK6XDG2RPUaVUVOzza6kVDTgWwFrm43mM2dign3+VsxQTsCovpxW3dEZ0=
X-Received: by 2002:ac2:47ed:: with SMTP id b13mr15611694lfp.21.1593621485126;
 Wed, 01 Jul 2020 09:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200701103126.1512615-1-megous@megous.com> <20200701152532.GA670324@ravnborg.org>
 <20200701163018.cfweuzp76qx5nsew@core.my.home>
In-Reply-To: <20200701163018.cfweuzp76qx5nsew@core.my.home>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 1 Jul 2020 18:37:53 +0200
Message-ID: <CACRpkdYf87RymMwUFL=nXNs3dFVveLt7u0X3haL=SN+N6+V_vQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/13] Add support for PinePhone LCD panel
To:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 6:30 PM Ond=C5=99ej Jirman <megous@megous.com> wrote=
:
> On Wed, Jul 01, 2020 at 05:25:32PM +0200, Sam Ravnborg wrote:
> > Hi Ondrej.
> >
> > On Wed, Jul 01, 2020 at 12:31:13PM +0200, Ondrej Jirman wrote:
> > > This patchset adds support for the LCD panel of PinePhone.
> > >
> > > I've tested this on PinePhone 1.0 and 1.2.
> > >
> > > Please take a look.
> > >
> > > thank you and regards,
> > >   Ondrej Jirman
> > >
> > > Changes in v6:
> > > - Fixed spacing in yaml
> > > - Fixed wrong vccio->iovcc supply name in the bindings doc
> > > - I noticed that the original driver uses a delay of 20ms in the init
> > >   function to achieve a combined total of 120ms required from post-re=
set
> > >   to display_on. I've added a similar delay to xbd599_init, so that
> > >   xbd599 panel also has the right timing. (patch 9)
> > > - v5->v6 diff: https://megous.com/dl/tmp/v5-v6.patch
> > > - Added review/ack tags
> > > - Learned to run dt_binding_check by myself ;)
> > The patch-set does not apply clean on top of drm-misc-next - due to
> > vrefresh removal.
> > Please re-spin.
>
> Sorry for that. Rebased and retested.

Sam will you apply it? I was in the middle of applying and ran into the sam=
e
issue :D

Yours,
Linus Walleij
