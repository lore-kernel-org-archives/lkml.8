Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5AAC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 19:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64B4920753
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 19:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587499014;
	bh=ETifHYDRK1FzZJ6ND7rFAzLA3xN5oZGfPogquuTNc5Q=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=lv6QRe99EbM+zOraMb0IrOXAqqvdeG2Zf3K1REhNqKOCEJuAUMBt9W4RF4kVn+Dmv
	 S5CCpBddSpqAbT9ZhqdBaUT2zwpjfEukwcs2y4H73qllCj1IxjF3zpuJeX31cTS+BE
	 C96uPaItR/DN+OKNOXgugoFOZCEnog1JpApOxbyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgDUT4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 15:56:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgDUT4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 15:56:53 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3942820747;
        Tue, 21 Apr 2020 19:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587499012;
        bh=ETifHYDRK1FzZJ6ND7rFAzLA3xN5oZGfPogquuTNc5Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fYGrdLlQ6fiuttI3ramdPVO44yeoN8o1888LgBd/lARcHjSmUKvRaLOfskJE1JtLz
         MAm+V9o2QzxbLTcMl3TwR8ojRjJLwszOwpXIT6XLsNw+Cjh3sc4F/EWtwntDhcCSYq
         uCQ+wsZXZDOdUW0IUveXXlZl5OcvAxPzy2fynAqw=
Subject: Re: [PATCH 5.5 00/65] 5.5.19-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200420121505.909671922@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <0f30ba9e-ae8a-850c-04a4-1a96567b3dd4@kernel.org>
Date:   Tue, 21 Apr 2020 13:56:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200420121505.909671922@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/20 6:38 AM, Greg Kroah-Hartman wrote:
> --------------------
> NOTE: this is going to be the LAST 5.5.y release, after this one, it will be
> end-of-life, please move to 5.6.y at this point in time.
> --------------------
> 
> This is the start of the stable review cycle for the 5.5.19 release.
> There are 65 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Apr 2020 12:10:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.5.19-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.5.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regression.
Reboot/poweroff work - hang problem fixed.

thanks,
-- Shuah

