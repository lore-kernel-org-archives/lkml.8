Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBC3C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E7A120738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CJ8JSST7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbgGMRBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 13:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729751AbgGMRBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 13:01:04 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B943C08C5DB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 10:01:04 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d27so10487862qtg.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 10:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P0iBC/WN/QpVqecFxZ7dZUdqk1Yv3dfke4IJQgmo7vw=;
        b=CJ8JSST77FVzlY08ahfSo7BV8d1SMIbx5VuVK6KmkCScq6LqOIjMa8dRRTN4zZoB1S
         RX+njTlua5cC2H4AevbdIVNkPHbAs9CuUEunmPpq+hxDiznnIMmwfX9L654Y+y9RVHyQ
         0swjRb04Db0kVLVzf28MFtF/rhv5R8d2CsVVh6xy/8H3D8z1kr74BgaTFJ/1ByryBi5u
         3EfuxQhHopgEIbrC8ZXONRvvNty0Sjhad4ww5IS38vCOJoN9wIB719EkukFf52ZHwBSH
         h9SFmWdT/Fg7614YUtwmkK3crRhW3sYx83BfG71otxqKzYSxRt4LrOWj6aJcXltmgO7E
         t8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P0iBC/WN/QpVqecFxZ7dZUdqk1Yv3dfke4IJQgmo7vw=;
        b=swmj+CCkHDVsBsVIacTFIpk8b/6YOSIq2OU/tziUUMocYLfyhcVTTwuLhtdVFQGefG
         BvEbQMF2IHtyVg8vDOP4Lp7v5cZGl9fkf8NnblSrozCfXgEQ9sNDlweF8AvBgPKCeAjo
         Q2QqpL6YW39dkQgE2DtPYc78jZsvrVd/ePhhcYAZ7k8Pkng0s4dBEvllcCkPwENjNc+E
         i7l/OinmA3QjUuZCVE5VRsPdB3nvSr4jGuLOQ8Ft+w4EwtwLflc3DsmbULs+/eVKgzv7
         F/sIE30I9CD0KMyNCIoZAMKYQ/puXFMg6DtiXtzquQsfHkYF2W7Ams/D97TdWxl2h7GH
         Y8Og==
X-Gm-Message-State: AOAM530t3H2yXnfplTNUSjhWUaYnO3Ogean1U8cvwbqYyMF9GH/uxHX1
        1IPiK2/9QC1Srx6cqLAq1LXDJndwNFw=
X-Google-Smtp-Source: ABdhPJyhlffBbLpO9vlLtuMxcv6sdBRtlI41L28L7FXDX7Y87Wn4OqCeI/zqveRdQJdN2muBVmbeEw==
X-Received: by 2002:ac8:3a27:: with SMTP id w36mr304912qte.196.1594659663213;
        Mon, 13 Jul 2020 10:01:03 -0700 (PDT)
Received: from [192.168.1.92] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id z18sm20097156qta.51.2020.07.13.10.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 10:01:02 -0700 (PDT)
Subject: Re: [RFC PATCH 1/4] dt-bindings:thermal:Add cold trip point type
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200710135154.181454-1-thara.gopinath@linaro.org>
 <20200710135154.181454-2-thara.gopinath@linaro.org>
 <08503e0c-c8db-6d03-9692-5339dadf6c4f@linaro.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <2b845792-41f0-7fb1-122e-a77aa70c9a3c@linaro.org>
Date:   Mon, 13 Jul 2020 13:01:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <08503e0c-c8db-6d03-9692-5339dadf6c4f@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/13/20 11:05 AM, Daniel Lezcano wrote:
> On 10/07/2020 15:51, Thara Gopinath wrote:
>> Extend thermal trip point type property to include "cold" trip type
>> indicating point in the temperature domain below which a warming action
>> must be intiated.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/thermal/thermal.txt | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
>> index f78bec19ca35..1689d9ba1471 100644
>> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
>> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
>> @@ -87,6 +87,7 @@ Required properties:
>>   	"active":	A trip point to enable active cooling
>>   	"passive":	A trip point to enable passive cooling
>>   	"hot":		A trip point to notify emergency
>> +	"cold":		A trip point to enable warming
>>   	"critical":	Hardware not reliable.
>>     Type: string
> 
> 
> thermal.txt should have been removed. Perhaps, a patch is missing. The
> thermal.txt has been converted into 3 yaml schema.
> 
> The change should be in thermal-zones.yaml.

Hi Daniel..

Thanks for the review. My bad.. I will fix this in the next version.
I can send a patch removing thermal.txt as well


> 
> 

-- 
Warm Regards
Thara
