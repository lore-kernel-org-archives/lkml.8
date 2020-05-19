Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C0EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 07:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 940DF20709
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 07:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Bk6mLRft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgESHaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 03:30:17 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53552 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgESHaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 03:30:15 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04J7U99W030707;
        Tue, 19 May 2020 02:30:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589873409;
        bh=7QK68xeNmUeDODH2mIzX/+6Cxr5S9voQlodrRmQYvn0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Bk6mLRftQCSM16fIXNsdzxsMRCC0rXySbJovpNJlULe4zsm4m6WpbM/D7bSoHpBLh
         ckvPUuZbmadH91pY802PADokkqyWL4QEzOdrQHnv8LCK97M005UfPeO+iCpP6IpeYP
         AIGBwXH/AxzIBdrm1SUhgSSVT1zJWSAQTQuqSLvU=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04J7U9g3098123
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 May 2020 02:30:09 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 19
 May 2020 02:30:09 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 19 May 2020 02:30:09 -0500
Received: from [10.250.232.87] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04J7U6Yi063839;
        Tue, 19 May 2020 02:30:07 -0500
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am654-main: Update otap-del-sel
 values
To:     Tero Kristo <t-kristo@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>
References: <20200507181526.12529-1-faiz_abbas@ti.com>
 <c59653d0-2e24-8917-f5b9-8c1044786bc9@ti.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <fae18e36-2292-b607-fa4c-fdedb7040216@ti.com>
Date:   Tue, 19 May 2020 13:00:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <c59653d0-2e24-8917-f5b9-8c1044786bc9@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tero,

On 15/05/20 3:44 pm, Tero Kristo wrote:
> On 07/05/2020 21:15, Faiz Abbas wrote:
>> According to the latest AM65x Data Manual[1], a different output tap
>> delay value is optimum for a given speed mode. Update these values.
>>
>> [1] http://www.ti.com/lit/gpn/am6526
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>> v2: Rebased to the latest mainline kernel
>>
>>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> index 11887c72f23a..6cd9701e4ead 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> @@ -244,7 +244,17 @@
>>           interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
>>           mmc-ddr-1_8v;
>>           mmc-hs200-1_8v;
>> -        ti,otap-del-sel = <0x2>;
>> +        ti,otap-del-sel-legacy = <0x0>;
>> +        ti,otap-del-sel-mmc-hs = <0x0>;
>> +        ti,otap-del-sel-sd-hs = <0x0>;
>> +        ti,otap-del-sel-sdr12 = <0x0>;
>> +        ti,otap-del-sel-sdr25 = <0x0>;
>> +        ti,otap-del-sel-sdr50 = <0x8>;
>> +        ti,otap-del-sel-sdr104 = <0x5>;
> 
> Isn't this wrong? Doc claims the value for sdr104 should be 0x7?
> 

Yes. There seems to be an update to the document since I last updated the value.
Thanks for catching. I will post another version soon.

Thanks,
Faiz
