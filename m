Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFB0C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 23:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 128832137B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 23:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588461429;
	bh=RjxqBy1GZPpSKMM6F8Pnu5u7xBZt++QZn4Zlpj0GsEs=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=AvE8nN67xFCkMmFxNWUHIhWY2JFqQb60K/2fLgj0tBZowC2BWEwjKET+f+xjMEo85
	 rXmqlfi4o+pUkWZIW/gi/l0T4lrQ8tQ660FhfjK17wtnyBMdQY+lwZ4e92Rp8ZyDXq
	 HTfBAtK+Hukms8qKIqRe/9fmW8kEIUaqgu0L60ok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgEBXRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 19:17:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgEBXRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 19:17:07 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCA5820787;
        Sat,  2 May 2020 23:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588461427;
        bh=RjxqBy1GZPpSKMM6F8Pnu5u7xBZt++QZn4Zlpj0GsEs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JAkNjbNUOXQF8xqaEPNJEiSe7bQdoCnqjfyel4kfespOfRlXeZpsx8c5HEmQ4yNg7
         zatsN+KyNC2ZZG5IjIX9d1u2Zld5G/YDieaaeKKtVhHAFZFE0rFWLrgJLSKgRLbh9F
         aJ81VW2P7NBOFtsnlFkszM6XW2N1qSiPn7XYCXZY=
Subject: Re: [PATCH 4.19 00/46] 4.19.120-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200501131457.023036302@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <10ef5da2-3eb3-6974-881a-a8b27e7e2be2@kernel.org>
Date:   Sat, 2 May 2020 17:17:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501131457.023036302@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/20 7:22 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.120 release.
> There are 46 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 03 May 2020 13:12:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.120-rc1.gz
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

