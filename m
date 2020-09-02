Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E740C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 10:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73D8E2071B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 10:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgIBKgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 06:36:39 -0400
Received: from foss.arm.com ([217.140.110.172]:35256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgIBKgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 06:36:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD2ADD6E;
        Wed,  2 Sep 2020 03:36:35 -0700 (PDT)
Received: from [10.37.8.67] (unknown [10.37.8.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5681D3F66F;
        Wed,  2 Sep 2020 03:36:25 -0700 (PDT)
Subject: Re: [RFC PATCH v2] coresight: etm4x: Modify core-commit of cpu to
 avoid the overflow of HiSilicon ETM
To:     mathieu.poirier@linaro.org, liuqi115@huawei.com
Cc:     gregkh@linuxfoundation.org, mike.leach@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, coresight@lists.linaro.org
References: <1597824397-29894-1-git-send-email-liuqi115@huawei.com>
 <20200827204426.GD22307@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <548c973d-6964-ca5c-4c8d-fbc2386f3349@arm.com>
Date:   Wed, 2 Sep 2020 11:41:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200827204426.GD22307@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/27/2020 09:44 PM, Mathieu Poirier wrote:
> Hi Liu,
> 
> On Wed, Aug 19, 2020 at 04:06:37PM +0800, Qi Liu wrote:
>> When too much trace information is generated on-chip, the ETM will
>> overflow, and cause data loss. This is a common phenomenon on ETM
>> devices.
>>
>> But sometimes we do not want to lose performance trace data, so we
>> suppress the speed of instructions sent from CPU core to ETM to
>> avoid the overflow of ETM.
>>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> ---
>>
>> Changes since v1:
>> - ETM on HiSilicon Hip09 platform supports backpressure, so does
>> not need to modify core commit.
>>
>>   drivers/hwtracing/coresight/coresight-etm4x.c | 43 +++++++++++++++++++++++++++
>>   1 file changed, 43 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
>> index 7797a57..7641f89 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
>> @@ -43,6 +43,10 @@ MODULE_PARM_DESC(boot_enable, "Enable tracing on boot");
>>   #define PARAM_PM_SAVE_NEVER	  1 /* never save any state */
>>   #define PARAM_PM_SAVE_SELF_HOSTED 2 /* save self-hosted state only */
>>
>> +#define CORE_COMMIT_CLEAR	0x3000
>> +#define CORE_COMMIT_SHIFT	12
>> +#define HISI_ETM_AMBA_ID_V1	0x000b6d01
>> +
>>   static int pm_save_enable = PARAM_PM_SAVE_FIRMWARE;
>>   module_param(pm_save_enable, int, 0444);
>>   MODULE_PARM_DESC(pm_save_enable,
>> @@ -104,11 +108,40 @@ struct etm4_enable_arg {
>>   	int rc;
>>   };
>>
>> +static void etm4_cpu_actlr1_cfg(void *info)
>> +{
>> +	struct etm4_enable_arg *arg = (struct etm4_enable_arg *)info;
>> +	u64 val;
>> +
>> +	asm volatile("mrs %0,s3_1_c15_c2_5" : "=r"(val));


The ID register (S3_1_C15_c2_5) falls into implementation defined space.
See Arm ARM DDI 0487F.a, section "D12.3.2  Reserved encodings for 
IMPLEMENTATION DEFINED registers".

So, please stop calling this "etm4_cpu_actlr1_cfg". Since,
1) actlr1 is not an architected name for the said encoding
2) The id register could mean something else on another CPU.

Rather this should indicate platform/CPU specific. e.g,

etm4_cpu_hisilicon_config_core_commit()


>> +	val &= ~CORE_COMMIT_CLEAR;
>> +	val |= arg->rc << CORE_COMMIT_SHIFT;
>> +	asm volatile("msr s3_1_c15_c2_5,%0" : : "r"(val));
>> +}
>> +
>> +static void etm4_config_core_commit(int cpu, int val)
>> +{
>> +	struct etm4_enable_arg arg = {0};
>> +
>> +	arg.rc = val;
>> +	smp_call_function_single(cpu, etm4_cpu_actlr1_cfg, &arg, 1);
> 
> Function etm4_enable/disable_hw() are already running on the CPU they are
> supposed to so no need to call smp_call_function_single().
> 
>> +}
>> +
>>   static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>>   {
>>   	int i, rc;
>> +	struct amba_device *adev;
>>   	struct etmv4_config *config = &drvdata->config;
>>   	struct device *etm_dev = &drvdata->csdev->dev;
>> +	struct device *dev = drvdata->csdev->dev.parent;
>> +
>> +	adev = container_of(dev, struct amba_device, dev);
>> +	/*
>> +	 * If ETM device is HiSilicon ETM device, reduce the
>> +	 * core-commit to avoid ETM overflow.
>> +	 */
>> +	if (adev->periphid == HISI_ETM_AMBA_ID_V1)

Please could you move this check to the function above ?
Ideally, it would be good to have something like :

	etm4_config_impdef_features();

And :

	etm4_config_impdef_features(struct etm4_drvdata *drvdata)
	{
		etm4_cpu_hisilicon_config_core_commit(drvdata);
	}

> 
> Do you have any documentation on this back pressure feature?  I doubt this is
> specific to Hip09 platform and as such would prefer to have a more generic
> approach that works on any platform that supports it.
> 
> Anyone on the CS mailing list that knows what this is about?

I believe this is hisilicon specific. May be same across their CPUs, may
be a specific one. There is no architectural guarantee.


Cheers
Suzuki
