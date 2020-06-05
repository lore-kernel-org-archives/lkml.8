Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D4FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3CAF20663
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="RXROPFih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgFEOKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgFEOKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:10:08 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252A3C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 07:10:08 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n11so9759878qkn.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 07:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I0/WSfj2SyN/DyoKU5g8TSVdYEPxsYEHqAcc64RrQhU=;
        b=RXROPFih1qODR8nENLKP9JMQxe/2o43hmY/yGapZPyol/NnvoY62UsOWy+S7zmCZW0
         TMOVUkZHubrGkwKq1Xw9mhAPG9LcV5oRK0niv6Aiow7e7ZgmEYvDn/plIEuY1nCT1aOa
         aGXPv5b/huLViIIhT8WMuTT5K0qOSo+ykUx/MH9VtwURHW83KH4GCJXtVs0GdlR7YBSL
         8FmjDVPbACcF1Biph0ZodVdEtB622+nM9K1ELqUlZ4z9ixo4f3uEJGzKXl/eb3lzO3x2
         2Rkqm+/hVpRa8Nt5CSAg9Tv+ghkkI2Ewi3aBmWYvvBCGBfS5gvJNrwgbyHuigBY2b+5+
         WydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I0/WSfj2SyN/DyoKU5g8TSVdYEPxsYEHqAcc64RrQhU=;
        b=dJGKv4LkHXQ5nhxpfoF+jGtz0jMmEIsp4IPx54pImT3v+xirIVpbvDQAhqX+y2gnDw
         +1mkbzsc15q4zfxG0A1wMDePPHGGbFfN6aczSH2yfNE4qlzONjv57n3/LnsVaKN0WAJI
         e4T3dKyYX5NUxwdVUTILPYhnYzYxWcL7cCd75b2sYYwpJD1LUv2/zZtjNapF+O/lIuGk
         ST7kp3GQTmMrYUSBRgaxsNvb/JHt8E7qUtWVePUdsZRxvqlOFJf+eaI0SIPIeWv86Cvi
         tU/3HZCaBQZSg6Cfq/X1rzQ2L9Q1s3zIUDl1z+vB8glKows57EOKcKmOj/Ze0R2iMk+o
         /6sg==
X-Gm-Message-State: AOAM532DKo+9N4phCuiaRlPX0T8935mmVmvM0lEXCt6O4R+iZ3TtrgJl
        Jt9N38QAHHk9ArEzg8Ge5aJcRw==
X-Google-Smtp-Source: ABdhPJwVy4BwZQ6cvWCnxoX8YJIsDQhVvQPsH1HgtDJtg+RGPnkkV5AL921wK/IkdVN4k1dMoBjVDA==
X-Received: by 2002:a37:c20c:: with SMTP id i12mr10527895qkm.167.1591366207162;
        Fri, 05 Jun 2020 07:10:07 -0700 (PDT)
Received: from [192.168.0.189] ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id b4sm6449846qka.133.2020.06.05.07.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 07:10:06 -0700 (PDT)
Subject: Re: [PATCH 1/6] arm64: dts: qcom: sm8150: add apps_smmu node
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        devicetree-owner@vger.kernel.org
References: <20200524023815.21789-1-jonathan@marek.ca>
 <20200524023815.21789-2-jonathan@marek.ca>
 <20200529025246.GV279327@builder.lan>
 <d0908f34-a698-3449-35b9-7a98e9641295@marek.ca>
 <20200529031520.GA1799770@builder.lan>
 <91eb7ee0e549b10724c724aebfd91996@codeaurora.org>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <8cf134f0-381f-7765-2496-e5abd77f3087@marek.ca>
Date:   Fri, 5 Jun 2020 10:10:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <91eb7ee0e549b10724c724aebfd91996@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/20 10:03 AM, Sai Prakash Ranjan wrote:
> On 2020-05-29 08:45, Bjorn Andersson wrote:
>> On Thu 28 May 20:02 PDT 2020, Jonathan Marek wrote:
>>
>>>
>>>
>>> On 5/28/20 10:52 PM, Bjorn Andersson wrote:
>>> > On Sat 23 May 19:38 PDT 2020, Jonathan Marek wrote:
>>> >
>>> > > Add the apps_smmu node for sm8150. Note that adding the iommus 
>>> field for
>>> > > UFS is required because initializing the iommu removes the bypass 
>>> mapping
>>> > > that created by the bootloader.
>>> > >
>>> >
>>> > Unrelated to the patch itself; how do you disable the splash screen on
>>> > 8150? "fastboot oem select-display-panel none" doesn't seem to work 
>>> for
>>> > me on the MTP - and hence this would prevent my device from booting.
>>> >
>>> > Thanks,
>>> > Bjorn
>>> >
>>>
>>> I don't have a MTP, but on HDK855, "fastboot oem select-display-panel 
>>> none"
>>> combined with setting the physical switch to HDMI mode (which 
>>> switches off
>>> the 1440x2560 panel) gets it to not setup the display at all (just the
>>> fastboot command isn't enough).
>>>
>>
>> Okay, I don't think we have anything equivalent on the MTP, but good to
>> know.
>>
> 
> Actually I tried out this in SM8150 MTP and it works fine for me,
> 
> "fastboot set_active a; fastboot set_active b; fastboot set_active a; 
> fastboot oem select-display-panel none; fastboot reboot bootloader; 
> fastboot boot boot-sm8150.img"
> 
> Also I need to switch slots everytime like above, otherwise I always see 
> some error
> while loading the boot image.
> 

What is the error? If it is "FAILED (remote: Failed to load/authenticate 
boot image: Load Error)" then flashing/erasing boot_a will make it go 
away ("fastboot erase boot_a") for the next 6 or so "failed" boots.

> Thanks,
> Sai
> 
