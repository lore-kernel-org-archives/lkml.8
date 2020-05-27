Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C8DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E83120873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590598266;
	bh=4KrOx9LZA6UgWW6S9RdgSWsnecwKtL62KC4WVxdtl8w=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=VX19xh8JjYiNpfBZ4JCcFmt2ykMiiFwngEFcA4nNELPGnqoX5jgYJPJWIiZCk+PWj
	 AD/QJGvd8tvnk30sBSrepql0O8EUsbn9y/Sw2hPPHjHjDUyYZ3VwJUEnYupsS6Wao2
	 41922PquAaUyW0XydHhDr+n/S/yOvJ6aen16f10g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731005AbgE0QvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:51:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730994AbgE0QvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:51:05 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 893512071A;
        Wed, 27 May 2020 16:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590598265;
        bh=4KrOx9LZA6UgWW6S9RdgSWsnecwKtL62KC4WVxdtl8w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HJSjWRzVmt0kcmDQuGUCSM4bH7obXRUGtenGKuVjD+gvxPLjRyA7hjTJFWlxmW3Tf
         3UxFSvq6O0zDGGEDGUQhvHVImJ0nCc6KCX/sRlO1lzYglz0ZGVa9gHVC2o9mSDTjDA
         URk613IhqwPCmwyIYYezQNH922oRnh7sgMcxoxIQ=
Subject: Re: [PATCH 4.14 00/59] 4.14.182-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200526183907.123822792@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <8935fd6f-7d5d-bd86-d7eb-8f388fb09462@kernel.org>
Date:   Wed, 27 May 2020 10:51:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200526183907.123822792@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/20 12:52 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.182 release.
> There are 59 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 28 May 2020 18:36:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.182-rc1.gz
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
