Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0584C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858FC214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="modb9885"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404504AbgAXLdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:33:06 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49200 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388159AbgAXLdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:33:03 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00OBWtri042094;
        Fri, 24 Jan 2020 05:32:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579865575;
        bh=c8f7d0QFL08xNSoD/1DZYVvClgyENpiDhzqCItQ9mFs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=modb9885HvyjGetaE6PWy8EkNHP1tLV7mEeoDXo3Q0Dfd1sSkEt9rw/5Xs2iztVxG
         veV0SIuzJBowghsAJj5sEcnIxBCzvE66BFQSN+6pov1hmMw5QSF7D0ccHbEz0RQflj
         l52eU8Pmj4oONlgIpzC/eOyCIeLlz20SFD3Lg0/U=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00OBWtRY127768
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Jan 2020 05:32:55 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 24
 Jan 2020 05:32:53 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 24 Jan 2020 05:32:53 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00OBWpEk091417;
        Fri, 24 Jan 2020 05:32:51 -0600
Subject: Re: [PATCH v3 0/9] arm64: dts: ti: UDMAP and McASP support
To:     Lokesh Vutla <lokeshvutla@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>, <nm@ti.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200123114528.26552-1-peter.ujfalusi@ti.com>
 <7a34dbfa-426d-061e-cbf6-3da1d8bada65@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <14b395ad-122a-3331-5b89-b6f8708bc00e@ti.com>
Date:   Fri, 24 Jan 2020 13:32:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <7a34dbfa-426d-061e-cbf6-3da1d8bada65@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2020 14:35, Lokesh Vutla wrote:
> 
> 
> On 23/01/20 5:15 PM, Peter Ujfalusi wrote:
>> Hi,
>>
>> Changes since v2:
>> - Correct unit addresses for the McASP nodes
>> - Remove unit address and label for MAIN and MCU NAVSS
>>
>> Changes since v1:
>> - rebased on ti-k3-next
>> - Corrected j721e mcu_udma node: s/udmap/dma-controller
>> - Moved the two McASP node patch at the end of the series
>>
>> The ringacc and UDMA documentation and drivers are in next-20200122.
>>
>> While adding the DMA support I have noticed few issues which is also fixed by
>> this series.
> 
> 
> Entire series looks good to me.
> 
> Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Queued the whole series towards 5.6, thanks.

-Tero

> 
>>
>> Tero: I have included the McASP nodes as well to have examples for other
>> peripherals on how he binding should be used.
>> The patches for the McASP driver is not in next, but they are only internal
>> driver changes (and Kconfig), not adding new DT dependencies.
>> Since the McASP is disabled in SoC dtsi due to board level configuration needs
>> it is not going to erroneously probe drivers.
>>
>> It is up to you if you pick them or not, but I believe they serve a safe and
>> nice example how the dma binding should be used for UDMA.
>>
>> Regards,
>> Peter
>> ---
>> Peter Ujfalusi (9):
>>    arm64: dts: ti: k3-am65-main: Correct main NAVSS representation
>>    arm64: dts: ti: k3-am65-main: Move secure proxy under cbass_main_navss
>>    arm64: dts: ti: k3-am65: DMA support
>>    arm64: dts: ti: k3-j721e: Correct the address for MAIN NAVSS
>>    arm64: dts: ti: k3-j721e-main: Correct main NAVSS representation
>>    arm64: dts: ti: k3-j721e-main: Move secure proxy and smmu under
>>      main_navss
>>    arm64: dts: ti: k3-j721e: DMA support
>>    arm64: dts: ti: k3-am654-main: Add McASP nodes
>>    arm64: dts: ti: k3-j721e-main: Add McASP nodes
>>
>>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 122 ++++++-
>>   arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       |  46 +++
>>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 313 ++++++++++++++++--
>>   .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  45 +++
>>   arch/arm64/boot/dts/ti/k3-j721e.dtsi          |   2 +-
>>   5 files changed, 491 insertions(+), 37 deletions(-)
>>

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
