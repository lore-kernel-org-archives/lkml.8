Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1535C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 21:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8848721569
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 21:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579902509;
	bh=7Yjq+vDxOYsrQQm3Kcl0cS81mS27ugwgb7t3BK6sV7o=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Mb5VUrXYd4aWZVXvEy/tUxijzwD2DgecgEY7Uw3gY2ru90Exk4SS6O07f/EGPjYdb
	 2MqUT6U//RQa8Kn7VKkEGaq/240ofz4ktBrX3LFMiLQ+VLT4jwk5AD72hMCIhsEYUy
	 3pjfBGVKtutVahol9v9JxXRWEUdheVseicN9xtJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgAXVs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 16:48:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:58866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgAXVs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 16:48:28 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F20D2077C;
        Fri, 24 Jan 2020 21:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579902508;
        bh=7Yjq+vDxOYsrQQm3Kcl0cS81mS27ugwgb7t3BK6sV7o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=0aAFfrhgbFUEYE/irU3nV2FO8uQJFPxin2DB1MC02mqduPw1AHt/gHrv9qZL0LtOM
         /9bd3wmUyxatuS6/sU/t5VFKVoGPE2KE/AT/PQA0MagYIU57nv/q2OgUOcxF4mCKs/
         ox9EiR9ph4Nha2UtrQXrIwZQ2uAVy/wXao7Nk6xE=
Subject: Re: [PATCH 4.14 000/343] 4.14.168-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200124092919.490687572@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <eea5b549-9db8-726b-25b8-df92ad3ea25b@kernel.org>
Date:   Fri, 24 Jan 2020 14:48:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/20 2:26 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.168 release.
> There are 343 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 26 Jan 2020 09:26:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.168-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
