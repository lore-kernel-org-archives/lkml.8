Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3A7C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 11:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509F824683
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 11:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C1Ag+u56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgAVLjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 06:39:16 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34236 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgAVLjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 06:39:16 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00MBd9u6025782;
        Wed, 22 Jan 2020 05:39:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579693149;
        bh=HvPGELjrP56iYK9ROZqp0RxXKPmPMfECw6+E+vPm6Y8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=C1Ag+u56cn27rvzG6aLZZqBkw2qAnedvArKU7bGUsiXg6R5qJG+mIlVpFeImopdmF
         hubbYlaY+7hkLSHCg9tt8yUYOa25W12t72/I/idM6Ht4NIY7YHeOHWZIgzjjD/Gd7b
         5zbK8vntoZi+9N36xWe5F7VTKHJd0Wp5dfuTow+M=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00MBd9hv089272
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Jan 2020 05:39:09 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 22
 Jan 2020 05:39:08 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 22 Jan 2020 05:39:08 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00MBd6Di039187;
        Wed, 22 Jan 2020 05:39:07 -0600
Subject: Re: [PATCH v2 1/9] arm64: dts: ti: k3-am65-main: Correct main NAVSS
 representation
To:     Lokesh Vutla <lokeshvutla@ti.com>, <t-kristo@ti.com>, <nm@ti.com>
CC:     <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20200122082621.4974-1-peter.ujfalusi@ti.com>
 <20200122082621.4974-2-peter.ujfalusi@ti.com>
 <600df214-620b-fa41-82ef-01132d9bdfae@ti.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <04a1bb97-f308-f866-ad4f-907cd7fb3515@ti.com>
Date:   Wed, 22 Jan 2020 13:39:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <600df214-620b-fa41-82ef-01132d9bdfae@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/01/2020 13.03, Lokesh Vutla wrote:
> 
> 
> On 22/01/20 1:56 PM, Peter Ujfalusi wrote:
>> NAVSS is a subsystem containing different IPs, it is not really a bus.
>> Change the compatible from "simple-bus" to "simple-mfd" to reflect that.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> index efb24579922c..e40f7acbec42 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> @@ -385,8 +385,8 @@ intr_main_gpio: interrupt-controller0 {
>>  		ti,sci-rm-range-girq = <0x1>;
>>  	};
>>  
>> -	cbass_main_navss: interconnect0 {
>> -		compatible = "simple-bus";
>> +	cbass_main_navss: navss@30800000 {
> 
> This introduces below dtc warning when built with W=1
> 
> arch/arm64/boot/dts/ti/k3-am65-main.dtsi:388.35-530.4: Warning
> (unit_address_vs_reg): /interconnect@100000/navss@30800000: node has a unit
> name, but no reg property

Interesting, the example in
Documentation/devicetree/bindings/dma/ti/k3-udma.yaml

is basically the same and dt_binding_check is happy about it:
DTC     Documentation/devicetree/bindings/dma/ti/k3-udma.example.dt.yaml
CHECK   Documentation/devicetree/bindings/dma/ti/k3-udma.example.dt.yaml

but it screamed when I had the simple-bus in there (copied from the
existing dtsi file).

The node name for simple-bus _must_ be
'^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'

I would not use any of these to NAVSS node...

> this is representing cbass inside main_navss, just like cbass_main. You can drop
> this patch and the similar mcu version.

According to Documentation/devicetree/bindings/mfd/mfd.txt:
- compatible : "simple-mfd" - this signifies that the operating system
  should consider all subnodes of the MFD device as separate devices
  akin to how "simple-bus" indicates when to see subnodes as children
  for a simple memory-mapped bus.

NAVSS is falling into simple-mfd as the devices under it are independent
devices.

> 
> Thanks and regards,
> Lokesh
> 
>> +		compatible = "simple-mfd";
>>  		#address-cells = <2>;
>>  		#size-cells = <2>;
>>  		ranges;
>>

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
