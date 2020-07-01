Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B3FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E5B62074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tvs2DSdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgGAHux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbgGAHux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:50:53 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D759AC061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 00:50:52 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t25so21209593lji.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 00:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uz2HVrjjWvM9xtc3pLsQOyiOISHzNTG2GYwMVCw6J4o=;
        b=tvs2DSdH9VtwLW7TdYV8ZAqaUg/zZ8haHmG8YpMOlppKeOLLQbv5ErlxCiEgo2/eXK
         77As9LEMtO5Mk/n8z5uLzjqYSo5Mhn8o4iSVjroURbmuoqH6xpj0dvP6gPfFOJT1rvwV
         T2pZTjcKOppqeOjFBTHlhjsr5ALmNO3j9hUdL1PUtLuvgZ4PFaHTyYG2fVCwkaBuYKwo
         xussbvQg1VFQaVTB9vB8oSf+Qx7zJtAb8ihs1wIwWwwHktc9Sf3sDhxwGFZTMY1sBJB4
         iaEN1xgQeU6zhego2PxrwsM12K2MdRSrNT/wEmTm9whZ6UZ247TkW8wtJ14MkpaKfZ7t
         mIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uz2HVrjjWvM9xtc3pLsQOyiOISHzNTG2GYwMVCw6J4o=;
        b=qw09bgbcxJHYJWdcXRIneVzvAx5Eq5ob3IfkBZQ0kaPfSPx55zX8kwM/d3mItsCP8x
         6pgYBGsAkfvQe/I6akfmBV9hylsQaLPjbSHtEC9KN7JeI93pHw9+TMh27dKUYY7+3JN9
         /pmz3ifNIBVcNEC12i4L2ANi1FikHMcH0gC2vyow/twQuzyFJerQRCmEfEdhPqcxcxIF
         zoWCbWpqdyGbvSUK2mDzVoYfzLCFuh7l+ujAODXq+ByyI9sXoiwj7iCRgC7EwcQfIBT6
         VUNDYZLCBQHNMFvfDHKsJrzER+BCYUiaoJWxU1+dRniLcZXKiOiTYKtefuxOc+AnWlT+
         2sZg==
X-Gm-Message-State: AOAM530ZpaZCVeCaqVMSx08THK4s5jIKZ0QmKev/busw5xmFuh0BIm/w
        MPHHBdwvjJPuXUJo+jZ9dSKLGNYm43yhizLNdXiQEQ==
X-Google-Smtp-Source: ABdhPJwgrorp6PW7xMBimsg+9NrZkVcYegomjAzeg6KTUWqMNqo6scmxWP7ixbhDL9EU3lg5KTkr+7Ecj790mtBVXkk=
X-Received: by 2002:a2e:810a:: with SMTP id d10mr7003529ljg.144.1593589851375;
 Wed, 01 Jul 2020 00:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200626005601.241022-1-megous@megous.com> <20200626005601.241022-10-megous@megous.com>
In-Reply-To: <20200626005601.241022-10-megous@megous.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 1 Jul 2020 09:50:40 +0200
Message-ID: <CACRpkdZcMA_Y_eH8_TL09Z0_DADDcUy5s_S45UfrnoSKmNgtXw@mail.gmail.com>
Subject: Re: [PATCH v5 09/13] drm/panel: st7703: Add support for Xingbangda XBD599
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

> Xingbangda XBD599 is a 5.99" 720x1440 MIPI-DSI LCD panel used in
> PinePhone. Add support for it.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
