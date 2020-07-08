Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E13C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36C3E2078D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594220446;
	bh=g8RTQ64Xlt02pBDQhtHdvTqOce4Ju3qEnWb9BCZtP3o=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=bIU/+4Zo0fEHFa64NZgZpSBp0uUNg9qHz3l6FLUffZr+BfpHv1gK/DfyD+LXRVlqA
	 4iz7+miEoOXOyUZnh5UOGLtW45c0ZB6dQWBrGPP5fJh9wOs93t54y1K46as7ZFD2ni
	 DBLQ0qVw8zkMuGuMumbRvuClvx07Br1eYH638NQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbgGHPAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbgGHPAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:00:43 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C08C08C5CE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 08:00:41 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id k22so26718426oib.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 08:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0GZgF/SyAhnMOXZCKoaQ1p6yjE2XQ72Ure/u4JzjEMg=;
        b=aWuWIcLFQ46VvdRzCVzqrfCzNUTmGcEQ8EsHJSBJ68MGVCHEvauLRtPXkri8BbADKj
         Z1UHksgZTXONRXDVSJzG48ExfRw7pMPjkGuaer+1aYJ6YQwTlRRgRvv8CIEQ7wTlGd9B
         srfARCjoO0QI52xSLXR/utQJ0ABCBjUgT8Abw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0GZgF/SyAhnMOXZCKoaQ1p6yjE2XQ72Ure/u4JzjEMg=;
        b=NwAxDskfNg3GAAuPt439dyea/0L9eDYicmifE0oflQUoegDxlSCa9w2f1AXOpd7L8C
         btrhhxo4LfdoVZ94yoDeg34tvrP8a7JUvT8iB72wxfzFtMiMqNQ18TMXl7QrgwsMAf44
         xFpADs5qASoS890Qzo2XVQbOFVbSE9ihITIcnsl05EQ3WD0S3BLdOO35cwKIoRYx31g0
         Wdilr1sH1mBZu9nSa/IqFumMGSbuVqTQ/kShUcMyKeNbrzA3n0ioW9fxQSQM8LfgtznZ
         TDzX5csRNSm2bYiPnnipNUVJhsW99DZAmhU6Os2bhu/yWCbWwpsMaEB7yve10MJxJkX9
         QoTA==
X-Gm-Message-State: AOAM531gY5jpT0yXdb+S3GgqfgF8x1OMxRnZlXETNjaj/WijtCieAU2z
        qjpaw2vpnSvot5ffg1cOVvskJA==
X-Google-Smtp-Source: ABdhPJxXSRc4vYONf0j91kT5lMWUgUpWTXL5LI/rgNjA97TZzv3YXY47t5H6qFbT/QfSD1RD423Kxw==
X-Received: by 2002:aca:5c03:: with SMTP id q3mr7779580oib.132.1594220441078;
        Wed, 08 Jul 2020 08:00:41 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c26sm6433809otr.26.2020.07.08.08.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 08:00:40 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/65] 5.4.51-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200707145752.417212219@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <cf5d63dc-cf72-81b6-f76a-b27ebaff13fd@linuxfoundation.org>
Date:   Wed, 8 Jul 2020 09:00:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707145752.417212219@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/20 9:16 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.51 release.
> There are 65 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 09 Jul 2020 14:57:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.51-rc1.gz
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
