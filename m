Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F190C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 783B0206BE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ITdUT3mq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgGCOxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 10:53:12 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:60331 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgGCOxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 10:53:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593787991; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=qnO8dgt8kPgCd7OkCwm5OGmXgYl4ROSS5lJBIbWqa6I=;
 b=ITdUT3mqTJcjd1G2V9lGPUYw2Dl5mwrdCCsTJISx0DA+XxgYH0mSt4NaLCcW+hppv3lRKXcH
 xoDW8j3HAIG7FuQY24LVYzmgvixBsJvCVWJaZzk5BzR9eISpkejAwNr1NAOV0RfcYjzh8eq/
 7uQhKSBvqcHf8RYaeVih95y0fO4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5eff4656c76a4e7a2a430098 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 03 Jul 2020 14:53:10
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8C3E0C433AD; Fri,  3 Jul 2020 14:53:08 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 99A3BC433C8;
        Fri,  3 Jul 2020 14:53:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 03 Jul 2020 20:23:07 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Paul <sean@poorly.run>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Emil Velikov <emil.velikov@collabora.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        "Kristian H . Kristensen" <hoegsberg@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCHv3 7/7] drm/msm/a6xx: Add support for using system
 cache(LLC)
In-Reply-To: <20200703133732.GD18953@willie-the-truck>
References: <cover.1593344119.git.saiprakash.ranjan@codeaurora.org>
 <449a6544b10f0035d191ac52283198343187c153.1593344120.git.saiprakash.ranjan@codeaurora.org>
 <20200703133732.GD18953@willie-the-truck>
Message-ID: <ecfda7ca80f6d7b4ff3d89b8758f4dc9@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2020-07-03 19:07, Will Deacon wrote:
> On Mon, Jun 29, 2020 at 09:22:50PM +0530, Sai Prakash Ranjan wrote:
>> diff --git a/drivers/gpu/drm/msm/msm_iommu.c 
>> b/drivers/gpu/drm/msm/msm_iommu.c
>> index f455c597f76d..bd1d58229cc2 100644
>> --- a/drivers/gpu/drm/msm/msm_iommu.c
>> +++ b/drivers/gpu/drm/msm/msm_iommu.c
>> @@ -218,6 +218,9 @@ static int msm_iommu_map(struct msm_mmu *mmu, 
>> uint64_t iova,
>>  		iova |= GENMASK_ULL(63, 49);
>> 
>> 
>> +	if (mmu->features & MMU_FEATURE_USE_SYSTEM_CACHE)
>> +		prot |= IOMMU_SYS_CACHE_ONLY;
> 
> Given that I think this is the only user of IOMMU_SYS_CACHE_ONLY, then 
> it
> looks like it should actually be a property on the domain because we 
> never
> need to configure it on a per-mapping basis within a domain, and 
> therefore
> it shouldn't be exposed by the IOMMU API as a prot flag.
> 
> Do you agree?
> 

GPU being the only user is for now, but there are other clients which 
can use this.
Plus how do we set the memory attributes if we do not expose this as 
prot flag?

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
