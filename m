Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24060C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06D0120675
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iIm3W3vx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgENIYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 04:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725935AbgENIYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 04:24:41 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5F1C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 01:24:41 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a21so2482186ljj.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 01:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jkb8BxKnl71QcTSlAQifB2QDBHTd1utKf7Tuku0XIK4=;
        b=iIm3W3vxPyvQT8hBr8kR8u+6yVBH0h6bfGPXKdobARfet5qpx6e2NJwbGUoVD4BTiz
         kvpn1tyKA+LwVUJc8z8fF1ZwXlCreaNrldq4vaEDBNH9cKFjh4tAUHQkvEkgZrv38eDN
         o2gz3Js+ZsuW3daffpbxtnkSsvbVGjH/1ch+B53s3SDAzYlJpVIgVSGq9BIdUF43U3J3
         PYEdm9THYdzNqhqnu0YtajA3OhEFK2moz2+zytOAdmmOqgbfZNV8YpRwBfYf+FcYfKP1
         slXNCbKogiAPZuvMbATklfcba8DSvlZ/NhggKTK4KlzEC8fEhJbI/SNZCFcSB3u8yrD/
         oIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jkb8BxKnl71QcTSlAQifB2QDBHTd1utKf7Tuku0XIK4=;
        b=UQ9reeEHXY1w4DQEW4rkf/HYRPO/a1HS4t5rID6RKgN1FFdpfEo2kAecexUZSZTUzS
         qQhX1zlafUv8WaGZkbNJysCDVnVqWM6/CmcPbA2jATINCztUROPV/GoPSKuxiDK921DX
         lUYzdj3z4ox3KO4bGgGzp/YWTAylxnz04wTJ2hxbStsszAa/FdHW4v8aVj5bwVZcTcjn
         ao0Syx4e9CH4ARSs5sbpUUjE7VdukDwB71DWKC3ZWoYhaWvXUBMDHASXSrMjxdGRa4UH
         GyDg4kukORu+7xgBnHNEIl+e1Mdfd2tMzUYEcpV8ncrMICPIWmxBm0gUEbSpXW0z94Rp
         zNYQ==
X-Gm-Message-State: AOAM532Cwly5v0gLRrvl/h5azsv+DEl4n/736UCuws0fIGKdm2QfLqLR
        QO28JUFu9TmIYEw4gheHH3GIbZloNBiku/jxcVm68A==
X-Google-Smtp-Source: ABdhPJzbR0lONsL+LHNQ562bI+zZx3vzCrNYamk5GJI5zjbv9WVScZ7rOiUe3C6sarzGNmAWB4jF6RMUNqx0dbXgSxU=
X-Received: by 2002:a2e:8805:: with SMTP id x5mr2073815ljh.223.1589444679816;
 Thu, 14 May 2020 01:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <1589267017-17294-1-git-send-email-dillon.minfei@gmail.com> <1589267017-17294-4-git-send-email-dillon.minfei@gmail.com>
In-Reply-To: <1589267017-17294-4-git-send-email-dillon.minfei@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 May 2020 10:24:28 +0200
Message-ID: <CACRpkda5VjjBdbruXTi33QBNb=VU6vK2zDE8yyQXoWw7=NQFeg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] ARM: dts: stm32: enable ltdc binding with ili9341
 on stm32429-disco board
To:     dillon.minfei@gmail.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 9:04 AM <dillon.minfei@gmail.com> wrote:

> From: dillon min <dillon.minfei@gmail.com>
>
> Enable the ltdc & ili9341 on stm32429-disco board.
>
> Signed-off-by: dillon min <dillon.minfei@gmail.com>

This mostly looks good but...

> +&spi5 {
> +       status = "okay";
> +       pinctrl-0 = <&spi5_pins>;
> +       pinctrl-names = "default";
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +       cs-gpios = <&gpioc 2 GPIO_ACTIVE_LOW>;
> +       dmas = <&dma2 3 2 0x400 0x0>,
> +              <&dma2 4 2 0x400 0x0>;
> +       dma-names = "rx", "tx";

These DMA assignments seem to be SoC things and should
rather be in the DTS(I) file where &spi5 is defined, right?
stm32f429.dtsi I suppose?

It is likely the same no matter which device is using spi5.

Yours,
Linus Walleij
