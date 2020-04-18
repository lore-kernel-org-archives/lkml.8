Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84F7C38A2E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 12:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0E8E22251
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 12:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koe5NkvT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgDRMOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 08:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725862AbgDRMOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 08:14:49 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAFDC061A0C;
        Sat, 18 Apr 2020 05:14:49 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a81so5698767wmf.5;
        Sat, 18 Apr 2020 05:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f+xMR+KYzCgzYlW1x4Og/ZLSKx3U5B8Ky3smGBm8ZHA=;
        b=koe5NkvTdWegoN30UZTYBcRaxprT1wTS0WqnTAbfD8B4oBWVkTSEqoj+1yIpB/qPiV
         ondEhRv6v/0G/SyDhcn0t/WmOPmyjDrfge1QkFKA+oRl07dvL613Vq/D8u93n3qt7U42
         FLe6mDe9LYxN36yCaI/+nOkdw02d0TgkgjwyXWf6FxtJk+7Cy7uiOtaObxKrUH6lAst2
         mP3wJ4gn5ZjUWKlP0li8NkjDPDSFgJomwczytkyqePEGoq9lfcTTCtthyxd6cZgwbHQ8
         HDXCuSdNftLEaY8W8+SbZ6FYchlOOLsYXjg8cdsSCSYsiMXf3TuOI66csYo3OddvAUqU
         KkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f+xMR+KYzCgzYlW1x4Og/ZLSKx3U5B8Ky3smGBm8ZHA=;
        b=tS7Gutnu4fTAth629xb3mnIlcqhiItiZ9C9xXkG0N5TrXsxTGIiZOw26Bu/4PHj8Y9
         OuQROJA/AuGbvmKuAWa2Ry0AyIchLUnLeLJEld5iZgR08IOHqeYat2wGpBkr8SllVR2l
         Aevb+PorNkF4qxpbS28/IfTiiHW0FOh3Uh6D/yp7RnvYL8hEvoQwOcfkC/R7Adg1dQXw
         qUBeIMdgOyid29ctfZ77QfS0NSQ3kaUAtJzPp1QS/awq0prjwllKpPcv6vKhKoW7CBFH
         ySnPevTL+S+cqg12DniPHoONdGtmhDzBriyS1HyKGryKYXIctU+2AA1DFtZQQc8jTlMu
         xexw==
X-Gm-Message-State: AGi0PuYOq4QAl596gGmKnABEQRGYbUwGs+X7AM4KpIsohKdLh42HyayV
        0h1AUw+qr71G9PcHzu/IwfQ=
X-Google-Smtp-Source: APiQypLstfRt6XI+FJgsZSB8kYksMAzORNwekKGiJB7VWHJq2V546ps+cjXl1idfaq0d3MMRzVBZ9A==
X-Received: by 2002:a1c:3105:: with SMTP id x5mr8366565wmx.51.1587212087665;
        Sat, 18 Apr 2020 05:14:47 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id i97sm37891167wri.1.2020.04.18.05.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 05:14:47 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] ARM: dts: rockchip: add rga node for rk322x
To:     Heiko Stuebner <heiko@sntech.de>,
        Justin Swartz <justin.swartz@risingedge.co.za>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        mark.rutland@arm.com, robh+dt@kernel.org
References: <be4f2c802a64562cbab629abc82dd7d228a1a747.1580768038.git.justin.swartz@risingedge.co.za>
 <3593382.iQIKm1rSL1@phil> <b77422198df7c285d824086131371284@risingedge.co.za>
 <2533855.f5ZhyS2AsA@phil>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <558b35c3-7f75-8d0d-048b-c55c06fa8a53@gmail.com>
Date:   Sat, 18 Apr 2020 14:14:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2533855.f5ZhyS2AsA@phil>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/20 12:53 PM, Heiko Stuebner wrote:
> Am Samstag, 18. April 2020, 11:56:03 CEST schrieb Justin Swartz:
>> Hi Johan, Heiko,
>>
>> On 2020-04-18 11:49, Heiko Stuebner wrote:
>>
>>> Am Samstag, 18. April 2020, 11:15:27 CEST schrieb Johan Jonker:
>>>
>>>> Hi Justin, Heiko,
>>>>
>>>> In the discussion about "rockchip,px30-rga" it was mentioned that:
>>>> "no status for soc internal components without any board-specifics".
>>>> The binding is in mainline, but the dts node is missing I think.
>>>> Should this also be changed?
>>>
>>> yep, drop the status disabled from the dtsi and that then results
>>> in not needing the board-level enablement
>>>
>>> (background: rga is a simple mem2mem device without any
>>> board-specific hooks)
>>
>> Shall I submit version 5 of this patch series?
> 
> I guess so ... especially as we expect patch1 to go through the
> media tree and sending a new version might serve as a ping :-)
> and include the Ack by Rob for easy applying

The conversion to rockchip-rga.yaml including rockchip,rk3228-rga is
already reviewed by robh.

> 
> 
> Heiko
> 
> 
>>
>>> Johan
>>>
>>> +&rga {
>>> +    status = "okay";
>>> +};
>>> +
>>>
>>> Add a node to define the presence of RGA, a 2D raster
>>> graphic acceleration unit.
>>>
>>> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
>>> ---
>>> arch/arm/boot/dts/rk322x.dtsi | 11 +++++++++++
>>> 1 file changed, 11 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/rk322x.dtsi 
>>> b/arch/arm/boot/dts/rk322x.dtsi
>>> index 340ed6ccb..29d50bebc 100644
>>> --- a/arch/arm/boot/dts/rk322x.dtsi
>>> +++ b/arch/arm/boot/dts/rk322x.dtsi
>>> @@ -621,6 +621,17 @@
>>> status = "disabled";
>>> };
>>>
>>> +    rga: rga@20060000 {
>>> +        compatible = "rockchip,rk3228-rga", "rockchip,rk3288-rga";
>>> +        reg = <0x20060000 0x1000>;
>>> +        interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
>>> +        clocks = <&cru ACLK_RGA>, <&cru HCLK_RGA>, <&cru SCLK_RGA>;
>>> +        clock-names = "aclk", "hclk", "sclk";
>>> +        resets = <&cru SRST_RGA>, <&cru SRST_RGA_A>, <&cru 
>>> SRST_RGA_H>;
>>> +        reset-names = "core", "axi", "ahb";
>>> +        status = "disabled";
>>> remove?
>>>
>>> +    };
>>> +
>>> iep_mmu: iommu@20070800 {
>>> compatible = "rockchip,iommu";
>>> reg = <0x20070800 0x100>;
>>
> 
> 
> 
> 

