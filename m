Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EF8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8269B214F1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WEQMKsvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgHGUYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgHGUYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 16:24:04 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245D7C061757
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 13:24:04 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id e4so1494309pjd.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 13:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=8kRWK6mpY0yuzrMz6VeBLLcMrpVG8ZtSX/iAsw+ut4A=;
        b=WEQMKsvxL+jGuutK/BX9GjKhG9V6iqjN0wIPhLgvikM+b48e3QcXAaeBfnLsnUbVQM
         sEPO5cpmUWUqe4CGQPLKERNzawMZGhiNtw2+3gnBjmoKN8srnzPI9ngJ2NslwuAjvSVk
         RgOZqa5CfaRROKBbMjMpTLlU7cxtbupJL0vwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=8kRWK6mpY0yuzrMz6VeBLLcMrpVG8ZtSX/iAsw+ut4A=;
        b=QU/sh1PVPce4EY1A9XhUuojv4mA7DbMEh1lnAyVfqWZ/fcg/aUjHmhLuGO5XshAArQ
         JSIH3gUz4RJY0t7wLYvLBI6JuU40VJDAbTbSlozKrZmTVawtD6J826O05c6/1qD8KCcG
         eLl6qcgeFpKaxSCugrsf5x69qcOQj/TQso62QaOnbnnZ0wLro/bpf2LIEXpX9zEsp8tf
         i77Lnk+T6KMnnfMSZLP1acJZIbaN3Xmh93O4o555fRTPWWpPLqc7xG1yP9IVMcKd+iXX
         cuDS/V55WHALWLmsjEYQT7mkvUUq5IyIlx/y/yECIyDIYMiljBRhCJPvX0Q19zunRGou
         BKWg==
X-Gm-Message-State: AOAM533sdVZgLnAoIb2Vc9eKLZVI3QUfQ+Xu4u83wFw2ptu0lVUux79m
        8oB/qM85GT8fX3jvrPGOVUOKMw==
X-Google-Smtp-Source: ABdhPJwUCMA+qcCj4NBJ6bH6GJrNHolYmVbC63o7ey2y7ucXrSodd1KiH1QHhuAQODHYrQ6iqRsEPQ==
X-Received: by 2002:a17:902:b089:: with SMTP id p9mr13616774plr.52.1596831843666;
        Fri, 07 Aug 2020 13:24:03 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id z23sm11490482pgv.57.2020.08.07.13.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 13:24:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAF6AEGv5Yf1x7aCEauP7XtzTjpUCxJt6_GzxFhFXyf_DX_Gi+g@mail.gmail.com>
References: <20200807071718.17937-1-tanmay@codeaurora.org> <20200807071718.17937-4-tanmay@codeaurora.org> <3b0d0e49-5fe8-e217-4ddc-1ff08e65ab48@infradead.org> <CAF6AEGv5Yf1x7aCEauP7XtzTjpUCxJt6_GzxFhFXyf_DX_Gi+g@mail.gmail.com>
Subject: Re: [PATCH v9 3/5] drm/msm/dp: add support for DP PLL driver
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Tanmay Shah <tanmay@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, aravindh@codeaurora.org,
        Abhinav Kumar <abhinavk@codeaurora.org>, khsieh@codeaurora.org,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Vara Reddy <varar@codeaurora.org>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Rob Clark <robdclark@gmail.com>
Date:   Fri, 07 Aug 2020 13:24:01 -0700
Message-ID: <159683184187.1360974.15575847254880429529@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Clark (2020-08-07 08:51:48)
> On Fri, Aug 7, 2020 at 8:27 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > On 8/7/20 12:17 AM, Tanmay Shah wrote:
> > > diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> > > index ea3c4d094d09..cc1392b29022 100644
> > > --- a/drivers/gpu/drm/msm/Kconfig
> > > +++ b/drivers/gpu/drm/msm/Kconfig
> > > @@ -60,6 +60,7 @@ config DRM_MSM_HDMI_HDCP
> > >  config DRM_MSM_DP
> > >       bool "Enable DP support in MSM DRM driver"
> > >       depends on DRM_MSM
> > > +     default y
> > >       help
> > >         Compile in support for DP driver in msm drm driver. DP extern=
al
> > >         display support is enabled through this config option. It can
> >
> > Hi,
> >
> > You need a very strong justification to make an optional part of a driv=
er
> > to be "default y".
>=20
> My opinion is that if the driver is built, everything should be built.
> This is what makes sense for distro's.  It is only the embedded case
> where you want to trim down unneeded features where you might want to
> disable some parts.  So 'default y' makes sense to me.
>=20

Maybe use 'default DRM_MSM' so that it doesn't trigger the 'default y'
filters people have?
