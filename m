Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73563C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CA4E2078D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594220999;
	bh=jWbIygxcjBuw+Fa6iYlrC9vPat8plczsNwXJ60XXlbU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=bWEfiYTGfIPJMOFYUujFqZsVvfqeEMhvNKJBhhB4PVeZF/X23afxfwTAEqhRb+nCB
	 9JlvBxwcZAyVnPYqeVCuV1xODAj/Jtw8moAZOmhk/ul2NM23/7y0Nvo1dnK6p/mIhv
	 KsMJlUGLdjX3t4gvi1Y28Ca/SutjTKLYMhqGAzFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgGHPJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgGHPJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:09:57 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA67C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 08:09:57 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id p26so3024963oos.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 08:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RWj01bK2pV6BNLG1xOO+3qo5uJchifSrRn1MyFV208k=;
        b=JL7Ptq9v8mdFU10Yb7O/YO4CxQYZcvDVSnB+qXTzB4NbiDvIYQ0ewjqUt0qeaYw5nW
         ltt/+5vEYCEg9hkpJudDux2YWtqB85ZRfe6NBuEf3fks9jniYOxoLPG/39GKaTWaNgoA
         URbZJFP9ISJ6I2eGSUq/DSy13hrJZdBbOk68M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RWj01bK2pV6BNLG1xOO+3qo5uJchifSrRn1MyFV208k=;
        b=RTVf3jpwA7BF/KBmYeQqDGlpuNYvLSa7sCLsiqa1Ln+s/Nuqi8xa2VpPazUl/XI1yE
         btHU+66T94xrVJCkrCfDg9qMkpxNJ5m5r6dyYBK1Xux/YUujta5YXIO9+fNYRJf+Ez58
         kmzyA9jxtGVuqwro6ifPbfve4kSNX0eRK05oA7RQkLtdio7vK8UylhQ+/YezR598ZHR3
         P3YB4FSLZPh9ZMkXI25tkVn6pjxQBiwgNILXO9FwK2RqmrUiE4oOkIf7iSj8xK/zRGrg
         ud01x6WVAnBtwLte41qu2weyUuw7uZNIYNCJ+vAAyyoiMeLRs1FWecJP/KU3KEj1CisY
         ib6g==
X-Gm-Message-State: AOAM531+GJP2Q9ftoImY6RZAMU+DyZmBXyRrXY0BBB8b2xaI10soNoHL
        Ozl6fQC43lhVXSjuTwpiqSZ4LjNblgw=
X-Google-Smtp-Source: ABdhPJzeDU0yQw5v+TRW2Xctx5qi7v/jAIXc8qXyGs0qRRPjjtgTkEOTV2OBsQa0qz3NFmOmj3jwrA==
X-Received: by 2002:a4a:9552:: with SMTP id n18mr10303586ooi.1.1594220997010;
        Wed, 08 Jul 2020 08:09:57 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y1sm5770oto.1.2020.07.08.08.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 08:09:56 -0700 (PDT)
Subject: Re: [PATCH 4.14 00/27] 4.14.188-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, skhan@linuxfoundation.org
References: <20200707145748.944863698@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f11dada6-53ad-0e0c-dfb8-53bad936a253@linuxfoundation.org>
Date:   Wed, 8 Jul 2020 09:09:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707145748.944863698@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/20 9:15 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.188 release.
> There are 27 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 09 Jul 2020 14:57:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.188-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
