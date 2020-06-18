Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95AEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3556E21BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="ovIu4chZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgFRJOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:14:19 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:11869 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgFRJOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:14:19 -0400
X-Greylist: delayed 718 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jun 2020 05:14:18 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1592471657;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=1wfLoFw1H/5l6k5HuZySiOqzR5RhC6ugiPkc6U/riKI=;
        b=ovIu4chZ4dC7uYPr6KTmAXK23Bw1li4XYfGqctcqn+6rY4aouC2QFP45VapzKZUr1n
        sdTUz2ZCBJoD96OYPTpGcnjyeWj/uty+AscIMIOTxTqTrKuqNOydRCRTAqXV7sWIzfxc
        ilzkB96nK5kzGml8ZiyJDV0nNFyWjA7Nnjse2N7x+A3UDlXQbZppXsyL3tD9hgauv0vV
        FATpfnsfXLC61O5b+VOxsLAsDIzBKWElSFP7M7g1i2qQpKZIDxLywg6dpSmk+dMvaCjV
        3JsMWz+WRjPFVnHQEyKG6ROxDBOO29EDFxW0fHSuv3ZNpjJqV8CdTXdQDhb6fLvAzGIS
        /FWg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j6IcjDBg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.10.4 DYNA|AUTH)
        with ESMTPSA id 6005e9w5I92GgLn
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 18 Jun 2020 11:02:16 +0200 (CEST)
Date:   Thu, 18 Jun 2020 11:02:10 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: msm8916: Add interconnect provider DT nodes
Message-ID: <20200618090210.GA48113@gerhold.net>
References: <20200617134515.25229-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617134515.25229-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Georgi,

On Wed, Jun 17, 2020 at 04:45:15PM +0300, Georgi Djakov wrote:
> Add nodes for the network-on-chip interconnect buses present on
> MSM8916-based platforms.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Thanks for resending this patch!

I tested this recently: it seems to probe fine and request the related
clocks; without interconnect consumers nothing is different otherwise
(as expected). FWIW:

Tested-by: Stephan Gerhold <stephan@gerhold.net>

> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 28 +++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 32bd140ac9fd..6c57896d9836 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <dt-bindings/arm/coresight-cti-dt.h>
> +#include <dt-bindings/interconnect/qcom,msm8916.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/qcom,gcc-msm8916.h>
>  #include <dt-bindings/reset/qcom,gcc-msm8916.h>
> @@ -406,11 +407,38 @@ soc: soc {
>  		ranges = <0 0 0 0xffffffff>;
>  		compatible = "simple-bus";
>  
> +		bimc: interconnect@400000 {
> +			compatible = "qcom,msm8916-bimc";
> +			reg = <0x00400000 0x62000>;
> +			#interconnect-cells = <1>;
> +			clock-names = "bus", "bus_a";
> +			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
> +				 <&rpmcc RPM_SMD_BIMC_A_CLK>;
> +		};
> +
>  		restart@4ab000 {
>  			compatible = "qcom,pshold";
>  			reg = <0x4ab000 0x4>;
>  		};
>  
> +		pcnoc: interconnect@500000 {
> +			compatible = "qcom,msm8916-pcnoc";
> +			reg = <0x00500000 0x11000>;
> +			#interconnect-cells = <1>;
> +			clock-names = "bus", "bus_a";
> +			clocks = <&rpmcc RPM_SMD_PCNOC_CLK>,
> +				 <&rpmcc RPM_SMD_PCNOC_A_CLK>;
> +		};
> +
> +		snoc: interconnect@580000 {
> +			compatible = "qcom,msm8916-snoc";
> +			reg = <0x00580000 0x14000>;
> +			#interconnect-cells = <1>;
> +			clock-names = "bus", "bus_a";
> +			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> +				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
> +		};
> +
>  		msmgpio: pinctrl@1000000 {
>  			compatible = "qcom,msm8916-pinctrl";
>  			reg = <0x1000000 0x300000>;
