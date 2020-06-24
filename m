Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3543AC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15CE220786
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VovrAuXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390908AbgFXM4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388942AbgFXM4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:56:10 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D16C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 05:56:10 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x11so1028299plo.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 05:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BudWo05ArRmRePLjA5xBNrNmyyzvRBGhzbvJwLCnkH0=;
        b=VovrAuXblBSTzq/6/XfemWZFoVjtapdBL6Wz1qU3Phgj++1U+GZ/hPAjZJP47h5hUi
         YQ/jkQ4l++Nn5DV1sG3GyQ/cxt37cIN49uMWF3Q0AFZpiHGMrUdmEnDK7DDcuKj4y2xA
         zM/tKFhuy/DLuPAj0FBsgEt4P9Po08dQxDQvTwUN+OzfAcGuW2GlVNzOkUbAlE5wqHij
         WdCzPRHrwIjOwaeA+n06Na5N/FyaVipSNKG+gG18MtoC4490gFP5fa/UYsnf9ydXTcpi
         IL78By7AvuimCTAqJ/f39CPa9CJXlp96nEtVQNCpYR9cHuG2/HCdx4C2FcqJ9SG5w248
         gvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BudWo05ArRmRePLjA5xBNrNmyyzvRBGhzbvJwLCnkH0=;
        b=bxCCk1TeCL+tcTmNusP5QMTmelanhbXND9Fo3ESbD7SaZtPe7miiigUmcjBfYpUmQX
         0cK+OInLYJrGI7BoE+OzFh070NzEi1LJPuOcNMxcLp+WcXTYWS/xftzsBo+kDQUkgFou
         H/yqikOaInFhpBDHRGT6BiR42Qi+nPaagFFF/28ON1AoV6+RgUvi7ojZJ4WouJxBFg86
         VgzJSAIGylpKZ1wMvxt7TRfboEcp7LyVapPSEYe6k2CXkOo1IdTXhvF3+RIO41doBYRo
         4VJgd+WF0ixkTWZ4Wx8tdmTlsLoSqYQicOKij1JahjmiPPiErkdrAqA7BlkAHH74Q7M9
         TnyA==
X-Gm-Message-State: AOAM532Bm/29lBqIIXYbtlKogc0fnNupPBVAjcRu9KCoZKzahWNyr/D9
        2FN5EPFBDZmHnUvcvasipCwYzJKzz9mpFzrkggU=
X-Google-Smtp-Source: ABdhPJzRZKLEpWyeo/NoFUWrW4UU840RrPrJNsza9FDRmLTNMxPJHwy89VbbjHRpQ0HUrfYBNXlqYSSKeR87YQva7nE=
X-Received: by 2002:a17:902:b206:: with SMTP id t6mr27559277plr.262.1593003370435;
 Wed, 24 Jun 2020 05:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200624114127.3016-1-a.hajda@samsung.com> <CGME20200624114136eucas1p1c84f81b1d78e2dbad7ac1b762f0a4b4f@eucas1p1.samsung.com>
 <20200624114127.3016-4-a.hajda@samsung.com> <2203e0c2-016b-4dbe-452d-63c857f06dd1@arm.com>
In-Reply-To: <2203e0c2-016b-4dbe-452d-63c857f06dd1@arm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 Jun 2020 15:55:57 +0300
Message-ID: <CAHp75VfpP1cGK3FvTL0hBudRY2N_7GpXYRuUHUCipz7X2sMLmQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 3/5] drivers core: allow probe_err accept
 integer and pointer types
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 3:37 PM Robin Murphy <robin.murphy@arm.com> wrote:
> On 2020-06-24 12:41, Andrzej Hajda wrote:
> > Many resource acquisition functions return error value encapsulated in
> > pointer instead of integer value. To simplify coding we can use macro
> > which will accept both types of error.
> > With this patch user can use:
> >       probe_err(dev, ptr, ...)
> > instead of:
> >       probe_err(dev, PTR_ERR(ptr), ...)
> > Without loosing old functionality:
> >       probe_err(dev, err, ...)
>
> Personally I'm not convinced that simplification has much value, and I'd
> say it *does* have a significant downside. This:
>
>         if (IS_ERR(x))
>                 do_something_with(PTR_ERR(x));
>
> is a familiar and expected pattern when reading/reviewing code, and at a
> glance is almost certainly doing the right thing. If I see this, on the
> other hand:
>
>         if (IS_ERR(x))
>                 do_something_with(x);

I don't consider your arguments strong enough. You are appealing to
one pattern vs. new coming *pattern* just with a different name and
actually much less characters to parse. We have a lot of clean ups
like this, have you protested against them? JFYI: they are now
*established patterns* and saved a ton of LOCs in some of which even
were typos.

> my immediate instinct is to be suspicious, and now I've got to go off
> and double-check that if do_something_with() really expects a pointer
> it's also robust against PTR_ERR values. Off-hand I can't think of any
> APIs that work that way in the areas with which I'm familiar, so it
> would be a pretty unusual and non-obvious thing.

-- 
With Best Regards,
Andy Shevchenko
