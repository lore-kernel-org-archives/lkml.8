Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F196C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ACEF207EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598998933;
	bh=ejmOEIVuYJ1bg+rcRpZhN7saAc+8dg/3WICfHMJCI24=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=m9/G5iiUubYoX+FpOZexh6dLUsjkrv+4m3PsZp9nxEA6Ni5zdq7EXu4BO233HIfuO
	 gruNkvMB3sxXEEM8IpJVYLliwdC5vN8ODpoGHcFobqNHa8+B4tXw+mgyA+PZG7rbR3
	 pOYl+E6aJP8XX9I0RUUI5bQYP59PJe8KWwxWS1RQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgIAWWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgIAWWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 18:22:11 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA766C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 15:22:10 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id x19so2601675oix.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 15:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hpZ/pqn/gZKDamwMZKx9sZztrXuD+zfU6JEPUgfZM7M=;
        b=FvVnYaPj7/wShDJ26GhbuXrYzH3SxX96TS7Vcq9mq5lSSMdZ9nWBy0o4o+crv9vnWY
         K09OPOVsVZrljuGivlpZceMj/ctiERJpvxYGtvJn9DtohgnjTTzPFJWAG3bVLX1PbKmN
         lobaHKQKGZqueIdaXR/xIrmbw9s7qI+JNgojg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hpZ/pqn/gZKDamwMZKx9sZztrXuD+zfU6JEPUgfZM7M=;
        b=jxzbTncKbd5ljgY5QbJATcEwEFZPfNnOR8F5DpDOxxfKyJdgJSw+IKXu7BaDSbgTB5
         1RSCHFSptFV7gNPyEYfTjqPYkLYvSHUjKMDCmRSXFsCg5amztoG6Qihcb44dkM9mKCIY
         JVdtJcrqeOl9k3A1MKa7kV8Ivev0aetqb2pdI05uv+FNmuQqQEFUBb9W+U8LVQlMpaeA
         DoowRVPQxoPmTwtfHb9n2yz474ccOmnQK6tXFsAZnzGzMl7EgGKdraPKu0XACJmyLU1T
         J1m+uR8QGQKqMi+nKIFUzcVlUjZvOJkmWu1Jbl/L3MTj7PS0guKY4IivDP9804rax/Xz
         h91g==
X-Gm-Message-State: AOAM531WGoCfrjTiMckK89GjJhwgqVP+KwxdxKon5vaaatT2cXlDWTat
        DHBoqGPweJVuJ1j+0rSuqyeXAQ==
X-Google-Smtp-Source: ABdhPJyaeSvW23yiAYE3kUusSuO/5hOP4D/KXP8p9Buo+tol+IhqxU4bxRMllJ0XZrpY5PrypG3eWg==
X-Received: by 2002:aca:3c43:: with SMTP id j64mr196648oia.178.1598998930171;
        Tue, 01 Sep 2020 15:22:10 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w12sm265707oow.22.2020.09.01.15.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 15:22:09 -0700 (PDT)
Subject: Re: [PATCH 4.19 000/125] 4.19.143-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200901150934.576210879@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <96cd2e66-0ede-01a0-d323-914f591c3675@linuxfoundation.org>
Date:   Tue, 1 Sep 2020 16:22:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901150934.576210879@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/20 9:09 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.143 release.
> There are 125 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 03 Sep 2020 15:09:01 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.143-rc1.gz
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

