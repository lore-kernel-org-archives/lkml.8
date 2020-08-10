Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DD6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 23:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E20020716
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 23:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597101041;
	bh=jG4q3ELHTIt4bmHrO0R7MsKJX3YCWMR8nkFA0qP9v1Q=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=HsjyyrCasw+YDk4/vR2JnTYYDktMNfXhzHsnF+reSQ+4sDT7LeirEi9Jl2FzpUl1w
	 vxcIwYzvBfAAbhjjKzFDi8ajpDCPOgd1ZvBLJ4jplyJkwMi+TxAuTAMNSHF5gG8VDz
	 g5YELSEyG2tFi5n13ZXngkkH50yeTNiASzV2yN48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgHJXKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 19:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgHJXKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 19:10:39 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB4CC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 16:10:38 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id t7so8681370otp.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 16:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oDBSjRVdrxSdo/zb6G9D/Gc+1eHy/zbqd68BxSpTpsk=;
        b=Mc1c4nKbTFsOT0G6P5jppbmdXZv2/qIOeB3bkzjdsWJJiRrRXCOrGoazMoSM+Zctbb
         JqG2uvtFB+ACwNjBk1aCExZg1ItHW1dg5bJnL8lVOSt+Wr3u4jeeZQjoRrF5OTvSRp6F
         F7zR+VErwGS0ufWssysHVnCffP+stlCF04Ik0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oDBSjRVdrxSdo/zb6G9D/Gc+1eHy/zbqd68BxSpTpsk=;
        b=n+BGuuQg8kVDEulbKAAejyRvpnA3VRwv1FiKbrDIDAD8yEMdRh8FTdvOfU8x/WdwYY
         6mafXkyDN5POX7MqDAWWe6Bl7zkRKiacSHzwyYz7+KfiS7Wbqd1PL05ZgAUkpwMH1acD
         F1NyH6PzJ4hfOEbEPi/ljKFKYi6Crxp0Iy2fW2LEfxDpUbkaYodfRJuCFiZuTc/l85vE
         cXrrBUH6C1QPTPnzwrr4u0+NN1UkhPS13M6tmcOQLxYKjpteak1eGCZnl+YRvraGxJYw
         zEOggDBnrp26MWph1BU8s2v6MOq/bMiX5NVLJS87tI8Ye1AptRJY1RibSQsIHNvXruTq
         00fQ==
X-Gm-Message-State: AOAM5309c48ruMyQhof3VZaWbVcrxWcf2qEX8C6oTjuP/xl1JTpmznGZ
        /S8tAvnoushzLTVKVioUfmNkQQ==
X-Google-Smtp-Source: ABdhPJy4Rx2TybXq8PCQy6YRHxndxiSIIHUBHnhzDArah6ixxcRWeFKmLM4EwBMWZZ9G/3EBguOr+w==
X-Received: by 2002:a9d:6d08:: with SMTP id o8mr2607774otp.257.1597101037850;
        Mon, 10 Aug 2020 16:10:37 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v3sm3707410oig.30.2020.08.10.16.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 16:10:37 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/67] 5.4.58-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200810151809.438685785@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <11a22932-4e07-77db-7cbe-70d9e0c18603@linuxfoundation.org>
Date:   Mon, 10 Aug 2020 17:10:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810151809.438685785@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/20 9:20 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.58 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Aug 2020 15:17:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.58-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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
