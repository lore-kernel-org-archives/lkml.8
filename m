Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D6EC4724C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 863DD2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="VCBJi/zF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgEGMHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 08:07:06 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:52038 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725914AbgEGMHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:07:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588853225; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=CsTjSpDacRW1HUymiU2kvvRQCndHnkINhBw2dj0kpdw=;
 b=VCBJi/zFghQbr2Qt7aEbfgI7wDlvDsgh1nPtxN8Y+Q5up87HP98VrNa7dPyEpDg241JKcMPf
 Z5VmhkbfPj9TBrovOtMcYjNjrRkdPcNrXDQ3NhKvIhN1+3iSAJtUtw2R1rTSaTtfC2SFaMi/
 em92jHYtW+IuqHOTABZR9NK1F3Y=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb3f9d2.7efd1eecbce0-smtp-out-n02;
 Thu, 07 May 2020 12:06:42 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AB34DC44799; Thu,  7 May 2020 12:06:42 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 88106C4478F;
        Thu,  7 May 2020 12:06:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 07 May 2020 17:36:41 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Robin Murphy <robin.murphy@arm.com>,
        Rob Clark <robdclark@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] iomm/arm-smmu: Add stall implementation hook
In-Reply-To: <1ced023b-157c-21a0-ac75-1adef7f029f0@arm.com>
References: <20200421202004.11686-1-saiprakash.ranjan@codeaurora.org>
 <b491e02ad790a437115fdeab6b21bc48@codeaurora.org>
 <1ced023b-157c-21a0-ac75-1adef7f029f0@arm.com>
Message-ID: <fad5dc096a2bd9404341ba8738ba8fc9@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 2020-05-07 16:25, Robin Murphy wrote:
> On 2020-05-07 11:14 am, Sai Prakash Ranjan wrote:
>> Hi Will, Robin
>> 
>> On 2020-04-22 01:50, Sai Prakash Ranjan wrote:
>>> Add stall implementation hook to enable stalling
>>> faults on QCOM platforms which supports it without
>>> causing any kind of hardware mishaps. Without this
>>> on QCOM platforms, GPU faults can cause unrelated
>>> GPU memory accesses to return zeroes. This has the
>>> unfortunate result of command-stream reads from CP
>>> getting invalid data, causing a cascade of fail.
> 
> I think this came up before, but something about this rationale
> doesn't add up - we're not *using* stalls at all, we're still
> terminating faulting transactions unconditionally; we're just using
> CFCFG to terminate them with a slight delay, rather than immediately.
> It's really not clear how or why that makes a difference. Is it a GPU
> bug? Or an SMMU bug? Is this reliable (or even a documented workaround
> for something), or might things start blowing up again if any other
> behaviour subtly changes? I'm not dead set against adding this, but
> I'd *really* like to have a lot more confidence in it.
> 

Yes it has come up before, you can find details in below links.
  - https://patchwork.kernel.org/patch/9953803/
  - https://patchwork.kernel.org/patch/10618713/

Rob Clark can add more details on this probably for the GPU faults.
As for the reliability, downstream kernel(I mean kernels with which 
android
devices with QCOM chipsets are shipped) has stalling enabled for a long 
time
now and has been stable in the field. So we can say that we are safe 
with
this enabled in QCOM implementation.

>>> Suggested-by: Rob Clark <robdclark@gmail.com>
>>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>>> ---
>>> This has been attempted previously by Rob Clark in 2017, 2018.
>>> Hopefully we can get something concluded in 2020.
>>>  * https://patchwork.kernel.org/patch/9953803/
>>>  * https://patchwork.kernel.org/patch/10618713/
>>> ---
>>>  drivers/iommu/arm-smmu-qcom.c | 1 +
>>>  drivers/iommu/arm-smmu.c      | 7 +++++++
>>>  drivers/iommu/arm-smmu.h      | 1 +
>>>  3 files changed, 9 insertions(+)
>>> 
>>> diff --git a/drivers/iommu/arm-smmu-qcom.c 
>>> b/drivers/iommu/arm-smmu-qcom.c
>>> index 24c071c1d8b0..a13b229389d4 100644
>>> --- a/drivers/iommu/arm-smmu-qcom.c
>>> +++ b/drivers/iommu/arm-smmu-qcom.c
>>> @@ -32,6 +32,7 @@ static int qcom_sdm845_smmu500_reset(struct
>>> arm_smmu_device *smmu)
>>> 
>>>  static const struct arm_smmu_impl qcom_smmu_impl = {
>>>      .reset = qcom_sdm845_smmu500_reset,
>>> +    .stall = true,
>>>  };
>>> 
>>>  struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device 
>>> *smmu)
>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>> index e622f4e33379..16b03fca9966 100644
>>> --- a/drivers/iommu/arm-smmu.c
>>> +++ b/drivers/iommu/arm-smmu.c
>>> @@ -488,6 +488,11 @@ static irqreturn_t arm_smmu_context_fault(int
>>> irq, void *dev)
>>>                  fsr, iova, fsynr, cbfrsynra, idx);
>>> 
>>>      arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
>>> +
>>> +    if (smmu->impl && smmu->impl->stall && (fsr & ARM_SMMU_FSR_SS))
>>> +        arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_RESUME,
>>> +                  ARM_SMMU_RESUME_TERMINATE);
> 
> Shouldn't this be *before* the write to FSR, in case the outstanding
> fault causes that to be immediately reasserted before we write
> CB_RESUME and we end up immediately taking the IRQ a second time?
> 

Yes, I will fixup this in the next version.

> (The overall enablement being in impl is sound, but you still don't
> get to play "works on my machine" in the architectural code :P)
> 

We could have our own context fault handler in QCOM implementation,
but that would just be duplicating things from arm-smmu context fault
handler. So I did not think it makes much sense to have our own
fault handler in qcom impl just for enabling stall model.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
