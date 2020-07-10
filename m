Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54DCC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D2092065F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="k5N4r23p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgGJWgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 18:36:50 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:29444 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726476AbgGJWgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 18:36:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594420609; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To: From:
 Subject: Sender; bh=zibTUJTH6MFdxW//DfqanSRTw7aZklvYX/+cHS6yCOw=; b=k5N4r23pwKNLepli9sMvVWonT/NnnptDSe0+6tBl0xMlmUaWw8IaaTH9FNiu8qtm+HmnWDcr
 LzYStwbN1KrKdu93j+zkS38d+060zN2L7GVGRcpdhjkzpYKLcsZEgXa0jZFXdwdYO8sA7EjF
 l2aFgmRFM0cXQqOQWICHydv616Y=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f08ed80d3d6508422f97efc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 10 Jul 2020 22:36:48
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8BDA2C433A0; Fri, 10 Jul 2020 22:36:47 +0000 (UTC)
Received: from [192.168.1.9] (unknown [117.210.185.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akhilpo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B02ABC433C8;
        Fri, 10 Jul 2020 22:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B02ABC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akhilpo@codeaurora.org
Subject: Re: [PATCH v4 3/7] drm: msm: a6xx: set gpu freq through hfi
From:   Akhil P Oommen <akhilpo@codeaurora.org>
To:     Jonathan Marek <jonathan@marek.ca>, freedreno@lists.freedesktop.org
Cc:     devicetree@vger.kernel.org, saravanak@google.com,
        linux-arm-msm@vger.kernel.org, smasetty@codeaurora.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        dri-devel@freedesktop.org, viresh.kumar@linaro.org,
        sibis@codeaurora.org
References: <1594324828-9571-1-git-send-email-akhilpo@codeaurora.org>
 <1594324828-9571-4-git-send-email-akhilpo@codeaurora.org>
 <322c921f-7c8f-7052-b191-44f0dade742e@marek.ca>
 <40f6df1d-f524-c612-9215-591fd7f16e3b@codeaurora.org>
Message-ID: <d9875eae-d7e5-e091-4f3d-b279157ac1c1@codeaurora.org>
Date:   Sat, 11 Jul 2020 04:06:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <40f6df1d-f524-c612-9215-591fd7f16e3b@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/11/2020 2:43 AM, Akhil P Oommen wrote:
>
> On 7/10/2020 1:34 AM, Jonathan Marek wrote:
>> On 7/9/20 4:00 PM, Akhil P Oommen wrote:
>>> Newer targets support changing gpu frequency through HFI. So
>>> use that wherever supported instead of the legacy method.
>>>
>>
>> It was already using HFI on newer targets. Don't break it in one 
>> commit then fix it in the next.
>
> Oops. I somehow got confused. Will fix and resend.
>
> -Akhil

I broke the pm_runtime_get_if_in_use() check too. Other than that, just 
squashing this patch with the previous one should be enough.

-Akhil.

>
>>
>>> Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
>>> ---
>>>   drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 11 +++++++----
>>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c 
>>> b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>>> index 233afea..b547339 100644
>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>>> @@ -121,6 +121,12 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, 
>>> struct dev_pm_opp *opp)
>>>           if (gpu_freq == gmu->gpu_freqs[perf_index])
>>>               break;
>>>   +    if (!gmu->legacy) {
>>> +        a6xx_hfi_set_freq(gmu, gmu->current_perf_index);
>>> +        icc_set_bw(gpu->icc_path, 0, MBps_to_icc(7216));
>>> +        return;
>>> +    }
>>> +
>>>       gmu->current_perf_index = perf_index;
>>>       gmu->freq = gmu->gpu_freqs[perf_index];
>>>   @@ -893,10 +899,7 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
>>>       enable_irq(gmu->hfi_irq);
>>>         /* Set the GPU to the current freq */
>>> -    if (gmu->legacy)
>>> -        a6xx_gmu_set_initial_freq(gpu, gmu);
>>> -    else
>>> -        a6xx_hfi_set_freq(gmu, gmu->current_perf_index);
>>> +    a6xx_gmu_set_initial_freq(gpu, gmu);
>>>         /*
>>>        * "enable" the GX power domain which won't actually do 
>>> anything but it
>>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
