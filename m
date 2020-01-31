Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BEAC33CB7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 04:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608D52082E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 04:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580445630;
	bh=Ta2jxYoCTaMj6ZPCMVj7SFqVYYk1bB1EHJ+ZCYkQBMk=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=k3hlwhLSNvkDNjJeXKPpcsQdHuWSieUFHRepF4Y98fxK+UPDjytf7cb/rl+EXQSKK
	 qo4S8Pxv26vgpRWE2vaC+Ndjgv0ACcLjsXRSAxsvqw4STctajl5GAxQiloDyAR8yvh
	 SeeE2e33njtVl4st4wO/EtP978srti6EloLDwyJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgAaEka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 23:40:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:37354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727933AbgAaEk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 23:40:29 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 945C920705;
        Fri, 31 Jan 2020 04:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580445629;
        bh=Ta2jxYoCTaMj6ZPCMVj7SFqVYYk1bB1EHJ+ZCYkQBMk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=0iso9VS2NFj+BC8yiQE4wsZvuqdQhuHCJWucb2ydA8LDPPgh4VuMphz3FVP5m63Iu
         qai1d6CDalXi0sXmEdJU64FLBWAXV/c5ZgNzT8wAIeINcXbFTZC5QVPryFbuTpk4Cm
         UfhOGintwtKbjTWxTYiVOMI6f51omYD/F52OUFBM=
Subject: Re: [PATCH 5.5 00/56] 5.5.1-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200130183608.849023566@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <a99ad773-c0ac-f887-5f74-b47eb395803f@kernel.org>
Date:   Thu, 30 Jan 2020 21:40:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200130183608.849023566@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/20 11:38 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.5.1 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 01 Feb 2020 18:35:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.5.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.5.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
