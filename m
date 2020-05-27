Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630BCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 350C8207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zcyryCjE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388581AbgE0Nma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388571AbgE0Nm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:42:29 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27146C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 06:42:29 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id m12so26561561ljc.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 06:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Gpj8j0c5lyk5HRTgWrPRCYDejEarn7rj3eE7+2oSVc=;
        b=zcyryCjEzgqjzqS0vEKTDZVA0X++Z1anrdUB1lNCfaHBFkLcjTCnYHdYlj7k3n3QM9
         Odvj75y+zy5TV+HerTnoD7OtG+IXx3N3ktu9K6NDagmnSq6JJ6/3ha/lUnacFXH4FkhH
         8qa48jdqcVdfMm0g1ELVkh1J6LQQSyBFN0LF2hsFL53oi+oRo7TbRzsAs1iq2wGS7Brm
         5pC3xPkW2IIsc+ILl9OaLm8+cQL+GwIxfx3UU1MGtY5Q4hkMLZoajmCZRa4cbhy5bP9r
         QqZd3Ad570pj8v29IEiK5wGFkzAraEl/NkquTKxiLTvPg3IhIZnTNIR9z8g7rc0xqpIk
         lhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Gpj8j0c5lyk5HRTgWrPRCYDejEarn7rj3eE7+2oSVc=;
        b=dYgJX66uIXVytV2txPxeXb1Y78YTK0u5eFz+jdoAmOc5kjt/Na4U103VpBK8PWnbEw
         4RFivKqTbEWes6XeyyrncjcyRHNlaBXB70y0smguiNngKY5zG5nOjH3Q4Q6Q8IZTfRjQ
         HsXJOMggmGzK5T8Tq40tEqN38A4Qnrppzm2fxADsX7mSdQf6j3AwLmTGSkInaSZdO559
         mYzNgeO4BBPDPjUGshiP9yQCiQcL3FTuRmiy3GfEunhhIRMvuuS8kCPskPVGS1KurKib
         6G+WsgVWvqL2F0VhQk1i1ZaTITU1o7s8cQT1fQkf4avLIBoqtAtLl7+BgZO31UyyDuCy
         RmlQ==
X-Gm-Message-State: AOAM530MbuGQxdxO4KQr8O3qx25QjwSOIeS0hdGL9LFDJiC08hXKVlfn
        jzFNQKCXsuHOY8bK23zTHLIHJEU2qnQRAjcuvzLfSg==
X-Google-Smtp-Source: ABdhPJwdDESykBgd1/Xo09tRAtdPiuah9DZv+t/1lZLdX32cBET1VtueeUtTZW2AEqUKI8AAVqGqcdgKFtE02GKvehQ=
X-Received: by 2002:a2e:9716:: with SMTP id r22mr3231303lji.293.1590586947594;
 Wed, 27 May 2020 06:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200527133158.462057-1-arnd@arndb.de>
In-Reply-To: <20200527133158.462057-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 May 2020 15:42:16 +0200
Message-ID: <CACRpkdYVM=KNTPeZKPmFDa755S2F6wTP7aAZPX60tTxnKBUYpw@mail.gmail.com>
Subject: Re: [PATCH] drm: pl111: add CONFIG_VEXPRESS_CONFIG dependency
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 3:32 PM Arnd Bergmann <arnd@arndb.de> wrote:
> The vexpress_config code fails to link in some configurations:
>
> drivers/gpu/drm/pl111/pl111_versatile.o: in function `pl111_versatile_init':
> (.text+0x1f0): undefined reference to `devm_regmap_init_vexpress_config'
>
> Add a dependency that links to this only if the dependency is there,
> and prevent the configuration where the drm driver is built-in but
> the config is a loadable module.
>
> Fixes: 826fc86b5903 ("drm: pl111: Move VExpress setup into versatile init")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Rob will you apply this directly to the drm tree?

Yours,
Linus Walleij
