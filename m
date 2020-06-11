Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5D4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8AE4206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="LptNAwM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgFKOon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbgFKOom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 10:44:42 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7A1C08C5C2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 07:44:42 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w1so5778617qkw.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 07:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GuZ/2YfzuKQvhddD6bDELUgkTCvQFemnpB9NAFBuxW8=;
        b=LptNAwM2yvONwlkObU2zhW+2yYC8+7IIFrx8mbhfT/qdcEYMasK7jSCepxhRO8hHiK
         8KJj4NJw8PVYrs9OTq9KToZ4yA7Sh2QVwk5RapYF/XNAtrkYEsNqjrWGszgjw++dnEKC
         D6EGWXLBDtLCg+BpmnYZV2MKpMWU+8+fafQlHh4K/9Hh9gk7GLuZRLAG3DLf1kxlLUvB
         1bit8coUQd2+e9gvEo7ObPTPaf5DJBFR0BcIumLRR+iSCdfFevcgiZjwRXwyLiIOLmlP
         KraWtqt/9jffxCglG+CU+E/TMqLjZuiIX4WIyDFDbiRUswjLAdXDoySoX6+AWtShUe3x
         K32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GuZ/2YfzuKQvhddD6bDELUgkTCvQFemnpB9NAFBuxW8=;
        b=nBuuq1J7sKJox1OxE0i3p+C8vE0w8LWWuggMdfqK0wN7l3qfJ29VF7AUql2NmYgkD9
         jeR2sT50TXiclR4y0oqEm6jkRqYqzxJGSaU4BAoWwh5v0MIT7hpPEg6o4hXZwaiOYioR
         x25RqtnLvOYOlMBgkHxsaNZB7fT8vSDrNozwlmjbCA7W3p9A6VQAWkL2KULUOVAITIPt
         Zrh7cAgcvIh/geBWaZbuh+l8WT9zaIEdeWmVfmYXaLir0k40TGTdZKzG3pBeYvdfxqQJ
         g3EvgYLacMMPvZ+bSt0yKT61scr5kaVabjCYPDg8Qg9PHG+hzTgTn6Yc2D4pCHMnvH4j
         AZdQ==
X-Gm-Message-State: AOAM530F/9zadn2Ah32/tp17ALQ1ziTtaAaYiRC4kdoF0FtpsjBrhCVk
        Lwrbg0ruROzg0VoqxUlzngyP65C1psX7bg==
X-Google-Smtp-Source: ABdhPJwnR1GhPXpkQ5WmzTcWno1iYdLj+m7QDT4gQp+ZJG51SrStw9FWMxcWjwbfg9AkzzGkeZXVKA==
X-Received: by 2002:a37:aa81:: with SMTP id t123mr9052562qke.11.1591886681431;
        Thu, 11 Jun 2020 07:44:41 -0700 (PDT)
Received: from [192.168.0.189] ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id y16sm2625629qty.1.2020.06.11.07.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 07:44:40 -0700 (PDT)
Subject: Re: [PATCH 7/8] drm/msm/dpu: add SM8150 to hw catalog
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shubhashree Dhar <dhar@codeaurora.org>,
        Raviteja Tamatam <travitej@codeaurora.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200526032235.21930-1-jonathan@marek.ca>
 <20200526032235.21930-8-jonathan@marek.ca>
 <ce713ed0-5f11-e92f-0ef4-c87690b67090@linaro.org>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <1109ea8b-38a5-37ea-7ed8-a4ead99658e2@marek.ca>
Date:   Thu, 11 Jun 2020 10:45:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <ce713ed0-5f11-e92f-0ef4-c87690b67090@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/20 10:37 AM, Dmitry Baryshkov wrote:
> On 26/05/2020 06:22, Jonathan Marek wrote:
>> This brings up basic video mode functionality for SM8150 DPU. Command 
>> mode
>> and dual mixer/intf configurations are not working, future patches will
>> address this. Scaler functionality and multiple planes is also untested.
>>
>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>> ---
>>   .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 147 ++++++++++++++++++
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h   |   2 +
>>   2 files changed, 149 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c 
>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>> index 1e64fa08c219..f99622870676 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>> @@ -90,6 +90,23 @@ static const struct dpu_caps sc7180_dpu_caps = {
>>       .pixel_ram_size = DEFAULT_PIXEL_RAM_SIZE,
>>   };
>> +static const struct dpu_caps sm8150_dpu_caps = {
>> +    .max_mixer_width = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
>> +    .max_mixer_blendstages = 0xb,
>> +    .max_linewidth = 4096,
>> +    .qseed_type = DPU_SSPP_SCALER_QSEED3,
>> +    .smart_dma_rev = DPU_SSPP_SMART_DMA_V2_5,
> 
> It seems you missed sending a patch adding support for 
> DPU_SSPP_SMART_DMA_V2_5. Could you please point to it?
> 
> 

There are no other changes related to that, the driver never checks 
smart_dma_rev and the correct version number is only set for when the 
driver supports it (if ever).
