Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6F0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A3E20772
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594213516;
	bh=kjD9eiuZ+artkQjcyBaR3fxGUrnjTdNr2TgqqgOSePc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=XYQt3/I6FfM+dkXrWlb0po2X4UOnPN/NONGcBkUs7AkdXMMo5GtiNPl48DYL0qTBA
	 6SRjqhtsLV0XzrNDsQUMmjVmrH/1xluHjhS0SB86yzR4ynaUPvG9uNjjvZ/I72Nbqo
	 dHk8XnhZYWndxNHcHYHdISlQVmL0FeK3NOZ5+zuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbgGHNFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729070AbgGHNFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:05:15 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A974C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 06:05:15 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id h17so37741050oie.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 06:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jnHU4ybCuZZYlQELmFh57D27dj28RTyWDhd9i79ajHo=;
        b=h48cBOjNmtf7x5yXbFeHtd7Hx6qMVw16CwUKWbcQBhZat4JXVBdU3ZFLvNDytpPmK/
         XaRllPX4CdmkYUl+xZH64SKTUBrlnKou81mggbJTAUbKpi7luTAocDYu39RfD28XRC1d
         p3wSfmN2FvA1eqljY1ttGqqKW8sywgW//bhQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jnHU4ybCuZZYlQELmFh57D27dj28RTyWDhd9i79ajHo=;
        b=D7l3mZC6p3HlP4nr+C1axPCKaXIe0IyxgmyzeGTKvXtl8L89GpWSK+wlVY5bQ0dl/P
         3OU2aJC9GAtQI26IHHunRPLmdRPYBK/lx+z2hTlxQJYHw81AIS9/yletl3Xci4RL5Pvm
         V2BxN1zw3LDUGWOTzCNwoIAg9LO1ieFDf/dRcR+nR5BQcM64bmpiJZoTMk2k1Cmwbsx3
         53cAqn4PZY1y6dzWaIZ6wAgQ0hUKQNn6T64ENuslZErrzk/kh895cXZH9JZLPvRAvKf2
         dgWniq0McFnk60upT7tjtAg4D6h1PgyFF6G1ZhUlZ3tEvD5lrmQnUwhmeK8ihj0IP/Ax
         ZVOA==
X-Gm-Message-State: AOAM531+aKz3hNDKABa+u+5/1gztQeX6gtzHYV1ciO3VfbqnXV7J+IdH
        Ee9SaJv184hKkvD31/ZioylLvw==
X-Google-Smtp-Source: ABdhPJw+gH7No5NB7zvrPYHmMGTVrSWNZb+xYGOe+4Tdm9UIvka5yC+w0QdExTvjpvhDxpAU9Zd8Hw==
X-Received: by 2002:aca:53cc:: with SMTP id h195mr820451oib.49.1594213514603;
        Wed, 08 Jul 2020 06:05:14 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i4sm761460ook.30.2020.07.08.06.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 06:05:13 -0700 (PDT)
Subject: Re: [PATCH 5.7 000/112] 5.7.8-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200707145800.925304888@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <552f9118-eac9-56cc-c321-dd9b97eff09e@linuxfoundation.org>
Date:   Wed, 8 Jul 2020 07:05:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707145800.925304888@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/20 9:16 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.7.8 release.
> There are 112 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 09 Jul 2020 14:57:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.8-rc1.gz
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
