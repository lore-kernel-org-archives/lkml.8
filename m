Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4F4C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 364432070B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TCOaST54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbgEKQYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 12:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729463AbgEKQYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 12:24:13 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DCFC05BD0A
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 09:24:12 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k19so4137590pll.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 09:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=nIHK0pERFEVTVOMQQjzKbYldCgkef0vrbHxpu8mVr5o=;
        b=TCOaST54SvL3086A7HHjNJTa/H/ch7lt91lpjhI79d01O042oBl3o3vcfVKRm5Bgqr
         yqPGz//m/aDJWTMYb7QNLl80YovugT4IKGrQtd1r/Zqt1DDke4Ieh/Xlc0YwHABLni2N
         VVzT8Wn9BpUiNvWsFe41tKvu7vmzWntoMa20w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=nIHK0pERFEVTVOMQQjzKbYldCgkef0vrbHxpu8mVr5o=;
        b=Xcvj+NtSky4KUAUQP3LxnbrUV8EKJp+eEr37atkc7M3n0DcQ6CIodzl7ZrqraQ5A1M
         dwS8UHFKXCer/oRVu1BjM0PALYEwyvL2lq0U+RItV2jviI67Swan0pVmr55G2nLGT8WY
         gYBbqe6mrLsW+9OT44sbQUXj4u2puln+d6SwE+iRfpcFtPiAOQuhe3aPq/rCvP7v2ecv
         edqBTsbn9Z6Prgip2VhoC3NkHjTlVusxzWZc/bvjBTrYQR93a/jRhQHHZhhiuLN9XmQp
         xR4noz6U1xjQsoDL3zvJLYpVfycyoaCSB8BM+6kZaCiNMTDuIjJhK69DMKOHaPPKRZUE
         BcQg==
X-Gm-Message-State: AGi0Pub/njTrofFRuKrgGNPi8A9ACJC9+PiE1VAXfF134QW8qs1gEHBc
        51eUp5v1DmFT84ectPvno4MJ6A==
X-Google-Smtp-Source: APiQypLIWX8xdd1JBGRzmfOJI4N2dj1AtQSQdOmDg36PNZdcgR9LSF47B8adWOS/qPaOt3Lk6Yv3GA==
X-Received: by 2002:a17:90a:d245:: with SMTP id o5mr25045160pjw.213.1589214251377;
        Mon, 11 May 2020 09:24:11 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j5sm9359046pfh.58.2020.05.11.09.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 09:24:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200507143354.v5.1.Ia50267a5549392af8b37e67092ca653a59c95886@changeid>
References: <20200507213500.241695-1-dianders@chromium.org> <20200507143354.v5.1.Ia50267a5549392af8b37e67092ca653a59c95886@changeid>
Subject: Re: [PATCH v5 1/6] drm/bridge: ti-sn65dsi86: Export bridge GPIOs to Linux
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     jonas@kwiboo.se, jeffrey.l.hugo@gmail.com,
        linux-gpio@vger.kernel.org, bjorn.andersson@linaro.org,
        jernej.skrabec@siol.net, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        robdclark@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>,
        Laurent.pinchart@ideasonboard.com, a.hajda@samsung.com,
        airlied@linux.ie, bgolaszewski@baylibre.com, daniel@ffwll.ch,
        linus.walleij@linaro.org, narmstrong@baylibre.com,
        robh+dt@kernel.org, spanda@codeaurora.org
Date:   Mon, 11 May 2020 09:24:09 -0700
Message-ID: <158921424955.26370.14824525920971881719@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-05-07 14:34:55)
> The ti-sn65dsi86 MIPI DSI to eDP bridge chip has 4 pins on it that can
> be used as GPIOs in a system.  Each pin can be configured as input,
> output, or a special function for the bridge chip.  These are:
> - GPIO1: SUSPEND Input
> - GPIO2: DSIA VSYNC
> - GPIO3: DSIA HSYNC or VSYNC
> - GPIO4: PWM
>=20
> Let's expose these pins as GPIOs.  A few notes:
> - Access to ti-sn65dsi86 is via i2c so we set "can_sleep".
> - These pins can't be configured for IRQ.
> - There are no programmable pulls or other fancy features.
> - Keeping the bridge chip powered might be expensive.  The driver is
>   setup such that if all used GPIOs are only inputs we'll power the
>   bridge chip on just long enough to read the GPIO and then power it
>   off again.  Setting a GPIO as output will keep the bridge powered.
> - If someone releases a GPIO we'll implicitly switch it to an input so
>   we no longer need to keep the bridge powered for it.
>=20
> Because of all of the above limitations we just need to implement a
> bare-bones GPIO driver.  The device tree bindings already account for
> this device being a GPIO controller so we only need the driver changes
> for it.
>=20
> NOTE: Despite the fact that these pins are nominally muxable I don't
> believe it makes sense to expose them through the pinctrl interface as
> well as the GPIO interface.  The special functions are things that the
> bridge chip driver itself would care about and it can just configure
> the pins as needed.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
