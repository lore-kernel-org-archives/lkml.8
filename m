Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C5EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 23:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70AA205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 23:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="hk0GH97n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733032AbgCPX7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 19:59:17 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:32051 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733002AbgCPX7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 19:59:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584403155; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=yVTT8MeB7U4UiiCNtrbe1K3gBcXo5N2ilHh2ffYf+nU=; b=hk0GH97ntJs523T3I1zlM9/l91mez01EcRwIvGexSf5JK+s0rShb5kGvWh2ckeLFomdPzMC3
 8jIVHflS5Kzynlceh7iZ2GOdVX+70yTjt/6NaYPXqiohjm2HJN2J5efoLedejddpHrvesmnW
 dB0j8uFUOuyhcGQeK9kVKAFPSkk=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7012d2.7f29e0120688-smtp-out-n03;
 Mon, 16 Mar 2020 23:59:14 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CB193C4478C; Mon, 16 Mar 2020 23:59:14 +0000 (UTC)
Received: from [10.110.35.103] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4AC39C432C2;
        Mon, 16 Mar 2020 23:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4AC39C432C2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8150: Add USB and PHY device
 nodes
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jack Pham <jackp@codeaurora.org>
References: <1584172319-24843-1-git-send-email-wcheng@codeaurora.org>
 <1584172319-24843-4-git-send-email-wcheng@codeaurora.org>
 <20200316222434.GB1135@builder>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <0c4503c9-97ca-1f9f-5919-970671ac5199@codeaurora.org>
Date:   Mon, 16 Mar 2020 16:59:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316222434.GB1135@builder>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/2020 3:24 PM, Bjorn Andersson wrote:
> On Sat 14 Mar 00:51 PDT 2020, Wesley Cheng wrote:
> 
>> From: Jack Pham <jackp@codeaurora.org>
>>
>> Add device nodes for the USB3 controller, QMP SS PHY and
>> SNPS HS PHY.
>>
>> Signed-off-by: Jack Pham <jackp@codeaurora.org>
>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sm8150-mtp.dts | 17 ++++++
>>  arch/arm64/boot/dts/qcom/sm8150.dtsi    | 92 +++++++++++++++++++++++++++++++++
>>  2 files changed, 109 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
>> index 8ab1661..edf0abc 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
>> @@ -408,3 +408,20 @@
>>  	vdda-pll-supply = <&vreg_l3c_1p2>;
>>  	vdda-pll-max-microamp = <19000>;
>>  };
>> +
>> +&usb_1_hsphy {
>> +	status = "okay";
>> +	vdda-pll-supply = <&vdd_usb_hs_core>;
>> +	vdda33-supply = <&vdda_usb_hs_3p1>;
>> +	vdda18-supply = <&vdda_usb_hs_1p8>;
>> +};
>> +
>> +&usb_1_qmpphy {
>> +	status = "okay";
>> +	vdda-phy-supply = <&vreg_l3c_1p2>;
>> +	vdda-pll-supply = <&vdda_usb_ss_dp_core_1>;
>> +};
>> +
>> +&usb_1 {
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
>> index 141c21d..cf58fb7 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
>> @@ -855,6 +855,98 @@
>>  
>>  			#freq-domain-cells = <1>;
>>  		};
>> +
>> +		usb_1_hsphy: phy@88e2000 {
> 
> Please sort these nodes by address, i.e. this should come right after
> the cdsp remoteproc node.
> 
> 
> Apart from that this looks good, thank you!
> 
> Regards,
> Bjorn
> 

Hi Bjorn,
Thanks for the update, will remember this for future changes as well!
Will update this in the next patch series.

>> +			compatible = "qcom,usb-snps-hs-7nm-phy",
>> +							"qcom,sm8150-usb-hs-phy";
>> +			reg = <0 0x088e2000 0 0x400>;
>> +			status = "disabled";
>> +			#phy-cells = <0>;
>> +
>> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
>> +			clock-names = "ref";
>> +
>> +			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
>> +		};
>> +
>> +		usb_1_qmpphy: phy@88e9000 {
>> +			compatible = "qcom,sm8150-qmp-usb3-phy";
>> +			reg = <0 0x088e9000 0 0x18c>,
>> +			      <0 0x088e8000 0 0x10>;
>> +			reg-names = "reg-base", "dp_com";
>> +			status = "disabled";
>> +			#clock-cells = <1>;
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges;
>> +
>> +			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
>> +				 <&rpmhcc RPMH_CXO_CLK>,
>> +				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
>> +				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
>> +			clock-names = "aux", "ref_clk_src", "ref", "com_aux";
>> +
>> +			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
>> +				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
>> +			reset-names = "phy", "common";
>> +
>> +			usb_1_ssphy: lanes@88e9200 {
>> +				reg = <0 0x088e9200 0 0x200>,
>> +				      <0 0x088e9400 0 0x200>,
>> +				      <0 0x088e9c00 0 0x218>,
>> +				      <0 0x088e9600 0 0x200>,
>> +				      <0 0x088e9800 0 0x200>,
>> +				      <0 0x088e9a00 0 0x100>;
>> +				#phy-cells = <0>;
>> +				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
>> +				clock-names = "pipe0";
>> +				clock-output-names = "usb3_phy_pipe_clk_src";
>> +			};
>> +		};
>> +
>> +		usb_1: usb@a6f8800 {
>> +			compatible = "qcom,sdm845-dwc3", "qcom,dwc3";
>> +			reg = <0 0x0a6f8800 0 0x400>;
>> +			status = "disabled";
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges;
>> +			dma-ranges;
>> +
>> +			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
>> +				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
>> +				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
>> +				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
>> +				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
>> +				 <&gcc GCC_USB3_SEC_CLKREF_CLK>;
>> +			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
>> +				      "sleep", "xo";
>> +
>> +			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
>> +					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
>> +			assigned-clock-rates = <19200000>, <150000000>;
>> +
>> +			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 488 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 489 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "hs_phy_irq", "ss_phy_irq",
>> +					  "dm_hs_phy_irq", "dp_hs_phy_irq";
>> +
>> +			power-domains = <&gcc USB30_PRIM_GDSC>;
>> +
>> +			resets = <&gcc GCC_USB30_PRIM_BCR>;
>> +
>> +			usb_1_dwc3: dwc3@a600000 {
>> +				compatible = "snps,dwc3";
>> +				reg = <0 0x0a600000 0 0xcd00>;
>> +				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
>> +				snps,dis_u2_susphy_quirk;
>> +				snps,dis_enblslpm_quirk;
>> +				phys = <&usb_1_hsphy>, <&usb_1_ssphy>;
>> +				phy-names = "usb2-phy", "usb3-phy";
>> +			};
>> +		};
>>  	};
>>  
>>  	timer {
>> -- 
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
