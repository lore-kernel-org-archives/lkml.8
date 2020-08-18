Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CCAC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 22:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4AB620709
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 22:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597790130;
	bh=THYnNojmeApGZWQDCd7+XFvmlfKWUCnGTUlYF/aXHFc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Rp9+fvGll3hUt2nixAFdGqFunwXEXjuVBKF0REuNFuk1UGl8kfKGF+3KYcAxpY3VF
	 f0xCA6x2eLp5UTCMy4jaYGSinoO4rZcRzUTvG+kOvTAVocll8IwrfEuAnKObIT/0ve
	 Wt8yRg8A3HISCwmfCNOtbU5eireCUXup+0w+DG8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgHRWf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 18:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgHRWf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 18:35:26 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F173BC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 15:35:25 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id v6so17532090ota.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 15:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Mr7nvNbnFpkDy3c67K2GUvt19jvHBlTR5B229YPmeWc=;
        b=ieI587s2lCbcsLeiT84E3t030aDwjNCGA7m+ZXstcOffv9pxHgaXo09keAwgI2lVlz
         AVexnWNKkOyLvCbSHHziU64DSVPwmWBvpATk6rptYX1pJrEEqkDx787GhPKODnQkHFEq
         lDX4YgNrqnthAAff7E70d/3KC+eOBLgOSc7MI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mr7nvNbnFpkDy3c67K2GUvt19jvHBlTR5B229YPmeWc=;
        b=ueoPMMy17Z0ARJVQ2B7gtfzxLiKiYy0WhqpynkdYd0nH3sIbP6+bGIT1NHMCpoY41p
         ufBiArkEPcyAlINc9l+HK9aU+RbGVy/SHzXMKKVqkUWOvuGMTPWtG+3ibQM2zlbUlehq
         oqK5nRBbG1Uatn6DJyi40x3xSH53UFF09Xl/abU6T57MMKNpOFb411BowaUhxH3UCYyH
         7l+sF9agnewfOl101pamujyCRnYHyf19j851JvpMQY0g3GxJpvWG3A7OhwRzx4jOeuGN
         mOrKUhe0osP+hHolj9aYvnB40jA+y5Jhct5P8UCf7bCK7LTDqJ+hwmbFsoHhIW1L+h6w
         kfyg==
X-Gm-Message-State: AOAM5305cTjeyDNH83BeqLd9IJWAj6tjGgbfenT1LPfdw8hXBJZwG50i
        44p63uKIzhwJYzjp4G8PF+U0Dw==
X-Google-Smtp-Source: ABdhPJxHed7y1WInJW45MfAYzq216rSpen3N6XSLz96fFYRbqNqsU586B3z2o6mZmIPsHFU53xHStA==
X-Received: by 2002:a05:6830:2149:: with SMTP id r9mr17022927otd.92.1597790125257;
        Tue, 18 Aug 2020 15:35:25 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m24sm4155590oof.5.2020.08.18.15.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 15:35:24 -0700 (PDT)
Subject: Re: [PATCH 5.8 000/464] 5.8.2-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, skhan@linuxfoundation.org
References: <20200817143833.737102804@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <67569cf0-3ba1-001b-9666-4a13696ff79f@linuxfoundation.org>
Date:   Tue, 18 Aug 2020 16:35:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/20 9:09 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.8.2 release.
> There are 464 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Aug 2020 14:36:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.8.2-rc1.gz
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

