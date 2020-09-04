Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41E9C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C7BF20665
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599250214;
	bh=yYyih0tRkyXvxF6zrp5M82q33ztuOVBW3TzBHsnDAx0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=h/s84gvATQw1QWQYVcRrptJDxPgA+l2DWTmKJt+neQ3gnR/MrIpxAOkvo+8unB/gZ
	 stAOCbdskFdxlVf+RKa2FTF6ZOzymS3Lw27X9Oa7L0TTL1Xpzrw/iSdMm2K6t3G8i+
	 k1OU+r6XpSk7z0YAcDlf0Pc2BceN+GJ18vzQ/IOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgIDUKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgIDUKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:10:10 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43BCC061245
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 13:10:09 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id w3so7437961ilh.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 13:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0Jg9VU73gZ+7YHgdtpsBvolMRud2ea97/XzW1kHoQ78=;
        b=drgRPsaTFf2IoqCMs2qQUUD6T2aRkWsilesRkIJmWBhZCw+Z7A+0mD+fbyls5lYR8e
         V3I5boO2IbRk6BAsIapKarliFDFzI41FdDLgQWvnS3oNw9wuQDPBNPaRJyIk/LPNahTe
         ovLxfoINDEpXd12w5eforYLmFXjYmP5u1BaxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Jg9VU73gZ+7YHgdtpsBvolMRud2ea97/XzW1kHoQ78=;
        b=Q9OoKP07H3OPP/LZCGCWPu5CurEENUWd5j25mwnAypIigTroqZTNGa7sF6WAN5eKym
         AFvm1mBhnceMI5q5eniqAgdGb4L/8DdTZgAx00Rv0mEZKEK2Uef38BA6WC9q+ZRKsdU0
         AkJzoI6rmFPq6s9kHne/LPz0khShUgG53x8akTclro8QzGd+gV8LWFTL0JG+CqktG5Nv
         7EsDpJ28kYJA7g4JFnNZYL4TodJmfDih6FC2/MKfOamUGH3tJSH6grDgjoIwydyJkRBM
         jfTyhdG6cyVYDnW1g2d8HlpRdVgGG6f5lcChrzdhl9AuhlIC0TpEUdJwsNsDAazE71Qb
         pHGA==
X-Gm-Message-State: AOAM532de1AmzSeXHY0JFR7myov+up4GU6HsZ0IsAmkBfnMIFro7mt+E
        bVei2oD23QOprJYXywBvsfrc1g==
X-Google-Smtp-Source: ABdhPJwRZrm7hpuD3sortxqwL+6h/N369d/kvC0s0f1ETskEGIAlcADB7xD3nvi1nzK3Unx8NNos3A==
X-Received: by 2002:a05:6e02:146:: with SMTP id j6mr9828929ilr.132.1599250208332;
        Fri, 04 Sep 2020 13:10:08 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h15sm3465334ils.74.2020.09.04.13.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 13:10:07 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/16] 5.4.63-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200904120257.203708503@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c9508e8f-1fb3-3bc1-8006-dffad4923026@linuxfoundation.org>
Date:   Fri, 4 Sep 2020 14:10:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904120257.203708503@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/20 7:29 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.63 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 06 Sep 2020 12:02:48 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.63-rc1.gz
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

