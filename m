Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F27CC33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A69206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Cuc7vtL4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgAaIAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 03:00:05 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:32710 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728027AbgAaIAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 03:00:05 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580457604; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: To:
 Subject: Sender; bh=vDYKPZDva0OYUuiv6T+bASw/nbPttMElOslv2zckmr0=; b=Cuc7vtL4o4LVYu/KjB2b0ojMSKwyVXCA/n03iSserhgG7Jq/y+C7k2qzmggkSi+q+wkpzdkP
 eaeo1rh9AtrhwSLzWsE4f1+vui91kzctL4qr4wUKI+bEUCsBzJG0+DbUQU4m7bQB5do/+rt2
 65aOKfLkf68tGDZoTKcHOwzYQHc=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e33de7f.7fa8334b3ed8-smtp-out-n01;
 Fri, 31 Jan 2020 07:59:59 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 621B3C4479C; Fri, 31 Jan 2020 07:59:59 +0000 (UTC)
Received: from [10.204.67.239] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akhilpo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 291A5C43383;
        Fri, 31 Jan 2020 07:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 291A5C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akhilpo@codeaurora.org
Subject: Re: [PATCH] drm/msm/a6xx: Correct the highestbank configuration
To:     freedreno@lists.freedesktop.org, dri-devel@freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        smasetty@codeaurora.org
References: <1579868411-20837-1-git-send-email-akhilpo@codeaurora.org>
 <20200124182654.GA17149@jcrouse1-lnx.qualcomm.com>
From:   Akhil P Oommen <akhilpo@codeaurora.org>
Message-ID: <9a9ec81d-f963-8d71-d6aa-d32956788d94@codeaurora.org>
Date:   Fri, 31 Jan 2020 13:29:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200124182654.GA17149@jcrouse1-lnx.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/2020 11:56 PM, Jordan Crouse wrote:
> On Fri, Jan 24, 2020 at 05:50:11PM +0530, Akhil P Oommen wrote:
>> Highest bank bit configuration is different for a618 gpu. Update
>> it with the correct configuration which is the reset value incidentally.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
>> Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
>> ---
>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> index daf0780..536d196 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> @@ -470,10 +470,12 @@ static int a6xx_hw_init(struct msm_gpu *gpu)
>>   	/* Select CP0 to always count cycles */
>>   	gpu_write(gpu, REG_A6XX_CP_PERFCTR_CP_SEL_0, PERF_CP_ALWAYS_COUNT);
>>   
>> -	gpu_write(gpu, REG_A6XX_RB_NC_MODE_CNTL, 2 << 1);
>> -	gpu_write(gpu, REG_A6XX_TPL1_NC_MODE_CNTL, 2 << 1);
>> -	gpu_write(gpu, REG_A6XX_SP_NC_MODE_CNTL, 2 << 1);
>> -	gpu_write(gpu, REG_A6XX_UCHE_MODE_CNTL, 2 << 21);
>> +	if (adreno_is_a630(adreno_gpu)) {
>> +		gpu_write(gpu, REG_A6XX_RB_NC_MODE_CNTL, 2 << 1);
>> +		gpu_write(gpu, REG_A6XX_TPL1_NC_MODE_CNTL, 2 << 1);
>> +		gpu_write(gpu, REG_A6XX_SP_NC_MODE_CNTL, 2 << 1);
>> +		gpu_write(gpu, REG_A6XX_UCHE_MODE_CNTL, 2 << 21);
>> +	}
> it shouldn't come as a surprise that everything in the a6xx family is going to
> have a highest bank bit setting. Even though the a618 uses the reset value, I
> think it would be less confusing to future folks if we explicitly program it:
>
> if (adreno_is_a630(adreno_dev))
>    hbb = 2;
> else
>    hbb = 0;

I think it would be better if we keep this in the adreno_info. Yes, this 
would waste a tiny bit of space for other gpu
entries in the gpulist. It is also possible to move this to a separate 
struct and keep a pointer to it in the adreno_info.
But that is something we should try when there are more a6xx specific 
configurations in future.

I have a new patch, but testing it is taking longer that I expected. I 
will share it as soon as possible.

> ....
>
> Jordan
>
Akhil

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
