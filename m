Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED24C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 01:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 432C820838
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 01:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595900268;
	bh=BUOf7pi1bXEWmK6QkGThywn/WQu6K2DqHm25ADBtUUU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=OKEZc79WXMZmAD+Fr+qkjWdjpnsosxIiUwc99VpJOuJsXhEBUPBPMASxES4EX9tYx
	 bACUUvozV6z1ch4B7peK9xPJ8586hp5X9Lt2aGdSqIC0nnpqDSzMAi0kj+v0FUZOkS
	 v9RMv8N8S90huSu7Z7mcG4aUVUZtXXoj2PlWwheE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgG1Bhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 21:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgG1Bhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 21:37:46 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7B5C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 18:37:46 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id x1so1334939oox.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 18:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7BD7VlCj+9fpGvYrpIdg86knouvhbQ4T8igQFat8A60=;
        b=SIA5rWqg9HgoCgllvk4zWkQEuUIGT34XDUKEcV14EfjJkyaQpfWOhZ4CmkEGmD8OoM
         qMnLkvRZHKOSedqhZ98xm6O9p+QtxY5/zJkjuGOM4VmbkokrMKSklWaDFX4Tz+rg7AnF
         8Y4qEM5EoBuvHOYh2vYp+Wchg3UV+BuLNIerY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7BD7VlCj+9fpGvYrpIdg86knouvhbQ4T8igQFat8A60=;
        b=VsXU61vu6hkjxDMCYBpuk9q1F9aF5c+c2Bzm4czc++wCLyUI+UdiXK/GHJ3DtYiuYE
         6ndcsH/ehYJfOyeyRSmPXc5NB1CcBNmFfRYK45jUylE/JJIvPKQqak8PMaqN7+hFccVs
         +CNG8fhpjqd12uzGzabkMt4j/9OU756w7V3MBxclRnp/kySZtrTmXOukeHNlv4FmEwo2
         JC0aKXT+RPmG/sw7vzifgWvDPKnKrKaoqcIOyou+j3soKE7Aq9IAAU6WYr4ML1+rYegs
         oY0q6n695Xp6vdDj1gpZODpFpNa6J6XaX6/azXw24/dj0NbLhNisyXN1q0TzeXTc2UJ6
         4miA==
X-Gm-Message-State: AOAM5334U/gLH2BXfy+XgP/WKltn0LyOe/ZasgWipQM3fGN+i02YdWrz
        cVTD8YmyV4KHJ7Xiu3V67O+ZKA==
X-Google-Smtp-Source: ABdhPJzl2D7vsp5ORNIRK95ufH+sTmHhiwE91vS4ngMTFMtLPuU9P/jNCxdupnrtOiwBm6zufOWXPw==
X-Received: by 2002:a4a:4150:: with SMTP id x77mr10571713ooa.21.1595900265818;
        Mon, 27 Jul 2020 18:37:45 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r22sm2699990ooq.37.2020.07.27.18.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 18:37:45 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/86] 4.19.135-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, skhan@linuxfoundation.org
References: <20200727134914.312934924@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <139a2921-ed1a-cda6-8449-3b10f6d75940@linuxfoundation.org>
Date:   Mon, 27 Jul 2020 19:37:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727134914.312934924@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/20 8:03 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.135 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Jul 2020 13:48:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.135-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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

