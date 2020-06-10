Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D44EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26B5A206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591797806;
	bh=zUxvDp/hbeAfwacdlzAqSVREMjwK17J7BlQ9zX66ITM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Ifn+MH4C2NwuUqOnAgFjB6hv910xirubW+sEWBKIytNyd8pGDOrfqsZBk1Jmf66bV
	 JoKMuKzApqMdqGXII1qcCMIuOccyx5IgI3H0GuGhOu66nJxREFG3Sy9eqldsYbNl+3
	 SrXIrsvELgxHyAPmNnh9YWsMNbVNNbx3clSupdaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbgFJODZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 10:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgFJODW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 10:03:22 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD08C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 07:03:21 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id 25so2100384oiy.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 07:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pdw90hnvM5VkRq8PPTPgpbDRpCg5mWZbFW6n0mIUA5o=;
        b=h7aCFKTThqYTJWpGrDz/oLADlgfZzrg+dH/UYEn7I/iJeYenhsf3CjXeQU/mrU3UNT
         BJ4aTf/BvNQ/+lh1HnRuN/Ovlonz69LrNwwXszAu4jWEl9mZUVqj0adLPlU6wL2R/OTX
         BqahRLGg1JZRYqWe41+3jnrTtbpqgdh+z/w14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pdw90hnvM5VkRq8PPTPgpbDRpCg5mWZbFW6n0mIUA5o=;
        b=kpqKqIo3JzeNgiKrPGDMzfA/3uZ08YAH6/YSOdVEw52RQGiSx5pzIicHxGGMXuDxHT
         tr2Rga9OvXgULFEgEz4fjCK8+zJxx1tWJHjpzVlNfjz9v/N03CZQxRjw2lte8/mrt1i2
         ZVySs7y8zgEBZBI+Iku42N6+PVzh3LFOGRDux0WT6z9z11QXB5garj3NWWfTfr9BiYVQ
         0RgHsb4xi4HQFSDWmUvgH4WImj5dIvYAxiuVeW3a1tMxZURBY0DwX9OVxK8uODqtb9Ol
         O9QnrynZd2WABVQImd/h2QvIsTrns/QdRwwRX8t28l6dZ36ONsaT4xoZ5Jy7CcWCfjBS
         8arw==
X-Gm-Message-State: AOAM532yJPZfccwdgTwDgjwYFLHo1pZU1WOlVxnj7rUBVZnCqlcJxwx9
        G7g2cHMvMlp4RdbylYMsiDbTZA==
X-Google-Smtp-Source: ABdhPJwfL+uzw9PhiKOiTCEqVNkoHNohe0UEh37apdS8YNoLjVTNu66Demw0rCHHJAl87TXI230VXA==
X-Received: by 2002:aca:88c:: with SMTP id 134mr2391878oii.99.1591797800648;
        Wed, 10 Jun 2020 07:03:20 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id p9sm17621ota.24.2020.06.10.07.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 07:03:20 -0700 (PDT)
Subject: Re: [PATCH 4.14 00/46] 4.14.184-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, skhan@linuxfoundation.org
References: <20200609190050.275446645@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <dea7a253-ba09-07d5-f52b-1419b5b68559@linuxfoundation.org>
Date:   Wed, 10 Jun 2020 08:03:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609190050.275446645@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/20 1:18 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.184 release.
> There are 46 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 Jun 2020 19:00:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.184-rc2.gz
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
