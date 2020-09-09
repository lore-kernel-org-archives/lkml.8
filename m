Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE56C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 01:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C71762177B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 01:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599616048;
	bh=HIZQAcIhvCWCDUalYUFNSvSXSQut6/KRl1BsHvQIMfM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=xO4g4kGLjfEjr4LG7JCn3uvEV9AKGK8mhAXaFl5TVbd7uidnZwKt5Bhzd37TZC9zg
	 Siwov9R0XRRNt54GQUO6VqNALeWGMCIZXsaAtxxg3MjU/EbEvwusKnn851o9R7wGHO
	 9ZB/QrxV5c6o/8tNdRp8zm5HTgUtUr+R+z2mfYoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgIIBr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 21:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgIIBrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 21:47:25 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D18C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 18:47:25 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id y5so960313otg.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 18:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7J7Og61LtakBvmJjtl5qwmWiJpdAG4wxn73qQlVnYUk=;
        b=JvaA8IDBUzk/iItxfRh7zYTrtZHZ3HNvLPNQAzQZQP4HoU8DQN8PFkILrp3FpvZ0QY
         xv9SzYeLIYUuBN3AvY4ttCEOQfXkYCcr31zb2M4iuEyoU4RluLbuU/sBKIAaO5o+/T6f
         ixFWipdv4UHGnutG974SCwjBkKfNcLiVj8PfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7J7Og61LtakBvmJjtl5qwmWiJpdAG4wxn73qQlVnYUk=;
        b=DoPFIktWEUCzVnqMokNnFUBnPFpOCC9O9Q+n8hRkpR0YiTGEWh2ZnH0SdJxFEzZ2xl
         z/urcFiSSKC+patwL9zG50sxUP+hW7ohLd00iruEpS84IbJA9CHF3M74aNjseE98fwf/
         vSPP82l+nIcW/TFlRWywdJPd5/k8wb2IVpxwvgbnIKwpfkcJH0VMBghjMi1f6507DkZQ
         Re3AJFE7slLnYxOhimmVp5mfcEnhkuej5sFNUjQ55FVH2/y7+6fDkgM14ZXPejgj8AuB
         YoF8CKsOJ0USTyEMgAmz4zDFFOOAuPIlBdAfCTS7zWW0APe1AqOvRg7k8UAEbke1/3i+
         EHmA==
X-Gm-Message-State: AOAM531BJQ/U1b8YGnj3V+zW230/OC8iWTNOP/QZO0d5r9ZyLAeW/8JN
        4iUUFZbOAshWcLjSS/ecx7NNGQ==
X-Google-Smtp-Source: ABdhPJwvyNDTdJEG9ZJhMMUMe4t15KpUbW1ZJrgT6n7AhiPuwxPlUMl1IimiBeLQQzpGpDiXVqB1LA==
X-Received: by 2002:a9d:7698:: with SMTP id j24mr1356269otl.112.1599616044677;
        Tue, 08 Sep 2020 18:47:24 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id p9sm174120oti.22.2020.09.08.18.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 18:47:24 -0700 (PDT)
Subject: Re: [PATCH 4.14 00/65] 4.14.197-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200908152217.022816723@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ef15d591-70d0-6be5-486c-49cf9c0bba62@linuxfoundation.org>
Date:   Tue, 8 Sep 2020 19:47:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908152217.022816723@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/20 9:25 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.197 release.
> There are 65 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Sep 2020 15:21:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.197-rc1.gz
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
