Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266BBC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8378206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598998967;
	bh=StUfsIy3qRL2tn71A1OmeFV+oQwme41WkLMps6NbwTo=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=lH3ewFhhR3Vd+UAztzSKE7x7Ry1kC7dcYXxOpdXPJ6IX5Dc9YLF/rOCDuK8M7MK7w
	 6t1PlY9tcCxoeWeFVx0IsxKiKyX+d+CPxy52BUn/GkXEd5bWhPVCL0UTSxsZqY733J
	 ukCj3Y3IWWfGPkNYl2iIAdk1brr5Bju5pHfx+Xsc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgIAWWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgIAWWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 18:22:39 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328F9C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 15:22:39 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 109so2593227otv.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 15:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3ER0ltEsDy6u1Dz73olx5pTxbVk1kq7hDykAcPOe3uo=;
        b=d/Uoy50Kuzv54wghayiKGcy824eN1I/m4AutGRLLdU7lpdYzD9U9JcfM6tgXDTrC72
         L6VABgZR17HHPE+XDURYMjkoKFyuVqyAh7XsESyGB6hf5UU/gVm7eSDCFnE4GkgnodNN
         j2xl4bkzGqAVMrpAm+pPTmO0y0WBIkthWWUfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3ER0ltEsDy6u1Dz73olx5pTxbVk1kq7hDykAcPOe3uo=;
        b=fNIdoJjWJqpvPkoKZNeIlLJYhlU25QJphzy29jNapMkoeX0clSjgDRTcSNEsPQxrma
         lY50XKmgxmND22cJjcpPXqbB8ChZfjXFzEtr6ps+uZbKicy06EdDyBeMxMxOBiU4djq6
         egozveKl+RtG2gFV+5NssC9thqlWBCFcnwUcut4UURJUoBcZ/eNTPnw8TB02YYUJoImJ
         Oes7h5Jt24URc0Q123bzhBnSsBeQZUDFno+vaXtr0/Rf+iP4CjfuO8Ep3QUElxXVfPrA
         Otqglv2aoXxpNn+YMXfw57OtOk3q6NyQmuvOGApxj+TdoKTVCaq3Y1K38p3XyOB7xmOZ
         8QBg==
X-Gm-Message-State: AOAM5315/wUDkqiLPK7w0qPs3CT+cSjBRR5Bgsxff3ldk0f0QII5hCfM
        YmaGSNcKGzIzGFkKKPsPcvd1xQ==
X-Google-Smtp-Source: ABdhPJzoQAftt1vQrLXjLw9PMDCUtYjUe3gNIkgrmpErP3pF8iGpyMTNXFBjRWwrxiQJVBmqx54jGA==
X-Received: by 2002:a9d:3d4a:: with SMTP id a68mr3107674otc.216.1598998958607;
        Tue, 01 Sep 2020 15:22:38 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 91sm434946otn.18.2020.09.01.15.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 15:22:38 -0700 (PDT)
Subject: Re: [PATCH 4.14 00/91] 4.14.196-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200901150928.096174795@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1856b9cb-a750-c10a-e88b-c7860509424b@linuxfoundation.org>
Date:   Tue, 1 Sep 2020 16:22:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901150928.096174795@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/20 9:09 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.196 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 03 Sep 2020 15:09:01 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.196-rc1.gz
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
