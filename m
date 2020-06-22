Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A580DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81F8E20768
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L8MOP02t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725616AbgFVIMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgFVIMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:12:30 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD43C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 01:12:30 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id g5so12357772otg.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 01:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4RpwlAyFnjmq4it4DvV6HICg0Qx2ws7Bbf9XwDlyvNU=;
        b=L8MOP02tH082ssrMnlQVK6MgCCFguURnrHOyjjmPEn46O6qiMW89ifsdfxtdB5k3Su
         tBOwlwpzkpqwPU+WuXm1lbyDJ6BvoO5G2yb3IhT7bypKJom7G8RzMQwA4RFhz4o0FciI
         t3cJSDB8HrSMkY4mo9soGsiG8VJ73joqoDLPrYtOwIxsqndMyZXKdd3vaWWQLODw9HNT
         dAXQ7Ki58sLJQKkSd+TAdrSpiSbuDyV9SXvr4EzjiHfFGNLkAW4qJkfoTNNMdTWcLz9f
         YW3YddKGxbnrWmTa62JO21S5kcnlohu6HAUPTCczwwIdoOSVIhBA5ImWnAalwxM0FHxy
         4QtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4RpwlAyFnjmq4it4DvV6HICg0Qx2ws7Bbf9XwDlyvNU=;
        b=DcsKSlCjQLyWd9cLANGCubdfjqu0JAJ2qk/R0Ynty8VjLoqigPEYGEY86ivIXhi0JS
         83l+EeMNdHv/rmFwHU1rfdPH2ldVnXma2LycKT93zcvsXxaBEtNCvfVELT84j5OorPBR
         GOU3UTNRsKyLox3Pwm9sz2WspJrKs075pPr8z9el8kQHqZizSFgPK2c1aXSY6Bx877xf
         nywP1hVJa6y8m8wFXbcINF2fLSiMZnmB5hXGsOjUN1+oRfSLaOur82STI14EShE08O5L
         mwDdQz3YINqeriLQ5rZB/e+hTCNG6wjd7ThaM+Tip+9JTZL88r3vIHYqJcNNRw8k/PDn
         nstg==
X-Gm-Message-State: AOAM533iNhAWG1zx43e+0o35q6wWnf6u/1EgwQ8jnmHUOFhC6CvfEEBS
        hJbkuLzrH3iDM4jMHCyZuv9dpA==
X-Google-Smtp-Source: ABdhPJyRltu6da/7EU8mqyL2GmxT6IdSGCN9QFVNL+cZ6aMNKXWOP7pN+tWyS1cGEm2kIWwqmVPAeQ==
X-Received: by 2002:a9d:611c:: with SMTP id i28mr12578642otj.361.1592813549698;
        Mon, 22 Jun 2020 01:12:29 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g2sm3194522otq.9.2020.06.22.01.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 01:12:29 -0700 (PDT)
Date:   Mon, 22 Jun 2020 01:09:43 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     skrzynka@konradybcio.pl, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 5/8] arm64: dts: qcom: pm660(l): Add base dts files
Message-ID: <20200622080943.GE2421@builder.lan>
References: <20200622075749.21925-1-konradybcio@gmail.com>
 <20200622075749.21925-6-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622075749.21925-6-konradybcio@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22 Jun 00:57 PDT 2020, Konrad Dybcio wrote:

> Add base DTS files for pm660(l) along with GPIOs, power-on and
> rtc nodes.
> 
> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/pm660.dtsi  | 60 ++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/pm660l.dtsi | 46 +++++++++++++++++++++
>  2 files changed, 106 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/pm660.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/pm660l.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm660.dtsi b/arch/arm64/boot/dts/qcom/pm660.dtsi
> new file mode 100644
> index 000000000000..041f45264255
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pm660.dtsi
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2020, Konrad Dybcio
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/spmi/spmi.h>
> +#include <dt-bindings/input/linux-event-codes.h>

Please keep things alphabetically sorted.

> +
> +&spmi_bus {
> +
> +	pmic@0 {
> +		compatible = "qcom,pm660", "qcom,spmi-pmic";
> +		reg = <0x0 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		rtc@6000 {
> +			compatible = "qcom,pm8941-rtc";
> +			reg = <0x6000>, <0x6100>;
> +			reg-names = "rtc", "alarm";
> +			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
> +		};
> +
> +		pon: pon@800 {
> +			compatible = "qcom,pm8916-pon";
> +
> +			reg = <0x800>;
> +
> +			pwrkey {
> +				compatible = "qcom,pm8941-pwrkey";
> +				interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
> +				debounce = <15625>;
> +				bias-pull-up;
> +				linux,code = <KEY_POWER>;
> +			};
> +
> +		};
> +
> +		pm660_gpios: gpios@c000 {
> +			compatible = "qcom,pm660-gpio";
> +			reg = <0xc000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupts = <0 0xc0 0 IRQ_TYPE_NONE>,

The spmi gpio driver now relies on hierarchical irq chips to map its
pins to the interrupt controller's. So you shouldn't list the interrupts
anymore.

But it should be an "interrupt-controller" and you need "gpio-ranges".

> +				     <0 0xc1 0 IRQ_TYPE_NONE>,
> +				     <0 0xc2 0 IRQ_TYPE_NONE>,
> +				     <0 0xc3 0 IRQ_TYPE_NONE>,
> +				     <0 0xc4 0 IRQ_TYPE_NONE>,
> +				     <0 0xc5 0 IRQ_TYPE_NONE>,
> +				     <0 0xc6 0 IRQ_TYPE_NONE>,
> +				     <0 0xc7 0 IRQ_TYPE_NONE>,
> +				     <0 0xc8 0 IRQ_TYPE_NONE>,
> +				     <0 0xc9 0 IRQ_TYPE_NONE>,
> +				     <0 0xca 0 IRQ_TYPE_NONE>,
> +				     <0 0xcb 0 IRQ_TYPE_NONE>,
> +				     <0 0xcc 0 IRQ_TYPE_NONE>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/qcom/pm660l.dtsi b/arch/arm64/boot/dts/qcom/pm660l.dtsi
> new file mode 100644
> index 000000000000..5e0f1a6e3966
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pm660l.dtsi
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2020, Konrad Dybcio
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/spmi/spmi.h>
> +#include <dt-bindings/input/linux-event-codes.h>
> +
> +&spmi_bus {
> +
> +	pmic@2 {
> +		compatible = "qcom,pm660l", "qcom,spmi-pmic";
> +		reg = <0x2 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pm660l_gpios: gpios@c000 {
> +			compatible = "qcom,pm660l-gpio", "qcom,spmi-gpio";
> +			reg = <0xc000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			#interrupt-cells = <2>;
> +			interrupts = <0x2 0xc0 0x0 IRQ_TYPE_NONE>,

As above.

Regards,
Bjorn

> +					 <0x2 0xc1 0x0 IRQ_TYPE_NONE>,
> +					 <0x2 0xc2 0x0 IRQ_TYPE_NONE>,
> +					 <0x2 0xc3 0x0 IRQ_TYPE_NONE>,
> +					 <0x2 0xc4 0x0 IRQ_TYPE_NONE>,
> +					 <0x2 0xc5 0x0 IRQ_TYPE_NONE>,
> +					 <0x2 0xc6 0x0 IRQ_TYPE_NONE>,
> +					 <0x2 0xc7 0x0 IRQ_TYPE_NONE>,
> +					 <0x2 0xc8 0x0 IRQ_TYPE_NONE>,
> +					 <0x2 0xc9 0x0 IRQ_TYPE_NONE>,
> +					 <0x2 0xca 0x0 IRQ_TYPE_NONE>,
> +					 <0x2 0xcb 0x0 IRQ_TYPE_NONE>;
> +		};
> +	};
> +
> +	pmic@3 {
> +		compatible = "qcom,pm660l", "qcom,spmi-pmic";
> +		reg = <0x3 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +};
> +
> -- 
> 2.27.0
> 
