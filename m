Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE7CC4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 09:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F9B205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 09:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgCOJoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 05:44:25 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:53142 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbgCOJoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 05:44:25 -0400
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 02F9iDJp004785;
        Sun, 15 Mar 2020 18:44:13 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav101.sakura.ne.jp);
 Sun, 15 Mar 2020 18:44:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav101.sakura.ne.jp)
Received: from [192.168.1.2] (121.252.232.153.ap.dti.ne.jp [153.232.252.121])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 02F9iDK0004781
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 15 Mar 2020 18:44:13 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH] ARM: dts: rockchip: use DMA channels for UARTs of
 TinkerBoard
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200314142327.25568-1-katsuhiro@katsuster.net>
 <2930126.sCcUyySgUU@diego>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <0b36bf84-0e7b-7287-a094-9fd2f33167ee@katsuster.net>
Date:   Sun, 15 Mar 2020 18:44:13 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2930126.sCcUyySgUU@diego>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Heiko,

> This belongs in rk3288.dtsi, as this is definitly not board-specific, as
> the dma-uart connection is done inside the soc.
> 
> At least on arm64 (rk3328, px30, probably more) we already have the
> uart dmas in the core dtsi without any problems.
> 
> Is there any reason why you only did add it to the tinker board only?

There is no special reason. Simply I don't have and not tested on other
boards of RK3288. But I hope these DMA settings can work correctly on
other boards.

I'll resend patch for rk3288.dtsi.

Best Regards,
Katsuhiro Suzuki


On 2020/03/15 0:09, Heiko Stübner wrote:
> Hi,
> 
> Am Samstag, 14. März 2020, 15:23:27 CET schrieb Katsuhiro Suzuki:
>> This patch enables to use DMAC for all UARTs that are connected to
>> dmac_peri core for TinkerBoard.
>>
>> Only uart2 is connected different DMAC (dmac_bus_s) so keep current
>> settings on this patch.
> 
> This belongs in rk3288.dtsi, as this is definitly not board-specific, as
> the dma-uart connection is done inside the soc.
> 
> At least on arm64 (rk3328, px30, probably more) we already have the
> uart dmas in the core dtsi without any problems.
> 
> Is there any reason why you only did add it to the tinker board only?
> 
> 
> Heiko
> 
> 
>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>> ---
>>   arch/arm/boot/dts/rk3288-tinker.dtsi | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
>> index 312582c1bd37..6efabeaf3c6d 100644
>> --- a/arch/arm/boot/dts/rk3288-tinker.dtsi
>> +++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
>> @@ -491,10 +491,14 @@ &tsadc {
>>   };
>>   
>>   &uart0 {
>> +	dmas = <&dmac_peri 1>, <&dmac_peri 2>;
>> +	dma-names = "tx", "rx";
>>   	status = "okay";
>>   };
>>   
>>   &uart1 {
>> +	dmas = <&dmac_peri 3>, <&dmac_peri 4>;
>> +	dma-names = "tx", "rx";
>>   	status = "okay";
>>   };
>>   
>> @@ -503,10 +507,14 @@ &uart2 {
>>   };
>>   
>>   &uart3 {
>> +	dmas = <&dmac_peri 7>, <&dmac_peri 8>;
>> +	dma-names = "tx", "rx";
>>   	status = "okay";
>>   };
>>   
>>   &uart4 {
>> +	dmas = <&dmac_peri 9>, <&dmac_peri 10>;
>> +	dma-names = "tx", "rx";
>>   	status = "okay";
>>   };
>>   
>>
> 
> 
> 
> 
> 

