Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F335C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D9A920578
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Li+lGF6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732045AbgIHTmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:42:43 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57872 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730883AbgIHPws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:52:48 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 088Fq14c088766;
        Tue, 8 Sep 2020 10:52:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599580321;
        bh=cEZvkRsnogXi5jTE+0zv4VJY5SU4FT/ctE+ghwX1lDc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Li+lGF6ijYlqqJT5GnJRrEVr/c1Pe0AMHxr51idLzgohIplXR1C+pNvKKjXzsBerY
         uzHNpZo9/DSHZFoBXkUntm/sM6FEispHbx/TUDYeQd9VOTy5+FawgCKjk4Z3Fvn5Me
         dJf+5oPLfpBlESQoIlEotsqaN0h+1qkBSVQx1HgQ=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 088Fq1D0074408
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Sep 2020 10:52:01 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Sep
 2020 10:52:00 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Sep 2020 10:52:00 -0500
Received: from [10.250.34.59] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 088Fq0cq120219;
        Tue, 8 Sep 2020 10:52:00 -0500
Subject: Re: [v4,4/4] arm64: dts: mt8192: add infracfg_rst node
To:     Crystal Guo <crystal.guo@mediatek.com>
CC:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?U2VpeWEgV2FuZyAo546L6L+65ZCbKQ==?= 
        <seiya.wang@mediatek.com>,
        =?UTF-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        =?UTF-8?B?WWluZ2pvZSBDaGVuICjpmbPoi7HmtLIp?= 
        <Yingjoe.Chen@mediatek.com>,
        =?UTF-8?B?RmFuIENoZW4gKOmZs+WHoSk=?= <fan.chen@mediatek.com>,
        =?UTF-8?B?WW9uZyBMaWFuZyAo5qKB5YuHKQ==?= <Yong.Liang@mediatek.com>
References: <20200817030324.5690-1-crystal.guo@mediatek.com>
 <20200817030324.5690-5-crystal.guo@mediatek.com>
 <211bd78f-3b70-1e65-eea9-75cc73a3dfdd@ti.com>
 <1599571618.14806.7.camel@mhfsdcap03>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <77432990-4a0e-e8cd-5dec-772ea9110630@ti.com>
Date:   Tue, 8 Sep 2020 10:51:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1599571618.14806.7.camel@mhfsdcap03>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/20 8:26 AM, Crystal Guo wrote:
> On Thu, 2020-09-03 at 07:29 +0800, Suman Anna wrote:
>> Hi Crystal,
>>
>> On 8/16/20 10:03 PM, Crystal Guo wrote:
>>> add infracfg_rst node which is for MT8192 platform
>>>
>>> Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
>>
>> I understand you are posting these together for complete reference, but driver
>> subsystem maintainers typically don't pick dts patches. In anycase, can you
>> clarify if your registers are self-clearing registers?
>>
>> regards
>> Suman
>>
> Hi Suman,
> 
> Thanks for your reply.
> Our reset registers are not self-clearing, it needs to set the clear bit
> to 1 to clear the related bit.
> And should I separate this dts patch from the patch sets?

Typically yes, but will leave it upto Philipp and Mediatek DT maintainers.

regards
Suman

> 
> regards
> Crystal
>>> ---
>>>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 11 ++++++++++-
>>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> index 931e1ca17220..a0cb9904706b 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> @@ -10,6 +10,7 @@
>>>  #include <dt-bindings/interrupt-controller/irq.h>
>>>  #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
>>>  #include <dt-bindings/power/mt8192-power.h>
>>> +#include <dt-bindings/reset/ti-syscon.h>
>>>  
>>>  / {
>>>  	compatible = "mediatek,mt8192";
>>> @@ -219,9 +220,17 @@
>>>  		};
>>>  
>>>  		infracfg: infracfg@10001000 {
>>> -			compatible = "mediatek,mt8192-infracfg", "syscon";
>>> +			compatible = "mediatek,mt8192-infracfg", "syscon", "simple-mfd";
>>>  			reg = <0 0x10001000 0 0x1000>;
>>>  			#clock-cells = <1>;
>>> +
>>> +			infracfg_rst: reset-controller {
>>> +				compatible = "mediatek,infra-reset", "ti,syscon-reset";
>>> +				#reset-cells = <1>;
>>> +				ti,reset-bits = <
>>> +					0x140 15 0x144 15 0 0 (ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* 0: pcie */
>>> +				>;
>>> +			};
>>>  		};
>>>  
>>>  		pericfg: pericfg@10003000 {
>>>
>>
> 

