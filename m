Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426BBC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B52420757
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgHaBKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 21:10:51 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:52616 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgHaBKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 21:10:50 -0400
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 07V1AU7J008966;
        Mon, 31 Aug 2020 10:10:30 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp);
 Mon, 31 Aug 2020 10:10:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp)
Received: from [192.168.1.2] (80.57.232.153.ap.dti.ne.jp [153.232.57.80])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 07V1ATDa008961
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 31 Aug 2020 10:10:30 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH v2] arm64: dts: rockchip: add SPDIF node for
 rk3399-rockpro64
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200810091619.3170534-1-katsuhiro@katsuster.net>
 <9694178.H46bfk3Hth@phil>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <6aea0d8d-00a7-6697-4085-bd2cdcd98f26@katsuster.net>
Date:   Mon, 31 Aug 2020 10:10:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <9694178.H46bfk3Hth@phil>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Heiko,

On 2020/08/31 4:08, Heiko Stuebner wrote:
> Hi,
> 
> Am Montag, 10. August 2020, 11:16:19 CEST schrieb Katsuhiro Suzuki:
>> This patch adds 'disabled' SPDIF sound node and related settings
>> for rk3399-rockpro64.
>>
>> There are 2 reasons:
>>    - All RK3399 dma-bus channels have been already used by I2S0/1/2
>>    - RockPro64 does not have SPDIF optical nor coaxial connector,
>>      just have 3pins
> 
> I don't really understand what you mean here.
> 
> Like is there spdif on the board or not? Because you call it "disabled"
> and also indicate that no i2s is available anymore, yet you mention 3 pins.
> What do they do then?
> 

RockPro64 has output pins for SPDIF Tx. But RK3399 does not have enough DMA
channel for enabling SPDIF tx. Current settings are:

   - I2S0     (Req number 0, 1): Enabled  : Output to 40pin headers (CON40)
   - I2S1     (Req number 2, 3): Enabled  : Output to ES8316 on board
   - I2S2     (Req number 4, 5): Enabled  : Output to internal HDMI core
   - SPDIF Tx (Req number 7)   : Disabled : Output to other connector (J10)

If we want to enable ALL sound I/Os, we need 7 DMA channels for it.
But... Unfortunately, RK3399 has only 6 DMA channels for sounds, PWM and SPIs.

So users of RockPro64 have to choose from the following:

   - Disable one of I2S (Ex. I2S0) and enable SPDIF tx
   - Keep enable I2S0/1/2 and disable SPDIF tx

> Thanks
> Heiko
> 
> 

Best Regards,
Katsuhiro Suzuki


>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>>
>> ---
>>
>> Changes in v2:
>>    - Remove redundant status property
>> ---
>>   .../boot/dts/rockchip/rk3399-rockpro64.dtsi   | 27 +++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
>> index 6e553ff47534..58097245994a 100644
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
>> @@ -698,6 +715,16 @@ &sdhci {
>>   	status = "okay";
>>   };
>>   
>> +&spdif {
>> +	pinctrl-0 = <&spdif_bus_1>;
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
> 
> 
> 

