Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE99C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA59620658
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgBJPDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:03:14 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51874 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgBJPDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:03:13 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 725CF290B17
Subject: Re: [PATCH v2] platform/chrome: wilco_ec: Platform data shan't
 include kernel.h
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nick Crews <ncrews@chromium.org>, linux-kernel@vger.kernel.org,
        Daniel Campello <campello@chromium.org>
References: <20200205094828.77940-1-andriy.shevchenko@linux.intel.com>
 <20200210145721.GX10400@smile.fi.intel.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <4e78d3ca-7e41-a201-18c8-d91923423827@collabora.com>
Date:   Mon, 10 Feb 2020 16:03:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200210145721.GX10400@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 10/2/20 15:57, Andy Shevchenko wrote:
> On Wed, Feb 05, 2020 at 11:48:28AM +0200, Andy Shevchenko wrote:
>> Replace with appropriate types.h.
>>
>> Also there is no need to include device.h, but mutex.h.
>> For the pointers to unknown structures use forward declarations.
>>
>> In the *.c files we need to include all headers that provide APIs
>> being used in the module.
> 
> Anybody to comment?
> 

LGTM, I silently queued this patch this morning in our kernelci branch to give a
try. Waiting for the results, if all goes well will be queued for-next.

Thanks,
 Enric

>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>> v2: update *.c files (kbuild test robot)
>>  drivers/platform/chrome/wilco_ec/properties.c | 3 +++
>>  drivers/platform/chrome/wilco_ec/sysfs.c      | 4 ++++
>>  include/linux/platform_data/wilco-ec.h        | 8 ++++++--
>>  3 files changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/platform/chrome/wilco_ec/properties.c b/drivers/platform/chrome/wilco_ec/properties.c
>> index e69682c95ea2..a0cbd8bd2851 100644
>> --- a/drivers/platform/chrome/wilco_ec/properties.c
>> +++ b/drivers/platform/chrome/wilco_ec/properties.c
>> @@ -3,8 +3,11 @@
>>   * Copyright 2019 Google LLC
>>   */
>>  
>> +#include <linux/errno.h>
>> +#include <linux/export.h>
>>  #include <linux/platform_data/wilco-ec.h>
>>  #include <linux/string.h>
>> +#include <linux/types.h>
>>  #include <linux/unaligned/le_memmove.h>
>>  
>>  /* Operation code; what the EC should do with the property */
>> diff --git a/drivers/platform/chrome/wilco_ec/sysfs.c b/drivers/platform/chrome/wilco_ec/sysfs.c
>> index f0d174b6bb21..3c587b4054a5 100644
>> --- a/drivers/platform/chrome/wilco_ec/sysfs.c
>> +++ b/drivers/platform/chrome/wilco_ec/sysfs.c
>> @@ -8,8 +8,12 @@
>>   * See Documentation/ABI/testing/sysfs-platform-wilco-ec for more information.
>>   */
>>  
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>>  #include <linux/platform_data/wilco-ec.h>
>> +#include <linux/string.h>
>>  #include <linux/sysfs.h>
>> +#include <linux/types.h>
>>  
>>  #define CMD_KB_CMOS			0x7C
>>  #define SUB_CMD_KB_CMOS_AUTO_ON		0x03
>> diff --git a/include/linux/platform_data/wilco-ec.h b/include/linux/platform_data/wilco-ec.h
>> index afede15a95bf..25f46a939637 100644
>> --- a/include/linux/platform_data/wilco-ec.h
>> +++ b/include/linux/platform_data/wilco-ec.h
>> @@ -8,8 +8,8 @@
>>  #ifndef WILCO_EC_H
>>  #define WILCO_EC_H
>>  
>> -#include <linux/device.h>
>> -#include <linux/kernel.h>
>> +#include <linux/mutex.h>
>> +#include <linux/types.h>
>>  
>>  /* Message flags for using the mailbox() interface */
>>  #define WILCO_EC_FLAG_NO_RESPONSE	BIT(0) /* EC does not respond */
>> @@ -17,6 +17,10 @@
>>  /* Normal commands have a maximum 32 bytes of data */
>>  #define EC_MAILBOX_DATA_SIZE		32
>>  
>> +struct device;
>> +struct resource;
>> +struct platform_device;
>> +
>>  /**
>>   * struct wilco_ec_device - Wilco Embedded Controller handle.
>>   * @dev: Device handle.
>> -- 
>> 2.24.1
>>
> 
