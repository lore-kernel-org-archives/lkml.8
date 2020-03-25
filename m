Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528DDC54FCF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A8E20740
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XtpjmpZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgCYPuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:50:21 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:41227 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgCYPuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:50:20 -0400
Received: by mail-ua1-f66.google.com with SMTP id f9so906016uaq.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 08:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5R9OlcysTIjSd6LSQUVfdd7d9zM2FdO/Mwd40Pw5oqo=;
        b=XtpjmpZHorFljb0nMx6/72BT6LEyg6Yu3GZqe2zFozULuw0vZvc0DGxN1dv5nyYcCC
         hHWAbWGSOUvReB9nY4FED4Ar/y5wjn/ZL8FKAYhFCQofbGaikMQxNWYRkq+MvceY2mpy
         N4Sp0qbxAYASySnf+wDwpkd2kniFgXVKTcZFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5R9OlcysTIjSd6LSQUVfdd7d9zM2FdO/Mwd40Pw5oqo=;
        b=oH75PR6S9p4FMhmeT1b6FALNxyTzSSgd0F1HYU932tATA+9O1R2Fem0TX7HfXrQT7l
         1cp0RPhyuHNeOXJLOCrzcjXijmEmYgOe8QADGmUN0Ns9CnG5Ew0GuciulJr5vefShaFZ
         1z8ZSKlF7N/qe94F5Vdqp6VFhcP7Hlq5fhmSCTF+kIabKjLxHRReHmHWVdXgl2cye3L3
         vIzwua7lz6oTTFAUJkRhFxC432GaZlPqG2rt+YUSD0MnW/WrtyOkDaULg+SeQUZUFRVo
         Ri5nHMPhQKt4LeXVdHydUPLMijwtf3ln7/toBbyQTdX01e6JoC6783LfmtOoB+LwwRDq
         2VHw==
X-Gm-Message-State: ANhLgQ2GZtT+F3GZu/I5wjQa7ePPimKQCqb/R+i3H64LNKfQnkBmAMMV
        BqtWgAVKHa01glZNWNFbnpv7U7gc22I=
X-Google-Smtp-Source: ADFU+vsn/Gq7+jA1ahH0mmC5pyuCE0VmXofvEgWcHkKqfv7ljtVeDLBwPhQxjjKCKMHptBK7EhQEUA==
X-Received: by 2002:ab0:45f8:: with SMTP id u111mr3003030uau.50.1585151419230;
        Wed, 25 Mar 2020 08:50:19 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id k14sm3109052vke.16.2020.03.25.08.50.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 08:50:18 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id e138so1767027vsc.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 08:50:18 -0700 (PDT)
X-Received: by 2002:a67:694f:: with SMTP id e76mr2833828vsc.73.1585151417831;
 Wed, 25 Mar 2020 08:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <1584944027-1730-1-git-send-email-kalyan_t@codeaurora.org>
 <CAD=FV=VX+Lj=NeZnYxDv9gLYUiwUO6brwvDSL8dbs1MTF4ieuA@mail.gmail.com> <CAF6AEGs5saoU3FeO++S+YD=Js499HB2CjK8neYCXAZmCjgy2nQ@mail.gmail.com>
In-Reply-To: <CAF6AEGs5saoU3FeO++S+YD=Js499HB2CjK8neYCXAZmCjgy2nQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 25 Mar 2020 08:50:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VxeCUEEFi9T0Jand3EWkaQTLnQkT3v5yjyjLi4yDeQ-w@mail.gmail.com>
Message-ID: <CAD=FV=VxeCUEEFi9T0Jand3EWkaQTLnQkT3v5yjyjLi4yDeQ-w@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: ensure device suspend happens during PM sleep
To:     Rob Clark <robdclark@gmail.com>
Cc:     Kalyan Thota <kalyan_t@codeaurora.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Sean Paul <seanpaul@chromium.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        mkrishn@codeaurora.org, travitej@codeaurora.org,
        nganji@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 25, 2020 at 8:40 AM Rob Clark <robdclark@gmail.com> wrote:
>
> On Tue, Mar 24, 2020 at 7:35 AM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Sun, Mar 22, 2020 at 11:14 PM Kalyan Thota <kalyan_t@codeaurora.org> wrote:
> > >
> > > "The PM core always increments the runtime usage counter
> > > before calling the ->suspend() callback and decrements it
> > > after calling the ->resume() callback"
> > >
> > > DPU and DSI are managed as runtime devices. When
> > > suspend is triggered, PM core adds a refcount on all the
> > > devices and calls device suspend, since usage count is
> > > already incremented, runtime suspend was not getting called
> > > and it kept the clocks on which resulted in target not
> > > entering into XO shutdown.
> > >
> > > Add changes to manage runtime devices during pm sleep.
> > >
> > > Changes in v1:
> > >  - Remove unnecessary checks in the function
> > >      _dpu_kms_disable_dpu (Rob Clark).
> >
> > I'm wondering what happened with my feedback on v1, AKA:
> >
> > https://lore.kernel.org/r/CAD=FV=VxzEV40g+ieuEN+7o=34+wM8MHO8o7T5zA1Yosx7SVWg@mail.gmail.com
> >
> > Maybe you didn't see it?  ...or if you or Rob think I'm way off base
> > (always possible) then please tell me so.
> >
>
> At least w/ the current patch, disable_dpu should not be called for
> screen-off (although I'd hope if all the screens are off the device
> would suspend).

OK, that's good.

> But I won't claim to be a pm expert.. so not really
> sure if this is the best approach or not.  I don't think our
> arrangement of sub-devices under a parent is completely abnormal, so
> it does feel like there should be a simpler solution..

I think the other arguments about asymmetry are still valid and I've
fixed bugs around this type of thing in the past.  For instance, see
commit f7ccbed656f7 ("drm/rockchip: Suspend DP late").


-Doug
