Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9C4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 19:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 901F2204EA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 19:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591817723;
	bh=6o0ldbIlocKYqBYaG+hP4ilq9IPeezuoq9GlxRs7RTo=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=RyPeItN0K3br5OEyneBn+V0H0qZd6aqQt7tntLYw6OwdaVEJAhP8zjNFnmyCCa82N
	 YzVYdW4wEYae0o7SOfHLCNSnDB6E+sG53jZdokZCE+2mRFkf55jD+6fVbhLhIEkXwN
	 paISrCvhsT5+jXdKJh5b+9axNOvXsegIXCfMpaPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbgFJTfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 15:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgFJTfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 15:35:20 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F064AC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 12:35:19 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id g5so2660404otg.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 12:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h8DwvDaJUW54D89L5CMJ9LLKG/vnyzMlJjqUWjz0Z8g=;
        b=C+Y4rLt2w3UZ1fcrpPsiMniHpA5n0CU8kGPE68MsI+ACFQ64MMIo+HXItyb5puP9FF
         16OLooGZARLUqNXn69uF0uku4IdQCpApKsLmFZkkIrVErfm/ssZO2HbWw5rJj7RWlaUV
         nOkE5sFXz/5Q2TYWrH9AJtBqF6Gt7wi8BsZCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h8DwvDaJUW54D89L5CMJ9LLKG/vnyzMlJjqUWjz0Z8g=;
        b=K2Q3mKH0exo1EMT9yQG5n/zgguWSYiz2DBDJ3ncRbnmaw9fHb8r9sD7VShPsPL7aXo
         Eyj8zIxDWAfFbF+pehtVBIkoqIuPqyaYWyYDIwwkIMG+rCLQ8iTuT3pC/TLDubKTHSMh
         X+qB1rb8lEQsiwUvDQAtHQ4VqPe0SHrDdZN5mEiEBm41BxvTvOuHtwRfvhlj60ys25Ft
         yZUuu3LFqIL00OQid3TZ6l6aA0nwGKRbBD/ycJnNQJFGfsuUj8SSQBe6ZlYXNmsyJWPm
         vwJVigc0W/SoW68aVoqAQYtdTxLIDfRZ/ZX0ULAVCgN/dw5JolqXnqKNd0NbqtY2Gwnb
         2how==
X-Gm-Message-State: AOAM5335VFR+BRWAjBvgcTUsHmnDjIvDlCJHOdcmw4r1R5FMD0qz+uB3
        dlMkUxWdJBljl8TYkgb1BsNn9Q==
X-Google-Smtp-Source: ABdhPJw8sENmOAJTSPxHUs5ygnsNC353XrXO+/GNlaXXENgexAxIVbyDjRk4pAiA8P5TacUy3Vc9fQ==
X-Received: by 2002:a05:6830:141a:: with SMTP id v26mr4006758otp.250.1591817718211;
        Wed, 10 Jun 2020 12:35:18 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w197sm168898oif.1.2020.06.10.12.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 12:35:17 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/42] 4.9.227-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, skhan@linuxfoundation.org
References: <20200609190124.109610974@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7f9f02b0-b568-adf7-0816-1505709875b9@linuxfoundation.org>
Date:   Wed, 10 Jun 2020 13:35:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609190124.109610974@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/20 1:18 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.227 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 Jun 2020 19:01:14 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.227-rc2.gz
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
