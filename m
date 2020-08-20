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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DABC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DBE420674
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597967872;
	bh=EUoMlSP1/zwIA7CbJKjrdhZSPu05SUlrK0BiwieEvGM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Uw0WooOQ5195y+1mCbFtP8gcFdkUYyx4LD4vDhKgjgDW3uTThr1hu3BTtKIL/KV5n
	 8K6LNHLumaq15HfngUmgHGGiTEzfkDTuEjgmECxwDvsBRaqhY2ZDSbwcAjOOBXTeCj
	 h3SltyHpn+qpSegBvkWmNsCKk+aqRtv8Jzw8OE88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgHTX5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgHTX4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:56:09 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3C0C06134E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 16:50:46 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id b22so91100oic.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 16:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vTURMoPYRKEhRabwzbby4L0vZjRVRN5hzWu4YQjs3QQ=;
        b=co7VQZAt/z6lz3q9qMAU9jN4pgo/0qnIxC1u5TjcCzWwOdKDEl1uhRvC/3Uar501Jm
         lbLXThUTTvoeAwTGomftu1/kMB0SLkfevuBrTVCVrWfPKvN0iNi0YITtGoJpETSxtbkU
         Gw28H/6UORkqKy5OLVKy2wTreoQOmWQroqBxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vTURMoPYRKEhRabwzbby4L0vZjRVRN5hzWu4YQjs3QQ=;
        b=UcCLeZqx2y/EIuOBSUrQu01D1cMzIZrYYf6TwKER0uSPulHWFpv9jdzcpiSOyhT6iC
         AzPlDL7m/ptfvp7tIPwWj6txSkOCL3m8IQRY7IAb1TO/mWl39/YWCcfSCyu/Hf0bObnc
         Ly9Xdz2x3eKHhFCdypRDObbXdkT/dRFEztgZpZueK2bIeu3k0JMRHZhZpiQRWd7PQ9oi
         IsBLuV5C2KUznalPpCxbiYH8obypg1fUJyQjXYKaEUv8jGQ2RxLN1du+H3BkViX5XGPL
         7OyWy3Pu7dYUoVzrlR+pq62j3zqgm4J6LomcdILjJpJzr1rcQiyVNbM/3HIxgxC+VyPu
         8OHw==
X-Gm-Message-State: AOAM532zEM5d5Iy7fOoGo1ZXK2nLXUHcOswTD3k+UqJ8GIMS1aXnM4U3
        E+H2O/B5s20kwADz+oTyC+IsPg==
X-Google-Smtp-Source: ABdhPJzKdM35MbRce3CRCIbSdBC1voTjsnxHyYkR0m71G0GhjGjKgbw3NNmnIf8Fh1ImXs+BxAcQMQ==
X-Received: by 2002:a54:4f1a:: with SMTP id e26mr238535oiy.171.1597967446073;
        Thu, 20 Aug 2020 16:50:46 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k4sm36477otr.14.2020.08.20.16.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 16:50:45 -0700 (PDT)
Subject: Re: [PATCH 4.9 000/212] 4.9.233-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <96e6b82a-1711-d963-d382-5dc816b4b4ab@linuxfoundation.org>
Date:   Thu, 20 Aug 2020 17:50:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/20 3:19 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.233 release.
> There are 212 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 Aug 2020 09:15:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.233-rc1.gz
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

