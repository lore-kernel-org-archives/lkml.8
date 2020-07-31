Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A686C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6720F20829
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732273AbgGaJlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:41:31 -0400
Received: from foss.arm.com ([217.140.110.172]:53892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732257AbgGaJla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:41:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57AEC31B;
        Fri, 31 Jul 2020 02:41:30 -0700 (PDT)
Received: from [10.37.12.83] (unknown [10.37.12.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C54463F66E;
        Fri, 31 Jul 2020 02:41:28 -0700 (PDT)
Subject: Re: [RFC PATCH 06/14] coresight: Convert claim and lock operations to
 use access wrappers
To:     mathieu.poirier@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, coresight@lists.linaro.org
References: <20200722172040.1299289-1-suzuki.poulose@arm.com>
 <20200722172040.1299289-7-suzuki.poulose@arm.com>
 <20200730195450.GC3155687@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <453196b1-7549-dca5-169a-eff98f8d720e@arm.com>
Date:   Fri, 31 Jul 2020 10:46:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200730195450.GC3155687@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30/2020 08:54 PM, Mathieu Poirier wrote:
> On Wed, Jul 22, 2020 at 06:20:32PM +0100, Suzuki K Poulose wrote:
>> Convert the CoreSight CLAIM set/clear, LOCK/UNLOCK operations to
>> use the coresight device access abstraction.
>>
>> Mostly a mechanical change.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-catu.c  | 14 ++--
>>   .../hwtracing/coresight/coresight-cpu-debug.c | 26 ++++++--
>>   .../hwtracing/coresight/coresight-cti-sysfs.c |  4 +-
>>   drivers/hwtracing/coresight/coresight-cti.c   | 30 +++++----
>>   drivers/hwtracing/coresight/coresight-etb10.c | 20 +++---
>>   .../coresight/coresight-etm3x-sysfs.c         |  8 +--
>>   drivers/hwtracing/coresight/coresight-etm3x.c | 44 ++++++++-----
>>   drivers/hwtracing/coresight/coresight-etm4x.c | 44 ++++++++-----
>>   .../hwtracing/coresight/coresight-funnel.c    | 18 ++---
>>   drivers/hwtracing/coresight/coresight-priv.h  |  9 +--
>>   .../coresight/coresight-replicator.c          | 27 +++++---
>>   drivers/hwtracing/coresight/coresight-stm.c   | 46 ++++++++-----
>>   .../hwtracing/coresight/coresight-tmc-etf.c   | 36 ++++++----
>>   .../hwtracing/coresight/coresight-tmc-etr.c   | 19 +++---
>>   drivers/hwtracing/coresight/coresight-tpiu.c  |  9 +--
>>   drivers/hwtracing/coresight/coresight.c       | 66 +++++++++++--------
>>   include/linux/coresight.h                     | 16 ++---
>>   17 files changed, 266 insertions(+), 170 deletions(-)
>>

...

>> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
>> index 67fc3e3b77d8..d61ffbfe0a5c 100644
>> --- a/drivers/hwtracing/coresight/coresight-funnel.c
>> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
>> @@ -52,13 +52,14 @@ static int dynamic_funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
>>   {
>>   	u32 functl;
>>   	int rc = 0;
>> +	struct coresight_device *csdev = drvdata->csdev;
>>   
>> -	CS_UNLOCK(drvdata->base);
>> +	CS_UNLOCK(&csdev->access);
>>   
>>   	functl = readl_relaxed(drvdata->base + FUNNEL_FUNCTL);
>>   	/* Claim the device only when we enable the first slave */
>>   	if (!(functl & FUNNEL_ENSx_MASK)) {
>> -		rc = coresight_claim_device_unlocked(drvdata->base);
>> +		rc = coresight_claim_device_unlocked(csdev);
>>   		if (rc)
>>   			goto done;
>>   	}
>> @@ -69,7 +70,7 @@ static int dynamic_funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
>>   	writel_relaxed(functl, drvdata->base + FUNNEL_FUNCTL);
>>   	writel_relaxed(drvdata->priority, drvdata->base + FUNNEL_PRICTL);
>>   done:
>> -	CS_LOCK(drvdata->base);
>> +	CS_LOCK(&csdev->access);
>>   	return rc;
>>   }
>>   
>> @@ -101,8 +102,9 @@ static void dynamic_funnel_disable_hw(struct funnel_drvdata *drvdata,
>>   				      int inport)
>>   {
>>   	u32 functl;
>> +	struct coresight_device *csdev = drvdata->csdev;
> 
> Sometimes a csdev variable is declared, sometimes not as in get_funnel_ctrl_hw()
> below and this makes it hard to review all these changes.  Please select a
> heuristic and keep with it.  I prefer this version but not dead set on it.

Agreed, will change.


> 
> Also please split in two, on for CS_LOCK/UNLOCK() and another one for the claim
> tag functions.

There is a minor dependency here. CS_LOCK/UNLOCK is issued from the 
coresight_{dis}claim_device() versions. One option is to choose the
following order:

1) convert claim/disclaim to accept csdev.
    And use csdev->access->base for CS_LOCK/UNLOCK.

2) Convert all CS_LOCK/UNLOCK to work on csdev->access.

I thought having this at one go might look better. But I agree, it is
better to split this one. I will give it a go.

Cheers
Suzuki
