Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E5EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCD4D20722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jhCYCyy9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgGAHrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbgGAHrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:47:41 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F44C03E979
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 00:47:40 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id t9so13016287lfl.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 00:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iIDLsMEqEu6N2jaXdTulWkfEp7Kjn/2oh7q3WmCmgLs=;
        b=jhCYCyy9yFVY5gCDiHwYz6PmY8nom9rH+nB33U4cwyxeYk0JH44YqUgWCKpCsd4xvx
         YUbMO4iv6azZgxYQ7mQONcO+cCE+pUzwPohi2QRpvYKkg0vFWNCmZoKQlsKx1Iy8xJJ8
         BzmfQTT1ieWTFOWsU9Ny/q6AGkOL65X/9oqAlBhS/AG18zF7XMgKv/4YAgtqKG/Rxgeu
         FzXwgMxo15sq56v3jmlYvaq10jiYxNWryCh/oOQQV+wmai6gXYp7aNs6u8Wp3CyApTOf
         fsZXJy9R8HmnGvqrOXXE5NYgQjX/vfRyyb+RHcZDaffzcNCqar/xwgWB2YqZpwqPcGYC
         os5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iIDLsMEqEu6N2jaXdTulWkfEp7Kjn/2oh7q3WmCmgLs=;
        b=MDp50MkZTC6IESzJINRIFKti/FH43X5mm1qWsNZCluM4MIRILFZ/OkQk7etaydG6xv
         xVwKqFc7KExADu8cCNGz6kZn/SYjXHupVszSDx63ye0PC7emaEPUyVlEtULu9RUSseFN
         ICgceUVSBSK8Lb4NqcNPOLSTTG7P9cbVL/5X1YRysY1h5SOrkPYeYYjBKvj1CSYoRtht
         ElPRkcfcYEeiTiZ3UOeI+0xLbRCEAalJzApxbvEGLRC8mvqegLrdx7HtqjPNQOKM3l+/
         tHZ0iteUdFzjG4WvKavHdNrtumUF9Yw69WQLv6ign4q6gZdhjivSd2wMhYb7lEJ4vHNA
         Y9IQ==
X-Gm-Message-State: AOAM533pTLxq0V3xOlHrfnFPFejUysgYhB6xHdnu03Xi1m5PISpEJdQR
        Y4+83r93pc9GXD5EAcG16nrjVgxdDxB9+EdW30Oeyg==
X-Google-Smtp-Source: ABdhPJxuQhh9QuZuUqJPJjuR/b+dDLREBTmySJg4FX0sMHHxmx5c080ySCLZHwPZqCVaSh9Yel1Lc9f0B5OJmbWs5U4=
X-Received: by 2002:a05:6512:3150:: with SMTP id s16mr3346458lfi.47.1593589659102;
 Wed, 01 Jul 2020 00:47:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200626005601.241022-1-megous@megous.com> <20200626005601.241022-5-megous@megous.com>
In-Reply-To: <20200626005601.241022-5-megous@megous.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 1 Jul 2020 09:47:28 +0200
Message-ID: <CACRpkdbJqFHCGkLgMM3pzgE4kYL7wH2FyK0fpOf1Gva1xicxuA@mail.gmail.com>
Subject: Re: [PATCH v5 04/13] drm/panel: rocktech-jh057n00900: Rename the
 driver to st7703
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 2:56 AM Ondrej Jirman <megous@megous.com> wrote:

> This rename is done so that the driver matches the name of the
> display controller and in preparation for adding support for more
> panels to the driver.
>
> This is just a basic file rename, with no code changes.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>

This is the right thing to do.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
