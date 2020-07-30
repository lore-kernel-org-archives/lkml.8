Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250A0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07FE42070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbgG3OyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:54:06 -0400
Received: from foss.arm.com ([217.140.110.172]:40918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgG3OyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:54:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF1841FB;
        Thu, 30 Jul 2020 07:54:04 -0700 (PDT)
Received: from [10.37.12.83] (unknown [10.37.12.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 339BF3F66E;
        Thu, 30 Jul 2020 07:54:03 -0700 (PDT)
Subject: Re: [RFC PATCH 02/14] coresight: Introduce device access abstraction
To:     mathieu.poirier@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, coresight@lists.linaro.org
References: <20200722172040.1299289-1-suzuki.poulose@arm.com>
 <20200722172040.1299289-3-suzuki.poulose@arm.com>
 <20200729195617.GB3073178@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <a841f0a4-e371-b5ba-c451-ec49d9f6e10b@arm.com>
Date:   Thu, 30 Jul 2020 15:58:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200729195617.GB3073178@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/29/2020 08:56 PM, Mathieu Poirier wrote:
> On Wed, Jul 22, 2020 at 06:20:28PM +0100, Suzuki K Poulose wrote:
>> We are about to introduce support for sysreg access to ETMv4.4+
>> component. Since there are generic routines that access the
>> registers (e.g, CS_LOCK/UNLOCK , claim/disclaim operations, timeout)
>> and in order to preserve the logic of these operations at a single place
>> we introduce an abstraction layer for the accesses to a given device.
>> This will also be helpful in consolidating the sysfs.attribute helpers,
>> that we define per driver.
> 
> Please drop the last sentence, it doesn't add to the current patch.
> 

Sure.

>> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
>> index e9c90f2de34a..38e9c03ab754 100644
>> --- a/drivers/hwtracing/coresight/coresight.c
>> +++ b/drivers/hwtracing/coresight/coresight.c
>> @@ -1387,6 +1387,54 @@ static int __init coresight_init(void)
>>   }

...

>>    * coresight_release_platform_data: Release references to the devices connected
>>    * to the output port of this device.
>> @@ -1451,6 +1499,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>>   	csdev->type = desc->type;
>>   	csdev->subtype = desc->subtype;
>>   	csdev->ops = desc->ops;
>> +	csdev->access = desc->access;
>>   	csdev->orphan = false;
>>   
>>   	csdev->dev.type = &coresight_dev_type[desc->type];
>> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
>> index 58fffdecdbfd..81ac708689f8 100644
>> --- a/include/linux/coresight.h
>> +++ b/include/linux/coresight.h
>> @@ -7,6 +7,7 @@
>>   #define _LINUX_CORESIGHT_H
>>   
>>   #include <linux/device.h>
>> +#include <linux/io.h>
>>   #include <linux/perf_event.h>
>>   #include <linux/sched.h>
>>   
>> @@ -114,6 +115,32 @@ struct coresight_platform_data {
>>   	struct coresight_connection *conns;
>>   };
>>   
>> +/**
>> + * struct csdev_access - Abstraction of a CoreSight device access.
>> + *
>> + * @no_iomem	: True if the device doesn't have iomem access.
>> + * @base	: When no_iomem == false, base address of the component
>> + * @read	: Read from the given "offset" of the given instance.
>> + * @write	: Write "val" to the given "offset".
>> + */
>> +struct csdev_access {
>> +	bool no_iomem;
> 
> I find the no_iomen to be difficult to understand, especially when prefixed with
> '!'.  Using "has_iomem" would be a lot more intuitive and would avoid extra
> mental gymnastics.


I agree. That was a bit of laziness in part, to limit the changes to the
existing drivers, where almost everyone, except the ETM would need to
simply use the MMIO approach. So, in order to keep those changes to
minimum, i.e, simply initialize the base, I used the inverted logic.
I will fix it.



>> +u32 coresight_relaxed_read32(struct coresight_device *csdev, u32 offset);
>> +u32 coresight_read32(struct coresight_device *csdev, u32 offset);
>> +void coresight_write32(struct coresight_device *csdev, u32 val, u32 offset);
>> +void coresight_relaxed_write32(struct coresight_device *csdev,
>> +			       u32 val,
>> +			       u32 offset);
>> +
> 
> Why are the 64 bit version outside of the #ifdef and the 32 bit within?

Mistake ;-). I will address all of the comments above in my next version.

...


>> +static inline u64 coresight_read64(struct coresight_device *csdev, u32 offset)
>> +{
>> +	WARN_ON_ONCE(1);
> 
> Not sure about the motivation behind using WARN_ON_ONCE(), and only in the read
> functions.  I would simply return 0 here.  After all if CONFIG_CORESIGHT is not
> defined they won't make it very far.
> 

If someone is reading the values, they might do something with the
value, i.e, make a decision when they shouldn't. This is just to prevent
such cases.

>> +	return 0;
>> +}
>> +
>> +static inline void coresight_relaxed_write64(struct coresight_device *csdev,
>> +					     u64 val,
>> +					     u32 offset)
>> +{
>> +}
>> +
>> +static inline void coresight_write64(struct coresight_device *csdev, u64 val, u32 offset)
>> +{
>> +}
>> +
>>   #endif
> 
> I will likely come back to this patch once I have reviewed the rest of the set.
> 

Sure. I am looking for thoughts on the proposed API (not ABI) changes,
as they are quite significant and invasive changes in the code, without
much functionality changes.


Thank you for the review !

Suzuki
