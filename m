Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B32C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B99AB20702
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597967835;
	bh=R2pcanlR+9lCe5ULBDyIV7b1clT8q8FHWbulzQAyOtY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=KXfl+kihBpSN041AC6xkjMipuGH/LMV69M/NsbqLJCYqc/d4qL3D/T5LCiTLGcfgh
	 3wQASH0nWilJgj82FHjSpeJT0GMGE7+uzyg5H3iZBChIOZr9e8jeRAfC/OAxPx7uZV
	 ttKTN9SJAF4F9C650EtX9koewU+2LET55wfgylyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgHTX5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgHTX4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:56:15 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788C8C061343
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 16:48:31 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id j7so83679oij.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 16:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9uGyMrw33yyhGegWP6BmwqpFM8yRbxnIVbZ2SWMKUmE=;
        b=ZNnMHRgebTN450UsDfLkrghESFEw+aARdiKwrAd75mE34IyhxAPeQ6kjShKImqpJXC
         CtccYsB9jMJxjxKD0eqDan4QJA1qBlAxlGOxCkqwZ7UqgTk7WINtDDY6Tg+GaNEocqhC
         bpFr/mPOmIqMjS5074u0piR6K09002Ka/0ftU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9uGyMrw33yyhGegWP6BmwqpFM8yRbxnIVbZ2SWMKUmE=;
        b=teg1J8/uA5xUF/TRFH5SJtRUA44JTxkuFfUaihSjee101iuUwDPkwwH7gJuVEjwC3q
         lm7wfByQ2ED0AJf14CsJLPSEvSDtYkHgkd/AV1c5ZYQNwPXUmAjyaVW4nWnJ5+Bc2i8k
         NPmELJqEIwDNvkvUK0oja0j3c2o7Ke6zd1Z+19dOfpS3vzlxXzAkZYEzu3m3iLdn7/hC
         i1N344PtdOXbh7gpc+yMUGuVTvFJGaNUdq2ab2t74d8urJbbBjhz56gF29zFSnmEl/iA
         CfSaJo1AGuJHvBEdNVeLPOXNzwwG3AHuw/m8NFibYMNAGumkUGZZCIrtxYWSdlT+qVA2
         m2LA==
X-Gm-Message-State: AOAM531LvEopJMPHD50JeCSMojKsDBA9LXdlQayWCg8nwOp/8pUBJni1
        /Dvcb/ULF4A9tpI69MT+ogGjtw==
X-Google-Smtp-Source: ABdhPJzU8rD3OU7sHs/RuDxl1HsFpLL/ld1LkoijEsv1ja1A3ZhwfzkBId87G/6Ywa9lx3pCYK1CVw==
X-Received: by 2002:aca:504f:: with SMTP id e76mr157677oib.87.1597967310932;
        Thu, 20 Aug 2020 16:48:30 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h68sm30460otb.50.2020.08.20.16.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 16:48:30 -0700 (PDT)
Subject: Re: [PATCH 5.7 000/204] 5.7.17-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f8a27d7e-c326-8ee5-12e9-c04f4ec2771f@linuxfoundation.org>
Date:   Thu, 20 Aug 2020 17:48:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/20 3:18 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.7.17 release.
> There are 204 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 Aug 2020 09:15:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.17-rc1.gz
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
