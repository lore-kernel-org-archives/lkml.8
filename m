Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6418BC2BA16
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350DD20719
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388695AbgDBTqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 15:46:43 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46424 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbgDBTqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 15:46:43 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id 0F4DB28A9AD
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: add isp0 node for rk3399
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     dafna.hirschfeld@collabora.com, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, ezequiel@collabora.com,
        heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        karthik.poduval@gmail.com, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, mark.rutland@arm.com,
        robh+dt@kernel.org
References: <20200402000234.226466-5-helen.koike@collabora.com>
 <1187d28a-6fb9-fd12-a422-8a4220a11e79@gmail.com>
From:   Helen Koike <helen.koike@collabora.com>
Message-ID: <d8b05dd4-1ece-9513-b2ec-0cb58f665c5e@collabora.com>
Date:   Thu, 2 Apr 2020 16:46:28 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <1187d28a-6fb9-fd12-a422-8a4220a11e79@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/2/20 2:20 PM, Johan Jonker wrote:
> Hi Helen,
> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> index fc0295d2a65a1..815099a0cd0dd 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> @@ -1718,6 +1718,33 @@ vopb_mmu: iommu@ff903f00 {
>>  		status = "disabled";
>>  	};
>>  
>> +	isp0: isp0@ff910000 {
>> +		compatible = "rockchip,rk3399-cif-isp";
>> +		reg = <0x0 0xff910000 0x0 0x4000>;
>> +		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH 0>;
>> +		clocks = <&cru SCLK_ISP0>,
>> +			 <&cru ACLK_ISP0>, <&cru ACLK_ISP0_WRAPPER>,
>> +			 <&cru HCLK_ISP0>, <&cru HCLK_ISP0_WRAPPER>;
>> +		clock-names = "clk_isp",
>> +			      "aclk_isp", "aclk_isp_wrap",
>> +			      "hclk_isp", "hclk_isp_wrap";
> 
>> +		power-domains = <&power RK3399_PD_ISP0>;
>> +		iommus = <&isp0_mmu>;
>> +		phys = <&mipi_dphy_rx0>;
>> +		phy-names = "dphy";
> 
> Maybe a little sort? But keep rest as it is. Also in example.
> 
> 		iommus = <&isp0_mmu>;
> 		phys = <&mipi_dphy_rx0>;
> 		phy-names = "dphy";
> 		power-domains = <&power RK3399_PD_ISP0>;

Are you proposing only to move power-domains after phy? And keep the rest?
What is the main logic?

Thanks
Helen

> 
>> +
>> +		ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			port@0 {
> 
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				reg = <0>;
> 
> Move reg above #address-cells. Change that in example as well.
> 
> 				reg = <0>;
> 				#address-cells = <1>;
> 				#size-cells = <0>;
> 
>> +			};
>> +		};
>> +	};
>> +
>>  	isp0_mmu: iommu@ff914000 {
>>  		compatible = "rockchip,iommu";
>>  		reg = <0x0 0xff914000 0x0 0x100>, <0x0 0xff915000 0x0 0x100>;
>> -- 
>> 2.26.0
> 
