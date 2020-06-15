Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B677C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4043520679
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OrN4GhiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbgFOOhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbgFOOhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:37:09 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7DFC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:37:08 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id u17so9474772vsu.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jQ7S3FlEiexYsr4lwFQ+YPcMSE4i4i8SYc02PMpdNRs=;
        b=OrN4GhiCldEYngS5C9zMWmKc8uT0jp2fECCklT9801PrIRD6hkwiJ3JGiK1iHeGhI+
         e5UGox5+6/NlvlOUcwJXW/xpmnMU89WF82kjAEMmEBpqHxVQ3d+tcz2wx2W8OQ/s44jZ
         Q0rQIksw4dkw8w0N5mEfN25a5oxnvwGyAm2mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jQ7S3FlEiexYsr4lwFQ+YPcMSE4i4i8SYc02PMpdNRs=;
        b=CioQFkoNTnsXasJwoieTtDLka93Th63bCd6X8UCqGVK8fDd+mRWN4+oMSJFk/5ZvOw
         VG/+aslrupSQWEi+ncPctcOluvylrW94xmIjQIsl/eOHNJy0FNcMVfBxaRRNLf6nGoaw
         tst1CSqQUVLTMh4tdcY1+G5ZPV8lUYjOwF4feHGpLIYUkR0kS23XR8m44U+kbNtswzFU
         7owFenij73WsJIAOU4mNk+nwzTVcRGm3VAYAjFQLhYczdywJ4OwUj+d736NAy+yZgfta
         WES70FPhp9cuQuPjfYd492SjswUsHsrYIx+Pzow9avLi5u2GxLEEyCD4jaTLGwBhepaQ
         UT2w==
X-Gm-Message-State: AOAM533Lgj1wf7FZsdnvFyXeg4YP5ftD0n7SzPduxvzE+SWsra79zEsj
        n/PIQs+08LivlnLPdiD/px1tMILYRd8=
X-Google-Smtp-Source: ABdhPJxN0U7d7PGrWgvgFUf6kza61khU+K2tLppHR1yC1LLtxZOX9v2Njk+tz8cP+LBfzYvDekSweg==
X-Received: by 2002:a67:8c89:: with SMTP id o131mr14565483vsd.218.1592231827252;
        Mon, 15 Jun 2020 07:37:07 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id t2sm2334389vka.28.2020.06.15.07.37.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 07:37:06 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id i1so3984738vkp.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:37:06 -0700 (PDT)
X-Received: by 2002:a1f:280c:: with SMTP id o12mr18294000vko.92.1592231825528;
 Mon, 15 Jun 2020 07:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200612123003.v2.1.Ibe95d8f3daef01e5c57d4c8c398f04d6a839492c@changeid>
In-Reply-To: <20200612123003.v2.1.Ibe95d8f3daef01e5c57d4c8c398f04d6a839492c@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 15 Jun 2020 07:36:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W6d-Asap63+MDga26k2krfNOZ4ftcM1HPp3T0oXWdA0A@mail.gmail.com>
Message-ID: <CAD=FV=W6d-Asap63+MDga26k2krfNOZ4ftcM1HPp3T0oXWdA0A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drm/bridge: ti-sn65dsi86: Don't compile GPIO bits
 if not CONFIG_OF_GPIO
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sean Paul <seanpaul@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Sandeep Panda <spanda@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 12, 2020 at 12:31 PM Douglas Anderson <dianders@chromium.org> wrote:
>
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
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Changes in v2: None
>
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

The kernel test robot gave me another yell over the weekend.  I think
the whole series is ready to land, but if nothing else could at least
patch #1 land to fix the build error so the robot is happy?

-Doug
