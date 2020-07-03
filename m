Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7399DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5215720870
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="Pa5s69St"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgGCJdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 05:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgGCJdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:33:24 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBC3C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 02:33:23 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id d17so21474057ljl.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 02:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FxORWevFMuPysEWqwp7nhsVM+UgCIl2L6xusN6h/tRo=;
        b=Pa5s69StIWHqUszCnn7WyIkhL3j+RajqkShp8k3dvCEVibyOe0GMLFnbZpxTqORJbm
         DQrixJG2YkDXrhh1sLs/XgxA5tes5bCbL1xR6BOYa7f6P9j7t5W5rlnNav4M4qA0/Asm
         QXPh//FRRJNTzfHoQViYPLngKyafB6kAZB1SNlf8blPIcbpmEDr1WiIpFWf50KZA1AeA
         E/0FtRT62fkshSeBqe5ahRC3LI+WU97GHJVErWiqarDYYZP0ZPuOCEX6F3R4q5W7PAJg
         8h1ZRUYYKKCWxhgNbzQpXwjLneJmKBEFO5kPyCU3mowvLD6bQ24f5JSQooY2fj9cehSa
         qB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FxORWevFMuPysEWqwp7nhsVM+UgCIl2L6xusN6h/tRo=;
        b=tS/9RDGFTRtzvRX+R6gz/xGKAELahdj507dxAEG7z//+zDZ9ipTXMNOC3qLNq5PtAc
         ejd6qn2fFUpIc86Tx3xBgFcpwD871qZgqpeLXK8wFdEwpkCSz6hRxqidDJs3ZH17gxex
         3DxeM3gplgZBhT705PjYUM+q3mbqHFVL66J/Oah4txr5EMVQxZFZ2kw9KgrzUfCa9hkF
         BrM4OPvzmGJlq4rUdQaaR0Mc1zJBfWIm82d2W0ga0bH982s8f2/uWU3L0VmrgJSpqLMZ
         NYJ9U4vChfxZ//i+oMUx8MMK1qeS3X6VBVLhbhJUEfOr51OogObrMC/N+lZgJnG/NdcQ
         eLBw==
X-Gm-Message-State: AOAM532Ti9Wj7FXAu1xaD4N0su7VWUNYCAplhjgnVX+zDuGo7kAOSHN1
        CO2ZMoAaQWgaruDQh8o+R8RbcA==
X-Google-Smtp-Source: ABdhPJzd/ZgbHMgl58AU/eQVn4qA4l5hP0brJ3GW/SvYfHe/nK8939nIQ/LSupb0XRiMYcgIBwPmfA==
X-Received: by 2002:a2e:b6d2:: with SMTP id m18mr699203ljo.341.1593768802134;
        Fri, 03 Jul 2020 02:33:22 -0700 (PDT)
Received: from [192.168.1.9] ([83.68.95.66])
        by smtp.googlemail.com with ESMTPSA id c14sm3908884ljj.112.2020.07.03.02.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 02:33:21 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] arm64: dts: marvell: add SMMU support
To:     Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        joro@8bytes.org, gregory.clement@bootlin.com, robh+dt@kernel.org,
        hannah@marvell.com
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, catalin.marinas@arm.com,
        nadavh@marvell.com, linux-arm-kernel@lists.infradead.org,
        mw@semihalf.com
References: <20200702201633.22693-1-tn@semihalf.com>
 <20200702201633.22693-5-tn@semihalf.com>
 <ba29e839-79e0-7189-f735-d457544135e4@arm.com>
From:   Tomasz Nowicki <tn@semihalf.com>
Message-ID: <3d9b3d16-00e4-d3b5-344b-8515c70fb83e@semihalf.com>
Date:   Fri, 3 Jul 2020 11:33:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <ba29e839-79e0-7189-f735-d457544135e4@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.07.2020 11:16, Robin Murphy wrote:
> On 2020-07-02 21:16, Tomasz Nowicki wrote:
>> From: Marcin Wojtas <mw@semihalf.com>
>>
>> Add IOMMU node for Marvell AP806 based SoCs together with platform
>> and PCI device Stream ID mapping.
>>
>> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> ---
>>   arch/arm64/boot/dts/marvell/armada-8040.dtsi  | 36 +++++++++++++++++++
>>   arch/arm64/boot/dts/marvell/armada-ap80x.dtsi | 17 +++++++++
>>   2 files changed, 53 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/marvell/armada-8040.dtsi 
>> b/arch/arm64/boot/dts/marvell/armada-8040.dtsi
>> index 7699b19224c2..25c1df709f72 100644
>> --- a/arch/arm64/boot/dts/marvell/armada-8040.dtsi
>> +++ b/arch/arm64/boot/dts/marvell/armada-8040.dtsi
>> @@ -23,3 +23,39 @@
>>   &cp0_rtc {
>>       status = "disabled";
>>   };
>> +
>> +&cp0_usb3_0 {
>> +    iommus = <&smmu 0x440>;
>> +};
>> +
>> +&cp0_usb3_1 {
>> +    iommus = <&smmu 0x441>;
>> +};
>> +
>> +&cp0_sata0 {
>> +    iommus = <&smmu 0x444>;
>> +};
>> +
>> +&cp0_sdhci0 {
>> +    iommus = <&smmu 0x445>;
>> +};
>> +
>> +&cp1_sata0 {
>> +    iommus = <&smmu 0x454>;
>> +};
>> +
>> +&cp1_usb3_0 {
>> +    iommus = <&smmu 0x450>;
>> +};
>> +
>> +&cp1_usb3_1 {
>> +    iommus = <&smmu 0x451>;
>> +};
>> +
>> +&cp0_pcie0 {
>> +    iommu-map =
>> +        <0x0   &smmu 0x480 0x20>,
>> +        <0x100 &smmu 0x4a0 0x20>,
>> +        <0x200 &smmu 0x4c0 0x20>;
>> +    iommu-map-mask = <0x031f>;
> 
> Nice! I do like a good compressed mapping :D
> 
>> +};
>> diff --git a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi 
>> b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
>> index 7f9b9a647717..ded8b8082d79 100644
>> --- a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
>> +++ b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
>> @@ -56,6 +56,23 @@
>>               compatible = "simple-bus";
>>               ranges = <0x0 0x0 0xf0000000 0x1000000>;
>> +            smmu: iommu@5000000 {
>> +                compatible = "marvell,ap806-smmu-500", "arm,mmu-500";
>> +                reg = <0x100000 0x100000>;
>> +                dma-coherent;
>> +                #iommu-cells = <1>;
>> +                #global-interrupts = <1>;
>> +                interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> 
> I'd recommend you have the node disabled by default here, then 
> explicitly enable it in armada-8040.dtsi where you add the Stream IDs. 
> Otherwise it will also end up enabled for 8020, 70x0, etc. where 
> disable_bypass will then catastrophically break everything.
> 

Good point! I will fix this.

Thanks,
Tomasz
