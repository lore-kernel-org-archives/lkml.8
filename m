Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22F6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9F942173E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596742266;
	bh=GPdnnVf+wkv0er6lGVlGC7WSPLCoYPkeCb0XPhe1Oc0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=lnYpVXmG4HehcVL09JOTanaFts+NLx7ZXvzgEsX6UDJZu26fJ9sk8j/gO8KnqnpaZ
	 0y/JflEijUgo8MNN2uOchlVCM5W0O/q9aTbsCRDA+Ah89CT4xTalYFaZd2XdYceEY5
	 +natKV5LVg48QHO7Jf2eb3hIiD3gvocRcCKqgF6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgHFTbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgHFTbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:31:04 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0F0C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 12:31:04 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id a65so27915045otc.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 12:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GeRu59tlMk1gr3XfJOJEPZ16YIlB7a9bT3FSbDrlFNI=;
        b=PN/ZVzhUkybgP1iS/3pgofGQLIstZowSVGWyaA3VZLSQACZ1ltUjBTxAldLU/9Xmr3
         9360LjGBU4FLmna/CBUYITDmAW0HLyhVIy4kR08/3/5W7WQuJa+75XnfE00Re/vozRn+
         AiRG3+y6siXSY7Wz301LjpU0jWSHjvwwymRaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GeRu59tlMk1gr3XfJOJEPZ16YIlB7a9bT3FSbDrlFNI=;
        b=CZ++iVAlGsp9b180IoamY19hLX2WQoOOmDZl0xuw2oXuQy0obF9CX6HcnLUvACgv3f
         lMVnDc9gAFFnZJBJ0WchRt405X8CJS46NqFB/S50HINtZKdfjgN9V94jYtVl++5/nSSU
         U6DVI8OK4Ugyzq6cZc9tQFc82gZcpt89N3o9Fx1x5prIzTyEAEcwPdeIMAmhmfcYYqdW
         +CW9nStRwrnX5lUUKauHLlPFv/AZafhGH5lY0KgXKgmquo4ytjQ6HH4H3gbETQ8X7iTl
         fSu4X5TW5yrgN3DR0fH/opGe8PSjFU0eRXgvHv55+h86Ie3rFPR47TXN1iLBTC2A8NRk
         xAwQ==
X-Gm-Message-State: AOAM533feutgO2oQv7+S3MLQn8MJzyf0i/YxaolXmf1YxZGScy5g+YVS
        I9loRoIDC1EVG77b4HDn2oz5Tw==
X-Google-Smtp-Source: ABdhPJymGxB8cteoqcTajGgZEwlxw18mQJaEqCGCcgB8dv+BIN9kMCgkhniIyQ83D6CY+yWzqkMOcw==
X-Received: by 2002:a05:6830:56a:: with SMTP id f10mr8272484otc.247.1596742264014;
        Thu, 06 Aug 2020 12:31:04 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id p64sm1266995oih.39.2020.08.06.12.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 12:31:03 -0700 (PDT)
Subject: Re: [PATCH 5.7 0/7] 5.7.14-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200805195916.183355405@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <fb676589-8646-0120-d743-a3744663326d@linuxfoundation.org>
Date:   Thu, 6 Aug 2020 13:31:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805195916.183355405@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/20 1:59 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.7.14 release.
> There are 7 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 07 Aug 2020 19:59:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.14-rc2.gz
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

