Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B165EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 23:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DC212073E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 23:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597100670;
	bh=H+velwRWEKxLklWwiJHwHQRbdbAG2Tx/nXEEIFVbi1E=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=EX1bykaJoupAoyHADIICcgNaj6Ggc4/WfFL6agoBCrfWkuesICCkIW2UaKAiknRXf
	 qtVA7Eo9UUbeD+MFR5E//4MS7BNGyZtL8uVi2ULiAHZJJyHS8QOi+Zt9tdDuEKBfR4
	 NoDt/WxrejOVU2LulhbXmKLqtM5LHJfwn7AzqJqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgHJXE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 19:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgHJXE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 19:04:29 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6BDC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 16:04:29 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id e6so10503988oii.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 16:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XRtSwbypZFNRRMuQ+PKBEYpCpUDWNU/PfWfWLrKLeDY=;
        b=NGQ1lwTgRg5LyKNoISD3Kj4Wah8d6ne82UhNakoz15/7O4FSnLbBeZMHRDPu+8Df8d
         TnluECXDZ1Cy27IgtX3tMuRXKkKpHvO3efQEzoI4LbehpL5RDAjI6Pkx9hnf353M5k1C
         +RlDGEZ8k6dMmh4PQQLrJelre65Td5Ll5x1Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XRtSwbypZFNRRMuQ+PKBEYpCpUDWNU/PfWfWLrKLeDY=;
        b=ESVvVYBgKqUzBf3aI9dKmaKtccanOmN6VHa3D8W5C07VuvsrsSM6FV3EPMrcasREQN
         dddNLeH6a7oMYqFz5YXizy0mK9ptgTmLSPR4dEkOiaqTrKb2tq6wjwqkvMSYAynAInMa
         xbSGY1I1GT7p/ZKIQ/M1TXBo96z5yvk1RcAzpcmWLJl/HSwjb0r84EtWO3rjGCh0oSbk
         8KRZklZtWtQuVhWLk2DLxQvSRrQdcVIfpVV4ltG84EWccW4SsIy9FrY7j6I2ikaVYv+F
         zUX1LHIpYvBWAnVhBowjz0lTBRuVWlE8pPABolC1NC+bbH4Pi+KbNKJX3ENSYhuPqnM1
         IykA==
X-Gm-Message-State: AOAM532Wr872ctXPhHLk293r/3iumxHOrXzwlUiQHCw4NkbsP9ecfZ3d
        MbthEmFjqn6TovscrUuH583vqxgMDOI=
X-Google-Smtp-Source: ABdhPJzNIWb2lAifa3fBKatQjQgacZAoLvxtlcFCkOdVE09pMIFe7l7P5zh/hLEQrLD7mw2GqOA8qQ==
X-Received: by 2002:aca:ab82:: with SMTP id u124mr1322124oie.179.1597100668539;
        Mon, 10 Aug 2020 16:04:28 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q7sm3712420otf.25.2020.08.10.16.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 16:04:27 -0700 (PDT)
Subject: Re: [PATCH 5.8 00/38] 5.8.1-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200810151803.920113428@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4ee644b4-55ee-35b0-bddb-0c4e95259151@linuxfoundation.org>
Date:   Mon, 10 Aug 2020 17:04:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810151803.920113428@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/20 9:18 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.8.1 release.
> There are 38 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Aug 2020 15:17:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.8.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.8.y
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

