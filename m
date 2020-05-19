Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B25BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 23:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7960720829
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 23:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hyFWCJ1j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgESX0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 19:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbgESX0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 19:26:05 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09A3C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 16:26:04 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w19so537451ply.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 16:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o1nk3e7Hsby7x4Ub20aIHxa82tR9fW/umMvTM9rKISk=;
        b=hyFWCJ1ji28KGi7XMbjo2ZeeZD9a4yQ3KrtWD0u9ykevNP52LvLwXh0wfok0MP56km
         pEKk9ZSP4HEpLOWsEX1apDTwk/+Uc8bXuDbiYRaRZTwtTSXYWD35qFT9E8XPWJtqm8B8
         VNjzUCl57jqbgGeUX06EhWqfO+b3qhoONqJmEcrldnVVSPYftOWl+imwh7jPXAyOhuOe
         7AX7QH5RZ6bDFIiUIeWcNjAyQ9Bd0soIsGrZPWf9wp8xkbM1JMaPFpaVphJMswuIwiLF
         jVfCFDKg8LN13dAJH/pQ7wNsnlAMS80pwFrQbIyYWUIaG08ccDoJD78Dc+TM++spUHUE
         dv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o1nk3e7Hsby7x4Ub20aIHxa82tR9fW/umMvTM9rKISk=;
        b=hZTGnELRuvqoDtKf6c6Ev0RqwgL8SRCu/It84722JTzVU3Obze7cNv/IjgxrdAG74J
         YQxP1ofnYyUg2NpZVHsDf0tFCTYZJI/Qpv0RVN92V8Wt1EZmx0TLn4orqxD1GwjvsFxL
         BB7f26hDXvPPNRhRFCOUH+C7HVF11Z7dUFpg+MHTbdHnO3aESYtlZvJUEtGhG8LI/KV9
         uZgoYc2Hw0C67PMs6uHDieCmg/WQlA1srBm+Elivsl3eR5FfcMzZBKHtt2iQRVOfbCiV
         TnmT0Ub2itGDCgs40OYIfNliAxvZI9Dxa20W8izf2pgA2q7/UeFVbSyiFxkiWW2xubSF
         /4qw==
X-Gm-Message-State: AOAM532NPyNbJp0g1LBM7Wufz7WuHzLIBtX531U7ZsDgJQ9gRYwMORmq
        IGTGsq+0qg4yOo3n1QsIjVjQlw==
X-Google-Smtp-Source: ABdhPJwIaUrLIl1h4oKC2Zpxord9bh4XxK3fZAdVQpeaxzA/bI1iAMfOCqAsvKQsdp773VOcn7w60g==
X-Received: by 2002:a17:902:ba8e:: with SMTP id k14mr1730650pls.85.1589930764297;
        Tue, 19 May 2020 16:26:04 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o11sm443867pfd.195.2020.05.19.16.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 16:26:03 -0700 (PDT)
Date:   Tue, 19 May 2020 16:24:42 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Robert Foss <robert.foss@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: Re: [PATCH v3] arm64: dts: qcom: apq8016-sbc-d3: Add Qualcomm
 APQ8016 SBC + D3Camera mezzanine
Message-ID: <20200519232442.GE2165@builder.lan>
References: <20200518082129.2103683-1-robert.foss@linaro.org>
 <20200519102256.GB8114@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519102256.GB8114@Mani-XPS-13-9360>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19 May 03:22 PDT 2020, Manivannan Sadhasivam wrote:

> Hi Robert,
> 
> On Mon, May 18, 2020 at 10:21:29AM +0200, Robert Foss wrote:
> > Add device treee support for the Qualcomm APQ8016 SBC, otherwise known as
> > the Dragonboard 410c with the D3Camera mezzanine expansion board.
> > 
> > The D3Camera mezzanine ships in a kit with a OmniVision 5640 sensor module,
> > which is what this DT targets.
> > 
> 
> What is the motivation behind adding this new dts? We have been using the
> userspace tool [1] for applying this as an overlay for some time. But if we
> start adding dts for mezzanines then for sure we'll end up with some good
> numbers which will flood arch/{..}/qcom directory.
> 
> I could understand that one of the motivation is to provide nice user experience
> to users but that's also taken care by the dt-update tool IMO.
> 

The motivation for posting this was to provoke a response like yours.

I knew about [1], but not that it included the overlays. I'm okay with
using overlays and the dt-update tool. But I would have preferred that
the dts files didn't live out of tree, given that this approach breaks
if I change the name of a node you depend on upstream.

Thanks,
Bjorn

> Thanks,
> Mani
> 
> [1] https://github.com/96boards/dt-update
> 
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > ---
> > 
> > Changes since v2:
> >  - Vinod: Change copyright assignment to Linaro
> > 
> > Changes since v1:
> >  - Vinod: Changed license to GPL+BSD
> >  - Vinod: Changed copyright year to 2020
> >  - Nico: Changed name of mezzanine to d3camera
> > 
> >  arch/arm64/boot/dts/qcom/Makefile             |  1 +
> >  .../boot/dts/qcom/apq8016-sbc-d3camera.dts    | 45 +++++++++++++++++++
> >  2 files changed, 46 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc-d3camera.dts
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> > index cc103f7020fd..3f95b522694e 100644
> > --- a/arch/arm64/boot/dts/qcom/Makefile
> > +++ b/arch/arm64/boot/dts/qcom/Makefile
> > @@ -1,5 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
> > +dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc-d3camera.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
> >  dtb-$(CONFIG_ARCH_QCOM) += apq8096-ifc6640.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= ipq6018-cp01-c1.dtb
> > diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc-d3camera.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc-d3camera.dts
> > new file mode 100644
> > index 000000000000..752e5ec47499
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc-d3camera.dts
> > @@ -0,0 +1,45 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> > +/*
> > + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "apq8016-sbc.dtsi"
> > +
> > +/ {
> > +	model = "Qualcomm Technologies, Inc. APQ 8016 SBC w/ D3Camera Mezzanine";
> > +	compatible = "qcom,apq8016-sbc", "qcom,apq8016", "qcom,sbc";
> > +};
> > +
> > +&cci_i2c0 {
> > +	/delete-node/ camera_rear@3b;
> > +
> > +	camera_rear@76 {
> > +		compatible = "ovti,ov5640";
> > +		reg = <0x76>;
> > +
> > +		enable-gpios = <&msmgpio 34 GPIO_ACTIVE_HIGH>;
> > +		reset-gpios = <&msmgpio 35 GPIO_ACTIVE_LOW>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&camera_rear_default>;
> > +
> > +		clocks = <&gcc GCC_CAMSS_MCLK0_CLK>;
> > +		clock-names = "xclk";
> > +		clock-frequency = <23880000>;
> > +
> > +		vdddo-supply = <&camera_vdddo_1v8>;
> > +		vdda-supply = <&camera_vdda_2v8>;
> > +		vddd-supply = <&camera_vddd_1v5>;
> > +
> > +		status = "ok";
> > +
> > +		port {
> > +			ov5640_ep: endpoint {
> > +				clock-lanes = <1>;
> > +				data-lanes = <0 2>;
> > +				remote-endpoint = <&csiphy0_ep>;
> > +			};
> > +		};
> > +	};
> > +};
> > -- 
> > 2.25.1
> > 
