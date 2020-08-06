Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E50C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76D222173E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596742454;
	bh=sykehnTtngJLNlbvttgleen+KqNM3O/rDoQoRmwXz54=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=duRiGUMYav/i34AzuhflmIT2mWldVNkPsCqvIjMQO1ySzt5MrTw8TdD30nNQJ0EVU
	 e28cdNgXIRGwedz6Lu/ybTb62ACmNyCPxwCTcdnJfQSxARyDlTdC1Hla6bLEv2WrR4
	 xvLa46h1/lpS4YkkCIldeIl48lK7/ngIx4ZyU1vA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgHFTeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHFTeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:34:12 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165F1C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 12:34:11 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id k12so20272921otr.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 12:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1es26tsdCKsqKmJOB8uF5Bn5UO+epgItEywVRGDwRXA=;
        b=XE4k7WyI2t7M59d27ZYsgFmCscGNqSYs6wi0xjS3Vgo/Z2qEl42HftuaR4p79Fgoga
         L8XJkEdsU1kItTy0CsGsiCLzWIekHyY98ZR2Vw7sTZK7QsaXW1N/gL1Bhu2edkZzFbv0
         liqpuRk9wgjvxS9hJfK6ALEXCaxmTxsEmylwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1es26tsdCKsqKmJOB8uF5Bn5UO+epgItEywVRGDwRXA=;
        b=MCTBOF7VYfQ/EmZI2YcY7tyrRL3maAwYI891E0gHxgehswNJB0nGFFRtbSVvyuzCEX
         bGauKEnCLjgNjBJw+HhZFEQlJDGRmI92/L9lCCsSQrqTkOCjlXuZiCXiE0zzDY/QuFIF
         KfAaI5N8PZltaSUpBZP9cSrwhzSFuAYRs3HtfX1zrvox3s25Rb9dbqnJ8AVIFd82kwTf
         aslEGIojAHwHEAmlLNOQ6UvF/OdVdhQBiFGGnfFgM3zHzE5uZDeGlagStjrSqhRlaONp
         0mn+Umo18kzizwROfJQcdNrkdVoe1U75oFo4omNZ15QcTSetB0SLH+K+w6L2h0tE3PF9
         J/1A==
X-Gm-Message-State: AOAM53342LW6vBywzV5JAQR6EkavmvxA0r/HdXPbCSE5NI4mc4kE3AgX
        GaO/NLf60xTNt3bWzVleDq+ejQ==
X-Google-Smtp-Source: ABdhPJxYxpY0QuM0iIR4HWc0hd1gPoDxDjJmafm9uJSbMujRdlz6vySSTL55Y5mkaZmp4Lh6W2+WvQ==
X-Received: by 2002:a9d:7349:: with SMTP id l9mr9021506otk.341.1596742451094;
        Thu, 06 Aug 2020 12:34:11 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w22sm1341226ooq.37.2020.08.06.12.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 12:34:10 -0700 (PDT)
Subject: Re: [PATCH 4.14 0/8] 4.14.193-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, skhan@linuxfoundation.org
References: <20200805153507.005753845@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <87e43631-71d2-d7f9-7cdc-4f62c1f067c6@linuxfoundation.org>
Date:   Thu, 6 Aug 2020 13:34:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805153507.005753845@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/20 9:53 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.193 release.
> There are 8 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 07 Aug 2020 15:34:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.193-rc1.gz
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

