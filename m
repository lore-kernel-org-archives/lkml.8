Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23D5C35663
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 19:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83898208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 19:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582314719;
	bh=5GVO4BWWYkqAbWt/9/lmxhI4c0yr8DWwAfymhCasL/E=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=mHT51Gtlj/GBGHlMjHILM/Lsqq5m8pw8sFNvpCDpkzUYv00SjocNf4KEpq2/OX7NO
	 U2+MSGH0ADOLMmJQQeOPrIO2wOPENVFGMbBepIP5mftDxzu24f85shvO48ZGcNIozr
	 eJD3jhKFiDMAc85ZODKL7sAKFPQIBCg0cGiRKhmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgBUTv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 14:51:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:43744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgBUTv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 14:51:58 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03644207FD;
        Fri, 21 Feb 2020 19:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582314717;
        bh=5GVO4BWWYkqAbWt/9/lmxhI4c0yr8DWwAfymhCasL/E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=u5uFT3TtqWVZeZk75hoICMkFcUlxZDYOF0LR66Ge5Aup9mhYlwmP6TiBTArhh89Pl
         lw0M3Mg90ss10fdk8tLeqt5BMJtnLZP8IH5f3tL4iXQVucZOjXk629t2v1kvCba9Un
         bWeu8eHJdNph55alathA6wP81CuCGm4qeNfhJD0k=
Subject: Re: [PATCH 5.4 000/344] 5.4.22-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200221072349.335551332@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <96422b04-aed2-cc9b-1fb8-23dded328e59@kernel.org>
Date:   Fri, 21 Feb 2020 12:51:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/20 12:36 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.22 release.
> There are 344 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 23 Feb 2020 07:19:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.22-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on test system. No dmesg regressions.

thanks,
-- Shuah
