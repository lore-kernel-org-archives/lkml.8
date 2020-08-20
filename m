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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028A9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE7E120702
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597967857;
	bh=mRZEEU1eAlxEsBes1vGNrZ+O1f7TL0Bib8IstYfJ4ac=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=GzB8bxD/kITAGQ5Rt97xcWFpeNiM2NRCtqHFSPbcIbM91IMsG+eUFW/5BFcjE9b8N
	 j5pk1gkD6/A6P6ZGyDpbjLFKg4BrKqafmAiM4bLsyvyaW3BXhy8DfQDfKulrkT06p2
	 IR7Ril4/2MPcOx/9AcD79JnHiDjITUmaLX7QGzN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgHTX5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbgHTX4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:56:12 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BE3C061347
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 16:49:34 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id u28so816882ooe.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 16:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oZUvMXwXY9bt259tMB/dgK87KeJSN3Vs01nZPdrO78A=;
        b=C9+RYfwhiHcu/DG8B5Y4xBoyEXcisNFMzNg4zMWaPkGdq/mJLj5HuMz76ui+ED1IoZ
         ZvmQrO+I//F2J2LvXcQq7b/EsfnG4VhxHk5wLA7HRZ/3TbUGDVLN6iFnv2WbNSQNPTJU
         b7utLb5kooAMaJC6TVQ2n/lJ8EO5UTkN7ksEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oZUvMXwXY9bt259tMB/dgK87KeJSN3Vs01nZPdrO78A=;
        b=pQMzB5gKVSEZPVTNBC5zxjZMD66YBaO7ltmMWKbojdqQLS/jXz1FGCWdEEGgIsIf9B
         LPBHgfjvtVjIJQcwEv/vFp5LAbXr/Pt8OPi/eo37ZbkEReQ3MRXHNhFeN+9rNm0nL2SC
         lqwpPlT1HhfIN1jV5zmvAXYLQO2JdMPMCC4/qKZeqA56g0NCqRp+HBz5EejI0uGOCK5P
         Y/IpGXue1yPYRduvTwiUDEBcEYADMFnkfrXnirpMZxun7pR4Z8RF/ExqsI5tkIb8oN2a
         tuBxpkYni7mTAW3lY9uASFIFbchiJ4Qj9LVRrqMIgmRg4wDKxm0N93BWlMNJSvK/I4gX
         ciFQ==
X-Gm-Message-State: AOAM5339gkrdr4ZHvcDXcRp/pP3zOHZKLlYVhBXVq9a3i2/zXTI/iXvR
        HxRJmMwG0fvMJYhM+9Mju2ABsg==
X-Google-Smtp-Source: ABdhPJz6OO9q7ynYl5AJf7S8zZsBQqOYtZKomeZK0jBP8zpo+ipyqidMANn5GTuDtuA7RM3M1+v3rA==
X-Received: by 2002:a4a:9441:: with SMTP id j1mr188845ooi.46.1597967373707;
        Thu, 20 Aug 2020 16:49:33 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n74sm15785oig.54.2020.08.20.16.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 16:49:33 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/92] 4.19.141-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200820091537.490965042@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9f2a64dd-3ddd-4559-aa37-c11265538dc8@linuxfoundation.org>
Date:   Thu, 20 Aug 2020 17:49:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820091537.490965042@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/20 3:20 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.141 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 Aug 2020 09:15:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.141-rc1.gz
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
