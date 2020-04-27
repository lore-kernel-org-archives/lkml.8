Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E16C5519E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 244E020661
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mL4UttTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgD0Kug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 06:50:36 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49670 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgD0Kue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 06:50:34 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03RAoQXT001400;
        Mon, 27 Apr 2020 05:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587984626;
        bh=IGT8KtVf7PY2gZ9dU2q+ikbbXQeLIMBV50rwe1LAM80=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=mL4UttTBU230xpooZ1c7vwuHNunAEuD65ZxU9nPRWzcn4X+OHnetVmvL1Q9v6MTQB
         NIsXhHt3QqtXq43Hdz30XG41zctgvylQTy3Z3Nruu+To5kn10r/QgpLkVolIT+sRFB
         5jOD488Lu2mtwWSoQIfHxY0gXAm/ziB1GOMlmvKc=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03RAoQo3001900
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Apr 2020 05:50:26 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 27
 Apr 2020 05:50:25 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 27 Apr 2020 05:50:25 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03RAoONg024515;
        Mon, 27 Apr 2020 05:50:24 -0500
Subject: Re: [PATCH 1/3] arm64: dts: ti: am654: Add DSS node
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jyri Sarha <jsarha@ti.com>
References: <20200422091512.950-1-tomi.valkeinen@ti.com>
 <591ddc8e-b45a-5a36-ae81-e1b92727dd2d@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <3708a94a-9c42-745b-3dc0-2271fcc266a5@ti.com>
Date:   Mon, 27 Apr 2020 13:50:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <591ddc8e-b45a-5a36-ae81-e1b92727dd2d@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2020 13:08, Tero Kristo wrote:
> On 22/04/2020 12:15, Tomi Valkeinen wrote:
>> From: Jyri Sarha <jsarha@ti.com>
>>
>> Add DSS node to k3-am65-main.dtsi with labels for board specific
>> support and syscon node for oldi-io-ctrl.
>>
>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 44 ++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> index 11887c72f23a..7d1bc991708e 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> @@ -287,6 +287,11 @@
>>               mux-reg-masks = <0x4080 0x3>, /* SERDES0 lane select */
>>                       <0x4090 0x3>; /* SERDES1 lane select */
>>           };
>> +
>> +        dss_oldi_io_ctrl: dss_oldi_io_ctrl@41E0 {
>> +            compatible = "syscon";
>> +            reg = <0x0000041E0 0x14>;
>> +        };
>>       };
>>       dwc3_0: dwc3@4000000 {
>> @@ -746,4 +751,43 @@
>>               };
>>           };
>>       };
>> +
>> +    dss: dss@04a00000 {
>> +        compatible = "ti,am65x-dss";
>> +        reg =    <0x0 0x04a00000 0x0 0x1000>, /* common */
>> +            <0x0 0x04a02000 0x0 0x1000>, /* vidl1 */
>> +            <0x0 0x04a06000 0x0 0x1000>, /* vid */
>> +            <0x0 0x04a07000 0x0 0x1000>, /* ovr1 */
>> +            <0x0 0x04a08000 0x0 0x1000>, /* ovr2 */
>> +            <0x0 0x04a0a000 0x0 0x1000>, /* vp1 */
>> +            <0x0 0x04a0b000 0x0 0x1000>; /* vp2 */
>> +        reg-names = "common", "vidl1", "vid",
>> +            "ovr1", "ovr2", "vp1", "vp2";
>> +
>> +        ti,am65x-oldi-io-ctrl = <&dss_oldi_io_ctrl>;
>> +
>> +        power-domains = <&k3_pds 67 TI_SCI_PD_EXCLUSIVE>;
>> +
>> +        clocks =    <&k3_clks 67 1>,
>> +                <&k3_clks 216 1>,
>> +                <&k3_clks 67 2>;
>> +        clock-names = "fck", "vp1", "vp2";
>> +
>> +        /*
>> +         * Set vp2 clk (DPI_1_IN_CLK) mux to PLL4 via
>> +         * DIV1. See "Figure 12-3365. DSS Integration"
>> +         * in AM65x TRM for details.
>> +         */
>> +        assigned-clocks = <&k3_clks 67 2>;
>> +        assigned-clock-parents = <&k3_clks 67 5>;
>> +
>> +        interrupts = <GIC_SPI 166 IRQ_TYPE_EDGE_RISING>;
>> +
>> +        status = "disabled";
> 
> Any reason why the node is disabled? Are you planning to enable it somewhere later on, or is that 
> left for the user to do?

It's enabled in board DT files or DT overlays which add a display and the DT graph for the 
connections. Having DSS driver probe without any displays is a waste of resources.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
