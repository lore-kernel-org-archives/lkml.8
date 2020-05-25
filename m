Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F13DC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D5712071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D69DgVjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388812AbgEYIgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 04:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731246AbgEYIgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 04:36:02 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC1DC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:36:01 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id s198so15440868oie.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NRyvkXRye4iYanmLJM9esEpVEWDZpWUJeI38gHuM/d4=;
        b=D69DgVjlpmos8d57BUoJiWBpsjXn3XSt1iSRkr+MkDgZDWE5try1xRKerx9simqzAF
         6QMf+j8OVCNnVLGtBeTGYwPOGjATY/XS70Y1LO3yvCCFxE1gJSWZXgDeHU277tgQ9Yqe
         T5ylTRD/FbgCXV3yBDwHEITJ29FuG6AvFblhn+33/ZrnWAzvb5HJPz2HwaKjaq6Lr9lV
         qq1AIV9VSuqOLLrhXErp5vg2bFLaenpIAb71fAxU2da0qs0a5DRSywo3gmKAEpN5jJMl
         dSROMusTv0v3AFNCIUeyL/WudiYqfwQ3h7GnjW2u3qAONGrOJTve0zSUi8g5tWeMPKhi
         iI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NRyvkXRye4iYanmLJM9esEpVEWDZpWUJeI38gHuM/d4=;
        b=bqpe6g3MpO3C/vyj8IAXVDygVxaqyAj/znOp5mDt/1a62VZP7bdJeWre6a/U3rDNvI
         GY0BpWyCkd83exOEKl+brxLCXDdiod9dSHKrqqVB7AnWDnppjl2o0YwTT2We3RoSIwm0
         fJAIKLH8QV8NIMf2g34WTQIdWAwqPat4ZRFPWlA7dp013gNis9Ti/U62BD+ukXHae+7V
         XpfJYhqw8HKHhYoEJG8irHARc2HTDJDDX87IE1OR6b8m6eKtW9kIdagYz4b0hP2BglCy
         gYacQ4R4wh+Xz94j7aHxtqVx7wRn1Vo5QHrK833veZvGOq1nVNW7zydIcspjhmAuiJj9
         Grtg==
X-Gm-Message-State: AOAM530+bNNuh46V0RaY/AJgtrEiYoF4HdHSIGimtieAzRX3rqJqH+0A
        TB9arRRqgfcu+6yVlIoJpcHbFsy7Dax+PPjoNtqJIQ==
X-Google-Smtp-Source: ABdhPJxIrQuW5N7Il7y0ZdJ5sA7xOTsYPnibkCKplJ1Fr7FxMg6AgD+RBAREa2r3PHYpGN46pbDyNDGJWwX9BuuN0dE=
X-Received: by 2002:aca:4ad6:: with SMTP id x205mr11033941oia.56.1590395761206;
 Mon, 25 May 2020 01:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200518082129.2103683-1-robert.foss@linaro.org>
 <20200519102256.GB8114@Mani-XPS-13-9360> <20200519232442.GE2165@builder.lan>
In-Reply-To: <20200519232442.GE2165@builder.lan>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 25 May 2020 10:35:50 +0200
Message-ID: <CAG3jFytUvfwFKvysKpRhrRRAotMv-epQZA3zq8DG0QdrQMpfyg@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: qcom: apq8016-sbc-d3: Add Qualcomm APQ8016
 SBC + D3Camera mezzanine
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Thanks for the review. I'll incorporate the changes if we decide to
that this DT should live upstream.

On Wed, 20 May 2020 at 01:26, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Tue 19 May 03:22 PDT 2020, Manivannan Sadhasivam wrote:
>
> > Hi Robert,
> >
> > On Mon, May 18, 2020 at 10:21:29AM +0200, Robert Foss wrote:
> > > Add device treee support for the Qualcomm APQ8016 SBC, otherwise known as
> > > the Dragonboard 410c with the D3Camera mezzanine expansion board.
> > >
> > > The D3Camera mezzanine ships in a kit with a OmniVision 5640 sensor module,
> > > which is what this DT targets.
> > >
> >
> > What is the motivation behind adding this new dts? We have been using the
> > userspace tool [1] for applying this as an overlay for some time. But if we
> > start adding dts for mezzanines then for sure we'll end up with some good
> > numbers which will flood arch/{..}/qcom directory.
> >
> > I could understand that one of the motivation is to provide nice user experience
> > to users but that's also taken care by the dt-update tool IMO.
> >
>
> The motivation for posting this was to provoke a response like yours.
>
> I knew about [1], but not that it included the overlays. I'm okay with
> using overlays and the dt-update tool. But I would have preferred that
> the dts files didn't live out of tree, given that this approach breaks
> if I change the name of a node you depend on upstream.

I wasn't aware of the dt-update tool, and it seems pretty neat.
However, a thought I had is that using it to enable a dt-node or a
board variant is not very different from applying a patch the the
upstream tree. The work it takes to do it is about the same, and the
maintenance burden of using a patch is about the same as using
dt-tool.

> > [1] https://github.com/96boards/dt-update
