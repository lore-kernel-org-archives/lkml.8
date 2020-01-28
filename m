Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8403C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 23:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A0E2465B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 23:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580252584;
	bh=IeMfbkutZAogA7eAlwxihfRzKsK7Qwov9+XSngb0Wfc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=0ddFRA9ho24k1GW265afIGiYEE12YcNyx8v4HNzxxCkDuKd9H8szyWIJe7OFeENUy
	 jQwbtPdIHwVia5NhKHl1H4+bJu2+FuTykG4DXb0DTQhk58/gCBT5xxINY57YpkCPZq
	 kuhhN6LIcxL3SC42FWdmhSSe+ZQoOctT4qoJ01xw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgA1XDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 18:03:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:43106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgA1XDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 18:03:03 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5AD62087F;
        Tue, 28 Jan 2020 23:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580252583;
        bh=IeMfbkutZAogA7eAlwxihfRzKsK7Qwov9+XSngb0Wfc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dPWaxQ4MAK2FN80Yv5KDDt7fcPbFaFMV2wFZdw/Q294b+oOdD/juiCgRI9eFEqqss
         /O5tMmeDCiCS9TnG7vR4lhAgOsejIfSXV/3YrCfe/CEimggkJvluTn+vC9SAPF7eJw
         Td3xPwsxGafSyJ634a9yWEASQ2Lg2eqmbocfYPgw=
Subject: Re: [PATCH 4.19 00/92] 4.19.100-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200128135809.344954797@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <17978d4b-8445-ec38-ebd0-1d3d4daade30@kernel.org>
Date:   Tue, 28 Jan 2020 16:03:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200128135809.344954797@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/20 7:07 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.100 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 30 Jan 2020 13:57:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.100-rc1.gz
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
