Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60694C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AD93208C7
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="0XEVb2Qb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgGCPJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 11:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgGCPJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 11:09:46 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A01CC08C5DF
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 08:09:46 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id b25so2659201qto.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 08:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u+Sd7i65krcb9TCJujdS7fcqGQBerYdyz556aRVUbV8=;
        b=0XEVb2QbODuFnkFXN5z/HVN4gVHtzFqrlykBT0SJjG/N0tNjgqEoIN8DEZNccC0Pcp
         gk6lvuN0LndKWLzm98ep00R5PD00tOE63NXxprQo7tFHzRTuH8u5RgEYqIpxNvrejD0b
         zEffQ0WhymEwxqZYe13kSe7hQJsQMT16f/2YixUW/x4RuQYuqzXPBealhgH7L9BmSUSA
         QE+0dq9lLmsjkI1VjWsCGbPG2RlomsScRX5sVt7Mo5BN8nMrLwPEtJ0QnmpJiGq3tDNR
         Bw2ZokZrAqLAR9hO6C6lI8bUzQXoawLjIk3xOuk0UWzL0oqREnHtUnLdNFI2vNaWw3z1
         J2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u+Sd7i65krcb9TCJujdS7fcqGQBerYdyz556aRVUbV8=;
        b=Fjgbz/9arYexvlc5y2Tp4J7oZ1CA1oHwnlALtMshRYfweXcCBH8D8yMVavrqRUf6hK
         7uZ7VKu/awQtgglsO5cdgn1tS9q1nIfyILEPW4bixW63jMwY3YbmVf+uDSe/capk12EA
         ax94d1mg0IOgmQLTjTjS8VBANRof1qn3Ag4MMubZ4AXbbqNIObFDfkIS4RCO8WsIVeUo
         0gmnXVUH4OSOtLOTC3GEWLf/RodIxx73xvZSufSdPEi4soMEkjxPfWBlGxyPN0GEkZmu
         wcfQrZbGDzxyXEh7cyCJStXHuM/t2xdSK3snLGv5KWtRK1w1nhGjXqBlkcGMSqT+K7PC
         sbxA==
X-Gm-Message-State: AOAM531Vg9hSSJAalysu1xA8UkOS6q0PzlNG4HrspA7CuZAXDCsQ+3Zm
        38S3Q2jDY2APkEWzXIhODTSC6g==
X-Google-Smtp-Source: ABdhPJykdA5Uy1xPtqu83PEWzlTbxSuVdUPpDnePrDuyDRFaqLThEoXQ8M11YLTQdDFmo1v4r2OBqA==
X-Received: by 2002:ac8:7b57:: with SMTP id m23mr16266446qtu.379.1593788985358;
        Fri, 03 Jul 2020 08:09:45 -0700 (PDT)
Received: from [192.168.0.189] ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id 23sm10804273qkl.52.2020.07.03.08.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 08:09:44 -0700 (PDT)
Subject: Re: [RESEND PATCH v2 00/13] Enable GPU for SM8150 and SM8250
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Deepak Katragadda <dkatraga@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>, Vinod Koul <vkoul@kernel.org>
References: <20200629211725.2592-1-jonathan@marek.ca>
 <011a1f99-46bb-12f2-ee07-8cd14d891947@linaro.org>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <1887f23d-57ef-c83a-4eaf-a8f8d5024ebf@marek.ca>
Date:   Fri, 3 Jul 2020 11:08:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <011a1f99-46bb-12f2-ee07-8cd14d891947@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/20 11:03 AM, Dmitry Baryshkov wrote:
> On 30/06/2020 00:17, Jonathan Marek wrote:
>> This series adds the missing clock drivers and dts nodes to enable
>> the GPU on both SM8150 and SM8250.
>>
>> Note an extra patch [1] is still required for GPU to work on SM8250.
>>
>> Changes in V2:
>> * Added "clk: qcom: gcc: fix sm8150 GPU and NPU clocks" to fix the 
>> newly added
>>    SM8150 GPU gcc clocks
>> * Added "Fixes:" tag to "clk: qcom: clk-alpha-pll: remove 
>> unused/incorrect PLL_CAL_VAL"
>> * Added yaml schemas to gpucc dt-bindings patches
>> * Added "clk: qcom: add common gdsc_gx_do_nothing_enable for gpucc 
>> drivers" and changed
>>    gpucc patches to use it.
>> * Removed CLK_IS_CRITICAL from gpu_cc_ahb_clk
>> * Added missing rpmh regulator level for sm8250 GPU clock levels
>> * Use sm8150/sm8250 iommu compatibles in dts
>> * Add gcc_gpu_gpll0_clk_src/gcc_gpu_gpll0_div_clk_src to gpucc clocks 
>> in dts
>>
>> [1] https://gist.github.com/flto/784f1aca761ebf2fe6c105719a4a04ca
> 
> With your patches applied:
> 
> [   56.751977] msm msm: [drm:adreno_request_fw] loaded qcom/a650_sqe.fw 
> from new location
> [   56.760166] msm msm: [drm:adreno_request_fw] loaded qcom/a650_gmu.bin 
> from new location
> [   56.768485] arm-smmu 3da0000.iommu: genpd_runtime_resume()
> [   56.774196] PM: gpu_cx_gdsc: Power-on latency exceeded, new value 
> 49531 ns
> [   56.781730] arm-smmu 3da0000.iommu: resume latency exceeded, 462604 ns
> [   56.799559] platform 3d6a000.gmu: [drm:a6xx_gmu_resume] *ERROR* GMU 
> firmware initialization timed out
> [   56.809260] arm-smmu 3da0000.iommu: genpd_runtime_suspend()
> [   56.813062] msm msm: [drm:adreno_load_gpu] *ERROR* Couldn't power up 
> the GPU: -110
> 
> 

Do you have your branch published somewhere so I can see what could've 
went wrong?



