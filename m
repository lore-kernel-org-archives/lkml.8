Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8838C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 20:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 945E821841
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 20:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NTiOrafa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgDQU4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 16:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgDQU4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 16:56:50 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC941C061A0F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 13:56:48 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id 1so2041551vsl.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 13:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nTPDJ1FZx21ZUdm/rZe6vuNjgKbQ4V6e3Md/8z5QSYQ=;
        b=NTiOrafaduGKDmVfB6vAvc2mWdTspMay2fHcWX+kFb/9rqtwB1ixoAxjzkdoDWotNU
         cJPXhjrUZPXQpMjnVmPFTyNGXTFPAxaFIEJ+J06zvtyOEqhWnIlMm7m494gCUii9ggCA
         1t8AcHugDOTujupYSZCzSQt7zsOSByyoz29Tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nTPDJ1FZx21ZUdm/rZe6vuNjgKbQ4V6e3Md/8z5QSYQ=;
        b=jx6ILgyUmxDWv4ETxiqRhBemFq+u4tXkpCcmizlj5zt3t4DiJW34Uf0HxXvmiIh63i
         UA3X+qB4hFTeZsoSJ8h1Mb2xyFJksIge2d/K28mfpiEJ/SVxpLUf+Gl1pZq3xgHXdsxX
         ob3lNnyGz2Bi+GKUe2tTTwlt7AcXRXgUSa4x7MdOgSP5iJ4cN7V2vweCA85UbUoE2OQa
         qpL6t8JOOLFA2P2T9cfiEwCCUmMouMZLwTZrulL/JGVD/zXKCi57qA9yYO3k7HertHGB
         2afiRH9wR82/nsD+AKk0KpmkjwAgTRQ8HmqQP84fyw1lPkWJImSbC0kLscisyy6VebcZ
         NOyQ==
X-Gm-Message-State: AGi0PuaIDvSPyBpwC+zJN4JIr0IEgssogqURRQvePRA6YcNfV0cIurYZ
        Dz7tzUkPUJxdKV7HMLj/2govlSoDhUc=
X-Google-Smtp-Source: APiQypJLnwAo4pzoegSIZf5nsdi2/e3cDSlVjcJleESFiT0t3gXILDZjvveXU6OrfRxesXW27hf5xw==
X-Received: by 2002:a67:28c7:: with SMTP id o190mr4421242vso.48.1587157007572;
        Fri, 17 Apr 2020 13:56:47 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id m82sm7089274vke.53.2020.04.17.13.56.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2020 13:56:46 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id b5so2074549vsb.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 13:56:46 -0700 (PDT)
X-Received: by 2002:a67:1e46:: with SMTP id e67mr4201742vse.106.1587157005954;
 Fri, 17 Apr 2020 13:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <1587107546-7379-1-git-send-email-kalyan_t@codeaurora.org>
In-Reply-To: <1587107546-7379-1-git-send-email-kalyan_t@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 17 Apr 2020 13:56:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WmiXRJF77Nd0JEr-6WDGpJvxt4as6YJJUZdKo6c0NuvQ@mail.gmail.com>
Message-ID: <CAD=FV=WmiXRJF77Nd0JEr-6WDGpJvxt4as6YJJUZdKo6c0NuvQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: ensure device suspend happens during PM sleep
To:     Kalyan Thota <kalyan_t@codeaurora.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        mkrishn@codeaurora.org, travitej@codeaurora.org,
        nganji@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 17, 2020 at 12:13 AM Kalyan Thota <kalyan_t@codeaurora.org> wrote:
>
> "The PM core always increments the runtime usage counter
> before calling the ->suspend() callback and decrements it
> after calling the ->resume() callback"
>
> DPU and DSI are managed as runtime devices. When
> suspend is triggered, PM core adds a refcount on all the
> devices and calls device suspend, since usage count is
> already incremented, runtime suspend was not getting called
> and it kept the clocks on which resulted in target not
> entering into XO shutdown.
>
> Add changes to force suspend on runtime devices during pm sleep.
>
> Changes in v1:
>  - Remove unnecessary checks in the function
>     _dpu_kms_disable_dpu (Rob Clark).
>
> Changes in v2:
>  - Avoid using suspend_late to reset the usagecount
>    as suspend_late might not be called during suspend
>    call failures (Doug).
>
> Changes in v3:
>  - Use force suspend instead of managing device usage_count
>    via runtime put and get API's to trigger callbacks (Doug).
>
> Changes in v4:
>  - Check the return values of pm_runtime_force_suspend and
>    pm_runtime_force_resume API's and pass appropriately (Doug).
>
> Signed-off-by: Kalyan Thota <kalyan_t@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c |  2 ++
>  drivers/gpu/drm/msm/dsi/dsi.c           |  2 ++
>  drivers/gpu/drm/msm/msm_drv.c           | 14 +++++++++++++-
>  3 files changed, 17 insertions(+), 1 deletion(-)

I am most certainly not an expert in this code, but as far as I can
tell it looks sane.  Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

-Doug
