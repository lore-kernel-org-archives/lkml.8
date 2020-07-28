Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C6BC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 01:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91E2D20809
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 01:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595899885;
	bh=o0F1lXqaF9d+mItpn2c1TyHScRxt40LLUDFY6KUIOAM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=w275HwfyBkG1k8PowfrfjSRVOTJuObswwGj0QZppuNSFAqvHYwslq2bZBlG/Ch0My
	 o6hVOgDi5xom7d1hhz/fgZBXY9yzu+5lxzhMzDlHLuUTxoRySUwj8RPPsG8PS8aWpX
	 ZBl+zpU+3RMji9hNZMOAzLrZKTWQGCwzTDQQ3Ou0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgG1BbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 21:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgG1BbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 21:31:23 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A82C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 18:31:23 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id w1so3510017ooj.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 18:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=85PU/jeMBPu5Upo6UlF9JkPgAyG/TgNDI2puYp9FnuM=;
        b=RfG/PYmyP3MrH8UgvY59xXT43rK8K6jxBfyj3ny8PFYkBkhY9QibvYkB6zi7MRm88C
         UvBlHM5OiF9Q1JBxtVpkHFWf01zVjdcZ12B2MNSz9rfP5shebjPn315qhA02U79Hunuv
         cQeC2p6EwohTKWu+CFLf2+BTz+tPLYjtKgT1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=85PU/jeMBPu5Upo6UlF9JkPgAyG/TgNDI2puYp9FnuM=;
        b=ebwn8G1XVbGxtQqajsRthPUdGsJV5WsMWrriprDnA3xVrcYItfVzxpgQAfLrksRIKM
         Y6PSDTBZo1Lb/3WcgG12+7X7UnfyXa6q2HrsTTF3dyoLEBQo9IQ6bsCWyTXHB4uNxjFI
         7pSzIl35/Q22Imbk4Eo0VL0fAMhS8IXLOf4XxVODwgXZ1oShRkdKiRGHOi9uII1FToDN
         E+6UvDrkYpdutNtiYG6Lr0W7OGQ/H7SJtHPbkP3AR8X2SB0vJ12ao2wajzjO2K9Ay4lO
         Flheh5vhsLE0ioh6QagUPbWTUSXrcmJgzYJKWiGOQ3jl4oQ/NE8AX475hQWMFinNjB8/
         5SJA==
X-Gm-Message-State: AOAM530rNXACDCkp8wCH3CWogn4PbFbJ1v3XpfISQo0oRNpYH2dWmvgq
        yFaMW6Ob9wJjo/YB52FqxNLCEw==
X-Google-Smtp-Source: ABdhPJyTn7S/tuMTZD6FUbhNh3F/gzDuxavwvcuLVVLhUX0JpFMq8XGVsq71+W60ALcKrnkct9aH0w==
X-Received: by 2002:a4a:aac8:: with SMTP id e8mr10248748oon.64.1595899882847;
        Mon, 27 Jul 2020 18:31:22 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e203sm2102281oia.17.2020.07.27.18.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 18:31:22 -0700 (PDT)
Subject: Re: [PATCH 5.7 000/179] 5.7.11-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <63f634e5-e2bb-fea4-90da-774790ced38d@linuxfoundation.org>
Date:   Mon, 27 Jul 2020 19:31:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/20 8:02 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.7.11 release.
> There are 179 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Jul 2020 13:48:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.7.y
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
