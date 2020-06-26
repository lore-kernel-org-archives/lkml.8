Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518C7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F30F207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CY4xQpCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgFZSkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:40:24 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40314 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFZSkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:40:24 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05QIeBJ9089649;
        Fri, 26 Jun 2020 13:40:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593196811;
        bh=CrDkOC+fm85LpHYK++eBWVeyOv6G39lapXPJvPYrvPk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=CY4xQpCcbxd6OahseU8z5KqUtOt+oJsJdGZeqwj0IBX6wZpA+17LsWqT0nbBY/CXS
         a2XKfcCNnpKgi38W4wqvkptuQAsB0GfZkzaW6PON1fOxq3gIMyYe/W4AcNscTfcQV0
         qegQutFtoreejwN4dZqr2d6sGiqWgNZj8lc/aobM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05QIe67R091726
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Jun 2020 13:40:11 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 26
 Jun 2020 13:40:07 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 26 Jun 2020 13:40:07 -0500
Received: from [10.250.48.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05QIe6W2021586;
        Fri, 26 Jun 2020 13:40:07 -0500
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-j721e-main: rename smmu node to
 iommu
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>
References: <20200626183532.23436-1-grygorii.strashko@ti.com>
 <88041e5c-b96d-5d92-d951-eb3356a519e2@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <438e0ec4-c6e0-8f9d-1608-b810b30295e0@ti.com>
Date:   Fri, 26 Jun 2020 13:40:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <88041e5c-b96d-5d92-d951-eb3356a519e2@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/20 1:36 PM, Grygorii Strashko wrote:
> 
> 
> On 26/06/2020 21:35, Grygorii Strashko wrote:
>> Rename smmu node to iommu to fix dtbs_check warning:
>>   k3-j721e-common-proc-board.dt.yaml: smmu@36600000: $nodename:0: 
>> 'smmu@36600000' does not match '^iommu@[0-9a-f]*'
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Acked-by: Suman Anna <s-anna@ti.com>

>> ---
>>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi 
>> b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> index 5d82de4097bb..0ac23c4414a2 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> @@ -95,7 +95,7 @@
>>               interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>>           };
>> -        smmu0: smmu@36600000 {
>> +        smmu0: iommu@36600000 {
>>               compatible = "arm,smmu-v3";
>>               reg = <0x0 0x36600000 0x0 0x100000>;
>>               interrupt-parent = <&gic500>;
>>
> 
> Pls, ignore "3/3" in subj.
> 

