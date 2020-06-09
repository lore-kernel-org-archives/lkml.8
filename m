Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9FFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0521B206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="P1LYPNvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389400AbgFITmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729680AbgFITmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 15:42:13 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512A9C08C5C2
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 12:42:13 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w3so22048018qkb.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 12:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PmkfgBREBTZO6Lp2UGSsh4z5MxUsd0nbvKVP/iz3AwU=;
        b=P1LYPNvMyUWuYnFLslmoaME7fOIbzZ7vLQgZlSN/neUPoucaQ2KOFsChMogb02y8Rd
         x2gk6UBDLM5J2sRw69zj5ucSIj/r106vHu4lLlzEoAjMD6P2Mdd1isbdnY0u7SgIQmZ1
         apI0LHIQaBz0M/l5twAWI6FfFEPVLUgRIst+8ImG8Tw4D5ecJOsKg/k/Xs4p7iyo6PM5
         8z7kIGK2CrX82YlG3xBRdVHUOaj6+Sz1DaY+uilNJmkAy7ijLn8TAAXUO7ND4YI33N4C
         1O1s/wmoTIvbxBXXN5NFOZlQyACVcrcNbiQ2eg/ZoONzNUCTFPa6j3mzkkjlz0EpJAMr
         dCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PmkfgBREBTZO6Lp2UGSsh4z5MxUsd0nbvKVP/iz3AwU=;
        b=RySR3DW/chJLB0fycittDPvnZdtnTI01wdKmbPgA2qRaSN1VaO5g5yBNzA0LKm6ARP
         OEzpf7asjrOT5W7VwPEo3QO0mu+Kw7KDylublhZhFE6T/uuW6rWE2mTetHisU29QnU2u
         I4k2WRFheatj+9OlraySCort/SC3YqpGEsTKiSIJDLeMmy0BktWUjgRm6zqXaG7LS0TW
         qgpA4nuaIjiSb7FEU5YfOnt4ou9GmJa2zJPMzd2q6sFRtSvBbRjO7eUVC/bjToWRzRju
         Xr5omq6UlpCGWko1zp7RP73TtaEPzBYVyXw2sllTUH3x67W/Lod7M9NgJSak8d+IItLH
         0iUw==
X-Gm-Message-State: AOAM5304dQtpkVqD1O1aOidiYljLHt2ZbdIFs0HRozvgBxH85tzMdayH
        KaBrZvX/4vEziJx2ObAo/xZsr1ugv7YLeA==
X-Google-Smtp-Source: ABdhPJxPoZa5i7cw6g6j5jFto1S52GzTF6MdnrhHijhBh8WO+6es4ey0iqaL1gWN1g5RBgbK55I9nw==
X-Received: by 2002:a05:620a:200a:: with SMTP id c10mr28557256qka.218.1591731732437;
        Tue, 09 Jun 2020 12:42:12 -0700 (PDT)
Received: from [192.168.0.189] ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id o66sm10662743qka.60.2020.06.09.12.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 12:42:12 -0700 (PDT)
Subject: Re: [PATCH 6/6] arm64: dts: qcom: add sm8250 hdk dts
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200524023815.21789-1-jonathan@marek.ca>
 <20200524023815.21789-7-jonathan@marek.ca>
 <20200529030322.GX279327@builder.lan>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <9076c2c0-853f-62f9-4e34-a78e865a552e@marek.ca>
Date:   Tue, 9 Jun 2020 15:42:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200529030322.GX279327@builder.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/20 11:03 PM, Bjorn Andersson wrote:
> On Sat 23 May 19:38 PDT 2020, Jonathan Marek wrote:
> 
>> Add initial HDK865 dts, based on sm8250-mtp, with a few changes.
>> Notably, regulator configs are changed a bit.
>>
>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile       |   1 +
>>   arch/arm64/boot/dts/qcom/sm8250-hdk.dts | 454 ++++++++++++++++++++++++
>>   2 files changed, 455 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/sm8250-hdk.dts
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index e5dbd8b63951..4649e8bc5034 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -24,6 +24,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-mtp.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-hdk.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-mtp.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-hdk.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-mtp.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/sm8250-hdk.dts b/arch/arm64/boot/dts/qcom/sm8250-hdk.dts
>> new file mode 100644
>> index 000000000000..d35014bf4f81
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sm8250-hdk.dts
>> @@ -0,0 +1,454 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include "sm8250.dtsi"
>> +#include "pm8150.dtsi"
>> +#include "pm8150b.dtsi"
>> +#include "pm8150l.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. SM8250 HDK";
>> +	compatible = "qcom,sm8250-hdk";
> 
> 	compatible = "qcom,sm8250-hdk", "qcom,sm8250";
> 
> Apart from that this looks good!
> 

Made this change for both HDK dts, but FYI the mtp dts do not have this.

> Thanks,
> Bjorn
> 
