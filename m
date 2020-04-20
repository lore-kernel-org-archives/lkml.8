Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315BAC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 127A32074F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ZtdkXgGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbgDTQ1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:27:53 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:49576 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728879AbgDTQ1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:27:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587400069; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=JmEUkT/HF+RFoziT0BX0UCsQ/PoZeQDMFSY5vkJTons=;
 b=ZtdkXgGUs9YiCzeAD/P4w/1/PabkApNwtgjTkKn+2s1u9uSkecVvrcZ5XzVBYOV1m3PEJDj2
 XoAoN9SJ0xUGnGznIR4vGdExhk7fZkyhiYOeVq6hbDeSfB7IHQ7Kof+kPTac0hbkp8suPpwc
 4dJYsIynLa864ld54pZclLyGm9E=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9dcd84.7f3eee842c70-smtp-out-n01;
 Mon, 20 Apr 2020 16:27:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 25E72C4478F; Mon, 20 Apr 2020 16:27:47 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 50479C433CB;
        Mon, 20 Apr 2020 16:27:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 20 Apr 2020 21:57:46 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        iommu@lists.linux-foundation.org,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv2 3/6] iommu/arm-smmu: Implement
 iommu_ops->def_domain_type call-back
In-Reply-To: <6dd26176-448a-985c-90fc-7c47088015ff@arm.com>
References: <cover.1587392905.git.saiprakash.ranjan@codeaurora.org>
 <558b1aee4c699a0a5b14b325178d22a79958488f.1587392905.git.saiprakash.ranjan@codeaurora.org>
 <6dd26176-448a-985c-90fc-7c47088015ff@arm.com>
Message-ID: <10cac2a08ae90afc88cbadff53a41ec5@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 2020-04-20 20:56, Robin Murphy wrote:
> On 2020-04-20 3:37 pm, Sai Prakash Ranjan wrote:
>> Implement the new def_domain_type call-back for the ARM
>> SMMU driver. We need this to support requesting the domain
>> type by the client devices.
>> 
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> ---
>>   drivers/iommu/arm-smmu.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>> 
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index e622f4e33379..b5d1d52dfbb8 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -1609,6 +1609,25 @@ static void arm_smmu_get_resv_regions(struct 
>> device *dev,
>>   	iommu_dma_get_resv_regions(dev, head);
>>   }
>>   +static int arm_smmu_def_domain_type(struct device *dev)
>> +{
>> +	struct iommu_fwspec *fwspec;
>> +	struct arm_smmu_device *smmu;
>> +
>> +	fwspec = dev_iommu_fwspec_get(dev);
>> +	if (!fwspec || fwspec->ops != &arm_smmu_ops)
>> +		return -ENODEV;
>> +
>> +	smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
>> +	if (!smmu)
>> +		return -ENODEV;
>> +
> 
> AFAICS this should only ever be called for a device in a group, which
> means an initial ->probe_device has succeeded and rather than
> defensively going the long way round, we can safely assume this:
> 
> 	struct arm_smmu_master_cfg = dev_iommu_priv_get(dev);
> 	struct arm_smmu_impl *impl = cfg->smmu->impl;
> 
> 	if (impl && impl->req_domain)
> 		return impl->req_domain(dev);
> 

Yes you are right, will use this.

Thanks,
Sai
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
