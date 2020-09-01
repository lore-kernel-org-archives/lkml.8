Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4821CC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 01:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A268208DB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 01:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgIAB5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 21:57:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10740 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725941AbgIAB5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 21:57:46 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DFD122C053DCDD80DE61;
        Tue,  1 Sep 2020 09:57:43 +0800 (CST)
Received: from [127.0.0.1] (10.65.95.32) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Tue, 1 Sep 2020
 09:57:33 +0800
Subject: Re: [RFC PATCH v2] coresight: etm4x: Modify core-commit of cpu to
 avoid the overflow of HiSilicon ETM
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
References: <1597824397-29894-1-git-send-email-liuqi115@huawei.com>
 <20200831221308.GB207013@xps15>
CC:     <gregkh@linuxfoundation.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
From:   Qi Liu <liuqi115@huawei.com>
Message-ID: <fae22c97-489b-0312-4357-973a4969780c@huawei.com>
Date:   Tue, 1 Sep 2020 09:57:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200831221308.GB207013@xps15>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.95.32]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

Thanks for your review.

On 2020/9/1 6:13, Mathieu Poirier wrote:
> Following Al's comment I have the following recommendations...
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
>>  drivers/hwtracing/coresight/coresight-etm4x.c | 43 +++++++++++++++++++++++++++
>>  1 file changed, 43 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
>> index 7797a57..7641f89 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
>> @@ -43,6 +43,10 @@ MODULE_PARM_DESC(boot_enable, "Enable tracing on boot");
>>  #define PARAM_PM_SAVE_NEVER	  1 /* never save any state */
>>  #define PARAM_PM_SAVE_SELF_HOSTED 2 /* save self-hosted state only */
>>
>> +#define CORE_COMMIT_CLEAR	0x3000
>> +#define CORE_COMMIT_SHIFT	12
>> +#define HISI_ETM_AMBA_ID_V1	0x000b6d01
> Do you have a name for the SoC that can be added so that other HiSilicon SoC can
> be added?  I suggest something like:
>
> #define HISI_NAME_CORE_COMMIT_CLEAR
> #define HISI_NAME_CORE_COMMIT_SHIFT
> #define HISI_NAME_ETM_ID
Will fix this next version.
> Moreover I don't see an entry for 0x000b6d01 in the amba id table - is your
> devices upstream?  Needless to day that is mandatory in order to move forward
> with this work.
A patch has been applied to add this ETM id and here is the link:
https://lore.kernel.org/linux-arm-kernel/20200813210000.GO3393195@xps15/

>> +
>>  static int pm_save_enable = PARAM_PM_SAVE_FIRMWARE;
>>  module_param(pm_save_enable, int, 0444);
>>  MODULE_PARM_DESC(pm_save_enable,
>> @@ -104,11 +108,40 @@ struct etm4_enable_arg {
>>  	int rc;
>>  };
>>
>> +static void etm4_cpu_actlr1_cfg(void *info)
>> +{
>> +	struct etm4_enable_arg *arg = (struct etm4_enable_arg *)info;
>> +	u64 val;
>> +
>> +	asm volatile("mrs %0,s3_1_c15_c2_5" : "=r"(val));
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
>> +}
>> +
>>  static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>>  {
>>  	int i, rc;
>> +	struct amba_device *adev;
>>  	struct etmv4_config *config = &drvdata->config;
>>  	struct device *etm_dev = &drvdata->csdev->dev;
>> +	struct device *dev = drvdata->csdev->dev.parent;
>> +
>> +	adev = container_of(dev, struct amba_device, dev);
>> +	/*
>> +	 * If ETM device is HiSilicon ETM device, reduce the
>> +	 * core-commit to avoid ETM overflow.
>> +	 */
>> +	if (adev->periphid == HISI_ETM_AMBA_ID_V1)
>> +		etm4_config_core_commit(drvdata->cpu, 1);
> I susggest to add a function like etm4_enable_arch_specific() and do the above
> in there.  The same goes for the disable path.
>
> Thanks,
> Mathieu
Thanks, I'll fix this next version : )

Qi
>
>>  	CS_UNLOCK(drvdata->base);
>>
>> @@ -472,10 +505,20 @@ static void etm4_disable_hw(void *info)
>>  {
>>  	u32 control;
>>  	struct etmv4_drvdata *drvdata = info;
>> +	struct device *dev = drvdata->csdev->dev.parent;
>>  	struct etmv4_config *config = &drvdata->config;
>>  	struct device *etm_dev = &drvdata->csdev->dev;
>> +	struct amba_device *adev;
>>  	int i;
>>
>> +	adev = container_of(dev, struct amba_device, dev);
>> +	/*
>> +	 * If ETM device is HiSilicon ETM device, resume the
>> +	 * core-commit after ETM trace is complete.
>> +	 */
>> +	if (adev->periphid == HISI_ETM_AMBA_ID_V1)
>> +		etm4_config_core_commit(drvdata->cpu, 0);
>> +
>>  	CS_UNLOCK(drvdata->base);
>>
>>  	if (!drvdata->skip_power_up) {
>> --
>> 2.8.1
>>
> .
>


