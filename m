Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E993C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 12:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E6B24673
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 12:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rB1SF7Tv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgAVMKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 07:10:22 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40962 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgAVMKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 07:10:21 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00MC9q30125917;
        Wed, 22 Jan 2020 06:09:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579694992;
        bh=DURafSP9jXxKBg06v735OUNmSHNLqrtC9E3PQ25ELkk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rB1SF7TvFaXo2dRUOVoUlXi/QZEjwZMQcvNhPv9TuzM0HRqudEDpt26Ko5geBMKi5
         EwqRGi5LplxTS1jOFFqJVbTHCqJCknTECTiVCpHNsJSP+U7FPx3jlIRXdbzYVgehkN
         Mzf5nr9/WRo2YSVjDWg7xSqiVMb/NO3nERsaYBWw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00MC9qeS058322
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Jan 2020 06:09:52 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 22
 Jan 2020 06:09:52 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 22 Jan 2020 06:09:52 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00MC9kbi046917;
        Wed, 22 Jan 2020 06:09:48 -0600
Subject: Re: [PATCH v2] mtd: spi-nor: keep lock bits if they are non-volatile
To:     <Tudor.Ambarus@microchip.com>, <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <richard@nod.at>, <boris.brezillon@collabora.com>,
        <miquel.raynal@bootlin.com>, <marex@denx.de>
References: <20200103221229.7287-1-michael@walle.cc>
 <8187061.UfBqSTmf1g@192.168.0.113>
 <62b578b07d5eb46a015dafd4c2f45bc2@walle.cc>
 <5323055.WqobA3rpa8@192.168.0.113>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <990b9b16-36e5-ce73-36c7-0ebfa391c26b@ti.com>
Date:   Wed, 22 Jan 2020 17:40:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5323055.WqobA3rpa8@192.168.0.113>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/01/20 12:23 am, Tudor.Ambarus@microchip.com wrote:
> Hi, Michael, Vignesh,
> 
> On Sunday, January 12, 2020 12:50:57 AM EET Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the
>> content is safe
[...]

>>> I see three choices:
>>> 1/ dt prop which gives a per flash granularity. The prop is related to
>>> hw
>>> protection and there might be some chances to get this accepted, maybe
>>> it is
>>> worth to involve Rob. But I tend to share Vignesh's opinion, this would
>>> configure the flash and not describe it.
>>
>> Still my preferred way. but also see below. But I wouldn't say it
> 
> Try to convince Rob.
> 
>> configures the
>> flash but describe that the user want to use the write protection.
>>
>>> 2/ kconfig option, the behavior would be enforced on all the flashes.
>>> It would
>>> be similar to what we have with CONFIG_MTD_SPI_NOR_USE_4K_SECTORS. I
>>> did a
>>> patch to address this some time ago:
>>> https://patchwork.ozlabs.org/patch/
>>> 1133278/
>>
>> Mhh. If we would combine this with this patch that would be at least a
>> step into
>> the right direction. At least a distro could enable that kernel option
>> without
>> breaking old boards/flashes. Because as outlined about you need that for
>> flashes
>> in category (2). Or you'd have to do a flash_unlock every time you want
>> to write
>> to it. But that would be really a backwards incompatible change.. ;)
>>
>>> 3/ module param, the behavior would be enforced on all the flashes.
>>>
>>> Preferences or suggestions?
>>
> I would go with 2/ or 3/. Vignesh, what do you prefer and why?
> 

I dont like option 1, because I am not convinced that this is a HW
description to be put in DT.  IIUC, problem is more of what to do with
locking configuration that is done before Linux comes up(either in
previous boot or by bootloader or POR default). Current code just
discards it and unlocks entire flash.
But proposal is not to touch those bits at probe time and leave this
upto userspace to handle.

Adding a Kconfig does not scale well for multi-platform builds. There
would not be a way to have protection enabled on one platform but
disabled on other. Does not scale for multiple flashes either

Option 3 sounds least bad among all. If module param can be designed to
be a string then, we could control locking behavior to be per flash
using flash name.


-- 
Regards
Vignesh
