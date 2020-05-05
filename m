Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8AFC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F352920746
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588693839;
	bh=sFSOu0wrBVEu3vNwrjFbX/f117ESQRiaC7SFXRmxR6g=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=j6zOfziMZCOXzfBWjMs6yFF9P/3Oyfzmfhgw1MlDl3PktV0kvbJYqK6lsTAgvhDN4
	 e04Jaf00j5nuPkLG+sxP9YDLBIbPpjLgwM5HAGANXvRXd5YldbHj/ljThkr8VdxpVQ
	 vN1JSmkNSo94Yo3iI2EzNWFa+mLIMj5nUhEy6VII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbgEEPui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:50:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729516AbgEEPuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:50:37 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 215242073B;
        Tue,  5 May 2020 15:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588693837;
        bh=sFSOu0wrBVEu3vNwrjFbX/f117ESQRiaC7SFXRmxR6g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UbjjyVXlxFsuTq0bEF2oVRALRsFdk4BkOqw5wylQNCZptdvZwsgPO/3uo5V7IqCZu
         SboEQPsgIdZO7zrunK+8EUV+cXO4+Gn+V5gc1FFhYqOdqsrd0ZXH/p4qq7vCy17DIR
         nZQlto8k91GBW9Ye0RSv+HDVvK3v6RZp+4V0NmTU=
Subject: Re: [PATCH 4.19 00/37] 4.19.121-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200504165448.264746645@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <0cf33fe3-2ce5-7174-d899-f3d58b51326a@kernel.org>
Date:   Tue, 5 May 2020 09:50:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504165448.264746645@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/20 11:57 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.121 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 May 2020 16:52:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.121-rc1.gz
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

