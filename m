Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8A3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C61421744
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SSP5OEKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgHGQKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgHGQKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 12:10:02 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91AEC061757
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 09:10:02 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id c16so2610513ejx.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 09:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e0+XcafvkYqFAISI9FsWYXqr0NzOr+9r9ZHvTjYtkXc=;
        b=SSP5OEKD8fj8yOVmeHuyAsd7v5SDawwciuLl0spQMxOn1ma+BoYKRaRpEMNGoBSqCw
         wHu499nyL9wVoU/h6acqvIropQ032VOLjJRuhf/0UGaesQO6e5UPVCy8fIN9e7J1BQHT
         yrH8BaIB+7/l2ZAnparNyoAIh2P1OrkzU+y5DXex7BxCn3s6Oe6WbRxPQIJMyHZUOxc7
         ZPPCNI6uYEhToABA87QGOi9nWIFXJ6cTXz9p4htArMo5RwDdkuJ+xkbfuZbrhVS7BMRa
         q4Lqlv6/40JS7T0d3rmheoRNp0NkEQSID42YY31Mv5Bx5IeDSetS5HCVwikDMePvA4js
         w2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e0+XcafvkYqFAISI9FsWYXqr0NzOr+9r9ZHvTjYtkXc=;
        b=LGn5pBZMsO5yg3O0aw9fqc8nYsNIFuh75qoTuBJ0oluZEQZ7UsNxF4CFiFQlAc8Edz
         CdYr14SwQ/0eZjiKUKFfwh8u3nR+LErs/Kd7/ucrrmYqbjhKvF3NWiC+t+uYFEf4QUDy
         NuUstkzqB8LU+MotPGCYmCtnoooMIYlujzQ7MDdfhYsDAdDC3/zwiFdzmKnXg2lGT98u
         XBxFh2nS4vY2Kfxl6vIeH+04v+/IibppWdXuJb3magWRCrRePrNftdhmzFj2coeK7X//
         JcDcAD2giPwG7S/3hXpeAGwBOXOXWxJ0xjAS/hVl/GcP1Ei/5bgvpE4EyT2yu735YgEI
         9IQg==
X-Gm-Message-State: AOAM533QU/eSwjpOb3G9FOo/Sx2CfTxR+POVjTJ7p+/oRVa/3W1TRmhR
        E2w4oLI3pMbOl6bUgSIv8/nQLWvy7JiSKvCN6lX8mg==
X-Google-Smtp-Source: ABdhPJzdcRdTkOs+1G2pCdfkm+OyrYACJDw4v+tP3FYbX5unsdmggkgMqGmRVjVfrIDE5rOzWCzhoWk91aR3GjYmu9g=
X-Received: by 2002:a17:906:e87:: with SMTP id p7mr9829318ejf.547.1596816600939;
 Fri, 07 Aug 2020 09:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200807071718.17937-1-tanmay@codeaurora.org> <20200807071718.17937-3-tanmay@codeaurora.org>
 <b0e8415f-53e6-575d-5774-5f4f7adca982@infradead.org>
In-Reply-To: <b0e8415f-53e6-575d-5774-5f4f7adca982@infradead.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 7 Aug 2020 09:09:50 -0700
Message-ID: <CABXOdTf6be2-O_aBakamNFswt+Xk0urJ7_x9hgwuuFO6=NDeew@mail.gmail.com>
Subject: Re: [PATCH v9 2/5] drm/msm/dp: add displayPort driver support
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Tanmay Shah <tanmay@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        freedreno@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, aravindh@codeaurora.org,
        abhinavk@codeaurora.org, khsieh@codeaurora.org,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Vara Reddy <varar@codeaurora.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 7, 2020 at 8:37 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 8/7/20 12:17 AM, Tanmay Shah wrote:
> > diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> > index 6deaa7d01654..ea3c4d094d09 100644
> > --- a/drivers/gpu/drm/msm/Kconfig
> > +++ b/drivers/gpu/drm/msm/Kconfig
> > @@ -57,6 +57,14 @@ config DRM_MSM_HDMI_HDCP
> >       help
> >         Choose this option to enable HDCP state machine
> >
> > +config DRM_MSM_DP
> > +     bool "Enable DP support in MSM DRM driver"
>
>         bool "Enabled DisplayPort support in MSM DRM driver"
>
Why "Enabled" ? This would be quite unusual for a Kconfig entry.

Guenter

> > +     depends on DRM_MSM
> > +     help
> > +       Compile in support for DP driver in msm drm driver. DP external
>
>                                               MSM DRM
>
> Also:
> I can't find anywhere in drivers/gpu/drm/msm/ that explains what MSM means.
> What does it mean?
>
> > +       display support is enabled through this config option. It can
> > +       be primary or secondary display on device.
> > +
> >  config DRM_MSM_DSI
> >       bool "Enable DSI support in MSM DRM driver"
> >       depends on DRM_MSM
>
> thanks.
> --
> ~Randy
>
