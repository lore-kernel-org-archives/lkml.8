Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49848C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222BB222C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583875940;
	bh=krPSIEZ2F/hA74wColUFSAT1UABB88jixa8bZnvs/xg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=srxyIygkPiVnl80i2Y6VkYvCoGc4xTssuWiCdks+lXz7kH7LjEzlIUyAZWhXenBcR
	 A9qjQ4h2dt3qJ6Hv76ru1LOEL7kmZ9CVLrX3bMGuJkDmes6BD/jM50tCWCMMqJCvMu
	 awMMM4lGjT+od4iE+A3LecE3PGaa781cNH2O8pd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgCJVcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:32:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgCJVcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 17:32:18 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE5B2208C3;
        Tue, 10 Mar 2020 21:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583875938;
        bh=krPSIEZ2F/hA74wColUFSAT1UABB88jixa8bZnvs/xg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SkzhmiOczfo2r195XwaoFxD1kw2DvypQE6k1T3M7KnJNGBfR8BapL3+gqH5tkY1NE
         ikD7psqckH/3rlgUqjwrh/txZDxAQcw4P0JI2UKVXkXhFFITwaLcgg8hHIvPQXZPeS
         pTbg3XgTXYk4IOBuitsgv4hXbCjO8jr0XLpLhvkQ=
Subject: Re: [PATCH 4.9 00/88] 4.9.216-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200310123606.543939933@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <fc4053a7-d156-027c-5b80-45efc4f51559@kernel.org>
Date:   Tue, 10 Mar 2020 15:32:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200310123606.543939933@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/20 6:38 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.216 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 Mar 2020 12:34:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.216-rc1.gz
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
