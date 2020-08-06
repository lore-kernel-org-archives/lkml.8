Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB6EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC87A2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596742354;
	bh=WY1+dOt26uIaP201SRKCA+QaWmdfpRrtpMXlsv2/3E0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=RIhZZrn7bbszdTgG16L+thm6xHhHeCU3CqEhvCgHPeyq4NJJ2R8DMp4JX2ZQ6RB+X
	 ipr+Ldf2mbBr3MqzNCx2J7YaoLz6beUnBG2KacO/HtJ7cluuMY/oUvKV/hHtKJxVg0
	 WQDrqHk88+yZ3SLuI2cmtsbp9xXiJ1vbIRVJoDz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgHFTcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgHFTcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:32:31 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D446C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 12:32:31 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id s190so9794954ooa.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 12:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NMtEtRWa1Ph/hgihSbCj1KJKI/E8qY3VELHB6UZTdgc=;
        b=VCGYUSclUfOZl7vC4H5liHx7E+/cNBrNj8GBNv6sZWqT0A7vpBxz4c73r38xclb+Gj
         bVJoGbc7NtmxdmZDC8jaefAsfm2fwIx0ZDmnPVLU3nQC2iThAKh0RRPICZPlUAbSpW5t
         1Gaoj78H7hEu2Tw2757YUX6ErwruQX64fL4Hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NMtEtRWa1Ph/hgihSbCj1KJKI/E8qY3VELHB6UZTdgc=;
        b=YPPmtCiQHTS6NI+sk10Zi+wAsWEuucK337ZYmV/3+gLGLoejdoAUBWTdBejjSHWwmV
         AI+wJTwM9LluErsQFI7BNUMc0Uygome3jBkgbfRI1oKEPEoRLDxXLxbZCoozK/ZdmVuL
         URZeZGIH2an7zOi/Jpk06EZ8/pLq5fQRN6i//7pmZK76QQW2nunOMOPOBuMECRLGmZ0N
         UpsTVaOY82qmsCIx+B46QJBnXc0bQudxN7yLfD89FilwZtgAamfddNCUBbJrbbeOPxr0
         PmCx2I4j7NLOYc+Q6md02y6ss1GePbF1njWIUvBvCwPtpYMtwiyQH8MlUCJt4HbPCltw
         uZyQ==
X-Gm-Message-State: AOAM530z+LwG4etyA44GxSzPM+dQwg5g0LhKoED39tG0lh6oXAGdUVEQ
        Lxr5fqapBW/rtcYdjGjXM6jcfA==
X-Google-Smtp-Source: ABdhPJxStsoqhs60G3cKrgFfrCvuP22hIVoczjy/r8HluulCmLb7pGDkNZlNxE9LzC09WdQDTmNF+g==
X-Received: by 2002:a4a:e9bb:: with SMTP id t27mr9422822ood.18.1596742350342;
        Thu, 06 Aug 2020 12:32:30 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n26sm1293933oie.1.2020.08.06.12.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 12:32:29 -0700 (PDT)
Subject: Re: [PATCH 5.4 0/9] 5.4.57-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200805153507.053638231@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <cf890bb2-931b-7906-21d2-a263e863590e@linuxfoundation.org>
Date:   Thu, 6 Aug 2020 13:32:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805153507.053638231@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/20 9:52 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.57 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 07 Aug 2020 15:34:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.57-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
