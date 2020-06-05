Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82F7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 22:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81438206DC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 22:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591395553;
	bh=xYTgI0YaL79W5rmRtFDTwYfJv0uuCwfpzXdrOcmwl5A=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ijrR7GhlUquUO0ns+mfpxdTgbf+XEgzrPU3Hh1SCmusRi3DkbL3tjI4X6rdtlpCL3
	 VFOOO1B+hld7OGmVCZ9DFe+OXl5/qaaXpyNgJcM83rPJZgnXdjNDd9Om1qnPpsLN+s
	 k+gNR8SmQSOGAGfPurY4Wj1d5zeqaXZayGoJwQ+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgFEWTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 18:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgFEWTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 18:19:11 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485F0C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 15:19:11 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m2so8835200otr.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 15:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8mu33PrUuZ+3kMf9sxuSzyPe8VLIGEEmxjelDnG52AM=;
        b=fyy5newW8d0s+UuczWfb5XvZUdoLFSYgujaF8mWZJ5Gf0H5cXoLA5iCZtuqNKfyLhi
         gRGwxJjHvLmSvdSCwj7yeLMbbiNhYl1Sy3xMRPUfadXUpgMeiE8HVaW+epR1TX1o2jlo
         0EF+HcKWguqrfyMv7C9ta2WybysXFWqUroQZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8mu33PrUuZ+3kMf9sxuSzyPe8VLIGEEmxjelDnG52AM=;
        b=J6VNsE9Utgp/jiZchkZZwAaM1QAPQsvXopjM6FFmtgojpBFI7CB2eJxR2IK7I1ii17
         8H0RMtVz2sEvvCeDSevvuOw8nZwOtjNSiG2rX1Se9NOexE6zvL38YXsgIQtW/S3HHIVN
         EdWNVOhhUOfme7yxnD8IpVIqDNVPNmtrYxPbn+DgZWY4VEWQcNu5MKYdhDXXnCXcIiFX
         ryObTNnIg8UWkcP5cwN2tj2qMYA6ijtB+PrYuKwNrDG3PcUG9PLWyQFV43O9rId8qOI/
         Y73MEbHPEgzLRS0EfpfBIP7hPnj7X/bFpdysvk5JnLqQvUH/lEbDVs4DrXAtUjQuzviQ
         43CA==
X-Gm-Message-State: AOAM532g7YcdheoEvMuYAiGfPjk+puGXN9VZzBfCvQFcQWcPn+WJ66a9
        5bfXTmSKnQqEM49dP16syNsNlQ==
X-Google-Smtp-Source: ABdhPJxpIKFRYzWzhdETc4mNG/8jq4y78etvvYmHPuGOAOvzkhNcp2Rc+4xlpIiNdtQQAPCsklgEVQ==
X-Received: by 2002:a9d:6c4e:: with SMTP id g14mr6009456otq.229.1591395550601;
        Fri, 05 Jun 2020 15:19:10 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j2sm183819otk.61.2020.06.05.15.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 15:19:10 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/28] 4.19.127-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, skhan@linuxfoundation.org
References: <20200605140252.338635395@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <60a4a595-aa2e-cc34-e219-b33635d7e5c3@linuxfoundation.org>
Date:   Fri, 5 Jun 2020 16:19:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605140252.338635395@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/20 8:15 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.127 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 07 Jun 2020 13:54:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.127-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

