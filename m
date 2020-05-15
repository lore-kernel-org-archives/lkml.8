Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2EFC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C610206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AwQU4FZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgEOIbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 04:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727113AbgEOIbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 04:31:48 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EB1C05BD0A
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 01:31:48 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id v128so1519566oia.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 01:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qH+EwBLeoTrVnjbfZOg/tXxPcMHnGZvYgXulHKPhGds=;
        b=AwQU4FZ+/b1Gt5/SnZhbk1z+4qLxmM69app8fOWHEdscysuzaIgES+BUe0BsQxVfTt
         tHfXEGUATu9ZndTbYaNDMn+I0SC9ybzqrf4EXrWxgn+jKMmqpRbTx5LV5CUNhmq64VZJ
         rKItQltA814EtSEBq58E/Ug7Snd87vXNSNKK4VvjplKeI2mkmRn3N5Oklx1NNee1m7Hf
         qGkxPJPoCkbeg0HVbUdLbL3M35ds5gUUyAb6iXfBA5wuZj9epKU1K7ZambfaofWhgHa3
         8B2WtoO4BuLK6teLmgTmF3G7XYF5aXjcyZTFEyCjlMV71uMKIYUzAm4GBJis72cdGeqZ
         4a3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qH+EwBLeoTrVnjbfZOg/tXxPcMHnGZvYgXulHKPhGds=;
        b=ApAIuQ+dbAX8uMjxcGzTXJ22iwbhsHkLmytif7r9i6/3pE/fTfgPQIBOLhEcvbWRYn
         /VUaEG4R673GL8YoYXZNwGCIbMc+t+kAsytuRtybP50fLzFW76KoqgP79q9vAV3XLDvt
         54l0ZveCMAGnn/Pga0QlpcL7Jt3cKtnmAlbUoo8cMbNXGCgO8AvXD/p3Ofs9364f7Mjx
         1bz1Qm8tTLbQIDTO4e8hA72nQg0gsovph0gaG3J2Zg7EeZpG7M121gd1Hb6cS+wzBmn2
         RraAi8IYlC3kTxA4CIlZC9ARIKPf2jXgYYtG+eWCAXChXk5uj/LV2XBbFEwZbQNJbHKO
         flSA==
X-Gm-Message-State: AOAM531yRiFxnIgqNJR4P3a/YDFEzGPrSbQScLH5O37maB9jCtLB2i1G
        ZJ+1PrKQyCBJeSB93RqHHNKnJcdboWPlsTCTlQ/4Hg==
X-Google-Smtp-Source: ABdhPJy28bLOOaddFHAGxZVzh5D5A7M9Z00/42Bv2Msat2DEz6gGAy0wE+LNMGBCnOUDZRJIQNie/7RhEfsNWbjYGeA=
X-Received: by 2002:aca:f146:: with SMTP id p67mr1387057oih.56.1589531507959;
 Fri, 15 May 2020 01:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200422111014.616233-1-robert.foss@linaro.org> <20200514172223.GF14092@vkoul-mobl>
In-Reply-To: <20200514172223.GF14092@vkoul-mobl>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 15 May 2020 10:31:36 +0200
Message-ID: <CAG3jFyuaU-HNq4nnRQfz04a+t=pLvKz82vRpJi7r_KGxuSYC-A@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: qcom: apq8016-sbc-d3: Add Qualcomm APQ8016
 SBC + D3 mezzanine
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 May 2020 at 19:22, Vinod Koul <vkoul@kernel.org> wrote:
>
> On 22-04-20, 13:10, Robert Foss wrote:
> > Add device treee support for the Qualcomm APQ8016 SBC, otherwise known as
> > the Dragonboard 410c with the D3 mezzanine expansion board.
> >
> > The D3 mezzanine ships in a kit with a OmniVision 5640 sensor module,
> > which is what this DT targets.
> >
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/Makefile           |  1 +
> >  arch/arm64/boot/dts/qcom/apq8016-sbc-d3.dts | 45 +++++++++++++++++++++
> >  2 files changed, 46 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc-d3.dts
> >
> > diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> > index cc103f7020fd..025362471929 100644
> > --- a/arch/arm64/boot/dts/qcom/Makefile
> > +++ b/arch/arm64/boot/dts/qcom/Makefile
> > @@ -1,5 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  dtb-$(CONFIG_ARCH_QCOM)      += apq8016-sbc.dtb
> > +dtb-$(CONFIG_ARCH_QCOM)      += apq8016-sbc-d3.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      += apq8096-db820c.dtb
> >  dtb-$(CONFIG_ARCH_QCOM) += apq8096-ifc6640.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      += ipq6018-cp01-c1.dtb
> > diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc-d3.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc-d3.dts
> > new file mode 100644
> > index 000000000000..1b85adeeada1
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc-d3.dts
> > @@ -0,0 +1,45 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
>
> Dual BSD + GPL please

Thanks.

>
> > +/*
> > + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
>
> we are in 2020 now :)

Maybe I should fix that.
I'll change the name of the d3 mezzanine to d3camera as well.

>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "apq8016-sbc.dtsi"
> > +
> > +/ {
> > +     model = "Qualcomm Technologies, Inc. APQ 8016 SBC w/ D3 Mezzanine";
> > +     compatible = "qcom,apq8016-sbc", "qcom,apq8016", "qcom,sbc";
> > +};
> > +
> > +&cci_i2c0 {
> > +     /delete-node/ camera_rear@3b;
> > +
> > +     camera_rear@76 {
> > +             compatible = "ovti,ov5640";
> > +             reg = <0x76>;
> > +
> > +             enable-gpios = <&msmgpio 34 GPIO_ACTIVE_HIGH>;
> > +             reset-gpios = <&msmgpio 35 GPIO_ACTIVE_LOW>;
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&camera_rear_default>;
> > +
> > +             clocks = <&gcc GCC_CAMSS_MCLK0_CLK>;
> > +             clock-names = "xclk";
> > +             clock-frequency = <23880000>;
> > +
> > +             vdddo-supply = <&camera_vdddo_1v8>;
> > +             vdda-supply = <&camera_vdda_2v8>;
> > +             vddd-supply = <&camera_vddd_1v5>;
> > +
> > +             status = "ok";
> > +
> > +             port {
> > +                     ov5640_ep: endpoint {
> > +                             clock-lanes = <1>;
> > +                             data-lanes = <0 2>;
> > +                             remote-endpoint = <&csiphy0_ep>;
> > +                     };
> > +             };
> > +     };
> > +};
> > --
> > 2.25.1
>
> --
> ~Vinod
