Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4F3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 00:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC8C8207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 00:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgESAmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 20:42:03 -0400
Received: from regular1.263xmail.com ([211.150.70.202]:36314 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgESAmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 20:42:02 -0400
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 May 2020 20:42:02 EDT
Received: from localhost (unknown [192.168.167.69])
        by regular1.263xmail.com (Postfix) with ESMTP id 444A5321;
        Tue, 19 May 2020 08:34:23 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.21.179] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P27331T140437578839808S1589848461574244_;
        Tue, 19 May 2020 08:34:22 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <33669f1ebadf44b2994914d3681cde90>
X-RL-SENDER: wxt@rock-chips.com
X-SENDER: wxt@rock-chips.com
X-LOGIN-NAME: wxt@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: rk3399: fix pd_tcpc0 and
 pd_tcpc1 node position
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>, kever.yang@rock-chips.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200428203003.3318-1-jbx6244@gmail.com>
 <20200428203003.3318-2-jbx6244@gmail.com> <2978296.PvbIKR7951@diego>
From:   Caesar Wang <wxt@rock-chips.com>
Message-ID: <243ee54a-2fb8-86e3-0018-c069147a21c5@rock-chips.com>
Date:   Tue, 19 May 2020 08:34:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2978296.PvbIKR7951@diego>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

ÔÚ 2020/5/19 ÉÏÎç6:29, Heiko St¨¹bner Ð´µÀ:
> Hi Kever, Caesar,
>
> could you double check where the type-c power-domains are located
> in the power-tree, as Caesar did add them under pd_vio back in 2016.

Johan's patch is correct, the pd_tcpc0 and pd_tcpc1 are grouped by VDD_LOGIC.
I have a passed test for pd_vio without pd_tcpc*.

>
> Thanks
> Heiko
>
> Am Dienstag, 28. April 2020, 22:30:03 CEST schrieb Johan Jonker:
>> The pd_tcpc0 and pd_tcpc1 nodes are currently a sub node of pd_vio.
>> In the rk3399 TRM figure of the 'Power Domain Partition' and in the
>> table of 'Power Domain and Voltage Domain Summary' these power domains
>> are positioned directly under VD_LOGIC, so fix that in 'rk3399.dtsi'.
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>


Reviewed-by: Caesar Wang <wxt@rock-chips.com>

Thanks,

-Caesar

>> ---
>>   arch/arm64/boot/dts/rockchip/rk3399.dtsi | 20 ++++++++++----------
>>   1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> index 37279db53..a4dc1bf2e 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> @@ -1056,6 +1056,16 @@
>>   				clocks = <&cru HCLK_SDIO>;
>>   				pm_qos = <&qos_sdioaudio>;
>>   			};
>> +			pd_tcpc0@RK3399_PD_TCPD0 {
>> +				reg = <RK3399_PD_TCPD0>;
>> +				clocks = <&cru SCLK_UPHY0_TCPDCORE>,
>> +					 <&cru SCLK_UPHY0_TCPDPHY_REF>;
>> +			};
>> +			pd_tcpc1@RK3399_PD_TCPD1 {
>> +				reg = <RK3399_PD_TCPD1>;
>> +				clocks = <&cru SCLK_UPHY1_TCPDCORE>,
>> +					 <&cru SCLK_UPHY1_TCPDPHY_REF>;
>> +			};
>>   			pd_usb3@RK3399_PD_USB3 {
>>   				reg = <RK3399_PD_USB3>;
>>   				clocks = <&cru ACLK_USB3>;
>> @@ -1088,16 +1098,6 @@
>>   					pm_qos = <&qos_isp1_m0>,
>>   						 <&qos_isp1_m1>;
>>   				};
>> -				pd_tcpc0@RK3399_PD_TCPD0 {
>> -					reg = <RK3399_PD_TCPD0>;
>> -					clocks = <&cru SCLK_UPHY0_TCPDCORE>,
>> -						 <&cru SCLK_UPHY0_TCPDPHY_REF>;
>> -				};
>> -				pd_tcpc1@RK3399_PD_TCPD1 {
>> -					reg = <RK3399_PD_TCPD1>;
>> -					clocks = <&cru SCLK_UPHY1_TCPDCORE>,
>> -						 <&cru SCLK_UPHY1_TCPDPHY_REF>;
>> -				};
>>   				pd_vo@RK3399_PD_VO {
>>   					reg = <RK3399_PD_VO>;
>>   					#address-cells = <1>;
>>
>
>
>
>
>


