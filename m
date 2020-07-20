Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8EEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D7D4207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595288615;
	bh=gbwiPtXVlQOKl71WOR99mI/+PFovderhlKo4pARvYkg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=YL3v3fOcTbwzSxCyCY2RX9rqGvHR1I2k9fwOQ47JWOH37bIjSuLIaT8PQuvyu329w
	 E9hfMFxiOV4UqzW8IEuCP2essUsxLguB8Nlh1jGqMjsd9Xr4uhIaKLgVXXDMHD1klu
	 LOP+zQVcIVT74GeT7zHNS6N0w/zR0MgxKgrIqNdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgGTXnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 19:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgGTXnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 19:43:33 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F581C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 16:43:33 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id k4so15794135oik.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 16:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/kU9asGm2tLYrzftHBhHd5vQnhrVpYxep61O6cw23Rc=;
        b=Dz+Mu9yRZguchCVf0nhPn6+/kl2yl7+g0aCTWbD29Oa0+SDqsTAbZBCjwYokw0Yzi4
         RKBgLnq9HjLU8muuqhJDYtKhEPUAOxvh4EOupvMrLYuL4FUmoHQNd46rec3C+96CNWTi
         XUhe3IN30/FzvT+ins/PB92dYnuUD39cX3pkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/kU9asGm2tLYrzftHBhHd5vQnhrVpYxep61O6cw23Rc=;
        b=k2V87FNZYaLD4COwsK/bK1QzzxxS9+eiSvzx0V9V/lLFktFk55qDnAbLiKk2eXxPXr
         XJhPbRmIuA73ActDxcC+gQmtuhekXXSq/Yb7zsKQGjYDTX0b4G2BfEesGzLS0WKSsEr0
         0/kvQGaZ+qhEKXreUcOgFiqkLuXly9mTmdRaZ3G+li5Yx2E7JHrJ+15jg1UX+mSL/40F
         wd7Cp/e/MIg4L5bp1pkyarOMB/nrQRd1Bv4TpOcEOFDMCLHIpGF58edOKAJzlVRZm/xI
         d4c0Kba68/I+gpmUKYIora5y4w3pbEuSldHxH+v0bIxb6rqxHMddXPWUzRjXvda9REzN
         ZB/Q==
X-Gm-Message-State: AOAM533kvKfwFXjZ6/2O5DhnHutrKvpDUybHMJa8fF0ygEmrW0cd0dMi
        02rTR9SFw5MDXw03JGnCPRMAyiqu9vE=
X-Google-Smtp-Source: ABdhPJyvtb3xprhLdnmQ0RVq3WPbUBUc9wCsvRaqzj4peBIHuLR8wwU2HQtHh7NaT5O6NKhvv4M3vQ==
X-Received: by 2002:aca:f05:: with SMTP id 5mr1185144oip.93.1595288612492;
        Mon, 20 Jul 2020 16:43:32 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o84sm4297607oif.55.2020.07.20.16.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 16:43:31 -0700 (PDT)
Subject: Re: [PATCH 4.19 000/133] 4.19.134-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200720152803.732195882@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <910415a1-0280-0f05-7dd1-46cf39580445@linuxfoundation.org>
Date:   Mon, 20 Jul 2020 17:43:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720152803.732195882@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/20 9:35 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.134 release.
> There are 133 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Jul 2020 15:27:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.134-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

