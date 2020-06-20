Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D306C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 20:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 349F32468B
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 20:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qotg/ZeX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgFTUWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 16:22:36 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40491 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbgFTUWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 16:22:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id n23so15190188ljh.7
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 13:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BWp0+qDm6D8+3mdyev80e+srYJlNGDQfDI6Ux1DPKEI=;
        b=qotg/ZeXIPMehWBAckg+OzF18WAadLD8hI2ucC1ErHAe3OF4T+ewG7b8UnXqPIrCJC
         NffQkxDyfJdTqZmnpSmScWrwE3vt69gKx1J5R+fiooBvd8reKOQJAOwDL2Er7dHcbG6r
         ujq99H01r7tEQL1RJapvL6hnCqnbi+U0YbRbTY5A4z9aOGUisYrUTF7uERjFvLEEhzQS
         r8WayBPRqSkjkZSvNs7AVxa4Zk7i7rM1CTDjSYTmrezr0UmbashCHAKHJQWIKZ5B8F6h
         50FhDx0XlT5NpnjJ09s6t9wAMWaJCWA9kl1w5ZXxh0f6MAzLvg7sK4mfjwEQKnbMHk3l
         H7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BWp0+qDm6D8+3mdyev80e+srYJlNGDQfDI6Ux1DPKEI=;
        b=e7EWYJGH2QPbCt9DyXCTqvy5syjFP5qV4dQ0dfgGBPthMGCDnjLSOguwKzonL5euCm
         tHke7FR3IviC+fiowSahokxK5K++BoKRCIQBcU9IyuMmQVGhGMeER9sEZbdudxKnJ6Rp
         kV1SrWouvZjYYCXq0yDicz+f2yovotahqW2M5nHvvarxQUdKnqzhCkuj4zlx+hxiyljI
         W8Znf/EPcBm2nZgD+K0z9VfG+HUszVjMt2Jo1lR+TzAlqfNb3gLV3MBCoviFIlrj46JY
         e02lWjnhSw48pgmmVfNnoqC4F2MvhP6+hI2E42q0Sy+INItrrDzkd0NZzFQmDEo7yNGH
         x3wA==
X-Gm-Message-State: AOAM533Qq1a5lK+UMPTyMrJwecNyOQMVnYK2nW3QTBHXOMGEO70HJZhr
        QrB8XiNgAeG3672U21QNmJIuLShMFbq7hpoHy1p5zg==
X-Google-Smtp-Source: ABdhPJwztfJNiEkx5aQDaLYvFXoWh6IYZzLs+Pbi4Vm2pTrzkcb2BWJegviTjlgMxkuZFcxtSjiCvDT0ZWRTDHcS7BU=
X-Received: by 2002:a2e:351a:: with SMTP id z26mr4729522ljz.144.1592684492809;
 Sat, 20 Jun 2020 13:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200608104832.1.Ibe95d8f3daef01e5c57d4c8c398f04d6a839492c@changeid>
In-Reply-To: <20200608104832.1.Ibe95d8f3daef01e5c57d4c8c398f04d6a839492c@changeid>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 20 Jun 2020 22:21:21 +0200
Message-ID: <CACRpkdZ+8B2hRDrBjA5uB8zneodE53ea9RJn1G33hJSJptShSQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/bridge: ti-sn65dsi86: Don't compile GPIO bits if
 not CONFIG_OF_GPIO
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sandeep Panda <spanda@codeaurora.org>,
        kernel test robot <lkp@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 7:48 PM Douglas Anderson <dianders@chromium.org> wrote:

> The kernel test robot noted that if "OF" is defined (which is needed
> to select DRM_TI_SN65DSI86 at all) but not OF_GPIO that we'd get
> compile failures because some of the members that we access in "struct
> gpio_chip" are only defined "#if defined(CONFIG_OF_GPIO)".
>
> All the GPIO bits in the driver are all nicely separated out.  We'll
> guard them with the same "#if defined" that the header has and add a
> little stub function if OF_GPIO is not defined.
>
> Fixes: 27ed2b3f22ed ("drm/bridge: ti-sn65dsi86: Export bridge GPIOs to Linux")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Fair enough,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
