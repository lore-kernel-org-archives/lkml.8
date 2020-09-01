Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7C7C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7563A2078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598998806;
	bh=75WLpz1kCcV95Q75jYebiNlbKPGSV2VJpE1cN2EJGGs=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=YDfpXfNMD81HFahfD3vI7iuhAf3Heuv0fT7wM4zYFYZuepDR7y0cjZU7K4+k2kLdE
	 gLPqUAqP18NGEOvQv13dnDiwBfmR/gzScrw6oTKRs5VhjgEwi4wWiBwROyu8/d1DoH
	 rgpbV/6UGX9U7lzCVMmZXfkR4xAJIElpTO60AiPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgIAWUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgIAWUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 18:20:02 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AADC061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 15:20:01 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id u25so2579728otq.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 15:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WNfZAUxXAABQdDQchDkXXMD/igGrhM8AWkqaIapbhzY=;
        b=DjpZ8Pz43XQPA4tMFhKjxeMvsZnmgo5TZYK6EQtknRt18NBR+Z1CPP8FvDanN1eqrI
         5RfLYveqvbJ0UoMN3poP3t7ptYdA0ifx2+onPY4KHHIpho2WohvUCN5+WBn/l40YwGce
         E7tiPyJ3v9nH2j5rdWXzC0IkhPmDsYx4ne9q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WNfZAUxXAABQdDQchDkXXMD/igGrhM8AWkqaIapbhzY=;
        b=NkiuaZWAi+GhlOJhpgHAibRiHmCl4x7hcZAHbH2umEAelshDeHQYLn5V01jU33P3I8
         KT20Z/QaH5M0ycYqY7i/vEqQGyUOAAgIWEyFEDUtyf22RZXA/p/FaNRUa3yLJykoBAoT
         AiLcFwkroVE7qos38gTwVFsbnQLoBQcA7uPE7SjsIXxpiAakRT3g9BdotlRo1/m+uOJY
         lessWuliG2YL35sBlHqUeDySRoCcwWYUivVZu/MHCddR/xBMNgdWp8lE1wOrpNHC2bCG
         kRboagt4E1TuKYsBwHe+IaP+Ahfa0ReL6KQKjDToly5ifz/t6KInQ2Il9VDbQKC+DEa4
         Kmwg==
X-Gm-Message-State: AOAM532QrsA2Xp4tIwX5KVIJ8FqjJ0Jxp/L228GOAt78S8OFgOny7uyL
        QITW8Jp/igwi6PFrC/1hYxqxqw==
X-Google-Smtp-Source: ABdhPJzVdMILrV31cHU4FnnfEnKxSF+tr4R1UsCYj9MSPtvicCYZx37ciIkB9EknaLKLbehoAOgvqw==
X-Received: by 2002:a05:6830:3097:: with SMTP id f23mr2752664ots.305.1598998800742;
        Tue, 01 Sep 2020 15:20:00 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 3sm419299otu.46.2020.09.01.15.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 15:20:00 -0700 (PDT)
Subject: Re: [PATCH 5.8 000/255] 5.8.6-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5774a892-bf17-c759-0616-aaec4b740b9d@linuxfoundation.org>
Date:   Tue, 1 Sep 2020 16:19:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/20 9:07 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.8.6 release.
> There are 255 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 03 Sep 2020 15:09:01 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.8.6-rc1.gz
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

