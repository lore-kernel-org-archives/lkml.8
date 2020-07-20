Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C25C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5345B21702
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595289012;
	bh=zQN8TXtWpstMnOK+J8IGrtKDr9qGvt6nExweSvBo0EE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Bc88CrYWR/AtfclrK2TY7UbW3DGCHTz0rbDTLvO9hxhENaNj4GyhKDcLMHXa1fROQ
	 AasW/BQqWhQ2xzwxO71xVhssetc+oR9k2Bam1tS0ovpxyuDaPrECxpa2IMEt5Ownql
	 dCxsWPncJPahgsUSAnXDfFYk0zFHBj62emgt9z48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGTXuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 19:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgGTXuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 19:50:10 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53968C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 16:50:10 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id w17so13693125otl.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 16:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K6pANJbBIpZEsh1nQyh0JxNSkniZqlV6WQFGpOqrBB0=;
        b=KP8zbU3YvI+0BVknkJUveCvpB7HyaZRRRgG2NHoPNiB0In6TWi/R9UpKDhMxQzNENB
         jAXdIZic/5H9TNLXPgZs7xjLGYS+pYvuFdVPrJ29W2HEiEa4tq6wbs+QPSVea56Yz2SJ
         KhOZNjsOew49k4U2hWD7aPXD1nzbN6/41RvKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K6pANJbBIpZEsh1nQyh0JxNSkniZqlV6WQFGpOqrBB0=;
        b=R2BKs8rMv6nORiYD0pK3L1yLATCt4TVq8u2D28j3Ugxbjun4fVys+X7Rvhet8OPRTH
         /ZTLF3DbONMKqwWt9E/KmvZtvY53gOwgPpj7nzyKWwfyBPyGliajUJQ1C2l7qkwEaAUx
         Q/1Yd7ARGYjeyT9r1S7xE5TKYib7CPuyH+Coc7HD0HN8p0mMEKiCkhurKTfZkmmeSXaa
         TTXN9g88xvWs9/hPuZEVU8xvlnS5HYFQ9c8UNc/IjTaxHN3nS/cKCrCFBP3dkC9eR5T5
         F9jWb5wZWhsU0bnj65dQFae2mjMDq7eSdu5LGybsidcXit4ceeB77ZgZ6+fLhC2rNDOE
         80HQ==
X-Gm-Message-State: AOAM531ddkuBZwnMltwsXCDy2qDFDzpZsKDlncTC19RxqU26ccBDmgFK
        WUyOx+4a7fjqI0mq6JAzREQFaQ==
X-Google-Smtp-Source: ABdhPJzTk+0gVu0yhsMbxg6GE7fosczEpFrAss0oSAuZms4ImOHB7Z7U5TwfixOgc3i5YTWvYUGHFA==
X-Received: by 2002:a9d:674a:: with SMTP id w10mr20151416otm.305.1595289009715;
        Mon, 20 Jul 2020 16:50:09 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c7sm280422otm.19.2020.07.20.16.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 16:50:09 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/86] 4.9.231-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200720152753.138974850@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <513ce41e-9a8d-f9aa-eb45-f37add7399ad@linuxfoundation.org>
Date:   Mon, 20 Jul 2020 17:50:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720152753.138974850@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/20 9:35 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.231 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Jul 2020 15:27:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.231-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
