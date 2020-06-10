Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DF8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 830B52078C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591797582;
	bh=laPzZ6gJLtFtTSm7/lf3tmYLFPUBtkjMFH7TfiLZAV0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=UD+WaNzJ/Qwc/8U8YYMwFbYcSPhqKB4IcWtZr22AUXOiFiysrIYuTwa1/6ojDHEKJ
	 NZ6cqfdi7CPzbXCRsusLfb/a4+lOaG8WMGHC8bFp+3iab69KG53x6ovCZa+DMcPl+8
	 eFf1zcBlbnCFxP2JnUjfsVxkxsiU8AzwEc17uyWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbgFJN7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 09:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729620AbgFJN7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 09:59:40 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB03C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 06:59:40 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id e5so1744434ote.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 06:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cO10j57No0BaEyb9YSQv7ypFi+s1a2RxN3tcT3QgZWI=;
        b=MjKh9E1ka7ye4LxJWRV3NqhfehHWPDxlwuvxv4sY2ufC/iG+JGdWhKzB/DRjr3F9Fp
         EiGp9TPFtBivX4GgmFP5yCvhuGuF2Irkq/UEohgqBqyBh3FdX8fn/NrZ7ApVHMosX56o
         BYKOj5S/3aeXjlEwCDitWVPFYyHGW9tWAFTHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cO10j57No0BaEyb9YSQv7ypFi+s1a2RxN3tcT3QgZWI=;
        b=AO3KY7bH6bCCVO9kXd42Bs9vAU1E0xvdVxTs2lBGlzv/D9ekknvScaW4BmXVZrYuHi
         XXQt2Fa9Fvmm57fXr6mz1mnpyu+Cc50be0yp/acFW9SjTV1c3WmNONhmQPrYBTI61494
         8Cm+BPaN6WHm5YGCSL6Lw47xcqFSFGpNxpinVJUVKqewyq7TJTa0rhRphSx5QqazVqBi
         sZ8zcydpaTykPYU/SCKy9q2h5sSPUrt7YCM+CFxU6xRVrwl5/dTZKdo8P/0Sb5c3+Zkn
         bSi5hjOMn5afszs64fN34OCsGJGsFkm+me41kjUINfM21RCpnI0eKYgLx+I6Hiuivwdu
         BA9Q==
X-Gm-Message-State: AOAM532f9ezw6iibEcozMgSVX4DxsBTnHgGQWf/HIB3c1XwOjYhJyP8X
        ntNliIxzEPDBZTbaKfDmwHIkGQ==
X-Google-Smtp-Source: ABdhPJzf+YXQpMcXtYNdqQnAUdcSOPlqPUi+y5rAXH+kUMnPwYic9TBvFuTVFbkRZgVGTTsEgD0WqA==
X-Received: by 2002:a9d:186:: with SMTP id e6mr2755394ote.33.1591797579638;
        Wed, 10 Jun 2020 06:59:39 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z6sm15425oth.26.2020.06.10.06.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 06:59:38 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/34] 5.4.46-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, skhan@linuxfoundation.org
References: <20200609174052.628006868@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <241bc3fd-7bcd-1ccb-f825-f0b5acd6bb45@linuxfoundation.org>
Date:   Wed, 10 Jun 2020 07:59:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609174052.628006868@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/20 11:44 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.46 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 Jun 2020 17:40:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.46-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

