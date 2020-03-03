Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4E6C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 23:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D60208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 23:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583277505;
	bh=l220GedQk5uuMioZw3M7k03ycV1DqXP3XK6IVLLNaRs=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=dzb2obJhnLY5Uppvewd6rRQlJFPa8GgckKzpXFHOaMi0095QSzxrc2FHjsR/Te+ZM
	 Hl/yHmYxLLMsl713POECpZe3wHgm+6gnmN3YrwVX+nHMoj1yVYMmaFKOf+ae9xIWPq
	 jI5ogmKEJ+zv8+TrakOtFTOBw8KQ8lIh6X/ZxMpM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgCCXSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 18:18:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:54064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727429AbgCCXSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 18:18:23 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1F7C20870;
        Tue,  3 Mar 2020 23:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583277503;
        bh=l220GedQk5uuMioZw3M7k03ycV1DqXP3XK6IVLLNaRs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=2JyKbgH8WMqyXdfdtXmC+qh50gyty0Xiqx8PX7N1VEwpArJu8np3arMUfgB5EvqcA
         NfV8buLHlBhUdbc4ukKDNOH960I0FVfMNtd80jbb4DWvJBJz94ljJAPyG4JDWokYIM
         YREGWp1WQJvnVzLQ6y+uWzhkdtWaBppT1xK5LhRY=
Subject: Re: [PATCH 4.19 00/87] 4.19.108-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200303174349.075101355@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <559039dc-05d8-4267-fbe0-f2df1b18d514@kernel.org>
Date:   Tue, 3 Mar 2020 16:18:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303174349.075101355@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/20 10:42 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.108 release.
> There are 87 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 05 Mar 2020 17:43:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.108-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

