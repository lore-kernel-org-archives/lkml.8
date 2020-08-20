Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1259CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1A7C20674
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597967812;
	bh=i9WjApUaaqfqz1xBXGuZd4GiTGLLhpAgL4kjGLT0vYE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=RMM4JBpp24fursxyOW3wlsqxqpxNcrwmToV/JJkh7/R0x+/QMJ/G/lkcsyyIX59AV
	 NDNpJjNT3CYgseWoHrmjBMccJf8BXPgZoW+iLMIRINYEr/MsMjhqjrRkh5QFwIuHuJ
	 1ZmkCAqLplC14KhrLe+rco4X5JAlSswwe1ubx1Ec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgHTX4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgHTX4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:56:08 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD16C06134A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 16:50:13 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id j16so815861ooc.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 16:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yOUlFnTL+XyX6xjHFLowjyeqpIKSlnIJUWb6WpqEMQM=;
        b=YGJwshJsH1wNFoOWIvfJIQp5Cf1LT/9VcJA/XPy4DFr4x22/NkrMoaLTzY6cAivNtg
         Lh9nBCOI/Vbu6gnz1rGhh+NjftRRUQqh/SsyS/iWDn4bu3Ne2mhjdWvFJV6orzaMv0PI
         zl9R11C2LQe7cusYbPVmckA5TjliVE8QTY5aA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yOUlFnTL+XyX6xjHFLowjyeqpIKSlnIJUWb6WpqEMQM=;
        b=AMU8eksvboYIZX5pw55lVCbwbXck6mh5eFQ491U79FYfuh79pDSRmvOow6F2bFXuIQ
         LQHGccv4/kiYVvxCR9wpV0IEuaL+9zqcUgV7fSEZElkd0imVOlOB1W5ESEIeMu/dLfOq
         PTUXaTtpztmbL0xecak1f8BehUv8lyocwKf6BoOTLjmw6W/RK1U/JE2iJiyGujBThi29
         HiBKN1f7r9mhKA+Y2ccrOvDMcFMBu54SHGefARgZajrPTViErBIHCewgJhUWZhW6CI9X
         RPdk7U+fiduBFAKlPO92IeV+pGGImFIHokophJHKgcr0jJsb9qbkNLPK5QUbvlrmJC/R
         uTZg==
X-Gm-Message-State: AOAM533lDv8/HhkZutHN1SrzNndy7c3FXG71ZIHG6Y3NtyXklBdg131M
        91Y99d305hgchxl5vzTSRA5Huw==
X-Google-Smtp-Source: ABdhPJyZG8oH4VKCjS1vegRO13xkgfdCIBly/mLpQtPV8tBdm5byU+kUyvopaaB3/3Zo61WYDw5sEg==
X-Received: by 2002:a4a:a782:: with SMTP id l2mr181821oom.62.1597967413403;
        Thu, 20 Aug 2020 16:50:13 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h21sm16403oib.51.2020.08.20.16.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 16:50:12 -0700 (PDT)
Subject: Re: [PATCH 4.14 000/226] 4.14.194-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200820135009.684062405@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8de043e7-7b7a-c041-0dd5-f0384fd32713@linuxfoundation.org>
Date:   Thu, 20 Aug 2020 17:50:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820135009.684062405@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/20 7:51 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.194 release.
> There are 226 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 Aug 2020 13:49:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.194-rc2.gz
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

