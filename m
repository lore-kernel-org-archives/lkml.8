Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108F8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 22:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD926206DB
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 22:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591395373;
	bh=ouSRtkfJwZ+f8xfpomDpxEQ/HbVrrJt+dertMmfomuM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=oLRsQeUC1BOr/yl8RsW4HW0Bh/0mf4OuKAlFKkB13C2xzqnjq2LPM/JR72eoHK0Jd
	 LOzVZKMLYvA9h2M49Lkq2RcljPs69gYXbFYd+0r2FDSuhk5ibAwaUNy+TJ62QE6aGM
	 voOubD/w2bOHHDqmudOqOTmtRg7THL+uGYEhCqVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgFEWQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 18:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728611AbgFEWQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 18:16:12 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9491C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 15:16:11 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id c194so9538308oig.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 15:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ekLpFzBqNwOuTQsawmJlVyGtYM79JpHBNAHjc5cJoYM=;
        b=Rd/UwoBCFhO7dS0mm77XO3/TFZK2GF8yR5H6IAR6AoDSsLlxbYRvDJqOwUmaUcURVi
         Jzsvo9/nCM64Z1qlf5X+5uJJhFlRrA19pzAugG0g4oGlZm6QSXMpEoYGCvXeGfM0mJpq
         aTt6UJCxF2goAYZQXp8kLUgmXrOvy/X5Q19tU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ekLpFzBqNwOuTQsawmJlVyGtYM79JpHBNAHjc5cJoYM=;
        b=sLUXh3aDZmDNqDgMOCrqoncjwP5fIWVRDztq4NRbvj+7uw4PnKzEh02s2nMlztd93N
         uQN5PRX7qbBF1MAyIuztOFfrubgcJ/rixrexKBuK3FFkX81PMleqVsBAyQokhlKdLdC2
         wUDRDVVX0UEHiiVt2A8Zw6Nj3tp8Gf8i9VojTJUWkM8kxm+rSS3swJ2Zk5IDKtEpu/VK
         /CnNCp2yV1fJMZ3o5rwdjix2tFH45ngsn6dDZhlexyaDjz5PRPh1JLIp8/xllnPdqVyz
         UriQqCgXMKSFIILR5fh+r9sJr4x9Kt+ENQR/A0phDb41kDQi4x2Qi268xfxvtw+BRTcS
         wJPg==
X-Gm-Message-State: AOAM531yCK+hd+77QhvD9H0r55J1RK21H0NOozGnoyaV2jNhVJwpe1pq
        jfK/4ZfLkk7skEK3zADHduQHg0NADso=
X-Google-Smtp-Source: ABdhPJwmKrFIwY+oBUlJ3CciDrWIsAIN0caHXaTutLGctrVfOOIespo5psnZh+By0FHJDlCST8iepg==
X-Received: by 2002:aca:3008:: with SMTP id w8mr3380358oiw.157.1591395371303;
        Fri, 05 Jun 2020 15:16:11 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a3sm973613ool.43.2020.06.05.15.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 15:16:10 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/38] 5.4.45-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, skhan@linuxfoundation.org
References: <20200605140252.542768750@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b42534a8-64b6-2d9d-ecb0-47ecde5f25c3@linuxfoundation.org>
Date:   Fri, 5 Jun 2020 16:16:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605140252.542768750@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/20 8:14 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.45 release.
> There are 38 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 07 Jun 2020 13:54:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.45-rc1.gz
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
