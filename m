Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFC6C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A47020758
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TIbkUtCw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbgESKXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 06:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgESKXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 06:23:04 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E52C05BD0A
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 03:23:03 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n11so6179520pgl.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 03:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GQe9KMB2kqiw5JPO5UGD3SLSZt+HtAllRarrzvhgqqQ=;
        b=TIbkUtCwuBgOInmLmiG7Hc3G2gu7E+9dN9+ZzJ9tM99uSq5liBw/XsGSHoXYaw56Dv
         4YnCbnZyerH1I9Emfx9wZKta2DEfoPY+RsiXXN5HJzix5plLOYux4ZJPMWj4W6ioMuwM
         PA6QchCxIJeeUjZuPTNNRzj6mZYe+7FPOckH2vQnuQp0oUGRoNCxD7TGZynUhMDQBzAb
         PPNAL5dw2eZkyykpLJWibbCG/QDzP1PHqFnZXldDYrvEuNpuuqQLAYokWJvfLZlO8P+N
         FCtKfqeDYXZ5vzL+mq69487lWDWC/bZys51tAq+vybkc4eASXy0rd9wLNyxPNhegSd8L
         W0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GQe9KMB2kqiw5JPO5UGD3SLSZt+HtAllRarrzvhgqqQ=;
        b=DIiOUQ/DuI52x4xpGsP/DW1L1jfqY2BP2LowUgsz6dRud+EhUpPcIBfhKd/0hwB+BS
         jx5dmfT8U0vTJOXkrwJ9naJ3ZJF5fJhNl/4/OnX4w4eiqKB32tbNC1z9rXu2UH8Ak/u4
         igO6/49JfaUqLMjyaJOjCzPFfQ4MT63C1l/nTH+oEb+TlSjsKKshOXxicRqNheoR00J6
         pS+HJINryQqJ9YhKM7yjgTxPSYNvDBMDjqSDeJDuXRCawmJHH+VTD9yNgVjnZL7OQ4NR
         DX9obSAjGr+1KONWQckhCU6cJ4mSd5fU1k5nliBJXa2PonpPlHvR4v9Q+rQhQmyqlLiA
         TK/Q==
X-Gm-Message-State: AOAM533NIT/4gPSmgKmT37lztUsXTV59oaoVhmYIIMBPsbAsw3q/GGfq
        o8jdmXmXgnObibS3lyM8pVmJ
X-Google-Smtp-Source: ABdhPJwNLm53AdK7ivDSoX6ZtCtLWTXA8dPegoSMR4zKgGi/uWzIG+UNLlP0WqfO3yXjuyJ6hJzqHA==
X-Received: by 2002:a63:d918:: with SMTP id r24mr3875348pgg.119.1589883782939;
        Tue, 19 May 2020 03:23:02 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([157.50.251.138])
        by smtp.gmail.com with ESMTPSA id s94sm1938664pjb.20.2020.05.19.03.22.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 03:23:02 -0700 (PDT)
Date:   Tue, 19 May 2020 15:52:56 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: Re: [PATCH v3] arm64: dts: qcom: apq8016-sbc-d3: Add Qualcomm
 APQ8016 SBC + D3Camera mezzanine
Message-ID: <20200519102256.GB8114@Mani-XPS-13-9360>
References: <20200518082129.2103683-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518082129.2103683-1-robert.foss@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On Mon, May 18, 2020 at 10:21:29AM +0200, Robert Foss wrote:
> Add device treee support for the Qualcomm APQ8016 SBC, otherwise known as
> the Dragonboard 410c with the D3Camera mezzanine expansion board.
> 
> The D3Camera mezzanine ships in a kit with a OmniVision 5640 sensor module,
> which is what this DT targets.
> 

What is the motivation behind adding this new dts? We have been using the
userspace tool [1] for applying this as an overlay for some time. But if we
start adding dts for mezzanines then for sure we'll end up with some good
numbers which will flood arch/{..}/qcom directory.

I could understand that one of the motivation is to provide nice user experience
to users but that's also taken care by the dt-update tool IMO.

Thanks,
Mani

[1] https://github.com/96boards/dt-update

> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
> 
> Changes since v2:
>  - Vinod: Change copyright assignment to Linaro
> 
> Changes since v1:
>  - Vinod: Changed license to GPL+BSD
>  - Vinod: Changed copyright year to 2020
>  - Nico: Changed name of mezzanine to d3camera
> 
>  arch/arm64/boot/dts/qcom/Makefile             |  1 +
>  .../boot/dts/qcom/apq8016-sbc-d3camera.dts    | 45 +++++++++++++++++++
>  2 files changed, 46 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc-d3camera.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index cc103f7020fd..3f95b522694e 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc-d3camera.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
>  dtb-$(CONFIG_ARCH_QCOM) += apq8096-ifc6640.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq6018-cp01-c1.dtb
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc-d3camera.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc-d3camera.dts
> new file mode 100644
> index 000000000000..752e5ec47499
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc-d3camera.dts
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +/*
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "apq8016-sbc.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. APQ 8016 SBC w/ D3Camera Mezzanine";
> +	compatible = "qcom,apq8016-sbc", "qcom,apq8016", "qcom,sbc";
> +};
> +
> +&cci_i2c0 {
> +	/delete-node/ camera_rear@3b;
> +
> +	camera_rear@76 {
> +		compatible = "ovti,ov5640";
> +		reg = <0x76>;
> +
> +		enable-gpios = <&msmgpio 34 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&msmgpio 35 GPIO_ACTIVE_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&camera_rear_default>;
> +
> +		clocks = <&gcc GCC_CAMSS_MCLK0_CLK>;
> +		clock-names = "xclk";
> +		clock-frequency = <23880000>;
> +
> +		vdddo-supply = <&camera_vdddo_1v8>;
> +		vdda-supply = <&camera_vdda_2v8>;
> +		vddd-supply = <&camera_vddd_1v5>;
> +
> +		status = "ok";
> +
> +		port {
> +			ov5640_ep: endpoint {
> +				clock-lanes = <1>;
> +				data-lanes = <0 2>;
> +				remote-endpoint = <&csiphy0_ep>;
> +			};
> +		};
> +	};
> +};
> -- 
> 2.25.1
> 
