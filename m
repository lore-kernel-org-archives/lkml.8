Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDAEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 22:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 161432081A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 22:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593036103;
	bh=e5aZgH4g+EmRFyOJbsEZkbQTICt16PmIuic5BpUpnjE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=er9OMGHiPK9WVMwQUx02wZmzdXN/BZbNJetRrjrmYj9cwg658eNLYtYWEma9epK+1
	 XoxxE4u/eQkpzSRB/XOQH6tNq+5HmOQx0pb1tEzvrZGajGONyZLrjZpP8Lrot4pa5Q
	 3lxrCvRDnN3Ps823OfyQPMfezFXp8S3nFhpfg1eM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390089AbgFXWBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 18:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388217AbgFXWBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 18:01:39 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8552C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 15:01:38 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m2so3397753otr.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 15:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yOgHGV8TRMzo68skBN0k7YZtFC8RQZSVK1V6TRXSLNA=;
        b=CS+j/Mg8UAUzneJWwG2tPHnivDeZBXQykN9FqolFmN+Z1gLa3sOxDMf4gQkTMbkEA3
         /CtGdFAOPpFau0j3yN6avw2V0RBRwvX4o/qodlbVOF2ZwW2PaP1SzXypXz3+c8x7Ww4Y
         oAiezN4zuBzgdv9pJOjylXhVx2BQrLPs1Nhzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yOgHGV8TRMzo68skBN0k7YZtFC8RQZSVK1V6TRXSLNA=;
        b=sJ30iAp2AzW9cnOmYd95vE9ZgAzL7wZiq0sbQQujnu4F/uH7MIvT1C9PKwCVB3g7bs
         uovIzDam1EiB61rmslfOw54wbFd6zaLtCLndMA5vYvdH/jMbUKONWLWOgC/8NtmqHde2
         fY42446qhxMILV1DtrtUQv4LbFTZscsmUuDuAlFB0DPENXixqI9GL2uRpudHApgMkCzv
         IIpJauCFB7+dYsTtHdiAKJIywACrer6BOxilPbUjwsgNmlOgcsQ0HHH4m45ikf9zkn00
         tjpjeE0YNW35IX4RvoQJE0CAycvl+O8023IC3QLE3fNjjf65PL6cU+0Vca5BlkEwKPBq
         +4vg==
X-Gm-Message-State: AOAM530W4T4e+vnYUbitO1Y+e0Wcm2BdTFqeHYlWJXgSamfq+0e2FBoZ
        N9BVBaxNhT/hBVIQYOSoy5KEPQ==
X-Google-Smtp-Source: ABdhPJz5NFAZZ18jqTNCmM2dfEmfknZHF3igSzFZERbZiQwVSmVJpQ8I9V6787DtNUl6BrMqMc3ITA==
X-Received: by 2002:a9d:6d0a:: with SMTP id o10mr11692730otp.160.1593036098206;
        Wed, 24 Jun 2020 15:01:38 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v24sm1866512oou.42.2020.06.24.15.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 15:01:37 -0700 (PDT)
Subject: Re: [PATCH 4.14 000/136] 4.14.186-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, skhan@linuxfoundation.org
References: <20200623195303.601828702@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e66287f6-6b0f-d136-7874-21cfb00cf15f@linuxfoundation.org>
Date:   Wed, 24 Jun 2020 16:01:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623195303.601828702@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/20 1:57 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.186 release.
> There are 136 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jun 2020 19:52:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.186-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

