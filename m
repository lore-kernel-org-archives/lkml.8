Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A167C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 01:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C139521973
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 01:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599615922;
	bh=rq9yO+v0ojlQGFY7yuXXq6A/xBH0v8doF/fVVL2tJIk=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=sACEsZWr1LJv92xEbvvr68ErjiCjAYhOd90uq76hsa9QHjIeuHsW/5V6YtFwFaaHe
	 krb1LFPnsCLz46akFdeiN/INR9ldCyEgkSEIeoyWdFIr3EpZmKF/xvh+Vk+PKkkHca
	 jI1Xr10UKGvUlgGvf8Gt90nRouWU+bqEY2pbBlYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgIIBpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 21:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgIIBpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 21:45:21 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C3EC061755
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 18:45:21 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id m12so986619otr.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 18:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bpK281isRf5gVgnXwTUWT0hn9s9B4RkkPUa9f71NFqw=;
        b=Gt2KdmKKpZiPG0ag5WURFB2PAY+484m4T+mguV6iGLsOapG3xL8SeLmO6advSguk/7
         TIexQmi+oT4AEKZljrCPbVvYy99DCHd76PYrl/HXPOH1lUYi5phLAwF9J+neHkCJApvt
         nnAyem1cptrnHYekemViSnxAmmyIsFie823tI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bpK281isRf5gVgnXwTUWT0hn9s9B4RkkPUa9f71NFqw=;
        b=rGNERipY1W6wU9TqAiNA1AJXrX0euKCTINaycf+RQ6kThXli+boBr5TPpxC6+DR2Pf
         nl/W8r8Q6QydzJKh70Z/PDnYO/7y9+q6nZw9j7GdVKZjuA1b+F7oyhnAwkKmRf6mlp3t
         ojomDuJCoFeTkT9roNf7pcOl1qxASKf7fI1+dJWFU+Wo61ReUEqWf9BEswCWlcWy4HoB
         SldyWExm3UuD7/nXIdo/jWDLfAscrXgWSGNRrpzedOzbPvOrJaH6Ek9087yYI0k3sNzT
         9AJMtl4oLYeihT41rKVUsFsu6WG1en8gIQmYlxA67K6HKWvgECi8fOBoLBJX/G7UpoCf
         Ipfg==
X-Gm-Message-State: AOAM531zpkkp2LxJP/xrnZ3K6wHMr5MaG+tDE5dq39UOtkd/WhoOojQL
        ttRipWCUxRAqGK4lwEZ4ESazFQ==
X-Google-Smtp-Source: ABdhPJwjD03FtbLJKe25UNa5gXAKc0ojHLVlL78dyRhzyTdeqBt5GA6EknB//XJ16qIabfgkNuNCCA==
X-Received: by 2002:a9d:8b8:: with SMTP id 53mr1367208otf.85.1599615920310;
        Tue, 08 Sep 2020 18:45:20 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k19sm179508otb.45.2020.09.08.18.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 18:45:19 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/88] 4.19.144-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200908152221.082184905@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d20738dc-2fb0-450b-c594-758346d740b9@linuxfoundation.org>
Date:   Tue, 8 Sep 2020 19:45:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908152221.082184905@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/20 9:25 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.144 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Sep 2020 15:21:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.144-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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
