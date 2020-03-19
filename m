Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32289C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 19:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F992070A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 19:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="snEHPqIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbgCSTI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 15:08:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37798 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbgCSTI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 15:08:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id a32so1765521pga.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 12:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zlKmJ2002BFVX2ZXxYBAvMXUqHfOUCBNDSCbpquzDD4=;
        b=snEHPqIWVHGADR5tx1NSp9UdpaVA8/qSH0Y5/qNyPUv+rOJjSnBcUlIRiOvg5qGYfL
         Q0tqqT+WC6ncGdFoDlIF7JUnLpTq+8HNiQrPwREwNfEW6ccu1EfFnJGPPdC4QyPRIIkp
         5RU3tBCF0kyWrOjXuVq9gYlrQdYaJJZ4/ZC7Z9KyzK+xElRq3r8I5gDp8n+sQZ+0W38g
         9DxL/vlgYcKiUR6T9xbGsce4Mt/ky+5U1OQKf6naER91G1OxbNLCCOJZYSISWKf15TgW
         FvD6EyKTUeYndw15/zS7RolG/uv7r0CmrelG4NlIXeVSxIqx02wVEeSlC9EqCUFmWboR
         k5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zlKmJ2002BFVX2ZXxYBAvMXUqHfOUCBNDSCbpquzDD4=;
        b=CmCokaSVwCx+YcCAyNI8/JQ/FHdsaTkr/aKekHenEoeLAPEPpVb+G/vjIvC+gzJt1V
         u+bG8App70S1ewwVg2UrzY/U15Gz0H7Q1fD/FA32dBrJ79rvuED6as/kt84O7plb5TP1
         LtZaYiLmAi+EmIuUC353esWlWWNSlGFRcNHcs2J3bnDSiZALMXRxo1IWAi25H5gq06cz
         eqa3y+wVkePoxNepLBFKC3MN1T4fRtT0VWy6aezCUIEVmvEGvq3+jpATXid3egnTbufm
         jVqeMW3kW4KJ1T7WGY5F1LPx4xUil26Bue8VXOHQNeE0MkDhnE0GV7xsMFRt0mwkgEwf
         CtCA==
X-Gm-Message-State: ANhLgQ0ztbqQl8xuOxEPRJYdeSsFqGozrMVbetyS0acQzHwR1cuEA4j6
        SzuMyAkwPWKrJRKZuGWPZWA4Xw==
X-Google-Smtp-Source: ADFU+vvbguubW7E6FOD/bR6UAFbsfiXhbysyZNZA0X02MHIz8KIBZKkLDrSYMWTpjPPb3cT9rshHyA==
X-Received: by 2002:a62:b604:: with SMTP id j4mr5635879pff.93.1584644933964;
        Thu, 19 Mar 2020 12:08:53 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f8sm3151821pfn.2.2020.03.19.12.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:08:53 -0700 (PDT)
Date:   Thu, 19 Mar 2020 12:08:51 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm: Don't attempt to attach HDMI bridge twice
Message-ID: <20200319190851.GB458947@yoga>
References: <20200319043741.3338842-1-bjorn.andersson@linaro.org>
 <CAF6AEGtvSZOp48hyrBUzqQLV6+twtuy6k6MLimz6fhC-dqWEVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGtvSZOp48hyrBUzqQLV6+twtuy6k6MLimz6fhC-dqWEVA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19 Mar 11:19 PDT 2020, Rob Clark wrote:

> On Wed, Mar 18, 2020 at 9:39 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > With the introduction of '3ef2f119bd3e ("drm/msm: Use
> > drm_attach_bridge() to attach a bridge to an encoder")' the HDMI bridge
> > is attached both in msm_hdmi_bridge_init() and later in
> > msm_hdmi_modeset_init().
> >
> > The second attempt fails as the bridge is already attached to the
> > encoder and the whole process is aborted.
> >
> > So instead make msm_hdmi_bridge_init() just initialize the hdmi_bridge
> > object and let msm_hdmi_modeset_init() attach it later.
> >
> > Fixes: 3ef2f119bd3e ("drm/msm: Use drm_attach_bridge() to attach a bridge to an encoder")
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Thanks, I think this should also be solved by:
> 
> https://patchwork.freedesktop.org/patch/357331/?series=74611&rev=1

Yes, didn't find that when looking yesterday. T-b and R-b.

Thanks,
Bjorn

> 
> BR,
> -R
> 
> > ---
> >  drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 19 +++----------------
> >  1 file changed, 3 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> > index 6e380db9287b..0e103ee1b730 100644
> > --- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> > +++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> > @@ -271,31 +271,18 @@ static const struct drm_bridge_funcs msm_hdmi_bridge_funcs = {
> >  /* initialize bridge */
> >  struct drm_bridge *msm_hdmi_bridge_init(struct hdmi *hdmi)
> >  {
> > -       struct drm_bridge *bridge = NULL;
> >         struct hdmi_bridge *hdmi_bridge;
> > -       int ret;
> > +       struct drm_bridge *bridge;
> >
> >         hdmi_bridge = devm_kzalloc(hdmi->dev->dev,
> >                         sizeof(*hdmi_bridge), GFP_KERNEL);
> > -       if (!hdmi_bridge) {
> > -               ret = -ENOMEM;
> > -               goto fail;
> > -       }
> > +       if (!hdmi_bridge)
> > +               return ERR_PTR(-ENOMEM);
> >
> >         hdmi_bridge->hdmi = hdmi;
> >
> >         bridge = &hdmi_bridge->base;
> >         bridge->funcs = &msm_hdmi_bridge_funcs;
> >
> > -       ret = drm_bridge_attach(hdmi->encoder, bridge, NULL, 0);
> > -       if (ret)
> > -               goto fail;
> > -
> >         return bridge;
> > -
> > -fail:
> > -       if (bridge)
> > -               msm_hdmi_bridge_destroy(bridge);
> > -
> > -       return ERR_PTR(ret);
> >  }
> > --
> > 2.24.0
> >
