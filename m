Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E225EC433F2
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCA152065D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RUPYiNko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGXOKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgGXOKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:10:15 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD7CC0619E6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 07:10:14 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id p14so7721507wmg.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 07:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oPLIlCfc70Qlc5XX07VBDQthbWP5GzGhSyFC84buhe0=;
        b=RUPYiNkoD9/fvOChPJy6VZ5o+bNPXpv0KPwl9rtBPktcYYeZ5ZUVjUVTaEd67e7NRR
         W08X3kLsvJCFPlfhGnpTVqkJNHPH4d/zGjX2ZyzF/dyvdMlGfV2Ec67w5SaIENFjAVqy
         evUtDPnk52Cqzgrac7jKE3IM1Yvnm8o3NnbB4bG+JzTNYN3gnOAu7uoRnmVt+Xp6vzN8
         ju6tGl7g6ZpmhQ8OltJAomK6SRjQhO/tG8QAzmrK9J1pxPFkVSMjP2UX2c2nZdYgRz+o
         xtwSgzXrp4LvQ5aIrudAYH+aATM4bsybIbSje22Al+V72pv5PnrrrQKHyXdF4UVV7CYd
         J5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oPLIlCfc70Qlc5XX07VBDQthbWP5GzGhSyFC84buhe0=;
        b=fOJhopr6eNCP13O657fRlkXGJnMm/urlE1NmWu9hlYYtWnUDOjMyC0NYrjlnUS5Ac0
         7rXBHkqJvXxA/RLK30CMhZtV07t50zv2vouy1+nJmqMJ1WdZU/4BkMKL97TiGPE92/ES
         doD9JwU6hUcPUWxhuZ7trb5o5fUHqfnVkM02PQvmypTreTXcFnKi/1a7laLR5Y4qGVCD
         0CfzjbFXKC9/9W8n6ODNo/p1AMqFiuZ+ILvNP0I0Y3bHC6m8NEwzoCdxFSjfcTZAjoze
         97YLCmNPY8OtuyWkFR33tuKxGGG/8VWYPOnvlL9exAUVYgugNKECxMnUGFscuDVf5GQ0
         nfqw==
X-Gm-Message-State: AOAM5334K0Zun24LqYpiiMvyVCzneAJxvQ9xMgfJPM7nMZx/LIpd3XnE
        L5WH0pJC6x10swLNQHacJbgWGA==
X-Google-Smtp-Source: ABdhPJykpbsUwMaxQU5o+LBtvuFvjHIiOODN4lC6PN8XqQtQ6aUJlEBz8DWym4y64kSxomzz5ajbsQ==
X-Received: by 2002:a05:600c:21ca:: with SMTP id x10mr8790738wmj.63.1595599813106;
        Fri, 24 Jul 2020 07:10:13 -0700 (PDT)
Received: from [192.168.1.7] ([195.24.90.54])
        by smtp.googlemail.com with ESMTPSA id b18sm1480475wrs.46.2020.07.24.07.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 07:10:12 -0700 (PDT)
Subject: Re: [PATCH v4 4/5] arm64: dts: sdm845: Add OPP tables and
 power-domains for venus
To:     Rajendra Nayak <rnayak@codeaurora.org>, robh+dt@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org
References: <1595503612-2901-1-git-send-email-rnayak@codeaurora.org>
 <1595503612-2901-5-git-send-email-rnayak@codeaurora.org>
 <e68ff810-362a-5b99-206b-f676b204101d@linaro.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <94581989-e069-55e5-6b70-919185eda33e@linaro.org>
Date:   Fri, 24 Jul 2020 17:09:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e68ff810-362a-5b99-206b-f676b204101d@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/23/20 9:06 PM, Stanimir Varbanov wrote:
> Hi Rajendra,
> 
> After applying 2,3 and 4/5 patches on linaro-integration v5.8-rc2 I see
> below messages on db845:
> 
> qcom-venus aa00000.video-codec: dev_pm_opp_set_rate: failed to find
> current OPP for freq 533000097 (-34)
> 
> ^^^ This one is new.
> 
> qcom_rpmh TCS Busy, retrying RPMH message send: addr=0x30000
> 
> ^^^ and this message is annoying, can we make it pr_debug in rpmh?
> 
> On 7/23/20 2:26 PM, Rajendra Nayak wrote:
>> Add the OPP tables in order to be able to vote on the performance state of
>> a power-domain.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 40 ++++++++++++++++++++++++++++++++++--
>>  1 file changed, 38 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index e506793..5ca2265 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -3631,8 +3631,10 @@
>>  			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
>>  			power-domains = <&videocc VENUS_GDSC>,
>>  					<&videocc VCODEC0_GDSC>,
>> -					<&videocc VCODEC1_GDSC>;
>> -			power-domain-names = "venus", "vcodec0", "vcodec1";
>> +					<&videocc VCODEC1_GDSC>,
>> +					<&rpmhpd SDM845_CX>;
>> +			power-domain-names = "venus", "vcodec0", "vcodec1", "cx";
>> +			operating-points-v2 = <&venus_opp_table>;
>>  			clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
>>  				 <&videocc VIDEO_CC_VENUS_AHB_CLK>,
>>  				 <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>,
>> @@ -3654,6 +3656,40 @@
>>  			video-core1 {
>>  				compatible = "venus-encoder";
>>  			};
>> +
>> +			venus_opp_table: venus-opp-table {
>> +				compatible = "operating-points-v2";
>> +
>> +				opp-100000000 {
>> +					opp-hz = /bits/ 64 <100000000>;
>> +					required-opps = <&rpmhpd_opp_min_svs>;
>> +				};
>> +
>> +				opp-200000000 {
>> +					opp-hz = /bits/ 64 <200000000>;
>> +					required-opps = <&rpmhpd_opp_low_svs>;
>> +				};
>> +
>> +				opp-320000000 {
>> +					opp-hz = /bits/ 64 <320000000>;
>> +					required-opps = <&rpmhpd_opp_svs>;
>> +				};
>> +
>> +				opp-380000000 {
>> +					opp-hz = /bits/ 64 <380000000>;
>> +					required-opps = <&rpmhpd_opp_svs_l1>;
>> +				};
>> +
>> +				opp-444000000 {
>> +					opp-hz = /bits/ 64 <444000000>;
>> +					required-opps = <&rpmhpd_opp_nom>;
>> +				};
>> +
>> +				opp-533000000 {
>> +					opp-hz = /bits/ 64 <533000000>;

Actually it comes from videocc, where ftbl_video_cc_venus_clk_src
defines 533000000 but the real calculated freq is 533000097.

If I change to opp-hz = /bits/ 64 <533000097> the error disappear.

I guess we have to revisit m/n and/or pre-divider for this freq when the
source pll is P_VIDEO_PLL0_OUT_MAIN PLL?

>> +					required-opps = <&rpmhpd_opp_turbo>;
>> +				};
>> +			};
>>  		};
>>  
>>  		videocc: clock-controller@ab00000 {
>>
> 

-- 
regards,
Stan
