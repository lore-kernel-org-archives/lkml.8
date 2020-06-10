Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6CDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6E19206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591794841;
	bh=tfRNlZJvBQsNcmSvWh4I5h6tAlf0IIg6o84QjF6DzUg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=iKb7HL9KuBSiHKt62FKD7/m2cJ2T6VH+PjgNAygr4jkVV9yZNrWAzTibn89CF6/so
	 TAjDeUP4lsk3Y/BSSJdEtmO2byuE9gMAGqpbFcuB94eqfh3hR9t9YCzjImUxJLZbft
	 UyhaZ8dRQEeVQo3PP2YJ+qZ+4/L5GeZ7MUAFzXlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgFJNOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 09:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729222AbgFJNN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 09:13:58 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB70CC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 06:13:57 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id v13so1648788otp.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 06:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=njgzj9HQCEKqgSx9E2K8l281h/MJdRNifxNxBU5g88I=;
        b=a8Zlx9OYBts380NOVCALgu02QeDq+X3BIpM9/p+70QnVNofe1BBU22C+vn2CTeKFWq
         hlrZxtNxXNN9Hq5+f/unaBA98b4O75CegDo+VLzqMEXGDLKgWNrdnnbsF08hVtmrsxz2
         pp2qxVlvt/awq3w6CTDAx97EdNRT4uwa9KpPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=njgzj9HQCEKqgSx9E2K8l281h/MJdRNifxNxBU5g88I=;
        b=rGolonuGO6XJLNkllwgW2PBeYs6VXczKSttlvDMG+9Y48hYcs0lPahScREqHSkh7YS
         BvY/busn90+0iLDmsdl9aTJmBVZhNl1HiLq/7CYUsJKaORbnAz+TEWHQy69wDAmG5z15
         fWjjGJRCKkD+VniROvBimZbOZqiha7f0LOJgu/f5kt/yNPUGur6PjE+pacWpHn+0dN7G
         lEt+DUAR/Plz7PAhtptgk64bujHPQxfKbAP8oKXi0QRaSkEEUgfGIR7nQfKGmA6H8MPF
         WWaxG+1TV4YrobxKs7yRAHXoKuBLde5nn59VtGt8TBrXH34t6xx984bRDCWF/zSgI89X
         lKfg==
X-Gm-Message-State: AOAM53313mC5+3yvMiUFReyPGQAw627niGC1RxGOO6kG0O4EGYdQsxlA
        AxHXrA8vG/+JO+Vp/YUm2/gGTA==
X-Google-Smtp-Source: ABdhPJy0acUQrvKR0gU7PJ780BA5BZUqpa60MVgJ7NmqHt48tGw1j8iQ0jdUfoBz2/PlWbKgUbdASg==
X-Received: by 2002:a9d:145:: with SMTP id 63mr2444915otu.141.1591794836904;
        Wed, 10 Jun 2020 06:13:56 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x32sm2841859ota.50.2020.06.10.06.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 06:13:56 -0700 (PDT)
Subject: Re: [PATCH 5.7 00/24] 5.7.2-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200609174149.255223112@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1c3f7784-3d9c-4b40-7e96-99f230f251fb@linuxfoundation.org>
Date:   Wed, 10 Jun 2020 07:13:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609174149.255223112@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/20 11:45 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.7.2 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 Jun 2020 17:41:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.7.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
