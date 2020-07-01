Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E70C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE5CE2073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZWv+idF9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgGAHwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbgGAHwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:52:34 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1B3C03E979
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 00:52:34 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h19so25776339ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 00:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sp8OFRFf6RX3lWs07Kr7AL+Vpp0ArpSvDuDKv5ockV4=;
        b=ZWv+idF9f6C09tDpuANbtiZts4oy6Jp5G1wSc4cfgblqEH6E+eM6fWzw78g8Jym25H
         ESLvx77xZlyF23QX2tk/bGVSZNIB3cK6WP7tuOsSmSUSUfQKFljAkgjkGFTg5MVl2SHc
         I45UL6AyclZyHXiaOMg5f2gg14p0pj9SskoqwosD9HZoQEAmhfiFU6SFqpnSIdpxjDYK
         gb4O0POOdeIrAJGg2v5Pp1AmYKsvfYwczug197KEa/QuFl43CZRsgMDP7tJL54aSqTky
         SmG+X0j/S7GVnqpwYBphXgIDO0nunTa5tPSy6BcjTknPtA8noK/g2cyVwldEPqFh9+Xu
         zjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sp8OFRFf6RX3lWs07Kr7AL+Vpp0ArpSvDuDKv5ockV4=;
        b=MnVPfN+4qHMwPvwIxCuQc98BZ8prqmWA6BZZTG4PB4oR0RozEuKDPnBUK9GpGgqQja
         RSYmvo7wRBZR8CERCxK6N/Hc890urrnUPuMyCsGhrGimK51r260fp5J8fzp+FTCCsOWV
         z7Lk9aA/uQfEjasb4Qb99I0v3/VE5obZrsD3gPdSGLGKYrwdfFT3/yz3azd0sEiHcdXJ
         sQTB0lR5TP1qOVTAx9S5fJTzIOaAZrpzjbbGkobvWU5Rg05CfSd8yuRDFJe+XBT2mw5v
         +udUiiHceOaCCJ70Ov/MDBhaaQ/MEIiFk7YFlm8OSklQh1rfh4xX/Jeopwot3g1+pad7
         VZtw==
X-Gm-Message-State: AOAM5320Myb9TtTWkwrQqzg5rwmWJsz5JLlw7B2NwJ18ZsQ9HJLWzE+D
        7JMZ7cZvA6MB7fJeAc6PwuA9H+gniHPIcV3mkzLftw==
X-Google-Smtp-Source: ABdhPJwpRScXAGVUMqgSm84FX6WJ0SzvlgWp8UNzvNb5Aa6vqYqzZkRC8x+/6pQpFExpVAZVeTV2K/cWOS/1LOUiSjs=
X-Received: by 2002:a05:651c:112e:: with SMTP id e14mr11806438ljo.338.1593589952845;
 Wed, 01 Jul 2020 00:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200626005601.241022-1-megous@megous.com> <20200626005601.241022-13-megous@megous.com>
In-Reply-To: <20200626005601.241022-13-megous@megous.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 1 Jul 2020 09:52:21 +0200
Message-ID: <CACRpkdaca=1gvYv5e2v3BzZSTE_1gab6nOt6DCrFm3QX64xy9Q@mail.gmail.com>
Subject: Re: [PATCH v5 12/13] arm64: dts: sun50i-a64-pinephone: Enable LCD
 support on PinePhone
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

> From: Icenowy Zheng <icenowy@aosc.io>
>
> PinePhone uses PWM backlight and a XBD599 LCD panel over DSI for
> display.
>
> Backlight levels curve was optimized by Martijn Braam using a
> lux meter.
>
> Add its device nodes.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Martijn Braam <martijn@brixit.nl>
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
