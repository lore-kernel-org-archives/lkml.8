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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2978DC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 080DF20578
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598999130;
	bh=Qw3Y4qgT9wVJM+xu1/Q8xmb+yLWI+ZHo8cEyTx0N4DY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=FmwQ10Q7c65Z2p+iMiuSgC5iWxkkNq4IAAfWcNU+WYiP1p3yVyL5Xc1D/c8d1UpGr
	 PKsG53s8m81i0Y4uASHEn4Ow14C+kSnyozxDZbUGoyz0ouICGYX6fc3KWgYzzp9jCe
	 TxKiMT3sPRcRHxJ5JEUR8yWHRkGniiCOUVzpRaac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgIAWZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIAWZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 18:25:27 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A6FC061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 15:25:26 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id e23so2592530otk.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 15:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Yeewx12qLKB4TGySW2pJhTuDPaEyodFbF3F+b907ybc=;
        b=XjvJc8w083w+AVX9qGcMvSjZ8tHUdN44x6QsU2gflWOxuBTft9+95zsF5TR6F6akOk
         RLxC7GkVuCS2xWSS0u2TqENjzMLn7HHkeOZEg6KomPkbnJflWv76/brQR0DRscFrlFu9
         vejl1mabJSdCq4kVPo2EHa//F7Z8SvrvKDJYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yeewx12qLKB4TGySW2pJhTuDPaEyodFbF3F+b907ybc=;
        b=tblT2GFjAAVL/b0ot7fvW/GWBj2GzvRcduERQbHaYjNt8eVJx/4I5EyFDjFnI4uAnt
         5x7l68mtikjLNmClxjTvBtpNrGViLeB3blLXI4FlHWNGBQrgZH1R5+puDgis0gcRHlMu
         +osJzsdg7c0k0tNgbdPbfZEaynAdBtxXYzVnDDWXk0VnxmheZdSMKaxjbk8JVdb86Sed
         bTp7GphcR9lKMAlVcCAwGZSNQ2YDecoYlYaYVqpmuCaNB3nrzF3eGjsQR3ooBOSyEzo1
         UeO8MJ++Oee8VSepEnqoI9/80bh4dZQ2CfAbx4wIXsjVbo85K40E04m6T+q2E83uel9v
         TT9Q==
X-Gm-Message-State: AOAM532s2IoSK8NSvaxNuUhTkuKGvxYmbU8Oivk1MGK1CxqvDWvauzKf
        tNlVkiVJgH75ZIqttnlvEIXGrw==
X-Google-Smtp-Source: ABdhPJwst0xtfYUOYcg1BW4vPIgCBhP6Sh9f0PYiGK4uFWJ+pl9IETurWsOkFjh1FjwEIN4RXMJSvQ==
X-Received: by 2002:a05:6830:134a:: with SMTP id r10mr2883686otq.252.1598999126171;
        Tue, 01 Sep 2020 15:25:26 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z12sm464223ooh.41.2020.09.01.15.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 15:25:25 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/78] 4.9.235-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200901150924.680106554@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <83fb2e3e-c7b5-962b-ee3b-8b2081f584b2@linuxfoundation.org>
Date:   Tue, 1 Sep 2020 16:25:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901150924.680106554@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/20 9:09 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.235 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 03 Sep 2020 15:09:01 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.235-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
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


