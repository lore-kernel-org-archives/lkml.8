Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1DBC47257
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 23:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5159324953
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 23:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588461486;
	bh=3UwIBFGwFAvp9d1yqwSPHDvoBLqMtP6hEaiZ1SdIE30=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=lGQkgLTBY793/HV3Vo5Uu45ZGVRmOTUviMXp0A+McRVaLi0unYdVHfoYS2etSuldF
	 pXFTt3SnaN5h1UHJ290OTLQ4Vu2htPWAq4PvJYAgT3M0vv/e4WOLPExUbRkeIgc1a3
	 DHZGHrR1fU4Vr5wD0kTkCiiO5tiLnsxVzlxuDsvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgEBXSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 19:18:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgEBXSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 19:18:05 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9542420787;
        Sat,  2 May 2020 23:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588461485;
        bh=3UwIBFGwFAvp9d1yqwSPHDvoBLqMtP6hEaiZ1SdIE30=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Na4OGiOPhD+jS50ws/HZo532kZJtfsqds6Fx4aRs8Gils3jhGBLVtFZ7Bd5s/pht3
         Dd4ljFx4HDEjOgif/2KKZwlgB4sy8C6GdfYkSdOxnMWU3V5SoGpFGHWb0LawKX4tvX
         Mkrg1QUUJmbSoatZmZ2MPOAKm9fSO6wL6PvX2VFI=
Subject: Re: [PATCH 4.9 00/80] 4.9.221-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200501131513.810761598@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <9f9dcc62-a3a2-7e08-04c9-bdf37db3c4b6@kernel.org>
Date:   Sat, 2 May 2020 17:18:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501131513.810761598@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/20 7:20 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.221 release.
> There are 80 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 03 May 2020 13:12:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.221-rc1.gz
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
