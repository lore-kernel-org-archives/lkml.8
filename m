Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A558C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 01:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36E8D2083E
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 01:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgIAB0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 21:26:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47226 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725993AbgIAB0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 21:26:53 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1453E38070FB3E0FDC7E;
        Tue,  1 Sep 2020 09:26:51 +0800 (CST)
Received: from [127.0.0.1] (10.65.95.32) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Tue, 1 Sep 2020
 09:26:45 +0800
Subject: Re: [RFC PATCH v2] coresight: etm4x: Modify core-commit of cpu to
 avoid the overflow of HiSilicon ETM
To:     Al Grant <Al.Grant@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
References: <1597824397-29894-1-git-send-email-liuqi115@huawei.com>
 <20200827204426.GD22307@xps15>
 <DB7PR08MB3355B59AE058823AEE3B372E86520@DB7PR08MB3355.eurprd08.prod.outlook.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>
From:   Qi Liu <liuqi115@huawei.com>
Message-ID: <5e10018f-bd1e-7fa5-db96-68dc88c34618@huawei.com>
Date:   Tue, 1 Sep 2020 09:26:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <DB7PR08MB3355B59AE058823AEE3B372E86520@DB7PR08MB3355.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.95.32]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

On 2020/8/28 17:00, Al Grant wrote:
> Hi Mathieu and CS maintainers,
>
>> Hi Liu,
>>
>> On Wed, Aug 19, 2020 at 04:06:37PM +0800, Qi Liu wrote:
>>> When too much trace information is generated on-chip, the ETM will
>>> overflow, and cause data loss. This is a common phenomenon on ETM
>>> devices.
>>>
>>> But sometimes we do not want to lose performance trace data, so we
>>> suppress the speed of instructions sent from CPU core to ETM to avoid
>>> the overflow of ETM.
>>>
>>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>>> ---
>>>
>>> Changes since v1:
>>> - ETM on HiSilicon Hip09 platform supports backpressure, so does not
>>> need to modify core commit.
>>>
>>>  drivers/hwtracing/coresight/coresight-etm4x.c | 43
>>> +++++++++++++++++++++++++++
>>>  1 file changed, 43 insertions(+)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c
>>> b/drivers/hwtracing/coresight/coresight-etm4x.c
>>> index 7797a57..7641f89 100644
>>> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
>>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
>>> @@ -43,6 +43,10 @@ MODULE_PARM_DESC(boot_enable, "Enable tracing
>> on boot");
>>>  #define PARAM_PM_SAVE_NEVER	  1 /* never save any state */
>>>  #define PARAM_PM_SAVE_SELF_HOSTED 2 /* save self-hosted state only */
>>>
>>> +#define CORE_COMMIT_CLEAR	0x3000
>>> +#define CORE_COMMIT_SHIFT	12
>>> +#define HISI_ETM_AMBA_ID_V1	0x000b6d01
>>> +
>>>  static int pm_save_enable = PARAM_PM_SAVE_FIRMWARE;
>>> module_param(pm_save_enable, int, 0444);
>>> MODULE_PARM_DESC(pm_save_enable, @@ -104,11 +108,40 @@ struct
>>> etm4_enable_arg {
>>>  	int rc;
>>>  };
>>>
>>> +static void etm4_cpu_actlr1_cfg(void *info) {
>>> +	struct etm4_enable_arg *arg = (struct etm4_enable_arg *)info;
>>> +	u64 val;
>>> +
>>> +	asm volatile("mrs %0,s3_1_c15_c2_5" : "=r"(val));
>>> +	val &= ~CORE_COMMIT_CLEAR;
>>> +	val |= arg->rc << CORE_COMMIT_SHIFT;
>>> +	asm volatile("msr s3_1_c15_c2_5,%0" : : "r"(val)); }
>>> +
>>> +static void etm4_config_core_commit(int cpu, int val) {
>>> +	struct etm4_enable_arg arg = {0};
>>> +
>>> +	arg.rc = val;
>>> +	smp_call_function_single(cpu, etm4_cpu_actlr1_cfg, &arg, 1);
>> Function etm4_enable/disable_hw() are already running on the CPU they are
>> supposed to so no need to call smp_call_function_single().
>>
>>> +}
>>> +
>>>  static int etm4_enable_hw(struct etmv4_drvdata *drvdata)  {
>>>  	int i, rc;
>>> +	struct amba_device *adev;
>>>  	struct etmv4_config *config = &drvdata->config;
>>>  	struct device *etm_dev = &drvdata->csdev->dev;
>>> +	struct device *dev = drvdata->csdev->dev.parent;
>>> +
>>> +	adev = container_of(dev, struct amba_device, dev);
>>> +	/*
>>> +	 * If ETM device is HiSilicon ETM device, reduce the
>>> +	 * core-commit to avoid ETM overflow.
>>> +	 */
>>> +	if (adev->periphid == HISI_ETM_AMBA_ID_V1)
>> Do you have any documentation on this back pressure feature?  I doubt this is
>> specific to Hip09 platform and as such would prefer to have a more generic
>> approach that works on any platform that supports it.
> It's not a standard Arm architecture feature, this is a model-specific register.
> Some cores may be able to throttle throughput under user control,
> but this isn't standardized. It may (as in this case) be something that you
> want to enable whenever you enable ETM - and, I guess, disable whenever
> you disable ETM. It's a bit unclean to have model-specific code in the main
> ETM driver, and names like CORE_COMMIT_CLEAR really ought to be more
> specific, but I don't see that it's more ugly than the model-specific code in
> e.g. arch/arm64/kernel/perf_event.c or its equivalent on other architectures.
Thanks for the review. 
Yes, this core commit is a specific feature to reduce commit rate and let ETM keep up
with core pipeline. Considering this, I'll change a more specific name for the macro
definition and send a new version.

Qi
> Ideally, a core that has an inherent difficulty generating ETM at full speed,
> i.e. where the ETM can't keep up with the core pipeline, would reduce
> commit rate automatically, and some already do. So if this core needs it
> to be done manually via a system register, we might allow that in the
> same way as we might allow other core-specific actions that need to be
> done to enable ETM.
>
> There are of course issues with trace overflow at all stages up to and
> including harvesting trace from buffers into perf.data (for which solutions
> might involve DVFS, trace strobing, scheduling etc.), and I am assuming
> this patch is not addressing those but dealing with a very specific concern
> about overflow within the core and its ETM.
>
> Al
>
>
>> Anyone on the CS mailing list that knows what this is about?
>>
>> Thanks,
>> Mathieu
>>
>>> +		etm4_config_core_commit(drvdata->cpu, 1);
>>>
>>>  	CS_UNLOCK(drvdata->base);
>>>
>>> @@ -472,10 +505,20 @@ static void etm4_disable_hw(void *info)  {
>>>  	u32 control;
>>>  	struct etmv4_drvdata *drvdata = info;
>>> +	struct device *dev = drvdata->csdev->dev.parent;
>>>  	struct etmv4_config *config = &drvdata->config;
>>>  	struct device *etm_dev = &drvdata->csdev->dev;
>>> +	struct amba_device *adev;
>>>  	int i;
>>>
>>> +	adev = container_of(dev, struct amba_device, dev);
>>> +	/*
>>> +	 * If ETM device is HiSilicon ETM device, resume the
>>> +	 * core-commit after ETM trace is complete.
>>> +	 */
>>> +	if (adev->periphid == HISI_ETM_AMBA_ID_V1)
>>> +		etm4_config_core_commit(drvdata->cpu, 0);
>>> +
>>>  	CS_UNLOCK(drvdata->base);
>>>
>>>  	if (!drvdata->skip_power_up) {
>>> --
>>> 2.8.1
>>>
>> _______________________________________________
>> CoreSight mailing list
>> CoreSight@lists.linaro.org
>> https://lists.linaro.org/mailman/listinfo/coresight


