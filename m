Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A9EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 17:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73DF214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 17:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pk8lMzDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgAWRVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 12:21:21 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58078 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbgAWRVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 12:21:20 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00NHKsx4050826;
        Thu, 23 Jan 2020 11:20:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579800054;
        bh=3gIbziJjyKajUTx1b0qn+STFFQnqmxy/nbpdeY5ApuY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pk8lMzDqe4modsPGk9srUr6q+8hDUKQT5SjYiaCK+0/NQpPnjLj0Bd1r8k0AWsd/d
         8ZeVQ+q5xnDJYth+qfR5BGJ6aaevQeUM+3dOvcUSMhXiPddNIrQNnwIy43HHrkqCCA
         /R/oj8fX843TXU2vHYwO6jdjCyj78JqxRT8f1yW8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00NHKsC7018970
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Jan 2020 11:20:54 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 23
 Jan 2020 11:20:54 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 23 Jan 2020 11:20:53 -0600
Received: from [10.250.133.86] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00NHKniV108940;
        Thu, 23 Jan 2020 11:20:50 -0600
Subject: Re: [PATCH v2] mtd: spi-nor: keep lock bits if they are non-volatile
To:     Michael Walle <michael@walle.cc>
CC:     <Tudor.Ambarus@microchip.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <richard@nod.at>,
        <boris.brezillon@collabora.com>, <miquel.raynal@bootlin.com>,
        <marex@denx.de>
References: <20200103221229.7287-1-michael@walle.cc>
 <8187061.UfBqSTmf1g@192.168.0.113>
 <62b578b07d5eb46a015dafd4c2f45bc2@walle.cc>
 <5323055.WqobA3rpa8@192.168.0.113>
 <990b9b16-36e5-ce73-36c7-0ebfa391c26b@ti.com>
 <e64cc3ac32d2b44c9e6f4b4f795354ae@walle.cc>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <a4f3657b-8ebe-a54d-8a11-c6e4ce8a3561@ti.com>
Date:   Thu, 23 Jan 2020 22:50:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e64cc3ac32d2b44c9e6f4b4f795354ae@walle.cc>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/22/2020 6:14 PM, Michael Walle wrote:
> Hi Vignesh,
> 
> Am 2020-01-22 13:10, schrieb Vignesh Raghavendra:
>> On 22/01/20 12:23 am, Tudor.Ambarus@microchip.com wrote:
>>> Hi, Michael, Vignesh,
>>>
>>> On Sunday, January 12, 2020 12:50:57 AM EET Michael Walle wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>>>> know the
>>>> content is safe
>> [...]
>>

[...]

>>>>> Preferences or suggestions?
>>>>
>>> I would go with 2/ or 3/. Vignesh, what do you prefer and why?
>>>
>>
>> I dont like option 1, because I am not convinced that this is a HW
>> description to be put in DT.  IIUC, problem is more of what to do with
>> locking configuration that is done before Linux comes up(either in
>> previous boot or by bootloader or POR default). Current code just
>> discards it and unlocks entire flash.
> 
> But this is not the main problem. It is rather the intention of the
> user to actually want write protect the flash (for flashes who has
> proper support for them, that is the ones which have non-volatile
> bits).
> 
> Flashes with volatile bits are another subject. Here it might be useful
> to unlock them either at probe time or when we first write to them, so
> the user doesn't need to know if its this kind of flash and he would
> actually have to unlock the flash before writing. I've left the
> behaviour for these flashes as it was before.
> 
> And yes, u-boot suffers from the same problem, eg. it unlocks the whole
> flash too. I guess they inherited the behaviour from linux. But I
> wanted to start with linux first.
> 

U-Boot only unlocks entire flash in case of Atmel or SST or Intel.

>> But proposal is not to touch those bits at probe time and leave this
>> upto userspace to handle.
> 
> No, my proposal was to divide the flashes into two categories. The
> unlocking is only done on the flashes which have volatile locking bits,
> thus even when the new option is enabled it won't break access to these
> flashes.
> 

Hmm, looks like before commit 3e0930f109e7 ("mtd: spi-nor: Rework the
disabling of block write protection") global unlock was being done only
for Atmel, SST and Intel flashes. So 3e0930f109e7 definitely changes
this behavior to unlock all flashes that have SPI_NOR_HAS_LOCK set (in
addition to Atmel,SST and Intel).
I think we should just revert to the behavior before 3e0930f109e7 so as
not to break userspace expectation of preserving non volatile BP setting
across boots

Are we sure there are no Atmel and SST flashes that have non-volatile BP
bits? If so, then I have no objection for this patch as this effectively
reverts back to behavior before 3e0930f109e7.

Regards
Vignesh

>> Adding a Kconfig does not scale well for multi-platform builds. There
>> would not be a way to have protection enabled on one platform but
>> disabled on other. Does not scale for multiple flashes either
>>
>> Option 3 sounds least bad among all. If module param can be designed to
>> be a string then, we could control locking behavior to be per flash
>> using flash name.
> 
> What about both? A kconfig option which defines the default for the
> kernel parameter? My fear is that once it is a kernel parameter it is
> easy to forget (thus having the non-volatile bits, the flash is
> completely unlocked again) and it is not very handy; for proper write
> protection you'd always have to have this parameter.
> 
> btw. I don't see a need to have this option per flash, because once
> the user actually enables it, he is aware that its for all of his
> flashes. I haven't seen flashes which has non-volatile protection bits
> _and_ are protected by default. There shouldn't be a noticable
> difference for the user if the option when enabled.
> 
> -michael
