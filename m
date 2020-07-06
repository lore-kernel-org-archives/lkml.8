Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=BITCOIN_SPAM_02,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BTC_ID,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E90AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B232073E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O2Ha9wry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgGFK3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 06:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728738AbgGFK27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 06:28:59 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641BAC061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 03:28:59 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id d17so29916742ljl.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 03:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LKBuUSuomSjDtZHM38O9ZHigU60CDlkdg9XkwZXYuvE=;
        b=O2Ha9wryghDYkFNeIoXJ9bQEYdxrLzq7a/342POXPWkB1YHg7jDwzuJkD9kfwNTqiC
         xvMcW6QbW8rdYwAohXO//TlSOnKBHd735jQObQbXmusUzjBFl8EkRInfVvcbrHiKcmcA
         PHoo4FYK5OWsJuJ1Re5aKMqbYkDh+3cMALh4ssEX5THkLXdzf1pKKyfm0ZKbyep7SWHj
         TWCh8lPwTnv1KDOsLqXkkgIos7qoXTKUDwW6wRrPNMOhGpjJE1gyy7TSUlDD397+K17s
         sFcL4eYH6LN0A3otZwxJXmOR2+zuFKGRCHhLxe5dkfu2hBUQ0KkfHYXn41haCjYTpmr6
         wVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LKBuUSuomSjDtZHM38O9ZHigU60CDlkdg9XkwZXYuvE=;
        b=oE4P0iBXWCw6RDGNovZS7O8L6xfYmwcBTvvEABrLpRTK2GgWN0u33IClzzlGkOlZDD
         94LqHmwSvW1ZWvh6AJod7gHDb/2lxu9r/GHzvh8275gWCWiI48ghIcmcvdQGKujRbqya
         qccRBpBi0qWHl3AtOCB0x44n4J/URoU8xY89wvyOQSvSFYJmhlmV+54fSveRFwKuodFo
         XTDPI0K82G6QD1oNVfPGgv4CVF3Xa6uXkBSOFWm14l6oi0sp9geUvbuupOxQqnG28vn8
         jqOhHEQaDZ8oAkA7pBQbqSk+dcJeQRGXWnsRAYtTrsnUi7R+jC/5jMVXBulbH9v39ycZ
         WLcQ==
X-Gm-Message-State: AOAM532sjVitM81Aa17c0kLUT1QyvQjfR4h9nDLysuGiFN3EqAHvm1qr
        GMBktuXNNXFrw8Zt0w/meE5+eQ==
X-Google-Smtp-Source: ABdhPJxYJqtOitJYEzxZXEq2ze9IEkc4AcADgLXy0+/Ww+Ad0GszgvKUjl+SgJfc38f7zOlBHxzeUg==
X-Received: by 2002:a2e:b4ec:: with SMTP id s12mr27683463ljm.155.1594031336962;
        Mon, 06 Jul 2020 03:28:56 -0700 (PDT)
Received: from [10.0.0.11] ([188.162.65.153])
        by smtp.gmail.com with ESMTPSA id f9sm10204654ljf.27.2020.07.06.03.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 03:28:56 -0700 (PDT)
Subject: Re: [RESEND PATCH v2 00/13] Enable GPU for SM8150 and SM8250
To:     Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org
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
 <1887f23d-57ef-c83a-4eaf-a8f8d5024ebf@marek.ca>
 <a82bd8ed-fc8f-ea94-7687-cdc17190900a@linaro.org>
 <04900059-6af8-1b48-33f9-7b8426a55fd0@linaro.org>
 <0ad7638f-7310-f84e-0ce9-a2f1d1d64079@marek.ca>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <afac986b-833b-cd84-e888-914da80071a7@linaro.org>
Date:   Mon, 6 Jul 2020 13:28:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <0ad7638f-7310-f84e-0ce9-a2f1d1d64079@marek.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/07/2020 00:08, Jonathan Marek wrote:
> On 7/3/20 1:29 PM, Dmitry Baryshkov wrote:
>> On 03/07/2020 18:14, Dmitry Baryshkov wrote:
>>> On 03/07/2020 18:08, Jonathan Marek wrote:
>>>> On 7/3/20 11:03 AM, Dmitry Baryshkov wrote:
>>>>> On 30/06/2020 00:17, Jonathan Marek wrote:
>>>>>> This series adds the missing clock drivers and dts nodes to enable
>>>>>> the GPU on both SM8150 and SM8250.
>>>>>>
>>>>>> Note an extra patch [1] is still required for GPU to work on SM8250.
>>>>>>
>>>>>> Changes in V2:
>>>>>> * Added "clk: qcom: gcc: fix sm8150 GPU and NPU clocks" to fix the 
>>>>>> newly added
>>>>>>    SM8150 GPU gcc clocks
>>>>>> * Added "Fixes:" tag to "clk: qcom: clk-alpha-pll: remove 
>>>>>> unused/incorrect PLL_CAL_VAL"
>>>>>> * Added yaml schemas to gpucc dt-bindings patches
>>>>>> * Added "clk: qcom: add common gdsc_gx_do_nothing_enable for gpucc 
>>>>>> drivers" and changed
>>>>>>    gpucc patches to use it.
>>>>>> * Removed CLK_IS_CRITICAL from gpu_cc_ahb_clk
>>>>>> * Added missing rpmh regulator level for sm8250 GPU clock levels
>>>>>> * Use sm8150/sm8250 iommu compatibles in dts
>>>>>> * Add gcc_gpu_gpll0_clk_src/gcc_gpu_gpll0_div_clk_src to gpucc 
>>>>>> clocks in dts
>>>>>>
>>>>>> [1] https://gist.github.com/flto/784f1aca761ebf2fe6c105719a4a04ca
>>>>>
>>>>> With your patches applied:
>>>>>
>>>>> [   56.751977] msm msm: [drm:adreno_request_fw] loaded 
>>>>> qcom/a650_sqe.fw from new location
>>>>> [   56.760166] msm msm: [drm:adreno_request_fw] loaded 
>>>>> qcom/a650_gmu.bin from new location
>>>>> [   56.768485] arm-smmu 3da0000.iommu: genpd_runtime_resume()
>>>>> [   56.774196] PM: gpu_cx_gdsc: Power-on latency exceeded, new 
>>>>> value 49531 ns
>>>>> [   56.781730] arm-smmu 3da0000.iommu: resume latency exceeded, 
>>>>> 462604 ns
>>>>> [   56.799559] platform 3d6a000.gmu: [drm:a6xx_gmu_resume] *ERROR* 
>>>>> GMU firmware initialization timed out
>>>>> [   56.809260] arm-smmu 3da0000.iommu: genpd_runtime_suspend()
>>>>> [   56.813062] msm msm: [drm:adreno_load_gpu] *ERROR* Couldn't 
>>>>> power up the GPU: -110
>>>>>
>>>>>
>>>>
>>>> Do you have your branch published somewhere so I can see what 
>>>> could've went wrong?
>>>
>>> I've applied your patches (this series + the extra one for 
>>> gpu/drm/msm) on top of 
>>> https://git.linaro.org/landing-teams/working/qualcomm/kernel.git 
>>> branch integration-linux-qcomlt .
>>
>> A trimmed down version: 
>> git.linaro.org/people/dmitry.baryshkov/kernel.git branch sm8250-gpu-test
>>
>>
> 
> Hi,
> 
> I tried this branch, with only the sm8250-hdk.dts from my other series 
> added (USB nodes removed as you don't have those in your branch), and 
> the GPU starts up without problems.
> 
> Possible differences I can think of:
> 
> 1) Different firmware version which behaves differently? These are the 
> checksums for the firmware I have:
> 
> /lib/firmware# md5sum a650_*
> f6536ba45c2f9f64ec31438217b6a027  a650_gmu.bin
> 897be740bed67deaa1943e9c36293165  a650_sqe.fw
> 00f1b291a2b30c98f05c25506e3f4761  a650_zap.b00
> bec0f79c7c6f5b32254facf3c7e046c7  a650_zap.b01
> 35273e4135147a269076144a3051b498  a650_zap.b02
> ce0dd1af27306eb341a01bda642f1c64  a650_zap.elf
> 09834955a8865073f6ee483f69a98b33  a650_zap.mdt

Interesting. This is what I have here:

3a3a455289c8c36b97a76b95d1dda5cb  a650_gmu.bin
9439db9b76c84f4aec625ff2bc4d1f90  a650_sqe.fw
00f1b291a2b30c98f05c25506e3f4761  a650_zap.b00
f30017eb17a440476a939d8eb1fbe102  a650_zap.b01
35273e4135147a269076144a3051b498  a650_zap.b02
03cef57e54ff48ab3ad49c7e2bcac56e  a650_zap.elf
93f651f41f4bab30dfb8e2bbd8f64ffd  a650_zap.mdt

> 2) GPU revision is not 650.2 (the downstream driver had workarounds for 
> bugs in the first revisions, which I didn't include in the upstream driver)

Interesting, I will take a look. The first obvious difference is the 
hang timeout and the a6xx_gmu_start() handling.

> 
> 3) Something in the kernel config is making a difference. Here is the 
> kernel config I used to test this: 
> https://gist.github.com/flto/c6b1bc48abda6fb580a2f21c51039c81

No, your config produces the same result:

[   46.964891] msm msm: [drm:0xffffffc01049bd00] loaded qcom/a650_sqe.fw 
from new location
[   46.973156] msm msm: [drm:0xffffffc01049bd00] loaded 
qcom/a650_gmu.bin from new location
[   46.994573] platform 3d6a000.gmu: [drm:0xffffffc0104a85d4] *ERROR* 
GMU firmware initialization timed out
[   47.004537] msm msm: [drm:0xffffffc01049b584] *ERROR* Couldn't power 
up the GPU: -110

-- 
With best wishes
Dmitry
