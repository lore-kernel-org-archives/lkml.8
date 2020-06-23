Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D796AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B337C206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732416AbgFWLaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 07:30:30 -0400
Received: from foss.arm.com ([217.140.110.172]:58868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732191AbgFWLaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:30:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 477CD1F1;
        Tue, 23 Jun 2020 04:30:20 -0700 (PDT)
Received: from [10.57.9.128] (unknown [10.57.9.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB48E3F6CF;
        Tue, 23 Jun 2020 04:30:17 -0700 (PDT)
Subject: Re: [PATCH v6 3/4] iommu/arm-smmu: Add global/context fault
 implementation hooks
To:     Thierry Reding <thierry.reding@gmail.com>,
        Krishna Reddy <vdumpa@nvidia.com>
Cc:     snikam@nvidia.com, mperttunen@nvidia.com, bhuntsman@nvidia.com,
        will@kernel.org, joro@8bytes.org, linux-kernel@vger.kernel.org,
        praithatha@nvidia.com, talho@nvidia.com,
        iommu@lists.linux-foundation.org, nicolinc@nvidia.com,
        linux-tegra@vger.kernel.org, yhsu@nvidia.com, treding@nvidia.com,
        linux-arm-kernel@lists.infradead.org, bbiswas@nvidia.com
References: <20200604234414.21912-1-vdumpa@nvidia.com>
 <20200604234414.21912-4-vdumpa@nvidia.com> <20200623083643.GB4098287@ulmo>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2dda4530-39cc-d549-1124-26337dd9afbe@arm.com>
Date:   Tue, 23 Jun 2020 12:30:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623083643.GB4098287@ulmo>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-23 09:36, Thierry Reding wrote:
[...]
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 243bc4cb2705b..d720e1e191176 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -673,6 +673,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>>   	enum io_pgtable_fmt fmt;
>>   	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>   	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>> +	irqreturn_t (*context_fault)(int irq, void *dev);
>>   
>>   	mutex_lock(&smmu_domain->init_mutex);
>>   	if (smmu_domain->smmu)
>> @@ -835,7 +836,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>>   	 * handler seeing a half-initialised domain state.
>>   	 */
>>   	irq = smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
>> -	ret = devm_request_irq(smmu->dev, irq, arm_smmu_context_fault,
>> +	context_fault = (smmu->impl && smmu->impl->context_fault) ?
>> +			 smmu->impl->context_fault : arm_smmu_context_fault;
> 
> A simpler way might have been to assign arm_smmu_context_fault to all
> implementations. That way we wouldn't have to perform this check here
> and instead just always using smmu->impl->context_fault.

But smmu->impl can still be NULL...

Everything in impl, including the presence of impl itself, is optional, 
so the notion of overriding a default with the same default doesn't 
really make much sense, and would go against the pattern everywhere else.

Robin.

>> +	ret = devm_request_irq(smmu->dev, irq, context_fault,
>>   			       IRQF_SHARED, "arm-smmu-context-fault", domain);
>>   	if (ret < 0) {
>>   		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
>> @@ -2107,6 +2110,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>   	struct arm_smmu_device *smmu;
>>   	struct device *dev = &pdev->dev;
>>   	int num_irqs, i, err;
>> +	irqreturn_t (*global_fault)(int irq, void *dev);
>>   
>>   	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
>>   	if (!smmu) {
>> @@ -2193,9 +2197,12 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>   		smmu->num_context_irqs = smmu->num_context_banks;
>>   	}
>>   
>> +	global_fault = (smmu->impl && smmu->impl->global_fault) ?
>> +			smmu->impl->global_fault : arm_smmu_global_fault;
>> +
> 
> Same as above.
> 
> Thierry
> 
