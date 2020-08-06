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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4BAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A0C02177B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596742423;
	bh=HK8khKIYoZpD47vcMvd39jZxvnPy/pDIqT4XwCGbBCI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=nbTkSnwo5yeFaDTU72ZNpNhZvi9TJOY6HyvZUjGZ1Yk0Ue5VEUEz+EAy8C0sPjPWd
	 V0Eo4CimQB+dODoMV2oxlXCKa7M2PloRpDxlpO2EGi663vPx5X8Vvp9HkFjxhDqPlU
	 xQqg1T19tB0NaajMQ0KI6kBvuCoOyiPxg2L6lRFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgHFTdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgHFTdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:33:41 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9096CC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 12:33:40 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id k12so20271676otr.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 12:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fpq7wVyleeE3lJivC0yCSUpTWD3vPscmoHMBxV4pkMo=;
        b=Ola8E9AsNg2r+NHHc4cZAv1YL2AKrJeMwEhJ9CGOI1DSU/G/p9DIKZ8P17sSUlA0Uw
         XaM4aYKf8ckkD42uzhxhPsDd++mkvUKWGzD9tDGbGCBQn3ivY9ADwXtpI4zgmfvwSacC
         WN4KJ3yEwXygFqPvodBBUbBXzSBR4wlYyWLwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fpq7wVyleeE3lJivC0yCSUpTWD3vPscmoHMBxV4pkMo=;
        b=a2oBj1lrCbLodIjYM7X3tvvy9BlH9sGlwp67JbFbFJMV41wDht5wls6xJ3Tgx1Y57M
         BDIkfSRPQXpTYbf5BFxvFUyVdciIQVMo137J/SaiJ+wBIwIFoYSIJS49f1b0I7CFCGAe
         /mwG2/fof6KV5oh/8Wsq4e5n+7ZwYX47wsMwslH4UVOWs6gxgL+C9k1Tfl5ZQ22w3Cp2
         E7+TbA+Y4Abs/699yeo06UG8xYu6arsI8e+srlRdM7WWlYdqApY5IGTlaEiqhLmtBZ/t
         zIBFsUW2GFJw04ZulI84M0OhcXv3r7iFpQhEheyEsI5Ynlt0xr1BXfaNkRFiEhlPf3XI
         WomA==
X-Gm-Message-State: AOAM5300GGduawSyjZO9O+jfTizhsfw/7jwmKH2QF+8aCJ1JarivJvJj
        fJq/m58Q4Ta+cnHvsTXr46ebmA==
X-Google-Smtp-Source: ABdhPJxgp4Nayzl+OkCvCOgm+xl3uLGJLuNhSxl78NDNfOLJhKPxR58mqm+F2D95N2q1oQbisl2c0w==
X-Received: by 2002:a9d:148:: with SMTP id 66mr8490804otu.132.1596742419998;
        Thu, 06 Aug 2020 12:33:39 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u72sm1285719oie.22.2020.08.06.12.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 12:33:39 -0700 (PDT)
Subject: Re: [PATCH 4.19 0/6] 4.19.138-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, skhan@linuxfoundation.org
References: <20200805153505.472594546@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <909eb769-8c3b-ced8-94ec-53bf3a6696be@linuxfoundation.org>
Date:   Thu, 6 Aug 2020 13:33:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805153505.472594546@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/20 9:52 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.138 release.
> There are 6 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 07 Aug 2020 15:34:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.138-rc1.gz
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
