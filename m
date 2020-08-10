Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D8CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 09:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 178252073A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 09:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgHJJLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 05:11:14 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:14963 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbgHJJLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 05:11:11 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 07A9AsHE097759;
        Mon, 10 Aug 2020 18:10:54 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp);
 Mon, 10 Aug 2020 18:10:54 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp)
Received: from [192.168.1.2] (121.252.232.153.ap.dti.ne.jp [153.232.252.121])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 07A9ArbS097750
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 10 Aug 2020 18:10:54 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH] arm64: dts: rockchip: add SPDIF node for rk3399-rockpro64
To:     Johan Jonker <jbx6244@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200801174950.2309273-1-katsuhiro@katsuster.net>
 <1e16b653-3820-7944-2254-a99627f9eeb0@gmail.com>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <14a2f659-675d-a530-eef5-9c965f3743b6@katsuster.net>
Date:   Mon, 10 Aug 2020 18:10:53 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1e16b653-3820-7944-2254-a99627f9eeb0@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Johan,

Sorry for late and thanks for your comment!

On 2020/08/03 2:52, Johan Jonker wrote:
> Hi Katsuhiro,
> 
> On 8/1/20 7:49 PM, Katsuhiro Suzuki wrote:
>> This patch adds 'disabled' SPDIF sound node and related settings
>> for rk3399-rockpro64.
>>
>> There are 2 reasons:
>>    - All RK3399 dma-bus channels have been already used by I2S0/1/2
>>    - RockPro64 does not have SPDIF optical nor coaxial connector,
>>      just have 3pins
>>
>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>> ---
>>   .../boot/dts/rockchip/rk3399-rockpro64.dtsi   | 28 +++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
>> index 6e553ff47534..e35b30f8a46e 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
>> @@ -76,6 +76,23 @@ sound {
>>   		dais = <&i2s1_p0>;
>>   	};
>>   
>> +	sound-dit {
>> +		compatible = "audio-graph-card";
>> +		label = "rockchip,rk3399";
>> +		dais = <&spdif_p0>;
>> +	};
>> +
>> +	spdif-dit {
>> +		compatible = "linux,spdif-dit";
>> +		#sound-dai-cells = <0>;
>> +
>> +		port {
>> +			dit_p0_0: endpoint {
>> +				remote-endpoint = <&spdif_p0_0>;
>> +			};
>> +		};
>> +	};
>> +
>>   	vcc12v_dcin: vcc12v-dcin {
>>   		compatible = "regulator-fixed";
>>   		regulator-name = "vcc12v_dcin";
>> @@ -698,6 +715,17 @@ &sdhci {
>>   	status = "okay";
>>   };
>>   
>> +&spdif {
>> +	pinctrl-0 = <&spdif_bus_1>;
> 
>> +	status = "disabled";
> 
> The status is already disabled.
> Adding more unused nodes and properties doesn't make sense here.
>> 	spdif: spdif@ff870000 {
> 		compatible = "rockchip,rk3399-spdif";
> 		reg = <0x0 0xff870000 0x0 0x1000>;
> 		interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH 0>;
> 		dmas = <&dmac_bus 7>;
> 		dma-names = "tx";
> 		clock-names = "mclk", "hclk";
> 		clocks = <&cru SCLK_SPDIF_8CH>, <&cru HCLK_SPDIF>;
> 		pinctrl-names = "default";
> 		pinctrl-0 = <&spdif_bus>;
> 		power-domains = <&power RK3399_PD_SDIOAUDIO>;
> 		#sound-dai-cells = <0>;
> 		status = "disabled";
> 	};
> 

I see, I will remove this line and send V2 patch.

Best Regards,
Katsuhiro Suzuki


>> +
>> +	spdif_p0: port {
>> +		spdif_p0_0: endpoint {
>> +			remote-endpoint = <&dit_p0_0>;
>> +		};
>> +	};
>> +};
>> +
>>   &spi1 {
>>   	status = "okay";
>>   
>>
> 

