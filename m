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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E1DC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBCE720665
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599250274;
	bh=p5PsYk69/1nY/btveGKlBKyxN2l+heRl67biyKSd84o=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=0RycZTg73D+1pMuIQoqc1u7Co4SdI/aRb7y/BhHjhpOmsWsUetc0ubcyqna55qWj8
	 8GIeknBITz8rLYdnZEpFpAhYE2hru7QV4vsGt60aanq/TigH70Y/CpDeEosV/hNYIO
	 gN6w9kGeVH7p+7cIGVgkwMBsz62/kKREmIL5sNC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgIDULM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgIDULK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:11:10 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A46C061245
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 13:11:10 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id u126so8313303iod.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 13:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gkfQj1LIg6HcRXXs9J86JWfLhD4SCmRsNf1G3tDBlx0=;
        b=P7IvLEAVnnH7d7vnGK7NWb+1RvHrAYDrHKvZhkU5OSYDcQEaxt8qKItOMfV1GjNGxu
         Co0nuOrCGxRVPPtMlR6AEuKWHzUSjWRXGhTWevrq/eP1hEAmxqKf3pPpqME39TYFH8n6
         KTZpuEq9EMeHCWRamfC4ZMmUyzyACfrNPh2oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gkfQj1LIg6HcRXXs9J86JWfLhD4SCmRsNf1G3tDBlx0=;
        b=KNL/jrz9dOk4yyV9WkTI9l7ChonQ09uFOkmwORVD/U3KvDXk3BVo+DaLQ21cEkXlwp
         H0hhJGS0l4dfvKR2Sff6916vL4n5KoTdFvAZwFzLk4l9J3Enu5l483lFzihcxCi1YRkE
         948Gy860/VV8z5DArlfULSrTqIkSy4kvAJMs3iojsudZjnYDVabVUq0gvBo7XdmC0DZz
         vFlslRDvwXlUoNd5cEoCCo6LJkl2iU2WUC09cGRL6Gi4BSShuFTcev5XoKalE+HLN/Iz
         jcziyprpYXK1ZFYWbRWltTd/vcY7PjfhAsUM3qgXM3JtNWFNiTUPVgNe+p8fuijHiILf
         jd+A==
X-Gm-Message-State: AOAM53041a5C4SSah1igdbe9rsdLPtWUwebuFG/zaGacZqO8N6SD7ByI
        fB6ttf0JW7w0Ttk/yy1hI37wAQ==
X-Google-Smtp-Source: ABdhPJwS0WstSwUkafcH//c0oAjtxnJzWmxj/JrT3bbEFd4x5QUIjJRsFcdmMxtqKV7T2MpSrnDqug==
X-Received: by 2002:a05:6638:967:: with SMTP id o7mr10029350jaj.27.1599250269796;
        Fri, 04 Sep 2020 13:11:09 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u17sm3688254ilb.44.2020.09.04.13.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 13:11:09 -0700 (PDT)
Subject: Re: [PATCH 5.8 00/17] 5.8.7-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200904120257.983551609@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <46d98b44-ec5a-2f86-55ab-ac69e36c4c53@linuxfoundation.org>
Date:   Fri, 4 Sep 2020 14:11:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904120257.983551609@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/20 7:29 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.8.7 release.
> There are 17 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 06 Sep 2020 12:02:48 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.8.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.8.y
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
