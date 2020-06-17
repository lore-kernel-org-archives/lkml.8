Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162D4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E91E52089D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xh1zc5cv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgFQRXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgFQRXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 13:23:13 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFCDC0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 10:23:12 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id v6so1024238uam.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 10:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OnWnquHlT/ltYTFNOPUHSh/iGSUA1c4DqQQurVsebw8=;
        b=Xh1zc5cvq0KeGeKe9/EMOtxNnm0G2z0Rf2LfQ7DfSbytlWYqX6TDlwuE81rzzG74qY
         RbK/RQqrrCu8cQP/sDw3TD37jNJpQRTkRMSPvp7VMoEAnyyE/AQQx7GqQmatJJn3bPup
         Es06CH2SxxxZMpdKRMBPxDYp7T/H/08kX2iMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OnWnquHlT/ltYTFNOPUHSh/iGSUA1c4DqQQurVsebw8=;
        b=lnu6vw4/a8Ks1HkCcvWbZ6zIhei8tyXh0KUfLWDa9c2pkOpaBc2LJ6+mzjEnjlYesK
         TNQBvGlIWf4B4gBi5N/2EwSkzHJTw3KdZJh2BwKyZgi/nfeOHWqdevx2z6HlXK16eRuq
         hqWgTz7IdrLq6iQYRzfUuKPgjmDaTDbxqkdkE23dWfKvoARaUD5vMxnP+nfx4j7hmawV
         HXxkZ18WdJalGCrpCdog28XmVCHttPT+VzADoFRfh1RvHvRTuvuEcxkvy1cCEp4hbVGD
         9ZQsYXXTb1lUYEkw3yXCG4qk7jT1CcshU6EXlN8gKt//DfH8GYIle2HI9FUiLFAxmSuz
         7zVQ==
X-Gm-Message-State: AOAM533jJtXpFmEfe5uMegsY3SojOSnS/nIDOw1VTwJRqv38hbw4vCBe
        dh32dQw27Sa/6gCOfJ/lc05FHKIdTzA=
X-Google-Smtp-Source: ABdhPJzqwLK8PFqha1YLFCXGH36EShV+kifswNDPITlCy/bhLU3MRb2Crmue3LfHr/94qBu5i9hwaQ==
X-Received: by 2002:a9f:2581:: with SMTP id 1mr43353uaf.18.1592414591087;
        Wed, 17 Jun 2020 10:23:11 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id s65sm49996vss.5.2020.06.17.10.23.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 10:23:10 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id u17so1850987vsu.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 10:23:09 -0700 (PDT)
X-Received: by 2002:a05:6102:20c8:: with SMTP id i8mr205487vsr.106.1592414588681;
 Wed, 17 Jun 2020 10:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200617145116.247432-1-dianders@chromium.org>
 <20200617074930.v3.2.I3b5c3bfaf5fb2d28d63f1b5ee92980900e3f8251@changeid> <254998b9-c45e-bd6b-bc9a-b5934c0fea8e@linaro.org>
In-Reply-To: <254998b9-c45e-bd6b-bc9a-b5934c0fea8e@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 17 Jun 2020 10:22:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vec5FVrDVkmUQTfa6bP+1d3yOtj_FsgVAFdHLLbZ8VDA@mail.gmail.com>
Message-ID: <CAD=FV=Vec5FVrDVkmUQTfa6bP+1d3yOtj_FsgVAFdHLLbZ8VDA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: nvmem: Add properties needed for
 blowing fuses
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, dhavalp@codeaurora.org,
        mturney@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Ravi Kumar Bokka <rbokka@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        sparate@codeaurora.org, mkurumel@codeaurora.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 17, 2020 at 8:19 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
>
> On 17/06/2020 15:51, Douglas Anderson wrote:
> > From: Ravi Kumar Bokka <rbokka@codeaurora.org>
> >
> > On some systems it's possible to actually blow the fuses in the qfprom
> > from the kernel.  Add properties to support that.
> >
> > NOTE: Whether this is possible depends on the BIOS settings and
> > whether the kernel has permissions here, so not all boards will be
> > able to blow fuses in the kernel.
> >
> > Signed-off-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Add an extra reg range (at 0x6000 offset for SoCs checked)
> > - Define two options for reg: 1 item or 4 items.
> > - No reg-names.
> > - Add "clocks" and "clock-names" to list of properties.
> > - Clock is now "sec", not "secclk".
> > - Add "vcc-supply" to list of properties.
> > - Fixed up example.
> >
> >   .../bindings/nvmem/qcom,qfprom.yaml           | 45 ++++++++++++++++++-
> >   1 file changed, 43 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> > index 5efa5e7c4d81..b195212c6193 100644
> > --- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> > +++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> > @@ -17,8 +17,27 @@ properties:
> >       const: qcom,qfprom
> >
> >     reg:
> > -    items:
> > -      - description: The corrected region.
> > +    # If the QFPROM is read-only OS image then only the corrected region
> > +    # needs to be provided.  If the QFPROM is writable then all 4 regions
> > +    # must be provided.
> > +    oneOf:
> > +      - items:
> > +          - description: The corrected region.
> > +      - items:
> > +          - description: The corrected region.
> > +          - description: The raw region.
> > +          - description: The config region.
> > +          - description: The security control region.
> > +
> > +  # Clock must be provided if QFPROM is writable from the OS image.
> > +  clocks:
> > +    maxItems: 1
>
>
> > +  clock-names:
> > +    const: sec
>
> Do we need clock-names for just one clock here?

I think technically you can get by without, but convention is that
clock-names are always provided for clocks.  It's talked about in the
same link I sent that talked about reg-names:

https://lore.kernel.org/r/CAL_Jsq+MMunmVWqeW9v2RyzsMKP+=kMzeTHNMG4JDHM7Fy0HBg@mail.gmail.com/

Specifically, Rob said:

> That probably is because the clock binding has had clock-names from
> the start (it may have been the first one). That was probably partly
> due to the clock API also was mainly by name already if we want to
> admit Linux influence on bindings

Basically the standard way for getting clocks in Linux is
clk_get(name).  With just one clock you can call clk_get(NULL) and I
believe that works, but when you add the 2nd clock then you have to
switch APIs to one of the less-commonly-used variants.

-Doug
