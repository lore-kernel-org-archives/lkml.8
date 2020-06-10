Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AD6C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1B45206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591797120;
	bh=FO7RsyaUEx43/J7tctMgmBtj/nqhDVrP5YnsEE6aoDs=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=C3U7P6HfkRTkPjC6n6IhkI4Al/3PZRBCnEaYVQ9tzRUYFOuwbtZFec4n0LbUCmdpc
	 lmdMkOe/KAkwI4SBAI9NcFQbQMb74kA3gt9DS6Uh7RV5YsWsmSi4bzBNoBrfOHkHRe
	 1ghn5gpDHTwA8kzaErujTLG5PUxbKyyENs7Y6MRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbgFJNv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 09:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbgFJNv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 09:51:59 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3FFC03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 06:51:58 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id a21so2087310oic.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 06:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rw9Mj0/+zzahZvyDMEuzuvW0Rn8QEeky5cPhAciCJPw=;
        b=MUaQd6f/BXiIREv15GSwQVLeIhm4Wa2S6Q0t8CHFYR7CME4+8bThfnPUpI9gTi21wt
         w553O7sARRIPJ0pkWVfikDPaLsjFvKTFjE8Y5sf1Kvr+3YaBdnImkWxSTt/8XQyAwV2d
         lM8IqHeCuVDN0YSSSECwnn8vzQb4GRR/kC1H8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rw9Mj0/+zzahZvyDMEuzuvW0Rn8QEeky5cPhAciCJPw=;
        b=eKX38L2MBVY40efQNaZEiG0ZCbcqpV0CZz/GqPxKknEtMrDDaOSM51OHzM7jijCpyd
         jUX03tQ6CPXb2s6zcpSmfMGMjzgg47MHl40H+etOxm+uiyQrI51qpKtobzR1pxYglTTg
         LwqNI03FBQkM3u5vc4dUPzNYeHqQnfyROEiB0g4tuQNMEBsZDc+NV2SovyD7OwCkF8F3
         wy1im2raWMoEjLHQMrh/oi/ipenHhAHxrfk3fDXjFJrezaihRSKHRixrz85mnT0A6hxq
         nqwfzY0jglwPpsTdDEJioUfVEdp86NU20BbTrGV3mTviCRp2RFIAq0fjElFHuctrveYo
         RU/g==
X-Gm-Message-State: AOAM531bzbQCBmwmofz7PyXnbvgBN7AhSZaohkfA/2L+Ts7lYbysWN13
        bzZ60GU2I3XfQ1T+YBCgut3RFgJ/cJk=
X-Google-Smtp-Source: ABdhPJxtlQuwQmxDLMoDK57a9/HXESSPe9khaYCy0R14MDk7Rimx4iT8K/X5OC/DbN9zfqtovRPIZg==
X-Received: by 2002:a05:6808:ab0:: with SMTP id r16mr2574689oij.24.1591797117980;
        Wed, 10 Jun 2020 06:51:57 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y89sm12308ota.16.2020.06.10.06.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 06:51:57 -0700 (PDT)
Subject: Re: [PATCH 5.6 00/41] 5.6.18-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, skhan@linuxfoundation.org
References: <20200609174112.129412236@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9696dbd3-0ee3-a511-076a-98bb924bda8e@linuxfoundation.org>
Date:   Wed, 10 Jun 2020 07:51:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609174112.129412236@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/20 11:45 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.6.18 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 Jun 2020 17:40:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.6.18-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
