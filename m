Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645A5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AFEA20888
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="0Y/u5oOn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391785AbgE2DOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 23:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391750AbgE2DOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 23:14:45 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAD2C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 20:14:44 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id g18so825284qtu.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 20:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H5HheWuqLGrlDB833NJjW67g7yc0Wg6x6QVU4LcM2l4=;
        b=0Y/u5oOnsW4Ep6890ubioL04lWNxZBVNGL8q9iyU9rQrSikRSCNfimgvsLLiTdkd+U
         7rBfJASN22GZlPguXLbPl/E0SOQGg3iwtH8Wx2MyXIdOQq4JjCUYSDML0WkRvusvYz1v
         y4ExbMGfj8rOjz9NUoiwGMKQELV9NXwFcjUMsxEXPX0DB5OctIC9XzPs+c3cGaEM6GFT
         WpjWLTjuKymUdktDdLFjYvJO+EGUO9Ugi1cNTNx8Ko6MkQspmT7j2Yyi7mqrFc7euLJZ
         yTs8fIUQuzIVaU0Yk3Vh5aE3Gnvw1SCKQSE+ITqiDx4BXpENcQmpKlRjkUgZnWrB62Rj
         hsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H5HheWuqLGrlDB833NJjW67g7yc0Wg6x6QVU4LcM2l4=;
        b=MlVFDJZjoQEE7Sc/Cfk3LHRZW5TdWijdi5BtjLEjB/bTqWjUOeIL8eSZwmdpOW/wkU
         O9jwTvMJP+Yvjg0GoQBYBFRNS7MT83HG/EFe+jFQUJD1wdcWk/bzsMxOym0HloOGzpjB
         dqt2kDaKnOZCdKoQ3eB5dDcFVUShyEZ53y0s5/R3r1b8E6gORCuPSBV7hhUpMoZHxEIT
         Gg3ZIpkaRf4gwABEviJBGn+YniY/DHDZkn8VawsgbRZYNUIiNxRTNfT8wXQOoGEllqzK
         8IdWpoTYHvFvNiuDxrh0VmQCSSh0l/sKQimAV6k5OltEWAyoMkQzaBUBm26vAX9XJXwT
         0e2A==
X-Gm-Message-State: AOAM531rfK+GkAxFn9vfffbOr/A0qcuf7OZBSfwbfxzM+GTzEzHV56B6
        9Xy1TIlSUMLWoFXEBdcOuXDgwA==
X-Google-Smtp-Source: ABdhPJzShBLLbmfKyfOsjtLrmhoL7/fz5ZzZWGY33fZ69PPlQzqY+VHuZ0o5nHjZ26WSNK0E7VHJZw==
X-Received: by 2002:ac8:774d:: with SMTP id g13mr6476728qtu.63.1590722083477;
        Thu, 28 May 2020 20:14:43 -0700 (PDT)
Received: from [192.168.0.189] ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id b9sm6535131qto.91.2020.05.28.20.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 20:14:43 -0700 (PDT)
Subject: Re: [PATCH 0/6] arm64: dts: qcom: smmu/USB nodes and HDK855/HDK865
 dts
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20200524023815.21789-1-jonathan@marek.ca>
 <20200529030505.GY279327@builder.lan>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <0630ae9c-6ae7-b74e-5dd3-0c569bad74f5@marek.ca>
Date:   Thu, 28 May 2020 23:15:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200529030505.GY279327@builder.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/20 11:05 PM, Bjorn Andersson wrote:
> On Sat 23 May 19:38 PDT 2020, Jonathan Marek wrote:
> 
>> Add dts nodes for apps_smmu and USB for both sm8150 and sm8250.
>>
>> Also add initial dts files for HDK855 and HDK865, based on mtp dts, with a
>> few changes. Notably, the HDK865 dts has regulator config changed a bit based
>> on downstream (I think sm8250-mtp.dts is wrong and copied too much from sm8150).
> 
> Can you please elaborate on this discrepancy? I do remember seeing
> something odd when looking at this, but it seems like I didn't document
> it anywhere...
> 
> Thanks,
> Bjorn
> 

Mainly there's a few regulators with different min/max voltage values. 
For example with l16a, downstream has min/max 3024000/3304000 but 
upstream sm8250-mtp has 2704000/2960000. I also added l18a.

>>
>> Jonathan Marek (6):
>>    arm64: dts: qcom: sm8150: add apps_smmu node
>>    arm64: dts: qcom: sm8250: add apps_smmu node
>>    arm64: dts: qcom: sm8150: Add secondary USB and PHY nodes
>>    arm64: dts: qcom: sm8250: Add USB and PHY device nodes
>>    arm64: dts: qcom: add sm8150 hdk dts
>>    arm64: dts: qcom: add sm8250 hdk dts
>>
>>   arch/arm64/boot/dts/qcom/Makefile       |   2 +
>>   arch/arm64/boot/dts/qcom/sm8150-hdk.dts | 461 ++++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/sm8150.dtsi    | 180 +++++++++
>>   arch/arm64/boot/dts/qcom/sm8250-hdk.dts | 454 +++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/sm8250.dtsi    | 287 +++++++++++++++
>>   5 files changed, 1384 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/sm8150-hdk.dts
>>   create mode 100644 arch/arm64/boot/dts/qcom/sm8250-hdk.dts
>>
>> -- 
>> 2.26.1
>>
