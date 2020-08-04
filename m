Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74514C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B6D920842
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596573407;
	bh=gSvocLQB7J96s1MUSqptR5Mt9PtfnvRlyObn813PYMo=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=jZKL5HEfIpAn6W3npTMpmLgt+fADzTFj9j3rF+oots8mBZS45lL9pPOh953w27VkT
	 ybwwPxUwvpWMB224nh42It85SIlprZvZsnr4noCc7MOTT7mgCZEy70MwmuSITK9nmL
	 dG8iMtpwwoT3VVr6mDwEtZkYNNC8mLWOjqgRFtsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgHDUgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgHDUgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:36:44 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95433C061756
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 13:36:44 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id h16so11542955oti.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 13:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=seeOjLMrqpVnUq6/RwDe6n5PWXIo5DZNlxCTXS/G8bk=;
        b=ZoRg0WrJH3iB9ea0HU4t2VDqDb1oVNqSzfgWiT2wNsrX/662A1GnDaKCAOkF4gG9aF
         2TZhEVmK4LEcG5cUJlzOOqUXWRE307OWk/81K/wBatW5vTMVB99P01PILIY7GpDQZ+I5
         4AMmesrG1U5S+06ZTwpaHAWKmZp8o0GWuFhsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=seeOjLMrqpVnUq6/RwDe6n5PWXIo5DZNlxCTXS/G8bk=;
        b=FelLyTdweG/zctAFeS1p/2syP5fcYaSOc0RkrdcUkxWL5aLxZYknQkHYdaALJhB14b
         6N5OPZ3hsY9XyMP5gcpThVHJTEE8boSbGVTbrNJ4uOPDfRZsO8oWxHEmZpOpLETKdt7A
         eck+9SlUV83QUvO7aHjDnmOY7lSgky+dhCMp0stVHhbF9YqnpiegzPUU3sY6Min7XJHA
         nHmo32TDfgS2QqAgjxC+4yMMW23po+DkrAdEmY9H285RoJiZwBuUq1UJrolPvhoxulWs
         NGCejpbrPFmPJCgtwOBUF1ODRLJKsrQZEHZQ06LbrMDA/xWThMjuMMEIgSBqJMU+hMsd
         U13g==
X-Gm-Message-State: AOAM530GhMrcUdnTRbn6RuiwqDtzwouJdG4ERtyOfJGZhU7elOja5M/L
        FyJ2hMZ7OsZEEykh2I6MSe2Nsg==
X-Google-Smtp-Source: ABdhPJyR78mYsK+sdEf560Iu4wBFXC24d+YOycJqoDxw40JDCH1mSgyi5AvrHCIIw3jU2718T2UaMw==
X-Received: by 2002:a05:6830:4b1:: with SMTP id l17mr13932923otd.297.1596573403256;
        Tue, 04 Aug 2020 13:36:43 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y67sm3717782oig.46.2020.08.04.13.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 13:36:42 -0700 (PDT)
Subject: Re: [PATCH 4.14 00/47] 4.14.192-rc3 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, skhan@linuxfoundation.org
References: <20200804085215.362760089@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ac9f888b-72f8-5fd7-1db0-132af7322042@linuxfoundation.org>
Date:   Tue, 4 Aug 2020 14:36:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200804085215.362760089@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/20 2:53 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.192 release.
> There are 47 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 06 Aug 2020 08:51:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.192-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
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




