Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85967C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 11:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66D59208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 11:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732701AbgGaLcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 07:32:12 -0400
Received: from foss.arm.com ([217.140.110.172]:55506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732104AbgGaLcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 07:32:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F6951FB;
        Fri, 31 Jul 2020 04:32:11 -0700 (PDT)
Received: from [10.37.12.83] (unknown [10.37.12.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33C213F71F;
        Fri, 31 Jul 2020 04:32:09 -0700 (PDT)
Subject: Re: [RFC PATCH 03/14] coresight: tpiu: Use coresight device access
 abstraction
To:     mathieu.poirier@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, coresight@lists.linaro.org
References: <20200722172040.1299289-1-suzuki.poulose@arm.com>
 <20200722172040.1299289-4-suzuki.poulose@arm.com>
 <20200729210105.GC3073178@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <02f28b5f-d3d6-755f-066d-88b90aa35eef@arm.com>
Date:   Fri, 31 Jul 2020 12:36:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200729210105.GC3073178@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/29/2020 10:01 PM, Mathieu Poirier wrote:
> On Wed, Jul 22, 2020 at 06:20:29PM +0100, Suzuki K Poulose wrote:
>> TPIU driver access the device before the coresight device
>> is registered. In other words, before the drvdata->csdev
>> is valid. Thus, we need to make sure that the csdev_access
>> is valid for both the invocations. Switch to using the
>> csdev_access directly instead of relying on availability
>> of drvdata->csdev.
> 
> I'm not sure all of the above is needed and based on the wording I could easily
> see this patch being selected for stable backport, which would be a mistak.
> 
> The gist of this patch is that we are moving to the access abstraction and the
> changelog should reflect that.

True, I will make it something like :

"Prepare the TPIU driver to make use of the CoreSight device access
abstraction layer. The driver touches the device even before the
coresight device is registered. Thus we could be accessing the
devices without a csdev. As we are about to use the abstraction
layer for accessing the device, pass in the access directly
to avoid having to deal with the un-initialised csdev.


>>   
>>   static int tpiu_disable(struct coresight_device *csdev)
>>   {
>> -	struct tpiu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> -
>>   	if (atomic_dec_return(csdev->refcnt))
>>   		return -EBUSY;
>>   
>> -	tpiu_disable_hw(drvdata);
>> +	tpiu_disable_hw(&csdev->access);
>>   
>>   	dev_dbg(&csdev->dev, "TPIU disabled\n");
>>   	return 0;
>> @@ -152,7 +148,7 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
>>   	desc.access.base = base;
> 
> Any reason for introducing the above in patch 02?  I would have done that as
> part of this patch...  Also part of this patch I would remove drvdata::base
> since it is no longer needed.

The patch 02 is not touching how the individual drivers access the
device, yet. It only sets the way by introducing the layer. As per
the proposed change, this is a preparation of the TPIU driver, so
that we can convert the generic helper functions ( coresight_timeout())
more easily and keep the patch 05 easier for review (just like the Patch
4, which prepares the ETM driver).

Cheers
Suzuki


> 
> I'm out of time for today - I will continue tomorrow.
> 
> Regards,
> Mathieu
> 
>>   
>>   	/* Disable tpiu to support older devices */
>> -	tpiu_disable_hw(drvdata);
>> +	tpiu_disable_hw(&desc.access);
>>   
>>   	pdata = coresight_get_platform_data(dev);
>>   	if (IS_ERR(pdata))
>> -- 
>> 2.24.1
>>

