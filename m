Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E59C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD32020723
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="chanZ80S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436684AbgE2DeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 23:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436574AbgE2DeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 23:34:06 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D478C08C5C8
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 20:34:06 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b27so1050503qka.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 20:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tyQ6R9zPHdER38OPNGcXMf3Y34VIQ+4iMgNDMwi1+Qw=;
        b=chanZ80SvsBSV9iu/NMRLWDs1dH98echwP5mSuqC77tdDqO6ptpp8qxA8IbcsnnpLu
         3oWFPxTPCQ5Mvwlnq2b9gBoH0VNKPTMlL7cVEqawqpZyg4Om8gHVSQNsKqjk0ZiAZHsk
         qhsp4yfD1QM3KHvEZpRY6BvKR44u55vFVDOLAPbj6Tk/I3ExEijsOJVEgJ+wp6wzUo4J
         HNnWA0UDqaQi+Bo58fvxGRADorC1VX71HGnmqTKO0D7Qo3TIYB/M29Ns8+ErYoVWP9U4
         enwrn62aA5MDh77UQEi5SP12CiFhvD9OPpMiBn7uBUO01ViJUM8NbuxManbqTI7RhGPo
         Zejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tyQ6R9zPHdER38OPNGcXMf3Y34VIQ+4iMgNDMwi1+Qw=;
        b=YMYuYYtUSoDMdrsPjiWr0PO7VjW8HrCctDU1kGvI3Z/JUPWbxoKlpRJ839wn30zL3p
         XMxV6fv4gTpzS4xo5ALVSl1pTh39H89G8XgGJobD5aga0CwqdX+AEwu7+eu2kk0c6zDV
         hgdenoUBFQYi3E3+z5Gdn+GhA+nAdH3Yn9sMvenotYd4VZgfmxCXRUvTmyPHt4iaAbPF
         5QH7tVTekceYrGTrJMAUfKjXkwz+DS+izVzdAEt2QCUNW3KZjU8n0ZjRYKcsHb0Wp4XF
         FTc/bPJqW5JM9akvvt1xQ9QUFnaqgDLI+ifhn5Nny6KMAkmPlscSQWqlTu6SUvUWjeYT
         xOPA==
X-Gm-Message-State: AOAM531fpDlnnKMYo10o+mLyKQpnZD2R0QCtYG4ROB5fwX0eOyOfaaQa
        vArdPldwPnBq8SvKmEJRdyLD4iwH9Ds=
X-Google-Smtp-Source: ABdhPJyNBvf7yQNlqfR7BUIySX4hvebQsf08XCpr8wNvefEY+MuD3uSVtBJuRPWV2ryJcH/paqdzAg==
X-Received: by 2002:a37:af02:: with SMTP id y2mr6149497qke.389.1590723245397;
        Thu, 28 May 2020 20:34:05 -0700 (PDT)
Received: from [192.168.0.189] ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id e16sm7305168qtc.71.2020.05.28.20.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 20:34:05 -0700 (PDT)
Subject: Re: [PATCH 1/6] arm64: dts: qcom: sm8150: add apps_smmu node
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200524023815.21789-1-jonathan@marek.ca>
 <20200524023815.21789-2-jonathan@marek.ca>
 <20200529025246.GV279327@builder.lan>
 <d0908f34-a698-3449-35b9-7a98e9641295@marek.ca>
 <20200529031520.GA1799770@builder.lan>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <00b8f010-1ae1-45b2-8dd0-a1b582861a2e@marek.ca>
Date:   Thu, 28 May 2020 23:34:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200529031520.GA1799770@builder.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/20 11:15 PM, Bjorn Andersson wrote:
> On Thu 28 May 20:02 PDT 2020, Jonathan Marek wrote:
> 
>>
>>
>> On 5/28/20 10:52 PM, Bjorn Andersson wrote:
>>> On Sat 23 May 19:38 PDT 2020, Jonathan Marek wrote:
>>>
>>>> Add the apps_smmu node for sm8150. Note that adding the iommus field for
>>>> UFS is required because initializing the iommu removes the bypass mapping
>>>> that created by the bootloader.
>>>>
>>>
>>> Unrelated to the patch itself; how do you disable the splash screen on
>>> 8150? "fastboot oem select-display-panel none" doesn't seem to work for
>>> me on the MTP - and hence this would prevent my device from booting.
>>>
>>> Thanks,
>>> Bjorn
>>>
>>
>> I don't have a MTP, but on HDK855, "fastboot oem select-display-panel none"
>> combined with setting the physical switch to HDMI mode (which switches off
>> the 1440x2560 panel) gets it to not setup the display at all (just the
>> fastboot command isn't enough).
>>
> 
> Okay, I don't think we have anything equivalent on the MTP, but good to
> know.
> 
>> With HDK865 though that doesn't work and I have a hack to work around it
>> (writing 0 to INTF_TIMING_ENGINE_EN early on in boot will stop video mode
>> scanout and it won't crash).
>>
> 
> Then we need to sort this out in the arm-smmu driver before we can
> enable the apps_smmu node on 8250. I did receive some guidance from Will
> on the subject and have started looking into this.
> 

That's annoying because a lot depends on apps_mmu. GPU is an exception 
with its own MMU but pretty much everything else uses apps_smmu (does it 
make sense to add USB nodes if it won't work without apps_smmu?) Is this 
something that will get resolved soon?

FWIW, I have another sm8250 board which does not need the workaround 
(its bootloader does not set up the display). AFAIK modifying the 
bootloader to not set up any display is a trivial modification (assuming 
that's an option).

> Thanks,
> Bjorn
> 
>>>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/sm8150.dtsi | 91 ++++++++++++++++++++++++++++
>>>>    1 file changed, 91 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
>>>> index a36512d1f6a1..acb839427b12 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
>>>> @@ -442,6 +442,8 @@ ufs_mem_hc: ufshc@1d84000 {
>>>>    			resets = <&gcc GCC_UFS_PHY_BCR>;
>>>>    			reset-names = "rst";
>>>> +			iommus = <&apps_smmu 0x300 0>;
>>>> +
>>>>    			clock-names =
>>>>    				"core_clk",
>>>>    				"bus_aggr_clk",
>>>> @@ -706,6 +708,7 @@ usb_1_dwc3: dwc3@a600000 {
>>>>    				compatible = "snps,dwc3";
>>>>    				reg = <0 0x0a600000 0 0xcd00>;
>>>>    				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
>>>> +				iommus = <&apps_smmu 0x140 0>;
>>>>    				snps,dis_u2_susphy_quirk;
>>>>    				snps,dis_enblslpm_quirk;
>>>>    				phys = <&usb_1_hsphy>, <&usb_1_ssphy>;
>>>> @@ -742,6 +745,94 @@ spmi_bus: spmi@c440000 {
>>>>    			cell-index = <0>;
>>>>    		};
>>>> +		apps_smmu: iommu@15000000 {
>>>> +			compatible = "qcom,sdm845-smmu-500", "arm,mmu-500";
>>>> +			reg = <0 0x15000000 0 0x100000>;
>>>> +			#iommu-cells = <2>;
>>>> +			#global-interrupts = <1>;
>>>> +			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>;
>>>> +		};
>>>> +
>>>>    		remoteproc_adsp: remoteproc@17300000 {
>>>>    			compatible = "qcom,sm8150-adsp-pas";
>>>>    			reg = <0x0 0x17300000 0x0 0x4040>;
>>>> -- 
>>>> 2.26.1
>>>>
