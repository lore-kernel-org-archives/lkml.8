Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F462C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6B62072C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581374748;
	bh=3KpOkQmGYqDD7lRY7tRNtaKFptqHWYzUHjjB4/ZXxc0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=vzJs2WEyH5SoGDLzbbsZZ8rv8FWP4A02yFBlAPJzzWx9zVEu5HFz6BCd51XpF8wtx
	 7b0ul76wOy3PSq1jsvB3jsk4/7yHttxyqfqZPKtwtt7AMx787gW2y1fQ9LZLmJ0yp0
	 1d3niXLxSur5pHjhwfGpdETwgK28mEPIV9KgeiGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgBJWpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:45:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:49470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgBJWpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 17:45:46 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A320F2051A;
        Mon, 10 Feb 2020 22:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581374745;
        bh=3KpOkQmGYqDD7lRY7tRNtaKFptqHWYzUHjjB4/ZXxc0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mnYVhiPINukIMkADWCVJQMV87UnFdXH5tZp0WFmSJ3yDsLnrXDjbDdkAzCdB8uG/s
         XqY3dFmkgrxbA8Al74uI5XVFy1ZlwkX7zTssN4k+hU162NGv08t2ObA1N/NU6fuBXP
         5maQFyTTXbJI8gPX08tOrEpMTWP+zm3J/iFoBSZg=
Subject: Re: [PATCH 4.19 000/195] 4.19.103-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200210122305.731206734@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <9f3971b2-80b9-cf7f-74af-7503fd6a608d@kernel.org>
Date:   Mon, 10 Feb 2020 15:45:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/20 5:30 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.103 release.
> There are 195 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Feb 2020 12:18:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.103-rc1.gz
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
