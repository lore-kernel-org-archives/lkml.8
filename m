Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50729C55182
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 335F620724
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587499457;
	bh=ijsxzxLtyR1+w8+1bP8Fp637enB8g9lYXr9wOsUw4AI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=IdNxaa2iEr4k9qL/9yPC1RMvZL6C7MBlOFBC9MibHvfTNq8f/zrQ2NNFs7hMDUC7i
	 LjCvsrg7PXz4Caih/MX1M0r5PTOYpmTNq6LtxXpvoHvND3bTEZOc8MyXOJsH1b2NkE
	 /Ft5BGuxPQPmOBu4DTy1Jgb3bLePU263IVS/lAR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgDUUEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:04:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgDUUEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 16:04:16 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A63C206B8;
        Tue, 21 Apr 2020 20:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587499455;
        bh=ijsxzxLtyR1+w8+1bP8Fp637enB8g9lYXr9wOsUw4AI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PkOMYxVo/pe9fJmGqjeSpxdSW0c205O2wCrdYxW5Z3nK0AoMSUhHztjY+zjll9XvF
         u1EGc7gdqEwamlXe3A073MXfLcEynqZXDeIq7Lu2gKFrhtIrVy8P0O0z9RWvgDDlZy
         10PYkRHvN/laN8w+VUAF/8tOFeMJtL6fyYwOgfME=
Subject: Re: [PATCH 4.19 00/40] 4.19.117-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200420121444.178150063@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <b53be106-95a4-4ada-c8e8-22f149dc16e5@kernel.org>
Date:   Tue, 21 Apr 2020 14:04:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200420121444.178150063@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/20 6:39 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.117 release.
> There are 40 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Apr 2020 12:10:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.117-rc1.gz
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

