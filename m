Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82454C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BB7C2074B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OXaBMLD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgGQH2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 03:28:39 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42102 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgGQH2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:28:38 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06H7SAT9015699;
        Fri, 17 Jul 2020 02:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594970890;
        bh=x+gIR4BgrZjaApIDkz1UIty6xRR9m3Z0fmVHijIFdYA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=OXaBMLD1OPAXCalEhUW1JeOY6ceqlQ3URxPzRZ9JQdUGH2aaYpzrAkpXXthWgCho2
         uybx/Bd0nJx+X0Z+JnFDdS/kX+8sZ/Lq2mELAvW3LN3nesjIZYg5cXHaAuW6V68nta
         cbBbxin+jh3D3MtpaAjbQiC8GxfhcV0cyVtYvo6o=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06H7SAIR096261
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jul 2020 02:28:10 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 17
 Jul 2020 02:28:09 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 17 Jul 2020 02:28:09 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06H7S6nQ042040;
        Fri, 17 Jul 2020 02:28:07 -0500
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-j721e-main: rename smmu node to
 iommu
To:     Suman Anna <s-anna@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>
References: <20200626183532.23436-1-grygorii.strashko@ti.com>
 <88041e5c-b96d-5d92-d951-eb3356a519e2@ti.com>
 <438e0ec4-c6e0-8f9d-1608-b810b30295e0@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <170b8b4b-ab58-21be-9f2b-7de4a418a7a6@ti.com>
Date:   Fri, 17 Jul 2020 10:28:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <438e0ec4-c6e0-8f9d-1608-b810b30295e0@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2020 21:40, Suman Anna wrote:
> On 6/26/20 1:36 PM, Grygorii Strashko wrote:
>>
>>
>> On 26/06/2020 21:35, Grygorii Strashko wrote:
>>> Rename smmu node to iommu to fix dtbs_check warning:
>>>   k3-j721e-common-proc-board.dt.yaml: smmu@36600000: $nodename:0: 
>>> 'smmu@36600000' does not match '^iommu@[0-9a-f]*'
>>>
>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Acked-by: Suman Anna <s-anna@ti.com>

Queued up for 5.9, thanks.

-Tero

> 
>>> ---
>>>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi 
>>> b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>>> index 5d82de4097bb..0ac23c4414a2 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>>> @@ -95,7 +95,7 @@
>>>               interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>>>           };
>>> -        smmu0: smmu@36600000 {
>>> +        smmu0: iommu@36600000 {
>>>               compatible = "arm,smmu-v3";
>>>               reg = <0x0 0x36600000 0x0 0x100000>;
>>>               interrupt-parent = <&gic500>;
>>>
>>
>> Pls, ignore "3/3" in subj.
>>
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
