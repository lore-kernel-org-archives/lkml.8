Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5AAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 11:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5B0C20674
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 11:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="cNaVziwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgGCLYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 07:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgGCLYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 07:24:30 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4891CC08C5DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 04:24:30 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c11so18241382lfh.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 04:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oitMqipLEPO2Yj5xL/dlzZEeDLyWSmeeByxlVNYyd1g=;
        b=cNaVziwXP/FXl51uLD6P9SDqfM10xutFUrENHOk8xP7BmYZk+IWUPzeVhnaZQf9gvc
         vxjGSLQIWpuBQfzo3o5bSoGUxFVJoZJ+ddZCWpOZTdGDg4ZTM6iHWWpMIycrEdxDjLOA
         vmG5JZBPh8P6Kz+iwAHXiP4l9H8Z+T1SQpQa1c/s5/RCne8EgFXmQLHsH2L2jNGdkCz/
         CX59J9EmjTO1g7YeQqxM/A0p57k3gU5y0rpUgm+GyfXUFvWU+HQJ6C7AvsG1olSZ5Wf2
         RAH10ZnURTCqLtuTWy+hNEYQhv56R45INNiRlKhkTKPC2FJSuXDDeCOnYALAyOYuJ8NM
         9Flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oitMqipLEPO2Yj5xL/dlzZEeDLyWSmeeByxlVNYyd1g=;
        b=X/XGMdGN9odnQqCOHYClPPQhDnvY/H3wlD2uOo0i6hAmLtMjh/k1Nu5Y5hHVmJj3q3
         Z35uLWHASsOwOjqYRcgmJ0udh/TW1BXXFLR2B2eqBcDjBqFDB6ta+QmERGNNiol7wPqE
         DIOp3EJ2BbnYqn//qj6wsdWLLTp1PKkD+TytqM64An2QBMdYjHjf+ucx92lV92FYur0w
         e+d0Nhb0efIkfLxEyHDqXzVMhjs1M63eBYHhJWqd2xPekkA8AhJ9KT4TCniEO3ydOkhs
         aOurVn2WflxIsOTmYhHEyaJLtwRWzZD7kGWy83IKzVZDh7cwSDmdo1mv48Xv6t6naFwZ
         QENw==
X-Gm-Message-State: AOAM531ujbs5ekmEocEvfxZdRUjl/59UTsIPRtH4wNRJEgtMtFJjW6Bo
        8E8ma8s16WRvQi2wNbU9YitMsg==
X-Google-Smtp-Source: ABdhPJwSnB2E+9qDy3UvGZ3TOCAmeByNzVFr4FH7BTY3Q5sjfcRDicXgAigg7pUSQRkrPg0kxImDPQ==
X-Received: by 2002:ac2:5e29:: with SMTP id o9mr20757726lfg.196.1593775468529;
        Fri, 03 Jul 2020 04:24:28 -0700 (PDT)
Received: from [192.168.1.9] ([83.68.95.66])
        by smtp.googlemail.com with ESMTPSA id g7sm4539921lfe.62.2020.07.03.04.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 04:24:27 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] iommu/arm-smmu: Workaround for Marvell
 Armada-AP806 SoC erratum #582743
To:     Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        joro@8bytes.org, gregory.clement@bootlin.com, robh+dt@kernel.org,
        hannah@marvell.com
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, catalin.marinas@arm.com,
        nadavh@marvell.com, linux-arm-kernel@lists.infradead.org,
        mw@semihalf.com
References: <20200702201633.22693-1-tn@semihalf.com>
 <20200702201633.22693-3-tn@semihalf.com>
 <f8c3fea9-2bd7-e776-447e-54886cd61568@arm.com>
From:   Tomasz Nowicki <tn@semihalf.com>
Message-ID: <8fb0f73f-35ca-d8ec-43b8-ae89e9a21d0c@semihalf.com>
Date:   Fri, 3 Jul 2020 13:24:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <f8c3fea9-2bd7-e776-447e-54886cd61568@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03.07.2020 11:03, Robin Murphy wrote:
> On 2020-07-02 21:16, Tomasz Nowicki wrote:
>> From: Hanna Hawa <hannah@marvell.com>
>>
>> Due to erratum #582743, the Marvell Armada-AP806 can't access 64bit to
>> ARM SMMUv2 registers.
>>
>> Provide implementation relevant hooks:
>> - split the writeq/readq to two accesses of writel/readl.
>> - mask the MMU_IDR2.PTFSv8 fields to not use AArch64 format (but
>> only AARCH32_L) since with AArch64 format 32 bits access is not 
>> supported.
>>
>> Note that separate writes/reads to 2 is not problem regards to
>> atomicity, because the driver use the readq/writeq while initialize
>> the SMMU, report for SMMU fault, and use spinlock in one
>> case (iova_to_phys).
> 
> The comment about the spinlock seems to be out of date, and TBH that 
> whole sentence is a bit unclear - how about something like:
> 
> "Note that most 64-bit registers like TTBRn can be accessed as two 
> 32-bit halves without issue, and AArch32 format ensures that the 
> register writes which must be atomic (for TLBI etc.) need only be 32-bit."
> 
>> Signed-off-by: Hanna Hawa <hannah@marvell.com>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> ---
>>   Documentation/arm64/silicon-errata.rst |  3 ++
>>   drivers/iommu/arm-smmu-impl.c          | 52 ++++++++++++++++++++++++++
>>   2 files changed, 55 insertions(+)
>>
>> diff --git a/Documentation/arm64/silicon-errata.rst 
>> b/Documentation/arm64/silicon-errata.rst
>> index 936cf2a59ca4..157214d3abe1 100644
>> --- a/Documentation/arm64/silicon-errata.rst
>> +++ b/Documentation/arm64/silicon-errata.rst
>> @@ -125,6 +125,9 @@ stable kernels.
>>   | Cavium         | ThunderX2 Core  | #219            | 
>> CAVIUM_TX2_ERRATUM_219      |
>>   
>> +----------------+-----------------+-----------------+-----------------------------+ 
>>
>>   
>> +----------------+-----------------+-----------------+-----------------------------+ 
>>
>> +| Marvell        | ARM-MMU-500     | #582743         | 
>> N/A                         |
>> ++----------------+-----------------+-----------------+-----------------------------+ 
>>
>> ++----------------+-----------------+-----------------+-----------------------------+ 
>>
>>   | Freescale/NXP  | LS2080A/LS1043A | A-008585        | 
>> FSL_ERRATUM_A008585         |
>>   
>> +----------------+-----------------+-----------------+-----------------------------+ 
>>
>>   
>> +----------------+-----------------+-----------------+-----------------------------+ 
>>
>> diff --git a/drivers/iommu/arm-smmu-impl.c 
>> b/drivers/iommu/arm-smmu-impl.c
>> index c75b9d957b70..c1fc5e1b8193 100644
>> --- a/drivers/iommu/arm-smmu-impl.c
>> +++ b/drivers/iommu/arm-smmu-impl.c
>> @@ -147,6 +147,53 @@ static const struct arm_smmu_impl arm_mmu500_impl 
>> = {
>>       .reset = arm_mmu500_reset,
>>   };
>> +static u64 mrvl_mmu500_readq(struct arm_smmu_device *smmu, int page, 
>> int off)
>> +{
>> +    u64 val;
>> +
>> +    /*
>> +     * Marvell Armada-AP806 erratum #582743.
>> +     * Split all the readq to double readl
>> +     */
>> +    val = (u64)readl_relaxed(arm_smmu_page(smmu, page) + off + 4) << 32;
>> +    val |= readl_relaxed(arm_smmu_page(smmu, page) + off);
> 
> Even though io-64-nonatomic-hi-lo.h doesn't override readq() etc. for 
> 64-bit builds, you can still use hi_lo_readq_relaxed() directly.
> 
>> +
>> +    return val;
>> +}
>> +
>> +static void mrvl_mmu500_writeq(struct arm_smmu_device *smmu, int 
>> page, int off,
>> +                   u64 val)
>> +{
>> +    /*
>> +     * Marvell Armada-AP806 erratum #582743.
>> +     * Split all the writeq to double writel
>> +     */
>> +    writel_relaxed(upper_32_bits(val), arm_smmu_page(smmu, page) + 
>> off + 4);
>> +    writel_relaxed(lower_32_bits(val), arm_smmu_page(smmu, page) + off);
> 
> Similarly, hi_lo_writeq_relaxed().
> 
>> +}
>> +
>> +static u32 mrvl_mmu500_cfg_id2_fixup(u32 id)
>> +{
>> +
>> +    /*
>> +     * Armada-AP806 erratum #582743.
>> +     * Hide the SMMU_IDR2.PTFSv8 fields to sidestep the AArch64
>> +     * formats altogether and allow using 32 bits access on the
>> +     * interconnect.
>> +     */
>> +    id &= ~(ARM_SMMU_ID2_PTFS_4K | ARM_SMMU_ID2_PTFS_16K |
>> +        ARM_SMMU_ID2_PTFS_64K);
>> +
>> +    return id;
>> +}
>> +
>> +static const struct arm_smmu_impl mrvl_mmu500_impl = {
>> +    .read_reg64 = mrvl_mmu500_readq,
>> +    .write_reg64 = mrvl_mmu500_writeq,
>> +    .cfg_id2_fixup = mrvl_mmu500_cfg_id2_fixup,
>> +    .reset = arm_mmu500_reset,
>> +};
>> +
>>   struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device 
>> *smmu)
>>   {
>> @@ -160,6 +207,11 @@ struct arm_smmu_device *arm_smmu_impl_init(struct 
>> arm_smmu_device *smmu)
>>        */
>>       switch (smmu->model) {
>>       case ARM_MMU500:
>> +        if (of_device_is_compatible(smmu->dev->of_node,
> 
> Nit: there's a local "np" variable now.
> 
>> +                        "marvell,ap806-smmu-500")) {
>> +            smmu->impl = &mrvl_mmu500_impl;
>> +            return smmu;
>> +        }
> 
> Please put this with the other integration checks below the switch 
> statement. Yes, it means we'll end up assigning smmu->impl twice for 
> this particular case, but that's the intended pattern.
> 

Thanks, all above comments do make sense and will be fixed in next spin.

Thanks,
Tomasz
