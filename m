Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD32AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863CC214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580240151;
	bh=Pr3DXFI8ViRGOKjh9h8Hz0BT7YyyVwuuTEjQR62AWt0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cQtvMgilEnY8d2xQuNyBk8PLCn+BvcloyJxk04S64mMZjZXNrxq59hJZWEN1rHNJB
	 ERxl+hPmujMDMxtxX2iWIwLGuzL9Q6y59fIVoNys99JDKNnPRvSOYtsrfImcxrE7XA
	 b4FBaJGhSUBmBQYY/gjWiA+Y3Sx/UXhSuxMACkjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgA1Tfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 14:35:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:52214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbgA1Tfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 14:35:48 -0500
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B3912064C;
        Tue, 28 Jan 2020 19:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580240147;
        bh=Pr3DXFI8ViRGOKjh9h8Hz0BT7YyyVwuuTEjQR62AWt0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WfvRLtX5hpTQMwySLxrZH8GpBe6ytT2T/lwnUPhmTFwO1NedUw8V0GQrveCaKQZ8P
         ohCoeR/PjFUr4GK+xsjvr1e1Pq9c1LysBmb5DmJrFbUPl09WXUa+7W+Bu+UrBIQItp
         rYcqUX1cq+HCR5fwJzxS2OI6cs7CxlP7xdhwju7I=
Received: by mail-qv1-f54.google.com with SMTP id s7so1170028qvn.8;
        Tue, 28 Jan 2020 11:35:47 -0800 (PST)
X-Gm-Message-State: APjAAAWi/iv3AL6h+1kMqcNvV/Ea21f5xWgO+aJ1F+/VdYQR5uzE6sfU
        KufMORa5aOOGo0lxCe13mPwyQYGbWOI7Q8j6WA==
X-Google-Smtp-Source: APXvYqwkmWB2OfVLFMVNplRokJbj3S/E+jDUH5hAvg+SvFAjOQiYU7rRQIIH/C6cNNowZ+CtFMHj5h56SknQFBBd9ec=
X-Received: by 2002:ad4:4511:: with SMTP id k17mr22775194qvu.135.1580240146421;
 Tue, 28 Jan 2020 11:35:46 -0800 (PST)
MIME-Version: 1.0
References: <20200128082013.15951-1-benjamin.gaignard@st.com>
 <20200128120600.oagnindklixjyieo@gilmour.lan> <a7fa1b43-a188-9d06-73ec-16bcd4012207@st.com>
In-Reply-To: <a7fa1b43-a188-9d06-73ec-16bcd4012207@st.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 28 Jan 2020 13:35:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ80kSU7bHJt0_SeX5FVfxxjN5-ZKxt+tOfGy2cV62cbQ@mail.gmail.com>
Message-ID: <CAL_JsqJ80kSU7bHJt0_SeX5FVfxxjN5-ZKxt+tOfGy2cV62cbQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: display: Convert etnaviv to json-schema
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux+etnaviv@armlinux.org.uk" <linux+etnaviv@armlinux.org.uk>,
        "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philippe CORNU <philippe.cornu@st.com>,
        Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 6:31 AM Benjamin GAIGNARD
<benjamin.gaignard@st.com> wrote:
>
>
> On 1/28/20 1:06 PM, Maxime Ripard wrote:
> > Hi Benjamin,
> >
> > On Tue, Jan 28, 2020 at 09:20:13AM +0100, Benjamin Gaignard wrote:
> >> Convert etnaviv bindings to yaml format.
> >>
> >> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> >> ---
> >>   .../bindings/display/etnaviv/etnaviv-drm.txt       | 36 -----------
> >>   .../devicetree/bindings/gpu/vivante,gc.yaml        | 72 ++++++++++++++++++++++
> >>   2 files changed, 72 insertions(+), 36 deletions(-)
> >>   delete mode 100644 Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
> >>   create mode 100644 Documentation/devicetree/bindings/gpu/vivante,gc.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt b/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
> >> deleted file mode 100644
> >> index 8def11b16a24..000000000000
> >> --- a/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
> >> +++ /dev/null
> >> @@ -1,36 +0,0 @@
> >> -Vivante GPU core devices
> >> -========================
> >> -
> >> -Required properties:
> >> -- compatible: Should be "vivante,gc"
> >> -  A more specific compatible is not needed, as the cores contain chip
> >> -  identification registers at fixed locations, which provide all the
> >> -  necessary information to the driver.
> >> -- reg: should be register base and length as documented in the
> >> -  datasheet
> >> -- interrupts: Should contain the cores interrupt line
> >> -- clocks: should contain one clock for entry in clock-names
> >> -  see Documentation/devicetree/bindings/clock/clock-bindings.txt
> >> -- clock-names:
> >> -   - "bus":    AXI/master interface clock
> >> -   - "reg":    AHB/slave interface clock
> >> -               (only required if GPU can gate slave interface independently)
> >> -   - "core":   GPU core clock
> >> -   - "shader": Shader clock (only required if GPU has feature PIPE_3D)
> >> -
> >> -Optional properties:
> >> -- power-domains: a power domain consumer specifier according to
> >> -  Documentation/devicetree/bindings/power/power_domain.txt
> >> -
> >> -example:
> >> -
> >> -gpu_3d: gpu@130000 {
> >> -    compatible = "vivante,gc";
> >> -    reg = <0x00130000 0x4000>;
> >> -    interrupts = <0 9 IRQ_TYPE_LEVEL_HIGH>;
> >> -    clocks = <&clks IMX6QDL_CLK_GPU3D_AXI>,
> >> -             <&clks IMX6QDL_CLK_GPU3D_CORE>,
> >> -             <&clks IMX6QDL_CLK_GPU3D_SHADER>;
> >> -    clock-names = "bus", "core", "shader";
> >> -    power-domains = <&gpc 1>;
> >> -};
> >> diff --git a/Documentation/devicetree/bindings/gpu/vivante,gc.yaml b/Documentation/devicetree/bindings/gpu/vivante,gc.yaml
> >> new file mode 100644
> >> index 000000000000..c4f549c0d750
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/gpu/vivante,gc.yaml
> >> @@ -0,0 +1,72 @@
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/gpu/vivante,gc.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Vivante GPU Bindings
> >> +
> >> +description: Vivante GPU core devices
> >> +
> >> +maintainers:
> >> +  -  Lucas Stach <l.stach@pengutronix.de>
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: vivante,gc
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +  interrupts:
> >> +    maxItems: 1
> >> +
> >> +  clocks:
> >> +    items:
> >> +      - description: AXI/master interface clock
> >> +      - description: GPU core clock
> >> +      - description: Shader clock (only required if GPU has feature PIPE_3D)
> >> +      - description: AHB/slave interface clock (only required if GPU can gate slave interface independently)
> > Can you have an AHB slave interface clock without a shader clock?
>
> No because the items in the list are ordered so you need to have, in
> order: "bus", "core", "shader", "reg"
>
> If it is needed to allow any number of clock in any order I could write
> it like this:

Yes, but I prefer we don't allow any order if we don't have to. Did
you run this schema against dtbs_check or just audit the dts files
with vivante?

Rob
