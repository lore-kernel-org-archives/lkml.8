Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01519C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8DD7208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbgGaJea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:34:30 -0400
Received: from foss.arm.com ([217.140.110.172]:53780 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbgGaJe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:34:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D21DE31B;
        Fri, 31 Jul 2020 02:34:28 -0700 (PDT)
Received: from [10.37.12.83] (unknown [10.37.12.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7773F3F66E;
        Fri, 31 Jul 2020 02:34:27 -0700 (PDT)
Subject: Re: [RFC PATCH 04/14] coresight: etm4x: Free up argument of
 etm4_init_arch_data
To:     mathieu.poirier@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, coresight@lists.linaro.org
References: <20200722172040.1299289-1-suzuki.poulose@arm.com>
 <20200722172040.1299289-5-suzuki.poulose@arm.com>
 <20200730173131.GA3155687@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <d732bde3-43b2-e49c-15c7-b48bf1108133@arm.com>
Date:   Fri, 31 Jul 2020 10:39:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200730173131.GA3155687@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30/2020 06:31 PM, Mathieu Poirier wrote:
> On Wed, Jul 22, 2020 at 06:20:30PM +0100, Suzuki K Poulose wrote:
>> etm4_init_arch_data is called early during the device probe,
>> even before the coresight_device is registered. Since we are
>> about to replace the direct access via abstraction layer, we
>> need a way to pass in the csdev_access for the given device.
>> Towards this free up the argument, which is already available
>> via etmdrvdata[smp_processor_id()].
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm4x.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
>> index 7bb74c659c4f..67deb4a4e618 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
>> @@ -614,7 +614,8 @@ static const struct coresight_ops etm4_cs_ops = {
>>   	.source_ops	= &etm4_source_ops,
>>   };
>>   
>> -static void etm4_init_arch_data(void *info)
>> +
>> +static void etm4_init_arch_data(void *__unused)
>>   {
>>   	u32 etmidr0;
>>   	u32 etmidr1;
>> @@ -622,8 +623,14 @@ static void etm4_init_arch_data(void *info)
>>   	u32 etmidr3;
>>   	u32 etmidr4;
>>   	u32 etmidr5;
>> -	struct etmv4_drvdata *drvdata = info;
>> -	int i;
>> +	struct etmv4_drvdata *drvdata;
>> +	int i, cpu;
>> +
>> +	cpu = raw_smp_processor_id();
> 
> Can you provide details on the motivation to use the raw_ version over the regular
> one?  As far as I can see in linux/smp.h there is no difference between them
> unless DEBUB_PREEMPT is enabled.  Even then the debug version won't complain
> since the task is CPU affined.
> 

Right, it is partly my misunderstanding. debug_smp_processor_id() is to
detect cases where smp_processor_id() is called in pre-emptible
contexts. This is not the case here. So it is fine to use the
smp_processor_id(). I will switch to that in the next version.

Thanks
Suzuki
