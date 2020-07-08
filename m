Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0073DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB17B206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594221241;
	bh=rI98W918gRJb1c3QOCyZv+CY4zYT5fLwXNWUgxiG3cM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=A1oWT+ep/0w6pvt/9z0y4csPACFmJr5b1WaMdlibOsuC1eNM47uRE6b1lRWc+KiP3
	 827ZoX3KbReEx6z6Psg5/FYz6KibkaPUZMdGZ8gcDE/Y3rhao3somnt3fL6Fj3jQX7
	 ZTfEvrO6uDPlYAg3LxcZdlmUeM+UACkcgArep+Z8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbgGHPOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729652AbgGHPN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:13:59 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEC2C08C5CE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 08:13:59 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id t6so2859116ooh.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 08:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vCLsIz3cUn0ECQyTT1GzhIyLiG7jZa3O4U6Vs5fBW0Y=;
        b=EIRYuJm0AM6Zp6FgWg6RlDHM7aWTT35bXIJZi3FOegpSBk/MNR8CLtEyAJBr0vb7ef
         bHAkUI7u2rdzStiBAfejkkaj0hPNFPeAme5cDkJ9T4nd8sLDXANAgMG5fx6ER7sxgmE8
         HYdpGH4Rmd22kk3ttGv+tm82LPZOmjJkLaog0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vCLsIz3cUn0ECQyTT1GzhIyLiG7jZa3O4U6Vs5fBW0Y=;
        b=DgDF+Ypy9NM03L/YRd1UKoitM1Pb3x+qjnum4nl+B+h3vIKVD4RGFGa842cYQM4rpS
         nTeTI4p/q6W6xFVQzhU49mEFT/i2sG8jVAULkIthzf6vrOCOK85BMf0bd6z8TAZ3UWuk
         XCUd7QYkZkVEoo/qcRCX7+s9f2sC91JtwOFNCjelLbMA0DCVQIYBbEmGO6cQZlucJIvS
         MA9t5jViqZL1HeGJO1s2BzGQfP35jF6XwnDxaMW7a9hIBJK4FPA9woVIkFEm2kWDESZg
         xjq46GyBjXGNWjTff6p28QnHMsvWwUa8eyleGqukdDLcIRr3AGKCoaLusVdENl/nd0SC
         tEpg==
X-Gm-Message-State: AOAM531COBkujEqPZEfzIMEkPu0K1c45ZvbWNYeYi3UjSO5offenh7IC
        Yxkpf7w6Ahp7LA7xMkY12TwuFg==
X-Google-Smtp-Source: ABdhPJw1ChwjOnjxHCznvTWZ0JUFggHDYyOer1CD9zW0IxpwuSvoSuk1s7U5Y7aVta93OINJzHheJw==
X-Received: by 2002:a4a:b34b:: with SMTP id n11mr51096516ooo.41.1594221239214;
        Wed, 08 Jul 2020 08:13:59 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v6sm30783oou.2.2020.07.08.08.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 08:13:58 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/24] 4.9.230-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200707145748.952502272@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a64805f8-f026-af4d-11a5-8e8b12ce3f17@linuxfoundation.org>
Date:   Wed, 8 Jul 2020 09:13:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707145748.952502272@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/20 9:13 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.230 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 09 Jul 2020 14:57:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.230-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
>

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

