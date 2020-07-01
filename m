Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC42C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CB2920722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lA+NKOK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgGAHsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbgGAHsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:48:50 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43D9C03E979
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 00:48:49 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e4so25805364ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 00:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uHiWeHvIRTabhJTMwa3fxsZyuvaR5uB2s6b6XKCykyI=;
        b=lA+NKOK7zcmXa+2MC1Gn+Y/TDNNdWs07VZI26+piRmWa5IgJ6SkoLWgnui5+oh39Q6
         JI6t0CXi/MwfxhT8vihn8/G5X/LVpEvZMEq6tZoPu3lZavZG9S0OrLs90EX1D+5GNIjW
         sn5HxzJnDf4UXKGwZsAkmMMGh/L0sPm18+UMSMM1eLMgNI1ScSZ7avbX4Jba1HNPFR01
         Oz9jy9C52A6E2XL5BRjrUkpECbZ+e9Z0fJBkNwYFnAHSKnD0TULcsTh24JxIR23IbQ9B
         1wfadENgJePUvcAFAQh88V1690Yckkn/btGB8V/wCG7M9ur0RaRMuVp1qacys1YinlL/
         Kt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uHiWeHvIRTabhJTMwa3fxsZyuvaR5uB2s6b6XKCykyI=;
        b=YNfdFN39PJ+RrpU5Gvt5nJxl/vmdlzB5gLEjBZX50YBE2YONQNykBlnDz92w0zLuie
         dgSSzGx9487cYHmncP7X0gFzPTZ45M15Q5U6gN8AEw7WWw9UF67X/qBaizLpulZyHnKr
         lbRmiFtfrpa++H4VT+/n5zuTfR/rGxeJd1V9HI6cIfhQtyJXoblpakJuVKXEY0Gvq+5P
         ZLCdOUS5IRVMazQDK9314Kmig6h0XrtnQ8+kKdq9KYEjgQlisYzX+c85QkMfyRIz2LqU
         DncXxDEt8f8nL7arL43stzQDe4uI3iMtnvFIzyioRQ169pFyhP93iIm0ZMZKW6l8Vflr
         6dlQ==
X-Gm-Message-State: AOAM532KWOoSB1iNAT7AfUT8ppWJLE3cmH5pZ8LD30SuHZiqp4SmzcGC
        dEb2ms8VjJwbvXCU973F5dSlQxHVE328KB4v0NuuzQ==
X-Google-Smtp-Source: ABdhPJxumtOUJ9MZZWWYdqUsVyvRBEAFzjv5D3L00fsCsWjbg4DvKg1etmzvpIC/d88ZkoLQjiDZIXHRS5fiu1kXPgs=
X-Received: by 2002:a05:651c:112e:: with SMTP id e14mr11799081ljo.338.1593589728209;
 Wed, 01 Jul 2020 00:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200626005601.241022-1-megous@megous.com> <20200626005601.241022-7-megous@megous.com>
In-Reply-To: <20200626005601.241022-7-megous@megous.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 1 Jul 2020 09:48:37 +0200
Message-ID: <CACRpkdbWUW4AaZf3ZTvabdQ3SwwwBcdwYFOaE1ou4rbtUAUOEw@mail.gmail.com>
Subject: Re: [PATCH v5 06/13] drm/panel: st7703: Prepare for supporting
 multiple panels
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

> Parametrize the driver so that it can support more panels based
> on st7703 controller.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
