Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F800C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F16CA20575
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oKrgg6+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgEGOjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgEGOjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:39:40 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553F3C05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 07:39:40 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id x136so3500838vsx.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 07:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z7IFA9stGr7AQIAUx30OK+wSMM9GgogchHTSn33YI0U=;
        b=oKrgg6+ohJKVAOjUfdVbli6fopWWBK9ouxsK7MkYl2D0qBOvCFhQahNLKGcyctP0/3
         GuQCx6TcEKb7uN2XV751z4mfwU5kpykWAbuevm+p41uR8/egw097FPbwgDTfIlAaV1bB
         mk+N35TAXodLwzAsbM5yVi87spgJIxwJ/nNIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z7IFA9stGr7AQIAUx30OK+wSMM9GgogchHTSn33YI0U=;
        b=h0sR/QwTI1EGnaIwfM6i5cic5j1MYBWarv8StnB52+8A4ULMfX+nYomNp1z1Tuxm2t
         YPSpKWm4vuGyAaVkHjvtqgjDpgUUcFIhv1XPCdBqpXv2SGwQlob8mKfNFw+6Zz5ECu5Z
         5SIBeKBjBEFyYfu52fqiDVTW9XFiRi0Vfd5ZMUZUbhZrjoDBWcOEyY5MA0LBu+yzLyln
         /kZq2tijYnYrgSx+BQr8zrprGqrEwxLaH7AfKbLjKGW/Mna06EHp+//PrWyYmioJvuiM
         ktrwA2MQ71cv/UWwtPxx9go4H25EJHgGnxUijCsLl7G3HUQNdOBcNRbjUrE2L3QFZXjK
         V5qA==
X-Gm-Message-State: AGi0PubMdYmaJkZL5Ih4sIOvp8J3bZ+KJwABdD+n08ntvjphYa+AfCvM
        B3nwrDLYBINYKi8wawPWTWSRl+tHyWU=
X-Google-Smtp-Source: APiQypKIglHA57rcQZ+3CJHULOgYij12mCsktN8yvNrwOjSiP7qrAAiKm2LXLUfYSIi93GmpjM31BA==
X-Received: by 2002:a67:334a:: with SMTP id z71mr13092290vsz.87.1588862379150;
        Thu, 07 May 2020 07:39:39 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id n193sm2910545vkf.43.2020.05.07.07.39.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 07:39:38 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id u12so3625102vsq.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 07:39:37 -0700 (PDT)
X-Received: by 2002:a67:f5d6:: with SMTP id t22mr12876499vso.73.1588862377337;
 Thu, 07 May 2020 07:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200430194617.197510-1-dianders@chromium.org> <20200430124442.v4.1.Ia50267a5549392af8b37e67092ca653a59c95886@changeid>
In-Reply-To: <20200430124442.v4.1.Ia50267a5549392af8b37e67092ca653a59c95886@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 7 May 2020 07:39:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WHoxdr++f7Y_NO=VnrnEPkP=+WS5u3j_5ifEjekhBWcA@mail.gmail.com>
Message-ID: <CAD=FV=WHoxdr++f7Y_NO=VnrnEPkP=+WS5u3j_5ifEjekhBWcA@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] drm/bridge: ti-sn65dsi86: Export bridge GPIOs to Linux
To:     LinusW <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sandeep Panda <spanda@codeaurora.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Rob Clark <robdclark@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 30, 2020 at 12:46 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> The ti-sn65dsi86 MIPI DSI to eDP bridge chip has 4 pins on it that can
> be used as GPIOs in a system.  Each pin can be configured as input,
> output, or a special function for the bridge chip.  These are:
> - GPIO1: SUSPEND Input
> - GPIO2: DSIA VSYNC
> - GPIO3: DSIA HSYNC or VSYNC
> - GPIO4: PWM

One suggestion that came off-list is to change the code to make the
numbering match up better with the datasheet.  Right now if you want
GPIO 2 you have to refer to it like:

hpd-gpios = <&sn65dsi86_bridge 1 GPIO_ACTIVE_HIGH>;

That's because the code right now numbers things starting at 0 even if
the datasheet numbers things starting at 1.

I'm planning to spin the series later today for this.  While at it,
I'll squash my yaml bindings fixup into the bindings patch in this
series.  If someone would rather I wait and not spin yet, please yell.
