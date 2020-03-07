Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65847C10DCE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 02:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB7A206CC
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 02:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pk5kyEk9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgCGCnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 21:43:05 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38771 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgCGCnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 21:43:04 -0500
Received: by mail-pg1-f195.google.com with SMTP id x7so1938831pgh.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 18:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1gdPrM7L3JdZc/DG08O9ahVcD28LXiincmgoBfc8Mlk=;
        b=pk5kyEk9yONh7dBZ4flJDx27Aj9j4jpOizczWG9giJCpqjVhUweWm+DHF8gCoFgpBc
         wJNHcO3UProRW0mz7dSaSKbsVZ/Dp2KLPG0170LTxpWi6qwtLmtGmhTP2yIiZ3WG0x/W
         +Hr0y4Zq6JepLXz7XJgwpdwOPIWx2m/vxqj+7uhNH+4wYoV5WNFkw4hdQxMfCZwFBqQv
         mboRdDlqz34LKHiz2jC0pCgBH1dpMeJak8hCbPB/sZ2N5T0LjHkyYvw3/SqAE37eRRWg
         hP/uviKv6/4QpaIMP0scsFPli5lTx4pAJZs/iyjlAlPR9Q0EFMn+o0Ikdpd7HAsvDT72
         tlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1gdPrM7L3JdZc/DG08O9ahVcD28LXiincmgoBfc8Mlk=;
        b=MjQ6Fm+M0l9BqABZXgoiWfR6ErnNGtpFSm6cMOSmt/SNEw8g4EbK0DZaG0fWuIhxUz
         o0nVBnul9Pw7M1e4CI9qakm8+RkERACNt+qahVwNIusUA62bMz7lFMVJuW2oikWiiS6U
         8Jr0ueeONMpU0pkoB+8wavtNIlazfWU/ptGpbE4yKtJI95oV7Kcry7IIgXJVeLV9rOSj
         +cSYgBOHnn5cR3ZBw3jxD62xOwG3qrV0FsTSiCf600UKgKa9ugHFkj9+GnUnQ4pswq//
         2KLfzbsSOmCzrMp5wH9VlqkE1KH0wTyV0UpYfLR0P63gRCk0xjdOKOdqFtD8L4eE+P8Y
         0pBg==
X-Gm-Message-State: ANhLgQ0tHr9D4iPvfkPVRvVweDuWMv+cjawHITwL8zrrNb7fohdo8WID
        PFoEQ87O9jbzC5ACPnvfdTrmnw==
X-Google-Smtp-Source: ADFU+vuzaPV2bzk0eY5etm8MBkQwXVV+JqsNaT+Nx+n8UshkHyDQtbFM8E58qN3eCImTFJd4eK/0kw==
X-Received: by 2002:a63:da45:: with SMTP id l5mr5780622pgj.273.1583548983410;
        Fri, 06 Mar 2020 18:43:03 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h132sm33211291pfe.118.2020.03.06.18.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 18:43:02 -0800 (PST)
Date:   Fri, 6 Mar 2020 18:43:00 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: qcom: c630: Enable audio support
Message-ID: <20200307024300.GD1094083@builder>
References: <20200305145344.14670-1-srinivas.kandagatla@linaro.org>
 <20200305145344.14670-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305145344.14670-3-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05 Mar 06:53 PST 2020, Srinivas Kandagatla wrote:

> This patch add support to audio via WSA881x Speakers and Headset.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> index b255be3a4a0a..99f5836b9331 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> @@ -8,6 +8,8 @@
>  /dts-v1/;
>  
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include <dt-bindings/sound/qcom,q6afe.h>
> +#include <dt-bindings/sound/qcom,q6asm.h>
>  #include "sdm845.dtsi"
>  #include "pm8998.dtsi"
>  
> @@ -353,6 +355,95 @@
>  	status = "okay";
>  };
>  
> +&slim_msm {
> +	ngd@1 {
> +		wcd9340: codec@1{

Afaict this extends the &wcd9340 defined in sdm845.dtsi, so you should
be able to just reference &wcd9340 here instead.

> +			clock-names = "extclk";
> +			clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
> +			vdd-buck-supply = <&vreg_s4a_1p8>;
> +			vdd-buck-sido-supply = <&vreg_s4a_1p8>;
> +			vdd-tx-supply = <&vreg_s4a_1p8>;
> +			vdd-rx-supply = <&vreg_s4a_1p8>;
> +			vdd-io-supply = <&vreg_s4a_1p8>;
> +			swm: swm@c85 {

This too extends the node from sdm845.dtsi, so reference it by label
(and perhaps give it a label to indicate that this is the wcd9340_swm?

> +				left_spkr:wsa8810-left{

Space after ':', unit address on the node name and then perhaps just
give the node a more generic name? Something like:

left_spkr: amplifier@0 {

> +					compatible = "sdw10217211000";
> +					reg = <0 3>;
> +					powerdown-gpios = <&wcdpinctrl 2 0>;

s/0/GPIO_ACTIVE_HIGH/

> +					#thermal-sensor-cells = <0>;
> +					sound-name-prefix = "SpkrLeft";
> +					#sound-dai-cells = <0>;
> +				};
> +
> +				right_spkr:wsa8810-right{
> +					compatible = "sdw10217211000";
> +					powerdown-gpios = <&wcdpinctrl 3 0>;
> +					reg = <0 4>;
> +					#thermal-sensor-cells = <0>;
> +					sound-name-prefix = "SpkrRight";
> +					#sound-dai-cells = <0>;
> +				};
> +			};
> +
> +		};
> +	};
> +};

Regards,
Bjorn
