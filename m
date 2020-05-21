Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D249C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 22:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18D6420748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 22:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dEpj6/DK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbgEUWkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 18:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730620AbgEUWkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 18:40:00 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E56C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 15:40:00 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id x1so10768871ejd.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 15:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DUPhOAIuTJ5xRLAJLrPs5R/yX2Kz3PPtLVmeKSOmg64=;
        b=dEpj6/DK0orAiDd62wDopz6yDw82sY7oW+LmYMcGo7qmJSQdB7DJBVhDzpRMLZwHXb
         1Ack+ZtR+ymImD4q3b7A1H3CdA1GuzqBuPMuw8k//lZbveH6Vb9SF3g13xSxfkQAxqaX
         OD5/62fPQe98pieHNxrY8EhjgKRNh3pmBX7+2lTWHELUcmYoaf8u3WIOfJWbsQ3trKD7
         kQMcsBOsq89wX/2/RiymxaI15nawYm1g8LgI44nw+aKY0vOsja6Cp0ctK96y2LqTYw4N
         DEE1wShdy0AIErZz+Cw6OXnFwau/3FC0bKbhZ3RY+7apTaK06vCvhiMBNcIlyFlOmCc1
         2zIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DUPhOAIuTJ5xRLAJLrPs5R/yX2Kz3PPtLVmeKSOmg64=;
        b=p8pcSdc0bwZyEYXw4kOYPvCzwmlcYEE7yUZE52MZlmTIVRxK03Dyssim0KmzMHinGx
         AKEIayXSLbXScixUzwHjegpH9HQ+Bj0ZepW5Yt/6LMe/NAaNAmBGrPZn/HsCzxBZnZ9E
         JWGm9ZG5AmceknqhqVE0VqeRF5fx9WTkxr75nL89R2z8N4ef4ou/vi3frlfyQlX2/MYd
         m5nTjGP35pFagAV/61yUYLDfoNWyRR1AVaplgDGx8QatK3HbTyuoV3cri2OwRLEFTzeb
         iFnRMwkA1I2/puZ1ih+GVS/Ys+45m5Wznjzcx8utEnGnoRC+ZQaHytlAQfAnX3Mny60F
         80Mg==
X-Gm-Message-State: AOAM530ZyNZ7R1tl/5bJ9taemFm2KQGrvSLpVlGmFsIl64EKkN4T9rWy
        j5KwuYNJ4vtvZFQqkz8zbjo37b1AoEiOMQ==
X-Google-Smtp-Source: ABdhPJznjwofg+qdPN7YqjP44PDn2xnukhn8p1qlycSbyTdo6B54Aa68m4LoeJ987kxtuKx71OshfQ==
X-Received: by 2002:a17:906:2e4a:: with SMTP id r10mr6068225eji.116.1590100798553;
        Thu, 21 May 2020 15:39:58 -0700 (PDT)
Received: from [192.168.1.4] (212-5-158-12.ip.btc-net.bg. [212.5.158.12])
        by smtp.googlemail.com with ESMTPSA id q3sm5831341edn.91.2020.05.21.15.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 15:39:57 -0700 (PDT)
Subject: Re: [RFC] Make dynamic debug infrastructure more flexible
To:     Joe Perches <joe@perches.com>, Jason Baron <jbaron@akamai.com>
Cc:     Vikash Garodia <vgarodia@codeaurora.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200521132816.31111-1-stanimir.varbanov@linaro.org>
 <20200521132816.31111-3-stanimir.varbanov@linaro.org>
 <c4cad4f243988d214208a4903aa311a64f9b4531.camel@perches.com>
 <5bb4b918aec3c77038122588ee642ae4aa2a09b0.camel@perches.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <bb5ff55f-dd97-5367-8f64-673e420103d7@linaro.org>
Date:   Fri, 22 May 2020 01:39:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5bb4b918aec3c77038122588ee642ae4aa2a09b0.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe, Jason,

On 5/21/20 11:06 PM, Joe Perches wrote:
> On Thu, 2020-05-21 at 09:08 -0700, Joe Perches wrote:
>> On Thu, 2020-05-21 at 16:28 +0300, Stanimir Varbanov wrote:
>>> Here we introduce few debug macros with levels (low, medium and
>>> high) and debug macro for firmware. Enabling the particular level
>>> will be done by dynamic debug.
>>
>> I'd rather make the logging level facility generic in
>> dynamic debug than prefix all formats with what could
>> be non-specific content.

I like the idea. To be honest I researched the dynamic debug for such
level debugging facility but found it will be too complex to implement.
I guess now when you catch me it will be better to add it in dyndbg ;) .

>>
>> From a long time ago:
>>
>> https://groups.google.com/forum/#!msg/linux.kernel/VlWbno-ZAFw/k_fFadhNHXcJ
> 
> Hey Jason.
> 
> I believe there are 6 bits left in the unsigned int
> use for the line number and flags in struct _ddebug
> 
> Assuming the use of a mechanism like
> 
> 	pr_debug_level(level, fmt, ...)
> 
> would you be OK with something like this to enable a
> level or bitmask test of dynamic debug logging output?
> 
> where the output is controlled by something like
> 
> echo 'file <filename> level <n> +p' > <debugfs>/dynamic_debug/control

I guess for bitmask it should be?

echo 'file <> bitmask <0xn> +p' >  $CONTROL

> 
> to enable dynamic debug output only at level <n> or higher
> or maybe match a bitmap of <n>
> 
> (modulo all the rest of the code necessary to use it?)
> ---
>  include/linux/dynamic_debug.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index abcd5fde30eb..616dbb2b5921 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -38,6 +38,8 @@ struct _ddebug {
>  #define _DPRINTK_FLAGS_DEFAULT 0
>  #endif
>  	unsigned int flags:8;
> +	unsigned int level:5;
> +	unsigned int level_is_bitmask:1;
>  #ifdef CONFIG_JUMP_LABEL
>  	union {
>  		struct static_key_true dd_key_true;
> 
> 

-- 
regards,
Stan
