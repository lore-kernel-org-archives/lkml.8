Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7AFC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 23:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639C424683
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 23:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580252762;
	bh=KOr8AmOoXcx7hQ7QiVbvqA4e1lL3bFF0I8KpWIXPoIk=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=BFbI9dJ7Fp9vzxjNX+00lGrLykXJCUDCW7sRtznmygLGjg3gAhdYWJWIadg23G4t8
	 G/V0+wNjGo3yVtjNocfNqJMsrK2EjM7Zn7wR0YarlIiswt7MZFKKV0MomRBLK6KjrV
	 flK7w8n2Vsawf6eB3nwFSksNN5BC0BqBfQ8jO5tQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgA1XGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 18:06:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:44564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbgA1XGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 18:06:01 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A4D22465B;
        Tue, 28 Jan 2020 23:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580252761;
        bh=KOr8AmOoXcx7hQ7QiVbvqA4e1lL3bFF0I8KpWIXPoIk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XatRN97DZc+iU94ZZC8A0wTO5j04Yqi8T0zCbzRu3d/PP1gYCQvNZSvgzggS3oADC
         +W33xQUbjio7U1lthKsBVJz4QMUQwkAZsl69cSuLrh39ucHGSlKBZpp7YgszZ8+7mC
         RDfoBOVaddh3POmI0YbJY82B20atmJW/VjI1AhpM=
Subject: Re: [PATCH 4.14 00/46] 4.14.169-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200128135749.822297911@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <9de817bf-f0e8-98a3-21d3-4a1b03070070@kernel.org>
Date:   Tue, 28 Jan 2020 16:05:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200128135749.822297911@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/20 6:57 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.169 release.
> There are 46 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 30 Jan 2020 13:57:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.169-rc1.gz
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

