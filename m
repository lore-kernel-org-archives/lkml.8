Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8D0C35246
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 05:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BDC2467E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 05:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Dol1ECKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgA1F6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 00:58:18 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:10976 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgA1F6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 00:58:18 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580191097; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=xEMzgt/quh6QS5imm/Ss06fNSr9xLLI+rH8MSsl9UWU=; b=Dol1ECKdn1xITK6rYY9t9LmZtGPgKsxlLPUbX63v/OtSV+Fc1SaSJGOBXwfFa5cu23jWXPDt
 jz3e6iCWZXyNu4sE7ezfGQEsF4n2tRXd7thEnO1HuKJKTbRpTW5zw7q4uQV5prgwzVappT9U
 o9JQd39ygDLi263FtzU9T8iOtX0=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2fcd78.7fe99340fa78-smtp-out-n01;
 Tue, 28 Jan 2020 05:58:16 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7E81EC433CB; Tue, 28 Jan 2020 05:58:16 +0000 (UTC)
Received: from [10.206.28.9] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1D0AAC447A2;
        Tue, 28 Jan 2020 05:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1D0AAC447A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v2 10/10] arm64: dts: sc7180: Add clock controller nodes
To:     Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, harigovi@codeaurora.org,
        mka@chromium.org, kalyan_t@codeaurora.org,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        hoegsberg@chromium.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
References: <20200124224225.22547-1-dianders@chromium.org>
 <20200124144154.v2.10.I1a4b93fb005791e29a9dcf288fc8bd459a555a59@changeid>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <eeef68f4-127e-6d28-4a79-c1464a10c7db@codeaurora.org>
Date:   Tue, 28 Jan 2020 11:28:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200124144154.v2.10.I1a4b93fb005791e29a9dcf288fc8bd459a555a59@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

Thanks for the patch.

On 1/25/2020 4:12 AM, Douglas Anderson wrote:
> From: Taniya Das <tdas@codeaurora.org>
> 
> Add the display, video & graphics clock controller nodes supported on
> SC7180.
> 
> NOTE: the dispcc needs input clocks from various PHYs that aren't in
> the device tree yet.  For now we'll leave these stubbed out with <0>,
> which is apparently the magic way to do this.  These clocks aren't
> really "optional" and this stubbing out method is apparently the best
> way to handle it.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v2:
> - Added includes
> - Changed various parent names to match bindings / driver
> 
>   arch/arm64/boot/dts/qcom/sc7180.dtsi | 41 ++++++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 8011c5fe2a31..ee3b4bade66b 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -5,7 +5,9 @@
>    * Copyright (c) 2019, The Linux Foundation. All rights reserved.
>    */
>   
> +#include <dt-bindings/clock/qcom,dispcc-sc7180.h>
>   #include <dt-bindings/clock/qcom,gcc-sc7180.h>
> +#include <dt-bindings/clock/qcom,gpucc-sc7180.h>

My bad, but we are still missing the videocc header. I could send across 
the new patch.
>   #include <dt-bindings/clock/qcom,rpmh.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/phy/phy-qcom-qusb2.h>
> @@ -1039,6 +1041,18 @@ pinmux {
>   			};
>   		};
>   
> +		gpucc: clock-controller@5090000 {
> +			compatible = "qcom,sc7180-gpucc";
> +			reg = <0 0x05090000 0 0x9000>;
> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
> +				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
> +			clock-names = "xo", "gpll0", "gpll0_div";
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +		};
> +
>   		qspi: spi@88dc000 {
>   			compatible = "qcom,qspi-v1";
>   			reg = <0 0x088dc000 0 0x600>;
> @@ -1151,6 +1165,33 @@ usb_1_dwc3: dwc3@a600000 {
>   			};
>   		};
>   
> +		videocc: clock-controller@ab00000 {
> +			compatible = "qcom,sc7180-videocc";
> +			reg = <0 0x0ab00000 0 0x10000>;
> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "xo";
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +		};
> +
> +		dispcc: clock-controller@af00000 {
> +			compatible = "qcom,sc7180-dispcc";
> +			reg = <0 0x0af00000 0 0x200000>;
> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_DISP_GPLL0_CLK_SRC>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>;
> +			clock-names = "xo", "gpll0",
> +				      "dsi_phy_pll_byte", "dsi_phy_pll_pixel",
> +				      "dp_phy_pll_link", "dp_phy_pll_vco_div";
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +		};
> +
>   		pdc: interrupt-controller@b220000 {
>   			compatible = "qcom,sc7180-pdc", "qcom,pdc";
>   			reg = <0 0x0b220000 0 0x30000>;
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
