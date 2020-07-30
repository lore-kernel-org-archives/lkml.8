Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A876C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2441420829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbgG3OlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:41:03 -0400
Received: from foss.arm.com ([217.140.110.172]:40794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729092AbgG3OlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:41:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D42F61FB;
        Thu, 30 Jul 2020 07:41:01 -0700 (PDT)
Received: from [10.37.12.83] (unknown [10.37.12.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E2313F71F;
        Thu, 30 Jul 2020 07:41:00 -0700 (PDT)
Subject: Re: [RFC PATCH 01/14] coresight: etm4x: Skip save/restore before
 device registration
To:     mathieu.poirier@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, coresight@lists.linaro.org
References: <20200722172040.1299289-1-suzuki.poulose@arm.com>
 <20200722172040.1299289-2-suzuki.poulose@arm.com>
 <20200729180128.GA3073178@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <dc1409bf-3b8a-d669-fb9a-09537d01fb0f@arm.com>
Date:   Thu, 30 Jul 2020 15:45:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200729180128.GA3073178@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/29/2020 07:01 PM, Mathieu Poirier wrote:
> Hi Suzuki,
> 
> I have starte to review this - comments will be scattered over a few days.
> 
> On Wed, Jul 22, 2020 at 06:20:27PM +0100, Suzuki K Poulose wrote:
>> Skip cpu save/restore before the coresight device is registered.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm4x.c | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
>> index 6d7d2169bfb2..cb83fb77ded6 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
>> @@ -1135,7 +1135,13 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
>>   {
>>   	int i, ret = 0;
>>   	struct etmv4_save_state *state;
>> -	struct device *etm_dev = &drvdata->csdev->dev;
>> +	struct coresight_device *csdev = drvdata->csdev;
>> +	struct device *etm_dev;
>> +
>> +	if (WARN_ON(!csdev))
>> +		return -ENODEV;
>> +
>> +	etm_dev = &csdev->dev;
>>   
>>   	/*
>>   	 * As recommended by 3.4.1 ("The procedure when powering down the PE")
>> @@ -1261,6 +1267,10 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
>>   {
>>   	int i;
>>   	struct etmv4_save_state *state = drvdata->save_state;
>> +	struct coresight_device *csdev = drvdata->csdev;
>> +
>> +	if (WARN_ON(!csdev))
>> +		return;
> 
> Restore and save operations are only called from etm4_cpu_pm_notify() where the
> check for a valid drvdata->csdev is already done.
> 

Correct, this is just an enforcement as we are going to rely on the 
availability of drvdata->csdev to access the device with the
introduction of abstraction. This is why we WARN_ON() as we should
never hit this case.

>>   
>>   	CS_UNLOCK(drvdata->base);
>>   
>> @@ -1368,6 +1378,10 @@ static int etm4_cpu_pm_notify(struct notifier_block *nb, unsigned long cmd,
>>   
>>   	drvdata = etmdrvdata[cpu];
>>   
>> +	/* If we have not registered the device there is nothing to do */
>> +	if (!drvdata->csdev)
>> +		return NOTIFY_OK;
> 
> Can you describe the scenario you've seen this happening in?  Probably best to
> add it to the changelog.

The CPU PM notifier is registered with the probing of the first ETM
device. Now, another ETM device could be probed (on a different CPU
than the parent of this ETM). Now, there is a very narrow window of
time between :

1) Initialise etmdrvdata[cpu]

2) Register the coresight_device for the ETM.(i.e, coresight_register()).

If the CPU is put on idle, after (1) and before (2), we end up with

drvdata->csdev == NULL.

This is unacceptable and there is no need to take an action in
such case. This patch fixes the potential problem, also making
sure that we have the access methods available when we need it.
(drvdata->csdev->access)

I will add it to the commit message.

Cheers
Suzuki
