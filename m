Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE57C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0880F2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579277127;
	bh=x7JuI1E9wvqitbssRJlpjo1FyMOuFppcS76BVDnU0Fw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=yk8bHJv0MBCMDBcSCbZl0x7AJwpXnt2l5senkPJXcRV8y+lMf9MYk56hmZrG794bL
	 2FKBgW+yEynvqxUsDNdGJzDUpnMCZRtZu3mhaYwI0mmt+GcI021bwxA0zipG9oLMCq
	 pN08IRHoR3J6rHurKxsdP8YeNBCsO4Pi1tTwD8Bw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgAQQF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 11:05:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:46552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbgAQQF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:05:26 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A77B2064C;
        Fri, 17 Jan 2020 16:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579277125;
        bh=x7JuI1E9wvqitbssRJlpjo1FyMOuFppcS76BVDnU0Fw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=x+RZocghEOCxn6x7gzZJyIx3svF7CLvQ14RSl/TL+ZpXLS2OZNcFnILQL2scr1sCd
         WquuDCE76pR3Etml5R3SY669ZOc4jIHKVrFxRTiuIBvbwh+mtT38vIHTx9rEpk/uKk
         kyA/4EIraIEFArWm6j+/7A/Gr7WfiOoJbbSwPTWI=
Subject: Re: [PATCH 5.4 000/203] 5.4.13-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200116231745.218684830@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <456d28d9-1a50-5445-bfaf-9d87bfeb185f@kernel.org>
Date:   Fri, 17 Jan 2020 09:05:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/20 4:15 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.13 release.
> There are 203 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 18 Jan 2020 23:16:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
