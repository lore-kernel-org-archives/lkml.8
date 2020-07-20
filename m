Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5F3C433FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68A6A2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595288275;
	bh=tQVsLUdy4E7vdhtCRsDlC1I4aZw60VUOHY7OZUnLREw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=EFf9clGobsFe8npMqF3PlMfrvbhjDhxxA6CYw80B7KPYt1MBfSWPMRa2SoT1M848A
	 9eukg2uRb4Ro75NhxgtEq5Esouad/9hhVJiCWrN4hKxhBdfMaPTywtjRdjSyVMr8zs
	 7AZqcxJ8hYin0DloNUiB9FHp00CVxSvX1KgSUu48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgGTXhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 19:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbgGTXhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 19:37:50 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B263C0619D4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 16:37:50 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id d4so13686002otk.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 16:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2VapwMIKwhCwr2bWdb3iYIkjYLx7IHfthHZSlZWyQ6s=;
        b=ffXHysH0O/EB1jsyRGMtTayoZV1mwFQraJDX+Bwy6R6Dj7qnXYdn/xx4L8PvSYOe1A
         yk/zRbpPtIwz0myM8hFn153LgiMUGqbW06JoZ6TSglSXobH2WOo77sbBwUNWvUPR64oB
         BgCcQ4u/ei1vhs4dO7xhYT96PTwqs0iveHkHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2VapwMIKwhCwr2bWdb3iYIkjYLx7IHfthHZSlZWyQ6s=;
        b=GYhaYV+2mE83lYore0M/kqJB/9lwHzR6M1WNlQnED622PIhKoKFQug6pU1OfOJ+p9V
         FEFy8FGvhfnoc88rlfYJWD01C2uve7GPeEpsYqcDUXjyLZsMgKXX1IchLGhX8AtSZ5Tz
         mybrnXMkpCcH5kc+r+qTIb8nkd0Ntx+E7YCl08wfh0ZA0w5Ls+p2Mwl7iCsiq9M5tSpc
         VY8Bf3QjWHsGjDgNftRb9XfxzKX8SWHi0q7EEqws+yBS6HLm3+b76/7QdYfPiLfG4Miv
         y09kbcLSWR9Cjd9en1UQYsaPcJL6IbCy6lqITVrKdSCbsOCrrbYdisRgmLuitIDOshvc
         oq1A==
X-Gm-Message-State: AOAM532x6Q7flFAfa/dKayd6hMuy0bRvtFbTFZvoOuRp/9tG2aWN5TGf
        CJWjBIVB9pm6Wo4z7KkThPd4Ow==
X-Google-Smtp-Source: ABdhPJxOhm2h4JPCyqD2lRwaFXbuKKoJflI+RELIC7kdMXmosNTd9tZw66UaUlnnl6VpcV6UA4jURA==
X-Received: by 2002:a9d:600b:: with SMTP id h11mr21263893otj.263.1595288269634;
        Mon, 20 Jul 2020 16:37:49 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h17sm4717501oor.18.2020.07.20.16.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 16:37:48 -0700 (PDT)
Subject: Re: [PATCH 5.7 000/243] 5.7.10-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200720191523.845282610@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8f328303-f1fa-e4b6-d6bb-a2817c7474f7@linuxfoundation.org>
Date:   Mon, 20 Jul 2020 17:37:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720191523.845282610@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/20 1:16 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.7.10 release.
> There are 243 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Jul 2020 19:14:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.10-rc2.gz
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

