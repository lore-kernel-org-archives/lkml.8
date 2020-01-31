Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81646C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 16:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A54214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 16:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RfcRbQ+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgAaQ5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 11:57:08 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39959 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgAaQ5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 11:57:08 -0500
Received: by mail-pg1-f195.google.com with SMTP id k25so3763080pgt.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 08:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H4H/l/EMhFF6pY2BmwBr3TmDwgCoPTi4UEgr7Md8qb0=;
        b=RfcRbQ+i4VLsXYNxRUM2pBZ+l+GC+HGsPMX/v/dlzShiAEZ9cPp9WuDZE0di5Qjjqo
         jnk1Sv4jjo88FTcaEWIyZoHfr/vXtvqzDzavZlsBLly/w/rO4dUNs6ko5Cmhdb+3M9vY
         PcO9IZFZ3wzz3xfvyOfjjTQIbScbsZTZkKwy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H4H/l/EMhFF6pY2BmwBr3TmDwgCoPTi4UEgr7Md8qb0=;
        b=nQiOMAOZdXTp7hRFAt3wi8pJiAuRDeFQZXDyk/SgpbMBqMGLu6KSbtktzVMEBJ6lUF
         TFZ3PsEK5y97fb0bsMKy6FS+sYuUoWh10gRG1uw8HgLidAYdbxIaloFG4CcCmMn/xAN0
         tmx/sCAypc4kn9KnpenzRVkmsXBCzXTZwGLkFbz0u/0CxxDPyUP8kEyATfqSJvR/6uJw
         9iG6HpkQWQOSVDKBvi4H8ZmpNkuUufomesXS23fPSCleiQTLLtoLPR+Nl2Uql2o3Bb1h
         KrtQUeMu1F+8fgf94ss5CrozYWl/w7obsYKqonkBtl/HfgVAK3Hj4Rc2CHBKf5zfsnXy
         MfLw==
X-Gm-Message-State: APjAAAXXymTtsaS05NxTfW1Y4CYGOc4k/yVOOHwGXqp5+6hOfCD68X9c
        VEVwhVWqtc/tr8kNFny2FHPDDmAfvxY=
X-Google-Smtp-Source: APXvYqxX5Es/RZTwWnvGdAVuvUlF1rA6JRkZmamR6oSP/DVEwt04YaZ56aw0cU6tqkOk3VSklYY7Ww==
X-Received: by 2002:a63:8b44:: with SMTP id j65mr10952646pge.272.1580489826065;
        Fri, 31 Jan 2020 08:57:06 -0800 (PST)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com. [209.85.210.178])
        by smtp.gmail.com with ESMTPSA id m15sm10532727pgi.91.2020.01.31.08.57.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 08:57:05 -0800 (PST)
Received: by mail-pf1-f178.google.com with SMTP id 185so3641480pfv.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 08:57:05 -0800 (PST)
X-Received: by 2002:a67:e342:: with SMTP id s2mr7136533vsm.198.1580489329211;
 Fri, 31 Jan 2020 08:48:49 -0800 (PST)
MIME-Version: 1.0
References: <20200130211231.224656-1-dianders@chromium.org>
 <20200130131220.v3.7.I513cd73b16665065ae6c22cf594d8b543745e28c@changeid> <CAL_JsqLj8WbP=oXAovyVFOc-58eFr5xS5EJK=kpAK-eT7_TyNw@mail.gmail.com>
In-Reply-To: <CAL_JsqLj8WbP=oXAovyVFOc-58eFr5xS5EJK=kpAK-eT7_TyNw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 31 Jan 2020 08:48:37 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X=vAM7HZmA7pCm707rb8u+ogEqPUu_F_ueiS9GwbVwuw@mail.gmail.com>
Message-ID: <CAD=FV=X=vAM7HZmA7pCm707rb8u+ogEqPUu_F_ueiS9GwbVwuw@mail.gmail.com>
Subject: Re: [PATCH v3 07/15] dt-bindings: clock: Fix qcom,gpucc bindings for sdm845/sc7180/msm8998
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Harigovindan P <harigovi@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Matthias Kaehlcke <mka@chromium.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 31, 2020 at 8:43 AM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Jan 30, 2020 at 3:12 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > The qcom,gpucc bindings had a few problems with them:
> >
> > 1. When things were converted to yaml the name of the "gpll0 main"
> >    clock got changed from "gpll0" to "gpll0_main".  Change it back for
> >    msm8998.
> >
> > 2. Apparently there is a push not to use purist aliases for clocks but
> >    instead to just use the internal Qualcomm names.  For sdm845 and
> >    sc7180 (where the drivers haven't already been changed) move in
> >    this direction.
> >
> > Things were also getting complicated harder to deal with by jamming
> > several SoCs into one file.  Splitting simplifies things.
> >
> > Fixes: 5c6f3a36b913 ("dt-bindings: clock: Add YAML schemas for the QCOM GPUCC clock bindings")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Added pointer to inlude file in description.
> > - Everyone but msm8998 now uses internal QC names.
> > - Fixed typo grpahics => graphics
> > - Split bindings into 3 files.
> >
> > Changes in v2:
> > - Patch ("dt-bindings: clock: Fix qcom,gpucc...") new for v2.
> >
> >  .../devicetree/bindings/clock/qcom,gpucc.yaml | 72 -------------------
> >  .../bindings/clock/qcom,msm8998-gpucc.yaml    | 66 +++++++++++++++++
> >  .../bindings/clock/qcom,sc7180-gpucc.yaml     | 72 +++++++++++++++++++
> >  .../bindings/clock/qcom,sdm845-gpucc.yaml     | 72 +++++++++++++++++++
> >  4 files changed, 210 insertions(+), 72 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> >  create mode 100644 Documentation/devicetree/bindings/clock/qcom,msm8998-gpucc.yaml
> >  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7180-gpucc.yaml
> >  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sdm845-gpucc.yaml
>
> I'm not seeing any differences in sdm845 and sc7180. Do those really
> need to be separate? It doesn't have to be all combined or all
> separate.

They are the same, other than pointing to a different #include file.
I debated whether to put them in one file (arbitrarily named after one
SoC or the other) or to put them in individual files.  I got the
impression from Stephen that he'd prefer them to be separate files
even in the case that they were 99% identical, but I certainly could
have misunderstood.

I'll do whatever you guys agree to.  If you want them in one file I'll
probably name it "qcom,sdm845-gpucc.yaml" just because that SoC is
earlier, unless someone tells me otherwise.

-Doug
