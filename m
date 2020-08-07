Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA6FC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC4422065E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h8dgkoz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHGQLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHGQLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 12:11:45 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BEBC061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 09:11:44 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id c16so2615939ejx.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 09:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y9D1KRUva+vEZ2yw/RUAbLSmKMRhybgAq31n6MCUn2w=;
        b=h8dgkoz8y/OiP85im29r03TQUoi5ZKfJewD54te1FYPtv/KEpTqZ+Da+Zaa0mlPEzE
         csDJUwYUPnrshDjQ6xV40Ux3iDsSemGp/pg5DQtAWRaB1aGrbcaG9gUW+rtMRRyLTgQ1
         ncC2qUcZI2kRdy542DbHxGfUEqUYiTPyZUafAliFIznk/rTpMgi5ASJ+4ySkCniKIYMH
         NT/hAK1qje2Ml/rNoKixLn77hnR0JvTBdLS+KtPpJPZMdhr7cQOtZqWHfQgUL/vZkkk7
         E9brMTW0uk6z/ioIWdFAof0g60jFqE3pnegpob1E+DCmYgk2LVRWhJjiwf5Qz2gjAWiK
         Gb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y9D1KRUva+vEZ2yw/RUAbLSmKMRhybgAq31n6MCUn2w=;
        b=nIwplEVC+YAPEuGC9z8kKijQcVaB9F1TQJNp0Y4PxpX8v/TA35RFG9VRoIJhAr+t92
         AKrQKOkXR3/wy2ypP/MAW4/rEGcWMcJvgl/Kunp0LRGUpnEbIC+O92fkJGUzdJFS5kAf
         MPLj98VaQ/yhlA0pr/ykZmVcRMXIb8LnowFoR/5rgBz+tOeo/mIYKNQbT2cQOgXqB65b
         vjMgXgrPlSaV2GSAf/DNRNVGls7xkoDj+k2LygBzRGI1XQKKVz/j+zVF4rcLfti/bxz7
         l0i9urdSek+jHeLQiwoBzcGjMUgs0Aq/9I6fgNIwEmAdxbbLW2jB/CsMFrme47Nv+QV2
         7RfA==
X-Gm-Message-State: AOAM5322Ip3oNms0iAm1qGyXFI8ykOdLIQHaaa9A6amHEpyWKPi2I+Gc
        0dAi83n5xW1fk2Wh6n/mKfOvpnVPJKaY+cBDluj9Qw==
X-Google-Smtp-Source: ABdhPJyrYrsX5pEESa8H+K7koPpEjRogCNgaqAF5EHjcrBUY1fHtp+5JeCDPHY/P9J9KeauYe50jhbLLuLbLdMYGuqM=
X-Received: by 2002:a17:906:9399:: with SMTP id l25mr9939694ejx.212.1596816703233;
 Fri, 07 Aug 2020 09:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200807071718.17937-1-tanmay@codeaurora.org> <20200807071718.17937-3-tanmay@codeaurora.org>
 <b0e8415f-53e6-575d-5774-5f4f7adca982@infradead.org> <CAF6AEGvLrR2LPTF2DDEcxRwQY+pEEcooZh=NBSr5WOs+TUk0Dw@mail.gmail.com>
In-Reply-To: <CAF6AEGvLrR2LPTF2DDEcxRwQY+pEEcooZh=NBSr5WOs+TUk0Dw@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 7 Aug 2020 09:11:32 -0700
Message-ID: <CABXOdTeYOVWKNWfJxxVDC6Mdu1aisCs6yDCAdxRQGuUp8r2EQA@mail.gmail.com>
Subject: Re: [PATCH v9 2/5] drm/msm/dp: add displayPort driver support
To:     Rob Clark <robdclark@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, aravindh@codeaurora.org,
        Abhinav Kumar <abhinavk@codeaurora.org>, khsieh@codeaurora.org,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Vara Reddy <varar@codeaurora.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 7, 2020 at 8:48 AM Rob Clark <robdclark@gmail.com> wrote:
>
> On Fri, Aug 7, 2020 at 8:37 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > On 8/7/20 12:17 AM, Tanmay Shah wrote:
> > > diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> > > index 6deaa7d01654..ea3c4d094d09 100644
> > > --- a/drivers/gpu/drm/msm/Kconfig
> > > +++ b/drivers/gpu/drm/msm/Kconfig
> > > @@ -57,6 +57,14 @@ config DRM_MSM_HDMI_HDCP
> > >       help
> > >         Choose this option to enable HDCP state machine
> > >
> > > +config DRM_MSM_DP
> > > +     bool "Enable DP support in MSM DRM driver"
> >
> >         bool "Enabled DisplayPort support in MSM DRM driver"
> >
> > > +     depends on DRM_MSM
> > > +     help
> > > +       Compile in support for DP driver in msm drm driver. DP external
> >
> >                                               MSM DRM
> >
> > Also:
> > I can't find anywhere in drivers/gpu/drm/msm/ that explains what MSM means.
> > What does it mean?
>
> I believe it stands for "Mobile Station Modem".. in the pre-devicetree
> days it was the name of the qcom platform.  Things later shifted to
> "qcom" instead, but that was after this driver was merged.  At this
> point it is just three letters ;-)
>

FWIW: https://en.wikichip.org/wiki/qualcomm/msm

Guenter

> BR,
> -R
>
> > > +       display support is enabled through this config option. It can
> > > +       be primary or secondary display on device.
> > > +
> > >  config DRM_MSM_DSI
> > >       bool "Enable DSI support in MSM DRM driver"
> > >       depends on DRM_MSM
> >
> > thanks.
> > --
> > ~Randy
> >
