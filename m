Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1E9C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CFE122202
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587147128;
	bh=VPLqjvDyglb1vtUXEqe9nCJ3f68e7xNo8c2HxQKQwjs=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=uBJ5qyFKaSOwEdI2IjbLc7zWbYpzaYWVK16cG0bVpyGU1TyFtcsw5mGAhtcHtqmb+
	 222lqmR+N986ITUQXNTfYg1uyYRlUzozRAJY/YKf2ZX8LqTH/VrCROzknhTSbQ3IU6
	 chhl9EWvfIDbvy10sj8XJnMVYc1uCMjdy6Bh2pUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbgDQSMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 14:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730323AbgDQSMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 14:12:06 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95708C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 11:12:06 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id c17so3032447ilk.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 11:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=foA4DPbQhpo9xw/eOdopgrsDK8K+vfBDZATjTXoQh4I=;
        b=Z0MQ60xFZB3rug8cIA+FngZ0z5QTTaKj8L2zfDYreK5DCo9VyIQsbVvoQsEixaqASV
         Xe1eIj5eMACzhqFhfR1Ea39QY5PL+Hb/cv6dWzsZTHQF7sPy5VGNQ7qCbG/e1H2vfXzx
         f1QUhwZOxp3lfix1qIk/TZ32m/y8uoJ4+Rxk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=foA4DPbQhpo9xw/eOdopgrsDK8K+vfBDZATjTXoQh4I=;
        b=NPx37Uqk5N8bCkfwd30+SyIlpyg/d9sjNVCKS54C84OcFHIethrU4bgd5iCVecYiwb
         NSG3GIWVL1YaESIwsftYOyE5OdIoj5LHcl/ADdUa8oOpV9jSgOpg+ogoSrZpGkyfZgmV
         ajwUHVc2NfKIg4+QwnuX3T4kdG+E+lveCO4q/cY8jRAn03bhiFGf0cGSyi82xJstufpb
         Bq+yzr52vH8HfUkZAv+ccV/7/25R9s/0lQIZ/3efyEno7YG/ar82pqgCxi4bqqSETKk5
         QZwHQa5G5oVHQJDEaf8JXj+Ua/WZ1SI3zWs4lsgnfNHu9TcFtKwoFCMttLaf3EJzBDoX
         nngg==
X-Gm-Message-State: AGi0PuY8T9lP8dLZdUXjand4fsaBK6hVpAaZM5jaKy/S3uXL08ZfouP5
        57C53mTY3b3FPilEOT9LXZYNAg==
X-Google-Smtp-Source: APiQypK0O3NmNw3iIF83xy1VuEtCksGeLHf4dXqAZp+DSBugDnssGyEy4+rb78xy7abwBzrMsiAKyw==
X-Received: by 2002:a05:6e02:cd2:: with SMTP id c18mr4590069ilj.223.1587147125661;
        Fri, 17 Apr 2020 11:12:05 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v17sm8424124ill.5.2020.04.17.11.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2020 11:12:05 -0700 (PDT)
Subject: Re: Linux 5.7-rc1 reboot/poweroff hangs
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prike.Liang@amd.com, Alexander Deucher <Alexander.Deucher@amd.com>,
        stable <stable@vger.kernel.org>
References: <b8eaee2b-21dd-c0de-f522-d58bb9ae31da@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f6d5973a-286e-2273-cbeb-5c88707008d3@linuxfoundation.org>
Date:   Fri, 17 Apr 2020 12:12:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b8eaee2b-21dd-c0de-f522-d58bb9ae31da@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/20 12:05 PM, Shuah Khan wrote:
> Hi Linus,
> 
> Linux 5.7-rc1 reboot/powereoff hangs on AMD Ryzen 5 PRO 2400GE
> system.
> 
> I isolated the commit to:
> 
> Revering the following commit fixes the problem.
> 
> commit 487eca11a321ef33bcf4ca5adb3c0c4954db1b58
> Author: Prike Liang <Prike.Liang@amd.com>
> Date:   Tue Apr 7 20:21:26 2020 +0800
> 
>      drm/amdgpu: fix gfx hang during suspend with video playback (v2)
> 
>      The system will be hang up during S3 suspend because of SMU is
>      pending for GC not respose the register CP_HQD_ACTIVE access
>      request.This issue root cause of accessing the GC register under
>      enter GFX CGGPG and can be fixed by disable GFX CGPG before perform
>      suspend.
> 

I can send a revert, however it appears this is a fix for a suspend
hang.

thanks,
-- Shuah


