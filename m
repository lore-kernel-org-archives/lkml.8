Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E27C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 13:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E7B206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 13:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b2NNtPZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389373AbgAXNON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 08:14:13 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39950 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387445AbgAXNON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 08:14:13 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00OC4hFK113955;
        Fri, 24 Jan 2020 06:04:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579867484;
        bh=ZiaD4SnCdosS8nQj0oAGF73NcGkqbYROWitRkBVgCU4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=b2NNtPZdhbz/8dI8KJE8mwbYPflq+53YLKNqNwKLejvpXl5CuIO9xUin33ng/zQIU
         IOiNYbLMKRbk8RAJhx2jG+cB7ypZFiT5tyBZCj0gga5D4GcJMP0m3OWUVde3dbk3YC
         14sCzXFRdKiE44Lzr+EaVBexwcMsuhI9JBngGOWo=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00OC4hd2012138
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Jan 2020 06:04:43 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 24
 Jan 2020 06:04:43 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 24 Jan 2020 06:04:43 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00OC4fPg018694;
        Fri, 24 Jan 2020 06:04:41 -0600
Subject: Re: [PATCH for-next] arm64: defconfig: Set bcm2835-dma as built-in
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     <f.fainelli@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <C0400CAEQS8N.3P1J37PC0KU9F@linux-9qgx>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <86672a12-6b88-dba8-0945-b6321ccf28c3@ti.com>
Date:   Fri, 24 Jan 2020 14:05:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <C0400CAEQS8N.3P1J37PC0KU9F@linux-9qgx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/01/2020 13.51, Nicolas Saenz Julienne wrote:
> Hi Peter,
> 
> On Fri Jan 24, 2020 at 1:31 PM, Peter Ujfalusi wrote:
>> Hi Nicolas,
>>
>> On 24/01/2020 13.17, Nicolas Saenz Julienne wrote:
>>> With the introduction of 738987a1d6f1 ("mmc: bcm2835: Use
>>> dma_request_chan() instead dma_request_slave_channel()") sdhost-bcm2835
>>> now waits for its DMA channel to be available when defined in the
>>> device-tree (it would previously default to PIO). Albeit the right
>>> behaviour, the MMC host is needed for booting. So this makes sure the
>>> DMA channel shows up in time.
>>>
>>> Fixes: 738987a1d6f1 ("mmc: bcm2835: Use dma_request_chan() instead dma_request_slave_channel()")
>>
>> it is not a bug, it is a feature ;)
> 
> Agree, I'm just afraid of your series being picked up by a stable
> release without this patch. But maybe it's not necessary?

If you need MMC rootfs then the DMA needs to be built in or have initrd
with the modules.
The driver expects to have DMA channel and it is going to wait for it to
appear unless the request fails.

Without moving the DMA as built in and removing the deferred probe
handling form the MMC driver, one can just remove the DMA support from
the mmc-bcm2835 as it is not used at all.

I wonder why this is not signaled by automated boot testing, if any
exists for bcm2835.

>> Yes, if a driver have DMA binding and it is needed during boot then the
>> DMA driver also needs to be built in.
>> I believe it is desired to use DMA instead of PIO in any case for MMC
>> and in the past bcm2835 did not used DMA if DMA was module and the MMC
>> was built in.
>>
>> Sorry for the inconvenience this change has caused to bcm2835!
> 
> Not at all :)
> 
>> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Thanks,
> Nicolas
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
