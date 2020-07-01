Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F75C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEFA12074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xTCIkOiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgGAHxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbgGAHxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:53:06 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D2AC061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 00:53:06 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t25so21215769lji.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 00:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=enPGC0OPftzCJlUnTQARq7JEwIW+q43cB8Io8/Pof2M=;
        b=xTCIkOiBtlJ6KiXHJnag1uUXr7+sABVaySKZwGWLW5bPgNh2BpVrCKqCjglU/TuFGH
         m9QtKUXanPF0gEBmpQNGPZx85JSQb83YZbgLpLTKkIv1UXKqBUZJTMA+lDPcpg6NmnA8
         yEJfoyS1/zewE72ZeCP16ZGXR9t4xXVWMNqfm8H8UJfeX03FrzhX/Ue7EnpKQHR0Ul1N
         bbl0jRMKuKHGYDE9ofhB5OiIbUeQJIdWXfo1NerQIiNu+MdLppPXX5PEm4N2CmlC6zkk
         HlGZOPJdteytMiASWqZt67U+AMjsKUhgRsKVnC709MG+tkDQD2kyIYXYGPsOxYUQY1A5
         xMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=enPGC0OPftzCJlUnTQARq7JEwIW+q43cB8Io8/Pof2M=;
        b=ouKxEFQb8qn/+zC99gIEJeKS7F8x+ySQ+wa76Zzr/uqTUOwmlFvvslBDv0iXo8K6VC
         EMHz4gSco90PNEM9xhu0XKpqmj4MMG/Z2yonc3To/xF9OYoPbONe/RgatorWOsAsNFTd
         N4WzHrnHFkWPaJp7/oWUYVO3BOAxNwBoLRzmg6lpWPq+vaan3AMRu4xs1+tucRw6uYcX
         aPzyJHqd6G+hM0z5+AS1bcwXjK7pbjbYJN98B2ApKRgaajDv8mWBb0e6UcHS6E214Qbo
         wcTDjHkO09nPPKzfiiznlnf38SrbI79AyolDfRAjbbVW2R0+cZFR7d2BAXocJCcHuIv4
         SLbw==
X-Gm-Message-State: AOAM5302TMkpREw5vMVMo4RtI/2nJoqFtfQswEBB/UaEchtdy4rZUuzS
        vQrSKXdk4CKT6OrT7qUsHaOttHIG2OsRI01dS3LOvw==
X-Google-Smtp-Source: ABdhPJw3tzZ9D9p6jgEm59VOvtaJaUTyrZtudaxwwHOStc/fwYBz/YcU4X11SqbNhvI9hCjXocTGYoYCbCv2Fh3PwSk=
X-Received: by 2002:a05:651c:284:: with SMTP id b4mr1772479ljo.283.1593589984484;
 Wed, 01 Jul 2020 00:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200626005601.241022-1-megous@megous.com> <20200626005601.241022-14-megous@megous.com>
In-Reply-To: <20200626005601.241022-14-megous@megous.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 1 Jul 2020 09:52:53 +0200
Message-ID: <CACRpkda2LnZ7UQkp_ZDEVCfxHVQ-VUE7NH0dEGNHYrUd1LcC0Q@mail.gmail.com>
Subject: Re: [PATCH v5 13/13] arm64: dts: sun50i-a64-pinephone: Add
 touchscreen support
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

> Pinephone has a Goodix GT917S capacitive touchscreen controller on
> I2C0 bus. Add support for it.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
