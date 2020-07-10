Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EA3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 02:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33E6C20748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 02:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FqMpvwwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgGJCO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgGJCOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 22:14:55 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AB1C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 19:14:55 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id d198so2203146vsc.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 19:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Hywc1x9A6pr0CRt+2NvKzTMAzPWDqqcQzWTAgr3WdA=;
        b=FqMpvwwCb9dpe7UBryM/EcOozRX1lwFdrdBzi6xzDnEKZh2OoMEtN2fjbqcDCUrTRA
         G/uqyZ8phkRmpHCnbtDwt4L9W1fAWzn3ef/hbpBNScSTumoNlfxcimfhrs002pQgYYMO
         C5wNeccogggNi/MBtl9XYVeMhj+5M8PkPDZAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Hywc1x9A6pr0CRt+2NvKzTMAzPWDqqcQzWTAgr3WdA=;
        b=qQi5Rr8jn+SHFmA0ZoWYrBvtLgg9rDjDaux/a7ZjFaNqJMfnLV744FFYSqjsxhll9O
         f0QLn2sKiz0y4M292iROmlEJ5cgPDfP7afiuqTMvwfbf72T6SQayvmaSYWUKlZ1z7Uza
         cYLnuXhByLsAvL7tEHpyNyaKZWiInvPeLJE7igD1rKNdPTJm1iG0o0mtYaSsg9NC6cuW
         T/0SsMSJqpMWNg4Sf3W/WKXjKlDq0f5W2G0cOtFFd/3gn4GniG2YJPQotxrx3sMpwe93
         j2QxY5XKqPcB8cDiixkILz7bhAsA6eLe+/KrHwKloXElYWKknmtzqt6msoPfiq9vzTiv
         oEfw==
X-Gm-Message-State: AOAM530PPFqqRz1+VRDXfBW8L1Rx3SFCxur4PxeMXtp89Fp3H4UELYzO
        2bkHHQWHccixqFgUqlv7BpN9fI9D0O4=
X-Google-Smtp-Source: ABdhPJx1vrSyFQFQZIKlWznlcRL/HRN91+n/4oA3jjOqZoGrG42wpjEZjlfzif1hD6DiKZBsLNQxlA==
X-Received: by 2002:a05:6102:c5:: with SMTP id u5mr16021173vsp.147.1594347294297;
        Thu, 09 Jul 2020 19:14:54 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id b21sm485709uap.15.2020.07.09.19.14.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 19:14:52 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id f11so1347409uao.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 19:14:51 -0700 (PDT)
X-Received: by 2002:ab0:6e8e:: with SMTP id b14mr54133636uav.0.1594347291225;
 Thu, 09 Jul 2020 19:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20191218143416.v3.6.Iaf8d698f4e5253d658ae283d2fd07268076a7c27@changeid>
 <20200710011935.GA7056@gentoo.org> <CAD=FV=X3oazamoKR1jHoXm-yCAp9208ahNd8y+NDPt1pU=5xRg@mail.gmail.com>
In-Reply-To: <CAD=FV=X3oazamoKR1jHoXm-yCAp9208ahNd8y+NDPt1pU=5xRg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 9 Jul 2020 19:14:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UWQsGit6XMCzHn5cBRAC9nAaGReDyMzMM2Su02bfiPyQ@mail.gmail.com>
Message-ID: <CAD=FV=UWQsGit6XMCzHn5cBRAC9nAaGReDyMzMM2Su02bfiPyQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] drm/bridge: ti-sn65dsi86: Use 18-bit DP if we can
To:     steev@kali.org
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Steev Klimaszewski <steev@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 9, 2020 at 6:38 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Jul 9, 2020 at 6:19 PM Steev Klimaszewski <steev@gentoo.org> wrote:
> >
> > Hi Doug,
> >
> > I've been testing 5.8 and linux-next on the Lenovo Yoga C630, and with this patch applied, there is really bad banding on the display.
> >
> > I'm really bad at explaining it, but you can see the differences in the following:
> >
> > 24bit (pre-5.8) - https://dev.gentoo.org/~steev/files/image0.jpg
> >
> > 18bit (5.8/linux-next) - https://dev.gentoo.org/~steev/files/image1.jpg
>
> Presumably this means that your panel is defined improperly?  If the
> panel reports that it's a 6 bits per pixel panel but it's actually an
> 8 bits per pixel panel then you'll run into this problem.
>
> I would have to assume you have a bunch of out of tree patches to
> support your hardware since I don't see any device trees in linuxnext
> (other than cheza) that use this bridge chip.  Otherwise I could try
> to check and confirm that was the problem.

Ah, interesting.  Maybe you have the panel:

boe,nv133fhm-n61

As far as I can tell from the datasheet (I have the similar
boe,nv133fhm-n62) this is a 6bpp panel.  ...but if you feed it 8bpp
the banding goes away!  Maybe the panel itself knows how to dither???
...or maybe the datasheet / edid are wrong and this is actually an
8bpp panel.  Seems unlikely...

In any case, one fix is to pick
<https://lore.kernel.org/dri-devel/1593087419-903-1-git-send-email-kalyan_t@codeaurora.org/>,
though right now that patch is only enabled for sc7180.  Maybe you
could figure out how to apply it to your hardware?

...another fix would be to pretend that your panel is 8bpp even though
it's actually 6bpp.  Ironically if anyone ever tried to configure BPP
from the EDID they'd go back to 6bpp.  You can read the EDID of your
panel with this:

bus=$(i2cdetect -l | grep sn65 | sed 's/i2c-\([0-9]*\).*$/\1/')
i2cdump ${bus} 0x50 i

When I do that and then decode it on the "boe,nv133fhm-n62" panel, I find:

6 bits per primary color channel

-Doug
