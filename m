Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC95C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 831EF207F9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594221529;
	bh=II5Eqy62AQukZuTjhDPGih3KxSJK69GXo6skIzAnteE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=b2FpPl46tY0zOAbx+60ymcMksnXXsstzjtCx0q8BeWV54z6yazd0mxkgJVTGn+GeP
	 ZbdAsSDnjLaT7aC+tS6B1Uz6/bBk/fQohEdVkri9dpu37slHcuvic/J+8O/12n1rek
	 oA/9ih2QZIyaMj6Kpbkx6yf0MyHOMHuC/5SYciYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbgGHPSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgGHPSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:18:47 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B88C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 08:18:47 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id y22so25489821oie.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 08:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZuoUzrDuDd0J/oVgMoGWhxlVUdrJuDrqViZgxHnlo/Q=;
        b=draIj9k8f7stBC5+C3bynh8LM4vQknVR0yAsbyEFMVqoHLAg9lVDQYES2yFYA6G2SW
         gmRHxGfw9NtoUTmF3rBh3qGYhDYdCljoRZ6JbagyUQBFSuyEJCmdVDPmqs2WY4pblNEN
         eqkwRVStrD8XXeqn6pDFkCzSBIr4ltf07PpOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZuoUzrDuDd0J/oVgMoGWhxlVUdrJuDrqViZgxHnlo/Q=;
        b=mjILGWmawdVyQWoRdxJ4SiSD/rLtfhQ2tFIyE61vy/8xRe+wTS1wakMUzOxuQLUzsL
         UlrzziqfaXGpW44ymj/4h/0lX7RVlEhv4CR5nXAc9Xd+9V3BzVbV8+vOyrJrUXbW+AmZ
         XTyXMSU+dlhT/1yJ/Xas0oZijB1ck/lFc0uo/3txlmcB+Ey6SL9TvK2n42Ob2y7zRHgf
         TRI1nl9xfXWblia0nYdmrJ6yS8CuPjHdtZLvDv/vKVoTixUkO3F4chsnWSXBaLLyH+JU
         V0OV79aaay44+UWgOS+iDko3sTOZdfwWt2Vc0Hey5Fl9A8Pqf1oL2JXX8mvrxfN1g9lM
         ZtXw==
X-Gm-Message-State: AOAM531nHBTHhBaLL0ug04YghV5MALPt3ctPqqAe/XDo+A877SefoEEO
        3Pwz49WUJxGIymovMAbQJB9ZiA==
X-Google-Smtp-Source: ABdhPJwADAsqoQhJjqYOqyXMgxuA5fhLeFm5MSaw/twe212+yNaFvolz9pLcFe5Jz0L5EvQGmPTEkg==
X-Received: by 2002:a05:6808:2:: with SMTP id u2mr7238927oic.173.1594221527159;
        Wed, 08 Jul 2020 08:18:47 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r22sm24675ooq.37.2020.07.08.08.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 08:18:46 -0700 (PDT)
Subject: Re: [PATCH 4.4 00/19] 4.4.230-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, skhan@linuxfoundation.org
References: <20200707145747.493710555@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e643820b-24e4-6888-7be4-26aab756cf17@linuxfoundation.org>
Date:   Wed, 8 Jul 2020 09:18:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707145747.493710555@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/20 9:10 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.230 release.
> There are 19 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 09 Jul 2020 14:57:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.230-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

